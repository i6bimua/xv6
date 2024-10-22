
user/_xargs:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <readline>:
#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"
#include "kernel/param.h"

int readline(char *new_argv[32], int curr_argc) {
   0:	bc010113          	addi	sp,sp,-1088
   4:	42113c23          	sd	ra,1080(sp)
   8:	42813823          	sd	s0,1072(sp)
   c:	42913423          	sd	s1,1064(sp)
  10:	43213023          	sd	s2,1056(sp)
  14:	41313c23          	sd	s3,1048(sp)
  18:	41413823          	sd	s4,1040(sp)
  1c:	41513423          	sd	s5,1032(sp)
  20:	41613023          	sd	s6,1024(sp)
  24:	44010413          	addi	s0,sp,1088
  28:	8b2a                	mv	s6,a0
  2a:	89ae                	mv	s3,a1
    char buf[1024];
    int n = 0;
    while (read(0, buf + n, 1) == 1) {
  2c:	bc040913          	addi	s2,s0,-1088
    int n = 0;
  30:	4481                	li	s1,0
        if (n == 1023) {
  32:	3ff00a13          	li	s4,1023
            fprintf(2, "argument is too long\n");
            exit(-1);
        }
        if (buf[n] == '\n') {
  36:	4aa9                	li	s5,10
    while (read(0, buf + n, 1) == 1) {
  38:	4605                	li	a2,1
  3a:	85ca                	mv	a1,s2
  3c:	4501                	li	a0,0
  3e:	00000097          	auipc	ra,0x0
  42:	498080e7          	jalr	1176(ra) # 4d6 <read>
  46:	4785                	li	a5,1
  48:	02f51963          	bne	a0,a5,7a <readline+0x7a>
        if (n == 1023) {
  4c:	01448963          	beq	s1,s4,5e <readline+0x5e>
        if (buf[n] == '\n') {
  50:	0905                	addi	s2,s2,1
  52:	fff94783          	lbu	a5,-1(s2)
  56:	03578263          	beq	a5,s5,7a <readline+0x7a>
            break;
        }
        n++;
  5a:	2485                	addiw	s1,s1,1
  5c:	bff1                	j	38 <readline+0x38>
            fprintf(2, "argument is too long\n");
  5e:	00001597          	auipc	a1,0x1
  62:	97a58593          	addi	a1,a1,-1670 # 9d8 <malloc+0xe4>
  66:	4509                	li	a0,2
  68:	00000097          	auipc	ra,0x0
  6c:	7a0080e7          	jalr	1952(ra) # 808 <fprintf>
            exit(-1);
  70:	557d                	li	a0,-1
  72:	00000097          	auipc	ra,0x0
  76:	44c080e7          	jalr	1100(ra) # 4be <exit>
    }
    buf[n] = 0;
  7a:	fc040793          	addi	a5,s0,-64
  7e:	97a6                	add	a5,a5,s1
  80:	c0078023          	sb	zero,-1024(a5)
    if (n == 0)
  84:	c4bd                	beqz	s1,f2 <readline+0xf2>
        return 0;
    int offset = 0;
    while (offset < n) {
  86:	04905463          	blez	s1,ce <readline+0xce>
  8a:	00399593          	slli	a1,s3,0x3
  8e:	95da                	add	a1,a1,s6
    int offset = 0;
  90:	4781                	li	a5,0
        new_argv[curr_argc++] = buf + offset;
        while (buf[offset] != ' ' && offset < n) {
  92:	02000693          	li	a3,32
  96:	a021                	j	9e <readline+0x9e>
    while (offset < n) {
  98:	05a1                	addi	a1,a1,8
  9a:	0297d863          	bge	a5,s1,ca <readline+0xca>
        new_argv[curr_argc++] = buf + offset;
  9e:	2985                	addiw	s3,s3,1
  a0:	bc040713          	addi	a4,s0,-1088
  a4:	973e                	add	a4,a4,a5
  a6:	e198                	sd	a4,0(a1)
        while (buf[offset] != ' ' && offset < n) {
  a8:	fc040613          	addi	a2,s0,-64
  ac:	963e                	add	a2,a2,a5
  ae:	c0064603          	lbu	a2,-1024(a2)
  b2:	02d60063          	beq	a2,a3,d2 <readline+0xd2>
  b6:	0097da63          	bge	a5,s1,ca <readline+0xca>
            offset++;
  ba:	2785                	addiw	a5,a5,1
        while (buf[offset] != ' ' && offset < n) {
  bc:	00174603          	lbu	a2,1(a4)
  c0:	00d60963          	beq	a2,a3,d2 <readline+0xd2>
  c4:	0705                	addi	a4,a4,1
  c6:	fef49ae3          	bne	s1,a5,ba <readline+0xba>
        new_argv[curr_argc++] = buf + offset;
  ca:	84ce                	mv	s1,s3
  cc:	a01d                	j	f2 <readline+0xf2>
    while (offset < n) {
  ce:	84ce                	mv	s1,s3
  d0:	a00d                	j	f2 <readline+0xf2>
        }
        while (buf[offset] == ' ' && offset < n) {
  d2:	0097df63          	bge	a5,s1,f0 <readline+0xf0>
  d6:	bc040713          	addi	a4,s0,-1088
  da:	973e                	add	a4,a4,a5
            buf[offset++] = 0;
  dc:	2785                	addiw	a5,a5,1
  de:	00070023          	sb	zero,0(a4)
        while (buf[offset] == ' ' && offset < n) {
  e2:	00174603          	lbu	a2,1(a4)
  e6:	fad619e3          	bne	a2,a3,98 <readline+0x98>
  ea:	0705                	addi	a4,a4,1
  ec:	fef498e3          	bne	s1,a5,dc <readline+0xdc>
    int offset = 0;
  f0:	84ce                	mv	s1,s3
        }
    }
    return curr_argc;
}
  f2:	8526                	mv	a0,s1
  f4:	43813083          	ld	ra,1080(sp)
  f8:	43013403          	ld	s0,1072(sp)
  fc:	42813483          	ld	s1,1064(sp)
 100:	42013903          	ld	s2,1056(sp)
 104:	41813983          	ld	s3,1048(sp)
 108:	41013a03          	ld	s4,1040(sp)
 10c:	40813a83          	ld	s5,1032(sp)
 110:	40013b03          	ld	s6,1024(sp)
 114:	44010113          	addi	sp,sp,1088
 118:	8082                	ret

000000000000011a <main>:

int main(int argc, char const *argv[]) {
 11a:	7129                	addi	sp,sp,-320
 11c:	fe06                	sd	ra,312(sp)
 11e:	fa22                	sd	s0,304(sp)
 120:	f626                	sd	s1,296(sp)
 122:	f24a                	sd	s2,288(sp)
 124:	ee4e                	sd	s3,280(sp)
 126:	ea52                	sd	s4,272(sp)
 128:	e656                	sd	s5,264(sp)
 12a:	e25a                	sd	s6,256(sp)
 12c:	0280                	addi	s0,sp,320
    if (argc < 2) {
 12e:	4785                	li	a5,1
 130:	06a7d863          	bge	a5,a0,1a0 <main+0x86>
 134:	8a2a                	mv	s4,a0
 136:	8b2e                	mv	s6,a1
        printf("Usage: xargs [command]\n");
        exit(-1);
    }
    char *command = malloc(strlen(argv[1]) + 1);
 138:	6588                	ld	a0,8(a1)
 13a:	00000097          	auipc	ra,0x0
 13e:	156080e7          	jalr	342(ra) # 290 <strlen>
 142:	2505                	addiw	a0,a0,1
 144:	00000097          	auipc	ra,0x0
 148:	7b0080e7          	jalr	1968(ra) # 8f4 <malloc>
 14c:	89aa                	mv	s3,a0
    char *new_argv[MAXARG];
    strcpy(command, argv[1]);
 14e:	008b3583          	ld	a1,8(s6)
 152:	00000097          	auipc	ra,0x0
 156:	0f6080e7          	jalr	246(ra) # 248 <strcpy>
    for (int i = 1; i < argc; ++i) {
 15a:	008b0493          	addi	s1,s6,8
 15e:	ec040913          	addi	s2,s0,-320
 162:	ffea0a9b          	addiw	s5,s4,-2
 166:	1a82                	slli	s5,s5,0x20
 168:	020ada93          	srli	s5,s5,0x20
 16c:	0a8e                	slli	s5,s5,0x3
 16e:	0b41                	addi	s6,s6,16
 170:	9ada                	add	s5,s5,s6
        new_argv[i - 1] = malloc(strlen(argv[i]) + 1);
 172:	6088                	ld	a0,0(s1)
 174:	00000097          	auipc	ra,0x0
 178:	11c080e7          	jalr	284(ra) # 290 <strlen>
 17c:	2505                	addiw	a0,a0,1
 17e:	00000097          	auipc	ra,0x0
 182:	776080e7          	jalr	1910(ra) # 8f4 <malloc>
 186:	00a93023          	sd	a0,0(s2)
        strcpy(new_argv[i - 1], argv[i]);
 18a:	608c                	ld	a1,0(s1)
 18c:	00000097          	auipc	ra,0x0
 190:	0bc080e7          	jalr	188(ra) # 248 <strcpy>
    for (int i = 1; i < argc; ++i) {
 194:	04a1                	addi	s1,s1,8
 196:	0921                	addi	s2,s2,8
 198:	fd549de3          	bne	s1,s5,172 <main+0x58>
    }

    int curr_argc;
    while ((curr_argc = readline(new_argv, argc - 1)) != 0) {
 19c:	3a7d                	addiw	s4,s4,-1
 19e:	a089                	j	1e0 <main+0xc6>
        printf("Usage: xargs [command]\n");
 1a0:	00001517          	auipc	a0,0x1
 1a4:	85050513          	addi	a0,a0,-1968 # 9f0 <malloc+0xfc>
 1a8:	00000097          	auipc	ra,0x0
 1ac:	68e080e7          	jalr	1678(ra) # 836 <printf>
        exit(-1);
 1b0:	557d                	li	a0,-1
 1b2:	00000097          	auipc	ra,0x0
 1b6:	30c080e7          	jalr	780(ra) # 4be <exit>
        new_argv[curr_argc] = 0;
        int pid = fork();
        if (pid < 0) {
            fprintf(2, "fork failed\n");
 1ba:	00001597          	auipc	a1,0x1
 1be:	84e58593          	addi	a1,a1,-1970 # a08 <malloc+0x114>
 1c2:	4509                	li	a0,2
 1c4:	00000097          	auipc	ra,0x0
 1c8:	644080e7          	jalr	1604(ra) # 808 <fprintf>
            exit(-1);
 1cc:	557d                	li	a0,-1
 1ce:	00000097          	auipc	ra,0x0
 1d2:	2f0080e7          	jalr	752(ra) # 4be <exit>
        if (pid == 0) {
            exec(command, new_argv);
            fprintf(2, "exec failed\n");
            exit(-1);
        }
        wait(0);
 1d6:	4501                	li	a0,0
 1d8:	00000097          	auipc	ra,0x0
 1dc:	2ee080e7          	jalr	750(ra) # 4c6 <wait>
    while ((curr_argc = readline(new_argv, argc - 1)) != 0) {
 1e0:	85d2                	mv	a1,s4
 1e2:	ec040513          	addi	a0,s0,-320
 1e6:	00000097          	auipc	ra,0x0
 1ea:	e1a080e7          	jalr	-486(ra) # 0 <readline>
 1ee:	c139                	beqz	a0,234 <main+0x11a>
        new_argv[curr_argc] = 0;
 1f0:	050e                	slli	a0,a0,0x3
 1f2:	fc040793          	addi	a5,s0,-64
 1f6:	953e                	add	a0,a0,a5
 1f8:	f0053023          	sd	zero,-256(a0)
        int pid = fork();
 1fc:	00000097          	auipc	ra,0x0
 200:	2ba080e7          	jalr	698(ra) # 4b6 <fork>
        if (pid < 0) {
 204:	fa054be3          	bltz	a0,1ba <main+0xa0>
        if (pid == 0) {
 208:	f579                	bnez	a0,1d6 <main+0xbc>
            exec(command, new_argv);
 20a:	ec040593          	addi	a1,s0,-320
 20e:	854e                	mv	a0,s3
 210:	00000097          	auipc	ra,0x0
 214:	2e6080e7          	jalr	742(ra) # 4f6 <exec>
            fprintf(2, "exec failed\n");
 218:	00001597          	auipc	a1,0x1
 21c:	80058593          	addi	a1,a1,-2048 # a18 <malloc+0x124>
 220:	4509                	li	a0,2
 222:	00000097          	auipc	ra,0x0
 226:	5e6080e7          	jalr	1510(ra) # 808 <fprintf>
            exit(-1);
 22a:	557d                	li	a0,-1
 22c:	00000097          	auipc	ra,0x0
 230:	292080e7          	jalr	658(ra) # 4be <exit>
    }
    for (int i = 0; i < curr_argc; ++i) {
        free(new_argv[i]);
    }
    free(command);
 234:	854e                	mv	a0,s3
 236:	00000097          	auipc	ra,0x0
 23a:	636080e7          	jalr	1590(ra) # 86c <free>
    exit(0);
 23e:	4501                	li	a0,0
 240:	00000097          	auipc	ra,0x0
 244:	27e080e7          	jalr	638(ra) # 4be <exit>

0000000000000248 <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
 248:	1141                	addi	sp,sp,-16
 24a:	e422                	sd	s0,8(sp)
 24c:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 24e:	87aa                	mv	a5,a0
 250:	0585                	addi	a1,a1,1
 252:	0785                	addi	a5,a5,1
 254:	fff5c703          	lbu	a4,-1(a1)
 258:	fee78fa3          	sb	a4,-1(a5)
 25c:	fb75                	bnez	a4,250 <strcpy+0x8>
    ;
  return os;
}
 25e:	6422                	ld	s0,8(sp)
 260:	0141                	addi	sp,sp,16
 262:	8082                	ret

0000000000000264 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 264:	1141                	addi	sp,sp,-16
 266:	e422                	sd	s0,8(sp)
 268:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 26a:	00054783          	lbu	a5,0(a0)
 26e:	cb91                	beqz	a5,282 <strcmp+0x1e>
 270:	0005c703          	lbu	a4,0(a1)
 274:	00f71763          	bne	a4,a5,282 <strcmp+0x1e>
    p++, q++;
 278:	0505                	addi	a0,a0,1
 27a:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 27c:	00054783          	lbu	a5,0(a0)
 280:	fbe5                	bnez	a5,270 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 282:	0005c503          	lbu	a0,0(a1)
}
 286:	40a7853b          	subw	a0,a5,a0
 28a:	6422                	ld	s0,8(sp)
 28c:	0141                	addi	sp,sp,16
 28e:	8082                	ret

0000000000000290 <strlen>:

uint
strlen(const char *s)
{
 290:	1141                	addi	sp,sp,-16
 292:	e422                	sd	s0,8(sp)
 294:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 296:	00054783          	lbu	a5,0(a0)
 29a:	cf91                	beqz	a5,2b6 <strlen+0x26>
 29c:	0505                	addi	a0,a0,1
 29e:	87aa                	mv	a5,a0
 2a0:	4685                	li	a3,1
 2a2:	9e89                	subw	a3,a3,a0
 2a4:	00f6853b          	addw	a0,a3,a5
 2a8:	0785                	addi	a5,a5,1
 2aa:	fff7c703          	lbu	a4,-1(a5)
 2ae:	fb7d                	bnez	a4,2a4 <strlen+0x14>
    ;
  return n;
}
 2b0:	6422                	ld	s0,8(sp)
 2b2:	0141                	addi	sp,sp,16
 2b4:	8082                	ret
  for(n = 0; s[n]; n++)
 2b6:	4501                	li	a0,0
 2b8:	bfe5                	j	2b0 <strlen+0x20>

00000000000002ba <memset>:

void*
memset(void *dst, int c, uint n)
{
 2ba:	1141                	addi	sp,sp,-16
 2bc:	e422                	sd	s0,8(sp)
 2be:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 2c0:	ce09                	beqz	a2,2da <memset+0x20>
 2c2:	87aa                	mv	a5,a0
 2c4:	fff6071b          	addiw	a4,a2,-1
 2c8:	1702                	slli	a4,a4,0x20
 2ca:	9301                	srli	a4,a4,0x20
 2cc:	0705                	addi	a4,a4,1
 2ce:	972a                	add	a4,a4,a0
    cdst[i] = c;
 2d0:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 2d4:	0785                	addi	a5,a5,1
 2d6:	fee79de3          	bne	a5,a4,2d0 <memset+0x16>
  }
  return dst;
}
 2da:	6422                	ld	s0,8(sp)
 2dc:	0141                	addi	sp,sp,16
 2de:	8082                	ret

00000000000002e0 <strchr>:

char*
strchr(const char *s, char c)
{
 2e0:	1141                	addi	sp,sp,-16
 2e2:	e422                	sd	s0,8(sp)
 2e4:	0800                	addi	s0,sp,16
  for(; *s; s++)
 2e6:	00054783          	lbu	a5,0(a0)
 2ea:	cb99                	beqz	a5,300 <strchr+0x20>
    if(*s == c)
 2ec:	00f58763          	beq	a1,a5,2fa <strchr+0x1a>
  for(; *s; s++)
 2f0:	0505                	addi	a0,a0,1
 2f2:	00054783          	lbu	a5,0(a0)
 2f6:	fbfd                	bnez	a5,2ec <strchr+0xc>
      return (char*)s;
  return 0;
 2f8:	4501                	li	a0,0
}
 2fa:	6422                	ld	s0,8(sp)
 2fc:	0141                	addi	sp,sp,16
 2fe:	8082                	ret
  return 0;
 300:	4501                	li	a0,0
 302:	bfe5                	j	2fa <strchr+0x1a>

0000000000000304 <gets>:

char*
gets(char *buf, int max)
{
 304:	711d                	addi	sp,sp,-96
 306:	ec86                	sd	ra,88(sp)
 308:	e8a2                	sd	s0,80(sp)
 30a:	e4a6                	sd	s1,72(sp)
 30c:	e0ca                	sd	s2,64(sp)
 30e:	fc4e                	sd	s3,56(sp)
 310:	f852                	sd	s4,48(sp)
 312:	f456                	sd	s5,40(sp)
 314:	f05a                	sd	s6,32(sp)
 316:	ec5e                	sd	s7,24(sp)
 318:	1080                	addi	s0,sp,96
 31a:	8baa                	mv	s7,a0
 31c:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 31e:	892a                	mv	s2,a0
 320:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 322:	4aa9                	li	s5,10
 324:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 326:	89a6                	mv	s3,s1
 328:	2485                	addiw	s1,s1,1
 32a:	0344d863          	bge	s1,s4,35a <gets+0x56>
    cc = read(0, &c, 1);
 32e:	4605                	li	a2,1
 330:	faf40593          	addi	a1,s0,-81
 334:	4501                	li	a0,0
 336:	00000097          	auipc	ra,0x0
 33a:	1a0080e7          	jalr	416(ra) # 4d6 <read>
    if(cc < 1)
 33e:	00a05e63          	blez	a0,35a <gets+0x56>
    buf[i++] = c;
 342:	faf44783          	lbu	a5,-81(s0)
 346:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 34a:	01578763          	beq	a5,s5,358 <gets+0x54>
 34e:	0905                	addi	s2,s2,1
 350:	fd679be3          	bne	a5,s6,326 <gets+0x22>
  for(i=0; i+1 < max; ){
 354:	89a6                	mv	s3,s1
 356:	a011                	j	35a <gets+0x56>
 358:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 35a:	99de                	add	s3,s3,s7
 35c:	00098023          	sb	zero,0(s3)
  return buf;
}
 360:	855e                	mv	a0,s7
 362:	60e6                	ld	ra,88(sp)
 364:	6446                	ld	s0,80(sp)
 366:	64a6                	ld	s1,72(sp)
 368:	6906                	ld	s2,64(sp)
 36a:	79e2                	ld	s3,56(sp)
 36c:	7a42                	ld	s4,48(sp)
 36e:	7aa2                	ld	s5,40(sp)
 370:	7b02                	ld	s6,32(sp)
 372:	6be2                	ld	s7,24(sp)
 374:	6125                	addi	sp,sp,96
 376:	8082                	ret

0000000000000378 <stat>:

int
stat(const char *n, struct stat *st)
{
 378:	1101                	addi	sp,sp,-32
 37a:	ec06                	sd	ra,24(sp)
 37c:	e822                	sd	s0,16(sp)
 37e:	e426                	sd	s1,8(sp)
 380:	e04a                	sd	s2,0(sp)
 382:	1000                	addi	s0,sp,32
 384:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 386:	4581                	li	a1,0
 388:	00000097          	auipc	ra,0x0
 38c:	176080e7          	jalr	374(ra) # 4fe <open>
  if(fd < 0)
 390:	02054563          	bltz	a0,3ba <stat+0x42>
 394:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 396:	85ca                	mv	a1,s2
 398:	00000097          	auipc	ra,0x0
 39c:	17e080e7          	jalr	382(ra) # 516 <fstat>
 3a0:	892a                	mv	s2,a0
  close(fd);
 3a2:	8526                	mv	a0,s1
 3a4:	00000097          	auipc	ra,0x0
 3a8:	142080e7          	jalr	322(ra) # 4e6 <close>
  return r;
}
 3ac:	854a                	mv	a0,s2
 3ae:	60e2                	ld	ra,24(sp)
 3b0:	6442                	ld	s0,16(sp)
 3b2:	64a2                	ld	s1,8(sp)
 3b4:	6902                	ld	s2,0(sp)
 3b6:	6105                	addi	sp,sp,32
 3b8:	8082                	ret
    return -1;
 3ba:	597d                	li	s2,-1
 3bc:	bfc5                	j	3ac <stat+0x34>

00000000000003be <atoi>:

int
atoi(const char *s)
{
 3be:	1141                	addi	sp,sp,-16
 3c0:	e422                	sd	s0,8(sp)
 3c2:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 3c4:	00054603          	lbu	a2,0(a0)
 3c8:	fd06079b          	addiw	a5,a2,-48
 3cc:	0ff7f793          	andi	a5,a5,255
 3d0:	4725                	li	a4,9
 3d2:	02f76963          	bltu	a4,a5,404 <atoi+0x46>
 3d6:	86aa                	mv	a3,a0
  n = 0;
 3d8:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 3da:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 3dc:	0685                	addi	a3,a3,1
 3de:	0025179b          	slliw	a5,a0,0x2
 3e2:	9fa9                	addw	a5,a5,a0
 3e4:	0017979b          	slliw	a5,a5,0x1
 3e8:	9fb1                	addw	a5,a5,a2
 3ea:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 3ee:	0006c603          	lbu	a2,0(a3)
 3f2:	fd06071b          	addiw	a4,a2,-48
 3f6:	0ff77713          	andi	a4,a4,255
 3fa:	fee5f1e3          	bgeu	a1,a4,3dc <atoi+0x1e>
  return n;
}
 3fe:	6422                	ld	s0,8(sp)
 400:	0141                	addi	sp,sp,16
 402:	8082                	ret
  n = 0;
 404:	4501                	li	a0,0
 406:	bfe5                	j	3fe <atoi+0x40>

0000000000000408 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 408:	1141                	addi	sp,sp,-16
 40a:	e422                	sd	s0,8(sp)
 40c:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 40e:	02b57663          	bgeu	a0,a1,43a <memmove+0x32>
    while(n-- > 0)
 412:	02c05163          	blez	a2,434 <memmove+0x2c>
 416:	fff6079b          	addiw	a5,a2,-1
 41a:	1782                	slli	a5,a5,0x20
 41c:	9381                	srli	a5,a5,0x20
 41e:	0785                	addi	a5,a5,1
 420:	97aa                	add	a5,a5,a0
  dst = vdst;
 422:	872a                	mv	a4,a0
      *dst++ = *src++;
 424:	0585                	addi	a1,a1,1
 426:	0705                	addi	a4,a4,1
 428:	fff5c683          	lbu	a3,-1(a1)
 42c:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 430:	fee79ae3          	bne	a5,a4,424 <memmove+0x1c>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 434:	6422                	ld	s0,8(sp)
 436:	0141                	addi	sp,sp,16
 438:	8082                	ret
    dst += n;
 43a:	00c50733          	add	a4,a0,a2
    src += n;
 43e:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 440:	fec05ae3          	blez	a2,434 <memmove+0x2c>
 444:	fff6079b          	addiw	a5,a2,-1
 448:	1782                	slli	a5,a5,0x20
 44a:	9381                	srli	a5,a5,0x20
 44c:	fff7c793          	not	a5,a5
 450:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 452:	15fd                	addi	a1,a1,-1
 454:	177d                	addi	a4,a4,-1
 456:	0005c683          	lbu	a3,0(a1)
 45a:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 45e:	fee79ae3          	bne	a5,a4,452 <memmove+0x4a>
 462:	bfc9                	j	434 <memmove+0x2c>

0000000000000464 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 464:	1141                	addi	sp,sp,-16
 466:	e422                	sd	s0,8(sp)
 468:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 46a:	ca05                	beqz	a2,49a <memcmp+0x36>
 46c:	fff6069b          	addiw	a3,a2,-1
 470:	1682                	slli	a3,a3,0x20
 472:	9281                	srli	a3,a3,0x20
 474:	0685                	addi	a3,a3,1
 476:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 478:	00054783          	lbu	a5,0(a0)
 47c:	0005c703          	lbu	a4,0(a1)
 480:	00e79863          	bne	a5,a4,490 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 484:	0505                	addi	a0,a0,1
    p2++;
 486:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 488:	fed518e3          	bne	a0,a3,478 <memcmp+0x14>
  }
  return 0;
 48c:	4501                	li	a0,0
 48e:	a019                	j	494 <memcmp+0x30>
      return *p1 - *p2;
 490:	40e7853b          	subw	a0,a5,a4
}
 494:	6422                	ld	s0,8(sp)
 496:	0141                	addi	sp,sp,16
 498:	8082                	ret
  return 0;
 49a:	4501                	li	a0,0
 49c:	bfe5                	j	494 <memcmp+0x30>

000000000000049e <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 49e:	1141                	addi	sp,sp,-16
 4a0:	e406                	sd	ra,8(sp)
 4a2:	e022                	sd	s0,0(sp)
 4a4:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 4a6:	00000097          	auipc	ra,0x0
 4aa:	f62080e7          	jalr	-158(ra) # 408 <memmove>
}
 4ae:	60a2                	ld	ra,8(sp)
 4b0:	6402                	ld	s0,0(sp)
 4b2:	0141                	addi	sp,sp,16
 4b4:	8082                	ret

00000000000004b6 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 4b6:	4885                	li	a7,1
 ecall
 4b8:	00000073          	ecall
 ret
 4bc:	8082                	ret

00000000000004be <exit>:
.global exit
exit:
 li a7, SYS_exit
 4be:	4889                	li	a7,2
 ecall
 4c0:	00000073          	ecall
 ret
 4c4:	8082                	ret

00000000000004c6 <wait>:
.global wait
wait:
 li a7, SYS_wait
 4c6:	488d                	li	a7,3
 ecall
 4c8:	00000073          	ecall
 ret
 4cc:	8082                	ret

00000000000004ce <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 4ce:	4891                	li	a7,4
 ecall
 4d0:	00000073          	ecall
 ret
 4d4:	8082                	ret

00000000000004d6 <read>:
.global read
read:
 li a7, SYS_read
 4d6:	4895                	li	a7,5
 ecall
 4d8:	00000073          	ecall
 ret
 4dc:	8082                	ret

00000000000004de <write>:
.global write
write:
 li a7, SYS_write
 4de:	48c1                	li	a7,16
 ecall
 4e0:	00000073          	ecall
 ret
 4e4:	8082                	ret

00000000000004e6 <close>:
.global close
close:
 li a7, SYS_close
 4e6:	48d5                	li	a7,21
 ecall
 4e8:	00000073          	ecall
 ret
 4ec:	8082                	ret

00000000000004ee <kill>:
.global kill
kill:
 li a7, SYS_kill
 4ee:	4899                	li	a7,6
 ecall
 4f0:	00000073          	ecall
 ret
 4f4:	8082                	ret

00000000000004f6 <exec>:
.global exec
exec:
 li a7, SYS_exec
 4f6:	489d                	li	a7,7
 ecall
 4f8:	00000073          	ecall
 ret
 4fc:	8082                	ret

00000000000004fe <open>:
.global open
open:
 li a7, SYS_open
 4fe:	48bd                	li	a7,15
 ecall
 500:	00000073          	ecall
 ret
 504:	8082                	ret

0000000000000506 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 506:	48c5                	li	a7,17
 ecall
 508:	00000073          	ecall
 ret
 50c:	8082                	ret

000000000000050e <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 50e:	48c9                	li	a7,18
 ecall
 510:	00000073          	ecall
 ret
 514:	8082                	ret

0000000000000516 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 516:	48a1                	li	a7,8
 ecall
 518:	00000073          	ecall
 ret
 51c:	8082                	ret

000000000000051e <link>:
.global link
link:
 li a7, SYS_link
 51e:	48cd                	li	a7,19
 ecall
 520:	00000073          	ecall
 ret
 524:	8082                	ret

0000000000000526 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 526:	48d1                	li	a7,20
 ecall
 528:	00000073          	ecall
 ret
 52c:	8082                	ret

000000000000052e <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 52e:	48a5                	li	a7,9
 ecall
 530:	00000073          	ecall
 ret
 534:	8082                	ret

0000000000000536 <dup>:
.global dup
dup:
 li a7, SYS_dup
 536:	48a9                	li	a7,10
 ecall
 538:	00000073          	ecall
 ret
 53c:	8082                	ret

000000000000053e <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 53e:	48ad                	li	a7,11
 ecall
 540:	00000073          	ecall
 ret
 544:	8082                	ret

0000000000000546 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 546:	48b1                	li	a7,12
 ecall
 548:	00000073          	ecall
 ret
 54c:	8082                	ret

000000000000054e <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 54e:	48b5                	li	a7,13
 ecall
 550:	00000073          	ecall
 ret
 554:	8082                	ret

0000000000000556 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 556:	48b9                	li	a7,14
 ecall
 558:	00000073          	ecall
 ret
 55c:	8082                	ret

000000000000055e <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 55e:	1101                	addi	sp,sp,-32
 560:	ec06                	sd	ra,24(sp)
 562:	e822                	sd	s0,16(sp)
 564:	1000                	addi	s0,sp,32
 566:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 56a:	4605                	li	a2,1
 56c:	fef40593          	addi	a1,s0,-17
 570:	00000097          	auipc	ra,0x0
 574:	f6e080e7          	jalr	-146(ra) # 4de <write>
}
 578:	60e2                	ld	ra,24(sp)
 57a:	6442                	ld	s0,16(sp)
 57c:	6105                	addi	sp,sp,32
 57e:	8082                	ret

0000000000000580 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 580:	7139                	addi	sp,sp,-64
 582:	fc06                	sd	ra,56(sp)
 584:	f822                	sd	s0,48(sp)
 586:	f426                	sd	s1,40(sp)
 588:	f04a                	sd	s2,32(sp)
 58a:	ec4e                	sd	s3,24(sp)
 58c:	0080                	addi	s0,sp,64
 58e:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 590:	c299                	beqz	a3,596 <printint+0x16>
 592:	0805c863          	bltz	a1,622 <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 596:	2581                	sext.w	a1,a1
  neg = 0;
 598:	4881                	li	a7,0
 59a:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 59e:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 5a0:	2601                	sext.w	a2,a2
 5a2:	00000517          	auipc	a0,0x0
 5a6:	48e50513          	addi	a0,a0,1166 # a30 <digits>
 5aa:	883a                	mv	a6,a4
 5ac:	2705                	addiw	a4,a4,1
 5ae:	02c5f7bb          	remuw	a5,a1,a2
 5b2:	1782                	slli	a5,a5,0x20
 5b4:	9381                	srli	a5,a5,0x20
 5b6:	97aa                	add	a5,a5,a0
 5b8:	0007c783          	lbu	a5,0(a5)
 5bc:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 5c0:	0005879b          	sext.w	a5,a1
 5c4:	02c5d5bb          	divuw	a1,a1,a2
 5c8:	0685                	addi	a3,a3,1
 5ca:	fec7f0e3          	bgeu	a5,a2,5aa <printint+0x2a>
  if(neg)
 5ce:	00088b63          	beqz	a7,5e4 <printint+0x64>
    buf[i++] = '-';
 5d2:	fd040793          	addi	a5,s0,-48
 5d6:	973e                	add	a4,a4,a5
 5d8:	02d00793          	li	a5,45
 5dc:	fef70823          	sb	a5,-16(a4)
 5e0:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 5e4:	02e05863          	blez	a4,614 <printint+0x94>
 5e8:	fc040793          	addi	a5,s0,-64
 5ec:	00e78933          	add	s2,a5,a4
 5f0:	fff78993          	addi	s3,a5,-1
 5f4:	99ba                	add	s3,s3,a4
 5f6:	377d                	addiw	a4,a4,-1
 5f8:	1702                	slli	a4,a4,0x20
 5fa:	9301                	srli	a4,a4,0x20
 5fc:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 600:	fff94583          	lbu	a1,-1(s2)
 604:	8526                	mv	a0,s1
 606:	00000097          	auipc	ra,0x0
 60a:	f58080e7          	jalr	-168(ra) # 55e <putc>
  while(--i >= 0)
 60e:	197d                	addi	s2,s2,-1
 610:	ff3918e3          	bne	s2,s3,600 <printint+0x80>
}
 614:	70e2                	ld	ra,56(sp)
 616:	7442                	ld	s0,48(sp)
 618:	74a2                	ld	s1,40(sp)
 61a:	7902                	ld	s2,32(sp)
 61c:	69e2                	ld	s3,24(sp)
 61e:	6121                	addi	sp,sp,64
 620:	8082                	ret
    x = -xx;
 622:	40b005bb          	negw	a1,a1
    neg = 1;
 626:	4885                	li	a7,1
    x = -xx;
 628:	bf8d                	j	59a <printint+0x1a>

000000000000062a <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 62a:	7119                	addi	sp,sp,-128
 62c:	fc86                	sd	ra,120(sp)
 62e:	f8a2                	sd	s0,112(sp)
 630:	f4a6                	sd	s1,104(sp)
 632:	f0ca                	sd	s2,96(sp)
 634:	ecce                	sd	s3,88(sp)
 636:	e8d2                	sd	s4,80(sp)
 638:	e4d6                	sd	s5,72(sp)
 63a:	e0da                	sd	s6,64(sp)
 63c:	fc5e                	sd	s7,56(sp)
 63e:	f862                	sd	s8,48(sp)
 640:	f466                	sd	s9,40(sp)
 642:	f06a                	sd	s10,32(sp)
 644:	ec6e                	sd	s11,24(sp)
 646:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 648:	0005c903          	lbu	s2,0(a1)
 64c:	18090f63          	beqz	s2,7ea <vprintf+0x1c0>
 650:	8aaa                	mv	s5,a0
 652:	8b32                	mv	s6,a2
 654:	00158493          	addi	s1,a1,1
  state = 0;
 658:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 65a:	02500a13          	li	s4,37
      if(c == 'd'){
 65e:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 662:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 666:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 66a:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 66e:	00000b97          	auipc	s7,0x0
 672:	3c2b8b93          	addi	s7,s7,962 # a30 <digits>
 676:	a839                	j	694 <vprintf+0x6a>
        putc(fd, c);
 678:	85ca                	mv	a1,s2
 67a:	8556                	mv	a0,s5
 67c:	00000097          	auipc	ra,0x0
 680:	ee2080e7          	jalr	-286(ra) # 55e <putc>
 684:	a019                	j	68a <vprintf+0x60>
    } else if(state == '%'){
 686:	01498f63          	beq	s3,s4,6a4 <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
 68a:	0485                	addi	s1,s1,1
 68c:	fff4c903          	lbu	s2,-1(s1)
 690:	14090d63          	beqz	s2,7ea <vprintf+0x1c0>
    c = fmt[i] & 0xff;
 694:	0009079b          	sext.w	a5,s2
    if(state == 0){
 698:	fe0997e3          	bnez	s3,686 <vprintf+0x5c>
      if(c == '%'){
 69c:	fd479ee3          	bne	a5,s4,678 <vprintf+0x4e>
        state = '%';
 6a0:	89be                	mv	s3,a5
 6a2:	b7e5                	j	68a <vprintf+0x60>
      if(c == 'd'){
 6a4:	05878063          	beq	a5,s8,6e4 <vprintf+0xba>
      } else if(c == 'l') {
 6a8:	05978c63          	beq	a5,s9,700 <vprintf+0xd6>
      } else if(c == 'x') {
 6ac:	07a78863          	beq	a5,s10,71c <vprintf+0xf2>
      } else if(c == 'p') {
 6b0:	09b78463          	beq	a5,s11,738 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 6b4:	07300713          	li	a4,115
 6b8:	0ce78663          	beq	a5,a4,784 <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 6bc:	06300713          	li	a4,99
 6c0:	0ee78e63          	beq	a5,a4,7bc <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 6c4:	11478863          	beq	a5,s4,7d4 <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 6c8:	85d2                	mv	a1,s4
 6ca:	8556                	mv	a0,s5
 6cc:	00000097          	auipc	ra,0x0
 6d0:	e92080e7          	jalr	-366(ra) # 55e <putc>
        putc(fd, c);
 6d4:	85ca                	mv	a1,s2
 6d6:	8556                	mv	a0,s5
 6d8:	00000097          	auipc	ra,0x0
 6dc:	e86080e7          	jalr	-378(ra) # 55e <putc>
      }
      state = 0;
 6e0:	4981                	li	s3,0
 6e2:	b765                	j	68a <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 6e4:	008b0913          	addi	s2,s6,8
 6e8:	4685                	li	a3,1
 6ea:	4629                	li	a2,10
 6ec:	000b2583          	lw	a1,0(s6)
 6f0:	8556                	mv	a0,s5
 6f2:	00000097          	auipc	ra,0x0
 6f6:	e8e080e7          	jalr	-370(ra) # 580 <printint>
 6fa:	8b4a                	mv	s6,s2
      state = 0;
 6fc:	4981                	li	s3,0
 6fe:	b771                	j	68a <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 700:	008b0913          	addi	s2,s6,8
 704:	4681                	li	a3,0
 706:	4629                	li	a2,10
 708:	000b2583          	lw	a1,0(s6)
 70c:	8556                	mv	a0,s5
 70e:	00000097          	auipc	ra,0x0
 712:	e72080e7          	jalr	-398(ra) # 580 <printint>
 716:	8b4a                	mv	s6,s2
      state = 0;
 718:	4981                	li	s3,0
 71a:	bf85                	j	68a <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 71c:	008b0913          	addi	s2,s6,8
 720:	4681                	li	a3,0
 722:	4641                	li	a2,16
 724:	000b2583          	lw	a1,0(s6)
 728:	8556                	mv	a0,s5
 72a:	00000097          	auipc	ra,0x0
 72e:	e56080e7          	jalr	-426(ra) # 580 <printint>
 732:	8b4a                	mv	s6,s2
      state = 0;
 734:	4981                	li	s3,0
 736:	bf91                	j	68a <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 738:	008b0793          	addi	a5,s6,8
 73c:	f8f43423          	sd	a5,-120(s0)
 740:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 744:	03000593          	li	a1,48
 748:	8556                	mv	a0,s5
 74a:	00000097          	auipc	ra,0x0
 74e:	e14080e7          	jalr	-492(ra) # 55e <putc>
  putc(fd, 'x');
 752:	85ea                	mv	a1,s10
 754:	8556                	mv	a0,s5
 756:	00000097          	auipc	ra,0x0
 75a:	e08080e7          	jalr	-504(ra) # 55e <putc>
 75e:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 760:	03c9d793          	srli	a5,s3,0x3c
 764:	97de                	add	a5,a5,s7
 766:	0007c583          	lbu	a1,0(a5)
 76a:	8556                	mv	a0,s5
 76c:	00000097          	auipc	ra,0x0
 770:	df2080e7          	jalr	-526(ra) # 55e <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 774:	0992                	slli	s3,s3,0x4
 776:	397d                	addiw	s2,s2,-1
 778:	fe0914e3          	bnez	s2,760 <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 77c:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 780:	4981                	li	s3,0
 782:	b721                	j	68a <vprintf+0x60>
        s = va_arg(ap, char*);
 784:	008b0993          	addi	s3,s6,8
 788:	000b3903          	ld	s2,0(s6)
        if(s == 0)
 78c:	02090163          	beqz	s2,7ae <vprintf+0x184>
        while(*s != 0){
 790:	00094583          	lbu	a1,0(s2)
 794:	c9a1                	beqz	a1,7e4 <vprintf+0x1ba>
          putc(fd, *s);
 796:	8556                	mv	a0,s5
 798:	00000097          	auipc	ra,0x0
 79c:	dc6080e7          	jalr	-570(ra) # 55e <putc>
          s++;
 7a0:	0905                	addi	s2,s2,1
        while(*s != 0){
 7a2:	00094583          	lbu	a1,0(s2)
 7a6:	f9e5                	bnez	a1,796 <vprintf+0x16c>
        s = va_arg(ap, char*);
 7a8:	8b4e                	mv	s6,s3
      state = 0;
 7aa:	4981                	li	s3,0
 7ac:	bdf9                	j	68a <vprintf+0x60>
          s = "(null)";
 7ae:	00000917          	auipc	s2,0x0
 7b2:	27a90913          	addi	s2,s2,634 # a28 <malloc+0x134>
        while(*s != 0){
 7b6:	02800593          	li	a1,40
 7ba:	bff1                	j	796 <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
 7bc:	008b0913          	addi	s2,s6,8
 7c0:	000b4583          	lbu	a1,0(s6)
 7c4:	8556                	mv	a0,s5
 7c6:	00000097          	auipc	ra,0x0
 7ca:	d98080e7          	jalr	-616(ra) # 55e <putc>
 7ce:	8b4a                	mv	s6,s2
      state = 0;
 7d0:	4981                	li	s3,0
 7d2:	bd65                	j	68a <vprintf+0x60>
        putc(fd, c);
 7d4:	85d2                	mv	a1,s4
 7d6:	8556                	mv	a0,s5
 7d8:	00000097          	auipc	ra,0x0
 7dc:	d86080e7          	jalr	-634(ra) # 55e <putc>
      state = 0;
 7e0:	4981                	li	s3,0
 7e2:	b565                	j	68a <vprintf+0x60>
        s = va_arg(ap, char*);
 7e4:	8b4e                	mv	s6,s3
      state = 0;
 7e6:	4981                	li	s3,0
 7e8:	b54d                	j	68a <vprintf+0x60>
    }
  }
}
 7ea:	70e6                	ld	ra,120(sp)
 7ec:	7446                	ld	s0,112(sp)
 7ee:	74a6                	ld	s1,104(sp)
 7f0:	7906                	ld	s2,96(sp)
 7f2:	69e6                	ld	s3,88(sp)
 7f4:	6a46                	ld	s4,80(sp)
 7f6:	6aa6                	ld	s5,72(sp)
 7f8:	6b06                	ld	s6,64(sp)
 7fa:	7be2                	ld	s7,56(sp)
 7fc:	7c42                	ld	s8,48(sp)
 7fe:	7ca2                	ld	s9,40(sp)
 800:	7d02                	ld	s10,32(sp)
 802:	6de2                	ld	s11,24(sp)
 804:	6109                	addi	sp,sp,128
 806:	8082                	ret

0000000000000808 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 808:	715d                	addi	sp,sp,-80
 80a:	ec06                	sd	ra,24(sp)
 80c:	e822                	sd	s0,16(sp)
 80e:	1000                	addi	s0,sp,32
 810:	e010                	sd	a2,0(s0)
 812:	e414                	sd	a3,8(s0)
 814:	e818                	sd	a4,16(s0)
 816:	ec1c                	sd	a5,24(s0)
 818:	03043023          	sd	a6,32(s0)
 81c:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 820:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 824:	8622                	mv	a2,s0
 826:	00000097          	auipc	ra,0x0
 82a:	e04080e7          	jalr	-508(ra) # 62a <vprintf>
}
 82e:	60e2                	ld	ra,24(sp)
 830:	6442                	ld	s0,16(sp)
 832:	6161                	addi	sp,sp,80
 834:	8082                	ret

0000000000000836 <printf>:

void
printf(const char *fmt, ...)
{
 836:	711d                	addi	sp,sp,-96
 838:	ec06                	sd	ra,24(sp)
 83a:	e822                	sd	s0,16(sp)
 83c:	1000                	addi	s0,sp,32
 83e:	e40c                	sd	a1,8(s0)
 840:	e810                	sd	a2,16(s0)
 842:	ec14                	sd	a3,24(s0)
 844:	f018                	sd	a4,32(s0)
 846:	f41c                	sd	a5,40(s0)
 848:	03043823          	sd	a6,48(s0)
 84c:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 850:	00840613          	addi	a2,s0,8
 854:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 858:	85aa                	mv	a1,a0
 85a:	4505                	li	a0,1
 85c:	00000097          	auipc	ra,0x0
 860:	dce080e7          	jalr	-562(ra) # 62a <vprintf>
}
 864:	60e2                	ld	ra,24(sp)
 866:	6442                	ld	s0,16(sp)
 868:	6125                	addi	sp,sp,96
 86a:	8082                	ret

000000000000086c <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 86c:	1141                	addi	sp,sp,-16
 86e:	e422                	sd	s0,8(sp)
 870:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 872:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 876:	00000797          	auipc	a5,0x0
 87a:	1d27b783          	ld	a5,466(a5) # a48 <freep>
 87e:	a805                	j	8ae <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 880:	4618                	lw	a4,8(a2)
 882:	9db9                	addw	a1,a1,a4
 884:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 888:	6398                	ld	a4,0(a5)
 88a:	6318                	ld	a4,0(a4)
 88c:	fee53823          	sd	a4,-16(a0)
 890:	a091                	j	8d4 <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 892:	ff852703          	lw	a4,-8(a0)
 896:	9e39                	addw	a2,a2,a4
 898:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 89a:	ff053703          	ld	a4,-16(a0)
 89e:	e398                	sd	a4,0(a5)
 8a0:	a099                	j	8e6 <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8a2:	6398                	ld	a4,0(a5)
 8a4:	00e7e463          	bltu	a5,a4,8ac <free+0x40>
 8a8:	00e6ea63          	bltu	a3,a4,8bc <free+0x50>
{
 8ac:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8ae:	fed7fae3          	bgeu	a5,a3,8a2 <free+0x36>
 8b2:	6398                	ld	a4,0(a5)
 8b4:	00e6e463          	bltu	a3,a4,8bc <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8b8:	fee7eae3          	bltu	a5,a4,8ac <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
 8bc:	ff852583          	lw	a1,-8(a0)
 8c0:	6390                	ld	a2,0(a5)
 8c2:	02059713          	slli	a4,a1,0x20
 8c6:	9301                	srli	a4,a4,0x20
 8c8:	0712                	slli	a4,a4,0x4
 8ca:	9736                	add	a4,a4,a3
 8cc:	fae60ae3          	beq	a2,a4,880 <free+0x14>
    bp->s.ptr = p->s.ptr;
 8d0:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 8d4:	4790                	lw	a2,8(a5)
 8d6:	02061713          	slli	a4,a2,0x20
 8da:	9301                	srli	a4,a4,0x20
 8dc:	0712                	slli	a4,a4,0x4
 8de:	973e                	add	a4,a4,a5
 8e0:	fae689e3          	beq	a3,a4,892 <free+0x26>
  } else
    p->s.ptr = bp;
 8e4:	e394                	sd	a3,0(a5)
  freep = p;
 8e6:	00000717          	auipc	a4,0x0
 8ea:	16f73123          	sd	a5,354(a4) # a48 <freep>
}
 8ee:	6422                	ld	s0,8(sp)
 8f0:	0141                	addi	sp,sp,16
 8f2:	8082                	ret

00000000000008f4 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 8f4:	7139                	addi	sp,sp,-64
 8f6:	fc06                	sd	ra,56(sp)
 8f8:	f822                	sd	s0,48(sp)
 8fa:	f426                	sd	s1,40(sp)
 8fc:	f04a                	sd	s2,32(sp)
 8fe:	ec4e                	sd	s3,24(sp)
 900:	e852                	sd	s4,16(sp)
 902:	e456                	sd	s5,8(sp)
 904:	e05a                	sd	s6,0(sp)
 906:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 908:	02051493          	slli	s1,a0,0x20
 90c:	9081                	srli	s1,s1,0x20
 90e:	04bd                	addi	s1,s1,15
 910:	8091                	srli	s1,s1,0x4
 912:	0014899b          	addiw	s3,s1,1
 916:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 918:	00000517          	auipc	a0,0x0
 91c:	13053503          	ld	a0,304(a0) # a48 <freep>
 920:	c515                	beqz	a0,94c <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 922:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 924:	4798                	lw	a4,8(a5)
 926:	02977f63          	bgeu	a4,s1,964 <malloc+0x70>
 92a:	8a4e                	mv	s4,s3
 92c:	0009871b          	sext.w	a4,s3
 930:	6685                	lui	a3,0x1
 932:	00d77363          	bgeu	a4,a3,938 <malloc+0x44>
 936:	6a05                	lui	s4,0x1
 938:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 93c:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 940:	00000917          	auipc	s2,0x0
 944:	10890913          	addi	s2,s2,264 # a48 <freep>
  if(p == (char*)-1)
 948:	5afd                	li	s5,-1
 94a:	a88d                	j	9bc <malloc+0xc8>
    base.s.ptr = freep = prevp = &base;
 94c:	00000797          	auipc	a5,0x0
 950:	10478793          	addi	a5,a5,260 # a50 <base>
 954:	00000717          	auipc	a4,0x0
 958:	0ef73a23          	sd	a5,244(a4) # a48 <freep>
 95c:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 95e:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 962:	b7e1                	j	92a <malloc+0x36>
      if(p->s.size == nunits)
 964:	02e48b63          	beq	s1,a4,99a <malloc+0xa6>
        p->s.size -= nunits;
 968:	4137073b          	subw	a4,a4,s3
 96c:	c798                	sw	a4,8(a5)
        p += p->s.size;
 96e:	1702                	slli	a4,a4,0x20
 970:	9301                	srli	a4,a4,0x20
 972:	0712                	slli	a4,a4,0x4
 974:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 976:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 97a:	00000717          	auipc	a4,0x0
 97e:	0ca73723          	sd	a0,206(a4) # a48 <freep>
      return (void*)(p + 1);
 982:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 986:	70e2                	ld	ra,56(sp)
 988:	7442                	ld	s0,48(sp)
 98a:	74a2                	ld	s1,40(sp)
 98c:	7902                	ld	s2,32(sp)
 98e:	69e2                	ld	s3,24(sp)
 990:	6a42                	ld	s4,16(sp)
 992:	6aa2                	ld	s5,8(sp)
 994:	6b02                	ld	s6,0(sp)
 996:	6121                	addi	sp,sp,64
 998:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 99a:	6398                	ld	a4,0(a5)
 99c:	e118                	sd	a4,0(a0)
 99e:	bff1                	j	97a <malloc+0x86>
  hp->s.size = nu;
 9a0:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 9a4:	0541                	addi	a0,a0,16
 9a6:	00000097          	auipc	ra,0x0
 9aa:	ec6080e7          	jalr	-314(ra) # 86c <free>
  return freep;
 9ae:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 9b2:	d971                	beqz	a0,986 <malloc+0x92>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9b4:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 9b6:	4798                	lw	a4,8(a5)
 9b8:	fa9776e3          	bgeu	a4,s1,964 <malloc+0x70>
    if(p == freep)
 9bc:	00093703          	ld	a4,0(s2)
 9c0:	853e                	mv	a0,a5
 9c2:	fef719e3          	bne	a4,a5,9b4 <malloc+0xc0>
  p = sbrk(nu * sizeof(Header));
 9c6:	8552                	mv	a0,s4
 9c8:	00000097          	auipc	ra,0x0
 9cc:	b7e080e7          	jalr	-1154(ra) # 546 <sbrk>
  if(p == (char*)-1)
 9d0:	fd5518e3          	bne	a0,s5,9a0 <malloc+0xac>
        return 0;
 9d4:	4501                	li	a0,0
 9d6:	bf45                	j	986 <malloc+0x92>
