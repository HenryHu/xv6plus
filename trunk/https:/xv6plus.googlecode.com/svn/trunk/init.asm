
_init:     file format elf32-i386-freebsd

Disassembly of section .text:

00000000 <main>:
char *sh_args[] = { "sh", 0 };

int
main(void)
{
       0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
       4:	83 e4 f0             	and    $0xfffffff0,%esp
       7:	ff 71 fc             	pushl  0xfffffffc(%ecx)
       a:	55                   	push   %ebp
       b:	89 e5                	mov    %esp,%ebp
       d:	51                   	push   %ecx
       e:	83 ec 24             	sub    $0x24,%esp
  int pid, wpid;

  if(open("console", O_RDWR) < 0){
      11:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
      18:	00 
      19:	c7 04 24 27 11 00 00 	movl   $0x1127,(%esp)
      20:	e8 af 03 00 00       	call   3d4 <open>
      25:	85 c0                	test   %eax,%eax
      27:	79 30                	jns    59 <main+0x59>
    mknod("console", 1, 1);
      29:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
      30:	00 
      31:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
      38:	00 
      39:	c7 04 24 27 11 00 00 	movl   $0x1127,(%esp)
      40:	e8 97 03 00 00       	call   3dc <mknod>
    open("console", O_RDWR);
      45:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
      4c:	00 
      4d:	c7 04 24 27 11 00 00 	movl   $0x1127,(%esp)
      54:	e8 7b 03 00 00       	call   3d4 <open>
  }
  dup(0);  // stdout
      59:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
      60:	e8 a7 03 00 00       	call   40c <dup>
  dup(0);  // stderr
      65:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
      6c:	e8 9b 03 00 00       	call   40c <dup>

  for(;;){
    printf(1, "init: starting sh\n");
      71:	c7 44 24 04 2f 11 00 	movl   $0x112f,0x4(%esp)
      78:	00 
      79:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
      80:	e8 1b 05 00 00       	call   5a0 <printf>
    pid = fork();
      85:	e8 02 03 00 00       	call   38c <fork>
      8a:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
    if(pid < 0){
      8d:	83 7d f4 00          	cmpl   $0x0,0xfffffff4(%ebp)
      91:	79 19                	jns    ac <main+0xac>
      printf(1, "init: fork failed\n");
      93:	c7 44 24 04 42 11 00 	movl   $0x1142,0x4(%esp)
      9a:	00 
      9b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
      a2:	e8 f9 04 00 00       	call   5a0 <printf>
      exit();
      a7:	e8 e8 02 00 00       	call   394 <exit>
    }
    if(pid == 0){
      ac:	83 7d f4 00          	cmpl   $0x0,0xfffffff4(%ebp)
      b0:	75 2d                	jne    df <main+0xdf>
      exec("sh", sh_args);
      b2:	c7 44 24 04 88 11 00 	movl   $0x1188,0x4(%esp)
      b9:	00 
      ba:	c7 04 24 24 11 00 00 	movl   $0x1124,(%esp)
      c1:	e8 06 03 00 00       	call   3cc <exec>
      printf(1, "init: exec sh failed\n");
      c6:	c7 44 24 04 55 11 00 	movl   $0x1155,0x4(%esp)
      cd:	00 
      ce:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
      d5:	e8 c6 04 00 00       	call   5a0 <printf>
      exit();
      da:	e8 b5 02 00 00       	call   394 <exit>
    }
    while((wpid=wait()) >= 0 && wpid != pid)
      df:	e8 b8 02 00 00       	call   39c <wait>
      e4:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
      e7:	83 7d f8 00          	cmpl   $0x0,0xfffffff8(%ebp)
      eb:	78 84                	js     71 <main+0x71>
      ed:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
      f0:	3b 45 f4             	cmp    0xfffffff4(%ebp),%eax
      f3:	75 ea                	jne    df <main+0xdf>
    {
#if 0
      printf(1, "zombie!\n");
#endif
    }
  }
      f5:	e9 77 ff ff ff       	jmp    71 <main+0x71>
      fa:	90                   	nop    
      fb:	90                   	nop    
      fc:	90                   	nop    
      fd:	90                   	nop    
      fe:	90                   	nop    
      ff:	90                   	nop    

00000100 <strcpy>:
#include "user.h"

char*
strcpy(char *s, char *t)
{
     100:	55                   	push   %ebp
     101:	89 e5                	mov    %esp,%ebp
     103:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
     106:	8b 45 08             	mov    0x8(%ebp),%eax
     109:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
  while((*s++ = *t++) != 0)
     10c:	8b 45 0c             	mov    0xc(%ebp),%eax
     10f:	0f b6 10             	movzbl (%eax),%edx
     112:	8b 45 08             	mov    0x8(%ebp),%eax
     115:	88 10                	mov    %dl,(%eax)
     117:	8b 45 08             	mov    0x8(%ebp),%eax
     11a:	0f b6 00             	movzbl (%eax),%eax
     11d:	84 c0                	test   %al,%al
     11f:	0f 95 c0             	setne  %al
     122:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     126:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
     12a:	84 c0                	test   %al,%al
     12c:	75 de                	jne    10c <strcpy+0xc>
    ;
  return os;
     12e:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
}
     131:	c9                   	leave  
     132:	c3                   	ret    
     133:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     139:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00000140 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     140:	55                   	push   %ebp
     141:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
     143:	eb 08                	jmp    14d <strcmp+0xd>
    p++, q++;
     145:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     149:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
     14d:	8b 45 08             	mov    0x8(%ebp),%eax
     150:	0f b6 00             	movzbl (%eax),%eax
     153:	84 c0                	test   %al,%al
     155:	74 10                	je     167 <strcmp+0x27>
     157:	8b 45 08             	mov    0x8(%ebp),%eax
     15a:	0f b6 10             	movzbl (%eax),%edx
     15d:	8b 45 0c             	mov    0xc(%ebp),%eax
     160:	0f b6 00             	movzbl (%eax),%eax
     163:	38 c2                	cmp    %al,%dl
     165:	74 de                	je     145 <strcmp+0x5>
  return (uchar)*p - (uchar)*q;
     167:	8b 45 08             	mov    0x8(%ebp),%eax
     16a:	0f b6 00             	movzbl (%eax),%eax
     16d:	0f b6 d0             	movzbl %al,%edx
     170:	8b 45 0c             	mov    0xc(%ebp),%eax
     173:	0f b6 00             	movzbl (%eax),%eax
     176:	0f b6 c0             	movzbl %al,%eax
     179:	89 d1                	mov    %edx,%ecx
     17b:	29 c1                	sub    %eax,%ecx
     17d:	89 c8                	mov    %ecx,%eax
}
     17f:	5d                   	pop    %ebp
     180:	c3                   	ret    
     181:	eb 0d                	jmp    190 <strlen>
     183:	90                   	nop    
     184:	90                   	nop    
     185:	90                   	nop    
     186:	90                   	nop    
     187:	90                   	nop    
     188:	90                   	nop    
     189:	90                   	nop    
     18a:	90                   	nop    
     18b:	90                   	nop    
     18c:	90                   	nop    
     18d:	90                   	nop    
     18e:	90                   	nop    
     18f:	90                   	nop    

00000190 <strlen>:

uint
strlen(char *s)
{
     190:	55                   	push   %ebp
     191:	89 e5                	mov    %esp,%ebp
     193:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
     196:	c7 45 fc 00 00 00 00 	movl   $0x0,0xfffffffc(%ebp)
     19d:	eb 04                	jmp    1a3 <strlen+0x13>
     19f:	83 45 fc 01          	addl   $0x1,0xfffffffc(%ebp)
     1a3:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     1a6:	03 45 08             	add    0x8(%ebp),%eax
     1a9:	0f b6 00             	movzbl (%eax),%eax
     1ac:	84 c0                	test   %al,%al
     1ae:	75 ef                	jne    19f <strlen+0xf>
    ;
  return n;
     1b0:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
}
     1b3:	c9                   	leave  
     1b4:	c3                   	ret    
     1b5:	8d 74 26 00          	lea    0x0(%esi),%esi
     1b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

000001c0 <memset>:

void*
memset(void *dst, int c, uint n)
{
     1c0:	55                   	push   %ebp
     1c1:	89 e5                	mov    %esp,%ebp
     1c3:	83 ec 10             	sub    $0x10,%esp
  char *d;
  
  d = dst;
     1c6:	8b 45 08             	mov    0x8(%ebp),%eax
     1c9:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
  while(n-- > 0)
     1cc:	eb 0e                	jmp    1dc <memset+0x1c>
    *d++ = c;
     1ce:	8b 45 0c             	mov    0xc(%ebp),%eax
     1d1:	89 c2                	mov    %eax,%edx
     1d3:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     1d6:	88 10                	mov    %dl,(%eax)
     1d8:	83 45 fc 01          	addl   $0x1,0xfffffffc(%ebp)
     1dc:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
     1e0:	83 7d 10 ff          	cmpl   $0xffffffff,0x10(%ebp)
     1e4:	75 e8                	jne    1ce <memset+0xe>
  return dst;
     1e6:	8b 45 08             	mov    0x8(%ebp),%eax
}
     1e9:	c9                   	leave  
     1ea:	c3                   	ret    
     1eb:	90                   	nop    
     1ec:	8d 74 26 00          	lea    0x0(%esi),%esi

000001f0 <strchr>:

char*
strchr(const char *s, char c)
{
     1f0:	55                   	push   %ebp
     1f1:	89 e5                	mov    %esp,%ebp
     1f3:	83 ec 08             	sub    $0x8,%esp
     1f6:	8b 45 0c             	mov    0xc(%ebp),%eax
     1f9:	88 45 fc             	mov    %al,0xfffffffc(%ebp)
  for(; *s; s++)
     1fc:	eb 17                	jmp    215 <strchr+0x25>
    if(*s == c)
     1fe:	8b 45 08             	mov    0x8(%ebp),%eax
     201:	0f b6 00             	movzbl (%eax),%eax
     204:	3a 45 fc             	cmp    0xfffffffc(%ebp),%al
     207:	75 08                	jne    211 <strchr+0x21>
      return (char*) s;
     209:	8b 45 08             	mov    0x8(%ebp),%eax
     20c:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
     20f:	eb 15                	jmp    226 <strchr+0x36>
     211:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     215:	8b 45 08             	mov    0x8(%ebp),%eax
     218:	0f b6 00             	movzbl (%eax),%eax
     21b:	84 c0                	test   %al,%al
     21d:	75 df                	jne    1fe <strchr+0xe>
  return 0;
     21f:	c7 45 f8 00 00 00 00 	movl   $0x0,0xfffffff8(%ebp)
     226:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
}
     229:	c9                   	leave  
     22a:	c3                   	ret    
     22b:	90                   	nop    
     22c:	8d 74 26 00          	lea    0x0(%esi),%esi

00000230 <gets>:

char*
gets(char *buf, int max)
{
     230:	55                   	push   %ebp
     231:	89 e5                	mov    %esp,%ebp
     233:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     236:	c7 45 f8 00 00 00 00 	movl   $0x0,0xfffffff8(%ebp)
     23d:	eb 46                	jmp    285 <gets+0x55>
    cc = read(0, &c, 1);
     23f:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
     246:	00 
     247:	8d 45 f7             	lea    0xfffffff7(%ebp),%eax
     24a:	89 44 24 04          	mov    %eax,0x4(%esp)
     24e:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     255:	e8 52 01 00 00       	call   3ac <read>
     25a:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
    if(cc < 1)
     25d:	83 7d fc 00          	cmpl   $0x0,0xfffffffc(%ebp)
     261:	7e 2d                	jle    290 <gets+0x60>
      break;
    buf[i++] = c;
     263:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     266:	89 c2                	mov    %eax,%edx
     268:	03 55 08             	add    0x8(%ebp),%edx
     26b:	0f b6 45 f7          	movzbl 0xfffffff7(%ebp),%eax
     26f:	88 02                	mov    %al,(%edx)
     271:	83 45 f8 01          	addl   $0x1,0xfffffff8(%ebp)
    if(c == '\n' || c == '\r')
     275:	0f b6 45 f7          	movzbl 0xfffffff7(%ebp),%eax
     279:	3c 0a                	cmp    $0xa,%al
     27b:	74 13                	je     290 <gets+0x60>
     27d:	0f b6 45 f7          	movzbl 0xfffffff7(%ebp),%eax
     281:	3c 0d                	cmp    $0xd,%al
     283:	74 0b                	je     290 <gets+0x60>
     285:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     288:	83 c0 01             	add    $0x1,%eax
     28b:	3b 45 0c             	cmp    0xc(%ebp),%eax
     28e:	7c af                	jl     23f <gets+0xf>
      break;
  }
  buf[i] = '\0';
     290:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     293:	03 45 08             	add    0x8(%ebp),%eax
     296:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
     299:	8b 45 08             	mov    0x8(%ebp),%eax
}
     29c:	c9                   	leave  
     29d:	c3                   	ret    
     29e:	89 f6                	mov    %esi,%esi

