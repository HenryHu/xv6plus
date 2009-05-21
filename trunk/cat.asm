
_cat:     file format elf32-i386-freebsd

Disassembly of section .text:

00000000 <cat>:
char buf[512];

void
cat(int fd)
{
       0:	55                   	push   %ebp
       1:	89 e5                	mov    %esp,%ebp
       3:	83 ec 28             	sub    $0x28,%esp
  int n;

  while((n = read(fd, buf, sizeof(buf))) > 0)
       6:	eb 1b                	jmp    23 <cat+0x23>
    write(1, buf, n);
       8:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
       b:	89 44 24 08          	mov    %eax,0x8(%esp)
       f:	c7 44 24 04 e0 11 00 	movl   $0x11e0,0x4(%esp)
      16:	00 
      17:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
      1e:	e8 c1 03 00 00       	call   3e4 <write>
      23:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
      2a:	00 
      2b:	c7 44 24 04 e0 11 00 	movl   $0x11e0,0x4(%esp)
      32:	00 
      33:	8b 45 08             	mov    0x8(%ebp),%eax
      36:	89 04 24             	mov    %eax,(%esp)
      39:	e8 9e 03 00 00       	call   3dc <read>
      3e:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
      41:	83 7d fc 00          	cmpl   $0x0,0xfffffffc(%ebp)
      45:	7f c1                	jg     8 <cat+0x8>
  if(n < 0){
      47:	83 7d fc 00          	cmpl   $0x0,0xfffffffc(%ebp)
      4b:	79 19                	jns    66 <cat+0x66>
    printf(1, "cat: read error\n");
      4d:	c7 44 24 04 54 11 00 	movl   $0x1154,0x4(%esp)
      54:	00 
      55:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
      5c:	e8 6f 05 00 00       	call   5d0 <printf>
    exit();
      61:	e8 5e 03 00 00       	call   3c4 <exit>
  }
}
      66:	c9                   	leave  
      67:	c3                   	ret    
      68:	90                   	nop    
      69:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi

00000070 <main>:

int
main(int argc, char *argv[])
{
      70:	8d 4c 24 04          	lea    0x4(%esp),%ecx
      74:	83 e4 f0             	and    $0xfffffff0,%esp
      77:	ff 71 fc             	pushl  0xfffffffc(%ecx)
      7a:	55                   	push   %ebp
      7b:	89 e5                	mov    %esp,%ebp
      7d:	51                   	push   %ecx
      7e:	83 ec 24             	sub    $0x24,%esp
      81:	89 4d e8             	mov    %ecx,0xffffffe8(%ebp)
  int fd, i;

  if(argc <= 1){
      84:	8b 45 e8             	mov    0xffffffe8(%ebp),%eax
      87:	83 38 01             	cmpl   $0x1,(%eax)
      8a:	7f 11                	jg     9d <main+0x2d>
    cat(0);
      8c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
      93:	e8 68 ff ff ff       	call   0 <cat>
    exit();
      98:	e8 27 03 00 00       	call   3c4 <exit>
  }

  for(i = 1; i < argc; i++){
      9d:	c7 45 f8 01 00 00 00 	movl   $0x1,0xfffffff8(%ebp)
      a4:	eb 6c                	jmp    112 <main+0xa2>
    if((fd = open(argv[i], 0)) < 0){
      a6:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
      a9:	c1 e0 02             	shl    $0x2,%eax
      ac:	8b 55 e8             	mov    0xffffffe8(%ebp),%edx
      af:	03 42 04             	add    0x4(%edx),%eax
      b2:	8b 00                	mov    (%eax),%eax
      b4:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
      bb:	00 
      bc:	89 04 24             	mov    %eax,(%esp)
      bf:	e8 40 03 00 00       	call   404 <open>
      c4:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
      c7:	83 7d f4 00          	cmpl   $0x0,0xfffffff4(%ebp)
      cb:	79 2b                	jns    f8 <main+0x88>
      printf(1, "cat: cannot open %s\n", argv[i]);
      cd:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
      d0:	c1 e0 02             	shl    $0x2,%eax
      d3:	8b 55 e8             	mov    0xffffffe8(%ebp),%edx
      d6:	03 42 04             	add    0x4(%edx),%eax
      d9:	8b 00                	mov    (%eax),%eax
      db:	89 44 24 08          	mov    %eax,0x8(%esp)
      df:	c7 44 24 04 65 11 00 	movl   $0x1165,0x4(%esp)
      e6:	00 
      e7:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
      ee:	e8 dd 04 00 00       	call   5d0 <printf>
      exit();
      f3:	e8 cc 02 00 00       	call   3c4 <exit>
    }
    cat(fd);
      f8:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
      fb:	89 04 24             	mov    %eax,(%esp)
      fe:	e8 fd fe ff ff       	call   0 <cat>
    close(fd);
     103:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     106:	89 04 24             	mov    %eax,(%esp)
     109:	e8 de 02 00 00       	call   3ec <close>
     10e:	83 45 f8 01          	addl   $0x1,0xfffffff8(%ebp)
     112:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     115:	8b 55 e8             	mov    0xffffffe8(%ebp),%edx
     118:	3b 02                	cmp    (%edx),%eax
     11a:	7c 8a                	jl     a6 <main+0x36>
  }
  exit();
     11c:	e8 a3 02 00 00       	call   3c4 <exit>
     121:	90                   	nop    
     122:	90                   	nop    
     123:	90                   	nop    
     124:	90                   	nop    
     125:	90                   	nop    
     126:	90                   	nop    
     127:	90                   	nop    
     128:	90                   	nop    
     129:	90                   	nop    
     12a:	90                   	nop    
     12b:	90                   	nop    
     12c:	90                   	nop    
     12d:	90                   	nop    
     12e:	90                   	nop    
     12f:	90                   	nop    

00000130 <strcpy>:
#include "user.h"

char*
strcpy(char *s, char *t)
{
     130:	55                   	push   %ebp
     131:	89 e5                	mov    %esp,%ebp
     133:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
     136:	8b 45 08             	mov    0x8(%ebp),%eax
     139:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
  while((*s++ = *t++) != 0)
     13c:	8b 45 0c             	mov    0xc(%ebp),%eax
     13f:	0f b6 10             	movzbl (%eax),%edx
     142:	8b 45 08             	mov    0x8(%ebp),%eax
     145:	88 10                	mov    %dl,(%eax)
     147:	8b 45 08             	mov    0x8(%ebp),%eax
     14a:	0f b6 00             	movzbl (%eax),%eax
     14d:	84 c0                	test   %al,%al
     14f:	0f 95 c0             	setne  %al
     152:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     156:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
     15a:	84 c0                	test   %al,%al
     15c:	75 de                	jne    13c <strcpy+0xc>
    ;
  return os;
     15e:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
}
     161:	c9                   	leave  
     162:	c3                   	ret    
     163:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     169:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00000170 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     170:	55                   	push   %ebp
     171:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
     173:	eb 08                	jmp    17d <strcmp+0xd>
    p++, q++;
     175:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     179:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
     17d:	8b 45 08             	mov    0x8(%ebp),%eax
     180:	0f b6 00             	movzbl (%eax),%eax
     183:	84 c0                	test   %al,%al
     185:	74 10                	je     197 <strcmp+0x27>
     187:	8b 45 08             	mov    0x8(%ebp),%eax
     18a:	0f b6 10             	movzbl (%eax),%edx
     18d:	8b 45 0c             	mov    0xc(%ebp),%eax
     190:	0f b6 00             	movzbl (%eax),%eax
     193:	38 c2                	cmp    %al,%dl
     195:	74 de                	je     175 <strcmp+0x5>
  return (uchar)*p - (uchar)*q;
     197:	8b 45 08             	mov    0x8(%ebp),%eax
     19a:	0f b6 00             	movzbl (%eax),%eax
     19d:	0f b6 d0             	movzbl %al,%edx
     1a0:	8b 45 0c             	mov    0xc(%ebp),%eax
     1a3:	0f b6 00             	movzbl (%eax),%eax
     1a6:	0f b6 c0             	movzbl %al,%eax
     1a9:	89 d1                	mov    %edx,%ecx
     1ab:	29 c1                	sub    %eax,%ecx
     1ad:	89 c8                	mov    %ecx,%eax
}
     1af:	5d                   	pop    %ebp
     1b0:	c3                   	ret    
     1b1:	eb 0d                	jmp    1c0 <strlen>
     1b3:	90                   	nop    
     1b4:	90                   	nop    
     1b5:	90                   	nop    
     1b6:	90                   	nop    
     1b7:	90                   	nop    
     1b8:	90                   	nop    
     1b9:	90                   	nop    
     1ba:	90                   	nop    
     1bb:	90                   	nop    
     1bc:	90                   	nop    
     1bd:	90                   	nop    
     1be:	90                   	nop    
     1bf:	90                   	nop    

000001c0 <strlen>:

uint
strlen(char *s)
{
     1c0:	55                   	push   %ebp
     1c1:	89 e5                	mov    %esp,%ebp
     1c3:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
     1c6:	c7 45 fc 00 00 00 00 	movl   $0x0,0xfffffffc(%ebp)
     1cd:	eb 04                	jmp    1d3 <strlen+0x13>
     1cf:	83 45 fc 01          	addl   $0x1,0xfffffffc(%ebp)
     1d3:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     1d6:	03 45 08             	add    0x8(%ebp),%eax
     1d9:	0f b6 00             	movzbl (%eax),%eax
     1dc:	84 c0                	test   %al,%al
     1de:	75 ef                	jne    1cf <strlen+0xf>
    ;
  return n;
     1e0:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
}
     1e3:	c9                   	leave  
     1e4:	c3                   	ret    
     1e5:	8d 74 26 00          	lea    0x0(%esi),%esi
     1e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

000001f0 <memset>:

void*
memset(void *dst, int c, uint n)
{
     1f0:	55                   	push   %ebp
     1f1:	89 e5                	mov    %esp,%ebp
     1f3:	83 ec 10             	sub    $0x10,%esp
  char *d;
  
  d = dst;
     1f6:	8b 45 08             	mov    0x8(%ebp),%eax
     1f9:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
  while(n-- > 0)
     1fc:	eb 0e                	jmp    20c <memset+0x1c>
    *d++ = c;
     1fe:	8b 45 0c             	mov    0xc(%ebp),%eax
     201:	89 c2                	mov    %eax,%edx
     203:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     206:	88 10                	mov    %dl,(%eax)
     208:	83 45 fc 01          	addl   $0x1,0xfffffffc(%ebp)
     20c:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
     210:	83 7d 10 ff          	cmpl   $0xffffffff,0x10(%ebp)
     214:	75 e8                	jne    1fe <memset+0xe>
  return dst;
     216:	8b 45 08             	mov    0x8(%ebp),%eax
}
     219:	c9                   	leave  
     21a:	c3                   	ret    
     21b:	90                   	nop    
     21c:	8d 74 26 00          	lea    0x0(%esi),%esi

00000220 <strchr>:

char*
strchr(const char *s, char c)
{
     220:	55                   	push   %ebp
     221:	89 e5                	mov    %esp,%ebp
     223:	83 ec 08             	sub    $0x8,%esp
     226:	8b 45 0c             	mov    0xc(%ebp),%eax
     229:	88 45 fc             	mov    %al,0xfffffffc(%ebp)
  for(; *s; s++)
     22c:	eb 17                	jmp    245 <strchr+0x25>
    if(*s == c)
     22e:	8b 45 08             	mov    0x8(%ebp),%eax
     231:	0f b6 00             	movzbl (%eax),%eax
     234:	3a 45 fc             	cmp    0xfffffffc(%ebp),%al
     237:	75 08                	jne    241 <strchr+0x21>
      return (char*) s;
     239:	8b 45 08             	mov    0x8(%ebp),%eax
     23c:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
     23f:	eb 15                	jmp    256 <strchr+0x36>
     241:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     245:	8b 45 08             	mov    0x8(%ebp),%eax
     248:	0f b6 00             	movzbl (%eax),%eax
     24b:	84 c0                	test   %al,%al
     24d:	75 df                	jne    22e <strchr+0xe>
  return 0;
     24f:	c7 45 f8 00 00 00 00 	movl   $0x0,0xfffffff8(%ebp)
     256:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
}
     259:	c9                   	leave  
     25a:	c3                   	ret    
     25b:	90                   	nop    
     25c:	8d 74 26 00          	lea    0x0(%esi),%esi

00000260 <gets>:

char*
gets(char *buf, int max)
{
     260:	55                   	push   %ebp
     261:	89 e5                	mov    %esp,%ebp
     263:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     266:	c7 45 f8 00 00 00 00 	movl   $0x0,0xfffffff8(%ebp)
     26d:	eb 46                	jmp    2b5 <gets+0x55>
    cc = read(0, &c, 1);
     26f:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
     276:	00 
     277:	8d 45 f7             	lea    0xfffffff7(%ebp),%eax
     27a:	89 44 24 04          	mov    %eax,0x4(%esp)
     27e:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     285:	e8 52 01 00 00       	call   3dc <read>
     28a:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
    if(cc < 1)
     28d:	83 7d fc 00          	cmpl   $0x0,0xfffffffc(%ebp)
     291:	7e 2d                	jle    2c0 <gets+0x60>
      break;
    buf[i++] = c;
     293:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     296:	89 c2                	mov    %eax,%edx
     298:	03 55 08             	add    0x8(%ebp),%edx
     29b:	0f b6 45 f7          	movzbl 0xfffffff7(%ebp),%eax
     29f:	88 02                	mov    %al,(%edx)
     2a1:	83 45 f8 01          	addl   $0x1,0xfffffff8(%ebp)
    if(c == '\n' || c == '\r')
     2a5:	0f b6 45 f7          	movzbl 0xfffffff7(%ebp),%eax
     2a9:	3c 0a                	cmp    $0xa,%al
     2ab:	74 13                	je     2c0 <gets+0x60>
     2ad:	0f b6 45 f7          	movzbl 0xfffffff7(%ebp),%eax
     2b1:	3c 0d                	cmp    $0xd,%al
     2b3:	74 0b                	je     2c0 <gets+0x60>
     2b5:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     2b8:	83 c0 01             	add    $0x1,%eax
     2bb:	3b 45 0c             	cmp    0xc(%ebp),%eax
     2be:	7c af                	jl     26f <gets+0xf>
      break;
  }
  buf[i] = '\0';
     2c0:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     2c3:	03 45 08             	add    0x8(%ebp),%eax
     2c6:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
     2c9:	8b 45 08             	mov    0x8(%ebp),%eax
}
     2cc:	c9                   	leave  
     2cd:	c3                   	ret    
     2ce:	89 f6                	mov    %esi,%esi

000002d0 <stat>:

int
stat(char *n, struct stat *st)
{
     2d0:	55                   	push   %ebp
     2d1:	89 e5                	mov    %esp,%ebp
     2d3:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     2d6:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     2dd:	00 
     2de:	8b 45 08             	mov    0x8(%ebp),%eax
     2e1:	89 04 24             	mov    %eax,(%esp)
     2e4:	e8 1b 01 00 00       	call   404 <open>
     2e9:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
  if(fd < 0)
     2ec:	83 7d f8 00          	cmpl   $0x0,0xfffffff8(%ebp)
     2f0:	79 09                	jns    2fb <stat+0x2b>
    return -1;
     2f2:	c7 45 ec ff ff ff ff 	movl   $0xffffffff,0xffffffec(%ebp)
     2f9:	eb 26                	jmp    321 <stat+0x51>
  r = fstat(fd, st);
     2fb:	8b 45 0c             	mov    0xc(%ebp),%eax
     2fe:	89 44 24 04          	mov    %eax,0x4(%esp)
     302:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     305:	89 04 24             	mov    %eax,(%esp)
     308:	e8 0f 01 00 00       	call   41c <fstat>
     30d:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
  close(fd);
     310:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     313:	89 04 24             	mov    %eax,(%esp)
     316:	e8 d1 00 00 00       	call   3ec <close>
  return r;
     31b:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     31e:	89 45 ec             	mov    %eax,0xffffffec(%ebp)
     321:	8b 45 ec             	mov    0xffffffec(%ebp),%eax
}
     324:	c9                   	leave  
     325:	c3                   	ret    
     326:	8d 76 00             	lea    0x0(%esi),%esi
     329:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00000330 <atoi>:

int
atoi(const char *s)
{
     330:	55                   	push   %ebp
     331:	89 e5                	mov    %esp,%ebp
     333:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
     336:	c7 45 fc 00 00 00 00 	movl   $0x0,0xfffffffc(%ebp)
  while('0' <= *s && *s <= '9')
     33d:	eb 24                	jmp    363 <atoi+0x33>
    n = n*10 + *s++ - '0';
     33f:	8b 55 fc             	mov    0xfffffffc(%ebp),%edx
     342:	89 d0                	mov    %edx,%eax
     344:	c1 e0 02             	shl    $0x2,%eax
     347:	01 d0                	add    %edx,%eax
     349:	01 c0                	add    %eax,%eax
     34b:	89 c2                	mov    %eax,%edx
     34d:	8b 45 08             	mov    0x8(%ebp),%eax
     350:	0f b6 00             	movzbl (%eax),%eax
     353:	0f be c0             	movsbl %al,%eax
     356:	8d 04 02             	lea    (%edx,%eax,1),%eax
     359:	83 e8 30             	sub    $0x30,%eax
     35c:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
     35f:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     363:	8b 45 08             	mov    0x8(%ebp),%eax
     366:	0f b6 00             	movzbl (%eax),%eax
     369:	3c 2f                	cmp    $0x2f,%al
     36b:	7e 0a                	jle    377 <atoi+0x47>
     36d:	8b 45 08             	mov    0x8(%ebp),%eax
     370:	0f b6 00             	movzbl (%eax),%eax
     373:	3c 39                	cmp    $0x39,%al
     375:	7e c8                	jle    33f <atoi+0xf>
  return n;
     377:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
}
     37a:	c9                   	leave  
     37b:	c3                   	ret    
     37c:	8d 74 26 00          	lea    0x0(%esi),%esi

00000380 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
     380:	55                   	push   %ebp
     381:	89 e5                	mov    %esp,%ebp
     383:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
     386:	8b 45 08             	mov    0x8(%ebp),%eax
     389:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
  src = vsrc;
     38c:	8b 45 0c             	mov    0xc(%ebp),%eax
     38f:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
  while(n-- > 0)
     392:	eb 13                	jmp    3a7 <memmove+0x27>
    *dst++ = *src++;
     394:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     397:	0f b6 10             	movzbl (%eax),%edx
     39a:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     39d:	88 10                	mov    %dl,(%eax)
     39f:	83 45 f8 01          	addl   $0x1,0xfffffff8(%ebp)
     3a3:	83 45 fc 01          	addl   $0x1,0xfffffffc(%ebp)
     3a7:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     3ab:	0f 9f c0             	setg   %al
     3ae:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
     3b2:	84 c0                	test   %al,%al
     3b4:	75 de                	jne    394 <memmove+0x14>
  return vdst;
     3b6:	8b 45 08             	mov    0x8(%ebp),%eax
}
     3b9:	c9                   	leave  
     3ba:	c3                   	ret    
     3bb:	90                   	nop    

000003bc <fork>:
     3bc:	b8 01 00 00 00       	mov    $0x1,%eax
     3c1:	cd 30                	int    $0x30
     3c3:	c3                   	ret    

000003c4 <exit>:
     3c4:	b8 02 00 00 00       	mov    $0x2,%eax
     3c9:	cd 30                	int    $0x30
     3cb:	c3                   	ret    

000003cc <wait>:
     3cc:	b8 03 00 00 00       	mov    $0x3,%eax
     3d1:	cd 30                	int    $0x30
     3d3:	c3                   	ret    

000003d4 <pipe>:
     3d4:	b8 04 00 00 00       	mov    $0x4,%eax
     3d9:	cd 30                	int    $0x30
     3db:	c3                   	ret    

000003dc <read>:
     3dc:	b8 06 00 00 00       	mov    $0x6,%eax
     3e1:	cd 30                	int    $0x30
     3e3:	c3                   	ret    

000003e4 <write>:
     3e4:	b8 05 00 00 00       	mov    $0x5,%eax
     3e9:	cd 30                	int    $0x30
     3eb:	c3                   	ret    

000003ec <close>:
     3ec:	b8 07 00 00 00       	mov    $0x7,%eax
     3f1:	cd 30                	int    $0x30
     3f3:	c3                   	ret    

000003f4 <kill>:
     3f4:	b8 08 00 00 00       	mov    $0x8,%eax
     3f9:	cd 30                	int    $0x30
     3fb:	c3                   	ret    

000003fc <exec>:
     3fc:	b8 09 00 00 00       	mov    $0x9,%eax
     401:	cd 30                	int    $0x30
     403:	c3                   	ret    

00000404 <open>:
     404:	b8 0a 00 00 00       	mov    $0xa,%eax
     409:	cd 30                	int    $0x30
     40b:	c3                   	ret    

0000040c <mknod>:
     40c:	b8 0b 00 00 00       	mov    $0xb,%eax
     411:	cd 30                	int    $0x30
     413:	c3                   	ret    

00000414 <unlink>:
     414:	b8 0c 00 00 00       	mov    $0xc,%eax
     419:	cd 30                	int    $0x30
     41b:	c3                   	ret    

0000041c <fstat>:
     41c:	b8 0d 00 00 00       	mov    $0xd,%eax
     421:	cd 30                	int    $0x30
     423:	c3                   	ret    

00000424 <link>:
     424:	b8 0e 00 00 00       	mov    $0xe,%eax
     429:	cd 30                	int    $0x30
     42b:	c3                   	ret    

0000042c <mkdir>:
     42c:	b8 0f 00 00 00       	mov    $0xf,%eax
     431:	cd 30                	int    $0x30
     433:	c3                   	ret    

00000434 <chdir>:
     434:	b8 10 00 00 00       	mov    $0x10,%eax
     439:	cd 30                	int    $0x30
     43b:	c3                   	ret    

0000043c <dup>:
     43c:	b8 11 00 00 00       	mov    $0x11,%eax
     441:	cd 30                	int    $0x30
     443:	c3                   	ret    

00000444 <getpid>:
     444:	b8 12 00 00 00       	mov    $0x12,%eax
     449:	cd 30                	int    $0x30
     44b:	c3                   	ret    

0000044c <sbrk>:
     44c:	b8 13 00 00 00       	mov    $0x13,%eax
     451:	cd 30                	int    $0x30
     453:	c3                   	ret    

00000454 <sleep>:
     454:	b8 14 00 00 00       	mov    $0x14,%eax
     459:	cd 30                	int    $0x30
     45b:	c3                   	ret    

0000045c <upmsec>:
     45c:	b8 15 00 00 00       	mov    $0x15,%eax
     461:	cd 30                	int    $0x30
     463:	c3                   	ret    

00000464 <socket>:
     464:	b8 16 00 00 00       	mov    $0x16,%eax
     469:	cd 30                	int    $0x30
     46b:	c3                   	ret    

0000046c <bind>:
     46c:	b8 17 00 00 00       	mov    $0x17,%eax
     471:	cd 30                	int    $0x30
     473:	c3                   	ret    

00000474 <listen>:
     474:	b8 18 00 00 00       	mov    $0x18,%eax
     479:	cd 30                	int    $0x30
     47b:	c3                   	ret    

0000047c <accept>:
     47c:	b8 19 00 00 00       	mov    $0x19,%eax
     481:	cd 30                	int    $0x30
     483:	c3                   	ret    

00000484 <recv>:
     484:	b8 1a 00 00 00       	mov    $0x1a,%eax
     489:	cd 30                	int    $0x30
     48b:	c3                   	ret    

0000048c <recvfrom>:
     48c:	b8 1b 00 00 00       	mov    $0x1b,%eax
     491:	cd 30                	int    $0x30
     493:	c3                   	ret    

00000494 <send>:
     494:	b8 1c 00 00 00       	mov    $0x1c,%eax
     499:	cd 30                	int    $0x30
     49b:	c3                   	ret    

0000049c <sendto>:
     49c:	b8 1d 00 00 00       	mov    $0x1d,%eax
     4a1:	cd 30                	int    $0x30
     4a3:	c3                   	ret    

000004a4 <shutdown>:
     4a4:	b8 1e 00 00 00       	mov    $0x1e,%eax
     4a9:	cd 30                	int    $0x30
     4ab:	c3                   	ret    

000004ac <getsockopt>:
     4ac:	b8 1f 00 00 00       	mov    $0x1f,%eax
     4b1:	cd 30                	int    $0x30
     4b3:	c3                   	ret    

000004b4 <setsockopt>:
     4b4:	b8 20 00 00 00       	mov    $0x20,%eax
     4b9:	cd 30                	int    $0x30
     4bb:	c3                   	ret    

000004bc <sockclose>:
     4bc:	b8 21 00 00 00       	mov    $0x21,%eax
     4c1:	cd 30                	int    $0x30
     4c3:	c3                   	ret    

