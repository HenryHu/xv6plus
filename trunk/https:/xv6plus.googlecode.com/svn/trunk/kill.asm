
_kill:     file format elf32-i386-freebsd

Disassembly of section .text:

00000000 <main>:
#include "user.h"

int
main(int argc, char **argv)
{
       0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
       4:	83 e4 f0             	and    $0xfffffff0,%esp
       7:	ff 71 fc             	pushl  0xfffffffc(%ecx)
       a:	55                   	push   %ebp
       b:	89 e5                	mov    %esp,%ebp
       d:	51                   	push   %ecx
       e:	83 ec 24             	sub    $0x24,%esp
      11:	89 4d e8             	mov    %ecx,0xffffffe8(%ebp)
  int i;
	
  if(argc < 1){
      14:	8b 45 e8             	mov    0xffffffe8(%ebp),%eax
      17:	83 38 00             	cmpl   $0x0,(%eax)
      1a:	7f 19                	jg     35 <main+0x35>
    printf(2, "usage: kill pid...\n");
      1c:	c7 44 24 04 94 10 00 	movl   $0x1094,0x4(%esp)
      23:	00 
      24:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
      2b:	e8 e0 04 00 00       	call   510 <printf>
    exit();
      30:	e8 cf 02 00 00       	call   304 <exit>
  }
  for(i=1; i<argc; i++)
      35:	c7 45 f8 01 00 00 00 	movl   $0x1,0xfffffff8(%ebp)
      3c:	eb 22                	jmp    60 <main+0x60>
    kill(atoi(argv[i]));
      3e:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
      41:	c1 e0 02             	shl    $0x2,%eax
      44:	8b 55 e8             	mov    0xffffffe8(%ebp),%edx
      47:	03 42 04             	add    0x4(%edx),%eax
      4a:	8b 00                	mov    (%eax),%eax
      4c:	89 04 24             	mov    %eax,(%esp)
      4f:	e8 1c 02 00 00       	call   270 <atoi>
      54:	89 04 24             	mov    %eax,(%esp)
      57:	e8 d8 02 00 00       	call   334 <kill>
      5c:	83 45 f8 01          	addl   $0x1,0xfffffff8(%ebp)
      60:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
      63:	8b 55 e8             	mov    0xffffffe8(%ebp),%edx
      66:	3b 02                	cmp    (%edx),%eax
      68:	7c d4                	jl     3e <main+0x3e>
  exit();
      6a:	e8 95 02 00 00       	call   304 <exit>
      6f:	90                   	nop    

00000070 <strcpy>:
#include "user.h"

char*
strcpy(char *s, char *t)
{
      70:	55                   	push   %ebp
      71:	89 e5                	mov    %esp,%ebp
      73:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
      76:	8b 45 08             	mov    0x8(%ebp),%eax
      79:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
  while((*s++ = *t++) != 0)
      7c:	8b 45 0c             	mov    0xc(%ebp),%eax
      7f:	0f b6 10             	movzbl (%eax),%edx
      82:	8b 45 08             	mov    0x8(%ebp),%eax
      85:	88 10                	mov    %dl,(%eax)
      87:	8b 45 08             	mov    0x8(%ebp),%eax
      8a:	0f b6 00             	movzbl (%eax),%eax
      8d:	84 c0                	test   %al,%al
      8f:	0f 95 c0             	setne  %al
      92:	83 45 08 01          	addl   $0x1,0x8(%ebp)
      96:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
      9a:	84 c0                	test   %al,%al
      9c:	75 de                	jne    7c <strcpy+0xc>
    ;
  return os;
      9e:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
}
      a1:	c9                   	leave  
      a2:	c3                   	ret    
      a3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

000000b0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
      b0:	55                   	push   %ebp
      b1:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
      b3:	eb 08                	jmp    bd <strcmp+0xd>
    p++, q++;
      b5:	83 45 08 01          	addl   $0x1,0x8(%ebp)
      b9:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
      bd:	8b 45 08             	mov    0x8(%ebp),%eax
      c0:	0f b6 00             	movzbl (%eax),%eax
      c3:	84 c0                	test   %al,%al
      c5:	74 10                	je     d7 <strcmp+0x27>
      c7:	8b 45 08             	mov    0x8(%ebp),%eax
      ca:	0f b6 10             	movzbl (%eax),%edx
      cd:	8b 45 0c             	mov    0xc(%ebp),%eax
      d0:	0f b6 00             	movzbl (%eax),%eax
      d3:	38 c2                	cmp    %al,%dl
      d5:	74 de                	je     b5 <strcmp+0x5>
  return (uchar)*p - (uchar)*q;
      d7:	8b 45 08             	mov    0x8(%ebp),%eax
      da:	0f b6 00             	movzbl (%eax),%eax
      dd:	0f b6 d0             	movzbl %al,%edx
      e0:	8b 45 0c             	mov    0xc(%ebp),%eax
      e3:	0f b6 00             	movzbl (%eax),%eax
      e6:	0f b6 c0             	movzbl %al,%eax
      e9:	89 d1                	mov    %edx,%ecx
      eb:	29 c1                	sub    %eax,%ecx
      ed:	89 c8                	mov    %ecx,%eax
}
      ef:	5d                   	pop    %ebp
      f0:	c3                   	ret    
      f1:	eb 0d                	jmp    100 <strlen>
      f3:	90                   	nop    
      f4:	90                   	nop    
      f5:	90                   	nop    
      f6:	90                   	nop    
      f7:	90                   	nop    
      f8:	90                   	nop    
      f9:	90                   	nop    
      fa:	90                   	nop    
      fb:	90                   	nop    
      fc:	90                   	nop    
      fd:	90                   	nop    
      fe:	90                   	nop    
      ff:	90                   	nop    

00000100 <strlen>:

uint
strlen(char *s)
{
     100:	55                   	push   %ebp
     101:	89 e5                	mov    %esp,%ebp
     103:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
     106:	c7 45 fc 00 00 00 00 	movl   $0x0,0xfffffffc(%ebp)
     10d:	eb 04                	jmp    113 <strlen+0x13>
     10f:	83 45 fc 01          	addl   $0x1,0xfffffffc(%ebp)
     113:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     116:	03 45 08             	add    0x8(%ebp),%eax
     119:	0f b6 00             	movzbl (%eax),%eax
     11c:	84 c0                	test   %al,%al
     11e:	75 ef                	jne    10f <strlen+0xf>
    ;
  return n;
     120:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
}
     123:	c9                   	leave  
     124:	c3                   	ret    
     125:	8d 74 26 00          	lea    0x0(%esi),%esi
     129:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00000130 <memset>:

void*
memset(void *dst, int c, uint n)
{
     130:	55                   	push   %ebp
     131:	89 e5                	mov    %esp,%ebp
     133:	83 ec 10             	sub    $0x10,%esp
  char *d;
  
  d = dst;
     136:	8b 45 08             	mov    0x8(%ebp),%eax
     139:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
  while(n-- > 0)
     13c:	eb 0e                	jmp    14c <memset+0x1c>
    *d++ = c;
     13e:	8b 45 0c             	mov    0xc(%ebp),%eax
     141:	89 c2                	mov    %eax,%edx
     143:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     146:	88 10                	mov    %dl,(%eax)
     148:	83 45 fc 01          	addl   $0x1,0xfffffffc(%ebp)
     14c:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
     150:	83 7d 10 ff          	cmpl   $0xffffffff,0x10(%ebp)
     154:	75 e8                	jne    13e <memset+0xe>
  return dst;
     156:	8b 45 08             	mov    0x8(%ebp),%eax
}
     159:	c9                   	leave  
     15a:	c3                   	ret    
     15b:	90                   	nop    
     15c:	8d 74 26 00          	lea    0x0(%esi),%esi

00000160 <strchr>:

char*
strchr(const char *s, char c)
{
     160:	55                   	push   %ebp
     161:	89 e5                	mov    %esp,%ebp
     163:	83 ec 08             	sub    $0x8,%esp
     166:	8b 45 0c             	mov    0xc(%ebp),%eax
     169:	88 45 fc             	mov    %al,0xfffffffc(%ebp)
  for(; *s; s++)
     16c:	eb 17                	jmp    185 <strchr+0x25>
    if(*s == c)
     16e:	8b 45 08             	mov    0x8(%ebp),%eax
     171:	0f b6 00             	movzbl (%eax),%eax
     174:	3a 45 fc             	cmp    0xfffffffc(%ebp),%al
     177:	75 08                	jne    181 <strchr+0x21>
      return (char*) s;
     179:	8b 45 08             	mov    0x8(%ebp),%eax
     17c:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
     17f:	eb 15                	jmp    196 <strchr+0x36>
     181:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     185:	8b 45 08             	mov    0x8(%ebp),%eax
     188:	0f b6 00             	movzbl (%eax),%eax
     18b:	84 c0                	test   %al,%al
     18d:	75 df                	jne    16e <strchr+0xe>
  return 0;
     18f:	c7 45 f8 00 00 00 00 	movl   $0x0,0xfffffff8(%ebp)
     196:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
}
     199:	c9                   	leave  
     19a:	c3                   	ret    
     19b:	90                   	nop    
     19c:	8d 74 26 00          	lea    0x0(%esi),%esi

000001a0 <gets>:

char*
gets(char *buf, int max)
{
     1a0:	55                   	push   %ebp
     1a1:	89 e5                	mov    %esp,%ebp
     1a3:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     1a6:	c7 45 f8 00 00 00 00 	movl   $0x0,0xfffffff8(%ebp)
     1ad:	eb 46                	jmp    1f5 <gets+0x55>
    cc = read(0, &c, 1);
     1af:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
     1b6:	00 
     1b7:	8d 45 f7             	lea    0xfffffff7(%ebp),%eax
     1ba:	89 44 24 04          	mov    %eax,0x4(%esp)
     1be:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     1c5:	e8 52 01 00 00       	call   31c <read>
     1ca:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
    if(cc < 1)
     1cd:	83 7d fc 00          	cmpl   $0x0,0xfffffffc(%ebp)
     1d1:	7e 2d                	jle    200 <gets+0x60>
      break;
    buf[i++] = c;
     1d3:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     1d6:	89 c2                	mov    %eax,%edx
     1d8:	03 55 08             	add    0x8(%ebp),%edx
     1db:	0f b6 45 f7          	movzbl 0xfffffff7(%ebp),%eax
     1df:	88 02                	mov    %al,(%edx)
     1e1:	83 45 f8 01          	addl   $0x1,0xfffffff8(%ebp)
    if(c == '\n' || c == '\r')
     1e5:	0f b6 45 f7          	movzbl 0xfffffff7(%ebp),%eax
     1e9:	3c 0a                	cmp    $0xa,%al
     1eb:	74 13                	je     200 <gets+0x60>
     1ed:	0f b6 45 f7          	movzbl 0xfffffff7(%ebp),%eax
     1f1:	3c 0d                	cmp    $0xd,%al
     1f3:	74 0b                	je     200 <gets+0x60>
     1f5:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     1f8:	83 c0 01             	add    $0x1,%eax
     1fb:	3b 45 0c             	cmp    0xc(%ebp),%eax
     1fe:	7c af                	jl     1af <gets+0xf>
      break;
  }
  buf[i] = '\0';
     200:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     203:	03 45 08             	add    0x8(%ebp),%eax
     206:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
     209:	8b 45 08             	mov    0x8(%ebp),%eax
}
     20c:	c9                   	leave  
     20d:	c3                   	ret    
     20e:	89 f6                	mov    %esi,%esi

00000210 <stat>:

int
stat(char *n, struct stat *st)
{
     210:	55                   	push   %ebp
     211:	89 e5                	mov    %esp,%ebp
     213:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     216:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     21d:	00 
     21e:	8b 45 08             	mov    0x8(%ebp),%eax
     221:	89 04 24             	mov    %eax,(%esp)
     224:	e8 1b 01 00 00       	call   344 <open>
     229:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
  if(fd < 0)
     22c:	83 7d f8 00          	cmpl   $0x0,0xfffffff8(%ebp)
     230:	79 09                	jns    23b <stat+0x2b>
    return -1;
     232:	c7 45 ec ff ff ff ff 	movl   $0xffffffff,0xffffffec(%ebp)
     239:	eb 26                	jmp    261 <stat+0x51>
  r = fstat(fd, st);
     23b:	8b 45 0c             	mov    0xc(%ebp),%eax
     23e:	89 44 24 04          	mov    %eax,0x4(%esp)
     242:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     245:	89 04 24             	mov    %eax,(%esp)
     248:	e8 0f 01 00 00       	call   35c <fstat>
     24d:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
  close(fd);
     250:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     253:	89 04 24             	mov    %eax,(%esp)
     256:	e8 d1 00 00 00       	call   32c <close>
  return r;
     25b:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     25e:	89 45 ec             	mov    %eax,0xffffffec(%ebp)
     261:	8b 45 ec             	mov    0xffffffec(%ebp),%eax
}
     264:	c9                   	leave  
     265:	c3                   	ret    
     266:	8d 76 00             	lea    0x0(%esi),%esi
     269:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00000270 <atoi>:

int
atoi(const char *s)
{
     270:	55                   	push   %ebp
     271:	89 e5                	mov    %esp,%ebp
     273:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
     276:	c7 45 fc 00 00 00 00 	movl   $0x0,0xfffffffc(%ebp)
  while('0' <= *s && *s <= '9')
     27d:	eb 24                	jmp    2a3 <atoi+0x33>
    n = n*10 + *s++ - '0';
     27f:	8b 55 fc             	mov    0xfffffffc(%ebp),%edx
     282:	89 d0                	mov    %edx,%eax
     284:	c1 e0 02             	shl    $0x2,%eax
     287:	01 d0                	add    %edx,%eax
     289:	01 c0                	add    %eax,%eax
     28b:	89 c2                	mov    %eax,%edx
     28d:	8b 45 08             	mov    0x8(%ebp),%eax
     290:	0f b6 00             	movzbl (%eax),%eax
     293:	0f be c0             	movsbl %al,%eax
     296:	8d 04 02             	lea    (%edx,%eax,1),%eax
     299:	83 e8 30             	sub    $0x30,%eax
     29c:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
     29f:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     2a3:	8b 45 08             	mov    0x8(%ebp),%eax
     2a6:	0f b6 00             	movzbl (%eax),%eax
     2a9:	3c 2f                	cmp    $0x2f,%al
     2ab:	7e 0a                	jle    2b7 <atoi+0x47>
     2ad:	8b 45 08             	mov    0x8(%ebp),%eax
     2b0:	0f b6 00             	movzbl (%eax),%eax
     2b3:	3c 39                	cmp    $0x39,%al
     2b5:	7e c8                	jle    27f <atoi+0xf>
  return n;
     2b7:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
}
     2ba:	c9                   	leave  
     2bb:	c3                   	ret    
     2bc:	8d 74 26 00          	lea    0x0(%esi),%esi

000002c0 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
     2c0:	55                   	push   %ebp
     2c1:	89 e5                	mov    %esp,%ebp
     2c3:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
     2c6:	8b 45 08             	mov    0x8(%ebp),%eax
     2c9:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
  src = vsrc;
     2cc:	8b 45 0c             	mov    0xc(%ebp),%eax
     2cf:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
  while(n-- > 0)
     2d2:	eb 13                	jmp    2e7 <memmove+0x27>
    *dst++ = *src++;
     2d4:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     2d7:	0f b6 10             	movzbl (%eax),%edx
     2da:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     2dd:	88 10                	mov    %dl,(%eax)
     2df:	83 45 f8 01          	addl   $0x1,0xfffffff8(%ebp)
     2e3:	83 45 fc 01          	addl   $0x1,0xfffffffc(%ebp)
     2e7:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     2eb:	0f 9f c0             	setg   %al
     2ee:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
     2f2:	84 c0                	test   %al,%al
     2f4:	75 de                	jne    2d4 <memmove+0x14>
  return vdst;
     2f6:	8b 45 08             	mov    0x8(%ebp),%eax
}
     2f9:	c9                   	leave  
     2fa:	c3                   	ret    
     2fb:	90                   	nop    

000002fc <fork>:
     2fc:	b8 01 00 00 00       	mov    $0x1,%eax
     301:	cd 30                	int    $0x30
     303:	c3                   	ret    

00000304 <exit>:
     304:	b8 02 00 00 00       	mov    $0x2,%eax
     309:	cd 30                	int    $0x30
     30b:	c3                   	ret    

0000030c <wait>:
     30c:	b8 03 00 00 00       	mov    $0x3,%eax
     311:	cd 30                	int    $0x30
     313:	c3                   	ret    

00000314 <pipe>:
     314:	b8 04 00 00 00       	mov    $0x4,%eax
     319:	cd 30                	int    $0x30
     31b:	c3                   	ret    

0000031c <read>:
     31c:	b8 06 00 00 00       	mov    $0x6,%eax
     321:	cd 30                	int    $0x30
     323:	c3                   	ret    

00000324 <write>:
     324:	b8 05 00 00 00       	mov    $0x5,%eax
     329:	cd 30                	int    $0x30
     32b:	c3                   	ret    

0000032c <close>:
     32c:	b8 07 00 00 00       	mov    $0x7,%eax
     331:	cd 30                	int    $0x30
     333:	c3                   	ret    

00000334 <kill>:
     334:	b8 08 00 00 00       	mov    $0x8,%eax
     339:	cd 30                	int    $0x30
     33b:	c3                   	ret    

0000033c <exec>:
     33c:	b8 09 00 00 00       	mov    $0x9,%eax
     341:	cd 30                	int    $0x30
     343:	c3                   	ret    

00000344 <open>:
     344:	b8 0a 00 00 00       	mov    $0xa,%eax
     349:	cd 30                	int    $0x30
     34b:	c3                   	ret    

0000034c <mknod>:
     34c:	b8 0b 00 00 00       	mov    $0xb,%eax
     351:	cd 30                	int    $0x30
     353:	c3                   	ret    

00000354 <unlink>:
     354:	b8 0c 00 00 00       	mov    $0xc,%eax
     359:	cd 30                	int    $0x30
     35b:	c3                   	ret    

0000035c <fstat>:
     35c:	b8 0d 00 00 00       	mov    $0xd,%eax
     361:	cd 30                	int    $0x30
     363:	c3                   	ret    

00000364 <link>:
     364:	b8 0e 00 00 00       	mov    $0xe,%eax
     369:	cd 30                	int    $0x30
     36b:	c3                   	ret    

0000036c <mkdir>:
     36c:	b8 0f 00 00 00       	mov    $0xf,%eax
     371:	cd 30                	int    $0x30
     373:	c3                   	ret    

00000374 <chdir>:
     374:	b8 10 00 00 00       	mov    $0x10,%eax
     379:	cd 30                	int    $0x30
     37b:	c3                   	ret    

0000037c <dup>:
     37c:	b8 11 00 00 00       	mov    $0x11,%eax
     381:	cd 30                	int    $0x30
     383:	c3                   	ret    

00000384 <getpid>:
     384:	b8 12 00 00 00       	mov    $0x12,%eax
     389:	cd 30                	int    $0x30
     38b:	c3                   	ret    

0000038c <sbrk>:
     38c:	b8 13 00 00 00       	mov    $0x13,%eax
     391:	cd 30                	int    $0x30
     393:	c3                   	ret    

00000394 <sleep>:
     394:	b8 14 00 00 00       	mov    $0x14,%eax
     399:	cd 30                	int    $0x30
     39b:	c3                   	ret    

0000039c <upmsec>:
     39c:	b8 15 00 00 00       	mov    $0x15,%eax
     3a1:	cd 30                	int    $0x30
     3a3:	c3                   	ret    

000003a4 <socket>:
     3a4:	b8 16 00 00 00       	mov    $0x16,%eax
     3a9:	cd 30                	int    $0x30
     3ab:	c3                   	ret    

000003ac <bind>:
     3ac:	b8 17 00 00 00       	mov    $0x17,%eax
     3b1:	cd 30                	int    $0x30
     3b3:	c3                   	ret    

000003b4 <listen>:
     3b4:	b8 18 00 00 00       	mov    $0x18,%eax
     3b9:	cd 30                	int    $0x30
     3bb:	c3                   	ret    

000003bc <accept>:
     3bc:	b8 19 00 00 00       	mov    $0x19,%eax
     3c1:	cd 30                	int    $0x30
     3c3:	c3                   	ret    

000003c4 <recv>:
     3c4:	b8 1a 00 00 00       	mov    $0x1a,%eax
     3c9:	cd 30                	int    $0x30
     3cb:	c3                   	ret    

000003cc <recvfrom>:
     3cc:	b8 1b 00 00 00       	mov    $0x1b,%eax
     3d1:	cd 30                	int    $0x30
     3d3:	c3                   	ret    

000003d4 <send>:
     3d4:	b8 1c 00 00 00       	mov    $0x1c,%eax
     3d9:	cd 30                	int    $0x30
     3db:	c3                   	ret    

000003dc <sendto>:
     3dc:	b8 1d 00 00 00       	mov    $0x1d,%eax
     3e1:	cd 30                	int    $0x30
     3e3:	c3                   	ret    

000003e4 <shutdown>:
     3e4:	b8 1e 00 00 00       	mov    $0x1e,%eax
     3e9:	cd 30                	int    $0x30
     3eb:	c3                   	ret    

000003ec <getsockopt>:
     3ec:	b8 1f 00 00 00       	mov    $0x1f,%eax
     3f1:	cd 30                	int    $0x30
     3f3:	c3                   	ret    

000003f4 <setsockopt>:
     3f4:	b8 20 00 00 00       	mov    $0x20,%eax
     3f9:	cd 30                	int    $0x30
     3fb:	c3                   	ret    

000003fc <sockclose>:
     3fc:	b8 21 00 00 00       	mov    $0x21,%eax
     401:	cd 30                	int    $0x30
     403:	c3                   	ret    

00000404 <connect>:
     404:	b8 22 00 00 00       	mov    $0x22,%eax
     409:	cd 30                	int    $0x30
     40b:	c3                   	ret    

0000040c <getpeername>:
     40c:	b8 23 00 00 00       	mov    $0x23,%eax
     411:	cd 30                	int    $0x30
     413:	c3                   	ret    

00000414 <getsockname>:
     414:	b8 24 00 00 00       	mov    $0x24,%eax
     419:	cd 30                	int    $0x30
     41b:	c3                   	ret    
     41c:	90                   	nop    
     41d:	90                   	nop    
     41e:	90                   	nop    
     41f:	90                   	nop    

00000420 <putc>:
#include "user.h"

void
putc(int fd, char c)
{
     420:	55                   	push   %ebp
     421:	89 e5                	mov    %esp,%ebp
     423:	83 ec 18             	sub    $0x18,%esp
     426:	8b 45 0c             	mov    0xc(%ebp),%eax
     429:	88 45 fc             	mov    %al,0xfffffffc(%ebp)
  write(fd, &c, 1);
     42c:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
     433:	00 
     434:	8d 45 fc             	lea    0xfffffffc(%ebp),%eax
     437:	89 44 24 04          	mov    %eax,0x4(%esp)
     43b:	8b 45 08             	mov    0x8(%ebp),%eax
     43e:	89 04 24             	mov    %eax,(%esp)
     441:	e8 de fe ff ff       	call   324 <write>
}
     446:	c9                   	leave  
     447:	c3                   	ret    
     448:	90                   	nop    
     449:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi

00000450 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     450:	55                   	push   %ebp
     451:	89 e5                	mov    %esp,%ebp
     453:	53                   	push   %ebx
     454:	83 ec 34             	sub    $0x34,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     457:	c7 45 f4 00 00 00 00 	movl   $0x0,0xfffffff4(%ebp)
  if(sgn && xx < 0){
     45e:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
     462:	74 17                	je     47b <printint+0x2b>
     464:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     468:	79 11                	jns    47b <printint+0x2b>
    neg = 1;
     46a:	c7 45 f4 01 00 00 00 	movl   $0x1,0xfffffff4(%ebp)
    x = -xx;
     471:	8b 45 0c             	mov    0xc(%ebp),%eax
     474:	f7 d8                	neg    %eax
     476:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
     479:	eb 06                	jmp    481 <printint+0x31>
  } else {
    x = xx;
     47b:	8b 45 0c             	mov    0xc(%ebp),%eax
     47e:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
  }

  i = 0;
     481:	c7 45 f0 00 00 00 00 	movl   $0x0,0xfffffff0(%ebp)
  do{
    buf[i++] = digits[x % base];
     488:	8b 4d f0             	mov    0xfffffff0(%ebp),%ecx
     48b:	8b 55 10             	mov    0x10(%ebp),%edx
     48e:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     491:	89 d3                	mov    %edx,%ebx
     493:	ba 00 00 00 00       	mov    $0x0,%edx
     498:	f7 f3                	div    %ebx
     49a:	89 d0                	mov    %edx,%eax
     49c:	0f b6 80 c4 10 00 00 	movzbl 0x10c4(%eax),%eax
     4a3:	88 44 0d e0          	mov    %al,0xffffffe0(%ebp,%ecx,1)
     4a7:	83 45 f0 01          	addl   $0x1,0xfffffff0(%ebp)
  }while((x /= base) != 0);
     4ab:	8b 55 10             	mov    0x10(%ebp),%edx
     4ae:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     4b1:	89 d1                	mov    %edx,%ecx
     4b3:	ba 00 00 00 00       	mov    $0x0,%edx
     4b8:	f7 f1                	div    %ecx
     4ba:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
     4bd:	83 7d f8 00          	cmpl   $0x0,0xfffffff8(%ebp)
     4c1:	75 c5                	jne    488 <printint+0x38>
  if(neg)
     4c3:	83 7d f4 00          	cmpl   $0x0,0xfffffff4(%ebp)
     4c7:	74 28                	je     4f1 <printint+0xa1>
    buf[i++] = '-';
     4c9:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
     4cc:	c6 44 05 e0 2d       	movb   $0x2d,0xffffffe0(%ebp,%eax,1)
     4d1:	83 45 f0 01          	addl   $0x1,0xfffffff0(%ebp)

  while(--i >= 0)
     4d5:	eb 1a                	jmp    4f1 <printint+0xa1>
    putc(fd, buf[i]);
     4d7:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
     4da:	0f b6 44 05 e0       	movzbl 0xffffffe0(%ebp,%eax,1),%eax
     4df:	0f be c0             	movsbl %al,%eax
     4e2:	89 44 24 04          	mov    %eax,0x4(%esp)
     4e6:	8b 45 08             	mov    0x8(%ebp),%eax
     4e9:	89 04 24             	mov    %eax,(%esp)
     4ec:	e8 2f ff ff ff       	call   420 <putc>
     4f1:	83 6d f0 01          	subl   $0x1,0xfffffff0(%ebp)
     4f5:	83 7d f0 00          	cmpl   $0x0,0xfffffff0(%ebp)
     4f9:	79 dc                	jns    4d7 <printint+0x87>
}
     4fb:	83 c4 34             	add    $0x34,%esp
     4fe:	5b                   	pop    %ebx
     4ff:	5d                   	pop    %ebp
     500:	c3                   	ret    
     501:	eb 0d                	jmp    510 <printf>
     503:	90                   	nop    
     504:	90                   	nop    
     505:	90                   	nop    
     506:	90                   	nop    
     507:	90                   	nop    
     508:	90                   	nop    
     509:	90                   	nop    
     50a:	90                   	nop    
     50b:	90                   	nop    
     50c:	90                   	nop    
     50d:	90                   	nop    
     50e:	90                   	nop    
     50f:	90                   	nop    

00000510 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
     510:	55                   	push   %ebp
     511:	89 e5                	mov    %esp,%ebp
     513:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
     516:	c7 45 f8 00 00 00 00 	movl   $0x0,0xfffffff8(%ebp)
  ap = (uint*)(void*)&fmt + 1;
     51d:	8d 45 0c             	lea    0xc(%ebp),%eax
     520:	83 c0 04             	add    $0x4,%eax
     523:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
  for(i = 0; fmt[i]; i++){
     526:	c7 45 f4 00 00 00 00 	movl   $0x0,0xfffffff4(%ebp)
     52d:	e9 7b 01 00 00       	jmp    6ad <printf+0x19d>
    c = fmt[i] & 0xff;
     532:	8b 55 0c             	mov    0xc(%ebp),%edx
     535:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     538:	8d 04 02             	lea    (%edx,%eax,1),%eax
     53b:	0f b6 00             	movzbl (%eax),%eax
     53e:	0f be c0             	movsbl %al,%eax
     541:	25 ff 00 00 00       	and    $0xff,%eax
     546:	89 45 f0             	mov    %eax,0xfffffff0(%ebp)
    if(state == 0){
     549:	83 7d f8 00          	cmpl   $0x0,0xfffffff8(%ebp)
     54d:	75 2c                	jne    57b <printf+0x6b>
      if(c == '%'){
     54f:	83 7d f0 25          	cmpl   $0x25,0xfffffff0(%ebp)
     553:	75 0c                	jne    561 <printf+0x51>
        state = '%';
     555:	c7 45 f8 25 00 00 00 	movl   $0x25,0xfffffff8(%ebp)
     55c:	e9 48 01 00 00       	jmp    6a9 <printf+0x199>
      } else {
        putc(fd, c);
     561:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
     564:	0f be c0             	movsbl %al,%eax
     567:	89 44 24 04          	mov    %eax,0x4(%esp)
     56b:	8b 45 08             	mov    0x8(%ebp),%eax
     56e:	89 04 24             	mov    %eax,(%esp)
     571:	e8 aa fe ff ff       	call   420 <putc>
     576:	e9 2e 01 00 00       	jmp    6a9 <printf+0x199>
      }
    } else if(state == '%'){
     57b:	83 7d f8 25          	cmpl   $0x25,0xfffffff8(%ebp)
     57f:	0f 85 24 01 00 00    	jne    6a9 <printf+0x199>
      if(c == 'd'){
     585:	83 7d f0 64          	cmpl   $0x64,0xfffffff0(%ebp)
     589:	75 2d                	jne    5b8 <printf+0xa8>
        printint(fd, *ap, 10, 1);
     58b:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     58e:	8b 00                	mov    (%eax),%eax
     590:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
     597:	00 
     598:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
     59f:	00 
     5a0:	89 44 24 04          	mov    %eax,0x4(%esp)
     5a4:	8b 45 08             	mov    0x8(%ebp),%eax
     5a7:	89 04 24             	mov    %eax,(%esp)
     5aa:	e8 a1 fe ff ff       	call   450 <printint>
        ap++;
     5af:	83 45 fc 04          	addl   $0x4,0xfffffffc(%ebp)
     5b3:	e9 ea 00 00 00       	jmp    6a2 <printf+0x192>
      } else if(c == 'x' || c == 'p'){
     5b8:	83 7d f0 78          	cmpl   $0x78,0xfffffff0(%ebp)
     5bc:	74 06                	je     5c4 <printf+0xb4>
     5be:	83 7d f0 70          	cmpl   $0x70,0xfffffff0(%ebp)
     5c2:	75 2d                	jne    5f1 <printf+0xe1>
        printint(fd, *ap, 16, 0);
     5c4:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     5c7:	8b 00                	mov    (%eax),%eax
     5c9:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
     5d0:	00 
     5d1:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
     5d8:	00 
     5d9:	89 44 24 04          	mov    %eax,0x4(%esp)
     5dd:	8b 45 08             	mov    0x8(%ebp),%eax
     5e0:	89 04 24             	mov    %eax,(%esp)
     5e3:	e8 68 fe ff ff       	call   450 <printint>
        ap++;
     5e8:	83 45 fc 04          	addl   $0x4,0xfffffffc(%ebp)
     5ec:	e9 b1 00 00 00       	jmp    6a2 <printf+0x192>
      } else if(c == 's'){
     5f1:	83 7d f0 73          	cmpl   $0x73,0xfffffff0(%ebp)
     5f5:	75 43                	jne    63a <printf+0x12a>
        s = (char*)*ap;
     5f7:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     5fa:	8b 00                	mov    (%eax),%eax
     5fc:	89 45 ec             	mov    %eax,0xffffffec(%ebp)
        ap++;
     5ff:	83 45 fc 04          	addl   $0x4,0xfffffffc(%ebp)
        if(s == 0)
     603:	83 7d ec 00          	cmpl   $0x0,0xffffffec(%ebp)
     607:	75 25                	jne    62e <printf+0x11e>
          s = "(null)";
     609:	c7 45 ec a8 10 00 00 	movl   $0x10a8,0xffffffec(%ebp)
        while(*s != 0){
     610:	eb 1c                	jmp    62e <printf+0x11e>
          putc(fd, *s);
     612:	8b 45 ec             	mov    0xffffffec(%ebp),%eax
     615:	0f b6 00             	movzbl (%eax),%eax
     618:	0f be c0             	movsbl %al,%eax
     61b:	89 44 24 04          	mov    %eax,0x4(%esp)
     61f:	8b 45 08             	mov    0x8(%ebp),%eax
     622:	89 04 24             	mov    %eax,(%esp)
     625:	e8 f6 fd ff ff       	call   420 <putc>
          s++;
     62a:	83 45 ec 01          	addl   $0x1,0xffffffec(%ebp)
     62e:	8b 45 ec             	mov    0xffffffec(%ebp),%eax
     631:	0f b6 00             	movzbl (%eax),%eax
     634:	84 c0                	test   %al,%al
     636:	75 da                	jne    612 <printf+0x102>
     638:	eb 68                	jmp    6a2 <printf+0x192>
        }
      } else if(c == 'c'){
     63a:	83 7d f0 63          	cmpl   $0x63,0xfffffff0(%ebp)
     63e:	75 1d                	jne    65d <printf+0x14d>
        putc(fd, *ap);
     640:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     643:	8b 00                	mov    (%eax),%eax
     645:	0f be c0             	movsbl %al,%eax
     648:	89 44 24 04          	mov    %eax,0x4(%esp)
     64c:	8b 45 08             	mov    0x8(%ebp),%eax
     64f:	89 04 24             	mov    %eax,(%esp)
     652:	e8 c9 fd ff ff       	call   420 <putc>
        ap++;
     657:	83 45 fc 04          	addl   $0x4,0xfffffffc(%ebp)
     65b:	eb 45                	jmp    6a2 <printf+0x192>
      } else if(c == '%'){
     65d:	83 7d f0 25          	cmpl   $0x25,0xfffffff0(%ebp)
     661:	75 17                	jne    67a <printf+0x16a>
        putc(fd, c);
     663:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
     666:	0f be c0             	movsbl %al,%eax
     669:	89 44 24 04          	mov    %eax,0x4(%esp)
     66d:	8b 45 08             	mov    0x8(%ebp),%eax
     670:	89 04 24             	mov    %eax,(%esp)
     673:	e8 a8 fd ff ff       	call   420 <putc>
     678:	eb 28                	jmp    6a2 <printf+0x192>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     67a:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
     681:	00 
     682:	8b 45 08             	mov    0x8(%ebp),%eax
     685:	89 04 24             	mov    %eax,(%esp)
     688:	e8 93 fd ff ff       	call   420 <putc>
        putc(fd, c);
     68d:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
     690:	0f be c0             	movsbl %al,%eax
     693:	89 44 24 04          	mov    %eax,0x4(%esp)
     697:	8b 45 08             	mov    0x8(%ebp),%eax
     69a:	89 04 24             	mov    %eax,(%esp)
     69d:	e8 7e fd ff ff       	call   420 <putc>
      }
      state = 0;
     6a2:	c7 45 f8 00 00 00 00 	movl   $0x0,0xfffffff8(%ebp)
     6a9:	83 45 f4 01          	addl   $0x1,0xfffffff4(%ebp)
     6ad:	8b 55 0c             	mov    0xc(%ebp),%edx
     6b0:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     6b3:	8d 04 02             	lea    (%edx,%eax,1),%eax
     6b6:	0f b6 00             	movzbl (%eax),%eax
     6b9:	84 c0                	test   %al,%al
     6bb:	0f 85 71 fe ff ff    	jne    532 <printf+0x22>
    }
  }
}
     6c1:	c9                   	leave  
     6c2:	c3                   	ret    
     6c3:	90                   	nop    
     6c4:	90                   	nop    
     6c5:	90                   	nop    
     6c6:	90                   	nop    
     6c7:	90                   	nop    
     6c8:	90                   	nop    
     6c9:	90                   	nop    
     6ca:	90                   	nop    
     6cb:	90                   	nop    
     6cc:	90                   	nop    
     6cd:	90                   	nop    
     6ce:	90                   	nop    
     6cf:	90                   	nop    

