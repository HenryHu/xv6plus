
_ls:     file format elf32-i386-freebsd

Disassembly of section .text:

00000000 <fmtname>:
#include "fs.h"

char*
fmtname(char *path)
{
       0:	55                   	push   %ebp
       1:	89 e5                	mov    %esp,%ebp
       3:	53                   	push   %ebx
       4:	83 ec 24             	sub    $0x24,%esp
  static char buf[DIRSIZ+1];
  char *p;
  
  // Find first character after last slash.
  for(p=path+strlen(path); p >= path && *p != '/'; p--)
       7:	8b 45 08             	mov    0x8(%ebp),%eax
       a:	89 04 24             	mov    %eax,(%esp)
       d:	e8 0e 04 00 00       	call   420 <strlen>
      12:	03 45 08             	add    0x8(%ebp),%eax
      15:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
      18:	eb 04                	jmp    1e <fmtname+0x1e>
      1a:	83 6d f8 01          	subl   $0x1,0xfffffff8(%ebp)
      1e:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
      21:	3b 45 08             	cmp    0x8(%ebp),%eax
      24:	72 0a                	jb     30 <fmtname+0x30>
      26:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
      29:	0f b6 00             	movzbl (%eax),%eax
      2c:	3c 2f                	cmp    $0x2f,%al
      2e:	75 ea                	jne    1a <fmtname+0x1a>
    ;
  p++;
      30:	83 45 f8 01          	addl   $0x1,0xfffffff8(%ebp)
  
  // Return blank-padded name.
  if(strlen(p) >= DIRSIZ)
      34:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
      37:	89 04 24             	mov    %eax,(%esp)
      3a:	e8 e1 03 00 00       	call   420 <strlen>
      3f:	83 f8 0d             	cmp    $0xd,%eax
      42:	76 08                	jbe    4c <fmtname+0x4c>
    return p;
      44:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
      47:	89 45 e8             	mov    %eax,0xffffffe8(%ebp)
      4a:	eb 63                	jmp    af <fmtname+0xaf>
  memmove(buf, p, strlen(p));
      4c:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
      4f:	89 04 24             	mov    %eax,(%esp)
      52:	e8 c9 03 00 00       	call   420 <strlen>
      57:	89 44 24 08          	mov    %eax,0x8(%esp)
      5b:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
      5e:	89 44 24 04          	mov    %eax,0x4(%esp)
      62:	c7 04 24 30 14 00 00 	movl   $0x1430,(%esp)
      69:	e8 72 05 00 00       	call   5e0 <memmove>
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
      6e:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
      71:	89 04 24             	mov    %eax,(%esp)
      74:	e8 a7 03 00 00       	call   420 <strlen>
      79:	89 c2                	mov    %eax,%edx
      7b:	b8 0e 00 00 00       	mov    $0xe,%eax
      80:	89 c3                	mov    %eax,%ebx
      82:	29 d3                	sub    %edx,%ebx
      84:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
      87:	89 04 24             	mov    %eax,(%esp)
      8a:	e8 91 03 00 00       	call   420 <strlen>
      8f:	05 30 14 00 00       	add    $0x1430,%eax
      94:	89 5c 24 08          	mov    %ebx,0x8(%esp)
      98:	c7 44 24 04 20 00 00 	movl   $0x20,0x4(%esp)
      9f:	00 
      a0:	89 04 24             	mov    %eax,(%esp)
      a3:	e8 a8 03 00 00       	call   450 <memset>
  return buf;
      a8:	c7 45 e8 30 14 00 00 	movl   $0x1430,0xffffffe8(%ebp)
      af:	8b 45 e8             	mov    0xffffffe8(%ebp),%eax
}
      b2:	83 c4 24             	add    $0x24,%esp
      b5:	5b                   	pop    %ebx
      b6:	5d                   	pop    %ebp
      b7:	c3                   	ret    
      b8:	90                   	nop    
      b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi

000000c0 <ls>:

void
ls(char *path)
{
      c0:	55                   	push   %ebp
      c1:	89 e5                	mov    %esp,%ebp
      c3:	57                   	push   %edi
      c4:	56                   	push   %esi
      c5:	53                   	push   %ebx
      c6:	81 ec 4c 02 00 00    	sub    $0x24c,%esp
  char buf[512], *p;
  int fd;
  struct dirent de;
  struct stat st;
  
  if((fd = open(path, 0)) < 0){
      cc:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
      d3:	00 
      d4:	8b 45 08             	mov    0x8(%ebp),%eax
      d7:	89 04 24             	mov    %eax,(%esp)
      da:	e8 85 05 00 00       	call   664 <open>
      df:	89 45 f0             	mov    %eax,0xfffffff0(%ebp)
      e2:	83 7d f0 00          	cmpl   $0x0,0xfffffff0(%ebp)
      e6:	79 20                	jns    108 <ls+0x48>
    printf(2, "ls: cannot open %s\n", path);
      e8:	8b 45 08             	mov    0x8(%ebp),%eax
      eb:	89 44 24 08          	mov    %eax,0x8(%esp)
      ef:	c7 44 24 04 b4 13 00 	movl   $0x13b4,0x4(%esp)
      f6:	00 
      f7:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
      fe:	e8 2d 07 00 00       	call   830 <printf>
    return;
     103:	e9 0e 02 00 00       	jmp    316 <ls+0x256>
  }
  
  if(fstat(fd, &st) < 0){
     108:	8d 85 cc fd ff ff    	lea    0xfffffdcc(%ebp),%eax
     10e:	89 44 24 04          	mov    %eax,0x4(%esp)
     112:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
     115:	89 04 24             	mov    %eax,(%esp)
     118:	e8 5f 05 00 00       	call   67c <fstat>
     11d:	85 c0                	test   %eax,%eax
     11f:	79 2b                	jns    14c <ls+0x8c>
    printf(2, "ls: cannot stat %s\n", path);
     121:	8b 45 08             	mov    0x8(%ebp),%eax
     124:	89 44 24 08          	mov    %eax,0x8(%esp)
     128:	c7 44 24 04 c8 13 00 	movl   $0x13c8,0x4(%esp)
     12f:	00 
     130:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     137:	e8 f4 06 00 00       	call   830 <printf>
    close(fd);
     13c:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
     13f:	89 04 24             	mov    %eax,(%esp)
     142:	e8 05 05 00 00       	call   64c <close>
    return;
     147:	e9 ca 01 00 00       	jmp    316 <ls+0x256>
  }
  
  switch(st.type){
     14c:	0f b7 85 d4 fd ff ff 	movzwl 0xfffffdd4(%ebp),%eax
     153:	98                   	cwtl   
     154:	89 85 c0 fd ff ff    	mov    %eax,0xfffffdc0(%ebp)
     15a:	83 bd c0 fd ff ff 01 	cmpl   $0x1,0xfffffdc0(%ebp)
     161:	74 58                	je     1bb <ls+0xfb>
     163:	83 bd c0 fd ff ff 02 	cmpl   $0x2,0xfffffdc0(%ebp)
     16a:	74 05                	je     171 <ls+0xb1>
     16c:	e9 9a 01 00 00       	jmp    30b <ls+0x24b>
  case T_FILE:
    printf(1, "%s %d %d %d\n", fmtname(path), st.type, st.ino, st.size);
     171:	8b 9d d8 fd ff ff    	mov    0xfffffdd8(%ebp),%ebx
     177:	8b b5 d0 fd ff ff    	mov    0xfffffdd0(%ebp),%esi
     17d:	0f b7 85 d4 fd ff ff 	movzwl 0xfffffdd4(%ebp),%eax
     184:	0f bf f8             	movswl %ax,%edi
     187:	8b 45 08             	mov    0x8(%ebp),%eax
     18a:	89 04 24             	mov    %eax,(%esp)
     18d:	e8 6e fe ff ff       	call   0 <fmtname>
     192:	89 5c 24 14          	mov    %ebx,0x14(%esp)
     196:	89 74 24 10          	mov    %esi,0x10(%esp)
     19a:	89 7c 24 0c          	mov    %edi,0xc(%esp)
     19e:	89 44 24 08          	mov    %eax,0x8(%esp)
     1a2:	c7 44 24 04 dc 13 00 	movl   $0x13dc,0x4(%esp)
     1a9:	00 
     1aa:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     1b1:	e8 7a 06 00 00       	call   830 <printf>
    break;
     1b6:	e9 50 01 00 00       	jmp    30b <ls+0x24b>
  
  case T_DIR:
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
     1bb:	8b 45 08             	mov    0x8(%ebp),%eax
     1be:	89 04 24             	mov    %eax,(%esp)
     1c1:	e8 5a 02 00 00       	call   420 <strlen>
     1c6:	83 c0 10             	add    $0x10,%eax
     1c9:	3d 00 02 00 00       	cmp    $0x200,%eax
     1ce:	76 19                	jbe    1e9 <ls+0x129>
      printf(1, "ls: path too long\n");
     1d0:	c7 44 24 04 e9 13 00 	movl   $0x13e9,0x4(%esp)
     1d7:	00 
     1d8:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     1df:	e8 4c 06 00 00       	call   830 <printf>
      break;
     1e4:	e9 22 01 00 00       	jmp    30b <ls+0x24b>
    }
    strcpy(buf, path);
     1e9:	8b 45 08             	mov    0x8(%ebp),%eax
     1ec:	89 44 24 04          	mov    %eax,0x4(%esp)
     1f0:	8d 85 ec fd ff ff    	lea    0xfffffdec(%ebp),%eax
     1f6:	89 04 24             	mov    %eax,(%esp)
     1f9:	e8 92 01 00 00       	call   390 <strcpy>
    p = buf+strlen(buf);
     1fe:	8d 85 ec fd ff ff    	lea    0xfffffdec(%ebp),%eax
     204:	89 04 24             	mov    %eax,(%esp)
     207:	e8 14 02 00 00       	call   420 <strlen>
     20c:	89 c2                	mov    %eax,%edx
     20e:	8d 85 ec fd ff ff    	lea    0xfffffdec(%ebp),%eax
     214:	01 d0                	add    %edx,%eax
     216:	89 45 ec             	mov    %eax,0xffffffec(%ebp)
    *p++ = '/';
     219:	8b 45 ec             	mov    0xffffffec(%ebp),%eax
     21c:	c6 00 2f             	movb   $0x2f,(%eax)
     21f:	83 45 ec 01          	addl   $0x1,0xffffffec(%ebp)
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
     223:	e9 bd 00 00 00       	jmp    2e5 <ls+0x225>
      if(de.inum == 0)
     228:	0f b7 85 dc fd ff ff 	movzwl 0xfffffddc(%ebp),%eax
     22f:	66 85 c0             	test   %ax,%ax
     232:	0f 84 ad 00 00 00    	je     2e5 <ls+0x225>
        continue;
      memmove(p, de.name, DIRSIZ);
     238:	c7 44 24 08 0e 00 00 	movl   $0xe,0x8(%esp)
     23f:	00 
     240:	8d 85 dc fd ff ff    	lea    0xfffffddc(%ebp),%eax
     246:	83 c0 02             	add    $0x2,%eax
     249:	89 44 24 04          	mov    %eax,0x4(%esp)
     24d:	8b 45 ec             	mov    0xffffffec(%ebp),%eax
     250:	89 04 24             	mov    %eax,(%esp)
     253:	e8 88 03 00 00       	call   5e0 <memmove>
      p[DIRSIZ] = 0;
     258:	8b 45 ec             	mov    0xffffffec(%ebp),%eax
     25b:	83 c0 0e             	add    $0xe,%eax
     25e:	c6 00 00             	movb   $0x0,(%eax)
      if(stat(buf, &st) < 0){
     261:	8d 85 cc fd ff ff    	lea    0xfffffdcc(%ebp),%eax
     267:	89 44 24 04          	mov    %eax,0x4(%esp)
     26b:	8d 85 ec fd ff ff    	lea    0xfffffdec(%ebp),%eax
     271:	89 04 24             	mov    %eax,(%esp)
     274:	e8 b7 02 00 00       	call   530 <stat>
     279:	85 c0                	test   %eax,%eax
     27b:	79 20                	jns    29d <ls+0x1dd>
        printf(1, "ls: cannot stat %s\n", buf);
     27d:	8d 85 ec fd ff ff    	lea    0xfffffdec(%ebp),%eax
     283:	89 44 24 08          	mov    %eax,0x8(%esp)
     287:	c7 44 24 04 c8 13 00 	movl   $0x13c8,0x4(%esp)
     28e:	00 
     28f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     296:	e8 95 05 00 00       	call   830 <printf>
        continue;
     29b:	eb 48                	jmp    2e5 <ls+0x225>
      }
      printf(1, "%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
     29d:	8b 9d d8 fd ff ff    	mov    0xfffffdd8(%ebp),%ebx
     2a3:	8b b5 d0 fd ff ff    	mov    0xfffffdd0(%ebp),%esi
     2a9:	0f b7 85 d4 fd ff ff 	movzwl 0xfffffdd4(%ebp),%eax
     2b0:	0f bf f8             	movswl %ax,%edi
     2b3:	8d 85 ec fd ff ff    	lea    0xfffffdec(%ebp),%eax
     2b9:	89 04 24             	mov    %eax,(%esp)
     2bc:	e8 3f fd ff ff       	call   0 <fmtname>
     2c1:	89 5c 24 14          	mov    %ebx,0x14(%esp)
     2c5:	89 74 24 10          	mov    %esi,0x10(%esp)
     2c9:	89 7c 24 0c          	mov    %edi,0xc(%esp)
     2cd:	89 44 24 08          	mov    %eax,0x8(%esp)
     2d1:	c7 44 24 04 dc 13 00 	movl   $0x13dc,0x4(%esp)
     2d8:	00 
     2d9:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     2e0:	e8 4b 05 00 00       	call   830 <printf>
     2e5:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
     2ec:	00 
     2ed:	8d 85 dc fd ff ff    	lea    0xfffffddc(%ebp),%eax
     2f3:	89 44 24 04          	mov    %eax,0x4(%esp)
     2f7:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
     2fa:	89 04 24             	mov    %eax,(%esp)
     2fd:	e8 3a 03 00 00       	call   63c <read>
     302:	83 f8 10             	cmp    $0x10,%eax
     305:	0f 84 1d ff ff ff    	je     228 <ls+0x168>
    }
    break;
  }
  close(fd);
     30b:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
     30e:	89 04 24             	mov    %eax,(%esp)
     311:	e8 36 03 00 00       	call   64c <close>
}
     316:	81 c4 4c 02 00 00    	add    $0x24c,%esp
     31c:	5b                   	pop    %ebx
     31d:	5e                   	pop    %esi
     31e:	5f                   	pop    %edi
     31f:	5d                   	pop    %ebp
     320:	c3                   	ret    
     321:	eb 0d                	jmp    330 <main>
     323:	90                   	nop    
     324:	90                   	nop    
     325:	90                   	nop    
     326:	90                   	nop    
     327:	90                   	nop    
     328:	90                   	nop    
     329:	90                   	nop    
     32a:	90                   	nop    
     32b:	90                   	nop    
     32c:	90                   	nop    
     32d:	90                   	nop    
     32e:	90                   	nop    
     32f:	90                   	nop    