000004c4 <connect>:
     4c4:	b8 22 00 00 00       	mov    $0x22,%eax
     4c9:	cd 30                	int    $0x30
     4cb:	c3                   	ret    

000004cc <getpeername>:
     4cc:	b8 23 00 00 00       	mov    $0x23,%eax
     4d1:	cd 30                	int    $0x30
     4d3:	c3                   	ret    

000004d4 <getsockname>:
     4d4:	b8 24 00 00 00       	mov    $0x24,%eax
     4d9:	cd 30                	int    $0x30
     4db:	c3                   	ret    
     4dc:	90                   	nop    
     4dd:	90                   	nop    
     4de:	90                   	nop    
     4df:	90                   	nop    

000004e0 <putc>:
#include "user.h"

void
putc(int fd, char c)
{
     4e0:	55                   	push   %ebp
     4e1:	89 e5                	mov    %esp,%ebp
     4e3:	83 ec 18             	sub    $0x18,%esp
     4e6:	8b 45 0c             	mov    0xc(%ebp),%eax
     4e9:	88 45 fc             	mov    %al,0xfffffffc(%ebp)
  write(fd, &c, 1);
     4ec:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
     4f3:	00 
     4f4:	8d 45 fc             	lea    0xfffffffc(%ebp),%eax
     4f7:	89 44 24 04          	mov    %eax,0x4(%esp)
     4fb:	8b 45 08             	mov    0x8(%ebp),%eax
     4fe:	89 04 24             	mov    %eax,(%esp)
     501:	e8 de fe ff ff       	call   3e4 <write>
}
     506:	c9                   	leave  
     507:	c3                   	ret    
     508:	90                   	nop    
     509:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi

00000510 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     510:	55                   	push   %ebp
     511:	89 e5                	mov    %esp,%ebp
     513:	53                   	push   %ebx
     514:	83 ec 34             	sub    $0x34,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     517:	c7 45 f4 00 00 00 00 	movl   $0x0,0xfffffff4(%ebp)
  if(sgn && xx < 0){
     51e:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
     522:	74 17                	je     53b <printint+0x2b>
     524:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     528:	79 11                	jns    53b <printint+0x2b>
    neg = 1;
     52a:	c7 45 f4 01 00 00 00 	movl   $0x1,0xfffffff4(%ebp)
    x = -xx;
     531:	8b 45 0c             	mov    0xc(%ebp),%eax
     534:	f7 d8                	neg    %eax
     536:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
     539:	eb 06                	jmp    541 <printint+0x31>
  } else {
    x = xx;
     53b:	8b 45 0c             	mov    0xc(%ebp),%eax
     53e:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
  }

  i = 0;
     541:	c7 45 f0 00 00 00 00 	movl   $0x0,0xfffffff0(%ebp)
  do{
    buf[i++] = digits[x % base];
     548:	8b 4d f0             	mov    0xfffffff0(%ebp),%ecx
     54b:	8b 55 10             	mov    0x10(%ebp),%edx
     54e:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     551:	89 d3                	mov    %edx,%ebx
     553:	ba 00 00 00 00       	mov    $0x0,%edx
     558:	f7 f3                	div    %ebx
     55a:	89 d0                	mov    %edx,%eax
     55c:	0f b6 80 98 11 00 00 	movzbl 0x1198(%eax),%eax
     563:	88 44 0d e0          	mov    %al,0xffffffe0(%ebp,%ecx,1)
     567:	83 45 f0 01          	addl   $0x1,0xfffffff0(%ebp)
  }while((x /= base) != 0);
     56b:	8b 55 10             	mov    0x10(%ebp),%edx
     56e:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     571:	89 d1                	mov    %edx,%ecx
     573:	ba 00 00 00 00       	mov    $0x0,%edx
     578:	f7 f1                	div    %ecx
     57a:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
     57d:	83 7d f8 00          	cmpl   $0x0,0xfffffff8(%ebp)
     581:	75 c5                	jne    548 <printint+0x38>
  if(neg)
     583:	83 7d f4 00          	cmpl   $0x0,0xfffffff4(%ebp)
     587:	74 28                	je     5b1 <printint+0xa1>
    buf[i++] = '-';
     589:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
     58c:	c6 44 05 e0 2d       	movb   $0x2d,0xffffffe0(%ebp,%eax,1)
     591:	83 45 f0 01          	addl   $0x1,0xfffffff0(%ebp)

  while(--i >= 0)
     595:	eb 1a                	jmp    5b1 <printint+0xa1>
    putc(fd, buf[i]);
     597:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
     59a:	0f b6 44 05 e0       	movzbl 0xffffffe0(%ebp,%eax,1),%eax
     59f:	0f be c0             	movsbl %al,%eax
     5a2:	89 44 24 04          	mov    %eax,0x4(%esp)
     5a6:	8b 45 08             	mov    0x8(%ebp),%eax
     5a9:	89 04 24             	mov    %eax,(%esp)
     5ac:	e8 2f ff ff ff       	call   4e0 <putc>
     5b1:	83 6d f0 01          	subl   $0x1,0xfffffff0(%ebp)
     5b5:	83 7d f0 00          	cmpl   $0x0,0xfffffff0(%ebp)
     5b9:	79 dc                	jns    597 <printint+0x87>
}
     5bb:	83 c4 34             	add    $0x34,%esp
     5be:	5b                   	pop    %ebx
     5bf:	5d                   	pop    %ebp
     5c0:	c3                   	ret    
     5c1:	eb 0d                	jmp    5d0 <printf>
     5c3:	90                   	nop    
     5c4:	90                   	nop    
     5c5:	90                   	nop    
     5c6:	90                   	nop    
     5c7:	90                   	nop    
     5c8:	90                   	nop    
     5c9:	90                   	nop    
     5ca:	90                   	nop    
     5cb:	90                   	nop    
     5cc:	90                   	nop    
     5cd:	90                   	nop    
     5ce:	90                   	nop    
     5cf:	90                   	nop    

000005d0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
     5d0:	55                   	push   %ebp
     5d1:	89 e5                	mov    %esp,%ebp
     5d3:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
     5d6:	c7 45 f8 00 00 00 00 	movl   $0x0,0xfffffff8(%ebp)
  ap = (uint*)(void*)&fmt + 1;
     5dd:	8d 45 0c             	lea    0xc(%ebp),%eax
     5e0:	83 c0 04             	add    $0x4,%eax
     5e3:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
  for(i = 0; fmt[i]; i++){
     5e6:	c7 45 f4 00 00 00 00 	movl   $0x0,0xfffffff4(%ebp)
     5ed:	e9 7b 01 00 00       	jmp    76d <printf+0x19d>
    c = fmt[i] & 0xff;
     5f2:	8b 55 0c             	mov    0xc(%ebp),%edx
     5f5:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     5f8:	8d 04 02             	lea    (%edx,%eax,1),%eax
     5fb:	0f b6 00             	movzbl (%eax),%eax
     5fe:	0f be c0             	movsbl %al,%eax
     601:	25 ff 00 00 00       	and    $0xff,%eax
     606:	89 45 f0             	mov    %eax,0xfffffff0(%ebp)
    if(state == 0){
     609:	83 7d f8 00          	cmpl   $0x0,0xfffffff8(%ebp)
     60d:	75 2c                	jne    63b <printf+0x6b>
      if(c == '%'){
     60f:	83 7d f0 25          	cmpl   $0x25,0xfffffff0(%ebp)
     613:	75 0c                	jne    621 <printf+0x51>
        state = '%';
     615:	c7 45 f8 25 00 00 00 	movl   $0x25,0xfffffff8(%ebp)
     61c:	e9 48 01 00 00       	jmp    769 <printf+0x199>
      } else {
        putc(fd, c);
     621:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
     624:	0f be c0             	movsbl %al,%eax
     627:	89 44 24 04          	mov    %eax,0x4(%esp)
     62b:	8b 45 08             	mov    0x8(%ebp),%eax
     62e:	89 04 24             	mov    %eax,(%esp)
     631:	e8 aa fe ff ff       	call   4e0 <putc>
     636:	e9 2e 01 00 00       	jmp    769 <printf+0x199>
      }
    } else if(state == '%'){
     63b:	83 7d f8 25          	cmpl   $0x25,0xfffffff8(%ebp)
     63f:	0f 85 24 01 00 00    	jne    769 <printf+0x199>
      if(c == 'd'){
     645:	83 7d f0 64          	cmpl   $0x64,0xfffffff0(%ebp)
     649:	75 2d                	jne    678 <printf+0xa8>
        printint(fd, *ap, 10, 1);
     64b:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     64e:	8b 00                	mov    (%eax),%eax
     650:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
     657:	00 
     658:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
     65f:	00 
     660:	89 44 24 04          	mov    %eax,0x4(%esp)
     664:	8b 45 08             	mov    0x8(%ebp),%eax
     667:	89 04 24             	mov    %eax,(%esp)
     66a:	e8 a1 fe ff ff       	call   510 <printint>
        ap++;
     66f:	83 45 fc 04          	addl   $0x4,0xfffffffc(%ebp)
     673:	e9 ea 00 00 00       	jmp    762 <printf+0x192>
      } else if(c == 'x' || c == 'p'){
     678:	83 7d f0 78          	cmpl   $0x78,0xfffffff0(%ebp)
     67c:	74 06                	je     684 <printf+0xb4>
     67e:	83 7d f0 70          	cmpl   $0x70,0xfffffff0(%ebp)
     682:	75 2d                	jne    6b1 <printf+0xe1>
        printint(fd, *ap, 16, 0);
     684:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     687:	8b 00                	mov    (%eax),%eax
     689:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
     690:	00 
     691:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
     698:	00 
     699:	89 44 24 04          	mov    %eax,0x4(%esp)
     69d:	8b 45 08             	mov    0x8(%ebp),%eax
     6a0:	89 04 24             	mov    %eax,(%esp)
     6a3:	e8 68 fe ff ff       	call   510 <printint>
        ap++;
     6a8:	83 45 fc 04          	addl   $0x4,0xfffffffc(%ebp)
     6ac:	e9 b1 00 00 00       	jmp    762 <printf+0x192>
      } else if(c == 's'){
     6b1:	83 7d f0 73          	cmpl   $0x73,0xfffffff0(%ebp)
     6b5:	75 43                	jne    6fa <printf+0x12a>
        s = (char*)*ap;
     6b7:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     6ba:	8b 00                	mov    (%eax),%eax
     6bc:	89 45 ec             	mov    %eax,0xffffffec(%ebp)
        ap++;
     6bf:	83 45 fc 04          	addl   $0x4,0xfffffffc(%ebp)
        if(s == 0)
     6c3:	83 7d ec 00          	cmpl   $0x0,0xffffffec(%ebp)
     6c7:	75 25                	jne    6ee <printf+0x11e>
          s = "(null)";
     6c9:	c7 45 ec 7a 11 00 00 	movl   $0x117a,0xffffffec(%ebp)
        while(*s != 0){
     6d0:	eb 1c                	jmp    6ee <printf+0x11e>
          putc(fd, *s);
     6d2:	8b 45 ec             	mov    0xffffffec(%ebp),%eax
     6d5:	0f b6 00             	movzbl (%eax),%eax
     6d8:	0f be c0             	movsbl %al,%eax
     6db:	89 44 24 04          	mov    %eax,0x4(%esp)
     6df:	8b 45 08             	mov    0x8(%ebp),%eax
     6e2:	89 04 24             	mov    %eax,(%esp)
     6e5:	e8 f6 fd ff ff       	call   4e0 <putc>
          s++;
     6ea:	83 45 ec 01          	addl   $0x1,0xffffffec(%ebp)
     6ee:	8b 45 ec             	mov    0xffffffec(%ebp),%eax
     6f1:	0f b6 00             	movzbl (%eax),%eax
     6f4:	84 c0                	test   %al,%al
     6f6:	75 da                	jne    6d2 <printf+0x102>
     6f8:	eb 68                	jmp    762 <printf+0x192>
        }
      } else if(c == 'c'){
     6fa:	83 7d f0 63          	cmpl   $0x63,0xfffffff0(%ebp)
     6fe:	75 1d                	jne    71d <printf+0x14d>
        putc(fd, *ap);
     700:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     703:	8b 00                	mov    (%eax),%eax
     705:	0f be c0             	movsbl %al,%eax
     708:	89 44 24 04          	mov    %eax,0x4(%esp)
     70c:	8b 45 08             	mov    0x8(%ebp),%eax
     70f:	89 04 24             	mov    %eax,(%esp)
     712:	e8 c9 fd ff ff       	call   4e0 <putc>
        ap++;
     717:	83 45 fc 04          	addl   $0x4,0xfffffffc(%ebp)
     71b:	eb 45                	jmp    762 <printf+0x192>
      } else if(c == '%'){
     71d:	83 7d f0 25          	cmpl   $0x25,0xfffffff0(%ebp)
     721:	75 17                	jne    73a <printf+0x16a>
        putc(fd, c);
     723:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
     726:	0f be c0             	movsbl %al,%eax
     729:	89 44 24 04          	mov    %eax,0x4(%esp)
     72d:	8b 45 08             	mov    0x8(%ebp),%eax
     730:	89 04 24             	mov    %eax,(%esp)
     733:	e8 a8 fd ff ff       	call   4e0 <putc>
     738:	eb 28                	jmp    762 <printf+0x192>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     73a:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
     741:	00 
     742:	8b 45 08             	mov    0x8(%ebp),%eax
     745:	89 04 24             	mov    %eax,(%esp)
     748:	e8 93 fd ff ff       	call   4e0 <putc>
        putc(fd, c);
     74d:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
     750:	0f be c0             	movsbl %al,%eax
     753:	89 44 24 04          	mov    %eax,0x4(%esp)
     757:	8b 45 08             	mov    0x8(%ebp),%eax
     75a:	89 04 24             	mov    %eax,(%esp)
     75d:	e8 7e fd ff ff       	call   4e0 <putc>
      }
      state = 0;
     762:	c7 45 f8 00 00 00 00 	movl   $0x0,0xfffffff8(%ebp)
     769:	83 45 f4 01          	addl   $0x1,0xfffffff4(%ebp)
     76d:	8b 55 0c             	mov    0xc(%ebp),%edx
     770:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     773:	8d 04 02             	lea    (%edx,%eax,1),%eax
     776:	0f b6 00             	movzbl (%eax),%eax
     779:	84 c0                	test   %al,%al
     77b:	0f 85 71 fe ff ff    	jne    5f2 <printf+0x22>
    }
  }
}
     781:	c9                   	leave  
     782:	c3                   	ret    
     783:	90                   	nop    
     784:	90                   	nop    
     785:	90                   	nop    
     786:	90                   	nop    
     787:	90                   	nop    
     788:	90                   	nop    
     789:	90                   	nop    
     78a:	90                   	nop    
     78b:	90                   	nop    
     78c:	90                   	nop    
     78d:	90                   	nop    
     78e:	90                   	nop    
     78f:	90                   	nop    

