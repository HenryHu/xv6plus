1050 #include "asm.h"
1051 
1052 # Start an Application Processor. This must be placed on a 4KB boundary
1053 # somewhere in the 1st MB of conventional memory (APBOOTSTRAP). However,
1054 # due to some shortcuts below it's restricted further to within the 1st
1055 # 64KB. The AP starts in real-mode, with
1056 #   CS selector set to the startup memory address/16;
1057 #   CS base set to startup memory address;
1058 #   CS limit set to 64KB;
1059 #   CPL and IP set to 0.
1060 #
1061 # Bootothers (in main.c) starts each non-boot CPU in turn.
1062 # It puts the correct %esp in start-4,
1063 # and the place to jump to in start-8.
1064 #
1065 # This code is identical to bootasm.S except:
1066 #   - it does not need to enable A20
1067 #   - it uses the address at start-4 for the %esp
1068 #   - it jumps to the address at start-8 instead of calling bootmain
1069 
1070 .set PROT_MODE_CSEG, 0x8         # kernel code segment selector
1071 .set PROT_MODE_DSEG, 0x10        # kernel data segment selector
1072 .set CR0_PE_ON,      0x1         # protected mode enable flag
1073 
1074 .globl start
1075 start:
1076   .code16                     # Assemble for 16-bit mode
1077   cli                         # Disable interrupts
1078   cld                         # String operations increment
1079 
1080   # Set up the important data segment registers (DS, ES, SS).
1081   xorw    %ax,%ax             # Segment number zero
1082   movw    %ax,%ds             # -> Data Segment
1083   movw    %ax,%es             # -> Extra Segment
1084   movw    %ax,%ss             # -> Stack Segment
1085 
1086   # Switch from real to protected mode, using a bootstrap GDT
1087   # and segment translation that makes virtual addresses
1088   # identical to their physical addresses, so that the
1089   # effective memory map does not change during the switch.
1090   lgdt    gdtdesc
1091   movl    %cr0, %eax
1092   orl     $CR0_PE_ON, %eax
1093   movl    %eax, %cr0
1094 
1095   # Jump to next instruction, but in 32-bit code segment.
1096   # Switches processor into 32-bit mode.
1097   ljmp    $PROT_MODE_CSEG, $protcseg
1098 
1099 
1100   .code32                     # Assemble for 32-bit mode
1101 protcseg:
1102   # Set up the protected-mode data segment registers
1103   movw    $PROT_MODE_DSEG, %ax    # Our data segment selector
1104   movw    %ax, %ds                # -> DS: Data Segment
1105   movw    %ax, %es                # -> ES: Extra Segment
1106   movw    %ax, %fs                # -> FS
1107   movw    %ax, %gs                # -> GS
1108   movw    %ax, %ss                # -> SS: Stack Segment
1109 
1110   movl    start-4, %esp
1111   movl    start-8, %eax
1112   jmp     *%eax
1113 
1114 # Bootstrap GDT
1115 .p2align 2                                # force 4 byte alignment
1116 gdt:
1117   SEG_NULLASM                             # null seg
1118   SEG_ASM(STA_X|STA_R, 0x0, 0xffffffff)   # code seg
1119   SEG_ASM(STA_W, 0x0, 0xffffffff)         # data seg
1120 
1121 gdtdesc:
1122   .word   0x17                            # sizeof(gdt) - 1
1123   .long   gdt                             # address gdt
1124 
1125 
1126 
1127 
1128 
1129 
1130 
1131 
1132 
1133 
1134 
1135 
1136 
1137 
1138 
1139 
1140 
1141 
1142 
1143 
1144 
1145 
1146 
1147 
1148 
1149 
