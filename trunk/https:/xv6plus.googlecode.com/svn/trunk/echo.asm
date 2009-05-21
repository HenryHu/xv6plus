
_echo:     file format elf32-i386-freebsd

Disassembly of section .text:

00000000 <main>:
#include "user.h"

int
main(int argc, char *argv[])
{
       0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
       4:	83 e4 f0             	and    $0xfffffff0,%esp
       7:	ff 71 fc             	pushl  0xfffffffc(%ecx)
       a:	55                   	push   %ebp
       b:	89 e5                	mov    %esp,%ebp
       d:	51                   	push   %ecx
       e:	83 ec 34             	sub    $0x34,%esp
      11:	89 4d e4             	mov    %ecx,0xffffffe4(%ebp)
  int i;

  for(i = 1; i < argc; i++)
      14:	c7 45 f8 01 00 00 00 	movl   $0x1,0xfffffff8(%ebp)
      1b:	eb 4e                	jmp    6b <main+0x6b>
    printf(1, "%s%s", argv[i], i+1 < argc ? " " : "\n");
      1d:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
      20:	83 c0 01             	add    $0x1,%eax
      23:	8b 55 e4             	mov    0xffffffe4(%ebp),%edx
      26:	3b 02                	cmp    (%edx),%eax
      28:	7d 09                	jge    33 <main+0x33>
      2a:	c7 45 e8 a4 10 00 00 	movl   $0x10a4,0xffffffe8(%ebp)
      31:	eb 07                	jmp    3a <main+0x3a>
      33:	c7 45 e8 a6 10 00 00 	movl   $0x10a6,0xffffffe8(%ebp)
      3a:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
      3d:	c1 e0 02             	shl    $0x2,%eax
      40:	8b 55 e4             	mov    0xffffffe4(%ebp),%edx
      43:	03 42 04             	add    0x4(%edx),%eax
      46:	8b 00                	mov    (%eax),%eax
      48:	8b 55 e8             	mov    0xffffffe8(%ebp),%edx
      4b:	89 54 24 0c          	mov    %edx,0xc(%esp)
      4f:	89 44 24 08          	mov    %eax,0x8(%esp)
      53:	c7 44 24 04 a8 10 00 	movl   $0x10a8,0x4(%esp)
      5a:	00 
      5b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
      62:	e8 b9 04 00 00       	call   520 <printf>
      67:	83 45 f8 01          	addl   $0x1,0xfffffff8(%ebp)
      6b:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
      6e:	8b 55 e4             	mov    0xffffffe4(%ebp),%edx
      71:	3b 02                	cmp    (%edx),%eax
      73:	7c a8                	jl     1d <main+0x1d>
  exit();
      75:	e8 9a 02 00 00       	call   314 <exit>
      7a:	90                   	nop    
      7b:	90                   	nop    
      7c:	90                   	nop    
      7d:	90                   	nop    
      7e:	90                   	nop    
      7f:	90                   	nop    

00000080 <strcpy>:
#include "user.h"

char*
strcpy(char *s, char *t)
{
      80:	55                   	push   %ebp
      81:	89 e5                	mov    %esp,%ebp
      83:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
      86:	8b 45 08             	mov    0x8(%ebp),%eax
      89:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
  while((*s++ = *t++) != 0)
      8c:	8b 45 0c             	mov    0xc(%ebp),%eax
      8f:	0f b6 10             	movzbl (%eax),%edx
      92:	8b 45 08             	mov    0x8(%ebp),%eax
      95:	88 10                	mov    %dl,(%eax)
      97:	8b 45 08             	mov    0x8(%ebp),%eax
      9a:	0f b6 00             	movzbl (%eax),%eax
      9d:	84 c0                	test   %al,%al
      9f:	0f 95 c0             	setne  %al
      a2:	83 45 08 01          	addl   $0x1,0x8(%ebp)
      a6:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
      aa:	84 c0                	test   %al,%al
      ac:	75 de                	jne    8c <strcpy+0xc>
    ;
  return os;
      ae:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
}
      b1:	c9                   	leave  
      b2:	c3                   	ret    
      b3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

000000c0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
      c0:	55                   	push   %ebp
      c1:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
      c3:	eb 08                	jmp    cd <strcmp+0xd>
    p++, q++;
      c5:	83 45 08 01          	addl   $0x1,0x8(%ebp)
      c9:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
      cd:	8b 45 08             	mov    0x8(%ebp),%eax
      d0:	0f b6 00             	movzbl (%eax),%eax
      d3:	84 c0                	test   %al,%al
      d5:	74 10                	je     e7 <strcmp+0x27>
      d7:	8b 45 08             	mov    0x8(%ebp),%eax
      da:	0f b6 10             	movzbl (%eax),%edx
      dd:	8b 45 0c             	mov    0xc(%ebp),%eax
      e0:	0f b6 00             	movzbl (%eax),%eax
      e3:	38 c2                	cmp    %al,%dl
      e5:	74 de                	je     c5 <strcmp+0x5>
  return (uchar)*p - (uchar)*q;
      e7:	8b 45 08             	mov    0x8(%ebp),%eax
      ea:	0f b6 00             	movzbl (%eax),%eax
      ed:	0f b6 d0             	movzbl %al,%edx
      f0:	8b 45 0c             	mov    0xc(%ebp),%eax
      f3:	0f b6 00             	movzbl (%eax),%eax
      f6:	0f b6 c0             	movzbl %al,%eax
      f9:	89 d1                	mov    %edx,%ecx
      fb:	29 c1                	sub    %eax,%ecx
      fd:	89 c8                	mov    %ecx,%eax
}
      ff:	5d                   	pop    %ebp
     100:	c3                   	ret    
     101:	eb 0d                	jmp    110 <strlen>
     103:	90                   	nop    
     104:	90                   	nop    
     105:	90                   	nop    
     106:	90                   	nop    
     107:	90                   	nop    
     108:	90                   	nop    
     109:	90                   	nop    
     10a:	90                   	nop    
     10b:	90                   	nop    
     10c:	90                   	nop    
     10d:	90                   	nop    
     10e:	90                   	nop    
     10f:	90                   	nop    

00000110 <strlen>:

uint
strlen(char *s)
{
     110:	55                   	push   %ebp
     111:	89 e5                	mov    %esp,%ebp
     113:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
     116:	c7 45 fc 00 00 00 00 	movl   $0x0,0xfffffffc(%ebp)
     11d:	eb 04                	jmp    123 <strlen+0x13>
     11f:	83 45 fc 01          	addl   $0x1,0xfffffffc(%ebp)
     123:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     126:	03 45 08             	add    0x8(%ebp),%eax
     129:	0f b6 00             	movzbl (%eax),%eax
     12c:	84 c0                	test   %al,%al
     12e:	75 ef                	jne    11f <strlen+0xf>
    ;
  return n;
     130:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
}
     133:	c9                   	leave  
     134:	c3                   	ret    
     135:	8d 74 26 00          	lea    0x0(%esi),%esi
     139:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00000140 <memset>:

void*
memset(void *dst, int c, uint n)
{
     140:	55                   	push   %ebp
     141:	89 e5                	mov    %esp,%ebp
     143:	83 ec 10             	sub    $0x10,%esp
  char *d;
  
  d = dst;
     146:	8b 45 08             	mov    0x8(%ebp),%eax
     149:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
  while(n-- > 0)
     14c:	eb 0e                	jmp    15c <memset+0x1c>
    *d++ = c;
     14e:	8b 45 0c             	mov    0xc(%ebp),%eax
     151:	89 c2                	mov    %eax,%edx
     153:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     156:	88 10                	mov    %dl,(%eax)
     158:	83 45 fc 01          	addl   $0x1,0xfffffffc(%ebp)
     15c:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
     160:	83 7d 10 ff          	cmpl   $0xffffffff,0x10(%ebp)
     164:	75 e8                	jne    14e <memset+0xe>
  return dst;
     166:	8b 45 08             	mov    0x8(%ebp),%eax
}
     169:	c9                   	leave  
     16a:	c3                   	ret    
     16b:	90                   	nop    
     16c:	8d 74 26 00          	lea    0x0(%esi),%esi

00000170 <strchr>:

char*
strchr(const char *s, char c)
{
     170:	55                   	push   %ebp
     171:	89 e5                	mov    %esp,%ebp
     173:	83 ec 08             	sub    $0x8,%esp
     176:	8b 45 0c             	mov    0xc(%ebp),%eax
     179:	88 45 fc             	mov    %al,0xfffffffc(%ebp)
  for(; *s; s++)
     17c:	eb 17                	jmp    195 <strchr+0x25>
    if(*s == c)
     17e:	8b 45 08             	mov    0x8(%ebp),%eax
     181:	0f b6 00             	movzbl (%eax),%eax
     184:	3a 45 fc             	cmp    0xfffffffc(%ebp),%al
     187:	75 08                	jne    191 <strchr+0x21>
      return (char*) s;
     189:	8b 45 08             	mov    0x8(%ebp),%eax
     18c:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
     18f:	eb 15                	jmp    1a6 <strchr+0x36>
     191:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     195:	8b 45 08             	mov    0x8(%ebp),%eax
     198:	0f b6 00             	movzbl (%eax),%eax
     19b:	84 c0                	test   %al,%al
     19d:	75 df                	jne    17e <strchr+0xe>
  return 0;
     19f:	c7 45 f8 00 00 00 00 	movl   $0x0,0xfffffff8(%ebp)
     1a6:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
}
     1a9:	c9                   	leave  
     1aa:	c3                   	ret    
     1ab:	90                   	nop    
     1ac:	8d 74 26 00          	lea    0x0(%esi),%esi

000001b0 <gets>:

char*
gets(char *buf, int max)
{
     1b0:	55                   	push   %ebp
     1b1:	89 e5                	mov    %esp,%ebp
     1b3:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     1b6:	c7 45 f8 00 00 00 00 	movl   $0x0,0xfffffff8(%ebp)
     1bd:	eb 46                	jmp    205 <gets+0x55>
    cc = read(0, &c, 1);
     1bf:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
     1c6:	00 
     1c7:	8d 45 f7             	lea    0xfffffff7(%ebp),%eax
     1ca:	89 44 24 04          	mov    %eax,0x4(%esp)
     1ce:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     1d5:	e8 52 01 00 00       	call   32c <read>
     1da:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
    if(cc < 1)
     1dd:	83 7d fc 00          	cmpl   $0x0,0xfffffffc(%ebp)
     1e1:	7e 2d                	jle    210 <gets+0x60>
      break;
    buf[i++] = c;
     1e3:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     1e6:	89 c2                	mov    %eax,%edx
     1e8:	03 55 08             	add    0x8(%ebp),%edx
     1eb:	0f b6 45 f7          	movzbl 0xfffffff7(%ebp),%eax
     1ef:	88 02                	mov    %al,(%edx)
     1f1:	83 45 f8 01          	addl   $0x1,0xfffffff8(%ebp)
    if(c == '\n' || c == '\r')
     1f5:	0f b6 45 f7          	movzbl 0xfffffff7(%ebp),%eax
     1f9:	3c 0a                	cmp    $0xa,%al
     1fb:	74 13                	je     210 <gets+0x60>
     1fd:	0f b6 45 f7          	movzbl 0xfffffff7(%ebp),%eax
     201:	3c 0d                	cmp    $0xd,%al
     203:	74 0b                	je     210 <gets+0x60>
     205:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     208:	83 c0 01             	add    $0x1,%eax
     20b:	3b 45 0c             	cmp    0xc(%ebp),%eax
     20e:	7c af                	jl     1bf <gets+0xf>
      break;
  }
  buf[i] = '\0';
     210:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     213:	03 45 08             	add    0x8(%ebp),%eax
     216:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
     219:	8b 45 08             	mov    0x8(%ebp),%eax
}
     21c:	c9                   	leave  
     21d:	c3                   	ret    
     21e:	89 f6                	mov    %esi,%esi

00000220 <stat>:

int
stat(char *n, struct stat *st)
{
     220:	55                   	push   %ebp
     221:	89 e5                	mov    %esp,%ebp
     223:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     226:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     22d:	00 
     22e:	8b 45 08             	mov    0x8(%ebp),%eax
     231:	89 04 24             	mov    %eax,(%esp)
     234:	e8 1b 01 00 00       	call   354 <open>
     239:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
  if(fd < 0)
     23c:	83 7d f8 00          	cmpl   $0x0,0xfffffff8(%ebp)
     240:	79 09                	jns    24b <stat+0x2b>
    return -1;
     242:	c7 45 ec ff ff ff ff 	movl   $0xffffffff,0xffffffec(%ebp)
     249:	eb 26                	jmp    271 <stat+0x51>
  r = fstat(fd, st);
     24b:	8b 45 0c             	mov    0xc(%ebp),%eax
     24e:	89 44 24 04          	mov    %eax,0x4(%esp)
     252:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     255:	89 04 24             	mov    %eax,(%esp)
     258:	e8 0f 01 00 00       	call   36c <fstat>
     25d:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
  close(fd);
     260:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     263:	89 04 24             	mov    %eax,(%esp)
     266:	e8 d1 00 00 00       	call   33c <close>
  return r;
     26b:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     26e:	89 45 ec             	mov    %eax,0xffffffec(%ebp)
     271:	8b 45 ec             	mov    0xffffffec(%ebp),%eax
}
     274:	c9                   	leave  
     275:	c3                   	ret    
     276:	8d 76 00             	lea    0x0(%esi),%esi
     279:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00000280 <atoi>:

int
atoi(const char *s)
{
     280:	55                   	push   %ebp
     281:	89 e5                	mov    %esp,%ebp
     283:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
     286:	c7 45 fc 00 00 00 00 	movl   $0x0,0xfffffffc(%ebp)
  while('0' <= *s && *s <= '9')
     28d:	eb 24                	jmp    2b3 <atoi+0x33>
    n = n*10 + *s++ - '0';
     28f:	8b 55 fc             	mov    0xfffffffc(%ebp),%edx
     292:	89 d0                	mov    %edx,%eax
     294:	c1 e0 02             	shl    $0x2,%eax
     297:	01 d0                	add    %edx,%eax
     299:	01 c0                	add    %eax,%eax
     29b:	89 c2                	mov    %eax,%edx
     29d:	8b 45 08             	mov    0x8(%ebp),%eax
     2a0:	0f b6 00             	movzbl (%eax),%eax
     2a3:	0f be c0             	movsbl %al,%eax
     2a6:	8d 04 02             	lea    (%edx,%eax,1),%eax
     2a9:	83 e8 30             	sub    $0x30,%eax
     2ac:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
     2af:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     2b3:	8b 45 08             	mov    0x8(%ebp),%eax
     2b6:	0f b6 00             	movzbl (%eax),%eax
     2b9:	3c 2f                	cmp    $0x2f,%al
     2bb:	7e 0a                	jle    2c7 <atoi+0x47>
     2bd:	8b 45 08             	mov    0x8(%ebp),%eax
     2c0:	0f b6 00             	movzbl (%eax),%eax
     2c3:	3c 39                	cmp    $0x39,%al
     2c5:	7e c8                	jle    28f <atoi+0xf>
  return n;
     2c7:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
}
     2ca:	c9                   	leave  
     2cb:	c3                   	ret    
     2cc:	8d 74 26 00          	lea    0x0(%esi),%esi

000002d0 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
     2d0:	55                   	push   %ebp
     2d1:	89 e5                	mov    %esp,%ebp
     2d3:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
     2d6:	8b 45 08             	mov    0x8(%ebp),%eax
     2d9:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
  src = vsrc;
     2dc:	8b 45 0c             	mov    0xc(%ebp),%eax
     2df:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
  while(n-- > 0)
     2e2:	eb 13                	jmp    2f7 <memmove+0x27>
    *dst++ = *src++;
     2e4:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     2e7:	0f b6 10             	movzbl (%eax),%edx
     2ea:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     2ed:	88 10                	mov    %dl,(%eax)
     2ef:	83 45 f8 01          	addl   $0x1,0xfffffff8(%ebp)
     2f3:	83 45 fc 01          	addl   $0x1,0xfffffffc(%ebp)
     2f7:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     2fb:	0f 9f c0             	setg   %al
     2fe:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
     302:	84 c0                	test   %al,%al
     304:	75 de                	jne    2e4 <memmove+0x14>
  return vdst;
     306:	8b 45 08             	mov    0x8(%ebp),%eax
}
     309:	c9                   	leave  
     30a:	c3                   	ret    
     30b:	90                   	nop    

0000030c <fork>:
     30c:	b8 01 00 00 00       	mov    $0x1,%eax
     311:	cd 30                	int    $0x30
     313:	c3                   	ret    

00000314 <exit>:
     314:	b8 02 00 00 00       	mov    $0x2,%eax
     319:	cd 30                	int    $0x30
     31b:	c3                   	ret    

0000031c <wait>:
     31c:	b8 03 00 00 00       	mov    $0x3,%eax
     321:	cd 30                	int    $0x30
     323:	c3                   	ret    

00000324 <pipe>:
     324:	b8 04 00 00 00       	mov    $0x4,%eax
     329:	cd 30                	int    $0x30
     32b:	c3                   	ret    

0000032c <read>:
     32c:	b8 06 00 00 00       	mov    $0x6,%eax
     331:	cd 30                	int    $0x30
     333:	c3                   	ret    

00000334 <write>:
     334:	b8 05 00 00 00       	mov    $0x5,%eax
     339:	cd 30                	int    $0x30
     33b:	c3                   	ret    

0000033c <close>:
     33c:	b8 07 00 00 00       	mov    $0x7,%eax
     341:	cd 30                	int    $0x30
     343:	c3                   	ret    

00000344 <kill>:
     344:	b8 08 00 00 00       	mov    $0x8,%eax
     349:	cd 30                	int    $0x30
     34b:	c3                   	ret    

0000034c <exec>:
     34c:	b8 09 00 00 00       	mov    $0x9,%eax
     351:	cd 30                	int    $0x30
     353:	c3                   	ret    

00000354 <open>:
     354:	b8 0a 00 00 00       	mov    $0xa,%eax
     359:	cd 30                	int    $0x30
     35b:	c3                   	ret    

0000035c <mknod>:
     35c:	b8 0b 00 00 00       	mov    $0xb,%eax
     361:	cd 30                	int    $0x30
     363:	c3                   	ret    

00000364 <unlink>:
     364:	b8 0c 00 00 00       	mov    $0xc,%eax
     369:	cd 30                	int    $0x30
     36b:	c3                   	ret    

0000036c <fstat>:
     36c:	b8 0d 00 00 00       	mov    $0xd,%eax
     371:	cd 30                	int    $0x30
     373:	c3                   	ret    

00000374 <link>:
     374:	b8 0e 00 00 00       	mov    $0xe,%eax
     379:	cd 30                	int    $0x30
     37b:	c3                   	ret    

0000037c <mkdir>:
     37c:	b8 0f 00 00 00       	mov    $0xf,%eax
     381:	cd 30                	int    $0x30
     383:	c3                   	ret    

00000384 <chdir>:
     384:	b8 10 00 00 00       	mov    $0x10,%eax
     389:	cd 30                	int    $0x30
     38b:	c3                   	ret    

0000038c <dup>:
     38c:	b8 11 00 00 00       	mov    $0x11,%eax
     391:	cd 30                	int    $0x30
     393:	c3                   	ret    

00000394 <getpid>:
     394:	b8 12 00 00 00       	mov    $0x12,%eax
     399:	cd 30                	int    $0x30
     39b:	c3                   	ret    

0000039c <sbrk>:
     39c:	b8 13 00 00 00       	mov    $0x13,%eax
     3a1:	cd 30                	int    $0x30
     3a3:	c3                   	ret    

000003a4 <sleep>:
     3a4:	b8 14 00 00 00       	mov    $0x14,%eax
     3a9:	cd 30                	int    $0x30
     3ab:	c3                   	ret    

000003ac <upmsec>:
     3ac:	b8 15 00 00 00       	mov    $0x15,%eax
     3b1:	cd 30                	int    $0x30
     3b3:	c3                   	ret    

000003b4 <socket>:
     3b4:	b8 16 00 00 00       	mov    $0x16,%eax
     3b9:	cd 30                	int    $0x30
     3bb:	c3                   	ret    

000003bc <bind>:
     3bc:	b8 17 00 00 00       	mov    $0x17,%eax
     3c1:	cd 30                	int    $0x30
     3c3:	c3                   	ret    

000003c4 <listen>:
     3c4:	b8 18 00 00 00       	mov    $0x18,%eax
     3c9:	cd 30                	int    $0x30
     3cb:	c3                   	ret    

000003cc <accept>:
     3cc:	b8 19 00 00 00       	mov    $0x19,%eax
     3d1:	cd 30                	int    $0x30
     3d3:	c3                   	ret    

000003d4 <recv>:
     3d4:	b8 1a 00 00 00       	mov    $0x1a,%eax
     3d9:	cd 30                	int    $0x30
     3db:	c3                   	ret    

000003dc <recvfrom>:
     3dc:	b8 1b 00 00 00       	mov    $0x1b,%eax
     3e1:	cd 30                	int    $0x30
     3e3:	c3                   	ret    

000003e4 <send>:
     3e4:	b8 1c 00 00 00       	mov    $0x1c,%eax
     3e9:	cd 30                	int    $0x30
     3eb:	c3                   	ret    

000003ec <sendto>:
     3ec:	b8 1d 00 00 00       	mov    $0x1d,%eax
     3f1:	cd 30                	int    $0x30
     3f3:	c3                   	ret    

000003f4 <shutdown>:
     3f4:	b8 1e 00 00 00       	mov    $0x1e,%eax
     3f9:	cd 30                	int    $0x30
     3fb:	c3                   	ret    

000003fc <getsockopt>:
     3fc:	b8 1f 00 00 00       	mov    $0x1f,%eax
     401:	cd 30                	int    $0x30
     403:	c3                   	ret    

00000404 <setsockopt>:
     404:	b8 20 00 00 00       	mov    $0x20,%eax
     409:	cd 30                	int    $0x30
     40b:	c3                   	ret    

0000040c <sockclose>:
     40c:	b8 21 00 00 00       	mov    $0x21,%eax
     411:	cd 30                	int    $0x30
     413:	c3                   	ret    

00000414 <connect>:
     414:	b8 22 00 00 00       	mov    $0x22,%eax
     419:	cd 30                	int    $0x30
     41b:	c3                   	ret    

0000041c <getpeername>:
     41c:	b8 23 00 00 00       	mov    $0x23,%eax
     421:	cd 30                	int    $0x30
     423:	c3                   	ret    

00000424 <getsockname>:
     424:	b8 24 00 00 00       	mov    $0x24,%eax
     429:	cd 30                	int    $0x30
     42b:	c3                   	ret    
     42c:	90                   	nop    
     42d:	90                   	nop    
     42e:	90                   	nop    
     42f:	90                   	nop    

00000430 <putc>:
#include "user.h"

void
putc(int fd, char c)
{
     430:	55                   	push   %ebp
     431:	89 e5                	mov    %esp,%ebp
     433:	83 ec 18             	sub    $0x18,%esp
     436:	8b 45 0c             	mov    0xc(%ebp),%eax
     439:	88 45 fc             	mov    %al,0xfffffffc(%ebp)
  write(fd, &c, 1);
     43c:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
     443:	00 
     444:	8d 45 fc             	lea    0xfffffffc(%ebp),%eax
     447:	89 44 24 04          	mov    %eax,0x4(%esp)
     44b:	8b 45 08             	mov    0x8(%ebp),%eax
     44e:	89 04 24             	mov    %eax,(%esp)
     451:	e8 de fe ff ff       	call   334 <write>
}
     456:	c9                   	leave  
     457:	c3                   	ret    
     458:	90                   	nop    
     459:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi

00000460 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     460:	55                   	push   %ebp
     461:	89 e5                	mov    %esp,%ebp
     463:	53                   	push   %ebx
     464:	83 ec 34             	sub    $0x34,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     467:	c7 45 f4 00 00 00 00 	movl   $0x0,0xfffffff4(%ebp)
  if(sgn && xx < 0){
     46e:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
     472:	74 17                	je     48b <printint+0x2b>
     474:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     478:	79 11                	jns    48b <printint+0x2b>
    neg = 1;
     47a:	c7 45 f4 01 00 00 00 	movl   $0x1,0xfffffff4(%ebp)
    x = -xx;
     481:	8b 45 0c             	mov    0xc(%ebp),%eax
     484:	f7 d8                	neg    %eax
     486:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
     489:	eb 06                	jmp    491 <printint+0x31>
  } else {
    x = xx;
     48b:	8b 45 0c             	mov    0xc(%ebp),%eax
     48e:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
  }

  i = 0;
     491:	c7 45 f0 00 00 00 00 	movl   $0x0,0xfffffff0(%ebp)
  do{
    buf[i++] = digits[x % base];
     498:	8b 4d f0             	mov    0xfffffff0(%ebp),%ecx
     49b:	8b 55 10             	mov    0x10(%ebp),%edx
     49e:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     4a1:	89 d3                	mov    %edx,%ebx
     4a3:	ba 00 00 00 00       	mov    $0x0,%edx
     4a8:	f7 f3                	div    %ebx
     4aa:	89 d0                	mov    %edx,%eax
     4ac:	0f b6 80 c8 10 00 00 	movzbl 0x10c8(%eax),%eax
     4b3:	88 44 0d e0          	mov    %al,0xffffffe0(%ebp,%ecx,1)
     4b7:	83 45 f0 01          	addl   $0x1,0xfffffff0(%ebp)
  }while((x /= base) != 0);
     4bb:	8b 55 10             	mov    0x10(%ebp),%edx
     4be:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     4c1:	89 d1                	mov    %edx,%ecx
     4c3:	ba 00 00 00 00       	mov    $0x0,%edx
     4c8:	f7 f1                	div    %ecx
     4ca:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
     4cd:	83 7d f8 00          	cmpl   $0x0,0xfffffff8(%ebp)
     4d1:	75 c5                	jne    498 <printint+0x38>
  if(neg)
     4d3:	83 7d f4 00          	cmpl   $0x0,0xfffffff4(%ebp)
     4d7:	74 28                	je     501 <printint+0xa1>
    buf[i++] = '-';
     4d9:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
     4dc:	c6 44 05 e0 2d       	movb   $0x2d,0xffffffe0(%ebp,%eax,1)
     4e1:	83 45 f0 01          	addl   $0x1,0xfffffff0(%ebp)

  while(--i >= 0)
     4e5:	eb 1a                	jmp    501 <printint+0xa1>
    putc(fd, buf[i]);
     4e7:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
     4ea:	0f b6 44 05 e0       	movzbl 0xffffffe0(%ebp,%eax,1),%eax
     4ef:	0f be c0             	movsbl %al,%eax
     4f2:	89 44 24 04          	mov    %eax,0x4(%esp)
     4f6:	8b 45 08             	mov    0x8(%ebp),%eax
     4f9:	89 04 24             	mov    %eax,(%esp)
     4fc:	e8 2f ff ff ff       	call   430 <putc>
     501:	83 6d f0 01          	subl   $0x1,0xfffffff0(%ebp)
     505:	83 7d f0 00          	cmpl   $0x0,0xfffffff0(%ebp)
     509:	79 dc                	jns    4e7 <printint+0x87>
}
     50b:	83 c4 34             	add    $0x34,%esp
     50e:	5b                   	pop    %ebx
     50f:	5d                   	pop    %ebp
     510:	c3                   	ret    
     511:	eb 0d                	jmp    520 <printf>
     513:	90                   	nop    
     514:	90                   	nop    
     515:	90                   	nop    
     516:	90                   	nop    
     517:	90                   	nop    
     518:	90                   	nop    
     519:	90                   	nop    
     51a:	90                   	nop    
     51b:	90                   	nop    
     51c:	90                   	nop    
     51d:	90                   	nop    
     51e:	90                   	nop    
     51f:	90                   	nop    

00000520 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
     520:	55                   	push   %ebp
     521:	89 e5                	mov    %esp,%ebp
     523:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
     526:	c7 45 f8 00 00 00 00 	movl   $0x0,0xfffffff8(%ebp)
  ap = (uint*)(void*)&fmt + 1;
     52d:	8d 45 0c             	lea    0xc(%ebp),%eax
     530:	83 c0 04             	add    $0x4,%eax
     533:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
  for(i = 0; fmt[i]; i++){
     536:	c7 45 f4 00 00 00 00 	movl   $0x0,0xfffffff4(%ebp)
     53d:	e9 7b 01 00 00       	jmp    6bd <printf+0x19d>
    c = fmt[i] & 0xff;
     542:	8b 55 0c             	mov    0xc(%ebp),%edx
     545:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     548:	8d 04 02             	lea    (%edx,%eax,1),%eax
     54b:	0f b6 00             	movzbl (%eax),%eax
     54e:	0f be c0             	movsbl %al,%eax
     551:	25 ff 00 00 00       	and    $0xff,%eax
     556:	89 45 f0             	mov    %eax,0xfffffff0(%ebp)
    if(state == 0){
     559:	83 7d f8 00          	cmpl   $0x0,0xfffffff8(%ebp)
     55d:	75 2c                	jne    58b <printf+0x6b>
      if(c == '%'){
     55f:	83 7d f0 25          	cmpl   $0x25,0xfffffff0(%ebp)
     563:	75 0c                	jne    571 <printf+0x51>
        state = '%';
     565:	c7 45 f8 25 00 00 00 	movl   $0x25,0xfffffff8(%ebp)
     56c:	e9 48 01 00 00       	jmp    6b9 <printf+0x199>
      } else {
        putc(fd, c);
     571:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
     574:	0f be c0             	movsbl %al,%eax
     577:	89 44 24 04          	mov    %eax,0x4(%esp)
     57b:	8b 45 08             	mov    0x8(%ebp),%eax
     57e:	89 04 24             	mov    %eax,(%esp)
     581:	e8 aa fe ff ff       	call   430 <putc>
     586:	e9 2e 01 00 00       	jmp    6b9 <printf+0x199>
      }
    } else if(state == '%'){
     58b:	83 7d f8 25          	cmpl   $0x25,0xfffffff8(%ebp)
     58f:	0f 85 24 01 00 00    	jne    6b9 <printf+0x199>
      if(c == 'd'){
     595:	83 7d f0 64          	cmpl   $0x64,0xfffffff0(%ebp)
     599:	75 2d                	jne    5c8 <printf+0xa8>
        printint(fd, *ap, 10, 1);
     59b:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     59e:	8b 00                	mov    (%eax),%eax
     5a0:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
     5a7:	00 
     5a8:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
     5af:	00 
     5b0:	89 44 24 04          	mov    %eax,0x4(%esp)
     5b4:	8b 45 08             	mov    0x8(%ebp),%eax
     5b7:	89 04 24             	mov    %eax,(%esp)
     5ba:	e8 a1 fe ff ff       	call   460 <printint>
        ap++;
     5bf:	83 45 fc 04          	addl   $0x4,0xfffffffc(%ebp)
     5c3:	e9 ea 00 00 00       	jmp    6b2 <printf+0x192>
      } else if(c == 'x' || c == 'p'){
     5c8:	83 7d f0 78          	cmpl   $0x78,0xfffffff0(%ebp)
     5cc:	74 06                	je     5d4 <printf+0xb4>
     5ce:	83 7d f0 70          	cmpl   $0x70,0xfffffff0(%ebp)
     5d2:	75 2d                	jne    601 <printf+0xe1>
        printint(fd, *ap, 16, 0);
     5d4:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     5d7:	8b 00                	mov    (%eax),%eax
     5d9:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
     5e0:	00 
     5e1:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
     5e8:	00 
     5e9:	89 44 24 04          	mov    %eax,0x4(%esp)
     5ed:	8b 45 08             	mov    0x8(%ebp),%eax
     5f0:	89 04 24             	mov    %eax,(%esp)
     5f3:	e8 68 fe ff ff       	call   460 <printint>
        ap++;
     5f8:	83 45 fc 04          	addl   $0x4,0xfffffffc(%ebp)
     5fc:	e9 b1 00 00 00       	jmp    6b2 <printf+0x192>
      } else if(c == 's'){
     601:	83 7d f0 73          	cmpl   $0x73,0xfffffff0(%ebp)
     605:	75 43                	jne    64a <printf+0x12a>
        s = (char*)*ap;
     607:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     60a:	8b 00                	mov    (%eax),%eax
     60c:	89 45 ec             	mov    %eax,0xffffffec(%ebp)
        ap++;
     60f:	83 45 fc 04          	addl   $0x4,0xfffffffc(%ebp)
        if(s == 0)
     613:	83 7d ec 00          	cmpl   $0x0,0xffffffec(%ebp)
     617:	75 25                	jne    63e <printf+0x11e>
          s = "(null)";
     619:	c7 45 ec ad 10 00 00 	movl   $0x10ad,0xffffffec(%ebp)
        while(*s != 0){
     620:	eb 1c                	jmp    63e <printf+0x11e>
          putc(fd, *s);
     622:	8b 45 ec             	mov    0xffffffec(%ebp),%eax
     625:	0f b6 00             	movzbl (%eax),%eax
     628:	0f be c0             	movsbl %al,%eax
     62b:	89 44 24 04          	mov    %eax,0x4(%esp)
     62f:	8b 45 08             	mov    0x8(%ebp),%eax
     632:	89 04 24             	mov    %eax,(%esp)
     635:	e8 f6 fd ff ff       	call   430 <putc>
          s++;
     63a:	83 45 ec 01          	addl   $0x1,0xffffffec(%ebp)
     63e:	8b 45 ec             	mov    0xffffffec(%ebp),%eax
     641:	0f b6 00             	movzbl (%eax),%eax
     644:	84 c0                	test   %al,%al
     646:	75 da                	jne    622 <printf+0x102>
     648:	eb 68                	jmp    6b2 <printf+0x192>
        }
      } else if(c == 'c'){
     64a:	83 7d f0 63          	cmpl   $0x63,0xfffffff0(%ebp)
     64e:	75 1d                	jne    66d <printf+0x14d>
        putc(fd, *ap);
     650:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     653:	8b 00                	mov    (%eax),%eax
     655:	0f be c0             	movsbl %al,%eax
     658:	89 44 24 04          	mov    %eax,0x4(%esp)
     65c:	8b 45 08             	mov    0x8(%ebp),%eax
     65f:	89 04 24             	mov    %eax,(%esp)
     662:	e8 c9 fd ff ff       	call   430 <putc>
        ap++;
     667:	83 45 fc 04          	addl   $0x4,0xfffffffc(%ebp)
     66b:	eb 45                	jmp    6b2 <printf+0x192>
      } else if(c == '%'){
     66d:	83 7d f0 25          	cmpl   $0x25,0xfffffff0(%ebp)
     671:	75 17                	jne    68a <printf+0x16a>
        putc(fd, c);
     673:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
     676:	0f be c0             	movsbl %al,%eax
     679:	89 44 24 04          	mov    %eax,0x4(%esp)
     67d:	8b 45 08             	mov    0x8(%ebp),%eax
     680:	89 04 24             	mov    %eax,(%esp)
     683:	e8 a8 fd ff ff       	call   430 <putc>
     688:	eb 28                	jmp    6b2 <printf+0x192>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     68a:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
     691:	00 
     692:	8b 45 08             	mov    0x8(%ebp),%eax
     695:	89 04 24             	mov    %eax,(%esp)
     698:	e8 93 fd ff ff       	call   430 <putc>
        putc(fd, c);
     69d:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
     6a0:	0f be c0             	movsbl %al,%eax
     6a3:	89 44 24 04          	mov    %eax,0x4(%esp)
     6a7:	8b 45 08             	mov    0x8(%ebp),%eax
     6aa:	89 04 24             	mov    %eax,(%esp)
     6ad:	e8 7e fd ff ff       	call   430 <putc>
      }
      state = 0;
     6b2:	c7 45 f8 00 00 00 00 	movl   $0x0,0xfffffff8(%ebp)
     6b9:	83 45 f4 01          	addl   $0x1,0xfffffff4(%ebp)
     6bd:	8b 55 0c             	mov    0xc(%ebp),%edx
     6c0:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     6c3:	8d 04 02             	lea    (%edx,%eax,1),%eax
     6c6:	0f b6 00             	movzbl (%eax),%eax
     6c9:	84 c0                	test   %al,%al
     6cb:	0f 85 71 fe ff ff    	jne    542 <printf+0x22>
    }
  }
}
     6d1:	c9                   	leave  
     6d2:	c3                   	ret    
     6d3:	90                   	nop    
     6d4:	90                   	nop    
     6d5:	90                   	nop    
     6d6:	90                   	nop    
     6d7:	90                   	nop    
     6d8:	90                   	nop    
     6d9:	90                   	nop    
     6da:	90                   	nop    
     6db:	90                   	nop    
     6dc:	90                   	nop    
     6dd:	90                   	nop    
     6de:	90                   	nop    
     6df:	90                   	nop    

