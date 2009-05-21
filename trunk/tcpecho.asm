
_tcpecho:     file format elf32-i386-freebsd

Disassembly of section .text:

00000000 <main>:
#include "lwip/sockets.h"
#include "lwip/inet.h"

int main()
{
       0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
       4:	83 e4 f0             	and    $0xfffffff0,%esp
       7:	ff 71 fc             	pushl  0xfffffffc(%ecx)
       a:	55                   	push   %ebp
       b:	89 e5                	mov    %esp,%ebp
       d:	51                   	push   %ecx
       e:	81 ec 34 02 00 00    	sub    $0x234,%esp
  unsigned char data[512];
  int s;
  int len;
  s = socket(PF_INET, SOCK_STREAM, 0);
      14:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
      1b:	00 
      1c:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
      23:	00 
      24:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
      2b:	e8 a4 04 00 00       	call   4d4 <socket>
      30:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
  struct sockaddr_in sa;
  sa.sin_family = AF_INET;
      33:	c6 85 e1 fd ff ff 02 	movb   $0x2,0xfffffde1(%ebp)
  sa.sin_port = htons(80);
      3a:	c7 04 24 50 00 00 00 	movl   $0x50,(%esp)
      41:	e8 da 10 00 00       	call   1120 <htons>
      46:	66 89 85 e2 fd ff ff 	mov    %ax,0xfffffde2(%ebp)
  sa.sin_addr.s_addr = inet_addr("192.168.1.1");
      4d:	c7 04 24 c4 11 00 00 	movl   $0x11c4,(%esp)
      54:	e8 e7 0c 00 00       	call   d40 <inet_addr>
      59:	89 85 e4 fd ff ff    	mov    %eax,0xfffffde4(%ebp)
  len = 1;
      5f:	c7 85 f0 fd ff ff 01 	movl   $0x1,0xfffffdf0(%ebp)
      66:	00 00 00 
  setsockopt(s, SOL_SOCKET, SO_REUSEPORT, &len, sizeof(int));
      69:	c7 44 24 10 04 00 00 	movl   $0x4,0x10(%esp)
      70:	00 
      71:	8d 85 f0 fd ff ff    	lea    0xfffffdf0(%ebp),%eax
      77:	89 44 24 0c          	mov    %eax,0xc(%esp)
      7b:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
      82:	00 
      83:	c7 44 24 04 ff 0f 00 	movl   $0xfff,0x4(%esp)
      8a:	00 
      8b:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
      8e:	89 04 24             	mov    %eax,(%esp)
      91:	e8 8e 04 00 00       	call   524 <setsockopt>
  bind(s, &sa, sizeof(sa));
      96:	8d 85 e0 fd ff ff    	lea    0xfffffde0(%ebp),%eax
      9c:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
      a3:	00 
      a4:	89 44 24 04          	mov    %eax,0x4(%esp)
      a8:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
      ab:	89 04 24             	mov    %eax,(%esp)
      ae:	e8 29 04 00 00       	call   4dc <bind>
  int addrlen = sizeof(sa);
      b3:	c7 85 dc fd ff ff 10 	movl   $0x10,0xfffffddc(%ebp)
      ba:	00 00 00 
//  len = lwip_recvfrom(s, data, sizeof(data), 0, &sa, &addrlen);
//  lwip_sendto(s, data, len, 0, &sa, addrlen);
  int client;
  listen(s, 1);
      bd:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
      c4:	00 
      c5:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
      c8:	89 04 24             	mov    %eax,(%esp)
      cb:	e8 14 04 00 00       	call   4e4 <listen>
  while ((client = accept(s, &sa, &addrlen)) > 0)
      d0:	eb 7c                	jmp    14e <main+0x14e>
  {
      do {
        len = recv(client, data, sizeof(data), 0);
      d2:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
      d9:	00 
      da:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
      e1:	00 
      e2:	8d 85 f4 fd ff ff    	lea    0xfffffdf4(%ebp),%eax
      e8:	89 44 24 04          	mov    %eax,0x4(%esp)
      ec:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
      ef:	89 04 24             	mov    %eax,(%esp)
      f2:	e8 fd 03 00 00       	call   4f4 <recv>
      f7:	89 85 f0 fd ff ff    	mov    %eax,0xfffffdf0(%ebp)
//        cprintf("received %d bytes\n", len);
        send(client, data, len, 0);
      fd:	8b 85 f0 fd ff ff    	mov    0xfffffdf0(%ebp),%eax
     103:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
     10a:	00 
     10b:	89 44 24 08          	mov    %eax,0x8(%esp)
     10f:	8d 85 f4 fd ff ff    	lea    0xfffffdf4(%ebp),%eax
     115:	89 44 24 04          	mov    %eax,0x4(%esp)
     119:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     11c:	89 04 24             	mov    %eax,(%esp)
     11f:	e8 e0 03 00 00       	call   504 <send>
        if (data[0] == '!')
     124:	0f b6 85 f4 fd ff ff 	movzbl 0xfffffdf4(%ebp),%eax
     12b:	3c 21                	cmp    $0x21,%al
     12d:	75 0a                	jne    139 <main+0x139>
            len = -1;
     12f:	c7 85 f0 fd ff ff ff 	movl   $0xffffffff,0xfffffdf0(%ebp)
     136:	ff ff ff 
      } while (len > 0);
     139:	8b 85 f0 fd ff ff    	mov    0xfffffdf0(%ebp),%eax
     13f:	85 c0                	test   %eax,%eax
     141:	7f 8f                	jg     d2 <main+0xd2>
      sockclose(client);
     143:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     146:	89 04 24             	mov    %eax,(%esp)
     149:	e8 de 03 00 00       	call   52c <sockclose>
     14e:	8d 95 e0 fd ff ff    	lea    0xfffffde0(%ebp),%edx
     154:	8d 85 dc fd ff ff    	lea    0xfffffddc(%ebp),%eax
     15a:	89 44 24 08          	mov    %eax,0x8(%esp)
     15e:	89 54 24 04          	mov    %edx,0x4(%esp)
     162:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     165:	89 04 24             	mov    %eax,(%esp)
     168:	e8 7f 03 00 00       	call   4ec <accept>
     16d:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
     170:	83 7d f8 00          	cmpl   $0x0,0xfffffff8(%ebp)
     174:	0f 8f 58 ff ff ff    	jg     d2 <main+0xd2>
  }
  sockclose(s);
     17a:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     17d:	89 04 24             	mov    %eax,(%esp)
     180:	e8 a7 03 00 00       	call   52c <sockclose>
  return 0;
     185:	b8 00 00 00 00       	mov    $0x0,%eax
}
     18a:	81 c4 34 02 00 00    	add    $0x234,%esp
     190:	59                   	pop    %ecx
     191:	5d                   	pop    %ebp
     192:	8d 61 fc             	lea    0xfffffffc(%ecx),%esp
     195:	c3                   	ret    
     196:	90                   	nop    
     197:	90                   	nop    
     198:	90                   	nop    
     199:	90                   	nop    
     19a:	90                   	nop    
     19b:	90                   	nop    
     19c:	90                   	nop    
     19d:	90                   	nop    
     19e:	90                   	nop    
     19f:	90                   	nop    

000001a0 <strcpy>:
#include "user.h"

char*
strcpy(char *s, char *t)
{
     1a0:	55                   	push   %ebp
     1a1:	89 e5                	mov    %esp,%ebp
     1a3:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
     1a6:	8b 45 08             	mov    0x8(%ebp),%eax
     1a9:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
  while((*s++ = *t++) != 0)
     1ac:	8b 45 0c             	mov    0xc(%ebp),%eax
     1af:	0f b6 10             	movzbl (%eax),%edx
     1b2:	8b 45 08             	mov    0x8(%ebp),%eax
     1b5:	88 10                	mov    %dl,(%eax)
     1b7:	8b 45 08             	mov    0x8(%ebp),%eax
     1ba:	0f b6 00             	movzbl (%eax),%eax
     1bd:	84 c0                	test   %al,%al
     1bf:	0f 95 c0             	setne  %al
     1c2:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     1c6:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
     1ca:	84 c0                	test   %al,%al
     1cc:	75 de                	jne    1ac <strcpy+0xc>
    ;
  return os;
     1ce:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
}
     1d1:	c9                   	leave  
     1d2:	c3                   	ret    
     1d3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     1d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

000001e0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     1e0:	55                   	push   %ebp
     1e1:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
     1e3:	eb 08                	jmp    1ed <strcmp+0xd>
    p++, q++;
     1e5:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     1e9:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
     1ed:	8b 45 08             	mov    0x8(%ebp),%eax
     1f0:	0f b6 00             	movzbl (%eax),%eax
     1f3:	84 c0                	test   %al,%al
     1f5:	74 10                	je     207 <strcmp+0x27>
     1f7:	8b 45 08             	mov    0x8(%ebp),%eax
     1fa:	0f b6 10             	movzbl (%eax),%edx
     1fd:	8b 45 0c             	mov    0xc(%ebp),%eax
     200:	0f b6 00             	movzbl (%eax),%eax
     203:	38 c2                	cmp    %al,%dl
     205:	74 de                	je     1e5 <strcmp+0x5>
  return (uchar)*p - (uchar)*q;
     207:	8b 45 08             	mov    0x8(%ebp),%eax
     20a:	0f b6 00             	movzbl (%eax),%eax
     20d:	0f b6 d0             	movzbl %al,%edx
     210:	8b 45 0c             	mov    0xc(%ebp),%eax
     213:	0f b6 00             	movzbl (%eax),%eax
     216:	0f b6 c0             	movzbl %al,%eax
     219:	89 d1                	mov    %edx,%ecx
     21b:	29 c1                	sub    %eax,%ecx
     21d:	89 c8                	mov    %ecx,%eax
}
     21f:	5d                   	pop    %ebp
     220:	c3                   	ret    
     221:	eb 0d                	jmp    230 <strlen>
     223:	90                   	nop    
     224:	90                   	nop    
     225:	90                   	nop    
     226:	90                   	nop    
     227:	90                   	nop    
     228:	90                   	nop    
     229:	90                   	nop    
     22a:	90                   	nop    
     22b:	90                   	nop    
     22c:	90                   	nop    
     22d:	90                   	nop    
     22e:	90                   	nop    
     22f:	90                   	nop    

00000230 <strlen>:

uint
strlen(char *s)
{
     230:	55                   	push   %ebp
     231:	89 e5                	mov    %esp,%ebp
     233:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
     236:	c7 45 fc 00 00 00 00 	movl   $0x0,0xfffffffc(%ebp)
     23d:	eb 04                	jmp    243 <strlen+0x13>
     23f:	83 45 fc 01          	addl   $0x1,0xfffffffc(%ebp)
     243:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     246:	03 45 08             	add    0x8(%ebp),%eax
     249:	0f b6 00             	movzbl (%eax),%eax
     24c:	84 c0                	test   %al,%al
     24e:	75 ef                	jne    23f <strlen+0xf>
    ;
  return n;
     250:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
}
     253:	c9                   	leave  
     254:	c3                   	ret    
     255:	8d 74 26 00          	lea    0x0(%esi),%esi
     259:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00000260 <memset>:

void*
memset(void *dst, int c, uint n)
{
     260:	55                   	push   %ebp
     261:	89 e5                	mov    %esp,%ebp
     263:	83 ec 10             	sub    $0x10,%esp
  char *d;
  
  d = dst;
     266:	8b 45 08             	mov    0x8(%ebp),%eax
     269:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
  while(n-- > 0)
     26c:	eb 0e                	jmp    27c <memset+0x1c>
    *d++ = c;
     26e:	8b 45 0c             	mov    0xc(%ebp),%eax
     271:	89 c2                	mov    %eax,%edx
     273:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     276:	88 10                	mov    %dl,(%eax)
     278:	83 45 fc 01          	addl   $0x1,0xfffffffc(%ebp)
     27c:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
     280:	83 7d 10 ff          	cmpl   $0xffffffff,0x10(%ebp)
     284:	75 e8                	jne    26e <memset+0xe>
  return dst;
     286:	8b 45 08             	mov    0x8(%ebp),%eax
}
     289:	c9                   	leave  
     28a:	c3                   	ret    
     28b:	90                   	nop    
     28c:	8d 74 26 00          	lea    0x0(%esi),%esi

00000290 <strchr>:

char*
strchr(const char *s, char c)
{
     290:	55                   	push   %ebp
     291:	89 e5                	mov    %esp,%ebp
     293:	83 ec 08             	sub    $0x8,%esp
     296:	8b 45 0c             	mov    0xc(%ebp),%eax
     299:	88 45 fc             	mov    %al,0xfffffffc(%ebp)
  for(; *s; s++)
     29c:	eb 17                	jmp    2b5 <strchr+0x25>
    if(*s == c)
     29e:	8b 45 08             	mov    0x8(%ebp),%eax
     2a1:	0f b6 00             	movzbl (%eax),%eax
     2a4:	3a 45 fc             	cmp    0xfffffffc(%ebp),%al
     2a7:	75 08                	jne    2b1 <strchr+0x21>
      return (char*) s;
     2a9:	8b 45 08             	mov    0x8(%ebp),%eax
     2ac:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
     2af:	eb 15                	jmp    2c6 <strchr+0x36>
     2b1:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     2b5:	8b 45 08             	mov    0x8(%ebp),%eax
     2b8:	0f b6 00             	movzbl (%eax),%eax
     2bb:	84 c0                	test   %al,%al
     2bd:	75 df                	jne    29e <strchr+0xe>
  return 0;
     2bf:	c7 45 f8 00 00 00 00 	movl   $0x0,0xfffffff8(%ebp)
     2c6:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
}
     2c9:	c9                   	leave  
     2ca:	c3                   	ret    
     2cb:	90                   	nop    
     2cc:	8d 74 26 00          	lea    0x0(%esi),%esi

000002d0 <gets>:

char*
gets(char *buf, int max)
{
     2d0:	55                   	push   %ebp
     2d1:	89 e5                	mov    %esp,%ebp
     2d3:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     2d6:	c7 45 f8 00 00 00 00 	movl   $0x0,0xfffffff8(%ebp)
     2dd:	eb 46                	jmp    325 <gets+0x55>
    cc = read(0, &c, 1);
     2df:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
     2e6:	00 
     2e7:	8d 45 f7             	lea    0xfffffff7(%ebp),%eax
     2ea:	89 44 24 04          	mov    %eax,0x4(%esp)
     2ee:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     2f5:	e8 52 01 00 00       	call   44c <read>
     2fa:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
    if(cc < 1)
     2fd:	83 7d fc 00          	cmpl   $0x0,0xfffffffc(%ebp)
     301:	7e 2d                	jle    330 <gets+0x60>
      break;
    buf[i++] = c;
     303:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     306:	89 c2                	mov    %eax,%edx
     308:	03 55 08             	add    0x8(%ebp),%edx
     30b:	0f b6 45 f7          	movzbl 0xfffffff7(%ebp),%eax
     30f:	88 02                	mov    %al,(%edx)
     311:	83 45 f8 01          	addl   $0x1,0xfffffff8(%ebp)
    if(c == '\n' || c == '\r')
     315:	0f b6 45 f7          	movzbl 0xfffffff7(%ebp),%eax
     319:	3c 0a                	cmp    $0xa,%al
     31b:	74 13                	je     330 <gets+0x60>
     31d:	0f b6 45 f7          	movzbl 0xfffffff7(%ebp),%eax
     321:	3c 0d                	cmp    $0xd,%al
     323:	74 0b                	je     330 <gets+0x60>
     325:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     328:	83 c0 01             	add    $0x1,%eax
     32b:	3b 45 0c             	cmp    0xc(%ebp),%eax
     32e:	7c af                	jl     2df <gets+0xf>
      break;
  }
  buf[i] = '\0';
     330:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     333:	03 45 08             	add    0x8(%ebp),%eax
     336:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
     339:	8b 45 08             	mov    0x8(%ebp),%eax
}
     33c:	c9                   	leave  
     33d:	c3                   	ret    
     33e:	89 f6                	mov    %esi,%esi

00000340 <stat>:

int
stat(char *n, struct stat *st)
{
     340:	55                   	push   %ebp
     341:	89 e5                	mov    %esp,%ebp
     343:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     346:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     34d:	00 
     34e:	8b 45 08             	mov    0x8(%ebp),%eax
     351:	89 04 24             	mov    %eax,(%esp)
     354:	e8 1b 01 00 00       	call   474 <open>
     359:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
  if(fd < 0)
     35c:	83 7d f8 00          	cmpl   $0x0,0xfffffff8(%ebp)
     360:	79 09                	jns    36b <stat+0x2b>
    return -1;
     362:	c7 45 ec ff ff ff ff 	movl   $0xffffffff,0xffffffec(%ebp)
     369:	eb 26                	jmp    391 <stat+0x51>
  r = fstat(fd, st);
     36b:	8b 45 0c             	mov    0xc(%ebp),%eax
     36e:	89 44 24 04          	mov    %eax,0x4(%esp)
     372:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     375:	89 04 24             	mov    %eax,(%esp)
     378:	e8 0f 01 00 00       	call   48c <fstat>
     37d:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
  close(fd);
     380:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     383:	89 04 24             	mov    %eax,(%esp)
     386:	e8 d1 00 00 00       	call   45c <close>
  return r;
     38b:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     38e:	89 45 ec             	mov    %eax,0xffffffec(%ebp)
     391:	8b 45 ec             	mov    0xffffffec(%ebp),%eax
}
     394:	c9                   	leave  
     395:	c3                   	ret    
     396:	8d 76 00             	lea    0x0(%esi),%esi
     399:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

000003a0 <atoi>:

int
atoi(const char *s)
{
     3a0:	55                   	push   %ebp
     3a1:	89 e5                	mov    %esp,%ebp
     3a3:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
     3a6:	c7 45 fc 00 00 00 00 	movl   $0x0,0xfffffffc(%ebp)
  while('0' <= *s && *s <= '9')
     3ad:	eb 24                	jmp    3d3 <atoi+0x33>
    n = n*10 + *s++ - '0';
     3af:	8b 55 fc             	mov    0xfffffffc(%ebp),%edx
     3b2:	89 d0                	mov    %edx,%eax
     3b4:	c1 e0 02             	shl    $0x2,%eax
     3b7:	01 d0                	add    %edx,%eax
     3b9:	01 c0                	add    %eax,%eax
     3bb:	89 c2                	mov    %eax,%edx
     3bd:	8b 45 08             	mov    0x8(%ebp),%eax
     3c0:	0f b6 00             	movzbl (%eax),%eax
     3c3:	0f be c0             	movsbl %al,%eax
     3c6:	8d 04 02             	lea    (%edx,%eax,1),%eax
     3c9:	83 e8 30             	sub    $0x30,%eax
     3cc:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
     3cf:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     3d3:	8b 45 08             	mov    0x8(%ebp),%eax
     3d6:	0f b6 00             	movzbl (%eax),%eax
     3d9:	3c 2f                	cmp    $0x2f,%al
     3db:	7e 0a                	jle    3e7 <atoi+0x47>
     3dd:	8b 45 08             	mov    0x8(%ebp),%eax
     3e0:	0f b6 00             	movzbl (%eax),%eax
     3e3:	3c 39                	cmp    $0x39,%al
     3e5:	7e c8                	jle    3af <atoi+0xf>
  return n;
     3e7:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
}
     3ea:	c9                   	leave  
     3eb:	c3                   	ret    
     3ec:	8d 74 26 00          	lea    0x0(%esi),%esi

000003f0 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
     3f0:	55                   	push   %ebp
     3f1:	89 e5                	mov    %esp,%ebp
     3f3:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
     3f6:	8b 45 08             	mov    0x8(%ebp),%eax
     3f9:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
  src = vsrc;
     3fc:	8b 45 0c             	mov    0xc(%ebp),%eax
     3ff:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
  while(n-- > 0)
     402:	eb 13                	jmp    417 <memmove+0x27>
    *dst++ = *src++;
     404:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     407:	0f b6 10             	movzbl (%eax),%edx
     40a:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     40d:	88 10                	mov    %dl,(%eax)
     40f:	83 45 f8 01          	addl   $0x1,0xfffffff8(%ebp)
     413:	83 45 fc 01          	addl   $0x1,0xfffffffc(%ebp)
     417:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     41b:	0f 9f c0             	setg   %al
     41e:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
     422:	84 c0                	test   %al,%al
     424:	75 de                	jne    404 <memmove+0x14>
  return vdst;
     426:	8b 45 08             	mov    0x8(%ebp),%eax
}
     429:	c9                   	leave  
     42a:	c3                   	ret    
     42b:	90                   	nop    

0000042c <fork>:
     42c:	b8 01 00 00 00       	mov    $0x1,%eax
     431:	cd 30                	int    $0x30
     433:	c3                   	ret    

00000434 <exit>:
     434:	b8 02 00 00 00       	mov    $0x2,%eax
     439:	cd 30                	int    $0x30
     43b:	c3                   	ret    

0000043c <wait>:
     43c:	b8 03 00 00 00       	mov    $0x3,%eax
     441:	cd 30                	int    $0x30
     443:	c3                   	ret    

00000444 <pipe>:
     444:	b8 04 00 00 00       	mov    $0x4,%eax
     449:	cd 30                	int    $0x30
     44b:	c3                   	ret    

0000044c <read>:
     44c:	b8 06 00 00 00       	mov    $0x6,%eax
     451:	cd 30                	int    $0x30
     453:	c3                   	ret    

00000454 <write>:
     454:	b8 05 00 00 00       	mov    $0x5,%eax
     459:	cd 30                	int    $0x30
     45b:	c3                   	ret    

0000045c <close>:
     45c:	b8 07 00 00 00       	mov    $0x7,%eax
     461:	cd 30                	int    $0x30
     463:	c3                   	ret    

00000464 <kill>:
     464:	b8 08 00 00 00       	mov    $0x8,%eax
     469:	cd 30                	int    $0x30
     46b:	c3                   	ret    

0000046c <exec>:
     46c:	b8 09 00 00 00       	mov    $0x9,%eax
     471:	cd 30                	int    $0x30
     473:	c3                   	ret    

00000474 <open>:
     474:	b8 0a 00 00 00       	mov    $0xa,%eax
     479:	cd 30                	int    $0x30
     47b:	c3                   	ret    

0000047c <mknod>:
     47c:	b8 0b 00 00 00       	mov    $0xb,%eax
     481:	cd 30                	int    $0x30
     483:	c3                   	ret    

00000484 <unlink>:
     484:	b8 0c 00 00 00       	mov    $0xc,%eax
     489:	cd 30                	int    $0x30
     48b:	c3                   	ret    

0000048c <fstat>:
     48c:	b8 0d 00 00 00       	mov    $0xd,%eax
     491:	cd 30                	int    $0x30
     493:	c3                   	ret    

00000494 <link>:
     494:	b8 0e 00 00 00       	mov    $0xe,%eax
     499:	cd 30                	int    $0x30
     49b:	c3                   	ret    

0000049c <mkdir>:
     49c:	b8 0f 00 00 00       	mov    $0xf,%eax
     4a1:	cd 30                	int    $0x30
     4a3:	c3                   	ret    

000004a4 <chdir>:
     4a4:	b8 10 00 00 00       	mov    $0x10,%eax
     4a9:	cd 30                	int    $0x30
     4ab:	c3                   	ret    

000004ac <dup>:
     4ac:	b8 11 00 00 00       	mov    $0x11,%eax
     4b1:	cd 30                	int    $0x30
     4b3:	c3                   	ret    

000004b4 <getpid>:
     4b4:	b8 12 00 00 00       	mov    $0x12,%eax
     4b9:	cd 30                	int    $0x30
     4bb:	c3                   	ret    

000004bc <sbrk>:
     4bc:	b8 13 00 00 00       	mov    $0x13,%eax
     4c1:	cd 30                	int    $0x30
     4c3:	c3                   	ret    

000004c4 <sleep>:
     4c4:	b8 14 00 00 00       	mov    $0x14,%eax
     4c9:	cd 30                	int    $0x30
     4cb:	c3                   	ret    

000004cc <upmsec>:
     4cc:	b8 15 00 00 00       	mov    $0x15,%eax
     4d1:	cd 30                	int    $0x30
     4d3:	c3                   	ret    

000004d4 <socket>:
     4d4:	b8 16 00 00 00       	mov    $0x16,%eax
     4d9:	cd 30                	int    $0x30
     4db:	c3                   	ret    

000004dc <bind>:
     4dc:	b8 17 00 00 00       	mov    $0x17,%eax
     4e1:	cd 30                	int    $0x30
     4e3:	c3                   	ret    

000004e4 <listen>:
     4e4:	b8 18 00 00 00       	mov    $0x18,%eax
     4e9:	cd 30                	int    $0x30
     4eb:	c3                   	ret    

000004ec <accept>:
     4ec:	b8 19 00 00 00       	mov    $0x19,%eax
     4f1:	cd 30                	int    $0x30
     4f3:	c3                   	ret    

000004f4 <recv>:
     4f4:	b8 1a 00 00 00       	mov    $0x1a,%eax
     4f9:	cd 30                	int    $0x30
     4fb:	c3                   	ret    

000004fc <recvfrom>:
     4fc:	b8 1b 00 00 00       	mov    $0x1b,%eax
     501:	cd 30                	int    $0x30
     503:	c3                   	ret    

