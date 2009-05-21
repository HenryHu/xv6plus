
_sh:     file format elf32-i386-freebsd

Disassembly of section .text:

00000000 <runcmd>:

// Execute cmd.  Never returns.
void
runcmd(struct cmd *cmd)
{
       0:	55                   	push   %ebp
       1:	89 e5                	mov    %esp,%ebp
       3:	83 ec 38             	sub    $0x38,%esp
  int p[2];
  struct backcmd *bcmd;
  struct execcmd *ecmd;
  struct listcmd *lcmd;
  struct pipecmd *pcmd;
  struct redircmd *rcmd;

  if(cmd == 0)
       6:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
       a:	75 05                	jne    11 <runcmd+0x11>
    exit();
       c:	e8 23 10 00 00       	call   1034 <exit>
  
  switch(cmd->type){
      11:	8b 45 08             	mov    0x8(%ebp),%eax
      14:	8b 00                	mov    (%eax),%eax
      16:	89 45 dc             	mov    %eax,0xffffffdc(%ebp)
      19:	83 7d dc 05          	cmpl   $0x5,0xffffffdc(%ebp)
      1d:	77 0c                	ja     2b <runcmd+0x2b>
      1f:	8b 55 dc             	mov    0xffffffdc(%ebp),%edx
      22:	8b 04 95 f0 1d 00 00 	mov    0x1df0(,%edx,4),%eax
      29:	ff e0                	jmp    *%eax
  default:
    panic("runcmd");
      2b:	c7 04 24 c4 1d 00 00 	movl   $0x1dc4,(%esp)
      32:	e8 49 03 00 00       	call   380 <panic>

  case EXEC:
    ecmd = (struct execcmd*)cmd;
      37:	8b 45 08             	mov    0x8(%ebp),%eax
      3a:	89 45 f0             	mov    %eax,0xfffffff0(%ebp)
    if(ecmd->argv[0] == 0)
      3d:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
      40:	8b 40 04             	mov    0x4(%eax),%eax
      43:	85 c0                	test   %eax,%eax
      45:	75 05                	jne    4c <runcmd+0x4c>
      exit();
      47:	e8 e8 0f 00 00       	call   1034 <exit>
    exec(ecmd->argv[0], ecmd->argv);
      4c:	8b 55 f0             	mov    0xfffffff0(%ebp),%edx
      4f:	83 c2 04             	add    $0x4,%edx
      52:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
      55:	8b 40 04             	mov    0x4(%eax),%eax
      58:	89 54 24 04          	mov    %edx,0x4(%esp)
      5c:	89 04 24             	mov    %eax,(%esp)
      5f:	e8 08 10 00 00       	call   106c <exec>
    printf(2, "exec %s failed\n", ecmd->argv[0]);
      64:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
      67:	8b 40 04             	mov    0x4(%eax),%eax
      6a:	89 44 24 08          	mov    %eax,0x8(%esp)
      6e:	c7 44 24 04 cb 1d 00 	movl   $0x1dcb,0x4(%esp)
      75:	00 
      76:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
      7d:	e8 be 11 00 00       	call   1240 <printf>
    break;
      82:	e9 83 01 00 00       	jmp    20a <runcmd+0x20a>

  case REDIR:
    rcmd = (struct redircmd*)cmd;
      87:	8b 45 08             	mov    0x8(%ebp),%eax
      8a:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
    close(rcmd->fd);
      8d:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
      90:	8b 40 14             	mov    0x14(%eax),%eax
      93:	89 04 24             	mov    %eax,(%esp)
      96:	e8 c1 0f 00 00       	call   105c <close>
    if(open(rcmd->file, rcmd->mode) < 0){
      9b:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
      9e:	8b 50 10             	mov    0x10(%eax),%edx
      a1:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
      a4:	8b 40 08             	mov    0x8(%eax),%eax
      a7:	89 54 24 04          	mov    %edx,0x4(%esp)
      ab:	89 04 24             	mov    %eax,(%esp)
      ae:	e8 c1 0f 00 00       	call   1074 <open>
      b3:	85 c0                	test   %eax,%eax
      b5:	79 23                	jns    da <runcmd+0xda>
      printf(2, "open %s failed\n", rcmd->file);
      b7:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
      ba:	8b 40 08             	mov    0x8(%eax),%eax
      bd:	89 44 24 08          	mov    %eax,0x8(%esp)
      c1:	c7 44 24 04 db 1d 00 	movl   $0x1ddb,0x4(%esp)
      c8:	00 
      c9:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
      d0:	e8 6b 11 00 00       	call   1240 <printf>
      exit();
      d5:	e8 5a 0f 00 00       	call   1034 <exit>
    }
    runcmd(rcmd->cmd);
      da:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
      dd:	8b 40 04             	mov    0x4(%eax),%eax
      e0:	89 04 24             	mov    %eax,(%esp)
      e3:	e8 18 ff ff ff       	call   0 <runcmd>
    break;
      e8:	e9 1d 01 00 00       	jmp    20a <runcmd+0x20a>

  case LIST:
    lcmd = (struct listcmd*)cmd;
      ed:	8b 45 08             	mov    0x8(%ebp),%eax
      f0:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
    if(fork1() == 0)
      f3:	e8 b8 02 00 00       	call   3b0 <fork1>
      f8:	85 c0                	test   %eax,%eax
      fa:	75 0e                	jne    10a <runcmd+0x10a>
      runcmd(lcmd->left);
      fc:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
      ff:	8b 40 04             	mov    0x4(%eax),%eax
     102:	89 04 24             	mov    %eax,(%esp)
     105:	e8 f6 fe ff ff       	call   0 <runcmd>
    wait();
     10a:	e8 2d 0f 00 00       	call   103c <wait>
    runcmd(lcmd->right);
     10f:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     112:	8b 40 08             	mov    0x8(%eax),%eax
     115:	89 04 24             	mov    %eax,(%esp)
     118:	e8 e3 fe ff ff       	call   0 <runcmd>
    break;
     11d:	e9 e8 00 00 00       	jmp    20a <runcmd+0x20a>

  case PIPE:
    pcmd = (struct pipecmd*)cmd;
     122:	8b 45 08             	mov    0x8(%ebp),%eax
     125:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
    if(pipe(p) < 0)
     128:	8d 45 e4             	lea    0xffffffe4(%ebp),%eax
     12b:	89 04 24             	mov    %eax,(%esp)
     12e:	e8 11 0f 00 00       	call   1044 <pipe>
     133:	85 c0                	test   %eax,%eax
     135:	79 0c                	jns    143 <runcmd+0x143>
      panic("pipe");
     137:	c7 04 24 eb 1d 00 00 	movl   $0x1deb,(%esp)
     13e:	e8 3d 02 00 00       	call   380 <panic>
    if(fork1() == 0){
     143:	e8 68 02 00 00       	call   3b0 <fork1>
     148:	85 c0                	test   %eax,%eax
     14a:	75 3b                	jne    187 <runcmd+0x187>
      close(1);
     14c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     153:	e8 04 0f 00 00       	call   105c <close>
      dup(p[1]);
     158:	8b 45 e8             	mov    0xffffffe8(%ebp),%eax
     15b:	89 04 24             	mov    %eax,(%esp)
     15e:	e8 49 0f 00 00       	call   10ac <dup>
      close(p[0]);
     163:	8b 45 e4             	mov    0xffffffe4(%ebp),%eax
     166:	89 04 24             	mov    %eax,(%esp)
     169:	e8 ee 0e 00 00       	call   105c <close>
      close(p[1]);
     16e:	8b 45 e8             	mov    0xffffffe8(%ebp),%eax
     171:	89 04 24             	mov    %eax,(%esp)
     174:	e8 e3 0e 00 00       	call   105c <close>
      runcmd(pcmd->left);
     179:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     17c:	8b 40 04             	mov    0x4(%eax),%eax
     17f:	89 04 24             	mov    %eax,(%esp)
     182:	e8 79 fe ff ff       	call   0 <runcmd>
    }
    if(fork1() == 0){
     187:	e8 24 02 00 00       	call   3b0 <fork1>
     18c:	85 c0                	test   %eax,%eax
     18e:	75 3b                	jne    1cb <runcmd+0x1cb>
      close(0);
     190:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     197:	e8 c0 0e 00 00       	call   105c <close>
      dup(p[0]);
     19c:	8b 45 e4             	mov    0xffffffe4(%ebp),%eax
     19f:	89 04 24             	mov    %eax,(%esp)
     1a2:	e8 05 0f 00 00       	call   10ac <dup>
      close(p[0]);
     1a7:	8b 45 e4             	mov    0xffffffe4(%ebp),%eax
     1aa:	89 04 24             	mov    %eax,(%esp)
     1ad:	e8 aa 0e 00 00       	call   105c <close>
      close(p[1]);
     1b2:	8b 45 e8             	mov    0xffffffe8(%ebp),%eax
     1b5:	89 04 24             	mov    %eax,(%esp)
     1b8:	e8 9f 0e 00 00       	call   105c <close>
      runcmd(pcmd->right);
     1bd:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     1c0:	8b 40 08             	mov    0x8(%eax),%eax
     1c3:	89 04 24             	mov    %eax,(%esp)
     1c6:	e8 35 fe ff ff       	call   0 <runcmd>
    }
    close(p[0]);
     1cb:	8b 45 e4             	mov    0xffffffe4(%ebp),%eax
     1ce:	89 04 24             	mov    %eax,(%esp)
     1d1:	e8 86 0e 00 00       	call   105c <close>
    close(p[1]);
     1d6:	8b 45 e8             	mov    0xffffffe8(%ebp),%eax
     1d9:	89 04 24             	mov    %eax,(%esp)
     1dc:	e8 7b 0e 00 00       	call   105c <close>
    wait();
     1e1:	e8 56 0e 00 00       	call   103c <wait>
    wait();
     1e6:	e8 51 0e 00 00       	call   103c <wait>
    break;
     1eb:	eb 1d                	jmp    20a <runcmd+0x20a>
    
  case BACK:
    bcmd = (struct backcmd*)cmd;
     1ed:	8b 45 08             	mov    0x8(%ebp),%eax
     1f0:	89 45 ec             	mov    %eax,0xffffffec(%ebp)
    if(fork1() == 0)
     1f3:	e8 b8 01 00 00       	call   3b0 <fork1>
     1f8:	85 c0                	test   %eax,%eax
     1fa:	75 0e                	jne    20a <runcmd+0x20a>
      runcmd(bcmd->cmd);
     1fc:	8b 45 ec             	mov    0xffffffec(%ebp),%eax
     1ff:	8b 40 04             	mov    0x4(%eax),%eax
     202:	89 04 24             	mov    %eax,(%esp)
     205:	e8 f6 fd ff ff       	call   0 <runcmd>
    break;
  }
  exit();
     20a:	e8 25 0e 00 00       	call   1034 <exit>
     20f:	90                   	nop    

00000210 <getcmd>:
}

int
getcmd(char *buf, int nbuf)
{
     210:	55                   	push   %ebp
     211:	89 e5                	mov    %esp,%ebp
     213:	83 ec 18             	sub    $0x18,%esp
  printf(2, "$ ");
     216:	c7 44 24 04 08 1e 00 	movl   $0x1e08,0x4(%esp)
     21d:	00 
     21e:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     225:	e8 16 10 00 00       	call   1240 <printf>
  memset(buf, 0, nbuf);
     22a:	8b 45 0c             	mov    0xc(%ebp),%eax
     22d:	89 44 24 08          	mov    %eax,0x8(%esp)
     231:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     238:	00 
     239:	8b 45 08             	mov    0x8(%ebp),%eax
     23c:	89 04 24             	mov    %eax,(%esp)
     23f:	e8 1c 0c 00 00       	call   e60 <memset>
  gets(buf, nbuf);
     244:	8b 45 0c             	mov    0xc(%ebp),%eax
     247:	89 44 24 04          	mov    %eax,0x4(%esp)
     24b:	8b 45 08             	mov    0x8(%ebp),%eax
     24e:	89 04 24             	mov    %eax,(%esp)
     251:	e8 7a 0c 00 00       	call   ed0 <gets>
  if(buf[0] == 0) // EOF
     256:	8b 45 08             	mov    0x8(%ebp),%eax
     259:	0f b6 00             	movzbl (%eax),%eax
     25c:	84 c0                	test   %al,%al
     25e:	75 09                	jne    269 <getcmd+0x59>
    return -1;
     260:	c7 45 fc ff ff ff ff 	movl   $0xffffffff,0xfffffffc(%ebp)
     267:	eb 07                	jmp    270 <getcmd+0x60>
  return 0;
     269:	c7 45 fc 00 00 00 00 	movl   $0x0,0xfffffffc(%ebp)
     270:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
}
     273:	c9                   	leave  
     274:	c3                   	ret    
     275:	8d 74 26 00          	lea    0x0(%esi),%esi
     279:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00000280 <main>:

int
main(void)
{
     280:	8d 4c 24 04          	lea    0x4(%esp),%ecx
     284:	83 e4 f0             	and    $0xfffffff0,%esp
     287:	ff 71 fc             	pushl  0xfffffffc(%ecx)
     28a:	55                   	push   %ebp
     28b:	89 e5                	mov    %esp,%ebp
     28d:	51                   	push   %ecx
     28e:	83 ec 24             	sub    $0x24,%esp
  static char buf[100];
  int fd;
  
  // Assumes three file descriptors open.
  while((fd = open("console", O_RDWR)) >= 0){
     291:	eb 16                	jmp    2a9 <main+0x29>
    if(fd >= 3){
     293:	83 7d f8 02          	cmpl   $0x2,0xfffffff8(%ebp)
     297:	7e 10                	jle    2a9 <main+0x29>
      close(fd);
     299:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     29c:	89 04 24             	mov    %eax,(%esp)
     29f:	e8 b8 0d 00 00       	call   105c <close>
      break;
     2a4:	e9 ab 00 00 00       	jmp    354 <main+0xd4>
     2a9:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
     2b0:	00 
     2b1:	c7 04 24 0b 1e 00 00 	movl   $0x1e0b,(%esp)
     2b8:	e8 b7 0d 00 00       	call   1074 <open>
     2bd:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
     2c0:	83 7d f8 00          	cmpl   $0x0,0xfffffff8(%ebp)
     2c4:	79 cd                	jns    293 <main+0x13>
    }
  }
  
  // Read and run input commands.
  while(getcmd(buf, sizeof(buf)) >= 0){
     2c6:	e9 89 00 00 00       	jmp    354 <main+0xd4>
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
     2cb:	0f b6 05 00 1f 00 00 	movzbl 0x1f00,%eax
     2d2:	3c 63                	cmp    $0x63,%al
     2d4:	75 5c                	jne    332 <main+0xb2>
     2d6:	0f b6 05 01 1f 00 00 	movzbl 0x1f01,%eax
     2dd:	3c 64                	cmp    $0x64,%al
     2df:	75 51                	jne    332 <main+0xb2>
     2e1:	0f b6 05 02 1f 00 00 	movzbl 0x1f02,%eax
     2e8:	3c 20                	cmp    $0x20,%al
     2ea:	75 46                	jne    332 <main+0xb2>
      // Clumsy but will have to do for now.
      // Chdir has no effect on the parent if run in the child.
      buf[strlen(buf)-1] = 0;  // chop \n
     2ec:	c7 04 24 00 1f 00 00 	movl   $0x1f00,(%esp)
     2f3:	e8 38 0b 00 00       	call   e30 <strlen>
     2f8:	83 e8 01             	sub    $0x1,%eax
     2fb:	c6 80 00 1f 00 00 00 	movb   $0x0,0x1f00(%eax)
      if(chdir(buf+3) < 0)
     302:	b8 03 1f 00 00       	mov    $0x1f03,%eax
     307:	89 04 24             	mov    %eax,(%esp)
     30a:	e8 95 0d 00 00       	call   10a4 <chdir>
     30f:	85 c0                	test   %eax,%eax
     311:	79 41                	jns    354 <main+0xd4>
        printf(2, "cannot cd %s\n", buf+3);
     313:	b8 03 1f 00 00       	mov    $0x1f03,%eax
     318:	89 44 24 08          	mov    %eax,0x8(%esp)
     31c:	c7 44 24 04 13 1e 00 	movl   $0x1e13,0x4(%esp)
     323:	00 
     324:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     32b:	e8 10 0f 00 00       	call   1240 <printf>
      continue;
     330:	eb 22                	jmp    354 <main+0xd4>
    }
    if(fork1() == 0)
     332:	e8 79 00 00 00       	call   3b0 <fork1>
     337:	85 c0                	test   %eax,%eax
     339:	75 14                	jne    34f <main+0xcf>
      runcmd(parsecmd(buf));
     33b:	c7 04 24 00 1f 00 00 	movl   $0x1f00,(%esp)
     342:	e8 09 04 00 00       	call   750 <parsecmd>
     347:	89 04 24             	mov    %eax,(%esp)
     34a:	e8 b1 fc ff ff       	call   0 <runcmd>
    wait();
     34f:	e8 e8 0c 00 00       	call   103c <wait>
     354:	c7 44 24 04 64 00 00 	movl   $0x64,0x4(%esp)
     35b:	00 
     35c:	c7 04 24 00 1f 00 00 	movl   $0x1f00,(%esp)
     363:	e8 a8 fe ff ff       	call   210 <getcmd>
     368:	85 c0                	test   %eax,%eax
     36a:	0f 89 5b ff ff ff    	jns    2cb <main+0x4b>
  }
  exit();
     370:	e8 bf 0c 00 00       	call   1034 <exit>
     375:	8d 74 26 00          	lea    0x0(%esi),%esi
     379:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00000380 <panic>:
}

void
panic(char *s)
{
     380:	55                   	push   %ebp
     381:	89 e5                	mov    %esp,%ebp
     383:	83 ec 18             	sub    $0x18,%esp
  printf(2, "%s\n", s);
     386:	8b 45 08             	mov    0x8(%ebp),%eax
     389:	89 44 24 08          	mov    %eax,0x8(%esp)
     38d:	c7 44 24 04 21 1e 00 	movl   $0x1e21,0x4(%esp)
     394:	00 
     395:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     39c:	e8 9f 0e 00 00       	call   1240 <printf>
  exit();
     3a1:	e8 8e 0c 00 00       	call   1034 <exit>
     3a6:	8d 76 00             	lea    0x0(%esi),%esi
     3a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

000003b0 <fork1>:
}

int
fork1(void)
{
     3b0:	55                   	push   %ebp
     3b1:	89 e5                	mov    %esp,%ebp
     3b3:	83 ec 18             	sub    $0x18,%esp
  int pid;
  
  pid = fork();
     3b6:	e8 71 0c 00 00       	call   102c <fork>
     3bb:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
  if(pid == -1)
     3be:	83 7d fc ff          	cmpl   $0xffffffff,0xfffffffc(%ebp)
     3c2:	75 0c                	jne    3d0 <fork1+0x20>
    panic("fork");
     3c4:	c7 04 24 25 1e 00 00 	movl   $0x1e25,(%esp)
     3cb:	e8 b0 ff ff ff       	call   380 <panic>
  return pid;
     3d0:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
}
     3d3:	c9                   	leave  
     3d4:	c3                   	ret    
     3d5:	8d 74 26 00          	lea    0x0(%esi),%esi
     3d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

000003e0 <execcmd>:

// Constructors

struct cmd*
execcmd(void)
{
     3e0:	55                   	push   %ebp
     3e1:	89 e5                	mov    %esp,%ebp
     3e3:	83 ec 28             	sub    $0x28,%esp
  struct execcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     3e6:	c7 04 24 54 00 00 00 	movl   $0x54,(%esp)
     3ed:	e8 6e 11 00 00       	call   1560 <malloc>
     3f2:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
  memset(cmd, 0, sizeof(*cmd));
     3f5:	c7 44 24 08 54 00 00 	movl   $0x54,0x8(%esp)
     3fc:	00 
     3fd:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     404:	00 
     405:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     408:	89 04 24             	mov    %eax,(%esp)
     40b:	e8 50 0a 00 00       	call   e60 <memset>
  cmd->type = EXEC;
     410:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     413:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  return (struct cmd*)cmd;
     419:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
}
     41c:	c9                   	leave  
     41d:	c3                   	ret    
     41e:	89 f6                	mov    %esi,%esi

00000420 <redircmd>:

struct cmd*
redircmd(struct cmd *subcmd, char *file, char *efile, int mode, int fd)
{
     420:	55                   	push   %ebp
     421:	89 e5                	mov    %esp,%ebp
     423:	83 ec 28             	sub    $0x28,%esp
  struct redircmd *cmd;

  cmd = malloc(sizeof(*cmd));
     426:	c7 04 24 18 00 00 00 	movl   $0x18,(%esp)
     42d:	e8 2e 11 00 00       	call   1560 <malloc>
     432:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
  memset(cmd, 0, sizeof(*cmd));
     435:	c7 44 24 08 18 00 00 	movl   $0x18,0x8(%esp)
     43c:	00 
     43d:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     444:	00 
     445:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     448:	89 04 24             	mov    %eax,(%esp)
     44b:	e8 10 0a 00 00       	call   e60 <memset>
  cmd->type = REDIR;
     450:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     453:	c7 00 02 00 00 00    	movl   $0x2,(%eax)
  cmd->cmd = subcmd;
     459:	8b 55 fc             	mov    0xfffffffc(%ebp),%edx
     45c:	8b 45 08             	mov    0x8(%ebp),%eax
     45f:	89 42 04             	mov    %eax,0x4(%edx)
  cmd->file = file;
     462:	8b 55 fc             	mov    0xfffffffc(%ebp),%edx
     465:	8b 45 0c             	mov    0xc(%ebp),%eax
     468:	89 42 08             	mov    %eax,0x8(%edx)
  cmd->efile = efile;
     46b:	8b 55 fc             	mov    0xfffffffc(%ebp),%edx
     46e:	8b 45 10             	mov    0x10(%ebp),%eax
     471:	89 42 0c             	mov    %eax,0xc(%edx)
  cmd->mode = mode;
     474:	8b 55 fc             	mov    0xfffffffc(%ebp),%edx
     477:	8b 45 14             	mov    0x14(%ebp),%eax
     47a:	89 42 10             	mov    %eax,0x10(%edx)
  cmd->fd = fd;
     47d:	8b 55 fc             	mov    0xfffffffc(%ebp),%edx
     480:	8b 45 18             	mov    0x18(%ebp),%eax
     483:	89 42 14             	mov    %eax,0x14(%edx)
  return (struct cmd*)cmd;
     486:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
}
     489:	c9                   	leave  
     48a:	c3                   	ret    
     48b:	90                   	nop    
     48c:	8d 74 26 00          	lea    0x0(%esi),%esi

00000490 <pipecmd>:

struct cmd*
pipecmd(struct cmd *left, struct cmd *right)
{
     490:	55                   	push   %ebp
     491:	89 e5                	mov    %esp,%ebp
     493:	83 ec 28             	sub    $0x28,%esp
  struct pipecmd *cmd;

  cmd = malloc(sizeof(*cmd));
     496:	c7 04 24 0c 00 00 00 	movl   $0xc,(%esp)
     49d:	e8 be 10 00 00       	call   1560 <malloc>
     4a2:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
  memset(cmd, 0, sizeof(*cmd));
     4a5:	c7 44 24 08 0c 00 00 	movl   $0xc,0x8(%esp)
     4ac:	00 
     4ad:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     4b4:	00 
     4b5:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     4b8:	89 04 24             	mov    %eax,(%esp)
     4bb:	e8 a0 09 00 00       	call   e60 <memset>
  cmd->type = PIPE;
     4c0:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     4c3:	c7 00 03 00 00 00    	movl   $0x3,(%eax)
  cmd->left = left;
     4c9:	8b 55 fc             	mov    0xfffffffc(%ebp),%edx
     4cc:	8b 45 08             	mov    0x8(%ebp),%eax
     4cf:	89 42 04             	mov    %eax,0x4(%edx)
  cmd->right = right;
     4d2:	8b 55 fc             	mov    0xfffffffc(%ebp),%edx
     4d5:	8b 45 0c             	mov    0xc(%ebp),%eax
     4d8:	89 42 08             	mov    %eax,0x8(%edx)
  return (struct cmd*)cmd;
     4db:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
}
     4de:	c9                   	leave  
     4df:	c3                   	ret    

000004e0 <listcmd>:

struct cmd*
listcmd(struct cmd *left, struct cmd *right)
{
     4e0:	55                   	push   %ebp
     4e1:	89 e5                	mov    %esp,%ebp
     4e3:	83 ec 28             	sub    $0x28,%esp
  struct listcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     4e6:	c7 04 24 0c 00 00 00 	movl   $0xc,(%esp)
     4ed:	e8 6e 10 00 00       	call   1560 <malloc>
     4f2:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
  memset(cmd, 0, sizeof(*cmd));
     4f5:	c7 44 24 08 0c 00 00 	movl   $0xc,0x8(%esp)
     4fc:	00 
     4fd:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     504:	00 
     505:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     508:	89 04 24             	mov    %eax,(%esp)
     50b:	e8 50 09 00 00       	call   e60 <memset>
  cmd->type = LIST;
     510:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     513:	c7 00 04 00 00 00    	movl   $0x4,(%eax)
  cmd->left = left;
     519:	8b 55 fc             	mov    0xfffffffc(%ebp),%edx
     51c:	8b 45 08             	mov    0x8(%ebp),%eax
     51f:	89 42 04             	mov    %eax,0x4(%edx)
  cmd->right = right;
     522:	8b 55 fc             	mov    0xfffffffc(%ebp),%edx
     525:	8b 45 0c             	mov    0xc(%ebp),%eax
     528:	89 42 08             	mov    %eax,0x8(%edx)
  return (struct cmd*)cmd;
     52b:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
}
     52e:	c9                   	leave  
     52f:	c3                   	ret    

00000530 <backcmd>:

struct cmd*
backcmd(struct cmd *subcmd)
{
     530:	55                   	push   %ebp
     531:	89 e5                	mov    %esp,%ebp
     533:	83 ec 28             	sub    $0x28,%esp
  struct backcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     536:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
     53d:	e8 1e 10 00 00       	call   1560 <malloc>
     542:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
  memset(cmd, 0, sizeof(*cmd));
     545:	c7 44 24 08 08 00 00 	movl   $0x8,0x8(%esp)
     54c:	00 
     54d:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     554:	00 
     555:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     558:	89 04 24             	mov    %eax,(%esp)
     55b:	e8 00 09 00 00       	call   e60 <memset>
  cmd->type = BACK;
     560:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     563:	c7 00 05 00 00 00    	movl   $0x5,(%eax)
  cmd->cmd = subcmd;
     569:	8b 55 fc             	mov    0xfffffffc(%ebp),%edx
     56c:	8b 45 08             	mov    0x8(%ebp),%eax
     56f:	89 42 04             	mov    %eax,0x4(%edx)
  return (struct cmd*)cmd;
     572:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
}
     575:	c9                   	leave  
     576:	c3                   	ret    
     577:	89 f6                	mov    %esi,%esi
     579:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00000580 <gettoken>:
// Parsing

char whitespace[] = " \t\r\n\v";
char symbols[] = "<|>&;()";

int
gettoken(char **ps, char *es, char **q, char **eq)
{
     580:	55                   	push   %ebp
     581:	89 e5                	mov    %esp,%ebp
     583:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int ret;
  
  s = *ps;
     586:	8b 45 08             	mov    0x8(%ebp),%eax
     589:	8b 00                	mov    (%eax),%eax
     58b:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
  while(s < es && strchr(whitespace, *s))
     58e:	eb 04                	jmp    594 <gettoken+0x14>
    s++;
     590:	83 45 f8 01          	addl   $0x1,0xfffffff8(%ebp)
     594:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     597:	3b 45 0c             	cmp    0xc(%ebp),%eax
     59a:	73 1d                	jae    5b9 <gettoken+0x39>
     59c:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     59f:	0f b6 00             	movzbl (%eax),%eax
     5a2:	0f be c0             	movsbl %al,%eax
     5a5:	89 44 24 04          	mov    %eax,0x4(%esp)
     5a9:	c7 04 24 d0 1e 00 00 	movl   $0x1ed0,(%esp)
     5b0:	e8 db 08 00 00       	call   e90 <strchr>
     5b5:	85 c0                	test   %eax,%eax
     5b7:	75 d7                	jne    590 <gettoken+0x10>
  if(q)
     5b9:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     5bd:	74 08                	je     5c7 <gettoken+0x47>
    *q = s;
     5bf:	8b 55 10             	mov    0x10(%ebp),%edx
     5c2:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     5c5:	89 02                	mov    %eax,(%edx)
  ret = *s;
     5c7:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     5ca:	0f b6 00             	movzbl (%eax),%eax
     5cd:	0f be c0             	movsbl %al,%eax
     5d0:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
  switch(*s){
     5d3:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     5d6:	0f b6 00             	movzbl (%eax),%eax
     5d9:	0f be c0             	movsbl %al,%eax
     5dc:	89 45 ec             	mov    %eax,0xffffffec(%ebp)
     5df:	83 7d ec 3c          	cmpl   $0x3c,0xffffffec(%ebp)
     5e3:	7f 24                	jg     609 <gettoken+0x89>
     5e5:	83 7d ec 3b          	cmpl   $0x3b,0xffffffec(%ebp)
     5e9:	7d 2c                	jge    617 <gettoken+0x97>
     5eb:	83 7d ec 29          	cmpl   $0x29,0xffffffec(%ebp)
     5ef:	7f 47                	jg     638 <gettoken+0xb8>
     5f1:	83 7d ec 28          	cmpl   $0x28,0xffffffec(%ebp)
     5f5:	7d 20                	jge    617 <gettoken+0x97>
     5f7:	83 7d ec 00          	cmpl   $0x0,0xffffffec(%ebp)
     5fb:	0f 84 86 00 00 00    	je     687 <gettoken+0x107>
     601:	83 7d ec 26          	cmpl   $0x26,0xffffffec(%ebp)
     605:	74 10                	je     617 <gettoken+0x97>
     607:	eb 2f                	jmp    638 <gettoken+0xb8>
     609:	83 7d ec 3e          	cmpl   $0x3e,0xffffffec(%ebp)
     60d:	74 0e                	je     61d <gettoken+0x9d>
     60f:	83 7d ec 7c          	cmpl   $0x7c,0xffffffec(%ebp)
     613:	74 02                	je     617 <gettoken+0x97>
     615:	eb 21                	jmp    638 <gettoken+0xb8>
  case 0:
    break;
  case '|':
  case '(':
  case ')':
  case ';':
  case '&':
  case '<':
    s++;
     617:	83 45 f8 01          	addl   $0x1,0xfffffff8(%ebp)
    break;
     61b:	eb 6a                	jmp    687 <gettoken+0x107>
  case '>':
    s++;
     61d:	83 45 f8 01          	addl   $0x1,0xfffffff8(%ebp)
    if(*s == '>'){
     621:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     624:	0f b6 00             	movzbl (%eax),%eax
     627:	3c 3e                	cmp    $0x3e,%al
     629:	75 5c                	jne    687 <gettoken+0x107>
      ret = '+';
     62b:	c7 45 fc 2b 00 00 00 	movl   $0x2b,0xfffffffc(%ebp)
      s++;
     632:	83 45 f8 01          	addl   $0x1,0xfffffff8(%ebp)
    }
    break;
     636:	eb 4f                	jmp    687 <gettoken+0x107>
  default:
    ret = 'a';
     638:	c7 45 fc 61 00 00 00 	movl   $0x61,0xfffffffc(%ebp)
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     63f:	eb 04                	jmp    645 <gettoken+0xc5>
      s++;
     641:	83 45 f8 01          	addl   $0x1,0xfffffff8(%ebp)
     645:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     648:	3b 45 0c             	cmp    0xc(%ebp),%eax
     64b:	73 3a                	jae    687 <gettoken+0x107>
     64d:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     650:	0f b6 00             	movzbl (%eax),%eax
     653:	0f be c0             	movsbl %al,%eax
     656:	89 44 24 04          	mov    %eax,0x4(%esp)
     65a:	c7 04 24 d0 1e 00 00 	movl   $0x1ed0,(%esp)
     661:	e8 2a 08 00 00       	call   e90 <strchr>
     666:	85 c0                	test   %eax,%eax
     668:	75 1d                	jne    687 <gettoken+0x107>
     66a:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     66d:	0f b6 00             	movzbl (%eax),%eax
     670:	0f be c0             	movsbl %al,%eax
     673:	89 44 24 04          	mov    %eax,0x4(%esp)
     677:	c7 04 24 d6 1e 00 00 	movl   $0x1ed6,(%esp)
     67e:	e8 0d 08 00 00       	call   e90 <strchr>
     683:	85 c0                	test   %eax,%eax
     685:	74 ba                	je     641 <gettoken+0xc1>
    break;
  }
  if(eq)
     687:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
     68b:	74 0e                	je     69b <gettoken+0x11b>
    *eq = s;
     68d:	8b 55 14             	mov    0x14(%ebp),%edx
     690:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     693:	89 02                	mov    %eax,(%edx)
  
  while(s < es && strchr(whitespace, *s))
     695:	eb 04                	jmp    69b <gettoken+0x11b>
    s++;
     697:	83 45 f8 01          	addl   $0x1,0xfffffff8(%ebp)
     69b:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     69e:	3b 45 0c             	cmp    0xc(%ebp),%eax
     6a1:	73 1d                	jae    6c0 <gettoken+0x140>
     6a3:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     6a6:	0f b6 00             	movzbl (%eax),%eax
     6a9:	0f be c0             	movsbl %al,%eax
     6ac:	89 44 24 04          	mov    %eax,0x4(%esp)
     6b0:	c7 04 24 d0 1e 00 00 	movl   $0x1ed0,(%esp)
     6b7:	e8 d4 07 00 00       	call   e90 <strchr>
     6bc:	85 c0                	test   %eax,%eax
     6be:	75 d7                	jne    697 <gettoken+0x117>
  *ps = s;
     6c0:	8b 55 08             	mov    0x8(%ebp),%edx
     6c3:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     6c6:	89 02                	mov    %eax,(%edx)
  return ret;
     6c8:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
}
     6cb:	c9                   	leave  
     6cc:	c3                   	ret    
     6cd:	8d 76 00             	lea    0x0(%esi),%esi

000006d0 <peek>:

int
peek(char **ps, char *es, char *toks)
{
     6d0:	55                   	push   %ebp
     6d1:	89 e5                	mov    %esp,%ebp
     6d3:	83 ec 28             	sub    $0x28,%esp
  char *s;
  
  s = *ps;
     6d6:	8b 45 08             	mov    0x8(%ebp),%eax
     6d9:	8b 00                	mov    (%eax),%eax
     6db:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
  while(s < es && strchr(whitespace, *s))
     6de:	eb 04                	jmp    6e4 <peek+0x14>
    s++;
     6e0:	83 45 fc 01          	addl   $0x1,0xfffffffc(%ebp)
     6e4:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     6e7:	3b 45 0c             	cmp    0xc(%ebp),%eax
     6ea:	73 1d                	jae    709 <peek+0x39>
     6ec:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     6ef:	0f b6 00             	movzbl (%eax),%eax
     6f2:	0f be c0             	movsbl %al,%eax
     6f5:	89 44 24 04          	mov    %eax,0x4(%esp)
     6f9:	c7 04 24 d0 1e 00 00 	movl   $0x1ed0,(%esp)
     700:	e8 8b 07 00 00       	call   e90 <strchr>
     705:	85 c0                	test   %eax,%eax
     707:	75 d7                	jne    6e0 <peek+0x10>
  *ps = s;
     709:	8b 55 08             	mov    0x8(%ebp),%edx
     70c:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     70f:	89 02                	mov    %eax,(%edx)
  return *s && strchr(toks, *s);
     711:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     714:	0f b6 00             	movzbl (%eax),%eax
     717:	84 c0                	test   %al,%al
     719:	74 25                	je     740 <peek+0x70>
     71b:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     71e:	0f b6 00             	movzbl (%eax),%eax
     721:	0f be c0             	movsbl %al,%eax
     724:	89 44 24 04          	mov    %eax,0x4(%esp)
     728:	8b 45 10             	mov    0x10(%ebp),%eax
     72b:	89 04 24             	mov    %eax,(%esp)
     72e:	e8 5d 07 00 00       	call   e90 <strchr>
     733:	85 c0                	test   %eax,%eax
     735:	74 09                	je     740 <peek+0x70>
     737:	c7 45 ec 01 00 00 00 	movl   $0x1,0xffffffec(%ebp)
     73e:	eb 07                	jmp    747 <peek+0x77>
     740:	c7 45 ec 00 00 00 00 	movl   $0x0,0xffffffec(%ebp)
     747:	8b 45 ec             	mov    0xffffffec(%ebp),%eax
}
     74a:	c9                   	leave  
     74b:	c3                   	ret    
     74c:	8d 74 26 00          	lea    0x0(%esi),%esi

00000750 <parsecmd>:

struct cmd *parseline(char**, char*);
struct cmd *parsepipe(char**, char*);
struct cmd *parseexec(char**, char*);
struct cmd *nulterminate(struct cmd*);

struct cmd*
parsecmd(char *s)
{
     750:	55                   	push   %ebp
     751:	89 e5                	mov    %esp,%ebp
     753:	83 ec 28             	sub    $0x28,%esp
  char *es;
  struct cmd *cmd;
  
  es = s + strlen(s);
     756:	8b 45 08             	mov    0x8(%ebp),%eax
     759:	89 04 24             	mov    %eax,(%esp)
     75c:	e8 cf 06 00 00       	call   e30 <strlen>
     761:	89 c2                	mov    %eax,%edx
     763:	8b 45 08             	mov    0x8(%ebp),%eax
     766:	8d 04 02             	lea    (%edx,%eax,1),%eax
     769:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
  cmd = parseline(&s, es);
     76c:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     76f:	89 44 24 04          	mov    %eax,0x4(%esp)
     773:	8d 45 08             	lea    0x8(%ebp),%eax
     776:	89 04 24             	mov    %eax,(%esp)
     779:	e8 62 00 00 00       	call   7e0 <parseline>
     77e:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
  peek(&s, es, "");
     781:	c7 44 24 08 2a 1e 00 	movl   $0x1e2a,0x8(%esp)
     788:	00 
     789:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     78c:	89 44 24 04          	mov    %eax,0x4(%esp)
     790:	8d 45 08             	lea    0x8(%ebp),%eax
     793:	89 04 24             	mov    %eax,(%esp)
     796:	e8 35 ff ff ff       	call   6d0 <peek>
  if(s != es){
     79b:	8b 45 08             	mov    0x8(%ebp),%eax
     79e:	3b 45 f8             	cmp    0xfffffff8(%ebp),%eax
     7a1:	74 27                	je     7ca <parsecmd+0x7a>
    printf(2, "leftovers: %s\n", s);
     7a3:	8b 45 08             	mov    0x8(%ebp),%eax
     7a6:	89 44 24 08          	mov    %eax,0x8(%esp)
     7aa:	c7 44 24 04 2b 1e 00 	movl   $0x1e2b,0x4(%esp)
     7b1:	00 
     7b2:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     7b9:	e8 82 0a 00 00       	call   1240 <printf>
    panic("syntax");
     7be:	c7 04 24 3a 1e 00 00 	movl   $0x1e3a,(%esp)
     7c5:	e8 b6 fb ff ff       	call   380 <panic>
  }
  nulterminate(cmd);
     7ca:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     7cd:	89 04 24             	mov    %eax,(%esp)
     7d0:	e8 db 04 00 00       	call   cb0 <nulterminate>
  return cmd;
     7d5:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
}
     7d8:	c9                   	leave  
     7d9:	c3                   	ret    
     7da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000007e0 <parseline>:

struct cmd*
parseline(char **ps, char *es)
{
     7e0:	55                   	push   %ebp
     7e1:	89 e5                	mov    %esp,%ebp
     7e3:	83 ec 28             	sub    $0x28,%esp
  struct cmd *cmd;

  cmd = parsepipe(ps, es);
     7e6:	8b 45 0c             	mov    0xc(%ebp),%eax
     7e9:	89 44 24 04          	mov    %eax,0x4(%esp)
     7ed:	8b 45 08             	mov    0x8(%ebp),%eax
     7f0:	89 04 24             	mov    %eax,(%esp)
     7f3:	e8 c8 00 00 00       	call   8c0 <parsepipe>
     7f8:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
  while(peek(ps, es, "&")){
     7fb:	eb 30                	jmp    82d <parseline+0x4d>
    gettoken(ps, es, 0, 0);
     7fd:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
     804:	00 
     805:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
     80c:	00 
     80d:	8b 45 0c             	mov    0xc(%ebp),%eax
     810:	89 44 24 04          	mov    %eax,0x4(%esp)
     814:	8b 45 08             	mov    0x8(%ebp),%eax
     817:	89 04 24             	mov    %eax,(%esp)
     81a:	e8 61 fd ff ff       	call   580 <gettoken>
    cmd = backcmd(cmd);
     81f:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     822:	89 04 24             	mov    %eax,(%esp)
     825:	e8 06 fd ff ff       	call   530 <backcmd>
     82a:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
     82d:	c7 44 24 08 41 1e 00 	movl   $0x1e41,0x8(%esp)
     834:	00 
     835:	8b 45 0c             	mov    0xc(%ebp),%eax
     838:	89 44 24 04          	mov    %eax,0x4(%esp)
     83c:	8b 45 08             	mov    0x8(%ebp),%eax
     83f:	89 04 24             	mov    %eax,(%esp)
     842:	e8 89 fe ff ff       	call   6d0 <peek>
     847:	85 c0                	test   %eax,%eax
     849:	75 b2                	jne    7fd <parseline+0x1d>
  }
  if(peek(ps, es, ";")){
     84b:	c7 44 24 08 43 1e 00 	movl   $0x1e43,0x8(%esp)
     852:	00 
     853:	8b 45 0c             	mov    0xc(%ebp),%eax
     856:	89 44 24 04          	mov    %eax,0x4(%esp)
     85a:	8b 45 08             	mov    0x8(%ebp),%eax
     85d:	89 04 24             	mov    %eax,(%esp)
     860:	e8 6b fe ff ff       	call   6d0 <peek>
     865:	85 c0                	test   %eax,%eax
     867:	74 46                	je     8af <parseline+0xcf>
    gettoken(ps, es, 0, 0);
     869:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
     870:	00 
     871:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
     878:	00 
     879:	8b 45 0c             	mov    0xc(%ebp),%eax
     87c:	89 44 24 04          	mov    %eax,0x4(%esp)
     880:	8b 45 08             	mov    0x8(%ebp),%eax
     883:	89 04 24             	mov    %eax,(%esp)
     886:	e8 f5 fc ff ff       	call   580 <gettoken>
    cmd = listcmd(cmd, parseline(ps, es));
     88b:	8b 45 0c             	mov    0xc(%ebp),%eax
     88e:	89 44 24 04          	mov    %eax,0x4(%esp)
     892:	8b 45 08             	mov    0x8(%ebp),%eax
     895:	89 04 24             	mov    %eax,(%esp)
     898:	e8 43 ff ff ff       	call   7e0 <parseline>
     89d:	89 44 24 04          	mov    %eax,0x4(%esp)
     8a1:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     8a4:	89 04 24             	mov    %eax,(%esp)
     8a7:	e8 34 fc ff ff       	call   4e0 <listcmd>
     8ac:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
  }
  return cmd;
     8af:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
}
     8b2:	c9                   	leave  
     8b3:	c3                   	ret    
     8b4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     8ba:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000008c0 <parsepipe>:

struct cmd*
parsepipe(char **ps, char *es)
{
     8c0:	55                   	push   %ebp
     8c1:	89 e5                	mov    %esp,%ebp
     8c3:	83 ec 28             	sub    $0x28,%esp
  struct cmd *cmd;
  
  cmd = parseexec(ps, es);
     8c6:	8b 45 0c             	mov    0xc(%ebp),%eax
     8c9:	89 44 24 04          	mov    %eax,0x4(%esp)
     8cd:	8b 45 08             	mov    0x8(%ebp),%eax
     8d0:	89 04 24             	mov    %eax,(%esp)
     8d3:	e8 88 02 00 00       	call   b60 <parseexec>
     8d8:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
  if(peek(ps, es, "|")){
     8db:	c7 44 24 08 45 1e 00 	movl   $0x1e45,0x8(%esp)
     8e2:	00 
     8e3:	8b 45 0c             	mov    0xc(%ebp),%eax
     8e6:	89 44 24 04          	mov    %eax,0x4(%esp)
     8ea:	8b 45 08             	mov    0x8(%ebp),%eax
     8ed:	89 04 24             	mov    %eax,(%esp)
     8f0:	e8 db fd ff ff       	call   6d0 <peek>
     8f5:	85 c0                	test   %eax,%eax
     8f7:	74 46                	je     93f <parsepipe+0x7f>
    gettoken(ps, es, 0, 0);
     8f9:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
     900:	00 
     901:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
     908:	00 
     909:	8b 45 0c             	mov    0xc(%ebp),%eax
     90c:	89 44 24 04          	mov    %eax,0x4(%esp)
     910:	8b 45 08             	mov    0x8(%ebp),%eax
     913:	89 04 24             	mov    %eax,(%esp)
     916:	e8 65 fc ff ff       	call   580 <gettoken>
    cmd = pipecmd(cmd, parsepipe(ps, es));
     91b:	8b 45 0c             	mov    0xc(%ebp),%eax
     91e:	89 44 24 04          	mov    %eax,0x4(%esp)
     922:	8b 45 08             	mov    0x8(%ebp),%eax
     925:	89 04 24             	mov    %eax,(%esp)
     928:	e8 93 ff ff ff       	call   8c0 <parsepipe>
     92d:	89 44 24 04          	mov    %eax,0x4(%esp)
     931:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     934:	89 04 24             	mov    %eax,(%esp)
     937:	e8 54 fb ff ff       	call   490 <pipecmd>
     93c:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
  }
  return cmd;
     93f:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
}
     942:	c9                   	leave  
     943:	c3                   	ret    
     944:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     94a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000950 <parseredirs>:

struct cmd*
parseredirs(struct cmd *cmd, char **ps, char *es)
{
     950:	55                   	push   %ebp
     951:	89 e5                	mov    %esp,%ebp
     953:	83 ec 28             	sub    $0x28,%esp
  int tok;
  char *q, *eq;

  while(peek(ps, es, "<>")){
     956:	e9 fb 00 00 00       	jmp    a56 <parseredirs+0x106>
    tok = gettoken(ps, es, 0, 0);
     95b:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
     962:	00 
     963:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
     96a:	00 
     96b:	8b 45 10             	mov    0x10(%ebp),%eax
     96e:	89 44 24 04          	mov    %eax,0x4(%esp)
     972:	8b 45 0c             	mov    0xc(%ebp),%eax
     975:	89 04 24             	mov    %eax,(%esp)
     978:	e8 03 fc ff ff       	call   580 <gettoken>
     97d:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
    if(gettoken(ps, es, &q, &eq) != 'a')
     980:	8d 45 f4             	lea    0xfffffff4(%ebp),%eax
     983:	89 44 24 0c          	mov    %eax,0xc(%esp)
     987:	8d 45 f8             	lea    0xfffffff8(%ebp),%eax
     98a:	89 44 24 08          	mov    %eax,0x8(%esp)
     98e:	8b 45 10             	mov    0x10(%ebp),%eax
     991:	89 44 24 04          	mov    %eax,0x4(%esp)
     995:	8b 45 0c             	mov    0xc(%ebp),%eax
     998:	89 04 24             	mov    %eax,(%esp)
     99b:	e8 e0 fb ff ff       	call   580 <gettoken>
     9a0:	83 f8 61             	cmp    $0x61,%eax
     9a3:	74 0c                	je     9b1 <parseredirs+0x61>
      panic("missing file for redirection");
     9a5:	c7 04 24 47 1e 00 00 	movl   $0x1e47,(%esp)
     9ac:	e8 cf f9 ff ff       	call   380 <panic>
    switch(tok){
     9b1:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     9b4:	89 45 ec             	mov    %eax,0xffffffec(%ebp)
     9b7:	83 7d ec 3c          	cmpl   $0x3c,0xffffffec(%ebp)
     9bb:	74 11                	je     9ce <parseredirs+0x7e>
     9bd:	83 7d ec 3e          	cmpl   $0x3e,0xffffffec(%ebp)
     9c1:	74 39                	je     9fc <parseredirs+0xac>
     9c3:	83 7d ec 2b          	cmpl   $0x2b,0xffffffec(%ebp)
     9c7:	74 61                	je     a2a <parseredirs+0xda>
     9c9:	e9 88 00 00 00       	jmp    a56 <parseredirs+0x106>
    case '<':
      cmd = redircmd(cmd, q, eq, O_RDONLY, 0);
     9ce:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     9d1:	8b 55 f8             	mov    0xfffffff8(%ebp),%edx
     9d4:	c7 44 24 10 00 00 00 	movl   $0x0,0x10(%esp)
     9db:	00 
     9dc:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
     9e3:	00 
     9e4:	89 44 24 08          	mov    %eax,0x8(%esp)
     9e8:	89 54 24 04          	mov    %edx,0x4(%esp)
     9ec:	8b 45 08             	mov    0x8(%ebp),%eax
     9ef:	89 04 24             	mov    %eax,(%esp)
     9f2:	e8 29 fa ff ff       	call   420 <redircmd>
     9f7:	89 45 08             	mov    %eax,0x8(%ebp)
      break;
     9fa:	eb 5a                	jmp    a56 <parseredirs+0x106>
    case '>':
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
     9fc:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     9ff:	8b 55 f8             	mov    0xfffffff8(%ebp),%edx
     a02:	c7 44 24 10 01 00 00 	movl   $0x1,0x10(%esp)
     a09:	00 
     a0a:	c7 44 24 0c 01 02 00 	movl   $0x201,0xc(%esp)
     a11:	00 
     a12:	89 44 24 08          	mov    %eax,0x8(%esp)
     a16:	89 54 24 04          	mov    %edx,0x4(%esp)
     a1a:	8b 45 08             	mov    0x8(%ebp),%eax
     a1d:	89 04 24             	mov    %eax,(%esp)
     a20:	e8 fb f9 ff ff       	call   420 <redircmd>
     a25:	89 45 08             	mov    %eax,0x8(%ebp)
      break;
     a28:	eb 2c                	jmp    a56 <parseredirs+0x106>
    case '+':  // >>
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
     a2a:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     a2d:	8b 55 f8             	mov    0xfffffff8(%ebp),%edx
     a30:	c7 44 24 10 01 00 00 	movl   $0x1,0x10(%esp)
     a37:	00 
     a38:	c7 44 24 0c 01 02 00 	movl   $0x201,0xc(%esp)
     a3f:	00 
     a40:	89 44 24 08          	mov    %eax,0x8(%esp)
     a44:	89 54 24 04          	mov    %edx,0x4(%esp)
     a48:	8b 45 08             	mov    0x8(%ebp),%eax
     a4b:	89 04 24             	mov    %eax,(%esp)
     a4e:	e8 cd f9 ff ff       	call   420 <redircmd>
     a53:	89 45 08             	mov    %eax,0x8(%ebp)
     a56:	c7 44 24 08 64 1e 00 	movl   $0x1e64,0x8(%esp)
     a5d:	00 
     a5e:	8b 45 10             	mov    0x10(%ebp),%eax
     a61:	89 44 24 04          	mov    %eax,0x4(%esp)
     a65:	8b 45 0c             	mov    0xc(%ebp),%eax
     a68:	89 04 24             	mov    %eax,(%esp)
     a6b:	e8 60 fc ff ff       	call   6d0 <peek>
     a70:	85 c0                	test   %eax,%eax
     a72:	0f 85 e3 fe ff ff    	jne    95b <parseredirs+0xb>
      break;
    }
  }
  return cmd;
     a78:	8b 45 08             	mov    0x8(%ebp),%eax
}
     a7b:	c9                   	leave  
     a7c:	c3                   	ret    
     a7d:	8d 76 00             	lea    0x0(%esi),%esi

00000a80 <parseblock>:

struct cmd*
parseblock(char **ps, char *es)
{
     a80:	55                   	push   %ebp
     a81:	89 e5                	mov    %esp,%ebp
     a83:	83 ec 28             	sub    $0x28,%esp
  struct cmd *cmd;

  if(!peek(ps, es, "("))
     a86:	c7 44 24 08 67 1e 00 	movl   $0x1e67,0x8(%esp)
     a8d:	00 
     a8e:	8b 45 0c             	mov    0xc(%ebp),%eax
     a91:	89 44 24 04          	mov    %eax,0x4(%esp)
     a95:	8b 45 08             	mov    0x8(%ebp),%eax
     a98:	89 04 24             	mov    %eax,(%esp)
     a9b:	e8 30 fc ff ff       	call   6d0 <peek>
     aa0:	85 c0                	test   %eax,%eax
     aa2:	75 0c                	jne    ab0 <parseblock+0x30>
    panic("parseblock");
     aa4:	c7 04 24 69 1e 00 00 	movl   $0x1e69,(%esp)
     aab:	e8 d0 f8 ff ff       	call   380 <panic>
  gettoken(ps, es, 0, 0);
     ab0:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
     ab7:	00 
     ab8:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
     abf:	00 
     ac0:	8b 45 0c             	mov    0xc(%ebp),%eax
     ac3:	89 44 24 04          	mov    %eax,0x4(%esp)
     ac7:	8b 45 08             	mov    0x8(%ebp),%eax
     aca:	89 04 24             	mov    %eax,(%esp)
     acd:	e8 ae fa ff ff       	call   580 <gettoken>
  cmd = parseline(ps, es);
     ad2:	8b 45 0c             	mov    0xc(%ebp),%eax
     ad5:	89 44 24 04          	mov    %eax,0x4(%esp)
     ad9:	8b 45 08             	mov    0x8(%ebp),%eax
     adc:	89 04 24             	mov    %eax,(%esp)
     adf:	e8 fc fc ff ff       	call   7e0 <parseline>
     ae4:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
  if(!peek(ps, es, ")"))
     ae7:	c7 44 24 08 74 1e 00 	movl   $0x1e74,0x8(%esp)
     aee:	00 
     aef:	8b 45 0c             	mov    0xc(%ebp),%eax
     af2:	89 44 24 04          	mov    %eax,0x4(%esp)
     af6:	8b 45 08             	mov    0x8(%ebp),%eax
     af9:	89 04 24             	mov    %eax,(%esp)
     afc:	e8 cf fb ff ff       	call   6d0 <peek>
     b01:	85 c0                	test   %eax,%eax
     b03:	75 0c                	jne    b11 <parseblock+0x91>
    panic("syntax - missing )");
     b05:	c7 04 24 76 1e 00 00 	movl   $0x1e76,(%esp)
     b0c:	e8 6f f8 ff ff       	call   380 <panic>
  gettoken(ps, es, 0, 0);
     b11:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
     b18:	00 
     b19:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
     b20:	00 
     b21:	8b 45 0c             	mov    0xc(%ebp),%eax
     b24:	89 44 24 04          	mov    %eax,0x4(%esp)
     b28:	8b 45 08             	mov    0x8(%ebp),%eax
     b2b:	89 04 24             	mov    %eax,(%esp)
     b2e:	e8 4d fa ff ff       	call   580 <gettoken>
  cmd = parseredirs(cmd, ps, es);
     b33:	8b 45 0c             	mov    0xc(%ebp),%eax
     b36:	89 44 24 08          	mov    %eax,0x8(%esp)
     b3a:	8b 45 08             	mov    0x8(%ebp),%eax
     b3d:	89 44 24 04          	mov    %eax,0x4(%esp)
     b41:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     b44:	89 04 24             	mov    %eax,(%esp)
     b47:	e8 04 fe ff ff       	call   950 <parseredirs>
     b4c:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
  return cmd;
     b4f:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
}
     b52:	c9                   	leave  
     b53:	c3                   	ret    
     b54:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     b5a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000b60 <parseexec>:

struct cmd*
parseexec(char **ps, char *es)
{
     b60:	55                   	push   %ebp
     b61:	89 e5                	mov    %esp,%ebp
     b63:	83 ec 38             	sub    $0x38,%esp
  char *q, *eq;
  int tok, argc;
  struct execcmd *cmd;
  struct cmd *ret;
  
  if(peek(ps, es, "("))
     b66:	c7 44 24 08 67 1e 00 	movl   $0x1e67,0x8(%esp)
     b6d:	00 
     b6e:	8b 45 0c             	mov    0xc(%ebp),%eax
     b71:	89 44 24 04          	mov    %eax,0x4(%esp)
     b75:	8b 45 08             	mov    0x8(%ebp),%eax
     b78:	89 04 24             	mov    %eax,(%esp)
     b7b:	e8 50 fb ff ff       	call   6d0 <peek>
     b80:	85 c0                	test   %eax,%eax
     b82:	74 1a                	je     b9e <parseexec+0x3e>
    return parseblock(ps, es);
     b84:	8b 45 0c             	mov    0xc(%ebp),%eax
     b87:	89 44 24 04          	mov    %eax,0x4(%esp)
     b8b:	8b 45 08             	mov    0x8(%ebp),%eax
     b8e:	89 04 24             	mov    %eax,(%esp)
     b91:	e8 ea fe ff ff       	call   a80 <parseblock>
     b96:	89 45 dc             	mov    %eax,0xffffffdc(%ebp)
     b99:	e9 05 01 00 00       	jmp    ca3 <parseexec+0x143>

  ret = execcmd();
     b9e:	e8 3d f8 ff ff       	call   3e0 <execcmd>
     ba3:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
  cmd = (struct execcmd*)ret;
     ba6:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     ba9:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)

  argc = 0;
     bac:	c7 45 f4 00 00 00 00 	movl   $0x0,0xfffffff4(%ebp)
  ret = parseredirs(ret, ps, es);
     bb3:	8b 45 0c             	mov    0xc(%ebp),%eax
     bb6:	89 44 24 08          	mov    %eax,0x8(%esp)
     bba:	8b 45 08             	mov    0x8(%ebp),%eax
     bbd:	89 44 24 04          	mov    %eax,0x4(%esp)
     bc1:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     bc4:	89 04 24             	mov    %eax,(%esp)
     bc7:	e8 84 fd ff ff       	call   950 <parseredirs>
     bcc:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
  while(!peek(ps, es, "|)&;")){
     bcf:	e9 8b 00 00 00       	jmp    c5f <parseexec+0xff>
    if((tok=gettoken(ps, es, &q, &eq)) == 0)
     bd4:	8d 45 e8             	lea    0xffffffe8(%ebp),%eax
     bd7:	89 44 24 0c          	mov    %eax,0xc(%esp)
     bdb:	8d 45 ec             	lea    0xffffffec(%ebp),%eax
     bde:	89 44 24 08          	mov    %eax,0x8(%esp)
     be2:	8b 45 0c             	mov    0xc(%ebp),%eax
     be5:	89 44 24 04          	mov    %eax,0x4(%esp)
     be9:	8b 45 08             	mov    0x8(%ebp),%eax
     bec:	89 04 24             	mov    %eax,(%esp)
     bef:	e8 8c f9 ff ff       	call   580 <gettoken>
     bf4:	89 45 f0             	mov    %eax,0xfffffff0(%ebp)
     bf7:	83 7d f0 00          	cmpl   $0x0,0xfffffff0(%ebp)
     bfb:	0f 84 80 00 00 00    	je     c81 <parseexec+0x121>
      break;
    if(tok != 'a')
     c01:	83 7d f0 61          	cmpl   $0x61,0xfffffff0(%ebp)
     c05:	74 0c                	je     c13 <parseexec+0xb3>
      panic("syntax");
     c07:	c7 04 24 3a 1e 00 00 	movl   $0x1e3a,(%esp)
     c0e:	e8 6d f7 ff ff       	call   380 <panic>
    cmd->argv[argc] = q;
     c13:	8b 4d f4             	mov    0xfffffff4(%ebp),%ecx
     c16:	8b 55 ec             	mov    0xffffffec(%ebp),%edx
     c19:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     c1c:	89 54 88 04          	mov    %edx,0x4(%eax,%ecx,4)
    cmd->eargv[argc] = eq;
     c20:	8b 4d f4             	mov    0xfffffff4(%ebp),%ecx
     c23:	8b 55 e8             	mov    0xffffffe8(%ebp),%edx
     c26:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     c29:	89 54 88 2c          	mov    %edx,0x2c(%eax,%ecx,4)
    argc++;
     c2d:	83 45 f4 01          	addl   $0x1,0xfffffff4(%ebp)
    if(argc >= MAXARGS)
     c31:	83 7d f4 09          	cmpl   $0x9,0xfffffff4(%ebp)
     c35:	7e 0c                	jle    c43 <parseexec+0xe3>
      panic("too many args");
     c37:	c7 04 24 89 1e 00 00 	movl   $0x1e89,(%esp)
     c3e:	e8 3d f7 ff ff       	call   380 <panic>
    ret = parseredirs(ret, ps, es);
     c43:	8b 45 0c             	mov    0xc(%ebp),%eax
     c46:	89 44 24 08          	mov    %eax,0x8(%esp)
     c4a:	8b 45 08             	mov    0x8(%ebp),%eax
     c4d:	89 44 24 04          	mov    %eax,0x4(%esp)
     c51:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     c54:	89 04 24             	mov    %eax,(%esp)
     c57:	e8 f4 fc ff ff       	call   950 <parseredirs>
     c5c:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
     c5f:	c7 44 24 08 97 1e 00 	movl   $0x1e97,0x8(%esp)
     c66:	00 
     c67:	8b 45 0c             	mov    0xc(%ebp),%eax
     c6a:	89 44 24 04          	mov    %eax,0x4(%esp)
     c6e:	8b 45 08             	mov    0x8(%ebp),%eax
     c71:	89 04 24             	mov    %eax,(%esp)
     c74:	e8 57 fa ff ff       	call   6d0 <peek>
     c79:	85 c0                	test   %eax,%eax
     c7b:	0f 84 53 ff ff ff    	je     bd4 <parseexec+0x74>
  }
  cmd->argv[argc] = 0;
     c81:	8b 55 f4             	mov    0xfffffff4(%ebp),%edx
     c84:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     c87:	c7 44 90 04 00 00 00 	movl   $0x0,0x4(%eax,%edx,4)
     c8e:	00 
  cmd->eargv[argc] = 0;
     c8f:	8b 55 f4             	mov    0xfffffff4(%ebp),%edx
     c92:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     c95:	c7 44 90 2c 00 00 00 	movl   $0x0,0x2c(%eax,%edx,4)
     c9c:	00 
  return ret;
     c9d:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     ca0:	89 45 dc             	mov    %eax,0xffffffdc(%ebp)
     ca3:	8b 45 dc             	mov    0xffffffdc(%ebp),%eax
}
     ca6:	c9                   	leave  
     ca7:	c3                   	ret    
     ca8:	90                   	nop    
     ca9:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi

00000cb0 <nulterminate>:

// NUL-terminate all the counted strings.
struct cmd*
nulterminate(struct cmd *cmd)
{
     cb0:	55                   	push   %ebp
     cb1:	89 e5                	mov    %esp,%ebp
     cb3:	83 ec 2c             	sub    $0x2c,%esp
  int i;
  struct backcmd *bcmd;
  struct execcmd *ecmd;
  struct listcmd *lcmd;
  struct pipecmd *pcmd;
  struct redircmd *rcmd;

  if(cmd == 0)
     cb6:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
     cba:	75 0c                	jne    cc8 <nulterminate+0x18>
    return 0;
     cbc:	c7 45 d8 00 00 00 00 	movl   $0x0,0xffffffd8(%ebp)
     cc3:	e9 cf 00 00 00       	jmp    d97 <nulterminate+0xe7>
  
  switch(cmd->type){
     cc8:	8b 45 08             	mov    0x8(%ebp),%eax
     ccb:	8b 00                	mov    (%eax),%eax
     ccd:	89 45 dc             	mov    %eax,0xffffffdc(%ebp)
     cd0:	83 7d dc 05          	cmpl   $0x5,0xffffffdc(%ebp)
     cd4:	0f 87 b7 00 00 00    	ja     d91 <nulterminate+0xe1>
     cda:	8b 55 dc             	mov    0xffffffdc(%ebp),%edx
     cdd:	8b 04 95 9c 1e 00 00 	mov    0x1e9c(,%edx,4),%eax
     ce4:	ff e0                	jmp    *%eax
  case EXEC:
    ecmd = (struct execcmd*)cmd;
     ce6:	8b 45 08             	mov    0x8(%ebp),%eax
     ce9:	89 45 f0             	mov    %eax,0xfffffff0(%ebp)
    for(i=0; ecmd->argv[i]; i++)
     cec:	c7 45 e8 00 00 00 00 	movl   $0x0,0xffffffe8(%ebp)
     cf3:	eb 11                	jmp    d06 <nulterminate+0x56>
      *ecmd->eargv[i] = 0;
     cf5:	8b 45 e8             	mov    0xffffffe8(%ebp),%eax
     cf8:	8b 55 f0             	mov    0xfffffff0(%ebp),%edx
     cfb:	8b 44 82 2c          	mov    0x2c(%edx,%eax,4),%eax
     cff:	c6 00 00             	movb   $0x0,(%eax)
     d02:	83 45 e8 01          	addl   $0x1,0xffffffe8(%ebp)
     d06:	8b 45 e8             	mov    0xffffffe8(%ebp),%eax
     d09:	8b 55 f0             	mov    0xfffffff0(%ebp),%edx
     d0c:	8b 44 82 04          	mov    0x4(%edx,%eax,4),%eax
     d10:	85 c0                	test   %eax,%eax
     d12:	75 e1                	jne    cf5 <nulterminate+0x45>
    break;
     d14:	eb 7b                	jmp    d91 <nulterminate+0xe1>

  case REDIR:
    rcmd = (struct redircmd*)cmd;
     d16:	8b 45 08             	mov    0x8(%ebp),%eax
     d19:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
    nulterminate(rcmd->cmd);
     d1c:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     d1f:	8b 40 04             	mov    0x4(%eax),%eax
     d22:	89 04 24             	mov    %eax,(%esp)
     d25:	e8 86 ff ff ff       	call   cb0 <nulterminate>
    *rcmd->efile = 0;
     d2a:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     d2d:	8b 40 0c             	mov    0xc(%eax),%eax
     d30:	c6 00 00             	movb   $0x0,(%eax)
    break;
     d33:	eb 5c                	jmp    d91 <nulterminate+0xe1>

  case PIPE:
    pcmd = (struct pipecmd*)cmd;
     d35:	8b 45 08             	mov    0x8(%ebp),%eax
     d38:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
    nulterminate(pcmd->left);
     d3b:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     d3e:	8b 40 04             	mov    0x4(%eax),%eax
     d41:	89 04 24             	mov    %eax,(%esp)
     d44:	e8 67 ff ff ff       	call   cb0 <nulterminate>
    nulterminate(pcmd->right);
     d49:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     d4c:	8b 40 08             	mov    0x8(%eax),%eax
     d4f:	89 04 24             	mov    %eax,(%esp)
     d52:	e8 59 ff ff ff       	call   cb0 <nulterminate>
    break;
     d57:	eb 38                	jmp    d91 <nulterminate+0xe1>
    
  case LIST:
    lcmd = (struct listcmd*)cmd;
     d59:	8b 45 08             	mov    0x8(%ebp),%eax
     d5c:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
    nulterminate(lcmd->left);
     d5f:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     d62:	8b 40 04             	mov    0x4(%eax),%eax
     d65:	89 04 24             	mov    %eax,(%esp)
     d68:	e8 43 ff ff ff       	call   cb0 <nulterminate>
    nulterminate(lcmd->right);
     d6d:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     d70:	8b 40 08             	mov    0x8(%eax),%eax
     d73:	89 04 24             	mov    %eax,(%esp)
     d76:	e8 35 ff ff ff       	call   cb0 <nulterminate>
    break;
     d7b:	eb 14                	jmp    d91 <nulterminate+0xe1>

  case BACK:
    bcmd = (struct backcmd*)cmd;
     d7d:	8b 45 08             	mov    0x8(%ebp),%eax
     d80:	89 45 ec             	mov    %eax,0xffffffec(%ebp)
    nulterminate(bcmd->cmd);
     d83:	8b 45 ec             	mov    0xffffffec(%ebp),%eax
     d86:	8b 40 04             	mov    0x4(%eax),%eax
     d89:	89 04 24             	mov    %eax,(%esp)
     d8c:	e8 1f ff ff ff       	call   cb0 <nulterminate>
    break;
  }
  return cmd;
     d91:	8b 45 08             	mov    0x8(%ebp),%eax
     d94:	89 45 d8             	mov    %eax,0xffffffd8(%ebp)
     d97:	8b 45 d8             	mov    0xffffffd8(%ebp),%eax
}
     d9a:	c9                   	leave  
     d9b:	c3                   	ret    
     d9c:	90                   	nop    
     d9d:	90                   	nop    
     d9e:	90                   	nop    
     d9f:	90                   	nop    

00000da0 <strcpy>:
#include "user.h"

char*
strcpy(char *s, char *t)
{
     da0:	55                   	push   %ebp
     da1:	89 e5                	mov    %esp,%ebp
     da3:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
     da6:	8b 45 08             	mov    0x8(%ebp),%eax
     da9:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
  while((*s++ = *t++) != 0)
     dac:	8b 45 0c             	mov    0xc(%ebp),%eax
     daf:	0f b6 10             	movzbl (%eax),%edx
     db2:	8b 45 08             	mov    0x8(%ebp),%eax
     db5:	88 10                	mov    %dl,(%eax)
     db7:	8b 45 08             	mov    0x8(%ebp),%eax
     dba:	0f b6 00             	movzbl (%eax),%eax
     dbd:	84 c0                	test   %al,%al
     dbf:	0f 95 c0             	setne  %al
     dc2:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     dc6:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
     dca:	84 c0                	test   %al,%al
     dcc:	75 de                	jne    dac <strcpy+0xc>
    ;
  return os;
     dce:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
}
     dd1:	c9                   	leave  
     dd2:	c3                   	ret    
     dd3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     dd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00000de0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     de0:	55                   	push   %ebp
     de1:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
     de3:	eb 08                	jmp    ded <strcmp+0xd>
    p++, q++;
     de5:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     de9:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
     ded:	8b 45 08             	mov    0x8(%ebp),%eax
     df0:	0f b6 00             	movzbl (%eax),%eax
     df3:	84 c0                	test   %al,%al
     df5:	74 10                	je     e07 <strcmp+0x27>
     df7:	8b 45 08             	mov    0x8(%ebp),%eax
     dfa:	0f b6 10             	movzbl (%eax),%edx
     dfd:	8b 45 0c             	mov    0xc(%ebp),%eax
     e00:	0f b6 00             	movzbl (%eax),%eax
     e03:	38 c2                	cmp    %al,%dl
     e05:	74 de                	je     de5 <strcmp+0x5>
  return (uchar)*p - (uchar)*q;
     e07:	8b 45 08             	mov    0x8(%ebp),%eax
     e0a:	0f b6 00             	movzbl (%eax),%eax
     e0d:	0f b6 d0             	movzbl %al,%edx
     e10:	8b 45 0c             	mov    0xc(%ebp),%eax
     e13:	0f b6 00             	movzbl (%eax),%eax
     e16:	0f b6 c0             	movzbl %al,%eax
     e19:	89 d1                	mov    %edx,%ecx
     e1b:	29 c1                	sub    %eax,%ecx
     e1d:	89 c8                	mov    %ecx,%eax
}
     e1f:	5d                   	pop    %ebp
     e20:	c3                   	ret    
     e21:	eb 0d                	jmp    e30 <strlen>
     e23:	90                   	nop    
     e24:	90                   	nop    
     e25:	90                   	nop    
     e26:	90                   	nop    
     e27:	90                   	nop    
     e28:	90                   	nop    
     e29:	90                   	nop    
     e2a:	90                   	nop    
     e2b:	90                   	nop    
     e2c:	90                   	nop    
     e2d:	90                   	nop    
     e2e:	90                   	nop    
     e2f:	90                   	nop    

00000e30 <strlen>:

uint
strlen(char *s)
{
     e30:	55                   	push   %ebp
     e31:	89 e5                	mov    %esp,%ebp
     e33:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
     e36:	c7 45 fc 00 00 00 00 	movl   $0x0,0xfffffffc(%ebp)
     e3d:	eb 04                	jmp    e43 <strlen+0x13>
     e3f:	83 45 fc 01          	addl   $0x1,0xfffffffc(%ebp)
     e43:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     e46:	03 45 08             	add    0x8(%ebp),%eax
     e49:	0f b6 00             	movzbl (%eax),%eax
     e4c:	84 c0                	test   %al,%al
     e4e:	75 ef                	jne    e3f <strlen+0xf>
    ;
  return n;
     e50:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
}
     e53:	c9                   	leave  
     e54:	c3                   	ret    
     e55:	8d 74 26 00          	lea    0x0(%esi),%esi
     e59:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00000e60 <memset>:

void*
memset(void *dst, int c, uint n)
{
     e60:	55                   	push   %ebp
     e61:	89 e5                	mov    %esp,%ebp
     e63:	83 ec 10             	sub    $0x10,%esp
  char *d;
  
  d = dst;
     e66:	8b 45 08             	mov    0x8(%ebp),%eax
     e69:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
  while(n-- > 0)
     e6c:	eb 0e                	jmp    e7c <memset+0x1c>
    *d++ = c;
     e6e:	8b 45 0c             	mov    0xc(%ebp),%eax
     e71:	89 c2                	mov    %eax,%edx
     e73:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     e76:	88 10                	mov    %dl,(%eax)
     e78:	83 45 fc 01          	addl   $0x1,0xfffffffc(%ebp)
     e7c:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
     e80:	83 7d 10 ff          	cmpl   $0xffffffff,0x10(%ebp)
     e84:	75 e8                	jne    e6e <memset+0xe>
  return dst;
     e86:	8b 45 08             	mov    0x8(%ebp),%eax
}
     e89:	c9                   	leave  
     e8a:	c3                   	ret    
     e8b:	90                   	nop    
     e8c:	8d 74 26 00          	lea    0x0(%esi),%esi

00000e90 <strchr>:

char*
strchr(const char *s, char c)
{
     e90:	55                   	push   %ebp
     e91:	89 e5                	mov    %esp,%ebp
     e93:	83 ec 08             	sub    $0x8,%esp
     e96:	8b 45 0c             	mov    0xc(%ebp),%eax
     e99:	88 45 fc             	mov    %al,0xfffffffc(%ebp)
  for(; *s; s++)
     e9c:	eb 17                	jmp    eb5 <strchr+0x25>
    if(*s == c)
     e9e:	8b 45 08             	mov    0x8(%ebp),%eax
     ea1:	0f b6 00             	movzbl (%eax),%eax
     ea4:	3a 45 fc             	cmp    0xfffffffc(%ebp),%al
     ea7:	75 08                	jne    eb1 <strchr+0x21>
      return (char*) s;
     ea9:	8b 45 08             	mov    0x8(%ebp),%eax
     eac:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
     eaf:	eb 15                	jmp    ec6 <strchr+0x36>
     eb1:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     eb5:	8b 45 08             	mov    0x8(%ebp),%eax
     eb8:	0f b6 00             	movzbl (%eax),%eax
     ebb:	84 c0                	test   %al,%al
     ebd:	75 df                	jne    e9e <strchr+0xe>
  return 0;
     ebf:	c7 45 f8 00 00 00 00 	movl   $0x0,0xfffffff8(%ebp)
     ec6:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
}
     ec9:	c9                   	leave  
     eca:	c3                   	ret    
     ecb:	90                   	nop    
     ecc:	8d 74 26 00          	lea    0x0(%esi),%esi

00000ed0 <gets>:

char*
gets(char *buf, int max)
{
     ed0:	55                   	push   %ebp
     ed1:	89 e5                	mov    %esp,%ebp
     ed3:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     ed6:	c7 45 f8 00 00 00 00 	movl   $0x0,0xfffffff8(%ebp)
     edd:	eb 46                	jmp    f25 <gets+0x55>
    cc = read(0, &c, 1);
     edf:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
     ee6:	00 
     ee7:	8d 45 f7             	lea    0xfffffff7(%ebp),%eax
     eea:	89 44 24 04          	mov    %eax,0x4(%esp)
     eee:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     ef5:	e8 52 01 00 00       	call   104c <read>
     efa:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
    if(cc < 1)
     efd:	83 7d fc 00          	cmpl   $0x0,0xfffffffc(%ebp)
     f01:	7e 2d                	jle    f30 <gets+0x60>
      break;
    buf[i++] = c;
     f03:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     f06:	89 c2                	mov    %eax,%edx
     f08:	03 55 08             	add    0x8(%ebp),%edx
     f0b:	0f b6 45 f7          	movzbl 0xfffffff7(%ebp),%eax
     f0f:	88 02                	mov    %al,(%edx)
     f11:	83 45 f8 01          	addl   $0x1,0xfffffff8(%ebp)
    if(c == '\n' || c == '\r')
     f15:	0f b6 45 f7          	movzbl 0xfffffff7(%ebp),%eax
     f19:	3c 0a                	cmp    $0xa,%al
     f1b:	74 13                	je     f30 <gets+0x60>
     f1d:	0f b6 45 f7          	movzbl 0xfffffff7(%ebp),%eax
     f21:	3c 0d                	cmp    $0xd,%al
     f23:	74 0b                	je     f30 <gets+0x60>
     f25:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     f28:	83 c0 01             	add    $0x1,%eax
     f2b:	3b 45 0c             	cmp    0xc(%ebp),%eax
     f2e:	7c af                	jl     edf <gets+0xf>
      break;
  }
  buf[i] = '\0';
     f30:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     f33:	03 45 08             	add    0x8(%ebp),%eax
     f36:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
     f39:	8b 45 08             	mov    0x8(%ebp),%eax
}
     f3c:	c9                   	leave  
     f3d:	c3                   	ret    
     f3e:	89 f6                	mov    %esi,%esi

00000f40 <stat>:

int
stat(char *n, struct stat *st)
{
     f40:	55                   	push   %ebp
     f41:	89 e5                	mov    %esp,%ebp
     f43:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     f46:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     f4d:	00 
     f4e:	8b 45 08             	mov    0x8(%ebp),%eax
     f51:	89 04 24             	mov    %eax,(%esp)
     f54:	e8 1b 01 00 00       	call   1074 <open>
     f59:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
  if(fd < 0)
     f5c:	83 7d f8 00          	cmpl   $0x0,0xfffffff8(%ebp)
     f60:	79 09                	jns    f6b <stat+0x2b>
    return -1;
     f62:	c7 45 ec ff ff ff ff 	movl   $0xffffffff,0xffffffec(%ebp)
     f69:	eb 26                	jmp    f91 <stat+0x51>
  r = fstat(fd, st);
     f6b:	8b 45 0c             	mov    0xc(%ebp),%eax
     f6e:	89 44 24 04          	mov    %eax,0x4(%esp)
     f72:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     f75:	89 04 24             	mov    %eax,(%esp)
     f78:	e8 0f 01 00 00       	call   108c <fstat>
     f7d:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
  close(fd);
     f80:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     f83:	89 04 24             	mov    %eax,(%esp)
     f86:	e8 d1 00 00 00       	call   105c <close>
  return r;
     f8b:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     f8e:	89 45 ec             	mov    %eax,0xffffffec(%ebp)
     f91:	8b 45 ec             	mov    0xffffffec(%ebp),%eax
}
     f94:	c9                   	leave  
     f95:	c3                   	ret    
     f96:	8d 76 00             	lea    0x0(%esi),%esi
     f99:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00000fa0 <atoi>:

int
atoi(const char *s)
{
     fa0:	55                   	push   %ebp
     fa1:	89 e5                	mov    %esp,%ebp
     fa3:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
     fa6:	c7 45 fc 00 00 00 00 	movl   $0x0,0xfffffffc(%ebp)
  while('0' <= *s && *s <= '9')
     fad:	eb 24                	jmp    fd3 <atoi+0x33>
    n = n*10 + *s++ - '0';
     faf:	8b 55 fc             	mov    0xfffffffc(%ebp),%edx
     fb2:	89 d0                	mov    %edx,%eax
     fb4:	c1 e0 02             	shl    $0x2,%eax
     fb7:	01 d0                	add    %edx,%eax
     fb9:	01 c0                	add    %eax,%eax
     fbb:	89 c2                	mov    %eax,%edx
     fbd:	8b 45 08             	mov    0x8(%ebp),%eax
     fc0:	0f b6 00             	movzbl (%eax),%eax
     fc3:	0f be c0             	movsbl %al,%eax
     fc6:	8d 04 02             	lea    (%edx,%eax,1),%eax
     fc9:	83 e8 30             	sub    $0x30,%eax
     fcc:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
     fcf:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     fd3:	8b 45 08             	mov    0x8(%ebp),%eax
     fd6:	0f b6 00             	movzbl (%eax),%eax
     fd9:	3c 2f                	cmp    $0x2f,%al
     fdb:	7e 0a                	jle    fe7 <atoi+0x47>
     fdd:	8b 45 08             	mov    0x8(%ebp),%eax
     fe0:	0f b6 00             	movzbl (%eax),%eax
     fe3:	3c 39                	cmp    $0x39,%al
     fe5:	7e c8                	jle    faf <atoi+0xf>
  return n;
     fe7:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
}
     fea:	c9                   	leave  
     feb:	c3                   	ret    
     fec:	8d 74 26 00          	lea    0x0(%esi),%esi

00000ff0 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
     ff0:	55                   	push   %ebp
     ff1:	89 e5                	mov    %esp,%ebp
     ff3:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
     ff6:	8b 45 08             	mov    0x8(%ebp),%eax
     ff9:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
  src = vsrc;
     ffc:	8b 45 0c             	mov    0xc(%ebp),%eax
     fff:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
  while(n-- > 0)
    1002:	eb 13                	jmp    1017 <memmove+0x27>
    *dst++ = *src++;
    1004:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
    1007:	0f b6 10             	movzbl (%eax),%edx
    100a:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
    100d:	88 10                	mov    %dl,(%eax)
    100f:	83 45 f8 01          	addl   $0x1,0xfffffff8(%ebp)
    1013:	83 45 fc 01          	addl   $0x1,0xfffffffc(%ebp)
    1017:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    101b:	0f 9f c0             	setg   %al
    101e:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
    1022:	84 c0                	test   %al,%al
    1024:	75 de                	jne    1004 <memmove+0x14>
  return vdst;
    1026:	8b 45 08             	mov    0x8(%ebp),%eax
}
    1029:	c9                   	leave  
    102a:	c3                   	ret    
    102b:	90                   	nop    

0000102c <fork>:
    102c:	b8 01 00 00 00       	mov    $0x1,%eax
    1031:	cd 30                	int    $0x30
    1033:	c3                   	ret    

