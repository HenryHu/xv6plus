10150 // Shell.
10151 
10152 #include "types.h"
10153 #include "user.h"
10154 #include "fcntl.h"
10155 
10156 // Parsed command representation
10157 #define EXEC  1
10158 #define REDIR 2
10159 #define PIPE  3
10160 #define LIST  4
10161 #define BACK  5
10162 
10163 #define MAXARGS 10
10164 
10165 struct cmd {
10166   int type;
10167 };
10168 
10169 struct execcmd {
10170   int type;
10171   char *argv[MAXARGS];
10172   char *eargv[MAXARGS];
10173 };
10174 
10175 struct redircmd {
10176   int type;
10177   struct cmd *cmd;
10178   char *file;
10179   char *efile;
10180   int mode;
10181   int fd;
10182 };
10183 
10184 struct pipecmd {
10185   int type;
10186   struct cmd *left;
10187   struct cmd *right;
10188 };
10189 
10190 struct listcmd {
10191   int type;
10192   struct cmd *left;
10193   struct cmd *right;
10194 };
10195 
10196 struct backcmd {
10197   int type;
10198   struct cmd *cmd;
10199 };
10200 int fork1(void);  // Fork but panics on failure.
10201 void panic(char*);
10202 struct cmd *parsecmd(char*);
10203 
10204 // Execute cmd.  Never returns.
10205 void
10206 runcmd(struct cmd *cmd)
10207 {
10208   int p[2];
10209   struct backcmd *bcmd;
10210   struct execcmd *ecmd;
10211   struct listcmd *lcmd;
10212   struct pipecmd *pcmd;
10213   struct redircmd *rcmd;
10214 
10215   if(cmd == 0)
10216     exit();
10217 
10218   switch(cmd->type){
10219   default:
10220     panic("runcmd");
10221 
10222   case EXEC:
10223     ecmd = (struct execcmd*)cmd;
10224     if(ecmd->argv[0] == 0)
10225       exit();
10226     exec(ecmd->argv[0], ecmd->argv);
10227     printf(2, "exec %s failed\n", ecmd->argv[0]);
10228     break;
10229 
10230   case REDIR:
10231     rcmd = (struct redircmd*)cmd;
10232     close(rcmd->fd);
10233     if(open(rcmd->file, rcmd->mode) < 0){
10234       printf(2, "open %s failed\n", rcmd->file);
10235       exit();
10236     }
10237     runcmd(rcmd->cmd);
10238     break;
10239 
10240   case LIST:
10241     lcmd = (struct listcmd*)cmd;
10242     if(fork1() == 0)
10243       runcmd(lcmd->left);
10244     wait();
10245     runcmd(lcmd->right);
10246     break;
10247 
10248 
10249 
10250   case PIPE:
10251     pcmd = (struct pipecmd*)cmd;
10252     if(pipe(p) < 0)
10253       panic("pipe");
10254     if(fork1() == 0){
10255       close(1);
10256       dup(p[1]);
10257       close(p[0]);
10258       close(p[1]);
10259       runcmd(pcmd->left);
10260     }
10261     if(fork1() == 0){
10262       close(0);
10263       dup(p[0]);
10264       close(p[0]);
10265       close(p[1]);
10266       runcmd(pcmd->right);
10267     }
10268     close(p[0]);
10269     close(p[1]);
10270     wait();
10271     wait();
10272     break;
10273 
10274   case BACK:
10275     bcmd = (struct backcmd*)cmd;
10276     if(fork1() == 0)
10277       runcmd(bcmd->cmd);
10278     break;
10279   }
10280   exit();
10281 }
10282 
10283 int
10284 getcmd(char *buf, int nbuf)
10285 {
10286   printf(2, "$ ");
10287   memset(buf, 0, nbuf);
10288   gets(buf, nbuf);
10289   if(buf[0] == 0) // EOF
10290     return -1;
10291   return 0;
10292 }
10293 
10294 
10295 
10296 
10297 
10298 
10299 
10300 int
10301 main(void)
10302 {
10303   static char buf[100];
10304   int fd;
10305 
10306   // Assumes three file descriptors open.
10307   while((fd = open("console", O_RDWR)) >= 0){
10308     if(fd >= 3){
10309       close(fd);
10310       break;
10311     }
10312   }
10313 
10314   // Read and run input commands.
10315   while(getcmd(buf, sizeof(buf)) >= 0){
10316     if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
10317       // Clumsy but will have to do for now.
10318       // Chdir has no effect on the parent if run in the child.
10319       buf[strlen(buf)-1] = 0;  // chop \n
10320       if(chdir(buf+3) < 0)
10321         printf(2, "cannot cd %s\n", buf+3);
10322       continue;
10323     }
10324     if(fork1() == 0)
10325       runcmd(parsecmd(buf));
10326     wait();
10327   }
10328   exit();
10329 }
10330 
10331 void
10332 panic(char *s)
10333 {
10334   printf(2, "%s\n", s);
10335   exit();
10336 }
10337 
10338 int
10339 fork1(void)
10340 {
10341   int pid;
10342 
10343   pid = fork();
10344   if(pid == -1)
10345     panic("fork");
10346   return pid;
10347 }
10348 
10349 
10350 // Constructors
10351 
10352 struct cmd*
10353 execcmd(void)
10354 {
10355   struct execcmd *cmd;
10356 
10357   cmd = malloc(sizeof(*cmd));
10358   memset(cmd, 0, sizeof(*cmd));
10359   cmd->type = EXEC;
10360   return (struct cmd*)cmd;
10361 }
10362 
10363 struct cmd*
10364 redircmd(struct cmd *subcmd, char *file, char *efile, int mode, int fd)
10365 {
10366   struct redircmd *cmd;
10367 
10368   cmd = malloc(sizeof(*cmd));
10369   memset(cmd, 0, sizeof(*cmd));
10370   cmd->type = REDIR;
10371   cmd->cmd = subcmd;
10372   cmd->file = file;
10373   cmd->efile = efile;
10374   cmd->mode = mode;
10375   cmd->fd = fd;
10376   return (struct cmd*)cmd;
10377 }
10378 
10379 struct cmd*
10380 pipecmd(struct cmd *left, struct cmd *right)
10381 {
10382   struct pipecmd *cmd;
10383 
10384   cmd = malloc(sizeof(*cmd));
10385   memset(cmd, 0, sizeof(*cmd));
10386   cmd->type = PIPE;
10387   cmd->left = left;
10388   cmd->right = right;
10389   return (struct cmd*)cmd;
10390 }
10391 
10392 
10393 
10394 
10395 
10396 
10397 
10398 
10399 
10400 struct cmd*
10401 listcmd(struct cmd *left, struct cmd *right)
10402 {
10403   struct listcmd *cmd;
10404 
10405   cmd = malloc(sizeof(*cmd));
10406   memset(cmd, 0, sizeof(*cmd));
10407   cmd->type = LIST;
10408   cmd->left = left;
10409   cmd->right = right;
10410   return (struct cmd*)cmd;
10411 }
10412 
10413 struct cmd*
10414 backcmd(struct cmd *subcmd)
10415 {
10416   struct backcmd *cmd;
10417 
10418   cmd = malloc(sizeof(*cmd));
10419   memset(cmd, 0, sizeof(*cmd));
10420   cmd->type = BACK;
10421   cmd->cmd = subcmd;
10422   return (struct cmd*)cmd;
10423 }
10424 // Parsing
10425 
10426 char whitespace[] = " \t\r\n\v";
10427 char symbols[] = "<|>&;()";
10428 
10429 int
10430 gettoken(char **ps, char *es, char **q, char **eq)
10431 {
10432   char *s;
10433   int ret;
10434 
10435   s = *ps;
10436   while(s < es && strchr(whitespace, *s))
10437     s++;
10438   if(q)
10439     *q = s;
10440   ret = *s;
10441   switch(*s){
10442   case 0:
10443     break;
10444   case '|':
10445   case '(':
10446   case ')':
10447   case ';':
10448   case '&':
10449   case '<':
10450     s++;
10451     break;
10452   case '>':
10453     s++;
10454     if(*s == '>'){
10455       ret = '+';
10456       s++;
10457     }
10458     break;
10459   default:
10460     ret = 'a';
10461     while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
10462       s++;
10463     break;
10464   }
10465   if(eq)
10466     *eq = s;
10467 
10468   while(s < es && strchr(whitespace, *s))
10469     s++;
10470   *ps = s;
10471   return ret;
10472 }
10473 
10474 int
10475 peek(char **ps, char *es, char *toks)
10476 {
10477   char *s;
10478 
10479   s = *ps;
10480   while(s < es && strchr(whitespace, *s))
10481     s++;
10482   *ps = s;
10483   return *s && strchr(toks, *s);
10484 }
10485 
10486 
10487 
10488 
10489 
10490 
10491 
10492 
10493 
10494 
10495 
10496 
10497 
10498 
10499 
10500 struct cmd *parseline(char**, char*);
10501 struct cmd *parsepipe(char**, char*);
10502 struct cmd *parseexec(char**, char*);
10503 struct cmd *nulterminate(struct cmd*);
10504 
10505 struct cmd*
10506 parsecmd(char *s)
10507 {
10508   char *es;
10509   struct cmd *cmd;
10510 
10511   es = s + strlen(s);
10512   cmd = parseline(&s, es);
10513   peek(&s, es, "");
10514   if(s != es){
10515     printf(2, "leftovers: %s\n", s);
10516     panic("syntax");
10517   }
10518   nulterminate(cmd);
10519   return cmd;
10520 }
10521 
10522 struct cmd*
10523 parseline(char **ps, char *es)
10524 {
10525   struct cmd *cmd;
10526 
10527   cmd = parsepipe(ps, es);
10528   while(peek(ps, es, "&")){
10529     gettoken(ps, es, 0, 0);
10530     cmd = backcmd(cmd);
10531   }
10532   if(peek(ps, es, ";")){
10533     gettoken(ps, es, 0, 0);
10534     cmd = listcmd(cmd, parseline(ps, es));
10535   }
10536   return cmd;
10537 }
10538 
10539 
10540 
10541 
10542 
10543 
10544 
10545 
10546 
10547 
10548 
10549 
10550 struct cmd*
10551 parsepipe(char **ps, char *es)
10552 {
10553   struct cmd *cmd;
10554 
10555   cmd = parseexec(ps, es);
10556   if(peek(ps, es, "|")){
10557     gettoken(ps, es, 0, 0);
10558     cmd = pipecmd(cmd, parsepipe(ps, es));
10559   }
10560   return cmd;
10561 }
10562 
10563 struct cmd*
10564 parseredirs(struct cmd *cmd, char **ps, char *es)
10565 {
10566   int tok;
10567   char *q, *eq;
10568 
10569   while(peek(ps, es, "<>")){
10570     tok = gettoken(ps, es, 0, 0);
10571     if(gettoken(ps, es, &q, &eq) != 'a')
10572       panic("missing file for redirection");
10573     switch(tok){
10574     case '<':
10575       cmd = redircmd(cmd, q, eq, O_RDONLY, 0);
10576       break;
10577     case '>':
10578       cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
10579       break;
10580     case '+':  // >>
10581       cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
10582       break;
10583     }
10584   }
10585   return cmd;
10586 }
10587 
10588 
10589 
10590 
10591 
10592 
10593 
10594 
10595 
10596 
10597 
10598 
10599 
10600 struct cmd*
10601 parseblock(char **ps, char *es)
10602 {
10603   struct cmd *cmd;
10604 
10605   if(!peek(ps, es, "("))
10606     panic("parseblock");
10607   gettoken(ps, es, 0, 0);
10608   cmd = parseline(ps, es);
10609   if(!peek(ps, es, ")"))
10610     panic("syntax - missing )");
10611   gettoken(ps, es, 0, 0);
10612   cmd = parseredirs(cmd, ps, es);
10613   return cmd;
10614 }
10615 
10616 struct cmd*
10617 parseexec(char **ps, char *es)
10618 {
10619   char *q, *eq;
10620   int tok, argc;
10621   struct execcmd *cmd;
10622   struct cmd *ret;
10623 
10624   if(peek(ps, es, "("))
10625     return parseblock(ps, es);
10626 
10627   ret = execcmd();
10628   cmd = (struct execcmd*)ret;
10629 
10630   argc = 0;
10631   ret = parseredirs(ret, ps, es);
10632   while(!peek(ps, es, "|)&;")){
10633     if((tok=gettoken(ps, es, &q, &eq)) == 0)
10634       break;
10635     if(tok != 'a')
10636       panic("syntax");
10637     cmd->argv[argc] = q;
10638     cmd->eargv[argc] = eq;
10639     argc++;
10640     if(argc >= MAXARGS)
10641       panic("too many args");
10642     ret = parseredirs(ret, ps, es);
10643   }
10644   cmd->argv[argc] = 0;
10645   cmd->eargv[argc] = 0;
10646   return ret;
10647 }
10648 
10649 
10650 // NUL-terminate all the counted strings.
10651 struct cmd*
10652 nulterminate(struct cmd *cmd)
10653 {
10654   int i;
10655   struct backcmd *bcmd;
10656   struct execcmd *ecmd;
10657   struct listcmd *lcmd;
10658   struct pipecmd *pcmd;
10659   struct redircmd *rcmd;
10660 
10661   if(cmd == 0)
10662     return 0;
10663 
10664   switch(cmd->type){
10665   case EXEC:
10666     ecmd = (struct execcmd*)cmd;
10667     for(i=0; ecmd->argv[i]; i++)
10668       *ecmd->eargv[i] = 0;
10669     break;
10670 
10671   case REDIR:
10672     rcmd = (struct redircmd*)cmd;
10673     nulterminate(rcmd->cmd);
10674     *rcmd->efile = 0;
10675     break;
10676 
10677   case PIPE:
10678     pcmd = (struct pipecmd*)cmd;
10679     nulterminate(pcmd->left);
10680     nulterminate(pcmd->right);
10681     break;
10682 
10683   case LIST:
10684     lcmd = (struct listcmd*)cmd;
10685     nulterminate(lcmd->left);
10686     nulterminate(lcmd->right);
10687     break;
10688 
10689   case BACK:
10690     bcmd = (struct backcmd*)cmd;
10691     nulterminate(bcmd->cmd);
10692     break;
10693   }
10694   return cmd;
10695 }
10696 
10697 
10698 
10699 
