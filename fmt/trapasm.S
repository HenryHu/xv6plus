3150 .text
3151 
3152 .set SEG_KDATA_SEL, 0x10   # selector for SEG_KDATA
3153 
3154   # vectors.S sends all traps here.
3155 .globl alltraps
3156 alltraps:
3157   # Build trap frame.
3158   pushl %ds
3159   pushl %es
3160   pushal
3161 
3162   # Set up data segments.
3163   movl $SEG_KDATA_SEL, %eax
3164   movw %ax,%ds
3165   movw %ax,%es
3166 
3167   # Call trap(tf), where tf=%esp
3168   pushl %esp
3169   call trap
3170   addl $4, %esp
3171 
3172   # Return falls through to trapret...
3173 .globl trapret
3174 trapret:
3175   popal
3176   popl %es
3177   popl %ds
3178   addl $0x8, %esp  # trapno and errcode
3179   iret
3180 
3181   # A forked process switches to user mode by calling
3182   # forkret1(tf), where tf is the trap frame to use.
3183 .globl forkret1
3184 forkret1:
3185   movl 4(%esp), %esp
3186   jmp trapret
3187 
3188 
3189 
3190 
3191 
3192 
3193 
3194 
3195 
3196 
3197 
3198 
3199 