00001034 <exit>:
    1034:	b8 02 00 00 00       	mov    $0x2,%eax
    1039:	cd 30                	int    $0x30
    103b:	c3                   	ret    

0000103c <wait>:
    103c:	b8 03 00 00 00       	mov    $0x3,%eax
    1041:	cd 30                	int    $0x30
    1043:	c3                   	ret    

00001044 <pipe>:
    1044:	b8 04 00 00 00       	mov    $0x4,%eax
    1049:	cd 30                	int    $0x30
    104b:	c3                   	ret    

0000104c <read>:
    104c:	b8 06 00 00 00       	mov    $0x6,%eax
    1051:	cd 30                	int    $0x30
    1053:	c3                   	ret    

00001054 <write>:
    1054:	b8 05 00 00 00       	mov    $0x5,%eax
    1059:	cd 30                	int    $0x30
    105b:	c3                   	ret    

0000105c <close>:
    105c:	b8 07 00 00 00       	mov    $0x7,%eax
    1061:	cd 30                	int    $0x30
    1063:	c3                   	ret    

00001064 <kill>:
    1064:	b8 08 00 00 00       	mov    $0x8,%eax
    1069:	cd 30                	int    $0x30
    106b:	c3                   	ret    

0000106c <exec>:
    106c:	b8 09 00 00 00       	mov    $0x9,%eax
    1071:	cd 30                	int    $0x30
    1073:	c3                   	ret    

00001074 <open>:
    1074:	b8 0a 00 00 00       	mov    $0xa,%eax
    1079:	cd 30                	int    $0x30
    107b:	c3                   	ret    

0000107c <mknod>:
    107c:	b8 0b 00 00 00       	mov    $0xb,%eax
    1081:	cd 30                	int    $0x30
    1083:	c3                   	ret    

00001084 <unlink>:
    1084:	b8 0c 00 00 00       	mov    $0xc,%eax
    1089:	cd 30                	int    $0x30
    108b:	c3                   	ret    

0000108c <fstat>:
    108c:	b8 0d 00 00 00       	mov    $0xd,%eax
    1091:	cd 30                	int    $0x30
    1093:	c3                   	ret    

00001094 <link>:
    1094:	b8 0e 00 00 00       	mov    $0xe,%eax
    1099:	cd 30                	int    $0x30
    109b:	c3                   	ret    

0000109c <mkdir>:
    109c:	b8 0f 00 00 00       	mov    $0xf,%eax
    10a1:	cd 30                	int    $0x30
    10a3:	c3                   	ret    

000010a4 <chdir>:
    10a4:	b8 10 00 00 00       	mov    $0x10,%eax
    10a9:	cd 30                	int    $0x30
    10ab:	c3                   	ret    

000010ac <dup>:
    10ac:	b8 11 00 00 00       	mov    $0x11,%eax
    10b1:	cd 30                	int    $0x30
    10b3:	c3                   	ret    

000010b4 <getpid>:
    10b4:	b8 12 00 00 00       	mov    $0x12,%eax
    10b9:	cd 30                	int    $0x30
    10bb:	c3                   	ret    

000010bc <sbrk>:
    10bc:	b8 13 00 00 00       	mov    $0x13,%eax
    10c1:	cd 30                	int    $0x30
    10c3:	c3                   	ret    

000010c4 <sleep>:
    10c4:	b8 14 00 00 00       	mov    $0x14,%eax
    10c9:	cd 30                	int    $0x30
    10cb:	c3                   	ret    

000010cc <upmsec>:
    10cc:	b8 15 00 00 00       	mov    $0x15,%eax
    10d1:	cd 30                	int    $0x30
    10d3:	c3                   	ret    

000010d4 <socket>:
    10d4:	b8 16 00 00 00       	mov    $0x16,%eax
    10d9:	cd 30                	int    $0x30
    10db:	c3                   	ret    

000010dc <bind>:
    10dc:	b8 17 00 00 00       	mov    $0x17,%eax
    10e1:	cd 30                	int    $0x30
    10e3:	c3                   	ret    

000010e4 <listen>:
    10e4:	b8 18 00 00 00       	mov    $0x18,%eax
    10e9:	cd 30                	int    $0x30
    10eb:	c3                   	ret    

000010ec <accept>:
    10ec:	b8 19 00 00 00       	mov    $0x19,%eax
    10f1:	cd 30                	int    $0x30
    10f3:	c3                   	ret    

000010f4 <recv>:
    10f4:	b8 1a 00 00 00       	mov    $0x1a,%eax
    10f9:	cd 30                	int    $0x30
    10fb:	c3                   	ret    

000010fc <recvfrom>:
    10fc:	b8 1b 00 00 00       	mov    $0x1b,%eax
    1101:	cd 30                	int    $0x30
    1103:	c3                   	ret    

00001104 <send>:
    1104:	b8 1c 00 00 00       	mov    $0x1c,%eax
    1109:	cd 30                	int    $0x30
    110b:	c3                   	ret    

0000110c <sendto>:
    110c:	b8 1d 00 00 00       	mov    $0x1d,%eax
    1111:	cd 30                	int    $0x30
    1113:	c3                   	ret    

00001114 <shutdown>:
    1114:	b8 1e 00 00 00       	mov    $0x1e,%eax
    1119:	cd 30                	int    $0x30
    111b:	c3                   	ret    

0000111c <getsockopt>:
    111c:	b8 1f 00 00 00       	mov    $0x1f,%eax
    1121:	cd 30                	int    $0x30
    1123:	c3                   	ret    

00001124 <setsockopt>:
    1124:	b8 20 00 00 00       	mov    $0x20,%eax
    1129:	cd 30                	int    $0x30
    112b:	c3                   	ret    

0000112c <sockclose>:
    112c:	b8 21 00 00 00       	mov    $0x21,%eax
    1131:	cd 30                	int    $0x30
    1133:	c3                   	ret    

00001134 <connect>:
    1134:	b8 22 00 00 00       	mov    $0x22,%eax
    1139:	cd 30                	int    $0x30
    113b:	c3                   	ret    

0000113c <getpeername>:
    113c:	b8 23 00 00 00       	mov    $0x23,%eax
    1141:	cd 30                	int    $0x30
    1143:	c3                   	ret    

00001144 <getsockname>:
    1144:	b8 24 00 00 00       	mov    $0x24,%eax
    1149:	cd 30                	int    $0x30
    114b:	c3                   	ret    
    114c:	90                   	nop    
    114d:	90                   	nop    
    114e:	90                   	nop    
    114f:	90                   	nop    

00001150 <putc>:
#include "user.h"

void
putc(int fd, char c)
{
    1150:	55                   	push   %ebp
    1151:	89 e5                	mov    %esp,%ebp
    1153:	83 ec 18             	sub    $0x18,%esp
    1156:	8b 45 0c             	mov    0xc(%ebp),%eax
    1159:	88 45 fc             	mov    %al,0xfffffffc(%ebp)
  write(fd, &c, 1);
    115c:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    1163:	00 
    1164:	8d 45 fc             	lea    0xfffffffc(%ebp),%eax
    1167:	89 44 24 04          	mov    %eax,0x4(%esp)
    116b:	8b 45 08             	mov    0x8(%ebp),%eax
    116e:	89 04 24             	mov    %eax,(%esp)
    1171:	e8 de fe ff ff       	call   1054 <write>
}
    1176:	c9                   	leave  
    1177:	c3                   	ret    
    1178:	90                   	nop    
    1179:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi

00001180 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    1180:	55                   	push   %ebp
    1181:	89 e5                	mov    %esp,%ebp
    1183:	53                   	push   %ebx
    1184:	83 ec 34             	sub    $0x34,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    1187:	c7 45 f4 00 00 00 00 	movl   $0x0,0xfffffff4(%ebp)
  if(sgn && xx < 0){
    118e:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
    1192:	74 17                	je     11ab <printint+0x2b>
    1194:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1198:	79 11                	jns    11ab <printint+0x2b>
    neg = 1;
    119a:	c7 45 f4 01 00 00 00 	movl   $0x1,0xfffffff4(%ebp)
    x = -xx;
    11a1:	8b 45 0c             	mov    0xc(%ebp),%eax
    11a4:	f7 d8                	neg    %eax
    11a6:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
    11a9:	eb 06                	jmp    11b1 <printint+0x31>
  } else {
    x = xx;
    11ab:	8b 45 0c             	mov    0xc(%ebp),%eax
    11ae:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
  }

  i = 0;
    11b1:	c7 45 f0 00 00 00 00 	movl   $0x0,0xfffffff0(%ebp)
  do{
    buf[i++] = digits[x % base];
    11b8:	8b 4d f0             	mov    0xfffffff0(%ebp),%ecx
    11bb:	8b 55 10             	mov    0x10(%ebp),%edx
    11be:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
    11c1:	89 d3                	mov    %edx,%ebx
    11c3:	ba 00 00 00 00       	mov    $0x0,%edx
    11c8:	f7 f3                	div    %ebx
    11ca:	89 d0                	mov    %edx,%eax
    11cc:	0f b6 80 e0 1e 00 00 	movzbl 0x1ee0(%eax),%eax
    11d3:	88 44 0d e0          	mov    %al,0xffffffe0(%ebp,%ecx,1)
    11d7:	83 45 f0 01          	addl   $0x1,0xfffffff0(%ebp)
  }while((x /= base) != 0);
    11db:	8b 55 10             	mov    0x10(%ebp),%edx
    11de:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
    11e1:	89 d1                	mov    %edx,%ecx
    11e3:	ba 00 00 00 00       	mov    $0x0,%edx
    11e8:	f7 f1                	div    %ecx
    11ea:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
    11ed:	83 7d f8 00          	cmpl   $0x0,0xfffffff8(%ebp)
    11f1:	75 c5                	jne    11b8 <printint+0x38>
  if(neg)
    11f3:	83 7d f4 00          	cmpl   $0x0,0xfffffff4(%ebp)
    11f7:	74 28                	je     1221 <printint+0xa1>
    buf[i++] = '-';
    11f9:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
    11fc:	c6 44 05 e0 2d       	movb   $0x2d,0xffffffe0(%ebp,%eax,1)
    1201:	83 45 f0 01          	addl   $0x1,0xfffffff0(%ebp)

  while(--i >= 0)
    1205:	eb 1a                	jmp    1221 <printint+0xa1>
    putc(fd, buf[i]);
    1207:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
    120a:	0f b6 44 05 e0       	movzbl 0xffffffe0(%ebp,%eax,1),%eax
    120f:	0f be c0             	movsbl %al,%eax
    1212:	89 44 24 04          	mov    %eax,0x4(%esp)
    1216:	8b 45 08             	mov    0x8(%ebp),%eax
    1219:	89 04 24             	mov    %eax,(%esp)
    121c:	e8 2f ff ff ff       	call   1150 <putc>
    1221:	83 6d f0 01          	subl   $0x1,0xfffffff0(%ebp)
    1225:	83 7d f0 00          	cmpl   $0x0,0xfffffff0(%ebp)
    1229:	79 dc                	jns    1207 <printint+0x87>
}
    122b:	83 c4 34             	add    $0x34,%esp
    122e:	5b                   	pop    %ebx
    122f:	5d                   	pop    %ebp
    1230:	c3                   	ret    
    1231:	eb 0d                	jmp    1240 <printf>
    1233:	90                   	nop    
    1234:	90                   	nop    
    1235:	90                   	nop    
    1236:	90                   	nop    
    1237:	90                   	nop    
    1238:	90                   	nop    
    1239:	90                   	nop    
    123a:	90                   	nop    
    123b:	90                   	nop    
    123c:	90                   	nop    
    123d:	90                   	nop    
    123e:	90                   	nop    
    123f:	90                   	nop    

00001240 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    1240:	55                   	push   %ebp
    1241:	89 e5                	mov    %esp,%ebp
    1243:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
    1246:	c7 45 f8 00 00 00 00 	movl   $0x0,0xfffffff8(%ebp)
  ap = (uint*)(void*)&fmt + 1;
    124d:	8d 45 0c             	lea    0xc(%ebp),%eax
    1250:	83 c0 04             	add    $0x4,%eax
    1253:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
  for(i = 0; fmt[i]; i++){
    1256:	c7 45 f4 00 00 00 00 	movl   $0x0,0xfffffff4(%ebp)
    125d:	e9 7b 01 00 00       	jmp    13dd <printf+0x19d>
    c = fmt[i] & 0xff;
    1262:	8b 55 0c             	mov    0xc(%ebp),%edx
    1265:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
    1268:	8d 04 02             	lea    (%edx,%eax,1),%eax
    126b:	0f b6 00             	movzbl (%eax),%eax
    126e:	0f be c0             	movsbl %al,%eax
    1271:	25 ff 00 00 00       	and    $0xff,%eax
    1276:	89 45 f0             	mov    %eax,0xfffffff0(%ebp)
    if(state == 0){
    1279:	83 7d f8 00          	cmpl   $0x0,0xfffffff8(%ebp)
    127d:	75 2c                	jne    12ab <printf+0x6b>
      if(c == '%'){
    127f:	83 7d f0 25          	cmpl   $0x25,0xfffffff0(%ebp)
    1283:	75 0c                	jne    1291 <printf+0x51>
        state = '%';
    1285:	c7 45 f8 25 00 00 00 	movl   $0x25,0xfffffff8(%ebp)
    128c:	e9 48 01 00 00       	jmp    13d9 <printf+0x199>
      } else {
        putc(fd, c);
    1291:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
    1294:	0f be c0             	movsbl %al,%eax
    1297:	89 44 24 04          	mov    %eax,0x4(%esp)
    129b:	8b 45 08             	mov    0x8(%ebp),%eax
    129e:	89 04 24             	mov    %eax,(%esp)
    12a1:	e8 aa fe ff ff       	call   1150 <putc>
    12a6:	e9 2e 01 00 00       	jmp    13d9 <printf+0x199>
      }
    } else if(state == '%'){
    12ab:	83 7d f8 25          	cmpl   $0x25,0xfffffff8(%ebp)
    12af:	0f 85 24 01 00 00    	jne    13d9 <printf+0x199>
      if(c == 'd'){
    12b5:	83 7d f0 64          	cmpl   $0x64,0xfffffff0(%ebp)
    12b9:	75 2d                	jne    12e8 <printf+0xa8>
        printint(fd, *ap, 10, 1);
    12bb:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
    12be:	8b 00                	mov    (%eax),%eax
    12c0:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
    12c7:	00 
    12c8:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
    12cf:	00 
    12d0:	89 44 24 04          	mov    %eax,0x4(%esp)
    12d4:	8b 45 08             	mov    0x8(%ebp),%eax
    12d7:	89 04 24             	mov    %eax,(%esp)
    12da:	e8 a1 fe ff ff       	call   1180 <printint>
        ap++;
    12df:	83 45 fc 04          	addl   $0x4,0xfffffffc(%ebp)
    12e3:	e9 ea 00 00 00       	jmp    13d2 <printf+0x192>
      } else if(c == 'x' || c == 'p'){
    12e8:	83 7d f0 78          	cmpl   $0x78,0xfffffff0(%ebp)
    12ec:	74 06                	je     12f4 <printf+0xb4>
    12ee:	83 7d f0 70          	cmpl   $0x70,0xfffffff0(%ebp)
    12f2:	75 2d                	jne    1321 <printf+0xe1>
        printint(fd, *ap, 16, 0);
    12f4:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
    12f7:	8b 00                	mov    (%eax),%eax
    12f9:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
    1300:	00 
    1301:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
    1308:	00 
    1309:	89 44 24 04          	mov    %eax,0x4(%esp)
    130d:	8b 45 08             	mov    0x8(%ebp),%eax
    1310:	89 04 24             	mov    %eax,(%esp)
    1313:	e8 68 fe ff ff       	call   1180 <printint>
        ap++;
    1318:	83 45 fc 04          	addl   $0x4,0xfffffffc(%ebp)
    131c:	e9 b1 00 00 00       	jmp    13d2 <printf+0x192>
      } else if(c == 's'){
    1321:	83 7d f0 73          	cmpl   $0x73,0xfffffff0(%ebp)
    1325:	75 43                	jne    136a <printf+0x12a>
        s = (char*)*ap;
    1327:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
    132a:	8b 00                	mov    (%eax),%eax
    132c:	89 45 ec             	mov    %eax,0xffffffec(%ebp)
        ap++;
    132f:	83 45 fc 04          	addl   $0x4,0xfffffffc(%ebp)
        if(s == 0)
    1333:	83 7d ec 00          	cmpl   $0x0,0xffffffec(%ebp)
    1337:	75 25                	jne    135e <printf+0x11e>
          s = "(null)";
    1339:	c7 45 ec b4 1e 00 00 	movl   $0x1eb4,0xffffffec(%ebp)
        while(*s != 0){
    1340:	eb 1c                	jmp    135e <printf+0x11e>
          putc(fd, *s);
    1342:	8b 45 ec             	mov    0xffffffec(%ebp),%eax
    1345:	0f b6 00             	movzbl (%eax),%eax
    1348:	0f be c0             	movsbl %al,%eax
    134b:	89 44 24 04          	mov    %eax,0x4(%esp)
    134f:	8b 45 08             	mov    0x8(%ebp),%eax
    1352:	89 04 24             	mov    %eax,(%esp)
    1355:	e8 f6 fd ff ff       	call   1150 <putc>
          s++;
    135a:	83 45 ec 01          	addl   $0x1,0xffffffec(%ebp)
    135e:	8b 45 ec             	mov    0xffffffec(%ebp),%eax
    1361:	0f b6 00             	movzbl (%eax),%eax
    1364:	84 c0                	test   %al,%al
    1366:	75 da                	jne    1342 <printf+0x102>
    1368:	eb 68                	jmp    13d2 <printf+0x192>
        }
      } else if(c == 'c'){
    136a:	83 7d f0 63          	cmpl   $0x63,0xfffffff0(%ebp)
    136e:	75 1d                	jne    138d <printf+0x14d>
        putc(fd, *ap);
    1370:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
    1373:	8b 00                	mov    (%eax),%eax
    1375:	0f be c0             	movsbl %al,%eax
    1378:	89 44 24 04          	mov    %eax,0x4(%esp)
    137c:	8b 45 08             	mov    0x8(%ebp),%eax
    137f:	89 04 24             	mov    %eax,(%esp)
    1382:	e8 c9 fd ff ff       	call   1150 <putc>
        ap++;
    1387:	83 45 fc 04          	addl   $0x4,0xfffffffc(%ebp)
    138b:	eb 45                	jmp    13d2 <printf+0x192>
      } else if(c == '%'){
    138d:	83 7d f0 25          	cmpl   $0x25,0xfffffff0(%ebp)
    1391:	75 17                	jne    13aa <printf+0x16a>
        putc(fd, c);
    1393:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
    1396:	0f be c0             	movsbl %al,%eax
    1399:	89 44 24 04          	mov    %eax,0x4(%esp)
    139d:	8b 45 08             	mov    0x8(%ebp),%eax
    13a0:	89 04 24             	mov    %eax,(%esp)
    13a3:	e8 a8 fd ff ff       	call   1150 <putc>
    13a8:	eb 28                	jmp    13d2 <printf+0x192>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    13aa:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
    13b1:	00 
    13b2:	8b 45 08             	mov    0x8(%ebp),%eax
    13b5:	89 04 24             	mov    %eax,(%esp)
    13b8:	e8 93 fd ff ff       	call   1150 <putc>
        putc(fd, c);
    13bd:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
    13c0:	0f be c0             	movsbl %al,%eax
    13c3:	89 44 24 04          	mov    %eax,0x4(%esp)
    13c7:	8b 45 08             	mov    0x8(%ebp),%eax
    13ca:	89 04 24             	mov    %eax,(%esp)
    13cd:	e8 7e fd ff ff       	call   1150 <putc>
      }
      state = 0;
    13d2:	c7 45 f8 00 00 00 00 	movl   $0x0,0xfffffff8(%ebp)
    13d9:	83 45 f4 01          	addl   $0x1,0xfffffff4(%ebp)
    13dd:	8b 55 0c             	mov    0xc(%ebp),%edx
    13e0:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
    13e3:	8d 04 02             	lea    (%edx,%eax,1),%eax
    13e6:	0f b6 00             	movzbl (%eax),%eax
    13e9:	84 c0                	test   %al,%al
    13eb:	0f 85 71 fe ff ff    	jne    1262 <printf+0x22>
    }
  }
}
    13f1:	c9                   	leave  
    13f2:	c3                   	ret    
    13f3:	90                   	nop    
    13f4:	90                   	nop    
    13f5:	90                   	nop    
    13f6:	90                   	nop    
    13f7:	90                   	nop    
    13f8:	90                   	nop    
    13f9:	90                   	nop    
    13fa:	90                   	nop    
    13fb:	90                   	nop    
    13fc:	90                   	nop    
    13fd:	90                   	nop    
    13fe:	90                   	nop    
    13ff:	90                   	nop    

