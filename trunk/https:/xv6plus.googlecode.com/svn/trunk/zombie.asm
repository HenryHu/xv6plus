
_zombie:     file format elf32-i386-freebsd

Disassembly of section .text:

00000000 <main>:
#include "user.h"

int
main(void)
{
       0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
       4:	83 e4 f0             	and    $0xfffffff0,%esp
       7:	ff 71 fc             	pushl  0xfffffffc(%ecx)
       a:	55                   	push   %ebp
       b:	89 e5                	mov    %esp,%ebp
       d:	51                   	push   %ecx
       e:	83 ec 04             	sub    $0x4,%esp
  if(fork() > 0)
      11:	e8 a6 02 00 00       	call   2bc <fork>
      16:	85 c0                	test   %eax,%eax
      18:	7e 0c                	jle    26 <main+0x26>
    sleep(5);  // Let child exit before parent.
      1a:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
      21:	e8 2e 03 00 00       	call   354 <sleep>
  exit();
      26:	e8 99 02 00 00       	call   2c4 <exit>
      2b:	90                   	nop    
      2c:	90                   	nop    
      2d:	90                   	nop    
      2e:	90                   	nop    
      2f:	90                   	nop    

00000030 <strcpy>:
#include "user.h"

char*
strcpy(char *s, char *t)
{
      30:	55                   	push   %ebp
      31:	89 e5                	mov    %esp,%ebp
      33:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
      36:	8b 45 08             	mov    0x8(%ebp),%eax
      39:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
  while((*s++ = *t++) != 0)
      3c:	8b 45 0c             	mov    0xc(%ebp),%eax
      3f:	0f b6 10             	movzbl (%eax),%edx
      42:	8b 45 08             	mov    0x8(%ebp),%eax
      45:	88 10                	mov    %dl,(%eax)
      47:	8b 45 08             	mov    0x8(%ebp),%eax
      4a:	0f b6 00             	movzbl (%eax),%eax
      4d:	84 c0                	test   %al,%al
      4f:	0f 95 c0             	setne  %al
      52:	83 45 08 01          	addl   $0x1,0x8(%ebp)
      56:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
      5a:	84 c0                	test   %al,%al
      5c:	75 de                	jne    3c <strcpy+0xc>
    ;
  return os;
      5e:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
}
      61:	c9                   	leave  
      62:	c3                   	ret    
      63:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      69:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00000070 <strcmp>:

int
strcmp(const char *p, const char *q)
{
      70:	55                   	push   %ebp
      71:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
      73:	eb 08                	jmp    7d <strcmp+0xd>
    p++, q++;
      75:	83 45 08 01          	addl   $0x1,0x8(%ebp)
      79:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
      7d:	8b 45 08             	mov    0x8(%ebp),%eax
      80:	0f b6 00             	movzbl (%eax),%eax
      83:	84 c0                	test   %al,%al
      85:	74 10                	je     97 <strcmp+0x27>
      87:	8b 45 08             	mov    0x8(%ebp),%eax
      8a:	0f b6 10             	movzbl (%eax),%edx
      8d:	8b 45 0c             	mov    0xc(%ebp),%eax
      90:	0f b6 00             	movzbl (%eax),%eax
      93:	38 c2                	cmp    %al,%dl
      95:	74 de                	je     75 <strcmp+0x5>
  return (uchar)*p - (uchar)*q;
      97:	8b 45 08             	mov    0x8(%ebp),%eax
      9a:	0f b6 00             	movzbl (%eax),%eax
      9d:	0f b6 d0             	movzbl %al,%edx
      a0:	8b 45 0c             	mov    0xc(%ebp),%eax
      a3:	0f b6 00             	movzbl (%eax),%eax
      a6:	0f b6 c0             	movzbl %al,%eax
      a9:	89 d1                	mov    %edx,%ecx
      ab:	29 c1                	sub    %eax,%ecx
      ad:	89 c8                	mov    %ecx,%eax
}
      af:	5d                   	pop    %ebp
      b0:	c3                   	ret    
      b1:	eb 0d                	jmp    c0 <strlen>
      b3:	90                   	nop    
      b4:	90                   	nop    
      b5:	90                   	nop    
      b6:	90                   	nop    
      b7:	90                   	nop    
      b8:	90                   	nop    
      b9:	90                   	nop    
      ba:	90                   	nop    
      bb:	90                   	nop    
      bc:	90                   	nop    
      bd:	90                   	nop    
      be:	90                   	nop    
      bf:	90                   	nop    

000000c0 <strlen>:

uint
strlen(char *s)
{
      c0:	55                   	push   %ebp
      c1:	89 e5                	mov    %esp,%ebp
      c3:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
      c6:	c7 45 fc 00 00 00 00 	movl   $0x0,0xfffffffc(%ebp)
      cd:	eb 04                	jmp    d3 <strlen+0x13>
      cf:	83 45 fc 01          	addl   $0x1,0xfffffffc(%ebp)
      d3:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
      d6:	03 45 08             	add    0x8(%ebp),%eax
      d9:	0f b6 00             	movzbl (%eax),%eax
      dc:	84 c0                	test   %al,%al
      de:	75 ef                	jne    cf <strlen+0xf>
    ;
  return n;
      e0:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
}
      e3:	c9                   	leave  
      e4:	c3                   	ret    
      e5:	8d 74 26 00          	lea    0x0(%esi),%esi
      e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

000000f0 <memset>:

void*
memset(void *dst, int c, uint n)
{
      f0:	55                   	push   %ebp
      f1:	89 e5                	mov    %esp,%ebp
      f3:	83 ec 10             	sub    $0x10,%esp
  char *d;
  
  d = dst;
      f6:	8b 45 08             	mov    0x8(%ebp),%eax
      f9:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
  while(n-- > 0)
      fc:	eb 0e                	jmp    10c <memset+0x1c>
    *d++ = c;
      fe:	8b 45 0c             	mov    0xc(%ebp),%eax
     101:	89 c2                	mov    %eax,%edx
     103:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     106:	88 10                	mov    %dl,(%eax)
     108:	83 45 fc 01          	addl   $0x1,0xfffffffc(%ebp)
     10c:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
     110:	83 7d 10 ff          	cmpl   $0xffffffff,0x10(%ebp)
     114:	75 e8                	jne    fe <memset+0xe>
  return dst;
     116:	8b 45 08             	mov    0x8(%ebp),%eax
}
     119:	c9                   	leave  
     11a:	c3                   	ret    
     11b:	90                   	nop    
     11c:	8d 74 26 00          	lea    0x0(%esi),%esi

00000120 <strchr>:

char*
strchr(const char *s, char c)
{
     120:	55                   	push   %ebp
     121:	89 e5                	mov    %esp,%ebp
     123:	83 ec 08             	sub    $0x8,%esp
     126:	8b 45 0c             	mov    0xc(%ebp),%eax
     129:	88 45 fc             	mov    %al,0xfffffffc(%ebp)
  for(; *s; s++)
     12c:	eb 17                	jmp    145 <strchr+0x25>
    if(*s == c)
     12e:	8b 45 08             	mov    0x8(%ebp),%eax
     131:	0f b6 00             	movzbl (%eax),%eax
     134:	3a 45 fc             	cmp    0xfffffffc(%ebp),%al
     137:	75 08                	jne    141 <strchr+0x21>
      return (char*) s;
     139:	8b 45 08             	mov    0x8(%ebp),%eax
     13c:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
     13f:	eb 15                	jmp    156 <strchr+0x36>
     141:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     145:	8b 45 08             	mov    0x8(%ebp),%eax
     148:	0f b6 00             	movzbl (%eax),%eax
     14b:	84 c0                	test   %al,%al
     14d:	75 df                	jne    12e <strchr+0xe>
  return 0;
     14f:	c7 45 f8 00 00 00 00 	movl   $0x0,0xfffffff8(%ebp)
     156:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
}
     159:	c9                   	leave  
     15a:	c3                   	ret    
     15b:	90                   	nop    
     15c:	8d 74 26 00          	lea    0x0(%esi),%esi

00000160 <gets>:

char*
gets(char *buf, int max)
{
     160:	55                   	push   %ebp
     161:	89 e5                	mov    %esp,%ebp
     163:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     166:	c7 45 f8 00 00 00 00 	movl   $0x0,0xfffffff8(%ebp)
     16d:	eb 46                	jmp    1b5 <gets+0x55>
    cc = read(0, &c, 1);
     16f:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
     176:	00 
     177:	8d 45 f7             	lea    0xfffffff7(%ebp),%eax
     17a:	89 44 24 04          	mov    %eax,0x4(%esp)
     17e:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     185:	e8 52 01 00 00       	call   2dc <read>
     18a:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
    if(cc < 1)
     18d:	83 7d fc 00          	cmpl   $0x0,0xfffffffc(%ebp)
     191:	7e 2d                	jle    1c0 <gets+0x60>
      break;
    buf[i++] = c;
     193:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     196:	89 c2                	mov    %eax,%edx
     198:	03 55 08             	add    0x8(%ebp),%edx
     19b:	0f b6 45 f7          	movzbl 0xfffffff7(%ebp),%eax
     19f:	88 02                	mov    %al,(%edx)
     1a1:	83 45 f8 01          	addl   $0x1,0xfffffff8(%ebp)
    if(c == '\n' || c == '\r')
     1a5:	0f b6 45 f7          	movzbl 0xfffffff7(%ebp),%eax
     1a9:	3c 0a                	cmp    $0xa,%al
     1ab:	74 13                	je     1c0 <gets+0x60>
     1ad:	0f b6 45 f7          	movzbl 0xfffffff7(%ebp),%eax
     1b1:	3c 0d                	cmp    $0xd,%al
     1b3:	74 0b                	je     1c0 <gets+0x60>
     1b5:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     1b8:	83 c0 01             	add    $0x1,%eax
     1bb:	3b 45 0c             	cmp    0xc(%ebp),%eax
     1be:	7c af                	jl     16f <gets+0xf>
      break;
  }
  buf[i] = '\0';
     1c0:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     1c3:	03 45 08             	add    0x8(%ebp),%eax
     1c6:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
     1c9:	8b 45 08             	mov    0x8(%ebp),%eax
}
     1cc:	c9                   	leave  
     1cd:	c3                   	ret    
     1ce:	89 f6                	mov    %esi,%esi

000001d0 <stat>:

int
stat(char *n, struct stat *st)
{
     1d0:	55                   	push   %ebp
     1d1:	89 e5                	mov    %esp,%ebp
     1d3:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     1d6:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     1dd:	00 
     1de:	8b 45 08             	mov    0x8(%ebp),%eax
     1e1:	89 04 24             	mov    %eax,(%esp)
     1e4:	e8 1b 01 00 00       	call   304 <open>
     1e9:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
  if(fd < 0)
     1ec:	83 7d f8 00          	cmpl   $0x0,0xfffffff8(%ebp)
     1f0:	79 09                	jns    1fb <stat+0x2b>
    return -1;
     1f2:	c7 45 ec ff ff ff ff 	movl   $0xffffffff,0xffffffec(%ebp)
     1f9:	eb 26                	jmp    221 <stat+0x51>
  r = fstat(fd, st);
     1fb:	8b 45 0c             	mov    0xc(%ebp),%eax
     1fe:	89 44 24 04          	mov    %eax,0x4(%esp)
     202:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     205:	89 04 24             	mov    %eax,(%esp)
     208:	e8 0f 01 00 00       	call   31c <fstat>
     20d:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
  close(fd);
     210:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     213:	89 04 24             	mov    %eax,(%esp)
     216:	e8 d1 00 00 00       	call   2ec <close>
  return r;
     21b:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     21e:	89 45 ec             	mov    %eax,0xffffffec(%ebp)
     221:	8b 45 ec             	mov    0xffffffec(%ebp),%eax
}
     224:	c9                   	leave  
     225:	c3                   	ret    
     226:	8d 76 00             	lea    0x0(%esi),%esi
     229:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00000230 <atoi>:

int
atoi(const char *s)
{
     230:	55                   	push   %ebp
     231:	89 e5                	mov    %esp,%ebp
     233:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
     236:	c7 45 fc 00 00 00 00 	movl   $0x0,0xfffffffc(%ebp)
  while('0' <= *s && *s <= '9')
     23d:	eb 24                	jmp    263 <atoi+0x33>
    n = n*10 + *s++ - '0';
     23f:	8b 55 fc             	mov    0xfffffffc(%ebp),%edx
     242:	89 d0                	mov    %edx,%eax
     244:	c1 e0 02             	shl    $0x2,%eax
     247:	01 d0                	add    %edx,%eax
     249:	01 c0                	add    %eax,%eax
     24b:	89 c2                	mov    %eax,%edx
     24d:	8b 45 08             	mov    0x8(%ebp),%eax
     250:	0f b6 00             	movzbl (%eax),%eax
     253:	0f be c0             	movsbl %al,%eax
     256:	8d 04 02             	lea    (%edx,%eax,1),%eax
     259:	83 e8 30             	sub    $0x30,%eax
     25c:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
     25f:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     263:	8b 45 08             	mov    0x8(%ebp),%eax
     266:	0f b6 00             	movzbl (%eax),%eax
     269:	3c 2f                	cmp    $0x2f,%al
     26b:	7e 0a                	jle    277 <atoi+0x47>
     26d:	8b 45 08             	mov    0x8(%ebp),%eax
     270:	0f b6 00             	movzbl (%eax),%eax
     273:	3c 39                	cmp    $0x39,%al
     275:	7e c8                	jle    23f <atoi+0xf>
  return n;
     277:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
}
     27a:	c9                   	leave  
     27b:	c3                   	ret    
     27c:	8d 74 26 00          	lea    0x0(%esi),%esi

00000280 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
     280:	55                   	push   %ebp
     281:	89 e5                	mov    %esp,%ebp
     283:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
     286:	8b 45 08             	mov    0x8(%ebp),%eax
     289:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
  src = vsrc;
     28c:	8b 45 0c             	mov    0xc(%ebp),%eax
     28f:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
  while(n-- > 0)
     292:	eb 13                	jmp    2a7 <memmove+0x27>
    *dst++ = *src++;
     294:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     297:	0f b6 10             	movzbl (%eax),%edx
     29a:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     29d:	88 10                	mov    %dl,(%eax)
     29f:	83 45 f8 01          	addl   $0x1,0xfffffff8(%ebp)
     2a3:	83 45 fc 01          	addl   $0x1,0xfffffffc(%ebp)
     2a7:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     2ab:	0f 9f c0             	setg   %al
     2ae:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
     2b2:	84 c0                	test   %al,%al
     2b4:	75 de                	jne    294 <memmove+0x14>
  return vdst;
     2b6:	8b 45 08             	mov    0x8(%ebp),%eax
}
     2b9:	c9                   	leave  
     2ba:	c3                   	ret    
     2bb:	90                   	nop    

000002bc <fork>:
     2bc:	b8 01 00 00 00       	mov    $0x1,%eax
     2c1:	cd 30                	int    $0x30
     2c3:	c3                   	ret    

000002c4 <exit>:
     2c4:	b8 02 00 00 00       	mov    $0x2,%eax
     2c9:	cd 30                	int    $0x30
     2cb:	c3                   	ret    

000002cc <wait>:
     2cc:	b8 03 00 00 00       	mov    $0x3,%eax
     2d1:	cd 30                	int    $0x30
     2d3:	c3                   	ret    

000002d4 <pipe>:
     2d4:	b8 04 00 00 00       	mov    $0x4,%eax
     2d9:	cd 30                	int    $0x30
     2db:	c3                   	ret    

000002dc <read>:
     2dc:	b8 06 00 00 00       	mov    $0x6,%eax
     2e1:	cd 30                	int    $0x30
     2e3:	c3                   	ret    

000002e4 <write>:
     2e4:	b8 05 00 00 00       	mov    $0x5,%eax
     2e9:	cd 30                	int    $0x30
     2eb:	c3                   	ret    

000002ec <close>:
     2ec:	b8 07 00 00 00       	mov    $0x7,%eax
     2f1:	cd 30                	int    $0x30
     2f3:	c3                   	ret    

000002f4 <kill>:
     2f4:	b8 08 00 00 00       	mov    $0x8,%eax
     2f9:	cd 30                	int    $0x30
     2fb:	c3                   	ret    

000002fc <exec>:
     2fc:	b8 09 00 00 00       	mov    $0x9,%eax
     301:	cd 30                	int    $0x30
     303:	c3                   	ret    

00000304 <open>:
     304:	b8 0a 00 00 00       	mov    $0xa,%eax
     309:	cd 30                	int    $0x30
     30b:	c3                   	ret    

0000030c <mknod>:
     30c:	b8 0b 00 00 00       	mov    $0xb,%eax
     311:	cd 30                	int    $0x30
     313:	c3                   	ret    

00000314 <unlink>:
     314:	b8 0c 00 00 00       	mov    $0xc,%eax
     319:	cd 30                	int    $0x30
     31b:	c3                   	ret    

0000031c <fstat>:
     31c:	b8 0d 00 00 00       	mov    $0xd,%eax
     321:	cd 30                	int    $0x30
     323:	c3                   	ret    

00000324 <link>:
     324:	b8 0e 00 00 00       	mov    $0xe,%eax
     329:	cd 30                	int    $0x30
     32b:	c3                   	ret    

0000032c <mkdir>:
     32c:	b8 0f 00 00 00       	mov    $0xf,%eax
     331:	cd 30                	int    $0x30
     333:	c3                   	ret    

00000334 <chdir>:
     334:	b8 10 00 00 00       	mov    $0x10,%eax
     339:	cd 30                	int    $0x30
     33b:	c3                   	ret    

0000033c <dup>:
     33c:	b8 11 00 00 00       	mov    $0x11,%eax
     341:	cd 30                	int    $0x30
     343:	c3                   	ret    

00000344 <getpid>:
     344:	b8 12 00 00 00       	mov    $0x12,%eax
     349:	cd 30                	int    $0x30
     34b:	c3                   	ret    

0000034c <sbrk>:
     34c:	b8 13 00 00 00       	mov    $0x13,%eax
     351:	cd 30                	int    $0x30
     353:	c3                   	ret    

00000354 <sleep>:
     354:	b8 14 00 00 00       	mov    $0x14,%eax
     359:	cd 30                	int    $0x30
     35b:	c3                   	ret    

0000035c <upmsec>:
     35c:	b8 15 00 00 00       	mov    $0x15,%eax
     361:	cd 30                	int    $0x30
     363:	c3                   	ret    

00000364 <socket>:
     364:	b8 16 00 00 00       	mov    $0x16,%eax
     369:	cd 30                	int    $0x30
     36b:	c3                   	ret    

0000036c <bind>:
     36c:	b8 17 00 00 00       	mov    $0x17,%eax
     371:	cd 30                	int    $0x30
     373:	c3                   	ret    

00000374 <listen>:
     374:	b8 18 00 00 00       	mov    $0x18,%eax
     379:	cd 30                	int    $0x30
     37b:	c3                   	ret    

0000037c <accept>:
     37c:	b8 19 00 00 00       	mov    $0x19,%eax
     381:	cd 30                	int    $0x30
     383:	c3                   	ret    

00000384 <recv>:
     384:	b8 1a 00 00 00       	mov    $0x1a,%eax
     389:	cd 30                	int    $0x30
     38b:	c3                   	ret    

0000038c <recvfrom>:
     38c:	b8 1b 00 00 00       	mov    $0x1b,%eax
     391:	cd 30                	int    $0x30
     393:	c3                   	ret    

00000394 <send>:
     394:	b8 1c 00 00 00       	mov    $0x1c,%eax
     399:	cd 30                	int    $0x30
     39b:	c3                   	ret    

0000039c <sendto>:
     39c:	b8 1d 00 00 00       	mov    $0x1d,%eax
     3a1:	cd 30                	int    $0x30
     3a3:	c3                   	ret    

000003a4 <shutdown>:
     3a4:	b8 1e 00 00 00       	mov    $0x1e,%eax
     3a9:	cd 30                	int    $0x30
     3ab:	c3                   	ret    

000003ac <getsockopt>:
     3ac:	b8 1f 00 00 00       	mov    $0x1f,%eax
     3b1:	cd 30                	int    $0x30
     3b3:	c3                   	ret    

000003b4 <setsockopt>:
     3b4:	b8 20 00 00 00       	mov    $0x20,%eax
     3b9:	cd 30                	int    $0x30
     3bb:	c3                   	ret    

000003bc <sockclose>:
     3bc:	b8 21 00 00 00       	mov    $0x21,%eax
     3c1:	cd 30                	int    $0x30
     3c3:	c3                   	ret    

000003c4 <connect>:
     3c4:	b8 22 00 00 00       	mov    $0x22,%eax
     3c9:	cd 30                	int    $0x30
     3cb:	c3                   	ret    

000003cc <getpeername>:
     3cc:	b8 23 00 00 00       	mov    $0x23,%eax
     3d1:	cd 30                	int    $0x30
     3d3:	c3                   	ret    

000003d4 <getsockname>:
     3d4:	b8 24 00 00 00       	mov    $0x24,%eax
     3d9:	cd 30                	int    $0x30
     3db:	c3                   	ret    
     3dc:	90                   	nop    
     3dd:	90                   	nop    
     3de:	90                   	nop    
     3df:	90                   	nop    

000003e0 <putc>:
#include "user.h"

void
putc(int fd, char c)
{
     3e0:	55                   	push   %ebp
     3e1:	89 e5                	mov    %esp,%ebp
     3e3:	83 ec 18             	sub    $0x18,%esp
     3e6:	8b 45 0c             	mov    0xc(%ebp),%eax
     3e9:	88 45 fc             	mov    %al,0xfffffffc(%ebp)
  write(fd, &c, 1);
     3ec:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
     3f3:	00 
     3f4:	8d 45 fc             	lea    0xfffffffc(%ebp),%eax
     3f7:	89 44 24 04          	mov    %eax,0x4(%esp)
     3fb:	8b 45 08             	mov    0x8(%ebp),%eax
     3fe:	89 04 24             	mov    %eax,(%esp)
     401:	e8 de fe ff ff       	call   2e4 <write>
}
     406:	c9                   	leave  
     407:	c3                   	ret    
     408:	90                   	nop    
     409:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi

00000410 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     410:	55                   	push   %ebp
     411:	89 e5                	mov    %esp,%ebp
     413:	53                   	push   %ebx
     414:	83 ec 34             	sub    $0x34,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     417:	c7 45 f4 00 00 00 00 	movl   $0x0,0xfffffff4(%ebp)
  if(sgn && xx < 0){
     41e:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
     422:	74 17                	je     43b <printint+0x2b>
     424:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     428:	79 11                	jns    43b <printint+0x2b>
    neg = 1;
     42a:	c7 45 f4 01 00 00 00 	movl   $0x1,0xfffffff4(%ebp)
    x = -xx;
     431:	8b 45 0c             	mov    0xc(%ebp),%eax
     434:	f7 d8                	neg    %eax
     436:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
     439:	eb 06                	jmp    441 <printint+0x31>
  } else {
    x = xx;
     43b:	8b 45 0c             	mov    0xc(%ebp),%eax
     43e:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
  }

  i = 0;
     441:	c7 45 f0 00 00 00 00 	movl   $0x0,0xfffffff0(%ebp)
  do{
    buf[i++] = digits[x % base];
     448:	8b 4d f0             	mov    0xfffffff0(%ebp),%ecx
     44b:	8b 55 10             	mov    0x10(%ebp),%edx
     44e:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     451:	89 d3                	mov    %edx,%ebx
     453:	ba 00 00 00 00       	mov    $0x0,%edx
     458:	f7 f3                	div    %ebx
     45a:	89 d0                	mov    %edx,%eax
     45c:	0f b6 80 70 10 00 00 	movzbl 0x1070(%eax),%eax
     463:	88 44 0d e0          	mov    %al,0xffffffe0(%ebp,%ecx,1)
     467:	83 45 f0 01          	addl   $0x1,0xfffffff0(%ebp)
  }while((x /= base) != 0);
     46b:	8b 55 10             	mov    0x10(%ebp),%edx
     46e:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     471:	89 d1                	mov    %edx,%ecx
     473:	ba 00 00 00 00       	mov    $0x0,%edx
     478:	f7 f1                	div    %ecx
     47a:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
     47d:	83 7d f8 00          	cmpl   $0x0,0xfffffff8(%ebp)
     481:	75 c5                	jne    448 <printint+0x38>
  if(neg)
     483:	83 7d f4 00          	cmpl   $0x0,0xfffffff4(%ebp)
     487:	74 28                	je     4b1 <printint+0xa1>
    buf[i++] = '-';
     489:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
     48c:	c6 44 05 e0 2d       	movb   $0x2d,0xffffffe0(%ebp,%eax,1)
     491:	83 45 f0 01          	addl   $0x1,0xfffffff0(%ebp)

  while(--i >= 0)
     495:	eb 1a                	jmp    4b1 <printint+0xa1>
    putc(fd, buf[i]);
     497:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
     49a:	0f b6 44 05 e0       	movzbl 0xffffffe0(%ebp,%eax,1),%eax
     49f:	0f be c0             	movsbl %al,%eax
     4a2:	89 44 24 04          	mov    %eax,0x4(%esp)
     4a6:	8b 45 08             	mov    0x8(%ebp),%eax
     4a9:	89 04 24             	mov    %eax,(%esp)
     4ac:	e8 2f ff ff ff       	call   3e0 <putc>
     4b1:	83 6d f0 01          	subl   $0x1,0xfffffff0(%ebp)
     4b5:	83 7d f0 00          	cmpl   $0x0,0xfffffff0(%ebp)
     4b9:	79 dc                	jns    497 <printint+0x87>
}
     4bb:	83 c4 34             	add    $0x34,%esp
     4be:	5b                   	pop    %ebx
     4bf:	5d                   	pop    %ebp
     4c0:	c3                   	ret    
     4c1:	eb 0d                	jmp    4d0 <printf>
     4c3:	90                   	nop    
     4c4:	90                   	nop    
     4c5:	90                   	nop    
     4c6:	90                   	nop    
     4c7:	90                   	nop    
     4c8:	90                   	nop    
     4c9:	90                   	nop    
     4ca:	90                   	nop    
     4cb:	90                   	nop    
     4cc:	90                   	nop    
     4cd:	90                   	nop    
     4ce:	90                   	nop    
     4cf:	90                   	nop    

000004d0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
     4d0:	55                   	push   %ebp
     4d1:	89 e5                	mov    %esp,%ebp
     4d3:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
     4d6:	c7 45 f8 00 00 00 00 	movl   $0x0,0xfffffff8(%ebp)
  ap = (uint*)(void*)&fmt + 1;
     4dd:	8d 45 0c             	lea    0xc(%ebp),%eax
     4e0:	83 c0 04             	add    $0x4,%eax
     4e3:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
  for(i = 0; fmt[i]; i++){
     4e6:	c7 45 f4 00 00 00 00 	movl   $0x0,0xfffffff4(%ebp)
     4ed:	e9 7b 01 00 00       	jmp    66d <printf+0x19d>
    c = fmt[i] & 0xff;
     4f2:	8b 55 0c             	mov    0xc(%ebp),%edx
     4f5:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     4f8:	8d 04 02             	lea    (%edx,%eax,1),%eax
     4fb:	0f b6 00             	movzbl (%eax),%eax
     4fe:	0f be c0             	movsbl %al,%eax
     501:	25 ff 00 00 00       	and    $0xff,%eax
     506:	89 45 f0             	mov    %eax,0xfffffff0(%ebp)
    if(state == 0){
     509:	83 7d f8 00          	cmpl   $0x0,0xfffffff8(%ebp)
     50d:	75 2c                	jne    53b <printf+0x6b>
      if(c == '%'){
     50f:	83 7d f0 25          	cmpl   $0x25,0xfffffff0(%ebp)
     513:	75 0c                	jne    521 <printf+0x51>
        state = '%';
     515:	c7 45 f8 25 00 00 00 	movl   $0x25,0xfffffff8(%ebp)
     51c:	e9 48 01 00 00       	jmp    669 <printf+0x199>
      } else {
        putc(fd, c);
     521:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
     524:	0f be c0             	movsbl %al,%eax
     527:	89 44 24 04          	mov    %eax,0x4(%esp)
     52b:	8b 45 08             	mov    0x8(%ebp),%eax
     52e:	89 04 24             	mov    %eax,(%esp)
     531:	e8 aa fe ff ff       	call   3e0 <putc>
     536:	e9 2e 01 00 00       	jmp    669 <printf+0x199>
      }
    } else if(state == '%'){
     53b:	83 7d f8 25          	cmpl   $0x25,0xfffffff8(%ebp)
     53f:	0f 85 24 01 00 00    	jne    669 <printf+0x199>
      if(c == 'd'){
     545:	83 7d f0 64          	cmpl   $0x64,0xfffffff0(%ebp)
     549:	75 2d                	jne    578 <printf+0xa8>
        printint(fd, *ap, 10, 1);
     54b:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     54e:	8b 00                	mov    (%eax),%eax
     550:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
     557:	00 
     558:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
     55f:	00 
     560:	89 44 24 04          	mov    %eax,0x4(%esp)
     564:	8b 45 08             	mov    0x8(%ebp),%eax
     567:	89 04 24             	mov    %eax,(%esp)
     56a:	e8 a1 fe ff ff       	call   410 <printint>
        ap++;
     56f:	83 45 fc 04          	addl   $0x4,0xfffffffc(%ebp)
     573:	e9 ea 00 00 00       	jmp    662 <printf+0x192>
      } else if(c == 'x' || c == 'p'){
     578:	83 7d f0 78          	cmpl   $0x78,0xfffffff0(%ebp)
     57c:	74 06                	je     584 <printf+0xb4>
     57e:	83 7d f0 70          	cmpl   $0x70,0xfffffff0(%ebp)
     582:	75 2d                	jne    5b1 <printf+0xe1>
        printint(fd, *ap, 16, 0);
     584:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     587:	8b 00                	mov    (%eax),%eax
     589:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
     590:	00 
     591:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
     598:	00 
     599:	89 44 24 04          	mov    %eax,0x4(%esp)
     59d:	8b 45 08             	mov    0x8(%ebp),%eax
     5a0:	89 04 24             	mov    %eax,(%esp)
     5a3:	e8 68 fe ff ff       	call   410 <printint>
        ap++;
     5a8:	83 45 fc 04          	addl   $0x4,0xfffffffc(%ebp)
     5ac:	e9 b1 00 00 00       	jmp    662 <printf+0x192>
      } else if(c == 's'){
     5b1:	83 7d f0 73          	cmpl   $0x73,0xfffffff0(%ebp)
     5b5:	75 43                	jne    5fa <printf+0x12a>
        s = (char*)*ap;
     5b7:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     5ba:	8b 00                	mov    (%eax),%eax
     5bc:	89 45 ec             	mov    %eax,0xffffffec(%ebp)
        ap++;
     5bf:	83 45 fc 04          	addl   $0x4,0xfffffffc(%ebp)
        if(s == 0)
     5c3:	83 7d ec 00          	cmpl   $0x0,0xffffffec(%ebp)
     5c7:	75 25                	jne    5ee <printf+0x11e>
          s = "(null)";
     5c9:	c7 45 ec 54 10 00 00 	movl   $0x1054,0xffffffec(%ebp)
        while(*s != 0){
     5d0:	eb 1c                	jmp    5ee <printf+0x11e>
          putc(fd, *s);
     5d2:	8b 45 ec             	mov    0xffffffec(%ebp),%eax
     5d5:	0f b6 00             	movzbl (%eax),%eax
     5d8:	0f be c0             	movsbl %al,%eax
     5db:	89 44 24 04          	mov    %eax,0x4(%esp)
     5df:	8b 45 08             	mov    0x8(%ebp),%eax
     5e2:	89 04 24             	mov    %eax,(%esp)
     5e5:	e8 f6 fd ff ff       	call   3e0 <putc>
          s++;
     5ea:	83 45 ec 01          	addl   $0x1,0xffffffec(%ebp)
     5ee:	8b 45 ec             	mov    0xffffffec(%ebp),%eax
     5f1:	0f b6 00             	movzbl (%eax),%eax
     5f4:	84 c0                	test   %al,%al
     5f6:	75 da                	jne    5d2 <printf+0x102>
     5f8:	eb 68                	jmp    662 <printf+0x192>
        }
      } else if(c == 'c'){
     5fa:	83 7d f0 63          	cmpl   $0x63,0xfffffff0(%ebp)
     5fe:	75 1d                	jne    61d <printf+0x14d>
        putc(fd, *ap);
     600:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     603:	8b 00                	mov    (%eax),%eax
     605:	0f be c0             	movsbl %al,%eax
     608:	89 44 24 04          	mov    %eax,0x4(%esp)
     60c:	8b 45 08             	mov    0x8(%ebp),%eax
     60f:	89 04 24             	mov    %eax,(%esp)
     612:	e8 c9 fd ff ff       	call   3e0 <putc>
        ap++;
     617:	83 45 fc 04          	addl   $0x4,0xfffffffc(%ebp)
     61b:	eb 45                	jmp    662 <printf+0x192>
      } else if(c == '%'){
     61d:	83 7d f0 25          	cmpl   $0x25,0xfffffff0(%ebp)
     621:	75 17                	jne    63a <printf+0x16a>
        putc(fd, c);
     623:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
     626:	0f be c0             	movsbl %al,%eax
     629:	89 44 24 04          	mov    %eax,0x4(%esp)
     62d:	8b 45 08             	mov    0x8(%ebp),%eax
     630:	89 04 24             	mov    %eax,(%esp)
     633:	e8 a8 fd ff ff       	call   3e0 <putc>
     638:	eb 28                	jmp    662 <printf+0x192>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     63a:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
     641:	00 
     642:	8b 45 08             	mov    0x8(%ebp),%eax
     645:	89 04 24             	mov    %eax,(%esp)
     648:	e8 93 fd ff ff       	call   3e0 <putc>
        putc(fd, c);
     64d:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
     650:	0f be c0             	movsbl %al,%eax
     653:	89 44 24 04          	mov    %eax,0x4(%esp)
     657:	8b 45 08             	mov    0x8(%ebp),%eax
     65a:	89 04 24             	mov    %eax,(%esp)
     65d:	e8 7e fd ff ff       	call   3e0 <putc>
      }
      state = 0;
     662:	c7 45 f8 00 00 00 00 	movl   $0x0,0xfffffff8(%ebp)
     669:	83 45 f4 01          	addl   $0x1,0xfffffff4(%ebp)
     66d:	8b 55 0c             	mov    0xc(%ebp),%edx
     670:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     673:	8d 04 02             	lea    (%edx,%eax,1),%eax
     676:	0f b6 00             	movzbl (%eax),%eax
     679:	84 c0                	test   %al,%al
     67b:	0f 85 71 fe ff ff    	jne    4f2 <printf+0x22>
    }
  }
}
     681:	c9                   	leave  
     682:	c3                   	ret    
     683:	90                   	nop    
     684:	90                   	nop    
     685:	90                   	nop    
     686:	90                   	nop    
     687:	90                   	nop    
     688:	90                   	nop    
     689:	90                   	nop    
     68a:	90                   	nop    
     68b:	90                   	nop    
     68c:	90                   	nop    
     68d:	90                   	nop    
     68e:	90                   	nop    
     68f:	90                   	nop    

00000690 <free>:
static Header *freep;

