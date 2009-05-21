0200 #ifndef XV6_DEFS_H_
0201 #define XV6_DEFS_H_
0202 #include "types.h"
0203 struct buf;
0204 struct context;
0205 struct file;
0206 struct inode;
0207 struct pipe;
0208 struct proc;
0209 struct spinlock;
0210 struct stat;
0211 
0212 // bio.c
0213 void            binit(void);
0214 struct buf*     bread(uint, uint);
0215 void            brelse(struct buf*);
0216 void            bwrite(struct buf*);
0217 
0218 // console.c
0219 void            console_init(void);
0220 void            cprintf(char*, ...);
0221 void            console_intr(int(*)(void));
0222 void            panic(char*) __attribute__((noreturn));
0223 void            printstack(void);
0224 
0225 // exec.c
0226 int             exec(char*, char**);
0227 
0228 // file.c
0229 struct file*    filealloc(void);
0230 void            fileclose(struct file*);
0231 struct file*    filedup(struct file*);
0232 void            fileinit(void);
0233 int             fileread(struct file*, char*, int n);
0234 int             filestat(struct file*, struct stat*);
0235 int             filewrite(struct file*, char*, int n);
0236 
0237 // fs.c
0238 int             dirlink(struct inode*, char*, uint);
0239 struct inode*   dirlookup(struct inode*, char*, uint*);
0240 struct inode*   ialloc(uint, short);
0241 struct inode*   idup(struct inode*);
0242 void            iinit(void);
0243 void            ilock(struct inode*);
0244 void            iput(struct inode*);
0245 void            iunlock(struct inode*);
0246 void            iunlockput(struct inode*);
0247 void            iupdate(struct inode*);
0248 int             namecmp(const char*, const char*);
0249 struct inode*   namei(char*);
0250 struct inode*   nameiparent(char*, char*);
0251 int             readi(struct inode*, char*, uint, uint);
0252 void            stati(struct inode*, struct stat*);
0253 int             writei(struct inode*, char*, uint, uint);
0254 
0255 // ide.c
0256 void            ide_init(void);
0257 void            ide_intr(void);
0258 void            ide_rw(struct buf *);
0259 
0260 // ioapic.c
0261 void            ioapic_enable(int irq, int cpu);
0262 extern uchar    ioapic_id;
0263 void            ioapic_init(void);
0264 
0265 // kalloc.c
0266 char*           kalloc(int);
0267 void            kfree(char*, int);
0268 void*           kmalloc(int);
0269 void            kmfree(void*, int);
0270 void            kinit(void);
0271 
0272 // kbd.c
0273 void            kbd_intr(void);
0274 
0275 // lapic.c
0276 int             cpu(void);
0277 extern volatile uint*    lapic;
0278 void            lapic_disableintr(void);
0279 void            lapic_enableintr(void);
0280 void            lapic_eoi(void);
0281 void            lapic_init(int);
0282 void            lapic_startap(uchar, uint);
0283 void            lapic_timerinit(void);
0284 void            lapic_timerintr(void);
0285 
0286 // mp.c
0287 extern int      ismp;
0288 int             mp_bcpu(void);
0289 void            mp_init(void);
0290 void            mp_startthem(void);
0291 
0292 // picirq.c
0293 void            pic_enable(int);
0294 void            pic_init(void);
0295 
0296 
0297 
0298 
0299 
0300 // pipe.c
0301 int             pipealloc(struct file**, struct file**);
0302 void            pipeclose(struct pipe*, int);
0303 int             piperead(struct pipe*, char*, int);
0304 int             pipewrite(struct pipe*, char*, int);
0305 
0306 // proc.c
0307 struct proc*    copyproc(struct proc*);
0308 struct proc*    allocproc(void);
0309 void            exit(void);
0310 int             growproc(int);
0311 int             kill(int);
0312 void            pinit(void);
0313 void            procdump(void);
0314 void            scheduler(void) __attribute__((noreturn));
0315 void            setupsegs(struct proc*);
0316 void            sleep(void*, struct spinlock*);
0317 int             msleep_spin(void*, struct spinlock*, int);
0318 void            userinit(void);
0319 int             wait(void);
0320 void            wakeup(void*);
0321 void            wakeup_one(void*);
0322 void            yield(void);
0323 
0324 // swtch.S
0325 void            swtch(struct context*, struct context*);
0326 
0327 // spinlock.c
0328 void            acquire(struct spinlock*);
0329 void            getcallerpcs(void*, uint*);
0330 int             holding(struct spinlock*);
0331 void            initlock(struct spinlock*, char*);
0332 void            release(struct spinlock*);
0333 
0334 // string.c
0335 int             memcmp(const void*, const void*, uint);
0336 void*           memmove(void*, const void*, uint);
0337 void*           memset(void*, int, uint);
0338 char*           safestrcpy(char*, const char*, int);
0339 int             strlen(const char*);
0340 int             strncmp(const char*, const char*, uint);
0341 char*           strncpy(char*, const char*, int);
0342 void*           memcpy(void *dst, const void *src, uint n);
0343 
0344 // syscall.c
0345 int             argint(int, int*);
0346 int             argptr(int, char**, int);
0347 int             argstr(int, char**);
0348 int             fetchint(struct proc*, uint, int*);
0349 int             fetchstr(struct proc*, uint, char**);
0350 void            syscall(void);
0351 
0352 // timer.c
0353 void            timer_init(void);
0354 int             millitime(void);
0355 
0356 // trap.c
0357 void            idtinit(void);
0358 extern int      ticks;
0359 void            tvinit(void);
0360 extern struct spinlock tickslock;
0361 
0362 // number of elements in fixed-size array
0363 #define NELEM(x) (sizeof(x)/sizeof((x)[0]))
0364 
0365 #ifndef NULL
0366 #define NULL    0
0367 #endif
0368 
0369 #endif // XV6_DEFS_H_
0370 
0371 
0372 
0373 
0374 
0375 
0376 
0377 
0378 
0379 
0380 
0381 
0382 
0383 
0384 
0385 
0386 
0387 
0388 
0389 
0390 
0391 
0392 
0393 
0394 
0395 
0396 
0397 
0398 
0399 