000002a0 <stat>:

int
stat(char *n, struct stat *st)
{
     2a0:	55                   	push   %ebp
     2a1:	89 e5                	mov    %esp,%ebp
     2a3:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     2a6:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     2ad:	00 
     2ae:	8b 45 08             	mov    0x8(%ebp),%eax
     2b1:	89 04 24             	mov    %eax,(%esp)
     2b4:	e8 1b 01 00 00       	call   3d4 <open>
     2b9:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
  if(fd < 0)
     2bc:	83 7d f8 00          	cmpl   $0x0,0xfffffff8(%ebp)
     2c0:	79 09                	jns    2cb <stat+0x2b>
    return -1;
     2c2:	c7 45 ec ff ff ff ff 	movl   $0xffffffff,0xffffffec(%ebp)
     2c9:	eb 26                	jmp    2f1 <stat+0x51>
  r = fstat(fd, st);
     2cb:	8b 45 0c             	mov    0xc(%ebp),%eax
     2ce:	89 44 24 04          	mov    %eax,0x4(%esp)
     2d2:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     2d5:	89 04 24             	mov    %eax,(%esp)
     2d8:	e8 0f 01 00 00       	call   3ec <fstat>
     2dd:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
  close(fd);
     2e0:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     2e3:	89 04 24             	mov    %eax,(%esp)
     2e6:	e8 d1 00 00 00       	call   3bc <close>
  return r;
     2eb:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     2ee:	89 45 ec             	mov    %eax,0xffffffec(%ebp)
     2f1:	8b 45 ec             	mov    0xffffffec(%ebp),%eax
}
     2f4:	c9                   	leave  
     2f5:	c3                   	ret    
     2f6:	8d 76 00             	lea    0x0(%esi),%esi
     2f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00000300 <atoi>:

int
atoi(const char *s)
{
     300:	55                   	push   %ebp
     301:	89 e5                	mov    %esp,%ebp
     303:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
     306:	c7 45 fc 00 00 00 00 	movl   $0x0,0xfffffffc(%ebp)
  while('0' <= *s && *s <= '9')
     30d:	eb 24                	jmp    333 <atoi+0x33>
    n = n*10 + *s++ - '0';
     30f:	8b 55 fc             	mov    0xfffffffc(%ebp),%edx
     312:	89 d0                	mov    %edx,%eax
     314:	c1 e0 02             	shl    $0x2,%eax
     317:	01 d0                	add    %edx,%eax
     319:	01 c0                	add    %eax,%eax
     31b:	89 c2                	mov    %eax,%edx
     31d:	8b 45 08             	mov    0x8(%ebp),%eax
     320:	0f b6 00             	movzbl (%eax),%eax
     323:	0f be c0             	movsbl %al,%eax
     326:	8d 04 02             	lea    (%edx,%eax,1),%eax
     329:	83 e8 30             	sub    $0x30,%eax
     32c:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
     32f:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     333:	8b 45 08             	mov    0x8(%ebp),%eax
     336:	0f b6 00             	movzbl (%eax),%eax
     339:	3c 2f                	cmp    $0x2f,%al
     33b:	7e 0a                	jle    347 <atoi+0x47>
     33d:	8b 45 08             	mov    0x8(%ebp),%eax
     340:	0f b6 00             	movzbl (%eax),%eax
     343:	3c 39                	cmp    $0x39,%al
     345:	7e c8                	jle    30f <atoi+0xf>
  return n;
     347:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
}
     34a:	c9                   	leave  
     34b:	c3                   	ret    
     34c:	8d 74 26 00          	lea    0x0(%esi),%esi

00000350 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
     350:	55                   	push   %ebp
     351:	89 e5                	mov    %esp,%ebp
     353:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
     356:	8b 45 08             	mov    0x8(%ebp),%eax
     359:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
  src = vsrc;
     35c:	8b 45 0c             	mov    0xc(%ebp),%eax
     35f:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
  while(n-- > 0)
     362:	eb 13                	jmp    377 <memmove+0x27>
    *dst++ = *src++;
     364:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     367:	0f b6 10             	movzbl (%eax),%edx
     36a:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     36d:	88 10                	mov    %dl,(%eax)
     36f:	83 45 f8 01          	addl   $0x1,0xfffffff8(%ebp)
     373:	83 45 fc 01          	addl   $0x1,0xfffffffc(%ebp)
     377:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     37b:	0f 9f c0             	setg   %al
     37e:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
     382:	84 c0                	test   %al,%al
     384:	75 de                	jne    364 <memmove+0x14>
  return vdst;
     386:	8b 45 08             	mov    0x8(%ebp),%eax
}
     389:	c9                   	leave  
     38a:	c3                   	ret    
     38b:	90                   	nop    

0000038c <fork>:
     38c:	b8 01 00 00 00       	mov    $0x1,%eax
     391:	cd 30                	int    $0x30
     393:	c3                   	ret    

00000394 <exit>:
     394:	b8 02 00 00 00       	mov    $0x2,%eax
     399:	cd 30                	int    $0x30
     39b:	c3                   	ret    

0000039c <wait>:
     39c:	b8 03 00 00 00       	mov    $0x3,%eax
     3a1:	cd 30                	int    $0x30
     3a3:	c3                   	ret    

000003a4 <pipe>:
     3a4:	b8 04 00 00 00       	mov    $0x4,%eax
     3a9:	cd 30                	int    $0x30
     3ab:	c3                   	ret    

000003ac <read>:
     3ac:	b8 06 00 00 00       	mov    $0x6,%eax
     3b1:	cd 30                	int    $0x30
     3b3:	c3                   	ret    

000003b4 <write>:
     3b4:	b8 05 00 00 00       	mov    $0x5,%eax
     3b9:	cd 30                	int    $0x30
     3bb:	c3                   	ret    

000003bc <close>:
     3bc:	b8 07 00 00 00       	mov    $0x7,%eax
     3c1:	cd 30                	int    $0x30
     3c3:	c3                   	ret    

000003c4 <kill>:
     3c4:	b8 08 00 00 00       	mov    $0x8,%eax
     3c9:	cd 30                	int    $0x30
     3cb:	c3                   	ret    

000003cc <exec>:
     3cc:	b8 09 00 00 00       	mov    $0x9,%eax
     3d1:	cd 30                	int    $0x30
     3d3:	c3                   	ret    

000003d4 <open>:
     3d4:	b8 0a 00 00 00       	mov    $0xa,%eax
     3d9:	cd 30                	int    $0x30
     3db:	c3                   	ret    

000003dc <mknod>:
     3dc:	b8 0b 00 00 00       	mov    $0xb,%eax
     3e1:	cd 30                	int    $0x30
     3e3:	c3                   	ret    

000003e4 <unlink>:
     3e4:	b8 0c 00 00 00       	mov    $0xc,%eax
     3e9:	cd 30                	int    $0x30
     3eb:	c3                   	ret    

000003ec <fstat>:
     3ec:	b8 0d 00 00 00       	mov    $0xd,%eax
     3f1:	cd 30                	int    $0x30
     3f3:	c3                   	ret    

000003f4 <link>:
     3f4:	b8 0e 00 00 00       	mov    $0xe,%eax
     3f9:	cd 30                	int    $0x30
     3fb:	c3                   	ret    

000003fc <mkdir>:
     3fc:	b8 0f 00 00 00       	mov    $0xf,%eax
     401:	cd 30                	int    $0x30
     403:	c3                   	ret    

00000404 <chdir>:
     404:	b8 10 00 00 00       	mov    $0x10,%eax
     409:	cd 30                	int    $0x30
     40b:	c3                   	ret    

0000040c <dup>:
     40c:	b8 11 00 00 00       	mov    $0x11,%eax
     411:	cd 30                	int    $0x30
     413:	c3                   	ret    

00000414 <getpid>:
     414:	b8 12 00 00 00       	mov    $0x12,%eax
     419:	cd 30                	int    $0x30
     41b:	c3                   	ret    

0000041c <sbrk>:
     41c:	b8 13 00 00 00       	mov    $0x13,%eax
     421:	cd 30                	int    $0x30
     423:	c3                   	ret    

00000424 <sleep>:
     424:	b8 14 00 00 00       	mov    $0x14,%eax
     429:	cd 30                	int    $0x30
     42b:	c3                   	ret    

0000042c <upmsec>:
     42c:	b8 15 00 00 00       	mov    $0x15,%eax
     431:	cd 30                	int    $0x30
     433:	c3                   	ret    

00000434 <socket>:
     434:	b8 16 00 00 00       	mov    $0x16,%eax
     439:	cd 30                	int    $0x30
     43b:	c3                   	ret    

0000043c <bind>:
     43c:	b8 17 00 00 00       	mov    $0x17,%eax
     441:	cd 30                	int    $0x30
     443:	c3                   	ret    

00000444 <listen>:
     444:	b8 18 00 00 00       	mov    $0x18,%eax
     449:	cd 30                	int    $0x30
     44b:	c3                   	ret    

0000044c <accept>:
     44c:	b8 19 00 00 00       	mov    $0x19,%eax
     451:	cd 30                	int    $0x30
     453:	c3                   	ret    

00000454 <recv>:
     454:	b8 1a 00 00 00       	mov    $0x1a,%eax
     459:	cd 30                	int    $0x30
     45b:	c3                   	ret    

0000045c <recvfrom>:
     45c:	b8 1b 00 00 00       	mov    $0x1b,%eax
     461:	cd 30                	int    $0x30
     463:	c3                   	ret    

00000464 <send>:
     464:	b8 1c 00 00 00       	mov    $0x1c,%eax
     469:	cd 30                	int    $0x30
     46b:	c3                   	ret    

0000046c <sendto>:
     46c:	b8 1d 00 00 00       	mov    $0x1d,%eax
     471:	cd 30                	int    $0x30
     473:	c3                   	ret    

00000474 <shutdown>:
     474:	b8 1e 00 00 00       	mov    $0x1e,%eax
     479:	cd 30                	int    $0x30
     47b:	c3                   	ret    

0000047c <getsockopt>:
     47c:	b8 1f 00 00 00       	mov    $0x1f,%eax
     481:	cd 30                	int    $0x30
     483:	c3                   	ret    

00000484 <setsockopt>:
     484:	b8 20 00 00 00       	mov    $0x20,%eax
     489:	cd 30                	int    $0x30
     48b:	c3                   	ret    

0000048c <sockclose>:
     48c:	b8 21 00 00 00       	mov    $0x21,%eax
     491:	cd 30                	int    $0x30
     493:	c3                   	ret    

00000494 <connect>:
     494:	b8 22 00 00 00       	mov    $0x22,%eax
     499:	cd 30                	int    $0x30
     49b:	c3                   	ret    

0000049c <getpeername>:
     49c:	b8 23 00 00 00       	mov    $0x23,%eax
     4a1:	cd 30                	int    $0x30
     4a3:	c3                   	ret    

000004a4 <getsockname>:
     4a4:	b8 24 00 00 00       	mov    $0x24,%eax
     4a9:	cd 30                	int    $0x30
     4ab:	c3                   	ret    
     4ac:	90                   	nop    
     4ad:	90                   	nop    
     4ae:	90                   	nop    
     4af:	90                   	nop    

000004b0 <putc>:
#include "user.h"

void
putc(int fd, char c)
{
     4b0:	55                   	push   %ebp
     4b1:	89 e5                	mov    %esp,%ebp
     4b3:	83 ec 18             	sub    $0x18,%esp
     4b6:	8b 45 0c             	mov    0xc(%ebp),%eax
     4b9:	88 45 fc             	mov    %al,0xfffffffc(%ebp)
  write(fd, &c, 1);
     4bc:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
     4c3:	00 
     4c4:	8d 45 fc             	lea    0xfffffffc(%ebp),%eax
     4c7:	89 44 24 04          	mov    %eax,0x4(%esp)
     4cb:	8b 45 08             	mov    0x8(%ebp),%eax
     4ce:	89 04 24             	mov    %eax,(%esp)
     4d1:	e8 de fe ff ff       	call   3b4 <write>
}
     4d6:	c9                   	leave  
     4d7:	c3                   	ret    
     4d8:	90                   	nop    
     4d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi

000004e0 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     4e0:	55                   	push   %ebp
     4e1:	89 e5                	mov    %esp,%ebp
     4e3:	53                   	push   %ebx
     4e4:	83 ec 34             	sub    $0x34,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     4e7:	c7 45 f4 00 00 00 00 	movl   $0x0,0xfffffff4(%ebp)
  if(sgn && xx < 0){
     4ee:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
     4f2:	74 17                	je     50b <printint+0x2b>
     4f4:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     4f8:	79 11                	jns    50b <printint+0x2b>
    neg = 1;
     4fa:	c7 45 f4 01 00 00 00 	movl   $0x1,0xfffffff4(%ebp)
    x = -xx;
     501:	8b 45 0c             	mov    0xc(%ebp),%eax
     504:	f7 d8                	neg    %eax
     506:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
     509:	eb 06                	jmp    511 <printint+0x31>
  } else {
    x = xx;
     50b:	8b 45 0c             	mov    0xc(%ebp),%eax
     50e:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
  }

  i = 0;
     511:	c7 45 f0 00 00 00 00 	movl   $0x0,0xfffffff0(%ebp)
  do{
    buf[i++] = digits[x % base];
     518:	8b 4d f0             	mov    0xfffffff0(%ebp),%ecx
     51b:	8b 55 10             	mov    0x10(%ebp),%edx
     51e:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     521:	89 d3                	mov    %edx,%ebx
     523:	ba 00 00 00 00       	mov    $0x0,%edx
     528:	f7 f3                	div    %ebx
     52a:	89 d0                	mov    %edx,%eax
     52c:	0f b6 80 90 11 00 00 	movzbl 0x1190(%eax),%eax
     533:	88 44 0d e0          	mov    %al,0xffffffe0(%ebp,%ecx,1)
     537:	83 45 f0 01          	addl   $0x1,0xfffffff0(%ebp)
  }while((x /= base) != 0);
     53b:	8b 55 10             	mov    0x10(%ebp),%edx
     53e:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     541:	89 d1                	mov    %edx,%ecx
     543:	ba 00 00 00 00       	mov    $0x0,%edx
     548:	f7 f1                	div    %ecx
     54a:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
     54d:	83 7d f8 00          	cmpl   $0x0,0xfffffff8(%ebp)
     551:	75 c5                	jne    518 <printint+0x38>
  if(neg)
     553:	83 7d f4 00          	cmpl   $0x0,0xfffffff4(%ebp)
     557:	74 28                	je     581 <printint+0xa1>
    buf[i++] = '-';
     559:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
     55c:	c6 44 05 e0 2d       	movb   $0x2d,0xffffffe0(%ebp,%eax,1)
     561:	83 45 f0 01          	addl   $0x1,0xfffffff0(%ebp)

  while(--i >= 0)
     565:	eb 1a                	jmp    581 <printint+0xa1>
    putc(fd, buf[i]);
     567:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
     56a:	0f b6 44 05 e0       	movzbl 0xffffffe0(%ebp,%eax,1),%eax
     56f:	0f be c0             	movsbl %al,%eax
     572:	89 44 24 04          	mov    %eax,0x4(%esp)
     576:	8b 45 08             	mov    0x8(%ebp),%eax
     579:	89 04 24             	mov    %eax,(%esp)
     57c:	e8 2f ff ff ff       	call   4b0 <putc>
     581:	83 6d f0 01          	subl   $0x1,0xfffffff0(%ebp)
     585:	83 7d f0 00          	cmpl   $0x0,0xfffffff0(%ebp)
     589:	79 dc                	jns    567 <printint+0x87>
}
     58b:	83 c4 34             	add    $0x34,%esp
     58e:	5b                   	pop    %ebx
     58f:	5d                   	pop    %ebp
     590:	c3                   	ret    
     591:	eb 0d                	jmp    5a0 <printf>
     593:	90                   	nop    
     594:	90                   	nop    
     595:	90                   	nop    
     596:	90                   	nop    
     597:	90                   	nop    
     598:	90                   	nop    
     599:	90                   	nop    
     59a:	90                   	nop    
     59b:	90                   	nop    
     59c:	90                   	nop    
     59d:	90                   	nop    
     59e:	90                   	nop    
     59f:	90                   	nop    

000005a0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
     5a0:	55                   	push   %ebp
     5a1:	89 e5                	mov    %esp,%ebp
     5a3:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
     5a6:	c7 45 f8 00 00 00 00 	movl   $0x0,0xfffffff8(%ebp)
  ap = (uint*)(void*)&fmt + 1;
     5ad:	8d 45 0c             	lea    0xc(%ebp),%eax
     5b0:	83 c0 04             	add    $0x4,%eax
     5b3:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
  for(i = 0; fmt[i]; i++){
     5b6:	c7 45 f4 00 00 00 00 	movl   $0x0,0xfffffff4(%ebp)
     5bd:	e9 7b 01 00 00       	jmp    73d <printf+0x19d>
    c = fmt[i] & 0xff;
     5c2:	8b 55 0c             	mov    0xc(%ebp),%edx
     5c5:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     5c8:	8d 04 02             	lea    (%edx,%eax,1),%eax
     5cb:	0f b6 00             	movzbl (%eax),%eax
     5ce:	0f be c0             	movsbl %al,%eax
     5d1:	25 ff 00 00 00       	and    $0xff,%eax
     5d6:	89 45 f0             	mov    %eax,0xfffffff0(%ebp)
    if(state == 0){
     5d9:	83 7d f8 00          	cmpl   $0x0,0xfffffff8(%ebp)
     5dd:	75 2c                	jne    60b <printf+0x6b>
      if(c == '%'){
     5df:	83 7d f0 25          	cmpl   $0x25,0xfffffff0(%ebp)
     5e3:	75 0c                	jne    5f1 <printf+0x51>
        state = '%';
     5e5:	c7 45 f8 25 00 00 00 	movl   $0x25,0xfffffff8(%ebp)
     5ec:	e9 48 01 00 00       	jmp    739 <printf+0x199>
      } else {
        putc(fd, c);
     5f1:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
     5f4:	0f be c0             	movsbl %al,%eax
     5f7:	89 44 24 04          	mov    %eax,0x4(%esp)
     5fb:	8b 45 08             	mov    0x8(%ebp),%eax
     5fe:	89 04 24             	mov    %eax,(%esp)
     601:	e8 aa fe ff ff       	call   4b0 <putc>
     606:	e9 2e 01 00 00       	jmp    739 <printf+0x199>
      }
    } else if(state == '%'){
     60b:	83 7d f8 25          	cmpl   $0x25,0xfffffff8(%ebp)
     60f:	0f 85 24 01 00 00    	jne    739 <printf+0x199>
      if(c == 'd'){
     615:	83 7d f0 64          	cmpl   $0x64,0xfffffff0(%ebp)
     619:	75 2d                	jne    648 <printf+0xa8>
        printint(fd, *ap, 10, 1);
     61b:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     61e:	8b 00                	mov    (%eax),%eax
     620:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
     627:	00 
     628:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
     62f:	00 
     630:	89 44 24 04          	mov    %eax,0x4(%esp)
     634:	8b 45 08             	mov    0x8(%ebp),%eax
     637:	89 04 24             	mov    %eax,(%esp)
     63a:	e8 a1 fe ff ff       	call   4e0 <printint>
        ap++;
     63f:	83 45 fc 04          	addl   $0x4,0xfffffffc(%ebp)
     643:	e9 ea 00 00 00       	jmp    732 <printf+0x192>
      } else if(c == 'x' || c == 'p'){
     648:	83 7d f0 78          	cmpl   $0x78,0xfffffff0(%ebp)
     64c:	74 06                	je     654 <printf+0xb4>
     64e:	83 7d f0 70          	cmpl   $0x70,0xfffffff0(%ebp)
     652:	75 2d                	jne    681 <printf+0xe1>
        printint(fd, *ap, 16, 0);
     654:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     657:	8b 00                	mov    (%eax),%eax
     659:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
     660:	00 
     661:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
     668:	00 
     669:	89 44 24 04          	mov    %eax,0x4(%esp)
     66d:	8b 45 08             	mov    0x8(%ebp),%eax
     670:	89 04 24             	mov    %eax,(%esp)
     673:	e8 68 fe ff ff       	call   4e0 <printint>
        ap++;
     678:	83 45 fc 04          	addl   $0x4,0xfffffffc(%ebp)
     67c:	e9 b1 00 00 00       	jmp    732 <printf+0x192>
      } else if(c == 's'){
     681:	83 7d f0 73          	cmpl   $0x73,0xfffffff0(%ebp)
     685:	75 43                	jne    6ca <printf+0x12a>
        s = (char*)*ap;
     687:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     68a:	8b 00                	mov    (%eax),%eax
     68c:	89 45 ec             	mov    %eax,0xffffffec(%ebp)
        ap++;
     68f:	83 45 fc 04          	addl   $0x4,0xfffffffc(%ebp)
        if(s == 0)
     693:	83 7d ec 00          	cmpl   $0x0,0xffffffec(%ebp)
     697:	75 25                	jne    6be <printf+0x11e>
          s = "(null)";
     699:	c7 45 ec 6b 11 00 00 	movl   $0x116b,0xffffffec(%ebp)
        while(*s != 0){
     6a0:	eb 1c                	jmp    6be <printf+0x11e>
          putc(fd, *s);
     6a2:	8b 45 ec             	mov    0xffffffec(%ebp),%eax
     6a5:	0f b6 00             	movzbl (%eax),%eax
     6a8:	0f be c0             	movsbl %al,%eax
     6ab:	89 44 24 04          	mov    %eax,0x4(%esp)
     6af:	8b 45 08             	mov    0x8(%ebp),%eax
     6b2:	89 04 24             	mov    %eax,(%esp)
     6b5:	e8 f6 fd ff ff       	call   4b0 <putc>
          s++;
     6ba:	83 45 ec 01          	addl   $0x1,0xffffffec(%ebp)
     6be:	8b 45 ec             	mov    0xffffffec(%ebp),%eax
     6c1:	0f b6 00             	movzbl (%eax),%eax
     6c4:	84 c0                	test   %al,%al
     6c6:	75 da                	jne    6a2 <printf+0x102>
     6c8:	eb 68                	jmp    732 <printf+0x192>
        }
      } else if(c == 'c'){
     6ca:	83 7d f0 63          	cmpl   $0x63,0xfffffff0(%ebp)
     6ce:	75 1d                	jne    6ed <printf+0x14d>
        putc(fd, *ap);
     6d0:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     6d3:	8b 00                	mov    (%eax),%eax
     6d5:	0f be c0             	movsbl %al,%eax
     6d8:	89 44 24 04          	mov    %eax,0x4(%esp)
     6dc:	8b 45 08             	mov    0x8(%ebp),%eax
     6df:	89 04 24             	mov    %eax,(%esp)
     6e2:	e8 c9 fd ff ff       	call   4b0 <putc>
        ap++;
     6e7:	83 45 fc 04          	addl   $0x4,0xfffffffc(%ebp)
     6eb:	eb 45                	jmp    732 <printf+0x192>
      } else if(c == '%'){
     6ed:	83 7d f0 25          	cmpl   $0x25,0xfffffff0(%ebp)
     6f1:	75 17                	jne    70a <printf+0x16a>
        putc(fd, c);
     6f3:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
     6f6:	0f be c0             	movsbl %al,%eax
     6f9:	89 44 24 04          	mov    %eax,0x4(%esp)
     6fd:	8b 45 08             	mov    0x8(%ebp),%eax
     700:	89 04 24             	mov    %eax,(%esp)
     703:	e8 a8 fd ff ff       	call   4b0 <putc>
     708:	eb 28                	jmp    732 <printf+0x192>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     70a:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
     711:	00 
     712:	8b 45 08             	mov    0x8(%ebp),%eax
     715:	89 04 24             	mov    %eax,(%esp)
     718:	e8 93 fd ff ff       	call   4b0 <putc>
        putc(fd, c);
     71d:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
     720:	0f be c0             	movsbl %al,%eax
     723:	89 44 24 04          	mov    %eax,0x4(%esp)
     727:	8b 45 08             	mov    0x8(%ebp),%eax
     72a:	89 04 24             	mov    %eax,(%esp)
     72d:	e8 7e fd ff ff       	call   4b0 <putc>
      }
      state = 0;
     732:	c7 45 f8 00 00 00 00 	movl   $0x0,0xfffffff8(%ebp)
     739:	83 45 f4 01          	addl   $0x1,0xfffffff4(%ebp)
     73d:	8b 55 0c             	mov    0xc(%ebp),%edx
     740:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     743:	8d 04 02             	lea    (%edx,%eax,1),%eax
     746:	0f b6 00             	movzbl (%eax),%eax
     749:	84 c0                	test   %al,%al
     74b:	0f 85 71 fe ff ff    	jne    5c2 <printf+0x22>
    }
  }
}
     751:	c9                   	leave  
     752:	c3                   	ret    
     753:	90                   	nop    
     754:	90                   	nop    
     755:	90                   	nop    
     756:	90                   	nop    
     757:	90                   	nop    
     758:	90                   	nop    
     759:	90                   	nop    
     75a:	90                   	nop    
     75b:	90                   	nop    
     75c:	90                   	nop    
     75d:	90                   	nop    
     75e:	90                   	nop    
     75f:	90                   	nop    