void
free(void *ap)
{
     690:	55                   	push   %ebp
     691:	89 e5                	mov    %esp,%ebp
     693:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*) ap - 1;
     696:	8b 45 08             	mov    0x8(%ebp),%eax
     699:	83 e8 08             	sub    $0x8,%eax
     69c:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     69f:	a1 8c 10 00 00       	mov    0x108c,%eax
     6a4:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
     6a7:	eb 24                	jmp    6cd <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     6a9:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     6ac:	8b 00                	mov    (%eax),%eax
     6ae:	3b 45 fc             	cmp    0xfffffffc(%ebp),%eax
     6b1:	77 12                	ja     6c5 <free+0x35>
     6b3:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     6b6:	3b 45 fc             	cmp    0xfffffffc(%ebp),%eax
     6b9:	77 24                	ja     6df <free+0x4f>
     6bb:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     6be:	8b 00                	mov    (%eax),%eax
     6c0:	3b 45 f8             	cmp    0xfffffff8(%ebp),%eax
     6c3:	77 1a                	ja     6df <free+0x4f>
     6c5:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     6c8:	8b 00                	mov    (%eax),%eax
     6ca:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
     6cd:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     6d0:	3b 45 fc             	cmp    0xfffffffc(%ebp),%eax
     6d3:	76 d4                	jbe    6a9 <free+0x19>
     6d5:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     6d8:	8b 00                	mov    (%eax),%eax
     6da:	3b 45 f8             	cmp    0xfffffff8(%ebp),%eax
     6dd:	76 ca                	jbe    6a9 <free+0x19>
      break;
  if(bp + bp->s.size == p->s.ptr){
     6df:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     6e2:	8b 40 04             	mov    0x4(%eax),%eax
     6e5:	c1 e0 03             	shl    $0x3,%eax
     6e8:	89 c2                	mov    %eax,%edx
     6ea:	03 55 f8             	add    0xfffffff8(%ebp),%edx
     6ed:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     6f0:	8b 00                	mov    (%eax),%eax
     6f2:	39 c2                	cmp    %eax,%edx
     6f4:	75 24                	jne    71a <free+0x8a>
    bp->s.size += p->s.ptr->s.size;
     6f6:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     6f9:	8b 50 04             	mov    0x4(%eax),%edx
     6fc:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     6ff:	8b 00                	mov    (%eax),%eax
     701:	8b 40 04             	mov    0x4(%eax),%eax
     704:	01 c2                	add    %eax,%edx
     706:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     709:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
     70c:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     70f:	8b 00                	mov    (%eax),%eax
     711:	8b 10                	mov    (%eax),%edx
     713:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     716:	89 10                	mov    %edx,(%eax)
     718:	eb 0a                	jmp    724 <free+0x94>
  } else
    bp->s.ptr = p->s.ptr;
     71a:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     71d:	8b 10                	mov    (%eax),%edx
     71f:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     722:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
     724:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     727:	8b 40 04             	mov    0x4(%eax),%eax
     72a:	c1 e0 03             	shl    $0x3,%eax
     72d:	03 45 fc             	add    0xfffffffc(%ebp),%eax
     730:	3b 45 f8             	cmp    0xfffffff8(%ebp),%eax
     733:	75 20                	jne    755 <free+0xc5>
    p->s.size += bp->s.size;
     735:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     738:	8b 50 04             	mov    0x4(%eax),%edx
     73b:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     73e:	8b 40 04             	mov    0x4(%eax),%eax
     741:	01 c2                	add    %eax,%edx
     743:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     746:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
     749:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     74c:	8b 10                	mov    (%eax),%edx
     74e:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     751:	89 10                	mov    %edx,(%eax)
     753:	eb 08                	jmp    75d <free+0xcd>
  } else
    p->s.ptr = bp;
     755:	8b 55 fc             	mov    0xfffffffc(%ebp),%edx
     758:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     75b:	89 02                	mov    %eax,(%edx)
  freep = p;
     75d:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     760:	a3 8c 10 00 00       	mov    %eax,0x108c
}
     765:	c9                   	leave  
     766:	c3                   	ret    
     767:	89 f6                	mov    %esi,%esi
     769:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00000770 <morecore>:

static Header*
morecore(uint nu)
{
     770:	55                   	push   %ebp
     771:	89 e5                	mov    %esp,%ebp
     773:	83 ec 18             	sub    $0x18,%esp
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
     776:	8b 45 08             	mov    0x8(%ebp),%eax
     779:	c1 e0 03             	shl    $0x3,%eax
     77c:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
  size += PAGE - size % PAGE;
     77f:	8b 55 fc             	mov    0xfffffffc(%ebp),%edx
     782:	89 d0                	mov    %edx,%eax
     784:	c1 f8 1f             	sar    $0x1f,%eax
     787:	89 c1                	mov    %eax,%ecx
     789:	c1 e9 14             	shr    $0x14,%ecx
     78c:	8d 04 0a             	lea    (%edx,%ecx,1),%eax
     78f:	25 ff 0f 00 00       	and    $0xfff,%eax
     794:	29 c8                	sub    %ecx,%eax
     796:	89 c2                	mov    %eax,%edx
     798:	b8 00 10 00 00       	mov    $0x1000,%eax
     79d:	29 d0                	sub    %edx,%eax
     79f:	01 45 fc             	add    %eax,0xfffffffc(%ebp)
#endif
#ifdef UMALLOC_DEBUG
  printf(1, "size: %d\n", size);
#endif
  p = sbrk(size);
     7a2:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     7a5:	89 04 24             	mov    %eax,(%esp)
     7a8:	e8 9f fb ff ff       	call   34c <sbrk>
     7ad:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
  if(p == (char*) -1)
     7b0:	83 7d f4 ff          	cmpl   $0xffffffff,0xfffffff4(%ebp)
     7b4:	75 09                	jne    7bf <morecore+0x4f>
    return 0;
     7b6:	c7 45 ec 00 00 00 00 	movl   $0x0,0xffffffec(%ebp)
     7bd:	eb 2a                	jmp    7e9 <morecore+0x79>
  hp = (Header*)p;
     7bf:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     7c2:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
#ifdef UMALLOC_NOALIGN
  hp->s.size = nu;
#else
  hp->s.size = size / sizeof(Header);
     7c5:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     7c8:	89 c2                	mov    %eax,%edx
     7ca:	c1 ea 03             	shr    $0x3,%edx
     7cd:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     7d0:	89 50 04             	mov    %edx,0x4(%eax)
#endif
  free((void*)(hp + 1));
     7d3:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     7d6:	83 c0 08             	add    $0x8,%eax
     7d9:	89 04 24             	mov    %eax,(%esp)
     7dc:	e8 af fe ff ff       	call   690 <free>
  return freep;
     7e1:	a1 8c 10 00 00       	mov    0x108c,%eax
     7e6:	89 45 ec             	mov    %eax,0xffffffec(%ebp)
     7e9:	8b 45 ec             	mov    0xffffffec(%ebp),%eax
}
     7ec:	c9                   	leave  
     7ed:	c3                   	ret    
     7ee:	89 f6                	mov    %esi,%esi

000007f0 <malloc>:

void*
malloc(uint nbytes)
{
     7f0:	55                   	push   %ebp
     7f1:	89 e5                	mov    %esp,%ebp
     7f3:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

#ifdef UMALLOC_DEBUG
  printf(1, "malloc: %d bytes\n", nbytes);
  printf(1, "size of Header: %d\n", sizeof(Header));
#endif
  if (PAGE % sizeof(Header))
      printf(2, "Warning! align failed! Need UMALLOC_NOALIGN\n");
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     7f6:	8b 45 08             	mov    0x8(%ebp),%eax
     7f9:	83 c0 07             	add    $0x7,%eax
     7fc:	c1 e8 03             	shr    $0x3,%eax
     7ff:	83 c0 01             	add    $0x1,%eax
     802:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
  if((prevp = freep) == 0){
     805:	a1 8c 10 00 00       	mov    0x108c,%eax
     80a:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
     80d:	83 7d f8 00          	cmpl   $0x0,0xfffffff8(%ebp)
     811:	75 23                	jne    836 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
     813:	c7 45 f8 84 10 00 00 	movl   $0x1084,0xfffffff8(%ebp)
     81a:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     81d:	a3 8c 10 00 00       	mov    %eax,0x108c
     822:	a1 8c 10 00 00       	mov    0x108c,%eax
     827:	a3 84 10 00 00       	mov    %eax,0x1084
    base.s.size = 0;
     82c:	c7 05 88 10 00 00 00 	movl   $0x0,0x1088
     833:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     836:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     839:	8b 00                	mov    (%eax),%eax
     83b:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
    if(p->s.size >= nunits){
     83e:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     841:	8b 40 04             	mov    0x4(%eax),%eax
     844:	3b 45 fc             	cmp    0xfffffffc(%ebp),%eax
     847:	72 50                	jb     899 <malloc+0xa9>
      if(p->s.size == nunits)
     849:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     84c:	8b 40 04             	mov    0x4(%eax),%eax
     84f:	3b 45 fc             	cmp    0xfffffffc(%ebp),%eax
     852:	75 0c                	jne    860 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
     854:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     857:	8b 10                	mov    (%eax),%edx
     859:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     85c:	89 10                	mov    %edx,(%eax)
     85e:	eb 26                	jmp    886 <malloc+0x96>
      else {
        p->s.size -= nunits;
     860:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     863:	8b 40 04             	mov    0x4(%eax),%eax
     866:	89 c2                	mov    %eax,%edx
     868:	2b 55 fc             	sub    0xfffffffc(%ebp),%edx
     86b:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     86e:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
     871:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     874:	8b 40 04             	mov    0x4(%eax),%eax
     877:	c1 e0 03             	shl    $0x3,%eax
     87a:	01 45 f4             	add    %eax,0xfffffff4(%ebp)
        p->s.size = nunits;
     87d:	8b 55 f4             	mov    0xfffffff4(%ebp),%edx
     880:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     883:	89 42 04             	mov    %eax,0x4(%edx)
      }
      freep = prevp;
     886:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     889:	a3 8c 10 00 00       	mov    %eax,0x108c
      return (void*) (p + 1);
     88e:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     891:	83 c0 08             	add    $0x8,%eax
     894:	89 45 ec             	mov    %eax,0xffffffec(%ebp)
     897:	eb 3a                	jmp    8d3 <malloc+0xe3>
    }
    if(p == freep)
     899:	a1 8c 10 00 00       	mov    0x108c,%eax
     89e:	39 45 f4             	cmp    %eax,0xfffffff4(%ebp)
     8a1:	75 1d                	jne    8c0 <malloc+0xd0>
      if((p = morecore(nunits)) == 0)
     8a3:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     8a6:	89 04 24             	mov    %eax,(%esp)
     8a9:	e8 c2 fe ff ff       	call   770 <morecore>
     8ae:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
     8b1:	83 7d f4 00          	cmpl   $0x0,0xfffffff4(%ebp)
     8b5:	75 09                	jne    8c0 <malloc+0xd0>
        return 0;
     8b7:	c7 45 ec 00 00 00 00 	movl   $0x0,0xffffffec(%ebp)
     8be:	eb 13                	jmp    8d3 <malloc+0xe3>
     8c0:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     8c3:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
     8c6:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     8c9:	8b 00                	mov    (%eax),%eax
     8cb:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
  }
     8ce:	e9 6b ff ff ff       	jmp    83e <malloc+0x4e>
     8d3:	8b 45 ec             	mov    0xffffffec(%ebp),%eax
}
     8d6:	c9                   	leave  
     8d7:	c3                   	ret    
     8d8:	90                   	nop    
     8d9:	90                   	nop    
     8da:	90                   	nop    
     8db:	90                   	nop    
     8dc:	90                   	nop    
     8dd:	90                   	nop    
     8de:	90                   	nop    
     8df:	90                   	nop    

000008e0 <lwip_chksum>:


static u16_t
lwip_chksum(void *dataptr, int len)
{
     8e0:	55                   	push   %ebp
     8e1:	89 e5                	mov    %esp,%ebp
     8e3:	83 ec 18             	sub    $0x18,%esp
  u32_t acc;

  LWIP_DEBUGF(INET_DEBUG, ("lwip_chksum(%p, %d)\n", (void *)dataptr, len));
  for(acc = 0; len > 1; len -= 2) {
     8e6:	c7 45 fc 00 00 00 00 	movl   $0x0,0xfffffffc(%ebp)
     8ed:	eb 19                	jmp    908 <lwip_chksum+0x28>
      /*    acc = acc + *((u16_t *)dataptr)++;*/
    acc += *(u16_t *)dataptr;
     8ef:	8b 45 08             	mov    0x8(%ebp),%eax
     8f2:	0f b7 00             	movzwl (%eax),%eax
     8f5:	0f b7 c0             	movzwl %ax,%eax
     8f8:	01 45 fc             	add    %eax,0xfffffffc(%ebp)
    dataptr = (void *)((u16_t *)dataptr + 1);
     8fb:	8b 45 08             	mov    0x8(%ebp),%eax
     8fe:	83 c0 02             	add    $0x2,%eax
     901:	89 45 08             	mov    %eax,0x8(%ebp)
     904:	83 6d 0c 02          	subl   $0x2,0xc(%ebp)
     908:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
     90c:	7f e1                	jg     8ef <lwip_chksum+0xf>
  }

  /* add up any odd byte */
  if (len == 1) {
     90e:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
     912:	75 1d                	jne    931 <lwip_chksum+0x51>
    acc += htons((u16_t)((*(u8_t *)dataptr) & 0xff) << 8);
     914:	8b 45 08             	mov    0x8(%ebp),%eax
     917:	0f b6 00             	movzbl (%eax),%eax
     91a:	0f b6 c0             	movzbl %al,%eax
     91d:	c1 e0 08             	shl    $0x8,%eax
     920:	0f b7 c0             	movzwl %ax,%eax
     923:	89 04 24             	mov    %eax,(%esp)
     926:	e8 85 06 00 00       	call   fb0 <htons>
     92b:	0f b7 c0             	movzwl %ax,%eax
     92e:	01 45 fc             	add    %eax,0xfffffffc(%ebp)
    LWIP_DEBUGF(INET_DEBUG, ("inet: chksum: odd byte %d\n", (unsigned int)(*(u8_t *)dataptr)));
  } else {
    LWIP_DEBUGF(INET_DEBUG, ("inet: chksum: no odd byte\n"));
  }
  acc = (acc >> 16) + (acc & 0xffffUL);
     931:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     934:	89 c2                	mov    %eax,%edx
     936:	c1 ea 10             	shr    $0x10,%edx
     939:	0f b7 45 fc          	movzwl 0xfffffffc(%ebp),%eax
     93d:	8d 04 02             	lea    (%edx,%eax,1),%eax
     940:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)

  if ((acc & 0xffff0000) != 0) {
     943:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     946:	66 b8 00 00          	mov    $0x0,%ax
     94a:	85 c0                	test   %eax,%eax
     94c:	74 12                	je     960 <lwip_chksum+0x80>
    acc = (acc >> 16) + (acc & 0xffffUL);
     94e:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     951:	89 c2                	mov    %eax,%edx
     953:	c1 ea 10             	shr    $0x10,%edx
     956:	0f b7 45 fc          	movzwl 0xfffffffc(%ebp),%eax
     95a:	8d 04 02             	lea    (%edx,%eax,1),%eax
     95d:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
  }

  return (u16_t)acc;
     960:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     963:	0f b7 c0             	movzwl %ax,%eax
}
     966:	c9                   	leave  
     967:	c3                   	ret    
     968:	90                   	nop    
     969:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi

00000970 <inet_chksum_pseudo>:

/* inet_chksum_pseudo:
 *
 * Calculates the pseudo Internet checksum used by TCP and UDP for a pbuf chain.
 */

u16_t
inet_chksum_pseudo(struct pbuf *p,
       struct ip_addr *src, struct ip_addr *dest,
       u8_t proto, u16_t proto_len)
{
     970:	55                   	push   %ebp
     971:	89 e5                	mov    %esp,%ebp
     973:	83 ec 28             	sub    $0x28,%esp
     976:	8b 45 14             	mov    0x14(%ebp),%eax
     979:	8b 55 18             	mov    0x18(%ebp),%edx
     97c:	88 45 ec             	mov    %al,0xffffffec(%ebp)
     97f:	66 89 55 e8          	mov    %dx,0xffffffe8(%ebp)
  u32_t acc;
  struct pbuf *q;
  u8_t swapped;

  acc = 0;
     983:	c7 45 f4 00 00 00 00 	movl   $0x0,0xfffffff4(%ebp)
  swapped = 0;
     98a:	c6 45 ff 00          	movb   $0x0,0xffffffff(%ebp)
  /* iterate through all pbuf in chain */
  for(q = p; q != NULL; q = q->next) {
     98e:	8b 45 08             	mov    0x8(%ebp),%eax
     991:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
     994:	eb 7b                	jmp    a11 <inet_chksum_pseudo+0xa1>
    LWIP_DEBUGF(INET_DEBUG, ("inet_chksum_pseudo(): checksumming pbuf %p (has next %p) \n",
      (void *)q, (void *)q->next));
    acc += lwip_chksum(q->payload, q->len);
     996:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     999:	0f b7 40 0a          	movzwl 0xa(%eax),%eax
     99d:	0f b7 d0             	movzwl %ax,%edx
     9a0:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     9a3:	8b 40 04             	mov    0x4(%eax),%eax
     9a6:	89 54 24 04          	mov    %edx,0x4(%esp)
     9aa:	89 04 24             	mov    %eax,(%esp)
     9ad:	e8 2e ff ff ff       	call   8e0 <lwip_chksum>
     9b2:	0f b7 c0             	movzwl %ax,%eax
     9b5:	01 45 f4             	add    %eax,0xfffffff4(%ebp)
    /*LWIP_DEBUGF(INET_DEBUG, ("inet_chksum_pseudo(): unwrapped lwip_chksum()=%lx \n", acc));*/
    while (acc >> 16) {
     9b8:	eb 10                	jmp    9ca <inet_chksum_pseudo+0x5a>
      acc = (acc & 0xffffUL) + (acc >> 16);
     9ba:	0f b7 55 f4          	movzwl 0xfffffff4(%ebp),%edx
     9be:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     9c1:	c1 e8 10             	shr    $0x10,%eax
     9c4:	8d 04 02             	lea    (%edx,%eax,1),%eax
     9c7:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
     9ca:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     9cd:	c1 e8 10             	shr    $0x10,%eax
     9d0:	85 c0                	test   %eax,%eax
     9d2:	75 e6                	jne    9ba <inet_chksum_pseudo+0x4a>
    }
    if (q->len % 2 != 0) {
     9d4:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     9d7:	0f b7 40 0a          	movzwl 0xa(%eax),%eax
     9db:	0f b7 c0             	movzwl %ax,%eax
     9de:	83 e0 01             	and    $0x1,%eax
     9e1:	84 c0                	test   %al,%al
     9e3:	74 24                	je     a09 <inet_chksum_pseudo+0x99>
      swapped = 1 - swapped;
     9e5:	b8 01 00 00 00       	mov    $0x1,%eax
     9ea:	2a 45 ff             	sub    0xffffffff(%ebp),%al
     9ed:	88 45 ff             	mov    %al,0xffffffff(%ebp)
      acc = ((acc & 0xff) << 8) | ((acc & 0xff00UL) >> 8);
     9f0:	0f b6 45 f4          	movzbl 0xfffffff4(%ebp),%eax
     9f4:	89 c2                	mov    %eax,%edx
     9f6:	c1 e2 08             	shl    $0x8,%edx
     9f9:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     9fc:	25 00 ff 00 00       	and    $0xff00,%eax
     a01:	c1 e8 08             	shr    $0x8,%eax
     a04:	09 d0                	or     %edx,%eax
     a06:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
     a09:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     a0c:	8b 00                	mov    (%eax),%eax
     a0e:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
     a11:	83 7d f8 00          	cmpl   $0x0,0xfffffff8(%ebp)
     a15:	0f 85 7b ff ff ff    	jne    996 <inet_chksum_pseudo+0x26>
    }
    /*LWIP_DEBUGF(INET_DEBUG, ("inet_chksum_pseudo(): wrapped lwip_chksum()=%lx \n", acc));*/
  }

  if (swapped) {
     a1b:	80 7d ff 00          	cmpb   $0x0,0xffffffff(%ebp)
     a1f:	74 19                	je     a3a <inet_chksum_pseudo+0xca>
    acc = ((acc & 0xff) << 8) | ((acc & 0xff00UL) >> 8);
     a21:	0f b6 45 f4          	movzbl 0xfffffff4(%ebp),%eax
     a25:	89 c2                	mov    %eax,%edx
     a27:	c1 e2 08             	shl    $0x8,%edx
     a2a:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     a2d:	25 00 ff 00 00       	and    $0xff00,%eax
     a32:	c1 e8 08             	shr    $0x8,%eax
     a35:	09 d0                	or     %edx,%eax
     a37:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
  }
  acc += (src->addr & 0xffffUL);
     a3a:	8b 45 0c             	mov    0xc(%ebp),%eax
     a3d:	8b 00                	mov    (%eax),%eax
     a3f:	25 ff ff 00 00       	and    $0xffff,%eax
     a44:	01 45 f4             	add    %eax,0xfffffff4(%ebp)
  acc += ((src->addr >> 16) & 0xffffUL);
     a47:	8b 45 0c             	mov    0xc(%ebp),%eax
     a4a:	8b 00                	mov    (%eax),%eax
     a4c:	c1 e8 10             	shr    $0x10,%eax
     a4f:	25 ff ff 00 00       	and    $0xffff,%eax
     a54:	01 45 f4             	add    %eax,0xfffffff4(%ebp)
  acc += (dest->addr & 0xffffUL);
     a57:	8b 45 10             	mov    0x10(%ebp),%eax
     a5a:	8b 00                	mov    (%eax),%eax
     a5c:	25 ff ff 00 00       	and    $0xffff,%eax
     a61:	01 45 f4             	add    %eax,0xfffffff4(%ebp)
  acc += ((dest->addr >> 16) & 0xffffUL);
     a64:	8b 45 10             	mov    0x10(%ebp),%eax
     a67:	8b 00                	mov    (%eax),%eax
     a69:	c1 e8 10             	shr    $0x10,%eax
     a6c:	25 ff ff 00 00       	and    $0xffff,%eax
     a71:	01 45 f4             	add    %eax,0xfffffff4(%ebp)
  acc += (u32_t)htons((u16_t)proto);
     a74:	0f b6 45 ec          	movzbl 0xffffffec(%ebp),%eax
     a78:	89 04 24             	mov    %eax,(%esp)
     a7b:	e8 30 05 00 00       	call   fb0 <htons>
     a80:	0f b7 c0             	movzwl %ax,%eax
     a83:	01 45 f4             	add    %eax,0xfffffff4(%ebp)
  acc += (u32_t)htons(proto_len);
     a86:	0f b7 45 e8          	movzwl 0xffffffe8(%ebp),%eax
     a8a:	89 04 24             	mov    %eax,(%esp)
     a8d:	e8 1e 05 00 00       	call   fb0 <htons>
     a92:	0f b7 c0             	movzwl %ax,%eax
     a95:	01 45 f4             	add    %eax,0xfffffff4(%ebp)

  while (acc >> 16) {
     a98:	eb 10                	jmp    aaa <inet_chksum_pseudo+0x13a>
    acc = (acc & 0xffffUL) + (acc >> 16);
     a9a:	0f b7 55 f4          	movzwl 0xfffffff4(%ebp),%edx
     a9e:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     aa1:	c1 e8 10             	shr    $0x10,%eax
     aa4:	8d 04 02             	lea    (%edx,%eax,1),%eax
     aa7:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
     aaa:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     aad:	c1 e8 10             	shr    $0x10,%eax
     ab0:	85 c0                	test   %eax,%eax
     ab2:	75 e6                	jne    a9a <inet_chksum_pseudo+0x12a>
  }
  LWIP_DEBUGF(INET_DEBUG, ("inet_chksum_pseudo(): pbuf chain lwip_chksum()=%lx\n", acc));
  return ~(acc & 0xffffUL);
     ab4:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     ab7:	f7 d0                	not    %eax
     ab9:	0f b7 c0             	movzwl %ax,%eax
}
     abc:	c9                   	leave  
     abd:	c3                   	ret    
     abe:	89 f6                	mov    %esi,%esi

