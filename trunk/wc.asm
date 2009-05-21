
_wc:     file format elf32-i386-freebsd

Disassembly of section .text:

00000000 <wc>:
char buf[512];

void
wc(int fd, char *name)
{
       0:	55                   	push   %ebp
       1:	89 e5                	mov    %esp,%ebp
       3:	83 ec 38             	sub    $0x38,%esp
  int i, n;
  int l, w, c, inword;

  l = w = c = 0;
       6:	c7 45 f8 00 00 00 00 	movl   $0x0,0xfffffff8(%ebp)
       d:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
      10:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
      13:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
      16:	89 45 f0             	mov    %eax,0xfffffff0(%ebp)
  inword = 0;
      19:	c7 45 fc 00 00 00 00 	movl   $0x0,0xfffffffc(%ebp)
  while((n = read(fd, buf, sizeof(buf))) > 0){
      20:	eb 66                	jmp    88 <wc+0x88>
    for(i=0; i<n; i++){
      22:	c7 45 e8 00 00 00 00 	movl   $0x0,0xffffffe8(%ebp)
      29:	eb 55                	jmp    80 <wc+0x80>
      c++;
      2b:	83 45 f8 01          	addl   $0x1,0xfffffff8(%ebp)
      if(buf[i] == '\n')
      2f:	8b 45 e8             	mov    0xffffffe8(%ebp),%eax
      32:	0f b6 80 a0 12 00 00 	movzbl 0x12a0(%eax),%eax
      39:	3c 0a                	cmp    $0xa,%al
      3b:	75 04                	jne    41 <wc+0x41>
        l++;
      3d:	83 45 f0 01          	addl   $0x1,0xfffffff0(%ebp)
      if(strchr(" \r\t\n\v", buf[i]))
      41:	8b 45 e8             	mov    0xffffffe8(%ebp),%eax
      44:	0f b6 80 a0 12 00 00 	movzbl 0x12a0(%eax),%eax
      4b:	0f be c0             	movsbl %al,%eax
      4e:	89 44 24 04          	mov    %eax,0x4(%esp)
      52:	c7 04 24 04 12 00 00 	movl   $0x1204,(%esp)
      59:	e8 72 02 00 00       	call   2d0 <strchr>
      5e:	85 c0                	test   %eax,%eax
      60:	74 09                	je     6b <wc+0x6b>
        inword = 0;
      62:	c7 45 fc 00 00 00 00 	movl   $0x0,0xfffffffc(%ebp)
      69:	eb 11                	jmp    7c <wc+0x7c>
      else if(!inword){
      6b:	83 7d fc 00          	cmpl   $0x0,0xfffffffc(%ebp)
      6f:	75 0b                	jne    7c <wc+0x7c>
        w++;
      71:	83 45 f4 01          	addl   $0x1,0xfffffff4(%ebp)
        inword = 1;
      75:	c7 45 fc 01 00 00 00 	movl   $0x1,0xfffffffc(%ebp)
      7c:	83 45 e8 01          	addl   $0x1,0xffffffe8(%ebp)
      80:	8b 45 e8             	mov    0xffffffe8(%ebp),%eax
      83:	3b 45 ec             	cmp    0xffffffec(%ebp),%eax
      86:	7c a3                	jl     2b <wc+0x2b>
      88:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
      8f:	00 
      90:	c7 44 24 04 a0 12 00 	movl   $0x12a0,0x4(%esp)
      97:	00 
      98:	8b 45 08             	mov    0x8(%ebp),%eax
      9b:	89 04 24             	mov    %eax,(%esp)
      9e:	e8 e9 03 00 00       	call   48c <read>
      a3:	89 45 ec             	mov    %eax,0xffffffec(%ebp)
      a6:	83 7d ec 00          	cmpl   $0x0,0xffffffec(%ebp)
      aa:	0f 8f 72 ff ff ff    	jg     22 <wc+0x22>
      }
    }
  }
  if(n < 0){
      b0:	83 7d ec 00          	cmpl   $0x0,0xffffffec(%ebp)
      b4:	79 19                	jns    cf <wc+0xcf>
    printf(1, "wc: read error\n");
      b6:	c7 44 24 04 0a 12 00 	movl   $0x120a,0x4(%esp)
      bd:	00 
      be:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
      c5:	e8 b6 05 00 00       	call   680 <printf>
    exit();
      ca:	e8 a5 03 00 00       	call   474 <exit>
  }
  printf(1, "%d %d %d %s\n", l, w, c, name);
      cf:	8b 45 0c             	mov    0xc(%ebp),%eax
      d2:	89 44 24 14          	mov    %eax,0x14(%esp)
      d6:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
      d9:	89 44 24 10          	mov    %eax,0x10(%esp)
      dd:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
      e0:	89 44 24 0c          	mov    %eax,0xc(%esp)
      e4:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
      e7:	89 44 24 08          	mov    %eax,0x8(%esp)
      eb:	c7 44 24 04 1a 12 00 	movl   $0x121a,0x4(%esp)
      f2:	00 
      f3:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
      fa:	e8 81 05 00 00       	call   680 <printf>
}
      ff:	c9                   	leave  
     100:	c3                   	ret    
     101:	eb 0d                	jmp    110 <main>
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

00000110 <main>:

int
main(int argc, char *argv[])
{
     110:	8d 4c 24 04          	lea    0x4(%esp),%ecx
     114:	83 e4 f0             	and    $0xfffffff0,%esp
     117:	ff 71 fc             	pushl  0xfffffffc(%ecx)
     11a:	55                   	push   %ebp
     11b:	89 e5                	mov    %esp,%ebp
     11d:	51                   	push   %ecx
     11e:	83 ec 24             	sub    $0x24,%esp
     121:	89 4d e8             	mov    %ecx,0xffffffe8(%ebp)
  int fd, i;

  if(argc <= 1){
     124:	8b 45 e8             	mov    0xffffffe8(%ebp),%eax
     127:	83 38 01             	cmpl   $0x1,(%eax)
     12a:	7f 19                	jg     145 <main+0x35>
    wc(0, "");
     12c:	c7 44 24 04 27 12 00 	movl   $0x1227,0x4(%esp)
     133:	00 
     134:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     13b:	e8 c0 fe ff ff       	call   0 <wc>
    exit();
     140:	e8 2f 03 00 00       	call   474 <exit>
  }

  for(i = 1; i < argc; i++){
     145:	c7 45 f8 01 00 00 00 	movl   $0x1,0xfffffff8(%ebp)
     14c:	eb 7e                	jmp    1cc <main+0xbc>
    if((fd = open(argv[i], 0)) < 0){
     14e:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     151:	c1 e0 02             	shl    $0x2,%eax
     154:	8b 55 e8             	mov    0xffffffe8(%ebp),%edx
     157:	03 42 04             	add    0x4(%edx),%eax
     15a:	8b 00                	mov    (%eax),%eax
     15c:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     163:	00 
     164:	89 04 24             	mov    %eax,(%esp)
     167:	e8 48 03 00 00       	call   4b4 <open>
     16c:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
     16f:	83 7d f4 00          	cmpl   $0x0,0xfffffff4(%ebp)
     173:	79 2b                	jns    1a0 <main+0x90>
      printf(1, "cat: cannot open %s\n", argv[i]);
     175:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     178:	c1 e0 02             	shl    $0x2,%eax
     17b:	8b 55 e8             	mov    0xffffffe8(%ebp),%edx
     17e:	03 42 04             	add    0x4(%edx),%eax
     181:	8b 00                	mov    (%eax),%eax
     183:	89 44 24 08          	mov    %eax,0x8(%esp)
     187:	c7 44 24 04 28 12 00 	movl   $0x1228,0x4(%esp)
     18e:	00 
     18f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     196:	e8 e5 04 00 00       	call   680 <printf>
      exit();
     19b:	e8 d4 02 00 00       	call   474 <exit>
    }
    wc(fd, argv[i]);
     1a0:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     1a3:	c1 e0 02             	shl    $0x2,%eax
     1a6:	8b 55 e8             	mov    0xffffffe8(%ebp),%edx
     1a9:	03 42 04             	add    0x4(%edx),%eax
     1ac:	8b 00                	mov    (%eax),%eax
     1ae:	89 44 24 04          	mov    %eax,0x4(%esp)
     1b2:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     1b5:	89 04 24             	mov    %eax,(%esp)
     1b8:	e8 43 fe ff ff       	call   0 <wc>
    close(fd);
     1bd:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     1c0:	89 04 24             	mov    %eax,(%esp)
     1c3:	e8 d4 02 00 00       	call   49c <close>
     1c8:	83 45 f8 01          	addl   $0x1,0xfffffff8(%ebp)
     1cc:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     1cf:	8b 55 e8             	mov    0xffffffe8(%ebp),%edx
     1d2:	3b 02                	cmp    (%edx),%eax
     1d4:	0f 8c 74 ff ff ff    	jl     14e <main+0x3e>
  }
  exit();
     1da:	e8 95 02 00 00       	call   474 <exit>
     1df:	90                   	nop    

000001e0 <strcpy>:
#include "user.h"

char*
strcpy(char *s, char *t)
{
     1e0:	55                   	push   %ebp
     1e1:	89 e5                	mov    %esp,%ebp
     1e3:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
     1e6:	8b 45 08             	mov    0x8(%ebp),%eax
     1e9:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
  while((*s++ = *t++) != 0)
     1ec:	8b 45 0c             	mov    0xc(%ebp),%eax
     1ef:	0f b6 10             	movzbl (%eax),%edx
     1f2:	8b 45 08             	mov    0x8(%ebp),%eax
     1f5:	88 10                	mov    %dl,(%eax)
     1f7:	8b 45 08             	mov    0x8(%ebp),%eax
     1fa:	0f b6 00             	movzbl (%eax),%eax
     1fd:	84 c0                	test   %al,%al
     1ff:	0f 95 c0             	setne  %al
     202:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     206:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
     20a:	84 c0                	test   %al,%al
     20c:	75 de                	jne    1ec <strcpy+0xc>
    ;
  return os;
     20e:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
}
     211:	c9                   	leave  
     212:	c3                   	ret    
     213:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     219:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00000220 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     220:	55                   	push   %ebp
     221:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
     223:	eb 08                	jmp    22d <strcmp+0xd>
    p++, q++;
     225:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     229:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
     22d:	8b 45 08             	mov    0x8(%ebp),%eax
     230:	0f b6 00             	movzbl (%eax),%eax
     233:	84 c0                	test   %al,%al
     235:	74 10                	je     247 <strcmp+0x27>
     237:	8b 45 08             	mov    0x8(%ebp),%eax
     23a:	0f b6 10             	movzbl (%eax),%edx
     23d:	8b 45 0c             	mov    0xc(%ebp),%eax
     240:	0f b6 00             	movzbl (%eax),%eax
     243:	38 c2                	cmp    %al,%dl
     245:	74 de                	je     225 <strcmp+0x5>
  return (uchar)*p - (uchar)*q;
     247:	8b 45 08             	mov    0x8(%ebp),%eax
     24a:	0f b6 00             	movzbl (%eax),%eax
     24d:	0f b6 d0             	movzbl %al,%edx
     250:	8b 45 0c             	mov    0xc(%ebp),%eax
     253:	0f b6 00             	movzbl (%eax),%eax
     256:	0f b6 c0             	movzbl %al,%eax
     259:	89 d1                	mov    %edx,%ecx
     25b:	29 c1                	sub    %eax,%ecx
     25d:	89 c8                	mov    %ecx,%eax
}
     25f:	5d                   	pop    %ebp
     260:	c3                   	ret    
     261:	eb 0d                	jmp    270 <strlen>
     263:	90                   	nop    
     264:	90                   	nop    
     265:	90                   	nop    
     266:	90                   	nop    
     267:	90                   	nop    
     268:	90                   	nop    
     269:	90                   	nop    
     26a:	90                   	nop    
     26b:	90                   	nop    
     26c:	90                   	nop    
     26d:	90                   	nop    
     26e:	90                   	nop    
     26f:	90                   	nop    

00000270 <strlen>:

uint
strlen(char *s)
{
     270:	55                   	push   %ebp
     271:	89 e5                	mov    %esp,%ebp
     273:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
     276:	c7 45 fc 00 00 00 00 	movl   $0x0,0xfffffffc(%ebp)
     27d:	eb 04                	jmp    283 <strlen+0x13>
     27f:	83 45 fc 01          	addl   $0x1,0xfffffffc(%ebp)
     283:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     286:	03 45 08             	add    0x8(%ebp),%eax
     289:	0f b6 00             	movzbl (%eax),%eax
     28c:	84 c0                	test   %al,%al
     28e:	75 ef                	jne    27f <strlen+0xf>
    ;
  return n;
     290:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
}
     293:	c9                   	leave  
     294:	c3                   	ret    
     295:	8d 74 26 00          	lea    0x0(%esi),%esi
     299:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

000002a0 <memset>:

void*
memset(void *dst, int c, uint n)
{
     2a0:	55                   	push   %ebp
     2a1:	89 e5                	mov    %esp,%ebp
     2a3:	83 ec 10             	sub    $0x10,%esp
  char *d;
  
  d = dst;
     2a6:	8b 45 08             	mov    0x8(%ebp),%eax
     2a9:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
  while(n-- > 0)
     2ac:	eb 0e                	jmp    2bc <memset+0x1c>
    *d++ = c;
     2ae:	8b 45 0c             	mov    0xc(%ebp),%eax
     2b1:	89 c2                	mov    %eax,%edx
     2b3:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     2b6:	88 10                	mov    %dl,(%eax)
     2b8:	83 45 fc 01          	addl   $0x1,0xfffffffc(%ebp)
     2bc:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
     2c0:	83 7d 10 ff          	cmpl   $0xffffffff,0x10(%ebp)
     2c4:	75 e8                	jne    2ae <memset+0xe>
  return dst;
     2c6:	8b 45 08             	mov    0x8(%ebp),%eax
}
     2c9:	c9                   	leave  
     2ca:	c3                   	ret    
     2cb:	90                   	nop    
     2cc:	8d 74 26 00          	lea    0x0(%esi),%esi

000002d0 <strchr>:

char*
strchr(const char *s, char c)
{
     2d0:	55                   	push   %ebp
     2d1:	89 e5                	mov    %esp,%ebp
     2d3:	83 ec 08             	sub    $0x8,%esp
     2d6:	8b 45 0c             	mov    0xc(%ebp),%eax
     2d9:	88 45 fc             	mov    %al,0xfffffffc(%ebp)
  for(; *s; s++)
     2dc:	eb 17                	jmp    2f5 <strchr+0x25>
    if(*s == c)
     2de:	8b 45 08             	mov    0x8(%ebp),%eax
     2e1:	0f b6 00             	movzbl (%eax),%eax
     2e4:	3a 45 fc             	cmp    0xfffffffc(%ebp),%al
     2e7:	75 08                	jne    2f1 <strchr+0x21>
      return (char*) s;
     2e9:	8b 45 08             	mov    0x8(%ebp),%eax
     2ec:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
     2ef:	eb 15                	jmp    306 <strchr+0x36>
     2f1:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     2f5:	8b 45 08             	mov    0x8(%ebp),%eax
     2f8:	0f b6 00             	movzbl (%eax),%eax
     2fb:	84 c0                	test   %al,%al
     2fd:	75 df                	jne    2de <strchr+0xe>
  return 0;
     2ff:	c7 45 f8 00 00 00 00 	movl   $0x0,0xfffffff8(%ebp)
     306:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
}
     309:	c9                   	leave  
     30a:	c3                   	ret    
     30b:	90                   	nop    
     30c:	8d 74 26 00          	lea    0x0(%esi),%esi

00000310 <gets>:

char*
gets(char *buf, int max)
{
     310:	55                   	push   %ebp
     311:	89 e5                	mov    %esp,%ebp
     313:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     316:	c7 45 f8 00 00 00 00 	movl   $0x0,0xfffffff8(%ebp)
     31d:	eb 46                	jmp    365 <gets+0x55>
    cc = read(0, &c, 1);
     31f:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
     326:	00 
     327:	8d 45 f7             	lea    0xfffffff7(%ebp),%eax
     32a:	89 44 24 04          	mov    %eax,0x4(%esp)
     32e:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     335:	e8 52 01 00 00       	call   48c <read>
     33a:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
    if(cc < 1)
     33d:	83 7d fc 00          	cmpl   $0x0,0xfffffffc(%ebp)
     341:	7e 2d                	jle    370 <gets+0x60>
      break;
    buf[i++] = c;
     343:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     346:	89 c2                	mov    %eax,%edx
     348:	03 55 08             	add    0x8(%ebp),%edx
     34b:	0f b6 45 f7          	movzbl 0xfffffff7(%ebp),%eax
     34f:	88 02                	mov    %al,(%edx)
     351:	83 45 f8 01          	addl   $0x1,0xfffffff8(%ebp)
    if(c == '\n' || c == '\r')
     355:	0f b6 45 f7          	movzbl 0xfffffff7(%ebp),%eax
     359:	3c 0a                	cmp    $0xa,%al
     35b:	74 13                	je     370 <gets+0x60>
     35d:	0f b6 45 f7          	movzbl 0xfffffff7(%ebp),%eax
     361:	3c 0d                	cmp    $0xd,%al
     363:	74 0b                	je     370 <gets+0x60>
     365:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     368:	83 c0 01             	add    $0x1,%eax
     36b:	3b 45 0c             	cmp    0xc(%ebp),%eax
     36e:	7c af                	jl     31f <gets+0xf>
      break;
  }
  buf[i] = '\0';
     370:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     373:	03 45 08             	add    0x8(%ebp),%eax
     376:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
     379:	8b 45 08             	mov    0x8(%ebp),%eax
}
     37c:	c9                   	leave  
     37d:	c3                   	ret    
     37e:	89 f6                	mov    %esi,%esi

00000380 <stat>:

int
stat(char *n, struct stat *st)
{
     380:	55                   	push   %ebp
     381:	89 e5                	mov    %esp,%ebp
     383:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     386:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     38d:	00 
     38e:	8b 45 08             	mov    0x8(%ebp),%eax
     391:	89 04 24             	mov    %eax,(%esp)
     394:	e8 1b 01 00 00       	call   4b4 <open>
     399:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
  if(fd < 0)
     39c:	83 7d f8 00          	cmpl   $0x0,0xfffffff8(%ebp)
     3a0:	79 09                	jns    3ab <stat+0x2b>
    return -1;
     3a2:	c7 45 ec ff ff ff ff 	movl   $0xffffffff,0xffffffec(%ebp)
     3a9:	eb 26                	jmp    3d1 <stat+0x51>
  r = fstat(fd, st);
     3ab:	8b 45 0c             	mov    0xc(%ebp),%eax
     3ae:	89 44 24 04          	mov    %eax,0x4(%esp)
     3b2:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     3b5:	89 04 24             	mov    %eax,(%esp)
     3b8:	e8 0f 01 00 00       	call   4cc <fstat>
     3bd:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
  close(fd);
     3c0:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     3c3:	89 04 24             	mov    %eax,(%esp)
     3c6:	e8 d1 00 00 00       	call   49c <close>
  return r;
     3cb:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     3ce:	89 45 ec             	mov    %eax,0xffffffec(%ebp)
     3d1:	8b 45 ec             	mov    0xffffffec(%ebp),%eax
}
     3d4:	c9                   	leave  
     3d5:	c3                   	ret    
     3d6:	8d 76 00             	lea    0x0(%esi),%esi
     3d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

000003e0 <atoi>:

int
atoi(const char *s)
{
     3e0:	55                   	push   %ebp
     3e1:	89 e5                	mov    %esp,%ebp
     3e3:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
     3e6:	c7 45 fc 00 00 00 00 	movl   $0x0,0xfffffffc(%ebp)
  while('0' <= *s && *s <= '9')
     3ed:	eb 24                	jmp    413 <atoi+0x33>
    n = n*10 + *s++ - '0';
     3ef:	8b 55 fc             	mov    0xfffffffc(%ebp),%edx
     3f2:	89 d0                	mov    %edx,%eax
     3f4:	c1 e0 02             	shl    $0x2,%eax
     3f7:	01 d0                	add    %edx,%eax
     3f9:	01 c0                	add    %eax,%eax
     3fb:	89 c2                	mov    %eax,%edx
     3fd:	8b 45 08             	mov    0x8(%ebp),%eax
     400:	0f b6 00             	movzbl (%eax),%eax
     403:	0f be c0             	movsbl %al,%eax
     406:	8d 04 02             	lea    (%edx,%eax,1),%eax
     409:	83 e8 30             	sub    $0x30,%eax
     40c:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
     40f:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     413:	8b 45 08             	mov    0x8(%ebp),%eax
     416:	0f b6 00             	movzbl (%eax),%eax
     419:	3c 2f                	cmp    $0x2f,%al
     41b:	7e 0a                	jle    427 <atoi+0x47>
     41d:	8b 45 08             	mov    0x8(%ebp),%eax
     420:	0f b6 00             	movzbl (%eax),%eax
     423:	3c 39                	cmp    $0x39,%al
     425:	7e c8                	jle    3ef <atoi+0xf>
  return n;
     427:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
}
     42a:	c9                   	leave  
     42b:	c3                   	ret    
     42c:	8d 74 26 00          	lea    0x0(%esi),%esi

00000430 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
     430:	55                   	push   %ebp
     431:	89 e5                	mov    %esp,%ebp
     433:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
     436:	8b 45 08             	mov    0x8(%ebp),%eax
     439:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
  src = vsrc;
     43c:	8b 45 0c             	mov    0xc(%ebp),%eax
     43f:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
  while(n-- > 0)
     442:	eb 13                	jmp    457 <memmove+0x27>
    *dst++ = *src++;
     444:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     447:	0f b6 10             	movzbl (%eax),%edx
     44a:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     44d:	88 10                	mov    %dl,(%eax)
     44f:	83 45 f8 01          	addl   $0x1,0xfffffff8(%ebp)
     453:	83 45 fc 01          	addl   $0x1,0xfffffffc(%ebp)
     457:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     45b:	0f 9f c0             	setg   %al
     45e:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
     462:	84 c0                	test   %al,%al
     464:	75 de                	jne    444 <memmove+0x14>
  return vdst;
     466:	8b 45 08             	mov    0x8(%ebp),%eax
}
     469:	c9                   	leave  
     46a:	c3                   	ret    
     46b:	90                   	nop    

0000046c <fork>:
     46c:	b8 01 00 00 00       	mov    $0x1,%eax
     471:	cd 30                	int    $0x30
     473:	c3                   	ret    

00000474 <exit>:
     474:	b8 02 00 00 00       	mov    $0x2,%eax
     479:	cd 30                	int    $0x30
     47b:	c3                   	ret    

0000047c <wait>:
     47c:	b8 03 00 00 00       	mov    $0x3,%eax
     481:	cd 30                	int    $0x30
     483:	c3                   	ret    

00000484 <pipe>:
     484:	b8 04 00 00 00       	mov    $0x4,%eax
     489:	cd 30                	int    $0x30
     48b:	c3                   	ret    

0000048c <read>:
     48c:	b8 06 00 00 00       	mov    $0x6,%eax
     491:	cd 30                	int    $0x30
     493:	c3                   	ret    

00000494 <write>:
     494:	b8 05 00 00 00       	mov    $0x5,%eax
     499:	cd 30                	int    $0x30
     49b:	c3                   	ret    

0000049c <close>:
     49c:	b8 07 00 00 00       	mov    $0x7,%eax
     4a1:	cd 30                	int    $0x30
     4a3:	c3                   	ret    

000004a4 <kill>:
     4a4:	b8 08 00 00 00       	mov    $0x8,%eax
     4a9:	cd 30                	int    $0x30
     4ab:	c3                   	ret    

000004ac <exec>:
     4ac:	b8 09 00 00 00       	mov    $0x9,%eax
     4b1:	cd 30                	int    $0x30
     4b3:	c3                   	ret    

000004b4 <open>:
     4b4:	b8 0a 00 00 00       	mov    $0xa,%eax
     4b9:	cd 30                	int    $0x30
     4bb:	c3                   	ret    

000004bc <mknod>:
     4bc:	b8 0b 00 00 00       	mov    $0xb,%eax
     4c1:	cd 30                	int    $0x30
     4c3:	c3                   	ret    

000004c4 <unlink>:
     4c4:	b8 0c 00 00 00       	mov    $0xc,%eax
     4c9:	cd 30                	int    $0x30
     4cb:	c3                   	ret    

000004cc <fstat>:
     4cc:	b8 0d 00 00 00       	mov    $0xd,%eax
     4d1:	cd 30                	int    $0x30
     4d3:	c3                   	ret    

000004d4 <link>:
     4d4:	b8 0e 00 00 00       	mov    $0xe,%eax
     4d9:	cd 30                	int    $0x30
     4db:	c3                   	ret    

000004dc <mkdir>:
     4dc:	b8 0f 00 00 00       	mov    $0xf,%eax
     4e1:	cd 30                	int    $0x30
     4e3:	c3                   	ret    

000004e4 <chdir>:
     4e4:	b8 10 00 00 00       	mov    $0x10,%eax
     4e9:	cd 30                	int    $0x30
     4eb:	c3                   	ret    

000004ec <dup>:
     4ec:	b8 11 00 00 00       	mov    $0x11,%eax
     4f1:	cd 30                	int    $0x30
     4f3:	c3                   	ret    

000004f4 <getpid>:
     4f4:	b8 12 00 00 00       	mov    $0x12,%eax
     4f9:	cd 30                	int    $0x30
     4fb:	c3                   	ret    

000004fc <sbrk>:
     4fc:	b8 13 00 00 00       	mov    $0x13,%eax
     501:	cd 30                	int    $0x30
     503:	c3                   	ret    

