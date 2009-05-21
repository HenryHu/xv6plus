0600 //
0601 // assembler macros to create x86 segments
0602 //
0603 
0604 #define SEG_NULLASM                                             \
0605         .word 0, 0;                                             \
0606         .byte 0, 0, 0, 0
0607 
0608 #define SEG_ASM(type,base,lim)                                  \
0609         .word (((lim) >> 12) & 0xffff), ((base) & 0xffff);      \
0610         .byte (((base) >> 16) & 0xff), (0x90 | (type)),         \
0611                 (0xC0 | (((lim) >> 28) & 0xf)), (((base) >> 24) & 0xff)
0612 
0613 #define STA_X     0x8       // Executable segment
0614 #define STA_E     0x4       // Expand down (non-executable segments)
0615 #define STA_C     0x4       // Conforming code segment (executable only)
0616 #define STA_W     0x2       // Writeable (non-executable segments)
0617 #define STA_R     0x2       // Readable (executable segments)
0618 #define STA_A     0x1       // Accessed
0619 
0620 
0621 
0622 
0623 
0624 
0625 
0626 
0627 
0628 
0629 
0630 
0631 
0632 
0633 
0634 
0635 
0636 
0637 
0638 
0639 
0640 
0641 
0642 
0643 
0644 
0645 
0646 
0647 
0648 
0649 
