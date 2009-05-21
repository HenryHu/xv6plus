10050 // init: The initial user-level program
10051 
10052 #include "types.h"
10053 #include "stat.h"
10054 #include "user.h"
10055 #include "fcntl.h"
10056 
10057 char *sh_args[] = { "sh", 0 };
10058 
10059 int
10060 main(void)
10061 {
10062   int pid, wpid;
10063 
10064   if(open("console", O_RDWR) < 0){
10065     mknod("console", 1, 1);
10066     open("console", O_RDWR);
10067   }
10068   dup(0);  // stdout
10069   dup(0);  // stderr
10070 
10071   for(;;){
10072     printf(1, "init: starting sh\n");
10073     pid = fork();
10074     if(pid < 0){
10075       printf(1, "init: fork failed\n");
10076       exit();
10077     }
10078     if(pid == 0){
10079       exec("sh", sh_args);
10080       printf(1, "init: exec sh failed\n");
10081       exit();
10082     }
10083     while((wpid=wait()) >= 0 && wpid != pid)
10084     {
10085 #if 0
10086       printf(1, "zombie!\n");
10087 #endif
10088     }
10089   }
10090 }
10091 
10092 
10093 
10094 
10095 
10096 
10097 
10098 
10099 