000006e0 <free>:
static Header *freep;

void
free(void *ap)
{
     6e0:	55                   	push   %ebp
     6e1:	89 e5                	mov    %esp,%ebp
     6e3:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*) ap - 1;
     6e6:	8b 45 08             	mov    0x8(%ebp),%eax
     6e9:	83 e8 08             	sub    $0x8,%eax
     6ec:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     6ef:	a1 e4 10 00 00       	mov    0x10e4,%eax
     6f4:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
     6f7:	eb 24                	jmp    71d <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     6f9:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     6fc:	8b 00                	mov    (%eax),%eax
     6fe:	3b 45 fc             	cmp    0xfffffffc(%ebp),%eax
     701:	77 12                	ja     715 <free+0x35>
     703:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     706:	3b 45 fc             	cmp    0xfffffffc(%ebp),%eax
     709:	77 24                	ja     72f <free+0x4f>
     70b:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     70e:	8b 00                	mov    (%eax),%eax
     710:	3b 45 f8             	cmp    0xfffffff8(%ebp),%eax
     713:	77 1a                	ja     72f <free+0x4f>
     715:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     718:	8b 00                	mov    (%eax),%eax
     71a:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
     71d:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     720:	3b 45 fc             	cmp    0xfffffffc(%ebp),%eax
     723:	76 d4                	jbe    6f9 <free+0x19>
     725:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     728:	8b 00                	mov    (%eax),%eax
     72a:	3b 45 f8             	cmp    0xfffffff8(%ebp),%eax
     72d:	76 ca                	jbe    6f9 <free+0x19>
      break;
  if(bp + bp->s.size == p->s.ptr){
     72f:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     732:	8b 40 04             	mov    0x4(%eax),%eax
     735:	c1 e0 03             	shl    $0x3,%eax
     738:	89 c2                	mov    %eax,%edx
     73a:	03 55 f8             	add    0xfffffff8(%ebp),%edx
     73d:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     740:	8b 00                	mov    (%eax),%eax
     742:	39 c2                	cmp    %eax,%edx
     744:	75 24                	jne    76a <free+0x8a>
    bp->s.size += p->s.ptr->s.size;
     746:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     749:	8b 50 04             	mov    0x4(%eax),%edx
     74c:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     74f:	8b 00                	mov    (%eax),%eax
     751:	8b 40 04             	mov    0x4(%eax),%eax
     754:	01 c2                	add    %eax,%edx
     756:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     759:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
     75c:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     75f:	8b 00                	mov    (%eax),%eax
     761:	8b 10                	mov    (%eax),%edx
     763:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     766:	89 10                	mov    %edx,(%eax)
     768:	eb 0a                	jmp    774 <free+0x94>
  } else
    bp->s.ptr = p->s.ptr;
     76a:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     76d:	8b 10                	mov    (%eax),%edx
     76f:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     772:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
     774:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     777:	8b 40 04             	mov    0x4(%eax),%eax
     77a:	c1 e0 03             	shl    $0x3,%eax
     77d:	03 45 fc             	add    0xfffffffc(%ebp),%eax
     780:	3b 45 f8             	cmp    0xfffffff8(%ebp),%eax
     783:	75 20                	jne    7a5 <free+0xc5>
    p->s.size += bp->s.size;
     785:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     788:	8b 50 04             	mov    0x4(%eax),%edx
     78b:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     78e:	8b 40 04             	mov    0x4(%eax),%eax
     791:	01 c2                	add    %eax,%edx
     793:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     796:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
     799:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     79c:	8b 10                	mov    (%eax),%edx
     79e:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     7a1:	89 10                	mov    %edx,(%eax)
     7a3:	eb 08                	jmp    7ad <free+0xcd>
  } else
    p->s.ptr = bp;
     7a5:	8b 55 fc             	mov    0xfffffffc(%ebp),%edx
     7a8:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     7ab:	89 02                	mov    %eax,(%edx)
  freep = p;
     7ad:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     7b0:	a3 e4 10 00 00       	mov    %eax,0x10e4
}
     7b5:	c9                   	leave  
     7b6:	c3                   	ret    
     7b7:	89 f6                	mov    %esi,%esi
     7b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

000007c0 <morecore>:

static Header*
morecore(uint nu)
{
     7c0:	55                   	push   %ebp
     7c1:	89 e5                	mov    %esp,%ebp
     7c3:	83 ec 18             	sub    $0x18,%esp
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
     7c6:	8b 45 08             	mov    0x8(%ebp),%eax
     7c9:	c1 e0 03             	shl    $0x3,%eax
     7cc:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
  size += PAGE - size % PAGE;
     7cf:	8b 55 fc             	mov    0xfffffffc(%ebp),%edx
     7d2:	89 d0                	mov    %edx,%eax
     7d4:	c1 f8 1f             	sar    $0x1f,%eax
     7d7:	89 c1                	mov    %eax,%ecx
     7d9:	c1 e9 14             	shr    $0x14,%ecx
     7dc:	8d 04 0a             	lea    (%edx,%ecx,1),%eax
     7df:	25 ff 0f 00 00       	and    $0xfff,%eax
     7e4:	29 c8                	sub    %ecx,%eax
     7e6:	89 c2                	mov    %eax,%edx
     7e8:	b8 00 10 00 00       	mov    $0x1000,%eax
     7ed:	29 d0                	sub    %edx,%eax
     7ef:	01 45 fc             	add    %eax,0xfffffffc(%ebp)
#endif
#ifdef UMALLOC_DEBUG
  printf(1, "size: %d\n", size);
#endif
  p = sbrk(size);
     7f2:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     7f5:	89 04 24             	mov    %eax,(%esp)
     7f8:	e8 9f fb ff ff       	call   39c <sbrk>
     7fd:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
  if(p == (char*) -1)
     800:	83 7d f4 ff          	cmpl   $0xffffffff,0xfffffff4(%ebp)
     804:	75 09                	jne    80f <morecore+0x4f>
    return 0;
     806:	c7 45 ec 00 00 00 00 	movl   $0x0,0xffffffec(%ebp)
     80d:	eb 2a                	jmp    839 <morecore+0x79>
  hp = (Header*)p;
     80f:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     812:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
#ifdef UMALLOC_NOALIGN
  hp->s.size = nu;
#else
  hp->s.size = size / sizeof(Header);
     815:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     818:	89 c2                	mov    %eax,%edx
     81a:	c1 ea 03             	shr    $0x3,%edx
     81d:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     820:	89 50 04             	mov    %edx,0x4(%eax)
#endif
  free((void*)(hp + 1));
     823:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     826:	83 c0 08             	add    $0x8,%eax
     829:	89 04 24             	mov    %eax,(%esp)
     82c:	e8 af fe ff ff       	call   6e0 <free>
  return freep;
     831:	a1 e4 10 00 00       	mov    0x10e4,%eax
     836:	89 45 ec             	mov    %eax,0xffffffec(%ebp)
     839:	8b 45 ec             	mov    0xffffffec(%ebp),%eax
}
     83c:	c9                   	leave  
     83d:	c3                   	ret    
     83e:	89 f6                	mov    %esi,%esi

00000840 <malloc>:

void*
malloc(uint nbytes)
{
     840:	55                   	push   %ebp
     841:	89 e5                	mov    %esp,%ebp
     843:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

#ifdef UMALLOC_DEBUG
  printf(1, "malloc: %d bytes\n", nbytes);
  printf(1, "size of Header: %d\n", sizeof(Header));
#endif
  if (PAGE % sizeof(Header))
      printf(2, "Warning! align failed! Need UMALLOC_NOALIGN\n");
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     846:	8b 45 08             	mov    0x8(%ebp),%eax
     849:	83 c0 07             	add    $0x7,%eax
     84c:	c1 e8 03             	shr    $0x3,%eax
     84f:	83 c0 01             	add    $0x1,%eax
     852:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
  if((prevp = freep) == 0){
     855:	a1 e4 10 00 00       	mov    0x10e4,%eax
     85a:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
     85d:	83 7d f8 00          	cmpl   $0x0,0xfffffff8(%ebp)
     861:	75 23                	jne    886 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
     863:	c7 45 f8 dc 10 00 00 	movl   $0x10dc,0xfffffff8(%ebp)
     86a:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     86d:	a3 e4 10 00 00       	mov    %eax,0x10e4
     872:	a1 e4 10 00 00       	mov    0x10e4,%eax
     877:	a3 dc 10 00 00       	mov    %eax,0x10dc
    base.s.size = 0;
     87c:	c7 05 e0 10 00 00 00 	movl   $0x0,0x10e0
     883:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     886:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     889:	8b 00                	mov    (%eax),%eax
     88b:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
    if(p->s.size >= nunits){
     88e:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     891:	8b 40 04             	mov    0x4(%eax),%eax
     894:	3b 45 fc             	cmp    0xfffffffc(%ebp),%eax
     897:	72 50                	jb     8e9 <malloc+0xa9>
      if(p->s.size == nunits)
     899:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     89c:	8b 40 04             	mov    0x4(%eax),%eax
     89f:	3b 45 fc             	cmp    0xfffffffc(%ebp),%eax
     8a2:	75 0c                	jne    8b0 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
     8a4:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     8a7:	8b 10                	mov    (%eax),%edx
     8a9:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     8ac:	89 10                	mov    %edx,(%eax)
     8ae:	eb 26                	jmp    8d6 <malloc+0x96>
      else {
        p->s.size -= nunits;
     8b0:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     8b3:	8b 40 04             	mov    0x4(%eax),%eax
     8b6:	89 c2                	mov    %eax,%edx
     8b8:	2b 55 fc             	sub    0xfffffffc(%ebp),%edx
     8bb:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     8be:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
     8c1:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     8c4:	8b 40 04             	mov    0x4(%eax),%eax
     8c7:	c1 e0 03             	shl    $0x3,%eax
     8ca:	01 45 f4             	add    %eax,0xfffffff4(%ebp)
        p->s.size = nunits;
     8cd:	8b 55 f4             	mov    0xfffffff4(%ebp),%edx
     8d0:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     8d3:	89 42 04             	mov    %eax,0x4(%edx)
      }
      freep = prevp;
     8d6:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     8d9:	a3 e4 10 00 00       	mov    %eax,0x10e4
      return (void*) (p + 1);
     8de:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     8e1:	83 c0 08             	add    $0x8,%eax
     8e4:	89 45 ec             	mov    %eax,0xffffffec(%ebp)
     8e7:	eb 3a                	jmp    923 <malloc+0xe3>
    }
    if(p == freep)
     8e9:	a1 e4 10 00 00       	mov    0x10e4,%eax
     8ee:	39 45 f4             	cmp    %eax,0xfffffff4(%ebp)
     8f1:	75 1d                	jne    910 <malloc+0xd0>
      if((p = morecore(nunits)) == 0)
     8f3:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     8f6:	89 04 24             	mov    %eax,(%esp)
     8f9:	e8 c2 fe ff ff       	call   7c0 <morecore>
     8fe:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
     901:	83 7d f4 00          	cmpl   $0x0,0xfffffff4(%ebp)
     905:	75 09                	jne    910 <malloc+0xd0>
        return 0;
     907:	c7 45 ec 00 00 00 00 	movl   $0x0,0xffffffec(%ebp)
     90e:	eb 13                	jmp    923 <malloc+0xe3>
     910:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     913:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
     916:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     919:	8b 00                	mov    (%eax),%eax
     91b:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
  }
     91e:	e9 6b ff ff ff       	jmp    88e <malloc+0x4e>
     923:	8b 45 ec             	mov    0xffffffec(%ebp),%eax
}
     926:	c9                   	leave  
     927:	c3                   	ret    
     928:	90                   	nop    
     929:	90                   	nop    
     92a:	90                   	nop    
     92b:	90                   	nop    
     92c:	90                   	nop    
     92d:	90                   	nop    
     92e:	90                   	nop    
     92f:	90                   	nop    

