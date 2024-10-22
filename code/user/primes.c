#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"

void prime(int rd) {
    int n;
    read(
        rd, &n,
        4); // 实验提示：最简单的方法是直接将32位（4字节）int写入管道，而不是使用格式化的ASCII的I/O的体现
    printf("prime %d\n", n);
    int created = 0; // 是否已经创建了管道
    int fd[2]; // 注意实验要求及时关闭文件描述符，因为xv6的系统资源较少
    int num;
    while (read(rd, &num, 4) == 4) {
        if (created == 0) {
            if (pipe(fd) < 0) {
                fprintf(2, "create pipe failed");
                exit(-1);
            };
            created = 1;
            int pid = fork();
            if (pid == 0) {
                close(fd[1]); // 子进程只读
                prime(fd[0]); // 从父进程处读取
                return;
            } else {
                close(fd[0]); // 父进程只写
            }
        }
        if (num % n != 0) {
            if (write(fd[1], &num, 4) < 0) {
                fprintf(2, "write wrong");
                exit(-1);
            };
        }
    }
    // 释放资源
    close(rd);
    close(fd[1]);
    wait(0);
    return;
}

int main(int argc, char *argv[]) {
    int fd[2];
    if (pipe(fd) < 0) {
        fprintf(2, "create pipe failed");
        exit(-1);
    };
    int pid = fork();
    if (pid < 0) {
        fprintf(2, "fork failed");
        exit(-1);
    }
    if (pid != 0) {
        // first
        close(fd[0]);
        for (int i = 2; i <= 35; i++) {
            if (write(fd[1], &i, 4) < 0) {
                fprintf(2, "write wrong");
                exit(-1);
            };
        }
        close(fd[1]);
        wait(0);
        /*
        父进程一旦调用了wait就立即阻塞自己，由wait自动分析是否当前进程的某个子进程已经退出，如果让它找到了这样一个已经变成僵尸的子进程，wait就会收集这个子进程的信息，并把它彻底销毁后返回；如果没有找到这样一个子进程，wait就会一直阻塞在这里，直到有一个出现为止。
        所以在这里父进程会等待子进程结束后一起返回
        wait() 要与fork()配套出现,如果在使用fork()
        之前调用wait(),wait()的返回值则为 - 1,正常情况下wait()
        的返回值为子进程的PID
        如果参数status的值不是NULL，wait就会把子进程退出时的状态取出并存入其中，这是一个整数值（int），指出了子进程是正常退出还是被非正常结束的，以及正常结束时的返回值，或被哪一个信号结束的等信息。
        */
    } else {
        close(fd[1]);
        prime(fd[0]);
        close(fd[0]);
    }
    exit(0);
}