00000760 <free>:
static Header *freep;

void
free(void *ap)
{
     760:	55                   	push   %ebp
     761:	89 e5                	mov    %esp,%ebp
     763:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*) ap - 1;
     766:	8b 45 08             	mov    0x8(%ebp),%eax
     769:	83 e8 08             	sub    $0x8,%eax
     76c:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     76f:	a1 ac 11 00 00       	mov    0x11ac,%eax
     774:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
     777:	eb 24                	jmp    79d <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     779:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     77c:	8b 00                	mov    (%eax),%eax
     77e:	3b 45 fc             	cmp    0xfffffffc(%ebp),%eax
     781:	77 12                	ja     795 <free+0x35>
     783:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     786:	3b 45 fc             	cmp    0xfffffffc(%ebp),%eax
     789:	77 24                	ja     7af <free+0x4f>
     78b:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     78e:	8b 00                	mov    (%eax),%eax
     790:	3b 45 f8             	cmp    0xfffffff8(%ebp),%eax
     793:	77 1a                	ja     7af <free+0x4f>
     795:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     798:	8b 00                	mov    (%eax),%eax
     79a:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
     79d:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     7a0:	3b 45 fc             	cmp    0xfffffffc(%ebp),%eax
     7a3:	76 d4                	jbe    779 <free+0x19>
     7a5:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     7a8:	8b 00                	mov    (%eax),%eax
     7aa:	3b 45 f8             	cmp    0xfffffff8(%ebp),%eax
     7ad:	76 ca                	jbe    779 <free+0x19>
      break;
  if(bp + bp->s.size == p->s.ptr){
     7af:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     7b2:	8b 40 04             	mov    0x4(%eax),%eax
     7b5:	c1 e0 03             	shl    $0x3,%eax
     7b8:	89 c2                	mov    %eax,%edx
     7ba:	03 55 f8             	add    0xfffffff8(%ebp),%edx
     7bd:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     7c0:	8b 00                	mov    (%eax),%eax
     7c2:	39 c2                	cmp    %eax,%edx
     7c4:	75 24                	jne    7ea <free+0x8a>
    bp->s.size += p->s.ptr->s.size;
     7c6:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     7c9:	8b 50 04             	mov    0x4(%eax),%edx
     7cc:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     7cf:	8b 00                	mov    (%eax),%eax
     7d1:	8b 40 04             	mov    0x4(%eax),%eax
     7d4:	01 c2                	add    %eax,%edx
     7d6:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     7d9:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
     7dc:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     7df:	8b 00                	mov    (%eax),%eax
     7e1:	8b 10                	mov    (%eax),%edx
     7e3:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     7e6:	89 10                	mov    %edx,(%eax)
     7e8:	eb 0a                	jmp    7f4 <free+0x94>
  } else
    bp->s.ptr = p->s.ptr;
     7ea:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     7ed:	8b 10                	mov    (%eax),%edx
     7ef:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     7f2:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
     7f4:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     7f7:	8b 40 04             	mov    0x4(%eax),%eax
     7fa:	c1 e0 03             	shl    $0x3,%eax
     7fd:	03 45 fc             	add    0xfffffffc(%ebp),%eax
     800:	3b 45 f8             	cmp    0xfffffff8(%ebp),%eax
     803:	75 20                	jne    825 <free+0xc5>
    p->s.size += bp->s.size;
     805:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     808:	8b 50 04             	mov    0x4(%eax),%edx
     80b:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     80e:	8b 40 04             	mov    0x4(%eax),%eax
     811:	01 c2                	add    %eax,%edx
     813:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     816:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
     819:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     81c:	8b 10                	mov    (%eax),%edx
     81e:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     821:	89 10                	mov    %edx,(%eax)
     823:	eb 08                	jmp    82d <free+0xcd>
  } else
    p->s.ptr = bp;
     825:	8b 55 fc             	mov    0xfffffffc(%ebp),%edx
     828:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     82b:	89 02                	mov    %eax,(%edx)
  freep = p;
     82d:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     830:	a3 ac 11 00 00       	mov    %eax,0x11ac
}
     835:	c9                   	leave  
     836:	c3                   	ret    
     837:	89 f6                	mov    %esi,%esi
     839:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00000840 <morecore>:

static Header*
morecore(uint nu)
{
     840:	55                   	push   %ebp
     841:	89 e5                	mov    %esp,%ebp
     843:	83 ec 18             	sub    $0x18,%esp
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
     846:	8b 45 08             	mov    0x8(%ebp),%eax
     849:	c1 e0 03             	shl    $0x3,%eax
     84c:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
  size += PAGE - size % PAGE;
     84f:	8b 55 fc             	mov    0xfffffffc(%ebp),%edx
     852:	89 d0                	mov    %edx,%eax
     854:	c1 f8 1f             	sar    $0x1f,%eax
     857:	89 c1                	mov    %eax,%ecx
     859:	c1 e9 14             	shr    $0x14,%ecx
     85c:	8d 04 0a             	lea    (%edx,%ecx,1),%eax
     85f:	25 ff 0f 00 00       	and    $0xfff,%eax
     864:	29 c8                	sub    %ecx,%eax
     866:	89 c2                	mov    %eax,%edx
     868:	b8 00 10 00 00       	mov    $0x1000,%eax
     86d:	29 d0                	sub    %edx,%eax
     86f:	01 45 fc             	add    %eax,0xfffffffc(%ebp)
#endif
#ifdef UMALLOC_DEBUG
  printf(1, "size: %d\n", size);
#endif
  p = sbrk(size);
     872:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     875:	89 04 24             	mov    %eax,(%esp)
     878:	e8 9f fb ff ff       	call   41c <sbrk>
     87d:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
  if(p == (char*) -1)
     880:	83 7d f4 ff          	cmpl   $0xffffffff,0xfffffff4(%ebp)
     884:	75 09                	jne    88f <morecore+0x4f>
    return 0;
     886:	c7 45 ec 00 00 00 00 	movl   $0x0,0xffffffec(%ebp)
     88d:	eb 2a                	jmp    8b9 <morecore+0x79>
  hp = (Header*)p;
     88f:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     892:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
#ifdef UMALLOC_NOALIGN
  hp->s.size = nu;
#else
  hp->s.size = size / sizeof(Header);
     895:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     898:	89 c2                	mov    %eax,%edx
     89a:	c1 ea 03             	shr    $0x3,%edx
     89d:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     8a0:	89 50 04             	mov    %edx,0x4(%eax)
#endif
  free((void*)(hp + 1));
     8a3:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     8a6:	83 c0 08             	add    $0x8,%eax
     8a9:	89 04 24             	mov    %eax,(%esp)
     8ac:	e8 af fe ff ff       	call   760 <free>
  return freep;
     8b1:	a1 ac 11 00 00       	mov    0x11ac,%eax
     8b6:	89 45 ec             	mov    %eax,0xffffffec(%ebp)
     8b9:	8b 45 ec             	mov    0xffffffec(%ebp),%eax
}
     8bc:	c9                   	leave  
     8bd:	c3                   	ret    
     8be:	89 f6                	mov    %esi,%esi

000008c0 <malloc>:

void*
malloc(uint nbytes)
{
     8c0:	55                   	push   %ebp
     8c1:	89 e5                	mov    %esp,%ebp
     8c3:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

#ifdef UMALLOC_DEBUG
  printf(1, "malloc: %d bytes\n", nbytes);
  printf(1, "size of Header: %d\n", sizeof(Header));
#endif
  if (PAGE % sizeof(Header))
      printf(2, "Warning! align failed! Need UMALLOC_NOALIGN\n");
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     8c6:	8b 45 08             	mov    0x8(%ebp),%eax
     8c9:	83 c0 07             	add    $0x7,%eax
     8cc:	c1 e8 03             	shr    $0x3,%eax
     8cf:	83 c0 01             	add    $0x1,%eax
     8d2:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
  if((prevp = freep) == 0){
     8d5:	a1 ac 11 00 00       	mov    0x11ac,%eax
     8da:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
     8dd:	83 7d f8 00          	cmpl   $0x0,0xfffffff8(%ebp)
     8e1:	75 23                	jne    906 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
     8e3:	c7 45 f8 a4 11 00 00 	movl   $0x11a4,0xfffffff8(%ebp)
     8ea:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     8ed:	a3 ac 11 00 00       	mov    %eax,0x11ac
     8f2:	a1 ac 11 00 00       	mov    0x11ac,%eax
     8f7:	a3 a4 11 00 00       	mov    %eax,0x11a4
    base.s.size = 0;
     8fc:	c7 05 a8 11 00 00 00 	movl   $0x0,0x11a8
     903:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     906:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     909:	8b 00                	mov    (%eax),%eax
     90b:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
    if(p->s.size >= nunits){
     90e:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     911:	8b 40 04             	mov    0x4(%eax),%eax
     914:	3b 45 fc             	cmp    0xfffffffc(%ebp),%eax
     917:	72 50                	jb     969 <malloc+0xa9>
      if(p->s.size == nunits)
     919:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     91c:	8b 40 04             	mov    0x4(%eax),%eax
     91f:	3b 45 fc             	cmp    0xfffffffc(%ebp),%eax
     922:	75 0c                	jne    930 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
     924:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     927:	8b 10                	mov    (%eax),%edx
     929:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     92c:	89 10                	mov    %edx,(%eax)
     92e:	eb 26                	jmp    956 <malloc+0x96>
      else {
        p->s.size -= nunits;
     930:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     933:	8b 40 04             	mov    0x4(%eax),%eax
     936:	89 c2                	mov    %eax,%edx
     938:	2b 55 fc             	sub    0xfffffffc(%ebp),%edx
     93b:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     93e:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
     941:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     944:	8b 40 04             	mov    0x4(%eax),%eax
     947:	c1 e0 03             	shl    $0x3,%eax
     94a:	01 45 f4             	add    %eax,0xfffffff4(%ebp)
        p->s.size = nunits;
     94d:	8b 55 f4             	mov    0xfffffff4(%ebp),%edx
     950:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     953:	89 42 04             	mov    %eax,0x4(%edx)
      }
      freep = prevp;
     956:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     959:	a3 ac 11 00 00       	mov    %eax,0x11ac
      return (void*) (p + 1);
     95e:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     961:	83 c0 08             	add    $0x8,%eax
     964:	89 45 ec             	mov    %eax,0xffffffec(%ebp)
     967:	eb 3a                	jmp    9a3 <malloc+0xe3>
    }
    if(p == freep)
     969:	a1 ac 11 00 00       	mov    0x11ac,%eax
     96e:	39 45 f4             	cmp    %eax,0xfffffff4(%ebp)
     971:	75 1d                	jne    990 <malloc+0xd0>
      if((p = morecore(nunits)) == 0)
     973:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     976:	89 04 24             	mov    %eax,(%esp)
     979:	e8 c2 fe ff ff       	call   840 <morecore>
     97e:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
     981:	83 7d f4 00          	cmpl   $0x0,0xfffffff4(%ebp)
     985:	75 09                	jne    990 <malloc+0xd0>
        return 0;
     987:	c7 45 ec 00 00 00 00 	movl   $0x0,0xffffffec(%ebp)
     98e:	eb 13                	jmp    9a3 <malloc+0xe3>
     990:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     993:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
     996:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     999:	8b 00                	mov    (%eax),%eax
     99b:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
  }
     99e:	e9 6b ff ff ff       	jmp    90e <malloc+0x4e>
     9a3:	8b 45 ec             	mov    0xffffffec(%ebp),%eax
}
     9a6:	c9                   	leave  
     9a7:	c3                   	ret    
     9a8:	90                   	nop    
     9a9:	90                   	nop    
     9aa:	90                   	nop    
     9ab:	90                   	nop    
     9ac:	90                   	nop    
     9ad:	90                   	nop    
     9ae:	90                   	nop    
     9af:	90                   	nop    