00000930 <lwip_chksum>:


static u16_t
lwip_chksum(void *dataptr, int len)
{
     930:	55                   	push   %ebp
     931:	89 e5                	mov    %esp,%ebp
     933:	83 ec 18             	sub    $0x18,%esp
  u32_t acc;

  LWIP_DEBUGF(INET_DEBUG, ("lwip_chksum(%p, %d)\n", (void *)dataptr, len));
  for(acc = 0; len > 1; len -= 2) {
     936:	c7 45 fc 00 00 00 00 	movl   $0x0,0xfffffffc(%ebp)
     93d:	eb 19                	jmp    958 <lwip_chksum+0x28>
      /*    acc = acc + *((u16_t *)dataptr)++;*/
    acc += *(u16_t *)dataptr;
     93f:	8b 45 08             	mov    0x8(%ebp),%eax
     942:	0f b7 00             	movzwl (%eax),%eax
     945:	0f b7 c0             	movzwl %ax,%eax
     948:	01 45 fc             	add    %eax,0xfffffffc(%ebp)
    dataptr = (void *)((u16_t *)dataptr + 1);
     94b:	8b 45 08             	mov    0x8(%ebp),%eax
     94e:	83 c0 02             	add    $0x2,%eax
     951:	89 45 08             	mov    %eax,0x8(%ebp)
     954:	83 6d 0c 02          	subl   $0x2,0xc(%ebp)
     958:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
     95c:	7f e1                	jg     93f <lwip_chksum+0xf>
  }

  /* add up any odd byte */
  if (len == 1) {
     95e:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
     962:	75 1d                	jne    981 <lwip_chksum+0x51>
    acc += htons((u16_t)((*(u8_t *)dataptr) & 0xff) << 8);
     964:	8b 45 08             	mov    0x8(%ebp),%eax
     967:	0f b6 00             	movzbl (%eax),%eax
     96a:	0f b6 c0             	movzbl %al,%eax
     96d:	c1 e0 08             	shl    $0x8,%eax
     970:	0f b7 c0             	movzwl %ax,%eax
     973:	89 04 24             	mov    %eax,(%esp)
     976:	e8 85 06 00 00       	call   1000 <htons>
     97b:	0f b7 c0             	movzwl %ax,%eax
     97e:	01 45 fc             	add    %eax,0xfffffffc(%ebp)
    LWIP_DEBUGF(INET_DEBUG, ("inet: chksum: odd byte %d\n", (unsigned int)(*(u8_t *)dataptr)));
  } else {
    LWIP_DEBUGF(INET_DEBUG, ("inet: chksum: no odd byte\n"));
  }
  acc = (acc >> 16) + (acc & 0xffffUL);
     981:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     984:	89 c2                	mov    %eax,%edx
     986:	c1 ea 10             	shr    $0x10,%edx
     989:	0f b7 45 fc          	movzwl 0xfffffffc(%ebp),%eax
     98d:	8d 04 02             	lea    (%edx,%eax,1),%eax
     990:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)

  if ((acc & 0xffff0000) != 0) {
     993:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     996:	66 b8 00 00          	mov    $0x0,%ax
     99a:	85 c0                	test   %eax,%eax
     99c:	74 12                	je     9b0 <lwip_chksum+0x80>
    acc = (acc >> 16) + (acc & 0xffffUL);
     99e:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     9a1:	89 c2                	mov    %eax,%edx
     9a3:	c1 ea 10             	shr    $0x10,%edx
     9a6:	0f b7 45 fc          	movzwl 0xfffffffc(%ebp),%eax
     9aa:	8d 04 02             	lea    (%edx,%eax,1),%eax
     9ad:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
  }

  return (u16_t)acc;
     9b0:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     9b3:	0f b7 c0             	movzwl %ax,%eax
}
     9b6:	c9                   	leave  
     9b7:	c3                   	ret    
     9b8:	90                   	nop    
     9b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi

000009c0 <inet_chksum_pseudo>:

/* inet_chksum_pseudo:
 *
 * Calculates the pseudo Internet checksum used by TCP and UDP for a pbuf chain.
 */

u16_t
inet_chksum_pseudo(struct pbuf *p,
       struct ip_addr *src, struct ip_addr *dest,
       u8_t proto, u16_t proto_len)
{
     9c0:	55                   	push   %ebp
     9c1:	89 e5                	mov    %esp,%ebp
     9c3:	83 ec 28             	sub    $0x28,%esp
     9c6:	8b 45 14             	mov    0x14(%ebp),%eax
     9c9:	8b 55 18             	mov    0x18(%ebp),%edx
     9cc:	88 45 ec             	mov    %al,0xffffffec(%ebp)
     9cf:	66 89 55 e8          	mov    %dx,0xffffffe8(%ebp)
  u32_t acc;
  struct pbuf *q;
  u8_t swapped;

  acc = 0;
     9d3:	c7 45 f4 00 00 00 00 	movl   $0x0,0xfffffff4(%ebp)
  swapped = 0;
     9da:	c6 45 ff 00          	movb   $0x0,0xffffffff(%ebp)
  /* iterate through all pbuf in chain */
  for(q = p; q != NULL; q = q->next) {
     9de:	8b 45 08             	mov    0x8(%ebp),%eax
     9e1:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
     9e4:	eb 7b                	jmp    a61 <inet_chksum_pseudo+0xa1>
    LWIP_DEBUGF(INET_DEBUG, ("inet_chksum_pseudo(): checksumming pbuf %p (has next %p) \n",
      (void *)q, (void *)q->next));
    acc += lwip_chksum(q->payload, q->len);
     9e6:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     9e9:	0f b7 40 0a          	movzwl 0xa(%eax),%eax
     9ed:	0f b7 d0             	movzwl %ax,%edx
     9f0:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     9f3:	8b 40 04             	mov    0x4(%eax),%eax
     9f6:	89 54 24 04          	mov    %edx,0x4(%esp)
     9fa:	89 04 24             	mov    %eax,(%esp)
     9fd:	e8 2e ff ff ff       	call   930 <lwip_chksum>
     a02:	0f b7 c0             	movzwl %ax,%eax
     a05:	01 45 f4             	add    %eax,0xfffffff4(%ebp)
    /*LWIP_DEBUGF(INET_DEBUG, ("inet_chksum_pseudo(): unwrapped lwip_chksum()=%lx \n", acc));*/
    while (acc >> 16) {
     a08:	eb 10                	jmp    a1a <inet_chksum_pseudo+0x5a>
      acc = (acc & 0xffffUL) + (acc >> 16);
     a0a:	0f b7 55 f4          	movzwl 0xfffffff4(%ebp),%edx
     a0e:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     a11:	c1 e8 10             	shr    $0x10,%eax
     a14:	8d 04 02             	lea    (%edx,%eax,1),%eax
     a17:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
     a1a:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     a1d:	c1 e8 10             	shr    $0x10,%eax
     a20:	85 c0                	test   %eax,%eax
     a22:	75 e6                	jne    a0a <inet_chksum_pseudo+0x4a>
    }
    if (q->len % 2 != 0) {
     a24:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     a27:	0f b7 40 0a          	movzwl 0xa(%eax),%eax
     a2b:	0f b7 c0             	movzwl %ax,%eax
     a2e:	83 e0 01             	and    $0x1,%eax
     a31:	84 c0                	test   %al,%al
     a33:	74 24                	je     a59 <inet_chksum_pseudo+0x99>
      swapped = 1 - swapped;
     a35:	b8 01 00 00 00       	mov    $0x1,%eax
     a3a:	2a 45 ff             	sub    0xffffffff(%ebp),%al
     a3d:	88 45 ff             	mov    %al,0xffffffff(%ebp)
      acc = ((acc & 0xff) << 8) | ((acc & 0xff00UL) >> 8);
     a40:	0f b6 45 f4          	movzbl 0xfffffff4(%ebp),%eax
     a44:	89 c2                	mov    %eax,%edx
     a46:	c1 e2 08             	shl    $0x8,%edx
     a49:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     a4c:	25 00 ff 00 00       	and    $0xff00,%eax
     a51:	c1 e8 08             	shr    $0x8,%eax
     a54:	09 d0                	or     %edx,%eax
     a56:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
     a59:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     a5c:	8b 00                	mov    (%eax),%eax
     a5e:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
     a61:	83 7d f8 00          	cmpl   $0x0,0xfffffff8(%ebp)
     a65:	0f 85 7b ff ff ff    	jne    9e6 <inet_chksum_pseudo+0x26>
    }
    /*LWIP_DEBUGF(INET_DEBUG, ("inet_chksum_pseudo(): wrapped lwip_chksum()=%lx \n", acc));*/
  }

  if (swapped) {
     a6b:	80 7d ff 00          	cmpb   $0x0,0xffffffff(%ebp)
     a6f:	74 19                	je     a8a <inet_chksum_pseudo+0xca>
    acc = ((acc & 0xff) << 8) | ((acc & 0xff00UL) >> 8);
     a71:	0f b6 45 f4          	movzbl 0xfffffff4(%ebp),%eax
     a75:	89 c2                	mov    %eax,%edx
     a77:	c1 e2 08             	shl    $0x8,%edx
     a7a:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     a7d:	25 00 ff 00 00       	and    $0xff00,%eax
     a82:	c1 e8 08             	shr    $0x8,%eax
     a85:	09 d0                	or     %edx,%eax
     a87:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
  }
  acc += (src->addr & 0xffffUL);
     a8a:	8b 45 0c             	mov    0xc(%ebp),%eax
     a8d:	8b 00                	mov    (%eax),%eax
     a8f:	25 ff ff 00 00       	and    $0xffff,%eax
     a94:	01 45 f4             	add    %eax,0xfffffff4(%ebp)
  acc += ((src->addr >> 16) & 0xffffUL);
     a97:	8b 45 0c             	mov    0xc(%ebp),%eax
     a9a:	8b 00                	mov    (%eax),%eax
     a9c:	c1 e8 10             	shr    $0x10,%eax
     a9f:	25 ff ff 00 00       	and    $0xffff,%eax
     aa4:	01 45 f4             	add    %eax,0xfffffff4(%ebp)
  acc += (dest->addr & 0xffffUL);
     aa7:	8b 45 10             	mov    0x10(%ebp),%eax
     aaa:	8b 00                	mov    (%eax),%eax
     aac:	25 ff ff 00 00       	and    $0xffff,%eax
     ab1:	01 45 f4             	add    %eax,0xfffffff4(%ebp)
  acc += ((dest->addr >> 16) & 0xffffUL);
     ab4:	8b 45 10             	mov    0x10(%ebp),%eax
     ab7:	8b 00                	mov    (%eax),%eax
     ab9:	c1 e8 10             	shr    $0x10,%eax
     abc:	25 ff ff 00 00       	and    $0xffff,%eax
     ac1:	01 45 f4             	add    %eax,0xfffffff4(%ebp)
  acc += (u32_t)htons((u16_t)proto);
     ac4:	0f b6 45 ec          	movzbl 0xffffffec(%ebp),%eax
     ac8:	89 04 24             	mov    %eax,(%esp)
     acb:	e8 30 05 00 00       	call   1000 <htons>
     ad0:	0f b7 c0             	movzwl %ax,%eax
     ad3:	01 45 f4             	add    %eax,0xfffffff4(%ebp)
  acc += (u32_t)htons(proto_len);
     ad6:	0f b7 45 e8          	movzwl 0xffffffe8(%ebp),%eax
     ada:	89 04 24             	mov    %eax,(%esp)
     add:	e8 1e 05 00 00       	call   1000 <htons>
     ae2:	0f b7 c0             	movzwl %ax,%eax
     ae5:	01 45 f4             	add    %eax,0xfffffff4(%ebp)

  while (acc >> 16) {
     ae8:	eb 10                	jmp    afa <inet_chksum_pseudo+0x13a>
    acc = (acc & 0xffffUL) + (acc >> 16);
     aea:	0f b7 55 f4          	movzwl 0xfffffff4(%ebp),%edx
     aee:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     af1:	c1 e8 10             	shr    $0x10,%eax
     af4:	8d 04 02             	lea    (%edx,%eax,1),%eax
     af7:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
     afa:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     afd:	c1 e8 10             	shr    $0x10,%eax
     b00:	85 c0                	test   %eax,%eax
     b02:	75 e6                	jne    aea <inet_chksum_pseudo+0x12a>
  }
  LWIP_DEBUGF(INET_DEBUG, ("inet_chksum_pseudo(): pbuf chain lwip_chksum()=%lx\n", acc));
  return ~(acc & 0xffffUL);
     b04:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     b07:	f7 d0                	not    %eax
     b09:	0f b7 c0             	movzwl %ax,%eax
}
     b0c:	c9                   	leave  
     b0d:	c3                   	ret    
     b0e:	89 f6                	mov    %esi,%esi