00001400 <free>:
static Header *freep;

void
free(void *ap)
{
    1400:	55                   	push   %ebp
    1401:	89 e5                	mov    %esp,%ebp
    1403:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*) ap - 1;
    1406:	8b 45 08             	mov    0x8(%ebp),%eax
    1409:	83 e8 08             	sub    $0x8,%eax
    140c:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    140f:	a1 6c 1f 00 00       	mov    0x1f6c,%eax
    1414:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
    1417:	eb 24                	jmp    143d <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1419:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
    141c:	8b 00                	mov    (%eax),%eax
    141e:	3b 45 fc             	cmp    0xfffffffc(%ebp),%eax
    1421:	77 12                	ja     1435 <free+0x35>
    1423:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
    1426:	3b 45 fc             	cmp    0xfffffffc(%ebp),%eax
    1429:	77 24                	ja     144f <free+0x4f>
    142b:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
    142e:	8b 00                	mov    (%eax),%eax
    1430:	3b 45 f8             	cmp    0xfffffff8(%ebp),%eax
    1433:	77 1a                	ja     144f <free+0x4f>
    1435:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
    1438:	8b 00                	mov    (%eax),%eax
    143a:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
    143d:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
    1440:	3b 45 fc             	cmp    0xfffffffc(%ebp),%eax
    1443:	76 d4                	jbe    1419 <free+0x19>
    1445:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
    1448:	8b 00                	mov    (%eax),%eax
    144a:	3b 45 f8             	cmp    0xfffffff8(%ebp),%eax
    144d:	76 ca                	jbe    1419 <free+0x19>
      break;
  if(bp + bp->s.size == p->s.ptr){
    144f:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
    1452:	8b 40 04             	mov    0x4(%eax),%eax
    1455:	c1 e0 03             	shl    $0x3,%eax
    1458:	89 c2                	mov    %eax,%edx
    145a:	03 55 f8             	add    0xfffffff8(%ebp),%edx
    145d:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
    1460:	8b 00                	mov    (%eax),%eax
    1462:	39 c2                	cmp    %eax,%edx
    1464:	75 24                	jne    148a <free+0x8a>
    bp->s.size += p->s.ptr->s.size;
    1466:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
    1469:	8b 50 04             	mov    0x4(%eax),%edx
    146c:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
    146f:	8b 00                	mov    (%eax),%eax
    1471:	8b 40 04             	mov    0x4(%eax),%eax
    1474:	01 c2                	add    %eax,%edx
    1476:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
    1479:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
    147c:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
    147f:	8b 00                	mov    (%eax),%eax
    1481:	8b 10                	mov    (%eax),%edx
    1483:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
    1486:	89 10                	mov    %edx,(%eax)
    1488:	eb 0a                	jmp    1494 <free+0x94>
  } else
    bp->s.ptr = p->s.ptr;
    148a:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
    148d:	8b 10                	mov    (%eax),%edx
    148f:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
    1492:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
    1494:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
    1497:	8b 40 04             	mov    0x4(%eax),%eax
    149a:	c1 e0 03             	shl    $0x3,%eax
    149d:	03 45 fc             	add    0xfffffffc(%ebp),%eax
    14a0:	3b 45 f8             	cmp    0xfffffff8(%ebp),%eax
    14a3:	75 20                	jne    14c5 <free+0xc5>
    p->s.size += bp->s.size;
    14a5:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
    14a8:	8b 50 04             	mov    0x4(%eax),%edx
    14ab:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
    14ae:	8b 40 04             	mov    0x4(%eax),%eax
    14b1:	01 c2                	add    %eax,%edx
    14b3:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
    14b6:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    14b9:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
    14bc:	8b 10                	mov    (%eax),%edx
    14be:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
    14c1:	89 10                	mov    %edx,(%eax)
    14c3:	eb 08                	jmp    14cd <free+0xcd>
  } else
    p->s.ptr = bp;
    14c5:	8b 55 fc             	mov    0xfffffffc(%ebp),%edx
    14c8:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
    14cb:	89 02                	mov    %eax,(%edx)
  freep = p;
    14cd:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
    14d0:	a3 6c 1f 00 00       	mov    %eax,0x1f6c
}
    14d5:	c9                   	leave  
    14d6:	c3                   	ret    
    14d7:	89 f6                	mov    %esi,%esi
    14d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

000014e0 <morecore>:

static Header*
morecore(uint nu)
{
    14e0:	55                   	push   %ebp
    14e1:	89 e5                	mov    %esp,%ebp
    14e3:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;
  int size;

#ifdef UMALLOC_DEBUG
  printf(1, "morecore: %d\n", nu);
#endif
#ifdef UMALLOC_NOALIGN
  if(nu < PAGE)
    nu = PAGE;
#else
  size = nu * sizeof(Header);
    14e6:	8b 45 08             	mov    0x8(%ebp),%eax
    14e9:	c1 e0 03             	shl    $0x3,%eax
    14ec:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
  size += PAGE - size % PAGE;
    14ef:	8b 55 fc             	mov    0xfffffffc(%ebp),%edx
    14f2:	89 d0                	mov    %edx,%eax
    14f4:	c1 f8 1f             	sar    $0x1f,%eax
    14f7:	89 c1                	mov    %eax,%ecx
    14f9:	c1 e9 14             	shr    $0x14,%ecx
    14fc:	8d 04 0a             	lea    (%edx,%ecx,1),%eax
    14ff:	25 ff 0f 00 00       	and    $0xfff,%eax
    1504:	29 c8                	sub    %ecx,%eax
    1506:	89 c2                	mov    %eax,%edx
    1508:	b8 00 10 00 00       	mov    $0x1000,%eax
    150d:	29 d0                	sub    %edx,%eax
    150f:	01 45 fc             	add    %eax,0xfffffffc(%ebp)
#endif
#ifdef UMALLOC_DEBUG
  printf(1, "size: %d\n", size);
#endif
  p = sbrk(size);
    1512:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
    1515:	89 04 24             	mov    %eax,(%esp)
    1518:	e8 9f fb ff ff       	call   10bc <sbrk>
    151d:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
  if(p == (char*) -1)
    1520:	83 7d f4 ff          	cmpl   $0xffffffff,0xfffffff4(%ebp)
    1524:	75 09                	jne    152f <morecore+0x4f>
    return 0;
    1526:	c7 45 ec 00 00 00 00 	movl   $0x0,0xffffffec(%ebp)
    152d:	eb 2a                	jmp    1559 <morecore+0x79>
  hp = (Header*)p;
    152f:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
    1532:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
#ifdef UMALLOC_NOALIGN
  hp->s.size = nu;
#else
  hp->s.size = size / sizeof(Header);
    1535:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
    1538:	89 c2                	mov    %eax,%edx
    153a:	c1 ea 03             	shr    $0x3,%edx
    153d:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
    1540:	89 50 04             	mov    %edx,0x4(%eax)
#endif
  free((void*)(hp + 1));
    1543:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
    1546:	83 c0 08             	add    $0x8,%eax
    1549:	89 04 24             	mov    %eax,(%esp)
    154c:	e8 af fe ff ff       	call   1400 <free>
  return freep;
    1551:	a1 6c 1f 00 00       	mov    0x1f6c,%eax
    1556:	89 45 ec             	mov    %eax,0xffffffec(%ebp)
    1559:	8b 45 ec             	mov    0xffffffec(%ebp),%eax
}
    155c:	c9                   	leave  
    155d:	c3                   	ret    
    155e:	89 f6                	mov    %esi,%esi

00001560 <malloc>:

void*
malloc(uint nbytes)
{
    1560:	55                   	push   %ebp
    1561:	89 e5                	mov    %esp,%ebp
    1563:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

#ifdef UMALLOC_DEBUG
  printf(1, "malloc: %d bytes\n", nbytes);
  printf(1, "size of Header: %d\n", sizeof(Header));
#endif
  if (PAGE % sizeof(Header))
      printf(2, "Warning! align failed! Need UMALLOC_NOALIGN\n");
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1566:	8b 45 08             	mov    0x8(%ebp),%eax
    1569:	83 c0 07             	add    $0x7,%eax
    156c:	c1 e8 03             	shr    $0x3,%eax
    156f:	83 c0 01             	add    $0x1,%eax
    1572:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
  if((prevp = freep) == 0){
    1575:	a1 6c 1f 00 00       	mov    0x1f6c,%eax
    157a:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
    157d:	83 7d f8 00          	cmpl   $0x0,0xfffffff8(%ebp)
    1581:	75 23                	jne    15a6 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
    1583:	c7 45 f8 64 1f 00 00 	movl   $0x1f64,0xfffffff8(%ebp)
    158a:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
    158d:	a3 6c 1f 00 00       	mov    %eax,0x1f6c
    1592:	a1 6c 1f 00 00       	mov    0x1f6c,%eax
    1597:	a3 64 1f 00 00       	mov    %eax,0x1f64
    base.s.size = 0;
    159c:	c7 05 68 1f 00 00 00 	movl   $0x0,0x1f68
    15a3:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    15a6:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
    15a9:	8b 00                	mov    (%eax),%eax
    15ab:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
    if(p->s.size >= nunits){
    15ae:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
    15b1:	8b 40 04             	mov    0x4(%eax),%eax
    15b4:	3b 45 fc             	cmp    0xfffffffc(%ebp),%eax
    15b7:	72 50                	jb     1609 <malloc+0xa9>
      if(p->s.size == nunits)
    15b9:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
    15bc:	8b 40 04             	mov    0x4(%eax),%eax
    15bf:	3b 45 fc             	cmp    0xfffffffc(%ebp),%eax
    15c2:	75 0c                	jne    15d0 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
    15c4:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
    15c7:	8b 10                	mov    (%eax),%edx
    15c9:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
    15cc:	89 10                	mov    %edx,(%eax)
    15ce:	eb 26                	jmp    15f6 <malloc+0x96>
      else {
        p->s.size -= nunits;
    15d0:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
    15d3:	8b 40 04             	mov    0x4(%eax),%eax
    15d6:	89 c2                	mov    %eax,%edx
    15d8:	2b 55 fc             	sub    0xfffffffc(%ebp),%edx
    15db:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
    15de:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    15e1:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
    15e4:	8b 40 04             	mov    0x4(%eax),%eax
    15e7:	c1 e0 03             	shl    $0x3,%eax
    15ea:	01 45 f4             	add    %eax,0xfffffff4(%ebp)
        p->s.size = nunits;
    15ed:	8b 55 f4             	mov    0xfffffff4(%ebp),%edx
    15f0:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
    15f3:	89 42 04             	mov    %eax,0x4(%edx)
      }
      freep = prevp;
    15f6:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
    15f9:	a3 6c 1f 00 00       	mov    %eax,0x1f6c
      return (void*) (p + 1);
    15fe:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
    1601:	83 c0 08             	add    $0x8,%eax
    1604:	89 45 ec             	mov    %eax,0xffffffec(%ebp)
    1607:	eb 3a                	jmp    1643 <malloc+0xe3>
    }
    if(p == freep)
    1609:	a1 6c 1f 00 00       	mov    0x1f6c,%eax
    160e:	39 45 f4             	cmp    %eax,0xfffffff4(%ebp)
    1611:	75 1d                	jne    1630 <malloc+0xd0>
      if((p = morecore(nunits)) == 0)
    1613:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
    1616:	89 04 24             	mov    %eax,(%esp)
    1619:	e8 c2 fe ff ff       	call   14e0 <morecore>
    161e:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
    1621:	83 7d f4 00          	cmpl   $0x0,0xfffffff4(%ebp)
    1625:	75 09                	jne    1630 <malloc+0xd0>
        return 0;
    1627:	c7 45 ec 00 00 00 00 	movl   $0x0,0xffffffec(%ebp)
    162e:	eb 13                	jmp    1643 <malloc+0xe3>
    1630:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
    1633:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
    1636:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
    1639:	8b 00                	mov    (%eax),%eax
    163b:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
  }
    163e:	e9 6b ff ff ff       	jmp    15ae <malloc+0x4e>
    1643:	8b 45 ec             	mov    0xffffffec(%ebp),%eax
}
    1646:	c9                   	leave  
    1647:	c3                   	ret    
    1648:	90                   	nop    
    1649:	90                   	nop    
    164a:	90                   	nop    
    164b:	90                   	nop    
    164c:	90                   	nop    
    164d:	90                   	nop    
    164e:	90                   	nop    
    164f:	90                   	nop    

00001650 <lwip_chksum>:


static u16_t
lwip_chksum(void *dataptr, int len)
{
    1650:	55                   	push   %ebp
    1651:	89 e5                	mov    %esp,%ebp
    1653:	83 ec 18             	sub    $0x18,%esp
  u32_t acc;

  LWIP_DEBUGF(INET_DEBUG, ("lwip_chksum(%p, %d)\n", (void *)dataptr, len));
  for(acc = 0; len > 1; len -= 2) {
    1656:	c7 45 fc 00 00 00 00 	movl   $0x0,0xfffffffc(%ebp)
    165d:	eb 19                	jmp    1678 <lwip_chksum+0x28>
      /*    acc = acc + *((u16_t *)dataptr)++;*/
    acc += *(u16_t *)dataptr;
    165f:	8b 45 08             	mov    0x8(%ebp),%eax
    1662:	0f b7 00             	movzwl (%eax),%eax
    1665:	0f b7 c0             	movzwl %ax,%eax
    1668:	01 45 fc             	add    %eax,0xfffffffc(%ebp)
    dataptr = (void *)((u16_t *)dataptr + 1);
    166b:	8b 45 08             	mov    0x8(%ebp),%eax
    166e:	83 c0 02             	add    $0x2,%eax
    1671:	89 45 08             	mov    %eax,0x8(%ebp)
    1674:	83 6d 0c 02          	subl   $0x2,0xc(%ebp)
    1678:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
    167c:	7f e1                	jg     165f <lwip_chksum+0xf>
  }

  /* add up any odd byte */
  if (len == 1) {
    167e:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
    1682:	75 1d                	jne    16a1 <lwip_chksum+0x51>
    acc += htons((u16_t)((*(u8_t *)dataptr) & 0xff) << 8);
    1684:	8b 45 08             	mov    0x8(%ebp),%eax
    1687:	0f b6 00             	movzbl (%eax),%eax
    168a:	0f b6 c0             	movzbl %al,%eax
    168d:	c1 e0 08             	shl    $0x8,%eax
    1690:	0f b7 c0             	movzwl %ax,%eax
    1693:	89 04 24             	mov    %eax,(%esp)
    1696:	e8 85 06 00 00       	call   1d20 <htons>
    169b:	0f b7 c0             	movzwl %ax,%eax
    169e:	01 45 fc             	add    %eax,0xfffffffc(%ebp)
    LWIP_DEBUGF(INET_DEBUG, ("inet: chksum: odd byte %d\n", (unsigned int)(*(u8_t *)dataptr)));
  } else {
    LWIP_DEBUGF(INET_DEBUG, ("inet: chksum: no odd byte\n"));
  }
  acc = (acc >> 16) + (acc & 0xffffUL);
    16a1:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
    16a4:	89 c2                	mov    %eax,%edx
    16a6:	c1 ea 10             	shr    $0x10,%edx
    16a9:	0f b7 45 fc          	movzwl 0xfffffffc(%ebp),%eax
    16ad:	8d 04 02             	lea    (%edx,%eax,1),%eax
    16b0:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)

  if ((acc & 0xffff0000) != 0) {
    16b3:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
    16b6:	66 b8 00 00          	mov    $0x0,%ax
    16ba:	85 c0                	test   %eax,%eax
    16bc:	74 12                	je     16d0 <lwip_chksum+0x80>
    acc = (acc >> 16) + (acc & 0xffffUL);
    16be:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
    16c1:	89 c2                	mov    %eax,%edx
    16c3:	c1 ea 10             	shr    $0x10,%edx
    16c6:	0f b7 45 fc          	movzwl 0xfffffffc(%ebp),%eax
    16ca:	8d 04 02             	lea    (%edx,%eax,1),%eax
    16cd:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
  }

  return (u16_t)acc;
    16d0:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
    16d3:	0f b7 c0             	movzwl %ax,%eax
}
    16d6:	c9                   	leave  
    16d7:	c3                   	ret    
    16d8:	90                   	nop    
    16d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi

000016e0 <inet_chksum_pseudo>:

/* inet_chksum_pseudo:
 *
 * Calculates the pseudo Internet checksum used by TCP and UDP for a pbuf chain.
 */

u16_t
inet_chksum_pseudo(struct pbuf *p,
       struct ip_addr *src, struct ip_addr *dest,
       u8_t proto, u16_t proto_len)
{
    16e0:	55                   	push   %ebp
    16e1:	89 e5                	mov    %esp,%ebp
    16e3:	83 ec 28             	sub    $0x28,%esp
    16e6:	8b 45 14             	mov    0x14(%ebp),%eax
    16e9:	8b 55 18             	mov    0x18(%ebp),%edx
    16ec:	88 45 ec             	mov    %al,0xffffffec(%ebp)
    16ef:	66 89 55 e8          	mov    %dx,0xffffffe8(%ebp)
  u32_t acc;
  struct pbuf *q;
  u8_t swapped;

  acc = 0;
    16f3:	c7 45 f4 00 00 00 00 	movl   $0x0,0xfffffff4(%ebp)
  swapped = 0;
    16fa:	c6 45 ff 00          	movb   $0x0,0xffffffff(%ebp)
  /* iterate through all pbuf in chain */
  for(q = p; q != NULL; q = q->next) {
    16fe:	8b 45 08             	mov    0x8(%ebp),%eax
    1701:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
    1704:	eb 7b                	jmp    1781 <inet_chksum_pseudo+0xa1>
    LWIP_DEBUGF(INET_DEBUG, ("inet_chksum_pseudo(): checksumming pbuf %p (has next %p) \n",
      (void *)q, (void *)q->next));
    acc += lwip_chksum(q->payload, q->len);
    1706:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
    1709:	0f b7 40 0a          	movzwl 0xa(%eax),%eax
    170d:	0f b7 d0             	movzwl %ax,%edx
    1710:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
    1713:	8b 40 04             	mov    0x4(%eax),%eax
    1716:	89 54 24 04          	mov    %edx,0x4(%esp)
    171a:	89 04 24             	mov    %eax,(%esp)
    171d:	e8 2e ff ff ff       	call   1650 <lwip_chksum>
    1722:	0f b7 c0             	movzwl %ax,%eax
    1725:	01 45 f4             	add    %eax,0xfffffff4(%ebp)
    /*LWIP_DEBUGF(INET_DEBUG, ("inet_chksum_pseudo(): unwrapped lwip_chksum()=%lx \n", acc));*/
    while (acc >> 16) {
    1728:	eb 10                	jmp    173a <inet_chksum_pseudo+0x5a>
      acc = (acc & 0xffffUL) + (acc >> 16);
    172a:	0f b7 55 f4          	movzwl 0xfffffff4(%ebp),%edx
    172e:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
    1731:	c1 e8 10             	shr    $0x10,%eax
    1734:	8d 04 02             	lea    (%edx,%eax,1),%eax
    1737:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
    173a:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
    173d:	c1 e8 10             	shr    $0x10,%eax
    1740:	85 c0                	test   %eax,%eax
    1742:	75 e6                	jne    172a <inet_chksum_pseudo+0x4a>
    }
    if (q->len % 2 != 0) {
    1744:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
    1747:	0f b7 40 0a          	movzwl 0xa(%eax),%eax
    174b:	0f b7 c0             	movzwl %ax,%eax
    174e:	83 e0 01             	and    $0x1,%eax
    1751:	84 c0                	test   %al,%al
    1753:	74 24                	je     1779 <inet_chksum_pseudo+0x99>
      swapped = 1 - swapped;
    1755:	b8 01 00 00 00       	mov    $0x1,%eax
    175a:	2a 45 ff             	sub    0xffffffff(%ebp),%al
    175d:	88 45 ff             	mov    %al,0xffffffff(%ebp)
      acc = ((acc & 0xff) << 8) | ((acc & 0xff00UL) >> 8);
    1760:	0f b6 45 f4          	movzbl 0xfffffff4(%ebp),%eax
    1764:	89 c2                	mov    %eax,%edx
    1766:	c1 e2 08             	shl    $0x8,%edx
    1769:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
    176c:	25 00 ff 00 00       	and    $0xff00,%eax
    1771:	c1 e8 08             	shr    $0x8,%eax
    1774:	09 d0                	or     %edx,%eax
    1776:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
    1779:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
    177c:	8b 00                	mov    (%eax),%eax
    177e:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
    1781:	83 7d f8 00          	cmpl   $0x0,0xfffffff8(%ebp)
    1785:	0f 85 7b ff ff ff    	jne    1706 <inet_chksum_pseudo+0x26>
    }
    /*LWIP_DEBUGF(INET_DEBUG, ("inet_chksum_pseudo(): wrapped lwip_chksum()=%lx \n", acc));*/
  }

  if (swapped) {
    178b:	80 7d ff 00          	cmpb   $0x0,0xffffffff(%ebp)
    178f:	74 19                	je     17aa <inet_chksum_pseudo+0xca>
    acc = ((acc & 0xff) << 8) | ((acc & 0xff00UL) >> 8);
    1791:	0f b6 45 f4          	movzbl 0xfffffff4(%ebp),%eax
    1795:	89 c2                	mov    %eax,%edx
    1797:	c1 e2 08             	shl    $0x8,%edx
    179a:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
    179d:	25 00 ff 00 00       	and    $0xff00,%eax
    17a2:	c1 e8 08             	shr    $0x8,%eax
    17a5:	09 d0                	or     %edx,%eax
    17a7:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
  }
  acc += (src->addr & 0xffffUL);
    17aa:	8b 45 0c             	mov    0xc(%ebp),%eax
    17ad:	8b 00                	mov    (%eax),%eax
    17af:	25 ff ff 00 00       	and    $0xffff,%eax
    17b4:	01 45 f4             	add    %eax,0xfffffff4(%ebp)
  acc += ((src->addr >> 16) & 0xffffUL);
    17b7:	8b 45 0c             	mov    0xc(%ebp),%eax
    17ba:	8b 00                	mov    (%eax),%eax
    17bc:	c1 e8 10             	shr    $0x10,%eax
    17bf:	25 ff ff 00 00       	and    $0xffff,%eax
    17c4:	01 45 f4             	add    %eax,0xfffffff4(%ebp)
  acc += (dest->addr & 0xffffUL);
    17c7:	8b 45 10             	mov    0x10(%ebp),%eax
    17ca:	8b 00                	mov    (%eax),%eax
    17cc:	25 ff ff 00 00       	and    $0xffff,%eax
    17d1:	01 45 f4             	add    %eax,0xfffffff4(%ebp)
  acc += ((dest->addr >> 16) & 0xffffUL);
    17d4:	8b 45 10             	mov    0x10(%ebp),%eax
    17d7:	8b 00                	mov    (%eax),%eax
    17d9:	c1 e8 10             	shr    $0x10,%eax
    17dc:	25 ff ff 00 00       	and    $0xffff,%eax
    17e1:	01 45 f4             	add    %eax,0xfffffff4(%ebp)
  acc += (u32_t)htons((u16_t)proto);
    17e4:	0f b6 45 ec          	movzbl 0xffffffec(%ebp),%eax
    17e8:	89 04 24             	mov    %eax,(%esp)
    17eb:	e8 30 05 00 00       	call   1d20 <htons>
    17f0:	0f b7 c0             	movzwl %ax,%eax
    17f3:	01 45 f4             	add    %eax,0xfffffff4(%ebp)
  acc += (u32_t)htons(proto_len);
    17f6:	0f b7 45 e8          	movzwl 0xffffffe8(%ebp),%eax
    17fa:	89 04 24             	mov    %eax,(%esp)
    17fd:	e8 1e 05 00 00       	call   1d20 <htons>
    1802:	0f b7 c0             	movzwl %ax,%eax
    1805:	01 45 f4             	add    %eax,0xfffffff4(%ebp)

  while (acc >> 16) {
    1808:	eb 10                	jmp    181a <inet_chksum_pseudo+0x13a>
    acc = (acc & 0xffffUL) + (acc >> 16);
    180a:	0f b7 55 f4          	movzwl 0xfffffff4(%ebp),%edx
    180e:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
    1811:	c1 e8 10             	shr    $0x10,%eax
    1814:	8d 04 02             	lea    (%edx,%eax,1),%eax
    1817:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
    181a:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
    181d:	c1 e8 10             	shr    $0x10,%eax
    1820:	85 c0                	test   %eax,%eax
    1822:	75 e6                	jne    180a <inet_chksum_pseudo+0x12a>
  }
  LWIP_DEBUGF(INET_DEBUG, ("inet_chksum_pseudo(): pbuf chain lwip_chksum()=%lx\n", acc));
  return ~(acc & 0xffffUL);
    1824:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
    1827:	f7 d0                	not    %eax
    1829:	0f b7 c0             	movzwl %ax,%eax
}
    182c:	c9                   	leave  
    182d:	c3                   	ret    
    182e:	89 f6                	mov    %esi,%esi

