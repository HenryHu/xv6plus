6850 // The I/O APIC manages hardware interrupts for an SMP system.
6851 // http://www.intel.com/design/chipsets/datashts/29056601.pdf
6852 // See also picirq.c.
6853 
6854 #include "types.h"
6855 #include "defs.h"
6856 #include "traps.h"
6857 
6858 #define IOAPIC  0xFEC00000   // Default physical address of IO APIC
6859 
6860 #define REG_ID     0x00  // Register index: ID
6861 #define REG_VER    0x01  // Register index: version
6862 #define REG_TABLE  0x10  // Redirection table base
6863 
6864 // The redirection table starts at REG_TABLE and uses
6865 // two registers to configure each interrupt.
6866 // The first (low) register in a pair contains configuration bits.
6867 // The second (high) register contains a bitmask telling which
6868 // CPUs can serve that interrupt.
6869 #define INT_DISABLED   0x00100000  // Interrupt disabled
6870 #define INT_LEVEL      0x00008000  // Level-triggered (vs edge-)
6871 #define INT_ACTIVELOW  0x00002000  // Active low (vs high)
6872 #define INT_LOGICAL    0x00000800  // Destination is CPU id (vs APIC ID)
6873 
6874 volatile struct ioapic *ioapic;
6875 
6876 // IO APIC MMIO structure: write reg, then read or write data.
6877 struct ioapic {
6878   uint reg;
6879   uint pad[3];
6880   uint data;
6881 };
6882 
6883 static uint
6884 ioapic_read(int reg)
6885 {
6886   ioapic->reg = reg;
6887   return ioapic->data;
6888 }
6889 
6890 static void
6891 ioapic_write(int reg, uint data)
6892 {
6893   ioapic->reg = reg;
6894   ioapic->data = data;
6895 }
6896 
6897 
6898 
6899 
6900 void
6901 ioapic_init(void)
6902 {
6903   int i, id, maxintr;
6904 
6905   if(!ismp)
6906     return;
6907 
6908   ioapic = (volatile struct ioapic*)IOAPIC;
6909   maxintr = (ioapic_read(REG_VER) >> 16) & 0xFF;
6910   id = ioapic_read(REG_ID) >> 24;
6911   if(id != ioapic_id)
6912     cprintf("ioapic_init: id isn't equal to ioapic_id; not a MP\n");
6913 
6914   // Mark all interrupts edge-triggered, active high, disabled,
6915   // and not routed to any CPUs.
6916   for(i = 0; i <= maxintr; i++){
6917     ioapic_write(REG_TABLE+2*i, INT_DISABLED | (IRQ_OFFSET + i));
6918     ioapic_write(REG_TABLE+2*i+1, 0);
6919   }
6920 }
6921 
6922 void
6923 ioapic_enable(int irq, int cpunum)
6924 {
6925   if(!ismp)
6926     return;
6927 
6928   // Mark interrupt edge-triggered, active high,
6929   // enabled, and routed to the given cpunum,
6930   // which happens to be that cpu's APIC ID.
6931   ioapic_write(REG_TABLE+2*irq, IRQ_OFFSET + irq);
6932   ioapic_write(REG_TABLE+2*irq+1, cpunum << 24);
6933 }
6934 
6935 
6936 
6937 
6938 
6939 
6940 
6941 
6942 
6943 
6944 
6945 
6946 
6947 
6948 
6949 
