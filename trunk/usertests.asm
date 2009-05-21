
_usertests:     file format elf32-i386-freebsd

Disassembly of section .text:

00000000 <opentest>:
// simple file system tests

void
opentest(void)
{
       0:	55                   	push   %ebp
       1:	89 e5                	mov    %esp,%ebp
       3:	83 ec 18             	sub    $0x18,%esp
  int fd;

  printf(stdout, "open test\n");
       6:	a1 3c 52 00 00       	mov    0x523c,%eax
       b:	c7 44 24 04 55 3f 00 	movl   $0x3f55,0x4(%esp)
      12:	00 
      13:	89 04 24             	mov    %eax,(%esp)
      16:	e8 95 33 00 00       	call   33b0 <printf>
  fd = open("echo", 0);
      1b:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
      22:	00 
      23:	c7 04 24 34 3f 00 00 	movl   $0x3f34,(%esp)
      2a:	e8 b5 31 00 00       	call   31e4 <open>
      2f:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
  if(fd < 0){
      32:	83 7d fc 00          	cmpl   $0x0,0xfffffffc(%ebp)
      36:	79 1a                	jns    52 <opentest+0x52>
    printf(stdout, "open echo failed!\n");
      38:	a1 3c 52 00 00       	mov    0x523c,%eax
      3d:	c7 44 24 04 60 3f 00 	movl   $0x3f60,0x4(%esp)
      44:	00 
      45:	89 04 24             	mov    %eax,(%esp)
      48:	e8 63 33 00 00       	call   33b0 <printf>
    exit();
      4d:	e8 52 31 00 00       	call   31a4 <exit>
  }
  close(fd);
      52:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
      55:	89 04 24             	mov    %eax,(%esp)
      58:	e8 6f 31 00 00       	call   31cc <close>
  fd = open("doesnotexist", 0);
      5d:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
      64:	00 
      65:	c7 04 24 73 3f 00 00 	movl   $0x3f73,(%esp)
      6c:	e8 73 31 00 00       	call   31e4 <open>
      71:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
  if(fd >= 0){
      74:	83 7d fc 00          	cmpl   $0x0,0xfffffffc(%ebp)
      78:	78 1a                	js     94 <opentest+0x94>
    printf(stdout, "open doesnotexist succeeded!\n");
      7a:	a1 3c 52 00 00       	mov    0x523c,%eax
      7f:	c7 44 24 04 80 3f 00 	movl   $0x3f80,0x4(%esp)
      86:	00 
      87:	89 04 24             	mov    %eax,(%esp)
      8a:	e8 21 33 00 00       	call   33b0 <printf>
    exit();
      8f:	e8 10 31 00 00       	call   31a4 <exit>
  }
  printf(stdout, "open test ok\n");
      94:	a1 3c 52 00 00       	mov    0x523c,%eax
      99:	c7 44 24 04 9e 3f 00 	movl   $0x3f9e,0x4(%esp)
      a0:	00 
      a1:	89 04 24             	mov    %eax,(%esp)
      a4:	e8 07 33 00 00       	call   33b0 <printf>
}
      a9:	c9                   	leave  
      aa:	c3                   	ret    
      ab:	90                   	nop    
      ac:	8d 74 26 00          	lea    0x0(%esi),%esi

000000b0 <writetest>:

void
writetest(void)
{
      b0:	55                   	push   %ebp
      b1:	89 e5                	mov    %esp,%ebp
      b3:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int i;

  printf(stdout, "small file test\n");
      b6:	a1 3c 52 00 00       	mov    0x523c,%eax
      bb:	c7 44 24 04 ac 3f 00 	movl   $0x3fac,0x4(%esp)
      c2:	00 
      c3:	89 04 24             	mov    %eax,(%esp)
      c6:	e8 e5 32 00 00       	call   33b0 <printf>
  fd = open("small", O_CREATE|O_RDWR);
      cb:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
      d2:	00 
      d3:	c7 04 24 bd 3f 00 00 	movl   $0x3fbd,(%esp)
      da:	e8 05 31 00 00       	call   31e4 <open>
      df:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
  if(fd >= 0){
      e2:	83 7d f8 00          	cmpl   $0x0,0xfffffff8(%ebp)
      e6:	78 21                	js     109 <writetest+0x59>
    printf(stdout, "creat small succeeded; ok\n");
      e8:	a1 3c 52 00 00       	mov    0x523c,%eax
      ed:	c7 44 24 04 c3 3f 00 	movl   $0x3fc3,0x4(%esp)
      f4:	00 
      f5:	89 04 24             	mov    %eax,(%esp)
      f8:	e8 b3 32 00 00       	call   33b0 <printf>
  } else {
    printf(stdout, "error: creat small failed!\n");
    exit();
  }
  for(i = 0; i < 100; i++) {
      fd:	c7 45 fc 00 00 00 00 	movl   $0x0,0xfffffffc(%ebp)
     104:	e9 a2 00 00 00       	jmp    1ab <writetest+0xfb>
     109:	a1 3c 52 00 00       	mov    0x523c,%eax
     10e:	c7 44 24 04 de 3f 00 	movl   $0x3fde,0x4(%esp)
     115:	00 
     116:	89 04 24             	mov    %eax,(%esp)
     119:	e8 92 32 00 00       	call   33b0 <printf>
     11e:	e8 81 30 00 00       	call   31a4 <exit>
    if(write(fd, "aaaaaaaaaa", 10) != 10) {
     123:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
     12a:	00 
     12b:	c7 44 24 04 fa 3f 00 	movl   $0x3ffa,0x4(%esp)
     132:	00 
     133:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     136:	89 04 24             	mov    %eax,(%esp)
     139:	e8 86 30 00 00       	call   31c4 <write>
     13e:	83 f8 0a             	cmp    $0xa,%eax
     141:	74 22                	je     165 <writetest+0xb5>
      printf(stdout, "error: write aa %d new file failed\n", i);
     143:	8b 15 3c 52 00 00    	mov    0x523c,%edx
     149:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     14c:	89 44 24 08          	mov    %eax,0x8(%esp)
     150:	c7 44 24 04 08 40 00 	movl   $0x4008,0x4(%esp)
     157:	00 
     158:	89 14 24             	mov    %edx,(%esp)
     15b:	e8 50 32 00 00       	call   33b0 <printf>
      exit();
     160:	e8 3f 30 00 00       	call   31a4 <exit>
    }
    if(write(fd, "bbbbbbbbbb", 10) != 10) {
     165:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
     16c:	00 
     16d:	c7 44 24 04 2c 40 00 	movl   $0x402c,0x4(%esp)
     174:	00 
     175:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     178:	89 04 24             	mov    %eax,(%esp)
     17b:	e8 44 30 00 00       	call   31c4 <write>
     180:	83 f8 0a             	cmp    $0xa,%eax
     183:	74 22                	je     1a7 <writetest+0xf7>
      printf(stdout, "error: write bb %d new file failed\n", i);
     185:	8b 15 3c 52 00 00    	mov    0x523c,%edx
     18b:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     18e:	89 44 24 08          	mov    %eax,0x8(%esp)
     192:	c7 44 24 04 38 40 00 	movl   $0x4038,0x4(%esp)
     199:	00 
     19a:	89 14 24             	mov    %edx,(%esp)
     19d:	e8 0e 32 00 00       	call   33b0 <printf>
      exit();
     1a2:	e8 fd 2f 00 00       	call   31a4 <exit>
     1a7:	83 45 fc 01          	addl   $0x1,0xfffffffc(%ebp)
     1ab:	83 7d fc 63          	cmpl   $0x63,0xfffffffc(%ebp)
     1af:	0f 8e 6e ff ff ff    	jle    123 <writetest+0x73>
    }
  }
  printf(stdout, "writes ok\n");
     1b5:	a1 3c 52 00 00       	mov    0x523c,%eax
     1ba:	c7 44 24 04 5c 40 00 	movl   $0x405c,0x4(%esp)
     1c1:	00 
     1c2:	89 04 24             	mov    %eax,(%esp)
     1c5:	e8 e6 31 00 00       	call   33b0 <printf>
  close(fd);
     1ca:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     1cd:	89 04 24             	mov    %eax,(%esp)
     1d0:	e8 f7 2f 00 00       	call   31cc <close>
  fd = open("small", O_RDONLY);
     1d5:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     1dc:	00 
     1dd:	c7 04 24 bd 3f 00 00 	movl   $0x3fbd,(%esp)
     1e4:	e8 fb 2f 00 00       	call   31e4 <open>
     1e9:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
  if(fd >= 0){
     1ec:	83 7d f8 00          	cmpl   $0x0,0xfffffff8(%ebp)
     1f0:	78 3e                	js     230 <writetest+0x180>
    printf(stdout, "open small succeeded ok\n");
     1f2:	a1 3c 52 00 00       	mov    0x523c,%eax
     1f7:	c7 44 24 04 67 40 00 	movl   $0x4067,0x4(%esp)
     1fe:	00 
     1ff:	89 04 24             	mov    %eax,(%esp)
     202:	e8 a9 31 00 00       	call   33b0 <printf>
  } else {
    printf(stdout, "error: open small failed!\n");
    exit();
  }
  i = read(fd, buf, 2000);
     207:	c7 44 24 08 d0 07 00 	movl   $0x7d0,0x8(%esp)
     20e:	00 
     20f:	c7 44 24 04 80 52 00 	movl   $0x5280,0x4(%esp)
     216:	00 
     217:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     21a:	89 04 24             	mov    %eax,(%esp)
     21d:	e8 9a 2f 00 00       	call   31bc <read>
     222:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
  if(i == 2000) {
     225:	81 7d fc d0 07 00 00 	cmpl   $0x7d0,0xfffffffc(%ebp)
     22c:	74 1c                	je     24a <writetest+0x19a>
     22e:	eb 4c                	jmp    27c <writetest+0x1cc>
     230:	a1 3c 52 00 00       	mov    0x523c,%eax
     235:	c7 44 24 04 80 40 00 	movl   $0x4080,0x4(%esp)
     23c:	00 
     23d:	89 04 24             	mov    %eax,(%esp)
     240:	e8 6b 31 00 00       	call   33b0 <printf>
     245:	e8 5a 2f 00 00       	call   31a4 <exit>
    printf(stdout, "read succeeded ok\n");
     24a:	a1 3c 52 00 00       	mov    0x523c,%eax
     24f:	c7 44 24 04 9b 40 00 	movl   $0x409b,0x4(%esp)
     256:	00 
     257:	89 04 24             	mov    %eax,(%esp)
     25a:	e8 51 31 00 00       	call   33b0 <printf>
  } else {
    printf(stdout, "read failed\n");
    exit();
  }
  close(fd);
     25f:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     262:	89 04 24             	mov    %eax,(%esp)
     265:	e8 62 2f 00 00       	call   31cc <close>

  if(unlink("small") < 0) {
     26a:	c7 04 24 bd 3f 00 00 	movl   $0x3fbd,(%esp)
     271:	e8 7e 2f 00 00       	call   31f4 <unlink>
     276:	85 c0                	test   %eax,%eax
     278:	78 1c                	js     296 <writetest+0x1e6>
     27a:	eb 34                	jmp    2b0 <writetest+0x200>
     27c:	a1 3c 52 00 00       	mov    0x523c,%eax
     281:	c7 44 24 04 ae 40 00 	movl   $0x40ae,0x4(%esp)
     288:	00 
     289:	89 04 24             	mov    %eax,(%esp)
     28c:	e8 1f 31 00 00       	call   33b0 <printf>
     291:	e8 0e 2f 00 00       	call   31a4 <exit>
    printf(stdout, "unlink small failed\n");
     296:	a1 3c 52 00 00       	mov    0x523c,%eax
     29b:	c7 44 24 04 bb 40 00 	movl   $0x40bb,0x4(%esp)
     2a2:	00 
     2a3:	89 04 24             	mov    %eax,(%esp)
     2a6:	e8 05 31 00 00       	call   33b0 <printf>
    exit();
     2ab:	e8 f4 2e 00 00       	call   31a4 <exit>
  }
  printf(stdout, "small file test ok\n");
     2b0:	a1 3c 52 00 00       	mov    0x523c,%eax
     2b5:	c7 44 24 04 d0 40 00 	movl   $0x40d0,0x4(%esp)
     2bc:	00 
     2bd:	89 04 24             	mov    %eax,(%esp)
     2c0:	e8 eb 30 00 00       	call   33b0 <printf>
}
     2c5:	c9                   	leave  
     2c6:	c3                   	ret    
     2c7:	89 f6                	mov    %esi,%esi
     2c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

000002d0 <writetest1>:

void
writetest1(void)
{
     2d0:	55                   	push   %ebp
     2d1:	89 e5                	mov    %esp,%ebp
     2d3:	83 ec 28             	sub    $0x28,%esp
  int i, fd, n;

  printf(stdout, "big files test\n");
     2d6:	a1 3c 52 00 00       	mov    0x523c,%eax
     2db:	c7 44 24 04 e4 40 00 	movl   $0x40e4,0x4(%esp)
     2e2:	00 
     2e3:	89 04 24             	mov    %eax,(%esp)
     2e6:	e8 c5 30 00 00       	call   33b0 <printf>

  fd = open("big", O_CREATE|O_RDWR);
     2eb:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
     2f2:	00 
     2f3:	c7 04 24 f4 40 00 00 	movl   $0x40f4,(%esp)
     2fa:	e8 e5 2e 00 00       	call   31e4 <open>
     2ff:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
  if(fd < 0){
     302:	83 7d f8 00          	cmpl   $0x0,0xfffffff8(%ebp)
     306:	79 1a                	jns    322 <writetest1+0x52>
    printf(stdout, "error: creat big failed!\n");
     308:	a1 3c 52 00 00       	mov    0x523c,%eax
     30d:	c7 44 24 04 f8 40 00 	movl   $0x40f8,0x4(%esp)
     314:	00 
     315:	89 04 24             	mov    %eax,(%esp)
     318:	e8 93 30 00 00       	call   33b0 <printf>
    exit();
     31d:	e8 82 2e 00 00       	call   31a4 <exit>
  }

  for(i = 0; i < MAXFILE; i++) {
     322:	c7 45 f4 00 00 00 00 	movl   $0x0,0xfffffff4(%ebp)
     329:	eb 52                	jmp    37d <writetest1+0xad>
    ((int*) buf)[0] = i;
     32b:	ba 80 52 00 00       	mov    $0x5280,%edx
     330:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     333:	89 02                	mov    %eax,(%edx)
    if(write(fd, buf, 512) != 512) {
     335:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
     33c:	00 
     33d:	c7 44 24 04 80 52 00 	movl   $0x5280,0x4(%esp)
     344:	00 
     345:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     348:	89 04 24             	mov    %eax,(%esp)
     34b:	e8 74 2e 00 00       	call   31c4 <write>
     350:	3d 00 02 00 00       	cmp    $0x200,%eax
     355:	74 22                	je     379 <writetest1+0xa9>
      printf(stdout, "error: write big file failed\n", i);
     357:	8b 15 3c 52 00 00    	mov    0x523c,%edx
     35d:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     360:	89 44 24 08          	mov    %eax,0x8(%esp)
     364:	c7 44 24 04 12 41 00 	movl   $0x4112,0x4(%esp)
     36b:	00 
     36c:	89 14 24             	mov    %edx,(%esp)
     36f:	e8 3c 30 00 00       	call   33b0 <printf>
      exit();
     374:	e8 2b 2e 00 00       	call   31a4 <exit>
     379:	83 45 f4 01          	addl   $0x1,0xfffffff4(%ebp)
     37d:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     380:	3d 8b 00 00 00       	cmp    $0x8b,%eax
     385:	76 a4                	jbe    32b <writetest1+0x5b>
    }
  }

  close(fd);
     387:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     38a:	89 04 24             	mov    %eax,(%esp)
     38d:	e8 3a 2e 00 00       	call   31cc <close>

  fd = open("big", O_RDONLY);
     392:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     399:	00 
     39a:	c7 04 24 f4 40 00 00 	movl   $0x40f4,(%esp)
     3a1:	e8 3e 2e 00 00       	call   31e4 <open>
     3a6:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
  if(fd < 0){
     3a9:	83 7d f8 00          	cmpl   $0x0,0xfffffff8(%ebp)
     3ad:	79 1a                	jns    3c9 <writetest1+0xf9>
    printf(stdout, "error: open big failed!\n");
     3af:	a1 3c 52 00 00       	mov    0x523c,%eax
     3b4:	c7 44 24 04 30 41 00 	movl   $0x4130,0x4(%esp)
     3bb:	00 
     3bc:	89 04 24             	mov    %eax,(%esp)
     3bf:	e8 ec 2f 00 00       	call   33b0 <printf>
    exit();
     3c4:	e8 db 2d 00 00       	call   31a4 <exit>
  }

  n = 0;
     3c9:	c7 45 fc 00 00 00 00 	movl   $0x0,0xfffffffc(%ebp)
  for(;;) {
    i = read(fd, buf, 512);
     3d0:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
     3d7:	00 
     3d8:	c7 44 24 04 80 52 00 	movl   $0x5280,0x4(%esp)
     3df:	00 
     3e0:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     3e3:	89 04 24             	mov    %eax,(%esp)
     3e6:	e8 d1 2d 00 00       	call   31bc <read>
     3eb:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
    if(i == 0) {
     3ee:	83 7d f4 00          	cmpl   $0x0,0xfffffff4(%ebp)
     3f2:	75 4b                	jne    43f <writetest1+0x16f>
      if(n == MAXFILE - 1) {
     3f4:	81 7d fc 8b 00 00 00 	cmpl   $0x8b,0xfffffffc(%ebp)
     3fb:	75 22                	jne    41f <writetest1+0x14f>
        printf(stdout, "read only %d blocks from big", n);
     3fd:	8b 15 3c 52 00 00    	mov    0x523c,%edx
     403:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     406:	89 44 24 08          	mov    %eax,0x8(%esp)
     40a:	c7 44 24 04 49 41 00 	movl   $0x4149,0x4(%esp)
     411:	00 
     412:	89 14 24             	mov    %edx,(%esp)
     415:	e8 96 2f 00 00       	call   33b0 <printf>
        exit();
     41a:	e8 85 2d 00 00       	call   31a4 <exit>
      }
      break;
    } else if(i != 512) {
      printf(stdout, "read failed %d\n", i);
      exit();
    }
    if(((int*)buf)[0] != n) {
      printf(stdout, "read content of block %d is %d\n",
             n, ((int*)buf)[0]);
      exit();
    }
    n++;
  }
  close(fd);
     41f:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     422:	89 04 24             	mov    %eax,(%esp)
     425:	e8 a2 2d 00 00       	call   31cc <close>
  if(unlink("big") < 0) {
     42a:	c7 04 24 f4 40 00 00 	movl   $0x40f4,(%esp)
     431:	e8 be 2d 00 00       	call   31f4 <unlink>
     436:	85 c0                	test   %eax,%eax
     438:	78 72                	js     4ac <writetest1+0x1dc>
     43a:	e9 87 00 00 00       	jmp    4c6 <writetest1+0x1f6>
     43f:	81 7d f4 00 02 00 00 	cmpl   $0x200,0xfffffff4(%ebp)
     446:	74 22                	je     46a <writetest1+0x19a>
     448:	8b 15 3c 52 00 00    	mov    0x523c,%edx
     44e:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     451:	89 44 24 08          	mov    %eax,0x8(%esp)
     455:	c7 44 24 04 66 41 00 	movl   $0x4166,0x4(%esp)
     45c:	00 
     45d:	89 14 24             	mov    %edx,(%esp)
     460:	e8 4b 2f 00 00       	call   33b0 <printf>
     465:	e8 3a 2d 00 00       	call   31a4 <exit>
     46a:	b8 80 52 00 00       	mov    $0x5280,%eax
     46f:	8b 00                	mov    (%eax),%eax
     471:	3b 45 fc             	cmp    0xfffffffc(%ebp),%eax
     474:	74 2d                	je     4a3 <writetest1+0x1d3>
     476:	b8 80 52 00 00       	mov    $0x5280,%eax
     47b:	8b 00                	mov    (%eax),%eax
     47d:	8b 15 3c 52 00 00    	mov    0x523c,%edx
     483:	89 44 24 0c          	mov    %eax,0xc(%esp)
     487:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     48a:	89 44 24 08          	mov    %eax,0x8(%esp)
     48e:	c7 44 24 04 78 41 00 	movl   $0x4178,0x4(%esp)
     495:	00 
     496:	89 14 24             	mov    %edx,(%esp)
     499:	e8 12 2f 00 00       	call   33b0 <printf>
     49e:	e8 01 2d 00 00       	call   31a4 <exit>
     4a3:	83 45 fc 01          	addl   $0x1,0xfffffffc(%ebp)
     4a7:	e9 24 ff ff ff       	jmp    3d0 <writetest1+0x100>
    printf(stdout, "unlink big failed\n");
     4ac:	a1 3c 52 00 00       	mov    0x523c,%eax
     4b1:	c7 44 24 04 98 41 00 	movl   $0x4198,0x4(%esp)
     4b8:	00 
     4b9:	89 04 24             	mov    %eax,(%esp)
     4bc:	e8 ef 2e 00 00       	call   33b0 <printf>
    exit();
     4c1:	e8 de 2c 00 00       	call   31a4 <exit>
  }
  printf(stdout, "big files ok\n");
     4c6:	a1 3c 52 00 00       	mov    0x523c,%eax
     4cb:	c7 44 24 04 ab 41 00 	movl   $0x41ab,0x4(%esp)
     4d2:	00 
     4d3:	89 04 24             	mov    %eax,(%esp)
     4d6:	e8 d5 2e 00 00       	call   33b0 <printf>
}
     4db:	c9                   	leave  
     4dc:	c3                   	ret    
     4dd:	8d 76 00             	lea    0x0(%esi),%esi

000004e0 <createtest>:

void
createtest(void)
{
     4e0:	55                   	push   %ebp
     4e1:	89 e5                	mov    %esp,%ebp
     4e3:	83 ec 18             	sub    $0x18,%esp
  int i, fd;

  printf(stdout, "many creates, followed by unlink test\n");
     4e6:	a1 3c 52 00 00       	mov    0x523c,%eax
     4eb:	c7 44 24 04 bc 41 00 	movl   $0x41bc,0x4(%esp)
     4f2:	00 
     4f3:	89 04 24             	mov    %eax,(%esp)
     4f6:	e8 b5 2e 00 00       	call   33b0 <printf>

  name[0] = 'a';
     4fb:	c6 05 80 5a 00 00 61 	movb   $0x61,0x5a80
  name[2] = '\0';
     502:	c6 05 82 5a 00 00 00 	movb   $0x0,0x5a82
  for(i = 0; i < 52; i++) {
     509:	c7 45 f8 00 00 00 00 	movl   $0x0,0xfffffff8(%ebp)
     510:	eb 31                	jmp    543 <createtest+0x63>
    name[1] = '0' + i;
     512:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     515:	83 c0 30             	add    $0x30,%eax
     518:	a2 81 5a 00 00       	mov    %al,0x5a81
    fd = open(name, O_CREATE|O_RDWR);
     51d:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
     524:	00 
     525:	c7 04 24 80 5a 00 00 	movl   $0x5a80,(%esp)
     52c:	e8 b3 2c 00 00       	call   31e4 <open>
     531:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
    close(fd);
     534:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     537:	89 04 24             	mov    %eax,(%esp)
     53a:	e8 8d 2c 00 00       	call   31cc <close>
     53f:	83 45 f8 01          	addl   $0x1,0xfffffff8(%ebp)
     543:	83 7d f8 33          	cmpl   $0x33,0xfffffff8(%ebp)
     547:	7e c9                	jle    512 <createtest+0x32>
  }
  name[0] = 'a';
     549:	c6 05 80 5a 00 00 61 	movb   $0x61,0x5a80
  name[2] = '\0';
     550:	c6 05 82 5a 00 00 00 	movb   $0x0,0x5a82
  for(i = 0; i < 52; i++) {
     557:	c7 45 f8 00 00 00 00 	movl   $0x0,0xfffffff8(%ebp)
     55e:	eb 1b                	jmp    57b <createtest+0x9b>
    name[1] = '0' + i;
     560:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     563:	83 c0 30             	add    $0x30,%eax
     566:	a2 81 5a 00 00       	mov    %al,0x5a81
    unlink(name);
     56b:	c7 04 24 80 5a 00 00 	movl   $0x5a80,(%esp)
     572:	e8 7d 2c 00 00       	call   31f4 <unlink>
     577:	83 45 f8 01          	addl   $0x1,0xfffffff8(%ebp)
     57b:	83 7d f8 33          	cmpl   $0x33,0xfffffff8(%ebp)
     57f:	7e df                	jle    560 <createtest+0x80>
  }
  printf(stdout, "many creates, followed by unlink; ok\n");
     581:	a1 3c 52 00 00       	mov    0x523c,%eax
     586:	c7 44 24 04 e4 41 00 	movl   $0x41e4,0x4(%esp)
     58d:	00 
     58e:	89 04 24             	mov    %eax,(%esp)
     591:	e8 1a 2e 00 00       	call   33b0 <printf>
}
     596:	c9                   	leave  
     597:	c3                   	ret    
     598:	90                   	nop    
     599:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi

000005a0 <dirtest>:

void dirtest(void)
{
     5a0:	55                   	push   %ebp
     5a1:	89 e5                	mov    %esp,%ebp
     5a3:	83 ec 08             	sub    $0x8,%esp
  printf(stdout, "mkdir test\n");
     5a6:	a1 3c 52 00 00       	mov    0x523c,%eax
     5ab:	c7 44 24 04 0a 42 00 	movl   $0x420a,0x4(%esp)
     5b2:	00 
     5b3:	89 04 24             	mov    %eax,(%esp)
     5b6:	e8 f5 2d 00 00       	call   33b0 <printf>

  if(mkdir("dir0") < 0) {
     5bb:	c7 04 24 16 42 00 00 	movl   $0x4216,(%esp)
     5c2:	e8 45 2c 00 00       	call   320c <mkdir>
     5c7:	85 c0                	test   %eax,%eax
     5c9:	79 1a                	jns    5e5 <dirtest+0x45>
    printf(stdout, "mkdir failed\n");
     5cb:	a1 3c 52 00 00       	mov    0x523c,%eax
     5d0:	c7 44 24 04 1b 42 00 	movl   $0x421b,0x4(%esp)
     5d7:	00 
     5d8:	89 04 24             	mov    %eax,(%esp)
     5db:	e8 d0 2d 00 00       	call   33b0 <printf>
    exit();
     5e0:	e8 bf 2b 00 00       	call   31a4 <exit>
  }

  if(chdir("dir0") < 0) {
     5e5:	c7 04 24 16 42 00 00 	movl   $0x4216,(%esp)
     5ec:	e8 23 2c 00 00       	call   3214 <chdir>
     5f1:	85 c0                	test   %eax,%eax
     5f3:	79 1a                	jns    60f <dirtest+0x6f>
    printf(stdout, "chdir dir0 failed\n");
     5f5:	a1 3c 52 00 00       	mov    0x523c,%eax
     5fa:	c7 44 24 04 29 42 00 	movl   $0x4229,0x4(%esp)
     601:	00 
     602:	89 04 24             	mov    %eax,(%esp)
     605:	e8 a6 2d 00 00       	call   33b0 <printf>
    exit();
     60a:	e8 95 2b 00 00       	call   31a4 <exit>
  }

  if(chdir("..") < 0) {
     60f:	c7 04 24 3c 42 00 00 	movl   $0x423c,(%esp)
     616:	e8 f9 2b 00 00       	call   3214 <chdir>
     61b:	85 c0                	test   %eax,%eax
     61d:	79 1a                	jns    639 <dirtest+0x99>
    printf(stdout, "chdir .. failed\n");
     61f:	a1 3c 52 00 00       	mov    0x523c,%eax
     624:	c7 44 24 04 3f 42 00 	movl   $0x423f,0x4(%esp)
     62b:	00 
     62c:	89 04 24             	mov    %eax,(%esp)
     62f:	e8 7c 2d 00 00       	call   33b0 <printf>
    exit();
     634:	e8 6b 2b 00 00       	call   31a4 <exit>
  }

  if(unlink("dir0") < 0) {
     639:	c7 04 24 16 42 00 00 	movl   $0x4216,(%esp)
     640:	e8 af 2b 00 00       	call   31f4 <unlink>
     645:	85 c0                	test   %eax,%eax
     647:	79 1a                	jns    663 <dirtest+0xc3>
    printf(stdout, "unlink dir0 failed\n");
     649:	a1 3c 52 00 00       	mov    0x523c,%eax
     64e:	c7 44 24 04 50 42 00 	movl   $0x4250,0x4(%esp)
     655:	00 
     656:	89 04 24             	mov    %eax,(%esp)
     659:	e8 52 2d 00 00       	call   33b0 <printf>
    exit();
     65e:	e8 41 2b 00 00       	call   31a4 <exit>
  }
  printf(stdout, "mkdir test\n");
     663:	a1 3c 52 00 00       	mov    0x523c,%eax
     668:	c7 44 24 04 0a 42 00 	movl   $0x420a,0x4(%esp)
     66f:	00 
     670:	89 04 24             	mov    %eax,(%esp)
     673:	e8 38 2d 00 00       	call   33b0 <printf>
}
     678:	c9                   	leave  
     679:	c3                   	ret    
     67a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000680 <exectest>:

void
exectest(void)
{
     680:	55                   	push   %ebp
     681:	89 e5                	mov    %esp,%ebp
     683:	83 ec 08             	sub    $0x8,%esp
  printf(stdout, "exec test\n");
     686:	a1 3c 52 00 00       	mov    0x523c,%eax
     68b:	c7 44 24 04 64 42 00 	movl   $0x4264,0x4(%esp)
     692:	00 
     693:	89 04 24             	mov    %eax,(%esp)
     696:	e8 15 2d 00 00       	call   33b0 <printf>
  if(exec("echo", echo_args) < 0) {
     69b:	c7 44 24 04 1c 52 00 	movl   $0x521c,0x4(%esp)
     6a2:	00 
     6a3:	c7 04 24 34 3f 00 00 	movl   $0x3f34,(%esp)
     6aa:	e8 2d 2b 00 00       	call   31dc <exec>
     6af:	85 c0                	test   %eax,%eax
     6b1:	79 1a                	jns    6cd <exectest+0x4d>
    printf(stdout, "exec echo failed\n");
     6b3:	a1 3c 52 00 00       	mov    0x523c,%eax
     6b8:	c7 44 24 04 6f 42 00 	movl   $0x426f,0x4(%esp)
     6bf:	00 
     6c0:	89 04 24             	mov    %eax,(%esp)
     6c3:	e8 e8 2c 00 00       	call   33b0 <printf>
    exit();
     6c8:	e8 d7 2a 00 00       	call   31a4 <exit>
  }
}
     6cd:	c9                   	leave  
     6ce:	c3                   	ret    
     6cf:	90                   	nop    

000006d0 <pipe1>:

// simple fork and pipe read/write

void
pipe1(void)
{
     6d0:	55                   	push   %ebp
     6d1:	89 e5                	mov    %esp,%ebp
     6d3:	83 ec 38             	sub    $0x38,%esp
  int fds[2], pid;
  int seq, i, n, cc, total;

  if(pipe(fds) != 0){
     6d6:	8d 45 e0             	lea    0xffffffe0(%ebp),%eax
     6d9:	89 04 24             	mov    %eax,(%esp)
     6dc:	e8 d3 2a 00 00       	call   31b4 <pipe>
     6e1:	85 c0                	test   %eax,%eax
     6e3:	74 19                	je     6fe <pipe1+0x2e>
    printf(1, "pipe() failed\n");
     6e5:	c7 44 24 04 81 42 00 	movl   $0x4281,0x4(%esp)
     6ec:	00 
     6ed:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     6f4:	e8 b7 2c 00 00       	call   33b0 <printf>
    exit();
     6f9:	e8 a6 2a 00 00       	call   31a4 <exit>
  }
  pid = fork();
     6fe:	e8 99 2a 00 00       	call   319c <fork>
     703:	89 45 e8             	mov    %eax,0xffffffe8(%ebp)
  seq = 0;
     706:	c7 45 ec 00 00 00 00 	movl   $0x0,0xffffffec(%ebp)
  if(pid == 0){
     70d:	83 7d e8 00          	cmpl   $0x0,0xffffffe8(%ebp)
     711:	0f 85 84 00 00 00    	jne    79b <pipe1+0xcb>
    close(fds[0]);
     717:	8b 45 e0             	mov    0xffffffe0(%ebp),%eax
     71a:	89 04 24             	mov    %eax,(%esp)
     71d:	e8 aa 2a 00 00       	call   31cc <close>
    for(n = 0; n < 5; n++){
     722:	c7 45 f4 00 00 00 00 	movl   $0x0,0xfffffff4(%ebp)
     729:	eb 65                	jmp    790 <pipe1+0xc0>
      for(i = 0; i < 1033; i++)
     72b:	c7 45 f0 00 00 00 00 	movl   $0x0,0xfffffff0(%ebp)
     732:	eb 14                	jmp    748 <pipe1+0x78>
        buf[i] = seq++;
     734:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
     737:	8b 55 ec             	mov    0xffffffec(%ebp),%edx
     73a:	88 90 80 52 00 00    	mov    %dl,0x5280(%eax)
     740:	83 45 ec 01          	addl   $0x1,0xffffffec(%ebp)
     744:	83 45 f0 01          	addl   $0x1,0xfffffff0(%ebp)
     748:	81 7d f0 08 04 00 00 	cmpl   $0x408,0xfffffff0(%ebp)
     74f:	7e e3                	jle    734 <pipe1+0x64>
      if(write(fds[1], buf, 1033) != 1033){
     751:	8b 45 e4             	mov    0xffffffe4(%ebp),%eax
     754:	c7 44 24 08 09 04 00 	movl   $0x409,0x8(%esp)
     75b:	00 
     75c:	c7 44 24 04 80 52 00 	movl   $0x5280,0x4(%esp)
     763:	00 
     764:	89 04 24             	mov    %eax,(%esp)
     767:	e8 58 2a 00 00       	call   31c4 <write>
     76c:	3d 09 04 00 00       	cmp    $0x409,%eax
     771:	74 19                	je     78c <pipe1+0xbc>
        printf(1, "pipe1 oops 1\n");
     773:	c7 44 24 04 90 42 00 	movl   $0x4290,0x4(%esp)
     77a:	00 
     77b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     782:	e8 29 2c 00 00       	call   33b0 <printf>
        exit();
     787:	e8 18 2a 00 00       	call   31a4 <exit>
     78c:	83 45 f4 01          	addl   $0x1,0xfffffff4(%ebp)
     790:	83 7d f4 04          	cmpl   $0x4,0xfffffff4(%ebp)
     794:	7e 95                	jle    72b <pipe1+0x5b>
      }
    }
    exit();
     796:	e8 09 2a 00 00       	call   31a4 <exit>
  } else if(pid > 0){
     79b:	83 7d e8 00          	cmpl   $0x0,0xffffffe8(%ebp)
     79f:	0f 8e f5 00 00 00    	jle    89a <pipe1+0x1ca>
    close(fds[1]);
     7a5:	8b 45 e4             	mov    0xffffffe4(%ebp),%eax
     7a8:	89 04 24             	mov    %eax,(%esp)
     7ab:	e8 1c 2a 00 00       	call   31cc <close>
    total = 0;
     7b0:	c7 45 fc 00 00 00 00 	movl   $0x0,0xfffffffc(%ebp)
    cc = 1;
     7b7:	c7 45 f8 01 00 00 00 	movl   $0x1,0xfffffff8(%ebp)
    while((n = read(fds[0], buf, cc)) > 0){
     7be:	eb 69                	jmp    829 <pipe1+0x159>
      for(i = 0; i < n; i++){
     7c0:	c7 45 f0 00 00 00 00 	movl   $0x0,0xfffffff0(%ebp)
     7c7:	eb 3e                	jmp    807 <pipe1+0x137>
        if((buf[i] & 0xff) != (seq++ & 0xff)){
     7c9:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
     7cc:	0f b6 80 80 52 00 00 	movzbl 0x5280(%eax),%eax
     7d3:	0f be c0             	movsbl %al,%eax
     7d6:	0f b6 d0             	movzbl %al,%edx
     7d9:	0f b6 45 ec          	movzbl 0xffffffec(%ebp),%eax
     7dd:	39 c2                	cmp    %eax,%edx
     7df:	0f 95 c0             	setne  %al
     7e2:	83 45 ec 01          	addl   $0x1,0xffffffec(%ebp)
     7e6:	84 c0                	test   %al,%al
     7e8:	74 19                	je     803 <pipe1+0x133>
          printf(1, "pipe1 oops 2\n");
     7ea:	c7 44 24 04 9e 42 00 	movl   $0x429e,0x4(%esp)
     7f1:	00 
     7f2:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     7f9:	e8 b2 2b 00 00       	call   33b0 <printf>
          return;
     7fe:	e9 b0 00 00 00       	jmp    8b3 <pipe1+0x1e3>
     803:	83 45 f0 01          	addl   $0x1,0xfffffff0(%ebp)
     807:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
     80a:	3b 45 f4             	cmp    0xfffffff4(%ebp),%eax
     80d:	7c ba                	jl     7c9 <pipe1+0xf9>
        }
      }
      total += n;
     80f:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     812:	01 45 fc             	add    %eax,0xfffffffc(%ebp)
      cc = cc * 2;
     815:	d1 65 f8             	shll   0xfffffff8(%ebp)
      if(cc > sizeof(buf))
     818:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     81b:	3d 00 08 00 00       	cmp    $0x800,%eax
     820:	76 07                	jbe    829 <pipe1+0x159>
        cc = sizeof(buf);
     822:	c7 45 f8 00 08 00 00 	movl   $0x800,0xfffffff8(%ebp)
     829:	8b 45 e0             	mov    0xffffffe0(%ebp),%eax
     82c:	8b 55 f8             	mov    0xfffffff8(%ebp),%edx
     82f:	89 54 24 08          	mov    %edx,0x8(%esp)
     833:	c7 44 24 04 80 52 00 	movl   $0x5280,0x4(%esp)
     83a:	00 
     83b:	89 04 24             	mov    %eax,(%esp)
     83e:	e8 79 29 00 00       	call   31bc <read>
     843:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
     846:	83 7d f4 00          	cmpl   $0x0,0xfffffff4(%ebp)
     84a:	0f 8f 70 ff ff ff    	jg     7c0 <pipe1+0xf0>
    }
    if(total != 5 * 1033)
     850:	81 7d fc 2d 14 00 00 	cmpl   $0x142d,0xfffffffc(%ebp)
     857:	74 1b                	je     874 <pipe1+0x1a4>
      printf(1, "pipe1 oops 3 total %d\n", total);
     859:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     85c:	89 44 24 08          	mov    %eax,0x8(%esp)
     860:	c7 44 24 04 ac 42 00 	movl   $0x42ac,0x4(%esp)
     867:	00 
     868:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     86f:	e8 3c 2b 00 00       	call   33b0 <printf>
    close(fds[0]);
     874:	8b 45 e0             	mov    0xffffffe0(%ebp),%eax
     877:	89 04 24             	mov    %eax,(%esp)
     87a:	e8 4d 29 00 00       	call   31cc <close>
    wait();
     87f:	e8 28 29 00 00       	call   31ac <wait>
  } else {
    printf(1, "fork() failed\n");
    exit();
  }
  printf(1, "pipe1 ok\n");
     884:	c7 44 24 04 c3 42 00 	movl   $0x42c3,0x4(%esp)
     88b:	00 
     88c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     893:	e8 18 2b 00 00       	call   33b0 <printf>
     898:	eb 19                	jmp    8b3 <pipe1+0x1e3>
     89a:	c7 44 24 04 cd 42 00 	movl   $0x42cd,0x4(%esp)
     8a1:	00 
     8a2:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     8a9:	e8 02 2b 00 00       	call   33b0 <printf>
     8ae:	e8 f1 28 00 00       	call   31a4 <exit>
}
     8b3:	c9                   	leave  
     8b4:	c3                   	ret    
     8b5:	8d 74 26 00          	lea    0x0(%esi),%esi
     8b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