00000b10 <inet_chksum>:

/* inet_chksum:
 *
 * Calculates the Internet checksum over a portion of memory. Used primarely for IP
 * and ICMP.
 */

u16_t
inet_chksum(void *dataptr, u16_t len)
{
     b10:	55                   	push   %ebp
     b11:	89 e5                	mov    %esp,%ebp
     b13:	83 ec 28             	sub    $0x28,%esp
     b16:	8b 45 0c             	mov    0xc(%ebp),%eax
     b19:	66 89 45 ec          	mov    %ax,0xffffffec(%ebp)
  u32_t acc;

  acc = lwip_chksum(dataptr, len);
     b1d:	0f b7 45 ec          	movzwl 0xffffffec(%ebp),%eax
     b21:	89 44 24 04          	mov    %eax,0x4(%esp)
     b25:	8b 45 08             	mov    0x8(%ebp),%eax
     b28:	89 04 24             	mov    %eax,(%esp)
     b2b:	e8 00 fe ff ff       	call   930 <lwip_chksum>
     b30:	0f b7 c0             	movzwl %ax,%eax
     b33:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
  while (acc >> 16) {
     b36:	eb 10                	jmp    b48 <inet_chksum+0x38>
    acc = (acc & 0xffff) + (acc >> 16);
     b38:	0f b7 55 fc          	movzwl 0xfffffffc(%ebp),%edx
     b3c:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     b3f:	c1 e8 10             	shr    $0x10,%eax
     b42:	8d 04 02             	lea    (%edx,%eax,1),%eax
     b45:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
     b48:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     b4b:	c1 e8 10             	shr    $0x10,%eax
     b4e:	85 c0                	test   %eax,%eax
     b50:	75 e6                	jne    b38 <inet_chksum+0x28>
  }
  return ~(acc & 0xffff);
     b52:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     b55:	f7 d0                	not    %eax
     b57:	0f b7 c0             	movzwl %ax,%eax
}
     b5a:	c9                   	leave  
     b5b:	c3                   	ret    
     b5c:	8d 74 26 00          	lea    0x0(%esi),%esi

00000b60 <inet_chksum_pbuf>:

u16_t
inet_chksum_pbuf(struct pbuf *p)
{
     b60:	55                   	push   %ebp
     b61:	89 e5                	mov    %esp,%ebp
     b63:	83 ec 18             	sub    $0x18,%esp
  u32_t acc;
  struct pbuf *q;
  u8_t swapped;

  acc = 0;
     b66:	c7 45 f4 00 00 00 00 	movl   $0x0,0xfffffff4(%ebp)
  swapped = 0;
     b6d:	c6 45 ff 00          	movb   $0x0,0xffffffff(%ebp)
  for(q = p; q != NULL; q = q->next) {
     b71:	8b 45 08             	mov    0x8(%ebp),%eax
     b74:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
     b77:	eb 69                	jmp    be2 <inet_chksum_pbuf+0x82>
    acc += lwip_chksum(q->payload, q->len);
     b79:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     b7c:	0f b7 40 0a          	movzwl 0xa(%eax),%eax
     b80:	0f b7 d0             	movzwl %ax,%edx
     b83:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     b86:	8b 40 04             	mov    0x4(%eax),%eax
     b89:	89 54 24 04          	mov    %edx,0x4(%esp)
     b8d:	89 04 24             	mov    %eax,(%esp)
     b90:	e8 9b fd ff ff       	call   930 <lwip_chksum>
     b95:	0f b7 c0             	movzwl %ax,%eax
     b98:	01 45 f4             	add    %eax,0xfffffff4(%ebp)
    while (acc >> 16) {
     b9b:	eb 10                	jmp    bad <inet_chksum_pbuf+0x4d>
      acc = (acc & 0xffffUL) + (acc >> 16);
     b9d:	0f b7 55 f4          	movzwl 0xfffffff4(%ebp),%edx
     ba1:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     ba4:	c1 e8 10             	shr    $0x10,%eax
     ba7:	8d 04 02             	lea    (%edx,%eax,1),%eax
     baa:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
     bad:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     bb0:	c1 e8 10             	shr    $0x10,%eax
     bb3:	85 c0                	test   %eax,%eax
     bb5:	75 e6                	jne    b9d <inet_chksum_pbuf+0x3d>
    }
    if (q->len % 2 != 0) {
     bb7:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     bba:	0f b7 40 0a          	movzwl 0xa(%eax),%eax
     bbe:	0f b7 c0             	movzwl %ax,%eax
     bc1:	83 e0 01             	and    $0x1,%eax
     bc4:	84 c0                	test   %al,%al
     bc6:	74 12                	je     bda <inet_chksum_pbuf+0x7a>
      swapped = 1 - swapped;
     bc8:	b8 01 00 00 00       	mov    $0x1,%eax
     bcd:	2a 45 ff             	sub    0xffffffff(%ebp),%al
     bd0:	88 45 ff             	mov    %al,0xffffffff(%ebp)
      acc = (acc & 0x00ffUL << 8) | (acc & 0xff00UL >> 8);
     bd3:	81 65 f4 ff ff 00 00 	andl   $0xffff,0xfffffff4(%ebp)
     bda:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     bdd:	8b 00                	mov    (%eax),%eax
     bdf:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
     be2:	83 7d f8 00          	cmpl   $0x0,0xfffffff8(%ebp)
     be6:	75 91                	jne    b79 <inet_chksum_pbuf+0x19>
    }
  }

  if (swapped) {
     be8:	80 7d ff 00          	cmpb   $0x0,0xffffffff(%ebp)
     bec:	74 19                	je     c07 <inet_chksum_pbuf+0xa7>
    acc = ((acc & 0x00ffUL) << 8) | ((acc & 0xff00UL) >> 8);
     bee:	0f b6 45 f4          	movzbl 0xfffffff4(%ebp),%eax
     bf2:	89 c2                	mov    %eax,%edx
     bf4:	c1 e2 08             	shl    $0x8,%edx
     bf7:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     bfa:	25 00 ff 00 00       	and    $0xff00,%eax
     bff:	c1 e8 08             	shr    $0x8,%eax
     c02:	09 d0                	or     %edx,%eax
     c04:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
  }
  return ~(acc & 0xffffUL);
     c07:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     c0a:	f7 d0                	not    %eax
     c0c:	0f b7 c0             	movzwl %ax,%eax
}
     c0f:	c9                   	leave  
     c10:	c3                   	ret    
     c11:	eb 0d                	jmp    c20 <inet_addr>
     c13:	90                   	nop    
     c14:	90                   	nop    
     c15:	90                   	nop    
     c16:	90                   	nop    
     c17:	90                   	nop    
     c18:	90                   	nop    
     c19:	90                   	nop    
     c1a:	90                   	nop    
     c1b:	90                   	nop    
     c1c:	90                   	nop    
     c1d:	90                   	nop    
     c1e:	90                   	nop    
     c1f:	90                   	nop    

00000c20 <inet_addr>:

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
     c20:	55                   	push   %ebp
     c21:	89 e5                	mov    %esp,%ebp
     c23:	83 ec 28             	sub    $0x28,%esp
     struct in_addr val;

     if (inet_aton(cp, &val)) {
     c26:	8d 45 fc             	lea    0xfffffffc(%ebp),%eax
     c29:	89 44 24 04          	mov    %eax,0x4(%esp)
     c2d:	8b 45 08             	mov    0x8(%ebp),%eax
     c30:	89 04 24             	mov    %eax,(%esp)
     c33:	e8 18 00 00 00       	call   c50 <inet_aton>
     c38:	85 c0                	test   %eax,%eax
     c3a:	74 08                	je     c44 <inet_addr+0x24>
         return (val.s_addr);
     c3c:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     c3f:	89 45 ec             	mov    %eax,0xffffffec(%ebp)
     c42:	eb 07                	jmp    c4b <inet_addr+0x2b>
     }
     return (INADDR_NONE);
     c44:	c7 45 ec ff ff ff ff 	movl   $0xffffffff,0xffffffec(%ebp)
     c4b:	8b 45 ec             	mov    0xffffffec(%ebp),%eax
 }
     c4e:	c9                   	leave  
     c4f:	c3                   	ret    

