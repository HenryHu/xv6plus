
_mkdir:     file format elf32-i386-freebsd

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
       e:	83 ec 24             	sub    $0x24,%esp
      11:	89 4d e8             	mov    %ecx,0xffffffe8(%ebp)
  int i;

  if(argc < 2){
      14:	8b 45 e8             	mov    0xffffffe8(%ebp),%eax
      17:	83 38 01             	cmpl   $0x1,(%eax)
      1a:	7f 19                	jg     35 <main+0x35>
    printf(2, "Usage: mkdir files...\n");
      1c:	c7 44 24 04 c4 10 00 	movl   $0x10c4,0x4(%esp)
      23:	00 
      24:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
      2b:	e8 10 05 00 00       	call   540 <printf>
    exit();
      30:	e8 ff 02 00 00       	call   334 <exit>
  }

  for(i = 1; i < argc; i++){
      35:	c7 45 f8 01 00 00 00 	movl   $0x1,0xfffffff8(%ebp)
      3c:	eb 46                	jmp    84 <main+0x84>
    if(mkdir(argv[i]) < 0){
      3e:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
      41:	c1 e0 02             	shl    $0x2,%eax
      44:	8b 55 e8             	mov    0xffffffe8(%ebp),%edx
      47:	03 42 04             	add    0x4(%edx),%eax
      4a:	8b 00                	mov    (%eax),%eax
      4c:	89 04 24             	mov    %eax,(%esp)
      4f:	e8 48 03 00 00       	call   39c <mkdir>
      54:	85 c0                	test   %eax,%eax
      56:	79 28                	jns    80 <main+0x80>
      printf(2, "mkdir: %s failed to create\n", argv[i]);
      58:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
      5b:	c1 e0 02             	shl    $0x2,%eax
      5e:	8b 55 e8             	mov    0xffffffe8(%ebp),%edx
      61:	03 42 04             	add    0x4(%edx),%eax
      64:	8b 00                	mov    (%eax),%eax
      66:	89 44 24 08          	mov    %eax,0x8(%esp)
      6a:	c7 44 24 04 db 10 00 	movl   $0x10db,0x4(%esp)
      71:	00 
      72:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
      79:	e8 c2 04 00 00       	call   540 <printf>
      break;
      7e:	eb 0e                	jmp    8e <main+0x8e>
      80:	83 45 f8 01          	addl   $0x1,0xfffffff8(%ebp)
      84:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
      87:	8b 55 e8             	mov    0xffffffe8(%ebp),%edx
      8a:	3b 02                	cmp    (%edx),%eax
      8c:	7c b0                	jl     3e <main+0x3e>
    }
  }

  exit();
      8e:	e8 a1 02 00 00       	call   334 <exit>
      93:	90                   	nop    
      94:	90                   	nop    
      95:	90                   	nop    
      96:	90                   	nop    
      97:	90                   	nop    
      98:	90                   	nop    
      99:	90                   	nop    
      9a:	90                   	nop    
      9b:	90                   	nop    
      9c:	90                   	nop    
      9d:	90                   	nop    
      9e:	90                   	nop    
      9f:	90                   	nop    

000000a0 <strcpy>:
#include "user.h"

char*
strcpy(char *s, char *t)
{
      a0:	55                   	push   %ebp
      a1:	89 e5                	mov    %esp,%ebp
      a3:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
      a6:	8b 45 08             	mov    0x8(%ebp),%eax
      a9:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
  while((*s++ = *t++) != 0)
      ac:	8b 45 0c             	mov    0xc(%ebp),%eax
      af:	0f b6 10             	movzbl (%eax),%edx
      b2:	8b 45 08             	mov    0x8(%ebp),%eax
      b5:	88 10                	mov    %dl,(%eax)
      b7:	8b 45 08             	mov    0x8(%ebp),%eax
      ba:	0f b6 00             	movzbl (%eax),%eax
      bd:	84 c0                	test   %al,%al
      bf:	0f 95 c0             	setne  %al
      c2:	83 45 08 01          	addl   $0x1,0x8(%ebp)
      c6:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
      ca:	84 c0                	test   %al,%al
      cc:	75 de                	jne    ac <strcpy+0xc>
    ;
  return os;
      ce:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
}
      d1:	c9                   	leave  
      d2:	c3                   	ret    
      d3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

000000e0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
      e0:	55                   	push   %ebp
      e1:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
      e3:	eb 08                	jmp    ed <strcmp+0xd>
    p++, q++;
      e5:	83 45 08 01          	addl   $0x1,0x8(%ebp)
      e9:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
      ed:	8b 45 08             	mov    0x8(%ebp),%eax
      f0:	0f b6 00             	movzbl (%eax),%eax
      f3:	84 c0                	test   %al,%al
      f5:	74 10                	je     107 <strcmp+0x27>
      f7:	8b 45 08             	mov    0x8(%ebp),%eax
      fa:	0f b6 10             	movzbl (%eax),%edx
      fd:	8b 45 0c             	mov    0xc(%ebp),%eax
     100:	0f b6 00             	movzbl (%eax),%eax
     103:	38 c2                	cmp    %al,%dl
     105:	74 de                	je     e5 <strcmp+0x5>
  return (uchar)*p - (uchar)*q;
     107:	8b 45 08             	mov    0x8(%ebp),%eax
     10a:	0f b6 00             	movzbl (%eax),%eax
     10d:	0f b6 d0             	movzbl %al,%edx
     110:	8b 45 0c             	mov    0xc(%ebp),%eax
     113:	0f b6 00             	movzbl (%eax),%eax
     116:	0f b6 c0             	movzbl %al,%eax
     119:	89 d1                	mov    %edx,%ecx
     11b:	29 c1                	sub    %eax,%ecx
     11d:	89 c8                	mov    %ecx,%eax
}
     11f:	5d                   	pop    %ebp
     120:	c3                   	ret    
     121:	eb 0d                	jmp    130 <strlen>
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

00000130 <strlen>:

uint
strlen(char *s)
{
     130:	55                   	push   %ebp
     131:	89 e5                	mov    %esp,%ebp
     133:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
     136:	c7 45 fc 00 00 00 00 	movl   $0x0,0xfffffffc(%ebp)
     13d:	eb 04                	jmp    143 <strlen+0x13>
     13f:	83 45 fc 01          	addl   $0x1,0xfffffffc(%ebp)
     143:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     146:	03 45 08             	add    0x8(%ebp),%eax
     149:	0f b6 00             	movzbl (%eax),%eax
     14c:	84 c0                	test   %al,%al
     14e:	75 ef                	jne    13f <strlen+0xf>
    ;
  return n;
     150:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
}
     153:	c9                   	leave  
     154:	c3                   	ret    
     155:	8d 74 26 00          	lea    0x0(%esi),%esi
     159:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00000160 <memset>:

void*
memset(void *dst, int c, uint n)
{
     160:	55                   	push   %ebp
     161:	89 e5                	mov    %esp,%ebp
     163:	83 ec 10             	sub    $0x10,%esp
  char *d;
  
  d = dst;
     166:	8b 45 08             	mov    0x8(%ebp),%eax
     169:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
  while(n-- > 0)
     16c:	eb 0e                	jmp    17c <memset+0x1c>
    *d++ = c;
     16e:	8b 45 0c             	mov    0xc(%ebp),%eax
     171:	89 c2                	mov    %eax,%edx
     173:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     176:	88 10                	mov    %dl,(%eax)
     178:	83 45 fc 01          	addl   $0x1,0xfffffffc(%ebp)
     17c:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
     180:	83 7d 10 ff          	cmpl   $0xffffffff,0x10(%ebp)
     184:	75 e8                	jne    16e <memset+0xe>
  return dst;
     186:	8b 45 08             	mov    0x8(%ebp),%eax
}
     189:	c9                   	leave  
     18a:	c3                   	ret    
     18b:	90                   	nop    
     18c:	8d 74 26 00          	lea    0x0(%esi),%esi

00000190 <strchr>:

char*
strchr(const char *s, char c)
{
     190:	55                   	push   %ebp
     191:	89 e5                	mov    %esp,%ebp
     193:	83 ec 08             	sub    $0x8,%esp
     196:	8b 45 0c             	mov    0xc(%ebp),%eax
     199:	88 45 fc             	mov    %al,0xfffffffc(%ebp)
  for(; *s; s++)
     19c:	eb 17                	jmp    1b5 <strchr+0x25>
    if(*s == c)
     19e:	8b 45 08             	mov    0x8(%ebp),%eax
     1a1:	0f b6 00             	movzbl (%eax),%eax
     1a4:	3a 45 fc             	cmp    0xfffffffc(%ebp),%al
     1a7:	75 08                	jne    1b1 <strchr+0x21>
      return (char*) s;
     1a9:	8b 45 08             	mov    0x8(%ebp),%eax
     1ac:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
     1af:	eb 15                	jmp    1c6 <strchr+0x36>
     1b1:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     1b5:	8b 45 08             	mov    0x8(%ebp),%eax
     1b8:	0f b6 00             	movzbl (%eax),%eax
     1bb:	84 c0                	test   %al,%al
     1bd:	75 df                	jne    19e <strchr+0xe>
  return 0;
     1bf:	c7 45 f8 00 00 00 00 	movl   $0x0,0xfffffff8(%ebp)
     1c6:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
}
     1c9:	c9                   	leave  
     1ca:	c3                   	ret    
     1cb:	90                   	nop    
     1cc:	8d 74 26 00          	lea    0x0(%esi),%esi

000001d0 <gets>:

char*
gets(char *buf, int max)
{
     1d0:	55                   	push   %ebp
     1d1:	89 e5                	mov    %esp,%ebp
     1d3:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     1d6:	c7 45 f8 00 00 00 00 	movl   $0x0,0xfffffff8(%ebp)
     1dd:	eb 46                	jmp    225 <gets+0x55>
    cc = read(0, &c, 1);
     1df:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
     1e6:	00 
     1e7:	8d 45 f7             	lea    0xfffffff7(%ebp),%eax
     1ea:	89 44 24 04          	mov    %eax,0x4(%esp)
     1ee:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     1f5:	e8 52 01 00 00       	call   34c <read>
     1fa:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
    if(cc < 1)
     1fd:	83 7d fc 00          	cmpl   $0x0,0xfffffffc(%ebp)
     201:	7e 2d                	jle    230 <gets+0x60>
      break;
    buf[i++] = c;
     203:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     206:	89 c2                	mov    %eax,%edx
     208:	03 55 08             	add    0x8(%ebp),%edx
     20b:	0f b6 45 f7          	movzbl 0xfffffff7(%ebp),%eax
     20f:	88 02                	mov    %al,(%edx)
     211:	83 45 f8 01          	addl   $0x1,0xfffffff8(%ebp)
    if(c == '\n' || c == '\r')
     215:	0f b6 45 f7          	movzbl 0xfffffff7(%ebp),%eax
     219:	3c 0a                	cmp    $0xa,%al
     21b:	74 13                	je     230 <gets+0x60>
     21d:	0f b6 45 f7          	movzbl 0xfffffff7(%ebp),%eax
     221:	3c 0d                	cmp    $0xd,%al
     223:	74 0b                	je     230 <gets+0x60>
     225:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     228:	83 c0 01             	add    $0x1,%eax
     22b:	3b 45 0c             	cmp    0xc(%ebp),%eax
     22e:	7c af                	jl     1df <gets+0xf>
      break;
  }
  buf[i] = '\0';
     230:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     233:	03 45 08             	add    0x8(%ebp),%eax
     236:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
     239:	8b 45 08             	mov    0x8(%ebp),%eax
}
     23c:	c9                   	leave  
     23d:	c3                   	ret    
     23e:	89 f6                	mov    %esi,%esi

00000240 <stat>:

int
stat(char *n, struct stat *st)
{
     240:	55                   	push   %ebp
     241:	89 e5                	mov    %esp,%ebp
     243:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     246:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     24d:	00 
     24e:	8b 45 08             	mov    0x8(%ebp),%eax
     251:	89 04 24             	mov    %eax,(%esp)
     254:	e8 1b 01 00 00       	call   374 <open>
     259:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
  if(fd < 0)
     25c:	83 7d f8 00          	cmpl   $0x0,0xfffffff8(%ebp)
     260:	79 09                	jns    26b <stat+0x2b>
    return -1;
     262:	c7 45 ec ff ff ff ff 	movl   $0xffffffff,0xffffffec(%ebp)
     269:	eb 26                	jmp    291 <stat+0x51>
  r = fstat(fd, st);
     26b:	8b 45 0c             	mov    0xc(%ebp),%eax
     26e:	89 44 24 04          	mov    %eax,0x4(%esp)
     272:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     275:	89 04 24             	mov    %eax,(%esp)
     278:	e8 0f 01 00 00       	call   38c <fstat>
     27d:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
  close(fd);
     280:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     283:	89 04 24             	mov    %eax,(%esp)
     286:	e8 d1 00 00 00       	call   35c <close>
  return r;
     28b:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     28e:	89 45 ec             	mov    %eax,0xffffffec(%ebp)
     291:	8b 45 ec             	mov    0xffffffec(%ebp),%eax
}
     294:	c9                   	leave  
     295:	c3                   	ret    
     296:	8d 76 00             	lea    0x0(%esi),%esi
     299:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

000002a0 <atoi>:

int
atoi(const char *s)
{
     2a0:	55                   	push   %ebp
     2a1:	89 e5                	mov    %esp,%ebp
     2a3:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
     2a6:	c7 45 fc 00 00 00 00 	movl   $0x0,0xfffffffc(%ebp)
  while('0' <= *s && *s <= '9')
     2ad:	eb 24                	jmp    2d3 <atoi+0x33>
    n = n*10 + *s++ - '0';
     2af:	8b 55 fc             	mov    0xfffffffc(%ebp),%edx
     2b2:	89 d0                	mov    %edx,%eax
     2b4:	c1 e0 02             	shl    $0x2,%eax
     2b7:	01 d0                	add    %edx,%eax
     2b9:	01 c0                	add    %eax,%eax
     2bb:	89 c2                	mov    %eax,%edx
     2bd:	8b 45 08             	mov    0x8(%ebp),%eax
     2c0:	0f b6 00             	movzbl (%eax),%eax
     2c3:	0f be c0             	movsbl %al,%eax
     2c6:	8d 04 02             	lea    (%edx,%eax,1),%eax
     2c9:	83 e8 30             	sub    $0x30,%eax
     2cc:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
     2cf:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     2d3:	8b 45 08             	mov    0x8(%ebp),%eax
     2d6:	0f b6 00             	movzbl (%eax),%eax
     2d9:	3c 2f                	cmp    $0x2f,%al
     2db:	7e 0a                	jle    2e7 <atoi+0x47>
     2dd:	8b 45 08             	mov    0x8(%ebp),%eax
     2e0:	0f b6 00             	movzbl (%eax),%eax
     2e3:	3c 39                	cmp    $0x39,%al
     2e5:	7e c8                	jle    2af <atoi+0xf>
  return n;
     2e7:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
}
     2ea:	c9                   	leave  
     2eb:	c3                   	ret    
     2ec:	8d 74 26 00          	lea    0x0(%esi),%esi

000002f0 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
     2f0:	55                   	push   %ebp
     2f1:	89 e5                	mov    %esp,%ebp
     2f3:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
     2f6:	8b 45 08             	mov    0x8(%ebp),%eax
     2f9:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
  src = vsrc;
     2fc:	8b 45 0c             	mov    0xc(%ebp),%eax
     2ff:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
  while(n-- > 0)
     302:	eb 13                	jmp    317 <memmove+0x27>
    *dst++ = *src++;
     304:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     307:	0f b6 10             	movzbl (%eax),%edx
     30a:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     30d:	88 10                	mov    %dl,(%eax)
     30f:	83 45 f8 01          	addl   $0x1,0xfffffff8(%ebp)
     313:	83 45 fc 01          	addl   $0x1,0xfffffffc(%ebp)
     317:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     31b:	0f 9f c0             	setg   %al
     31e:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
     322:	84 c0                	test   %al,%al
     324:	75 de                	jne    304 <memmove+0x14>
  return vdst;
     326:	8b 45 08             	mov    0x8(%ebp),%eax
}
     329:	c9                   	leave  
     32a:	c3                   	ret    
     32b:	90                   	nop    

0000032c <fork>:
     32c:	b8 01 00 00 00       	mov    $0x1,%eax
     331:	cd 30                	int    $0x30
     333:	c3                   	ret    

00000334 <exit>:
     334:	b8 02 00 00 00       	mov    $0x2,%eax
     339:	cd 30                	int    $0x30
     33b:	c3                   	ret    

0000033c <wait>:
     33c:	b8 03 00 00 00       	mov    $0x3,%eax
     341:	cd 30                	int    $0x30
     343:	c3                   	ret    

00000344 <pipe>:
     344:	b8 04 00 00 00       	mov    $0x4,%eax
     349:	cd 30                	int    $0x30
     34b:	c3                   	ret    

0000034c <read>:
     34c:	b8 06 00 00 00       	mov    $0x6,%eax
     351:	cd 30                	int    $0x30
     353:	c3                   	ret    

00000354 <write>:
     354:	b8 05 00 00 00       	mov    $0x5,%eax
     359:	cd 30                	int    $0x30
     35b:	c3                   	ret    

0000035c <close>:
     35c:	b8 07 00 00 00       	mov    $0x7,%eax
     361:	cd 30                	int    $0x30
     363:	c3                   	ret    

00000364 <kill>:
     364:	b8 08 00 00 00       	mov    $0x8,%eax
     369:	cd 30                	int    $0x30
     36b:	c3                   	ret    

0000036c <exec>:
     36c:	b8 09 00 00 00       	mov    $0x9,%eax
     371:	cd 30                	int    $0x30
     373:	c3                   	ret    

00000374 <open>:
     374:	b8 0a 00 00 00       	mov    $0xa,%eax
     379:	cd 30                	int    $0x30
     37b:	c3                   	ret    

0000037c <mknod>:
     37c:	b8 0b 00 00 00       	mov    $0xb,%eax
     381:	cd 30                	int    $0x30
     383:	c3                   	ret    

00000384 <unlink>:
     384:	b8 0c 00 00 00       	mov    $0xc,%eax
     389:	cd 30                	int    $0x30
     38b:	c3                   	ret    

0000038c <fstat>:
     38c:	b8 0d 00 00 00       	mov    $0xd,%eax
     391:	cd 30                	int    $0x30
     393:	c3                   	ret    

00000394 <link>:
     394:	b8 0e 00 00 00       	mov    $0xe,%eax
     399:	cd 30                	int    $0x30
     39b:	c3                   	ret    

0000039c <mkdir>:
     39c:	b8 0f 00 00 00       	mov    $0xf,%eax
     3a1:	cd 30                	int    $0x30
     3a3:	c3                   	ret    

000003a4 <chdir>:
     3a4:	b8 10 00 00 00       	mov    $0x10,%eax
     3a9:	cd 30                	int    $0x30
     3ab:	c3                   	ret    

000003ac <dup>:
     3ac:	b8 11 00 00 00       	mov    $0x11,%eax
     3b1:	cd 30                	int    $0x30
     3b3:	c3                   	ret    

000003b4 <getpid>:
     3b4:	b8 12 00 00 00       	mov    $0x12,%eax
     3b9:	cd 30                	int    $0x30
     3bb:	c3                   	ret    

000003bc <sbrk>:
     3bc:	b8 13 00 00 00       	mov    $0x13,%eax
     3c1:	cd 30                	int    $0x30
     3c3:	c3                   	ret    

000003c4 <sleep>:
     3c4:	b8 14 00 00 00       	mov    $0x14,%eax
     3c9:	cd 30                	int    $0x30
     3cb:	c3                   	ret    

000003cc <upmsec>:
     3cc:	b8 15 00 00 00       	mov    $0x15,%eax
     3d1:	cd 30                	int    $0x30
     3d3:	c3                   	ret    

000003d4 <socket>:
     3d4:	b8 16 00 00 00       	mov    $0x16,%eax
     3d9:	cd 30                	int    $0x30
     3db:	c3                   	ret    

000003dc <bind>:
     3dc:	b8 17 00 00 00       	mov    $0x17,%eax
     3e1:	cd 30                	int    $0x30
     3e3:	c3                   	ret    

000003e4 <listen>:
     3e4:	b8 18 00 00 00       	mov    $0x18,%eax
     3e9:	cd 30                	int    $0x30
     3eb:	c3                   	ret    

000003ec <accept>:
     3ec:	b8 19 00 00 00       	mov    $0x19,%eax
     3f1:	cd 30                	int    $0x30
     3f3:	c3                   	ret    

000003f4 <recv>:
     3f4:	b8 1a 00 00 00       	mov    $0x1a,%eax
     3f9:	cd 30                	int    $0x30
     3fb:	c3                   	ret    

000003fc <recvfrom>:
     3fc:	b8 1b 00 00 00       	mov    $0x1b,%eax
     401:	cd 30                	int    $0x30
     403:	c3                   	ret    

00000404 <send>:
     404:	b8 1c 00 00 00       	mov    $0x1c,%eax
     409:	cd 30                	int    $0x30
     40b:	c3                   	ret    

0000040c <sendto>:
     40c:	b8 1d 00 00 00       	mov    $0x1d,%eax
     411:	cd 30                	int    $0x30
     413:	c3                   	ret    

00000414 <shutdown>:
     414:	b8 1e 00 00 00       	mov    $0x1e,%eax
     419:	cd 30                	int    $0x30
     41b:	c3                   	ret    

0000041c <getsockopt>:
     41c:	b8 1f 00 00 00       	mov    $0x1f,%eax
     421:	cd 30                	int    $0x30
     423:	c3                   	ret    

00000424 <setsockopt>:
     424:	b8 20 00 00 00       	mov    $0x20,%eax
     429:	cd 30                	int    $0x30
     42b:	c3                   	ret    

0000042c <sockclose>:
     42c:	b8 21 00 00 00       	mov    $0x21,%eax
     431:	cd 30                	int    $0x30
     433:	c3                   	ret    

00000434 <connect>:
     434:	b8 22 00 00 00       	mov    $0x22,%eax
     439:	cd 30                	int    $0x30
     43b:	c3                   	ret    

0000043c <getpeername>:
     43c:	b8 23 00 00 00       	mov    $0x23,%eax
     441:	cd 30                	int    $0x30
     443:	c3                   	ret    

00000444 <getsockname>:
     444:	b8 24 00 00 00       	mov    $0x24,%eax
     449:	cd 30                	int    $0x30
     44b:	c3                   	ret    
     44c:	90                   	nop    
     44d:	90                   	nop    
     44e:	90                   	nop    
     44f:	90                   	nop    

00000450 <putc>:
#include "user.h"

void
putc(int fd, char c)
{
     450:	55                   	push   %ebp
     451:	89 e5                	mov    %esp,%ebp
     453:	83 ec 18             	sub    $0x18,%esp
     456:	8b 45 0c             	mov    0xc(%ebp),%eax
     459:	88 45 fc             	mov    %al,0xfffffffc(%ebp)
  write(fd, &c, 1);
     45c:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
     463:	00 
     464:	8d 45 fc             	lea    0xfffffffc(%ebp),%eax
     467:	89 44 24 04          	mov    %eax,0x4(%esp)
     46b:	8b 45 08             	mov    0x8(%ebp),%eax
     46e:	89 04 24             	mov    %eax,(%esp)
     471:	e8 de fe ff ff       	call   354 <write>
}
     476:	c9                   	leave  
     477:	c3                   	ret    
     478:	90                   	nop    
     479:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi

00000480 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     480:	55                   	push   %ebp
     481:	89 e5                	mov    %esp,%ebp
     483:	53                   	push   %ebx
     484:	83 ec 34             	sub    $0x34,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     487:	c7 45 f4 00 00 00 00 	movl   $0x0,0xfffffff4(%ebp)
  if(sgn && xx < 0){
     48e:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
     492:	74 17                	je     4ab <printint+0x2b>
     494:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     498:	79 11                	jns    4ab <printint+0x2b>
    neg = 1;
     49a:	c7 45 f4 01 00 00 00 	movl   $0x1,0xfffffff4(%ebp)
    x = -xx;
     4a1:	8b 45 0c             	mov    0xc(%ebp),%eax
     4a4:	f7 d8                	neg    %eax
     4a6:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
     4a9:	eb 06                	jmp    4b1 <printint+0x31>
  } else {
    x = xx;
     4ab:	8b 45 0c             	mov    0xc(%ebp),%eax
     4ae:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
  }

  i = 0;
     4b1:	c7 45 f0 00 00 00 00 	movl   $0x0,0xfffffff0(%ebp)
  do{
    buf[i++] = digits[x % base];
     4b8:	8b 4d f0             	mov    0xfffffff0(%ebp),%ecx
     4bb:	8b 55 10             	mov    0x10(%ebp),%edx
     4be:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     4c1:	89 d3                	mov    %edx,%ebx
     4c3:	ba 00 00 00 00       	mov    $0x0,%edx
     4c8:	f7 f3                	div    %ebx
     4ca:	89 d0                	mov    %edx,%eax
     4cc:	0f b6 80 14 11 00 00 	movzbl 0x1114(%eax),%eax
     4d3:	88 44 0d e0          	mov    %al,0xffffffe0(%ebp,%ecx,1)
     4d7:	83 45 f0 01          	addl   $0x1,0xfffffff0(%ebp)
  }while((x /= base) != 0);
     4db:	8b 55 10             	mov    0x10(%ebp),%edx
     4de:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     4e1:	89 d1                	mov    %edx,%ecx
     4e3:	ba 00 00 00 00       	mov    $0x0,%edx
     4e8:	f7 f1                	div    %ecx
     4ea:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
     4ed:	83 7d f8 00          	cmpl   $0x0,0xfffffff8(%ebp)
     4f1:	75 c5                	jne    4b8 <printint+0x38>
  if(neg)
     4f3:	83 7d f4 00          	cmpl   $0x0,0xfffffff4(%ebp)
     4f7:	74 28                	je     521 <printint+0xa1>
    buf[i++] = '-';
     4f9:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
     4fc:	c6 44 05 e0 2d       	movb   $0x2d,0xffffffe0(%ebp,%eax,1)
     501:	83 45 f0 01          	addl   $0x1,0xfffffff0(%ebp)

  while(--i >= 0)
     505:	eb 1a                	jmp    521 <printint+0xa1>
    putc(fd, buf[i]);
     507:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
     50a:	0f b6 44 05 e0       	movzbl 0xffffffe0(%ebp,%eax,1),%eax
     50f:	0f be c0             	movsbl %al,%eax
     512:	89 44 24 04          	mov    %eax,0x4(%esp)
     516:	8b 45 08             	mov    0x8(%ebp),%eax
     519:	89 04 24             	mov    %eax,(%esp)
     51c:	e8 2f ff ff ff       	call   450 <putc>
     521:	83 6d f0 01          	subl   $0x1,0xfffffff0(%ebp)
     525:	83 7d f0 00          	cmpl   $0x0,0xfffffff0(%ebp)
     529:	79 dc                	jns    507 <printint+0x87>
}
     52b:	83 c4 34             	add    $0x34,%esp
     52e:	5b                   	pop    %ebx
     52f:	5d                   	pop    %ebp
     530:	c3                   	ret    
     531:	eb 0d                	jmp    540 <printf>
     533:	90                   	nop    
     534:	90                   	nop    
     535:	90                   	nop    
     536:	90                   	nop    
     537:	90                   	nop    
     538:	90                   	nop    
     539:	90                   	nop    
     53a:	90                   	nop    
     53b:	90                   	nop    
     53c:	90                   	nop    
     53d:	90                   	nop    
     53e:	90                   	nop    
     53f:	90                   	nop    

00000540 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
     540:	55                   	push   %ebp
     541:	89 e5                	mov    %esp,%ebp
     543:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
     546:	c7 45 f8 00 00 00 00 	movl   $0x0,0xfffffff8(%ebp)
  ap = (uint*)(void*)&fmt + 1;
     54d:	8d 45 0c             	lea    0xc(%ebp),%eax
     550:	83 c0 04             	add    $0x4,%eax
     553:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
  for(i = 0; fmt[i]; i++){
     556:	c7 45 f4 00 00 00 00 	movl   $0x0,0xfffffff4(%ebp)
     55d:	e9 7b 01 00 00       	jmp    6dd <printf+0x19d>
    c = fmt[i] & 0xff;
     562:	8b 55 0c             	mov    0xc(%ebp),%edx
     565:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     568:	8d 04 02             	lea    (%edx,%eax,1),%eax
     56b:	0f b6 00             	movzbl (%eax),%eax
     56e:	0f be c0             	movsbl %al,%eax
     571:	25 ff 00 00 00       	and    $0xff,%eax
     576:	89 45 f0             	mov    %eax,0xfffffff0(%ebp)
    if(state == 0){
     579:	83 7d f8 00          	cmpl   $0x0,0xfffffff8(%ebp)
     57d:	75 2c                	jne    5ab <printf+0x6b>
      if(c == '%'){
     57f:	83 7d f0 25          	cmpl   $0x25,0xfffffff0(%ebp)
     583:	75 0c                	jne    591 <printf+0x51>
        state = '%';
     585:	c7 45 f8 25 00 00 00 	movl   $0x25,0xfffffff8(%ebp)
     58c:	e9 48 01 00 00       	jmp    6d9 <printf+0x199>
      } else {
        putc(fd, c);
     591:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
     594:	0f be c0             	movsbl %al,%eax
     597:	89 44 24 04          	mov    %eax,0x4(%esp)
     59b:	8b 45 08             	mov    0x8(%ebp),%eax
     59e:	89 04 24             	mov    %eax,(%esp)
     5a1:	e8 aa fe ff ff       	call   450 <putc>
     5a6:	e9 2e 01 00 00       	jmp    6d9 <printf+0x199>
      }
    } else if(state == '%'){
     5ab:	83 7d f8 25          	cmpl   $0x25,0xfffffff8(%ebp)
     5af:	0f 85 24 01 00 00    	jne    6d9 <printf+0x199>
      if(c == 'd'){
     5b5:	83 7d f0 64          	cmpl   $0x64,0xfffffff0(%ebp)
     5b9:	75 2d                	jne    5e8 <printf+0xa8>
        printint(fd, *ap, 10, 1);
     5bb:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     5be:	8b 00                	mov    (%eax),%eax
     5c0:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
     5c7:	00 
     5c8:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
     5cf:	00 
     5d0:	89 44 24 04          	mov    %eax,0x4(%esp)
     5d4:	8b 45 08             	mov    0x8(%ebp),%eax
     5d7:	89 04 24             	mov    %eax,(%esp)
     5da:	e8 a1 fe ff ff       	call   480 <printint>
        ap++;
     5df:	83 45 fc 04          	addl   $0x4,0xfffffffc(%ebp)
     5e3:	e9 ea 00 00 00       	jmp    6d2 <printf+0x192>
      } else if(c == 'x' || c == 'p'){
     5e8:	83 7d f0 78          	cmpl   $0x78,0xfffffff0(%ebp)
     5ec:	74 06                	je     5f4 <printf+0xb4>
     5ee:	83 7d f0 70          	cmpl   $0x70,0xfffffff0(%ebp)
     5f2:	75 2d                	jne    621 <printf+0xe1>
        printint(fd, *ap, 16, 0);
     5f4:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     5f7:	8b 00                	mov    (%eax),%eax
     5f9:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
     600:	00 
     601:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
     608:	00 
     609:	89 44 24 04          	mov    %eax,0x4(%esp)
     60d:	8b 45 08             	mov    0x8(%ebp),%eax
     610:	89 04 24             	mov    %eax,(%esp)
     613:	e8 68 fe ff ff       	call   480 <printint>
        ap++;
     618:	83 45 fc 04          	addl   $0x4,0xfffffffc(%ebp)
     61c:	e9 b1 00 00 00       	jmp    6d2 <printf+0x192>
      } else if(c == 's'){
     621:	83 7d f0 73          	cmpl   $0x73,0xfffffff0(%ebp)
     625:	75 43                	jne    66a <printf+0x12a>
        s = (char*)*ap;
     627:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     62a:	8b 00                	mov    (%eax),%eax
     62c:	89 45 ec             	mov    %eax,0xffffffec(%ebp)
        ap++;
     62f:	83 45 fc 04          	addl   $0x4,0xfffffffc(%ebp)
        if(s == 0)
     633:	83 7d ec 00          	cmpl   $0x0,0xffffffec(%ebp)
     637:	75 25                	jne    65e <printf+0x11e>
          s = "(null)";
     639:	c7 45 ec f7 10 00 00 	movl   $0x10f7,0xffffffec(%ebp)
        while(*s != 0){
     640:	eb 1c                	jmp    65e <printf+0x11e>
          putc(fd, *s);
     642:	8b 45 ec             	mov    0xffffffec(%ebp),%eax
     645:	0f b6 00             	movzbl (%eax),%eax
     648:	0f be c0             	movsbl %al,%eax
     64b:	89 44 24 04          	mov    %eax,0x4(%esp)
     64f:	8b 45 08             	mov    0x8(%ebp),%eax
     652:	89 04 24             	mov    %eax,(%esp)
     655:	e8 f6 fd ff ff       	call   450 <putc>
          s++;
     65a:	83 45 ec 01          	addl   $0x1,0xffffffec(%ebp)
     65e:	8b 45 ec             	mov    0xffffffec(%ebp),%eax
     661:	0f b6 00             	movzbl (%eax),%eax
     664:	84 c0                	test   %al,%al
     666:	75 da                	jne    642 <printf+0x102>
     668:	eb 68                	jmp    6d2 <printf+0x192>
        }
      } else if(c == 'c'){
     66a:	83 7d f0 63          	cmpl   $0x63,0xfffffff0(%ebp)
     66e:	75 1d                	jne    68d <printf+0x14d>
        putc(fd, *ap);
     670:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     673:	8b 00                	mov    (%eax),%eax
     675:	0f be c0             	movsbl %al,%eax
     678:	89 44 24 04          	mov    %eax,0x4(%esp)
     67c:	8b 45 08             	mov    0x8(%ebp),%eax
     67f:	89 04 24             	mov    %eax,(%esp)
     682:	e8 c9 fd ff ff       	call   450 <putc>
        ap++;
     687:	83 45 fc 04          	addl   $0x4,0xfffffffc(%ebp)
     68b:	eb 45                	jmp    6d2 <printf+0x192>
      } else if(c == '%'){
     68d:	83 7d f0 25          	cmpl   $0x25,0xfffffff0(%ebp)
     691:	75 17                	jne    6aa <printf+0x16a>
        putc(fd, c);
     693:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
     696:	0f be c0             	movsbl %al,%eax
     699:	89 44 24 04          	mov    %eax,0x4(%esp)
     69d:	8b 45 08             	mov    0x8(%ebp),%eax
     6a0:	89 04 24             	mov    %eax,(%esp)
     6a3:	e8 a8 fd ff ff       	call   450 <putc>
     6a8:	eb 28                	jmp    6d2 <printf+0x192>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     6aa:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
     6b1:	00 
     6b2:	8b 45 08             	mov    0x8(%ebp),%eax
     6b5:	89 04 24             	mov    %eax,(%esp)
     6b8:	e8 93 fd ff ff       	call   450 <putc>
        putc(fd, c);
     6bd:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
     6c0:	0f be c0             	movsbl %al,%eax
     6c3:	89 44 24 04          	mov    %eax,0x4(%esp)
     6c7:	8b 45 08             	mov    0x8(%ebp),%eax
     6ca:	89 04 24             	mov    %eax,(%esp)
     6cd:	e8 7e fd ff ff       	call   450 <putc>
      }
      state = 0;
     6d2:	c7 45 f8 00 00 00 00 	movl   $0x0,0xfffffff8(%ebp)
     6d9:	83 45 f4 01          	addl   $0x1,0xfffffff4(%ebp)
     6dd:	8b 55 0c             	mov    0xc(%ebp),%edx
     6e0:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     6e3:	8d 04 02             	lea    (%edx,%eax,1),%eax
     6e6:	0f b6 00             	movzbl (%eax),%eax
     6e9:	84 c0                	test   %al,%al
     6eb:	0f 85 71 fe ff ff    	jne    562 <printf+0x22>
    }
  }
}
     6f1:	c9                   	leave  
     6f2:	c3                   	ret    
     6f3:	90                   	nop    
     6f4:	90                   	nop    
     6f5:	90                   	nop    
     6f6:	90                   	nop    
     6f7:	90                   	nop    
     6f8:	90                   	nop    
     6f9:	90                   	nop    
     6fa:	90                   	nop    
     6fb:	90                   	nop    
     6fc:	90                   	nop    
     6fd:	90                   	nop    
     6fe:	90                   	nop    
     6ff:	90                   	nop    