00000790 <free>:
static Header *freep;

void
free(void *ap)
{
     790:	55                   	push   %ebp
     791:	89 e5                	mov    %esp,%ebp
     793:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*) ap - 1;
     796:	8b 45 08             	mov    0x8(%ebp),%eax
     799:	83 e8 08             	sub    $0x8,%eax
     79c:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     79f:	a1 c8 11 00 00       	mov    0x11c8,%eax
     7a4:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
     7a7:	eb 24                	jmp    7cd <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     7a9:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     7ac:	8b 00                	mov    (%eax),%eax
     7ae:	3b 45 fc             	cmp    0xfffffffc(%ebp),%eax
     7b1:	77 12                	ja     7c5 <free+0x35>
     7b3:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     7b6:	3b 45 fc             	cmp    0xfffffffc(%ebp),%eax
     7b9:	77 24                	ja     7df <free+0x4f>
     7bb:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     7be:	8b 00                	mov    (%eax),%eax
     7c0:	3b 45 f8             	cmp    0xfffffff8(%ebp),%eax
     7c3:	77 1a                	ja     7df <free+0x4f>
     7c5:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     7c8:	8b 00                	mov    (%eax),%eax
     7ca:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
     7cd:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     7d0:	3b 45 fc             	cmp    0xfffffffc(%ebp),%eax
     7d3:	76 d4                	jbe    7a9 <free+0x19>
     7d5:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     7d8:	8b 00                	mov    (%eax),%eax
     7da:	3b 45 f8             	cmp    0xfffffff8(%ebp),%eax
     7dd:	76 ca                	jbe    7a9 <free+0x19>
      break;
  if(bp + bp->s.size == p->s.ptr){
     7df:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     7e2:	8b 40 04             	mov    0x4(%eax),%eax
     7e5:	c1 e0 03             	shl    $0x3,%eax
     7e8:	89 c2                	mov    %eax,%edx
     7ea:	03 55 f8             	add    0xfffffff8(%ebp),%edx
     7ed:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     7f0:	8b 00                	mov    (%eax),%eax
     7f2:	39 c2                	cmp    %eax,%edx
     7f4:	75 24                	jne    81a <free+0x8a>
    bp->s.size += p->s.ptr->s.size;
     7f6:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     7f9:	8b 50 04             	mov    0x4(%eax),%edx
     7fc:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     7ff:	8b 00                	mov    (%eax),%eax
     801:	8b 40 04             	mov    0x4(%eax),%eax
     804:	01 c2                	add    %eax,%edx
     806:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     809:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
     80c:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     80f:	8b 00                	mov    (%eax),%eax
     811:	8b 10                	mov    (%eax),%edx
     813:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     816:	89 10                	mov    %edx,(%eax)
     818:	eb 0a                	jmp    824 <free+0x94>
  } else
    bp->s.ptr = p->s.ptr;
     81a:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     81d:	8b 10                	mov    (%eax),%edx
     81f:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     822:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
     824:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     827:	8b 40 04             	mov    0x4(%eax),%eax
     82a:	c1 e0 03             	shl    $0x3,%eax
     82d:	03 45 fc             	add    0xfffffffc(%ebp),%eax
     830:	3b 45 f8             	cmp    0xfffffff8(%ebp),%eax
     833:	75 20                	jne    855 <free+0xc5>
    p->s.size += bp->s.size;
     835:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     838:	8b 50 04             	mov    0x4(%eax),%edx
     83b:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     83e:	8b 40 04             	mov    0x4(%eax),%eax
     841:	01 c2                	add    %eax,%edx
     843:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     846:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
     849:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     84c:	8b 10                	mov    (%eax),%edx
     84e:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     851:	89 10                	mov    %edx,(%eax)
     853:	eb 08                	jmp    85d <free+0xcd>
  } else
    p->s.ptr = bp;
     855:	8b 55 fc             	mov    0xfffffffc(%ebp),%edx
     858:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     85b:	89 02                	mov    %eax,(%edx)
  freep = p;
     85d:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     860:	a3 c8 11 00 00       	mov    %eax,0x11c8
}
     865:	c9                   	leave  
     866:	c3                   	ret    
     867:	89 f6                	mov    %esi,%esi
     869:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00000870 <morecore>:

static Header*
morecore(uint nu)
{
     870:	55                   	push   %ebp
     871:	89 e5                	mov    %esp,%ebp
     873:	83 ec 18             	sub    $0x18,%esp
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
     876:	8b 45 08             	mov    0x8(%ebp),%eax
     879:	c1 e0 03             	shl    $0x3,%eax
     87c:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
  size += PAGE - size % PAGE;
     87f:	8b 55 fc             	mov    0xfffffffc(%ebp),%edx
     882:	89 d0                	mov    %edx,%eax
     884:	c1 f8 1f             	sar    $0x1f,%eax
     887:	89 c1                	mov    %eax,%ecx
     889:	c1 e9 14             	shr    $0x14,%ecx
     88c:	8d 04 0a             	lea    (%edx,%ecx,1),%eax
     88f:	25 ff 0f 00 00       	and    $0xfff,%eax
     894:	29 c8                	sub    %ecx,%eax
     896:	89 c2                	mov    %eax,%edx
     898:	b8 00 10 00 00       	mov    $0x1000,%eax
     89d:	29 d0                	sub    %edx,%eax
     89f:	01 45 fc             	add    %eax,0xfffffffc(%ebp)
#endif
#ifdef UMALLOC_DEBUG
  printf(1, "size: %d\n", size);
#endif
  p = sbrk(size);
     8a2:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     8a5:	89 04 24             	mov    %eax,(%esp)
     8a8:	e8 9f fb ff ff       	call   44c <sbrk>
     8ad:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
  if(p == (char*) -1)
     8b0:	83 7d f4 ff          	cmpl   $0xffffffff,0xfffffff4(%ebp)
     8b4:	75 09                	jne    8bf <morecore+0x4f>
    return 0;
     8b6:	c7 45 ec 00 00 00 00 	movl   $0x0,0xffffffec(%ebp)
     8bd:	eb 2a                	jmp    8e9 <morecore+0x79>
  hp = (Header*)p;
     8bf:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     8c2:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
#ifdef UMALLOC_NOALIGN
  hp->s.size = nu;
#else
  hp->s.size = size / sizeof(Header);
     8c5:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     8c8:	89 c2                	mov    %eax,%edx
     8ca:	c1 ea 03             	shr    $0x3,%edx
     8cd:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     8d0:	89 50 04             	mov    %edx,0x4(%eax)
#endif
  free((void*)(hp + 1));
     8d3:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     8d6:	83 c0 08             	add    $0x8,%eax
     8d9:	89 04 24             	mov    %eax,(%esp)
     8dc:	e8 af fe ff ff       	call   790 <free>
  return freep;
     8e1:	a1 c8 11 00 00       	mov    0x11c8,%eax
     8e6:	89 45 ec             	mov    %eax,0xffffffec(%ebp)
     8e9:	8b 45 ec             	mov    0xffffffec(%ebp),%eax
}
     8ec:	c9                   	leave  
     8ed:	c3                   	ret    
     8ee:	89 f6                	mov    %esi,%esi

000008f0 <malloc>:

void*
malloc(uint nbytes)
{
     8f0:	55                   	push   %ebp
     8f1:	89 e5                	mov    %esp,%ebp
     8f3:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

#ifdef UMALLOC_DEBUG
  printf(1, "malloc: %d bytes\n", nbytes);
  printf(1, "size of Header: %d\n", sizeof(Header));
#endif
  if (PAGE % sizeof(Header))
      printf(2, "Warning! align failed! Need UMALLOC_NOALIGN\n");
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     8f6:	8b 45 08             	mov    0x8(%ebp),%eax
     8f9:	83 c0 07             	add    $0x7,%eax
     8fc:	c1 e8 03             	shr    $0x3,%eax
     8ff:	83 c0 01             	add    $0x1,%eax
     902:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
  if((prevp = freep) == 0){
     905:	a1 c8 11 00 00       	mov    0x11c8,%eax
     90a:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
     90d:	83 7d f8 00          	cmpl   $0x0,0xfffffff8(%ebp)
     911:	75 23                	jne    936 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
     913:	c7 45 f8 c0 11 00 00 	movl   $0x11c0,0xfffffff8(%ebp)
     91a:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     91d:	a3 c8 11 00 00       	mov    %eax,0x11c8
     922:	a1 c8 11 00 00       	mov    0x11c8,%eax
     927:	a3 c0 11 00 00       	mov    %eax,0x11c0
    base.s.size = 0;
     92c:	c7 05 c4 11 00 00 00 	movl   $0x0,0x11c4
     933:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     936:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     939:	8b 00                	mov    (%eax),%eax
     93b:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
    if(p->s.size >= nunits){
     93e:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     941:	8b 40 04             	mov    0x4(%eax),%eax
     944:	3b 45 fc             	cmp    0xfffffffc(%ebp),%eax
     947:	72 50                	jb     999 <malloc+0xa9>
      if(p->s.size == nunits)
     949:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     94c:	8b 40 04             	mov    0x4(%eax),%eax
     94f:	3b 45 fc             	cmp    0xfffffffc(%ebp),%eax
     952:	75 0c                	jne    960 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
     954:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     957:	8b 10                	mov    (%eax),%edx
     959:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     95c:	89 10                	mov    %edx,(%eax)
     95e:	eb 26                	jmp    986 <malloc+0x96>
      else {
        p->s.size -= nunits;
     960:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     963:	8b 40 04             	mov    0x4(%eax),%eax
     966:	89 c2                	mov    %eax,%edx
     968:	2b 55 fc             	sub    0xfffffffc(%ebp),%edx
     96b:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     96e:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
     971:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     974:	8b 40 04             	mov    0x4(%eax),%eax
     977:	c1 e0 03             	shl    $0x3,%eax
     97a:	01 45 f4             	add    %eax,0xfffffff4(%ebp)
        p->s.size = nunits;
     97d:	8b 55 f4             	mov    0xfffffff4(%ebp),%edx
     980:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     983:	89 42 04             	mov    %eax,0x4(%edx)
      }
      freep = prevp;
     986:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     989:	a3 c8 11 00 00       	mov    %eax,0x11c8
      return (void*) (p + 1);
     98e:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     991:	83 c0 08             	add    $0x8,%eax
     994:	89 45 ec             	mov    %eax,0xffffffec(%ebp)
     997:	eb 3a                	jmp    9d3 <malloc+0xe3>
    }
    if(p == freep)
     999:	a1 c8 11 00 00       	mov    0x11c8,%eax
     99e:	39 45 f4             	cmp    %eax,0xfffffff4(%ebp)
     9a1:	75 1d                	jne    9c0 <malloc+0xd0>
      if((p = morecore(nunits)) == 0)
     9a3:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     9a6:	89 04 24             	mov    %eax,(%esp)
     9a9:	e8 c2 fe ff ff       	call   870 <morecore>
     9ae:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
     9b1:	83 7d f4 00          	cmpl   $0x0,0xfffffff4(%ebp)
     9b5:	75 09                	jne    9c0 <malloc+0xd0>
        return 0;
     9b7:	c7 45 ec 00 00 00 00 	movl   $0x0,0xffffffec(%ebp)
     9be:	eb 13                	jmp    9d3 <malloc+0xe3>
     9c0:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     9c3:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
     9c6:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     9c9:	8b 00                	mov    (%eax),%eax
     9cb:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
  }
     9ce:	e9 6b ff ff ff       	jmp    93e <malloc+0x4e>
     9d3:	8b 45 ec             	mov    0xffffffec(%ebp),%eax
}
     9d6:	c9                   	leave  
     9d7:	c3                   	ret    
     9d8:	90                   	nop    
     9d9:	90                   	nop    
     9da:	90                   	nop    
     9db:	90                   	nop    
     9dc:	90                   	nop    
     9dd:	90                   	nop    
     9de:	90                   	nop    
     9df:	90                   	nop    

