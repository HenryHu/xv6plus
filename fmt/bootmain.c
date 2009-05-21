1150 // Boot loader.
1151 //
1152 // The BIOS loads boot sector (bootasm.S) from sector 0 of the disk
1153 // into memory and executes it.  The boot sector puts the processor
1154 // in 32-bit mode and calls bootmain below, which loads an ELF kernel
1155 // image from the disk starting at sector 1 and then jumps to the
1156 // kernel entry routine.
1157 
1158 #include "types.h"
1159 #include "elf.h"
1160 #include "x86.h"
1161 
1162 #define SECTSIZE  512
1163 
1164 void readseg(uint, uint, uint);
1165 
1166 void
1167 bootmain(void)
1168 {
1169   struct elfhdr *elf;
1170   struct proghdr *ph, *eph;
1171   void (*entry)(void);
1172 
1173   elf = (struct elfhdr*)0x10000;  // scratch space
1174 
1175   // Read 1st page off disk
1176   readseg((uint)elf, SECTSIZE*8, 0);
1177 
1178   // Is this an ELF executable?
1179   if(elf->magic != ELF_MAGIC)
1180     goto bad;
1181 
1182   // Load each program segment (ignores ph flags).
1183   ph = (struct proghdr*)((uchar*)elf + elf->phoff);
1184   eph = ph + elf->phnum;
1185   for(; ph < eph; ph++)
1186     readseg(ph->va, ph->memsz, ph->offset);
1187 
1188   // Call the entry point from the ELF header.
1189   // Does not return!
1190   entry = (void(*)(void))(elf->entry & 0xFFFFFF);
1191   entry();
1192 
1193 bad:
1194   outw(0x8A00, 0x8A00);
1195   outw(0x8A00, 0x8E00);
1196   for(;;)
1197     ;
1198 }
1199 
1200 void
1201 waitdisk(void)
1202 {
1203   // Wait for disk ready.
1204   while((inb(0x1F7) & 0xC0) != 0x40)
1205     ;
1206 }
1207 
1208 // Read a single sector at offset into dst.
1209 void
1210 readsect(void *dst, uint offset)
1211 {
1212   // Issue command.
1213   waitdisk();
1214   outb(0x1F2, 1);   // count = 1
1215   outb(0x1F3, offset);
1216   outb(0x1F4, offset >> 8);
1217   outb(0x1F5, offset >> 16);
1218   outb(0x1F6, (offset >> 24) | 0xE0);
1219   outb(0x1F7, 0x20);  // cmd 0x20 - read sectors
1220 
1221   // Read data.
1222   waitdisk();
1223   insl(0x1F0, dst, SECTSIZE/4);
1224 }
1225 
1226 // Read 'count' bytes at 'offset' from kernel into virtual address 'va'.
1227 // Might copy more than asked.
1228 void
1229 readseg(uint va, uint count, uint offset)
1230 {
1231   uint eva;
1232 
1233   va &= 0xFFFFFF;
1234   eva = va + count;
1235 
1236   // Round down to sector boundary.
1237   va &= ~(SECTSIZE - 1);
1238 
1239   // Translate from bytes to sectors; kernel starts at sector 1.
1240   offset = (offset / SECTSIZE) + 1;
1241 
1242   // If this is too slow, we could read lots of sectors at a time.
1243   // We'd write more to memory than asked, but it doesn't matter --
1244   // we load in increasing order.
1245   for(; va < eva; va += SECTSIZE, offset++)
1246     readsect((uchar*)va, offset);
1247 }
1248 
1249 
