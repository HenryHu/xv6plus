2650 #   void swtch(struct context *old, struct context *new);
2651 #
2652 # Save current register context in old
2653 # and then load register context from new.
2654 
2655 .globl swtch
2656 swtch:
2657   # Save old registers
2658   movl 4(%esp), %eax
2659 
2660   popl 0(%eax)  # %eip
2661   movl %esp, 4(%eax)
2662   movl %ebx, 8(%eax)
2663   movl %ecx, 12(%eax)
2664   movl %edx, 16(%eax)
2665   movl %esi, 20(%eax)
2666   movl %edi, 24(%eax)
2667   movl %ebp, 28(%eax)
2668 
2669   # Load new registers
2670   movl 4(%esp), %eax  # not 8(%esp) - popped return address above
2671 
2672   movl 28(%eax), %ebp
2673   movl 24(%eax), %edi
2674   movl 20(%eax), %esi
2675   movl 16(%eax), %edx
2676   movl 12(%eax), %ecx
2677   movl 8(%eax), %ebx
2678   movl 4(%eax), %esp
2679   pushl 0(%eax)  # %eip
2680 
2681   ret
2682 
2683 
2684 
2685 
2686 
2687 
2688 
2689 
2690 
2691 
2692 
2693 
2694 
2695 
2696 
2697 
2698 
2699 
