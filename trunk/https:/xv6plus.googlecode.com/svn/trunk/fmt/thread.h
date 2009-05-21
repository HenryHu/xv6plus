2900 #ifndef XV6_THREAD_H_
2901 #define XV6_THREAD_H_
2902 typedef struct thread * kproc_t;
2903 
2904 #ifndef SYS_TIMEOUTS_DEFINED
2905 #define SYS_TIMEOUTS_DEFINED
2906 
2907 struct sys_timeouts {
2908     struct sys_timeout *next;
2909 };
2910 #endif // SYS_TIMEOUTS_DEFINED
2911 
2912 struct thread {
2913     struct proc *p;
2914     void *data;
2915     struct sys_timeouts timeouts;
2916 };
2917 
2918 kproc_t kproc_start(void (* proc)(void *arg),
2919         void *arg, int prio, void *data, char *name);
2920 void kproc_free(kproc_t thread);
2921 
2922 #endif // XV6_THREAD_H_
2923 
2924 
2925 
2926 
2927 
2928 
2929 
2930 
2931 
2932 
2933 
2934 
2935 
2936 
2937 
2938 
2939 
2940 
2941 
2942 
2943 
2944 
2945 
2946 
2947 
2948 
2949 
