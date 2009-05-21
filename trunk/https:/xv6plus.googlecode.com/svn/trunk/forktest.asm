
_forktest:     file format elf32-i386-freebsd

Disassembly of section .text:

00000000 <printf>:
#include "user.h"

void
printf(int fd, char *s, ...)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 ec 18             	sub    $0x18,%esp
  write(fd, s, strlen(s));
   6:	8b 45 0c             	mov    0xc(%ebp),%eax
   9:	89 04 24             	mov    %eax,(%esp)
   c:	e8 9f 01 00 00       	call   1b0 <strlen>
  11:	89 44 24 08          	mov    %eax,0x8(%esp)
  15:	8b 45 0c             	mov    0xc(%ebp),%eax
  18:	89 44 24 04          	mov    %eax,0x4(%esp)
  1c:	8b 45 08             	mov    0x8(%ebp),%eax
  1f:	89 04 24             	mov    %eax,(%esp)
  22:	e8 ad 03 00 00       	call   3d4 <write>
}
  27:	c9                   	leave  
  28:	c3                   	ret    
  29:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi

00000030 <forktest>:

void
forktest(void)
{
  30:	55                   	push   %ebp
  31:	89 e5                	mov    %esp,%ebp
  33:	83 ec 18             	sub    $0x18,%esp
  int n, pid;

  printf(1, "fork test\n");
  36:	c7 44 24 04 cc 04 00 	movl   $0x4cc,0x4(%esp)
  3d:	00 
  3e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  45:	e8 b6 ff ff ff       	call   0 <printf>

  for(n=0; n<1000; n++){
  4a:	c7 45 f8 00 00 00 00 	movl   $0x0,0xfffffff8(%ebp)
  51:	eb 1d                	jmp    70 <forktest+0x40>
    pid = fork();
  53:	e8 54 03 00 00       	call   3ac <fork>
  58:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
    if(pid < 0)
  5b:	83 7d fc 00          	cmpl   $0x0,0xfffffffc(%ebp)
  5f:	78 18                	js     79 <forktest+0x49>
      break;
    if(pid == 0)
  61:	83 7d fc 00          	cmpl   $0x0,0xfffffffc(%ebp)
  65:	75 05                	jne    6c <forktest+0x3c>
      exit();
  67:	e8 48 03 00 00       	call   3b4 <exit>
  6c:	83 45 f8 01          	addl   $0x1,0xfffffff8(%ebp)
  70:	81 7d f8 e7 03 00 00 	cmpl   $0x3e7,0xfffffff8(%ebp)
  77:	7e da                	jle    53 <forktest+0x23>
  }
  
  if(n == 1000){
  79:	81 7d f8 e8 03 00 00 	cmpl   $0x3e8,0xfffffff8(%ebp)
  80:	75 3f                	jne    c1 <forktest+0x91>
    printf(1, "fork claimed to work 1000 times!\n");
  82:	c7 44 24 04 d8 04 00 	movl   $0x4d8,0x4(%esp)
  89:	00 
  8a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  91:	e8 6a ff ff ff       	call   0 <printf>
    exit();
  96:	e8 19 03 00 00       	call   3b4 <exit>
  }
  
  for(; n > 0; n--){
    if(wait() < 0){
  9b:	e8 1c 03 00 00       	call   3bc <wait>
  a0:	85 c0                	test   %eax,%eax
  a2:	79 19                	jns    bd <forktest+0x8d>
      printf(1, "wait stopped early\n");
  a4:	c7 44 24 04 fa 04 00 	movl   $0x4fa,0x4(%esp)
  ab:	00 
  ac:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  b3:	e8 48 ff ff ff       	call   0 <printf>
      exit();
  b8:	e8 f7 02 00 00       	call   3b4 <exit>
  bd:	83 6d f8 01          	subl   $0x1,0xfffffff8(%ebp)
  c1:	83 7d f8 00          	cmpl   $0x0,0xfffffff8(%ebp)
  c5:	7f d4                	jg     9b <forktest+0x6b>
    }
  }
  
  if(wait() != -1){
  c7:	e8 f0 02 00 00       	call   3bc <wait>
  cc:	83 f8 ff             	cmp    $0xffffffff,%eax
  cf:	74 19                	je     ea <forktest+0xba>
    printf(1, "wait got too many\n");
  d1:	c7 44 24 04 0e 05 00 	movl   $0x50e,0x4(%esp)
  d8:	00 
  d9:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  e0:	e8 1b ff ff ff       	call   0 <printf>
    exit();
  e5:	e8 ca 02 00 00       	call   3b4 <exit>
  }
  
  printf(1, "fork test OK\n");
  ea:	c7 44 24 04 21 05 00 	movl   $0x521,0x4(%esp)
  f1:	00 
  f2:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  f9:	e8 02 ff ff ff       	call   0 <printf>
}
  fe:	c9                   	leave  
  ff:	c3                   	ret    

