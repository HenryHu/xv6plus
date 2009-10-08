// Console input and output.
// Input is from the keyboard only.
// Output is written to the screen and the printer port.

#include "types.h"
#include "defs.h"
#include "param.h"
#include "traps.h"
#include "spinlock.h"
#include "dev.h"
#include "mmu.h"
#include "proc.h"
#include "x86.h"
#include "thread.h"
#include "lwip/sockets.h"

#define CRTPORT 0x3d4
#define LPTPORT 0x378
#define BACKSPACE 0x100

static ushort *crt = (ushort*)0xb8000;  // CGA memory

static struct spinlock console_lock;
int panicked = 0;
int use_console_lock = 0;

// Copy console output to parallel port, which you can tell
// .bochsrc to copy to the stdout:
//   parport1: enabled=1, file="/dev/stdout"
static void
lpt_putc(int c)
{
  int i;

  for(i = 0; !(inb(LPTPORT+1) & 0x80) && i < 12800; i++)
    ;
  if(c == BACKSPACE)
    c = '\b';
  outb(LPTPORT+0, c);
  outb(LPTPORT+2, 0x08|0x04|0x01);
  outb(LPTPORT+2, 0x08);
}

static void
cga_putc(int c)
{
  int pos;
  
  // Cursor position: col + 80*row.
  outb(CRTPORT, 14);
  pos = inb(CRTPORT+1) << 8;
  outb(CRTPORT, 15);
  pos |= inb(CRTPORT+1);

  if(c == '\n')
    pos += 80 - pos%80;
  else if(c == BACKSPACE){
    if(pos > 0)
      crt[--pos] = ' ' | 0x0700;
  } else
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
  
  if((pos/80) >= 24){  // Scroll up.
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
    pos -= 80;
    memset(crt + pos, 0, sizeof(crt[0])*80);
  }
  
  outb(CRTPORT, 14);
  outb(CRTPORT+1, pos>>8);
  outb(CRTPORT, 15);
  outb(CRTPORT+1, pos);
  crt[pos] = ' ' | 0x0700;
}

void
cons_putc(int c)
{
  if(panicked){
    cli();
    for(;;)
      ;
  }

  lpt_putc(c);
  cga_putc(c);
}