00000700 <free>:
static Header *freep;

void
free(void *ap)
{
     700:	55                   	push   %ebp
     701:	89 e5                	mov    %esp,%ebp
     703:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*) ap - 1;
     706:	8b 45 08             	mov    0x8(%ebp),%eax
     709:	83 e8 08             	sub    $0x8,%eax
     70c:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     70f:	a1 30 11 00 00       	mov    0x1130,%eax
     714:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
     717:	eb 24                	jmp    73d <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     719:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     71c:	8b 00                	mov    (%eax),%eax
     71e:	3b 45 fc             	cmp    0xfffffffc(%ebp),%eax
     721:	77 12                	ja     735 <free+0x35>
     723:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     726:	3b 45 fc             	cmp    0xfffffffc(%ebp),%eax
     729:	77 24                	ja     74f <free+0x4f>
     72b:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     72e:	8b 00                	mov    (%eax),%eax
     730:	3b 45 f8             	cmp    0xfffffff8(%ebp),%eax
     733:	77 1a                	ja     74f <free+0x4f>
     735:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     738:	8b 00                	mov    (%eax),%eax
     73a:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
     73d:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     740:	3b 45 fc             	cmp    0xfffffffc(%ebp),%eax
     743:	76 d4                	jbe    719 <free+0x19>
     745:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     748:	8b 00                	mov    (%eax),%eax
     74a:	3b 45 f8             	cmp    0xfffffff8(%ebp),%eax
     74d:	76 ca                	jbe    719 <free+0x19>
      break;
  if(bp + bp->s.size == p->s.ptr){
     74f:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     752:	8b 40 04             	mov    0x4(%eax),%eax
     755:	c1 e0 03             	shl    $0x3,%eax
     758:	89 c2                	mov    %eax,%edx
     75a:	03 55 f8             	add    0xfffffff8(%ebp),%edx
     75d:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     760:	8b 00                	mov    (%eax),%eax
     762:	39 c2                	cmp    %eax,%edx
     764:	75 24                	jne    78a <free+0x8a>
    bp->s.size += p->s.ptr->s.size;
     766:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     769:	8b 50 04             	mov    0x4(%eax),%edx
     76c:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     76f:	8b 00                	mov    (%eax),%eax
     771:	8b 40 04             	mov    0x4(%eax),%eax
     774:	01 c2                	add    %eax,%edx
     776:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     779:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
     77c:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     77f:	8b 00                	mov    (%eax),%eax
     781:	8b 10                	mov    (%eax),%edx
     783:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     786:	89 10                	mov    %edx,(%eax)
     788:	eb 0a                	jmp    794 <free+0x94>
  } else
    bp->s.ptr = p->s.ptr;
     78a:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     78d:	8b 10                	mov    (%eax),%edx
     78f:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     792:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
     794:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     797:	8b 40 04             	mov    0x4(%eax),%eax
     79a:	c1 e0 03             	shl    $0x3,%eax
     79d:	03 45 fc             	add    0xfffffffc(%ebp),%eax
     7a0:	3b 45 f8             	cmp    0xfffffff8(%ebp),%eax
     7a3:	75 20                	jne    7c5 <free+0xc5>
    p->s.size += bp->s.size;
     7a5:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     7a8:	8b 50 04             	mov    0x4(%eax),%edx
     7ab:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     7ae:	8b 40 04             	mov    0x4(%eax),%eax
     7b1:	01 c2                	add    %eax,%edx
     7b3:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     7b6:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
     7b9:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     7bc:	8b 10                	mov    (%eax),%edx
     7be:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     7c1:	89 10                	mov    %edx,(%eax)
     7c3:	eb 08                	jmp    7cd <free+0xcd>
  } else
    p->s.ptr = bp;
     7c5:	8b 55 fc             	mov    0xfffffffc(%ebp),%edx
     7c8:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     7cb:	89 02                	mov    %eax,(%edx)
  freep = p;
     7cd:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     7d0:	a3 30 11 00 00       	mov    %eax,0x1130
}
     7d5:	c9                   	leave  
     7d6:	c3                   	ret    
     7d7:	89 f6                	mov    %esi,%esi
     7d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

000007e0 <morecore>:

static Header*
morecore(uint nu)
{
     7e0:	55                   	push   %ebp
     7e1:	89 e5                	mov    %esp,%ebp
     7e3:	83 ec 18             	sub    $0x18,%esp
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
     7e6:	8b 45 08             	mov    0x8(%ebp),%eax
     7e9:	c1 e0 03             	shl    $0x3,%eax
     7ec:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
  size += PAGE - size % PAGE;
     7ef:	8b 55 fc             	mov    0xfffffffc(%ebp),%edx
     7f2:	89 d0                	mov    %edx,%eax
     7f4:	c1 f8 1f             	sar    $0x1f,%eax
     7f7:	89 c1                	mov    %eax,%ecx
     7f9:	c1 e9 14             	shr    $0x14,%ecx
     7fc:	8d 04 0a             	lea    (%edx,%ecx,1),%eax
     7ff:	25 ff 0f 00 00       	and    $0xfff,%eax
     804:	29 c8                	sub    %ecx,%eax
     806:	89 c2                	mov    %eax,%edx
     808:	b8 00 10 00 00       	mov    $0x1000,%eax
     80d:	29 d0                	sub    %edx,%eax
     80f:	01 45 fc             	add    %eax,0xfffffffc(%ebp)
#endif
#ifdef UMALLOC_DEBUG
  printf(1, "size: %d\n", size);
#endif
  p = sbrk(size);
     812:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     815:	89 04 24             	mov    %eax,(%esp)
     818:	e8 9f fb ff ff       	call   3bc <sbrk>
     81d:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
  if(p == (char*) -1)
     820:	83 7d f4 ff          	cmpl   $0xffffffff,0xfffffff4(%ebp)
     824:	75 09                	jne    82f <morecore+0x4f>
    return 0;
     826:	c7 45 ec 00 00 00 00 	movl   $0x0,0xffffffec(%ebp)
     82d:	eb 2a                	jmp    859 <morecore+0x79>
  hp = (Header*)p;
     82f:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     832:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
#ifdef UMALLOC_NOALIGN
  hp->s.size = nu;
#else
  hp->s.size = size / sizeof(Header);
     835:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     838:	89 c2                	mov    %eax,%edx
     83a:	c1 ea 03             	shr    $0x3,%edx
     83d:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     840:	89 50 04             	mov    %edx,0x4(%eax)
#endif
  free((void*)(hp + 1));
     843:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     846:	83 c0 08             	add    $0x8,%eax
     849:	89 04 24             	mov    %eax,(%esp)
     84c:	e8 af fe ff ff       	call   700 <free>
  return freep;
     851:	a1 30 11 00 00       	mov    0x1130,%eax
     856:	89 45 ec             	mov    %eax,0xffffffec(%ebp)
     859:	8b 45 ec             	mov    0xffffffec(%ebp),%eax
}
     85c:	c9                   	leave  
     85d:	c3                   	ret    
     85e:	89 f6                	mov    %esi,%esi

00000860 <malloc>:

void*
malloc(uint nbytes)
{
     860:	55                   	push   %ebp
     861:	89 e5                	mov    %esp,%ebp
     863:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

#ifdef UMALLOC_DEBUG
  printf(1, "malloc: %d bytes\n", nbytes);
  printf(1, "size of Header: %d\n", sizeof(Header));
#endif
  if (PAGE % sizeof(Header))
      printf(2, "Warning! align failed! Need UMALLOC_NOALIGN\n");
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     866:	8b 45 08             	mov    0x8(%ebp),%eax
     869:	83 c0 07             	add    $0x7,%eax
     86c:	c1 e8 03             	shr    $0x3,%eax
     86f:	83 c0 01             	add    $0x1,%eax
     872:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
  if((prevp = freep) == 0){
     875:	a1 30 11 00 00       	mov    0x1130,%eax
     87a:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
     87d:	83 7d f8 00          	cmpl   $0x0,0xfffffff8(%ebp)
     881:	75 23                	jne    8a6 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
     883:	c7 45 f8 28 11 00 00 	movl   $0x1128,0xfffffff8(%ebp)
     88a:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     88d:	a3 30 11 00 00       	mov    %eax,0x1130
     892:	a1 30 11 00 00       	mov    0x1130,%eax
     897:	a3 28 11 00 00       	mov    %eax,0x1128
    base.s.size = 0;
     89c:	c7 05 2c 11 00 00 00 	movl   $0x0,0x112c
     8a3:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     8a6:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     8a9:	8b 00                	mov    (%eax),%eax
     8ab:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
    if(p->s.size >= nunits){
     8ae:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     8b1:	8b 40 04             	mov    0x4(%eax),%eax
     8b4:	3b 45 fc             	cmp    0xfffffffc(%ebp),%eax
     8b7:	72 50                	jb     909 <malloc+0xa9>
      if(p->s.size == nunits)
     8b9:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     8bc:	8b 40 04             	mov    0x4(%eax),%eax
     8bf:	3b 45 fc             	cmp    0xfffffffc(%ebp),%eax
     8c2:	75 0c                	jne    8d0 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
     8c4:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     8c7:	8b 10                	mov    (%eax),%edx
     8c9:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     8cc:	89 10                	mov    %edx,(%eax)
     8ce:	eb 26                	jmp    8f6 <malloc+0x96>
      else {
        p->s.size -= nunits;
     8d0:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     8d3:	8b 40 04             	mov    0x4(%eax),%eax
     8d6:	89 c2                	mov    %eax,%edx
     8d8:	2b 55 fc             	sub    0xfffffffc(%ebp),%edx
     8db:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     8de:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
     8e1:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     8e4:	8b 40 04             	mov    0x4(%eax),%eax
     8e7:	c1 e0 03             	shl    $0x3,%eax
     8ea:	01 45 f4             	add    %eax,0xfffffff4(%ebp)
        p->s.size = nunits;
     8ed:	8b 55 f4             	mov    0xfffffff4(%ebp),%edx
     8f0:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     8f3:	89 42 04             	mov    %eax,0x4(%edx)
      }
      freep = prevp;
     8f6:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     8f9:	a3 30 11 00 00       	mov    %eax,0x1130
      return (void*) (p + 1);
     8fe:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     901:	83 c0 08             	add    $0x8,%eax
     904:	89 45 ec             	mov    %eax,0xffffffec(%ebp)
     907:	eb 3a                	jmp    943 <malloc+0xe3>
    }
    if(p == freep)
     909:	a1 30 11 00 00       	mov    0x1130,%eax
     90e:	39 45 f4             	cmp    %eax,0xfffffff4(%ebp)
     911:	75 1d                	jne    930 <malloc+0xd0>
      if((p = morecore(nunits)) == 0)
     913:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     916:	89 04 24             	mov    %eax,(%esp)
     919:	e8 c2 fe ff ff       	call   7e0 <morecore>
     91e:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
     921:	83 7d f4 00          	cmpl   $0x0,0xfffffff4(%ebp)
     925:	75 09                	jne    930 <malloc+0xd0>
        return 0;
     927:	c7 45 ec 00 00 00 00 	movl   $0x0,0xffffffec(%ebp)
     92e:	eb 13                	jmp    943 <malloc+0xe3>
     930:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     933:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
     936:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     939:	8b 00                	mov    (%eax),%eax
     93b:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
  }
     93e:	e9 6b ff ff ff       	jmp    8ae <malloc+0x4e>
     943:	8b 45 ec             	mov    0xffffffec(%ebp),%eax
}
     946:	c9                   	leave  
     947:	c3                   	ret    
     948:	90                   	nop    
     949:	90                   	nop    
     94a:	90                   	nop    
     94b:	90                   	nop    
     94c:	90                   	nop    
     94d:	90                   	nop    
     94e:	90                   	nop    
     94f:	90                   	nop    