00000100 <main>:

int
main(void)
{
 100:	8d 4c 24 04          	lea    0x4(%esp),%ecx
 104:	83 e4 f0             	and    $0xfffffff0,%esp
 107:	ff 71 fc             	pushl  0xfffffffc(%ecx)
 10a:	55                   	push   %ebp
 10b:	89 e5                	mov    %esp,%ebp
 10d:	51                   	push   %ecx
 10e:	83 ec 04             	sub    $0x4,%esp
  forktest();
 111:	e8 1a ff ff ff       	call   30 <forktest>
  exit();
 116:	e8 99 02 00 00       	call   3b4 <exit>
 11b:	90                   	nop    
 11c:	90                   	nop    
 11d:	90                   	nop    
 11e:	90                   	nop    
 11f:	90                   	nop    

00000120 <strcpy>:
#include "user.h"

char*
strcpy(char *s, char *t)
{
 120:	55                   	push   %ebp
 121:	89 e5                	mov    %esp,%ebp
 123:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
 126:	8b 45 08             	mov    0x8(%ebp),%eax
 129:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
  while((*s++ = *t++) != 0)
 12c:	8b 45 0c             	mov    0xc(%ebp),%eax
 12f:	0f b6 10             	movzbl (%eax),%edx
 132:	8b 45 08             	mov    0x8(%ebp),%eax
 135:	88 10                	mov    %dl,(%eax)
 137:	8b 45 08             	mov    0x8(%ebp),%eax
 13a:	0f b6 00             	movzbl (%eax),%eax
 13d:	84 c0                	test   %al,%al
 13f:	0f 95 c0             	setne  %al
 142:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 146:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
 14a:	84 c0                	test   %al,%al
 14c:	75 de                	jne    12c <strcpy+0xc>
    ;
  return os;
 14e:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
}
 151:	c9                   	leave  
 152:	c3                   	ret    
 153:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 159:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00000160 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 160:	55                   	push   %ebp
 161:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
 163:	eb 08                	jmp    16d <strcmp+0xd>
    p++, q++;
 165:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 169:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
 16d:	8b 45 08             	mov    0x8(%ebp),%eax
 170:	0f b6 00             	movzbl (%eax),%eax
 173:	84 c0                	test   %al,%al
 175:	74 10                	je     187 <strcmp+0x27>
 177:	8b 45 08             	mov    0x8(%ebp),%eax
 17a:	0f b6 10             	movzbl (%eax),%edx
 17d:	8b 45 0c             	mov    0xc(%ebp),%eax
 180:	0f b6 00             	movzbl (%eax),%eax
 183:	38 c2                	cmp    %al,%dl
 185:	74 de                	je     165 <strcmp+0x5>
  return (uchar)*p - (uchar)*q;
 187:	8b 45 08             	mov    0x8(%ebp),%eax
 18a:	0f b6 00             	movzbl (%eax),%eax
 18d:	0f b6 d0             	movzbl %al,%edx
 190:	8b 45 0c             	mov    0xc(%ebp),%eax
 193:	0f b6 00             	movzbl (%eax),%eax
 196:	0f b6 c0             	movzbl %al,%eax
 199:	89 d1                	mov    %edx,%ecx
 19b:	29 c1                	sub    %eax,%ecx
 19d:	89 c8                	mov    %ecx,%eax
}
 19f:	5d                   	pop    %ebp
 1a0:	c3                   	ret    
 1a1:	eb 0d                	jmp    1b0 <strlen>
 1a3:	90                   	nop    
 1a4:	90                   	nop    
 1a5:	90                   	nop    
 1a6:	90                   	nop    
 1a7:	90                   	nop    
 1a8:	90                   	nop    
 1a9:	90                   	nop    
 1aa:	90                   	nop    
 1ab:	90                   	nop    
 1ac:	90                   	nop    
 1ad:	90                   	nop    
 1ae:	90                   	nop    
 1af:	90                   	nop    