void
printintlen(int xx, int base, int sgn, int len, char fill)
{
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i = 0, neg = 0, j = 0;
  uint x;

  if(sgn && xx < 0){
    neg = 1;
    x = 0 - xx;
  } else {
    x = xx;
  }

  do{
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  if (i < len)
  {
      if (neg)
      {
          cons_putc('-');
          i--;
      }
      j = len - i;
      while (j-- > 0)
          cons_putc(fill);
  }
  while(--i >= 0)
    cons_putc(buf[i]);
}

void
printint(int xx, int base, int sgn)
{
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i = 0, neg = 0;
  uint x;

  if(sgn && xx < 0){
    neg = 1;
    x = 0 - xx;
  } else {
    x = xx;
  }

  do{
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    cons_putc(buf[i]);
}

enum fmt_types {
    CHAR,
    SHORT,
    LONG,
    LONGLONG,
};

// Print to the console. only understands %d, %x, %p, %s.
void
cprintf(char *fmt, ...)
{
  int i, c, state, locking, len = 0;
  uint *argp;
  char *s, last, fill;
  enum fmt_types type;

  locking = use_console_lock;
  if(locking)
    acquire(&console_lock);

  argp = (uint*)(void*)&fmt + 1;
  state = 0;
  c = 0;
  fill = ' ';
  len = -1;
  for(i = 0; fmt[i]; i++){
    last = c;
    c = fmt[i] & 0xff;
    switch(state){
    case 0:
      if(c == '%')
        state = '%';
      else
        cons_putc(c);
      break;
    
    case '%':
      switch(c){
      case 'l':
        if (last == 'l')
        {
            // ll: long long
            type = LONGLONG;
        } else {
            type = LONG;
        }
        break;
      case 'h':
        if (last == 'h')
        {
            // hh: char
            type = CHAR;
        } else {
            type = SHORT;
        }
        break;
      case 'c':
        cons_putc(*argp++);
        len = -1;
        state = 0;
        break;
      case 'd':
      case 'i':
        if (len != -1)
            printintlen(*argp++, 10, 1, len, fill);
        else
            printint(*argp++, 10, 1);
        fill = ' ';
        len = -1;
        state = 0;
        break;
      case 'u':
        if (len != -1)
            printintlen(*argp++, 10, 0, len, fill);
        else
            printint(*argp++, 10, 0);
        fill = ' ';
        len = -1;
        state = 0;
        break;
      case 'x':
      case 'p':
        if (len != -1)
            printintlen(*argp++, 16, 0, len, fill);
        else
            printint(*argp++, 16, 0);
        fill = ' ';
        len = -1;
        state = 0;
        break;
      case 's':
        s = (char*)*argp++;
        if(s == 0)
          s = "(null)";
        for(; *s; s++)
          cons_putc(*s);
        len = -1;
        state = 0;
        break;
      case '%':
        cons_putc('%');
        state = 0;
        break;
      case '0':
        if (len == -1)
        {
            len = 0;
            fill = '0';
        } else {
            len = len * 10;
        }
        break;
      case '1':
      case '2':
      case '3':
      case '4':
      case '5':
      case '6':
      case '7':
      case '8':
      case '9':
        if (len == -1)
            len = c - '0';
        else
            len = len * 10 + c - '0';
        break;
      default:
        // Print unknown % sequence to draw attention.
        cons_putc('%');
        cons_putc(c);
        break;
      }
      break;
    }
  }

  if(locking)
    release(&console_lock);
}

int
console_write(struct inode *ip, char *buf, int n)
{
  int i;

  iunlock(ip);
  acquire(&console_lock);
  for(i = 0; i < n; i++)
    cons_putc(buf[i] & 0xff);
  release(&console_lock);
  ilock(ip);

  return n;
}

#define INPUT_BUF 128
struct {
  struct spinlock lock;
  char buf[INPUT_BUF];
  int r;  // Read index
  int w;  // Write index
  int e;  // Edit index
} input;

#define C(x)  ((x)-'@')  // Control-x

void
console_intr(int (*getc)(void))
{
  int c;

  acquire(&input.lock);
  while((c = getc()) >= 0){
    switch(c){
    case C('P'):  // Process listing.
      procdump();
      break;
    case C('U'):  // Kill line.
      while(input.e > input.w &&
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
        input.e--;
        cons_putc(BACKSPACE);
      }
      break;
    case C('H'):  // Backspace
      if(input.e > input.w){
        input.e--;
        cons_putc(BACKSPACE);
      }
      break;
    default:
      if(c != 0 && input.e < input.r+INPUT_BUF){
        input.buf[input.e++ % INPUT_BUF] = c;
        cons_putc(c);
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
          input.w = input.e;
          wakeup(&input.r);
        }
      }
      break;
    }
  }
  release(&input.lock);
}

void
thread_stub(void * arg)
{
/*    static int id = 0;
    id++;
//    int myid = id;
    cprintf("thread_stub started! arg: %d\n", arg);
    int i;
    for (i=0; i<100000000; i++)
    {
        if (i % 100000 == 0)
        cprintf("%d:", myid);
    }*/
  static int in = 0;
  if (in)
      return;
  in = 1;
  unsigned char data[512];
  int s;
  int len;
  s = lwip_socket(PF_INET, SOCK_STREAM, 0);
  struct sockaddr_in sa;
  sa.sin_family = AF_INET;
  sa.sin_port = htons(80);
  sa.sin_addr.s_addr = inet_addr("192.168.1.1");
  len = 1;
  lwip_setsockopt(s, SOL_SOCKET, SO_REUSEPORT, &len, sizeof(int));
  lwip_bind(s, &sa, sizeof(sa));
  int addrlen = sizeof(sa);
//  len = lwip_recvfrom(s, data, sizeof(data), 0, &sa, &addrlen);
//  lwip_sendto(s, data, len, 0, &sa, addrlen);
  int client;
  lwip_listen(s, 1);
  while ((client = lwip_accept(s, &sa, &addrlen)) > 0)
  {
      do {
        len = lwip_read(client, data, sizeof(data));
//        cprintf("received %d bytes\n", len);
        lwip_send(client, data, len, 0);
        if (data[0] == '!')
            len = -1;
      } while (len > 0);
      lwip_close(client);
  }
  lwip_close(s);
  in = 0;
}


int
console_read(struct inode *ip, char *dst, int n)
{
  uint target;
  int c;
  int ret;
//  unsigned char data[100];
  int mark;

//  kproc_start(thread_stub, 0, 0, 0, "[stub thread]");
//  for (c=0; c<10; c++)
//      data[c] = 0xda;
  iunlock(ip);
  target = n;
  acquire(&input.lock);
  while(n > 0){
    while(input.r == input.w){
      if(cp->killed){
        release(&input.lock);
        ilock(ip);
        return -1;
      }
      mark = 0;
      sleep(&input.r, &input.lock);
/*      do {
        ret = msleep_spin(&input.r, &input.lock, 1000);
       if (ret)
        {*/
//            if ((mark = lwip_recv(s, data, 
//            sizeof(data), MSG_DONTWAIT)) > 0)
//                cprintf("received from 192.168.1.1:80: %d\n", mark);
/*            if (mark == 0)
            {
                for ( ; mark < 64; mark ++)
                    e100_send(data, sizeof(data));
            }
            int len = e100_receive(data, sizeof(data));
            cprintf("received: %d bytes\n", len);
            int i;
            for (i=0; i<len; i++)
            {
                cprintf("%02x ", data[i]);
                if ((i+1) % 10 == 0)
                    cprintf("\n");
            }
            cprintf("\n");*/
//            kproc_start(thread_stub, (void *)100, 0, 0);
//            cprintf("XXX faster!!\n");
/*        }
      } while (ret);*/
    }
    c = input.buf[input.r++ % INPUT_BUF];
    if(c == C('D')){  // EOF
      if(n < target){
        // Save ^D for next time, to make sure
        // caller gets a 0-byte result.
        input.r--;
      }
      break;
    }
    *dst++ = c;
    --n;
    if(c == '\n')
      break;
  }
  release(&input.lock);
  ilock(ip);

  return target - n;
}

void
console_init(void)
{
  initlock(&console_lock, "console");
  initlock(&input.lock, "console input");

  devsw[CONSOLE].write = console_write;
  devsw[CONSOLE].read = console_read;
  //use_console_lock = 1;

  reg_irq_handler(IRQ_KBD, kbd_intr);
  pic_enable(IRQ_KBD);
  ioapic_enable(IRQ_KBD, 0);
}

void
printstack()
{
  int i;
  uint ebp;
  uint pcs[10];
  cprintf("Stack trace:\n");
  asm("movl %%ebp, %0" : "=r"(ebp) : );
  getcallerpcs((void*)(ebp+8), pcs);
  for(i=0; i<10; i++)
    cprintf("0x%08x ", pcs[i]);
  cprintf("\n");
}


void
panic(char *s)
{
  int i;
  uint pcs[10];
  
  __asm __volatile("cli");
  use_console_lock = 0;
  cprintf("panic (%d): ", cpu());
  cprintf(s, 0);
  cprintf("\n", 0);
  getcallerpcs(&s, pcs);
  for(i=0; i<10; i++)
    cprintf(" %p", pcs[i]);
  panicked = 1; // freeze other CPU
  for(;;)
    ;
}

