
user/_usertests:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <mycopyinstr1>:
}

// what if you pass ridiculous string pointers to system calls?
void
mycopyinstr1(char *s)
{
       0:	1141                	addi	sp,sp,-16
       2:	e406                	sd	ra,8(sp)
       4:	e022                	sd	s0,0(sp)
       6:	0800                	addi	s0,sp,16
  uint64 addrs[] = { 0x80000000LL, 0xffffffffffffffff };

  for(int ai = 0; ai < 2; ai++){
    uint64 addr = addrs[ai];

    int fd = open((char *)addr, O_CREATE|O_WRONLY);
       8:	20100593          	li	a1,513
       c:	4505                	li	a0,1
       e:	057e                	slli	a0,a0,0x1f
      10:	00006097          	auipc	ra,0x6
      14:	800080e7          	jalr	-2048(ra) # 5810 <open>
    if(fd >= 0){
      18:	02055063          	bgez	a0,38 <mycopyinstr1+0x38>
    int fd = open((char *)addr, O_CREATE|O_WRONLY);
      1c:	20100593          	li	a1,513
      20:	557d                	li	a0,-1
      22:	00005097          	auipc	ra,0x5
      26:	7ee080e7          	jalr	2030(ra) # 5810 <open>
    uint64 addr = addrs[ai];
      2a:	55fd                	li	a1,-1
    if(fd >= 0){
      2c:	00055863          	bgez	a0,3c <mycopyinstr1+0x3c>
      printf("open(%p) returned %d, not -1\n", addr, fd);
      exit(1);
    }
  }
}
      30:	60a2                	ld	ra,8(sp)
      32:	6402                	ld	s0,0(sp)
      34:	0141                	addi	sp,sp,16
      36:	8082                	ret
    uint64 addr = addrs[ai];
      38:	4585                	li	a1,1
      3a:	05fe                	slli	a1,a1,0x1f
      printf("open(%p) returned %d, not -1\n", addr, fd);
      3c:	862a                	mv	a2,a0
      3e:	00006517          	auipc	a0,0x6
      42:	caa50513          	addi	a0,a0,-854 # 5ce8 <malloc+0xe6>
      46:	00006097          	auipc	ra,0x6
      4a:	b04080e7          	jalr	-1276(ra) # 5b4a <printf>
      exit(1);
      4e:	4505                	li	a0,1
      50:	00005097          	auipc	ra,0x5
      54:	780080e7          	jalr	1920(ra) # 57d0 <exit>

0000000000000058 <bsstest>:
void
bsstest(char *s)
{
  int i;

  for(i = 0; i < sizeof(uninit); i++){
      58:	00009797          	auipc	a5,0x9
      5c:	61078793          	addi	a5,a5,1552 # 9668 <uninit>
      60:	0000c697          	auipc	a3,0xc
      64:	d1868693          	addi	a3,a3,-744 # bd78 <buf>
    if(uninit[i] != '\0'){
      68:	0007c703          	lbu	a4,0(a5)
      6c:	e709                	bnez	a4,76 <bsstest+0x1e>
  for(i = 0; i < sizeof(uninit); i++){
      6e:	0785                	addi	a5,a5,1
      70:	fed79ce3          	bne	a5,a3,68 <bsstest+0x10>
      74:	8082                	ret
{
      76:	1141                	addi	sp,sp,-16
      78:	e406                	sd	ra,8(sp)
      7a:	e022                	sd	s0,0(sp)
      7c:	0800                	addi	s0,sp,16
      printf("%s: bss test failed\n", s);
      7e:	85aa                	mv	a1,a0
      80:	00006517          	auipc	a0,0x6
      84:	c8850513          	addi	a0,a0,-888 # 5d08 <malloc+0x106>
      88:	00006097          	auipc	ra,0x6
      8c:	ac2080e7          	jalr	-1342(ra) # 5b4a <printf>
      exit(1);
      90:	4505                	li	a0,1
      92:	00005097          	auipc	ra,0x5
      96:	73e080e7          	jalr	1854(ra) # 57d0 <exit>

000000000000009a <opentest>:
{
      9a:	1101                	addi	sp,sp,-32
      9c:	ec06                	sd	ra,24(sp)
      9e:	e822                	sd	s0,16(sp)
      a0:	e426                	sd	s1,8(sp)
      a2:	1000                	addi	s0,sp,32
      a4:	84aa                	mv	s1,a0
  fd = open("echo", 0);
      a6:	4581                	li	a1,0
      a8:	00006517          	auipc	a0,0x6
      ac:	c7850513          	addi	a0,a0,-904 # 5d20 <malloc+0x11e>
      b0:	00005097          	auipc	ra,0x5
      b4:	760080e7          	jalr	1888(ra) # 5810 <open>
  if(fd < 0){
      b8:	02054663          	bltz	a0,e4 <opentest+0x4a>
  close(fd);
      bc:	00005097          	auipc	ra,0x5
      c0:	73c080e7          	jalr	1852(ra) # 57f8 <close>
  fd = open("doesnotexist", 0);
      c4:	4581                	li	a1,0
      c6:	00006517          	auipc	a0,0x6
      ca:	c7a50513          	addi	a0,a0,-902 # 5d40 <malloc+0x13e>
      ce:	00005097          	auipc	ra,0x5
      d2:	742080e7          	jalr	1858(ra) # 5810 <open>
  if(fd >= 0){
      d6:	02055563          	bgez	a0,100 <opentest+0x66>
}
      da:	60e2                	ld	ra,24(sp)
      dc:	6442                	ld	s0,16(sp)
      de:	64a2                	ld	s1,8(sp)
      e0:	6105                	addi	sp,sp,32
      e2:	8082                	ret
    printf("%s: open echo failed!\n", s);
      e4:	85a6                	mv	a1,s1
      e6:	00006517          	auipc	a0,0x6
      ea:	c4250513          	addi	a0,a0,-958 # 5d28 <malloc+0x126>
      ee:	00006097          	auipc	ra,0x6
      f2:	a5c080e7          	jalr	-1444(ra) # 5b4a <printf>
    exit(1);
      f6:	4505                	li	a0,1
      f8:	00005097          	auipc	ra,0x5
      fc:	6d8080e7          	jalr	1752(ra) # 57d0 <exit>
    printf("%s: open doesnotexist succeeded!\n", s);
     100:	85a6                	mv	a1,s1
     102:	00006517          	auipc	a0,0x6
     106:	c4e50513          	addi	a0,a0,-946 # 5d50 <malloc+0x14e>
     10a:	00006097          	auipc	ra,0x6
     10e:	a40080e7          	jalr	-1472(ra) # 5b4a <printf>
    exit(1);
     112:	4505                	li	a0,1
     114:	00005097          	auipc	ra,0x5
     118:	6bc080e7          	jalr	1724(ra) # 57d0 <exit>

000000000000011c <truncate2>:
{
     11c:	7179                	addi	sp,sp,-48
     11e:	f406                	sd	ra,40(sp)
     120:	f022                	sd	s0,32(sp)
     122:	ec26                	sd	s1,24(sp)
     124:	e84a                	sd	s2,16(sp)
     126:	e44e                	sd	s3,8(sp)
     128:	1800                	addi	s0,sp,48
     12a:	89aa                	mv	s3,a0
  unlink("truncfile");
     12c:	00006517          	auipc	a0,0x6
     130:	c4c50513          	addi	a0,a0,-948 # 5d78 <malloc+0x176>
     134:	00005097          	auipc	ra,0x5
     138:	6ec080e7          	jalr	1772(ra) # 5820 <unlink>
  int fd1 = open("truncfile", O_CREATE|O_TRUNC|O_WRONLY);
     13c:	60100593          	li	a1,1537
     140:	00006517          	auipc	a0,0x6
     144:	c3850513          	addi	a0,a0,-968 # 5d78 <malloc+0x176>
     148:	00005097          	auipc	ra,0x5
     14c:	6c8080e7          	jalr	1736(ra) # 5810 <open>
     150:	84aa                	mv	s1,a0
  write(fd1, "abcd", 4);
     152:	4611                	li	a2,4
     154:	00006597          	auipc	a1,0x6
     158:	c3458593          	addi	a1,a1,-972 # 5d88 <malloc+0x186>
     15c:	00005097          	auipc	ra,0x5
     160:	694080e7          	jalr	1684(ra) # 57f0 <write>
  int fd2 = open("truncfile", O_TRUNC|O_WRONLY);
     164:	40100593          	li	a1,1025
     168:	00006517          	auipc	a0,0x6
     16c:	c1050513          	addi	a0,a0,-1008 # 5d78 <malloc+0x176>
     170:	00005097          	auipc	ra,0x5
     174:	6a0080e7          	jalr	1696(ra) # 5810 <open>
     178:	892a                	mv	s2,a0
  int n = write(fd1, "x", 1);
     17a:	4605                	li	a2,1
     17c:	00006597          	auipc	a1,0x6
     180:	c1458593          	addi	a1,a1,-1004 # 5d90 <malloc+0x18e>
     184:	8526                	mv	a0,s1
     186:	00005097          	auipc	ra,0x5
     18a:	66a080e7          	jalr	1642(ra) # 57f0 <write>
  if(n != -1){
     18e:	57fd                	li	a5,-1
     190:	02f51b63          	bne	a0,a5,1c6 <truncate2+0xaa>
  unlink("truncfile");
     194:	00006517          	auipc	a0,0x6
     198:	be450513          	addi	a0,a0,-1052 # 5d78 <malloc+0x176>
     19c:	00005097          	auipc	ra,0x5
     1a0:	684080e7          	jalr	1668(ra) # 5820 <unlink>
  close(fd1);
     1a4:	8526                	mv	a0,s1
     1a6:	00005097          	auipc	ra,0x5
     1aa:	652080e7          	jalr	1618(ra) # 57f8 <close>
  close(fd2);
     1ae:	854a                	mv	a0,s2
     1b0:	00005097          	auipc	ra,0x5
     1b4:	648080e7          	jalr	1608(ra) # 57f8 <close>
}
     1b8:	70a2                	ld	ra,40(sp)
     1ba:	7402                	ld	s0,32(sp)
     1bc:	64e2                	ld	s1,24(sp)
     1be:	6942                	ld	s2,16(sp)
     1c0:	69a2                	ld	s3,8(sp)
     1c2:	6145                	addi	sp,sp,48
     1c4:	8082                	ret
    printf("%s: write returned %d, expected -1\n", s, n);
     1c6:	862a                	mv	a2,a0
     1c8:	85ce                	mv	a1,s3
     1ca:	00006517          	auipc	a0,0x6
     1ce:	bce50513          	addi	a0,a0,-1074 # 5d98 <malloc+0x196>
     1d2:	00006097          	auipc	ra,0x6
     1d6:	978080e7          	jalr	-1672(ra) # 5b4a <printf>
    exit(1);
     1da:	4505                	li	a0,1
     1dc:	00005097          	auipc	ra,0x5
     1e0:	5f4080e7          	jalr	1524(ra) # 57d0 <exit>

00000000000001e4 <createtest>:
{
     1e4:	7179                	addi	sp,sp,-48
     1e6:	f406                	sd	ra,40(sp)
     1e8:	f022                	sd	s0,32(sp)
     1ea:	ec26                	sd	s1,24(sp)
     1ec:	e84a                	sd	s2,16(sp)
     1ee:	1800                	addi	s0,sp,48
  name[0] = 'a';
     1f0:	06100793          	li	a5,97
     1f4:	fcf40c23          	sb	a5,-40(s0)
  name[2] = '\0';
     1f8:	fc040d23          	sb	zero,-38(s0)
     1fc:	03000493          	li	s1,48
  for(i = 0; i < N; i++){
     200:	06400913          	li	s2,100
    name[1] = '0' + i;
     204:	fc940ca3          	sb	s1,-39(s0)
    fd = open(name, O_CREATE|O_RDWR);
     208:	20200593          	li	a1,514
     20c:	fd840513          	addi	a0,s0,-40
     210:	00005097          	auipc	ra,0x5
     214:	600080e7          	jalr	1536(ra) # 5810 <open>
    close(fd);
     218:	00005097          	auipc	ra,0x5
     21c:	5e0080e7          	jalr	1504(ra) # 57f8 <close>
  for(i = 0; i < N; i++){
     220:	2485                	addiw	s1,s1,1
     222:	0ff4f493          	zext.b	s1,s1
     226:	fd249fe3          	bne	s1,s2,204 <createtest+0x20>
  name[0] = 'a';
     22a:	06100793          	li	a5,97
     22e:	fcf40c23          	sb	a5,-40(s0)
  name[2] = '\0';
     232:	fc040d23          	sb	zero,-38(s0)
     236:	03000493          	li	s1,48
  for(i = 0; i < N; i++){
     23a:	06400913          	li	s2,100
    name[1] = '0' + i;
     23e:	fc940ca3          	sb	s1,-39(s0)
    unlink(name);
     242:	fd840513          	addi	a0,s0,-40
     246:	00005097          	auipc	ra,0x5
     24a:	5da080e7          	jalr	1498(ra) # 5820 <unlink>
  for(i = 0; i < N; i++){
     24e:	2485                	addiw	s1,s1,1
     250:	0ff4f493          	zext.b	s1,s1
     254:	ff2495e3          	bne	s1,s2,23e <createtest+0x5a>
}
     258:	70a2                	ld	ra,40(sp)
     25a:	7402                	ld	s0,32(sp)
     25c:	64e2                	ld	s1,24(sp)
     25e:	6942                	ld	s2,16(sp)
     260:	6145                	addi	sp,sp,48
     262:	8082                	ret

0000000000000264 <bigwrite>:
{
     264:	715d                	addi	sp,sp,-80
     266:	e486                	sd	ra,72(sp)
     268:	e0a2                	sd	s0,64(sp)
     26a:	fc26                	sd	s1,56(sp)
     26c:	f84a                	sd	s2,48(sp)
     26e:	f44e                	sd	s3,40(sp)
     270:	f052                	sd	s4,32(sp)
     272:	ec56                	sd	s5,24(sp)
     274:	e85a                	sd	s6,16(sp)
     276:	e45e                	sd	s7,8(sp)
     278:	0880                	addi	s0,sp,80
     27a:	8baa                	mv	s7,a0
  unlink("bigwrite");
     27c:	00006517          	auipc	a0,0x6
     280:	b4450513          	addi	a0,a0,-1212 # 5dc0 <malloc+0x1be>
     284:	00005097          	auipc	ra,0x5
     288:	59c080e7          	jalr	1436(ra) # 5820 <unlink>
  for(sz = 499; sz < (MAXOPBLOCKS+2)*BSIZE; sz += 471){
     28c:	1f300493          	li	s1,499
    fd = open("bigwrite", O_CREATE | O_RDWR);
     290:	00006a97          	auipc	s5,0x6
     294:	b30a8a93          	addi	s5,s5,-1232 # 5dc0 <malloc+0x1be>
      int cc = write(fd, buf, sz);
     298:	0000ca17          	auipc	s4,0xc
     29c:	ae0a0a13          	addi	s4,s4,-1312 # bd78 <buf>
  for(sz = 499; sz < (MAXOPBLOCKS+2)*BSIZE; sz += 471){
     2a0:	6b0d                	lui	s6,0x3
     2a2:	1c9b0b13          	addi	s6,s6,457 # 31c9 <subdir+0x33>
    fd = open("bigwrite", O_CREATE | O_RDWR);
     2a6:	20200593          	li	a1,514
     2aa:	8556                	mv	a0,s5
     2ac:	00005097          	auipc	ra,0x5
     2b0:	564080e7          	jalr	1380(ra) # 5810 <open>
     2b4:	892a                	mv	s2,a0
    if(fd < 0){
     2b6:	04054d63          	bltz	a0,310 <bigwrite+0xac>
      int cc = write(fd, buf, sz);
     2ba:	8626                	mv	a2,s1
     2bc:	85d2                	mv	a1,s4
     2be:	00005097          	auipc	ra,0x5
     2c2:	532080e7          	jalr	1330(ra) # 57f0 <write>
     2c6:	89aa                	mv	s3,a0
      if(cc != sz){
     2c8:	06a49263          	bne	s1,a0,32c <bigwrite+0xc8>
      int cc = write(fd, buf, sz);
     2cc:	8626                	mv	a2,s1
     2ce:	85d2                	mv	a1,s4
     2d0:	854a                	mv	a0,s2
     2d2:	00005097          	auipc	ra,0x5
     2d6:	51e080e7          	jalr	1310(ra) # 57f0 <write>
      if(cc != sz){
     2da:	04951a63          	bne	a0,s1,32e <bigwrite+0xca>
    close(fd);
     2de:	854a                	mv	a0,s2
     2e0:	00005097          	auipc	ra,0x5
     2e4:	518080e7          	jalr	1304(ra) # 57f8 <close>
    unlink("bigwrite");
     2e8:	8556                	mv	a0,s5
     2ea:	00005097          	auipc	ra,0x5
     2ee:	536080e7          	jalr	1334(ra) # 5820 <unlink>
  for(sz = 499; sz < (MAXOPBLOCKS+2)*BSIZE; sz += 471){
     2f2:	1d74849b          	addiw	s1,s1,471
     2f6:	fb6498e3          	bne	s1,s6,2a6 <bigwrite+0x42>
}
     2fa:	60a6                	ld	ra,72(sp)
     2fc:	6406                	ld	s0,64(sp)
     2fe:	74e2                	ld	s1,56(sp)
     300:	7942                	ld	s2,48(sp)
     302:	79a2                	ld	s3,40(sp)
     304:	7a02                	ld	s4,32(sp)
     306:	6ae2                	ld	s5,24(sp)
     308:	6b42                	ld	s6,16(sp)
     30a:	6ba2                	ld	s7,8(sp)
     30c:	6161                	addi	sp,sp,80
     30e:	8082                	ret
      printf("%s: cannot create bigwrite\n", s);
     310:	85de                	mv	a1,s7
     312:	00006517          	auipc	a0,0x6
     316:	abe50513          	addi	a0,a0,-1346 # 5dd0 <malloc+0x1ce>
     31a:	00006097          	auipc	ra,0x6
     31e:	830080e7          	jalr	-2000(ra) # 5b4a <printf>
      exit(1);
     322:	4505                	li	a0,1
     324:	00005097          	auipc	ra,0x5
     328:	4ac080e7          	jalr	1196(ra) # 57d0 <exit>
      if(cc != sz){
     32c:	89a6                	mv	s3,s1
        printf("%s: write(%d) ret %d\n", s, sz, cc);
     32e:	86aa                	mv	a3,a0
     330:	864e                	mv	a2,s3
     332:	85de                	mv	a1,s7
     334:	00006517          	auipc	a0,0x6
     338:	abc50513          	addi	a0,a0,-1348 # 5df0 <malloc+0x1ee>
     33c:	00006097          	auipc	ra,0x6
     340:	80e080e7          	jalr	-2034(ra) # 5b4a <printf>
        exit(1);
     344:	4505                	li	a0,1
     346:	00005097          	auipc	ra,0x5
     34a:	48a080e7          	jalr	1162(ra) # 57d0 <exit>

000000000000034e <manywrites>:
{
     34e:	7139                	addi	sp,sp,-64
     350:	fc06                	sd	ra,56(sp)
     352:	f822                	sd	s0,48(sp)
     354:	f426                	sd	s1,40(sp)
     356:	f04a                	sd	s2,32(sp)
     358:	ec4e                	sd	s3,24(sp)
     35a:	e852                	sd	s4,16(sp)
     35c:	0080                	addi	s0,sp,64
     35e:	84aa                	mv	s1,a0
      name[0] = 'b';
     360:	06200793          	li	a5,98
     364:	fcf40423          	sb	a5,-56(s0)
      name[1] = 'a' + ci;
     368:	06100793          	li	a5,97
     36c:	fcf404a3          	sb	a5,-55(s0)
      name[2] = '\0';
     370:	fc040523          	sb	zero,-54(s0)
      unlink(name);
     374:	fc840513          	addi	a0,s0,-56
     378:	00005097          	auipc	ra,0x5
     37c:	4a8080e7          	jalr	1192(ra) # 5820 <unlink>
     380:	49f9                	li	s3,30
          int cc = write(fd, buf, sz);
     382:	0000ca17          	auipc	s4,0xc
     386:	9f6a0a13          	addi	s4,s4,-1546 # bd78 <buf>
          int fd = open(name, O_CREATE | O_RDWR);
     38a:	20200593          	li	a1,514
     38e:	fc840513          	addi	a0,s0,-56
     392:	00005097          	auipc	ra,0x5
     396:	47e080e7          	jalr	1150(ra) # 5810 <open>
     39a:	892a                	mv	s2,a0
          if(fd < 0){
     39c:	04054563          	bltz	a0,3e6 <manywrites+0x98>
          int cc = write(fd, buf, sz);
     3a0:	660d                	lui	a2,0x3
     3a2:	85d2                	mv	a1,s4
     3a4:	854a                	mv	a0,s2
     3a6:	00005097          	auipc	ra,0x5
     3aa:	44a080e7          	jalr	1098(ra) # 57f0 <write>
          if(cc != sz){
     3ae:	678d                	lui	a5,0x3
     3b0:	04f51b63          	bne	a0,a5,406 <manywrites+0xb8>
          close(fd);
     3b4:	854a                	mv	a0,s2
     3b6:	00005097          	auipc	ra,0x5
     3ba:	442080e7          	jalr	1090(ra) # 57f8 <close>
        unlink(name);
     3be:	fc840513          	addi	a0,s0,-56
     3c2:	00005097          	auipc	ra,0x5
     3c6:	45e080e7          	jalr	1118(ra) # 5820 <unlink>
      for(int iters = 0; iters < howmany; iters++){
     3ca:	39fd                	addiw	s3,s3,-1
     3cc:	fa099fe3          	bnez	s3,38a <manywrites+0x3c>
      unlink(name);
     3d0:	fc840513          	addi	a0,s0,-56
     3d4:	00005097          	auipc	ra,0x5
     3d8:	44c080e7          	jalr	1100(ra) # 5820 <unlink>
      exit(0);
     3dc:	4501                	li	a0,0
     3de:	00005097          	auipc	ra,0x5
     3e2:	3f2080e7          	jalr	1010(ra) # 57d0 <exit>
            printf("%s: cannot create %s\n", s, name);
     3e6:	fc840613          	addi	a2,s0,-56
     3ea:	85a6                	mv	a1,s1
     3ec:	00006517          	auipc	a0,0x6
     3f0:	a1c50513          	addi	a0,a0,-1508 # 5e08 <malloc+0x206>
     3f4:	00005097          	auipc	ra,0x5
     3f8:	756080e7          	jalr	1878(ra) # 5b4a <printf>
            exit(1);
     3fc:	4505                	li	a0,1
     3fe:	00005097          	auipc	ra,0x5
     402:	3d2080e7          	jalr	978(ra) # 57d0 <exit>
            printf("%s: write(%d) ret %d\n", s, sz, cc);
     406:	86aa                	mv	a3,a0
     408:	660d                	lui	a2,0x3
     40a:	85a6                	mv	a1,s1
     40c:	00006517          	auipc	a0,0x6
     410:	9e450513          	addi	a0,a0,-1564 # 5df0 <malloc+0x1ee>
     414:	00005097          	auipc	ra,0x5
     418:	736080e7          	jalr	1846(ra) # 5b4a <printf>
            exit(1);
     41c:	4505                	li	a0,1
     41e:	00005097          	auipc	ra,0x5
     422:	3b2080e7          	jalr	946(ra) # 57d0 <exit>

0000000000000426 <mycopyin>:
{
     426:	715d                	addi	sp,sp,-80
     428:	e486                	sd	ra,72(sp)
     42a:	e0a2                	sd	s0,64(sp)
     42c:	fc26                	sd	s1,56(sp)
     42e:	f84a                	sd	s2,48(sp)
     430:	f44e                	sd	s3,40(sp)
     432:	f052                	sd	s4,32(sp)
     434:	0880                	addi	s0,sp,80
  uint64 addrs[] = { 0x80000000LL, 0xffffffffffffffff };
     436:	4785                	li	a5,1
     438:	07fe                	slli	a5,a5,0x1f
     43a:	fcf43023          	sd	a5,-64(s0)
     43e:	57fd                	li	a5,-1
     440:	fcf43423          	sd	a5,-56(s0)
  for(int ai = 0; ai < 2; ai++){
     444:	fc040913          	addi	s2,s0,-64
    int fd = open("mycopyin1", O_CREATE|O_WRONLY);
     448:	00006a17          	auipc	s4,0x6
     44c:	9d8a0a13          	addi	s4,s4,-1576 # 5e20 <malloc+0x21e>
    uint64 addr = addrs[ai];
     450:	00093983          	ld	s3,0(s2)
    int fd = open("mycopyin1", O_CREATE|O_WRONLY);
     454:	20100593          	li	a1,513
     458:	8552                	mv	a0,s4
     45a:	00005097          	auipc	ra,0x5
     45e:	3b6080e7          	jalr	950(ra) # 5810 <open>
     462:	84aa                	mv	s1,a0
    if(fd < 0){
     464:	08054863          	bltz	a0,4f4 <mycopyin+0xce>
    int n = write(fd, (void*)addr, 8192);
     468:	6609                	lui	a2,0x2
     46a:	85ce                	mv	a1,s3
     46c:	00005097          	auipc	ra,0x5
     470:	384080e7          	jalr	900(ra) # 57f0 <write>
    if(n >= 0){
     474:	08055d63          	bgez	a0,50e <mycopyin+0xe8>
    close(fd);
     478:	8526                	mv	a0,s1
     47a:	00005097          	auipc	ra,0x5
     47e:	37e080e7          	jalr	894(ra) # 57f8 <close>
    unlink("mycopyin1");
     482:	8552                	mv	a0,s4
     484:	00005097          	auipc	ra,0x5
     488:	39c080e7          	jalr	924(ra) # 5820 <unlink>
    n = write(1, (char*)addr, 8192);
     48c:	6609                	lui	a2,0x2
     48e:	85ce                	mv	a1,s3
     490:	4505                	li	a0,1
     492:	00005097          	auipc	ra,0x5
     496:	35e080e7          	jalr	862(ra) # 57f0 <write>
    if(n > 0){
     49a:	08a04963          	bgtz	a0,52c <mycopyin+0x106>
    if(pipe(fds) < 0){
     49e:	fb840513          	addi	a0,s0,-72
     4a2:	00005097          	auipc	ra,0x5
     4a6:	33e080e7          	jalr	830(ra) # 57e0 <pipe>
     4aa:	0a054063          	bltz	a0,54a <mycopyin+0x124>
    n = write(fds[1], (char*)addr, 8192);
     4ae:	6609                	lui	a2,0x2
     4b0:	85ce                	mv	a1,s3
     4b2:	fbc42503          	lw	a0,-68(s0)
     4b6:	00005097          	auipc	ra,0x5
     4ba:	33a080e7          	jalr	826(ra) # 57f0 <write>
    if(n > 0){
     4be:	0aa04363          	bgtz	a0,564 <mycopyin+0x13e>
    close(fds[0]);
     4c2:	fb842503          	lw	a0,-72(s0)
     4c6:	00005097          	auipc	ra,0x5
     4ca:	332080e7          	jalr	818(ra) # 57f8 <close>
    close(fds[1]);
     4ce:	fbc42503          	lw	a0,-68(s0)
     4d2:	00005097          	auipc	ra,0x5
     4d6:	326080e7          	jalr	806(ra) # 57f8 <close>
  for(int ai = 0; ai < 2; ai++){
     4da:	0921                	addi	s2,s2,8
     4dc:	fd040793          	addi	a5,s0,-48
     4e0:	f6f918e3          	bne	s2,a5,450 <mycopyin+0x2a>
}
     4e4:	60a6                	ld	ra,72(sp)
     4e6:	6406                	ld	s0,64(sp)
     4e8:	74e2                	ld	s1,56(sp)
     4ea:	7942                	ld	s2,48(sp)
     4ec:	79a2                	ld	s3,40(sp)
     4ee:	7a02                	ld	s4,32(sp)
     4f0:	6161                	addi	sp,sp,80
     4f2:	8082                	ret
      printf("open(mycopyin1) failed\n");
     4f4:	00006517          	auipc	a0,0x6
     4f8:	93c50513          	addi	a0,a0,-1732 # 5e30 <malloc+0x22e>
     4fc:	00005097          	auipc	ra,0x5
     500:	64e080e7          	jalr	1614(ra) # 5b4a <printf>
      exit(1);
     504:	4505                	li	a0,1
     506:	00005097          	auipc	ra,0x5
     50a:	2ca080e7          	jalr	714(ra) # 57d0 <exit>
      printf("write(fd, %p, 8192) returned %d, not -1\n", addr, n);
     50e:	862a                	mv	a2,a0
     510:	85ce                	mv	a1,s3
     512:	00006517          	auipc	a0,0x6
     516:	93650513          	addi	a0,a0,-1738 # 5e48 <malloc+0x246>
     51a:	00005097          	auipc	ra,0x5
     51e:	630080e7          	jalr	1584(ra) # 5b4a <printf>
      exit(1);
     522:	4505                	li	a0,1
     524:	00005097          	auipc	ra,0x5
     528:	2ac080e7          	jalr	684(ra) # 57d0 <exit>
      printf("write(1, %p, 8192) returned %d, not -1 or 0\n", addr, n);
     52c:	862a                	mv	a2,a0
     52e:	85ce                	mv	a1,s3
     530:	00006517          	auipc	a0,0x6
     534:	94850513          	addi	a0,a0,-1720 # 5e78 <malloc+0x276>
     538:	00005097          	auipc	ra,0x5
     53c:	612080e7          	jalr	1554(ra) # 5b4a <printf>
      exit(1);
     540:	4505                	li	a0,1
     542:	00005097          	auipc	ra,0x5
     546:	28e080e7          	jalr	654(ra) # 57d0 <exit>
      printf("pipe() failed\n");
     54a:	00006517          	auipc	a0,0x6
     54e:	95e50513          	addi	a0,a0,-1698 # 5ea8 <malloc+0x2a6>
     552:	00005097          	auipc	ra,0x5
     556:	5f8080e7          	jalr	1528(ra) # 5b4a <printf>
      exit(1);
     55a:	4505                	li	a0,1
     55c:	00005097          	auipc	ra,0x5
     560:	274080e7          	jalr	628(ra) # 57d0 <exit>
      printf("write(pipe, %p, 8192) returned %d, not -1 or 0\n", addr, n);
     564:	862a                	mv	a2,a0
     566:	85ce                	mv	a1,s3
     568:	00006517          	auipc	a0,0x6
     56c:	95050513          	addi	a0,a0,-1712 # 5eb8 <malloc+0x2b6>
     570:	00005097          	auipc	ra,0x5
     574:	5da080e7          	jalr	1498(ra) # 5b4a <printf>
      exit(1);
     578:	4505                	li	a0,1
     57a:	00005097          	auipc	ra,0x5
     57e:	256080e7          	jalr	598(ra) # 57d0 <exit>

0000000000000582 <mycopyout>:
{
     582:	711d                	addi	sp,sp,-96
     584:	ec86                	sd	ra,88(sp)
     586:	e8a2                	sd	s0,80(sp)
     588:	e4a6                	sd	s1,72(sp)
     58a:	e0ca                	sd	s2,64(sp)
     58c:	fc4e                	sd	s3,56(sp)
     58e:	f852                	sd	s4,48(sp)
     590:	f456                	sd	s5,40(sp)
     592:	1080                	addi	s0,sp,96
  uint64 addrs[] = { 0x80000000LL, 0xffffffffffffffff };
     594:	4785                	li	a5,1
     596:	07fe                	slli	a5,a5,0x1f
     598:	faf43823          	sd	a5,-80(s0)
     59c:	57fd                	li	a5,-1
     59e:	faf43c23          	sd	a5,-72(s0)
  for(int ai = 0; ai < 2; ai++){
     5a2:	fb040913          	addi	s2,s0,-80
    int fd = open("README", 0);
     5a6:	00006a17          	auipc	s4,0x6
     5aa:	942a0a13          	addi	s4,s4,-1726 # 5ee8 <malloc+0x2e6>
    n = write(fds[1], "x", 1);
     5ae:	00005a97          	auipc	s5,0x5
     5b2:	7e2a8a93          	addi	s5,s5,2018 # 5d90 <malloc+0x18e>
    uint64 addr = addrs[ai];
     5b6:	00093983          	ld	s3,0(s2)
    int fd = open("README", 0);
     5ba:	4581                	li	a1,0
     5bc:	8552                	mv	a0,s4
     5be:	00005097          	auipc	ra,0x5
     5c2:	252080e7          	jalr	594(ra) # 5810 <open>
     5c6:	84aa                	mv	s1,a0
    if(fd < 0){
     5c8:	08054663          	bltz	a0,654 <mycopyout+0xd2>
    int n = read(fd, (void*)addr, 8192);
     5cc:	6609                	lui	a2,0x2
     5ce:	85ce                	mv	a1,s3
     5d0:	00005097          	auipc	ra,0x5
     5d4:	218080e7          	jalr	536(ra) # 57e8 <read>
    if(n > 0){
     5d8:	08a04b63          	bgtz	a0,66e <mycopyout+0xec>
    close(fd);
     5dc:	8526                	mv	a0,s1
     5de:	00005097          	auipc	ra,0x5
     5e2:	21a080e7          	jalr	538(ra) # 57f8 <close>
    if(pipe(fds) < 0){
     5e6:	fa840513          	addi	a0,s0,-88
     5ea:	00005097          	auipc	ra,0x5
     5ee:	1f6080e7          	jalr	502(ra) # 57e0 <pipe>
     5f2:	08054d63          	bltz	a0,68c <mycopyout+0x10a>
    n = write(fds[1], "x", 1);
     5f6:	4605                	li	a2,1
     5f8:	85d6                	mv	a1,s5
     5fa:	fac42503          	lw	a0,-84(s0)
     5fe:	00005097          	auipc	ra,0x5
     602:	1f2080e7          	jalr	498(ra) # 57f0 <write>
    if(n != 1){
     606:	4785                	li	a5,1
     608:	08f51f63          	bne	a0,a5,6a6 <mycopyout+0x124>
    n = read(fds[0], (void*)addr, 8192);
     60c:	6609                	lui	a2,0x2
     60e:	85ce                	mv	a1,s3
     610:	fa842503          	lw	a0,-88(s0)
     614:	00005097          	auipc	ra,0x5
     618:	1d4080e7          	jalr	468(ra) # 57e8 <read>
    if(n > 0){
     61c:	0aa04263          	bgtz	a0,6c0 <mycopyout+0x13e>
    close(fds[0]);
     620:	fa842503          	lw	a0,-88(s0)
     624:	00005097          	auipc	ra,0x5
     628:	1d4080e7          	jalr	468(ra) # 57f8 <close>
    close(fds[1]);
     62c:	fac42503          	lw	a0,-84(s0)
     630:	00005097          	auipc	ra,0x5
     634:	1c8080e7          	jalr	456(ra) # 57f8 <close>
  for(int ai = 0; ai < 2; ai++){
     638:	0921                	addi	s2,s2,8
     63a:	fc040793          	addi	a5,s0,-64
     63e:	f6f91ce3          	bne	s2,a5,5b6 <mycopyout+0x34>
}
     642:	60e6                	ld	ra,88(sp)
     644:	6446                	ld	s0,80(sp)
     646:	64a6                	ld	s1,72(sp)
     648:	6906                	ld	s2,64(sp)
     64a:	79e2                	ld	s3,56(sp)
     64c:	7a42                	ld	s4,48(sp)
     64e:	7aa2                	ld	s5,40(sp)
     650:	6125                	addi	sp,sp,96
     652:	8082                	ret
      printf("open(README) failed\n");
     654:	00006517          	auipc	a0,0x6
     658:	89c50513          	addi	a0,a0,-1892 # 5ef0 <malloc+0x2ee>
     65c:	00005097          	auipc	ra,0x5
     660:	4ee080e7          	jalr	1262(ra) # 5b4a <printf>
      exit(1);
     664:	4505                	li	a0,1
     666:	00005097          	auipc	ra,0x5
     66a:	16a080e7          	jalr	362(ra) # 57d0 <exit>
      printf("read(fd, %p, 8192) returned %d, not -1 or 0\n", addr, n);
     66e:	862a                	mv	a2,a0
     670:	85ce                	mv	a1,s3
     672:	00006517          	auipc	a0,0x6
     676:	89650513          	addi	a0,a0,-1898 # 5f08 <malloc+0x306>
     67a:	00005097          	auipc	ra,0x5
     67e:	4d0080e7          	jalr	1232(ra) # 5b4a <printf>
      exit(1);
     682:	4505                	li	a0,1
     684:	00005097          	auipc	ra,0x5
     688:	14c080e7          	jalr	332(ra) # 57d0 <exit>
      printf("pipe() failed\n");
     68c:	00006517          	auipc	a0,0x6
     690:	81c50513          	addi	a0,a0,-2020 # 5ea8 <malloc+0x2a6>
     694:	00005097          	auipc	ra,0x5
     698:	4b6080e7          	jalr	1206(ra) # 5b4a <printf>
      exit(1);
     69c:	4505                	li	a0,1
     69e:	00005097          	auipc	ra,0x5
     6a2:	132080e7          	jalr	306(ra) # 57d0 <exit>
      printf("pipe write failed\n");
     6a6:	00006517          	auipc	a0,0x6
     6aa:	89250513          	addi	a0,a0,-1902 # 5f38 <malloc+0x336>
     6ae:	00005097          	auipc	ra,0x5
     6b2:	49c080e7          	jalr	1180(ra) # 5b4a <printf>
      exit(1);
     6b6:	4505                	li	a0,1
     6b8:	00005097          	auipc	ra,0x5
     6bc:	118080e7          	jalr	280(ra) # 57d0 <exit>
      printf("read(pipe, %p, 8192) returned %d, not -1 or 0\n", addr, n);
     6c0:	862a                	mv	a2,a0
     6c2:	85ce                	mv	a1,s3
     6c4:	00006517          	auipc	a0,0x6
     6c8:	88c50513          	addi	a0,a0,-1908 # 5f50 <malloc+0x34e>
     6cc:	00005097          	auipc	ra,0x5
     6d0:	47e080e7          	jalr	1150(ra) # 5b4a <printf>
      exit(1);
     6d4:	4505                	li	a0,1
     6d6:	00005097          	auipc	ra,0x5
     6da:	0fa080e7          	jalr	250(ra) # 57d0 <exit>

00000000000006de <truncate1>:
{
     6de:	711d                	addi	sp,sp,-96
     6e0:	ec86                	sd	ra,88(sp)
     6e2:	e8a2                	sd	s0,80(sp)
     6e4:	e4a6                	sd	s1,72(sp)
     6e6:	e0ca                	sd	s2,64(sp)
     6e8:	fc4e                	sd	s3,56(sp)
     6ea:	f852                	sd	s4,48(sp)
     6ec:	f456                	sd	s5,40(sp)
     6ee:	1080                	addi	s0,sp,96
     6f0:	8aaa                	mv	s5,a0
  unlink("truncfile");
     6f2:	00005517          	auipc	a0,0x5
     6f6:	68650513          	addi	a0,a0,1670 # 5d78 <malloc+0x176>
     6fa:	00005097          	auipc	ra,0x5
     6fe:	126080e7          	jalr	294(ra) # 5820 <unlink>
  int fd1 = open("truncfile", O_CREATE|O_WRONLY|O_TRUNC);
     702:	60100593          	li	a1,1537
     706:	00005517          	auipc	a0,0x5
     70a:	67250513          	addi	a0,a0,1650 # 5d78 <malloc+0x176>
     70e:	00005097          	auipc	ra,0x5
     712:	102080e7          	jalr	258(ra) # 5810 <open>
     716:	84aa                	mv	s1,a0
  write(fd1, "abcd", 4);
     718:	4611                	li	a2,4
     71a:	00005597          	auipc	a1,0x5
     71e:	66e58593          	addi	a1,a1,1646 # 5d88 <malloc+0x186>
     722:	00005097          	auipc	ra,0x5
     726:	0ce080e7          	jalr	206(ra) # 57f0 <write>
  close(fd1);
     72a:	8526                	mv	a0,s1
     72c:	00005097          	auipc	ra,0x5
     730:	0cc080e7          	jalr	204(ra) # 57f8 <close>
  int fd2 = open("truncfile", O_RDONLY);
     734:	4581                	li	a1,0
     736:	00005517          	auipc	a0,0x5
     73a:	64250513          	addi	a0,a0,1602 # 5d78 <malloc+0x176>
     73e:	00005097          	auipc	ra,0x5
     742:	0d2080e7          	jalr	210(ra) # 5810 <open>
     746:	84aa                	mv	s1,a0
  int n = read(fd2, buf, sizeof(buf));
     748:	02000613          	li	a2,32
     74c:	fa040593          	addi	a1,s0,-96
     750:	00005097          	auipc	ra,0x5
     754:	098080e7          	jalr	152(ra) # 57e8 <read>
  if(n != 4){
     758:	4791                	li	a5,4
     75a:	0cf51e63          	bne	a0,a5,836 <truncate1+0x158>
  fd1 = open("truncfile", O_WRONLY|O_TRUNC);
     75e:	40100593          	li	a1,1025
     762:	00005517          	auipc	a0,0x5
     766:	61650513          	addi	a0,a0,1558 # 5d78 <malloc+0x176>
     76a:	00005097          	auipc	ra,0x5
     76e:	0a6080e7          	jalr	166(ra) # 5810 <open>
     772:	89aa                	mv	s3,a0
  int fd3 = open("truncfile", O_RDONLY);
     774:	4581                	li	a1,0
     776:	00005517          	auipc	a0,0x5
     77a:	60250513          	addi	a0,a0,1538 # 5d78 <malloc+0x176>
     77e:	00005097          	auipc	ra,0x5
     782:	092080e7          	jalr	146(ra) # 5810 <open>
     786:	892a                	mv	s2,a0
  n = read(fd3, buf, sizeof(buf));
     788:	02000613          	li	a2,32
     78c:	fa040593          	addi	a1,s0,-96
     790:	00005097          	auipc	ra,0x5
     794:	058080e7          	jalr	88(ra) # 57e8 <read>
     798:	8a2a                	mv	s4,a0
  if(n != 0){
     79a:	ed4d                	bnez	a0,854 <truncate1+0x176>
  n = read(fd2, buf, sizeof(buf));
     79c:	02000613          	li	a2,32
     7a0:	fa040593          	addi	a1,s0,-96
     7a4:	8526                	mv	a0,s1
     7a6:	00005097          	auipc	ra,0x5
     7aa:	042080e7          	jalr	66(ra) # 57e8 <read>
     7ae:	8a2a                	mv	s4,a0
  if(n != 0){
     7b0:	e971                	bnez	a0,884 <truncate1+0x1a6>
  write(fd1, "abcdef", 6);
     7b2:	4619                	li	a2,6
     7b4:	00006597          	auipc	a1,0x6
     7b8:	82c58593          	addi	a1,a1,-2004 # 5fe0 <malloc+0x3de>
     7bc:	854e                	mv	a0,s3
     7be:	00005097          	auipc	ra,0x5
     7c2:	032080e7          	jalr	50(ra) # 57f0 <write>
  n = read(fd3, buf, sizeof(buf));
     7c6:	02000613          	li	a2,32
     7ca:	fa040593          	addi	a1,s0,-96
     7ce:	854a                	mv	a0,s2
     7d0:	00005097          	auipc	ra,0x5
     7d4:	018080e7          	jalr	24(ra) # 57e8 <read>
  if(n != 6){
     7d8:	4799                	li	a5,6
     7da:	0cf51d63          	bne	a0,a5,8b4 <truncate1+0x1d6>
  n = read(fd2, buf, sizeof(buf));
     7de:	02000613          	li	a2,32
     7e2:	fa040593          	addi	a1,s0,-96
     7e6:	8526                	mv	a0,s1
     7e8:	00005097          	auipc	ra,0x5
     7ec:	000080e7          	jalr	ra # 57e8 <read>
  if(n != 2){
     7f0:	4789                	li	a5,2
     7f2:	0ef51063          	bne	a0,a5,8d2 <truncate1+0x1f4>
  unlink("truncfile");
     7f6:	00005517          	auipc	a0,0x5
     7fa:	58250513          	addi	a0,a0,1410 # 5d78 <malloc+0x176>
     7fe:	00005097          	auipc	ra,0x5
     802:	022080e7          	jalr	34(ra) # 5820 <unlink>
  close(fd1);
     806:	854e                	mv	a0,s3
     808:	00005097          	auipc	ra,0x5
     80c:	ff0080e7          	jalr	-16(ra) # 57f8 <close>
  close(fd2);
     810:	8526                	mv	a0,s1
     812:	00005097          	auipc	ra,0x5
     816:	fe6080e7          	jalr	-26(ra) # 57f8 <close>
  close(fd3);
     81a:	854a                	mv	a0,s2
     81c:	00005097          	auipc	ra,0x5
     820:	fdc080e7          	jalr	-36(ra) # 57f8 <close>
}
     824:	60e6                	ld	ra,88(sp)
     826:	6446                	ld	s0,80(sp)
     828:	64a6                	ld	s1,72(sp)
     82a:	6906                	ld	s2,64(sp)
     82c:	79e2                	ld	s3,56(sp)
     82e:	7a42                	ld	s4,48(sp)
     830:	7aa2                	ld	s5,40(sp)
     832:	6125                	addi	sp,sp,96
     834:	8082                	ret
    printf("%s: read %d bytes, wanted 4\n", s, n);
     836:	862a                	mv	a2,a0
     838:	85d6                	mv	a1,s5
     83a:	00005517          	auipc	a0,0x5
     83e:	74650513          	addi	a0,a0,1862 # 5f80 <malloc+0x37e>
     842:	00005097          	auipc	ra,0x5
     846:	308080e7          	jalr	776(ra) # 5b4a <printf>
    exit(1);
     84a:	4505                	li	a0,1
     84c:	00005097          	auipc	ra,0x5
     850:	f84080e7          	jalr	-124(ra) # 57d0 <exit>
    printf("aaa fd3=%d\n", fd3);
     854:	85ca                	mv	a1,s2
     856:	00005517          	auipc	a0,0x5
     85a:	74a50513          	addi	a0,a0,1866 # 5fa0 <malloc+0x39e>
     85e:	00005097          	auipc	ra,0x5
     862:	2ec080e7          	jalr	748(ra) # 5b4a <printf>
    printf("%s: read %d bytes, wanted 0\n", s, n);
     866:	8652                	mv	a2,s4
     868:	85d6                	mv	a1,s5
     86a:	00005517          	auipc	a0,0x5
     86e:	74650513          	addi	a0,a0,1862 # 5fb0 <malloc+0x3ae>
     872:	00005097          	auipc	ra,0x5
     876:	2d8080e7          	jalr	728(ra) # 5b4a <printf>
    exit(1);
     87a:	4505                	li	a0,1
     87c:	00005097          	auipc	ra,0x5
     880:	f54080e7          	jalr	-172(ra) # 57d0 <exit>
    printf("bbb fd2=%d\n", fd2);
     884:	85a6                	mv	a1,s1
     886:	00005517          	auipc	a0,0x5
     88a:	74a50513          	addi	a0,a0,1866 # 5fd0 <malloc+0x3ce>
     88e:	00005097          	auipc	ra,0x5
     892:	2bc080e7          	jalr	700(ra) # 5b4a <printf>
    printf("%s: read %d bytes, wanted 0\n", s, n);
     896:	8652                	mv	a2,s4
     898:	85d6                	mv	a1,s5
     89a:	00005517          	auipc	a0,0x5
     89e:	71650513          	addi	a0,a0,1814 # 5fb0 <malloc+0x3ae>
     8a2:	00005097          	auipc	ra,0x5
     8a6:	2a8080e7          	jalr	680(ra) # 5b4a <printf>
    exit(1);
     8aa:	4505                	li	a0,1
     8ac:	00005097          	auipc	ra,0x5
     8b0:	f24080e7          	jalr	-220(ra) # 57d0 <exit>
    printf("%s: read %d bytes, wanted 6\n", s, n);
     8b4:	862a                	mv	a2,a0
     8b6:	85d6                	mv	a1,s5
     8b8:	00005517          	auipc	a0,0x5
     8bc:	73050513          	addi	a0,a0,1840 # 5fe8 <malloc+0x3e6>
     8c0:	00005097          	auipc	ra,0x5
     8c4:	28a080e7          	jalr	650(ra) # 5b4a <printf>
    exit(1);
     8c8:	4505                	li	a0,1
     8ca:	00005097          	auipc	ra,0x5
     8ce:	f06080e7          	jalr	-250(ra) # 57d0 <exit>
    printf("%s: read %d bytes, wanted 2\n", s, n);
     8d2:	862a                	mv	a2,a0
     8d4:	85d6                	mv	a1,s5
     8d6:	00005517          	auipc	a0,0x5
     8da:	73250513          	addi	a0,a0,1842 # 6008 <malloc+0x406>
     8de:	00005097          	auipc	ra,0x5
     8e2:	26c080e7          	jalr	620(ra) # 5b4a <printf>
    exit(1);
     8e6:	4505                	li	a0,1
     8e8:	00005097          	auipc	ra,0x5
     8ec:	ee8080e7          	jalr	-280(ra) # 57d0 <exit>

00000000000008f0 <writetest>:
{
     8f0:	7139                	addi	sp,sp,-64
     8f2:	fc06                	sd	ra,56(sp)
     8f4:	f822                	sd	s0,48(sp)
     8f6:	f426                	sd	s1,40(sp)
     8f8:	f04a                	sd	s2,32(sp)
     8fa:	ec4e                	sd	s3,24(sp)
     8fc:	e852                	sd	s4,16(sp)
     8fe:	e456                	sd	s5,8(sp)
     900:	e05a                	sd	s6,0(sp)
     902:	0080                	addi	s0,sp,64
     904:	8b2a                	mv	s6,a0
  fd = open("small", O_CREATE|O_RDWR);
     906:	20200593          	li	a1,514
     90a:	00005517          	auipc	a0,0x5
     90e:	71e50513          	addi	a0,a0,1822 # 6028 <malloc+0x426>
     912:	00005097          	auipc	ra,0x5
     916:	efe080e7          	jalr	-258(ra) # 5810 <open>
  if(fd < 0){
     91a:	0a054d63          	bltz	a0,9d4 <writetest+0xe4>
     91e:	892a                	mv	s2,a0
     920:	4481                	li	s1,0
    if(write(fd, "aaaaaaaaaa", SZ) != SZ){
     922:	00005997          	auipc	s3,0x5
     926:	72e98993          	addi	s3,s3,1838 # 6050 <malloc+0x44e>
    if(write(fd, "bbbbbbbbbb", SZ) != SZ){
     92a:	00005a97          	auipc	s5,0x5
     92e:	75ea8a93          	addi	s5,s5,1886 # 6088 <malloc+0x486>
  for(i = 0; i < N; i++){
     932:	06400a13          	li	s4,100
    if(write(fd, "aaaaaaaaaa", SZ) != SZ){
     936:	4629                	li	a2,10
     938:	85ce                	mv	a1,s3
     93a:	854a                	mv	a0,s2
     93c:	00005097          	auipc	ra,0x5
     940:	eb4080e7          	jalr	-332(ra) # 57f0 <write>
     944:	47a9                	li	a5,10
     946:	0af51563          	bne	a0,a5,9f0 <writetest+0x100>
    if(write(fd, "bbbbbbbbbb", SZ) != SZ){
     94a:	4629                	li	a2,10
     94c:	85d6                	mv	a1,s5
     94e:	854a                	mv	a0,s2
     950:	00005097          	auipc	ra,0x5
     954:	ea0080e7          	jalr	-352(ra) # 57f0 <write>
     958:	47a9                	li	a5,10
     95a:	0af51a63          	bne	a0,a5,a0e <writetest+0x11e>
  for(i = 0; i < N; i++){
     95e:	2485                	addiw	s1,s1,1
     960:	fd449be3          	bne	s1,s4,936 <writetest+0x46>
  close(fd);
     964:	854a                	mv	a0,s2
     966:	00005097          	auipc	ra,0x5
     96a:	e92080e7          	jalr	-366(ra) # 57f8 <close>
  fd = open("small", O_RDONLY);
     96e:	4581                	li	a1,0
     970:	00005517          	auipc	a0,0x5
     974:	6b850513          	addi	a0,a0,1720 # 6028 <malloc+0x426>
     978:	00005097          	auipc	ra,0x5
     97c:	e98080e7          	jalr	-360(ra) # 5810 <open>
     980:	84aa                	mv	s1,a0
  if(fd < 0){
     982:	0a054563          	bltz	a0,a2c <writetest+0x13c>
  i = read(fd, buf, N*SZ*2);
     986:	7d000613          	li	a2,2000
     98a:	0000b597          	auipc	a1,0xb
     98e:	3ee58593          	addi	a1,a1,1006 # bd78 <buf>
     992:	00005097          	auipc	ra,0x5
     996:	e56080e7          	jalr	-426(ra) # 57e8 <read>
  if(i != N*SZ*2){
     99a:	7d000793          	li	a5,2000
     99e:	0af51563          	bne	a0,a5,a48 <writetest+0x158>
  close(fd);
     9a2:	8526                	mv	a0,s1
     9a4:	00005097          	auipc	ra,0x5
     9a8:	e54080e7          	jalr	-428(ra) # 57f8 <close>
  if(unlink("small") < 0){
     9ac:	00005517          	auipc	a0,0x5
     9b0:	67c50513          	addi	a0,a0,1660 # 6028 <malloc+0x426>
     9b4:	00005097          	auipc	ra,0x5
     9b8:	e6c080e7          	jalr	-404(ra) # 5820 <unlink>
     9bc:	0a054463          	bltz	a0,a64 <writetest+0x174>
}
     9c0:	70e2                	ld	ra,56(sp)
     9c2:	7442                	ld	s0,48(sp)
     9c4:	74a2                	ld	s1,40(sp)
     9c6:	7902                	ld	s2,32(sp)
     9c8:	69e2                	ld	s3,24(sp)
     9ca:	6a42                	ld	s4,16(sp)
     9cc:	6aa2                	ld	s5,8(sp)
     9ce:	6b02                	ld	s6,0(sp)
     9d0:	6121                	addi	sp,sp,64
     9d2:	8082                	ret
    printf("%s: error: creat small failed!\n", s);
     9d4:	85da                	mv	a1,s6
     9d6:	00005517          	auipc	a0,0x5
     9da:	65a50513          	addi	a0,a0,1626 # 6030 <malloc+0x42e>
     9de:	00005097          	auipc	ra,0x5
     9e2:	16c080e7          	jalr	364(ra) # 5b4a <printf>
    exit(1);
     9e6:	4505                	li	a0,1
     9e8:	00005097          	auipc	ra,0x5
     9ec:	de8080e7          	jalr	-536(ra) # 57d0 <exit>
      printf("%s: error: write aa %d new file failed\n", s, i);
     9f0:	8626                	mv	a2,s1
     9f2:	85da                	mv	a1,s6
     9f4:	00005517          	auipc	a0,0x5
     9f8:	66c50513          	addi	a0,a0,1644 # 6060 <malloc+0x45e>
     9fc:	00005097          	auipc	ra,0x5
     a00:	14e080e7          	jalr	334(ra) # 5b4a <printf>
      exit(1);
     a04:	4505                	li	a0,1
     a06:	00005097          	auipc	ra,0x5
     a0a:	dca080e7          	jalr	-566(ra) # 57d0 <exit>
      printf("%s: error: write bb %d new file failed\n", s, i);
     a0e:	8626                	mv	a2,s1
     a10:	85da                	mv	a1,s6
     a12:	00005517          	auipc	a0,0x5
     a16:	68650513          	addi	a0,a0,1670 # 6098 <malloc+0x496>
     a1a:	00005097          	auipc	ra,0x5
     a1e:	130080e7          	jalr	304(ra) # 5b4a <printf>
      exit(1);
     a22:	4505                	li	a0,1
     a24:	00005097          	auipc	ra,0x5
     a28:	dac080e7          	jalr	-596(ra) # 57d0 <exit>
    printf("%s: error: open small failed!\n", s);
     a2c:	85da                	mv	a1,s6
     a2e:	00005517          	auipc	a0,0x5
     a32:	69250513          	addi	a0,a0,1682 # 60c0 <malloc+0x4be>
     a36:	00005097          	auipc	ra,0x5
     a3a:	114080e7          	jalr	276(ra) # 5b4a <printf>
    exit(1);
     a3e:	4505                	li	a0,1
     a40:	00005097          	auipc	ra,0x5
     a44:	d90080e7          	jalr	-624(ra) # 57d0 <exit>
    printf("%s: read failed\n", s);
     a48:	85da                	mv	a1,s6
     a4a:	00005517          	auipc	a0,0x5
     a4e:	69650513          	addi	a0,a0,1686 # 60e0 <malloc+0x4de>
     a52:	00005097          	auipc	ra,0x5
     a56:	0f8080e7          	jalr	248(ra) # 5b4a <printf>
    exit(1);
     a5a:	4505                	li	a0,1
     a5c:	00005097          	auipc	ra,0x5
     a60:	d74080e7          	jalr	-652(ra) # 57d0 <exit>
    printf("%s: unlink small failed\n", s);
     a64:	85da                	mv	a1,s6
     a66:	00005517          	auipc	a0,0x5
     a6a:	69250513          	addi	a0,a0,1682 # 60f8 <malloc+0x4f6>
     a6e:	00005097          	auipc	ra,0x5
     a72:	0dc080e7          	jalr	220(ra) # 5b4a <printf>
    exit(1);
     a76:	4505                	li	a0,1
     a78:	00005097          	auipc	ra,0x5
     a7c:	d58080e7          	jalr	-680(ra) # 57d0 <exit>

0000000000000a80 <writebig>:
{
     a80:	7139                	addi	sp,sp,-64
     a82:	fc06                	sd	ra,56(sp)
     a84:	f822                	sd	s0,48(sp)
     a86:	f426                	sd	s1,40(sp)
     a88:	f04a                	sd	s2,32(sp)
     a8a:	ec4e                	sd	s3,24(sp)
     a8c:	e852                	sd	s4,16(sp)
     a8e:	e456                	sd	s5,8(sp)
     a90:	0080                	addi	s0,sp,64
     a92:	8aaa                	mv	s5,a0
  fd = open("big", O_CREATE|O_RDWR);
     a94:	20200593          	li	a1,514
     a98:	00005517          	auipc	a0,0x5
     a9c:	68050513          	addi	a0,a0,1664 # 6118 <malloc+0x516>
     aa0:	00005097          	auipc	ra,0x5
     aa4:	d70080e7          	jalr	-656(ra) # 5810 <open>
     aa8:	89aa                	mv	s3,a0
  for(i = 0; i < MAXFILE; i++){
     aaa:	4481                	li	s1,0
    ((int*)buf)[0] = i;
     aac:	0000b917          	auipc	s2,0xb
     ab0:	2cc90913          	addi	s2,s2,716 # bd78 <buf>
  for(i = 0; i < MAXFILE; i++){
     ab4:	10c00a13          	li	s4,268
  if(fd < 0){
     ab8:	06054c63          	bltz	a0,b30 <writebig+0xb0>
    ((int*)buf)[0] = i;
     abc:	00992023          	sw	s1,0(s2)
    if(write(fd, buf, BSIZE) != BSIZE){
     ac0:	40000613          	li	a2,1024
     ac4:	85ca                	mv	a1,s2
     ac6:	854e                	mv	a0,s3
     ac8:	00005097          	auipc	ra,0x5
     acc:	d28080e7          	jalr	-728(ra) # 57f0 <write>
     ad0:	40000793          	li	a5,1024
     ad4:	06f51c63          	bne	a0,a5,b4c <writebig+0xcc>
  for(i = 0; i < MAXFILE; i++){
     ad8:	2485                	addiw	s1,s1,1
     ada:	ff4491e3          	bne	s1,s4,abc <writebig+0x3c>
  close(fd);
     ade:	854e                	mv	a0,s3
     ae0:	00005097          	auipc	ra,0x5
     ae4:	d18080e7          	jalr	-744(ra) # 57f8 <close>
  fd = open("big", O_RDONLY);
     ae8:	4581                	li	a1,0
     aea:	00005517          	auipc	a0,0x5
     aee:	62e50513          	addi	a0,a0,1582 # 6118 <malloc+0x516>
     af2:	00005097          	auipc	ra,0x5
     af6:	d1e080e7          	jalr	-738(ra) # 5810 <open>
     afa:	89aa                	mv	s3,a0
  n = 0;
     afc:	4481                	li	s1,0
    i = read(fd, buf, BSIZE);
     afe:	0000b917          	auipc	s2,0xb
     b02:	27a90913          	addi	s2,s2,634 # bd78 <buf>
  if(fd < 0){
     b06:	06054263          	bltz	a0,b6a <writebig+0xea>
    i = read(fd, buf, BSIZE);
     b0a:	40000613          	li	a2,1024
     b0e:	85ca                	mv	a1,s2
     b10:	854e                	mv	a0,s3
     b12:	00005097          	auipc	ra,0x5
     b16:	cd6080e7          	jalr	-810(ra) # 57e8 <read>
    if(i == 0){
     b1a:	c535                	beqz	a0,b86 <writebig+0x106>
    } else if(i != BSIZE){
     b1c:	40000793          	li	a5,1024
     b20:	0af51f63          	bne	a0,a5,bde <writebig+0x15e>
    if(((int*)buf)[0] != n){
     b24:	00092683          	lw	a3,0(s2)
     b28:	0c969a63          	bne	a3,s1,bfc <writebig+0x17c>
    n++;
     b2c:	2485                	addiw	s1,s1,1
    i = read(fd, buf, BSIZE);
     b2e:	bff1                	j	b0a <writebig+0x8a>
    printf("%s: error: creat big failed!\n", s);
     b30:	85d6                	mv	a1,s5
     b32:	00005517          	auipc	a0,0x5
     b36:	5ee50513          	addi	a0,a0,1518 # 6120 <malloc+0x51e>
     b3a:	00005097          	auipc	ra,0x5
     b3e:	010080e7          	jalr	16(ra) # 5b4a <printf>
    exit(1);
     b42:	4505                	li	a0,1
     b44:	00005097          	auipc	ra,0x5
     b48:	c8c080e7          	jalr	-884(ra) # 57d0 <exit>
      printf("%s: error: write big file failed\n", s, i);
     b4c:	8626                	mv	a2,s1
     b4e:	85d6                	mv	a1,s5
     b50:	00005517          	auipc	a0,0x5
     b54:	5f050513          	addi	a0,a0,1520 # 6140 <malloc+0x53e>
     b58:	00005097          	auipc	ra,0x5
     b5c:	ff2080e7          	jalr	-14(ra) # 5b4a <printf>
      exit(1);
     b60:	4505                	li	a0,1
     b62:	00005097          	auipc	ra,0x5
     b66:	c6e080e7          	jalr	-914(ra) # 57d0 <exit>
    printf("%s: error: open big failed!\n", s);
     b6a:	85d6                	mv	a1,s5
     b6c:	00005517          	auipc	a0,0x5
     b70:	5fc50513          	addi	a0,a0,1532 # 6168 <malloc+0x566>
     b74:	00005097          	auipc	ra,0x5
     b78:	fd6080e7          	jalr	-42(ra) # 5b4a <printf>
    exit(1);
     b7c:	4505                	li	a0,1
     b7e:	00005097          	auipc	ra,0x5
     b82:	c52080e7          	jalr	-942(ra) # 57d0 <exit>
      if(n == MAXFILE - 1){
     b86:	10b00793          	li	a5,267
     b8a:	02f48a63          	beq	s1,a5,bbe <writebig+0x13e>
  close(fd);
     b8e:	854e                	mv	a0,s3
     b90:	00005097          	auipc	ra,0x5
     b94:	c68080e7          	jalr	-920(ra) # 57f8 <close>
  if(unlink("big") < 0){
     b98:	00005517          	auipc	a0,0x5
     b9c:	58050513          	addi	a0,a0,1408 # 6118 <malloc+0x516>
     ba0:	00005097          	auipc	ra,0x5
     ba4:	c80080e7          	jalr	-896(ra) # 5820 <unlink>
     ba8:	06054963          	bltz	a0,c1a <writebig+0x19a>
}
     bac:	70e2                	ld	ra,56(sp)
     bae:	7442                	ld	s0,48(sp)
     bb0:	74a2                	ld	s1,40(sp)
     bb2:	7902                	ld	s2,32(sp)
     bb4:	69e2                	ld	s3,24(sp)
     bb6:	6a42                	ld	s4,16(sp)
     bb8:	6aa2                	ld	s5,8(sp)
     bba:	6121                	addi	sp,sp,64
     bbc:	8082                	ret
        printf("%s: read only %d blocks from big", s, n);
     bbe:	10b00613          	li	a2,267
     bc2:	85d6                	mv	a1,s5
     bc4:	00005517          	auipc	a0,0x5
     bc8:	5c450513          	addi	a0,a0,1476 # 6188 <malloc+0x586>
     bcc:	00005097          	auipc	ra,0x5
     bd0:	f7e080e7          	jalr	-130(ra) # 5b4a <printf>
        exit(1);
     bd4:	4505                	li	a0,1
     bd6:	00005097          	auipc	ra,0x5
     bda:	bfa080e7          	jalr	-1030(ra) # 57d0 <exit>
      printf("%s: read failed %d\n", s, i);
     bde:	862a                	mv	a2,a0
     be0:	85d6                	mv	a1,s5
     be2:	00005517          	auipc	a0,0x5
     be6:	5ce50513          	addi	a0,a0,1486 # 61b0 <malloc+0x5ae>
     bea:	00005097          	auipc	ra,0x5
     bee:	f60080e7          	jalr	-160(ra) # 5b4a <printf>
      exit(1);
     bf2:	4505                	li	a0,1
     bf4:	00005097          	auipc	ra,0x5
     bf8:	bdc080e7          	jalr	-1060(ra) # 57d0 <exit>
      printf("%s: read content of block %d is %d\n", s,
     bfc:	8626                	mv	a2,s1
     bfe:	85d6                	mv	a1,s5
     c00:	00005517          	auipc	a0,0x5
     c04:	5c850513          	addi	a0,a0,1480 # 61c8 <malloc+0x5c6>
     c08:	00005097          	auipc	ra,0x5
     c0c:	f42080e7          	jalr	-190(ra) # 5b4a <printf>
      exit(1);
     c10:	4505                	li	a0,1
     c12:	00005097          	auipc	ra,0x5
     c16:	bbe080e7          	jalr	-1090(ra) # 57d0 <exit>
    printf("%s: unlink big failed\n", s);
     c1a:	85d6                	mv	a1,s5
     c1c:	00005517          	auipc	a0,0x5
     c20:	5d450513          	addi	a0,a0,1492 # 61f0 <malloc+0x5ee>
     c24:	00005097          	auipc	ra,0x5
     c28:	f26080e7          	jalr	-218(ra) # 5b4a <printf>
    exit(1);
     c2c:	4505                	li	a0,1
     c2e:	00005097          	auipc	ra,0x5
     c32:	ba2080e7          	jalr	-1118(ra) # 57d0 <exit>

0000000000000c36 <unlinkread>:
{
     c36:	7179                	addi	sp,sp,-48
     c38:	f406                	sd	ra,40(sp)
     c3a:	f022                	sd	s0,32(sp)
     c3c:	ec26                	sd	s1,24(sp)
     c3e:	e84a                	sd	s2,16(sp)
     c40:	e44e                	sd	s3,8(sp)
     c42:	1800                	addi	s0,sp,48
     c44:	89aa                	mv	s3,a0
  fd = open("unlinkread", O_CREATE | O_RDWR);
     c46:	20200593          	li	a1,514
     c4a:	00005517          	auipc	a0,0x5
     c4e:	5be50513          	addi	a0,a0,1470 # 6208 <malloc+0x606>
     c52:	00005097          	auipc	ra,0x5
     c56:	bbe080e7          	jalr	-1090(ra) # 5810 <open>
  if(fd < 0){
     c5a:	0e054563          	bltz	a0,d44 <unlinkread+0x10e>
     c5e:	84aa                	mv	s1,a0
  write(fd, "hello", SZ);
     c60:	4615                	li	a2,5
     c62:	00005597          	auipc	a1,0x5
     c66:	5d658593          	addi	a1,a1,1494 # 6238 <malloc+0x636>
     c6a:	00005097          	auipc	ra,0x5
     c6e:	b86080e7          	jalr	-1146(ra) # 57f0 <write>
  close(fd);
     c72:	8526                	mv	a0,s1
     c74:	00005097          	auipc	ra,0x5
     c78:	b84080e7          	jalr	-1148(ra) # 57f8 <close>
  fd = open("unlinkread", O_RDWR);
     c7c:	4589                	li	a1,2
     c7e:	00005517          	auipc	a0,0x5
     c82:	58a50513          	addi	a0,a0,1418 # 6208 <malloc+0x606>
     c86:	00005097          	auipc	ra,0x5
     c8a:	b8a080e7          	jalr	-1142(ra) # 5810 <open>
     c8e:	84aa                	mv	s1,a0
  if(fd < 0){
     c90:	0c054863          	bltz	a0,d60 <unlinkread+0x12a>
  if(unlink("unlinkread") != 0){
     c94:	00005517          	auipc	a0,0x5
     c98:	57450513          	addi	a0,a0,1396 # 6208 <malloc+0x606>
     c9c:	00005097          	auipc	ra,0x5
     ca0:	b84080e7          	jalr	-1148(ra) # 5820 <unlink>
     ca4:	ed61                	bnez	a0,d7c <unlinkread+0x146>
  fd1 = open("unlinkread", O_CREATE | O_RDWR);
     ca6:	20200593          	li	a1,514
     caa:	00005517          	auipc	a0,0x5
     cae:	55e50513          	addi	a0,a0,1374 # 6208 <malloc+0x606>
     cb2:	00005097          	auipc	ra,0x5
     cb6:	b5e080e7          	jalr	-1186(ra) # 5810 <open>
     cba:	892a                	mv	s2,a0
  write(fd1, "yyy", 3);
     cbc:	460d                	li	a2,3
     cbe:	00005597          	auipc	a1,0x5
     cc2:	5c258593          	addi	a1,a1,1474 # 6280 <malloc+0x67e>
     cc6:	00005097          	auipc	ra,0x5
     cca:	b2a080e7          	jalr	-1238(ra) # 57f0 <write>
  close(fd1);
     cce:	854a                	mv	a0,s2
     cd0:	00005097          	auipc	ra,0x5
     cd4:	b28080e7          	jalr	-1240(ra) # 57f8 <close>
  if(read(fd, buf, sizeof(buf)) != SZ){
     cd8:	660d                	lui	a2,0x3
     cda:	0000b597          	auipc	a1,0xb
     cde:	09e58593          	addi	a1,a1,158 # bd78 <buf>
     ce2:	8526                	mv	a0,s1
     ce4:	00005097          	auipc	ra,0x5
     ce8:	b04080e7          	jalr	-1276(ra) # 57e8 <read>
     cec:	4795                	li	a5,5
     cee:	0af51563          	bne	a0,a5,d98 <unlinkread+0x162>
  if(buf[0] != 'h'){
     cf2:	0000b717          	auipc	a4,0xb
     cf6:	08674703          	lbu	a4,134(a4) # bd78 <buf>
     cfa:	06800793          	li	a5,104
     cfe:	0af71b63          	bne	a4,a5,db4 <unlinkread+0x17e>
  if(write(fd, buf, 10) != 10){
     d02:	4629                	li	a2,10
     d04:	0000b597          	auipc	a1,0xb
     d08:	07458593          	addi	a1,a1,116 # bd78 <buf>
     d0c:	8526                	mv	a0,s1
     d0e:	00005097          	auipc	ra,0x5
     d12:	ae2080e7          	jalr	-1310(ra) # 57f0 <write>
     d16:	47a9                	li	a5,10
     d18:	0af51c63          	bne	a0,a5,dd0 <unlinkread+0x19a>
  close(fd);
     d1c:	8526                	mv	a0,s1
     d1e:	00005097          	auipc	ra,0x5
     d22:	ada080e7          	jalr	-1318(ra) # 57f8 <close>
  unlink("unlinkread");
     d26:	00005517          	auipc	a0,0x5
     d2a:	4e250513          	addi	a0,a0,1250 # 6208 <malloc+0x606>
     d2e:	00005097          	auipc	ra,0x5
     d32:	af2080e7          	jalr	-1294(ra) # 5820 <unlink>
}
     d36:	70a2                	ld	ra,40(sp)
     d38:	7402                	ld	s0,32(sp)
     d3a:	64e2                	ld	s1,24(sp)
     d3c:	6942                	ld	s2,16(sp)
     d3e:	69a2                	ld	s3,8(sp)
     d40:	6145                	addi	sp,sp,48
     d42:	8082                	ret
    printf("%s: create unlinkread failed\n", s);
     d44:	85ce                	mv	a1,s3
     d46:	00005517          	auipc	a0,0x5
     d4a:	4d250513          	addi	a0,a0,1234 # 6218 <malloc+0x616>
     d4e:	00005097          	auipc	ra,0x5
     d52:	dfc080e7          	jalr	-516(ra) # 5b4a <printf>
    exit(1);
     d56:	4505                	li	a0,1
     d58:	00005097          	auipc	ra,0x5
     d5c:	a78080e7          	jalr	-1416(ra) # 57d0 <exit>
    printf("%s: open unlinkread failed\n", s);
     d60:	85ce                	mv	a1,s3
     d62:	00005517          	auipc	a0,0x5
     d66:	4de50513          	addi	a0,a0,1246 # 6240 <malloc+0x63e>
     d6a:	00005097          	auipc	ra,0x5
     d6e:	de0080e7          	jalr	-544(ra) # 5b4a <printf>
    exit(1);
     d72:	4505                	li	a0,1
     d74:	00005097          	auipc	ra,0x5
     d78:	a5c080e7          	jalr	-1444(ra) # 57d0 <exit>
    printf("%s: unlink unlinkread failed\n", s);
     d7c:	85ce                	mv	a1,s3
     d7e:	00005517          	auipc	a0,0x5
     d82:	4e250513          	addi	a0,a0,1250 # 6260 <malloc+0x65e>
     d86:	00005097          	auipc	ra,0x5
     d8a:	dc4080e7          	jalr	-572(ra) # 5b4a <printf>
    exit(1);
     d8e:	4505                	li	a0,1
     d90:	00005097          	auipc	ra,0x5
     d94:	a40080e7          	jalr	-1472(ra) # 57d0 <exit>
    printf("%s: unlinkread read failed", s);
     d98:	85ce                	mv	a1,s3
     d9a:	00005517          	auipc	a0,0x5
     d9e:	4ee50513          	addi	a0,a0,1262 # 6288 <malloc+0x686>
     da2:	00005097          	auipc	ra,0x5
     da6:	da8080e7          	jalr	-600(ra) # 5b4a <printf>
    exit(1);
     daa:	4505                	li	a0,1
     dac:	00005097          	auipc	ra,0x5
     db0:	a24080e7          	jalr	-1500(ra) # 57d0 <exit>
    printf("%s: unlinkread wrong data\n", s);
     db4:	85ce                	mv	a1,s3
     db6:	00005517          	auipc	a0,0x5
     dba:	4f250513          	addi	a0,a0,1266 # 62a8 <malloc+0x6a6>
     dbe:	00005097          	auipc	ra,0x5
     dc2:	d8c080e7          	jalr	-628(ra) # 5b4a <printf>
    exit(1);
     dc6:	4505                	li	a0,1
     dc8:	00005097          	auipc	ra,0x5
     dcc:	a08080e7          	jalr	-1528(ra) # 57d0 <exit>
    printf("%s: unlinkread write failed\n", s);
     dd0:	85ce                	mv	a1,s3
     dd2:	00005517          	auipc	a0,0x5
     dd6:	4f650513          	addi	a0,a0,1270 # 62c8 <malloc+0x6c6>
     dda:	00005097          	auipc	ra,0x5
     dde:	d70080e7          	jalr	-656(ra) # 5b4a <printf>
    exit(1);
     de2:	4505                	li	a0,1
     de4:	00005097          	auipc	ra,0x5
     de8:	9ec080e7          	jalr	-1556(ra) # 57d0 <exit>

0000000000000dec <linktest>:
{
     dec:	1101                	addi	sp,sp,-32
     dee:	ec06                	sd	ra,24(sp)
     df0:	e822                	sd	s0,16(sp)
     df2:	e426                	sd	s1,8(sp)
     df4:	e04a                	sd	s2,0(sp)
     df6:	1000                	addi	s0,sp,32
     df8:	892a                	mv	s2,a0
  unlink("lf1");
     dfa:	00005517          	auipc	a0,0x5
     dfe:	4ee50513          	addi	a0,a0,1262 # 62e8 <malloc+0x6e6>
     e02:	00005097          	auipc	ra,0x5
     e06:	a1e080e7          	jalr	-1506(ra) # 5820 <unlink>
  unlink("lf2");
     e0a:	00005517          	auipc	a0,0x5
     e0e:	4e650513          	addi	a0,a0,1254 # 62f0 <malloc+0x6ee>
     e12:	00005097          	auipc	ra,0x5
     e16:	a0e080e7          	jalr	-1522(ra) # 5820 <unlink>
  fd = open("lf1", O_CREATE|O_RDWR);
     e1a:	20200593          	li	a1,514
     e1e:	00005517          	auipc	a0,0x5
     e22:	4ca50513          	addi	a0,a0,1226 # 62e8 <malloc+0x6e6>
     e26:	00005097          	auipc	ra,0x5
     e2a:	9ea080e7          	jalr	-1558(ra) # 5810 <open>
  if(fd < 0){
     e2e:	10054763          	bltz	a0,f3c <linktest+0x150>
     e32:	84aa                	mv	s1,a0
  if(write(fd, "hello", SZ) != SZ){
     e34:	4615                	li	a2,5
     e36:	00005597          	auipc	a1,0x5
     e3a:	40258593          	addi	a1,a1,1026 # 6238 <malloc+0x636>
     e3e:	00005097          	auipc	ra,0x5
     e42:	9b2080e7          	jalr	-1614(ra) # 57f0 <write>
     e46:	4795                	li	a5,5
     e48:	10f51863          	bne	a0,a5,f58 <linktest+0x16c>
  close(fd);
     e4c:	8526                	mv	a0,s1
     e4e:	00005097          	auipc	ra,0x5
     e52:	9aa080e7          	jalr	-1622(ra) # 57f8 <close>
  if(link("lf1", "lf2") < 0){
     e56:	00005597          	auipc	a1,0x5
     e5a:	49a58593          	addi	a1,a1,1178 # 62f0 <malloc+0x6ee>
     e5e:	00005517          	auipc	a0,0x5
     e62:	48a50513          	addi	a0,a0,1162 # 62e8 <malloc+0x6e6>
     e66:	00005097          	auipc	ra,0x5
     e6a:	9ca080e7          	jalr	-1590(ra) # 5830 <link>
     e6e:	10054363          	bltz	a0,f74 <linktest+0x188>
  unlink("lf1");
     e72:	00005517          	auipc	a0,0x5
     e76:	47650513          	addi	a0,a0,1142 # 62e8 <malloc+0x6e6>
     e7a:	00005097          	auipc	ra,0x5
     e7e:	9a6080e7          	jalr	-1626(ra) # 5820 <unlink>
  if(open("lf1", 0) >= 0){
     e82:	4581                	li	a1,0
     e84:	00005517          	auipc	a0,0x5
     e88:	46450513          	addi	a0,a0,1124 # 62e8 <malloc+0x6e6>
     e8c:	00005097          	auipc	ra,0x5
     e90:	984080e7          	jalr	-1660(ra) # 5810 <open>
     e94:	0e055e63          	bgez	a0,f90 <linktest+0x1a4>
  fd = open("lf2", 0);
     e98:	4581                	li	a1,0
     e9a:	00005517          	auipc	a0,0x5
     e9e:	45650513          	addi	a0,a0,1110 # 62f0 <malloc+0x6ee>
     ea2:	00005097          	auipc	ra,0x5
     ea6:	96e080e7          	jalr	-1682(ra) # 5810 <open>
     eaa:	84aa                	mv	s1,a0
  if(fd < 0){
     eac:	10054063          	bltz	a0,fac <linktest+0x1c0>
  if(read(fd, buf, sizeof(buf)) != SZ){
     eb0:	660d                	lui	a2,0x3
     eb2:	0000b597          	auipc	a1,0xb
     eb6:	ec658593          	addi	a1,a1,-314 # bd78 <buf>
     eba:	00005097          	auipc	ra,0x5
     ebe:	92e080e7          	jalr	-1746(ra) # 57e8 <read>
     ec2:	4795                	li	a5,5
     ec4:	10f51263          	bne	a0,a5,fc8 <linktest+0x1dc>
  close(fd);
     ec8:	8526                	mv	a0,s1
     eca:	00005097          	auipc	ra,0x5
     ece:	92e080e7          	jalr	-1746(ra) # 57f8 <close>
  if(link("lf2", "lf2") >= 0){
     ed2:	00005597          	auipc	a1,0x5
     ed6:	41e58593          	addi	a1,a1,1054 # 62f0 <malloc+0x6ee>
     eda:	852e                	mv	a0,a1
     edc:	00005097          	auipc	ra,0x5
     ee0:	954080e7          	jalr	-1708(ra) # 5830 <link>
     ee4:	10055063          	bgez	a0,fe4 <linktest+0x1f8>
  unlink("lf2");
     ee8:	00005517          	auipc	a0,0x5
     eec:	40850513          	addi	a0,a0,1032 # 62f0 <malloc+0x6ee>
     ef0:	00005097          	auipc	ra,0x5
     ef4:	930080e7          	jalr	-1744(ra) # 5820 <unlink>
  if(link("lf2", "lf1") >= 0){
     ef8:	00005597          	auipc	a1,0x5
     efc:	3f058593          	addi	a1,a1,1008 # 62e8 <malloc+0x6e6>
     f00:	00005517          	auipc	a0,0x5
     f04:	3f050513          	addi	a0,a0,1008 # 62f0 <malloc+0x6ee>
     f08:	00005097          	auipc	ra,0x5
     f0c:	928080e7          	jalr	-1752(ra) # 5830 <link>
     f10:	0e055863          	bgez	a0,1000 <linktest+0x214>
  if(link(".", "lf1") >= 0){
     f14:	00005597          	auipc	a1,0x5
     f18:	3d458593          	addi	a1,a1,980 # 62e8 <malloc+0x6e6>
     f1c:	00005517          	auipc	a0,0x5
     f20:	4dc50513          	addi	a0,a0,1244 # 63f8 <malloc+0x7f6>
     f24:	00005097          	auipc	ra,0x5
     f28:	90c080e7          	jalr	-1780(ra) # 5830 <link>
     f2c:	0e055863          	bgez	a0,101c <linktest+0x230>
}
     f30:	60e2                	ld	ra,24(sp)
     f32:	6442                	ld	s0,16(sp)
     f34:	64a2                	ld	s1,8(sp)
     f36:	6902                	ld	s2,0(sp)
     f38:	6105                	addi	sp,sp,32
     f3a:	8082                	ret
    printf("%s: create lf1 failed\n", s);
     f3c:	85ca                	mv	a1,s2
     f3e:	00005517          	auipc	a0,0x5
     f42:	3ba50513          	addi	a0,a0,954 # 62f8 <malloc+0x6f6>
     f46:	00005097          	auipc	ra,0x5
     f4a:	c04080e7          	jalr	-1020(ra) # 5b4a <printf>
    exit(1);
     f4e:	4505                	li	a0,1
     f50:	00005097          	auipc	ra,0x5
     f54:	880080e7          	jalr	-1920(ra) # 57d0 <exit>
    printf("%s: write lf1 failed\n", s);
     f58:	85ca                	mv	a1,s2
     f5a:	00005517          	auipc	a0,0x5
     f5e:	3b650513          	addi	a0,a0,950 # 6310 <malloc+0x70e>
     f62:	00005097          	auipc	ra,0x5
     f66:	be8080e7          	jalr	-1048(ra) # 5b4a <printf>
    exit(1);
     f6a:	4505                	li	a0,1
     f6c:	00005097          	auipc	ra,0x5
     f70:	864080e7          	jalr	-1948(ra) # 57d0 <exit>
    printf("%s: link lf1 lf2 failed\n", s);
     f74:	85ca                	mv	a1,s2
     f76:	00005517          	auipc	a0,0x5
     f7a:	3b250513          	addi	a0,a0,946 # 6328 <malloc+0x726>
     f7e:	00005097          	auipc	ra,0x5
     f82:	bcc080e7          	jalr	-1076(ra) # 5b4a <printf>
    exit(1);
     f86:	4505                	li	a0,1
     f88:	00005097          	auipc	ra,0x5
     f8c:	848080e7          	jalr	-1976(ra) # 57d0 <exit>
    printf("%s: unlinked lf1 but it is still there!\n", s);
     f90:	85ca                	mv	a1,s2
     f92:	00005517          	auipc	a0,0x5
     f96:	3b650513          	addi	a0,a0,950 # 6348 <malloc+0x746>
     f9a:	00005097          	auipc	ra,0x5
     f9e:	bb0080e7          	jalr	-1104(ra) # 5b4a <printf>
    exit(1);
     fa2:	4505                	li	a0,1
     fa4:	00005097          	auipc	ra,0x5
     fa8:	82c080e7          	jalr	-2004(ra) # 57d0 <exit>
    printf("%s: open lf2 failed\n", s);
     fac:	85ca                	mv	a1,s2
     fae:	00005517          	auipc	a0,0x5
     fb2:	3ca50513          	addi	a0,a0,970 # 6378 <malloc+0x776>
     fb6:	00005097          	auipc	ra,0x5
     fba:	b94080e7          	jalr	-1132(ra) # 5b4a <printf>
    exit(1);
     fbe:	4505                	li	a0,1
     fc0:	00005097          	auipc	ra,0x5
     fc4:	810080e7          	jalr	-2032(ra) # 57d0 <exit>
    printf("%s: read lf2 failed\n", s);
     fc8:	85ca                	mv	a1,s2
     fca:	00005517          	auipc	a0,0x5
     fce:	3c650513          	addi	a0,a0,966 # 6390 <malloc+0x78e>
     fd2:	00005097          	auipc	ra,0x5
     fd6:	b78080e7          	jalr	-1160(ra) # 5b4a <printf>
    exit(1);
     fda:	4505                	li	a0,1
     fdc:	00004097          	auipc	ra,0x4
     fe0:	7f4080e7          	jalr	2036(ra) # 57d0 <exit>
    printf("%s: link lf2 lf2 succeeded! oops\n", s);
     fe4:	85ca                	mv	a1,s2
     fe6:	00005517          	auipc	a0,0x5
     fea:	3c250513          	addi	a0,a0,962 # 63a8 <malloc+0x7a6>
     fee:	00005097          	auipc	ra,0x5
     ff2:	b5c080e7          	jalr	-1188(ra) # 5b4a <printf>
    exit(1);
     ff6:	4505                	li	a0,1
     ff8:	00004097          	auipc	ra,0x4
     ffc:	7d8080e7          	jalr	2008(ra) # 57d0 <exit>
    printf("%s: link non-existent succeeded! oops\n", s);
    1000:	85ca                	mv	a1,s2
    1002:	00005517          	auipc	a0,0x5
    1006:	3ce50513          	addi	a0,a0,974 # 63d0 <malloc+0x7ce>
    100a:	00005097          	auipc	ra,0x5
    100e:	b40080e7          	jalr	-1216(ra) # 5b4a <printf>
    exit(1);
    1012:	4505                	li	a0,1
    1014:	00004097          	auipc	ra,0x4
    1018:	7bc080e7          	jalr	1980(ra) # 57d0 <exit>
    printf("%s: link . lf1 succeeded! oops\n", s);
    101c:	85ca                	mv	a1,s2
    101e:	00005517          	auipc	a0,0x5
    1022:	3e250513          	addi	a0,a0,994 # 6400 <malloc+0x7fe>
    1026:	00005097          	auipc	ra,0x5
    102a:	b24080e7          	jalr	-1244(ra) # 5b4a <printf>
    exit(1);
    102e:	4505                	li	a0,1
    1030:	00004097          	auipc	ra,0x4
    1034:	7a0080e7          	jalr	1952(ra) # 57d0 <exit>

0000000000001038 <bigdir>:
{
    1038:	715d                	addi	sp,sp,-80
    103a:	e486                	sd	ra,72(sp)
    103c:	e0a2                	sd	s0,64(sp)
    103e:	fc26                	sd	s1,56(sp)
    1040:	f84a                	sd	s2,48(sp)
    1042:	f44e                	sd	s3,40(sp)
    1044:	f052                	sd	s4,32(sp)
    1046:	ec56                	sd	s5,24(sp)
    1048:	e85a                	sd	s6,16(sp)
    104a:	0880                	addi	s0,sp,80
    104c:	89aa                	mv	s3,a0
  unlink("bd");
    104e:	00005517          	auipc	a0,0x5
    1052:	3d250513          	addi	a0,a0,978 # 6420 <malloc+0x81e>
    1056:	00004097          	auipc	ra,0x4
    105a:	7ca080e7          	jalr	1994(ra) # 5820 <unlink>
  fd = open("bd", O_CREATE);
    105e:	20000593          	li	a1,512
    1062:	00005517          	auipc	a0,0x5
    1066:	3be50513          	addi	a0,a0,958 # 6420 <malloc+0x81e>
    106a:	00004097          	auipc	ra,0x4
    106e:	7a6080e7          	jalr	1958(ra) # 5810 <open>
  if(fd < 0){
    1072:	0c054963          	bltz	a0,1144 <bigdir+0x10c>
  close(fd);
    1076:	00004097          	auipc	ra,0x4
    107a:	782080e7          	jalr	1922(ra) # 57f8 <close>
  for(i = 0; i < N; i++){
    107e:	4901                	li	s2,0
    name[0] = 'x';
    1080:	07800a93          	li	s5,120
    if(link("bd", name) != 0){
    1084:	00005a17          	auipc	s4,0x5
    1088:	39ca0a13          	addi	s4,s4,924 # 6420 <malloc+0x81e>
  for(i = 0; i < N; i++){
    108c:	1f400b13          	li	s6,500
    name[0] = 'x';
    1090:	fb540823          	sb	s5,-80(s0)
    name[1] = '0' + (i / 64);
    1094:	41f9571b          	sraiw	a4,s2,0x1f
    1098:	01a7571b          	srliw	a4,a4,0x1a
    109c:	012707bb          	addw	a5,a4,s2
    10a0:	4067d69b          	sraiw	a3,a5,0x6
    10a4:	0306869b          	addiw	a3,a3,48
    10a8:	fad408a3          	sb	a3,-79(s0)
    name[2] = '0' + (i % 64);
    10ac:	03f7f793          	andi	a5,a5,63
    10b0:	9f99                	subw	a5,a5,a4
    10b2:	0307879b          	addiw	a5,a5,48
    10b6:	faf40923          	sb	a5,-78(s0)
    name[3] = '\0';
    10ba:	fa0409a3          	sb	zero,-77(s0)
    if(link("bd", name) != 0){
    10be:	fb040593          	addi	a1,s0,-80
    10c2:	8552                	mv	a0,s4
    10c4:	00004097          	auipc	ra,0x4
    10c8:	76c080e7          	jalr	1900(ra) # 5830 <link>
    10cc:	84aa                	mv	s1,a0
    10ce:	e949                	bnez	a0,1160 <bigdir+0x128>
  for(i = 0; i < N; i++){
    10d0:	2905                	addiw	s2,s2,1
    10d2:	fb691fe3          	bne	s2,s6,1090 <bigdir+0x58>
  unlink("bd");
    10d6:	00005517          	auipc	a0,0x5
    10da:	34a50513          	addi	a0,a0,842 # 6420 <malloc+0x81e>
    10de:	00004097          	auipc	ra,0x4
    10e2:	742080e7          	jalr	1858(ra) # 5820 <unlink>
    name[0] = 'x';
    10e6:	07800913          	li	s2,120
  for(i = 0; i < N; i++){
    10ea:	1f400a13          	li	s4,500
    name[0] = 'x';
    10ee:	fb240823          	sb	s2,-80(s0)
    name[1] = '0' + (i / 64);
    10f2:	41f4d71b          	sraiw	a4,s1,0x1f
    10f6:	01a7571b          	srliw	a4,a4,0x1a
    10fa:	009707bb          	addw	a5,a4,s1
    10fe:	4067d69b          	sraiw	a3,a5,0x6
    1102:	0306869b          	addiw	a3,a3,48
    1106:	fad408a3          	sb	a3,-79(s0)
    name[2] = '0' + (i % 64);
    110a:	03f7f793          	andi	a5,a5,63
    110e:	9f99                	subw	a5,a5,a4
    1110:	0307879b          	addiw	a5,a5,48
    1114:	faf40923          	sb	a5,-78(s0)
    name[3] = '\0';
    1118:	fa0409a3          	sb	zero,-77(s0)
    if(unlink(name) != 0){
    111c:	fb040513          	addi	a0,s0,-80
    1120:	00004097          	auipc	ra,0x4
    1124:	700080e7          	jalr	1792(ra) # 5820 <unlink>
    1128:	ed21                	bnez	a0,1180 <bigdir+0x148>
  for(i = 0; i < N; i++){
    112a:	2485                	addiw	s1,s1,1
    112c:	fd4491e3          	bne	s1,s4,10ee <bigdir+0xb6>
}
    1130:	60a6                	ld	ra,72(sp)
    1132:	6406                	ld	s0,64(sp)
    1134:	74e2                	ld	s1,56(sp)
    1136:	7942                	ld	s2,48(sp)
    1138:	79a2                	ld	s3,40(sp)
    113a:	7a02                	ld	s4,32(sp)
    113c:	6ae2                	ld	s5,24(sp)
    113e:	6b42                	ld	s6,16(sp)
    1140:	6161                	addi	sp,sp,80
    1142:	8082                	ret
    printf("%s: bigdir create failed\n", s);
    1144:	85ce                	mv	a1,s3
    1146:	00005517          	auipc	a0,0x5
    114a:	2e250513          	addi	a0,a0,738 # 6428 <malloc+0x826>
    114e:	00005097          	auipc	ra,0x5
    1152:	9fc080e7          	jalr	-1540(ra) # 5b4a <printf>
    exit(1);
    1156:	4505                	li	a0,1
    1158:	00004097          	auipc	ra,0x4
    115c:	678080e7          	jalr	1656(ra) # 57d0 <exit>
      printf("%s: bigdir link(bd, %s) failed\n", s, name);
    1160:	fb040613          	addi	a2,s0,-80
    1164:	85ce                	mv	a1,s3
    1166:	00005517          	auipc	a0,0x5
    116a:	2e250513          	addi	a0,a0,738 # 6448 <malloc+0x846>
    116e:	00005097          	auipc	ra,0x5
    1172:	9dc080e7          	jalr	-1572(ra) # 5b4a <printf>
      exit(1);
    1176:	4505                	li	a0,1
    1178:	00004097          	auipc	ra,0x4
    117c:	658080e7          	jalr	1624(ra) # 57d0 <exit>
      printf("%s: bigdir unlink failed", s);
    1180:	85ce                	mv	a1,s3
    1182:	00005517          	auipc	a0,0x5
    1186:	2e650513          	addi	a0,a0,742 # 6468 <malloc+0x866>
    118a:	00005097          	auipc	ra,0x5
    118e:	9c0080e7          	jalr	-1600(ra) # 5b4a <printf>
      exit(1);
    1192:	4505                	li	a0,1
    1194:	00004097          	auipc	ra,0x4
    1198:	63c080e7          	jalr	1596(ra) # 57d0 <exit>

000000000000119c <validatetest>:
{
    119c:	7139                	addi	sp,sp,-64
    119e:	fc06                	sd	ra,56(sp)
    11a0:	f822                	sd	s0,48(sp)
    11a2:	f426                	sd	s1,40(sp)
    11a4:	f04a                	sd	s2,32(sp)
    11a6:	ec4e                	sd	s3,24(sp)
    11a8:	e852                	sd	s4,16(sp)
    11aa:	e456                	sd	s5,8(sp)
    11ac:	e05a                	sd	s6,0(sp)
    11ae:	0080                	addi	s0,sp,64
    11b0:	8b2a                	mv	s6,a0
  for(p = 0; p <= (uint)hi; p += PGSIZE){
    11b2:	4481                	li	s1,0
    if(link("nosuchfile", (char*)p) != -1){
    11b4:	00005997          	auipc	s3,0x5
    11b8:	2d498993          	addi	s3,s3,724 # 6488 <malloc+0x886>
    11bc:	597d                	li	s2,-1
  for(p = 0; p <= (uint)hi; p += PGSIZE){
    11be:	6a85                	lui	s5,0x1
    11c0:	00114a37          	lui	s4,0x114
    if(link("nosuchfile", (char*)p) != -1){
    11c4:	85a6                	mv	a1,s1
    11c6:	854e                	mv	a0,s3
    11c8:	00004097          	auipc	ra,0x4
    11cc:	668080e7          	jalr	1640(ra) # 5830 <link>
    11d0:	01251f63          	bne	a0,s2,11ee <validatetest+0x52>
  for(p = 0; p <= (uint)hi; p += PGSIZE){
    11d4:	94d6                	add	s1,s1,s5
    11d6:	ff4497e3          	bne	s1,s4,11c4 <validatetest+0x28>
}
    11da:	70e2                	ld	ra,56(sp)
    11dc:	7442                	ld	s0,48(sp)
    11de:	74a2                	ld	s1,40(sp)
    11e0:	7902                	ld	s2,32(sp)
    11e2:	69e2                	ld	s3,24(sp)
    11e4:	6a42                	ld	s4,16(sp)
    11e6:	6aa2                	ld	s5,8(sp)
    11e8:	6b02                	ld	s6,0(sp)
    11ea:	6121                	addi	sp,sp,64
    11ec:	8082                	ret
      printf("%s: link should not succeed\n", s);
    11ee:	85da                	mv	a1,s6
    11f0:	00005517          	auipc	a0,0x5
    11f4:	2a850513          	addi	a0,a0,680 # 6498 <malloc+0x896>
    11f8:	00005097          	auipc	ra,0x5
    11fc:	952080e7          	jalr	-1710(ra) # 5b4a <printf>
      exit(1);
    1200:	4505                	li	a0,1
    1202:	00004097          	auipc	ra,0x4
    1206:	5ce080e7          	jalr	1486(ra) # 57d0 <exit>

000000000000120a <pgbug>:
// regression test. mycopyin(), mycopyout(), and mycopyinstr() used to cast
// the virtual page address to uint, which (with certain wild system
// call arguments) resulted in a kernel page faults.
void
pgbug(char *s)
{
    120a:	7179                	addi	sp,sp,-48
    120c:	f406                	sd	ra,40(sp)
    120e:	f022                	sd	s0,32(sp)
    1210:	ec26                	sd	s1,24(sp)
    1212:	1800                	addi	s0,sp,48
  char *argv[1];
  argv[0] = 0;
    1214:	fc043c23          	sd	zero,-40(s0)
  exec((char*)0xeaeb0b5b00002f5e, argv);
    1218:	00007497          	auipc	s1,0x7
    121c:	3384b483          	ld	s1,824(s1) # 8550 <__SDATA_BEGIN__>
    1220:	fd840593          	addi	a1,s0,-40
    1224:	8526                	mv	a0,s1
    1226:	00004097          	auipc	ra,0x4
    122a:	5e2080e7          	jalr	1506(ra) # 5808 <exec>

  pipe((int*)0xeaeb0b5b00002f5e);
    122e:	8526                	mv	a0,s1
    1230:	00004097          	auipc	ra,0x4
    1234:	5b0080e7          	jalr	1456(ra) # 57e0 <pipe>

  exit(0);
    1238:	4501                	li	a0,0
    123a:	00004097          	auipc	ra,0x4
    123e:	596080e7          	jalr	1430(ra) # 57d0 <exit>

0000000000001242 <badarg>:

// regression test. test whether exec() leaks memory if one of the
// arguments is invalid. the test passes if the kernel doesn't panic.
void
badarg(char *s)
{
    1242:	7139                	addi	sp,sp,-64
    1244:	fc06                	sd	ra,56(sp)
    1246:	f822                	sd	s0,48(sp)
    1248:	f426                	sd	s1,40(sp)
    124a:	f04a                	sd	s2,32(sp)
    124c:	ec4e                	sd	s3,24(sp)
    124e:	0080                	addi	s0,sp,64
    1250:	64b1                	lui	s1,0xc
    1252:	35048493          	addi	s1,s1,848 # c350 <buf+0x5d8>
  for(int i = 0; i < 50000; i++){
    char *argv[2];
    argv[0] = (char*)0xffffffff;
    1256:	597d                	li	s2,-1
    1258:	02095913          	srli	s2,s2,0x20
    argv[1] = 0;
    exec("echo", argv);
    125c:	00005997          	auipc	s3,0x5
    1260:	ac498993          	addi	s3,s3,-1340 # 5d20 <malloc+0x11e>
    argv[0] = (char*)0xffffffff;
    1264:	fd243023          	sd	s2,-64(s0)
    argv[1] = 0;
    1268:	fc043423          	sd	zero,-56(s0)
    exec("echo", argv);
    126c:	fc040593          	addi	a1,s0,-64
    1270:	854e                	mv	a0,s3
    1272:	00004097          	auipc	ra,0x4
    1276:	596080e7          	jalr	1430(ra) # 5808 <exec>
  for(int i = 0; i < 50000; i++){
    127a:	34fd                	addiw	s1,s1,-1
    127c:	f4e5                	bnez	s1,1264 <badarg+0x22>
  }
  
  exit(0);
    127e:	4501                	li	a0,0
    1280:	00004097          	auipc	ra,0x4
    1284:	550080e7          	jalr	1360(ra) # 57d0 <exit>

0000000000001288 <mycopyinstr2>:
{
    1288:	7155                	addi	sp,sp,-208
    128a:	e586                	sd	ra,200(sp)
    128c:	e1a2                	sd	s0,192(sp)
    128e:	0980                	addi	s0,sp,208
  for(int i = 0; i < MAXPATH; i++)
    1290:	f6840793          	addi	a5,s0,-152
    1294:	fe840693          	addi	a3,s0,-24
    b[i] = 'x';
    1298:	07800713          	li	a4,120
    129c:	00e78023          	sb	a4,0(a5) # 3000 <exitiputtest+0x28>
  for(int i = 0; i < MAXPATH; i++)
    12a0:	0785                	addi	a5,a5,1
    12a2:	fed79de3          	bne	a5,a3,129c <mycopyinstr2+0x14>
  b[MAXPATH] = '\0';
    12a6:	fe040423          	sb	zero,-24(s0)
  int ret = unlink(b);
    12aa:	f6840513          	addi	a0,s0,-152
    12ae:	00004097          	auipc	ra,0x4
    12b2:	572080e7          	jalr	1394(ra) # 5820 <unlink>
  if(ret != -1){
    12b6:	57fd                	li	a5,-1
    12b8:	0ef51063          	bne	a0,a5,1398 <mycopyinstr2+0x110>
  int fd = open(b, O_CREATE | O_WRONLY);
    12bc:	20100593          	li	a1,513
    12c0:	f6840513          	addi	a0,s0,-152
    12c4:	00004097          	auipc	ra,0x4
    12c8:	54c080e7          	jalr	1356(ra) # 5810 <open>
  if(fd != -1){
    12cc:	57fd                	li	a5,-1
    12ce:	0ef51563          	bne	a0,a5,13b8 <mycopyinstr2+0x130>
  ret = link(b, b);
    12d2:	f6840593          	addi	a1,s0,-152
    12d6:	852e                	mv	a0,a1
    12d8:	00004097          	auipc	ra,0x4
    12dc:	558080e7          	jalr	1368(ra) # 5830 <link>
  if(ret != -1){
    12e0:	57fd                	li	a5,-1
    12e2:	0ef51b63          	bne	a0,a5,13d8 <mycopyinstr2+0x150>
  char *args[] = { "xx", 0 };
    12e6:	00006797          	auipc	a5,0x6
    12ea:	39278793          	addi	a5,a5,914 # 7678 <malloc+0x1a76>
    12ee:	f4f43c23          	sd	a5,-168(s0)
    12f2:	f6043023          	sd	zero,-160(s0)
  ret = exec(b, args);
    12f6:	f5840593          	addi	a1,s0,-168
    12fa:	f6840513          	addi	a0,s0,-152
    12fe:	00004097          	auipc	ra,0x4
    1302:	50a080e7          	jalr	1290(ra) # 5808 <exec>
  if(ret != -1){
    1306:	57fd                	li	a5,-1
    1308:	0ef51963          	bne	a0,a5,13fa <mycopyinstr2+0x172>
  int pid = fork();
    130c:	00004097          	auipc	ra,0x4
    1310:	4bc080e7          	jalr	1212(ra) # 57c8 <fork>
  if(pid < 0){
    1314:	10054363          	bltz	a0,141a <mycopyinstr2+0x192>
  if(pid == 0){
    1318:	12051463          	bnez	a0,1440 <mycopyinstr2+0x1b8>
    131c:	00007797          	auipc	a5,0x7
    1320:	34478793          	addi	a5,a5,836 # 8660 <big.0>
    1324:	00008697          	auipc	a3,0x8
    1328:	33c68693          	addi	a3,a3,828 # 9660 <__global_pointer$+0x910>
      big[i] = 'x';
    132c:	07800713          	li	a4,120
    1330:	00e78023          	sb	a4,0(a5)
    for(int i = 0; i < PGSIZE; i++)
    1334:	0785                	addi	a5,a5,1
    1336:	fed79de3          	bne	a5,a3,1330 <mycopyinstr2+0xa8>
    big[PGSIZE] = '\0';
    133a:	00008797          	auipc	a5,0x8
    133e:	32078323          	sb	zero,806(a5) # 9660 <__global_pointer$+0x910>
    char *args2[] = { big, big, big, 0 };
    1342:	00007797          	auipc	a5,0x7
    1346:	d8678793          	addi	a5,a5,-634 # 80c8 <malloc+0x24c6>
    134a:	6390                	ld	a2,0(a5)
    134c:	6794                	ld	a3,8(a5)
    134e:	6b98                	ld	a4,16(a5)
    1350:	6f9c                	ld	a5,24(a5)
    1352:	f2c43823          	sd	a2,-208(s0)
    1356:	f2d43c23          	sd	a3,-200(s0)
    135a:	f4e43023          	sd	a4,-192(s0)
    135e:	f4f43423          	sd	a5,-184(s0)
    ret = exec("echo", args2);
    1362:	f3040593          	addi	a1,s0,-208
    1366:	00005517          	auipc	a0,0x5
    136a:	9ba50513          	addi	a0,a0,-1606 # 5d20 <malloc+0x11e>
    136e:	00004097          	auipc	ra,0x4
    1372:	49a080e7          	jalr	1178(ra) # 5808 <exec>
    if(ret != -1){
    1376:	57fd                	li	a5,-1
    1378:	0af50e63          	beq	a0,a5,1434 <mycopyinstr2+0x1ac>
      printf("exec(echo, BIG) returned %d, not -1\n", fd);
    137c:	55fd                	li	a1,-1
    137e:	00005517          	auipc	a0,0x5
    1382:	1c250513          	addi	a0,a0,450 # 6540 <malloc+0x93e>
    1386:	00004097          	auipc	ra,0x4
    138a:	7c4080e7          	jalr	1988(ra) # 5b4a <printf>
      exit(1);
    138e:	4505                	li	a0,1
    1390:	00004097          	auipc	ra,0x4
    1394:	440080e7          	jalr	1088(ra) # 57d0 <exit>
    printf("unlink(%s) returned %d, not -1\n", b, ret);
    1398:	862a                	mv	a2,a0
    139a:	f6840593          	addi	a1,s0,-152
    139e:	00005517          	auipc	a0,0x5
    13a2:	11a50513          	addi	a0,a0,282 # 64b8 <malloc+0x8b6>
    13a6:	00004097          	auipc	ra,0x4
    13aa:	7a4080e7          	jalr	1956(ra) # 5b4a <printf>
    exit(1);
    13ae:	4505                	li	a0,1
    13b0:	00004097          	auipc	ra,0x4
    13b4:	420080e7          	jalr	1056(ra) # 57d0 <exit>
    printf("open(%s) returned %d, not -1\n", b, fd);
    13b8:	862a                	mv	a2,a0
    13ba:	f6840593          	addi	a1,s0,-152
    13be:	00005517          	auipc	a0,0x5
    13c2:	11a50513          	addi	a0,a0,282 # 64d8 <malloc+0x8d6>
    13c6:	00004097          	auipc	ra,0x4
    13ca:	784080e7          	jalr	1924(ra) # 5b4a <printf>
    exit(1);
    13ce:	4505                	li	a0,1
    13d0:	00004097          	auipc	ra,0x4
    13d4:	400080e7          	jalr	1024(ra) # 57d0 <exit>
    printf("link(%s, %s) returned %d, not -1\n", b, b, ret);
    13d8:	86aa                	mv	a3,a0
    13da:	f6840613          	addi	a2,s0,-152
    13de:	85b2                	mv	a1,a2
    13e0:	00005517          	auipc	a0,0x5
    13e4:	11850513          	addi	a0,a0,280 # 64f8 <malloc+0x8f6>
    13e8:	00004097          	auipc	ra,0x4
    13ec:	762080e7          	jalr	1890(ra) # 5b4a <printf>
    exit(1);
    13f0:	4505                	li	a0,1
    13f2:	00004097          	auipc	ra,0x4
    13f6:	3de080e7          	jalr	990(ra) # 57d0 <exit>
    printf("exec(%s) returned %d, not -1\n", b, fd);
    13fa:	567d                	li	a2,-1
    13fc:	f6840593          	addi	a1,s0,-152
    1400:	00005517          	auipc	a0,0x5
    1404:	12050513          	addi	a0,a0,288 # 6520 <malloc+0x91e>
    1408:	00004097          	auipc	ra,0x4
    140c:	742080e7          	jalr	1858(ra) # 5b4a <printf>
    exit(1);
    1410:	4505                	li	a0,1
    1412:	00004097          	auipc	ra,0x4
    1416:	3be080e7          	jalr	958(ra) # 57d0 <exit>
    printf("fork failed\n");
    141a:	00005517          	auipc	a0,0x5
    141e:	58650513          	addi	a0,a0,1414 # 69a0 <malloc+0xd9e>
    1422:	00004097          	auipc	ra,0x4
    1426:	728080e7          	jalr	1832(ra) # 5b4a <printf>
    exit(1);
    142a:	4505                	li	a0,1
    142c:	00004097          	auipc	ra,0x4
    1430:	3a4080e7          	jalr	932(ra) # 57d0 <exit>
    exit(747); // OK
    1434:	2eb00513          	li	a0,747
    1438:	00004097          	auipc	ra,0x4
    143c:	398080e7          	jalr	920(ra) # 57d0 <exit>
  int st = 0;
    1440:	f4042a23          	sw	zero,-172(s0)
  wait(&st);
    1444:	f5440513          	addi	a0,s0,-172
    1448:	00004097          	auipc	ra,0x4
    144c:	390080e7          	jalr	912(ra) # 57d8 <wait>
  if(st != 747){
    1450:	f5442703          	lw	a4,-172(s0)
    1454:	2eb00793          	li	a5,747
    1458:	00f71663          	bne	a4,a5,1464 <mycopyinstr2+0x1dc>
}
    145c:	60ae                	ld	ra,200(sp)
    145e:	640e                	ld	s0,192(sp)
    1460:	6169                	addi	sp,sp,208
    1462:	8082                	ret
    printf("exec(echo, BIG) succeeded, should have failed\n");
    1464:	00005517          	auipc	a0,0x5
    1468:	10450513          	addi	a0,a0,260 # 6568 <malloc+0x966>
    146c:	00004097          	auipc	ra,0x4
    1470:	6de080e7          	jalr	1758(ra) # 5b4a <printf>
    exit(1);
    1474:	4505                	li	a0,1
    1476:	00004097          	auipc	ra,0x4
    147a:	35a080e7          	jalr	858(ra) # 57d0 <exit>

000000000000147e <truncate3>:
{
    147e:	7159                	addi	sp,sp,-112
    1480:	f486                	sd	ra,104(sp)
    1482:	f0a2                	sd	s0,96(sp)
    1484:	eca6                	sd	s1,88(sp)
    1486:	e8ca                	sd	s2,80(sp)
    1488:	e4ce                	sd	s3,72(sp)
    148a:	e0d2                	sd	s4,64(sp)
    148c:	fc56                	sd	s5,56(sp)
    148e:	1880                	addi	s0,sp,112
    1490:	892a                	mv	s2,a0
  close(open("truncfile", O_CREATE|O_TRUNC|O_WRONLY));
    1492:	60100593          	li	a1,1537
    1496:	00005517          	auipc	a0,0x5
    149a:	8e250513          	addi	a0,a0,-1822 # 5d78 <malloc+0x176>
    149e:	00004097          	auipc	ra,0x4
    14a2:	372080e7          	jalr	882(ra) # 5810 <open>
    14a6:	00004097          	auipc	ra,0x4
    14aa:	352080e7          	jalr	850(ra) # 57f8 <close>
  pid = fork();
    14ae:	00004097          	auipc	ra,0x4
    14b2:	31a080e7          	jalr	794(ra) # 57c8 <fork>
  if(pid < 0){
    14b6:	08054063          	bltz	a0,1536 <truncate3+0xb8>
  if(pid == 0){
    14ba:	e969                	bnez	a0,158c <truncate3+0x10e>
    14bc:	06400993          	li	s3,100
      int fd = open("truncfile", O_WRONLY);
    14c0:	00005a17          	auipc	s4,0x5
    14c4:	8b8a0a13          	addi	s4,s4,-1864 # 5d78 <malloc+0x176>
      int n = write(fd, "1234567890", 10);
    14c8:	00005a97          	auipc	s5,0x5
    14cc:	100a8a93          	addi	s5,s5,256 # 65c8 <malloc+0x9c6>
      int fd = open("truncfile", O_WRONLY);
    14d0:	4585                	li	a1,1
    14d2:	8552                	mv	a0,s4
    14d4:	00004097          	auipc	ra,0x4
    14d8:	33c080e7          	jalr	828(ra) # 5810 <open>
    14dc:	84aa                	mv	s1,a0
      if(fd < 0){
    14de:	06054a63          	bltz	a0,1552 <truncate3+0xd4>
      int n = write(fd, "1234567890", 10);
    14e2:	4629                	li	a2,10
    14e4:	85d6                	mv	a1,s5
    14e6:	00004097          	auipc	ra,0x4
    14ea:	30a080e7          	jalr	778(ra) # 57f0 <write>
      if(n != 10){
    14ee:	47a9                	li	a5,10
    14f0:	06f51f63          	bne	a0,a5,156e <truncate3+0xf0>
      close(fd);
    14f4:	8526                	mv	a0,s1
    14f6:	00004097          	auipc	ra,0x4
    14fa:	302080e7          	jalr	770(ra) # 57f8 <close>
      fd = open("truncfile", O_RDONLY);
    14fe:	4581                	li	a1,0
    1500:	8552                	mv	a0,s4
    1502:	00004097          	auipc	ra,0x4
    1506:	30e080e7          	jalr	782(ra) # 5810 <open>
    150a:	84aa                	mv	s1,a0
      read(fd, buf, sizeof(buf));
    150c:	02000613          	li	a2,32
    1510:	f9840593          	addi	a1,s0,-104
    1514:	00004097          	auipc	ra,0x4
    1518:	2d4080e7          	jalr	724(ra) # 57e8 <read>
      close(fd);
    151c:	8526                	mv	a0,s1
    151e:	00004097          	auipc	ra,0x4
    1522:	2da080e7          	jalr	730(ra) # 57f8 <close>
    for(int i = 0; i < 100; i++){
    1526:	39fd                	addiw	s3,s3,-1
    1528:	fa0994e3          	bnez	s3,14d0 <truncate3+0x52>
    exit(0);
    152c:	4501                	li	a0,0
    152e:	00004097          	auipc	ra,0x4
    1532:	2a2080e7          	jalr	674(ra) # 57d0 <exit>
    printf("%s: fork failed\n", s);
    1536:	85ca                	mv	a1,s2
    1538:	00005517          	auipc	a0,0x5
    153c:	06050513          	addi	a0,a0,96 # 6598 <malloc+0x996>
    1540:	00004097          	auipc	ra,0x4
    1544:	60a080e7          	jalr	1546(ra) # 5b4a <printf>
    exit(1);
    1548:	4505                	li	a0,1
    154a:	00004097          	auipc	ra,0x4
    154e:	286080e7          	jalr	646(ra) # 57d0 <exit>
        printf("%s: open failed\n", s);
    1552:	85ca                	mv	a1,s2
    1554:	00005517          	auipc	a0,0x5
    1558:	05c50513          	addi	a0,a0,92 # 65b0 <malloc+0x9ae>
    155c:	00004097          	auipc	ra,0x4
    1560:	5ee080e7          	jalr	1518(ra) # 5b4a <printf>
        exit(1);
    1564:	4505                	li	a0,1
    1566:	00004097          	auipc	ra,0x4
    156a:	26a080e7          	jalr	618(ra) # 57d0 <exit>
        printf("%s: write got %d, expected 10\n", s, n);
    156e:	862a                	mv	a2,a0
    1570:	85ca                	mv	a1,s2
    1572:	00005517          	auipc	a0,0x5
    1576:	06650513          	addi	a0,a0,102 # 65d8 <malloc+0x9d6>
    157a:	00004097          	auipc	ra,0x4
    157e:	5d0080e7          	jalr	1488(ra) # 5b4a <printf>
        exit(1);
    1582:	4505                	li	a0,1
    1584:	00004097          	auipc	ra,0x4
    1588:	24c080e7          	jalr	588(ra) # 57d0 <exit>
    158c:	09600993          	li	s3,150
    int fd = open("truncfile", O_CREATE|O_WRONLY|O_TRUNC);
    1590:	00004a17          	auipc	s4,0x4
    1594:	7e8a0a13          	addi	s4,s4,2024 # 5d78 <malloc+0x176>
    int n = write(fd, "xxx", 3);
    1598:	00005a97          	auipc	s5,0x5
    159c:	060a8a93          	addi	s5,s5,96 # 65f8 <malloc+0x9f6>
    int fd = open("truncfile", O_CREATE|O_WRONLY|O_TRUNC);
    15a0:	60100593          	li	a1,1537
    15a4:	8552                	mv	a0,s4
    15a6:	00004097          	auipc	ra,0x4
    15aa:	26a080e7          	jalr	618(ra) # 5810 <open>
    15ae:	84aa                	mv	s1,a0
    if(fd < 0){
    15b0:	04054763          	bltz	a0,15fe <truncate3+0x180>
    int n = write(fd, "xxx", 3);
    15b4:	460d                	li	a2,3
    15b6:	85d6                	mv	a1,s5
    15b8:	00004097          	auipc	ra,0x4
    15bc:	238080e7          	jalr	568(ra) # 57f0 <write>
    if(n != 3){
    15c0:	478d                	li	a5,3
    15c2:	04f51c63          	bne	a0,a5,161a <truncate3+0x19c>
    close(fd);
    15c6:	8526                	mv	a0,s1
    15c8:	00004097          	auipc	ra,0x4
    15cc:	230080e7          	jalr	560(ra) # 57f8 <close>
  for(int i = 0; i < 150; i++){
    15d0:	39fd                	addiw	s3,s3,-1
    15d2:	fc0997e3          	bnez	s3,15a0 <truncate3+0x122>
  wait(&xstatus);
    15d6:	fbc40513          	addi	a0,s0,-68
    15da:	00004097          	auipc	ra,0x4
    15de:	1fe080e7          	jalr	510(ra) # 57d8 <wait>
  unlink("truncfile");
    15e2:	00004517          	auipc	a0,0x4
    15e6:	79650513          	addi	a0,a0,1942 # 5d78 <malloc+0x176>
    15ea:	00004097          	auipc	ra,0x4
    15ee:	236080e7          	jalr	566(ra) # 5820 <unlink>
  exit(xstatus);
    15f2:	fbc42503          	lw	a0,-68(s0)
    15f6:	00004097          	auipc	ra,0x4
    15fa:	1da080e7          	jalr	474(ra) # 57d0 <exit>
      printf("%s: open failed\n", s);
    15fe:	85ca                	mv	a1,s2
    1600:	00005517          	auipc	a0,0x5
    1604:	fb050513          	addi	a0,a0,-80 # 65b0 <malloc+0x9ae>
    1608:	00004097          	auipc	ra,0x4
    160c:	542080e7          	jalr	1346(ra) # 5b4a <printf>
      exit(1);
    1610:	4505                	li	a0,1
    1612:	00004097          	auipc	ra,0x4
    1616:	1be080e7          	jalr	446(ra) # 57d0 <exit>
      printf("%s: write got %d, expected 3\n", s, n);
    161a:	862a                	mv	a2,a0
    161c:	85ca                	mv	a1,s2
    161e:	00005517          	auipc	a0,0x5
    1622:	fe250513          	addi	a0,a0,-30 # 6600 <malloc+0x9fe>
    1626:	00004097          	auipc	ra,0x4
    162a:	524080e7          	jalr	1316(ra) # 5b4a <printf>
      exit(1);
    162e:	4505                	li	a0,1
    1630:	00004097          	auipc	ra,0x4
    1634:	1a0080e7          	jalr	416(ra) # 57d0 <exit>

0000000000001638 <exectest>:
{
    1638:	715d                	addi	sp,sp,-80
    163a:	e486                	sd	ra,72(sp)
    163c:	e0a2                	sd	s0,64(sp)
    163e:	fc26                	sd	s1,56(sp)
    1640:	f84a                	sd	s2,48(sp)
    1642:	0880                	addi	s0,sp,80
    1644:	892a                	mv	s2,a0
  char *echoargv[] = { "echo", "OK", 0 };
    1646:	00004797          	auipc	a5,0x4
    164a:	6da78793          	addi	a5,a5,1754 # 5d20 <malloc+0x11e>
    164e:	fcf43023          	sd	a5,-64(s0)
    1652:	00005797          	auipc	a5,0x5
    1656:	fce78793          	addi	a5,a5,-50 # 6620 <malloc+0xa1e>
    165a:	fcf43423          	sd	a5,-56(s0)
    165e:	fc043823          	sd	zero,-48(s0)
  unlink("echo-ok");
    1662:	00005517          	auipc	a0,0x5
    1666:	fc650513          	addi	a0,a0,-58 # 6628 <malloc+0xa26>
    166a:	00004097          	auipc	ra,0x4
    166e:	1b6080e7          	jalr	438(ra) # 5820 <unlink>
  pid = fork();
    1672:	00004097          	auipc	ra,0x4
    1676:	156080e7          	jalr	342(ra) # 57c8 <fork>
  if(pid < 0) {
    167a:	04054663          	bltz	a0,16c6 <exectest+0x8e>
    167e:	84aa                	mv	s1,a0
  if(pid == 0) {
    1680:	e959                	bnez	a0,1716 <exectest+0xde>
    close(1);
    1682:	4505                	li	a0,1
    1684:	00004097          	auipc	ra,0x4
    1688:	174080e7          	jalr	372(ra) # 57f8 <close>
    fd = open("echo-ok", O_CREATE|O_WRONLY);
    168c:	20100593          	li	a1,513
    1690:	00005517          	auipc	a0,0x5
    1694:	f9850513          	addi	a0,a0,-104 # 6628 <malloc+0xa26>
    1698:	00004097          	auipc	ra,0x4
    169c:	178080e7          	jalr	376(ra) # 5810 <open>
    if(fd < 0) {
    16a0:	04054163          	bltz	a0,16e2 <exectest+0xaa>
    if(fd != 1) {
    16a4:	4785                	li	a5,1
    16a6:	04f50c63          	beq	a0,a5,16fe <exectest+0xc6>
      printf("%s: wrong fd\n", s);
    16aa:	85ca                	mv	a1,s2
    16ac:	00005517          	auipc	a0,0x5
    16b0:	f9c50513          	addi	a0,a0,-100 # 6648 <malloc+0xa46>
    16b4:	00004097          	auipc	ra,0x4
    16b8:	496080e7          	jalr	1174(ra) # 5b4a <printf>
      exit(1);
    16bc:	4505                	li	a0,1
    16be:	00004097          	auipc	ra,0x4
    16c2:	112080e7          	jalr	274(ra) # 57d0 <exit>
     printf("%s: fork failed\n", s);
    16c6:	85ca                	mv	a1,s2
    16c8:	00005517          	auipc	a0,0x5
    16cc:	ed050513          	addi	a0,a0,-304 # 6598 <malloc+0x996>
    16d0:	00004097          	auipc	ra,0x4
    16d4:	47a080e7          	jalr	1146(ra) # 5b4a <printf>
     exit(1);
    16d8:	4505                	li	a0,1
    16da:	00004097          	auipc	ra,0x4
    16de:	0f6080e7          	jalr	246(ra) # 57d0 <exit>
      printf("%s: create failed\n", s);
    16e2:	85ca                	mv	a1,s2
    16e4:	00005517          	auipc	a0,0x5
    16e8:	f4c50513          	addi	a0,a0,-180 # 6630 <malloc+0xa2e>
    16ec:	00004097          	auipc	ra,0x4
    16f0:	45e080e7          	jalr	1118(ra) # 5b4a <printf>
      exit(1);
    16f4:	4505                	li	a0,1
    16f6:	00004097          	auipc	ra,0x4
    16fa:	0da080e7          	jalr	218(ra) # 57d0 <exit>
    if(exec("echo", echoargv) < 0){
    16fe:	fc040593          	addi	a1,s0,-64
    1702:	00004517          	auipc	a0,0x4
    1706:	61e50513          	addi	a0,a0,1566 # 5d20 <malloc+0x11e>
    170a:	00004097          	auipc	ra,0x4
    170e:	0fe080e7          	jalr	254(ra) # 5808 <exec>
    1712:	02054163          	bltz	a0,1734 <exectest+0xfc>
  if (wait(&xstatus) != pid) {
    1716:	fdc40513          	addi	a0,s0,-36
    171a:	00004097          	auipc	ra,0x4
    171e:	0be080e7          	jalr	190(ra) # 57d8 <wait>
    1722:	02951763          	bne	a0,s1,1750 <exectest+0x118>
  if(xstatus != 0)
    1726:	fdc42503          	lw	a0,-36(s0)
    172a:	cd0d                	beqz	a0,1764 <exectest+0x12c>
    exit(xstatus);
    172c:	00004097          	auipc	ra,0x4
    1730:	0a4080e7          	jalr	164(ra) # 57d0 <exit>
      printf("%s: exec echo failed\n", s);
    1734:	85ca                	mv	a1,s2
    1736:	00005517          	auipc	a0,0x5
    173a:	f2250513          	addi	a0,a0,-222 # 6658 <malloc+0xa56>
    173e:	00004097          	auipc	ra,0x4
    1742:	40c080e7          	jalr	1036(ra) # 5b4a <printf>
      exit(1);
    1746:	4505                	li	a0,1
    1748:	00004097          	auipc	ra,0x4
    174c:	088080e7          	jalr	136(ra) # 57d0 <exit>
    printf("%s: wait failed!\n", s);
    1750:	85ca                	mv	a1,s2
    1752:	00005517          	auipc	a0,0x5
    1756:	f1e50513          	addi	a0,a0,-226 # 6670 <malloc+0xa6e>
    175a:	00004097          	auipc	ra,0x4
    175e:	3f0080e7          	jalr	1008(ra) # 5b4a <printf>
    1762:	b7d1                	j	1726 <exectest+0xee>
  fd = open("echo-ok", O_RDONLY);
    1764:	4581                	li	a1,0
    1766:	00005517          	auipc	a0,0x5
    176a:	ec250513          	addi	a0,a0,-318 # 6628 <malloc+0xa26>
    176e:	00004097          	auipc	ra,0x4
    1772:	0a2080e7          	jalr	162(ra) # 5810 <open>
  if(fd < 0) {
    1776:	02054a63          	bltz	a0,17aa <exectest+0x172>
  if (read(fd, buf, 2) != 2) {
    177a:	4609                	li	a2,2
    177c:	fb840593          	addi	a1,s0,-72
    1780:	00004097          	auipc	ra,0x4
    1784:	068080e7          	jalr	104(ra) # 57e8 <read>
    1788:	4789                	li	a5,2
    178a:	02f50e63          	beq	a0,a5,17c6 <exectest+0x18e>
    printf("%s: read failed\n", s);
    178e:	85ca                	mv	a1,s2
    1790:	00005517          	auipc	a0,0x5
    1794:	95050513          	addi	a0,a0,-1712 # 60e0 <malloc+0x4de>
    1798:	00004097          	auipc	ra,0x4
    179c:	3b2080e7          	jalr	946(ra) # 5b4a <printf>
    exit(1);
    17a0:	4505                	li	a0,1
    17a2:	00004097          	auipc	ra,0x4
    17a6:	02e080e7          	jalr	46(ra) # 57d0 <exit>
    printf("%s: open failed\n", s);
    17aa:	85ca                	mv	a1,s2
    17ac:	00005517          	auipc	a0,0x5
    17b0:	e0450513          	addi	a0,a0,-508 # 65b0 <malloc+0x9ae>
    17b4:	00004097          	auipc	ra,0x4
    17b8:	396080e7          	jalr	918(ra) # 5b4a <printf>
    exit(1);
    17bc:	4505                	li	a0,1
    17be:	00004097          	auipc	ra,0x4
    17c2:	012080e7          	jalr	18(ra) # 57d0 <exit>
  unlink("echo-ok");
    17c6:	00005517          	auipc	a0,0x5
    17ca:	e6250513          	addi	a0,a0,-414 # 6628 <malloc+0xa26>
    17ce:	00004097          	auipc	ra,0x4
    17d2:	052080e7          	jalr	82(ra) # 5820 <unlink>
  if(buf[0] == 'O' && buf[1] == 'K')
    17d6:	fb844703          	lbu	a4,-72(s0)
    17da:	04f00793          	li	a5,79
    17de:	00f71863          	bne	a4,a5,17ee <exectest+0x1b6>
    17e2:	fb944703          	lbu	a4,-71(s0)
    17e6:	04b00793          	li	a5,75
    17ea:	02f70063          	beq	a4,a5,180a <exectest+0x1d2>
    printf("%s: wrong output\n", s);
    17ee:	85ca                	mv	a1,s2
    17f0:	00005517          	auipc	a0,0x5
    17f4:	e9850513          	addi	a0,a0,-360 # 6688 <malloc+0xa86>
    17f8:	00004097          	auipc	ra,0x4
    17fc:	352080e7          	jalr	850(ra) # 5b4a <printf>
    exit(1);
    1800:	4505                	li	a0,1
    1802:	00004097          	auipc	ra,0x4
    1806:	fce080e7          	jalr	-50(ra) # 57d0 <exit>
    exit(0);
    180a:	4501                	li	a0,0
    180c:	00004097          	auipc	ra,0x4
    1810:	fc4080e7          	jalr	-60(ra) # 57d0 <exit>

0000000000001814 <pipe1>:
{
    1814:	711d                	addi	sp,sp,-96
    1816:	ec86                	sd	ra,88(sp)
    1818:	e8a2                	sd	s0,80(sp)
    181a:	e4a6                	sd	s1,72(sp)
    181c:	e0ca                	sd	s2,64(sp)
    181e:	fc4e                	sd	s3,56(sp)
    1820:	f852                	sd	s4,48(sp)
    1822:	f456                	sd	s5,40(sp)
    1824:	f05a                	sd	s6,32(sp)
    1826:	ec5e                	sd	s7,24(sp)
    1828:	1080                	addi	s0,sp,96
    182a:	892a                	mv	s2,a0
  if(pipe(fds) != 0){
    182c:	fa840513          	addi	a0,s0,-88
    1830:	00004097          	auipc	ra,0x4
    1834:	fb0080e7          	jalr	-80(ra) # 57e0 <pipe>
    1838:	e93d                	bnez	a0,18ae <pipe1+0x9a>
    183a:	84aa                	mv	s1,a0
  pid = fork();
    183c:	00004097          	auipc	ra,0x4
    1840:	f8c080e7          	jalr	-116(ra) # 57c8 <fork>
    1844:	8a2a                	mv	s4,a0
  if(pid == 0){
    1846:	c151                	beqz	a0,18ca <pipe1+0xb6>
  } else if(pid > 0){
    1848:	16a05d63          	blez	a0,19c2 <pipe1+0x1ae>
    close(fds[1]);
    184c:	fac42503          	lw	a0,-84(s0)
    1850:	00004097          	auipc	ra,0x4
    1854:	fa8080e7          	jalr	-88(ra) # 57f8 <close>
    total = 0;
    1858:	8a26                	mv	s4,s1
    cc = 1;
    185a:	4985                	li	s3,1
    while((n = read(fds[0], buf, cc)) > 0){
    185c:	0000aa97          	auipc	s5,0xa
    1860:	51ca8a93          	addi	s5,s5,1308 # bd78 <buf>
      if(cc > sizeof(buf))
    1864:	6b0d                	lui	s6,0x3
    while((n = read(fds[0], buf, cc)) > 0){
    1866:	864e                	mv	a2,s3
    1868:	85d6                	mv	a1,s5
    186a:	fa842503          	lw	a0,-88(s0)
    186e:	00004097          	auipc	ra,0x4
    1872:	f7a080e7          	jalr	-134(ra) # 57e8 <read>
    1876:	10a05163          	blez	a0,1978 <pipe1+0x164>
      for(i = 0; i < n; i++){
    187a:	0000a717          	auipc	a4,0xa
    187e:	4fe70713          	addi	a4,a4,1278 # bd78 <buf>
    1882:	00a4863b          	addw	a2,s1,a0
        if((buf[i] & 0xff) != (seq++ & 0xff)){
    1886:	00074683          	lbu	a3,0(a4)
    188a:	0ff4f793          	zext.b	a5,s1
    188e:	2485                	addiw	s1,s1,1
    1890:	0cf69063          	bne	a3,a5,1950 <pipe1+0x13c>
      for(i = 0; i < n; i++){
    1894:	0705                	addi	a4,a4,1
    1896:	fec498e3          	bne	s1,a2,1886 <pipe1+0x72>
      total += n;
    189a:	00aa0a3b          	addw	s4,s4,a0
      cc = cc * 2;
    189e:	0019979b          	slliw	a5,s3,0x1
    18a2:	0007899b          	sext.w	s3,a5
      if(cc > sizeof(buf))
    18a6:	fd3b70e3          	bgeu	s6,s3,1866 <pipe1+0x52>
        cc = sizeof(buf);
    18aa:	89da                	mv	s3,s6
    18ac:	bf6d                	j	1866 <pipe1+0x52>
    printf("%s: pipe() failed\n", s);
    18ae:	85ca                	mv	a1,s2
    18b0:	00005517          	auipc	a0,0x5
    18b4:	df050513          	addi	a0,a0,-528 # 66a0 <malloc+0xa9e>
    18b8:	00004097          	auipc	ra,0x4
    18bc:	292080e7          	jalr	658(ra) # 5b4a <printf>
    exit(1);
    18c0:	4505                	li	a0,1
    18c2:	00004097          	auipc	ra,0x4
    18c6:	f0e080e7          	jalr	-242(ra) # 57d0 <exit>
    close(fds[0]);
    18ca:	fa842503          	lw	a0,-88(s0)
    18ce:	00004097          	auipc	ra,0x4
    18d2:	f2a080e7          	jalr	-214(ra) # 57f8 <close>
    for(n = 0; n < N; n++){
    18d6:	0000ab17          	auipc	s6,0xa
    18da:	4a2b0b13          	addi	s6,s6,1186 # bd78 <buf>
    18de:	416004bb          	negw	s1,s6
    18e2:	0ff4f493          	zext.b	s1,s1
    18e6:	409b0993          	addi	s3,s6,1033
      if(write(fds[1], buf, SZ) != SZ){
    18ea:	8bda                	mv	s7,s6
    for(n = 0; n < N; n++){
    18ec:	6a85                	lui	s5,0x1
    18ee:	42da8a93          	addi	s5,s5,1069 # 142d <mycopyinstr2+0x1a5>
{
    18f2:	87da                	mv	a5,s6
        buf[i] = seq++;
    18f4:	0097873b          	addw	a4,a5,s1
    18f8:	00e78023          	sb	a4,0(a5)
      for(i = 0; i < SZ; i++)
    18fc:	0785                	addi	a5,a5,1
    18fe:	fef99be3          	bne	s3,a5,18f4 <pipe1+0xe0>
        buf[i] = seq++;
    1902:	409a0a1b          	addiw	s4,s4,1033
      if(write(fds[1], buf, SZ) != SZ){
    1906:	40900613          	li	a2,1033
    190a:	85de                	mv	a1,s7
    190c:	fac42503          	lw	a0,-84(s0)
    1910:	00004097          	auipc	ra,0x4
    1914:	ee0080e7          	jalr	-288(ra) # 57f0 <write>
    1918:	40900793          	li	a5,1033
    191c:	00f51c63          	bne	a0,a5,1934 <pipe1+0x120>
    for(n = 0; n < N; n++){
    1920:	24a5                	addiw	s1,s1,9
    1922:	0ff4f493          	zext.b	s1,s1
    1926:	fd5a16e3          	bne	s4,s5,18f2 <pipe1+0xde>
    exit(0);
    192a:	4501                	li	a0,0
    192c:	00004097          	auipc	ra,0x4
    1930:	ea4080e7          	jalr	-348(ra) # 57d0 <exit>
        printf("%s: pipe1 oops 1\n", s);
    1934:	85ca                	mv	a1,s2
    1936:	00005517          	auipc	a0,0x5
    193a:	d8250513          	addi	a0,a0,-638 # 66b8 <malloc+0xab6>
    193e:	00004097          	auipc	ra,0x4
    1942:	20c080e7          	jalr	524(ra) # 5b4a <printf>
        exit(1);
    1946:	4505                	li	a0,1
    1948:	00004097          	auipc	ra,0x4
    194c:	e88080e7          	jalr	-376(ra) # 57d0 <exit>
          printf("%s: pipe1 oops 2\n", s);
    1950:	85ca                	mv	a1,s2
    1952:	00005517          	auipc	a0,0x5
    1956:	d7e50513          	addi	a0,a0,-642 # 66d0 <malloc+0xace>
    195a:	00004097          	auipc	ra,0x4
    195e:	1f0080e7          	jalr	496(ra) # 5b4a <printf>
}
    1962:	60e6                	ld	ra,88(sp)
    1964:	6446                	ld	s0,80(sp)
    1966:	64a6                	ld	s1,72(sp)
    1968:	6906                	ld	s2,64(sp)
    196a:	79e2                	ld	s3,56(sp)
    196c:	7a42                	ld	s4,48(sp)
    196e:	7aa2                	ld	s5,40(sp)
    1970:	7b02                	ld	s6,32(sp)
    1972:	6be2                	ld	s7,24(sp)
    1974:	6125                	addi	sp,sp,96
    1976:	8082                	ret
    if(total != N * SZ){
    1978:	6785                	lui	a5,0x1
    197a:	42d78793          	addi	a5,a5,1069 # 142d <mycopyinstr2+0x1a5>
    197e:	02fa0063          	beq	s4,a5,199e <pipe1+0x18a>
      printf("%s: pipe1 oops 3 total %d\n", total);
    1982:	85d2                	mv	a1,s4
    1984:	00005517          	auipc	a0,0x5
    1988:	d6450513          	addi	a0,a0,-668 # 66e8 <malloc+0xae6>
    198c:	00004097          	auipc	ra,0x4
    1990:	1be080e7          	jalr	446(ra) # 5b4a <printf>
      exit(1);
    1994:	4505                	li	a0,1
    1996:	00004097          	auipc	ra,0x4
    199a:	e3a080e7          	jalr	-454(ra) # 57d0 <exit>
    close(fds[0]);
    199e:	fa842503          	lw	a0,-88(s0)
    19a2:	00004097          	auipc	ra,0x4
    19a6:	e56080e7          	jalr	-426(ra) # 57f8 <close>
    wait(&xstatus);
    19aa:	fa440513          	addi	a0,s0,-92
    19ae:	00004097          	auipc	ra,0x4
    19b2:	e2a080e7          	jalr	-470(ra) # 57d8 <wait>
    exit(xstatus);
    19b6:	fa442503          	lw	a0,-92(s0)
    19ba:	00004097          	auipc	ra,0x4
    19be:	e16080e7          	jalr	-490(ra) # 57d0 <exit>
    printf("%s: fork() failed\n", s);
    19c2:	85ca                	mv	a1,s2
    19c4:	00005517          	auipc	a0,0x5
    19c8:	d4450513          	addi	a0,a0,-700 # 6708 <malloc+0xb06>
    19cc:	00004097          	auipc	ra,0x4
    19d0:	17e080e7          	jalr	382(ra) # 5b4a <printf>
    exit(1);
    19d4:	4505                	li	a0,1
    19d6:	00004097          	auipc	ra,0x4
    19da:	dfa080e7          	jalr	-518(ra) # 57d0 <exit>

00000000000019de <exitwait>:
{
    19de:	7139                	addi	sp,sp,-64
    19e0:	fc06                	sd	ra,56(sp)
    19e2:	f822                	sd	s0,48(sp)
    19e4:	f426                	sd	s1,40(sp)
    19e6:	f04a                	sd	s2,32(sp)
    19e8:	ec4e                	sd	s3,24(sp)
    19ea:	e852                	sd	s4,16(sp)
    19ec:	0080                	addi	s0,sp,64
    19ee:	8a2a                	mv	s4,a0
  for(i = 0; i < 100; i++){
    19f0:	4901                	li	s2,0
    19f2:	06400993          	li	s3,100
    pid = fork();
    19f6:	00004097          	auipc	ra,0x4
    19fa:	dd2080e7          	jalr	-558(ra) # 57c8 <fork>
    19fe:	84aa                	mv	s1,a0
    if(pid < 0){
    1a00:	02054a63          	bltz	a0,1a34 <exitwait+0x56>
    if(pid){
    1a04:	c151                	beqz	a0,1a88 <exitwait+0xaa>
      if(wait(&xstate) != pid){
    1a06:	fcc40513          	addi	a0,s0,-52
    1a0a:	00004097          	auipc	ra,0x4
    1a0e:	dce080e7          	jalr	-562(ra) # 57d8 <wait>
    1a12:	02951f63          	bne	a0,s1,1a50 <exitwait+0x72>
      if(i != xstate) {
    1a16:	fcc42783          	lw	a5,-52(s0)
    1a1a:	05279963          	bne	a5,s2,1a6c <exitwait+0x8e>
  for(i = 0; i < 100; i++){
    1a1e:	2905                	addiw	s2,s2,1
    1a20:	fd391be3          	bne	s2,s3,19f6 <exitwait+0x18>
}
    1a24:	70e2                	ld	ra,56(sp)
    1a26:	7442                	ld	s0,48(sp)
    1a28:	74a2                	ld	s1,40(sp)
    1a2a:	7902                	ld	s2,32(sp)
    1a2c:	69e2                	ld	s3,24(sp)
    1a2e:	6a42                	ld	s4,16(sp)
    1a30:	6121                	addi	sp,sp,64
    1a32:	8082                	ret
      printf("%s: fork failed\n", s);
    1a34:	85d2                	mv	a1,s4
    1a36:	00005517          	auipc	a0,0x5
    1a3a:	b6250513          	addi	a0,a0,-1182 # 6598 <malloc+0x996>
    1a3e:	00004097          	auipc	ra,0x4
    1a42:	10c080e7          	jalr	268(ra) # 5b4a <printf>
      exit(1);
    1a46:	4505                	li	a0,1
    1a48:	00004097          	auipc	ra,0x4
    1a4c:	d88080e7          	jalr	-632(ra) # 57d0 <exit>
        printf("%s: wait wrong pid\n", s);
    1a50:	85d2                	mv	a1,s4
    1a52:	00005517          	auipc	a0,0x5
    1a56:	cce50513          	addi	a0,a0,-818 # 6720 <malloc+0xb1e>
    1a5a:	00004097          	auipc	ra,0x4
    1a5e:	0f0080e7          	jalr	240(ra) # 5b4a <printf>
        exit(1);
    1a62:	4505                	li	a0,1
    1a64:	00004097          	auipc	ra,0x4
    1a68:	d6c080e7          	jalr	-660(ra) # 57d0 <exit>
        printf("%s: wait wrong exit status\n", s);
    1a6c:	85d2                	mv	a1,s4
    1a6e:	00005517          	auipc	a0,0x5
    1a72:	cca50513          	addi	a0,a0,-822 # 6738 <malloc+0xb36>
    1a76:	00004097          	auipc	ra,0x4
    1a7a:	0d4080e7          	jalr	212(ra) # 5b4a <printf>
        exit(1);
    1a7e:	4505                	li	a0,1
    1a80:	00004097          	auipc	ra,0x4
    1a84:	d50080e7          	jalr	-688(ra) # 57d0 <exit>
      exit(i);
    1a88:	854a                	mv	a0,s2
    1a8a:	00004097          	auipc	ra,0x4
    1a8e:	d46080e7          	jalr	-698(ra) # 57d0 <exit>

0000000000001a92 <twochildren>:
{
    1a92:	1101                	addi	sp,sp,-32
    1a94:	ec06                	sd	ra,24(sp)
    1a96:	e822                	sd	s0,16(sp)
    1a98:	e426                	sd	s1,8(sp)
    1a9a:	e04a                	sd	s2,0(sp)
    1a9c:	1000                	addi	s0,sp,32
    1a9e:	892a                	mv	s2,a0
    1aa0:	3e800493          	li	s1,1000
    int pid1 = fork();
    1aa4:	00004097          	auipc	ra,0x4
    1aa8:	d24080e7          	jalr	-732(ra) # 57c8 <fork>
    if(pid1 < 0){
    1aac:	02054c63          	bltz	a0,1ae4 <twochildren+0x52>
    if(pid1 == 0){
    1ab0:	c921                	beqz	a0,1b00 <twochildren+0x6e>
      int pid2 = fork();
    1ab2:	00004097          	auipc	ra,0x4
    1ab6:	d16080e7          	jalr	-746(ra) # 57c8 <fork>
      if(pid2 < 0){
    1aba:	04054763          	bltz	a0,1b08 <twochildren+0x76>
      if(pid2 == 0){
    1abe:	c13d                	beqz	a0,1b24 <twochildren+0x92>
        wait(0);
    1ac0:	4501                	li	a0,0
    1ac2:	00004097          	auipc	ra,0x4
    1ac6:	d16080e7          	jalr	-746(ra) # 57d8 <wait>
        wait(0);
    1aca:	4501                	li	a0,0
    1acc:	00004097          	auipc	ra,0x4
    1ad0:	d0c080e7          	jalr	-756(ra) # 57d8 <wait>
  for(int i = 0; i < 1000; i++){
    1ad4:	34fd                	addiw	s1,s1,-1
    1ad6:	f4f9                	bnez	s1,1aa4 <twochildren+0x12>
}
    1ad8:	60e2                	ld	ra,24(sp)
    1ada:	6442                	ld	s0,16(sp)
    1adc:	64a2                	ld	s1,8(sp)
    1ade:	6902                	ld	s2,0(sp)
    1ae0:	6105                	addi	sp,sp,32
    1ae2:	8082                	ret
      printf("%s: fork failed\n", s);
    1ae4:	85ca                	mv	a1,s2
    1ae6:	00005517          	auipc	a0,0x5
    1aea:	ab250513          	addi	a0,a0,-1358 # 6598 <malloc+0x996>
    1aee:	00004097          	auipc	ra,0x4
    1af2:	05c080e7          	jalr	92(ra) # 5b4a <printf>
      exit(1);
    1af6:	4505                	li	a0,1
    1af8:	00004097          	auipc	ra,0x4
    1afc:	cd8080e7          	jalr	-808(ra) # 57d0 <exit>
      exit(0);
    1b00:	00004097          	auipc	ra,0x4
    1b04:	cd0080e7          	jalr	-816(ra) # 57d0 <exit>
        printf("%s: fork failed\n", s);
    1b08:	85ca                	mv	a1,s2
    1b0a:	00005517          	auipc	a0,0x5
    1b0e:	a8e50513          	addi	a0,a0,-1394 # 6598 <malloc+0x996>
    1b12:	00004097          	auipc	ra,0x4
    1b16:	038080e7          	jalr	56(ra) # 5b4a <printf>
        exit(1);
    1b1a:	4505                	li	a0,1
    1b1c:	00004097          	auipc	ra,0x4
    1b20:	cb4080e7          	jalr	-844(ra) # 57d0 <exit>
        exit(0);
    1b24:	00004097          	auipc	ra,0x4
    1b28:	cac080e7          	jalr	-852(ra) # 57d0 <exit>

0000000000001b2c <forkfork>:
{
    1b2c:	7179                	addi	sp,sp,-48
    1b2e:	f406                	sd	ra,40(sp)
    1b30:	f022                	sd	s0,32(sp)
    1b32:	ec26                	sd	s1,24(sp)
    1b34:	1800                	addi	s0,sp,48
    1b36:	84aa                	mv	s1,a0
    int pid = fork();
    1b38:	00004097          	auipc	ra,0x4
    1b3c:	c90080e7          	jalr	-880(ra) # 57c8 <fork>
    if(pid < 0){
    1b40:	04054163          	bltz	a0,1b82 <forkfork+0x56>
    if(pid == 0){
    1b44:	cd29                	beqz	a0,1b9e <forkfork+0x72>
    int pid = fork();
    1b46:	00004097          	auipc	ra,0x4
    1b4a:	c82080e7          	jalr	-894(ra) # 57c8 <fork>
    if(pid < 0){
    1b4e:	02054a63          	bltz	a0,1b82 <forkfork+0x56>
    if(pid == 0){
    1b52:	c531                	beqz	a0,1b9e <forkfork+0x72>
    wait(&xstatus);
    1b54:	fdc40513          	addi	a0,s0,-36
    1b58:	00004097          	auipc	ra,0x4
    1b5c:	c80080e7          	jalr	-896(ra) # 57d8 <wait>
    if(xstatus != 0) {
    1b60:	fdc42783          	lw	a5,-36(s0)
    1b64:	ebbd                	bnez	a5,1bda <forkfork+0xae>
    wait(&xstatus);
    1b66:	fdc40513          	addi	a0,s0,-36
    1b6a:	00004097          	auipc	ra,0x4
    1b6e:	c6e080e7          	jalr	-914(ra) # 57d8 <wait>
    if(xstatus != 0) {
    1b72:	fdc42783          	lw	a5,-36(s0)
    1b76:	e3b5                	bnez	a5,1bda <forkfork+0xae>
}
    1b78:	70a2                	ld	ra,40(sp)
    1b7a:	7402                	ld	s0,32(sp)
    1b7c:	64e2                	ld	s1,24(sp)
    1b7e:	6145                	addi	sp,sp,48
    1b80:	8082                	ret
      printf("%s: fork failed", s);
    1b82:	85a6                	mv	a1,s1
    1b84:	00005517          	auipc	a0,0x5
    1b88:	bd450513          	addi	a0,a0,-1068 # 6758 <malloc+0xb56>
    1b8c:	00004097          	auipc	ra,0x4
    1b90:	fbe080e7          	jalr	-66(ra) # 5b4a <printf>
      exit(1);
    1b94:	4505                	li	a0,1
    1b96:	00004097          	auipc	ra,0x4
    1b9a:	c3a080e7          	jalr	-966(ra) # 57d0 <exit>
{
    1b9e:	0c800493          	li	s1,200
        int pid1 = fork();
    1ba2:	00004097          	auipc	ra,0x4
    1ba6:	c26080e7          	jalr	-986(ra) # 57c8 <fork>
        if(pid1 < 0){
    1baa:	00054f63          	bltz	a0,1bc8 <forkfork+0x9c>
        if(pid1 == 0){
    1bae:	c115                	beqz	a0,1bd2 <forkfork+0xa6>
        wait(0);
    1bb0:	4501                	li	a0,0
    1bb2:	00004097          	auipc	ra,0x4
    1bb6:	c26080e7          	jalr	-986(ra) # 57d8 <wait>
      for(int j = 0; j < 200; j++){
    1bba:	34fd                	addiw	s1,s1,-1
    1bbc:	f0fd                	bnez	s1,1ba2 <forkfork+0x76>
      exit(0);
    1bbe:	4501                	li	a0,0
    1bc0:	00004097          	auipc	ra,0x4
    1bc4:	c10080e7          	jalr	-1008(ra) # 57d0 <exit>
          exit(1);
    1bc8:	4505                	li	a0,1
    1bca:	00004097          	auipc	ra,0x4
    1bce:	c06080e7          	jalr	-1018(ra) # 57d0 <exit>
          exit(0);
    1bd2:	00004097          	auipc	ra,0x4
    1bd6:	bfe080e7          	jalr	-1026(ra) # 57d0 <exit>
      printf("%s: fork in child failed", s);
    1bda:	85a6                	mv	a1,s1
    1bdc:	00005517          	auipc	a0,0x5
    1be0:	b8c50513          	addi	a0,a0,-1140 # 6768 <malloc+0xb66>
    1be4:	00004097          	auipc	ra,0x4
    1be8:	f66080e7          	jalr	-154(ra) # 5b4a <printf>
      exit(1);
    1bec:	4505                	li	a0,1
    1bee:	00004097          	auipc	ra,0x4
    1bf2:	be2080e7          	jalr	-1054(ra) # 57d0 <exit>

0000000000001bf6 <reparent2>:
{
    1bf6:	1101                	addi	sp,sp,-32
    1bf8:	ec06                	sd	ra,24(sp)
    1bfa:	e822                	sd	s0,16(sp)
    1bfc:	e426                	sd	s1,8(sp)
    1bfe:	1000                	addi	s0,sp,32
    1c00:	32000493          	li	s1,800
    int pid1 = fork();
    1c04:	00004097          	auipc	ra,0x4
    1c08:	bc4080e7          	jalr	-1084(ra) # 57c8 <fork>
    if(pid1 < 0){
    1c0c:	00054f63          	bltz	a0,1c2a <reparent2+0x34>
    if(pid1 == 0){
    1c10:	c915                	beqz	a0,1c44 <reparent2+0x4e>
    wait(0);
    1c12:	4501                	li	a0,0
    1c14:	00004097          	auipc	ra,0x4
    1c18:	bc4080e7          	jalr	-1084(ra) # 57d8 <wait>
  for(int i = 0; i < 800; i++){
    1c1c:	34fd                	addiw	s1,s1,-1
    1c1e:	f0fd                	bnez	s1,1c04 <reparent2+0xe>
  exit(0);
    1c20:	4501                	li	a0,0
    1c22:	00004097          	auipc	ra,0x4
    1c26:	bae080e7          	jalr	-1106(ra) # 57d0 <exit>
      printf("fork failed\n");
    1c2a:	00005517          	auipc	a0,0x5
    1c2e:	d7650513          	addi	a0,a0,-650 # 69a0 <malloc+0xd9e>
    1c32:	00004097          	auipc	ra,0x4
    1c36:	f18080e7          	jalr	-232(ra) # 5b4a <printf>
      exit(1);
    1c3a:	4505                	li	a0,1
    1c3c:	00004097          	auipc	ra,0x4
    1c40:	b94080e7          	jalr	-1132(ra) # 57d0 <exit>
      fork();
    1c44:	00004097          	auipc	ra,0x4
    1c48:	b84080e7          	jalr	-1148(ra) # 57c8 <fork>
      fork();
    1c4c:	00004097          	auipc	ra,0x4
    1c50:	b7c080e7          	jalr	-1156(ra) # 57c8 <fork>
      exit(0);
    1c54:	4501                	li	a0,0
    1c56:	00004097          	auipc	ra,0x4
    1c5a:	b7a080e7          	jalr	-1158(ra) # 57d0 <exit>

0000000000001c5e <createdelete>:
{
    1c5e:	7175                	addi	sp,sp,-144
    1c60:	e506                	sd	ra,136(sp)
    1c62:	e122                	sd	s0,128(sp)
    1c64:	fca6                	sd	s1,120(sp)
    1c66:	f8ca                	sd	s2,112(sp)
    1c68:	f4ce                	sd	s3,104(sp)
    1c6a:	f0d2                	sd	s4,96(sp)
    1c6c:	ecd6                	sd	s5,88(sp)
    1c6e:	e8da                	sd	s6,80(sp)
    1c70:	e4de                	sd	s7,72(sp)
    1c72:	e0e2                	sd	s8,64(sp)
    1c74:	fc66                	sd	s9,56(sp)
    1c76:	0900                	addi	s0,sp,144
    1c78:	8caa                	mv	s9,a0
  for(pi = 0; pi < NCHILD; pi++){
    1c7a:	4901                	li	s2,0
    1c7c:	4991                	li	s3,4
    pid = fork();
    1c7e:	00004097          	auipc	ra,0x4
    1c82:	b4a080e7          	jalr	-1206(ra) # 57c8 <fork>
    1c86:	84aa                	mv	s1,a0
    if(pid < 0){
    1c88:	02054f63          	bltz	a0,1cc6 <createdelete+0x68>
    if(pid == 0){
    1c8c:	c939                	beqz	a0,1ce2 <createdelete+0x84>
  for(pi = 0; pi < NCHILD; pi++){
    1c8e:	2905                	addiw	s2,s2,1
    1c90:	ff3917e3          	bne	s2,s3,1c7e <createdelete+0x20>
    1c94:	4491                	li	s1,4
    wait(&xstatus);
    1c96:	f7c40513          	addi	a0,s0,-132
    1c9a:	00004097          	auipc	ra,0x4
    1c9e:	b3e080e7          	jalr	-1218(ra) # 57d8 <wait>
    if(xstatus != 0)
    1ca2:	f7c42903          	lw	s2,-132(s0)
    1ca6:	0e091263          	bnez	s2,1d8a <createdelete+0x12c>
  for(pi = 0; pi < NCHILD; pi++){
    1caa:	34fd                	addiw	s1,s1,-1
    1cac:	f4ed                	bnez	s1,1c96 <createdelete+0x38>
  name[0] = name[1] = name[2] = 0;
    1cae:	f8040123          	sb	zero,-126(s0)
    1cb2:	03000993          	li	s3,48
    1cb6:	5a7d                	li	s4,-1
    1cb8:	07000c13          	li	s8,112
      } else if((i >= 1 && i < N/2) && fd >= 0){
    1cbc:	4b21                	li	s6,8
      if((i == 0 || i >= N/2) && fd < 0){
    1cbe:	4ba5                	li	s7,9
    for(pi = 0; pi < NCHILD; pi++){
    1cc0:	07400a93          	li	s5,116
    1cc4:	a29d                	j	1e2a <createdelete+0x1cc>
      printf("fork failed\n", s);
    1cc6:	85e6                	mv	a1,s9
    1cc8:	00005517          	auipc	a0,0x5
    1ccc:	cd850513          	addi	a0,a0,-808 # 69a0 <malloc+0xd9e>
    1cd0:	00004097          	auipc	ra,0x4
    1cd4:	e7a080e7          	jalr	-390(ra) # 5b4a <printf>
      exit(1);
    1cd8:	4505                	li	a0,1
    1cda:	00004097          	auipc	ra,0x4
    1cde:	af6080e7          	jalr	-1290(ra) # 57d0 <exit>
      name[0] = 'p' + pi;
    1ce2:	0709091b          	addiw	s2,s2,112
    1ce6:	f9240023          	sb	s2,-128(s0)
      name[2] = '\0';
    1cea:	f8040123          	sb	zero,-126(s0)
      for(i = 0; i < N; i++){
    1cee:	4951                	li	s2,20
    1cf0:	a015                	j	1d14 <createdelete+0xb6>
          printf("%s: create failed\n", s);
    1cf2:	85e6                	mv	a1,s9
    1cf4:	00005517          	auipc	a0,0x5
    1cf8:	93c50513          	addi	a0,a0,-1732 # 6630 <malloc+0xa2e>
    1cfc:	00004097          	auipc	ra,0x4
    1d00:	e4e080e7          	jalr	-434(ra) # 5b4a <printf>
          exit(1);
    1d04:	4505                	li	a0,1
    1d06:	00004097          	auipc	ra,0x4
    1d0a:	aca080e7          	jalr	-1334(ra) # 57d0 <exit>
      for(i = 0; i < N; i++){
    1d0e:	2485                	addiw	s1,s1,1
    1d10:	07248863          	beq	s1,s2,1d80 <createdelete+0x122>
        name[1] = '0' + i;
    1d14:	0304879b          	addiw	a5,s1,48
    1d18:	f8f400a3          	sb	a5,-127(s0)
        fd = open(name, O_CREATE | O_RDWR);
    1d1c:	20200593          	li	a1,514
    1d20:	f8040513          	addi	a0,s0,-128
    1d24:	00004097          	auipc	ra,0x4
    1d28:	aec080e7          	jalr	-1300(ra) # 5810 <open>
        if(fd < 0){
    1d2c:	fc0543e3          	bltz	a0,1cf2 <createdelete+0x94>
        close(fd);
    1d30:	00004097          	auipc	ra,0x4
    1d34:	ac8080e7          	jalr	-1336(ra) # 57f8 <close>
        if(i > 0 && (i % 2 ) == 0){
    1d38:	fc905be3          	blez	s1,1d0e <createdelete+0xb0>
    1d3c:	0014f793          	andi	a5,s1,1
    1d40:	f7f9                	bnez	a5,1d0e <createdelete+0xb0>
          name[1] = '0' + (i / 2);
    1d42:	01f4d79b          	srliw	a5,s1,0x1f
    1d46:	9fa5                	addw	a5,a5,s1
    1d48:	4017d79b          	sraiw	a5,a5,0x1
    1d4c:	0307879b          	addiw	a5,a5,48
    1d50:	f8f400a3          	sb	a5,-127(s0)
          if(unlink(name) < 0){
    1d54:	f8040513          	addi	a0,s0,-128
    1d58:	00004097          	auipc	ra,0x4
    1d5c:	ac8080e7          	jalr	-1336(ra) # 5820 <unlink>
    1d60:	fa0557e3          	bgez	a0,1d0e <createdelete+0xb0>
            printf("%s: unlink failed\n", s);
    1d64:	85e6                	mv	a1,s9
    1d66:	00005517          	auipc	a0,0x5
    1d6a:	a2250513          	addi	a0,a0,-1502 # 6788 <malloc+0xb86>
    1d6e:	00004097          	auipc	ra,0x4
    1d72:	ddc080e7          	jalr	-548(ra) # 5b4a <printf>
            exit(1);
    1d76:	4505                	li	a0,1
    1d78:	00004097          	auipc	ra,0x4
    1d7c:	a58080e7          	jalr	-1448(ra) # 57d0 <exit>
      exit(0);
    1d80:	4501                	li	a0,0
    1d82:	00004097          	auipc	ra,0x4
    1d86:	a4e080e7          	jalr	-1458(ra) # 57d0 <exit>
      exit(1);
    1d8a:	4505                	li	a0,1
    1d8c:	00004097          	auipc	ra,0x4
    1d90:	a44080e7          	jalr	-1468(ra) # 57d0 <exit>
        printf("%s: oops createdelete %s didn't exist\n", s, name);
    1d94:	f8040613          	addi	a2,s0,-128
    1d98:	85e6                	mv	a1,s9
    1d9a:	00005517          	auipc	a0,0x5
    1d9e:	a0650513          	addi	a0,a0,-1530 # 67a0 <malloc+0xb9e>
    1da2:	00004097          	auipc	ra,0x4
    1da6:	da8080e7          	jalr	-600(ra) # 5b4a <printf>
        exit(1);
    1daa:	4505                	li	a0,1
    1dac:	00004097          	auipc	ra,0x4
    1db0:	a24080e7          	jalr	-1500(ra) # 57d0 <exit>
      } else if((i >= 1 && i < N/2) && fd >= 0){
    1db4:	054b7163          	bgeu	s6,s4,1df6 <createdelete+0x198>
      if(fd >= 0)
    1db8:	02055a63          	bgez	a0,1dec <createdelete+0x18e>
    for(pi = 0; pi < NCHILD; pi++){
    1dbc:	2485                	addiw	s1,s1,1
    1dbe:	0ff4f493          	zext.b	s1,s1
    1dc2:	05548c63          	beq	s1,s5,1e1a <createdelete+0x1bc>
      name[0] = 'p' + pi;
    1dc6:	f8940023          	sb	s1,-128(s0)
      name[1] = '0' + i;
    1dca:	f93400a3          	sb	s3,-127(s0)
      fd = open(name, 0);
    1dce:	4581                	li	a1,0
    1dd0:	f8040513          	addi	a0,s0,-128
    1dd4:	00004097          	auipc	ra,0x4
    1dd8:	a3c080e7          	jalr	-1476(ra) # 5810 <open>
      if((i == 0 || i >= N/2) && fd < 0){
    1ddc:	00090463          	beqz	s2,1de4 <createdelete+0x186>
    1de0:	fd2bdae3          	bge	s7,s2,1db4 <createdelete+0x156>
    1de4:	fa0548e3          	bltz	a0,1d94 <createdelete+0x136>
      } else if((i >= 1 && i < N/2) && fd >= 0){
    1de8:	014b7963          	bgeu	s6,s4,1dfa <createdelete+0x19c>
        close(fd);
    1dec:	00004097          	auipc	ra,0x4
    1df0:	a0c080e7          	jalr	-1524(ra) # 57f8 <close>
    1df4:	b7e1                	j	1dbc <createdelete+0x15e>
      } else if((i >= 1 && i < N/2) && fd >= 0){
    1df6:	fc0543e3          	bltz	a0,1dbc <createdelete+0x15e>
        printf("%s: oops createdelete %s did exist\n", s, name);
    1dfa:	f8040613          	addi	a2,s0,-128
    1dfe:	85e6                	mv	a1,s9
    1e00:	00005517          	auipc	a0,0x5
    1e04:	9c850513          	addi	a0,a0,-1592 # 67c8 <malloc+0xbc6>
    1e08:	00004097          	auipc	ra,0x4
    1e0c:	d42080e7          	jalr	-702(ra) # 5b4a <printf>
        exit(1);
    1e10:	4505                	li	a0,1
    1e12:	00004097          	auipc	ra,0x4
    1e16:	9be080e7          	jalr	-1602(ra) # 57d0 <exit>
  for(i = 0; i < N; i++){
    1e1a:	2905                	addiw	s2,s2,1
    1e1c:	2a05                	addiw	s4,s4,1
    1e1e:	2985                	addiw	s3,s3,1
    1e20:	0ff9f993          	zext.b	s3,s3
    1e24:	47d1                	li	a5,20
    1e26:	02f90a63          	beq	s2,a5,1e5a <createdelete+0x1fc>
    for(pi = 0; pi < NCHILD; pi++){
    1e2a:	84e2                	mv	s1,s8
    1e2c:	bf69                	j	1dc6 <createdelete+0x168>
  for(i = 0; i < N; i++){
    1e2e:	2905                	addiw	s2,s2,1
    1e30:	0ff97913          	zext.b	s2,s2
    1e34:	2985                	addiw	s3,s3,1
    1e36:	0ff9f993          	zext.b	s3,s3
    1e3a:	03490863          	beq	s2,s4,1e6a <createdelete+0x20c>
  name[0] = name[1] = name[2] = 0;
    1e3e:	84d6                	mv	s1,s5
      name[0] = 'p' + i;
    1e40:	f9240023          	sb	s2,-128(s0)
      name[1] = '0' + i;
    1e44:	f93400a3          	sb	s3,-127(s0)
      unlink(name);
    1e48:	f8040513          	addi	a0,s0,-128
    1e4c:	00004097          	auipc	ra,0x4
    1e50:	9d4080e7          	jalr	-1580(ra) # 5820 <unlink>
    for(pi = 0; pi < NCHILD; pi++){
    1e54:	34fd                	addiw	s1,s1,-1
    1e56:	f4ed                	bnez	s1,1e40 <createdelete+0x1e2>
    1e58:	bfd9                	j	1e2e <createdelete+0x1d0>
    1e5a:	03000993          	li	s3,48
    1e5e:	07000913          	li	s2,112
  name[0] = name[1] = name[2] = 0;
    1e62:	4a91                	li	s5,4
  for(i = 0; i < N; i++){
    1e64:	08400a13          	li	s4,132
    1e68:	bfd9                	j	1e3e <createdelete+0x1e0>
}
    1e6a:	60aa                	ld	ra,136(sp)
    1e6c:	640a                	ld	s0,128(sp)
    1e6e:	74e6                	ld	s1,120(sp)
    1e70:	7946                	ld	s2,112(sp)
    1e72:	79a6                	ld	s3,104(sp)
    1e74:	7a06                	ld	s4,96(sp)
    1e76:	6ae6                	ld	s5,88(sp)
    1e78:	6b46                	ld	s6,80(sp)
    1e7a:	6ba6                	ld	s7,72(sp)
    1e7c:	6c06                	ld	s8,64(sp)
    1e7e:	7ce2                	ld	s9,56(sp)
    1e80:	6149                	addi	sp,sp,144
    1e82:	8082                	ret

0000000000001e84 <linkunlink>:
{
    1e84:	711d                	addi	sp,sp,-96
    1e86:	ec86                	sd	ra,88(sp)
    1e88:	e8a2                	sd	s0,80(sp)
    1e8a:	e4a6                	sd	s1,72(sp)
    1e8c:	e0ca                	sd	s2,64(sp)
    1e8e:	fc4e                	sd	s3,56(sp)
    1e90:	f852                	sd	s4,48(sp)
    1e92:	f456                	sd	s5,40(sp)
    1e94:	f05a                	sd	s6,32(sp)
    1e96:	ec5e                	sd	s7,24(sp)
    1e98:	e862                	sd	s8,16(sp)
    1e9a:	e466                	sd	s9,8(sp)
    1e9c:	1080                	addi	s0,sp,96
    1e9e:	84aa                	mv	s1,a0
  unlink("x");
    1ea0:	00004517          	auipc	a0,0x4
    1ea4:	ef050513          	addi	a0,a0,-272 # 5d90 <malloc+0x18e>
    1ea8:	00004097          	auipc	ra,0x4
    1eac:	978080e7          	jalr	-1672(ra) # 5820 <unlink>
  pid = fork();
    1eb0:	00004097          	auipc	ra,0x4
    1eb4:	918080e7          	jalr	-1768(ra) # 57c8 <fork>
  if(pid < 0){
    1eb8:	02054b63          	bltz	a0,1eee <linkunlink+0x6a>
    1ebc:	8c2a                	mv	s8,a0
  unsigned int x = (pid ? 1 : 97);
    1ebe:	4c85                	li	s9,1
    1ec0:	e119                	bnez	a0,1ec6 <linkunlink+0x42>
    1ec2:	06100c93          	li	s9,97
    1ec6:	06400493          	li	s1,100
    x = x * 1103515245 + 12345;
    1eca:	41c659b7          	lui	s3,0x41c65
    1ece:	e6d9899b          	addiw	s3,s3,-403
    1ed2:	690d                	lui	s2,0x3
    1ed4:	0399091b          	addiw	s2,s2,57
    if((x % 3) == 0){
    1ed8:	4a0d                	li	s4,3
    } else if((x % 3) == 1){
    1eda:	4b05                	li	s6,1
      unlink("x");
    1edc:	00004a97          	auipc	s5,0x4
    1ee0:	eb4a8a93          	addi	s5,s5,-332 # 5d90 <malloc+0x18e>
      link("cat", "x");
    1ee4:	00005b97          	auipc	s7,0x5
    1ee8:	90cb8b93          	addi	s7,s7,-1780 # 67f0 <malloc+0xbee>
    1eec:	a825                	j	1f24 <linkunlink+0xa0>
    printf("%s: fork failed\n", s);
    1eee:	85a6                	mv	a1,s1
    1ef0:	00004517          	auipc	a0,0x4
    1ef4:	6a850513          	addi	a0,a0,1704 # 6598 <malloc+0x996>
    1ef8:	00004097          	auipc	ra,0x4
    1efc:	c52080e7          	jalr	-942(ra) # 5b4a <printf>
    exit(1);
    1f00:	4505                	li	a0,1
    1f02:	00004097          	auipc	ra,0x4
    1f06:	8ce080e7          	jalr	-1842(ra) # 57d0 <exit>
      close(open("x", O_RDWR | O_CREATE));
    1f0a:	20200593          	li	a1,514
    1f0e:	8556                	mv	a0,s5
    1f10:	00004097          	auipc	ra,0x4
    1f14:	900080e7          	jalr	-1792(ra) # 5810 <open>
    1f18:	00004097          	auipc	ra,0x4
    1f1c:	8e0080e7          	jalr	-1824(ra) # 57f8 <close>
  for(i = 0; i < 100; i++){
    1f20:	34fd                	addiw	s1,s1,-1
    1f22:	c88d                	beqz	s1,1f54 <linkunlink+0xd0>
    x = x * 1103515245 + 12345;
    1f24:	033c87bb          	mulw	a5,s9,s3
    1f28:	012787bb          	addw	a5,a5,s2
    1f2c:	00078c9b          	sext.w	s9,a5
    if((x % 3) == 0){
    1f30:	0347f7bb          	remuw	a5,a5,s4
    1f34:	dbf9                	beqz	a5,1f0a <linkunlink+0x86>
    } else if((x % 3) == 1){
    1f36:	01678863          	beq	a5,s6,1f46 <linkunlink+0xc2>
      unlink("x");
    1f3a:	8556                	mv	a0,s5
    1f3c:	00004097          	auipc	ra,0x4
    1f40:	8e4080e7          	jalr	-1820(ra) # 5820 <unlink>
    1f44:	bff1                	j	1f20 <linkunlink+0x9c>
      link("cat", "x");
    1f46:	85d6                	mv	a1,s5
    1f48:	855e                	mv	a0,s7
    1f4a:	00004097          	auipc	ra,0x4
    1f4e:	8e6080e7          	jalr	-1818(ra) # 5830 <link>
    1f52:	b7f9                	j	1f20 <linkunlink+0x9c>
  if(pid)
    1f54:	020c0463          	beqz	s8,1f7c <linkunlink+0xf8>
    wait(0);
    1f58:	4501                	li	a0,0
    1f5a:	00004097          	auipc	ra,0x4
    1f5e:	87e080e7          	jalr	-1922(ra) # 57d8 <wait>
}
    1f62:	60e6                	ld	ra,88(sp)
    1f64:	6446                	ld	s0,80(sp)
    1f66:	64a6                	ld	s1,72(sp)
    1f68:	6906                	ld	s2,64(sp)
    1f6a:	79e2                	ld	s3,56(sp)
    1f6c:	7a42                	ld	s4,48(sp)
    1f6e:	7aa2                	ld	s5,40(sp)
    1f70:	7b02                	ld	s6,32(sp)
    1f72:	6be2                	ld	s7,24(sp)
    1f74:	6c42                	ld	s8,16(sp)
    1f76:	6ca2                	ld	s9,8(sp)
    1f78:	6125                	addi	sp,sp,96
    1f7a:	8082                	ret
    exit(0);
    1f7c:	4501                	li	a0,0
    1f7e:	00004097          	auipc	ra,0x4
    1f82:	852080e7          	jalr	-1966(ra) # 57d0 <exit>

0000000000001f86 <forktest>:
{
    1f86:	7179                	addi	sp,sp,-48
    1f88:	f406                	sd	ra,40(sp)
    1f8a:	f022                	sd	s0,32(sp)
    1f8c:	ec26                	sd	s1,24(sp)
    1f8e:	e84a                	sd	s2,16(sp)
    1f90:	e44e                	sd	s3,8(sp)
    1f92:	1800                	addi	s0,sp,48
    1f94:	89aa                	mv	s3,a0
  for(n=0; n<N; n++){
    1f96:	4481                	li	s1,0
    1f98:	3e800913          	li	s2,1000
    pid = fork();
    1f9c:	00004097          	auipc	ra,0x4
    1fa0:	82c080e7          	jalr	-2004(ra) # 57c8 <fork>
    if(pid < 0)
    1fa4:	02054863          	bltz	a0,1fd4 <forktest+0x4e>
    if(pid == 0)
    1fa8:	c115                	beqz	a0,1fcc <forktest+0x46>
  for(n=0; n<N; n++){
    1faa:	2485                	addiw	s1,s1,1
    1fac:	ff2498e3          	bne	s1,s2,1f9c <forktest+0x16>
    printf("%s: fork claimed to work 1000 times!\n", s);
    1fb0:	85ce                	mv	a1,s3
    1fb2:	00005517          	auipc	a0,0x5
    1fb6:	85e50513          	addi	a0,a0,-1954 # 6810 <malloc+0xc0e>
    1fba:	00004097          	auipc	ra,0x4
    1fbe:	b90080e7          	jalr	-1136(ra) # 5b4a <printf>
    exit(1);
    1fc2:	4505                	li	a0,1
    1fc4:	00004097          	auipc	ra,0x4
    1fc8:	80c080e7          	jalr	-2036(ra) # 57d0 <exit>
      exit(0);
    1fcc:	00004097          	auipc	ra,0x4
    1fd0:	804080e7          	jalr	-2044(ra) # 57d0 <exit>
  if (n == 0) {
    1fd4:	cc9d                	beqz	s1,2012 <forktest+0x8c>
  if(n == N){
    1fd6:	3e800793          	li	a5,1000
    1fda:	fcf48be3          	beq	s1,a5,1fb0 <forktest+0x2a>
  for(; n > 0; n--){
    1fde:	00905b63          	blez	s1,1ff4 <forktest+0x6e>
    if(wait(0) < 0){
    1fe2:	4501                	li	a0,0
    1fe4:	00003097          	auipc	ra,0x3
    1fe8:	7f4080e7          	jalr	2036(ra) # 57d8 <wait>
    1fec:	04054163          	bltz	a0,202e <forktest+0xa8>
  for(; n > 0; n--){
    1ff0:	34fd                	addiw	s1,s1,-1
    1ff2:	f8e5                	bnez	s1,1fe2 <forktest+0x5c>
  if(wait(0) != -1){
    1ff4:	4501                	li	a0,0
    1ff6:	00003097          	auipc	ra,0x3
    1ffa:	7e2080e7          	jalr	2018(ra) # 57d8 <wait>
    1ffe:	57fd                	li	a5,-1
    2000:	04f51563          	bne	a0,a5,204a <forktest+0xc4>
}
    2004:	70a2                	ld	ra,40(sp)
    2006:	7402                	ld	s0,32(sp)
    2008:	64e2                	ld	s1,24(sp)
    200a:	6942                	ld	s2,16(sp)
    200c:	69a2                	ld	s3,8(sp)
    200e:	6145                	addi	sp,sp,48
    2010:	8082                	ret
    printf("%s: no fork at all!\n", s);
    2012:	85ce                	mv	a1,s3
    2014:	00004517          	auipc	a0,0x4
    2018:	7e450513          	addi	a0,a0,2020 # 67f8 <malloc+0xbf6>
    201c:	00004097          	auipc	ra,0x4
    2020:	b2e080e7          	jalr	-1234(ra) # 5b4a <printf>
    exit(1);
    2024:	4505                	li	a0,1
    2026:	00003097          	auipc	ra,0x3
    202a:	7aa080e7          	jalr	1962(ra) # 57d0 <exit>
      printf("%s: wait stopped early\n", s);
    202e:	85ce                	mv	a1,s3
    2030:	00005517          	auipc	a0,0x5
    2034:	80850513          	addi	a0,a0,-2040 # 6838 <malloc+0xc36>
    2038:	00004097          	auipc	ra,0x4
    203c:	b12080e7          	jalr	-1262(ra) # 5b4a <printf>
      exit(1);
    2040:	4505                	li	a0,1
    2042:	00003097          	auipc	ra,0x3
    2046:	78e080e7          	jalr	1934(ra) # 57d0 <exit>
    printf("%s: wait got too many\n", s);
    204a:	85ce                	mv	a1,s3
    204c:	00005517          	auipc	a0,0x5
    2050:	80450513          	addi	a0,a0,-2044 # 6850 <malloc+0xc4e>
    2054:	00004097          	auipc	ra,0x4
    2058:	af6080e7          	jalr	-1290(ra) # 5b4a <printf>
    exit(1);
    205c:	4505                	li	a0,1
    205e:	00003097          	auipc	ra,0x3
    2062:	772080e7          	jalr	1906(ra) # 57d0 <exit>

0000000000002066 <kernmem>:
{
    2066:	715d                	addi	sp,sp,-80
    2068:	e486                	sd	ra,72(sp)
    206a:	e0a2                	sd	s0,64(sp)
    206c:	fc26                	sd	s1,56(sp)
    206e:	f84a                	sd	s2,48(sp)
    2070:	f44e                	sd	s3,40(sp)
    2072:	f052                	sd	s4,32(sp)
    2074:	ec56                	sd	s5,24(sp)
    2076:	0880                	addi	s0,sp,80
    2078:	8a2a                	mv	s4,a0
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    207a:	4485                	li	s1,1
    207c:	04fe                	slli	s1,s1,0x1f
    if(xstatus != -1)  // did kernel kill child?
    207e:	5afd                	li	s5,-1
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    2080:	69b1                	lui	s3,0xc
    2082:	35098993          	addi	s3,s3,848 # c350 <buf+0x5d8>
    2086:	1003d937          	lui	s2,0x1003d
    208a:	090e                	slli	s2,s2,0x3
    208c:	48090913          	addi	s2,s2,1152 # 1003d480 <__BSS_END__+0x1002e6f8>
    pid = fork();
    2090:	00003097          	auipc	ra,0x3
    2094:	738080e7          	jalr	1848(ra) # 57c8 <fork>
    if(pid < 0){
    2098:	02054963          	bltz	a0,20ca <kernmem+0x64>
    if(pid == 0){
    209c:	c529                	beqz	a0,20e6 <kernmem+0x80>
    wait(&xstatus);
    209e:	fbc40513          	addi	a0,s0,-68
    20a2:	00003097          	auipc	ra,0x3
    20a6:	736080e7          	jalr	1846(ra) # 57d8 <wait>
    if(xstatus != -1)  // did kernel kill child?
    20aa:	fbc42783          	lw	a5,-68(s0)
    20ae:	05579d63          	bne	a5,s5,2108 <kernmem+0xa2>
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    20b2:	94ce                	add	s1,s1,s3
    20b4:	fd249ee3          	bne	s1,s2,2090 <kernmem+0x2a>
}
    20b8:	60a6                	ld	ra,72(sp)
    20ba:	6406                	ld	s0,64(sp)
    20bc:	74e2                	ld	s1,56(sp)
    20be:	7942                	ld	s2,48(sp)
    20c0:	79a2                	ld	s3,40(sp)
    20c2:	7a02                	ld	s4,32(sp)
    20c4:	6ae2                	ld	s5,24(sp)
    20c6:	6161                	addi	sp,sp,80
    20c8:	8082                	ret
      printf("%s: fork failed\n", s);
    20ca:	85d2                	mv	a1,s4
    20cc:	00004517          	auipc	a0,0x4
    20d0:	4cc50513          	addi	a0,a0,1228 # 6598 <malloc+0x996>
    20d4:	00004097          	auipc	ra,0x4
    20d8:	a76080e7          	jalr	-1418(ra) # 5b4a <printf>
      exit(1);
    20dc:	4505                	li	a0,1
    20de:	00003097          	auipc	ra,0x3
    20e2:	6f2080e7          	jalr	1778(ra) # 57d0 <exit>
      printf("%s: oops could read %x = %x\n", s, a, *a);
    20e6:	0004c683          	lbu	a3,0(s1)
    20ea:	8626                	mv	a2,s1
    20ec:	85d2                	mv	a1,s4
    20ee:	00004517          	auipc	a0,0x4
    20f2:	77a50513          	addi	a0,a0,1914 # 6868 <malloc+0xc66>
    20f6:	00004097          	auipc	ra,0x4
    20fa:	a54080e7          	jalr	-1452(ra) # 5b4a <printf>
      exit(1);
    20fe:	4505                	li	a0,1
    2100:	00003097          	auipc	ra,0x3
    2104:	6d0080e7          	jalr	1744(ra) # 57d0 <exit>
      exit(1);
    2108:	4505                	li	a0,1
    210a:	00003097          	auipc	ra,0x3
    210e:	6c6080e7          	jalr	1734(ra) # 57d0 <exit>

0000000000002112 <MAXVAplus>:
{
    2112:	7179                	addi	sp,sp,-48
    2114:	f406                	sd	ra,40(sp)
    2116:	f022                	sd	s0,32(sp)
    2118:	ec26                	sd	s1,24(sp)
    211a:	e84a                	sd	s2,16(sp)
    211c:	1800                	addi	s0,sp,48
  volatile uint64 a = MAXVA;
    211e:	4785                	li	a5,1
    2120:	179a                	slli	a5,a5,0x26
    2122:	fcf43c23          	sd	a5,-40(s0)
  for( ; a != 0; a <<= 1){
    2126:	fd843783          	ld	a5,-40(s0)
    212a:	cf85                	beqz	a5,2162 <MAXVAplus+0x50>
    212c:	892a                	mv	s2,a0
    if(xstatus != -1)  // did kernel kill child?
    212e:	54fd                	li	s1,-1
    pid = fork();
    2130:	00003097          	auipc	ra,0x3
    2134:	698080e7          	jalr	1688(ra) # 57c8 <fork>
    if(pid < 0){
    2138:	02054b63          	bltz	a0,216e <MAXVAplus+0x5c>
    if(pid == 0){
    213c:	c539                	beqz	a0,218a <MAXVAplus+0x78>
    wait(&xstatus);
    213e:	fd440513          	addi	a0,s0,-44
    2142:	00003097          	auipc	ra,0x3
    2146:	696080e7          	jalr	1686(ra) # 57d8 <wait>
    if(xstatus != -1)  // did kernel kill child?
    214a:	fd442783          	lw	a5,-44(s0)
    214e:	06979463          	bne	a5,s1,21b6 <MAXVAplus+0xa4>
  for( ; a != 0; a <<= 1){
    2152:	fd843783          	ld	a5,-40(s0)
    2156:	0786                	slli	a5,a5,0x1
    2158:	fcf43c23          	sd	a5,-40(s0)
    215c:	fd843783          	ld	a5,-40(s0)
    2160:	fbe1                	bnez	a5,2130 <MAXVAplus+0x1e>
}
    2162:	70a2                	ld	ra,40(sp)
    2164:	7402                	ld	s0,32(sp)
    2166:	64e2                	ld	s1,24(sp)
    2168:	6942                	ld	s2,16(sp)
    216a:	6145                	addi	sp,sp,48
    216c:	8082                	ret
      printf("%s: fork failed\n", s);
    216e:	85ca                	mv	a1,s2
    2170:	00004517          	auipc	a0,0x4
    2174:	42850513          	addi	a0,a0,1064 # 6598 <malloc+0x996>
    2178:	00004097          	auipc	ra,0x4
    217c:	9d2080e7          	jalr	-1582(ra) # 5b4a <printf>
      exit(1);
    2180:	4505                	li	a0,1
    2182:	00003097          	auipc	ra,0x3
    2186:	64e080e7          	jalr	1614(ra) # 57d0 <exit>
      *(char*)a = 99;
    218a:	fd843783          	ld	a5,-40(s0)
    218e:	06300713          	li	a4,99
    2192:	00e78023          	sb	a4,0(a5)
      printf("%s: oops wrote %x\n", s, a);
    2196:	fd843603          	ld	a2,-40(s0)
    219a:	85ca                	mv	a1,s2
    219c:	00004517          	auipc	a0,0x4
    21a0:	6ec50513          	addi	a0,a0,1772 # 6888 <malloc+0xc86>
    21a4:	00004097          	auipc	ra,0x4
    21a8:	9a6080e7          	jalr	-1626(ra) # 5b4a <printf>
      exit(1);
    21ac:	4505                	li	a0,1
    21ae:	00003097          	auipc	ra,0x3
    21b2:	622080e7          	jalr	1570(ra) # 57d0 <exit>
      exit(1);
    21b6:	4505                	li	a0,1
    21b8:	00003097          	auipc	ra,0x3
    21bc:	618080e7          	jalr	1560(ra) # 57d0 <exit>

00000000000021c0 <bigargtest>:
{
    21c0:	7179                	addi	sp,sp,-48
    21c2:	f406                	sd	ra,40(sp)
    21c4:	f022                	sd	s0,32(sp)
    21c6:	ec26                	sd	s1,24(sp)
    21c8:	1800                	addi	s0,sp,48
    21ca:	84aa                	mv	s1,a0
  unlink("bigarg-ok");
    21cc:	00004517          	auipc	a0,0x4
    21d0:	6d450513          	addi	a0,a0,1748 # 68a0 <malloc+0xc9e>
    21d4:	00003097          	auipc	ra,0x3
    21d8:	64c080e7          	jalr	1612(ra) # 5820 <unlink>
  pid = fork();
    21dc:	00003097          	auipc	ra,0x3
    21e0:	5ec080e7          	jalr	1516(ra) # 57c8 <fork>
  if(pid == 0){
    21e4:	c121                	beqz	a0,2224 <bigargtest+0x64>
  } else if(pid < 0){
    21e6:	0a054063          	bltz	a0,2286 <bigargtest+0xc6>
  wait(&xstatus);
    21ea:	fdc40513          	addi	a0,s0,-36
    21ee:	00003097          	auipc	ra,0x3
    21f2:	5ea080e7          	jalr	1514(ra) # 57d8 <wait>
  if(xstatus != 0)
    21f6:	fdc42503          	lw	a0,-36(s0)
    21fa:	e545                	bnez	a0,22a2 <bigargtest+0xe2>
  fd = open("bigarg-ok", 0);
    21fc:	4581                	li	a1,0
    21fe:	00004517          	auipc	a0,0x4
    2202:	6a250513          	addi	a0,a0,1698 # 68a0 <malloc+0xc9e>
    2206:	00003097          	auipc	ra,0x3
    220a:	60a080e7          	jalr	1546(ra) # 5810 <open>
  if(fd < 0){
    220e:	08054e63          	bltz	a0,22aa <bigargtest+0xea>
  close(fd);
    2212:	00003097          	auipc	ra,0x3
    2216:	5e6080e7          	jalr	1510(ra) # 57f8 <close>
}
    221a:	70a2                	ld	ra,40(sp)
    221c:	7402                	ld	s0,32(sp)
    221e:	64e2                	ld	s1,24(sp)
    2220:	6145                	addi	sp,sp,48
    2222:	8082                	ret
    2224:	00006797          	auipc	a5,0x6
    2228:	33c78793          	addi	a5,a5,828 # 8560 <args.1>
    222c:	00006697          	auipc	a3,0x6
    2230:	42c68693          	addi	a3,a3,1068 # 8658 <args.1+0xf8>
      args[i] = "bigargs test: failed\n                                                                                                                                                                                                       ";
    2234:	00004717          	auipc	a4,0x4
    2238:	67c70713          	addi	a4,a4,1660 # 68b0 <malloc+0xcae>
    223c:	e398                	sd	a4,0(a5)
    for(i = 0; i < MAXARG-1; i++)
    223e:	07a1                	addi	a5,a5,8
    2240:	fed79ee3          	bne	a5,a3,223c <bigargtest+0x7c>
    args[MAXARG-1] = 0;
    2244:	00006597          	auipc	a1,0x6
    2248:	31c58593          	addi	a1,a1,796 # 8560 <args.1>
    224c:	0e05bc23          	sd	zero,248(a1)
    exec("echo", args);
    2250:	00004517          	auipc	a0,0x4
    2254:	ad050513          	addi	a0,a0,-1328 # 5d20 <malloc+0x11e>
    2258:	00003097          	auipc	ra,0x3
    225c:	5b0080e7          	jalr	1456(ra) # 5808 <exec>
    fd = open("bigarg-ok", O_CREATE);
    2260:	20000593          	li	a1,512
    2264:	00004517          	auipc	a0,0x4
    2268:	63c50513          	addi	a0,a0,1596 # 68a0 <malloc+0xc9e>
    226c:	00003097          	auipc	ra,0x3
    2270:	5a4080e7          	jalr	1444(ra) # 5810 <open>
    close(fd);
    2274:	00003097          	auipc	ra,0x3
    2278:	584080e7          	jalr	1412(ra) # 57f8 <close>
    exit(0);
    227c:	4501                	li	a0,0
    227e:	00003097          	auipc	ra,0x3
    2282:	552080e7          	jalr	1362(ra) # 57d0 <exit>
    printf("%s: bigargtest: fork failed\n", s);
    2286:	85a6                	mv	a1,s1
    2288:	00004517          	auipc	a0,0x4
    228c:	70850513          	addi	a0,a0,1800 # 6990 <malloc+0xd8e>
    2290:	00004097          	auipc	ra,0x4
    2294:	8ba080e7          	jalr	-1862(ra) # 5b4a <printf>
    exit(1);
    2298:	4505                	li	a0,1
    229a:	00003097          	auipc	ra,0x3
    229e:	536080e7          	jalr	1334(ra) # 57d0 <exit>
    exit(xstatus);
    22a2:	00003097          	auipc	ra,0x3
    22a6:	52e080e7          	jalr	1326(ra) # 57d0 <exit>
    printf("%s: bigarg test failed!\n", s);
    22aa:	85a6                	mv	a1,s1
    22ac:	00004517          	auipc	a0,0x4
    22b0:	70450513          	addi	a0,a0,1796 # 69b0 <malloc+0xdae>
    22b4:	00004097          	auipc	ra,0x4
    22b8:	896080e7          	jalr	-1898(ra) # 5b4a <printf>
    exit(1);
    22bc:	4505                	li	a0,1
    22be:	00003097          	auipc	ra,0x3
    22c2:	512080e7          	jalr	1298(ra) # 57d0 <exit>

00000000000022c6 <stacktest>:
{
    22c6:	7179                	addi	sp,sp,-48
    22c8:	f406                	sd	ra,40(sp)
    22ca:	f022                	sd	s0,32(sp)
    22cc:	ec26                	sd	s1,24(sp)
    22ce:	1800                	addi	s0,sp,48
    22d0:	84aa                	mv	s1,a0
  pid = fork();
    22d2:	00003097          	auipc	ra,0x3
    22d6:	4f6080e7          	jalr	1270(ra) # 57c8 <fork>
  if(pid == 0) {
    22da:	c115                	beqz	a0,22fe <stacktest+0x38>
  } else if(pid < 0){
    22dc:	04054463          	bltz	a0,2324 <stacktest+0x5e>
  wait(&xstatus);
    22e0:	fdc40513          	addi	a0,s0,-36
    22e4:	00003097          	auipc	ra,0x3
    22e8:	4f4080e7          	jalr	1268(ra) # 57d8 <wait>
  if(xstatus == -1)  // kernel killed child?
    22ec:	fdc42503          	lw	a0,-36(s0)
    22f0:	57fd                	li	a5,-1
    22f2:	04f50763          	beq	a0,a5,2340 <stacktest+0x7a>
    exit(xstatus);
    22f6:	00003097          	auipc	ra,0x3
    22fa:	4da080e7          	jalr	1242(ra) # 57d0 <exit>

static inline uint64
r_sp()
{
  uint64 x;
  asm volatile("mv %0, sp" : "=r" (x) );
    22fe:	870a                	mv	a4,sp
    printf("%s: stacktest: read below stack %p\n", s, *sp);
    2300:	77fd                	lui	a5,0xfffff
    2302:	97ba                	add	a5,a5,a4
    2304:	0007c603          	lbu	a2,0(a5) # fffffffffffff000 <__BSS_END__+0xffffffffffff0278>
    2308:	85a6                	mv	a1,s1
    230a:	00004517          	auipc	a0,0x4
    230e:	6c650513          	addi	a0,a0,1734 # 69d0 <malloc+0xdce>
    2312:	00004097          	auipc	ra,0x4
    2316:	838080e7          	jalr	-1992(ra) # 5b4a <printf>
    exit(1);
    231a:	4505                	li	a0,1
    231c:	00003097          	auipc	ra,0x3
    2320:	4b4080e7          	jalr	1204(ra) # 57d0 <exit>
    printf("%s: fork failed\n", s);
    2324:	85a6                	mv	a1,s1
    2326:	00004517          	auipc	a0,0x4
    232a:	27250513          	addi	a0,a0,626 # 6598 <malloc+0x996>
    232e:	00004097          	auipc	ra,0x4
    2332:	81c080e7          	jalr	-2020(ra) # 5b4a <printf>
    exit(1);
    2336:	4505                	li	a0,1
    2338:	00003097          	auipc	ra,0x3
    233c:	498080e7          	jalr	1176(ra) # 57d0 <exit>
    exit(0);
    2340:	4501                	li	a0,0
    2342:	00003097          	auipc	ra,0x3
    2346:	48e080e7          	jalr	1166(ra) # 57d0 <exit>

000000000000234a <mycopyinstr3>:
{
    234a:	7179                	addi	sp,sp,-48
    234c:	f406                	sd	ra,40(sp)
    234e:	f022                	sd	s0,32(sp)
    2350:	ec26                	sd	s1,24(sp)
    2352:	1800                	addi	s0,sp,48
  sbrk(8192);
    2354:	6509                	lui	a0,0x2
    2356:	00003097          	auipc	ra,0x3
    235a:	502080e7          	jalr	1282(ra) # 5858 <sbrk>
  uint64 top = (uint64) sbrk(0);
    235e:	4501                	li	a0,0
    2360:	00003097          	auipc	ra,0x3
    2364:	4f8080e7          	jalr	1272(ra) # 5858 <sbrk>
  if((top % PGSIZE) != 0){
    2368:	03451793          	slli	a5,a0,0x34
    236c:	e3c9                	bnez	a5,23ee <mycopyinstr3+0xa4>
  top = (uint64) sbrk(0);
    236e:	4501                	li	a0,0
    2370:	00003097          	auipc	ra,0x3
    2374:	4e8080e7          	jalr	1256(ra) # 5858 <sbrk>
  if(top % PGSIZE){
    2378:	03451793          	slli	a5,a0,0x34
    237c:	e3d9                	bnez	a5,2402 <mycopyinstr3+0xb8>
  char *b = (char *) (top - 1);
    237e:	fff50493          	addi	s1,a0,-1 # 1fff <forktest+0x79>
  *b = 'x';
    2382:	07800793          	li	a5,120
    2386:	fef50fa3          	sb	a5,-1(a0)
  int ret = unlink(b);
    238a:	8526                	mv	a0,s1
    238c:	00003097          	auipc	ra,0x3
    2390:	494080e7          	jalr	1172(ra) # 5820 <unlink>
  if(ret != -1){
    2394:	57fd                	li	a5,-1
    2396:	08f51363          	bne	a0,a5,241c <mycopyinstr3+0xd2>
  int fd = open(b, O_CREATE | O_WRONLY);
    239a:	20100593          	li	a1,513
    239e:	8526                	mv	a0,s1
    23a0:	00003097          	auipc	ra,0x3
    23a4:	470080e7          	jalr	1136(ra) # 5810 <open>
  if(fd != -1){
    23a8:	57fd                	li	a5,-1
    23aa:	08f51863          	bne	a0,a5,243a <mycopyinstr3+0xf0>
  ret = link(b, b);
    23ae:	85a6                	mv	a1,s1
    23b0:	8526                	mv	a0,s1
    23b2:	00003097          	auipc	ra,0x3
    23b6:	47e080e7          	jalr	1150(ra) # 5830 <link>
  if(ret != -1){
    23ba:	57fd                	li	a5,-1
    23bc:	08f51e63          	bne	a0,a5,2458 <mycopyinstr3+0x10e>
  char *args[] = { "xx", 0 };
    23c0:	00005797          	auipc	a5,0x5
    23c4:	2b878793          	addi	a5,a5,696 # 7678 <malloc+0x1a76>
    23c8:	fcf43823          	sd	a5,-48(s0)
    23cc:	fc043c23          	sd	zero,-40(s0)
  ret = exec(b, args);
    23d0:	fd040593          	addi	a1,s0,-48
    23d4:	8526                	mv	a0,s1
    23d6:	00003097          	auipc	ra,0x3
    23da:	432080e7          	jalr	1074(ra) # 5808 <exec>
  if(ret != -1){
    23de:	57fd                	li	a5,-1
    23e0:	08f51c63          	bne	a0,a5,2478 <mycopyinstr3+0x12e>
}
    23e4:	70a2                	ld	ra,40(sp)
    23e6:	7402                	ld	s0,32(sp)
    23e8:	64e2                	ld	s1,24(sp)
    23ea:	6145                	addi	sp,sp,48
    23ec:	8082                	ret
    sbrk(PGSIZE - (top % PGSIZE));
    23ee:	0347d513          	srli	a0,a5,0x34
    23f2:	6785                	lui	a5,0x1
    23f4:	40a7853b          	subw	a0,a5,a0
    23f8:	00003097          	auipc	ra,0x3
    23fc:	460080e7          	jalr	1120(ra) # 5858 <sbrk>
    2400:	b7bd                	j	236e <mycopyinstr3+0x24>
    printf("oops\n");
    2402:	00004517          	auipc	a0,0x4
    2406:	5f650513          	addi	a0,a0,1526 # 69f8 <malloc+0xdf6>
    240a:	00003097          	auipc	ra,0x3
    240e:	740080e7          	jalr	1856(ra) # 5b4a <printf>
    exit(1);
    2412:	4505                	li	a0,1
    2414:	00003097          	auipc	ra,0x3
    2418:	3bc080e7          	jalr	956(ra) # 57d0 <exit>
    printf("unlink(%s) returned %d, not -1\n", b, ret);
    241c:	862a                	mv	a2,a0
    241e:	85a6                	mv	a1,s1
    2420:	00004517          	auipc	a0,0x4
    2424:	09850513          	addi	a0,a0,152 # 64b8 <malloc+0x8b6>
    2428:	00003097          	auipc	ra,0x3
    242c:	722080e7          	jalr	1826(ra) # 5b4a <printf>
    exit(1);
    2430:	4505                	li	a0,1
    2432:	00003097          	auipc	ra,0x3
    2436:	39e080e7          	jalr	926(ra) # 57d0 <exit>
    printf("open(%s) returned %d, not -1\n", b, fd);
    243a:	862a                	mv	a2,a0
    243c:	85a6                	mv	a1,s1
    243e:	00004517          	auipc	a0,0x4
    2442:	09a50513          	addi	a0,a0,154 # 64d8 <malloc+0x8d6>
    2446:	00003097          	auipc	ra,0x3
    244a:	704080e7          	jalr	1796(ra) # 5b4a <printf>
    exit(1);
    244e:	4505                	li	a0,1
    2450:	00003097          	auipc	ra,0x3
    2454:	380080e7          	jalr	896(ra) # 57d0 <exit>
    printf("link(%s, %s) returned %d, not -1\n", b, b, ret);
    2458:	86aa                	mv	a3,a0
    245a:	8626                	mv	a2,s1
    245c:	85a6                	mv	a1,s1
    245e:	00004517          	auipc	a0,0x4
    2462:	09a50513          	addi	a0,a0,154 # 64f8 <malloc+0x8f6>
    2466:	00003097          	auipc	ra,0x3
    246a:	6e4080e7          	jalr	1764(ra) # 5b4a <printf>
    exit(1);
    246e:	4505                	li	a0,1
    2470:	00003097          	auipc	ra,0x3
    2474:	360080e7          	jalr	864(ra) # 57d0 <exit>
    printf("exec(%s) returned %d, not -1\n", b, fd);
    2478:	567d                	li	a2,-1
    247a:	85a6                	mv	a1,s1
    247c:	00004517          	auipc	a0,0x4
    2480:	0a450513          	addi	a0,a0,164 # 6520 <malloc+0x91e>
    2484:	00003097          	auipc	ra,0x3
    2488:	6c6080e7          	jalr	1734(ra) # 5b4a <printf>
    exit(1);
    248c:	4505                	li	a0,1
    248e:	00003097          	auipc	ra,0x3
    2492:	342080e7          	jalr	834(ra) # 57d0 <exit>

0000000000002496 <rwsbrk>:
{
    2496:	1101                	addi	sp,sp,-32
    2498:	ec06                	sd	ra,24(sp)
    249a:	e822                	sd	s0,16(sp)
    249c:	e426                	sd	s1,8(sp)
    249e:	e04a                	sd	s2,0(sp)
    24a0:	1000                	addi	s0,sp,32
  uint64 a = (uint64) sbrk(8192);
    24a2:	6509                	lui	a0,0x2
    24a4:	00003097          	auipc	ra,0x3
    24a8:	3b4080e7          	jalr	948(ra) # 5858 <sbrk>
  if(a == 0xffffffffffffffffLL) {
    24ac:	57fd                	li	a5,-1
    24ae:	06f50263          	beq	a0,a5,2512 <rwsbrk+0x7c>
    24b2:	84aa                	mv	s1,a0
  if ((uint64) sbrk(-8192) ==  0xffffffffffffffffLL) {
    24b4:	7579                	lui	a0,0xffffe
    24b6:	00003097          	auipc	ra,0x3
    24ba:	3a2080e7          	jalr	930(ra) # 5858 <sbrk>
    24be:	57fd                	li	a5,-1
    24c0:	06f50663          	beq	a0,a5,252c <rwsbrk+0x96>
  fd = open("rwsbrk", O_CREATE|O_WRONLY);
    24c4:	20100593          	li	a1,513
    24c8:	00004517          	auipc	a0,0x4
    24cc:	57050513          	addi	a0,a0,1392 # 6a38 <malloc+0xe36>
    24d0:	00003097          	auipc	ra,0x3
    24d4:	340080e7          	jalr	832(ra) # 5810 <open>
    24d8:	892a                	mv	s2,a0
  if(fd < 0){
    24da:	06054663          	bltz	a0,2546 <rwsbrk+0xb0>
  n = write(fd, (void*)(a+4096), 1024);
    24de:	6785                	lui	a5,0x1
    24e0:	94be                	add	s1,s1,a5
    24e2:	40000613          	li	a2,1024
    24e6:	85a6                	mv	a1,s1
    24e8:	00003097          	auipc	ra,0x3
    24ec:	308080e7          	jalr	776(ra) # 57f0 <write>
    24f0:	862a                	mv	a2,a0
  if(n >= 0){
    24f2:	06054763          	bltz	a0,2560 <rwsbrk+0xca>
    printf("write(fd, %p, 1024) returned %d, not -1\n", a+4096, n);
    24f6:	85a6                	mv	a1,s1
    24f8:	00004517          	auipc	a0,0x4
    24fc:	56050513          	addi	a0,a0,1376 # 6a58 <malloc+0xe56>
    2500:	00003097          	auipc	ra,0x3
    2504:	64a080e7          	jalr	1610(ra) # 5b4a <printf>
    exit(1);
    2508:	4505                	li	a0,1
    250a:	00003097          	auipc	ra,0x3
    250e:	2c6080e7          	jalr	710(ra) # 57d0 <exit>
    printf("sbrk(rwsbrk) failed\n");
    2512:	00004517          	auipc	a0,0x4
    2516:	4ee50513          	addi	a0,a0,1262 # 6a00 <malloc+0xdfe>
    251a:	00003097          	auipc	ra,0x3
    251e:	630080e7          	jalr	1584(ra) # 5b4a <printf>
    exit(1);
    2522:	4505                	li	a0,1
    2524:	00003097          	auipc	ra,0x3
    2528:	2ac080e7          	jalr	684(ra) # 57d0 <exit>
    printf("sbrk(rwsbrk) shrink failed\n");
    252c:	00004517          	auipc	a0,0x4
    2530:	4ec50513          	addi	a0,a0,1260 # 6a18 <malloc+0xe16>
    2534:	00003097          	auipc	ra,0x3
    2538:	616080e7          	jalr	1558(ra) # 5b4a <printf>
    exit(1);
    253c:	4505                	li	a0,1
    253e:	00003097          	auipc	ra,0x3
    2542:	292080e7          	jalr	658(ra) # 57d0 <exit>
    printf("open(rwsbrk) failed\n");
    2546:	00004517          	auipc	a0,0x4
    254a:	4fa50513          	addi	a0,a0,1274 # 6a40 <malloc+0xe3e>
    254e:	00003097          	auipc	ra,0x3
    2552:	5fc080e7          	jalr	1532(ra) # 5b4a <printf>
    exit(1);
    2556:	4505                	li	a0,1
    2558:	00003097          	auipc	ra,0x3
    255c:	278080e7          	jalr	632(ra) # 57d0 <exit>
  close(fd);
    2560:	854a                	mv	a0,s2
    2562:	00003097          	auipc	ra,0x3
    2566:	296080e7          	jalr	662(ra) # 57f8 <close>
  unlink("rwsbrk");
    256a:	00004517          	auipc	a0,0x4
    256e:	4ce50513          	addi	a0,a0,1230 # 6a38 <malloc+0xe36>
    2572:	00003097          	auipc	ra,0x3
    2576:	2ae080e7          	jalr	686(ra) # 5820 <unlink>
  fd = open("README", O_RDONLY);
    257a:	4581                	li	a1,0
    257c:	00004517          	auipc	a0,0x4
    2580:	96c50513          	addi	a0,a0,-1684 # 5ee8 <malloc+0x2e6>
    2584:	00003097          	auipc	ra,0x3
    2588:	28c080e7          	jalr	652(ra) # 5810 <open>
    258c:	892a                	mv	s2,a0
  if(fd < 0){
    258e:	02054963          	bltz	a0,25c0 <rwsbrk+0x12a>
  n = read(fd, (void*)(a+4096), 10);
    2592:	4629                	li	a2,10
    2594:	85a6                	mv	a1,s1
    2596:	00003097          	auipc	ra,0x3
    259a:	252080e7          	jalr	594(ra) # 57e8 <read>
    259e:	862a                	mv	a2,a0
  if(n >= 0){
    25a0:	02054d63          	bltz	a0,25da <rwsbrk+0x144>
    printf("read(fd, %p, 10) returned %d, not -1\n", a+4096, n);
    25a4:	85a6                	mv	a1,s1
    25a6:	00004517          	auipc	a0,0x4
    25aa:	4e250513          	addi	a0,a0,1250 # 6a88 <malloc+0xe86>
    25ae:	00003097          	auipc	ra,0x3
    25b2:	59c080e7          	jalr	1436(ra) # 5b4a <printf>
    exit(1);
    25b6:	4505                	li	a0,1
    25b8:	00003097          	auipc	ra,0x3
    25bc:	218080e7          	jalr	536(ra) # 57d0 <exit>
    printf("open(rwsbrk) failed\n");
    25c0:	00004517          	auipc	a0,0x4
    25c4:	48050513          	addi	a0,a0,1152 # 6a40 <malloc+0xe3e>
    25c8:	00003097          	auipc	ra,0x3
    25cc:	582080e7          	jalr	1410(ra) # 5b4a <printf>
    exit(1);
    25d0:	4505                	li	a0,1
    25d2:	00003097          	auipc	ra,0x3
    25d6:	1fe080e7          	jalr	510(ra) # 57d0 <exit>
  close(fd);
    25da:	854a                	mv	a0,s2
    25dc:	00003097          	auipc	ra,0x3
    25e0:	21c080e7          	jalr	540(ra) # 57f8 <close>
  exit(0);
    25e4:	4501                	li	a0,0
    25e6:	00003097          	auipc	ra,0x3
    25ea:	1ea080e7          	jalr	490(ra) # 57d0 <exit>

00000000000025ee <sbrkbasic>:
{
    25ee:	7139                	addi	sp,sp,-64
    25f0:	fc06                	sd	ra,56(sp)
    25f2:	f822                	sd	s0,48(sp)
    25f4:	f426                	sd	s1,40(sp)
    25f6:	f04a                	sd	s2,32(sp)
    25f8:	ec4e                	sd	s3,24(sp)
    25fa:	e852                	sd	s4,16(sp)
    25fc:	0080                	addi	s0,sp,64
    25fe:	8a2a                	mv	s4,a0
  pid = fork();
    2600:	00003097          	auipc	ra,0x3
    2604:	1c8080e7          	jalr	456(ra) # 57c8 <fork>
  if(pid < 0){
    2608:	02054c63          	bltz	a0,2640 <sbrkbasic+0x52>
  if(pid == 0){
    260c:	ed21                	bnez	a0,2664 <sbrkbasic+0x76>
    a = sbrk(TOOMUCH);
    260e:	40000537          	lui	a0,0x40000
    2612:	00003097          	auipc	ra,0x3
    2616:	246080e7          	jalr	582(ra) # 5858 <sbrk>
    if(a == (char*)0xffffffffffffffffL){
    261a:	57fd                	li	a5,-1
    261c:	02f50f63          	beq	a0,a5,265a <sbrkbasic+0x6c>
    for(b = a; b < a+TOOMUCH; b += 4096){
    2620:	400007b7          	lui	a5,0x40000
    2624:	97aa                	add	a5,a5,a0
      *b = 99;
    2626:	06300693          	li	a3,99
    for(b = a; b < a+TOOMUCH; b += 4096){
    262a:	6705                	lui	a4,0x1
      *b = 99;
    262c:	00d50023          	sb	a3,0(a0) # 40000000 <__BSS_END__+0x3fff1278>
    for(b = a; b < a+TOOMUCH; b += 4096){
    2630:	953a                	add	a0,a0,a4
    2632:	fef51de3          	bne	a0,a5,262c <sbrkbasic+0x3e>
    exit(1);
    2636:	4505                	li	a0,1
    2638:	00003097          	auipc	ra,0x3
    263c:	198080e7          	jalr	408(ra) # 57d0 <exit>
    printf("fork failed in sbrkbasic\n");
    2640:	00004517          	auipc	a0,0x4
    2644:	47050513          	addi	a0,a0,1136 # 6ab0 <malloc+0xeae>
    2648:	00003097          	auipc	ra,0x3
    264c:	502080e7          	jalr	1282(ra) # 5b4a <printf>
    exit(1);
    2650:	4505                	li	a0,1
    2652:	00003097          	auipc	ra,0x3
    2656:	17e080e7          	jalr	382(ra) # 57d0 <exit>
      exit(0);
    265a:	4501                	li	a0,0
    265c:	00003097          	auipc	ra,0x3
    2660:	174080e7          	jalr	372(ra) # 57d0 <exit>
  wait(&xstatus);
    2664:	fcc40513          	addi	a0,s0,-52
    2668:	00003097          	auipc	ra,0x3
    266c:	170080e7          	jalr	368(ra) # 57d8 <wait>
  if(xstatus == 1){
    2670:	fcc42703          	lw	a4,-52(s0)
    2674:	4785                	li	a5,1
    2676:	00f70d63          	beq	a4,a5,2690 <sbrkbasic+0xa2>
  a = sbrk(0);
    267a:	4501                	li	a0,0
    267c:	00003097          	auipc	ra,0x3
    2680:	1dc080e7          	jalr	476(ra) # 5858 <sbrk>
    2684:	84aa                	mv	s1,a0
  for(i = 0; i < 5000; i++){
    2686:	4901                	li	s2,0
    2688:	6985                	lui	s3,0x1
    268a:	38898993          	addi	s3,s3,904 # 1388 <mycopyinstr2+0x100>
    268e:	a005                	j	26ae <sbrkbasic+0xc0>
    printf("%s: too much memory allocated!\n", s);
    2690:	85d2                	mv	a1,s4
    2692:	00004517          	auipc	a0,0x4
    2696:	43e50513          	addi	a0,a0,1086 # 6ad0 <malloc+0xece>
    269a:	00003097          	auipc	ra,0x3
    269e:	4b0080e7          	jalr	1200(ra) # 5b4a <printf>
    exit(1);
    26a2:	4505                	li	a0,1
    26a4:	00003097          	auipc	ra,0x3
    26a8:	12c080e7          	jalr	300(ra) # 57d0 <exit>
    a = b + 1;
    26ac:	84be                	mv	s1,a5
    b = sbrk(1);
    26ae:	4505                	li	a0,1
    26b0:	00003097          	auipc	ra,0x3
    26b4:	1a8080e7          	jalr	424(ra) # 5858 <sbrk>
    if(b != a){
    26b8:	04951c63          	bne	a0,s1,2710 <sbrkbasic+0x122>
    *b = 1;
    26bc:	4785                	li	a5,1
    26be:	00f48023          	sb	a5,0(s1)
    a = b + 1;
    26c2:	00148793          	addi	a5,s1,1
  for(i = 0; i < 5000; i++){
    26c6:	2905                	addiw	s2,s2,1
    26c8:	ff3912e3          	bne	s2,s3,26ac <sbrkbasic+0xbe>
  pid = fork();
    26cc:	00003097          	auipc	ra,0x3
    26d0:	0fc080e7          	jalr	252(ra) # 57c8 <fork>
    26d4:	892a                	mv	s2,a0
  if(pid < 0){
    26d6:	04054e63          	bltz	a0,2732 <sbrkbasic+0x144>
  c = sbrk(1);
    26da:	4505                	li	a0,1
    26dc:	00003097          	auipc	ra,0x3
    26e0:	17c080e7          	jalr	380(ra) # 5858 <sbrk>
  c = sbrk(1);
    26e4:	4505                	li	a0,1
    26e6:	00003097          	auipc	ra,0x3
    26ea:	172080e7          	jalr	370(ra) # 5858 <sbrk>
  if(c != a + 1){
    26ee:	0489                	addi	s1,s1,2
    26f0:	04a48f63          	beq	s1,a0,274e <sbrkbasic+0x160>
    printf("%s: sbrk test failed post-fork\n", s);
    26f4:	85d2                	mv	a1,s4
    26f6:	00004517          	auipc	a0,0x4
    26fa:	43a50513          	addi	a0,a0,1082 # 6b30 <malloc+0xf2e>
    26fe:	00003097          	auipc	ra,0x3
    2702:	44c080e7          	jalr	1100(ra) # 5b4a <printf>
    exit(1);
    2706:	4505                	li	a0,1
    2708:	00003097          	auipc	ra,0x3
    270c:	0c8080e7          	jalr	200(ra) # 57d0 <exit>
      printf("%s: sbrk test failed %d %x %x\n", s, i, a, b);
    2710:	872a                	mv	a4,a0
    2712:	86a6                	mv	a3,s1
    2714:	864a                	mv	a2,s2
    2716:	85d2                	mv	a1,s4
    2718:	00004517          	auipc	a0,0x4
    271c:	3d850513          	addi	a0,a0,984 # 6af0 <malloc+0xeee>
    2720:	00003097          	auipc	ra,0x3
    2724:	42a080e7          	jalr	1066(ra) # 5b4a <printf>
      exit(1);
    2728:	4505                	li	a0,1
    272a:	00003097          	auipc	ra,0x3
    272e:	0a6080e7          	jalr	166(ra) # 57d0 <exit>
    printf("%s: sbrk test fork failed\n", s);
    2732:	85d2                	mv	a1,s4
    2734:	00004517          	auipc	a0,0x4
    2738:	3dc50513          	addi	a0,a0,988 # 6b10 <malloc+0xf0e>
    273c:	00003097          	auipc	ra,0x3
    2740:	40e080e7          	jalr	1038(ra) # 5b4a <printf>
    exit(1);
    2744:	4505                	li	a0,1
    2746:	00003097          	auipc	ra,0x3
    274a:	08a080e7          	jalr	138(ra) # 57d0 <exit>
  if(pid == 0)
    274e:	00091763          	bnez	s2,275c <sbrkbasic+0x16e>
    exit(0);
    2752:	4501                	li	a0,0
    2754:	00003097          	auipc	ra,0x3
    2758:	07c080e7          	jalr	124(ra) # 57d0 <exit>
  wait(&xstatus);
    275c:	fcc40513          	addi	a0,s0,-52
    2760:	00003097          	auipc	ra,0x3
    2764:	078080e7          	jalr	120(ra) # 57d8 <wait>
  exit(xstatus);
    2768:	fcc42503          	lw	a0,-52(s0)
    276c:	00003097          	auipc	ra,0x3
    2770:	064080e7          	jalr	100(ra) # 57d0 <exit>

0000000000002774 <sbrkmuch>:
{
    2774:	7179                	addi	sp,sp,-48
    2776:	f406                	sd	ra,40(sp)
    2778:	f022                	sd	s0,32(sp)
    277a:	ec26                	sd	s1,24(sp)
    277c:	e84a                	sd	s2,16(sp)
    277e:	e44e                	sd	s3,8(sp)
    2780:	e052                	sd	s4,0(sp)
    2782:	1800                	addi	s0,sp,48
    2784:	89aa                	mv	s3,a0
  oldbrk = sbrk(0);
    2786:	4501                	li	a0,0
    2788:	00003097          	auipc	ra,0x3
    278c:	0d0080e7          	jalr	208(ra) # 5858 <sbrk>
    2790:	892a                	mv	s2,a0
  a = sbrk(0);
    2792:	4501                	li	a0,0
    2794:	00003097          	auipc	ra,0x3
    2798:	0c4080e7          	jalr	196(ra) # 5858 <sbrk>
    279c:	84aa                	mv	s1,a0
  p = sbrk(amt);
    279e:	06400537          	lui	a0,0x6400
    27a2:	9d05                	subw	a0,a0,s1
    27a4:	00003097          	auipc	ra,0x3
    27a8:	0b4080e7          	jalr	180(ra) # 5858 <sbrk>
  if (p != a) {
    27ac:	0ca49863          	bne	s1,a0,287c <sbrkmuch+0x108>
  char *eee = sbrk(0);
    27b0:	4501                	li	a0,0
    27b2:	00003097          	auipc	ra,0x3
    27b6:	0a6080e7          	jalr	166(ra) # 5858 <sbrk>
    27ba:	87aa                	mv	a5,a0
  for(char *pp = a; pp < eee; pp += 4096)
    27bc:	00a4f963          	bgeu	s1,a0,27ce <sbrkmuch+0x5a>
    *pp = 1;
    27c0:	4685                	li	a3,1
  for(char *pp = a; pp < eee; pp += 4096)
    27c2:	6705                	lui	a4,0x1
    *pp = 1;
    27c4:	00d48023          	sb	a3,0(s1)
  for(char *pp = a; pp < eee; pp += 4096)
    27c8:	94ba                	add	s1,s1,a4
    27ca:	fef4ede3          	bltu	s1,a5,27c4 <sbrkmuch+0x50>
  *lastaddr = 99;
    27ce:	064007b7          	lui	a5,0x6400
    27d2:	06300713          	li	a4,99
    27d6:	fee78fa3          	sb	a4,-1(a5) # 63fffff <__BSS_END__+0x63f1277>
  a = sbrk(0);
    27da:	4501                	li	a0,0
    27dc:	00003097          	auipc	ra,0x3
    27e0:	07c080e7          	jalr	124(ra) # 5858 <sbrk>
    27e4:	84aa                	mv	s1,a0
  c = sbrk(-PGSIZE);
    27e6:	757d                	lui	a0,0xfffff
    27e8:	00003097          	auipc	ra,0x3
    27ec:	070080e7          	jalr	112(ra) # 5858 <sbrk>
  if(c == (char*)0xffffffffffffffffL){
    27f0:	57fd                	li	a5,-1
    27f2:	0af50363          	beq	a0,a5,2898 <sbrkmuch+0x124>
  c = sbrk(0);
    27f6:	4501                	li	a0,0
    27f8:	00003097          	auipc	ra,0x3
    27fc:	060080e7          	jalr	96(ra) # 5858 <sbrk>
  if(c != a - PGSIZE){
    2800:	77fd                	lui	a5,0xfffff
    2802:	97a6                	add	a5,a5,s1
    2804:	0af51863          	bne	a0,a5,28b4 <sbrkmuch+0x140>
  a = sbrk(0);
    2808:	4501                	li	a0,0
    280a:	00003097          	auipc	ra,0x3
    280e:	04e080e7          	jalr	78(ra) # 5858 <sbrk>
    2812:	84aa                	mv	s1,a0
  c = sbrk(PGSIZE);
    2814:	6505                	lui	a0,0x1
    2816:	00003097          	auipc	ra,0x3
    281a:	042080e7          	jalr	66(ra) # 5858 <sbrk>
    281e:	8a2a                	mv	s4,a0
  if(c != a || sbrk(0) != a + PGSIZE){
    2820:	0aa49a63          	bne	s1,a0,28d4 <sbrkmuch+0x160>
    2824:	4501                	li	a0,0
    2826:	00003097          	auipc	ra,0x3
    282a:	032080e7          	jalr	50(ra) # 5858 <sbrk>
    282e:	6785                	lui	a5,0x1
    2830:	97a6                	add	a5,a5,s1
    2832:	0af51163          	bne	a0,a5,28d4 <sbrkmuch+0x160>
  if(*lastaddr == 99){
    2836:	064007b7          	lui	a5,0x6400
    283a:	fff7c703          	lbu	a4,-1(a5) # 63fffff <__BSS_END__+0x63f1277>
    283e:	06300793          	li	a5,99
    2842:	0af70963          	beq	a4,a5,28f4 <sbrkmuch+0x180>
  a = sbrk(0);
    2846:	4501                	li	a0,0
    2848:	00003097          	auipc	ra,0x3
    284c:	010080e7          	jalr	16(ra) # 5858 <sbrk>
    2850:	84aa                	mv	s1,a0
  c = sbrk(-(sbrk(0) - oldbrk));
    2852:	4501                	li	a0,0
    2854:	00003097          	auipc	ra,0x3
    2858:	004080e7          	jalr	4(ra) # 5858 <sbrk>
    285c:	40a9053b          	subw	a0,s2,a0
    2860:	00003097          	auipc	ra,0x3
    2864:	ff8080e7          	jalr	-8(ra) # 5858 <sbrk>
  if(c != a){
    2868:	0aa49463          	bne	s1,a0,2910 <sbrkmuch+0x19c>
}
    286c:	70a2                	ld	ra,40(sp)
    286e:	7402                	ld	s0,32(sp)
    2870:	64e2                	ld	s1,24(sp)
    2872:	6942                	ld	s2,16(sp)
    2874:	69a2                	ld	s3,8(sp)
    2876:	6a02                	ld	s4,0(sp)
    2878:	6145                	addi	sp,sp,48
    287a:	8082                	ret
    printf("%s: sbrk test failed to grow big address space; enough phys mem?\n", s);
    287c:	85ce                	mv	a1,s3
    287e:	00004517          	auipc	a0,0x4
    2882:	2d250513          	addi	a0,a0,722 # 6b50 <malloc+0xf4e>
    2886:	00003097          	auipc	ra,0x3
    288a:	2c4080e7          	jalr	708(ra) # 5b4a <printf>
    exit(1);
    288e:	4505                	li	a0,1
    2890:	00003097          	auipc	ra,0x3
    2894:	f40080e7          	jalr	-192(ra) # 57d0 <exit>
    printf("%s: sbrk could not deallocate\n", s);
    2898:	85ce                	mv	a1,s3
    289a:	00004517          	auipc	a0,0x4
    289e:	2fe50513          	addi	a0,a0,766 # 6b98 <malloc+0xf96>
    28a2:	00003097          	auipc	ra,0x3
    28a6:	2a8080e7          	jalr	680(ra) # 5b4a <printf>
    exit(1);
    28aa:	4505                	li	a0,1
    28ac:	00003097          	auipc	ra,0x3
    28b0:	f24080e7          	jalr	-220(ra) # 57d0 <exit>
    printf("%s: sbrk deallocation produced wrong address, a %x c %x\n", s, a, c);
    28b4:	86aa                	mv	a3,a0
    28b6:	8626                	mv	a2,s1
    28b8:	85ce                	mv	a1,s3
    28ba:	00004517          	auipc	a0,0x4
    28be:	2fe50513          	addi	a0,a0,766 # 6bb8 <malloc+0xfb6>
    28c2:	00003097          	auipc	ra,0x3
    28c6:	288080e7          	jalr	648(ra) # 5b4a <printf>
    exit(1);
    28ca:	4505                	li	a0,1
    28cc:	00003097          	auipc	ra,0x3
    28d0:	f04080e7          	jalr	-252(ra) # 57d0 <exit>
    printf("%s: sbrk re-allocation failed, a %x c %x\n", s, a, c);
    28d4:	86d2                	mv	a3,s4
    28d6:	8626                	mv	a2,s1
    28d8:	85ce                	mv	a1,s3
    28da:	00004517          	auipc	a0,0x4
    28de:	31e50513          	addi	a0,a0,798 # 6bf8 <malloc+0xff6>
    28e2:	00003097          	auipc	ra,0x3
    28e6:	268080e7          	jalr	616(ra) # 5b4a <printf>
    exit(1);
    28ea:	4505                	li	a0,1
    28ec:	00003097          	auipc	ra,0x3
    28f0:	ee4080e7          	jalr	-284(ra) # 57d0 <exit>
    printf("%s: sbrk de-allocation didn't really deallocate\n", s);
    28f4:	85ce                	mv	a1,s3
    28f6:	00004517          	auipc	a0,0x4
    28fa:	33250513          	addi	a0,a0,818 # 6c28 <malloc+0x1026>
    28fe:	00003097          	auipc	ra,0x3
    2902:	24c080e7          	jalr	588(ra) # 5b4a <printf>
    exit(1);
    2906:	4505                	li	a0,1
    2908:	00003097          	auipc	ra,0x3
    290c:	ec8080e7          	jalr	-312(ra) # 57d0 <exit>
    printf("%s: sbrk downsize failed, a %x c %x\n", s, a, c);
    2910:	86aa                	mv	a3,a0
    2912:	8626                	mv	a2,s1
    2914:	85ce                	mv	a1,s3
    2916:	00004517          	auipc	a0,0x4
    291a:	34a50513          	addi	a0,a0,842 # 6c60 <malloc+0x105e>
    291e:	00003097          	auipc	ra,0x3
    2922:	22c080e7          	jalr	556(ra) # 5b4a <printf>
    exit(1);
    2926:	4505                	li	a0,1
    2928:	00003097          	auipc	ra,0x3
    292c:	ea8080e7          	jalr	-344(ra) # 57d0 <exit>

0000000000002930 <sbrkarg>:
{
    2930:	7179                	addi	sp,sp,-48
    2932:	f406                	sd	ra,40(sp)
    2934:	f022                	sd	s0,32(sp)
    2936:	ec26                	sd	s1,24(sp)
    2938:	e84a                	sd	s2,16(sp)
    293a:	e44e                	sd	s3,8(sp)
    293c:	1800                	addi	s0,sp,48
    293e:	89aa                	mv	s3,a0
  a = sbrk(PGSIZE);
    2940:	6505                	lui	a0,0x1
    2942:	00003097          	auipc	ra,0x3
    2946:	f16080e7          	jalr	-234(ra) # 5858 <sbrk>
    294a:	892a                	mv	s2,a0
  fd = open("sbrk", O_CREATE|O_WRONLY);
    294c:	20100593          	li	a1,513
    2950:	00004517          	auipc	a0,0x4
    2954:	33850513          	addi	a0,a0,824 # 6c88 <malloc+0x1086>
    2958:	00003097          	auipc	ra,0x3
    295c:	eb8080e7          	jalr	-328(ra) # 5810 <open>
    2960:	84aa                	mv	s1,a0
  unlink("sbrk");
    2962:	00004517          	auipc	a0,0x4
    2966:	32650513          	addi	a0,a0,806 # 6c88 <malloc+0x1086>
    296a:	00003097          	auipc	ra,0x3
    296e:	eb6080e7          	jalr	-330(ra) # 5820 <unlink>
  if(fd < 0)  {
    2972:	0404c163          	bltz	s1,29b4 <sbrkarg+0x84>
  if ((n = write(fd, a, PGSIZE)) < 0) {
    2976:	6605                	lui	a2,0x1
    2978:	85ca                	mv	a1,s2
    297a:	8526                	mv	a0,s1
    297c:	00003097          	auipc	ra,0x3
    2980:	e74080e7          	jalr	-396(ra) # 57f0 <write>
    2984:	04054663          	bltz	a0,29d0 <sbrkarg+0xa0>
  close(fd);
    2988:	8526                	mv	a0,s1
    298a:	00003097          	auipc	ra,0x3
    298e:	e6e080e7          	jalr	-402(ra) # 57f8 <close>
  a = sbrk(PGSIZE);
    2992:	6505                	lui	a0,0x1
    2994:	00003097          	auipc	ra,0x3
    2998:	ec4080e7          	jalr	-316(ra) # 5858 <sbrk>
  if(pipe((int *) a) != 0){
    299c:	00003097          	auipc	ra,0x3
    29a0:	e44080e7          	jalr	-444(ra) # 57e0 <pipe>
    29a4:	e521                	bnez	a0,29ec <sbrkarg+0xbc>
}
    29a6:	70a2                	ld	ra,40(sp)
    29a8:	7402                	ld	s0,32(sp)
    29aa:	64e2                	ld	s1,24(sp)
    29ac:	6942                	ld	s2,16(sp)
    29ae:	69a2                	ld	s3,8(sp)
    29b0:	6145                	addi	sp,sp,48
    29b2:	8082                	ret
    printf("%s: open sbrk failed\n", s);
    29b4:	85ce                	mv	a1,s3
    29b6:	00004517          	auipc	a0,0x4
    29ba:	2da50513          	addi	a0,a0,730 # 6c90 <malloc+0x108e>
    29be:	00003097          	auipc	ra,0x3
    29c2:	18c080e7          	jalr	396(ra) # 5b4a <printf>
    exit(1);
    29c6:	4505                	li	a0,1
    29c8:	00003097          	auipc	ra,0x3
    29cc:	e08080e7          	jalr	-504(ra) # 57d0 <exit>
    printf("%s: write sbrk failed\n", s);
    29d0:	85ce                	mv	a1,s3
    29d2:	00004517          	auipc	a0,0x4
    29d6:	2d650513          	addi	a0,a0,726 # 6ca8 <malloc+0x10a6>
    29da:	00003097          	auipc	ra,0x3
    29de:	170080e7          	jalr	368(ra) # 5b4a <printf>
    exit(1);
    29e2:	4505                	li	a0,1
    29e4:	00003097          	auipc	ra,0x3
    29e8:	dec080e7          	jalr	-532(ra) # 57d0 <exit>
    printf("%s: pipe() failed\n", s);
    29ec:	85ce                	mv	a1,s3
    29ee:	00004517          	auipc	a0,0x4
    29f2:	cb250513          	addi	a0,a0,-846 # 66a0 <malloc+0xa9e>
    29f6:	00003097          	auipc	ra,0x3
    29fa:	154080e7          	jalr	340(ra) # 5b4a <printf>
    exit(1);
    29fe:	4505                	li	a0,1
    2a00:	00003097          	auipc	ra,0x3
    2a04:	dd0080e7          	jalr	-560(ra) # 57d0 <exit>

0000000000002a08 <argptest>:
{
    2a08:	1101                	addi	sp,sp,-32
    2a0a:	ec06                	sd	ra,24(sp)
    2a0c:	e822                	sd	s0,16(sp)
    2a0e:	e426                	sd	s1,8(sp)
    2a10:	e04a                	sd	s2,0(sp)
    2a12:	1000                	addi	s0,sp,32
    2a14:	892a                	mv	s2,a0
  fd = open("init", O_RDONLY);
    2a16:	4581                	li	a1,0
    2a18:	00004517          	auipc	a0,0x4
    2a1c:	2a850513          	addi	a0,a0,680 # 6cc0 <malloc+0x10be>
    2a20:	00003097          	auipc	ra,0x3
    2a24:	df0080e7          	jalr	-528(ra) # 5810 <open>
  if (fd < 0) {
    2a28:	02054b63          	bltz	a0,2a5e <argptest+0x56>
    2a2c:	84aa                	mv	s1,a0
  read(fd, sbrk(0) - 1, -1);
    2a2e:	4501                	li	a0,0
    2a30:	00003097          	auipc	ra,0x3
    2a34:	e28080e7          	jalr	-472(ra) # 5858 <sbrk>
    2a38:	567d                	li	a2,-1
    2a3a:	fff50593          	addi	a1,a0,-1
    2a3e:	8526                	mv	a0,s1
    2a40:	00003097          	auipc	ra,0x3
    2a44:	da8080e7          	jalr	-600(ra) # 57e8 <read>
  close(fd);
    2a48:	8526                	mv	a0,s1
    2a4a:	00003097          	auipc	ra,0x3
    2a4e:	dae080e7          	jalr	-594(ra) # 57f8 <close>
}
    2a52:	60e2                	ld	ra,24(sp)
    2a54:	6442                	ld	s0,16(sp)
    2a56:	64a2                	ld	s1,8(sp)
    2a58:	6902                	ld	s2,0(sp)
    2a5a:	6105                	addi	sp,sp,32
    2a5c:	8082                	ret
    printf("%s: open failed\n", s);
    2a5e:	85ca                	mv	a1,s2
    2a60:	00004517          	auipc	a0,0x4
    2a64:	b5050513          	addi	a0,a0,-1200 # 65b0 <malloc+0x9ae>
    2a68:	00003097          	auipc	ra,0x3
    2a6c:	0e2080e7          	jalr	226(ra) # 5b4a <printf>
    exit(1);
    2a70:	4505                	li	a0,1
    2a72:	00003097          	auipc	ra,0x3
    2a76:	d5e080e7          	jalr	-674(ra) # 57d0 <exit>

0000000000002a7a <sbrkbugs>:
{
    2a7a:	1141                	addi	sp,sp,-16
    2a7c:	e406                	sd	ra,8(sp)
    2a7e:	e022                	sd	s0,0(sp)
    2a80:	0800                	addi	s0,sp,16
  int pid = fork();
    2a82:	00003097          	auipc	ra,0x3
    2a86:	d46080e7          	jalr	-698(ra) # 57c8 <fork>
  if(pid < 0){
    2a8a:	02054263          	bltz	a0,2aae <sbrkbugs+0x34>
  if(pid == 0){
    2a8e:	ed0d                	bnez	a0,2ac8 <sbrkbugs+0x4e>
    int sz = (uint64) sbrk(0);
    2a90:	00003097          	auipc	ra,0x3
    2a94:	dc8080e7          	jalr	-568(ra) # 5858 <sbrk>
    sbrk(-sz);
    2a98:	40a0053b          	negw	a0,a0
    2a9c:	00003097          	auipc	ra,0x3
    2aa0:	dbc080e7          	jalr	-580(ra) # 5858 <sbrk>
    exit(0);
    2aa4:	4501                	li	a0,0
    2aa6:	00003097          	auipc	ra,0x3
    2aaa:	d2a080e7          	jalr	-726(ra) # 57d0 <exit>
    printf("fork failed\n");
    2aae:	00004517          	auipc	a0,0x4
    2ab2:	ef250513          	addi	a0,a0,-270 # 69a0 <malloc+0xd9e>
    2ab6:	00003097          	auipc	ra,0x3
    2aba:	094080e7          	jalr	148(ra) # 5b4a <printf>
    exit(1);
    2abe:	4505                	li	a0,1
    2ac0:	00003097          	auipc	ra,0x3
    2ac4:	d10080e7          	jalr	-752(ra) # 57d0 <exit>
  wait(0);
    2ac8:	4501                	li	a0,0
    2aca:	00003097          	auipc	ra,0x3
    2ace:	d0e080e7          	jalr	-754(ra) # 57d8 <wait>
  pid = fork();
    2ad2:	00003097          	auipc	ra,0x3
    2ad6:	cf6080e7          	jalr	-778(ra) # 57c8 <fork>
  if(pid < 0){
    2ada:	02054563          	bltz	a0,2b04 <sbrkbugs+0x8a>
  if(pid == 0){
    2ade:	e121                	bnez	a0,2b1e <sbrkbugs+0xa4>
    int sz = (uint64) sbrk(0);
    2ae0:	00003097          	auipc	ra,0x3
    2ae4:	d78080e7          	jalr	-648(ra) # 5858 <sbrk>
    sbrk(-(sz - 3500));
    2ae8:	6785                	lui	a5,0x1
    2aea:	dac7879b          	addiw	a5,a5,-596
    2aee:	40a7853b          	subw	a0,a5,a0
    2af2:	00003097          	auipc	ra,0x3
    2af6:	d66080e7          	jalr	-666(ra) # 5858 <sbrk>
    exit(0);
    2afa:	4501                	li	a0,0
    2afc:	00003097          	auipc	ra,0x3
    2b00:	cd4080e7          	jalr	-812(ra) # 57d0 <exit>
    printf("fork failed\n");
    2b04:	00004517          	auipc	a0,0x4
    2b08:	e9c50513          	addi	a0,a0,-356 # 69a0 <malloc+0xd9e>
    2b0c:	00003097          	auipc	ra,0x3
    2b10:	03e080e7          	jalr	62(ra) # 5b4a <printf>
    exit(1);
    2b14:	4505                	li	a0,1
    2b16:	00003097          	auipc	ra,0x3
    2b1a:	cba080e7          	jalr	-838(ra) # 57d0 <exit>
  wait(0);
    2b1e:	4501                	li	a0,0
    2b20:	00003097          	auipc	ra,0x3
    2b24:	cb8080e7          	jalr	-840(ra) # 57d8 <wait>
  pid = fork();
    2b28:	00003097          	auipc	ra,0x3
    2b2c:	ca0080e7          	jalr	-864(ra) # 57c8 <fork>
  if(pid < 0){
    2b30:	02054a63          	bltz	a0,2b64 <sbrkbugs+0xea>
  if(pid == 0){
    2b34:	e529                	bnez	a0,2b7e <sbrkbugs+0x104>
    sbrk((10*4096 + 2048) - (uint64)sbrk(0));
    2b36:	00003097          	auipc	ra,0x3
    2b3a:	d22080e7          	jalr	-734(ra) # 5858 <sbrk>
    2b3e:	67ad                	lui	a5,0xb
    2b40:	8007879b          	addiw	a5,a5,-2048
    2b44:	40a7853b          	subw	a0,a5,a0
    2b48:	00003097          	auipc	ra,0x3
    2b4c:	d10080e7          	jalr	-752(ra) # 5858 <sbrk>
    sbrk(-10);
    2b50:	5559                	li	a0,-10
    2b52:	00003097          	auipc	ra,0x3
    2b56:	d06080e7          	jalr	-762(ra) # 5858 <sbrk>
    exit(0);
    2b5a:	4501                	li	a0,0
    2b5c:	00003097          	auipc	ra,0x3
    2b60:	c74080e7          	jalr	-908(ra) # 57d0 <exit>
    printf("fork failed\n");
    2b64:	00004517          	auipc	a0,0x4
    2b68:	e3c50513          	addi	a0,a0,-452 # 69a0 <malloc+0xd9e>
    2b6c:	00003097          	auipc	ra,0x3
    2b70:	fde080e7          	jalr	-34(ra) # 5b4a <printf>
    exit(1);
    2b74:	4505                	li	a0,1
    2b76:	00003097          	auipc	ra,0x3
    2b7a:	c5a080e7          	jalr	-934(ra) # 57d0 <exit>
  wait(0);
    2b7e:	4501                	li	a0,0
    2b80:	00003097          	auipc	ra,0x3
    2b84:	c58080e7          	jalr	-936(ra) # 57d8 <wait>
  exit(0);
    2b88:	4501                	li	a0,0
    2b8a:	00003097          	auipc	ra,0x3
    2b8e:	c46080e7          	jalr	-954(ra) # 57d0 <exit>

0000000000002b92 <sbrklast>:
{
    2b92:	7179                	addi	sp,sp,-48
    2b94:	f406                	sd	ra,40(sp)
    2b96:	f022                	sd	s0,32(sp)
    2b98:	ec26                	sd	s1,24(sp)
    2b9a:	e84a                	sd	s2,16(sp)
    2b9c:	e44e                	sd	s3,8(sp)
    2b9e:	e052                	sd	s4,0(sp)
    2ba0:	1800                	addi	s0,sp,48
  uint64 top = (uint64) sbrk(0);
    2ba2:	4501                	li	a0,0
    2ba4:	00003097          	auipc	ra,0x3
    2ba8:	cb4080e7          	jalr	-844(ra) # 5858 <sbrk>
  if((top % 4096) != 0)
    2bac:	03451793          	slli	a5,a0,0x34
    2bb0:	ebd9                	bnez	a5,2c46 <sbrklast+0xb4>
  sbrk(4096);
    2bb2:	6505                	lui	a0,0x1
    2bb4:	00003097          	auipc	ra,0x3
    2bb8:	ca4080e7          	jalr	-860(ra) # 5858 <sbrk>
  sbrk(10);
    2bbc:	4529                	li	a0,10
    2bbe:	00003097          	auipc	ra,0x3
    2bc2:	c9a080e7          	jalr	-870(ra) # 5858 <sbrk>
  sbrk(-20);
    2bc6:	5531                	li	a0,-20
    2bc8:	00003097          	auipc	ra,0x3
    2bcc:	c90080e7          	jalr	-880(ra) # 5858 <sbrk>
  top = (uint64) sbrk(0);
    2bd0:	4501                	li	a0,0
    2bd2:	00003097          	auipc	ra,0x3
    2bd6:	c86080e7          	jalr	-890(ra) # 5858 <sbrk>
    2bda:	84aa                	mv	s1,a0
  char *p = (char *) (top - 64);
    2bdc:	fc050913          	addi	s2,a0,-64 # fc0 <linktest+0x1d4>
  p[0] = 'x';
    2be0:	07800a13          	li	s4,120
    2be4:	fd450023          	sb	s4,-64(a0)
  p[1] = '\0';
    2be8:	fc0500a3          	sb	zero,-63(a0)
  int fd = open(p, O_RDWR|O_CREATE);
    2bec:	20200593          	li	a1,514
    2bf0:	854a                	mv	a0,s2
    2bf2:	00003097          	auipc	ra,0x3
    2bf6:	c1e080e7          	jalr	-994(ra) # 5810 <open>
    2bfa:	89aa                	mv	s3,a0
  write(fd, p, 1);
    2bfc:	4605                	li	a2,1
    2bfe:	85ca                	mv	a1,s2
    2c00:	00003097          	auipc	ra,0x3
    2c04:	bf0080e7          	jalr	-1040(ra) # 57f0 <write>
  close(fd);
    2c08:	854e                	mv	a0,s3
    2c0a:	00003097          	auipc	ra,0x3
    2c0e:	bee080e7          	jalr	-1042(ra) # 57f8 <close>
  fd = open(p, O_RDWR);
    2c12:	4589                	li	a1,2
    2c14:	854a                	mv	a0,s2
    2c16:	00003097          	auipc	ra,0x3
    2c1a:	bfa080e7          	jalr	-1030(ra) # 5810 <open>
  p[0] = '\0';
    2c1e:	fc048023          	sb	zero,-64(s1)
  read(fd, p, 1);
    2c22:	4605                	li	a2,1
    2c24:	85ca                	mv	a1,s2
    2c26:	00003097          	auipc	ra,0x3
    2c2a:	bc2080e7          	jalr	-1086(ra) # 57e8 <read>
  if(p[0] != 'x')
    2c2e:	fc04c783          	lbu	a5,-64(s1)
    2c32:	03479463          	bne	a5,s4,2c5a <sbrklast+0xc8>
}
    2c36:	70a2                	ld	ra,40(sp)
    2c38:	7402                	ld	s0,32(sp)
    2c3a:	64e2                	ld	s1,24(sp)
    2c3c:	6942                	ld	s2,16(sp)
    2c3e:	69a2                	ld	s3,8(sp)
    2c40:	6a02                	ld	s4,0(sp)
    2c42:	6145                	addi	sp,sp,48
    2c44:	8082                	ret
    sbrk(4096 - (top % 4096));
    2c46:	0347d513          	srli	a0,a5,0x34
    2c4a:	6785                	lui	a5,0x1
    2c4c:	40a7853b          	subw	a0,a5,a0
    2c50:	00003097          	auipc	ra,0x3
    2c54:	c08080e7          	jalr	-1016(ra) # 5858 <sbrk>
    2c58:	bfa9                	j	2bb2 <sbrklast+0x20>
    exit(1);
    2c5a:	4505                	li	a0,1
    2c5c:	00003097          	auipc	ra,0x3
    2c60:	b74080e7          	jalr	-1164(ra) # 57d0 <exit>

0000000000002c64 <sbrk8000>:
{
    2c64:	1141                	addi	sp,sp,-16
    2c66:	e406                	sd	ra,8(sp)
    2c68:	e022                	sd	s0,0(sp)
    2c6a:	0800                	addi	s0,sp,16
  sbrk(0x80000004);
    2c6c:	80000537          	lui	a0,0x80000
    2c70:	0511                	addi	a0,a0,4
    2c72:	00003097          	auipc	ra,0x3
    2c76:	be6080e7          	jalr	-1050(ra) # 5858 <sbrk>
  volatile char *top = sbrk(0);
    2c7a:	4501                	li	a0,0
    2c7c:	00003097          	auipc	ra,0x3
    2c80:	bdc080e7          	jalr	-1060(ra) # 5858 <sbrk>
  *(top-1) = *(top-1) + 1;
    2c84:	fff54783          	lbu	a5,-1(a0) # ffffffff7fffffff <__BSS_END__+0xffffffff7fff1277>
    2c88:	2785                	addiw	a5,a5,1
    2c8a:	0ff7f793          	zext.b	a5,a5
    2c8e:	fef50fa3          	sb	a5,-1(a0)
}
    2c92:	60a2                	ld	ra,8(sp)
    2c94:	6402                	ld	s0,0(sp)
    2c96:	0141                	addi	sp,sp,16
    2c98:	8082                	ret

0000000000002c9a <execout>:
// test the exec() code that cleans up if it runs out
// of memory. it's really a test that such a condition
// doesn't cause a panic.
void
execout(char *s)
{
    2c9a:	715d                	addi	sp,sp,-80
    2c9c:	e486                	sd	ra,72(sp)
    2c9e:	e0a2                	sd	s0,64(sp)
    2ca0:	fc26                	sd	s1,56(sp)
    2ca2:	f84a                	sd	s2,48(sp)
    2ca4:	f44e                	sd	s3,40(sp)
    2ca6:	f052                	sd	s4,32(sp)
    2ca8:	0880                	addi	s0,sp,80
  for(int avail = 0; avail < 15; avail++){
    2caa:	4901                	li	s2,0
    2cac:	49bd                	li	s3,15
    int pid = fork();
    2cae:	00003097          	auipc	ra,0x3
    2cb2:	b1a080e7          	jalr	-1254(ra) # 57c8 <fork>
    2cb6:	84aa                	mv	s1,a0
    if(pid < 0){
    2cb8:	02054063          	bltz	a0,2cd8 <execout+0x3e>
      printf("fork failed\n");
      exit(1);
    } else if(pid == 0){
    2cbc:	c91d                	beqz	a0,2cf2 <execout+0x58>
      close(1);
      char *args[] = { "echo", "x", 0 };
      exec("echo", args);
      exit(0);
    } else {
      wait((int*)0);
    2cbe:	4501                	li	a0,0
    2cc0:	00003097          	auipc	ra,0x3
    2cc4:	b18080e7          	jalr	-1256(ra) # 57d8 <wait>
  for(int avail = 0; avail < 15; avail++){
    2cc8:	2905                	addiw	s2,s2,1
    2cca:	ff3912e3          	bne	s2,s3,2cae <execout+0x14>
    }
  }

  exit(0);
    2cce:	4501                	li	a0,0
    2cd0:	00003097          	auipc	ra,0x3
    2cd4:	b00080e7          	jalr	-1280(ra) # 57d0 <exit>
      printf("fork failed\n");
    2cd8:	00004517          	auipc	a0,0x4
    2cdc:	cc850513          	addi	a0,a0,-824 # 69a0 <malloc+0xd9e>
    2ce0:	00003097          	auipc	ra,0x3
    2ce4:	e6a080e7          	jalr	-406(ra) # 5b4a <printf>
      exit(1);
    2ce8:	4505                	li	a0,1
    2cea:	00003097          	auipc	ra,0x3
    2cee:	ae6080e7          	jalr	-1306(ra) # 57d0 <exit>
        if(a == 0xffffffffffffffffLL)
    2cf2:	59fd                	li	s3,-1
        *(char*)(a + 4096 - 1) = 1;
    2cf4:	4a05                	li	s4,1
        uint64 a = (uint64) sbrk(4096);
    2cf6:	6505                	lui	a0,0x1
    2cf8:	00003097          	auipc	ra,0x3
    2cfc:	b60080e7          	jalr	-1184(ra) # 5858 <sbrk>
        if(a == 0xffffffffffffffffLL)
    2d00:	01350763          	beq	a0,s3,2d0e <execout+0x74>
        *(char*)(a + 4096 - 1) = 1;
    2d04:	6785                	lui	a5,0x1
    2d06:	97aa                	add	a5,a5,a0
    2d08:	ff478fa3          	sb	s4,-1(a5) # fff <linktest+0x213>
      while(1){
    2d0c:	b7ed                	j	2cf6 <execout+0x5c>
      for(int i = 0; i < avail; i++)
    2d0e:	01205a63          	blez	s2,2d22 <execout+0x88>
        sbrk(-4096);
    2d12:	757d                	lui	a0,0xfffff
    2d14:	00003097          	auipc	ra,0x3
    2d18:	b44080e7          	jalr	-1212(ra) # 5858 <sbrk>
      for(int i = 0; i < avail; i++)
    2d1c:	2485                	addiw	s1,s1,1
    2d1e:	ff249ae3          	bne	s1,s2,2d12 <execout+0x78>
      close(1);
    2d22:	4505                	li	a0,1
    2d24:	00003097          	auipc	ra,0x3
    2d28:	ad4080e7          	jalr	-1324(ra) # 57f8 <close>
      char *args[] = { "echo", "x", 0 };
    2d2c:	00003517          	auipc	a0,0x3
    2d30:	ff450513          	addi	a0,a0,-12 # 5d20 <malloc+0x11e>
    2d34:	faa43c23          	sd	a0,-72(s0)
    2d38:	00003797          	auipc	a5,0x3
    2d3c:	05878793          	addi	a5,a5,88 # 5d90 <malloc+0x18e>
    2d40:	fcf43023          	sd	a5,-64(s0)
    2d44:	fc043423          	sd	zero,-56(s0)
      exec("echo", args);
    2d48:	fb840593          	addi	a1,s0,-72
    2d4c:	00003097          	auipc	ra,0x3
    2d50:	abc080e7          	jalr	-1348(ra) # 5808 <exec>
      exit(0);
    2d54:	4501                	li	a0,0
    2d56:	00003097          	auipc	ra,0x3
    2d5a:	a7a080e7          	jalr	-1414(ra) # 57d0 <exit>

0000000000002d5e <fourteen>:
{
    2d5e:	1101                	addi	sp,sp,-32
    2d60:	ec06                	sd	ra,24(sp)
    2d62:	e822                	sd	s0,16(sp)
    2d64:	e426                	sd	s1,8(sp)
    2d66:	1000                	addi	s0,sp,32
    2d68:	84aa                	mv	s1,a0
  if(mkdir("12345678901234") != 0){
    2d6a:	00004517          	auipc	a0,0x4
    2d6e:	12e50513          	addi	a0,a0,302 # 6e98 <malloc+0x1296>
    2d72:	00003097          	auipc	ra,0x3
    2d76:	ac6080e7          	jalr	-1338(ra) # 5838 <mkdir>
    2d7a:	e165                	bnez	a0,2e5a <fourteen+0xfc>
  if(mkdir("12345678901234/123456789012345") != 0){
    2d7c:	00004517          	auipc	a0,0x4
    2d80:	f7450513          	addi	a0,a0,-140 # 6cf0 <malloc+0x10ee>
    2d84:	00003097          	auipc	ra,0x3
    2d88:	ab4080e7          	jalr	-1356(ra) # 5838 <mkdir>
    2d8c:	e56d                	bnez	a0,2e76 <fourteen+0x118>
  fd = open("123456789012345/123456789012345/123456789012345", O_CREATE);
    2d8e:	20000593          	li	a1,512
    2d92:	00004517          	auipc	a0,0x4
    2d96:	fb650513          	addi	a0,a0,-74 # 6d48 <malloc+0x1146>
    2d9a:	00003097          	auipc	ra,0x3
    2d9e:	a76080e7          	jalr	-1418(ra) # 5810 <open>
  if(fd < 0){
    2da2:	0e054863          	bltz	a0,2e92 <fourteen+0x134>
  close(fd);
    2da6:	00003097          	auipc	ra,0x3
    2daa:	a52080e7          	jalr	-1454(ra) # 57f8 <close>
  fd = open("12345678901234/12345678901234/12345678901234", 0);
    2dae:	4581                	li	a1,0
    2db0:	00004517          	auipc	a0,0x4
    2db4:	01050513          	addi	a0,a0,16 # 6dc0 <malloc+0x11be>
    2db8:	00003097          	auipc	ra,0x3
    2dbc:	a58080e7          	jalr	-1448(ra) # 5810 <open>
  if(fd < 0){
    2dc0:	0e054763          	bltz	a0,2eae <fourteen+0x150>
  close(fd);
    2dc4:	00003097          	auipc	ra,0x3
    2dc8:	a34080e7          	jalr	-1484(ra) # 57f8 <close>
  if(mkdir("12345678901234/12345678901234") == 0){
    2dcc:	00004517          	auipc	a0,0x4
    2dd0:	06450513          	addi	a0,a0,100 # 6e30 <malloc+0x122e>
    2dd4:	00003097          	auipc	ra,0x3
    2dd8:	a64080e7          	jalr	-1436(ra) # 5838 <mkdir>
    2ddc:	c57d                	beqz	a0,2eca <fourteen+0x16c>
  if(mkdir("123456789012345/12345678901234") == 0){
    2dde:	00004517          	auipc	a0,0x4
    2de2:	0aa50513          	addi	a0,a0,170 # 6e88 <malloc+0x1286>
    2de6:	00003097          	auipc	ra,0x3
    2dea:	a52080e7          	jalr	-1454(ra) # 5838 <mkdir>
    2dee:	cd65                	beqz	a0,2ee6 <fourteen+0x188>
  unlink("123456789012345/12345678901234");
    2df0:	00004517          	auipc	a0,0x4
    2df4:	09850513          	addi	a0,a0,152 # 6e88 <malloc+0x1286>
    2df8:	00003097          	auipc	ra,0x3
    2dfc:	a28080e7          	jalr	-1496(ra) # 5820 <unlink>
  unlink("12345678901234/12345678901234");
    2e00:	00004517          	auipc	a0,0x4
    2e04:	03050513          	addi	a0,a0,48 # 6e30 <malloc+0x122e>
    2e08:	00003097          	auipc	ra,0x3
    2e0c:	a18080e7          	jalr	-1512(ra) # 5820 <unlink>
  unlink("12345678901234/12345678901234/12345678901234");
    2e10:	00004517          	auipc	a0,0x4
    2e14:	fb050513          	addi	a0,a0,-80 # 6dc0 <malloc+0x11be>
    2e18:	00003097          	auipc	ra,0x3
    2e1c:	a08080e7          	jalr	-1528(ra) # 5820 <unlink>
  unlink("123456789012345/123456789012345/123456789012345");
    2e20:	00004517          	auipc	a0,0x4
    2e24:	f2850513          	addi	a0,a0,-216 # 6d48 <malloc+0x1146>
    2e28:	00003097          	auipc	ra,0x3
    2e2c:	9f8080e7          	jalr	-1544(ra) # 5820 <unlink>
  unlink("12345678901234/123456789012345");
    2e30:	00004517          	auipc	a0,0x4
    2e34:	ec050513          	addi	a0,a0,-320 # 6cf0 <malloc+0x10ee>
    2e38:	00003097          	auipc	ra,0x3
    2e3c:	9e8080e7          	jalr	-1560(ra) # 5820 <unlink>
  unlink("12345678901234");
    2e40:	00004517          	auipc	a0,0x4
    2e44:	05850513          	addi	a0,a0,88 # 6e98 <malloc+0x1296>
    2e48:	00003097          	auipc	ra,0x3
    2e4c:	9d8080e7          	jalr	-1576(ra) # 5820 <unlink>
}
    2e50:	60e2                	ld	ra,24(sp)
    2e52:	6442                	ld	s0,16(sp)
    2e54:	64a2                	ld	s1,8(sp)
    2e56:	6105                	addi	sp,sp,32
    2e58:	8082                	ret
    printf("%s: mkdir 12345678901234 failed\n", s);
    2e5a:	85a6                	mv	a1,s1
    2e5c:	00004517          	auipc	a0,0x4
    2e60:	e6c50513          	addi	a0,a0,-404 # 6cc8 <malloc+0x10c6>
    2e64:	00003097          	auipc	ra,0x3
    2e68:	ce6080e7          	jalr	-794(ra) # 5b4a <printf>
    exit(1);
    2e6c:	4505                	li	a0,1
    2e6e:	00003097          	auipc	ra,0x3
    2e72:	962080e7          	jalr	-1694(ra) # 57d0 <exit>
    printf("%s: mkdir 12345678901234/123456789012345 failed\n", s);
    2e76:	85a6                	mv	a1,s1
    2e78:	00004517          	auipc	a0,0x4
    2e7c:	e9850513          	addi	a0,a0,-360 # 6d10 <malloc+0x110e>
    2e80:	00003097          	auipc	ra,0x3
    2e84:	cca080e7          	jalr	-822(ra) # 5b4a <printf>
    exit(1);
    2e88:	4505                	li	a0,1
    2e8a:	00003097          	auipc	ra,0x3
    2e8e:	946080e7          	jalr	-1722(ra) # 57d0 <exit>
    printf("%s: create 123456789012345/123456789012345/123456789012345 failed\n", s);
    2e92:	85a6                	mv	a1,s1
    2e94:	00004517          	auipc	a0,0x4
    2e98:	ee450513          	addi	a0,a0,-284 # 6d78 <malloc+0x1176>
    2e9c:	00003097          	auipc	ra,0x3
    2ea0:	cae080e7          	jalr	-850(ra) # 5b4a <printf>
    exit(1);
    2ea4:	4505                	li	a0,1
    2ea6:	00003097          	auipc	ra,0x3
    2eaa:	92a080e7          	jalr	-1750(ra) # 57d0 <exit>
    printf("%s: open 12345678901234/12345678901234/12345678901234 failed\n", s);
    2eae:	85a6                	mv	a1,s1
    2eb0:	00004517          	auipc	a0,0x4
    2eb4:	f4050513          	addi	a0,a0,-192 # 6df0 <malloc+0x11ee>
    2eb8:	00003097          	auipc	ra,0x3
    2ebc:	c92080e7          	jalr	-878(ra) # 5b4a <printf>
    exit(1);
    2ec0:	4505                	li	a0,1
    2ec2:	00003097          	auipc	ra,0x3
    2ec6:	90e080e7          	jalr	-1778(ra) # 57d0 <exit>
    printf("%s: mkdir 12345678901234/12345678901234 succeeded!\n", s);
    2eca:	85a6                	mv	a1,s1
    2ecc:	00004517          	auipc	a0,0x4
    2ed0:	f8450513          	addi	a0,a0,-124 # 6e50 <malloc+0x124e>
    2ed4:	00003097          	auipc	ra,0x3
    2ed8:	c76080e7          	jalr	-906(ra) # 5b4a <printf>
    exit(1);
    2edc:	4505                	li	a0,1
    2ede:	00003097          	auipc	ra,0x3
    2ee2:	8f2080e7          	jalr	-1806(ra) # 57d0 <exit>
    printf("%s: mkdir 12345678901234/123456789012345 succeeded!\n", s);
    2ee6:	85a6                	mv	a1,s1
    2ee8:	00004517          	auipc	a0,0x4
    2eec:	fc050513          	addi	a0,a0,-64 # 6ea8 <malloc+0x12a6>
    2ef0:	00003097          	auipc	ra,0x3
    2ef4:	c5a080e7          	jalr	-934(ra) # 5b4a <printf>
    exit(1);
    2ef8:	4505                	li	a0,1
    2efa:	00003097          	auipc	ra,0x3
    2efe:	8d6080e7          	jalr	-1834(ra) # 57d0 <exit>

0000000000002f02 <iputtest>:
{
    2f02:	1101                	addi	sp,sp,-32
    2f04:	ec06                	sd	ra,24(sp)
    2f06:	e822                	sd	s0,16(sp)
    2f08:	e426                	sd	s1,8(sp)
    2f0a:	1000                	addi	s0,sp,32
    2f0c:	84aa                	mv	s1,a0
  if(mkdir("iputdir") < 0){
    2f0e:	00004517          	auipc	a0,0x4
    2f12:	fd250513          	addi	a0,a0,-46 # 6ee0 <malloc+0x12de>
    2f16:	00003097          	auipc	ra,0x3
    2f1a:	922080e7          	jalr	-1758(ra) # 5838 <mkdir>
    2f1e:	04054563          	bltz	a0,2f68 <iputtest+0x66>
  if(chdir("iputdir") < 0){
    2f22:	00004517          	auipc	a0,0x4
    2f26:	fbe50513          	addi	a0,a0,-66 # 6ee0 <malloc+0x12de>
    2f2a:	00003097          	auipc	ra,0x3
    2f2e:	916080e7          	jalr	-1770(ra) # 5840 <chdir>
    2f32:	04054963          	bltz	a0,2f84 <iputtest+0x82>
  if(unlink("../iputdir") < 0){
    2f36:	00004517          	auipc	a0,0x4
    2f3a:	fea50513          	addi	a0,a0,-22 # 6f20 <malloc+0x131e>
    2f3e:	00003097          	auipc	ra,0x3
    2f42:	8e2080e7          	jalr	-1822(ra) # 5820 <unlink>
    2f46:	04054d63          	bltz	a0,2fa0 <iputtest+0x9e>
  if(chdir("/") < 0){
    2f4a:	00004517          	auipc	a0,0x4
    2f4e:	00650513          	addi	a0,a0,6 # 6f50 <malloc+0x134e>
    2f52:	00003097          	auipc	ra,0x3
    2f56:	8ee080e7          	jalr	-1810(ra) # 5840 <chdir>
    2f5a:	06054163          	bltz	a0,2fbc <iputtest+0xba>
}
    2f5e:	60e2                	ld	ra,24(sp)
    2f60:	6442                	ld	s0,16(sp)
    2f62:	64a2                	ld	s1,8(sp)
    2f64:	6105                	addi	sp,sp,32
    2f66:	8082                	ret
    printf("%s: mkdir failed\n", s);
    2f68:	85a6                	mv	a1,s1
    2f6a:	00004517          	auipc	a0,0x4
    2f6e:	f7e50513          	addi	a0,a0,-130 # 6ee8 <malloc+0x12e6>
    2f72:	00003097          	auipc	ra,0x3
    2f76:	bd8080e7          	jalr	-1064(ra) # 5b4a <printf>
    exit(1);
    2f7a:	4505                	li	a0,1
    2f7c:	00003097          	auipc	ra,0x3
    2f80:	854080e7          	jalr	-1964(ra) # 57d0 <exit>
    printf("%s: chdir iputdir failed\n", s);
    2f84:	85a6                	mv	a1,s1
    2f86:	00004517          	auipc	a0,0x4
    2f8a:	f7a50513          	addi	a0,a0,-134 # 6f00 <malloc+0x12fe>
    2f8e:	00003097          	auipc	ra,0x3
    2f92:	bbc080e7          	jalr	-1092(ra) # 5b4a <printf>
    exit(1);
    2f96:	4505                	li	a0,1
    2f98:	00003097          	auipc	ra,0x3
    2f9c:	838080e7          	jalr	-1992(ra) # 57d0 <exit>
    printf("%s: unlink ../iputdir failed\n", s);
    2fa0:	85a6                	mv	a1,s1
    2fa2:	00004517          	auipc	a0,0x4
    2fa6:	f8e50513          	addi	a0,a0,-114 # 6f30 <malloc+0x132e>
    2faa:	00003097          	auipc	ra,0x3
    2fae:	ba0080e7          	jalr	-1120(ra) # 5b4a <printf>
    exit(1);
    2fb2:	4505                	li	a0,1
    2fb4:	00003097          	auipc	ra,0x3
    2fb8:	81c080e7          	jalr	-2020(ra) # 57d0 <exit>
    printf("%s: chdir / failed\n", s);
    2fbc:	85a6                	mv	a1,s1
    2fbe:	00004517          	auipc	a0,0x4
    2fc2:	f9a50513          	addi	a0,a0,-102 # 6f58 <malloc+0x1356>
    2fc6:	00003097          	auipc	ra,0x3
    2fca:	b84080e7          	jalr	-1148(ra) # 5b4a <printf>
    exit(1);
    2fce:	4505                	li	a0,1
    2fd0:	00003097          	auipc	ra,0x3
    2fd4:	800080e7          	jalr	-2048(ra) # 57d0 <exit>

0000000000002fd8 <exitiputtest>:
{
    2fd8:	7179                	addi	sp,sp,-48
    2fda:	f406                	sd	ra,40(sp)
    2fdc:	f022                	sd	s0,32(sp)
    2fde:	ec26                	sd	s1,24(sp)
    2fe0:	1800                	addi	s0,sp,48
    2fe2:	84aa                	mv	s1,a0
  pid = fork();
    2fe4:	00002097          	auipc	ra,0x2
    2fe8:	7e4080e7          	jalr	2020(ra) # 57c8 <fork>
  if(pid < 0){
    2fec:	04054663          	bltz	a0,3038 <exitiputtest+0x60>
  if(pid == 0){
    2ff0:	ed45                	bnez	a0,30a8 <exitiputtest+0xd0>
    if(mkdir("iputdir") < 0){
    2ff2:	00004517          	auipc	a0,0x4
    2ff6:	eee50513          	addi	a0,a0,-274 # 6ee0 <malloc+0x12de>
    2ffa:	00003097          	auipc	ra,0x3
    2ffe:	83e080e7          	jalr	-1986(ra) # 5838 <mkdir>
    3002:	04054963          	bltz	a0,3054 <exitiputtest+0x7c>
    if(chdir("iputdir") < 0){
    3006:	00004517          	auipc	a0,0x4
    300a:	eda50513          	addi	a0,a0,-294 # 6ee0 <malloc+0x12de>
    300e:	00003097          	auipc	ra,0x3
    3012:	832080e7          	jalr	-1998(ra) # 5840 <chdir>
    3016:	04054d63          	bltz	a0,3070 <exitiputtest+0x98>
    if(unlink("../iputdir") < 0){
    301a:	00004517          	auipc	a0,0x4
    301e:	f0650513          	addi	a0,a0,-250 # 6f20 <malloc+0x131e>
    3022:	00002097          	auipc	ra,0x2
    3026:	7fe080e7          	jalr	2046(ra) # 5820 <unlink>
    302a:	06054163          	bltz	a0,308c <exitiputtest+0xb4>
    exit(0);
    302e:	4501                	li	a0,0
    3030:	00002097          	auipc	ra,0x2
    3034:	7a0080e7          	jalr	1952(ra) # 57d0 <exit>
    printf("%s: fork failed\n", s);
    3038:	85a6                	mv	a1,s1
    303a:	00003517          	auipc	a0,0x3
    303e:	55e50513          	addi	a0,a0,1374 # 6598 <malloc+0x996>
    3042:	00003097          	auipc	ra,0x3
    3046:	b08080e7          	jalr	-1272(ra) # 5b4a <printf>
    exit(1);
    304a:	4505                	li	a0,1
    304c:	00002097          	auipc	ra,0x2
    3050:	784080e7          	jalr	1924(ra) # 57d0 <exit>
      printf("%s: mkdir failed\n", s);
    3054:	85a6                	mv	a1,s1
    3056:	00004517          	auipc	a0,0x4
    305a:	e9250513          	addi	a0,a0,-366 # 6ee8 <malloc+0x12e6>
    305e:	00003097          	auipc	ra,0x3
    3062:	aec080e7          	jalr	-1300(ra) # 5b4a <printf>
      exit(1);
    3066:	4505                	li	a0,1
    3068:	00002097          	auipc	ra,0x2
    306c:	768080e7          	jalr	1896(ra) # 57d0 <exit>
      printf("%s: child chdir failed\n", s);
    3070:	85a6                	mv	a1,s1
    3072:	00004517          	auipc	a0,0x4
    3076:	efe50513          	addi	a0,a0,-258 # 6f70 <malloc+0x136e>
    307a:	00003097          	auipc	ra,0x3
    307e:	ad0080e7          	jalr	-1328(ra) # 5b4a <printf>
      exit(1);
    3082:	4505                	li	a0,1
    3084:	00002097          	auipc	ra,0x2
    3088:	74c080e7          	jalr	1868(ra) # 57d0 <exit>
      printf("%s: unlink ../iputdir failed\n", s);
    308c:	85a6                	mv	a1,s1
    308e:	00004517          	auipc	a0,0x4
    3092:	ea250513          	addi	a0,a0,-350 # 6f30 <malloc+0x132e>
    3096:	00003097          	auipc	ra,0x3
    309a:	ab4080e7          	jalr	-1356(ra) # 5b4a <printf>
      exit(1);
    309e:	4505                	li	a0,1
    30a0:	00002097          	auipc	ra,0x2
    30a4:	730080e7          	jalr	1840(ra) # 57d0 <exit>
  wait(&xstatus);
    30a8:	fdc40513          	addi	a0,s0,-36
    30ac:	00002097          	auipc	ra,0x2
    30b0:	72c080e7          	jalr	1836(ra) # 57d8 <wait>
  exit(xstatus);
    30b4:	fdc42503          	lw	a0,-36(s0)
    30b8:	00002097          	auipc	ra,0x2
    30bc:	718080e7          	jalr	1816(ra) # 57d0 <exit>

00000000000030c0 <dirtest>:
{
    30c0:	1101                	addi	sp,sp,-32
    30c2:	ec06                	sd	ra,24(sp)
    30c4:	e822                	sd	s0,16(sp)
    30c6:	e426                	sd	s1,8(sp)
    30c8:	1000                	addi	s0,sp,32
    30ca:	84aa                	mv	s1,a0
  if(mkdir("dir0") < 0){
    30cc:	00004517          	auipc	a0,0x4
    30d0:	ebc50513          	addi	a0,a0,-324 # 6f88 <malloc+0x1386>
    30d4:	00002097          	auipc	ra,0x2
    30d8:	764080e7          	jalr	1892(ra) # 5838 <mkdir>
    30dc:	04054563          	bltz	a0,3126 <dirtest+0x66>
  if(chdir("dir0") < 0){
    30e0:	00004517          	auipc	a0,0x4
    30e4:	ea850513          	addi	a0,a0,-344 # 6f88 <malloc+0x1386>
    30e8:	00002097          	auipc	ra,0x2
    30ec:	758080e7          	jalr	1880(ra) # 5840 <chdir>
    30f0:	04054963          	bltz	a0,3142 <dirtest+0x82>
  if(chdir("..") < 0){
    30f4:	00004517          	auipc	a0,0x4
    30f8:	eb450513          	addi	a0,a0,-332 # 6fa8 <malloc+0x13a6>
    30fc:	00002097          	auipc	ra,0x2
    3100:	744080e7          	jalr	1860(ra) # 5840 <chdir>
    3104:	04054d63          	bltz	a0,315e <dirtest+0x9e>
  if(unlink("dir0") < 0){
    3108:	00004517          	auipc	a0,0x4
    310c:	e8050513          	addi	a0,a0,-384 # 6f88 <malloc+0x1386>
    3110:	00002097          	auipc	ra,0x2
    3114:	710080e7          	jalr	1808(ra) # 5820 <unlink>
    3118:	06054163          	bltz	a0,317a <dirtest+0xba>
}
    311c:	60e2                	ld	ra,24(sp)
    311e:	6442                	ld	s0,16(sp)
    3120:	64a2                	ld	s1,8(sp)
    3122:	6105                	addi	sp,sp,32
    3124:	8082                	ret
    printf("%s: mkdir failed\n", s);
    3126:	85a6                	mv	a1,s1
    3128:	00004517          	auipc	a0,0x4
    312c:	dc050513          	addi	a0,a0,-576 # 6ee8 <malloc+0x12e6>
    3130:	00003097          	auipc	ra,0x3
    3134:	a1a080e7          	jalr	-1510(ra) # 5b4a <printf>
    exit(1);
    3138:	4505                	li	a0,1
    313a:	00002097          	auipc	ra,0x2
    313e:	696080e7          	jalr	1686(ra) # 57d0 <exit>
    printf("%s: chdir dir0 failed\n", s);
    3142:	85a6                	mv	a1,s1
    3144:	00004517          	auipc	a0,0x4
    3148:	e4c50513          	addi	a0,a0,-436 # 6f90 <malloc+0x138e>
    314c:	00003097          	auipc	ra,0x3
    3150:	9fe080e7          	jalr	-1538(ra) # 5b4a <printf>
    exit(1);
    3154:	4505                	li	a0,1
    3156:	00002097          	auipc	ra,0x2
    315a:	67a080e7          	jalr	1658(ra) # 57d0 <exit>
    printf("%s: chdir .. failed\n", s);
    315e:	85a6                	mv	a1,s1
    3160:	00004517          	auipc	a0,0x4
    3164:	e5050513          	addi	a0,a0,-432 # 6fb0 <malloc+0x13ae>
    3168:	00003097          	auipc	ra,0x3
    316c:	9e2080e7          	jalr	-1566(ra) # 5b4a <printf>
    exit(1);
    3170:	4505                	li	a0,1
    3172:	00002097          	auipc	ra,0x2
    3176:	65e080e7          	jalr	1630(ra) # 57d0 <exit>
    printf("%s: unlink dir0 failed\n", s);
    317a:	85a6                	mv	a1,s1
    317c:	00004517          	auipc	a0,0x4
    3180:	e4c50513          	addi	a0,a0,-436 # 6fc8 <malloc+0x13c6>
    3184:	00003097          	auipc	ra,0x3
    3188:	9c6080e7          	jalr	-1594(ra) # 5b4a <printf>
    exit(1);
    318c:	4505                	li	a0,1
    318e:	00002097          	auipc	ra,0x2
    3192:	642080e7          	jalr	1602(ra) # 57d0 <exit>

0000000000003196 <subdir>:
{
    3196:	1101                	addi	sp,sp,-32
    3198:	ec06                	sd	ra,24(sp)
    319a:	e822                	sd	s0,16(sp)
    319c:	e426                	sd	s1,8(sp)
    319e:	e04a                	sd	s2,0(sp)
    31a0:	1000                	addi	s0,sp,32
    31a2:	892a                	mv	s2,a0
  unlink("ff");
    31a4:	00004517          	auipc	a0,0x4
    31a8:	f6c50513          	addi	a0,a0,-148 # 7110 <malloc+0x150e>
    31ac:	00002097          	auipc	ra,0x2
    31b0:	674080e7          	jalr	1652(ra) # 5820 <unlink>
  if(mkdir("dd") != 0){
    31b4:	00004517          	auipc	a0,0x4
    31b8:	e2c50513          	addi	a0,a0,-468 # 6fe0 <malloc+0x13de>
    31bc:	00002097          	auipc	ra,0x2
    31c0:	67c080e7          	jalr	1660(ra) # 5838 <mkdir>
    31c4:	38051663          	bnez	a0,3550 <subdir+0x3ba>
  fd = open("dd/ff", O_CREATE | O_RDWR);
    31c8:	20200593          	li	a1,514
    31cc:	00004517          	auipc	a0,0x4
    31d0:	e3450513          	addi	a0,a0,-460 # 7000 <malloc+0x13fe>
    31d4:	00002097          	auipc	ra,0x2
    31d8:	63c080e7          	jalr	1596(ra) # 5810 <open>
    31dc:	84aa                	mv	s1,a0
  if(fd < 0){
    31de:	38054763          	bltz	a0,356c <subdir+0x3d6>
  write(fd, "ff", 2);
    31e2:	4609                	li	a2,2
    31e4:	00004597          	auipc	a1,0x4
    31e8:	f2c58593          	addi	a1,a1,-212 # 7110 <malloc+0x150e>
    31ec:	00002097          	auipc	ra,0x2
    31f0:	604080e7          	jalr	1540(ra) # 57f0 <write>
  close(fd);
    31f4:	8526                	mv	a0,s1
    31f6:	00002097          	auipc	ra,0x2
    31fa:	602080e7          	jalr	1538(ra) # 57f8 <close>
  if(unlink("dd") >= 0){
    31fe:	00004517          	auipc	a0,0x4
    3202:	de250513          	addi	a0,a0,-542 # 6fe0 <malloc+0x13de>
    3206:	00002097          	auipc	ra,0x2
    320a:	61a080e7          	jalr	1562(ra) # 5820 <unlink>
    320e:	36055d63          	bgez	a0,3588 <subdir+0x3f2>
  if(mkdir("/dd/dd") != 0){
    3212:	00004517          	auipc	a0,0x4
    3216:	e4650513          	addi	a0,a0,-442 # 7058 <malloc+0x1456>
    321a:	00002097          	auipc	ra,0x2
    321e:	61e080e7          	jalr	1566(ra) # 5838 <mkdir>
    3222:	38051163          	bnez	a0,35a4 <subdir+0x40e>
  fd = open("dd/dd/ff", O_CREATE | O_RDWR);
    3226:	20200593          	li	a1,514
    322a:	00004517          	auipc	a0,0x4
    322e:	e5650513          	addi	a0,a0,-426 # 7080 <malloc+0x147e>
    3232:	00002097          	auipc	ra,0x2
    3236:	5de080e7          	jalr	1502(ra) # 5810 <open>
    323a:	84aa                	mv	s1,a0
  if(fd < 0){
    323c:	38054263          	bltz	a0,35c0 <subdir+0x42a>
  write(fd, "FF", 2);
    3240:	4609                	li	a2,2
    3242:	00004597          	auipc	a1,0x4
    3246:	e6e58593          	addi	a1,a1,-402 # 70b0 <malloc+0x14ae>
    324a:	00002097          	auipc	ra,0x2
    324e:	5a6080e7          	jalr	1446(ra) # 57f0 <write>
  close(fd);
    3252:	8526                	mv	a0,s1
    3254:	00002097          	auipc	ra,0x2
    3258:	5a4080e7          	jalr	1444(ra) # 57f8 <close>
  fd = open("dd/dd/../ff", 0);
    325c:	4581                	li	a1,0
    325e:	00004517          	auipc	a0,0x4
    3262:	e5a50513          	addi	a0,a0,-422 # 70b8 <malloc+0x14b6>
    3266:	00002097          	auipc	ra,0x2
    326a:	5aa080e7          	jalr	1450(ra) # 5810 <open>
    326e:	84aa                	mv	s1,a0
  if(fd < 0){
    3270:	36054663          	bltz	a0,35dc <subdir+0x446>
  cc = read(fd, buf, sizeof(buf));
    3274:	660d                	lui	a2,0x3
    3276:	00009597          	auipc	a1,0x9
    327a:	b0258593          	addi	a1,a1,-1278 # bd78 <buf>
    327e:	00002097          	auipc	ra,0x2
    3282:	56a080e7          	jalr	1386(ra) # 57e8 <read>
  if(cc != 2 || buf[0] != 'f'){
    3286:	4789                	li	a5,2
    3288:	36f51863          	bne	a0,a5,35f8 <subdir+0x462>
    328c:	00009717          	auipc	a4,0x9
    3290:	aec74703          	lbu	a4,-1300(a4) # bd78 <buf>
    3294:	06600793          	li	a5,102
    3298:	36f71063          	bne	a4,a5,35f8 <subdir+0x462>
  close(fd);
    329c:	8526                	mv	a0,s1
    329e:	00002097          	auipc	ra,0x2
    32a2:	55a080e7          	jalr	1370(ra) # 57f8 <close>
  if(link("dd/dd/ff", "dd/dd/ffff") != 0){
    32a6:	00004597          	auipc	a1,0x4
    32aa:	e6258593          	addi	a1,a1,-414 # 7108 <malloc+0x1506>
    32ae:	00004517          	auipc	a0,0x4
    32b2:	dd250513          	addi	a0,a0,-558 # 7080 <malloc+0x147e>
    32b6:	00002097          	auipc	ra,0x2
    32ba:	57a080e7          	jalr	1402(ra) # 5830 <link>
    32be:	34051b63          	bnez	a0,3614 <subdir+0x47e>
  if(unlink("dd/dd/ff") != 0){
    32c2:	00004517          	auipc	a0,0x4
    32c6:	dbe50513          	addi	a0,a0,-578 # 7080 <malloc+0x147e>
    32ca:	00002097          	auipc	ra,0x2
    32ce:	556080e7          	jalr	1366(ra) # 5820 <unlink>
    32d2:	34051f63          	bnez	a0,3630 <subdir+0x49a>
  if(open("dd/dd/ff", O_RDONLY) >= 0){
    32d6:	4581                	li	a1,0
    32d8:	00004517          	auipc	a0,0x4
    32dc:	da850513          	addi	a0,a0,-600 # 7080 <malloc+0x147e>
    32e0:	00002097          	auipc	ra,0x2
    32e4:	530080e7          	jalr	1328(ra) # 5810 <open>
    32e8:	36055263          	bgez	a0,364c <subdir+0x4b6>
  if(chdir("dd") != 0){
    32ec:	00004517          	auipc	a0,0x4
    32f0:	cf450513          	addi	a0,a0,-780 # 6fe0 <malloc+0x13de>
    32f4:	00002097          	auipc	ra,0x2
    32f8:	54c080e7          	jalr	1356(ra) # 5840 <chdir>
    32fc:	36051663          	bnez	a0,3668 <subdir+0x4d2>
  if(chdir("dd/../../dd") != 0){
    3300:	00004517          	auipc	a0,0x4
    3304:	ea050513          	addi	a0,a0,-352 # 71a0 <malloc+0x159e>
    3308:	00002097          	auipc	ra,0x2
    330c:	538080e7          	jalr	1336(ra) # 5840 <chdir>
    3310:	36051a63          	bnez	a0,3684 <subdir+0x4ee>
  if(chdir("dd/../../../dd") != 0){
    3314:	00004517          	auipc	a0,0x4
    3318:	ebc50513          	addi	a0,a0,-324 # 71d0 <malloc+0x15ce>
    331c:	00002097          	auipc	ra,0x2
    3320:	524080e7          	jalr	1316(ra) # 5840 <chdir>
    3324:	36051e63          	bnez	a0,36a0 <subdir+0x50a>
  if(chdir("./..") != 0){
    3328:	00004517          	auipc	a0,0x4
    332c:	ed850513          	addi	a0,a0,-296 # 7200 <malloc+0x15fe>
    3330:	00002097          	auipc	ra,0x2
    3334:	510080e7          	jalr	1296(ra) # 5840 <chdir>
    3338:	38051263          	bnez	a0,36bc <subdir+0x526>
  fd = open("dd/dd/ffff", 0);
    333c:	4581                	li	a1,0
    333e:	00004517          	auipc	a0,0x4
    3342:	dca50513          	addi	a0,a0,-566 # 7108 <malloc+0x1506>
    3346:	00002097          	auipc	ra,0x2
    334a:	4ca080e7          	jalr	1226(ra) # 5810 <open>
    334e:	84aa                	mv	s1,a0
  if(fd < 0){
    3350:	38054463          	bltz	a0,36d8 <subdir+0x542>
  if(read(fd, buf, sizeof(buf)) != 2){
    3354:	660d                	lui	a2,0x3
    3356:	00009597          	auipc	a1,0x9
    335a:	a2258593          	addi	a1,a1,-1502 # bd78 <buf>
    335e:	00002097          	auipc	ra,0x2
    3362:	48a080e7          	jalr	1162(ra) # 57e8 <read>
    3366:	4789                	li	a5,2
    3368:	38f51663          	bne	a0,a5,36f4 <subdir+0x55e>
  close(fd);
    336c:	8526                	mv	a0,s1
    336e:	00002097          	auipc	ra,0x2
    3372:	48a080e7          	jalr	1162(ra) # 57f8 <close>
  if(open("dd/dd/ff", O_RDONLY) >= 0){
    3376:	4581                	li	a1,0
    3378:	00004517          	auipc	a0,0x4
    337c:	d0850513          	addi	a0,a0,-760 # 7080 <malloc+0x147e>
    3380:	00002097          	auipc	ra,0x2
    3384:	490080e7          	jalr	1168(ra) # 5810 <open>
    3388:	38055463          	bgez	a0,3710 <subdir+0x57a>
  if(open("dd/ff/ff", O_CREATE|O_RDWR) >= 0){
    338c:	20200593          	li	a1,514
    3390:	00004517          	auipc	a0,0x4
    3394:	f0050513          	addi	a0,a0,-256 # 7290 <malloc+0x168e>
    3398:	00002097          	auipc	ra,0x2
    339c:	478080e7          	jalr	1144(ra) # 5810 <open>
    33a0:	38055663          	bgez	a0,372c <subdir+0x596>
  if(open("dd/xx/ff", O_CREATE|O_RDWR) >= 0){
    33a4:	20200593          	li	a1,514
    33a8:	00004517          	auipc	a0,0x4
    33ac:	f1850513          	addi	a0,a0,-232 # 72c0 <malloc+0x16be>
    33b0:	00002097          	auipc	ra,0x2
    33b4:	460080e7          	jalr	1120(ra) # 5810 <open>
    33b8:	38055863          	bgez	a0,3748 <subdir+0x5b2>
  if(open("dd", O_CREATE) >= 0){
    33bc:	20000593          	li	a1,512
    33c0:	00004517          	auipc	a0,0x4
    33c4:	c2050513          	addi	a0,a0,-992 # 6fe0 <malloc+0x13de>
    33c8:	00002097          	auipc	ra,0x2
    33cc:	448080e7          	jalr	1096(ra) # 5810 <open>
    33d0:	38055a63          	bgez	a0,3764 <subdir+0x5ce>
  if(open("dd", O_RDWR) >= 0){
    33d4:	4589                	li	a1,2
    33d6:	00004517          	auipc	a0,0x4
    33da:	c0a50513          	addi	a0,a0,-1014 # 6fe0 <malloc+0x13de>
    33de:	00002097          	auipc	ra,0x2
    33e2:	432080e7          	jalr	1074(ra) # 5810 <open>
    33e6:	38055d63          	bgez	a0,3780 <subdir+0x5ea>
  if(open("dd", O_WRONLY) >= 0){
    33ea:	4585                	li	a1,1
    33ec:	00004517          	auipc	a0,0x4
    33f0:	bf450513          	addi	a0,a0,-1036 # 6fe0 <malloc+0x13de>
    33f4:	00002097          	auipc	ra,0x2
    33f8:	41c080e7          	jalr	1052(ra) # 5810 <open>
    33fc:	3a055063          	bgez	a0,379c <subdir+0x606>
  if(link("dd/ff/ff", "dd/dd/xx") == 0){
    3400:	00004597          	auipc	a1,0x4
    3404:	f5058593          	addi	a1,a1,-176 # 7350 <malloc+0x174e>
    3408:	00004517          	auipc	a0,0x4
    340c:	e8850513          	addi	a0,a0,-376 # 7290 <malloc+0x168e>
    3410:	00002097          	auipc	ra,0x2
    3414:	420080e7          	jalr	1056(ra) # 5830 <link>
    3418:	3a050063          	beqz	a0,37b8 <subdir+0x622>
  if(link("dd/xx/ff", "dd/dd/xx") == 0){
    341c:	00004597          	auipc	a1,0x4
    3420:	f3458593          	addi	a1,a1,-204 # 7350 <malloc+0x174e>
    3424:	00004517          	auipc	a0,0x4
    3428:	e9c50513          	addi	a0,a0,-356 # 72c0 <malloc+0x16be>
    342c:	00002097          	auipc	ra,0x2
    3430:	404080e7          	jalr	1028(ra) # 5830 <link>
    3434:	3a050063          	beqz	a0,37d4 <subdir+0x63e>
  if(link("dd/ff", "dd/dd/ffff") == 0){
    3438:	00004597          	auipc	a1,0x4
    343c:	cd058593          	addi	a1,a1,-816 # 7108 <malloc+0x1506>
    3440:	00004517          	auipc	a0,0x4
    3444:	bc050513          	addi	a0,a0,-1088 # 7000 <malloc+0x13fe>
    3448:	00002097          	auipc	ra,0x2
    344c:	3e8080e7          	jalr	1000(ra) # 5830 <link>
    3450:	3a050063          	beqz	a0,37f0 <subdir+0x65a>
  if(mkdir("dd/ff/ff") == 0){
    3454:	00004517          	auipc	a0,0x4
    3458:	e3c50513          	addi	a0,a0,-452 # 7290 <malloc+0x168e>
    345c:	00002097          	auipc	ra,0x2
    3460:	3dc080e7          	jalr	988(ra) # 5838 <mkdir>
    3464:	3a050463          	beqz	a0,380c <subdir+0x676>
  if(mkdir("dd/xx/ff") == 0){
    3468:	00004517          	auipc	a0,0x4
    346c:	e5850513          	addi	a0,a0,-424 # 72c0 <malloc+0x16be>
    3470:	00002097          	auipc	ra,0x2
    3474:	3c8080e7          	jalr	968(ra) # 5838 <mkdir>
    3478:	3a050863          	beqz	a0,3828 <subdir+0x692>
  if(mkdir("dd/dd/ffff") == 0){
    347c:	00004517          	auipc	a0,0x4
    3480:	c8c50513          	addi	a0,a0,-884 # 7108 <malloc+0x1506>
    3484:	00002097          	auipc	ra,0x2
    3488:	3b4080e7          	jalr	948(ra) # 5838 <mkdir>
    348c:	3a050c63          	beqz	a0,3844 <subdir+0x6ae>
  if(unlink("dd/xx/ff") == 0){
    3490:	00004517          	auipc	a0,0x4
    3494:	e3050513          	addi	a0,a0,-464 # 72c0 <malloc+0x16be>
    3498:	00002097          	auipc	ra,0x2
    349c:	388080e7          	jalr	904(ra) # 5820 <unlink>
    34a0:	3c050063          	beqz	a0,3860 <subdir+0x6ca>
  if(unlink("dd/ff/ff") == 0){
    34a4:	00004517          	auipc	a0,0x4
    34a8:	dec50513          	addi	a0,a0,-532 # 7290 <malloc+0x168e>
    34ac:	00002097          	auipc	ra,0x2
    34b0:	374080e7          	jalr	884(ra) # 5820 <unlink>
    34b4:	3c050463          	beqz	a0,387c <subdir+0x6e6>
  if(chdir("dd/ff") == 0){
    34b8:	00004517          	auipc	a0,0x4
    34bc:	b4850513          	addi	a0,a0,-1208 # 7000 <malloc+0x13fe>
    34c0:	00002097          	auipc	ra,0x2
    34c4:	380080e7          	jalr	896(ra) # 5840 <chdir>
    34c8:	3c050863          	beqz	a0,3898 <subdir+0x702>
  if(chdir("dd/xx") == 0){
    34cc:	00004517          	auipc	a0,0x4
    34d0:	fd450513          	addi	a0,a0,-44 # 74a0 <malloc+0x189e>
    34d4:	00002097          	auipc	ra,0x2
    34d8:	36c080e7          	jalr	876(ra) # 5840 <chdir>
    34dc:	3c050c63          	beqz	a0,38b4 <subdir+0x71e>
  if(unlink("dd/dd/ffff") != 0){
    34e0:	00004517          	auipc	a0,0x4
    34e4:	c2850513          	addi	a0,a0,-984 # 7108 <malloc+0x1506>
    34e8:	00002097          	auipc	ra,0x2
    34ec:	338080e7          	jalr	824(ra) # 5820 <unlink>
    34f0:	3e051063          	bnez	a0,38d0 <subdir+0x73a>
  if(unlink("dd/ff") != 0){
    34f4:	00004517          	auipc	a0,0x4
    34f8:	b0c50513          	addi	a0,a0,-1268 # 7000 <malloc+0x13fe>
    34fc:	00002097          	auipc	ra,0x2
    3500:	324080e7          	jalr	804(ra) # 5820 <unlink>
    3504:	3e051463          	bnez	a0,38ec <subdir+0x756>
  if(unlink("dd") == 0){
    3508:	00004517          	auipc	a0,0x4
    350c:	ad850513          	addi	a0,a0,-1320 # 6fe0 <malloc+0x13de>
    3510:	00002097          	auipc	ra,0x2
    3514:	310080e7          	jalr	784(ra) # 5820 <unlink>
    3518:	3e050863          	beqz	a0,3908 <subdir+0x772>
  if(unlink("dd/dd") < 0){
    351c:	00004517          	auipc	a0,0x4
    3520:	ff450513          	addi	a0,a0,-12 # 7510 <malloc+0x190e>
    3524:	00002097          	auipc	ra,0x2
    3528:	2fc080e7          	jalr	764(ra) # 5820 <unlink>
    352c:	3e054c63          	bltz	a0,3924 <subdir+0x78e>
  if(unlink("dd") < 0){
    3530:	00004517          	auipc	a0,0x4
    3534:	ab050513          	addi	a0,a0,-1360 # 6fe0 <malloc+0x13de>
    3538:	00002097          	auipc	ra,0x2
    353c:	2e8080e7          	jalr	744(ra) # 5820 <unlink>
    3540:	40054063          	bltz	a0,3940 <subdir+0x7aa>
}
    3544:	60e2                	ld	ra,24(sp)
    3546:	6442                	ld	s0,16(sp)
    3548:	64a2                	ld	s1,8(sp)
    354a:	6902                	ld	s2,0(sp)
    354c:	6105                	addi	sp,sp,32
    354e:	8082                	ret
    printf("%s: mkdir dd failed\n", s);
    3550:	85ca                	mv	a1,s2
    3552:	00004517          	auipc	a0,0x4
    3556:	a9650513          	addi	a0,a0,-1386 # 6fe8 <malloc+0x13e6>
    355a:	00002097          	auipc	ra,0x2
    355e:	5f0080e7          	jalr	1520(ra) # 5b4a <printf>
    exit(1);
    3562:	4505                	li	a0,1
    3564:	00002097          	auipc	ra,0x2
    3568:	26c080e7          	jalr	620(ra) # 57d0 <exit>
    printf("%s: create dd/ff failed\n", s);
    356c:	85ca                	mv	a1,s2
    356e:	00004517          	auipc	a0,0x4
    3572:	a9a50513          	addi	a0,a0,-1382 # 7008 <malloc+0x1406>
    3576:	00002097          	auipc	ra,0x2
    357a:	5d4080e7          	jalr	1492(ra) # 5b4a <printf>
    exit(1);
    357e:	4505                	li	a0,1
    3580:	00002097          	auipc	ra,0x2
    3584:	250080e7          	jalr	592(ra) # 57d0 <exit>
    printf("%s: unlink dd (non-empty dir) succeeded!\n", s);
    3588:	85ca                	mv	a1,s2
    358a:	00004517          	auipc	a0,0x4
    358e:	a9e50513          	addi	a0,a0,-1378 # 7028 <malloc+0x1426>
    3592:	00002097          	auipc	ra,0x2
    3596:	5b8080e7          	jalr	1464(ra) # 5b4a <printf>
    exit(1);
    359a:	4505                	li	a0,1
    359c:	00002097          	auipc	ra,0x2
    35a0:	234080e7          	jalr	564(ra) # 57d0 <exit>
    printf("subdir mkdir dd/dd failed\n", s);
    35a4:	85ca                	mv	a1,s2
    35a6:	00004517          	auipc	a0,0x4
    35aa:	aba50513          	addi	a0,a0,-1350 # 7060 <malloc+0x145e>
    35ae:	00002097          	auipc	ra,0x2
    35b2:	59c080e7          	jalr	1436(ra) # 5b4a <printf>
    exit(1);
    35b6:	4505                	li	a0,1
    35b8:	00002097          	auipc	ra,0x2
    35bc:	218080e7          	jalr	536(ra) # 57d0 <exit>
    printf("%s: create dd/dd/ff failed\n", s);
    35c0:	85ca                	mv	a1,s2
    35c2:	00004517          	auipc	a0,0x4
    35c6:	ace50513          	addi	a0,a0,-1330 # 7090 <malloc+0x148e>
    35ca:	00002097          	auipc	ra,0x2
    35ce:	580080e7          	jalr	1408(ra) # 5b4a <printf>
    exit(1);
    35d2:	4505                	li	a0,1
    35d4:	00002097          	auipc	ra,0x2
    35d8:	1fc080e7          	jalr	508(ra) # 57d0 <exit>
    printf("%s: open dd/dd/../ff failed\n", s);
    35dc:	85ca                	mv	a1,s2
    35de:	00004517          	auipc	a0,0x4
    35e2:	aea50513          	addi	a0,a0,-1302 # 70c8 <malloc+0x14c6>
    35e6:	00002097          	auipc	ra,0x2
    35ea:	564080e7          	jalr	1380(ra) # 5b4a <printf>
    exit(1);
    35ee:	4505                	li	a0,1
    35f0:	00002097          	auipc	ra,0x2
    35f4:	1e0080e7          	jalr	480(ra) # 57d0 <exit>
    printf("%s: dd/dd/../ff wrong content\n", s);
    35f8:	85ca                	mv	a1,s2
    35fa:	00004517          	auipc	a0,0x4
    35fe:	aee50513          	addi	a0,a0,-1298 # 70e8 <malloc+0x14e6>
    3602:	00002097          	auipc	ra,0x2
    3606:	548080e7          	jalr	1352(ra) # 5b4a <printf>
    exit(1);
    360a:	4505                	li	a0,1
    360c:	00002097          	auipc	ra,0x2
    3610:	1c4080e7          	jalr	452(ra) # 57d0 <exit>
    printf("link dd/dd/ff dd/dd/ffff failed\n", s);
    3614:	85ca                	mv	a1,s2
    3616:	00004517          	auipc	a0,0x4
    361a:	b0250513          	addi	a0,a0,-1278 # 7118 <malloc+0x1516>
    361e:	00002097          	auipc	ra,0x2
    3622:	52c080e7          	jalr	1324(ra) # 5b4a <printf>
    exit(1);
    3626:	4505                	li	a0,1
    3628:	00002097          	auipc	ra,0x2
    362c:	1a8080e7          	jalr	424(ra) # 57d0 <exit>
    printf("%s: unlink dd/dd/ff failed\n", s);
    3630:	85ca                	mv	a1,s2
    3632:	00004517          	auipc	a0,0x4
    3636:	b0e50513          	addi	a0,a0,-1266 # 7140 <malloc+0x153e>
    363a:	00002097          	auipc	ra,0x2
    363e:	510080e7          	jalr	1296(ra) # 5b4a <printf>
    exit(1);
    3642:	4505                	li	a0,1
    3644:	00002097          	auipc	ra,0x2
    3648:	18c080e7          	jalr	396(ra) # 57d0 <exit>
    printf("%s: open (unlinked) dd/dd/ff succeeded\n", s);
    364c:	85ca                	mv	a1,s2
    364e:	00004517          	auipc	a0,0x4
    3652:	b1250513          	addi	a0,a0,-1262 # 7160 <malloc+0x155e>
    3656:	00002097          	auipc	ra,0x2
    365a:	4f4080e7          	jalr	1268(ra) # 5b4a <printf>
    exit(1);
    365e:	4505                	li	a0,1
    3660:	00002097          	auipc	ra,0x2
    3664:	170080e7          	jalr	368(ra) # 57d0 <exit>
    printf("%s: chdir dd failed\n", s);
    3668:	85ca                	mv	a1,s2
    366a:	00004517          	auipc	a0,0x4
    366e:	b1e50513          	addi	a0,a0,-1250 # 7188 <malloc+0x1586>
    3672:	00002097          	auipc	ra,0x2
    3676:	4d8080e7          	jalr	1240(ra) # 5b4a <printf>
    exit(1);
    367a:	4505                	li	a0,1
    367c:	00002097          	auipc	ra,0x2
    3680:	154080e7          	jalr	340(ra) # 57d0 <exit>
    printf("%s: chdir dd/../../dd failed\n", s);
    3684:	85ca                	mv	a1,s2
    3686:	00004517          	auipc	a0,0x4
    368a:	b2a50513          	addi	a0,a0,-1238 # 71b0 <malloc+0x15ae>
    368e:	00002097          	auipc	ra,0x2
    3692:	4bc080e7          	jalr	1212(ra) # 5b4a <printf>
    exit(1);
    3696:	4505                	li	a0,1
    3698:	00002097          	auipc	ra,0x2
    369c:	138080e7          	jalr	312(ra) # 57d0 <exit>
    printf("chdir dd/../../dd failed\n", s);
    36a0:	85ca                	mv	a1,s2
    36a2:	00004517          	auipc	a0,0x4
    36a6:	b3e50513          	addi	a0,a0,-1218 # 71e0 <malloc+0x15de>
    36aa:	00002097          	auipc	ra,0x2
    36ae:	4a0080e7          	jalr	1184(ra) # 5b4a <printf>
    exit(1);
    36b2:	4505                	li	a0,1
    36b4:	00002097          	auipc	ra,0x2
    36b8:	11c080e7          	jalr	284(ra) # 57d0 <exit>
    printf("%s: chdir ./.. failed\n", s);
    36bc:	85ca                	mv	a1,s2
    36be:	00004517          	auipc	a0,0x4
    36c2:	b4a50513          	addi	a0,a0,-1206 # 7208 <malloc+0x1606>
    36c6:	00002097          	auipc	ra,0x2
    36ca:	484080e7          	jalr	1156(ra) # 5b4a <printf>
    exit(1);
    36ce:	4505                	li	a0,1
    36d0:	00002097          	auipc	ra,0x2
    36d4:	100080e7          	jalr	256(ra) # 57d0 <exit>
    printf("%s: open dd/dd/ffff failed\n", s);
    36d8:	85ca                	mv	a1,s2
    36da:	00004517          	auipc	a0,0x4
    36de:	b4650513          	addi	a0,a0,-1210 # 7220 <malloc+0x161e>
    36e2:	00002097          	auipc	ra,0x2
    36e6:	468080e7          	jalr	1128(ra) # 5b4a <printf>
    exit(1);
    36ea:	4505                	li	a0,1
    36ec:	00002097          	auipc	ra,0x2
    36f0:	0e4080e7          	jalr	228(ra) # 57d0 <exit>
    printf("%s: read dd/dd/ffff wrong len\n", s);
    36f4:	85ca                	mv	a1,s2
    36f6:	00004517          	auipc	a0,0x4
    36fa:	b4a50513          	addi	a0,a0,-1206 # 7240 <malloc+0x163e>
    36fe:	00002097          	auipc	ra,0x2
    3702:	44c080e7          	jalr	1100(ra) # 5b4a <printf>
    exit(1);
    3706:	4505                	li	a0,1
    3708:	00002097          	auipc	ra,0x2
    370c:	0c8080e7          	jalr	200(ra) # 57d0 <exit>
    printf("%s: open (unlinked) dd/dd/ff succeeded!\n", s);
    3710:	85ca                	mv	a1,s2
    3712:	00004517          	auipc	a0,0x4
    3716:	b4e50513          	addi	a0,a0,-1202 # 7260 <malloc+0x165e>
    371a:	00002097          	auipc	ra,0x2
    371e:	430080e7          	jalr	1072(ra) # 5b4a <printf>
    exit(1);
    3722:	4505                	li	a0,1
    3724:	00002097          	auipc	ra,0x2
    3728:	0ac080e7          	jalr	172(ra) # 57d0 <exit>
    printf("%s: create dd/ff/ff succeeded!\n", s);
    372c:	85ca                	mv	a1,s2
    372e:	00004517          	auipc	a0,0x4
    3732:	b7250513          	addi	a0,a0,-1166 # 72a0 <malloc+0x169e>
    3736:	00002097          	auipc	ra,0x2
    373a:	414080e7          	jalr	1044(ra) # 5b4a <printf>
    exit(1);
    373e:	4505                	li	a0,1
    3740:	00002097          	auipc	ra,0x2
    3744:	090080e7          	jalr	144(ra) # 57d0 <exit>
    printf("%s: create dd/xx/ff succeeded!\n", s);
    3748:	85ca                	mv	a1,s2
    374a:	00004517          	auipc	a0,0x4
    374e:	b8650513          	addi	a0,a0,-1146 # 72d0 <malloc+0x16ce>
    3752:	00002097          	auipc	ra,0x2
    3756:	3f8080e7          	jalr	1016(ra) # 5b4a <printf>
    exit(1);
    375a:	4505                	li	a0,1
    375c:	00002097          	auipc	ra,0x2
    3760:	074080e7          	jalr	116(ra) # 57d0 <exit>
    printf("%s: create dd succeeded!\n", s);
    3764:	85ca                	mv	a1,s2
    3766:	00004517          	auipc	a0,0x4
    376a:	b8a50513          	addi	a0,a0,-1142 # 72f0 <malloc+0x16ee>
    376e:	00002097          	auipc	ra,0x2
    3772:	3dc080e7          	jalr	988(ra) # 5b4a <printf>
    exit(1);
    3776:	4505                	li	a0,1
    3778:	00002097          	auipc	ra,0x2
    377c:	058080e7          	jalr	88(ra) # 57d0 <exit>
    printf("%s: open dd rdwr succeeded!\n", s);
    3780:	85ca                	mv	a1,s2
    3782:	00004517          	auipc	a0,0x4
    3786:	b8e50513          	addi	a0,a0,-1138 # 7310 <malloc+0x170e>
    378a:	00002097          	auipc	ra,0x2
    378e:	3c0080e7          	jalr	960(ra) # 5b4a <printf>
    exit(1);
    3792:	4505                	li	a0,1
    3794:	00002097          	auipc	ra,0x2
    3798:	03c080e7          	jalr	60(ra) # 57d0 <exit>
    printf("%s: open dd wronly succeeded!\n", s);
    379c:	85ca                	mv	a1,s2
    379e:	00004517          	auipc	a0,0x4
    37a2:	b9250513          	addi	a0,a0,-1134 # 7330 <malloc+0x172e>
    37a6:	00002097          	auipc	ra,0x2
    37aa:	3a4080e7          	jalr	932(ra) # 5b4a <printf>
    exit(1);
    37ae:	4505                	li	a0,1
    37b0:	00002097          	auipc	ra,0x2
    37b4:	020080e7          	jalr	32(ra) # 57d0 <exit>
    printf("%s: link dd/ff/ff dd/dd/xx succeeded!\n", s);
    37b8:	85ca                	mv	a1,s2
    37ba:	00004517          	auipc	a0,0x4
    37be:	ba650513          	addi	a0,a0,-1114 # 7360 <malloc+0x175e>
    37c2:	00002097          	auipc	ra,0x2
    37c6:	388080e7          	jalr	904(ra) # 5b4a <printf>
    exit(1);
    37ca:	4505                	li	a0,1
    37cc:	00002097          	auipc	ra,0x2
    37d0:	004080e7          	jalr	4(ra) # 57d0 <exit>
    printf("%s: link dd/xx/ff dd/dd/xx succeeded!\n", s);
    37d4:	85ca                	mv	a1,s2
    37d6:	00004517          	auipc	a0,0x4
    37da:	bb250513          	addi	a0,a0,-1102 # 7388 <malloc+0x1786>
    37de:	00002097          	auipc	ra,0x2
    37e2:	36c080e7          	jalr	876(ra) # 5b4a <printf>
    exit(1);
    37e6:	4505                	li	a0,1
    37e8:	00002097          	auipc	ra,0x2
    37ec:	fe8080e7          	jalr	-24(ra) # 57d0 <exit>
    printf("%s: link dd/ff dd/dd/ffff succeeded!\n", s);
    37f0:	85ca                	mv	a1,s2
    37f2:	00004517          	auipc	a0,0x4
    37f6:	bbe50513          	addi	a0,a0,-1090 # 73b0 <malloc+0x17ae>
    37fa:	00002097          	auipc	ra,0x2
    37fe:	350080e7          	jalr	848(ra) # 5b4a <printf>
    exit(1);
    3802:	4505                	li	a0,1
    3804:	00002097          	auipc	ra,0x2
    3808:	fcc080e7          	jalr	-52(ra) # 57d0 <exit>
    printf("%s: mkdir dd/ff/ff succeeded!\n", s);
    380c:	85ca                	mv	a1,s2
    380e:	00004517          	auipc	a0,0x4
    3812:	bca50513          	addi	a0,a0,-1078 # 73d8 <malloc+0x17d6>
    3816:	00002097          	auipc	ra,0x2
    381a:	334080e7          	jalr	820(ra) # 5b4a <printf>
    exit(1);
    381e:	4505                	li	a0,1
    3820:	00002097          	auipc	ra,0x2
    3824:	fb0080e7          	jalr	-80(ra) # 57d0 <exit>
    printf("%s: mkdir dd/xx/ff succeeded!\n", s);
    3828:	85ca                	mv	a1,s2
    382a:	00004517          	auipc	a0,0x4
    382e:	bce50513          	addi	a0,a0,-1074 # 73f8 <malloc+0x17f6>
    3832:	00002097          	auipc	ra,0x2
    3836:	318080e7          	jalr	792(ra) # 5b4a <printf>
    exit(1);
    383a:	4505                	li	a0,1
    383c:	00002097          	auipc	ra,0x2
    3840:	f94080e7          	jalr	-108(ra) # 57d0 <exit>
    printf("%s: mkdir dd/dd/ffff succeeded!\n", s);
    3844:	85ca                	mv	a1,s2
    3846:	00004517          	auipc	a0,0x4
    384a:	bd250513          	addi	a0,a0,-1070 # 7418 <malloc+0x1816>
    384e:	00002097          	auipc	ra,0x2
    3852:	2fc080e7          	jalr	764(ra) # 5b4a <printf>
    exit(1);
    3856:	4505                	li	a0,1
    3858:	00002097          	auipc	ra,0x2
    385c:	f78080e7          	jalr	-136(ra) # 57d0 <exit>
    printf("%s: unlink dd/xx/ff succeeded!\n", s);
    3860:	85ca                	mv	a1,s2
    3862:	00004517          	auipc	a0,0x4
    3866:	bde50513          	addi	a0,a0,-1058 # 7440 <malloc+0x183e>
    386a:	00002097          	auipc	ra,0x2
    386e:	2e0080e7          	jalr	736(ra) # 5b4a <printf>
    exit(1);
    3872:	4505                	li	a0,1
    3874:	00002097          	auipc	ra,0x2
    3878:	f5c080e7          	jalr	-164(ra) # 57d0 <exit>
    printf("%s: unlink dd/ff/ff succeeded!\n", s);
    387c:	85ca                	mv	a1,s2
    387e:	00004517          	auipc	a0,0x4
    3882:	be250513          	addi	a0,a0,-1054 # 7460 <malloc+0x185e>
    3886:	00002097          	auipc	ra,0x2
    388a:	2c4080e7          	jalr	708(ra) # 5b4a <printf>
    exit(1);
    388e:	4505                	li	a0,1
    3890:	00002097          	auipc	ra,0x2
    3894:	f40080e7          	jalr	-192(ra) # 57d0 <exit>
    printf("%s: chdir dd/ff succeeded!\n", s);
    3898:	85ca                	mv	a1,s2
    389a:	00004517          	auipc	a0,0x4
    389e:	be650513          	addi	a0,a0,-1050 # 7480 <malloc+0x187e>
    38a2:	00002097          	auipc	ra,0x2
    38a6:	2a8080e7          	jalr	680(ra) # 5b4a <printf>
    exit(1);
    38aa:	4505                	li	a0,1
    38ac:	00002097          	auipc	ra,0x2
    38b0:	f24080e7          	jalr	-220(ra) # 57d0 <exit>
    printf("%s: chdir dd/xx succeeded!\n", s);
    38b4:	85ca                	mv	a1,s2
    38b6:	00004517          	auipc	a0,0x4
    38ba:	bf250513          	addi	a0,a0,-1038 # 74a8 <malloc+0x18a6>
    38be:	00002097          	auipc	ra,0x2
    38c2:	28c080e7          	jalr	652(ra) # 5b4a <printf>
    exit(1);
    38c6:	4505                	li	a0,1
    38c8:	00002097          	auipc	ra,0x2
    38cc:	f08080e7          	jalr	-248(ra) # 57d0 <exit>
    printf("%s: unlink dd/dd/ff failed\n", s);
    38d0:	85ca                	mv	a1,s2
    38d2:	00004517          	auipc	a0,0x4
    38d6:	86e50513          	addi	a0,a0,-1938 # 7140 <malloc+0x153e>
    38da:	00002097          	auipc	ra,0x2
    38de:	270080e7          	jalr	624(ra) # 5b4a <printf>
    exit(1);
    38e2:	4505                	li	a0,1
    38e4:	00002097          	auipc	ra,0x2
    38e8:	eec080e7          	jalr	-276(ra) # 57d0 <exit>
    printf("%s: unlink dd/ff failed\n", s);
    38ec:	85ca                	mv	a1,s2
    38ee:	00004517          	auipc	a0,0x4
    38f2:	bda50513          	addi	a0,a0,-1062 # 74c8 <malloc+0x18c6>
    38f6:	00002097          	auipc	ra,0x2
    38fa:	254080e7          	jalr	596(ra) # 5b4a <printf>
    exit(1);
    38fe:	4505                	li	a0,1
    3900:	00002097          	auipc	ra,0x2
    3904:	ed0080e7          	jalr	-304(ra) # 57d0 <exit>
    printf("%s: unlink non-empty dd succeeded!\n", s);
    3908:	85ca                	mv	a1,s2
    390a:	00004517          	auipc	a0,0x4
    390e:	bde50513          	addi	a0,a0,-1058 # 74e8 <malloc+0x18e6>
    3912:	00002097          	auipc	ra,0x2
    3916:	238080e7          	jalr	568(ra) # 5b4a <printf>
    exit(1);
    391a:	4505                	li	a0,1
    391c:	00002097          	auipc	ra,0x2
    3920:	eb4080e7          	jalr	-332(ra) # 57d0 <exit>
    printf("%s: unlink dd/dd failed\n", s);
    3924:	85ca                	mv	a1,s2
    3926:	00004517          	auipc	a0,0x4
    392a:	bf250513          	addi	a0,a0,-1038 # 7518 <malloc+0x1916>
    392e:	00002097          	auipc	ra,0x2
    3932:	21c080e7          	jalr	540(ra) # 5b4a <printf>
    exit(1);
    3936:	4505                	li	a0,1
    3938:	00002097          	auipc	ra,0x2
    393c:	e98080e7          	jalr	-360(ra) # 57d0 <exit>
    printf("%s: unlink dd failed\n", s);
    3940:	85ca                	mv	a1,s2
    3942:	00004517          	auipc	a0,0x4
    3946:	bf650513          	addi	a0,a0,-1034 # 7538 <malloc+0x1936>
    394a:	00002097          	auipc	ra,0x2
    394e:	200080e7          	jalr	512(ra) # 5b4a <printf>
    exit(1);
    3952:	4505                	li	a0,1
    3954:	00002097          	auipc	ra,0x2
    3958:	e7c080e7          	jalr	-388(ra) # 57d0 <exit>

000000000000395c <rmdot>:
{
    395c:	1101                	addi	sp,sp,-32
    395e:	ec06                	sd	ra,24(sp)
    3960:	e822                	sd	s0,16(sp)
    3962:	e426                	sd	s1,8(sp)
    3964:	1000                	addi	s0,sp,32
    3966:	84aa                	mv	s1,a0
  if(mkdir("dots") != 0){
    3968:	00004517          	auipc	a0,0x4
    396c:	be850513          	addi	a0,a0,-1048 # 7550 <malloc+0x194e>
    3970:	00002097          	auipc	ra,0x2
    3974:	ec8080e7          	jalr	-312(ra) # 5838 <mkdir>
    3978:	e549                	bnez	a0,3a02 <rmdot+0xa6>
  if(chdir("dots") != 0){
    397a:	00004517          	auipc	a0,0x4
    397e:	bd650513          	addi	a0,a0,-1066 # 7550 <malloc+0x194e>
    3982:	00002097          	auipc	ra,0x2
    3986:	ebe080e7          	jalr	-322(ra) # 5840 <chdir>
    398a:	e951                	bnez	a0,3a1e <rmdot+0xc2>
  if(unlink(".") == 0){
    398c:	00003517          	auipc	a0,0x3
    3990:	a6c50513          	addi	a0,a0,-1428 # 63f8 <malloc+0x7f6>
    3994:	00002097          	auipc	ra,0x2
    3998:	e8c080e7          	jalr	-372(ra) # 5820 <unlink>
    399c:	cd59                	beqz	a0,3a3a <rmdot+0xde>
  if(unlink("..") == 0){
    399e:	00003517          	auipc	a0,0x3
    39a2:	60a50513          	addi	a0,a0,1546 # 6fa8 <malloc+0x13a6>
    39a6:	00002097          	auipc	ra,0x2
    39aa:	e7a080e7          	jalr	-390(ra) # 5820 <unlink>
    39ae:	c545                	beqz	a0,3a56 <rmdot+0xfa>
  if(chdir("/") != 0){
    39b0:	00003517          	auipc	a0,0x3
    39b4:	5a050513          	addi	a0,a0,1440 # 6f50 <malloc+0x134e>
    39b8:	00002097          	auipc	ra,0x2
    39bc:	e88080e7          	jalr	-376(ra) # 5840 <chdir>
    39c0:	e94d                	bnez	a0,3a72 <rmdot+0x116>
  if(unlink("dots/.") == 0){
    39c2:	00004517          	auipc	a0,0x4
    39c6:	bf650513          	addi	a0,a0,-1034 # 75b8 <malloc+0x19b6>
    39ca:	00002097          	auipc	ra,0x2
    39ce:	e56080e7          	jalr	-426(ra) # 5820 <unlink>
    39d2:	cd55                	beqz	a0,3a8e <rmdot+0x132>
  if(unlink("dots/..") == 0){
    39d4:	00004517          	auipc	a0,0x4
    39d8:	c0c50513          	addi	a0,a0,-1012 # 75e0 <malloc+0x19de>
    39dc:	00002097          	auipc	ra,0x2
    39e0:	e44080e7          	jalr	-444(ra) # 5820 <unlink>
    39e4:	c179                	beqz	a0,3aaa <rmdot+0x14e>
  if(unlink("dots") != 0){
    39e6:	00004517          	auipc	a0,0x4
    39ea:	b6a50513          	addi	a0,a0,-1174 # 7550 <malloc+0x194e>
    39ee:	00002097          	auipc	ra,0x2
    39f2:	e32080e7          	jalr	-462(ra) # 5820 <unlink>
    39f6:	e961                	bnez	a0,3ac6 <rmdot+0x16a>
}
    39f8:	60e2                	ld	ra,24(sp)
    39fa:	6442                	ld	s0,16(sp)
    39fc:	64a2                	ld	s1,8(sp)
    39fe:	6105                	addi	sp,sp,32
    3a00:	8082                	ret
    printf("%s: mkdir dots failed\n", s);
    3a02:	85a6                	mv	a1,s1
    3a04:	00004517          	auipc	a0,0x4
    3a08:	b5450513          	addi	a0,a0,-1196 # 7558 <malloc+0x1956>
    3a0c:	00002097          	auipc	ra,0x2
    3a10:	13e080e7          	jalr	318(ra) # 5b4a <printf>
    exit(1);
    3a14:	4505                	li	a0,1
    3a16:	00002097          	auipc	ra,0x2
    3a1a:	dba080e7          	jalr	-582(ra) # 57d0 <exit>
    printf("%s: chdir dots failed\n", s);
    3a1e:	85a6                	mv	a1,s1
    3a20:	00004517          	auipc	a0,0x4
    3a24:	b5050513          	addi	a0,a0,-1200 # 7570 <malloc+0x196e>
    3a28:	00002097          	auipc	ra,0x2
    3a2c:	122080e7          	jalr	290(ra) # 5b4a <printf>
    exit(1);
    3a30:	4505                	li	a0,1
    3a32:	00002097          	auipc	ra,0x2
    3a36:	d9e080e7          	jalr	-610(ra) # 57d0 <exit>
    printf("%s: rm . worked!\n", s);
    3a3a:	85a6                	mv	a1,s1
    3a3c:	00004517          	auipc	a0,0x4
    3a40:	b4c50513          	addi	a0,a0,-1204 # 7588 <malloc+0x1986>
    3a44:	00002097          	auipc	ra,0x2
    3a48:	106080e7          	jalr	262(ra) # 5b4a <printf>
    exit(1);
    3a4c:	4505                	li	a0,1
    3a4e:	00002097          	auipc	ra,0x2
    3a52:	d82080e7          	jalr	-638(ra) # 57d0 <exit>
    printf("%s: rm .. worked!\n", s);
    3a56:	85a6                	mv	a1,s1
    3a58:	00004517          	auipc	a0,0x4
    3a5c:	b4850513          	addi	a0,a0,-1208 # 75a0 <malloc+0x199e>
    3a60:	00002097          	auipc	ra,0x2
    3a64:	0ea080e7          	jalr	234(ra) # 5b4a <printf>
    exit(1);
    3a68:	4505                	li	a0,1
    3a6a:	00002097          	auipc	ra,0x2
    3a6e:	d66080e7          	jalr	-666(ra) # 57d0 <exit>
    printf("%s: chdir / failed\n", s);
    3a72:	85a6                	mv	a1,s1
    3a74:	00003517          	auipc	a0,0x3
    3a78:	4e450513          	addi	a0,a0,1252 # 6f58 <malloc+0x1356>
    3a7c:	00002097          	auipc	ra,0x2
    3a80:	0ce080e7          	jalr	206(ra) # 5b4a <printf>
    exit(1);
    3a84:	4505                	li	a0,1
    3a86:	00002097          	auipc	ra,0x2
    3a8a:	d4a080e7          	jalr	-694(ra) # 57d0 <exit>
    printf("%s: unlink dots/. worked!\n", s);
    3a8e:	85a6                	mv	a1,s1
    3a90:	00004517          	auipc	a0,0x4
    3a94:	b3050513          	addi	a0,a0,-1232 # 75c0 <malloc+0x19be>
    3a98:	00002097          	auipc	ra,0x2
    3a9c:	0b2080e7          	jalr	178(ra) # 5b4a <printf>
    exit(1);
    3aa0:	4505                	li	a0,1
    3aa2:	00002097          	auipc	ra,0x2
    3aa6:	d2e080e7          	jalr	-722(ra) # 57d0 <exit>
    printf("%s: unlink dots/.. worked!\n", s);
    3aaa:	85a6                	mv	a1,s1
    3aac:	00004517          	auipc	a0,0x4
    3ab0:	b3c50513          	addi	a0,a0,-1220 # 75e8 <malloc+0x19e6>
    3ab4:	00002097          	auipc	ra,0x2
    3ab8:	096080e7          	jalr	150(ra) # 5b4a <printf>
    exit(1);
    3abc:	4505                	li	a0,1
    3abe:	00002097          	auipc	ra,0x2
    3ac2:	d12080e7          	jalr	-750(ra) # 57d0 <exit>
    printf("%s: unlink dots failed!\n", s);
    3ac6:	85a6                	mv	a1,s1
    3ac8:	00004517          	auipc	a0,0x4
    3acc:	b4050513          	addi	a0,a0,-1216 # 7608 <malloc+0x1a06>
    3ad0:	00002097          	auipc	ra,0x2
    3ad4:	07a080e7          	jalr	122(ra) # 5b4a <printf>
    exit(1);
    3ad8:	4505                	li	a0,1
    3ada:	00002097          	auipc	ra,0x2
    3ade:	cf6080e7          	jalr	-778(ra) # 57d0 <exit>

0000000000003ae2 <dirfile>:
{
    3ae2:	1101                	addi	sp,sp,-32
    3ae4:	ec06                	sd	ra,24(sp)
    3ae6:	e822                	sd	s0,16(sp)
    3ae8:	e426                	sd	s1,8(sp)
    3aea:	e04a                	sd	s2,0(sp)
    3aec:	1000                	addi	s0,sp,32
    3aee:	892a                	mv	s2,a0
  fd = open("dirfile", O_CREATE);
    3af0:	20000593          	li	a1,512
    3af4:	00004517          	auipc	a0,0x4
    3af8:	b3450513          	addi	a0,a0,-1228 # 7628 <malloc+0x1a26>
    3afc:	00002097          	auipc	ra,0x2
    3b00:	d14080e7          	jalr	-748(ra) # 5810 <open>
  if(fd < 0){
    3b04:	0e054d63          	bltz	a0,3bfe <dirfile+0x11c>
  close(fd);
    3b08:	00002097          	auipc	ra,0x2
    3b0c:	cf0080e7          	jalr	-784(ra) # 57f8 <close>
  if(chdir("dirfile") == 0){
    3b10:	00004517          	auipc	a0,0x4
    3b14:	b1850513          	addi	a0,a0,-1256 # 7628 <malloc+0x1a26>
    3b18:	00002097          	auipc	ra,0x2
    3b1c:	d28080e7          	jalr	-728(ra) # 5840 <chdir>
    3b20:	cd6d                	beqz	a0,3c1a <dirfile+0x138>
  fd = open("dirfile/xx", 0);
    3b22:	4581                	li	a1,0
    3b24:	00004517          	auipc	a0,0x4
    3b28:	b4c50513          	addi	a0,a0,-1204 # 7670 <malloc+0x1a6e>
    3b2c:	00002097          	auipc	ra,0x2
    3b30:	ce4080e7          	jalr	-796(ra) # 5810 <open>
  if(fd >= 0){
    3b34:	10055163          	bgez	a0,3c36 <dirfile+0x154>
  fd = open("dirfile/xx", O_CREATE);
    3b38:	20000593          	li	a1,512
    3b3c:	00004517          	auipc	a0,0x4
    3b40:	b3450513          	addi	a0,a0,-1228 # 7670 <malloc+0x1a6e>
    3b44:	00002097          	auipc	ra,0x2
    3b48:	ccc080e7          	jalr	-820(ra) # 5810 <open>
  if(fd >= 0){
    3b4c:	10055363          	bgez	a0,3c52 <dirfile+0x170>
  if(mkdir("dirfile/xx") == 0){
    3b50:	00004517          	auipc	a0,0x4
    3b54:	b2050513          	addi	a0,a0,-1248 # 7670 <malloc+0x1a6e>
    3b58:	00002097          	auipc	ra,0x2
    3b5c:	ce0080e7          	jalr	-800(ra) # 5838 <mkdir>
    3b60:	10050763          	beqz	a0,3c6e <dirfile+0x18c>
  if(unlink("dirfile/xx") == 0){
    3b64:	00004517          	auipc	a0,0x4
    3b68:	b0c50513          	addi	a0,a0,-1268 # 7670 <malloc+0x1a6e>
    3b6c:	00002097          	auipc	ra,0x2
    3b70:	cb4080e7          	jalr	-844(ra) # 5820 <unlink>
    3b74:	10050b63          	beqz	a0,3c8a <dirfile+0x1a8>
  if(link("README", "dirfile/xx") == 0){
    3b78:	00004597          	auipc	a1,0x4
    3b7c:	af858593          	addi	a1,a1,-1288 # 7670 <malloc+0x1a6e>
    3b80:	00002517          	auipc	a0,0x2
    3b84:	36850513          	addi	a0,a0,872 # 5ee8 <malloc+0x2e6>
    3b88:	00002097          	auipc	ra,0x2
    3b8c:	ca8080e7          	jalr	-856(ra) # 5830 <link>
    3b90:	10050b63          	beqz	a0,3ca6 <dirfile+0x1c4>
  if(unlink("dirfile") != 0){
    3b94:	00004517          	auipc	a0,0x4
    3b98:	a9450513          	addi	a0,a0,-1388 # 7628 <malloc+0x1a26>
    3b9c:	00002097          	auipc	ra,0x2
    3ba0:	c84080e7          	jalr	-892(ra) # 5820 <unlink>
    3ba4:	10051f63          	bnez	a0,3cc2 <dirfile+0x1e0>
  fd = open(".", O_RDWR);
    3ba8:	4589                	li	a1,2
    3baa:	00003517          	auipc	a0,0x3
    3bae:	84e50513          	addi	a0,a0,-1970 # 63f8 <malloc+0x7f6>
    3bb2:	00002097          	auipc	ra,0x2
    3bb6:	c5e080e7          	jalr	-930(ra) # 5810 <open>
  if(fd >= 0){
    3bba:	12055263          	bgez	a0,3cde <dirfile+0x1fc>
  fd = open(".", 0);
    3bbe:	4581                	li	a1,0
    3bc0:	00003517          	auipc	a0,0x3
    3bc4:	83850513          	addi	a0,a0,-1992 # 63f8 <malloc+0x7f6>
    3bc8:	00002097          	auipc	ra,0x2
    3bcc:	c48080e7          	jalr	-952(ra) # 5810 <open>
    3bd0:	84aa                	mv	s1,a0
  if(write(fd, "x", 1) > 0){
    3bd2:	4605                	li	a2,1
    3bd4:	00002597          	auipc	a1,0x2
    3bd8:	1bc58593          	addi	a1,a1,444 # 5d90 <malloc+0x18e>
    3bdc:	00002097          	auipc	ra,0x2
    3be0:	c14080e7          	jalr	-1004(ra) # 57f0 <write>
    3be4:	10a04b63          	bgtz	a0,3cfa <dirfile+0x218>
  close(fd);
    3be8:	8526                	mv	a0,s1
    3bea:	00002097          	auipc	ra,0x2
    3bee:	c0e080e7          	jalr	-1010(ra) # 57f8 <close>
}
    3bf2:	60e2                	ld	ra,24(sp)
    3bf4:	6442                	ld	s0,16(sp)
    3bf6:	64a2                	ld	s1,8(sp)
    3bf8:	6902                	ld	s2,0(sp)
    3bfa:	6105                	addi	sp,sp,32
    3bfc:	8082                	ret
    printf("%s: create dirfile failed\n", s);
    3bfe:	85ca                	mv	a1,s2
    3c00:	00004517          	auipc	a0,0x4
    3c04:	a3050513          	addi	a0,a0,-1488 # 7630 <malloc+0x1a2e>
    3c08:	00002097          	auipc	ra,0x2
    3c0c:	f42080e7          	jalr	-190(ra) # 5b4a <printf>
    exit(1);
    3c10:	4505                	li	a0,1
    3c12:	00002097          	auipc	ra,0x2
    3c16:	bbe080e7          	jalr	-1090(ra) # 57d0 <exit>
    printf("%s: chdir dirfile succeeded!\n", s);
    3c1a:	85ca                	mv	a1,s2
    3c1c:	00004517          	auipc	a0,0x4
    3c20:	a3450513          	addi	a0,a0,-1484 # 7650 <malloc+0x1a4e>
    3c24:	00002097          	auipc	ra,0x2
    3c28:	f26080e7          	jalr	-218(ra) # 5b4a <printf>
    exit(1);
    3c2c:	4505                	li	a0,1
    3c2e:	00002097          	auipc	ra,0x2
    3c32:	ba2080e7          	jalr	-1118(ra) # 57d0 <exit>
    printf("%s: create dirfile/xx succeeded!\n", s);
    3c36:	85ca                	mv	a1,s2
    3c38:	00004517          	auipc	a0,0x4
    3c3c:	a4850513          	addi	a0,a0,-1464 # 7680 <malloc+0x1a7e>
    3c40:	00002097          	auipc	ra,0x2
    3c44:	f0a080e7          	jalr	-246(ra) # 5b4a <printf>
    exit(1);
    3c48:	4505                	li	a0,1
    3c4a:	00002097          	auipc	ra,0x2
    3c4e:	b86080e7          	jalr	-1146(ra) # 57d0 <exit>
    printf("%s: create dirfile/xx succeeded!\n", s);
    3c52:	85ca                	mv	a1,s2
    3c54:	00004517          	auipc	a0,0x4
    3c58:	a2c50513          	addi	a0,a0,-1492 # 7680 <malloc+0x1a7e>
    3c5c:	00002097          	auipc	ra,0x2
    3c60:	eee080e7          	jalr	-274(ra) # 5b4a <printf>
    exit(1);
    3c64:	4505                	li	a0,1
    3c66:	00002097          	auipc	ra,0x2
    3c6a:	b6a080e7          	jalr	-1174(ra) # 57d0 <exit>
    printf("%s: mkdir dirfile/xx succeeded!\n", s);
    3c6e:	85ca                	mv	a1,s2
    3c70:	00004517          	auipc	a0,0x4
    3c74:	a3850513          	addi	a0,a0,-1480 # 76a8 <malloc+0x1aa6>
    3c78:	00002097          	auipc	ra,0x2
    3c7c:	ed2080e7          	jalr	-302(ra) # 5b4a <printf>
    exit(1);
    3c80:	4505                	li	a0,1
    3c82:	00002097          	auipc	ra,0x2
    3c86:	b4e080e7          	jalr	-1202(ra) # 57d0 <exit>
    printf("%s: unlink dirfile/xx succeeded!\n", s);
    3c8a:	85ca                	mv	a1,s2
    3c8c:	00004517          	auipc	a0,0x4
    3c90:	a4450513          	addi	a0,a0,-1468 # 76d0 <malloc+0x1ace>
    3c94:	00002097          	auipc	ra,0x2
    3c98:	eb6080e7          	jalr	-330(ra) # 5b4a <printf>
    exit(1);
    3c9c:	4505                	li	a0,1
    3c9e:	00002097          	auipc	ra,0x2
    3ca2:	b32080e7          	jalr	-1230(ra) # 57d0 <exit>
    printf("%s: link to dirfile/xx succeeded!\n", s);
    3ca6:	85ca                	mv	a1,s2
    3ca8:	00004517          	auipc	a0,0x4
    3cac:	a5050513          	addi	a0,a0,-1456 # 76f8 <malloc+0x1af6>
    3cb0:	00002097          	auipc	ra,0x2
    3cb4:	e9a080e7          	jalr	-358(ra) # 5b4a <printf>
    exit(1);
    3cb8:	4505                	li	a0,1
    3cba:	00002097          	auipc	ra,0x2
    3cbe:	b16080e7          	jalr	-1258(ra) # 57d0 <exit>
    printf("%s: unlink dirfile failed!\n", s);
    3cc2:	85ca                	mv	a1,s2
    3cc4:	00004517          	auipc	a0,0x4
    3cc8:	a5c50513          	addi	a0,a0,-1444 # 7720 <malloc+0x1b1e>
    3ccc:	00002097          	auipc	ra,0x2
    3cd0:	e7e080e7          	jalr	-386(ra) # 5b4a <printf>
    exit(1);
    3cd4:	4505                	li	a0,1
    3cd6:	00002097          	auipc	ra,0x2
    3cda:	afa080e7          	jalr	-1286(ra) # 57d0 <exit>
    printf("%s: open . for writing succeeded!\n", s);
    3cde:	85ca                	mv	a1,s2
    3ce0:	00004517          	auipc	a0,0x4
    3ce4:	a6050513          	addi	a0,a0,-1440 # 7740 <malloc+0x1b3e>
    3ce8:	00002097          	auipc	ra,0x2
    3cec:	e62080e7          	jalr	-414(ra) # 5b4a <printf>
    exit(1);
    3cf0:	4505                	li	a0,1
    3cf2:	00002097          	auipc	ra,0x2
    3cf6:	ade080e7          	jalr	-1314(ra) # 57d0 <exit>
    printf("%s: write . succeeded!\n", s);
    3cfa:	85ca                	mv	a1,s2
    3cfc:	00004517          	auipc	a0,0x4
    3d00:	a6c50513          	addi	a0,a0,-1428 # 7768 <malloc+0x1b66>
    3d04:	00002097          	auipc	ra,0x2
    3d08:	e46080e7          	jalr	-442(ra) # 5b4a <printf>
    exit(1);
    3d0c:	4505                	li	a0,1
    3d0e:	00002097          	auipc	ra,0x2
    3d12:	ac2080e7          	jalr	-1342(ra) # 57d0 <exit>

0000000000003d16 <iref>:
{
    3d16:	7139                	addi	sp,sp,-64
    3d18:	fc06                	sd	ra,56(sp)
    3d1a:	f822                	sd	s0,48(sp)
    3d1c:	f426                	sd	s1,40(sp)
    3d1e:	f04a                	sd	s2,32(sp)
    3d20:	ec4e                	sd	s3,24(sp)
    3d22:	e852                	sd	s4,16(sp)
    3d24:	e456                	sd	s5,8(sp)
    3d26:	e05a                	sd	s6,0(sp)
    3d28:	0080                	addi	s0,sp,64
    3d2a:	8b2a                	mv	s6,a0
    3d2c:	03300913          	li	s2,51
    if(mkdir("irefd") != 0){
    3d30:	00004a17          	auipc	s4,0x4
    3d34:	a50a0a13          	addi	s4,s4,-1456 # 7780 <malloc+0x1b7e>
    mkdir("");
    3d38:	00003497          	auipc	s1,0x3
    3d3c:	55048493          	addi	s1,s1,1360 # 7288 <malloc+0x1686>
    link("README", "");
    3d40:	00002a97          	auipc	s5,0x2
    3d44:	1a8a8a93          	addi	s5,s5,424 # 5ee8 <malloc+0x2e6>
    fd = open("xx", O_CREATE);
    3d48:	00004997          	auipc	s3,0x4
    3d4c:	93098993          	addi	s3,s3,-1744 # 7678 <malloc+0x1a76>
    3d50:	a891                	j	3da4 <iref+0x8e>
      printf("%s: mkdir irefd failed\n", s);
    3d52:	85da                	mv	a1,s6
    3d54:	00004517          	auipc	a0,0x4
    3d58:	a3450513          	addi	a0,a0,-1484 # 7788 <malloc+0x1b86>
    3d5c:	00002097          	auipc	ra,0x2
    3d60:	dee080e7          	jalr	-530(ra) # 5b4a <printf>
      exit(1);
    3d64:	4505                	li	a0,1
    3d66:	00002097          	auipc	ra,0x2
    3d6a:	a6a080e7          	jalr	-1430(ra) # 57d0 <exit>
      printf("%s: chdir irefd failed\n", s);
    3d6e:	85da                	mv	a1,s6
    3d70:	00004517          	auipc	a0,0x4
    3d74:	a3050513          	addi	a0,a0,-1488 # 77a0 <malloc+0x1b9e>
    3d78:	00002097          	auipc	ra,0x2
    3d7c:	dd2080e7          	jalr	-558(ra) # 5b4a <printf>
      exit(1);
    3d80:	4505                	li	a0,1
    3d82:	00002097          	auipc	ra,0x2
    3d86:	a4e080e7          	jalr	-1458(ra) # 57d0 <exit>
      close(fd);
    3d8a:	00002097          	auipc	ra,0x2
    3d8e:	a6e080e7          	jalr	-1426(ra) # 57f8 <close>
    3d92:	a889                	j	3de4 <iref+0xce>
    unlink("xx");
    3d94:	854e                	mv	a0,s3
    3d96:	00002097          	auipc	ra,0x2
    3d9a:	a8a080e7          	jalr	-1398(ra) # 5820 <unlink>
  for(i = 0; i < NINODE + 1; i++){
    3d9e:	397d                	addiw	s2,s2,-1
    3da0:	06090063          	beqz	s2,3e00 <iref+0xea>
    if(mkdir("irefd") != 0){
    3da4:	8552                	mv	a0,s4
    3da6:	00002097          	auipc	ra,0x2
    3daa:	a92080e7          	jalr	-1390(ra) # 5838 <mkdir>
    3dae:	f155                	bnez	a0,3d52 <iref+0x3c>
    if(chdir("irefd") != 0){
    3db0:	8552                	mv	a0,s4
    3db2:	00002097          	auipc	ra,0x2
    3db6:	a8e080e7          	jalr	-1394(ra) # 5840 <chdir>
    3dba:	f955                	bnez	a0,3d6e <iref+0x58>
    mkdir("");
    3dbc:	8526                	mv	a0,s1
    3dbe:	00002097          	auipc	ra,0x2
    3dc2:	a7a080e7          	jalr	-1414(ra) # 5838 <mkdir>
    link("README", "");
    3dc6:	85a6                	mv	a1,s1
    3dc8:	8556                	mv	a0,s5
    3dca:	00002097          	auipc	ra,0x2
    3dce:	a66080e7          	jalr	-1434(ra) # 5830 <link>
    fd = open("", O_CREATE);
    3dd2:	20000593          	li	a1,512
    3dd6:	8526                	mv	a0,s1
    3dd8:	00002097          	auipc	ra,0x2
    3ddc:	a38080e7          	jalr	-1480(ra) # 5810 <open>
    if(fd >= 0)
    3de0:	fa0555e3          	bgez	a0,3d8a <iref+0x74>
    fd = open("xx", O_CREATE);
    3de4:	20000593          	li	a1,512
    3de8:	854e                	mv	a0,s3
    3dea:	00002097          	auipc	ra,0x2
    3dee:	a26080e7          	jalr	-1498(ra) # 5810 <open>
    if(fd >= 0)
    3df2:	fa0541e3          	bltz	a0,3d94 <iref+0x7e>
      close(fd);
    3df6:	00002097          	auipc	ra,0x2
    3dfa:	a02080e7          	jalr	-1534(ra) # 57f8 <close>
    3dfe:	bf59                	j	3d94 <iref+0x7e>
    3e00:	03300493          	li	s1,51
    chdir("..");
    3e04:	00003997          	auipc	s3,0x3
    3e08:	1a498993          	addi	s3,s3,420 # 6fa8 <malloc+0x13a6>
    unlink("irefd");
    3e0c:	00004917          	auipc	s2,0x4
    3e10:	97490913          	addi	s2,s2,-1676 # 7780 <malloc+0x1b7e>
    chdir("..");
    3e14:	854e                	mv	a0,s3
    3e16:	00002097          	auipc	ra,0x2
    3e1a:	a2a080e7          	jalr	-1494(ra) # 5840 <chdir>
    unlink("irefd");
    3e1e:	854a                	mv	a0,s2
    3e20:	00002097          	auipc	ra,0x2
    3e24:	a00080e7          	jalr	-1536(ra) # 5820 <unlink>
  for(i = 0; i < NINODE + 1; i++){
    3e28:	34fd                	addiw	s1,s1,-1
    3e2a:	f4ed                	bnez	s1,3e14 <iref+0xfe>
  chdir("/");
    3e2c:	00003517          	auipc	a0,0x3
    3e30:	12450513          	addi	a0,a0,292 # 6f50 <malloc+0x134e>
    3e34:	00002097          	auipc	ra,0x2
    3e38:	a0c080e7          	jalr	-1524(ra) # 5840 <chdir>
}
    3e3c:	70e2                	ld	ra,56(sp)
    3e3e:	7442                	ld	s0,48(sp)
    3e40:	74a2                	ld	s1,40(sp)
    3e42:	7902                	ld	s2,32(sp)
    3e44:	69e2                	ld	s3,24(sp)
    3e46:	6a42                	ld	s4,16(sp)
    3e48:	6aa2                	ld	s5,8(sp)
    3e4a:	6b02                	ld	s6,0(sp)
    3e4c:	6121                	addi	sp,sp,64
    3e4e:	8082                	ret

0000000000003e50 <openiputtest>:
{
    3e50:	7179                	addi	sp,sp,-48
    3e52:	f406                	sd	ra,40(sp)
    3e54:	f022                	sd	s0,32(sp)
    3e56:	ec26                	sd	s1,24(sp)
    3e58:	1800                	addi	s0,sp,48
    3e5a:	84aa                	mv	s1,a0
  if(mkdir("oidir") < 0){
    3e5c:	00004517          	auipc	a0,0x4
    3e60:	95c50513          	addi	a0,a0,-1700 # 77b8 <malloc+0x1bb6>
    3e64:	00002097          	auipc	ra,0x2
    3e68:	9d4080e7          	jalr	-1580(ra) # 5838 <mkdir>
    3e6c:	04054263          	bltz	a0,3eb0 <openiputtest+0x60>
  pid = fork();
    3e70:	00002097          	auipc	ra,0x2
    3e74:	958080e7          	jalr	-1704(ra) # 57c8 <fork>
  if(pid < 0){
    3e78:	04054a63          	bltz	a0,3ecc <openiputtest+0x7c>
  if(pid == 0){
    3e7c:	e93d                	bnez	a0,3ef2 <openiputtest+0xa2>
    int fd = open("oidir", O_RDWR);
    3e7e:	4589                	li	a1,2
    3e80:	00004517          	auipc	a0,0x4
    3e84:	93850513          	addi	a0,a0,-1736 # 77b8 <malloc+0x1bb6>
    3e88:	00002097          	auipc	ra,0x2
    3e8c:	988080e7          	jalr	-1656(ra) # 5810 <open>
    if(fd >= 0){
    3e90:	04054c63          	bltz	a0,3ee8 <openiputtest+0x98>
      printf("%s: open directory for write succeeded\n", s);
    3e94:	85a6                	mv	a1,s1
    3e96:	00004517          	auipc	a0,0x4
    3e9a:	94250513          	addi	a0,a0,-1726 # 77d8 <malloc+0x1bd6>
    3e9e:	00002097          	auipc	ra,0x2
    3ea2:	cac080e7          	jalr	-852(ra) # 5b4a <printf>
      exit(1);
    3ea6:	4505                	li	a0,1
    3ea8:	00002097          	auipc	ra,0x2
    3eac:	928080e7          	jalr	-1752(ra) # 57d0 <exit>
    printf("%s: mkdir oidir failed\n", s);
    3eb0:	85a6                	mv	a1,s1
    3eb2:	00004517          	auipc	a0,0x4
    3eb6:	90e50513          	addi	a0,a0,-1778 # 77c0 <malloc+0x1bbe>
    3eba:	00002097          	auipc	ra,0x2
    3ebe:	c90080e7          	jalr	-880(ra) # 5b4a <printf>
    exit(1);
    3ec2:	4505                	li	a0,1
    3ec4:	00002097          	auipc	ra,0x2
    3ec8:	90c080e7          	jalr	-1780(ra) # 57d0 <exit>
    printf("%s: fork failed\n", s);
    3ecc:	85a6                	mv	a1,s1
    3ece:	00002517          	auipc	a0,0x2
    3ed2:	6ca50513          	addi	a0,a0,1738 # 6598 <malloc+0x996>
    3ed6:	00002097          	auipc	ra,0x2
    3eda:	c74080e7          	jalr	-908(ra) # 5b4a <printf>
    exit(1);
    3ede:	4505                	li	a0,1
    3ee0:	00002097          	auipc	ra,0x2
    3ee4:	8f0080e7          	jalr	-1808(ra) # 57d0 <exit>
    exit(0);
    3ee8:	4501                	li	a0,0
    3eea:	00002097          	auipc	ra,0x2
    3eee:	8e6080e7          	jalr	-1818(ra) # 57d0 <exit>
  sleep(1);
    3ef2:	4505                	li	a0,1
    3ef4:	00002097          	auipc	ra,0x2
    3ef8:	96c080e7          	jalr	-1684(ra) # 5860 <sleep>
  if(unlink("oidir") != 0){
    3efc:	00004517          	auipc	a0,0x4
    3f00:	8bc50513          	addi	a0,a0,-1860 # 77b8 <malloc+0x1bb6>
    3f04:	00002097          	auipc	ra,0x2
    3f08:	91c080e7          	jalr	-1764(ra) # 5820 <unlink>
    3f0c:	cd19                	beqz	a0,3f2a <openiputtest+0xda>
    printf("%s: unlink failed\n", s);
    3f0e:	85a6                	mv	a1,s1
    3f10:	00003517          	auipc	a0,0x3
    3f14:	87850513          	addi	a0,a0,-1928 # 6788 <malloc+0xb86>
    3f18:	00002097          	auipc	ra,0x2
    3f1c:	c32080e7          	jalr	-974(ra) # 5b4a <printf>
    exit(1);
    3f20:	4505                	li	a0,1
    3f22:	00002097          	auipc	ra,0x2
    3f26:	8ae080e7          	jalr	-1874(ra) # 57d0 <exit>
  wait(&xstatus);
    3f2a:	fdc40513          	addi	a0,s0,-36
    3f2e:	00002097          	auipc	ra,0x2
    3f32:	8aa080e7          	jalr	-1878(ra) # 57d8 <wait>
  exit(xstatus);
    3f36:	fdc42503          	lw	a0,-36(s0)
    3f3a:	00002097          	auipc	ra,0x2
    3f3e:	896080e7          	jalr	-1898(ra) # 57d0 <exit>

0000000000003f42 <forkforkfork>:
{
    3f42:	1101                	addi	sp,sp,-32
    3f44:	ec06                	sd	ra,24(sp)
    3f46:	e822                	sd	s0,16(sp)
    3f48:	e426                	sd	s1,8(sp)
    3f4a:	1000                	addi	s0,sp,32
    3f4c:	84aa                	mv	s1,a0
  unlink("stopforking");
    3f4e:	00004517          	auipc	a0,0x4
    3f52:	8b250513          	addi	a0,a0,-1870 # 7800 <malloc+0x1bfe>
    3f56:	00002097          	auipc	ra,0x2
    3f5a:	8ca080e7          	jalr	-1846(ra) # 5820 <unlink>
  int pid = fork();
    3f5e:	00002097          	auipc	ra,0x2
    3f62:	86a080e7          	jalr	-1942(ra) # 57c8 <fork>
  if(pid < 0){
    3f66:	04054563          	bltz	a0,3fb0 <forkforkfork+0x6e>
  if(pid == 0){
    3f6a:	c12d                	beqz	a0,3fcc <forkforkfork+0x8a>
  sleep(20); // two seconds
    3f6c:	4551                	li	a0,20
    3f6e:	00002097          	auipc	ra,0x2
    3f72:	8f2080e7          	jalr	-1806(ra) # 5860 <sleep>
  close(open("stopforking", O_CREATE|O_RDWR));
    3f76:	20200593          	li	a1,514
    3f7a:	00004517          	auipc	a0,0x4
    3f7e:	88650513          	addi	a0,a0,-1914 # 7800 <malloc+0x1bfe>
    3f82:	00002097          	auipc	ra,0x2
    3f86:	88e080e7          	jalr	-1906(ra) # 5810 <open>
    3f8a:	00002097          	auipc	ra,0x2
    3f8e:	86e080e7          	jalr	-1938(ra) # 57f8 <close>
  wait(0);
    3f92:	4501                	li	a0,0
    3f94:	00002097          	auipc	ra,0x2
    3f98:	844080e7          	jalr	-1980(ra) # 57d8 <wait>
  sleep(10); // one second
    3f9c:	4529                	li	a0,10
    3f9e:	00002097          	auipc	ra,0x2
    3fa2:	8c2080e7          	jalr	-1854(ra) # 5860 <sleep>
}
    3fa6:	60e2                	ld	ra,24(sp)
    3fa8:	6442                	ld	s0,16(sp)
    3faa:	64a2                	ld	s1,8(sp)
    3fac:	6105                	addi	sp,sp,32
    3fae:	8082                	ret
    printf("%s: fork failed", s);
    3fb0:	85a6                	mv	a1,s1
    3fb2:	00002517          	auipc	a0,0x2
    3fb6:	7a650513          	addi	a0,a0,1958 # 6758 <malloc+0xb56>
    3fba:	00002097          	auipc	ra,0x2
    3fbe:	b90080e7          	jalr	-1136(ra) # 5b4a <printf>
    exit(1);
    3fc2:	4505                	li	a0,1
    3fc4:	00002097          	auipc	ra,0x2
    3fc8:	80c080e7          	jalr	-2036(ra) # 57d0 <exit>
      int fd = open("stopforking", 0);
    3fcc:	00004497          	auipc	s1,0x4
    3fd0:	83448493          	addi	s1,s1,-1996 # 7800 <malloc+0x1bfe>
    3fd4:	4581                	li	a1,0
    3fd6:	8526                	mv	a0,s1
    3fd8:	00002097          	auipc	ra,0x2
    3fdc:	838080e7          	jalr	-1992(ra) # 5810 <open>
      if(fd >= 0){
    3fe0:	02055463          	bgez	a0,4008 <forkforkfork+0xc6>
      if(fork() < 0){
    3fe4:	00001097          	auipc	ra,0x1
    3fe8:	7e4080e7          	jalr	2020(ra) # 57c8 <fork>
    3fec:	fe0554e3          	bgez	a0,3fd4 <forkforkfork+0x92>
        close(open("stopforking", O_CREATE|O_RDWR));
    3ff0:	20200593          	li	a1,514
    3ff4:	8526                	mv	a0,s1
    3ff6:	00002097          	auipc	ra,0x2
    3ffa:	81a080e7          	jalr	-2022(ra) # 5810 <open>
    3ffe:	00001097          	auipc	ra,0x1
    4002:	7fa080e7          	jalr	2042(ra) # 57f8 <close>
    4006:	b7f9                	j	3fd4 <forkforkfork+0x92>
        exit(0);
    4008:	4501                	li	a0,0
    400a:	00001097          	auipc	ra,0x1
    400e:	7c6080e7          	jalr	1990(ra) # 57d0 <exit>

0000000000004012 <killstatus>:
{
    4012:	7139                	addi	sp,sp,-64
    4014:	fc06                	sd	ra,56(sp)
    4016:	f822                	sd	s0,48(sp)
    4018:	f426                	sd	s1,40(sp)
    401a:	f04a                	sd	s2,32(sp)
    401c:	ec4e                	sd	s3,24(sp)
    401e:	e852                	sd	s4,16(sp)
    4020:	0080                	addi	s0,sp,64
    4022:	8a2a                	mv	s4,a0
    4024:	06400913          	li	s2,100
    if(xst != -1) {
    4028:	59fd                	li	s3,-1
    int pid1 = fork();
    402a:	00001097          	auipc	ra,0x1
    402e:	79e080e7          	jalr	1950(ra) # 57c8 <fork>
    4032:	84aa                	mv	s1,a0
    if(pid1 < 0){
    4034:	02054f63          	bltz	a0,4072 <killstatus+0x60>
    if(pid1 == 0){
    4038:	c939                	beqz	a0,408e <killstatus+0x7c>
    sleep(1);
    403a:	4505                	li	a0,1
    403c:	00002097          	auipc	ra,0x2
    4040:	824080e7          	jalr	-2012(ra) # 5860 <sleep>
    kill(pid1);
    4044:	8526                	mv	a0,s1
    4046:	00001097          	auipc	ra,0x1
    404a:	7ba080e7          	jalr	1978(ra) # 5800 <kill>
    wait(&xst);
    404e:	fcc40513          	addi	a0,s0,-52
    4052:	00001097          	auipc	ra,0x1
    4056:	786080e7          	jalr	1926(ra) # 57d8 <wait>
    if(xst != -1) {
    405a:	fcc42783          	lw	a5,-52(s0)
    405e:	03379d63          	bne	a5,s3,4098 <killstatus+0x86>
  for(int i = 0; i < 100; i++){
    4062:	397d                	addiw	s2,s2,-1
    4064:	fc0913e3          	bnez	s2,402a <killstatus+0x18>
  exit(0);
    4068:	4501                	li	a0,0
    406a:	00001097          	auipc	ra,0x1
    406e:	766080e7          	jalr	1894(ra) # 57d0 <exit>
      printf("%s: fork failed\n", s);
    4072:	85d2                	mv	a1,s4
    4074:	00002517          	auipc	a0,0x2
    4078:	52450513          	addi	a0,a0,1316 # 6598 <malloc+0x996>
    407c:	00002097          	auipc	ra,0x2
    4080:	ace080e7          	jalr	-1330(ra) # 5b4a <printf>
      exit(1);
    4084:	4505                	li	a0,1
    4086:	00001097          	auipc	ra,0x1
    408a:	74a080e7          	jalr	1866(ra) # 57d0 <exit>
        getpid();
    408e:	00001097          	auipc	ra,0x1
    4092:	7c2080e7          	jalr	1986(ra) # 5850 <getpid>
      while(1) {
    4096:	bfe5                	j	408e <killstatus+0x7c>
       printf("%s: status should be -1\n", s);
    4098:	85d2                	mv	a1,s4
    409a:	00003517          	auipc	a0,0x3
    409e:	77650513          	addi	a0,a0,1910 # 7810 <malloc+0x1c0e>
    40a2:	00002097          	auipc	ra,0x2
    40a6:	aa8080e7          	jalr	-1368(ra) # 5b4a <printf>
       exit(1);
    40aa:	4505                	li	a0,1
    40ac:	00001097          	auipc	ra,0x1
    40b0:	724080e7          	jalr	1828(ra) # 57d0 <exit>

00000000000040b4 <preempt>:
{
    40b4:	7139                	addi	sp,sp,-64
    40b6:	fc06                	sd	ra,56(sp)
    40b8:	f822                	sd	s0,48(sp)
    40ba:	f426                	sd	s1,40(sp)
    40bc:	f04a                	sd	s2,32(sp)
    40be:	ec4e                	sd	s3,24(sp)
    40c0:	e852                	sd	s4,16(sp)
    40c2:	0080                	addi	s0,sp,64
    40c4:	892a                	mv	s2,a0
  pid1 = fork();
    40c6:	00001097          	auipc	ra,0x1
    40ca:	702080e7          	jalr	1794(ra) # 57c8 <fork>
  if(pid1 < 0) {
    40ce:	00054563          	bltz	a0,40d8 <preempt+0x24>
    40d2:	84aa                	mv	s1,a0
  if(pid1 == 0)
    40d4:	e105                	bnez	a0,40f4 <preempt+0x40>
    for(;;)
    40d6:	a001                	j	40d6 <preempt+0x22>
    printf("%s: fork failed", s);
    40d8:	85ca                	mv	a1,s2
    40da:	00002517          	auipc	a0,0x2
    40de:	67e50513          	addi	a0,a0,1662 # 6758 <malloc+0xb56>
    40e2:	00002097          	auipc	ra,0x2
    40e6:	a68080e7          	jalr	-1432(ra) # 5b4a <printf>
    exit(1);
    40ea:	4505                	li	a0,1
    40ec:	00001097          	auipc	ra,0x1
    40f0:	6e4080e7          	jalr	1764(ra) # 57d0 <exit>
  pid2 = fork();
    40f4:	00001097          	auipc	ra,0x1
    40f8:	6d4080e7          	jalr	1748(ra) # 57c8 <fork>
    40fc:	89aa                	mv	s3,a0
  if(pid2 < 0) {
    40fe:	00054463          	bltz	a0,4106 <preempt+0x52>
  if(pid2 == 0)
    4102:	e105                	bnez	a0,4122 <preempt+0x6e>
    for(;;)
    4104:	a001                	j	4104 <preempt+0x50>
    printf("%s: fork failed\n", s);
    4106:	85ca                	mv	a1,s2
    4108:	00002517          	auipc	a0,0x2
    410c:	49050513          	addi	a0,a0,1168 # 6598 <malloc+0x996>
    4110:	00002097          	auipc	ra,0x2
    4114:	a3a080e7          	jalr	-1478(ra) # 5b4a <printf>
    exit(1);
    4118:	4505                	li	a0,1
    411a:	00001097          	auipc	ra,0x1
    411e:	6b6080e7          	jalr	1718(ra) # 57d0 <exit>
  pipe(pfds);
    4122:	fc840513          	addi	a0,s0,-56
    4126:	00001097          	auipc	ra,0x1
    412a:	6ba080e7          	jalr	1722(ra) # 57e0 <pipe>
  pid3 = fork();
    412e:	00001097          	auipc	ra,0x1
    4132:	69a080e7          	jalr	1690(ra) # 57c8 <fork>
    4136:	8a2a                	mv	s4,a0
  if(pid3 < 0) {
    4138:	02054e63          	bltz	a0,4174 <preempt+0xc0>
  if(pid3 == 0){
    413c:	e525                	bnez	a0,41a4 <preempt+0xf0>
    close(pfds[0]);
    413e:	fc842503          	lw	a0,-56(s0)
    4142:	00001097          	auipc	ra,0x1
    4146:	6b6080e7          	jalr	1718(ra) # 57f8 <close>
    if(write(pfds[1], "x", 1) != 1)
    414a:	4605                	li	a2,1
    414c:	00002597          	auipc	a1,0x2
    4150:	c4458593          	addi	a1,a1,-956 # 5d90 <malloc+0x18e>
    4154:	fcc42503          	lw	a0,-52(s0)
    4158:	00001097          	auipc	ra,0x1
    415c:	698080e7          	jalr	1688(ra) # 57f0 <write>
    4160:	4785                	li	a5,1
    4162:	02f51763          	bne	a0,a5,4190 <preempt+0xdc>
    close(pfds[1]);
    4166:	fcc42503          	lw	a0,-52(s0)
    416a:	00001097          	auipc	ra,0x1
    416e:	68e080e7          	jalr	1678(ra) # 57f8 <close>
    for(;;)
    4172:	a001                	j	4172 <preempt+0xbe>
     printf("%s: fork failed\n", s);
    4174:	85ca                	mv	a1,s2
    4176:	00002517          	auipc	a0,0x2
    417a:	42250513          	addi	a0,a0,1058 # 6598 <malloc+0x996>
    417e:	00002097          	auipc	ra,0x2
    4182:	9cc080e7          	jalr	-1588(ra) # 5b4a <printf>
     exit(1);
    4186:	4505                	li	a0,1
    4188:	00001097          	auipc	ra,0x1
    418c:	648080e7          	jalr	1608(ra) # 57d0 <exit>
      printf("%s: preempt write error", s);
    4190:	85ca                	mv	a1,s2
    4192:	00003517          	auipc	a0,0x3
    4196:	69e50513          	addi	a0,a0,1694 # 7830 <malloc+0x1c2e>
    419a:	00002097          	auipc	ra,0x2
    419e:	9b0080e7          	jalr	-1616(ra) # 5b4a <printf>
    41a2:	b7d1                	j	4166 <preempt+0xb2>
  close(pfds[1]);
    41a4:	fcc42503          	lw	a0,-52(s0)
    41a8:	00001097          	auipc	ra,0x1
    41ac:	650080e7          	jalr	1616(ra) # 57f8 <close>
  if(read(pfds[0], buf, sizeof(buf)) != 1){
    41b0:	660d                	lui	a2,0x3
    41b2:	00008597          	auipc	a1,0x8
    41b6:	bc658593          	addi	a1,a1,-1082 # bd78 <buf>
    41ba:	fc842503          	lw	a0,-56(s0)
    41be:	00001097          	auipc	ra,0x1
    41c2:	62a080e7          	jalr	1578(ra) # 57e8 <read>
    41c6:	4785                	li	a5,1
    41c8:	02f50363          	beq	a0,a5,41ee <preempt+0x13a>
    printf("%s: preempt read error", s);
    41cc:	85ca                	mv	a1,s2
    41ce:	00003517          	auipc	a0,0x3
    41d2:	67a50513          	addi	a0,a0,1658 # 7848 <malloc+0x1c46>
    41d6:	00002097          	auipc	ra,0x2
    41da:	974080e7          	jalr	-1676(ra) # 5b4a <printf>
}
    41de:	70e2                	ld	ra,56(sp)
    41e0:	7442                	ld	s0,48(sp)
    41e2:	74a2                	ld	s1,40(sp)
    41e4:	7902                	ld	s2,32(sp)
    41e6:	69e2                	ld	s3,24(sp)
    41e8:	6a42                	ld	s4,16(sp)
    41ea:	6121                	addi	sp,sp,64
    41ec:	8082                	ret
  close(pfds[0]);
    41ee:	fc842503          	lw	a0,-56(s0)
    41f2:	00001097          	auipc	ra,0x1
    41f6:	606080e7          	jalr	1542(ra) # 57f8 <close>
  printf("kill... ");
    41fa:	00003517          	auipc	a0,0x3
    41fe:	66650513          	addi	a0,a0,1638 # 7860 <malloc+0x1c5e>
    4202:	00002097          	auipc	ra,0x2
    4206:	948080e7          	jalr	-1720(ra) # 5b4a <printf>
  kill(pid1);
    420a:	8526                	mv	a0,s1
    420c:	00001097          	auipc	ra,0x1
    4210:	5f4080e7          	jalr	1524(ra) # 5800 <kill>
  kill(pid2);
    4214:	854e                	mv	a0,s3
    4216:	00001097          	auipc	ra,0x1
    421a:	5ea080e7          	jalr	1514(ra) # 5800 <kill>
  kill(pid3);
    421e:	8552                	mv	a0,s4
    4220:	00001097          	auipc	ra,0x1
    4224:	5e0080e7          	jalr	1504(ra) # 5800 <kill>
  printf("wait... ");
    4228:	00003517          	auipc	a0,0x3
    422c:	64850513          	addi	a0,a0,1608 # 7870 <malloc+0x1c6e>
    4230:	00002097          	auipc	ra,0x2
    4234:	91a080e7          	jalr	-1766(ra) # 5b4a <printf>
  wait(0);
    4238:	4501                	li	a0,0
    423a:	00001097          	auipc	ra,0x1
    423e:	59e080e7          	jalr	1438(ra) # 57d8 <wait>
  wait(0);
    4242:	4501                	li	a0,0
    4244:	00001097          	auipc	ra,0x1
    4248:	594080e7          	jalr	1428(ra) # 57d8 <wait>
  wait(0);
    424c:	4501                	li	a0,0
    424e:	00001097          	auipc	ra,0x1
    4252:	58a080e7          	jalr	1418(ra) # 57d8 <wait>
    4256:	b761                	j	41de <preempt+0x12a>

0000000000004258 <reparent>:
{
    4258:	7179                	addi	sp,sp,-48
    425a:	f406                	sd	ra,40(sp)
    425c:	f022                	sd	s0,32(sp)
    425e:	ec26                	sd	s1,24(sp)
    4260:	e84a                	sd	s2,16(sp)
    4262:	e44e                	sd	s3,8(sp)
    4264:	e052                	sd	s4,0(sp)
    4266:	1800                	addi	s0,sp,48
    4268:	89aa                	mv	s3,a0
  int master_pid = getpid();
    426a:	00001097          	auipc	ra,0x1
    426e:	5e6080e7          	jalr	1510(ra) # 5850 <getpid>
    4272:	8a2a                	mv	s4,a0
    4274:	0c800913          	li	s2,200
    int pid = fork();
    4278:	00001097          	auipc	ra,0x1
    427c:	550080e7          	jalr	1360(ra) # 57c8 <fork>
    4280:	84aa                	mv	s1,a0
    if(pid < 0){
    4282:	02054263          	bltz	a0,42a6 <reparent+0x4e>
    if(pid){
    4286:	cd21                	beqz	a0,42de <reparent+0x86>
      if(wait(0) != pid){
    4288:	4501                	li	a0,0
    428a:	00001097          	auipc	ra,0x1
    428e:	54e080e7          	jalr	1358(ra) # 57d8 <wait>
    4292:	02951863          	bne	a0,s1,42c2 <reparent+0x6a>
  for(int i = 0; i < 200; i++){
    4296:	397d                	addiw	s2,s2,-1
    4298:	fe0910e3          	bnez	s2,4278 <reparent+0x20>
  exit(0);
    429c:	4501                	li	a0,0
    429e:	00001097          	auipc	ra,0x1
    42a2:	532080e7          	jalr	1330(ra) # 57d0 <exit>
      printf("%s: fork failed\n", s);
    42a6:	85ce                	mv	a1,s3
    42a8:	00002517          	auipc	a0,0x2
    42ac:	2f050513          	addi	a0,a0,752 # 6598 <malloc+0x996>
    42b0:	00002097          	auipc	ra,0x2
    42b4:	89a080e7          	jalr	-1894(ra) # 5b4a <printf>
      exit(1);
    42b8:	4505                	li	a0,1
    42ba:	00001097          	auipc	ra,0x1
    42be:	516080e7          	jalr	1302(ra) # 57d0 <exit>
        printf("%s: wait wrong pid\n", s);
    42c2:	85ce                	mv	a1,s3
    42c4:	00002517          	auipc	a0,0x2
    42c8:	45c50513          	addi	a0,a0,1116 # 6720 <malloc+0xb1e>
    42cc:	00002097          	auipc	ra,0x2
    42d0:	87e080e7          	jalr	-1922(ra) # 5b4a <printf>
        exit(1);
    42d4:	4505                	li	a0,1
    42d6:	00001097          	auipc	ra,0x1
    42da:	4fa080e7          	jalr	1274(ra) # 57d0 <exit>
      int pid2 = fork();
    42de:	00001097          	auipc	ra,0x1
    42e2:	4ea080e7          	jalr	1258(ra) # 57c8 <fork>
      if(pid2 < 0){
    42e6:	00054763          	bltz	a0,42f4 <reparent+0x9c>
      exit(0);
    42ea:	4501                	li	a0,0
    42ec:	00001097          	auipc	ra,0x1
    42f0:	4e4080e7          	jalr	1252(ra) # 57d0 <exit>
        kill(master_pid);
    42f4:	8552                	mv	a0,s4
    42f6:	00001097          	auipc	ra,0x1
    42fa:	50a080e7          	jalr	1290(ra) # 5800 <kill>
        exit(1);
    42fe:	4505                	li	a0,1
    4300:	00001097          	auipc	ra,0x1
    4304:	4d0080e7          	jalr	1232(ra) # 57d0 <exit>

0000000000004308 <sbrkfail>:
{
    4308:	7119                	addi	sp,sp,-128
    430a:	fc86                	sd	ra,120(sp)
    430c:	f8a2                	sd	s0,112(sp)
    430e:	f4a6                	sd	s1,104(sp)
    4310:	f0ca                	sd	s2,96(sp)
    4312:	ecce                	sd	s3,88(sp)
    4314:	e8d2                	sd	s4,80(sp)
    4316:	e4d6                	sd	s5,72(sp)
    4318:	0100                	addi	s0,sp,128
    431a:	8aaa                	mv	s5,a0
  if(pipe(fds) != 0){
    431c:	fb040513          	addi	a0,s0,-80
    4320:	00001097          	auipc	ra,0x1
    4324:	4c0080e7          	jalr	1216(ra) # 57e0 <pipe>
    4328:	e901                	bnez	a0,4338 <sbrkfail+0x30>
    432a:	f8040493          	addi	s1,s0,-128
    432e:	fa840993          	addi	s3,s0,-88
    4332:	8926                	mv	s2,s1
    if(pids[i] != -1)
    4334:	5a7d                	li	s4,-1
    4336:	a085                	j	4396 <sbrkfail+0x8e>
    printf("%s: pipe() failed\n", s);
    4338:	85d6                	mv	a1,s5
    433a:	00002517          	auipc	a0,0x2
    433e:	36650513          	addi	a0,a0,870 # 66a0 <malloc+0xa9e>
    4342:	00002097          	auipc	ra,0x2
    4346:	808080e7          	jalr	-2040(ra) # 5b4a <printf>
    exit(1);
    434a:	4505                	li	a0,1
    434c:	00001097          	auipc	ra,0x1
    4350:	484080e7          	jalr	1156(ra) # 57d0 <exit>
      sbrk(BIG - (uint64)sbrk(0));
    4354:	00001097          	auipc	ra,0x1
    4358:	504080e7          	jalr	1284(ra) # 5858 <sbrk>
    435c:	064007b7          	lui	a5,0x6400
    4360:	40a7853b          	subw	a0,a5,a0
    4364:	00001097          	auipc	ra,0x1
    4368:	4f4080e7          	jalr	1268(ra) # 5858 <sbrk>
      write(fds[1], "x", 1);
    436c:	4605                	li	a2,1
    436e:	00002597          	auipc	a1,0x2
    4372:	a2258593          	addi	a1,a1,-1502 # 5d90 <malloc+0x18e>
    4376:	fb442503          	lw	a0,-76(s0)
    437a:	00001097          	auipc	ra,0x1
    437e:	476080e7          	jalr	1142(ra) # 57f0 <write>
      for(;;) sleep(1000);
    4382:	3e800513          	li	a0,1000
    4386:	00001097          	auipc	ra,0x1
    438a:	4da080e7          	jalr	1242(ra) # 5860 <sleep>
    438e:	bfd5                	j	4382 <sbrkfail+0x7a>
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    4390:	0911                	addi	s2,s2,4
    4392:	03390563          	beq	s2,s3,43bc <sbrkfail+0xb4>
    if((pids[i] = fork()) == 0){
    4396:	00001097          	auipc	ra,0x1
    439a:	432080e7          	jalr	1074(ra) # 57c8 <fork>
    439e:	00a92023          	sw	a0,0(s2)
    43a2:	d94d                	beqz	a0,4354 <sbrkfail+0x4c>
    if(pids[i] != -1)
    43a4:	ff4506e3          	beq	a0,s4,4390 <sbrkfail+0x88>
      read(fds[0], &scratch, 1);
    43a8:	4605                	li	a2,1
    43aa:	faf40593          	addi	a1,s0,-81
    43ae:	fb042503          	lw	a0,-80(s0)
    43b2:	00001097          	auipc	ra,0x1
    43b6:	436080e7          	jalr	1078(ra) # 57e8 <read>
    43ba:	bfd9                	j	4390 <sbrkfail+0x88>
  c = sbrk(PGSIZE);
    43bc:	6505                	lui	a0,0x1
    43be:	00001097          	auipc	ra,0x1
    43c2:	49a080e7          	jalr	1178(ra) # 5858 <sbrk>
    43c6:	8a2a                	mv	s4,a0
    if(pids[i] == -1)
    43c8:	597d                	li	s2,-1
    43ca:	a021                	j	43d2 <sbrkfail+0xca>
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    43cc:	0491                	addi	s1,s1,4
    43ce:	01348f63          	beq	s1,s3,43ec <sbrkfail+0xe4>
    if(pids[i] == -1)
    43d2:	4088                	lw	a0,0(s1)
    43d4:	ff250ce3          	beq	a0,s2,43cc <sbrkfail+0xc4>
    kill(pids[i]);
    43d8:	00001097          	auipc	ra,0x1
    43dc:	428080e7          	jalr	1064(ra) # 5800 <kill>
    wait(0);
    43e0:	4501                	li	a0,0
    43e2:	00001097          	auipc	ra,0x1
    43e6:	3f6080e7          	jalr	1014(ra) # 57d8 <wait>
    43ea:	b7cd                	j	43cc <sbrkfail+0xc4>
  if(c == (char*)0xffffffffffffffffL){
    43ec:	57fd                	li	a5,-1
    43ee:	04fa0163          	beq	s4,a5,4430 <sbrkfail+0x128>
  pid = fork();
    43f2:	00001097          	auipc	ra,0x1
    43f6:	3d6080e7          	jalr	982(ra) # 57c8 <fork>
    43fa:	84aa                	mv	s1,a0
  if(pid < 0){
    43fc:	04054863          	bltz	a0,444c <sbrkfail+0x144>
  if(pid == 0){
    4400:	c525                	beqz	a0,4468 <sbrkfail+0x160>
  wait(&xstatus);
    4402:	fbc40513          	addi	a0,s0,-68
    4406:	00001097          	auipc	ra,0x1
    440a:	3d2080e7          	jalr	978(ra) # 57d8 <wait>
  if(xstatus != -1 && xstatus != 2)
    440e:	fbc42783          	lw	a5,-68(s0)
    4412:	577d                	li	a4,-1
    4414:	00e78563          	beq	a5,a4,441e <sbrkfail+0x116>
    4418:	4709                	li	a4,2
    441a:	08e79d63          	bne	a5,a4,44b4 <sbrkfail+0x1ac>
}
    441e:	70e6                	ld	ra,120(sp)
    4420:	7446                	ld	s0,112(sp)
    4422:	74a6                	ld	s1,104(sp)
    4424:	7906                	ld	s2,96(sp)
    4426:	69e6                	ld	s3,88(sp)
    4428:	6a46                	ld	s4,80(sp)
    442a:	6aa6                	ld	s5,72(sp)
    442c:	6109                	addi	sp,sp,128
    442e:	8082                	ret
    printf("%s: failed sbrk leaked memory\n", s);
    4430:	85d6                	mv	a1,s5
    4432:	00003517          	auipc	a0,0x3
    4436:	44e50513          	addi	a0,a0,1102 # 7880 <malloc+0x1c7e>
    443a:	00001097          	auipc	ra,0x1
    443e:	710080e7          	jalr	1808(ra) # 5b4a <printf>
    exit(1);
    4442:	4505                	li	a0,1
    4444:	00001097          	auipc	ra,0x1
    4448:	38c080e7          	jalr	908(ra) # 57d0 <exit>
    printf("%s: fork failed\n", s);
    444c:	85d6                	mv	a1,s5
    444e:	00002517          	auipc	a0,0x2
    4452:	14a50513          	addi	a0,a0,330 # 6598 <malloc+0x996>
    4456:	00001097          	auipc	ra,0x1
    445a:	6f4080e7          	jalr	1780(ra) # 5b4a <printf>
    exit(1);
    445e:	4505                	li	a0,1
    4460:	00001097          	auipc	ra,0x1
    4464:	370080e7          	jalr	880(ra) # 57d0 <exit>
    a = sbrk(0);
    4468:	4501                	li	a0,0
    446a:	00001097          	auipc	ra,0x1
    446e:	3ee080e7          	jalr	1006(ra) # 5858 <sbrk>
    4472:	892a                	mv	s2,a0
    sbrk(10*BIG);
    4474:	3e800537          	lui	a0,0x3e800
    4478:	00001097          	auipc	ra,0x1
    447c:	3e0080e7          	jalr	992(ra) # 5858 <sbrk>
    for (i = 0; i < 10*BIG; i += PGSIZE) {
    4480:	87ca                	mv	a5,s2
    4482:	3e800737          	lui	a4,0x3e800
    4486:	993a                	add	s2,s2,a4
    4488:	6705                	lui	a4,0x1
      n += *(a+i);
    448a:	0007c683          	lbu	a3,0(a5) # 6400000 <__BSS_END__+0x63f1278>
    448e:	9cb5                	addw	s1,s1,a3
    for (i = 0; i < 10*BIG; i += PGSIZE) {
    4490:	97ba                	add	a5,a5,a4
    4492:	ff279ce3          	bne	a5,s2,448a <sbrkfail+0x182>
    printf("%s: allocate a lot of memory succeeded %d\n", s, n);
    4496:	8626                	mv	a2,s1
    4498:	85d6                	mv	a1,s5
    449a:	00003517          	auipc	a0,0x3
    449e:	40650513          	addi	a0,a0,1030 # 78a0 <malloc+0x1c9e>
    44a2:	00001097          	auipc	ra,0x1
    44a6:	6a8080e7          	jalr	1704(ra) # 5b4a <printf>
    exit(1);
    44aa:	4505                	li	a0,1
    44ac:	00001097          	auipc	ra,0x1
    44b0:	324080e7          	jalr	804(ra) # 57d0 <exit>
    exit(1);
    44b4:	4505                	li	a0,1
    44b6:	00001097          	auipc	ra,0x1
    44ba:	31a080e7          	jalr	794(ra) # 57d0 <exit>

00000000000044be <mem>:
{
    44be:	7139                	addi	sp,sp,-64
    44c0:	fc06                	sd	ra,56(sp)
    44c2:	f822                	sd	s0,48(sp)
    44c4:	f426                	sd	s1,40(sp)
    44c6:	f04a                	sd	s2,32(sp)
    44c8:	ec4e                	sd	s3,24(sp)
    44ca:	0080                	addi	s0,sp,64
    44cc:	89aa                	mv	s3,a0
  if((pid = fork()) == 0){
    44ce:	00001097          	auipc	ra,0x1
    44d2:	2fa080e7          	jalr	762(ra) # 57c8 <fork>
    m1 = 0;
    44d6:	4481                	li	s1,0
    while((m2 = malloc(10001)) != 0){
    44d8:	6909                	lui	s2,0x2
    44da:	71190913          	addi	s2,s2,1809 # 2711 <sbrkbasic+0x123>
  if((pid = fork()) == 0){
    44de:	c115                	beqz	a0,4502 <mem+0x44>
    wait(&xstatus);
    44e0:	fcc40513          	addi	a0,s0,-52
    44e4:	00001097          	auipc	ra,0x1
    44e8:	2f4080e7          	jalr	756(ra) # 57d8 <wait>
    if(xstatus == -1){
    44ec:	fcc42503          	lw	a0,-52(s0)
    44f0:	57fd                	li	a5,-1
    44f2:	06f50363          	beq	a0,a5,4558 <mem+0x9a>
    exit(xstatus);
    44f6:	00001097          	auipc	ra,0x1
    44fa:	2da080e7          	jalr	730(ra) # 57d0 <exit>
      *(char**)m2 = m1;
    44fe:	e104                	sd	s1,0(a0)
      m1 = m2;
    4500:	84aa                	mv	s1,a0
    while((m2 = malloc(10001)) != 0){
    4502:	854a                	mv	a0,s2
    4504:	00001097          	auipc	ra,0x1
    4508:	6fe080e7          	jalr	1790(ra) # 5c02 <malloc>
    450c:	f96d                	bnez	a0,44fe <mem+0x40>
    while(m1){
    450e:	c881                	beqz	s1,451e <mem+0x60>
      m2 = *(char**)m1;
    4510:	8526                	mv	a0,s1
    4512:	6084                	ld	s1,0(s1)
      free(m1);
    4514:	00001097          	auipc	ra,0x1
    4518:	66c080e7          	jalr	1644(ra) # 5b80 <free>
    while(m1){
    451c:	f8f5                	bnez	s1,4510 <mem+0x52>
    m1 = malloc(1024*20);
    451e:	6515                	lui	a0,0x5
    4520:	00001097          	auipc	ra,0x1
    4524:	6e2080e7          	jalr	1762(ra) # 5c02 <malloc>
    if(m1 == 0){
    4528:	c911                	beqz	a0,453c <mem+0x7e>
    free(m1);
    452a:	00001097          	auipc	ra,0x1
    452e:	656080e7          	jalr	1622(ra) # 5b80 <free>
    exit(0);
    4532:	4501                	li	a0,0
    4534:	00001097          	auipc	ra,0x1
    4538:	29c080e7          	jalr	668(ra) # 57d0 <exit>
      printf("couldn't allocate mem?!!\n", s);
    453c:	85ce                	mv	a1,s3
    453e:	00003517          	auipc	a0,0x3
    4542:	39250513          	addi	a0,a0,914 # 78d0 <malloc+0x1cce>
    4546:	00001097          	auipc	ra,0x1
    454a:	604080e7          	jalr	1540(ra) # 5b4a <printf>
      exit(1);
    454e:	4505                	li	a0,1
    4550:	00001097          	auipc	ra,0x1
    4554:	280080e7          	jalr	640(ra) # 57d0 <exit>
      exit(0);
    4558:	4501                	li	a0,0
    455a:	00001097          	auipc	ra,0x1
    455e:	276080e7          	jalr	630(ra) # 57d0 <exit>

0000000000004562 <sharedfd>:
{
    4562:	7159                	addi	sp,sp,-112
    4564:	f486                	sd	ra,104(sp)
    4566:	f0a2                	sd	s0,96(sp)
    4568:	eca6                	sd	s1,88(sp)
    456a:	e8ca                	sd	s2,80(sp)
    456c:	e4ce                	sd	s3,72(sp)
    456e:	e0d2                	sd	s4,64(sp)
    4570:	fc56                	sd	s5,56(sp)
    4572:	f85a                	sd	s6,48(sp)
    4574:	f45e                	sd	s7,40(sp)
    4576:	1880                	addi	s0,sp,112
    4578:	8a2a                	mv	s4,a0
  unlink("sharedfd");
    457a:	00003517          	auipc	a0,0x3
    457e:	37650513          	addi	a0,a0,886 # 78f0 <malloc+0x1cee>
    4582:	00001097          	auipc	ra,0x1
    4586:	29e080e7          	jalr	670(ra) # 5820 <unlink>
  fd = open("sharedfd", O_CREATE|O_RDWR);
    458a:	20200593          	li	a1,514
    458e:	00003517          	auipc	a0,0x3
    4592:	36250513          	addi	a0,a0,866 # 78f0 <malloc+0x1cee>
    4596:	00001097          	auipc	ra,0x1
    459a:	27a080e7          	jalr	634(ra) # 5810 <open>
  if(fd < 0){
    459e:	04054a63          	bltz	a0,45f2 <sharedfd+0x90>
    45a2:	892a                	mv	s2,a0
  pid = fork();
    45a4:	00001097          	auipc	ra,0x1
    45a8:	224080e7          	jalr	548(ra) # 57c8 <fork>
    45ac:	89aa                	mv	s3,a0
  memset(buf, pid==0?'c':'p', sizeof(buf));
    45ae:	06300593          	li	a1,99
    45b2:	c119                	beqz	a0,45b8 <sharedfd+0x56>
    45b4:	07000593          	li	a1,112
    45b8:	4629                	li	a2,10
    45ba:	fa040513          	addi	a0,s0,-96
    45be:	00001097          	auipc	ra,0x1
    45c2:	018080e7          	jalr	24(ra) # 55d6 <memset>
    45c6:	3e800493          	li	s1,1000
    if(write(fd, buf, sizeof(buf)) != sizeof(buf)){
    45ca:	4629                	li	a2,10
    45cc:	fa040593          	addi	a1,s0,-96
    45d0:	854a                	mv	a0,s2
    45d2:	00001097          	auipc	ra,0x1
    45d6:	21e080e7          	jalr	542(ra) # 57f0 <write>
    45da:	47a9                	li	a5,10
    45dc:	02f51963          	bne	a0,a5,460e <sharedfd+0xac>
  for(i = 0; i < N; i++){
    45e0:	34fd                	addiw	s1,s1,-1
    45e2:	f4e5                	bnez	s1,45ca <sharedfd+0x68>
  if(pid == 0) {
    45e4:	04099363          	bnez	s3,462a <sharedfd+0xc8>
    exit(0);
    45e8:	4501                	li	a0,0
    45ea:	00001097          	auipc	ra,0x1
    45ee:	1e6080e7          	jalr	486(ra) # 57d0 <exit>
    printf("%s: cannot open sharedfd for writing", s);
    45f2:	85d2                	mv	a1,s4
    45f4:	00003517          	auipc	a0,0x3
    45f8:	30c50513          	addi	a0,a0,780 # 7900 <malloc+0x1cfe>
    45fc:	00001097          	auipc	ra,0x1
    4600:	54e080e7          	jalr	1358(ra) # 5b4a <printf>
    exit(1);
    4604:	4505                	li	a0,1
    4606:	00001097          	auipc	ra,0x1
    460a:	1ca080e7          	jalr	458(ra) # 57d0 <exit>
      printf("%s: write sharedfd failed\n", s);
    460e:	85d2                	mv	a1,s4
    4610:	00003517          	auipc	a0,0x3
    4614:	31850513          	addi	a0,a0,792 # 7928 <malloc+0x1d26>
    4618:	00001097          	auipc	ra,0x1
    461c:	532080e7          	jalr	1330(ra) # 5b4a <printf>
      exit(1);
    4620:	4505                	li	a0,1
    4622:	00001097          	auipc	ra,0x1
    4626:	1ae080e7          	jalr	430(ra) # 57d0 <exit>
    wait(&xstatus);
    462a:	f9c40513          	addi	a0,s0,-100
    462e:	00001097          	auipc	ra,0x1
    4632:	1aa080e7          	jalr	426(ra) # 57d8 <wait>
    if(xstatus != 0)
    4636:	f9c42983          	lw	s3,-100(s0)
    463a:	00098763          	beqz	s3,4648 <sharedfd+0xe6>
      exit(xstatus);
    463e:	854e                	mv	a0,s3
    4640:	00001097          	auipc	ra,0x1
    4644:	190080e7          	jalr	400(ra) # 57d0 <exit>
  close(fd);
    4648:	854a                	mv	a0,s2
    464a:	00001097          	auipc	ra,0x1
    464e:	1ae080e7          	jalr	430(ra) # 57f8 <close>
  fd = open("sharedfd", 0);
    4652:	4581                	li	a1,0
    4654:	00003517          	auipc	a0,0x3
    4658:	29c50513          	addi	a0,a0,668 # 78f0 <malloc+0x1cee>
    465c:	00001097          	auipc	ra,0x1
    4660:	1b4080e7          	jalr	436(ra) # 5810 <open>
    4664:	8baa                	mv	s7,a0
  nc = np = 0;
    4666:	8ace                	mv	s5,s3
  if(fd < 0){
    4668:	02054563          	bltz	a0,4692 <sharedfd+0x130>
    466c:	faa40913          	addi	s2,s0,-86
      if(buf[i] == 'c')
    4670:	06300493          	li	s1,99
      if(buf[i] == 'p')
    4674:	07000b13          	li	s6,112
  while((n = read(fd, buf, sizeof(buf))) > 0){
    4678:	4629                	li	a2,10
    467a:	fa040593          	addi	a1,s0,-96
    467e:	855e                	mv	a0,s7
    4680:	00001097          	auipc	ra,0x1
    4684:	168080e7          	jalr	360(ra) # 57e8 <read>
    4688:	02a05f63          	blez	a0,46c6 <sharedfd+0x164>
    468c:	fa040793          	addi	a5,s0,-96
    4690:	a01d                	j	46b6 <sharedfd+0x154>
    printf("%s: cannot open sharedfd for reading\n", s);
    4692:	85d2                	mv	a1,s4
    4694:	00003517          	auipc	a0,0x3
    4698:	2b450513          	addi	a0,a0,692 # 7948 <malloc+0x1d46>
    469c:	00001097          	auipc	ra,0x1
    46a0:	4ae080e7          	jalr	1198(ra) # 5b4a <printf>
    exit(1);
    46a4:	4505                	li	a0,1
    46a6:	00001097          	auipc	ra,0x1
    46aa:	12a080e7          	jalr	298(ra) # 57d0 <exit>
        nc++;
    46ae:	2985                	addiw	s3,s3,1
    for(i = 0; i < sizeof(buf); i++){
    46b0:	0785                	addi	a5,a5,1
    46b2:	fd2783e3          	beq	a5,s2,4678 <sharedfd+0x116>
      if(buf[i] == 'c')
    46b6:	0007c703          	lbu	a4,0(a5)
    46ba:	fe970ae3          	beq	a4,s1,46ae <sharedfd+0x14c>
      if(buf[i] == 'p')
    46be:	ff6719e3          	bne	a4,s6,46b0 <sharedfd+0x14e>
        np++;
    46c2:	2a85                	addiw	s5,s5,1
    46c4:	b7f5                	j	46b0 <sharedfd+0x14e>
  close(fd);
    46c6:	855e                	mv	a0,s7
    46c8:	00001097          	auipc	ra,0x1
    46cc:	130080e7          	jalr	304(ra) # 57f8 <close>
  unlink("sharedfd");
    46d0:	00003517          	auipc	a0,0x3
    46d4:	22050513          	addi	a0,a0,544 # 78f0 <malloc+0x1cee>
    46d8:	00001097          	auipc	ra,0x1
    46dc:	148080e7          	jalr	328(ra) # 5820 <unlink>
  if(nc == N*SZ && np == N*SZ){
    46e0:	6789                	lui	a5,0x2
    46e2:	71078793          	addi	a5,a5,1808 # 2710 <sbrkbasic+0x122>
    46e6:	00f99763          	bne	s3,a5,46f4 <sharedfd+0x192>
    46ea:	6789                	lui	a5,0x2
    46ec:	71078793          	addi	a5,a5,1808 # 2710 <sbrkbasic+0x122>
    46f0:	02fa8063          	beq	s5,a5,4710 <sharedfd+0x1ae>
    printf("%s: nc/np test fails\n", s);
    46f4:	85d2                	mv	a1,s4
    46f6:	00003517          	auipc	a0,0x3
    46fa:	27a50513          	addi	a0,a0,634 # 7970 <malloc+0x1d6e>
    46fe:	00001097          	auipc	ra,0x1
    4702:	44c080e7          	jalr	1100(ra) # 5b4a <printf>
    exit(1);
    4706:	4505                	li	a0,1
    4708:	00001097          	auipc	ra,0x1
    470c:	0c8080e7          	jalr	200(ra) # 57d0 <exit>
    exit(0);
    4710:	4501                	li	a0,0
    4712:	00001097          	auipc	ra,0x1
    4716:	0be080e7          	jalr	190(ra) # 57d0 <exit>

000000000000471a <fourfiles>:
{
    471a:	7171                	addi	sp,sp,-176
    471c:	f506                	sd	ra,168(sp)
    471e:	f122                	sd	s0,160(sp)
    4720:	ed26                	sd	s1,152(sp)
    4722:	e94a                	sd	s2,144(sp)
    4724:	e54e                	sd	s3,136(sp)
    4726:	e152                	sd	s4,128(sp)
    4728:	fcd6                	sd	s5,120(sp)
    472a:	f8da                	sd	s6,112(sp)
    472c:	f4de                	sd	s7,104(sp)
    472e:	f0e2                	sd	s8,96(sp)
    4730:	ece6                	sd	s9,88(sp)
    4732:	e8ea                	sd	s10,80(sp)
    4734:	e4ee                	sd	s11,72(sp)
    4736:	1900                	addi	s0,sp,176
    4738:	f4a43c23          	sd	a0,-168(s0)
  char *names[] = { "f0", "f1", "f2", "f3" };
    473c:	00003797          	auipc	a5,0x3
    4740:	24c78793          	addi	a5,a5,588 # 7988 <malloc+0x1d86>
    4744:	f6f43823          	sd	a5,-144(s0)
    4748:	00003797          	auipc	a5,0x3
    474c:	24878793          	addi	a5,a5,584 # 7990 <malloc+0x1d8e>
    4750:	f6f43c23          	sd	a5,-136(s0)
    4754:	00003797          	auipc	a5,0x3
    4758:	24478793          	addi	a5,a5,580 # 7998 <malloc+0x1d96>
    475c:	f8f43023          	sd	a5,-128(s0)
    4760:	00003797          	auipc	a5,0x3
    4764:	24078793          	addi	a5,a5,576 # 79a0 <malloc+0x1d9e>
    4768:	f8f43423          	sd	a5,-120(s0)
  for(pi = 0; pi < NCHILD; pi++){
    476c:	f7040c13          	addi	s8,s0,-144
  char *names[] = { "f0", "f1", "f2", "f3" };
    4770:	8962                	mv	s2,s8
  for(pi = 0; pi < NCHILD; pi++){
    4772:	4481                	li	s1,0
    4774:	4a11                	li	s4,4
    fname = names[pi];
    4776:	00093983          	ld	s3,0(s2)
    unlink(fname);
    477a:	854e                	mv	a0,s3
    477c:	00001097          	auipc	ra,0x1
    4780:	0a4080e7          	jalr	164(ra) # 5820 <unlink>
    pid = fork();
    4784:	00001097          	auipc	ra,0x1
    4788:	044080e7          	jalr	68(ra) # 57c8 <fork>
    if(pid < 0){
    478c:	04054463          	bltz	a0,47d4 <fourfiles+0xba>
    if(pid == 0){
    4790:	c12d                	beqz	a0,47f2 <fourfiles+0xd8>
  for(pi = 0; pi < NCHILD; pi++){
    4792:	2485                	addiw	s1,s1,1
    4794:	0921                	addi	s2,s2,8
    4796:	ff4490e3          	bne	s1,s4,4776 <fourfiles+0x5c>
    479a:	4491                	li	s1,4
    wait(&xstatus);
    479c:	f6c40513          	addi	a0,s0,-148
    47a0:	00001097          	auipc	ra,0x1
    47a4:	038080e7          	jalr	56(ra) # 57d8 <wait>
    if(xstatus != 0)
    47a8:	f6c42b03          	lw	s6,-148(s0)
    47ac:	0c0b1e63          	bnez	s6,4888 <fourfiles+0x16e>
  for(pi = 0; pi < NCHILD; pi++){
    47b0:	34fd                	addiw	s1,s1,-1
    47b2:	f4ed                	bnez	s1,479c <fourfiles+0x82>
    47b4:	03000b93          	li	s7,48
    while((n = read(fd, buf, sizeof(buf))) > 0){
    47b8:	00007a17          	auipc	s4,0x7
    47bc:	5c0a0a13          	addi	s4,s4,1472 # bd78 <buf>
    47c0:	00007a97          	auipc	s5,0x7
    47c4:	5b9a8a93          	addi	s5,s5,1465 # bd79 <buf+0x1>
    if(total != N*SZ){
    47c8:	6d85                	lui	s11,0x1
    47ca:	770d8d93          	addi	s11,s11,1904 # 1770 <exectest+0x138>
  for(i = 0; i < NCHILD; i++){
    47ce:	03400d13          	li	s10,52
    47d2:	aa1d                	j	4908 <fourfiles+0x1ee>
      printf("fork failed\n", s);
    47d4:	f5843583          	ld	a1,-168(s0)
    47d8:	00002517          	auipc	a0,0x2
    47dc:	1c850513          	addi	a0,a0,456 # 69a0 <malloc+0xd9e>
    47e0:	00001097          	auipc	ra,0x1
    47e4:	36a080e7          	jalr	874(ra) # 5b4a <printf>
      exit(1);
    47e8:	4505                	li	a0,1
    47ea:	00001097          	auipc	ra,0x1
    47ee:	fe6080e7          	jalr	-26(ra) # 57d0 <exit>
      fd = open(fname, O_CREATE | O_RDWR);
    47f2:	20200593          	li	a1,514
    47f6:	854e                	mv	a0,s3
    47f8:	00001097          	auipc	ra,0x1
    47fc:	018080e7          	jalr	24(ra) # 5810 <open>
    4800:	892a                	mv	s2,a0
      if(fd < 0){
    4802:	04054763          	bltz	a0,4850 <fourfiles+0x136>
      memset(buf, '0'+pi, SZ);
    4806:	1f400613          	li	a2,500
    480a:	0304859b          	addiw	a1,s1,48
    480e:	00007517          	auipc	a0,0x7
    4812:	56a50513          	addi	a0,a0,1386 # bd78 <buf>
    4816:	00001097          	auipc	ra,0x1
    481a:	dc0080e7          	jalr	-576(ra) # 55d6 <memset>
    481e:	44b1                	li	s1,12
        if((n = write(fd, buf, SZ)) != SZ){
    4820:	00007997          	auipc	s3,0x7
    4824:	55898993          	addi	s3,s3,1368 # bd78 <buf>
    4828:	1f400613          	li	a2,500
    482c:	85ce                	mv	a1,s3
    482e:	854a                	mv	a0,s2
    4830:	00001097          	auipc	ra,0x1
    4834:	fc0080e7          	jalr	-64(ra) # 57f0 <write>
    4838:	85aa                	mv	a1,a0
    483a:	1f400793          	li	a5,500
    483e:	02f51863          	bne	a0,a5,486e <fourfiles+0x154>
      for(i = 0; i < N; i++){
    4842:	34fd                	addiw	s1,s1,-1
    4844:	f0f5                	bnez	s1,4828 <fourfiles+0x10e>
      exit(0);
    4846:	4501                	li	a0,0
    4848:	00001097          	auipc	ra,0x1
    484c:	f88080e7          	jalr	-120(ra) # 57d0 <exit>
        printf("create failed\n", s);
    4850:	f5843583          	ld	a1,-168(s0)
    4854:	00003517          	auipc	a0,0x3
    4858:	15450513          	addi	a0,a0,340 # 79a8 <malloc+0x1da6>
    485c:	00001097          	auipc	ra,0x1
    4860:	2ee080e7          	jalr	750(ra) # 5b4a <printf>
        exit(1);
    4864:	4505                	li	a0,1
    4866:	00001097          	auipc	ra,0x1
    486a:	f6a080e7          	jalr	-150(ra) # 57d0 <exit>
          printf("write failed %d\n", n);
    486e:	00003517          	auipc	a0,0x3
    4872:	14a50513          	addi	a0,a0,330 # 79b8 <malloc+0x1db6>
    4876:	00001097          	auipc	ra,0x1
    487a:	2d4080e7          	jalr	724(ra) # 5b4a <printf>
          exit(1);
    487e:	4505                	li	a0,1
    4880:	00001097          	auipc	ra,0x1
    4884:	f50080e7          	jalr	-176(ra) # 57d0 <exit>
      exit(xstatus);
    4888:	855a                	mv	a0,s6
    488a:	00001097          	auipc	ra,0x1
    488e:	f46080e7          	jalr	-186(ra) # 57d0 <exit>
          printf("wrong char\n", s);
    4892:	f5843583          	ld	a1,-168(s0)
    4896:	00003517          	auipc	a0,0x3
    489a:	13a50513          	addi	a0,a0,314 # 79d0 <malloc+0x1dce>
    489e:	00001097          	auipc	ra,0x1
    48a2:	2ac080e7          	jalr	684(ra) # 5b4a <printf>
          exit(1);
    48a6:	4505                	li	a0,1
    48a8:	00001097          	auipc	ra,0x1
    48ac:	f28080e7          	jalr	-216(ra) # 57d0 <exit>
      total += n;
    48b0:	00a9093b          	addw	s2,s2,a0
    while((n = read(fd, buf, sizeof(buf))) > 0){
    48b4:	660d                	lui	a2,0x3
    48b6:	85d2                	mv	a1,s4
    48b8:	854e                	mv	a0,s3
    48ba:	00001097          	auipc	ra,0x1
    48be:	f2e080e7          	jalr	-210(ra) # 57e8 <read>
    48c2:	02a05363          	blez	a0,48e8 <fourfiles+0x1ce>
    48c6:	00007797          	auipc	a5,0x7
    48ca:	4b278793          	addi	a5,a5,1202 # bd78 <buf>
    48ce:	fff5069b          	addiw	a3,a0,-1
    48d2:	1682                	slli	a3,a3,0x20
    48d4:	9281                	srli	a3,a3,0x20
    48d6:	96d6                	add	a3,a3,s5
        if(buf[j] != '0'+i){
    48d8:	0007c703          	lbu	a4,0(a5)
    48dc:	fa971be3          	bne	a4,s1,4892 <fourfiles+0x178>
      for(j = 0; j < n; j++){
    48e0:	0785                	addi	a5,a5,1
    48e2:	fed79be3          	bne	a5,a3,48d8 <fourfiles+0x1be>
    48e6:	b7e9                	j	48b0 <fourfiles+0x196>
    close(fd);
    48e8:	854e                	mv	a0,s3
    48ea:	00001097          	auipc	ra,0x1
    48ee:	f0e080e7          	jalr	-242(ra) # 57f8 <close>
    if(total != N*SZ){
    48f2:	03b91863          	bne	s2,s11,4922 <fourfiles+0x208>
    unlink(fname);
    48f6:	8566                	mv	a0,s9
    48f8:	00001097          	auipc	ra,0x1
    48fc:	f28080e7          	jalr	-216(ra) # 5820 <unlink>
  for(i = 0; i < NCHILD; i++){
    4900:	0c21                	addi	s8,s8,8
    4902:	2b85                	addiw	s7,s7,1
    4904:	03ab8d63          	beq	s7,s10,493e <fourfiles+0x224>
    fname = names[i];
    4908:	000c3c83          	ld	s9,0(s8)
    fd = open(fname, 0);
    490c:	4581                	li	a1,0
    490e:	8566                	mv	a0,s9
    4910:	00001097          	auipc	ra,0x1
    4914:	f00080e7          	jalr	-256(ra) # 5810 <open>
    4918:	89aa                	mv	s3,a0
    total = 0;
    491a:	895a                	mv	s2,s6
        if(buf[j] != '0'+i){
    491c:	000b849b          	sext.w	s1,s7
    while((n = read(fd, buf, sizeof(buf))) > 0){
    4920:	bf51                	j	48b4 <fourfiles+0x19a>
      printf("wrong length %d\n", total);
    4922:	85ca                	mv	a1,s2
    4924:	00003517          	auipc	a0,0x3
    4928:	0bc50513          	addi	a0,a0,188 # 79e0 <malloc+0x1dde>
    492c:	00001097          	auipc	ra,0x1
    4930:	21e080e7          	jalr	542(ra) # 5b4a <printf>
      exit(1);
    4934:	4505                	li	a0,1
    4936:	00001097          	auipc	ra,0x1
    493a:	e9a080e7          	jalr	-358(ra) # 57d0 <exit>
}
    493e:	70aa                	ld	ra,168(sp)
    4940:	740a                	ld	s0,160(sp)
    4942:	64ea                	ld	s1,152(sp)
    4944:	694a                	ld	s2,144(sp)
    4946:	69aa                	ld	s3,136(sp)
    4948:	6a0a                	ld	s4,128(sp)
    494a:	7ae6                	ld	s5,120(sp)
    494c:	7b46                	ld	s6,112(sp)
    494e:	7ba6                	ld	s7,104(sp)
    4950:	7c06                	ld	s8,96(sp)
    4952:	6ce6                	ld	s9,88(sp)
    4954:	6d46                	ld	s10,80(sp)
    4956:	6da6                	ld	s11,72(sp)
    4958:	614d                	addi	sp,sp,176
    495a:	8082                	ret

000000000000495c <concreate>:
{
    495c:	7135                	addi	sp,sp,-160
    495e:	ed06                	sd	ra,152(sp)
    4960:	e922                	sd	s0,144(sp)
    4962:	e526                	sd	s1,136(sp)
    4964:	e14a                	sd	s2,128(sp)
    4966:	fcce                	sd	s3,120(sp)
    4968:	f8d2                	sd	s4,112(sp)
    496a:	f4d6                	sd	s5,104(sp)
    496c:	f0da                	sd	s6,96(sp)
    496e:	ecde                	sd	s7,88(sp)
    4970:	1100                	addi	s0,sp,160
    4972:	89aa                	mv	s3,a0
  file[0] = 'C';
    4974:	04300793          	li	a5,67
    4978:	faf40423          	sb	a5,-88(s0)
  file[2] = '\0';
    497c:	fa040523          	sb	zero,-86(s0)
  for(i = 0; i < N; i++){
    4980:	4901                	li	s2,0
    if(pid && (i % 3) == 1){
    4982:	4b0d                	li	s6,3
    4984:	4a85                	li	s5,1
      link("C0", file);
    4986:	00003b97          	auipc	s7,0x3
    498a:	072b8b93          	addi	s7,s7,114 # 79f8 <malloc+0x1df6>
  for(i = 0; i < N; i++){
    498e:	02800a13          	li	s4,40
    4992:	acc9                	j	4c64 <concreate+0x308>
      link("C0", file);
    4994:	fa840593          	addi	a1,s0,-88
    4998:	855e                	mv	a0,s7
    499a:	00001097          	auipc	ra,0x1
    499e:	e96080e7          	jalr	-362(ra) # 5830 <link>
    if(pid == 0) {
    49a2:	a465                	j	4c4a <concreate+0x2ee>
    } else if(pid == 0 && (i % 5) == 1){
    49a4:	4795                	li	a5,5
    49a6:	02f9693b          	remw	s2,s2,a5
    49aa:	4785                	li	a5,1
    49ac:	02f90b63          	beq	s2,a5,49e2 <concreate+0x86>
      fd = open(file, O_CREATE | O_RDWR);
    49b0:	20200593          	li	a1,514
    49b4:	fa840513          	addi	a0,s0,-88
    49b8:	00001097          	auipc	ra,0x1
    49bc:	e58080e7          	jalr	-424(ra) # 5810 <open>
      if(fd < 0){
    49c0:	26055c63          	bgez	a0,4c38 <concreate+0x2dc>
        printf("concreate create %s failed\n", file);
    49c4:	fa840593          	addi	a1,s0,-88
    49c8:	00003517          	auipc	a0,0x3
    49cc:	03850513          	addi	a0,a0,56 # 7a00 <malloc+0x1dfe>
    49d0:	00001097          	auipc	ra,0x1
    49d4:	17a080e7          	jalr	378(ra) # 5b4a <printf>
        exit(1);
    49d8:	4505                	li	a0,1
    49da:	00001097          	auipc	ra,0x1
    49de:	df6080e7          	jalr	-522(ra) # 57d0 <exit>
      link("C0", file);
    49e2:	fa840593          	addi	a1,s0,-88
    49e6:	00003517          	auipc	a0,0x3
    49ea:	01250513          	addi	a0,a0,18 # 79f8 <malloc+0x1df6>
    49ee:	00001097          	auipc	ra,0x1
    49f2:	e42080e7          	jalr	-446(ra) # 5830 <link>
      exit(0);
    49f6:	4501                	li	a0,0
    49f8:	00001097          	auipc	ra,0x1
    49fc:	dd8080e7          	jalr	-552(ra) # 57d0 <exit>
        exit(1);
    4a00:	4505                	li	a0,1
    4a02:	00001097          	auipc	ra,0x1
    4a06:	dce080e7          	jalr	-562(ra) # 57d0 <exit>
  memset(fa, 0, sizeof(fa));
    4a0a:	02800613          	li	a2,40
    4a0e:	4581                	li	a1,0
    4a10:	f8040513          	addi	a0,s0,-128
    4a14:	00001097          	auipc	ra,0x1
    4a18:	bc2080e7          	jalr	-1086(ra) # 55d6 <memset>
  fd = open(".", 0);
    4a1c:	4581                	li	a1,0
    4a1e:	00002517          	auipc	a0,0x2
    4a22:	9da50513          	addi	a0,a0,-1574 # 63f8 <malloc+0x7f6>
    4a26:	00001097          	auipc	ra,0x1
    4a2a:	dea080e7          	jalr	-534(ra) # 5810 <open>
    4a2e:	892a                	mv	s2,a0
  n = 0;
    4a30:	8aa6                	mv	s5,s1
    if(de.name[0] == 'C' && de.name[2] == '\0'){
    4a32:	04300a13          	li	s4,67
      if(i < 0 || i >= sizeof(fa)){
    4a36:	02700b13          	li	s6,39
      fa[i] = 1;
    4a3a:	4b85                	li	s7,1
  while(read(fd, &de, sizeof(de)) > 0){
    4a3c:	4641                	li	a2,16
    4a3e:	f7040593          	addi	a1,s0,-144
    4a42:	854a                	mv	a0,s2
    4a44:	00001097          	auipc	ra,0x1
    4a48:	da4080e7          	jalr	-604(ra) # 57e8 <read>
    4a4c:	08a05263          	blez	a0,4ad0 <concreate+0x174>
    if(de.inum == 0)
    4a50:	f7045783          	lhu	a5,-144(s0)
    4a54:	d7e5                	beqz	a5,4a3c <concreate+0xe0>
    if(de.name[0] == 'C' && de.name[2] == '\0'){
    4a56:	f7244783          	lbu	a5,-142(s0)
    4a5a:	ff4791e3          	bne	a5,s4,4a3c <concreate+0xe0>
    4a5e:	f7444783          	lbu	a5,-140(s0)
    4a62:	ffe9                	bnez	a5,4a3c <concreate+0xe0>
      i = de.name[1] - '0';
    4a64:	f7344783          	lbu	a5,-141(s0)
    4a68:	fd07879b          	addiw	a5,a5,-48
    4a6c:	0007871b          	sext.w	a4,a5
      if(i < 0 || i >= sizeof(fa)){
    4a70:	02eb6063          	bltu	s6,a4,4a90 <concreate+0x134>
      if(fa[i]){
    4a74:	fb070793          	addi	a5,a4,-80 # fb0 <linktest+0x1c4>
    4a78:	97a2                	add	a5,a5,s0
    4a7a:	fd07c783          	lbu	a5,-48(a5)
    4a7e:	eb8d                	bnez	a5,4ab0 <concreate+0x154>
      fa[i] = 1;
    4a80:	fb070793          	addi	a5,a4,-80
    4a84:	00878733          	add	a4,a5,s0
    4a88:	fd770823          	sb	s7,-48(a4)
      n++;
    4a8c:	2a85                	addiw	s5,s5,1
    4a8e:	b77d                	j	4a3c <concreate+0xe0>
        printf("%s: concreate weird file %s\n", s, de.name);
    4a90:	f7240613          	addi	a2,s0,-142
    4a94:	85ce                	mv	a1,s3
    4a96:	00003517          	auipc	a0,0x3
    4a9a:	f8a50513          	addi	a0,a0,-118 # 7a20 <malloc+0x1e1e>
    4a9e:	00001097          	auipc	ra,0x1
    4aa2:	0ac080e7          	jalr	172(ra) # 5b4a <printf>
        exit(1);
    4aa6:	4505                	li	a0,1
    4aa8:	00001097          	auipc	ra,0x1
    4aac:	d28080e7          	jalr	-728(ra) # 57d0 <exit>
        printf("%s: concreate duplicate file %s\n", s, de.name);
    4ab0:	f7240613          	addi	a2,s0,-142
    4ab4:	85ce                	mv	a1,s3
    4ab6:	00003517          	auipc	a0,0x3
    4aba:	f8a50513          	addi	a0,a0,-118 # 7a40 <malloc+0x1e3e>
    4abe:	00001097          	auipc	ra,0x1
    4ac2:	08c080e7          	jalr	140(ra) # 5b4a <printf>
        exit(1);
    4ac6:	4505                	li	a0,1
    4ac8:	00001097          	auipc	ra,0x1
    4acc:	d08080e7          	jalr	-760(ra) # 57d0 <exit>
  close(fd);
    4ad0:	854a                	mv	a0,s2
    4ad2:	00001097          	auipc	ra,0x1
    4ad6:	d26080e7          	jalr	-730(ra) # 57f8 <close>
  if(n != N){
    4ada:	02800793          	li	a5,40
    4ade:	00fa9763          	bne	s5,a5,4aec <concreate+0x190>
    if(((i % 3) == 0 && pid == 0) ||
    4ae2:	4a8d                	li	s5,3
    4ae4:	4b05                	li	s6,1
  for(i = 0; i < N; i++){
    4ae6:	02800a13          	li	s4,40
    4aea:	a8c9                	j	4bbc <concreate+0x260>
    printf("%s: concreate not enough files in directory listing\n", s);
    4aec:	85ce                	mv	a1,s3
    4aee:	00003517          	auipc	a0,0x3
    4af2:	f7a50513          	addi	a0,a0,-134 # 7a68 <malloc+0x1e66>
    4af6:	00001097          	auipc	ra,0x1
    4afa:	054080e7          	jalr	84(ra) # 5b4a <printf>
    exit(1);
    4afe:	4505                	li	a0,1
    4b00:	00001097          	auipc	ra,0x1
    4b04:	cd0080e7          	jalr	-816(ra) # 57d0 <exit>
      printf("%s: fork failed\n", s);
    4b08:	85ce                	mv	a1,s3
    4b0a:	00002517          	auipc	a0,0x2
    4b0e:	a8e50513          	addi	a0,a0,-1394 # 6598 <malloc+0x996>
    4b12:	00001097          	auipc	ra,0x1
    4b16:	038080e7          	jalr	56(ra) # 5b4a <printf>
      exit(1);
    4b1a:	4505                	li	a0,1
    4b1c:	00001097          	auipc	ra,0x1
    4b20:	cb4080e7          	jalr	-844(ra) # 57d0 <exit>
      close(open(file, 0));
    4b24:	4581                	li	a1,0
    4b26:	fa840513          	addi	a0,s0,-88
    4b2a:	00001097          	auipc	ra,0x1
    4b2e:	ce6080e7          	jalr	-794(ra) # 5810 <open>
    4b32:	00001097          	auipc	ra,0x1
    4b36:	cc6080e7          	jalr	-826(ra) # 57f8 <close>
      close(open(file, 0));
    4b3a:	4581                	li	a1,0
    4b3c:	fa840513          	addi	a0,s0,-88
    4b40:	00001097          	auipc	ra,0x1
    4b44:	cd0080e7          	jalr	-816(ra) # 5810 <open>
    4b48:	00001097          	auipc	ra,0x1
    4b4c:	cb0080e7          	jalr	-848(ra) # 57f8 <close>
      close(open(file, 0));
    4b50:	4581                	li	a1,0
    4b52:	fa840513          	addi	a0,s0,-88
    4b56:	00001097          	auipc	ra,0x1
    4b5a:	cba080e7          	jalr	-838(ra) # 5810 <open>
    4b5e:	00001097          	auipc	ra,0x1
    4b62:	c9a080e7          	jalr	-870(ra) # 57f8 <close>
      close(open(file, 0));
    4b66:	4581                	li	a1,0
    4b68:	fa840513          	addi	a0,s0,-88
    4b6c:	00001097          	auipc	ra,0x1
    4b70:	ca4080e7          	jalr	-860(ra) # 5810 <open>
    4b74:	00001097          	auipc	ra,0x1
    4b78:	c84080e7          	jalr	-892(ra) # 57f8 <close>
      close(open(file, 0));
    4b7c:	4581                	li	a1,0
    4b7e:	fa840513          	addi	a0,s0,-88
    4b82:	00001097          	auipc	ra,0x1
    4b86:	c8e080e7          	jalr	-882(ra) # 5810 <open>
    4b8a:	00001097          	auipc	ra,0x1
    4b8e:	c6e080e7          	jalr	-914(ra) # 57f8 <close>
      close(open(file, 0));
    4b92:	4581                	li	a1,0
    4b94:	fa840513          	addi	a0,s0,-88
    4b98:	00001097          	auipc	ra,0x1
    4b9c:	c78080e7          	jalr	-904(ra) # 5810 <open>
    4ba0:	00001097          	auipc	ra,0x1
    4ba4:	c58080e7          	jalr	-936(ra) # 57f8 <close>
    if(pid == 0)
    4ba8:	08090363          	beqz	s2,4c2e <concreate+0x2d2>
      wait(0);
    4bac:	4501                	li	a0,0
    4bae:	00001097          	auipc	ra,0x1
    4bb2:	c2a080e7          	jalr	-982(ra) # 57d8 <wait>
  for(i = 0; i < N; i++){
    4bb6:	2485                	addiw	s1,s1,1
    4bb8:	0f448563          	beq	s1,s4,4ca2 <concreate+0x346>
    file[1] = '0' + i;
    4bbc:	0304879b          	addiw	a5,s1,48
    4bc0:	faf404a3          	sb	a5,-87(s0)
    pid = fork();
    4bc4:	00001097          	auipc	ra,0x1
    4bc8:	c04080e7          	jalr	-1020(ra) # 57c8 <fork>
    4bcc:	892a                	mv	s2,a0
    if(pid < 0){
    4bce:	f2054de3          	bltz	a0,4b08 <concreate+0x1ac>
    if(((i % 3) == 0 && pid == 0) ||
    4bd2:	0354e73b          	remw	a4,s1,s5
    4bd6:	00a767b3          	or	a5,a4,a0
    4bda:	2781                	sext.w	a5,a5
    4bdc:	d7a1                	beqz	a5,4b24 <concreate+0x1c8>
    4bde:	01671363          	bne	a4,s6,4be4 <concreate+0x288>
       ((i % 3) == 1 && pid != 0)){
    4be2:	f129                	bnez	a0,4b24 <concreate+0x1c8>
      unlink(file);
    4be4:	fa840513          	addi	a0,s0,-88
    4be8:	00001097          	auipc	ra,0x1
    4bec:	c38080e7          	jalr	-968(ra) # 5820 <unlink>
      unlink(file);
    4bf0:	fa840513          	addi	a0,s0,-88
    4bf4:	00001097          	auipc	ra,0x1
    4bf8:	c2c080e7          	jalr	-980(ra) # 5820 <unlink>
      unlink(file);
    4bfc:	fa840513          	addi	a0,s0,-88
    4c00:	00001097          	auipc	ra,0x1
    4c04:	c20080e7          	jalr	-992(ra) # 5820 <unlink>
      unlink(file);
    4c08:	fa840513          	addi	a0,s0,-88
    4c0c:	00001097          	auipc	ra,0x1
    4c10:	c14080e7          	jalr	-1004(ra) # 5820 <unlink>
      unlink(file);
    4c14:	fa840513          	addi	a0,s0,-88
    4c18:	00001097          	auipc	ra,0x1
    4c1c:	c08080e7          	jalr	-1016(ra) # 5820 <unlink>
      unlink(file);
    4c20:	fa840513          	addi	a0,s0,-88
    4c24:	00001097          	auipc	ra,0x1
    4c28:	bfc080e7          	jalr	-1028(ra) # 5820 <unlink>
    4c2c:	bfb5                	j	4ba8 <concreate+0x24c>
      exit(0);
    4c2e:	4501                	li	a0,0
    4c30:	00001097          	auipc	ra,0x1
    4c34:	ba0080e7          	jalr	-1120(ra) # 57d0 <exit>
      close(fd);
    4c38:	00001097          	auipc	ra,0x1
    4c3c:	bc0080e7          	jalr	-1088(ra) # 57f8 <close>
    if(pid == 0) {
    4c40:	bb5d                	j	49f6 <concreate+0x9a>
      close(fd);
    4c42:	00001097          	auipc	ra,0x1
    4c46:	bb6080e7          	jalr	-1098(ra) # 57f8 <close>
      wait(&xstatus);
    4c4a:	f6c40513          	addi	a0,s0,-148
    4c4e:	00001097          	auipc	ra,0x1
    4c52:	b8a080e7          	jalr	-1142(ra) # 57d8 <wait>
      if(xstatus != 0)
    4c56:	f6c42483          	lw	s1,-148(s0)
    4c5a:	da0493e3          	bnez	s1,4a00 <concreate+0xa4>
  for(i = 0; i < N; i++){
    4c5e:	2905                	addiw	s2,s2,1
    4c60:	db4905e3          	beq	s2,s4,4a0a <concreate+0xae>
    file[1] = '0' + i;
    4c64:	0309079b          	addiw	a5,s2,48
    4c68:	faf404a3          	sb	a5,-87(s0)
    unlink(file);
    4c6c:	fa840513          	addi	a0,s0,-88
    4c70:	00001097          	auipc	ra,0x1
    4c74:	bb0080e7          	jalr	-1104(ra) # 5820 <unlink>
    pid = fork();
    4c78:	00001097          	auipc	ra,0x1
    4c7c:	b50080e7          	jalr	-1200(ra) # 57c8 <fork>
    if(pid && (i % 3) == 1){
    4c80:	d20502e3          	beqz	a0,49a4 <concreate+0x48>
    4c84:	036967bb          	remw	a5,s2,s6
    4c88:	d15786e3          	beq	a5,s5,4994 <concreate+0x38>
      fd = open(file, O_CREATE | O_RDWR);
    4c8c:	20200593          	li	a1,514
    4c90:	fa840513          	addi	a0,s0,-88
    4c94:	00001097          	auipc	ra,0x1
    4c98:	b7c080e7          	jalr	-1156(ra) # 5810 <open>
      if(fd < 0){
    4c9c:	fa0553e3          	bgez	a0,4c42 <concreate+0x2e6>
    4ca0:	b315                	j	49c4 <concreate+0x68>
}
    4ca2:	60ea                	ld	ra,152(sp)
    4ca4:	644a                	ld	s0,144(sp)
    4ca6:	64aa                	ld	s1,136(sp)
    4ca8:	690a                	ld	s2,128(sp)
    4caa:	79e6                	ld	s3,120(sp)
    4cac:	7a46                	ld	s4,112(sp)
    4cae:	7aa6                	ld	s5,104(sp)
    4cb0:	7b06                	ld	s6,96(sp)
    4cb2:	6be6                	ld	s7,88(sp)
    4cb4:	610d                	addi	sp,sp,160
    4cb6:	8082                	ret

0000000000004cb8 <bigfile>:
{
    4cb8:	7139                	addi	sp,sp,-64
    4cba:	fc06                	sd	ra,56(sp)
    4cbc:	f822                	sd	s0,48(sp)
    4cbe:	f426                	sd	s1,40(sp)
    4cc0:	f04a                	sd	s2,32(sp)
    4cc2:	ec4e                	sd	s3,24(sp)
    4cc4:	e852                	sd	s4,16(sp)
    4cc6:	e456                	sd	s5,8(sp)
    4cc8:	0080                	addi	s0,sp,64
    4cca:	8aaa                	mv	s5,a0
  unlink("bigfile.dat");
    4ccc:	00003517          	auipc	a0,0x3
    4cd0:	dd450513          	addi	a0,a0,-556 # 7aa0 <malloc+0x1e9e>
    4cd4:	00001097          	auipc	ra,0x1
    4cd8:	b4c080e7          	jalr	-1204(ra) # 5820 <unlink>
  fd = open("bigfile.dat", O_CREATE | O_RDWR);
    4cdc:	20200593          	li	a1,514
    4ce0:	00003517          	auipc	a0,0x3
    4ce4:	dc050513          	addi	a0,a0,-576 # 7aa0 <malloc+0x1e9e>
    4ce8:	00001097          	auipc	ra,0x1
    4cec:	b28080e7          	jalr	-1240(ra) # 5810 <open>
    4cf0:	89aa                	mv	s3,a0
  for(i = 0; i < N; i++){
    4cf2:	4481                	li	s1,0
    memset(buf, i, SZ);
    4cf4:	00007917          	auipc	s2,0x7
    4cf8:	08490913          	addi	s2,s2,132 # bd78 <buf>
  for(i = 0; i < N; i++){
    4cfc:	4a51                	li	s4,20
  if(fd < 0){
    4cfe:	0a054063          	bltz	a0,4d9e <bigfile+0xe6>
    memset(buf, i, SZ);
    4d02:	25800613          	li	a2,600
    4d06:	85a6                	mv	a1,s1
    4d08:	854a                	mv	a0,s2
    4d0a:	00001097          	auipc	ra,0x1
    4d0e:	8cc080e7          	jalr	-1844(ra) # 55d6 <memset>
    if(write(fd, buf, SZ) != SZ){
    4d12:	25800613          	li	a2,600
    4d16:	85ca                	mv	a1,s2
    4d18:	854e                	mv	a0,s3
    4d1a:	00001097          	auipc	ra,0x1
    4d1e:	ad6080e7          	jalr	-1322(ra) # 57f0 <write>
    4d22:	25800793          	li	a5,600
    4d26:	08f51a63          	bne	a0,a5,4dba <bigfile+0x102>
  for(i = 0; i < N; i++){
    4d2a:	2485                	addiw	s1,s1,1
    4d2c:	fd449be3          	bne	s1,s4,4d02 <bigfile+0x4a>
  close(fd);
    4d30:	854e                	mv	a0,s3
    4d32:	00001097          	auipc	ra,0x1
    4d36:	ac6080e7          	jalr	-1338(ra) # 57f8 <close>
  fd = open("bigfile.dat", 0);
    4d3a:	4581                	li	a1,0
    4d3c:	00003517          	auipc	a0,0x3
    4d40:	d6450513          	addi	a0,a0,-668 # 7aa0 <malloc+0x1e9e>
    4d44:	00001097          	auipc	ra,0x1
    4d48:	acc080e7          	jalr	-1332(ra) # 5810 <open>
    4d4c:	8a2a                	mv	s4,a0
  total = 0;
    4d4e:	4981                	li	s3,0
  for(i = 0; ; i++){
    4d50:	4481                	li	s1,0
    cc = read(fd, buf, SZ/2);
    4d52:	00007917          	auipc	s2,0x7
    4d56:	02690913          	addi	s2,s2,38 # bd78 <buf>
  if(fd < 0){
    4d5a:	06054e63          	bltz	a0,4dd6 <bigfile+0x11e>
    cc = read(fd, buf, SZ/2);
    4d5e:	12c00613          	li	a2,300
    4d62:	85ca                	mv	a1,s2
    4d64:	8552                	mv	a0,s4
    4d66:	00001097          	auipc	ra,0x1
    4d6a:	a82080e7          	jalr	-1406(ra) # 57e8 <read>
    if(cc < 0){
    4d6e:	08054263          	bltz	a0,4df2 <bigfile+0x13a>
    if(cc == 0)
    4d72:	c971                	beqz	a0,4e46 <bigfile+0x18e>
    if(cc != SZ/2){
    4d74:	12c00793          	li	a5,300
    4d78:	08f51b63          	bne	a0,a5,4e0e <bigfile+0x156>
    if(buf[0] != i/2 || buf[SZ/2-1] != i/2){
    4d7c:	01f4d79b          	srliw	a5,s1,0x1f
    4d80:	9fa5                	addw	a5,a5,s1
    4d82:	4017d79b          	sraiw	a5,a5,0x1
    4d86:	00094703          	lbu	a4,0(s2)
    4d8a:	0af71063          	bne	a4,a5,4e2a <bigfile+0x172>
    4d8e:	12b94703          	lbu	a4,299(s2)
    4d92:	08f71c63          	bne	a4,a5,4e2a <bigfile+0x172>
    total += cc;
    4d96:	12c9899b          	addiw	s3,s3,300
  for(i = 0; ; i++){
    4d9a:	2485                	addiw	s1,s1,1
    cc = read(fd, buf, SZ/2);
    4d9c:	b7c9                	j	4d5e <bigfile+0xa6>
    printf("%s: cannot create bigfile", s);
    4d9e:	85d6                	mv	a1,s5
    4da0:	00003517          	auipc	a0,0x3
    4da4:	d1050513          	addi	a0,a0,-752 # 7ab0 <malloc+0x1eae>
    4da8:	00001097          	auipc	ra,0x1
    4dac:	da2080e7          	jalr	-606(ra) # 5b4a <printf>
    exit(1);
    4db0:	4505                	li	a0,1
    4db2:	00001097          	auipc	ra,0x1
    4db6:	a1e080e7          	jalr	-1506(ra) # 57d0 <exit>
      printf("%s: write bigfile failed\n", s);
    4dba:	85d6                	mv	a1,s5
    4dbc:	00003517          	auipc	a0,0x3
    4dc0:	d1450513          	addi	a0,a0,-748 # 7ad0 <malloc+0x1ece>
    4dc4:	00001097          	auipc	ra,0x1
    4dc8:	d86080e7          	jalr	-634(ra) # 5b4a <printf>
      exit(1);
    4dcc:	4505                	li	a0,1
    4dce:	00001097          	auipc	ra,0x1
    4dd2:	a02080e7          	jalr	-1534(ra) # 57d0 <exit>
    printf("%s: cannot open bigfile\n", s);
    4dd6:	85d6                	mv	a1,s5
    4dd8:	00003517          	auipc	a0,0x3
    4ddc:	d1850513          	addi	a0,a0,-744 # 7af0 <malloc+0x1eee>
    4de0:	00001097          	auipc	ra,0x1
    4de4:	d6a080e7          	jalr	-662(ra) # 5b4a <printf>
    exit(1);
    4de8:	4505                	li	a0,1
    4dea:	00001097          	auipc	ra,0x1
    4dee:	9e6080e7          	jalr	-1562(ra) # 57d0 <exit>
      printf("%s: read bigfile failed\n", s);
    4df2:	85d6                	mv	a1,s5
    4df4:	00003517          	auipc	a0,0x3
    4df8:	d1c50513          	addi	a0,a0,-740 # 7b10 <malloc+0x1f0e>
    4dfc:	00001097          	auipc	ra,0x1
    4e00:	d4e080e7          	jalr	-690(ra) # 5b4a <printf>
      exit(1);
    4e04:	4505                	li	a0,1
    4e06:	00001097          	auipc	ra,0x1
    4e0a:	9ca080e7          	jalr	-1590(ra) # 57d0 <exit>
      printf("%s: short read bigfile\n", s);
    4e0e:	85d6                	mv	a1,s5
    4e10:	00003517          	auipc	a0,0x3
    4e14:	d2050513          	addi	a0,a0,-736 # 7b30 <malloc+0x1f2e>
    4e18:	00001097          	auipc	ra,0x1
    4e1c:	d32080e7          	jalr	-718(ra) # 5b4a <printf>
      exit(1);
    4e20:	4505                	li	a0,1
    4e22:	00001097          	auipc	ra,0x1
    4e26:	9ae080e7          	jalr	-1618(ra) # 57d0 <exit>
      printf("%s: read bigfile wrong data\n", s);
    4e2a:	85d6                	mv	a1,s5
    4e2c:	00003517          	auipc	a0,0x3
    4e30:	d1c50513          	addi	a0,a0,-740 # 7b48 <malloc+0x1f46>
    4e34:	00001097          	auipc	ra,0x1
    4e38:	d16080e7          	jalr	-746(ra) # 5b4a <printf>
      exit(1);
    4e3c:	4505                	li	a0,1
    4e3e:	00001097          	auipc	ra,0x1
    4e42:	992080e7          	jalr	-1646(ra) # 57d0 <exit>
  close(fd);
    4e46:	8552                	mv	a0,s4
    4e48:	00001097          	auipc	ra,0x1
    4e4c:	9b0080e7          	jalr	-1616(ra) # 57f8 <close>
  if(total != N*SZ){
    4e50:	678d                	lui	a5,0x3
    4e52:	ee078793          	addi	a5,a5,-288 # 2ee0 <fourteen+0x182>
    4e56:	02f99363          	bne	s3,a5,4e7c <bigfile+0x1c4>
  unlink("bigfile.dat");
    4e5a:	00003517          	auipc	a0,0x3
    4e5e:	c4650513          	addi	a0,a0,-954 # 7aa0 <malloc+0x1e9e>
    4e62:	00001097          	auipc	ra,0x1
    4e66:	9be080e7          	jalr	-1602(ra) # 5820 <unlink>
}
    4e6a:	70e2                	ld	ra,56(sp)
    4e6c:	7442                	ld	s0,48(sp)
    4e6e:	74a2                	ld	s1,40(sp)
    4e70:	7902                	ld	s2,32(sp)
    4e72:	69e2                	ld	s3,24(sp)
    4e74:	6a42                	ld	s4,16(sp)
    4e76:	6aa2                	ld	s5,8(sp)
    4e78:	6121                	addi	sp,sp,64
    4e7a:	8082                	ret
    printf("%s: read bigfile wrong total\n", s);
    4e7c:	85d6                	mv	a1,s5
    4e7e:	00003517          	auipc	a0,0x3
    4e82:	cea50513          	addi	a0,a0,-790 # 7b68 <malloc+0x1f66>
    4e86:	00001097          	auipc	ra,0x1
    4e8a:	cc4080e7          	jalr	-828(ra) # 5b4a <printf>
    exit(1);
    4e8e:	4505                	li	a0,1
    4e90:	00001097          	auipc	ra,0x1
    4e94:	940080e7          	jalr	-1728(ra) # 57d0 <exit>

0000000000004e98 <fsfull>:
{
    4e98:	7171                	addi	sp,sp,-176
    4e9a:	f506                	sd	ra,168(sp)
    4e9c:	f122                	sd	s0,160(sp)
    4e9e:	ed26                	sd	s1,152(sp)
    4ea0:	e94a                	sd	s2,144(sp)
    4ea2:	e54e                	sd	s3,136(sp)
    4ea4:	e152                	sd	s4,128(sp)
    4ea6:	fcd6                	sd	s5,120(sp)
    4ea8:	f8da                	sd	s6,112(sp)
    4eaa:	f4de                	sd	s7,104(sp)
    4eac:	f0e2                	sd	s8,96(sp)
    4eae:	ece6                	sd	s9,88(sp)
    4eb0:	e8ea                	sd	s10,80(sp)
    4eb2:	e4ee                	sd	s11,72(sp)
    4eb4:	1900                	addi	s0,sp,176
  printf("fsfull test\n");
    4eb6:	00003517          	auipc	a0,0x3
    4eba:	cd250513          	addi	a0,a0,-814 # 7b88 <malloc+0x1f86>
    4ebe:	00001097          	auipc	ra,0x1
    4ec2:	c8c080e7          	jalr	-884(ra) # 5b4a <printf>
  for(nfiles = 0; ; nfiles++){
    4ec6:	4481                	li	s1,0
    name[0] = 'f';
    4ec8:	06600d13          	li	s10,102
    name[1] = '0' + nfiles / 1000;
    4ecc:	3e800c13          	li	s8,1000
    name[2] = '0' + (nfiles % 1000) / 100;
    4ed0:	06400b93          	li	s7,100
    name[3] = '0' + (nfiles % 100) / 10;
    4ed4:	4b29                	li	s6,10
    printf("writing %s\n", name);
    4ed6:	00003c97          	auipc	s9,0x3
    4eda:	cc2c8c93          	addi	s9,s9,-830 # 7b98 <malloc+0x1f96>
    int total = 0;
    4ede:	4d81                	li	s11,0
      int cc = write(fd, buf, BSIZE);
    4ee0:	00007a17          	auipc	s4,0x7
    4ee4:	e98a0a13          	addi	s4,s4,-360 # bd78 <buf>
    name[0] = 'f';
    4ee8:	f5a40823          	sb	s10,-176(s0)
    name[1] = '0' + nfiles / 1000;
    4eec:	0384c7bb          	divw	a5,s1,s8
    4ef0:	0307879b          	addiw	a5,a5,48
    4ef4:	f4f408a3          	sb	a5,-175(s0)
    name[2] = '0' + (nfiles % 1000) / 100;
    4ef8:	0384e7bb          	remw	a5,s1,s8
    4efc:	0377c7bb          	divw	a5,a5,s7
    4f00:	0307879b          	addiw	a5,a5,48
    4f04:	f4f40923          	sb	a5,-174(s0)
    name[3] = '0' + (nfiles % 100) / 10;
    4f08:	0374e7bb          	remw	a5,s1,s7
    4f0c:	0367c7bb          	divw	a5,a5,s6
    4f10:	0307879b          	addiw	a5,a5,48
    4f14:	f4f409a3          	sb	a5,-173(s0)
    name[4] = '0' + (nfiles % 10);
    4f18:	0364e7bb          	remw	a5,s1,s6
    4f1c:	0307879b          	addiw	a5,a5,48
    4f20:	f4f40a23          	sb	a5,-172(s0)
    name[5] = '\0';
    4f24:	f4040aa3          	sb	zero,-171(s0)
    printf("writing %s\n", name);
    4f28:	f5040593          	addi	a1,s0,-176
    4f2c:	8566                	mv	a0,s9
    4f2e:	00001097          	auipc	ra,0x1
    4f32:	c1c080e7          	jalr	-996(ra) # 5b4a <printf>
    int fd = open(name, O_CREATE|O_RDWR);
    4f36:	20200593          	li	a1,514
    4f3a:	f5040513          	addi	a0,s0,-176
    4f3e:	00001097          	auipc	ra,0x1
    4f42:	8d2080e7          	jalr	-1838(ra) # 5810 <open>
    4f46:	892a                	mv	s2,a0
    if(fd < 0){
    4f48:	0a055663          	bgez	a0,4ff4 <fsfull+0x15c>
      printf("open %s failed\n", name);
    4f4c:	f5040593          	addi	a1,s0,-176
    4f50:	00003517          	auipc	a0,0x3
    4f54:	c5850513          	addi	a0,a0,-936 # 7ba8 <malloc+0x1fa6>
    4f58:	00001097          	auipc	ra,0x1
    4f5c:	bf2080e7          	jalr	-1038(ra) # 5b4a <printf>
  while(nfiles >= 0){
    4f60:	0604c363          	bltz	s1,4fc6 <fsfull+0x12e>
    name[0] = 'f';
    4f64:	06600b13          	li	s6,102
    name[1] = '0' + nfiles / 1000;
    4f68:	3e800a13          	li	s4,1000
    name[2] = '0' + (nfiles % 1000) / 100;
    4f6c:	06400993          	li	s3,100
    name[3] = '0' + (nfiles % 100) / 10;
    4f70:	4929                	li	s2,10
  while(nfiles >= 0){
    4f72:	5afd                	li	s5,-1
    name[0] = 'f';
    4f74:	f5640823          	sb	s6,-176(s0)
    name[1] = '0' + nfiles / 1000;
    4f78:	0344c7bb          	divw	a5,s1,s4
    4f7c:	0307879b          	addiw	a5,a5,48
    4f80:	f4f408a3          	sb	a5,-175(s0)
    name[2] = '0' + (nfiles % 1000) / 100;
    4f84:	0344e7bb          	remw	a5,s1,s4
    4f88:	0337c7bb          	divw	a5,a5,s3
    4f8c:	0307879b          	addiw	a5,a5,48
    4f90:	f4f40923          	sb	a5,-174(s0)
    name[3] = '0' + (nfiles % 100) / 10;
    4f94:	0334e7bb          	remw	a5,s1,s3
    4f98:	0327c7bb          	divw	a5,a5,s2
    4f9c:	0307879b          	addiw	a5,a5,48
    4fa0:	f4f409a3          	sb	a5,-173(s0)
    name[4] = '0' + (nfiles % 10);
    4fa4:	0324e7bb          	remw	a5,s1,s2
    4fa8:	0307879b          	addiw	a5,a5,48
    4fac:	f4f40a23          	sb	a5,-172(s0)
    name[5] = '\0';
    4fb0:	f4040aa3          	sb	zero,-171(s0)
    unlink(name);
    4fb4:	f5040513          	addi	a0,s0,-176
    4fb8:	00001097          	auipc	ra,0x1
    4fbc:	868080e7          	jalr	-1944(ra) # 5820 <unlink>
    nfiles--;
    4fc0:	34fd                	addiw	s1,s1,-1
  while(nfiles >= 0){
    4fc2:	fb5499e3          	bne	s1,s5,4f74 <fsfull+0xdc>
  printf("fsfull test finished\n");
    4fc6:	00003517          	auipc	a0,0x3
    4fca:	c0250513          	addi	a0,a0,-1022 # 7bc8 <malloc+0x1fc6>
    4fce:	00001097          	auipc	ra,0x1
    4fd2:	b7c080e7          	jalr	-1156(ra) # 5b4a <printf>
}
    4fd6:	70aa                	ld	ra,168(sp)
    4fd8:	740a                	ld	s0,160(sp)
    4fda:	64ea                	ld	s1,152(sp)
    4fdc:	694a                	ld	s2,144(sp)
    4fde:	69aa                	ld	s3,136(sp)
    4fe0:	6a0a                	ld	s4,128(sp)
    4fe2:	7ae6                	ld	s5,120(sp)
    4fe4:	7b46                	ld	s6,112(sp)
    4fe6:	7ba6                	ld	s7,104(sp)
    4fe8:	7c06                	ld	s8,96(sp)
    4fea:	6ce6                	ld	s9,88(sp)
    4fec:	6d46                	ld	s10,80(sp)
    4fee:	6da6                	ld	s11,72(sp)
    4ff0:	614d                	addi	sp,sp,176
    4ff2:	8082                	ret
    int total = 0;
    4ff4:	89ee                	mv	s3,s11
      if(cc < BSIZE)
    4ff6:	3ff00a93          	li	s5,1023
      int cc = write(fd, buf, BSIZE);
    4ffa:	40000613          	li	a2,1024
    4ffe:	85d2                	mv	a1,s4
    5000:	854a                	mv	a0,s2
    5002:	00000097          	auipc	ra,0x0
    5006:	7ee080e7          	jalr	2030(ra) # 57f0 <write>
      if(cc < BSIZE)
    500a:	00aad563          	bge	s5,a0,5014 <fsfull+0x17c>
      total += cc;
    500e:	00a989bb          	addw	s3,s3,a0
    while(1){
    5012:	b7e5                	j	4ffa <fsfull+0x162>
    printf("wrote %d bytes\n", total);
    5014:	85ce                	mv	a1,s3
    5016:	00003517          	auipc	a0,0x3
    501a:	ba250513          	addi	a0,a0,-1118 # 7bb8 <malloc+0x1fb6>
    501e:	00001097          	auipc	ra,0x1
    5022:	b2c080e7          	jalr	-1236(ra) # 5b4a <printf>
    close(fd);
    5026:	854a                	mv	a0,s2
    5028:	00000097          	auipc	ra,0x0
    502c:	7d0080e7          	jalr	2000(ra) # 57f8 <close>
    if(total == 0)
    5030:	f20988e3          	beqz	s3,4f60 <fsfull+0xc8>
  for(nfiles = 0; ; nfiles++){
    5034:	2485                	addiw	s1,s1,1
    5036:	bd4d                	j	4ee8 <fsfull+0x50>

0000000000005038 <badwrite>:
{
    5038:	7179                	addi	sp,sp,-48
    503a:	f406                	sd	ra,40(sp)
    503c:	f022                	sd	s0,32(sp)
    503e:	ec26                	sd	s1,24(sp)
    5040:	e84a                	sd	s2,16(sp)
    5042:	e44e                	sd	s3,8(sp)
    5044:	e052                	sd	s4,0(sp)
    5046:	1800                	addi	s0,sp,48
  unlink("junk");
    5048:	00003517          	auipc	a0,0x3
    504c:	b9850513          	addi	a0,a0,-1128 # 7be0 <malloc+0x1fde>
    5050:	00000097          	auipc	ra,0x0
    5054:	7d0080e7          	jalr	2000(ra) # 5820 <unlink>
    5058:	25800913          	li	s2,600
    int fd = open("junk", O_CREATE|O_WRONLY);
    505c:	00003997          	auipc	s3,0x3
    5060:	b8498993          	addi	s3,s3,-1148 # 7be0 <malloc+0x1fde>
    write(fd, (char*)0xffffffffffL, 1);
    5064:	5a7d                	li	s4,-1
    5066:	018a5a13          	srli	s4,s4,0x18
    int fd = open("junk", O_CREATE|O_WRONLY);
    506a:	20100593          	li	a1,513
    506e:	854e                	mv	a0,s3
    5070:	00000097          	auipc	ra,0x0
    5074:	7a0080e7          	jalr	1952(ra) # 5810 <open>
    5078:	84aa                	mv	s1,a0
    if(fd < 0){
    507a:	06054b63          	bltz	a0,50f0 <badwrite+0xb8>
    write(fd, (char*)0xffffffffffL, 1);
    507e:	4605                	li	a2,1
    5080:	85d2                	mv	a1,s4
    5082:	00000097          	auipc	ra,0x0
    5086:	76e080e7          	jalr	1902(ra) # 57f0 <write>
    close(fd);
    508a:	8526                	mv	a0,s1
    508c:	00000097          	auipc	ra,0x0
    5090:	76c080e7          	jalr	1900(ra) # 57f8 <close>
    unlink("junk");
    5094:	854e                	mv	a0,s3
    5096:	00000097          	auipc	ra,0x0
    509a:	78a080e7          	jalr	1930(ra) # 5820 <unlink>
  for(int i = 0; i < assumed_free; i++){
    509e:	397d                	addiw	s2,s2,-1
    50a0:	fc0915e3          	bnez	s2,506a <badwrite+0x32>
  int fd = open("junk", O_CREATE|O_WRONLY);
    50a4:	20100593          	li	a1,513
    50a8:	00003517          	auipc	a0,0x3
    50ac:	b3850513          	addi	a0,a0,-1224 # 7be0 <malloc+0x1fde>
    50b0:	00000097          	auipc	ra,0x0
    50b4:	760080e7          	jalr	1888(ra) # 5810 <open>
    50b8:	84aa                	mv	s1,a0
  if(fd < 0){
    50ba:	04054863          	bltz	a0,510a <badwrite+0xd2>
  if(write(fd, "x", 1) != 1){
    50be:	4605                	li	a2,1
    50c0:	00001597          	auipc	a1,0x1
    50c4:	cd058593          	addi	a1,a1,-816 # 5d90 <malloc+0x18e>
    50c8:	00000097          	auipc	ra,0x0
    50cc:	728080e7          	jalr	1832(ra) # 57f0 <write>
    50d0:	4785                	li	a5,1
    50d2:	04f50963          	beq	a0,a5,5124 <badwrite+0xec>
    printf("write failed\n");
    50d6:	00003517          	auipc	a0,0x3
    50da:	b2a50513          	addi	a0,a0,-1238 # 7c00 <malloc+0x1ffe>
    50de:	00001097          	auipc	ra,0x1
    50e2:	a6c080e7          	jalr	-1428(ra) # 5b4a <printf>
    exit(1);
    50e6:	4505                	li	a0,1
    50e8:	00000097          	auipc	ra,0x0
    50ec:	6e8080e7          	jalr	1768(ra) # 57d0 <exit>
      printf("open junk failed\n");
    50f0:	00003517          	auipc	a0,0x3
    50f4:	af850513          	addi	a0,a0,-1288 # 7be8 <malloc+0x1fe6>
    50f8:	00001097          	auipc	ra,0x1
    50fc:	a52080e7          	jalr	-1454(ra) # 5b4a <printf>
      exit(1);
    5100:	4505                	li	a0,1
    5102:	00000097          	auipc	ra,0x0
    5106:	6ce080e7          	jalr	1742(ra) # 57d0 <exit>
    printf("open junk failed\n");
    510a:	00003517          	auipc	a0,0x3
    510e:	ade50513          	addi	a0,a0,-1314 # 7be8 <malloc+0x1fe6>
    5112:	00001097          	auipc	ra,0x1
    5116:	a38080e7          	jalr	-1480(ra) # 5b4a <printf>
    exit(1);
    511a:	4505                	li	a0,1
    511c:	00000097          	auipc	ra,0x0
    5120:	6b4080e7          	jalr	1716(ra) # 57d0 <exit>
  close(fd);
    5124:	8526                	mv	a0,s1
    5126:	00000097          	auipc	ra,0x0
    512a:	6d2080e7          	jalr	1746(ra) # 57f8 <close>
  unlink("junk");
    512e:	00003517          	auipc	a0,0x3
    5132:	ab250513          	addi	a0,a0,-1358 # 7be0 <malloc+0x1fde>
    5136:	00000097          	auipc	ra,0x0
    513a:	6ea080e7          	jalr	1770(ra) # 5820 <unlink>
  exit(0);
    513e:	4501                	li	a0,0
    5140:	00000097          	auipc	ra,0x0
    5144:	690080e7          	jalr	1680(ra) # 57d0 <exit>

0000000000005148 <countfree>:
// because out of memory with lazy allocation results in the process
// taking a fault and being killed, fork and report back.
//
int
countfree()
{
    5148:	7139                	addi	sp,sp,-64
    514a:	fc06                	sd	ra,56(sp)
    514c:	f822                	sd	s0,48(sp)
    514e:	f426                	sd	s1,40(sp)
    5150:	f04a                	sd	s2,32(sp)
    5152:	ec4e                	sd	s3,24(sp)
    5154:	0080                	addi	s0,sp,64
  int fds[2];

  if(pipe(fds) < 0){
    5156:	fc840513          	addi	a0,s0,-56
    515a:	00000097          	auipc	ra,0x0
    515e:	686080e7          	jalr	1670(ra) # 57e0 <pipe>
    5162:	06054763          	bltz	a0,51d0 <countfree+0x88>
    printf("pipe() failed in countfree()\n");
    exit(1);
  }
  
  int pid = fork();
    5166:	00000097          	auipc	ra,0x0
    516a:	662080e7          	jalr	1634(ra) # 57c8 <fork>

  if(pid < 0){
    516e:	06054e63          	bltz	a0,51ea <countfree+0xa2>
    printf("fork failed in countfree()\n");
    exit(1);
  }

  if(pid == 0){
    5172:	ed51                	bnez	a0,520e <countfree+0xc6>
    close(fds[0]);
    5174:	fc842503          	lw	a0,-56(s0)
    5178:	00000097          	auipc	ra,0x0
    517c:	680080e7          	jalr	1664(ra) # 57f8 <close>
    
    while(1){
      uint64 a = (uint64) sbrk(4096);
      if(a == 0xffffffffffffffff){
    5180:	597d                	li	s2,-1
        break;
      }

      // modify the memory to make sure it's really allocated.
      *(char *)(a + 4096 - 1) = 1;
    5182:	4485                	li	s1,1

      // report back one more page.
      if(write(fds[1], "x", 1) != 1){
    5184:	00001997          	auipc	s3,0x1
    5188:	c0c98993          	addi	s3,s3,-1012 # 5d90 <malloc+0x18e>
      uint64 a = (uint64) sbrk(4096);
    518c:	6505                	lui	a0,0x1
    518e:	00000097          	auipc	ra,0x0
    5192:	6ca080e7          	jalr	1738(ra) # 5858 <sbrk>
      if(a == 0xffffffffffffffff){
    5196:	07250763          	beq	a0,s2,5204 <countfree+0xbc>
      *(char *)(a + 4096 - 1) = 1;
    519a:	6785                	lui	a5,0x1
    519c:	97aa                	add	a5,a5,a0
    519e:	fe978fa3          	sb	s1,-1(a5) # fff <linktest+0x213>
      if(write(fds[1], "x", 1) != 1){
    51a2:	8626                	mv	a2,s1
    51a4:	85ce                	mv	a1,s3
    51a6:	fcc42503          	lw	a0,-52(s0)
    51aa:	00000097          	auipc	ra,0x0
    51ae:	646080e7          	jalr	1606(ra) # 57f0 <write>
    51b2:	fc950de3          	beq	a0,s1,518c <countfree+0x44>
        printf("write() failed in countfree()\n");
    51b6:	00003517          	auipc	a0,0x3
    51ba:	a9a50513          	addi	a0,a0,-1382 # 7c50 <malloc+0x204e>
    51be:	00001097          	auipc	ra,0x1
    51c2:	98c080e7          	jalr	-1652(ra) # 5b4a <printf>
        exit(1);
    51c6:	4505                	li	a0,1
    51c8:	00000097          	auipc	ra,0x0
    51cc:	608080e7          	jalr	1544(ra) # 57d0 <exit>
    printf("pipe() failed in countfree()\n");
    51d0:	00003517          	auipc	a0,0x3
    51d4:	a4050513          	addi	a0,a0,-1472 # 7c10 <malloc+0x200e>
    51d8:	00001097          	auipc	ra,0x1
    51dc:	972080e7          	jalr	-1678(ra) # 5b4a <printf>
    exit(1);
    51e0:	4505                	li	a0,1
    51e2:	00000097          	auipc	ra,0x0
    51e6:	5ee080e7          	jalr	1518(ra) # 57d0 <exit>
    printf("fork failed in countfree()\n");
    51ea:	00003517          	auipc	a0,0x3
    51ee:	a4650513          	addi	a0,a0,-1466 # 7c30 <malloc+0x202e>
    51f2:	00001097          	auipc	ra,0x1
    51f6:	958080e7          	jalr	-1704(ra) # 5b4a <printf>
    exit(1);
    51fa:	4505                	li	a0,1
    51fc:	00000097          	auipc	ra,0x0
    5200:	5d4080e7          	jalr	1492(ra) # 57d0 <exit>
      }
    }

    exit(0);
    5204:	4501                	li	a0,0
    5206:	00000097          	auipc	ra,0x0
    520a:	5ca080e7          	jalr	1482(ra) # 57d0 <exit>
  }

  close(fds[1]);
    520e:	fcc42503          	lw	a0,-52(s0)
    5212:	00000097          	auipc	ra,0x0
    5216:	5e6080e7          	jalr	1510(ra) # 57f8 <close>

  int n = 0;
    521a:	4481                	li	s1,0
  while(1){
    char c;
    int cc = read(fds[0], &c, 1);
    521c:	4605                	li	a2,1
    521e:	fc740593          	addi	a1,s0,-57
    5222:	fc842503          	lw	a0,-56(s0)
    5226:	00000097          	auipc	ra,0x0
    522a:	5c2080e7          	jalr	1474(ra) # 57e8 <read>
    if(cc < 0){
    522e:	00054563          	bltz	a0,5238 <countfree+0xf0>
      printf("read() failed in countfree()\n");
      exit(1);
    }
    if(cc == 0)
    5232:	c105                	beqz	a0,5252 <countfree+0x10a>
      break;
    n += 1;
    5234:	2485                	addiw	s1,s1,1
  while(1){
    5236:	b7dd                	j	521c <countfree+0xd4>
      printf("read() failed in countfree()\n");
    5238:	00003517          	auipc	a0,0x3
    523c:	a3850513          	addi	a0,a0,-1480 # 7c70 <malloc+0x206e>
    5240:	00001097          	auipc	ra,0x1
    5244:	90a080e7          	jalr	-1782(ra) # 5b4a <printf>
      exit(1);
    5248:	4505                	li	a0,1
    524a:	00000097          	auipc	ra,0x0
    524e:	586080e7          	jalr	1414(ra) # 57d0 <exit>
  }

  close(fds[0]);
    5252:	fc842503          	lw	a0,-56(s0)
    5256:	00000097          	auipc	ra,0x0
    525a:	5a2080e7          	jalr	1442(ra) # 57f8 <close>
  wait((int*)0);
    525e:	4501                	li	a0,0
    5260:	00000097          	auipc	ra,0x0
    5264:	578080e7          	jalr	1400(ra) # 57d8 <wait>
  
  return n;
}
    5268:	8526                	mv	a0,s1
    526a:	70e2                	ld	ra,56(sp)
    526c:	7442                	ld	s0,48(sp)
    526e:	74a2                	ld	s1,40(sp)
    5270:	7902                	ld	s2,32(sp)
    5272:	69e2                	ld	s3,24(sp)
    5274:	6121                	addi	sp,sp,64
    5276:	8082                	ret

0000000000005278 <run>:

// run each test in its own process. run returns 1 if child's exit()
// indicates success.
int
run(void f(char *), char *s) {
    5278:	7179                	addi	sp,sp,-48
    527a:	f406                	sd	ra,40(sp)
    527c:	f022                	sd	s0,32(sp)
    527e:	ec26                	sd	s1,24(sp)
    5280:	e84a                	sd	s2,16(sp)
    5282:	1800                	addi	s0,sp,48
    5284:	84aa                	mv	s1,a0
    5286:	892e                	mv	s2,a1
  int pid;
  int xstatus;

  printf("test %s: ", s);
    5288:	00003517          	auipc	a0,0x3
    528c:	a0850513          	addi	a0,a0,-1528 # 7c90 <malloc+0x208e>
    5290:	00001097          	auipc	ra,0x1
    5294:	8ba080e7          	jalr	-1862(ra) # 5b4a <printf>
  if((pid = fork()) < 0) {
    5298:	00000097          	auipc	ra,0x0
    529c:	530080e7          	jalr	1328(ra) # 57c8 <fork>
    52a0:	02054e63          	bltz	a0,52dc <run+0x64>
    printf("runtest: fork error\n");
    exit(1);
  }
  if(pid == 0) {
    52a4:	c929                	beqz	a0,52f6 <run+0x7e>
    f(s);
    exit(0);
  } else {
    wait(&xstatus);
    52a6:	fdc40513          	addi	a0,s0,-36
    52aa:	00000097          	auipc	ra,0x0
    52ae:	52e080e7          	jalr	1326(ra) # 57d8 <wait>
    if(xstatus != 0) 
    52b2:	fdc42783          	lw	a5,-36(s0)
    52b6:	c7b9                	beqz	a5,5304 <run+0x8c>
      printf("FAILED\n");
    52b8:	00003517          	auipc	a0,0x3
    52bc:	a0050513          	addi	a0,a0,-1536 # 7cb8 <malloc+0x20b6>
    52c0:	00001097          	auipc	ra,0x1
    52c4:	88a080e7          	jalr	-1910(ra) # 5b4a <printf>
    else
      printf("OK\n");
    return xstatus == 0;
    52c8:	fdc42503          	lw	a0,-36(s0)
  }
}
    52cc:	00153513          	seqz	a0,a0
    52d0:	70a2                	ld	ra,40(sp)
    52d2:	7402                	ld	s0,32(sp)
    52d4:	64e2                	ld	s1,24(sp)
    52d6:	6942                	ld	s2,16(sp)
    52d8:	6145                	addi	sp,sp,48
    52da:	8082                	ret
    printf("runtest: fork error\n");
    52dc:	00003517          	auipc	a0,0x3
    52e0:	9c450513          	addi	a0,a0,-1596 # 7ca0 <malloc+0x209e>
    52e4:	00001097          	auipc	ra,0x1
    52e8:	866080e7          	jalr	-1946(ra) # 5b4a <printf>
    exit(1);
    52ec:	4505                	li	a0,1
    52ee:	00000097          	auipc	ra,0x0
    52f2:	4e2080e7          	jalr	1250(ra) # 57d0 <exit>
    f(s);
    52f6:	854a                	mv	a0,s2
    52f8:	9482                	jalr	s1
    exit(0);
    52fa:	4501                	li	a0,0
    52fc:	00000097          	auipc	ra,0x0
    5300:	4d4080e7          	jalr	1236(ra) # 57d0 <exit>
      printf("OK\n");
    5304:	00003517          	auipc	a0,0x3
    5308:	9bc50513          	addi	a0,a0,-1604 # 7cc0 <malloc+0x20be>
    530c:	00001097          	auipc	ra,0x1
    5310:	83e080e7          	jalr	-1986(ra) # 5b4a <printf>
    5314:	bf55                	j	52c8 <run+0x50>

0000000000005316 <main>:

int
main(int argc, char *argv[])
{
    5316:	bd010113          	addi	sp,sp,-1072
    531a:	42113423          	sd	ra,1064(sp)
    531e:	42813023          	sd	s0,1056(sp)
    5322:	40913c23          	sd	s1,1048(sp)
    5326:	41213823          	sd	s2,1040(sp)
    532a:	41313423          	sd	s3,1032(sp)
    532e:	41413023          	sd	s4,1024(sp)
    5332:	3f513c23          	sd	s5,1016(sp)
    5336:	3f613823          	sd	s6,1008(sp)
    533a:	43010413          	addi	s0,sp,1072
    533e:	89aa                	mv	s3,a0
  int continuous = 0;
  char *justone = 0;

  if(argc == 2 && strcmp(argv[1], "-c") == 0){
    5340:	4789                	li	a5,2
    5342:	08f50f63          	beq	a0,a5,53e0 <main+0xca>
    continuous = 1;
  } else if(argc == 2 && strcmp(argv[1], "-C") == 0){
    continuous = 2;
  } else if(argc == 2 && argv[1][0] != '-'){
    justone = argv[1];
  } else if(argc > 1){
    5346:	4785                	li	a5,1
  char *justone = 0;
    5348:	4901                	li	s2,0
  } else if(argc > 1){
    534a:	0ca7c963          	blt	a5,a0,541c <main+0x106>
  }
  
  struct test {
    void (*f)(char *);
    char *s;
  } tests[] = {
    534e:	00003797          	auipc	a5,0x3
    5352:	d9a78793          	addi	a5,a5,-614 # 80e8 <malloc+0x24e6>
    5356:	bd040713          	addi	a4,s0,-1072
    535a:	00003317          	auipc	t1,0x3
    535e:	17e30313          	addi	t1,t1,382 # 84d8 <malloc+0x28d6>
    5362:	0007b883          	ld	a7,0(a5)
    5366:	0087b803          	ld	a6,8(a5)
    536a:	6b88                	ld	a0,16(a5)
    536c:	6f8c                	ld	a1,24(a5)
    536e:	7390                	ld	a2,32(a5)
    5370:	7794                	ld	a3,40(a5)
    5372:	01173023          	sd	a7,0(a4)
    5376:	01073423          	sd	a6,8(a4)
    537a:	eb08                	sd	a0,16(a4)
    537c:	ef0c                	sd	a1,24(a4)
    537e:	f310                	sd	a2,32(a4)
    5380:	f714                	sd	a3,40(a4)
    5382:	03078793          	addi	a5,a5,48
    5386:	03070713          	addi	a4,a4,48
    538a:	fc679ce3          	bne	a5,t1,5362 <main+0x4c>
          exit(1);
      }
    }
  }

  printf("usertests starting\n");
    538e:	00003517          	auipc	a0,0x3
    5392:	9ea50513          	addi	a0,a0,-1558 # 7d78 <malloc+0x2176>
    5396:	00000097          	auipc	ra,0x0
    539a:	7b4080e7          	jalr	1972(ra) # 5b4a <printf>
  int free0 = countfree();
    539e:	00000097          	auipc	ra,0x0
    53a2:	daa080e7          	jalr	-598(ra) # 5148 <countfree>
    53a6:	8a2a                	mv	s4,a0
  int free1 = 0;
  int fail = 0;
  for (struct test *t = tests; t->s != 0; t++) {
    53a8:	bd843503          	ld	a0,-1064(s0)
    53ac:	bd040493          	addi	s1,s0,-1072
  int fail = 0;
    53b0:	4981                	li	s3,0
    if((justone == 0) || strcmp(t->s, justone) == 0) {
      if(!run(t->f, t->s))
        fail = 1;
    53b2:	4a85                	li	s5,1
  for (struct test *t = tests; t->s != 0; t++) {
    53b4:	e55d                	bnez	a0,5462 <main+0x14c>
  }

  if(fail){
    printf("SOME TESTS FAILED\n");
    exit(1);
  } else if((free1 = countfree()) < free0){
    53b6:	00000097          	auipc	ra,0x0
    53ba:	d92080e7          	jalr	-622(ra) # 5148 <countfree>
    53be:	85aa                	mv	a1,a0
    53c0:	0f455163          	bge	a0,s4,54a2 <main+0x18c>
    printf("FAILED -- lost some free pages %d (out of %d)\n", free1, free0);
    53c4:	8652                	mv	a2,s4
    53c6:	00003517          	auipc	a0,0x3
    53ca:	96a50513          	addi	a0,a0,-1686 # 7d30 <malloc+0x212e>
    53ce:	00000097          	auipc	ra,0x0
    53d2:	77c080e7          	jalr	1916(ra) # 5b4a <printf>
    exit(1);
    53d6:	4505                	li	a0,1
    53d8:	00000097          	auipc	ra,0x0
    53dc:	3f8080e7          	jalr	1016(ra) # 57d0 <exit>
    53e0:	84ae                	mv	s1,a1
  if(argc == 2 && strcmp(argv[1], "-c") == 0){
    53e2:	00003597          	auipc	a1,0x3
    53e6:	8e658593          	addi	a1,a1,-1818 # 7cc8 <malloc+0x20c6>
    53ea:	6488                	ld	a0,8(s1)
    53ec:	00000097          	auipc	ra,0x0
    53f0:	194080e7          	jalr	404(ra) # 5580 <strcmp>
    53f4:	10050563          	beqz	a0,54fe <main+0x1e8>
  } else if(argc == 2 && strcmp(argv[1], "-C") == 0){
    53f8:	00003597          	auipc	a1,0x3
    53fc:	9b858593          	addi	a1,a1,-1608 # 7db0 <malloc+0x21ae>
    5400:	6488                	ld	a0,8(s1)
    5402:	00000097          	auipc	ra,0x0
    5406:	17e080e7          	jalr	382(ra) # 5580 <strcmp>
    540a:	c97d                	beqz	a0,5500 <main+0x1ea>
  } else if(argc == 2 && argv[1][0] != '-'){
    540c:	0084b903          	ld	s2,8(s1)
    5410:	00094703          	lbu	a4,0(s2)
    5414:	02d00793          	li	a5,45
    5418:	f2f71be3          	bne	a4,a5,534e <main+0x38>
    printf("Usage: usertests [-c] [testname]\n");
    541c:	00003517          	auipc	a0,0x3
    5420:	8b450513          	addi	a0,a0,-1868 # 7cd0 <malloc+0x20ce>
    5424:	00000097          	auipc	ra,0x0
    5428:	726080e7          	jalr	1830(ra) # 5b4a <printf>
    exit(1);
    542c:	4505                	li	a0,1
    542e:	00000097          	auipc	ra,0x0
    5432:	3a2080e7          	jalr	930(ra) # 57d0 <exit>
          exit(1);
    5436:	4505                	li	a0,1
    5438:	00000097          	auipc	ra,0x0
    543c:	398080e7          	jalr	920(ra) # 57d0 <exit>
        printf("FAILED -- lost %d free pages\n", free0 - free1);
    5440:	40a905bb          	subw	a1,s2,a0
    5444:	855a                	mv	a0,s6
    5446:	00000097          	auipc	ra,0x0
    544a:	704080e7          	jalr	1796(ra) # 5b4a <printf>
        if(continuous != 2)
    544e:	09498463          	beq	s3,s4,54d6 <main+0x1c0>
          exit(1);
    5452:	4505                	li	a0,1
    5454:	00000097          	auipc	ra,0x0
    5458:	37c080e7          	jalr	892(ra) # 57d0 <exit>
  for (struct test *t = tests; t->s != 0; t++) {
    545c:	04c1                	addi	s1,s1,16
    545e:	6488                	ld	a0,8(s1)
    5460:	c115                	beqz	a0,5484 <main+0x16e>
    if((justone == 0) || strcmp(t->s, justone) == 0) {
    5462:	00090863          	beqz	s2,5472 <main+0x15c>
    5466:	85ca                	mv	a1,s2
    5468:	00000097          	auipc	ra,0x0
    546c:	118080e7          	jalr	280(ra) # 5580 <strcmp>
    5470:	f575                	bnez	a0,545c <main+0x146>
      if(!run(t->f, t->s))
    5472:	648c                	ld	a1,8(s1)
    5474:	6088                	ld	a0,0(s1)
    5476:	00000097          	auipc	ra,0x0
    547a:	e02080e7          	jalr	-510(ra) # 5278 <run>
    547e:	fd79                	bnez	a0,545c <main+0x146>
        fail = 1;
    5480:	89d6                	mv	s3,s5
    5482:	bfe9                	j	545c <main+0x146>
  if(fail){
    5484:	f20989e3          	beqz	s3,53b6 <main+0xa0>
    printf("SOME TESTS FAILED\n");
    5488:	00003517          	auipc	a0,0x3
    548c:	89050513          	addi	a0,a0,-1904 # 7d18 <malloc+0x2116>
    5490:	00000097          	auipc	ra,0x0
    5494:	6ba080e7          	jalr	1722(ra) # 5b4a <printf>
    exit(1);
    5498:	4505                	li	a0,1
    549a:	00000097          	auipc	ra,0x0
    549e:	336080e7          	jalr	822(ra) # 57d0 <exit>
  } else {
    printf("ALL TESTS PASSED\n");
    54a2:	00003517          	auipc	a0,0x3
    54a6:	8be50513          	addi	a0,a0,-1858 # 7d60 <malloc+0x215e>
    54aa:	00000097          	auipc	ra,0x0
    54ae:	6a0080e7          	jalr	1696(ra) # 5b4a <printf>
    exit(0);
    54b2:	4501                	li	a0,0
    54b4:	00000097          	auipc	ra,0x0
    54b8:	31c080e7          	jalr	796(ra) # 57d0 <exit>
        printf("SOME TESTS FAILED\n");
    54bc:	8556                	mv	a0,s5
    54be:	00000097          	auipc	ra,0x0
    54c2:	68c080e7          	jalr	1676(ra) # 5b4a <printf>
        if(continuous != 2)
    54c6:	f74998e3          	bne	s3,s4,5436 <main+0x120>
      int free1 = countfree();
    54ca:	00000097          	auipc	ra,0x0
    54ce:	c7e080e7          	jalr	-898(ra) # 5148 <countfree>
      if(free1 < free0){
    54d2:	f72547e3          	blt	a0,s2,5440 <main+0x12a>
      int free0 = countfree();
    54d6:	00000097          	auipc	ra,0x0
    54da:	c72080e7          	jalr	-910(ra) # 5148 <countfree>
    54de:	892a                	mv	s2,a0
      for (struct test *t = tests; t->s != 0; t++) {
    54e0:	bd843583          	ld	a1,-1064(s0)
    54e4:	d1fd                	beqz	a1,54ca <main+0x1b4>
    54e6:	bd040493          	addi	s1,s0,-1072
        if(!run(t->f, t->s)){
    54ea:	6088                	ld	a0,0(s1)
    54ec:	00000097          	auipc	ra,0x0
    54f0:	d8c080e7          	jalr	-628(ra) # 5278 <run>
    54f4:	d561                	beqz	a0,54bc <main+0x1a6>
      for (struct test *t = tests; t->s != 0; t++) {
    54f6:	04c1                	addi	s1,s1,16
    54f8:	648c                	ld	a1,8(s1)
    54fa:	f9e5                	bnez	a1,54ea <main+0x1d4>
    54fc:	b7f9                	j	54ca <main+0x1b4>
    continuous = 1;
    54fe:	4985                	li	s3,1
  } tests[] = {
    5500:	00003797          	auipc	a5,0x3
    5504:	be878793          	addi	a5,a5,-1048 # 80e8 <malloc+0x24e6>
    5508:	bd040713          	addi	a4,s0,-1072
    550c:	00003317          	auipc	t1,0x3
    5510:	fcc30313          	addi	t1,t1,-52 # 84d8 <malloc+0x28d6>
    5514:	0007b883          	ld	a7,0(a5)
    5518:	0087b803          	ld	a6,8(a5)
    551c:	6b88                	ld	a0,16(a5)
    551e:	6f8c                	ld	a1,24(a5)
    5520:	7390                	ld	a2,32(a5)
    5522:	7794                	ld	a3,40(a5)
    5524:	01173023          	sd	a7,0(a4)
    5528:	01073423          	sd	a6,8(a4)
    552c:	eb08                	sd	a0,16(a4)
    552e:	ef0c                	sd	a1,24(a4)
    5530:	f310                	sd	a2,32(a4)
    5532:	f714                	sd	a3,40(a4)
    5534:	03078793          	addi	a5,a5,48
    5538:	03070713          	addi	a4,a4,48
    553c:	fc679ce3          	bne	a5,t1,5514 <main+0x1fe>
    printf("continuous usertests starting\n");
    5540:	00003517          	auipc	a0,0x3
    5544:	85050513          	addi	a0,a0,-1968 # 7d90 <malloc+0x218e>
    5548:	00000097          	auipc	ra,0x0
    554c:	602080e7          	jalr	1538(ra) # 5b4a <printf>
        printf("SOME TESTS FAILED\n");
    5550:	00002a97          	auipc	s5,0x2
    5554:	7c8a8a93          	addi	s5,s5,1992 # 7d18 <malloc+0x2116>
        if(continuous != 2)
    5558:	4a09                	li	s4,2
        printf("FAILED -- lost %d free pages\n", free0 - free1);
    555a:	00002b17          	auipc	s6,0x2
    555e:	79eb0b13          	addi	s6,s6,1950 # 7cf8 <malloc+0x20f6>
    5562:	bf95                	j	54d6 <main+0x1c0>

0000000000005564 <strcpy>:

#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
    5564:	1141                	addi	sp,sp,-16
    5566:	e422                	sd	s0,8(sp)
    5568:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    556a:	87aa                	mv	a5,a0
    556c:	0585                	addi	a1,a1,1
    556e:	0785                	addi	a5,a5,1
    5570:	fff5c703          	lbu	a4,-1(a1)
    5574:	fee78fa3          	sb	a4,-1(a5)
    5578:	fb75                	bnez	a4,556c <strcpy+0x8>
    ;
  return os;
}
    557a:	6422                	ld	s0,8(sp)
    557c:	0141                	addi	sp,sp,16
    557e:	8082                	ret

0000000000005580 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    5580:	1141                	addi	sp,sp,-16
    5582:	e422                	sd	s0,8(sp)
    5584:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
    5586:	00054783          	lbu	a5,0(a0)
    558a:	cb91                	beqz	a5,559e <strcmp+0x1e>
    558c:	0005c703          	lbu	a4,0(a1)
    5590:	00f71763          	bne	a4,a5,559e <strcmp+0x1e>
    p++, q++;
    5594:	0505                	addi	a0,a0,1
    5596:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
    5598:	00054783          	lbu	a5,0(a0)
    559c:	fbe5                	bnez	a5,558c <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
    559e:	0005c503          	lbu	a0,0(a1)
}
    55a2:	40a7853b          	subw	a0,a5,a0
    55a6:	6422                	ld	s0,8(sp)
    55a8:	0141                	addi	sp,sp,16
    55aa:	8082                	ret

00000000000055ac <strlen>:

uint
strlen(const char *s)
{
    55ac:	1141                	addi	sp,sp,-16
    55ae:	e422                	sd	s0,8(sp)
    55b0:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
    55b2:	00054783          	lbu	a5,0(a0)
    55b6:	cf91                	beqz	a5,55d2 <strlen+0x26>
    55b8:	0505                	addi	a0,a0,1
    55ba:	87aa                	mv	a5,a0
    55bc:	4685                	li	a3,1
    55be:	9e89                	subw	a3,a3,a0
    55c0:	00f6853b          	addw	a0,a3,a5
    55c4:	0785                	addi	a5,a5,1
    55c6:	fff7c703          	lbu	a4,-1(a5)
    55ca:	fb7d                	bnez	a4,55c0 <strlen+0x14>
    ;
  return n;
}
    55cc:	6422                	ld	s0,8(sp)
    55ce:	0141                	addi	sp,sp,16
    55d0:	8082                	ret
  for(n = 0; s[n]; n++)
    55d2:	4501                	li	a0,0
    55d4:	bfe5                	j	55cc <strlen+0x20>

00000000000055d6 <memset>:

void*
memset(void *dst, int c, uint n)
{
    55d6:	1141                	addi	sp,sp,-16
    55d8:	e422                	sd	s0,8(sp)
    55da:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
    55dc:	ca19                	beqz	a2,55f2 <memset+0x1c>
    55de:	87aa                	mv	a5,a0
    55e0:	1602                	slli	a2,a2,0x20
    55e2:	9201                	srli	a2,a2,0x20
    55e4:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
    55e8:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
    55ec:	0785                	addi	a5,a5,1
    55ee:	fee79de3          	bne	a5,a4,55e8 <memset+0x12>
  }
  return dst;
}
    55f2:	6422                	ld	s0,8(sp)
    55f4:	0141                	addi	sp,sp,16
    55f6:	8082                	ret

00000000000055f8 <strchr>:

char*
strchr(const char *s, char c)
{
    55f8:	1141                	addi	sp,sp,-16
    55fa:	e422                	sd	s0,8(sp)
    55fc:	0800                	addi	s0,sp,16
  for(; *s; s++)
    55fe:	00054783          	lbu	a5,0(a0)
    5602:	cb99                	beqz	a5,5618 <strchr+0x20>
    if(*s == c)
    5604:	00f58763          	beq	a1,a5,5612 <strchr+0x1a>
  for(; *s; s++)
    5608:	0505                	addi	a0,a0,1
    560a:	00054783          	lbu	a5,0(a0)
    560e:	fbfd                	bnez	a5,5604 <strchr+0xc>
      return (char*)s;
  return 0;
    5610:	4501                	li	a0,0
}
    5612:	6422                	ld	s0,8(sp)
    5614:	0141                	addi	sp,sp,16
    5616:	8082                	ret
  return 0;
    5618:	4501                	li	a0,0
    561a:	bfe5                	j	5612 <strchr+0x1a>

000000000000561c <gets>:

char*
gets(char *buf, int max)
{
    561c:	711d                	addi	sp,sp,-96
    561e:	ec86                	sd	ra,88(sp)
    5620:	e8a2                	sd	s0,80(sp)
    5622:	e4a6                	sd	s1,72(sp)
    5624:	e0ca                	sd	s2,64(sp)
    5626:	fc4e                	sd	s3,56(sp)
    5628:	f852                	sd	s4,48(sp)
    562a:	f456                	sd	s5,40(sp)
    562c:	f05a                	sd	s6,32(sp)
    562e:	ec5e                	sd	s7,24(sp)
    5630:	1080                	addi	s0,sp,96
    5632:	8baa                	mv	s7,a0
    5634:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    5636:	892a                	mv	s2,a0
    5638:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
    563a:	4aa9                	li	s5,10
    563c:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
    563e:	89a6                	mv	s3,s1
    5640:	2485                	addiw	s1,s1,1
    5642:	0344d863          	bge	s1,s4,5672 <gets+0x56>
    cc = read(0, &c, 1);
    5646:	4605                	li	a2,1
    5648:	faf40593          	addi	a1,s0,-81
    564c:	4501                	li	a0,0
    564e:	00000097          	auipc	ra,0x0
    5652:	19a080e7          	jalr	410(ra) # 57e8 <read>
    if(cc < 1)
    5656:	00a05e63          	blez	a0,5672 <gets+0x56>
    buf[i++] = c;
    565a:	faf44783          	lbu	a5,-81(s0)
    565e:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
    5662:	01578763          	beq	a5,s5,5670 <gets+0x54>
    5666:	0905                	addi	s2,s2,1
    5668:	fd679be3          	bne	a5,s6,563e <gets+0x22>
  for(i=0; i+1 < max; ){
    566c:	89a6                	mv	s3,s1
    566e:	a011                	j	5672 <gets+0x56>
    5670:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
    5672:	99de                	add	s3,s3,s7
    5674:	00098023          	sb	zero,0(s3)
  return buf;
}
    5678:	855e                	mv	a0,s7
    567a:	60e6                	ld	ra,88(sp)
    567c:	6446                	ld	s0,80(sp)
    567e:	64a6                	ld	s1,72(sp)
    5680:	6906                	ld	s2,64(sp)
    5682:	79e2                	ld	s3,56(sp)
    5684:	7a42                	ld	s4,48(sp)
    5686:	7aa2                	ld	s5,40(sp)
    5688:	7b02                	ld	s6,32(sp)
    568a:	6be2                	ld	s7,24(sp)
    568c:	6125                	addi	sp,sp,96
    568e:	8082                	ret

0000000000005690 <stat>:

int
stat(const char *n, struct stat *st)
{
    5690:	1101                	addi	sp,sp,-32
    5692:	ec06                	sd	ra,24(sp)
    5694:	e822                	sd	s0,16(sp)
    5696:	e426                	sd	s1,8(sp)
    5698:	e04a                	sd	s2,0(sp)
    569a:	1000                	addi	s0,sp,32
    569c:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    569e:	4581                	li	a1,0
    56a0:	00000097          	auipc	ra,0x0
    56a4:	170080e7          	jalr	368(ra) # 5810 <open>
  if(fd < 0)
    56a8:	02054563          	bltz	a0,56d2 <stat+0x42>
    56ac:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
    56ae:	85ca                	mv	a1,s2
    56b0:	00000097          	auipc	ra,0x0
    56b4:	178080e7          	jalr	376(ra) # 5828 <fstat>
    56b8:	892a                	mv	s2,a0
  close(fd);
    56ba:	8526                	mv	a0,s1
    56bc:	00000097          	auipc	ra,0x0
    56c0:	13c080e7          	jalr	316(ra) # 57f8 <close>
  return r;
}
    56c4:	854a                	mv	a0,s2
    56c6:	60e2                	ld	ra,24(sp)
    56c8:	6442                	ld	s0,16(sp)
    56ca:	64a2                	ld	s1,8(sp)
    56cc:	6902                	ld	s2,0(sp)
    56ce:	6105                	addi	sp,sp,32
    56d0:	8082                	ret
    return -1;
    56d2:	597d                	li	s2,-1
    56d4:	bfc5                	j	56c4 <stat+0x34>

00000000000056d6 <atoi>:

int
atoi(const char *s)
{
    56d6:	1141                	addi	sp,sp,-16
    56d8:	e422                	sd	s0,8(sp)
    56da:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    56dc:	00054683          	lbu	a3,0(a0)
    56e0:	fd06879b          	addiw	a5,a3,-48
    56e4:	0ff7f793          	zext.b	a5,a5
    56e8:	4625                	li	a2,9
    56ea:	02f66863          	bltu	a2,a5,571a <atoi+0x44>
    56ee:	872a                	mv	a4,a0
  n = 0;
    56f0:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
    56f2:	0705                	addi	a4,a4,1
    56f4:	0025179b          	slliw	a5,a0,0x2
    56f8:	9fa9                	addw	a5,a5,a0
    56fa:	0017979b          	slliw	a5,a5,0x1
    56fe:	9fb5                	addw	a5,a5,a3
    5700:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
    5704:	00074683          	lbu	a3,0(a4)
    5708:	fd06879b          	addiw	a5,a3,-48
    570c:	0ff7f793          	zext.b	a5,a5
    5710:	fef671e3          	bgeu	a2,a5,56f2 <atoi+0x1c>
  return n;
}
    5714:	6422                	ld	s0,8(sp)
    5716:	0141                	addi	sp,sp,16
    5718:	8082                	ret
  n = 0;
    571a:	4501                	li	a0,0
    571c:	bfe5                	j	5714 <atoi+0x3e>

000000000000571e <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    571e:	1141                	addi	sp,sp,-16
    5720:	e422                	sd	s0,8(sp)
    5722:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
    5724:	02b57463          	bgeu	a0,a1,574c <memmove+0x2e>
    while(n-- > 0)
    5728:	00c05f63          	blez	a2,5746 <memmove+0x28>
    572c:	1602                	slli	a2,a2,0x20
    572e:	9201                	srli	a2,a2,0x20
    5730:	00c507b3          	add	a5,a0,a2
  dst = vdst;
    5734:	872a                	mv	a4,a0
      *dst++ = *src++;
    5736:	0585                	addi	a1,a1,1
    5738:	0705                	addi	a4,a4,1
    573a:	fff5c683          	lbu	a3,-1(a1)
    573e:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
    5742:	fee79ae3          	bne	a5,a4,5736 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
    5746:	6422                	ld	s0,8(sp)
    5748:	0141                	addi	sp,sp,16
    574a:	8082                	ret
    dst += n;
    574c:	00c50733          	add	a4,a0,a2
    src += n;
    5750:	95b2                	add	a1,a1,a2
    while(n-- > 0)
    5752:	fec05ae3          	blez	a2,5746 <memmove+0x28>
    5756:	fff6079b          	addiw	a5,a2,-1
    575a:	1782                	slli	a5,a5,0x20
    575c:	9381                	srli	a5,a5,0x20
    575e:	fff7c793          	not	a5,a5
    5762:	97ba                	add	a5,a5,a4
      *--dst = *--src;
    5764:	15fd                	addi	a1,a1,-1
    5766:	177d                	addi	a4,a4,-1
    5768:	0005c683          	lbu	a3,0(a1)
    576c:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
    5770:	fee79ae3          	bne	a5,a4,5764 <memmove+0x46>
    5774:	bfc9                	j	5746 <memmove+0x28>

0000000000005776 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
    5776:	1141                	addi	sp,sp,-16
    5778:	e422                	sd	s0,8(sp)
    577a:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
    577c:	ca05                	beqz	a2,57ac <memcmp+0x36>
    577e:	fff6069b          	addiw	a3,a2,-1
    5782:	1682                	slli	a3,a3,0x20
    5784:	9281                	srli	a3,a3,0x20
    5786:	0685                	addi	a3,a3,1
    5788:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
    578a:	00054783          	lbu	a5,0(a0)
    578e:	0005c703          	lbu	a4,0(a1)
    5792:	00e79863          	bne	a5,a4,57a2 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
    5796:	0505                	addi	a0,a0,1
    p2++;
    5798:	0585                	addi	a1,a1,1
  while (n-- > 0) {
    579a:	fed518e3          	bne	a0,a3,578a <memcmp+0x14>
  }
  return 0;
    579e:	4501                	li	a0,0
    57a0:	a019                	j	57a6 <memcmp+0x30>
      return *p1 - *p2;
    57a2:	40e7853b          	subw	a0,a5,a4
}
    57a6:	6422                	ld	s0,8(sp)
    57a8:	0141                	addi	sp,sp,16
    57aa:	8082                	ret
  return 0;
    57ac:	4501                	li	a0,0
    57ae:	bfe5                	j	57a6 <memcmp+0x30>

00000000000057b0 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
    57b0:	1141                	addi	sp,sp,-16
    57b2:	e406                	sd	ra,8(sp)
    57b4:	e022                	sd	s0,0(sp)
    57b6:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
    57b8:	00000097          	auipc	ra,0x0
    57bc:	f66080e7          	jalr	-154(ra) # 571e <memmove>
}
    57c0:	60a2                	ld	ra,8(sp)
    57c2:	6402                	ld	s0,0(sp)
    57c4:	0141                	addi	sp,sp,16
    57c6:	8082                	ret

00000000000057c8 <fork>:
# generated by usys.pl - do not edit
#include <kernel/syscall.h>
.global fork
fork:
 li a7, SYS_fork
    57c8:	4885                	li	a7,1
 ecall
    57ca:	00000073          	ecall
 ret
    57ce:	8082                	ret

00000000000057d0 <exit>:
.global exit
exit:
 li a7, SYS_exit
    57d0:	4889                	li	a7,2
 ecall
    57d2:	00000073          	ecall
 ret
    57d6:	8082                	ret

00000000000057d8 <wait>:
.global wait
wait:
 li a7, SYS_wait
    57d8:	488d                	li	a7,3
 ecall
    57da:	00000073          	ecall
 ret
    57de:	8082                	ret

00000000000057e0 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
    57e0:	4891                	li	a7,4
 ecall
    57e2:	00000073          	ecall
 ret
    57e6:	8082                	ret

00000000000057e8 <read>:
.global read
read:
 li a7, SYS_read
    57e8:	4895                	li	a7,5
 ecall
    57ea:	00000073          	ecall
 ret
    57ee:	8082                	ret

00000000000057f0 <write>:
.global write
write:
 li a7, SYS_write
    57f0:	48c1                	li	a7,16
 ecall
    57f2:	00000073          	ecall
 ret
    57f6:	8082                	ret

00000000000057f8 <close>:
.global close
close:
 li a7, SYS_close
    57f8:	48d5                	li	a7,21
 ecall
    57fa:	00000073          	ecall
 ret
    57fe:	8082                	ret

0000000000005800 <kill>:
.global kill
kill:
 li a7, SYS_kill
    5800:	4899                	li	a7,6
 ecall
    5802:	00000073          	ecall
 ret
    5806:	8082                	ret

0000000000005808 <exec>:
.global exec
exec:
 li a7, SYS_exec
    5808:	489d                	li	a7,7
 ecall
    580a:	00000073          	ecall
 ret
    580e:	8082                	ret

0000000000005810 <open>:
.global open
open:
 li a7, SYS_open
    5810:	48bd                	li	a7,15
 ecall
    5812:	00000073          	ecall
 ret
    5816:	8082                	ret

0000000000005818 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
    5818:	48c5                	li	a7,17
 ecall
    581a:	00000073          	ecall
 ret
    581e:	8082                	ret

0000000000005820 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
    5820:	48c9                	li	a7,18
 ecall
    5822:	00000073          	ecall
 ret
    5826:	8082                	ret

0000000000005828 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
    5828:	48a1                	li	a7,8
 ecall
    582a:	00000073          	ecall
 ret
    582e:	8082                	ret

0000000000005830 <link>:
.global link
link:
 li a7, SYS_link
    5830:	48cd                	li	a7,19
 ecall
    5832:	00000073          	ecall
 ret
    5836:	8082                	ret

0000000000005838 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
    5838:	48d1                	li	a7,20
 ecall
    583a:	00000073          	ecall
 ret
    583e:	8082                	ret

0000000000005840 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
    5840:	48a5                	li	a7,9
 ecall
    5842:	00000073          	ecall
 ret
    5846:	8082                	ret

0000000000005848 <dup>:
.global dup
dup:
 li a7, SYS_dup
    5848:	48a9                	li	a7,10
 ecall
    584a:	00000073          	ecall
 ret
    584e:	8082                	ret

0000000000005850 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
    5850:	48ad                	li	a7,11
 ecall
    5852:	00000073          	ecall
 ret
    5856:	8082                	ret

0000000000005858 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
    5858:	48b1                	li	a7,12
 ecall
    585a:	00000073          	ecall
 ret
    585e:	8082                	ret

0000000000005860 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
    5860:	48b5                	li	a7,13
 ecall
    5862:	00000073          	ecall
 ret
    5866:	8082                	ret

0000000000005868 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
    5868:	48b9                	li	a7,14
 ecall
    586a:	00000073          	ecall
 ret
    586e:	8082                	ret

0000000000005870 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
    5870:	1101                	addi	sp,sp,-32
    5872:	ec06                	sd	ra,24(sp)
    5874:	e822                	sd	s0,16(sp)
    5876:	1000                	addi	s0,sp,32
    5878:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
    587c:	4605                	li	a2,1
    587e:	fef40593          	addi	a1,s0,-17
    5882:	00000097          	auipc	ra,0x0
    5886:	f6e080e7          	jalr	-146(ra) # 57f0 <write>
}
    588a:	60e2                	ld	ra,24(sp)
    588c:	6442                	ld	s0,16(sp)
    588e:	6105                	addi	sp,sp,32
    5890:	8082                	ret

0000000000005892 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    5892:	7139                	addi	sp,sp,-64
    5894:	fc06                	sd	ra,56(sp)
    5896:	f822                	sd	s0,48(sp)
    5898:	f426                	sd	s1,40(sp)
    589a:	f04a                	sd	s2,32(sp)
    589c:	ec4e                	sd	s3,24(sp)
    589e:	0080                	addi	s0,sp,64
    58a0:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    58a2:	c299                	beqz	a3,58a8 <printint+0x16>
    58a4:	0805c963          	bltz	a1,5936 <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
    58a8:	2581                	sext.w	a1,a1
  neg = 0;
    58aa:	4881                	li	a7,0
    58ac:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
    58b0:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
    58b2:	2601                	sext.w	a2,a2
    58b4:	00003517          	auipc	a0,0x3
    58b8:	c8450513          	addi	a0,a0,-892 # 8538 <digits>
    58bc:	883a                	mv	a6,a4
    58be:	2705                	addiw	a4,a4,1
    58c0:	02c5f7bb          	remuw	a5,a1,a2
    58c4:	1782                	slli	a5,a5,0x20
    58c6:	9381                	srli	a5,a5,0x20
    58c8:	97aa                	add	a5,a5,a0
    58ca:	0007c783          	lbu	a5,0(a5)
    58ce:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
    58d2:	0005879b          	sext.w	a5,a1
    58d6:	02c5d5bb          	divuw	a1,a1,a2
    58da:	0685                	addi	a3,a3,1
    58dc:	fec7f0e3          	bgeu	a5,a2,58bc <printint+0x2a>
  if(neg)
    58e0:	00088c63          	beqz	a7,58f8 <printint+0x66>
    buf[i++] = '-';
    58e4:	fd070793          	addi	a5,a4,-48
    58e8:	00878733          	add	a4,a5,s0
    58ec:	02d00793          	li	a5,45
    58f0:	fef70823          	sb	a5,-16(a4)
    58f4:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
    58f8:	02e05863          	blez	a4,5928 <printint+0x96>
    58fc:	fc040793          	addi	a5,s0,-64
    5900:	00e78933          	add	s2,a5,a4
    5904:	fff78993          	addi	s3,a5,-1
    5908:	99ba                	add	s3,s3,a4
    590a:	377d                	addiw	a4,a4,-1
    590c:	1702                	slli	a4,a4,0x20
    590e:	9301                	srli	a4,a4,0x20
    5910:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
    5914:	fff94583          	lbu	a1,-1(s2)
    5918:	8526                	mv	a0,s1
    591a:	00000097          	auipc	ra,0x0
    591e:	f56080e7          	jalr	-170(ra) # 5870 <putc>
  while(--i >= 0)
    5922:	197d                	addi	s2,s2,-1
    5924:	ff3918e3          	bne	s2,s3,5914 <printint+0x82>
}
    5928:	70e2                	ld	ra,56(sp)
    592a:	7442                	ld	s0,48(sp)
    592c:	74a2                	ld	s1,40(sp)
    592e:	7902                	ld	s2,32(sp)
    5930:	69e2                	ld	s3,24(sp)
    5932:	6121                	addi	sp,sp,64
    5934:	8082                	ret
    x = -xx;
    5936:	40b005bb          	negw	a1,a1
    neg = 1;
    593a:	4885                	li	a7,1
    x = -xx;
    593c:	bf85                	j	58ac <printint+0x1a>

000000000000593e <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
    593e:	7119                	addi	sp,sp,-128
    5940:	fc86                	sd	ra,120(sp)
    5942:	f8a2                	sd	s0,112(sp)
    5944:	f4a6                	sd	s1,104(sp)
    5946:	f0ca                	sd	s2,96(sp)
    5948:	ecce                	sd	s3,88(sp)
    594a:	e8d2                	sd	s4,80(sp)
    594c:	e4d6                	sd	s5,72(sp)
    594e:	e0da                	sd	s6,64(sp)
    5950:	fc5e                	sd	s7,56(sp)
    5952:	f862                	sd	s8,48(sp)
    5954:	f466                	sd	s9,40(sp)
    5956:	f06a                	sd	s10,32(sp)
    5958:	ec6e                	sd	s11,24(sp)
    595a:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
    595c:	0005c903          	lbu	s2,0(a1)
    5960:	18090f63          	beqz	s2,5afe <vprintf+0x1c0>
    5964:	8aaa                	mv	s5,a0
    5966:	8b32                	mv	s6,a2
    5968:	00158493          	addi	s1,a1,1
  state = 0;
    596c:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
    596e:	02500a13          	li	s4,37
    5972:	4c55                	li	s8,21
    5974:	00003c97          	auipc	s9,0x3
    5978:	b6cc8c93          	addi	s9,s9,-1172 # 84e0 <malloc+0x28de>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
        s = va_arg(ap, char*);
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    597c:	02800d93          	li	s11,40
  putc(fd, 'x');
    5980:	4d41                	li	s10,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    5982:	00003b97          	auipc	s7,0x3
    5986:	bb6b8b93          	addi	s7,s7,-1098 # 8538 <digits>
    598a:	a839                	j	59a8 <vprintf+0x6a>
        putc(fd, c);
    598c:	85ca                	mv	a1,s2
    598e:	8556                	mv	a0,s5
    5990:	00000097          	auipc	ra,0x0
    5994:	ee0080e7          	jalr	-288(ra) # 5870 <putc>
    5998:	a019                	j	599e <vprintf+0x60>
    } else if(state == '%'){
    599a:	01498d63          	beq	s3,s4,59b4 <vprintf+0x76>
  for(i = 0; fmt[i]; i++){
    599e:	0485                	addi	s1,s1,1
    59a0:	fff4c903          	lbu	s2,-1(s1)
    59a4:	14090d63          	beqz	s2,5afe <vprintf+0x1c0>
    if(state == 0){
    59a8:	fe0999e3          	bnez	s3,599a <vprintf+0x5c>
      if(c == '%'){
    59ac:	ff4910e3          	bne	s2,s4,598c <vprintf+0x4e>
        state = '%';
    59b0:	89d2                	mv	s3,s4
    59b2:	b7f5                	j	599e <vprintf+0x60>
      if(c == 'd'){
    59b4:	11490c63          	beq	s2,s4,5acc <vprintf+0x18e>
    59b8:	f9d9079b          	addiw	a5,s2,-99
    59bc:	0ff7f793          	zext.b	a5,a5
    59c0:	10fc6e63          	bltu	s8,a5,5adc <vprintf+0x19e>
    59c4:	f9d9079b          	addiw	a5,s2,-99
    59c8:	0ff7f713          	zext.b	a4,a5
    59cc:	10ec6863          	bltu	s8,a4,5adc <vprintf+0x19e>
    59d0:	00271793          	slli	a5,a4,0x2
    59d4:	97e6                	add	a5,a5,s9
    59d6:	439c                	lw	a5,0(a5)
    59d8:	97e6                	add	a5,a5,s9
    59da:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
    59dc:	008b0913          	addi	s2,s6,8
    59e0:	4685                	li	a3,1
    59e2:	4629                	li	a2,10
    59e4:	000b2583          	lw	a1,0(s6)
    59e8:	8556                	mv	a0,s5
    59ea:	00000097          	auipc	ra,0x0
    59ee:	ea8080e7          	jalr	-344(ra) # 5892 <printint>
    59f2:	8b4a                	mv	s6,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    59f4:	4981                	li	s3,0
    59f6:	b765                	j	599e <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
    59f8:	008b0913          	addi	s2,s6,8
    59fc:	4681                	li	a3,0
    59fe:	4629                	li	a2,10
    5a00:	000b2583          	lw	a1,0(s6)
    5a04:	8556                	mv	a0,s5
    5a06:	00000097          	auipc	ra,0x0
    5a0a:	e8c080e7          	jalr	-372(ra) # 5892 <printint>
    5a0e:	8b4a                	mv	s6,s2
      state = 0;
    5a10:	4981                	li	s3,0
    5a12:	b771                	j	599e <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
    5a14:	008b0913          	addi	s2,s6,8
    5a18:	4681                	li	a3,0
    5a1a:	866a                	mv	a2,s10
    5a1c:	000b2583          	lw	a1,0(s6)
    5a20:	8556                	mv	a0,s5
    5a22:	00000097          	auipc	ra,0x0
    5a26:	e70080e7          	jalr	-400(ra) # 5892 <printint>
    5a2a:	8b4a                	mv	s6,s2
      state = 0;
    5a2c:	4981                	li	s3,0
    5a2e:	bf85                	j	599e <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
    5a30:	008b0793          	addi	a5,s6,8
    5a34:	f8f43423          	sd	a5,-120(s0)
    5a38:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
    5a3c:	03000593          	li	a1,48
    5a40:	8556                	mv	a0,s5
    5a42:	00000097          	auipc	ra,0x0
    5a46:	e2e080e7          	jalr	-466(ra) # 5870 <putc>
  putc(fd, 'x');
    5a4a:	07800593          	li	a1,120
    5a4e:	8556                	mv	a0,s5
    5a50:	00000097          	auipc	ra,0x0
    5a54:	e20080e7          	jalr	-480(ra) # 5870 <putc>
    5a58:	896a                	mv	s2,s10
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    5a5a:	03c9d793          	srli	a5,s3,0x3c
    5a5e:	97de                	add	a5,a5,s7
    5a60:	0007c583          	lbu	a1,0(a5)
    5a64:	8556                	mv	a0,s5
    5a66:	00000097          	auipc	ra,0x0
    5a6a:	e0a080e7          	jalr	-502(ra) # 5870 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    5a6e:	0992                	slli	s3,s3,0x4
    5a70:	397d                	addiw	s2,s2,-1
    5a72:	fe0914e3          	bnez	s2,5a5a <vprintf+0x11c>
        printptr(fd, va_arg(ap, uint64));
    5a76:	f8843b03          	ld	s6,-120(s0)
      state = 0;
    5a7a:	4981                	li	s3,0
    5a7c:	b70d                	j	599e <vprintf+0x60>
        s = va_arg(ap, char*);
    5a7e:	008b0913          	addi	s2,s6,8
    5a82:	000b3983          	ld	s3,0(s6)
        if(s == 0)
    5a86:	02098163          	beqz	s3,5aa8 <vprintf+0x16a>
        while(*s != 0){
    5a8a:	0009c583          	lbu	a1,0(s3)
    5a8e:	c5ad                	beqz	a1,5af8 <vprintf+0x1ba>
          putc(fd, *s);
    5a90:	8556                	mv	a0,s5
    5a92:	00000097          	auipc	ra,0x0
    5a96:	dde080e7          	jalr	-546(ra) # 5870 <putc>
          s++;
    5a9a:	0985                	addi	s3,s3,1
        while(*s != 0){
    5a9c:	0009c583          	lbu	a1,0(s3)
    5aa0:	f9e5                	bnez	a1,5a90 <vprintf+0x152>
        s = va_arg(ap, char*);
    5aa2:	8b4a                	mv	s6,s2
      state = 0;
    5aa4:	4981                	li	s3,0
    5aa6:	bde5                	j	599e <vprintf+0x60>
          s = "(null)";
    5aa8:	00003997          	auipc	s3,0x3
    5aac:	a3098993          	addi	s3,s3,-1488 # 84d8 <malloc+0x28d6>
        while(*s != 0){
    5ab0:	85ee                	mv	a1,s11
    5ab2:	bff9                	j	5a90 <vprintf+0x152>
        putc(fd, va_arg(ap, uint));
    5ab4:	008b0913          	addi	s2,s6,8
    5ab8:	000b4583          	lbu	a1,0(s6)
    5abc:	8556                	mv	a0,s5
    5abe:	00000097          	auipc	ra,0x0
    5ac2:	db2080e7          	jalr	-590(ra) # 5870 <putc>
    5ac6:	8b4a                	mv	s6,s2
      state = 0;
    5ac8:	4981                	li	s3,0
    5aca:	bdd1                	j	599e <vprintf+0x60>
        putc(fd, c);
    5acc:	85d2                	mv	a1,s4
    5ace:	8556                	mv	a0,s5
    5ad0:	00000097          	auipc	ra,0x0
    5ad4:	da0080e7          	jalr	-608(ra) # 5870 <putc>
      state = 0;
    5ad8:	4981                	li	s3,0
    5ada:	b5d1                	j	599e <vprintf+0x60>
        putc(fd, '%');
    5adc:	85d2                	mv	a1,s4
    5ade:	8556                	mv	a0,s5
    5ae0:	00000097          	auipc	ra,0x0
    5ae4:	d90080e7          	jalr	-624(ra) # 5870 <putc>
        putc(fd, c);
    5ae8:	85ca                	mv	a1,s2
    5aea:	8556                	mv	a0,s5
    5aec:	00000097          	auipc	ra,0x0
    5af0:	d84080e7          	jalr	-636(ra) # 5870 <putc>
      state = 0;
    5af4:	4981                	li	s3,0
    5af6:	b565                	j	599e <vprintf+0x60>
        s = va_arg(ap, char*);
    5af8:	8b4a                	mv	s6,s2
      state = 0;
    5afa:	4981                	li	s3,0
    5afc:	b54d                	j	599e <vprintf+0x60>
    }
  }
}
    5afe:	70e6                	ld	ra,120(sp)
    5b00:	7446                	ld	s0,112(sp)
    5b02:	74a6                	ld	s1,104(sp)
    5b04:	7906                	ld	s2,96(sp)
    5b06:	69e6                	ld	s3,88(sp)
    5b08:	6a46                	ld	s4,80(sp)
    5b0a:	6aa6                	ld	s5,72(sp)
    5b0c:	6b06                	ld	s6,64(sp)
    5b0e:	7be2                	ld	s7,56(sp)
    5b10:	7c42                	ld	s8,48(sp)
    5b12:	7ca2                	ld	s9,40(sp)
    5b14:	7d02                	ld	s10,32(sp)
    5b16:	6de2                	ld	s11,24(sp)
    5b18:	6109                	addi	sp,sp,128
    5b1a:	8082                	ret

0000000000005b1c <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
    5b1c:	715d                	addi	sp,sp,-80
    5b1e:	ec06                	sd	ra,24(sp)
    5b20:	e822                	sd	s0,16(sp)
    5b22:	1000                	addi	s0,sp,32
    5b24:	e010                	sd	a2,0(s0)
    5b26:	e414                	sd	a3,8(s0)
    5b28:	e818                	sd	a4,16(s0)
    5b2a:	ec1c                	sd	a5,24(s0)
    5b2c:	03043023          	sd	a6,32(s0)
    5b30:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
    5b34:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
    5b38:	8622                	mv	a2,s0
    5b3a:	00000097          	auipc	ra,0x0
    5b3e:	e04080e7          	jalr	-508(ra) # 593e <vprintf>
}
    5b42:	60e2                	ld	ra,24(sp)
    5b44:	6442                	ld	s0,16(sp)
    5b46:	6161                	addi	sp,sp,80
    5b48:	8082                	ret

0000000000005b4a <printf>:

void
printf(const char *fmt, ...)
{
    5b4a:	711d                	addi	sp,sp,-96
    5b4c:	ec06                	sd	ra,24(sp)
    5b4e:	e822                	sd	s0,16(sp)
    5b50:	1000                	addi	s0,sp,32
    5b52:	e40c                	sd	a1,8(s0)
    5b54:	e810                	sd	a2,16(s0)
    5b56:	ec14                	sd	a3,24(s0)
    5b58:	f018                	sd	a4,32(s0)
    5b5a:	f41c                	sd	a5,40(s0)
    5b5c:	03043823          	sd	a6,48(s0)
    5b60:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
    5b64:	00840613          	addi	a2,s0,8
    5b68:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
    5b6c:	85aa                	mv	a1,a0
    5b6e:	4505                	li	a0,1
    5b70:	00000097          	auipc	ra,0x0
    5b74:	dce080e7          	jalr	-562(ra) # 593e <vprintf>
}
    5b78:	60e2                	ld	ra,24(sp)
    5b7a:	6442                	ld	s0,16(sp)
    5b7c:	6125                	addi	sp,sp,96
    5b7e:	8082                	ret

0000000000005b80 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    5b80:	1141                	addi	sp,sp,-16
    5b82:	e422                	sd	s0,8(sp)
    5b84:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
    5b86:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    5b8a:	00003797          	auipc	a5,0x3
    5b8e:	9ce7b783          	ld	a5,-1586(a5) # 8558 <freep>
    5b92:	a02d                	j	5bbc <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    5b94:	4618                	lw	a4,8(a2)
    5b96:	9f2d                	addw	a4,a4,a1
    5b98:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
    5b9c:	6398                	ld	a4,0(a5)
    5b9e:	6310                	ld	a2,0(a4)
    5ba0:	a83d                	j	5bde <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    5ba2:	ff852703          	lw	a4,-8(a0)
    5ba6:	9f31                	addw	a4,a4,a2
    5ba8:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
    5baa:	ff053683          	ld	a3,-16(a0)
    5bae:	a091                	j	5bf2 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    5bb0:	6398                	ld	a4,0(a5)
    5bb2:	00e7e463          	bltu	a5,a4,5bba <free+0x3a>
    5bb6:	00e6ea63          	bltu	a3,a4,5bca <free+0x4a>
{
    5bba:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    5bbc:	fed7fae3          	bgeu	a5,a3,5bb0 <free+0x30>
    5bc0:	6398                	ld	a4,0(a5)
    5bc2:	00e6e463          	bltu	a3,a4,5bca <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    5bc6:	fee7eae3          	bltu	a5,a4,5bba <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
    5bca:	ff852583          	lw	a1,-8(a0)
    5bce:	6390                	ld	a2,0(a5)
    5bd0:	02059813          	slli	a6,a1,0x20
    5bd4:	01c85713          	srli	a4,a6,0x1c
    5bd8:	9736                	add	a4,a4,a3
    5bda:	fae60de3          	beq	a2,a4,5b94 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
    5bde:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
    5be2:	4790                	lw	a2,8(a5)
    5be4:	02061593          	slli	a1,a2,0x20
    5be8:	01c5d713          	srli	a4,a1,0x1c
    5bec:	973e                	add	a4,a4,a5
    5bee:	fae68ae3          	beq	a3,a4,5ba2 <free+0x22>
    p->s.ptr = bp->s.ptr;
    5bf2:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
    5bf4:	00003717          	auipc	a4,0x3
    5bf8:	96f73223          	sd	a5,-1692(a4) # 8558 <freep>
}
    5bfc:	6422                	ld	s0,8(sp)
    5bfe:	0141                	addi	sp,sp,16
    5c00:	8082                	ret

0000000000005c02 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    5c02:	7139                	addi	sp,sp,-64
    5c04:	fc06                	sd	ra,56(sp)
    5c06:	f822                	sd	s0,48(sp)
    5c08:	f426                	sd	s1,40(sp)
    5c0a:	f04a                	sd	s2,32(sp)
    5c0c:	ec4e                	sd	s3,24(sp)
    5c0e:	e852                	sd	s4,16(sp)
    5c10:	e456                	sd	s5,8(sp)
    5c12:	e05a                	sd	s6,0(sp)
    5c14:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    5c16:	02051493          	slli	s1,a0,0x20
    5c1a:	9081                	srli	s1,s1,0x20
    5c1c:	04bd                	addi	s1,s1,15
    5c1e:	8091                	srli	s1,s1,0x4
    5c20:	0014899b          	addiw	s3,s1,1
    5c24:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
    5c26:	00003517          	auipc	a0,0x3
    5c2a:	93253503          	ld	a0,-1742(a0) # 8558 <freep>
    5c2e:	c515                	beqz	a0,5c5a <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    5c30:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    5c32:	4798                	lw	a4,8(a5)
    5c34:	02977f63          	bgeu	a4,s1,5c72 <malloc+0x70>
    5c38:	8a4e                	mv	s4,s3
    5c3a:	0009871b          	sext.w	a4,s3
    5c3e:	6685                	lui	a3,0x1
    5c40:	00d77363          	bgeu	a4,a3,5c46 <malloc+0x44>
    5c44:	6a05                	lui	s4,0x1
    5c46:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
    5c4a:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    5c4e:	00003917          	auipc	s2,0x3
    5c52:	90a90913          	addi	s2,s2,-1782 # 8558 <freep>
  if(p == (char*)-1)
    5c56:	5afd                	li	s5,-1
    5c58:	a895                	j	5ccc <malloc+0xca>
    base.s.ptr = freep = prevp = &base;
    5c5a:	00009797          	auipc	a5,0x9
    5c5e:	11e78793          	addi	a5,a5,286 # ed78 <base>
    5c62:	00003717          	auipc	a4,0x3
    5c66:	8ef73b23          	sd	a5,-1802(a4) # 8558 <freep>
    5c6a:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
    5c6c:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
    5c70:	b7e1                	j	5c38 <malloc+0x36>
      if(p->s.size == nunits)
    5c72:	02e48c63          	beq	s1,a4,5caa <malloc+0xa8>
        p->s.size -= nunits;
    5c76:	4137073b          	subw	a4,a4,s3
    5c7a:	c798                	sw	a4,8(a5)
        p += p->s.size;
    5c7c:	02071693          	slli	a3,a4,0x20
    5c80:	01c6d713          	srli	a4,a3,0x1c
    5c84:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
    5c86:	0137a423          	sw	s3,8(a5)
      freep = prevp;
    5c8a:	00003717          	auipc	a4,0x3
    5c8e:	8ca73723          	sd	a0,-1842(a4) # 8558 <freep>
      return (void*)(p + 1);
    5c92:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
    5c96:	70e2                	ld	ra,56(sp)
    5c98:	7442                	ld	s0,48(sp)
    5c9a:	74a2                	ld	s1,40(sp)
    5c9c:	7902                	ld	s2,32(sp)
    5c9e:	69e2                	ld	s3,24(sp)
    5ca0:	6a42                	ld	s4,16(sp)
    5ca2:	6aa2                	ld	s5,8(sp)
    5ca4:	6b02                	ld	s6,0(sp)
    5ca6:	6121                	addi	sp,sp,64
    5ca8:	8082                	ret
        prevp->s.ptr = p->s.ptr;
    5caa:	6398                	ld	a4,0(a5)
    5cac:	e118                	sd	a4,0(a0)
    5cae:	bff1                	j	5c8a <malloc+0x88>
  hp->s.size = nu;
    5cb0:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
    5cb4:	0541                	addi	a0,a0,16
    5cb6:	00000097          	auipc	ra,0x0
    5cba:	eca080e7          	jalr	-310(ra) # 5b80 <free>
  return freep;
    5cbe:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
    5cc2:	d971                	beqz	a0,5c96 <malloc+0x94>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    5cc4:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    5cc6:	4798                	lw	a4,8(a5)
    5cc8:	fa9775e3          	bgeu	a4,s1,5c72 <malloc+0x70>
    if(p == freep)
    5ccc:	00093703          	ld	a4,0(s2)
    5cd0:	853e                	mv	a0,a5
    5cd2:	fef719e3          	bne	a4,a5,5cc4 <malloc+0xc2>
  p = sbrk(nu * sizeof(Header));
    5cd6:	8552                	mv	a0,s4
    5cd8:	00000097          	auipc	ra,0x0
    5cdc:	b80080e7          	jalr	-1152(ra) # 5858 <sbrk>
  if(p == (char*)-1)
    5ce0:	fd5518e3          	bne	a0,s5,5cb0 <malloc+0xae>
        return 0;
    5ce4:	4501                	li	a0,0
    5ce6:	bf45                	j	5c96 <malloc+0x94>
