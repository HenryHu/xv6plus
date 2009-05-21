2700 // Physical memory allocator, intended to allocate
2701 // memory for user processes. Allocates in 4096-byte "pages".
2702 // Free list is kept sorted and combines adjacent pages into
2703 // long runs, to make it easier to allocate big segments.
2704 // One reason the page size is 4k is that the x86 segment size
2705 // granularity is 4k.
2706 
2707 #include "types.h"
2708 #include "defs.h"
2709 #include "param.h"
2710 #include "spinlock.h"
2711 
2712 //#define MEM_DEBUG 1
2713 struct spinlock kalloc_lock;
2714 
2715 struct run {
2716   struct run *next;
2717   int len; // bytes
2718 };
2719 struct run *freelist;
2720 
2721 // Initialize free list of physical pages.
2722 // This code cheats by just considering one megabyte of
2723 // pages after _end.  Real systems would determine the
2724 // amount of memory available in the system and use it all.
2725 void
2726 kinit(void)
2727 {
2728   extern int end;
2729   uint mem;
2730   char *start;
2731 
2732   initlock(&kalloc_lock, "kalloc");
2733   start = (char*) &end;
2734   start = (char*) (((uint)start + PAGE) & ~(PAGE-1));
2735   mem = 256; // assume computer has 256 pages of RAM
2736   cprintf("mem = %d\n", mem * PAGE);
2737   kfree(start, mem * PAGE);
2738 }
2739 
2740 
2741 
2742 
2743 
2744 
2745 
2746 
2747 
2748 
2749 
2750 // Free the len bytes of memory pointed at by v,
2751 // which normally should have been returned by a
2752 // call to kalloc(len).  (The exception is when
2753 // initializing the allocator; see kinit above.)
2754 void
2755 kfree(char *v, int len)
2756 {
2757   struct run *r, *rend, **rp, *p, *pend;
2758 
2759 #ifdef MEM_DEBUG
2760   cprintf("kfree: %d pages\n", len / PAGE);
2761 #endif
2762   if(len <= 0 || len % PAGE)
2763   {
2764     cprintf("kfree: length = %d\n", len);
2765     panic("kfree");
2766   }
2767 
2768   // Fill with junk to catch dangling refs.
2769   memset(v, 1, len);
2770 
2771   acquire(&kalloc_lock);
2772   p = (struct run*)v;
2773   pend = (struct run*)(v + len);
2774   for(rp=&freelist; (r=*rp) != 0 && r <= pend; rp=&r->next){
2775     rend = (struct run*)((char*)r + r->len);
2776     if(r <= p && p < rend)
2777       panic("freeing free page");
2778     if(pend == r){  // p next to r: replace r with p
2779       p->len = len + r->len;
2780       p->next = r->next;
2781       *rp = p;
2782       goto out;
2783     }
2784     if(rend == p){  // r next to p: replace p with r
2785       r->len += len;
2786       if(r->next && r->next == pend){  // r now next to r->next?
2787         r->len += r->next->len;
2788         r->next = r->next->next;
2789       }
2790       goto out;
2791     }
2792   }
2793   // Insert p before r in list.
2794   p->len = len;
2795   p->next = r;
2796   *rp = p;
2797 
2798 
2799 
2800  out:
2801   release(&kalloc_lock);
2802 }
2803 
2804 // Allocate n bytes of physical memory.
2805 // Returns a kernel-segment pointer.
2806 // Returns 0 if the memory cannot be allocated.
2807 char*
2808 kalloc(int n)
2809 {
2810   char *p;
2811   struct run *r, **rp;
2812 
2813 #ifdef MEM_DEBUG
2814   cprintf("kalloc: %d pages\n", n / PAGE);
2815   printstack();
2816 #endif
2817   if(n % PAGE || n <= 0)
2818     panic("kalloc");
2819 
2820   acquire(&kalloc_lock);
2821   for(rp=&freelist; (r=*rp) != 0; rp=&r->next){
2822     if(r->len == n){
2823       *rp = r->next;
2824       release(&kalloc_lock);
2825       return (char*)r;
2826     }
2827     if(r->len > n){
2828       r->len -= n;
2829       p = (char*)r + r->len;
2830       release(&kalloc_lock);
2831       return p;
2832     }
2833   }
2834   release(&kalloc_lock);
2835 
2836   cprintf("kalloc: out of memory\n");
2837   return 0;
2838 }
2839 
2840 void *
2841 kmalloc(int n)
2842 {
2843 #ifdef MEM_DEBUG
2844     cprintf("kmalloc: %d bytes\n", n);
2845 #endif
2846     return kalloc(((n - 1) / PAGE + 1) * PAGE);
2847 }
2848 
2849 
2850 void
2851 kmfree(void *p, int n)
2852 {
2853 #ifdef MEM_DEBUG
2854     cprintf("kmfree: %d bytes\n", n);
2855 #endif
2856     return kfree(p, ((n - 1) / PAGE + 1) * PAGE);
2857 }
2858 
2859 
2860 
2861 
2862 
2863 
2864 
2865 
2866 
2867 
2868 
2869 
2870 
2871 
2872 
2873 
2874 
2875 
2876 
2877 
2878 
2879 
2880 
2881 
2882 
2883 
2884 
2885 
2886 
2887 
2888 
2889 
2890 
2891 
2892 
2893 
2894 
2895 
2896 
2897 
2898 
2899 