00000504 <sleep>:
     504:	b8 14 00 00 00       	mov    $0x14,%eax
     509:	cd 30                	int    $0x30
     50b:	c3                   	ret    

0000050c <upmsec>:
     50c:	b8 15 00 00 00       	mov    $0x15,%eax
     511:	cd 30                	int    $0x30
     513:	c3                   	ret    

00000514 <socket>:
     514:	b8 16 00 00 00       	mov    $0x16,%eax
     519:	cd 30                	int    $0x30
     51b:	c3                   	ret    

0000051c <bind>:
     51c:	b8 17 00 00 00       	mov    $0x17,%eax
     521:	cd 30                	int    $0x30
     523:	c3                   	ret    

00000524 <listen>:
     524:	b8 18 00 00 00       	mov    $0x18,%eax
     529:	cd 30                	int    $0x30
     52b:	c3                   	ret    

0000052c <accept>:
     52c:	b8 19 00 00 00       	mov    $0x19,%eax
     531:	cd 30                	int    $0x30
     533:	c3                   	ret    

00000534 <recv>:
     534:	b8 1a 00 00 00       	mov    $0x1a,%eax
     539:	cd 30                	int    $0x30
     53b:	c3                   	ret    

0000053c <recvfrom>:
     53c:	b8 1b 00 00 00       	mov    $0x1b,%eax
     541:	cd 30                	int    $0x30
     543:	c3                   	ret    

00000544 <send>:
     544:	b8 1c 00 00 00       	mov    $0x1c,%eax
     549:	cd 30                	int    $0x30
     54b:	c3                   	ret    

0000054c <sendto>:
     54c:	b8 1d 00 00 00       	mov    $0x1d,%eax
     551:	cd 30                	int    $0x30
     553:	c3                   	ret    

00000554 <shutdown>:
     554:	b8 1e 00 00 00       	mov    $0x1e,%eax
     559:	cd 30                	int    $0x30
     55b:	c3                   	ret    

0000055c <getsockopt>:
     55c:	b8 1f 00 00 00       	mov    $0x1f,%eax
     561:	cd 30                	int    $0x30
     563:	c3                   	ret    

00000564 <setsockopt>:
     564:	b8 20 00 00 00       	mov    $0x20,%eax
     569:	cd 30                	int    $0x30
     56b:	c3                   	ret    

0000056c <sockclose>:
     56c:	b8 21 00 00 00       	mov    $0x21,%eax
     571:	cd 30                	int    $0x30
     573:	c3                   	ret    

00000574 <connect>:
     574:	b8 22 00 00 00       	mov    $0x22,%eax
     579:	cd 30                	int    $0x30
     57b:	c3                   	ret    

0000057c <getpeername>:
     57c:	b8 23 00 00 00       	mov    $0x23,%eax
     581:	cd 30                	int    $0x30
     583:	c3                   	ret    

00000584 <getsockname>:
     584:	b8 24 00 00 00       	mov    $0x24,%eax
     589:	cd 30                	int    $0x30
     58b:	c3                   	ret    
     58c:	90                   	nop    
     58d:	90                   	nop    
     58e:	90                   	nop    
     58f:	90                   	nop    

00000590 <putc>:
#include "user.h"

void
putc(int fd, char c)
{
     590:	55                   	push   %ebp
     591:	89 e5                	mov    %esp,%ebp
     593:	83 ec 18             	sub    $0x18,%esp
     596:	8b 45 0c             	mov    0xc(%ebp),%eax
     599:	88 45 fc             	mov    %al,0xfffffffc(%ebp)
  write(fd, &c, 1);
     59c:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
     5a3:	00 
     5a4:	8d 45 fc             	lea    0xfffffffc(%ebp),%eax
     5a7:	89 44 24 04          	mov    %eax,0x4(%esp)
     5ab:	8b 45 08             	mov    0x8(%ebp),%eax
     5ae:	89 04 24             	mov    %eax,(%esp)
     5b1:	e8 de fe ff ff       	call   494 <write>
}
     5b6:	c9                   	leave  
     5b7:	c3                   	ret    
     5b8:	90                   	nop    
     5b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi

000005c0 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     5c0:	55                   	push   %ebp
     5c1:	89 e5                	mov    %esp,%ebp
     5c3:	53                   	push   %ebx
     5c4:	83 ec 34             	sub    $0x34,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     5c7:	c7 45 f4 00 00 00 00 	movl   $0x0,0xfffffff4(%ebp)
  if(sgn && xx < 0){
     5ce:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
     5d2:	74 17                	je     5eb <printint+0x2b>
     5d4:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     5d8:	79 11                	jns    5eb <printint+0x2b>
    neg = 1;
     5da:	c7 45 f4 01 00 00 00 	movl   $0x1,0xfffffff4(%ebp)
    x = -xx;
     5e1:	8b 45 0c             	mov    0xc(%ebp),%eax
     5e4:	f7 d8                	neg    %eax
     5e6:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
     5e9:	eb 06                	jmp    5f1 <printint+0x31>
  } else {
    x = xx;
     5eb:	8b 45 0c             	mov    0xc(%ebp),%eax
     5ee:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
  }

  i = 0;
     5f1:	c7 45 f0 00 00 00 00 	movl   $0x0,0xfffffff0(%ebp)
  do{
    buf[i++] = digits[x % base];
     5f8:	8b 4d f0             	mov    0xfffffff0(%ebp),%ecx
     5fb:	8b 55 10             	mov    0x10(%ebp),%edx
     5fe:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     601:	89 d3                	mov    %edx,%ebx
     603:	ba 00 00 00 00       	mov    $0x0,%edx
     608:	f7 f3                	div    %ebx
     60a:	89 d0                	mov    %edx,%eax
     60c:	0f b6 80 58 12 00 00 	movzbl 0x1258(%eax),%eax
     613:	88 44 0d e0          	mov    %al,0xffffffe0(%ebp,%ecx,1)
     617:	83 45 f0 01          	addl   $0x1,0xfffffff0(%ebp)
  }while((x /= base) != 0);
     61b:	8b 55 10             	mov    0x10(%ebp),%edx
     61e:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     621:	89 d1                	mov    %edx,%ecx
     623:	ba 00 00 00 00       	mov    $0x0,%edx
     628:	f7 f1                	div    %ecx
     62a:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
     62d:	83 7d f8 00          	cmpl   $0x0,0xfffffff8(%ebp)
     631:	75 c5                	jne    5f8 <printint+0x38>
  if(neg)
     633:	83 7d f4 00          	cmpl   $0x0,0xfffffff4(%ebp)
     637:	74 28                	je     661 <printint+0xa1>
    buf[i++] = '-';
     639:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
     63c:	c6 44 05 e0 2d       	movb   $0x2d,0xffffffe0(%ebp,%eax,1)
     641:	83 45 f0 01          	addl   $0x1,0xfffffff0(%ebp)

  while(--i >= 0)
     645:	eb 1a                	jmp    661 <printint+0xa1>
    putc(fd, buf[i]);
     647:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
     64a:	0f b6 44 05 e0       	movzbl 0xffffffe0(%ebp,%eax,1),%eax
     64f:	0f be c0             	movsbl %al,%eax
     652:	89 44 24 04          	mov    %eax,0x4(%esp)
     656:	8b 45 08             	mov    0x8(%ebp),%eax
     659:	89 04 24             	mov    %eax,(%esp)
     65c:	e8 2f ff ff ff       	call   590 <putc>
     661:	83 6d f0 01          	subl   $0x1,0xfffffff0(%ebp)
     665:	83 7d f0 00          	cmpl   $0x0,0xfffffff0(%ebp)
     669:	79 dc                	jns    647 <printint+0x87>
}
     66b:	83 c4 34             	add    $0x34,%esp
     66e:	5b                   	pop    %ebx
     66f:	5d                   	pop    %ebp
     670:	c3                   	ret    
     671:	eb 0d                	jmp    680 <printf>
     673:	90                   	nop    
     674:	90                   	nop    
     675:	90                   	nop    
     676:	90                   	nop    
     677:	90                   	nop    
     678:	90                   	nop    
     679:	90                   	nop    
     67a:	90                   	nop    
     67b:	90                   	nop    
     67c:	90                   	nop    
     67d:	90                   	nop    
     67e:	90                   	nop    
     67f:	90                   	nop    

00000680 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
     680:	55                   	push   %ebp
     681:	89 e5                	mov    %esp,%ebp
     683:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
     686:	c7 45 f8 00 00 00 00 	movl   $0x0,0xfffffff8(%ebp)
  ap = (uint*)(void*)&fmt + 1;
     68d:	8d 45 0c             	lea    0xc(%ebp),%eax
     690:	83 c0 04             	add    $0x4,%eax
     693:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
  for(i = 0; fmt[i]; i++){
     696:	c7 45 f4 00 00 00 00 	movl   $0x0,0xfffffff4(%ebp)
     69d:	e9 7b 01 00 00       	jmp    81d <printf+0x19d>
    c = fmt[i] & 0xff;
     6a2:	8b 55 0c             	mov    0xc(%ebp),%edx
     6a5:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     6a8:	8d 04 02             	lea    (%edx,%eax,1),%eax
     6ab:	0f b6 00             	movzbl (%eax),%eax
     6ae:	0f be c0             	movsbl %al,%eax
     6b1:	25 ff 00 00 00       	and    $0xff,%eax
     6b6:	89 45 f0             	mov    %eax,0xfffffff0(%ebp)
    if(state == 0){
     6b9:	83 7d f8 00          	cmpl   $0x0,0xfffffff8(%ebp)
     6bd:	75 2c                	jne    6eb <printf+0x6b>
      if(c == '%'){
     6bf:	83 7d f0 25          	cmpl   $0x25,0xfffffff0(%ebp)
     6c3:	75 0c                	jne    6d1 <printf+0x51>
        state = '%';
     6c5:	c7 45 f8 25 00 00 00 	movl   $0x25,0xfffffff8(%ebp)
     6cc:	e9 48 01 00 00       	jmp    819 <printf+0x199>
      } else {
        putc(fd, c);
     6d1:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
     6d4:	0f be c0             	movsbl %al,%eax
     6d7:	89 44 24 04          	mov    %eax,0x4(%esp)
     6db:	8b 45 08             	mov    0x8(%ebp),%eax
     6de:	89 04 24             	mov    %eax,(%esp)
     6e1:	e8 aa fe ff ff       	call   590 <putc>
     6e6:	e9 2e 01 00 00       	jmp    819 <printf+0x199>
      }
    } else if(state == '%'){
     6eb:	83 7d f8 25          	cmpl   $0x25,0xfffffff8(%ebp)
     6ef:	0f 85 24 01 00 00    	jne    819 <printf+0x199>
      if(c == 'd'){
     6f5:	83 7d f0 64          	cmpl   $0x64,0xfffffff0(%ebp)
     6f9:	75 2d                	jne    728 <printf+0xa8>
        printint(fd, *ap, 10, 1);
     6fb:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     6fe:	8b 00                	mov    (%eax),%eax
     700:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
     707:	00 
     708:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
     70f:	00 
     710:	89 44 24 04          	mov    %eax,0x4(%esp)
     714:	8b 45 08             	mov    0x8(%ebp),%eax
     717:	89 04 24             	mov    %eax,(%esp)
     71a:	e8 a1 fe ff ff       	call   5c0 <printint>
        ap++;
     71f:	83 45 fc 04          	addl   $0x4,0xfffffffc(%ebp)
     723:	e9 ea 00 00 00       	jmp    812 <printf+0x192>
      } else if(c == 'x' || c == 'p'){
     728:	83 7d f0 78          	cmpl   $0x78,0xfffffff0(%ebp)
     72c:	74 06                	je     734 <printf+0xb4>
     72e:	83 7d f0 70          	cmpl   $0x70,0xfffffff0(%ebp)
     732:	75 2d                	jne    761 <printf+0xe1>
        printint(fd, *ap, 16, 0);
     734:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     737:	8b 00                	mov    (%eax),%eax
     739:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
     740:	00 
     741:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
     748:	00 
     749:	89 44 24 04          	mov    %eax,0x4(%esp)
     74d:	8b 45 08             	mov    0x8(%ebp),%eax
     750:	89 04 24             	mov    %eax,(%esp)
     753:	e8 68 fe ff ff       	call   5c0 <printint>
        ap++;
     758:	83 45 fc 04          	addl   $0x4,0xfffffffc(%ebp)
     75c:	e9 b1 00 00 00       	jmp    812 <printf+0x192>
      } else if(c == 's'){
     761:	83 7d f0 73          	cmpl   $0x73,0xfffffff0(%ebp)
     765:	75 43                	jne    7aa <printf+0x12a>
        s = (char*)*ap;
     767:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     76a:	8b 00                	mov    (%eax),%eax
     76c:	89 45 ec             	mov    %eax,0xffffffec(%ebp)
        ap++;
     76f:	83 45 fc 04          	addl   $0x4,0xfffffffc(%ebp)
        if(s == 0)
     773:	83 7d ec 00          	cmpl   $0x0,0xffffffec(%ebp)
     777:	75 25                	jne    79e <printf+0x11e>
          s = "(null)";
     779:	c7 45 ec 3d 12 00 00 	movl   $0x123d,0xffffffec(%ebp)
        while(*s != 0){
     780:	eb 1c                	jmp    79e <printf+0x11e>
          putc(fd, *s);
     782:	8b 45 ec             	mov    0xffffffec(%ebp),%eax
     785:	0f b6 00             	movzbl (%eax),%eax
     788:	0f be c0             	movsbl %al,%eax
     78b:	89 44 24 04          	mov    %eax,0x4(%esp)
     78f:	8b 45 08             	mov    0x8(%ebp),%eax
     792:	89 04 24             	mov    %eax,(%esp)
     795:	e8 f6 fd ff ff       	call   590 <putc>
          s++;
     79a:	83 45 ec 01          	addl   $0x1,0xffffffec(%ebp)
     79e:	8b 45 ec             	mov    0xffffffec(%ebp),%eax
     7a1:	0f b6 00             	movzbl (%eax),%eax
     7a4:	84 c0                	test   %al,%al
     7a6:	75 da                	jne    782 <printf+0x102>
     7a8:	eb 68                	jmp    812 <printf+0x192>
        }
      } else if(c == 'c'){
     7aa:	83 7d f0 63          	cmpl   $0x63,0xfffffff0(%ebp)
     7ae:	75 1d                	jne    7cd <printf+0x14d>
        putc(fd, *ap);
     7b0:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     7b3:	8b 00                	mov    (%eax),%eax
     7b5:	0f be c0             	movsbl %al,%eax
     7b8:	89 44 24 04          	mov    %eax,0x4(%esp)
     7bc:	8b 45 08             	mov    0x8(%ebp),%eax
     7bf:	89 04 24             	mov    %eax,(%esp)
     7c2:	e8 c9 fd ff ff       	call   590 <putc>
        ap++;
     7c7:	83 45 fc 04          	addl   $0x4,0xfffffffc(%ebp)
     7cb:	eb 45                	jmp    812 <printf+0x192>
      } else if(c == '%'){
     7cd:	83 7d f0 25          	cmpl   $0x25,0xfffffff0(%ebp)
     7d1:	75 17                	jne    7ea <printf+0x16a>
        putc(fd, c);
     7d3:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
     7d6:	0f be c0             	movsbl %al,%eax
     7d9:	89 44 24 04          	mov    %eax,0x4(%esp)
     7dd:	8b 45 08             	mov    0x8(%ebp),%eax
     7e0:	89 04 24             	mov    %eax,(%esp)
     7e3:	e8 a8 fd ff ff       	call   590 <putc>
     7e8:	eb 28                	jmp    812 <printf+0x192>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     7ea:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
     7f1:	00 
     7f2:	8b 45 08             	mov    0x8(%ebp),%eax
     7f5:	89 04 24             	mov    %eax,(%esp)
     7f8:	e8 93 fd ff ff       	call   590 <putc>
        putc(fd, c);
     7fd:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
     800:	0f be c0             	movsbl %al,%eax
     803:	89 44 24 04          	mov    %eax,0x4(%esp)
     807:	8b 45 08             	mov    0x8(%ebp),%eax
     80a:	89 04 24             	mov    %eax,(%esp)
     80d:	e8 7e fd ff ff       	call   590 <putc>
      }
      state = 0;
     812:	c7 45 f8 00 00 00 00 	movl   $0x0,0xfffffff8(%ebp)
     819:	83 45 f4 01          	addl   $0x1,0xfffffff4(%ebp)
     81d:	8b 55 0c             	mov    0xc(%ebp),%edx
     820:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     823:	8d 04 02             	lea    (%edx,%eax,1),%eax
     826:	0f b6 00             	movzbl (%eax),%eax
     829:	84 c0                	test   %al,%al
     82b:	0f 85 71 fe ff ff    	jne    6a2 <printf+0x22>
    }
  }
}
     831:	c9                   	leave  
     832:	c3                   	ret    
     833:	90                   	nop    
     834:	90                   	nop    
     835:	90                   	nop    
     836:	90                   	nop    
     837:	90                   	nop    
     838:	90                   	nop    
     839:	90                   	nop    
     83a:	90                   	nop    
     83b:	90                   	nop    
     83c:	90                   	nop    
     83d:	90                   	nop    
     83e:	90                   	nop    
     83f:	90                   	nop    

