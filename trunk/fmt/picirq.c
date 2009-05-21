7000 // Intel 8259A programmable interrupt controllers.
7001 
7002 #include "types.h"
7003 #include "x86.h"
7004 #include "picirq.h"
7005 #include "traps.h"
7006 #include "defs.h"
7007 
7008 irq_handler_t irq_handler[IRQ_MAX];
7009 // I/O Addresses of the two programmable interrupt controllers
7010 #define IO_PIC1         0x20    // Master (IRQs 0-7)
7011 #define IO_PIC2         0xA0    // Slave (IRQs 8-15)
7012 
7013 #define IRQ_SLAVE       2       // IRQ at which slave connects to master
7014 
7015 // Current IRQ mask.
7016 // Initial IRQ mask has interrupt 2 enabled (for slave 8259A).
7017 static ushort irqmask = 0xFFFF & ~(1<<IRQ_SLAVE);
7018 
7019 void
7020 reg_irq_handler(int irq_num, irq_handler_t handler)
7021 {
7022     irq_handler[irq_num] = handler;
7023 }
7024 
7025 static void
7026 pic_setmask(ushort mask)
7027 {
7028   irqmask = mask;
7029   outb(IO_PIC1+1, mask);
7030   outb(IO_PIC2+1, mask >> 8);
7031 }
7032 
7033 void
7034 pic_enable(int irq)
7035 {
7036   pic_setmask(irqmask & ~(1<<irq));
7037 }
7038 
7039 
7040 
7041 
7042 
7043 
7044 
7045 
7046 
7047 
7048 
7049 
7050 // Initialize the 8259A interrupt controllers.
7051 void
7052 pic_init(void)
7053 {
7054   // mask all interrupts
7055   outb(IO_PIC1+1, 0xFF);
7056   outb(IO_PIC2+1, 0xFF);
7057 
7058   // Set up master (8259A-1)
7059 
7060   // ICW1:  0001g0hi
7061   //    g:  0 = edge triggering, 1 = level triggering
7062   //    h:  0 = cascaded PICs, 1 = master only
7063   //    i:  0 = no ICW4, 1 = ICW4 required
7064   outb(IO_PIC1, 0x11);
7065 
7066   // ICW2:  Vector offset
7067   outb(IO_PIC1+1, IRQ_OFFSET);
7068 
7069   // ICW3:  (master PIC) bit mask of IR lines connected to slaves
7070   //        (slave PIC) 3-bit # of slave's connection to master
7071   outb(IO_PIC1+1, 1<<IRQ_SLAVE);
7072 
7073   // ICW4:  000nbmap
7074   //    n:  1 = special fully nested mode
7075   //    b:  1 = buffered mode
7076   //    m:  0 = slave PIC, 1 = master PIC
7077   //      (ignored when b is 0, as the master/slave role
7078   //      can be hardwired).
7079   //    a:  1 = Automatic EOI mode
7080   //    p:  0 = MCS-80/85 mode, 1 = intel x86 mode
7081   outb(IO_PIC1+1, 0x3);
7082 
7083   // Set up slave (8259A-2)
7084   outb(IO_PIC2, 0x11);                  // ICW1
7085   outb(IO_PIC2+1, IRQ_OFFSET + 8);      // ICW2
7086   outb(IO_PIC2+1, IRQ_SLAVE);           // ICW3
7087   // NB Automatic EOI mode doesn't tend to work on the slave.
7088   // Linux source code says it's "to be investigated".
7089   outb(IO_PIC2+1, 0x3);                 // ICW4
7090 
7091   // OCW3:  0ef01prs
7092   //   ef:  0x = NOP, 10 = clear specific mask, 11 = set specific mask
7093   //    p:  0 = no polling, 1 = polling mode
7094   //   rs:  0x = NOP, 10 = read IRR, 11 = read ISR
7095   outb(IO_PIC1, 0x68);             // clear specific mask
7096   outb(IO_PIC1, 0x0a);             // read IRR by default
7097 
7098   outb(IO_PIC2, 0x68);             // OCW3
7099   outb(IO_PIC2, 0x0a);             // OCW3
7100   if(irqmask != 0xFFFF)
7101     pic_setmask(irqmask);
7102   memset(irq_handler, 0, sizeof(irq_handler));
7103 }
7104 
7105 
7106 
7107 
7108 
7109 
7110 
7111 
7112 
7113 
7114 
7115 
7116 
7117 
7118 
7119 
7120 
7121 
7122 
7123 
7124 
7125 
7126 
7127 
7128 
7129 
7130 
7131 
7132 
7133 
7134 
7135 
7136 
7137 
7138 
7139 
7140 
7141 
7142 
7143 
7144 
7145 
7146 
7147 
7148 
7149 