00001830 <inet_chksum>:

/* inet_chksum:
 *
 * Calculates the Internet checksum over a portion of memory. Used primarely for IP
 * and ICMP.
 */

u16_t
inet_chksum(void *dataptr, u16_t len)
{
    1830:	55                   	push   %ebp
    1831:	89 e5                	mov    %esp,%ebp
    1833:	83 ec 28             	sub    $0x28,%esp
    1836:	8b 45 0c             	mov    0xc(%ebp),%eax
    1839:	66 89 45 ec          	mov    %ax,0xffffffec(%ebp)
  u32_t acc;

  acc = lwip_chksum(dataptr, len);
    183d:	0f b7 45 ec          	movzwl 0xffffffec(%ebp),%eax
    1841:	89 44 24 04          	mov    %eax,0x4(%esp)
    1845:	8b 45 08             	mov    0x8(%ebp),%eax
    1848:	89 04 24             	mov    %eax,(%esp)
    184b:	e8 00 fe ff ff       	call   1650 <lwip_chksum>
    1850:	0f b7 c0             	movzwl %ax,%eax
    1853:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
  while (acc >> 16) {
    1856:	eb 10                	jmp    1868 <inet_chksum+0x38>
    acc = (acc & 0xffff) + (acc >> 16);
    1858:	0f b7 55 fc          	movzwl 0xfffffffc(%ebp),%edx
    185c:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
    185f:	c1 e8 10             	shr    $0x10,%eax
    1862:	8d 04 02             	lea    (%edx,%eax,1),%eax
    1865:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
    1868:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
    186b:	c1 e8 10             	shr    $0x10,%eax
    186e:	85 c0                	test   %eax,%eax
    1870:	75 e6                	jne    1858 <inet_chksum+0x28>
  }
  return ~(acc & 0xffff);
    1872:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
    1875:	f7 d0                	not    %eax
    1877:	0f b7 c0             	movzwl %ax,%eax
}
    187a:	c9                   	leave  
    187b:	c3                   	ret    
    187c:	8d 74 26 00          	lea    0x0(%esi),%esi

00001880 <inet_chksum_pbuf>:

u16_t
inet_chksum_pbuf(struct pbuf *p)
{
    1880:	55                   	push   %ebp
    1881:	89 e5                	mov    %esp,%ebp
    1883:	83 ec 18             	sub    $0x18,%esp
  u32_t acc;
  struct pbuf *q;
  u8_t swapped;

  acc = 0;
    1886:	c7 45 f4 00 00 00 00 	movl   $0x0,0xfffffff4(%ebp)
  swapped = 0;
    188d:	c6 45 ff 00          	movb   $0x0,0xffffffff(%ebp)
  for(q = p; q != NULL; q = q->next) {
    1891:	8b 45 08             	mov    0x8(%ebp),%eax
    1894:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
    1897:	eb 69                	jmp    1902 <inet_chksum_pbuf+0x82>
    acc += lwip_chksum(q->payload, q->len);
    1899:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
    189c:	0f b7 40 0a          	movzwl 0xa(%eax),%eax
    18a0:	0f b7 d0             	movzwl %ax,%edx
    18a3:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
    18a6:	8b 40 04             	mov    0x4(%eax),%eax
    18a9:	89 54 24 04          	mov    %edx,0x4(%esp)
    18ad:	89 04 24             	mov    %eax,(%esp)
    18b0:	e8 9b fd ff ff       	call   1650 <lwip_chksum>
    18b5:	0f b7 c0             	movzwl %ax,%eax
    18b8:	01 45 f4             	add    %eax,0xfffffff4(%ebp)
    while (acc >> 16) {
    18bb:	eb 10                	jmp    18cd <inet_chksum_pbuf+0x4d>
      acc = (acc & 0xffffUL) + (acc >> 16);
    18bd:	0f b7 55 f4          	movzwl 0xfffffff4(%ebp),%edx
    18c1:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
    18c4:	c1 e8 10             	shr    $0x10,%eax
    18c7:	8d 04 02             	lea    (%edx,%eax,1),%eax
    18ca:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
    18cd:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
    18d0:	c1 e8 10             	shr    $0x10,%eax
    18d3:	85 c0                	test   %eax,%eax
    18d5:	75 e6                	jne    18bd <inet_chksum_pbuf+0x3d>
    }
    if (q->len % 2 != 0) {
    18d7:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
    18da:	0f b7 40 0a          	movzwl 0xa(%eax),%eax
    18de:	0f b7 c0             	movzwl %ax,%eax
    18e1:	83 e0 01             	and    $0x1,%eax
    18e4:	84 c0                	test   %al,%al
    18e6:	74 12                	je     18fa <inet_chksum_pbuf+0x7a>
      swapped = 1 - swapped;
    18e8:	b8 01 00 00 00       	mov    $0x1,%eax
    18ed:	2a 45 ff             	sub    0xffffffff(%ebp),%al
    18f0:	88 45 ff             	mov    %al,0xffffffff(%ebp)
      acc = (acc & 0x00ffUL << 8) | (acc & 0xff00UL >> 8);
    18f3:	81 65 f4 ff ff 00 00 	andl   $0xffff,0xfffffff4(%ebp)
    18fa:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
    18fd:	8b 00                	mov    (%eax),%eax
    18ff:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
    1902:	83 7d f8 00          	cmpl   $0x0,0xfffffff8(%ebp)
    1906:	75 91                	jne    1899 <inet_chksum_pbuf+0x19>
    }
  }

  if (swapped) {
    1908:	80 7d ff 00          	cmpb   $0x0,0xffffffff(%ebp)
    190c:	74 19                	je     1927 <inet_chksum_pbuf+0xa7>
    acc = ((acc & 0x00ffUL) << 8) | ((acc & 0xff00UL) >> 8);
    190e:	0f b6 45 f4          	movzbl 0xfffffff4(%ebp),%eax
    1912:	89 c2                	mov    %eax,%edx
    1914:	c1 e2 08             	shl    $0x8,%edx
    1917:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
    191a:	25 00 ff 00 00       	and    $0xff00,%eax
    191f:	c1 e8 08             	shr    $0x8,%eax
    1922:	09 d0                	or     %edx,%eax
    1924:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
  }
  return ~(acc & 0xffffUL);
    1927:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
    192a:	f7 d0                	not    %eax
    192c:	0f b7 c0             	movzwl %ax,%eax
}
    192f:	c9                   	leave  
    1930:	c3                   	ret    
    1931:	eb 0d                	jmp    1940 <inet_addr>
    1933:	90                   	nop    
    1934:	90                   	nop    
    1935:	90                   	nop    
    1936:	90                   	nop    
    1937:	90                   	nop    
    1938:	90                   	nop    
    1939:	90                   	nop    
    193a:	90                   	nop    
    193b:	90                   	nop    
    193c:	90                   	nop    
    193d:	90                   	nop    
    193e:	90                   	nop    
    193f:	90                   	nop    

00001940 <inet_addr>:

/* Here for now until needed in other places in lwIP */
#ifndef isascii
#define in_range(c, lo, up)  ((u8_t)c >= lo && (u8_t)c <= up)
#define isascii(c)           in_range(c, 0x20, 0x7f)
#define isdigit(c)           in_range(c, '0', '9')
#define isxdigit(c)          (isdigit(c) || in_range(c, 'a', 'f') || in_range(c, 'A', 'F'))
#define islower(c)           in_range(c, 'a', 'z')
#define isspace(c)           (c == ' ' || c == '\f' || c == '\n' || c == '\r' || c == '\t' || c == '\v')
#endif		
		

 /*
  * Ascii internet address interpretation routine.
  * The value returned is in network order.
  */

 /*  */
 /* inet_addr */
 u32_t inet_addr(const char *cp)
 {
    1940:	55                   	push   %ebp
    1941:	89 e5                	mov    %esp,%ebp
    1943:	83 ec 28             	sub    $0x28,%esp
     struct in_addr val;

     if (inet_aton(cp, &val)) {
    1946:	8d 45 fc             	lea    0xfffffffc(%ebp),%eax
    1949:	89 44 24 04          	mov    %eax,0x4(%esp)
    194d:	8b 45 08             	mov    0x8(%ebp),%eax
    1950:	89 04 24             	mov    %eax,(%esp)
    1953:	e8 18 00 00 00       	call   1970 <inet_aton>
    1958:	85 c0                	test   %eax,%eax
    195a:	74 08                	je     1964 <inet_addr+0x24>
         return (val.s_addr);
    195c:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
    195f:	89 45 ec             	mov    %eax,0xffffffec(%ebp)
    1962:	eb 07                	jmp    196b <inet_addr+0x2b>
     }
     return (INADDR_NONE);
    1964:	c7 45 ec ff ff ff ff 	movl   $0xffffffff,0xffffffec(%ebp)
    196b:	8b 45 ec             	mov    0xffffffec(%ebp),%eax
 }
    196e:	c9                   	leave  
    196f:	c3                   	ret    