000009e0 <lwip_chksum>:


static u16_t
lwip_chksum(void *dataptr, int len)
{
     9e0:	55                   	push   %ebp
     9e1:	89 e5                	mov    %esp,%ebp
     9e3:	83 ec 18             	sub    $0x18,%esp
  u32_t acc;

  LWIP_DEBUGF(INET_DEBUG, ("lwip_chksum(%p, %d)\n", (void *)dataptr, len));
  for(acc = 0; len > 1; len -= 2) {
     9e6:	c7 45 fc 00 00 00 00 	movl   $0x0,0xfffffffc(%ebp)
     9ed:	eb 19                	jmp    a08 <lwip_chksum+0x28>
      /*    acc = acc + *((u16_t *)dataptr)++;*/
    acc += *(u16_t *)dataptr;
     9ef:	8b 45 08             	mov    0x8(%ebp),%eax
     9f2:	0f b7 00             	movzwl (%eax),%eax
     9f5:	0f b7 c0             	movzwl %ax,%eax
     9f8:	01 45 fc             	add    %eax,0xfffffffc(%ebp)
    dataptr = (void *)((u16_t *)dataptr + 1);
     9fb:	8b 45 08             	mov    0x8(%ebp),%eax
     9fe:	83 c0 02             	add    $0x2,%eax
     a01:	89 45 08             	mov    %eax,0x8(%ebp)
     a04:	83 6d 0c 02          	subl   $0x2,0xc(%ebp)
     a08:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
     a0c:	7f e1                	jg     9ef <lwip_chksum+0xf>
  }

  /* add up any odd byte */
  if (len == 1) {
     a0e:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
     a12:	75 1d                	jne    a31 <lwip_chksum+0x51>
    acc += htons((u16_t)((*(u8_t *)dataptr) & 0xff) << 8);
     a14:	8b 45 08             	mov    0x8(%ebp),%eax
     a17:	0f b6 00             	movzbl (%eax),%eax
     a1a:	0f b6 c0             	movzbl %al,%eax
     a1d:	c1 e0 08             	shl    $0x8,%eax
     a20:	0f b7 c0             	movzwl %ax,%eax
     a23:	89 04 24             	mov    %eax,(%esp)
     a26:	e8 85 06 00 00       	call   10b0 <htons>
     a2b:	0f b7 c0             	movzwl %ax,%eax
     a2e:	01 45 fc             	add    %eax,0xfffffffc(%ebp)
    LWIP_DEBUGF(INET_DEBUG, ("inet: chksum: odd byte %d\n", (unsigned int)(*(u8_t *)dataptr)));
  } else {
    LWIP_DEBUGF(INET_DEBUG, ("inet: chksum: no odd byte\n"));
  }
  acc = (acc >> 16) + (acc & 0xffffUL);
     a31:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     a34:	89 c2                	mov    %eax,%edx
     a36:	c1 ea 10             	shr    $0x10,%edx
     a39:	0f b7 45 fc          	movzwl 0xfffffffc(%ebp),%eax
     a3d:	8d 04 02             	lea    (%edx,%eax,1),%eax
     a40:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)

  if ((acc & 0xffff0000) != 0) {
     a43:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     a46:	66 b8 00 00          	mov    $0x0,%ax
     a4a:	85 c0                	test   %eax,%eax
     a4c:	74 12                	je     a60 <lwip_chksum+0x80>
    acc = (acc >> 16) + (acc & 0xffffUL);
     a4e:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     a51:	89 c2                	mov    %eax,%edx
     a53:	c1 ea 10             	shr    $0x10,%edx
     a56:	0f b7 45 fc          	movzwl 0xfffffffc(%ebp),%eax
     a5a:	8d 04 02             	lea    (%edx,%eax,1),%eax
     a5d:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
  }

  return (u16_t)acc;
     a60:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     a63:	0f b7 c0             	movzwl %ax,%eax
}
     a66:	c9                   	leave  
     a67:	c3                   	ret    
     a68:	90                   	nop    
     a69:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi

00000a70 <inet_chksum_pseudo>:

/* inet_chksum_pseudo:
 *
 * Calculates the pseudo Internet checksum used by TCP and UDP for a pbuf chain.
 */

u16_t
inet_chksum_pseudo(struct pbuf *p,
       struct ip_addr *src, struct ip_addr *dest,
       u8_t proto, u16_t proto_len)
{
     a70:	55                   	push   %ebp
     a71:	89 e5                	mov    %esp,%ebp
     a73:	83 ec 28             	sub    $0x28,%esp
     a76:	8b 45 14             	mov    0x14(%ebp),%eax
     a79:	8b 55 18             	mov    0x18(%ebp),%edx
     a7c:	88 45 ec             	mov    %al,0xffffffec(%ebp)
     a7f:	66 89 55 e8          	mov    %dx,0xffffffe8(%ebp)
  u32_t acc;
  struct pbuf *q;
  u8_t swapped;

  acc = 0;
     a83:	c7 45 f4 00 00 00 00 	movl   $0x0,0xfffffff4(%ebp)
  swapped = 0;
     a8a:	c6 45 ff 00          	movb   $0x0,0xffffffff(%ebp)
  /* iterate through all pbuf in chain */
  for(q = p; q != NULL; q = q->next) {
     a8e:	8b 45 08             	mov    0x8(%ebp),%eax
     a91:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
     a94:	eb 7b                	jmp    b11 <inet_chksum_pseudo+0xa1>
    LWIP_DEBUGF(INET_DEBUG, ("inet_chksum_pseudo(): checksumming pbuf %p (has next %p) \n",
      (void *)q, (void *)q->next));
    acc += lwip_chksum(q->payload, q->len);
     a96:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     a99:	0f b7 40 0a          	movzwl 0xa(%eax),%eax
     a9d:	0f b7 d0             	movzwl %ax,%edx
     aa0:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     aa3:	8b 40 04             	mov    0x4(%eax),%eax
     aa6:	89 54 24 04          	mov    %edx,0x4(%esp)
     aaa:	89 04 24             	mov    %eax,(%esp)
     aad:	e8 2e ff ff ff       	call   9e0 <lwip_chksum>
     ab2:	0f b7 c0             	movzwl %ax,%eax
     ab5:	01 45 f4             	add    %eax,0xfffffff4(%ebp)
    /*LWIP_DEBUGF(INET_DEBUG, ("inet_chksum_pseudo(): unwrapped lwip_chksum()=%lx \n", acc));*/
    while (acc >> 16) {
     ab8:	eb 10                	jmp    aca <inet_chksum_pseudo+0x5a>
      acc = (acc & 0xffffUL) + (acc >> 16);
     aba:	0f b7 55 f4          	movzwl 0xfffffff4(%ebp),%edx
     abe:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     ac1:	c1 e8 10             	shr    $0x10,%eax
     ac4:	8d 04 02             	lea    (%edx,%eax,1),%eax
     ac7:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
     aca:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     acd:	c1 e8 10             	shr    $0x10,%eax
     ad0:	85 c0                	test   %eax,%eax
     ad2:	75 e6                	jne    aba <inet_chksum_pseudo+0x4a>
    }
    if (q->len % 2 != 0) {
     ad4:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     ad7:	0f b7 40 0a          	movzwl 0xa(%eax),%eax
     adb:	0f b7 c0             	movzwl %ax,%eax
     ade:	83 e0 01             	and    $0x1,%eax
     ae1:	84 c0                	test   %al,%al
     ae3:	74 24                	je     b09 <inet_chksum_pseudo+0x99>
      swapped = 1 - swapped;
     ae5:	b8 01 00 00 00       	mov    $0x1,%eax
     aea:	2a 45 ff             	sub    0xffffffff(%ebp),%al
     aed:	88 45 ff             	mov    %al,0xffffffff(%ebp)
      acc = ((acc & 0xff) << 8) | ((acc & 0xff00UL) >> 8);
     af0:	0f b6 45 f4          	movzbl 0xfffffff4(%ebp),%eax
     af4:	89 c2                	mov    %eax,%edx
     af6:	c1 e2 08             	shl    $0x8,%edx
     af9:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     afc:	25 00 ff 00 00       	and    $0xff00,%eax
     b01:	c1 e8 08             	shr    $0x8,%eax
     b04:	09 d0                	or     %edx,%eax
     b06:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
     b09:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     b0c:	8b 00                	mov    (%eax),%eax
     b0e:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
     b11:	83 7d f8 00          	cmpl   $0x0,0xfffffff8(%ebp)
     b15:	0f 85 7b ff ff ff    	jne    a96 <inet_chksum_pseudo+0x26>
    }
    /*LWIP_DEBUGF(INET_DEBUG, ("inet_chksum_pseudo(): wrapped lwip_chksum()=%lx \n", acc));*/
  }

  if (swapped) {
     b1b:	80 7d ff 00          	cmpb   $0x0,0xffffffff(%ebp)
     b1f:	74 19                	je     b3a <inet_chksum_pseudo+0xca>
    acc = ((acc & 0xff) << 8) | ((acc & 0xff00UL) >> 8);
     b21:	0f b6 45 f4          	movzbl 0xfffffff4(%ebp),%eax
     b25:	89 c2                	mov    %eax,%edx
     b27:	c1 e2 08             	shl    $0x8,%edx
     b2a:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     b2d:	25 00 ff 00 00       	and    $0xff00,%eax
     b32:	c1 e8 08             	shr    $0x8,%eax
     b35:	09 d0                	or     %edx,%eax
     b37:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
  }
  acc += (src->addr & 0xffffUL);
     b3a:	8b 45 0c             	mov    0xc(%ebp),%eax
     b3d:	8b 00                	mov    (%eax),%eax
     b3f:	25 ff ff 00 00       	and    $0xffff,%eax
     b44:	01 45 f4             	add    %eax,0xfffffff4(%ebp)
  acc += ((src->addr >> 16) & 0xffffUL);
     b47:	8b 45 0c             	mov    0xc(%ebp),%eax
     b4a:	8b 00                	mov    (%eax),%eax
     b4c:	c1 e8 10             	shr    $0x10,%eax
     b4f:	25 ff ff 00 00       	and    $0xffff,%eax
     b54:	01 45 f4             	add    %eax,0xfffffff4(%ebp)
  acc += (dest->addr & 0xffffUL);
     b57:	8b 45 10             	mov    0x10(%ebp),%eax
     b5a:	8b 00                	mov    (%eax),%eax
     b5c:	25 ff ff 00 00       	and    $0xffff,%eax
     b61:	01 45 f4             	add    %eax,0xfffffff4(%ebp)
  acc += ((dest->addr >> 16) & 0xffffUL);
     b64:	8b 45 10             	mov    0x10(%ebp),%eax
     b67:	8b 00                	mov    (%eax),%eax
     b69:	c1 e8 10             	shr    $0x10,%eax
     b6c:	25 ff ff 00 00       	and    $0xffff,%eax
     b71:	01 45 f4             	add    %eax,0xfffffff4(%ebp)
  acc += (u32_t)htons((u16_t)proto);
     b74:	0f b6 45 ec          	movzbl 0xffffffec(%ebp),%eax
     b78:	89 04 24             	mov    %eax,(%esp)
     b7b:	e8 30 05 00 00       	call   10b0 <htons>
     b80:	0f b7 c0             	movzwl %ax,%eax
     b83:	01 45 f4             	add    %eax,0xfffffff4(%ebp)
  acc += (u32_t)htons(proto_len);
     b86:	0f b7 45 e8          	movzwl 0xffffffe8(%ebp),%eax
     b8a:	89 04 24             	mov    %eax,(%esp)
     b8d:	e8 1e 05 00 00       	call   10b0 <htons>
     b92:	0f b7 c0             	movzwl %ax,%eax
     b95:	01 45 f4             	add    %eax,0xfffffff4(%ebp)

  while (acc >> 16) {
     b98:	eb 10                	jmp    baa <inet_chksum_pseudo+0x13a>
    acc = (acc & 0xffffUL) + (acc >> 16);
     b9a:	0f b7 55 f4          	movzwl 0xfffffff4(%ebp),%edx
     b9e:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     ba1:	c1 e8 10             	shr    $0x10,%eax
     ba4:	8d 04 02             	lea    (%edx,%eax,1),%eax
     ba7:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
     baa:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     bad:	c1 e8 10             	shr    $0x10,%eax
     bb0:	85 c0                	test   %eax,%eax
     bb2:	75 e6                	jne    b9a <inet_chksum_pseudo+0x12a>
  }
  LWIP_DEBUGF(INET_DEBUG, ("inet_chksum_pseudo(): pbuf chain lwip_chksum()=%lx\n", acc));
  return ~(acc & 0xffffUL);
     bb4:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     bb7:	f7 d0                	not    %eax
     bb9:	0f b7 c0             	movzwl %ax,%eax
}
     bbc:	c9                   	leave  
     bbd:	c3                   	ret    
     bbe:	89 f6                	mov    %esi,%esi

