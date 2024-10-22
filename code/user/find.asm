
user/_find:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <fmtname>:
#include "user/user.h"
#include "kernel/fs.h"

void search(char *path, char *target);

char *fmtname(char *path) {
   0:	7179                	addi	sp,sp,-48
   2:	f406                	sd	ra,40(sp)
   4:	f022                	sd	s0,32(sp)
   6:	ec26                	sd	s1,24(sp)
   8:	e84a                	sd	s2,16(sp)
   a:	e44e                	sd	s3,8(sp)
   c:	1800                	addi	s0,sp,48
   e:	84aa                	mv	s1,a0
    static char buf[DIRSIZ + 1];
    char *p;

    for (p = path + strlen(path); p >= path && *p != '/'; p--)
  10:	00000097          	auipc	ra,0x0
  14:	298080e7          	jalr	664(ra) # 2a8 <strlen>
  18:	02051793          	slli	a5,a0,0x20
  1c:	9381                	srli	a5,a5,0x20
  1e:	97a6                	add	a5,a5,s1
  20:	02f00693          	li	a3,47
  24:	0097e963          	bltu	a5,s1,36 <fmtname+0x36>
  28:	0007c703          	lbu	a4,0(a5)
  2c:	00d70563          	beq	a4,a3,36 <fmtname+0x36>
  30:	17fd                	addi	a5,a5,-1
  32:	fe97fbe3          	bgeu	a5,s1,28 <fmtname+0x28>
        ;
    p++;
  36:	00178493          	addi	s1,a5,1

    if (strlen(p) >= DIRSIZ)
  3a:	8526                	mv	a0,s1
  3c:	00000097          	auipc	ra,0x0
  40:	26c080e7          	jalr	620(ra) # 2a8 <strlen>
  44:	2501                	sext.w	a0,a0
  46:	47b5                	li	a5,13
  48:	00a7fa63          	bgeu	a5,a0,5c <fmtname+0x5c>
        return p;
    memmove(buf, p, strlen(p));
    memset(buf + strlen(p), 0, DIRSIZ - strlen(p));
    return buf;
}
  4c:	8526                	mv	a0,s1
  4e:	70a2                	ld	ra,40(sp)
  50:	7402                	ld	s0,32(sp)
  52:	64e2                	ld	s1,24(sp)
  54:	6942                	ld	s2,16(sp)
  56:	69a2                	ld	s3,8(sp)
  58:	6145                	addi	sp,sp,48
  5a:	8082                	ret
    memmove(buf, p, strlen(p));
  5c:	8526                	mv	a0,s1
  5e:	00000097          	auipc	ra,0x0
  62:	24a080e7          	jalr	586(ra) # 2a8 <strlen>
  66:	00001997          	auipc	s3,0x1
  6a:	a1298993          	addi	s3,s3,-1518 # a78 <buf.1110>
  6e:	0005061b          	sext.w	a2,a0
  72:	85a6                	mv	a1,s1
  74:	854e                	mv	a0,s3
  76:	00000097          	auipc	ra,0x0
  7a:	3aa080e7          	jalr	938(ra) # 420 <memmove>
    memset(buf + strlen(p), 0, DIRSIZ - strlen(p));
  7e:	8526                	mv	a0,s1
  80:	00000097          	auipc	ra,0x0
  84:	228080e7          	jalr	552(ra) # 2a8 <strlen>
  88:	0005091b          	sext.w	s2,a0
  8c:	8526                	mv	a0,s1
  8e:	00000097          	auipc	ra,0x0
  92:	21a080e7          	jalr	538(ra) # 2a8 <strlen>
  96:	1902                	slli	s2,s2,0x20
  98:	02095913          	srli	s2,s2,0x20
  9c:	4639                	li	a2,14
  9e:	9e09                	subw	a2,a2,a0
  a0:	4581                	li	a1,0
  a2:	01298533          	add	a0,s3,s2
  a6:	00000097          	auipc	ra,0x0
  aa:	22c080e7          	jalr	556(ra) # 2d2 <memset>
    return buf;
  ae:	84ce                	mv	s1,s3
  b0:	bf71                	j	4c <fmtname+0x4c>