00000c50 <inet_aton>:

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
     c50:	55                   	push   %ebp
     c51:	89 e5                	mov    %esp,%ebp
     c53:	83 ec 48             	sub    $0x48,%esp
     u32_t val;
     int base, n;
     char c;
     u32_t parts[4];
     u32_t* pp = parts;
     c56:	8d 45 dc             	lea    0xffffffdc(%ebp),%eax
     c59:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)

     c = *cp;
     c5c:	8b 45 08             	mov    0x8(%ebp),%eax
     c5f:	0f b6 00             	movzbl (%eax),%eax
     c62:	88 45 fb             	mov    %al,0xfffffffb(%ebp)
     for (;;) {
         /*
          * Collect number up to ``.''.
          * Values are specified as for C:
          * 0x=hex, 0=octal, isdigit=decimal.
          */
         if (!isdigit(c))
     c65:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
     c69:	3c 2f                	cmp    $0x2f,%al
     c6b:	76 08                	jbe    c75 <inet_aton+0x25>
     c6d:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
     c71:	3c 39                	cmp    $0x39,%al
     c73:	76 0c                	jbe    c81 <inet_aton+0x31>
             return (0);
     c75:	c7 45 c0 00 00 00 00 	movl   $0x0,0xffffffc0(%ebp)
     c7c:	e9 78 02 00 00       	jmp    ef9 <inet_aton+0x2a9>
         val = 0; base = 10;
     c81:	c7 45 ec 00 00 00 00 	movl   $0x0,0xffffffec(%ebp)
     c88:	c7 45 f0 0a 00 00 00 	movl   $0xa,0xfffffff0(%ebp)
         if (c == '0') {
     c8f:	80 7d fb 30          	cmpb   $0x30,0xfffffffb(%ebp)
     c93:	75 36                	jne    ccb <inet_aton+0x7b>
             c = *++cp;
     c95:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     c99:	8b 45 08             	mov    0x8(%ebp),%eax
     c9c:	0f b6 00             	movzbl (%eax),%eax
     c9f:	88 45 fb             	mov    %al,0xfffffffb(%ebp)
             if (c == 'x' || c == 'X')
     ca2:	80 7d fb 78          	cmpb   $0x78,0xfffffffb(%ebp)
     ca6:	74 06                	je     cae <inet_aton+0x5e>
     ca8:	80 7d fb 58          	cmpb   $0x58,0xfffffffb(%ebp)
     cac:	75 16                	jne    cc4 <inet_aton+0x74>
                 base = 16, c = *++cp;
     cae:	c7 45 f0 10 00 00 00 	movl   $0x10,0xfffffff0(%ebp)
     cb5:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     cb9:	8b 45 08             	mov    0x8(%ebp),%eax
     cbc:	0f b6 00             	movzbl (%eax),%eax
     cbf:	88 45 fb             	mov    %al,0xfffffffb(%ebp)
     cc2:	eb 07                	jmp    ccb <inet_aton+0x7b>
             else
                 base = 8;
     cc4:	c7 45 f0 08 00 00 00 	movl   $0x8,0xfffffff0(%ebp)
         }
         for (;;) {
             if (isascii(c) && isdigit(c)) {
     ccb:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
     ccf:	3c 1f                	cmp    $0x1f,%al
     cd1:	76 3b                	jbe    d0e <inet_aton+0xbe>
     cd3:	80 7d fb 00          	cmpb   $0x0,0xfffffffb(%ebp)
     cd7:	78 35                	js     d0e <inet_aton+0xbe>
     cd9:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
     cdd:	3c 2f                	cmp    $0x2f,%al
     cdf:	76 2d                	jbe    d0e <inet_aton+0xbe>
     ce1:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
     ce5:	3c 39                	cmp    $0x39,%al
     ce7:	77 25                	ja     d0e <inet_aton+0xbe>
                 val = (val * base) + (c - '0');
     ce9:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
     cec:	89 c2                	mov    %eax,%edx
     cee:	0f af 55 ec          	imul   0xffffffec(%ebp),%edx
     cf2:	0f be 45 fb          	movsbl 0xfffffffb(%ebp),%eax
     cf6:	8d 04 02             	lea    (%edx,%eax,1),%eax
     cf9:	83 e8 30             	sub    $0x30,%eax
     cfc:	89 45 ec             	mov    %eax,0xffffffec(%ebp)
                 c = *++cp;
     cff:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     d03:	8b 45 08             	mov    0x8(%ebp),%eax
     d06:	0f b6 00             	movzbl (%eax),%eax
     d09:	88 45 fb             	mov    %al,0xfffffffb(%ebp)
     d0c:	eb bd                	jmp    ccb <inet_aton+0x7b>
             } else if (base == 16 && isascii(c) && isxdigit(c)) {
     d0e:	83 7d f0 10          	cmpl   $0x10,0xfffffff0(%ebp)
     d12:	0f 85 99 00 00 00    	jne    db1 <inet_aton+0x161>
     d18:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
     d1c:	3c 1f                	cmp    $0x1f,%al
     d1e:	0f 86 8d 00 00 00    	jbe    db1 <inet_aton+0x161>
     d24:	80 7d fb 00          	cmpb   $0x0,0xfffffffb(%ebp)
     d28:	0f 88 83 00 00 00    	js     db1 <inet_aton+0x161>
     d2e:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
     d32:	3c 2f                	cmp    $0x2f,%al
     d34:	76 08                	jbe    d3e <inet_aton+0xee>
     d36:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
     d3a:	3c 39                	cmp    $0x39,%al
     d3c:	76 20                	jbe    d5e <inet_aton+0x10e>
     d3e:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
     d42:	3c 60                	cmp    $0x60,%al
     d44:	76 08                	jbe    d4e <inet_aton+0xfe>
     d46:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
     d4a:	3c 66                	cmp    $0x66,%al
     d4c:	76 10                	jbe    d5e <inet_aton+0x10e>
     d4e:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
     d52:	3c 40                	cmp    $0x40,%al
     d54:	76 5b                	jbe    db1 <inet_aton+0x161>
     d56:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
     d5a:	3c 46                	cmp    $0x46,%al
     d5c:	77 53                	ja     db1 <inet_aton+0x161>
                 val = (val << 4) |
     d5e:	8b 45 ec             	mov    0xffffffec(%ebp),%eax
     d61:	89 c2                	mov    %eax,%edx
     d63:	c1 e2 04             	shl    $0x4,%edx
     d66:	89 55 c4             	mov    %edx,0xffffffc4(%ebp)
     d69:	0f be 45 fb          	movsbl 0xfffffffb(%ebp),%eax
     d6d:	83 c0 0a             	add    $0xa,%eax
     d70:	89 45 c8             	mov    %eax,0xffffffc8(%ebp)
     d73:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
     d77:	3c 60                	cmp    $0x60,%al
     d79:	76 11                	jbe    d8c <inet_aton+0x13c>
     d7b:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
     d7f:	3c 7a                	cmp    $0x7a,%al
     d81:	77 09                	ja     d8c <inet_aton+0x13c>
     d83:	c7 45 cc 61 00 00 00 	movl   $0x61,0xffffffcc(%ebp)
     d8a:	eb 07                	jmp    d93 <inet_aton+0x143>
     d8c:	c7 45 cc 41 00 00 00 	movl   $0x41,0xffffffcc(%ebp)
     d93:	8b 45 c8             	mov    0xffffffc8(%ebp),%eax
     d96:	2b 45 cc             	sub    0xffffffcc(%ebp),%eax
     d99:	0b 45 c4             	or     0xffffffc4(%ebp),%eax
     d9c:	89 45 ec             	mov    %eax,0xffffffec(%ebp)
                     (c + 10 - (islower(c) ? 'a' : 'A'));
                 c = *++cp;
     d9f:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     da3:	8b 45 08             	mov    0x8(%ebp),%eax
     da6:	0f b6 00             	movzbl (%eax),%eax
     da9:	88 45 fb             	mov    %al,0xfffffffb(%ebp)
             } else
             break;
         }
     dac:	e9 1a ff ff ff       	jmp    ccb <inet_aton+0x7b>
         if (c == '.') {
     db1:	80 7d fb 2e          	cmpb   $0x2e,0xfffffffb(%ebp)
     db5:	75 35                	jne    dec <inet_aton+0x19c>
             /*
              * Internet format:
              *  a.b.c.d
              *  a.b.c   (with c treated as 16 bits)
              *  a.b (with b treated as 24 bits)
              */
             if (pp >= parts + 3)
     db7:	8d 45 dc             	lea    0xffffffdc(%ebp),%eax
     dba:	83 c0 0c             	add    $0xc,%eax
     dbd:	3b 45 fc             	cmp    0xfffffffc(%ebp),%eax
     dc0:	77 0c                	ja     dce <inet_aton+0x17e>
                 return (0);
     dc2:	c7 45 c0 00 00 00 00 	movl   $0x0,0xffffffc0(%ebp)
     dc9:	e9 2b 01 00 00       	jmp    ef9 <inet_aton+0x2a9>
             *pp++ = val;
     dce:	8b 55 fc             	mov    0xfffffffc(%ebp),%edx
     dd1:	8b 45 ec             	mov    0xffffffec(%ebp),%eax
     dd4:	89 02                	mov    %eax,(%edx)
     dd6:	83 45 fc 04          	addl   $0x4,0xfffffffc(%ebp)
             c = *++cp;
     dda:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     dde:	8b 45 08             	mov    0x8(%ebp),%eax
     de1:	0f b6 00             	movzbl (%eax),%eax
     de4:	88 45 fb             	mov    %al,0xfffffffb(%ebp)
         } else
             break;
     }
     de7:	e9 79 fe ff ff       	jmp    c65 <inet_aton+0x15>
     /*
      * Check for trailing characters.
      */
     if (c != '\0' && (!isascii(c) || !isspace(c)))
     dec:	80 7d fb 00          	cmpb   $0x0,0xfffffffb(%ebp)
     df0:	74 3e                	je     e30 <inet_aton+0x1e0>
     df2:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
     df6:	3c 1f                	cmp    $0x1f,%al
     df8:	76 2a                	jbe    e24 <inet_aton+0x1d4>
     dfa:	80 7d fb 00          	cmpb   $0x0,0xfffffffb(%ebp)
     dfe:	78 24                	js     e24 <inet_aton+0x1d4>
     e00:	80 7d fb 20          	cmpb   $0x20,0xfffffffb(%ebp)
     e04:	74 2a                	je     e30 <inet_aton+0x1e0>
     e06:	80 7d fb 0c          	cmpb   $0xc,0xfffffffb(%ebp)
     e0a:	74 24                	je     e30 <inet_aton+0x1e0>
     e0c:	80 7d fb 0a          	cmpb   $0xa,0xfffffffb(%ebp)
     e10:	74 1e                	je     e30 <inet_aton+0x1e0>
     e12:	80 7d fb 0d          	cmpb   $0xd,0xfffffffb(%ebp)
     e16:	74 18                	je     e30 <inet_aton+0x1e0>
     e18:	80 7d fb 09          	cmpb   $0x9,0xfffffffb(%ebp)
     e1c:	74 12                	je     e30 <inet_aton+0x1e0>
     e1e:	80 7d fb 0b          	cmpb   $0xb,0xfffffffb(%ebp)
     e22:	74 0c                	je     e30 <inet_aton+0x1e0>
         return (0);
     e24:	c7 45 c0 00 00 00 00 	movl   $0x0,0xffffffc0(%ebp)
     e2b:	e9 c9 00 00 00       	jmp    ef9 <inet_aton+0x2a9>
     /*
      * Concoct the address according to
      * the number of parts specified.
      */
     n = pp - parts + 1;
     e30:	8b 55 fc             	mov    0xfffffffc(%ebp),%edx
     e33:	8d 45 dc             	lea    0xffffffdc(%ebp),%eax
     e36:	89 d1                	mov    %edx,%ecx
     e38:	29 c1                	sub    %eax,%ecx
     e3a:	89 c8                	mov    %ecx,%eax
     e3c:	c1 f8 02             	sar    $0x2,%eax
     e3f:	83 c0 01             	add    $0x1,%eax
     e42:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
     switch (n) {
     e45:	83 7d f4 04          	cmpl   $0x4,0xfffffff4(%ebp)
     e49:	0f 87 8b 00 00 00    	ja     eda <inet_aton+0x28a>
     e4f:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     e52:	c1 e0 02             	shl    $0x2,%eax
     e55:	8b 80 b4 10 00 00    	mov    0x10b4(%eax),%eax
     e5b:	ff e0                	jmp    *%eax

     case 0:
         return (0);     /* initial nondigit */
     e5d:	c7 45 c0 00 00 00 00 	movl   $0x0,0xffffffc0(%ebp)
     e64:	e9 90 00 00 00       	jmp    ef9 <inet_aton+0x2a9>

     case 1:             /* a -- 32 bits */
         break;

     case 2:             /* a.b -- 8.24 bits */
         if (val > 0xffffff)
     e69:	81 7d ec ff ff ff 00 	cmpl   $0xffffff,0xffffffec(%ebp)
     e70:	76 09                	jbe    e7b <inet_aton+0x22b>
             return (0);
     e72:	c7 45 c0 00 00 00 00 	movl   $0x0,0xffffffc0(%ebp)
     e79:	eb 7e                	jmp    ef9 <inet_aton+0x2a9>
         val |= parts[0] << 24;
     e7b:	8b 45 dc             	mov    0xffffffdc(%ebp),%eax
     e7e:	c1 e0 18             	shl    $0x18,%eax
     e81:	09 45 ec             	or     %eax,0xffffffec(%ebp)
         break;
     e84:	eb 54                	jmp    eda <inet_aton+0x28a>

     case 3:             /* a.b.c -- 8.8.16 bits */
         if (val > 0xffff)
     e86:	81 7d ec ff ff 00 00 	cmpl   $0xffff,0xffffffec(%ebp)
     e8d:	76 09                	jbe    e98 <inet_aton+0x248>
             return (0);
     e8f:	c7 45 c0 00 00 00 00 	movl   $0x0,0xffffffc0(%ebp)
     e96:	eb 61                	jmp    ef9 <inet_aton+0x2a9>
         val |= (parts[0] << 24) | (parts[1] << 16);
     e98:	8b 45 dc             	mov    0xffffffdc(%ebp),%eax
     e9b:	89 c2                	mov    %eax,%edx
     e9d:	c1 e2 18             	shl    $0x18,%edx
     ea0:	8b 45 e0             	mov    0xffffffe0(%ebp),%eax
     ea3:	c1 e0 10             	shl    $0x10,%eax
     ea6:	09 d0                	or     %edx,%eax
     ea8:	09 45 ec             	or     %eax,0xffffffec(%ebp)
         break;
     eab:	eb 2d                	jmp    eda <inet_aton+0x28a>

     case 4:             /* a.b.c.d -- 8.8.8.8 bits */
         if (val > 0xff)
     ead:	81 7d ec ff 00 00 00 	cmpl   $0xff,0xffffffec(%ebp)
     eb4:	76 09                	jbe    ebf <inet_aton+0x26f>
             return (0);
     eb6:	c7 45 c0 00 00 00 00 	movl   $0x0,0xffffffc0(%ebp)
     ebd:	eb 3a                	jmp    ef9 <inet_aton+0x2a9>
         val |= (parts[0] << 24) | (parts[1] << 16) | (parts[2] << 8);
     ebf:	8b 45 dc             	mov    0xffffffdc(%ebp),%eax
     ec2:	89 c2                	mov    %eax,%edx
     ec4:	c1 e2 18             	shl    $0x18,%edx
     ec7:	8b 45 e0             	mov    0xffffffe0(%ebp),%eax
     eca:	c1 e0 10             	shl    $0x10,%eax
     ecd:	09 c2                	or     %eax,%edx
     ecf:	8b 45 e4             	mov    0xffffffe4(%ebp),%eax
     ed2:	c1 e0 08             	shl    $0x8,%eax
     ed5:	09 d0                	or     %edx,%eax
     ed7:	09 45 ec             	or     %eax,0xffffffec(%ebp)
         break;
     }
     if (addr)
     eda:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     ede:	74 12                	je     ef2 <inet_aton+0x2a2>
         addr->s_addr = htonl(val);
     ee0:	8b 45 ec             	mov    0xffffffec(%ebp),%eax
     ee3:	89 04 24             	mov    %eax,(%esp)
     ee6:	e8 65 01 00 00       	call   1050 <htonl>
     eeb:	89 c2                	mov    %eax,%edx
     eed:	8b 45 0c             	mov    0xc(%ebp),%eax
     ef0:	89 10                	mov    %edx,(%eax)
     return (1);
     ef2:	c7 45 c0 01 00 00 00 	movl   $0x1,0xffffffc0(%ebp)
     ef9:	8b 45 c0             	mov    0xffffffc0(%ebp),%eax
 }
     efc:	c9                   	leave  
     efd:	c3                   	ret    
     efe:	89 f6                	mov    %esi,%esi