00000ac0 <inet_chksum>:

/* inet_chksum:
 *
 * Calculates the Internet checksum over a portion of memory. Used primarely for IP
 * and ICMP.
 */

u16_t
inet_chksum(void *dataptr, u16_t len)
{
     ac0:	55                   	push   %ebp
     ac1:	89 e5                	mov    %esp,%ebp
     ac3:	83 ec 28             	sub    $0x28,%esp
     ac6:	8b 45 0c             	mov    0xc(%ebp),%eax
     ac9:	66 89 45 ec          	mov    %ax,0xffffffec(%ebp)
  u32_t acc;

  acc = lwip_chksum(dataptr, len);
     acd:	0f b7 45 ec          	movzwl 0xffffffec(%ebp),%eax
     ad1:	89 44 24 04          	mov    %eax,0x4(%esp)
     ad5:	8b 45 08             	mov    0x8(%ebp),%eax
     ad8:	89 04 24             	mov    %eax,(%esp)
     adb:	e8 00 fe ff ff       	call   8e0 <lwip_chksum>
     ae0:	0f b7 c0             	movzwl %ax,%eax
     ae3:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
  while (acc >> 16) {
     ae6:	eb 10                	jmp    af8 <inet_chksum+0x38>
    acc = (acc & 0xffff) + (acc >> 16);
     ae8:	0f b7 55 fc          	movzwl 0xfffffffc(%ebp),%edx
     aec:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     aef:	c1 e8 10             	shr    $0x10,%eax
     af2:	8d 04 02             	lea    (%edx,%eax,1),%eax
     af5:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
     af8:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     afb:	c1 e8 10             	shr    $0x10,%eax
     afe:	85 c0                	test   %eax,%eax
     b00:	75 e6                	jne    ae8 <inet_chksum+0x28>
  }
  return ~(acc & 0xffff);
     b02:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     b05:	f7 d0                	not    %eax
     b07:	0f b7 c0             	movzwl %ax,%eax
}
     b0a:	c9                   	leave  
     b0b:	c3                   	ret    
     b0c:	8d 74 26 00          	lea    0x0(%esi),%esi

00000b10 <inet_chksum_pbuf>:

u16_t
inet_chksum_pbuf(struct pbuf *p)
{
     b10:	55                   	push   %ebp
     b11:	89 e5                	mov    %esp,%ebp
     b13:	83 ec 18             	sub    $0x18,%esp
  u32_t acc;
  struct pbuf *q;
  u8_t swapped;

  acc = 0;
     b16:	c7 45 f4 00 00 00 00 	movl   $0x0,0xfffffff4(%ebp)
  swapped = 0;
     b1d:	c6 45 ff 00          	movb   $0x0,0xffffffff(%ebp)
  for(q = p; q != NULL; q = q->next) {
     b21:	8b 45 08             	mov    0x8(%ebp),%eax
     b24:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
     b27:	eb 69                	jmp    b92 <inet_chksum_pbuf+0x82>
    acc += lwip_chksum(q->payload, q->len);
     b29:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     b2c:	0f b7 40 0a          	movzwl 0xa(%eax),%eax
     b30:	0f b7 d0             	movzwl %ax,%edx
     b33:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     b36:	8b 40 04             	mov    0x4(%eax),%eax
     b39:	89 54 24 04          	mov    %edx,0x4(%esp)
     b3d:	89 04 24             	mov    %eax,(%esp)
     b40:	e8 9b fd ff ff       	call   8e0 <lwip_chksum>
     b45:	0f b7 c0             	movzwl %ax,%eax
     b48:	01 45 f4             	add    %eax,0xfffffff4(%ebp)
    while (acc >> 16) {
     b4b:	eb 10                	jmp    b5d <inet_chksum_pbuf+0x4d>
      acc = (acc & 0xffffUL) + (acc >> 16);
     b4d:	0f b7 55 f4          	movzwl 0xfffffff4(%ebp),%edx
     b51:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     b54:	c1 e8 10             	shr    $0x10,%eax
     b57:	8d 04 02             	lea    (%edx,%eax,1),%eax
     b5a:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
     b5d:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     b60:	c1 e8 10             	shr    $0x10,%eax
     b63:	85 c0                	test   %eax,%eax
     b65:	75 e6                	jne    b4d <inet_chksum_pbuf+0x3d>
    }
    if (q->len % 2 != 0) {
     b67:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     b6a:	0f b7 40 0a          	movzwl 0xa(%eax),%eax
     b6e:	0f b7 c0             	movzwl %ax,%eax
     b71:	83 e0 01             	and    $0x1,%eax
     b74:	84 c0                	test   %al,%al
     b76:	74 12                	je     b8a <inet_chksum_pbuf+0x7a>
      swapped = 1 - swapped;
     b78:	b8 01 00 00 00       	mov    $0x1,%eax
     b7d:	2a 45 ff             	sub    0xffffffff(%ebp),%al
     b80:	88 45 ff             	mov    %al,0xffffffff(%ebp)
      acc = (acc & 0x00ffUL << 8) | (acc & 0xff00UL >> 8);
     b83:	81 65 f4 ff ff 00 00 	andl   $0xffff,0xfffffff4(%ebp)
     b8a:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     b8d:	8b 00                	mov    (%eax),%eax
     b8f:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
     b92:	83 7d f8 00          	cmpl   $0x0,0xfffffff8(%ebp)
     b96:	75 91                	jne    b29 <inet_chksum_pbuf+0x19>
    }
  }

  if (swapped) {
     b98:	80 7d ff 00          	cmpb   $0x0,0xffffffff(%ebp)
     b9c:	74 19                	je     bb7 <inet_chksum_pbuf+0xa7>
    acc = ((acc & 0x00ffUL) << 8) | ((acc & 0xff00UL) >> 8);
     b9e:	0f b6 45 f4          	movzbl 0xfffffff4(%ebp),%eax
     ba2:	89 c2                	mov    %eax,%edx
     ba4:	c1 e2 08             	shl    $0x8,%edx
     ba7:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     baa:	25 00 ff 00 00       	and    $0xff00,%eax
     baf:	c1 e8 08             	shr    $0x8,%eax
     bb2:	09 d0                	or     %edx,%eax
     bb4:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
  }
  return ~(acc & 0xffffUL);
     bb7:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     bba:	f7 d0                	not    %eax
     bbc:	0f b7 c0             	movzwl %ax,%eax
}
     bbf:	c9                   	leave  
     bc0:	c3                   	ret    
     bc1:	eb 0d                	jmp    bd0 <inet_addr>
     bc3:	90                   	nop    
     bc4:	90                   	nop    
     bc5:	90                   	nop    
     bc6:	90                   	nop    
     bc7:	90                   	nop    
     bc8:	90                   	nop    
     bc9:	90                   	nop    
     bca:	90                   	nop    
     bcb:	90                   	nop    
     bcc:	90                   	nop    
     bcd:	90                   	nop    
     bce:	90                   	nop    
     bcf:	90                   	nop    

00000bd0 <inet_addr>:

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
     bd0:	55                   	push   %ebp
     bd1:	89 e5                	mov    %esp,%ebp
     bd3:	83 ec 28             	sub    $0x28,%esp
     struct in_addr val;

     if (inet_aton(cp, &val)) {
     bd6:	8d 45 fc             	lea    0xfffffffc(%ebp),%eax
     bd9:	89 44 24 04          	mov    %eax,0x4(%esp)
     bdd:	8b 45 08             	mov    0x8(%ebp),%eax
     be0:	89 04 24             	mov    %eax,(%esp)
     be3:	e8 18 00 00 00       	call   c00 <inet_aton>
     be8:	85 c0                	test   %eax,%eax
     bea:	74 08                	je     bf4 <inet_addr+0x24>
         return (val.s_addr);
     bec:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     bef:	89 45 ec             	mov    %eax,0xffffffec(%ebp)
     bf2:	eb 07                	jmp    bfb <inet_addr+0x2b>
     }
     return (INADDR_NONE);
     bf4:	c7 45 ec ff ff ff ff 	movl   $0xffffffff,0xffffffec(%ebp)
     bfb:	8b 45 ec             	mov    0xffffffec(%ebp),%eax
 }
     bfe:	c9                   	leave  
     bff:	c3                   	ret    