00000bc0 <inet_chksum>:

/* inet_chksum:
 *
 * Calculates the Internet checksum over a portion of memory. Used primarely for IP
 * and ICMP.
 */

u16_t
inet_chksum(void *dataptr, u16_t len)
{
     bc0:	55                   	push   %ebp
     bc1:	89 e5                	mov    %esp,%ebp
     bc3:	83 ec 28             	sub    $0x28,%esp
     bc6:	8b 45 0c             	mov    0xc(%ebp),%eax
     bc9:	66 89 45 ec          	mov    %ax,0xffffffec(%ebp)
  u32_t acc;

  acc = lwip_chksum(dataptr, len);
     bcd:	0f b7 45 ec          	movzwl 0xffffffec(%ebp),%eax
     bd1:	89 44 24 04          	mov    %eax,0x4(%esp)
     bd5:	8b 45 08             	mov    0x8(%ebp),%eax
     bd8:	89 04 24             	mov    %eax,(%esp)
     bdb:	e8 00 fe ff ff       	call   9e0 <lwip_chksum>
     be0:	0f b7 c0             	movzwl %ax,%eax
     be3:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
  while (acc >> 16) {
     be6:	eb 10                	jmp    bf8 <inet_chksum+0x38>
    acc = (acc & 0xffff) + (acc >> 16);
     be8:	0f b7 55 fc          	movzwl 0xfffffffc(%ebp),%edx
     bec:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     bef:	c1 e8 10             	shr    $0x10,%eax
     bf2:	8d 04 02             	lea    (%edx,%eax,1),%eax
     bf5:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
     bf8:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     bfb:	c1 e8 10             	shr    $0x10,%eax
     bfe:	85 c0                	test   %eax,%eax
     c00:	75 e6                	jne    be8 <inet_chksum+0x28>
  }
  return ~(acc & 0xffff);
     c02:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     c05:	f7 d0                	not    %eax
     c07:	0f b7 c0             	movzwl %ax,%eax
}
     c0a:	c9                   	leave  
     c0b:	c3                   	ret    
     c0c:	8d 74 26 00          	lea    0x0(%esi),%esi

00000c10 <inet_chksum_pbuf>:

u16_t
inet_chksum_pbuf(struct pbuf *p)
{
     c10:	55                   	push   %ebp
     c11:	89 e5                	mov    %esp,%ebp
     c13:	83 ec 18             	sub    $0x18,%esp
  u32_t acc;
  struct pbuf *q;
  u8_t swapped;

  acc = 0;
     c16:	c7 45 f4 00 00 00 00 	movl   $0x0,0xfffffff4(%ebp)
  swapped = 0;
     c1d:	c6 45 ff 00          	movb   $0x0,0xffffffff(%ebp)
  for(q = p; q != NULL; q = q->next) {
     c21:	8b 45 08             	mov    0x8(%ebp),%eax
     c24:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
     c27:	eb 69                	jmp    c92 <inet_chksum_pbuf+0x82>
    acc += lwip_chksum(q->payload, q->len);
     c29:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     c2c:	0f b7 40 0a          	movzwl 0xa(%eax),%eax
     c30:	0f b7 d0             	movzwl %ax,%edx
     c33:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     c36:	8b 40 04             	mov    0x4(%eax),%eax
     c39:	89 54 24 04          	mov    %edx,0x4(%esp)
     c3d:	89 04 24             	mov    %eax,(%esp)
     c40:	e8 9b fd ff ff       	call   9e0 <lwip_chksum>
     c45:	0f b7 c0             	movzwl %ax,%eax
     c48:	01 45 f4             	add    %eax,0xfffffff4(%ebp)
    while (acc >> 16) {
     c4b:	eb 10                	jmp    c5d <inet_chksum_pbuf+0x4d>
      acc = (acc & 0xffffUL) + (acc >> 16);
     c4d:	0f b7 55 f4          	movzwl 0xfffffff4(%ebp),%edx
     c51:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     c54:	c1 e8 10             	shr    $0x10,%eax
     c57:	8d 04 02             	lea    (%edx,%eax,1),%eax
     c5a:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
     c5d:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     c60:	c1 e8 10             	shr    $0x10,%eax
     c63:	85 c0                	test   %eax,%eax
     c65:	75 e6                	jne    c4d <inet_chksum_pbuf+0x3d>
    }
    if (q->len % 2 != 0) {
     c67:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     c6a:	0f b7 40 0a          	movzwl 0xa(%eax),%eax
     c6e:	0f b7 c0             	movzwl %ax,%eax
     c71:	83 e0 01             	and    $0x1,%eax
     c74:	84 c0                	test   %al,%al
     c76:	74 12                	je     c8a <inet_chksum_pbuf+0x7a>
      swapped = 1 - swapped;
     c78:	b8 01 00 00 00       	mov    $0x1,%eax
     c7d:	2a 45 ff             	sub    0xffffffff(%ebp),%al
     c80:	88 45 ff             	mov    %al,0xffffffff(%ebp)
      acc = (acc & 0x00ffUL << 8) | (acc & 0xff00UL >> 8);
     c83:	81 65 f4 ff ff 00 00 	andl   $0xffff,0xfffffff4(%ebp)
     c8a:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     c8d:	8b 00                	mov    (%eax),%eax
     c8f:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
     c92:	83 7d f8 00          	cmpl   $0x0,0xfffffff8(%ebp)
     c96:	75 91                	jne    c29 <inet_chksum_pbuf+0x19>
    }
  }

  if (swapped) {
     c98:	80 7d ff 00          	cmpb   $0x0,0xffffffff(%ebp)
     c9c:	74 19                	je     cb7 <inet_chksum_pbuf+0xa7>
    acc = ((acc & 0x00ffUL) << 8) | ((acc & 0xff00UL) >> 8);
     c9e:	0f b6 45 f4          	movzbl 0xfffffff4(%ebp),%eax
     ca2:	89 c2                	mov    %eax,%edx
     ca4:	c1 e2 08             	shl    $0x8,%edx
     ca7:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     caa:	25 00 ff 00 00       	and    $0xff00,%eax
     caf:	c1 e8 08             	shr    $0x8,%eax
     cb2:	09 d0                	or     %edx,%eax
     cb4:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
  }
  return ~(acc & 0xffffUL);
     cb7:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     cba:	f7 d0                	not    %eax
     cbc:	0f b7 c0             	movzwl %ax,%eax
}
     cbf:	c9                   	leave  
     cc0:	c3                   	ret    
     cc1:	eb 0d                	jmp    cd0 <inet_addr>
     cc3:	90                   	nop    
     cc4:	90                   	nop    
     cc5:	90                   	nop    
     cc6:	90                   	nop    
     cc7:	90                   	nop    
     cc8:	90                   	nop    
     cc9:	90                   	nop    
     cca:	90                   	nop    
     ccb:	90                   	nop    
     ccc:	90                   	nop    
     ccd:	90                   	nop    
     cce:	90                   	nop    
     ccf:	90                   	nop    

00000cd0 <inet_addr>:

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
     cd0:	55                   	push   %ebp
     cd1:	89 e5                	mov    %esp,%ebp
     cd3:	83 ec 28             	sub    $0x28,%esp
     struct in_addr val;

     if (inet_aton(cp, &val)) {
     cd6:	8d 45 fc             	lea    0xfffffffc(%ebp),%eax
     cd9:	89 44 24 04          	mov    %eax,0x4(%esp)
     cdd:	8b 45 08             	mov    0x8(%ebp),%eax
     ce0:	89 04 24             	mov    %eax,(%esp)
     ce3:	e8 18 00 00 00       	call   d00 <inet_aton>
     ce8:	85 c0                	test   %eax,%eax
     cea:	74 08                	je     cf4 <inet_addr+0x24>
         return (val.s_addr);
     cec:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     cef:	89 45 ec             	mov    %eax,0xffffffec(%ebp)
     cf2:	eb 07                	jmp    cfb <inet_addr+0x2b>
     }
     return (INADDR_NONE);
     cf4:	c7 45 ec ff ff ff ff 	movl   $0xffffffff,0xffffffec(%ebp)
     cfb:	8b 45 ec             	mov    0xffffffec(%ebp),%eax
 }
     cfe:	c9                   	leave  
     cff:	c3                   	ret    