00000330 <main>:

int
main(int argc, char *argv[])
{
     330:	8d 4c 24 04          	lea    0x4(%esp),%ecx
     334:	83 e4 f0             	and    $0xfffffff0,%esp
     337:	ff 71 fc             	pushl  0xfffffffc(%ecx)
     33a:	55                   	push   %ebp
     33b:	89 e5                	mov    %esp,%ebp
     33d:	51                   	push   %ecx
     33e:	83 ec 24             	sub    $0x24,%esp
     341:	89 4d e8             	mov    %ecx,0xffffffe8(%ebp)
  int i;

  if(argc < 2){
     344:	8b 45 e8             	mov    0xffffffe8(%ebp),%eax
     347:	83 38 01             	cmpl   $0x1,(%eax)
     34a:	7f 11                	jg     35d <main+0x2d>
    ls(".");
     34c:	c7 04 24 fc 13 00 00 	movl   $0x13fc,(%esp)
     353:	e8 68 fd ff ff       	call   c0 <ls>
    exit();
     358:	e8 c7 02 00 00       	call   624 <exit>
  }
  for(i=1; i<argc; i++)
     35d:	c7 45 f8 01 00 00 00 	movl   $0x1,0xfffffff8(%ebp)
     364:	eb 1a                	jmp    380 <main+0x50>
    ls(argv[i]);
     366:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     369:	c1 e0 02             	shl    $0x2,%eax
     36c:	8b 55 e8             	mov    0xffffffe8(%ebp),%edx
     36f:	03 42 04             	add    0x4(%edx),%eax
     372:	8b 00                	mov    (%eax),%eax
     374:	89 04 24             	mov    %eax,(%esp)
     377:	e8 44 fd ff ff       	call   c0 <ls>
     37c:	83 45 f8 01          	addl   $0x1,0xfffffff8(%ebp)
     380:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     383:	8b 55 e8             	mov    0xffffffe8(%ebp),%edx
     386:	3b 02                	cmp    (%edx),%eax
     388:	7c dc                	jl     366 <main+0x36>
  exit();
     38a:	e8 95 02 00 00       	call   624 <exit>
     38f:	90                   	nop    

00000390 <strcpy>:
#include "user.h"

char*
strcpy(char *s, char *t)
{
     390:	55                   	push   %ebp
     391:	89 e5                	mov    %esp,%ebp
     393:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
     396:	8b 45 08             	mov    0x8(%ebp),%eax
     399:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
  while((*s++ = *t++) != 0)
     39c:	8b 45 0c             	mov    0xc(%ebp),%eax
     39f:	0f b6 10             	movzbl (%eax),%edx
     3a2:	8b 45 08             	mov    0x8(%ebp),%eax
     3a5:	88 10                	mov    %dl,(%eax)
     3a7:	8b 45 08             	mov    0x8(%ebp),%eax
     3aa:	0f b6 00             	movzbl (%eax),%eax
     3ad:	84 c0                	test   %al,%al
     3af:	0f 95 c0             	setne  %al
     3b2:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     3b6:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
     3ba:	84 c0                	test   %al,%al
     3bc:	75 de                	jne    39c <strcpy+0xc>
    ;
  return os;
     3be:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
}
     3c1:	c9                   	leave  
     3c2:	c3                   	ret    
     3c3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     3c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

000003d0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     3d0:	55                   	push   %ebp
     3d1:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
     3d3:	eb 08                	jmp    3dd <strcmp+0xd>
    p++, q++;
     3d5:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     3d9:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
     3dd:	8b 45 08             	mov    0x8(%ebp),%eax
     3e0:	0f b6 00             	movzbl (%eax),%eax
     3e3:	84 c0                	test   %al,%al
     3e5:	74 10                	je     3f7 <strcmp+0x27>
     3e7:	8b 45 08             	mov    0x8(%ebp),%eax
     3ea:	0f b6 10             	movzbl (%eax),%edx
     3ed:	8b 45 0c             	mov    0xc(%ebp),%eax
     3f0:	0f b6 00             	movzbl (%eax),%eax
     3f3:	38 c2                	cmp    %al,%dl
     3f5:	74 de                	je     3d5 <strcmp+0x5>
  return (uchar)*p - (uchar)*q;
     3f7:	8b 45 08             	mov    0x8(%ebp),%eax
     3fa:	0f b6 00             	movzbl (%eax),%eax
     3fd:	0f b6 d0             	movzbl %al,%edx
     400:	8b 45 0c             	mov    0xc(%ebp),%eax
     403:	0f b6 00             	movzbl (%eax),%eax
     406:	0f b6 c0             	movzbl %al,%eax
     409:	89 d1                	mov    %edx,%ecx
     40b:	29 c1                	sub    %eax,%ecx
     40d:	89 c8                	mov    %ecx,%eax
}
     40f:	5d                   	pop    %ebp
     410:	c3                   	ret    
     411:	eb 0d                	jmp    420 <strlen>
     413:	90                   	nop    
     414:	90                   	nop    
     415:	90                   	nop    
     416:	90                   	nop    
     417:	90                   	nop    
     418:	90                   	nop    
     419:	90                   	nop    
     41a:	90                   	nop    
     41b:	90                   	nop    
     41c:	90                   	nop    
     41d:	90                   	nop    
     41e:	90                   	nop    
     41f:	90                   	nop    

00000420 <strlen>:

uint
strlen(char *s)
{
     420:	55                   	push   %ebp
     421:	89 e5                	mov    %esp,%ebp
     423:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
     426:	c7 45 fc 00 00 00 00 	movl   $0x0,0xfffffffc(%ebp)
     42d:	eb 04                	jmp    433 <strlen+0x13>
     42f:	83 45 fc 01          	addl   $0x1,0xfffffffc(%ebp)
     433:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     436:	03 45 08             	add    0x8(%ebp),%eax
     439:	0f b6 00             	movzbl (%eax),%eax
     43c:	84 c0                	test   %al,%al
     43e:	75 ef                	jne    42f <strlen+0xf>
    ;
  return n;
     440:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
}
     443:	c9                   	leave  
     444:	c3                   	ret    
     445:	8d 74 26 00          	lea    0x0(%esi),%esi
     449:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00000450 <memset>:

void*
memset(void *dst, int c, uint n)
{
     450:	55                   	push   %ebp
     451:	89 e5                	mov    %esp,%ebp
     453:	83 ec 10             	sub    $0x10,%esp
  char *d;
  
  d = dst;
     456:	8b 45 08             	mov    0x8(%ebp),%eax
     459:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
  while(n-- > 0)
     45c:	eb 0e                	jmp    46c <memset+0x1c>
    *d++ = c;
     45e:	8b 45 0c             	mov    0xc(%ebp),%eax
     461:	89 c2                	mov    %eax,%edx
     463:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     466:	88 10                	mov    %dl,(%eax)
     468:	83 45 fc 01          	addl   $0x1,0xfffffffc(%ebp)
     46c:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
     470:	83 7d 10 ff          	cmpl   $0xffffffff,0x10(%ebp)
     474:	75 e8                	jne    45e <memset+0xe>
  return dst;
     476:	8b 45 08             	mov    0x8(%ebp),%eax
}
     479:	c9                   	leave  
     47a:	c3                   	ret    
     47b:	90                   	nop    
     47c:	8d 74 26 00          	lea    0x0(%esi),%esi

00000480 <strchr>:

char*
strchr(const char *s, char c)
{
     480:	55                   	push   %ebp
     481:	89 e5                	mov    %esp,%ebp
     483:	83 ec 08             	sub    $0x8,%esp
     486:	8b 45 0c             	mov    0xc(%ebp),%eax
     489:	88 45 fc             	mov    %al,0xfffffffc(%ebp)
  for(; *s; s++)
     48c:	eb 17                	jmp    4a5 <strchr+0x25>
    if(*s == c)
     48e:	8b 45 08             	mov    0x8(%ebp),%eax
     491:	0f b6 00             	movzbl (%eax),%eax
     494:	3a 45 fc             	cmp    0xfffffffc(%ebp),%al
     497:	75 08                	jne    4a1 <strchr+0x21>
      return (char*) s;
     499:	8b 45 08             	mov    0x8(%ebp),%eax
     49c:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
     49f:	eb 15                	jmp    4b6 <strchr+0x36>
     4a1:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     4a5:	8b 45 08             	mov    0x8(%ebp),%eax
     4a8:	0f b6 00             	movzbl (%eax),%eax
     4ab:	84 c0                	test   %al,%al
     4ad:	75 df                	jne    48e <strchr+0xe>
  return 0;
     4af:	c7 45 f8 00 00 00 00 	movl   $0x0,0xfffffff8(%ebp)
     4b6:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
}
     4b9:	c9                   	leave  
     4ba:	c3                   	ret    
     4bb:	90                   	nop    
     4bc:	8d 74 26 00          	lea    0x0(%esi),%esi

000004c0 <gets>:

char*
gets(char *buf, int max)
{
     4c0:	55                   	push   %ebp
     4c1:	89 e5                	mov    %esp,%ebp
     4c3:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     4c6:	c7 45 f8 00 00 00 00 	movl   $0x0,0xfffffff8(%ebp)
     4cd:	eb 46                	jmp    515 <gets+0x55>
    cc = read(0, &c, 1);
     4cf:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
     4d6:	00 
     4d7:	8d 45 f7             	lea    0xfffffff7(%ebp),%eax
     4da:	89 44 24 04          	mov    %eax,0x4(%esp)
     4de:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     4e5:	e8 52 01 00 00       	call   63c <read>
     4ea:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
    if(cc < 1)
     4ed:	83 7d fc 00          	cmpl   $0x0,0xfffffffc(%ebp)
     4f1:	7e 2d                	jle    520 <gets+0x60>
      break;
    buf[i++] = c;
     4f3:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     4f6:	89 c2                	mov    %eax,%edx
     4f8:	03 55 08             	add    0x8(%ebp),%edx
     4fb:	0f b6 45 f7          	movzbl 0xfffffff7(%ebp),%eax
     4ff:	88 02                	mov    %al,(%edx)
     501:	83 45 f8 01          	addl   $0x1,0xfffffff8(%ebp)
    if(c == '\n' || c == '\r')
     505:	0f b6 45 f7          	movzbl 0xfffffff7(%ebp),%eax
     509:	3c 0a                	cmp    $0xa,%al
     50b:	74 13                	je     520 <gets+0x60>
     50d:	0f b6 45 f7          	movzbl 0xfffffff7(%ebp),%eax
     511:	3c 0d                	cmp    $0xd,%al
     513:	74 0b                	je     520 <gets+0x60>
     515:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     518:	83 c0 01             	add    $0x1,%eax
     51b:	3b 45 0c             	cmp    0xc(%ebp),%eax
     51e:	7c af                	jl     4cf <gets+0xf>
      break;
  }
  buf[i] = '\0';
     520:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     523:	03 45 08             	add    0x8(%ebp),%eax
     526:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
     529:	8b 45 08             	mov    0x8(%ebp),%eax
}
     52c:	c9                   	leave  
     52d:	c3                   	ret    
     52e:	89 f6                	mov    %esi,%esi

00000530 <stat>:

int
stat(char *n, struct stat *st)
{
     530:	55                   	push   %ebp
     531:	89 e5                	mov    %esp,%ebp
     533:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     536:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     53d:	00 
     53e:	8b 45 08             	mov    0x8(%ebp),%eax
     541:	89 04 24             	mov    %eax,(%esp)
     544:	e8 1b 01 00 00       	call   664 <open>
     549:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
  if(fd < 0)
     54c:	83 7d f8 00          	cmpl   $0x0,0xfffffff8(%ebp)
     550:	79 09                	jns    55b <stat+0x2b>
    return -1;
     552:	c7 45 ec ff ff ff ff 	movl   $0xffffffff,0xffffffec(%ebp)
     559:	eb 26                	jmp    581 <stat+0x51>
  r = fstat(fd, st);
     55b:	8b 45 0c             	mov    0xc(%ebp),%eax
     55e:	89 44 24 04          	mov    %eax,0x4(%esp)
     562:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     565:	89 04 24             	mov    %eax,(%esp)
     568:	e8 0f 01 00 00       	call   67c <fstat>
     56d:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
  close(fd);
     570:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     573:	89 04 24             	mov    %eax,(%esp)
     576:	e8 d1 00 00 00       	call   64c <close>
  return r;
     57b:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     57e:	89 45 ec             	mov    %eax,0xffffffec(%ebp)
     581:	8b 45 ec             	mov    0xffffffec(%ebp),%eax
}
     584:	c9                   	leave  
     585:	c3                   	ret    
     586:	8d 76 00             	lea    0x0(%esi),%esi
     589:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00000590 <atoi>:

int
atoi(const char *s)
{
     590:	55                   	push   %ebp
     591:	89 e5                	mov    %esp,%ebp
     593:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
     596:	c7 45 fc 00 00 00 00 	movl   $0x0,0xfffffffc(%ebp)
  while('0' <= *s && *s <= '9')
     59d:	eb 24                	jmp    5c3 <atoi+0x33>
    n = n*10 + *s++ - '0';
     59f:	8b 55 fc             	mov    0xfffffffc(%ebp),%edx
     5a2:	89 d0                	mov    %edx,%eax
     5a4:	c1 e0 02             	shl    $0x2,%eax
     5a7:	01 d0                	add    %edx,%eax
     5a9:	01 c0                	add    %eax,%eax
     5ab:	89 c2                	mov    %eax,%edx
     5ad:	8b 45 08             	mov    0x8(%ebp),%eax
     5b0:	0f b6 00             	movzbl (%eax),%eax
     5b3:	0f be c0             	movsbl %al,%eax
     5b6:	8d 04 02             	lea    (%edx,%eax,1),%eax
     5b9:	83 e8 30             	sub    $0x30,%eax
     5bc:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
     5bf:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     5c3:	8b 45 08             	mov    0x8(%ebp),%eax
     5c6:	0f b6 00             	movzbl (%eax),%eax
     5c9:	3c 2f                	cmp    $0x2f,%al
     5cb:	7e 0a                	jle    5d7 <atoi+0x47>
     5cd:	8b 45 08             	mov    0x8(%ebp),%eax
     5d0:	0f b6 00             	movzbl (%eax),%eax
     5d3:	3c 39                	cmp    $0x39,%al
     5d5:	7e c8                	jle    59f <atoi+0xf>
  return n;
     5d7:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
}
     5da:	c9                   	leave  
     5db:	c3                   	ret    
     5dc:	8d 74 26 00          	lea    0x0(%esi),%esi

000005e0 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
     5e0:	55                   	push   %ebp
     5e1:	89 e5                	mov    %esp,%ebp
     5e3:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
     5e6:	8b 45 08             	mov    0x8(%ebp),%eax
     5e9:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
  src = vsrc;
     5ec:	8b 45 0c             	mov    0xc(%ebp),%eax
     5ef:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
  while(n-- > 0)
     5f2:	eb 13                	jmp    607 <memmove+0x27>
    *dst++ = *src++;
     5f4:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     5f7:	0f b6 10             	movzbl (%eax),%edx
     5fa:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     5fd:	88 10                	mov    %dl,(%eax)
     5ff:	83 45 f8 01          	addl   $0x1,0xfffffff8(%ebp)
     603:	83 45 fc 01          	addl   $0x1,0xfffffffc(%ebp)
     607:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     60b:	0f 9f c0             	setg   %al
     60e:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
     612:	84 c0                	test   %al,%al
     614:	75 de                	jne    5f4 <memmove+0x14>
  return vdst;
     616:	8b 45 08             	mov    0x8(%ebp),%eax
}
     619:	c9                   	leave  
     61a:	c3                   	ret    
     61b:	90                   	nop    

0000061c <fork>:
     61c:	b8 01 00 00 00       	mov    $0x1,%eax
     621:	cd 30                	int    $0x30
     623:	c3                   	ret    

00000624 <exit>:
     624:	b8 02 00 00 00       	mov    $0x2,%eax
     629:	cd 30                	int    $0x30
     62b:	c3                   	ret    

0000062c <wait>:
     62c:	b8 03 00 00 00       	mov    $0x3,%eax
     631:	cd 30                	int    $0x30
     633:	c3                   	ret    

00000634 <pipe>:
     634:	b8 04 00 00 00       	mov    $0x4,%eax
     639:	cd 30                	int    $0x30
     63b:	c3                   	ret    

0000063c <read>:
     63c:	b8 06 00 00 00       	mov    $0x6,%eax
     641:	cd 30                	int    $0x30
     643:	c3                   	ret    

00000644 <write>:
     644:	b8 05 00 00 00       	mov    $0x5,%eax
     649:	cd 30                	int    $0x30
     64b:	c3                   	ret    

0000064c <close>:
     64c:	b8 07 00 00 00       	mov    $0x7,%eax
     651:	cd 30                	int    $0x30
     653:	c3                   	ret    

00000654 <kill>:
     654:	b8 08 00 00 00       	mov    $0x8,%eax
     659:	cd 30                	int    $0x30
     65b:	c3                   	ret    

0000065c <exec>:
     65c:	b8 09 00 00 00       	mov    $0x9,%eax
     661:	cd 30                	int    $0x30
     663:	c3                   	ret    

00000664 <open>:
     664:	b8 0a 00 00 00       	mov    $0xa,%eax
     669:	cd 30                	int    $0x30
     66b:	c3                   	ret    

0000066c <mknod>:
     66c:	b8 0b 00 00 00       	mov    $0xb,%eax
     671:	cd 30                	int    $0x30
     673:	c3                   	ret    

00000674 <unlink>:
     674:	b8 0c 00 00 00       	mov    $0xc,%eax
     679:	cd 30                	int    $0x30
     67b:	c3                   	ret    

0000067c <fstat>:
     67c:	b8 0d 00 00 00       	mov    $0xd,%eax
     681:	cd 30                	int    $0x30
     683:	c3                   	ret    

00000684 <link>:
     684:	b8 0e 00 00 00       	mov    $0xe,%eax
     689:	cd 30                	int    $0x30
     68b:	c3                   	ret    

0000068c <mkdir>:
     68c:	b8 0f 00 00 00       	mov    $0xf,%eax
     691:	cd 30                	int    $0x30
     693:	c3                   	ret    

00000694 <chdir>:
     694:	b8 10 00 00 00       	mov    $0x10,%eax
     699:	cd 30                	int    $0x30
     69b:	c3                   	ret    

0000069c <dup>:
     69c:	b8 11 00 00 00       	mov    $0x11,%eax
     6a1:	cd 30                	int    $0x30
     6a3:	c3                   	ret    

000006a4 <getpid>:
     6a4:	b8 12 00 00 00       	mov    $0x12,%eax
     6a9:	cd 30                	int    $0x30
     6ab:	c3                   	ret    

000006ac <sbrk>:
     6ac:	b8 13 00 00 00       	mov    $0x13,%eax
     6b1:	cd 30                	int    $0x30
     6b3:	c3                   	ret    

000006b4 <sleep>:
     6b4:	b8 14 00 00 00       	mov    $0x14,%eax
     6b9:	cd 30                	int    $0x30
     6bb:	c3                   	ret    

000006bc <upmsec>:
     6bc:	b8 15 00 00 00       	mov    $0x15,%eax
     6c1:	cd 30                	int    $0x30
     6c3:	c3                   	ret    

000006c4 <socket>:
     6c4:	b8 16 00 00 00       	mov    $0x16,%eax
     6c9:	cd 30                	int    $0x30
     6cb:	c3                   	ret    

000006cc <bind>:
     6cc:	b8 17 00 00 00       	mov    $0x17,%eax
     6d1:	cd 30                	int    $0x30
     6d3:	c3                   	ret    

000006d4 <listen>:
     6d4:	b8 18 00 00 00       	mov    $0x18,%eax
     6d9:	cd 30                	int    $0x30
     6db:	c3                   	ret    

000006dc <accept>:
     6dc:	b8 19 00 00 00       	mov    $0x19,%eax
     6e1:	cd 30                	int    $0x30
     6e3:	c3                   	ret    

000006e4 <recv>:
     6e4:	b8 1a 00 00 00       	mov    $0x1a,%eax
     6e9:	cd 30                	int    $0x30
     6eb:	c3                   	ret    

000006ec <recvfrom>:
     6ec:	b8 1b 00 00 00       	mov    $0x1b,%eax
     6f1:	cd 30                	int    $0x30
     6f3:	c3                   	ret    

000006f4 <send>:
     6f4:	b8 1c 00 00 00       	mov    $0x1c,%eax
     6f9:	cd 30                	int    $0x30
     6fb:	c3                   	ret    

000006fc <sendto>:
     6fc:	b8 1d 00 00 00       	mov    $0x1d,%eax
     701:	cd 30                	int    $0x30
     703:	c3                   	ret    

00000704 <shutdown>:
     704:	b8 1e 00 00 00       	mov    $0x1e,%eax
     709:	cd 30                	int    $0x30
     70b:	c3                   	ret    

0000070c <getsockopt>:
     70c:	b8 1f 00 00 00       	mov    $0x1f,%eax
     711:	cd 30                	int    $0x30
     713:	c3                   	ret    

00000714 <setsockopt>:
     714:	b8 20 00 00 00       	mov    $0x20,%eax
     719:	cd 30                	int    $0x30
     71b:	c3                   	ret    

0000071c <sockclose>:
     71c:	b8 21 00 00 00       	mov    $0x21,%eax
     721:	cd 30                	int    $0x30
     723:	c3                   	ret    

00000724 <connect>:
     724:	b8 22 00 00 00       	mov    $0x22,%eax
     729:	cd 30                	int    $0x30
     72b:	c3                   	ret    

0000072c <getpeername>:
     72c:	b8 23 00 00 00       	mov    $0x23,%eax
     731:	cd 30                	int    $0x30
     733:	c3                   	ret    

00000734 <getsockname>:
     734:	b8 24 00 00 00       	mov    $0x24,%eax
     739:	cd 30                	int    $0x30
     73b:	c3                   	ret    
     73c:	90                   	nop    
     73d:	90                   	nop    
     73e:	90                   	nop    
     73f:	90                   	nop    

00000740 <putc>:
#include "user.h"

void
putc(int fd, char c)
{
     740:	55                   	push   %ebp
     741:	89 e5                	mov    %esp,%ebp
     743:	83 ec 18             	sub    $0x18,%esp
     746:	8b 45 0c             	mov    0xc(%ebp),%eax
     749:	88 45 fc             	mov    %al,0xfffffffc(%ebp)
  write(fd, &c, 1);
     74c:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
     753:	00 
     754:	8d 45 fc             	lea    0xfffffffc(%ebp),%eax
     757:	89 44 24 04          	mov    %eax,0x4(%esp)
     75b:	8b 45 08             	mov    0x8(%ebp),%eax
     75e:	89 04 24             	mov    %eax,(%esp)
     761:	e8 de fe ff ff       	call   644 <write>
}
     766:	c9                   	leave  
     767:	c3                   	ret    
     768:	90                   	nop    
     769:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi

00000770 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     770:	55                   	push   %ebp
     771:	89 e5                	mov    %esp,%ebp
     773:	53                   	push   %ebx
     774:	83 ec 34             	sub    $0x34,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     777:	c7 45 f4 00 00 00 00 	movl   $0x0,0xfffffff4(%ebp)
  if(sgn && xx < 0){
     77e:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
     782:	74 17                	je     79b <printint+0x2b>
     784:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     788:	79 11                	jns    79b <printint+0x2b>
    neg = 1;
     78a:	c7 45 f4 01 00 00 00 	movl   $0x1,0xfffffff4(%ebp)
    x = -xx;
     791:	8b 45 0c             	mov    0xc(%ebp),%eax
     794:	f7 d8                	neg    %eax
     796:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
     799:	eb 06                	jmp    7a1 <printint+0x31>
  } else {
    x = xx;
     79b:	8b 45 0c             	mov    0xc(%ebp),%eax
     79e:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
  }

  i = 0;
     7a1:	c7 45 f0 00 00 00 00 	movl   $0x0,0xfffffff0(%ebp)
  do{
    buf[i++] = digits[x % base];
     7a8:	8b 4d f0             	mov    0xfffffff0(%ebp),%ecx
     7ab:	8b 55 10             	mov    0x10(%ebp),%edx
     7ae:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     7b1:	89 d3                	mov    %edx,%ebx
     7b3:	ba 00 00 00 00       	mov    $0x0,%edx
     7b8:	f7 f3                	div    %ebx
     7ba:	89 d0                	mov    %edx,%eax
     7bc:	0f b6 80 1c 14 00 00 	movzbl 0x141c(%eax),%eax
     7c3:	88 44 0d e0          	mov    %al,0xffffffe0(%ebp,%ecx,1)
     7c7:	83 45 f0 01          	addl   $0x1,0xfffffff0(%ebp)
  }while((x /= base) != 0);
     7cb:	8b 55 10             	mov    0x10(%ebp),%edx
     7ce:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     7d1:	89 d1                	mov    %edx,%ecx
     7d3:	ba 00 00 00 00       	mov    $0x0,%edx
     7d8:	f7 f1                	div    %ecx
     7da:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
     7dd:	83 7d f8 00          	cmpl   $0x0,0xfffffff8(%ebp)
     7e1:	75 c5                	jne    7a8 <printint+0x38>
  if(neg)
     7e3:	83 7d f4 00          	cmpl   $0x0,0xfffffff4(%ebp)
     7e7:	74 28                	je     811 <printint+0xa1>
    buf[i++] = '-';
     7e9:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
     7ec:	c6 44 05 e0 2d       	movb   $0x2d,0xffffffe0(%ebp,%eax,1)
     7f1:	83 45 f0 01          	addl   $0x1,0xfffffff0(%ebp)

  while(--i >= 0)
     7f5:	eb 1a                	jmp    811 <printint+0xa1>
    putc(fd, buf[i]);
     7f7:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
     7fa:	0f b6 44 05 e0       	movzbl 0xffffffe0(%ebp,%eax,1),%eax
     7ff:	0f be c0             	movsbl %al,%eax
     802:	89 44 24 04          	mov    %eax,0x4(%esp)
     806:	8b 45 08             	mov    0x8(%ebp),%eax
     809:	89 04 24             	mov    %eax,(%esp)
     80c:	e8 2f ff ff ff       	call   740 <putc>
     811:	83 6d f0 01          	subl   $0x1,0xfffffff0(%ebp)
     815:	83 7d f0 00          	cmpl   $0x0,0xfffffff0(%ebp)
     819:	79 dc                	jns    7f7 <printint+0x87>
}
     81b:	83 c4 34             	add    $0x34,%esp
     81e:	5b                   	pop    %ebx
     81f:	5d                   	pop    %ebp
     820:	c3                   	ret    
     821:	eb 0d                	jmp    830 <printf>
     823:	90                   	nop    
     824:	90                   	nop    
     825:	90                   	nop    
     826:	90                   	nop    
     827:	90                   	nop    
     828:	90                   	nop    
     829:	90                   	nop    
     82a:	90                   	nop    
     82b:	90                   	nop    
     82c:	90                   	nop    
     82d:	90                   	nop    
     82e:	90                   	nop    
     82f:	90                   	nop    

