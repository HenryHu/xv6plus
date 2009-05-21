6000 #include "types.h"
6001 #include "param.h"
6002 #include "mmu.h"
6003 #include "proc.h"
6004 #include "defs.h"
6005 #include "x86.h"
6006 #include "elf.h"
6007 
6008 int
6009 exec(char *path, char **argv)
6010 {
6011   char *mem, *s, *last;
6012   int i, argc, arglen, len, off;
6013   uint sz, sp, argp;
6014   struct elfhdr elf;
6015   struct inode *ip;
6016   struct proghdr ph;
6017 
6018   if((ip = namei(path)) == 0)
6019     return -1;
6020 //  cprintf("XXX exec\n");
6021   ilock(ip);
6022 
6023   // Compute memory size of new process.
6024   mem = 0;
6025   sz = 0;
6026 
6027   // Program segments.
6028   if(readi(ip, (char*)&elf, 0, sizeof(elf)) < sizeof(elf))
6029     goto bad;
6030   if(elf.magic != ELF_MAGIC)
6031     goto bad;
6032   for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
6033     if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
6034       goto bad;
6035     if(ph.type != ELF_PROG_LOAD)
6036       continue;
6037     if(ph.memsz < ph.filesz)
6038       goto bad;
6039     sz += ph.memsz;
6040   }
6041 
6042   // Arguments.
6043   arglen = 0;
6044   for(argc=0; argv[argc]; argc++)
6045     arglen += strlen(argv[argc]) + 1;
6046   arglen = (arglen+3) & ~3;
6047   sz += arglen + 4*(argc+1);
6048 
6049 
6050   // Stack.
6051   sz += PAGE;
6052 
6053   // Allocate program memory.
6054   sz = (sz+PAGE-1) & ~(PAGE-1);
6055   mem = kalloc(sz);
6056   if(mem == 0)
6057     goto bad;
6058   memset(mem, 0, sz);
6059 
6060   // Load program into memory.
6061   for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
6062     if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
6063       goto bad;
6064     if(ph.type != ELF_PROG_LOAD)
6065       continue;
6066     if(ph.va + ph.memsz > sz)
6067       goto bad;
6068     if(readi(ip, mem + ph.va, ph.offset, ph.filesz) != ph.filesz)
6069       goto bad;
6070     memset(mem + ph.va + ph.filesz, 0, ph.memsz - ph.filesz);
6071   }
6072   iunlockput(ip);
6073 
6074   // Initialize stack.
6075   sp = sz;
6076   argp = sz - arglen - 4*(argc+1);
6077 
6078   // Copy argv strings and pointers to stack.
6079   *(uint*)(mem+argp + 4*argc) = 0;  // argv[argc]
6080   for(i=argc-1; i>=0; i--){
6081     len = strlen(argv[i]) + 1;
6082     sp -= len;
6083     memmove(mem+sp, argv[i], len);
6084     *(uint*)(mem+argp + 4*i) = sp;  // argv[i]
6085   }
6086 
6087   // Stack frame for main(argc, argv), below arguments.
6088   sp = argp;
6089   sp -= 4;
6090   *(uint*)(mem+sp) = argp;
6091   sp -= 4;
6092   *(uint*)(mem+sp) = argc;
6093   sp -= 4;
6094   *(uint*)(mem+sp) = 0xffffffff;   // fake return pc
6095 
6096 
6097 
6098 
6099 
6100   // Save program name for debugging.
6101   for(last=s=path; *s; s++)
6102     if(*s == '/')
6103       last = s+1;
6104   safestrcpy(cp->name, last, sizeof(cp->name));
6105 
6106   // Commit to the new image.
6107   kfree(cp->mem, cp->sz);
6108   cp->mem = mem;
6109   cp->sz = sz;
6110   cp->tf->eip = elf.entry;  // main
6111   cp->tf->esp = sp;
6112   setupsegs(cp);
6113   return 0;
6114 
6115  bad:
6116   if(mem)
6117     kfree(mem, sz);
6118   iunlockput(ip);
6119   return -1;
6120 }
6121 
6122 
6123 
6124 
6125 
6126 
6127 
6128 
6129 
6130 
6131 
6132 
6133 
6134 
6135 
6136 
6137 
6138 
6139 
6140 
6141 
6142 
6143 
6144 
6145 
6146 
6147 
6148 
6149 
