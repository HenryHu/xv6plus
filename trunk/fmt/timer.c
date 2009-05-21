7900 // Intel 8253/8254/82C54 Programmable Interval Timer (PIT).
7901 // Only used on uniprocessors;
7902 // SMP machines use the local APIC timer.
7903 
7904 #include "types.h"
7905 #include "defs.h"
7906 #include "traps.h"
7907 #include "x86.h"
7908 
7909 #define IO_TIMER1       0x040           // 8253 Timer #1
7910 
7911 // Frequency of all three count-down timers;
7912 // (TIMER_FREQ/freq) is the appropriate count
7913 // to generate a frequency of freq Hz.
7914 
7915 #define TIMER_FREQ      1193182
7916 #define TIMER_DIV(x)    ((TIMER_FREQ+(x)/2)/(x))
7917 
7918 #define TIMER_MODE      (IO_TIMER1 + 3) // timer mode port
7919 #define TIMER_SEL0      0x00    // select counter 0
7920 #define TIMER_RATEGEN   0x04    // mode 2, rate generator
7921 #define TIMER_16BIT     0x30    // r/w counter 16 bits, LSB first
7922 
7923 void
7924 timer_init(void)
7925 {
7926   // Interrupt 100 times/sec.
7927   outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
7928   outb(IO_TIMER1, TIMER_DIV(100) % 256);
7929   outb(IO_TIMER1, TIMER_DIV(100) / 256);
7930   pic_enable(IRQ_TIMER);
7931 }
7932 
7933 int
7934 millitime(void)
7935 {
7936     return ticks * 10;
7937 }
7938 
7939 
7940 
7941 
7942 
7943 
7944 
7945 
7946 
7947 
7948 
7949 