00001970 <inet_aton>:

 /*
  * Check whether "cp" is a valid ascii representation
  * of an Internet address and convert to a binary address.
  * Returns 1 if the address is valid, 0 if not.
  * This replaces inet_addr, the return value from which
  * cannot distinguish between failure and a local broadcast address.
  */
 /*  */
 /* inet_aton */
 int inet_aton(const char *cp, struct in_addr *addr)
 {
    1970:	55                   	push   %ebp
    1971:	89 e5                	mov    %esp,%ebp
    1973:	83 ec 48             	sub    $0x48,%esp
     u32_t val;
     int base, n;
     char c;
     u32_t parts[4];
     u32_t* pp = parts;
    1976:	8d 45 dc             	lea    0xffffffdc(%ebp),%eax
    1979:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)

     c = *cp;
    197c:	8b 45 08             	mov    0x8(%ebp),%eax
    197f:	0f b6 00             	movzbl (%eax),%eax
    1982:	88 45 fb             	mov    %al,0xfffffffb(%ebp)
     for (;;) {
         /*
          * Collect number up to ``.''.
          * Values are specified as for C:
          * 0x=hex, 0=octal, isdigit=decimal.
          */
         if (!isdigit(c))
    1985:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
    1989:	3c 2f                	cmp    $0x2f,%al
    198b:	76 08                	jbe    1995 <inet_aton+0x25>
    198d:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
    1991:	3c 39                	cmp    $0x39,%al
    1993:	76 0c                	jbe    19a1 <inet_aton+0x31>
             return (0);
    1995:	c7 45 c0 00 00 00 00 	movl   $0x0,0xffffffc0(%ebp)
    199c:	e9 78 02 00 00       	jmp    1c19 <inet_aton+0x2a9>
         val = 0; base = 10;
    19a1:	c7 45 ec 00 00 00 00 	movl   $0x0,0xffffffec(%ebp)
    19a8:	c7 45 f0 0a 00 00 00 	movl   $0xa,0xfffffff0(%ebp)
         if (c == '0') {
    19af:	80 7d fb 30          	cmpb   $0x30,0xfffffffb(%ebp)
    19b3:	75 36                	jne    19eb <inet_aton+0x7b>
             c = *++cp;
    19b5:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    19b9:	8b 45 08             	mov    0x8(%ebp),%eax
    19bc:	0f b6 00             	movzbl (%eax),%eax
    19bf:	88 45 fb             	mov    %al,0xfffffffb(%ebp)
             if (c == 'x' || c == 'X')
    19c2:	80 7d fb 78          	cmpb   $0x78,0xfffffffb(%ebp)
    19c6:	74 06                	je     19ce <inet_aton+0x5e>
    19c8:	80 7d fb 58          	cmpb   $0x58,0xfffffffb(%ebp)
    19cc:	75 16                	jne    19e4 <inet_aton+0x74>
                 base = 16, c = *++cp;
    19ce:	c7 45 f0 10 00 00 00 	movl   $0x10,0xfffffff0(%ebp)
    19d5:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    19d9:	8b 45 08             	mov    0x8(%ebp),%eax
    19dc:	0f b6 00             	movzbl (%eax),%eax
    19df:	88 45 fb             	mov    %al,0xfffffffb(%ebp)
    19e2:	eb 07                	jmp    19eb <inet_aton+0x7b>
             else
                 base = 8;
    19e4:	c7 45 f0 08 00 00 00 	movl   $0x8,0xfffffff0(%ebp)
         }
         for (;;) {
             if (isascii(c) && isdigit(c)) {
    19eb:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
    19ef:	3c 1f                	cmp    $0x1f,%al
    19f1:	76 3b                	jbe    1a2e <inet_aton+0xbe>
    19f3:	80 7d fb 00          	cmpb   $0x0,0xfffffffb(%ebp)
    19f7:	78 35                	js     1a2e <inet_aton+0xbe>
    19f9:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
    19fd:	3c 2f                	cmp    $0x2f,%al
    19ff:	76 2d                	jbe    1a2e <inet_aton+0xbe>
    1a01:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
    1a05:	3c 39                	cmp    $0x39,%al
    1a07:	77 25                	ja     1a2e <inet_aton+0xbe>
                 val = (val * base) + (c - '0');
    1a09:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
    1a0c:	89 c2                	mov    %eax,%edx
    1a0e:	0f af 55 ec          	imul   0xffffffec(%ebp),%edx
    1a12:	0f be 45 fb          	movsbl 0xfffffffb(%ebp),%eax
    1a16:	8d 04 02             	lea    (%edx,%eax,1),%eax
    1a19:	83 e8 30             	sub    $0x30,%eax
    1a1c:	89 45 ec             	mov    %eax,0xffffffec(%ebp)
                 c = *++cp;
    1a1f:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    1a23:	8b 45 08             	mov    0x8(%ebp),%eax
    1a26:	0f b6 00             	movzbl (%eax),%eax
    1a29:	88 45 fb             	mov    %al,0xfffffffb(%ebp)
    1a2c:	eb bd                	jmp    19eb <inet_aton+0x7b>
             } else if (base == 16 && isascii(c) && isxdigit(c)) {
    1a2e:	83 7d f0 10          	cmpl   $0x10,0xfffffff0(%ebp)
    1a32:	0f 85 99 00 00 00    	jne    1ad1 <inet_aton+0x161>
    1a38:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
    1a3c:	3c 1f                	cmp    $0x1f,%al
    1a3e:	0f 86 8d 00 00 00    	jbe    1ad1 <inet_aton+0x161>
    1a44:	80 7d fb 00          	cmpb   $0x0,0xfffffffb(%ebp)
    1a48:	0f 88 83 00 00 00    	js     1ad1 <inet_aton+0x161>
    1a4e:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
    1a52:	3c 2f                	cmp    $0x2f,%al
    1a54:	76 08                	jbe    1a5e <inet_aton+0xee>
    1a56:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
    1a5a:	3c 39                	cmp    $0x39,%al
    1a5c:	76 20                	jbe    1a7e <inet_aton+0x10e>
    1a5e:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
    1a62:	3c 60                	cmp    $0x60,%al
    1a64:	76 08                	jbe    1a6e <inet_aton+0xfe>
    1a66:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
    1a6a:	3c 66                	cmp    $0x66,%al
    1a6c:	76 10                	jbe    1a7e <inet_aton+0x10e>
    1a6e:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
    1a72:	3c 40                	cmp    $0x40,%al
    1a74:	76 5b                	jbe    1ad1 <inet_aton+0x161>
    1a76:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
    1a7a:	3c 46                	cmp    $0x46,%al
    1a7c:	77 53                	ja     1ad1 <inet_aton+0x161>
                 val = (val << 4) |
    1a7e:	8b 45 ec             	mov    0xffffffec(%ebp),%eax
    1a81:	89 c2                	mov    %eax,%edx
    1a83:	c1 e2 04             	shl    $0x4,%edx
    1a86:	89 55 c4             	mov    %edx,0xffffffc4(%ebp)
    1a89:	0f be 45 fb          	movsbl 0xfffffffb(%ebp),%eax
    1a8d:	83 c0 0a             	add    $0xa,%eax
    1a90:	89 45 c8             	mov    %eax,0xffffffc8(%ebp)
    1a93:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
    1a97:	3c 60                	cmp    $0x60,%al
    1a99:	76 11                	jbe    1aac <inet_aton+0x13c>
    1a9b:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
    1a9f:	3c 7a                	cmp    $0x7a,%al
    1aa1:	77 09                	ja     1aac <inet_aton+0x13c>
    1aa3:	c7 45 cc 61 00 00 00 	movl   $0x61,0xffffffcc(%ebp)
    1aaa:	eb 07                	jmp    1ab3 <inet_aton+0x143>
    1aac:	c7 45 cc 41 00 00 00 	movl   $0x41,0xffffffcc(%ebp)
    1ab3:	8b 45 c8             	mov    0xffffffc8(%ebp),%eax
    1ab6:	2b 45 cc             	sub    0xffffffcc(%ebp),%eax
    1ab9:	0b 45 c4             	or     0xffffffc4(%ebp),%eax
    1abc:	89 45 ec             	mov    %eax,0xffffffec(%ebp)
                     (c + 10 - (islower(c) ? 'a' : 'A'));
                 c = *++cp;
    1abf:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    1ac3:	8b 45 08             	mov    0x8(%ebp),%eax
    1ac6:	0f b6 00             	movzbl (%eax),%eax
    1ac9:	88 45 fb             	mov    %al,0xfffffffb(%ebp)
             } else
             break;
         }
    1acc:	e9 1a ff ff ff       	jmp    19eb <inet_aton+0x7b>
         if (c == '.') {
    1ad1:	80 7d fb 2e          	cmpb   $0x2e,0xfffffffb(%ebp)
    1ad5:	75 35                	jne    1b0c <inet_aton+0x19c>
             /*
              * Internet format:
              *  a.b.c.d
              *  a.b.c   (with c treated as 16 bits)
              *  a.b (with b treated as 24 bits)
              */
             if (pp >= parts + 3)
    1ad7:	8d 45 dc             	lea    0xffffffdc(%ebp),%eax
    1ada:	83 c0 0c             	add    $0xc,%eax
    1add:	3b 45 fc             	cmp    0xfffffffc(%ebp),%eax
    1ae0:	77 0c                	ja     1aee <inet_aton+0x17e>
                 return (0);
    1ae2:	c7 45 c0 00 00 00 00 	movl   $0x0,0xffffffc0(%ebp)
    1ae9:	e9 2b 01 00 00       	jmp    1c19 <inet_aton+0x2a9>
             *pp++ = val;
    1aee:	8b 55 fc             	mov    0xfffffffc(%ebp),%edx
    1af1:	8b 45 ec             	mov    0xffffffec(%ebp),%eax
    1af4:	89 02                	mov    %eax,(%edx)
    1af6:	83 45 fc 04          	addl   $0x4,0xfffffffc(%ebp)
             c = *++cp;
    1afa:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    1afe:	8b 45 08             	mov    0x8(%ebp),%eax
    1b01:	0f b6 00             	movzbl (%eax),%eax
    1b04:	88 45 fb             	mov    %al,0xfffffffb(%ebp)
         } else
             break;
     }
    1b07:	e9 79 fe ff ff       	jmp    1985 <inet_aton+0x15>
     /*
      * Check for trailing characters.
      */
     if (c != '\0' && (!isascii(c) || !isspace(c)))
    1b0c:	80 7d fb 00          	cmpb   $0x0,0xfffffffb(%ebp)
    1b10:	74 3e                	je     1b50 <inet_aton+0x1e0>
    1b12:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
    1b16:	3c 1f                	cmp    $0x1f,%al
    1b18:	76 2a                	jbe    1b44 <inet_aton+0x1d4>
    1b1a:	80 7d fb 00          	cmpb   $0x0,0xfffffffb(%ebp)
    1b1e:	78 24                	js     1b44 <inet_aton+0x1d4>
    1b20:	80 7d fb 20          	cmpb   $0x20,0xfffffffb(%ebp)
    1b24:	74 2a                	je     1b50 <inet_aton+0x1e0>
    1b26:	80 7d fb 0c          	cmpb   $0xc,0xfffffffb(%ebp)
    1b2a:	74 24                	je     1b50 <inet_aton+0x1e0>
    1b2c:	80 7d fb 0a          	cmpb   $0xa,0xfffffffb(%ebp)
    1b30:	74 1e                	je     1b50 <inet_aton+0x1e0>
    1b32:	80 7d fb 0d          	cmpb   $0xd,0xfffffffb(%ebp)
    1b36:	74 18                	je     1b50 <inet_aton+0x1e0>
    1b38:	80 7d fb 09          	cmpb   $0x9,0xfffffffb(%ebp)
    1b3c:	74 12                	je     1b50 <inet_aton+0x1e0>
    1b3e:	80 7d fb 0b          	cmpb   $0xb,0xfffffffb(%ebp)
    1b42:	74 0c                	je     1b50 <inet_aton+0x1e0>
         return (0);
    1b44:	c7 45 c0 00 00 00 00 	movl   $0x0,0xffffffc0(%ebp)
    1b4b:	e9 c9 00 00 00       	jmp    1c19 <inet_aton+0x2a9>
     /*
      * Concoct the address according to
      * the number of parts specified.
      */
     n = pp - parts + 1;
    1b50:	8b 55 fc             	mov    0xfffffffc(%ebp),%edx
    1b53:	8d 45 dc             	lea    0xffffffdc(%ebp),%eax
    1b56:	89 d1                	mov    %edx,%ecx
    1b58:	29 c1                	sub    %eax,%ecx
    1b5a:	89 c8                	mov    %ecx,%eax
    1b5c:	c1 f8 02             	sar    $0x2,%eax
    1b5f:	83 c0 01             	add    $0x1,%eax
    1b62:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
     switch (n) {
    1b65:	83 7d f4 04          	cmpl   $0x4,0xfffffff4(%ebp)
    1b69:	0f 87 8b 00 00 00    	ja     1bfa <inet_aton+0x28a>
    1b6f:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
    1b72:	c1 e0 02             	shl    $0x2,%eax
    1b75:	8b 80 bc 1e 00 00    	mov    0x1ebc(%eax),%eax
    1b7b:	ff e0                	jmp    *%eax

     case 0:
         return (0);     /* initial nondigit */
    1b7d:	c7 45 c0 00 00 00 00 	movl   $0x0,0xffffffc0(%ebp)
    1b84:	e9 90 00 00 00       	jmp    1c19 <inet_aton+0x2a9>

     case 1:             /* a -- 32 bits */
         break;

     case 2:             /* a.b -- 8.24 bits */
         if (val > 0xffffff)
    1b89:	81 7d ec ff ff ff 00 	cmpl   $0xffffff,0xffffffec(%ebp)
    1b90:	76 09                	jbe    1b9b <inet_aton+0x22b>
             return (0);
    1b92:	c7 45 c0 00 00 00 00 	movl   $0x0,0xffffffc0(%ebp)
    1b99:	eb 7e                	jmp    1c19 <inet_aton+0x2a9>
         val |= parts[0] << 24;
    1b9b:	8b 45 dc             	mov    0xffffffdc(%ebp),%eax
    1b9e:	c1 e0 18             	shl    $0x18,%eax
    1ba1:	09 45 ec             	or     %eax,0xffffffec(%ebp)
         break;
    1ba4:	eb 54                	jmp    1bfa <inet_aton+0x28a>

     case 3:             /* a.b.c -- 8.8.16 bits */
         if (val > 0xffff)
    1ba6:	81 7d ec ff ff 00 00 	cmpl   $0xffff,0xffffffec(%ebp)
    1bad:	76 09                	jbe    1bb8 <inet_aton+0x248>
             return (0);
    1baf:	c7 45 c0 00 00 00 00 	movl   $0x0,0xffffffc0(%ebp)
    1bb6:	eb 61                	jmp    1c19 <inet_aton+0x2a9>
         val |= (parts[0] << 24) | (parts[1] << 16);
    1bb8:	8b 45 dc             	mov    0xffffffdc(%ebp),%eax
    1bbb:	89 c2                	mov    %eax,%edx
    1bbd:	c1 e2 18             	shl    $0x18,%edx
    1bc0:	8b 45 e0             	mov    0xffffffe0(%ebp),%eax
    1bc3:	c1 e0 10             	shl    $0x10,%eax
    1bc6:	09 d0                	or     %edx,%eax
    1bc8:	09 45 ec             	or     %eax,0xffffffec(%ebp)
         break;
    1bcb:	eb 2d                	jmp    1bfa <inet_aton+0x28a>

     case 4:             /* a.b.c.d -- 8.8.8.8 bits */
         if (val > 0xff)
    1bcd:	81 7d ec ff 00 00 00 	cmpl   $0xff,0xffffffec(%ebp)
    1bd4:	76 09                	jbe    1bdf <inet_aton+0x26f>
             return (0);
    1bd6:	c7 45 c0 00 00 00 00 	movl   $0x0,0xffffffc0(%ebp)
    1bdd:	eb 3a                	jmp    1c19 <inet_aton+0x2a9>
         val |= (parts[0] << 24) | (parts[1] << 16) | (parts[2] << 8);
    1bdf:	8b 45 dc             	mov    0xffffffdc(%ebp),%eax
    1be2:	89 c2                	mov    %eax,%edx
    1be4:	c1 e2 18             	shl    $0x18,%edx
    1be7:	8b 45 e0             	mov    0xffffffe0(%ebp),%eax
    1bea:	c1 e0 10             	shl    $0x10,%eax
    1bed:	09 c2                	or     %eax,%edx
    1bef:	8b 45 e4             	mov    0xffffffe4(%ebp),%eax
    1bf2:	c1 e0 08             	shl    $0x8,%eax
    1bf5:	09 d0                	or     %edx,%eax
    1bf7:	09 45 ec             	or     %eax,0xffffffec(%ebp)
         break;
     }
     if (addr)
    1bfa:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1bfe:	74 12                	je     1c12 <inet_aton+0x2a2>
         addr->s_addr = htonl(val);
    1c00:	8b 45 ec             	mov    0xffffffec(%ebp),%eax
    1c03:	89 04 24             	mov    %eax,(%esp)
    1c06:	e8 65 01 00 00       	call   1d70 <htonl>
    1c0b:	89 c2                	mov    %eax,%edx
    1c0d:	8b 45 0c             	mov    0xc(%ebp),%eax
    1c10:	89 10                	mov    %edx,(%eax)
     return (1);
    1c12:	c7 45 c0 01 00 00 00 	movl   $0x1,0xffffffc0(%ebp)
    1c19:	8b 45 c0             	mov    0xffffffc0(%ebp),%eax
 }
    1c1c:	c9                   	leave  
    1c1d:	c3                   	ret    
    1c1e:	89 f6                	mov    %esi,%esi

00001c20 <inet_ntoa>:

/* Convert numeric IP address into decimal dotted ASCII representation.
 * returns ptr to static buffer; not reentrant!
 */
char *inet_ntoa(struct in_addr addr)
{
    1c20:	55                   	push   %ebp
    1c21:	89 e5                	mov    %esp,%ebp
    1c23:	53                   	push   %ebx
    1c24:	83 ec 24             	sub    $0x24,%esp
  static char str[16];
  u32_t s_addr = addr.s_addr;
    1c27:	8b 45 08             	mov    0x8(%ebp),%eax
    1c2a:	89 45 ec             	mov    %eax,0xffffffec(%ebp)
  char inv[3];
  char *rp;
  char *ap;
  u8_t rem;
  u8_t n;
  u8_t i;

  rp = str;
    1c2d:	c7 45 f0 70 1f 00 00 	movl   $0x1f70,0xfffffff0(%ebp)
  ap = (u8_t *)&s_addr;
    1c34:	8d 45 ec             	lea    0xffffffec(%ebp),%eax
    1c37:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
  for(n = 0; n < 4; n++) {
    1c3a:	c6 45 fa 00          	movb   $0x0,0xfffffffa(%ebp)
    1c3e:	e9 af 00 00 00       	jmp    1cf2 <inet_ntoa+0xd2>
    i = 0;
    1c43:	c6 45 fb 00          	movb   $0x0,0xfffffffb(%ebp)
    do {
      rem = *ap % (u8_t)10;
    1c47:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
    1c4a:	0f b6 08             	movzbl (%eax),%ecx
    1c4d:	b8 67 00 00 00       	mov    $0x67,%eax
    1c52:	f6 e9                	imul   %cl
    1c54:	66 c1 e8 08          	shr    $0x8,%ax
    1c58:	89 c2                	mov    %eax,%edx
    1c5a:	c0 fa 02             	sar    $0x2,%dl
    1c5d:	89 c8                	mov    %ecx,%eax
    1c5f:	c0 f8 07             	sar    $0x7,%al
    1c62:	89 d3                	mov    %edx,%ebx
    1c64:	28 c3                	sub    %al,%bl
    1c66:	88 5d db             	mov    %bl,0xffffffdb(%ebp)
    1c69:	0f b6 45 db          	movzbl 0xffffffdb(%ebp),%eax
    1c6d:	c1 e0 02             	shl    $0x2,%eax
    1c70:	02 45 db             	add    0xffffffdb(%ebp),%al
    1c73:	01 c0                	add    %eax,%eax
    1c75:	89 ca                	mov    %ecx,%edx
    1c77:	28 c2                	sub    %al,%dl
    1c79:	88 55 db             	mov    %dl,0xffffffdb(%ebp)
    1c7c:	0f b6 5d db          	movzbl 0xffffffdb(%ebp),%ebx
    1c80:	88 5d f9             	mov    %bl,0xfffffff9(%ebp)
      *ap /= (u8_t)10;
    1c83:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
    1c86:	0f b6 08             	movzbl (%eax),%ecx
    1c89:	b8 67 00 00 00       	mov    $0x67,%eax
    1c8e:	f6 e9                	imul   %cl
    1c90:	66 c1 e8 08          	shr    $0x8,%ax
    1c94:	89 c2                	mov    %eax,%edx
    1c96:	c0 fa 02             	sar    $0x2,%dl
    1c99:	89 c8                	mov    %ecx,%eax
    1c9b:	c0 f8 07             	sar    $0x7,%al
    1c9e:	28 c2                	sub    %al,%dl
    1ca0:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
    1ca3:	88 10                	mov    %dl,(%eax)
      inv[i++] = '0' + rem;
    1ca5:	0f b6 55 fb          	movzbl 0xfffffffb(%ebp),%edx
    1ca9:	0f b6 45 f9          	movzbl 0xfffffff9(%ebp),%eax
    1cad:	83 c0 30             	add    $0x30,%eax
    1cb0:	88 44 15 e9          	mov    %al,0xffffffe9(%ebp,%edx,1)
    1cb4:	80 45 fb 01          	addb   $0x1,0xfffffffb(%ebp)
    } while(*ap);
    1cb8:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
    1cbb:	0f b6 00             	movzbl (%eax),%eax
    1cbe:	84 c0                	test   %al,%al
    1cc0:	75 85                	jne    1c47 <inet_ntoa+0x27>
    while(i--)
    1cc2:	eb 12                	jmp    1cd6 <inet_ntoa+0xb6>
      *rp++ = inv[i];
    1cc4:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
    1cc8:	0f b6 54 05 e9       	movzbl 0xffffffe9(%ebp,%eax,1),%edx
    1ccd:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
    1cd0:	88 10                	mov    %dl,(%eax)
    1cd2:	83 45 f0 01          	addl   $0x1,0xfffffff0(%ebp)
    1cd6:	80 6d fb 01          	subb   $0x1,0xfffffffb(%ebp)
    1cda:	80 7d fb ff          	cmpb   $0xff,0xfffffffb(%ebp)
    1cde:	75 e4                	jne    1cc4 <inet_ntoa+0xa4>
    *rp++ = '.';
    1ce0:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
    1ce3:	c6 00 2e             	movb   $0x2e,(%eax)
    1ce6:	83 45 f0 01          	addl   $0x1,0xfffffff0(%ebp)
    ap++;
    1cea:	83 45 f4 01          	addl   $0x1,0xfffffff4(%ebp)
    1cee:	80 45 fa 01          	addb   $0x1,0xfffffffa(%ebp)
    1cf2:	80 7d fa 03          	cmpb   $0x3,0xfffffffa(%ebp)
    1cf6:	0f 86 47 ff ff ff    	jbe    1c43 <inet_ntoa+0x23>
  }
  *--rp = 0;
    1cfc:	83 6d f0 01          	subl   $0x1,0xfffffff0(%ebp)
    1d00:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
    1d03:	c6 00 00             	movb   $0x0,(%eax)
  return str;
    1d06:	b8 70 1f 00 00       	mov    $0x1f70,%eax
}
    1d0b:	83 c4 24             	add    $0x24,%esp
    1d0e:	5b                   	pop    %ebx
    1d0f:	5d                   	pop    %ebp
    1d10:	c3                   	ret    
    1d11:	eb 0d                	jmp    1d20 <htons>
    1d13:	90                   	nop    
    1d14:	90                   	nop    
    1d15:	90                   	nop    
    1d16:	90                   	nop    
    1d17:	90                   	nop    
    1d18:	90                   	nop    
    1d19:	90                   	nop    
    1d1a:	90                   	nop    
    1d1b:	90                   	nop    
    1d1c:	90                   	nop    
    1d1d:	90                   	nop    
    1d1e:	90                   	nop    
    1d1f:	90                   	nop    

00001d20 <htons>:


#ifndef BYTE_ORDER
#error BYTE_ORDER is not defined
#endif
#if BYTE_ORDER == LITTLE_ENDIAN

u16_t
htons(u16_t n)
{
    1d20:	55                   	push   %ebp
    1d21:	89 e5                	mov    %esp,%ebp
    1d23:	83 ec 04             	sub    $0x4,%esp
    1d26:	8b 45 08             	mov    0x8(%ebp),%eax
    1d29:	66 89 45 fc          	mov    %ax,0xfffffffc(%ebp)
  return ((n & 0xff) << 8) | ((n & 0xff00) >> 8);
    1d2d:	0f b7 45 fc          	movzwl 0xfffffffc(%ebp),%eax
    1d31:	25 ff 00 00 00       	and    $0xff,%eax
    1d36:	c1 e0 08             	shl    $0x8,%eax
    1d39:	89 c2                	mov    %eax,%edx
    1d3b:	0f b7 45 fc          	movzwl 0xfffffffc(%ebp),%eax
    1d3f:	25 00 ff 00 00       	and    $0xff00,%eax
    1d44:	c1 f8 08             	sar    $0x8,%eax
    1d47:	09 d0                	or     %edx,%eax
    1d49:	0f b7 c0             	movzwl %ax,%eax
}
    1d4c:	c9                   	leave  
    1d4d:	c3                   	ret    
    1d4e:	89 f6                	mov    %esi,%esi

00001d50 <ntohs>:

u16_t
ntohs(u16_t n)
{
    1d50:	55                   	push   %ebp
    1d51:	89 e5                	mov    %esp,%ebp
    1d53:	83 ec 08             	sub    $0x8,%esp
    1d56:	8b 45 08             	mov    0x8(%ebp),%eax
    1d59:	66 89 45 fc          	mov    %ax,0xfffffffc(%ebp)
  return htons(n);
    1d5d:	0f b7 45 fc          	movzwl 0xfffffffc(%ebp),%eax
    1d61:	89 04 24             	mov    %eax,(%esp)
    1d64:	e8 b7 ff ff ff       	call   1d20 <htons>
    1d69:	0f b7 c0             	movzwl %ax,%eax
}
    1d6c:	c9                   	leave  
    1d6d:	c3                   	ret    
    1d6e:	89 f6                	mov    %esi,%esi

00001d70 <htonl>:

u32_t
htonl(u32_t n)
{
    1d70:	55                   	push   %ebp
    1d71:	89 e5                	mov    %esp,%ebp
  return ((n & 0xff) << 24) |
    1d73:	0f b6 45 08          	movzbl 0x8(%ebp),%eax
    1d77:	89 c2                	mov    %eax,%edx
    1d79:	c1 e2 18             	shl    $0x18,%edx
    1d7c:	8b 45 08             	mov    0x8(%ebp),%eax
    1d7f:	25 00 ff 00 00       	and    $0xff00,%eax
    1d84:	c1 e0 08             	shl    $0x8,%eax
    1d87:	09 c2                	or     %eax,%edx
    1d89:	8b 45 08             	mov    0x8(%ebp),%eax
    1d8c:	25 00 00 ff 00       	and    $0xff0000,%eax
    1d91:	c1 e8 08             	shr    $0x8,%eax
    1d94:	09 c2                	or     %eax,%edx
    1d96:	8b 45 08             	mov    0x8(%ebp),%eax
    1d99:	25 00 00 00 ff       	and    $0xff000000,%eax
    1d9e:	c1 e8 18             	shr    $0x18,%eax
    1da1:	09 d0                	or     %edx,%eax
    ((n & 0xff00) << 8) |
    ((n & 0xff0000) >> 8) |
    ((n & 0xff000000) >> 24);
}
    1da3:	5d                   	pop    %ebp
    1da4:	c3                   	ret    
    1da5:	8d 74 26 00          	lea    0x0(%esi),%esi
    1da9:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00001db0 <ntohl>:

u32_t
ntohl(u32_t n)
{
    1db0:	55                   	push   %ebp
    1db1:	89 e5                	mov    %esp,%ebp
    1db3:	83 ec 04             	sub    $0x4,%esp
  return htonl(n);
    1db6:	8b 45 08             	mov    0x8(%ebp),%eax
    1db9:	89 04 24             	mov    %eax,(%esp)
    1dbc:	e8 af ff ff ff       	call   1d70 <htonl>
}
    1dc1:	c9                   	leave  
    1dc2:	c3                   	ret    