00000950 <lwip_chksum>:


static u16_t
lwip_chksum(void *dataptr, int len)
{
     950:	55                   	push   %ebp
     951:	89 e5                	mov    %esp,%ebp
     953:	83 ec 18             	sub    $0x18,%esp
  u32_t acc;

  LWIP_DEBUGF(INET_DEBUG, ("lwip_chksum(%p, %d)\n", (void *)dataptr, len));
  for(acc = 0; len > 1; len -= 2) {
     956:	c7 45 fc 00 00 00 00 	movl   $0x0,0xfffffffc(%ebp)
     95d:	eb 19                	jmp    978 <lwip_chksum+0x28>
      /*    acc = acc + *((u16_t *)dataptr)++;*/
    acc += *(u16_t *)dataptr;
     95f:	8b 45 08             	mov    0x8(%ebp),%eax
     962:	0f b7 00             	movzwl (%eax),%eax
     965:	0f b7 c0             	movzwl %ax,%eax
     968:	01 45 fc             	add    %eax,0xfffffffc(%ebp)
    dataptr = (void *)((u16_t *)dataptr + 1);
     96b:	8b 45 08             	mov    0x8(%ebp),%eax
     96e:	83 c0 02             	add    $0x2,%eax
     971:	89 45 08             	mov    %eax,0x8(%ebp)
     974:	83 6d 0c 02          	subl   $0x2,0xc(%ebp)
     978:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
     97c:	7f e1                	jg     95f <lwip_chksum+0xf>
  }

  /* add up any odd byte */
  if (len == 1) {
     97e:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
     982:	75 1d                	jne    9a1 <lwip_chksum+0x51>
    acc += htons((u16_t)((*(u8_t *)dataptr) & 0xff) << 8);
     984:	8b 45 08             	mov    0x8(%ebp),%eax
     987:	0f b6 00             	movzbl (%eax),%eax
     98a:	0f b6 c0             	movzbl %al,%eax
     98d:	c1 e0 08             	shl    $0x8,%eax
     990:	0f b7 c0             	movzwl %ax,%eax
     993:	89 04 24             	mov    %eax,(%esp)
     996:	e8 85 06 00 00       	call   1020 <htons>
     99b:	0f b7 c0             	movzwl %ax,%eax
     99e:	01 45 fc             	add    %eax,0xfffffffc(%ebp)
    LWIP_DEBUGF(INET_DEBUG, ("inet: chksum: odd byte %d\n", (unsigned int)(*(u8_t *)dataptr)));
  } else {
    LWIP_DEBUGF(INET_DEBUG, ("inet: chksum: no odd byte\n"));
  }
  acc = (acc >> 16) + (acc & 0xffffUL);
     9a1:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     9a4:	89 c2                	mov    %eax,%edx
     9a6:	c1 ea 10             	shr    $0x10,%edx
     9a9:	0f b7 45 fc          	movzwl 0xfffffffc(%ebp),%eax
     9ad:	8d 04 02             	lea    (%edx,%eax,1),%eax
     9b0:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)

  if ((acc & 0xffff0000) != 0) {
     9b3:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     9b6:	66 b8 00 00          	mov    $0x0,%ax
     9ba:	85 c0                	test   %eax,%eax
     9bc:	74 12                	je     9d0 <lwip_chksum+0x80>
    acc = (acc >> 16) + (acc & 0xffffUL);
     9be:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     9c1:	89 c2                	mov    %eax,%edx
     9c3:	c1 ea 10             	shr    $0x10,%edx
     9c6:	0f b7 45 fc          	movzwl 0xfffffffc(%ebp),%eax
     9ca:	8d 04 02             	lea    (%edx,%eax,1),%eax
     9cd:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
  }

  return (u16_t)acc;
     9d0:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     9d3:	0f b7 c0             	movzwl %ax,%eax
}
     9d6:	c9                   	leave  
     9d7:	c3                   	ret    
     9d8:	90                   	nop    
     9d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi

000009e0 <inet_chksum_pseudo>:

/* inet_chksum_pseudo:
 *
 * Calculates the pseudo Internet checksum used by TCP and UDP for a pbuf chain.
 */

u16_t
inet_chksum_pseudo(struct pbuf *p,
       struct ip_addr *src, struct ip_addr *dest,
       u8_t proto, u16_t proto_len)
{
     9e0:	55                   	push   %ebp
     9e1:	89 e5                	mov    %esp,%ebp
     9e3:	83 ec 28             	sub    $0x28,%esp
     9e6:	8b 45 14             	mov    0x14(%ebp),%eax
     9e9:	8b 55 18             	mov    0x18(%ebp),%edx
     9ec:	88 45 ec             	mov    %al,0xffffffec(%ebp)
     9ef:	66 89 55 e8          	mov    %dx,0xffffffe8(%ebp)
  u32_t acc;
  struct pbuf *q;
  u8_t swapped;

  acc = 0;
     9f3:	c7 45 f4 00 00 00 00 	movl   $0x0,0xfffffff4(%ebp)
  swapped = 0;
     9fa:	c6 45 ff 00          	movb   $0x0,0xffffffff(%ebp)
  /* iterate through all pbuf in chain */
  for(q = p; q != NULL; q = q->next) {
     9fe:	8b 45 08             	mov    0x8(%ebp),%eax
     a01:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
     a04:	eb 7b                	jmp    a81 <inet_chksum_pseudo+0xa1>
    LWIP_DEBUGF(INET_DEBUG, ("inet_chksum_pseudo(): checksumming pbuf %p (has next %p) \n",
      (void *)q, (void *)q->next));
    acc += lwip_chksum(q->payload, q->len);
     a06:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     a09:	0f b7 40 0a          	movzwl 0xa(%eax),%eax
     a0d:	0f b7 d0             	movzwl %ax,%edx
     a10:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     a13:	8b 40 04             	mov    0x4(%eax),%eax
     a16:	89 54 24 04          	mov    %edx,0x4(%esp)
     a1a:	89 04 24             	mov    %eax,(%esp)
     a1d:	e8 2e ff ff ff       	call   950 <lwip_chksum>
     a22:	0f b7 c0             	movzwl %ax,%eax
     a25:	01 45 f4             	add    %eax,0xfffffff4(%ebp)
    /*LWIP_DEBUGF(INET_DEBUG, ("inet_chksum_pseudo(): unwrapped lwip_chksum()=%lx \n", acc));*/
    while (acc >> 16) {
     a28:	eb 10                	jmp    a3a <inet_chksum_pseudo+0x5a>
      acc = (acc & 0xffffUL) + (acc >> 16);
     a2a:	0f b7 55 f4          	movzwl 0xfffffff4(%ebp),%edx
     a2e:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     a31:	c1 e8 10             	shr    $0x10,%eax
     a34:	8d 04 02             	lea    (%edx,%eax,1),%eax
     a37:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
     a3a:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     a3d:	c1 e8 10             	shr    $0x10,%eax
     a40:	85 c0                	test   %eax,%eax
     a42:	75 e6                	jne    a2a <inet_chksum_pseudo+0x4a>
    }
    if (q->len % 2 != 0) {
     a44:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     a47:	0f b7 40 0a          	movzwl 0xa(%eax),%eax
     a4b:	0f b7 c0             	movzwl %ax,%eax
     a4e:	83 e0 01             	and    $0x1,%eax
     a51:	84 c0                	test   %al,%al
     a53:	74 24                	je     a79 <inet_chksum_pseudo+0x99>
      swapped = 1 - swapped;
     a55:	b8 01 00 00 00       	mov    $0x1,%eax
     a5a:	2a 45 ff             	sub    0xffffffff(%ebp),%al
     a5d:	88 45 ff             	mov    %al,0xffffffff(%ebp)
      acc = ((acc & 0xff) << 8) | ((acc & 0xff00UL) >> 8);
     a60:	0f b6 45 f4          	movzbl 0xfffffff4(%ebp),%eax
     a64:	89 c2                	mov    %eax,%edx
     a66:	c1 e2 08             	shl    $0x8,%edx
     a69:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     a6c:	25 00 ff 00 00       	and    $0xff00,%eax
     a71:	c1 e8 08             	shr    $0x8,%eax
     a74:	09 d0                	or     %edx,%eax
     a76:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
     a79:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     a7c:	8b 00                	mov    (%eax),%eax
     a7e:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
     a81:	83 7d f8 00          	cmpl   $0x0,0xfffffff8(%ebp)
     a85:	0f 85 7b ff ff ff    	jne    a06 <inet_chksum_pseudo+0x26>
    }
    /*LWIP_DEBUGF(INET_DEBUG, ("inet_chksum_pseudo(): wrapped lwip_chksum()=%lx \n", acc));*/
  }

  if (swapped) {
     a8b:	80 7d ff 00          	cmpb   $0x0,0xffffffff(%ebp)
     a8f:	74 19                	je     aaa <inet_chksum_pseudo+0xca>
    acc = ((acc & 0xff) << 8) | ((acc & 0xff00UL) >> 8);
     a91:	0f b6 45 f4          	movzbl 0xfffffff4(%ebp),%eax
     a95:	89 c2                	mov    %eax,%edx
     a97:	c1 e2 08             	shl    $0x8,%edx
     a9a:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     a9d:	25 00 ff 00 00       	and    $0xff00,%eax
     aa2:	c1 e8 08             	shr    $0x8,%eax
     aa5:	09 d0                	or     %edx,%eax
     aa7:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
  }
  acc += (src->addr & 0xffffUL);
     aaa:	8b 45 0c             	mov    0xc(%ebp),%eax
     aad:	8b 00                	mov    (%eax),%eax
     aaf:	25 ff ff 00 00       	and    $0xffff,%eax
     ab4:	01 45 f4             	add    %eax,0xfffffff4(%ebp)
  acc += ((src->addr >> 16) & 0xffffUL);
     ab7:	8b 45 0c             	mov    0xc(%ebp),%eax
     aba:	8b 00                	mov    (%eax),%eax
     abc:	c1 e8 10             	shr    $0x10,%eax
     abf:	25 ff ff 00 00       	and    $0xffff,%eax
     ac4:	01 45 f4             	add    %eax,0xfffffff4(%ebp)
  acc += (dest->addr & 0xffffUL);
     ac7:	8b 45 10             	mov    0x10(%ebp),%eax
     aca:	8b 00                	mov    (%eax),%eax
     acc:	25 ff ff 00 00       	and    $0xffff,%eax
     ad1:	01 45 f4             	add    %eax,0xfffffff4(%ebp)
  acc += ((dest->addr >> 16) & 0xffffUL);
     ad4:	8b 45 10             	mov    0x10(%ebp),%eax
     ad7:	8b 00                	mov    (%eax),%eax
     ad9:	c1 e8 10             	shr    $0x10,%eax
     adc:	25 ff ff 00 00       	and    $0xffff,%eax
     ae1:	01 45 f4             	add    %eax,0xfffffff4(%ebp)
  acc += (u32_t)htons((u16_t)proto);
     ae4:	0f b6 45 ec          	movzbl 0xffffffec(%ebp),%eax
     ae8:	89 04 24             	mov    %eax,(%esp)
     aeb:	e8 30 05 00 00       	call   1020 <htons>
     af0:	0f b7 c0             	movzwl %ax,%eax
     af3:	01 45 f4             	add    %eax,0xfffffff4(%ebp)
  acc += (u32_t)htons(proto_len);
     af6:	0f b7 45 e8          	movzwl 0xffffffe8(%ebp),%eax
     afa:	89 04 24             	mov    %eax,(%esp)
     afd:	e8 1e 05 00 00       	call   1020 <htons>
     b02:	0f b7 c0             	movzwl %ax,%eax
     b05:	01 45 f4             	add    %eax,0xfffffff4(%ebp)

  while (acc >> 16) {
     b08:	eb 10                	jmp    b1a <inet_chksum_pseudo+0x13a>
    acc = (acc & 0xffffUL) + (acc >> 16);
     b0a:	0f b7 55 f4          	movzwl 0xfffffff4(%ebp),%edx
     b0e:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     b11:	c1 e8 10             	shr    $0x10,%eax
     b14:	8d 04 02             	lea    (%edx,%eax,1),%eax
     b17:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
     b1a:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     b1d:	c1 e8 10             	shr    $0x10,%eax
     b20:	85 c0                	test   %eax,%eax
     b22:	75 e6                	jne    b0a <inet_chksum_pseudo+0x12a>
  }
  LWIP_DEBUGF(INET_DEBUG, ("inet_chksum_pseudo(): pbuf chain lwip_chksum()=%lx\n", acc));
  return ~(acc & 0xffffUL);
     b24:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     b27:	f7 d0                	not    %eax
     b29:	0f b7 c0             	movzwl %ax,%eax
}
     b2c:	c9                   	leave  
     b2d:	c3                   	ret    
     b2e:	89 f6                	mov    %esi,%esi