000006d0 <free>:
static Header *freep;

void
free(void *ap)
{
     6d0:	55                   	push   %ebp
     6d1:	89 e5                	mov    %esp,%ebp
     6d3:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*) ap - 1;
     6d6:	8b 45 08             	mov    0x8(%ebp),%eax
     6d9:	83 e8 08             	sub    $0x8,%eax
     6dc:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     6df:	a1 e0 10 00 00       	mov    0x10e0,%eax
     6e4:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
     6e7:	eb 24                	jmp    70d <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     6e9:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     6ec:	8b 00                	mov    (%eax),%eax
     6ee:	3b 45 fc             	cmp    0xfffffffc(%ebp),%eax
     6f1:	77 12                	ja     705 <free+0x35>
     6f3:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     6f6:	3b 45 fc             	cmp    0xfffffffc(%ebp),%eax
     6f9:	77 24                	ja     71f <free+0x4f>
     6fb:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     6fe:	8b 00                	mov    (%eax),%eax
     700:	3b 45 f8             	cmp    0xfffffff8(%ebp),%eax
     703:	77 1a                	ja     71f <free+0x4f>
     705:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     708:	8b 00                	mov    (%eax),%eax
     70a:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
     70d:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     710:	3b 45 fc             	cmp    0xfffffffc(%ebp),%eax
     713:	76 d4                	jbe    6e9 <free+0x19>
     715:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     718:	8b 00                	mov    (%eax),%eax
     71a:	3b 45 f8             	cmp    0xfffffff8(%ebp),%eax
     71d:	76 ca                	jbe    6e9 <free+0x19>
      break;
  if(bp + bp->s.size == p->s.ptr){
     71f:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     722:	8b 40 04             	mov    0x4(%eax),%eax
     725:	c1 e0 03             	shl    $0x3,%eax
     728:	89 c2                	mov    %eax,%edx
     72a:	03 55 f8             	add    0xfffffff8(%ebp),%edx
     72d:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     730:	8b 00                	mov    (%eax),%eax
     732:	39 c2                	cmp    %eax,%edx
     734:	75 24                	jne    75a <free+0x8a>
    bp->s.size += p->s.ptr->s.size;
     736:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     739:	8b 50 04             	mov    0x4(%eax),%edx
     73c:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     73f:	8b 00                	mov    (%eax),%eax
     741:	8b 40 04             	mov    0x4(%eax),%eax
     744:	01 c2                	add    %eax,%edx
     746:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     749:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
     74c:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     74f:	8b 00                	mov    (%eax),%eax
     751:	8b 10                	mov    (%eax),%edx
     753:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     756:	89 10                	mov    %edx,(%eax)
     758:	eb 0a                	jmp    764 <free+0x94>
  } else
    bp->s.ptr = p->s.ptr;
     75a:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     75d:	8b 10                	mov    (%eax),%edx
     75f:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     762:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
     764:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     767:	8b 40 04             	mov    0x4(%eax),%eax
     76a:	c1 e0 03             	shl    $0x3,%eax
     76d:	03 45 fc             	add    0xfffffffc(%ebp),%eax
     770:	3b 45 f8             	cmp    0xfffffff8(%ebp),%eax
     773:	75 20                	jne    795 <free+0xc5>
    p->s.size += bp->s.size;
     775:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     778:	8b 50 04             	mov    0x4(%eax),%edx
     77b:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     77e:	8b 40 04             	mov    0x4(%eax),%eax
     781:	01 c2                	add    %eax,%edx
     783:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     786:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
     789:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     78c:	8b 10                	mov    (%eax),%edx
     78e:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     791:	89 10                	mov    %edx,(%eax)
     793:	eb 08                	jmp    79d <free+0xcd>
  } else
    p->s.ptr = bp;
     795:	8b 55 fc             	mov    0xfffffffc(%ebp),%edx
     798:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     79b:	89 02                	mov    %eax,(%edx)
  freep = p;
     79d:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     7a0:	a3 e0 10 00 00       	mov    %eax,0x10e0
}
     7a5:	c9                   	leave  
     7a6:	c3                   	ret    
     7a7:	89 f6                	mov    %esi,%esi
     7a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

000007b0 <morecore>:

static Header*
morecore(uint nu)
{
     7b0:	55                   	push   %ebp
     7b1:	89 e5                	mov    %esp,%ebp
     7b3:	83 ec 18             	sub    $0x18,%esp
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
     7b6:	8b 45 08             	mov    0x8(%ebp),%eax
     7b9:	c1 e0 03             	shl    $0x3,%eax
     7bc:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
  size += PAGE - size % PAGE;
     7bf:	8b 55 fc             	mov    0xfffffffc(%ebp),%edx
     7c2:	89 d0                	mov    %edx,%eax
     7c4:	c1 f8 1f             	sar    $0x1f,%eax
     7c7:	89 c1                	mov    %eax,%ecx
     7c9:	c1 e9 14             	shr    $0x14,%ecx
     7cc:	8d 04 0a             	lea    (%edx,%ecx,1),%eax
     7cf:	25 ff 0f 00 00       	and    $0xfff,%eax
     7d4:	29 c8                	sub    %ecx,%eax
     7d6:	89 c2                	mov    %eax,%edx
     7d8:	b8 00 10 00 00       	mov    $0x1000,%eax
     7dd:	29 d0                	sub    %edx,%eax
     7df:	01 45 fc             	add    %eax,0xfffffffc(%ebp)
#endif
#ifdef UMALLOC_DEBUG
  printf(1, "size: %d\n", size);
#endif
  p = sbrk(size);
     7e2:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     7e5:	89 04 24             	mov    %eax,(%esp)
     7e8:	e8 9f fb ff ff       	call   38c <sbrk>
     7ed:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
  if(p == (char*) -1)
     7f0:	83 7d f4 ff          	cmpl   $0xffffffff,0xfffffff4(%ebp)
     7f4:	75 09                	jne    7ff <morecore+0x4f>
    return 0;
     7f6:	c7 45 ec 00 00 00 00 	movl   $0x0,0xffffffec(%ebp)
     7fd:	eb 2a                	jmp    829 <morecore+0x79>
  hp = (Header*)p;
     7ff:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     802:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
#ifdef UMALLOC_NOALIGN
  hp->s.size = nu;
#else
  hp->s.size = size / sizeof(Header);
     805:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     808:	89 c2                	mov    %eax,%edx
     80a:	c1 ea 03             	shr    $0x3,%edx
     80d:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     810:	89 50 04             	mov    %edx,0x4(%eax)
#endif
  free((void*)(hp + 1));
     813:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     816:	83 c0 08             	add    $0x8,%eax
     819:	89 04 24             	mov    %eax,(%esp)
     81c:	e8 af fe ff ff       	call   6d0 <free>
  return freep;
     821:	a1 e0 10 00 00       	mov    0x10e0,%eax
     826:	89 45 ec             	mov    %eax,0xffffffec(%ebp)
     829:	8b 45 ec             	mov    0xffffffec(%ebp),%eax
}
     82c:	c9                   	leave  
     82d:	c3                   	ret    
     82e:	89 f6                	mov    %esi,%esi

00000830 <malloc>:

void*
malloc(uint nbytes)
{
     830:	55                   	push   %ebp
     831:	89 e5                	mov    %esp,%ebp
     833:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

#ifdef UMALLOC_DEBUG
  printf(1, "malloc: %d bytes\n", nbytes);
  printf(1, "size of Header: %d\n", sizeof(Header));
#endif
  if (PAGE % sizeof(Header))
      printf(2, "Warning! align failed! Need UMALLOC_NOALIGN\n");
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     836:	8b 45 08             	mov    0x8(%ebp),%eax
     839:	83 c0 07             	add    $0x7,%eax
     83c:	c1 e8 03             	shr    $0x3,%eax
     83f:	83 c0 01             	add    $0x1,%eax
     842:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
  if((prevp = freep) == 0){
     845:	a1 e0 10 00 00       	mov    0x10e0,%eax
     84a:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
     84d:	83 7d f8 00          	cmpl   $0x0,0xfffffff8(%ebp)
     851:	75 23                	jne    876 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
     853:	c7 45 f8 d8 10 00 00 	movl   $0x10d8,0xfffffff8(%ebp)
     85a:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     85d:	a3 e0 10 00 00       	mov    %eax,0x10e0
     862:	a1 e0 10 00 00       	mov    0x10e0,%eax
     867:	a3 d8 10 00 00       	mov    %eax,0x10d8
    base.s.size = 0;
     86c:	c7 05 dc 10 00 00 00 	movl   $0x0,0x10dc
     873:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     876:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     879:	8b 00                	mov    (%eax),%eax
     87b:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
    if(p->s.size >= nunits){
     87e:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     881:	8b 40 04             	mov    0x4(%eax),%eax
     884:	3b 45 fc             	cmp    0xfffffffc(%ebp),%eax
     887:	72 50                	jb     8d9 <malloc+0xa9>
      if(p->s.size == nunits)
     889:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     88c:	8b 40 04             	mov    0x4(%eax),%eax
     88f:	3b 45 fc             	cmp    0xfffffffc(%ebp),%eax
     892:	75 0c                	jne    8a0 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
     894:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     897:	8b 10                	mov    (%eax),%edx
     899:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     89c:	89 10                	mov    %edx,(%eax)
     89e:	eb 26                	jmp    8c6 <malloc+0x96>
      else {
        p->s.size -= nunits;
     8a0:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     8a3:	8b 40 04             	mov    0x4(%eax),%eax
     8a6:	89 c2                	mov    %eax,%edx
     8a8:	2b 55 fc             	sub    0xfffffffc(%ebp),%edx
     8ab:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     8ae:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
     8b1:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     8b4:	8b 40 04             	mov    0x4(%eax),%eax
     8b7:	c1 e0 03             	shl    $0x3,%eax
     8ba:	01 45 f4             	add    %eax,0xfffffff4(%ebp)
        p->s.size = nunits;
     8bd:	8b 55 f4             	mov    0xfffffff4(%ebp),%edx
     8c0:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     8c3:	89 42 04             	mov    %eax,0x4(%edx)
      }
      freep = prevp;
     8c6:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     8c9:	a3 e0 10 00 00       	mov    %eax,0x10e0
      return (void*) (p + 1);
     8ce:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     8d1:	83 c0 08             	add    $0x8,%eax
     8d4:	89 45 ec             	mov    %eax,0xffffffec(%ebp)
     8d7:	eb 3a                	jmp    913 <malloc+0xe3>
    }
    if(p == freep)
     8d9:	a1 e0 10 00 00       	mov    0x10e0,%eax
     8de:	39 45 f4             	cmp    %eax,0xfffffff4(%ebp)
     8e1:	75 1d                	jne    900 <malloc+0xd0>
      if((p = morecore(nunits)) == 0)
     8e3:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     8e6:	89 04 24             	mov    %eax,(%esp)
     8e9:	e8 c2 fe ff ff       	call   7b0 <morecore>
     8ee:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
     8f1:	83 7d f4 00          	cmpl   $0x0,0xfffffff4(%ebp)
     8f5:	75 09                	jne    900 <malloc+0xd0>
        return 0;
     8f7:	c7 45 ec 00 00 00 00 	movl   $0x0,0xffffffec(%ebp)
     8fe:	eb 13                	jmp    913 <malloc+0xe3>
     900:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     903:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
     906:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     909:	8b 00                	mov    (%eax),%eax
     90b:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
  }
     90e:	e9 6b ff ff ff       	jmp    87e <malloc+0x4e>
     913:	8b 45 ec             	mov    0xffffffec(%ebp),%eax
}
     916:	c9                   	leave  
     917:	c3                   	ret    
     918:	90                   	nop    
     919:	90                   	nop    
     91a:	90                   	nop    
     91b:	90                   	nop    
     91c:	90                   	nop    
     91d:	90                   	nop    
     91e:	90                   	nop    
     91f:	90                   	nop    