000009b0 <lwip_chksum>:


static u16_t
lwip_chksum(void *dataptr, int len)
{
     9b0:	55                   	push   %ebp
     9b1:	89 e5                	mov    %esp,%ebp
     9b3:	83 ec 18             	sub    $0x18,%esp
  u32_t acc;

  LWIP_DEBUGF(INET_DEBUG, ("lwip_chksum(%p, %d)\n", (void *)dataptr, len));
  for(acc = 0; len > 1; len -= 2) {
     9b6:	c7 45 fc 00 00 00 00 	movl   $0x0,0xfffffffc(%ebp)
     9bd:	eb 19                	jmp    9d8 <lwip_chksum+0x28>
      /*    acc = acc + *((u16_t *)dataptr)++;*/
    acc += *(u16_t *)dataptr;
     9bf:	8b 45 08             	mov    0x8(%ebp),%eax
     9c2:	0f b7 00             	movzwl (%eax),%eax
     9c5:	0f b7 c0             	movzwl %ax,%eax
     9c8:	01 45 fc             	add    %eax,0xfffffffc(%ebp)
    dataptr = (void *)((u16_t *)dataptr + 1);
     9cb:	8b 45 08             	mov    0x8(%ebp),%eax
     9ce:	83 c0 02             	add    $0x2,%eax
     9d1:	89 45 08             	mov    %eax,0x8(%ebp)
     9d4:	83 6d 0c 02          	subl   $0x2,0xc(%ebp)
     9d8:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
     9dc:	7f e1                	jg     9bf <lwip_chksum+0xf>
  }

  /* add up any odd byte */
  if (len == 1) {
     9de:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
     9e2:	75 1d                	jne    a01 <lwip_chksum+0x51>
    acc += htons((u16_t)((*(u8_t *)dataptr) & 0xff) << 8);
     9e4:	8b 45 08             	mov    0x8(%ebp),%eax
     9e7:	0f b6 00             	movzbl (%eax),%eax
     9ea:	0f b6 c0             	movzbl %al,%eax
     9ed:	c1 e0 08             	shl    $0x8,%eax
     9f0:	0f b7 c0             	movzwl %ax,%eax
     9f3:	89 04 24             	mov    %eax,(%esp)
     9f6:	e8 85 06 00 00       	call   1080 <htons>
     9fb:	0f b7 c0             	movzwl %ax,%eax
     9fe:	01 45 fc             	add    %eax,0xfffffffc(%ebp)
    LWIP_DEBUGF(INET_DEBUG, ("inet: chksum: odd byte %d\n", (unsigned int)(*(u8_t *)dataptr)));
  } else {
    LWIP_DEBUGF(INET_DEBUG, ("inet: chksum: no odd byte\n"));
  }
  acc = (acc >> 16) + (acc & 0xffffUL);
     a01:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     a04:	89 c2                	mov    %eax,%edx
     a06:	c1 ea 10             	shr    $0x10,%edx
     a09:	0f b7 45 fc          	movzwl 0xfffffffc(%ebp),%eax
     a0d:	8d 04 02             	lea    (%edx,%eax,1),%eax
     a10:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)

  if ((acc & 0xffff0000) != 0) {
     a13:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     a16:	66 b8 00 00          	mov    $0x0,%ax
     a1a:	85 c0                	test   %eax,%eax
     a1c:	74 12                	je     a30 <lwip_chksum+0x80>
    acc = (acc >> 16) + (acc & 0xffffUL);
     a1e:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     a21:	89 c2                	mov    %eax,%edx
     a23:	c1 ea 10             	shr    $0x10,%edx
     a26:	0f b7 45 fc          	movzwl 0xfffffffc(%ebp),%eax
     a2a:	8d 04 02             	lea    (%edx,%eax,1),%eax
     a2d:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
  }

  return (u16_t)acc;
     a30:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     a33:	0f b7 c0             	movzwl %ax,%eax
}
     a36:	c9                   	leave  
     a37:	c3                   	ret    
     a38:	90                   	nop    
     a39:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi

00000a40 <inet_chksum_pseudo>:

/* inet_chksum_pseudo:
 *
 * Calculates the pseudo Internet checksum used by TCP and UDP for a pbuf chain.
 */

u16_t
inet_chksum_pseudo(struct pbuf *p,
       struct ip_addr *src, struct ip_addr *dest,
       u8_t proto, u16_t proto_len)
{
     a40:	55                   	push   %ebp
     a41:	89 e5                	mov    %esp,%ebp
     a43:	83 ec 28             	sub    $0x28,%esp
     a46:	8b 45 14             	mov    0x14(%ebp),%eax
     a49:	8b 55 18             	mov    0x18(%ebp),%edx
     a4c:	88 45 ec             	mov    %al,0xffffffec(%ebp)
     a4f:	66 89 55 e8          	mov    %dx,0xffffffe8(%ebp)
  u32_t acc;
  struct pbuf *q;
  u8_t swapped;

  acc = 0;
     a53:	c7 45 f4 00 00 00 00 	movl   $0x0,0xfffffff4(%ebp)
  swapped = 0;
     a5a:	c6 45 ff 00          	movb   $0x0,0xffffffff(%ebp)
  /* iterate through all pbuf in chain */
  for(q = p; q != NULL; q = q->next) {
     a5e:	8b 45 08             	mov    0x8(%ebp),%eax
     a61:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
     a64:	eb 7b                	jmp    ae1 <inet_chksum_pseudo+0xa1>
    LWIP_DEBUGF(INET_DEBUG, ("inet_chksum_pseudo(): checksumming pbuf %p (has next %p) \n",
      (void *)q, (void *)q->next));
    acc += lwip_chksum(q->payload, q->len);
     a66:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     a69:	0f b7 40 0a          	movzwl 0xa(%eax),%eax
     a6d:	0f b7 d0             	movzwl %ax,%edx
     a70:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     a73:	8b 40 04             	mov    0x4(%eax),%eax
     a76:	89 54 24 04          	mov    %edx,0x4(%esp)
     a7a:	89 04 24             	mov    %eax,(%esp)
     a7d:	e8 2e ff ff ff       	call   9b0 <lwip_chksum>
     a82:	0f b7 c0             	movzwl %ax,%eax
     a85:	01 45 f4             	add    %eax,0xfffffff4(%ebp)
    /*LWIP_DEBUGF(INET_DEBUG, ("inet_chksum_pseudo(): unwrapped lwip_chksum()=%lx \n", acc));*/
    while (acc >> 16) {
     a88:	eb 10                	jmp    a9a <inet_chksum_pseudo+0x5a>
      acc = (acc & 0xffffUL) + (acc >> 16);
     a8a:	0f b7 55 f4          	movzwl 0xfffffff4(%ebp),%edx
     a8e:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     a91:	c1 e8 10             	shr    $0x10,%eax
     a94:	8d 04 02             	lea    (%edx,%eax,1),%eax
     a97:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
     a9a:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     a9d:	c1 e8 10             	shr    $0x10,%eax
     aa0:	85 c0                	test   %eax,%eax
     aa2:	75 e6                	jne    a8a <inet_chksum_pseudo+0x4a>
    }
    if (q->len % 2 != 0) {
     aa4:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     aa7:	0f b7 40 0a          	movzwl 0xa(%eax),%eax
     aab:	0f b7 c0             	movzwl %ax,%eax
     aae:	83 e0 01             	and    $0x1,%eax
     ab1:	84 c0                	test   %al,%al
     ab3:	74 24                	je     ad9 <inet_chksum_pseudo+0x99>
      swapped = 1 - swapped;
     ab5:	b8 01 00 00 00       	mov    $0x1,%eax
     aba:	2a 45 ff             	sub    0xffffffff(%ebp),%al
     abd:	88 45 ff             	mov    %al,0xffffffff(%ebp)
      acc = ((acc & 0xff) << 8) | ((acc & 0xff00UL) >> 8);
     ac0:	0f b6 45 f4          	movzbl 0xfffffff4(%ebp),%eax
     ac4:	89 c2                	mov    %eax,%edx
     ac6:	c1 e2 08             	shl    $0x8,%edx
     ac9:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     acc:	25 00 ff 00 00       	and    $0xff00,%eax
     ad1:	c1 e8 08             	shr    $0x8,%eax
     ad4:	09 d0                	or     %edx,%eax
     ad6:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
     ad9:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     adc:	8b 00                	mov    (%eax),%eax
     ade:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
     ae1:	83 7d f8 00          	cmpl   $0x0,0xfffffff8(%ebp)
     ae5:	0f 85 7b ff ff ff    	jne    a66 <inet_chksum_pseudo+0x26>
    }
    /*LWIP_DEBUGF(INET_DEBUG, ("inet_chksum_pseudo(): wrapped lwip_chksum()=%lx \n", acc));*/
  }

  if (swapped) {
     aeb:	80 7d ff 00          	cmpb   $0x0,0xffffffff(%ebp)
     aef:	74 19                	je     b0a <inet_chksum_pseudo+0xca>
    acc = ((acc & 0xff) << 8) | ((acc & 0xff00UL) >> 8);
     af1:	0f b6 45 f4          	movzbl 0xfffffff4(%ebp),%eax
     af5:	89 c2                	mov    %eax,%edx
     af7:	c1 e2 08             	shl    $0x8,%edx
     afa:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     afd:	25 00 ff 00 00       	and    $0xff00,%eax
     b02:	c1 e8 08             	shr    $0x8,%eax
     b05:	09 d0                	or     %edx,%eax
     b07:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
  }
  acc += (src->addr & 0xffffUL);
     b0a:	8b 45 0c             	mov    0xc(%ebp),%eax
     b0d:	8b 00                	mov    (%eax),%eax
     b0f:	25 ff ff 00 00       	and    $0xffff,%eax
     b14:	01 45 f4             	add    %eax,0xfffffff4(%ebp)
  acc += ((src->addr >> 16) & 0xffffUL);
     b17:	8b 45 0c             	mov    0xc(%ebp),%eax
     b1a:	8b 00                	mov    (%eax),%eax
     b1c:	c1 e8 10             	shr    $0x10,%eax
     b1f:	25 ff ff 00 00       	and    $0xffff,%eax
     b24:	01 45 f4             	add    %eax,0xfffffff4(%ebp)
  acc += (dest->addr & 0xffffUL);
     b27:	8b 45 10             	mov    0x10(%ebp),%eax
     b2a:	8b 00                	mov    (%eax),%eax
     b2c:	25 ff ff 00 00       	and    $0xffff,%eax
     b31:	01 45 f4             	add    %eax,0xfffffff4(%ebp)
  acc += ((dest->addr >> 16) & 0xffffUL);
     b34:	8b 45 10             	mov    0x10(%ebp),%eax
     b37:	8b 00                	mov    (%eax),%eax
     b39:	c1 e8 10             	shr    $0x10,%eax
     b3c:	25 ff ff 00 00       	and    $0xffff,%eax
     b41:	01 45 f4             	add    %eax,0xfffffff4(%ebp)
  acc += (u32_t)htons((u16_t)proto);
     b44:	0f b6 45 ec          	movzbl 0xffffffec(%ebp),%eax
     b48:	89 04 24             	mov    %eax,(%esp)
     b4b:	e8 30 05 00 00       	call   1080 <htons>
     b50:	0f b7 c0             	movzwl %ax,%eax
     b53:	01 45 f4             	add    %eax,0xfffffff4(%ebp)
  acc += (u32_t)htons(proto_len);
     b56:	0f b7 45 e8          	movzwl 0xffffffe8(%ebp),%eax
     b5a:	89 04 24             	mov    %eax,(%esp)
     b5d:	e8 1e 05 00 00       	call   1080 <htons>
     b62:	0f b7 c0             	movzwl %ax,%eax
     b65:	01 45 f4             	add    %eax,0xfffffff4(%ebp)

  while (acc >> 16) {
     b68:	eb 10                	jmp    b7a <inet_chksum_pseudo+0x13a>
    acc = (acc & 0xffffUL) + (acc >> 16);
     b6a:	0f b7 55 f4          	movzwl 0xfffffff4(%ebp),%edx
     b6e:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     b71:	c1 e8 10             	shr    $0x10,%eax
     b74:	8d 04 02             	lea    (%edx,%eax,1),%eax
     b77:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
     b7a:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     b7d:	c1 e8 10             	shr    $0x10,%eax
     b80:	85 c0                	test   %eax,%eax
     b82:	75 e6                	jne    b6a <inet_chksum_pseudo+0x12a>
  }
  LWIP_DEBUGF(INET_DEBUG, ("inet_chksum_pseudo(): pbuf chain lwip_chksum()=%lx\n", acc));
  return ~(acc & 0xffffUL);
     b84:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     b87:	f7 d0                	not    %eax
     b89:	0f b7 c0             	movzwl %ax,%eax
}
     b8c:	c9                   	leave  
     b8d:	c3                   	ret    
     b8e:	89 f6                	mov    %esi,%esi