00000504 <send>:
     504:	b8 1c 00 00 00       	mov    $0x1c,%eax
     509:	cd 30                	int    $0x30
     50b:	c3                   	ret    

0000050c <sendto>:
     50c:	b8 1d 00 00 00       	mov    $0x1d,%eax
     511:	cd 30                	int    $0x30
     513:	c3                   	ret    

00000514 <shutdown>:
     514:	b8 1e 00 00 00       	mov    $0x1e,%eax
     519:	cd 30                	int    $0x30
     51b:	c3                   	ret    

0000051c <getsockopt>:
     51c:	b8 1f 00 00 00       	mov    $0x1f,%eax
     521:	cd 30                	int    $0x30
     523:	c3                   	ret    

00000524 <setsockopt>:
     524:	b8 20 00 00 00       	mov    $0x20,%eax
     529:	cd 30                	int    $0x30
     52b:	c3                   	ret    

0000052c <sockclose>:
     52c:	b8 21 00 00 00       	mov    $0x21,%eax
     531:	cd 30                	int    $0x30
     533:	c3                   	ret    

00000534 <connect>:
     534:	b8 22 00 00 00       	mov    $0x22,%eax
     539:	cd 30                	int    $0x30
     53b:	c3                   	ret    

0000053c <getpeername>:
     53c:	b8 23 00 00 00       	mov    $0x23,%eax
     541:	cd 30                	int    $0x30
     543:	c3                   	ret    

00000544 <getsockname>:
     544:	b8 24 00 00 00       	mov    $0x24,%eax
     549:	cd 30                	int    $0x30
     54b:	c3                   	ret    
     54c:	90                   	nop    
     54d:	90                   	nop    
     54e:	90                   	nop    
     54f:	90                   	nop    

00000550 <putc>:
#include "user.h"

void
putc(int fd, char c)
{
     550:	55                   	push   %ebp
     551:	89 e5                	mov    %esp,%ebp
     553:	83 ec 18             	sub    $0x18,%esp
     556:	8b 45 0c             	mov    0xc(%ebp),%eax
     559:	88 45 fc             	mov    %al,0xfffffffc(%ebp)
  write(fd, &c, 1);
     55c:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
     563:	00 
     564:	8d 45 fc             	lea    0xfffffffc(%ebp),%eax
     567:	89 44 24 04          	mov    %eax,0x4(%esp)
     56b:	8b 45 08             	mov    0x8(%ebp),%eax
     56e:	89 04 24             	mov    %eax,(%esp)
     571:	e8 de fe ff ff       	call   454 <write>
}
     576:	c9                   	leave  
     577:	c3                   	ret    
     578:	90                   	nop    
     579:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi

00000580 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     580:	55                   	push   %ebp
     581:	89 e5                	mov    %esp,%ebp
     583:	53                   	push   %ebx
     584:	83 ec 34             	sub    $0x34,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     587:	c7 45 f4 00 00 00 00 	movl   $0x0,0xfffffff4(%ebp)
  if(sgn && xx < 0){
     58e:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
     592:	74 17                	je     5ab <printint+0x2b>
     594:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     598:	79 11                	jns    5ab <printint+0x2b>
    neg = 1;
     59a:	c7 45 f4 01 00 00 00 	movl   $0x1,0xfffffff4(%ebp)
    x = -xx;
     5a1:	8b 45 0c             	mov    0xc(%ebp),%eax
     5a4:	f7 d8                	neg    %eax
     5a6:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
     5a9:	eb 06                	jmp    5b1 <printint+0x31>
  } else {
    x = xx;
     5ab:	8b 45 0c             	mov    0xc(%ebp),%eax
     5ae:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
  }

  i = 0;
     5b1:	c7 45 f0 00 00 00 00 	movl   $0x0,0xfffffff0(%ebp)
  do{
    buf[i++] = digits[x % base];
     5b8:	8b 4d f0             	mov    0xfffffff0(%ebp),%ecx
     5bb:	8b 55 10             	mov    0x10(%ebp),%edx
     5be:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     5c1:	89 d3                	mov    %edx,%ebx
     5c3:	ba 00 00 00 00       	mov    $0x0,%edx
     5c8:	f7 f3                	div    %ebx
     5ca:	89 d0                	mov    %edx,%eax
     5cc:	0f b6 80 ec 11 00 00 	movzbl 0x11ec(%eax),%eax
     5d3:	88 44 0d e0          	mov    %al,0xffffffe0(%ebp,%ecx,1)
     5d7:	83 45 f0 01          	addl   $0x1,0xfffffff0(%ebp)
  }while((x /= base) != 0);
     5db:	8b 55 10             	mov    0x10(%ebp),%edx
     5de:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     5e1:	89 d1                	mov    %edx,%ecx
     5e3:	ba 00 00 00 00       	mov    $0x0,%edx
     5e8:	f7 f1                	div    %ecx
     5ea:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
     5ed:	83 7d f8 00          	cmpl   $0x0,0xfffffff8(%ebp)
     5f1:	75 c5                	jne    5b8 <printint+0x38>
  if(neg)
     5f3:	83 7d f4 00          	cmpl   $0x0,0xfffffff4(%ebp)
     5f7:	74 28                	je     621 <printint+0xa1>
    buf[i++] = '-';
     5f9:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
     5fc:	c6 44 05 e0 2d       	movb   $0x2d,0xffffffe0(%ebp,%eax,1)
     601:	83 45 f0 01          	addl   $0x1,0xfffffff0(%ebp)

  while(--i >= 0)
     605:	eb 1a                	jmp    621 <printint+0xa1>
    putc(fd, buf[i]);
     607:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
     60a:	0f b6 44 05 e0       	movzbl 0xffffffe0(%ebp,%eax,1),%eax
     60f:	0f be c0             	movsbl %al,%eax
     612:	89 44 24 04          	mov    %eax,0x4(%esp)
     616:	8b 45 08             	mov    0x8(%ebp),%eax
     619:	89 04 24             	mov    %eax,(%esp)
     61c:	e8 2f ff ff ff       	call   550 <putc>
     621:	83 6d f0 01          	subl   $0x1,0xfffffff0(%ebp)
     625:	83 7d f0 00          	cmpl   $0x0,0xfffffff0(%ebp)
     629:	79 dc                	jns    607 <printint+0x87>
}
     62b:	83 c4 34             	add    $0x34,%esp
     62e:	5b                   	pop    %ebx
     62f:	5d                   	pop    %ebp
     630:	c3                   	ret    
     631:	eb 0d                	jmp    640 <printf>
     633:	90                   	nop    
     634:	90                   	nop    
     635:	90                   	nop    
     636:	90                   	nop    
     637:	90                   	nop    
     638:	90                   	nop    
     639:	90                   	nop    
     63a:	90                   	nop    
     63b:	90                   	nop    
     63c:	90                   	nop    
     63d:	90                   	nop    
     63e:	90                   	nop    
     63f:	90                   	nop    

00000640 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
     640:	55                   	push   %ebp
     641:	89 e5                	mov    %esp,%ebp
     643:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
     646:	c7 45 f8 00 00 00 00 	movl   $0x0,0xfffffff8(%ebp)
  ap = (uint*)(void*)&fmt + 1;
     64d:	8d 45 0c             	lea    0xc(%ebp),%eax
     650:	83 c0 04             	add    $0x4,%eax
     653:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
  for(i = 0; fmt[i]; i++){
     656:	c7 45 f4 00 00 00 00 	movl   $0x0,0xfffffff4(%ebp)
     65d:	e9 7b 01 00 00       	jmp    7dd <printf+0x19d>
    c = fmt[i] & 0xff;
     662:	8b 55 0c             	mov    0xc(%ebp),%edx
     665:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     668:	8d 04 02             	lea    (%edx,%eax,1),%eax
     66b:	0f b6 00             	movzbl (%eax),%eax
     66e:	0f be c0             	movsbl %al,%eax
     671:	25 ff 00 00 00       	and    $0xff,%eax
     676:	89 45 f0             	mov    %eax,0xfffffff0(%ebp)
    if(state == 0){
     679:	83 7d f8 00          	cmpl   $0x0,0xfffffff8(%ebp)
     67d:	75 2c                	jne    6ab <printf+0x6b>
      if(c == '%'){
     67f:	83 7d f0 25          	cmpl   $0x25,0xfffffff0(%ebp)
     683:	75 0c                	jne    691 <printf+0x51>
        state = '%';
     685:	c7 45 f8 25 00 00 00 	movl   $0x25,0xfffffff8(%ebp)
     68c:	e9 48 01 00 00       	jmp    7d9 <printf+0x199>
      } else {
        putc(fd, c);
     691:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
     694:	0f be c0             	movsbl %al,%eax
     697:	89 44 24 04          	mov    %eax,0x4(%esp)
     69b:	8b 45 08             	mov    0x8(%ebp),%eax
     69e:	89 04 24             	mov    %eax,(%esp)
     6a1:	e8 aa fe ff ff       	call   550 <putc>
     6a6:	e9 2e 01 00 00       	jmp    7d9 <printf+0x199>
      }
    } else if(state == '%'){
     6ab:	83 7d f8 25          	cmpl   $0x25,0xfffffff8(%ebp)
     6af:	0f 85 24 01 00 00    	jne    7d9 <printf+0x199>
      if(c == 'd'){
     6b5:	83 7d f0 64          	cmpl   $0x64,0xfffffff0(%ebp)
     6b9:	75 2d                	jne    6e8 <printf+0xa8>
        printint(fd, *ap, 10, 1);
     6bb:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     6be:	8b 00                	mov    (%eax),%eax
     6c0:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
     6c7:	00 
     6c8:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
     6cf:	00 
     6d0:	89 44 24 04          	mov    %eax,0x4(%esp)
     6d4:	8b 45 08             	mov    0x8(%ebp),%eax
     6d7:	89 04 24             	mov    %eax,(%esp)
     6da:	e8 a1 fe ff ff       	call   580 <printint>
        ap++;
     6df:	83 45 fc 04          	addl   $0x4,0xfffffffc(%ebp)
     6e3:	e9 ea 00 00 00       	jmp    7d2 <printf+0x192>
      } else if(c == 'x' || c == 'p'){
     6e8:	83 7d f0 78          	cmpl   $0x78,0xfffffff0(%ebp)
     6ec:	74 06                	je     6f4 <printf+0xb4>
     6ee:	83 7d f0 70          	cmpl   $0x70,0xfffffff0(%ebp)
     6f2:	75 2d                	jne    721 <printf+0xe1>
        printint(fd, *ap, 16, 0);
     6f4:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     6f7:	8b 00                	mov    (%eax),%eax
     6f9:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
     700:	00 
     701:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
     708:	00 
     709:	89 44 24 04          	mov    %eax,0x4(%esp)
     70d:	8b 45 08             	mov    0x8(%ebp),%eax
     710:	89 04 24             	mov    %eax,(%esp)
     713:	e8 68 fe ff ff       	call   580 <printint>
        ap++;
     718:	83 45 fc 04          	addl   $0x4,0xfffffffc(%ebp)
     71c:	e9 b1 00 00 00       	jmp    7d2 <printf+0x192>
      } else if(c == 's'){
     721:	83 7d f0 73          	cmpl   $0x73,0xfffffff0(%ebp)
     725:	75 43                	jne    76a <printf+0x12a>
        s = (char*)*ap;
     727:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     72a:	8b 00                	mov    (%eax),%eax
     72c:	89 45 ec             	mov    %eax,0xffffffec(%ebp)
        ap++;
     72f:	83 45 fc 04          	addl   $0x4,0xfffffffc(%ebp)
        if(s == 0)
     733:	83 7d ec 00          	cmpl   $0x0,0xffffffec(%ebp)
     737:	75 25                	jne    75e <printf+0x11e>
          s = "(null)";
     739:	c7 45 ec d0 11 00 00 	movl   $0x11d0,0xffffffec(%ebp)
        while(*s != 0){
     740:	eb 1c                	jmp    75e <printf+0x11e>
          putc(fd, *s);
     742:	8b 45 ec             	mov    0xffffffec(%ebp),%eax
     745:	0f b6 00             	movzbl (%eax),%eax
     748:	0f be c0             	movsbl %al,%eax
     74b:	89 44 24 04          	mov    %eax,0x4(%esp)
     74f:	8b 45 08             	mov    0x8(%ebp),%eax
     752:	89 04 24             	mov    %eax,(%esp)
     755:	e8 f6 fd ff ff       	call   550 <putc>
          s++;
     75a:	83 45 ec 01          	addl   $0x1,0xffffffec(%ebp)
     75e:	8b 45 ec             	mov    0xffffffec(%ebp),%eax
     761:	0f b6 00             	movzbl (%eax),%eax
     764:	84 c0                	test   %al,%al
     766:	75 da                	jne    742 <printf+0x102>
     768:	eb 68                	jmp    7d2 <printf+0x192>
        }
      } else if(c == 'c'){
     76a:	83 7d f0 63          	cmpl   $0x63,0xfffffff0(%ebp)
     76e:	75 1d                	jne    78d <printf+0x14d>
        putc(fd, *ap);
     770:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     773:	8b 00                	mov    (%eax),%eax
     775:	0f be c0             	movsbl %al,%eax
     778:	89 44 24 04          	mov    %eax,0x4(%esp)
     77c:	8b 45 08             	mov    0x8(%ebp),%eax
     77f:	89 04 24             	mov    %eax,(%esp)
     782:	e8 c9 fd ff ff       	call   550 <putc>
        ap++;
     787:	83 45 fc 04          	addl   $0x4,0xfffffffc(%ebp)
     78b:	eb 45                	jmp    7d2 <printf+0x192>
      } else if(c == '%'){
     78d:	83 7d f0 25          	cmpl   $0x25,0xfffffff0(%ebp)
     791:	75 17                	jne    7aa <printf+0x16a>
        putc(fd, c);
     793:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
     796:	0f be c0             	movsbl %al,%eax
     799:	89 44 24 04          	mov    %eax,0x4(%esp)
     79d:	8b 45 08             	mov    0x8(%ebp),%eax
     7a0:	89 04 24             	mov    %eax,(%esp)
     7a3:	e8 a8 fd ff ff       	call   550 <putc>
     7a8:	eb 28                	jmp    7d2 <printf+0x192>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     7aa:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
     7b1:	00 
     7b2:	8b 45 08             	mov    0x8(%ebp),%eax
     7b5:	89 04 24             	mov    %eax,(%esp)
     7b8:	e8 93 fd ff ff       	call   550 <putc>
        putc(fd, c);
     7bd:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
     7c0:	0f be c0             	movsbl %al,%eax
     7c3:	89 44 24 04          	mov    %eax,0x4(%esp)
     7c7:	8b 45 08             	mov    0x8(%ebp),%eax
     7ca:	89 04 24             	mov    %eax,(%esp)
     7cd:	e8 7e fd ff ff       	call   550 <putc>
      }
      state = 0;
     7d2:	c7 45 f8 00 00 00 00 	movl   $0x0,0xfffffff8(%ebp)
     7d9:	83 45 f4 01          	addl   $0x1,0xfffffff4(%ebp)
     7dd:	8b 55 0c             	mov    0xc(%ebp),%edx
     7e0:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     7e3:	8d 04 02             	lea    (%edx,%eax,1),%eax
     7e6:	0f b6 00             	movzbl (%eax),%eax
     7e9:	84 c0                	test   %al,%al
     7eb:	0f 85 71 fe ff ff    	jne    662 <printf+0x22>
    }
  }
}
     7f1:	c9                   	leave  
     7f2:	c3                   	ret    
     7f3:	90                   	nop    
     7f4:	90                   	nop    
     7f5:	90                   	nop    
     7f6:	90                   	nop    
     7f7:	90                   	nop    
     7f8:	90                   	nop    
     7f9:	90                   	nop    
     7fa:	90                   	nop    
     7fb:	90                   	nop    
     7fc:	90                   	nop    
     7fd:	90                   	nop    
     7fe:	90                   	nop    
     7ff:	90                   	nop    

