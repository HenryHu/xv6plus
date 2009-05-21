9350 #include "types.h"
9351 #include "x86.h"
9352 #include "pci.h"
9353 #include "pcireg.h"
9354 #include "defs.h"
9355 #include "e100.h"
9356 #include "proc.h"
9357 #include "picirq.h"
9358 #include "traps.h"
9359 #include "lwip/include/ipv4/lwip/ip_addr.h"
9360 #include "lwip/include/ipv4/lwip/ip.h"
9361 #include "lwip/include/lwip/netif.h"
9362 #include "lwip/include/netif/ethernetif.h"
9363 #include "thread.h"
9364 
9365 static int dev_count = 0;
9366 
9367 typedef struct e100_devinfo {
9368     int irq;
9369     uint32_t regbase[6], regsize[6];
9370     uint32_t iobase;
9371     struct netif netif;
9372     struct spinlock culock;
9373     uint32_t cubase;
9374     uint32_t cusize;
9375 //    uint32_t cuhead;
9376 //    uint32_t cuend;
9377     uint32_t cucount;
9378     int cufirst;
9379     int cuidle;
9380     command_block *cu_last_pkt;
9381     command_block *cu_next_pkt;
9382     struct spinlock rulock;
9383     uint32_t rubase;
9384     uint32_t rusize;
9385     uint32_t rucount;
9386     rf_desc *ru_first;
9387     rf_desc *ru_last;
9388     rf_desc *ru_prev;
9389     int ru_full;
9390     struct spinlock rxlock;
9391 } e100_dev;
9392 
9393 static e100_dev e100_devs[E100_MAX_DEVS];
9394 int e100_reset(e100_dev *dev);
9395 scb_status_word e100_print_state(e100_dev *dev);
9396 void e100_put_state(e100_dev *dev, scb_status_word stat);
9397 uint8_t e100_read_scb_command(e100_dev *dev);
9398 void e100_cu_command(e100_dev *dev, int command, void *cmd_addr);
9399 void e100_ru_command(e100_dev *dev, int command, void *cmd_addr);
9400 void e100_intr(struct trapframe *tf);
9401 void e100_ru_start(e100_dev *dev);
9402 void ring_printinfo(e100_dev *dev);
9403 void ring_init(e100_dev *dev);
9404 int e100_receive_dev(e100_dev *dev, void *buffer, int len);
9405 void e100_rx_thread(void *arg);
9406 
9407 char *cu_state_name[];
9408 char *ru_state_name[];
9409 
9410 int
9411 ether_e100_attach(struct pci_func *pcif)
9412 {
9413     cprintf("PCI: %02x:%02x.%d: "
9414             "Intel 82559ER Fast Ethernet PCI Controller %04x:%04x\n",
9415 		pcif->bus->busno, pcif->dev, pcif->func,
9416         PCI_VENDOR(pcif->dev_id), PCI_PRODUCT(pcif->dev_id));
9417     dev_count++;
9418     int index = dev_count-1;
9419     e100_dev *dev = &e100_devs[index];
9420 
9421     dev->cubase = (uint32_t)kalloc(E100_CU_RING_SIZE * PAGE); // 128K
9422     if (!dev->cubase)
9423     {
9424         cprintf("   Failed to allocate CU ring\n");
9425         dev_count--;
9426         return -1;
9427     }
9428     dev->rubase = (uint32_t)kalloc(E100_RU_RING_SIZE * PAGE); // 128K
9429     if (!dev->rubase)
9430     {
9431         cprintf("   Failed to allocate RU ring\n");
9432         dev_count--;
9433         return -1;
9434     }
9435     dev->cusize = E100_CU_RING_SIZE * PAGE;
9436     dev->rusize = E100_RU_RING_SIZE * PAGE;
9437     ring_init(dev);
9438 //    dev->cuhead = 0;
9439 //    dev->cuend = 0;
9440 
9441     pci_func_enable(pcif);
9442     initlock(&dev->culock, "e100 CU lock");
9443     initlock(&dev->rulock, "e100 RU lock");
9444     initlock(&dev->rxlock, "e100 RX lock");
9445     dev->irq = pcif->irq_line;
9446     int i;
9447     for (i=0; i<6; i++)
9448     {
9449         dev->regbase[i] = pcif->reg_base[i];
9450         dev->regsize[i] = pcif->reg_size[i];
9451         if (dev->regsize[i] == E100_IOPORT_SIZE)
9452             dev->iobase = dev->regbase[i];
9453     }
9454     e100_reset(dev);
9455     dev->cufirst = 1;
9456     dev->cuidle = 1;
9457     e100_print_state(dev);
9458     struct ip_addr ipaddr;
9459     IP4_ADDR(&ipaddr, 192, 168, 1, 1);
9460     struct ip_addr netmask;
9461     IP4_ADDR(&netmask, 255, 255, 255, 0);
9462     struct ip_addr gw;
9463     IP4_ADDR(&gw, 192, 168, 1, 2);
9464     netif_add(&dev->netif, &ipaddr, &netmask, &gw, 0, ethernetif_init, ip_input);
9465     reg_irq_handler(dev->irq, e100_intr);
9466     pic_enable(dev->irq);
9467     ioapic_enable(dev->irq, ncpu-1);
9468     kproc_start(e100_rx_thread, dev, 0, 0, "[e100 rx thread]");
9469     e100_ru_start(dev);
9470     return 1;
9471 }
9472 
9473 static void
9474 delay(int n)
9475 {
9476     volatile int i;
9477     int j;
9478     for (j=0; j<n; j++)
9479     {
9480     for (i=0; i<1000; i++)
9481         ;
9482     }
9483 }
9484 
9485 int
9486 e100_reset(e100_dev *dev)
9487 {
9488     outl(dev->iobase + SCB_PORT, PORT_SOFT_RESET);
9489     delay(10);
9490     scb_command_word cmd;
9491     cmd.word = 0;
9492     cmd.cmd.cu_command = CUC_DUMP_RESET;
9493     outw(dev->iobase + SCB_COMMAND, cmd.word);
9494     return 0;
9495 }
9496 
9497 
9498 
9499 
9500 scb_status_word
9501 e100_get_state(e100_dev *dev)
9502 {
9503     scb_status_word st;
9504     st.word = inw(dev->iobase + SCB_STATUS);
9505     return st;
9506 }
9507 
9508 void
9509 e100_put_state(e100_dev *dev, scb_status_word stat)
9510 {
9511     outw(dev->iobase + SCB_STATUS, stat.word);
9512 }
9513 
9514 scb_status_word
9515 e100_print_state(e100_dev *dev)
9516 {
9517     scb_status_word state = e100_get_state(dev);
9518     cprintf("   RU Status: %s\n", ru_state_name[state.status.rus]);
9519     cprintf("   CU Status: %s\n", cu_state_name[state.status.cus]);
9520 
9521     struct scb_status_word stat = state.status;
9522     if (stat.cx) cprintf("   CU executed\n");
9523     if (stat.fr)
9524         cprintf("   RU received\n");
9525     if (stat.cna)
9526         cprintf("   CU state change\n");
9527     if (stat.rnr)
9528         cprintf("   RU not ready\n");
9529     if (stat.mdi)
9530         cprintf("   MDI operation completed\n");
9531     if (stat.swi)
9532         cprintf("   Software Interrupt\n");
9533     if (stat.fcp)
9534         cprintf("   Flow Control Pause\n");
9535 
9536     return state;
9537 }
9538 
9539 char *cu_state_name[4] = {
9540     "Idle",
9541     "Suspended",
9542     "LPQ Active",
9543     "HQP Active",
9544 };
9545 
9546 
9547 
9548 
9549 
9550 char *ru_state_name[16] = {
9551     "Idle",
9552     "Suspended",
9553     "No resources",
9554     "Reserved",
9555     "Ready",
9556     "Reserved",
9557     "Reserved",
9558     "Reserved",
9559     "Reserved",
9560     "Reserved",
9561     "Reserved",
9562     "Reserved",
9563     "Reserved",
9564     "Reserved",
9565     "Reserved",
9566     "Reserved",
9567 };
9568 
9569 uint8_t
9570 e100_read_scb_command(e100_dev *dev)
9571 {
9572     return inb(dev->iobase + SCB_COMMAND + 1);
9573 }
9574 
9575 void
9576 e100_set_gp(e100_dev *dev, void *addr)
9577 {
9578     outl(dev->iobase + SCB_GENPTR, (uint32_t)addr);
9579 }
9580 
9581 void
9582 e100_cu_command(e100_dev *dev, int command, void *cmd_addr)
9583 {
9584     scb_command_word cmd;
9585     cmd.word = 0;
9586     cmd.cmd.cu_command = command;
9587     e100_set_gp(dev, cmd_addr);
9588     outw(dev->iobase + SCB_COMMAND, cmd.word);
9589     while (e100_read_scb_command(dev)) ;
9590 }
9591 
9592 
9593 
9594 
9595 
9596 
9597 
9598 
9599 
9600 void
9601 e100_ru_command(e100_dev *dev, int command, void *cmd_addr)
9602 {
9603     scb_command_word cmd;
9604     cmd.word = 0;
9605     cmd.cmd.ru_command = command;
9606     e100_set_gp(dev, cmd_addr);
9607     outw(dev->iobase + SCB_COMMAND, cmd.word);
9608     while (e100_read_scb_command(dev)) ;
9609 }
9610 
9611 void
9612 e100_rx_thread(void *arg)
9613 {
9614     e100_dev *dev = arg;
9615     acquire(&dev->rxlock);
9616     while(1)
9617     {
9618         sleep(&dev->rxlock, &dev->rxlock);
9619         while (dev->ru_last->eof)
9620         {
9621             ethernetif_input(&dev->netif);
9622             dev->ru_last = (void*)dev->ru_last->head.link;
9623         }
9624     }
9625     release(&dev->rxlock);
9626 }
9627 
9628 void
9629 e100_intr(struct trapframe *tf)
9630 {
9631 //    cprintf("e100_intr\n");
9632     int i;
9633     int index = -1;
9634     for (i=0; i< dev_count; i++)
9635     {
9636         if (tf->trapno == IRQ_OFFSET + e100_devs[i].irq)
9637         {
9638             index = i;
9639             break;
9640         }
9641     }
9642     if (index == -1)
9643     {
9644         cprintf("e100_intr: can't find corresponding device\n");
9645         return;
9646     }
9647     e100_dev *dev = &e100_devs[index];
9648 //    e100_print_state(dev);
9649     scb_status_word state = e100_get_state(dev);
9650     struct scb_status_word stat = state.status;
9651     state.word |= 0xff00;
9652     e100_put_state(dev, state);
9653 
9654     if (stat.cx)
9655     {
9656 //        cprintf("   CU executed\n");
9657     }
9658     if (stat.fr)
9659     {
9660         if (!dev->ru_first)
9661         {
9662             dev->ru_first = dev->ru_last;
9663             wakeup(&dev->ru_first);
9664         }
9665         wakeup(&dev->rxlock);
9666 /*        while (dev->ru_last->eof)
9667         {
9668             ethernetif_input(&dev->netif);
9669             dev->ru_last = (void*)dev->ru_last->head.link;
9670         }*/
9671     }
9672     if (stat.cna)
9673     {
9674 /*        if (dev->cu_next_pkt != 0)
9675         {
9676             cprintf("   finished 0x%08x\n", dev->cu_next_pkt);
9677             if (dev->cu_next_pkt->link != 0)
9678             {
9679                 cprintf("   starting next packet: "
9680                         "0x%08x\n", dev->cu_next_pkt->link);
9681                 e100_cu_command(dev, CUC_START,
9682                         (void*)dev->cu_next_pkt->link);
9683                 dev->cuhead = dev->cu_next_pkt->link - dev->cubase;
9684                 dev->cu_next_pkt = (command_block *)dev->cu_next_pkt->link;
9685             }
9686             else
9687             {
9688                 dev->cuhead = dev->cuend;
9689                 dev->cu_last_pkt = 0;
9690                 dev->cu_next_pkt = 0;
9691             }
9692             ring_printinfo(dev);
9693         }*/
9694         if (dev->cu_last_pkt)
9695         {
9696             if (dev->cu_last_pkt->c)
9697             {
9698                 dev->cuidle = 1;
9699 //                dev->cuhead = dev->cuend;
9700                 dev->cu_next_pkt = 0;
9701 //                dev->cu_last_pkt = 0;
9702             } else {
9703                 dev->cuidle = 0;
9704                 while (dev->cu_next_pkt->c)
9705                 {
9706                     if (!dev->cu_next_pkt->ok)
9707                         cprintf("send error 0x%08x\n", dev->cu_next_pkt);
9708                     dev->cu_next_pkt = (void*)dev->cu_next_pkt->link;
9709                 }
9710                 e100_cu_command(dev, CUC_RESUME, 0);
9711 //                dev->cuhead = (uint32_t)dev->cu_next_pkt - dev->cubase;
9712             }
9713         }
9714 //        ring_printinfo(dev);
9715     }
9716     if (stat.rnr)
9717     {
9718         cprintf("e100: RU overrun!\n");
9719         dev->ru_full = 1;
9720     }
9721     if (stat.mdi)
9722         cprintf("   MDI operation completed\n");
9723     if (stat.swi)
9724         cprintf("   Software Interrupt\n");
9725     if (stat.fcp)
9726         cprintf("   Flow Control Pause\n");
9727 
9728 }
9729 
9730 void
9731 ring_printinfo(e100_dev *dev)
9732 {
9733     cprintf("Ring Info:   ");
9734     cprintf("head: 0x%08x  ", dev->cu_next_pkt);
9735     cprintf("end:  0x%08x\n", dev->cu_last_pkt);
9736 }
9737 
9738 
9739 
9740 
9741 
9742 
9743 
9744 
9745 
9746 
9747 
9748 
9749 
9750 void *
9751 ring_alloc(e100_dev *dev, uint32_t len)
9752 {
9753     if (len > E100_CB_SIZE)
9754         return (void*) 0;
9755     if (dev->cu_next_pkt)
9756     {
9757         if ((void*)dev->cu_last_pkt->link == dev->cu_next_pkt)
9758             return (void*) 0;
9759         return (void*)dev->cu_last_pkt->link;
9760     } else {
9761         return (void*)dev->cu_last_pkt->link;
9762     }
9763 /*
9764     len = E100_CB_SIZE;
9765     if (dev->cuhead <= dev->cuend)
9766     {
9767         uint32_t newend = dev->cuend + len;
9768         uint32_t oldend = dev->cuend;
9769         if (newend >= dev->cusize)
9770         {
9771             newend = len; // Start from base
9772             if (newend < dev->cuhead)
9773             {
9774                 dev->cuend = newend;
9775                 return (void*)dev->cubase;
9776             }
9777             else
9778                 return (void*)0;
9779         }
9780         else
9781         {
9782             dev->cuend = newend;
9783             return (void*)(oldend + dev->cubase);
9784         }
9785     }
9786     else
9787     {
9788         uint32_t newend = dev->cuend + len;
9789         uint32_t oldend = dev->cuend;
9790         if (newend < dev->cuhead)
9791         {
9792             dev->cuend = newend;
9793             return (void*)(oldend + dev->cubase);
9794         }
9795         else
9796             return (void*)0;
9797     }*/
9798 }
9799 
9800 int
9801 e100_send_dev(e100_dev *dev, void *buffer, uint32_t len)
9802 {
9803 //    cprintf("e100_send_dev\n");
9804     if (len > TBD_DATA_LIMIT)
9805         return -1; // ETOOBIG
9806     acquire(&dev->culock);
9807     op_transmit_cmd *start =
9808         ring_alloc(dev, sizeof(op_transmit_cmd) + len);
9809 //    cprintf("   start: 0x%08x\n", start);
9810     if (!start)
9811     {
9812         release(&dev->culock);
9813         return -1; // No space in buffer
9814     }
9815     op_transmit_cmd_cmd cmd_word;
9816     cmd_word.word = 0;
9817     cmd_word.cmd = OP_TRANSMIT;
9818 //    cmd_word.el = 0;
9819     cmd_word.cid = 0xe;
9820     cmd_word.i = 1;
9821     cmd_word.s = 1;
9822     if (!dev->cuidle)
9823         dev->cu_last_pkt->s = 0;
9824     start->base_cmd.cmd_word = cmd_word.word;
9825     start->base_cmd.status_word = 0;
9826 //    start->base_cmd.link = 0;
9827     start->tbd_addr = 0xffffffff;
9828     start->byte_count = len;
9829     start->eof = 1;
9830     start->trans_thres = 0xE0;
9831     start->tbd_num = 0;
9832     memcpy((void*)(start+1), buffer, len);
9833 //    e100_print_state(dev);
9834 //    if (e100_get_state(dev).status.cus == CUS_IDLE)
9835 //    if (dev->cu_next_pkt == 0)
9836 //    This test would fail in real i82559er
9837 //    But it passed in qemu
9838 /*    if ((!dev->cufirst) && (!dev->cuidle))
9839         if (start->base_cmd.link == dev->cu_next_pkt)
9840             e100_cu_command(dev, CUC_RESUME, start);*/
9841     if (dev->cufirst)
9842     {
9843         dev->cufirst = 0;
9844         dev->cu_next_pkt = &start->base_cmd;
9845         e100_cu_command(dev, CUC_START, start);
9846     }
9847     else if (dev->cuidle)
9848     {
9849         dev->cuidle = 0;
9850         dev->cu_next_pkt = &start->base_cmd;
9851         e100_cu_command(dev, CUC_RESUME, start); // the GENPTR is nonsense
9852     }
9853     dev->cu_last_pkt = &start->base_cmd;
9854     release(&dev->culock);
9855     return len;
9856 }
9857 
9858 int
9859 e100_send(void *buffer, uint32_t len)
9860 {
9861     if (dev_count == 0)
9862         return -2; // Device not found
9863     return e100_send_dev(&e100_devs[0], buffer,len);
9864 }
9865 
9866 void
9867 ring_init(e100_dev *dev)
9868 {
9869     int i;
9870     dev->cucount = dev->cusize / E100_CB_SIZE;
9871     dev->cu_next_pkt = 0;
9872     for (i=0; i<dev->cucount ; i++)
9873     {
9874         command_block *cmd = (void*)(dev->cubase + i * E100_CB_SIZE);
9875         cmd->cmd_word = 0;
9876         cmd->status_word = 0;
9877         cmd->c = 1;
9878         cmd->el = 1;
9879         if (i == dev->cucount - 1)
9880         {
9881             cmd->link = (void*)dev->cubase;
9882             dev->cu_last_pkt = cmd;
9883         }
9884         else
9885         {
9886             cmd->link = (void*)((uint32_t)cmd + E100_CB_SIZE);
9887         }
9888 //        cprintf("CB %d: start 0x%08x next 0x%08x\n", i, cmd, cmd->link);
9889     }
9890     dev->rucount = dev->rusize / E100_RFD_SIZE;
9891     for (i=0; i<dev->rucount; i++)
9892     {
9893         rf_desc *rfd = (void*)(dev->rubase + i * E100_RFD_SIZE);
9894         rfd->head.cmd_word = 0;
9895         rfd->head.status_word = 0;
9896         rfd->size = E100_RFD_SIZE - sizeof(rf_desc);
9897         if (rfd->size & 1)
9898             rfd->size--;
9899         rfd->eof = 0;
9900         rfd->f = 0;
9901         if (i == dev->rucount - 1)
9902         {
9903             rfd->head.link = (void*)dev->rubase;
9904             rfd->head.el = 1;
9905             dev->ru_prev = rfd;
9906         }
9907         else
9908         {
9909             rfd->head.link = (void*)((uint32_t)rfd + E100_RFD_SIZE);
9910         }
9911     }
9912     dev->ru_first = 0;
9913     dev->ru_last = (void*)dev->rubase;
9914 
9915 }
9916 
9917 void
9918 e100_ru_start(e100_dev *dev)
9919 {
9920     dev->ru_full = 0;
9921     e100_ru_command(dev, RUC_START, (void*)dev->rubase);
9922 }
9923 
9924 int
9925 e100_receive(void *buffer, uint32_t len)
9926 {
9927     if (dev_count == 0)
9928         return -2; // Device not found
9929     return e100_receive_dev(&e100_devs[0], buffer, len);
9930 }
9931 
9932 int
9933 e100_receive_dev(e100_dev *dev, void *buffer, int len)
9934 {
9935     int count;
9936 //    cprintf("e100_receive_dev\n");
9937     acquire(&dev->rulock);
9938     while (dev->ru_first == 0)
9939         sleep(&dev->rulock, &dev->rulock);
9940     if (len < dev->ru_first->count)
9941     {
9942         release(&dev->rulock);
9943         return -1; // ETOOBIG
9944     }
9945     memcpy(buffer, dev->ru_first + 1, dev->ru_first->count);
9946 //    cprintf("received %d bytes into 0x%08x\n", dev->ru_first->count, buffer);
9947     count = dev->ru_first->count;
9948     dev->ru_first->eof = 0;
9949     dev->ru_first->f = 0;
9950     dev->ru_prev->head.el = 0;
9951     dev->ru_first->head.el = 1;
9952     dev->ru_prev = dev->ru_first;
9953     dev->ru_first = (void*)dev->ru_first->head.link;
9954     if (dev->ru_full)
9955     {
9956         // RU full, in No Resource state
9957         dev->ru_full = 0;
9958         e100_ru_command(dev, RUC_START, dev->ru_prev);
9959     }
9960     if (dev->ru_first == dev->ru_last)
9961         dev->ru_first = 0;
9962     release(&dev->rulock);
9963     return count;
9964 }
9965 
9966 
9967 
9968 
9969 
9970 
9971 
9972 
9973 
9974 
9975 
9976 
9977 
9978 
9979 
9980 
9981 
9982 
9983 
9984 
9985 
9986 
9987 
9988 
9989 
9990 
9991 
9992 
9993 
9994 
9995 
9996 
9997 
9998 
9999 