00000b90 <inet_chksum>:

/* inet_chksum:
 *
 * Calculates the Internet checksum over a portion of memory. Used primarely for IP
 * and ICMP.
 */

u16_t
inet_chksum(void *dataptr, u16_t len)
{
     b90:	55                   	push   %ebp
     b91:	89 e5                	mov    %esp,%ebp
     b93:	83 ec 28             	sub    $0x28,%esp
     b96:	8b 45 0c             	mov    0xc(%ebp),%eax
     b99:	66 89 45 ec          	mov    %ax,0xffffffec(%ebp)
  u32_t acc;

  acc = lwip_chksum(dataptr, len);
     b9d:	0f b7 45 ec          	movzwl 0xffffffec(%ebp),%eax
     ba1:	89 44 24 04          	mov    %eax,0x4(%esp)
     ba5:	8b 45 08             	mov    0x8(%ebp),%eax
     ba8:	89 04 24             	mov    %eax,(%esp)
     bab:	e8 00 fe ff ff       	call   9b0 <lwip_chksum>
     bb0:	0f b7 c0             	movzwl %ax,%eax
     bb3:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
  while (acc >> 16) {
     bb6:	eb 10                	jmp    bc8 <inet_chksum+0x38>
    acc = (acc & 0xffff) + (acc >> 16);
     bb8:	0f b7 55 fc          	movzwl 0xfffffffc(%ebp),%edx
     bbc:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     bbf:	c1 e8 10             	shr    $0x10,%eax
     bc2:	8d 04 02             	lea    (%edx,%eax,1),%eax
     bc5:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
     bc8:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     bcb:	c1 e8 10             	shr    $0x10,%eax
     bce:	85 c0                	test   %eax,%eax
     bd0:	75 e6                	jne    bb8 <inet_chksum+0x28>
  }
  return ~(acc & 0xffff);
     bd2:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     bd5:	f7 d0                	not    %eax
     bd7:	0f b7 c0             	movzwl %ax,%eax
}
     bda:	c9                   	leave  
     bdb:	c3                   	ret    
     bdc:	8d 74 26 00          	lea    0x0(%esi),%esi

00000be0 <inet_chksum_pbuf>:

u16_t
inet_chksum_pbuf(struct pbuf *p)
{
     be0:	55                   	push   %ebp
     be1:	89 e5                	mov    %esp,%ebp
     be3:	83 ec 18             	sub    $0x18,%esp
  u32_t acc;
  struct pbuf *q;
  u8_t swapped;

  acc = 0;
     be6:	c7 45 f4 00 00 00 00 	movl   $0x0,0xfffffff4(%ebp)
  swapped = 0;
     bed:	c6 45 ff 00          	movb   $0x0,0xffffffff(%ebp)
  for(q = p; q != NULL; q = q->next) {
     bf1:	8b 45 08             	mov    0x8(%ebp),%eax
     bf4:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
     bf7:	eb 69                	jmp    c62 <inet_chksum_pbuf+0x82>
    acc += lwip_chksum(q->payload, q->len);
     bf9:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     bfc:	0f b7 40 0a          	movzwl 0xa(%eax),%eax
     c00:	0f b7 d0             	movzwl %ax,%edx
     c03:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     c06:	8b 40 04             	mov    0x4(%eax),%eax
     c09:	89 54 24 04          	mov    %edx,0x4(%esp)
     c0d:	89 04 24             	mov    %eax,(%esp)
     c10:	e8 9b fd ff ff       	call   9b0 <lwip_chksum>
     c15:	0f b7 c0             	movzwl %ax,%eax
     c18:	01 45 f4             	add    %eax,0xfffffff4(%ebp)
    while (acc >> 16) {
     c1b:	eb 10                	jmp    c2d <inet_chksum_pbuf+0x4d>
      acc = (acc & 0xffffUL) + (acc >> 16);
     c1d:	0f b7 55 f4          	movzwl 0xfffffff4(%ebp),%edx
     c21:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     c24:	c1 e8 10             	shr    $0x10,%eax
     c27:	8d 04 02             	lea    (%edx,%eax,1),%eax
     c2a:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
     c2d:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     c30:	c1 e8 10             	shr    $0x10,%eax
     c33:	85 c0                	test   %eax,%eax
     c35:	75 e6                	jne    c1d <inet_chksum_pbuf+0x3d>
    }
    if (q->len % 2 != 0) {
     c37:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     c3a:	0f b7 40 0a          	movzwl 0xa(%eax),%eax
     c3e:	0f b7 c0             	movzwl %ax,%eax
     c41:	83 e0 01             	and    $0x1,%eax
     c44:	84 c0                	test   %al,%al
     c46:	74 12                	je     c5a <inet_chksum_pbuf+0x7a>
      swapped = 1 - swapped;
     c48:	b8 01 00 00 00       	mov    $0x1,%eax
     c4d:	2a 45 ff             	sub    0xffffffff(%ebp),%al
     c50:	88 45 ff             	mov    %al,0xffffffff(%ebp)
      acc = (acc & 0x00ffUL << 8) | (acc & 0xff00UL >> 8);
     c53:	81 65 f4 ff ff 00 00 	andl   $0xffff,0xfffffff4(%ebp)
     c5a:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     c5d:	8b 00                	mov    (%eax),%eax
     c5f:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
     c62:	83 7d f8 00          	cmpl   $0x0,0xfffffff8(%ebp)
     c66:	75 91                	jne    bf9 <inet_chksum_pbuf+0x19>
    }
  }

  if (swapped) {
     c68:	80 7d ff 00          	cmpb   $0x0,0xffffffff(%ebp)
     c6c:	74 19                	je     c87 <inet_chksum_pbuf+0xa7>
    acc = ((acc & 0x00ffUL) << 8) | ((acc & 0xff00UL) >> 8);
     c6e:	0f b6 45 f4          	movzbl 0xfffffff4(%ebp),%eax
     c72:	89 c2                	mov    %eax,%edx
     c74:	c1 e2 08             	shl    $0x8,%edx
     c77:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     c7a:	25 00 ff 00 00       	and    $0xff00,%eax
     c7f:	c1 e8 08             	shr    $0x8,%eax
     c82:	09 d0                	or     %edx,%eax
     c84:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
  }
  return ~(acc & 0xffffUL);
     c87:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     c8a:	f7 d0                	not    %eax
     c8c:	0f b7 c0             	movzwl %ax,%eax
}
     c8f:	c9                   	leave  
     c90:	c3                   	ret    
     c91:	eb 0d                	jmp    ca0 <inet_addr>
     c93:	90                   	nop    
     c94:	90                   	nop    
     c95:	90                   	nop    
     c96:	90                   	nop    
     c97:	90                   	nop    
     c98:	90                   	nop    
     c99:	90                   	nop    
     c9a:	90                   	nop    
     c9b:	90                   	nop    
     c9c:	90                   	nop    
     c9d:	90                   	nop    
     c9e:	90                   	nop    
     c9f:	90                   	nop    

00000ca0 <inet_addr>:

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
     ca0:	55                   	push   %ebp
     ca1:	89 e5                	mov    %esp,%ebp
     ca3:	83 ec 28             	sub    $0x28,%esp
     struct in_addr val;

     if (inet_aton(cp, &val)) {
     ca6:	8d 45 fc             	lea    0xfffffffc(%ebp),%eax
     ca9:	89 44 24 04          	mov    %eax,0x4(%esp)
     cad:	8b 45 08             	mov    0x8(%ebp),%eax
     cb0:	89 04 24             	mov    %eax,(%esp)
     cb3:	e8 18 00 00 00       	call   cd0 <inet_aton>
     cb8:	85 c0                	test   %eax,%eax
     cba:	74 08                	je     cc4 <inet_addr+0x24>
         return (val.s_addr);
     cbc:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     cbf:	89 45 ec             	mov    %eax,0xffffffec(%ebp)
     cc2:	eb 07                	jmp    ccb <inet_addr+0x2b>
     }
     return (INADDR_NONE);
     cc4:	c7 45 ec ff ff ff ff 	movl   $0xffffffff,0xffffffec(%ebp)
     ccb:	8b 45 ec             	mov    0xffffffec(%ebp),%eax
 }
     cce:	c9                   	leave  
     ccf:	c3                   	ret    

