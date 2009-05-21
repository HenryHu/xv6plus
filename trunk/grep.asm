
_grep:     file format elf32-i386-freebsd

Disassembly of section .text:

00000000 <grep>:
int match(char*, char*);

void
grep(char *pattern, int fd)
{
       0:	55                   	push   %ebp
       1:	89 e5                	mov    %esp,%ebp
       3:	83 ec 28             	sub    $0x28,%esp
  int n, m;
  char *p, *q;
  
  m = 0;
       6:	c7 45 f4 00 00 00 00 	movl   $0x0,0xfffffff4(%ebp)
  while((n = read(fd, buf+m, sizeof(buf)-m)) > 0){
       d:	e9 bf 00 00 00       	jmp    d1 <grep+0xd1>
    m += n;
      12:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
      15:	01 45 f4             	add    %eax,0xfffffff4(%ebp)
    p = buf;
      18:	c7 45 f8 60 14 00 00 	movl   $0x1460,0xfffffff8(%ebp)
    while((q = strchr(p, '\n')) != 0){
      1f:	eb 53                	jmp    74 <grep+0x74>
      *q = 0;
      21:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
      24:	c6 00 00             	movb   $0x0,(%eax)
      if(match(pattern, p)){
      27:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
      2a:	89 44 24 04          	mov    %eax,0x4(%esp)
      2e:	8b 45 08             	mov    0x8(%ebp),%eax
      31:	89 04 24             	mov    %eax,(%esp)
      34:	e8 c7 01 00 00       	call   200 <match>
      39:	85 c0                	test   %eax,%eax
      3b:	74 2e                	je     6b <grep+0x6b>
        *q = '\n';
      3d:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
      40:	c6 00 0a             	movb   $0xa,(%eax)
        write(1, p, q+1 - p);
      43:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
      46:	83 c0 01             	add    $0x1,%eax
      49:	89 c2                	mov    %eax,%edx
      4b:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
      4e:	89 d1                	mov    %edx,%ecx
      50:	29 c1                	sub    %eax,%ecx
      52:	89 c8                	mov    %ecx,%eax
      54:	89 44 24 08          	mov    %eax,0x8(%esp)
      58:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
      5b:	89 44 24 04          	mov    %eax,0x4(%esp)
      5f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
      66:	e8 e9 05 00 00       	call   654 <write>
      }
      p = q+1;
      6b:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
      6e:	83 c0 01             	add    $0x1,%eax
      71:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
      74:	c7 44 24 04 0a 00 00 	movl   $0xa,0x4(%esp)
      7b:	00 
      7c:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
      7f:	89 04 24             	mov    %eax,(%esp)
      82:	e8 09 04 00 00       	call   490 <strchr>
      87:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
      8a:	83 7d fc 00          	cmpl   $0x0,0xfffffffc(%ebp)
      8e:	75 91                	jne    21 <grep+0x21>
    }
    if(p == buf)
      90:	81 7d f8 60 14 00 00 	cmpl   $0x1460,0xfffffff8(%ebp)
      97:	75 07                	jne    a0 <grep+0xa0>
      m = 0;
      99:	c7 45 f4 00 00 00 00 	movl   $0x0,0xfffffff4(%ebp)
    if(m > 0){
      a0:	83 7d f4 00          	cmpl   $0x0,0xfffffff4(%ebp)
      a4:	7e 2b                	jle    d1 <grep+0xd1>
      m -= p - buf;
      a6:	8b 55 f8             	mov    0xfffffff8(%ebp),%edx
      a9:	b8 60 14 00 00       	mov    $0x1460,%eax
      ae:	89 d1                	mov    %edx,%ecx
      b0:	29 c1                	sub    %eax,%ecx
      b2:	89 c8                	mov    %ecx,%eax
      b4:	29 45 f4             	sub    %eax,0xfffffff4(%ebp)
      memmove(buf, p, m);
      b7:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
      ba:	89 44 24 08          	mov    %eax,0x8(%esp)
      be:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
      c1:	89 44 24 04          	mov    %eax,0x4(%esp)
      c5:	c7 04 24 60 14 00 00 	movl   $0x1460,(%esp)
      cc:	e8 1f 05 00 00       	call   5f0 <memmove>
      d1:	8b 55 f4             	mov    0xfffffff4(%ebp),%edx
      d4:	b8 00 04 00 00       	mov    $0x400,%eax
      d9:	29 d0                	sub    %edx,%eax
      db:	89 c2                	mov    %eax,%edx
      dd:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
      e0:	05 60 14 00 00       	add    $0x1460,%eax
      e5:	89 54 24 08          	mov    %edx,0x8(%esp)
      e9:	89 44 24 04          	mov    %eax,0x4(%esp)
      ed:	8b 45 0c             	mov    0xc(%ebp),%eax
      f0:	89 04 24             	mov    %eax,(%esp)
      f3:	e8 54 05 00 00       	call   64c <read>
      f8:	89 45 f0             	mov    %eax,0xfffffff0(%ebp)
      fb:	83 7d f0 00          	cmpl   $0x0,0xfffffff0(%ebp)
      ff:	0f 8f 0d ff ff ff    	jg     12 <grep+0x12>
    }
  }
}
     105:	c9                   	leave  
     106:	c3                   	ret    
     107:	89 f6                	mov    %esi,%esi
     109:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

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
  char *pattern;
  
  if(argc <= 1){
     124:	8b 45 e8             	mov    0xffffffe8(%ebp),%eax
     127:	83 38 01             	cmpl   $0x1,(%eax)
     12a:	7f 19                	jg     145 <main+0x35>
    printf(2, "usage: grep pattern [file ...]\n");
     12c:	c7 44 24 04 c4 13 00 	movl   $0x13c4,0x4(%esp)
     133:	00 
     134:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     13b:	e8 00 07 00 00       	call   840 <printf>
    exit();
     140:	e8 ef 04 00 00       	call   634 <exit>
  }
  pattern = argv[1];
     145:	8b 55 e8             	mov    0xffffffe8(%ebp),%edx
     148:	8b 42 04             	mov    0x4(%edx),%eax
     14b:	83 c0 04             	add    $0x4,%eax
     14e:	8b 00                	mov    (%eax),%eax
     150:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
  
  if(argc <= 2){
     153:	8b 45 e8             	mov    0xffffffe8(%ebp),%eax
     156:	83 38 02             	cmpl   $0x2,(%eax)
     159:	7f 18                	jg     173 <main+0x63>
    grep(pattern, 0);
     15b:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     162:	00 
     163:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     166:	89 04 24             	mov    %eax,(%esp)
     169:	e8 92 fe ff ff       	call   0 <grep>
    exit();
     16e:	e8 c1 04 00 00       	call   634 <exit>
  }

  for(i = 2; i < argc; i++){
     173:	c7 45 f4 02 00 00 00 	movl   $0x2,0xfffffff4(%ebp)
     17a:	eb 73                	jmp    1ef <main+0xdf>
    if((fd = open(argv[i], 0)) < 0){
     17c:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     17f:	c1 e0 02             	shl    $0x2,%eax
     182:	8b 55 e8             	mov    0xffffffe8(%ebp),%edx
     185:	03 42 04             	add    0x4(%edx),%eax
     188:	8b 00                	mov    (%eax),%eax
     18a:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     191:	00 
     192:	89 04 24             	mov    %eax,(%esp)
     195:	e8 da 04 00 00       	call   674 <open>
     19a:	89 45 f0             	mov    %eax,0xfffffff0(%ebp)
     19d:	83 7d f0 00          	cmpl   $0x0,0xfffffff0(%ebp)
     1a1:	79 2b                	jns    1ce <main+0xbe>
      printf(1, "grep: cannot open %s\n", argv[i]);
     1a3:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     1a6:	c1 e0 02             	shl    $0x2,%eax
     1a9:	8b 55 e8             	mov    0xffffffe8(%ebp),%edx
     1ac:	03 42 04             	add    0x4(%edx),%eax
     1af:	8b 00                	mov    (%eax),%eax
     1b1:	89 44 24 08          	mov    %eax,0x8(%esp)
     1b5:	c7 44 24 04 e4 13 00 	movl   $0x13e4,0x4(%esp)
     1bc:	00 
     1bd:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     1c4:	e8 77 06 00 00       	call   840 <printf>
      exit();
     1c9:	e8 66 04 00 00       	call   634 <exit>
    }
    grep(pattern, fd);
     1ce:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
     1d1:	89 44 24 04          	mov    %eax,0x4(%esp)
     1d5:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     1d8:	89 04 24             	mov    %eax,(%esp)
     1db:	e8 20 fe ff ff       	call   0 <grep>
    close(fd);
     1e0:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
     1e3:	89 04 24             	mov    %eax,(%esp)
     1e6:	e8 71 04 00 00       	call   65c <close>
     1eb:	83 45 f4 01          	addl   $0x1,0xfffffff4(%ebp)
     1ef:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     1f2:	8b 55 e8             	mov    0xffffffe8(%ebp),%edx
     1f5:	3b 02                	cmp    (%edx),%eax
     1f7:	7c 83                	jl     17c <main+0x6c>
  }
  exit();
     1f9:	e8 36 04 00 00       	call   634 <exit>
     1fe:	89 f6                	mov    %esi,%esi

00000200 <match>:
}

// Regexp matcher from Kernighan & Pike,
// The Practice of Programming, Chapter 9.

int matchhere(char*, char*);
int matchstar(int, char*, char*);

int
match(char *re, char *text)
{
     200:	55                   	push   %ebp
     201:	89 e5                	mov    %esp,%ebp
     203:	83 ec 18             	sub    $0x18,%esp
  if(re[0] == '^')
     206:	8b 45 08             	mov    0x8(%ebp),%eax
     209:	0f b6 00             	movzbl (%eax),%eax
     20c:	3c 5e                	cmp    $0x5e,%al
     20e:	75 1a                	jne    22a <match+0x2a>
    return matchhere(re+1, text);
     210:	8b 45 08             	mov    0x8(%ebp),%eax
     213:	83 c0 01             	add    $0x1,%eax
     216:	8b 55 0c             	mov    0xc(%ebp),%edx
     219:	89 54 24 04          	mov    %edx,0x4(%esp)
     21d:	89 04 24             	mov    %eax,(%esp)
     220:	e8 4b 00 00 00       	call   270 <matchhere>
     225:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
     228:	eb 39                	jmp    263 <match+0x63>
  do{  // must look at empty string
    if(matchhere(re, text))
     22a:	8b 45 0c             	mov    0xc(%ebp),%eax
     22d:	89 44 24 04          	mov    %eax,0x4(%esp)
     231:	8b 45 08             	mov    0x8(%ebp),%eax
     234:	89 04 24             	mov    %eax,(%esp)
     237:	e8 34 00 00 00       	call   270 <matchhere>
     23c:	85 c0                	test   %eax,%eax
     23e:	74 09                	je     249 <match+0x49>
      return 1;
     240:	c7 45 fc 01 00 00 00 	movl   $0x1,0xfffffffc(%ebp)
     247:	eb 1a                	jmp    263 <match+0x63>
  }while(*text++ != '\0');
     249:	8b 45 0c             	mov    0xc(%ebp),%eax
     24c:	0f b6 00             	movzbl (%eax),%eax
     24f:	84 c0                	test   %al,%al
     251:	0f 95 c0             	setne  %al
     254:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
     258:	84 c0                	test   %al,%al
     25a:	75 ce                	jne    22a <match+0x2a>
  return 0;
     25c:	c7 45 fc 00 00 00 00 	movl   $0x0,0xfffffffc(%ebp)
     263:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
}
     266:	c9                   	leave  
     267:	c3                   	ret    
     268:	90                   	nop    
     269:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi

00000270 <matchhere>:

// matchhere: search for re at beginning of text
int matchhere(char *re, char *text)
{
     270:	55                   	push   %ebp
     271:	89 e5                	mov    %esp,%ebp
     273:	83 ec 18             	sub    $0x18,%esp
  if(re[0] == '\0')
     276:	8b 45 08             	mov    0x8(%ebp),%eax
     279:	0f b6 00             	movzbl (%eax),%eax
     27c:	84 c0                	test   %al,%al
     27e:	75 0c                	jne    28c <matchhere+0x1c>
    return 1;
     280:	c7 45 fc 01 00 00 00 	movl   $0x1,0xfffffffc(%ebp)
     287:	e9 a6 00 00 00       	jmp    332 <matchhere+0xc2>
  if(re[1] == '*')
     28c:	8b 45 08             	mov    0x8(%ebp),%eax
     28f:	83 c0 01             	add    $0x1,%eax
     292:	0f b6 00             	movzbl (%eax),%eax
     295:	3c 2a                	cmp    $0x2a,%al
     297:	75 27                	jne    2c0 <matchhere+0x50>
    return matchstar(re[0], re+2, text);
     299:	8b 4d 08             	mov    0x8(%ebp),%ecx
     29c:	83 c1 02             	add    $0x2,%ecx
     29f:	8b 45 08             	mov    0x8(%ebp),%eax
     2a2:	0f b6 00             	movzbl (%eax),%eax
     2a5:	0f be d0             	movsbl %al,%edx
     2a8:	8b 45 0c             	mov    0xc(%ebp),%eax
     2ab:	89 44 24 08          	mov    %eax,0x8(%esp)
     2af:	89 4c 24 04          	mov    %ecx,0x4(%esp)
     2b3:	89 14 24             	mov    %edx,(%esp)
     2b6:	e8 85 00 00 00       	call   340 <matchstar>
     2bb:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
     2be:	eb 72                	jmp    332 <matchhere+0xc2>
  if(re[0] == '$' && re[1] == '\0')
     2c0:	8b 45 08             	mov    0x8(%ebp),%eax
     2c3:	0f b6 00             	movzbl (%eax),%eax
     2c6:	3c 24                	cmp    $0x24,%al
     2c8:	75 20                	jne    2ea <matchhere+0x7a>
     2ca:	8b 45 08             	mov    0x8(%ebp),%eax
     2cd:	83 c0 01             	add    $0x1,%eax
     2d0:	0f b6 00             	movzbl (%eax),%eax
     2d3:	84 c0                	test   %al,%al
     2d5:	75 13                	jne    2ea <matchhere+0x7a>
    return *text == '\0';
     2d7:	8b 45 0c             	mov    0xc(%ebp),%eax
     2da:	0f b6 00             	movzbl (%eax),%eax
     2dd:	84 c0                	test   %al,%al
     2df:	0f 94 c0             	sete   %al
     2e2:	0f b6 c0             	movzbl %al,%eax
     2e5:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
     2e8:	eb 48                	jmp    332 <matchhere+0xc2>
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
     2ea:	8b 45 0c             	mov    0xc(%ebp),%eax
     2ed:	0f b6 00             	movzbl (%eax),%eax
     2f0:	84 c0                	test   %al,%al
     2f2:	74 37                	je     32b <matchhere+0xbb>
     2f4:	8b 45 08             	mov    0x8(%ebp),%eax
     2f7:	0f b6 00             	movzbl (%eax),%eax
     2fa:	3c 2e                	cmp    $0x2e,%al
     2fc:	74 10                	je     30e <matchhere+0x9e>
     2fe:	8b 45 08             	mov    0x8(%ebp),%eax
     301:	0f b6 10             	movzbl (%eax),%edx
     304:	8b 45 0c             	mov    0xc(%ebp),%eax
     307:	0f b6 00             	movzbl (%eax),%eax
     30a:	38 c2                	cmp    %al,%dl
     30c:	75 1d                	jne    32b <matchhere+0xbb>
    return matchhere(re+1, text+1);
     30e:	8b 45 0c             	mov    0xc(%ebp),%eax
     311:	83 c0 01             	add    $0x1,%eax
     314:	8b 55 08             	mov    0x8(%ebp),%edx
     317:	83 c2 01             	add    $0x1,%edx
     31a:	89 44 24 04          	mov    %eax,0x4(%esp)
     31e:	89 14 24             	mov    %edx,(%esp)
     321:	e8 4a ff ff ff       	call   270 <matchhere>
     326:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
     329:	eb 07                	jmp    332 <matchhere+0xc2>
  return 0;
     32b:	c7 45 fc 00 00 00 00 	movl   $0x0,0xfffffffc(%ebp)
     332:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
}
     335:	c9                   	leave  
     336:	c3                   	ret    
     337:	89 f6                	mov    %esi,%esi
     339:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00000340 <matchstar>:

// matchstar: search for c*re at beginning of text
int matchstar(int c, char *re, char *text)
{
     340:	55                   	push   %ebp
     341:	89 e5                	mov    %esp,%ebp
     343:	83 ec 18             	sub    $0x18,%esp
  do{  // a * matches zero or more instances
    if(matchhere(re, text))
     346:	8b 45 10             	mov    0x10(%ebp),%eax
     349:	89 44 24 04          	mov    %eax,0x4(%esp)
     34d:	8b 45 0c             	mov    0xc(%ebp),%eax
     350:	89 04 24             	mov    %eax,(%esp)
     353:	e8 18 ff ff ff       	call   270 <matchhere>
     358:	85 c0                	test   %eax,%eax
     35a:	74 09                	je     365 <matchstar+0x25>
      return 1;
     35c:	c7 45 fc 01 00 00 00 	movl   $0x1,0xfffffffc(%ebp)
     363:	eb 2e                	jmp    393 <matchstar+0x53>
  }while(*text!='\0' && (*text++==c || c=='.'));
     365:	8b 45 10             	mov    0x10(%ebp),%eax
     368:	0f b6 00             	movzbl (%eax),%eax
     36b:	84 c0                	test   %al,%al
     36d:	74 1d                	je     38c <matchstar+0x4c>
     36f:	8b 45 10             	mov    0x10(%ebp),%eax
     372:	0f b6 00             	movzbl (%eax),%eax
     375:	0f be c0             	movsbl %al,%eax
     378:	3b 45 08             	cmp    0x8(%ebp),%eax
     37b:	0f 94 c0             	sete   %al
     37e:	83 45 10 01          	addl   $0x1,0x10(%ebp)
     382:	84 c0                	test   %al,%al
     384:	75 c0                	jne    346 <matchstar+0x6>
     386:	83 7d 08 2e          	cmpl   $0x2e,0x8(%ebp)
     38a:	74 ba                	je     346 <matchstar+0x6>
  return 0;
     38c:	c7 45 fc 00 00 00 00 	movl   $0x0,0xfffffffc(%ebp)
     393:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
}
     396:	c9                   	leave  
     397:	c3                   	ret    
     398:	90                   	nop    
     399:	90                   	nop    
     39a:	90                   	nop    
     39b:	90                   	nop    
     39c:	90                   	nop    
     39d:	90                   	nop    
     39e:	90                   	nop    
     39f:	90                   	nop    

000003a0 <strcpy>:
#include "user.h"

char*
strcpy(char *s, char *t)
{
     3a0:	55                   	push   %ebp
     3a1:	89 e5                	mov    %esp,%ebp
     3a3:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
     3a6:	8b 45 08             	mov    0x8(%ebp),%eax
     3a9:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
  while((*s++ = *t++) != 0)
     3ac:	8b 45 0c             	mov    0xc(%ebp),%eax
     3af:	0f b6 10             	movzbl (%eax),%edx
     3b2:	8b 45 08             	mov    0x8(%ebp),%eax
     3b5:	88 10                	mov    %dl,(%eax)
     3b7:	8b 45 08             	mov    0x8(%ebp),%eax
     3ba:	0f b6 00             	movzbl (%eax),%eax
     3bd:	84 c0                	test   %al,%al
     3bf:	0f 95 c0             	setne  %al
     3c2:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     3c6:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
     3ca:	84 c0                	test   %al,%al
     3cc:	75 de                	jne    3ac <strcpy+0xc>
    ;
  return os;
     3ce:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
}
     3d1:	c9                   	leave  
     3d2:	c3                   	ret    
     3d3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     3d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

000003e0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     3e0:	55                   	push   %ebp
     3e1:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
     3e3:	eb 08                	jmp    3ed <strcmp+0xd>
    p++, q++;
     3e5:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     3e9:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
     3ed:	8b 45 08             	mov    0x8(%ebp),%eax
     3f0:	0f b6 00             	movzbl (%eax),%eax
     3f3:	84 c0                	test   %al,%al
     3f5:	74 10                	je     407 <strcmp+0x27>
     3f7:	8b 45 08             	mov    0x8(%ebp),%eax
     3fa:	0f b6 10             	movzbl (%eax),%edx
     3fd:	8b 45 0c             	mov    0xc(%ebp),%eax
     400:	0f b6 00             	movzbl (%eax),%eax
     403:	38 c2                	cmp    %al,%dl
     405:	74 de                	je     3e5 <strcmp+0x5>
  return (uchar)*p - (uchar)*q;
     407:	8b 45 08             	mov    0x8(%ebp),%eax
     40a:	0f b6 00             	movzbl (%eax),%eax
     40d:	0f b6 d0             	movzbl %al,%edx
     410:	8b 45 0c             	mov    0xc(%ebp),%eax
     413:	0f b6 00             	movzbl (%eax),%eax
     416:	0f b6 c0             	movzbl %al,%eax
     419:	89 d1                	mov    %edx,%ecx
     41b:	29 c1                	sub    %eax,%ecx
     41d:	89 c8                	mov    %ecx,%eax
}
     41f:	5d                   	pop    %ebp
     420:	c3                   	ret    
     421:	eb 0d                	jmp    430 <strlen>
     423:	90                   	nop    
     424:	90                   	nop    
     425:	90                   	nop    
     426:	90                   	nop    
     427:	90                   	nop    
     428:	90                   	nop    
     429:	90                   	nop    
     42a:	90                   	nop    
     42b:	90                   	nop    
     42c:	90                   	nop    
     42d:	90                   	nop    
     42e:	90                   	nop    
     42f:	90                   	nop    

00000430 <strlen>:

uint
strlen(char *s)
{
     430:	55                   	push   %ebp
     431:	89 e5                	mov    %esp,%ebp
     433:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
     436:	c7 45 fc 00 00 00 00 	movl   $0x0,0xfffffffc(%ebp)
     43d:	eb 04                	jmp    443 <strlen+0x13>
     43f:	83 45 fc 01          	addl   $0x1,0xfffffffc(%ebp)
     443:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     446:	03 45 08             	add    0x8(%ebp),%eax
     449:	0f b6 00             	movzbl (%eax),%eax
     44c:	84 c0                	test   %al,%al
     44e:	75 ef                	jne    43f <strlen+0xf>
    ;
  return n;
     450:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
}
     453:	c9                   	leave  
     454:	c3                   	ret    
     455:	8d 74 26 00          	lea    0x0(%esi),%esi
     459:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00000460 <memset>:

void*
memset(void *dst, int c, uint n)
{
     460:	55                   	push   %ebp
     461:	89 e5                	mov    %esp,%ebp
     463:	83 ec 10             	sub    $0x10,%esp
  char *d;
  
  d = dst;
     466:	8b 45 08             	mov    0x8(%ebp),%eax
     469:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
  while(n-- > 0)
     46c:	eb 0e                	jmp    47c <memset+0x1c>
    *d++ = c;
     46e:	8b 45 0c             	mov    0xc(%ebp),%eax
     471:	89 c2                	mov    %eax,%edx
     473:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     476:	88 10                	mov    %dl,(%eax)
     478:	83 45 fc 01          	addl   $0x1,0xfffffffc(%ebp)
     47c:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
     480:	83 7d 10 ff          	cmpl   $0xffffffff,0x10(%ebp)
     484:	75 e8                	jne    46e <memset+0xe>
  return dst;
     486:	8b 45 08             	mov    0x8(%ebp),%eax
}
     489:	c9                   	leave  
     48a:	c3                   	ret    
     48b:	90                   	nop    
     48c:	8d 74 26 00          	lea    0x0(%esi),%esi

00000490 <strchr>:

char*
strchr(const char *s, char c)
{
     490:	55                   	push   %ebp
     491:	89 e5                	mov    %esp,%ebp
     493:	83 ec 08             	sub    $0x8,%esp
     496:	8b 45 0c             	mov    0xc(%ebp),%eax
     499:	88 45 fc             	mov    %al,0xfffffffc(%ebp)
  for(; *s; s++)
     49c:	eb 17                	jmp    4b5 <strchr+0x25>
    if(*s == c)
     49e:	8b 45 08             	mov    0x8(%ebp),%eax
     4a1:	0f b6 00             	movzbl (%eax),%eax
     4a4:	3a 45 fc             	cmp    0xfffffffc(%ebp),%al
     4a7:	75 08                	jne    4b1 <strchr+0x21>
      return (char*) s;
     4a9:	8b 45 08             	mov    0x8(%ebp),%eax
     4ac:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
     4af:	eb 15                	jmp    4c6 <strchr+0x36>
     4b1:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     4b5:	8b 45 08             	mov    0x8(%ebp),%eax
     4b8:	0f b6 00             	movzbl (%eax),%eax
     4bb:	84 c0                	test   %al,%al
     4bd:	75 df                	jne    49e <strchr+0xe>
  return 0;
     4bf:	c7 45 f8 00 00 00 00 	movl   $0x0,0xfffffff8(%ebp)
     4c6:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
}
     4c9:	c9                   	leave  
     4ca:	c3                   	ret    
     4cb:	90                   	nop    
     4cc:	8d 74 26 00          	lea    0x0(%esi),%esi

000004d0 <gets>:

char*
gets(char *buf, int max)
{
     4d0:	55                   	push   %ebp
     4d1:	89 e5                	mov    %esp,%ebp
     4d3:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     4d6:	c7 45 f8 00 00 00 00 	movl   $0x0,0xfffffff8(%ebp)
     4dd:	eb 46                	jmp    525 <gets+0x55>
    cc = read(0, &c, 1);
     4df:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
     4e6:	00 
     4e7:	8d 45 f7             	lea    0xfffffff7(%ebp),%eax
     4ea:	89 44 24 04          	mov    %eax,0x4(%esp)
     4ee:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     4f5:	e8 52 01 00 00       	call   64c <read>
     4fa:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
    if(cc < 1)
     4fd:	83 7d fc 00          	cmpl   $0x0,0xfffffffc(%ebp)
     501:	7e 2d                	jle    530 <gets+0x60>
      break;
    buf[i++] = c;
     503:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     506:	89 c2                	mov    %eax,%edx
     508:	03 55 08             	add    0x8(%ebp),%edx
     50b:	0f b6 45 f7          	movzbl 0xfffffff7(%ebp),%eax
     50f:	88 02                	mov    %al,(%edx)
     511:	83 45 f8 01          	addl   $0x1,0xfffffff8(%ebp)
    if(c == '\n' || c == '\r')
     515:	0f b6 45 f7          	movzbl 0xfffffff7(%ebp),%eax
     519:	3c 0a                	cmp    $0xa,%al
     51b:	74 13                	je     530 <gets+0x60>
     51d:	0f b6 45 f7          	movzbl 0xfffffff7(%ebp),%eax
     521:	3c 0d                	cmp    $0xd,%al
     523:	74 0b                	je     530 <gets+0x60>
     525:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     528:	83 c0 01             	add    $0x1,%eax
     52b:	3b 45 0c             	cmp    0xc(%ebp),%eax
     52e:	7c af                	jl     4df <gets+0xf>
      break;
  }
  buf[i] = '\0';
     530:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     533:	03 45 08             	add    0x8(%ebp),%eax
     536:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
     539:	8b 45 08             	mov    0x8(%ebp),%eax
}
     53c:	c9                   	leave  
     53d:	c3                   	ret    
     53e:	89 f6                	mov    %esi,%esi

00000540 <stat>:

int
stat(char *n, struct stat *st)
{
     540:	55                   	push   %ebp
     541:	89 e5                	mov    %esp,%ebp
     543:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     546:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     54d:	00 
     54e:	8b 45 08             	mov    0x8(%ebp),%eax
     551:	89 04 24             	mov    %eax,(%esp)
     554:	e8 1b 01 00 00       	call   674 <open>
     559:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
  if(fd < 0)
     55c:	83 7d f8 00          	cmpl   $0x0,0xfffffff8(%ebp)
     560:	79 09                	jns    56b <stat+0x2b>
    return -1;
     562:	c7 45 ec ff ff ff ff 	movl   $0xffffffff,0xffffffec(%ebp)
     569:	eb 26                	jmp    591 <stat+0x51>
  r = fstat(fd, st);
     56b:	8b 45 0c             	mov    0xc(%ebp),%eax
     56e:	89 44 24 04          	mov    %eax,0x4(%esp)
     572:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     575:	89 04 24             	mov    %eax,(%esp)
     578:	e8 0f 01 00 00       	call   68c <fstat>
     57d:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
  close(fd);
     580:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     583:	89 04 24             	mov    %eax,(%esp)
     586:	e8 d1 00 00 00       	call   65c <close>
  return r;
     58b:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     58e:	89 45 ec             	mov    %eax,0xffffffec(%ebp)
     591:	8b 45 ec             	mov    0xffffffec(%ebp),%eax
}
     594:	c9                   	leave  
     595:	c3                   	ret    
     596:	8d 76 00             	lea    0x0(%esi),%esi
     599:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

000005a0 <atoi>:

int
atoi(const char *s)
{
     5a0:	55                   	push   %ebp
     5a1:	89 e5                	mov    %esp,%ebp
     5a3:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
     5a6:	c7 45 fc 00 00 00 00 	movl   $0x0,0xfffffffc(%ebp)
  while('0' <= *s && *s <= '9')
     5ad:	eb 24                	jmp    5d3 <atoi+0x33>
    n = n*10 + *s++ - '0';
     5af:	8b 55 fc             	mov    0xfffffffc(%ebp),%edx
     5b2:	89 d0                	mov    %edx,%eax
     5b4:	c1 e0 02             	shl    $0x2,%eax
     5b7:	01 d0                	add    %edx,%eax
     5b9:	01 c0                	add    %eax,%eax
     5bb:	89 c2                	mov    %eax,%edx
     5bd:	8b 45 08             	mov    0x8(%ebp),%eax
     5c0:	0f b6 00             	movzbl (%eax),%eax
     5c3:	0f be c0             	movsbl %al,%eax
     5c6:	8d 04 02             	lea    (%edx,%eax,1),%eax
     5c9:	83 e8 30             	sub    $0x30,%eax
     5cc:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
     5cf:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     5d3:	8b 45 08             	mov    0x8(%ebp),%eax
     5d6:	0f b6 00             	movzbl (%eax),%eax
     5d9:	3c 2f                	cmp    $0x2f,%al
     5db:	7e 0a                	jle    5e7 <atoi+0x47>
     5dd:	8b 45 08             	mov    0x8(%ebp),%eax
     5e0:	0f b6 00             	movzbl (%eax),%eax
     5e3:	3c 39                	cmp    $0x39,%al
     5e5:	7e c8                	jle    5af <atoi+0xf>
  return n;
     5e7:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
}
     5ea:	c9                   	leave  
     5eb:	c3                   	ret    
     5ec:	8d 74 26 00          	lea    0x0(%esi),%esi

000005f0 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
     5f0:	55                   	push   %ebp
     5f1:	89 e5                	mov    %esp,%ebp
     5f3:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
     5f6:	8b 45 08             	mov    0x8(%ebp),%eax
     5f9:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
  src = vsrc;
     5fc:	8b 45 0c             	mov    0xc(%ebp),%eax
     5ff:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
  while(n-- > 0)
     602:	eb 13                	jmp    617 <memmove+0x27>
    *dst++ = *src++;
     604:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     607:	0f b6 10             	movzbl (%eax),%edx
     60a:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     60d:	88 10                	mov    %dl,(%eax)
     60f:	83 45 f8 01          	addl   $0x1,0xfffffff8(%ebp)
     613:	83 45 fc 01          	addl   $0x1,0xfffffffc(%ebp)
     617:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     61b:	0f 9f c0             	setg   %al
     61e:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
     622:	84 c0                	test   %al,%al
     624:	75 de                	jne    604 <memmove+0x14>
  return vdst;
     626:	8b 45 08             	mov    0x8(%ebp),%eax
}
     629:	c9                   	leave  
     62a:	c3                   	ret    
     62b:	90                   	nop    

0000062c <fork>:
     62c:	b8 01 00 00 00       	mov    $0x1,%eax
     631:	cd 30                	int    $0x30
     633:	c3                   	ret    

00000634 <exit>:
     634:	b8 02 00 00 00       	mov    $0x2,%eax
     639:	cd 30                	int    $0x30
     63b:	c3                   	ret    

0000063c <wait>:
     63c:	b8 03 00 00 00       	mov    $0x3,%eax
     641:	cd 30                	int    $0x30
     643:	c3                   	ret    

00000644 <pipe>:
     644:	b8 04 00 00 00       	mov    $0x4,%eax
     649:	cd 30                	int    $0x30
     64b:	c3                   	ret    

0000064c <read>:
     64c:	b8 06 00 00 00       	mov    $0x6,%eax
     651:	cd 30                	int    $0x30
     653:	c3                   	ret    

00000654 <write>:
     654:	b8 05 00 00 00       	mov    $0x5,%eax
     659:	cd 30                	int    $0x30
     65b:	c3                   	ret    

0000065c <close>:
     65c:	b8 07 00 00 00       	mov    $0x7,%eax
     661:	cd 30                	int    $0x30
     663:	c3                   	ret    

00000664 <kill>:
     664:	b8 08 00 00 00       	mov    $0x8,%eax
     669:	cd 30                	int    $0x30
     66b:	c3                   	ret    

0000066c <exec>:
     66c:	b8 09 00 00 00       	mov    $0x9,%eax
     671:	cd 30                	int    $0x30
     673:	c3                   	ret    

00000674 <open>:
     674:	b8 0a 00 00 00       	mov    $0xa,%eax
     679:	cd 30                	int    $0x30
     67b:	c3                   	ret    

0000067c <mknod>:
     67c:	b8 0b 00 00 00       	mov    $0xb,%eax
     681:	cd 30                	int    $0x30
     683:	c3                   	ret    

00000684 <unlink>:
     684:	b8 0c 00 00 00       	mov    $0xc,%eax
     689:	cd 30                	int    $0x30
     68b:	c3                   	ret    

0000068c <fstat>:
     68c:	b8 0d 00 00 00       	mov    $0xd,%eax
     691:	cd 30                	int    $0x30
     693:	c3                   	ret    

00000694 <link>:
     694:	b8 0e 00 00 00       	mov    $0xe,%eax
     699:	cd 30                	int    $0x30
     69b:	c3                   	ret    

0000069c <mkdir>:
     69c:	b8 0f 00 00 00       	mov    $0xf,%eax
     6a1:	cd 30                	int    $0x30
     6a3:	c3                   	ret    

000006a4 <chdir>:
     6a4:	b8 10 00 00 00       	mov    $0x10,%eax
     6a9:	cd 30                	int    $0x30
     6ab:	c3                   	ret    

000006ac <dup>:
     6ac:	b8 11 00 00 00       	mov    $0x11,%eax
     6b1:	cd 30                	int    $0x30
     6b3:	c3                   	ret    

000006b4 <getpid>:
     6b4:	b8 12 00 00 00       	mov    $0x12,%eax
     6b9:	cd 30                	int    $0x30
     6bb:	c3                   	ret    

000006bc <sbrk>:
     6bc:	b8 13 00 00 00       	mov    $0x13,%eax
     6c1:	cd 30                	int    $0x30
     6c3:	c3                   	ret    

000006c4 <sleep>:
     6c4:	b8 14 00 00 00       	mov    $0x14,%eax
     6c9:	cd 30                	int    $0x30
     6cb:	c3                   	ret    

000006cc <upmsec>:
     6cc:	b8 15 00 00 00       	mov    $0x15,%eax
     6d1:	cd 30                	int    $0x30
     6d3:	c3                   	ret    

000006d4 <socket>:
     6d4:	b8 16 00 00 00       	mov    $0x16,%eax
     6d9:	cd 30                	int    $0x30
     6db:	c3                   	ret    

000006dc <bind>:
     6dc:	b8 17 00 00 00       	mov    $0x17,%eax
     6e1:	cd 30                	int    $0x30
     6e3:	c3                   	ret    

000006e4 <listen>:
     6e4:	b8 18 00 00 00       	mov    $0x18,%eax
     6e9:	cd 30                	int    $0x30
     6eb:	c3                   	ret    

000006ec <accept>:
     6ec:	b8 19 00 00 00       	mov    $0x19,%eax
     6f1:	cd 30                	int    $0x30
     6f3:	c3                   	ret    

000006f4 <recv>:
     6f4:	b8 1a 00 00 00       	mov    $0x1a,%eax
     6f9:	cd 30                	int    $0x30
     6fb:	c3                   	ret    

000006fc <recvfrom>:
     6fc:	b8 1b 00 00 00       	mov    $0x1b,%eax
     701:	cd 30                	int    $0x30
     703:	c3                   	ret    

00000704 <send>:
     704:	b8 1c 00 00 00       	mov    $0x1c,%eax
     709:	cd 30                	int    $0x30
     70b:	c3                   	ret    

0000070c <sendto>:
     70c:	b8 1d 00 00 00       	mov    $0x1d,%eax
     711:	cd 30                	int    $0x30
     713:	c3                   	ret    

00000714 <shutdown>:
     714:	b8 1e 00 00 00       	mov    $0x1e,%eax
     719:	cd 30                	int    $0x30
     71b:	c3                   	ret    

0000071c <getsockopt>:
     71c:	b8 1f 00 00 00       	mov    $0x1f,%eax
     721:	cd 30                	int    $0x30
     723:	c3                   	ret    

00000724 <setsockopt>:
     724:	b8 20 00 00 00       	mov    $0x20,%eax
     729:	cd 30                	int    $0x30
     72b:	c3                   	ret    

0000072c <sockclose>:
     72c:	b8 21 00 00 00       	mov    $0x21,%eax
     731:	cd 30                	int    $0x30
     733:	c3                   	ret    

00000734 <connect>:
     734:	b8 22 00 00 00       	mov    $0x22,%eax
     739:	cd 30                	int    $0x30
     73b:	c3                   	ret    

0000073c <getpeername>:
     73c:	b8 23 00 00 00       	mov    $0x23,%eax
     741:	cd 30                	int    $0x30
     743:	c3                   	ret    

00000744 <getsockname>:
     744:	b8 24 00 00 00       	mov    $0x24,%eax
     749:	cd 30                	int    $0x30
     74b:	c3                   	ret    
     74c:	90                   	nop    
     74d:	90                   	nop    
     74e:	90                   	nop    
     74f:	90                   	nop    

00000750 <putc>:
#include "user.h"

void
putc(int fd, char c)
{
     750:	55                   	push   %ebp
     751:	89 e5                	mov    %esp,%ebp
     753:	83 ec 18             	sub    $0x18,%esp
     756:	8b 45 0c             	mov    0xc(%ebp),%eax
     759:	88 45 fc             	mov    %al,0xfffffffc(%ebp)
  write(fd, &c, 1);
     75c:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
     763:	00 
     764:	8d 45 fc             	lea    0xfffffffc(%ebp),%eax
     767:	89 44 24 04          	mov    %eax,0x4(%esp)
     76b:	8b 45 08             	mov    0x8(%ebp),%eax
     76e:	89 04 24             	mov    %eax,(%esp)
     771:	e8 de fe ff ff       	call   654 <write>
}
     776:	c9                   	leave  
     777:	c3                   	ret    
     778:	90                   	nop    
     779:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi

00000780 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     780:	55                   	push   %ebp
     781:	89 e5                	mov    %esp,%ebp
     783:	53                   	push   %ebx
     784:	83 ec 34             	sub    $0x34,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     787:	c7 45 f4 00 00 00 00 	movl   $0x0,0xfffffff4(%ebp)
  if(sgn && xx < 0){
     78e:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
     792:	74 17                	je     7ab <printint+0x2b>
     794:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     798:	79 11                	jns    7ab <printint+0x2b>
    neg = 1;
     79a:	c7 45 f4 01 00 00 00 	movl   $0x1,0xfffffff4(%ebp)
    x = -xx;
     7a1:	8b 45 0c             	mov    0xc(%ebp),%eax
     7a4:	f7 d8                	neg    %eax
     7a6:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
     7a9:	eb 06                	jmp    7b1 <printint+0x31>
  } else {
    x = xx;
     7ab:	8b 45 0c             	mov    0xc(%ebp),%eax
     7ae:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
  }

  i = 0;
     7b1:	c7 45 f0 00 00 00 00 	movl   $0x0,0xfffffff0(%ebp)
  do{
    buf[i++] = digits[x % base];
     7b8:	8b 4d f0             	mov    0xfffffff0(%ebp),%ecx
     7bb:	8b 55 10             	mov    0x10(%ebp),%edx
     7be:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     7c1:	89 d3                	mov    %edx,%ebx
     7c3:	ba 00 00 00 00       	mov    $0x0,%edx
     7c8:	f7 f3                	div    %ebx
     7ca:	89 d0                	mov    %edx,%eax
     7cc:	0f b6 80 18 14 00 00 	movzbl 0x1418(%eax),%eax
     7d3:	88 44 0d e0          	mov    %al,0xffffffe0(%ebp,%ecx,1)
     7d7:	83 45 f0 01          	addl   $0x1,0xfffffff0(%ebp)
  }while((x /= base) != 0);
     7db:	8b 55 10             	mov    0x10(%ebp),%edx
     7de:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     7e1:	89 d1                	mov    %edx,%ecx
     7e3:	ba 00 00 00 00       	mov    $0x0,%edx
     7e8:	f7 f1                	div    %ecx
     7ea:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
     7ed:	83 7d f8 00          	cmpl   $0x0,0xfffffff8(%ebp)
     7f1:	75 c5                	jne    7b8 <printint+0x38>
  if(neg)
     7f3:	83 7d f4 00          	cmpl   $0x0,0xfffffff4(%ebp)
     7f7:	74 28                	je     821 <printint+0xa1>
    buf[i++] = '-';
     7f9:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
     7fc:	c6 44 05 e0 2d       	movb   $0x2d,0xffffffe0(%ebp,%eax,1)
     801:	83 45 f0 01          	addl   $0x1,0xfffffff0(%ebp)

  while(--i >= 0)
     805:	eb 1a                	jmp    821 <printint+0xa1>
    putc(fd, buf[i]);
     807:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
     80a:	0f b6 44 05 e0       	movzbl 0xffffffe0(%ebp,%eax,1),%eax
     80f:	0f be c0             	movsbl %al,%eax
     812:	89 44 24 04          	mov    %eax,0x4(%esp)
     816:	8b 45 08             	mov    0x8(%ebp),%eax
     819:	89 04 24             	mov    %eax,(%esp)
     81c:	e8 2f ff ff ff       	call   750 <putc>
     821:	83 6d f0 01          	subl   $0x1,0xfffffff0(%ebp)
     825:	83 7d f0 00          	cmpl   $0x0,0xfffffff0(%ebp)
     829:	79 dc                	jns    807 <printint+0x87>
}
     82b:	83 c4 34             	add    $0x34,%esp
     82e:	5b                   	pop    %ebx
     82f:	5d                   	pop    %ebp
     830:	c3                   	ret    
     831:	eb 0d                	jmp    840 <printf>
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