00000b30 <inet_chksum>:

/* inet_chksum:
 *
 * Calculates the Internet checksum over a portion of memory. Used primarely for IP
 * and ICMP.
 */

u16_t
inet_chksum(void *dataptr, u16_t len)
{
     b30:	55                   	push   %ebp
     b31:	89 e5                	mov    %esp,%ebp
     b33:	83 ec 28             	sub    $0x28,%esp
     b36:	8b 45 0c             	mov    0xc(%ebp),%eax
     b39:	66 89 45 ec          	mov    %ax,0xffffffec(%ebp)
  u32_t acc;

  acc = lwip_chksum(dataptr, len);
     b3d:	0f b7 45 ec          	movzwl 0xffffffec(%ebp),%eax
     b41:	89 44 24 04          	mov    %eax,0x4(%esp)
     b45:	8b 45 08             	mov    0x8(%ebp),%eax
     b48:	89 04 24             	mov    %eax,(%esp)
     b4b:	e8 00 fe ff ff       	call   950 <lwip_chksum>
     b50:	0f b7 c0             	movzwl %ax,%eax
     b53:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
  while (acc >> 16) {
     b56:	eb 10                	jmp    b68 <inet_chksum+0x38>
    acc = (acc & 0xffff) + (acc >> 16);
     b58:	0f b7 55 fc          	movzwl 0xfffffffc(%ebp),%edx
     b5c:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     b5f:	c1 e8 10             	shr    $0x10,%eax
     b62:	8d 04 02             	lea    (%edx,%eax,1),%eax
     b65:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
     b68:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     b6b:	c1 e8 10             	shr    $0x10,%eax
     b6e:	85 c0                	test   %eax,%eax
     b70:	75 e6                	jne    b58 <inet_chksum+0x28>
  }
  return ~(acc & 0xffff);
     b72:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     b75:	f7 d0                	not    %eax
     b77:	0f b7 c0             	movzwl %ax,%eax
}
     b7a:	c9                   	leave  
     b7b:	c3                   	ret    
     b7c:	8d 74 26 00          	lea    0x0(%esi),%esi

00000b80 <inet_chksum_pbuf>:

u16_t
inet_chksum_pbuf(struct pbuf *p)
{
     b80:	55                   	push   %ebp
     b81:	89 e5                	mov    %esp,%ebp
     b83:	83 ec 18             	sub    $0x18,%esp
  u32_t acc;
  struct pbuf *q;
  u8_t swapped;

  acc = 0;
     b86:	c7 45 f4 00 00 00 00 	movl   $0x0,0xfffffff4(%ebp)
  swapped = 0;
     b8d:	c6 45 ff 00          	movb   $0x0,0xffffffff(%ebp)
  for(q = p; q != NULL; q = q->next) {
     b91:	8b 45 08             	mov    0x8(%ebp),%eax
     b94:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
     b97:	eb 69                	jmp    c02 <inet_chksum_pbuf+0x82>
    acc += lwip_chksum(q->payload, q->len);
     b99:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     b9c:	0f b7 40 0a          	movzwl 0xa(%eax),%eax
     ba0:	0f b7 d0             	movzwl %ax,%edx
     ba3:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     ba6:	8b 40 04             	mov    0x4(%eax),%eax
     ba9:	89 54 24 04          	mov    %edx,0x4(%esp)
     bad:	89 04 24             	mov    %eax,(%esp)
     bb0:	e8 9b fd ff ff       	call   950 <lwip_chksum>
     bb5:	0f b7 c0             	movzwl %ax,%eax
     bb8:	01 45 f4             	add    %eax,0xfffffff4(%ebp)
    while (acc >> 16) {
     bbb:	eb 10                	jmp    bcd <inet_chksum_pbuf+0x4d>
      acc = (acc & 0xffffUL) + (acc >> 16);
     bbd:	0f b7 55 f4          	movzwl 0xfffffff4(%ebp),%edx
     bc1:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     bc4:	c1 e8 10             	shr    $0x10,%eax
     bc7:	8d 04 02             	lea    (%edx,%eax,1),%eax
     bca:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
     bcd:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     bd0:	c1 e8 10             	shr    $0x10,%eax
     bd3:	85 c0                	test   %eax,%eax
     bd5:	75 e6                	jne    bbd <inet_chksum_pbuf+0x3d>
    }
    if (q->len % 2 != 0) {
     bd7:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     bda:	0f b7 40 0a          	movzwl 0xa(%eax),%eax
     bde:	0f b7 c0             	movzwl %ax,%eax
     be1:	83 e0 01             	and    $0x1,%eax
     be4:	84 c0                	test   %al,%al
     be6:	74 12                	je     bfa <inet_chksum_pbuf+0x7a>
      swapped = 1 - swapped;
     be8:	b8 01 00 00 00       	mov    $0x1,%eax
     bed:	2a 45 ff             	sub    0xffffffff(%ebp),%al
     bf0:	88 45 ff             	mov    %al,0xffffffff(%ebp)
      acc = (acc & 0x00ffUL << 8) | (acc & 0xff00UL >> 8);
     bf3:	81 65 f4 ff ff 00 00 	andl   $0xffff,0xfffffff4(%ebp)
     bfa:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     bfd:	8b 00                	mov    (%eax),%eax
     bff:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
     c02:	83 7d f8 00          	cmpl   $0x0,0xfffffff8(%ebp)
     c06:	75 91                	jne    b99 <inet_chksum_pbuf+0x19>
    }
  }

  if (swapped) {
     c08:	80 7d ff 00          	cmpb   $0x0,0xffffffff(%ebp)
     c0c:	74 19                	je     c27 <inet_chksum_pbuf+0xa7>
    acc = ((acc & 0x00ffUL) << 8) | ((acc & 0xff00UL) >> 8);
     c0e:	0f b6 45 f4          	movzbl 0xfffffff4(%ebp),%eax
     c12:	89 c2                	mov    %eax,%edx
     c14:	c1 e2 08             	shl    $0x8,%edx
     c17:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     c1a:	25 00 ff 00 00       	and    $0xff00,%eax
     c1f:	c1 e8 08             	shr    $0x8,%eax
     c22:	09 d0                	or     %edx,%eax
     c24:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
  }
  return ~(acc & 0xffffUL);
     c27:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     c2a:	f7 d0                	not    %eax
     c2c:	0f b7 c0             	movzwl %ax,%eax
}
     c2f:	c9                   	leave  
     c30:	c3                   	ret    
     c31:	eb 0d                	jmp    c40 <inet_addr>
     c33:	90                   	nop    
     c34:	90                   	nop    
     c35:	90                   	nop    
     c36:	90                   	nop    
     c37:	90                   	nop    
     c38:	90                   	nop    
     c39:	90                   	nop    
     c3a:	90                   	nop    
     c3b:	90                   	nop    
     c3c:	90                   	nop    
     c3d:	90                   	nop    
     c3e:	90                   	nop    
     c3f:	90                   	nop    

00000c40 <inet_addr>:

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
     c40:	55                   	push   %ebp
     c41:	89 e5                	mov    %esp,%ebp
     c43:	83 ec 28             	sub    $0x28,%esp
     struct in_addr val;

     if (inet_aton(cp, &val)) {
     c46:	8d 45 fc             	lea    0xfffffffc(%ebp),%eax
     c49:	89 44 24 04          	mov    %eax,0x4(%esp)
     c4d:	8b 45 08             	mov    0x8(%ebp),%eax
     c50:	89 04 24             	mov    %eax,(%esp)
     c53:	e8 18 00 00 00       	call   c70 <inet_aton>
     c58:	85 c0                	test   %eax,%eax
     c5a:	74 08                	je     c64 <inet_addr+0x24>
         return (val.s_addr);
     c5c:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     c5f:	89 45 ec             	mov    %eax,0xffffffec(%ebp)
     c62:	eb 07                	jmp    c6b <inet_addr+0x2b>
     }
     return (INADDR_NONE);
     c64:	c7 45 ec ff ff ff ff 	movl   $0xffffffff,0xffffffec(%ebp)
     c6b:	8b 45 ec             	mov    0xffffffec(%ebp),%eax
 }
     c6e:	c9                   	leave  
     c6f:	c3                   	ret    

