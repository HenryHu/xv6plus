#include "types.h"
#include "user.h"

int main(int argc, char *argv[])
{    
    int msec, sec;
    msec = upmsec();
    sec = msec / 1000;
    msec %= 1000;
    printf(1, "up time: %d d %d h %d m %d s %d msec\n",
            sec / 86400,
            (sec % 86400) / 3600,
            (sec % 3600) / 60,
            sec % 60,
            msec);

    exit();
}


