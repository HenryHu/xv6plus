
_httpd:     file format elf32-i386-freebsd

Disassembly of section .text:

00000000 <strncmp>:
#define FCACHE_SIZE     1024

int
strncmp(char *s1, char *s2, int len)
{
       0:	55                   	push   %ebp
       1:	89 e5                	mov    %esp,%ebp
       3:	83 ec 14             	sub    $0x14,%esp
    int i;
    i=0;
       6:	c7 45 fc 00 00 00 00 	movl   $0x0,0xfffffffc(%ebp)
    while (*s1 && *s1 == *s2)
       d:	eb 14                	jmp    23 <strncmp+0x23>
    {
        i++;
       f:	83 45 fc 01          	addl   $0x1,0xfffffffc(%ebp)
        if (i == len)
      13:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
      16:	3b 45 10             	cmp    0x10(%ebp),%eax
      19:	74 22                	je     3d <strncmp+0x3d>
            break;
        s1++, s2++;
      1b:	83 45 08 01          	addl   $0x1,0x8(%ebp)
      1f:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
      23:	8b 45 08             	mov    0x8(%ebp),%eax
      26:	0f b6 00             	movzbl (%eax),%eax
      29:	84 c0                	test   %al,%al
      2b:	74 10                	je     3d <strncmp+0x3d>
      2d:	8b 45 08             	mov    0x8(%ebp),%eax
      30:	0f b6 10             	movzbl (%eax),%edx
      33:	8b 45 0c             	mov    0xc(%ebp),%eax
      36:	0f b6 00             	movzbl (%eax),%eax
      39:	38 c2                	cmp    %al,%dl
      3b:	74 d2                	je     f <strncmp+0xf>
    }
    if (i == len)
      3d:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
      40:	3b 45 10             	cmp    0x10(%ebp),%eax
      43:	75 09                	jne    4e <strncmp+0x4e>
        return 0;
      45:	c7 45 ec 00 00 00 00 	movl   $0x0,0xffffffec(%ebp)
      4c:	eb 19                	jmp    67 <strncmp+0x67>
    return *s1 - *s2;
      4e:	8b 45 08             	mov    0x8(%ebp),%eax
      51:	0f b6 00             	movzbl (%eax),%eax
      54:	0f be d0             	movsbl %al,%edx
      57:	8b 45 0c             	mov    0xc(%ebp),%eax
      5a:	0f b6 00             	movzbl (%eax),%eax
      5d:	0f be c0             	movsbl %al,%eax
      60:	89 d1                	mov    %edx,%ecx
      62:	29 c1                	sub    %eax,%ecx
      64:	89 4d ec             	mov    %ecx,0xffffffec(%ebp)
      67:	8b 45 ec             	mov    0xffffffec(%ebp),%eax
}
      6a:	c9                   	leave  
      6b:	c3                   	ret    
      6c:	8d 74 26 00          	lea    0x0(%esi),%esi

00000070 <parsedata>:

int lineptr = 0;
int linepos = 0;
int finished = 0;

char **line;

void
parsedata(char *start, char *end)
{
      70:	55                   	push   %ebp
      71:	89 e5                	mov    %esp,%ebp
      73:	83 ec 28             	sub    $0x28,%esp
    int movelen = end-start+1;
      76:	8b 55 0c             	mov    0xc(%ebp),%edx
      79:	8b 45 08             	mov    0x8(%ebp),%eax
      7c:	89 d1                	mov    %edx,%ecx
      7e:	29 c1                	sub    %eax,%ecx
      80:	89 c8                	mov    %ecx,%eax
      82:	83 c0 01             	add    $0x1,%eax
      85:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
    if (linepos + movelen > MAX_LINE_LEN)
      88:	a1 ac 19 00 00       	mov    0x19ac,%eax
      8d:	03 45 fc             	add    0xfffffffc(%ebp),%eax
      90:	3d c8 00 00 00       	cmp    $0xc8,%eax
      95:	7e 1c                	jle    b3 <parsedata+0x43>
    {
        movelen = MAX_LINE_LEN - linepos;
      97:	8b 15 ac 19 00 00    	mov    0x19ac,%edx
      9d:	b8 c8 00 00 00       	mov    $0xc8,%eax
      a2:	29 d0                	sub    %edx,%eax
      a4:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
        *(start + movelen - 1) = '\0';
      a7:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
      aa:	03 45 08             	add    0x8(%ebp),%eax
      ad:	83 e8 01             	sub    $0x1,%eax
      b0:	c6 00 00             	movb   $0x0,(%eax)
    }
    if (!finished)
      b3:	a1 b0 19 00 00       	mov    0x19b0,%eax
      b8:	85 c0                	test   %eax,%eax
      ba:	75 3d                	jne    f9 <parsedata+0x89>
    {
        memmove(line[lineptr]+linepos, start, movelen);
      bc:	a1 a8 19 00 00       	mov    0x19a8,%eax
      c1:	c1 e0 02             	shl    $0x2,%eax
      c4:	89 c2                	mov    %eax,%edx
      c6:	a1 d0 19 00 00       	mov    0x19d0,%eax
      cb:	8d 04 02             	lea    (%edx,%eax,1),%eax
      ce:	8b 10                	mov    (%eax),%edx
      d0:	a1 ac 19 00 00       	mov    0x19ac,%eax
      d5:	01 c2                	add    %eax,%edx
      d7:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
      da:	89 44 24 08          	mov    %eax,0x8(%esp)
      de:	8b 45 08             	mov    0x8(%ebp),%eax
      e1:	89 44 24 04          	mov    %eax,0x4(%esp)
      e5:	89 14 24             	mov    %edx,(%esp)
      e8:	e8 e3 09 00 00       	call   ad0 <memmove>
        finished = 1;
      ed:	c7 05 b0 19 00 00 01 	movl   $0x1,0x19b0
      f4:	00 00 00 
      f7:	eb 2a                	jmp    123 <parsedata+0xb3>
    } else {
        memmove(line[lineptr], start, movelen);
      f9:	a1 a8 19 00 00       	mov    0x19a8,%eax
      fe:	c1 e0 02             	shl    $0x2,%eax
     101:	89 c2                	mov    %eax,%edx
     103:	a1 d0 19 00 00       	mov    0x19d0,%eax
     108:	8d 04 02             	lea    (%edx,%eax,1),%eax
     10b:	8b 10                	mov    (%eax),%edx
     10d:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     110:	89 44 24 08          	mov    %eax,0x8(%esp)
     114:	8b 45 08             	mov    0x8(%ebp),%eax
     117:	89 44 24 04          	mov    %eax,0x4(%esp)
     11b:	89 14 24             	mov    %edx,(%esp)
     11e:	e8 ad 09 00 00       	call   ad0 <memmove>
    }
    lineptr++;
     123:	a1 a8 19 00 00       	mov    0x19a8,%eax
     128:	83 c0 01             	add    $0x1,%eax
     12b:	a3 a8 19 00 00       	mov    %eax,0x19a8
    linepos = 0;
     130:	c7 05 ac 19 00 00 00 	movl   $0x0,0x19ac
     137:	00 00 00 
}
     13a:	c9                   	leave  
     13b:	c3                   	ret    
     13c:	8d 74 26 00          	lea    0x0(%esi),%esi

00000140 <itoa>:

void
itoa(int val, char *data)
{
     140:	55                   	push   %ebp
     141:	89 e5                	mov    %esp,%ebp
     143:	56                   	push   %esi
     144:	53                   	push   %ebx
     145:	83 ec 38             	sub    $0x38,%esp
    char buffer[40];
    int i = -1;
     148:	c7 45 f0 ff ff ff ff 	movl   $0xffffffff,0xfffffff0(%ebp)
    while (val != 0)
     14f:	eb 62                	jmp    1b3 <itoa+0x73>
    {
        i++;
     151:	83 45 f0 01          	addl   $0x1,0xfffffff0(%ebp)
        buffer[i] = '0' + val % 10;
     155:	8b 5d f0             	mov    0xfffffff0(%ebp),%ebx
     158:	8b 4d 08             	mov    0x8(%ebp),%ecx
     15b:	c7 45 c0 67 66 66 66 	movl   $0x66666667,0xffffffc0(%ebp)
     162:	8b 45 c0             	mov    0xffffffc0(%ebp),%eax
     165:	f7 e9                	imul   %ecx
     167:	c1 fa 02             	sar    $0x2,%edx
     16a:	89 c8                	mov    %ecx,%eax
     16c:	c1 f8 1f             	sar    $0x1f,%eax
     16f:	89 d6                	mov    %edx,%esi
     171:	29 c6                	sub    %eax,%esi
     173:	89 75 c4             	mov    %esi,0xffffffc4(%ebp)
     176:	8b 45 c4             	mov    0xffffffc4(%ebp),%eax
     179:	c1 e0 02             	shl    $0x2,%eax
     17c:	03 45 c4             	add    0xffffffc4(%ebp),%eax
     17f:	01 c0                	add    %eax,%eax
     181:	89 ca                	mov    %ecx,%edx
     183:	29 c2                	sub    %eax,%edx
     185:	89 55 c4             	mov    %edx,0xffffffc4(%ebp)
     188:	0f b6 45 c4          	movzbl 0xffffffc4(%ebp),%eax
     18c:	83 c0 30             	add    $0x30,%eax
     18f:	88 44 1d c8          	mov    %al,0xffffffc8(%ebp,%ebx,1)
        val /= 10;
     193:	8b 4d 08             	mov    0x8(%ebp),%ecx
     196:	c7 45 c0 67 66 66 66 	movl   $0x66666667,0xffffffc0(%ebp)
     19d:	8b 45 c0             	mov    0xffffffc0(%ebp),%eax
     1a0:	f7 e9                	imul   %ecx
     1a2:	c1 fa 02             	sar    $0x2,%edx
     1a5:	89 c8                	mov    %ecx,%eax
     1a7:	c1 f8 1f             	sar    $0x1f,%eax
     1aa:	89 d1                	mov    %edx,%ecx
     1ac:	29 c1                	sub    %eax,%ecx
     1ae:	89 c8                	mov    %ecx,%eax
     1b0:	89 45 08             	mov    %eax,0x8(%ebp)
     1b3:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
     1b7:	75 98                	jne    151 <itoa+0x11>
    }
    if (i == -1)
     1b9:	83 7d f0 ff          	cmpl   $0xffffffff,0xfffffff0(%ebp)
     1bd:	75 0c                	jne    1cb <itoa+0x8b>
    {
        i++;
     1bf:	83 45 f0 01          	addl   $0x1,0xfffffff0(%ebp)
        buffer[i] = '0';
     1c3:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
     1c6:	c6 44 05 c8 30       	movb   $0x30,0xffffffc8(%ebp,%eax,1)
    }
    int j;
    for (j=0; j<=i; j++)
     1cb:	c7 45 f4 00 00 00 00 	movl   $0x0,0xfffffff4(%ebp)
     1d2:	eb 1b                	jmp    1ef <itoa+0xaf>
    {
        data[i-j] = buffer[j];
     1d4:	8b 55 f4             	mov    0xfffffff4(%ebp),%edx
     1d7:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
     1da:	29 d0                	sub    %edx,%eax
     1dc:	89 c2                	mov    %eax,%edx
     1de:	03 55 0c             	add    0xc(%ebp),%edx
     1e1:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     1e4:	0f b6 44 05 c8       	movzbl 0xffffffc8(%ebp,%eax,1),%eax
     1e9:	88 02                	mov    %al,(%edx)
     1eb:	83 45 f4 01          	addl   $0x1,0xfffffff4(%ebp)
     1ef:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     1f2:	3b 45 f0             	cmp    0xfffffff0(%ebp),%eax
     1f5:	7e dd                	jle    1d4 <itoa+0x94>
    }
    data[i+1] = '\0';
     1f7:	8b 55 0c             	mov    0xc(%ebp),%edx
     1fa:	83 c2 01             	add    $0x1,%edx
     1fd:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
     200:	8d 04 02             	lea    (%edx,%eax,1),%eax
     203:	c6 00 00             	movb   $0x0,(%eax)
}
     206:	83 c4 38             	add    $0x38,%esp
     209:	5b                   	pop    %ebx
     20a:	5e                   	pop    %esi
     20b:	5d                   	pop    %ebp
     20c:	c3                   	ret    
     20d:	8d 76 00             	lea    0x0(%esi),%esi

00000210 <parse_request>:

void
parse_request(int client)
{
     210:	55                   	push   %ebp
     211:	89 e5                	mov    %esp,%ebp
     213:	81 ec 78 04 00 00    	sub    $0x478,%esp
    printf(1, "Request line count: %d\n", lineptr);
     219:	a1 a8 19 00 00       	mov    0x19a8,%eax
     21e:	89 44 24 08          	mov    %eax,0x8(%esp)
     222:	c7 44 24 04 a4 18 00 	movl   $0x18a4,0x4(%esp)
     229:	00 
     22a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     231:	e8 ea 0a 00 00       	call   d20 <printf>
//    printf(1, "Request content:\n");
    char data[FCACHE_SIZE];
    int i;
    for (i=0; i<lineptr; i++)
     236:	c7 45 d8 00 00 00 00 	movl   $0x0,0xffffffd8(%ebp)
     23d:	e9 45 02 00 00       	jmp    487 <parse_request+0x277>
    {
        char *start = line[i];
     242:	8b 45 d8             	mov    0xffffffd8(%ebp),%eax
     245:	c1 e0 02             	shl    $0x2,%eax
     248:	89 c2                	mov    %eax,%edx
     24a:	a1 d0 19 00 00       	mov    0x19d0,%eax
     24f:	8d 04 02             	lea    (%edx,%eax,1),%eax
     252:	8b 00                	mov    (%eax),%eax
     254:	89 45 dc             	mov    %eax,0xffffffdc(%ebp)
        while (*start == ' ') start++;
     257:	eb 04                	jmp    25d <parse_request+0x4d>
     259:	83 45 dc 01          	addl   $0x1,0xffffffdc(%ebp)
     25d:	8b 45 dc             	mov    0xffffffdc(%ebp),%eax
     260:	0f b6 00             	movzbl (%eax),%eax
     263:	3c 20                	cmp    $0x20,%al
     265:	74 f2                	je     259 <parse_request+0x49>
        if (!*start)
     267:	8b 45 dc             	mov    0xffffffdc(%ebp),%eax
     26a:	0f b6 00             	movzbl (%eax),%eax
     26d:	84 c0                	test   %al,%al
     26f:	0f 84 0e 02 00 00    	je     483 <parse_request+0x273>
            continue;
//        printf(1, "%s\n", start);
        if (strncmp(start, "GET ", 4) == 0)
     275:	c7 44 24 08 04 00 00 	movl   $0x4,0x8(%esp)
     27c:	00 
     27d:	c7 44 24 04 bc 18 00 	movl   $0x18bc,0x4(%esp)
     284:	00 
     285:	8b 45 dc             	mov    0xffffffdc(%ebp),%eax
     288:	89 04 24             	mov    %eax,(%esp)
     28b:	e8 70 fd ff ff       	call   0 <strncmp>
     290:	85 c0                	test   %eax,%eax
     292:	0f 85 eb 01 00 00    	jne    483 <parse_request+0x273>
        {
//            printf(1, "GET request\n");
            char *head = start + 4;
     298:	8b 45 dc             	mov    0xffffffdc(%ebp),%eax
     29b:	83 c0 04             	add    $0x4,%eax
     29e:	89 45 e0             	mov    %eax,0xffffffe0(%ebp)
            if (*head)
     2a1:	8b 45 e0             	mov    0xffffffe0(%ebp),%eax
     2a4:	0f b6 00             	movzbl (%eax),%eax
     2a7:	84 c0                	test   %al,%al
     2a9:	0f 84 a4 01 00 00    	je     453 <parse_request+0x243>
            {
                char old;
                char *end = head + 1;
     2af:	8b 45 e0             	mov    0xffffffe0(%ebp),%eax
     2b2:	83 c0 01             	add    $0x1,%eax
     2b5:	89 45 e8             	mov    %eax,0xffffffe8(%ebp)
                while ((*end != ' ') && (*end != '\0'))
     2b8:	eb 04                	jmp    2be <parse_request+0xae>
                    end++;
     2ba:	83 45 e8 01          	addl   $0x1,0xffffffe8(%ebp)
     2be:	8b 45 e8             	mov    0xffffffe8(%ebp),%eax
     2c1:	0f b6 00             	movzbl (%eax),%eax
     2c4:	3c 20                	cmp    $0x20,%al
     2c6:	74 0a                	je     2d2 <parse_request+0xc2>
     2c8:	8b 45 e8             	mov    0xffffffe8(%ebp),%eax
     2cb:	0f b6 00             	movzbl (%eax),%eax
     2ce:	84 c0                	test   %al,%al
     2d0:	75 e8                	jne    2ba <parse_request+0xaa>
                old = *end;
     2d2:	8b 45 e8             	mov    0xffffffe8(%ebp),%eax
     2d5:	0f b6 00             	movzbl (%eax),%eax
     2d8:	88 45 e7             	mov    %al,0xffffffe7(%ebp)
                *end = '\0';
     2db:	8b 45 e8             	mov    0xffffffe8(%ebp),%eax
     2de:	c6 00 00             	movb   $0x0,(%eax)
//                printf(1, " URI: %s\n", head);
                int f = open(head, O_RDONLY);
     2e1:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     2e8:	00 
     2e9:	8b 45 e0             	mov    0xffffffe0(%ebp),%eax
     2ec:	89 04 24             	mov    %eax,(%esp)
     2ef:	e8 60 08 00 00       	call   b54 <open>
     2f4:	89 45 ec             	mov    %eax,0xffffffec(%ebp)
                int len;
                if (f > 0)
     2f7:	83 7d ec 00          	cmpl   $0x0,0xffffffec(%ebp)
     2fb:	0f 8e 17 01 00 00    	jle    418 <parse_request+0x208>
                {
                    struct stat st;
                    fstat(f, &st);
     301:	8d 85 c8 fb ff ff    	lea    0xfffffbc8(%ebp),%eax
     307:	89 44 24 04          	mov    %eax,0x4(%esp)
     30b:	8b 45 ec             	mov    0xffffffec(%ebp),%eax
     30e:	89 04 24             	mov    %eax,(%esp)
     311:	e8 56 08 00 00       	call   b6c <fstat>
                    char *message = "HTTP/1.1 200 OK\r\nContent-Length: ";
     316:	c7 45 f4 c4 18 00 00 	movl   $0x18c4,0xfffffff4(%ebp)
                    send(client, message, strlen(message), 0);
     31d:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     320:	89 04 24             	mov    %eax,(%esp)
     323:	e8 e8 05 00 00       	call   910 <strlen>
     328:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
     32f:	00 
     330:	89 44 24 08          	mov    %eax,0x8(%esp)
     334:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     337:	89 44 24 04          	mov    %eax,0x4(%esp)
     33b:	8b 45 08             	mov    0x8(%ebp),%eax
     33e:	89 04 24             	mov    %eax,(%esp)
     341:	e8 9e 08 00 00       	call   be4 <send>
                    char buff[40];
                    itoa(st.size, buff);
     346:	8b 85 d4 fb ff ff    	mov    0xfffffbd4(%ebp),%eax
     34c:	89 c2                	mov    %eax,%edx
     34e:	8d 85 a0 fb ff ff    	lea    0xfffffba0(%ebp),%eax
     354:	89 44 24 04          	mov    %eax,0x4(%esp)
     358:	89 14 24             	mov    %edx,(%esp)
     35b:	e8 e0 fd ff ff       	call   140 <itoa>
                    send(client, buff, strlen(buff), 0);
     360:	8d 85 a0 fb ff ff    	lea    0xfffffba0(%ebp),%eax
     366:	89 04 24             	mov    %eax,(%esp)
     369:	e8 a2 05 00 00       	call   910 <strlen>
     36e:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
     375:	00 
     376:	89 44 24 08          	mov    %eax,0x8(%esp)
     37a:	8d 85 a0 fb ff ff    	lea    0xfffffba0(%ebp),%eax
     380:	89 44 24 04          	mov    %eax,0x4(%esp)
     384:	8b 45 08             	mov    0x8(%ebp),%eax
     387:	89 04 24             	mov    %eax,(%esp)
     38a:	e8 55 08 00 00       	call   be4 <send>
                    message = "\r\n\r\n";
     38f:	c7 45 f4 e6 18 00 00 	movl   $0x18e6,0xfffffff4(%ebp)
                    send(client, message, strlen(message), 0);
     396:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     399:	89 04 24             	mov    %eax,(%esp)
     39c:	e8 6f 05 00 00       	call   910 <strlen>
     3a1:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
     3a8:	00 
     3a9:	89 44 24 08          	mov    %eax,0x8(%esp)
     3ad:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     3b0:	89 44 24 04          	mov    %eax,0x4(%esp)
     3b4:	8b 45 08             	mov    0x8(%ebp),%eax
     3b7:	89 04 24             	mov    %eax,(%esp)
     3ba:	e8 25 08 00 00       	call   be4 <send>
                    while ((len = read(f, data, sizeof(data))) > 0)
     3bf:	eb 24                	jmp    3e5 <parse_request+0x1d5>
                    {
                        send(client, data, len, 0);
     3c1:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
     3c8:	00 
     3c9:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
     3cc:	89 44 24 08          	mov    %eax,0x8(%esp)
     3d0:	8d 85 d8 fb ff ff    	lea    0xfffffbd8(%ebp),%eax
     3d6:	89 44 24 04          	mov    %eax,0x4(%esp)
     3da:	8b 45 08             	mov    0x8(%ebp),%eax
     3dd:	89 04 24             	mov    %eax,(%esp)
     3e0:	e8 ff 07 00 00       	call   be4 <send>
     3e5:	c7 44 24 08 00 04 00 	movl   $0x400,0x8(%esp)
     3ec:	00 
     3ed:	8d 85 d8 fb ff ff    	lea    0xfffffbd8(%ebp),%eax
     3f3:	89 44 24 04          	mov    %eax,0x4(%esp)
     3f7:	8b 45 ec             	mov    0xffffffec(%ebp),%eax
     3fa:	89 04 24             	mov    %eax,(%esp)
     3fd:	e8 2a 07 00 00       	call   b2c <read>
     402:	89 45 f0             	mov    %eax,0xfffffff0(%ebp)
     405:	83 7d f0 00          	cmpl   $0x0,0xfffffff0(%ebp)
     409:	7f b6                	jg     3c1 <parse_request+0x1b1>
                    }
                    close(f);
     40b:	8b 45 ec             	mov    0xffffffec(%ebp),%eax
     40e:	89 04 24             	mov    %eax,(%esp)
     411:	e8 26 07 00 00       	call   b3c <close>
     416:	eb 30                	jmp    448 <parse_request+0x238>
                } else {
                    char *message = "HTTP/1.1 404 Not Found\r\n\r\nNot Found\r\n";
     418:	c7 45 f8 ec 18 00 00 	movl   $0x18ec,0xfffffff8(%ebp)
                    send(client, message, strlen(message), 0);
     41f:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     422:	89 04 24             	mov    %eax,(%esp)
     425:	e8 e6 04 00 00       	call   910 <strlen>
     42a:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
     431:	00 
     432:	89 44 24 08          	mov    %eax,0x8(%esp)
     436:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     439:	89 44 24 04          	mov    %eax,0x4(%esp)
     43d:	8b 45 08             	mov    0x8(%ebp),%eax
     440:	89 04 24             	mov    %eax,(%esp)
     443:	e8 9c 07 00 00       	call   be4 <send>
                }
                *end = old;
     448:	8b 55 e8             	mov    0xffffffe8(%ebp),%edx
     44b:	0f b6 45 e7          	movzbl 0xffffffe7(%ebp),%eax
     44f:	88 02                	mov    %al,(%edx)
     451:	eb 30                	jmp    483 <parse_request+0x273>
            } else {
                char *message = "HTTP/1.1 400 Bad Request\r\n\r\nBad Request\r\n";
     453:	c7 45 fc 14 19 00 00 	movl   $0x1914,0xfffffffc(%ebp)
                send(client, message, strlen(message), 0);
     45a:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     45d:	89 04 24             	mov    %eax,(%esp)
     460:	e8 ab 04 00 00       	call   910 <strlen>
     465:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
     46c:	00 
     46d:	89 44 24 08          	mov    %eax,0x8(%esp)
     471:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     474:	89 44 24 04          	mov    %eax,0x4(%esp)
     478:	8b 45 08             	mov    0x8(%ebp),%eax
     47b:	89 04 24             	mov    %eax,(%esp)
     47e:	e8 61 07 00 00       	call   be4 <send>
     483:	83 45 d8 01          	addl   $0x1,0xffffffd8(%ebp)
     487:	a1 a8 19 00 00       	mov    0x19a8,%eax
     48c:	39 45 d8             	cmp    %eax,0xffffffd8(%ebp)
     48f:	0f 8c ad fd ff ff    	jl     242 <parse_request+0x32>
            }
        }
    }
    printf(1, "End of request_parse\n");
     495:	c7 44 24 04 3e 19 00 	movl   $0x193e,0x4(%esp)
     49c:	00 
     49d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     4a4:	e8 77 08 00 00       	call   d20 <printf>
}
     4a9:	c9                   	leave  
     4aa:	c3                   	ret    
     4ab:	90                   	nop    
     4ac:	8d 74 26 00          	lea    0x0(%esi),%esi

000004b0 <main>:

int main()
{
     4b0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
     4b4:	83 e4 f0             	and    $0xfffffff0,%esp
     4b7:	ff 71 fc             	pushl  0xfffffffc(%ecx)
     4ba:	55                   	push   %ebp
     4bb:	89 e5                	mov    %esp,%ebp
     4bd:	53                   	push   %ebx
     4be:	51                   	push   %ecx
     4bf:	81 ec 10 0c 00 00    	sub    $0xc10,%esp
    int i;
    line = malloc(MAX_REQ_LINE * sizeof(char *));
     4c5:	c7 04 24 50 00 00 00 	movl   $0x50,(%esp)
     4cc:	e8 6f 0b 00 00       	call   1040 <malloc>
     4d1:	a3 d0 19 00 00       	mov    %eax,0x19d0
    for (i=0; i<MAX_REQ_LINE; i++)
     4d6:	c7 45 d4 00 00 00 00 	movl   $0x0,0xffffffd4(%ebp)
     4dd:	eb 22                	jmp    501 <main+0x51>
        line[i] = malloc(MAX_LINE_LEN);
     4df:	8b 45 d4             	mov    0xffffffd4(%ebp),%eax
     4e2:	c1 e0 02             	shl    $0x2,%eax
     4e5:	89 c2                	mov    %eax,%edx
     4e7:	a1 d0 19 00 00       	mov    0x19d0,%eax
     4ec:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
     4ef:	c7 04 24 c8 00 00 00 	movl   $0xc8,(%esp)
     4f6:	e8 45 0b 00 00       	call   1040 <malloc>
     4fb:	89 03                	mov    %eax,(%ebx)
     4fd:	83 45 d4 01          	addl   $0x1,0xffffffd4(%ebp)
     501:	83 7d d4 13          	cmpl   $0x13,0xffffffd4(%ebp)
     505:	7e d8                	jle    4df <main+0x2f>
    int s = socket(PF_INET, SOCK_STREAM, 0);
     507:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
     50e:	00 
     50f:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
     516:	00 
     517:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     51e:	e8 91 06 00 00       	call   bb4 <socket>
     523:	89 45 d8             	mov    %eax,0xffffffd8(%ebp)
    if (s<0)
     526:	83 7d d8 00          	cmpl   $0x0,0xffffffd8(%ebp)
     52a:	79 0f                	jns    53b <main+0x8b>
        return 1;
     52c:	c7 85 04 f4 ff ff 01 	movl   $0x1,0xfffff404(%ebp)
     533:	00 00 00 
     536:	e9 28 03 00 00       	jmp    863 <main+0x3b3>
    struct sockaddr_in addr;
    int addrlen = sizeof(addr);
     53b:	c7 45 c0 10 00 00 00 	movl   $0x10,0xffffffc0(%ebp)
    addr.sin_family = AF_INET;
     542:	c6 45 c5 02          	movb   $0x2,0xffffffc5(%ebp)
    addr.sin_port = htons(80);
     546:	c7 04 24 50 00 00 00 	movl   $0x50,(%esp)
     54d:	e8 ae 12 00 00       	call   1800 <htons>
     552:	66 89 45 c6          	mov    %ax,0xffffffc6(%ebp)
    addr.sin_addr.s_addr = inet_addr("192.168.1.1");
     556:	c7 04 24 54 19 00 00 	movl   $0x1954,(%esp)
     55d:	e8 be 0e 00 00       	call   1420 <inet_addr>
     562:	89 45 c8             	mov    %eax,0xffffffc8(%ebp)
    if (bind(s, &addr, sizeof(addr))<0)
     565:	8d 45 c4             	lea    0xffffffc4(%ebp),%eax
     568:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
     56f:	00 
     570:	89 44 24 04          	mov    %eax,0x4(%esp)
     574:	8b 45 d8             	mov    0xffffffd8(%ebp),%eax
     577:	89 04 24             	mov    %eax,(%esp)
     57a:	e8 3d 06 00 00       	call   bbc <bind>
     57f:	85 c0                	test   %eax,%eax
     581:	79 0f                	jns    592 <main+0xe2>
        return 1;
     583:	c7 85 04 f4 ff ff 01 	movl   $0x1,0xfffff404(%ebp)
     58a:	00 00 00 
     58d:	e9 d1 02 00 00       	jmp    863 <main+0x3b3>
    if (listen(s, 10)<0)
     592:	c7 44 24 04 0a 00 00 	movl   $0xa,0x4(%esp)
     599:	00 
     59a:	8b 45 d8             	mov    0xffffffd8(%ebp),%eax
     59d:	89 04 24             	mov    %eax,(%esp)
     5a0:	e8 1f 06 00 00       	call   bc4 <listen>
     5a5:	85 c0                	test   %eax,%eax
     5a7:	0f 89 7b 02 00 00    	jns    828 <main+0x378>
        return 1;
     5ad:	c7 85 04 f4 ff ff 01 	movl   $0x1,0xfffff404(%ebp)
     5b4:	00 00 00 
     5b7:	e9 a7 02 00 00       	jmp    863 <main+0x3b3>
    int client;
    unsigned char data[1500];
    int len;
    char fdata[1500];
    while (client = accept(s, &addr, &addrlen))
    {
        int pid = fork();
     5bc:	e8 4b 05 00 00       	call   b0c <fork>
     5c1:	89 45 e4             	mov    %eax,0xffffffe4(%ebp)
        if (pid)
     5c4:	83 7d e4 00          	cmpl   $0x0,0xffffffe4(%ebp)
     5c8:	0f 85 5a 02 00 00    	jne    828 <main+0x378>
            continue;
        printf(1, "forked\n");
     5ce:	c7 44 24 04 60 19 00 	movl   $0x1960,0x4(%esp)
     5d5:	00 
     5d6:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     5dd:	e8 3e 07 00 00       	call   d20 <printf>
        lineptr = 0;
     5e2:	c7 05 a8 19 00 00 00 	movl   $0x0,0x19a8
     5e9:	00 00 00 
        char lastchr = '\0', curchr;
     5ec:	c6 45 ea 00          	movb   $0x0,0xffffffea(%ebp)
        while ((len = recv(client, data, sizeof(data), 0)) > 0)
     5f0:	e9 ea 01 00 00       	jmp    7df <main+0x32f>
        {
            printf(1, "PACK received\n");
     5f5:	c7 44 24 04 68 19 00 	movl   $0x1968,0x4(%esp)
     5fc:	00 
     5fd:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     604:	e8 17 07 00 00       	call   d20 <printf>
                char *old = data;
     609:	8d 85 e4 f9 ff ff    	lea    0xfffff9e4(%ebp),%eax
     60f:	89 45 ec             	mov    %eax,0xffffffec(%ebp)
                int i;
                int reqend = 0;
     612:	c7 45 f4 00 00 00 00 	movl   $0x0,0xfffffff4(%ebp)
                for (i=0; i<len; i++)
     619:	c7 45 f0 00 00 00 00 	movl   $0x0,0xfffffff0(%ebp)
     620:	e9 f8 00 00 00       	jmp    71d <main+0x26d>
                {
                    curchr = data[i];
     625:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
     628:	0f b6 84 05 e4 f9 ff 	movzbl 0xfffff9e4(%ebp,%eax,1),%eax
     62f:	ff 
     630:	88 45 eb             	mov    %al,0xffffffeb(%ebp)
                    if ((data[i] == '\0') || (data[i] == '\n') || (data[i] == '\r'))
     633:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
     636:	0f b6 84 05 e4 f9 ff 	movzbl 0xfffff9e4(%ebp,%eax,1),%eax
     63d:	ff 
     63e:	84 c0                	test   %al,%al
     640:	74 22                	je     664 <main+0x1b4>
     642:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
     645:	0f b6 84 05 e4 f9 ff 	movzbl 0xfffff9e4(%ebp,%eax,1),%eax
     64c:	ff 
     64d:	3c 0a                	cmp    $0xa,%al
     64f:	74 13                	je     664 <main+0x1b4>
     651:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
     654:	0f b6 84 05 e4 f9 ff 	movzbl 0xfffff9e4(%ebp,%eax,1),%eax
     65b:	ff 
     65c:	3c 0d                	cmp    $0xd,%al
     65e:	0f 85 ae 00 00 00    	jne    712 <main+0x262>
                    {
                        data[i] = '\0';
     664:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
     667:	c6 84 05 e4 f9 ff ff 	movb   $0x0,0xfffff9e4(%ebp,%eax,1)
     66e:	00 
//                        printf(1, "%d: %s\n", i, old);
//                        printf(1, "%d %d\n", lastchr, curchr);
                        if (old+1 < &data[i])
     66f:	8b 4d ec             	mov    0xffffffec(%ebp),%ecx
     672:	83 c1 01             	add    $0x1,%ecx
     675:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
     678:	89 c2                	mov    %eax,%edx
     67a:	8d 85 e4 f9 ff ff    	lea    0xfffff9e4(%ebp),%eax
     680:	01 d0                	add    %edx,%eax
     682:	39 c1                	cmp    %eax,%ecx
     684:	73 1c                	jae    6a2 <main+0x1f2>
                            parsedata(old, &data[i]);
     686:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
     689:	89 c2                	mov    %eax,%edx
     68b:	8d 85 e4 f9 ff ff    	lea    0xfffff9e4(%ebp),%eax
     691:	01 d0                	add    %edx,%eax
     693:	89 44 24 04          	mov    %eax,0x4(%esp)
     697:	8b 45 ec             	mov    0xffffffec(%ebp),%eax
     69a:	89 04 24             	mov    %eax,(%esp)
     69d:	e8 ce f9 ff ff       	call   70 <parsedata>
                        if ((lastchr == '\n') && (curchr == '\r'))
     6a2:	80 7d ea 0a          	cmpb   $0xa,0xffffffea(%ebp)
     6a6:	75 11                	jne    6b9 <main+0x209>
     6a8:	80 7d eb 0d          	cmpb   $0xd,0xffffffeb(%ebp)
     6ac:	75 0b                	jne    6b9 <main+0x209>
                        {
                            i++;
     6ae:	83 45 f0 01          	addl   $0x1,0xfffffff0(%ebp)
                            reqend = 1;
     6b2:	c7 45 f4 01 00 00 00 	movl   $0x1,0xfffffff4(%ebp)
                        }
                        if ((lastchr == '\n') && (curchr == '\n'))
     6b9:	80 7d ea 0a          	cmpb   $0xa,0xffffffea(%ebp)
     6bd:	75 0d                	jne    6cc <main+0x21c>
     6bf:	80 7d eb 0a          	cmpb   $0xa,0xffffffeb(%ebp)
     6c3:	75 07                	jne    6cc <main+0x21c>
                            reqend = 1;
     6c5:	c7 45 f4 01 00 00 00 	movl   $0x1,0xfffffff4(%ebp)

                        if (reqend)
     6cc:	83 7d f4 00          	cmpl   $0x0,0xfffffff4(%ebp)
     6d0:	74 2e                	je     700 <main+0x250>
                        {
                            parse_request(client);
     6d2:	8b 45 dc             	mov    0xffffffdc(%ebp),%eax
     6d5:	89 04 24             	mov    %eax,(%esp)
     6d8:	e8 33 fb ff ff       	call   210 <parse_request>
                            reqend = 0;
     6dd:	c7 45 f4 00 00 00 00 	movl   $0x0,0xfffffff4(%ebp)
                            lineptr = 0;
     6e4:	c7 05 a8 19 00 00 00 	movl   $0x0,0x19a8
     6eb:	00 00 00 
                            linepos = 0;
     6ee:	c7 05 ac 19 00 00 00 	movl   $0x0,0x19ac
     6f5:	00 00 00 
                            lastchr = '\0';
     6f8:	c6 45 ea 00          	movb   $0x0,0xffffffea(%ebp)
                            curchr = '\0';
     6fc:	c6 45 eb 00          	movb   $0x0,0xffffffeb(%ebp)
                        }
                        old = &data[i+1];
     700:	8d 85 e4 f9 ff ff    	lea    0xfffff9e4(%ebp),%eax
     706:	8d 50 01             	lea    0x1(%eax),%edx
     709:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
     70c:	8d 04 02             	lea    (%edx,%eax,1),%eax
     70f:	89 45 ec             	mov    %eax,0xffffffec(%ebp)
                    }
                    lastchr = curchr;
     712:	0f b6 45 eb          	movzbl 0xffffffeb(%ebp),%eax
     716:	88 45 ea             	mov    %al,0xffffffea(%ebp)
     719:	83 45 f0 01          	addl   $0x1,0xfffffff0(%ebp)
     71d:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
     720:	3b 45 e0             	cmp    0xffffffe0(%ebp),%eax
     723:	0f 8c fc fe ff ff    	jl     625 <main+0x175>
                }
                if ((i >= len) || ((data[i] != '\0') && (data[i] != '\r') && (data[i] != '\n')))
     729:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
     72c:	3b 45 e0             	cmp    0xffffffe0(%ebp),%eax
     72f:	7d 35                	jge    766 <main+0x2b6>
     731:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
     734:	0f b6 84 05 e4 f9 ff 	movzbl 0xfffff9e4(%ebp,%eax,1),%eax
     73b:	ff 
     73c:	84 c0                	test   %al,%al
     73e:	0f 84 9b 00 00 00    	je     7df <main+0x32f>
     744:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
     747:	0f b6 84 05 e4 f9 ff 	movzbl 0xfffff9e4(%ebp,%eax,1),%eax
     74e:	ff 
     74f:	3c 0d                	cmp    $0xd,%al
     751:	0f 84 88 00 00 00    	je     7df <main+0x32f>
     757:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
     75a:	0f b6 84 05 e4 f9 ff 	movzbl 0xfffff9e4(%ebp,%eax,1),%eax
     761:	ff 
     762:	3c 0a                	cmp    $0xa,%al
     764:	74 79                	je     7df <main+0x32f>
                {
                    if (old < data + len)
     766:	8b 45 e0             	mov    0xffffffe0(%ebp),%eax
     769:	89 c2                	mov    %eax,%edx
     76b:	8d 85 e4 f9 ff ff    	lea    0xfffff9e4(%ebp),%eax
     771:	01 d0                	add    %edx,%eax
     773:	3b 45 ec             	cmp    0xffffffec(%ebp),%eax
     776:	76 67                	jbe    7df <main+0x32f>
                    {
                        finished = 0;
     778:	c7 05 b0 19 00 00 00 	movl   $0x0,0x19b0
     77f:	00 00 00 
                        lineptr++;
     782:	a1 a8 19 00 00       	mov    0x19a8,%eax
     787:	83 c0 01             	add    $0x1,%eax
     78a:	a3 a8 19 00 00       	mov    %eax,0x19a8
                        linepos = (int)&data[0] - (int)old + len;
     78f:	8d 95 e4 f9 ff ff    	lea    0xfffff9e4(%ebp),%edx
     795:	8b 45 ec             	mov    0xffffffec(%ebp),%eax
     798:	89 d1                	mov    %edx,%ecx
     79a:	29 c1                	sub    %eax,%ecx
     79c:	89 c8                	mov    %ecx,%eax
     79e:	03 45 e0             	add    0xffffffe0(%ebp),%eax
     7a1:	a3 ac 19 00 00       	mov    %eax,0x19ac
                        memmove(line[lineptr], old, (int)data+len-(int)old);
     7a6:	8d 85 e4 f9 ff ff    	lea    0xfffff9e4(%ebp),%eax
     7ac:	89 c2                	mov    %eax,%edx
     7ae:	03 55 e0             	add    0xffffffe0(%ebp),%edx
     7b1:	8b 45 ec             	mov    0xffffffec(%ebp),%eax
     7b4:	89 d1                	mov    %edx,%ecx
     7b6:	29 c1                	sub    %eax,%ecx
     7b8:	a1 a8 19 00 00       	mov    0x19a8,%eax
     7bd:	c1 e0 02             	shl    $0x2,%eax
     7c0:	89 c2                	mov    %eax,%edx
     7c2:	a1 d0 19 00 00       	mov    0x19d0,%eax
     7c7:	8d 04 02             	lea    (%edx,%eax,1),%eax
     7ca:	8b 10                	mov    (%eax),%edx
     7cc:	89 4c 24 08          	mov    %ecx,0x8(%esp)
     7d0:	8b 45 ec             	mov    0xffffffec(%ebp),%eax
     7d3:	89 44 24 04          	mov    %eax,0x4(%esp)
     7d7:	89 14 24             	mov    %edx,(%esp)
     7da:	e8 f1 02 00 00       	call   ad0 <memmove>
     7df:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
     7e6:	00 
     7e7:	c7 44 24 08 dc 05 00 	movl   $0x5dc,0x8(%esp)
     7ee:	00 
     7ef:	8d 85 e4 f9 ff ff    	lea    0xfffff9e4(%ebp),%eax
     7f5:	89 44 24 04          	mov    %eax,0x4(%esp)
     7f9:	8b 45 dc             	mov    0xffffffdc(%ebp),%eax
     7fc:	89 04 24             	mov    %eax,(%esp)
     7ff:	e8 d0 03 00 00       	call   bd4 <recv>
     804:	89 45 e0             	mov    %eax,0xffffffe0(%ebp)
     807:	83 7d e0 00          	cmpl   $0x0,0xffffffe0(%ebp)
     80b:	0f 8f e4 fd ff ff    	jg     5f5 <main+0x145>
                    }
                }
        }
        sockclose(client);
     811:	8b 45 dc             	mov    0xffffffdc(%ebp),%eax
     814:	89 04 24             	mov    %eax,(%esp)
     817:	e8 f0 03 00 00       	call   c0c <sockclose>
        return 0;
     81c:	c7 85 04 f4 ff ff 00 	movl   $0x0,0xfffff404(%ebp)
     823:	00 00 00 
     826:	eb 3b                	jmp    863 <main+0x3b3>
     828:	8d 55 c4             	lea    0xffffffc4(%ebp),%edx
     82b:	8d 45 c0             	lea    0xffffffc0(%ebp),%eax
     82e:	89 44 24 08          	mov    %eax,0x8(%esp)
     832:	89 54 24 04          	mov    %edx,0x4(%esp)
     836:	8b 45 d8             	mov    0xffffffd8(%ebp),%eax
     839:	89 04 24             	mov    %eax,(%esp)
     83c:	e8 8b 03 00 00       	call   bcc <accept>
     841:	89 45 dc             	mov    %eax,0xffffffdc(%ebp)
     844:	83 7d dc 00          	cmpl   $0x0,0xffffffdc(%ebp)
     848:	0f 85 6e fd ff ff    	jne    5bc <main+0x10c>
    }
    sockclose(s);
     84e:	8b 45 d8             	mov    0xffffffd8(%ebp),%eax
     851:	89 04 24             	mov    %eax,(%esp)
     854:	e8 b3 03 00 00       	call   c0c <sockclose>
    return 0;
     859:	c7 85 04 f4 ff ff 00 	movl   $0x0,0xfffff404(%ebp)
     860:	00 00 00 
     863:	8b 85 04 f4 ff ff    	mov    0xfffff404(%ebp),%eax
}
     869:	81 c4 10 0c 00 00    	add    $0xc10,%esp
     86f:	59                   	pop    %ecx
     870:	5b                   	pop    %ebx
     871:	5d                   	pop    %ebp
     872:	8d 61 fc             	lea    0xfffffffc(%ecx),%esp
     875:	c3                   	ret    
     876:	90                   	nop    
     877:	90                   	nop    
     878:	90                   	nop    
     879:	90                   	nop    
     87a:	90                   	nop    
     87b:	90                   	nop    
     87c:	90                   	nop    
     87d:	90                   	nop    
     87e:	90                   	nop    
     87f:	90                   	nop    

00000880 <strcpy>:
#include "user.h"

char*
strcpy(char *s, char *t)
{
     880:	55                   	push   %ebp
     881:	89 e5                	mov    %esp,%ebp
     883:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
     886:	8b 45 08             	mov    0x8(%ebp),%eax
     889:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
  while((*s++ = *t++) != 0)
     88c:	8b 45 0c             	mov    0xc(%ebp),%eax
     88f:	0f b6 10             	movzbl (%eax),%edx
     892:	8b 45 08             	mov    0x8(%ebp),%eax
     895:	88 10                	mov    %dl,(%eax)
     897:	8b 45 08             	mov    0x8(%ebp),%eax
     89a:	0f b6 00             	movzbl (%eax),%eax
     89d:	84 c0                	test   %al,%al
     89f:	0f 95 c0             	setne  %al
     8a2:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     8a6:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
     8aa:	84 c0                	test   %al,%al
     8ac:	75 de                	jne    88c <strcpy+0xc>
    ;
  return os;
     8ae:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
}
     8b1:	c9                   	leave  
     8b2:	c3                   	ret    
     8b3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     8b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

000008c0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     8c0:	55                   	push   %ebp
     8c1:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
     8c3:	eb 08                	jmp    8cd <strcmp+0xd>
    p++, q++;
     8c5:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     8c9:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
     8cd:	8b 45 08             	mov    0x8(%ebp),%eax
     8d0:	0f b6 00             	movzbl (%eax),%eax
     8d3:	84 c0                	test   %al,%al
     8d5:	74 10                	je     8e7 <strcmp+0x27>
     8d7:	8b 45 08             	mov    0x8(%ebp),%eax
     8da:	0f b6 10             	movzbl (%eax),%edx
     8dd:	8b 45 0c             	mov    0xc(%ebp),%eax
     8e0:	0f b6 00             	movzbl (%eax),%eax
     8e3:	38 c2                	cmp    %al,%dl
     8e5:	74 de                	je     8c5 <strcmp+0x5>
  return (uchar)*p - (uchar)*q;
     8e7:	8b 45 08             	mov    0x8(%ebp),%eax
     8ea:	0f b6 00             	movzbl (%eax),%eax
     8ed:	0f b6 d0             	movzbl %al,%edx
     8f0:	8b 45 0c             	mov    0xc(%ebp),%eax
     8f3:	0f b6 00             	movzbl (%eax),%eax
     8f6:	0f b6 c0             	movzbl %al,%eax
     8f9:	89 d1                	mov    %edx,%ecx
     8fb:	29 c1                	sub    %eax,%ecx
     8fd:	89 c8                	mov    %ecx,%eax
}
     8ff:	5d                   	pop    %ebp
     900:	c3                   	ret    
     901:	eb 0d                	jmp    910 <strlen>
     903:	90                   	nop    
     904:	90                   	nop    
     905:	90                   	nop    
     906:	90                   	nop    
     907:	90                   	nop    
     908:	90                   	nop    
     909:	90                   	nop    
     90a:	90                   	nop    
     90b:	90                   	nop    
     90c:	90                   	nop    
     90d:	90                   	nop    
     90e:	90                   	nop    
     90f:	90                   	nop    

00000910 <strlen>:

uint
strlen(char *s)
{
     910:	55                   	push   %ebp
     911:	89 e5                	mov    %esp,%ebp
     913:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
     916:	c7 45 fc 00 00 00 00 	movl   $0x0,0xfffffffc(%ebp)
     91d:	eb 04                	jmp    923 <strlen+0x13>
     91f:	83 45 fc 01          	addl   $0x1,0xfffffffc(%ebp)
     923:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     926:	03 45 08             	add    0x8(%ebp),%eax
     929:	0f b6 00             	movzbl (%eax),%eax
     92c:	84 c0                	test   %al,%al
     92e:	75 ef                	jne    91f <strlen+0xf>
    ;
  return n;
     930:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
}
     933:	c9                   	leave  
     934:	c3                   	ret    
     935:	8d 74 26 00          	lea    0x0(%esi),%esi
     939:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00000940 <memset>:

void*
memset(void *dst, int c, uint n)
{
     940:	55                   	push   %ebp
     941:	89 e5                	mov    %esp,%ebp
     943:	83 ec 10             	sub    $0x10,%esp
  char *d;
  
  d = dst;
     946:	8b 45 08             	mov    0x8(%ebp),%eax
     949:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
  while(n-- > 0)
     94c:	eb 0e                	jmp    95c <memset+0x1c>
    *d++ = c;
     94e:	8b 45 0c             	mov    0xc(%ebp),%eax
     951:	89 c2                	mov    %eax,%edx
     953:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     956:	88 10                	mov    %dl,(%eax)
     958:	83 45 fc 01          	addl   $0x1,0xfffffffc(%ebp)
     95c:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
     960:	83 7d 10 ff          	cmpl   $0xffffffff,0x10(%ebp)
     964:	75 e8                	jne    94e <memset+0xe>
  return dst;
     966:	8b 45 08             	mov    0x8(%ebp),%eax
}
     969:	c9                   	leave  
     96a:	c3                   	ret    
     96b:	90                   	nop    
     96c:	8d 74 26 00          	lea    0x0(%esi),%esi

00000970 <strchr>:

char*
strchr(const char *s, char c)
{
     970:	55                   	push   %ebp
     971:	89 e5                	mov    %esp,%ebp
     973:	83 ec 08             	sub    $0x8,%esp
     976:	8b 45 0c             	mov    0xc(%ebp),%eax
     979:	88 45 fc             	mov    %al,0xfffffffc(%ebp)
  for(; *s; s++)
     97c:	eb 17                	jmp    995 <strchr+0x25>
    if(*s == c)
     97e:	8b 45 08             	mov    0x8(%ebp),%eax
     981:	0f b6 00             	movzbl (%eax),%eax
     984:	3a 45 fc             	cmp    0xfffffffc(%ebp),%al
     987:	75 08                	jne    991 <strchr+0x21>
      return (char*) s;
     989:	8b 45 08             	mov    0x8(%ebp),%eax
     98c:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
     98f:	eb 15                	jmp    9a6 <strchr+0x36>
     991:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     995:	8b 45 08             	mov    0x8(%ebp),%eax
     998:	0f b6 00             	movzbl (%eax),%eax
     99b:	84 c0                	test   %al,%al
     99d:	75 df                	jne    97e <strchr+0xe>
  return 0;
     99f:	c7 45 f8 00 00 00 00 	movl   $0x0,0xfffffff8(%ebp)
     9a6:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
}
     9a9:	c9                   	leave  
     9aa:	c3                   	ret    
     9ab:	90                   	nop    
     9ac:	8d 74 26 00          	lea    0x0(%esi),%esi

000009b0 <gets>:

char*
gets(char *buf, int max)
{
     9b0:	55                   	push   %ebp
     9b1:	89 e5                	mov    %esp,%ebp
     9b3:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     9b6:	c7 45 f8 00 00 00 00 	movl   $0x0,0xfffffff8(%ebp)
     9bd:	eb 46                	jmp    a05 <gets+0x55>
    cc = read(0, &c, 1);
     9bf:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
     9c6:	00 
     9c7:	8d 45 f7             	lea    0xfffffff7(%ebp),%eax
     9ca:	89 44 24 04          	mov    %eax,0x4(%esp)
     9ce:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     9d5:	e8 52 01 00 00       	call   b2c <read>
     9da:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
    if(cc < 1)
     9dd:	83 7d fc 00          	cmpl   $0x0,0xfffffffc(%ebp)
     9e1:	7e 2d                	jle    a10 <gets+0x60>
      break;
    buf[i++] = c;
     9e3:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     9e6:	89 c2                	mov    %eax,%edx
     9e8:	03 55 08             	add    0x8(%ebp),%edx
     9eb:	0f b6 45 f7          	movzbl 0xfffffff7(%ebp),%eax
     9ef:	88 02                	mov    %al,(%edx)
     9f1:	83 45 f8 01          	addl   $0x1,0xfffffff8(%ebp)
    if(c == '\n' || c == '\r')
     9f5:	0f b6 45 f7          	movzbl 0xfffffff7(%ebp),%eax
     9f9:	3c 0a                	cmp    $0xa,%al
     9fb:	74 13                	je     a10 <gets+0x60>
     9fd:	0f b6 45 f7          	movzbl 0xfffffff7(%ebp),%eax
     a01:	3c 0d                	cmp    $0xd,%al
     a03:	74 0b                	je     a10 <gets+0x60>
     a05:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     a08:	83 c0 01             	add    $0x1,%eax
     a0b:	3b 45 0c             	cmp    0xc(%ebp),%eax
     a0e:	7c af                	jl     9bf <gets+0xf>
      break;
  }
  buf[i] = '\0';
     a10:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     a13:	03 45 08             	add    0x8(%ebp),%eax
     a16:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
     a19:	8b 45 08             	mov    0x8(%ebp),%eax
}
     a1c:	c9                   	leave  
     a1d:	c3                   	ret    
     a1e:	89 f6                	mov    %esi,%esi

00000a20 <stat>:

int
stat(char *n, struct stat *st)
{
     a20:	55                   	push   %ebp
     a21:	89 e5                	mov    %esp,%ebp
     a23:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     a26:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     a2d:	00 
     a2e:	8b 45 08             	mov    0x8(%ebp),%eax
     a31:	89 04 24             	mov    %eax,(%esp)
     a34:	e8 1b 01 00 00       	call   b54 <open>
     a39:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
  if(fd < 0)
     a3c:	83 7d f8 00          	cmpl   $0x0,0xfffffff8(%ebp)
     a40:	79 09                	jns    a4b <stat+0x2b>
    return -1;
     a42:	c7 45 ec ff ff ff ff 	movl   $0xffffffff,0xffffffec(%ebp)
     a49:	eb 26                	jmp    a71 <stat+0x51>
  r = fstat(fd, st);
     a4b:	8b 45 0c             	mov    0xc(%ebp),%eax
     a4e:	89 44 24 04          	mov    %eax,0x4(%esp)
     a52:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     a55:	89 04 24             	mov    %eax,(%esp)
     a58:	e8 0f 01 00 00       	call   b6c <fstat>
     a5d:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
  close(fd);
     a60:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     a63:	89 04 24             	mov    %eax,(%esp)
     a66:	e8 d1 00 00 00       	call   b3c <close>
  return r;
     a6b:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     a6e:	89 45 ec             	mov    %eax,0xffffffec(%ebp)
     a71:	8b 45 ec             	mov    0xffffffec(%ebp),%eax
}
     a74:	c9                   	leave  
     a75:	c3                   	ret    
     a76:	8d 76 00             	lea    0x0(%esi),%esi
     a79:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00000a80 <atoi>:

int
atoi(const char *s)
{
     a80:	55                   	push   %ebp
     a81:	89 e5                	mov    %esp,%ebp
     a83:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
     a86:	c7 45 fc 00 00 00 00 	movl   $0x0,0xfffffffc(%ebp)
  while('0' <= *s && *s <= '9')
     a8d:	eb 24                	jmp    ab3 <atoi+0x33>
    n = n*10 + *s++ - '0';
     a8f:	8b 55 fc             	mov    0xfffffffc(%ebp),%edx
     a92:	89 d0                	mov    %edx,%eax
     a94:	c1 e0 02             	shl    $0x2,%eax
     a97:	01 d0                	add    %edx,%eax
     a99:	01 c0                	add    %eax,%eax
     a9b:	89 c2                	mov    %eax,%edx
     a9d:	8b 45 08             	mov    0x8(%ebp),%eax
     aa0:	0f b6 00             	movzbl (%eax),%eax
     aa3:	0f be c0             	movsbl %al,%eax
     aa6:	8d 04 02             	lea    (%edx,%eax,1),%eax
     aa9:	83 e8 30             	sub    $0x30,%eax
     aac:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
     aaf:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     ab3:	8b 45 08             	mov    0x8(%ebp),%eax
     ab6:	0f b6 00             	movzbl (%eax),%eax
     ab9:	3c 2f                	cmp    $0x2f,%al
     abb:	7e 0a                	jle    ac7 <atoi+0x47>
     abd:	8b 45 08             	mov    0x8(%ebp),%eax
     ac0:	0f b6 00             	movzbl (%eax),%eax
     ac3:	3c 39                	cmp    $0x39,%al
     ac5:	7e c8                	jle    a8f <atoi+0xf>
  return n;
     ac7:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
}
     aca:	c9                   	leave  
     acb:	c3                   	ret    
     acc:	8d 74 26 00          	lea    0x0(%esi),%esi

00000ad0 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
     ad0:	55                   	push   %ebp
     ad1:	89 e5                	mov    %esp,%ebp
     ad3:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
     ad6:	8b 45 08             	mov    0x8(%ebp),%eax
     ad9:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
  src = vsrc;
     adc:	8b 45 0c             	mov    0xc(%ebp),%eax
     adf:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
  while(n-- > 0)
     ae2:	eb 13                	jmp    af7 <memmove+0x27>
    *dst++ = *src++;
     ae4:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     ae7:	0f b6 10             	movzbl (%eax),%edx
     aea:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     aed:	88 10                	mov    %dl,(%eax)
     aef:	83 45 f8 01          	addl   $0x1,0xfffffff8(%ebp)
     af3:	83 45 fc 01          	addl   $0x1,0xfffffffc(%ebp)
     af7:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     afb:	0f 9f c0             	setg   %al
     afe:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
     b02:	84 c0                	test   %al,%al
     b04:	75 de                	jne    ae4 <memmove+0x14>
  return vdst;
     b06:	8b 45 08             	mov    0x8(%ebp),%eax
}
     b09:	c9                   	leave  
     b0a:	c3                   	ret    
     b0b:	90                   	nop    

00000b0c <fork>:
     b0c:	b8 01 00 00 00       	mov    $0x1,%eax
     b11:	cd 30                	int    $0x30
     b13:	c3                   	ret    

00000b14 <exit>:
     b14:	b8 02 00 00 00       	mov    $0x2,%eax
     b19:	cd 30                	int    $0x30
     b1b:	c3                   	ret    

00000b1c <wait>:
     b1c:	b8 03 00 00 00       	mov    $0x3,%eax
     b21:	cd 30                	int    $0x30
     b23:	c3                   	ret    

00000b24 <pipe>:
     b24:	b8 04 00 00 00       	mov    $0x4,%eax
     b29:	cd 30                	int    $0x30
     b2b:	c3                   	ret    

00000b2c <read>:
     b2c:	b8 06 00 00 00       	mov    $0x6,%eax
     b31:	cd 30                	int    $0x30
     b33:	c3                   	ret    

00000b34 <write>:
     b34:	b8 05 00 00 00       	mov    $0x5,%eax
     b39:	cd 30                	int    $0x30
     b3b:	c3                   	ret    

00000b3c <close>:
     b3c:	b8 07 00 00 00       	mov    $0x7,%eax
     b41:	cd 30                	int    $0x30
     b43:	c3                   	ret    

00000b44 <kill>:
     b44:	b8 08 00 00 00       	mov    $0x8,%eax
     b49:	cd 30                	int    $0x30
     b4b:	c3                   	ret    

00000b4c <exec>:
     b4c:	b8 09 00 00 00       	mov    $0x9,%eax
     b51:	cd 30                	int    $0x30
     b53:	c3                   	ret    

00000b54 <open>:
     b54:	b8 0a 00 00 00       	mov    $0xa,%eax
     b59:	cd 30                	int    $0x30
     b5b:	c3                   	ret    

00000b5c <mknod>:
     b5c:	b8 0b 00 00 00       	mov    $0xb,%eax
     b61:	cd 30                	int    $0x30
     b63:	c3                   	ret    

00000b64 <unlink>:
     b64:	b8 0c 00 00 00       	mov    $0xc,%eax
     b69:	cd 30                	int    $0x30
     b6b:	c3                   	ret    

00000b6c <fstat>:
     b6c:	b8 0d 00 00 00       	mov    $0xd,%eax
     b71:	cd 30                	int    $0x30
     b73:	c3                   	ret    

00000b74 <link>:
     b74:	b8 0e 00 00 00       	mov    $0xe,%eax
     b79:	cd 30                	int    $0x30
     b7b:	c3                   	ret    

00000b7c <mkdir>:
     b7c:	b8 0f 00 00 00       	mov    $0xf,%eax
     b81:	cd 30                	int    $0x30
     b83:	c3                   	ret    

00000b84 <chdir>:
     b84:	b8 10 00 00 00       	mov    $0x10,%eax
     b89:	cd 30                	int    $0x30
     b8b:	c3                   	ret    

00000b8c <dup>:
     b8c:	b8 11 00 00 00       	mov    $0x11,%eax
     b91:	cd 30                	int    $0x30
     b93:	c3                   	ret    

00000b94 <getpid>:
     b94:	b8 12 00 00 00       	mov    $0x12,%eax
     b99:	cd 30                	int    $0x30
     b9b:	c3                   	ret    

00000b9c <sbrk>:
     b9c:	b8 13 00 00 00       	mov    $0x13,%eax
     ba1:	cd 30                	int    $0x30
     ba3:	c3                   	ret    

00000ba4 <sleep>:
     ba4:	b8 14 00 00 00       	mov    $0x14,%eax
     ba9:	cd 30                	int    $0x30
     bab:	c3                   	ret    

00000bac <upmsec>:
     bac:	b8 15 00 00 00       	mov    $0x15,%eax
     bb1:	cd 30                	int    $0x30
     bb3:	c3                   	ret    

00000bb4 <socket>:
     bb4:	b8 16 00 00 00       	mov    $0x16,%eax
     bb9:	cd 30                	int    $0x30
     bbb:	c3                   	ret    

00000bbc <bind>:
     bbc:	b8 17 00 00 00       	mov    $0x17,%eax
     bc1:	cd 30                	int    $0x30
     bc3:	c3                   	ret    

00000bc4 <listen>:
     bc4:	b8 18 00 00 00       	mov    $0x18,%eax
     bc9:	cd 30                	int    $0x30
     bcb:	c3                   	ret    

00000bcc <accept>:
     bcc:	b8 19 00 00 00       	mov    $0x19,%eax
     bd1:	cd 30                	int    $0x30
     bd3:	c3                   	ret    

00000bd4 <recv>:
     bd4:	b8 1a 00 00 00       	mov    $0x1a,%eax
     bd9:	cd 30                	int    $0x30
     bdb:	c3                   	ret    

00000bdc <recvfrom>:
     bdc:	b8 1b 00 00 00       	mov    $0x1b,%eax
     be1:	cd 30                	int    $0x30
     be3:	c3                   	ret    

00000be4 <send>:
     be4:	b8 1c 00 00 00       	mov    $0x1c,%eax
     be9:	cd 30                	int    $0x30
     beb:	c3                   	ret    

00000bec <sendto>:
     bec:	b8 1d 00 00 00       	mov    $0x1d,%eax
     bf1:	cd 30                	int    $0x30
     bf3:	c3                   	ret    

00000bf4 <shutdown>:
     bf4:	b8 1e 00 00 00       	mov    $0x1e,%eax
     bf9:	cd 30                	int    $0x30
     bfb:	c3                   	ret    

00000bfc <getsockopt>:
     bfc:	b8 1f 00 00 00       	mov    $0x1f,%eax
     c01:	cd 30                	int    $0x30
     c03:	c3                   	ret    

00000c04 <setsockopt>:
     c04:	b8 20 00 00 00       	mov    $0x20,%eax
     c09:	cd 30                	int    $0x30
     c0b:	c3                   	ret    

00000c0c <sockclose>:
     c0c:	b8 21 00 00 00       	mov    $0x21,%eax
     c11:	cd 30                	int    $0x30
     c13:	c3                   	ret    

00000c14 <connect>:
     c14:	b8 22 00 00 00       	mov    $0x22,%eax
     c19:	cd 30                	int    $0x30
     c1b:	c3                   	ret    

00000c1c <getpeername>:
     c1c:	b8 23 00 00 00       	mov    $0x23,%eax
     c21:	cd 30                	int    $0x30
     c23:	c3                   	ret    

00000c24 <getsockname>:
     c24:	b8 24 00 00 00       	mov    $0x24,%eax
     c29:	cd 30                	int    $0x30
     c2b:	c3                   	ret    
     c2c:	90                   	nop    
     c2d:	90                   	nop    
     c2e:	90                   	nop    
     c2f:	90                   	nop    

00000c30 <putc>:
#include "user.h"

void
putc(int fd, char c)
{
     c30:	55                   	push   %ebp
     c31:	89 e5                	mov    %esp,%ebp
     c33:	83 ec 18             	sub    $0x18,%esp
     c36:	8b 45 0c             	mov    0xc(%ebp),%eax
     c39:	88 45 fc             	mov    %al,0xfffffffc(%ebp)
  write(fd, &c, 1);
     c3c:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
     c43:	00 
     c44:	8d 45 fc             	lea    0xfffffffc(%ebp),%eax
     c47:	89 44 24 04          	mov    %eax,0x4(%esp)
     c4b:	8b 45 08             	mov    0x8(%ebp),%eax
     c4e:	89 04 24             	mov    %eax,(%esp)
     c51:	e8 de fe ff ff       	call   b34 <write>
}
     c56:	c9                   	leave  
     c57:	c3                   	ret    
     c58:	90                   	nop    
     c59:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi

00000c60 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     c60:	55                   	push   %ebp
     c61:	89 e5                	mov    %esp,%ebp
     c63:	53                   	push   %ebx
     c64:	83 ec 34             	sub    $0x34,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     c67:	c7 45 f4 00 00 00 00 	movl   $0x0,0xfffffff4(%ebp)
  if(sgn && xx < 0){
     c6e:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
     c72:	74 17                	je     c8b <printint+0x2b>
     c74:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     c78:	79 11                	jns    c8b <printint+0x2b>
    neg = 1;
     c7a:	c7 45 f4 01 00 00 00 	movl   $0x1,0xfffffff4(%ebp)
    x = -xx;
     c81:	8b 45 0c             	mov    0xc(%ebp),%eax
     c84:	f7 d8                	neg    %eax
     c86:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
     c89:	eb 06                	jmp    c91 <printint+0x31>
  } else {
    x = xx;
     c8b:	8b 45 0c             	mov    0xc(%ebp),%eax
     c8e:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
  }

  i = 0;
     c91:	c7 45 f0 00 00 00 00 	movl   $0x0,0xfffffff0(%ebp)
  do{
    buf[i++] = digits[x % base];
     c98:	8b 4d f0             	mov    0xfffffff0(%ebp),%ecx
     c9b:	8b 55 10             	mov    0x10(%ebp),%edx
     c9e:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     ca1:	89 d3                	mov    %edx,%ebx
     ca3:	ba 00 00 00 00       	mov    $0x0,%edx
     ca8:	f7 f3                	div    %ebx
     caa:	89 d0                	mov    %edx,%eax
     cac:	0f b6 80 94 19 00 00 	movzbl 0x1994(%eax),%eax
     cb3:	88 44 0d e0          	mov    %al,0xffffffe0(%ebp,%ecx,1)
     cb7:	83 45 f0 01          	addl   $0x1,0xfffffff0(%ebp)
  }while((x /= base) != 0);
     cbb:	8b 55 10             	mov    0x10(%ebp),%edx
     cbe:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     cc1:	89 d1                	mov    %edx,%ecx
     cc3:	ba 00 00 00 00       	mov    $0x0,%edx
     cc8:	f7 f1                	div    %ecx
     cca:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
     ccd:	83 7d f8 00          	cmpl   $0x0,0xfffffff8(%ebp)
     cd1:	75 c5                	jne    c98 <printint+0x38>
  if(neg)
     cd3:	83 7d f4 00          	cmpl   $0x0,0xfffffff4(%ebp)
     cd7:	74 28                	je     d01 <printint+0xa1>
    buf[i++] = '-';
     cd9:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
     cdc:	c6 44 05 e0 2d       	movb   $0x2d,0xffffffe0(%ebp,%eax,1)
     ce1:	83 45 f0 01          	addl   $0x1,0xfffffff0(%ebp)

  while(--i >= 0)
     ce5:	eb 1a                	jmp    d01 <printint+0xa1>
    putc(fd, buf[i]);
     ce7:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
     cea:	0f b6 44 05 e0       	movzbl 0xffffffe0(%ebp,%eax,1),%eax
     cef:	0f be c0             	movsbl %al,%eax
     cf2:	89 44 24 04          	mov    %eax,0x4(%esp)
     cf6:	8b 45 08             	mov    0x8(%ebp),%eax
     cf9:	89 04 24             	mov    %eax,(%esp)
     cfc:	e8 2f ff ff ff       	call   c30 <putc>
     d01:	83 6d f0 01          	subl   $0x1,0xfffffff0(%ebp)
     d05:	83 7d f0 00          	cmpl   $0x0,0xfffffff0(%ebp)
     d09:	79 dc                	jns    ce7 <printint+0x87>
}
     d0b:	83 c4 34             	add    $0x34,%esp
     d0e:	5b                   	pop    %ebx
     d0f:	5d                   	pop    %ebp
     d10:	c3                   	ret    
     d11:	eb 0d                	jmp    d20 <printf>
     d13:	90                   	nop    
     d14:	90                   	nop    
     d15:	90                   	nop    
     d16:	90                   	nop    
     d17:	90                   	nop    
     d18:	90                   	nop    
     d19:	90                   	nop    
     d1a:	90                   	nop    
     d1b:	90                   	nop    
     d1c:	90                   	nop    
     d1d:	90                   	nop    
     d1e:	90                   	nop    
     d1f:	90                   	nop    