00000c70 <inet_aton>:

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
     c70:	55                   	push   %ebp
     c71:	89 e5                	mov    %esp,%ebp
     c73:	83 ec 48             	sub    $0x48,%esp
     u32_t val;
     int base, n;
     char c;
     u32_t parts[4];
     u32_t* pp = parts;
     c76:	8d 45 dc             	lea    0xffffffdc(%ebp),%eax
     c79:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)

     c = *cp;
     c7c:	8b 45 08             	mov    0x8(%ebp),%eax
     c7f:	0f b6 00             	movzbl (%eax),%eax
     c82:	88 45 fb             	mov    %al,0xfffffffb(%ebp)
     for (;;) {
         /*
          * Collect number up to ``.''.
          * Values are specified as for C:
          * 0x=hex, 0=octal, isdigit=decimal.
          */
         if (!isdigit(c))
     c85:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
     c89:	3c 2f                	cmp    $0x2f,%al
     c8b:	76 08                	jbe    c95 <inet_aton+0x25>
     c8d:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
     c91:	3c 39                	cmp    $0x39,%al
     c93:	76 0c                	jbe    ca1 <inet_aton+0x31>
             return (0);
     c95:	c7 45 c0 00 00 00 00 	movl   $0x0,0xffffffc0(%ebp)
     c9c:	e9 78 02 00 00       	jmp    f19 <inet_aton+0x2a9>
         val = 0; base = 10;
     ca1:	c7 45 ec 00 00 00 00 	movl   $0x0,0xffffffec(%ebp)
     ca8:	c7 45 f0 0a 00 00 00 	movl   $0xa,0xfffffff0(%ebp)
         if (c == '0') {
     caf:	80 7d fb 30          	cmpb   $0x30,0xfffffffb(%ebp)
     cb3:	75 36                	jne    ceb <inet_aton+0x7b>
             c = *++cp;
     cb5:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     cb9:	8b 45 08             	mov    0x8(%ebp),%eax
     cbc:	0f b6 00             	movzbl (%eax),%eax
     cbf:	88 45 fb             	mov    %al,0xfffffffb(%ebp)
             if (c == 'x' || c == 'X')
     cc2:	80 7d fb 78          	cmpb   $0x78,0xfffffffb(%ebp)
     cc6:	74 06                	je     cce <inet_aton+0x5e>
     cc8:	80 7d fb 58          	cmpb   $0x58,0xfffffffb(%ebp)
     ccc:	75 16                	jne    ce4 <inet_aton+0x74>
                 base = 16, c = *++cp;
     cce:	c7 45 f0 10 00 00 00 	movl   $0x10,0xfffffff0(%ebp)
     cd5:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     cd9:	8b 45 08             	mov    0x8(%ebp),%eax
     cdc:	0f b6 00             	movzbl (%eax),%eax
     cdf:	88 45 fb             	mov    %al,0xfffffffb(%ebp)
     ce2:	eb 07                	jmp    ceb <inet_aton+0x7b>
             else
                 base = 8;
     ce4:	c7 45 f0 08 00 00 00 	movl   $0x8,0xfffffff0(%ebp)
         }
         for (;;) {
             if (isascii(c) && isdigit(c)) {
     ceb:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
     cef:	3c 1f                	cmp    $0x1f,%al
     cf1:	76 3b                	jbe    d2e <inet_aton+0xbe>
     cf3:	80 7d fb 00          	cmpb   $0x0,0xfffffffb(%ebp)
     cf7:	78 35                	js     d2e <inet_aton+0xbe>
     cf9:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
     cfd:	3c 2f                	cmp    $0x2f,%al
     cff:	76 2d                	jbe    d2e <inet_aton+0xbe>
     d01:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
     d05:	3c 39                	cmp    $0x39,%al
     d07:	77 25                	ja     d2e <inet_aton+0xbe>
                 val = (val * base) + (c - '0');
     d09:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
     d0c:	89 c2                	mov    %eax,%edx
     d0e:	0f af 55 ec          	imul   0xffffffec(%ebp),%edx
     d12:	0f be 45 fb          	movsbl 0xfffffffb(%ebp),%eax
     d16:	8d 04 02             	lea    (%edx,%eax,1),%eax
     d19:	83 e8 30             	sub    $0x30,%eax
     d1c:	89 45 ec             	mov    %eax,0xffffffec(%ebp)
                 c = *++cp;
     d1f:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     d23:	8b 45 08             	mov    0x8(%ebp),%eax
     d26:	0f b6 00             	movzbl (%eax),%eax
     d29:	88 45 fb             	mov    %al,0xfffffffb(%ebp)
     d2c:	eb bd                	jmp    ceb <inet_aton+0x7b>
             } else if (base == 16 && isascii(c) && isxdigit(c)) {
     d2e:	83 7d f0 10          	cmpl   $0x10,0xfffffff0(%ebp)
     d32:	0f 85 99 00 00 00    	jne    dd1 <inet_aton+0x161>
     d38:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
     d3c:	3c 1f                	cmp    $0x1f,%al
     d3e:	0f 86 8d 00 00 00    	jbe    dd1 <inet_aton+0x161>
     d44:	80 7d fb 00          	cmpb   $0x0,0xfffffffb(%ebp)
     d48:	0f 88 83 00 00 00    	js     dd1 <inet_aton+0x161>
     d4e:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
     d52:	3c 2f                	cmp    $0x2f,%al
     d54:	76 08                	jbe    d5e <inet_aton+0xee>
     d56:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
     d5a:	3c 39                	cmp    $0x39,%al
     d5c:	76 20                	jbe    d7e <inet_aton+0x10e>
     d5e:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
     d62:	3c 60                	cmp    $0x60,%al
     d64:	76 08                	jbe    d6e <inet_aton+0xfe>
     d66:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
     d6a:	3c 66                	cmp    $0x66,%al
     d6c:	76 10                	jbe    d7e <inet_aton+0x10e>
     d6e:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
     d72:	3c 40                	cmp    $0x40,%al
     d74:	76 5b                	jbe    dd1 <inet_aton+0x161>
     d76:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
     d7a:	3c 46                	cmp    $0x46,%al
     d7c:	77 53                	ja     dd1 <inet_aton+0x161>
                 val = (val << 4) |
     d7e:	8b 45 ec             	mov    0xffffffec(%ebp),%eax
     d81:	89 c2                	mov    %eax,%edx
     d83:	c1 e2 04             	shl    $0x4,%edx
     d86:	89 55 c4             	mov    %edx,0xffffffc4(%ebp)
     d89:	0f be 45 fb          	movsbl 0xfffffffb(%ebp),%eax
     d8d:	83 c0 0a             	add    $0xa,%eax
     d90:	89 45 c8             	mov    %eax,0xffffffc8(%ebp)
     d93:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
     d97:	3c 60                	cmp    $0x60,%al
     d99:	76 11                	jbe    dac <inet_aton+0x13c>
     d9b:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
     d9f:	3c 7a                	cmp    $0x7a,%al
     da1:	77 09                	ja     dac <inet_aton+0x13c>
     da3:	c7 45 cc 61 00 00 00 	movl   $0x61,0xffffffcc(%ebp)
     daa:	eb 07                	jmp    db3 <inet_aton+0x143>
     dac:	c7 45 cc 41 00 00 00 	movl   $0x41,0xffffffcc(%ebp)
     db3:	8b 45 c8             	mov    0xffffffc8(%ebp),%eax
     db6:	2b 45 cc             	sub    0xffffffcc(%ebp),%eax
     db9:	0b 45 c4             	or     0xffffffc4(%ebp),%eax
     dbc:	89 45 ec             	mov    %eax,0xffffffec(%ebp)
                     (c + 10 - (islower(c) ? 'a' : 'A'));
                 c = *++cp;
     dbf:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     dc3:	8b 45 08             	mov    0x8(%ebp),%eax
     dc6:	0f b6 00             	movzbl (%eax),%eax
     dc9:	88 45 fb             	mov    %al,0xfffffffb(%ebp)
             } else
             break;
         }
     dcc:	e9 1a ff ff ff       	jmp    ceb <inet_aton+0x7b>
         if (c == '.') {
     dd1:	80 7d fb 2e          	cmpb   $0x2e,0xfffffffb(%ebp)
     dd5:	75 35                	jne    e0c <inet_aton+0x19c>
             /*
              * Internet format:
              *  a.b.c.d
              *  a.b.c   (with c treated as 16 bits)
              *  a.b (with b treated as 24 bits)
              */
             if (pp >= parts + 3)
     dd7:	8d 45 dc             	lea    0xffffffdc(%ebp),%eax
     dda:	83 c0 0c             	add    $0xc,%eax
     ddd:	3b 45 fc             	cmp    0xfffffffc(%ebp),%eax
     de0:	77 0c                	ja     dee <inet_aton+0x17e>
                 return (0);
     de2:	c7 45 c0 00 00 00 00 	movl   $0x0,0xffffffc0(%ebp)
     de9:	e9 2b 01 00 00       	jmp    f19 <inet_aton+0x2a9>
             *pp++ = val;
     dee:	8b 55 fc             	mov    0xfffffffc(%ebp),%edx
     df1:	8b 45 ec             	mov    0xffffffec(%ebp),%eax
     df4:	89 02                	mov    %eax,(%edx)
     df6:	83 45 fc 04          	addl   $0x4,0xfffffffc(%ebp)
             c = *++cp;
     dfa:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     dfe:	8b 45 08             	mov    0x8(%ebp),%eax
     e01:	0f b6 00             	movzbl (%eax),%eax
     e04:	88 45 fb             	mov    %al,0xfffffffb(%ebp)
         } else
             break;
     }
     e07:	e9 79 fe ff ff       	jmp    c85 <inet_aton+0x15>
     /*
      * Check for trailing characters.
      */
     if (c != '\0' && (!isascii(c) || !isspace(c)))
     e0c:	80 7d fb 00          	cmpb   $0x0,0xfffffffb(%ebp)
     e10:	74 3e                	je     e50 <inet_aton+0x1e0>
     e12:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
     e16:	3c 1f                	cmp    $0x1f,%al
     e18:	76 2a                	jbe    e44 <inet_aton+0x1d4>
     e1a:	80 7d fb 00          	cmpb   $0x0,0xfffffffb(%ebp)
     e1e:	78 24                	js     e44 <inet_aton+0x1d4>
     e20:	80 7d fb 20          	cmpb   $0x20,0xfffffffb(%ebp)
     e24:	74 2a                	je     e50 <inet_aton+0x1e0>
     e26:	80 7d fb 0c          	cmpb   $0xc,0xfffffffb(%ebp)
     e2a:	74 24                	je     e50 <inet_aton+0x1e0>
     e2c:	80 7d fb 0a          	cmpb   $0xa,0xfffffffb(%ebp)
     e30:	74 1e                	je     e50 <inet_aton+0x1e0>
     e32:	80 7d fb 0d          	cmpb   $0xd,0xfffffffb(%ebp)
     e36:	74 18                	je     e50 <inet_aton+0x1e0>
     e38:	80 7d fb 09          	cmpb   $0x9,0xfffffffb(%ebp)
     e3c:	74 12                	je     e50 <inet_aton+0x1e0>
     e3e:	80 7d fb 0b          	cmpb   $0xb,0xfffffffb(%ebp)
     e42:	74 0c                	je     e50 <inet_aton+0x1e0>
         return (0);
     e44:	c7 45 c0 00 00 00 00 	movl   $0x0,0xffffffc0(%ebp)
     e4b:	e9 c9 00 00 00       	jmp    f19 <inet_aton+0x2a9>
     /*
      * Concoct the address according to
      * the number of parts specified.
      */
     n = pp - parts + 1;
     e50:	8b 55 fc             	mov    0xfffffffc(%ebp),%edx
     e53:	8d 45 dc             	lea    0xffffffdc(%ebp),%eax
     e56:	89 d1                	mov    %edx,%ecx
     e58:	29 c1                	sub    %eax,%ecx
     e5a:	89 c8                	mov    %ecx,%eax
     e5c:	c1 f8 02             	sar    $0x2,%eax
     e5f:	83 c0 01             	add    $0x1,%eax
     e62:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
     switch (n) {
     e65:	83 7d f4 04          	cmpl   $0x4,0xfffffff4(%ebp)
     e69:	0f 87 8b 00 00 00    	ja     efa <inet_aton+0x28a>
     e6f:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     e72:	c1 e0 02             	shl    $0x2,%eax
     e75:	8b 80 00 11 00 00    	mov    0x1100(%eax),%eax
     e7b:	ff e0                	jmp    *%eax

     case 0:
         return (0);     /* initial nondigit */
     e7d:	c7 45 c0 00 00 00 00 	movl   $0x0,0xffffffc0(%ebp)
     e84:	e9 90 00 00 00       	jmp    f19 <inet_aton+0x2a9>

     case 1:             /* a -- 32 bits */
         break;

     case 2:             /* a.b -- 8.24 bits */
         if (val > 0xffffff)
     e89:	81 7d ec ff ff ff 00 	cmpl   $0xffffff,0xffffffec(%ebp)
     e90:	76 09                	jbe    e9b <inet_aton+0x22b>
             return (0);
     e92:	c7 45 c0 00 00 00 00 	movl   $0x0,0xffffffc0(%ebp)
     e99:	eb 7e                	jmp    f19 <inet_aton+0x2a9>
         val |= parts[0] << 24;
     e9b:	8b 45 dc             	mov    0xffffffdc(%ebp),%eax
     e9e:	c1 e0 18             	shl    $0x18,%eax
     ea1:	09 45 ec             	or     %eax,0xffffffec(%ebp)
         break;
     ea4:	eb 54                	jmp    efa <inet_aton+0x28a>

     case 3:             /* a.b.c -- 8.8.16 bits */
         if (val > 0xffff)
     ea6:	81 7d ec ff ff 00 00 	cmpl   $0xffff,0xffffffec(%ebp)
     ead:	76 09                	jbe    eb8 <inet_aton+0x248>
             return (0);
     eaf:	c7 45 c0 00 00 00 00 	movl   $0x0,0xffffffc0(%ebp)
     eb6:	eb 61                	jmp    f19 <inet_aton+0x2a9>
         val |= (parts[0] << 24) | (parts[1] << 16);
     eb8:	8b 45 dc             	mov    0xffffffdc(%ebp),%eax
     ebb:	89 c2                	mov    %eax,%edx
     ebd:	c1 e2 18             	shl    $0x18,%edx
     ec0:	8b 45 e0             	mov    0xffffffe0(%ebp),%eax
     ec3:	c1 e0 10             	shl    $0x10,%eax
     ec6:	09 d0                	or     %edx,%eax
     ec8:	09 45 ec             	or     %eax,0xffffffec(%ebp)
         break;
     ecb:	eb 2d                	jmp    efa <inet_aton+0x28a>

     case 4:             /* a.b.c.d -- 8.8.8.8 bits */
         if (val > 0xff)
     ecd:	81 7d ec ff 00 00 00 	cmpl   $0xff,0xffffffec(%ebp)
     ed4:	76 09                	jbe    edf <inet_aton+0x26f>
             return (0);
     ed6:	c7 45 c0 00 00 00 00 	movl   $0x0,0xffffffc0(%ebp)
     edd:	eb 3a                	jmp    f19 <inet_aton+0x2a9>
         val |= (parts[0] << 24) | (parts[1] << 16) | (parts[2] << 8);
     edf:	8b 45 dc             	mov    0xffffffdc(%ebp),%eax
     ee2:	89 c2                	mov    %eax,%edx
     ee4:	c1 e2 18             	shl    $0x18,%edx
     ee7:	8b 45 e0             	mov    0xffffffe0(%ebp),%eax
     eea:	c1 e0 10             	shl    $0x10,%eax
     eed:	09 c2                	or     %eax,%edx
     eef:	8b 45 e4             	mov    0xffffffe4(%ebp),%eax
     ef2:	c1 e0 08             	shl    $0x8,%eax
     ef5:	09 d0                	or     %edx,%eax
     ef7:	09 45 ec             	or     %eax,0xffffffec(%ebp)
         break;
     }
     if (addr)
     efa:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     efe:	74 12                	je     f12 <inet_aton+0x2a2>
         addr->s_addr = htonl(val);
     f00:	8b 45 ec             	mov    0xffffffec(%ebp),%eax
     f03:	89 04 24             	mov    %eax,(%esp)
     f06:	e8 65 01 00 00       	call   1070 <htonl>
     f0b:	89 c2                	mov    %eax,%edx
     f0d:	8b 45 0c             	mov    0xc(%ebp),%eax
     f10:	89 10                	mov    %edx,(%eax)
     return (1);
     f12:	c7 45 c0 01 00 00 00 	movl   $0x1,0xffffffc0(%ebp)
     f19:	8b 45 c0             	mov    0xffffffc0(%ebp),%eax
 }
     f1c:	c9                   	leave  
     f1d:	c3                   	ret    
     f1e:	89 f6                	mov    %esi,%esi