00000800 <free>:
static Header *freep;

void
free(void *ap)
{
     800:	55                   	push   %ebp
     801:	89 e5                	mov    %esp,%ebp
     803:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*) ap - 1;
     806:	8b 45 08             	mov    0x8(%ebp),%eax
     809:	83 e8 08             	sub    $0x8,%eax
     80c:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     80f:	a1 08 12 00 00       	mov    0x1208,%eax
     814:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
     817:	eb 24                	jmp    83d <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     819:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     81c:	8b 00                	mov    (%eax),%eax
     81e:	3b 45 fc             	cmp    0xfffffffc(%ebp),%eax
     821:	77 12                	ja     835 <free+0x35>
     823:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     826:	3b 45 fc             	cmp    0xfffffffc(%ebp),%eax
     829:	77 24                	ja     84f <free+0x4f>
     82b:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     82e:	8b 00                	mov    (%eax),%eax
     830:	3b 45 f8             	cmp    0xfffffff8(%ebp),%eax
     833:	77 1a                	ja     84f <free+0x4f>
     835:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     838:	8b 00                	mov    (%eax),%eax
     83a:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
     83d:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     840:	3b 45 fc             	cmp    0xfffffffc(%ebp),%eax
     843:	76 d4                	jbe    819 <free+0x19>
     845:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     848:	8b 00                	mov    (%eax),%eax
     84a:	3b 45 f8             	cmp    0xfffffff8(%ebp),%eax
     84d:	76 ca                	jbe    819 <free+0x19>
      break;
  if(bp + bp->s.size == p->s.ptr){
     84f:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     852:	8b 40 04             	mov    0x4(%eax),%eax
     855:	c1 e0 03             	shl    $0x3,%eax
     858:	89 c2                	mov    %eax,%edx
     85a:	03 55 f8             	add    0xfffffff8(%ebp),%edx
     85d:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     860:	8b 00                	mov    (%eax),%eax
     862:	39 c2                	cmp    %eax,%edx
     864:	75 24                	jne    88a <free+0x8a>
    bp->s.size += p->s.ptr->s.size;
     866:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     869:	8b 50 04             	mov    0x4(%eax),%edx
     86c:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     86f:	8b 00                	mov    (%eax),%eax
     871:	8b 40 04             	mov    0x4(%eax),%eax
     874:	01 c2                	add    %eax,%edx
     876:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     879:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
     87c:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     87f:	8b 00                	mov    (%eax),%eax
     881:	8b 10                	mov    (%eax),%edx
     883:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     886:	89 10                	mov    %edx,(%eax)
     888:	eb 0a                	jmp    894 <free+0x94>
  } else
    bp->s.ptr = p->s.ptr;
     88a:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     88d:	8b 10                	mov    (%eax),%edx
     88f:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     892:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
     894:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     897:	8b 40 04             	mov    0x4(%eax),%eax
     89a:	c1 e0 03             	shl    $0x3,%eax
     89d:	03 45 fc             	add    0xfffffffc(%ebp),%eax
     8a0:	3b 45 f8             	cmp    0xfffffff8(%ebp),%eax
     8a3:	75 20                	jne    8c5 <free+0xc5>
    p->s.size += bp->s.size;
     8a5:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     8a8:	8b 50 04             	mov    0x4(%eax),%edx
     8ab:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     8ae:	8b 40 04             	mov    0x4(%eax),%eax
     8b1:	01 c2                	add    %eax,%edx
     8b3:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     8b6:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
     8b9:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     8bc:	8b 10                	mov    (%eax),%edx
     8be:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     8c1:	89 10                	mov    %edx,(%eax)
     8c3:	eb 08                	jmp    8cd <free+0xcd>
  } else
    p->s.ptr = bp;
     8c5:	8b 55 fc             	mov    0xfffffffc(%ebp),%edx
     8c8:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     8cb:	89 02                	mov    %eax,(%edx)
  freep = p;
     8cd:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     8d0:	a3 08 12 00 00       	mov    %eax,0x1208
}
     8d5:	c9                   	leave  
     8d6:	c3                   	ret    
     8d7:	89 f6                	mov    %esi,%esi
     8d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

000008e0 <morecore>:

static Header*
morecore(uint nu)
{
     8e0:	55                   	push   %ebp
     8e1:	89 e5                	mov    %esp,%ebp
     8e3:	83 ec 18             	sub    $0x18,%esp
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
     8e6:	8b 45 08             	mov    0x8(%ebp),%eax
     8e9:	c1 e0 03             	shl    $0x3,%eax
     8ec:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
  size += PAGE - size % PAGE;
     8ef:	8b 55 fc             	mov    0xfffffffc(%ebp),%edx
     8f2:	89 d0                	mov    %edx,%eax
     8f4:	c1 f8 1f             	sar    $0x1f,%eax
     8f7:	89 c1                	mov    %eax,%ecx
     8f9:	c1 e9 14             	shr    $0x14,%ecx
     8fc:	8d 04 0a             	lea    (%edx,%ecx,1),%eax
     8ff:	25 ff 0f 00 00       	and    $0xfff,%eax
     904:	29 c8                	sub    %ecx,%eax
     906:	89 c2                	mov    %eax,%edx
     908:	b8 00 10 00 00       	mov    $0x1000,%eax
     90d:	29 d0                	sub    %edx,%eax
     90f:	01 45 fc             	add    %eax,0xfffffffc(%ebp)
#endif
#ifdef UMALLOC_DEBUG
  printf(1, "size: %d\n", size);
#endif
  p = sbrk(size);
     912:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     915:	89 04 24             	mov    %eax,(%esp)
     918:	e8 9f fb ff ff       	call   4bc <sbrk>
     91d:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
  if(p == (char*) -1)
     920:	83 7d f4 ff          	cmpl   $0xffffffff,0xfffffff4(%ebp)
     924:	75 09                	jne    92f <morecore+0x4f>
    return 0;
     926:	c7 45 ec 00 00 00 00 	movl   $0x0,0xffffffec(%ebp)
     92d:	eb 2a                	jmp    959 <morecore+0x79>
  hp = (Header*)p;
     92f:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     932:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
#ifdef UMALLOC_NOALIGN
  hp->s.size = nu;
#else
  hp->s.size = size / sizeof(Header);
     935:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     938:	89 c2                	mov    %eax,%edx
     93a:	c1 ea 03             	shr    $0x3,%edx
     93d:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     940:	89 50 04             	mov    %edx,0x4(%eax)
#endif
  free((void*)(hp + 1));
     943:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     946:	83 c0 08             	add    $0x8,%eax
     949:	89 04 24             	mov    %eax,(%esp)
     94c:	e8 af fe ff ff       	call   800 <free>
  return freep;
     951:	a1 08 12 00 00       	mov    0x1208,%eax
     956:	89 45 ec             	mov    %eax,0xffffffec(%ebp)
     959:	8b 45 ec             	mov    0xffffffec(%ebp),%eax
}
     95c:	c9                   	leave  
     95d:	c3                   	ret    
     95e:	89 f6                	mov    %esi,%esi

00000960 <malloc>:

void*
malloc(uint nbytes)
{
     960:	55                   	push   %ebp
     961:	89 e5                	mov    %esp,%ebp
     963:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

#ifdef UMALLOC_DEBUG
  printf(1, "malloc: %d bytes\n", nbytes);
  printf(1, "size of Header: %d\n", sizeof(Header));
#endif
  if (PAGE % sizeof(Header))
      printf(2, "Warning! align failed! Need UMALLOC_NOALIGN\n");
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     966:	8b 45 08             	mov    0x8(%ebp),%eax
     969:	83 c0 07             	add    $0x7,%eax
     96c:	c1 e8 03             	shr    $0x3,%eax
     96f:	83 c0 01             	add    $0x1,%eax
     972:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
  if((prevp = freep) == 0){
     975:	a1 08 12 00 00       	mov    0x1208,%eax
     97a:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
     97d:	83 7d f8 00          	cmpl   $0x0,0xfffffff8(%ebp)
     981:	75 23                	jne    9a6 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
     983:	c7 45 f8 00 12 00 00 	movl   $0x1200,0xfffffff8(%ebp)
     98a:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     98d:	a3 08 12 00 00       	mov    %eax,0x1208
     992:	a1 08 12 00 00       	mov    0x1208,%eax
     997:	a3 00 12 00 00       	mov    %eax,0x1200
    base.s.size = 0;
     99c:	c7 05 04 12 00 00 00 	movl   $0x0,0x1204
     9a3:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     9a6:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     9a9:	8b 00                	mov    (%eax),%eax
     9ab:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
    if(p->s.size >= nunits){
     9ae:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     9b1:	8b 40 04             	mov    0x4(%eax),%eax
     9b4:	3b 45 fc             	cmp    0xfffffffc(%ebp),%eax
     9b7:	72 50                	jb     a09 <malloc+0xa9>
      if(p->s.size == nunits)
     9b9:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     9bc:	8b 40 04             	mov    0x4(%eax),%eax
     9bf:	3b 45 fc             	cmp    0xfffffffc(%ebp),%eax
     9c2:	75 0c                	jne    9d0 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
     9c4:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     9c7:	8b 10                	mov    (%eax),%edx
     9c9:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     9cc:	89 10                	mov    %edx,(%eax)
     9ce:	eb 26                	jmp    9f6 <malloc+0x96>
      else {
        p->s.size -= nunits;
     9d0:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     9d3:	8b 40 04             	mov    0x4(%eax),%eax
     9d6:	89 c2                	mov    %eax,%edx
     9d8:	2b 55 fc             	sub    0xfffffffc(%ebp),%edx
     9db:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     9de:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
     9e1:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     9e4:	8b 40 04             	mov    0x4(%eax),%eax
     9e7:	c1 e0 03             	shl    $0x3,%eax
     9ea:	01 45 f4             	add    %eax,0xfffffff4(%ebp)
        p->s.size = nunits;
     9ed:	8b 55 f4             	mov    0xfffffff4(%ebp),%edx
     9f0:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     9f3:	89 42 04             	mov    %eax,0x4(%edx)
      }
      freep = prevp;
     9f6:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     9f9:	a3 08 12 00 00       	mov    %eax,0x1208
      return (void*) (p + 1);
     9fe:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     a01:	83 c0 08             	add    $0x8,%eax
     a04:	89 45 ec             	mov    %eax,0xffffffec(%ebp)
     a07:	eb 3a                	jmp    a43 <malloc+0xe3>
    }
    if(p == freep)
     a09:	a1 08 12 00 00       	mov    0x1208,%eax
     a0e:	39 45 f4             	cmp    %eax,0xfffffff4(%ebp)
     a11:	75 1d                	jne    a30 <malloc+0xd0>
      if((p = morecore(nunits)) == 0)
     a13:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     a16:	89 04 24             	mov    %eax,(%esp)
     a19:	e8 c2 fe ff ff       	call   8e0 <morecore>
     a1e:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
     a21:	83 7d f4 00          	cmpl   $0x0,0xfffffff4(%ebp)
     a25:	75 09                	jne    a30 <malloc+0xd0>
        return 0;
     a27:	c7 45 ec 00 00 00 00 	movl   $0x0,0xffffffec(%ebp)
     a2e:	eb 13                	jmp    a43 <malloc+0xe3>
     a30:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     a33:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
     a36:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     a39:	8b 00                	mov    (%eax),%eax
     a3b:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
  }
     a3e:	e9 6b ff ff ff       	jmp    9ae <malloc+0x4e>
     a43:	8b 45 ec             	mov    0xffffffec(%ebp),%eax
}
     a46:	c9                   	leave  
     a47:	c3                   	ret    
     a48:	90                   	nop    
     a49:	90                   	nop    
     a4a:	90                   	nop    
     a4b:	90                   	nop    
     a4c:	90                   	nop    
     a4d:	90                   	nop    
     a4e:	90                   	nop    
     a4f:	90                   	nop    