00000d20 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
     d20:	55                   	push   %ebp
     d21:	89 e5                	mov    %esp,%ebp
     d23:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
     d26:	c7 45 f8 00 00 00 00 	movl   $0x0,0xfffffff8(%ebp)
  ap = (uint*)(void*)&fmt + 1;
     d2d:	8d 45 0c             	lea    0xc(%ebp),%eax
     d30:	83 c0 04             	add    $0x4,%eax
     d33:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
  for(i = 0; fmt[i]; i++){
     d36:	c7 45 f4 00 00 00 00 	movl   $0x0,0xfffffff4(%ebp)
     d3d:	e9 7b 01 00 00       	jmp    ebd <printf+0x19d>
    c = fmt[i] & 0xff;
     d42:	8b 55 0c             	mov    0xc(%ebp),%edx
     d45:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     d48:	8d 04 02             	lea    (%edx,%eax,1),%eax
     d4b:	0f b6 00             	movzbl (%eax),%eax
     d4e:	0f be c0             	movsbl %al,%eax
     d51:	25 ff 00 00 00       	and    $0xff,%eax
     d56:	89 45 f0             	mov    %eax,0xfffffff0(%ebp)
    if(state == 0){
     d59:	83 7d f8 00          	cmpl   $0x0,0xfffffff8(%ebp)
     d5d:	75 2c                	jne    d8b <printf+0x6b>
      if(c == '%'){
     d5f:	83 7d f0 25          	cmpl   $0x25,0xfffffff0(%ebp)
     d63:	75 0c                	jne    d71 <printf+0x51>
        state = '%';
     d65:	c7 45 f8 25 00 00 00 	movl   $0x25,0xfffffff8(%ebp)
     d6c:	e9 48 01 00 00       	jmp    eb9 <printf+0x199>
      } else {
        putc(fd, c);
     d71:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
     d74:	0f be c0             	movsbl %al,%eax
     d77:	89 44 24 04          	mov    %eax,0x4(%esp)
     d7b:	8b 45 08             	mov    0x8(%ebp),%eax
     d7e:	89 04 24             	mov    %eax,(%esp)
     d81:	e8 aa fe ff ff       	call   c30 <putc>
     d86:	e9 2e 01 00 00       	jmp    eb9 <printf+0x199>
      }
    } else if(state == '%'){
     d8b:	83 7d f8 25          	cmpl   $0x25,0xfffffff8(%ebp)
     d8f:	0f 85 24 01 00 00    	jne    eb9 <printf+0x199>
      if(c == 'd'){
     d95:	83 7d f0 64          	cmpl   $0x64,0xfffffff0(%ebp)
     d99:	75 2d                	jne    dc8 <printf+0xa8>
        printint(fd, *ap, 10, 1);
     d9b:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     d9e:	8b 00                	mov    (%eax),%eax
     da0:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
     da7:	00 
     da8:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
     daf:	00 
     db0:	89 44 24 04          	mov    %eax,0x4(%esp)
     db4:	8b 45 08             	mov    0x8(%ebp),%eax
     db7:	89 04 24             	mov    %eax,(%esp)
     dba:	e8 a1 fe ff ff       	call   c60 <printint>
        ap++;
     dbf:	83 45 fc 04          	addl   $0x4,0xfffffffc(%ebp)
     dc3:	e9 ea 00 00 00       	jmp    eb2 <printf+0x192>
      } else if(c == 'x' || c == 'p'){
     dc8:	83 7d f0 78          	cmpl   $0x78,0xfffffff0(%ebp)
     dcc:	74 06                	je     dd4 <printf+0xb4>
     dce:	83 7d f0 70          	cmpl   $0x70,0xfffffff0(%ebp)
     dd2:	75 2d                	jne    e01 <printf+0xe1>
        printint(fd, *ap, 16, 0);
     dd4:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     dd7:	8b 00                	mov    (%eax),%eax
     dd9:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
     de0:	00 
     de1:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
     de8:	00 
     de9:	89 44 24 04          	mov    %eax,0x4(%esp)
     ded:	8b 45 08             	mov    0x8(%ebp),%eax
     df0:	89 04 24             	mov    %eax,(%esp)
     df3:	e8 68 fe ff ff       	call   c60 <printint>
        ap++;
     df8:	83 45 fc 04          	addl   $0x4,0xfffffffc(%ebp)
     dfc:	e9 b1 00 00 00       	jmp    eb2 <printf+0x192>
      } else if(c == 's'){
     e01:	83 7d f0 73          	cmpl   $0x73,0xfffffff0(%ebp)
     e05:	75 43                	jne    e4a <printf+0x12a>
        s = (char*)*ap;
     e07:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     e0a:	8b 00                	mov    (%eax),%eax
     e0c:	89 45 ec             	mov    %eax,0xffffffec(%ebp)
        ap++;
     e0f:	83 45 fc 04          	addl   $0x4,0xfffffffc(%ebp)
        if(s == 0)
     e13:	83 7d ec 00          	cmpl   $0x0,0xffffffec(%ebp)
     e17:	75 25                	jne    e3e <printf+0x11e>
          s = "(null)";
     e19:	c7 45 ec 77 19 00 00 	movl   $0x1977,0xffffffec(%ebp)
        while(*s != 0){
     e20:	eb 1c                	jmp    e3e <printf+0x11e>
          putc(fd, *s);
     e22:	8b 45 ec             	mov    0xffffffec(%ebp),%eax
     e25:	0f b6 00             	movzbl (%eax),%eax
     e28:	0f be c0             	movsbl %al,%eax
     e2b:	89 44 24 04          	mov    %eax,0x4(%esp)
     e2f:	8b 45 08             	mov    0x8(%ebp),%eax
     e32:	89 04 24             	mov    %eax,(%esp)
     e35:	e8 f6 fd ff ff       	call   c30 <putc>
          s++;
     e3a:	83 45 ec 01          	addl   $0x1,0xffffffec(%ebp)
     e3e:	8b 45 ec             	mov    0xffffffec(%ebp),%eax
     e41:	0f b6 00             	movzbl (%eax),%eax
     e44:	84 c0                	test   %al,%al
     e46:	75 da                	jne    e22 <printf+0x102>
     e48:	eb 68                	jmp    eb2 <printf+0x192>
        }
      } else if(c == 'c'){
     e4a:	83 7d f0 63          	cmpl   $0x63,0xfffffff0(%ebp)
     e4e:	75 1d                	jne    e6d <printf+0x14d>
        putc(fd, *ap);
     e50:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     e53:	8b 00                	mov    (%eax),%eax
     e55:	0f be c0             	movsbl %al,%eax
     e58:	89 44 24 04          	mov    %eax,0x4(%esp)
     e5c:	8b 45 08             	mov    0x8(%ebp),%eax
     e5f:	89 04 24             	mov    %eax,(%esp)
     e62:	e8 c9 fd ff ff       	call   c30 <putc>
        ap++;
     e67:	83 45 fc 04          	addl   $0x4,0xfffffffc(%ebp)
     e6b:	eb 45                	jmp    eb2 <printf+0x192>
      } else if(c == '%'){
     e6d:	83 7d f0 25          	cmpl   $0x25,0xfffffff0(%ebp)
     e71:	75 17                	jne    e8a <printf+0x16a>
        putc(fd, c);
     e73:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
     e76:	0f be c0             	movsbl %al,%eax
     e79:	89 44 24 04          	mov    %eax,0x4(%esp)
     e7d:	8b 45 08             	mov    0x8(%ebp),%eax
     e80:	89 04 24             	mov    %eax,(%esp)
     e83:	e8 a8 fd ff ff       	call   c30 <putc>
     e88:	eb 28                	jmp    eb2 <printf+0x192>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     e8a:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
     e91:	00 
     e92:	8b 45 08             	mov    0x8(%ebp),%eax
     e95:	89 04 24             	mov    %eax,(%esp)
     e98:	e8 93 fd ff ff       	call   c30 <putc>
        putc(fd, c);
     e9d:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
     ea0:	0f be c0             	movsbl %al,%eax
     ea3:	89 44 24 04          	mov    %eax,0x4(%esp)
     ea7:	8b 45 08             	mov    0x8(%ebp),%eax
     eaa:	89 04 24             	mov    %eax,(%esp)
     ead:	e8 7e fd ff ff       	call   c30 <putc>
      }
      state = 0;
     eb2:	c7 45 f8 00 00 00 00 	movl   $0x0,0xfffffff8(%ebp)
     eb9:	83 45 f4 01          	addl   $0x1,0xfffffff4(%ebp)
     ebd:	8b 55 0c             	mov    0xc(%ebp),%edx
     ec0:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     ec3:	8d 04 02             	lea    (%edx,%eax,1),%eax
     ec6:	0f b6 00             	movzbl (%eax),%eax
     ec9:	84 c0                	test   %al,%al
     ecb:	0f 85 71 fe ff ff    	jne    d42 <printf+0x22>
    }
  }
}
     ed1:	c9                   	leave  
     ed2:	c3                   	ret    
     ed3:	90                   	nop    
     ed4:	90                   	nop    
     ed5:	90                   	nop    
     ed6:	90                   	nop    
     ed7:	90                   	nop    
     ed8:	90                   	nop    
     ed9:	90                   	nop    
     eda:	90                   	nop    
     edb:	90                   	nop    
     edc:	90                   	nop    
     edd:	90                   	nop    
     ede:	90                   	nop    
     edf:	90                   	nop    

00000ee0 <free>:
static Header *freep;

void
free(void *ap)
{
     ee0:	55                   	push   %ebp
     ee1:	89 e5                	mov    %esp,%ebp
     ee3:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*) ap - 1;
     ee6:	8b 45 08             	mov    0x8(%ebp),%eax
     ee9:	83 e8 08             	sub    $0x8,%eax
     eec:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     eef:	a1 bc 19 00 00       	mov    0x19bc,%eax
     ef4:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
     ef7:	eb 24                	jmp    f1d <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     ef9:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     efc:	8b 00                	mov    (%eax),%eax
     efe:	3b 45 fc             	cmp    0xfffffffc(%ebp),%eax
     f01:	77 12                	ja     f15 <free+0x35>
     f03:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     f06:	3b 45 fc             	cmp    0xfffffffc(%ebp),%eax
     f09:	77 24                	ja     f2f <free+0x4f>
     f0b:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     f0e:	8b 00                	mov    (%eax),%eax
     f10:	3b 45 f8             	cmp    0xfffffff8(%ebp),%eax
     f13:	77 1a                	ja     f2f <free+0x4f>
     f15:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     f18:	8b 00                	mov    (%eax),%eax
     f1a:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
     f1d:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     f20:	3b 45 fc             	cmp    0xfffffffc(%ebp),%eax
     f23:	76 d4                	jbe    ef9 <free+0x19>
     f25:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     f28:	8b 00                	mov    (%eax),%eax
     f2a:	3b 45 f8             	cmp    0xfffffff8(%ebp),%eax
     f2d:	76 ca                	jbe    ef9 <free+0x19>
      break;
  if(bp + bp->s.size == p->s.ptr){
     f2f:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     f32:	8b 40 04             	mov    0x4(%eax),%eax
     f35:	c1 e0 03             	shl    $0x3,%eax
     f38:	89 c2                	mov    %eax,%edx
     f3a:	03 55 f8             	add    0xfffffff8(%ebp),%edx
     f3d:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     f40:	8b 00                	mov    (%eax),%eax
     f42:	39 c2                	cmp    %eax,%edx
     f44:	75 24                	jne    f6a <free+0x8a>
    bp->s.size += p->s.ptr->s.size;
     f46:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     f49:	8b 50 04             	mov    0x4(%eax),%edx
     f4c:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     f4f:	8b 00                	mov    (%eax),%eax
     f51:	8b 40 04             	mov    0x4(%eax),%eax
     f54:	01 c2                	add    %eax,%edx
     f56:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     f59:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
     f5c:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     f5f:	8b 00                	mov    (%eax),%eax
     f61:	8b 10                	mov    (%eax),%edx
     f63:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     f66:	89 10                	mov    %edx,(%eax)
     f68:	eb 0a                	jmp    f74 <free+0x94>
  } else
    bp->s.ptr = p->s.ptr;
     f6a:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     f6d:	8b 10                	mov    (%eax),%edx
     f6f:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     f72:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
     f74:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     f77:	8b 40 04             	mov    0x4(%eax),%eax
     f7a:	c1 e0 03             	shl    $0x3,%eax
     f7d:	03 45 fc             	add    0xfffffffc(%ebp),%eax
     f80:	3b 45 f8             	cmp    0xfffffff8(%ebp),%eax
     f83:	75 20                	jne    fa5 <free+0xc5>
    p->s.size += bp->s.size;
     f85:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     f88:	8b 50 04             	mov    0x4(%eax),%edx
     f8b:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     f8e:	8b 40 04             	mov    0x4(%eax),%eax
     f91:	01 c2                	add    %eax,%edx
     f93:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     f96:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
     f99:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     f9c:	8b 10                	mov    (%eax),%edx
     f9e:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     fa1:	89 10                	mov    %edx,(%eax)
     fa3:	eb 08                	jmp    fad <free+0xcd>
  } else
    p->s.ptr = bp;
     fa5:	8b 55 fc             	mov    0xfffffffc(%ebp),%edx
     fa8:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     fab:	89 02                	mov    %eax,(%edx)
  freep = p;
     fad:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     fb0:	a3 bc 19 00 00       	mov    %eax,0x19bc
}
     fb5:	c9                   	leave  
     fb6:	c3                   	ret    
     fb7:	89 f6                	mov    %esi,%esi
     fb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00000fc0 <morecore>:

static Header*
morecore(uint nu)
{
     fc0:	55                   	push   %ebp
     fc1:	89 e5                	mov    %esp,%ebp
     fc3:	83 ec 18             	sub    $0x18,%esp
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
     fc6:	8b 45 08             	mov    0x8(%ebp),%eax
     fc9:	c1 e0 03             	shl    $0x3,%eax
     fcc:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
  size += PAGE - size % PAGE;
     fcf:	8b 55 fc             	mov    0xfffffffc(%ebp),%edx
     fd2:	89 d0                	mov    %edx,%eax
     fd4:	c1 f8 1f             	sar    $0x1f,%eax
     fd7:	89 c1                	mov    %eax,%ecx
     fd9:	c1 e9 14             	shr    $0x14,%ecx
     fdc:	8d 04 0a             	lea    (%edx,%ecx,1),%eax
     fdf:	25 ff 0f 00 00       	and    $0xfff,%eax
     fe4:	29 c8                	sub    %ecx,%eax
     fe6:	89 c2                	mov    %eax,%edx
     fe8:	b8 00 10 00 00       	mov    $0x1000,%eax
     fed:	29 d0                	sub    %edx,%eax
     fef:	01 45 fc             	add    %eax,0xfffffffc(%ebp)
#endif
#ifdef UMALLOC_DEBUG
  printf(1, "size: %d\n", size);
#endif
  p = sbrk(size);
     ff2:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     ff5:	89 04 24             	mov    %eax,(%esp)
     ff8:	e8 9f fb ff ff       	call   b9c <sbrk>
     ffd:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
  if(p == (char*) -1)
    1000:	83 7d f4 ff          	cmpl   $0xffffffff,0xfffffff4(%ebp)
    1004:	75 09                	jne    100f <morecore+0x4f>
    return 0;
    1006:	c7 45 ec 00 00 00 00 	movl   $0x0,0xffffffec(%ebp)
    100d:	eb 2a                	jmp    1039 <morecore+0x79>
  hp = (Header*)p;
    100f:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
    1012:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
#ifdef UMALLOC_NOALIGN
  hp->s.size = nu;
#else
  hp->s.size = size / sizeof(Header);
    1015:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
    1018:	89 c2                	mov    %eax,%edx
    101a:	c1 ea 03             	shr    $0x3,%edx
    101d:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
    1020:	89 50 04             	mov    %edx,0x4(%eax)
#endif
  free((void*)(hp + 1));
    1023:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
    1026:	83 c0 08             	add    $0x8,%eax
    1029:	89 04 24             	mov    %eax,(%esp)
    102c:	e8 af fe ff ff       	call   ee0 <free>
  return freep;
    1031:	a1 bc 19 00 00       	mov    0x19bc,%eax
    1036:	89 45 ec             	mov    %eax,0xffffffec(%ebp)
    1039:	8b 45 ec             	mov    0xffffffec(%ebp),%eax
}
    103c:	c9                   	leave  
    103d:	c3                   	ret    
    103e:	89 f6                	mov    %esi,%esi

00001040 <malloc>:

void*
malloc(uint nbytes)
{
    1040:	55                   	push   %ebp
    1041:	89 e5                	mov    %esp,%ebp
    1043:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

#ifdef UMALLOC_DEBUG
  printf(1, "malloc: %d bytes\n", nbytes);
  printf(1, "size of Header: %d\n", sizeof(Header));
#endif
  if (PAGE % sizeof(Header))
      printf(2, "Warning! align failed! Need UMALLOC_NOALIGN\n");
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1046:	8b 45 08             	mov    0x8(%ebp),%eax
    1049:	83 c0 07             	add    $0x7,%eax
    104c:	c1 e8 03             	shr    $0x3,%eax
    104f:	83 c0 01             	add    $0x1,%eax
    1052:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
  if((prevp = freep) == 0){
    1055:	a1 bc 19 00 00       	mov    0x19bc,%eax
    105a:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
    105d:	83 7d f8 00          	cmpl   $0x0,0xfffffff8(%ebp)
    1061:	75 23                	jne    1086 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
    1063:	c7 45 f8 b4 19 00 00 	movl   $0x19b4,0xfffffff8(%ebp)
    106a:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
    106d:	a3 bc 19 00 00       	mov    %eax,0x19bc
    1072:	a1 bc 19 00 00       	mov    0x19bc,%eax
    1077:	a3 b4 19 00 00       	mov    %eax,0x19b4
    base.s.size = 0;
    107c:	c7 05 b8 19 00 00 00 	movl   $0x0,0x19b8
    1083:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1086:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
    1089:	8b 00                	mov    (%eax),%eax
    108b:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
    if(p->s.size >= nunits){
    108e:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
    1091:	8b 40 04             	mov    0x4(%eax),%eax
    1094:	3b 45 fc             	cmp    0xfffffffc(%ebp),%eax
    1097:	72 50                	jb     10e9 <malloc+0xa9>
      if(p->s.size == nunits)
    1099:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
    109c:	8b 40 04             	mov    0x4(%eax),%eax
    109f:	3b 45 fc             	cmp    0xfffffffc(%ebp),%eax
    10a2:	75 0c                	jne    10b0 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
    10a4:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
    10a7:	8b 10                	mov    (%eax),%edx
    10a9:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
    10ac:	89 10                	mov    %edx,(%eax)
    10ae:	eb 26                	jmp    10d6 <malloc+0x96>
      else {
        p->s.size -= nunits;
    10b0:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
    10b3:	8b 40 04             	mov    0x4(%eax),%eax
    10b6:	89 c2                	mov    %eax,%edx
    10b8:	2b 55 fc             	sub    0xfffffffc(%ebp),%edx
    10bb:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
    10be:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    10c1:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
    10c4:	8b 40 04             	mov    0x4(%eax),%eax
    10c7:	c1 e0 03             	shl    $0x3,%eax
    10ca:	01 45 f4             	add    %eax,0xfffffff4(%ebp)
        p->s.size = nunits;
    10cd:	8b 55 f4             	mov    0xfffffff4(%ebp),%edx
    10d0:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
    10d3:	89 42 04             	mov    %eax,0x4(%edx)
      }
      freep = prevp;
    10d6:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
    10d9:	a3 bc 19 00 00       	mov    %eax,0x19bc
      return (void*) (p + 1);
    10de:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
    10e1:	83 c0 08             	add    $0x8,%eax
    10e4:	89 45 ec             	mov    %eax,0xffffffec(%ebp)
    10e7:	eb 3a                	jmp    1123 <malloc+0xe3>
    }
    if(p == freep)
    10e9:	a1 bc 19 00 00       	mov    0x19bc,%eax
    10ee:	39 45 f4             	cmp    %eax,0xfffffff4(%ebp)
    10f1:	75 1d                	jne    1110 <malloc+0xd0>
      if((p = morecore(nunits)) == 0)
    10f3:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
    10f6:	89 04 24             	mov    %eax,(%esp)
    10f9:	e8 c2 fe ff ff       	call   fc0 <morecore>
    10fe:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
    1101:	83 7d f4 00          	cmpl   $0x0,0xfffffff4(%ebp)
    1105:	75 09                	jne    1110 <malloc+0xd0>
        return 0;
    1107:	c7 45 ec 00 00 00 00 	movl   $0x0,0xffffffec(%ebp)
    110e:	eb 13                	jmp    1123 <malloc+0xe3>
    1110:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
    1113:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
    1116:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
    1119:	8b 00                	mov    (%eax),%eax
    111b:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
  }
    111e:	e9 6b ff ff ff       	jmp    108e <malloc+0x4e>
    1123:	8b 45 ec             	mov    0xffffffec(%ebp),%eax
}
    1126:	c9                   	leave  
    1127:	c3                   	ret    
    1128:	90                   	nop    
    1129:	90                   	nop    
    112a:	90                   	nop    
    112b:	90                   	nop    
    112c:	90                   	nop    
    112d:	90                   	nop    
    112e:	90                   	nop    
    112f:	90                   	nop    

00001130 <lwip_chksum>:


static u16_t
lwip_chksum(void *dataptr, int len)
{
    1130:	55                   	push   %ebp
    1131:	89 e5                	mov    %esp,%ebp
    1133:	83 ec 18             	sub    $0x18,%esp
  u32_t acc;

  LWIP_DEBUGF(INET_DEBUG, ("lwip_chksum(%p, %d)\n", (void *)dataptr, len));
  for(acc = 0; len > 1; len -= 2) {
    1136:	c7 45 fc 00 00 00 00 	movl   $0x0,0xfffffffc(%ebp)
    113d:	eb 19                	jmp    1158 <lwip_chksum+0x28>
      /*    acc = acc + *((u16_t *)dataptr)++;*/
    acc += *(u16_t *)dataptr;
    113f:	8b 45 08             	mov    0x8(%ebp),%eax
    1142:	0f b7 00             	movzwl (%eax),%eax
    1145:	0f b7 c0             	movzwl %ax,%eax
    1148:	01 45 fc             	add    %eax,0xfffffffc(%ebp)
    dataptr = (void *)((u16_t *)dataptr + 1);
    114b:	8b 45 08             	mov    0x8(%ebp),%eax
    114e:	83 c0 02             	add    $0x2,%eax
    1151:	89 45 08             	mov    %eax,0x8(%ebp)
    1154:	83 6d 0c 02          	subl   $0x2,0xc(%ebp)
    1158:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
    115c:	7f e1                	jg     113f <lwip_chksum+0xf>
  }

  /* add up any odd byte */
  if (len == 1) {
    115e:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
    1162:	75 1d                	jne    1181 <lwip_chksum+0x51>
    acc += htons((u16_t)((*(u8_t *)dataptr) & 0xff) << 8);
    1164:	8b 45 08             	mov    0x8(%ebp),%eax
    1167:	0f b6 00             	movzbl (%eax),%eax
    116a:	0f b6 c0             	movzbl %al,%eax
    116d:	c1 e0 08             	shl    $0x8,%eax
    1170:	0f b7 c0             	movzwl %ax,%eax
    1173:	89 04 24             	mov    %eax,(%esp)
    1176:	e8 85 06 00 00       	call   1800 <htons>
    117b:	0f b7 c0             	movzwl %ax,%eax
    117e:	01 45 fc             	add    %eax,0xfffffffc(%ebp)
    LWIP_DEBUGF(INET_DEBUG, ("inet: chksum: odd byte %d\n", (unsigned int)(*(u8_t *)dataptr)));
  } else {
    LWIP_DEBUGF(INET_DEBUG, ("inet: chksum: no odd byte\n"));
  }
  acc = (acc >> 16) + (acc & 0xffffUL);
    1181:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
    1184:	89 c2                	mov    %eax,%edx
    1186:	c1 ea 10             	shr    $0x10,%edx
    1189:	0f b7 45 fc          	movzwl 0xfffffffc(%ebp),%eax
    118d:	8d 04 02             	lea    (%edx,%eax,1),%eax
    1190:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)

  if ((acc & 0xffff0000) != 0) {
    1193:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
    1196:	66 b8 00 00          	mov    $0x0,%ax
    119a:	85 c0                	test   %eax,%eax
    119c:	74 12                	je     11b0 <lwip_chksum+0x80>
    acc = (acc >> 16) + (acc & 0xffffUL);
    119e:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
    11a1:	89 c2                	mov    %eax,%edx
    11a3:	c1 ea 10             	shr    $0x10,%edx
    11a6:	0f b7 45 fc          	movzwl 0xfffffffc(%ebp),%eax
    11aa:	8d 04 02             	lea    (%edx,%eax,1),%eax
    11ad:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
  }

  return (u16_t)acc;
    11b0:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
    11b3:	0f b7 c0             	movzwl %ax,%eax
}
    11b6:	c9                   	leave  
    11b7:	c3                   	ret    
    11b8:	90                   	nop    
    11b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi

000011c0 <inet_chksum_pseudo>:

/* inet_chksum_pseudo:
 *
 * Calculates the pseudo Internet checksum used by TCP and UDP for a pbuf chain.
 */

u16_t
inet_chksum_pseudo(struct pbuf *p,
       struct ip_addr *src, struct ip_addr *dest,
       u8_t proto, u16_t proto_len)
{
    11c0:	55                   	push   %ebp
    11c1:	89 e5                	mov    %esp,%ebp
    11c3:	83 ec 28             	sub    $0x28,%esp
    11c6:	8b 45 14             	mov    0x14(%ebp),%eax
    11c9:	8b 55 18             	mov    0x18(%ebp),%edx
    11cc:	88 45 ec             	mov    %al,0xffffffec(%ebp)
    11cf:	66 89 55 e8          	mov    %dx,0xffffffe8(%ebp)
  u32_t acc;
  struct pbuf *q;
  u8_t swapped;

  acc = 0;
    11d3:	c7 45 f4 00 00 00 00 	movl   $0x0,0xfffffff4(%ebp)
  swapped = 0;
    11da:	c6 45 ff 00          	movb   $0x0,0xffffffff(%ebp)
  /* iterate through all pbuf in chain */
  for(q = p; q != NULL; q = q->next) {
    11de:	8b 45 08             	mov    0x8(%ebp),%eax
    11e1:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
    11e4:	eb 7b                	jmp    1261 <inet_chksum_pseudo+0xa1>
    LWIP_DEBUGF(INET_DEBUG, ("inet_chksum_pseudo(): checksumming pbuf %p (has next %p) \n",
      (void *)q, (void *)q->next));
    acc += lwip_chksum(q->payload, q->len);
    11e6:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
    11e9:	0f b7 40 0a          	movzwl 0xa(%eax),%eax
    11ed:	0f b7 d0             	movzwl %ax,%edx
    11f0:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
    11f3:	8b 40 04             	mov    0x4(%eax),%eax
    11f6:	89 54 24 04          	mov    %edx,0x4(%esp)
    11fa:	89 04 24             	mov    %eax,(%esp)
    11fd:	e8 2e ff ff ff       	call   1130 <lwip_chksum>
    1202:	0f b7 c0             	movzwl %ax,%eax
    1205:	01 45 f4             	add    %eax,0xfffffff4(%ebp)
    /*LWIP_DEBUGF(INET_DEBUG, ("inet_chksum_pseudo(): unwrapped lwip_chksum()=%lx \n", acc));*/
    while (acc >> 16) {
    1208:	eb 10                	jmp    121a <inet_chksum_pseudo+0x5a>
      acc = (acc & 0xffffUL) + (acc >> 16);
    120a:	0f b7 55 f4          	movzwl 0xfffffff4(%ebp),%edx
    120e:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
    1211:	c1 e8 10             	shr    $0x10,%eax
    1214:	8d 04 02             	lea    (%edx,%eax,1),%eax
    1217:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
    121a:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
    121d:	c1 e8 10             	shr    $0x10,%eax
    1220:	85 c0                	test   %eax,%eax
    1222:	75 e6                	jne    120a <inet_chksum_pseudo+0x4a>
    }
    if (q->len % 2 != 0) {
    1224:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
    1227:	0f b7 40 0a          	movzwl 0xa(%eax),%eax
    122b:	0f b7 c0             	movzwl %ax,%eax
    122e:	83 e0 01             	and    $0x1,%eax
    1231:	84 c0                	test   %al,%al
    1233:	74 24                	je     1259 <inet_chksum_pseudo+0x99>
      swapped = 1 - swapped;
    1235:	b8 01 00 00 00       	mov    $0x1,%eax
    123a:	2a 45 ff             	sub    0xffffffff(%ebp),%al
    123d:	88 45 ff             	mov    %al,0xffffffff(%ebp)
      acc = ((acc & 0xff) << 8) | ((acc & 0xff00UL) >> 8);
    1240:	0f b6 45 f4          	movzbl 0xfffffff4(%ebp),%eax
    1244:	89 c2                	mov    %eax,%edx
    1246:	c1 e2 08             	shl    $0x8,%edx
    1249:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
    124c:	25 00 ff 00 00       	and    $0xff00,%eax
    1251:	c1 e8 08             	shr    $0x8,%eax
    1254:	09 d0                	or     %edx,%eax
    1256:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
    1259:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
    125c:	8b 00                	mov    (%eax),%eax
    125e:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
    1261:	83 7d f8 00          	cmpl   $0x0,0xfffffff8(%ebp)
    1265:	0f 85 7b ff ff ff    	jne    11e6 <inet_chksum_pseudo+0x26>
    }
    /*LWIP_DEBUGF(INET_DEBUG, ("inet_chksum_pseudo(): wrapped lwip_chksum()=%lx \n", acc));*/
  }

  if (swapped) {
    126b:	80 7d ff 00          	cmpb   $0x0,0xffffffff(%ebp)
    126f:	74 19                	je     128a <inet_chksum_pseudo+0xca>
    acc = ((acc & 0xff) << 8) | ((acc & 0xff00UL) >> 8);
    1271:	0f b6 45 f4          	movzbl 0xfffffff4(%ebp),%eax
    1275:	89 c2                	mov    %eax,%edx
    1277:	c1 e2 08             	shl    $0x8,%edx
    127a:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
    127d:	25 00 ff 00 00       	and    $0xff00,%eax
    1282:	c1 e8 08             	shr    $0x8,%eax
    1285:	09 d0                	or     %edx,%eax
    1287:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
  }
  acc += (src->addr & 0xffffUL);
    128a:	8b 45 0c             	mov    0xc(%ebp),%eax
    128d:	8b 00                	mov    (%eax),%eax
    128f:	25 ff ff 00 00       	and    $0xffff,%eax
    1294:	01 45 f4             	add    %eax,0xfffffff4(%ebp)
  acc += ((src->addr >> 16) & 0xffffUL);
    1297:	8b 45 0c             	mov    0xc(%ebp),%eax
    129a:	8b 00                	mov    (%eax),%eax
    129c:	c1 e8 10             	shr    $0x10,%eax
    129f:	25 ff ff 00 00       	and    $0xffff,%eax
    12a4:	01 45 f4             	add    %eax,0xfffffff4(%ebp)
  acc += (dest->addr & 0xffffUL);
    12a7:	8b 45 10             	mov    0x10(%ebp),%eax
    12aa:	8b 00                	mov    (%eax),%eax
    12ac:	25 ff ff 00 00       	and    $0xffff,%eax
    12b1:	01 45 f4             	add    %eax,0xfffffff4(%ebp)
  acc += ((dest->addr >> 16) & 0xffffUL);
    12b4:	8b 45 10             	mov    0x10(%ebp),%eax
    12b7:	8b 00                	mov    (%eax),%eax
    12b9:	c1 e8 10             	shr    $0x10,%eax
    12bc:	25 ff ff 00 00       	and    $0xffff,%eax
    12c1:	01 45 f4             	add    %eax,0xfffffff4(%ebp)
  acc += (u32_t)htons((u16_t)proto);
    12c4:	0f b6 45 ec          	movzbl 0xffffffec(%ebp),%eax
    12c8:	89 04 24             	mov    %eax,(%esp)
    12cb:	e8 30 05 00 00       	call   1800 <htons>
    12d0:	0f b7 c0             	movzwl %ax,%eax
    12d3:	01 45 f4             	add    %eax,0xfffffff4(%ebp)
  acc += (u32_t)htons(proto_len);
    12d6:	0f b7 45 e8          	movzwl 0xffffffe8(%ebp),%eax
    12da:	89 04 24             	mov    %eax,(%esp)
    12dd:	e8 1e 05 00 00       	call   1800 <htons>
    12e2:	0f b7 c0             	movzwl %ax,%eax
    12e5:	01 45 f4             	add    %eax,0xfffffff4(%ebp)

  while (acc >> 16) {
    12e8:	eb 10                	jmp    12fa <inet_chksum_pseudo+0x13a>
    acc = (acc & 0xffffUL) + (acc >> 16);
    12ea:	0f b7 55 f4          	movzwl 0xfffffff4(%ebp),%edx
    12ee:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
    12f1:	c1 e8 10             	shr    $0x10,%eax
    12f4:	8d 04 02             	lea    (%edx,%eax,1),%eax
    12f7:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
    12fa:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
    12fd:	c1 e8 10             	shr    $0x10,%eax
    1300:	85 c0                	test   %eax,%eax
    1302:	75 e6                	jne    12ea <inet_chksum_pseudo+0x12a>
  }
  LWIP_DEBUGF(INET_DEBUG, ("inet_chksum_pseudo(): pbuf chain lwip_chksum()=%lx\n", acc));
  return ~(acc & 0xffffUL);
    1304:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
    1307:	f7 d0                	not    %eax
    1309:	0f b7 c0             	movzwl %ax,%eax
}
    130c:	c9                   	leave  
    130d:	c3                   	ret    
    130e:	89 f6                	mov    %esi,%esi

00001310 <inet_chksum>:

/* inet_chksum:
 *
 * Calculates the Internet checksum over a portion of memory. Used primarely for IP
 * and ICMP.
 */