00000cd0 <inet_aton>:

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
     cd0:	55                   	push   %ebp
     cd1:	89 e5                	mov    %esp,%ebp
     cd3:	83 ec 48             	sub    $0x48,%esp
     u32_t val;
     int base, n;
     char c;
     u32_t parts[4];
     u32_t* pp = parts;
     cd6:	8d 45 dc             	lea    0xffffffdc(%ebp),%eax
     cd9:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)

     c = *cp;
     cdc:	8b 45 08             	mov    0x8(%ebp),%eax
     cdf:	0f b6 00             	movzbl (%eax),%eax
     ce2:	88 45 fb             	mov    %al,0xfffffffb(%ebp)
     for (;;) {
         /*
          * Collect number up to ``.''.
          * Values are specified as for C:
          * 0x=hex, 0=octal, isdigit=decimal.
          */
         if (!isdigit(c))
     ce5:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
     ce9:	3c 2f                	cmp    $0x2f,%al
     ceb:	76 08                	jbe    cf5 <inet_aton+0x25>
     ced:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
     cf1:	3c 39                	cmp    $0x39,%al
     cf3:	76 0c                	jbe    d01 <inet_aton+0x31>
             return (0);
     cf5:	c7 45 c0 00 00 00 00 	movl   $0x0,0xffffffc0(%ebp)
     cfc:	e9 78 02 00 00       	jmp    f79 <inet_aton+0x2a9>
         val = 0; base = 10;
     d01:	c7 45 ec 00 00 00 00 	movl   $0x0,0xffffffec(%ebp)
     d08:	c7 45 f0 0a 00 00 00 	movl   $0xa,0xfffffff0(%ebp)
         if (c == '0') {
     d0f:	80 7d fb 30          	cmpb   $0x30,0xfffffffb(%ebp)
     d13:	75 36                	jne    d4b <inet_aton+0x7b>
             c = *++cp;
     d15:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     d19:	8b 45 08             	mov    0x8(%ebp),%eax
     d1c:	0f b6 00             	movzbl (%eax),%eax
     d1f:	88 45 fb             	mov    %al,0xfffffffb(%ebp)
             if (c == 'x' || c == 'X')
     d22:	80 7d fb 78          	cmpb   $0x78,0xfffffffb(%ebp)
     d26:	74 06                	je     d2e <inet_aton+0x5e>
     d28:	80 7d fb 58          	cmpb   $0x58,0xfffffffb(%ebp)
     d2c:	75 16                	jne    d44 <inet_aton+0x74>
                 base = 16, c = *++cp;
     d2e:	c7 45 f0 10 00 00 00 	movl   $0x10,0xfffffff0(%ebp)
     d35:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     d39:	8b 45 08             	mov    0x8(%ebp),%eax
     d3c:	0f b6 00             	movzbl (%eax),%eax
     d3f:	88 45 fb             	mov    %al,0xfffffffb(%ebp)
     d42:	eb 07                	jmp    d4b <inet_aton+0x7b>
             else
                 base = 8;
     d44:	c7 45 f0 08 00 00 00 	movl   $0x8,0xfffffff0(%ebp)
         }
         for (;;) {
             if (isascii(c) && isdigit(c)) {
     d4b:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
     d4f:	3c 1f                	cmp    $0x1f,%al
     d51:	76 3b                	jbe    d8e <inet_aton+0xbe>
     d53:	80 7d fb 00          	cmpb   $0x0,0xfffffffb(%ebp)
     d57:	78 35                	js     d8e <inet_aton+0xbe>
     d59:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
     d5d:	3c 2f                	cmp    $0x2f,%al
     d5f:	76 2d                	jbe    d8e <inet_aton+0xbe>
     d61:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
     d65:	3c 39                	cmp    $0x39,%al
     d67:	77 25                	ja     d8e <inet_aton+0xbe>
                 val = (val * base) + (c - '0');
     d69:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
     d6c:	89 c2                	mov    %eax,%edx
     d6e:	0f af 55 ec          	imul   0xffffffec(%ebp),%edx
     d72:	0f be 45 fb          	movsbl 0xfffffffb(%ebp),%eax
     d76:	8d 04 02             	lea    (%edx,%eax,1),%eax
     d79:	83 e8 30             	sub    $0x30,%eax
     d7c:	89 45 ec             	mov    %eax,0xffffffec(%ebp)
                 c = *++cp;
     d7f:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     d83:	8b 45 08             	mov    0x8(%ebp),%eax
     d86:	0f b6 00             	movzbl (%eax),%eax
     d89:	88 45 fb             	mov    %al,0xfffffffb(%ebp)
     d8c:	eb bd                	jmp    d4b <inet_aton+0x7b>
             } else if (base == 16 && isascii(c) && isxdigit(c)) {
     d8e:	83 7d f0 10          	cmpl   $0x10,0xfffffff0(%ebp)
     d92:	0f 85 99 00 00 00    	jne    e31 <inet_aton+0x161>
     d98:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
     d9c:	3c 1f                	cmp    $0x1f,%al
     d9e:	0f 86 8d 00 00 00    	jbe    e31 <inet_aton+0x161>
     da4:	80 7d fb 00          	cmpb   $0x0,0xfffffffb(%ebp)
     da8:	0f 88 83 00 00 00    	js     e31 <inet_aton+0x161>
     dae:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
     db2:	3c 2f                	cmp    $0x2f,%al
     db4:	76 08                	jbe    dbe <inet_aton+0xee>
     db6:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
     dba:	3c 39                	cmp    $0x39,%al
     dbc:	76 20                	jbe    dde <inet_aton+0x10e>
     dbe:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
     dc2:	3c 60                	cmp    $0x60,%al
     dc4:	76 08                	jbe    dce <inet_aton+0xfe>
     dc6:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
     dca:	3c 66                	cmp    $0x66,%al
     dcc:	76 10                	jbe    dde <inet_aton+0x10e>
     dce:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
     dd2:	3c 40                	cmp    $0x40,%al
     dd4:	76 5b                	jbe    e31 <inet_aton+0x161>
     dd6:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
     dda:	3c 46                	cmp    $0x46,%al
     ddc:	77 53                	ja     e31 <inet_aton+0x161>
                 val = (val << 4) |
     dde:	8b 45 ec             	mov    0xffffffec(%ebp),%eax
     de1:	89 c2                	mov    %eax,%edx
     de3:	c1 e2 04             	shl    $0x4,%edx
     de6:	89 55 c4             	mov    %edx,0xffffffc4(%ebp)
     de9:	0f be 45 fb          	movsbl 0xfffffffb(%ebp),%eax
     ded:	83 c0 0a             	add    $0xa,%eax
     df0:	89 45 c8             	mov    %eax,0xffffffc8(%ebp)
     df3:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
     df7:	3c 60                	cmp    $0x60,%al
     df9:	76 11                	jbe    e0c <inet_aton+0x13c>
     dfb:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
     dff:	3c 7a                	cmp    $0x7a,%al
     e01:	77 09                	ja     e0c <inet_aton+0x13c>
     e03:	c7 45 cc 61 00 00 00 	movl   $0x61,0xffffffcc(%ebp)
     e0a:	eb 07                	jmp    e13 <inet_aton+0x143>
     e0c:	c7 45 cc 41 00 00 00 	movl   $0x41,0xffffffcc(%ebp)
     e13:	8b 45 c8             	mov    0xffffffc8(%ebp),%eax
     e16:	2b 45 cc             	sub    0xffffffcc(%ebp),%eax
     e19:	0b 45 c4             	or     0xffffffc4(%ebp),%eax
     e1c:	89 45 ec             	mov    %eax,0xffffffec(%ebp)
                     (c + 10 - (islower(c) ? 'a' : 'A'));
                 c = *++cp;
     e1f:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     e23:	8b 45 08             	mov    0x8(%ebp),%eax
     e26:	0f b6 00             	movzbl (%eax),%eax
     e29:	88 45 fb             	mov    %al,0xfffffffb(%ebp)
             } else
             break;
         }
     e2c:	e9 1a ff ff ff       	jmp    d4b <inet_aton+0x7b>
         if (c == '.') {
     e31:	80 7d fb 2e          	cmpb   $0x2e,0xfffffffb(%ebp)
     e35:	75 35                	jne    e6c <inet_aton+0x19c>
             /*
              * Internet format:
              *  a.b.c.d
              *  a.b.c   (with c treated as 16 bits)
              *  a.b (with b treated as 24 bits)
              */
             if (pp >= parts + 3)
     e37:	8d 45 dc             	lea    0xffffffdc(%ebp),%eax
     e3a:	83 c0 0c             	add    $0xc,%eax
     e3d:	3b 45 fc             	cmp    0xfffffffc(%ebp),%eax
     e40:	77 0c                	ja     e4e <inet_aton+0x17e>
                 return (0);
     e42:	c7 45 c0 00 00 00 00 	movl   $0x0,0xffffffc0(%ebp)
     e49:	e9 2b 01 00 00       	jmp    f79 <inet_aton+0x2a9>
             *pp++ = val;
     e4e:	8b 55 fc             	mov    0xfffffffc(%ebp),%edx
     e51:	8b 45 ec             	mov    0xffffffec(%ebp),%eax
     e54:	89 02                	mov    %eax,(%edx)
     e56:	83 45 fc 04          	addl   $0x4,0xfffffffc(%ebp)
             c = *++cp;
     e5a:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     e5e:	8b 45 08             	mov    0x8(%ebp),%eax
     e61:	0f b6 00             	movzbl (%eax),%eax
     e64:	88 45 fb             	mov    %al,0xfffffffb(%ebp)
         } else
             break;
     }
     e67:	e9 79 fe ff ff       	jmp    ce5 <inet_aton+0x15>
     /*
      * Check for trailing characters.
      */
     if (c != '\0' && (!isascii(c) || !isspace(c)))
     e6c:	80 7d fb 00          	cmpb   $0x0,0xfffffffb(%ebp)
     e70:	74 3e                	je     eb0 <inet_aton+0x1e0>
     e72:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
     e76:	3c 1f                	cmp    $0x1f,%al
     e78:	76 2a                	jbe    ea4 <inet_aton+0x1d4>
     e7a:	80 7d fb 00          	cmpb   $0x0,0xfffffffb(%ebp)
     e7e:	78 24                	js     ea4 <inet_aton+0x1d4>
     e80:	80 7d fb 20          	cmpb   $0x20,0xfffffffb(%ebp)
     e84:	74 2a                	je     eb0 <inet_aton+0x1e0>
     e86:	80 7d fb 0c          	cmpb   $0xc,0xfffffffb(%ebp)
     e8a:	74 24                	je     eb0 <inet_aton+0x1e0>
     e8c:	80 7d fb 0a          	cmpb   $0xa,0xfffffffb(%ebp)
     e90:	74 1e                	je     eb0 <inet_aton+0x1e0>
     e92:	80 7d fb 0d          	cmpb   $0xd,0xfffffffb(%ebp)
     e96:	74 18                	je     eb0 <inet_aton+0x1e0>
     e98:	80 7d fb 09          	cmpb   $0x9,0xfffffffb(%ebp)
     e9c:	74 12                	je     eb0 <inet_aton+0x1e0>
     e9e:	80 7d fb 0b          	cmpb   $0xb,0xfffffffb(%ebp)
     ea2:	74 0c                	je     eb0 <inet_aton+0x1e0>
         return (0);
     ea4:	c7 45 c0 00 00 00 00 	movl   $0x0,0xffffffc0(%ebp)
     eab:	e9 c9 00 00 00       	jmp    f79 <inet_aton+0x2a9>
     /*
      * Concoct the address according to
      * the number of parts specified.
      */
     n = pp - parts + 1;
     eb0:	8b 55 fc             	mov    0xfffffffc(%ebp),%edx
     eb3:	8d 45 dc             	lea    0xffffffdc(%ebp),%eax
     eb6:	89 d1                	mov    %edx,%ecx
     eb8:	29 c1                	sub    %eax,%ecx
     eba:	89 c8                	mov    %ecx,%eax
     ebc:	c1 f8 02             	sar    $0x2,%eax
     ebf:	83 c0 01             	add    $0x1,%eax
     ec2:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
     switch (n) {
     ec5:	83 7d f4 04          	cmpl   $0x4,0xfffffff4(%ebp)
     ec9:	0f 87 8b 00 00 00    	ja     f5a <inet_aton+0x28a>
     ecf:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     ed2:	c1 e0 02             	shl    $0x2,%eax
     ed5:	8b 80 74 11 00 00    	mov    0x1174(%eax),%eax
     edb:	ff e0                	jmp    *%eax

     case 0:
         return (0);     /* initial nondigit */
     edd:	c7 45 c0 00 00 00 00 	movl   $0x0,0xffffffc0(%ebp)
     ee4:	e9 90 00 00 00       	jmp    f79 <inet_aton+0x2a9>

     case 1:             /* a -- 32 bits */
         break;

     case 2:             /* a.b -- 8.24 bits */
         if (val > 0xffffff)
     ee9:	81 7d ec ff ff ff 00 	cmpl   $0xffffff,0xffffffec(%ebp)
     ef0:	76 09                	jbe    efb <inet_aton+0x22b>
             return (0);
     ef2:	c7 45 c0 00 00 00 00 	movl   $0x0,0xffffffc0(%ebp)
     ef9:	eb 7e                	jmp    f79 <inet_aton+0x2a9>
         val |= parts[0] << 24;
     efb:	8b 45 dc             	mov    0xffffffdc(%ebp),%eax
     efe:	c1 e0 18             	shl    $0x18,%eax
     f01:	09 45 ec             	or     %eax,0xffffffec(%ebp)
         break;
     f04:	eb 54                	jmp    f5a <inet_aton+0x28a>

     case 3:             /* a.b.c -- 8.8.16 bits */
         if (val > 0xffff)
     f06:	81 7d ec ff ff 00 00 	cmpl   $0xffff,0xffffffec(%ebp)
     f0d:	76 09                	jbe    f18 <inet_aton+0x248>
             return (0);
     f0f:	c7 45 c0 00 00 00 00 	movl   $0x0,0xffffffc0(%ebp)
     f16:	eb 61                	jmp    f79 <inet_aton+0x2a9>
         val |= (parts[0] << 24) | (parts[1] << 16);
     f18:	8b 45 dc             	mov    0xffffffdc(%ebp),%eax
     f1b:	89 c2                	mov    %eax,%edx
     f1d:	c1 e2 18             	shl    $0x18,%edx
     f20:	8b 45 e0             	mov    0xffffffe0(%ebp),%eax
     f23:	c1 e0 10             	shl    $0x10,%eax
     f26:	09 d0                	or     %edx,%eax
     f28:	09 45 ec             	or     %eax,0xffffffec(%ebp)
         break;
     f2b:	eb 2d                	jmp    f5a <inet_aton+0x28a>

     case 4:             /* a.b.c.d -- 8.8.8.8 bits */
         if (val > 0xff)
     f2d:	81 7d ec ff 00 00 00 	cmpl   $0xff,0xffffffec(%ebp)
     f34:	76 09                	jbe    f3f <inet_aton+0x26f>
             return (0);
     f36:	c7 45 c0 00 00 00 00 	movl   $0x0,0xffffffc0(%ebp)
     f3d:	eb 3a                	jmp    f79 <inet_aton+0x2a9>
         val |= (parts[0] << 24) | (parts[1] << 16) | (parts[2] << 8);
     f3f:	8b 45 dc             	mov    0xffffffdc(%ebp),%eax
     f42:	89 c2                	mov    %eax,%edx
     f44:	c1 e2 18             	shl    $0x18,%edx
     f47:	8b 45 e0             	mov    0xffffffe0(%ebp),%eax
     f4a:	c1 e0 10             	shl    $0x10,%eax
     f4d:	09 c2                	or     %eax,%edx
     f4f:	8b 45 e4             	mov    0xffffffe4(%ebp),%eax
     f52:	c1 e0 08             	shl    $0x8,%eax
     f55:	09 d0                	or     %edx,%eax
     f57:	09 45 ec             	or     %eax,0xffffffec(%ebp)
         break;
     }
     if (addr)
     f5a:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     f5e:	74 12                	je     f72 <inet_aton+0x2a2>
         addr->s_addr = htonl(val);
     f60:	8b 45 ec             	mov    0xffffffec(%ebp),%eax
     f63:	89 04 24             	mov    %eax,(%esp)
     f66:	e8 65 01 00 00       	call   10d0 <htonl>
     f6b:	89 c2                	mov    %eax,%edx
     f6d:	8b 45 0c             	mov    0xc(%ebp),%eax
     f70:	89 10                	mov    %edx,(%eax)
     return (1);
     f72:	c7 45 c0 01 00 00 00 	movl   $0x1,0xffffffc0(%ebp)
     f79:	8b 45 c0             	mov    0xffffffc0(%ebp),%eax
 }
     f7c:	c9                   	leave  
     f7d:	c3                   	ret    
     f7e:	89 f6                	mov    %esi,%esi