00000840 <free>:
static Header *freep;

void
free(void *ap)
{
     840:	55                   	push   %ebp
     841:	89 e5                	mov    %esp,%ebp
     843:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*) ap - 1;
     846:	8b 45 08             	mov    0x8(%ebp),%eax
     849:	83 e8 08             	sub    $0x8,%eax
     84c:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     84f:	a1 88 12 00 00       	mov    0x1288,%eax
     854:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
     857:	eb 24                	jmp    87d <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     859:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     85c:	8b 00                	mov    (%eax),%eax
     85e:	3b 45 fc             	cmp    0xfffffffc(%ebp),%eax
     861:	77 12                	ja     875 <free+0x35>
     863:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     866:	3b 45 fc             	cmp    0xfffffffc(%ebp),%eax
     869:	77 24                	ja     88f <free+0x4f>
     86b:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     86e:	8b 00                	mov    (%eax),%eax
     870:	3b 45 f8             	cmp    0xfffffff8(%ebp),%eax
     873:	77 1a                	ja     88f <free+0x4f>
     875:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     878:	8b 00                	mov    (%eax),%eax
     87a:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
     87d:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     880:	3b 45 fc             	cmp    0xfffffffc(%ebp),%eax
     883:	76 d4                	jbe    859 <free+0x19>
     885:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     888:	8b 00                	mov    (%eax),%eax
     88a:	3b 45 f8             	cmp    0xfffffff8(%ebp),%eax
     88d:	76 ca                	jbe    859 <free+0x19>
      break;
  if(bp + bp->s.size == p->s.ptr){
     88f:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     892:	8b 40 04             	mov    0x4(%eax),%eax
     895:	c1 e0 03             	shl    $0x3,%eax
     898:	89 c2                	mov    %eax,%edx
     89a:	03 55 f8             	add    0xfffffff8(%ebp),%edx
     89d:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     8a0:	8b 00                	mov    (%eax),%eax
     8a2:	39 c2                	cmp    %eax,%edx
     8a4:	75 24                	jne    8ca <free+0x8a>
    bp->s.size += p->s.ptr->s.size;
     8a6:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     8a9:	8b 50 04             	mov    0x4(%eax),%edx
     8ac:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     8af:	8b 00                	mov    (%eax),%eax
     8b1:	8b 40 04             	mov    0x4(%eax),%eax
     8b4:	01 c2                	add    %eax,%edx
     8b6:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     8b9:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
     8bc:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     8bf:	8b 00                	mov    (%eax),%eax
     8c1:	8b 10                	mov    (%eax),%edx
     8c3:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     8c6:	89 10                	mov    %edx,(%eax)
     8c8:	eb 0a                	jmp    8d4 <free+0x94>
  } else
    bp->s.ptr = p->s.ptr;
     8ca:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     8cd:	8b 10                	mov    (%eax),%edx
     8cf:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     8d2:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
     8d4:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     8d7:	8b 40 04             	mov    0x4(%eax),%eax
     8da:	c1 e0 03             	shl    $0x3,%eax
     8dd:	03 45 fc             	add    0xfffffffc(%ebp),%eax
     8e0:	3b 45 f8             	cmp    0xfffffff8(%ebp),%eax
     8e3:	75 20                	jne    905 <free+0xc5>
    p->s.size += bp->s.size;
     8e5:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     8e8:	8b 50 04             	mov    0x4(%eax),%edx
     8eb:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     8ee:	8b 40 04             	mov    0x4(%eax),%eax
     8f1:	01 c2                	add    %eax,%edx
     8f3:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     8f6:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
     8f9:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     8fc:	8b 10                	mov    (%eax),%edx
     8fe:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     901:	89 10                	mov    %edx,(%eax)
     903:	eb 08                	jmp    90d <free+0xcd>
  } else
    p->s.ptr = bp;
     905:	8b 55 fc             	mov    0xfffffffc(%ebp),%edx
     908:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     90b:	89 02                	mov    %eax,(%edx)
  freep = p;
     90d:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     910:	a3 88 12 00 00       	mov    %eax,0x1288
}
     915:	c9                   	leave  
     916:	c3                   	ret    
     917:	89 f6                	mov    %esi,%esi
     919:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00000920 <morecore>:

static Header*
morecore(uint nu)
{
     920:	55                   	push   %ebp
     921:	89 e5                	mov    %esp,%ebp
     923:	83 ec 18             	sub    $0x18,%esp
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
     926:	8b 45 08             	mov    0x8(%ebp),%eax
     929:	c1 e0 03             	shl    $0x3,%eax
     92c:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
  size += PAGE - size % PAGE;
     92f:	8b 55 fc             	mov    0xfffffffc(%ebp),%edx
     932:	89 d0                	mov    %edx,%eax
     934:	c1 f8 1f             	sar    $0x1f,%eax
     937:	89 c1                	mov    %eax,%ecx
     939:	c1 e9 14             	shr    $0x14,%ecx
     93c:	8d 04 0a             	lea    (%edx,%ecx,1),%eax
     93f:	25 ff 0f 00 00       	and    $0xfff,%eax
     944:	29 c8                	sub    %ecx,%eax
     946:	89 c2                	mov    %eax,%edx
     948:	b8 00 10 00 00       	mov    $0x1000,%eax
     94d:	29 d0                	sub    %edx,%eax
     94f:	01 45 fc             	add    %eax,0xfffffffc(%ebp)
#endif
#ifdef UMALLOC_DEBUG
  printf(1, "size: %d\n", size);
#endif
  p = sbrk(size);
     952:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     955:	89 04 24             	mov    %eax,(%esp)
     958:	e8 9f fb ff ff       	call   4fc <sbrk>
     95d:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
  if(p == (char*) -1)
     960:	83 7d f4 ff          	cmpl   $0xffffffff,0xfffffff4(%ebp)
     964:	75 09                	jne    96f <morecore+0x4f>
    return 0;
     966:	c7 45 ec 00 00 00 00 	movl   $0x0,0xffffffec(%ebp)
     96d:	eb 2a                	jmp    999 <morecore+0x79>
  hp = (Header*)p;
     96f:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     972:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
#ifdef UMALLOC_NOALIGN
  hp->s.size = nu;
#else
  hp->s.size = size / sizeof(Header);
     975:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     978:	89 c2                	mov    %eax,%edx
     97a:	c1 ea 03             	shr    $0x3,%edx
     97d:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     980:	89 50 04             	mov    %edx,0x4(%eax)
#endif
  free((void*)(hp + 1));
     983:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     986:	83 c0 08             	add    $0x8,%eax
     989:	89 04 24             	mov    %eax,(%esp)
     98c:	e8 af fe ff ff       	call   840 <free>
  return freep;
     991:	a1 88 12 00 00       	mov    0x1288,%eax
     996:	89 45 ec             	mov    %eax,0xffffffec(%ebp)
     999:	8b 45 ec             	mov    0xffffffec(%ebp),%eax
}
     99c:	c9                   	leave  
     99d:	c3                   	ret    
     99e:	89 f6                	mov    %esi,%esi

000009a0 <malloc>:

void*
malloc(uint nbytes)
{
     9a0:	55                   	push   %ebp
     9a1:	89 e5                	mov    %esp,%ebp
     9a3:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

#ifdef UMALLOC_DEBUG
  printf(1, "malloc: %d bytes\n", nbytes);
  printf(1, "size of Header: %d\n", sizeof(Header));
#endif
  if (PAGE % sizeof(Header))
      printf(2, "Warning! align failed! Need UMALLOC_NOALIGN\n");
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     9a6:	8b 45 08             	mov    0x8(%ebp),%eax
     9a9:	83 c0 07             	add    $0x7,%eax
     9ac:	c1 e8 03             	shr    $0x3,%eax
     9af:	83 c0 01             	add    $0x1,%eax
     9b2:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
  if((prevp = freep) == 0){
     9b5:	a1 88 12 00 00       	mov    0x1288,%eax
     9ba:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
     9bd:	83 7d f8 00          	cmpl   $0x0,0xfffffff8(%ebp)
     9c1:	75 23                	jne    9e6 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
     9c3:	c7 45 f8 80 12 00 00 	movl   $0x1280,0xfffffff8(%ebp)
     9ca:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     9cd:	a3 88 12 00 00       	mov    %eax,0x1288
     9d2:	a1 88 12 00 00       	mov    0x1288,%eax
     9d7:	a3 80 12 00 00       	mov    %eax,0x1280
    base.s.size = 0;
     9dc:	c7 05 84 12 00 00 00 	movl   $0x0,0x1284
     9e3:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     9e6:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     9e9:	8b 00                	mov    (%eax),%eax
     9eb:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
    if(p->s.size >= nunits){
     9ee:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     9f1:	8b 40 04             	mov    0x4(%eax),%eax
     9f4:	3b 45 fc             	cmp    0xfffffffc(%ebp),%eax
     9f7:	72 50                	jb     a49 <malloc+0xa9>
      if(p->s.size == nunits)
     9f9:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     9fc:	8b 40 04             	mov    0x4(%eax),%eax
     9ff:	3b 45 fc             	cmp    0xfffffffc(%ebp),%eax
     a02:	75 0c                	jne    a10 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
     a04:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     a07:	8b 10                	mov    (%eax),%edx
     a09:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     a0c:	89 10                	mov    %edx,(%eax)
     a0e:	eb 26                	jmp    a36 <malloc+0x96>
      else {
        p->s.size -= nunits;
     a10:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     a13:	8b 40 04             	mov    0x4(%eax),%eax
     a16:	89 c2                	mov    %eax,%edx
     a18:	2b 55 fc             	sub    0xfffffffc(%ebp),%edx
     a1b:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     a1e:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
     a21:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     a24:	8b 40 04             	mov    0x4(%eax),%eax
     a27:	c1 e0 03             	shl    $0x3,%eax
     a2a:	01 45 f4             	add    %eax,0xfffffff4(%ebp)
        p->s.size = nunits;
     a2d:	8b 55 f4             	mov    0xfffffff4(%ebp),%edx
     a30:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     a33:	89 42 04             	mov    %eax,0x4(%edx)
      }
      freep = prevp;
     a36:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     a39:	a3 88 12 00 00       	mov    %eax,0x1288
      return (void*) (p + 1);
     a3e:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     a41:	83 c0 08             	add    $0x8,%eax
     a44:	89 45 ec             	mov    %eax,0xffffffec(%ebp)
     a47:	eb 3a                	jmp    a83 <malloc+0xe3>
    }
    if(p == freep)
     a49:	a1 88 12 00 00       	mov    0x1288,%eax
     a4e:	39 45 f4             	cmp    %eax,0xfffffff4(%ebp)
     a51:	75 1d                	jne    a70 <malloc+0xd0>
      if((p = morecore(nunits)) == 0)
     a53:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     a56:	89 04 24             	mov    %eax,(%esp)
     a59:	e8 c2 fe ff ff       	call   920 <morecore>
     a5e:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
     a61:	83 7d f4 00          	cmpl   $0x0,0xfffffff4(%ebp)
     a65:	75 09                	jne    a70 <malloc+0xd0>
        return 0;
     a67:	c7 45 ec 00 00 00 00 	movl   $0x0,0xffffffec(%ebp)
     a6e:	eb 13                	jmp    a83 <malloc+0xe3>
     a70:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     a73:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
     a76:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     a79:	8b 00                	mov    (%eax),%eax
     a7b:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
  }
     a7e:	e9 6b ff ff ff       	jmp    9ee <malloc+0x4e>
     a83:	8b 45 ec             	mov    0xffffffec(%ebp),%eax
}
     a86:	c9                   	leave  
     a87:	c3                   	ret    
     a88:	90                   	nop    
     a89:	90                   	nop    
     a8a:	90                   	nop    
     a8b:	90                   	nop    
     a8c:	90                   	nop    
     a8d:	90                   	nop    
     a8e:	90                   	nop    
     a8f:	90                   	nop    

00000a90 <lwip_chksum>:


static u16_t
lwip_chksum(void *dataptr, int len)
{
     a90:	55                   	push   %ebp
     a91:	89 e5                	mov    %esp,%ebp
     a93:	83 ec 18             	sub    $0x18,%esp
  u32_t acc;

  LWIP_DEBUGF(INET_DEBUG, ("lwip_chksum(%p, %d)\n", (void *)dataptr, len));
  for(acc = 0; len > 1; len -= 2) {
     a96:	c7 45 fc 00 00 00 00 	movl   $0x0,0xfffffffc(%ebp)
     a9d:	eb 19                	jmp    ab8 <lwip_chksum+0x28>
      /*    acc = acc + *((u16_t *)dataptr)++;*/
    acc += *(u16_t *)dataptr;
     a9f:	8b 45 08             	mov    0x8(%ebp),%eax
     aa2:	0f b7 00             	movzwl (%eax),%eax
     aa5:	0f b7 c0             	movzwl %ax,%eax
     aa8:	01 45 fc             	add    %eax,0xfffffffc(%ebp)
    dataptr = (void *)((u16_t *)dataptr + 1);
     aab:	8b 45 08             	mov    0x8(%ebp),%eax
     aae:	83 c0 02             	add    $0x2,%eax
     ab1:	89 45 08             	mov    %eax,0x8(%ebp)
     ab4:	83 6d 0c 02          	subl   $0x2,0xc(%ebp)
     ab8:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
     abc:	7f e1                	jg     a9f <lwip_chksum+0xf>
  }

  /* add up any odd byte */
  if (len == 1) {
     abe:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
     ac2:	75 1d                	jne    ae1 <lwip_chksum+0x51>
    acc += htons((u16_t)((*(u8_t *)dataptr) & 0xff) << 8);
     ac4:	8b 45 08             	mov    0x8(%ebp),%eax
     ac7:	0f b6 00             	movzbl (%eax),%eax
     aca:	0f b6 c0             	movzbl %al,%eax
     acd:	c1 e0 08             	shl    $0x8,%eax
     ad0:	0f b7 c0             	movzwl %ax,%eax
     ad3:	89 04 24             	mov    %eax,(%esp)
     ad6:	e8 85 06 00 00       	call   1160 <htons>
     adb:	0f b7 c0             	movzwl %ax,%eax
     ade:	01 45 fc             	add    %eax,0xfffffffc(%ebp)
    LWIP_DEBUGF(INET_DEBUG, ("inet: chksum: odd byte %d\n", (unsigned int)(*(u8_t *)dataptr)));
  } else {
    LWIP_DEBUGF(INET_DEBUG, ("inet: chksum: no odd byte\n"));
  }
  acc = (acc >> 16) + (acc & 0xffffUL);
     ae1:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     ae4:	89 c2                	mov    %eax,%edx
     ae6:	c1 ea 10             	shr    $0x10,%edx
     ae9:	0f b7 45 fc          	movzwl 0xfffffffc(%ebp),%eax
     aed:	8d 04 02             	lea    (%edx,%eax,1),%eax
     af0:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)

  if ((acc & 0xffff0000) != 0) {
     af3:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     af6:	66 b8 00 00          	mov    $0x0,%ax
     afa:	85 c0                	test   %eax,%eax
     afc:	74 12                	je     b10 <lwip_chksum+0x80>
    acc = (acc >> 16) + (acc & 0xffffUL);
     afe:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     b01:	89 c2                	mov    %eax,%edx
     b03:	c1 ea 10             	shr    $0x10,%edx
     b06:	0f b7 45 fc          	movzwl 0xfffffffc(%ebp),%eax
     b0a:	8d 04 02             	lea    (%edx,%eax,1),%eax
     b0d:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
  }

  return (u16_t)acc;
     b10:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     b13:	0f b7 c0             	movzwl %ax,%eax
}
     b16:	c9                   	leave  
     b17:	c3                   	ret    
     b18:	90                   	nop    
     b19:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi

00000b20 <inet_chksum_pseudo>:

/* inet_chksum_pseudo:
 *
 * Calculates the pseudo Internet checksum used by TCP and UDP for a pbuf chain.
 */

u16_t
inet_chksum_pseudo(struct pbuf *p,
       struct ip_addr *src, struct ip_addr *dest,
       u8_t proto, u16_t proto_len)
{
     b20:	55                   	push   %ebp
     b21:	89 e5                	mov    %esp,%ebp
     b23:	83 ec 28             	sub    $0x28,%esp
     b26:	8b 45 14             	mov    0x14(%ebp),%eax
     b29:	8b 55 18             	mov    0x18(%ebp),%edx
     b2c:	88 45 ec             	mov    %al,0xffffffec(%ebp)
     b2f:	66 89 55 e8          	mov    %dx,0xffffffe8(%ebp)
  u32_t acc;
  struct pbuf *q;
  u8_t swapped;

  acc = 0;
     b33:	c7 45 f4 00 00 00 00 	movl   $0x0,0xfffffff4(%ebp)
  swapped = 0;
     b3a:	c6 45 ff 00          	movb   $0x0,0xffffffff(%ebp)
  /* iterate through all pbuf in chain */
  for(q = p; q != NULL; q = q->next) {
     b3e:	8b 45 08             	mov    0x8(%ebp),%eax
     b41:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
     b44:	eb 7b                	jmp    bc1 <inet_chksum_pseudo+0xa1>
    LWIP_DEBUGF(INET_DEBUG, ("inet_chksum_pseudo(): checksumming pbuf %p (has next %p) \n",
      (void *)q, (void *)q->next));
    acc += lwip_chksum(q->payload, q->len);
     b46:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     b49:	0f b7 40 0a          	movzwl 0xa(%eax),%eax
     b4d:	0f b7 d0             	movzwl %ax,%edx
     b50:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     b53:	8b 40 04             	mov    0x4(%eax),%eax
     b56:	89 54 24 04          	mov    %edx,0x4(%esp)
     b5a:	89 04 24             	mov    %eax,(%esp)
     b5d:	e8 2e ff ff ff       	call   a90 <lwip_chksum>
     b62:	0f b7 c0             	movzwl %ax,%eax
     b65:	01 45 f4             	add    %eax,0xfffffff4(%ebp)
    /*LWIP_DEBUGF(INET_DEBUG, ("inet_chksum_pseudo(): unwrapped lwip_chksum()=%lx \n", acc));*/
    while (acc >> 16) {
     b68:	eb 10                	jmp    b7a <inet_chksum_pseudo+0x5a>
      acc = (acc & 0xffffUL) + (acc >> 16);
     b6a:	0f b7 55 f4          	movzwl 0xfffffff4(%ebp),%edx
     b6e:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     b71:	c1 e8 10             	shr    $0x10,%eax
     b74:	8d 04 02             	lea    (%edx,%eax,1),%eax
     b77:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
     b7a:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     b7d:	c1 e8 10             	shr    $0x10,%eax
     b80:	85 c0                	test   %eax,%eax
     b82:	75 e6                	jne    b6a <inet_chksum_pseudo+0x4a>
    }
    if (q->len % 2 != 0) {
     b84:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     b87:	0f b7 40 0a          	movzwl 0xa(%eax),%eax
     b8b:	0f b7 c0             	movzwl %ax,%eax
     b8e:	83 e0 01             	and    $0x1,%eax
     b91:	84 c0                	test   %al,%al
     b93:	74 24                	je     bb9 <inet_chksum_pseudo+0x99>
      swapped = 1 - swapped;
     b95:	b8 01 00 00 00       	mov    $0x1,%eax
     b9a:	2a 45 ff             	sub    0xffffffff(%ebp),%al
     b9d:	88 45 ff             	mov    %al,0xffffffff(%ebp)
      acc = ((acc & 0xff) << 8) | ((acc & 0xff00UL) >> 8);
     ba0:	0f b6 45 f4          	movzbl 0xfffffff4(%ebp),%eax
     ba4:	89 c2                	mov    %eax,%edx
     ba6:	c1 e2 08             	shl    $0x8,%edx
     ba9:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     bac:	25 00 ff 00 00       	and    $0xff00,%eax
     bb1:	c1 e8 08             	shr    $0x8,%eax
     bb4:	09 d0                	or     %edx,%eax
     bb6:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
     bb9:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     bbc:	8b 00                	mov    (%eax),%eax
     bbe:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
     bc1:	83 7d f8 00          	cmpl   $0x0,0xfffffff8(%ebp)
     bc5:	0f 85 7b ff ff ff    	jne    b46 <inet_chksum_pseudo+0x26>
    }
    /*LWIP_DEBUGF(INET_DEBUG, ("inet_chksum_pseudo(): wrapped lwip_chksum()=%lx \n", acc));*/
  }

  if (swapped) {
     bcb:	80 7d ff 00          	cmpb   $0x0,0xffffffff(%ebp)
     bcf:	74 19                	je     bea <inet_chksum_pseudo+0xca>
    acc = ((acc & 0xff) << 8) | ((acc & 0xff00UL) >> 8);
     bd1:	0f b6 45 f4          	movzbl 0xfffffff4(%ebp),%eax
     bd5:	89 c2                	mov    %eax,%edx
     bd7:	c1 e2 08             	shl    $0x8,%edx
     bda:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     bdd:	25 00 ff 00 00       	and    $0xff00,%eax
     be2:	c1 e8 08             	shr    $0x8,%eax
     be5:	09 d0                	or     %edx,%eax
     be7:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
  }
  acc += (src->addr & 0xffffUL);
     bea:	8b 45 0c             	mov    0xc(%ebp),%eax
     bed:	8b 00                	mov    (%eax),%eax
     bef:	25 ff ff 00 00       	and    $0xffff,%eax
     bf4:	01 45 f4             	add    %eax,0xfffffff4(%ebp)
  acc += ((src->addr >> 16) & 0xffffUL);
     bf7:	8b 45 0c             	mov    0xc(%ebp),%eax
     bfa:	8b 00                	mov    (%eax),%eax
     bfc:	c1 e8 10             	shr    $0x10,%eax
     bff:	25 ff ff 00 00       	and    $0xffff,%eax
     c04:	01 45 f4             	add    %eax,0xfffffff4(%ebp)
  acc += (dest->addr & 0xffffUL);
     c07:	8b 45 10             	mov    0x10(%ebp),%eax
     c0a:	8b 00                	mov    (%eax),%eax
     c0c:	25 ff ff 00 00       	and    $0xffff,%eax
     c11:	01 45 f4             	add    %eax,0xfffffff4(%ebp)
  acc += ((dest->addr >> 16) & 0xffffUL);
     c14:	8b 45 10             	mov    0x10(%ebp),%eax
     c17:	8b 00                	mov    (%eax),%eax
     c19:	c1 e8 10             	shr    $0x10,%eax
     c1c:	25 ff ff 00 00       	and    $0xffff,%eax
     c21:	01 45 f4             	add    %eax,0xfffffff4(%ebp)
  acc += (u32_t)htons((u16_t)proto);
     c24:	0f b6 45 ec          	movzbl 0xffffffec(%ebp),%eax
     c28:	89 04 24             	mov    %eax,(%esp)
     c2b:	e8 30 05 00 00       	call   1160 <htons>
     c30:	0f b7 c0             	movzwl %ax,%eax
     c33:	01 45 f4             	add    %eax,0xfffffff4(%ebp)
  acc += (u32_t)htons(proto_len);
     c36:	0f b7 45 e8          	movzwl 0xffffffe8(%ebp),%eax
     c3a:	89 04 24             	mov    %eax,(%esp)
     c3d:	e8 1e 05 00 00       	call   1160 <htons>
     c42:	0f b7 c0             	movzwl %ax,%eax
     c45:	01 45 f4             	add    %eax,0xfffffff4(%ebp)

  while (acc >> 16) {
     c48:	eb 10                	jmp    c5a <inet_chksum_pseudo+0x13a>
    acc = (acc & 0xffffUL) + (acc >> 16);
     c4a:	0f b7 55 f4          	movzwl 0xfffffff4(%ebp),%edx
     c4e:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     c51:	c1 e8 10             	shr    $0x10,%eax
     c54:	8d 04 02             	lea    (%edx,%eax,1),%eax
     c57:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
     c5a:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     c5d:	c1 e8 10             	shr    $0x10,%eax
     c60:	85 c0                	test   %eax,%eax
     c62:	75 e6                	jne    c4a <inet_chksum_pseudo+0x12a>
  }
  LWIP_DEBUGF(INET_DEBUG, ("inet_chksum_pseudo(): pbuf chain lwip_chksum()=%lx\n", acc));
  return ~(acc & 0xffffUL);
     c64:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     c67:	f7 d0                	not    %eax
     c69:	0f b7 c0             	movzwl %ax,%eax
}
     c6c:	c9                   	leave  
     c6d:	c3                   	ret    
     c6e:	89 f6                	mov    %esi,%esi

