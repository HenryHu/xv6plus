1250 #include "types.h"
1251 #include "defs.h"
1252 #include "param.h"
1253 #include "mmu.h"
1254 #include "proc.h"
1255 #include "x86.h"
1256 #include "pci.h"
1257 
1258 static void bootothers(void);
1259 
1260 // Bootstrap processor starts running C code here.
1261 int
1262 main(void)
1263 {
1264   int i;
1265   static volatile int bcpu;  // cannot be on stack
1266   extern char edata[], end[];
1267 
1268   // clear BSS
1269   memset(edata, 0, end - edata);
1270 
1271   // Prevent release() from enabling interrupts.
1272   for(i=0; i<NCPU; i++)
1273     cpus[i].nlock = 1;
1274 
1275 //  mp_init(); // collect info about this machine
1276   bcpu = mp_bcpu();
1277 
1278   // Switch to bootstrap processor's stack
1279   asm volatile("movl %0, %%esp" : : "r" (cpus[bcpu].mpstack+MPSTACK-32));
1280   asm volatile("movl %0, %%ebp" : : "r" (cpus[bcpu].mpstack+MPSTACK));
1281 
1282   lapic_init(bcpu);
1283   cprintf("\ncpu%d: starting xv6\n\n", cpu());
1284 
1285   pinit();         // process table
1286   binit();         // buffer cache
1287   pic_init();      // interrupt controller
1288   ioapic_init();   // another interrupt controller
1289   kinit();         // physical memory allocator
1290   tvinit();        // trap vectors
1291   idtinit();       // interrupt descriptor table
1292   fileinit();      // file table
1293   iinit();         // inode cache
1294   setupsegs(0);    // segments & TSS
1295   console_init();  // I/O devices & their interrupts
1296   ide_init();      // disk
1297 
1298 
1299 
1300   // lwIP init
1301   memp_init();
1302   mem_init();
1303   netif_init();
1304   pbuf_init();
1305   tcpip_init(0, 0);
1306 
1307   pci_init();      // PCI
1308   bootothers();    // boot other CPUs
1309   if(!ismp)
1310     timer_init(); // uniprocessor timer
1311   userinit();      // first user process
1312 
1313   // enable interrupts on this processor.
1314   cpus[cpu()].nlock--;
1315   if (cpus[cpu()].nlock == 0)
1316     sti();
1317 
1318   scheduler();
1319 }
1320 
1321 // Additional processors start here.
1322 static void
1323 mpmain(void)
1324 {
1325   cprintf("cpu%d: starting\n", cpu());
1326   idtinit();
1327   lapic_init(cpu());
1328   setupsegs(0);
1329   cpuid(0, 0, 0, 0, 0);  // memory barrier
1330   cpus[cpu()].booted = 1;
1331 
1332   // Enable interrupts on this processor.
1333   cpus[cpu()].nlock--;
1334   if (cpus[cpu()].nlock == 0)
1335     sti();
1336 
1337   scheduler();
1338 }
1339 
1340 
1341 
1342 
1343 
1344 
1345 
1346 
1347 
1348 
1349 
1350 static void
1351 bootothers(void)
1352 {
1353   extern uchar _binary_bootother_start[], _binary_bootother_size[];
1354   uchar *code;
1355   struct cpu *c;
1356 
1357   // Write bootstrap code to unused memory at 0x7000.
1358   code = (uchar*)0x7000;
1359   memmove(code, _binary_bootother_start, (uint)_binary_bootother_size);
1360 
1361   for(c = cpus; c < cpus+ncpu; c++){
1362     if(c == cpus+cpu())  // We've started already.
1363       continue;
1364 
1365     // Fill in %esp, %eip and start code on cpu.
1366     *(void**)(code-4) = c->mpstack + MPSTACK;
1367     *(void**)(code-8) = mpmain;
1368     lapic_startap(c->apicid, (uint)code);
1369 
1370     // Wait for cpu to get through bootstrap.
1371     while(c->booted == 0)
1372       ;
1373   }
1374 }
1375 
1376 
1377 
1378 
1379 
1380 
1381 
1382 
1383 
1384 
1385 
1386 
1387 
1388 
1389 
1390 
1391 
1392 
1393 
1394 
1395 
1396 
1397 
1398 
1399 