00000920 <lwip_chksum>:


static u16_t
lwip_chksum(void *dataptr, int len)
{
     920:	55                   	push   %ebp
     921:	89 e5                	mov    %esp,%ebp
     923:	83 ec 18             	sub    $0x18,%esp
  u32_t acc;

  LWIP_DEBUGF(INET_DEBUG, ("lwip_chksum(%p, %d)\n", (void *)dataptr, len));
  for(acc = 0; len > 1; len -= 2) {
     926:	c7 45 fc 00 00 00 00 	movl   $0x0,0xfffffffc(%ebp)
     92d:	eb 19                	jmp    948 <lwip_chksum+0x28>
      /*    acc = acc + *((u16_t *)dataptr)++;*/
    acc += *(u16_t *)dataptr;
     92f:	8b 45 08             	mov    0x8(%ebp),%eax
     932:	0f b7 00             	movzwl (%eax),%eax
     935:	0f b7 c0             	movzwl %ax,%eax
     938:	01 45 fc             	add    %eax,0xfffffffc(%ebp)
    dataptr = (void *)((u16_t *)dataptr + 1);
     93b:	8b 45 08             	mov    0x8(%ebp),%eax
     93e:	83 c0 02             	add    $0x2,%eax
     941:	89 45 08             	mov    %eax,0x8(%ebp)
     944:	83 6d 0c 02          	subl   $0x2,0xc(%ebp)
     948:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
     94c:	7f e1                	jg     92f <lwip_chksum+0xf>
  }

  /* add up any odd byte */
  if (len == 1) {
     94e:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
     952:	75 1d                	jne    971 <lwip_chksum+0x51>
    acc += htons((u16_t)((*(u8_t *)dataptr) & 0xff) << 8);
     954:	8b 45 08             	mov    0x8(%ebp),%eax
     957:	0f b6 00             	movzbl (%eax),%eax
     95a:	0f b6 c0             	movzbl %al,%eax
     95d:	c1 e0 08             	shl    $0x8,%eax
     960:	0f b7 c0             	movzwl %ax,%eax
     963:	89 04 24             	mov    %eax,(%esp)
     966:	e8 85 06 00 00       	call   ff0 <htons>
     96b:	0f b7 c0             	movzwl %ax,%eax
     96e:	01 45 fc             	add    %eax,0xfffffffc(%ebp)
    LWIP_DEBUGF(INET_DEBUG, ("inet: chksum: odd byte %d\n", (unsigned int)(*(u8_t *)dataptr)));
  } else {
    LWIP_DEBUGF(INET_DEBUG, ("inet: chksum: no odd byte\n"));
  }
  acc = (acc >> 16) + (acc & 0xffffUL);
     971:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     974:	89 c2                	mov    %eax,%edx
     976:	c1 ea 10             	shr    $0x10,%edx
     979:	0f b7 45 fc          	movzwl 0xfffffffc(%ebp),%eax
     97d:	8d 04 02             	lea    (%edx,%eax,1),%eax
     980:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)

  if ((acc & 0xffff0000) != 0) {
     983:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     986:	66 b8 00 00          	mov    $0x0,%ax
     98a:	85 c0                	test   %eax,%eax
     98c:	74 12                	je     9a0 <lwip_chksum+0x80>
    acc = (acc >> 16) + (acc & 0xffffUL);
     98e:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     991:	89 c2                	mov    %eax,%edx
     993:	c1 ea 10             	shr    $0x10,%edx
     996:	0f b7 45 fc          	movzwl 0xfffffffc(%ebp),%eax
     99a:	8d 04 02             	lea    (%edx,%eax,1),%eax
     99d:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
  }

  return (u16_t)acc;
     9a0:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     9a3:	0f b7 c0             	movzwl %ax,%eax
}
     9a6:	c9                   	leave  
     9a7:	c3                   	ret    
     9a8:	90                   	nop    
     9a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi

000009b0 <inet_chksum_pseudo>:

/* inet_chksum_pseudo:
 *
 * Calculates the pseudo Internet checksum used by TCP and UDP for a pbuf chain.
 */

u16_t
inet_chksum_pseudo(struct pbuf *p,
       struct ip_addr *src, struct ip_addr *dest,
       u8_t proto, u16_t proto_len)
{
     9b0:	55                   	push   %ebp
     9b1:	89 e5                	mov    %esp,%ebp
     9b3:	83 ec 28             	sub    $0x28,%esp
     9b6:	8b 45 14             	mov    0x14(%ebp),%eax
     9b9:	8b 55 18             	mov    0x18(%ebp),%edx
     9bc:	88 45 ec             	mov    %al,0xffffffec(%ebp)
     9bf:	66 89 55 e8          	mov    %dx,0xffffffe8(%ebp)
  u32_t acc;
  struct pbuf *q;
  u8_t swapped;

  acc = 0;
     9c3:	c7 45 f4 00 00 00 00 	movl   $0x0,0xfffffff4(%ebp)
  swapped = 0;
     9ca:	c6 45 ff 00          	movb   $0x0,0xffffffff(%ebp)
  /* iterate through all pbuf in chain */
  for(q = p; q != NULL; q = q->next) {
     9ce:	8b 45 08             	mov    0x8(%ebp),%eax
     9d1:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
     9d4:	eb 7b                	jmp    a51 <inet_chksum_pseudo+0xa1>
    LWIP_DEBUGF(INET_DEBUG, ("inet_chksum_pseudo(): checksumming pbuf %p (has next %p) \n",
      (void *)q, (void *)q->next));
    acc += lwip_chksum(q->payload, q->len);
     9d6:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     9d9:	0f b7 40 0a          	movzwl 0xa(%eax),%eax
     9dd:	0f b7 d0             	movzwl %ax,%edx
     9e0:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     9e3:	8b 40 04             	mov    0x4(%eax),%eax
     9e6:	89 54 24 04          	mov    %edx,0x4(%esp)
     9ea:	89 04 24             	mov    %eax,(%esp)
     9ed:	e8 2e ff ff ff       	call   920 <lwip_chksum>
     9f2:	0f b7 c0             	movzwl %ax,%eax
     9f5:	01 45 f4             	add    %eax,0xfffffff4(%ebp)
    /*LWIP_DEBUGF(INET_DEBUG, ("inet_chksum_pseudo(): unwrapped lwip_chksum()=%lx \n", acc));*/
    while (acc >> 16) {
     9f8:	eb 10                	jmp    a0a <inet_chksum_pseudo+0x5a>
      acc = (acc & 0xffffUL) + (acc >> 16);
     9fa:	0f b7 55 f4          	movzwl 0xfffffff4(%ebp),%edx
     9fe:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     a01:	c1 e8 10             	shr    $0x10,%eax
     a04:	8d 04 02             	lea    (%edx,%eax,1),%eax
     a07:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
     a0a:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     a0d:	c1 e8 10             	shr    $0x10,%eax
     a10:	85 c0                	test   %eax,%eax
     a12:	75 e6                	jne    9fa <inet_chksum_pseudo+0x4a>
    }
    if (q->len % 2 != 0) {
     a14:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     a17:	0f b7 40 0a          	movzwl 0xa(%eax),%eax
     a1b:	0f b7 c0             	movzwl %ax,%eax
     a1e:	83 e0 01             	and    $0x1,%eax
     a21:	84 c0                	test   %al,%al
     a23:	74 24                	je     a49 <inet_chksum_pseudo+0x99>
      swapped = 1 - swapped;
     a25:	b8 01 00 00 00       	mov    $0x1,%eax
     a2a:	2a 45 ff             	sub    0xffffffff(%ebp),%al
     a2d:	88 45 ff             	mov    %al,0xffffffff(%ebp)
      acc = ((acc & 0xff) << 8) | ((acc & 0xff00UL) >> 8);
     a30:	0f b6 45 f4          	movzbl 0xfffffff4(%ebp),%eax
     a34:	89 c2                	mov    %eax,%edx
     a36:	c1 e2 08             	shl    $0x8,%edx
     a39:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     a3c:	25 00 ff 00 00       	and    $0xff00,%eax
     a41:	c1 e8 08             	shr    $0x8,%eax
     a44:	09 d0                	or     %edx,%eax
     a46:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
     a49:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     a4c:	8b 00                	mov    (%eax),%eax
     a4e:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
     a51:	83 7d f8 00          	cmpl   $0x0,0xfffffff8(%ebp)
     a55:	0f 85 7b ff ff ff    	jne    9d6 <inet_chksum_pseudo+0x26>
    }
    /*LWIP_DEBUGF(INET_DEBUG, ("inet_chksum_pseudo(): wrapped lwip_chksum()=%lx \n", acc));*/
  }

  if (swapped) {
     a5b:	80 7d ff 00          	cmpb   $0x0,0xffffffff(%ebp)
     a5f:	74 19                	je     a7a <inet_chksum_pseudo+0xca>
    acc = ((acc & 0xff) << 8) | ((acc & 0xff00UL) >> 8);
     a61:	0f b6 45 f4          	movzbl 0xfffffff4(%ebp),%eax
     a65:	89 c2                	mov    %eax,%edx
     a67:	c1 e2 08             	shl    $0x8,%edx
     a6a:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     a6d:	25 00 ff 00 00       	and    $0xff00,%eax
     a72:	c1 e8 08             	shr    $0x8,%eax
     a75:	09 d0                	or     %edx,%eax
     a77:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
  }
  acc += (src->addr & 0xffffUL);
     a7a:	8b 45 0c             	mov    0xc(%ebp),%eax
     a7d:	8b 00                	mov    (%eax),%eax
     a7f:	25 ff ff 00 00       	and    $0xffff,%eax
     a84:	01 45 f4             	add    %eax,0xfffffff4(%ebp)
  acc += ((src->addr >> 16) & 0xffffUL);
     a87:	8b 45 0c             	mov    0xc(%ebp),%eax
     a8a:	8b 00                	mov    (%eax),%eax
     a8c:	c1 e8 10             	shr    $0x10,%eax
     a8f:	25 ff ff 00 00       	and    $0xffff,%eax
     a94:	01 45 f4             	add    %eax,0xfffffff4(%ebp)
  acc += (dest->addr & 0xffffUL);
     a97:	8b 45 10             	mov    0x10(%ebp),%eax
     a9a:	8b 00                	mov    (%eax),%eax
     a9c:	25 ff ff 00 00       	and    $0xffff,%eax
     aa1:	01 45 f4             	add    %eax,0xfffffff4(%ebp)
  acc += ((dest->addr >> 16) & 0xffffUL);
     aa4:	8b 45 10             	mov    0x10(%ebp),%eax
     aa7:	8b 00                	mov    (%eax),%eax
     aa9:	c1 e8 10             	shr    $0x10,%eax
     aac:	25 ff ff 00 00       	and    $0xffff,%eax
     ab1:	01 45 f4             	add    %eax,0xfffffff4(%ebp)
  acc += (u32_t)htons((u16_t)proto);
     ab4:	0f b6 45 ec          	movzbl 0xffffffec(%ebp),%eax
     ab8:	89 04 24             	mov    %eax,(%esp)
     abb:	e8 30 05 00 00       	call   ff0 <htons>
     ac0:	0f b7 c0             	movzwl %ax,%eax
     ac3:	01 45 f4             	add    %eax,0xfffffff4(%ebp)
  acc += (u32_t)htons(proto_len);
     ac6:	0f b7 45 e8          	movzwl 0xffffffe8(%ebp),%eax
     aca:	89 04 24             	mov    %eax,(%esp)
     acd:	e8 1e 05 00 00       	call   ff0 <htons>
     ad2:	0f b7 c0             	movzwl %ax,%eax
     ad5:	01 45 f4             	add    %eax,0xfffffff4(%ebp)

  while (acc >> 16) {
     ad8:	eb 10                	jmp    aea <inet_chksum_pseudo+0x13a>
    acc = (acc & 0xffffUL) + (acc >> 16);
     ada:	0f b7 55 f4          	movzwl 0xfffffff4(%ebp),%edx
     ade:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     ae1:	c1 e8 10             	shr    $0x10,%eax
     ae4:	8d 04 02             	lea    (%edx,%eax,1),%eax
     ae7:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
     aea:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     aed:	c1 e8 10             	shr    $0x10,%eax
     af0:	85 c0                	test   %eax,%eax
     af2:	75 e6                	jne    ada <inet_chksum_pseudo+0x12a>
  }
  LWIP_DEBUGF(INET_DEBUG, ("inet_chksum_pseudo(): pbuf chain lwip_chksum()=%lx\n", acc));
  return ~(acc & 0xffffUL);
     af4:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     af7:	f7 d0                	not    %eax
     af9:	0f b7 c0             	movzwl %ax,%eax
}
     afc:	c9                   	leave  
     afd:	c3                   	ret    
     afe:	89 f6                	mov    %esi,%esi