00000c70 <inet_chksum>:

/* inet_chksum:
 *
 * Calculates the Internet checksum over a portion of memory. Used primarely for IP
 * and ICMP.
 */

u16_t
inet_chksum(void *dataptr, u16_t len)
{
     c70:	55                   	push   %ebp
     c71:	89 e5                	mov    %esp,%ebp
     c73:	83 ec 28             	sub    $0x28,%esp
     c76:	8b 45 0c             	mov    0xc(%ebp),%eax
     c79:	66 89 45 ec          	mov    %ax,0xffffffec(%ebp)
  u32_t acc;

  acc = lwip_chksum(dataptr, len);
     c7d:	0f b7 45 ec          	movzwl 0xffffffec(%ebp),%eax
     c81:	89 44 24 04          	mov    %eax,0x4(%esp)
     c85:	8b 45 08             	mov    0x8(%ebp),%eax
     c88:	89 04 24             	mov    %eax,(%esp)
     c8b:	e8 00 fe ff ff       	call   a90 <lwip_chksum>
     c90:	0f b7 c0             	movzwl %ax,%eax
     c93:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
  while (acc >> 16) {
     c96:	eb 10                	jmp    ca8 <inet_chksum+0x38>
    acc = (acc & 0xffff) + (acc >> 16);
     c98:	0f b7 55 fc          	movzwl 0xfffffffc(%ebp),%edx
     c9c:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     c9f:	c1 e8 10             	shr    $0x10,%eax
     ca2:	8d 04 02             	lea    (%edx,%eax,1),%eax
     ca5:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
     ca8:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     cab:	c1 e8 10             	shr    $0x10,%eax
     cae:	85 c0                	test   %eax,%eax
     cb0:	75 e6                	jne    c98 <inet_chksum+0x28>
  }
  return ~(acc & 0xffff);
     cb2:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     cb5:	f7 d0                	not    %eax
     cb7:	0f b7 c0             	movzwl %ax,%eax
}
     cba:	c9                   	leave  
     cbb:	c3                   	ret    
     cbc:	8d 74 26 00          	lea    0x0(%esi),%esi

00000cc0 <inet_chksum_pbuf>:

u16_t
inet_chksum_pbuf(struct pbuf *p)
{
     cc0:	55                   	push   %ebp
     cc1:	89 e5                	mov    %esp,%ebp
     cc3:	83 ec 18             	sub    $0x18,%esp
  u32_t acc;
  struct pbuf *q;
  u8_t swapped;

  acc = 0;
     cc6:	c7 45 f4 00 00 00 00 	movl   $0x0,0xfffffff4(%ebp)
  swapped = 0;
     ccd:	c6 45 ff 00          	movb   $0x0,0xffffffff(%ebp)
  for(q = p; q != NULL; q = q->next) {
     cd1:	8b 45 08             	mov    0x8(%ebp),%eax
     cd4:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
     cd7:	eb 69                	jmp    d42 <inet_chksum_pbuf+0x82>
    acc += lwip_chksum(q->payload, q->len);
     cd9:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     cdc:	0f b7 40 0a          	movzwl 0xa(%eax),%eax
     ce0:	0f b7 d0             	movzwl %ax,%edx
     ce3:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     ce6:	8b 40 04             	mov    0x4(%eax),%eax
     ce9:	89 54 24 04          	mov    %edx,0x4(%esp)
     ced:	89 04 24             	mov    %eax,(%esp)
     cf0:	e8 9b fd ff ff       	call   a90 <lwip_chksum>
     cf5:	0f b7 c0             	movzwl %ax,%eax
     cf8:	01 45 f4             	add    %eax,0xfffffff4(%ebp)
    while (acc >> 16) {
     cfb:	eb 10                	jmp    d0d <inet_chksum_pbuf+0x4d>
      acc = (acc & 0xffffUL) + (acc >> 16);
     cfd:	0f b7 55 f4          	movzwl 0xfffffff4(%ebp),%edx
     d01:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     d04:	c1 e8 10             	shr    $0x10,%eax
     d07:	8d 04 02             	lea    (%edx,%eax,1),%eax
     d0a:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
     d0d:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     d10:	c1 e8 10             	shr    $0x10,%eax
     d13:	85 c0                	test   %eax,%eax
     d15:	75 e6                	jne    cfd <inet_chksum_pbuf+0x3d>
    }
    if (q->len % 2 != 0) {
     d17:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     d1a:	0f b7 40 0a          	movzwl 0xa(%eax),%eax
     d1e:	0f b7 c0             	movzwl %ax,%eax
     d21:	83 e0 01             	and    $0x1,%eax
     d24:	84 c0                	test   %al,%al
     d26:	74 12                	je     d3a <inet_chksum_pbuf+0x7a>
      swapped = 1 - swapped;
     d28:	b8 01 00 00 00       	mov    $0x1,%eax
     d2d:	2a 45 ff             	sub    0xffffffff(%ebp),%al
     d30:	88 45 ff             	mov    %al,0xffffffff(%ebp)
      acc = (acc & 0x00ffUL << 8) | (acc & 0xff00UL >> 8);
     d33:	81 65 f4 ff ff 00 00 	andl   $0xffff,0xfffffff4(%ebp)
     d3a:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     d3d:	8b 00                	mov    (%eax),%eax
     d3f:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
     d42:	83 7d f8 00          	cmpl   $0x0,0xfffffff8(%ebp)
     d46:	75 91                	jne    cd9 <inet_chksum_pbuf+0x19>
    }
  }

  if (swapped) {
     d48:	80 7d ff 00          	cmpb   $0x0,0xffffffff(%ebp)
     d4c:	74 19                	je     d67 <inet_chksum_pbuf+0xa7>
    acc = ((acc & 0x00ffUL) << 8) | ((acc & 0xff00UL) >> 8);
     d4e:	0f b6 45 f4          	movzbl 0xfffffff4(%ebp),%eax
     d52:	89 c2                	mov    %eax,%edx
     d54:	c1 e2 08             	shl    $0x8,%edx
     d57:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     d5a:	25 00 ff 00 00       	and    $0xff00,%eax
     d5f:	c1 e8 08             	shr    $0x8,%eax
     d62:	09 d0                	or     %edx,%eax
     d64:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
  }
  return ~(acc & 0xffffUL);
     d67:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     d6a:	f7 d0                	not    %eax
     d6c:	0f b7 c0             	movzwl %ax,%eax
}
     d6f:	c9                   	leave  
     d70:	c3                   	ret    
     d71:	eb 0d                	jmp    d80 <inet_addr>
     d73:	90                   	nop    
     d74:	90                   	nop    
     d75:	90                   	nop    
     d76:	90                   	nop    
     d77:	90                   	nop    
     d78:	90                   	nop    
     d79:	90                   	nop    
     d7a:	90                   	nop    
     d7b:	90                   	nop    
     d7c:	90                   	nop    
     d7d:	90                   	nop    
     d7e:	90                   	nop    
     d7f:	90                   	nop    

00000d80 <inet_addr>:

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
     d80:	55                   	push   %ebp
     d81:	89 e5                	mov    %esp,%ebp
     d83:	83 ec 28             	sub    $0x28,%esp
     struct in_addr val;

     if (inet_aton(cp, &val)) {
     d86:	8d 45 fc             	lea    0xfffffffc(%ebp),%eax
     d89:	89 44 24 04          	mov    %eax,0x4(%esp)
     d8d:	8b 45 08             	mov    0x8(%ebp),%eax
     d90:	89 04 24             	mov    %eax,(%esp)
     d93:	e8 18 00 00 00       	call   db0 <inet_aton>
     d98:	85 c0                	test   %eax,%eax
     d9a:	74 08                	je     da4 <inet_addr+0x24>
         return (val.s_addr);
     d9c:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     d9f:	89 45 ec             	mov    %eax,0xffffffec(%ebp)
     da2:	eb 07                	jmp    dab <inet_addr+0x2b>
     }
     return (INADDR_NONE);
     da4:	c7 45 ec ff ff ff ff 	movl   $0xffffffff,0xffffffec(%ebp)
     dab:	8b 45 ec             	mov    0xffffffec(%ebp),%eax
 }
     dae:	c9                   	leave  
     daf:	c3                   	ret    