u16_t
inet_chksum(void *dataptr, u16_t len)
{
    1310:	55                   	push   %ebp
    1311:	89 e5                	mov    %esp,%ebp
    1313:	83 ec 28             	sub    $0x28,%esp
    1316:	8b 45 0c             	mov    0xc(%ebp),%eax
    1319:	66 89 45 ec          	mov    %ax,0xffffffec(%ebp)
  u32_t acc;

  acc = lwip_chksum(dataptr, len);
    131d:	0f b7 45 ec          	movzwl 0xffffffec(%ebp),%eax
    1321:	89 44 24 04          	mov    %eax,0x4(%esp)
    1325:	8b 45 08             	mov    0x8(%ebp),%eax
    1328:	89 04 24             	mov    %eax,(%esp)
    132b:	e8 00 fe ff ff       	call   1130 <lwip_chksum>
    1330:	0f b7 c0             	movzwl %ax,%eax
    1333:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
  while (acc >> 16) {
    1336:	eb 10                	jmp    1348 <inet_chksum+0x38>
    acc = (acc & 0xffff) + (acc >> 16);
    1338:	0f b7 55 fc          	movzwl 0xfffffffc(%ebp),%edx
    133c:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
    133f:	c1 e8 10             	shr    $0x10,%eax
    1342:	8d 04 02             	lea    (%edx,%eax,1),%eax
    1345:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
    1348:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
    134b:	c1 e8 10             	shr    $0x10,%eax
    134e:	85 c0                	test   %eax,%eax
    1350:	75 e6                	jne    1338 <inet_chksum+0x28>
  }
  return ~(acc & 0xffff);
    1352:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
    1355:	f7 d0                	not    %eax
    1357:	0f b7 c0             	movzwl %ax,%eax
}
    135a:	c9                   	leave  
    135b:	c3                   	ret    
    135c:	8d 74 26 00          	lea    0x0(%esi),%esi

00001360 <inet_chksum_pbuf>:

u16_t
inet_chksum_pbuf(struct pbuf *p)
{
    1360:	55                   	push   %ebp
    1361:	89 e5                	mov    %esp,%ebp
    1363:	83 ec 18             	sub    $0x18,%esp
  u32_t acc;
  struct pbuf *q;
  u8_t swapped;

  acc = 0;
    1366:	c7 45 f4 00 00 00 00 	movl   $0x0,0xfffffff4(%ebp)
  swapped = 0;
    136d:	c6 45 ff 00          	movb   $0x0,0xffffffff(%ebp)
  for(q = p; q != NULL; q = q->next) {
    1371:	8b 45 08             	mov    0x8(%ebp),%eax
    1374:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
    1377:	eb 69                	jmp    13e2 <inet_chksum_pbuf+0x82>
    acc += lwip_chksum(q->payload, q->len);
    1379:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
    137c:	0f b7 40 0a          	movzwl 0xa(%eax),%eax
    1380:	0f b7 d0             	movzwl %ax,%edx
    1383:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
    1386:	8b 40 04             	mov    0x4(%eax),%eax
    1389:	89 54 24 04          	mov    %edx,0x4(%esp)
    138d:	89 04 24             	mov    %eax,(%esp)
    1390:	e8 9b fd ff ff       	call   1130 <lwip_chksum>
    1395:	0f b7 c0             	movzwl %ax,%eax
    1398:	01 45 f4             	add    %eax,0xfffffff4(%ebp)
    while (acc >> 16) {
    139b:	eb 10                	jmp    13ad <inet_chksum_pbuf+0x4d>
      acc = (acc & 0xffffUL) + (acc >> 16);
    139d:	0f b7 55 f4          	movzwl 0xfffffff4(%ebp),%edx
    13a1:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
    13a4:	c1 e8 10             	shr    $0x10,%eax
    13a7:	8d 04 02             	lea    (%edx,%eax,1),%eax
    13aa:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
    13ad:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
    13b0:	c1 e8 10             	shr    $0x10,%eax
    13b3:	85 c0                	test   %eax,%eax
    13b5:	75 e6                	jne    139d <inet_chksum_pbuf+0x3d>
    }
    if (q->len % 2 != 0) {
    13b7:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
    13ba:	0f b7 40 0a          	movzwl 0xa(%eax),%eax
    13be:	0f b7 c0             	movzwl %ax,%eax
    13c1:	83 e0 01             	and    $0x1,%eax
    13c4:	84 c0                	test   %al,%al
    13c6:	74 12                	je     13da <inet_chksum_pbuf+0x7a>
      swapped = 1 - swapped;
    13c8:	b8 01 00 00 00       	mov    $0x1,%eax
    13cd:	2a 45 ff             	sub    0xffffffff(%ebp),%al
    13d0:	88 45 ff             	mov    %al,0xffffffff(%ebp)
      acc = (acc & 0x00ffUL << 8) | (acc & 0xff00UL >> 8);
    13d3:	81 65 f4 ff ff 00 00 	andl   $0xffff,0xfffffff4(%ebp)
    13da:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
    13dd:	8b 00                	mov    (%eax),%eax
    13df:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
    13e2:	83 7d f8 00          	cmpl   $0x0,0xfffffff8(%ebp)
    13e6:	75 91                	jne    1379 <inet_chksum_pbuf+0x19>
    }
  }

  if (swapped) {
    13e8:	80 7d ff 00          	cmpb   $0x0,0xffffffff(%ebp)
    13ec:	74 19                	je     1407 <inet_chksum_pbuf+0xa7>
    acc = ((acc & 0x00ffUL) << 8) | ((acc & 0xff00UL) >> 8);
    13ee:	0f b6 45 f4          	movzbl 0xfffffff4(%ebp),%eax
    13f2:	89 c2                	mov    %eax,%edx
    13f4:	c1 e2 08             	shl    $0x8,%edx
    13f7:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
    13fa:	25 00 ff 00 00       	and    $0xff00,%eax
    13ff:	c1 e8 08             	shr    $0x8,%eax
    1402:	09 d0                	or     %edx,%eax
    1404:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
  }
  return ~(acc & 0xffffUL);
    1407:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
    140a:	f7 d0                	not    %eax
    140c:	0f b7 c0             	movzwl %ax,%eax
}
    140f:	c9                   	leave  
    1410:	c3                   	ret    
    1411:	eb 0d                	jmp    1420 <inet_addr>
    1413:	90                   	nop    
    1414:	90                   	nop    
    1415:	90                   	nop    
    1416:	90                   	nop    
    1417:	90                   	nop    
    1418:	90                   	nop    
    1419:	90                   	nop    
    141a:	90                   	nop    
    141b:	90                   	nop    
    141c:	90                   	nop    
    141d:	90                   	nop    
    141e:	90                   	nop    
    141f:	90                   	nop    

00001420 <inet_addr>:

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
    1420:	55                   	push   %ebp
    1421:	89 e5                	mov    %esp,%ebp
    1423:	83 ec 28             	sub    $0x28,%esp
     struct in_addr val;

     if (inet_aton(cp, &val)) {
    1426:	8d 45 fc             	lea    0xfffffffc(%ebp),%eax
    1429:	89 44 24 04          	mov    %eax,0x4(%esp)
    142d:	8b 45 08             	mov    0x8(%ebp),%eax
    1430:	89 04 24             	mov    %eax,(%esp)
    1433:	e8 18 00 00 00       	call   1450 <inet_aton>
    1438:	85 c0                	test   %eax,%eax
    143a:	74 08                	je     1444 <inet_addr+0x24>
         return (val.s_addr);
    143c:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
    143f:	89 45 ec             	mov    %eax,0xffffffec(%ebp)
    1442:	eb 07                	jmp    144b <inet_addr+0x2b>
     }
     return (INADDR_NONE);
    1444:	c7 45 ec ff ff ff ff 	movl   $0xffffffff,0xffffffec(%ebp)
    144b:	8b 45 ec             	mov    0xffffffec(%ebp),%eax
 }
    144e:	c9                   	leave  
    144f:	c3                   	ret    

00001450 <inet_aton>:

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
    1450:	55                   	push   %ebp
    1451:	89 e5                	mov    %esp,%ebp
    1453:	83 ec 48             	sub    $0x48,%esp
     u32_t val;
     int base, n;
     char c;
     u32_t parts[4];
     u32_t* pp = parts;
    1456:	8d 45 dc             	lea    0xffffffdc(%ebp),%eax
    1459:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)

     c = *cp;
    145c:	8b 45 08             	mov    0x8(%ebp),%eax
    145f:	0f b6 00             	movzbl (%eax),%eax
    1462:	88 45 fb             	mov    %al,0xfffffffb(%ebp)
     for (;;) {
         /*
          * Collect number up to ``.''.
          * Values are specified as for C:
          * 0x=hex, 0=octal, isdigit=decimal.
          */
         if (!isdigit(c))
    1465:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
    1469:	3c 2f                	cmp    $0x2f,%al
    146b:	76 08                	jbe    1475 <inet_aton+0x25>
    146d:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
    1471:	3c 39                	cmp    $0x39,%al
    1473:	76 0c                	jbe    1481 <inet_aton+0x31>
             return (0);
    1475:	c7 45 c0 00 00 00 00 	movl   $0x0,0xffffffc0(%ebp)
    147c:	e9 78 02 00 00       	jmp    16f9 <inet_aton+0x2a9>
         val = 0; base = 10;
    1481:	c7 45 ec 00 00 00 00 	movl   $0x0,0xffffffec(%ebp)
    1488:	c7 45 f0 0a 00 00 00 	movl   $0xa,0xfffffff0(%ebp)
         if (c == '0') {
    148f:	80 7d fb 30          	cmpb   $0x30,0xfffffffb(%ebp)
    1493:	75 36                	jne    14cb <inet_aton+0x7b>
             c = *++cp;
    1495:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    1499:	8b 45 08             	mov    0x8(%ebp),%eax
    149c:	0f b6 00             	movzbl (%eax),%eax
    149f:	88 45 fb             	mov    %al,0xfffffffb(%ebp)
             if (c == 'x' || c == 'X')
    14a2:	80 7d fb 78          	cmpb   $0x78,0xfffffffb(%ebp)
    14a6:	74 06                	je     14ae <inet_aton+0x5e>
    14a8:	80 7d fb 58          	cmpb   $0x58,0xfffffffb(%ebp)
    14ac:	75 16                	jne    14c4 <inet_aton+0x74>
                 base = 16, c = *++cp;
    14ae:	c7 45 f0 10 00 00 00 	movl   $0x10,0xfffffff0(%ebp)
    14b5:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    14b9:	8b 45 08             	mov    0x8(%ebp),%eax
    14bc:	0f b6 00             	movzbl (%eax),%eax
    14bf:	88 45 fb             	mov    %al,0xfffffffb(%ebp)
    14c2:	eb 07                	jmp    14cb <inet_aton+0x7b>
             else
                 base = 8;
    14c4:	c7 45 f0 08 00 00 00 	movl   $0x8,0xfffffff0(%ebp)
         }
         for (;;) {
             if (isascii(c) && isdigit(c)) {
    14cb:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
    14cf:	3c 1f                	cmp    $0x1f,%al
    14d1:	76 3b                	jbe    150e <inet_aton+0xbe>
    14d3:	80 7d fb 00          	cmpb   $0x0,0xfffffffb(%ebp)
    14d7:	78 35                	js     150e <inet_aton+0xbe>
    14d9:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
    14dd:	3c 2f                	cmp    $0x2f,%al
    14df:	76 2d                	jbe    150e <inet_aton+0xbe>
    14e1:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
    14e5:	3c 39                	cmp    $0x39,%al
    14e7:	77 25                	ja     150e <inet_aton+0xbe>
                 val = (val * base) + (c - '0');
    14e9:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
    14ec:	89 c2                	mov    %eax,%edx
    14ee:	0f af 55 ec          	imul   0xffffffec(%ebp),%edx
    14f2:	0f be 45 fb          	movsbl 0xfffffffb(%ebp),%eax
    14f6:	8d 04 02             	lea    (%edx,%eax,1),%eax
    14f9:	83 e8 30             	sub    $0x30,%eax
    14fc:	89 45 ec             	mov    %eax,0xffffffec(%ebp)
                 c = *++cp;
    14ff:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    1503:	8b 45 08             	mov    0x8(%ebp),%eax
    1506:	0f b6 00             	movzbl (%eax),%eax
    1509:	88 45 fb             	mov    %al,0xfffffffb(%ebp)
    150c:	eb bd                	jmp    14cb <inet_aton+0x7b>
             } else if (base == 16 && isascii(c) && isxdigit(c)) {
    150e:	83 7d f0 10          	cmpl   $0x10,0xfffffff0(%ebp)
    1512:	0f 85 99 00 00 00    	jne    15b1 <inet_aton+0x161>
    1518:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
    151c:	3c 1f                	cmp    $0x1f,%al
    151e:	0f 86 8d 00 00 00    	jbe    15b1 <inet_aton+0x161>
    1524:	80 7d fb 00          	cmpb   $0x0,0xfffffffb(%ebp)
    1528:	0f 88 83 00 00 00    	js     15b1 <inet_aton+0x161>
    152e:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
    1532:	3c 2f                	cmp    $0x2f,%al
    1534:	76 08                	jbe    153e <inet_aton+0xee>
    1536:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
    153a:	3c 39                	cmp    $0x39,%al
    153c:	76 20                	jbe    155e <inet_aton+0x10e>
    153e:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
    1542:	3c 60                	cmp    $0x60,%al
    1544:	76 08                	jbe    154e <inet_aton+0xfe>
    1546:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
    154a:	3c 66                	cmp    $0x66,%al
    154c:	76 10                	jbe    155e <inet_aton+0x10e>
    154e:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
    1552:	3c 40                	cmp    $0x40,%al
    1554:	76 5b                	jbe    15b1 <inet_aton+0x161>
    1556:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
    155a:	3c 46                	cmp    $0x46,%al
    155c:	77 53                	ja     15b1 <inet_aton+0x161>
                 val = (val << 4) |
    155e:	8b 45 ec             	mov    0xffffffec(%ebp),%eax
    1561:	89 c2                	mov    %eax,%edx
    1563:	c1 e2 04             	shl    $0x4,%edx
    1566:	89 55 c4             	mov    %edx,0xffffffc4(%ebp)
    1569:	0f be 45 fb          	movsbl 0xfffffffb(%ebp),%eax
    156d:	83 c0 0a             	add    $0xa,%eax
    1570:	89 45 c8             	mov    %eax,0xffffffc8(%ebp)
    1573:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
    1577:	3c 60                	cmp    $0x60,%al
    1579:	76 11                	jbe    158c <inet_aton+0x13c>
    157b:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
    157f:	3c 7a                	cmp    $0x7a,%al
    1581:	77 09                	ja     158c <inet_aton+0x13c>
    1583:	c7 45 cc 61 00 00 00 	movl   $0x61,0xffffffcc(%ebp)
    158a:	eb 07                	jmp    1593 <inet_aton+0x143>
    158c:	c7 45 cc 41 00 00 00 	movl   $0x41,0xffffffcc(%ebp)
    1593:	8b 45 c8             	mov    0xffffffc8(%ebp),%eax
    1596:	2b 45 cc             	sub    0xffffffcc(%ebp),%eax
    1599:	0b 45 c4             	or     0xffffffc4(%ebp),%eax
    159c:	89 45 ec             	mov    %eax,0xffffffec(%ebp)
                     (c + 10 - (islower(c) ? 'a' : 'A'));
                 c = *++cp;
    159f:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    15a3:	8b 45 08             	mov    0x8(%ebp),%eax
    15a6:	0f b6 00             	movzbl (%eax),%eax
    15a9:	88 45 fb             	mov    %al,0xfffffffb(%ebp)
             } else
             break;
         }
    15ac:	e9 1a ff ff ff       	jmp    14cb <inet_aton+0x7b>
         if (c == '.') {
    15b1:	80 7d fb 2e          	cmpb   $0x2e,0xfffffffb(%ebp)
    15b5:	75 35                	jne    15ec <inet_aton+0x19c>
             /*
              * Internet format:
              *  a.b.c.d
              *  a.b.c   (with c treated as 16 bits)
              *  a.b (with b treated as 24 bits)
              */
             if (pp >= parts + 3)
    15b7:	8d 45 dc             	lea    0xffffffdc(%ebp),%eax
    15ba:	83 c0 0c             	add    $0xc,%eax
    15bd:	3b 45 fc             	cmp    0xfffffffc(%ebp),%eax
    15c0:	77 0c                	ja     15ce <inet_aton+0x17e>
                 return (0);
    15c2:	c7 45 c0 00 00 00 00 	movl   $0x0,0xffffffc0(%ebp)
    15c9:	e9 2b 01 00 00       	jmp    16f9 <inet_aton+0x2a9>
             *pp++ = val;
    15ce:	8b 55 fc             	mov    0xfffffffc(%ebp),%edx
    15d1:	8b 45 ec             	mov    0xffffffec(%ebp),%eax
    15d4:	89 02                	mov    %eax,(%edx)
    15d6:	83 45 fc 04          	addl   $0x4,0xfffffffc(%ebp)
             c = *++cp;
    15da:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    15de:	8b 45 08             	mov    0x8(%ebp),%eax
    15e1:	0f b6 00             	movzbl (%eax),%eax
    15e4:	88 45 fb             	mov    %al,0xfffffffb(%ebp)
         } else
             break;
     }
    15e7:	e9 79 fe ff ff       	jmp    1465 <inet_aton+0x15>
     /*
      * Check for trailing characters.
      */
     if (c != '\0' && (!isascii(c) || !isspace(c)))
    15ec:	80 7d fb 00          	cmpb   $0x0,0xfffffffb(%ebp)
    15f0:	74 3e                	je     1630 <inet_aton+0x1e0>
    15f2:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
    15f6:	3c 1f                	cmp    $0x1f,%al
    15f8:	76 2a                	jbe    1624 <inet_aton+0x1d4>
    15fa:	80 7d fb 00          	cmpb   $0x0,0xfffffffb(%ebp)
    15fe:	78 24                	js     1624 <inet_aton+0x1d4>
    1600:	80 7d fb 20          	cmpb   $0x20,0xfffffffb(%ebp)
    1604:	74 2a                	je     1630 <inet_aton+0x1e0>
    1606:	80 7d fb 0c          	cmpb   $0xc,0xfffffffb(%ebp)
    160a:	74 24                	je     1630 <inet_aton+0x1e0>
    160c:	80 7d fb 0a          	cmpb   $0xa,0xfffffffb(%ebp)
    1610:	74 1e                	je     1630 <inet_aton+0x1e0>
    1612:	80 7d fb 0d          	cmpb   $0xd,0xfffffffb(%ebp)
    1616:	74 18                	je     1630 <inet_aton+0x1e0>
    1618:	80 7d fb 09          	cmpb   $0x9,0xfffffffb(%ebp)
    161c:	74 12                	je     1630 <inet_aton+0x1e0>
    161e:	80 7d fb 0b          	cmpb   $0xb,0xfffffffb(%ebp)
    1622:	74 0c                	je     1630 <inet_aton+0x1e0>
         return (0);
    1624:	c7 45 c0 00 00 00 00 	movl   $0x0,0xffffffc0(%ebp)
    162b:	e9 c9 00 00 00       	jmp    16f9 <inet_aton+0x2a9>
     /*
      * Concoct the address according to
      * the number of parts specified.
      */
     n = pp - parts + 1;
    1630:	8b 55 fc             	mov    0xfffffffc(%ebp),%edx
    1633:	8d 45 dc             	lea    0xffffffdc(%ebp),%eax
    1636:	89 d1                	mov    %edx,%ecx
    1638:	29 c1                	sub    %eax,%ecx
    163a:	89 c8                	mov    %ecx,%eax
    163c:	c1 f8 02             	sar    $0x2,%eax
    163f:	83 c0 01             	add    $0x1,%eax
    1642:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
     switch (n) {
    1645:	83 7d f4 04          	cmpl   $0x4,0xfffffff4(%ebp)
    1649:	0f 87 8b 00 00 00    	ja     16da <inet_aton+0x28a>
    164f:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
    1652:	c1 e0 02             	shl    $0x2,%eax
    1655:	8b 80 80 19 00 00    	mov    0x1980(%eax),%eax
    165b:	ff e0                	jmp    *%eax

     case 0:
         return (0);     /* initial nondigit */
    165d:	c7 45 c0 00 00 00 00 	movl   $0x0,0xffffffc0(%ebp)
    1664:	e9 90 00 00 00       	jmp    16f9 <inet_aton+0x2a9>

     case 1:             /* a -- 32 bits */
         break;

     case 2:             /* a.b -- 8.24 bits */
         if (val > 0xffffff)
    1669:	81 7d ec ff ff ff 00 	cmpl   $0xffffff,0xffffffec(%ebp)
    1670:	76 09                	jbe    167b <inet_aton+0x22b>
             return (0);
    1672:	c7 45 c0 00 00 00 00 	movl   $0x0,0xffffffc0(%ebp)
    1679:	eb 7e                	jmp    16f9 <inet_aton+0x2a9>
         val |= parts[0] << 24;
    167b:	8b 45 dc             	mov    0xffffffdc(%ebp),%eax
    167e:	c1 e0 18             	shl    $0x18,%eax
    1681:	09 45 ec             	or     %eax,0xffffffec(%ebp)
         break;
    1684:	eb 54                	jmp    16da <inet_aton+0x28a>

     case 3:             /* a.b.c -- 8.8.16 bits */
         if (val > 0xffff)
    1686:	81 7d ec ff ff 00 00 	cmpl   $0xffff,0xffffffec(%ebp)
    168d:	76 09                	jbe    1698 <inet_aton+0x248>
             return (0);
    168f:	c7 45 c0 00 00 00 00 	movl   $0x0,0xffffffc0(%ebp)
    1696:	eb 61                	jmp    16f9 <inet_aton+0x2a9>
         val |= (parts[0] << 24) | (parts[1] << 16);
    1698:	8b 45 dc             	mov    0xffffffdc(%ebp),%eax
    169b:	89 c2                	mov    %eax,%edx
    169d:	c1 e2 18             	shl    $0x18,%edx
    16a0:	8b 45 e0             	mov    0xffffffe0(%ebp),%eax
    16a3:	c1 e0 10             	shl    $0x10,%eax
    16a6:	09 d0                	or     %edx,%eax
    16a8:	09 45 ec             	or     %eax,0xffffffec(%ebp)
         break;
    16ab:	eb 2d                	jmp    16da <inet_aton+0x28a>

     case 4:             /* a.b.c.d -- 8.8.8.8 bits */
         if (val > 0xff)
    16ad:	81 7d ec ff 00 00 00 	cmpl   $0xff,0xffffffec(%ebp)
    16b4:	76 09                	jbe    16bf <inet_aton+0x26f>
             return (0);
    16b6:	c7 45 c0 00 00 00 00 	movl   $0x0,0xffffffc0(%ebp)
    16bd:	eb 3a                	jmp    16f9 <inet_aton+0x2a9>
         val |= (parts[0] << 24) | (parts[1] << 16) | (parts[2] << 8);
    16bf:	8b 45 dc             	mov    0xffffffdc(%ebp),%eax
    16c2:	89 c2                	mov    %eax,%edx
    16c4:	c1 e2 18             	shl    $0x18,%edx
    16c7:	8b 45 e0             	mov    0xffffffe0(%ebp),%eax
    16ca:	c1 e0 10             	shl    $0x10,%eax
    16cd:	09 c2                	or     %eax,%edx
    16cf:	8b 45 e4             	mov    0xffffffe4(%ebp),%eax
    16d2:	c1 e0 08             	shl    $0x8,%eax
    16d5:	09 d0                	or     %edx,%eax
    16d7:	09 45 ec             	or     %eax,0xffffffec(%ebp)
         break;
     }
     if (addr)
    16da:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    16de:	74 12                	je     16f2 <inet_aton+0x2a2>
         addr->s_addr = htonl(val);
    16e0:	8b 45 ec             	mov    0xffffffec(%ebp),%eax
    16e3:	89 04 24             	mov    %eax,(%esp)
    16e6:	e8 65 01 00 00       	call   1850 <htonl>
    16eb:	89 c2                	mov    %eax,%edx
    16ed:	8b 45 0c             	mov    0xc(%ebp),%eax
    16f0:	89 10                	mov    %edx,(%eax)
     return (1);
    16f2:	c7 45 c0 01 00 00 00 	movl   $0x1,0xffffffc0(%ebp)
    16f9:	8b 45 c0             	mov    0xffffffc0(%ebp),%eax
 }
    16fc:	c9                   	leave  
    16fd:	c3                   	ret    
    16fe:	89 f6                	mov    %esi,%esi