00000a50 <lwip_chksum>:


static u16_t
lwip_chksum(void *dataptr, int len)
{
     a50:	55                   	push   %ebp
     a51:	89 e5                	mov    %esp,%ebp
     a53:	83 ec 18             	sub    $0x18,%esp
  u32_t acc;

  LWIP_DEBUGF(INET_DEBUG, ("lwip_chksum(%p, %d)\n", (void *)dataptr, len));
  for(acc = 0; len > 1; len -= 2) {
     a56:	c7 45 fc 00 00 00 00 	movl   $0x0,0xfffffffc(%ebp)
     a5d:	eb 19                	jmp    a78 <lwip_chksum+0x28>
      /*    acc = acc + *((u16_t *)dataptr)++;*/
    acc += *(u16_t *)dataptr;
     a5f:	8b 45 08             	mov    0x8(%ebp),%eax
     a62:	0f b7 00             	movzwl (%eax),%eax
     a65:	0f b7 c0             	movzwl %ax,%eax
     a68:	01 45 fc             	add    %eax,0xfffffffc(%ebp)
    dataptr = (void *)((u16_t *)dataptr + 1);
     a6b:	8b 45 08             	mov    0x8(%ebp),%eax
     a6e:	83 c0 02             	add    $0x2,%eax
     a71:	89 45 08             	mov    %eax,0x8(%ebp)
     a74:	83 6d 0c 02          	subl   $0x2,0xc(%ebp)
     a78:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
     a7c:	7f e1                	jg     a5f <lwip_chksum+0xf>
  }

  /* add up any odd byte */
  if (len == 1) {
     a7e:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
     a82:	75 1d                	jne    aa1 <lwip_chksum+0x51>
    acc += htons((u16_t)((*(u8_t *)dataptr) & 0xff) << 8);
     a84:	8b 45 08             	mov    0x8(%ebp),%eax
     a87:	0f b6 00             	movzbl (%eax),%eax
     a8a:	0f b6 c0             	movzbl %al,%eax
     a8d:	c1 e0 08             	shl    $0x8,%eax
     a90:	0f b7 c0             	movzwl %ax,%eax
     a93:	89 04 24             	mov    %eax,(%esp)
     a96:	e8 85 06 00 00       	call   1120 <htons>
     a9b:	0f b7 c0             	movzwl %ax,%eax
     a9e:	01 45 fc             	add    %eax,0xfffffffc(%ebp)
    LWIP_DEBUGF(INET_DEBUG, ("inet: chksum: odd byte %d\n", (unsigned int)(*(u8_t *)dataptr)));
  } else {
    LWIP_DEBUGF(INET_DEBUG, ("inet: chksum: no odd byte\n"));
  }
  acc = (acc >> 16) + (acc & 0xffffUL);
     aa1:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     aa4:	89 c2                	mov    %eax,%edx
     aa6:	c1 ea 10             	shr    $0x10,%edx
     aa9:	0f b7 45 fc          	movzwl 0xfffffffc(%ebp),%eax
     aad:	8d 04 02             	lea    (%edx,%eax,1),%eax
     ab0:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)

  if ((acc & 0xffff0000) != 0) {
     ab3:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     ab6:	66 b8 00 00          	mov    $0x0,%ax
     aba:	85 c0                	test   %eax,%eax
     abc:	74 12                	je     ad0 <lwip_chksum+0x80>
    acc = (acc >> 16) + (acc & 0xffffUL);
     abe:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     ac1:	89 c2                	mov    %eax,%edx
     ac3:	c1 ea 10             	shr    $0x10,%edx
     ac6:	0f b7 45 fc          	movzwl 0xfffffffc(%ebp),%eax
     aca:	8d 04 02             	lea    (%edx,%eax,1),%eax
     acd:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
  }

  return (u16_t)acc;
     ad0:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     ad3:	0f b7 c0             	movzwl %ax,%eax
}
     ad6:	c9                   	leave  
     ad7:	c3                   	ret    
     ad8:	90                   	nop    
     ad9:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi

00000ae0 <inet_chksum_pseudo>:

/* inet_chksum_pseudo:
 *
 * Calculates the pseudo Internet checksum used by TCP and UDP for a pbuf chain.
 */

u16_t
inet_chksum_pseudo(struct pbuf *p,
       struct ip_addr *src, struct ip_addr *dest,
       u8_t proto, u16_t proto_len)
{
     ae0:	55                   	push   %ebp
     ae1:	89 e5                	mov    %esp,%ebp
     ae3:	83 ec 28             	sub    $0x28,%esp
     ae6:	8b 45 14             	mov    0x14(%ebp),%eax
     ae9:	8b 55 18             	mov    0x18(%ebp),%edx
     aec:	88 45 ec             	mov    %al,0xffffffec(%ebp)
     aef:	66 89 55 e8          	mov    %dx,0xffffffe8(%ebp)
  u32_t acc;
  struct pbuf *q;
  u8_t swapped;

  acc = 0;
     af3:	c7 45 f4 00 00 00 00 	movl   $0x0,0xfffffff4(%ebp)
  swapped = 0;
     afa:	c6 45 ff 00          	movb   $0x0,0xffffffff(%ebp)
  /* iterate through all pbuf in chain */
  for(q = p; q != NULL; q = q->next) {
     afe:	8b 45 08             	mov    0x8(%ebp),%eax
     b01:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
     b04:	eb 7b                	jmp    b81 <inet_chksum_pseudo+0xa1>
    LWIP_DEBUGF(INET_DEBUG, ("inet_chksum_pseudo(): checksumming pbuf %p (has next %p) \n",
      (void *)q, (void *)q->next));
    acc += lwip_chksum(q->payload, q->len);
     b06:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     b09:	0f b7 40 0a          	movzwl 0xa(%eax),%eax
     b0d:	0f b7 d0             	movzwl %ax,%edx
     b10:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     b13:	8b 40 04             	mov    0x4(%eax),%eax
     b16:	89 54 24 04          	mov    %edx,0x4(%esp)
     b1a:	89 04 24             	mov    %eax,(%esp)
     b1d:	e8 2e ff ff ff       	call   a50 <lwip_chksum>
     b22:	0f b7 c0             	movzwl %ax,%eax
     b25:	01 45 f4             	add    %eax,0xfffffff4(%ebp)
    /*LWIP_DEBUGF(INET_DEBUG, ("inet_chksum_pseudo(): unwrapped lwip_chksum()=%lx \n", acc));*/
    while (acc >> 16) {
     b28:	eb 10                	jmp    b3a <inet_chksum_pseudo+0x5a>
      acc = (acc & 0xffffUL) + (acc >> 16);
     b2a:	0f b7 55 f4          	movzwl 0xfffffff4(%ebp),%edx
     b2e:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     b31:	c1 e8 10             	shr    $0x10,%eax
     b34:	8d 04 02             	lea    (%edx,%eax,1),%eax
     b37:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
     b3a:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     b3d:	c1 e8 10             	shr    $0x10,%eax
     b40:	85 c0                	test   %eax,%eax
     b42:	75 e6                	jne    b2a <inet_chksum_pseudo+0x4a>
    }
    if (q->len % 2 != 0) {
     b44:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     b47:	0f b7 40 0a          	movzwl 0xa(%eax),%eax
     b4b:	0f b7 c0             	movzwl %ax,%eax
     b4e:	83 e0 01             	and    $0x1,%eax
     b51:	84 c0                	test   %al,%al
     b53:	74 24                	je     b79 <inet_chksum_pseudo+0x99>
      swapped = 1 - swapped;
     b55:	b8 01 00 00 00       	mov    $0x1,%eax
     b5a:	2a 45 ff             	sub    0xffffffff(%ebp),%al
     b5d:	88 45 ff             	mov    %al,0xffffffff(%ebp)
      acc = ((acc & 0xff) << 8) | ((acc & 0xff00UL) >> 8);
     b60:	0f b6 45 f4          	movzbl 0xfffffff4(%ebp),%eax
     b64:	89 c2                	mov    %eax,%edx
     b66:	c1 e2 08             	shl    $0x8,%edx
     b69:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     b6c:	25 00 ff 00 00       	and    $0xff00,%eax
     b71:	c1 e8 08             	shr    $0x8,%eax
     b74:	09 d0                	or     %edx,%eax
     b76:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
     b79:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     b7c:	8b 00                	mov    (%eax),%eax
     b7e:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
     b81:	83 7d f8 00          	cmpl   $0x0,0xfffffff8(%ebp)
     b85:	0f 85 7b ff ff ff    	jne    b06 <inet_chksum_pseudo+0x26>
    }
    /*LWIP_DEBUGF(INET_DEBUG, ("inet_chksum_pseudo(): wrapped lwip_chksum()=%lx \n", acc));*/
  }

  if (swapped) {
     b8b:	80 7d ff 00          	cmpb   $0x0,0xffffffff(%ebp)
     b8f:	74 19                	je     baa <inet_chksum_pseudo+0xca>
    acc = ((acc & 0xff) << 8) | ((acc & 0xff00UL) >> 8);
     b91:	0f b6 45 f4          	movzbl 0xfffffff4(%ebp),%eax
     b95:	89 c2                	mov    %eax,%edx
     b97:	c1 e2 08             	shl    $0x8,%edx
     b9a:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     b9d:	25 00 ff 00 00       	and    $0xff00,%eax
     ba2:	c1 e8 08             	shr    $0x8,%eax
     ba5:	09 d0                	or     %edx,%eax
     ba7:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
  }
  acc += (src->addr & 0xffffUL);
     baa:	8b 45 0c             	mov    0xc(%ebp),%eax
     bad:	8b 00                	mov    (%eax),%eax
     baf:	25 ff ff 00 00       	and    $0xffff,%eax
     bb4:	01 45 f4             	add    %eax,0xfffffff4(%ebp)
  acc += ((src->addr >> 16) & 0xffffUL);
     bb7:	8b 45 0c             	mov    0xc(%ebp),%eax
     bba:	8b 00                	mov    (%eax),%eax
     bbc:	c1 e8 10             	shr    $0x10,%eax
     bbf:	25 ff ff 00 00       	and    $0xffff,%eax
     bc4:	01 45 f4             	add    %eax,0xfffffff4(%ebp)
  acc += (dest->addr & 0xffffUL);
     bc7:	8b 45 10             	mov    0x10(%ebp),%eax
     bca:	8b 00                	mov    (%eax),%eax
     bcc:	25 ff ff 00 00       	and    $0xffff,%eax
     bd1:	01 45 f4             	add    %eax,0xfffffff4(%ebp)
  acc += ((dest->addr >> 16) & 0xffffUL);
     bd4:	8b 45 10             	mov    0x10(%ebp),%eax
     bd7:	8b 00                	mov    (%eax),%eax
     bd9:	c1 e8 10             	shr    $0x10,%eax
     bdc:	25 ff ff 00 00       	and    $0xffff,%eax
     be1:	01 45 f4             	add    %eax,0xfffffff4(%ebp)
  acc += (u32_t)htons((u16_t)proto);
     be4:	0f b6 45 ec          	movzbl 0xffffffec(%ebp),%eax
     be8:	89 04 24             	mov    %eax,(%esp)
     beb:	e8 30 05 00 00       	call   1120 <htons>
     bf0:	0f b7 c0             	movzwl %ax,%eax
     bf3:	01 45 f4             	add    %eax,0xfffffff4(%ebp)
  acc += (u32_t)htons(proto_len);
     bf6:	0f b7 45 e8          	movzwl 0xffffffe8(%ebp),%eax
     bfa:	89 04 24             	mov    %eax,(%esp)
     bfd:	e8 1e 05 00 00       	call   1120 <htons>
     c02:	0f b7 c0             	movzwl %ax,%eax
     c05:	01 45 f4             	add    %eax,0xfffffff4(%ebp)

  while (acc >> 16) {
     c08:	eb 10                	jmp    c1a <inet_chksum_pseudo+0x13a>
    acc = (acc & 0xffffUL) + (acc >> 16);
     c0a:	0f b7 55 f4          	movzwl 0xfffffff4(%ebp),%edx
     c0e:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     c11:	c1 e8 10             	shr    $0x10,%eax
     c14:	8d 04 02             	lea    (%edx,%eax,1),%eax
     c17:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
     c1a:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     c1d:	c1 e8 10             	shr    $0x10,%eax
     c20:	85 c0                	test   %eax,%eax
     c22:	75 e6                	jne    c0a <inet_chksum_pseudo+0x12a>
  }
  LWIP_DEBUGF(INET_DEBUG, ("inet_chksum_pseudo(): pbuf chain lwip_chksum()=%lx\n", acc));
  return ~(acc & 0xffffUL);
     c24:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     c27:	f7 d0                	not    %eax
     c29:	0f b7 c0             	movzwl %ax,%eax
}
     c2c:	c9                   	leave  
     c2d:	c3                   	ret    
     c2e:	89 f6                	mov    %esi,%esi