00000f20 <inet_ntoa>:

/* Convert numeric IP address into decimal dotted ASCII representation.
 * returns ptr to static buffer; not reentrant!
 */
char *inet_ntoa(struct in_addr addr)
{
     f20:	55                   	push   %ebp
     f21:	89 e5                	mov    %esp,%ebp
     f23:	53                   	push   %ebx
     f24:	83 ec 24             	sub    $0x24,%esp
  static char str[16];
  u32_t s_addr = addr.s_addr;
     f27:	8b 45 08             	mov    0x8(%ebp),%eax
     f2a:	89 45 ec             	mov    %eax,0xffffffec(%ebp)
  char inv[3];
  char *rp;
  char *ap;
  u8_t rem;
  u8_t n;
  u8_t i;

  rp = str;
     f2d:	c7 45 f0 34 11 00 00 	movl   $0x1134,0xfffffff0(%ebp)
  ap = (u8_t *)&s_addr;
     f34:	8d 45 ec             	lea    0xffffffec(%ebp),%eax
     f37:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
  for(n = 0; n < 4; n++) {
     f3a:	c6 45 fa 00          	movb   $0x0,0xfffffffa(%ebp)
     f3e:	e9 af 00 00 00       	jmp    ff2 <inet_ntoa+0xd2>
    i = 0;
     f43:	c6 45 fb 00          	movb   $0x0,0xfffffffb(%ebp)
    do {
      rem = *ap % (u8_t)10;
     f47:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     f4a:	0f b6 08             	movzbl (%eax),%ecx
     f4d:	b8 67 00 00 00       	mov    $0x67,%eax
     f52:	f6 e9                	imul   %cl
     f54:	66 c1 e8 08          	shr    $0x8,%ax
     f58:	89 c2                	mov    %eax,%edx
     f5a:	c0 fa 02             	sar    $0x2,%dl
     f5d:	89 c8                	mov    %ecx,%eax
     f5f:	c0 f8 07             	sar    $0x7,%al
     f62:	89 d3                	mov    %edx,%ebx
     f64:	28 c3                	sub    %al,%bl
     f66:	88 5d db             	mov    %bl,0xffffffdb(%ebp)
     f69:	0f b6 45 db          	movzbl 0xffffffdb(%ebp),%eax
     f6d:	c1 e0 02             	shl    $0x2,%eax
     f70:	02 45 db             	add    0xffffffdb(%ebp),%al
     f73:	01 c0                	add    %eax,%eax
     f75:	89 ca                	mov    %ecx,%edx
     f77:	28 c2                	sub    %al,%dl
     f79:	88 55 db             	mov    %dl,0xffffffdb(%ebp)
     f7c:	0f b6 5d db          	movzbl 0xffffffdb(%ebp),%ebx
     f80:	88 5d f9             	mov    %bl,0xfffffff9(%ebp)
      *ap /= (u8_t)10;
     f83:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     f86:	0f b6 08             	movzbl (%eax),%ecx
     f89:	b8 67 00 00 00       	mov    $0x67,%eax
     f8e:	f6 e9                	imul   %cl
     f90:	66 c1 e8 08          	shr    $0x8,%ax
     f94:	89 c2                	mov    %eax,%edx
     f96:	c0 fa 02             	sar    $0x2,%dl
     f99:	89 c8                	mov    %ecx,%eax
     f9b:	c0 f8 07             	sar    $0x7,%al
     f9e:	28 c2                	sub    %al,%dl
     fa0:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     fa3:	88 10                	mov    %dl,(%eax)
      inv[i++] = '0' + rem;
     fa5:	0f b6 55 fb          	movzbl 0xfffffffb(%ebp),%edx
     fa9:	0f b6 45 f9          	movzbl 0xfffffff9(%ebp),%eax
     fad:	83 c0 30             	add    $0x30,%eax
     fb0:	88 44 15 e9          	mov    %al,0xffffffe9(%ebp,%edx,1)
     fb4:	80 45 fb 01          	addb   $0x1,0xfffffffb(%ebp)
    } while(*ap);
     fb8:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     fbb:	0f b6 00             	movzbl (%eax),%eax
     fbe:	84 c0                	test   %al,%al
     fc0:	75 85                	jne    f47 <inet_ntoa+0x27>
    while(i--)
     fc2:	eb 12                	jmp    fd6 <inet_ntoa+0xb6>
      *rp++ = inv[i];
     fc4:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
     fc8:	0f b6 54 05 e9       	movzbl 0xffffffe9(%ebp,%eax,1),%edx
     fcd:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
     fd0:	88 10                	mov    %dl,(%eax)
     fd2:	83 45 f0 01          	addl   $0x1,0xfffffff0(%ebp)
     fd6:	80 6d fb 01          	subb   $0x1,0xfffffffb(%ebp)
     fda:	80 7d fb ff          	cmpb   $0xff,0xfffffffb(%ebp)
     fde:	75 e4                	jne    fc4 <inet_ntoa+0xa4>
    *rp++ = '.';
     fe0:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
     fe3:	c6 00 2e             	movb   $0x2e,(%eax)
     fe6:	83 45 f0 01          	addl   $0x1,0xfffffff0(%ebp)
    ap++;
     fea:	83 45 f4 01          	addl   $0x1,0xfffffff4(%ebp)
     fee:	80 45 fa 01          	addb   $0x1,0xfffffffa(%ebp)
     ff2:	80 7d fa 03          	cmpb   $0x3,0xfffffffa(%ebp)
     ff6:	0f 86 47 ff ff ff    	jbe    f43 <inet_ntoa+0x23>
  }
  *--rp = 0;
     ffc:	83 6d f0 01          	subl   $0x1,0xfffffff0(%ebp)
    1000:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
    1003:	c6 00 00             	movb   $0x0,(%eax)
  return str;
    1006:	b8 34 11 00 00       	mov    $0x1134,%eax
}
    100b:	83 c4 24             	add    $0x24,%esp
    100e:	5b                   	pop    %ebx
    100f:	5d                   	pop    %ebp
    1010:	c3                   	ret    
    1011:	eb 0d                	jmp    1020 <htons>
    1013:	90                   	nop    
    1014:	90                   	nop    
    1015:	90                   	nop    
    1016:	90                   	nop    
    1017:	90                   	nop    
    1018:	90                   	nop    
    1019:	90                   	nop    
    101a:	90                   	nop    
    101b:	90                   	nop    
    101c:	90                   	nop    
    101d:	90                   	nop    
    101e:	90                   	nop    
    101f:	90                   	nop    

00001020 <htons>:


#ifndef BYTE_ORDER
#error BYTE_ORDER is not defined
#endif
#if BYTE_ORDER == LITTLE_ENDIAN

u16_t
htons(u16_t n)
{
    1020:	55                   	push   %ebp
    1021:	89 e5                	mov    %esp,%ebp
    1023:	83 ec 04             	sub    $0x4,%esp
    1026:	8b 45 08             	mov    0x8(%ebp),%eax
    1029:	66 89 45 fc          	mov    %ax,0xfffffffc(%ebp)
  return ((n & 0xff) << 8) | ((n & 0xff00) >> 8);
    102d:	0f b7 45 fc          	movzwl 0xfffffffc(%ebp),%eax
    1031:	25 ff 00 00 00       	and    $0xff,%eax
    1036:	c1 e0 08             	shl    $0x8,%eax
    1039:	89 c2                	mov    %eax,%edx
    103b:	0f b7 45 fc          	movzwl 0xfffffffc(%ebp),%eax
    103f:	25 00 ff 00 00       	and    $0xff00,%eax
    1044:	c1 f8 08             	sar    $0x8,%eax
    1047:	09 d0                	or     %edx,%eax
    1049:	0f b7 c0             	movzwl %ax,%eax
}
    104c:	c9                   	leave  
    104d:	c3                   	ret    
    104e:	89 f6                	mov    %esi,%esi

00001050 <ntohs>:

u16_t
ntohs(u16_t n)
{
    1050:	55                   	push   %ebp
    1051:	89 e5                	mov    %esp,%ebp
    1053:	83 ec 08             	sub    $0x8,%esp
    1056:	8b 45 08             	mov    0x8(%ebp),%eax
    1059:	66 89 45 fc          	mov    %ax,0xfffffffc(%ebp)
  return htons(n);
    105d:	0f b7 45 fc          	movzwl 0xfffffffc(%ebp),%eax
    1061:	89 04 24             	mov    %eax,(%esp)
    1064:	e8 b7 ff ff ff       	call   1020 <htons>
    1069:	0f b7 c0             	movzwl %ax,%eax
}
    106c:	c9                   	leave  
    106d:	c3                   	ret    
    106e:	89 f6                	mov    %esi,%esi

00001070 <htonl>:

u32_t
htonl(u32_t n)
{
    1070:	55                   	push   %ebp
    1071:	89 e5                	mov    %esp,%ebp
  return ((n & 0xff) << 24) |
    1073:	0f b6 45 08          	movzbl 0x8(%ebp),%eax
    1077:	89 c2                	mov    %eax,%edx
    1079:	c1 e2 18             	shl    $0x18,%edx
    107c:	8b 45 08             	mov    0x8(%ebp),%eax
    107f:	25 00 ff 00 00       	and    $0xff00,%eax
    1084:	c1 e0 08             	shl    $0x8,%eax
    1087:	09 c2                	or     %eax,%edx
    1089:	8b 45 08             	mov    0x8(%ebp),%eax
    108c:	25 00 00 ff 00       	and    $0xff0000,%eax
    1091:	c1 e8 08             	shr    $0x8,%eax
    1094:	09 c2                	or     %eax,%edx
    1096:	8b 45 08             	mov    0x8(%ebp),%eax
    1099:	25 00 00 00 ff       	and    $0xff000000,%eax
    109e:	c1 e8 18             	shr    $0x18,%eax
    10a1:	09 d0                	or     %edx,%eax
    ((n & 0xff00) << 8) |
    ((n & 0xff0000) >> 8) |
    ((n & 0xff000000) >> 24);
}
    10a3:	5d                   	pop    %ebp
    10a4:	c3                   	ret    
    10a5:	8d 74 26 00          	lea    0x0(%esi),%esi
    10a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

000010b0 <ntohl>:

u32_t
ntohl(u32_t n)
{
    10b0:	55                   	push   %ebp
    10b1:	89 e5                	mov    %esp,%ebp
    10b3:	83 ec 04             	sub    $0x4,%esp
  return htonl(n);
    10b6:	8b 45 08             	mov    0x8(%ebp),%eax
    10b9:	89 04 24             	mov    %eax,(%esp)
    10bc:	e8 af ff ff ff       	call   1070 <htonl>
}
    10c1:	c9                   	leave  
    10c2:	c3                   	ret    
