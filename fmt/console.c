7350 // Console input and output.
7351 // Input is from the keyboard only.
7352 // Output is written to the screen and the printer port.
7353 
7354 #include "types.h"
7355 #include "defs.h"
7356 #include "param.h"
7357 #include "traps.h"
7358 #include "spinlock.h"
7359 #include "dev.h"
7360 #include "mmu.h"
7361 #include "proc.h"
7362 #include "x86.h"
7363 #include "thread.h"
7364 #include "lwip/sockets.h"
7365 
7366 #define CRTPORT 0x3d4
7367 #define LPTPORT 0x378
7368 #define BACKSPACE 0x100
7369 
7370 static ushort *crt = (ushort*)0xb8000;  // CGA memory
7371 
7372 static struct spinlock console_lock;
7373 int panicked = 0;
7374 int use_console_lock = 0;
7375 
7376 // Copy console output to parallel port, which you can tell
7377 // .bochsrc to copy to the stdout:
7378 //   parport1: enabled=1, file="/dev/stdout"
7379 static void
7380 lpt_putc(int c)
7381 {
7382   int i;
7383 
7384   for(i = 0; !(inb(LPTPORT+1) & 0x80) && i < 12800; i++)
7385     ;
7386   if(c == BACKSPACE)
7387     c = '\b';
7388   outb(LPTPORT+0, c);
7389   outb(LPTPORT+2, 0x08|0x04|0x01);
7390   outb(LPTPORT+2, 0x08);
7391 }
7392 
7393 
7394 
7395 
7396 
7397 
7398 
7399 
7400 static void
7401 cga_putc(int c)
7402 {
7403   int pos;
7404 
7405   // Cursor position: col + 80*row.
7406   outb(CRTPORT, 14);
7407   pos = inb(CRTPORT+1) << 8;
7408   outb(CRTPORT, 15);
7409   pos |= inb(CRTPORT+1);
7410 
7411   if(c == '\n')
7412     pos += 80 - pos%80;
7413   else if(c == BACKSPACE){
7414     if(pos > 0)
7415       crt[--pos] = ' ' | 0x0700;
7416   } else
7417     crt[pos++] = (c&0xff) | 0x0700;  // black on white
7418 
7419   if((pos/80) >= 24){  // Scroll up.
7420     memmove(crt, crt+80, sizeof(crt[0])*23*80);
7421     pos -= 80;
7422     memset(crt + pos, 0, sizeof(crt[0])*80);
7423   }
7424 
7425   outb(CRTPORT, 14);
7426   outb(CRTPORT+1, pos>>8);
7427   outb(CRTPORT, 15);
7428   outb(CRTPORT+1, pos);
7429   crt[pos] = ' ' | 0x0700;
7430 }
7431 
7432 void
7433 cons_putc(int c)
7434 {
7435   if(panicked){
7436     cli();
7437     for(;;)
7438       ;
7439   }
7440 
7441   lpt_putc(c);
7442   cga_putc(c);
7443 }
7444 
7445 
7446 
7447 
7448 
7449 
7450 void
7451 printintlen(int xx, int base, int sgn, int len, char fill)
7452 {
7453   static char digits[] = "0123456789ABCDEF";
7454   char buf[16];
7455   int i = 0, neg = 0, j = 0;
7456   uint x;
7457 
7458   if(sgn && xx < 0){
7459     neg = 1;
7460     x = 0 - xx;
7461   } else {
7462     x = xx;
7463   }
7464 
7465   do{
7466     buf[i++] = digits[x % base];
7467   }while((x /= base) != 0);
7468   if(neg)
7469     buf[i++] = '-';
7470 
7471   if (i < len)
7472   {
7473       if (neg)
7474       {
7475           cons_putc('-');
7476           i--;
7477       }
7478       j = len - i;
7479       while (j-- > 0)
7480           cons_putc(fill);
7481   }
7482   while(--i >= 0)
7483     cons_putc(buf[i]);
7484 }
7485 
7486 
7487 
7488 
7489 
7490 
7491 
7492 
7493 
7494 
7495 
7496 
7497 
7498 
7499 
7500 void
7501 printint(int xx, int base, int sgn)
7502 {
7503   static char digits[] = "0123456789ABCDEF";
7504   char buf[16];
7505   int i = 0, neg = 0;
7506   uint x;
7507 
7508   if(sgn && xx < 0){
7509     neg = 1;
7510     x = 0 - xx;
7511   } else {
7512     x = xx;
7513   }
7514 
7515   do{
7516     buf[i++] = digits[x % base];
7517   }while((x /= base) != 0);
7518   if(neg)
7519     buf[i++] = '-';
7520 
7521   while(--i >= 0)
7522     cons_putc(buf[i]);
7523 }
7524 
7525 enum fmt_types {
7526     CHAR,
7527     SHORT,
7528     LONG,
7529     LONGLONG,
7530 };
7531 
7532 // Print to the console. only understands %d, %x, %p, %s.
7533 void
7534 cprintf(char *fmt, ...)
7535 {
7536   int i, c, state, locking, len = 0;
7537   uint *argp;
7538   char *s, last, fill;
7539   enum fmt_types type;
7540 
7541   locking = use_console_lock;
7542   if(locking)
7543     acquire(&console_lock);
7544 
7545   argp = (uint*)(void*)&fmt + 1;
7546   state = 0;
7547   c = 0;
7548   fill = ' ';
7549   len = -1;
7550   for(i = 0; fmt[i]; i++){
7551     last = c;
7552     c = fmt[i] & 0xff;
7553     switch(state){
7554     case 0:
7555       if(c == '%')
7556         state = '%';
7557       else
7558         cons_putc(c);
7559       break;
7560 
7561     case '%':
7562       switch(c){
7563       case 'l':
7564         if (last == 'l')
7565         {
7566             // ll: long long
7567             type = LONGLONG;
7568         } else {
7569             type = LONG;
7570         }
7571         break;
7572       case 'h':
7573         if (last == 'h')
7574         {
7575             // hh: char
7576             type = CHAR;
7577         } else {
7578             type = SHORT;
7579         }
7580         break;
7581       case 'c':
7582         cons_putc(*argp++);
7583         len = -1;
7584         state = 0;
7585         break;
7586       case 'd':
7587       case 'i':
7588         if (len != -1)
7589             printintlen(*argp++, 10, 1, len, fill);
7590         else
7591             printint(*argp++, 10, 1);
7592         fill = ' ';
7593         len = -1;
7594         state = 0;
7595         break;
7596       case 'u':
7597         if (len != -1)
7598             printintlen(*argp++, 10, 0, len, fill);
7599         else
7600             printint(*argp++, 10, 0);
7601         fill = ' ';
7602         len = -1;
7603         state = 0;
7604         break;
7605       case 'x':
7606       case 'p':
7607         if (len != -1)
7608             printintlen(*argp++, 16, 0, len, fill);
7609         else
7610             printint(*argp++, 16, 0);
7611         fill = ' ';
7612         len = -1;
7613         state = 0;
7614         break;
7615       case 's':
7616         s = (char*)*argp++;
7617         if(s == 0)
7618           s = "(null)";
7619         for(; *s; s++)
7620           cons_putc(*s);
7621         len = -1;
7622         state = 0;
7623         break;
7624       case '%':
7625         cons_putc('%');
7626         state = 0;
7627         break;
7628       case '0':
7629         if (len == -1)
7630         {
7631             len = 0;
7632             fill = '0';
7633         } else {
7634             len = len * 10;
7635         }
7636         break;
7637       case '1':
7638       case '2':
7639       case '3':
7640       case '4':
7641       case '5':
7642       case '6':
7643       case '7':
7644       case '8':
7645       case '9':
7646         if (len == -1)
7647             len = c - '0';
7648         else
7649             len = len * 10 + c - '0';
7650         break;
7651       default:
7652         // Print unknown % sequence to draw attention.
7653         cons_putc('%');
7654         cons_putc(c);
7655         break;
7656       }
7657       break;
7658     }
7659   }
7660 
7661   if(locking)
7662     release(&console_lock);
7663 }
7664 
7665 int
7666 console_write(struct inode *ip, char *buf, int n)
7667 {
7668   int i;
7669 
7670   iunlock(ip);
7671   acquire(&console_lock);
7672   for(i = 0; i < n; i++)
7673     cons_putc(buf[i] & 0xff);
7674   release(&console_lock);
7675   ilock(ip);
7676 
7677   return n;
7678 }
7679 
7680 #define INPUT_BUF 128
7681 struct {
7682   struct spinlock lock;
7683   char buf[INPUT_BUF];
7684   int r;  // Read index
7685   int w;  // Write index
7686   int e;  // Edit index
7687 } input;
7688 
7689 #define C(x)  ((x)-'@')  // Control-x
7690 
7691 void
7692 console_intr(int (*getc)(void))
7693 {
7694   int c;
7695 
7696   acquire(&input.lock);
7697   while((c = getc()) >= 0){
7698     switch(c){
7699     case C('P'):  // Process listing.
7700       procdump();
7701       break;
7702     case C('U'):  // Kill line.
7703       while(input.e > input.w &&
7704             input.buf[(input.e-1) % INPUT_BUF] != '\n'){
7705         input.e--;
7706         cons_putc(BACKSPACE);
7707       }
7708       break;
7709     case C('H'):  // Backspace
7710       if(input.e > input.w){
7711         input.e--;
7712         cons_putc(BACKSPACE);
7713       }
7714       break;
7715     default:
7716       if(c != 0 && input.e < input.r+INPUT_BUF){
7717         input.buf[input.e++ % INPUT_BUF] = c;
7718         cons_putc(c);
7719         if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
7720           input.w = input.e;
7721           wakeup(&input.r);
7722         }
7723       }
7724       break;
7725     }
7726   }
7727   release(&input.lock);
7728 }
7729 
7730 void
7731 thread_stub(void * arg)
7732 {
7733 /*    static int id = 0;
7734     id++;
7735 //    int myid = id;
7736     cprintf("thread_stub started! arg: %d\n", arg);
7737     int i;
7738     for (i=0; i<100000000; i++)
7739     {
7740         if (i % 100000 == 0)
7741         cprintf("%d:", myid);
7742     }*/
7743   static int in = 0;
7744   if (in)
7745       return;
7746   in = 1;
7747   unsigned char data[512];
7748   int s;
7749   int len;
7750   s = lwip_socket(PF_INET, SOCK_STREAM, 0);
7751   struct sockaddr_in sa;
7752   sa.sin_family = AF_INET;
7753   sa.sin_port = htons(80);
7754   sa.sin_addr.s_addr = inet_addr("192.168.1.1");
7755   len = 1;
7756   lwip_setsockopt(s, SOL_SOCKET, SO_REUSEPORT, &len, sizeof(int));
7757   lwip_bind(s, &sa, sizeof(sa));
7758   int addrlen = sizeof(sa);
7759 //  len = lwip_recvfrom(s, data, sizeof(data), 0, &sa, &addrlen);
7760 //  lwip_sendto(s, data, len, 0, &sa, addrlen);
7761   int client;
7762   lwip_listen(s, 1);
7763   while ((client = lwip_accept(s, &sa, &addrlen)) > 0)
7764   {
7765       do {
7766         len = lwip_read(client, data, sizeof(data));
7767 //        cprintf("received %d bytes\n", len);
7768         lwip_send(client, data, len, 0);
7769         if (data[0] == '!')
7770             len = -1;
7771       } while (len > 0);
7772       lwip_close(client);
7773   }
7774   lwip_close(s);
7775   in = 0;
7776 }
7777 
7778 
7779 int
7780 console_read(struct inode *ip, char *dst, int n)
7781 {
7782   uint target;
7783   int c;
7784   int ret;
7785 //  unsigned char data[100];
7786   int mark;
7787 
7788 //  kproc_start(thread_stub, 0, 0, 0, "[stub thread]");
7789 //  for (c=0; c<10; c++)
7790 //      data[c] = 0xda;
7791   iunlock(ip);
7792   target = n;
7793   acquire(&input.lock);
7794   while(n > 0){
7795     while(input.r == input.w){
7796       if(cp->killed){
7797         release(&input.lock);
7798         ilock(ip);
7799         return -1;
7800       }
7801       mark = 0;
7802       sleep(&input.r, &input.lock);
7803 /*      do {
7804         ret = msleep_spin(&input.r, &input.lock, 1000);
7805        if (ret)
7806         {*/
7807 //            if ((mark = lwip_recv(s, data,
7808 //            sizeof(data), MSG_DONTWAIT)) > 0)
7809 //                cprintf("received from 192.168.1.1:80: %d\n", mark);
7810 /*            if (mark == 0)
7811             {
7812                 for ( ; mark < 64; mark ++)
7813                     e100_send(data, sizeof(data));
7814             }
7815             int len = e100_receive(data, sizeof(data));
7816             cprintf("received: %d bytes\n", len);
7817             int i;
7818             for (i=0; i<len; i++)
7819             {
7820                 cprintf("%02x ", data[i]);
7821                 if ((i+1) % 10 == 0)
7822                     cprintf("\n");
7823             }
7824             cprintf("\n");*/
7825 //            kproc_start(thread_stub, (void *)100, 0, 0);
7826 //            cprintf("XXX faster!!\n");
7827 /*        }
7828       } while (ret);*/
7829     }
7830     c = input.buf[input.r++ % INPUT_BUF];
7831     if(c == C('D')){  // EOF
7832       if(n < target){
7833         // Save ^D for next time, to make sure
7834         // caller gets a 0-byte result.
7835         input.r--;
7836       }
7837       break;
7838     }
7839     *dst++ = c;
7840     --n;
7841     if(c == '\n')
7842       break;
7843   }
7844   release(&input.lock);
7845   ilock(ip);
7846 
7847   return target - n;
7848 }
7849 
7850 void
7851 console_init(void)
7852 {
7853   initlock(&console_lock, "console");
7854   initlock(&input.lock, "console input");
7855 
7856   devsw[CONSOLE].write = console_write;
7857   devsw[CONSOLE].read = console_read;
7858   //use_console_lock = 1;
7859 
7860   pic_enable(IRQ_KBD);
7861   ioapic_enable(IRQ_KBD, 0);
7862 }
7863 
7864 void
7865 printstack()
7866 {
7867   int i;
7868   uint ebp;
7869   uint pcs[10];
7870   cprintf("Stack trace:\n");
7871   asm("movl %%ebp, %0" : "=r"(ebp) : );
7872   getcallerpcs((void*)(ebp+8), pcs);
7873   for(i=0; i<10; i++)
7874     cprintf("0x%08x ", pcs[i]);
7875   cprintf("\n");
7876 }
7877 
7878 
7879 void
7880 panic(char *s)
7881 {
7882   int i;
7883   uint pcs[10];
7884 
7885   __asm __volatile("cli");
7886   use_console_lock = 0;
7887   cprintf("panic (%d): ", cpu());
7888   cprintf(s, 0);
7889   cprintf("\n", 0);
7890   getcallerpcs(&s, pcs);
7891   for(i=0; i<10; i++)
7892     cprintf(" %p", pcs[i]);
7893   panicked = 1; // freeze other CPU
7894   for(;;)
7895     ;
7896 }
7897 
7898 
7899 