00000840 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
     840:	55                   	push   %ebp
     841:	89 e5                	mov    %esp,%ebp
     843:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
     846:	c7 45 f8 00 00 00 00 	movl   $0x0,0xfffffff8(%ebp)
  ap = (uint*)(void*)&fmt + 1;
     84d:	8d 45 0c             	lea    0xc(%ebp),%eax
     850:	83 c0 04             	add    $0x4,%eax
     853:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
  for(i = 0; fmt[i]; i++){
     856:	c7 45 f4 00 00 00 00 	movl   $0x0,0xfffffff4(%ebp)
     85d:	e9 7b 01 00 00       	jmp    9dd <printf+0x19d>
    c = fmt[i] & 0xff;
     862:	8b 55 0c             	mov    0xc(%ebp),%edx
     865:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     868:	8d 04 02             	lea    (%edx,%eax,1),%eax
     86b:	0f b6 00             	movzbl (%eax),%eax
     86e:	0f be c0             	movsbl %al,%eax
     871:	25 ff 00 00 00       	and    $0xff,%eax
     876:	89 45 f0             	mov    %eax,0xfffffff0(%ebp)
    if(state == 0){
     879:	83 7d f8 00          	cmpl   $0x0,0xfffffff8(%ebp)
     87d:	75 2c                	jne    8ab <printf+0x6b>
      if(c == '%'){
     87f:	83 7d f0 25          	cmpl   $0x25,0xfffffff0(%ebp)
     883:	75 0c                	jne    891 <printf+0x51>
        state = '%';
     885:	c7 45 f8 25 00 00 00 	movl   $0x25,0xfffffff8(%ebp)
     88c:	e9 48 01 00 00       	jmp    9d9 <printf+0x199>
      } else {
        putc(fd, c);
     891:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
     894:	0f be c0             	movsbl %al,%eax
     897:	89 44 24 04          	mov    %eax,0x4(%esp)
     89b:	8b 45 08             	mov    0x8(%ebp),%eax
     89e:	89 04 24             	mov    %eax,(%esp)
     8a1:	e8 aa fe ff ff       	call   750 <putc>
     8a6:	e9 2e 01 00 00       	jmp    9d9 <printf+0x199>
      }
    } else if(state == '%'){
     8ab:	83 7d f8 25          	cmpl   $0x25,0xfffffff8(%ebp)
     8af:	0f 85 24 01 00 00    	jne    9d9 <printf+0x199>
      if(c == 'd'){
     8b5:	83 7d f0 64          	cmpl   $0x64,0xfffffff0(%ebp)
     8b9:	75 2d                	jne    8e8 <printf+0xa8>
        printint(fd, *ap, 10, 1);
     8bb:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     8be:	8b 00                	mov    (%eax),%eax
     8c0:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
     8c7:	00 
     8c8:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
     8cf:	00 
     8d0:	89 44 24 04          	mov    %eax,0x4(%esp)
     8d4:	8b 45 08             	mov    0x8(%ebp),%eax
     8d7:	89 04 24             	mov    %eax,(%esp)
     8da:	e8 a1 fe ff ff       	call   780 <printint>
        ap++;
     8df:	83 45 fc 04          	addl   $0x4,0xfffffffc(%ebp)
     8e3:	e9 ea 00 00 00       	jmp    9d2 <printf+0x192>
      } else if(c == 'x' || c == 'p'){
     8e8:	83 7d f0 78          	cmpl   $0x78,0xfffffff0(%ebp)
     8ec:	74 06                	je     8f4 <printf+0xb4>
     8ee:	83 7d f0 70          	cmpl   $0x70,0xfffffff0(%ebp)
     8f2:	75 2d                	jne    921 <printf+0xe1>
        printint(fd, *ap, 16, 0);
     8f4:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     8f7:	8b 00                	mov    (%eax),%eax
     8f9:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
     900:	00 
     901:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
     908:	00 
     909:	89 44 24 04          	mov    %eax,0x4(%esp)
     90d:	8b 45 08             	mov    0x8(%ebp),%eax
     910:	89 04 24             	mov    %eax,(%esp)
     913:	e8 68 fe ff ff       	call   780 <printint>
        ap++;
     918:	83 45 fc 04          	addl   $0x4,0xfffffffc(%ebp)
     91c:	e9 b1 00 00 00       	jmp    9d2 <printf+0x192>
      } else if(c == 's'){
     921:	83 7d f0 73          	cmpl   $0x73,0xfffffff0(%ebp)
     925:	75 43                	jne    96a <printf+0x12a>
        s = (char*)*ap;
     927:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     92a:	8b 00                	mov    (%eax),%eax
     92c:	89 45 ec             	mov    %eax,0xffffffec(%ebp)
        ap++;
     92f:	83 45 fc 04          	addl   $0x4,0xfffffffc(%ebp)
        if(s == 0)
     933:	83 7d ec 00          	cmpl   $0x0,0xffffffec(%ebp)
     937:	75 25                	jne    95e <printf+0x11e>
          s = "(null)";
     939:	c7 45 ec fa 13 00 00 	movl   $0x13fa,0xffffffec(%ebp)
        while(*s != 0){
     940:	eb 1c                	jmp    95e <printf+0x11e>
          putc(fd, *s);
     942:	8b 45 ec             	mov    0xffffffec(%ebp),%eax
     945:	0f b6 00             	movzbl (%eax),%eax
     948:	0f be c0             	movsbl %al,%eax
     94b:	89 44 24 04          	mov    %eax,0x4(%esp)
     94f:	8b 45 08             	mov    0x8(%ebp),%eax
     952:	89 04 24             	mov    %eax,(%esp)
     955:	e8 f6 fd ff ff       	call   750 <putc>
          s++;
     95a:	83 45 ec 01          	addl   $0x1,0xffffffec(%ebp)
     95e:	8b 45 ec             	mov    0xffffffec(%ebp),%eax
     961:	0f b6 00             	movzbl (%eax),%eax
     964:	84 c0                	test   %al,%al
     966:	75 da                	jne    942 <printf+0x102>
     968:	eb 68                	jmp    9d2 <printf+0x192>
        }
      } else if(c == 'c'){
     96a:	83 7d f0 63          	cmpl   $0x63,0xfffffff0(%ebp)
     96e:	75 1d                	jne    98d <printf+0x14d>
        putc(fd, *ap);
     970:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     973:	8b 00                	mov    (%eax),%eax
     975:	0f be c0             	movsbl %al,%eax
     978:	89 44 24 04          	mov    %eax,0x4(%esp)
     97c:	8b 45 08             	mov    0x8(%ebp),%eax
     97f:	89 04 24             	mov    %eax,(%esp)
     982:	e8 c9 fd ff ff       	call   750 <putc>
        ap++;
     987:	83 45 fc 04          	addl   $0x4,0xfffffffc(%ebp)
     98b:	eb 45                	jmp    9d2 <printf+0x192>
      } else if(c == '%'){
     98d:	83 7d f0 25          	cmpl   $0x25,0xfffffff0(%ebp)
     991:	75 17                	jne    9aa <printf+0x16a>
        putc(fd, c);
     993:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
     996:	0f be c0             	movsbl %al,%eax
     999:	89 44 24 04          	mov    %eax,0x4(%esp)
     99d:	8b 45 08             	mov    0x8(%ebp),%eax
     9a0:	89 04 24             	mov    %eax,(%esp)
     9a3:	e8 a8 fd ff ff       	call   750 <putc>
     9a8:	eb 28                	jmp    9d2 <printf+0x192>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     9aa:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
     9b1:	00 
     9b2:	8b 45 08             	mov    0x8(%ebp),%eax
     9b5:	89 04 24             	mov    %eax,(%esp)
     9b8:	e8 93 fd ff ff       	call   750 <putc>
        putc(fd, c);
     9bd:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
     9c0:	0f be c0             	movsbl %al,%eax
     9c3:	89 44 24 04          	mov    %eax,0x4(%esp)
     9c7:	8b 45 08             	mov    0x8(%ebp),%eax
     9ca:	89 04 24             	mov    %eax,(%esp)
     9cd:	e8 7e fd ff ff       	call   750 <putc>
      }
      state = 0;
     9d2:	c7 45 f8 00 00 00 00 	movl   $0x0,0xfffffff8(%ebp)
     9d9:	83 45 f4 01          	addl   $0x1,0xfffffff4(%ebp)
     9dd:	8b 55 0c             	mov    0xc(%ebp),%edx
     9e0:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     9e3:	8d 04 02             	lea    (%edx,%eax,1),%eax
     9e6:	0f b6 00             	movzbl (%eax),%eax
     9e9:	84 c0                	test   %al,%al
     9eb:	0f 85 71 fe ff ff    	jne    862 <printf+0x22>
    }
  }
}
     9f1:	c9                   	leave  
     9f2:	c3                   	ret    
     9f3:	90                   	nop    
     9f4:	90                   	nop    
     9f5:	90                   	nop    
     9f6:	90                   	nop    
     9f7:	90                   	nop    
     9f8:	90                   	nop    
     9f9:	90                   	nop    
     9fa:	90                   	nop    
     9fb:	90                   	nop    
     9fc:	90                   	nop    
     9fd:	90                   	nop    
     9fe:	90                   	nop    
     9ff:	90                   	nop    

00000a00 <free>:
static Header *freep;

void
free(void *ap)
{
     a00:	55                   	push   %ebp
     a01:	89 e5                	mov    %esp,%ebp
     a03:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*) ap - 1;
     a06:	8b 45 08             	mov    0x8(%ebp),%eax
     a09:	83 e8 08             	sub    $0x8,%eax
     a0c:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     a0f:	a1 48 14 00 00       	mov    0x1448,%eax
     a14:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
     a17:	eb 24                	jmp    a3d <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     a19:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     a1c:	8b 00                	mov    (%eax),%eax
     a1e:	3b 45 fc             	cmp    0xfffffffc(%ebp),%eax
     a21:	77 12                	ja     a35 <free+0x35>
     a23:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     a26:	3b 45 fc             	cmp    0xfffffffc(%ebp),%eax
     a29:	77 24                	ja     a4f <free+0x4f>
     a2b:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     a2e:	8b 00                	mov    (%eax),%eax
     a30:	3b 45 f8             	cmp    0xfffffff8(%ebp),%eax
     a33:	77 1a                	ja     a4f <free+0x4f>
     a35:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     a38:	8b 00                	mov    (%eax),%eax
     a3a:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
     a3d:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     a40:	3b 45 fc             	cmp    0xfffffffc(%ebp),%eax
     a43:	76 d4                	jbe    a19 <free+0x19>
     a45:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     a48:	8b 00                	mov    (%eax),%eax
     a4a:	3b 45 f8             	cmp    0xfffffff8(%ebp),%eax
     a4d:	76 ca                	jbe    a19 <free+0x19>
      break;
  if(bp + bp->s.size == p->s.ptr){
     a4f:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     a52:	8b 40 04             	mov    0x4(%eax),%eax
     a55:	c1 e0 03             	shl    $0x3,%eax
     a58:	89 c2                	mov    %eax,%edx
     a5a:	03 55 f8             	add    0xfffffff8(%ebp),%edx
     a5d:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     a60:	8b 00                	mov    (%eax),%eax
     a62:	39 c2                	cmp    %eax,%edx
     a64:	75 24                	jne    a8a <free+0x8a>
    bp->s.size += p->s.ptr->s.size;
     a66:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     a69:	8b 50 04             	mov    0x4(%eax),%edx
     a6c:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     a6f:	8b 00                	mov    (%eax),%eax
     a71:	8b 40 04             	mov    0x4(%eax),%eax
     a74:	01 c2                	add    %eax,%edx
     a76:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     a79:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
     a7c:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     a7f:	8b 00                	mov    (%eax),%eax
     a81:	8b 10                	mov    (%eax),%edx
     a83:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     a86:	89 10                	mov    %edx,(%eax)
     a88:	eb 0a                	jmp    a94 <free+0x94>
  } else
    bp->s.ptr = p->s.ptr;
     a8a:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     a8d:	8b 10                	mov    (%eax),%edx
     a8f:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     a92:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
     a94:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     a97:	8b 40 04             	mov    0x4(%eax),%eax
     a9a:	c1 e0 03             	shl    $0x3,%eax
     a9d:	03 45 fc             	add    0xfffffffc(%ebp),%eax
     aa0:	3b 45 f8             	cmp    0xfffffff8(%ebp),%eax
     aa3:	75 20                	jne    ac5 <free+0xc5>
    p->s.size += bp->s.size;
     aa5:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     aa8:	8b 50 04             	mov    0x4(%eax),%edx
     aab:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     aae:	8b 40 04             	mov    0x4(%eax),%eax
     ab1:	01 c2                	add    %eax,%edx
     ab3:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     ab6:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
     ab9:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     abc:	8b 10                	mov    (%eax),%edx
     abe:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     ac1:	89 10                	mov    %edx,(%eax)
     ac3:	eb 08                	jmp    acd <free+0xcd>
  } else
    p->s.ptr = bp;
     ac5:	8b 55 fc             	mov    0xfffffffc(%ebp),%edx
     ac8:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     acb:	89 02                	mov    %eax,(%edx)
  freep = p;
     acd:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     ad0:	a3 48 14 00 00       	mov    %eax,0x1448
}
     ad5:	c9                   	leave  
     ad6:	c3                   	ret    
     ad7:	89 f6                	mov    %esi,%esi
     ad9:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00000ae0 <morecore>:

static Header*
morecore(uint nu)
{
     ae0:	55                   	push   %ebp
     ae1:	89 e5                	mov    %esp,%ebp
     ae3:	83 ec 18             	sub    $0x18,%esp
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
     ae6:	8b 45 08             	mov    0x8(%ebp),%eax
     ae9:	c1 e0 03             	shl    $0x3,%eax
     aec:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
  size += PAGE - size % PAGE;
     aef:	8b 55 fc             	mov    0xfffffffc(%ebp),%edx
     af2:	89 d0                	mov    %edx,%eax
     af4:	c1 f8 1f             	sar    $0x1f,%eax
     af7:	89 c1                	mov    %eax,%ecx
     af9:	c1 e9 14             	shr    $0x14,%ecx
     afc:	8d 04 0a             	lea    (%edx,%ecx,1),%eax
     aff:	25 ff 0f 00 00       	and    $0xfff,%eax
     b04:	29 c8                	sub    %ecx,%eax
     b06:	89 c2                	mov    %eax,%edx
     b08:	b8 00 10 00 00       	mov    $0x1000,%eax
     b0d:	29 d0                	sub    %edx,%eax
     b0f:	01 45 fc             	add    %eax,0xfffffffc(%ebp)
#endif
#ifdef UMALLOC_DEBUG
  printf(1, "size: %d\n", size);
#endif
  p = sbrk(size);
     b12:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     b15:	89 04 24             	mov    %eax,(%esp)
     b18:	e8 9f fb ff ff       	call   6bc <sbrk>
     b1d:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
  if(p == (char*) -1)
     b20:	83 7d f4 ff          	cmpl   $0xffffffff,0xfffffff4(%ebp)
     b24:	75 09                	jne    b2f <morecore+0x4f>
    return 0;
     b26:	c7 45 ec 00 00 00 00 	movl   $0x0,0xffffffec(%ebp)
     b2d:	eb 2a                	jmp    b59 <morecore+0x79>
  hp = (Header*)p;
     b2f:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     b32:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
#ifdef UMALLOC_NOALIGN
  hp->s.size = nu;
#else
  hp->s.size = size / sizeof(Header);
     b35:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     b38:	89 c2                	mov    %eax,%edx
     b3a:	c1 ea 03             	shr    $0x3,%edx
     b3d:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     b40:	89 50 04             	mov    %edx,0x4(%eax)
#endif
  free((void*)(hp + 1));
     b43:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     b46:	83 c0 08             	add    $0x8,%eax
     b49:	89 04 24             	mov    %eax,(%esp)
     b4c:	e8 af fe ff ff       	call   a00 <free>
  return freep;
     b51:	a1 48 14 00 00       	mov    0x1448,%eax
     b56:	89 45 ec             	mov    %eax,0xffffffec(%ebp)
     b59:	8b 45 ec             	mov    0xffffffec(%ebp),%eax
}
     b5c:	c9                   	leave  
     b5d:	c3                   	ret    
     b5e:	89 f6                	mov    %esi,%esi

00000b60 <malloc>:

void*
malloc(uint nbytes)
{
     b60:	55                   	push   %ebp
     b61:	89 e5                	mov    %esp,%ebp
     b63:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

#ifdef UMALLOC_DEBUG
  printf(1, "malloc: %d bytes\n", nbytes);
  printf(1, "size of Header: %d\n", sizeof(Header));
#endif
  if (PAGE % sizeof(Header))
      printf(2, "Warning! align failed! Need UMALLOC_NOALIGN\n");
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     b66:	8b 45 08             	mov    0x8(%ebp),%eax
     b69:	83 c0 07             	add    $0x7,%eax
     b6c:	c1 e8 03             	shr    $0x3,%eax
     b6f:	83 c0 01             	add    $0x1,%eax
     b72:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
  if((prevp = freep) == 0){
     b75:	a1 48 14 00 00       	mov    0x1448,%eax
     b7a:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
     b7d:	83 7d f8 00          	cmpl   $0x0,0xfffffff8(%ebp)
     b81:	75 23                	jne    ba6 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
     b83:	c7 45 f8 40 14 00 00 	movl   $0x1440,0xfffffff8(%ebp)
     b8a:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     b8d:	a3 48 14 00 00       	mov    %eax,0x1448
     b92:	a1 48 14 00 00       	mov    0x1448,%eax
     b97:	a3 40 14 00 00       	mov    %eax,0x1440
    base.s.size = 0;
     b9c:	c7 05 44 14 00 00 00 	movl   $0x0,0x1444
     ba3:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     ba6:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     ba9:	8b 00                	mov    (%eax),%eax
     bab:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
    if(p->s.size >= nunits){
     bae:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     bb1:	8b 40 04             	mov    0x4(%eax),%eax
     bb4:	3b 45 fc             	cmp    0xfffffffc(%ebp),%eax
     bb7:	72 50                	jb     c09 <malloc+0xa9>
      if(p->s.size == nunits)
     bb9:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     bbc:	8b 40 04             	mov    0x4(%eax),%eax
     bbf:	3b 45 fc             	cmp    0xfffffffc(%ebp),%eax
     bc2:	75 0c                	jne    bd0 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
     bc4:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     bc7:	8b 10                	mov    (%eax),%edx
     bc9:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     bcc:	89 10                	mov    %edx,(%eax)
     bce:	eb 26                	jmp    bf6 <malloc+0x96>
      else {
        p->s.size -= nunits;
     bd0:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     bd3:	8b 40 04             	mov    0x4(%eax),%eax
     bd6:	89 c2                	mov    %eax,%edx
     bd8:	2b 55 fc             	sub    0xfffffffc(%ebp),%edx
     bdb:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     bde:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
     be1:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     be4:	8b 40 04             	mov    0x4(%eax),%eax
     be7:	c1 e0 03             	shl    $0x3,%eax
     bea:	01 45 f4             	add    %eax,0xfffffff4(%ebp)
        p->s.size = nunits;
     bed:	8b 55 f4             	mov    0xfffffff4(%ebp),%edx
     bf0:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     bf3:	89 42 04             	mov    %eax,0x4(%edx)
      }
      freep = prevp;
     bf6:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     bf9:	a3 48 14 00 00       	mov    %eax,0x1448
      return (void*) (p + 1);
     bfe:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     c01:	83 c0 08             	add    $0x8,%eax
     c04:	89 45 ec             	mov    %eax,0xffffffec(%ebp)
     c07:	eb 3a                	jmp    c43 <malloc+0xe3>
    }
    if(p == freep)
     c09:	a1 48 14 00 00       	mov    0x1448,%eax
     c0e:	39 45 f4             	cmp    %eax,0xfffffff4(%ebp)
     c11:	75 1d                	jne    c30 <malloc+0xd0>
      if((p = morecore(nunits)) == 0)
     c13:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     c16:	89 04 24             	mov    %eax,(%esp)
     c19:	e8 c2 fe ff ff       	call   ae0 <morecore>
     c1e:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
     c21:	83 7d f4 00          	cmpl   $0x0,0xfffffff4(%ebp)
     c25:	75 09                	jne    c30 <malloc+0xd0>
        return 0;
     c27:	c7 45 ec 00 00 00 00 	movl   $0x0,0xffffffec(%ebp)
     c2e:	eb 13                	jmp    c43 <malloc+0xe3>
     c30:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     c33:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
     c36:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     c39:	8b 00                	mov    (%eax),%eax
     c3b:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
  }
     c3e:	e9 6b ff ff ff       	jmp    bae <malloc+0x4e>
     c43:	8b 45 ec             	mov    0xffffffec(%ebp),%eax
}
     c46:	c9                   	leave  
     c47:	c3                   	ret    
     c48:	90                   	nop    
     c49:	90                   	nop    
     c4a:	90                   	nop    
     c4b:	90                   	nop    
     c4c:	90                   	nop    
     c4d:	90                   	nop    
     c4e:	90                   	nop    
     c4f:	90                   	nop    

00000c50 <lwip_chksum>:


static u16_t
lwip_chksum(void *dataptr, int len)
{
     c50:	55                   	push   %ebp
     c51:	89 e5                	mov    %esp,%ebp
     c53:	83 ec 18             	sub    $0x18,%esp
  u32_t acc;

  LWIP_DEBUGF(INET_DEBUG, ("lwip_chksum(%p, %d)\n", (void *)dataptr, len));
  for(acc = 0; len > 1; len -= 2) {
     c56:	c7 45 fc 00 00 00 00 	movl   $0x0,0xfffffffc(%ebp)
     c5d:	eb 19                	jmp    c78 <lwip_chksum+0x28>
      /*    acc = acc + *((u16_t *)dataptr)++;*/
    acc += *(u16_t *)dataptr;
     c5f:	8b 45 08             	mov    0x8(%ebp),%eax
     c62:	0f b7 00             	movzwl (%eax),%eax
     c65:	0f b7 c0             	movzwl %ax,%eax
     c68:	01 45 fc             	add    %eax,0xfffffffc(%ebp)
    dataptr = (void *)((u16_t *)dataptr + 1);
     c6b:	8b 45 08             	mov    0x8(%ebp),%eax
     c6e:	83 c0 02             	add    $0x2,%eax
     c71:	89 45 08             	mov    %eax,0x8(%ebp)
     c74:	83 6d 0c 02          	subl   $0x2,0xc(%ebp)
     c78:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
     c7c:	7f e1                	jg     c5f <lwip_chksum+0xf>
  }

  /* add up any odd byte */
  if (len == 1) {
     c7e:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
     c82:	75 1d                	jne    ca1 <lwip_chksum+0x51>
    acc += htons((u16_t)((*(u8_t *)dataptr) & 0xff) << 8);
     c84:	8b 45 08             	mov    0x8(%ebp),%eax
     c87:	0f b6 00             	movzbl (%eax),%eax
     c8a:	0f b6 c0             	movzbl %al,%eax
     c8d:	c1 e0 08             	shl    $0x8,%eax
     c90:	0f b7 c0             	movzwl %ax,%eax
     c93:	89 04 24             	mov    %eax,(%esp)
     c96:	e8 85 06 00 00       	call   1320 <htons>
     c9b:	0f b7 c0             	movzwl %ax,%eax
     c9e:	01 45 fc             	add    %eax,0xfffffffc(%ebp)
    LWIP_DEBUGF(INET_DEBUG, ("inet: chksum: odd byte %d\n", (unsigned int)(*(u8_t *)dataptr)));
  } else {
    LWIP_DEBUGF(INET_DEBUG, ("inet: chksum: no odd byte\n"));
  }
  acc = (acc >> 16) + (acc & 0xffffUL);
     ca1:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     ca4:	89 c2                	mov    %eax,%edx
     ca6:	c1 ea 10             	shr    $0x10,%edx
     ca9:	0f b7 45 fc          	movzwl 0xfffffffc(%ebp),%eax
     cad:	8d 04 02             	lea    (%edx,%eax,1),%eax
     cb0:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)

  if ((acc & 0xffff0000) != 0) {
     cb3:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     cb6:	66 b8 00 00          	mov    $0x0,%ax
     cba:	85 c0                	test   %eax,%eax
     cbc:	74 12                	je     cd0 <lwip_chksum+0x80>
    acc = (acc >> 16) + (acc & 0xffffUL);
     cbe:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     cc1:	89 c2                	mov    %eax,%edx
     cc3:	c1 ea 10             	shr    $0x10,%edx
     cc6:	0f b7 45 fc          	movzwl 0xfffffffc(%ebp),%eax
     cca:	8d 04 02             	lea    (%edx,%eax,1),%eax
     ccd:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
  }

  return (u16_t)acc;
     cd0:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     cd3:	0f b7 c0             	movzwl %ax,%eax
}
     cd6:	c9                   	leave  
     cd7:	c3                   	ret    
     cd8:	90                   	nop    
     cd9:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi

00000ce0 <inet_chksum_pseudo>:

/* inet_chksum_pseudo:
 *
 * Calculates the pseudo Internet checksum used by TCP and UDP for a pbuf chain.
 */