000008c0 <preempt>:

// meant to be run w/ at most two CPUs
void
preempt(void)
{
     8c0:	55                   	push   %ebp
     8c1:	89 e5                	mov    %esp,%ebp
     8c3:	83 ec 38             	sub    $0x38,%esp
  int pid1, pid2, pid3;
  int pfds[2];

  pid1 = fork();
     8c6:	e8 d1 28 00 00       	call   319c <fork>
     8cb:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
  if(pid1 == 0)
     8ce:	83 7d f4 00          	cmpl   $0x0,0xfffffff4(%ebp)
     8d2:	75 02                	jne    8d6 <preempt+0x16>
    for(;;)
      ;
     8d4:	eb fe                	jmp    8d4 <preempt+0x14>

  pid2 = fork();
     8d6:	e8 c1 28 00 00       	call   319c <fork>
     8db:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
  if(pid2 == 0)
     8de:	83 7d f8 00          	cmpl   $0x0,0xfffffff8(%ebp)
     8e2:	75 02                	jne    8e6 <preempt+0x26>
    for(;;)
      ;
     8e4:	eb fe                	jmp    8e4 <preempt+0x24>

  pipe(pfds);
     8e6:	8d 45 ec             	lea    0xffffffec(%ebp),%eax
     8e9:	89 04 24             	mov    %eax,(%esp)
     8ec:	e8 c3 28 00 00       	call   31b4 <pipe>
  pid3 = fork();
     8f1:	e8 a6 28 00 00       	call   319c <fork>
     8f6:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
  if(pid3 == 0){
     8f9:	83 7d fc 00          	cmpl   $0x0,0xfffffffc(%ebp)
     8fd:	75 4c                	jne    94b <preempt+0x8b>
    close(pfds[0]);
     8ff:	8b 45 ec             	mov    0xffffffec(%ebp),%eax
     902:	89 04 24             	mov    %eax,(%esp)
     905:	e8 c2 28 00 00       	call   31cc <close>
    if(write(pfds[1], "x", 1) != 1)
     90a:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
     90d:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
     914:	00 
     915:	c7 44 24 04 dc 42 00 	movl   $0x42dc,0x4(%esp)
     91c:	00 
     91d:	89 04 24             	mov    %eax,(%esp)
     920:	e8 9f 28 00 00       	call   31c4 <write>
     925:	83 f8 01             	cmp    $0x1,%eax
     928:	74 14                	je     93e <preempt+0x7e>
      printf(1, "preempt write error");
     92a:	c7 44 24 04 de 42 00 	movl   $0x42de,0x4(%esp)
     931:	00 
     932:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     939:	e8 72 2a 00 00       	call   33b0 <printf>
    close(pfds[1]);
     93e:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
     941:	89 04 24             	mov    %eax,(%esp)
     944:	e8 83 28 00 00       	call   31cc <close>
    for(;;)
      ;
     949:	eb fe                	jmp    949 <preempt+0x89>
  }

  close(pfds[1]);
     94b:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
     94e:	89 04 24             	mov    %eax,(%esp)
     951:	e8 76 28 00 00       	call   31cc <close>
  if(read(pfds[0], buf, sizeof(buf)) != 1){
     956:	8b 45 ec             	mov    0xffffffec(%ebp),%eax
     959:	c7 44 24 08 00 08 00 	movl   $0x800,0x8(%esp)
     960:	00 
     961:	c7 44 24 04 80 52 00 	movl   $0x5280,0x4(%esp)
     968:	00 
     969:	89 04 24             	mov    %eax,(%esp)
     96c:	e8 4b 28 00 00       	call   31bc <read>
     971:	83 f8 01             	cmp    $0x1,%eax
     974:	74 16                	je     98c <preempt+0xcc>
    printf(1, "preempt read error");
     976:	c7 44 24 04 f2 42 00 	movl   $0x42f2,0x4(%esp)
     97d:	00 
     97e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     985:	e8 26 2a 00 00       	call   33b0 <printf>
    return;
     98a:	eb 4f                	jmp    9db <preempt+0x11b>
  }
  close(pfds[0]);
     98c:	8b 45 ec             	mov    0xffffffec(%ebp),%eax
     98f:	89 04 24             	mov    %eax,(%esp)
     992:	e8 35 28 00 00       	call   31cc <close>
  kill(pid1);
     997:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     99a:	89 04 24             	mov    %eax,(%esp)
     99d:	e8 32 28 00 00       	call   31d4 <kill>
  kill(pid2);
     9a2:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     9a5:	89 04 24             	mov    %eax,(%esp)
     9a8:	e8 27 28 00 00       	call   31d4 <kill>
  kill(pid3);
     9ad:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     9b0:	89 04 24             	mov    %eax,(%esp)
     9b3:	e8 1c 28 00 00       	call   31d4 <kill>
  wait();
     9b8:	e8 ef 27 00 00       	call   31ac <wait>
  wait();
     9bd:	e8 ea 27 00 00       	call   31ac <wait>
  wait();
     9c2:	e8 e5 27 00 00       	call   31ac <wait>
  printf(1, "preempt ok\n");
     9c7:	c7 44 24 04 05 43 00 	movl   $0x4305,0x4(%esp)
     9ce:	00 
     9cf:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     9d6:	e8 d5 29 00 00       	call   33b0 <printf>
}
     9db:	c9                   	leave  
     9dc:	c3                   	ret    
     9dd:	8d 76 00             	lea    0x0(%esi),%esi

000009e0 <exitwait>:

// try to find any races between exit and wait
void
exitwait(void)
{
     9e0:	55                   	push   %ebp
     9e1:	89 e5                	mov    %esp,%ebp
     9e3:	83 ec 18             	sub    $0x18,%esp
  int i, pid;

  for(i = 0; i < 100; i++){
     9e6:	c7 45 f8 00 00 00 00 	movl   $0x0,0xfffffff8(%ebp)
     9ed:	eb 55                	jmp    a44 <exitwait+0x64>
    pid = fork();
     9ef:	e8 a8 27 00 00       	call   319c <fork>
     9f4:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
    if(pid < 0){
     9f7:	83 7d fc 00          	cmpl   $0x0,0xfffffffc(%ebp)
     9fb:	79 16                	jns    a13 <exitwait+0x33>
      printf(1, "fork failed\n");
     9fd:	c7 44 24 04 11 43 00 	movl   $0x4311,0x4(%esp)
     a04:	00 
     a05:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     a0c:	e8 9f 29 00 00       	call   33b0 <printf>
      return;
     a11:	eb 4b                	jmp    a5e <exitwait+0x7e>
    }
    if(pid){
     a13:	83 7d fc 00          	cmpl   $0x0,0xfffffffc(%ebp)
     a17:	74 26                	je     a3f <exitwait+0x5f>
      if(wait() != pid){
     a19:	e8 8e 27 00 00       	call   31ac <wait>
     a1e:	3b 45 fc             	cmp    0xfffffffc(%ebp),%eax
     a21:	74 16                	je     a39 <exitwait+0x59>
        printf(1, "wait wrong pid\n");
     a23:	c7 44 24 04 1e 43 00 	movl   $0x431e,0x4(%esp)
     a2a:	00 
     a2b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     a32:	e8 79 29 00 00       	call   33b0 <printf>
        return;
     a37:	eb 25                	jmp    a5e <exitwait+0x7e>
     a39:	83 45 f8 01          	addl   $0x1,0xfffffff8(%ebp)
     a3d:	eb 05                	jmp    a44 <exitwait+0x64>
      }
    } else {
      exit();
     a3f:	e8 60 27 00 00       	call   31a4 <exit>
     a44:	83 7d f8 63          	cmpl   $0x63,0xfffffff8(%ebp)
     a48:	7e a5                	jle    9ef <exitwait+0xf>
    }
  }
  printf(1, "exitwait ok\n");
     a4a:	c7 44 24 04 2e 43 00 	movl   $0x432e,0x4(%esp)
     a51:	00 
     a52:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     a59:	e8 52 29 00 00       	call   33b0 <printf>
}
     a5e:	c9                   	leave  
     a5f:	c3                   	ret    

00000a60 <mem>:

void
mem(void)
{
     a60:	55                   	push   %ebp
     a61:	89 e5                	mov    %esp,%ebp
     a63:	83 ec 18             	sub    $0x18,%esp
  void *m1, *m2;
  int pid;

  if((pid = fork()) == 0){
     a66:	e8 31 27 00 00       	call   319c <fork>
     a6b:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
     a6e:	83 7d fc 00          	cmpl   $0x0,0xfffffffc(%ebp)
     a72:	0f 85 9f 00 00 00    	jne    b17 <mem+0xb7>
    m1 = 0;
     a78:	c7 45 f4 00 00 00 00 	movl   $0x0,0xfffffff4(%ebp)
    while((m2 = malloc(10001)) != 0) {
     a7f:	eb 0e                	jmp    a8f <mem+0x2f>
      *(char**) m2 = m1;
     a81:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     a84:	8b 55 f4             	mov    0xfffffff4(%ebp),%edx
     a87:	89 10                	mov    %edx,(%eax)
      m1 = m2;
     a89:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     a8c:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
     a8f:	c7 04 24 11 27 00 00 	movl   $0x2711,(%esp)
     a96:	e8 35 2c 00 00       	call   36d0 <malloc>
     a9b:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
     a9e:	83 7d f8 00          	cmpl   $0x0,0xfffffff8(%ebp)
     aa2:	75 dd                	jne    a81 <mem+0x21>
    }
    while(m1) {
     aa4:	eb 19                	jmp    abf <mem+0x5f>
      m2 = *(char**)m1;
     aa6:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     aa9:	8b 00                	mov    (%eax),%eax
     aab:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
      free(m1);
     aae:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     ab1:	89 04 24             	mov    %eax,(%esp)
     ab4:	e8 b7 2a 00 00       	call   3570 <free>
      m1 = m2;
     ab9:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     abc:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
     abf:	83 7d f4 00          	cmpl   $0x0,0xfffffff4(%ebp)
     ac3:	75 e1                	jne    aa6 <mem+0x46>
    }
    m1 = malloc(1024*20);
     ac5:	c7 04 24 00 50 00 00 	movl   $0x5000,(%esp)
     acc:	e8 ff 2b 00 00       	call   36d0 <malloc>
     ad1:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
    if(m1 == 0) {
     ad4:	83 7d f4 00          	cmpl   $0x0,0xfffffff4(%ebp)
     ad8:	75 19                	jne    af3 <mem+0x93>
      printf(1, "couldn't allocate mem?!!\n");
     ada:	c7 44 24 04 3b 43 00 	movl   $0x433b,0x4(%esp)
     ae1:	00 
     ae2:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     ae9:	e8 c2 28 00 00       	call   33b0 <printf>
      exit();
     aee:	e8 b1 26 00 00       	call   31a4 <exit>
    }
    free(m1);
     af3:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     af6:	89 04 24             	mov    %eax,(%esp)
     af9:	e8 72 2a 00 00       	call   3570 <free>
    printf(1, "mem ok\n");
     afe:	c7 44 24 04 55 43 00 	movl   $0x4355,0x4(%esp)
     b05:	00 
     b06:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     b0d:	e8 9e 28 00 00       	call   33b0 <printf>
    exit();
     b12:	e8 8d 26 00 00       	call   31a4 <exit>
  } else {
    wait();
     b17:	e8 90 26 00 00       	call   31ac <wait>
  }
}
     b1c:	c9                   	leave  
     b1d:	c3                   	ret    
     b1e:	89 f6                	mov    %esi,%esi

00000b20 <sharedfd>:

// More file system tests

// two processes write to the same file descriptor
// is the offset shared? does inode locking work?
void
sharedfd(void)
{
     b20:	55                   	push   %ebp
     b21:	89 e5                	mov    %esp,%ebp
     b23:	83 ec 48             	sub    $0x48,%esp
  int fd, pid, i, n, nc, np;
  char buf[10];

  unlink("sharedfd");
     b26:	c7 04 24 5d 43 00 00 	movl   $0x435d,(%esp)
     b2d:	e8 c2 26 00 00       	call   31f4 <unlink>
  fd = open("sharedfd", O_CREATE|O_RDWR);
     b32:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
     b39:	00 
     b3a:	c7 04 24 5d 43 00 00 	movl   $0x435d,(%esp)
     b41:	e8 9e 26 00 00       	call   31e4 <open>
     b46:	89 45 e8             	mov    %eax,0xffffffe8(%ebp)
  if(fd < 0){
     b49:	83 7d e8 00          	cmpl   $0x0,0xffffffe8(%ebp)
     b4d:	79 19                	jns    b68 <sharedfd+0x48>
    printf(1, "fstests: cannot open sharedfd for writing");
     b4f:	c7 44 24 04 68 43 00 	movl   $0x4368,0x4(%esp)
     b56:	00 
     b57:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     b5e:	e8 4d 28 00 00       	call   33b0 <printf>
    return;
     b63:	e9 9c 01 00 00       	jmp    d04 <sharedfd+0x1e4>
  }
  pid = fork();
     b68:	e8 2f 26 00 00       	call   319c <fork>
     b6d:	89 45 ec             	mov    %eax,0xffffffec(%ebp)
  memset(buf, pid==0?'c':'p', sizeof(buf));
     b70:	83 7d ec 00          	cmpl   $0x0,0xffffffec(%ebp)
     b74:	75 09                	jne    b7f <sharedfd+0x5f>
     b76:	c7 45 cc 63 00 00 00 	movl   $0x63,0xffffffcc(%ebp)
     b7d:	eb 07                	jmp    b86 <sharedfd+0x66>
     b7f:	c7 45 cc 70 00 00 00 	movl   $0x70,0xffffffcc(%ebp)
     b86:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
     b8d:	00 
     b8e:	8b 45 cc             	mov    0xffffffcc(%ebp),%eax
     b91:	89 44 24 04          	mov    %eax,0x4(%esp)
     b95:	8d 45 de             	lea    0xffffffde(%ebp),%eax
     b98:	89 04 24             	mov    %eax,(%esp)
     b9b:	e8 30 24 00 00       	call   2fd0 <memset>
  for(i = 0; i < 1000; i++){
     ba0:	c7 45 f0 00 00 00 00 	movl   $0x0,0xfffffff0(%ebp)
     ba7:	eb 39                	jmp    be2 <sharedfd+0xc2>
    if(write(fd, buf, sizeof(buf)) != sizeof(buf)){
     ba9:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
     bb0:	00 
     bb1:	8d 45 de             	lea    0xffffffde(%ebp),%eax
     bb4:	89 44 24 04          	mov    %eax,0x4(%esp)
     bb8:	8b 45 e8             	mov    0xffffffe8(%ebp),%eax
     bbb:	89 04 24             	mov    %eax,(%esp)
     bbe:	e8 01 26 00 00       	call   31c4 <write>
     bc3:	83 f8 0a             	cmp    $0xa,%eax
     bc6:	74 16                	je     bde <sharedfd+0xbe>
      printf(1, "fstests: write sharedfd failed\n");
     bc8:	c7 44 24 04 94 43 00 	movl   $0x4394,0x4(%esp)
     bcf:	00 
     bd0:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     bd7:	e8 d4 27 00 00       	call   33b0 <printf>
      break;
     bdc:	eb 0d                	jmp    beb <sharedfd+0xcb>
     bde:	83 45 f0 01          	addl   $0x1,0xfffffff0(%ebp)
     be2:	81 7d f0 e7 03 00 00 	cmpl   $0x3e7,0xfffffff0(%ebp)
     be9:	7e be                	jle    ba9 <sharedfd+0x89>
    }
  }
  if(pid == 0)
     beb:	83 7d ec 00          	cmpl   $0x0,0xffffffec(%ebp)
     bef:	75 05                	jne    bf6 <sharedfd+0xd6>
    exit();
     bf1:	e8 ae 25 00 00       	call   31a4 <exit>
  else
    wait();
     bf6:	e8 b1 25 00 00       	call   31ac <wait>
  close(fd);
     bfb:	8b 45 e8             	mov    0xffffffe8(%ebp),%eax
     bfe:	89 04 24             	mov    %eax,(%esp)
     c01:	e8 c6 25 00 00       	call   31cc <close>
  fd = open("sharedfd", 0);
     c06:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     c0d:	00 
     c0e:	c7 04 24 5d 43 00 00 	movl   $0x435d,(%esp)
     c15:	e8 ca 25 00 00       	call   31e4 <open>
     c1a:	89 45 e8             	mov    %eax,0xffffffe8(%ebp)
  if(fd < 0){
     c1d:	83 7d e8 00          	cmpl   $0x0,0xffffffe8(%ebp)
     c21:	79 19                	jns    c3c <sharedfd+0x11c>
    printf(1, "fstests: cannot open sharedfd for reading\n");
     c23:	c7 44 24 04 b4 43 00 	movl   $0x43b4,0x4(%esp)
     c2a:	00 
     c2b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     c32:	e8 79 27 00 00       	call   33b0 <printf>
    return;
     c37:	e9 c8 00 00 00       	jmp    d04 <sharedfd+0x1e4>
  }
  nc = np = 0;
     c3c:	c7 45 fc 00 00 00 00 	movl   $0x0,0xfffffffc(%ebp)
     c43:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     c46:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
  while((n = read(fd, buf, sizeof(buf))) > 0){
     c49:	eb 35                	jmp    c80 <sharedfd+0x160>
    for(i = 0; i < sizeof(buf); i++){
     c4b:	c7 45 f0 00 00 00 00 	movl   $0x0,0xfffffff0(%ebp)
     c52:	eb 24                	jmp    c78 <sharedfd+0x158>
      if(buf[i] == 'c')
     c54:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
     c57:	0f b6 44 05 de       	movzbl 0xffffffde(%ebp,%eax,1),%eax
     c5c:	3c 63                	cmp    $0x63,%al
     c5e:	75 04                	jne    c64 <sharedfd+0x144>
        nc++;
     c60:	83 45 f8 01          	addl   $0x1,0xfffffff8(%ebp)
      if(buf[i] == 'p')
     c64:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
     c67:	0f b6 44 05 de       	movzbl 0xffffffde(%ebp,%eax,1),%eax
     c6c:	3c 70                	cmp    $0x70,%al
     c6e:	75 04                	jne    c74 <sharedfd+0x154>
        np++;
     c70:	83 45 fc 01          	addl   $0x1,0xfffffffc(%ebp)
     c74:	83 45 f0 01          	addl   $0x1,0xfffffff0(%ebp)
     c78:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
     c7b:	83 f8 09             	cmp    $0x9,%eax
     c7e:	76 d4                	jbe    c54 <sharedfd+0x134>
     c80:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
     c87:	00 
     c88:	8d 45 de             	lea    0xffffffde(%ebp),%eax
     c8b:	89 44 24 04          	mov    %eax,0x4(%esp)
     c8f:	8b 45 e8             	mov    0xffffffe8(%ebp),%eax
     c92:	89 04 24             	mov    %eax,(%esp)
     c95:	e8 22 25 00 00       	call   31bc <read>
     c9a:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
     c9d:	83 7d f4 00          	cmpl   $0x0,0xfffffff4(%ebp)
     ca1:	7f a8                	jg     c4b <sharedfd+0x12b>
    }
  }
  close(fd);
     ca3:	8b 45 e8             	mov    0xffffffe8(%ebp),%eax
     ca6:	89 04 24             	mov    %eax,(%esp)
     ca9:	e8 1e 25 00 00       	call   31cc <close>
  unlink("sharedfd");
     cae:	c7 04 24 5d 43 00 00 	movl   $0x435d,(%esp)
     cb5:	e8 3a 25 00 00       	call   31f4 <unlink>
  if(nc == 10000 && np == 10000)
     cba:	81 7d f8 10 27 00 00 	cmpl   $0x2710,0xfffffff8(%ebp)
     cc1:	75 1f                	jne    ce2 <sharedfd+0x1c2>
     cc3:	81 7d fc 10 27 00 00 	cmpl   $0x2710,0xfffffffc(%ebp)
     cca:	75 16                	jne    ce2 <sharedfd+0x1c2>
    printf(1, "sharedfd ok\n");
     ccc:	c7 44 24 04 df 43 00 	movl   $0x43df,0x4(%esp)
     cd3:	00 
     cd4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     cdb:	e8 d0 26 00 00       	call   33b0 <printf>
     ce0:	eb 22                	jmp    d04 <sharedfd+0x1e4>
  else
    printf(1, "sharedfd oops %d %d\n", nc, np);
     ce2:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     ce5:	89 44 24 0c          	mov    %eax,0xc(%esp)
     ce9:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     cec:	89 44 24 08          	mov    %eax,0x8(%esp)
     cf0:	c7 44 24 04 ec 43 00 	movl   $0x43ec,0x4(%esp)
     cf7:	00 
     cf8:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     cff:	e8 ac 26 00 00       	call   33b0 <printf>
}
     d04:	c9                   	leave  
     d05:	c3                   	ret    
     d06:	8d 76 00             	lea    0x0(%esi),%esi
     d09:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00000d10 <twofiles>:

// two processes write two different files at the same
// time, to test block allocation.
void
twofiles(void)
{
     d10:	55                   	push   %ebp
     d11:	89 e5                	mov    %esp,%ebp
     d13:	83 ec 48             	sub    $0x48,%esp
  int fd, pid, i, j, n, total;
  char *fname;

  printf(1, "twofiles test\n");
     d16:	c7 44 24 04 01 44 00 	movl   $0x4401,0x4(%esp)
     d1d:	00 
     d1e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     d25:	e8 86 26 00 00       	call   33b0 <printf>

  unlink("f1");
     d2a:	c7 04 24 10 44 00 00 	movl   $0x4410,(%esp)
     d31:	e8 be 24 00 00       	call   31f4 <unlink>
  unlink("f2");
     d36:	c7 04 24 13 44 00 00 	movl   $0x4413,(%esp)
     d3d:	e8 b2 24 00 00       	call   31f4 <unlink>

  pid = fork();
     d42:	e8 55 24 00 00       	call   319c <fork>
     d47:	89 45 e8             	mov    %eax,0xffffffe8(%ebp)
  if(pid < 0){
     d4a:	83 7d e8 00          	cmpl   $0x0,0xffffffe8(%ebp)
     d4e:	79 19                	jns    d69 <twofiles+0x59>
    printf(1, "fork failed\n");
     d50:	c7 44 24 04 11 43 00 	movl   $0x4311,0x4(%esp)
     d57:	00 
     d58:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     d5f:	e8 4c 26 00 00       	call   33b0 <printf>
    return;
     d64:	e9 30 02 00 00       	jmp    f99 <twofiles+0x289>
  }

  fname = pid ? "f1" : "f2";
     d69:	83 7d e8 00          	cmpl   $0x0,0xffffffe8(%ebp)
     d6d:	74 09                	je     d78 <twofiles+0x68>
     d6f:	c7 45 cc 10 44 00 00 	movl   $0x4410,0xffffffcc(%ebp)
     d76:	eb 07                	jmp    d7f <twofiles+0x6f>
     d78:	c7 45 cc 13 44 00 00 	movl   $0x4413,0xffffffcc(%ebp)
     d7f:	8b 45 cc             	mov    0xffffffcc(%ebp),%eax
     d82:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
  fd = open(fname, O_CREATE | O_RDWR);
     d85:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
     d8c:	00 
     d8d:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
     d90:	89 04 24             	mov    %eax,(%esp)
     d93:	e8 4c 24 00 00       	call   31e4 <open>
     d98:	89 45 e4             	mov    %eax,0xffffffe4(%ebp)
  if(fd < 0){
     d9b:	83 7d e4 00          	cmpl   $0x0,0xffffffe4(%ebp)
     d9f:	79 19                	jns    dba <twofiles+0xaa>
    printf(1, "create failed\n");
     da1:	c7 44 24 04 16 44 00 	movl   $0x4416,0x4(%esp)
     da8:	00 
     da9:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     db0:	e8 fb 25 00 00       	call   33b0 <printf>
    exit();
     db5:	e8 ea 23 00 00       	call   31a4 <exit>
  }

  memset(buf, pid?'p':'c', 512);
     dba:	83 7d e8 00          	cmpl   $0x0,0xffffffe8(%ebp)
     dbe:	74 09                	je     dc9 <twofiles+0xb9>
     dc0:	c7 45 d0 70 00 00 00 	movl   $0x70,0xffffffd0(%ebp)
     dc7:	eb 07                	jmp    dd0 <twofiles+0xc0>
     dc9:	c7 45 d0 63 00 00 00 	movl   $0x63,0xffffffd0(%ebp)
     dd0:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
     dd7:	00 
     dd8:	8b 45 d0             	mov    0xffffffd0(%ebp),%eax
     ddb:	89 44 24 04          	mov    %eax,0x4(%esp)
     ddf:	c7 04 24 80 52 00 00 	movl   $0x5280,(%esp)
     de6:	e8 e5 21 00 00       	call   2fd0 <memset>
  for(i = 0; i < 12; i++){
     deb:	c7 45 ec 00 00 00 00 	movl   $0x0,0xffffffec(%ebp)
     df2:	eb 4b                	jmp    e3f <twofiles+0x12f>
    if((n = write(fd, buf, 500)) != 500){
     df4:	c7 44 24 08 f4 01 00 	movl   $0x1f4,0x8(%esp)
     dfb:	00 
     dfc:	c7 44 24 04 80 52 00 	movl   $0x5280,0x4(%esp)
     e03:	00 
     e04:	8b 45 e4             	mov    0xffffffe4(%ebp),%eax
     e07:	89 04 24             	mov    %eax,(%esp)
     e0a:	e8 b5 23 00 00       	call   31c4 <write>
     e0f:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
     e12:	81 7d f4 f4 01 00 00 	cmpl   $0x1f4,0xfffffff4(%ebp)
     e19:	74 20                	je     e3b <twofiles+0x12b>
      printf(1, "write failed %d\n", n);
     e1b:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     e1e:	89 44 24 08          	mov    %eax,0x8(%esp)
     e22:	c7 44 24 04 25 44 00 	movl   $0x4425,0x4(%esp)
     e29:	00 
     e2a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     e31:	e8 7a 25 00 00       	call   33b0 <printf>
      exit();
     e36:	e8 69 23 00 00       	call   31a4 <exit>
     e3b:	83 45 ec 01          	addl   $0x1,0xffffffec(%ebp)
     e3f:	83 7d ec 0b          	cmpl   $0xb,0xffffffec(%ebp)
     e43:	7e af                	jle    df4 <twofiles+0xe4>
    }
  }
  close(fd);
     e45:	8b 45 e4             	mov    0xffffffe4(%ebp),%eax
     e48:	89 04 24             	mov    %eax,(%esp)
     e4b:	e8 7c 23 00 00       	call   31cc <close>
  if(pid)
     e50:	83 7d e8 00          	cmpl   $0x0,0xffffffe8(%ebp)
     e54:	74 11                	je     e67 <twofiles+0x157>
    wait();
     e56:	e8 51 23 00 00       	call   31ac <wait>
  else
    exit();

  for(i = 0; i < 2; i++){
     e5b:	c7 45 ec 00 00 00 00 	movl   $0x0,0xffffffec(%ebp)
     e62:	e9 fc 00 00 00       	jmp    f63 <twofiles+0x253>
     e67:	e8 38 23 00 00       	call   31a4 <exit>
    fd = open(i?"f1":"f2", 0);
     e6c:	83 7d ec 00          	cmpl   $0x0,0xffffffec(%ebp)
     e70:	74 09                	je     e7b <twofiles+0x16b>
     e72:	c7 45 d4 10 44 00 00 	movl   $0x4410,0xffffffd4(%ebp)
     e79:	eb 07                	jmp    e82 <twofiles+0x172>
     e7b:	c7 45 d4 13 44 00 00 	movl   $0x4413,0xffffffd4(%ebp)
     e82:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     e89:	00 
     e8a:	8b 45 d4             	mov    0xffffffd4(%ebp),%eax
     e8d:	89 04 24             	mov    %eax,(%esp)
     e90:	e8 4f 23 00 00       	call   31e4 <open>
     e95:	89 45 e4             	mov    %eax,0xffffffe4(%ebp)
    total = 0;
     e98:	c7 45 f8 00 00 00 00 	movl   $0x0,0xfffffff8(%ebp)
    while((n = read(fd, buf, sizeof(buf))) > 0){
     e9f:	eb 62                	jmp    f03 <twofiles+0x1f3>
      for(j = 0; j < n; j++){
     ea1:	c7 45 f0 00 00 00 00 	movl   $0x0,0xfffffff0(%ebp)
     ea8:	eb 4b                	jmp    ef5 <twofiles+0x1e5>
        if(buf[j] != (i?'p':'c')){
     eaa:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
     ead:	0f b6 80 80 52 00 00 	movzbl 0x5280(%eax),%eax
     eb4:	0f be c0             	movsbl %al,%eax
     eb7:	89 45 d8             	mov    %eax,0xffffffd8(%ebp)
     eba:	83 7d ec 00          	cmpl   $0x0,0xffffffec(%ebp)
     ebe:	74 09                	je     ec9 <twofiles+0x1b9>
     ec0:	c7 45 dc 70 00 00 00 	movl   $0x70,0xffffffdc(%ebp)
     ec7:	eb 07                	jmp    ed0 <twofiles+0x1c0>
     ec9:	c7 45 dc 63 00 00 00 	movl   $0x63,0xffffffdc(%ebp)
     ed0:	8b 45 dc             	mov    0xffffffdc(%ebp),%eax
     ed3:	39 45 d8             	cmp    %eax,0xffffffd8(%ebp)
     ed6:	74 19                	je     ef1 <twofiles+0x1e1>
          printf(1, "wrong char\n");
     ed8:	c7 44 24 04 36 44 00 	movl   $0x4436,0x4(%esp)
     edf:	00 
     ee0:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     ee7:	e8 c4 24 00 00       	call   33b0 <printf>
          exit();
     eec:	e8 b3 22 00 00       	call   31a4 <exit>
     ef1:	83 45 f0 01          	addl   $0x1,0xfffffff0(%ebp)
     ef5:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
     ef8:	3b 45 f4             	cmp    0xfffffff4(%ebp),%eax
     efb:	7c ad                	jl     eaa <twofiles+0x19a>
        }
      }
      total += n;
     efd:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
     f00:	01 45 f8             	add    %eax,0xfffffff8(%ebp)
     f03:	c7 44 24 08 00 08 00 	movl   $0x800,0x8(%esp)
     f0a:	00 
     f0b:	c7 44 24 04 80 52 00 	movl   $0x5280,0x4(%esp)
     f12:	00 
     f13:	8b 45 e4             	mov    0xffffffe4(%ebp),%eax
     f16:	89 04 24             	mov    %eax,(%esp)
     f19:	e8 9e 22 00 00       	call   31bc <read>
     f1e:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
     f21:	83 7d f4 00          	cmpl   $0x0,0xfffffff4(%ebp)
     f25:	0f 8f 76 ff ff ff    	jg     ea1 <twofiles+0x191>
    }
    close(fd);
     f2b:	8b 45 e4             	mov    0xffffffe4(%ebp),%eax
     f2e:	89 04 24             	mov    %eax,(%esp)
     f31:	e8 96 22 00 00       	call   31cc <close>
    if(total != 12*500){
     f36:	81 7d f8 70 17 00 00 	cmpl   $0x1770,0xfffffff8(%ebp)
     f3d:	74 20                	je     f5f <twofiles+0x24f>
      printf(1, "wrong length %d\n", total);
     f3f:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
     f42:	89 44 24 08          	mov    %eax,0x8(%esp)
     f46:	c7 44 24 04 42 44 00 	movl   $0x4442,0x4(%esp)
     f4d:	00 
     f4e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     f55:	e8 56 24 00 00       	call   33b0 <printf>
      exit();
     f5a:	e8 45 22 00 00       	call   31a4 <exit>
     f5f:	83 45 ec 01          	addl   $0x1,0xffffffec(%ebp)
     f63:	83 7d ec 01          	cmpl   $0x1,0xffffffec(%ebp)
     f67:	0f 8e ff fe ff ff    	jle    e6c <twofiles+0x15c>
    }
  }

  unlink("f1");
     f6d:	c7 04 24 10 44 00 00 	movl   $0x4410,(%esp)
     f74:	e8 7b 22 00 00       	call   31f4 <unlink>
  unlink("f2");
     f79:	c7 04 24 13 44 00 00 	movl   $0x4413,(%esp)
     f80:	e8 6f 22 00 00       	call   31f4 <unlink>

  printf(1, "twofiles ok\n");
     f85:	c7 44 24 04 53 44 00 	movl   $0x4453,0x4(%esp)
     f8c:	00 
     f8d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     f94:	e8 17 24 00 00       	call   33b0 <printf>
}
     f99:	c9                   	leave  
     f9a:	c3                   	ret    
     f9b:	90                   	nop    
     f9c:	8d 74 26 00          	lea    0x0(%esi),%esi

00000fa0 <createdelete>:

// two processes create and delete different files in same directory
void
createdelete(void)
{
     fa0:	55                   	push   %ebp
     fa1:	89 e5                	mov    %esp,%ebp
     fa3:	83 ec 48             	sub    $0x48,%esp
  enum { N = 20 };
  int pid, i, fd;
  char name[32];

  printf(1, "createdelete test\n");
     fa6:	c7 44 24 04 60 44 00 	movl   $0x4460,0x4(%esp)
     fad:	00 
     fae:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     fb5:	e8 f6 23 00 00       	call   33b0 <printf>
  pid = fork();
     fba:	e8 dd 21 00 00       	call   319c <fork>
     fbf:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
  if(pid < 0){
     fc2:	83 7d f4 00          	cmpl   $0x0,0xfffffff4(%ebp)
     fc6:	79 19                	jns    fe1 <createdelete+0x41>
    printf(1, "fork failed\n");
     fc8:	c7 44 24 04 11 43 00 	movl   $0x4311,0x4(%esp)
     fcf:	00 
     fd0:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     fd7:	e8 d4 23 00 00       	call   33b0 <printf>
    exit();
     fdc:	e8 c3 21 00 00       	call   31a4 <exit>
  }

  name[0] = pid ? 'p' : 'c';
     fe1:	83 7d f4 00          	cmpl   $0x0,0xfffffff4(%ebp)
     fe5:	74 06                	je     fed <createdelete+0x4d>
     fe7:	c6 45 cf 70          	movb   $0x70,0xffffffcf(%ebp)
     feb:	eb 04                	jmp    ff1 <createdelete+0x51>
     fed:	c6 45 cf 63          	movb   $0x63,0xffffffcf(%ebp)
     ff1:	0f b6 45 cf          	movzbl 0xffffffcf(%ebp),%eax
     ff5:	88 45 d4             	mov    %al,0xffffffd4(%ebp)
  name[2] = '\0';
     ff8:	c6 45 d6 00          	movb   $0x0,0xffffffd6(%ebp)
  for(i = 0; i < N; i++){
     ffc:	c7 45 f8 00 00 00 00 	movl   $0x0,0xfffffff8(%ebp)
    1003:	e9 97 00 00 00       	jmp    109f <createdelete+0xff>
    name[1] = '0' + i;
    1008:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
    100b:	83 c0 30             	add    $0x30,%eax
    100e:	88 45 d5             	mov    %al,0xffffffd5(%ebp)
    fd = open(name, O_CREATE | O_RDWR);
    1011:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    1018:	00 
    1019:	8d 45 d4             	lea    0xffffffd4(%ebp),%eax
    101c:	89 04 24             	mov    %eax,(%esp)
    101f:	e8 c0 21 00 00       	call   31e4 <open>
    1024:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
    if(fd < 0){
    1027:	83 7d fc 00          	cmpl   $0x0,0xfffffffc(%ebp)
    102b:	79 19                	jns    1046 <createdelete+0xa6>
      printf(1, "create failed\n");
    102d:	c7 44 24 04 16 44 00 	movl   $0x4416,0x4(%esp)
    1034:	00 
    1035:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    103c:	e8 6f 23 00 00       	call   33b0 <printf>
      exit();
    1041:	e8 5e 21 00 00       	call   31a4 <exit>
    }
    close(fd);
    1046:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
    1049:	89 04 24             	mov    %eax,(%esp)
    104c:	e8 7b 21 00 00       	call   31cc <close>
    if(i > 0 && (i % 2 ) == 0){
    1051:	83 7d f8 00          	cmpl   $0x0,0xfffffff8(%ebp)
    1055:	7e 44                	jle    109b <createdelete+0xfb>
    1057:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
    105a:	83 e0 01             	and    $0x1,%eax
    105d:	85 c0                	test   %eax,%eax
    105f:	75 3a                	jne    109b <createdelete+0xfb>
      name[1] = '0' + (i / 2);
    1061:	8b 55 f8             	mov    0xfffffff8(%ebp),%edx
    1064:	89 d0                	mov    %edx,%eax
    1066:	c1 e8 1f             	shr    $0x1f,%eax
    1069:	01 d0                	add    %edx,%eax
    106b:	d1 f8                	sar    %eax
    106d:	83 c0 30             	add    $0x30,%eax
    1070:	88 45 d5             	mov    %al,0xffffffd5(%ebp)
      if(unlink(name) < 0){
    1073:	8d 45 d4             	lea    0xffffffd4(%ebp),%eax
    1076:	89 04 24             	mov    %eax,(%esp)
    1079:	e8 76 21 00 00       	call   31f4 <unlink>
    107e:	85 c0                	test   %eax,%eax
    1080:	79 19                	jns    109b <createdelete+0xfb>
        printf(1, "unlink failed\n");
    1082:	c7 44 24 04 73 44 00 	movl   $0x4473,0x4(%esp)
    1089:	00 
    108a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1091:	e8 1a 23 00 00       	call   33b0 <printf>
        exit();
    1096:	e8 09 21 00 00       	call   31a4 <exit>
    109b:	83 45 f8 01          	addl   $0x1,0xfffffff8(%ebp)
    109f:	83 7d f8 13          	cmpl   $0x13,0xfffffff8(%ebp)
    10a3:	0f 8e 5f ff ff ff    	jle    1008 <createdelete+0x68>
      }
    }
  }

  if(pid==0)
    10a9:	83 7d f4 00          	cmpl   $0x0,0xfffffff4(%ebp)
    10ad:	75 05                	jne    10b4 <createdelete+0x114>
    exit();
    10af:	e8 f0 20 00 00       	call   31a4 <exit>
  else
    wait();
    10b4:	e8 f3 20 00 00       	call   31ac <wait>

  for(i = 0; i < N; i++){
    10b9:	c7 45 f8 00 00 00 00 	movl   $0x0,0xfffffff8(%ebp)
    10c0:	e9 34 01 00 00       	jmp    11f9 <createdelete+0x259>
    name[0] = 'p';
    10c5:	c6 45 d4 70          	movb   $0x70,0xffffffd4(%ebp)
    name[1] = '0' + i;
    10c9:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
    10cc:	83 c0 30             	add    $0x30,%eax
    10cf:	88 45 d5             	mov    %al,0xffffffd5(%ebp)
    fd = open(name, 0);
    10d2:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    10d9:	00 
    10da:	8d 45 d4             	lea    0xffffffd4(%ebp),%eax
    10dd:	89 04 24             	mov    %eax,(%esp)
    10e0:	e8 ff 20 00 00       	call   31e4 <open>
    10e5:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
    if((i == 0 || i >= N/2) && fd < 0){
    10e8:	83 7d f8 00          	cmpl   $0x0,0xfffffff8(%ebp)
    10ec:	74 06                	je     10f4 <createdelete+0x154>
    10ee:	83 7d f8 09          	cmpl   $0x9,0xfffffff8(%ebp)
    10f2:	7e 26                	jle    111a <createdelete+0x17a>
    10f4:	83 7d fc 00          	cmpl   $0x0,0xfffffffc(%ebp)
    10f8:	79 20                	jns    111a <createdelete+0x17a>
      printf(1, "oops createdelete %s didn't exist\n", name);
    10fa:	8d 45 d4             	lea    0xffffffd4(%ebp),%eax
    10fd:	89 44 24 08          	mov    %eax,0x8(%esp)
    1101:	c7 44 24 04 84 44 00 	movl   $0x4484,0x4(%esp)
    1108:	00 
    1109:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1110:	e8 9b 22 00 00       	call   33b0 <printf>
      exit();
    1115:	e8 8a 20 00 00       	call   31a4 <exit>
    } else if((i >= 1 && i < N/2) && fd >= 0){
    111a:	83 7d f8 00          	cmpl   $0x0,0xfffffff8(%ebp)
    111e:	7e 2c                	jle    114c <createdelete+0x1ac>
    1120:	83 7d f8 09          	cmpl   $0x9,0xfffffff8(%ebp)
    1124:	7f 26                	jg     114c <createdelete+0x1ac>
    1126:	83 7d fc 00          	cmpl   $0x0,0xfffffffc(%ebp)
    112a:	78 20                	js     114c <createdelete+0x1ac>
      printf(1, "oops createdelete %s did exist\n", name);
    112c:	8d 45 d4             	lea    0xffffffd4(%ebp),%eax
    112f:	89 44 24 08          	mov    %eax,0x8(%esp)
    1133:	c7 44 24 04 a8 44 00 	movl   $0x44a8,0x4(%esp)
    113a:	00 
    113b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1142:	e8 69 22 00 00       	call   33b0 <printf>
      exit();
    1147:	e8 58 20 00 00       	call   31a4 <exit>
    }
    if(fd >= 0)
    114c:	83 7d fc 00          	cmpl   $0x0,0xfffffffc(%ebp)
    1150:	78 0b                	js     115d <createdelete+0x1bd>
      close(fd);
    1152:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
    1155:	89 04 24             	mov    %eax,(%esp)
    1158:	e8 6f 20 00 00       	call   31cc <close>

    name[0] = 'c';
    115d:	c6 45 d4 63          	movb   $0x63,0xffffffd4(%ebp)
    name[1] = '0' + i;
    1161:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
    1164:	83 c0 30             	add    $0x30,%eax
    1167:	88 45 d5             	mov    %al,0xffffffd5(%ebp)
    fd = open(name, 0);
    116a:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1171:	00 
    1172:	8d 45 d4             	lea    0xffffffd4(%ebp),%eax
    1175:	89 04 24             	mov    %eax,(%esp)
    1178:	e8 67 20 00 00       	call   31e4 <open>
    117d:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
    if((i == 0 || i >= N/2) && fd < 0){
    1180:	83 7d f8 00          	cmpl   $0x0,0xfffffff8(%ebp)
    1184:	74 06                	je     118c <createdelete+0x1ec>
    1186:	83 7d f8 09          	cmpl   $0x9,0xfffffff8(%ebp)
    118a:	7e 26                	jle    11b2 <createdelete+0x212>
    118c:	83 7d fc 00          	cmpl   $0x0,0xfffffffc(%ebp)
    1190:	79 20                	jns    11b2 <createdelete+0x212>
      printf(1, "oops createdelete %s didn't exist\n", name);
    1192:	8d 45 d4             	lea    0xffffffd4(%ebp),%eax
    1195:	89 44 24 08          	mov    %eax,0x8(%esp)
    1199:	c7 44 24 04 84 44 00 	movl   $0x4484,0x4(%esp)
    11a0:	00 
    11a1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    11a8:	e8 03 22 00 00       	call   33b0 <printf>
      exit();
    11ad:	e8 f2 1f 00 00       	call   31a4 <exit>
    } else if((i >= 1 && i < N/2) && fd >= 0){
    11b2:	83 7d f8 00          	cmpl   $0x0,0xfffffff8(%ebp)
    11b6:	7e 2c                	jle    11e4 <createdelete+0x244>
    11b8:	83 7d f8 09          	cmpl   $0x9,0xfffffff8(%ebp)
    11bc:	7f 26                	jg     11e4 <createdelete+0x244>
    11be:	83 7d fc 00          	cmpl   $0x0,0xfffffffc(%ebp)
    11c2:	78 20                	js     11e4 <createdelete+0x244>
      printf(1, "oops createdelete %s did exist\n", name);
    11c4:	8d 45 d4             	lea    0xffffffd4(%ebp),%eax
    11c7:	89 44 24 08          	mov    %eax,0x8(%esp)
    11cb:	c7 44 24 04 a8 44 00 	movl   $0x44a8,0x4(%esp)
    11d2:	00 
    11d3:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    11da:	e8 d1 21 00 00       	call   33b0 <printf>
      exit();
    11df:	e8 c0 1f 00 00       	call   31a4 <exit>
    }
    if(fd >= 0)
    11e4:	83 7d fc 00          	cmpl   $0x0,0xfffffffc(%ebp)
    11e8:	78 0b                	js     11f5 <createdelete+0x255>
      close(fd);
    11ea:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
    11ed:	89 04 24             	mov    %eax,(%esp)
    11f0:	e8 d7 1f 00 00       	call   31cc <close>
    11f5:	83 45 f8 01          	addl   $0x1,0xfffffff8(%ebp)
    11f9:	83 7d f8 13          	cmpl   $0x13,0xfffffff8(%ebp)
    11fd:	0f 8e c2 fe ff ff    	jle    10c5 <createdelete+0x125>
  }

  for(i = 0; i < N; i++){
    1203:	c7 45 f8 00 00 00 00 	movl   $0x0,0xfffffff8(%ebp)
    120a:	eb 2b                	jmp    1237 <createdelete+0x297>
    name[0] = 'p';
    120c:	c6 45 d4 70          	movb   $0x70,0xffffffd4(%ebp)
    name[1] = '0' + i;
    1210:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
    1213:	83 c0 30             	add    $0x30,%eax
    1216:	88 45 d5             	mov    %al,0xffffffd5(%ebp)
    unlink(name);
    1219:	8d 45 d4             	lea    0xffffffd4(%ebp),%eax
    121c:	89 04 24             	mov    %eax,(%esp)
    121f:	e8 d0 1f 00 00       	call   31f4 <unlink>
    name[0] = 'c';
    1224:	c6 45 d4 63          	movb   $0x63,0xffffffd4(%ebp)
    unlink(name);
    1228:	8d 45 d4             	lea    0xffffffd4(%ebp),%eax
    122b:	89 04 24             	mov    %eax,(%esp)
    122e:	e8 c1 1f 00 00       	call   31f4 <unlink>
    1233:	83 45 f8 01          	addl   $0x1,0xfffffff8(%ebp)
    1237:	83 7d f8 13          	cmpl   $0x13,0xfffffff8(%ebp)
    123b:	7e cf                	jle    120c <createdelete+0x26c>
  }

  printf(1, "createdelete ok\n");
    123d:	c7 44 24 04 c8 44 00 	movl   $0x44c8,0x4(%esp)
    1244:	00 
    1245:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    124c:	e8 5f 21 00 00       	call   33b0 <printf>
}
    1251:	c9                   	leave  
    1252:	c3                   	ret    
    1253:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    1259:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00001260 <unlinkread>:

// can I unlink a file and still read it?
void
unlinkread(void)
{
    1260:	55                   	push   %ebp
    1261:	89 e5                	mov    %esp,%ebp
    1263:	83 ec 28             	sub    $0x28,%esp
  int fd, fd1;

  printf(1, "unlinkread test\n");
    1266:	c7 44 24 04 d9 44 00 	movl   $0x44d9,0x4(%esp)
    126d:	00 
    126e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1275:	e8 36 21 00 00       	call   33b0 <printf>
  fd = open("unlinkread", O_CREATE | O_RDWR);
    127a:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    1281:	00 
    1282:	c7 04 24 ea 44 00 00 	movl   $0x44ea,(%esp)
    1289:	e8 56 1f 00 00       	call   31e4 <open>
    128e:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
  if(fd < 0){
    1291:	83 7d f8 00          	cmpl   $0x0,0xfffffff8(%ebp)
    1295:	79 19                	jns    12b0 <unlinkread+0x50>
    printf(1, "create unlinkread failed\n");
    1297:	c7 44 24 04 f5 44 00 	movl   $0x44f5,0x4(%esp)
    129e:	00 
    129f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    12a6:	e8 05 21 00 00       	call   33b0 <printf>
    exit();
    12ab:	e8 f4 1e 00 00       	call   31a4 <exit>
  }
  write(fd, "hello", 5);
    12b0:	c7 44 24 08 05 00 00 	movl   $0x5,0x8(%esp)
    12b7:	00 
    12b8:	c7 44 24 04 0f 45 00 	movl   $0x450f,0x4(%esp)
    12bf:	00 
    12c0:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
    12c3:	89 04 24             	mov    %eax,(%esp)
    12c6:	e8 f9 1e 00 00       	call   31c4 <write>
  close(fd);
    12cb:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
    12ce:	89 04 24             	mov    %eax,(%esp)
    12d1:	e8 f6 1e 00 00       	call   31cc <close>

  fd = open("unlinkread", O_RDWR);
    12d6:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
    12dd:	00 
    12de:	c7 04 24 ea 44 00 00 	movl   $0x44ea,(%esp)
    12e5:	e8 fa 1e 00 00       	call   31e4 <open>
    12ea:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
  if(fd < 0){
    12ed:	83 7d f8 00          	cmpl   $0x0,0xfffffff8(%ebp)
    12f1:	79 19                	jns    130c <unlinkread+0xac>
    printf(1, "open unlinkread failed\n");
    12f3:	c7 44 24 04 15 45 00 	movl   $0x4515,0x4(%esp)
    12fa:	00 
    12fb:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1302:	e8 a9 20 00 00       	call   33b0 <printf>
    exit();
    1307:	e8 98 1e 00 00       	call   31a4 <exit>
  }
  if(unlink("unlinkread") != 0){
    130c:	c7 04 24 ea 44 00 00 	movl   $0x44ea,(%esp)
    1313:	e8 dc 1e 00 00       	call   31f4 <unlink>
    1318:	85 c0                	test   %eax,%eax
    131a:	74 19                	je     1335 <unlinkread+0xd5>
    printf(1, "unlink unlinkread failed\n");
    131c:	c7 44 24 04 2d 45 00 	movl   $0x452d,0x4(%esp)
    1323:	00 
    1324:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    132b:	e8 80 20 00 00       	call   33b0 <printf>
    exit();
    1330:	e8 6f 1e 00 00       	call   31a4 <exit>
  }

  fd1 = open("unlinkread", O_CREATE | O_RDWR);
    1335:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    133c:	00 
    133d:	c7 04 24 ea 44 00 00 	movl   $0x44ea,(%esp)
    1344:	e8 9b 1e 00 00       	call   31e4 <open>
    1349:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
  write(fd1, "yyy", 3);
    134c:	c7 44 24 08 03 00 00 	movl   $0x3,0x8(%esp)
    1353:	00 
    1354:	c7 44 24 04 47 45 00 	movl   $0x4547,0x4(%esp)
    135b:	00 
    135c:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
    135f:	89 04 24             	mov    %eax,(%esp)
    1362:	e8 5d 1e 00 00       	call   31c4 <write>
  close(fd1);
    1367:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
    136a:	89 04 24             	mov    %eax,(%esp)
    136d:	e8 5a 1e 00 00       	call   31cc <close>

  if(read(fd, buf, sizeof(buf)) != 5){
    1372:	c7 44 24 08 00 08 00 	movl   $0x800,0x8(%esp)
    1379:	00 
    137a:	c7 44 24 04 80 52 00 	movl   $0x5280,0x4(%esp)
    1381:	00 
    1382:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
    1385:	89 04 24             	mov    %eax,(%esp)
    1388:	e8 2f 1e 00 00       	call   31bc <read>
    138d:	83 f8 05             	cmp    $0x5,%eax
    1390:	74 19                	je     13ab <unlinkread+0x14b>
    printf(1, "unlinkread read failed");
    1392:	c7 44 24 04 4b 45 00 	movl   $0x454b,0x4(%esp)
    1399:	00 
    139a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    13a1:	e8 0a 20 00 00       	call   33b0 <printf>
    exit();
    13a6:	e8 f9 1d 00 00       	call   31a4 <exit>
  }
  if(buf[0] != 'h'){
    13ab:	0f b6 05 80 52 00 00 	movzbl 0x5280,%eax
    13b2:	3c 68                	cmp    $0x68,%al
    13b4:	74 19                	je     13cf <unlinkread+0x16f>
    printf(1, "unlinkread wrong data\n");
    13b6:	c7 44 24 04 62 45 00 	movl   $0x4562,0x4(%esp)
    13bd:	00 
    13be:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    13c5:	e8 e6 1f 00 00       	call   33b0 <printf>
    exit();
    13ca:	e8 d5 1d 00 00       	call   31a4 <exit>
  }
  if(write(fd, buf, 10) != 10){
    13cf:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
    13d6:	00 
    13d7:	c7 44 24 04 80 52 00 	movl   $0x5280,0x4(%esp)
    13de:	00 
    13df:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
    13e2:	89 04 24             	mov    %eax,(%esp)
    13e5:	e8 da 1d 00 00       	call   31c4 <write>
    13ea:	83 f8 0a             	cmp    $0xa,%eax
    13ed:	74 19                	je     1408 <unlinkread+0x1a8>
    printf(1, "unlinkread write failed\n");
    13ef:	c7 44 24 04 79 45 00 	movl   $0x4579,0x4(%esp)
    13f6:	00 
    13f7:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    13fe:	e8 ad 1f 00 00       	call   33b0 <printf>
    exit();
    1403:	e8 9c 1d 00 00       	call   31a4 <exit>
  }
  close(fd);
    1408:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
    140b:	89 04 24             	mov    %eax,(%esp)
    140e:	e8 b9 1d 00 00       	call   31cc <close>
  unlink("unlinkread");
    1413:	c7 04 24 ea 44 00 00 	movl   $0x44ea,(%esp)
    141a:	e8 d5 1d 00 00       	call   31f4 <unlink>
  printf(1, "unlinkread ok\n");
    141f:	c7 44 24 04 92 45 00 	movl   $0x4592,0x4(%esp)
    1426:	00 
    1427:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    142e:	e8 7d 1f 00 00       	call   33b0 <printf>
}
    1433:	c9                   	leave  
    1434:	c3                   	ret    
    1435:	8d 74 26 00          	lea    0x0(%esi),%esi
    1439:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00001440 <linktest>:

void
linktest(void)
{
    1440:	55                   	push   %ebp
    1441:	89 e5                	mov    %esp,%ebp
    1443:	83 ec 28             	sub    $0x28,%esp
  int fd;

  printf(1, "linktest\n");
    1446:	c7 44 24 04 a1 45 00 	movl   $0x45a1,0x4(%esp)
    144d:	00 
    144e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1455:	e8 56 1f 00 00       	call   33b0 <printf>

  unlink("lf1");
    145a:	c7 04 24 ab 45 00 00 	movl   $0x45ab,(%esp)
    1461:	e8 8e 1d 00 00       	call   31f4 <unlink>
  unlink("lf2");
    1466:	c7 04 24 af 45 00 00 	movl   $0x45af,(%esp)
    146d:	e8 82 1d 00 00       	call   31f4 <unlink>

  fd = open("lf1", O_CREATE|O_RDWR);
    1472:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    1479:	00 
    147a:	c7 04 24 ab 45 00 00 	movl   $0x45ab,(%esp)
    1481:	e8 5e 1d 00 00       	call   31e4 <open>
    1486:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
  if(fd < 0){
    1489:	83 7d fc 00          	cmpl   $0x0,0xfffffffc(%ebp)
    148d:	79 19                	jns    14a8 <linktest+0x68>
    printf(1, "create lf1 failed\n");
    148f:	c7 44 24 04 b3 45 00 	movl   $0x45b3,0x4(%esp)
    1496:	00 
    1497:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    149e:	e8 0d 1f 00 00       	call   33b0 <printf>
    exit();
    14a3:	e8 fc 1c 00 00       	call   31a4 <exit>
  }
  if(write(fd, "hello", 5) != 5){
    14a8:	c7 44 24 08 05 00 00 	movl   $0x5,0x8(%esp)
    14af:	00 
    14b0:	c7 44 24 04 0f 45 00 	movl   $0x450f,0x4(%esp)
    14b7:	00 
    14b8:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
    14bb:	89 04 24             	mov    %eax,(%esp)
    14be:	e8 01 1d 00 00       	call   31c4 <write>
    14c3:	83 f8 05             	cmp    $0x5,%eax
    14c6:	74 19                	je     14e1 <linktest+0xa1>
    printf(1, "write lf1 failed\n");
    14c8:	c7 44 24 04 c6 45 00 	movl   $0x45c6,0x4(%esp)
    14cf:	00 
    14d0:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    14d7:	e8 d4 1e 00 00       	call   33b0 <printf>
    exit();
    14dc:	e8 c3 1c 00 00       	call   31a4 <exit>
  }
  close(fd);
    14e1:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
    14e4:	89 04 24             	mov    %eax,(%esp)
    14e7:	e8 e0 1c 00 00       	call   31cc <close>

  if(link("lf1", "lf2") < 0){
    14ec:	c7 44 24 04 af 45 00 	movl   $0x45af,0x4(%esp)
    14f3:	00 
    14f4:	c7 04 24 ab 45 00 00 	movl   $0x45ab,(%esp)
    14fb:	e8 04 1d 00 00       	call   3204 <link>
    1500:	85 c0                	test   %eax,%eax
    1502:	79 19                	jns    151d <linktest+0xdd>
    printf(1, "link lf1 lf2 failed\n");
    1504:	c7 44 24 04 d8 45 00 	movl   $0x45d8,0x4(%esp)
    150b:	00 
    150c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1513:	e8 98 1e 00 00       	call   33b0 <printf>
    exit();
    1518:	e8 87 1c 00 00       	call   31a4 <exit>
  }
  unlink("lf1");
    151d:	c7 04 24 ab 45 00 00 	movl   $0x45ab,(%esp)
    1524:	e8 cb 1c 00 00       	call   31f4 <unlink>

  if(open("lf1", 0) >= 0){
    1529:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1530:	00 
    1531:	c7 04 24 ab 45 00 00 	movl   $0x45ab,(%esp)
    1538:	e8 a7 1c 00 00       	call   31e4 <open>
    153d:	85 c0                	test   %eax,%eax
    153f:	78 19                	js     155a <linktest+0x11a>
    printf(1, "unlinked lf1 but it is still there!\n");
    1541:	c7 44 24 04 f0 45 00 	movl   $0x45f0,0x4(%esp)
    1548:	00 
    1549:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1550:	e8 5b 1e 00 00       	call   33b0 <printf>
    exit();
    1555:	e8 4a 1c 00 00       	call   31a4 <exit>
  }

  fd = open("lf2", 0);
    155a:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1561:	00 
    1562:	c7 04 24 af 45 00 00 	movl   $0x45af,(%esp)
    1569:	e8 76 1c 00 00       	call   31e4 <open>
    156e:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
  if(fd < 0){
    1571:	83 7d fc 00          	cmpl   $0x0,0xfffffffc(%ebp)
    1575:	79 19                	jns    1590 <linktest+0x150>
    printf(1, "open lf2 failed\n");
    1577:	c7 44 24 04 15 46 00 	movl   $0x4615,0x4(%esp)
    157e:	00 
    157f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1586:	e8 25 1e 00 00       	call   33b0 <printf>
    exit();
    158b:	e8 14 1c 00 00       	call   31a4 <exit>
  }
  if(read(fd, buf, sizeof(buf)) != 5){
    1590:	c7 44 24 08 00 08 00 	movl   $0x800,0x8(%esp)
    1597:	00 
    1598:	c7 44 24 04 80 52 00 	movl   $0x5280,0x4(%esp)
    159f:	00 
    15a0:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
    15a3:	89 04 24             	mov    %eax,(%esp)
    15a6:	e8 11 1c 00 00       	call   31bc <read>
    15ab:	83 f8 05             	cmp    $0x5,%eax
    15ae:	74 19                	je     15c9 <linktest+0x189>
    printf(1, "read lf2 failed\n");
    15b0:	c7 44 24 04 26 46 00 	movl   $0x4626,0x4(%esp)
    15b7:	00 
    15b8:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    15bf:	e8 ec 1d 00 00       	call   33b0 <printf>
    exit();
    15c4:	e8 db 1b 00 00       	call   31a4 <exit>
  }
  close(fd);
    15c9:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
    15cc:	89 04 24             	mov    %eax,(%esp)
    15cf:	e8 f8 1b 00 00       	call   31cc <close>

  if(link("lf2", "lf2") >= 0){
    15d4:	c7 44 24 04 af 45 00 	movl   $0x45af,0x4(%esp)
    15db:	00 
    15dc:	c7 04 24 af 45 00 00 	movl   $0x45af,(%esp)
    15e3:	e8 1c 1c 00 00       	call   3204 <link>
    15e8:	85 c0                	test   %eax,%eax
    15ea:	78 19                	js     1605 <linktest+0x1c5>
    printf(1, "link lf2 lf2 succeeded! oops\n");
    15ec:	c7 44 24 04 37 46 00 	movl   $0x4637,0x4(%esp)
    15f3:	00 
    15f4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    15fb:	e8 b0 1d 00 00       	call   33b0 <printf>
    exit();
    1600:	e8 9f 1b 00 00       	call   31a4 <exit>
  }

  unlink("lf2");
    1605:	c7 04 24 af 45 00 00 	movl   $0x45af,(%esp)
    160c:	e8 e3 1b 00 00       	call   31f4 <unlink>
  if(link("lf2", "lf1") >= 0){
    1611:	c7 44 24 04 ab 45 00 	movl   $0x45ab,0x4(%esp)
    1618:	00 
    1619:	c7 04 24 af 45 00 00 	movl   $0x45af,(%esp)
    1620:	e8 df 1b 00 00       	call   3204 <link>
    1625:	85 c0                	test   %eax,%eax
    1627:	78 19                	js     1642 <linktest+0x202>
    printf(1, "link non-existant succeeded! oops\n");
    1629:	c7 44 24 04 58 46 00 	movl   $0x4658,0x4(%esp)
    1630:	00 
    1631:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1638:	e8 73 1d 00 00       	call   33b0 <printf>
    exit();
    163d:	e8 62 1b 00 00       	call   31a4 <exit>
  }

  if(link(".", "lf1") >= 0){
    1642:	c7 44 24 04 ab 45 00 	movl   $0x45ab,0x4(%esp)
    1649:	00 
    164a:	c7 04 24 7b 46 00 00 	movl   $0x467b,(%esp)
    1651:	e8 ae 1b 00 00       	call   3204 <link>
    1656:	85 c0                	test   %eax,%eax
    1658:	78 19                	js     1673 <linktest+0x233>
    printf(1, "link . lf1 succeeded! oops\n");
    165a:	c7 44 24 04 7d 46 00 	movl   $0x467d,0x4(%esp)
    1661:	00 
    1662:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1669:	e8 42 1d 00 00       	call   33b0 <printf>
    exit();
    166e:	e8 31 1b 00 00       	call   31a4 <exit>
  }

  printf(1, "linktest ok\n");
    1673:	c7 44 24 04 99 46 00 	movl   $0x4699,0x4(%esp)
    167a:	00 
    167b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1682:	e8 29 1d 00 00       	call   33b0 <printf>
}
    1687:	c9                   	leave  
    1688:	c3                   	ret    
    1689:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi

00001690 <concreate>:

// test concurrent create and unlink of the same file
void
concreate(void)
{
    1690:	55                   	push   %ebp
    1691:	89 e5                	mov    %esp,%ebp
    1693:	53                   	push   %ebx
    1694:	83 ec 74             	sub    $0x74,%esp
  char file[3];
  int i, pid, n, fd;
  char fa[40];
  struct {
    ushort inum;
    char name[14];
  } de;

  printf(1, "concreate test\n");
    1697:	c7 44 24 04 a6 46 00 	movl   $0x46a6,0x4(%esp)
    169e:	00 
    169f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    16a6:	e8 05 1d 00 00       	call   33b0 <printf>
  file[0] = 'C';
    16ab:	c6 45 e9 43          	movb   $0x43,0xffffffe9(%ebp)
  file[2] = '\0';
    16af:	c6 45 eb 00          	movb   $0x0,0xffffffeb(%ebp)
  for(i = 0; i < 40; i++){
    16b3:	c7 45 ec 00 00 00 00 	movl   $0x0,0xffffffec(%ebp)
    16ba:	e9 1b 01 00 00       	jmp    17da <concreate+0x14a>
    file[1] = '0' + i;
    16bf:	8b 45 ec             	mov    0xffffffec(%ebp),%eax
    16c2:	83 c0 30             	add    $0x30,%eax
    16c5:	88 45 ea             	mov    %al,0xffffffea(%ebp)
    unlink(file);
    16c8:	8d 45 e9             	lea    0xffffffe9(%ebp),%eax
    16cb:	89 04 24             	mov    %eax,(%esp)
    16ce:	e8 21 1b 00 00       	call   31f4 <unlink>
    pid = fork();
    16d3:	e8 c4 1a 00 00       	call   319c <fork>
    16d8:	89 45 f0             	mov    %eax,0xfffffff0(%ebp)
    if(pid && (i % 3) == 1){
    16db:	83 7d f0 00          	cmpl   $0x0,0xfffffff0(%ebp)
    16df:	74 50                	je     1731 <concreate+0xa1>
    16e1:	8b 45 ec             	mov    0xffffffec(%ebp),%eax
    16e4:	89 45 98             	mov    %eax,0xffffff98(%ebp)
    16e7:	c7 45 94 56 55 55 55 	movl   $0x55555556,0xffffff94(%ebp)
    16ee:	8b 45 94             	mov    0xffffff94(%ebp),%eax
    16f1:	f7 6d 98             	imull  0xffffff98(%ebp)
    16f4:	89 d1                	mov    %edx,%ecx
    16f6:	8b 45 98             	mov    0xffffff98(%ebp),%eax
    16f9:	c1 f8 1f             	sar    $0x1f,%eax
    16fc:	89 cb                	mov    %ecx,%ebx
    16fe:	29 c3                	sub    %eax,%ebx
    1700:	89 5d 9c             	mov    %ebx,0xffffff9c(%ebp)
    1703:	8b 45 9c             	mov    0xffffff9c(%ebp),%eax
    1706:	01 c0                	add    %eax,%eax
    1708:	03 45 9c             	add    0xffffff9c(%ebp),%eax
    170b:	8b 55 98             	mov    0xffffff98(%ebp),%edx
    170e:	29 c2                	sub    %eax,%edx
    1710:	89 55 9c             	mov    %edx,0xffffff9c(%ebp)
    1713:	83 7d 9c 01          	cmpl   $0x1,0xffffff9c(%ebp)
    1717:	75 18                	jne    1731 <concreate+0xa1>
      link("C0", file);
    1719:	8d 45 e9             	lea    0xffffffe9(%ebp),%eax
    171c:	89 44 24 04          	mov    %eax,0x4(%esp)
    1720:	c7 04 24 b6 46 00 00 	movl   $0x46b6,(%esp)
    1727:	e8 d8 1a 00 00       	call   3204 <link>
    172c:	e9 95 00 00 00       	jmp    17c6 <concreate+0x136>
    } else if(pid == 0 && (i % 5) == 1){
    1731:	83 7d f0 00          	cmpl   $0x0,0xfffffff0(%ebp)
    1735:	75 48                	jne    177f <concreate+0xef>
    1737:	8b 4d ec             	mov    0xffffffec(%ebp),%ecx
    173a:	c7 45 94 67 66 66 66 	movl   $0x66666667,0xffffff94(%ebp)
    1741:	8b 45 94             	mov    0xffffff94(%ebp),%eax
    1744:	f7 e9                	imul   %ecx
    1746:	d1 fa                	sar    %edx
    1748:	89 c8                	mov    %ecx,%eax
    174a:	c1 f8 1f             	sar    $0x1f,%eax
    174d:	89 d3                	mov    %edx,%ebx
    174f:	29 c3                	sub    %eax,%ebx
    1751:	89 5d a0             	mov    %ebx,0xffffffa0(%ebp)
    1754:	8b 45 a0             	mov    0xffffffa0(%ebp),%eax
    1757:	c1 e0 02             	shl    $0x2,%eax
    175a:	03 45 a0             	add    0xffffffa0(%ebp),%eax
    175d:	89 ca                	mov    %ecx,%edx
    175f:	29 c2                	sub    %eax,%edx
    1761:	89 55 a0             	mov    %edx,0xffffffa0(%ebp)
    1764:	83 7d a0 01          	cmpl   $0x1,0xffffffa0(%ebp)
    1768:	75 15                	jne    177f <concreate+0xef>
      link("C0", file);
    176a:	8d 45 e9             	lea    0xffffffe9(%ebp),%eax
    176d:	89 44 24 04          	mov    %eax,0x4(%esp)
    1771:	c7 04 24 b6 46 00 00 	movl   $0x46b6,(%esp)
    1778:	e8 87 1a 00 00       	call   3204 <link>
    177d:	eb 47                	jmp    17c6 <concreate+0x136>
    } else {
      fd = open(file, O_CREATE | O_RDWR);
    177f:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    1786:	00 
    1787:	8d 45 e9             	lea    0xffffffe9(%ebp),%eax
    178a:	89 04 24             	mov    %eax,(%esp)
    178d:	e8 52 1a 00 00       	call   31e4 <open>
    1792:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
      if(fd < 0){
    1795:	83 7d f8 00          	cmpl   $0x0,0xfffffff8(%ebp)
    1799:	79 20                	jns    17bb <concreate+0x12b>
        printf(1, "concreate create %s failed\n", file);
    179b:	8d 45 e9             	lea    0xffffffe9(%ebp),%eax
    179e:	89 44 24 08          	mov    %eax,0x8(%esp)
    17a2:	c7 44 24 04 b9 46 00 	movl   $0x46b9,0x4(%esp)
    17a9:	00 
    17aa:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    17b1:	e8 fa 1b 00 00       	call   33b0 <printf>
        exit();
    17b6:	e8 e9 19 00 00       	call   31a4 <exit>
      }
      close(fd);
    17bb:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
    17be:	89 04 24             	mov    %eax,(%esp)
    17c1:	e8 06 1a 00 00       	call   31cc <close>
    }
    if(pid == 0)
    17c6:	83 7d f0 00          	cmpl   $0x0,0xfffffff0(%ebp)
    17ca:	75 05                	jne    17d1 <concreate+0x141>
      exit();
    17cc:	e8 d3 19 00 00       	call   31a4 <exit>
    else
      wait();
    17d1:	e8 d6 19 00 00       	call   31ac <wait>
    17d6:	83 45 ec 01          	addl   $0x1,0xffffffec(%ebp)
    17da:	83 7d ec 27          	cmpl   $0x27,0xffffffec(%ebp)
    17de:	0f 8e db fe ff ff    	jle    16bf <concreate+0x2f>
  }

  memset(fa, 0, sizeof(fa));
    17e4:	c7 44 24 08 28 00 00 	movl   $0x28,0x8(%esp)
    17eb:	00 
    17ec:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    17f3:	00 
    17f4:	8d 45 c1             	lea    0xffffffc1(%ebp),%eax
    17f7:	89 04 24             	mov    %eax,(%esp)
    17fa:	e8 d1 17 00 00       	call   2fd0 <memset>
  fd = open(".", 0);
    17ff:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1806:	00 
    1807:	c7 04 24 7b 46 00 00 	movl   $0x467b,(%esp)
    180e:	e8 d1 19 00 00       	call   31e4 <open>
    1813:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
  n = 0;
    1816:	c7 45 f4 00 00 00 00 	movl   $0x0,0xfffffff4(%ebp)
  while(read(fd, &de, sizeof(de)) > 0){
    181d:	e9 9a 00 00 00       	jmp    18bc <concreate+0x22c>
    if(de.inum == 0)
    1822:	0f b7 45 b0          	movzwl 0xffffffb0(%ebp),%eax
    1826:	66 85 c0             	test   %ax,%ax
    1829:	0f 84 8d 00 00 00    	je     18bc <concreate+0x22c>
      continue;
    if(de.name[0] == 'C' && de.name[2] == '\0'){
    182f:	0f b6 45 b2          	movzbl 0xffffffb2(%ebp),%eax
    1833:	3c 43                	cmp    $0x43,%al
    1835:	0f 85 81 00 00 00    	jne    18bc <concreate+0x22c>
    183b:	0f b6 45 b4          	movzbl 0xffffffb4(%ebp),%eax
    183f:	84 c0                	test   %al,%al
    1841:	75 79                	jne    18bc <concreate+0x22c>
      i = de.name[1] - '0';
    1843:	0f b6 45 b3          	movzbl 0xffffffb3(%ebp),%eax
    1847:	0f be c0             	movsbl %al,%eax
    184a:	83 e8 30             	sub    $0x30,%eax
    184d:	89 45 ec             	mov    %eax,0xffffffec(%ebp)
      if(i < 0 || i >= sizeof(fa)){
    1850:	83 7d ec 00          	cmpl   $0x0,0xffffffec(%ebp)
    1854:	78 08                	js     185e <concreate+0x1ce>
    1856:	8b 45 ec             	mov    0xffffffec(%ebp),%eax
    1859:	83 f8 27             	cmp    $0x27,%eax
    185c:	76 23                	jbe    1881 <concreate+0x1f1>
        printf(1, "concreate weird file %s\n", de.name);
    185e:	8d 45 b0             	lea    0xffffffb0(%ebp),%eax
    1861:	83 c0 02             	add    $0x2,%eax
    1864:	89 44 24 08          	mov    %eax,0x8(%esp)
    1868:	c7 44 24 04 d5 46 00 	movl   $0x46d5,0x4(%esp)
    186f:	00 
    1870:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1877:	e8 34 1b 00 00       	call   33b0 <printf>
        exit();
    187c:	e8 23 19 00 00       	call   31a4 <exit>
      }
      if(fa[i]){
    1881:	8b 45 ec             	mov    0xffffffec(%ebp),%eax
    1884:	0f b6 44 05 c1       	movzbl 0xffffffc1(%ebp,%eax,1),%eax
    1889:	84 c0                	test   %al,%al
    188b:	74 23                	je     18b0 <concreate+0x220>
        printf(1, "concreate duplicate file %s\n", de.name);
    188d:	8d 45 b0             	lea    0xffffffb0(%ebp),%eax
    1890:	83 c0 02             	add    $0x2,%eax
    1893:	89 44 24 08          	mov    %eax,0x8(%esp)
    1897:	c7 44 24 04 ee 46 00 	movl   $0x46ee,0x4(%esp)
    189e:	00 
    189f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    18a6:	e8 05 1b 00 00       	call   33b0 <printf>
        exit();
    18ab:	e8 f4 18 00 00       	call   31a4 <exit>
      }
      fa[i] = 1;
    18b0:	8b 45 ec             	mov    0xffffffec(%ebp),%eax
    18b3:	c6 44 05 c1 01       	movb   $0x1,0xffffffc1(%ebp,%eax,1)
      n++;
    18b8:	83 45 f4 01          	addl   $0x1,0xfffffff4(%ebp)
    18bc:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
    18c3:	00 
    18c4:	8d 45 b0             	lea    0xffffffb0(%ebp),%eax
    18c7:	89 44 24 04          	mov    %eax,0x4(%esp)
    18cb:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
    18ce:	89 04 24             	mov    %eax,(%esp)
    18d1:	e8 e6 18 00 00       	call   31bc <read>
    18d6:	85 c0                	test   %eax,%eax
    18d8:	0f 8f 44 ff ff ff    	jg     1822 <concreate+0x192>
    }
  }
  close(fd);
    18de:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
    18e1:	89 04 24             	mov    %eax,(%esp)
    18e4:	e8 e3 18 00 00       	call   31cc <close>

  if(n != 40){
    18e9:	83 7d f4 28          	cmpl   $0x28,0xfffffff4(%ebp)
    18ed:	74 19                	je     1908 <concreate+0x278>
    printf(1, "concreate not enough files in directory listing\n");
    18ef:	c7 44 24 04 0c 47 00 	movl   $0x470c,0x4(%esp)
    18f6:	00 
    18f7:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    18fe:	e8 ad 1a 00 00       	call   33b0 <printf>
    exit();
    1903:	e8 9c 18 00 00       	call   31a4 <exit>
  }

  for(i = 0; i < 40; i++){
    1908:	c7 45 ec 00 00 00 00 	movl   $0x0,0xffffffec(%ebp)
    190f:	e9 ee 00 00 00       	jmp    1a02 <concreate+0x372>
    file[1] = '0' + i;
    1914:	8b 45 ec             	mov    0xffffffec(%ebp),%eax
    1917:	83 c0 30             	add    $0x30,%eax
    191a:	88 45 ea             	mov    %al,0xffffffea(%ebp)
    pid = fork();
    191d:	e8 7a 18 00 00       	call   319c <fork>
    1922:	89 45 f0             	mov    %eax,0xfffffff0(%ebp)
    if(pid < 0){
    1925:	83 7d f0 00          	cmpl   $0x0,0xfffffff0(%ebp)
    1929:	79 19                	jns    1944 <concreate+0x2b4>
      printf(1, "fork failed\n");
    192b:	c7 44 24 04 11 43 00 	movl   $0x4311,0x4(%esp)
    1932:	00 
    1933:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    193a:	e8 71 1a 00 00       	call   33b0 <printf>
      exit();
    193f:	e8 60 18 00 00       	call   31a4 <exit>
    }
    if(((i % 3) == 0 && pid == 0) ||
    1944:	8b 5d ec             	mov    0xffffffec(%ebp),%ebx
    1947:	89 5d 98             	mov    %ebx,0xffffff98(%ebp)
    194a:	c7 45 94 56 55 55 55 	movl   $0x55555556,0xffffff94(%ebp)
    1951:	8b 45 94             	mov    0xffffff94(%ebp),%eax
    1954:	f7 6d 98             	imull  0xffffff98(%ebp)
    1957:	89 d1                	mov    %edx,%ecx
    1959:	8b 45 98             	mov    0xffffff98(%ebp),%eax
    195c:	c1 f8 1f             	sar    $0x1f,%eax
    195f:	89 cb                	mov    %ecx,%ebx
    1961:	29 c3                	sub    %eax,%ebx
    1963:	89 5d a4             	mov    %ebx,0xffffffa4(%ebp)
    1966:	8b 45 a4             	mov    0xffffffa4(%ebp),%eax
    1969:	01 c0                	add    %eax,%eax
    196b:	03 45 a4             	add    0xffffffa4(%ebp),%eax
    196e:	8b 55 98             	mov    0xffffff98(%ebp),%edx
    1971:	29 c2                	sub    %eax,%edx
    1973:	89 55 a4             	mov    %edx,0xffffffa4(%ebp)
    1976:	83 7d a4 00          	cmpl   $0x0,0xffffffa4(%ebp)
    197a:	75 06                	jne    1982 <concreate+0x2f2>
    197c:	83 7d f0 00          	cmpl   $0x0,0xfffffff0(%ebp)
    1980:	74 3e                	je     19c0 <concreate+0x330>
    1982:	8b 5d ec             	mov    0xffffffec(%ebp),%ebx
    1985:	89 5d 98             	mov    %ebx,0xffffff98(%ebp)
    1988:	c7 45 94 56 55 55 55 	movl   $0x55555556,0xffffff94(%ebp)
    198f:	8b 45 94             	mov    0xffffff94(%ebp),%eax
    1992:	f7 6d 98             	imull  0xffffff98(%ebp)
    1995:	89 d1                	mov    %edx,%ecx
    1997:	8b 45 98             	mov    0xffffff98(%ebp),%eax
    199a:	c1 f8 1f             	sar    $0x1f,%eax
    199d:	89 cb                	mov    %ecx,%ebx
    199f:	29 c3                	sub    %eax,%ebx
    19a1:	89 5d a8             	mov    %ebx,0xffffffa8(%ebp)
    19a4:	8b 45 a8             	mov    0xffffffa8(%ebp),%eax
    19a7:	01 c0                	add    %eax,%eax
    19a9:	03 45 a8             	add    0xffffffa8(%ebp),%eax
    19ac:	8b 55 98             	mov    0xffffff98(%ebp),%edx
    19af:	29 c2                	sub    %eax,%edx
    19b1:	89 55 a8             	mov    %edx,0xffffffa8(%ebp)
    19b4:	83 7d a8 01          	cmpl   $0x1,0xffffffa8(%ebp)
    19b8:	75 29                	jne    19e3 <concreate+0x353>
    19ba:	83 7d f0 00          	cmpl   $0x0,0xfffffff0(%ebp)
    19be:	74 23                	je     19e3 <concreate+0x353>
       ((i % 3) == 1 && pid != 0)){
      fd = open(file, 0);
    19c0:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    19c7:	00 
    19c8:	8d 45 e9             	lea    0xffffffe9(%ebp),%eax
    19cb:	89 04 24             	mov    %eax,(%esp)
    19ce:	e8 11 18 00 00       	call   31e4 <open>
    19d3:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
      close(fd);
    19d6:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
    19d9:	89 04 24             	mov    %eax,(%esp)
    19dc:	e8 eb 17 00 00       	call   31cc <close>
    19e1:	eb 0b                	jmp    19ee <concreate+0x35e>
    } else {
      unlink(file);
    19e3:	8d 45 e9             	lea    0xffffffe9(%ebp),%eax
    19e6:	89 04 24             	mov    %eax,(%esp)
    19e9:	e8 06 18 00 00       	call   31f4 <unlink>
    }
    if(pid == 0)
    19ee:	83 7d f0 00          	cmpl   $0x0,0xfffffff0(%ebp)
    19f2:	75 05                	jne    19f9 <concreate+0x369>
      exit();
    19f4:	e8 ab 17 00 00       	call   31a4 <exit>
    else
      wait();
    19f9:	e8 ae 17 00 00       	call   31ac <wait>
    19fe:	83 45 ec 01          	addl   $0x1,0xffffffec(%ebp)
    1a02:	83 7d ec 27          	cmpl   $0x27,0xffffffec(%ebp)
    1a06:	0f 8e 08 ff ff ff    	jle    1914 <concreate+0x284>
  }

  printf(1, "concreate ok\n");
    1a0c:	c7 44 24 04 3d 47 00 	movl   $0x473d,0x4(%esp)
    1a13:	00 
    1a14:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1a1b:	e8 90 19 00 00       	call   33b0 <printf>
}
    1a20:	83 c4 74             	add    $0x74,%esp
    1a23:	5b                   	pop    %ebx
    1a24:	5d                   	pop    %ebp
    1a25:	c3                   	ret    
    1a26:	8d 76 00             	lea    0x0(%esi),%esi
    1a29:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00001a30 <bigdir>:

// directory that uses indirect blocks
void
bigdir(void)
{
    1a30:	55                   	push   %ebp
    1a31:	89 e5                	mov    %esp,%ebp
    1a33:	83 ec 28             	sub    $0x28,%esp
  int i, fd;
  char name[10];

  printf(1, "bigdir test\n");
    1a36:	c7 44 24 04 4b 47 00 	movl   $0x474b,0x4(%esp)
    1a3d:	00 
    1a3e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1a45:	e8 66 19 00 00       	call   33b0 <printf>
  unlink("bd");
    1a4a:	c7 04 24 58 47 00 00 	movl   $0x4758,(%esp)
    1a51:	e8 9e 17 00 00       	call   31f4 <unlink>

  fd = open("bd", O_CREATE);
    1a56:	c7 44 24 04 00 02 00 	movl   $0x200,0x4(%esp)
    1a5d:	00 
    1a5e:	c7 04 24 58 47 00 00 	movl   $0x4758,(%esp)
    1a65:	e8 7a 17 00 00       	call   31e4 <open>
    1a6a:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
  if(fd < 0){
    1a6d:	83 7d fc 00          	cmpl   $0x0,0xfffffffc(%ebp)
    1a71:	79 19                	jns    1a8c <bigdir+0x5c>
    printf(1, "bigdir create failed\n");
    1a73:	c7 44 24 04 5b 47 00 	movl   $0x475b,0x4(%esp)
    1a7a:	00 
    1a7b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1a82:	e8 29 19 00 00       	call   33b0 <printf>
    exit();
    1a87:	e8 18 17 00 00       	call   31a4 <exit>
  }
  close(fd);
    1a8c:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
    1a8f:	89 04 24             	mov    %eax,(%esp)
    1a92:	e8 35 17 00 00       	call   31cc <close>

  for(i = 0; i < 500; i++){
    1a97:	c7 45 f8 00 00 00 00 	movl   $0x0,0xfffffff8(%ebp)
    1a9e:	eb 6d                	jmp    1b0d <bigdir+0xdd>
    name[0] = 'x';
    1aa0:	c6 45 ee 78          	movb   $0x78,0xffffffee(%ebp)
    name[1] = '0' + (i / 64);
    1aa4:	8b 55 f8             	mov    0xfffffff8(%ebp),%edx
    1aa7:	89 d0                	mov    %edx,%eax
    1aa9:	c1 f8 1f             	sar    $0x1f,%eax
    1aac:	c1 e8 1a             	shr    $0x1a,%eax
    1aaf:	01 d0                	add    %edx,%eax
    1ab1:	c1 f8 06             	sar    $0x6,%eax
    1ab4:	83 c0 30             	add    $0x30,%eax
    1ab7:	88 45 ef             	mov    %al,0xffffffef(%ebp)
    name[2] = '0' + (i % 64);
    1aba:	8b 55 f8             	mov    0xfffffff8(%ebp),%edx
    1abd:	89 d0                	mov    %edx,%eax
    1abf:	c1 f8 1f             	sar    $0x1f,%eax
    1ac2:	89 c1                	mov    %eax,%ecx
    1ac4:	c1 e9 1a             	shr    $0x1a,%ecx
    1ac7:	8d 04 0a             	lea    (%edx,%ecx,1),%eax
    1aca:	83 e0 3f             	and    $0x3f,%eax
    1acd:	29 c8                	sub    %ecx,%eax
    1acf:	83 c0 30             	add    $0x30,%eax
    1ad2:	88 45 f0             	mov    %al,0xfffffff0(%ebp)
    name[3] = '\0';
    1ad5:	c6 45 f1 00          	movb   $0x0,0xfffffff1(%ebp)
    if(link("bd", name) != 0){
    1ad9:	8d 45 ee             	lea    0xffffffee(%ebp),%eax
    1adc:	89 44 24 04          	mov    %eax,0x4(%esp)
    1ae0:	c7 04 24 58 47 00 00 	movl   $0x4758,(%esp)
    1ae7:	e8 18 17 00 00       	call   3204 <link>
    1aec:	85 c0                	test   %eax,%eax
    1aee:	74 19                	je     1b09 <bigdir+0xd9>
      printf(1, "bigdir link failed\n");
    1af0:	c7 44 24 04 71 47 00 	movl   $0x4771,0x4(%esp)
    1af7:	00 
    1af8:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1aff:	e8 ac 18 00 00       	call   33b0 <printf>
      exit();
    1b04:	e8 9b 16 00 00       	call   31a4 <exit>
    1b09:	83 45 f8 01          	addl   $0x1,0xfffffff8(%ebp)
    1b0d:	81 7d f8 f3 01 00 00 	cmpl   $0x1f3,0xfffffff8(%ebp)
    1b14:	7e 8a                	jle    1aa0 <bigdir+0x70>
    }
  }

  unlink("bd");
    1b16:	c7 04 24 58 47 00 00 	movl   $0x4758,(%esp)
    1b1d:	e8 d2 16 00 00       	call   31f4 <unlink>
  for(i = 0; i < 500; i++){
    1b22:	c7 45 f8 00 00 00 00 	movl   $0x0,0xfffffff8(%ebp)
    1b29:	eb 65                	jmp    1b90 <bigdir+0x160>
    name[0] = 'x';
    1b2b:	c6 45 ee 78          	movb   $0x78,0xffffffee(%ebp)
    name[1] = '0' + (i / 64);
    1b2f:	8b 55 f8             	mov    0xfffffff8(%ebp),%edx
    1b32:	89 d0                	mov    %edx,%eax
    1b34:	c1 f8 1f             	sar    $0x1f,%eax
    1b37:	c1 e8 1a             	shr    $0x1a,%eax
    1b3a:	01 d0                	add    %edx,%eax
    1b3c:	c1 f8 06             	sar    $0x6,%eax
    1b3f:	83 c0 30             	add    $0x30,%eax
    1b42:	88 45 ef             	mov    %al,0xffffffef(%ebp)
    name[2] = '0' + (i % 64);
    1b45:	8b 55 f8             	mov    0xfffffff8(%ebp),%edx
    1b48:	89 d0                	mov    %edx,%eax
    1b4a:	c1 f8 1f             	sar    $0x1f,%eax
    1b4d:	89 c1                	mov    %eax,%ecx
    1b4f:	c1 e9 1a             	shr    $0x1a,%ecx
    1b52:	8d 04 0a             	lea    (%edx,%ecx,1),%eax
    1b55:	83 e0 3f             	and    $0x3f,%eax
    1b58:	29 c8                	sub    %ecx,%eax
    1b5a:	83 c0 30             	add    $0x30,%eax
    1b5d:	88 45 f0             	mov    %al,0xfffffff0(%ebp)
    name[3] = '\0';
    1b60:	c6 45 f1 00          	movb   $0x0,0xfffffff1(%ebp)
    if(unlink(name) != 0){
    1b64:	8d 45 ee             	lea    0xffffffee(%ebp),%eax
    1b67:	89 04 24             	mov    %eax,(%esp)
    1b6a:	e8 85 16 00 00       	call   31f4 <unlink>
    1b6f:	85 c0                	test   %eax,%eax
    1b71:	74 19                	je     1b8c <bigdir+0x15c>
      printf(1, "bigdir unlink failed");
    1b73:	c7 44 24 04 85 47 00 	movl   $0x4785,0x4(%esp)
    1b7a:	00 
    1b7b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1b82:	e8 29 18 00 00       	call   33b0 <printf>
      exit();
    1b87:	e8 18 16 00 00       	call   31a4 <exit>
    1b8c:	83 45 f8 01          	addl   $0x1,0xfffffff8(%ebp)
    1b90:	81 7d f8 f3 01 00 00 	cmpl   $0x1f3,0xfffffff8(%ebp)
    1b97:	7e 92                	jle    1b2b <bigdir+0xfb>
    }
  }

  printf(1, "bigdir ok\n");
    1b99:	c7 44 24 04 9a 47 00 	movl   $0x479a,0x4(%esp)
    1ba0:	00 
    1ba1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1ba8:	e8 03 18 00 00       	call   33b0 <printf>
}
    1bad:	c9                   	leave  
    1bae:	c3                   	ret    
    1baf:	90                   	nop    

00001bb0 <subdir>:

void
subdir(void)
{
    1bb0:	55                   	push   %ebp
    1bb1:	89 e5                	mov    %esp,%ebp
    1bb3:	83 ec 28             	sub    $0x28,%esp
  int fd, cc;

  printf(1, "subdir test\n");
    1bb6:	c7 44 24 04 a5 47 00 	movl   $0x47a5,0x4(%esp)
    1bbd:	00 
    1bbe:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1bc5:	e8 e6 17 00 00       	call   33b0 <printf>

  unlink("ff");
    1bca:	c7 04 24 b2 47 00 00 	movl   $0x47b2,(%esp)
    1bd1:	e8 1e 16 00 00       	call   31f4 <unlink>
  if(mkdir("dd") != 0){
    1bd6:	c7 04 24 b5 47 00 00 	movl   $0x47b5,(%esp)
    1bdd:	e8 2a 16 00 00       	call   320c <mkdir>
    1be2:	85 c0                	test   %eax,%eax
    1be4:	74 19                	je     1bff <subdir+0x4f>
    printf(1, "subdir mkdir dd failed\n");
    1be6:	c7 44 24 04 b8 47 00 	movl   $0x47b8,0x4(%esp)
    1bed:	00 
    1bee:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1bf5:	e8 b6 17 00 00       	call   33b0 <printf>
    exit();
    1bfa:	e8 a5 15 00 00       	call   31a4 <exit>
  }

  fd = open("dd/ff", O_CREATE | O_RDWR);
    1bff:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    1c06:	00 
    1c07:	c7 04 24 d0 47 00 00 	movl   $0x47d0,(%esp)
    1c0e:	e8 d1 15 00 00       	call   31e4 <open>
    1c13:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
  if(fd < 0){
    1c16:	83 7d f8 00          	cmpl   $0x0,0xfffffff8(%ebp)
    1c1a:	79 19                	jns    1c35 <subdir+0x85>
    printf(1, "create dd/ff failed\n");
    1c1c:	c7 44 24 04 d6 47 00 	movl   $0x47d6,0x4(%esp)
    1c23:	00 
    1c24:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1c2b:	e8 80 17 00 00       	call   33b0 <printf>
    exit();
    1c30:	e8 6f 15 00 00       	call   31a4 <exit>
  }
  write(fd, "ff", 2);
    1c35:	c7 44 24 08 02 00 00 	movl   $0x2,0x8(%esp)
    1c3c:	00 
    1c3d:	c7 44 24 04 b2 47 00 	movl   $0x47b2,0x4(%esp)
    1c44:	00 
    1c45:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
    1c48:	89 04 24             	mov    %eax,(%esp)
    1c4b:	e8 74 15 00 00       	call   31c4 <write>
  close(fd);
    1c50:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
    1c53:	89 04 24             	mov    %eax,(%esp)
    1c56:	e8 71 15 00 00       	call   31cc <close>
  
  if(unlink("dd") >= 0){
    1c5b:	c7 04 24 b5 47 00 00 	movl   $0x47b5,(%esp)
    1c62:	e8 8d 15 00 00       	call   31f4 <unlink>
    1c67:	85 c0                	test   %eax,%eax
    1c69:	78 19                	js     1c84 <subdir+0xd4>
    printf(1, "unlink dd (non-empty dir) succeeded!\n");
    1c6b:	c7 44 24 04 ec 47 00 	movl   $0x47ec,0x4(%esp)
    1c72:	00 
    1c73:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1c7a:	e8 31 17 00 00       	call   33b0 <printf>
    exit();
    1c7f:	e8 20 15 00 00       	call   31a4 <exit>
  }

  if(mkdir("/dd/dd") != 0){
    1c84:	c7 04 24 12 48 00 00 	movl   $0x4812,(%esp)
    1c8b:	e8 7c 15 00 00       	call   320c <mkdir>
    1c90:	85 c0                	test   %eax,%eax
    1c92:	74 19                	je     1cad <subdir+0xfd>
    printf(1, "subdir mkdir dd/dd failed\n");
    1c94:	c7 44 24 04 19 48 00 	movl   $0x4819,0x4(%esp)
    1c9b:	00 
    1c9c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1ca3:	e8 08 17 00 00       	call   33b0 <printf>
    exit();
    1ca8:	e8 f7 14 00 00       	call   31a4 <exit>
  }

  fd = open("dd/dd/ff", O_CREATE | O_RDWR);
    1cad:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    1cb4:	00 
    1cb5:	c7 04 24 34 48 00 00 	movl   $0x4834,(%esp)
    1cbc:	e8 23 15 00 00       	call   31e4 <open>
    1cc1:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
  if(fd < 0){
    1cc4:	83 7d f8 00          	cmpl   $0x0,0xfffffff8(%ebp)
    1cc8:	79 19                	jns    1ce3 <subdir+0x133>
    printf(1, "create dd/dd/ff failed\n");
    1cca:	c7 44 24 04 3d 48 00 	movl   $0x483d,0x4(%esp)
    1cd1:	00 
    1cd2:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1cd9:	e8 d2 16 00 00       	call   33b0 <printf>
    exit();
    1cde:	e8 c1 14 00 00       	call   31a4 <exit>
  }
  write(fd, "FF", 2);
    1ce3:	c7 44 24 08 02 00 00 	movl   $0x2,0x8(%esp)
    1cea:	00 
    1ceb:	c7 44 24 04 55 48 00 	movl   $0x4855,0x4(%esp)
    1cf2:	00 
    1cf3:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
    1cf6:	89 04 24             	mov    %eax,(%esp)
    1cf9:	e8 c6 14 00 00       	call   31c4 <write>
  close(fd);
    1cfe:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
    1d01:	89 04 24             	mov    %eax,(%esp)
    1d04:	e8 c3 14 00 00       	call   31cc <close>

  fd = open("dd/dd/../ff", 0);
    1d09:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1d10:	00 
    1d11:	c7 04 24 58 48 00 00 	movl   $0x4858,(%esp)
    1d18:	e8 c7 14 00 00       	call   31e4 <open>
    1d1d:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
  if(fd < 0){
    1d20:	83 7d f8 00          	cmpl   $0x0,0xfffffff8(%ebp)
    1d24:	79 19                	jns    1d3f <subdir+0x18f>
    printf(1, "open dd/dd/../ff failed\n");
    1d26:	c7 44 24 04 64 48 00 	movl   $0x4864,0x4(%esp)
    1d2d:	00 
    1d2e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1d35:	e8 76 16 00 00       	call   33b0 <printf>
    exit();
    1d3a:	e8 65 14 00 00       	call   31a4 <exit>
  }
  cc = read(fd, buf, sizeof(buf));
    1d3f:	c7 44 24 08 00 08 00 	movl   $0x800,0x8(%esp)
    1d46:	00 
    1d47:	c7 44 24 04 80 52 00 	movl   $0x5280,0x4(%esp)
    1d4e:	00 
    1d4f:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
    1d52:	89 04 24             	mov    %eax,(%esp)
    1d55:	e8 62 14 00 00       	call   31bc <read>
    1d5a:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
  if(cc != 2 || buf[0] != 'f'){
    1d5d:	83 7d fc 02          	cmpl   $0x2,0xfffffffc(%ebp)
    1d61:	75 0b                	jne    1d6e <subdir+0x1be>
    1d63:	0f b6 05 80 52 00 00 	movzbl 0x5280,%eax
    1d6a:	3c 66                	cmp    $0x66,%al
    1d6c:	74 19                	je     1d87 <subdir+0x1d7>
    printf(1, "dd/dd/../ff wrong content\n");
    1d6e:	c7 44 24 04 7d 48 00 	movl   $0x487d,0x4(%esp)
    1d75:	00 
    1d76:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1d7d:	e8 2e 16 00 00       	call   33b0 <printf>
    exit();
    1d82:	e8 1d 14 00 00       	call   31a4 <exit>
  }
  close(fd);
    1d87:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
    1d8a:	89 04 24             	mov    %eax,(%esp)
    1d8d:	e8 3a 14 00 00       	call   31cc <close>

  if(link("dd/dd/ff", "dd/dd/ffff") != 0){
    1d92:	c7 44 24 04 98 48 00 	movl   $0x4898,0x4(%esp)
    1d99:	00 
    1d9a:	c7 04 24 34 48 00 00 	movl   $0x4834,(%esp)
    1da1:	e8 5e 14 00 00       	call   3204 <link>
    1da6:	85 c0                	test   %eax,%eax
    1da8:	74 19                	je     1dc3 <subdir+0x213>
    printf(1, "link dd/dd/ff dd/dd/ffff failed\n");
    1daa:	c7 44 24 04 a4 48 00 	movl   $0x48a4,0x4(%esp)
    1db1:	00 
    1db2:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1db9:	e8 f2 15 00 00       	call   33b0 <printf>
    exit();
    1dbe:	e8 e1 13 00 00       	call   31a4 <exit>
  }

  if(unlink("dd/dd/ff") != 0){
    1dc3:	c7 04 24 34 48 00 00 	movl   $0x4834,(%esp)
    1dca:	e8 25 14 00 00       	call   31f4 <unlink>
    1dcf:	85 c0                	test   %eax,%eax
    1dd1:	74 19                	je     1dec <subdir+0x23c>
    printf(1, "unlink dd/dd/ff failed\n");
    1dd3:	c7 44 24 04 c5 48 00 	movl   $0x48c5,0x4(%esp)
    1dda:	00 
    1ddb:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1de2:	e8 c9 15 00 00       	call   33b0 <printf>
    exit();
    1de7:	e8 b8 13 00 00       	call   31a4 <exit>
  }
  if(open("dd/dd/ff", O_RDONLY) >= 0){
    1dec:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1df3:	00 
    1df4:	c7 04 24 34 48 00 00 	movl   $0x4834,(%esp)
    1dfb:	e8 e4 13 00 00       	call   31e4 <open>
    1e00:	85 c0                	test   %eax,%eax
    1e02:	78 19                	js     1e1d <subdir+0x26d>
    printf(1, "open (unlinked) dd/dd/ff succeeded\n");
    1e04:	c7 44 24 04 e0 48 00 	movl   $0x48e0,0x4(%esp)
    1e0b:	00 
    1e0c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1e13:	e8 98 15 00 00       	call   33b0 <printf>
    exit();
    1e18:	e8 87 13 00 00       	call   31a4 <exit>
  }

  if(chdir("dd") != 0){
    1e1d:	c7 04 24 b5 47 00 00 	movl   $0x47b5,(%esp)
    1e24:	e8 eb 13 00 00       	call   3214 <chdir>
    1e29:	85 c0                	test   %eax,%eax
    1e2b:	74 19                	je     1e46 <subdir+0x296>
    printf(1, "chdir dd failed\n");
    1e2d:	c7 44 24 04 04 49 00 	movl   $0x4904,0x4(%esp)
    1e34:	00 
    1e35:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1e3c:	e8 6f 15 00 00       	call   33b0 <printf>
    exit();
    1e41:	e8 5e 13 00 00       	call   31a4 <exit>
  }
  if(chdir("dd/../../dd") != 0){
    1e46:	c7 04 24 15 49 00 00 	movl   $0x4915,(%esp)
    1e4d:	e8 c2 13 00 00       	call   3214 <chdir>
    1e52:	85 c0                	test   %eax,%eax
    1e54:	74 19                	je     1e6f <subdir+0x2bf>
    printf(1, "chdir dd/../../dd failed\n");
    1e56:	c7 44 24 04 21 49 00 	movl   $0x4921,0x4(%esp)
    1e5d:	00 
    1e5e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1e65:	e8 46 15 00 00       	call   33b0 <printf>
    exit();
    1e6a:	e8 35 13 00 00       	call   31a4 <exit>
  }
  if(chdir("dd/../../../dd") != 0){
    1e6f:	c7 04 24 3b 49 00 00 	movl   $0x493b,(%esp)
    1e76:	e8 99 13 00 00       	call   3214 <chdir>
    1e7b:	85 c0                	test   %eax,%eax
    1e7d:	74 19                	je     1e98 <subdir+0x2e8>
    printf(1, "chdir dd/../../dd failed\n");
    1e7f:	c7 44 24 04 21 49 00 	movl   $0x4921,0x4(%esp)
    1e86:	00 
    1e87:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1e8e:	e8 1d 15 00 00       	call   33b0 <printf>
    exit();
    1e93:	e8 0c 13 00 00       	call   31a4 <exit>
  }
  if(chdir("./..") != 0){
    1e98:	c7 04 24 4a 49 00 00 	movl   $0x494a,(%esp)
    1e9f:	e8 70 13 00 00       	call   3214 <chdir>
    1ea4:	85 c0                	test   %eax,%eax
    1ea6:	74 19                	je     1ec1 <subdir+0x311>
    printf(1, "chdir ./.. failed\n");
    1ea8:	c7 44 24 04 4f 49 00 	movl   $0x494f,0x4(%esp)
    1eaf:	00 
    1eb0:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1eb7:	e8 f4 14 00 00       	call   33b0 <printf>
    exit();
    1ebc:	e8 e3 12 00 00       	call   31a4 <exit>
  }

  fd = open("dd/dd/ffff", 0);
    1ec1:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1ec8:	00 
    1ec9:	c7 04 24 98 48 00 00 	movl   $0x4898,(%esp)
    1ed0:	e8 0f 13 00 00       	call   31e4 <open>
    1ed5:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
  if(fd < 0){
    1ed8:	83 7d f8 00          	cmpl   $0x0,0xfffffff8(%ebp)
    1edc:	79 19                	jns    1ef7 <subdir+0x347>
    printf(1, "open dd/dd/ffff failed\n");
    1ede:	c7 44 24 04 62 49 00 	movl   $0x4962,0x4(%esp)
    1ee5:	00 
    1ee6:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1eed:	e8 be 14 00 00       	call   33b0 <printf>
    exit();
    1ef2:	e8 ad 12 00 00       	call   31a4 <exit>
  }
  if(read(fd, buf, sizeof(buf)) != 2){
    1ef7:	c7 44 24 08 00 08 00 	movl   $0x800,0x8(%esp)
    1efe:	00 
    1eff:	c7 44 24 04 80 52 00 	movl   $0x5280,0x4(%esp)
    1f06:	00 
    1f07:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
    1f0a:	89 04 24             	mov    %eax,(%esp)
    1f0d:	e8 aa 12 00 00       	call   31bc <read>
    1f12:	83 f8 02             	cmp    $0x2,%eax
    1f15:	74 19                	je     1f30 <subdir+0x380>
    printf(1, "read dd/dd/ffff wrong len\n");
    1f17:	c7 44 24 04 7a 49 00 	movl   $0x497a,0x4(%esp)
    1f1e:	00 
    1f1f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1f26:	e8 85 14 00 00       	call   33b0 <printf>
    exit();
    1f2b:	e8 74 12 00 00       	call   31a4 <exit>
  }
  close(fd);
    1f30:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
    1f33:	89 04 24             	mov    %eax,(%esp)
    1f36:	e8 91 12 00 00       	call   31cc <close>

  if(open("dd/dd/ff", O_RDONLY) >= 0){
    1f3b:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1f42:	00 
    1f43:	c7 04 24 34 48 00 00 	movl   $0x4834,(%esp)
    1f4a:	e8 95 12 00 00       	call   31e4 <open>
    1f4f:	85 c0                	test   %eax,%eax
    1f51:	78 19                	js     1f6c <subdir+0x3bc>
    printf(1, "open (unlinked) dd/dd/ff succeeded!\n");
    1f53:	c7 44 24 04 98 49 00 	movl   $0x4998,0x4(%esp)
    1f5a:	00 
    1f5b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1f62:	e8 49 14 00 00       	call   33b0 <printf>
    exit();
    1f67:	e8 38 12 00 00       	call   31a4 <exit>
  }

  if(open("dd/ff/ff", O_CREATE|O_RDWR) >= 0){
    1f6c:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    1f73:	00 
    1f74:	c7 04 24 bd 49 00 00 	movl   $0x49bd,(%esp)
    1f7b:	e8 64 12 00 00       	call   31e4 <open>
    1f80:	85 c0                	test   %eax,%eax
    1f82:	78 19                	js     1f9d <subdir+0x3ed>
    printf(1, "create dd/ff/ff succeeded!\n");
    1f84:	c7 44 24 04 c6 49 00 	movl   $0x49c6,0x4(%esp)
    1f8b:	00 
    1f8c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1f93:	e8 18 14 00 00       	call   33b0 <printf>
    exit();
    1f98:	e8 07 12 00 00       	call   31a4 <exit>
  }
  if(open("dd/xx/ff", O_CREATE|O_RDWR) >= 0){
    1f9d:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    1fa4:	00 
    1fa5:	c7 04 24 e2 49 00 00 	movl   $0x49e2,(%esp)
    1fac:	e8 33 12 00 00       	call   31e4 <open>
    1fb1:	85 c0                	test   %eax,%eax
    1fb3:	78 19                	js     1fce <subdir+0x41e>
    printf(1, "create dd/xx/ff succeeded!\n");
    1fb5:	c7 44 24 04 eb 49 00 	movl   $0x49eb,0x4(%esp)
    1fbc:	00 
    1fbd:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1fc4:	e8 e7 13 00 00       	call   33b0 <printf>
    exit();
    1fc9:	e8 d6 11 00 00       	call   31a4 <exit>
  }
  if(open("dd", O_CREATE) >= 0){
    1fce:	c7 44 24 04 00 02 00 	movl   $0x200,0x4(%esp)
    1fd5:	00 
    1fd6:	c7 04 24 b5 47 00 00 	movl   $0x47b5,(%esp)
    1fdd:	e8 02 12 00 00       	call   31e4 <open>
    1fe2:	85 c0                	test   %eax,%eax
    1fe4:	78 19                	js     1fff <subdir+0x44f>
    printf(1, "create dd succeeded!\n");
    1fe6:	c7 44 24 04 07 4a 00 	movl   $0x4a07,0x4(%esp)
    1fed:	00 
    1fee:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1ff5:	e8 b6 13 00 00       	call   33b0 <printf>
    exit();
    1ffa:	e8 a5 11 00 00       	call   31a4 <exit>
  }
  if(open("dd", O_RDWR) >= 0){
    1fff:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
    2006:	00 
    2007:	c7 04 24 b5 47 00 00 	movl   $0x47b5,(%esp)
    200e:	e8 d1 11 00 00       	call   31e4 <open>
    2013:	85 c0                	test   %eax,%eax
    2015:	78 19                	js     2030 <subdir+0x480>
    printf(1, "open dd rdwr succeeded!\n");
    2017:	c7 44 24 04 1d 4a 00 	movl   $0x4a1d,0x4(%esp)
    201e:	00 
    201f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2026:	e8 85 13 00 00       	call   33b0 <printf>
    exit();
    202b:	e8 74 11 00 00       	call   31a4 <exit>
  }
  if(open("dd", O_WRONLY) >= 0){
    2030:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
    2037:	00 
    2038:	c7 04 24 b5 47 00 00 	movl   $0x47b5,(%esp)
    203f:	e8 a0 11 00 00       	call   31e4 <open>
    2044:	85 c0                	test   %eax,%eax
    2046:	78 19                	js     2061 <subdir+0x4b1>
    printf(1, "open dd wronly succeeded!\n");
    2048:	c7 44 24 04 36 4a 00 	movl   $0x4a36,0x4(%esp)
    204f:	00 
    2050:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2057:	e8 54 13 00 00       	call   33b0 <printf>
    exit();
    205c:	e8 43 11 00 00       	call   31a4 <exit>
  }
  if(link("dd/ff/ff", "dd/dd/xx") == 0){
    2061:	c7 44 24 04 51 4a 00 	movl   $0x4a51,0x4(%esp)
    2068:	00 
    2069:	c7 04 24 bd 49 00 00 	movl   $0x49bd,(%esp)
    2070:	e8 8f 11 00 00       	call   3204 <link>
    2075:	85 c0                	test   %eax,%eax
    2077:	75 19                	jne    2092 <subdir+0x4e2>
    printf(1, "link dd/ff/ff dd/dd/xx succeeded!\n");
    2079:	c7 44 24 04 5c 4a 00 	movl   $0x4a5c,0x4(%esp)
    2080:	00 
    2081:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2088:	e8 23 13 00 00       	call   33b0 <printf>
    exit();
    208d:	e8 12 11 00 00       	call   31a4 <exit>
  }
  if(link("dd/xx/ff", "dd/dd/xx") == 0){
    2092:	c7 44 24 04 51 4a 00 	movl   $0x4a51,0x4(%esp)
    2099:	00 
    209a:	c7 04 24 e2 49 00 00 	movl   $0x49e2,(%esp)
    20a1:	e8 5e 11 00 00       	call   3204 <link>
    20a6:	85 c0                	test   %eax,%eax
    20a8:	75 19                	jne    20c3 <subdir+0x513>
    printf(1, "link dd/xx/ff dd/dd/xx succeeded!\n");
    20aa:	c7 44 24 04 80 4a 00 	movl   $0x4a80,0x4(%esp)
    20b1:	00 
    20b2:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    20b9:	e8 f2 12 00 00       	call   33b0 <printf>
    exit();
    20be:	e8 e1 10 00 00       	call   31a4 <exit>
  }
  if(link("dd/ff", "dd/dd/ffff") == 0){
    20c3:	c7 44 24 04 98 48 00 	movl   $0x4898,0x4(%esp)
    20ca:	00 
    20cb:	c7 04 24 d0 47 00 00 	movl   $0x47d0,(%esp)
    20d2:	e8 2d 11 00 00       	call   3204 <link>
    20d7:	85 c0                	test   %eax,%eax
    20d9:	75 19                	jne    20f4 <subdir+0x544>
    printf(1, "link dd/ff dd/dd/ffff succeeded!\n");
    20db:	c7 44 24 04 a4 4a 00 	movl   $0x4aa4,0x4(%esp)
    20e2:	00 
    20e3:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    20ea:	e8 c1 12 00 00       	call   33b0 <printf>
    exit();
    20ef:	e8 b0 10 00 00       	call   31a4 <exit>
  }
  if(mkdir("dd/ff/ff") == 0){
    20f4:	c7 04 24 bd 49 00 00 	movl   $0x49bd,(%esp)
    20fb:	e8 0c 11 00 00       	call   320c <mkdir>
    2100:	85 c0                	test   %eax,%eax
    2102:	75 19                	jne    211d <subdir+0x56d>
    printf(1, "mkdir dd/ff/ff succeeded!\n");
    2104:	c7 44 24 04 c6 4a 00 	movl   $0x4ac6,0x4(%esp)
    210b:	00 
    210c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2113:	e8 98 12 00 00       	call   33b0 <printf>
    exit();
    2118:	e8 87 10 00 00       	call   31a4 <exit>
  }
  if(mkdir("dd/xx/ff") == 0){
    211d:	c7 04 24 e2 49 00 00 	movl   $0x49e2,(%esp)
    2124:	e8 e3 10 00 00       	call   320c <mkdir>
    2129:	85 c0                	test   %eax,%eax
    212b:	75 19                	jne    2146 <subdir+0x596>
    printf(1, "mkdir dd/xx/ff succeeded!\n");
    212d:	c7 44 24 04 e1 4a 00 	movl   $0x4ae1,0x4(%esp)
    2134:	00 
    2135:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    213c:	e8 6f 12 00 00       	call   33b0 <printf>
    exit();
    2141:	e8 5e 10 00 00       	call   31a4 <exit>
  }
  if(mkdir("dd/dd/ffff") == 0){
    2146:	c7 04 24 98 48 00 00 	movl   $0x4898,(%esp)
    214d:	e8 ba 10 00 00       	call   320c <mkdir>
    2152:	85 c0                	test   %eax,%eax
    2154:	75 19                	jne    216f <subdir+0x5bf>
    printf(1, "mkdir dd/dd/ffff succeeded!\n");
    2156:	c7 44 24 04 fc 4a 00 	movl   $0x4afc,0x4(%esp)
    215d:	00 
    215e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2165:	e8 46 12 00 00       	call   33b0 <printf>
    exit();
    216a:	e8 35 10 00 00       	call   31a4 <exit>
  }
  if(unlink("dd/xx/ff") == 0){
    216f:	c7 04 24 e2 49 00 00 	movl   $0x49e2,(%esp)
    2176:	e8 79 10 00 00       	call   31f4 <unlink>
    217b:	85 c0                	test   %eax,%eax
    217d:	75 19                	jne    2198 <subdir+0x5e8>
    printf(1, "unlink dd/xx/ff succeeded!\n");
    217f:	c7 44 24 04 19 4b 00 	movl   $0x4b19,0x4(%esp)
    2186:	00 
    2187:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    218e:	e8 1d 12 00 00       	call   33b0 <printf>
    exit();
    2193:	e8 0c 10 00 00       	call   31a4 <exit>
  }
  if(unlink("dd/ff/ff") == 0){
    2198:	c7 04 24 bd 49 00 00 	movl   $0x49bd,(%esp)
    219f:	e8 50 10 00 00       	call   31f4 <unlink>
    21a4:	85 c0                	test   %eax,%eax
    21a6:	75 19                	jne    21c1 <subdir+0x611>
    printf(1, "unlink dd/ff/ff succeeded!\n");
    21a8:	c7 44 24 04 35 4b 00 	movl   $0x4b35,0x4(%esp)
    21af:	00 
    21b0:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    21b7:	e8 f4 11 00 00       	call   33b0 <printf>
    exit();
    21bc:	e8 e3 0f 00 00       	call   31a4 <exit>
  }
  if(chdir("dd/ff") == 0){
    21c1:	c7 04 24 d0 47 00 00 	movl   $0x47d0,(%esp)
    21c8:	e8 47 10 00 00       	call   3214 <chdir>
    21cd:	85 c0                	test   %eax,%eax
    21cf:	75 19                	jne    21ea <subdir+0x63a>
    printf(1, "chdir dd/ff succeeded!\n");
    21d1:	c7 44 24 04 51 4b 00 	movl   $0x4b51,0x4(%esp)
    21d8:	00 
    21d9:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    21e0:	e8 cb 11 00 00       	call   33b0 <printf>
    exit();
    21e5:	e8 ba 0f 00 00       	call   31a4 <exit>
  }
  if(chdir("dd/xx") == 0){
    21ea:	c7 04 24 69 4b 00 00 	movl   $0x4b69,(%esp)
    21f1:	e8 1e 10 00 00       	call   3214 <chdir>
    21f6:	85 c0                	test   %eax,%eax
    21f8:	75 19                	jne    2213 <subdir+0x663>
    printf(1, "chdir dd/xx succeeded!\n");
    21fa:	c7 44 24 04 6f 4b 00 	movl   $0x4b6f,0x4(%esp)
    2201:	00 
    2202:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2209:	e8 a2 11 00 00       	call   33b0 <printf>
    exit();
    220e:	e8 91 0f 00 00       	call   31a4 <exit>
  }

  if(unlink("dd/dd/ffff") != 0){
    2213:	c7 04 24 98 48 00 00 	movl   $0x4898,(%esp)
    221a:	e8 d5 0f 00 00       	call   31f4 <unlink>
    221f:	85 c0                	test   %eax,%eax
    2221:	74 19                	je     223c <subdir+0x68c>
    printf(1, "unlink dd/dd/ff failed\n");
    2223:	c7 44 24 04 c5 48 00 	movl   $0x48c5,0x4(%esp)
    222a:	00 
    222b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2232:	e8 79 11 00 00       	call   33b0 <printf>
    exit();
    2237:	e8 68 0f 00 00       	call   31a4 <exit>
  }
  if(unlink("dd/ff") != 0){
    223c:	c7 04 24 d0 47 00 00 	movl   $0x47d0,(%esp)
    2243:	e8 ac 0f 00 00       	call   31f4 <unlink>
    2248:	85 c0                	test   %eax,%eax
    224a:	74 19                	je     2265 <subdir+0x6b5>
    printf(1, "unlink dd/ff failed\n");
    224c:	c7 44 24 04 87 4b 00 	movl   $0x4b87,0x4(%esp)
    2253:	00 
    2254:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    225b:	e8 50 11 00 00       	call   33b0 <printf>
    exit();
    2260:	e8 3f 0f 00 00       	call   31a4 <exit>
  }
  if(unlink("dd") == 0){
    2265:	c7 04 24 b5 47 00 00 	movl   $0x47b5,(%esp)
    226c:	e8 83 0f 00 00       	call   31f4 <unlink>
    2271:	85 c0                	test   %eax,%eax
    2273:	75 19                	jne    228e <subdir+0x6de>
    printf(1, "unlink non-empty dd succeeded!\n");
    2275:	c7 44 24 04 9c 4b 00 	movl   $0x4b9c,0x4(%esp)
    227c:	00 
    227d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2284:	e8 27 11 00 00       	call   33b0 <printf>
    exit();
    2289:	e8 16 0f 00 00       	call   31a4 <exit>
  }
  if(unlink("dd/dd") < 0){
    228e:	c7 04 24 bc 4b 00 00 	movl   $0x4bbc,(%esp)
    2295:	e8 5a 0f 00 00       	call   31f4 <unlink>
    229a:	85 c0                	test   %eax,%eax
    229c:	79 19                	jns    22b7 <subdir+0x707>
    printf(1, "unlink dd/dd failed\n");
    229e:	c7 44 24 04 c2 4b 00 	movl   $0x4bc2,0x4(%esp)
    22a5:	00 
    22a6:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    22ad:	e8 fe 10 00 00       	call   33b0 <printf>
    exit();
    22b2:	e8 ed 0e 00 00       	call   31a4 <exit>
  }
  if(unlink("dd") < 0){
    22b7:	c7 04 24 b5 47 00 00 	movl   $0x47b5,(%esp)
    22be:	e8 31 0f 00 00       	call   31f4 <unlink>
    22c3:	85 c0                	test   %eax,%eax
    22c5:	79 19                	jns    22e0 <subdir+0x730>
    printf(1, "unlink dd failed\n");
    22c7:	c7 44 24 04 d7 4b 00 	movl   $0x4bd7,0x4(%esp)
    22ce:	00 
    22cf:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    22d6:	e8 d5 10 00 00       	call   33b0 <printf>
    exit();
    22db:	e8 c4 0e 00 00       	call   31a4 <exit>
  }

  printf(1, "subdir ok\n");
    22e0:	c7 44 24 04 e9 4b 00 	movl   $0x4be9,0x4(%esp)
    22e7:	00 
    22e8:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    22ef:	e8 bc 10 00 00       	call   33b0 <printf>
}
    22f4:	c9                   	leave  
    22f5:	c3                   	ret    
    22f6:	8d 76 00             	lea    0x0(%esi),%esi
    22f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00002300 <bigfile>:

void
bigfile(void)
{
    2300:	55                   	push   %ebp
    2301:	89 e5                	mov    %esp,%ebp
    2303:	83 ec 28             	sub    $0x28,%esp
  int fd, i, total, cc;

  printf(1, "bigfile test\n");
    2306:	c7 44 24 04 f4 4b 00 	movl   $0x4bf4,0x4(%esp)
    230d:	00 
    230e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2315:	e8 96 10 00 00       	call   33b0 <printf>

  unlink("bigfile");
    231a:	c7 04 24 02 4c 00 00 	movl   $0x4c02,(%esp)
    2321:	e8 ce 0e 00 00       	call   31f4 <unlink>
  fd = open("bigfile", O_CREATE | O_RDWR);
    2326:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    232d:	00 
    232e:	c7 04 24 02 4c 00 00 	movl   $0x4c02,(%esp)
    2335:	e8 aa 0e 00 00       	call   31e4 <open>
    233a:	89 45 f0             	mov    %eax,0xfffffff0(%ebp)
  if(fd < 0){
    233d:	83 7d f0 00          	cmpl   $0x0,0xfffffff0(%ebp)
    2341:	79 19                	jns    235c <bigfile+0x5c>
    printf(1, "cannot create bigfile");
    2343:	c7 44 24 04 0a 4c 00 	movl   $0x4c0a,0x4(%esp)
    234a:	00 
    234b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2352:	e8 59 10 00 00       	call   33b0 <printf>
    exit();
    2357:	e8 48 0e 00 00       	call   31a4 <exit>
  }
  for(i = 0; i < 20; i++){
    235c:	c7 45 f4 00 00 00 00 	movl   $0x0,0xfffffff4(%ebp)
    2363:	eb 5a                	jmp    23bf <bigfile+0xbf>
    memset(buf, i, 600);
    2365:	c7 44 24 08 58 02 00 	movl   $0x258,0x8(%esp)
    236c:	00 
    236d:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
    2370:	89 44 24 04          	mov    %eax,0x4(%esp)
    2374:	c7 04 24 80 52 00 00 	movl   $0x5280,(%esp)
    237b:	e8 50 0c 00 00       	call   2fd0 <memset>
    if(write(fd, buf, 600) != 600){
    2380:	c7 44 24 08 58 02 00 	movl   $0x258,0x8(%esp)
    2387:	00 
    2388:	c7 44 24 04 80 52 00 	movl   $0x5280,0x4(%esp)
    238f:	00 
    2390:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
    2393:	89 04 24             	mov    %eax,(%esp)
    2396:	e8 29 0e 00 00       	call   31c4 <write>
    239b:	3d 58 02 00 00       	cmp    $0x258,%eax
    23a0:	74 19                	je     23bb <bigfile+0xbb>
      printf(1, "write bigfile failed\n");
    23a2:	c7 44 24 04 20 4c 00 	movl   $0x4c20,0x4(%esp)
    23a9:	00 
    23aa:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    23b1:	e8 fa 0f 00 00       	call   33b0 <printf>
      exit();
    23b6:	e8 e9 0d 00 00       	call   31a4 <exit>
    23bb:	83 45 f4 01          	addl   $0x1,0xfffffff4(%ebp)
    23bf:	83 7d f4 13          	cmpl   $0x13,0xfffffff4(%ebp)
    23c3:	7e a0                	jle    2365 <bigfile+0x65>
    }
  }
  close(fd);
    23c5:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
    23c8:	89 04 24             	mov    %eax,(%esp)
    23cb:	e8 fc 0d 00 00       	call   31cc <close>

  fd = open("bigfile", 0);
    23d0:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    23d7:	00 
    23d8:	c7 04 24 02 4c 00 00 	movl   $0x4c02,(%esp)
    23df:	e8 00 0e 00 00       	call   31e4 <open>
    23e4:	89 45 f0             	mov    %eax,0xfffffff0(%ebp)
  if(fd < 0){
    23e7:	83 7d f0 00          	cmpl   $0x0,0xfffffff0(%ebp)
    23eb:	79 19                	jns    2406 <bigfile+0x106>
    printf(1, "cannot open bigfile\n");
    23ed:	c7 44 24 04 36 4c 00 	movl   $0x4c36,0x4(%esp)
    23f4:	00 
    23f5:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    23fc:	e8 af 0f 00 00       	call   33b0 <printf>
    exit();
    2401:	e8 9e 0d 00 00       	call   31a4 <exit>
  }
  total = 0;
    2406:	c7 45 f8 00 00 00 00 	movl   $0x0,0xfffffff8(%ebp)
  for(i = 0; ; i++){
    240d:	c7 45 f4 00 00 00 00 	movl   $0x0,0xfffffff4(%ebp)
    cc = read(fd, buf, 300);
    2414:	c7 44 24 08 2c 01 00 	movl   $0x12c,0x8(%esp)
    241b:	00 
    241c:	c7 44 24 04 80 52 00 	movl   $0x5280,0x4(%esp)
    2423:	00 
    2424:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
    2427:	89 04 24             	mov    %eax,(%esp)
    242a:	e8 8d 0d 00 00       	call   31bc <read>
    242f:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
    if(cc < 0){
    2432:	83 7d fc 00          	cmpl   $0x0,0xfffffffc(%ebp)
    2436:	79 19                	jns    2451 <bigfile+0x151>
      printf(1, "read bigfile failed\n");
    2438:	c7 44 24 04 4b 4c 00 	movl   $0x4c4b,0x4(%esp)
    243f:	00 
    2440:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2447:	e8 64 0f 00 00       	call   33b0 <printf>
      exit();
    244c:	e8 53 0d 00 00       	call   31a4 <exit>
    }
    if(cc == 0)
    2451:	83 7d fc 00          	cmpl   $0x0,0xfffffffc(%ebp)
    2455:	74 7e                	je     24d5 <bigfile+0x1d5>
      break;
    if(cc != 300){
    2457:	81 7d fc 2c 01 00 00 	cmpl   $0x12c,0xfffffffc(%ebp)
    245e:	74 19                	je     2479 <bigfile+0x179>
      printf(1, "short read bigfile\n");
    2460:	c7 44 24 04 60 4c 00 	movl   $0x4c60,0x4(%esp)
    2467:	00 
    2468:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    246f:	e8 3c 0f 00 00       	call   33b0 <printf>
      exit();
    2474:	e8 2b 0d 00 00       	call   31a4 <exit>
    }
    if(buf[0] != i/2 || buf[299] != i/2){
    2479:	0f b6 05 80 52 00 00 	movzbl 0x5280,%eax
    2480:	0f be c8             	movsbl %al,%ecx
    2483:	8b 55 f4             	mov    0xfffffff4(%ebp),%edx
    2486:	89 d0                	mov    %edx,%eax
    2488:	c1 e8 1f             	shr    $0x1f,%eax
    248b:	01 d0                	add    %edx,%eax
    248d:	d1 f8                	sar    %eax
    248f:	39 c1                	cmp    %eax,%ecx
    2491:	75 1a                	jne    24ad <bigfile+0x1ad>
    2493:	0f b6 05 ab 53 00 00 	movzbl 0x53ab,%eax
    249a:	0f be c8             	movsbl %al,%ecx
    249d:	8b 55 f4             	mov    0xfffffff4(%ebp),%edx
    24a0:	89 d0                	mov    %edx,%eax
    24a2:	c1 e8 1f             	shr    $0x1f,%eax
    24a5:	01 d0                	add    %edx,%eax
    24a7:	d1 f8                	sar    %eax
    24a9:	39 c1                	cmp    %eax,%ecx
    24ab:	74 19                	je     24c6 <bigfile+0x1c6>
      printf(1, "read bigfile wrong data\n");
    24ad:	c7 44 24 04 74 4c 00 	movl   $0x4c74,0x4(%esp)
    24b4:	00 
    24b5:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    24bc:	e8 ef 0e 00 00       	call   33b0 <printf>
      exit();
    24c1:	e8 de 0c 00 00       	call   31a4 <exit>
    }
    total += cc;
    24c6:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
    24c9:	01 45 f8             	add    %eax,0xfffffff8(%ebp)
    24cc:	83 45 f4 01          	addl   $0x1,0xfffffff4(%ebp)
  }
    24d0:	e9 3f ff ff ff       	jmp    2414 <bigfile+0x114>
  close(fd);
    24d5:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
    24d8:	89 04 24             	mov    %eax,(%esp)
    24db:	e8 ec 0c 00 00       	call   31cc <close>
  if(total != 20*600){
    24e0:	81 7d f8 e0 2e 00 00 	cmpl   $0x2ee0,0xfffffff8(%ebp)
    24e7:	74 19                	je     2502 <bigfile+0x202>
    printf(1, "read bigfile wrong total\n");
    24e9:	c7 44 24 04 8d 4c 00 	movl   $0x4c8d,0x4(%esp)
    24f0:	00 
    24f1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    24f8:	e8 b3 0e 00 00       	call   33b0 <printf>
    exit();
    24fd:	e8 a2 0c 00 00       	call   31a4 <exit>
  }
  unlink("bigfile");
    2502:	c7 04 24 02 4c 00 00 	movl   $0x4c02,(%esp)
    2509:	e8 e6 0c 00 00       	call   31f4 <unlink>

  printf(1, "bigfile test ok\n");
    250e:	c7 44 24 04 a7 4c 00 	movl   $0x4ca7,0x4(%esp)
    2515:	00 
    2516:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    251d:	e8 8e 0e 00 00       	call   33b0 <printf>
}
    2522:	c9                   	leave  
    2523:	c3                   	ret    
    2524:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    252a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00002530 <fourteen>:

void
fourteen(void)
{
    2530:	55                   	push   %ebp
    2531:	89 e5                	mov    %esp,%ebp
    2533:	83 ec 18             	sub    $0x18,%esp
  int fd;

  // DIRSIZ is 14.
  printf(1, "fourteen test\n");
    2536:	c7 44 24 04 b8 4c 00 	movl   $0x4cb8,0x4(%esp)
    253d:	00 
    253e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2545:	e8 66 0e 00 00       	call   33b0 <printf>

  if(mkdir("12345678901234") != 0){
    254a:	c7 04 24 c7 4c 00 00 	movl   $0x4cc7,(%esp)
    2551:	e8 b6 0c 00 00       	call   320c <mkdir>
    2556:	85 c0                	test   %eax,%eax
    2558:	74 19                	je     2573 <fourteen+0x43>
    printf(1, "mkdir 12345678901234 failed\n");
    255a:	c7 44 24 04 d6 4c 00 	movl   $0x4cd6,0x4(%esp)
    2561:	00 
    2562:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2569:	e8 42 0e 00 00       	call   33b0 <printf>
    exit();
    256e:	e8 31 0c 00 00       	call   31a4 <exit>
  }
  if(mkdir("12345678901234/123456789012345") != 0){
    2573:	c7 04 24 f4 4c 00 00 	movl   $0x4cf4,(%esp)
    257a:	e8 8d 0c 00 00       	call   320c <mkdir>
    257f:	85 c0                	test   %eax,%eax
    2581:	74 19                	je     259c <fourteen+0x6c>
    printf(1, "mkdir 12345678901234/123456789012345 failed\n");
    2583:	c7 44 24 04 14 4d 00 	movl   $0x4d14,0x4(%esp)
    258a:	00 
    258b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2592:	e8 19 0e 00 00       	call   33b0 <printf>
    exit();
    2597:	e8 08 0c 00 00       	call   31a4 <exit>
  }
  fd = open("123456789012345/123456789012345/123456789012345", O_CREATE);
    259c:	c7 44 24 04 00 02 00 	movl   $0x200,0x4(%esp)
    25a3:	00 
    25a4:	c7 04 24 44 4d 00 00 	movl   $0x4d44,(%esp)
    25ab:	e8 34 0c 00 00       	call   31e4 <open>
    25b0:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
  if(fd < 0){
    25b3:	83 7d fc 00          	cmpl   $0x0,0xfffffffc(%ebp)
    25b7:	79 19                	jns    25d2 <fourteen+0xa2>
    printf(1, "create 123456789012345/123456789012345/123456789012345 failed\n");
    25b9:	c7 44 24 04 74 4d 00 	movl   $0x4d74,0x4(%esp)
    25c0:	00 
    25c1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    25c8:	e8 e3 0d 00 00       	call   33b0 <printf>
    exit();
    25cd:	e8 d2 0b 00 00       	call   31a4 <exit>
  }
  close(fd);
    25d2:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
    25d5:	89 04 24             	mov    %eax,(%esp)
    25d8:	e8 ef 0b 00 00       	call   31cc <close>
  fd = open("12345678901234/12345678901234/12345678901234", 0);
    25dd:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    25e4:	00 
    25e5:	c7 04 24 b4 4d 00 00 	movl   $0x4db4,(%esp)
    25ec:	e8 f3 0b 00 00       	call   31e4 <open>
    25f1:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
  if(fd < 0){
    25f4:	83 7d fc 00          	cmpl   $0x0,0xfffffffc(%ebp)
    25f8:	79 19                	jns    2613 <fourteen+0xe3>
    printf(1, "open 12345678901234/12345678901234/12345678901234 failed\n");
    25fa:	c7 44 24 04 e4 4d 00 	movl   $0x4de4,0x4(%esp)
    2601:	00 
    2602:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2609:	e8 a2 0d 00 00       	call   33b0 <printf>
    exit();
    260e:	e8 91 0b 00 00       	call   31a4 <exit>
  }
  close(fd);
    2613:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
    2616:	89 04 24             	mov    %eax,(%esp)
    2619:	e8 ae 0b 00 00       	call   31cc <close>

  if(mkdir("12345678901234/12345678901234") == 0){
    261e:	c7 04 24 1e 4e 00 00 	movl   $0x4e1e,(%esp)
    2625:	e8 e2 0b 00 00       	call   320c <mkdir>
    262a:	85 c0                	test   %eax,%eax
    262c:	75 19                	jne    2647 <fourteen+0x117>
    printf(1, "mkdir 12345678901234/12345678901234 succeeded!\n");
    262e:	c7 44 24 04 3c 4e 00 	movl   $0x4e3c,0x4(%esp)
    2635:	00 
    2636:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    263d:	e8 6e 0d 00 00       	call   33b0 <printf>
    exit();
    2642:	e8 5d 0b 00 00       	call   31a4 <exit>
  }
  if(mkdir("123456789012345/12345678901234") == 0){
    2647:	c7 04 24 6c 4e 00 00 	movl   $0x4e6c,(%esp)
    264e:	e8 b9 0b 00 00       	call   320c <mkdir>
    2653:	85 c0                	test   %eax,%eax
    2655:	75 19                	jne    2670 <fourteen+0x140>
    printf(1, "mkdir 12345678901234/123456789012345 succeeded!\n");
    2657:	c7 44 24 04 8c 4e 00 	movl   $0x4e8c,0x4(%esp)
    265e:	00 
    265f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2666:	e8 45 0d 00 00       	call   33b0 <printf>
    exit();
    266b:	e8 34 0b 00 00       	call   31a4 <exit>
  }

  printf(1, "fourteen ok\n");
    2670:	c7 44 24 04 bd 4e 00 	movl   $0x4ebd,0x4(%esp)
    2677:	00 
    2678:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    267f:	e8 2c 0d 00 00       	call   33b0 <printf>
}
    2684:	c9                   	leave  
    2685:	c3                   	ret    
    2686:	8d 76 00             	lea    0x0(%esi),%esi
    2689:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00002690 <rmdot>:

void
rmdot(void)
{
    2690:	55                   	push   %ebp
    2691:	89 e5                	mov    %esp,%ebp
    2693:	83 ec 08             	sub    $0x8,%esp
  printf(1, "rmdot test\n");
    2696:	c7 44 24 04 ca 4e 00 	movl   $0x4eca,0x4(%esp)
    269d:	00 
    269e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    26a5:	e8 06 0d 00 00       	call   33b0 <printf>
  if(mkdir("dots") != 0){
    26aa:	c7 04 24 d6 4e 00 00 	movl   $0x4ed6,(%esp)
    26b1:	e8 56 0b 00 00       	call   320c <mkdir>
    26b6:	85 c0                	test   %eax,%eax
    26b8:	74 19                	je     26d3 <rmdot+0x43>
    printf(1, "mkdir dots failed\n");
    26ba:	c7 44 24 04 db 4e 00 	movl   $0x4edb,0x4(%esp)
    26c1:	00 
    26c2:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    26c9:	e8 e2 0c 00 00       	call   33b0 <printf>
    exit();
    26ce:	e8 d1 0a 00 00       	call   31a4 <exit>
  }
  if(chdir("dots") != 0){
    26d3:	c7 04 24 d6 4e 00 00 	movl   $0x4ed6,(%esp)
    26da:	e8 35 0b 00 00       	call   3214 <chdir>
    26df:	85 c0                	test   %eax,%eax
    26e1:	74 19                	je     26fc <rmdot+0x6c>
    printf(1, "chdir dots failed\n");
    26e3:	c7 44 24 04 ee 4e 00 	movl   $0x4eee,0x4(%esp)
    26ea:	00 
    26eb:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    26f2:	e8 b9 0c 00 00       	call   33b0 <printf>
    exit();
    26f7:	e8 a8 0a 00 00       	call   31a4 <exit>
  }
  if(unlink(".") == 0){
    26fc:	c7 04 24 7b 46 00 00 	movl   $0x467b,(%esp)
    2703:	e8 ec 0a 00 00       	call   31f4 <unlink>
    2708:	85 c0                	test   %eax,%eax
    270a:	75 19                	jne    2725 <rmdot+0x95>
    printf(1, "rm . worked!\n");
    270c:	c7 44 24 04 01 4f 00 	movl   $0x4f01,0x4(%esp)
    2713:	00 
    2714:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    271b:	e8 90 0c 00 00       	call   33b0 <printf>
    exit();
    2720:	e8 7f 0a 00 00       	call   31a4 <exit>
  }
  if(unlink("..") == 0){
    2725:	c7 04 24 3c 42 00 00 	movl   $0x423c,(%esp)
    272c:	e8 c3 0a 00 00       	call   31f4 <unlink>
    2731:	85 c0                	test   %eax,%eax
    2733:	75 19                	jne    274e <rmdot+0xbe>
    printf(1, "rm .. worked!\n");
    2735:	c7 44 24 04 0f 4f 00 	movl   $0x4f0f,0x4(%esp)
    273c:	00 
    273d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2744:	e8 67 0c 00 00       	call   33b0 <printf>
    exit();
    2749:	e8 56 0a 00 00       	call   31a4 <exit>
  }
  if(chdir("/") != 0){
    274e:	c7 04 24 1e 4f 00 00 	movl   $0x4f1e,(%esp)
    2755:	e8 ba 0a 00 00       	call   3214 <chdir>
    275a:	85 c0                	test   %eax,%eax
    275c:	74 19                	je     2777 <rmdot+0xe7>
    printf(1, "chdir / failed\n");
    275e:	c7 44 24 04 20 4f 00 	movl   $0x4f20,0x4(%esp)
    2765:	00 
    2766:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    276d:	e8 3e 0c 00 00       	call   33b0 <printf>
    exit();
    2772:	e8 2d 0a 00 00       	call   31a4 <exit>
  }
  if(unlink("dots/.") == 0){
    2777:	c7 04 24 30 4f 00 00 	movl   $0x4f30,(%esp)
    277e:	e8 71 0a 00 00       	call   31f4 <unlink>
    2783:	85 c0                	test   %eax,%eax
    2785:	75 19                	jne    27a0 <rmdot+0x110>
    printf(1, "unlink dots/. worked!\n");
    2787:	c7 44 24 04 37 4f 00 	movl   $0x4f37,0x4(%esp)
    278e:	00 
    278f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2796:	e8 15 0c 00 00       	call   33b0 <printf>
    exit();
    279b:	e8 04 0a 00 00       	call   31a4 <exit>
  }
  if(unlink("dots/..") == 0){
    27a0:	c7 04 24 4e 4f 00 00 	movl   $0x4f4e,(%esp)
    27a7:	e8 48 0a 00 00       	call   31f4 <unlink>
    27ac:	85 c0                	test   %eax,%eax
    27ae:	75 19                	jne    27c9 <rmdot+0x139>
    printf(1, "unlink dots/.. worked!\n");
    27b0:	c7 44 24 04 56 4f 00 	movl   $0x4f56,0x4(%esp)
    27b7:	00 
    27b8:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    27bf:	e8 ec 0b 00 00       	call   33b0 <printf>
    exit();
    27c4:	e8 db 09 00 00       	call   31a4 <exit>
  }
  if(unlink("dots") != 0){
    27c9:	c7 04 24 d6 4e 00 00 	movl   $0x4ed6,(%esp)
    27d0:	e8 1f 0a 00 00       	call   31f4 <unlink>
    27d5:	85 c0                	test   %eax,%eax
    27d7:	74 19                	je     27f2 <rmdot+0x162>
    printf(1, "unlink dots failed!\n");
    27d9:	c7 44 24 04 6e 4f 00 	movl   $0x4f6e,0x4(%esp)
    27e0:	00 
    27e1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    27e8:	e8 c3 0b 00 00       	call   33b0 <printf>
    exit();
    27ed:	e8 b2 09 00 00       	call   31a4 <exit>
  }
  printf(1, "rmdot ok\n");
    27f2:	c7 44 24 04 83 4f 00 	movl   $0x4f83,0x4(%esp)
    27f9:	00 
    27fa:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2801:	e8 aa 0b 00 00       	call   33b0 <printf>
}
    2806:	c9                   	leave  
    2807:	c3                   	ret    
    2808:	90                   	nop    
    2809:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi

00002810 <dirfile>:

void
dirfile(void)
{
    2810:	55                   	push   %ebp
    2811:	89 e5                	mov    %esp,%ebp
    2813:	83 ec 28             	sub    $0x28,%esp
  int fd;

  printf(1, "dir vs file\n");
    2816:	c7 44 24 04 8d 4f 00 	movl   $0x4f8d,0x4(%esp)
    281d:	00 
    281e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2825:	e8 86 0b 00 00       	call   33b0 <printf>

  fd = open("dirfile", O_CREATE);
    282a:	c7 44 24 04 00 02 00 	movl   $0x200,0x4(%esp)
    2831:	00 
    2832:	c7 04 24 9a 4f 00 00 	movl   $0x4f9a,(%esp)
    2839:	e8 a6 09 00 00       	call   31e4 <open>
    283e:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
  if(fd < 0){
    2841:	83 7d fc 00          	cmpl   $0x0,0xfffffffc(%ebp)
    2845:	79 19                	jns    2860 <dirfile+0x50>
    printf(1, "create dirfile failed\n");
    2847:	c7 44 24 04 a2 4f 00 	movl   $0x4fa2,0x4(%esp)
    284e:	00 
    284f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2856:	e8 55 0b 00 00       	call   33b0 <printf>
    exit();
    285b:	e8 44 09 00 00       	call   31a4 <exit>
  }
  close(fd);
    2860:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
    2863:	89 04 24             	mov    %eax,(%esp)
    2866:	e8 61 09 00 00       	call   31cc <close>
  if(chdir("dirfile") == 0){
    286b:	c7 04 24 9a 4f 00 00 	movl   $0x4f9a,(%esp)
    2872:	e8 9d 09 00 00       	call   3214 <chdir>
    2877:	85 c0                	test   %eax,%eax
    2879:	75 19                	jne    2894 <dirfile+0x84>
    printf(1, "chdir dirfile succeeded!\n");
    287b:	c7 44 24 04 b9 4f 00 	movl   $0x4fb9,0x4(%esp)
    2882:	00 
    2883:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    288a:	e8 21 0b 00 00       	call   33b0 <printf>
    exit();
    288f:	e8 10 09 00 00       	call   31a4 <exit>
  }
  fd = open("dirfile/xx", 0);
    2894:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    289b:	00 
    289c:	c7 04 24 d3 4f 00 00 	movl   $0x4fd3,(%esp)
    28a3:	e8 3c 09 00 00       	call   31e4 <open>
    28a8:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
  if(fd >= 0){
    28ab:	83 7d fc 00          	cmpl   $0x0,0xfffffffc(%ebp)
    28af:	78 19                	js     28ca <dirfile+0xba>
    printf(1, "create dirfile/xx succeeded!\n");
    28b1:	c7 44 24 04 de 4f 00 	movl   $0x4fde,0x4(%esp)
    28b8:	00 
    28b9:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    28c0:	e8 eb 0a 00 00       	call   33b0 <printf>
    exit();
    28c5:	e8 da 08 00 00       	call   31a4 <exit>
  }
  fd = open("dirfile/xx", O_CREATE);
    28ca:	c7 44 24 04 00 02 00 	movl   $0x200,0x4(%esp)
    28d1:	00 
    28d2:	c7 04 24 d3 4f 00 00 	movl   $0x4fd3,(%esp)
    28d9:	e8 06 09 00 00       	call   31e4 <open>
    28de:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
  if(fd >= 0){
    28e1:	83 7d fc 00          	cmpl   $0x0,0xfffffffc(%ebp)
    28e5:	78 19                	js     2900 <dirfile+0xf0>
    printf(1, "create dirfile/xx succeeded!\n");
    28e7:	c7 44 24 04 de 4f 00 	movl   $0x4fde,0x4(%esp)
    28ee:	00 
    28ef:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    28f6:	e8 b5 0a 00 00       	call   33b0 <printf>
    exit();
    28fb:	e8 a4 08 00 00       	call   31a4 <exit>
  }
  if(mkdir("dirfile/xx") == 0){
    2900:	c7 04 24 d3 4f 00 00 	movl   $0x4fd3,(%esp)
    2907:	e8 00 09 00 00       	call   320c <mkdir>
    290c:	85 c0                	test   %eax,%eax
    290e:	75 19                	jne    2929 <dirfile+0x119>
    printf(1, "mkdir dirfile/xx succeeded!\n");
    2910:	c7 44 24 04 fc 4f 00 	movl   $0x4ffc,0x4(%esp)
    2917:	00 
    2918:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    291f:	e8 8c 0a 00 00       	call   33b0 <printf>
    exit();
    2924:	e8 7b 08 00 00       	call   31a4 <exit>
  }
  if(unlink("dirfile/xx") == 0){
    2929:	c7 04 24 d3 4f 00 00 	movl   $0x4fd3,(%esp)
    2930:	e8 bf 08 00 00       	call   31f4 <unlink>
    2935:	85 c0                	test   %eax,%eax
    2937:	75 19                	jne    2952 <dirfile+0x142>
    printf(1, "unlink dirfile/xx succeeded!\n");
    2939:	c7 44 24 04 19 50 00 	movl   $0x5019,0x4(%esp)
    2940:	00 
    2941:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2948:	e8 63 0a 00 00       	call   33b0 <printf>
    exit();
    294d:	e8 52 08 00 00       	call   31a4 <exit>
  }
  if(link("README", "dirfile/xx") == 0){
    2952:	c7 44 24 04 d3 4f 00 	movl   $0x4fd3,0x4(%esp)
    2959:	00 
    295a:	c7 04 24 4e 3f 00 00 	movl   $0x3f4e,(%esp)
    2961:	e8 9e 08 00 00       	call   3204 <link>
    2966:	85 c0                	test   %eax,%eax
    2968:	75 19                	jne    2983 <dirfile+0x173>
    printf(1, "link to dirfile/xx succeeded!\n");
    296a:	c7 44 24 04 38 50 00 	movl   $0x5038,0x4(%esp)
    2971:	00 
    2972:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2979:	e8 32 0a 00 00       	call   33b0 <printf>
    exit();
    297e:	e8 21 08 00 00       	call   31a4 <exit>
  }
  if(unlink("dirfile") != 0){
    2983:	c7 04 24 9a 4f 00 00 	movl   $0x4f9a,(%esp)
    298a:	e8 65 08 00 00       	call   31f4 <unlink>
    298f:	85 c0                	test   %eax,%eax
    2991:	74 19                	je     29ac <dirfile+0x19c>
    printf(1, "unlink dirfile failed!\n");
    2993:	c7 44 24 04 57 50 00 	movl   $0x5057,0x4(%esp)
    299a:	00 
    299b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    29a2:	e8 09 0a 00 00       	call   33b0 <printf>
    exit();
    29a7:	e8 f8 07 00 00       	call   31a4 <exit>
  }

  fd = open(".", O_RDWR);
    29ac:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
    29b3:	00 
    29b4:	c7 04 24 7b 46 00 00 	movl   $0x467b,(%esp)
    29bb:	e8 24 08 00 00       	call   31e4 <open>
    29c0:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
  if(fd >= 0){
    29c3:	83 7d fc 00          	cmpl   $0x0,0xfffffffc(%ebp)
    29c7:	78 19                	js     29e2 <dirfile+0x1d2>
    printf(1, "open . for writing succeeded!\n");
    29c9:	c7 44 24 04 70 50 00 	movl   $0x5070,0x4(%esp)
    29d0:	00 
    29d1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    29d8:	e8 d3 09 00 00       	call   33b0 <printf>
    exit();
    29dd:	e8 c2 07 00 00       	call   31a4 <exit>
  }
  fd = open(".", 0);
    29e2:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    29e9:	00 
    29ea:	c7 04 24 7b 46 00 00 	movl   $0x467b,(%esp)
    29f1:	e8 ee 07 00 00       	call   31e4 <open>
    29f6:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
  if(write(fd, "x", 1) > 0){
    29f9:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    2a00:	00 
    2a01:	c7 44 24 04 dc 42 00 	movl   $0x42dc,0x4(%esp)
    2a08:	00 
    2a09:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
    2a0c:	89 04 24             	mov    %eax,(%esp)
    2a0f:	e8 b0 07 00 00       	call   31c4 <write>
    2a14:	85 c0                	test   %eax,%eax
    2a16:	7e 19                	jle    2a31 <dirfile+0x221>
    printf(1, "write . succeeded!\n");
    2a18:	c7 44 24 04 8f 50 00 	movl   $0x508f,0x4(%esp)
    2a1f:	00 
    2a20:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2a27:	e8 84 09 00 00       	call   33b0 <printf>
    exit();
    2a2c:	e8 73 07 00 00       	call   31a4 <exit>
  }
  close(fd);
    2a31:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
    2a34:	89 04 24             	mov    %eax,(%esp)
    2a37:	e8 90 07 00 00       	call   31cc <close>

  printf(1, "dir vs file OK\n");
    2a3c:	c7 44 24 04 a3 50 00 	movl   $0x50a3,0x4(%esp)
    2a43:	00 
    2a44:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2a4b:	e8 60 09 00 00       	call   33b0 <printf>
}
    2a50:	c9                   	leave  
    2a51:	c3                   	ret    
    2a52:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi
    2a59:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00002a60 <iref>:

// test that iput() is called at the end of _namei()
void
iref(void)
{
    2a60:	55                   	push   %ebp
    2a61:	89 e5                	mov    %esp,%ebp
    2a63:	83 ec 18             	sub    $0x18,%esp
  int i, fd;

  printf(1, "empty file name\n");
    2a66:	c7 44 24 04 b3 50 00 	movl   $0x50b3,0x4(%esp)
    2a6d:	00 
    2a6e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2a75:	e8 36 09 00 00       	call   33b0 <printf>

  // the 50 is NINODE
  for(i = 0; i < 50 + 1; i++){
    2a7a:	c7 45 f8 00 00 00 00 	movl   $0x0,0xfffffff8(%ebp)
    2a81:	e9 d2 00 00 00       	jmp    2b58 <iref+0xf8>
    if(mkdir("irefd") != 0){
    2a86:	c7 04 24 c4 50 00 00 	movl   $0x50c4,(%esp)
    2a8d:	e8 7a 07 00 00       	call   320c <mkdir>
    2a92:	85 c0                	test   %eax,%eax
    2a94:	74 19                	je     2aaf <iref+0x4f>
      printf(1, "mkdir irefd failed\n");
    2a96:	c7 44 24 04 ca 50 00 	movl   $0x50ca,0x4(%esp)
    2a9d:	00 
    2a9e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2aa5:	e8 06 09 00 00       	call   33b0 <printf>
      exit();
    2aaa:	e8 f5 06 00 00       	call   31a4 <exit>
    }
    if(chdir("irefd") != 0){
    2aaf:	c7 04 24 c4 50 00 00 	movl   $0x50c4,(%esp)
    2ab6:	e8 59 07 00 00       	call   3214 <chdir>
    2abb:	85 c0                	test   %eax,%eax
    2abd:	74 19                	je     2ad8 <iref+0x78>
      printf(1, "chdir irefd failed\n");
    2abf:	c7 44 24 04 de 50 00 	movl   $0x50de,0x4(%esp)
    2ac6:	00 
    2ac7:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2ace:	e8 dd 08 00 00       	call   33b0 <printf>
      exit();
    2ad3:	e8 cc 06 00 00       	call   31a4 <exit>
    }

    mkdir("");
    2ad8:	c7 04 24 f2 50 00 00 	movl   $0x50f2,(%esp)
    2adf:	e8 28 07 00 00       	call   320c <mkdir>
    link("README", "");
    2ae4:	c7 44 24 04 f2 50 00 	movl   $0x50f2,0x4(%esp)
    2aeb:	00 
    2aec:	c7 04 24 4e 3f 00 00 	movl   $0x3f4e,(%esp)
    2af3:	e8 0c 07 00 00       	call   3204 <link>
    fd = open("", O_CREATE);
    2af8:	c7 44 24 04 00 02 00 	movl   $0x200,0x4(%esp)
    2aff:	00 
    2b00:	c7 04 24 f2 50 00 00 	movl   $0x50f2,(%esp)
    2b07:	e8 d8 06 00 00       	call   31e4 <open>
    2b0c:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
    if(fd >= 0)
    2b0f:	83 7d fc 00          	cmpl   $0x0,0xfffffffc(%ebp)
    2b13:	78 0b                	js     2b20 <iref+0xc0>
      close(fd);
    2b15:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
    2b18:	89 04 24             	mov    %eax,(%esp)
    2b1b:	e8 ac 06 00 00       	call   31cc <close>
    fd = open("xx", O_CREATE);
    2b20:	c7 44 24 04 00 02 00 	movl   $0x200,0x4(%esp)
    2b27:	00 
    2b28:	c7 04 24 f3 50 00 00 	movl   $0x50f3,(%esp)
    2b2f:	e8 b0 06 00 00       	call   31e4 <open>
    2b34:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
    if(fd >= 0)
    2b37:	83 7d fc 00          	cmpl   $0x0,0xfffffffc(%ebp)
    2b3b:	78 0b                	js     2b48 <iref+0xe8>
      close(fd);
    2b3d:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
    2b40:	89 04 24             	mov    %eax,(%esp)
    2b43:	e8 84 06 00 00       	call   31cc <close>
    unlink("xx");
    2b48:	c7 04 24 f3 50 00 00 	movl   $0x50f3,(%esp)
    2b4f:	e8 a0 06 00 00       	call   31f4 <unlink>
    2b54:	83 45 f8 01          	addl   $0x1,0xfffffff8(%ebp)
    2b58:	83 7d f8 32          	cmpl   $0x32,0xfffffff8(%ebp)
    2b5c:	0f 8e 24 ff ff ff    	jle    2a86 <iref+0x26>
  }

  chdir("/");
    2b62:	c7 04 24 1e 4f 00 00 	movl   $0x4f1e,(%esp)
    2b69:	e8 a6 06 00 00       	call   3214 <chdir>
  printf(1, "empty file name OK\n");
    2b6e:	c7 44 24 04 f6 50 00 	movl   $0x50f6,0x4(%esp)
    2b75:	00 
    2b76:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2b7d:	e8 2e 08 00 00       	call   33b0 <printf>
}
    2b82:	c9                   	leave  
    2b83:	c3                   	ret    
    2b84:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    2b8a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00002b90 <forktest>:

// test that fork fails gracefully
// the forktest binary also does this, but it runs out of proc entries first.
// inside the bigger usertests binary, we run out of memory first.
void
forktest(void)
{
    2b90:	55                   	push   %ebp
    2b91:	89 e5                	mov    %esp,%ebp
    2b93:	83 ec 18             	sub    $0x18,%esp
  int n, pid;

  printf(1, "fork test\n");
    2b96:	c7 44 24 04 0a 51 00 	movl   $0x510a,0x4(%esp)
    2b9d:	00 
    2b9e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2ba5:	e8 06 08 00 00       	call   33b0 <printf>

  for(n=0; n<1000; n++){
    2baa:	c7 45 f8 00 00 00 00 	movl   $0x0,0xfffffff8(%ebp)
    2bb1:	eb 1d                	jmp    2bd0 <forktest+0x40>
    pid = fork();
    2bb3:	e8 e4 05 00 00       	call   319c <fork>
    2bb8:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
    if(pid < 0)
    2bbb:	83 7d fc 00          	cmpl   $0x0,0xfffffffc(%ebp)
    2bbf:	78 18                	js     2bd9 <forktest+0x49>
      break;
    if(pid == 0)
    2bc1:	83 7d fc 00          	cmpl   $0x0,0xfffffffc(%ebp)
    2bc5:	75 05                	jne    2bcc <forktest+0x3c>
      exit();
    2bc7:	e8 d8 05 00 00       	call   31a4 <exit>
    2bcc:	83 45 f8 01          	addl   $0x1,0xfffffff8(%ebp)
    2bd0:	81 7d f8 e7 03 00 00 	cmpl   $0x3e7,0xfffffff8(%ebp)
    2bd7:	7e da                	jle    2bb3 <forktest+0x23>
  }
  
  if(n == 1000){
    2bd9:	81 7d f8 e8 03 00 00 	cmpl   $0x3e8,0xfffffff8(%ebp)
    2be0:	75 3f                	jne    2c21 <forktest+0x91>
    printf(1, "fork claimed to work 1000 times!\n");
    2be2:	c7 44 24 04 18 51 00 	movl   $0x5118,0x4(%esp)
    2be9:	00 
    2bea:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2bf1:	e8 ba 07 00 00       	call   33b0 <printf>
    exit();
    2bf6:	e8 a9 05 00 00       	call   31a4 <exit>
  }
  
  for(; n > 0; n--){
    if(wait() < 0){
    2bfb:	e8 ac 05 00 00       	call   31ac <wait>
    2c00:	85 c0                	test   %eax,%eax
    2c02:	79 19                	jns    2c1d <forktest+0x8d>
      printf(1, "wait stopped early\n");
    2c04:	c7 44 24 04 3a 51 00 	movl   $0x513a,0x4(%esp)
    2c0b:	00 
    2c0c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2c13:	e8 98 07 00 00       	call   33b0 <printf>
      exit();
    2c18:	e8 87 05 00 00       	call   31a4 <exit>
    2c1d:	83 6d f8 01          	subl   $0x1,0xfffffff8(%ebp)
    2c21:	83 7d f8 00          	cmpl   $0x0,0xfffffff8(%ebp)
    2c25:	7f d4                	jg     2bfb <forktest+0x6b>
    }
  }
  
  if(wait() != -1){
    2c27:	e8 80 05 00 00       	call   31ac <wait>
    2c2c:	83 f8 ff             	cmp    $0xffffffff,%eax
    2c2f:	74 19                	je     2c4a <forktest+0xba>
    printf(1, "wait got too many\n");
    2c31:	c7 44 24 04 4e 51 00 	movl   $0x514e,0x4(%esp)
    2c38:	00 
    2c39:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2c40:	e8 6b 07 00 00       	call   33b0 <printf>
    exit();
    2c45:	e8 5a 05 00 00       	call   31a4 <exit>
  }
  
  printf(1, "fork test OK\n");
    2c4a:	c7 44 24 04 61 51 00 	movl   $0x5161,0x4(%esp)
    2c51:	00 
    2c52:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2c59:	e8 52 07 00 00       	call   33b0 <printf>
}
    2c5e:	c9                   	leave  
    2c5f:	c3                   	ret    

00002c60 <uptimetest>:

void
uptimetest(void)
{
    2c60:	55                   	push   %ebp
    2c61:	89 e5                	mov    %esp,%ebp
    2c63:	56                   	push   %esi
    2c64:	53                   	push   %ebx
    2c65:	83 ec 40             	sub    $0x40,%esp
    int msec, sec;
    printf(1, "uptime test\n");
    2c68:	c7 44 24 04 6f 51 00 	movl   $0x516f,0x4(%esp)
    2c6f:	00 
    2c70:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2c77:	e8 34 07 00 00       	call   33b0 <printf>

    msec = upmsec();
    2c7c:	e8 bb 05 00 00       	call   323c <upmsec>
    2c81:	89 45 f0             	mov    %eax,0xfffffff0(%ebp)
    sec = msec / 1000;
    2c84:	8b 4d f0             	mov    0xfffffff0(%ebp),%ecx
    2c87:	c7 45 d8 d3 4d 62 10 	movl   $0x10624dd3,0xffffffd8(%ebp)
    2c8e:	8b 45 d8             	mov    0xffffffd8(%ebp),%eax
    2c91:	f7 e9                	imul   %ecx
    2c93:	c1 fa 06             	sar    $0x6,%edx
    2c96:	89 c8                	mov    %ecx,%eax
    2c98:	c1 f8 1f             	sar    $0x1f,%eax
    2c9b:	89 d1                	mov    %edx,%ecx
    2c9d:	29 c1                	sub    %eax,%ecx
    2c9f:	89 c8                	mov    %ecx,%eax
    2ca1:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
    msec %= 1000;
    2ca4:	8b 4d f0             	mov    0xfffffff0(%ebp),%ecx
    2ca7:	c7 45 d8 d3 4d 62 10 	movl   $0x10624dd3,0xffffffd8(%ebp)
    2cae:	8b 45 d8             	mov    0xffffffd8(%ebp),%eax
    2cb1:	f7 e9                	imul   %ecx
    2cb3:	c1 fa 06             	sar    $0x6,%edx
    2cb6:	89 c8                	mov    %ecx,%eax
    2cb8:	c1 f8 1f             	sar    $0x1f,%eax
    2cbb:	89 d3                	mov    %edx,%ebx
    2cbd:	29 c3                	sub    %eax,%ebx
    2cbf:	89 d8                	mov    %ebx,%eax
    2cc1:	69 c0 e8 03 00 00    	imul   $0x3e8,%eax,%eax
    2cc7:	89 ce                	mov    %ecx,%esi
    2cc9:	29 c6                	sub    %eax,%esi
    2ccb:	89 f0                	mov    %esi,%eax
    2ccd:	89 45 f0             	mov    %eax,0xfffffff0(%ebp)
    printf(1, "up time: %d d %d h %d m %d s %d msec\n",
    2cd0:	8b 4d f4             	mov    0xfffffff4(%ebp),%ecx
    2cd3:	c7 45 d8 89 88 88 88 	movl   $0x88888889,0xffffffd8(%ebp)
    2cda:	8b 45 d8             	mov    0xffffffd8(%ebp),%eax
    2cdd:	f7 e9                	imul   %ecx
    2cdf:	8d 04 0a             	lea    (%edx,%ecx,1),%eax
    2ce2:	89 c2                	mov    %eax,%edx
    2ce4:	c1 fa 05             	sar    $0x5,%edx
    2ce7:	89 c8                	mov    %ecx,%eax
    2ce9:	c1 f8 1f             	sar    $0x1f,%eax
    2cec:	89 d3                	mov    %edx,%ebx
    2cee:	29 c3                	sub    %eax,%ebx
    2cf0:	89 5d dc             	mov    %ebx,0xffffffdc(%ebp)
    2cf3:	8b 45 dc             	mov    0xffffffdc(%ebp),%eax
    2cf6:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
    2cfd:	89 d0                	mov    %edx,%eax
    2cff:	c1 e0 04             	shl    $0x4,%eax
    2d02:	29 d0                	sub    %edx,%eax
    2d04:	89 ce                	mov    %ecx,%esi
    2d06:	29 c6                	sub    %eax,%esi
    2d08:	89 75 dc             	mov    %esi,0xffffffdc(%ebp)
    2d0b:	8b 4d f4             	mov    0xfffffff4(%ebp),%ecx
    2d0e:	c7 45 d8 c5 b3 a2 91 	movl   $0x91a2b3c5,0xffffffd8(%ebp)
    2d15:	8b 45 d8             	mov    0xffffffd8(%ebp),%eax
    2d18:	f7 e9                	imul   %ecx
    2d1a:	8d 04 0a             	lea    (%edx,%ecx,1),%eax
    2d1d:	89 c2                	mov    %eax,%edx
    2d1f:	c1 fa 0b             	sar    $0xb,%edx
    2d22:	89 c8                	mov    %ecx,%eax
    2d24:	c1 f8 1f             	sar    $0x1f,%eax
    2d27:	89 d3                	mov    %edx,%ebx
    2d29:	29 c3                	sub    %eax,%ebx
    2d2b:	89 5d e0             	mov    %ebx,0xffffffe0(%ebp)
    2d2e:	69 45 e0 10 0e 00 00 	imul   $0xe10,0xffffffe0(%ebp),%eax
    2d35:	89 ce                	mov    %ecx,%esi
    2d37:	29 c6                	sub    %eax,%esi
    2d39:	89 75 e0             	mov    %esi,0xffffffe0(%ebp)
    2d3c:	c7 45 d8 89 88 88 88 	movl   $0x88888889,0xffffffd8(%ebp)
    2d43:	8b 45 d8             	mov    0xffffffd8(%ebp),%eax
    2d46:	f7 6d e0             	imull  0xffffffe0(%ebp)
    2d49:	8b 4d e0             	mov    0xffffffe0(%ebp),%ecx
    2d4c:	8d 04 0a             	lea    (%edx,%ecx,1),%eax
    2d4f:	89 c2                	mov    %eax,%edx
    2d51:	c1 fa 05             	sar    $0x5,%edx
    2d54:	8b 45 e0             	mov    0xffffffe0(%ebp),%eax
    2d57:	c1 f8 1f             	sar    $0x1f,%eax
    2d5a:	89 d3                	mov    %edx,%ebx
    2d5c:	29 c3                	sub    %eax,%ebx
    2d5e:	8b 4d f4             	mov    0xfffffff4(%ebp),%ecx
    2d61:	c7 45 d8 07 45 2e c2 	movl   $0xc22e4507,0xffffffd8(%ebp)
    2d68:	8b 45 d8             	mov    0xffffffd8(%ebp),%eax
    2d6b:	f7 e9                	imul   %ecx
    2d6d:	8d 04 0a             	lea    (%edx,%ecx,1),%eax
    2d70:	89 c2                	mov    %eax,%edx
    2d72:	c1 fa 10             	sar    $0x10,%edx
    2d75:	89 c8                	mov    %ecx,%eax
    2d77:	c1 f8 1f             	sar    $0x1f,%eax
    2d7a:	89 d6                	mov    %edx,%esi
    2d7c:	29 c6                	sub    %eax,%esi
    2d7e:	89 75 e4             	mov    %esi,0xffffffe4(%ebp)
    2d81:	69 45 e4 80 51 01 00 	imul   $0x15180,0xffffffe4(%ebp),%eax
    2d88:	89 ca                	mov    %ecx,%edx
    2d8a:	29 c2                	sub    %eax,%edx
    2d8c:	89 55 e4             	mov    %edx,0xffffffe4(%ebp)
    2d8f:	c7 45 d8 c5 b3 a2 91 	movl   $0x91a2b3c5,0xffffffd8(%ebp)
    2d96:	8b 45 d8             	mov    0xffffffd8(%ebp),%eax
    2d99:	f7 6d e4             	imull  0xffffffe4(%ebp)
    2d9c:	8b 4d e4             	mov    0xffffffe4(%ebp),%ecx
    2d9f:	8d 04 0a             	lea    (%edx,%ecx,1),%eax
    2da2:	89 c2                	mov    %eax,%edx
    2da4:	c1 fa 0b             	sar    $0xb,%edx
    2da7:	8b 45 e4             	mov    0xffffffe4(%ebp),%eax
    2daa:	c1 f8 1f             	sar    $0x1f,%eax
    2dad:	89 d6                	mov    %edx,%esi
    2daf:	29 c6                	sub    %eax,%esi
    2db1:	8b 4d f4             	mov    0xfffffff4(%ebp),%ecx
    2db4:	c7 45 d8 07 45 2e c2 	movl   $0xc22e4507,0xffffffd8(%ebp)
    2dbb:	8b 45 d8             	mov    0xffffffd8(%ebp),%eax
    2dbe:	f7 e9                	imul   %ecx
    2dc0:	8d 04 0a             	lea    (%edx,%ecx,1),%eax
    2dc3:	89 c2                	mov    %eax,%edx
    2dc5:	c1 fa 10             	sar    $0x10,%edx
    2dc8:	89 c8                	mov    %ecx,%eax
    2dca:	c1 f8 1f             	sar    $0x1f,%eax
    2dcd:	29 c2                	sub    %eax,%edx
    2dcf:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
    2dd2:	89 44 24 18          	mov    %eax,0x18(%esp)
    2dd6:	8b 4d dc             	mov    0xffffffdc(%ebp),%ecx
    2dd9:	89 4c 24 14          	mov    %ecx,0x14(%esp)
    2ddd:	89 5c 24 10          	mov    %ebx,0x10(%esp)
    2de1:	89 74 24 0c          	mov    %esi,0xc(%esp)
    2de5:	89 54 24 08          	mov    %edx,0x8(%esp)
    2de9:	c7 44 24 04 7c 51 00 	movl   $0x517c,0x4(%esp)
    2df0:	00 
    2df1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2df8:	e8 b3 05 00 00       	call   33b0 <printf>
            sec / 86400,
            (sec % 86400) / 3600,
            (sec % 3600) / 60,
            sec % 60,
            msec);

    printf(1, "uptime test ok\n");
    2dfd:	c7 44 24 04 a2 51 00 	movl   $0x51a2,0x4(%esp)
    2e04:	00 
    2e05:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2e0c:	e8 9f 05 00 00       	call   33b0 <printf>
}
    2e11:	83 c4 40             	add    $0x40,%esp
    2e14:	5b                   	pop    %ebx
    2e15:	5e                   	pop    %esi
    2e16:	5d                   	pop    %ebp
    2e17:	c3                   	ret    
    2e18:	90                   	nop    
    2e19:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi

00002e20 <main>:


int
main(int argc, char *argv[])
{
    2e20:	8d 4c 24 04          	lea    0x4(%esp),%ecx
    2e24:	83 e4 f0             	and    $0xfffffff0,%esp
    2e27:	ff 71 fc             	pushl  0xfffffffc(%ecx)
    2e2a:	55                   	push   %ebp
    2e2b:	89 e5                	mov    %esp,%ebp
    2e2d:	51                   	push   %ecx
    2e2e:	83 ec 14             	sub    $0x14,%esp
  printf(1, "usertests starting\n");
    2e31:	c7 44 24 04 b2 51 00 	movl   $0x51b2,0x4(%esp)
    2e38:	00 
    2e39:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2e40:	e8 6b 05 00 00       	call   33b0 <printf>
  
  if(open("usertests.ran", 0) >= 0){
    2e45:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    2e4c:	00 
    2e4d:	c7 04 24 c6 51 00 00 	movl   $0x51c6,(%esp)
    2e54:	e8 8b 03 00 00       	call   31e4 <open>
    2e59:	85 c0                	test   %eax,%eax
    2e5b:	78 19                	js     2e76 <main+0x56>
    printf(1, "already ran user tests -- rebuild fs.img\n");
    2e5d:	c7 44 24 04 d4 51 00 	movl   $0x51d4,0x4(%esp)
    2e64:	00 
    2e65:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2e6c:	e8 3f 05 00 00       	call   33b0 <printf>
    exit();
    2e71:	e8 2e 03 00 00       	call   31a4 <exit>
  }
  close(open("usertests.ran", O_CREATE));
    2e76:	c7 44 24 04 00 02 00 	movl   $0x200,0x4(%esp)
    2e7d:	00 
    2e7e:	c7 04 24 c6 51 00 00 	movl   $0x51c6,(%esp)
    2e85:	e8 5a 03 00 00       	call   31e4 <open>
    2e8a:	89 04 24             	mov    %eax,(%esp)
    2e8d:	e8 3a 03 00 00       	call   31cc <close>

  uptimetest();
    2e92:	e8 c9 fd ff ff       	call   2c60 <uptimetest>
  opentest();
    2e97:	e8 64 d1 ff ff       	call   0 <opentest>
  writetest();
    2e9c:	e8 0f d2 ff ff       	call   b0 <writetest>
  writetest1();
    2ea1:	e8 2a d4 ff ff       	call   2d0 <writetest1>
  createtest();
    2ea6:	e8 35 d6 ff ff       	call   4e0 <createtest>

  mem();
    2eab:	e8 b0 db ff ff       	call   a60 <mem>
  pipe1();
    2eb0:	e8 1b d8 ff ff       	call   6d0 <pipe1>
  preempt();
    2eb5:	e8 06 da ff ff       	call   8c0 <preempt>
  exitwait();
    2eba:	e8 21 db ff ff       	call   9e0 <exitwait>

  rmdot();
    2ebf:	e8 cc f7 ff ff       	call   2690 <rmdot>
  fourteen();
    2ec4:	e8 67 f6 ff ff       	call   2530 <fourteen>
  bigfile();
    2ec9:	e8 32 f4 ff ff       	call   2300 <bigfile>
  subdir();
    2ece:	e8 dd ec ff ff       	call   1bb0 <subdir>
  bigdir(); // slow
    2ed3:	e8 58 eb ff ff       	call   1a30 <bigdir>
  concreate();
    2ed8:	e8 b3 e7 ff ff       	call   1690 <concreate>
  linktest();
    2edd:	e8 5e e5 ff ff       	call   1440 <linktest>
  unlinkread();
    2ee2:	e8 79 e3 ff ff       	call   1260 <unlinkread>
  createdelete();
    2ee7:	e8 b4 e0 ff ff       	call   fa0 <createdelete>
  twofiles();
    2eec:	e8 1f de ff ff       	call   d10 <twofiles>
  sharedfd();
    2ef1:	e8 2a dc ff ff       	call   b20 <sharedfd>
  dirfile();
    2ef6:	e8 15 f9 ff ff       	call   2810 <dirfile>
  iref();
    2efb:	e8 60 fb ff ff       	call   2a60 <iref>
  forktest();
    2f00:	e8 8b fc ff ff       	call   2b90 <forktest>

  exectest();
    2f05:	e8 76 d7 ff ff       	call   680 <exectest>

  exit();
    2f0a:	e8 95 02 00 00       	call   31a4 <exit>
    2f0f:	90                   	nop    

00002f10 <strcpy>:
#include "user.h"

char*
strcpy(char *s, char *t)
{
    2f10:	55                   	push   %ebp
    2f11:	89 e5                	mov    %esp,%ebp
    2f13:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
    2f16:	8b 45 08             	mov    0x8(%ebp),%eax
    2f19:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
  while((*s++ = *t++) != 0)
    2f1c:	8b 45 0c             	mov    0xc(%ebp),%eax
    2f1f:	0f b6 10             	movzbl (%eax),%edx
    2f22:	8b 45 08             	mov    0x8(%ebp),%eax
    2f25:	88 10                	mov    %dl,(%eax)
    2f27:	8b 45 08             	mov    0x8(%ebp),%eax
    2f2a:	0f b6 00             	movzbl (%eax),%eax
    2f2d:	84 c0                	test   %al,%al
    2f2f:	0f 95 c0             	setne  %al
    2f32:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    2f36:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
    2f3a:	84 c0                	test   %al,%al
    2f3c:	75 de                	jne    2f1c <strcpy+0xc>
    ;
  return os;
    2f3e:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
}
    2f41:	c9                   	leave  
    2f42:	c3                   	ret    
    2f43:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    2f49:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00002f50 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    2f50:	55                   	push   %ebp
    2f51:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
    2f53:	eb 08                	jmp    2f5d <strcmp+0xd>
    p++, q++;
    2f55:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    2f59:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
    2f5d:	8b 45 08             	mov    0x8(%ebp),%eax
    2f60:	0f b6 00             	movzbl (%eax),%eax
    2f63:	84 c0                	test   %al,%al
    2f65:	74 10                	je     2f77 <strcmp+0x27>
    2f67:	8b 45 08             	mov    0x8(%ebp),%eax
    2f6a:	0f b6 10             	movzbl (%eax),%edx
    2f6d:	8b 45 0c             	mov    0xc(%ebp),%eax
    2f70:	0f b6 00             	movzbl (%eax),%eax
    2f73:	38 c2                	cmp    %al,%dl
    2f75:	74 de                	je     2f55 <strcmp+0x5>
  return (uchar)*p - (uchar)*q;
    2f77:	8b 45 08             	mov    0x8(%ebp),%eax
    2f7a:	0f b6 00             	movzbl (%eax),%eax
    2f7d:	0f b6 d0             	movzbl %al,%edx
    2f80:	8b 45 0c             	mov    0xc(%ebp),%eax
    2f83:	0f b6 00             	movzbl (%eax),%eax
    2f86:	0f b6 c0             	movzbl %al,%eax
    2f89:	89 d1                	mov    %edx,%ecx
    2f8b:	29 c1                	sub    %eax,%ecx
    2f8d:	89 c8                	mov    %ecx,%eax
}
    2f8f:	5d                   	pop    %ebp
    2f90:	c3                   	ret    
    2f91:	eb 0d                	jmp    2fa0 <strlen>
    2f93:	90                   	nop    
    2f94:	90                   	nop    
    2f95:	90                   	nop    
    2f96:	90                   	nop    
    2f97:	90                   	nop    
    2f98:	90                   	nop    
    2f99:	90                   	nop    
    2f9a:	90                   	nop    
    2f9b:	90                   	nop    
    2f9c:	90                   	nop    
    2f9d:	90                   	nop    
    2f9e:	90                   	nop    
    2f9f:	90                   	nop    

00002fa0 <strlen>:

uint
strlen(char *s)
{
    2fa0:	55                   	push   %ebp
    2fa1:	89 e5                	mov    %esp,%ebp
    2fa3:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
    2fa6:	c7 45 fc 00 00 00 00 	movl   $0x0,0xfffffffc(%ebp)
    2fad:	eb 04                	jmp    2fb3 <strlen+0x13>
    2faf:	83 45 fc 01          	addl   $0x1,0xfffffffc(%ebp)
    2fb3:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
    2fb6:	03 45 08             	add    0x8(%ebp),%eax
    2fb9:	0f b6 00             	movzbl (%eax),%eax
    2fbc:	84 c0                	test   %al,%al
    2fbe:	75 ef                	jne    2faf <strlen+0xf>
    ;
  return n;
    2fc0:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
}
    2fc3:	c9                   	leave  
    2fc4:	c3                   	ret    
    2fc5:	8d 74 26 00          	lea    0x0(%esi),%esi
    2fc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00002fd0 <memset>:

void*
memset(void *dst, int c, uint n)
{
    2fd0:	55                   	push   %ebp
    2fd1:	89 e5                	mov    %esp,%ebp
    2fd3:	83 ec 10             	sub    $0x10,%esp
  char *d;
  
  d = dst;
    2fd6:	8b 45 08             	mov    0x8(%ebp),%eax
    2fd9:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
  while(n-- > 0)
    2fdc:	eb 0e                	jmp    2fec <memset+0x1c>
    *d++ = c;
    2fde:	8b 45 0c             	mov    0xc(%ebp),%eax
    2fe1:	89 c2                	mov    %eax,%edx
    2fe3:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
    2fe6:	88 10                	mov    %dl,(%eax)
    2fe8:	83 45 fc 01          	addl   $0x1,0xfffffffc(%ebp)
    2fec:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
    2ff0:	83 7d 10 ff          	cmpl   $0xffffffff,0x10(%ebp)
    2ff4:	75 e8                	jne    2fde <memset+0xe>
  return dst;
    2ff6:	8b 45 08             	mov    0x8(%ebp),%eax
}
    2ff9:	c9                   	leave  
    2ffa:	c3                   	ret    
    2ffb:	90                   	nop    
    2ffc:	8d 74 26 00          	lea    0x0(%esi),%esi

00003000 <strchr>:

char*
strchr(const char *s, char c)
{
    3000:	55                   	push   %ebp
    3001:	89 e5                	mov    %esp,%ebp
    3003:	83 ec 08             	sub    $0x8,%esp
    3006:	8b 45 0c             	mov    0xc(%ebp),%eax
    3009:	88 45 fc             	mov    %al,0xfffffffc(%ebp)
  for(; *s; s++)
    300c:	eb 17                	jmp    3025 <strchr+0x25>
    if(*s == c)
    300e:	8b 45 08             	mov    0x8(%ebp),%eax
    3011:	0f b6 00             	movzbl (%eax),%eax
    3014:	3a 45 fc             	cmp    0xfffffffc(%ebp),%al
    3017:	75 08                	jne    3021 <strchr+0x21>
      return (char*) s;
    3019:	8b 45 08             	mov    0x8(%ebp),%eax
    301c:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
    301f:	eb 15                	jmp    3036 <strchr+0x36>
    3021:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    3025:	8b 45 08             	mov    0x8(%ebp),%eax
    3028:	0f b6 00             	movzbl (%eax),%eax
    302b:	84 c0                	test   %al,%al
    302d:	75 df                	jne    300e <strchr+0xe>
  return 0;
    302f:	c7 45 f8 00 00 00 00 	movl   $0x0,0xfffffff8(%ebp)
    3036:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
}
    3039:	c9                   	leave  
    303a:	c3                   	ret    
    303b:	90                   	nop    
    303c:	8d 74 26 00          	lea    0x0(%esi),%esi

00003040 <gets>:

char*
gets(char *buf, int max)
{
    3040:	55                   	push   %ebp
    3041:	89 e5                	mov    %esp,%ebp
    3043:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    3046:	c7 45 f8 00 00 00 00 	movl   $0x0,0xfffffff8(%ebp)
    304d:	eb 46                	jmp    3095 <gets+0x55>
    cc = read(0, &c, 1);
    304f:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    3056:	00 
    3057:	8d 45 f7             	lea    0xfffffff7(%ebp),%eax
    305a:	89 44 24 04          	mov    %eax,0x4(%esp)
    305e:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3065:	e8 52 01 00 00       	call   31bc <read>
    306a:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
    if(cc < 1)
    306d:	83 7d fc 00          	cmpl   $0x0,0xfffffffc(%ebp)
    3071:	7e 2d                	jle    30a0 <gets+0x60>
      break;
    buf[i++] = c;
    3073:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
    3076:	89 c2                	mov    %eax,%edx
    3078:	03 55 08             	add    0x8(%ebp),%edx
    307b:	0f b6 45 f7          	movzbl 0xfffffff7(%ebp),%eax
    307f:	88 02                	mov    %al,(%edx)
    3081:	83 45 f8 01          	addl   $0x1,0xfffffff8(%ebp)
    if(c == '\n' || c == '\r')
    3085:	0f b6 45 f7          	movzbl 0xfffffff7(%ebp),%eax
    3089:	3c 0a                	cmp    $0xa,%al
    308b:	74 13                	je     30a0 <gets+0x60>
    308d:	0f b6 45 f7          	movzbl 0xfffffff7(%ebp),%eax
    3091:	3c 0d                	cmp    $0xd,%al
    3093:	74 0b                	je     30a0 <gets+0x60>
    3095:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
    3098:	83 c0 01             	add    $0x1,%eax
    309b:	3b 45 0c             	cmp    0xc(%ebp),%eax
    309e:	7c af                	jl     304f <gets+0xf>
      break;
  }
  buf[i] = '\0';
    30a0:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
    30a3:	03 45 08             	add    0x8(%ebp),%eax
    30a6:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
    30a9:	8b 45 08             	mov    0x8(%ebp),%eax
}
    30ac:	c9                   	leave  
    30ad:	c3                   	ret    
    30ae:	89 f6                	mov    %esi,%esi

000030b0 <stat>:

int
stat(char *n, struct stat *st)
{
    30b0:	55                   	push   %ebp
    30b1:	89 e5                	mov    %esp,%ebp
    30b3:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    30b6:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    30bd:	00 
    30be:	8b 45 08             	mov    0x8(%ebp),%eax
    30c1:	89 04 24             	mov    %eax,(%esp)
    30c4:	e8 1b 01 00 00       	call   31e4 <open>
    30c9:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
  if(fd < 0)
    30cc:	83 7d f8 00          	cmpl   $0x0,0xfffffff8(%ebp)
    30d0:	79 09                	jns    30db <stat+0x2b>
    return -1;
    30d2:	c7 45 ec ff ff ff ff 	movl   $0xffffffff,0xffffffec(%ebp)
    30d9:	eb 26                	jmp    3101 <stat+0x51>
  r = fstat(fd, st);
    30db:	8b 45 0c             	mov    0xc(%ebp),%eax
    30de:	89 44 24 04          	mov    %eax,0x4(%esp)
    30e2:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
    30e5:	89 04 24             	mov    %eax,(%esp)
    30e8:	e8 0f 01 00 00       	call   31fc <fstat>
    30ed:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
  close(fd);
    30f0:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
    30f3:	89 04 24             	mov    %eax,(%esp)
    30f6:	e8 d1 00 00 00       	call   31cc <close>
  return r;
    30fb:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
    30fe:	89 45 ec             	mov    %eax,0xffffffec(%ebp)
    3101:	8b 45 ec             	mov    0xffffffec(%ebp),%eax
}
    3104:	c9                   	leave  
    3105:	c3                   	ret    
    3106:	8d 76 00             	lea    0x0(%esi),%esi
    3109:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00003110 <atoi>:

int
atoi(const char *s)
{
    3110:	55                   	push   %ebp
    3111:	89 e5                	mov    %esp,%ebp
    3113:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
    3116:	c7 45 fc 00 00 00 00 	movl   $0x0,0xfffffffc(%ebp)
  while('0' <= *s && *s <= '9')
    311d:	eb 24                	jmp    3143 <atoi+0x33>
    n = n*10 + *s++ - '0';
    311f:	8b 55 fc             	mov    0xfffffffc(%ebp),%edx
    3122:	89 d0                	mov    %edx,%eax
    3124:	c1 e0 02             	shl    $0x2,%eax
    3127:	01 d0                	add    %edx,%eax
    3129:	01 c0                	add    %eax,%eax
    312b:	89 c2                	mov    %eax,%edx
    312d:	8b 45 08             	mov    0x8(%ebp),%eax
    3130:	0f b6 00             	movzbl (%eax),%eax
    3133:	0f be c0             	movsbl %al,%eax
    3136:	8d 04 02             	lea    (%edx,%eax,1),%eax
    3139:	83 e8 30             	sub    $0x30,%eax
    313c:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
    313f:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    3143:	8b 45 08             	mov    0x8(%ebp),%eax
    3146:	0f b6 00             	movzbl (%eax),%eax
    3149:	3c 2f                	cmp    $0x2f,%al
    314b:	7e 0a                	jle    3157 <atoi+0x47>
    314d:	8b 45 08             	mov    0x8(%ebp),%eax
    3150:	0f b6 00             	movzbl (%eax),%eax
    3153:	3c 39                	cmp    $0x39,%al
    3155:	7e c8                	jle    311f <atoi+0xf>
  return n;
    3157:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
}
    315a:	c9                   	leave  
    315b:	c3                   	ret    
    315c:	8d 74 26 00          	lea    0x0(%esi),%esi

00003160 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    3160:	55                   	push   %ebp
    3161:	89 e5                	mov    %esp,%ebp
    3163:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
    3166:	8b 45 08             	mov    0x8(%ebp),%eax
    3169:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
  src = vsrc;
    316c:	8b 45 0c             	mov    0xc(%ebp),%eax
    316f:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
  while(n-- > 0)
    3172:	eb 13                	jmp    3187 <memmove+0x27>
    *dst++ = *src++;
    3174:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
    3177:	0f b6 10             	movzbl (%eax),%edx
    317a:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
    317d:	88 10                	mov    %dl,(%eax)
    317f:	83 45 f8 01          	addl   $0x1,0xfffffff8(%ebp)
    3183:	83 45 fc 01          	addl   $0x1,0xfffffffc(%ebp)
    3187:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    318b:	0f 9f c0             	setg   %al
    318e:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
    3192:	84 c0                	test   %al,%al
    3194:	75 de                	jne    3174 <memmove+0x14>
  return vdst;
    3196:	8b 45 08             	mov    0x8(%ebp),%eax
}
    3199:	c9                   	leave  
    319a:	c3                   	ret    
    319b:	90                   	nop    

0000319c <fork>:
    319c:	b8 01 00 00 00       	mov    $0x1,%eax
    31a1:	cd 30                	int    $0x30
    31a3:	c3                   	ret    

000031a4 <exit>:
    31a4:	b8 02 00 00 00       	mov    $0x2,%eax
    31a9:	cd 30                	int    $0x30
    31ab:	c3                   	ret    

000031ac <wait>:
    31ac:	b8 03 00 00 00       	mov    $0x3,%eax
    31b1:	cd 30                	int    $0x30
    31b3:	c3                   	ret    

000031b4 <pipe>:
    31b4:	b8 04 00 00 00       	mov    $0x4,%eax
    31b9:	cd 30                	int    $0x30
    31bb:	c3                   	ret    

000031bc <read>:
    31bc:	b8 06 00 00 00       	mov    $0x6,%eax
    31c1:	cd 30                	int    $0x30
    31c3:	c3                   	ret    

000031c4 <write>:
    31c4:	b8 05 00 00 00       	mov    $0x5,%eax
    31c9:	cd 30                	int    $0x30
    31cb:	c3                   	ret    

000031cc <close>:
    31cc:	b8 07 00 00 00       	mov    $0x7,%eax
    31d1:	cd 30                	int    $0x30
    31d3:	c3                   	ret    

000031d4 <kill>:
    31d4:	b8 08 00 00 00       	mov    $0x8,%eax
    31d9:	cd 30                	int    $0x30
    31db:	c3                   	ret    

000031dc <exec>:
    31dc:	b8 09 00 00 00       	mov    $0x9,%eax
    31e1:	cd 30                	int    $0x30
    31e3:	c3                   	ret    

000031e4 <open>:
    31e4:	b8 0a 00 00 00       	mov    $0xa,%eax
    31e9:	cd 30                	int    $0x30
    31eb:	c3                   	ret    

000031ec <mknod>:
    31ec:	b8 0b 00 00 00       	mov    $0xb,%eax
    31f1:	cd 30                	int    $0x30
    31f3:	c3                   	ret    

000031f4 <unlink>:
    31f4:	b8 0c 00 00 00       	mov    $0xc,%eax
    31f9:	cd 30                	int    $0x30
    31fb:	c3                   	ret    

000031fc <fstat>:
    31fc:	b8 0d 00 00 00       	mov    $0xd,%eax
    3201:	cd 30                	int    $0x30
    3203:	c3                   	ret    

00003204 <link>:
    3204:	b8 0e 00 00 00       	mov    $0xe,%eax
    3209:	cd 30                	int    $0x30
    320b:	c3                   	ret    

0000320c <mkdir>:
    320c:	b8 0f 00 00 00       	mov    $0xf,%eax
    3211:	cd 30                	int    $0x30
    3213:	c3                   	ret    

00003214 <chdir>:
    3214:	b8 10 00 00 00       	mov    $0x10,%eax
    3219:	cd 30                	int    $0x30
    321b:	c3                   	ret    

0000321c <dup>:
    321c:	b8 11 00 00 00       	mov    $0x11,%eax
    3221:	cd 30                	int    $0x30
    3223:	c3                   	ret    

00003224 <getpid>:
    3224:	b8 12 00 00 00       	mov    $0x12,%eax
    3229:	cd 30                	int    $0x30
    322b:	c3                   	ret    

0000322c <sbrk>:
    322c:	b8 13 00 00 00       	mov    $0x13,%eax
    3231:	cd 30                	int    $0x30
    3233:	c3                   	ret    

00003234 <sleep>:
    3234:	b8 14 00 00 00       	mov    $0x14,%eax
    3239:	cd 30                	int    $0x30
    323b:	c3                   	ret    

0000323c <upmsec>:
    323c:	b8 15 00 00 00       	mov    $0x15,%eax
    3241:	cd 30                	int    $0x30
    3243:	c3                   	ret    

00003244 <socket>:
    3244:	b8 16 00 00 00       	mov    $0x16,%eax
    3249:	cd 30                	int    $0x30
    324b:	c3                   	ret    

0000324c <bind>:
    324c:	b8 17 00 00 00       	mov    $0x17,%eax
    3251:	cd 30                	int    $0x30
    3253:	c3                   	ret    

00003254 <listen>:
    3254:	b8 18 00 00 00       	mov    $0x18,%eax
    3259:	cd 30                	int    $0x30
    325b:	c3                   	ret    

0000325c <accept>:
    325c:	b8 19 00 00 00       	mov    $0x19,%eax
    3261:	cd 30                	int    $0x30
    3263:	c3                   	ret    

00003264 <recv>:
    3264:	b8 1a 00 00 00       	mov    $0x1a,%eax
    3269:	cd 30                	int    $0x30
    326b:	c3                   	ret    

