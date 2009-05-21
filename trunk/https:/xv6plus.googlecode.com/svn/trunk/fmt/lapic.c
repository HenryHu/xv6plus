6700 // The local APIC manages internal (non-I/O) interrupts.
6701 // See Chapter 8 & Appendix C of Intel processor manual volume 3.
6702 
6703 #include "types.h"
6704 #include "traps.h"
6705 
6706 // Local APIC registers, divided by 4 for use as uint[] indices.
6707 #define ID      (0x0020/4)   // ID
6708 #define VER     (0x0030/4)   // Version
6709 #define TPR     (0x0080/4)   // Task Priority
6710 #define EOI     (0x00B0/4)   // EOI
6711 #define SVR     (0x00F0/4)   // Spurious Interrupt Vector
6712   #define ENABLE     0x00000100   // Unit Enable
6713 #define ESR     (0x0280/4)   // Error Status
6714 #define ICRLO   (0x0300/4)   // Interrupt Command
6715   #define INIT       0x00000500   // INIT/RESET
6716   #define STARTUP    0x00000600   // Startup IPI
6717   #define DELIVS     0x00001000   // Delivery status
6718   #define ASSERT     0x00004000   // Assert interrupt (vs deassert)
6719   #define LEVEL      0x00008000   // Level triggered
6720   #define BCAST      0x00080000   // Send to all APICs, including self.
6721 #define ICRHI   (0x0310/4)   // Interrupt Command [63:32]
6722 #define TIMER   (0x0320/4)   // Local Vector Table 0 (TIMER)
6723   #define X1         0x0000000B   // divide counts by 1
6724   #define PERIODIC   0x00020000   // Periodic
6725 #define PCINT   (0x0340/4)   // Performance Counter LVT
6726 #define LINT0   (0x0350/4)   // Local Vector Table 1 (LINT0)
6727 #define LINT1   (0x0360/4)   // Local Vector Table 2 (LINT1)
6728 #define ERROR   (0x0370/4)   // Local Vector Table 3 (ERROR)
6729   #define MASKED     0x00010000   // Interrupt masked
6730 #define TICR    (0x0380/4)   // Timer Initial Count
6731 #define TCCR    (0x0390/4)   // Timer Current Count
6732 #define TDCR    (0x03E0/4)   // Timer Divide Configuration
6733 
6734 volatile uint *lapic;  // Initialized in mp.c
6735 
6736 void
6737 lapic_init(int c)
6738 {
6739   if(!lapic)
6740     return;
6741 
6742   // Enable local APIC; set spurious interrupt vector.
6743   lapic[SVR] = ENABLE | (IRQ_OFFSET+IRQ_SPURIOUS);
6744 
6745   // The timer repeatedly counts down at bus frequency
6746   // from lapic[TICR] and then issues an interrupt.
6747   // Lapic[TCCR] is the current counter value.
6748   // If xv6 cared more about precise timekeeping, the
6749   // values of TICR and TCCR would be calibrated using
6750   // an external time source.
6751   lapic[TDCR] = X1;
6752   lapic[TICR] = 10000000;
6753   lapic[TCCR] = 10000000;
6754   lapic[TIMER] = PERIODIC | (IRQ_OFFSET + IRQ_TIMER);
6755 
6756   // Disable logical interrupt lines.
6757   lapic[LINT0] = MASKED;
6758   lapic[LINT1] = MASKED;
6759 
6760   // Disable performance counter overflow interrupts
6761   // on machines that provide that interrupt entry.
6762   if(((lapic[VER]>>16) & 0xFF) >= 4)
6763     lapic[PCINT] = MASKED;
6764 
6765   // Map error interrupt to IRQ_ERROR.
6766   lapic[ERROR] = IRQ_OFFSET+IRQ_ERROR;
6767 
6768   // Clear error status register (requires back-to-back writes).
6769   lapic[ESR] = 0;
6770   lapic[ESR] = 0;
6771 
6772   // Ack any outstanding interrupts.
6773   lapic[EOI] = 0;
6774 
6775   // Send an Init Level De-Assert to synchronise arbitration ID's.
6776   lapic[ICRHI] = 0;
6777   lapic[ICRLO] = BCAST | INIT | LEVEL;
6778   while(lapic[ICRLO] & DELIVS)
6779     ;
6780 
6781   // Enable interrupts on the APIC (but not on the processor).
6782   lapic[TPR] = 0;
6783 }
6784 
6785 int
6786 cpu(void)
6787 {
6788   if(lapic)
6789     return lapic[ID]>>24;
6790   return 0;
6791 }
6792 
6793 // Acknowledge interrupt.
6794 void
6795 lapic_eoi(void)
6796 {
6797   if(lapic)
6798     lapic[EOI] = 0;
6799 }
6800 // Spin for a given number of microseconds.
6801 // On real hardware would want to tune this dynamically.
6802 static void
6803 microdelay(int us)
6804 {
6805   volatile int j = 0;
6806 
6807   while(us-- > 0)
6808     for(j=0; j<10000; j++);
6809 }
6810 
6811 // Start additional processor running bootstrap code at addr.
6812 // See Appendix B of MultiProcessor Specification.
6813 void
6814 lapic_startap(uchar apicid, uint addr)
6815 {
6816   int i;
6817   volatile int j = 0;
6818 
6819   // Send INIT interrupt to reset other CPU.
6820   lapic[ICRHI] = apicid<<24;
6821   lapic[ICRLO] = INIT | LEVEL;
6822   microdelay(10);
6823 
6824   // Send startup IPI (twice!) to enter bootstrap code.
6825   for(i = 0; i < 2; i++){
6826     lapic[ICRHI] = apicid<<24;
6827     lapic[ICRLO] = STARTUP | (addr>>12);
6828     for(j=0; j<10000; j++);  // 200us
6829   }
6830 }
6831 
6832 
6833 
6834 
6835 
6836 
6837 
6838 
6839 
6840 
6841 
6842 
6843 
6844 
6845 
6846 
6847 
6848 
6849 