00000000000000b2 <search>:
        exit(1);
    }
    search(argv[1], argv[2]);
    exit(0);
}
void search(char *path, char *target) {
  b2:	7119                	addi	sp,sp,-128
  b4:	fc86                	sd	ra,120(sp)
  b6:	f8a2                	sd	s0,112(sp)
  b8:	f4a6                	sd	s1,104(sp)
  ba:	f0ca                	sd	s2,96(sp)
  bc:	ecce                	sd	s3,88(sp)
  be:	e8d2                	sd	s4,80(sp)
  c0:	e4d6                	sd	s5,72(sp)
  c2:	e0da                	sd	s6,64(sp)
  c4:	fc5e                	sd	s7,56(sp)
  c6:	0100                	addi	s0,sp,128
  c8:	892a                	mv	s2,a0
  ca:	89ae                	mv	s3,a1
    char *p;
    int fd;
    struct dirent de;
    struct stat st;
    if ((fd = open(path, 0)) < 0) {
  cc:	4581                	li	a1,0
  ce:	00000097          	auipc	ra,0x0
  d2:	448080e7          	jalr	1096(ra) # 516 <open>
  d6:	06054163          	bltz	a0,138 <search+0x86>
  da:	84aa                	mv	s1,a0
        fprintf(2, "open err\n");
        exit(1);
    }
    if (fstat(fd, &st) < 0) {
  dc:	f8840593          	addi	a1,s0,-120
  e0:	00000097          	auipc	ra,0x0
  e4:	44e080e7          	jalr	1102(ra) # 52e <fstat>
  e8:	06054663          	bltz	a0,154 <search+0xa2>
        fprintf(2, "fstat err\n");
        exit(1);
    }

    switch (st.type) {
  ec:	f9041783          	lh	a5,-112(s0)
  f0:	0007869b          	sext.w	a3,a5
  f4:	4705                	li	a4,1
  f6:	08e68763          	beq	a3,a4,184 <search+0xd2>
  fa:	4709                	li	a4,2
  fc:	00e69e63          	bne	a3,a4,118 <search+0x66>
    case T_FILE:
        if (!strcmp(target, fmtname(path))) {
 100:	854a                	mv	a0,s2
 102:	00000097          	auipc	ra,0x0
 106:	efe080e7          	jalr	-258(ra) # 0 <fmtname>
 10a:	85aa                	mv	a1,a0
 10c:	854e                	mv	a0,s3
 10e:	00000097          	auipc	ra,0x0
 112:	16e080e7          	jalr	366(ra) # 27c <strcmp>
 116:	cd29                	beqz	a0,170 <search+0xbe>
            if (strcmp(p, ".") && strcmp(p, ".."))
                search(path, target);
            memset(p, 0, DIRSIZ);
        }
    }
    close(fd);
 118:	8526                	mv	a0,s1
 11a:	00000097          	auipc	ra,0x0
 11e:	3e4080e7          	jalr	996(ra) # 4fe <close>
 122:	70e6                	ld	ra,120(sp)
 124:	7446                	ld	s0,112(sp)
 126:	74a6                	ld	s1,104(sp)
 128:	7906                	ld	s2,96(sp)
 12a:	69e6                	ld	s3,88(sp)
 12c:	6a46                	ld	s4,80(sp)
 12e:	6aa6                	ld	s5,72(sp)
 130:	6b06                	ld	s6,64(sp)
 132:	7be2                	ld	s7,56(sp)
 134:	6109                	addi	sp,sp,128
 136:	8082                	ret
        fprintf(2, "open err\n");
 138:	00001597          	auipc	a1,0x1
 13c:	8b858593          	addi	a1,a1,-1864 # 9f0 <malloc+0xe4>
 140:	4509                	li	a0,2
 142:	00000097          	auipc	ra,0x0
 146:	6de080e7          	jalr	1758(ra) # 820 <fprintf>
        exit(1);
 14a:	4505                	li	a0,1
 14c:	00000097          	auipc	ra,0x0
 150:	38a080e7          	jalr	906(ra) # 4d6 <exit>
        fprintf(2, "fstat err\n");
 154:	00001597          	auipc	a1,0x1
 158:	8ac58593          	addi	a1,a1,-1876 # a00 <malloc+0xf4>
 15c:	4509                	li	a0,2
 15e:	00000097          	auipc	ra,0x0
 162:	6c2080e7          	jalr	1730(ra) # 820 <fprintf>
        exit(1);
 166:	4505                	li	a0,1
 168:	00000097          	auipc	ra,0x0
 16c:	36e080e7          	jalr	878(ra) # 4d6 <exit>
            printf("%s\n", path);
 170:	85ca                	mv	a1,s2
 172:	00001517          	auipc	a0,0x1
 176:	89e50513          	addi	a0,a0,-1890 # a10 <malloc+0x104>
 17a:	00000097          	auipc	ra,0x0
 17e:	6d4080e7          	jalr	1748(ra) # 84e <printf>
 182:	bf59                	j	118 <search+0x66>
        p = path + strlen(path);
 184:	854a                	mv	a0,s2
 186:	00000097          	auipc	ra,0x0
 18a:	122080e7          	jalr	290(ra) # 2a8 <strlen>
 18e:	02051a13          	slli	s4,a0,0x20
 192:	020a5a13          	srli	s4,s4,0x20
 196:	9a4a                	add	s4,s4,s2
        *p++ = '/';
 198:	001a0a93          	addi	s5,s4,1
 19c:	02f00793          	li	a5,47
 1a0:	00fa0023          	sb	a5,0(s4)
            if (strcmp(p, ".") && strcmp(p, ".."))
 1a4:	00001b17          	auipc	s6,0x1
 1a8:	874b0b13          	addi	s6,s6,-1932 # a18 <malloc+0x10c>
 1ac:	00001b97          	auipc	s7,0x1
 1b0:	874b8b93          	addi	s7,s7,-1932 # a20 <malloc+0x114>
        while (read(fd, &de, sizeof(de)) == sizeof(de)) {
 1b4:	a801                	j	1c4 <search+0x112>
            memset(p, 0, DIRSIZ);
 1b6:	4639                	li	a2,14
 1b8:	4581                	li	a1,0
 1ba:	8556                	mv	a0,s5
 1bc:	00000097          	auipc	ra,0x0
 1c0:	116080e7          	jalr	278(ra) # 2d2 <memset>
        while (read(fd, &de, sizeof(de)) == sizeof(de)) {
 1c4:	4641                	li	a2,16
 1c6:	fa040593          	addi	a1,s0,-96
 1ca:	8526                	mv	a0,s1
 1cc:	00000097          	auipc	ra,0x0
 1d0:	322080e7          	jalr	802(ra) # 4ee <read>
 1d4:	47c1                	li	a5,16
 1d6:	f4f511e3          	bne	a0,a5,118 <search+0x66>
            if (de.inum == 0)
 1da:	fa045783          	lhu	a5,-96(s0)
 1de:	d3fd                	beqz	a5,1c4 <search+0x112>
            memmove(p, de.name, DIRSIZ);
 1e0:	4639                	li	a2,14
 1e2:	fa240593          	addi	a1,s0,-94
 1e6:	8556                	mv	a0,s5
 1e8:	00000097          	auipc	ra,0x0
 1ec:	238080e7          	jalr	568(ra) # 420 <memmove>
            p[DIRSIZ] = 0;
 1f0:	000a07a3          	sb	zero,15(s4)
            if (strcmp(p, ".") && strcmp(p, ".."))
 1f4:	85da                	mv	a1,s6
 1f6:	8556                	mv	a0,s5
 1f8:	00000097          	auipc	ra,0x0
 1fc:	084080e7          	jalr	132(ra) # 27c <strcmp>
 200:	d95d                	beqz	a0,1b6 <search+0x104>
 202:	85de                	mv	a1,s7
 204:	8556                	mv	a0,s5
 206:	00000097          	auipc	ra,0x0
 20a:	076080e7          	jalr	118(ra) # 27c <strcmp>
 20e:	d545                	beqz	a0,1b6 <search+0x104>
                search(path, target);
 210:	85ce                	mv	a1,s3
 212:	854a                	mv	a0,s2
 214:	00000097          	auipc	ra,0x0
 218:	e9e080e7          	jalr	-354(ra) # b2 <search>
 21c:	bf69                	j	1b6 <search+0x104>

000000000000021e <main>:
int main(int argc, char *argv[]) {
 21e:	1141                	addi	sp,sp,-16
 220:	e406                	sd	ra,8(sp)
 222:	e022                	sd	s0,0(sp)
 224:	0800                	addi	s0,sp,16
    if (argc != 3) {
 226:	470d                	li	a4,3
 228:	02e50063          	beq	a0,a4,248 <main+0x2a>
        fprintf(2, "Usage:find <pathname> <filename>\n");
 22c:	00000597          	auipc	a1,0x0
 230:	7fc58593          	addi	a1,a1,2044 # a28 <malloc+0x11c>
 234:	4509                	li	a0,2
 236:	00000097          	auipc	ra,0x0
 23a:	5ea080e7          	jalr	1514(ra) # 820 <fprintf>
        exit(1);
 23e:	4505                	li	a0,1
 240:	00000097          	auipc	ra,0x0
 244:	296080e7          	jalr	662(ra) # 4d6 <exit>
 248:	87ae                	mv	a5,a1
    search(argv[1], argv[2]);
 24a:	698c                	ld	a1,16(a1)
 24c:	6788                	ld	a0,8(a5)
 24e:	00000097          	auipc	ra,0x0
 252:	e64080e7          	jalr	-412(ra) # b2 <search>
    exit(0);
 256:	4501                	li	a0,0
 258:	00000097          	auipc	ra,0x0
 25c:	27e080e7          	jalr	638(ra) # 4d6 <exit>

0000000000000260 <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
 260:	1141                	addi	sp,sp,-16
 262:	e422                	sd	s0,8(sp)
 264:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 266:	87aa                	mv	a5,a0
 268:	0585                	addi	a1,a1,1
 26a:	0785                	addi	a5,a5,1
 26c:	fff5c703          	lbu	a4,-1(a1)
 270:	fee78fa3          	sb	a4,-1(a5)
 274:	fb75                	bnez	a4,268 <strcpy+0x8>
    ;
  return os;
}
 276:	6422                	ld	s0,8(sp)
 278:	0141                	addi	sp,sp,16
 27a:	8082                	ret

000000000000027c <strcmp>:

int
strcmp(const char *p, const char *q)
{
 27c:	1141                	addi	sp,sp,-16
 27e:	e422                	sd	s0,8(sp)
 280:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 282:	00054783          	lbu	a5,0(a0)
 286:	cb91                	beqz	a5,29a <strcmp+0x1e>
 288:	0005c703          	lbu	a4,0(a1)
 28c:	00f71763          	bne	a4,a5,29a <strcmp+0x1e>
    p++, q++;
 290:	0505                	addi	a0,a0,1
 292:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 294:	00054783          	lbu	a5,0(a0)
 298:	fbe5                	bnez	a5,288 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 29a:	0005c503          	lbu	a0,0(a1)
}
 29e:	40a7853b          	subw	a0,a5,a0
 2a2:	6422                	ld	s0,8(sp)
 2a4:	0141                	addi	sp,sp,16
 2a6:	8082                	ret

00000000000002a8 <strlen>:

uint
strlen(const char *s)
{
 2a8:	1141                	addi	sp,sp,-16
 2aa:	e422                	sd	s0,8(sp)
 2ac:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 2ae:	00054783          	lbu	a5,0(a0)
 2b2:	cf91                	beqz	a5,2ce <strlen+0x26>
 2b4:	0505                	addi	a0,a0,1
 2b6:	87aa                	mv	a5,a0
 2b8:	4685                	li	a3,1
 2ba:	9e89                	subw	a3,a3,a0
 2bc:	00f6853b          	addw	a0,a3,a5
 2c0:	0785                	addi	a5,a5,1
 2c2:	fff7c703          	lbu	a4,-1(a5)
 2c6:	fb7d                	bnez	a4,2bc <strlen+0x14>
    ;
  return n;
}
 2c8:	6422                	ld	s0,8(sp)
 2ca:	0141                	addi	sp,sp,16
 2cc:	8082                	ret
  for(n = 0; s[n]; n++)
 2ce:	4501                	li	a0,0
 2d0:	bfe5                	j	2c8 <strlen+0x20>

00000000000002d2 <memset>:

void*
memset(void *dst, int c, uint n)
{
 2d2:	1141                	addi	sp,sp,-16
 2d4:	e422                	sd	s0,8(sp)
 2d6:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 2d8:	ce09                	beqz	a2,2f2 <memset+0x20>
 2da:	87aa                	mv	a5,a0
 2dc:	fff6071b          	addiw	a4,a2,-1
 2e0:	1702                	slli	a4,a4,0x20
 2e2:	9301                	srli	a4,a4,0x20
 2e4:	0705                	addi	a4,a4,1
 2e6:	972a                	add	a4,a4,a0
    cdst[i] = c;
 2e8:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 2ec:	0785                	addi	a5,a5,1
 2ee:	fee79de3          	bne	a5,a4,2e8 <memset+0x16>
  }
  return dst;
}
 2f2:	6422                	ld	s0,8(sp)
 2f4:	0141                	addi	sp,sp,16
 2f6:	8082                	ret

00000000000002f8 <strchr>:

char*
strchr(const char *s, char c)
{
 2f8:	1141                	addi	sp,sp,-16
 2fa:	e422                	sd	s0,8(sp)
 2fc:	0800                	addi	s0,sp,16
  for(; *s; s++)
 2fe:	00054783          	lbu	a5,0(a0)
 302:	cb99                	beqz	a5,318 <strchr+0x20>
    if(*s == c)
 304:	00f58763          	beq	a1,a5,312 <strchr+0x1a>
  for(; *s; s++)
 308:	0505                	addi	a0,a0,1
 30a:	00054783          	lbu	a5,0(a0)
 30e:	fbfd                	bnez	a5,304 <strchr+0xc>
      return (char*)s;
  return 0;
 310:	4501                	li	a0,0
}
 312:	6422                	ld	s0,8(sp)
 314:	0141                	addi	sp,sp,16
 316:	8082                	ret
  return 0;
 318:	4501                	li	a0,0
 31a:	bfe5                	j	312 <strchr+0x1a>

000000000000031c <gets>:

char*
gets(char *buf, int max)
{
 31c:	711d                	addi	sp,sp,-96
 31e:	ec86                	sd	ra,88(sp)
 320:	e8a2                	sd	s0,80(sp)
 322:	e4a6                	sd	s1,72(sp)
 324:	e0ca                	sd	s2,64(sp)
 326:	fc4e                	sd	s3,56(sp)
 328:	f852                	sd	s4,48(sp)
 32a:	f456                	sd	s5,40(sp)
 32c:	f05a                	sd	s6,32(sp)
 32e:	ec5e                	sd	s7,24(sp)
 330:	1080                	addi	s0,sp,96
 332:	8baa                	mv	s7,a0
 334:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 336:	892a                	mv	s2,a0
 338:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 33a:	4aa9                	li	s5,10
 33c:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 33e:	89a6                	mv	s3,s1
 340:	2485                	addiw	s1,s1,1
 342:	0344d863          	bge	s1,s4,372 <gets+0x56>
    cc = read(0, &c, 1);
 346:	4605                	li	a2,1
 348:	faf40593          	addi	a1,s0,-81
 34c:	4501                	li	a0,0
 34e:	00000097          	auipc	ra,0x0
 352:	1a0080e7          	jalr	416(ra) # 4ee <read>
    if(cc < 1)
 356:	00a05e63          	blez	a0,372 <gets+0x56>
    buf[i++] = c;
 35a:	faf44783          	lbu	a5,-81(s0)
 35e:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 362:	01578763          	beq	a5,s5,370 <gets+0x54>
 366:	0905                	addi	s2,s2,1
 368:	fd679be3          	bne	a5,s6,33e <gets+0x22>
  for(i=0; i+1 < max; ){
 36c:	89a6                	mv	s3,s1
 36e:	a011                	j	372 <gets+0x56>
 370:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 372:	99de                	add	s3,s3,s7
 374:	00098023          	sb	zero,0(s3)
  return buf;
}
 378:	855e                	mv	a0,s7
 37a:	60e6                	ld	ra,88(sp)
 37c:	6446                	ld	s0,80(sp)
 37e:	64a6                	ld	s1,72(sp)
 380:	6906                	ld	s2,64(sp)
 382:	79e2                	ld	s3,56(sp)
 384:	7a42                	ld	s4,48(sp)
 386:	7aa2                	ld	s5,40(sp)
 388:	7b02                	ld	s6,32(sp)
 38a:	6be2                	ld	s7,24(sp)
 38c:	6125                	addi	sp,sp,96
 38e:	8082                	ret

0000000000000390 <stat>:

int
stat(const char *n, struct stat *st)
{
 390:	1101                	addi	sp,sp,-32
 392:	ec06                	sd	ra,24(sp)
 394:	e822                	sd	s0,16(sp)
 396:	e426                	sd	s1,8(sp)
 398:	e04a                	sd	s2,0(sp)
 39a:	1000                	addi	s0,sp,32
 39c:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 39e:	4581                	li	a1,0
 3a0:	00000097          	auipc	ra,0x0
 3a4:	176080e7          	jalr	374(ra) # 516 <open>
  if(fd < 0)
 3a8:	02054563          	bltz	a0,3d2 <stat+0x42>
 3ac:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 3ae:	85ca                	mv	a1,s2
 3b0:	00000097          	auipc	ra,0x0
 3b4:	17e080e7          	jalr	382(ra) # 52e <fstat>
 3b8:	892a                	mv	s2,a0
  close(fd);
 3ba:	8526                	mv	a0,s1
 3bc:	00000097          	auipc	ra,0x0
 3c0:	142080e7          	jalr	322(ra) # 4fe <close>
  return r;
}
 3c4:	854a                	mv	a0,s2
 3c6:	60e2                	ld	ra,24(sp)
 3c8:	6442                	ld	s0,16(sp)
 3ca:	64a2                	ld	s1,8(sp)
 3cc:	6902                	ld	s2,0(sp)
 3ce:	6105                	addi	sp,sp,32
 3d0:	8082                	ret
    return -1;
 3d2:	597d                	li	s2,-1
 3d4:	bfc5                	j	3c4 <stat+0x34>

00000000000003d6 <atoi>:

int
atoi(const char *s)
{
 3d6:	1141                	addi	sp,sp,-16
 3d8:	e422                	sd	s0,8(sp)
 3da:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 3dc:	00054603          	lbu	a2,0(a0)
 3e0:	fd06079b          	addiw	a5,a2,-48
 3e4:	0ff7f793          	andi	a5,a5,255
 3e8:	4725                	li	a4,9
 3ea:	02f76963          	bltu	a4,a5,41c <atoi+0x46>
 3ee:	86aa                	mv	a3,a0
  n = 0;
 3f0:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 3f2:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 3f4:	0685                	addi	a3,a3,1
 3f6:	0025179b          	slliw	a5,a0,0x2
 3fa:	9fa9                	addw	a5,a5,a0
 3fc:	0017979b          	slliw	a5,a5,0x1
 400:	9fb1                	addw	a5,a5,a2
 402:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 406:	0006c603          	lbu	a2,0(a3)
 40a:	fd06071b          	addiw	a4,a2,-48
 40e:	0ff77713          	andi	a4,a4,255
 412:	fee5f1e3          	bgeu	a1,a4,3f4 <atoi+0x1e>
  return n;
}
 416:	6422                	ld	s0,8(sp)
 418:	0141                	addi	sp,sp,16
 41a:	8082                	ret
  n = 0;
 41c:	4501                	li	a0,0
 41e:	bfe5                	j	416 <atoi+0x40>

0000000000000420 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 420:	1141                	addi	sp,sp,-16
 422:	e422                	sd	s0,8(sp)
 424:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 426:	02b57663          	bgeu	a0,a1,452 <memmove+0x32>
    while(n-- > 0)
 42a:	02c05163          	blez	a2,44c <memmove+0x2c>
 42e:	fff6079b          	addiw	a5,a2,-1
 432:	1782                	slli	a5,a5,0x20
 434:	9381                	srli	a5,a5,0x20
 436:	0785                	addi	a5,a5,1
 438:	97aa                	add	a5,a5,a0
  dst = vdst;
 43a:	872a                	mv	a4,a0
      *dst++ = *src++;
 43c:	0585                	addi	a1,a1,1
 43e:	0705                	addi	a4,a4,1
 440:	fff5c683          	lbu	a3,-1(a1)
 444:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 448:	fee79ae3          	bne	a5,a4,43c <memmove+0x1c>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 44c:	6422                	ld	s0,8(sp)
 44e:	0141                	addi	sp,sp,16
 450:	8082                	ret
    dst += n;
 452:	00c50733          	add	a4,a0,a2
    src += n;
 456:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 458:	fec05ae3          	blez	a2,44c <memmove+0x2c>
 45c:	fff6079b          	addiw	a5,a2,-1
 460:	1782                	slli	a5,a5,0x20
 462:	9381                	srli	a5,a5,0x20
 464:	fff7c793          	not	a5,a5
 468:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 46a:	15fd                	addi	a1,a1,-1
 46c:	177d                	addi	a4,a4,-1
 46e:	0005c683          	lbu	a3,0(a1)
 472:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 476:	fee79ae3          	bne	a5,a4,46a <memmove+0x4a>
 47a:	bfc9                	j	44c <memmove+0x2c>

000000000000047c <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 47c:	1141                	addi	sp,sp,-16
 47e:	e422                	sd	s0,8(sp)
 480:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 482:	ca05                	beqz	a2,4b2 <memcmp+0x36>
 484:	fff6069b          	addiw	a3,a2,-1
 488:	1682                	slli	a3,a3,0x20
 48a:	9281                	srli	a3,a3,0x20
 48c:	0685                	addi	a3,a3,1
 48e:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 490:	00054783          	lbu	a5,0(a0)
 494:	0005c703          	lbu	a4,0(a1)
 498:	00e79863          	bne	a5,a4,4a8 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 49c:	0505                	addi	a0,a0,1
    p2++;
 49e:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 4a0:	fed518e3          	bne	a0,a3,490 <memcmp+0x14>
  }
  return 0;
 4a4:	4501                	li	a0,0
 4a6:	a019                	j	4ac <memcmp+0x30>
      return *p1 - *p2;
 4a8:	40e7853b          	subw	a0,a5,a4
}
 4ac:	6422                	ld	s0,8(sp)
 4ae:	0141                	addi	sp,sp,16
 4b0:	8082                	ret
  return 0;
 4b2:	4501                	li	a0,0
 4b4:	bfe5                	j	4ac <memcmp+0x30>

00000000000004b6 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 4b6:	1141                	addi	sp,sp,-16
 4b8:	e406                	sd	ra,8(sp)
 4ba:	e022                	sd	s0,0(sp)
 4bc:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 4be:	00000097          	auipc	ra,0x0
 4c2:	f62080e7          	jalr	-158(ra) # 420 <memmove>
}
 4c6:	60a2                	ld	ra,8(sp)
 4c8:	6402                	ld	s0,0(sp)
 4ca:	0141                	addi	sp,sp,16
 4cc:	8082                	ret

00000000000004ce <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 4ce:	4885                	li	a7,1
 ecall
 4d0:	00000073          	ecall
 ret
 4d4:	8082                	ret

00000000000004d6 <exit>:
.global exit
exit:
 li a7, SYS_exit
 4d6:	4889                	li	a7,2
 ecall
 4d8:	00000073          	ecall
 ret
 4dc:	8082                	ret

00000000000004de <wait>:
.global wait
wait:
 li a7, SYS_wait
 4de:	488d                	li	a7,3
 ecall
 4e0:	00000073          	ecall
 ret
 4e4:	8082                	ret

00000000000004e6 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 4e6:	4891                	li	a7,4
 ecall
 4e8:	00000073          	ecall
 ret
 4ec:	8082                	ret

00000000000004ee <read>:
.global read
read:
 li a7, SYS_read
 4ee:	4895                	li	a7,5
 ecall
 4f0:	00000073          	ecall
 ret
 4f4:	8082                	ret

00000000000004f6 <write>:
.global write
write:
 li a7, SYS_write
 4f6:	48c1                	li	a7,16
 ecall
 4f8:	00000073          	ecall
 ret
 4fc:	8082                	ret

00000000000004fe <close>:
.global close
close:
 li a7, SYS_close
 4fe:	48d5                	li	a7,21
 ecall
 500:	00000073          	ecall
 ret
 504:	8082                	ret

0000000000000506 <kill>:
.global kill
kill:
 li a7, SYS_kill
 506:	4899                	li	a7,6
 ecall
 508:	00000073          	ecall
 ret
 50c:	8082                	ret

000000000000050e <exec>:
.global exec
exec:
 li a7, SYS_exec
 50e:	489d                	li	a7,7
 ecall
 510:	00000073          	ecall
 ret
 514:	8082                	ret

0000000000000516 <open>:
.global open
open:
 li a7, SYS_open
 516:	48bd                	li	a7,15
 ecall
 518:	00000073          	ecall
 ret
 51c:	8082                	ret

000000000000051e <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 51e:	48c5                	li	a7,17
 ecall
 520:	00000073          	ecall
 ret
 524:	8082                	ret

0000000000000526 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 526:	48c9                	li	a7,18
 ecall
 528:	00000073          	ecall
 ret
 52c:	8082                	ret

000000000000052e <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 52e:	48a1                	li	a7,8
 ecall
 530:	00000073          	ecall
 ret
 534:	8082                	ret

0000000000000536 <link>:
.global link
link:
 li a7, SYS_link
 536:	48cd                	li	a7,19
 ecall
 538:	00000073          	ecall
 ret
 53c:	8082                	ret

000000000000053e <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 53e:	48d1                	li	a7,20
 ecall
 540:	00000073          	ecall
 ret
 544:	8082                	ret

0000000000000546 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 546:	48a5                	li	a7,9
 ecall
 548:	00000073          	ecall
 ret
 54c:	8082                	ret

000000000000054e <dup>:
.global dup
dup:
 li a7, SYS_dup
 54e:	48a9                	li	a7,10
 ecall
 550:	00000073          	ecall
 ret
 554:	8082                	ret

0000000000000556 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 556:	48ad                	li	a7,11
 ecall
 558:	00000073          	ecall
 ret
 55c:	8082                	ret

000000000000055e <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 55e:	48b1                	li	a7,12
 ecall
 560:	00000073          	ecall
 ret
 564:	8082                	ret

0000000000000566 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 566:	48b5                	li	a7,13
 ecall
 568:	00000073          	ecall
 ret
 56c:	8082                	ret

000000000000056e <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 56e:	48b9                	li	a7,14
 ecall
 570:	00000073          	ecall
 ret
 574:	8082                	ret

0000000000000576 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 576:	1101                	addi	sp,sp,-32
 578:	ec06                	sd	ra,24(sp)
 57a:	e822                	sd	s0,16(sp)
 57c:	1000                	addi	s0,sp,32
 57e:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 582:	4605                	li	a2,1
 584:	fef40593          	addi	a1,s0,-17
 588:	00000097          	auipc	ra,0x0
 58c:	f6e080e7          	jalr	-146(ra) # 4f6 <write>
}
 590:	60e2                	ld	ra,24(sp)
 592:	6442                	ld	s0,16(sp)
 594:	6105                	addi	sp,sp,32
 596:	8082                	ret