00000c00 <inet_aton>:

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
     c00:	55                   	push   %ebp
     c01:	89 e5                	mov    %esp,%ebp
     c03:	83 ec 48             	sub    $0x48,%esp
     u32_t val;
     int base, n;
     char c;
     u32_t parts[4];
     u32_t* pp = parts;
     c06:	8d 45 dc             	lea    0xffffffdc(%ebp),%eax
     c09:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)

     c = *cp;
     c0c:	8b 45 08             	mov    0x8(%ebp),%eax
     c0f:	0f b6 00             	movzbl (%eax),%eax
     c12:	88 45 fb             	mov    %al,0xfffffffb(%ebp)
     for (;;) {
         /*
          * Collect number up to ``.''.
          * Values are specified as for C:
          * 0x=hex, 0=octal, isdigit=decimal.
          */
         if (!isdigit(c))
     c15:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
     c19:	3c 2f                	cmp    $0x2f,%al
     c1b:	76 08                	jbe    c25 <inet_aton+0x25>
     c1d:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
     c21:	3c 39                	cmp    $0x39,%al
     c23:	76 0c                	jbe    c31 <inet_aton+0x31>
             return (0);
     c25:	c7 45 c0 00 00 00 00 	movl   $0x0,0xffffffc0(%ebp)
     c2c:	e9 78 02 00 00       	jmp    ea9 <inet_aton+0x2a9>
         val = 0; base = 10;
     c31:	c7 45 ec 00 00 00 00 	movl   $0x0,0xffffffec(%ebp)
     c38:	c7 45 f0 0a 00 00 00 	movl   $0xa,0xfffffff0(%ebp)
         if (c == '0') {
     c3f:	80 7d fb 30          	cmpb   $0x30,0xfffffffb(%ebp)
     c43:	75 36                	jne    c7b <inet_aton+0x7b>
             c = *++cp;
     c45:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     c49:	8b 45 08             	mov    0x8(%ebp),%eax
     c4c:	0f b6 00             	movzbl (%eax),%eax
     c4f:	88 45 fb             	mov    %al,0xfffffffb(%ebp)
             if (c == 'x' || c == 'X')
     c52:	80 7d fb 78          	cmpb   $0x78,0xfffffffb(%ebp)
     c56:	74 06                	je     c5e <inet_aton+0x5e>
     c58:	80 7d fb 58          	cmpb   $0x58,0xfffffffb(%ebp)
     c5c:	75 16                	jne    c74 <inet_aton+0x74>
                 base = 16, c = *++cp;
     c5e:	c7 45 f0 10 00 00 00 	movl   $0x10,0xfffffff0(%ebp)
     c65:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     c69:	8b 45 08             	mov    0x8(%ebp),%eax
     c6c:	0f b6 00             	movzbl (%eax),%eax
     c6f:	88 45 fb             	mov    %al,0xfffffffb(%ebp)
     c72:	eb 07                	jmp    c7b <inet_aton+0x7b>
             else
                 base = 8;
     c74:	c7 45 f0 08 00 00 00 	movl   $0x8,0xfffffff0(%ebp)
         }
         for (;;) {
             if (isascii(c) && isdigit(c)) {
     c7b:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
     c7f:	3c 1f                	cmp    $0x1f,%al
     c81:	76 3b                	jbe    cbe <inet_aton+0xbe>
     c83:	80 7d fb 00          	cmpb   $0x0,0xfffffffb(%ebp)
     c87:	78 35                	js     cbe <inet_aton+0xbe>
     c89:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
     c8d:	3c 2f                	cmp    $0x2f,%al
     c8f:	76 2d                	jbe    cbe <inet_aton+0xbe>
     c91:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
     c95:	3c 39                	cmp    $0x39,%al
     c97:	77 25                	ja     cbe <inet_aton+0xbe>
                 val = (val * base) + (c - '0');
     c99:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
     c9c:	89 c2                	mov    %eax,%edx
     c9e:	0f af 55 ec          	imul   0xffffffec(%ebp),%edx
     ca2:	0f be 45 fb          	movsbl 0xfffffffb(%ebp),%eax
     ca6:	8d 04 02             	lea    (%edx,%eax,1),%eax
     ca9:	83 e8 30             	sub    $0x30,%eax
     cac:	89 45 ec             	mov    %eax,0xffffffec(%ebp)
                 c = *++cp;
     caf:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     cb3:	8b 45 08             	mov    0x8(%ebp),%eax
     cb6:	0f b6 00             	movzbl (%eax),%eax
     cb9:	88 45 fb             	mov    %al,0xfffffffb(%ebp)
     cbc:	eb bd                	jmp    c7b <inet_aton+0x7b>
             } else if (base == 16 && isascii(c) && isxdigit(c)) {
     cbe:	83 7d f0 10          	cmpl   $0x10,0xfffffff0(%ebp)
     cc2:	0f 85 99 00 00 00    	jne    d61 <inet_aton+0x161>
     cc8:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
     ccc:	3c 1f                	cmp    $0x1f,%al
     cce:	0f 86 8d 00 00 00    	jbe    d61 <inet_aton+0x161>
     cd4:	80 7d fb 00          	cmpb   $0x0,0xfffffffb(%ebp)
     cd8:	0f 88 83 00 00 00    	js     d61 <inet_aton+0x161>
     cde:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
     ce2:	3c 2f                	cmp    $0x2f,%al
     ce4:	76 08                	jbe    cee <inet_aton+0xee>
     ce6:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
     cea:	3c 39                	cmp    $0x39,%al
     cec:	76 20                	jbe    d0e <inet_aton+0x10e>
     cee:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
     cf2:	3c 60                	cmp    $0x60,%al
     cf4:	76 08                	jbe    cfe <inet_aton+0xfe>
     cf6:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
     cfa:	3c 66                	cmp    $0x66,%al
     cfc:	76 10                	jbe    d0e <inet_aton+0x10e>
     cfe:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
     d02:	3c 40                	cmp    $0x40,%al
     d04:	76 5b                	jbe    d61 <inet_aton+0x161>
     d06:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
     d0a:	3c 46                	cmp    $0x46,%al
     d0c:	77 53                	ja     d61 <inet_aton+0x161>
                 val = (val << 4) |
     d0e:	8b 45 ec             	mov    0xffffffec(%ebp),%eax
     d11:	89 c2                	mov    %eax,%edx
     d13:	c1 e2 04             	shl    $0x4,%edx
     d16:	89 55 c4             	mov    %edx,0xffffffc4(%ebp)
     d19:	0f be 45 fb          	movsbl 0xfffffffb(%ebp),%eax
     d1d:	83 c0 0a             	add    $0xa,%eax
     d20:	89 45 c8             	mov    %eax,0xffffffc8(%ebp)
     d23:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
     d27:	3c 60                	cmp    $0x60,%al
     d29:	76 11                	jbe    d3c <inet_aton+0x13c>
     d2b:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
     d2f:	3c 7a                	cmp    $0x7a,%al
     d31:	77 09                	ja     d3c <inet_aton+0x13c>
     d33:	c7 45 cc 61 00 00 00 	movl   $0x61,0xffffffcc(%ebp)
     d3a:	eb 07                	jmp    d43 <inet_aton+0x143>
     d3c:	c7 45 cc 41 00 00 00 	movl   $0x41,0xffffffcc(%ebp)
     d43:	8b 45 c8             	mov    0xffffffc8(%ebp),%eax
     d46:	2b 45 cc             	sub    0xffffffcc(%ebp),%eax
     d49:	0b 45 c4             	or     0xffffffc4(%ebp),%eax
     d4c:	89 45 ec             	mov    %eax,0xffffffec(%ebp)
                     (c + 10 - (islower(c) ? 'a' : 'A'));
                 c = *++cp;
     d4f:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     d53:	8b 45 08             	mov    0x8(%ebp),%eax
     d56:	0f b6 00             	movzbl (%eax),%eax
     d59:	88 45 fb             	mov    %al,0xfffffffb(%ebp)
             } else
             break;
         }
     d5c:	e9 1a ff ff ff       	jmp    c7b <inet_aton+0x7b>
         if (c == '.') {
     d61:	80 7d fb 2e          	cmpb   $0x2e,0xfffffffb(%ebp)
     d65:	75 35                	jne    d9c <inet_aton+0x19c>
             /*
              * Internet format:
              *  a.b.c.d
              *  a.b.c   (with c treated as 16 bits)
              *  a.b (with b treated as 24 bits)
              */
             if (pp >= parts + 3)
     d67:	8d 45 dc             	lea    0xffffffdc(%ebp),%eax
     d6a:	83 c0 0c             	add    $0xc,%eax
     d6d:	3b 45 fc             	cmp    0xfffffffc(%ebp),%eax
     d70:	77 0c                	ja     d7e <inet_aton+0x17e>
                 return (0);
     d72:	c7 45 c0 00 00 00 00 	movl   $0x0,0xffffffc0(%ebp)
     d79:	e9 2b 01 00 00       	jmp    ea9 <inet_aton+0x2a9>
             *pp++ = val;
     d7e:	8b 55 fc             	mov    0xfffffffc(%ebp),%edx
     d81:	8b 45 ec             	mov    0xffffffec(%ebp),%eax
     d84:	89 02                	mov    %eax,(%edx)
     d86:	83 45 fc 04          	addl   $0x4,0xfffffffc(%ebp)
             c = *++cp;
     d8a:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     d8e:	8b 45 08             	mov    0x8(%ebp),%eax
     d91:	0f b6 00             	movzbl (%eax),%eax
     d94:	88 45 fb             	mov    %al,0xfffffffb(%ebp)
         } else
             break;
     }
     d97:	e9 79 fe ff ff       	jmp    c15 <inet_aton+0x15>
     /*
      * Check for trailing characters.
      */
     if (c != '\0' && (!isascii(c) || !isspace(c)))
     d9c:	80 7d fb 00          	cmpb   $0x0,0xfffffffb(%ebp)
     da0:	74 3e                	je     de0 <inet_aton+0x1e0>
     da2:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
     da6:	3c 1f                	cmp    $0x1f,%al
     da8:	76 2a                	jbe    dd4 <inet_aton+0x1d4>
     daa:	80 7d fb 00          	cmpb   $0x0,0xfffffffb(%ebp)
     dae:	78 24                	js     dd4 <inet_aton+0x1d4>
     db0:	80 7d fb 20          	cmpb   $0x20,0xfffffffb(%ebp)
     db4:	74 2a                	je     de0 <inet_aton+0x1e0>
     db6:	80 7d fb 0c          	cmpb   $0xc,0xfffffffb(%ebp)
     dba:	74 24                	je     de0 <inet_aton+0x1e0>
     dbc:	80 7d fb 0a          	cmpb   $0xa,0xfffffffb(%ebp)
     dc0:	74 1e                	je     de0 <inet_aton+0x1e0>
     dc2:	80 7d fb 0d          	cmpb   $0xd,0xfffffffb(%ebp)
     dc6:	74 18                	je     de0 <inet_aton+0x1e0>
     dc8:	80 7d fb 09          	cmpb   $0x9,0xfffffffb(%ebp)
     dcc:	74 12                	je     de0 <inet_aton+0x1e0>
     dce:	80 7d fb 0b          	cmpb   $0xb,0xfffffffb(%ebp)
     dd2:	74 0c                	je     de0 <inet_aton+0x1e0>
         return (0);
     dd4:	c7 45 c0 00 00 00 00 	movl   $0x0,0xffffffc0(%ebp)
     ddb:	e9 c9 00 00 00       	jmp    ea9 <inet_aton+0x2a9>
     /*
      * Concoct the address according to
      * the number of parts specified.
      */
     n = pp - parts + 1;
     de0:	8b 55 fc             	mov    0xfffffffc(%ebp),%edx
     de3:	8d 45 dc             	lea    0xffffffdc(%ebp),%eax
     de6:	89 d1                	mov    %edx,%ecx
     de8:	29 c1                	sub    %eax,%ecx
     dea:	89 c8                	mov    %ecx,%eax
     dec:	c1 f8 02             	sar    $0x2,%eax
     def:	83 c0 01             	add    $0x1,%eax
     df2:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
     switch (n) {
     df5:	83 7d f4 04          	cmpl   $0x4,0xfffffff4(%ebp)
     df9:	0f 87 8b 00 00 00    	ja     e8a <inet_aton+0x28a>
     dff:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     e02:	c1 e0 02             	shl    $0x2,%eax
     e05:	8b 80 5c 10 00 00    	mov    0x105c(%eax),%eax
     e0b:	ff e0                	jmp    *%eax

     case 0:
         return (0);     /* initial nondigit */
     e0d:	c7 45 c0 00 00 00 00 	movl   $0x0,0xffffffc0(%ebp)
     e14:	e9 90 00 00 00       	jmp    ea9 <inet_aton+0x2a9>

     case 1:             /* a -- 32 bits */
         break;

     case 2:             /* a.b -- 8.24 bits */
         if (val > 0xffffff)
     e19:	81 7d ec ff ff ff 00 	cmpl   $0xffffff,0xffffffec(%ebp)
     e20:	76 09                	jbe    e2b <inet_aton+0x22b>
             return (0);
     e22:	c7 45 c0 00 00 00 00 	movl   $0x0,0xffffffc0(%ebp)
     e29:	eb 7e                	jmp    ea9 <inet_aton+0x2a9>
         val |= parts[0] << 24;
     e2b:	8b 45 dc             	mov    0xffffffdc(%ebp),%eax
     e2e:	c1 e0 18             	shl    $0x18,%eax
     e31:	09 45 ec             	or     %eax,0xffffffec(%ebp)
         break;
     e34:	eb 54                	jmp    e8a <inet_aton+0x28a>

     case 3:             /* a.b.c -- 8.8.16 bits */
         if (val > 0xffff)
     e36:	81 7d ec ff ff 00 00 	cmpl   $0xffff,0xffffffec(%ebp)
     e3d:	76 09                	jbe    e48 <inet_aton+0x248>
             return (0);
     e3f:	c7 45 c0 00 00 00 00 	movl   $0x0,0xffffffc0(%ebp)
     e46:	eb 61                	jmp    ea9 <inet_aton+0x2a9>
         val |= (parts[0] << 24) | (parts[1] << 16);
     e48:	8b 45 dc             	mov    0xffffffdc(%ebp),%eax
     e4b:	89 c2                	mov    %eax,%edx
     e4d:	c1 e2 18             	shl    $0x18,%edx
     e50:	8b 45 e0             	mov    0xffffffe0(%ebp),%eax
     e53:	c1 e0 10             	shl    $0x10,%eax
     e56:	09 d0                	or     %edx,%eax
     e58:	09 45 ec             	or     %eax,0xffffffec(%ebp)
         break;
     e5b:	eb 2d                	jmp    e8a <inet_aton+0x28a>

     case 4:             /* a.b.c.d -- 8.8.8.8 bits */
         if (val > 0xff)
     e5d:	81 7d ec ff 00 00 00 	cmpl   $0xff,0xffffffec(%ebp)
     e64:	76 09                	jbe    e6f <inet_aton+0x26f>
             return (0);
     e66:	c7 45 c0 00 00 00 00 	movl   $0x0,0xffffffc0(%ebp)
     e6d:	eb 3a                	jmp    ea9 <inet_aton+0x2a9>
         val |= (parts[0] << 24) | (parts[1] << 16) | (parts[2] << 8);
     e6f:	8b 45 dc             	mov    0xffffffdc(%ebp),%eax
     e72:	89 c2                	mov    %eax,%edx
     e74:	c1 e2 18             	shl    $0x18,%edx
     e77:	8b 45 e0             	mov    0xffffffe0(%ebp),%eax
     e7a:	c1 e0 10             	shl    $0x10,%eax
     e7d:	09 c2                	or     %eax,%edx
     e7f:	8b 45 e4             	mov    0xffffffe4(%ebp),%eax
     e82:	c1 e0 08             	shl    $0x8,%eax
     e85:	09 d0                	or     %edx,%eax
     e87:	09 45 ec             	or     %eax,0xffffffec(%ebp)
         break;
     }
     if (addr)
     e8a:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     e8e:	74 12                	je     ea2 <inet_aton+0x2a2>
         addr->s_addr = htonl(val);
     e90:	8b 45 ec             	mov    0xffffffec(%ebp),%eax
     e93:	89 04 24             	mov    %eax,(%esp)
     e96:	e8 65 01 00 00       	call   1000 <htonl>
     e9b:	89 c2                	mov    %eax,%edx
     e9d:	8b 45 0c             	mov    0xc(%ebp),%eax
     ea0:	89 10                	mov    %edx,(%eax)
     return (1);
     ea2:	c7 45 c0 01 00 00 00 	movl   $0x1,0xffffffc0(%ebp)
     ea9:	8b 45 c0             	mov    0xffffffc0(%ebp),%eax
 }
     eac:	c9                   	leave  
     ead:	c3                   	ret    
     eae:	89 f6                	mov    %esi,%esi