0000326c <recvfrom>:
    326c:	b8 1b 00 00 00       	mov    $0x1b,%eax
    3271:	cd 30                	int    $0x30
    3273:	c3                   	ret    

00003274 <send>:
    3274:	b8 1c 00 00 00       	mov    $0x1c,%eax
    3279:	cd 30                	int    $0x30
    327b:	c3                   	ret    

0000327c <sendto>:
    327c:	b8 1d 00 00 00       	mov    $0x1d,%eax
    3281:	cd 30                	int    $0x30
    3283:	c3                   	ret    

00003284 <shutdown>:
    3284:	b8 1e 00 00 00       	mov    $0x1e,%eax
    3289:	cd 30                	int    $0x30
    328b:	c3                   	ret    

0000328c <getsockopt>:
    328c:	b8 1f 00 00 00       	mov    $0x1f,%eax
    3291:	cd 30                	int    $0x30
    3293:	c3                   	ret    

00003294 <setsockopt>:
    3294:	b8 20 00 00 00       	mov    $0x20,%eax
    3299:	cd 30                	int    $0x30
    329b:	c3                   	ret    

0000329c <sockclose>:
    329c:	b8 21 00 00 00       	mov    $0x21,%eax
    32a1:	cd 30                	int    $0x30
    32a3:	c3                   	ret    

000032a4 <connect>:
    32a4:	b8 22 00 00 00       	mov    $0x22,%eax
    32a9:	cd 30                	int    $0x30
    32ab:	c3                   	ret    

000032ac <getpeername>:
    32ac:	b8 23 00 00 00       	mov    $0x23,%eax
    32b1:	cd 30                	int    $0x30
    32b3:	c3                   	ret    

000032b4 <getsockname>:
    32b4:	b8 24 00 00 00       	mov    $0x24,%eax
    32b9:	cd 30                	int    $0x30
    32bb:	c3                   	ret    
    32bc:	90                   	nop    
    32bd:	90                   	nop    
    32be:	90                   	nop    
    32bf:	90                   	nop    

000032c0 <putc>:
#include "user.h"

void
putc(int fd, char c)
{
    32c0:	55                   	push   %ebp
    32c1:	89 e5                	mov    %esp,%ebp
    32c3:	83 ec 18             	sub    $0x18,%esp
    32c6:	8b 45 0c             	mov    0xc(%ebp),%eax
    32c9:	88 45 fc             	mov    %al,0xfffffffc(%ebp)
  write(fd, &c, 1);
    32cc:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    32d3:	00 
    32d4:	8d 45 fc             	lea    0xfffffffc(%ebp),%eax
    32d7:	89 44 24 04          	mov    %eax,0x4(%esp)
    32db:	8b 45 08             	mov    0x8(%ebp),%eax
    32de:	89 04 24             	mov    %eax,(%esp)
    32e1:	e8 de fe ff ff       	call   31c4 <write>
}
    32e6:	c9                   	leave  
    32e7:	c3                   	ret    
    32e8:	90                   	nop    
    32e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi

000032f0 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    32f0:	55                   	push   %ebp
    32f1:	89 e5                	mov    %esp,%ebp
    32f3:	53                   	push   %ebx
    32f4:	83 ec 34             	sub    $0x34,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    32f7:	c7 45 f4 00 00 00 00 	movl   $0x0,0xfffffff4(%ebp)
  if(sgn && xx < 0){
    32fe:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
    3302:	74 17                	je     331b <printint+0x2b>
    3304:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    3308:	79 11                	jns    331b <printint+0x2b>
    neg = 1;
    330a:	c7 45 f4 01 00 00 00 	movl   $0x1,0xfffffff4(%ebp)
    x = -xx;
    3311:	8b 45 0c             	mov    0xc(%ebp),%eax
    3314:	f7 d8                	neg    %eax
    3316:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
    3319:	eb 06                	jmp    3321 <printint+0x31>
  } else {
    x = xx;
    331b:	8b 45 0c             	mov    0xc(%ebp),%eax
    331e:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
  }

  i = 0;
    3321:	c7 45 f0 00 00 00 00 	movl   $0x0,0xfffffff0(%ebp)
  do{
    buf[i++] = digits[x % base];
    3328:	8b 4d f0             	mov    0xfffffff0(%ebp),%ecx
    332b:	8b 55 10             	mov    0x10(%ebp),%edx
    332e:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
    3331:	89 d3                	mov    %edx,%ebx
    3333:	ba 00 00 00 00       	mov    $0x0,%edx
    3338:	f7 f3                	div    %ebx
    333a:	89 d0                	mov    %edx,%eax
    333c:	0f b6 80 40 52 00 00 	movzbl 0x5240(%eax),%eax
    3343:	88 44 0d e0          	mov    %al,0xffffffe0(%ebp,%ecx,1)
    3347:	83 45 f0 01          	addl   $0x1,0xfffffff0(%ebp)
  }while((x /= base) != 0);
    334b:	8b 55 10             	mov    0x10(%ebp),%edx
    334e:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
    3351:	89 d1                	mov    %edx,%ecx
    3353:	ba 00 00 00 00       	mov    $0x0,%edx
    3358:	f7 f1                	div    %ecx
    335a:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
    335d:	83 7d f8 00          	cmpl   $0x0,0xfffffff8(%ebp)
    3361:	75 c5                	jne    3328 <printint+0x38>
  if(neg)
    3363:	83 7d f4 00          	cmpl   $0x0,0xfffffff4(%ebp)
    3367:	74 28                	je     3391 <printint+0xa1>
    buf[i++] = '-';
    3369:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
    336c:	c6 44 05 e0 2d       	movb   $0x2d,0xffffffe0(%ebp,%eax,1)
    3371:	83 45 f0 01          	addl   $0x1,0xfffffff0(%ebp)

  while(--i >= 0)
    3375:	eb 1a                	jmp    3391 <printint+0xa1>
    putc(fd, buf[i]);
    3377:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
    337a:	0f b6 44 05 e0       	movzbl 0xffffffe0(%ebp,%eax,1),%eax
    337f:	0f be c0             	movsbl %al,%eax
    3382:	89 44 24 04          	mov    %eax,0x4(%esp)
    3386:	8b 45 08             	mov    0x8(%ebp),%eax
    3389:	89 04 24             	mov    %eax,(%esp)
    338c:	e8 2f ff ff ff       	call   32c0 <putc>
    3391:	83 6d f0 01          	subl   $0x1,0xfffffff0(%ebp)
    3395:	83 7d f0 00          	cmpl   $0x0,0xfffffff0(%ebp)
    3399:	79 dc                	jns    3377 <printint+0x87>
}
    339b:	83 c4 34             	add    $0x34,%esp
    339e:	5b                   	pop    %ebx
    339f:	5d                   	pop    %ebp
    33a0:	c3                   	ret    
    33a1:	eb 0d                	jmp    33b0 <printf>
    33a3:	90                   	nop    
    33a4:	90                   	nop    
    33a5:	90                   	nop    
    33a6:	90                   	nop    
    33a7:	90                   	nop    
    33a8:	90                   	nop    
    33a9:	90                   	nop    
    33aa:	90                   	nop    
    33ab:	90                   	nop    
    33ac:	90                   	nop    
    33ad:	90                   	nop    
    33ae:	90                   	nop    
    33af:	90                   	nop    

000033b0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    33b0:	55                   	push   %ebp
    33b1:	89 e5                	mov    %esp,%ebp
    33b3:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
    33b6:	c7 45 f8 00 00 00 00 	movl   $0x0,0xfffffff8(%ebp)
  ap = (uint*)(void*)&fmt + 1;
    33bd:	8d 45 0c             	lea    0xc(%ebp),%eax
    33c0:	83 c0 04             	add    $0x4,%eax
    33c3:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
  for(i = 0; fmt[i]; i++){
    33c6:	c7 45 f4 00 00 00 00 	movl   $0x0,0xfffffff4(%ebp)
    33cd:	e9 7b 01 00 00       	jmp    354d <printf+0x19d>
    c = fmt[i] & 0xff;
    33d2:	8b 55 0c             	mov    0xc(%ebp),%edx
    33d5:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
    33d8:	8d 04 02             	lea    (%edx,%eax,1),%eax
    33db:	0f b6 00             	movzbl (%eax),%eax
    33de:	0f be c0             	movsbl %al,%eax
    33e1:	25 ff 00 00 00       	and    $0xff,%eax
    33e6:	89 45 f0             	mov    %eax,0xfffffff0(%ebp)
    if(state == 0){
    33e9:	83 7d f8 00          	cmpl   $0x0,0xfffffff8(%ebp)
    33ed:	75 2c                	jne    341b <printf+0x6b>
      if(c == '%'){
    33ef:	83 7d f0 25          	cmpl   $0x25,0xfffffff0(%ebp)
    33f3:	75 0c                	jne    3401 <printf+0x51>
        state = '%';
    33f5:	c7 45 f8 25 00 00 00 	movl   $0x25,0xfffffff8(%ebp)
    33fc:	e9 48 01 00 00       	jmp    3549 <printf+0x199>
      } else {
        putc(fd, c);
    3401:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
    3404:	0f be c0             	movsbl %al,%eax
    3407:	89 44 24 04          	mov    %eax,0x4(%esp)
    340b:	8b 45 08             	mov    0x8(%ebp),%eax
    340e:	89 04 24             	mov    %eax,(%esp)
    3411:	e8 aa fe ff ff       	call   32c0 <putc>
    3416:	e9 2e 01 00 00       	jmp    3549 <printf+0x199>
      }
    } else if(state == '%'){
    341b:	83 7d f8 25          	cmpl   $0x25,0xfffffff8(%ebp)
    341f:	0f 85 24 01 00 00    	jne    3549 <printf+0x199>
      if(c == 'd'){
    3425:	83 7d f0 64          	cmpl   $0x64,0xfffffff0(%ebp)
    3429:	75 2d                	jne    3458 <printf+0xa8>
        printint(fd, *ap, 10, 1);
    342b:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
    342e:	8b 00                	mov    (%eax),%eax
    3430:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
    3437:	00 
    3438:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
    343f:	00 
    3440:	89 44 24 04          	mov    %eax,0x4(%esp)
    3444:	8b 45 08             	mov    0x8(%ebp),%eax
    3447:	89 04 24             	mov    %eax,(%esp)
    344a:	e8 a1 fe ff ff       	call   32f0 <printint>
        ap++;
    344f:	83 45 fc 04          	addl   $0x4,0xfffffffc(%ebp)
    3453:	e9 ea 00 00 00       	jmp    3542 <printf+0x192>
      } else if(c == 'x' || c == 'p'){
    3458:	83 7d f0 78          	cmpl   $0x78,0xfffffff0(%ebp)
    345c:	74 06                	je     3464 <printf+0xb4>
    345e:	83 7d f0 70          	cmpl   $0x70,0xfffffff0(%ebp)
    3462:	75 2d                	jne    3491 <printf+0xe1>
        printint(fd, *ap, 16, 0);
    3464:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
    3467:	8b 00                	mov    (%eax),%eax
    3469:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
    3470:	00 
    3471:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
    3478:	00 
    3479:	89 44 24 04          	mov    %eax,0x4(%esp)
    347d:	8b 45 08             	mov    0x8(%ebp),%eax
    3480:	89 04 24             	mov    %eax,(%esp)
    3483:	e8 68 fe ff ff       	call   32f0 <printint>
        ap++;
    3488:	83 45 fc 04          	addl   $0x4,0xfffffffc(%ebp)
    348c:	e9 b1 00 00 00       	jmp    3542 <printf+0x192>
      } else if(c == 's'){
    3491:	83 7d f0 73          	cmpl   $0x73,0xfffffff0(%ebp)
    3495:	75 43                	jne    34da <printf+0x12a>
        s = (char*)*ap;
    3497:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
    349a:	8b 00                	mov    (%eax),%eax
    349c:	89 45 ec             	mov    %eax,0xffffffec(%ebp)
        ap++;
    349f:	83 45 fc 04          	addl   $0x4,0xfffffffc(%ebp)
        if(s == 0)
    34a3:	83 7d ec 00          	cmpl   $0x0,0xffffffec(%ebp)
    34a7:	75 25                	jne    34ce <printf+0x11e>
          s = "(null)";
    34a9:	c7 45 ec fe 51 00 00 	movl   $0x51fe,0xffffffec(%ebp)
        while(*s != 0){
    34b0:	eb 1c                	jmp    34ce <printf+0x11e>
          putc(fd, *s);
    34b2:	8b 45 ec             	mov    0xffffffec(%ebp),%eax
    34b5:	0f b6 00             	movzbl (%eax),%eax
    34b8:	0f be c0             	movsbl %al,%eax
    34bb:	89 44 24 04          	mov    %eax,0x4(%esp)
    34bf:	8b 45 08             	mov    0x8(%ebp),%eax
    34c2:	89 04 24             	mov    %eax,(%esp)
    34c5:	e8 f6 fd ff ff       	call   32c0 <putc>
          s++;
    34ca:	83 45 ec 01          	addl   $0x1,0xffffffec(%ebp)
    34ce:	8b 45 ec             	mov    0xffffffec(%ebp),%eax
    34d1:	0f b6 00             	movzbl (%eax),%eax
    34d4:	84 c0                	test   %al,%al
    34d6:	75 da                	jne    34b2 <printf+0x102>
    34d8:	eb 68                	jmp    3542 <printf+0x192>
        }
      } else if(c == 'c'){
    34da:	83 7d f0 63          	cmpl   $0x63,0xfffffff0(%ebp)
    34de:	75 1d                	jne    34fd <printf+0x14d>
        putc(fd, *ap);
    34e0:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
    34e3:	8b 00                	mov    (%eax),%eax
    34e5:	0f be c0             	movsbl %al,%eax
    34e8:	89 44 24 04          	mov    %eax,0x4(%esp)
    34ec:	8b 45 08             	mov    0x8(%ebp),%eax
    34ef:	89 04 24             	mov    %eax,(%esp)
    34f2:	e8 c9 fd ff ff       	call   32c0 <putc>
        ap++;
    34f7:	83 45 fc 04          	addl   $0x4,0xfffffffc(%ebp)
    34fb:	eb 45                	jmp    3542 <printf+0x192>
      } else if(c == '%'){
    34fd:	83 7d f0 25          	cmpl   $0x25,0xfffffff0(%ebp)
    3501:	75 17                	jne    351a <printf+0x16a>
        putc(fd, c);
    3503:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
    3506:	0f be c0             	movsbl %al,%eax
    3509:	89 44 24 04          	mov    %eax,0x4(%esp)
    350d:	8b 45 08             	mov    0x8(%ebp),%eax
    3510:	89 04 24             	mov    %eax,(%esp)
    3513:	e8 a8 fd ff ff       	call   32c0 <putc>
    3518:	eb 28                	jmp    3542 <printf+0x192>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    351a:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
    3521:	00 
    3522:	8b 45 08             	mov    0x8(%ebp),%eax
    3525:	89 04 24             	mov    %eax,(%esp)
    3528:	e8 93 fd ff ff       	call   32c0 <putc>
        putc(fd, c);
    352d:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
    3530:	0f be c0             	movsbl %al,%eax
    3533:	89 44 24 04          	mov    %eax,0x4(%esp)
    3537:	8b 45 08             	mov    0x8(%ebp),%eax
    353a:	89 04 24             	mov    %eax,(%esp)
    353d:	e8 7e fd ff ff       	call   32c0 <putc>
      }
      state = 0;
    3542:	c7 45 f8 00 00 00 00 	movl   $0x0,0xfffffff8(%ebp)
    3549:	83 45 f4 01          	addl   $0x1,0xfffffff4(%ebp)
    354d:	8b 55 0c             	mov    0xc(%ebp),%edx
    3550:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
    3553:	8d 04 02             	lea    (%edx,%eax,1),%eax
    3556:	0f b6 00             	movzbl (%eax),%eax
    3559:	84 c0                	test   %al,%al
    355b:	0f 85 71 fe ff ff    	jne    33d2 <printf+0x22>
    }
  }
}
    3561:	c9                   	leave  
    3562:	c3                   	ret    
    3563:	90                   	nop    
    3564:	90                   	nop    
    3565:	90                   	nop    
    3566:	90                   	nop    
    3567:	90                   	nop    
    3568:	90                   	nop    
    3569:	90                   	nop    
    356a:	90                   	nop    
    356b:	90                   	nop    
    356c:	90                   	nop    
    356d:	90                   	nop    
    356e:	90                   	nop    
    356f:	90                   	nop    

00003570 <free>:
static Header *freep;

void
free(void *ap)
{
    3570:	55                   	push   %ebp
    3571:	89 e5                	mov    %esp,%ebp
    3573:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*) ap - 1;
    3576:	8b 45 08             	mov    0x8(%ebp),%eax
    3579:	83 e8 08             	sub    $0x8,%eax
    357c:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    357f:	a1 68 52 00 00       	mov    0x5268,%eax
    3584:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
    3587:	eb 24                	jmp    35ad <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    3589:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
    358c:	8b 00                	mov    (%eax),%eax
    358e:	3b 45 fc             	cmp    0xfffffffc(%ebp),%eax
    3591:	77 12                	ja     35a5 <free+0x35>
    3593:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
    3596:	3b 45 fc             	cmp    0xfffffffc(%ebp),%eax
    3599:	77 24                	ja     35bf <free+0x4f>
    359b:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
    359e:	8b 00                	mov    (%eax),%eax
    35a0:	3b 45 f8             	cmp    0xfffffff8(%ebp),%eax
    35a3:	77 1a                	ja     35bf <free+0x4f>
    35a5:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
    35a8:	8b 00                	mov    (%eax),%eax
    35aa:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
    35ad:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
    35b0:	3b 45 fc             	cmp    0xfffffffc(%ebp),%eax
    35b3:	76 d4                	jbe    3589 <free+0x19>
    35b5:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
    35b8:	8b 00                	mov    (%eax),%eax
    35ba:	3b 45 f8             	cmp    0xfffffff8(%ebp),%eax
    35bd:	76 ca                	jbe    3589 <free+0x19>
      break;
  if(bp + bp->s.size == p->s.ptr){
    35bf:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
    35c2:	8b 40 04             	mov    0x4(%eax),%eax
    35c5:	c1 e0 03             	shl    $0x3,%eax
    35c8:	89 c2                	mov    %eax,%edx
    35ca:	03 55 f8             	add    0xfffffff8(%ebp),%edx
    35cd:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
    35d0:	8b 00                	mov    (%eax),%eax
    35d2:	39 c2                	cmp    %eax,%edx
    35d4:	75 24                	jne    35fa <free+0x8a>
    bp->s.size += p->s.ptr->s.size;
    35d6:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
    35d9:	8b 50 04             	mov    0x4(%eax),%edx
    35dc:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
    35df:	8b 00                	mov    (%eax),%eax
    35e1:	8b 40 04             	mov    0x4(%eax),%eax
    35e4:	01 c2                	add    %eax,%edx
    35e6:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
    35e9:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
    35ec:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
    35ef:	8b 00                	mov    (%eax),%eax
    35f1:	8b 10                	mov    (%eax),%edx
    35f3:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
    35f6:	89 10                	mov    %edx,(%eax)
    35f8:	eb 0a                	jmp    3604 <free+0x94>
  } else
    bp->s.ptr = p->s.ptr;
    35fa:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
    35fd:	8b 10                	mov    (%eax),%edx
    35ff:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
    3602:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
    3604:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
    3607:	8b 40 04             	mov    0x4(%eax),%eax
    360a:	c1 e0 03             	shl    $0x3,%eax
    360d:	03 45 fc             	add    0xfffffffc(%ebp),%eax
    3610:	3b 45 f8             	cmp    0xfffffff8(%ebp),%eax
    3613:	75 20                	jne    3635 <free+0xc5>
    p->s.size += bp->s.size;
    3615:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
    3618:	8b 50 04             	mov    0x4(%eax),%edx
    361b:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
    361e:	8b 40 04             	mov    0x4(%eax),%eax
    3621:	01 c2                	add    %eax,%edx
    3623:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
    3626:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    3629:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
    362c:	8b 10                	mov    (%eax),%edx
    362e:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
    3631:	89 10                	mov    %edx,(%eax)
    3633:	eb 08                	jmp    363d <free+0xcd>
  } else
    p->s.ptr = bp;
    3635:	8b 55 fc             	mov    0xfffffffc(%ebp),%edx
    3638:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
    363b:	89 02                	mov    %eax,(%edx)
  freep = p;
    363d:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
    3640:	a3 68 52 00 00       	mov    %eax,0x5268
}
    3645:	c9                   	leave  
    3646:	c3                   	ret    
    3647:	89 f6                	mov    %esi,%esi
    3649:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00003650 <morecore>:

static Header*
morecore(uint nu)
{
    3650:	55                   	push   %ebp
    3651:	89 e5                	mov    %esp,%ebp
    3653:	83 ec 18             	sub    $0x18,%esp
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
    3656:	8b 45 08             	mov    0x8(%ebp),%eax
    3659:	c1 e0 03             	shl    $0x3,%eax
    365c:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
  size += PAGE - size % PAGE;
    365f:	8b 55 fc             	mov    0xfffffffc(%ebp),%edx
    3662:	89 d0                	mov    %edx,%eax
    3664:	c1 f8 1f             	sar    $0x1f,%eax
    3667:	89 c1                	mov    %eax,%ecx
    3669:	c1 e9 14             	shr    $0x14,%ecx
    366c:	8d 04 0a             	lea    (%edx,%ecx,1),%eax
    366f:	25 ff 0f 00 00       	and    $0xfff,%eax
    3674:	29 c8                	sub    %ecx,%eax
    3676:	89 c2                	mov    %eax,%edx
    3678:	b8 00 10 00 00       	mov    $0x1000,%eax
    367d:	29 d0                	sub    %edx,%eax
    367f:	01 45 fc             	add    %eax,0xfffffffc(%ebp)
#endif
#ifdef UMALLOC_DEBUG
  printf(1, "size: %d\n", size);
#endif
  p = sbrk(size);
    3682:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
    3685:	89 04 24             	mov    %eax,(%esp)
    3688:	e8 9f fb ff ff       	call   322c <sbrk>
    368d:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
  if(p == (char*) -1)
    3690:	83 7d f4 ff          	cmpl   $0xffffffff,0xfffffff4(%ebp)
    3694:	75 09                	jne    369f <morecore+0x4f>
    return 0;
    3696:	c7 45 ec 00 00 00 00 	movl   $0x0,0xffffffec(%ebp)
    369d:	eb 2a                	jmp    36c9 <morecore+0x79>
  hp = (Header*)p;
    369f:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
    36a2:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
#ifdef UMALLOC_NOALIGN
  hp->s.size = nu;
#else
  hp->s.size = size / sizeof(Header);
    36a5:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
    36a8:	89 c2                	mov    %eax,%edx
    36aa:	c1 ea 03             	shr    $0x3,%edx
    36ad:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
    36b0:	89 50 04             	mov    %edx,0x4(%eax)
#endif
  free((void*)(hp + 1));
    36b3:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
    36b6:	83 c0 08             	add    $0x8,%eax
    36b9:	89 04 24             	mov    %eax,(%esp)
    36bc:	e8 af fe ff ff       	call   3570 <free>
  return freep;
    36c1:	a1 68 52 00 00       	mov    0x5268,%eax
    36c6:	89 45 ec             	mov    %eax,0xffffffec(%ebp)
    36c9:	8b 45 ec             	mov    0xffffffec(%ebp),%eax
}
    36cc:	c9                   	leave  
    36cd:	c3                   	ret    
    36ce:	89 f6                	mov    %esi,%esi

000036d0 <malloc>:

void*
malloc(uint nbytes)
{
    36d0:	55                   	push   %ebp
    36d1:	89 e5                	mov    %esp,%ebp
    36d3:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

#ifdef UMALLOC_DEBUG
  printf(1, "malloc: %d bytes\n", nbytes);
  printf(1, "size of Header: %d\n", sizeof(Header));
#endif
  if (PAGE % sizeof(Header))
      printf(2, "Warning! align failed! Need UMALLOC_NOALIGN\n");
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    36d6:	8b 45 08             	mov    0x8(%ebp),%eax
    36d9:	83 c0 07             	add    $0x7,%eax
    36dc:	c1 e8 03             	shr    $0x3,%eax
    36df:	83 c0 01             	add    $0x1,%eax
    36e2:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
  if((prevp = freep) == 0){
    36e5:	a1 68 52 00 00       	mov    0x5268,%eax
    36ea:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
    36ed:	83 7d f8 00          	cmpl   $0x0,0xfffffff8(%ebp)
    36f1:	75 23                	jne    3716 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
    36f3:	c7 45 f8 60 52 00 00 	movl   $0x5260,0xfffffff8(%ebp)
    36fa:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
    36fd:	a3 68 52 00 00       	mov    %eax,0x5268
    3702:	a1 68 52 00 00       	mov    0x5268,%eax
    3707:	a3 60 52 00 00       	mov    %eax,0x5260
    base.s.size = 0;
    370c:	c7 05 64 52 00 00 00 	movl   $0x0,0x5264
    3713:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    3716:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
    3719:	8b 00                	mov    (%eax),%eax
    371b:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
    if(p->s.size >= nunits){
    371e:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
    3721:	8b 40 04             	mov    0x4(%eax),%eax
    3724:	3b 45 fc             	cmp    0xfffffffc(%ebp),%eax
    3727:	72 50                	jb     3779 <malloc+0xa9>
      if(p->s.size == nunits)
    3729:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
    372c:	8b 40 04             	mov    0x4(%eax),%eax
    372f:	3b 45 fc             	cmp    0xfffffffc(%ebp),%eax
    3732:	75 0c                	jne    3740 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
    3734:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
    3737:	8b 10                	mov    (%eax),%edx
    3739:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
    373c:	89 10                	mov    %edx,(%eax)
    373e:	eb 26                	jmp    3766 <malloc+0x96>
      else {
        p->s.size -= nunits;
    3740:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
    3743:	8b 40 04             	mov    0x4(%eax),%eax
    3746:	89 c2                	mov    %eax,%edx
    3748:	2b 55 fc             	sub    0xfffffffc(%ebp),%edx
    374b:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
    374e:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    3751:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
    3754:	8b 40 04             	mov    0x4(%eax),%eax
    3757:	c1 e0 03             	shl    $0x3,%eax
    375a:	01 45 f4             	add    %eax,0xfffffff4(%ebp)
        p->s.size = nunits;
    375d:	8b 55 f4             	mov    0xfffffff4(%ebp),%edx
    3760:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
    3763:	89 42 04             	mov    %eax,0x4(%edx)
      }
      freep = prevp;
    3766:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
    3769:	a3 68 52 00 00       	mov    %eax,0x5268
      return (void*) (p + 1);
    376e:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
    3771:	83 c0 08             	add    $0x8,%eax
    3774:	89 45 ec             	mov    %eax,0xffffffec(%ebp)
    3777:	eb 3a                	jmp    37b3 <malloc+0xe3>
    }
    if(p == freep)
    3779:	a1 68 52 00 00       	mov    0x5268,%eax
    377e:	39 45 f4             	cmp    %eax,0xfffffff4(%ebp)
    3781:	75 1d                	jne    37a0 <malloc+0xd0>
      if((p = morecore(nunits)) == 0)
    3783:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
    3786:	89 04 24             	mov    %eax,(%esp)
    3789:	e8 c2 fe ff ff       	call   3650 <morecore>
    378e:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
    3791:	83 7d f4 00          	cmpl   $0x0,0xfffffff4(%ebp)
    3795:	75 09                	jne    37a0 <malloc+0xd0>
        return 0;
    3797:	c7 45 ec 00 00 00 00 	movl   $0x0,0xffffffec(%ebp)
    379e:	eb 13                	jmp    37b3 <malloc+0xe3>
    37a0:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
    37a3:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
    37a6:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
    37a9:	8b 00                	mov    (%eax),%eax
    37ab:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
  }
    37ae:	e9 6b ff ff ff       	jmp    371e <malloc+0x4e>
    37b3:	8b 45 ec             	mov    0xffffffec(%ebp),%eax
}
    37b6:	c9                   	leave  
    37b7:	c3                   	ret    
    37b8:	90                   	nop    
    37b9:	90                   	nop    
    37ba:	90                   	nop    
    37bb:	90                   	nop    
    37bc:	90                   	nop    
    37bd:	90                   	nop    
    37be:	90                   	nop    
    37bf:	90                   	nop    

000037c0 <lwip_chksum>:


static u16_t
lwip_chksum(void *dataptr, int len)
{
    37c0:	55                   	push   %ebp
    37c1:	89 e5                	mov    %esp,%ebp
    37c3:	83 ec 18             	sub    $0x18,%esp
  u32_t acc;

  LWIP_DEBUGF(INET_DEBUG, ("lwip_chksum(%p, %d)\n", (void *)dataptr, len));
  for(acc = 0; len > 1; len -= 2) {
    37c6:	c7 45 fc 00 00 00 00 	movl   $0x0,0xfffffffc(%ebp)
    37cd:	eb 19                	jmp    37e8 <lwip_chksum+0x28>
      /*    acc = acc + *((u16_t *)dataptr)++;*/
    acc += *(u16_t *)dataptr;
    37cf:	8b 45 08             	mov    0x8(%ebp),%eax
    37d2:	0f b7 00             	movzwl (%eax),%eax
    37d5:	0f b7 c0             	movzwl %ax,%eax
    37d8:	01 45 fc             	add    %eax,0xfffffffc(%ebp)
    dataptr = (void *)((u16_t *)dataptr + 1);
    37db:	8b 45 08             	mov    0x8(%ebp),%eax
    37de:	83 c0 02             	add    $0x2,%eax
    37e1:	89 45 08             	mov    %eax,0x8(%ebp)
    37e4:	83 6d 0c 02          	subl   $0x2,0xc(%ebp)
    37e8:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
    37ec:	7f e1                	jg     37cf <lwip_chksum+0xf>
  }

  /* add up any odd byte */
  if (len == 1) {
    37ee:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
    37f2:	75 1d                	jne    3811 <lwip_chksum+0x51>
    acc += htons((u16_t)((*(u8_t *)dataptr) & 0xff) << 8);
    37f4:	8b 45 08             	mov    0x8(%ebp),%eax
    37f7:	0f b6 00             	movzbl (%eax),%eax
    37fa:	0f b6 c0             	movzbl %al,%eax
    37fd:	c1 e0 08             	shl    $0x8,%eax
    3800:	0f b7 c0             	movzwl %ax,%eax
    3803:	89 04 24             	mov    %eax,(%esp)
    3806:	e8 85 06 00 00       	call   3e90 <htons>
    380b:	0f b7 c0             	movzwl %ax,%eax
    380e:	01 45 fc             	add    %eax,0xfffffffc(%ebp)
    LWIP_DEBUGF(INET_DEBUG, ("inet: chksum: odd byte %d\n", (unsigned int)(*(u8_t *)dataptr)));
  } else {
    LWIP_DEBUGF(INET_DEBUG, ("inet: chksum: no odd byte\n"));
  }
  acc = (acc >> 16) + (acc & 0xffffUL);
    3811:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
    3814:	89 c2                	mov    %eax,%edx
    3816:	c1 ea 10             	shr    $0x10,%edx
    3819:	0f b7 45 fc          	movzwl 0xfffffffc(%ebp),%eax
    381d:	8d 04 02             	lea    (%edx,%eax,1),%eax
    3820:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)

  if ((acc & 0xffff0000) != 0) {
    3823:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
    3826:	66 b8 00 00          	mov    $0x0,%ax
    382a:	85 c0                	test   %eax,%eax
    382c:	74 12                	je     3840 <lwip_chksum+0x80>
    acc = (acc >> 16) + (acc & 0xffffUL);
    382e:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
    3831:	89 c2                	mov    %eax,%edx
    3833:	c1 ea 10             	shr    $0x10,%edx
    3836:	0f b7 45 fc          	movzwl 0xfffffffc(%ebp),%eax
    383a:	8d 04 02             	lea    (%edx,%eax,1),%eax
    383d:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
  }

  return (u16_t)acc;
    3840:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
    3843:	0f b7 c0             	movzwl %ax,%eax
}
    3846:	c9                   	leave  
    3847:	c3                   	ret    
    3848:	90                   	nop    
    3849:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi

00003850 <inet_chksum_pseudo>:

/* inet_chksum_pseudo:
 *
 * Calculates the pseudo Internet checksum used by TCP and UDP for a pbuf chain.
 */

u16_t
inet_chksum_pseudo(struct pbuf *p,
       struct ip_addr *src, struct ip_addr *dest,
       u8_t proto, u16_t proto_len)
{
    3850:	55                   	push   %ebp
    3851:	89 e5                	mov    %esp,%ebp
    3853:	83 ec 28             	sub    $0x28,%esp
    3856:	8b 45 14             	mov    0x14(%ebp),%eax
    3859:	8b 55 18             	mov    0x18(%ebp),%edx
    385c:	88 45 ec             	mov    %al,0xffffffec(%ebp)
    385f:	66 89 55 e8          	mov    %dx,0xffffffe8(%ebp)
  u32_t acc;
  struct pbuf *q;
  u8_t swapped;

  acc = 0;
    3863:	c7 45 f4 00 00 00 00 	movl   $0x0,0xfffffff4(%ebp)
  swapped = 0;
    386a:	c6 45 ff 00          	movb   $0x0,0xffffffff(%ebp)
  /* iterate through all pbuf in chain */
  for(q = p; q != NULL; q = q->next) {
    386e:	8b 45 08             	mov    0x8(%ebp),%eax
    3871:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
    3874:	eb 7b                	jmp    38f1 <inet_chksum_pseudo+0xa1>
    LWIP_DEBUGF(INET_DEBUG, ("inet_chksum_pseudo(): checksumming pbuf %p (has next %p) \n",
      (void *)q, (void *)q->next));
    acc += lwip_chksum(q->payload, q->len);
    3876:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
    3879:	0f b7 40 0a          	movzwl 0xa(%eax),%eax
    387d:	0f b7 d0             	movzwl %ax,%edx
    3880:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
    3883:	8b 40 04             	mov    0x4(%eax),%eax
    3886:	89 54 24 04          	mov    %edx,0x4(%esp)
    388a:	89 04 24             	mov    %eax,(%esp)
    388d:	e8 2e ff ff ff       	call   37c0 <lwip_chksum>
    3892:	0f b7 c0             	movzwl %ax,%eax
    3895:	01 45 f4             	add    %eax,0xfffffff4(%ebp)
    /*LWIP_DEBUGF(INET_DEBUG, ("inet_chksum_pseudo(): unwrapped lwip_chksum()=%lx \n", acc));*/
    while (acc >> 16) {
    3898:	eb 10                	jmp    38aa <inet_chksum_pseudo+0x5a>
      acc = (acc & 0xffffUL) + (acc >> 16);
    389a:	0f b7 55 f4          	movzwl 0xfffffff4(%ebp),%edx
    389e:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
    38a1:	c1 e8 10             	shr    $0x10,%eax
    38a4:	8d 04 02             	lea    (%edx,%eax,1),%eax
    38a7:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
    38aa:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
    38ad:	c1 e8 10             	shr    $0x10,%eax
    38b0:	85 c0                	test   %eax,%eax
    38b2:	75 e6                	jne    389a <inet_chksum_pseudo+0x4a>
    }
    if (q->len % 2 != 0) {
    38b4:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
    38b7:	0f b7 40 0a          	movzwl 0xa(%eax),%eax
    38bb:	0f b7 c0             	movzwl %ax,%eax
    38be:	83 e0 01             	and    $0x1,%eax
    38c1:	84 c0                	test   %al,%al
    38c3:	74 24                	je     38e9 <inet_chksum_pseudo+0x99>
      swapped = 1 - swapped;
    38c5:	b8 01 00 00 00       	mov    $0x1,%eax
    38ca:	2a 45 ff             	sub    0xffffffff(%ebp),%al
    38cd:	88 45 ff             	mov    %al,0xffffffff(%ebp)
      acc = ((acc & 0xff) << 8) | ((acc & 0xff00UL) >> 8);
    38d0:	0f b6 45 f4          	movzbl 0xfffffff4(%ebp),%eax
    38d4:	89 c2                	mov    %eax,%edx
    38d6:	c1 e2 08             	shl    $0x8,%edx
    38d9:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
    38dc:	25 00 ff 00 00       	and    $0xff00,%eax
    38e1:	c1 e8 08             	shr    $0x8,%eax
    38e4:	09 d0                	or     %edx,%eax
    38e6:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
    38e9:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
    38ec:	8b 00                	mov    (%eax),%eax
    38ee:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
    38f1:	83 7d f8 00          	cmpl   $0x0,0xfffffff8(%ebp)
    38f5:	0f 85 7b ff ff ff    	jne    3876 <inet_chksum_pseudo+0x26>
    }
    /*LWIP_DEBUGF(INET_DEBUG, ("inet_chksum_pseudo(): wrapped lwip_chksum()=%lx \n", acc));*/
  }

  if (swapped) {
    38fb:	80 7d ff 00          	cmpb   $0x0,0xffffffff(%ebp)
    38ff:	74 19                	je     391a <inet_chksum_pseudo+0xca>
    acc = ((acc & 0xff) << 8) | ((acc & 0xff00UL) >> 8);
    3901:	0f b6 45 f4          	movzbl 0xfffffff4(%ebp),%eax
    3905:	89 c2                	mov    %eax,%edx
    3907:	c1 e2 08             	shl    $0x8,%edx
    390a:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
    390d:	25 00 ff 00 00       	and    $0xff00,%eax
    3912:	c1 e8 08             	shr    $0x8,%eax
    3915:	09 d0                	or     %edx,%eax
    3917:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
  }
  acc += (src->addr & 0xffffUL);
    391a:	8b 45 0c             	mov    0xc(%ebp),%eax
    391d:	8b 00                	mov    (%eax),%eax
    391f:	25 ff ff 00 00       	and    $0xffff,%eax
    3924:	01 45 f4             	add    %eax,0xfffffff4(%ebp)
  acc += ((src->addr >> 16) & 0xffffUL);
    3927:	8b 45 0c             	mov    0xc(%ebp),%eax
    392a:	8b 00                	mov    (%eax),%eax
    392c:	c1 e8 10             	shr    $0x10,%eax
    392f:	25 ff ff 00 00       	and    $0xffff,%eax
    3934:	01 45 f4             	add    %eax,0xfffffff4(%ebp)
  acc += (dest->addr & 0xffffUL);
    3937:	8b 45 10             	mov    0x10(%ebp),%eax
    393a:	8b 00                	mov    (%eax),%eax
    393c:	25 ff ff 00 00       	and    $0xffff,%eax
    3941:	01 45 f4             	add    %eax,0xfffffff4(%ebp)
  acc += ((dest->addr >> 16) & 0xffffUL);
    3944:	8b 45 10             	mov    0x10(%ebp),%eax
    3947:	8b 00                	mov    (%eax),%eax
    3949:	c1 e8 10             	shr    $0x10,%eax
    394c:	25 ff ff 00 00       	and    $0xffff,%eax
    3951:	01 45 f4             	add    %eax,0xfffffff4(%ebp)
  acc += (u32_t)htons((u16_t)proto);
    3954:	0f b6 45 ec          	movzbl 0xffffffec(%ebp),%eax
    3958:	89 04 24             	mov    %eax,(%esp)
    395b:	e8 30 05 00 00       	call   3e90 <htons>
    3960:	0f b7 c0             	movzwl %ax,%eax
    3963:	01 45 f4             	add    %eax,0xfffffff4(%ebp)
  acc += (u32_t)htons(proto_len);
    3966:	0f b7 45 e8          	movzwl 0xffffffe8(%ebp),%eax
    396a:	89 04 24             	mov    %eax,(%esp)
    396d:	e8 1e 05 00 00       	call   3e90 <htons>
    3972:	0f b7 c0             	movzwl %ax,%eax
    3975:	01 45 f4             	add    %eax,0xfffffff4(%ebp)

  while (acc >> 16) {
    3978:	eb 10                	jmp    398a <inet_chksum_pseudo+0x13a>
    acc = (acc & 0xffffUL) + (acc >> 16);
    397a:	0f b7 55 f4          	movzwl 0xfffffff4(%ebp),%edx
    397e:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
    3981:	c1 e8 10             	shr    $0x10,%eax
    3984:	8d 04 02             	lea    (%edx,%eax,1),%eax
    3987:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
    398a:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
    398d:	c1 e8 10             	shr    $0x10,%eax
    3990:	85 c0                	test   %eax,%eax
    3992:	75 e6                	jne    397a <inet_chksum_pseudo+0x12a>
  }
  LWIP_DEBUGF(INET_DEBUG, ("inet_chksum_pseudo(): pbuf chain lwip_chksum()=%lx\n", acc));
  return ~(acc & 0xffffUL);
    3994:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
    3997:	f7 d0                	not    %eax
    3999:	0f b7 c0             	movzwl %ax,%eax
}
    399c:	c9                   	leave  
    399d:	c3                   	ret    
    399e:	89 f6                	mov    %esi,%esi

