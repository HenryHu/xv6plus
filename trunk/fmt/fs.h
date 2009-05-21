4200 // On-disk file system format.
4201 // Both the kernel and user programs use this header file.
4202 
4203 // Block 0 is unused.
4204 // Block 1 is super block.
4205 // Inodes start at block 2.
4206 
4207 #define BSIZE 512  // block size
4208 
4209 // File system super block
4210 struct superblock {
4211   uint size;         // Size of file system image (blocks)
4212   uint nblocks;      // Number of data blocks
4213   uint ninodes;      // Number of inodes.
4214 };
4215 
4216 #define NADDRS (NDIRECT+1)
4217 #define NDIRECT 12
4218 #define INDIRECT 12
4219 #define NINDIRECT (BSIZE / sizeof(uint))
4220 #define MAXFILE (NDIRECT  + NINDIRECT)
4221 
4222 // On-disk inode structure
4223 struct dinode {
4224   short type;           // File type
4225   short major;          // Major device number (T_DEV only)
4226   short minor;          // Minor device number (T_DEV only)
4227   short nlink;          // Number of links to inode in file system
4228   uint size;            // Size of file (bytes)
4229   uint addrs[NADDRS];   // Data block addresses
4230 };
4231 
4232 #define T_DIR  1   // Directory
4233 #define T_FILE 2   // File
4234 #define T_DEV  3   // Special device
4235 
4236 // Inodes per block.
4237 #define IPB           (BSIZE / sizeof(struct dinode))
4238 
4239 // Block containing inode i
4240 #define IBLOCK(i)     ((i) / IPB + 2)
4241 
4242 // Bitmap bits per block
4243 #define BPB           (BSIZE*8)
4244 
4245 // Block containing bit for block b
4246 #define BBLOCK(b, ninodes) (b/BPB + (ninodes)/IPB + 3)
4247 
4248 // Directory is a file containing a sequence of dirent structures.
4249 #define DIRSIZ 14
4250 struct dirent {
4251   ushort inum;
4252   char name[DIRSIZ];
4253 };
4254 
4255 
4256 
4257 
4258 
4259 
4260 
4261 
4262 
4263 
4264 
4265 
4266 
4267 
4268 
4269 
4270 
4271 
4272 
4273 
4274 
4275 
4276 
4277 
4278 
4279 
4280 
4281 
4282 
4283 
4284 
4285 
4286 
4287 
4288 
4289 
4290 
4291 
4292 
4293 
4294 
4295 
4296 
4297 
4298 
4299 