00000db0 <inet_aton>:

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
     db0:	55                   	push   %ebp
     db1:	89 e5                	mov    %esp,%ebp
     db3:	83 ec 48             	sub    $0x48,%esp
     u32_t val;
     int base, n;
     char c;
     u32_t parts[4];
     u32_t* pp = parts;
     db6:	8d 45 dc             	lea    0xffffffdc(%ebp),%eax
     db9:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)

     c = *cp;
     dbc:	8b 45 08             	mov    0x8(%ebp),%eax
     dbf:	0f b6 00             	movzbl (%eax),%eax
     dc2:	88 45 fb             	mov    %al,0xfffffffb(%ebp)
     for (;;) {
         /*
          * Collect number up to ``.''.
          * Values are specified as for C:
          * 0x=hex, 0=octal, isdigit=decimal.
          */
         if (!isdigit(c))
     dc5:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
     dc9:	3c 2f                	cmp    $0x2f,%al
     dcb:	76 08                	jbe    dd5 <inet_aton+0x25>
     dcd:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
     dd1:	3c 39                	cmp    $0x39,%al
     dd3:	76 0c                	jbe    de1 <inet_aton+0x31>
             return (0);
     dd5:	c7 45 c0 00 00 00 00 	movl   $0x0,0xffffffc0(%ebp)
     ddc:	e9 78 02 00 00       	jmp    1059 <inet_aton+0x2a9>
         val = 0; base = 10;
     de1:	c7 45 ec 00 00 00 00 	movl   $0x0,0xffffffec(%ebp)
     de8:	c7 45 f0 0a 00 00 00 	movl   $0xa,0xfffffff0(%ebp)
         if (c == '0') {
     def:	80 7d fb 30          	cmpb   $0x30,0xfffffffb(%ebp)
     df3:	75 36                	jne    e2b <inet_aton+0x7b>
             c = *++cp;
     df5:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     df9:	8b 45 08             	mov    0x8(%ebp),%eax
     dfc:	0f b6 00             	movzbl (%eax),%eax
     dff:	88 45 fb             	mov    %al,0xfffffffb(%ebp)
             if (c == 'x' || c == 'X')
     e02:	80 7d fb 78          	cmpb   $0x78,0xfffffffb(%ebp)
     e06:	74 06                	je     e0e <inet_aton+0x5e>
     e08:	80 7d fb 58          	cmpb   $0x58,0xfffffffb(%ebp)
     e0c:	75 16                	jne    e24 <inet_aton+0x74>
                 base = 16, c = *++cp;
     e0e:	c7 45 f0 10 00 00 00 	movl   $0x10,0xfffffff0(%ebp)
     e15:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     e19:	8b 45 08             	mov    0x8(%ebp),%eax
     e1c:	0f b6 00             	movzbl (%eax),%eax
     e1f:	88 45 fb             	mov    %al,0xfffffffb(%ebp)
     e22:	eb 07                	jmp    e2b <inet_aton+0x7b>
             else
                 base = 8;
     e24:	c7 45 f0 08 00 00 00 	movl   $0x8,0xfffffff0(%ebp)
         }
         for (;;) {
             if (isascii(c) && isdigit(c)) {
     e2b:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
     e2f:	3c 1f                	cmp    $0x1f,%al
     e31:	76 3b                	jbe    e6e <inet_aton+0xbe>
     e33:	80 7d fb 00          	cmpb   $0x0,0xfffffffb(%ebp)
     e37:	78 35                	js     e6e <inet_aton+0xbe>
     e39:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
     e3d:	3c 2f                	cmp    $0x2f,%al
     e3f:	76 2d                	jbe    e6e <inet_aton+0xbe>
     e41:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
     e45:	3c 39                	cmp    $0x39,%al
     e47:	77 25                	ja     e6e <inet_aton+0xbe>
                 val = (val * base) + (c - '0');
     e49:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
     e4c:	89 c2                	mov    %eax,%edx
     e4e:	0f af 55 ec          	imul   0xffffffec(%ebp),%edx
     e52:	0f be 45 fb          	movsbl 0xfffffffb(%ebp),%eax
     e56:	8d 04 02             	lea    (%edx,%eax,1),%eax
     e59:	83 e8 30             	sub    $0x30,%eax
     e5c:	89 45 ec             	mov    %eax,0xffffffec(%ebp)
                 c = *++cp;
     e5f:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     e63:	8b 45 08             	mov    0x8(%ebp),%eax
     e66:	0f b6 00             	movzbl (%eax),%eax
     e69:	88 45 fb             	mov    %al,0xfffffffb(%ebp)
     e6c:	eb bd                	jmp    e2b <inet_aton+0x7b>
             } else if (base == 16 && isascii(c) && isxdigit(c)) {
     e6e:	83 7d f0 10          	cmpl   $0x10,0xfffffff0(%ebp)
     e72:	0f 85 99 00 00 00    	jne    f11 <inet_aton+0x161>
     e78:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
     e7c:	3c 1f                	cmp    $0x1f,%al
     e7e:	0f 86 8d 00 00 00    	jbe    f11 <inet_aton+0x161>
     e84:	80 7d fb 00          	cmpb   $0x0,0xfffffffb(%ebp)
     e88:	0f 88 83 00 00 00    	js     f11 <inet_aton+0x161>
     e8e:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
     e92:	3c 2f                	cmp    $0x2f,%al
     e94:	76 08                	jbe    e9e <inet_aton+0xee>
     e96:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
     e9a:	3c 39                	cmp    $0x39,%al
     e9c:	76 20                	jbe    ebe <inet_aton+0x10e>
     e9e:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
     ea2:	3c 60                	cmp    $0x60,%al
     ea4:	76 08                	jbe    eae <inet_aton+0xfe>
     ea6:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
     eaa:	3c 66                	cmp    $0x66,%al
     eac:	76 10                	jbe    ebe <inet_aton+0x10e>
     eae:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
     eb2:	3c 40                	cmp    $0x40,%al
     eb4:	76 5b                	jbe    f11 <inet_aton+0x161>
     eb6:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
     eba:	3c 46                	cmp    $0x46,%al
     ebc:	77 53                	ja     f11 <inet_aton+0x161>
                 val = (val << 4) |
     ebe:	8b 45 ec             	mov    0xffffffec(%ebp),%eax
     ec1:	89 c2                	mov    %eax,%edx
     ec3:	c1 e2 04             	shl    $0x4,%edx
     ec6:	89 55 c4             	mov    %edx,0xffffffc4(%ebp)
     ec9:	0f be 45 fb          	movsbl 0xfffffffb(%ebp),%eax
     ecd:	83 c0 0a             	add    $0xa,%eax
     ed0:	89 45 c8             	mov    %eax,0xffffffc8(%ebp)
     ed3:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
     ed7:	3c 60                	cmp    $0x60,%al
     ed9:	76 11                	jbe    eec <inet_aton+0x13c>
     edb:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
     edf:	3c 7a                	cmp    $0x7a,%al
     ee1:	77 09                	ja     eec <inet_aton+0x13c>
     ee3:	c7 45 cc 61 00 00 00 	movl   $0x61,0xffffffcc(%ebp)
     eea:	eb 07                	jmp    ef3 <inet_aton+0x143>
     eec:	c7 45 cc 41 00 00 00 	movl   $0x41,0xffffffcc(%ebp)
     ef3:	8b 45 c8             	mov    0xffffffc8(%ebp),%eax
     ef6:	2b 45 cc             	sub    0xffffffcc(%ebp),%eax
     ef9:	0b 45 c4             	or     0xffffffc4(%ebp),%eax
     efc:	89 45 ec             	mov    %eax,0xffffffec(%ebp)
                     (c + 10 - (islower(c) ? 'a' : 'A'));
                 c = *++cp;
     eff:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     f03:	8b 45 08             	mov    0x8(%ebp),%eax
     f06:	0f b6 00             	movzbl (%eax),%eax
     f09:	88 45 fb             	mov    %al,0xfffffffb(%ebp)
             } else
             break;
         }
     f0c:	e9 1a ff ff ff       	jmp    e2b <inet_aton+0x7b>
         if (c == '.') {
     f11:	80 7d fb 2e          	cmpb   $0x2e,0xfffffffb(%ebp)
     f15:	75 35                	jne    f4c <inet_aton+0x19c>
             /*
              * Internet format:
              *  a.b.c.d
              *  a.b.c   (with c treated as 16 bits)
              *  a.b (with b treated as 24 bits)
              */
             if (pp >= parts + 3)
     f17:	8d 45 dc             	lea    0xffffffdc(%ebp),%eax
     f1a:	83 c0 0c             	add    $0xc,%eax
     f1d:	3b 45 fc             	cmp    0xfffffffc(%ebp),%eax
     f20:	77 0c                	ja     f2e <inet_aton+0x17e>
                 return (0);
     f22:	c7 45 c0 00 00 00 00 	movl   $0x0,0xffffffc0(%ebp)
     f29:	e9 2b 01 00 00       	jmp    1059 <inet_aton+0x2a9>
             *pp++ = val;
     f2e:	8b 55 fc             	mov    0xfffffffc(%ebp),%edx
     f31:	8b 45 ec             	mov    0xffffffec(%ebp),%eax
     f34:	89 02                	mov    %eax,(%edx)
     f36:	83 45 fc 04          	addl   $0x4,0xfffffffc(%ebp)
             c = *++cp;
     f3a:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     f3e:	8b 45 08             	mov    0x8(%ebp),%eax
     f41:	0f b6 00             	movzbl (%eax),%eax
     f44:	88 45 fb             	mov    %al,0xfffffffb(%ebp)
         } else
             break;
     }
     f47:	e9 79 fe ff ff       	jmp    dc5 <inet_aton+0x15>
     /*
      * Check for trailing characters.
      */
     if (c != '\0' && (!isascii(c) || !isspace(c)))
     f4c:	80 7d fb 00          	cmpb   $0x0,0xfffffffb(%ebp)
     f50:	74 3e                	je     f90 <inet_aton+0x1e0>
     f52:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
     f56:	3c 1f                	cmp    $0x1f,%al
     f58:	76 2a                	jbe    f84 <inet_aton+0x1d4>
     f5a:	80 7d fb 00          	cmpb   $0x0,0xfffffffb(%ebp)
     f5e:	78 24                	js     f84 <inet_aton+0x1d4>
     f60:	80 7d fb 20          	cmpb   $0x20,0xfffffffb(%ebp)
     f64:	74 2a                	je     f90 <inet_aton+0x1e0>
     f66:	80 7d fb 0c          	cmpb   $0xc,0xfffffffb(%ebp)
     f6a:	74 24                	je     f90 <inet_aton+0x1e0>
     f6c:	80 7d fb 0a          	cmpb   $0xa,0xfffffffb(%ebp)
     f70:	74 1e                	je     f90 <inet_aton+0x1e0>
     f72:	80 7d fb 0d          	cmpb   $0xd,0xfffffffb(%ebp)
     f76:	74 18                	je     f90 <inet_aton+0x1e0>
     f78:	80 7d fb 09          	cmpb   $0x9,0xfffffffb(%ebp)
     f7c:	74 12                	je     f90 <inet_aton+0x1e0>
     f7e:	80 7d fb 0b          	cmpb   $0xb,0xfffffffb(%ebp)
     f82:	74 0c                	je     f90 <inet_aton+0x1e0>
         return (0);
     f84:	c7 45 c0 00 00 00 00 	movl   $0x0,0xffffffc0(%ebp)
     f8b:	e9 c9 00 00 00       	jmp    1059 <inet_aton+0x2a9>
     /*
      * Concoct the address according to
      * the number of parts specified.
      */
     n = pp - parts + 1;
     f90:	8b 55 fc             	mov    0xfffffffc(%ebp),%edx
     f93:	8d 45 dc             	lea    0xffffffdc(%ebp),%eax
     f96:	89 d1                	mov    %edx,%ecx
     f98:	29 c1                	sub    %eax,%ecx
     f9a:	89 c8                	mov    %ecx,%eax
     f9c:	c1 f8 02             	sar    $0x2,%eax
     f9f:	83 c0 01             	add    $0x1,%eax
     fa2:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
     switch (n) {
     fa5:	83 7d f4 04          	cmpl   $0x4,0xfffffff4(%ebp)
     fa9:	0f 87 8b 00 00 00    	ja     103a <inet_aton+0x28a>
     faf:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     fb2:	c1 e0 02             	shl    $0x2,%eax
     fb5:	8b 80 44 12 00 00    	mov    0x1244(%eax),%eax
     fbb:	ff e0                	jmp    *%eax

     case 0:
         return (0);     /* initial nondigit */
     fbd:	c7 45 c0 00 00 00 00 	movl   $0x0,0xffffffc0(%ebp)
     fc4:	e9 90 00 00 00       	jmp    1059 <inet_aton+0x2a9>

     case 1:             /* a -- 32 bits */
         break;

     case 2:             /* a.b -- 8.24 bits */
         if (val > 0xffffff)
     fc9:	81 7d ec ff ff ff 00 	cmpl   $0xffffff,0xffffffec(%ebp)
     fd0:	76 09                	jbe    fdb <inet_aton+0x22b>
             return (0);
     fd2:	c7 45 c0 00 00 00 00 	movl   $0x0,0xffffffc0(%ebp)
     fd9:	eb 7e                	jmp    1059 <inet_aton+0x2a9>
         val |= parts[0] << 24;
     fdb:	8b 45 dc             	mov    0xffffffdc(%ebp),%eax
     fde:	c1 e0 18             	shl    $0x18,%eax
     fe1:	09 45 ec             	or     %eax,0xffffffec(%ebp)
         break;
     fe4:	eb 54                	jmp    103a <inet_aton+0x28a>

     case 3:             /* a.b.c -- 8.8.16 bits */
         if (val > 0xffff)
     fe6:	81 7d ec ff ff 00 00 	cmpl   $0xffff,0xffffffec(%ebp)
     fed:	76 09                	jbe    ff8 <inet_aton+0x248>
             return (0);
     fef:	c7 45 c0 00 00 00 00 	movl   $0x0,0xffffffc0(%ebp)
     ff6:	eb 61                	jmp    1059 <inet_aton+0x2a9>
         val |= (parts[0] << 24) | (parts[1] << 16);
     ff8:	8b 45 dc             	mov    0xffffffdc(%ebp),%eax
     ffb:	89 c2                	mov    %eax,%edx
     ffd:	c1 e2 18             	shl    $0x18,%edx
    1000:	8b 45 e0             	mov    0xffffffe0(%ebp),%eax
    1003:	c1 e0 10             	shl    $0x10,%eax
    1006:	09 d0                	or     %edx,%eax
    1008:	09 45 ec             	or     %eax,0xffffffec(%ebp)
         break;
    100b:	eb 2d                	jmp    103a <inet_aton+0x28a>

     case 4:             /* a.b.c.d -- 8.8.8.8 bits */
         if (val > 0xff)
    100d:	81 7d ec ff 00 00 00 	cmpl   $0xff,0xffffffec(%ebp)
    1014:	76 09                	jbe    101f <inet_aton+0x26f>
             return (0);
    1016:	c7 45 c0 00 00 00 00 	movl   $0x0,0xffffffc0(%ebp)
    101d:	eb 3a                	jmp    1059 <inet_aton+0x2a9>
         val |= (parts[0] << 24) | (parts[1] << 16) | (parts[2] << 8);
    101f:	8b 45 dc             	mov    0xffffffdc(%ebp),%eax
    1022:	89 c2                	mov    %eax,%edx
    1024:	c1 e2 18             	shl    $0x18,%edx
    1027:	8b 45 e0             	mov    0xffffffe0(%ebp),%eax
    102a:	c1 e0 10             	shl    $0x10,%eax
    102d:	09 c2                	or     %eax,%edx
    102f:	8b 45 e4             	mov    0xffffffe4(%ebp),%eax
    1032:	c1 e0 08             	shl    $0x8,%eax
    1035:	09 d0                	or     %edx,%eax
    1037:	09 45 ec             	or     %eax,0xffffffec(%ebp)
         break;
     }
     if (addr)
    103a:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    103e:	74 12                	je     1052 <inet_aton+0x2a2>
         addr->s_addr = htonl(val);
    1040:	8b 45 ec             	mov    0xffffffec(%ebp),%eax
    1043:	89 04 24             	mov    %eax,(%esp)
    1046:	e8 65 01 00 00       	call   11b0 <htonl>
    104b:	89 c2                	mov    %eax,%edx
    104d:	8b 45 0c             	mov    0xc(%ebp),%eax
    1050:	89 10                	mov    %edx,(%eax)
     return (1);
    1052:	c7 45 c0 01 00 00 00 	movl   $0x1,0xffffffc0(%ebp)
    1059:	8b 45 c0             	mov    0xffffffc0(%ebp),%eax
 }
    105c:	c9                   	leave  
    105d:	c3                   	ret    
    105e:	89 f6                	mov    %esi,%esi

