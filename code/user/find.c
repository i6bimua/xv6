#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"
#include "kernel/fs.h"

void search(char *path, char *target);

char *fmtname(char *path) {
    static char buf[DIRSIZ + 1];
    char *p;

    for (p = path + strlen(path); p >= path && *p != '/'; p--)
        ;
    p++;

    if (strlen(p) >= DIRSIZ)
        return p;
    memmove(buf, p, strlen(p));
    memset(buf + strlen(p), 0, DIRSIZ - strlen(p));
    return buf;
}
int main(int argc, char *argv[]) {
    if (argc != 3) {
        fprintf(2, "Usage:find <pathname> <filename>\n");
        exit(1);
    }
    search(argv[1], argv[2]);
    exit(0);
}
void search(char *path, char *target) {
    char *p;
    int fd;
    struct dirent de;
    struct stat st;
    if ((fd = open(path, 0)) < 0) {
        fprintf(2, "open err\n");
        exit(1);
    }
    if (fstat(fd, &st) < 0) {
        fprintf(2, "fstat err\n");
        exit(1);
    }

    switch (st.type) {
    case T_FILE:
        if (!strcmp(target, fmtname(path))) {
            printf("%s\n", path);
        }
        break;
    case T_DIR:
        p = path + strlen(path);
        *p++ = '/';
        while (read(fd, &de, sizeof(de)) == sizeof(de)) {
            if (de.inum == 0)
                continue;
            memmove(p, de.name, DIRSIZ);
            p[DIRSIZ] = 0;
            if (strcmp(p, ".") && strcmp(p, ".."))
                search(path, target);
            memset(p, 0, DIRSIZ);
        }
    }
    close(fd);
}