4300 // in-core file system types
4301 
4302 struct inode {
4303   uint dev;           // Device number
4304   uint inum;          // Inode number
4305   int ref;            // Reference count
4306   int flags;          // I_BUSY, I_VALID
4307 
4308   short type;         // copy of disk inode
4309   short major;
4310   short minor;
4311   short nlink;
4312   uint size;
4313   uint addrs[NADDRS];
4314 };
4315 
4316 #define I_BUSY 0x1
4317 #define I_VALID 0x2
4318 
4319 
4320 
4321 
4322 
4323 
4324 
4325 
4326 
4327 
4328 
4329 
4330 
4331 
4332 
4333 
4334 
4335 
4336 
4337 
4338 
4339 
4340 
4341 
4342 
4343 
4344 
4345 
4346 
4347 
4348 
4349 
