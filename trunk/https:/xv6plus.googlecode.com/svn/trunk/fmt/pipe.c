6150 #include "types.h"
6151 #include "defs.h"
6152 #include "param.h"
6153 #include "mmu.h"
6154 #include "proc.h"
6155 #include "file.h"
6156 #include "spinlock.h"
6157 
6158 #define PIPESIZE 512
6159 
6160 struct pipe {
6161   int readopen;   // read fd is still open
6162   int writeopen;  // write fd is still open
6163   int writep;     // next index to write
6164   int readp;      // next index to read
6165   struct spinlock lock;
6166   char data[PIPESIZE];
6167 };
6168 
6169 int
6170 pipealloc(struct file **f0, struct file **f1)
6171 {
6172   struct pipe *p;
6173 
6174   p = 0;
6175   *f0 = *f1 = 0;
6176   if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
6177     goto bad;
6178   if((p = (struct pipe*)kalloc(PAGE)) == 0)
6179     goto bad;
6180   p->readopen = 1;
6181   p->writeopen = 1;
6182   p->writep = 0;
6183   p->readp = 0;
6184   initlock(&p->lock, "pipe");
6185   (*f0)->type = FD_PIPE;
6186   (*f0)->readable = 1;
6187   (*f0)->writable = 0;
6188   (*f0)->pipe = p;
6189   (*f1)->type = FD_PIPE;
6190   (*f1)->readable = 0;
6191   (*f1)->writable = 1;
6192   (*f1)->pipe = p;
6193   return 0;
6194 
6195  bad:
6196   if(p)
6197     kfree((char*)p, PAGE);
6198   if(*f0){
6199     (*f0)->type = FD_NONE;
6200     fileclose(*f0);
6201   }
6202   if(*f1){
6203     (*f1)->type = FD_NONE;
6204     fileclose(*f1);
6205   }
6206   return -1;
6207 }
6208 
6209 void
6210 pipeclose(struct pipe *p, int writable)
6211 {
6212   acquire(&p->lock);
6213   if(writable){
6214     p->writeopen = 0;
6215     wakeup(&p->readp);
6216   } else {
6217     p->readopen = 0;
6218     wakeup(&p->writep);
6219   }
6220   release(&p->lock);
6221 
6222   if(p->readopen == 0 && p->writeopen == 0)
6223     kfree((char*)p, PAGE);
6224 }
6225 
6226 int
6227 pipewrite(struct pipe *p, char *addr, int n)
6228 {
6229   int i;
6230 
6231   acquire(&p->lock);
6232   for(i = 0; i < n; i++){
6233     while(((p->writep + 1) % PIPESIZE) == p->readp){
6234       if(p->readopen == 0 || cp->killed){
6235         release(&p->lock);
6236         return -1;
6237       }
6238       wakeup(&p->readp);
6239       sleep(&p->writep, &p->lock);
6240     }
6241     p->data[p->writep] = addr[i];
6242     p->writep = (p->writep + 1) % PIPESIZE;
6243   }
6244   wakeup(&p->readp);
6245   release(&p->lock);
6246   return i;
6247 }
6248 
6249 
6250 int
6251 piperead(struct pipe *p, char *addr, int n)
6252 {
6253   int i;
6254 
6255   acquire(&p->lock);
6256   while(p->readp == p->writep && p->writeopen){
6257     if(cp->killed){
6258       release(&p->lock);
6259       return -1;
6260     }
6261     sleep(&p->readp, &p->lock);
6262   }
6263   for(i = 0; i < n; i++){
6264     if(p->readp == p->writep)
6265       break;
6266     addr[i] = p->data[p->readp];
6267     p->readp = (p->readp + 1) % PIPESIZE;
6268   }
6269   wakeup(&p->writep);
6270   release(&p->lock);
6271   return i;
6272 }
6273 
6274 
6275 
6276 
6277 
6278 
6279 
6280 
6281 
6282 
6283 
6284 
6285 
6286 
6287 
6288 
6289 
6290 
6291 
6292 
6293 
6294 
6295 
6296 
6297 
6298 
6299 