00001060 <inet_ntoa>:

/* Convert numeric IP address into decimal dotted ASCII representation.
 * returns ptr to static buffer; not reentrant!
 */
char *inet_ntoa(struct in_addr addr)
{
    1060:	55                   	push   %ebp
    1061:	89 e5                	mov    %esp,%ebp
    1063:	53                   	push   %ebx
    1064:	83 ec 24             	sub    $0x24,%esp
  static char str[16];
  u32_t s_addr = addr.s_addr;
    1067:	8b 45 08             	mov    0x8(%ebp),%eax
    106a:	89 45 ec             	mov    %eax,0xffffffec(%ebp)
  char inv[3];
  char *rp;
  char *ap;
  u8_t rem;
  u8_t n;
  u8_t i;

  rp = str;
    106d:	c7 45 f0 8c 12 00 00 	movl   $0x128c,0xfffffff0(%ebp)
  ap = (u8_t *)&s_addr;
    1074:	8d 45 ec             	lea    0xffffffec(%ebp),%eax
    1077:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
  for(n = 0; n < 4; n++) {
    107a:	c6 45 fa 00          	movb   $0x0,0xfffffffa(%ebp)
    107e:	e9 af 00 00 00       	jmp    1132 <inet_ntoa+0xd2>
    i = 0;
    1083:	c6 45 fb 00          	movb   $0x0,0xfffffffb(%ebp)
    do {
      rem = *ap % (u8_t)10;
    1087:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
    108a:	0f b6 08             	movzbl (%eax),%ecx
    108d:	b8 67 00 00 00       	mov    $0x67,%eax
    1092:	f6 e9                	imul   %cl
    1094:	66 c1 e8 08          	shr    $0x8,%ax
    1098:	89 c2                	mov    %eax,%edx
    109a:	c0 fa 02             	sar    $0x2,%dl
    109d:	89 c8                	mov    %ecx,%eax
    109f:	c0 f8 07             	sar    $0x7,%al
    10a2:	89 d3                	mov    %edx,%ebx
    10a4:	28 c3                	sub    %al,%bl
    10a6:	88 5d db             	mov    %bl,0xffffffdb(%ebp)
    10a9:	0f b6 45 db          	movzbl 0xffffffdb(%ebp),%eax
    10ad:	c1 e0 02             	shl    $0x2,%eax
    10b0:	02 45 db             	add    0xffffffdb(%ebp),%al
    10b3:	01 c0                	add    %eax,%eax
    10b5:	89 ca                	mov    %ecx,%edx
    10b7:	28 c2                	sub    %al,%dl
    10b9:	88 55 db             	mov    %dl,0xffffffdb(%ebp)
    10bc:	0f b6 5d db          	movzbl 0xffffffdb(%ebp),%ebx
    10c0:	88 5d f9             	mov    %bl,0xfffffff9(%ebp)
      *ap /= (u8_t)10;
    10c3:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
    10c6:	0f b6 08             	movzbl (%eax),%ecx
    10c9:	b8 67 00 00 00       	mov    $0x67,%eax
    10ce:	f6 e9                	imul   %cl
    10d0:	66 c1 e8 08          	shr    $0x8,%ax
    10d4:	89 c2                	mov    %eax,%edx
    10d6:	c0 fa 02             	sar    $0x2,%dl
    10d9:	89 c8                	mov    %ecx,%eax
    10db:	c0 f8 07             	sar    $0x7,%al
    10de:	28 c2                	sub    %al,%dl
    10e0:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
    10e3:	88 10                	mov    %dl,(%eax)
      inv[i++] = '0' + rem;
    10e5:	0f b6 55 fb          	movzbl 0xfffffffb(%ebp),%edx
    10e9:	0f b6 45 f9          	movzbl 0xfffffff9(%ebp),%eax
    10ed:	83 c0 30             	add    $0x30,%eax
    10f0:	88 44 15 e9          	mov    %al,0xffffffe9(%ebp,%edx,1)
    10f4:	80 45 fb 01          	addb   $0x1,0xfffffffb(%ebp)
    } while(*ap);
    10f8:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
    10fb:	0f b6 00             	movzbl (%eax),%eax
    10fe:	84 c0                	test   %al,%al
    1100:	75 85                	jne    1087 <inet_ntoa+0x27>
    while(i--)
    1102:	eb 12                	jmp    1116 <inet_ntoa+0xb6>
      *rp++ = inv[i];
    1104:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
    1108:	0f b6 54 05 e9       	movzbl 0xffffffe9(%ebp,%eax,1),%edx
    110d:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
    1110:	88 10                	mov    %dl,(%eax)
    1112:	83 45 f0 01          	addl   $0x1,0xfffffff0(%ebp)
    1116:	80 6d fb 01          	subb   $0x1,0xfffffffb(%ebp)
    111a:	80 7d fb ff          	cmpb   $0xff,0xfffffffb(%ebp)
    111e:	75 e4                	jne    1104 <inet_ntoa+0xa4>
    *rp++ = '.';
    1120:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
    1123:	c6 00 2e             	movb   $0x2e,(%eax)
    1126:	83 45 f0 01          	addl   $0x1,0xfffffff0(%ebp)
    ap++;
    112a:	83 45 f4 01          	addl   $0x1,0xfffffff4(%ebp)
    112e:	80 45 fa 01          	addb   $0x1,0xfffffffa(%ebp)
    1132:	80 7d fa 03          	cmpb   $0x3,0xfffffffa(%ebp)
    1136:	0f 86 47 ff ff ff    	jbe    1083 <inet_ntoa+0x23>
  }
  *--rp = 0;
    113c:	83 6d f0 01          	subl   $0x1,0xfffffff0(%ebp)
    1140:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
    1143:	c6 00 00             	movb   $0x0,(%eax)
  return str;
    1146:	b8 8c 12 00 00       	mov    $0x128c,%eax
}
    114b:	83 c4 24             	add    $0x24,%esp
    114e:	5b                   	pop    %ebx
    114f:	5d                   	pop    %ebp
    1150:	c3                   	ret    
    1151:	eb 0d                	jmp    1160 <htons>
    1153:	90                   	nop    
    1154:	90                   	nop    
    1155:	90                   	nop    
    1156:	90                   	nop    
    1157:	90                   	nop    
    1158:	90                   	nop    
    1159:	90                   	nop    
    115a:	90                   	nop    
    115b:	90                   	nop    
    115c:	90                   	nop    
    115d:	90                   	nop    
    115e:	90                   	nop    
    115f:	90                   	nop    

00001160 <htons>:


#ifndef BYTE_ORDER
#error BYTE_ORDER is not defined
#endif
#if BYTE_ORDER == LITTLE_ENDIAN

u16_t
htons(u16_t n)
{
    1160:	55                   	push   %ebp
    1161:	89 e5                	mov    %esp,%ebp
    1163:	83 ec 04             	sub    $0x4,%esp
    1166:	8b 45 08             	mov    0x8(%ebp),%eax
    1169:	66 89 45 fc          	mov    %ax,0xfffffffc(%ebp)
  return ((n & 0xff) << 8) | ((n & 0xff00) >> 8);
    116d:	0f b7 45 fc          	movzwl 0xfffffffc(%ebp),%eax
    1171:	25 ff 00 00 00       	and    $0xff,%eax
    1176:	c1 e0 08             	shl    $0x8,%eax
    1179:	89 c2                	mov    %eax,%edx
    117b:	0f b7 45 fc          	movzwl 0xfffffffc(%ebp),%eax
    117f:	25 00 ff 00 00       	and    $0xff00,%eax
    1184:	c1 f8 08             	sar    $0x8,%eax
    1187:	09 d0                	or     %edx,%eax
    1189:	0f b7 c0             	movzwl %ax,%eax
}
    118c:	c9                   	leave  
    118d:	c3                   	ret    
    118e:	89 f6                	mov    %esi,%esi

00001190 <ntohs>:

u16_t
ntohs(u16_t n)
{
    1190:	55                   	push   %ebp
    1191:	89 e5                	mov    %esp,%ebp
    1193:	83 ec 08             	sub    $0x8,%esp
    1196:	8b 45 08             	mov    0x8(%ebp),%eax
    1199:	66 89 45 fc          	mov    %ax,0xfffffffc(%ebp)
  return htons(n);
    119d:	0f b7 45 fc          	movzwl 0xfffffffc(%ebp),%eax
    11a1:	89 04 24             	mov    %eax,(%esp)
    11a4:	e8 b7 ff ff ff       	call   1160 <htons>
    11a9:	0f b7 c0             	movzwl %ax,%eax
}
    11ac:	c9                   	leave  
    11ad:	c3                   	ret    
    11ae:	89 f6                	mov    %esi,%esi

000011b0 <htonl>:

u32_t
htonl(u32_t n)
{
    11b0:	55                   	push   %ebp
    11b1:	89 e5                	mov    %esp,%ebp
  return ((n & 0xff) << 24) |
    11b3:	0f b6 45 08          	movzbl 0x8(%ebp),%eax
    11b7:	89 c2                	mov    %eax,%edx
    11b9:	c1 e2 18             	shl    $0x18,%edx
    11bc:	8b 45 08             	mov    0x8(%ebp),%eax
    11bf:	25 00 ff 00 00       	and    $0xff00,%eax
    11c4:	c1 e0 08             	shl    $0x8,%eax
    11c7:	09 c2                	or     %eax,%edx
    11c9:	8b 45 08             	mov    0x8(%ebp),%eax
    11cc:	25 00 00 ff 00       	and    $0xff0000,%eax
    11d1:	c1 e8 08             	shr    $0x8,%eax
    11d4:	09 c2                	or     %eax,%edx
    11d6:	8b 45 08             	mov    0x8(%ebp),%eax
    11d9:	25 00 00 00 ff       	and    $0xff000000,%eax
    11de:	c1 e8 18             	shr    $0x18,%eax
    11e1:	09 d0                	or     %edx,%eax
    ((n & 0xff00) << 8) |
    ((n & 0xff0000) >> 8) |
    ((n & 0xff000000) >> 24);
}
    11e3:	5d                   	pop    %ebp
    11e4:	c3                   	ret    
    11e5:	8d 74 26 00          	lea    0x0(%esi),%esi
    11e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

000011f0 <ntohl>:

u32_t
ntohl(u32_t n)
{
    11f0:	55                   	push   %ebp
    11f1:	89 e5                	mov    %esp,%ebp
    11f3:	83 ec 04             	sub    $0x4,%esp
  return htonl(n);
    11f6:	8b 45 08             	mov    0x8(%ebp),%eax
    11f9:	89 04 24             	mov    %eax,(%esp)
    11fc:	e8 af ff ff ff       	call   11b0 <htonl>
}
    1201:	c9                   	leave  
    1202:	c3                   	ret    