00000830 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
     830:	55                   	push   %ebp
     831:	89 e5                	mov    %esp,%ebp
     833:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
     836:	c7 45 f8 00 00 00 00 	movl   $0x0,0xfffffff8(%ebp)
  ap = (uint*)(void*)&fmt + 1;
     83d:	8d 45 0c             	lea    0xc(%ebp),%eax
     840:	83 c0 04             	add    $0x4,%eax
     843:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
  for(i = 0; fmt[i]; i++){
     846:	c7 45 f4 00 00 00 00 	movl   $0x0,0xfffffff4(%ebp)
     84d:	e9 7b 01 00 00       	jmp    9cd <printf+0x19d>
    c = fmt[i] & 0xff;
     852:	8b 55 0c             	mov    0xc(%ebp),%edx
     855:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     858:	8d 04 02             	lea    (%edx,%eax,1),%eax
     85b:	0f b6 00             	movzbl (%eax),%eax
     85e:	0f be c0             	movsbl %al,%eax
     861:	25 ff 00 00 00       	and    $0xff,%eax
     866:	89 45 f0             	mov    %eax,0xfffffff0(%ebp)
    if(state == 0){
     869:	83 7d f8 00          	cmpl   $0x0,0xfffffff8(%ebp)
     86d:	75 2c                	jne    89b <printf+0x6b>
      if(c == '%'){
     86f:	83 7d f0 25          	cmpl   $0x25,0xfffffff0(%ebp)
     873:	75 0c                	jne    881 <printf+0x51>
        state = '%';
     875:	c7 45 f8 25 00 00 00 	movl   $0x25,0xfffffff8(%ebp)
     87c:	e9 48 01 00 00       	jmp    9c9 <printf+0x199>
      } else {
        putc(fd, c);
     881:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
     884:	0f be c0             	movsbl %al,%eax
     887:	89 44 24 04          	mov    %eax,0x4(%esp)
     88b:	8b 45 08             	mov    0x8(%ebp),%eax
     88e:	89 04 24             	mov    %eax,(%esp)
     891:	e8 aa fe ff ff       	call   740 <putc>
     896:	e9 2e 01 00 00       	jmp    9c9 <printf+0x199>
      }
    } else if(state == '%'){
     89b:	83 7d f8 25          	cmpl   $0x25,0xfffffff8(%ebp)
     89f:	0f 85 24 01 00 00    	jne    9c9 <printf+0x199>
      if(c == 'd'){
     8a5:	83 7d f0 64          	cmpl   $0x64,0xfffffff0(%ebp)
     8a9:	75 2d                	jne    8d8 <printf+0xa8>
        printint(fd, *ap, 10, 1);
     8ab:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     8ae:	8b 00                	mov    (%eax),%eax
     8b0:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
     8b7:	00 
     8b8:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
     8bf:	00 
     8c0:	89 44 24 04          	mov    %eax,0x4(%esp)
     8c4:	8b 45 08             	mov    0x8(%ebp),%eax
     8c7:	89 04 24             	mov    %eax,(%esp)
     8ca:	e8 a1 fe ff ff       	call   770 <printint>
        ap++;
     8cf:	83 45 fc 04          	addl   $0x4,0xfffffffc(%ebp)
     8d3:	e9 ea 00 00 00       	jmp    9c2 <printf+0x192>
      } else if(c == 'x' || c == 'p'){
     8d8:	83 7d f0 78          	cmpl   $0x78,0xfffffff0(%ebp)
     8dc:	74 06                	je     8e4 <printf+0xb4>
     8de:	83 7d f0 70          	cmpl   $0x70,0xfffffff0(%ebp)
     8e2:	75 2d                	jne    911 <printf+0xe1>
        printint(fd, *ap, 16, 0);
     8e4:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     8e7:	8b 00                	mov    (%eax),%eax
     8e9:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
     8f0:	00 
     8f1:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
     8f8:	00 
     8f9:	89 44 24 04          	mov    %eax,0x4(%esp)
     8fd:	8b 45 08             	mov    0x8(%ebp),%eax
     900:	89 04 24             	mov    %eax,(%esp)
     903:	e8 68 fe ff ff       	call   770 <printint>
        ap++;
     908:	83 45 fc 04          	addl   $0x4,0xfffffffc(%ebp)
     90c:	e9 b1 00 00 00       	jmp    9c2 <printf+0x192>
      } else if(c == 's'){
     911:	83 7d f0 73          	cmpl   $0x73,0xfffffff0(%ebp)
     915:	75 43                	jne    95a <printf+0x12a>
        s = (char*)*ap;
     917:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     91a:	8b 00                	mov    (%eax),%eax
     91c:	89 45 ec             	mov    %eax,0xffffffec(%ebp)
        ap++;
     91f:	83 45 fc 04          	addl   $0x4,0xfffffffc(%ebp)
        if(s == 0)
     923:	83 7d ec 00          	cmpl   $0x0,0xffffffec(%ebp)
     927:	75 25                	jne    94e <printf+0x11e>
          s = "(null)";
     929:	c7 45 ec fe 13 00 00 	movl   $0x13fe,0xffffffec(%ebp)
        while(*s != 0){
     930:	eb 1c                	jmp    94e <printf+0x11e>
          putc(fd, *s);
     932:	8b 45 ec             	mov    0xffffffec(%ebp),%eax
     935:	0f b6 00             	movzbl (%eax),%eax
     938:	0f be c0             	movsbl %al,%eax
     93b:	89 44 24 04          	mov    %eax,0x4(%esp)
     93f:	8b 45 08             	mov    0x8(%ebp),%eax
     942:	89 04 24             	mov    %eax,(%esp)
     945:	e8 f6 fd ff ff       	call   740 <putc>
          s++;
     94a:	83 45 ec 01          	addl   $0x1,0xffffffec(%ebp)
     94e:	8b 45 ec             	mov    0xffffffec(%ebp),%eax
     951:	0f b6 00             	movzbl (%eax),%eax
     954:	84 c0                	test   %al,%al
     956:	75 da                	jne    932 <printf+0x102>
     958:	eb 68                	jmp    9c2 <printf+0x192>
        }
      } else if(c == 'c'){
     95a:	83 7d f0 63          	cmpl   $0x63,0xfffffff0(%ebp)
     95e:	75 1d                	jne    97d <printf+0x14d>
        putc(fd, *ap);
     960:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     963:	8b 00                	mov    (%eax),%eax
     965:	0f be c0             	movsbl %al,%eax
     968:	89 44 24 04          	mov    %eax,0x4(%esp)
     96c:	8b 45 08             	mov    0x8(%ebp),%eax
     96f:	89 04 24             	mov    %eax,(%esp)
     972:	e8 c9 fd ff ff       	call   740 <putc>
        ap++;
     977:	83 45 fc 04          	addl   $0x4,0xfffffffc(%ebp)
     97b:	eb 45                	jmp    9c2 <printf+0x192>
      } else if(c == '%'){
     97d:	83 7d f0 25          	cmpl   $0x25,0xfffffff0(%ebp)
     981:	75 17                	jne    99a <printf+0x16a>
        putc(fd, c);
     983:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
     986:	0f be c0             	movsbl %al,%eax
     989:	89 44 24 04          	mov    %eax,0x4(%esp)
     98d:	8b 45 08             	mov    0x8(%ebp),%eax
     990:	89 04 24             	mov    %eax,(%esp)
     993:	e8 a8 fd ff ff       	call   740 <putc>
     998:	eb 28                	jmp    9c2 <printf+0x192>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     99a:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
     9a1:	00 
     9a2:	8b 45 08             	mov    0x8(%ebp),%eax
     9a5:	89 04 24             	mov    %eax,(%esp)
     9a8:	e8 93 fd ff ff       	call   740 <putc>
        putc(fd, c);
     9ad:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
     9b0:	0f be c0             	movsbl %al,%eax
     9b3:	89 44 24 04          	mov    %eax,0x4(%esp)
     9b7:	8b 45 08             	mov    0x8(%ebp),%eax
     9ba:	89 04 24             	mov    %eax,(%esp)
     9bd:	e8 7e fd ff ff       	call   740 <putc>
      }
      state = 0;
     9c2:	c7 45 f8 00 00 00 00 	movl   $0x0,0xfffffff8(%ebp)
     9c9:	83 45 f4 01          	addl   $0x1,0xfffffff4(%ebp)
     9cd:	8b 55 0c             	mov    0xc(%ebp),%edx
     9d0:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     9d3:	8d 04 02             	lea    (%edx,%eax,1),%eax
     9d6:	0f b6 00             	movzbl (%eax),%eax
     9d9:	84 c0                	test   %al,%al
     9db:	0f 85 71 fe ff ff    	jne    852 <printf+0x22>
    }
  }
}
     9e1:	c9                   	leave  
     9e2:	c3                   	ret    
     9e3:	90                   	nop    
     9e4:	90                   	nop    
     9e5:	90                   	nop    
     9e6:	90                   	nop    
     9e7:	90                   	nop    
     9e8:	90                   	nop    
     9e9:	90                   	nop    
     9ea:	90                   	nop    
     9eb:	90                   	nop    
     9ec:	90                   	nop    
     9ed:	90                   	nop    
     9ee:	90                   	nop    
     9ef:	90                   	nop    

000009f0 <free>:
static Header *freep;

void
free(void *ap)
{
     9f0:	55                   	push   %ebp
     9f1:	89 e5                	mov    %esp,%ebp
     9f3:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*) ap - 1;
     9f6:	8b 45 08             	mov    0x8(%ebp),%eax
     9f9:	83 e8 08             	sub    $0x8,%eax
     9fc:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     9ff:	a1 48 14 00 00       	mov    0x1448,%eax
     a04:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
     a07:	eb 24                	jmp    a2d <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     a09:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     a0c:	8b 00                	mov    (%eax),%eax
     a0e:	3b 45 fc             	cmp    0xfffffffc(%ebp),%eax
     a11:	77 12                	ja     a25 <free+0x35>
     a13:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     a16:	3b 45 fc             	cmp    0xfffffffc(%ebp),%eax
     a19:	77 24                	ja     a3f <free+0x4f>
     a1b:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     a1e:	8b 00                	mov    (%eax),%eax
     a20:	3b 45 f8             	cmp    0xfffffff8(%ebp),%eax
     a23:	77 1a                	ja     a3f <free+0x4f>
     a25:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     a28:	8b 00                	mov    (%eax),%eax
     a2a:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
     a2d:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     a30:	3b 45 fc             	cmp    0xfffffffc(%ebp),%eax
     a33:	76 d4                	jbe    a09 <free+0x19>
     a35:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     a38:	8b 00                	mov    (%eax),%eax
     a3a:	3b 45 f8             	cmp    0xfffffff8(%ebp),%eax
     a3d:	76 ca                	jbe    a09 <free+0x19>
      break;
  if(bp + bp->s.size == p->s.ptr){
     a3f:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     a42:	8b 40 04             	mov    0x4(%eax),%eax
     a45:	c1 e0 03             	shl    $0x3,%eax
     a48:	89 c2                	mov    %eax,%edx
     a4a:	03 55 f8             	add    0xfffffff8(%ebp),%edx
     a4d:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     a50:	8b 00                	mov    (%eax),%eax
     a52:	39 c2                	cmp    %eax,%edx
     a54:	75 24                	jne    a7a <free+0x8a>
    bp->s.size += p->s.ptr->s.size;
     a56:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     a59:	8b 50 04             	mov    0x4(%eax),%edx
     a5c:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     a5f:	8b 00                	mov    (%eax),%eax
     a61:	8b 40 04             	mov    0x4(%eax),%eax
     a64:	01 c2                	add    %eax,%edx
     a66:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     a69:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
     a6c:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     a6f:	8b 00                	mov    (%eax),%eax
     a71:	8b 10                	mov    (%eax),%edx
     a73:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     a76:	89 10                	mov    %edx,(%eax)
     a78:	eb 0a                	jmp    a84 <free+0x94>
  } else
    bp->s.ptr = p->s.ptr;
     a7a:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     a7d:	8b 10                	mov    (%eax),%edx
     a7f:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     a82:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
     a84:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     a87:	8b 40 04             	mov    0x4(%eax),%eax
     a8a:	c1 e0 03             	shl    $0x3,%eax
     a8d:	03 45 fc             	add    0xfffffffc(%ebp),%eax
     a90:	3b 45 f8             	cmp    0xfffffff8(%ebp),%eax
     a93:	75 20                	jne    ab5 <free+0xc5>
    p->s.size += bp->s.size;
     a95:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     a98:	8b 50 04             	mov    0x4(%eax),%edx
     a9b:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     a9e:	8b 40 04             	mov    0x4(%eax),%eax
     aa1:	01 c2                	add    %eax,%edx
     aa3:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     aa6:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
     aa9:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     aac:	8b 10                	mov    (%eax),%edx
     aae:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     ab1:	89 10                	mov    %edx,(%eax)
     ab3:	eb 08                	jmp    abd <free+0xcd>
  } else
    p->s.ptr = bp;
     ab5:	8b 55 fc             	mov    0xfffffffc(%ebp),%edx
     ab8:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     abb:	89 02                	mov    %eax,(%edx)
  freep = p;
     abd:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     ac0:	a3 48 14 00 00       	mov    %eax,0x1448
}
     ac5:	c9                   	leave  
     ac6:	c3                   	ret    
     ac7:	89 f6                	mov    %esi,%esi
     ac9:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00000ad0 <morecore>:

static Header*
morecore(uint nu)
{
     ad0:	55                   	push   %ebp
     ad1:	89 e5                	mov    %esp,%ebp
     ad3:	83 ec 18             	sub    $0x18,%esp
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
     ad6:	8b 45 08             	mov    0x8(%ebp),%eax
     ad9:	c1 e0 03             	shl    $0x3,%eax
     adc:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
  size += PAGE - size % PAGE;
     adf:	8b 55 fc             	mov    0xfffffffc(%ebp),%edx
     ae2:	89 d0                	mov    %edx,%eax
     ae4:	c1 f8 1f             	sar    $0x1f,%eax
     ae7:	89 c1                	mov    %eax,%ecx
     ae9:	c1 e9 14             	shr    $0x14,%ecx
     aec:	8d 04 0a             	lea    (%edx,%ecx,1),%eax
     aef:	25 ff 0f 00 00       	and    $0xfff,%eax
     af4:	29 c8                	sub    %ecx,%eax
     af6:	89 c2                	mov    %eax,%edx
     af8:	b8 00 10 00 00       	mov    $0x1000,%eax
     afd:	29 d0                	sub    %edx,%eax
     aff:	01 45 fc             	add    %eax,0xfffffffc(%ebp)
#endif
#ifdef UMALLOC_DEBUG
  printf(1, "size: %d\n", size);
#endif
  p = sbrk(size);
     b02:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     b05:	89 04 24             	mov    %eax,(%esp)
     b08:	e8 9f fb ff ff       	call   6ac <sbrk>
     b0d:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
  if(p == (char*) -1)
     b10:	83 7d f4 ff          	cmpl   $0xffffffff,0xfffffff4(%ebp)
     b14:	75 09                	jne    b1f <morecore+0x4f>
    return 0;
     b16:	c7 45 ec 00 00 00 00 	movl   $0x0,0xffffffec(%ebp)
     b1d:	eb 2a                	jmp    b49 <morecore+0x79>
  hp = (Header*)p;
     b1f:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     b22:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
#ifdef UMALLOC_NOALIGN
  hp->s.size = nu;
#else
  hp->s.size = size / sizeof(Header);
     b25:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     b28:	89 c2                	mov    %eax,%edx
     b2a:	c1 ea 03             	shr    $0x3,%edx
     b2d:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     b30:	89 50 04             	mov    %edx,0x4(%eax)
#endif
  free((void*)(hp + 1));
     b33:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     b36:	83 c0 08             	add    $0x8,%eax
     b39:	89 04 24             	mov    %eax,(%esp)
     b3c:	e8 af fe ff ff       	call   9f0 <free>
  return freep;
     b41:	a1 48 14 00 00       	mov    0x1448,%eax
     b46:	89 45 ec             	mov    %eax,0xffffffec(%ebp)
     b49:	8b 45 ec             	mov    0xffffffec(%ebp),%eax
}
     b4c:	c9                   	leave  
     b4d:	c3                   	ret    
     b4e:	89 f6                	mov    %esi,%esi

00000b50 <malloc>:

void*
malloc(uint nbytes)
{
     b50:	55                   	push   %ebp
     b51:	89 e5                	mov    %esp,%ebp
     b53:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

#ifdef UMALLOC_DEBUG
  printf(1, "malloc: %d bytes\n", nbytes);
  printf(1, "size of Header: %d\n", sizeof(Header));
#endif
  if (PAGE % sizeof(Header))
      printf(2, "Warning! align failed! Need UMALLOC_NOALIGN\n");
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     b56:	8b 45 08             	mov    0x8(%ebp),%eax
     b59:	83 c0 07             	add    $0x7,%eax
     b5c:	c1 e8 03             	shr    $0x3,%eax
     b5f:	83 c0 01             	add    $0x1,%eax
     b62:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
  if((prevp = freep) == 0){
     b65:	a1 48 14 00 00       	mov    0x1448,%eax
     b6a:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
     b6d:	83 7d f8 00          	cmpl   $0x0,0xfffffff8(%ebp)
     b71:	75 23                	jne    b96 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
     b73:	c7 45 f8 40 14 00 00 	movl   $0x1440,0xfffffff8(%ebp)
     b7a:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     b7d:	a3 48 14 00 00       	mov    %eax,0x1448
     b82:	a1 48 14 00 00       	mov    0x1448,%eax
     b87:	a3 40 14 00 00       	mov    %eax,0x1440
    base.s.size = 0;
     b8c:	c7 05 44 14 00 00 00 	movl   $0x0,0x1444
     b93:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     b96:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     b99:	8b 00                	mov    (%eax),%eax
     b9b:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
    if(p->s.size >= nunits){
     b9e:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     ba1:	8b 40 04             	mov    0x4(%eax),%eax
     ba4:	3b 45 fc             	cmp    0xfffffffc(%ebp),%eax
     ba7:	72 50                	jb     bf9 <malloc+0xa9>
      if(p->s.size == nunits)
     ba9:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     bac:	8b 40 04             	mov    0x4(%eax),%eax
     baf:	3b 45 fc             	cmp    0xfffffffc(%ebp),%eax
     bb2:	75 0c                	jne    bc0 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
     bb4:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     bb7:	8b 10                	mov    (%eax),%edx
     bb9:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     bbc:	89 10                	mov    %edx,(%eax)
     bbe:	eb 26                	jmp    be6 <malloc+0x96>
      else {
        p->s.size -= nunits;
     bc0:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     bc3:	8b 40 04             	mov    0x4(%eax),%eax
     bc6:	89 c2                	mov    %eax,%edx
     bc8:	2b 55 fc             	sub    0xfffffffc(%ebp),%edx
     bcb:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     bce:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
     bd1:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     bd4:	8b 40 04             	mov    0x4(%eax),%eax
     bd7:	c1 e0 03             	shl    $0x3,%eax
     bda:	01 45 f4             	add    %eax,0xfffffff4(%ebp)
        p->s.size = nunits;
     bdd:	8b 55 f4             	mov    0xfffffff4(%ebp),%edx
     be0:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     be3:	89 42 04             	mov    %eax,0x4(%edx)
      }
      freep = prevp;
     be6:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     be9:	a3 48 14 00 00       	mov    %eax,0x1448
      return (void*) (p + 1);
     bee:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     bf1:	83 c0 08             	add    $0x8,%eax
     bf4:	89 45 ec             	mov    %eax,0xffffffec(%ebp)
     bf7:	eb 3a                	jmp    c33 <malloc+0xe3>
    }
    if(p == freep)
     bf9:	a1 48 14 00 00       	mov    0x1448,%eax
     bfe:	39 45 f4             	cmp    %eax,0xfffffff4(%ebp)
     c01:	75 1d                	jne    c20 <malloc+0xd0>
      if((p = morecore(nunits)) == 0)
     c03:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     c06:	89 04 24             	mov    %eax,(%esp)
     c09:	e8 c2 fe ff ff       	call   ad0 <morecore>
     c0e:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
     c11:	83 7d f4 00          	cmpl   $0x0,0xfffffff4(%ebp)
     c15:	75 09                	jne    c20 <malloc+0xd0>
        return 0;
     c17:	c7 45 ec 00 00 00 00 	movl   $0x0,0xffffffec(%ebp)
     c1e:	eb 13                	jmp    c33 <malloc+0xe3>
     c20:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     c23:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
     c26:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     c29:	8b 00                	mov    (%eax),%eax
     c2b:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
  }
     c2e:	e9 6b ff ff ff       	jmp    b9e <malloc+0x4e>
     c33:	8b 45 ec             	mov    0xffffffec(%ebp),%eax
}
     c36:	c9                   	leave  
     c37:	c3                   	ret    
     c38:	90                   	nop    
     c39:	90                   	nop    
     c3a:	90                   	nop    
     c3b:	90                   	nop    
     c3c:	90                   	nop    
     c3d:	90                   	nop    
     c3e:	90                   	nop    
     c3f:	90                   	nop    

00000c40 <lwip_chksum>:


static u16_t
lwip_chksum(void *dataptr, int len)
{
     c40:	55                   	push   %ebp
     c41:	89 e5                	mov    %esp,%ebp
     c43:	83 ec 18             	sub    $0x18,%esp
  u32_t acc;

  LWIP_DEBUGF(INET_DEBUG, ("lwip_chksum(%p, %d)\n", (void *)dataptr, len));
  for(acc = 0; len > 1; len -= 2) {
     c46:	c7 45 fc 00 00 00 00 	movl   $0x0,0xfffffffc(%ebp)
     c4d:	eb 19                	jmp    c68 <lwip_chksum+0x28>
      /*    acc = acc + *((u16_t *)dataptr)++;*/
    acc += *(u16_t *)dataptr;
     c4f:	8b 45 08             	mov    0x8(%ebp),%eax
     c52:	0f b7 00             	movzwl (%eax),%eax
     c55:	0f b7 c0             	movzwl %ax,%eax
     c58:	01 45 fc             	add    %eax,0xfffffffc(%ebp)
    dataptr = (void *)((u16_t *)dataptr + 1);
     c5b:	8b 45 08             	mov    0x8(%ebp),%eax
     c5e:	83 c0 02             	add    $0x2,%eax
     c61:	89 45 08             	mov    %eax,0x8(%ebp)
     c64:	83 6d 0c 02          	subl   $0x2,0xc(%ebp)
     c68:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
     c6c:	7f e1                	jg     c4f <lwip_chksum+0xf>
  }

  /* add up any odd byte */
  if (len == 1) {
     c6e:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
     c72:	75 1d                	jne    c91 <lwip_chksum+0x51>
    acc += htons((u16_t)((*(u8_t *)dataptr) & 0xff) << 8);
     c74:	8b 45 08             	mov    0x8(%ebp),%eax
     c77:	0f b6 00             	movzbl (%eax),%eax
     c7a:	0f b6 c0             	movzbl %al,%eax
     c7d:	c1 e0 08             	shl    $0x8,%eax
     c80:	0f b7 c0             	movzwl %ax,%eax
     c83:	89 04 24             	mov    %eax,(%esp)
     c86:	e8 85 06 00 00       	call   1310 <htons>
     c8b:	0f b7 c0             	movzwl %ax,%eax
     c8e:	01 45 fc             	add    %eax,0xfffffffc(%ebp)
    LWIP_DEBUGF(INET_DEBUG, ("inet: chksum: odd byte %d\n", (unsigned int)(*(u8_t *)dataptr)));
  } else {
    LWIP_DEBUGF(INET_DEBUG, ("inet: chksum: no odd byte\n"));
  }
  acc = (acc >> 16) + (acc & 0xffffUL);
     c91:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     c94:	89 c2                	mov    %eax,%edx
     c96:	c1 ea 10             	shr    $0x10,%edx
     c99:	0f b7 45 fc          	movzwl 0xfffffffc(%ebp),%eax
     c9d:	8d 04 02             	lea    (%edx,%eax,1),%eax
     ca0:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)

  if ((acc & 0xffff0000) != 0) {
     ca3:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     ca6:	66 b8 00 00          	mov    $0x0,%ax
     caa:	85 c0                	test   %eax,%eax
     cac:	74 12                	je     cc0 <lwip_chksum+0x80>
    acc = (acc >> 16) + (acc & 0xffffUL);
     cae:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     cb1:	89 c2                	mov    %eax,%edx
     cb3:	c1 ea 10             	shr    $0x10,%edx
     cb6:	0f b7 45 fc          	movzwl 0xfffffffc(%ebp),%eax
     cba:	8d 04 02             	lea    (%edx,%eax,1),%eax
     cbd:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
  }

  return (u16_t)acc;
     cc0:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     cc3:	0f b7 c0             	movzwl %ax,%eax
}
     cc6:	c9                   	leave  
     cc7:	c3                   	ret    
     cc8:	90                   	nop    
     cc9:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi

00000cd0 <inet_chksum_pseudo>:

/* inet_chksum_pseudo:
 *
 * Calculates the pseudo Internet checksum used by TCP and UDP for a pbuf chain.
 */

