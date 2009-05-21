0400 #ifndef XV6_X86_H_
0401 #define XV6_X86_H_
0402 // Routines to let C code use special x86 instructions.
0403 
0404 static inline uchar
0405 inb(ushort port)
0406 {
0407   uchar data;
0408 
0409   asm volatile("in %1,%0" : "=a" (data) : "d" (port));
0410   return data;
0411 }
0412 
0413 static inline uint
0414 inl(ushort port)
0415 {
0416     uint data;
0417 
0418     asm volatile("in %1,%0" : "=a" (data) : "d" (port));
0419     return data;
0420 }
0421 
0422 static inline ushort
0423 inw(ushort port)
0424 {
0425     ushort data;
0426 
0427     asm volatile("in %1,%0" : "=a" (data) : "d" (port));
0428     return data;
0429 }
0430 
0431 static inline void
0432 insl(int port, void *addr, int cnt)
0433 {
0434   asm volatile("cld\n\trepne\n\tinsl"     :
0435                    "=D" (addr), "=c" (cnt)    :
0436                    "d" (port), "0" (addr), "1" (cnt)  :
0437                    "memory", "cc");
0438 }
0439 
0440 static inline void
0441 outb(ushort port, uchar data)
0442 {
0443   asm volatile("out %0,%1" : : "a" (data), "d" (port));
0444 }
0445 
0446 
0447 
0448 
0449 
0450 static inline void
0451 outw(ushort port, ushort data)
0452 {
0453   asm volatile("out %0,%1" : : "a" (data), "d" (port));
0454 }
0455 
0456 static inline void
0457 outl(ushort port, uint data)
0458 {
0459     asm volatile("out %0,%1" : : "a" (data), "d" (port));
0460 }
0461 
0462 static inline void
0463 outsl(int port, const void *addr, int cnt)
0464 {
0465   asm volatile("cld\n\trepne\n\toutsl"    :
0466                    "=S" (addr), "=c" (cnt)    :
0467                    "d" (port), "0" (addr), "1" (cnt)  :
0468                    "cc");
0469 }
0470 
0471 struct segdesc;
0472 
0473 static inline void
0474 lgdt(struct segdesc *p, int size)
0475 {
0476   volatile ushort pd[3];
0477 
0478   pd[0] = size-1;
0479   pd[1] = (uint)p;
0480   pd[2] = (uint)p >> 16;
0481 
0482   asm volatile("lgdt (%0)" : : "r" (pd));
0483 }
0484 
0485 struct gatedesc;
0486 
0487 static inline void
0488 lidt(struct gatedesc *p, int size)
0489 {
0490   volatile ushort pd[3];
0491 
0492   pd[0] = size-1;
0493   pd[1] = (uint)p;
0494   pd[2] = (uint)p >> 16;
0495 
0496   asm volatile("lidt (%0)" : : "r" (pd));
0497 }
0498 
0499 
0500 static inline void
0501 ltr(ushort sel)
0502 {
0503   asm volatile("ltr %0" : : "r" (sel));
0504 }
0505 
0506 static inline uint
0507 read_eflags(void)
0508 {
0509   uint eflags;
0510   asm volatile("pushfl; popl %0" : "=r" (eflags));
0511   return eflags;
0512 }
0513 
0514 static inline void
0515 write_eflags(uint eflags)
0516 {
0517   asm volatile("pushl %0; popfl" : : "r" (eflags));
0518 }
0519 
0520 static inline void
0521 cpuid(uint info, uint *eaxp, uint *ebxp, uint *ecxp, uint *edxp)
0522 {
0523   uint eax, ebx, ecx, edx;
0524 
0525   asm volatile("cpuid" :
0526                "=a" (eax), "=b" (ebx), "=c" (ecx), "=d" (edx) :
0527                "a" (info));
0528   if(eaxp)
0529     *eaxp = eax;
0530   if(ebxp)
0531     *ebxp = ebx;
0532   if(ecxp)
0533     *ecxp = ecx;
0534   if(edxp)
0535     *edxp = edx;
0536 }
0537 
0538 static inline uint
0539 cmpxchg(uint oldval, uint newval, volatile uint* lock_addr)
0540 {
0541   uint result;
0542 
0543   // The + in "+m" denotes a read-modify-write operand.
0544   asm volatile("lock; cmpxchgl %2, %0" :
0545                        "+m" (*lock_addr), "=a" (result) :
0546                        "r"(newval), "1"(oldval) :
0547                        "cc");
0548   return result;
0549 }
0550 static inline void
0551 cli(void)
0552 {
0553   asm volatile("cli");
0554 }
0555 
0556 static inline void
0557 sti(void)
0558 {
0559   asm volatile("sti");
0560 }
0561 
0562 // Layout of the trap frame built on the stack by the
0563 // hardware and by trapasm.S, and passed to trap().
0564 struct trapframe {
0565   // registers as pushed by pusha
0566   uint edi;
0567   uint esi;
0568   uint ebp;
0569   uint oesp;      // useless & ignored
0570   uint ebx;
0571   uint edx;
0572   uint ecx;
0573   uint eax;
0574 
0575   // rest of trap frame
0576   ushort es;
0577   ushort padding1;
0578   ushort ds;
0579   ushort padding2;
0580   uint trapno;
0581 
0582   // below here defined by x86 hardware
0583   uint err;
0584   uint eip;
0585   ushort cs;
0586   ushort padding3;
0587   uint eflags;
0588 
0589   // below here only when crossing rings, such as from user to kernel
0590   uint esp;
0591   ushort ss;
0592   ushort padding4;
0593 };
0594 #endif // XV6_X86_H_
0595 
0596 
0597 
0598 
0599 