00000f80 <inet_ntoa>:

/* Convert numeric IP address into decimal dotted ASCII representation.
 * returns ptr to static buffer; not reentrant!
 */
char *inet_ntoa(struct in_addr addr)
{
     f80:	55                   	push   %ebp
     f81:	89 e5                	mov    %esp,%ebp
     f83:	53                   	push   %ebx
     f84:	83 ec 24             	sub    $0x24,%esp
  static char str[16];
  u32_t s_addr = addr.s_addr;
     f87:	8b 45 08             	mov    0x8(%ebp),%eax
     f8a:	89 45 ec             	mov    %eax,0xffffffec(%ebp)
  char inv[3];
  char *rp;
  char *ap;
  u8_t rem;
  u8_t n;
  u8_t i;

  rp = str;
     f8d:	c7 45 f0 b0 11 00 00 	movl   $0x11b0,0xfffffff0(%ebp)
  ap = (u8_t *)&s_addr;
     f94:	8d 45 ec             	lea    0xffffffec(%ebp),%eax
     f97:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
  for(n = 0; n < 4; n++) {
     f9a:	c6 45 fa 00          	movb   $0x0,0xfffffffa(%ebp)
     f9e:	e9 af 00 00 00       	jmp    1052 <inet_ntoa+0xd2>
    i = 0;
     fa3:	c6 45 fb 00          	movb   $0x0,0xfffffffb(%ebp)
    do {
      rem = *ap % (u8_t)10;
     fa7:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     faa:	0f b6 08             	movzbl (%eax),%ecx
     fad:	b8 67 00 00 00       	mov    $0x67,%eax
     fb2:	f6 e9                	imul   %cl
     fb4:	66 c1 e8 08          	shr    $0x8,%ax
     fb8:	89 c2                	mov    %eax,%edx
     fba:	c0 fa 02             	sar    $0x2,%dl
     fbd:	89 c8                	mov    %ecx,%eax
     fbf:	c0 f8 07             	sar    $0x7,%al
     fc2:	89 d3                	mov    %edx,%ebx
     fc4:	28 c3                	sub    %al,%bl
     fc6:	88 5d db             	mov    %bl,0xffffffdb(%ebp)
     fc9:	0f b6 45 db          	movzbl 0xffffffdb(%ebp),%eax
     fcd:	c1 e0 02             	shl    $0x2,%eax
     fd0:	02 45 db             	add    0xffffffdb(%ebp),%al
     fd3:	01 c0                	add    %eax,%eax
     fd5:	89 ca                	mov    %ecx,%edx
     fd7:	28 c2                	sub    %al,%dl
     fd9:	88 55 db             	mov    %dl,0xffffffdb(%ebp)
     fdc:	0f b6 5d db          	movzbl 0xffffffdb(%ebp),%ebx
     fe0:	88 5d f9             	mov    %bl,0xfffffff9(%ebp)
      *ap /= (u8_t)10;
     fe3:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     fe6:	0f b6 08             	movzbl (%eax),%ecx
     fe9:	b8 67 00 00 00       	mov    $0x67,%eax
     fee:	f6 e9                	imul   %cl
     ff0:	66 c1 e8 08          	shr    $0x8,%ax
     ff4:	89 c2                	mov    %eax,%edx
     ff6:	c0 fa 02             	sar    $0x2,%dl
     ff9:	89 c8                	mov    %ecx,%eax
     ffb:	c0 f8 07             	sar    $0x7,%al
     ffe:	28 c2                	sub    %al,%dl
    1000:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
    1003:	88 10                	mov    %dl,(%eax)
      inv[i++] = '0' + rem;
    1005:	0f b6 55 fb          	movzbl 0xfffffffb(%ebp),%edx
    1009:	0f b6 45 f9          	movzbl 0xfffffff9(%ebp),%eax
    100d:	83 c0 30             	add    $0x30,%eax
    1010:	88 44 15 e9          	mov    %al,0xffffffe9(%ebp,%edx,1)
    1014:	80 45 fb 01          	addb   $0x1,0xfffffffb(%ebp)
    } while(*ap);
    1018:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
    101b:	0f b6 00             	movzbl (%eax),%eax
    101e:	84 c0                	test   %al,%al
    1020:	75 85                	jne    fa7 <inet_ntoa+0x27>
    while(i--)
    1022:	eb 12                	jmp    1036 <inet_ntoa+0xb6>
      *rp++ = inv[i];
    1024:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
    1028:	0f b6 54 05 e9       	movzbl 0xffffffe9(%ebp,%eax,1),%edx
    102d:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
    1030:	88 10                	mov    %dl,(%eax)
    1032:	83 45 f0 01          	addl   $0x1,0xfffffff0(%ebp)
    1036:	80 6d fb 01          	subb   $0x1,0xfffffffb(%ebp)
    103a:	80 7d fb ff          	cmpb   $0xff,0xfffffffb(%ebp)
    103e:	75 e4                	jne    1024 <inet_ntoa+0xa4>
    *rp++ = '.';
    1040:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
    1043:	c6 00 2e             	movb   $0x2e,(%eax)
    1046:	83 45 f0 01          	addl   $0x1,0xfffffff0(%ebp)
    ap++;
    104a:	83 45 f4 01          	addl   $0x1,0xfffffff4(%ebp)
    104e:	80 45 fa 01          	addb   $0x1,0xfffffffa(%ebp)
    1052:	80 7d fa 03          	cmpb   $0x3,0xfffffffa(%ebp)
    1056:	0f 86 47 ff ff ff    	jbe    fa3 <inet_ntoa+0x23>
  }
  *--rp = 0;
    105c:	83 6d f0 01          	subl   $0x1,0xfffffff0(%ebp)
    1060:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
    1063:	c6 00 00             	movb   $0x0,(%eax)
  return str;
    1066:	b8 b0 11 00 00       	mov    $0x11b0,%eax
}
    106b:	83 c4 24             	add    $0x24,%esp
    106e:	5b                   	pop    %ebx
    106f:	5d                   	pop    %ebp
    1070:	c3                   	ret    
    1071:	eb 0d                	jmp    1080 <htons>
    1073:	90                   	nop    
    1074:	90                   	nop    
    1075:	90                   	nop    
    1076:	90                   	nop    
    1077:	90                   	nop    
    1078:	90                   	nop    
    1079:	90                   	nop    
    107a:	90                   	nop    
    107b:	90                   	nop    
    107c:	90                   	nop    
    107d:	90                   	nop    
    107e:	90                   	nop    
    107f:	90                   	nop    

00001080 <htons>:


#ifndef BYTE_ORDER
#error BYTE_ORDER is not defined
#endif
#if BYTE_ORDER == LITTLE_ENDIAN

u16_t
htons(u16_t n)
{
    1080:	55                   	push   %ebp
    1081:	89 e5                	mov    %esp,%ebp
    1083:	83 ec 04             	sub    $0x4,%esp
    1086:	8b 45 08             	mov    0x8(%ebp),%eax
    1089:	66 89 45 fc          	mov    %ax,0xfffffffc(%ebp)
  return ((n & 0xff) << 8) | ((n & 0xff00) >> 8);
    108d:	0f b7 45 fc          	movzwl 0xfffffffc(%ebp),%eax
    1091:	25 ff 00 00 00       	and    $0xff,%eax
    1096:	c1 e0 08             	shl    $0x8,%eax
    1099:	89 c2                	mov    %eax,%edx
    109b:	0f b7 45 fc          	movzwl 0xfffffffc(%ebp),%eax
    109f:	25 00 ff 00 00       	and    $0xff00,%eax
    10a4:	c1 f8 08             	sar    $0x8,%eax
    10a7:	09 d0                	or     %edx,%eax
    10a9:	0f b7 c0             	movzwl %ax,%eax
}
    10ac:	c9                   	leave  
    10ad:	c3                   	ret    
    10ae:	89 f6                	mov    %esi,%esi

000010b0 <ntohs>:

u16_t
ntohs(u16_t n)
{
    10b0:	55                   	push   %ebp
    10b1:	89 e5                	mov    %esp,%ebp
    10b3:	83 ec 08             	sub    $0x8,%esp
    10b6:	8b 45 08             	mov    0x8(%ebp),%eax
    10b9:	66 89 45 fc          	mov    %ax,0xfffffffc(%ebp)
  return htons(n);
    10bd:	0f b7 45 fc          	movzwl 0xfffffffc(%ebp),%eax
    10c1:	89 04 24             	mov    %eax,(%esp)
    10c4:	e8 b7 ff ff ff       	call   1080 <htons>
    10c9:	0f b7 c0             	movzwl %ax,%eax
}
    10cc:	c9                   	leave  
    10cd:	c3                   	ret    
    10ce:	89 f6                	mov    %esi,%esi

000010d0 <htonl>:

u32_t
htonl(u32_t n)
{
    10d0:	55                   	push   %ebp
    10d1:	89 e5                	mov    %esp,%ebp
  return ((n & 0xff) << 24) |
    10d3:	0f b6 45 08          	movzbl 0x8(%ebp),%eax
    10d7:	89 c2                	mov    %eax,%edx
    10d9:	c1 e2 18             	shl    $0x18,%edx
    10dc:	8b 45 08             	mov    0x8(%ebp),%eax
    10df:	25 00 ff 00 00       	and    $0xff00,%eax
    10e4:	c1 e0 08             	shl    $0x8,%eax
    10e7:	09 c2                	or     %eax,%edx
    10e9:	8b 45 08             	mov    0x8(%ebp),%eax
    10ec:	25 00 00 ff 00       	and    $0xff0000,%eax
    10f1:	c1 e8 08             	shr    $0x8,%eax
    10f4:	09 c2                	or     %eax,%edx
    10f6:	8b 45 08             	mov    0x8(%ebp),%eax
    10f9:	25 00 00 00 ff       	and    $0xff000000,%eax
    10fe:	c1 e8 18             	shr    $0x18,%eax
    1101:	09 d0                	or     %edx,%eax
    ((n & 0xff00) << 8) |
    ((n & 0xff0000) >> 8) |
    ((n & 0xff000000) >> 24);
}
    1103:	5d                   	pop    %ebp
    1104:	c3                   	ret    
    1105:	8d 74 26 00          	lea    0x0(%esi),%esi
    1109:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00001110 <ntohl>:

u32_t
ntohl(u32_t n)
{
    1110:	55                   	push   %ebp
    1111:	89 e5                	mov    %esp,%ebp
    1113:	83 ec 04             	sub    $0x4,%esp
  return htonl(n);
    1116:	8b 45 08             	mov    0x8(%ebp),%eax
    1119:	89 04 24             	mov    %eax,(%esp)
    111c:	e8 af ff ff ff       	call   10d0 <htonl>
}
    1121:	c9                   	leave  
    1122:	c3                   	ret    