u16_t
inet_chksum_pseudo(struct pbuf *p,
       struct ip_addr *src, struct ip_addr *dest,
       u8_t proto, u16_t proto_len)
{
     cd0:	55                   	push   %ebp
     cd1:	89 e5                	mov    %esp,%ebp
     cd3:	83 ec 28             	sub    $0x28,%esp
     cd6:	8b 45 14             	mov    0x14(%ebp),%eax
     cd9:	8b 55 18             	mov    0x18(%ebp),%edx
     cdc:	88 45 ec             	mov    %al,0xffffffec(%ebp)
     cdf:	66 89 55 e8          	mov    %dx,0xffffffe8(%ebp)
  u32_t acc;
  struct pbuf *q;
  u8_t swapped;

  acc = 0;
     ce3:	c7 45 f4 00 00 00 00 	movl   $0x0,0xfffffff4(%ebp)
  swapped = 0;
     cea:	c6 45 ff 00          	movb   $0x0,0xffffffff(%ebp)
  /* iterate through all pbuf in chain */
  for(q = p; q != NULL; q = q->next) {
     cee:	8b 45 08             	mov    0x8(%ebp),%eax
     cf1:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
     cf4:	eb 7b                	jmp    d71 <inet_chksum_pseudo+0xa1>
    LWIP_DEBUGF(INET_DEBUG, ("inet_chksum_pseudo(): checksumming pbuf %p (has next %p) \n",
      (void *)q, (void *)q->next));
    acc += lwip_chksum(q->payload, q->len);
     cf6:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     cf9:	0f b7 40 0a          	movzwl 0xa(%eax),%eax
     cfd:	0f b7 d0             	movzwl %ax,%edx
     d00:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     d03:	8b 40 04             	mov    0x4(%eax),%eax
     d06:	89 54 24 04          	mov    %edx,0x4(%esp)
     d0a:	89 04 24             	mov    %eax,(%esp)
     d0d:	e8 2e ff ff ff       	call   c40 <lwip_chksum>
     d12:	0f b7 c0             	movzwl %ax,%eax
     d15:	01 45 f4             	add    %eax,0xfffffff4(%ebp)
    /*LWIP_DEBUGF(INET_DEBUG, ("inet_chksum_pseudo(): unwrapped lwip_chksum()=%lx \n", acc));*/
    while (acc >> 16) {
     d18:	eb 10                	jmp    d2a <inet_chksum_pseudo+0x5a>
      acc = (acc & 0xffffUL) + (acc >> 16);
     d1a:	0f b7 55 f4          	movzwl 0xfffffff4(%ebp),%edx
     d1e:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     d21:	c1 e8 10             	shr    $0x10,%eax
     d24:	8d 04 02             	lea    (%edx,%eax,1),%eax
     d27:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
     d2a:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     d2d:	c1 e8 10             	shr    $0x10,%eax
     d30:	85 c0                	test   %eax,%eax
     d32:	75 e6                	jne    d1a <inet_chksum_pseudo+0x4a>
    }
    if (q->len % 2 != 0) {
     d34:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     d37:	0f b7 40 0a          	movzwl 0xa(%eax),%eax
     d3b:	0f b7 c0             	movzwl %ax,%eax
     d3e:	83 e0 01             	and    $0x1,%eax
     d41:	84 c0                	test   %al,%al
     d43:	74 24                	je     d69 <inet_chksum_pseudo+0x99>
      swapped = 1 - swapped;
     d45:	b8 01 00 00 00       	mov    $0x1,%eax
     d4a:	2a 45 ff             	sub    0xffffffff(%ebp),%al
     d4d:	88 45 ff             	mov    %al,0xffffffff(%ebp)
      acc = ((acc & 0xff) << 8) | ((acc & 0xff00UL) >> 8);
     d50:	0f b6 45 f4          	movzbl 0xfffffff4(%ebp),%eax
     d54:	89 c2                	mov    %eax,%edx
     d56:	c1 e2 08             	shl    $0x8,%edx
     d59:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     d5c:	25 00 ff 00 00       	and    $0xff00,%eax
     d61:	c1 e8 08             	shr    $0x8,%eax
     d64:	09 d0                	or     %edx,%eax
     d66:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
     d69:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     d6c:	8b 00                	mov    (%eax),%eax
     d6e:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
     d71:	83 7d f8 00          	cmpl   $0x0,0xfffffff8(%ebp)
     d75:	0f 85 7b ff ff ff    	jne    cf6 <inet_chksum_pseudo+0x26>
    }
    /*LWIP_DEBUGF(INET_DEBUG, ("inet_chksum_pseudo(): wrapped lwip_chksum()=%lx \n", acc));*/
  }

  if (swapped) {
     d7b:	80 7d ff 00          	cmpb   $0x0,0xffffffff(%ebp)
     d7f:	74 19                	je     d9a <inet_chksum_pseudo+0xca>
    acc = ((acc & 0xff) << 8) | ((acc & 0xff00UL) >> 8);
     d81:	0f b6 45 f4          	movzbl 0xfffffff4(%ebp),%eax
     d85:	89 c2                	mov    %eax,%edx
     d87:	c1 e2 08             	shl    $0x8,%edx
     d8a:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     d8d:	25 00 ff 00 00       	and    $0xff00,%eax
     d92:	c1 e8 08             	shr    $0x8,%eax
     d95:	09 d0                	or     %edx,%eax
     d97:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
  }
  acc += (src->addr & 0xffffUL);
     d9a:	8b 45 0c             	mov    0xc(%ebp),%eax
     d9d:	8b 00                	mov    (%eax),%eax
     d9f:	25 ff ff 00 00       	and    $0xffff,%eax
     da4:	01 45 f4             	add    %eax,0xfffffff4(%ebp)
  acc += ((src->addr >> 16) & 0xffffUL);
     da7:	8b 45 0c             	mov    0xc(%ebp),%eax
     daa:	8b 00                	mov    (%eax),%eax
     dac:	c1 e8 10             	shr    $0x10,%eax
     daf:	25 ff ff 00 00       	and    $0xffff,%eax
     db4:	01 45 f4             	add    %eax,0xfffffff4(%ebp)
  acc += (dest->addr & 0xffffUL);
     db7:	8b 45 10             	mov    0x10(%ebp),%eax
     dba:	8b 00                	mov    (%eax),%eax
     dbc:	25 ff ff 00 00       	and    $0xffff,%eax
     dc1:	01 45 f4             	add    %eax,0xfffffff4(%ebp)
  acc += ((dest->addr >> 16) & 0xffffUL);
     dc4:	8b 45 10             	mov    0x10(%ebp),%eax
     dc7:	8b 00                	mov    (%eax),%eax
     dc9:	c1 e8 10             	shr    $0x10,%eax
     dcc:	25 ff ff 00 00       	and    $0xffff,%eax
     dd1:	01 45 f4             	add    %eax,0xfffffff4(%ebp)
  acc += (u32_t)htons((u16_t)proto);
     dd4:	0f b6 45 ec          	movzbl 0xffffffec(%ebp),%eax
     dd8:	89 04 24             	mov    %eax,(%esp)
     ddb:	e8 30 05 00 00       	call   1310 <htons>
     de0:	0f b7 c0             	movzwl %ax,%eax
     de3:	01 45 f4             	add    %eax,0xfffffff4(%ebp)
  acc += (u32_t)htons(proto_len);
     de6:	0f b7 45 e8          	movzwl 0xffffffe8(%ebp),%eax
     dea:	89 04 24             	mov    %eax,(%esp)
     ded:	e8 1e 05 00 00       	call   1310 <htons>
     df2:	0f b7 c0             	movzwl %ax,%eax
     df5:	01 45 f4             	add    %eax,0xfffffff4(%ebp)

  while (acc >> 16) {
     df8:	eb 10                	jmp    e0a <inet_chksum_pseudo+0x13a>
    acc = (acc & 0xffffUL) + (acc >> 16);
     dfa:	0f b7 55 f4          	movzwl 0xfffffff4(%ebp),%edx
     dfe:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     e01:	c1 e8 10             	shr    $0x10,%eax
     e04:	8d 04 02             	lea    (%edx,%eax,1),%eax
     e07:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
     e0a:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     e0d:	c1 e8 10             	shr    $0x10,%eax
     e10:	85 c0                	test   %eax,%eax
     e12:	75 e6                	jne    dfa <inet_chksum_pseudo+0x12a>
  }
  LWIP_DEBUGF(INET_DEBUG, ("inet_chksum_pseudo(): pbuf chain lwip_chksum()=%lx\n", acc));
  return ~(acc & 0xffffUL);
     e14:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     e17:	f7 d0                	not    %eax
     e19:	0f b7 c0             	movzwl %ax,%eax
}
     e1c:	c9                   	leave  
     e1d:	c3                   	ret    
     e1e:	89 f6                	mov    %esi,%esi

00000e20 <inet_chksum>:

/* inet_chksum:
 *
 * Calculates the Internet checksum over a portion of memory. Used primarely for IP
 * and ICMP.
 */

u16_t
inet_chksum(void *dataptr, u16_t len)
{
     e20:	55                   	push   %ebp
     e21:	89 e5                	mov    %esp,%ebp
     e23:	83 ec 28             	sub    $0x28,%esp
     e26:	8b 45 0c             	mov    0xc(%ebp),%eax
     e29:	66 89 45 ec          	mov    %ax,0xffffffec(%ebp)
  u32_t acc;

  acc = lwip_chksum(dataptr, len);
     e2d:	0f b7 45 ec          	movzwl 0xffffffec(%ebp),%eax
     e31:	89 44 24 04          	mov    %eax,0x4(%esp)
     e35:	8b 45 08             	mov    0x8(%ebp),%eax
     e38:	89 04 24             	mov    %eax,(%esp)
     e3b:	e8 00 fe ff ff       	call   c40 <lwip_chksum>
     e40:	0f b7 c0             	movzwl %ax,%eax
     e43:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
  while (acc >> 16) {
     e46:	eb 10                	jmp    e58 <inet_chksum+0x38>
    acc = (acc & 0xffff) + (acc >> 16);
     e48:	0f b7 55 fc          	movzwl 0xfffffffc(%ebp),%edx
     e4c:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     e4f:	c1 e8 10             	shr    $0x10,%eax
     e52:	8d 04 02             	lea    (%edx,%eax,1),%eax
     e55:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
     e58:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     e5b:	c1 e8 10             	shr    $0x10,%eax
     e5e:	85 c0                	test   %eax,%eax
     e60:	75 e6                	jne    e48 <inet_chksum+0x28>
  }
  return ~(acc & 0xffff);
     e62:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     e65:	f7 d0                	not    %eax
     e67:	0f b7 c0             	movzwl %ax,%eax
}
     e6a:	c9                   	leave  
     e6b:	c3                   	ret    
     e6c:	8d 74 26 00          	lea    0x0(%esi),%esi

00000e70 <inet_chksum_pbuf>:

u16_t
inet_chksum_pbuf(struct pbuf *p)
{
     e70:	55                   	push   %ebp
     e71:	89 e5                	mov    %esp,%ebp
     e73:	83 ec 18             	sub    $0x18,%esp
  u32_t acc;
  struct pbuf *q;
  u8_t swapped;

  acc = 0;
     e76:	c7 45 f4 00 00 00 00 	movl   $0x0,0xfffffff4(%ebp)
  swapped = 0;
     e7d:	c6 45 ff 00          	movb   $0x0,0xffffffff(%ebp)
  for(q = p; q != NULL; q = q->next) {
     e81:	8b 45 08             	mov    0x8(%ebp),%eax
     e84:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
     e87:	eb 69                	jmp    ef2 <inet_chksum_pbuf+0x82>
    acc += lwip_chksum(q->payload, q->len);
     e89:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     e8c:	0f b7 40 0a          	movzwl 0xa(%eax),%eax
     e90:	0f b7 d0             	movzwl %ax,%edx
     e93:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     e96:	8b 40 04             	mov    0x4(%eax),%eax
     e99:	89 54 24 04          	mov    %edx,0x4(%esp)
     e9d:	89 04 24             	mov    %eax,(%esp)
     ea0:	e8 9b fd ff ff       	call   c40 <lwip_chksum>
     ea5:	0f b7 c0             	movzwl %ax,%eax
     ea8:	01 45 f4             	add    %eax,0xfffffff4(%ebp)
    while (acc >> 16) {
     eab:	eb 10                	jmp    ebd <inet_chksum_pbuf+0x4d>
      acc = (acc & 0xffffUL) + (acc >> 16);
     ead:	0f b7 55 f4          	movzwl 0xfffffff4(%ebp),%edx
     eb1:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     eb4:	c1 e8 10             	shr    $0x10,%eax
     eb7:	8d 04 02             	lea    (%edx,%eax,1),%eax
     eba:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
     ebd:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     ec0:	c1 e8 10             	shr    $0x10,%eax
     ec3:	85 c0                	test   %eax,%eax
     ec5:	75 e6                	jne    ead <inet_chksum_pbuf+0x3d>
    }
    if (q->len % 2 != 0) {
     ec7:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     eca:	0f b7 40 0a          	movzwl 0xa(%eax),%eax
     ece:	0f b7 c0             	movzwl %ax,%eax
     ed1:	83 e0 01             	and    $0x1,%eax
     ed4:	84 c0                	test   %al,%al
     ed6:	74 12                	je     eea <inet_chksum_pbuf+0x7a>
      swapped = 1 - swapped;
     ed8:	b8 01 00 00 00       	mov    $0x1,%eax
     edd:	2a 45 ff             	sub    0xffffffff(%ebp),%al
     ee0:	88 45 ff             	mov    %al,0xffffffff(%ebp)
      acc = (acc & 0x00ffUL << 8) | (acc & 0xff00UL >> 8);
     ee3:	81 65 f4 ff ff 00 00 	andl   $0xffff,0xfffffff4(%ebp)
     eea:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     eed:	8b 00                	mov    (%eax),%eax
     eef:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
     ef2:	83 7d f8 00          	cmpl   $0x0,0xfffffff8(%ebp)
     ef6:	75 91                	jne    e89 <inet_chksum_pbuf+0x19>
    }
  }

  if (swapped) {
     ef8:	80 7d ff 00          	cmpb   $0x0,0xffffffff(%ebp)
     efc:	74 19                	je     f17 <inet_chksum_pbuf+0xa7>
    acc = ((acc & 0x00ffUL) << 8) | ((acc & 0xff00UL) >> 8);
     efe:	0f b6 45 f4          	movzbl 0xfffffff4(%ebp),%eax
     f02:	89 c2                	mov    %eax,%edx
     f04:	c1 e2 08             	shl    $0x8,%edx
     f07:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     f0a:	25 00 ff 00 00       	and    $0xff00,%eax
     f0f:	c1 e8 08             	shr    $0x8,%eax
     f12:	09 d0                	or     %edx,%eax
     f14:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
  }
  return ~(acc & 0xffffUL);
     f17:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     f1a:	f7 d0                	not    %eax
     f1c:	0f b7 c0             	movzwl %ax,%eax
}
     f1f:	c9                   	leave  
     f20:	c3                   	ret    
     f21:	eb 0d                	jmp    f30 <inet_addr>
     f23:	90                   	nop    
     f24:	90                   	nop    
     f25:	90                   	nop    
     f26:	90                   	nop    
     f27:	90                   	nop    
     f28:	90                   	nop    
     f29:	90                   	nop    
     f2a:	90                   	nop    
     f2b:	90                   	nop    
     f2c:	90                   	nop    
     f2d:	90                   	nop    
     f2e:	90                   	nop    
     f2f:	90                   	nop    

00000f30 <inet_addr>:

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
     f30:	55                   	push   %ebp
     f31:	89 e5                	mov    %esp,%ebp
     f33:	83 ec 28             	sub    $0x28,%esp
     struct in_addr val;

     if (inet_aton(cp, &val)) {
     f36:	8d 45 fc             	lea    0xfffffffc(%ebp),%eax
     f39:	89 44 24 04          	mov    %eax,0x4(%esp)
     f3d:	8b 45 08             	mov    0x8(%ebp),%eax
     f40:	89 04 24             	mov    %eax,(%esp)
     f43:	e8 18 00 00 00       	call   f60 <inet_aton>
     f48:	85 c0                	test   %eax,%eax
     f4a:	74 08                	je     f54 <inet_addr+0x24>
         return (val.s_addr);
     f4c:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     f4f:	89 45 ec             	mov    %eax,0xffffffec(%ebp)
     f52:	eb 07                	jmp    f5b <inet_addr+0x2b>
     }
     return (INADDR_NONE);
     f54:	c7 45 ec ff ff ff ff 	movl   $0xffffffff,0xffffffec(%ebp)
     f5b:	8b 45 ec             	mov    0xffffffec(%ebp),%eax
 }
     f5e:	c9                   	leave  
     f5f:	c3                   	ret    

