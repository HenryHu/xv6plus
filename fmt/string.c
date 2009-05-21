6300 #include "types.h"
6301 
6302 void*
6303 memcpy(void *dst, const void *src, uint n)
6304 {
6305     const uchar *s1;
6306     uchar *s2;
6307 
6308     s1 = src;
6309     s2 = dst;
6310     while(n-- > 0){
6311         *s2 = *s1;
6312         s1++;
6313         s2++;
6314     }
6315 
6316     return 0;
6317 }
6318 
6319 void*
6320 memset(void *dst, int c, uint n)
6321 {
6322   char *d;
6323 
6324   d = (char*)dst;
6325   while(n-- > 0)
6326     *d++ = c;
6327 
6328   return dst;
6329 }
6330 
6331 int
6332 memcmp(const void *v1, const void *v2, uint n)
6333 {
6334   const uchar *s1, *s2;
6335 
6336   s1 = v1;
6337   s2 = v2;
6338   while(n-- > 0){
6339     if(*s1 != *s2)
6340       return *s1 - *s2;
6341     s1++, s2++;
6342   }
6343 
6344   return 0;
6345 }
6346 
6347 
6348 
6349 
6350 void*
6351 memmove(void *dst, const void *src, uint n)
6352 {
6353   const char *s;
6354   char *d;
6355 
6356   s = src;
6357   d = dst;
6358   if(s < d && s + n > d){
6359     s += n;
6360     d += n;
6361     while(n-- > 0)
6362       *--d = *--s;
6363   } else
6364     while(n-- > 0)
6365       *d++ = *s++;
6366 
6367   return dst;
6368 }
6369 
6370 int
6371 strncmp(const char *p, const char *q, uint n)
6372 {
6373   while(n > 0 && *p && *p == *q)
6374     n--, p++, q++;
6375   if(n == 0)
6376     return 0;
6377   return (uchar)*p - (uchar)*q;
6378 }
6379 
6380 char*
6381 strncpy(char *s, const char *t, int n)
6382 {
6383   char *os;
6384 
6385   os = s;
6386   while(n-- > 0 && (*s++ = *t++) != 0)
6387     ;
6388   while(n-- > 0)
6389     *s++ = 0;
6390   return os;
6391 }
6392 
6393 
6394 
6395 
6396 
6397 
6398 
6399 
6400 // Like strncpy but guaranteed to NUL-terminate.
6401 char*
6402 safestrcpy(char *s, const char *t, int n)
6403 {
6404   char *os;
6405 
6406   os = s;
6407   if(n <= 0)
6408     return os;
6409   while(--n > 0 && (*s++ = *t++) != 0)
6410     ;
6411   *s = 0;
6412   return os;
6413 }
6414 
6415 int
6416 strlen(const char *s)
6417 {
6418   int n;
6419 
6420   for(n = 0; s[n]; n++)
6421     ;
6422   return n;
6423 }
6424 
6425 
6426 
6427 
6428 
6429 
6430 
6431 
6432 
6433 
6434 
6435 
6436 
6437 
6438 
6439 
6440 
6441 
6442 
6443 
6444 
6445 
6446 
6447 
6448 
6449 