00000eb0 <inet_ntoa>:

/* Convert numeric IP address into decimal dotted ASCII representation.
 * returns ptr to static buffer; not reentrant!
 */
char *inet_ntoa(struct in_addr addr)
{
     eb0:	55                   	push   %ebp
     eb1:	89 e5                	mov    %esp,%ebp
     eb3:	53                   	push   %ebx
     eb4:	83 ec 24             	sub    $0x24,%esp
  static char str[16];
  u32_t s_addr = addr.s_addr;
     eb7:	8b 45 08             	mov    0x8(%ebp),%eax
     eba:	89 45 ec             	mov    %eax,0xffffffec(%ebp)
  char inv[3];
  char *rp;
  char *ap;
  u8_t rem;
  u8_t n;
  u8_t i;

  rp = str;
     ebd:	c7 45 f0 90 10 00 00 	movl   $0x1090,0xfffffff0(%ebp)
  ap = (u8_t *)&s_addr;
     ec4:	8d 45 ec             	lea    0xffffffec(%ebp),%eax
     ec7:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
  for(n = 0; n < 4; n++) {
     eca:	c6 45 fa 00          	movb   $0x0,0xfffffffa(%ebp)
     ece:	e9 af 00 00 00       	jmp    f82 <inet_ntoa+0xd2>
    i = 0;
     ed3:	c6 45 fb 00          	movb   $0x0,0xfffffffb(%ebp)
    do {
      rem = *ap % (u8_t)10;
     ed7:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     eda:	0f b6 08             	movzbl (%eax),%ecx
     edd:	b8 67 00 00 00       	mov    $0x67,%eax
     ee2:	f6 e9                	imul   %cl
     ee4:	66 c1 e8 08          	shr    $0x8,%ax
     ee8:	89 c2                	mov    %eax,%edx
     eea:	c0 fa 02             	sar    $0x2,%dl
     eed:	89 c8                	mov    %ecx,%eax
     eef:	c0 f8 07             	sar    $0x7,%al
     ef2:	89 d3                	mov    %edx,%ebx
     ef4:	28 c3                	sub    %al,%bl
     ef6:	88 5d db             	mov    %bl,0xffffffdb(%ebp)
     ef9:	0f b6 45 db          	movzbl 0xffffffdb(%ebp),%eax
     efd:	c1 e0 02             	shl    $0x2,%eax
     f00:	02 45 db             	add    0xffffffdb(%ebp),%al
     f03:	01 c0                	add    %eax,%eax
     f05:	89 ca                	mov    %ecx,%edx
     f07:	28 c2                	sub    %al,%dl
     f09:	88 55 db             	mov    %dl,0xffffffdb(%ebp)
     f0c:	0f b6 5d db          	movzbl 0xffffffdb(%ebp),%ebx
     f10:	88 5d f9             	mov    %bl,0xfffffff9(%ebp)
      *ap /= (u8_t)10;
     f13:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     f16:	0f b6 08             	movzbl (%eax),%ecx
     f19:	b8 67 00 00 00       	mov    $0x67,%eax
     f1e:	f6 e9                	imul   %cl
     f20:	66 c1 e8 08          	shr    $0x8,%ax
     f24:	89 c2                	mov    %eax,%edx
     f26:	c0 fa 02             	sar    $0x2,%dl
     f29:	89 c8                	mov    %ecx,%eax
     f2b:	c0 f8 07             	sar    $0x7,%al
     f2e:	28 c2                	sub    %al,%dl
     f30:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     f33:	88 10                	mov    %dl,(%eax)
      inv[i++] = '0' + rem;
     f35:	0f b6 55 fb          	movzbl 0xfffffffb(%ebp),%edx
     f39:	0f b6 45 f9          	movzbl 0xfffffff9(%ebp),%eax
     f3d:	83 c0 30             	add    $0x30,%eax
     f40:	88 44 15 e9          	mov    %al,0xffffffe9(%ebp,%edx,1)
     f44:	80 45 fb 01          	addb   $0x1,0xfffffffb(%ebp)
    } while(*ap);
     f48:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     f4b:	0f b6 00             	movzbl (%eax),%eax
     f4e:	84 c0                	test   %al,%al
     f50:	75 85                	jne    ed7 <inet_ntoa+0x27>
    while(i--)
     f52:	eb 12                	jmp    f66 <inet_ntoa+0xb6>
      *rp++ = inv[i];
     f54:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
     f58:	0f b6 54 05 e9       	movzbl 0xffffffe9(%ebp,%eax,1),%edx
     f5d:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
     f60:	88 10                	mov    %dl,(%eax)
     f62:	83 45 f0 01          	addl   $0x1,0xfffffff0(%ebp)
     f66:	80 6d fb 01          	subb   $0x1,0xfffffffb(%ebp)
     f6a:	80 7d fb ff          	cmpb   $0xff,0xfffffffb(%ebp)
     f6e:	75 e4                	jne    f54 <inet_ntoa+0xa4>
    *rp++ = '.';
     f70:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
     f73:	c6 00 2e             	movb   $0x2e,(%eax)
     f76:	83 45 f0 01          	addl   $0x1,0xfffffff0(%ebp)
    ap++;
     f7a:	83 45 f4 01          	addl   $0x1,0xfffffff4(%ebp)
     f7e:	80 45 fa 01          	addb   $0x1,0xfffffffa(%ebp)
     f82:	80 7d fa 03          	cmpb   $0x3,0xfffffffa(%ebp)
     f86:	0f 86 47 ff ff ff    	jbe    ed3 <inet_ntoa+0x23>
  }
  *--rp = 0;
     f8c:	83 6d f0 01          	subl   $0x1,0xfffffff0(%ebp)
     f90:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
     f93:	c6 00 00             	movb   $0x0,(%eax)
  return str;
     f96:	b8 90 10 00 00       	mov    $0x1090,%eax
}
     f9b:	83 c4 24             	add    $0x24,%esp
     f9e:	5b                   	pop    %ebx
     f9f:	5d                   	pop    %ebp
     fa0:	c3                   	ret    
     fa1:	eb 0d                	jmp    fb0 <htons>
     fa3:	90                   	nop    
     fa4:	90                   	nop    
     fa5:	90                   	nop    
     fa6:	90                   	nop    
     fa7:	90                   	nop    
     fa8:	90                   	nop    
     fa9:	90                   	nop    
     faa:	90                   	nop    
     fab:	90                   	nop    
     fac:	90                   	nop    
     fad:	90                   	nop    
     fae:	90                   	nop    
     faf:	90                   	nop    

00000fb0 <htons>:


#ifndef BYTE_ORDER
#error BYTE_ORDER is not defined
#endif
#if BYTE_ORDER == LITTLE_ENDIAN

u16_t
htons(u16_t n)
{
     fb0:	55                   	push   %ebp
     fb1:	89 e5                	mov    %esp,%ebp
     fb3:	83 ec 04             	sub    $0x4,%esp
     fb6:	8b 45 08             	mov    0x8(%ebp),%eax
     fb9:	66 89 45 fc          	mov    %ax,0xfffffffc(%ebp)
  return ((n & 0xff) << 8) | ((n & 0xff00) >> 8);
     fbd:	0f b7 45 fc          	movzwl 0xfffffffc(%ebp),%eax
     fc1:	25 ff 00 00 00       	and    $0xff,%eax
     fc6:	c1 e0 08             	shl    $0x8,%eax
     fc9:	89 c2                	mov    %eax,%edx
     fcb:	0f b7 45 fc          	movzwl 0xfffffffc(%ebp),%eax
     fcf:	25 00 ff 00 00       	and    $0xff00,%eax
     fd4:	c1 f8 08             	sar    $0x8,%eax
     fd7:	09 d0                	or     %edx,%eax
     fd9:	0f b7 c0             	movzwl %ax,%eax
}
     fdc:	c9                   	leave  
     fdd:	c3                   	ret    
     fde:	89 f6                	mov    %esi,%esi

00000fe0 <ntohs>:

u16_t
ntohs(u16_t n)
{
     fe0:	55                   	push   %ebp
     fe1:	89 e5                	mov    %esp,%ebp
     fe3:	83 ec 08             	sub    $0x8,%esp
     fe6:	8b 45 08             	mov    0x8(%ebp),%eax
     fe9:	66 89 45 fc          	mov    %ax,0xfffffffc(%ebp)
  return htons(n);
     fed:	0f b7 45 fc          	movzwl 0xfffffffc(%ebp),%eax
     ff1:	89 04 24             	mov    %eax,(%esp)
     ff4:	e8 b7 ff ff ff       	call   fb0 <htons>
     ff9:	0f b7 c0             	movzwl %ax,%eax
}
     ffc:	c9                   	leave  
     ffd:	c3                   	ret    
     ffe:	89 f6                	mov    %esi,%esi

00001000 <htonl>:

u32_t
htonl(u32_t n)
{
    1000:	55                   	push   %ebp
    1001:	89 e5                	mov    %esp,%ebp
  return ((n & 0xff) << 24) |
    1003:	0f b6 45 08          	movzbl 0x8(%ebp),%eax
    1007:	89 c2                	mov    %eax,%edx
    1009:	c1 e2 18             	shl    $0x18,%edx
    100c:	8b 45 08             	mov    0x8(%ebp),%eax
    100f:	25 00 ff 00 00       	and    $0xff00,%eax
    1014:	c1 e0 08             	shl    $0x8,%eax
    1017:	09 c2                	or     %eax,%edx
    1019:	8b 45 08             	mov    0x8(%ebp),%eax
    101c:	25 00 00 ff 00       	and    $0xff0000,%eax
    1021:	c1 e8 08             	shr    $0x8,%eax
    1024:	09 c2                	or     %eax,%edx
    1026:	8b 45 08             	mov    0x8(%ebp),%eax
    1029:	25 00 00 00 ff       	and    $0xff000000,%eax
    102e:	c1 e8 18             	shr    $0x18,%eax
    1031:	09 d0                	or     %edx,%eax
    ((n & 0xff00) << 8) |
    ((n & 0xff0000) >> 8) |
    ((n & 0xff000000) >> 24);
}
    1033:	5d                   	pop    %ebp
    1034:	c3                   	ret    
    1035:	8d 74 26 00          	lea    0x0(%esi),%esi
    1039:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00001040 <ntohl>:

u32_t
ntohl(u32_t n)
{
    1040:	55                   	push   %ebp
    1041:	89 e5                	mov    %esp,%ebp
    1043:	83 ec 04             	sub    $0x4,%esp
  return htonl(n);
    1046:	8b 45 08             	mov    0x8(%ebp),%eax
    1049:	89 04 24             	mov    %eax,(%esp)
    104c:	e8 af ff ff ff       	call   1000 <htonl>
}
    1051:	c9                   	leave  
    1052:	c3                   	ret    
