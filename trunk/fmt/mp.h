6450 // See MultiProcessor Specification Version 1.[14]
6451 
6452 struct mp {             // floating pointer
6453   uchar signature[4];           // "_MP_"
6454   void *physaddr;               // phys addr of MP config table
6455   uchar length;                 // 1
6456   uchar specrev;                // [14]
6457   uchar checksum;               // all bytes must add up to 0
6458   uchar type;                   // MP system config type
6459   uchar imcrp;
6460   uchar reserved[3];
6461 };
6462 
6463 struct mpconf {         // configuration table header
6464   uchar signature[4];           // "PCMP"
6465   ushort length;                // total table length
6466   uchar version;                // [14]
6467   uchar checksum;               // all bytes must add up to 0
6468   uchar product[20];            // product id
6469   uint *oemtable;               // OEM table pointer
6470   ushort oemlength;             // OEM table length
6471   ushort entry;                 // entry count
6472   uint *lapicaddr;              // address of local APIC
6473   ushort xlength;               // extended table length
6474   uchar xchecksum;              // extended table checksum
6475   uchar reserved;
6476 };
6477 
6478 struct mpproc {         // processor table entry
6479   uchar type;                   // entry type (0)
6480   uchar apicid;                 // local APIC id
6481   uchar version;                // local APIC verison
6482   uchar flags;                  // CPU flags
6483     #define MPBOOT 0x02           // This proc is the bootstrap processor.
6484   uchar signature[4];           // CPU signature
6485   uint feature;                 // feature flags from CPUID instruction
6486   uchar reserved[8];
6487 };
6488 
6489 struct mpioapic {       // I/O APIC table entry
6490   uchar type;                   // entry type (2)
6491   uchar apicno;                 // I/O APIC id
6492   uchar version;                // I/O APIC version
6493   uchar flags;                  // I/O APIC flags
6494   uint *addr;                  // I/O APIC address
6495 };
6496 
6497 
6498 
6499 
6500 // Table entry types
6501 #define MPPROC    0x00  // One per processor
6502 #define MPBUS     0x01  // One per bus
6503 #define MPIOAPIC  0x02  // One per I/O APIC
6504 #define MPIOINTR  0x03  // One per bus interrupt source
6505 #define MPLINTR   0x04  // One per system interrupt source
6506 
6507 
6508 
6509 
6510 
6511 
6512 
6513 
6514 
6515 
6516 
6517 
6518 
6519 
6520 
6521 
6522 
6523 
6524 
6525 
6526 
6527 
6528 
6529 
6530 
6531 
6532 
6533 
6534 
6535 
6536 
6537 
6538 
6539 
6540 
6541 
6542 
6543 
6544 
6545 
6546 
6547 
6548 
6549 