0000000000000598 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 598:	7139                	addi	sp,sp,-64
 59a:	fc06                	sd	ra,56(sp)
 59c:	f822                	sd	s0,48(sp)
 59e:	f426                	sd	s1,40(sp)
 5a0:	f04a                	sd	s2,32(sp)
 5a2:	ec4e                	sd	s3,24(sp)
 5a4:	0080                	addi	s0,sp,64
 5a6:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 5a8:	c299                	beqz	a3,5ae <printint+0x16>
 5aa:	0805c863          	bltz	a1,63a <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 5ae:	2581                	sext.w	a1,a1
  neg = 0;
 5b0:	4881                	li	a7,0
 5b2:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 5b6:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 5b8:	2601                	sext.w	a2,a2
 5ba:	00000517          	auipc	a0,0x0
 5be:	49e50513          	addi	a0,a0,1182 # a58 <digits>
 5c2:	883a                	mv	a6,a4
 5c4:	2705                	addiw	a4,a4,1
 5c6:	02c5f7bb          	remuw	a5,a1,a2
 5ca:	1782                	slli	a5,a5,0x20
 5cc:	9381                	srli	a5,a5,0x20
 5ce:	97aa                	add	a5,a5,a0
 5d0:	0007c783          	lbu	a5,0(a5)
 5d4:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 5d8:	0005879b          	sext.w	a5,a1
 5dc:	02c5d5bb          	divuw	a1,a1,a2
 5e0:	0685                	addi	a3,a3,1
 5e2:	fec7f0e3          	bgeu	a5,a2,5c2 <printint+0x2a>
  if(neg)
 5e6:	00088b63          	beqz	a7,5fc <printint+0x64>
    buf[i++] = '-';
 5ea:	fd040793          	addi	a5,s0,-48
 5ee:	973e                	add	a4,a4,a5
 5f0:	02d00793          	li	a5,45
 5f4:	fef70823          	sb	a5,-16(a4)
 5f8:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 5fc:	02e05863          	blez	a4,62c <printint+0x94>
 600:	fc040793          	addi	a5,s0,-64
 604:	00e78933          	add	s2,a5,a4
 608:	fff78993          	addi	s3,a5,-1
 60c:	99ba                	add	s3,s3,a4
 60e:	377d                	addiw	a4,a4,-1
 610:	1702                	slli	a4,a4,0x20
 612:	9301                	srli	a4,a4,0x20
 614:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 618:	fff94583          	lbu	a1,-1(s2)
 61c:	8526                	mv	a0,s1
 61e:	00000097          	auipc	ra,0x0
 622:	f58080e7          	jalr	-168(ra) # 576 <putc>
  while(--i >= 0)
 626:	197d                	addi	s2,s2,-1
 628:	ff3918e3          	bne	s2,s3,618 <printint+0x80>
}
 62c:	70e2                	ld	ra,56(sp)
 62e:	7442                	ld	s0,48(sp)
 630:	74a2                	ld	s1,40(sp)
 632:	7902                	ld	s2,32(sp)
 634:	69e2                	ld	s3,24(sp)
 636:	6121                	addi	sp,sp,64
 638:	8082                	ret
    x = -xx;
 63a:	40b005bb          	negw	a1,a1
    neg = 1;
 63e:	4885                	li	a7,1
    x = -xx;
 640:	bf8d                	j	5b2 <printint+0x1a>