00000f00 <inet_ntoa>:

/* Convert numeric IP address into decimal dotted ASCII representation.
 * returns ptr to static buffer; not reentrant!
 */
char *inet_ntoa(struct in_addr addr)
{
     f00:	55                   	push   %ebp
     f01:	89 e5                	mov    %esp,%ebp
     f03:	53                   	push   %ebx
     f04:	83 ec 24             	sub    $0x24,%esp
  static char str[16];
  u32_t s_addr = addr.s_addr;
     f07:	8b 45 08             	mov    0x8(%ebp),%eax
     f0a:	89 45 ec             	mov    %eax,0xffffffec(%ebp)
  char inv[3];
  char *rp;
  char *ap;
  u8_t rem;
  u8_t n;
  u8_t i;

  rp = str;
     f0d:	c7 45 f0 e8 10 00 00 	movl   $0x10e8,0xfffffff0(%ebp)
  ap = (u8_t *)&s_addr;
     f14:	8d 45 ec             	lea    0xffffffec(%ebp),%eax
     f17:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
  for(n = 0; n < 4; n++) {
     f1a:	c6 45 fa 00          	movb   $0x0,0xfffffffa(%ebp)
     f1e:	e9 af 00 00 00       	jmp    fd2 <inet_ntoa+0xd2>
    i = 0;
     f23:	c6 45 fb 00          	movb   $0x0,0xfffffffb(%ebp)
    do {
      rem = *ap % (u8_t)10;
     f27:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     f2a:	0f b6 08             	movzbl (%eax),%ecx
     f2d:	b8 67 00 00 00       	mov    $0x67,%eax
     f32:	f6 e9                	imul   %cl
     f34:	66 c1 e8 08          	shr    $0x8,%ax
     f38:	89 c2                	mov    %eax,%edx
     f3a:	c0 fa 02             	sar    $0x2,%dl
     f3d:	89 c8                	mov    %ecx,%eax
     f3f:	c0 f8 07             	sar    $0x7,%al
     f42:	89 d3                	mov    %edx,%ebx
     f44:	28 c3                	sub    %al,%bl
     f46:	88 5d db             	mov    %bl,0xffffffdb(%ebp)
     f49:	0f b6 45 db          	movzbl 0xffffffdb(%ebp),%eax
     f4d:	c1 e0 02             	shl    $0x2,%eax
     f50:	02 45 db             	add    0xffffffdb(%ebp),%al
     f53:	01 c0                	add    %eax,%eax
     f55:	89 ca                	mov    %ecx,%edx
     f57:	28 c2                	sub    %al,%dl
     f59:	88 55 db             	mov    %dl,0xffffffdb(%ebp)
     f5c:	0f b6 5d db          	movzbl 0xffffffdb(%ebp),%ebx
     f60:	88 5d f9             	mov    %bl,0xfffffff9(%ebp)
      *ap /= (u8_t)10;
     f63:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     f66:	0f b6 08             	movzbl (%eax),%ecx
     f69:	b8 67 00 00 00       	mov    $0x67,%eax
     f6e:	f6 e9                	imul   %cl
     f70:	66 c1 e8 08          	shr    $0x8,%ax
     f74:	89 c2                	mov    %eax,%edx
     f76:	c0 fa 02             	sar    $0x2,%dl
     f79:	89 c8                	mov    %ecx,%eax
     f7b:	c0 f8 07             	sar    $0x7,%al
     f7e:	28 c2                	sub    %al,%dl
     f80:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     f83:	88 10                	mov    %dl,(%eax)
      inv[i++] = '0' + rem;
     f85:	0f b6 55 fb          	movzbl 0xfffffffb(%ebp),%edx
     f89:	0f b6 45 f9          	movzbl 0xfffffff9(%ebp),%eax
     f8d:	83 c0 30             	add    $0x30,%eax
     f90:	88 44 15 e9          	mov    %al,0xffffffe9(%ebp,%edx,1)
     f94:	80 45 fb 01          	addb   $0x1,0xfffffffb(%ebp)
    } while(*ap);
     f98:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     f9b:	0f b6 00             	movzbl (%eax),%eax
     f9e:	84 c0                	test   %al,%al
     fa0:	75 85                	jne    f27 <inet_ntoa+0x27>
    while(i--)
     fa2:	eb 12                	jmp    fb6 <inet_ntoa+0xb6>
      *rp++ = inv[i];
     fa4:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
     fa8:	0f b6 54 05 e9       	movzbl 0xffffffe9(%ebp,%eax,1),%edx
     fad:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
     fb0:	88 10                	mov    %dl,(%eax)
     fb2:	83 45 f0 01          	addl   $0x1,0xfffffff0(%ebp)
     fb6:	80 6d fb 01          	subb   $0x1,0xfffffffb(%ebp)
     fba:	80 7d fb ff          	cmpb   $0xff,0xfffffffb(%ebp)
     fbe:	75 e4                	jne    fa4 <inet_ntoa+0xa4>
    *rp++ = '.';
     fc0:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
     fc3:	c6 00 2e             	movb   $0x2e,(%eax)
     fc6:	83 45 f0 01          	addl   $0x1,0xfffffff0(%ebp)
    ap++;
     fca:	83 45 f4 01          	addl   $0x1,0xfffffff4(%ebp)
     fce:	80 45 fa 01          	addb   $0x1,0xfffffffa(%ebp)
     fd2:	80 7d fa 03          	cmpb   $0x3,0xfffffffa(%ebp)
     fd6:	0f 86 47 ff ff ff    	jbe    f23 <inet_ntoa+0x23>
  }
  *--rp = 0;
     fdc:	83 6d f0 01          	subl   $0x1,0xfffffff0(%ebp)
     fe0:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
     fe3:	c6 00 00             	movb   $0x0,(%eax)
  return str;
     fe6:	b8 e8 10 00 00       	mov    $0x10e8,%eax
}
     feb:	83 c4 24             	add    $0x24,%esp
     fee:	5b                   	pop    %ebx
     fef:	5d                   	pop    %ebp
     ff0:	c3                   	ret    
     ff1:	eb 0d                	jmp    1000 <htons>
     ff3:	90                   	nop    
     ff4:	90                   	nop    
     ff5:	90                   	nop    
     ff6:	90                   	nop    
     ff7:	90                   	nop    
     ff8:	90                   	nop    
     ff9:	90                   	nop    
     ffa:	90                   	nop    
     ffb:	90                   	nop    
     ffc:	90                   	nop    
     ffd:	90                   	nop    
     ffe:	90                   	nop    
     fff:	90                   	nop    

00001000 <htons>:


#ifndef BYTE_ORDER
#error BYTE_ORDER is not defined
#endif
#if BYTE_ORDER == LITTLE_ENDIAN

u16_t
htons(u16_t n)
{
    1000:	55                   	push   %ebp
    1001:	89 e5                	mov    %esp,%ebp
    1003:	83 ec 04             	sub    $0x4,%esp
    1006:	8b 45 08             	mov    0x8(%ebp),%eax
    1009:	66 89 45 fc          	mov    %ax,0xfffffffc(%ebp)
  return ((n & 0xff) << 8) | ((n & 0xff00) >> 8);
    100d:	0f b7 45 fc          	movzwl 0xfffffffc(%ebp),%eax
    1011:	25 ff 00 00 00       	and    $0xff,%eax
    1016:	c1 e0 08             	shl    $0x8,%eax
    1019:	89 c2                	mov    %eax,%edx
    101b:	0f b7 45 fc          	movzwl 0xfffffffc(%ebp),%eax
    101f:	25 00 ff 00 00       	and    $0xff00,%eax
    1024:	c1 f8 08             	sar    $0x8,%eax
    1027:	09 d0                	or     %edx,%eax
    1029:	0f b7 c0             	movzwl %ax,%eax
}
    102c:	c9                   	leave  
    102d:	c3                   	ret    
    102e:	89 f6                	mov    %esi,%esi

00001030 <ntohs>:

u16_t
ntohs(u16_t n)
{
    1030:	55                   	push   %ebp
    1031:	89 e5                	mov    %esp,%ebp
    1033:	83 ec 08             	sub    $0x8,%esp
    1036:	8b 45 08             	mov    0x8(%ebp),%eax
    1039:	66 89 45 fc          	mov    %ax,0xfffffffc(%ebp)
  return htons(n);
    103d:	0f b7 45 fc          	movzwl 0xfffffffc(%ebp),%eax
    1041:	89 04 24             	mov    %eax,(%esp)
    1044:	e8 b7 ff ff ff       	call   1000 <htons>
    1049:	0f b7 c0             	movzwl %ax,%eax
}
    104c:	c9                   	leave  
    104d:	c3                   	ret    
    104e:	89 f6                	mov    %esi,%esi

00001050 <htonl>:

u32_t
htonl(u32_t n)
{
    1050:	55                   	push   %ebp
    1051:	89 e5                	mov    %esp,%ebp
  return ((n & 0xff) << 24) |
    1053:	0f b6 45 08          	movzbl 0x8(%ebp),%eax
    1057:	89 c2                	mov    %eax,%edx
    1059:	c1 e2 18             	shl    $0x18,%edx
    105c:	8b 45 08             	mov    0x8(%ebp),%eax
    105f:	25 00 ff 00 00       	and    $0xff00,%eax
    1064:	c1 e0 08             	shl    $0x8,%eax
    1067:	09 c2                	or     %eax,%edx
    1069:	8b 45 08             	mov    0x8(%ebp),%eax
    106c:	25 00 00 ff 00       	and    $0xff0000,%eax
    1071:	c1 e8 08             	shr    $0x8,%eax
    1074:	09 c2                	or     %eax,%edx
    1076:	8b 45 08             	mov    0x8(%ebp),%eax
    1079:	25 00 00 00 ff       	and    $0xff000000,%eax
    107e:	c1 e8 18             	shr    $0x18,%eax
    1081:	09 d0                	or     %edx,%eax
    ((n & 0xff00) << 8) |
    ((n & 0xff0000) >> 8) |
    ((n & 0xff000000) >> 24);
}
    1083:	5d                   	pop    %ebp
    1084:	c3                   	ret    
    1085:	8d 74 26 00          	lea    0x0(%esi),%esi
    1089:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00001090 <ntohl>:

u32_t
ntohl(u32_t n)
{
    1090:	55                   	push   %ebp
    1091:	89 e5                	mov    %esp,%ebp
    1093:	83 ec 04             	sub    $0x4,%esp
  return htonl(n);
    1096:	8b 45 08             	mov    0x8(%ebp),%eax
    1099:	89 04 24             	mov    %eax,(%esp)
    109c:	e8 af ff ff ff       	call   1050 <htonl>
}
    10a1:	c9                   	leave  
    10a2:	c3                   	ret    