000001b0 <strlen>:

uint
strlen(char *s)
{
 1b0:	55                   	push   %ebp
 1b1:	89 e5                	mov    %esp,%ebp
 1b3:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 1b6:	c7 45 fc 00 00 00 00 	movl   $0x0,0xfffffffc(%ebp)
 1bd:	eb 04                	jmp    1c3 <strlen+0x13>
 1bf:	83 45 fc 01          	addl   $0x1,0xfffffffc(%ebp)
 1c3:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
 1c6:	03 45 08             	add    0x8(%ebp),%eax
 1c9:	0f b6 00             	movzbl (%eax),%eax
 1cc:	84 c0                	test   %al,%al
 1ce:	75 ef                	jne    1bf <strlen+0xf>
    ;
  return n;
 1d0:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
}
 1d3:	c9                   	leave  
 1d4:	c3                   	ret    
 1d5:	8d 74 26 00          	lea    0x0(%esi),%esi
 1d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

000001e0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 1e0:	55                   	push   %ebp
 1e1:	89 e5                	mov    %esp,%ebp
 1e3:	83 ec 10             	sub    $0x10,%esp
  char *d;
  
  d = dst;
 1e6:	8b 45 08             	mov    0x8(%ebp),%eax
 1e9:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
  while(n-- > 0)
 1ec:	eb 0e                	jmp    1fc <memset+0x1c>
    *d++ = c;
 1ee:	8b 45 0c             	mov    0xc(%ebp),%eax
 1f1:	89 c2                	mov    %eax,%edx
 1f3:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
 1f6:	88 10                	mov    %dl,(%eax)
 1f8:	83 45 fc 01          	addl   $0x1,0xfffffffc(%ebp)
 1fc:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
 200:	83 7d 10 ff          	cmpl   $0xffffffff,0x10(%ebp)
 204:	75 e8                	jne    1ee <memset+0xe>
  return dst;
 206:	8b 45 08             	mov    0x8(%ebp),%eax
}
 209:	c9                   	leave  
 20a:	c3                   	ret    
 20b:	90                   	nop    
 20c:	8d 74 26 00          	lea    0x0(%esi),%esi

00000210 <strchr>:

char*
strchr(const char *s, char c)
{
 210:	55                   	push   %ebp
 211:	89 e5                	mov    %esp,%ebp
 213:	83 ec 08             	sub    $0x8,%esp
 216:	8b 45 0c             	mov    0xc(%ebp),%eax
 219:	88 45 fc             	mov    %al,0xfffffffc(%ebp)
  for(; *s; s++)
 21c:	eb 17                	jmp    235 <strchr+0x25>
    if(*s == c)
 21e:	8b 45 08             	mov    0x8(%ebp),%eax
 221:	0f b6 00             	movzbl (%eax),%eax
 224:	3a 45 fc             	cmp    0xfffffffc(%ebp),%al
 227:	75 08                	jne    231 <strchr+0x21>
      return (char*) s;
 229:	8b 45 08             	mov    0x8(%ebp),%eax
 22c:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
 22f:	eb 15                	jmp    246 <strchr+0x36>
 231:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 235:	8b 45 08             	mov    0x8(%ebp),%eax
 238:	0f b6 00             	movzbl (%eax),%eax
 23b:	84 c0                	test   %al,%al
 23d:	75 df                	jne    21e <strchr+0xe>
  return 0;
 23f:	c7 45 f8 00 00 00 00 	movl   $0x0,0xfffffff8(%ebp)
 246:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
}
 249:	c9                   	leave  
 24a:	c3                   	ret    
 24b:	90                   	nop    
 24c:	8d 74 26 00          	lea    0x0(%esi),%esi

00000250 <gets>:

char*
gets(char *buf, int max)
{
 250:	55                   	push   %ebp
 251:	89 e5                	mov    %esp,%ebp
 253:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 256:	c7 45 f8 00 00 00 00 	movl   $0x0,0xfffffff8(%ebp)
 25d:	eb 46                	jmp    2a5 <gets+0x55>
    cc = read(0, &c, 1);
 25f:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 266:	00 
 267:	8d 45 f7             	lea    0xfffffff7(%ebp),%eax
 26a:	89 44 24 04          	mov    %eax,0x4(%esp)
 26e:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 275:	e8 52 01 00 00       	call   3cc <read>
 27a:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
    if(cc < 1)
 27d:	83 7d fc 00          	cmpl   $0x0,0xfffffffc(%ebp)
 281:	7e 2d                	jle    2b0 <gets+0x60>
      break;
    buf[i++] = c;
 283:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
 286:	89 c2                	mov    %eax,%edx
 288:	03 55 08             	add    0x8(%ebp),%edx
 28b:	0f b6 45 f7          	movzbl 0xfffffff7(%ebp),%eax
 28f:	88 02                	mov    %al,(%edx)
 291:	83 45 f8 01          	addl   $0x1,0xfffffff8(%ebp)
    if(c == '\n' || c == '\r')
 295:	0f b6 45 f7          	movzbl 0xfffffff7(%ebp),%eax
 299:	3c 0a                	cmp    $0xa,%al
 29b:	74 13                	je     2b0 <gets+0x60>
 29d:	0f b6 45 f7          	movzbl 0xfffffff7(%ebp),%eax
 2a1:	3c 0d                	cmp    $0xd,%al
 2a3:	74 0b                	je     2b0 <gets+0x60>
 2a5:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
 2a8:	83 c0 01             	add    $0x1,%eax
 2ab:	3b 45 0c             	cmp    0xc(%ebp),%eax
 2ae:	7c af                	jl     25f <gets+0xf>
      break;
  }
  buf[i] = '\0';
 2b0:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
 2b3:	03 45 08             	add    0x8(%ebp),%eax
 2b6:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 2b9:	8b 45 08             	mov    0x8(%ebp),%eax
}
 2bc:	c9                   	leave  
 2bd:	c3                   	ret    
 2be:	89 f6                	mov    %esi,%esi

000002c0 <stat>:

int
stat(char *n, struct stat *st)
{
 2c0:	55                   	push   %ebp
 2c1:	89 e5                	mov    %esp,%ebp
 2c3:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2c6:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 2cd:	00 
 2ce:	8b 45 08             	mov    0x8(%ebp),%eax
 2d1:	89 04 24             	mov    %eax,(%esp)
 2d4:	e8 1b 01 00 00       	call   3f4 <open>
 2d9:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
  if(fd < 0)
 2dc:	83 7d f8 00          	cmpl   $0x0,0xfffffff8(%ebp)
 2e0:	79 09                	jns    2eb <stat+0x2b>
    return -1;
 2e2:	c7 45 ec ff ff ff ff 	movl   $0xffffffff,0xffffffec(%ebp)
 2e9:	eb 26                	jmp    311 <stat+0x51>
  r = fstat(fd, st);
 2eb:	8b 45 0c             	mov    0xc(%ebp),%eax
 2ee:	89 44 24 04          	mov    %eax,0x4(%esp)
 2f2:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
 2f5:	89 04 24             	mov    %eax,(%esp)
 2f8:	e8 0f 01 00 00       	call   40c <fstat>
 2fd:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
  close(fd);
 300:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
 303:	89 04 24             	mov    %eax,(%esp)
 306:	e8 d1 00 00 00       	call   3dc <close>
  return r;
 30b:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
 30e:	89 45 ec             	mov    %eax,0xffffffec(%ebp)
 311:	8b 45 ec             	mov    0xffffffec(%ebp),%eax
}
 314:	c9                   	leave  
 315:	c3                   	ret    
 316:	8d 76 00             	lea    0x0(%esi),%esi
 319:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00000320 <atoi>:

int
atoi(const char *s)
{
 320:	55                   	push   %ebp
 321:	89 e5                	mov    %esp,%ebp
 323:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 326:	c7 45 fc 00 00 00 00 	movl   $0x0,0xfffffffc(%ebp)
  while('0' <= *s && *s <= '9')
 32d:	eb 24                	jmp    353 <atoi+0x33>
    n = n*10 + *s++ - '0';
 32f:	8b 55 fc             	mov    0xfffffffc(%ebp),%edx
 332:	89 d0                	mov    %edx,%eax
 334:	c1 e0 02             	shl    $0x2,%eax
 337:	01 d0                	add    %edx,%eax
 339:	01 c0                	add    %eax,%eax
 33b:	89 c2                	mov    %eax,%edx
 33d:	8b 45 08             	mov    0x8(%ebp),%eax
 340:	0f b6 00             	movzbl (%eax),%eax
 343:	0f be c0             	movsbl %al,%eax
 346:	8d 04 02             	lea    (%edx,%eax,1),%eax
 349:	83 e8 30             	sub    $0x30,%eax
 34c:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
 34f:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 353:	8b 45 08             	mov    0x8(%ebp),%eax
 356:	0f b6 00             	movzbl (%eax),%eax
 359:	3c 2f                	cmp    $0x2f,%al
 35b:	7e 0a                	jle    367 <atoi+0x47>
 35d:	8b 45 08             	mov    0x8(%ebp),%eax
 360:	0f b6 00             	movzbl (%eax),%eax
 363:	3c 39                	cmp    $0x39,%al
 365:	7e c8                	jle    32f <atoi+0xf>
  return n;
 367:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
}
 36a:	c9                   	leave  
 36b:	c3                   	ret    
 36c:	8d 74 26 00          	lea    0x0(%esi),%esi

00000370 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 370:	55                   	push   %ebp
 371:	89 e5                	mov    %esp,%ebp
 373:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 376:	8b 45 08             	mov    0x8(%ebp),%eax
 379:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
  src = vsrc;
 37c:	8b 45 0c             	mov    0xc(%ebp),%eax
 37f:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
  while(n-- > 0)
 382:	eb 13                	jmp    397 <memmove+0x27>
    *dst++ = *src++;
 384:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
 387:	0f b6 10             	movzbl (%eax),%edx
 38a:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
 38d:	88 10                	mov    %dl,(%eax)
 38f:	83 45 f8 01          	addl   $0x1,0xfffffff8(%ebp)
 393:	83 45 fc 01          	addl   $0x1,0xfffffffc(%ebp)
 397:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
 39b:	0f 9f c0             	setg   %al
 39e:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
 3a2:	84 c0                	test   %al,%al
 3a4:	75 de                	jne    384 <memmove+0x14>
  return vdst;
 3a6:	8b 45 08             	mov    0x8(%ebp),%eax
}
 3a9:	c9                   	leave  
 3aa:	c3                   	ret    
 3ab:	90                   	nop    

000003ac <fork>:
 3ac:	b8 01 00 00 00       	mov    $0x1,%eax
 3b1:	cd 30                	int    $0x30
 3b3:	c3                   	ret    

000003b4 <exit>:
 3b4:	b8 02 00 00 00       	mov    $0x2,%eax
 3b9:	cd 30                	int    $0x30
 3bb:	c3                   	ret    

000003bc <wait>:
 3bc:	b8 03 00 00 00       	mov    $0x3,%eax
 3c1:	cd 30                	int    $0x30
 3c3:	c3                   	ret    

000003c4 <pipe>:
 3c4:	b8 04 00 00 00       	mov    $0x4,%eax
 3c9:	cd 30                	int    $0x30
 3cb:	c3                   	ret    

000003cc <read>:
 3cc:	b8 06 00 00 00       	mov    $0x6,%eax
 3d1:	cd 30                	int    $0x30
 3d3:	c3                   	ret    

000003d4 <write>:
 3d4:	b8 05 00 00 00       	mov    $0x5,%eax
 3d9:	cd 30                	int    $0x30
 3db:	c3                   	ret    

000003dc <close>:
 3dc:	b8 07 00 00 00       	mov    $0x7,%eax
 3e1:	cd 30                	int    $0x30
 3e3:	c3                   	ret    

000003e4 <kill>:
 3e4:	b8 08 00 00 00       	mov    $0x8,%eax
 3e9:	cd 30                	int    $0x30
 3eb:	c3                   	ret    

000003ec <exec>:
 3ec:	b8 09 00 00 00       	mov    $0x9,%eax
 3f1:	cd 30                	int    $0x30
 3f3:	c3                   	ret    

000003f4 <open>:
 3f4:	b8 0a 00 00 00       	mov    $0xa,%eax
 3f9:	cd 30                	int    $0x30
 3fb:	c3                   	ret    

000003fc <mknod>:
 3fc:	b8 0b 00 00 00       	mov    $0xb,%eax
 401:	cd 30                	int    $0x30
 403:	c3                   	ret    

00000404 <unlink>:
 404:	b8 0c 00 00 00       	mov    $0xc,%eax
 409:	cd 30                	int    $0x30
 40b:	c3                   	ret    

