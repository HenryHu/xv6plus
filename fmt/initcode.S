10000 # Initial process execs /init.
10001 
10002 #include "syscall.h"
10003 #include "traps.h"
10004 
10005 # exec(init, argv)
10006 .globl start
10007 start:
10008   pushl $argv
10009   pushl $init
10010   pushl $0
10011   movl $SYS_exec, %eax
10012   int $T_SYSCALL
10013 
10014 # for(;;) exit();
10015 exit:
10016   movl $SYS_exit, %eax
10017   int $T_SYSCALL
10018   jmp exit
10019 
10020 # char init[] = "/init\0";
10021 init:
10022   .string "/init\0"
10023 
10024 # char *argv[] = { init, 0 };
10025 .p2align 2
10026 argv:
10027   .long init
10028   .long 0
10029 
10030 
10031 
10032 
10033 
10034 
10035 
10036 
10037 
10038 
10039 
10040 
10041 
10042 
10043 
10044 
10045 
10046 
10047 
10048 
10049 