00000f60 <inet_aton>:

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
     f60:	55                   	push   %ebp
     f61:	89 e5                	mov    %esp,%ebp
     f63:	83 ec 48             	sub    $0x48,%esp
     u32_t val;
     int base, n;
     char c;
     u32_t parts[4];
     u32_t* pp = parts;
     f66:	8d 45 dc             	lea    0xffffffdc(%ebp),%eax
     f69:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)

     c = *cp;
     f6c:	8b 45 08             	mov    0x8(%ebp),%eax
     f6f:	0f b6 00             	movzbl (%eax),%eax
     f72:	88 45 fb             	mov    %al,0xfffffffb(%ebp)
     for (;;) {
         /*
          * Collect number up to ``.''.
          * Values are specified as for C:
          * 0x=hex, 0=octal, isdigit=decimal.
          */
         if (!isdigit(c))
     f75:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
     f79:	3c 2f                	cmp    $0x2f,%al
     f7b:	76 08                	jbe    f85 <inet_aton+0x25>
     f7d:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
     f81:	3c 39                	cmp    $0x39,%al
     f83:	76 0c                	jbe    f91 <inet_aton+0x31>
             return (0);
     f85:	c7 45 c0 00 00 00 00 	movl   $0x0,0xffffffc0(%ebp)
     f8c:	e9 78 02 00 00       	jmp    1209 <inet_aton+0x2a9>
         val = 0; base = 10;
     f91:	c7 45 ec 00 00 00 00 	movl   $0x0,0xffffffec(%ebp)
     f98:	c7 45 f0 0a 00 00 00 	movl   $0xa,0xfffffff0(%ebp)
         if (c == '0') {
     f9f:	80 7d fb 30          	cmpb   $0x30,0xfffffffb(%ebp)
     fa3:	75 36                	jne    fdb <inet_aton+0x7b>
             c = *++cp;
     fa5:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     fa9:	8b 45 08             	mov    0x8(%ebp),%eax
     fac:	0f b6 00             	movzbl (%eax),%eax
     faf:	88 45 fb             	mov    %al,0xfffffffb(%ebp)
             if (c == 'x' || c == 'X')
     fb2:	80 7d fb 78          	cmpb   $0x78,0xfffffffb(%ebp)
     fb6:	74 06                	je     fbe <inet_aton+0x5e>
     fb8:	80 7d fb 58          	cmpb   $0x58,0xfffffffb(%ebp)
     fbc:	75 16                	jne    fd4 <inet_aton+0x74>
                 base = 16, c = *++cp;
     fbe:	c7 45 f0 10 00 00 00 	movl   $0x10,0xfffffff0(%ebp)
     fc5:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     fc9:	8b 45 08             	mov    0x8(%ebp),%eax
     fcc:	0f b6 00             	movzbl (%eax),%eax
     fcf:	88 45 fb             	mov    %al,0xfffffffb(%ebp)
     fd2:	eb 07                	jmp    fdb <inet_aton+0x7b>
             else
                 base = 8;
     fd4:	c7 45 f0 08 00 00 00 	movl   $0x8,0xfffffff0(%ebp)
         }
         for (;;) {
             if (isascii(c) && isdigit(c)) {
     fdb:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
     fdf:	3c 1f                	cmp    $0x1f,%al
     fe1:	76 3b                	jbe    101e <inet_aton+0xbe>
     fe3:	80 7d fb 00          	cmpb   $0x0,0xfffffffb(%ebp)
     fe7:	78 35                	js     101e <inet_aton+0xbe>
     fe9:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
     fed:	3c 2f                	cmp    $0x2f,%al
     fef:	76 2d                	jbe    101e <inet_aton+0xbe>
     ff1:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
     ff5:	3c 39                	cmp    $0x39,%al
     ff7:	77 25                	ja     101e <inet_aton+0xbe>
                 val = (val * base) + (c - '0');
     ff9:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
     ffc:	89 c2                	mov    %eax,%edx
     ffe:	0f af 55 ec          	imul   0xffffffec(%ebp),%edx
    1002:	0f be 45 fb          	movsbl 0xfffffffb(%ebp),%eax
    1006:	8d 04 02             	lea    (%edx,%eax,1),%eax
    1009:	83 e8 30             	sub    $0x30,%eax
    100c:	89 45 ec             	mov    %eax,0xffffffec(%ebp)
                 c = *++cp;
    100f:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    1013:	8b 45 08             	mov    0x8(%ebp),%eax
    1016:	0f b6 00             	movzbl (%eax),%eax
    1019:	88 45 fb             	mov    %al,0xfffffffb(%ebp)
    101c:	eb bd                	jmp    fdb <inet_aton+0x7b>
             } else if (base == 16 && isascii(c) && isxdigit(c)) {
    101e:	83 7d f0 10          	cmpl   $0x10,0xfffffff0(%ebp)
    1022:	0f 85 99 00 00 00    	jne    10c1 <inet_aton+0x161>
    1028:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
    102c:	3c 1f                	cmp    $0x1f,%al
    102e:	0f 86 8d 00 00 00    	jbe    10c1 <inet_aton+0x161>
    1034:	80 7d fb 00          	cmpb   $0x0,0xfffffffb(%ebp)
    1038:	0f 88 83 00 00 00    	js     10c1 <inet_aton+0x161>
    103e:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
    1042:	3c 2f                	cmp    $0x2f,%al
    1044:	76 08                	jbe    104e <inet_aton+0xee>
    1046:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
    104a:	3c 39                	cmp    $0x39,%al
    104c:	76 20                	jbe    106e <inet_aton+0x10e>
    104e:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
    1052:	3c 60                	cmp    $0x60,%al
    1054:	76 08                	jbe    105e <inet_aton+0xfe>
    1056:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
    105a:	3c 66                	cmp    $0x66,%al
    105c:	76 10                	jbe    106e <inet_aton+0x10e>
    105e:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
    1062:	3c 40                	cmp    $0x40,%al
    1064:	76 5b                	jbe    10c1 <inet_aton+0x161>
    1066:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
    106a:	3c 46                	cmp    $0x46,%al
    106c:	77 53                	ja     10c1 <inet_aton+0x161>
                 val = (val << 4) |
    106e:	8b 45 ec             	mov    0xffffffec(%ebp),%eax
    1071:	89 c2                	mov    %eax,%edx
    1073:	c1 e2 04             	shl    $0x4,%edx
    1076:	89 55 c4             	mov    %edx,0xffffffc4(%ebp)
    1079:	0f be 45 fb          	movsbl 0xfffffffb(%ebp),%eax
    107d:	83 c0 0a             	add    $0xa,%eax
    1080:	89 45 c8             	mov    %eax,0xffffffc8(%ebp)
    1083:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
    1087:	3c 60                	cmp    $0x60,%al
    1089:	76 11                	jbe    109c <inet_aton+0x13c>
    108b:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
    108f:	3c 7a                	cmp    $0x7a,%al
    1091:	77 09                	ja     109c <inet_aton+0x13c>
    1093:	c7 45 cc 61 00 00 00 	movl   $0x61,0xffffffcc(%ebp)
    109a:	eb 07                	jmp    10a3 <inet_aton+0x143>
    109c:	c7 45 cc 41 00 00 00 	movl   $0x41,0xffffffcc(%ebp)
    10a3:	8b 45 c8             	mov    0xffffffc8(%ebp),%eax
    10a6:	2b 45 cc             	sub    0xffffffcc(%ebp),%eax
    10a9:	0b 45 c4             	or     0xffffffc4(%ebp),%eax
    10ac:	89 45 ec             	mov    %eax,0xffffffec(%ebp)
                     (c + 10 - (islower(c) ? 'a' : 'A'));
                 c = *++cp;
    10af:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    10b3:	8b 45 08             	mov    0x8(%ebp),%eax
    10b6:	0f b6 00             	movzbl (%eax),%eax
    10b9:	88 45 fb             	mov    %al,0xfffffffb(%ebp)
             } else
             break;
         }
    10bc:	e9 1a ff ff ff       	jmp    fdb <inet_aton+0x7b>
         if (c == '.') {
    10c1:	80 7d fb 2e          	cmpb   $0x2e,0xfffffffb(%ebp)
    10c5:	75 35                	jne    10fc <inet_aton+0x19c>
             /*
              * Internet format:
              *  a.b.c.d
              *  a.b.c   (with c treated as 16 bits)
              *  a.b (with b treated as 24 bits)
              */
             if (pp >= parts + 3)
    10c7:	8d 45 dc             	lea    0xffffffdc(%ebp),%eax
    10ca:	83 c0 0c             	add    $0xc,%eax
    10cd:	3b 45 fc             	cmp    0xfffffffc(%ebp),%eax
    10d0:	77 0c                	ja     10de <inet_aton+0x17e>
                 return (0);
    10d2:	c7 45 c0 00 00 00 00 	movl   $0x0,0xffffffc0(%ebp)
    10d9:	e9 2b 01 00 00       	jmp    1209 <inet_aton+0x2a9>
             *pp++ = val;
    10de:	8b 55 fc             	mov    0xfffffffc(%ebp),%edx
    10e1:	8b 45 ec             	mov    0xffffffec(%ebp),%eax
    10e4:	89 02                	mov    %eax,(%edx)
    10e6:	83 45 fc 04          	addl   $0x4,0xfffffffc(%ebp)
             c = *++cp;
    10ea:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    10ee:	8b 45 08             	mov    0x8(%ebp),%eax
    10f1:	0f b6 00             	movzbl (%eax),%eax
    10f4:	88 45 fb             	mov    %al,0xfffffffb(%ebp)
         } else
             break;
     }
    10f7:	e9 79 fe ff ff       	jmp    f75 <inet_aton+0x15>
     /*
      * Check for trailing characters.
      */
     if (c != '\0' && (!isascii(c) || !isspace(c)))
    10fc:	80 7d fb 00          	cmpb   $0x0,0xfffffffb(%ebp)
    1100:	74 3e                	je     1140 <inet_aton+0x1e0>
    1102:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
    1106:	3c 1f                	cmp    $0x1f,%al
    1108:	76 2a                	jbe    1134 <inet_aton+0x1d4>
    110a:	80 7d fb 00          	cmpb   $0x0,0xfffffffb(%ebp)
    110e:	78 24                	js     1134 <inet_aton+0x1d4>
    1110:	80 7d fb 20          	cmpb   $0x20,0xfffffffb(%ebp)
    1114:	74 2a                	je     1140 <inet_aton+0x1e0>
    1116:	80 7d fb 0c          	cmpb   $0xc,0xfffffffb(%ebp)
    111a:	74 24                	je     1140 <inet_aton+0x1e0>
    111c:	80 7d fb 0a          	cmpb   $0xa,0xfffffffb(%ebp)
    1120:	74 1e                	je     1140 <inet_aton+0x1e0>
    1122:	80 7d fb 0d          	cmpb   $0xd,0xfffffffb(%ebp)
    1126:	74 18                	je     1140 <inet_aton+0x1e0>
    1128:	80 7d fb 09          	cmpb   $0x9,0xfffffffb(%ebp)
    112c:	74 12                	je     1140 <inet_aton+0x1e0>
    112e:	80 7d fb 0b          	cmpb   $0xb,0xfffffffb(%ebp)
    1132:	74 0c                	je     1140 <inet_aton+0x1e0>
         return (0);
    1134:	c7 45 c0 00 00 00 00 	movl   $0x0,0xffffffc0(%ebp)
    113b:	e9 c9 00 00 00       	jmp    1209 <inet_aton+0x2a9>
     /*
      * Concoct the address according to
      * the number of parts specified.
      */
     n = pp - parts + 1;
    1140:	8b 55 fc             	mov    0xfffffffc(%ebp),%edx
    1143:	8d 45 dc             	lea    0xffffffdc(%ebp),%eax
    1146:	89 d1                	mov    %edx,%ecx
    1148:	29 c1                	sub    %eax,%ecx
    114a:	89 c8                	mov    %ecx,%eax
    114c:	c1 f8 02             	sar    $0x2,%eax
    114f:	83 c0 01             	add    $0x1,%eax
    1152:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
     switch (n) {
    1155:	83 7d f4 04          	cmpl   $0x4,0xfffffff4(%ebp)
    1159:	0f 87 8b 00 00 00    	ja     11ea <inet_aton+0x28a>
    115f:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
    1162:	c1 e0 02             	shl    $0x2,%eax
    1165:	8b 80 08 14 00 00    	mov    0x1408(%eax),%eax
    116b:	ff e0                	jmp    *%eax

     case 0:
         return (0);     /* initial nondigit */
    116d:	c7 45 c0 00 00 00 00 	movl   $0x0,0xffffffc0(%ebp)
    1174:	e9 90 00 00 00       	jmp    1209 <inet_aton+0x2a9>

     case 1:             /* a -- 32 bits */
         break;

     case 2:             /* a.b -- 8.24 bits */
         if (val > 0xffffff)
    1179:	81 7d ec ff ff ff 00 	cmpl   $0xffffff,0xffffffec(%ebp)
    1180:	76 09                	jbe    118b <inet_aton+0x22b>
             return (0);
    1182:	c7 45 c0 00 00 00 00 	movl   $0x0,0xffffffc0(%ebp)
    1189:	eb 7e                	jmp    1209 <inet_aton+0x2a9>
         val |= parts[0] << 24;
    118b:	8b 45 dc             	mov    0xffffffdc(%ebp),%eax
    118e:	c1 e0 18             	shl    $0x18,%eax
    1191:	09 45 ec             	or     %eax,0xffffffec(%ebp)
         break;
    1194:	eb 54                	jmp    11ea <inet_aton+0x28a>

     case 3:             /* a.b.c -- 8.8.16 bits */
         if (val > 0xffff)
    1196:	81 7d ec ff ff 00 00 	cmpl   $0xffff,0xffffffec(%ebp)
    119d:	76 09                	jbe    11a8 <inet_aton+0x248>
             return (0);
    119f:	c7 45 c0 00 00 00 00 	movl   $0x0,0xffffffc0(%ebp)
    11a6:	eb 61                	jmp    1209 <inet_aton+0x2a9>
         val |= (parts[0] << 24) | (parts[1] << 16);
    11a8:	8b 45 dc             	mov    0xffffffdc(%ebp),%eax
    11ab:	89 c2                	mov    %eax,%edx
    11ad:	c1 e2 18             	shl    $0x18,%edx
    11b0:	8b 45 e0             	mov    0xffffffe0(%ebp),%eax
    11b3:	c1 e0 10             	shl    $0x10,%eax
    11b6:	09 d0                	or     %edx,%eax
    11b8:	09 45 ec             	or     %eax,0xffffffec(%ebp)
         break;
    11bb:	eb 2d                	jmp    11ea <inet_aton+0x28a>

     case 4:             /* a.b.c.d -- 8.8.8.8 bits */
         if (val > 0xff)
    11bd:	81 7d ec ff 00 00 00 	cmpl   $0xff,0xffffffec(%ebp)
    11c4:	76 09                	jbe    11cf <inet_aton+0x26f>
             return (0);
    11c6:	c7 45 c0 00 00 00 00 	movl   $0x0,0xffffffc0(%ebp)
    11cd:	eb 3a                	jmp    1209 <inet_aton+0x2a9>
         val |= (parts[0] << 24) | (parts[1] << 16) | (parts[2] << 8);
    11cf:	8b 45 dc             	mov    0xffffffdc(%ebp),%eax
    11d2:	89 c2                	mov    %eax,%edx
    11d4:	c1 e2 18             	shl    $0x18,%edx
    11d7:	8b 45 e0             	mov    0xffffffe0(%ebp),%eax
    11da:	c1 e0 10             	shl    $0x10,%eax
    11dd:	09 c2                	or     %eax,%edx
    11df:	8b 45 e4             	mov    0xffffffe4(%ebp),%eax
    11e2:	c1 e0 08             	shl    $0x8,%eax
    11e5:	09 d0                	or     %edx,%eax
    11e7:	09 45 ec             	or     %eax,0xffffffec(%ebp)
         break;
     }
     if (addr)
    11ea:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    11ee:	74 12                	je     1202 <inet_aton+0x2a2>
         addr->s_addr = htonl(val);
    11f0:	8b 45 ec             	mov    0xffffffec(%ebp),%eax
    11f3:	89 04 24             	mov    %eax,(%esp)
    11f6:	e8 65 01 00 00       	call   1360 <htonl>
    11fb:	89 c2                	mov    %eax,%edx
    11fd:	8b 45 0c             	mov    0xc(%ebp),%eax
    1200:	89 10                	mov    %edx,(%eax)
     return (1);
    1202:	c7 45 c0 01 00 00 00 	movl   $0x1,0xffffffc0(%ebp)
    1209:	8b 45 c0             	mov    0xffffffc0(%ebp),%eax
 }
    120c:	c9                   	leave  
    120d:	c3                   	ret    
    120e:	89 f6                	mov    %esi,%esi

