0650 #ifndef XV6_MMU_H_
0651 #define XV6_MMU_H_
0652 // This file contains definitions for the
0653 // x86 memory management unit (MMU).
0654 
0655 // Eflags register
0656 #define FL_CF           0x00000001      // Carry Flag
0657 #define FL_PF           0x00000004      // Parity Flag
0658 #define FL_AF           0x00000010      // Auxiliary carry Flag
0659 #define FL_ZF           0x00000040      // Zero Flag
0660 #define FL_SF           0x00000080      // Sign Flag
0661 #define FL_TF           0x00000100      // Trap Flag
0662 #define FL_IF           0x00000200      // Interrupt Enable
0663 #define FL_DF           0x00000400      // Direction Flag
0664 #define FL_OF           0x00000800      // Overflow Flag
0665 #define FL_IOPL_MASK    0x00003000      // I/O Privilege Level bitmask
0666 #define FL_IOPL_0       0x00000000      //   IOPL == 0
0667 #define FL_IOPL_1       0x00001000      //   IOPL == 1
0668 #define FL_IOPL_2       0x00002000      //   IOPL == 2
0669 #define FL_IOPL_3       0x00003000      //   IOPL == 3
0670 #define FL_NT           0x00004000      // Nested Task
0671 #define FL_RF           0x00010000      // Resume Flag
0672 #define FL_VM           0x00020000      // Virtual 8086 mode
0673 #define FL_AC           0x00040000      // Alignment Check
0674 #define FL_VIF          0x00080000      // Virtual Interrupt Flag
0675 #define FL_VIP          0x00100000      // Virtual Interrupt Pending
0676 #define FL_ID           0x00200000      // ID flag
0677 
0678 // Segment Descriptor
0679 struct segdesc {
0680   uint lim_15_0 : 16;  // Low bits of segment limit
0681   uint base_15_0 : 16; // Low bits of segment base address
0682   uint base_23_16 : 8; // Middle bits of segment base address
0683   uint type : 4;       // Segment type (see STS_ constants)
0684   uint s : 1;          // 0 = system, 1 = application
0685   uint dpl : 2;        // Descriptor Privilege Level
0686   uint p : 1;          // Present
0687   uint lim_19_16 : 4;  // High bits of segment limit
0688   uint avl : 1;        // Unused (available for software use)
0689   uint rsv1 : 1;       // Reserved
0690   uint db : 1;         // 0 = 16-bit segment, 1 = 32-bit segment
0691   uint g : 1;          // Granularity: limit scaled by 4K when set
0692   uint base_31_24 : 8; // High bits of segment base address
0693 };
0694 
0695 
0696 
0697 
0698 
0699 
0700 // Null segment
0701 #define SEG_NULL        (struct segdesc){ 0,0,0,0,0,0,0,0,0,0,0,0,0 }
0702 
0703 // Normal segment
0704 #define SEG(type, base, lim, dpl) (struct segdesc)                      \
0705 { ((lim) >> 12) & 0xffff, (base) & 0xffff, ((base) >> 16) & 0xff,       \
0706     type, 1, dpl, 1, (uint) (lim) >> 28, 0, 0, 1, 1,                    \
0707     (uint) (base) >> 24 }
0708 
0709 #define SEG16(type, base, lim, dpl) (struct segdesc)                    \
0710 { (lim) & 0xffff, (base) & 0xffff, ((base) >> 16) & 0xff,               \
0711     type, 1, dpl, 1, (uint) (lim) >> 16, 0, 0, 1, 0,                    \
0712     (uint) (base) >> 24 }
0713 
0714 #define DPL_USER    0x3     // User DPL
0715 
0716 // Application segment type bits
0717 #define STA_X       0x8     // Executable segment
0718 #define STA_E       0x4     // Expand down (non-executable segments)
0719 #define STA_C       0x4     // Conforming code segment (executable only)
0720 #define STA_W       0x2     // Writeable (non-executable segments)
0721 #define STA_R       0x2     // Readable (executable segments)
0722 #define STA_A       0x1     // Accessed
0723 
0724 // System segment type bits
0725 #define STS_T16A    0x1     // Available 16-bit TSS
0726 #define STS_LDT     0x2     // Local Descriptor Table
0727 #define STS_T16B    0x3     // Busy 16-bit TSS
0728 #define STS_CG16    0x4     // 16-bit Call Gate
0729 #define STS_TG      0x5     // Task Gate / Coum Transmitions
0730 #define STS_IG16    0x6     // 16-bit Interrupt Gate
0731 #define STS_TG16    0x7     // 16-bit Trap Gate
0732 #define STS_T32A    0x9     // Available 32-bit TSS
0733 #define STS_T32B    0xB     // Busy 32-bit TSS
0734 #define STS_CG32    0xC     // 32-bit Call Gate
0735 #define STS_IG32    0xE     // 32-bit Interrupt Gate
0736 #define STS_TG32    0xF     // 32-bit Trap Gate
0737 
0738 // Task state segment format
0739 struct taskstate {
0740   uint link;         // Old ts selector
0741   uint esp0;         // Stack pointers and segment selectors
0742   ushort ss0;        //   after an increase in privilege level
0743   ushort padding1;
0744   uint *esp1;
0745   ushort ss1;
0746   ushort padding2;
0747   uint *esp2;
0748   ushort ss2;
0749   ushort padding3;
0750   void *cr3;         // Page directory base
0751   uint *eip;         // Saved state from last task switch
0752   uint eflags;
0753   uint eax;          // More saved state (registers)
0754   uint ecx;
0755   uint edx;
0756   uint ebx;
0757   uint *esp;
0758   uint *ebp;
0759   uint esi;
0760   uint edi;
0761   ushort es;         // Even more saved state (segment selectors)
0762   ushort padding4;
0763   ushort cs;
0764   ushort padding5;
0765   ushort ss;
0766   ushort padding6;
0767   ushort ds;
0768   ushort padding7;
0769   ushort fs;
0770   ushort padding8;
0771   ushort gs;
0772   ushort padding9;
0773   ushort ldt;
0774   ushort padding10;
0775   ushort t;          // Trap on task switch
0776   ushort iomb;       // I/O map base address
0777 };
0778 
0779 // Gate descriptors for interrupts and traps
0780 struct gatedesc {
0781   uint off_15_0 : 16;   // low 16 bits of offset in segment
0782   uint ss : 16;         // segment selector
0783   uint args : 5;        // # args, 0 for interrupt/trap gates
0784   uint rsv1 : 3;        // reserved(should be zero I guess)
0785   uint type : 4;        // type(STS_{TG,IG32,TG32})
0786   uint s : 1;           // must be 0 (system)
0787   uint dpl : 2;         // descriptor(meaning new) privilege level
0788   uint p : 1;           // Present
0789   uint off_31_16 : 16;  // high bits of offset in segment
0790 };
0791 
0792 
0793 
0794 
0795 
0796 
0797 
0798 
0799 
0800 // Set up a normal interrupt/trap gate descriptor.
0801 // - istrap: 1 for a trap (= exception) gate, 0 for an interrupt gate.
0802 //   interrupt gate clears FL_IF, trap gate leaves FL_IF alone
0803 // - sel: Code segment selector for interrupt/trap handler
0804 // - off: Offset in code segment for interrupt/trap handler
0805 // - dpl: Descriptor Privilege Level -
0806 //        the privilege level required for software to invoke
0807 //        this interrupt/trap gate explicitly using an int instruction.
0808 #define SETGATE(gate, istrap, sel, off, d)                \
0809 {                                                         \
0810   (gate).off_15_0 = (uint) (off) & 0xffff;                \
0811   (gate).ss = (sel);                                      \
0812   (gate).args = 0;                                        \
0813   (gate).rsv1 = 0;                                        \
0814   (gate).type = (istrap) ? STS_TG32 : STS_IG32;           \
0815   (gate).s = 0;                                           \
0816   (gate).dpl = (d);                                       \
0817   (gate).p = 1;                                           \
0818   (gate).off_31_16 = (uint) (off) >> 16;                  \
0819 }
0820 
0821 #endif // XV6_MMU_H_
0822 
0823 
0824 
0825 
0826 
0827 
0828 
0829 
0830 
0831 
0832 
0833 
0834 
0835 
0836 
0837 
0838 
0839 
0840 
0841 
0842 
0843 
0844 
0845 
0846 
0847 
0848 
0849 