0000040c <fstat>:
 40c:	b8 0d 00 00 00       	mov    $0xd,%eax
 411:	cd 30                	int    $0x30
 413:	c3                   	ret    

00000414 <link>:
 414:	b8 0e 00 00 00       	mov    $0xe,%eax
 419:	cd 30                	int    $0x30
 41b:	c3                   	ret    

0000041c <mkdir>:
 41c:	b8 0f 00 00 00       	mov    $0xf,%eax
 421:	cd 30                	int    $0x30
 423:	c3                   	ret    

00000424 <chdir>:
 424:	b8 10 00 00 00       	mov    $0x10,%eax
 429:	cd 30                	int    $0x30
 42b:	c3                   	ret    

0000042c <dup>:
 42c:	b8 11 00 00 00       	mov    $0x11,%eax
 431:	cd 30                	int    $0x30
 433:	c3                   	ret    

00000434 <getpid>:
 434:	b8 12 00 00 00       	mov    $0x12,%eax
 439:	cd 30                	int    $0x30
 43b:	c3                   	ret    

0000043c <sbrk>:
 43c:	b8 13 00 00 00       	mov    $0x13,%eax
 441:	cd 30                	int    $0x30
 443:	c3                   	ret    

00000444 <sleep>:
 444:	b8 14 00 00 00       	mov    $0x14,%eax
 449:	cd 30                	int    $0x30
 44b:	c3                   	ret    

0000044c <upmsec>:
 44c:	b8 15 00 00 00       	mov    $0x15,%eax
 451:	cd 30                	int    $0x30
 453:	c3                   	ret    

00000454 <socket>:
 454:	b8 16 00 00 00       	mov    $0x16,%eax
 459:	cd 30                	int    $0x30
 45b:	c3                   	ret    

0000045c <bind>:
 45c:	b8 17 00 00 00       	mov    $0x17,%eax
 461:	cd 30                	int    $0x30
 463:	c3                   	ret    

00000464 <listen>:
 464:	b8 18 00 00 00       	mov    $0x18,%eax
 469:	cd 30                	int    $0x30
 46b:	c3                   	ret    

0000046c <accept>:
 46c:	b8 19 00 00 00       	mov    $0x19,%eax
 471:	cd 30                	int    $0x30
 473:	c3                   	ret    

00000474 <recv>:
 474:	b8 1a 00 00 00       	mov    $0x1a,%eax
 479:	cd 30                	int    $0x30
 47b:	c3                   	ret    

0000047c <recvfrom>:
 47c:	b8 1b 00 00 00       	mov    $0x1b,%eax
 481:	cd 30                	int    $0x30
 483:	c3                   	ret    

00000484 <send>:
 484:	b8 1c 00 00 00       	mov    $0x1c,%eax
 489:	cd 30                	int    $0x30
 48b:	c3                   	ret    

0000048c <sendto>:
 48c:	b8 1d 00 00 00       	mov    $0x1d,%eax
 491:	cd 30                	int    $0x30
 493:	c3                   	ret    

00000494 <shutdown>:
 494:	b8 1e 00 00 00       	mov    $0x1e,%eax
 499:	cd 30                	int    $0x30
 49b:	c3                   	ret    

0000049c <getsockopt>:
 49c:	b8 1f 00 00 00       	mov    $0x1f,%eax
 4a1:	cd 30                	int    $0x30
 4a3:	c3                   	ret    

000004a4 <setsockopt>:
 4a4:	b8 20 00 00 00       	mov    $0x20,%eax
 4a9:	cd 30                	int    $0x30
 4ab:	c3                   	ret    

000004ac <sockclose>:
 4ac:	b8 21 00 00 00       	mov    $0x21,%eax
 4b1:	cd 30                	int    $0x30
 4b3:	c3                   	ret    

000004b4 <connect>:
 4b4:	b8 22 00 00 00       	mov    $0x22,%eax
 4b9:	cd 30                	int    $0x30
 4bb:	c3                   	ret    

000004bc <getpeername>:
 4bc:	b8 23 00 00 00       	mov    $0x23,%eax
 4c1:	cd 30                	int    $0x30
 4c3:	c3                   	ret    

000004c4 <getsockname>:
 4c4:	b8 24 00 00 00       	mov    $0x24,%eax
 4c9:	cd 30                	int    $0x30
 4cb:	c3                   	ret    