u16_t
inet_chksum_pseudo(struct pbuf *p,
       struct ip_addr *src, struct ip_addr *dest,
       u8_t proto, u16_t proto_len)
{
     ce0:	55                   	push   %ebp
     ce1:	89 e5                	mov    %esp,%ebp
     ce3:	83 ec 28             	sub    $0x28,%esp
     ce6:	8b 45 14             	mov    0x14(%ebp),%eax
     ce9:	8b 55 18             	mov    0x18(%ebp),%edx
     cec:	88 45 ec             	mov    %al,0xffffffec(%ebp)
     cef:	66 89 55 e8          	mov    %dx,0xffffffe8(%ebp)
  u32_t acc;
  struct pbuf *q;
  u8_t swapped;

  acc = 0;
     cf3:	c7 45 f4 00 00 00 00 	movl   $0x0,0xfffffff4(%ebp)
  swapped = 0;
     cfa:	c6 45 ff 00          	movb   $0x0,0xffffffff(%ebp)
  /* iterate through all pbuf in chain */
  for(q = p; q != NULL; q = q->next) {
     cfe:	8b 45 08             	mov    0x8(%ebp),%eax
     d01:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
     d04:	eb 7b                	jmp    d81 <inet_chksum_pseudo+0xa1>
    LWIP_DEBUGF(INET_DEBUG, ("inet_chksum_pseudo(): checksumming pbuf %p (has next %p) \n",
      (void *)q, (void *)q->next));
    acc += lwip_chksum(q->payload, q->len);
     d06:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     d09:	0f b7 40 0a          	movzwl 0xa(%eax),%eax
     d0d:	0f b7 d0             	movzwl %ax,%edx
     d10:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     d13:	8b 40 04             	mov    0x4(%eax),%eax
     d16:	89 54 24 04          	mov    %edx,0x4(%esp)
     d1a:	89 04 24             	mov    %eax,(%esp)
     d1d:	e8 2e ff ff ff       	call   c50 <lwip_chksum>
     d22:	0f b7 c0             	movzwl %ax,%eax
     d25:	01 45 f4             	add    %eax,0xfffffff4(%ebp)
    /*LWIP_DEBUGF(INET_DEBUG, ("inet_chksum_pseudo(): unwrapped lwip_chksum()=%lx \n", acc));*/
    while (acc >> 16) {
     d28:	eb 10                	jmp    d3a <inet_chksum_pseudo+0x5a>
      acc = (acc & 0xffffUL) + (acc >> 16);
     d2a:	0f b7 55 f4          	movzwl 0xfffffff4(%ebp),%edx
     d2e:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     d31:	c1 e8 10             	shr    $0x10,%eax
     d34:	8d 04 02             	lea    (%edx,%eax,1),%eax
     d37:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
     d3a:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     d3d:	c1 e8 10             	shr    $0x10,%eax
     d40:	85 c0                	test   %eax,%eax
     d42:	75 e6                	jne    d2a <inet_chksum_pseudo+0x4a>
    }
    if (q->len % 2 != 0) {
     d44:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     d47:	0f b7 40 0a          	movzwl 0xa(%eax),%eax
     d4b:	0f b7 c0             	movzwl %ax,%eax
     d4e:	83 e0 01             	and    $0x1,%eax
     d51:	84 c0                	test   %al,%al
     d53:	74 24                	je     d79 <inet_chksum_pseudo+0x99>
      swapped = 1 - swapped;
     d55:	b8 01 00 00 00       	mov    $0x1,%eax
     d5a:	2a 45 ff             	sub    0xffffffff(%ebp),%al
     d5d:	88 45 ff             	mov    %al,0xffffffff(%ebp)
      acc = ((acc & 0xff) << 8) | ((acc & 0xff00UL) >> 8);
     d60:	0f b6 45 f4          	movzbl 0xfffffff4(%ebp),%eax
     d64:	89 c2                	mov    %eax,%edx
     d66:	c1 e2 08             	shl    $0x8,%edx
     d69:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     d6c:	25 00 ff 00 00       	and    $0xff00,%eax
     d71:	c1 e8 08             	shr    $0x8,%eax
     d74:	09 d0                	or     %edx,%eax
     d76:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
     d79:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     d7c:	8b 00                	mov    (%eax),%eax
     d7e:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
     d81:	83 7d f8 00          	cmpl   $0x0,0xfffffff8(%ebp)
     d85:	0f 85 7b ff ff ff    	jne    d06 <inet_chksum_pseudo+0x26>
    }
    /*LWIP_DEBUGF(INET_DEBUG, ("inet_chksum_pseudo(): wrapped lwip_chksum()=%lx \n", acc));*/
  }

  if (swapped) {
     d8b:	80 7d ff 00          	cmpb   $0x0,0xffffffff(%ebp)
     d8f:	74 19                	je     daa <inet_chksum_pseudo+0xca>
    acc = ((acc & 0xff) << 8) | ((acc & 0xff00UL) >> 8);
     d91:	0f b6 45 f4          	movzbl 0xfffffff4(%ebp),%eax
     d95:	89 c2                	mov    %eax,%edx
     d97:	c1 e2 08             	shl    $0x8,%edx
     d9a:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     d9d:	25 00 ff 00 00       	and    $0xff00,%eax
     da2:	c1 e8 08             	shr    $0x8,%eax
     da5:	09 d0                	or     %edx,%eax
     da7:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
  }
  acc += (src->addr & 0xffffUL);
     daa:	8b 45 0c             	mov    0xc(%ebp),%eax
     dad:	8b 00                	mov    (%eax),%eax
     daf:	25 ff ff 00 00       	and    $0xffff,%eax
     db4:	01 45 f4             	add    %eax,0xfffffff4(%ebp)
  acc += ((src->addr >> 16) & 0xffffUL);
     db7:	8b 45 0c             	mov    0xc(%ebp),%eax
     dba:	8b 00                	mov    (%eax),%eax
     dbc:	c1 e8 10             	shr    $0x10,%eax
     dbf:	25 ff ff 00 00       	and    $0xffff,%eax
     dc4:	01 45 f4             	add    %eax,0xfffffff4(%ebp)
  acc += (dest->addr & 0xffffUL);
     dc7:	8b 45 10             	mov    0x10(%ebp),%eax
     dca:	8b 00                	mov    (%eax),%eax
     dcc:	25 ff ff 00 00       	and    $0xffff,%eax
     dd1:	01 45 f4             	add    %eax,0xfffffff4(%ebp)
  acc += ((dest->addr >> 16) & 0xffffUL);
     dd4:	8b 45 10             	mov    0x10(%ebp),%eax
     dd7:	8b 00                	mov    (%eax),%eax
     dd9:	c1 e8 10             	shr    $0x10,%eax
     ddc:	25 ff ff 00 00       	and    $0xffff,%eax
     de1:	01 45 f4             	add    %eax,0xfffffff4(%ebp)
  acc += (u32_t)htons((u16_t)proto);
     de4:	0f b6 45 ec          	movzbl 0xffffffec(%ebp),%eax
     de8:	89 04 24             	mov    %eax,(%esp)
     deb:	e8 30 05 00 00       	call   1320 <htons>
     df0:	0f b7 c0             	movzwl %ax,%eax
     df3:	01 45 f4             	add    %eax,0xfffffff4(%ebp)
  acc += (u32_t)htons(proto_len);
     df6:	0f b7 45 e8          	movzwl 0xffffffe8(%ebp),%eax
     dfa:	89 04 24             	mov    %eax,(%esp)
     dfd:	e8 1e 05 00 00       	call   1320 <htons>
     e02:	0f b7 c0             	movzwl %ax,%eax
     e05:	01 45 f4             	add    %eax,0xfffffff4(%ebp)

  while (acc >> 16) {
     e08:	eb 10                	jmp    e1a <inet_chksum_pseudo+0x13a>
    acc = (acc & 0xffffUL) + (acc >> 16);
     e0a:	0f b7 55 f4          	movzwl 0xfffffff4(%ebp),%edx
     e0e:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     e11:	c1 e8 10             	shr    $0x10,%eax
     e14:	8d 04 02             	lea    (%edx,%eax,1),%eax
     e17:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
     e1a:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     e1d:	c1 e8 10             	shr    $0x10,%eax
     e20:	85 c0                	test   %eax,%eax
     e22:	75 e6                	jne    e0a <inet_chksum_pseudo+0x12a>
  }
  LWIP_DEBUGF(INET_DEBUG, ("inet_chksum_pseudo(): pbuf chain lwip_chksum()=%lx\n", acc));
  return ~(acc & 0xffffUL);
     e24:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     e27:	f7 d0                	not    %eax
     e29:	0f b7 c0             	movzwl %ax,%eax
}
     e2c:	c9                   	leave  
     e2d:	c3                   	ret    
     e2e:	89 f6                	mov    %esi,%esi

00000e30 <inet_chksum>:

/* inet_chksum:
 *
 * Calculates the Internet checksum over a portion of memory. Used primarely for IP
 * and ICMP.
 */

u16_t
inet_chksum(void *dataptr, u16_t len)
{
     e30:	55                   	push   %ebp
     e31:	89 e5                	mov    %esp,%ebp
     e33:	83 ec 28             	sub    $0x28,%esp
     e36:	8b 45 0c             	mov    0xc(%ebp),%eax
     e39:	66 89 45 ec          	mov    %ax,0xffffffec(%ebp)
  u32_t acc;

  acc = lwip_chksum(dataptr, len);
     e3d:	0f b7 45 ec          	movzwl 0xffffffec(%ebp),%eax
     e41:	89 44 24 04          	mov    %eax,0x4(%esp)
     e45:	8b 45 08             	mov    0x8(%ebp),%eax
     e48:	89 04 24             	mov    %eax,(%esp)
     e4b:	e8 00 fe ff ff       	call   c50 <lwip_chksum>
     e50:	0f b7 c0             	movzwl %ax,%eax
     e53:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
  while (acc >> 16) {
     e56:	eb 10                	jmp    e68 <inet_chksum+0x38>
    acc = (acc & 0xffff) + (acc >> 16);
     e58:	0f b7 55 fc          	movzwl 0xfffffffc(%ebp),%edx
     e5c:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     e5f:	c1 e8 10             	shr    $0x10,%eax
     e62:	8d 04 02             	lea    (%edx,%eax,1),%eax
     e65:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
     e68:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     e6b:	c1 e8 10             	shr    $0x10,%eax
     e6e:	85 c0                	test   %eax,%eax
     e70:	75 e6                	jne    e58 <inet_chksum+0x28>
  }
  return ~(acc & 0xffff);
     e72:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     e75:	f7 d0                	not    %eax
     e77:	0f b7 c0             	movzwl %ax,%eax
}
     e7a:	c9                   	leave  
     e7b:	c3                   	ret    
     e7c:	8d 74 26 00          	lea    0x0(%esi),%esi

00000e80 <inet_chksum_pbuf>:

u16_t
inet_chksum_pbuf(struct pbuf *p)
{
     e80:	55                   	push   %ebp
     e81:	89 e5                	mov    %esp,%ebp
     e83:	83 ec 18             	sub    $0x18,%esp
  u32_t acc;
  struct pbuf *q;
  u8_t swapped;

  acc = 0;
     e86:	c7 45 f4 00 00 00 00 	movl   $0x0,0xfffffff4(%ebp)
  swapped = 0;
     e8d:	c6 45 ff 00          	movb   $0x0,0xffffffff(%ebp)
  for(q = p; q != NULL; q = q->next) {
     e91:	8b 45 08             	mov    0x8(%ebp),%eax
     e94:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
     e97:	eb 69                	jmp    f02 <inet_chksum_pbuf+0x82>
    acc += lwip_chksum(q->payload, q->len);
     e99:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     e9c:	0f b7 40 0a          	movzwl 0xa(%eax),%eax
     ea0:	0f b7 d0             	movzwl %ax,%edx
     ea3:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     ea6:	8b 40 04             	mov    0x4(%eax),%eax
     ea9:	89 54 24 04          	mov    %edx,0x4(%esp)
     ead:	89 04 24             	mov    %eax,(%esp)
     eb0:	e8 9b fd ff ff       	call   c50 <lwip_chksum>
     eb5:	0f b7 c0             	movzwl %ax,%eax
     eb8:	01 45 f4             	add    %eax,0xfffffff4(%ebp)
    while (acc >> 16) {
     ebb:	eb 10                	jmp    ecd <inet_chksum_pbuf+0x4d>
      acc = (acc & 0xffffUL) + (acc >> 16);
     ebd:	0f b7 55 f4          	movzwl 0xfffffff4(%ebp),%edx
     ec1:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     ec4:	c1 e8 10             	shr    $0x10,%eax
     ec7:	8d 04 02             	lea    (%edx,%eax,1),%eax
     eca:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
     ecd:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     ed0:	c1 e8 10             	shr    $0x10,%eax
     ed3:	85 c0                	test   %eax,%eax
     ed5:	75 e6                	jne    ebd <inet_chksum_pbuf+0x3d>
    }
    if (q->len % 2 != 0) {
     ed7:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     eda:	0f b7 40 0a          	movzwl 0xa(%eax),%eax
     ede:	0f b7 c0             	movzwl %ax,%eax
     ee1:	83 e0 01             	and    $0x1,%eax
     ee4:	84 c0                	test   %al,%al
     ee6:	74 12                	je     efa <inet_chksum_pbuf+0x7a>
      swapped = 1 - swapped;
     ee8:	b8 01 00 00 00       	mov    $0x1,%eax
     eed:	2a 45 ff             	sub    0xffffffff(%ebp),%al
     ef0:	88 45 ff             	mov    %al,0xffffffff(%ebp)
      acc = (acc & 0x00ffUL << 8) | (acc & 0xff00UL >> 8);
     ef3:	81 65 f4 ff ff 00 00 	andl   $0xffff,0xfffffff4(%ebp)
     efa:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     efd:	8b 00                	mov    (%eax),%eax
     eff:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
     f02:	83 7d f8 00          	cmpl   $0x0,0xfffffff8(%ebp)
     f06:	75 91                	jne    e99 <inet_chksum_pbuf+0x19>
    }
  }

  if (swapped) {
     f08:	80 7d ff 00          	cmpb   $0x0,0xffffffff(%ebp)
     f0c:	74 19                	je     f27 <inet_chksum_pbuf+0xa7>
    acc = ((acc & 0x00ffUL) << 8) | ((acc & 0xff00UL) >> 8);
     f0e:	0f b6 45 f4          	movzbl 0xfffffff4(%ebp),%eax
     f12:	89 c2                	mov    %eax,%edx
     f14:	c1 e2 08             	shl    $0x8,%edx
     f17:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     f1a:	25 00 ff 00 00       	and    $0xff00,%eax
     f1f:	c1 e8 08             	shr    $0x8,%eax
     f22:	09 d0                	or     %edx,%eax
     f24:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
  }
  return ~(acc & 0xffffUL);
     f27:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     f2a:	f7 d0                	not    %eax
     f2c:	0f b7 c0             	movzwl %ax,%eax
}
     f2f:	c9                   	leave  
     f30:	c3                   	ret    
     f31:	eb 0d                	jmp    f40 <inet_addr>
     f33:	90                   	nop    
     f34:	90                   	nop    
     f35:	90                   	nop    
     f36:	90                   	nop    
     f37:	90                   	nop    
     f38:	90                   	nop    
     f39:	90                   	nop    
     f3a:	90                   	nop    
     f3b:	90                   	nop    
     f3c:	90                   	nop    
     f3d:	90                   	nop    
     f3e:	90                   	nop    
     f3f:	90                   	nop    