00000d00 <inet_aton>:

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
     d00:	55                   	push   %ebp
     d01:	89 e5                	mov    %esp,%ebp
     d03:	83 ec 48             	sub    $0x48,%esp
     u32_t val;
     int base, n;
     char c;
     u32_t parts[4];
     u32_t* pp = parts;
     d06:	8d 45 dc             	lea    0xffffffdc(%ebp),%eax
     d09:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)

     c = *cp;
     d0c:	8b 45 08             	mov    0x8(%ebp),%eax
     d0f:	0f b6 00             	movzbl (%eax),%eax
     d12:	88 45 fb             	mov    %al,0xfffffffb(%ebp)
     for (;;) {
         /*
          * Collect number up to ``.''.
          * Values are specified as for C:
          * 0x=hex, 0=octal, isdigit=decimal.
          */
         if (!isdigit(c))
     d15:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
     d19:	3c 2f                	cmp    $0x2f,%al
     d1b:	76 08                	jbe    d25 <inet_aton+0x25>
     d1d:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
     d21:	3c 39                	cmp    $0x39,%al
     d23:	76 0c                	jbe    d31 <inet_aton+0x31>
             return (0);
     d25:	c7 45 c0 00 00 00 00 	movl   $0x0,0xffffffc0(%ebp)
     d2c:	e9 78 02 00 00       	jmp    fa9 <inet_aton+0x2a9>
         val = 0; base = 10;
     d31:	c7 45 ec 00 00 00 00 	movl   $0x0,0xffffffec(%ebp)
     d38:	c7 45 f0 0a 00 00 00 	movl   $0xa,0xfffffff0(%ebp)
         if (c == '0') {
     d3f:	80 7d fb 30          	cmpb   $0x30,0xfffffffb(%ebp)
     d43:	75 36                	jne    d7b <inet_aton+0x7b>
             c = *++cp;
     d45:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     d49:	8b 45 08             	mov    0x8(%ebp),%eax
     d4c:	0f b6 00             	movzbl (%eax),%eax
     d4f:	88 45 fb             	mov    %al,0xfffffffb(%ebp)
             if (c == 'x' || c == 'X')
     d52:	80 7d fb 78          	cmpb   $0x78,0xfffffffb(%ebp)
     d56:	74 06                	je     d5e <inet_aton+0x5e>
     d58:	80 7d fb 58          	cmpb   $0x58,0xfffffffb(%ebp)
     d5c:	75 16                	jne    d74 <inet_aton+0x74>
                 base = 16, c = *++cp;
     d5e:	c7 45 f0 10 00 00 00 	movl   $0x10,0xfffffff0(%ebp)
     d65:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     d69:	8b 45 08             	mov    0x8(%ebp),%eax
     d6c:	0f b6 00             	movzbl (%eax),%eax
     d6f:	88 45 fb             	mov    %al,0xfffffffb(%ebp)
     d72:	eb 07                	jmp    d7b <inet_aton+0x7b>
             else
                 base = 8;
     d74:	c7 45 f0 08 00 00 00 	movl   $0x8,0xfffffff0(%ebp)
         }
         for (;;) {
             if (isascii(c) && isdigit(c)) {
     d7b:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
     d7f:	3c 1f                	cmp    $0x1f,%al
     d81:	76 3b                	jbe    dbe <inet_aton+0xbe>
     d83:	80 7d fb 00          	cmpb   $0x0,0xfffffffb(%ebp)
     d87:	78 35                	js     dbe <inet_aton+0xbe>
     d89:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
     d8d:	3c 2f                	cmp    $0x2f,%al
     d8f:	76 2d                	jbe    dbe <inet_aton+0xbe>
     d91:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
     d95:	3c 39                	cmp    $0x39,%al
     d97:	77 25                	ja     dbe <inet_aton+0xbe>
                 val = (val * base) + (c - '0');
     d99:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
     d9c:	89 c2                	mov    %eax,%edx
     d9e:	0f af 55 ec          	imul   0xffffffec(%ebp),%edx
     da2:	0f be 45 fb          	movsbl 0xfffffffb(%ebp),%eax
     da6:	8d 04 02             	lea    (%edx,%eax,1),%eax
     da9:	83 e8 30             	sub    $0x30,%eax
     dac:	89 45 ec             	mov    %eax,0xffffffec(%ebp)
                 c = *++cp;
     daf:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     db3:	8b 45 08             	mov    0x8(%ebp),%eax
     db6:	0f b6 00             	movzbl (%eax),%eax
     db9:	88 45 fb             	mov    %al,0xfffffffb(%ebp)
     dbc:	eb bd                	jmp    d7b <inet_aton+0x7b>
             } else if (base == 16 && isascii(c) && isxdigit(c)) {
     dbe:	83 7d f0 10          	cmpl   $0x10,0xfffffff0(%ebp)
     dc2:	0f 85 99 00 00 00    	jne    e61 <inet_aton+0x161>
     dc8:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
     dcc:	3c 1f                	cmp    $0x1f,%al
     dce:	0f 86 8d 00 00 00    	jbe    e61 <inet_aton+0x161>
     dd4:	80 7d fb 00          	cmpb   $0x0,0xfffffffb(%ebp)
     dd8:	0f 88 83 00 00 00    	js     e61 <inet_aton+0x161>
     dde:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
     de2:	3c 2f                	cmp    $0x2f,%al
     de4:	76 08                	jbe    dee <inet_aton+0xee>
     de6:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
     dea:	3c 39                	cmp    $0x39,%al
     dec:	76 20                	jbe    e0e <inet_aton+0x10e>
     dee:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
     df2:	3c 60                	cmp    $0x60,%al
     df4:	76 08                	jbe    dfe <inet_aton+0xfe>
     df6:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
     dfa:	3c 66                	cmp    $0x66,%al
     dfc:	76 10                	jbe    e0e <inet_aton+0x10e>
     dfe:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
     e02:	3c 40                	cmp    $0x40,%al
     e04:	76 5b                	jbe    e61 <inet_aton+0x161>
     e06:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
     e0a:	3c 46                	cmp    $0x46,%al
     e0c:	77 53                	ja     e61 <inet_aton+0x161>
                 val = (val << 4) |
     e0e:	8b 45 ec             	mov    0xffffffec(%ebp),%eax
     e11:	89 c2                	mov    %eax,%edx
     e13:	c1 e2 04             	shl    $0x4,%edx
     e16:	89 55 c4             	mov    %edx,0xffffffc4(%ebp)
     e19:	0f be 45 fb          	movsbl 0xfffffffb(%ebp),%eax
     e1d:	83 c0 0a             	add    $0xa,%eax
     e20:	89 45 c8             	mov    %eax,0xffffffc8(%ebp)
     e23:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
     e27:	3c 60                	cmp    $0x60,%al
     e29:	76 11                	jbe    e3c <inet_aton+0x13c>
     e2b:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
     e2f:	3c 7a                	cmp    $0x7a,%al
     e31:	77 09                	ja     e3c <inet_aton+0x13c>
     e33:	c7 45 cc 61 00 00 00 	movl   $0x61,0xffffffcc(%ebp)
     e3a:	eb 07                	jmp    e43 <inet_aton+0x143>
     e3c:	c7 45 cc 41 00 00 00 	movl   $0x41,0xffffffcc(%ebp)
     e43:	8b 45 c8             	mov    0xffffffc8(%ebp),%eax
     e46:	2b 45 cc             	sub    0xffffffcc(%ebp),%eax
     e49:	0b 45 c4             	or     0xffffffc4(%ebp),%eax
     e4c:	89 45 ec             	mov    %eax,0xffffffec(%ebp)
                     (c + 10 - (islower(c) ? 'a' : 'A'));
                 c = *++cp;
     e4f:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     e53:	8b 45 08             	mov    0x8(%ebp),%eax
     e56:	0f b6 00             	movzbl (%eax),%eax
     e59:	88 45 fb             	mov    %al,0xfffffffb(%ebp)
             } else
             break;
         }
     e5c:	e9 1a ff ff ff       	jmp    d7b <inet_aton+0x7b>
         if (c == '.') {
     e61:	80 7d fb 2e          	cmpb   $0x2e,0xfffffffb(%ebp)
     e65:	75 35                	jne    e9c <inet_aton+0x19c>
             /*
              * Internet format:
              *  a.b.c.d
              *  a.b.c   (with c treated as 16 bits)
              *  a.b (with b treated as 24 bits)
              */
             if (pp >= parts + 3)
     e67:	8d 45 dc             	lea    0xffffffdc(%ebp),%eax
     e6a:	83 c0 0c             	add    $0xc,%eax
     e6d:	3b 45 fc             	cmp    0xfffffffc(%ebp),%eax
     e70:	77 0c                	ja     e7e <inet_aton+0x17e>
                 return (0);
     e72:	c7 45 c0 00 00 00 00 	movl   $0x0,0xffffffc0(%ebp)
     e79:	e9 2b 01 00 00       	jmp    fa9 <inet_aton+0x2a9>
             *pp++ = val;
     e7e:	8b 55 fc             	mov    0xfffffffc(%ebp),%edx
     e81:	8b 45 ec             	mov    0xffffffec(%ebp),%eax
     e84:	89 02                	mov    %eax,(%edx)
     e86:	83 45 fc 04          	addl   $0x4,0xfffffffc(%ebp)
             c = *++cp;
     e8a:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     e8e:	8b 45 08             	mov    0x8(%ebp),%eax
     e91:	0f b6 00             	movzbl (%eax),%eax
     e94:	88 45 fb             	mov    %al,0xfffffffb(%ebp)
         } else
             break;
     }
     e97:	e9 79 fe ff ff       	jmp    d15 <inet_aton+0x15>
     /*
      * Check for trailing characters.
      */
     if (c != '\0' && (!isascii(c) || !isspace(c)))
     e9c:	80 7d fb 00          	cmpb   $0x0,0xfffffffb(%ebp)
     ea0:	74 3e                	je     ee0 <inet_aton+0x1e0>
     ea2:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
     ea6:	3c 1f                	cmp    $0x1f,%al
     ea8:	76 2a                	jbe    ed4 <inet_aton+0x1d4>
     eaa:	80 7d fb 00          	cmpb   $0x0,0xfffffffb(%ebp)
     eae:	78 24                	js     ed4 <inet_aton+0x1d4>
     eb0:	80 7d fb 20          	cmpb   $0x20,0xfffffffb(%ebp)
     eb4:	74 2a                	je     ee0 <inet_aton+0x1e0>
     eb6:	80 7d fb 0c          	cmpb   $0xc,0xfffffffb(%ebp)
     eba:	74 24                	je     ee0 <inet_aton+0x1e0>
     ebc:	80 7d fb 0a          	cmpb   $0xa,0xfffffffb(%ebp)
     ec0:	74 1e                	je     ee0 <inet_aton+0x1e0>
     ec2:	80 7d fb 0d          	cmpb   $0xd,0xfffffffb(%ebp)
     ec6:	74 18                	je     ee0 <inet_aton+0x1e0>
     ec8:	80 7d fb 09          	cmpb   $0x9,0xfffffffb(%ebp)
     ecc:	74 12                	je     ee0 <inet_aton+0x1e0>
     ece:	80 7d fb 0b          	cmpb   $0xb,0xfffffffb(%ebp)
     ed2:	74 0c                	je     ee0 <inet_aton+0x1e0>
         return (0);
     ed4:	c7 45 c0 00 00 00 00 	movl   $0x0,0xffffffc0(%ebp)
     edb:	e9 c9 00 00 00       	jmp    fa9 <inet_aton+0x2a9>
     /*
      * Concoct the address according to
      * the number of parts specified.
      */
     n = pp - parts + 1;
     ee0:	8b 55 fc             	mov    0xfffffffc(%ebp),%edx
     ee3:	8d 45 dc             	lea    0xffffffdc(%ebp),%eax
     ee6:	89 d1                	mov    %edx,%ecx
     ee8:	29 c1                	sub    %eax,%ecx
     eea:	89 c8                	mov    %ecx,%eax
     eec:	c1 f8 02             	sar    $0x2,%eax
     eef:	83 c0 01             	add    $0x1,%eax
     ef2:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
     switch (n) {
     ef5:	83 7d f4 04          	cmpl   $0x4,0xfffffff4(%ebp)
     ef9:	0f 87 8b 00 00 00    	ja     f8a <inet_aton+0x28a>
     eff:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     f02:	c1 e0 02             	shl    $0x2,%eax
     f05:	8b 80 84 11 00 00    	mov    0x1184(%eax),%eax
     f0b:	ff e0                	jmp    *%eax

     case 0:
         return (0);     /* initial nondigit */
     f0d:	c7 45 c0 00 00 00 00 	movl   $0x0,0xffffffc0(%ebp)
     f14:	e9 90 00 00 00       	jmp    fa9 <inet_aton+0x2a9>

     case 1:             /* a -- 32 bits */
         break;

     case 2:             /* a.b -- 8.24 bits */
         if (val > 0xffffff)
     f19:	81 7d ec ff ff ff 00 	cmpl   $0xffffff,0xffffffec(%ebp)
     f20:	76 09                	jbe    f2b <inet_aton+0x22b>
             return (0);
     f22:	c7 45 c0 00 00 00 00 	movl   $0x0,0xffffffc0(%ebp)
     f29:	eb 7e                	jmp    fa9 <inet_aton+0x2a9>
         val |= parts[0] << 24;
     f2b:	8b 45 dc             	mov    0xffffffdc(%ebp),%eax
     f2e:	c1 e0 18             	shl    $0x18,%eax
     f31:	09 45 ec             	or     %eax,0xffffffec(%ebp)
         break;
     f34:	eb 54                	jmp    f8a <inet_aton+0x28a>

     case 3:             /* a.b.c -- 8.8.16 bits */
         if (val > 0xffff)
     f36:	81 7d ec ff ff 00 00 	cmpl   $0xffff,0xffffffec(%ebp)
     f3d:	76 09                	jbe    f48 <inet_aton+0x248>
             return (0);
     f3f:	c7 45 c0 00 00 00 00 	movl   $0x0,0xffffffc0(%ebp)
     f46:	eb 61                	jmp    fa9 <inet_aton+0x2a9>
         val |= (parts[0] << 24) | (parts[1] << 16);
     f48:	8b 45 dc             	mov    0xffffffdc(%ebp),%eax
     f4b:	89 c2                	mov    %eax,%edx
     f4d:	c1 e2 18             	shl    $0x18,%edx
     f50:	8b 45 e0             	mov    0xffffffe0(%ebp),%eax
     f53:	c1 e0 10             	shl    $0x10,%eax
     f56:	09 d0                	or     %edx,%eax
     f58:	09 45 ec             	or     %eax,0xffffffec(%ebp)
         break;
     f5b:	eb 2d                	jmp    f8a <inet_aton+0x28a>

     case 4:             /* a.b.c.d -- 8.8.8.8 bits */
         if (val > 0xff)
     f5d:	81 7d ec ff 00 00 00 	cmpl   $0xff,0xffffffec(%ebp)
     f64:	76 09                	jbe    f6f <inet_aton+0x26f>
             return (0);
     f66:	c7 45 c0 00 00 00 00 	movl   $0x0,0xffffffc0(%ebp)
     f6d:	eb 3a                	jmp    fa9 <inet_aton+0x2a9>
         val |= (parts[0] << 24) | (parts[1] << 16) | (parts[2] << 8);
     f6f:	8b 45 dc             	mov    0xffffffdc(%ebp),%eax
     f72:	89 c2                	mov    %eax,%edx
     f74:	c1 e2 18             	shl    $0x18,%edx
     f77:	8b 45 e0             	mov    0xffffffe0(%ebp),%eax
     f7a:	c1 e0 10             	shl    $0x10,%eax
     f7d:	09 c2                	or     %eax,%edx
     f7f:	8b 45 e4             	mov    0xffffffe4(%ebp),%eax
     f82:	c1 e0 08             	shl    $0x8,%eax
     f85:	09 d0                	or     %edx,%eax
     f87:	09 45 ec             	or     %eax,0xffffffec(%ebp)
         break;
     }
     if (addr)
     f8a:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     f8e:	74 12                	je     fa2 <inet_aton+0x2a2>
         addr->s_addr = htonl(val);
     f90:	8b 45 ec             	mov    0xffffffec(%ebp),%eax
     f93:	89 04 24             	mov    %eax,(%esp)
     f96:	e8 65 01 00 00       	call   1100 <htonl>
     f9b:	89 c2                	mov    %eax,%edx
     f9d:	8b 45 0c             	mov    0xc(%ebp),%eax
     fa0:	89 10                	mov    %edx,(%eax)
     return (1);
     fa2:	c7 45 c0 01 00 00 00 	movl   $0x1,0xffffffc0(%ebp)
     fa9:	8b 45 c0             	mov    0xffffffc0(%ebp),%eax
 }
     fac:	c9                   	leave  
     fad:	c3                   	ret    
     fae:	89 f6                	mov    %esi,%esi