00000c30 <inet_chksum>:

/* inet_chksum:
 *
 * Calculates the Internet checksum over a portion of memory. Used primarely for IP
 * and ICMP.
 */

u16_t
inet_chksum(void *dataptr, u16_t len)
{
     c30:	55                   	push   %ebp
     c31:	89 e5                	mov    %esp,%ebp
     c33:	83 ec 28             	sub    $0x28,%esp
     c36:	8b 45 0c             	mov    0xc(%ebp),%eax
     c39:	66 89 45 ec          	mov    %ax,0xffffffec(%ebp)
  u32_t acc;

  acc = lwip_chksum(dataptr, len);
     c3d:	0f b7 45 ec          	movzwl 0xffffffec(%ebp),%eax
     c41:	89 44 24 04          	mov    %eax,0x4(%esp)
     c45:	8b 45 08             	mov    0x8(%ebp),%eax
     c48:	89 04 24             	mov    %eax,(%esp)
     c4b:	e8 00 fe ff ff       	call   a50 <lwip_chksum>
     c50:	0f b7 c0             	movzwl %ax,%eax
     c53:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
  while (acc >> 16) {
     c56:	eb 10                	jmp    c68 <inet_chksum+0x38>
    acc = (acc & 0xffff) + (acc >> 16);
     c58:	0f b7 55 fc          	movzwl 0xfffffffc(%ebp),%edx
     c5c:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     c5f:	c1 e8 10             	shr    $0x10,%eax
     c62:	8d 04 02             	lea    (%edx,%eax,1),%eax
     c65:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
     c68:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     c6b:	c1 e8 10             	shr    $0x10,%eax
     c6e:	85 c0                	test   %eax,%eax
     c70:	75 e6                	jne    c58 <inet_chksum+0x28>
  }
  return ~(acc & 0xffff);
     c72:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     c75:	f7 d0                	not    %eax
     c77:	0f b7 c0             	movzwl %ax,%eax
}
     c7a:	c9                   	leave  
     c7b:	c3                   	ret    
     c7c:	8d 74 26 00          	lea    0x0(%esi),%esi

00000c80 <inet_chksum_pbuf>:

u16_t
inet_chksum_pbuf(struct pbuf *p)
{
     c80:	55                   	push   %ebp
     c81:	89 e5                	mov    %esp,%ebp
     c83:	83 ec 18             	sub    $0x18,%esp
  u32_t acc;
  struct pbuf *q;
  u8_t swapped;

  acc = 0;
     c86:	c7 45 f4 00 00 00 00 	movl   $0x0,0xfffffff4(%ebp)
  swapped = 0;
     c8d:	c6 45 ff 00          	movb   $0x0,0xffffffff(%ebp)
  for(q = p; q != NULL; q = q->next) {
     c91:	8b 45 08             	mov    0x8(%ebp),%eax
     c94:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
     c97:	eb 69                	jmp    d02 <inet_chksum_pbuf+0x82>
    acc += lwip_chksum(q->payload, q->len);
     c99:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     c9c:	0f b7 40 0a          	movzwl 0xa(%eax),%eax
     ca0:	0f b7 d0             	movzwl %ax,%edx
     ca3:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     ca6:	8b 40 04             	mov    0x4(%eax),%eax
     ca9:	89 54 24 04          	mov    %edx,0x4(%esp)
     cad:	89 04 24             	mov    %eax,(%esp)
     cb0:	e8 9b fd ff ff       	call   a50 <lwip_chksum>
     cb5:	0f b7 c0             	movzwl %ax,%eax
     cb8:	01 45 f4             	add    %eax,0xfffffff4(%ebp)
    while (acc >> 16) {
     cbb:	eb 10                	jmp    ccd <inet_chksum_pbuf+0x4d>
      acc = (acc & 0xffffUL) + (acc >> 16);
     cbd:	0f b7 55 f4          	movzwl 0xfffffff4(%ebp),%edx
     cc1:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     cc4:	c1 e8 10             	shr    $0x10,%eax
     cc7:	8d 04 02             	lea    (%edx,%eax,1),%eax
     cca:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
     ccd:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     cd0:	c1 e8 10             	shr    $0x10,%eax
     cd3:	85 c0                	test   %eax,%eax
     cd5:	75 e6                	jne    cbd <inet_chksum_pbuf+0x3d>
    }
    if (q->len % 2 != 0) {
     cd7:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     cda:	0f b7 40 0a          	movzwl 0xa(%eax),%eax
     cde:	0f b7 c0             	movzwl %ax,%eax
     ce1:	83 e0 01             	and    $0x1,%eax
     ce4:	84 c0                	test   %al,%al
     ce6:	74 12                	je     cfa <inet_chksum_pbuf+0x7a>
      swapped = 1 - swapped;
     ce8:	b8 01 00 00 00       	mov    $0x1,%eax
     ced:	2a 45 ff             	sub    0xffffffff(%ebp),%al
     cf0:	88 45 ff             	mov    %al,0xffffffff(%ebp)
      acc = (acc & 0x00ffUL << 8) | (acc & 0xff00UL >> 8);
     cf3:	81 65 f4 ff ff 00 00 	andl   $0xffff,0xfffffff4(%ebp)
     cfa:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     cfd:	8b 00                	mov    (%eax),%eax
     cff:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
     d02:	83 7d f8 00          	cmpl   $0x0,0xfffffff8(%ebp)
     d06:	75 91                	jne    c99 <inet_chksum_pbuf+0x19>
    }
  }

  if (swapped) {
     d08:	80 7d ff 00          	cmpb   $0x0,0xffffffff(%ebp)
     d0c:	74 19                	je     d27 <inet_chksum_pbuf+0xa7>
    acc = ((acc & 0x00ffUL) << 8) | ((acc & 0xff00UL) >> 8);
     d0e:	0f b6 45 f4          	movzbl 0xfffffff4(%ebp),%eax
     d12:	89 c2                	mov    %eax,%edx
     d14:	c1 e2 08             	shl    $0x8,%edx
     d17:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     d1a:	25 00 ff 00 00       	and    $0xff00,%eax
     d1f:	c1 e8 08             	shr    $0x8,%eax
     d22:	09 d0                	or     %edx,%eax
     d24:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
  }
  return ~(acc & 0xffffUL);
     d27:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     d2a:	f7 d0                	not    %eax
     d2c:	0f b7 c0             	movzwl %ax,%eax
}
     d2f:	c9                   	leave  
     d30:	c3                   	ret    
     d31:	eb 0d                	jmp    d40 <inet_addr>
     d33:	90                   	nop    
     d34:	90                   	nop    
     d35:	90                   	nop    
     d36:	90                   	nop    
     d37:	90                   	nop    
     d38:	90                   	nop    
     d39:	90                   	nop    
     d3a:	90                   	nop    
     d3b:	90                   	nop    
     d3c:	90                   	nop    
     d3d:	90                   	nop    
     d3e:	90                   	nop    
     d3f:	90                   	nop    

00000d40 <inet_addr>:

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
     d40:	55                   	push   %ebp
     d41:	89 e5                	mov    %esp,%ebp
     d43:	83 ec 28             	sub    $0x28,%esp
     struct in_addr val;

     if (inet_aton(cp, &val)) {
     d46:	8d 45 fc             	lea    0xfffffffc(%ebp),%eax
     d49:	89 44 24 04          	mov    %eax,0x4(%esp)
     d4d:	8b 45 08             	mov    0x8(%ebp),%eax
     d50:	89 04 24             	mov    %eax,(%esp)
     d53:	e8 18 00 00 00       	call   d70 <inet_aton>
     d58:	85 c0                	test   %eax,%eax
     d5a:	74 08                	je     d64 <inet_addr+0x24>
         return (val.s_addr);
     d5c:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     d5f:	89 45 ec             	mov    %eax,0xffffffec(%ebp)
     d62:	eb 07                	jmp    d6b <inet_addr+0x2b>
     }
     return (INADDR_NONE);
     d64:	c7 45 ec ff ff ff ff 	movl   $0xffffffff,0xffffffec(%ebp)
     d6b:	8b 45 ec             	mov    0xffffffec(%ebp),%eax
 }
     d6e:	c9                   	leave  
     d6f:	c3                   	ret    