0000000000000642 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 642:	7119                	addi	sp,sp,-128
 644:	fc86                	sd	ra,120(sp)
 646:	f8a2                	sd	s0,112(sp)
 648:	f4a6                	sd	s1,104(sp)
 64a:	f0ca                	sd	s2,96(sp)
 64c:	ecce                	sd	s3,88(sp)
 64e:	e8d2                	sd	s4,80(sp)
 650:	e4d6                	sd	s5,72(sp)
 652:	e0da                	sd	s6,64(sp)
 654:	fc5e                	sd	s7,56(sp)
 656:	f862                	sd	s8,48(sp)
 658:	f466                	sd	s9,40(sp)
 65a:	f06a                	sd	s10,32(sp)
 65c:	ec6e                	sd	s11,24(sp)
 65e:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 660:	0005c903          	lbu	s2,0(a1)
 664:	18090f63          	beqz	s2,802 <vprintf+0x1c0>
 668:	8aaa                	mv	s5,a0
 66a:	8b32                	mv	s6,a2
 66c:	00158493          	addi	s1,a1,1
  state = 0;
 670:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 672:	02500a13          	li	s4,37
      if(c == 'd'){
 676:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 67a:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 67e:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 682:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 686:	00000b97          	auipc	s7,0x0
 68a:	3d2b8b93          	addi	s7,s7,978 # a58 <digits>
 68e:	a839                	j	6ac <vprintf+0x6a>
        putc(fd, c);
 690:	85ca                	mv	a1,s2
 692:	8556                	mv	a0,s5
 694:	00000097          	auipc	ra,0x0
 698:	ee2080e7          	jalr	-286(ra) # 576 <putc>
 69c:	a019                	j	6a2 <vprintf+0x60>
    } else if(state == '%'){
 69e:	01498f63          	beq	s3,s4,6bc <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
 6a2:	0485                	addi	s1,s1,1
 6a4:	fff4c903          	lbu	s2,-1(s1)
 6a8:	14090d63          	beqz	s2,802 <vprintf+0x1c0>
    c = fmt[i] & 0xff;
 6ac:	0009079b          	sext.w	a5,s2
    if(state == 0){
 6b0:	fe0997e3          	bnez	s3,69e <vprintf+0x5c>
      if(c == '%'){
 6b4:	fd479ee3          	bne	a5,s4,690 <vprintf+0x4e>
        state = '%';
 6b8:	89be                	mv	s3,a5
 6ba:	b7e5                	j	6a2 <vprintf+0x60>
      if(c == 'd'){
 6bc:	05878063          	beq	a5,s8,6fc <vprintf+0xba>
      } else if(c == 'l') {
 6c0:	05978c63          	beq	a5,s9,718 <vprintf+0xd6>
      } else if(c == 'x') {
 6c4:	07a78863          	beq	a5,s10,734 <vprintf+0xf2>
      } else if(c == 'p') {
 6c8:	09b78463          	beq	a5,s11,750 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 6cc:	07300713          	li	a4,115
 6d0:	0ce78663          	beq	a5,a4,79c <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 6d4:	06300713          	li	a4,99
 6d8:	0ee78e63          	beq	a5,a4,7d4 <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 6dc:	11478863          	beq	a5,s4,7ec <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 6e0:	85d2                	mv	a1,s4
 6e2:	8556                	mv	a0,s5
 6e4:	00000097          	auipc	ra,0x0
 6e8:	e92080e7          	jalr	-366(ra) # 576 <putc>
        putc(fd, c);
 6ec:	85ca                	mv	a1,s2
 6ee:	8556                	mv	a0,s5
 6f0:	00000097          	auipc	ra,0x0
 6f4:	e86080e7          	jalr	-378(ra) # 576 <putc>
      }
      state = 0;
 6f8:	4981                	li	s3,0
 6fa:	b765                	j	6a2 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 6fc:	008b0913          	addi	s2,s6,8
 700:	4685                	li	a3,1
 702:	4629                	li	a2,10
 704:	000b2583          	lw	a1,0(s6)
 708:	8556                	mv	a0,s5
 70a:	00000097          	auipc	ra,0x0
 70e:	e8e080e7          	jalr	-370(ra) # 598 <printint>
 712:	8b4a                	mv	s6,s2
      state = 0;
 714:	4981                	li	s3,0
 716:	b771                	j	6a2 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 718:	008b0913          	addi	s2,s6,8
 71c:	4681                	li	a3,0
 71e:	4629                	li	a2,10
 720:	000b2583          	lw	a1,0(s6)
 724:	8556                	mv	a0,s5
 726:	00000097          	auipc	ra,0x0
 72a:	e72080e7          	jalr	-398(ra) # 598 <printint>
 72e:	8b4a                	mv	s6,s2
      state = 0;
 730:	4981                	li	s3,0
 732:	bf85                	j	6a2 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 734:	008b0913          	addi	s2,s6,8
 738:	4681                	li	a3,0
 73a:	4641                	li	a2,16
 73c:	000b2583          	lw	a1,0(s6)
 740:	8556                	mv	a0,s5
 742:	00000097          	auipc	ra,0x0
 746:	e56080e7          	jalr	-426(ra) # 598 <printint>
 74a:	8b4a                	mv	s6,s2
      state = 0;
 74c:	4981                	li	s3,0
 74e:	bf91                	j	6a2 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 750:	008b0793          	addi	a5,s6,8
 754:	f8f43423          	sd	a5,-120(s0)
 758:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 75c:	03000593          	li	a1,48
 760:	8556                	mv	a0,s5
 762:	00000097          	auipc	ra,0x0
 766:	e14080e7          	jalr	-492(ra) # 576 <putc>
  putc(fd, 'x');
 76a:	85ea                	mv	a1,s10
 76c:	8556                	mv	a0,s5
 76e:	00000097          	auipc	ra,0x0
 772:	e08080e7          	jalr	-504(ra) # 576 <putc>
 776:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 778:	03c9d793          	srli	a5,s3,0x3c
 77c:	97de                	add	a5,a5,s7
 77e:	0007c583          	lbu	a1,0(a5)
 782:	8556                	mv	a0,s5
 784:	00000097          	auipc	ra,0x0
 788:	df2080e7          	jalr	-526(ra) # 576 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 78c:	0992                	slli	s3,s3,0x4
 78e:	397d                	addiw	s2,s2,-1
 790:	fe0914e3          	bnez	s2,778 <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 794:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 798:	4981                	li	s3,0
 79a:	b721                	j	6a2 <vprintf+0x60>
        s = va_arg(ap, char*);
 79c:	008b0993          	addi	s3,s6,8
 7a0:	000b3903          	ld	s2,0(s6)
        if(s == 0)
 7a4:	02090163          	beqz	s2,7c6 <vprintf+0x184>
        while(*s != 0){
 7a8:	00094583          	lbu	a1,0(s2)
 7ac:	c9a1                	beqz	a1,7fc <vprintf+0x1ba>
          putc(fd, *s);
 7ae:	8556                	mv	a0,s5
 7b0:	00000097          	auipc	ra,0x0
 7b4:	dc6080e7          	jalr	-570(ra) # 576 <putc>
          s++;
 7b8:	0905                	addi	s2,s2,1
        while(*s != 0){
 7ba:	00094583          	lbu	a1,0(s2)
 7be:	f9e5                	bnez	a1,7ae <vprintf+0x16c>
        s = va_arg(ap, char*);
 7c0:	8b4e                	mv	s6,s3
      state = 0;
 7c2:	4981                	li	s3,0
 7c4:	bdf9                	j	6a2 <vprintf+0x60>
          s = "(null)";
 7c6:	00000917          	auipc	s2,0x0
 7ca:	28a90913          	addi	s2,s2,650 # a50 <malloc+0x144>
        while(*s != 0){
 7ce:	02800593          	li	a1,40
 7d2:	bff1                	j	7ae <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
 7d4:	008b0913          	addi	s2,s6,8
 7d8:	000b4583          	lbu	a1,0(s6)
 7dc:	8556                	mv	a0,s5
 7de:	00000097          	auipc	ra,0x0
 7e2:	d98080e7          	jalr	-616(ra) # 576 <putc>
 7e6:	8b4a                	mv	s6,s2
      state = 0;
 7e8:	4981                	li	s3,0
 7ea:	bd65                	j	6a2 <vprintf+0x60>
        putc(fd, c);
 7ec:	85d2                	mv	a1,s4
 7ee:	8556                	mv	a0,s5
 7f0:	00000097          	auipc	ra,0x0
 7f4:	d86080e7          	jalr	-634(ra) # 576 <putc>
      state = 0;
 7f8:	4981                	li	s3,0
 7fa:	b565                	j	6a2 <vprintf+0x60>
        s = va_arg(ap, char*);
 7fc:	8b4e                	mv	s6,s3
      state = 0;
 7fe:	4981                	li	s3,0
 800:	b54d                	j	6a2 <vprintf+0x60>
    }
  }
}
 802:	70e6                	ld	ra,120(sp)
 804:	7446                	ld	s0,112(sp)
 806:	74a6                	ld	s1,104(sp)
 808:	7906                	ld	s2,96(sp)
 80a:	69e6                	ld	s3,88(sp)
 80c:	6a46                	ld	s4,80(sp)
 80e:	6aa6                	ld	s5,72(sp)
 810:	6b06                	ld	s6,64(sp)
 812:	7be2                	ld	s7,56(sp)
 814:	7c42                	ld	s8,48(sp)
 816:	7ca2                	ld	s9,40(sp)
 818:	7d02                	ld	s10,32(sp)
 81a:	6de2                	ld	s11,24(sp)
 81c:	6109                	addi	sp,sp,128
 81e:	8082                	ret

0000000000000820 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 820:	715d                	addi	sp,sp,-80
 822:	ec06                	sd	ra,24(sp)
 824:	e822                	sd	s0,16(sp)
 826:	1000                	addi	s0,sp,32
 828:	e010                	sd	a2,0(s0)
 82a:	e414                	sd	a3,8(s0)
 82c:	e818                	sd	a4,16(s0)
 82e:	ec1c                	sd	a5,24(s0)
 830:	03043023          	sd	a6,32(s0)
 834:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 838:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 83c:	8622                	mv	a2,s0
 83e:	00000097          	auipc	ra,0x0
 842:	e04080e7          	jalr	-508(ra) # 642 <vprintf>
}
 846:	60e2                	ld	ra,24(sp)
 848:	6442                	ld	s0,16(sp)
 84a:	6161                	addi	sp,sp,80
 84c:	8082                	ret

000000000000084e <printf>:

void
printf(const char *fmt, ...)
{
 84e:	711d                	addi	sp,sp,-96
 850:	ec06                	sd	ra,24(sp)
 852:	e822                	sd	s0,16(sp)
 854:	1000                	addi	s0,sp,32
 856:	e40c                	sd	a1,8(s0)
 858:	e810                	sd	a2,16(s0)
 85a:	ec14                	sd	a3,24(s0)
 85c:	f018                	sd	a4,32(s0)
 85e:	f41c                	sd	a5,40(s0)
 860:	03043823          	sd	a6,48(s0)
 864:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 868:	00840613          	addi	a2,s0,8
 86c:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 870:	85aa                	mv	a1,a0
 872:	4505                	li	a0,1
 874:	00000097          	auipc	ra,0x0
 878:	dce080e7          	jalr	-562(ra) # 642 <vprintf>
}
 87c:	60e2                	ld	ra,24(sp)
 87e:	6442                	ld	s0,16(sp)
 880:	6125                	addi	sp,sp,96
 882:	8082                	ret

0000000000000884 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 884:	1141                	addi	sp,sp,-16
 886:	e422                	sd	s0,8(sp)
 888:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 88a:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 88e:	00000797          	auipc	a5,0x0
 892:	1e27b783          	ld	a5,482(a5) # a70 <freep>
 896:	a805                	j	8c6 <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 898:	4618                	lw	a4,8(a2)
 89a:	9db9                	addw	a1,a1,a4
 89c:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 8a0:	6398                	ld	a4,0(a5)
 8a2:	6318                	ld	a4,0(a4)
 8a4:	fee53823          	sd	a4,-16(a0)
 8a8:	a091                	j	8ec <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 8aa:	ff852703          	lw	a4,-8(a0)
 8ae:	9e39                	addw	a2,a2,a4
 8b0:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 8b2:	ff053703          	ld	a4,-16(a0)
 8b6:	e398                	sd	a4,0(a5)
 8b8:	a099                	j	8fe <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8ba:	6398                	ld	a4,0(a5)
 8bc:	00e7e463          	bltu	a5,a4,8c4 <free+0x40>
 8c0:	00e6ea63          	bltu	a3,a4,8d4 <free+0x50>
{
 8c4:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8c6:	fed7fae3          	bgeu	a5,a3,8ba <free+0x36>
 8ca:	6398                	ld	a4,0(a5)
 8cc:	00e6e463          	bltu	a3,a4,8d4 <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8d0:	fee7eae3          	bltu	a5,a4,8c4 <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
 8d4:	ff852583          	lw	a1,-8(a0)
 8d8:	6390                	ld	a2,0(a5)
 8da:	02059713          	slli	a4,a1,0x20
 8de:	9301                	srli	a4,a4,0x20
 8e0:	0712                	slli	a4,a4,0x4
 8e2:	9736                	add	a4,a4,a3
 8e4:	fae60ae3          	beq	a2,a4,898 <free+0x14>
    bp->s.ptr = p->s.ptr;
 8e8:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 8ec:	4790                	lw	a2,8(a5)
 8ee:	02061713          	slli	a4,a2,0x20
 8f2:	9301                	srli	a4,a4,0x20
 8f4:	0712                	slli	a4,a4,0x4
 8f6:	973e                	add	a4,a4,a5
 8f8:	fae689e3          	beq	a3,a4,8aa <free+0x26>
  } else
    p->s.ptr = bp;
 8fc:	e394                	sd	a3,0(a5)
  freep = p;
 8fe:	00000717          	auipc	a4,0x0
 902:	16f73923          	sd	a5,370(a4) # a70 <freep>
}
 906:	6422                	ld	s0,8(sp)
 908:	0141                	addi	sp,sp,16
 90a:	8082                	ret

000000000000090c <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 90c:	7139                	addi	sp,sp,-64
 90e:	fc06                	sd	ra,56(sp)
 910:	f822                	sd	s0,48(sp)
 912:	f426                	sd	s1,40(sp)
 914:	f04a                	sd	s2,32(sp)
 916:	ec4e                	sd	s3,24(sp)
 918:	e852                	sd	s4,16(sp)
 91a:	e456                	sd	s5,8(sp)
 91c:	e05a                	sd	s6,0(sp)
 91e:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 920:	02051493          	slli	s1,a0,0x20
 924:	9081                	srli	s1,s1,0x20
 926:	04bd                	addi	s1,s1,15
 928:	8091                	srli	s1,s1,0x4
 92a:	0014899b          	addiw	s3,s1,1
 92e:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 930:	00000517          	auipc	a0,0x0
 934:	14053503          	ld	a0,320(a0) # a70 <freep>
 938:	c515                	beqz	a0,964 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 93a:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 93c:	4798                	lw	a4,8(a5)
 93e:	02977f63          	bgeu	a4,s1,97c <malloc+0x70>
 942:	8a4e                	mv	s4,s3
 944:	0009871b          	sext.w	a4,s3
 948:	6685                	lui	a3,0x1
 94a:	00d77363          	bgeu	a4,a3,950 <malloc+0x44>
 94e:	6a05                	lui	s4,0x1
 950:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 954:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 958:	00000917          	auipc	s2,0x0
 95c:	11890913          	addi	s2,s2,280 # a70 <freep>
  if(p == (char*)-1)
 960:	5afd                	li	s5,-1
 962:	a88d                	j	9d4 <malloc+0xc8>
    base.s.ptr = freep = prevp = &base;
 964:	00000797          	auipc	a5,0x0
 968:	12478793          	addi	a5,a5,292 # a88 <base>
 96c:	00000717          	auipc	a4,0x0
 970:	10f73223          	sd	a5,260(a4) # a70 <freep>
 974:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 976:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 97a:	b7e1                	j	942 <malloc+0x36>
      if(p->s.size == nunits)
 97c:	02e48b63          	beq	s1,a4,9b2 <malloc+0xa6>
        p->s.size -= nunits;
 980:	4137073b          	subw	a4,a4,s3
 984:	c798                	sw	a4,8(a5)
        p += p->s.size;
 986:	1702                	slli	a4,a4,0x20
 988:	9301                	srli	a4,a4,0x20
 98a:	0712                	slli	a4,a4,0x4
 98c:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 98e:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 992:	00000717          	auipc	a4,0x0
 996:	0ca73f23          	sd	a0,222(a4) # a70 <freep>
      return (void*)(p + 1);
 99a:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 99e:	70e2                	ld	ra,56(sp)
 9a0:	7442                	ld	s0,48(sp)
 9a2:	74a2                	ld	s1,40(sp)
 9a4:	7902                	ld	s2,32(sp)
 9a6:	69e2                	ld	s3,24(sp)
 9a8:	6a42                	ld	s4,16(sp)
 9aa:	6aa2                	ld	s5,8(sp)
 9ac:	6b02                	ld	s6,0(sp)
 9ae:	6121                	addi	sp,sp,64
 9b0:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 9b2:	6398                	ld	a4,0(a5)
 9b4:	e118                	sd	a4,0(a0)
 9b6:	bff1                	j	992 <malloc+0x86>
  hp->s.size = nu;
 9b8:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 9bc:	0541                	addi	a0,a0,16
 9be:	00000097          	auipc	ra,0x0
 9c2:	ec6080e7          	jalr	-314(ra) # 884 <free>
  return freep;
 9c6:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 9ca:	d971                	beqz	a0,99e <malloc+0x92>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9cc:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 9ce:	4798                	lw	a4,8(a5)
 9d0:	fa9776e3          	bgeu	a4,s1,97c <malloc+0x70>
    if(p == freep)
 9d4:	00093703          	ld	a4,0(s2)
 9d8:	853e                	mv	a0,a5
 9da:	fef719e3          	bne	a4,a5,9cc <malloc+0xc0>
  p = sbrk(nu * sizeof(Header));
 9de:	8552                	mv	a0,s4
 9e0:	00000097          	auipc	ra,0x0
 9e4:	b7e080e7          	jalr	-1154(ra) # 55e <sbrk>
  if(p == (char*)-1)
 9e8:	fd5518e3          	bne	a0,s5,9b8 <malloc+0xac>
        return 0;
 9ec:	4501                	li	a0,0
 9ee:	bf45                	j	99e <malloc+0x92>
