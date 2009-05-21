2050 #include "types.h"
2051 #include "defs.h"
2052 #include "param.h"
2053 #include "mmu.h"
2054 #include "x86.h"
2055 #include "proc.h"
2056 #include "spinlock.h"
2057 #include "thread.h"
2058 
2059 struct spinlock proc_table_lock;
2060 
2061 struct proc proc[NPROC];
2062 struct proc *curproc[NCPU];
2063 struct proc *initproc;
2064 
2065 int nextpid = 1;
2066 extern void forkret(void);
2067 extern void forkret1(struct trapframe*);
2068 
2069 void
2070 pinit(void)
2071 {
2072   initlock(&proc_table_lock, "proc_table");
2073 }
2074 
2075 // Look in the process table for an UNUSED proc.
2076 // If found, change state to EMBRYO and return it.
2077 // Otherwise return 0.
2078 struct proc*
2079 allocproc(void)
2080 {
2081   int i;
2082   struct proc *p;
2083 
2084   acquire(&proc_table_lock);
2085   for(i = 0; i < NPROC; i++){
2086     p = &proc[i];
2087     if(p->state == UNUSED){
2088       p->state = EMBRYO;
2089       p->pid = nextpid++;
2090       p->thr = 0;
2091       release(&proc_table_lock);
2092       return p;
2093     }
2094   }
2095   release(&proc_table_lock);
2096   return 0;
2097 }
2098 
2099 
2100 // Grow current process's memory by n bytes.
2101 // Return old size on success, -1 on failure.
2102 int
2103 growproc(int n)
2104 {
2105   char *newmem, *oldmem;
2106 
2107   newmem = kalloc(cp->sz + n);
2108   if(newmem == 0)
2109     return -1;
2110   memmove(newmem, cp->mem, cp->sz);
2111   memset(newmem + cp->sz, 0, n);
2112   oldmem = cp->mem;
2113   cp->mem = newmem;
2114   kfree(oldmem, cp->sz);
2115   cp->sz += n;
2116   return cp->sz - n;
2117 }
2118 
2119 // Set up CPU's segment descriptors and task state for a given process.
2120 // If p==0, set up for "idle" state for when scheduler() is running.
2121 void
2122 setupsegs(struct proc *p)
2123 {
2124   struct cpu *c;
2125 
2126   c = &cpus[cpu()];
2127   c->ts.ss0 = SEG_KDATA << 3;
2128   if(p)
2129     c->ts.esp0 = (uint)(p->kstack + KSTACKSIZE);
2130   else
2131     c->ts.esp0 = 0xffffffff;
2132 
2133   c->gdt[0] = SEG_NULL;
2134   c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0x100000 + 64*1024-1, 0);
2135   c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
2136   c->gdt[SEG_TSS] = SEG16(STS_T32A, (uint)&c->ts, sizeof(c->ts)-1, 0);
2137   c->gdt[SEG_TSS].s = 0;
2138   if(p){
2139     c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, (uint)p->mem, p->sz-1, DPL_USER);
2140     c->gdt[SEG_UDATA] = SEG(STA_W, (uint)p->mem, p->sz-1, DPL_USER);
2141   } else {
2142     c->gdt[SEG_UCODE] = SEG_NULL;
2143     c->gdt[SEG_UDATA] = SEG_NULL;
2144   }
2145 
2146   lgdt(c->gdt, sizeof(c->gdt));
2147   ltr(SEG_TSS << 3);
2148 }
2149 
2150 // Create a new process copying p as the parent.
2151 // Sets up stack to return as if from system call.
2152 // Caller must set state of returned proc to RUNNABLE.
2153 struct proc*
2154 copyproc(struct proc *p)
2155 {
2156   int i;
2157   struct proc *np;
2158 
2159   // Allocate process.
2160   if((np = allocproc()) == 0)
2161     return 0;
2162 
2163   // Allocate kernel stack.
2164   if((np->kstack = kalloc(KSTACKSIZE)) == 0){
2165     np->state = UNUSED;
2166     return 0;
2167   }
2168   np->tf = (struct trapframe*)(np->kstack + KSTACKSIZE) - 1;
2169 
2170   if(p){  // Copy process state from p.
2171     np->parent = p;
2172     memmove(np->tf, p->tf, sizeof(*np->tf));
2173 
2174     np->sz = p->sz;
2175     if((np->mem = kalloc(np->sz)) == 0){
2176       kfree(np->kstack, KSTACKSIZE);
2177       np->kstack = 0;
2178       np->state = UNUSED;
2179       return 0;
2180     }
2181     memmove(np->mem, p->mem, np->sz);
2182 
2183     for(i = 0; i < NOFILE; i++)
2184       if(p->ofile[i])
2185         np->ofile[i] = filedup(p->ofile[i]);
2186     np->cwd = idup(p->cwd);
2187     np->thr = p->thr;
2188   }
2189 
2190   // Set up new context to start executing at forkret (see below).
2191   memset(&np->context, 0, sizeof(np->context));
2192   np->context.eip = (uint)forkret;
2193   np->context.esp = (uint)np->tf;
2194 
2195   // Clear %eax so that fork system call returns 0 in child.
2196   np->tf->eax = 0;
2197   return np;
2198 }
2199 
2200 // Set up first user process.
2201 void
2202 userinit(void)
2203 {
2204   struct proc *p;
2205   extern uchar _binary_initcode_start[], _binary_initcode_size[];
2206 
2207   p = copyproc(0);
2208   p->sz = PAGE;
2209   p->mem = kalloc(p->sz);
2210   p->cwd = namei("/");
2211   memset(p->tf, 0, sizeof(*p->tf));
2212   p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
2213   p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
2214   p->tf->es = p->tf->ds;
2215   p->tf->ss = p->tf->ds;
2216   p->tf->eflags = FL_IF;
2217   p->tf->esp = p->sz;
2218 
2219   // Make return address readable; needed for some gcc.
2220   p->tf->esp -= 4;
2221   *(uint*)(p->mem + p->tf->esp) = 0xefefefef;
2222 
2223   // On entry to user space, start executing at beginning of initcode.S.
2224   p->tf->eip = 0;
2225   memmove(p->mem, _binary_initcode_start, (int)_binary_initcode_size);
2226   safestrcpy(p->name, "initcode", sizeof(p->name));
2227   p->state = RUNNABLE;
2228 
2229   initproc = p;
2230 }
2231 
2232 // Per-CPU process scheduler.
2233 // Each CPU calls scheduler() after setting itself up.
2234 // Scheduler never returns.  It loops, doing:
2235 //  - choose a process to run
2236 //  - swtch to start running that process
2237 //  - eventually that process transfers control
2238 //      via swtch back to the scheduler.
2239 void
2240 scheduler(void)
2241 {
2242   struct proc *p;
2243   int i;
2244 
2245   for(;;){
2246     // Loop over process table looking for process to run.
2247     acquire(&proc_table_lock);
2248 
2249 
2250     for(i = 0; i < NPROC; i++){
2251       p = &proc[i];
2252       if((p->state != RUNNABLE) && (p->state != MSLEEPING))
2253         continue;
2254 
2255 //      cprintf("switch to %s eip: 0x%08x...\n", p->name, p->context.eip);
2256       // Switch to chosen process.  It is the process's job
2257       // to release proc_table_lock and then reacquire it
2258       // before jumping back to us.
2259       cp = p;
2260       setupsegs(p);
2261       if (p->state == RUNNABLE)
2262         p->state = RUNNING;
2263       swtch(&cpus[cpu()].context, &p->context);
2264 
2265 //      cprintf("done.\n");
2266       // Process is done running for now.
2267       // It should have changed its p->state before coming back.
2268       cp = 0;
2269       setupsegs(0);
2270     }
2271 
2272     release(&proc_table_lock);
2273   }
2274 }
2275 
2276 // Enter scheduler.  Must already hold proc_table_lock
2277 // and have changed curproc[cpu()]->state.
2278 void
2279 sched(void)
2280 {
2281   if(cp->state == RUNNING)
2282     panic("sched running");
2283   if(!holding(&proc_table_lock))
2284     panic("sched proc_table_lock");
2285 //  if(cpus[cpu()].nlock != 1)
2286 //    panic("sched locks");
2287 
2288   swtch(&cp->context, &cpus[cpu()].context);
2289 }
2290 
2291 // Give up the CPU for one scheduling round.
2292 void
2293 yield(void)
2294 {
2295   acquire(&proc_table_lock);
2296   cp->state = RUNNABLE;
2297   sched();
2298   release(&proc_table_lock);
2299 }
2300 // A fork child's very first scheduling by scheduler()
2301 // will swtch here.  "Return" to user space.
2302 void
2303 forkret(void)
2304 {
2305   // Still holding proc_table_lock from scheduler.
2306   release(&proc_table_lock);
2307 
2308   // Jump into assembly, never to return.
2309   forkret1(cp->tf);
2310 }
2311 
2312 int
2313 msleep_spin(void *chan, struct spinlock *lk, int timo)
2314 {
2315     uint32_t s = millitime();
2316     uint32_t p = s;
2317     int ret = 1; // Time Out
2318     s += timo;
2319 
2320     if (cp == 0)
2321         panic("msleep with cp == 0");
2322     if (lk == 0)
2323         panic("msleep without lock");
2324 
2325     if (lk != &proc_table_lock)
2326     {
2327         acquire(&proc_table_lock);
2328         release(lk);
2329     }
2330 
2331     cp->chan = chan;
2332     cp->state = MSLEEPING;
2333     while (p < s)
2334     {
2335         sched();
2336         if (cp->state == RUNNING)
2337         {
2338             ret = 0;
2339             break;
2340         }
2341         p = millitime();
2342     }
2343     cp->chan = 0;
2344     cp->state = RUNNING;
2345 
2346 
2347 
2348 
2349 
2350     if (lk != &proc_table_lock)
2351     {
2352         release(&proc_table_lock);
2353         acquire(lk);
2354     }
2355     return ret;
2356 }
2357 
2358 // Atomically release lock and sleep on chan.
2359 // Reacquires lock when reawakened.
2360 void
2361 sleep(void *chan, struct spinlock *lk)
2362 {
2363   if(cp == 0)
2364     panic("sleep");
2365 
2366   if(lk == 0)
2367     panic("sleep without lk");
2368 
2369   // Must acquire proc_table_lock in order to
2370   // change p->state and then call sched.
2371   // Once we hold proc_table_lock, we can be
2372   // guaranteed that we won't miss any wakeup
2373   // (wakeup runs with proc_table_lock locked),
2374   // so it's okay to release lk.
2375   if(lk != &proc_table_lock){
2376     acquire(&proc_table_lock);
2377     release(lk);
2378   }
2379 
2380   // Go to sleep.
2381   cp->chan = chan;
2382   cp->state = SLEEPING;
2383   sched();
2384 
2385   // Tidy up.
2386   cp->chan = 0;
2387 
2388   // Reacquire original lock.
2389   if(lk != &proc_table_lock){
2390     release(&proc_table_lock);
2391     acquire(lk);
2392   }
2393 }
2394 
2395 
2396 
2397 
2398 
2399 
2400 // Wake up all processes sleeping on chan.
2401 // Proc_table_lock must be held.
2402 static void
2403 wakeup1(void *chan)
2404 {
2405   struct proc *p;
2406 
2407   for(p = proc; p < &proc[NPROC]; p++)
2408     if(((p->state == SLEEPING) ||
2409                 (p->state == MSLEEPING)) && p->chan == chan)
2410       p->state = RUNNABLE;
2411 }
2412 
2413 // Wake up all processes sleeping on chan.
2414 // Proc_table_lock must be held.
2415 static void
2416 wakeup_one1(void *chan)
2417 {
2418   struct proc *p;
2419 
2420   for(p = proc; p < &proc[NPROC]; p++)
2421     if(((p->state == SLEEPING) ||
2422                 (p->state == MSLEEPING)) && p->chan == chan)
2423     {
2424       p->state = RUNNABLE;
2425       break;
2426     }
2427 }
2428 
2429 void
2430 wakeup_one(void *chan)
2431 {
2432   acquire(&proc_table_lock);
2433   wakeup_one1(chan);
2434   release(&proc_table_lock);
2435 }
2436 
2437 // Wake up all processes sleeping on chan.
2438 // Proc_table_lock is acquired and released.
2439 void
2440 wakeup(void *chan)
2441 {
2442   acquire(&proc_table_lock);
2443   wakeup1(chan);
2444   release(&proc_table_lock);
2445 }
2446 
2447 
2448 
2449 
2450 // Kill the process with the given pid.
2451 // Process won't actually exit until it returns
2452 // to user space (see trap in trap.c).
2453 int
2454 kill(int pid)
2455 {
2456   struct proc *p;
2457 
2458   acquire(&proc_table_lock);
2459   for(p = proc; p < &proc[NPROC]; p++){
2460     if(p->pid == pid){
2461       p->killed = 1;
2462       // Wake process from sleep if necessary.
2463       if(p->state == SLEEPING)
2464         p->state = RUNNABLE;
2465       release(&proc_table_lock);
2466       return 0;
2467     }
2468   }
2469   release(&proc_table_lock);
2470   return -1;
2471 }
2472 
2473 // Exit the current process.  Does not return.
2474 // Exited processes remain in the zombie state
2475 // until their parent calls wait() to find out they exited.
2476 void
2477 exit(void)
2478 {
2479   struct proc *p;
2480   int fd;
2481 
2482   if(cp == initproc)
2483     panic("init exiting");
2484 
2485   // Close all open files.
2486   for(fd = 0; fd < NOFILE; fd++){
2487     if(cp->ofile[fd]){
2488       fileclose(cp->ofile[fd]);
2489       cp->ofile[fd] = 0;
2490     }
2491   }
2492 
2493   iput(cp->cwd);
2494   cp->cwd = 0;
2495 
2496   acquire(&proc_table_lock);
2497 
2498   // Parent might be sleeping in proc_wait.
2499   wakeup1(cp->parent);
2500   // Pass abandoned children to init.
2501   for(p = proc; p < &proc[NPROC]; p++){
2502     if(p->parent == cp){
2503       p->parent = initproc;
2504       if(p->state == ZOMBIE)
2505         wakeup1(initproc);
2506     }
2507   }
2508 
2509   if (cp->thr)
2510       kproc_free(cp->thr);
2511 
2512   // Jump into the scheduler, never to return.
2513   cp->killed = 0;
2514   cp->state = ZOMBIE;
2515   cp->thr = 0;
2516   sched();
2517   panic("zombie exit");
2518 }
2519 
2520 // Wait for a child process to exit and return its pid.
2521 // Return -1 if this process has no children.
2522 int
2523 wait(void)
2524 {
2525   struct proc *p;
2526   int i, havekids, pid;
2527 
2528   acquire(&proc_table_lock);
2529   for(;;){
2530     // Scan through table looking for zombie children.
2531     havekids = 0;
2532     for(i = 0; i < NPROC; i++){
2533       p = &proc[i];
2534       if(p->state == UNUSED)
2535         continue;
2536       if(p->parent == cp){
2537         if(p->state == ZOMBIE){
2538           // Found one.
2539 #ifdef PROC_DEBUG
2540           cprintf("wait: freeing ZOMBIE %d %s\n", p->pid, p->name);
2541           cprintf("      freeing mem\n");
2542 #endif
2543           if (p->sz != 0) // kernel thread doesn't have mem
2544             kfree(p->mem, p->sz);
2545 #ifdef PROC_DEBUG
2546           cprintf("      freeing kstack\n");
2547 #endif
2548           kfree(p->kstack, KSTACKSIZE);
2549           pid = p->pid;
2550           p->state = UNUSED;
2551           p->pid = 0;
2552           p->parent = 0;
2553           p->name[0] = 0;
2554           release(&proc_table_lock);
2555           return pid;
2556         }
2557         havekids = 1;
2558       }
2559     }
2560 
2561     // No point waiting if we don't have any children.
2562     if(!havekids || cp->killed){
2563       release(&proc_table_lock);
2564       return -1;
2565     }
2566 
2567     // Wait for children to exit.  (See wakeup1 call in proc_exit.)
2568     sleep(cp, &proc_table_lock);
2569   }
2570 }
2571 
2572 // Print a process listing to console.  For debugging.
2573 // Runs when user types ^P on console.
2574 // No lock to avoid wedging a stuck machine further.
2575 void
2576 procdump(void)
2577 {
2578   static char *states[] = {
2579   [UNUSED]    "unused",
2580   [EMBRYO]    "embryo",
2581   [SLEEPING]  "sleep ",
2582   [RUNNABLE]  "runble",
2583   [RUNNING]   "run   ",
2584   [ZOMBIE]    "zombie",
2585   [MSLEEPING] "msleep"
2586   };
2587   int i, j;
2588   struct proc *p;
2589   char *state;
2590   uint pc[10];
2591 
2592   for(i = 0; i < NPROC; i++){
2593     p = &proc[i];
2594     if(p->state == UNUSED)
2595       continue;
2596     if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
2597       state = states[p->state];
2598     else
2599       state = "???";
2600     cprintf("%d %s %s", p->pid, state, p->name);
2601     if((p->state == SLEEPING) || (p->state == MSLEEPING)){
2602       getcallerpcs((uint*)p->context.ebp+2, pc);
2603       for(j=0; j<10 && pc[j] != 0; j++)
2604         cprintf(" %p", pc[j]);
2605     }
2606     cprintf("\n");
2607   }
2608 }
2609 
2610 
2611 
2612 
2613 
2614 
2615 
2616 
2617 
2618 
2619 
2620 
2621 
2622 
2623 
2624 
2625 
2626 
2627 
2628 
2629 
2630 
2631 
2632 
2633 
2634 
2635 
2636 
2637 
2638 
2639 
2640 
2641 
2642 
2643 
2644 
2645 
2646 
2647 
2648 
2649 