00001700 <inet_ntoa>:

/* Convert numeric IP address into decimal dotted ASCII representation.
 * returns ptr to static buffer; not reentrant!
 */
char *inet_ntoa(struct in_addr addr)
{
    1700:	55                   	push   %ebp
    1701:	89 e5                	mov    %esp,%ebp
    1703:	53                   	push   %ebx
    1704:	83 ec 24             	sub    $0x24,%esp
  static char str[16];
  u32_t s_addr = addr.s_addr;
    1707:	8b 45 08             	mov    0x8(%ebp),%eax
    170a:	89 45 ec             	mov    %eax,0xffffffec(%ebp)
  char inv[3];
  char *rp;
  char *ap;
  u8_t rem;
  u8_t n;
  u8_t i;

  rp = str;
    170d:	c7 45 f0 c0 19 00 00 	movl   $0x19c0,0xfffffff0(%ebp)
  ap = (u8_t *)&s_addr;
    1714:	8d 45 ec             	lea    0xffffffec(%ebp),%eax
    1717:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
  for(n = 0; n < 4; n++) {
    171a:	c6 45 fa 00          	movb   $0x0,0xfffffffa(%ebp)
    171e:	e9 af 00 00 00       	jmp    17d2 <inet_ntoa+0xd2>
    i = 0;
    1723:	c6 45 fb 00          	movb   $0x0,0xfffffffb(%ebp)
    do {
      rem = *ap % (u8_t)10;
    1727:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
    172a:	0f b6 08             	movzbl (%eax),%ecx
    172d:	b8 67 00 00 00       	mov    $0x67,%eax
    1732:	f6 e9                	imul   %cl
    1734:	66 c1 e8 08          	shr    $0x8,%ax
    1738:	89 c2                	mov    %eax,%edx
    173a:	c0 fa 02             	sar    $0x2,%dl
    173d:	89 c8                	mov    %ecx,%eax
    173f:	c0 f8 07             	sar    $0x7,%al
    1742:	89 d3                	mov    %edx,%ebx
    1744:	28 c3                	sub    %al,%bl
    1746:	88 5d db             	mov    %bl,0xffffffdb(%ebp)
    1749:	0f b6 45 db          	movzbl 0xffffffdb(%ebp),%eax
    174d:	c1 e0 02             	shl    $0x2,%eax
    1750:	02 45 db             	add    0xffffffdb(%ebp),%al
    1753:	01 c0                	add    %eax,%eax
    1755:	89 ca                	mov    %ecx,%edx
    1757:	28 c2                	sub    %al,%dl
    1759:	88 55 db             	mov    %dl,0xffffffdb(%ebp)
    175c:	0f b6 5d db          	movzbl 0xffffffdb(%ebp),%ebx
    1760:	88 5d f9             	mov    %bl,0xfffffff9(%ebp)
      *ap /= (u8_t)10;
    1763:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
    1766:	0f b6 08             	movzbl (%eax),%ecx
    1769:	b8 67 00 00 00       	mov    $0x67,%eax
    176e:	f6 e9                	imul   %cl
    1770:	66 c1 e8 08          	shr    $0x8,%ax
    1774:	89 c2                	mov    %eax,%edx
    1776:	c0 fa 02             	sar    $0x2,%dl
    1779:	89 c8                	mov    %ecx,%eax
    177b:	c0 f8 07             	sar    $0x7,%al
    177e:	28 c2                	sub    %al,%dl
    1780:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
    1783:	88 10                	mov    %dl,(%eax)
      inv[i++] = '0' + rem;
    1785:	0f b6 55 fb          	movzbl 0xfffffffb(%ebp),%edx
    1789:	0f b6 45 f9          	movzbl 0xfffffff9(%ebp),%eax
    178d:	83 c0 30             	add    $0x30,%eax
    1790:	88 44 15 e9          	mov    %al,0xffffffe9(%ebp,%edx,1)
    1794:	80 45 fb 01          	addb   $0x1,0xfffffffb(%ebp)
    } while(*ap);
    1798:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
    179b:	0f b6 00             	movzbl (%eax),%eax
    179e:	84 c0                	test   %al,%al
    17a0:	75 85                	jne    1727 <inet_ntoa+0x27>
    while(i--)
    17a2:	eb 12                	jmp    17b6 <inet_ntoa+0xb6>
      *rp++ = inv[i];
    17a4:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
    17a8:	0f b6 54 05 e9       	movzbl 0xffffffe9(%ebp,%eax,1),%edx
    17ad:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
    17b0:	88 10                	mov    %dl,(%eax)
    17b2:	83 45 f0 01          	addl   $0x1,0xfffffff0(%ebp)
    17b6:	80 6d fb 01          	subb   $0x1,0xfffffffb(%ebp)
    17ba:	80 7d fb ff          	cmpb   $0xff,0xfffffffb(%ebp)
    17be:	75 e4                	jne    17a4 <inet_ntoa+0xa4>
    *rp++ = '.';
    17c0:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
    17c3:	c6 00 2e             	movb   $0x2e,(%eax)
    17c6:	83 45 f0 01          	addl   $0x1,0xfffffff0(%ebp)
    ap++;
    17ca:	83 45 f4 01          	addl   $0x1,0xfffffff4(%ebp)
    17ce:	80 45 fa 01          	addb   $0x1,0xfffffffa(%ebp)
    17d2:	80 7d fa 03          	cmpb   $0x3,0xfffffffa(%ebp)
    17d6:	0f 86 47 ff ff ff    	jbe    1723 <inet_ntoa+0x23>
  }
  *--rp = 0;
    17dc:	83 6d f0 01          	subl   $0x1,0xfffffff0(%ebp)
    17e0:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
    17e3:	c6 00 00             	movb   $0x0,(%eax)
  return str;
    17e6:	b8 c0 19 00 00       	mov    $0x19c0,%eax
}
    17eb:	83 c4 24             	add    $0x24,%esp
    17ee:	5b                   	pop    %ebx
    17ef:	5d                   	pop    %ebp
    17f0:	c3                   	ret    
    17f1:	eb 0d                	jmp    1800 <htons>
    17f3:	90                   	nop    
    17f4:	90                   	nop    
    17f5:	90                   	nop    
    17f6:	90                   	nop    
    17f7:	90                   	nop    
    17f8:	90                   	nop    
    17f9:	90                   	nop    
    17fa:	90                   	nop    
    17fb:	90                   	nop    
    17fc:	90                   	nop    
    17fd:	90                   	nop    
    17fe:	90                   	nop    
    17ff:	90                   	nop    

00001800 <htons>:


#ifndef BYTE_ORDER
#error BYTE_ORDER is not defined
#endif
#if BYTE_ORDER == LITTLE_ENDIAN

u16_t
htons(u16_t n)
{
    1800:	55                   	push   %ebp
    1801:	89 e5                	mov    %esp,%ebp
    1803:	83 ec 04             	sub    $0x4,%esp
    1806:	8b 45 08             	mov    0x8(%ebp),%eax
    1809:	66 89 45 fc          	mov    %ax,0xfffffffc(%ebp)
  return ((n & 0xff) << 8) | ((n & 0xff00) >> 8);
    180d:	0f b7 45 fc          	movzwl 0xfffffffc(%ebp),%eax
    1811:	25 ff 00 00 00       	and    $0xff,%eax
    1816:	c1 e0 08             	shl    $0x8,%eax
    1819:	89 c2                	mov    %eax,%edx
    181b:	0f b7 45 fc          	movzwl 0xfffffffc(%ebp),%eax
    181f:	25 00 ff 00 00       	and    $0xff00,%eax
    1824:	c1 f8 08             	sar    $0x8,%eax
    1827:	09 d0                	or     %edx,%eax
    1829:	0f b7 c0             	movzwl %ax,%eax
}
    182c:	c9                   	leave  
    182d:	c3                   	ret    
    182e:	89 f6                	mov    %esi,%esi

00001830 <ntohs>:

u16_t
ntohs(u16_t n)
{
    1830:	55                   	push   %ebp
    1831:	89 e5                	mov    %esp,%ebp
    1833:	83 ec 08             	sub    $0x8,%esp
    1836:	8b 45 08             	mov    0x8(%ebp),%eax
    1839:	66 89 45 fc          	mov    %ax,0xfffffffc(%ebp)
  return htons(n);
    183d:	0f b7 45 fc          	movzwl 0xfffffffc(%ebp),%eax
    1841:	89 04 24             	mov    %eax,(%esp)
    1844:	e8 b7 ff ff ff       	call   1800 <htons>
    1849:	0f b7 c0             	movzwl %ax,%eax
}
    184c:	c9                   	leave  
    184d:	c3                   	ret    
    184e:	89 f6                	mov    %esi,%esi

00001850 <htonl>:

u32_t
htonl(u32_t n)
{
    1850:	55                   	push   %ebp
    1851:	89 e5                	mov    %esp,%ebp
  return ((n & 0xff) << 24) |
    1853:	0f b6 45 08          	movzbl 0x8(%ebp),%eax
    1857:	89 c2                	mov    %eax,%edx
    1859:	c1 e2 18             	shl    $0x18,%edx
    185c:	8b 45 08             	mov    0x8(%ebp),%eax
    185f:	25 00 ff 00 00       	and    $0xff00,%eax
    1864:	c1 e0 08             	shl    $0x8,%eax
    1867:	09 c2                	or     %eax,%edx
    1869:	8b 45 08             	mov    0x8(%ebp),%eax
    186c:	25 00 00 ff 00       	and    $0xff0000,%eax
    1871:	c1 e8 08             	shr    $0x8,%eax
    1874:	09 c2                	or     %eax,%edx
    1876:	8b 45 08             	mov    0x8(%ebp),%eax
    1879:	25 00 00 00 ff       	and    $0xff000000,%eax
    187e:	c1 e8 18             	shr    $0x18,%eax
    1881:	09 d0                	or     %edx,%eax
    ((n & 0xff00) << 8) |
    ((n & 0xff0000) >> 8) |
    ((n & 0xff000000) >> 24);
}
    1883:	5d                   	pop    %ebp
    1884:	c3                   	ret    
    1885:	8d 74 26 00          	lea    0x0(%esi),%esi
    1889:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00001890 <ntohl>:

u32_t
ntohl(u32_t n)
{
    1890:	55                   	push   %ebp
    1891:	89 e5                	mov    %esp,%ebp
    1893:	83 ec 04             	sub    $0x4,%esp
  return htonl(n);
    1896:	8b 45 08             	mov    0x8(%ebp),%eax
    1899:	89 04 24             	mov    %eax,(%esp)
    189c:	e8 af ff ff ff       	call   1850 <htonl>
}
    18a1:	c9                   	leave  
    18a2:	c3                   	ret    