00000d70 <inet_aton>:

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
     d70:	55                   	push   %ebp
     d71:	89 e5                	mov    %esp,%ebp
     d73:	83 ec 48             	sub    $0x48,%esp
     u32_t val;
     int base, n;
     char c;
     u32_t parts[4];
     u32_t* pp = parts;
     d76:	8d 45 dc             	lea    0xffffffdc(%ebp),%eax
     d79:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)

     c = *cp;
     d7c:	8b 45 08             	mov    0x8(%ebp),%eax
     d7f:	0f b6 00             	movzbl (%eax),%eax
     d82:	88 45 fb             	mov    %al,0xfffffffb(%ebp)
     for (;;) {
         /*
          * Collect number up to ``.''.
          * Values are specified as for C:
          * 0x=hex, 0=octal, isdigit=decimal.
          */
         if (!isdigit(c))
     d85:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
     d89:	3c 2f                	cmp    $0x2f,%al
     d8b:	76 08                	jbe    d95 <inet_aton+0x25>
     d8d:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
     d91:	3c 39                	cmp    $0x39,%al
     d93:	76 0c                	jbe    da1 <inet_aton+0x31>
             return (0);
     d95:	c7 45 c0 00 00 00 00 	movl   $0x0,0xffffffc0(%ebp)
     d9c:	e9 78 02 00 00       	jmp    1019 <inet_aton+0x2a9>
         val = 0; base = 10;
     da1:	c7 45 ec 00 00 00 00 	movl   $0x0,0xffffffec(%ebp)
     da8:	c7 45 f0 0a 00 00 00 	movl   $0xa,0xfffffff0(%ebp)
         if (c == '0') {
     daf:	80 7d fb 30          	cmpb   $0x30,0xfffffffb(%ebp)
     db3:	75 36                	jne    deb <inet_aton+0x7b>
             c = *++cp;
     db5:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     db9:	8b 45 08             	mov    0x8(%ebp),%eax
     dbc:	0f b6 00             	movzbl (%eax),%eax
     dbf:	88 45 fb             	mov    %al,0xfffffffb(%ebp)
             if (c == 'x' || c == 'X')
     dc2:	80 7d fb 78          	cmpb   $0x78,0xfffffffb(%ebp)
     dc6:	74 06                	je     dce <inet_aton+0x5e>
     dc8:	80 7d fb 58          	cmpb   $0x58,0xfffffffb(%ebp)
     dcc:	75 16                	jne    de4 <inet_aton+0x74>
                 base = 16, c = *++cp;
     dce:	c7 45 f0 10 00 00 00 	movl   $0x10,0xfffffff0(%ebp)
     dd5:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     dd9:	8b 45 08             	mov    0x8(%ebp),%eax
     ddc:	0f b6 00             	movzbl (%eax),%eax
     ddf:	88 45 fb             	mov    %al,0xfffffffb(%ebp)
     de2:	eb 07                	jmp    deb <inet_aton+0x7b>
             else
                 base = 8;
     de4:	c7 45 f0 08 00 00 00 	movl   $0x8,0xfffffff0(%ebp)
         }
         for (;;) {
             if (isascii(c) && isdigit(c)) {
     deb:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
     def:	3c 1f                	cmp    $0x1f,%al
     df1:	76 3b                	jbe    e2e <inet_aton+0xbe>
     df3:	80 7d fb 00          	cmpb   $0x0,0xfffffffb(%ebp)
     df7:	78 35                	js     e2e <inet_aton+0xbe>
     df9:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
     dfd:	3c 2f                	cmp    $0x2f,%al
     dff:	76 2d                	jbe    e2e <inet_aton+0xbe>
     e01:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
     e05:	3c 39                	cmp    $0x39,%al
     e07:	77 25                	ja     e2e <inet_aton+0xbe>
                 val = (val * base) + (c - '0');
     e09:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
     e0c:	89 c2                	mov    %eax,%edx
     e0e:	0f af 55 ec          	imul   0xffffffec(%ebp),%edx
     e12:	0f be 45 fb          	movsbl 0xfffffffb(%ebp),%eax
     e16:	8d 04 02             	lea    (%edx,%eax,1),%eax
     e19:	83 e8 30             	sub    $0x30,%eax
     e1c:	89 45 ec             	mov    %eax,0xffffffec(%ebp)
                 c = *++cp;
     e1f:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     e23:	8b 45 08             	mov    0x8(%ebp),%eax
     e26:	0f b6 00             	movzbl (%eax),%eax
     e29:	88 45 fb             	mov    %al,0xfffffffb(%ebp)
     e2c:	eb bd                	jmp    deb <inet_aton+0x7b>
             } else if (base == 16 && isascii(c) && isxdigit(c)) {
     e2e:	83 7d f0 10          	cmpl   $0x10,0xfffffff0(%ebp)
     e32:	0f 85 99 00 00 00    	jne    ed1 <inet_aton+0x161>
     e38:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
     e3c:	3c 1f                	cmp    $0x1f,%al
     e3e:	0f 86 8d 00 00 00    	jbe    ed1 <inet_aton+0x161>
     e44:	80 7d fb 00          	cmpb   $0x0,0xfffffffb(%ebp)
     e48:	0f 88 83 00 00 00    	js     ed1 <inet_aton+0x161>
     e4e:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
     e52:	3c 2f                	cmp    $0x2f,%al
     e54:	76 08                	jbe    e5e <inet_aton+0xee>
     e56:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
     e5a:	3c 39                	cmp    $0x39,%al
     e5c:	76 20                	jbe    e7e <inet_aton+0x10e>
     e5e:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
     e62:	3c 60                	cmp    $0x60,%al
     e64:	76 08                	jbe    e6e <inet_aton+0xfe>
     e66:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
     e6a:	3c 66                	cmp    $0x66,%al
     e6c:	76 10                	jbe    e7e <inet_aton+0x10e>
     e6e:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
     e72:	3c 40                	cmp    $0x40,%al
     e74:	76 5b                	jbe    ed1 <inet_aton+0x161>
     e76:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
     e7a:	3c 46                	cmp    $0x46,%al
     e7c:	77 53                	ja     ed1 <inet_aton+0x161>
                 val = (val << 4) |
     e7e:	8b 45 ec             	mov    0xffffffec(%ebp),%eax
     e81:	89 c2                	mov    %eax,%edx
     e83:	c1 e2 04             	shl    $0x4,%edx
     e86:	89 55 c4             	mov    %edx,0xffffffc4(%ebp)
     e89:	0f be 45 fb          	movsbl 0xfffffffb(%ebp),%eax
     e8d:	83 c0 0a             	add    $0xa,%eax
     e90:	89 45 c8             	mov    %eax,0xffffffc8(%ebp)
     e93:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
     e97:	3c 60                	cmp    $0x60,%al
     e99:	76 11                	jbe    eac <inet_aton+0x13c>
     e9b:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
     e9f:	3c 7a                	cmp    $0x7a,%al
     ea1:	77 09                	ja     eac <inet_aton+0x13c>
     ea3:	c7 45 cc 61 00 00 00 	movl   $0x61,0xffffffcc(%ebp)
     eaa:	eb 07                	jmp    eb3 <inet_aton+0x143>
     eac:	c7 45 cc 41 00 00 00 	movl   $0x41,0xffffffcc(%ebp)
     eb3:	8b 45 c8             	mov    0xffffffc8(%ebp),%eax
     eb6:	2b 45 cc             	sub    0xffffffcc(%ebp),%eax
     eb9:	0b 45 c4             	or     0xffffffc4(%ebp),%eax
     ebc:	89 45 ec             	mov    %eax,0xffffffec(%ebp)
                     (c + 10 - (islower(c) ? 'a' : 'A'));
                 c = *++cp;
     ebf:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     ec3:	8b 45 08             	mov    0x8(%ebp),%eax
     ec6:	0f b6 00             	movzbl (%eax),%eax
     ec9:	88 45 fb             	mov    %al,0xfffffffb(%ebp)
             } else
             break;
         }
     ecc:	e9 1a ff ff ff       	jmp    deb <inet_aton+0x7b>
         if (c == '.') {
     ed1:	80 7d fb 2e          	cmpb   $0x2e,0xfffffffb(%ebp)
     ed5:	75 35                	jne    f0c <inet_aton+0x19c>
             /*
              * Internet format:
              *  a.b.c.d
              *  a.b.c   (with c treated as 16 bits)
              *  a.b (with b treated as 24 bits)
              */
             if (pp >= parts + 3)
     ed7:	8d 45 dc             	lea    0xffffffdc(%ebp),%eax
     eda:	83 c0 0c             	add    $0xc,%eax
     edd:	3b 45 fc             	cmp    0xfffffffc(%ebp),%eax
     ee0:	77 0c                	ja     eee <inet_aton+0x17e>
                 return (0);
     ee2:	c7 45 c0 00 00 00 00 	movl   $0x0,0xffffffc0(%ebp)
     ee9:	e9 2b 01 00 00       	jmp    1019 <inet_aton+0x2a9>
             *pp++ = val;
     eee:	8b 55 fc             	mov    0xfffffffc(%ebp),%edx
     ef1:	8b 45 ec             	mov    0xffffffec(%ebp),%eax
     ef4:	89 02                	mov    %eax,(%edx)
     ef6:	83 45 fc 04          	addl   $0x4,0xfffffffc(%ebp)
             c = *++cp;
     efa:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     efe:	8b 45 08             	mov    0x8(%ebp),%eax
     f01:	0f b6 00             	movzbl (%eax),%eax
     f04:	88 45 fb             	mov    %al,0xfffffffb(%ebp)
         } else
             break;
     }
     f07:	e9 79 fe ff ff       	jmp    d85 <inet_aton+0x15>
     /*
      * Check for trailing characters.
      */
     if (c != '\0' && (!isascii(c) || !isspace(c)))
     f0c:	80 7d fb 00          	cmpb   $0x0,0xfffffffb(%ebp)
     f10:	74 3e                	je     f50 <inet_aton+0x1e0>
     f12:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
     f16:	3c 1f                	cmp    $0x1f,%al
     f18:	76 2a                	jbe    f44 <inet_aton+0x1d4>
     f1a:	80 7d fb 00          	cmpb   $0x0,0xfffffffb(%ebp)
     f1e:	78 24                	js     f44 <inet_aton+0x1d4>
     f20:	80 7d fb 20          	cmpb   $0x20,0xfffffffb(%ebp)
     f24:	74 2a                	je     f50 <inet_aton+0x1e0>
     f26:	80 7d fb 0c          	cmpb   $0xc,0xfffffffb(%ebp)
     f2a:	74 24                	je     f50 <inet_aton+0x1e0>
     f2c:	80 7d fb 0a          	cmpb   $0xa,0xfffffffb(%ebp)
     f30:	74 1e                	je     f50 <inet_aton+0x1e0>
     f32:	80 7d fb 0d          	cmpb   $0xd,0xfffffffb(%ebp)
     f36:	74 18                	je     f50 <inet_aton+0x1e0>
     f38:	80 7d fb 09          	cmpb   $0x9,0xfffffffb(%ebp)
     f3c:	74 12                	je     f50 <inet_aton+0x1e0>
     f3e:	80 7d fb 0b          	cmpb   $0xb,0xfffffffb(%ebp)
     f42:	74 0c                	je     f50 <inet_aton+0x1e0>
         return (0);
     f44:	c7 45 c0 00 00 00 00 	movl   $0x0,0xffffffc0(%ebp)
     f4b:	e9 c9 00 00 00       	jmp    1019 <inet_aton+0x2a9>
     /*
      * Concoct the address according to
      * the number of parts specified.
      */
     n = pp - parts + 1;
     f50:	8b 55 fc             	mov    0xfffffffc(%ebp),%edx
     f53:	8d 45 dc             	lea    0xffffffdc(%ebp),%eax
     f56:	89 d1                	mov    %edx,%ecx
     f58:	29 c1                	sub    %eax,%ecx
     f5a:	89 c8                	mov    %ecx,%eax
     f5c:	c1 f8 02             	sar    $0x2,%eax
     f5f:	83 c0 01             	add    $0x1,%eax
     f62:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
     switch (n) {
     f65:	83 7d f4 04          	cmpl   $0x4,0xfffffff4(%ebp)
     f69:	0f 87 8b 00 00 00    	ja     ffa <inet_aton+0x28a>
     f6f:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     f72:	c1 e0 02             	shl    $0x2,%eax
     f75:	8b 80 d8 11 00 00    	mov    0x11d8(%eax),%eax
     f7b:	ff e0                	jmp    *%eax

     case 0:
         return (0);     /* initial nondigit */
     f7d:	c7 45 c0 00 00 00 00 	movl   $0x0,0xffffffc0(%ebp)
     f84:	e9 90 00 00 00       	jmp    1019 <inet_aton+0x2a9>

     case 1:             /* a -- 32 bits */
         break;

     case 2:             /* a.b -- 8.24 bits */
         if (val > 0xffffff)
     f89:	81 7d ec ff ff ff 00 	cmpl   $0xffffff,0xffffffec(%ebp)
     f90:	76 09                	jbe    f9b <inet_aton+0x22b>
             return (0);
     f92:	c7 45 c0 00 00 00 00 	movl   $0x0,0xffffffc0(%ebp)
     f99:	eb 7e                	jmp    1019 <inet_aton+0x2a9>
         val |= parts[0] << 24;
     f9b:	8b 45 dc             	mov    0xffffffdc(%ebp),%eax
     f9e:	c1 e0 18             	shl    $0x18,%eax
     fa1:	09 45 ec             	or     %eax,0xffffffec(%ebp)
         break;
     fa4:	eb 54                	jmp    ffa <inet_aton+0x28a>

     case 3:             /* a.b.c -- 8.8.16 bits */
         if (val > 0xffff)
     fa6:	81 7d ec ff ff 00 00 	cmpl   $0xffff,0xffffffec(%ebp)
     fad:	76 09                	jbe    fb8 <inet_aton+0x248>
             return (0);
     faf:	c7 45 c0 00 00 00 00 	movl   $0x0,0xffffffc0(%ebp)
     fb6:	eb 61                	jmp    1019 <inet_aton+0x2a9>
         val |= (parts[0] << 24) | (parts[1] << 16);
     fb8:	8b 45 dc             	mov    0xffffffdc(%ebp),%eax
     fbb:	89 c2                	mov    %eax,%edx
     fbd:	c1 e2 18             	shl    $0x18,%edx
     fc0:	8b 45 e0             	mov    0xffffffe0(%ebp),%eax
     fc3:	c1 e0 10             	shl    $0x10,%eax
     fc6:	09 d0                	or     %edx,%eax
     fc8:	09 45 ec             	or     %eax,0xffffffec(%ebp)
         break;
     fcb:	eb 2d                	jmp    ffa <inet_aton+0x28a>

     case 4:             /* a.b.c.d -- 8.8.8.8 bits */
         if (val > 0xff)
     fcd:	81 7d ec ff 00 00 00 	cmpl   $0xff,0xffffffec(%ebp)
     fd4:	76 09                	jbe    fdf <inet_aton+0x26f>
             return (0);
     fd6:	c7 45 c0 00 00 00 00 	movl   $0x0,0xffffffc0(%ebp)
     fdd:	eb 3a                	jmp    1019 <inet_aton+0x2a9>
         val |= (parts[0] << 24) | (parts[1] << 16) | (parts[2] << 8);
     fdf:	8b 45 dc             	mov    0xffffffdc(%ebp),%eax
     fe2:	89 c2                	mov    %eax,%edx
     fe4:	c1 e2 18             	shl    $0x18,%edx
     fe7:	8b 45 e0             	mov    0xffffffe0(%ebp),%eax
     fea:	c1 e0 10             	shl    $0x10,%eax
     fed:	09 c2                	or     %eax,%edx
     fef:	8b 45 e4             	mov    0xffffffe4(%ebp),%eax
     ff2:	c1 e0 08             	shl    $0x8,%eax
     ff5:	09 d0                	or     %edx,%eax
     ff7:	09 45 ec             	or     %eax,0xffffffec(%ebp)
         break;
     }
     if (addr)
     ffa:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     ffe:	74 12                	je     1012 <inet_aton+0x2a2>
         addr->s_addr = htonl(val);
    1000:	8b 45 ec             	mov    0xffffffec(%ebp),%eax
    1003:	89 04 24             	mov    %eax,(%esp)
    1006:	e8 65 01 00 00       	call   1170 <htonl>
    100b:	89 c2                	mov    %eax,%edx
    100d:	8b 45 0c             	mov    0xc(%ebp),%eax
    1010:	89 10                	mov    %edx,(%eax)
     return (1);
    1012:	c7 45 c0 01 00 00 00 	movl   $0x1,0xffffffc0(%ebp)
    1019:	8b 45 c0             	mov    0xffffffc0(%ebp),%eax
 }
    101c:	c9                   	leave  
    101d:	c3                   	ret    
    101e:	89 f6                	mov    %esi,%esi

