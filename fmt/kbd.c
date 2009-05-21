7300 #include "types.h"
7301 #include "x86.h"
7302 #include "defs.h"
7303 #include "kbd.h"
7304 
7305 int
7306 kbd_getc(void)
7307 {
7308   static uint shift;
7309   static uchar *charcode[4] = {
7310     normalmap, shiftmap, ctlmap, ctlmap
7311   };
7312   uint st, data, c;
7313 
7314   st = inb(KBSTATP);
7315   if((st & KBS_DIB) == 0)
7316     return -1;
7317   data = inb(KBDATAP);
7318 
7319   if(data == 0xE0){
7320     shift |= E0ESC;
7321     return 0;
7322   } else if(data & 0x80){
7323     // Key released
7324     data = (shift & E0ESC ? data : data & 0x7F);
7325     shift &= ~(shiftcode[data] | E0ESC);
7326     return 0;
7327   } else if(shift & E0ESC){
7328     // Last character was an E0 escape; or with 0x80
7329     data |= 0x80;
7330     shift &= ~E0ESC;
7331   }
7332 
7333   shift |= shiftcode[data];
7334   shift ^= togglecode[data];
7335   c = charcode[shift & (CTL | SHIFT)][data];
7336   if(shift & CAPSLOCK){
7337     if('a' <= c && c <= 'z')
7338       c += 'A' - 'a';
7339     else if('A' <= c && c <= 'Z')
7340       c += 'a' - 'A';
7341   }
7342   return c;
7343 }
7344 
7345 void
7346 kbd_intr(void)
7347 {
7348   console_intr(kbd_getc);
7349 }