000039a0 <inet_chksum>:

/* inet_chksum:
 *
 * Calculates the Internet checksum over a portion of memory. Used primarely for IP
 * and ICMP.
 */

u16_t
inet_chksum(void *dataptr, u16_t len)
{
    39a0:	55                   	push   %ebp
    39a1:	89 e5                	mov    %esp,%ebp
    39a3:	83 ec 28             	sub    $0x28,%esp
    39a6:	8b 45 0c             	mov    0xc(%ebp),%eax
    39a9:	66 89 45 ec          	mov    %ax,0xffffffec(%ebp)
  u32_t acc;

  acc = lwip_chksum(dataptr, len);
    39ad:	0f b7 45 ec          	movzwl 0xffffffec(%ebp),%eax
    39b1:	89 44 24 04          	mov    %eax,0x4(%esp)
    39b5:	8b 45 08             	mov    0x8(%ebp),%eax
    39b8:	89 04 24             	mov    %eax,(%esp)
    39bb:	e8 00 fe ff ff       	call   37c0 <lwip_chksum>
    39c0:	0f b7 c0             	movzwl %ax,%eax
    39c3:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
  while (acc >> 16) {
    39c6:	eb 10                	jmp    39d8 <inet_chksum+0x38>
    acc = (acc & 0xffff) + (acc >> 16);
    39c8:	0f b7 55 fc          	movzwl 0xfffffffc(%ebp),%edx
    39cc:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
    39cf:	c1 e8 10             	shr    $0x10,%eax
    39d2:	8d 04 02             	lea    (%edx,%eax,1),%eax
    39d5:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
    39d8:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
    39db:	c1 e8 10             	shr    $0x10,%eax
    39de:	85 c0                	test   %eax,%eax
    39e0:	75 e6                	jne    39c8 <inet_chksum+0x28>
  }
  return ~(acc & 0xffff);
    39e2:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
    39e5:	f7 d0                	not    %eax
    39e7:	0f b7 c0             	movzwl %ax,%eax
}
    39ea:	c9                   	leave  
    39eb:	c3                   	ret    
    39ec:	8d 74 26 00          	lea    0x0(%esi),%esi

000039f0 <inet_chksum_pbuf>:

u16_t
inet_chksum_pbuf(struct pbuf *p)
{
    39f0:	55                   	push   %ebp
    39f1:	89 e5                	mov    %esp,%ebp
    39f3:	83 ec 18             	sub    $0x18,%esp
  u32_t acc;
  struct pbuf *q;
  u8_t swapped;

  acc = 0;
    39f6:	c7 45 f4 00 00 00 00 	movl   $0x0,0xfffffff4(%ebp)
  swapped = 0;
    39fd:	c6 45 ff 00          	movb   $0x0,0xffffffff(%ebp)
  for(q = p; q != NULL; q = q->next) {
    3a01:	8b 45 08             	mov    0x8(%ebp),%eax
    3a04:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
    3a07:	eb 69                	jmp    3a72 <inet_chksum_pbuf+0x82>
    acc += lwip_chksum(q->payload, q->len);
    3a09:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
    3a0c:	0f b7 40 0a          	movzwl 0xa(%eax),%eax
    3a10:	0f b7 d0             	movzwl %ax,%edx
    3a13:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
    3a16:	8b 40 04             	mov    0x4(%eax),%eax
    3a19:	89 54 24 04          	mov    %edx,0x4(%esp)
    3a1d:	89 04 24             	mov    %eax,(%esp)
    3a20:	e8 9b fd ff ff       	call   37c0 <lwip_chksum>
    3a25:	0f b7 c0             	movzwl %ax,%eax
    3a28:	01 45 f4             	add    %eax,0xfffffff4(%ebp)
    while (acc >> 16) {
    3a2b:	eb 10                	jmp    3a3d <inet_chksum_pbuf+0x4d>
      acc = (acc & 0xffffUL) + (acc >> 16);
    3a2d:	0f b7 55 f4          	movzwl 0xfffffff4(%ebp),%edx
    3a31:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
    3a34:	c1 e8 10             	shr    $0x10,%eax
    3a37:	8d 04 02             	lea    (%edx,%eax,1),%eax
    3a3a:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
    3a3d:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
    3a40:	c1 e8 10             	shr    $0x10,%eax
    3a43:	85 c0                	test   %eax,%eax
    3a45:	75 e6                	jne    3a2d <inet_chksum_pbuf+0x3d>
    }
    if (q->len % 2 != 0) {
    3a47:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
    3a4a:	0f b7 40 0a          	movzwl 0xa(%eax),%eax
    3a4e:	0f b7 c0             	movzwl %ax,%eax
    3a51:	83 e0 01             	and    $0x1,%eax
    3a54:	84 c0                	test   %al,%al
    3a56:	74 12                	je     3a6a <inet_chksum_pbuf+0x7a>
      swapped = 1 - swapped;
    3a58:	b8 01 00 00 00       	mov    $0x1,%eax
    3a5d:	2a 45 ff             	sub    0xffffffff(%ebp),%al
    3a60:	88 45 ff             	mov    %al,0xffffffff(%ebp)
      acc = (acc & 0x00ffUL << 8) | (acc & 0xff00UL >> 8);
    3a63:	81 65 f4 ff ff 00 00 	andl   $0xffff,0xfffffff4(%ebp)
    3a6a:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
    3a6d:	8b 00                	mov    (%eax),%eax
    3a6f:	89 45 f8             	mov    %eax,0xfffffff8(%ebp)
    3a72:	83 7d f8 00          	cmpl   $0x0,0xfffffff8(%ebp)
    3a76:	75 91                	jne    3a09 <inet_chksum_pbuf+0x19>
    }
  }

  if (swapped) {
    3a78:	80 7d ff 00          	cmpb   $0x0,0xffffffff(%ebp)
    3a7c:	74 19                	je     3a97 <inet_chksum_pbuf+0xa7>
    acc = ((acc & 0x00ffUL) << 8) | ((acc & 0xff00UL) >> 8);
    3a7e:	0f b6 45 f4          	movzbl 0xfffffff4(%ebp),%eax
    3a82:	89 c2                	mov    %eax,%edx
    3a84:	c1 e2 08             	shl    $0x8,%edx
    3a87:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
    3a8a:	25 00 ff 00 00       	and    $0xff00,%eax
    3a8f:	c1 e8 08             	shr    $0x8,%eax
    3a92:	09 d0                	or     %edx,%eax
    3a94:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
  }
  return ~(acc & 0xffffUL);
    3a97:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
    3a9a:	f7 d0                	not    %eax
    3a9c:	0f b7 c0             	movzwl %ax,%eax
}
    3a9f:	c9                   	leave  
    3aa0:	c3                   	ret    
    3aa1:	eb 0d                	jmp    3ab0 <inet_addr>
    3aa3:	90                   	nop    
    3aa4:	90                   	nop    
    3aa5:	90                   	nop    
    3aa6:	90                   	nop    
    3aa7:	90                   	nop    
    3aa8:	90                   	nop    
    3aa9:	90                   	nop    
    3aaa:	90                   	nop    
    3aab:	90                   	nop    
    3aac:	90                   	nop    
    3aad:	90                   	nop    
    3aae:	90                   	nop    
    3aaf:	90                   	nop    

00003ab0 <inet_addr>:

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
    3ab0:	55                   	push   %ebp
    3ab1:	89 e5                	mov    %esp,%ebp
    3ab3:	83 ec 28             	sub    $0x28,%esp
     struct in_addr val;

     if (inet_aton(cp, &val)) {
    3ab6:	8d 45 fc             	lea    0xfffffffc(%ebp),%eax
    3ab9:	89 44 24 04          	mov    %eax,0x4(%esp)
    3abd:	8b 45 08             	mov    0x8(%ebp),%eax
    3ac0:	89 04 24             	mov    %eax,(%esp)
    3ac3:	e8 18 00 00 00       	call   3ae0 <inet_aton>
    3ac8:	85 c0                	test   %eax,%eax
    3aca:	74 08                	je     3ad4 <inet_addr+0x24>
         return (val.s_addr);
    3acc:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
    3acf:	89 45 ec             	mov    %eax,0xffffffec(%ebp)
    3ad2:	eb 07                	jmp    3adb <inet_addr+0x2b>
     }
     return (INADDR_NONE);
    3ad4:	c7 45 ec ff ff ff ff 	movl   $0xffffffff,0xffffffec(%ebp)
    3adb:	8b 45 ec             	mov    0xffffffec(%ebp),%eax
 }
    3ade:	c9                   	leave  
    3adf:	c3                   	ret    

00003ae0 <inet_aton>:

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
    3ae0:	55                   	push   %ebp
    3ae1:	89 e5                	mov    %esp,%ebp
    3ae3:	83 ec 48             	sub    $0x48,%esp
     u32_t val;
     int base, n;
     char c;
     u32_t parts[4];
     u32_t* pp = parts;
    3ae6:	8d 45 dc             	lea    0xffffffdc(%ebp),%eax
    3ae9:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)

     c = *cp;
    3aec:	8b 45 08             	mov    0x8(%ebp),%eax
    3aef:	0f b6 00             	movzbl (%eax),%eax
    3af2:	88 45 fb             	mov    %al,0xfffffffb(%ebp)
     for (;;) {
         /*
          * Collect number up to ``.''.
          * Values are specified as for C:
          * 0x=hex, 0=octal, isdigit=decimal.
          */
         if (!isdigit(c))
    3af5:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
    3af9:	3c 2f                	cmp    $0x2f,%al
    3afb:	76 08                	jbe    3b05 <inet_aton+0x25>
    3afd:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
    3b01:	3c 39                	cmp    $0x39,%al
    3b03:	76 0c                	jbe    3b11 <inet_aton+0x31>
             return (0);
    3b05:	c7 45 c0 00 00 00 00 	movl   $0x0,0xffffffc0(%ebp)
    3b0c:	e9 78 02 00 00       	jmp    3d89 <inet_aton+0x2a9>
         val = 0; base = 10;
    3b11:	c7 45 ec 00 00 00 00 	movl   $0x0,0xffffffec(%ebp)
    3b18:	c7 45 f0 0a 00 00 00 	movl   $0xa,0xfffffff0(%ebp)
         if (c == '0') {
    3b1f:	80 7d fb 30          	cmpb   $0x30,0xfffffffb(%ebp)
    3b23:	75 36                	jne    3b5b <inet_aton+0x7b>
             c = *++cp;
    3b25:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    3b29:	8b 45 08             	mov    0x8(%ebp),%eax
    3b2c:	0f b6 00             	movzbl (%eax),%eax
    3b2f:	88 45 fb             	mov    %al,0xfffffffb(%ebp)
             if (c == 'x' || c == 'X')
    3b32:	80 7d fb 78          	cmpb   $0x78,0xfffffffb(%ebp)
    3b36:	74 06                	je     3b3e <inet_aton+0x5e>
    3b38:	80 7d fb 58          	cmpb   $0x58,0xfffffffb(%ebp)
    3b3c:	75 16                	jne    3b54 <inet_aton+0x74>
                 base = 16, c = *++cp;
    3b3e:	c7 45 f0 10 00 00 00 	movl   $0x10,0xfffffff0(%ebp)
    3b45:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    3b49:	8b 45 08             	mov    0x8(%ebp),%eax
    3b4c:	0f b6 00             	movzbl (%eax),%eax
    3b4f:	88 45 fb             	mov    %al,0xfffffffb(%ebp)
    3b52:	eb 07                	jmp    3b5b <inet_aton+0x7b>
             else
                 base = 8;
    3b54:	c7 45 f0 08 00 00 00 	movl   $0x8,0xfffffff0(%ebp)
         }
         for (;;) {
             if (isascii(c) && isdigit(c)) {
    3b5b:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
    3b5f:	3c 1f                	cmp    $0x1f,%al
    3b61:	76 3b                	jbe    3b9e <inet_aton+0xbe>
    3b63:	80 7d fb 00          	cmpb   $0x0,0xfffffffb(%ebp)
    3b67:	78 35                	js     3b9e <inet_aton+0xbe>
    3b69:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
    3b6d:	3c 2f                	cmp    $0x2f,%al
    3b6f:	76 2d                	jbe    3b9e <inet_aton+0xbe>
    3b71:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
    3b75:	3c 39                	cmp    $0x39,%al
    3b77:	77 25                	ja     3b9e <inet_aton+0xbe>
                 val = (val * base) + (c - '0');
    3b79:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
    3b7c:	89 c2                	mov    %eax,%edx
    3b7e:	0f af 55 ec          	imul   0xffffffec(%ebp),%edx
    3b82:	0f be 45 fb          	movsbl 0xfffffffb(%ebp),%eax
    3b86:	8d 04 02             	lea    (%edx,%eax,1),%eax
    3b89:	83 e8 30             	sub    $0x30,%eax
    3b8c:	89 45 ec             	mov    %eax,0xffffffec(%ebp)
                 c = *++cp;
    3b8f:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    3b93:	8b 45 08             	mov    0x8(%ebp),%eax
    3b96:	0f b6 00             	movzbl (%eax),%eax
    3b99:	88 45 fb             	mov    %al,0xfffffffb(%ebp)
    3b9c:	eb bd                	jmp    3b5b <inet_aton+0x7b>
             } else if (base == 16 && isascii(c) && isxdigit(c)) {
    3b9e:	83 7d f0 10          	cmpl   $0x10,0xfffffff0(%ebp)
    3ba2:	0f 85 99 00 00 00    	jne    3c41 <inet_aton+0x161>
    3ba8:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
    3bac:	3c 1f                	cmp    $0x1f,%al
    3bae:	0f 86 8d 00 00 00    	jbe    3c41 <inet_aton+0x161>
    3bb4:	80 7d fb 00          	cmpb   $0x0,0xfffffffb(%ebp)
    3bb8:	0f 88 83 00 00 00    	js     3c41 <inet_aton+0x161>
    3bbe:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
    3bc2:	3c 2f                	cmp    $0x2f,%al
    3bc4:	76 08                	jbe    3bce <inet_aton+0xee>
    3bc6:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
    3bca:	3c 39                	cmp    $0x39,%al
    3bcc:	76 20                	jbe    3bee <inet_aton+0x10e>
    3bce:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
    3bd2:	3c 60                	cmp    $0x60,%al
    3bd4:	76 08                	jbe    3bde <inet_aton+0xfe>
    3bd6:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
    3bda:	3c 66                	cmp    $0x66,%al
    3bdc:	76 10                	jbe    3bee <inet_aton+0x10e>
    3bde:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
    3be2:	3c 40                	cmp    $0x40,%al
    3be4:	76 5b                	jbe    3c41 <inet_aton+0x161>
    3be6:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
    3bea:	3c 46                	cmp    $0x46,%al
    3bec:	77 53                	ja     3c41 <inet_aton+0x161>
                 val = (val << 4) |
    3bee:	8b 45 ec             	mov    0xffffffec(%ebp),%eax
    3bf1:	89 c2                	mov    %eax,%edx
    3bf3:	c1 e2 04             	shl    $0x4,%edx
    3bf6:	89 55 c4             	mov    %edx,0xffffffc4(%ebp)
    3bf9:	0f be 45 fb          	movsbl 0xfffffffb(%ebp),%eax
    3bfd:	83 c0 0a             	add    $0xa,%eax
    3c00:	89 45 c8             	mov    %eax,0xffffffc8(%ebp)
    3c03:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
    3c07:	3c 60                	cmp    $0x60,%al
    3c09:	76 11                	jbe    3c1c <inet_aton+0x13c>
    3c0b:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
    3c0f:	3c 7a                	cmp    $0x7a,%al
    3c11:	77 09                	ja     3c1c <inet_aton+0x13c>
    3c13:	c7 45 cc 61 00 00 00 	movl   $0x61,0xffffffcc(%ebp)
    3c1a:	eb 07                	jmp    3c23 <inet_aton+0x143>
    3c1c:	c7 45 cc 41 00 00 00 	movl   $0x41,0xffffffcc(%ebp)
    3c23:	8b 45 c8             	mov    0xffffffc8(%ebp),%eax
    3c26:	2b 45 cc             	sub    0xffffffcc(%ebp),%eax
    3c29:	0b 45 c4             	or     0xffffffc4(%ebp),%eax
    3c2c:	89 45 ec             	mov    %eax,0xffffffec(%ebp)
                     (c + 10 - (islower(c) ? 'a' : 'A'));
                 c = *++cp;
    3c2f:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    3c33:	8b 45 08             	mov    0x8(%ebp),%eax
    3c36:	0f b6 00             	movzbl (%eax),%eax
    3c39:	88 45 fb             	mov    %al,0xfffffffb(%ebp)
             } else
             break;
         }
    3c3c:	e9 1a ff ff ff       	jmp    3b5b <inet_aton+0x7b>
         if (c == '.') {
    3c41:	80 7d fb 2e          	cmpb   $0x2e,0xfffffffb(%ebp)
    3c45:	75 35                	jne    3c7c <inet_aton+0x19c>
             /*
              * Internet format:
              *  a.b.c.d
              *  a.b.c   (with c treated as 16 bits)
              *  a.b (with b treated as 24 bits)
              */
             if (pp >= parts + 3)
    3c47:	8d 45 dc             	lea    0xffffffdc(%ebp),%eax
    3c4a:	83 c0 0c             	add    $0xc,%eax
    3c4d:	3b 45 fc             	cmp    0xfffffffc(%ebp),%eax
    3c50:	77 0c                	ja     3c5e <inet_aton+0x17e>
                 return (0);
    3c52:	c7 45 c0 00 00 00 00 	movl   $0x0,0xffffffc0(%ebp)
    3c59:	e9 2b 01 00 00       	jmp    3d89 <inet_aton+0x2a9>
             *pp++ = val;
    3c5e:	8b 55 fc             	mov    0xfffffffc(%ebp),%edx
    3c61:	8b 45 ec             	mov    0xffffffec(%ebp),%eax
    3c64:	89 02                	mov    %eax,(%edx)
    3c66:	83 45 fc 04          	addl   $0x4,0xfffffffc(%ebp)
             c = *++cp;
    3c6a:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    3c6e:	8b 45 08             	mov    0x8(%ebp),%eax
    3c71:	0f b6 00             	movzbl (%eax),%eax
    3c74:	88 45 fb             	mov    %al,0xfffffffb(%ebp)
         } else
             break;
     }
    3c77:	e9 79 fe ff ff       	jmp    3af5 <inet_aton+0x15>
     /*
      * Check for trailing characters.
      */
     if (c != '\0' && (!isascii(c) || !isspace(c)))
    3c7c:	80 7d fb 00          	cmpb   $0x0,0xfffffffb(%ebp)
    3c80:	74 3e                	je     3cc0 <inet_aton+0x1e0>
    3c82:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
    3c86:	3c 1f                	cmp    $0x1f,%al
    3c88:	76 2a                	jbe    3cb4 <inet_aton+0x1d4>
    3c8a:	80 7d fb 00          	cmpb   $0x0,0xfffffffb(%ebp)
    3c8e:	78 24                	js     3cb4 <inet_aton+0x1d4>
    3c90:	80 7d fb 20          	cmpb   $0x20,0xfffffffb(%ebp)
    3c94:	74 2a                	je     3cc0 <inet_aton+0x1e0>
    3c96:	80 7d fb 0c          	cmpb   $0xc,0xfffffffb(%ebp)
    3c9a:	74 24                	je     3cc0 <inet_aton+0x1e0>
    3c9c:	80 7d fb 0a          	cmpb   $0xa,0xfffffffb(%ebp)
    3ca0:	74 1e                	je     3cc0 <inet_aton+0x1e0>
    3ca2:	80 7d fb 0d          	cmpb   $0xd,0xfffffffb(%ebp)
    3ca6:	74 18                	je     3cc0 <inet_aton+0x1e0>
    3ca8:	80 7d fb 09          	cmpb   $0x9,0xfffffffb(%ebp)
    3cac:	74 12                	je     3cc0 <inet_aton+0x1e0>
    3cae:	80 7d fb 0b          	cmpb   $0xb,0xfffffffb(%ebp)
    3cb2:	74 0c                	je     3cc0 <inet_aton+0x1e0>
         return (0);
    3cb4:	c7 45 c0 00 00 00 00 	movl   $0x0,0xffffffc0(%ebp)
    3cbb:	e9 c9 00 00 00       	jmp    3d89 <inet_aton+0x2a9>
     /*
      * Concoct the address according to
      * the number of parts specified.
      */
     n = pp - parts + 1;
    3cc0:	8b 55 fc             	mov    0xfffffffc(%ebp),%edx
    3cc3:	8d 45 dc             	lea    0xffffffdc(%ebp),%eax
    3cc6:	89 d1                	mov    %edx,%ecx
    3cc8:	29 c1                	sub    %eax,%ecx
    3cca:	89 c8                	mov    %ecx,%eax
    3ccc:	c1 f8 02             	sar    $0x2,%eax
    3ccf:	83 c0 01             	add    $0x1,%eax
    3cd2:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
     switch (n) {
    3cd5:	83 7d f4 04          	cmpl   $0x4,0xfffffff4(%ebp)
    3cd9:	0f 87 8b 00 00 00    	ja     3d6a <inet_aton+0x28a>
    3cdf:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
    3ce2:	c1 e0 02             	shl    $0x2,%eax
    3ce5:	8b 80 08 52 00 00    	mov    0x5208(%eax),%eax
    3ceb:	ff e0                	jmp    *%eax

     case 0:
         return (0);     /* initial nondigit */
    3ced:	c7 45 c0 00 00 00 00 	movl   $0x0,0xffffffc0(%ebp)
    3cf4:	e9 90 00 00 00       	jmp    3d89 <inet_aton+0x2a9>

     case 1:             /* a -- 32 bits */
         break;

     case 2:             /* a.b -- 8.24 bits */
         if (val > 0xffffff)
    3cf9:	81 7d ec ff ff ff 00 	cmpl   $0xffffff,0xffffffec(%ebp)
    3d00:	76 09                	jbe    3d0b <inet_aton+0x22b>
             return (0);
    3d02:	c7 45 c0 00 00 00 00 	movl   $0x0,0xffffffc0(%ebp)
    3d09:	eb 7e                	jmp    3d89 <inet_aton+0x2a9>
         val |= parts[0] << 24;
    3d0b:	8b 45 dc             	mov    0xffffffdc(%ebp),%eax
    3d0e:	c1 e0 18             	shl    $0x18,%eax
    3d11:	09 45 ec             	or     %eax,0xffffffec(%ebp)
         break;
    3d14:	eb 54                	jmp    3d6a <inet_aton+0x28a>

     case 3:             /* a.b.c -- 8.8.16 bits */
         if (val > 0xffff)
    3d16:	81 7d ec ff ff 00 00 	cmpl   $0xffff,0xffffffec(%ebp)
    3d1d:	76 09                	jbe    3d28 <inet_aton+0x248>
             return (0);
    3d1f:	c7 45 c0 00 00 00 00 	movl   $0x0,0xffffffc0(%ebp)
    3d26:	eb 61                	jmp    3d89 <inet_aton+0x2a9>
         val |= (parts[0] << 24) | (parts[1] << 16);
    3d28:	8b 45 dc             	mov    0xffffffdc(%ebp),%eax
    3d2b:	89 c2                	mov    %eax,%edx
    3d2d:	c1 e2 18             	shl    $0x18,%edx
    3d30:	8b 45 e0             	mov    0xffffffe0(%ebp),%eax
    3d33:	c1 e0 10             	shl    $0x10,%eax
    3d36:	09 d0                	or     %edx,%eax
    3d38:	09 45 ec             	or     %eax,0xffffffec(%ebp)
         break;
    3d3b:	eb 2d                	jmp    3d6a <inet_aton+0x28a>

     case 4:             /* a.b.c.d -- 8.8.8.8 bits */
         if (val > 0xff)
    3d3d:	81 7d ec ff 00 00 00 	cmpl   $0xff,0xffffffec(%ebp)
    3d44:	76 09                	jbe    3d4f <inet_aton+0x26f>
             return (0);
    3d46:	c7 45 c0 00 00 00 00 	movl   $0x0,0xffffffc0(%ebp)
    3d4d:	eb 3a                	jmp    3d89 <inet_aton+0x2a9>
         val |= (parts[0] << 24) | (parts[1] << 16) | (parts[2] << 8);
    3d4f:	8b 45 dc             	mov    0xffffffdc(%ebp),%eax
    3d52:	89 c2                	mov    %eax,%edx
    3d54:	c1 e2 18             	shl    $0x18,%edx
    3d57:	8b 45 e0             	mov    0xffffffe0(%ebp),%eax
    3d5a:	c1 e0 10             	shl    $0x10,%eax
    3d5d:	09 c2                	or     %eax,%edx
    3d5f:	8b 45 e4             	mov    0xffffffe4(%ebp),%eax
    3d62:	c1 e0 08             	shl    $0x8,%eax
    3d65:	09 d0                	or     %edx,%eax
    3d67:	09 45 ec             	or     %eax,0xffffffec(%ebp)
         break;
     }
     if (addr)
    3d6a:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    3d6e:	74 12                	je     3d82 <inet_aton+0x2a2>
         addr->s_addr = htonl(val);
    3d70:	8b 45 ec             	mov    0xffffffec(%ebp),%eax
    3d73:	89 04 24             	mov    %eax,(%esp)
    3d76:	e8 65 01 00 00       	call   3ee0 <htonl>
    3d7b:	89 c2                	mov    %eax,%edx
    3d7d:	8b 45 0c             	mov    0xc(%ebp),%eax
    3d80:	89 10                	mov    %edx,(%eax)
     return (1);
    3d82:	c7 45 c0 01 00 00 00 	movl   $0x1,0xffffffc0(%ebp)
    3d89:	8b 45 c0             	mov    0xffffffc0(%ebp),%eax
 }
    3d8c:	c9                   	leave  
    3d8d:	c3                   	ret    
    3d8e:	89 f6                	mov    %esi,%esi

00003d90 <inet_ntoa>:

/* Convert numeric IP address into decimal dotted ASCII representation.
 * returns ptr to static buffer; not reentrant!
 */
char *inet_ntoa(struct in_addr addr)
{
    3d90:	55                   	push   %ebp
    3d91:	89 e5                	mov    %esp,%ebp
    3d93:	53                   	push   %ebx
    3d94:	83 ec 24             	sub    $0x24,%esp
  static char str[16];
  u32_t s_addr = addr.s_addr;
    3d97:	8b 45 08             	mov    0x8(%ebp),%eax
    3d9a:	89 45 ec             	mov    %eax,0xffffffec(%ebp)
  char inv[3];
  char *rp;
  char *ap;
  u8_t rem;
  u8_t n;
  u8_t i;

  rp = str;
    3d9d:	c7 45 f0 6c 52 00 00 	movl   $0x526c,0xfffffff0(%ebp)
  ap = (u8_t *)&s_addr;
    3da4:	8d 45 ec             	lea    0xffffffec(%ebp),%eax
    3da7:	89 45 f4             	mov    %eax,0xfffffff4(%ebp)
  for(n = 0; n < 4; n++) {
    3daa:	c6 45 fa 00          	movb   $0x0,0xfffffffa(%ebp)
    3dae:	e9 af 00 00 00       	jmp    3e62 <inet_ntoa+0xd2>
    i = 0;
    3db3:	c6 45 fb 00          	movb   $0x0,0xfffffffb(%ebp)
    do {
      rem = *ap % (u8_t)10;
    3db7:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
    3dba:	0f b6 08             	movzbl (%eax),%ecx
    3dbd:	b8 67 00 00 00       	mov    $0x67,%eax
    3dc2:	f6 e9                	imul   %cl
    3dc4:	66 c1 e8 08          	shr    $0x8,%ax
    3dc8:	89 c2                	mov    %eax,%edx
    3dca:	c0 fa 02             	sar    $0x2,%dl
    3dcd:	89 c8                	mov    %ecx,%eax
    3dcf:	c0 f8 07             	sar    $0x7,%al
    3dd2:	89 d3                	mov    %edx,%ebx
    3dd4:	28 c3                	sub    %al,%bl
    3dd6:	88 5d db             	mov    %bl,0xffffffdb(%ebp)
    3dd9:	0f b6 45 db          	movzbl 0xffffffdb(%ebp),%eax
    3ddd:	c1 e0 02             	shl    $0x2,%eax
    3de0:	02 45 db             	add    0xffffffdb(%ebp),%al
    3de3:	01 c0                	add    %eax,%eax
    3de5:	89 ca                	mov    %ecx,%edx
    3de7:	28 c2                	sub    %al,%dl
    3de9:	88 55 db             	mov    %dl,0xffffffdb(%ebp)
    3dec:	0f b6 5d db          	movzbl 0xffffffdb(%ebp),%ebx
    3df0:	88 5d f9             	mov    %bl,0xfffffff9(%ebp)
      *ap /= (u8_t)10;
    3df3:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
    3df6:	0f b6 08             	movzbl (%eax),%ecx
    3df9:	b8 67 00 00 00       	mov    $0x67,%eax
    3dfe:	f6 e9                	imul   %cl
    3e00:	66 c1 e8 08          	shr    $0x8,%ax
    3e04:	89 c2                	mov    %eax,%edx
    3e06:	c0 fa 02             	sar    $0x2,%dl
    3e09:	89 c8                	mov    %ecx,%eax
    3e0b:	c0 f8 07             	sar    $0x7,%al
    3e0e:	28 c2                	sub    %al,%dl
    3e10:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
    3e13:	88 10                	mov    %dl,(%eax)
      inv[i++] = '0' + rem;
    3e15:	0f b6 55 fb          	movzbl 0xfffffffb(%ebp),%edx
    3e19:	0f b6 45 f9          	movzbl 0xfffffff9(%ebp),%eax
    3e1d:	83 c0 30             	add    $0x30,%eax
    3e20:	88 44 15 e9          	mov    %al,0xffffffe9(%ebp,%edx,1)
    3e24:	80 45 fb 01          	addb   $0x1,0xfffffffb(%ebp)
    } while(*ap);
    3e28:	8b 45 f4             	mov    0xfffffff4(%ebp),%eax
    3e2b:	0f b6 00             	movzbl (%eax),%eax
    3e2e:	84 c0                	test   %al,%al
    3e30:	75 85                	jne    3db7 <inet_ntoa+0x27>
    while(i--)
    3e32:	eb 12                	jmp    3e46 <inet_ntoa+0xb6>
      *rp++ = inv[i];
    3e34:	0f b6 45 fb          	movzbl 0xfffffffb(%ebp),%eax
    3e38:	0f b6 54 05 e9       	movzbl 0xffffffe9(%ebp,%eax,1),%edx
    3e3d:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
    3e40:	88 10                	mov    %dl,(%eax)
    3e42:	83 45 f0 01          	addl   $0x1,0xfffffff0(%ebp)
    3e46:	80 6d fb 01          	subb   $0x1,0xfffffffb(%ebp)
    3e4a:	80 7d fb ff          	cmpb   $0xff,0xfffffffb(%ebp)
    3e4e:	75 e4                	jne    3e34 <inet_ntoa+0xa4>
    *rp++ = '.';
    3e50:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
    3e53:	c6 00 2e             	movb   $0x2e,(%eax)
    3e56:	83 45 f0 01          	addl   $0x1,0xfffffff0(%ebp)
    ap++;
    3e5a:	83 45 f4 01          	addl   $0x1,0xfffffff4(%ebp)
    3e5e:	80 45 fa 01          	addb   $0x1,0xfffffffa(%ebp)
    3e62:	80 7d fa 03          	cmpb   $0x3,0xfffffffa(%ebp)
    3e66:	0f 86 47 ff ff ff    	jbe    3db3 <inet_ntoa+0x23>
  }
  *--rp = 0;
    3e6c:	83 6d f0 01          	subl   $0x1,0xfffffff0(%ebp)
    3e70:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
    3e73:	c6 00 00             	movb   $0x0,(%eax)
  return str;
    3e76:	b8 6c 52 00 00       	mov    $0x526c,%eax
}
    3e7b:	83 c4 24             	add    $0x24,%esp
    3e7e:	5b                   	pop    %ebx
    3e7f:	5d                   	pop    %ebp
    3e80:	c3                   	ret    
    3e81:	eb 0d                	jmp    3e90 <htons>
    3e83:	90                   	nop    
    3e84:	90                   	nop    
    3e85:	90                   	nop    
    3e86:	90                   	nop    
    3e87:	90                   	nop    
    3e88:	90                   	nop    
    3e89:	90                   	nop    
    3e8a:	90                   	nop    
    3e8b:	90                   	nop    
    3e8c:	90                   	nop    
    3e8d:	90                   	nop    
    3e8e:	90                   	nop    
    3e8f:	90                   	nop    

00003e90 <htons>:


#ifndef BYTE_ORDER
#error BYTE_ORDER is not defined
#endif
#if BYTE_ORDER == LITTLE_ENDIAN

u16_t
htons(u16_t n)
{
    3e90:	55                   	push   %ebp
    3e91:	89 e5                	mov    %esp,%ebp
    3e93:	83 ec 04             	sub    $0x4,%esp
    3e96:	8b 45 08             	mov    0x8(%ebp),%eax
    3e99:	66 89 45 fc          	mov    %ax,0xfffffffc(%ebp)
  return ((n & 0xff) << 8) | ((n & 0xff00) >> 8);
    3e9d:	0f b7 45 fc          	movzwl 0xfffffffc(%ebp),%eax
    3ea1:	25 ff 00 00 00       	and    $0xff,%eax
    3ea6:	c1 e0 08             	shl    $0x8,%eax
    3ea9:	89 c2                	mov    %eax,%edx
    3eab:	0f b7 45 fc          	movzwl 0xfffffffc(%ebp),%eax
    3eaf:	25 00 ff 00 00       	and    $0xff00,%eax
    3eb4:	c1 f8 08             	sar    $0x8,%eax
    3eb7:	09 d0                	or     %edx,%eax
    3eb9:	0f b7 c0             	movzwl %ax,%eax
}
    3ebc:	c9                   	leave  
    3ebd:	c3                   	ret    
    3ebe:	89 f6                	mov    %esi,%esi

00003ec0 <ntohs>:

u16_t
ntohs(u16_t n)
{
    3ec0:	55                   	push   %ebp
    3ec1:	89 e5                	mov    %esp,%ebp
    3ec3:	83 ec 08             	sub    $0x8,%esp
    3ec6:	8b 45 08             	mov    0x8(%ebp),%eax
    3ec9:	66 89 45 fc          	mov    %ax,0xfffffffc(%ebp)
  return htons(n);
    3ecd:	0f b7 45 fc          	movzwl 0xfffffffc(%ebp),%eax
    3ed1:	89 04 24             	mov    %eax,(%esp)
    3ed4:	e8 b7 ff ff ff       	call   3e90 <htons>
    3ed9:	0f b7 c0             	movzwl %ax,%eax
}
    3edc:	c9                   	leave  
    3edd:	c3                   	ret    
    3ede:	89 f6                	mov    %esi,%esi

00003ee0 <htonl>:

u32_t
htonl(u32_t n)
{
    3ee0:	55                   	push   %ebp
    3ee1:	89 e5                	mov    %esp,%ebp
  return ((n & 0xff) << 24) |
    3ee3:	0f b6 45 08          	movzbl 0x8(%ebp),%eax
    3ee7:	89 c2                	mov    %eax,%edx
    3ee9:	c1 e2 18             	shl    $0x18,%edx
    3eec:	8b 45 08             	mov    0x8(%ebp),%eax
    3eef:	25 00 ff 00 00       	and    $0xff00,%eax
    3ef4:	c1 e0 08             	shl    $0x8,%eax
    3ef7:	09 c2                	or     %eax,%edx
    3ef9:	8b 45 08             	mov    0x8(%ebp),%eax
    3efc:	25 00 00 ff 00       	and    $0xff0000,%eax
    3f01:	c1 e8 08             	shr    $0x8,%eax
    3f04:	09 c2                	or     %eax,%edx
    3f06:	8b 45 08             	mov    0x8(%ebp),%eax
    3f09:	25 00 00 00 ff       	and    $0xff000000,%eax
    3f0e:	c1 e8 18             	shr    $0x18,%eax
    3f11:	09 d0                	or     %edx,%eax
    ((n & 0xff00) << 8) |
    ((n & 0xff0000) >> 8) |
    ((n & 0xff000000) >> 24);
}
    3f13:	5d                   	pop    %ebp
    3f14:	c3                   	ret    
    3f15:	8d 74 26 00          	lea    0x0(%esi),%esi
    3f19:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00003f20 <ntohl>:

u32_t
ntohl(u32_t n)
{
    3f20:	55                   	push   %ebp
    3f21:	89 e5                	mov    %esp,%ebp
    3f23:	83 ec 04             	sub    $0x4,%esp
  return htonl(n);
    3f26:	8b 45 08             	mov    0x8(%ebp),%eax
    3f29:	89 04 24             	mov    %eax,(%esp)
    3f2c:	e8 af ff ff ff       	call   3ee0 <htonl>
}
    3f31:	c9                   	leave  
    3f32:	c3                   	ret    