00001210 <inet_ntoa>:

/* Convert numeric IP address into decimal dotted ASCII representation.
 * returns ptr to static buffer; not reentrant!
 */
char *inet_ntoa(struct in_addr addr)
{
    1210:	55                   	push   %ebp
    1211:	89 e5                	mov    %esp,%ebp
    1213:	53                   	push   %ebx
    1214:	83 ec 24             	sub    $0x24,%esp
  static char str[16];
  u32_t s_addr = addr.s_addr;
    1217:	8b 45 08             	mov    0x8(%ebp),%eax
    121a:	89 45 ec             	mov    %eax,0xffffffec(%ebp)
  char inv[3];
  char *rp;
  char *ap;
  u8_t rem;
  u8_t n;
  u8_t i;

  rp = str;
    121d:	c7 45 f0 4c 14 00 00 	movl   $0x144c,0xfffffff0(%ebp)
  ap = (u8_t *)&s_addr;
    1224:	8d 45 ec             	lea    0xffffffec(%ebp),%eax
    1227:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
  for(n = 0; n < 4; n++) {
    122a:	c6 45 fa 00          	movb   $0x0,0xfffffffa(%ebp)
    122e:	e9 af 00 00 00       	jmp    12e2 <inet_ntoa+0xd2>
    i = 0;
    1233:	c6 45 fb 00          	movb   $0x0,0xfffffffb(%ebp)
    do {
      rem = *ap % (u8_t)10;
    1237:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
    123a:	0f b6 08             	movzbl (%eax),%ecx
    123d:	b8 67 00 00 00       	mov    $0x67,%eax
    1242:	f6 e9                	imul   %cl
    1244:	66 c1 e8 08          	shr    $0x8,%ax
    1248:	89 c2                	mov    %eax,%edx
    124a:	c0 fa 02             	sar    $0x2,%dl
    124d:	89 c8                	mov    %ecx,%eax
    124f:	c0 f8 07             	sar    $0x7,%al
    1252:	89 d3                	mov    %edx,%ebx
    1254:	28 c3                	sub    %al,%bl
    1256:	88 5d db             	mov    %bl,0xffffffdb(%ebp)
    1259:	0f b6 45 db          	movzbl 0xffffffdb(%ebp),%eax
    125d:	c1 e0 02             	shl    $0x2,%eax
    1260:	02 45 db             	add    0xffffffdb(%ebp),%al
    1263:	01 c0                	add    %eax,%eax
    1265:	89 ca                	mov    %ecx,%edx
    1267:	28 c2                	sub    %al,%dl
    1269:	88 55 db             	mov    %dl,0xffffffdb(%ebp)
    126c:	0f b6 5d db          	movzbl 0xffffffdb(%ebp),%ebx
    1270:	88 5d f9             	mov    %bl,0xfffffff9(%ebp)
      *ap /= (u8_t)10;
    1273:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
    1276:	0f b6 08             	movzbl (%eax),%ecx
    1279:	b8 67 00 00 00       	mov    $0x67,%eax
    127e:	f6 e9                	imul   %cl
    1280:	66 c1 e8 08          	shr    $0x8,%ax
    1284:	89 c2                	mov    %eax,%edx
    1286:	c0 fa 02             	sar    $0x2,%dl
    1289:	89 c8                	mov    %ecx,%eax
    128b:	c0 f8 07             	sar    $0x7,%al
    128e:	28 c2                	sub    %al,%dl
    1290:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
    1293:	88 10                	mov    %dl,(%eax)
      inv[i++] = '0' + rem;
    1295:	0f b6 55 fb          	movzbl 0xfffffffb(%ebp),%edx
    1299:	0f b6 45 f9          	movzbl 0xfffffff9(%ebp),%eax
    129d:	83 c0 30             	add    $0x30,%eax
    12a0:	88 44 15 e9          	mov    %al,0xffffffe9(%ebp,%edx,1)
    12a4:	80 45 fb 01          	addb   $0x1,0xfffffffb(%ebp)
    } while(*ap);
    12a8:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
    12ab:	0f b6 00             	movzbl (%eax),%eax
    12ae:	84 c0                	test   %al,%al
    12b0:	75 85                	jne    1237 <inet_ntoa+0x27>
    while(i--)
    12b2:	eb 12                	jmp    12c6 <inet_ntoa+0xb6>
      *rp++ = inv[i];
    12b4:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
    12b8:	0f b6 54 05 e9       	movzbl 0xffffffe9(%ebp,%eax,1),%edx
    12bd:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
    12c0:	88 10                	mov    %dl,(%eax)
    12c2:	83 45 f0 01          	addl   $0x1,0xfffffff0(%ebp)
    12c6:	80 6d fb 01          	subb   $0x1,0xfffffffb(%ebp)
    12ca:	80 7d fb ff          	cmpb   $0xff,0xfffffffb(%ebp)
    12ce:	75 e4                	jne    12b4 <inet_ntoa+0xa4>
    *rp++ = '.';
    12d0:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
    12d3:	c6 00 2e             	movb   $0x2e,(%eax)
    12d6:	83 45 f0 01          	addl   $0x1,0xfffffff0(%ebp)
    ap++;
    12da:	83 45 f4 01          	addl   $0x1,0xfffffff4(%ebp)
    12de:	80 45 fa 01          	addb   $0x1,0xfffffffa(%ebp)
    12e2:	80 7d fa 03          	cmpb   $0x3,0xfffffffa(%ebp)
    12e6:	0f 86 47 ff ff ff    	jbe    1233 <inet_ntoa+0x23>
  }
  *--rp = 0;
    12ec:	83 6d f0 01          	subl   $0x1,0xfffffff0(%ebp)
    12f0:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
    12f3:	c6 00 00             	movb   $0x0,(%eax)
  return str;
    12f6:	b8 4c 14 00 00       	mov    $0x144c,%eax
}
    12fb:	83 c4 24             	add    $0x24,%esp
    12fe:	5b                   	pop    %ebx
    12ff:	5d                   	pop    %ebp
    1300:	c3                   	ret    
    1301:	eb 0d                	jmp    1310 <htons>
    1303:	90                   	nop    
    1304:	90                   	nop    
    1305:	90                   	nop    
    1306:	90                   	nop    
    1307:	90                   	nop    
    1308:	90                   	nop    
    1309:	90                   	nop    
    130a:	90                   	nop    
    130b:	90                   	nop    
    130c:	90                   	nop    
    130d:	90                   	nop    
    130e:	90                   	nop    
    130f:	90                   	nop    

00001310 <htons>:


#ifndef BYTE_ORDER
#error BYTE_ORDER is not defined
#endif
#if BYTE_ORDER == LITTLE_ENDIAN

u16_t
htons(u16_t n)
{
    1310:	55                   	push   %ebp
    1311:	89 e5                	mov    %esp,%ebp
    1313:	83 ec 04             	sub    $0x4,%esp
    1316:	8b 45 08             	mov    0x8(%ebp),%eax
    1319:	66 89 45 fc          	mov    %ax,0xfffffffc(%ebp)
  return ((n & 0xff) << 8) | ((n & 0xff00) >> 8);
    131d:	0f b7 45 fc          	movzwl 0xfffffffc(%ebp),%eax
    1321:	25 ff 00 00 00       	and    $0xff,%eax
    1326:	c1 e0 08             	shl    $0x8,%eax
    1329:	89 c2                	mov    %eax,%edx
    132b:	0f b7 45 fc          	movzwl 0xfffffffc(%ebp),%eax
    132f:	25 00 ff 00 00       	and    $0xff00,%eax
    1334:	c1 f8 08             	sar    $0x8,%eax
    1337:	09 d0                	or     %edx,%eax
    1339:	0f b7 c0             	movzwl %ax,%eax
}
    133c:	c9                   	leave  
    133d:	c3                   	ret    
    133e:	89 f6                	mov    %esi,%esi

00001340 <ntohs>:

u16_t
ntohs(u16_t n)
{
    1340:	55                   	push   %ebp
    1341:	89 e5                	mov    %esp,%ebp
    1343:	83 ec 08             	sub    $0x8,%esp
    1346:	8b 45 08             	mov    0x8(%ebp),%eax
    1349:	66 89 45 fc          	mov    %ax,0xfffffffc(%ebp)
  return htons(n);
    134d:	0f b7 45 fc          	movzwl 0xfffffffc(%ebp),%eax
    1351:	89 04 24             	mov    %eax,(%esp)
    1354:	e8 b7 ff ff ff       	call   1310 <htons>
    1359:	0f b7 c0             	movzwl %ax,%eax
}
    135c:	c9                   	leave  
    135d:	c3                   	ret    
    135e:	89 f6                	mov    %esi,%esi

00001360 <htonl>:

u32_t
htonl(u32_t n)
{
    1360:	55                   	push   %ebp
    1361:	89 e5                	mov    %esp,%ebp
  return ((n & 0xff) << 24) |
    1363:	0f b6 45 08          	movzbl 0x8(%ebp),%eax
    1367:	89 c2                	mov    %eax,%edx
    1369:	c1 e2 18             	shl    $0x18,%edx
    136c:	8b 45 08             	mov    0x8(%ebp),%eax
    136f:	25 00 ff 00 00       	and    $0xff00,%eax
    1374:	c1 e0 08             	shl    $0x8,%eax
    1377:	09 c2                	or     %eax,%edx
    1379:	8b 45 08             	mov    0x8(%ebp),%eax
    137c:	25 00 00 ff 00       	and    $0xff0000,%eax
    1381:	c1 e8 08             	shr    $0x8,%eax
    1384:	09 c2                	or     %eax,%edx
    1386:	8b 45 08             	mov    0x8(%ebp),%eax
    1389:	25 00 00 00 ff       	and    $0xff000000,%eax
    138e:	c1 e8 18             	shr    $0x18,%eax
    1391:	09 d0                	or     %edx,%eax
    ((n & 0xff00) << 8) |
    ((n & 0xff0000) >> 8) |
    ((n & 0xff000000) >> 24);
}
    1393:	5d                   	pop    %ebp
    1394:	c3                   	ret    
    1395:	8d 74 26 00          	lea    0x0(%esi),%esi
    1399:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

000013a0 <ntohl>:

u32_t
ntohl(u32_t n)
{
    13a0:	55                   	push   %ebp
    13a1:	89 e5                	mov    %esp,%ebp
    13a3:	83 ec 04             	sub    $0x4,%esp
  return htonl(n);
    13a6:	8b 45 08             	mov    0x8(%ebp),%eax
    13a9:	89 04 24             	mov    %eax,(%esp)
    13ac:	e8 af ff ff ff       	call   1360 <htonl>
}
    13b1:	c9                   	leave  
    13b2:	c3                   	ret    