00000f40 <inet_addr>:

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
     f40:	55                   	push   %ebp
     f41:	89 e5                	mov    %esp,%ebp
     f43:	83 ec 28             	sub    $0x28,%esp
     struct in_addr val;

     if (inet_aton(cp, &val)) {
     f46:	8d 45 fc             	lea    0xfffffffc(%ebp),%eax
     f49:	89 44 24 04          	mov    %eax,0x4(%esp)
     f4d:	8b 45 08             	mov    0x8(%ebp),%eax
     f50:	89 04 24             	mov    %eax,(%esp)
     f53:	e8 18 00 00 00       	call   f70 <inet_aton>
     f58:	85 c0                	test   %eax,%eax
     f5a:	74 08                	je     f64 <inet_addr+0x24>
         return (val.s_addr);
     f5c:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     f5f:	89 45 ec             	mov    %eax,0xffffffec(%ebp)
     f62:	eb 07                	jmp    f6b <inet_addr+0x2b>
     }
     return (INADDR_NONE);
     f64:	c7 45 ec ff ff ff ff 	movl   $0xffffffff,0xffffffec(%ebp)
     f6b:	8b 45 ec             	mov    0xffffffec(%ebp),%eax
 }
     f6e:	c9                   	leave  
     f6f:	c3                   	ret    

00000f70 <inet_aton>:

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
     f70:	55                   	push   %ebp
     f71:	89 e5                	mov    %esp,%ebp
     f73:	83 ec 48             	sub    $0x48,%esp
     u32_t val;
     int base, n;
     char c;
     u32_t parts[4];
     u32_t* pp = parts;
     f76:	8d 45 dc             	lea    0xffffffdc(%ebp),%eax
     f79:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)

     c = *cp;
     f7c:	8b 45 08             	mov    0x8(%ebp),%eax
     f7f:	0f b6 00             	movzbl (%eax),%eax
     f82:	88 45 fb             	mov    %al,0xfffffffb(%ebp)
     for (;;) {
         /*
          * Collect number up to ``.''.
          * Values are specified as for C:
          * 0x=hex, 0=octal, isdigit=decimal.
          */
         if (!isdigit(c))
     f85:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
     f89:	3c 2f                	cmp    $0x2f,%al
     f8b:	76 08                	jbe    f95 <inet_aton+0x25>
     f8d:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
     f91:	3c 39                	cmp    $0x39,%al
     f93:	76 0c                	jbe    fa1 <inet_aton+0x31>
             return (0);
     f95:	c7 45 c0 00 00 00 00 	movl   $0x0,0xffffffc0(%ebp)
     f9c:	e9 78 02 00 00       	jmp    1219 <inet_aton+0x2a9>
         val = 0; base = 10;
     fa1:	c7 45 ec 00 00 00 00 	movl   $0x0,0xffffffec(%ebp)
     fa8:	c7 45 f0 0a 00 00 00 	movl   $0xa,0xfffffff0(%ebp)
         if (c == '0') {
     faf:	80 7d fb 30          	cmpb   $0x30,0xfffffffb(%ebp)
     fb3:	75 36                	jne    feb <inet_aton+0x7b>
             c = *++cp;
     fb5:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     fb9:	8b 45 08             	mov    0x8(%ebp),%eax
     fbc:	0f b6 00             	movzbl (%eax),%eax
     fbf:	88 45 fb             	mov    %al,0xfffffffb(%ebp)
             if (c == 'x' || c == 'X')
     fc2:	80 7d fb 78          	cmpb   $0x78,0xfffffffb(%ebp)
     fc6:	74 06                	je     fce <inet_aton+0x5e>
     fc8:	80 7d fb 58          	cmpb   $0x58,0xfffffffb(%ebp)
     fcc:	75 16                	jne    fe4 <inet_aton+0x74>
                 base = 16, c = *++cp;
     fce:	c7 45 f0 10 00 00 00 	movl   $0x10,0xfffffff0(%ebp)
     fd5:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     fd9:	8b 45 08             	mov    0x8(%ebp),%eax
     fdc:	0f b6 00             	movzbl (%eax),%eax
     fdf:	88 45 fb             	mov    %al,0xfffffffb(%ebp)
     fe2:	eb 07                	jmp    feb <inet_aton+0x7b>
             else
                 base = 8;
     fe4:	c7 45 f0 08 00 00 00 	movl   $0x8,0xfffffff0(%ebp)
         }
         for (;;) {
             if (isascii(c) && isdigit(c)) {
     feb:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
     fef:	3c 1f                	cmp    $0x1f,%al
     ff1:	76 3b                	jbe    102e <inet_aton+0xbe>
     ff3:	80 7d fb 00          	cmpb   $0x0,0xfffffffb(%ebp)
     ff7:	78 35                	js     102e <inet_aton+0xbe>
     ff9:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
     ffd:	3c 2f                	cmp    $0x2f,%al
     fff:	76 2d                	jbe    102e <inet_aton+0xbe>
    1001:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
    1005:	3c 39                	cmp    $0x39,%al
    1007:	77 25                	ja     102e <inet_aton+0xbe>
                 val = (val * base) + (c - '0');
    1009:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
    100c:	89 c2                	mov    %eax,%edx
    100e:	0f af 55 ec          	imul   0xffffffec(%ebp),%edx
    1012:	0f be 45 fb          	movsbl 0xfffffffb(%ebp),%eax
    1016:	8d 04 02             	lea    (%edx,%eax,1),%eax
    1019:	83 e8 30             	sub    $0x30,%eax
    101c:	89 45 ec             	mov    %eax,0xffffffec(%ebp)
                 c = *++cp;
    101f:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    1023:	8b 45 08             	mov    0x8(%ebp),%eax
    1026:	0f b6 00             	movzbl (%eax),%eax
    1029:	88 45 fb             	mov    %al,0xfffffffb(%ebp)
    102c:	eb bd                	jmp    feb <inet_aton+0x7b>
             } else if (base == 16 && isascii(c) && isxdigit(c)) {
    102e:	83 7d f0 10          	cmpl   $0x10,0xfffffff0(%ebp)
    1032:	0f 85 99 00 00 00    	jne    10d1 <inet_aton+0x161>
    1038:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
    103c:	3c 1f                	cmp    $0x1f,%al
    103e:	0f 86 8d 00 00 00    	jbe    10d1 <inet_aton+0x161>
    1044:	80 7d fb 00          	cmpb   $0x0,0xfffffffb(%ebp)
    1048:	0f 88 83 00 00 00    	js     10d1 <inet_aton+0x161>
    104e:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
    1052:	3c 2f                	cmp    $0x2f,%al
    1054:	76 08                	jbe    105e <inet_aton+0xee>
    1056:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
    105a:	3c 39                	cmp    $0x39,%al
    105c:	76 20                	jbe    107e <inet_aton+0x10e>
    105e:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
    1062:	3c 60                	cmp    $0x60,%al
    1064:	76 08                	jbe    106e <inet_aton+0xfe>
    1066:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
    106a:	3c 66                	cmp    $0x66,%al
    106c:	76 10                	jbe    107e <inet_aton+0x10e>
    106e:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
    1072:	3c 40                	cmp    $0x40,%al
    1074:	76 5b                	jbe    10d1 <inet_aton+0x161>
    1076:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
    107a:	3c 46                	cmp    $0x46,%al
    107c:	77 53                	ja     10d1 <inet_aton+0x161>
                 val = (val << 4) |
    107e:	8b 45 ec             	mov    0xffffffec(%ebp),%eax
    1081:	89 c2                	mov    %eax,%edx
    1083:	c1 e2 04             	shl    $0x4,%edx
    1086:	89 55 c4             	mov    %edx,0xffffffc4(%ebp)
    1089:	0f be 45 fb          	movsbl 0xfffffffb(%ebp),%eax
    108d:	83 c0 0a             	add    $0xa,%eax
    1090:	89 45 c8             	mov    %eax,0xffffffc8(%ebp)
    1093:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
    1097:	3c 60                	cmp    $0x60,%al
    1099:	76 11                	jbe    10ac <inet_aton+0x13c>
    109b:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
    109f:	3c 7a                	cmp    $0x7a,%al
    10a1:	77 09                	ja     10ac <inet_aton+0x13c>
    10a3:	c7 45 cc 61 00 00 00 	movl   $0x61,0xffffffcc(%ebp)
    10aa:	eb 07                	jmp    10b3 <inet_aton+0x143>
    10ac:	c7 45 cc 41 00 00 00 	movl   $0x41,0xffffffcc(%ebp)
    10b3:	8b 45 c8             	mov    0xffffffc8(%ebp),%eax
    10b6:	2b 45 cc             	sub    0xffffffcc(%ebp),%eax
    10b9:	0b 45 c4             	or     0xffffffc4(%ebp),%eax
    10bc:	89 45 ec             	mov    %eax,0xffffffec(%ebp)
                     (c + 10 - (islower(c) ? 'a' : 'A'));
                 c = *++cp;
    10bf:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    10c3:	8b 45 08             	mov    0x8(%ebp),%eax
    10c6:	0f b6 00             	movzbl (%eax),%eax
    10c9:	88 45 fb             	mov    %al,0xfffffffb(%ebp)
             } else
             break;
         }
    10cc:	e9 1a ff ff ff       	jmp    feb <inet_aton+0x7b>
         if (c == '.') {
    10d1:	80 7d fb 2e          	cmpb   $0x2e,0xfffffffb(%ebp)
    10d5:	75 35                	jne    110c <inet_aton+0x19c>
             /*
              * Internet format:
              *  a.b.c.d
              *  a.b.c   (with c treated as 16 bits)
              *  a.b (with b treated as 24 bits)
              */
             if (pp >= parts + 3)
    10d7:	8d 45 dc             	lea    0xffffffdc(%ebp),%eax
    10da:	83 c0 0c             	add    $0xc,%eax
    10dd:	3b 45 fc             	cmp    0xfffffffc(%ebp),%eax
    10e0:	77 0c                	ja     10ee <inet_aton+0x17e>
                 return (0);
    10e2:	c7 45 c0 00 00 00 00 	movl   $0x0,0xffffffc0(%ebp)
    10e9:	e9 2b 01 00 00       	jmp    1219 <inet_aton+0x2a9>
             *pp++ = val;
    10ee:	8b 55 fc             	mov    0xfffffffc(%ebp),%edx
    10f1:	8b 45 ec             	mov    0xffffffec(%ebp),%eax
    10f4:	89 02                	mov    %eax,(%edx)
    10f6:	83 45 fc 04          	addl   $0x4,0xfffffffc(%ebp)
             c = *++cp;
    10fa:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    10fe:	8b 45 08             	mov    0x8(%ebp),%eax
    1101:	0f b6 00             	movzbl (%eax),%eax
    1104:	88 45 fb             	mov    %al,0xfffffffb(%ebp)
         } else
             break;
     }
    1107:	e9 79 fe ff ff       	jmp    f85 <inet_aton+0x15>
     /*
      * Check for trailing characters.
      */
     if (c != '\0' && (!isascii(c) || !isspace(c)))
    110c:	80 7d fb 00          	cmpb   $0x0,0xfffffffb(%ebp)
    1110:	74 3e                	je     1150 <inet_aton+0x1e0>
    1112:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
    1116:	3c 1f                	cmp    $0x1f,%al
    1118:	76 2a                	jbe    1144 <inet_aton+0x1d4>
    111a:	80 7d fb 00          	cmpb   $0x0,0xfffffffb(%ebp)
    111e:	78 24                	js     1144 <inet_aton+0x1d4>
    1120:	80 7d fb 20          	cmpb   $0x20,0xfffffffb(%ebp)
    1124:	74 2a                	je     1150 <inet_aton+0x1e0>
    1126:	80 7d fb 0c          	cmpb   $0xc,0xfffffffb(%ebp)
    112a:	74 24                	je     1150 <inet_aton+0x1e0>
    112c:	80 7d fb 0a          	cmpb   $0xa,0xfffffffb(%ebp)
    1130:	74 1e                	je     1150 <inet_aton+0x1e0>
    1132:	80 7d fb 0d          	cmpb   $0xd,0xfffffffb(%ebp)
    1136:	74 18                	je     1150 <inet_aton+0x1e0>
    1138:	80 7d fb 09          	cmpb   $0x9,0xfffffffb(%ebp)
    113c:	74 12                	je     1150 <inet_aton+0x1e0>
    113e:	80 7d fb 0b          	cmpb   $0xb,0xfffffffb(%ebp)
    1142:	74 0c                	je     1150 <inet_aton+0x1e0>
         return (0);
    1144:	c7 45 c0 00 00 00 00 	movl   $0x0,0xffffffc0(%ebp)
    114b:	e9 c9 00 00 00       	jmp    1219 <inet_aton+0x2a9>
     /*
      * Concoct the address according to
      * the number of parts specified.
      */
     n = pp - parts + 1;
    1150:	8b 55 fc             	mov    0xfffffffc(%ebp),%edx
    1153:	8d 45 dc             	lea    0xffffffdc(%ebp),%eax
    1156:	89 d1                	mov    %edx,%ecx
    1158:	29 c1                	sub    %eax,%ecx
    115a:	89 c8                	mov    %ecx,%eax
    115c:	c1 f8 02             	sar    $0x2,%eax
    115f:	83 c0 01             	add    $0x1,%eax
    1162:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
     switch (n) {
    1165:	83 7d f4 04          	cmpl   $0x4,0xfffffff4(%ebp)
    1169:	0f 87 8b 00 00 00    	ja     11fa <inet_aton+0x28a>
    116f:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
    1172:	c1 e0 02             	shl    $0x2,%eax
    1175:	8b 80 04 14 00 00    	mov    0x1404(%eax),%eax
    117b:	ff e0                	jmp    *%eax

     case 0:
         return (0);     /* initial nondigit */
    117d:	c7 45 c0 00 00 00 00 	movl   $0x0,0xffffffc0(%ebp)
    1184:	e9 90 00 00 00       	jmp    1219 <inet_aton+0x2a9>

     case 1:             /* a -- 32 bits */
         break;

     case 2:             /* a.b -- 8.24 bits */
         if (val > 0xffffff)
    1189:	81 7d ec ff ff ff 00 	cmpl   $0xffffff,0xffffffec(%ebp)
    1190:	76 09                	jbe    119b <inet_aton+0x22b>
             return (0);
    1192:	c7 45 c0 00 00 00 00 	movl   $0x0,0xffffffc0(%ebp)
    1199:	eb 7e                	jmp    1219 <inet_aton+0x2a9>
         val |= parts[0] << 24;
    119b:	8b 45 dc             	mov    0xffffffdc(%ebp),%eax
    119e:	c1 e0 18             	shl    $0x18,%eax
    11a1:	09 45 ec             	or     %eax,0xffffffec(%ebp)
         break;
    11a4:	eb 54                	jmp    11fa <inet_aton+0x28a>

     case 3:             /* a.b.c -- 8.8.16 bits */
         if (val > 0xffff)
    11a6:	81 7d ec ff ff 00 00 	cmpl   $0xffff,0xffffffec(%ebp)
    11ad:	76 09                	jbe    11b8 <inet_aton+0x248>
             return (0);
    11af:	c7 45 c0 00 00 00 00 	movl   $0x0,0xffffffc0(%ebp)
    11b6:	eb 61                	jmp    1219 <inet_aton+0x2a9>
         val |= (parts[0] << 24) | (parts[1] << 16);
    11b8:	8b 45 dc             	mov    0xffffffdc(%ebp),%eax
    11bb:	89 c2                	mov    %eax,%edx
    11bd:	c1 e2 18             	shl    $0x18,%edx
    11c0:	8b 45 e0             	mov    0xffffffe0(%ebp),%eax
    11c3:	c1 e0 10             	shl    $0x10,%eax
    11c6:	09 d0                	or     %edx,%eax
    11c8:	09 45 ec             	or     %eax,0xffffffec(%ebp)
         break;
    11cb:	eb 2d                	jmp    11fa <inet_aton+0x28a>

     case 4:             /* a.b.c.d -- 8.8.8.8 bits */
         if (val > 0xff)
    11cd:	81 7d ec ff 00 00 00 	cmpl   $0xff,0xffffffec(%ebp)
    11d4:	76 09                	jbe    11df <inet_aton+0x26f>
             return (0);
    11d6:	c7 45 c0 00 00 00 00 	movl   $0x0,0xffffffc0(%ebp)
    11dd:	eb 3a                	jmp    1219 <inet_aton+0x2a9>
         val |= (parts[0] << 24) | (parts[1] << 16) | (parts[2] << 8);
    11df:	8b 45 dc             	mov    0xffffffdc(%ebp),%eax
    11e2:	89 c2                	mov    %eax,%edx
    11e4:	c1 e2 18             	shl    $0x18,%edx
    11e7:	8b 45 e0             	mov    0xffffffe0(%ebp),%eax
    11ea:	c1 e0 10             	shl    $0x10,%eax
    11ed:	09 c2                	or     %eax,%edx
    11ef:	8b 45 e4             	mov    0xffffffe4(%ebp),%eax
    11f2:	c1 e0 08             	shl    $0x8,%eax
    11f5:	09 d0                	or     %edx,%eax
    11f7:	09 45 ec             	or     %eax,0xffffffec(%ebp)
         break;
     }
     if (addr)
    11fa:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    11fe:	74 12                	je     1212 <inet_aton+0x2a2>
         addr->s_addr = htonl(val);
    1200:	8b 45 ec             	mov    0xffffffec(%ebp),%eax
    1203:	89 04 24             	mov    %eax,(%esp)
    1206:	e8 65 01 00 00       	call   1370 <htonl>
    120b:	89 c2                	mov    %eax,%edx
    120d:	8b 45 0c             	mov    0xc(%ebp),%eax
    1210:	89 10                	mov    %edx,(%eax)
     return (1);
    1212:	c7 45 c0 01 00 00 00 	movl   $0x1,0xffffffc0(%ebp)
    1219:	8b 45 c0             	mov    0xffffffc0(%ebp),%eax
 }
    121c:	c9                   	leave  
    121d:	c3                   	ret    
    121e:	89 f6                	mov    %esi,%esi