00001020 <inet_ntoa>:

/* Convert numeric IP address into decimal dotted ASCII representation.
 * returns ptr to static buffer; not reentrant!
 */
char *inet_ntoa(struct in_addr addr)
{
    1020:	55                   	push   %ebp
    1021:	89 e5                	mov    %esp,%ebp
    1023:	53                   	push   %ebx
    1024:	83 ec 24             	sub    $0x24,%esp
  static char str[16];
  u32_t s_addr = addr.s_addr;
    1027:	8b 45 08             	mov    0x8(%ebp),%eax
    102a:	89 45 ec             	mov    %eax,0xffffffec(%ebp)
  char inv[3];
  char *rp;
  char *ap;
  u8_t rem;
  u8_t n;
  u8_t i;

  rp = str;
    102d:	c7 45 f0 0c 12 00 00 	movl   $0x120c,0xfffffff0(%ebp)
  ap = (u8_t *)&s_addr;
    1034:	8d 45 ec             	lea    0xffffffec(%ebp),%eax
    1037:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
  for(n = 0; n < 4; n++) {
    103a:	c6 45 fa 00          	movb   $0x0,0xfffffffa(%ebp)
    103e:	e9 af 00 00 00       	jmp    10f2 <inet_ntoa+0xd2>
    i = 0;
    1043:	c6 45 fb 00          	movb   $0x0,0xfffffffb(%ebp)
    do {
      rem = *ap % (u8_t)10;
    1047:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
    104a:	0f b6 08             	movzbl (%eax),%ecx
    104d:	b8 67 00 00 00       	mov    $0x67,%eax
    1052:	f6 e9                	imul   %cl
    1054:	66 c1 e8 08          	shr    $0x8,%ax
    1058:	89 c2                	mov    %eax,%edx
    105a:	c0 fa 02             	sar    $0x2,%dl
    105d:	89 c8                	mov    %ecx,%eax
    105f:	c0 f8 07             	sar    $0x7,%al
    1062:	89 d3                	mov    %edx,%ebx
    1064:	28 c3                	sub    %al,%bl
    1066:	88 5d db             	mov    %bl,0xffffffdb(%ebp)
    1069:	0f b6 45 db          	movzbl 0xffffffdb(%ebp),%eax
    106d:	c1 e0 02             	shl    $0x2,%eax
    1070:	02 45 db             	add    0xffffffdb(%ebp),%al
    1073:	01 c0                	add    %eax,%eax
    1075:	89 ca                	mov    %ecx,%edx
    1077:	28 c2                	sub    %al,%dl
    1079:	88 55 db             	mov    %dl,0xffffffdb(%ebp)
    107c:	0f b6 5d db          	movzbl 0xffffffdb(%ebp),%ebx
    1080:	88 5d f9             	mov    %bl,0xfffffff9(%ebp)
      *ap /= (u8_t)10;
    1083:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
    1086:	0f b6 08             	movzbl (%eax),%ecx
    1089:	b8 67 00 00 00       	mov    $0x67,%eax
    108e:	f6 e9                	imul   %cl
    1090:	66 c1 e8 08          	shr    $0x8,%ax
    1094:	89 c2                	mov    %eax,%edx
    1096:	c0 fa 02             	sar    $0x2,%dl
    1099:	89 c8                	mov    %ecx,%eax
    109b:	c0 f8 07             	sar    $0x7,%al
    109e:	28 c2                	sub    %al,%dl
    10a0:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
    10a3:	88 10                	mov    %dl,(%eax)
      inv[i++] = '0' + rem;
    10a5:	0f b6 55 fb          	movzbl 0xfffffffb(%ebp),%edx
    10a9:	0f b6 45 f9          	movzbl 0xfffffff9(%ebp),%eax
    10ad:	83 c0 30             	add    $0x30,%eax
    10b0:	88 44 15 e9          	mov    %al,0xffffffe9(%ebp,%edx,1)
    10b4:	80 45 fb 01          	addb   $0x1,0xfffffffb(%ebp)
    } while(*ap);
    10b8:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
    10bb:	0f b6 00             	movzbl (%eax),%eax
    10be:	84 c0                	test   %al,%al
    10c0:	75 85                	jne    1047 <inet_ntoa+0x27>
    while(i--)
    10c2:	eb 12                	jmp    10d6 <inet_ntoa+0xb6>
      *rp++ = inv[i];
    10c4:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
    10c8:	0f b6 54 05 e9       	movzbl 0xffffffe9(%ebp,%eax,1),%edx
    10cd:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
    10d0:	88 10                	mov    %dl,(%eax)
    10d2:	83 45 f0 01          	addl   $0x1,0xfffffff0(%ebp)
    10d6:	80 6d fb 01          	subb   $0x1,0xfffffffb(%ebp)
    10da:	80 7d fb ff          	cmpb   $0xff,0xfffffffb(%ebp)
    10de:	75 e4                	jne    10c4 <inet_ntoa+0xa4>
    *rp++ = '.';
    10e0:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
    10e3:	c6 00 2e             	movb   $0x2e,(%eax)
    10e6:	83 45 f0 01          	addl   $0x1,0xfffffff0(%ebp)
    ap++;
    10ea:	83 45 f4 01          	addl   $0x1,0xfffffff4(%ebp)
    10ee:	80 45 fa 01          	addb   $0x1,0xfffffffa(%ebp)
    10f2:	80 7d fa 03          	cmpb   $0x3,0xfffffffa(%ebp)
    10f6:	0f 86 47 ff ff ff    	jbe    1043 <inet_ntoa+0x23>
  }
  *--rp = 0;
    10fc:	83 6d f0 01          	subl   $0x1,0xfffffff0(%ebp)
    1100:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
    1103:	c6 00 00             	movb   $0x0,(%eax)
  return str;
    1106:	b8 0c 12 00 00       	mov    $0x120c,%eax
}
    110b:	83 c4 24             	add    $0x24,%esp
    110e:	5b                   	pop    %ebx
    110f:	5d                   	pop    %ebp
    1110:	c3                   	ret    
    1111:	eb 0d                	jmp    1120 <htons>
    1113:	90                   	nop    
    1114:	90                   	nop    
    1115:	90                   	nop    
    1116:	90                   	nop    
    1117:	90                   	nop    
    1118:	90                   	nop    
    1119:	90                   	nop    
    111a:	90                   	nop    
    111b:	90                   	nop    
    111c:	90                   	nop    
    111d:	90                   	nop    
    111e:	90                   	nop    
    111f:	90                   	nop    

00001120 <htons>:


#ifndef BYTE_ORDER
#error BYTE_ORDER is not defined
#endif
#if BYTE_ORDER == LITTLE_ENDIAN

u16_t
htons(u16_t n)
{
    1120:	55                   	push   %ebp
    1121:	89 e5                	mov    %esp,%ebp
    1123:	83 ec 04             	sub    $0x4,%esp
    1126:	8b 45 08             	mov    0x8(%ebp),%eax
    1129:	66 89 45 fc          	mov    %ax,0xfffffffc(%ebp)
  return ((n & 0xff) << 8) | ((n & 0xff00) >> 8);
    112d:	0f b7 45 fc          	movzwl 0xfffffffc(%ebp),%eax
    1131:	25 ff 00 00 00       	and    $0xff,%eax
    1136:	c1 e0 08             	shl    $0x8,%eax
    1139:	89 c2                	mov    %eax,%edx
    113b:	0f b7 45 fc          	movzwl 0xfffffffc(%ebp),%eax
    113f:	25 00 ff 00 00       	and    $0xff00,%eax
    1144:	c1 f8 08             	sar    $0x8,%eax
    1147:	09 d0                	or     %edx,%eax
    1149:	0f b7 c0             	movzwl %ax,%eax
}
    114c:	c9                   	leave  
    114d:	c3                   	ret    
    114e:	89 f6                	mov    %esi,%esi

00001150 <ntohs>:

u16_t
ntohs(u16_t n)
{
    1150:	55                   	push   %ebp
    1151:	89 e5                	mov    %esp,%ebp
    1153:	83 ec 08             	sub    $0x8,%esp
    1156:	8b 45 08             	mov    0x8(%ebp),%eax
    1159:	66 89 45 fc          	mov    %ax,0xfffffffc(%ebp)
  return htons(n);
    115d:	0f b7 45 fc          	movzwl 0xfffffffc(%ebp),%eax
    1161:	89 04 24             	mov    %eax,(%esp)
    1164:	e8 b7 ff ff ff       	call   1120 <htons>
    1169:	0f b7 c0             	movzwl %ax,%eax
}
    116c:	c9                   	leave  
    116d:	c3                   	ret    
    116e:	89 f6                	mov    %esi,%esi

00001170 <htonl>:

u32_t
htonl(u32_t n)
{
    1170:	55                   	push   %ebp
    1171:	89 e5                	mov    %esp,%ebp
  return ((n & 0xff) << 24) |
    1173:	0f b6 45 08          	movzbl 0x8(%ebp),%eax
    1177:	89 c2                	mov    %eax,%edx
    1179:	c1 e2 18             	shl    $0x18,%edx
    117c:	8b 45 08             	mov    0x8(%ebp),%eax
    117f:	25 00 ff 00 00       	and    $0xff00,%eax
    1184:	c1 e0 08             	shl    $0x8,%eax
    1187:	09 c2                	or     %eax,%edx
    1189:	8b 45 08             	mov    0x8(%ebp),%eax
    118c:	25 00 00 ff 00       	and    $0xff0000,%eax
    1191:	c1 e8 08             	shr    $0x8,%eax
    1194:	09 c2                	or     %eax,%edx
    1196:	8b 45 08             	mov    0x8(%ebp),%eax
    1199:	25 00 00 00 ff       	and    $0xff000000,%eax
    119e:	c1 e8 18             	shr    $0x18,%eax
    11a1:	09 d0                	or     %edx,%eax
    ((n & 0xff00) << 8) |
    ((n & 0xff0000) >> 8) |
    ((n & 0xff000000) >> 24);
}
    11a3:	5d                   	pop    %ebp
    11a4:	c3                   	ret    
    11a5:	8d 74 26 00          	lea    0x0(%esi),%esi
    11a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

000011b0 <ntohl>:

u32_t
ntohl(u32_t n)
{
    11b0:	55                   	push   %ebp
    11b1:	89 e5                	mov    %esp,%ebp
    11b3:	83 ec 04             	sub    $0x4,%esp
  return htonl(n);
    11b6:	8b 45 08             	mov    0x8(%ebp),%eax
    11b9:	89 04 24             	mov    %eax,(%esp)
    11bc:	e8 af ff ff ff       	call   1170 <htonl>
}
    11c1:	c9                   	leave  
    11c2:	c3                   	ret    