00000b00 <inet_chksum>:

/* inet_chksum:
 *
 * Calculates the Internet checksum over a portion of memory. Used primarely for IP
 * and ICMP.
 */

u16_t
inet_chksum(void *dataptr, u16_t len)
{
     b00:	55                   	push   %ebp
     b01:	89 e5                	mov    %esp,%ebp
     b03:	83 ec 28             	sub    $0x28,%esp
     b06:	8b 45 0c             	mov    0xc(%ebp),%eax
     b09:	66 89 45 ec          	mov    %ax,0xffffffec(%ebp)
  u32_t acc;

  acc = lwip_chksum(dataptr, len);
     b0d:	0f b7 45 ec          	movzwl 0xffffffec(%ebp),%eax
     b11:	89 44 24 04          	mov    %eax,0x4(%esp)
     b15:	8b 45 08             	mov    0x8(%ebp),%eax
     b18:	89 04 24             	mov    %eax,(%esp)
     b1b:	e8 00 fe ff ff       	call   920 <lwip_chksum>
     b20:	0f b7 c0             	movzwl %ax,%eax
     b23:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
  while (acc >> 16) {
     b26:	eb 10                	jmp    b38 <inet_chksum+0x38>
    acc = (acc & 0xffff) + (acc >> 16);
     b28:	0f b7 55 fc          	movzwl 0xfffffffc(%ebp),%edx
     b2c:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     b2f:	c1 e8 10             	shr    $0x10,%eax
     b32:	8d 04 02             	lea    (%edx,%eax,1),%eax
     b35:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
     b38:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     b3b:	c1 e8 10             	shr    $0x10,%eax
     b3e:	85 c0                	test   %eax,%eax
     b40:	75 e6                	jne    b28 <inet_chksum+0x28>
  }
  return ~(acc & 0xffff);
     b42:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     b45:	f7 d0                	not    %eax
     b47:	0f b7 c0             	movzwl %ax,%eax
}
     b4a:	c9                   	leave  
     b4b:	c3                   	ret    
     b4c:	8d 74 26 00          	lea    0x0(%esi),%esi

00000b50 <inet_chksum_pbuf>:

u16_t
inet_chksum_pbuf(struct pbuf *p)
{
     b50:	55                   	push   %ebp
     b51:	89 e5                	mov    %esp,%ebp
     b53:	83 ec 18             	sub    $0x18,%esp
  u32_t acc;
  struct pbuf *q;
  u8_t swapped;

  acc = 0;
     b56:	c7 45 f4 00 00 00 00 	movl   $0x0,0xfffffff4(%ebp)
  swapped = 0;
     b5d:	c6 45 ff 00          	movb   $0x0,0xffffffff(%ebp)
  for(q = p; q != NULL; q = q->next) {
     b61:	8b 45 08             	mov    0x8(%ebp),%eax
     b64:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
     b67:	eb 69                	jmp    bd2 <inet_chksum_pbuf+0x82>
    acc += lwip_chksum(q->payload, q->len);
     b69:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     b6c:	0f b7 40 0a          	movzwl 0xa(%eax),%eax
     b70:	0f b7 d0             	movzwl %ax,%edx
     b73:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     b76:	8b 40 04             	mov    0x4(%eax),%eax
     b79:	89 54 24 04          	mov    %edx,0x4(%esp)
     b7d:	89 04 24             	mov    %eax,(%esp)
     b80:	e8 9b fd ff ff       	call   920 <lwip_chksum>
     b85:	0f b7 c0             	movzwl %ax,%eax
     b88:	01 45 f4             	add    %eax,0xfffffff4(%ebp)
    while (acc >> 16) {
     b8b:	eb 10                	jmp    b9d <inet_chksum_pbuf+0x4d>
      acc = (acc & 0xffffUL) + (acc >> 16);
     b8d:	0f b7 55 f4          	movzwl 0xfffffff4(%ebp),%edx
     b91:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     b94:	c1 e8 10             	shr    $0x10,%eax
     b97:	8d 04 02             	lea    (%edx,%eax,1),%eax
     b9a:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
     b9d:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     ba0:	c1 e8 10             	shr    $0x10,%eax
     ba3:	85 c0                	test   %eax,%eax
     ba5:	75 e6                	jne    b8d <inet_chksum_pbuf+0x3d>
    }
    if (q->len % 2 != 0) {
     ba7:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     baa:	0f b7 40 0a          	movzwl 0xa(%eax),%eax
     bae:	0f b7 c0             	movzwl %ax,%eax
     bb1:	83 e0 01             	and    $0x1,%eax
     bb4:	84 c0                	test   %al,%al
     bb6:	74 12                	je     bca <inet_chksum_pbuf+0x7a>
      swapped = 1 - swapped;
     bb8:	b8 01 00 00 00       	mov    $0x1,%eax
     bbd:	2a 45 ff             	sub    0xffffffff(%ebp),%al
     bc0:	88 45 ff             	mov    %al,0xffffffff(%ebp)
      acc = (acc & 0x00ffUL << 8) | (acc & 0xff00UL >> 8);
     bc3:	81 65 f4 ff ff 00 00 	andl   $0xffff,0xfffffff4(%ebp)
     bca:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     bcd:	8b 00                	mov    (%eax),%eax
     bcf:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
     bd2:	83 7d f8 00          	cmpl   $0x0,0xfffffff8(%ebp)
     bd6:	75 91                	jne    b69 <inet_chksum_pbuf+0x19>
    }
  }

  if (swapped) {
     bd8:	80 7d ff 00          	cmpb   $0x0,0xffffffff(%ebp)
     bdc:	74 19                	je     bf7 <inet_chksum_pbuf+0xa7>
    acc = ((acc & 0x00ffUL) << 8) | ((acc & 0xff00UL) >> 8);
     bde:	0f b6 45 f4          	movzbl 0xfffffff4(%ebp),%eax
     be2:	89 c2                	mov    %eax,%edx
     be4:	c1 e2 08             	shl    $0x8,%edx
     be7:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     bea:	25 00 ff 00 00       	and    $0xff00,%eax
     bef:	c1 e8 08             	shr    $0x8,%eax
     bf2:	09 d0                	or     %edx,%eax
     bf4:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
  }
  return ~(acc & 0xffffUL);
     bf7:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     bfa:	f7 d0                	not    %eax
     bfc:	0f b7 c0             	movzwl %ax,%eax
}
     bff:	c9                   	leave  
     c00:	c3                   	ret    
     c01:	eb 0d                	jmp    c10 <inet_addr>
     c03:	90                   	nop    
     c04:	90                   	nop    
     c05:	90                   	nop    
     c06:	90                   	nop    
     c07:	90                   	nop    
     c08:	90                   	nop    
     c09:	90                   	nop    
     c0a:	90                   	nop    
     c0b:	90                   	nop    
     c0c:	90                   	nop    
     c0d:	90                   	nop    
     c0e:	90                   	nop    
     c0f:	90                   	nop    

00000c10 <inet_addr>:

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
     c10:	55                   	push   %ebp
     c11:	89 e5                	mov    %esp,%ebp
     c13:	83 ec 28             	sub    $0x28,%esp
     struct in_addr val;

     if (inet_aton(cp, &val)) {
     c16:	8d 45 fc             	lea    0xfffffffc(%ebp),%eax
     c19:	89 44 24 04          	mov    %eax,0x4(%esp)
     c1d:	8b 45 08             	mov    0x8(%ebp),%eax
     c20:	89 04 24             	mov    %eax,(%esp)
     c23:	e8 18 00 00 00       	call   c40 <inet_aton>
     c28:	85 c0                	test   %eax,%eax
     c2a:	74 08                	je     c34 <inet_addr+0x24>
         return (val.s_addr);
     c2c:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     c2f:	89 45 ec             	mov    %eax,0xffffffec(%ebp)
     c32:	eb 07                	jmp    c3b <inet_addr+0x2b>
     }
     return (INADDR_NONE);
     c34:	c7 45 ec ff ff ff ff 	movl   $0xffffffff,0xffffffec(%ebp)
     c3b:	8b 45 ec             	mov    0xffffffec(%ebp),%eax
 }
     c3e:	c9                   	leave  
     c3f:	c3                   	ret    

