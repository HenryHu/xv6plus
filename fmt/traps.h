3050 // x86 trap and interrupt constants.
3051 
3052 // Processor-defined:
3053 #define T_DIVIDE         0      // divide error
3054 #define T_DEBUG          1      // debug exception
3055 #define T_NMI            2      // non-maskable interrupt
3056 #define T_BRKPT          3      // breakpoint
3057 #define T_OFLOW          4      // overflow
3058 #define T_BOUND          5      // bounds check
3059 #define T_ILLOP          6      // illegal opcode
3060 #define T_DEVICE         7      // device not available
3061 #define T_DBLFLT         8      // double fault
3062 // #define T_COPROC      9      // reserved (not used since 486)
3063 #define T_TSS           10      // invalid task switch segment
3064 #define T_SEGNP         11      // segment not present
3065 #define T_STACK         12      // stack exception
3066 #define T_GPFLT         13      // general protection fault
3067 #define T_PGFLT         14      // page fault
3068 // #define T_RES        15      // reserved
3069 #define T_FPERR         16      // floating point error
3070 #define T_ALIGN         17      // aligment check
3071 #define T_MCHK          18      // machine check
3072 #define T_SIMDERR       19      // SIMD floating point error
3073 
3074 // These are arbitrarily chosen, but with care not to overlap
3075 // processor defined exceptions or interrupt vectors.
3076 #define T_SYSCALL       48      // system call
3077 #define T_DEFAULT      500      // catchall
3078 
3079 #define IRQ_OFFSET      32      // IRQ 0 corresponds to int IRQ_OFFSET
3080 
3081 #define IRQ_TIMER        0
3082 #define IRQ_KBD          1
3083 #define IRQ_IDE         14
3084 #define IRQ_IDE_2       15
3085 #define IRQ_ERROR       19
3086 #define IRQ_SPURIOUS    31
3087 
3088 
3089 
3090 
3091 
3092 
3093 
3094 
3095 
3096 
3097 
3098 
3099 
