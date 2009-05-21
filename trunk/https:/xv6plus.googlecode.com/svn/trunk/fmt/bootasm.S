0950 #include "asm.h"
0951 
0952 # Start the first CPU: switch to 32-bit protected mode, jump into C.
0953 # The BIOS loads this code from the first sector of the hard disk into
0954 # memory at physical address 0x7c00 and starts executing in real mode
0955 # with %cs=0 %ip=7c00.
0956 
0957 .set PROT_MODE_CSEG, 0x8         # kernel code segment selector
0958 .set PROT_MODE_DSEG, 0x10        # kernel data segment selector
0959 .set CR0_PE_ON,      0x1         # protected mode enable flag
0960 
0961 .globl start
0962 start:
0963   .code16                     # Assemble for 16-bit mode
0964   cli                         # Disable interrupts
0965   cld                         # String operations increment
0966 
0967   # Set up the important data segment registers (DS, ES, SS).
0968   xorw    %ax,%ax             # Segment number zero
0969   movw    %ax,%ds             # -> Data Segment
0970   movw    %ax,%es             # -> Extra Segment
0971   movw    %ax,%ss             # -> Stack Segment
0972 
0973   # Enable A20:
0974   #   For backwards compatibility with the earliest PCs, physical
0975   #   address line 20 is tied low, so that addresses higher than
0976   #   1MB wrap around to zero by default.  This code undoes this.
0977 seta20.1:
0978   inb     $0x64,%al               # Wait for not busy
0979   testb   $0x2,%al
0980   jnz     seta20.1
0981 
0982   movb    $0xd1,%al               # 0xd1 -> port 0x64
0983   outb    %al,$0x64
0984 
0985 seta20.2:
0986   inb     $0x64,%al               # Wait for not busy
0987   testb   $0x2,%al
0988   jnz     seta20.2
0989 
0990   movb    $0xdf,%al               # 0xdf -> port 0x60
0991   outb    %al,$0x60
0992 
0993   # Switch from real to protected mode, using a bootstrap GDT
0994   # and segment translation that makes virtual addresses
0995   # identical to their physical addresses, so that the
0996   # effective memory map does not change during the switch.
0997   lgdt    gdtdesc
0998   movl    %cr0, %eax
0999   orl     $CR0_PE_ON, %eax
1000   movl    %eax, %cr0
1001 
1002   # Jump to next instruction, but in 32-bit code segment.
1003   # Switches processor into 32-bit mode.
1004   ljmp    $PROT_MODE_CSEG, $protcseg
1005 
1006   .code32                     # Assemble for 32-bit mode
1007 protcseg:
1008   # Set up the protected-mode data segment registers
1009   movw    $PROT_MODE_DSEG, %ax    # Our data segment selector
1010   movw    %ax, %ds                # -> DS: Data Segment
1011   movw    %ax, %es                # -> ES: Extra Segment
1012   movw    %ax, %fs                # -> FS
1013   movw    %ax, %gs                # -> GS
1014   movw    %ax, %ss                # -> SS: Stack Segment
1015 
1016   # Set up the stack pointer and call into C.
1017   movl    $start, %esp
1018   call    bootmain
1019 
1020   # If bootmain returns (it shouldn't), loop.
1021 spin:
1022   jmp     spin
1023 
1024 # Bootstrap GDT
1025 .p2align 2                                # force 4 byte alignment
1026 gdt:
1027   SEG_NULLASM                             # null seg
1028   SEG_ASM(STA_X|STA_R, 0x0, 0xffffffff)   # code seg
1029   SEG_ASM(STA_W, 0x0, 0xffffffff)         # data seg
1030 
1031 gdtdesc:
1032   .word   0x17                            # sizeof(gdt) - 1
1033   .long   gdt                             # address gdt
1034 
1035 
1036 
1037 
1038 
1039 
1040 
1041 
1042 
1043 
1044 
1045 
1046 
1047 
1048 
1049 