00000c40 <inet_aton>:

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
     c40:	55                   	push   %ebp
     c41:	89 e5                	mov    %esp,%ebp
     c43:	83 ec 48             	sub    $0x48,%esp
     u32_t val;
     int base, n;
     char c;
     u32_t parts[4];
     u32_t* pp = parts;
     c46:	8d 45 dc             	lea    0xffffffdc(%ebp),%eax
     c49:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)

     c = *cp;
     c4c:	8b 45 08             	mov    0x8(%ebp),%eax
     c4f:	0f b6 00             	movzbl (%eax),%eax
     c52:	88 45 fb             	mov    %al,0xfffffffb(%ebp)
     for (;;) {
         /*
          * Collect number up to ``.''.
          * Values are specified as for C:
          * 0x=hex, 0=octal, isdigit=decimal.
          */
         if (!isdigit(c))
     c55:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
     c59:	3c 2f                	cmp    $0x2f,%al
     c5b:	76 08                	jbe    c65 <inet_aton+0x25>
     c5d:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
     c61:	3c 39                	cmp    $0x39,%al
     c63:	76 0c                	jbe    c71 <inet_aton+0x31>
             return (0);
     c65:	c7 45 c0 00 00 00 00 	movl   $0x0,0xffffffc0(%ebp)
     c6c:	e9 78 02 00 00       	jmp    ee9 <inet_aton+0x2a9>
         val = 0; base = 10;
     c71:	c7 45 ec 00 00 00 00 	movl   $0x0,0xffffffec(%ebp)
     c78:	c7 45 f0 0a 00 00 00 	movl   $0xa,0xfffffff0(%ebp)
         if (c == '0') {
     c7f:	80 7d fb 30          	cmpb   $0x30,0xfffffffb(%ebp)
     c83:	75 36                	jne    cbb <inet_aton+0x7b>
             c = *++cp;
     c85:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     c89:	8b 45 08             	mov    0x8(%ebp),%eax
     c8c:	0f b6 00             	movzbl (%eax),%eax
     c8f:	88 45 fb             	mov    %al,0xfffffffb(%ebp)
             if (c == 'x' || c == 'X')
     c92:	80 7d fb 78          	cmpb   $0x78,0xfffffffb(%ebp)
     c96:	74 06                	je     c9e <inet_aton+0x5e>
     c98:	80 7d fb 58          	cmpb   $0x58,0xfffffffb(%ebp)
     c9c:	75 16                	jne    cb4 <inet_aton+0x74>
                 base = 16, c = *++cp;
     c9e:	c7 45 f0 10 00 00 00 	movl   $0x10,0xfffffff0(%ebp)
     ca5:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     ca9:	8b 45 08             	mov    0x8(%ebp),%eax
     cac:	0f b6 00             	movzbl (%eax),%eax
     caf:	88 45 fb             	mov    %al,0xfffffffb(%ebp)
     cb2:	eb 07                	jmp    cbb <inet_aton+0x7b>
             else
                 base = 8;
     cb4:	c7 45 f0 08 00 00 00 	movl   $0x8,0xfffffff0(%ebp)
         }
         for (;;) {
             if (isascii(c) && isdigit(c)) {
     cbb:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
     cbf:	3c 1f                	cmp    $0x1f,%al
     cc1:	76 3b                	jbe    cfe <inet_aton+0xbe>
     cc3:	80 7d fb 00          	cmpb   $0x0,0xfffffffb(%ebp)
     cc7:	78 35                	js     cfe <inet_aton+0xbe>
     cc9:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
     ccd:	3c 2f                	cmp    $0x2f,%al
     ccf:	76 2d                	jbe    cfe <inet_aton+0xbe>
     cd1:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
     cd5:	3c 39                	cmp    $0x39,%al
     cd7:	77 25                	ja     cfe <inet_aton+0xbe>
                 val = (val * base) + (c - '0');
     cd9:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
     cdc:	89 c2                	mov    %eax,%edx
     cde:	0f af 55 ec          	imul   0xffffffec(%ebp),%edx
     ce2:	0f be 45 fb          	movsbl 0xfffffffb(%ebp),%eax
     ce6:	8d 04 02             	lea    (%edx,%eax,1),%eax
     ce9:	83 e8 30             	sub    $0x30,%eax
     cec:	89 45 ec             	mov    %eax,0xffffffec(%ebp)
                 c = *++cp;
     cef:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     cf3:	8b 45 08             	mov    0x8(%ebp),%eax
     cf6:	0f b6 00             	movzbl (%eax),%eax
     cf9:	88 45 fb             	mov    %al,0xfffffffb(%ebp)
     cfc:	eb bd                	jmp    cbb <inet_aton+0x7b>
             } else if (base == 16 && isascii(c) && isxdigit(c)) {
     cfe:	83 7d f0 10          	cmpl   $0x10,0xfffffff0(%ebp)
     d02:	0f 85 99 00 00 00    	jne    da1 <inet_aton+0x161>
     d08:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
     d0c:	3c 1f                	cmp    $0x1f,%al
     d0e:	0f 86 8d 00 00 00    	jbe    da1 <inet_aton+0x161>
     d14:	80 7d fb 00          	cmpb   $0x0,0xfffffffb(%ebp)
     d18:	0f 88 83 00 00 00    	js     da1 <inet_aton+0x161>
     d1e:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
     d22:	3c 2f                	cmp    $0x2f,%al
     d24:	76 08                	jbe    d2e <inet_aton+0xee>
     d26:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
     d2a:	3c 39                	cmp    $0x39,%al
     d2c:	76 20                	jbe    d4e <inet_aton+0x10e>
     d2e:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
     d32:	3c 60                	cmp    $0x60,%al
     d34:	76 08                	jbe    d3e <inet_aton+0xfe>
     d36:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
     d3a:	3c 66                	cmp    $0x66,%al
     d3c:	76 10                	jbe    d4e <inet_aton+0x10e>
     d3e:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
     d42:	3c 40                	cmp    $0x40,%al
     d44:	76 5b                	jbe    da1 <inet_aton+0x161>
     d46:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
     d4a:	3c 46                	cmp    $0x46,%al
     d4c:	77 53                	ja     da1 <inet_aton+0x161>
                 val = (val << 4) |
     d4e:	8b 45 ec             	mov    0xffffffec(%ebp),%eax
     d51:	89 c2                	mov    %eax,%edx
     d53:	c1 e2 04             	shl    $0x4,%edx
     d56:	89 55 c4             	mov    %edx,0xffffffc4(%ebp)
     d59:	0f be 45 fb          	movsbl 0xfffffffb(%ebp),%eax
     d5d:	83 c0 0a             	add    $0xa,%eax
     d60:	89 45 c8             	mov    %eax,0xffffffc8(%ebp)
     d63:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
     d67:	3c 60                	cmp    $0x60,%al
     d69:	76 11                	jbe    d7c <inet_aton+0x13c>
     d6b:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
     d6f:	3c 7a                	cmp    $0x7a,%al
     d71:	77 09                	ja     d7c <inet_aton+0x13c>
     d73:	c7 45 cc 61 00 00 00 	movl   $0x61,0xffffffcc(%ebp)
     d7a:	eb 07                	jmp    d83 <inet_aton+0x143>
     d7c:	c7 45 cc 41 00 00 00 	movl   $0x41,0xffffffcc(%ebp)
     d83:	8b 45 c8             	mov    0xffffffc8(%ebp),%eax
     d86:	2b 45 cc             	sub    0xffffffcc(%ebp),%eax
     d89:	0b 45 c4             	or     0xffffffc4(%ebp),%eax
     d8c:	89 45 ec             	mov    %eax,0xffffffec(%ebp)
                     (c + 10 - (islower(c) ? 'a' : 'A'));
                 c = *++cp;
     d8f:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     d93:	8b 45 08             	mov    0x8(%ebp),%eax
     d96:	0f b6 00             	movzbl (%eax),%eax
     d99:	88 45 fb             	mov    %al,0xfffffffb(%ebp)
             } else
             break;
         }
     d9c:	e9 1a ff ff ff       	jmp    cbb <inet_aton+0x7b>
         if (c == '.') {
     da1:	80 7d fb 2e          	cmpb   $0x2e,0xfffffffb(%ebp)
     da5:	75 35                	jne    ddc <inet_aton+0x19c>
             /*
              * Internet format:
              *  a.b.c.d
              *  a.b.c   (with c treated as 16 bits)
              *  a.b (with b treated as 24 bits)
              */
             if (pp >= parts + 3)
     da7:	8d 45 dc             	lea    0xffffffdc(%ebp),%eax
     daa:	83 c0 0c             	add    $0xc,%eax
     dad:	3b 45 fc             	cmp    0xfffffffc(%ebp),%eax
     db0:	77 0c                	ja     dbe <inet_aton+0x17e>
                 return (0);
     db2:	c7 45 c0 00 00 00 00 	movl   $0x0,0xffffffc0(%ebp)
     db9:	e9 2b 01 00 00       	jmp    ee9 <inet_aton+0x2a9>
             *pp++ = val;
     dbe:	8b 55 fc             	mov    0xfffffffc(%ebp),%edx
     dc1:	8b 45 ec             	mov    0xffffffec(%ebp),%eax
     dc4:	89 02                	mov    %eax,(%edx)
     dc6:	83 45 fc 04          	addl   $0x4,0xfffffffc(%ebp)
             c = *++cp;
     dca:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     dce:	8b 45 08             	mov    0x8(%ebp),%eax
     dd1:	0f b6 00             	movzbl (%eax),%eax
     dd4:	88 45 fb             	mov    %al,0xfffffffb(%ebp)
         } else
             break;
     }
     dd7:	e9 79 fe ff ff       	jmp    c55 <inet_aton+0x15>
     /*
      * Check for trailing characters.
      */
     if (c != '\0' && (!isascii(c) || !isspace(c)))
     ddc:	80 7d fb 00          	cmpb   $0x0,0xfffffffb(%ebp)
     de0:	74 3e                	je     e20 <inet_aton+0x1e0>
     de2:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
     de6:	3c 1f                	cmp    $0x1f,%al
     de8:	76 2a                	jbe    e14 <inet_aton+0x1d4>
     dea:	80 7d fb 00          	cmpb   $0x0,0xfffffffb(%ebp)
     dee:	78 24                	js     e14 <inet_aton+0x1d4>
     df0:	80 7d fb 20          	cmpb   $0x20,0xfffffffb(%ebp)
     df4:	74 2a                	je     e20 <inet_aton+0x1e0>
     df6:	80 7d fb 0c          	cmpb   $0xc,0xfffffffb(%ebp)
     dfa:	74 24                	je     e20 <inet_aton+0x1e0>
     dfc:	80 7d fb 0a          	cmpb   $0xa,0xfffffffb(%ebp)
     e00:	74 1e                	je     e20 <inet_aton+0x1e0>
     e02:	80 7d fb 0d          	cmpb   $0xd,0xfffffffb(%ebp)
     e06:	74 18                	je     e20 <inet_aton+0x1e0>
     e08:	80 7d fb 09          	cmpb   $0x9,0xfffffffb(%ebp)
     e0c:	74 12                	je     e20 <inet_aton+0x1e0>
     e0e:	80 7d fb 0b          	cmpb   $0xb,0xfffffffb(%ebp)
     e12:	74 0c                	je     e20 <inet_aton+0x1e0>
         return (0);
     e14:	c7 45 c0 00 00 00 00 	movl   $0x0,0xffffffc0(%ebp)
     e1b:	e9 c9 00 00 00       	jmp    ee9 <inet_aton+0x2a9>
     /*
      * Concoct the address according to
      * the number of parts specified.
      */
     n = pp - parts + 1;
     e20:	8b 55 fc             	mov    0xfffffffc(%ebp),%edx
     e23:	8d 45 dc             	lea    0xffffffdc(%ebp),%eax
     e26:	89 d1                	mov    %edx,%ecx
     e28:	29 c1                	sub    %eax,%ecx
     e2a:	89 c8                	mov    %ecx,%eax
     e2c:	c1 f8 02             	sar    $0x2,%eax
     e2f:	83 c0 01             	add    $0x1,%eax
     e32:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
     switch (n) {
     e35:	83 7d f4 04          	cmpl   $0x4,0xfffffff4(%ebp)
     e39:	0f 87 8b 00 00 00    	ja     eca <inet_aton+0x28a>
     e3f:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     e42:	c1 e0 02             	shl    $0x2,%eax
     e45:	8b 80 b0 10 00 00    	mov    0x10b0(%eax),%eax
     e4b:	ff e0                	jmp    *%eax

     case 0:
         return (0);     /* initial nondigit */
     e4d:	c7 45 c0 00 00 00 00 	movl   $0x0,0xffffffc0(%ebp)
     e54:	e9 90 00 00 00       	jmp    ee9 <inet_aton+0x2a9>

     case 1:             /* a -- 32 bits */
         break;

     case 2:             /* a.b -- 8.24 bits */
         if (val > 0xffffff)
     e59:	81 7d ec ff ff ff 00 	cmpl   $0xffffff,0xffffffec(%ebp)
     e60:	76 09                	jbe    e6b <inet_aton+0x22b>
             return (0);
     e62:	c7 45 c0 00 00 00 00 	movl   $0x0,0xffffffc0(%ebp)
     e69:	eb 7e                	jmp    ee9 <inet_aton+0x2a9>
         val |= parts[0] << 24;
     e6b:	8b 45 dc             	mov    0xffffffdc(%ebp),%eax
     e6e:	c1 e0 18             	shl    $0x18,%eax
     e71:	09 45 ec             	or     %eax,0xffffffec(%ebp)
         break;
     e74:	eb 54                	jmp    eca <inet_aton+0x28a>

     case 3:             /* a.b.c -- 8.8.16 bits */
         if (val > 0xffff)
     e76:	81 7d ec ff ff 00 00 	cmpl   $0xffff,0xffffffec(%ebp)
     e7d:	76 09                	jbe    e88 <inet_aton+0x248>
             return (0);
     e7f:	c7 45 c0 00 00 00 00 	movl   $0x0,0xffffffc0(%ebp)
     e86:	eb 61                	jmp    ee9 <inet_aton+0x2a9>
         val |= (parts[0] << 24) | (parts[1] << 16);
     e88:	8b 45 dc             	mov    0xffffffdc(%ebp),%eax
     e8b:	89 c2                	mov    %eax,%edx
     e8d:	c1 e2 18             	shl    $0x18,%edx
     e90:	8b 45 e0             	mov    0xffffffe0(%ebp),%eax
     e93:	c1 e0 10             	shl    $0x10,%eax
     e96:	09 d0                	or     %edx,%eax
     e98:	09 45 ec             	or     %eax,0xffffffec(%ebp)
         break;
     e9b:	eb 2d                	jmp    eca <inet_aton+0x28a>

     case 4:             /* a.b.c.d -- 8.8.8.8 bits */
         if (val > 0xff)
     e9d:	81 7d ec ff 00 00 00 	cmpl   $0xff,0xffffffec(%ebp)
     ea4:	76 09                	jbe    eaf <inet_aton+0x26f>
             return (0);
     ea6:	c7 45 c0 00 00 00 00 	movl   $0x0,0xffffffc0(%ebp)
     ead:	eb 3a                	jmp    ee9 <inet_aton+0x2a9>
         val |= (parts[0] << 24) | (parts[1] << 16) | (parts[2] << 8);
     eaf:	8b 45 dc             	mov    0xffffffdc(%ebp),%eax
     eb2:	89 c2                	mov    %eax,%edx
     eb4:	c1 e2 18             	shl    $0x18,%edx
     eb7:	8b 45 e0             	mov    0xffffffe0(%ebp),%eax
     eba:	c1 e0 10             	shl    $0x10,%eax
     ebd:	09 c2                	or     %eax,%edx
     ebf:	8b 45 e4             	mov    0xffffffe4(%ebp),%eax
     ec2:	c1 e0 08             	shl    $0x8,%eax
     ec5:	09 d0                	or     %edx,%eax
     ec7:	09 45 ec             	or     %eax,0xffffffec(%ebp)
         break;
     }
     if (addr)
     eca:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     ece:	74 12                	je     ee2 <inet_aton+0x2a2>
         addr->s_addr = htonl(val);
     ed0:	8b 45 ec             	mov    0xffffffec(%ebp),%eax
     ed3:	89 04 24             	mov    %eax,(%esp)
     ed6:	e8 65 01 00 00       	call   1040 <htonl>
     edb:	89 c2                	mov    %eax,%edx
     edd:	8b 45 0c             	mov    0xc(%ebp),%eax
     ee0:	89 10                	mov    %edx,(%eax)
     return (1);
     ee2:	c7 45 c0 01 00 00 00 	movl   $0x1,0xffffffc0(%ebp)
     ee9:	8b 45 c0             	mov    0xffffffc0(%ebp),%eax
 }
     eec:	c9                   	leave  
     eed:	c3                   	ret    
     eee:	89 f6                	mov    %esi,%esi