00000fb0 <inet_ntoa>:

/* Convert numeric IP address into decimal dotted ASCII representation.
 * returns ptr to static buffer; not reentrant!
 */
char *inet_ntoa(struct in_addr addr)
{
     fb0:	55                   	push   %ebp
     fb1:	89 e5                	mov    %esp,%ebp
     fb3:	53                   	push   %ebx
     fb4:	83 ec 24             	sub    $0x24,%esp
  static char str[16];
  u32_t s_addr = addr.s_addr;
     fb7:	8b 45 08             	mov    0x8(%ebp),%eax
     fba:	89 45 ec             	mov    %eax,0xffffffec(%ebp)
  char inv[3];
  char *rp;
  char *ap;
  u8_t rem;
  u8_t n;
  u8_t i;

  rp = str;
     fbd:	c7 45 f0 cc 11 00 00 	movl   $0x11cc,0xfffffff0(%ebp)
  ap = (u8_t *)&s_addr;
     fc4:	8d 45 ec             	lea    0xffffffec(%ebp),%eax
     fc7:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
  for(n = 0; n < 4; n++) {
     fca:	c6 45 fa 00          	movb   $0x0,0xfffffffa(%ebp)
     fce:	e9 af 00 00 00       	jmp    1082 <inet_ntoa+0xd2>
    i = 0;
     fd3:	c6 45 fb 00          	movb   $0x0,0xfffffffb(%ebp)
    do {
      rem = *ap % (u8_t)10;
     fd7:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     fda:	0f b6 08             	movzbl (%eax),%ecx
     fdd:	b8 67 00 00 00       	mov    $0x67,%eax
     fe2:	f6 e9                	imul   %cl
     fe4:	66 c1 e8 08          	shr    $0x8,%ax
     fe8:	89 c2                	mov    %eax,%edx
     fea:	c0 fa 02             	sar    $0x2,%dl
     fed:	89 c8                	mov    %ecx,%eax
     fef:	c0 f8 07             	sar    $0x7,%al
     ff2:	89 d3                	mov    %edx,%ebx
     ff4:	28 c3                	sub    %al,%bl
     ff6:	88 5d db             	mov    %bl,0xffffffdb(%ebp)
     ff9:	0f b6 45 db          	movzbl 0xffffffdb(%ebp),%eax
     ffd:	c1 e0 02             	shl    $0x2,%eax
    1000:	02 45 db             	add    0xffffffdb(%ebp),%al
    1003:	01 c0                	add    %eax,%eax
    1005:	89 ca                	mov    %ecx,%edx
    1007:	28 c2                	sub    %al,%dl
    1009:	88 55 db             	mov    %dl,0xffffffdb(%ebp)
    100c:	0f b6 5d db          	movzbl 0xffffffdb(%ebp),%ebx
    1010:	88 5d f9             	mov    %bl,0xfffffff9(%ebp)
      *ap /= (u8_t)10;
    1013:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
    1016:	0f b6 08             	movzbl (%eax),%ecx
    1019:	b8 67 00 00 00       	mov    $0x67,%eax
    101e:	f6 e9                	imul   %cl
    1020:	66 c1 e8 08          	shr    $0x8,%ax
    1024:	89 c2                	mov    %eax,%edx
    1026:	c0 fa 02             	sar    $0x2,%dl
    1029:	89 c8                	mov    %ecx,%eax
    102b:	c0 f8 07             	sar    $0x7,%al
    102e:	28 c2                	sub    %al,%dl
    1030:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
    1033:	88 10                	mov    %dl,(%eax)
      inv[i++] = '0' + rem;
    1035:	0f b6 55 fb          	movzbl 0xfffffffb(%ebp),%edx
    1039:	0f b6 45 f9          	movzbl 0xfffffff9(%ebp),%eax
    103d:	83 c0 30             	add    $0x30,%eax
    1040:	88 44 15 e9          	mov    %al,0xffffffe9(%ebp,%edx,1)
    1044:	80 45 fb 01          	addb   $0x1,0xfffffffb(%ebp)
    } while(*ap);
    1048:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
    104b:	0f b6 00             	movzbl (%eax),%eax
    104e:	84 c0                	test   %al,%al
    1050:	75 85                	jne    fd7 <inet_ntoa+0x27>
    while(i--)
    1052:	eb 12                	jmp    1066 <inet_ntoa+0xb6>
      *rp++ = inv[i];
    1054:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
    1058:	0f b6 54 05 e9       	movzbl 0xffffffe9(%ebp,%eax,1),%edx
    105d:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
    1060:	88 10                	mov    %dl,(%eax)
    1062:	83 45 f0 01          	addl   $0x1,0xfffffff0(%ebp)
    1066:	80 6d fb 01          	subb   $0x1,0xfffffffb(%ebp)
    106a:	80 7d fb ff          	cmpb   $0xff,0xfffffffb(%ebp)
    106e:	75 e4                	jne    1054 <inet_ntoa+0xa4>
    *rp++ = '.';
    1070:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
    1073:	c6 00 2e             	movb   $0x2e,(%eax)
    1076:	83 45 f0 01          	addl   $0x1,0xfffffff0(%ebp)
    ap++;
    107a:	83 45 f4 01          	addl   $0x1,0xfffffff4(%ebp)
    107e:	80 45 fa 01          	addb   $0x1,0xfffffffa(%ebp)
    1082:	80 7d fa 03          	cmpb   $0x3,0xfffffffa(%ebp)
    1086:	0f 86 47 ff ff ff    	jbe    fd3 <inet_ntoa+0x23>
  }
  *--rp = 0;
    108c:	83 6d f0 01          	subl   $0x1,0xfffffff0(%ebp)
    1090:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
    1093:	c6 00 00             	movb   $0x0,(%eax)
  return str;
    1096:	b8 cc 11 00 00       	mov    $0x11cc,%eax
}
    109b:	83 c4 24             	add    $0x24,%esp
    109e:	5b                   	pop    %ebx
    109f:	5d                   	pop    %ebp
    10a0:	c3                   	ret    
    10a1:	eb 0d                	jmp    10b0 <htons>
    10a3:	90                   	nop    
    10a4:	90                   	nop    
    10a5:	90                   	nop    
    10a6:	90                   	nop    
    10a7:	90                   	nop    
    10a8:	90                   	nop    
    10a9:	90                   	nop    
    10aa:	90                   	nop    
    10ab:	90                   	nop    
    10ac:	90                   	nop    
    10ad:	90                   	nop    
    10ae:	90                   	nop    
    10af:	90                   	nop    

000010b0 <htons>:


#ifndef BYTE_ORDER
#error BYTE_ORDER is not defined
#endif
#if BYTE_ORDER == LITTLE_ENDIAN

u16_t
htons(u16_t n)
{
    10b0:	55                   	push   %ebp
    10b1:	89 e5                	mov    %esp,%ebp
    10b3:	83 ec 04             	sub    $0x4,%esp
    10b6:	8b 45 08             	mov    0x8(%ebp),%eax
    10b9:	66 89 45 fc          	mov    %ax,0xfffffffc(%ebp)
  return ((n & 0xff) << 8) | ((n & 0xff00) >> 8);
    10bd:	0f b7 45 fc          	movzwl 0xfffffffc(%ebp),%eax
    10c1:	25 ff 00 00 00       	and    $0xff,%eax
    10c6:	c1 e0 08             	shl    $0x8,%eax
    10c9:	89 c2                	mov    %eax,%edx
    10cb:	0f b7 45 fc          	movzwl 0xfffffffc(%ebp),%eax
    10cf:	25 00 ff 00 00       	and    $0xff00,%eax
    10d4:	c1 f8 08             	sar    $0x8,%eax
    10d7:	09 d0                	or     %edx,%eax
    10d9:	0f b7 c0             	movzwl %ax,%eax
}
    10dc:	c9                   	leave  
    10dd:	c3                   	ret    
    10de:	89 f6                	mov    %esi,%esi

000010e0 <ntohs>:

u16_t
ntohs(u16_t n)
{
    10e0:	55                   	push   %ebp
    10e1:	89 e5                	mov    %esp,%ebp
    10e3:	83 ec 08             	sub    $0x8,%esp
    10e6:	8b 45 08             	mov    0x8(%ebp),%eax
    10e9:	66 89 45 fc          	mov    %ax,0xfffffffc(%ebp)
  return htons(n);
    10ed:	0f b7 45 fc          	movzwl 0xfffffffc(%ebp),%eax
    10f1:	89 04 24             	mov    %eax,(%esp)
    10f4:	e8 b7 ff ff ff       	call   10b0 <htons>
    10f9:	0f b7 c0             	movzwl %ax,%eax
}
    10fc:	c9                   	leave  
    10fd:	c3                   	ret    
    10fe:	89 f6                	mov    %esi,%esi

00001100 <htonl>:

u32_t
htonl(u32_t n)
{
    1100:	55                   	push   %ebp
    1101:	89 e5                	mov    %esp,%ebp
  return ((n & 0xff) << 24) |
    1103:	0f b6 45 08          	movzbl 0x8(%ebp),%eax
    1107:	89 c2                	mov    %eax,%edx
    1109:	c1 e2 18             	shl    $0x18,%edx
    110c:	8b 45 08             	mov    0x8(%ebp),%eax
    110f:	25 00 ff 00 00       	and    $0xff00,%eax
    1114:	c1 e0 08             	shl    $0x8,%eax
    1117:	09 c2                	or     %eax,%edx
    1119:	8b 45 08             	mov    0x8(%ebp),%eax
    111c:	25 00 00 ff 00       	and    $0xff0000,%eax
    1121:	c1 e8 08             	shr    $0x8,%eax
    1124:	09 c2                	or     %eax,%edx
    1126:	8b 45 08             	mov    0x8(%ebp),%eax
    1129:	25 00 00 00 ff       	and    $0xff000000,%eax
    112e:	c1 e8 18             	shr    $0x18,%eax
    1131:	09 d0                	or     %edx,%eax
    ((n & 0xff00) << 8) |
    ((n & 0xff0000) >> 8) |
    ((n & 0xff000000) >> 24);
}
    1133:	5d                   	pop    %ebp
    1134:	c3                   	ret    
    1135:	8d 74 26 00          	lea    0x0(%esi),%esi
    1139:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00001140 <ntohl>:

u32_t
ntohl(u32_t n)
{
    1140:	55                   	push   %ebp
    1141:	89 e5                	mov    %esp,%ebp
    1143:	83 ec 04             	sub    $0x4,%esp
  return htonl(n);
    1146:	8b 45 08             	mov    0x8(%ebp),%eax
    1149:	89 04 24             	mov    %eax,(%esp)
    114c:	e8 af ff ff ff       	call   1100 <htonl>
}
    1151:	c9                   	leave  
    1152:	c3                   	ret    
