6550 // Multiprocessor bootstrap.
6551 // Search memory for MP description structures.
6552 // http://developer.intel.com/design/pentium/datashts/24201606.pdf
6553 
6554 #include "types.h"
6555 #include "defs.h"
6556 #include "param.h"
6557 #include "mp.h"
6558 #include "x86.h"
6559 #include "mmu.h"
6560 #include "proc.h"
6561 
6562 struct cpu cpus[NCPU];
6563 static struct cpu *bcpu;
6564 int ismp;
6565 int ncpu;
6566 uchar ioapic_id;
6567 
6568 int
6569 mp_bcpu(void)
6570 {
6571   return bcpu-cpus;
6572 }
6573 
6574 static uchar
6575 sum(uchar *addr, int len)
6576 {
6577   int i, sum;
6578 
6579   sum = 0;
6580   for(i=0; i<len; i++)
6581     sum += addr[i];
6582   return sum;
6583 }
6584 
6585 // Look for an MP structure in the len bytes at addr.
6586 static struct mp*
6587 mp_search1(uchar *addr, int len)
6588 {
6589   uchar *e, *p;
6590 
6591   e = addr+len;
6592   for(p = addr; p < e; p += sizeof(struct mp))
6593     if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
6594       return (struct mp*)p;
6595   return 0;
6596 }
6597 
6598 
6599 
6600 // Search for the MP Floating Pointer Structure, which according to the
6601 // spec is in one of the following three locations:
6602 // 1) in the first KB of the EBDA;
6603 // 2) in the last KB of system base memory;
6604 // 3) in the BIOS ROM between 0xE0000 and 0xFFFFF.
6605 static struct mp*
6606 mp_search(void)
6607 {
6608   uchar *bda;
6609   uint p;
6610   struct mp *mp;
6611 
6612   bda = (uchar*)0x400;
6613   if((p = (bda[0x0F]<<8)|bda[0x0E])){
6614     if((mp = mp_search1((uchar*)p, 1024)))
6615       return mp;
6616   } else {
6617     p = ((bda[0x14]<<8)|bda[0x13])*1024;
6618     if((mp = mp_search1((uchar*)p-1024, 1024)))
6619       return mp;
6620   }
6621   return mp_search1((uchar*)0xF0000, 0x10000);
6622 }
6623 
6624 // Search for an MP configuration table.  For now,
6625 // don't accept the default configurations (physaddr == 0).
6626 // Check for correct signature, calculate the checksum and,
6627 // if correct, check the version.
6628 // To do: check extended table checksum.
6629 static struct mpconf*
6630 mp_config(struct mp **pmp)
6631 {
6632   struct mpconf *conf;
6633   struct mp *mp;
6634 
6635   if((mp = mp_search()) == 0 || mp->physaddr == 0)
6636     return 0;
6637   conf = (struct mpconf*)mp->physaddr;
6638   if(memcmp(conf, "PCMP", 4) != 0)
6639     return 0;
6640   if(conf->version != 1 && conf->version != 4)
6641     return 0;
6642   if(sum((uchar*)conf, conf->length) != 0)
6643     return 0;
6644   *pmp = mp;
6645   return conf;
6646 }
6647 
6648 
6649 
6650 void
6651 mp_init(void)
6652 {
6653   uchar *p, *e;
6654   struct mp *mp;
6655   struct mpconf *conf;
6656   struct mpproc *proc;
6657   struct mpioapic *ioapic;
6658 
6659   bcpu = &cpus[ncpu];
6660   if((conf = mp_config(&mp)) == 0)
6661     return;
6662 
6663   ismp = 1;
6664   lapic = (uint*)conf->lapicaddr;
6665 
6666   for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
6667     switch(*p){
6668     case MPPROC:
6669       proc = (struct mpproc*)p;
6670       cpus[ncpu].apicid = proc->apicid;
6671       if(proc->flags & MPBOOT)
6672         bcpu = &cpus[ncpu];
6673       ncpu++;
6674       p += sizeof(struct mpproc);
6675       continue;
6676     case MPIOAPIC:
6677       ioapic = (struct mpioapic*)p;
6678       ioapic_id = ioapic->apicno;
6679       p += sizeof(struct mpioapic);
6680       continue;
6681     case MPBUS:
6682     case MPIOINTR:
6683     case MPLINTR:
6684       p += 8;
6685       continue;
6686     default:
6687       cprintf("mp_init: unknown config type %x\n", *p);
6688       panic("mp_init");
6689     }
6690   }
6691 
6692   if(mp->imcrp){
6693     // Bochs doesn't support IMCR, so this doesn't run on Bochs.
6694     // But it would on real hardware.
6695     outb(0x22, 0x70);   // Select IMCR
6696     outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
6697   }
6698 }
6699 