00001220 <inet_ntoa>:

/* Convert numeric IP address into decimal dotted ASCII representation.
 * returns ptr to static buffer; not reentrant!
 */
char *inet_ntoa(struct in_addr addr)
{
    1220:	55                   	push   %ebp
    1221:	89 e5                	mov    %esp,%ebp
    1223:	53                   	push   %ebx
    1224:	83 ec 24             	sub    $0x24,%esp
  static char str[16];
  u32_t s_addr = addr.s_addr;
    1227:	8b 45 08             	mov    0x8(%ebp),%eax
    122a:	89 45 ec             	mov    %eax,0xffffffec(%ebp)
  char inv[3];
  char *rp;
  char *ap;
  u8_t rem;
  u8_t n;
  u8_t i;

  rp = str;
    122d:	c7 45 f0 4c 14 00 00 	movl   $0x144c,0xfffffff0(%ebp)
  ap = (u8_t *)&s_addr;
    1234:	8d 45 ec             	lea    0xffffffec(%ebp),%eax
    1237:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
  for(n = 0; n < 4; n++) {
    123a:	c6 45 fa 00          	movb   $0x0,0xfffffffa(%ebp)
    123e:	e9 af 00 00 00       	jmp    12f2 <inet_ntoa+0xd2>
    i = 0;
    1243:	c6 45 fb 00          	movb   $0x0,0xfffffffb(%ebp)
    do {
      rem = *ap % (u8_t)10;
    1247:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
    124a:	0f b6 08             	movzbl (%eax),%ecx
    124d:	b8 67 00 00 00       	mov    $0x67,%eax
    1252:	f6 e9                	imul   %cl
    1254:	66 c1 e8 08          	shr    $0x8,%ax
    1258:	89 c2                	mov    %eax,%edx
    125a:	c0 fa 02             	sar    $0x2,%dl
    125d:	89 c8                	mov    %ecx,%eax
    125f:	c0 f8 07             	sar    $0x7,%al
    1262:	89 d3                	mov    %edx,%ebx
    1264:	28 c3                	sub    %al,%bl
    1266:	88 5d db             	mov    %bl,0xffffffdb(%ebp)
    1269:	0f b6 45 db          	movzbl 0xffffffdb(%ebp),%eax
    126d:	c1 e0 02             	shl    $0x2,%eax
    1270:	02 45 db             	add    0xffffffdb(%ebp),%al
    1273:	01 c0                	add    %eax,%eax
    1275:	89 ca                	mov    %ecx,%edx
    1277:	28 c2                	sub    %al,%dl
    1279:	88 55 db             	mov    %dl,0xffffffdb(%ebp)
    127c:	0f b6 5d db          	movzbl 0xffffffdb(%ebp),%ebx
    1280:	88 5d f9             	mov    %bl,0xfffffff9(%ebp)
      *ap /= (u8_t)10;
    1283:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
    1286:	0f b6 08             	movzbl (%eax),%ecx
    1289:	b8 67 00 00 00       	mov    $0x67,%eax
    128e:	f6 e9                	imul   %cl
    1290:	66 c1 e8 08          	shr    $0x8,%ax
    1294:	89 c2                	mov    %eax,%edx
    1296:	c0 fa 02             	sar    $0x2,%dl
    1299:	89 c8                	mov    %ecx,%eax
    129b:	c0 f8 07             	sar    $0x7,%al
    129e:	28 c2                	sub    %al,%dl
    12a0:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
    12a3:	88 10                	mov    %dl,(%eax)
      inv[i++] = '0' + rem;
    12a5:	0f b6 55 fb          	movzbl 0xfffffffb(%ebp),%edx
    12a9:	0f b6 45 f9          	movzbl 0xfffffff9(%ebp),%eax
    12ad:	83 c0 30             	add    $0x30,%eax
    12b0:	88 44 15 e9          	mov    %al,0xffffffe9(%ebp,%edx,1)
    12b4:	80 45 fb 01          	addb   $0x1,0xfffffffb(%ebp)
    } while(*ap);
    12b8:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
    12bb:	0f b6 00             	movzbl (%eax),%eax
    12be:	84 c0                	test   %al,%al
    12c0:	75 85                	jne    1247 <inet_ntoa+0x27>
    while(i--)
    12c2:	eb 12                	jmp    12d6 <inet_ntoa+0xb6>
      *rp++ = inv[i];
    12c4:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
    12c8:	0f b6 54 05 e9       	movzbl 0xffffffe9(%ebp,%eax,1),%edx
    12cd:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
    12d0:	88 10                	mov    %dl,(%eax)
    12d2:	83 45 f0 01          	addl   $0x1,0xfffffff0(%ebp)
    12d6:	80 6d fb 01          	subb   $0x1,0xfffffffb(%ebp)
    12da:	80 7d fb ff          	cmpb   $0xff,0xfffffffb(%ebp)
    12de:	75 e4                	jne    12c4 <inet_ntoa+0xa4>
    *rp++ = '.';
    12e0:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
    12e3:	c6 00 2e             	movb   $0x2e,(%eax)
    12e6:	83 45 f0 01          	addl   $0x1,0xfffffff0(%ebp)
    ap++;
    12ea:	83 45 f4 01          	addl   $0x1,0xfffffff4(%ebp)
    12ee:	80 45 fa 01          	addb   $0x1,0xfffffffa(%ebp)
    12f2:	80 7d fa 03          	cmpb   $0x3,0xfffffffa(%ebp)
    12f6:	0f 86 47 ff ff ff    	jbe    1243 <inet_ntoa+0x23>
  }
  *--rp = 0;
    12fc:	83 6d f0 01          	subl   $0x1,0xfffffff0(%ebp)
    1300:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
    1303:	c6 00 00             	movb   $0x0,(%eax)
  return str;
    1306:	b8 4c 14 00 00       	mov    $0x144c,%eax
}
    130b:	83 c4 24             	add    $0x24,%esp
    130e:	5b                   	pop    %ebx
    130f:	5d                   	pop    %ebp
    1310:	c3                   	ret    
    1311:	eb 0d                	jmp    1320 <htons>
    1313:	90                   	nop    
    1314:	90                   	nop    
    1315:	90                   	nop    
    1316:	90                   	nop    
    1317:	90                   	nop    
    1318:	90                   	nop    
    1319:	90                   	nop    
    131a:	90                   	nop    
    131b:	90                   	nop    
    131c:	90                   	nop    
    131d:	90                   	nop    
    131e:	90                   	nop    
    131f:	90                   	nop    

00001320 <htons>:


#ifndef BYTE_ORDER
#error BYTE_ORDER is not defined
#endif
#if BYTE_ORDER == LITTLE_ENDIAN

u16_t
htons(u16_t n)
{
    1320:	55                   	push   %ebp
    1321:	89 e5                	mov    %esp,%ebp
    1323:	83 ec 04             	sub    $0x4,%esp
    1326:	8b 45 08             	mov    0x8(%ebp),%eax
    1329:	66 89 45 fc          	mov    %ax,0xfffffffc(%ebp)
  return ((n & 0xff) << 8) | ((n & 0xff00) >> 8);
    132d:	0f b7 45 fc          	movzwl 0xfffffffc(%ebp),%eax
    1331:	25 ff 00 00 00       	and    $0xff,%eax
    1336:	c1 e0 08             	shl    $0x8,%eax
    1339:	89 c2                	mov    %eax,%edx
    133b:	0f b7 45 fc          	movzwl 0xfffffffc(%ebp),%eax
    133f:	25 00 ff 00 00       	and    $0xff00,%eax
    1344:	c1 f8 08             	sar    $0x8,%eax
    1347:	09 d0                	or     %edx,%eax
    1349:	0f b7 c0             	movzwl %ax,%eax
}
    134c:	c9                   	leave  
    134d:	c3                   	ret    
    134e:	89 f6                	mov    %esi,%esi

00001350 <ntohs>:

u16_t
ntohs(u16_t n)
{
    1350:	55                   	push   %ebp
    1351:	89 e5                	mov    %esp,%ebp
    1353:	83 ec 08             	sub    $0x8,%esp
    1356:	8b 45 08             	mov    0x8(%ebp),%eax
    1359:	66 89 45 fc          	mov    %ax,0xfffffffc(%ebp)
  return htons(n);
    135d:	0f b7 45 fc          	movzwl 0xfffffffc(%ebp),%eax
    1361:	89 04 24             	mov    %eax,(%esp)
    1364:	e8 b7 ff ff ff       	call   1320 <htons>
    1369:	0f b7 c0             	movzwl %ax,%eax
}
    136c:	c9                   	leave  
    136d:	c3                   	ret    
    136e:	89 f6                	mov    %esi,%esi

00001370 <htonl>:

u32_t
htonl(u32_t n)
{
    1370:	55                   	push   %ebp
    1371:	89 e5                	mov    %esp,%ebp
  return ((n & 0xff) << 24) |
    1373:	0f b6 45 08          	movzbl 0x8(%ebp),%eax
    1377:	89 c2                	mov    %eax,%edx
    1379:	c1 e2 18             	shl    $0x18,%edx
    137c:	8b 45 08             	mov    0x8(%ebp),%eax
    137f:	25 00 ff 00 00       	and    $0xff00,%eax
    1384:	c1 e0 08             	shl    $0x8,%eax
    1387:	09 c2                	or     %eax,%edx
    1389:	8b 45 08             	mov    0x8(%ebp),%eax
    138c:	25 00 00 ff 00       	and    $0xff0000,%eax
    1391:	c1 e8 08             	shr    $0x8,%eax
    1394:	09 c2                	or     %eax,%edx
    1396:	8b 45 08             	mov    0x8(%ebp),%eax
    1399:	25 00 00 00 ff       	and    $0xff000000,%eax
    139e:	c1 e8 18             	shr    $0x18,%eax
    13a1:	09 d0                	or     %edx,%eax
    ((n & 0xff00) << 8) |
    ((n & 0xff0000) >> 8) |
    ((n & 0xff000000) >> 24);
}
    13a3:	5d                   	pop    %ebp
    13a4:	c3                   	ret    
    13a5:	8d 74 26 00          	lea    0x0(%esi),%esi
    13a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

000013b0 <ntohl>:

u32_t
ntohl(u32_t n)
{
    13b0:	55                   	push   %ebp
    13b1:	89 e5                	mov    %esp,%ebp
    13b3:	83 ec 04             	sub    $0x4,%esp
  return htonl(n);
    13b6:	8b 45 08             	mov    0x8(%ebp),%eax
    13b9:	89 04 24             	mov    %eax,(%esp)
    13bc:	e8 af ff ff ff       	call   1370 <htonl>
}
    13c1:	c9                   	leave  
    13c2:	c3                   	ret    