00000ef0 <inet_ntoa>:

/* Convert numeric IP address into decimal dotted ASCII representation.
 * returns ptr to static buffer; not reentrant!
 */
char *inet_ntoa(struct in_addr addr)
{
     ef0:	55                   	push   %ebp
     ef1:	89 e5                	mov    %esp,%ebp
     ef3:	53                   	push   %ebx
     ef4:	83 ec 24             	sub    $0x24,%esp
  static char str[16];
  u32_t s_addr = addr.s_addr;
     ef7:	8b 45 08             	mov    0x8(%ebp),%eax
     efa:	89 45 ec             	mov    %eax,0xffffffec(%ebp)
  char inv[3];
  char *rp;
  char *ap;
  u8_t rem;
  u8_t n;
  u8_t i;

  rp = str;
     efd:	c7 45 f0 e4 10 00 00 	movl   $0x10e4,0xfffffff0(%ebp)
  ap = (u8_t *)&s_addr;
     f04:	8d 45 ec             	lea    0xffffffec(%ebp),%eax
     f07:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
  for(n = 0; n < 4; n++) {
     f0a:	c6 45 fa 00          	movb   $0x0,0xfffffffa(%ebp)
     f0e:	e9 af 00 00 00       	jmp    fc2 <inet_ntoa+0xd2>
    i = 0;
     f13:	c6 45 fb 00          	movb   $0x0,0xfffffffb(%ebp)
    do {
      rem = *ap % (u8_t)10;
     f17:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     f1a:	0f b6 08             	movzbl (%eax),%ecx
     f1d:	b8 67 00 00 00       	mov    $0x67,%eax
     f22:	f6 e9                	imul   %cl
     f24:	66 c1 e8 08          	shr    $0x8,%ax
     f28:	89 c2                	mov    %eax,%edx
     f2a:	c0 fa 02             	sar    $0x2,%dl
     f2d:	89 c8                	mov    %ecx,%eax
     f2f:	c0 f8 07             	sar    $0x7,%al
     f32:	89 d3                	mov    %edx,%ebx
     f34:	28 c3                	sub    %al,%bl
     f36:	88 5d db             	mov    %bl,0xffffffdb(%ebp)
     f39:	0f b6 45 db          	movzbl 0xffffffdb(%ebp),%eax
     f3d:	c1 e0 02             	shl    $0x2,%eax
     f40:	02 45 db             	add    0xffffffdb(%ebp),%al
     f43:	01 c0                	add    %eax,%eax
     f45:	89 ca                	mov    %ecx,%edx
     f47:	28 c2                	sub    %al,%dl
     f49:	88 55 db             	mov    %dl,0xffffffdb(%ebp)
     f4c:	0f b6 5d db          	movzbl 0xffffffdb(%ebp),%ebx
     f50:	88 5d f9             	mov    %bl,0xfffffff9(%ebp)
      *ap /= (u8_t)10;
     f53:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     f56:	0f b6 08             	movzbl (%eax),%ecx
     f59:	b8 67 00 00 00       	mov    $0x67,%eax
     f5e:	f6 e9                	imul   %cl
     f60:	66 c1 e8 08          	shr    $0x8,%ax
     f64:	89 c2                	mov    %eax,%edx
     f66:	c0 fa 02             	sar    $0x2,%dl
     f69:	89 c8                	mov    %ecx,%eax
     f6b:	c0 f8 07             	sar    $0x7,%al
     f6e:	28 c2                	sub    %al,%dl
     f70:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     f73:	88 10                	mov    %dl,(%eax)
      inv[i++] = '0' + rem;
     f75:	0f b6 55 fb          	movzbl 0xfffffffb(%ebp),%edx
     f79:	0f b6 45 f9          	movzbl 0xfffffff9(%ebp),%eax
     f7d:	83 c0 30             	add    $0x30,%eax
     f80:	88 44 15 e9          	mov    %al,0xffffffe9(%ebp,%edx,1)
     f84:	80 45 fb 01          	addb   $0x1,0xfffffffb(%ebp)
    } while(*ap);
     f88:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     f8b:	0f b6 00             	movzbl (%eax),%eax
     f8e:	84 c0                	test   %al,%al
     f90:	75 85                	jne    f17 <inet_ntoa+0x27>
    while(i--)
     f92:	eb 12                	jmp    fa6 <inet_ntoa+0xb6>
      *rp++ = inv[i];
     f94:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
     f98:	0f b6 54 05 e9       	movzbl 0xffffffe9(%ebp,%eax,1),%edx
     f9d:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
     fa0:	88 10                	mov    %dl,(%eax)
     fa2:	83 45 f0 01          	addl   $0x1,0xfffffff0(%ebp)
     fa6:	80 6d fb 01          	subb   $0x1,0xfffffffb(%ebp)
     faa:	80 7d fb ff          	cmpb   $0xff,0xfffffffb(%ebp)
     fae:	75 e4                	jne    f94 <inet_ntoa+0xa4>
    *rp++ = '.';
     fb0:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
     fb3:	c6 00 2e             	movb   $0x2e,(%eax)
     fb6:	83 45 f0 01          	addl   $0x1,0xfffffff0(%ebp)
    ap++;
     fba:	83 45 f4 01          	addl   $0x1,0xfffffff4(%ebp)
     fbe:	80 45 fa 01          	addb   $0x1,0xfffffffa(%ebp)
     fc2:	80 7d fa 03          	cmpb   $0x3,0xfffffffa(%ebp)
     fc6:	0f 86 47 ff ff ff    	jbe    f13 <inet_ntoa+0x23>
  }
  *--rp = 0;
     fcc:	83 6d f0 01          	subl   $0x1,0xfffffff0(%ebp)
     fd0:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
     fd3:	c6 00 00             	movb   $0x0,(%eax)
  return str;
     fd6:	b8 e4 10 00 00       	mov    $0x10e4,%eax
}
     fdb:	83 c4 24             	add    $0x24,%esp
     fde:	5b                   	pop    %ebx
     fdf:	5d                   	pop    %ebp
     fe0:	c3                   	ret    
     fe1:	eb 0d                	jmp    ff0 <htons>
     fe3:	90                   	nop    
     fe4:	90                   	nop    
     fe5:	90                   	nop    
     fe6:	90                   	nop    
     fe7:	90                   	nop    
     fe8:	90                   	nop    
     fe9:	90                   	nop    
     fea:	90                   	nop    
     feb:	90                   	nop    
     fec:	90                   	nop    
     fed:	90                   	nop    
     fee:	90                   	nop    
     fef:	90                   	nop    

00000ff0 <htons>:


#ifndef BYTE_ORDER
#error BYTE_ORDER is not defined
#endif
#if BYTE_ORDER == LITTLE_ENDIAN

u16_t
htons(u16_t n)
{
     ff0:	55                   	push   %ebp
     ff1:	89 e5                	mov    %esp,%ebp
     ff3:	83 ec 04             	sub    $0x4,%esp
     ff6:	8b 45 08             	mov    0x8(%ebp),%eax
     ff9:	66 89 45 fc          	mov    %ax,0xfffffffc(%ebp)
  return ((n & 0xff) << 8) | ((n & 0xff00) >> 8);
     ffd:	0f b7 45 fc          	movzwl 0xfffffffc(%ebp),%eax
    1001:	25 ff 00 00 00       	and    $0xff,%eax
    1006:	c1 e0 08             	shl    $0x8,%eax
    1009:	89 c2                	mov    %eax,%edx
    100b:	0f b7 45 fc          	movzwl 0xfffffffc(%ebp),%eax
    100f:	25 00 ff 00 00       	and    $0xff00,%eax
    1014:	c1 f8 08             	sar    $0x8,%eax
    1017:	09 d0                	or     %edx,%eax
    1019:	0f b7 c0             	movzwl %ax,%eax
}
    101c:	c9                   	leave  
    101d:	c3                   	ret    
    101e:	89 f6                	mov    %esi,%esi

00001020 <ntohs>:

u16_t
ntohs(u16_t n)
{
    1020:	55                   	push   %ebp
    1021:	89 e5                	mov    %esp,%ebp
    1023:	83 ec 08             	sub    $0x8,%esp
    1026:	8b 45 08             	mov    0x8(%ebp),%eax
    1029:	66 89 45 fc          	mov    %ax,0xfffffffc(%ebp)
  return htons(n);
    102d:	0f b7 45 fc          	movzwl 0xfffffffc(%ebp),%eax
    1031:	89 04 24             	mov    %eax,(%esp)
    1034:	e8 b7 ff ff ff       	call   ff0 <htons>
    1039:	0f b7 c0             	movzwl %ax,%eax
}
    103c:	c9                   	leave  
    103d:	c3                   	ret    
    103e:	89 f6                	mov    %esi,%esi

00001040 <htonl>:

u32_t
htonl(u32_t n)
{
    1040:	55                   	push   %ebp
    1041:	89 e5                	mov    %esp,%ebp
  return ((n & 0xff) << 24) |
    1043:	0f b6 45 08          	movzbl 0x8(%ebp),%eax
    1047:	89 c2                	mov    %eax,%edx
    1049:	c1 e2 18             	shl    $0x18,%edx
    104c:	8b 45 08             	mov    0x8(%ebp),%eax
    104f:	25 00 ff 00 00       	and    $0xff00,%eax
    1054:	c1 e0 08             	shl    $0x8,%eax
    1057:	09 c2                	or     %eax,%edx
    1059:	8b 45 08             	mov    0x8(%ebp),%eax
    105c:	25 00 00 ff 00       	and    $0xff0000,%eax
    1061:	c1 e8 08             	shr    $0x8,%eax
    1064:	09 c2                	or     %eax,%edx
    1066:	8b 45 08             	mov    0x8(%ebp),%eax
    1069:	25 00 00 00 ff       	and    $0xff000000,%eax
    106e:	c1 e8 18             	shr    $0x18,%eax
    1071:	09 d0                	or     %edx,%eax
    ((n & 0xff00) << 8) |
    ((n & 0xff0000) >> 8) |
    ((n & 0xff000000) >> 24);
}
    1073:	5d                   	pop    %ebp
    1074:	c3                   	ret    
    1075:	8d 74 26 00          	lea    0x0(%esi),%esi
    1079:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00001080 <ntohl>:

u32_t
ntohl(u32_t n)
{
    1080:	55                   	push   %ebp
    1081:	89 e5                	mov    %esp,%ebp
    1083:	83 ec 04             	sub    $0x4,%esp
  return htonl(n);
    1086:	8b 45 08             	mov    0x8(%ebp),%eax
    1089:	89 04 24             	mov    %eax,(%esp)
    108c:	e8 af ff ff ff       	call   1040 <htonl>
}
    1091:	c9                   	leave  
    1092:	c3                   	ret    
