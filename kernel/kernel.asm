
kernel/kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
_entry:
	# set up a stack for C.
        # stack0 is declared in start.c,
        # with a 4096-byte stack per CPU.
        # sp = stack0 + (hartid * 4096)
        la sp, stack0
    80000000:	0000b117          	auipc	sp,0xb
    80000004:	18010113          	addi	sp,sp,384 # 8000b180 <stack0>
        li a0, 1024*4
    80000008:	6505                	lui	a0,0x1
	csrr a1, mhartid
    8000000a:	f14025f3          	csrr	a1,mhartid
        addi a1, a1, 1
    8000000e:	0585                	addi	a1,a1,1
        mul a0, a0, a1
    80000010:	02b50533          	mul	a0,a0,a1
        add sp, sp, a0
    80000014:	912a                	add	sp,sp,a0
	# jump to start() in start.c
        call start
    80000016:	19e000ef          	jal	ra,800001b4 <start>

000000008000001a <spin>:
spin:
        j spin
    8000001a:	a001                	j	8000001a <spin>
    8000001c:	0000                	unimp
	...

0000000080000020 <kernelvec>:
.globl kerneltrap
.globl kernelvec
.align 4
kernelvec:
        // make room to save registers.
        addi sp, sp, -256
    80000020:	7111                	addi	sp,sp,-256

        // save the registers.
        sd ra, 0(sp)
    80000022:	e006                	sd	ra,0(sp)
        sd sp, 8(sp)
    80000024:	e40a                	sd	sp,8(sp)
        sd gp, 16(sp)
    80000026:	e80e                	sd	gp,16(sp)
        sd tp, 24(sp)
    80000028:	ec12                	sd	tp,24(sp)
        sd t0, 32(sp)
    8000002a:	f016                	sd	t0,32(sp)
        sd t1, 40(sp)
    8000002c:	f41a                	sd	t1,40(sp)
        sd t2, 48(sp)
    8000002e:	f81e                	sd	t2,48(sp)
        sd s0, 56(sp)
    80000030:	fc22                	sd	s0,56(sp)
        sd s1, 64(sp)
    80000032:	e0a6                	sd	s1,64(sp)
        sd a0, 72(sp)
    80000034:	e4aa                	sd	a0,72(sp)
        sd a1, 80(sp)
    80000036:	e8ae                	sd	a1,80(sp)
        sd a2, 88(sp)
    80000038:	ecb2                	sd	a2,88(sp)
        sd a3, 96(sp)
    8000003a:	f0b6                	sd	a3,96(sp)
        sd a4, 104(sp)
    8000003c:	f4ba                	sd	a4,104(sp)
        sd a5, 112(sp)
    8000003e:	f8be                	sd	a5,112(sp)
        sd a6, 120(sp)
    80000040:	fcc2                	sd	a6,120(sp)
        sd a7, 128(sp)
    80000042:	e146                	sd	a7,128(sp)
        sd s2, 136(sp)
    80000044:	e54a                	sd	s2,136(sp)
        sd s3, 144(sp)
    80000046:	e94e                	sd	s3,144(sp)
        sd s4, 152(sp)
    80000048:	ed52                	sd	s4,152(sp)
        sd s5, 160(sp)
    8000004a:	f156                	sd	s5,160(sp)
        sd s6, 168(sp)
    8000004c:	f55a                	sd	s6,168(sp)
        sd s7, 176(sp)
    8000004e:	f95e                	sd	s7,176(sp)
        sd s8, 184(sp)
    80000050:	fd62                	sd	s8,184(sp)
        sd s9, 192(sp)
    80000052:	e1e6                	sd	s9,192(sp)
        sd s10, 200(sp)
    80000054:	e5ea                	sd	s10,200(sp)
        sd s11, 208(sp)
    80000056:	e9ee                	sd	s11,208(sp)
        sd t3, 216(sp)
    80000058:	edf2                	sd	t3,216(sp)
        sd t4, 224(sp)
    8000005a:	f1f6                	sd	t4,224(sp)
        sd t5, 232(sp)
    8000005c:	f5fa                	sd	t5,232(sp)
        sd t6, 240(sp)
    8000005e:	f9fe                	sd	t6,240(sp)

	// call the C trap handler in trap.c
        call kerneltrap
    80000060:	06f020ef          	jal	ra,800028ce <kerneltrap>

        // restore registers.
        ld ra, 0(sp)
    80000064:	6082                	ld	ra,0(sp)
        ld sp, 8(sp)
    80000066:	6122                	ld	sp,8(sp)
        ld gp, 16(sp)
    80000068:	61c2                	ld	gp,16(sp)
        // not this, in case we moved CPUs: ld tp, 24(sp)
        ld t0, 32(sp)
    8000006a:	7282                	ld	t0,32(sp)
        ld t1, 40(sp)
    8000006c:	7322                	ld	t1,40(sp)
        ld t2, 48(sp)
    8000006e:	73c2                	ld	t2,48(sp)
        ld s0, 56(sp)
    80000070:	7462                	ld	s0,56(sp)
        ld s1, 64(sp)
    80000072:	6486                	ld	s1,64(sp)
        ld a0, 72(sp)
    80000074:	6526                	ld	a0,72(sp)
        ld a1, 80(sp)
    80000076:	65c6                	ld	a1,80(sp)
        ld a2, 88(sp)
    80000078:	6666                	ld	a2,88(sp)
        ld a3, 96(sp)
    8000007a:	7686                	ld	a3,96(sp)
        ld a4, 104(sp)
    8000007c:	7726                	ld	a4,104(sp)
        ld a5, 112(sp)
    8000007e:	77c6                	ld	a5,112(sp)
        ld a6, 120(sp)
    80000080:	7866                	ld	a6,120(sp)
        ld a7, 128(sp)
    80000082:	688a                	ld	a7,128(sp)
        ld s2, 136(sp)
    80000084:	692a                	ld	s2,136(sp)
        ld s3, 144(sp)
    80000086:	69ca                	ld	s3,144(sp)
        ld s4, 152(sp)
    80000088:	6a6a                	ld	s4,152(sp)
        ld s5, 160(sp)
    8000008a:	7a8a                	ld	s5,160(sp)
        ld s6, 168(sp)
    8000008c:	7b2a                	ld	s6,168(sp)
        ld s7, 176(sp)
    8000008e:	7bca                	ld	s7,176(sp)
        ld s8, 184(sp)
    80000090:	7c6a                	ld	s8,184(sp)
        ld s9, 192(sp)
    80000092:	6c8e                	ld	s9,192(sp)
        ld s10, 200(sp)
    80000094:	6d2e                	ld	s10,200(sp)
        ld s11, 208(sp)
    80000096:	6dce                	ld	s11,208(sp)
        ld t3, 216(sp)
    80000098:	6e6e                	ld	t3,216(sp)
        ld t4, 224(sp)
    8000009a:	7e8e                	ld	t4,224(sp)
        ld t5, 232(sp)
    8000009c:	7f2e                	ld	t5,232(sp)
        ld t6, 240(sp)
    8000009e:	7fce                	ld	t6,240(sp)

        addi sp, sp, 256
    800000a0:	6111                	addi	sp,sp,256

        // return to whatever we were doing in the kernel.
        sret
    800000a2:	10200073          	sret
    800000a6:	00000013          	nop
    800000aa:	00000013          	nop
    800000ae:	0001                	nop

00000000800000b0 <timervec>:
        # start.c has set up the memory that mscratch points to:
        # scratch[0,8,16] : register save area.
        # scratch[24] : address of CLINT's MTIMECMP register.
        # scratch[32] : desired interval between interrupts.
        
        csrrw a0, mscratch, a0
    800000b0:	34051573          	csrrw	a0,mscratch,a0
        sd a1, 0(a0)
    800000b4:	e10c                	sd	a1,0(a0)
        sd a2, 8(a0)
    800000b6:	e510                	sd	a2,8(a0)
        sd a3, 16(a0)
    800000b8:	e914                	sd	a3,16(a0)

        # schedule the next timer interrupt
        # by adding interval to mtimecmp.
        ld a1, 24(a0) # CLINT_MTIMECMP(hart)
    800000ba:	6d0c                	ld	a1,24(a0)
        ld a2, 32(a0) # interval
    800000bc:	7110                	ld	a2,32(a0)
        ld a3, 0(a1)
    800000be:	6194                	ld	a3,0(a1)
        add a3, a3, a2
    800000c0:	96b2                	add	a3,a3,a2
        sd a3, 0(a1)
    800000c2:	e194                	sd	a3,0(a1)

        # raise a supervisor software interrupt.
	li a1, 2
    800000c4:	4589                	li	a1,2
        csrw sip, a1
    800000c6:	14459073          	csrw	sip,a1

        ld a3, 16(a0)
    800000ca:	6914                	ld	a3,16(a0)
        ld a2, 8(a0)
    800000cc:	6510                	ld	a2,8(a0)
        ld a1, 0(a0)
    800000ce:	610c                	ld	a1,0(a0)
        csrrw a0, mscratch, a0
    800000d0:	34051573          	csrrw	a0,mscratch,a0

        mret
    800000d4:	30200073          	mret
	...

00000000800000da <swtch>:
# Save current registers in old. Load from new.	


.globl swtch
swtch:
        sd ra, 0(a0)
    800000da:	00153023          	sd	ra,0(a0) # 1000 <_entry-0x7ffff000>
        sd sp, 8(a0)
    800000de:	00253423          	sd	sp,8(a0)
        sd s0, 16(a0)
    800000e2:	e900                	sd	s0,16(a0)
        sd s1, 24(a0)
    800000e4:	ed04                	sd	s1,24(a0)
        sd s2, 32(a0)
    800000e6:	03253023          	sd	s2,32(a0)
        sd s3, 40(a0)
    800000ea:	03353423          	sd	s3,40(a0)
        sd s4, 48(a0)
    800000ee:	03453823          	sd	s4,48(a0)
        sd s5, 56(a0)
    800000f2:	03553c23          	sd	s5,56(a0)
        sd s6, 64(a0)
    800000f6:	05653023          	sd	s6,64(a0)
        sd s7, 72(a0)
    800000fa:	05753423          	sd	s7,72(a0)
        sd s8, 80(a0)
    800000fe:	05853823          	sd	s8,80(a0)
        sd s9, 88(a0)
    80000102:	05953c23          	sd	s9,88(a0)
        sd s10, 96(a0)
    80000106:	07a53023          	sd	s10,96(a0)
        sd s11, 104(a0)
    8000010a:	07b53423          	sd	s11,104(a0)

        ld ra, 0(a1)
    8000010e:	0005b083          	ld	ra,0(a1)
        ld sp, 8(a1)
    80000112:	0085b103          	ld	sp,8(a1)
        ld s0, 16(a1)
    80000116:	6980                	ld	s0,16(a1)
        ld s1, 24(a1)
    80000118:	6d84                	ld	s1,24(a1)
        ld s2, 32(a1)
    8000011a:	0205b903          	ld	s2,32(a1)
        ld s3, 40(a1)
    8000011e:	0285b983          	ld	s3,40(a1)
        ld s4, 48(a1)
    80000122:	0305ba03          	ld	s4,48(a1)
        ld s5, 56(a1)
    80000126:	0385ba83          	ld	s5,56(a1)
        ld s6, 64(a1)
    8000012a:	0405bb03          	ld	s6,64(a1)
        ld s7, 72(a1)
    8000012e:	0485bb83          	ld	s7,72(a1)
        ld s8, 80(a1)
    80000132:	0505bc03          	ld	s8,80(a1)
        ld s9, 88(a1)
    80000136:	0585bc83          	ld	s9,88(a1)
        ld s10, 96(a1)
    8000013a:	0605bd03          	ld	s10,96(a1)
        ld s11, 104(a1)
    8000013e:	0685bd83          	ld	s11,104(a1)
        
        ret
    80000142:	8082                	ret

0000000080000144 <timerinit>:
// which arrive at timervec in kernelvec.S,
// which turns them into software interrupts for
// devintr() in trap.c.
void
timerinit()
{
    80000144:	1141                	addi	sp,sp,-16
    80000146:	e422                	sd	s0,8(sp)
    80000148:	0800                	addi	s0,sp,16
// which hart (core) is this?
static inline uint64
r_mhartid()
{
  uint64 x;
  asm volatile("csrr %0, mhartid" : "=r" (x) );
    8000014a:	f14027f3          	csrr	a5,mhartid
  // each CPU has a separate source of timer interrupts.
  int id = r_mhartid();
    8000014e:	0007859b          	sext.w	a1,a5

  // ask the CLINT for a timer interrupt.
  int interval = 1000000; // cycles; about 1/10th second in qemu.
  *(uint64*)CLINT_MTIMECMP(id) = *(uint64*)CLINT_MTIME + interval;
    80000152:	0037979b          	slliw	a5,a5,0x3
    80000156:	02004737          	lui	a4,0x2004
    8000015a:	97ba                	add	a5,a5,a4
    8000015c:	0200c737          	lui	a4,0x200c
    80000160:	ff873703          	ld	a4,-8(a4) # 200bff8 <_entry-0x7dff4008>
    80000164:	000f4637          	lui	a2,0xf4
    80000168:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    8000016c:	9732                	add	a4,a4,a2
    8000016e:	e398                	sd	a4,0(a5)

  // prepare information in scratch[] for timervec.
  // scratch[0..2] : space for timervec to save registers.
  // scratch[3] : address of CLINT MTIMECMP register.
  // scratch[4] : desired interval (in cycles) between timer interrupts.
  uint64 *scratch = &timer_scratch[id][0];
    80000170:	00259693          	slli	a3,a1,0x2
    80000174:	96ae                	add	a3,a3,a1
    80000176:	068e                	slli	a3,a3,0x3
    80000178:	0000b717          	auipc	a4,0xb
    8000017c:	ec870713          	addi	a4,a4,-312 # 8000b040 <timer_scratch>
    80000180:	9736                	add	a4,a4,a3
  scratch[3] = CLINT_MTIMECMP(id);
    80000182:	ef1c                	sd	a5,24(a4)
  scratch[4] = interval;
    80000184:	f310                	sd	a2,32(a4)
}

static inline void 
w_mscratch(uint64 x)
{
  asm volatile("csrw mscratch, %0" : : "r" (x));
    80000186:	34071073          	csrw	mscratch,a4
  asm volatile("csrw mtvec, %0" : : "r" (x));
    8000018a:	00000797          	auipc	a5,0x0
    8000018e:	f2678793          	addi	a5,a5,-218 # 800000b0 <timervec>
    80000192:	30579073          	csrw	mtvec,a5
  asm volatile("csrr %0, mstatus" : "=r" (x) );
    80000196:	300027f3          	csrr	a5,mstatus

  // set the machine-mode trap handler.
  w_mtvec((uint64)timervec);

  // enable machine-mode interrupts.
  w_mstatus(r_mstatus() | MSTATUS_MIE);
    8000019a:	0087e793          	ori	a5,a5,8
  asm volatile("csrw mstatus, %0" : : "r" (x));
    8000019e:	30079073          	csrw	mstatus,a5
  asm volatile("csrr %0, mie" : "=r" (x) );
    800001a2:	304027f3          	csrr	a5,mie

  // enable machine-mode timer interrupts.
  w_mie(r_mie() | MIE_MTIE);
    800001a6:	0807e793          	ori	a5,a5,128
  asm volatile("csrw mie, %0" : : "r" (x));
    800001aa:	30479073          	csrw	mie,a5
}
    800001ae:	6422                	ld	s0,8(sp)
    800001b0:	0141                	addi	sp,sp,16
    800001b2:	8082                	ret

00000000800001b4 <start>:
{
    800001b4:	1141                	addi	sp,sp,-16
    800001b6:	e406                	sd	ra,8(sp)
    800001b8:	e022                	sd	s0,0(sp)
    800001ba:	0800                	addi	s0,sp,16
  asm volatile("csrr %0, mstatus" : "=r" (x) );
    800001bc:	300027f3          	csrr	a5,mstatus
  x &= ~MSTATUS_MPP_MASK;
    800001c0:	7779                	lui	a4,0xffffe
    800001c2:	7ff70713          	addi	a4,a4,2047 # ffffffffffffe7ff <end+0xffffffff7ffd443f>
    800001c6:	8ff9                	and	a5,a5,a4
  x |= MSTATUS_MPP_S;
    800001c8:	6705                	lui	a4,0x1
    800001ca:	80070713          	addi	a4,a4,-2048 # 800 <_entry-0x7ffff800>
    800001ce:	8fd9                	or	a5,a5,a4
  asm volatile("csrw mstatus, %0" : : "r" (x));
    800001d0:	30079073          	csrw	mstatus,a5
  asm volatile("csrw mepc, %0" : : "r" (x));
    800001d4:	00001797          	auipc	a5,0x1
    800001d8:	dec78793          	addi	a5,a5,-532 # 80000fc0 <main>
    800001dc:	34179073          	csrw	mepc,a5
  asm volatile("csrw satp, %0" : : "r" (x));
    800001e0:	4781                	li	a5,0
    800001e2:	18079073          	csrw	satp,a5
  asm volatile("csrw medeleg, %0" : : "r" (x));
    800001e6:	67c1                	lui	a5,0x10
    800001e8:	17fd                	addi	a5,a5,-1
    800001ea:	30279073          	csrw	medeleg,a5
  asm volatile("csrw mideleg, %0" : : "r" (x));
    800001ee:	30379073          	csrw	mideleg,a5
  asm volatile("csrr %0, sie" : "=r" (x) );
    800001f2:	104027f3          	csrr	a5,sie
  w_sie(r_sie() | SIE_SEIE | SIE_STIE | SIE_SSIE);
    800001f6:	2227e793          	ori	a5,a5,546
  asm volatile("csrw sie, %0" : : "r" (x));
    800001fa:	10479073          	csrw	sie,a5
  asm volatile("csrw pmpaddr0, %0" : : "r" (x));
    800001fe:	57fd                	li	a5,-1
    80000200:	83a9                	srli	a5,a5,0xa
    80000202:	3b079073          	csrw	pmpaddr0,a5
  asm volatile("csrw pmpcfg0, %0" : : "r" (x));
    80000206:	47bd                	li	a5,15
    80000208:	3a079073          	csrw	pmpcfg0,a5
  timerinit();
    8000020c:	00000097          	auipc	ra,0x0
    80000210:	f38080e7          	jalr	-200(ra) # 80000144 <timerinit>
  asm volatile("csrr %0, mhartid" : "=r" (x) );
    80000214:	f14027f3          	csrr	a5,mhartid
  w_tp(id);
    80000218:	2781                	sext.w	a5,a5
}

static inline void 
w_tp(uint64 x)
{
  asm volatile("mv tp, %0" : : "r" (x));
    8000021a:	823e                	mv	tp,a5
  asm volatile("mret");
    8000021c:	30200073          	mret
}
    80000220:	60a2                	ld	ra,8(sp)
    80000222:	6402                	ld	s0,0(sp)
    80000224:	0141                	addi	sp,sp,16
    80000226:	8082                	ret

0000000080000228 <consolewrite>:
//
// user write()s to the console go here.
//
int
consolewrite(int user_src, uint64 src, int n)
{
    80000228:	715d                	addi	sp,sp,-80
    8000022a:	e486                	sd	ra,72(sp)
    8000022c:	e0a2                	sd	s0,64(sp)
    8000022e:	fc26                	sd	s1,56(sp)
    80000230:	f84a                	sd	s2,48(sp)
    80000232:	f44e                	sd	s3,40(sp)
    80000234:	f052                	sd	s4,32(sp)
    80000236:	ec56                	sd	s5,24(sp)
    80000238:	0880                	addi	s0,sp,80
  int i;

  for(i = 0; i < n; i++){
    8000023a:	04c05763          	blez	a2,80000288 <consolewrite+0x60>
    8000023e:	8a2a                	mv	s4,a0
    80000240:	84ae                	mv	s1,a1
    80000242:	89b2                	mv	s3,a2
    80000244:	4901                	li	s2,0
    char c;
    if(either_copyin(&c, user_src, src+i, 1) == -1)
    80000246:	5afd                	li	s5,-1
    80000248:	4685                	li	a3,1
    8000024a:	8626                	mv	a2,s1
    8000024c:	85d2                	mv	a1,s4
    8000024e:	fbf40513          	addi	a0,s0,-65
    80000252:	00002097          	auipc	ra,0x2
    80000256:	358080e7          	jalr	856(ra) # 800025aa <either_copyin>
    8000025a:	01550d63          	beq	a0,s5,80000274 <consolewrite+0x4c>
      break;
    uartputc(c);
    8000025e:	fbf44503          	lbu	a0,-65(s0)
    80000262:	00000097          	auipc	ra,0x0
    80000266:	77e080e7          	jalr	1918(ra) # 800009e0 <uartputc>
  for(i = 0; i < n; i++){
    8000026a:	2905                	addiw	s2,s2,1
    8000026c:	0485                	addi	s1,s1,1
    8000026e:	fd299de3          	bne	s3,s2,80000248 <consolewrite+0x20>
    80000272:	894e                	mv	s2,s3
  }

  return i;
}
    80000274:	854a                	mv	a0,s2
    80000276:	60a6                	ld	ra,72(sp)
    80000278:	6406                	ld	s0,64(sp)
    8000027a:	74e2                	ld	s1,56(sp)
    8000027c:	7942                	ld	s2,48(sp)
    8000027e:	79a2                	ld	s3,40(sp)
    80000280:	7a02                	ld	s4,32(sp)
    80000282:	6ae2                	ld	s5,24(sp)
    80000284:	6161                	addi	sp,sp,80
    80000286:	8082                	ret
  for(i = 0; i < n; i++){
    80000288:	4901                	li	s2,0
    8000028a:	b7ed                	j	80000274 <consolewrite+0x4c>

000000008000028c <consoleread>:
// user_dist indicates whether dst is a user
// or kernel address.
//
int
consoleread(int user_dst, uint64 dst, int n)
{
    8000028c:	7159                	addi	sp,sp,-112
    8000028e:	f486                	sd	ra,104(sp)
    80000290:	f0a2                	sd	s0,96(sp)
    80000292:	eca6                	sd	s1,88(sp)
    80000294:	e8ca                	sd	s2,80(sp)
    80000296:	e4ce                	sd	s3,72(sp)
    80000298:	e0d2                	sd	s4,64(sp)
    8000029a:	fc56                	sd	s5,56(sp)
    8000029c:	f85a                	sd	s6,48(sp)
    8000029e:	f45e                	sd	s7,40(sp)
    800002a0:	f062                	sd	s8,32(sp)
    800002a2:	ec66                	sd	s9,24(sp)
    800002a4:	e86a                	sd	s10,16(sp)
    800002a6:	1880                	addi	s0,sp,112
    800002a8:	8aaa                	mv	s5,a0
    800002aa:	8a2e                	mv	s4,a1
    800002ac:	89b2                	mv	s3,a2
  uint target;
  int c;
  char cbuf;

  target = n;
    800002ae:	00060b1b          	sext.w	s6,a2
  acquire(&cons.lock);
    800002b2:	00013517          	auipc	a0,0x13
    800002b6:	ece50513          	addi	a0,a0,-306 # 80013180 <cons>
    800002ba:	00001097          	auipc	ra,0x1
    800002be:	a3e080e7          	jalr	-1474(ra) # 80000cf8 <acquire>
  while(n > 0){
    // wait until interrupt handler has put some
    // input into cons.buffer.
    while(cons.r == cons.w){
    800002c2:	00013497          	auipc	s1,0x13
    800002c6:	ebe48493          	addi	s1,s1,-322 # 80013180 <cons>
      if(myproc()->killed){
        release(&cons.lock);
        return -1;
      }
      _sleep(&cons.r, &cons.lock);
    800002ca:	00013917          	auipc	s2,0x13
    800002ce:	f4e90913          	addi	s2,s2,-178 # 80013218 <cons+0x98>
    }

    c = cons.buf[cons.r++ % INPUT_BUF];

    if(c == C('D')){  // end-of-file
    800002d2:	4b91                	li	s7,4
      break;
    }

    // copy the input byte to the user-space buffer.
    cbuf = c;
    if(either_copyout(user_dst, dst, &cbuf, 1) == -1)
    800002d4:	5c7d                	li	s8,-1
      break;

    dst++;
    --n;

    if(c == '\n'){
    800002d6:	4ca9                	li	s9,10
  while(n > 0){
    800002d8:	07305863          	blez	s3,80000348 <consoleread+0xbc>
    while(cons.r == cons.w){
    800002dc:	0984a783          	lw	a5,152(s1)
    800002e0:	09c4a703          	lw	a4,156(s1)
    800002e4:	02f71463          	bne	a4,a5,8000030c <consoleread+0x80>
      if(myproc()->killed){
    800002e8:	00001097          	auipc	ra,0x1
    800002ec:	7fc080e7          	jalr	2044(ra) # 80001ae4 <myproc>
    800002f0:	551c                	lw	a5,40(a0)
    800002f2:	e7b5                	bnez	a5,8000035e <consoleread+0xd2>
      _sleep(&cons.r, &cons.lock);
    800002f4:	85a6                	mv	a1,s1
    800002f6:	854a                	mv	a0,s2
    800002f8:	00002097          	auipc	ra,0x2
    800002fc:	eba080e7          	jalr	-326(ra) # 800021b2 <_sleep>
    while(cons.r == cons.w){
    80000300:	0984a783          	lw	a5,152(s1)
    80000304:	09c4a703          	lw	a4,156(s1)
    80000308:	fef700e3          	beq	a4,a5,800002e8 <consoleread+0x5c>
    c = cons.buf[cons.r++ % INPUT_BUF];
    8000030c:	0017871b          	addiw	a4,a5,1
    80000310:	08e4ac23          	sw	a4,152(s1)
    80000314:	07f7f713          	andi	a4,a5,127
    80000318:	9726                	add	a4,a4,s1
    8000031a:	01874703          	lbu	a4,24(a4)
    8000031e:	00070d1b          	sext.w	s10,a4
    if(c == C('D')){  // end-of-file
    80000322:	077d0563          	beq	s10,s7,8000038c <consoleread+0x100>
    cbuf = c;
    80000326:	f8e40fa3          	sb	a4,-97(s0)
    if(either_copyout(user_dst, dst, &cbuf, 1) == -1)
    8000032a:	4685                	li	a3,1
    8000032c:	f9f40613          	addi	a2,s0,-97
    80000330:	85d2                	mv	a1,s4
    80000332:	8556                	mv	a0,s5
    80000334:	00002097          	auipc	ra,0x2
    80000338:	220080e7          	jalr	544(ra) # 80002554 <either_copyout>
    8000033c:	01850663          	beq	a0,s8,80000348 <consoleread+0xbc>
    dst++;
    80000340:	0a05                	addi	s4,s4,1
    --n;
    80000342:	39fd                	addiw	s3,s3,-1
    if(c == '\n'){
    80000344:	f99d1ae3          	bne	s10,s9,800002d8 <consoleread+0x4c>
      // a whole line has arrived, return to
      // the user-level read().
      break;
    }
  }
  release(&cons.lock);
    80000348:	00013517          	auipc	a0,0x13
    8000034c:	e3850513          	addi	a0,a0,-456 # 80013180 <cons>
    80000350:	00001097          	auipc	ra,0x1
    80000354:	a5c080e7          	jalr	-1444(ra) # 80000dac <release>

  return target - n;
    80000358:	413b053b          	subw	a0,s6,s3
    8000035c:	a811                	j	80000370 <consoleread+0xe4>
        release(&cons.lock);
    8000035e:	00013517          	auipc	a0,0x13
    80000362:	e2250513          	addi	a0,a0,-478 # 80013180 <cons>
    80000366:	00001097          	auipc	ra,0x1
    8000036a:	a46080e7          	jalr	-1466(ra) # 80000dac <release>
        return -1;
    8000036e:	557d                	li	a0,-1
}
    80000370:	70a6                	ld	ra,104(sp)
    80000372:	7406                	ld	s0,96(sp)
    80000374:	64e6                	ld	s1,88(sp)
    80000376:	6946                	ld	s2,80(sp)
    80000378:	69a6                	ld	s3,72(sp)
    8000037a:	6a06                	ld	s4,64(sp)
    8000037c:	7ae2                	ld	s5,56(sp)
    8000037e:	7b42                	ld	s6,48(sp)
    80000380:	7ba2                	ld	s7,40(sp)
    80000382:	7c02                	ld	s8,32(sp)
    80000384:	6ce2                	ld	s9,24(sp)
    80000386:	6d42                	ld	s10,16(sp)
    80000388:	6165                	addi	sp,sp,112
    8000038a:	8082                	ret
      if(n < target){
    8000038c:	0009871b          	sext.w	a4,s3
    80000390:	fb677ce3          	bgeu	a4,s6,80000348 <consoleread+0xbc>
        cons.r--;
    80000394:	00013717          	auipc	a4,0x13
    80000398:	e8f72223          	sw	a5,-380(a4) # 80013218 <cons+0x98>
    8000039c:	b775                	j	80000348 <consoleread+0xbc>

000000008000039e <consputc>:
{
    8000039e:	1141                	addi	sp,sp,-16
    800003a0:	e406                	sd	ra,8(sp)
    800003a2:	e022                	sd	s0,0(sp)
    800003a4:	0800                	addi	s0,sp,16
  if(c == BACKSPACE){
    800003a6:	10000793          	li	a5,256
    800003aa:	00f50a63          	beq	a0,a5,800003be <consputc+0x20>
    uartputc_sync(c);
    800003ae:	00000097          	auipc	ra,0x0
    800003b2:	560080e7          	jalr	1376(ra) # 8000090e <uartputc_sync>
}
    800003b6:	60a2                	ld	ra,8(sp)
    800003b8:	6402                	ld	s0,0(sp)
    800003ba:	0141                	addi	sp,sp,16
    800003bc:	8082                	ret
    uartputc_sync('\b'); uartputc_sync(' '); uartputc_sync('\b');
    800003be:	4521                	li	a0,8
    800003c0:	00000097          	auipc	ra,0x0
    800003c4:	54e080e7          	jalr	1358(ra) # 8000090e <uartputc_sync>
    800003c8:	02000513          	li	a0,32
    800003cc:	00000097          	auipc	ra,0x0
    800003d0:	542080e7          	jalr	1346(ra) # 8000090e <uartputc_sync>
    800003d4:	4521                	li	a0,8
    800003d6:	00000097          	auipc	ra,0x0
    800003da:	538080e7          	jalr	1336(ra) # 8000090e <uartputc_sync>
    800003de:	bfe1                	j	800003b6 <consputc+0x18>

00000000800003e0 <consoleintr>:
// do erase/kill processing, append to cons.buf,
// wake up consoleread() if a whole line has arrived.
//
void
consoleintr(int c)
{
    800003e0:	1101                	addi	sp,sp,-32
    800003e2:	ec06                	sd	ra,24(sp)
    800003e4:	e822                	sd	s0,16(sp)
    800003e6:	e426                	sd	s1,8(sp)
    800003e8:	e04a                	sd	s2,0(sp)
    800003ea:	1000                	addi	s0,sp,32
    800003ec:	84aa                	mv	s1,a0
  acquire(&cons.lock);
    800003ee:	00013517          	auipc	a0,0x13
    800003f2:	d9250513          	addi	a0,a0,-622 # 80013180 <cons>
    800003f6:	00001097          	auipc	ra,0x1
    800003fa:	902080e7          	jalr	-1790(ra) # 80000cf8 <acquire>

  switch(c){
    800003fe:	47d5                	li	a5,21
    80000400:	0af48663          	beq	s1,a5,800004ac <consoleintr+0xcc>
    80000404:	0297ca63          	blt	a5,s1,80000438 <consoleintr+0x58>
    80000408:	47a1                	li	a5,8
    8000040a:	0ef48763          	beq	s1,a5,800004f8 <consoleintr+0x118>
    8000040e:	47c1                	li	a5,16
    80000410:	10f49a63          	bne	s1,a5,80000524 <consoleintr+0x144>
  case C('P'):  // Print process list.
    procdump();
    80000414:	00002097          	auipc	ra,0x2
    80000418:	1ec080e7          	jalr	492(ra) # 80002600 <procdump>
      }
    }
    break;
  }
  
  release(&cons.lock);
    8000041c:	00013517          	auipc	a0,0x13
    80000420:	d6450513          	addi	a0,a0,-668 # 80013180 <cons>
    80000424:	00001097          	auipc	ra,0x1
    80000428:	988080e7          	jalr	-1656(ra) # 80000dac <release>
}
    8000042c:	60e2                	ld	ra,24(sp)
    8000042e:	6442                	ld	s0,16(sp)
    80000430:	64a2                	ld	s1,8(sp)
    80000432:	6902                	ld	s2,0(sp)
    80000434:	6105                	addi	sp,sp,32
    80000436:	8082                	ret
  switch(c){
    80000438:	07f00793          	li	a5,127
    8000043c:	0af48e63          	beq	s1,a5,800004f8 <consoleintr+0x118>
    if(c != 0 && cons.e-cons.r < INPUT_BUF){
    80000440:	00013717          	auipc	a4,0x13
    80000444:	d4070713          	addi	a4,a4,-704 # 80013180 <cons>
    80000448:	0a072783          	lw	a5,160(a4)
    8000044c:	09872703          	lw	a4,152(a4)
    80000450:	9f99                	subw	a5,a5,a4
    80000452:	07f00713          	li	a4,127
    80000456:	fcf763e3          	bltu	a4,a5,8000041c <consoleintr+0x3c>
      c = (c == '\r') ? '\n' : c;
    8000045a:	47b5                	li	a5,13
    8000045c:	0cf48763          	beq	s1,a5,8000052a <consoleintr+0x14a>
      consputc(c);
    80000460:	8526                	mv	a0,s1
    80000462:	00000097          	auipc	ra,0x0
    80000466:	f3c080e7          	jalr	-196(ra) # 8000039e <consputc>
      cons.buf[cons.e++ % INPUT_BUF] = c;
    8000046a:	00013797          	auipc	a5,0x13
    8000046e:	d1678793          	addi	a5,a5,-746 # 80013180 <cons>
    80000472:	0a07a703          	lw	a4,160(a5)
    80000476:	0017069b          	addiw	a3,a4,1
    8000047a:	0006861b          	sext.w	a2,a3
    8000047e:	0ad7a023          	sw	a3,160(a5)
    80000482:	07f77713          	andi	a4,a4,127
    80000486:	97ba                	add	a5,a5,a4
    80000488:	00978c23          	sb	s1,24(a5)
      if(c == '\n' || c == C('D') || cons.e == cons.r+INPUT_BUF){
    8000048c:	47a9                	li	a5,10
    8000048e:	0cf48563          	beq	s1,a5,80000558 <consoleintr+0x178>
    80000492:	4791                	li	a5,4
    80000494:	0cf48263          	beq	s1,a5,80000558 <consoleintr+0x178>
    80000498:	00013797          	auipc	a5,0x13
    8000049c:	d807a783          	lw	a5,-640(a5) # 80013218 <cons+0x98>
    800004a0:	0807879b          	addiw	a5,a5,128
    800004a4:	f6f61ce3          	bne	a2,a5,8000041c <consoleintr+0x3c>
      cons.buf[cons.e++ % INPUT_BUF] = c;
    800004a8:	863e                	mv	a2,a5
    800004aa:	a07d                	j	80000558 <consoleintr+0x178>
    while(cons.e != cons.w &&
    800004ac:	00013717          	auipc	a4,0x13
    800004b0:	cd470713          	addi	a4,a4,-812 # 80013180 <cons>
    800004b4:	0a072783          	lw	a5,160(a4)
    800004b8:	09c72703          	lw	a4,156(a4)
          cons.buf[(cons.e-1) % INPUT_BUF] != '\n'){
    800004bc:	00013497          	auipc	s1,0x13
    800004c0:	cc448493          	addi	s1,s1,-828 # 80013180 <cons>
    while(cons.e != cons.w &&
    800004c4:	4929                	li	s2,10
    800004c6:	f4f70be3          	beq	a4,a5,8000041c <consoleintr+0x3c>
          cons.buf[(cons.e-1) % INPUT_BUF] != '\n'){
    800004ca:	37fd                	addiw	a5,a5,-1
    800004cc:	07f7f713          	andi	a4,a5,127
    800004d0:	9726                	add	a4,a4,s1
    while(cons.e != cons.w &&
    800004d2:	01874703          	lbu	a4,24(a4)
    800004d6:	f52703e3          	beq	a4,s2,8000041c <consoleintr+0x3c>
      cons.e--;
    800004da:	0af4a023          	sw	a5,160(s1)
      consputc(BACKSPACE);
    800004de:	10000513          	li	a0,256
    800004e2:	00000097          	auipc	ra,0x0
    800004e6:	ebc080e7          	jalr	-324(ra) # 8000039e <consputc>
    while(cons.e != cons.w &&
    800004ea:	0a04a783          	lw	a5,160(s1)
    800004ee:	09c4a703          	lw	a4,156(s1)
    800004f2:	fcf71ce3          	bne	a4,a5,800004ca <consoleintr+0xea>
    800004f6:	b71d                	j	8000041c <consoleintr+0x3c>
    if(cons.e != cons.w){
    800004f8:	00013717          	auipc	a4,0x13
    800004fc:	c8870713          	addi	a4,a4,-888 # 80013180 <cons>
    80000500:	0a072783          	lw	a5,160(a4)
    80000504:	09c72703          	lw	a4,156(a4)
    80000508:	f0f70ae3          	beq	a4,a5,8000041c <consoleintr+0x3c>
      cons.e--;
    8000050c:	37fd                	addiw	a5,a5,-1
    8000050e:	00013717          	auipc	a4,0x13
    80000512:	d0f72923          	sw	a5,-750(a4) # 80013220 <cons+0xa0>
      consputc(BACKSPACE);
    80000516:	10000513          	li	a0,256
    8000051a:	00000097          	auipc	ra,0x0
    8000051e:	e84080e7          	jalr	-380(ra) # 8000039e <consputc>
    80000522:	bded                	j	8000041c <consoleintr+0x3c>
    if(c != 0 && cons.e-cons.r < INPUT_BUF){
    80000524:	ee048ce3          	beqz	s1,8000041c <consoleintr+0x3c>
    80000528:	bf21                	j	80000440 <consoleintr+0x60>
      consputc(c);
    8000052a:	4529                	li	a0,10
    8000052c:	00000097          	auipc	ra,0x0
    80000530:	e72080e7          	jalr	-398(ra) # 8000039e <consputc>
      cons.buf[cons.e++ % INPUT_BUF] = c;
    80000534:	00013797          	auipc	a5,0x13
    80000538:	c4c78793          	addi	a5,a5,-948 # 80013180 <cons>
    8000053c:	0a07a703          	lw	a4,160(a5)
    80000540:	0017069b          	addiw	a3,a4,1
    80000544:	0006861b          	sext.w	a2,a3
    80000548:	0ad7a023          	sw	a3,160(a5)
    8000054c:	07f77713          	andi	a4,a4,127
    80000550:	97ba                	add	a5,a5,a4
    80000552:	4729                	li	a4,10
    80000554:	00e78c23          	sb	a4,24(a5)
        cons.w = cons.e;
    80000558:	00013797          	auipc	a5,0x13
    8000055c:	ccc7a223          	sw	a2,-828(a5) # 8001321c <cons+0x9c>
        wakeup(&cons.r);
    80000560:	00013517          	auipc	a0,0x13
    80000564:	cb850513          	addi	a0,a0,-840 # 80013218 <cons+0x98>
    80000568:	00002097          	auipc	ra,0x2
    8000056c:	dd6080e7          	jalr	-554(ra) # 8000233e <wakeup>
    80000570:	b575                	j	8000041c <consoleintr+0x3c>

0000000080000572 <consoleinit>:

void
consoleinit(void)
{
    80000572:	1141                	addi	sp,sp,-16
    80000574:	e406                	sd	ra,8(sp)
    80000576:	e022                	sd	s0,0(sp)
    80000578:	0800                	addi	s0,sp,16
  initlock(&cons.lock, "cons");
    8000057a:	00009597          	auipc	a1,0x9
    8000057e:	a9658593          	addi	a1,a1,-1386 # 80009010 <etext+0x10>
    80000582:	00013517          	auipc	a0,0x13
    80000586:	bfe50513          	addi	a0,a0,-1026 # 80013180 <cons>
    8000058a:	00000097          	auipc	ra,0x0
    8000058e:	6de080e7          	jalr	1758(ra) # 80000c68 <initlock>

  uartinit();
    80000592:	00000097          	auipc	ra,0x0
    80000596:	32c080e7          	jalr	812(ra) # 800008be <uartinit>

  // connect read and write system calls
  // to consoleread and consolewrite.
  devsw[CONSOLE].read = consoleread;
    8000059a:	00022797          	auipc	a5,0x22
    8000059e:	f9e78793          	addi	a5,a5,-98 # 80022538 <devsw>
    800005a2:	00000717          	auipc	a4,0x0
    800005a6:	cea70713          	addi	a4,a4,-790 # 8000028c <consoleread>
    800005aa:	eb98                	sd	a4,16(a5)
  devsw[CONSOLE].write = consolewrite;
    800005ac:	00000717          	auipc	a4,0x0
    800005b0:	c7c70713          	addi	a4,a4,-900 # 80000228 <consolewrite>
    800005b4:	ef98                	sd	a4,24(a5)
}
    800005b6:	60a2                	ld	ra,8(sp)
    800005b8:	6402                	ld	s0,0(sp)
    800005ba:	0141                	addi	sp,sp,16
    800005bc:	8082                	ret

00000000800005be <printint>:

static char digits[] = "0123456789abcdef";

static void
printint(int xx, int base, int sign)
{
    800005be:	7179                	addi	sp,sp,-48
    800005c0:	f406                	sd	ra,40(sp)
    800005c2:	f022                	sd	s0,32(sp)
    800005c4:	ec26                	sd	s1,24(sp)
    800005c6:	e84a                	sd	s2,16(sp)
    800005c8:	1800                	addi	s0,sp,48
  char buf[16];
  int i;
  uint x;

  if(sign && (sign = xx < 0))
    800005ca:	c219                	beqz	a2,800005d0 <printint+0x12>
    800005cc:	08054763          	bltz	a0,8000065a <printint+0x9c>
    x = -xx;
  else
    x = xx;
    800005d0:	2501                	sext.w	a0,a0
    800005d2:	4881                	li	a7,0
    800005d4:	fd040693          	addi	a3,s0,-48

  i = 0;
    800005d8:	4701                	li	a4,0
  do {
    buf[i++] = digits[x % base];
    800005da:	2581                	sext.w	a1,a1
    800005dc:	00009617          	auipc	a2,0x9
    800005e0:	a6460613          	addi	a2,a2,-1436 # 80009040 <digits>
    800005e4:	883a                	mv	a6,a4
    800005e6:	2705                	addiw	a4,a4,1
    800005e8:	02b577bb          	remuw	a5,a0,a1
    800005ec:	1782                	slli	a5,a5,0x20
    800005ee:	9381                	srli	a5,a5,0x20
    800005f0:	97b2                	add	a5,a5,a2
    800005f2:	0007c783          	lbu	a5,0(a5)
    800005f6:	00f68023          	sb	a5,0(a3)
  } while((x /= base) != 0);
    800005fa:	0005079b          	sext.w	a5,a0
    800005fe:	02b5553b          	divuw	a0,a0,a1
    80000602:	0685                	addi	a3,a3,1
    80000604:	feb7f0e3          	bgeu	a5,a1,800005e4 <printint+0x26>

  if(sign)
    80000608:	00088c63          	beqz	a7,80000620 <printint+0x62>
    buf[i++] = '-';
    8000060c:	fe070793          	addi	a5,a4,-32
    80000610:	00878733          	add	a4,a5,s0
    80000614:	02d00793          	li	a5,45
    80000618:	fef70823          	sb	a5,-16(a4)
    8000061c:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
    80000620:	02e05763          	blez	a4,8000064e <printint+0x90>
    80000624:	fd040793          	addi	a5,s0,-48
    80000628:	00e784b3          	add	s1,a5,a4
    8000062c:	fff78913          	addi	s2,a5,-1
    80000630:	993a                	add	s2,s2,a4
    80000632:	377d                	addiw	a4,a4,-1
    80000634:	1702                	slli	a4,a4,0x20
    80000636:	9301                	srli	a4,a4,0x20
    80000638:	40e90933          	sub	s2,s2,a4
    consputc(buf[i]);
    8000063c:	fff4c503          	lbu	a0,-1(s1)
    80000640:	00000097          	auipc	ra,0x0
    80000644:	d5e080e7          	jalr	-674(ra) # 8000039e <consputc>
  while(--i >= 0)
    80000648:	14fd                	addi	s1,s1,-1
    8000064a:	ff2499e3          	bne	s1,s2,8000063c <printint+0x7e>
}
    8000064e:	70a2                	ld	ra,40(sp)
    80000650:	7402                	ld	s0,32(sp)
    80000652:	64e2                	ld	s1,24(sp)
    80000654:	6942                	ld	s2,16(sp)
    80000656:	6145                	addi	sp,sp,48
    80000658:	8082                	ret
    x = -xx;
    8000065a:	40a0053b          	negw	a0,a0
  if(sign && (sign = xx < 0))
    8000065e:	4885                	li	a7,1
    x = -xx;
    80000660:	bf95                	j	800005d4 <printint+0x16>

0000000080000662 <panic>:
    release(&pr.lock);
}

void
panic(char *s)
{
    80000662:	1101                	addi	sp,sp,-32
    80000664:	ec06                	sd	ra,24(sp)
    80000666:	e822                	sd	s0,16(sp)
    80000668:	e426                	sd	s1,8(sp)
    8000066a:	1000                	addi	s0,sp,32
    8000066c:	84aa                	mv	s1,a0
  pr.locking = 0;
    8000066e:	00013797          	auipc	a5,0x13
    80000672:	bc07a923          	sw	zero,-1070(a5) # 80013240 <pr+0x18>
  kprintf("panic: ");
    80000676:	00009517          	auipc	a0,0x9
    8000067a:	9a250513          	addi	a0,a0,-1630 # 80009018 <etext+0x18>
    8000067e:	00000097          	auipc	ra,0x0
    80000682:	02e080e7          	jalr	46(ra) # 800006ac <kprintf>
  kprintf(s);
    80000686:	8526                	mv	a0,s1
    80000688:	00000097          	auipc	ra,0x0
    8000068c:	024080e7          	jalr	36(ra) # 800006ac <kprintf>
  kprintf("\n");
    80000690:	00009517          	auipc	a0,0x9
    80000694:	a3850513          	addi	a0,a0,-1480 # 800090c8 <digits+0x88>
    80000698:	00000097          	auipc	ra,0x0
    8000069c:	014080e7          	jalr	20(ra) # 800006ac <kprintf>
  panicked = 1; // freeze uart output from other CPUs
    800006a0:	4785                	li	a5,1
    800006a2:	0000b717          	auipc	a4,0xb
    800006a6:	94f72f23          	sw	a5,-1698(a4) # 8000b000 <panicked>
  for(;;)
    800006aa:	a001                	j	800006aa <panic+0x48>

00000000800006ac <kprintf>:
{
    800006ac:	7131                	addi	sp,sp,-192
    800006ae:	fc86                	sd	ra,120(sp)
    800006b0:	f8a2                	sd	s0,112(sp)
    800006b2:	f4a6                	sd	s1,104(sp)
    800006b4:	f0ca                	sd	s2,96(sp)
    800006b6:	ecce                	sd	s3,88(sp)
    800006b8:	e8d2                	sd	s4,80(sp)
    800006ba:	e4d6                	sd	s5,72(sp)
    800006bc:	e0da                	sd	s6,64(sp)
    800006be:	fc5e                	sd	s7,56(sp)
    800006c0:	f862                	sd	s8,48(sp)
    800006c2:	f466                	sd	s9,40(sp)
    800006c4:	f06a                	sd	s10,32(sp)
    800006c6:	ec6e                	sd	s11,24(sp)
    800006c8:	0100                	addi	s0,sp,128
    800006ca:	8a2a                	mv	s4,a0
    800006cc:	e40c                	sd	a1,8(s0)
    800006ce:	e810                	sd	a2,16(s0)
    800006d0:	ec14                	sd	a3,24(s0)
    800006d2:	f018                	sd	a4,32(s0)
    800006d4:	f41c                	sd	a5,40(s0)
    800006d6:	03043823          	sd	a6,48(s0)
    800006da:	03143c23          	sd	a7,56(s0)
  locking = pr.locking;
    800006de:	00013d97          	auipc	s11,0x13
    800006e2:	b62dad83          	lw	s11,-1182(s11) # 80013240 <pr+0x18>
  if(locking)
    800006e6:	020d9b63          	bnez	s11,8000071c <kprintf+0x70>
  if (fmt == 0)
    800006ea:	040a0263          	beqz	s4,8000072e <kprintf+0x82>
  va_start(ap, fmt);
    800006ee:	00840793          	addi	a5,s0,8
    800006f2:	f8f43423          	sd	a5,-120(s0)
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
    800006f6:	000a4503          	lbu	a0,0(s4)
    800006fa:	14050f63          	beqz	a0,80000858 <kprintf+0x1ac>
    800006fe:	4981                	li	s3,0
    if(c != '%'){
    80000700:	02500a93          	li	s5,37
    switch(c){
    80000704:	07000b93          	li	s7,112
  consputc('x');
    80000708:	4d41                	li	s10,16
    consputc(digits[x >> (sizeof(uint64) * 8 - 4)]);
    8000070a:	00009b17          	auipc	s6,0x9
    8000070e:	936b0b13          	addi	s6,s6,-1738 # 80009040 <digits>
    switch(c){
    80000712:	07300c93          	li	s9,115
    80000716:	06400c13          	li	s8,100
    8000071a:	a82d                	j	80000754 <kprintf+0xa8>
    acquire(&pr.lock);
    8000071c:	00013517          	auipc	a0,0x13
    80000720:	b0c50513          	addi	a0,a0,-1268 # 80013228 <pr>
    80000724:	00000097          	auipc	ra,0x0
    80000728:	5d4080e7          	jalr	1492(ra) # 80000cf8 <acquire>
    8000072c:	bf7d                	j	800006ea <kprintf+0x3e>
    panic("null fmt");
    8000072e:	00009517          	auipc	a0,0x9
    80000732:	8fa50513          	addi	a0,a0,-1798 # 80009028 <etext+0x28>
    80000736:	00000097          	auipc	ra,0x0
    8000073a:	f2c080e7          	jalr	-212(ra) # 80000662 <panic>
      consputc(c);
    8000073e:	00000097          	auipc	ra,0x0
    80000742:	c60080e7          	jalr	-928(ra) # 8000039e <consputc>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
    80000746:	2985                	addiw	s3,s3,1
    80000748:	013a07b3          	add	a5,s4,s3
    8000074c:	0007c503          	lbu	a0,0(a5)
    80000750:	10050463          	beqz	a0,80000858 <kprintf+0x1ac>
    if(c != '%'){
    80000754:	ff5515e3          	bne	a0,s5,8000073e <kprintf+0x92>
    c = fmt[++i] & 0xff;
    80000758:	2985                	addiw	s3,s3,1
    8000075a:	013a07b3          	add	a5,s4,s3
    8000075e:	0007c783          	lbu	a5,0(a5)
    80000762:	0007849b          	sext.w	s1,a5
    if(c == 0)
    80000766:	cbed                	beqz	a5,80000858 <kprintf+0x1ac>
    switch(c){
    80000768:	05778a63          	beq	a5,s7,800007bc <kprintf+0x110>
    8000076c:	02fbf663          	bgeu	s7,a5,80000798 <kprintf+0xec>
    80000770:	09978863          	beq	a5,s9,80000800 <kprintf+0x154>
    80000774:	07800713          	li	a4,120
    80000778:	0ce79563          	bne	a5,a4,80000842 <kprintf+0x196>
      printint(va_arg(ap, int), 16, 1);
    8000077c:	f8843783          	ld	a5,-120(s0)
    80000780:	00878713          	addi	a4,a5,8
    80000784:	f8e43423          	sd	a4,-120(s0)
    80000788:	4605                	li	a2,1
    8000078a:	85ea                	mv	a1,s10
    8000078c:	4388                	lw	a0,0(a5)
    8000078e:	00000097          	auipc	ra,0x0
    80000792:	e30080e7          	jalr	-464(ra) # 800005be <printint>
      break;
    80000796:	bf45                	j	80000746 <kprintf+0x9a>
    switch(c){
    80000798:	09578f63          	beq	a5,s5,80000836 <kprintf+0x18a>
    8000079c:	0b879363          	bne	a5,s8,80000842 <kprintf+0x196>
      printint(va_arg(ap, int), 10, 1);
    800007a0:	f8843783          	ld	a5,-120(s0)
    800007a4:	00878713          	addi	a4,a5,8
    800007a8:	f8e43423          	sd	a4,-120(s0)
    800007ac:	4605                	li	a2,1
    800007ae:	45a9                	li	a1,10
    800007b0:	4388                	lw	a0,0(a5)
    800007b2:	00000097          	auipc	ra,0x0
    800007b6:	e0c080e7          	jalr	-500(ra) # 800005be <printint>
      break;
    800007ba:	b771                	j	80000746 <kprintf+0x9a>
      printptr(va_arg(ap, uint64));
    800007bc:	f8843783          	ld	a5,-120(s0)
    800007c0:	00878713          	addi	a4,a5,8
    800007c4:	f8e43423          	sd	a4,-120(s0)
    800007c8:	0007b903          	ld	s2,0(a5)
  consputc('0');
    800007cc:	03000513          	li	a0,48
    800007d0:	00000097          	auipc	ra,0x0
    800007d4:	bce080e7          	jalr	-1074(ra) # 8000039e <consputc>
  consputc('x');
    800007d8:	07800513          	li	a0,120
    800007dc:	00000097          	auipc	ra,0x0
    800007e0:	bc2080e7          	jalr	-1086(ra) # 8000039e <consputc>
    800007e4:	84ea                	mv	s1,s10
    consputc(digits[x >> (sizeof(uint64) * 8 - 4)]);
    800007e6:	03c95793          	srli	a5,s2,0x3c
    800007ea:	97da                	add	a5,a5,s6
    800007ec:	0007c503          	lbu	a0,0(a5)
    800007f0:	00000097          	auipc	ra,0x0
    800007f4:	bae080e7          	jalr	-1106(ra) # 8000039e <consputc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    800007f8:	0912                	slli	s2,s2,0x4
    800007fa:	34fd                	addiw	s1,s1,-1
    800007fc:	f4ed                	bnez	s1,800007e6 <kprintf+0x13a>
    800007fe:	b7a1                	j	80000746 <kprintf+0x9a>
      if((s = va_arg(ap, char*)) == 0)
    80000800:	f8843783          	ld	a5,-120(s0)
    80000804:	00878713          	addi	a4,a5,8
    80000808:	f8e43423          	sd	a4,-120(s0)
    8000080c:	6384                	ld	s1,0(a5)
    8000080e:	cc89                	beqz	s1,80000828 <kprintf+0x17c>
      for(; *s; s++)
    80000810:	0004c503          	lbu	a0,0(s1)
    80000814:	d90d                	beqz	a0,80000746 <kprintf+0x9a>
        consputc(*s);
    80000816:	00000097          	auipc	ra,0x0
    8000081a:	b88080e7          	jalr	-1144(ra) # 8000039e <consputc>
      for(; *s; s++)
    8000081e:	0485                	addi	s1,s1,1
    80000820:	0004c503          	lbu	a0,0(s1)
    80000824:	f96d                	bnez	a0,80000816 <kprintf+0x16a>
    80000826:	b705                	j	80000746 <kprintf+0x9a>
        s = "(null)";
    80000828:	00008497          	auipc	s1,0x8
    8000082c:	7f848493          	addi	s1,s1,2040 # 80009020 <etext+0x20>
      for(; *s; s++)
    80000830:	02800513          	li	a0,40
    80000834:	b7cd                	j	80000816 <kprintf+0x16a>
      consputc('%');
    80000836:	8556                	mv	a0,s5
    80000838:	00000097          	auipc	ra,0x0
    8000083c:	b66080e7          	jalr	-1178(ra) # 8000039e <consputc>
      break;
    80000840:	b719                	j	80000746 <kprintf+0x9a>
      consputc('%');
    80000842:	8556                	mv	a0,s5
    80000844:	00000097          	auipc	ra,0x0
    80000848:	b5a080e7          	jalr	-1190(ra) # 8000039e <consputc>
      consputc(c);
    8000084c:	8526                	mv	a0,s1
    8000084e:	00000097          	auipc	ra,0x0
    80000852:	b50080e7          	jalr	-1200(ra) # 8000039e <consputc>
      break;
    80000856:	bdc5                	j	80000746 <kprintf+0x9a>
  if(locking)
    80000858:	020d9163          	bnez	s11,8000087a <kprintf+0x1ce>
}
    8000085c:	70e6                	ld	ra,120(sp)
    8000085e:	7446                	ld	s0,112(sp)
    80000860:	74a6                	ld	s1,104(sp)
    80000862:	7906                	ld	s2,96(sp)
    80000864:	69e6                	ld	s3,88(sp)
    80000866:	6a46                	ld	s4,80(sp)
    80000868:	6aa6                	ld	s5,72(sp)
    8000086a:	6b06                	ld	s6,64(sp)
    8000086c:	7be2                	ld	s7,56(sp)
    8000086e:	7c42                	ld	s8,48(sp)
    80000870:	7ca2                	ld	s9,40(sp)
    80000872:	7d02                	ld	s10,32(sp)
    80000874:	6de2                	ld	s11,24(sp)
    80000876:	6129                	addi	sp,sp,192
    80000878:	8082                	ret
    release(&pr.lock);
    8000087a:	00013517          	auipc	a0,0x13
    8000087e:	9ae50513          	addi	a0,a0,-1618 # 80013228 <pr>
    80000882:	00000097          	auipc	ra,0x0
    80000886:	52a080e7          	jalr	1322(ra) # 80000dac <release>
}
    8000088a:	bfc9                	j	8000085c <kprintf+0x1b0>

000000008000088c <printfinit>:
    ;
}

void
printfinit(void)
{
    8000088c:	1101                	addi	sp,sp,-32
    8000088e:	ec06                	sd	ra,24(sp)
    80000890:	e822                	sd	s0,16(sp)
    80000892:	e426                	sd	s1,8(sp)
    80000894:	1000                	addi	s0,sp,32
  initlock(&pr.lock, "pr");
    80000896:	00013497          	auipc	s1,0x13
    8000089a:	99248493          	addi	s1,s1,-1646 # 80013228 <pr>
    8000089e:	00008597          	auipc	a1,0x8
    800008a2:	79a58593          	addi	a1,a1,1946 # 80009038 <etext+0x38>
    800008a6:	8526                	mv	a0,s1
    800008a8:	00000097          	auipc	ra,0x0
    800008ac:	3c0080e7          	jalr	960(ra) # 80000c68 <initlock>
  pr.locking = 1;
    800008b0:	4785                	li	a5,1
    800008b2:	cc9c                	sw	a5,24(s1)
}
    800008b4:	60e2                	ld	ra,24(sp)
    800008b6:	6442                	ld	s0,16(sp)
    800008b8:	64a2                	ld	s1,8(sp)
    800008ba:	6105                	addi	sp,sp,32
    800008bc:	8082                	ret

00000000800008be <uartinit>:

void uartstart();

void
uartinit(void)
{
    800008be:	1141                	addi	sp,sp,-16
    800008c0:	e406                	sd	ra,8(sp)
    800008c2:	e022                	sd	s0,0(sp)
    800008c4:	0800                	addi	s0,sp,16
  // disable interrupts.
  WriteReg(IER, 0x00);
    800008c6:	100007b7          	lui	a5,0x10000
    800008ca:	000780a3          	sb	zero,1(a5) # 10000001 <_entry-0x6fffffff>

  // special mode to set baud rate.
  WriteReg(LCR, LCR_BAUD_LATCH);
    800008ce:	f8000713          	li	a4,-128
    800008d2:	00e781a3          	sb	a4,3(a5)

  // LSB for baud rate of 38.4K.
  WriteReg(0, 0x03);
    800008d6:	470d                	li	a4,3
    800008d8:	00e78023          	sb	a4,0(a5)

  // MSB for baud rate of 38.4K.
  WriteReg(1, 0x00);
    800008dc:	000780a3          	sb	zero,1(a5)

  // leave set-baud mode,
  // and set word length to 8 bits, no parity.
  WriteReg(LCR, LCR_EIGHT_BITS);
    800008e0:	00e781a3          	sb	a4,3(a5)

  // reset and enable FIFOs.
  WriteReg(FCR, FCR_FIFO_ENABLE | FCR_FIFO_CLEAR);
    800008e4:	469d                	li	a3,7
    800008e6:	00d78123          	sb	a3,2(a5)

  // enable transmit and receive interrupts.
  WriteReg(IER, IER_TX_ENABLE | IER_RX_ENABLE);
    800008ea:	00e780a3          	sb	a4,1(a5)

  initlock(&uart_tx_lock, "uart");
    800008ee:	00008597          	auipc	a1,0x8
    800008f2:	76a58593          	addi	a1,a1,1898 # 80009058 <digits+0x18>
    800008f6:	00013517          	auipc	a0,0x13
    800008fa:	95250513          	addi	a0,a0,-1710 # 80013248 <uart_tx_lock>
    800008fe:	00000097          	auipc	ra,0x0
    80000902:	36a080e7          	jalr	874(ra) # 80000c68 <initlock>
}
    80000906:	60a2                	ld	ra,8(sp)
    80000908:	6402                	ld	s0,0(sp)
    8000090a:	0141                	addi	sp,sp,16
    8000090c:	8082                	ret

000000008000090e <uartputc_sync>:
// use interrupts, for use by kernel printf() and
// to echo characters. it spins waiting for the uart's
// output register to be empty.
void
uartputc_sync(int c)
{
    8000090e:	1101                	addi	sp,sp,-32
    80000910:	ec06                	sd	ra,24(sp)
    80000912:	e822                	sd	s0,16(sp)
    80000914:	e426                	sd	s1,8(sp)
    80000916:	1000                	addi	s0,sp,32
    80000918:	84aa                	mv	s1,a0
  push_off();
    8000091a:	00000097          	auipc	ra,0x0
    8000091e:	392080e7          	jalr	914(ra) # 80000cac <push_off>

  if(panicked){
    80000922:	0000a797          	auipc	a5,0xa
    80000926:	6de7a783          	lw	a5,1758(a5) # 8000b000 <panicked>
    for(;;)
      ;
  }

  // wait for Transmit Holding Empty to be set in LSR.
  while((ReadReg(LSR) & LSR_TX_IDLE) == 0)
    8000092a:	10000737          	lui	a4,0x10000
  if(panicked){
    8000092e:	c391                	beqz	a5,80000932 <uartputc_sync+0x24>
    for(;;)
    80000930:	a001                	j	80000930 <uartputc_sync+0x22>
  while((ReadReg(LSR) & LSR_TX_IDLE) == 0)
    80000932:	00574783          	lbu	a5,5(a4) # 10000005 <_entry-0x6ffffffb>
    80000936:	0207f793          	andi	a5,a5,32
    8000093a:	dfe5                	beqz	a5,80000932 <uartputc_sync+0x24>
    ;
  WriteReg(THR, c);
    8000093c:	0ff4f513          	zext.b	a0,s1
    80000940:	100007b7          	lui	a5,0x10000
    80000944:	00a78023          	sb	a0,0(a5) # 10000000 <_entry-0x70000000>

  pop_off();
    80000948:	00000097          	auipc	ra,0x0
    8000094c:	404080e7          	jalr	1028(ra) # 80000d4c <pop_off>
}
    80000950:	60e2                	ld	ra,24(sp)
    80000952:	6442                	ld	s0,16(sp)
    80000954:	64a2                	ld	s1,8(sp)
    80000956:	6105                	addi	sp,sp,32
    80000958:	8082                	ret

000000008000095a <uartstart>:
// called from both the top- and bottom-half.
void
uartstart()
{
  while(1){
    if(uart_tx_w == uart_tx_r){
    8000095a:	0000a797          	auipc	a5,0xa
    8000095e:	6ae7b783          	ld	a5,1710(a5) # 8000b008 <uart_tx_r>
    80000962:	0000a717          	auipc	a4,0xa
    80000966:	6ae73703          	ld	a4,1710(a4) # 8000b010 <uart_tx_w>
    8000096a:	06f70a63          	beq	a4,a5,800009de <uartstart+0x84>
{
    8000096e:	7139                	addi	sp,sp,-64
    80000970:	fc06                	sd	ra,56(sp)
    80000972:	f822                	sd	s0,48(sp)
    80000974:	f426                	sd	s1,40(sp)
    80000976:	f04a                	sd	s2,32(sp)
    80000978:	ec4e                	sd	s3,24(sp)
    8000097a:	e852                	sd	s4,16(sp)
    8000097c:	e456                	sd	s5,8(sp)
    8000097e:	0080                	addi	s0,sp,64
      // transmit buffer is empty.
      return;
    }
    
    if((ReadReg(LSR) & LSR_TX_IDLE) == 0){
    80000980:	10000937          	lui	s2,0x10000
      // so we cannot give it another byte.
      // it will interrupt when it's ready for a new byte.
      return;
    }
    
    int c = uart_tx_buf[uart_tx_r % UART_TX_BUF_SIZE];
    80000984:	00013a17          	auipc	s4,0x13
    80000988:	8c4a0a13          	addi	s4,s4,-1852 # 80013248 <uart_tx_lock>
    uart_tx_r += 1;
    8000098c:	0000a497          	auipc	s1,0xa
    80000990:	67c48493          	addi	s1,s1,1660 # 8000b008 <uart_tx_r>
    if(uart_tx_w == uart_tx_r){
    80000994:	0000a997          	auipc	s3,0xa
    80000998:	67c98993          	addi	s3,s3,1660 # 8000b010 <uart_tx_w>
    if((ReadReg(LSR) & LSR_TX_IDLE) == 0){
    8000099c:	00594703          	lbu	a4,5(s2) # 10000005 <_entry-0x6ffffffb>
    800009a0:	02077713          	andi	a4,a4,32
    800009a4:	c705                	beqz	a4,800009cc <uartstart+0x72>
    int c = uart_tx_buf[uart_tx_r % UART_TX_BUF_SIZE];
    800009a6:	01f7f713          	andi	a4,a5,31
    800009aa:	9752                	add	a4,a4,s4
    800009ac:	01874a83          	lbu	s5,24(a4)
    uart_tx_r += 1;
    800009b0:	0785                	addi	a5,a5,1
    800009b2:	e09c                	sd	a5,0(s1)
    
    // maybe uartputc() is waiting for space in the buffer.
    wakeup(&uart_tx_r);
    800009b4:	8526                	mv	a0,s1
    800009b6:	00002097          	auipc	ra,0x2
    800009ba:	988080e7          	jalr	-1656(ra) # 8000233e <wakeup>
    
    WriteReg(THR, c);
    800009be:	01590023          	sb	s5,0(s2)
    if(uart_tx_w == uart_tx_r){
    800009c2:	609c                	ld	a5,0(s1)
    800009c4:	0009b703          	ld	a4,0(s3)
    800009c8:	fcf71ae3          	bne	a4,a5,8000099c <uartstart+0x42>
  }
}
    800009cc:	70e2                	ld	ra,56(sp)
    800009ce:	7442                	ld	s0,48(sp)
    800009d0:	74a2                	ld	s1,40(sp)
    800009d2:	7902                	ld	s2,32(sp)
    800009d4:	69e2                	ld	s3,24(sp)
    800009d6:	6a42                	ld	s4,16(sp)
    800009d8:	6aa2                	ld	s5,8(sp)
    800009da:	6121                	addi	sp,sp,64
    800009dc:	8082                	ret
    800009de:	8082                	ret

00000000800009e0 <uartputc>:
{
    800009e0:	7179                	addi	sp,sp,-48
    800009e2:	f406                	sd	ra,40(sp)
    800009e4:	f022                	sd	s0,32(sp)
    800009e6:	ec26                	sd	s1,24(sp)
    800009e8:	e84a                	sd	s2,16(sp)
    800009ea:	e44e                	sd	s3,8(sp)
    800009ec:	e052                	sd	s4,0(sp)
    800009ee:	1800                	addi	s0,sp,48
    800009f0:	8a2a                	mv	s4,a0
  acquire(&uart_tx_lock);
    800009f2:	00013517          	auipc	a0,0x13
    800009f6:	85650513          	addi	a0,a0,-1962 # 80013248 <uart_tx_lock>
    800009fa:	00000097          	auipc	ra,0x0
    800009fe:	2fe080e7          	jalr	766(ra) # 80000cf8 <acquire>
  if(panicked){
    80000a02:	0000a797          	auipc	a5,0xa
    80000a06:	5fe7a783          	lw	a5,1534(a5) # 8000b000 <panicked>
    80000a0a:	c391                	beqz	a5,80000a0e <uartputc+0x2e>
    for(;;)
    80000a0c:	a001                	j	80000a0c <uartputc+0x2c>
    if(uart_tx_w == uart_tx_r + UART_TX_BUF_SIZE){
    80000a0e:	0000a717          	auipc	a4,0xa
    80000a12:	60273703          	ld	a4,1538(a4) # 8000b010 <uart_tx_w>
    80000a16:	0000a797          	auipc	a5,0xa
    80000a1a:	5f27b783          	ld	a5,1522(a5) # 8000b008 <uart_tx_r>
    80000a1e:	02078793          	addi	a5,a5,32
    80000a22:	02e79b63          	bne	a5,a4,80000a58 <uartputc+0x78>
      _sleep(&uart_tx_r, &uart_tx_lock);
    80000a26:	00013997          	auipc	s3,0x13
    80000a2a:	82298993          	addi	s3,s3,-2014 # 80013248 <uart_tx_lock>
    80000a2e:	0000a497          	auipc	s1,0xa
    80000a32:	5da48493          	addi	s1,s1,1498 # 8000b008 <uart_tx_r>
    if(uart_tx_w == uart_tx_r + UART_TX_BUF_SIZE){
    80000a36:	0000a917          	auipc	s2,0xa
    80000a3a:	5da90913          	addi	s2,s2,1498 # 8000b010 <uart_tx_w>
      _sleep(&uart_tx_r, &uart_tx_lock);
    80000a3e:	85ce                	mv	a1,s3
    80000a40:	8526                	mv	a0,s1
    80000a42:	00001097          	auipc	ra,0x1
    80000a46:	770080e7          	jalr	1904(ra) # 800021b2 <_sleep>
    if(uart_tx_w == uart_tx_r + UART_TX_BUF_SIZE){
    80000a4a:	00093703          	ld	a4,0(s2)
    80000a4e:	609c                	ld	a5,0(s1)
    80000a50:	02078793          	addi	a5,a5,32
    80000a54:	fee785e3          	beq	a5,a4,80000a3e <uartputc+0x5e>
      uart_tx_buf[uart_tx_w % UART_TX_BUF_SIZE] = c;
    80000a58:	00012497          	auipc	s1,0x12
    80000a5c:	7f048493          	addi	s1,s1,2032 # 80013248 <uart_tx_lock>
    80000a60:	01f77793          	andi	a5,a4,31
    80000a64:	97a6                	add	a5,a5,s1
    80000a66:	01478c23          	sb	s4,24(a5)
      uart_tx_w += 1;
    80000a6a:	0705                	addi	a4,a4,1
    80000a6c:	0000a797          	auipc	a5,0xa
    80000a70:	5ae7b223          	sd	a4,1444(a5) # 8000b010 <uart_tx_w>
      uartstart();
    80000a74:	00000097          	auipc	ra,0x0
    80000a78:	ee6080e7          	jalr	-282(ra) # 8000095a <uartstart>
      release(&uart_tx_lock);
    80000a7c:	8526                	mv	a0,s1
    80000a7e:	00000097          	auipc	ra,0x0
    80000a82:	32e080e7          	jalr	814(ra) # 80000dac <release>
}
    80000a86:	70a2                	ld	ra,40(sp)
    80000a88:	7402                	ld	s0,32(sp)
    80000a8a:	64e2                	ld	s1,24(sp)
    80000a8c:	6942                	ld	s2,16(sp)
    80000a8e:	69a2                	ld	s3,8(sp)
    80000a90:	6a02                	ld	s4,0(sp)
    80000a92:	6145                	addi	sp,sp,48
    80000a94:	8082                	ret

0000000080000a96 <uartgetc>:

// read one input character from the UART.
// return -1 if none is waiting.
int
uartgetc(void)
{
    80000a96:	1141                	addi	sp,sp,-16
    80000a98:	e422                	sd	s0,8(sp)
    80000a9a:	0800                	addi	s0,sp,16
  if(ReadReg(LSR) & 0x01){
    80000a9c:	100007b7          	lui	a5,0x10000
    80000aa0:	0057c783          	lbu	a5,5(a5) # 10000005 <_entry-0x6ffffffb>
    80000aa4:	8b85                	andi	a5,a5,1
    80000aa6:	cb81                	beqz	a5,80000ab6 <uartgetc+0x20>
    // input data is ready.
    return ReadReg(RHR);
    80000aa8:	100007b7          	lui	a5,0x10000
    80000aac:	0007c503          	lbu	a0,0(a5) # 10000000 <_entry-0x70000000>
  } else {
    return -1;
  }
}
    80000ab0:	6422                	ld	s0,8(sp)
    80000ab2:	0141                	addi	sp,sp,16
    80000ab4:	8082                	ret
    return -1;
    80000ab6:	557d                	li	a0,-1
    80000ab8:	bfe5                	j	80000ab0 <uartgetc+0x1a>

0000000080000aba <uartintr>:
// handle a uart interrupt, raised because input has
// arrived, or the uart is ready for more output, or
// both. called from trap.c.
void
uartintr(void)
{
    80000aba:	1101                	addi	sp,sp,-32
    80000abc:	ec06                	sd	ra,24(sp)
    80000abe:	e822                	sd	s0,16(sp)
    80000ac0:	e426                	sd	s1,8(sp)
    80000ac2:	1000                	addi	s0,sp,32
  // read and process incoming characters.
  while(1){
    int c = uartgetc();
    if(c == -1)
    80000ac4:	54fd                	li	s1,-1
    80000ac6:	a029                	j	80000ad0 <uartintr+0x16>
      break;
    consoleintr(c);
    80000ac8:	00000097          	auipc	ra,0x0
    80000acc:	918080e7          	jalr	-1768(ra) # 800003e0 <consoleintr>
    int c = uartgetc();
    80000ad0:	00000097          	auipc	ra,0x0
    80000ad4:	fc6080e7          	jalr	-58(ra) # 80000a96 <uartgetc>
    if(c == -1)
    80000ad8:	fe9518e3          	bne	a0,s1,80000ac8 <uartintr+0xe>
  }

  // send buffered characters.
  acquire(&uart_tx_lock);
    80000adc:	00012497          	auipc	s1,0x12
    80000ae0:	76c48493          	addi	s1,s1,1900 # 80013248 <uart_tx_lock>
    80000ae4:	8526                	mv	a0,s1
    80000ae6:	00000097          	auipc	ra,0x0
    80000aea:	212080e7          	jalr	530(ra) # 80000cf8 <acquire>
  uartstart();
    80000aee:	00000097          	auipc	ra,0x0
    80000af2:	e6c080e7          	jalr	-404(ra) # 8000095a <uartstart>
  release(&uart_tx_lock);
    80000af6:	8526                	mv	a0,s1
    80000af8:	00000097          	auipc	ra,0x0
    80000afc:	2b4080e7          	jalr	692(ra) # 80000dac <release>
}
    80000b00:	60e2                	ld	ra,24(sp)
    80000b02:	6442                	ld	s0,16(sp)
    80000b04:	64a2                	ld	s1,8(sp)
    80000b06:	6105                	addi	sp,sp,32
    80000b08:	8082                	ret

0000000080000b0a <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(void *pa)
{
    80000b0a:	1101                	addi	sp,sp,-32
    80000b0c:	ec06                	sd	ra,24(sp)
    80000b0e:	e822                	sd	s0,16(sp)
    80000b10:	e426                	sd	s1,8(sp)
    80000b12:	e04a                	sd	s2,0(sp)
    80000b14:	1000                	addi	s0,sp,32
  struct run *r;

  if(((uint64)pa % PGSIZE) != 0 || (char*)pa < end || (uint64)pa >= PHYSTOP)
    80000b16:	03451793          	slli	a5,a0,0x34
    80000b1a:	ebb9                	bnez	a5,80000b70 <kfree+0x66>
    80000b1c:	84aa                	mv	s1,a0
    80000b1e:	0002a797          	auipc	a5,0x2a
    80000b22:	8a278793          	addi	a5,a5,-1886 # 8002a3c0 <end>
    80000b26:	04f56563          	bltu	a0,a5,80000b70 <kfree+0x66>
    80000b2a:	47c5                	li	a5,17
    80000b2c:	07ee                	slli	a5,a5,0x1b
    80000b2e:	04f57163          	bgeu	a0,a5,80000b70 <kfree+0x66>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  kmemset(pa, 1, PGSIZE);
    80000b32:	6605                	lui	a2,0x1
    80000b34:	4585                	li	a1,1
    80000b36:	00000097          	auipc	ra,0x0
    80000b3a:	2be080e7          	jalr	702(ra) # 80000df4 <kmemset>

  r = (struct run*)pa;

  acquire(&kmem.lock);
    80000b3e:	00012917          	auipc	s2,0x12
    80000b42:	74290913          	addi	s2,s2,1858 # 80013280 <kmem>
    80000b46:	854a                	mv	a0,s2
    80000b48:	00000097          	auipc	ra,0x0
    80000b4c:	1b0080e7          	jalr	432(ra) # 80000cf8 <acquire>
  r->next = kmem.freelist;
    80000b50:	01893783          	ld	a5,24(s2)
    80000b54:	e09c                	sd	a5,0(s1)
  kmem.freelist = r;
    80000b56:	00993c23          	sd	s1,24(s2)
  release(&kmem.lock);
    80000b5a:	854a                	mv	a0,s2
    80000b5c:	00000097          	auipc	ra,0x0
    80000b60:	250080e7          	jalr	592(ra) # 80000dac <release>
}
    80000b64:	60e2                	ld	ra,24(sp)
    80000b66:	6442                	ld	s0,16(sp)
    80000b68:	64a2                	ld	s1,8(sp)
    80000b6a:	6902                	ld	s2,0(sp)
    80000b6c:	6105                	addi	sp,sp,32
    80000b6e:	8082                	ret
    panic("kfree");
    80000b70:	00008517          	auipc	a0,0x8
    80000b74:	4f050513          	addi	a0,a0,1264 # 80009060 <digits+0x20>
    80000b78:	00000097          	auipc	ra,0x0
    80000b7c:	aea080e7          	jalr	-1302(ra) # 80000662 <panic>

0000000080000b80 <freerange>:
{
    80000b80:	7179                	addi	sp,sp,-48
    80000b82:	f406                	sd	ra,40(sp)
    80000b84:	f022                	sd	s0,32(sp)
    80000b86:	ec26                	sd	s1,24(sp)
    80000b88:	e84a                	sd	s2,16(sp)
    80000b8a:	e44e                	sd	s3,8(sp)
    80000b8c:	e052                	sd	s4,0(sp)
    80000b8e:	1800                	addi	s0,sp,48
  p = (char*)PGROUNDUP((uint64)pa_start);
    80000b90:	6785                	lui	a5,0x1
    80000b92:	fff78713          	addi	a4,a5,-1 # fff <_entry-0x7ffff001>
    80000b96:	00e504b3          	add	s1,a0,a4
    80000b9a:	777d                	lui	a4,0xfffff
    80000b9c:	8cf9                	and	s1,s1,a4
  for(; p + PGSIZE <= (char*)pa_end; p += PGSIZE)
    80000b9e:	94be                	add	s1,s1,a5
    80000ba0:	0095ee63          	bltu	a1,s1,80000bbc <freerange+0x3c>
    80000ba4:	892e                	mv	s2,a1
    kfree(p);
    80000ba6:	7a7d                	lui	s4,0xfffff
  for(; p + PGSIZE <= (char*)pa_end; p += PGSIZE)
    80000ba8:	6985                	lui	s3,0x1
    kfree(p);
    80000baa:	01448533          	add	a0,s1,s4
    80000bae:	00000097          	auipc	ra,0x0
    80000bb2:	f5c080e7          	jalr	-164(ra) # 80000b0a <kfree>
  for(; p + PGSIZE <= (char*)pa_end; p += PGSIZE)
    80000bb6:	94ce                	add	s1,s1,s3
    80000bb8:	fe9979e3          	bgeu	s2,s1,80000baa <freerange+0x2a>
}
    80000bbc:	70a2                	ld	ra,40(sp)
    80000bbe:	7402                	ld	s0,32(sp)
    80000bc0:	64e2                	ld	s1,24(sp)
    80000bc2:	6942                	ld	s2,16(sp)
    80000bc4:	69a2                	ld	s3,8(sp)
    80000bc6:	6a02                	ld	s4,0(sp)
    80000bc8:	6145                	addi	sp,sp,48
    80000bca:	8082                	ret

0000000080000bcc <kinit>:
{
    80000bcc:	1141                	addi	sp,sp,-16
    80000bce:	e406                	sd	ra,8(sp)
    80000bd0:	e022                	sd	s0,0(sp)
    80000bd2:	0800                	addi	s0,sp,16
  initlock(&kmem.lock, "kmem");
    80000bd4:	00008597          	auipc	a1,0x8
    80000bd8:	49458593          	addi	a1,a1,1172 # 80009068 <digits+0x28>
    80000bdc:	00012517          	auipc	a0,0x12
    80000be0:	6a450513          	addi	a0,a0,1700 # 80013280 <kmem>
    80000be4:	00000097          	auipc	ra,0x0
    80000be8:	084080e7          	jalr	132(ra) # 80000c68 <initlock>
  freerange(end, (void*)PHYSTOP);
    80000bec:	45c5                	li	a1,17
    80000bee:	05ee                	slli	a1,a1,0x1b
    80000bf0:	00029517          	auipc	a0,0x29
    80000bf4:	7d050513          	addi	a0,a0,2000 # 8002a3c0 <end>
    80000bf8:	00000097          	auipc	ra,0x0
    80000bfc:	f88080e7          	jalr	-120(ra) # 80000b80 <freerange>
}
    80000c00:	60a2                	ld	ra,8(sp)
    80000c02:	6402                	ld	s0,0(sp)
    80000c04:	0141                	addi	sp,sp,16
    80000c06:	8082                	ret

0000000080000c08 <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
void *
kalloc(void)
{
    80000c08:	1101                	addi	sp,sp,-32
    80000c0a:	ec06                	sd	ra,24(sp)
    80000c0c:	e822                	sd	s0,16(sp)
    80000c0e:	e426                	sd	s1,8(sp)
    80000c10:	1000                	addi	s0,sp,32
  struct run *r;

  acquire(&kmem.lock);
    80000c12:	00012497          	auipc	s1,0x12
    80000c16:	66e48493          	addi	s1,s1,1646 # 80013280 <kmem>
    80000c1a:	8526                	mv	a0,s1
    80000c1c:	00000097          	auipc	ra,0x0
    80000c20:	0dc080e7          	jalr	220(ra) # 80000cf8 <acquire>
  r = kmem.freelist;
    80000c24:	6c84                	ld	s1,24(s1)
  if(r)
    80000c26:	c885                	beqz	s1,80000c56 <kalloc+0x4e>
    kmem.freelist = r->next;
    80000c28:	609c                	ld	a5,0(s1)
    80000c2a:	00012517          	auipc	a0,0x12
    80000c2e:	65650513          	addi	a0,a0,1622 # 80013280 <kmem>
    80000c32:	ed1c                	sd	a5,24(a0)
  release(&kmem.lock);
    80000c34:	00000097          	auipc	ra,0x0
    80000c38:	178080e7          	jalr	376(ra) # 80000dac <release>

  if(r)
    kmemset((char*)r, 5, PGSIZE); // fill with junk
    80000c3c:	6605                	lui	a2,0x1
    80000c3e:	4595                	li	a1,5
    80000c40:	8526                	mv	a0,s1
    80000c42:	00000097          	auipc	ra,0x0
    80000c46:	1b2080e7          	jalr	434(ra) # 80000df4 <kmemset>
  return (void*)r;
}
    80000c4a:	8526                	mv	a0,s1
    80000c4c:	60e2                	ld	ra,24(sp)
    80000c4e:	6442                	ld	s0,16(sp)
    80000c50:	64a2                	ld	s1,8(sp)
    80000c52:	6105                	addi	sp,sp,32
    80000c54:	8082                	ret
  release(&kmem.lock);
    80000c56:	00012517          	auipc	a0,0x12
    80000c5a:	62a50513          	addi	a0,a0,1578 # 80013280 <kmem>
    80000c5e:	00000097          	auipc	ra,0x0
    80000c62:	14e080e7          	jalr	334(ra) # 80000dac <release>
  if(r)
    80000c66:	b7d5                	j	80000c4a <kalloc+0x42>

0000000080000c68 <initlock>:
#include <kernel/proc.h>
#include <kernel/defs.h>

void
initlock(struct spinlock *lk, char *name)
{
    80000c68:	1141                	addi	sp,sp,-16
    80000c6a:	e422                	sd	s0,8(sp)
    80000c6c:	0800                	addi	s0,sp,16
  lk->name = name;
    80000c6e:	e50c                	sd	a1,8(a0)
  lk->locked = 0;
    80000c70:	00052023          	sw	zero,0(a0)
  lk->cpu = 0;
    80000c74:	00053823          	sd	zero,16(a0)
}
    80000c78:	6422                	ld	s0,8(sp)
    80000c7a:	0141                	addi	sp,sp,16
    80000c7c:	8082                	ret

0000000080000c7e <holding>:
// Interrupts must be off.
int
holding(struct spinlock *lk)
{
  int r;
  r = (lk->locked && lk->cpu == mycpu());
    80000c7e:	411c                	lw	a5,0(a0)
    80000c80:	e399                	bnez	a5,80000c86 <holding+0x8>
    80000c82:	4501                	li	a0,0
  return r;
}
    80000c84:	8082                	ret
{
    80000c86:	1101                	addi	sp,sp,-32
    80000c88:	ec06                	sd	ra,24(sp)
    80000c8a:	e822                	sd	s0,16(sp)
    80000c8c:	e426                	sd	s1,8(sp)
    80000c8e:	1000                	addi	s0,sp,32
  r = (lk->locked && lk->cpu == mycpu());
    80000c90:	6904                	ld	s1,16(a0)
    80000c92:	00001097          	auipc	ra,0x1
    80000c96:	e36080e7          	jalr	-458(ra) # 80001ac8 <mycpu>
    80000c9a:	40a48533          	sub	a0,s1,a0
    80000c9e:	00153513          	seqz	a0,a0
}
    80000ca2:	60e2                	ld	ra,24(sp)
    80000ca4:	6442                	ld	s0,16(sp)
    80000ca6:	64a2                	ld	s1,8(sp)
    80000ca8:	6105                	addi	sp,sp,32
    80000caa:	8082                	ret

0000000080000cac <push_off>:
// it takes two pop_off()s to undo two push_off()s.  Also, if interrupts
// are initially off, then push_off, pop_off leaves them off.

void
push_off(void)
{
    80000cac:	1101                	addi	sp,sp,-32
    80000cae:	ec06                	sd	ra,24(sp)
    80000cb0:	e822                	sd	s0,16(sp)
    80000cb2:	e426                	sd	s1,8(sp)
    80000cb4:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80000cb6:	100024f3          	csrr	s1,sstatus
    80000cba:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() & ~SSTATUS_SIE);
    80000cbe:	9bf5                	andi	a5,a5,-3
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80000cc0:	10079073          	csrw	sstatus,a5
  int old = intr_get();

  intr_off();
  if(mycpu()->noff == 0)
    80000cc4:	00001097          	auipc	ra,0x1
    80000cc8:	e04080e7          	jalr	-508(ra) # 80001ac8 <mycpu>
    80000ccc:	5d3c                	lw	a5,120(a0)
    80000cce:	cf89                	beqz	a5,80000ce8 <push_off+0x3c>
    mycpu()->intena = old;
  mycpu()->noff += 1;
    80000cd0:	00001097          	auipc	ra,0x1
    80000cd4:	df8080e7          	jalr	-520(ra) # 80001ac8 <mycpu>
    80000cd8:	5d3c                	lw	a5,120(a0)
    80000cda:	2785                	addiw	a5,a5,1
    80000cdc:	dd3c                	sw	a5,120(a0)
}
    80000cde:	60e2                	ld	ra,24(sp)
    80000ce0:	6442                	ld	s0,16(sp)
    80000ce2:	64a2                	ld	s1,8(sp)
    80000ce4:	6105                	addi	sp,sp,32
    80000ce6:	8082                	ret
    mycpu()->intena = old;
    80000ce8:	00001097          	auipc	ra,0x1
    80000cec:	de0080e7          	jalr	-544(ra) # 80001ac8 <mycpu>
  return (x & SSTATUS_SIE) != 0;
    80000cf0:	8085                	srli	s1,s1,0x1
    80000cf2:	8885                	andi	s1,s1,1
    80000cf4:	dd64                	sw	s1,124(a0)
    80000cf6:	bfe9                	j	80000cd0 <push_off+0x24>

0000000080000cf8 <acquire>:
{
    80000cf8:	1101                	addi	sp,sp,-32
    80000cfa:	ec06                	sd	ra,24(sp)
    80000cfc:	e822                	sd	s0,16(sp)
    80000cfe:	e426                	sd	s1,8(sp)
    80000d00:	1000                	addi	s0,sp,32
    80000d02:	84aa                	mv	s1,a0
  push_off(); // disable interrupts to avoid deadlock.
    80000d04:	00000097          	auipc	ra,0x0
    80000d08:	fa8080e7          	jalr	-88(ra) # 80000cac <push_off>
  if(holding(lk))
    80000d0c:	8526                	mv	a0,s1
    80000d0e:	00000097          	auipc	ra,0x0
    80000d12:	f70080e7          	jalr	-144(ra) # 80000c7e <holding>
  while(__sync_lock_test_and_set(&lk->locked, 1) != 0)
    80000d16:	4705                	li	a4,1
  if(holding(lk))
    80000d18:	e115                	bnez	a0,80000d3c <acquire+0x44>
  while(__sync_lock_test_and_set(&lk->locked, 1) != 0)
    80000d1a:	87ba                	mv	a5,a4
    80000d1c:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
    80000d20:	2781                	sext.w	a5,a5
    80000d22:	ffe5                	bnez	a5,80000d1a <acquire+0x22>
  __sync_synchronize();
    80000d24:	0ff0000f          	fence
  lk->cpu = mycpu();
    80000d28:	00001097          	auipc	ra,0x1
    80000d2c:	da0080e7          	jalr	-608(ra) # 80001ac8 <mycpu>
    80000d30:	e888                	sd	a0,16(s1)
}
    80000d32:	60e2                	ld	ra,24(sp)
    80000d34:	6442                	ld	s0,16(sp)
    80000d36:	64a2                	ld	s1,8(sp)
    80000d38:	6105                	addi	sp,sp,32
    80000d3a:	8082                	ret
    panic("acquire");
    80000d3c:	00008517          	auipc	a0,0x8
    80000d40:	33450513          	addi	a0,a0,820 # 80009070 <digits+0x30>
    80000d44:	00000097          	auipc	ra,0x0
    80000d48:	91e080e7          	jalr	-1762(ra) # 80000662 <panic>

0000000080000d4c <pop_off>:

void
pop_off(void)
{
    80000d4c:	1141                	addi	sp,sp,-16
    80000d4e:	e406                	sd	ra,8(sp)
    80000d50:	e022                	sd	s0,0(sp)
    80000d52:	0800                	addi	s0,sp,16
  struct cpu *c = mycpu();
    80000d54:	00001097          	auipc	ra,0x1
    80000d58:	d74080e7          	jalr	-652(ra) # 80001ac8 <mycpu>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80000d5c:	100027f3          	csrr	a5,sstatus
  return (x & SSTATUS_SIE) != 0;
    80000d60:	8b89                	andi	a5,a5,2
  if(intr_get())
    80000d62:	e78d                	bnez	a5,80000d8c <pop_off+0x40>
    panic("pop_off - interruptible");
  if(c->noff < 1)
    80000d64:	5d3c                	lw	a5,120(a0)
    80000d66:	02f05b63          	blez	a5,80000d9c <pop_off+0x50>
    panic("pop_off");
  c->noff -= 1;
    80000d6a:	37fd                	addiw	a5,a5,-1
    80000d6c:	0007871b          	sext.w	a4,a5
    80000d70:	dd3c                	sw	a5,120(a0)
  if(c->noff == 0 && c->intena)
    80000d72:	eb09                	bnez	a4,80000d84 <pop_off+0x38>
    80000d74:	5d7c                	lw	a5,124(a0)
    80000d76:	c799                	beqz	a5,80000d84 <pop_off+0x38>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80000d78:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    80000d7c:	0027e793          	ori	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80000d80:	10079073          	csrw	sstatus,a5
    intr_on();
}
    80000d84:	60a2                	ld	ra,8(sp)
    80000d86:	6402                	ld	s0,0(sp)
    80000d88:	0141                	addi	sp,sp,16
    80000d8a:	8082                	ret
    panic("pop_off - interruptible");
    80000d8c:	00008517          	auipc	a0,0x8
    80000d90:	2ec50513          	addi	a0,a0,748 # 80009078 <digits+0x38>
    80000d94:	00000097          	auipc	ra,0x0
    80000d98:	8ce080e7          	jalr	-1842(ra) # 80000662 <panic>
    panic("pop_off");
    80000d9c:	00008517          	auipc	a0,0x8
    80000da0:	2f450513          	addi	a0,a0,756 # 80009090 <digits+0x50>
    80000da4:	00000097          	auipc	ra,0x0
    80000da8:	8be080e7          	jalr	-1858(ra) # 80000662 <panic>

0000000080000dac <release>:
{
    80000dac:	1101                	addi	sp,sp,-32
    80000dae:	ec06                	sd	ra,24(sp)
    80000db0:	e822                	sd	s0,16(sp)
    80000db2:	e426                	sd	s1,8(sp)
    80000db4:	1000                	addi	s0,sp,32
    80000db6:	84aa                	mv	s1,a0
  if(!holding(lk))
    80000db8:	00000097          	auipc	ra,0x0
    80000dbc:	ec6080e7          	jalr	-314(ra) # 80000c7e <holding>
    80000dc0:	c115                	beqz	a0,80000de4 <release+0x38>
  lk->cpu = 0;
    80000dc2:	0004b823          	sd	zero,16(s1)
  __sync_synchronize();
    80000dc6:	0ff0000f          	fence
  __sync_lock_release(&lk->locked);
    80000dca:	0f50000f          	fence	iorw,ow
    80000dce:	0804a02f          	amoswap.w	zero,zero,(s1)
  pop_off();
    80000dd2:	00000097          	auipc	ra,0x0
    80000dd6:	f7a080e7          	jalr	-134(ra) # 80000d4c <pop_off>
}
    80000dda:	60e2                	ld	ra,24(sp)
    80000ddc:	6442                	ld	s0,16(sp)
    80000dde:	64a2                	ld	s1,8(sp)
    80000de0:	6105                	addi	sp,sp,32
    80000de2:	8082                	ret
    panic("release");
    80000de4:	00008517          	auipc	a0,0x8
    80000de8:	2b450513          	addi	a0,a0,692 # 80009098 <digits+0x58>
    80000dec:	00000097          	auipc	ra,0x0
    80000df0:	876080e7          	jalr	-1930(ra) # 80000662 <panic>

0000000080000df4 <kmemset>:
#include <kernel/types.h>

void*
kmemset(void *dst, int c, uint n)
{
    80000df4:	1141                	addi	sp,sp,-16
    80000df6:	e422                	sd	s0,8(sp)
    80000df8:	0800                	addi	s0,sp,16
	char *cdst = (char *) dst;
	int i;
	for(i = 0; i < n; i++){
    80000dfa:	ca19                	beqz	a2,80000e10 <kmemset+0x1c>
    80000dfc:	87aa                	mv	a5,a0
    80000dfe:	1602                	slli	a2,a2,0x20
    80000e00:	9201                	srli	a2,a2,0x20
    80000e02:	00a60733          	add	a4,a2,a0
		cdst[i] = c;
    80000e06:	00b78023          	sb	a1,0(a5)
	for(i = 0; i < n; i++){
    80000e0a:	0785                	addi	a5,a5,1
    80000e0c:	fee79de3          	bne	a5,a4,80000e06 <kmemset+0x12>
	}
	return dst;
}
    80000e10:	6422                	ld	s0,8(sp)
    80000e12:	0141                	addi	sp,sp,16
    80000e14:	8082                	ret

0000000080000e16 <kmemcmp>:

int
kmemcmp(const void *v1, const void *v2, uint n)
{
    80000e16:	1141                	addi	sp,sp,-16
    80000e18:	e422                	sd	s0,8(sp)
    80000e1a:	0800                	addi	s0,sp,16
	const uchar *s1, *s2;

	s1 = v1;
	s2 = v2;
	while(n-- > 0){
    80000e1c:	ca05                	beqz	a2,80000e4c <kmemcmp+0x36>
    80000e1e:	fff6069b          	addiw	a3,a2,-1
    80000e22:	1682                	slli	a3,a3,0x20
    80000e24:	9281                	srli	a3,a3,0x20
    80000e26:	0685                	addi	a3,a3,1
    80000e28:	96aa                	add	a3,a3,a0
		if(*s1 != *s2)
    80000e2a:	00054783          	lbu	a5,0(a0)
    80000e2e:	0005c703          	lbu	a4,0(a1)
    80000e32:	00e79863          	bne	a5,a4,80000e42 <kmemcmp+0x2c>
			return *s1 - *s2;
		s1++, s2++;
    80000e36:	0505                	addi	a0,a0,1
    80000e38:	0585                	addi	a1,a1,1
	while(n-- > 0){
    80000e3a:	fed518e3          	bne	a0,a3,80000e2a <kmemcmp+0x14>
	}

	return 0;
    80000e3e:	4501                	li	a0,0
    80000e40:	a019                	j	80000e46 <kmemcmp+0x30>
			return *s1 - *s2;
    80000e42:	40e7853b          	subw	a0,a5,a4
}
    80000e46:	6422                	ld	s0,8(sp)
    80000e48:	0141                	addi	sp,sp,16
    80000e4a:	8082                	ret
	return 0;
    80000e4c:	4501                	li	a0,0
    80000e4e:	bfe5                	j	80000e46 <kmemcmp+0x30>

0000000080000e50 <kmemmove>:

void*
kmemmove(void *dst, const void *src, uint n)
{
    80000e50:	1141                	addi	sp,sp,-16
    80000e52:	e422                	sd	s0,8(sp)
    80000e54:	0800                	addi	s0,sp,16
	const char *s;
	char *d;

	if(n == 0)
    80000e56:	c205                	beqz	a2,80000e76 <kmemmove+0x26>
		return dst;
	
	s = src;
	d = dst;
	if(s < d && s + n > d){
    80000e58:	02a5e263          	bltu	a1,a0,80000e7c <kmemmove+0x2c>
		s += n;
		d += n;
		while(n-- > 0)
			*--d = *--s;
	} else
		while(n-- > 0)
    80000e5c:	1602                	slli	a2,a2,0x20
    80000e5e:	9201                	srli	a2,a2,0x20
    80000e60:	00c587b3          	add	a5,a1,a2
{
    80000e64:	872a                	mv	a4,a0
			*d++ = *s++;
    80000e66:	0585                	addi	a1,a1,1
    80000e68:	0705                	addi	a4,a4,1
    80000e6a:	fff5c683          	lbu	a3,-1(a1)
    80000e6e:	fed70fa3          	sb	a3,-1(a4) # ffffffffffffefff <end+0xffffffff7ffd4c3f>
		while(n-- > 0)
    80000e72:	fef59ae3          	bne	a1,a5,80000e66 <kmemmove+0x16>

	return dst;
}
    80000e76:	6422                	ld	s0,8(sp)
    80000e78:	0141                	addi	sp,sp,16
    80000e7a:	8082                	ret
	if(s < d && s + n > d){
    80000e7c:	02061693          	slli	a3,a2,0x20
    80000e80:	9281                	srli	a3,a3,0x20
    80000e82:	00d58733          	add	a4,a1,a3
    80000e86:	fce57be3          	bgeu	a0,a4,80000e5c <kmemmove+0xc>
		d += n;
    80000e8a:	96aa                	add	a3,a3,a0
		while(n-- > 0)
    80000e8c:	fff6079b          	addiw	a5,a2,-1
    80000e90:	1782                	slli	a5,a5,0x20
    80000e92:	9381                	srli	a5,a5,0x20
    80000e94:	fff7c793          	not	a5,a5
    80000e98:	97ba                	add	a5,a5,a4
			*--d = *--s;
    80000e9a:	177d                	addi	a4,a4,-1
    80000e9c:	16fd                	addi	a3,a3,-1
    80000e9e:	00074603          	lbu	a2,0(a4)
    80000ea2:	00c68023          	sb	a2,0(a3)
		while(n-- > 0)
    80000ea6:	fee79ae3          	bne	a5,a4,80000e9a <kmemmove+0x4a>
    80000eaa:	b7f1                	j	80000e76 <kmemmove+0x26>

0000000080000eac <kmemcpy>:

// memcpy exists to placate GCC.	Use memmove.
void*
kmemcpy(void *dst, const void *src, uint n)
{
    80000eac:	1141                	addi	sp,sp,-16
    80000eae:	e406                	sd	ra,8(sp)
    80000eb0:	e022                	sd	s0,0(sp)
    80000eb2:	0800                	addi	s0,sp,16
	return kmemmove(dst, src, n);
    80000eb4:	00000097          	auipc	ra,0x0
    80000eb8:	f9c080e7          	jalr	-100(ra) # 80000e50 <kmemmove>
}
    80000ebc:	60a2                	ld	ra,8(sp)
    80000ebe:	6402                	ld	s0,0(sp)
    80000ec0:	0141                	addi	sp,sp,16
    80000ec2:	8082                	ret

0000000080000ec4 <kstrncmp>:

int
kstrncmp(const char *p, const char *q, uint n)
{
    80000ec4:	1141                	addi	sp,sp,-16
    80000ec6:	e422                	sd	s0,8(sp)
    80000ec8:	0800                	addi	s0,sp,16
	while(n > 0 && *p && *p == *q)
    80000eca:	ce11                	beqz	a2,80000ee6 <kstrncmp+0x22>
    80000ecc:	00054783          	lbu	a5,0(a0)
    80000ed0:	cf89                	beqz	a5,80000eea <kstrncmp+0x26>
    80000ed2:	0005c703          	lbu	a4,0(a1)
    80000ed6:	00f71a63          	bne	a4,a5,80000eea <kstrncmp+0x26>
		n--, p++, q++;
    80000eda:	367d                	addiw	a2,a2,-1
    80000edc:	0505                	addi	a0,a0,1
    80000ede:	0585                	addi	a1,a1,1
	while(n > 0 && *p && *p == *q)
    80000ee0:	f675                	bnez	a2,80000ecc <kstrncmp+0x8>
	if(n == 0)
		return 0;
    80000ee2:	4501                	li	a0,0
    80000ee4:	a809                	j	80000ef6 <kstrncmp+0x32>
    80000ee6:	4501                	li	a0,0
    80000ee8:	a039                	j	80000ef6 <kstrncmp+0x32>
	if(n == 0)
    80000eea:	ca09                	beqz	a2,80000efc <kstrncmp+0x38>
	return (uchar)*p - (uchar)*q;
    80000eec:	00054503          	lbu	a0,0(a0)
    80000ef0:	0005c783          	lbu	a5,0(a1)
    80000ef4:	9d1d                	subw	a0,a0,a5
}
    80000ef6:	6422                	ld	s0,8(sp)
    80000ef8:	0141                	addi	sp,sp,16
    80000efa:	8082                	ret
		return 0;
    80000efc:	4501                	li	a0,0
    80000efe:	bfe5                	j	80000ef6 <kstrncmp+0x32>

0000000080000f00 <kstrncpy>:

char*
kstrncpy(char *s, const char *t, int n)
{
    80000f00:	1141                	addi	sp,sp,-16
    80000f02:	e422                	sd	s0,8(sp)
    80000f04:	0800                	addi	s0,sp,16
	char *os;

	os = s;
	while(n-- > 0 && (*s++ = *t++) != 0)
    80000f06:	872a                	mv	a4,a0
    80000f08:	8832                	mv	a6,a2
    80000f0a:	367d                	addiw	a2,a2,-1
    80000f0c:	01005963          	blez	a6,80000f1e <kstrncpy+0x1e>
    80000f10:	0705                	addi	a4,a4,1
    80000f12:	0005c783          	lbu	a5,0(a1)
    80000f16:	fef70fa3          	sb	a5,-1(a4)
    80000f1a:	0585                	addi	a1,a1,1
    80000f1c:	f7f5                	bnez	a5,80000f08 <kstrncpy+0x8>
		;
	while(n-- > 0)
    80000f1e:	86ba                	mv	a3,a4
    80000f20:	00c05c63          	blez	a2,80000f38 <kstrncpy+0x38>
		*s++ = 0;
    80000f24:	0685                	addi	a3,a3,1
    80000f26:	fe068fa3          	sb	zero,-1(a3)
	while(n-- > 0)
    80000f2a:	40d707bb          	subw	a5,a4,a3
    80000f2e:	37fd                	addiw	a5,a5,-1
    80000f30:	010787bb          	addw	a5,a5,a6
    80000f34:	fef048e3          	bgtz	a5,80000f24 <kstrncpy+0x24>
	return os;
}
    80000f38:	6422                	ld	s0,8(sp)
    80000f3a:	0141                	addi	sp,sp,16
    80000f3c:	8082                	ret

0000000080000f3e <ksafestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
ksafestrcpy(char *s, const char *t, int n)
{
    80000f3e:	1141                	addi	sp,sp,-16
    80000f40:	e422                	sd	s0,8(sp)
    80000f42:	0800                	addi	s0,sp,16
	char *os;

	os = s;
	if(n <= 0)
    80000f44:	02c05363          	blez	a2,80000f6a <ksafestrcpy+0x2c>
    80000f48:	fff6069b          	addiw	a3,a2,-1
    80000f4c:	1682                	slli	a3,a3,0x20
    80000f4e:	9281                	srli	a3,a3,0x20
    80000f50:	96ae                	add	a3,a3,a1
    80000f52:	87aa                	mv	a5,a0
		return os;
	while(--n > 0 && (*s++ = *t++) != 0)
    80000f54:	00d58963          	beq	a1,a3,80000f66 <ksafestrcpy+0x28>
    80000f58:	0585                	addi	a1,a1,1
    80000f5a:	0785                	addi	a5,a5,1
    80000f5c:	fff5c703          	lbu	a4,-1(a1)
    80000f60:	fee78fa3          	sb	a4,-1(a5)
    80000f64:	fb65                	bnez	a4,80000f54 <ksafestrcpy+0x16>
		;
	*s = 0;
    80000f66:	00078023          	sb	zero,0(a5)
	return os;
}
    80000f6a:	6422                	ld	s0,8(sp)
    80000f6c:	0141                	addi	sp,sp,16
    80000f6e:	8082                	ret

0000000080000f70 <kstrlen>:

int
kstrlen(const char *s)
{
    80000f70:	1141                	addi	sp,sp,-16
    80000f72:	e422                	sd	s0,8(sp)
    80000f74:	0800                	addi	s0,sp,16
	int n;

	for(n = 0; s[n]; n++)
    80000f76:	00054783          	lbu	a5,0(a0)
    80000f7a:	cf91                	beqz	a5,80000f96 <kstrlen+0x26>
    80000f7c:	0505                	addi	a0,a0,1
    80000f7e:	87aa                	mv	a5,a0
    80000f80:	4685                	li	a3,1
    80000f82:	9e89                	subw	a3,a3,a0
    80000f84:	00f6853b          	addw	a0,a3,a5
    80000f88:	0785                	addi	a5,a5,1
    80000f8a:	fff7c703          	lbu	a4,-1(a5)
    80000f8e:	fb7d                	bnez	a4,80000f84 <kstrlen+0x14>
		;
	return n;
}
    80000f90:	6422                	ld	s0,8(sp)
    80000f92:	0141                	addi	sp,sp,16
    80000f94:	8082                	ret
	for(n = 0; s[n]; n++)
    80000f96:	4501                	li	a0,0
    80000f98:	bfe5                	j	80000f90 <kstrlen+0x20>

0000000080000f9a <kmemscan>:

void * kmemscan(void * addr, int c, int size)
{
    80000f9a:	1141                	addi	sp,sp,-16
    80000f9c:	e422                	sd	s0,8(sp)
    80000f9e:	0800                	addi	s0,sp,16
	unsigned char *p = addr;

	while(size) {
    80000fa0:	ce09                	beqz	a2,80000fba <kmemscan+0x20>
    80000fa2:	1602                	slli	a2,a2,0x20
    80000fa4:	9201                	srli	a2,a2,0x20
    80000fa6:	00c50733          	add	a4,a0,a2
		if(*p == c)
    80000faa:	00054783          	lbu	a5,0(a0)
    80000fae:	00b78663          	beq	a5,a1,80000fba <kmemscan+0x20>
			return (void *)p;

		p++;
    80000fb2:	0505                	addi	a0,a0,1
	while(size) {
    80000fb4:	fee51be3          	bne	a0,a4,80000faa <kmemscan+0x10>
		p++;
    80000fb8:	853a                	mv	a0,a4
		size--;
	}

	return (void *)p;
    80000fba:	6422                	ld	s0,8(sp)
    80000fbc:	0141                	addi	sp,sp,16
    80000fbe:	8082                	ret

0000000080000fc0 <main>:
volatile static int started = 0;

// start() jumps here in supervisor mode on all CPUs.
void
main()
{
    80000fc0:	1141                	addi	sp,sp,-16
    80000fc2:	e406                	sd	ra,8(sp)
    80000fc4:	e022                	sd	s0,0(sp)
    80000fc6:	0800                	addi	s0,sp,16
	if(cpuid() == 0) { 
    80000fc8:	00001097          	auipc	ra,0x1
    80000fcc:	af0080e7          	jalr	-1296(ra) # 80001ab8 <cpuid>
		virtio_disk_init(); // emulated hard disk
		userinit();			// first user process
		__sync_synchronize();
		started = 1;
	} else {
		while(started == 0)
    80000fd0:	0000a717          	auipc	a4,0xa
    80000fd4:	04870713          	addi	a4,a4,72 # 8000b018 <started>
	if(cpuid() == 0) { 
    80000fd8:	c139                	beqz	a0,8000101e <main+0x5e>
		while(started == 0)
    80000fda:	431c                	lw	a5,0(a4)
    80000fdc:	2781                	sext.w	a5,a5
    80000fde:	dff5                	beqz	a5,80000fda <main+0x1a>
			;
		__sync_synchronize();
    80000fe0:	0ff0000f          	fence
		kprintf("hart %d starting\n", cpuid());
    80000fe4:	00001097          	auipc	ra,0x1
    80000fe8:	ad4080e7          	jalr	-1324(ra) # 80001ab8 <cpuid>
    80000fec:	85aa                	mv	a1,a0
    80000fee:	00008517          	auipc	a0,0x8
    80000ff2:	0ca50513          	addi	a0,a0,202 # 800090b8 <digits+0x78>
    80000ff6:	fffff097          	auipc	ra,0xfffff
    80000ffa:	6b6080e7          	jalr	1718(ra) # 800006ac <kprintf>
		kvminithart();		// turn on paging
    80000ffe:	00000097          	auipc	ra,0x0
    80001002:	0d8080e7          	jalr	216(ra) # 800010d6 <kvminithart>
		trapinithart();	 // install kernel trap vector
    80001006:	00001097          	auipc	ra,0x1
    8000100a:	636080e7          	jalr	1590(ra) # 8000263c <trapinithart>
		plicinithart();	 // ask PLIC for device interrupts
    8000100e:	00004097          	auipc	ra,0x4
    80001012:	036080e7          	jalr	54(ra) # 80005044 <plicinithart>
	}

	scheduler();				
    80001016:	00001097          	auipc	ra,0x1
    8000101a:	fea080e7          	jalr	-22(ra) # 80002000 <scheduler>
		consoleinit();
    8000101e:	fffff097          	auipc	ra,0xfffff
    80001022:	554080e7          	jalr	1364(ra) # 80000572 <consoleinit>
		printfinit();
    80001026:	00000097          	auipc	ra,0x0
    8000102a:	866080e7          	jalr	-1946(ra) # 8000088c <printfinit>
		kprintf("\n");
    8000102e:	00008517          	auipc	a0,0x8
    80001032:	09a50513          	addi	a0,a0,154 # 800090c8 <digits+0x88>
    80001036:	fffff097          	auipc	ra,0xfffff
    8000103a:	676080e7          	jalr	1654(ra) # 800006ac <kprintf>
		kprintf("xv6 kernel is booting\n");
    8000103e:	00008517          	auipc	a0,0x8
    80001042:	06250513          	addi	a0,a0,98 # 800090a0 <digits+0x60>
    80001046:	fffff097          	auipc	ra,0xfffff
    8000104a:	666080e7          	jalr	1638(ra) # 800006ac <kprintf>
		kprintf("\n");
    8000104e:	00008517          	auipc	a0,0x8
    80001052:	07a50513          	addi	a0,a0,122 # 800090c8 <digits+0x88>
    80001056:	fffff097          	auipc	ra,0xfffff
    8000105a:	656080e7          	jalr	1622(ra) # 800006ac <kprintf>
		kinit();				 // physical page allocator
    8000105e:	00000097          	auipc	ra,0x0
    80001062:	b6e080e7          	jalr	-1170(ra) # 80000bcc <kinit>
		kvminit();			 // create kernel page table
    80001066:	00000097          	auipc	ra,0x0
    8000106a:	322080e7          	jalr	802(ra) # 80001388 <kvminit>
		kvminithart();	 // turn on paging
    8000106e:	00000097          	auipc	ra,0x0
    80001072:	068080e7          	jalr	104(ra) # 800010d6 <kvminithart>
		procinit();			// process table
    80001076:	00001097          	auipc	ra,0x1
    8000107a:	992080e7          	jalr	-1646(ra) # 80001a08 <procinit>
		trapinit();			// trap vectors
    8000107e:	00001097          	auipc	ra,0x1
    80001082:	596080e7          	jalr	1430(ra) # 80002614 <trapinit>
		trapinithart();	// install kernel trap vector
    80001086:	00001097          	auipc	ra,0x1
    8000108a:	5b6080e7          	jalr	1462(ra) # 8000263c <trapinithart>
		plicinit();			// set up interrupt controller
    8000108e:	00004097          	auipc	ra,0x4
    80001092:	fa0080e7          	jalr	-96(ra) # 8000502e <plicinit>
		plicinithart();	// ask PLIC for device interrupts
    80001096:	00004097          	auipc	ra,0x4
    8000109a:	fae080e7          	jalr	-82(ra) # 80005044 <plicinithart>
		binit();				 // buffer cache
    8000109e:	00002097          	auipc	ra,0x2
    800010a2:	ce0080e7          	jalr	-800(ra) # 80002d7e <binit>
		iinit();				 // inode table
    800010a6:	00002097          	auipc	ra,0x2
    800010aa:	27c080e7          	jalr	636(ra) # 80003322 <iinit>
		fileinit();			// file table
    800010ae:	00003097          	auipc	ra,0x3
    800010b2:	8c4080e7          	jalr	-1852(ra) # 80003972 <fileinit>
		virtio_disk_init(); // emulated hard disk
    800010b6:	00004097          	auipc	ra,0x4
    800010ba:	0ae080e7          	jalr	174(ra) # 80005164 <virtio_disk_init>
		userinit();			// first user process
    800010be:	00001097          	auipc	ra,0x1
    800010c2:	d1e080e7          	jalr	-738(ra) # 80001ddc <userinit>
		__sync_synchronize();
    800010c6:	0ff0000f          	fence
		started = 1;
    800010ca:	4785                	li	a5,1
    800010cc:	0000a717          	auipc	a4,0xa
    800010d0:	f4f72623          	sw	a5,-180(a4) # 8000b018 <started>
    800010d4:	b789                	j	80001016 <main+0x56>

00000000800010d6 <kvminithart>:

// Switch h/w page table register to the kernel's page table,
// and enable paging.
void
kvminithart()
{
    800010d6:	1141                	addi	sp,sp,-16
    800010d8:	e422                	sd	s0,8(sp)
    800010da:	0800                	addi	s0,sp,16
  w_satp(MAKE_SATP(kernel_pagetable));
    800010dc:	0000a797          	auipc	a5,0xa
    800010e0:	f447b783          	ld	a5,-188(a5) # 8000b020 <kernel_pagetable>
    800010e4:	83b1                	srli	a5,a5,0xc
    800010e6:	577d                	li	a4,-1
    800010e8:	177e                	slli	a4,a4,0x3f
    800010ea:	8fd9                	or	a5,a5,a4
  asm volatile("csrw satp, %0" : : "r" (x));
    800010ec:	18079073          	csrw	satp,a5
// flush the TLB.
static inline void
sfence_vma()
{
  // the zero, zero means flush all TLB entries.
  asm volatile("sfence.vma zero, zero");
    800010f0:	12000073          	sfence.vma
  sfence_vma();
}
    800010f4:	6422                	ld	s0,8(sp)
    800010f6:	0141                	addi	sp,sp,16
    800010f8:	8082                	ret

00000000800010fa <walk>:
//   21..29 -- 9 bits of level-1 index.
//   12..20 -- 9 bits of level-0 index.
//    0..11 -- 12 bits of byte offset within the page.
pte_t *
walk(pagetable_t pagetable, uint64 va, int alloc)
{
    800010fa:	7139                	addi	sp,sp,-64
    800010fc:	fc06                	sd	ra,56(sp)
    800010fe:	f822                	sd	s0,48(sp)
    80001100:	f426                	sd	s1,40(sp)
    80001102:	f04a                	sd	s2,32(sp)
    80001104:	ec4e                	sd	s3,24(sp)
    80001106:	e852                	sd	s4,16(sp)
    80001108:	e456                	sd	s5,8(sp)
    8000110a:	e05a                	sd	s6,0(sp)
    8000110c:	0080                	addi	s0,sp,64
    8000110e:	84aa                	mv	s1,a0
    80001110:	89ae                	mv	s3,a1
    80001112:	8ab2                	mv	s5,a2
  if(va >= MAXVA)
    80001114:	57fd                	li	a5,-1
    80001116:	83e9                	srli	a5,a5,0x1a
    80001118:	4a79                	li	s4,30
    panic("walk");

  for(int level = 2; level > 0; level--) {
    8000111a:	4b31                	li	s6,12
  if(va >= MAXVA)
    8000111c:	04b7f263          	bgeu	a5,a1,80001160 <walk+0x66>
    panic("walk");
    80001120:	00008517          	auipc	a0,0x8
    80001124:	fb050513          	addi	a0,a0,-80 # 800090d0 <digits+0x90>
    80001128:	fffff097          	auipc	ra,0xfffff
    8000112c:	53a080e7          	jalr	1338(ra) # 80000662 <panic>
    pte_t *pte = &pagetable[PX(level, va)];
    if(*pte & PTE_V) {
      pagetable = (pagetable_t)PTE2PA(*pte);
    } else {
      if(!alloc || (pagetable = (pde_t*)kalloc()) == 0)
    80001130:	060a8663          	beqz	s5,8000119c <walk+0xa2>
    80001134:	00000097          	auipc	ra,0x0
    80001138:	ad4080e7          	jalr	-1324(ra) # 80000c08 <kalloc>
    8000113c:	84aa                	mv	s1,a0
    8000113e:	c529                	beqz	a0,80001188 <walk+0x8e>
        return 0;
      kmemset(pagetable, 0, PGSIZE);
    80001140:	6605                	lui	a2,0x1
    80001142:	4581                	li	a1,0
    80001144:	00000097          	auipc	ra,0x0
    80001148:	cb0080e7          	jalr	-848(ra) # 80000df4 <kmemset>
      *pte = PA2PTE(pagetable) | PTE_V;
    8000114c:	00c4d793          	srli	a5,s1,0xc
    80001150:	07aa                	slli	a5,a5,0xa
    80001152:	0017e793          	ori	a5,a5,1
    80001156:	00f93023          	sd	a5,0(s2)
  for(int level = 2; level > 0; level--) {
    8000115a:	3a5d                	addiw	s4,s4,-9
    8000115c:	036a0063          	beq	s4,s6,8000117c <walk+0x82>
    pte_t *pte = &pagetable[PX(level, va)];
    80001160:	0149d933          	srl	s2,s3,s4
    80001164:	1ff97913          	andi	s2,s2,511
    80001168:	090e                	slli	s2,s2,0x3
    8000116a:	9926                	add	s2,s2,s1
    if(*pte & PTE_V) {
    8000116c:	00093483          	ld	s1,0(s2)
    80001170:	0014f793          	andi	a5,s1,1
    80001174:	dfd5                	beqz	a5,80001130 <walk+0x36>
      pagetable = (pagetable_t)PTE2PA(*pte);
    80001176:	80a9                	srli	s1,s1,0xa
    80001178:	04b2                	slli	s1,s1,0xc
    8000117a:	b7c5                	j	8000115a <walk+0x60>
    }
  }
  return &pagetable[PX(0, va)];
    8000117c:	00c9d513          	srli	a0,s3,0xc
    80001180:	1ff57513          	andi	a0,a0,511
    80001184:	050e                	slli	a0,a0,0x3
    80001186:	9526                	add	a0,a0,s1
}
    80001188:	70e2                	ld	ra,56(sp)
    8000118a:	7442                	ld	s0,48(sp)
    8000118c:	74a2                	ld	s1,40(sp)
    8000118e:	7902                	ld	s2,32(sp)
    80001190:	69e2                	ld	s3,24(sp)
    80001192:	6a42                	ld	s4,16(sp)
    80001194:	6aa2                	ld	s5,8(sp)
    80001196:	6b02                	ld	s6,0(sp)
    80001198:	6121                	addi	sp,sp,64
    8000119a:	8082                	ret
        return 0;
    8000119c:	4501                	li	a0,0
    8000119e:	b7ed                	j	80001188 <walk+0x8e>

00000000800011a0 <walkaddr>:
walkaddr(pagetable_t pagetable, uint64 va)
{
  pte_t *pte;
  uint64 pa;

  if(va >= MAXVA)
    800011a0:	57fd                	li	a5,-1
    800011a2:	83e9                	srli	a5,a5,0x1a
    800011a4:	00b7f463          	bgeu	a5,a1,800011ac <walkaddr+0xc>
    return 0;
    800011a8:	4501                	li	a0,0
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  pa = PTE2PA(*pte);
  return pa;
}
    800011aa:	8082                	ret
{
    800011ac:	1141                	addi	sp,sp,-16
    800011ae:	e406                	sd	ra,8(sp)
    800011b0:	e022                	sd	s0,0(sp)
    800011b2:	0800                	addi	s0,sp,16
  pte = walk(pagetable, va, 0);
    800011b4:	4601                	li	a2,0
    800011b6:	00000097          	auipc	ra,0x0
    800011ba:	f44080e7          	jalr	-188(ra) # 800010fa <walk>
  if(pte == 0)
    800011be:	c105                	beqz	a0,800011de <walkaddr+0x3e>
  if((*pte & PTE_V) == 0)
    800011c0:	611c                	ld	a5,0(a0)
  if((*pte & PTE_U) == 0)
    800011c2:	0117f693          	andi	a3,a5,17
    800011c6:	4745                	li	a4,17
    return 0;
    800011c8:	4501                	li	a0,0
  if((*pte & PTE_U) == 0)
    800011ca:	00e68663          	beq	a3,a4,800011d6 <walkaddr+0x36>
}
    800011ce:	60a2                	ld	ra,8(sp)
    800011d0:	6402                	ld	s0,0(sp)
    800011d2:	0141                	addi	sp,sp,16
    800011d4:	8082                	ret
  pa = PTE2PA(*pte);
    800011d6:	83a9                	srli	a5,a5,0xa
    800011d8:	00c79513          	slli	a0,a5,0xc
  return pa;
    800011dc:	bfcd                	j	800011ce <walkaddr+0x2e>
    return 0;
    800011de:	4501                	li	a0,0
    800011e0:	b7fd                	j	800011ce <walkaddr+0x2e>

00000000800011e2 <mappages>:
// physical addresses starting at pa. va and size might not
// be page-aligned. Returns 0 on success, -1 if walk() couldn't
// allocate a needed page-table page.
int
mappages(pagetable_t pagetable, uint64 va, uint64 size, uint64 pa, int perm)
{
    800011e2:	715d                	addi	sp,sp,-80
    800011e4:	e486                	sd	ra,72(sp)
    800011e6:	e0a2                	sd	s0,64(sp)
    800011e8:	fc26                	sd	s1,56(sp)
    800011ea:	f84a                	sd	s2,48(sp)
    800011ec:	f44e                	sd	s3,40(sp)
    800011ee:	f052                	sd	s4,32(sp)
    800011f0:	ec56                	sd	s5,24(sp)
    800011f2:	e85a                	sd	s6,16(sp)
    800011f4:	e45e                	sd	s7,8(sp)
    800011f6:	0880                	addi	s0,sp,80
  uint64 a, last;
  pte_t *pte;

  if(size == 0)
    800011f8:	c639                	beqz	a2,80001246 <mappages+0x64>
    800011fa:	8aaa                	mv	s5,a0
    800011fc:	8b3a                	mv	s6,a4
    panic("mappages: size");
  
  a = PGROUNDDOWN(va);
    800011fe:	777d                	lui	a4,0xfffff
    80001200:	00e5f7b3          	and	a5,a1,a4
  last = PGROUNDDOWN(va + size - 1);
    80001204:	fff58993          	addi	s3,a1,-1
    80001208:	99b2                	add	s3,s3,a2
    8000120a:	00e9f9b3          	and	s3,s3,a4
  a = PGROUNDDOWN(va);
    8000120e:	893e                	mv	s2,a5
    80001210:	40f68a33          	sub	s4,a3,a5
    if(*pte & PTE_V)
      panic("mappages: remap");
    *pte = PA2PTE(pa) | perm | PTE_V;
    if(a == last)
      break;
    a += PGSIZE;
    80001214:	6b85                	lui	s7,0x1
    80001216:	012a04b3          	add	s1,s4,s2
    if((pte = walk(pagetable, a, 1)) == 0)
    8000121a:	4605                	li	a2,1
    8000121c:	85ca                	mv	a1,s2
    8000121e:	8556                	mv	a0,s5
    80001220:	00000097          	auipc	ra,0x0
    80001224:	eda080e7          	jalr	-294(ra) # 800010fa <walk>
    80001228:	cd1d                	beqz	a0,80001266 <mappages+0x84>
    if(*pte & PTE_V)
    8000122a:	611c                	ld	a5,0(a0)
    8000122c:	8b85                	andi	a5,a5,1
    8000122e:	e785                	bnez	a5,80001256 <mappages+0x74>
    *pte = PA2PTE(pa) | perm | PTE_V;
    80001230:	80b1                	srli	s1,s1,0xc
    80001232:	04aa                	slli	s1,s1,0xa
    80001234:	0164e4b3          	or	s1,s1,s6
    80001238:	0014e493          	ori	s1,s1,1
    8000123c:	e104                	sd	s1,0(a0)
    if(a == last)
    8000123e:	05390063          	beq	s2,s3,8000127e <mappages+0x9c>
    a += PGSIZE;
    80001242:	995e                	add	s2,s2,s7
    if((pte = walk(pagetable, a, 1)) == 0)
    80001244:	bfc9                	j	80001216 <mappages+0x34>
    panic("mappages: size");
    80001246:	00008517          	auipc	a0,0x8
    8000124a:	e9250513          	addi	a0,a0,-366 # 800090d8 <digits+0x98>
    8000124e:	fffff097          	auipc	ra,0xfffff
    80001252:	414080e7          	jalr	1044(ra) # 80000662 <panic>
      panic("mappages: remap");
    80001256:	00008517          	auipc	a0,0x8
    8000125a:	e9250513          	addi	a0,a0,-366 # 800090e8 <digits+0xa8>
    8000125e:	fffff097          	auipc	ra,0xfffff
    80001262:	404080e7          	jalr	1028(ra) # 80000662 <panic>
      return -1;
    80001266:	557d                	li	a0,-1
    pa += PGSIZE;
  }
  return 0;
}
    80001268:	60a6                	ld	ra,72(sp)
    8000126a:	6406                	ld	s0,64(sp)
    8000126c:	74e2                	ld	s1,56(sp)
    8000126e:	7942                	ld	s2,48(sp)
    80001270:	79a2                	ld	s3,40(sp)
    80001272:	7a02                	ld	s4,32(sp)
    80001274:	6ae2                	ld	s5,24(sp)
    80001276:	6b42                	ld	s6,16(sp)
    80001278:	6ba2                	ld	s7,8(sp)
    8000127a:	6161                	addi	sp,sp,80
    8000127c:	8082                	ret
  return 0;
    8000127e:	4501                	li	a0,0
    80001280:	b7e5                	j	80001268 <mappages+0x86>

0000000080001282 <kvmmap>:
{
    80001282:	1141                	addi	sp,sp,-16
    80001284:	e406                	sd	ra,8(sp)
    80001286:	e022                	sd	s0,0(sp)
    80001288:	0800                	addi	s0,sp,16
    8000128a:	87b6                	mv	a5,a3
  if(mappages(kpgtbl, va, sz, pa, perm) != 0)
    8000128c:	86b2                	mv	a3,a2
    8000128e:	863e                	mv	a2,a5
    80001290:	00000097          	auipc	ra,0x0
    80001294:	f52080e7          	jalr	-174(ra) # 800011e2 <mappages>
    80001298:	e509                	bnez	a0,800012a2 <kvmmap+0x20>
}
    8000129a:	60a2                	ld	ra,8(sp)
    8000129c:	6402                	ld	s0,0(sp)
    8000129e:	0141                	addi	sp,sp,16
    800012a0:	8082                	ret
    panic("kvmmap");
    800012a2:	00008517          	auipc	a0,0x8
    800012a6:	e5650513          	addi	a0,a0,-426 # 800090f8 <digits+0xb8>
    800012aa:	fffff097          	auipc	ra,0xfffff
    800012ae:	3b8080e7          	jalr	952(ra) # 80000662 <panic>

00000000800012b2 <kvmmake>:
{
    800012b2:	1101                	addi	sp,sp,-32
    800012b4:	ec06                	sd	ra,24(sp)
    800012b6:	e822                	sd	s0,16(sp)
    800012b8:	e426                	sd	s1,8(sp)
    800012ba:	e04a                	sd	s2,0(sp)
    800012bc:	1000                	addi	s0,sp,32
  kpgtbl = (pagetable_t) kalloc();
    800012be:	00000097          	auipc	ra,0x0
    800012c2:	94a080e7          	jalr	-1718(ra) # 80000c08 <kalloc>
    800012c6:	84aa                	mv	s1,a0
  kmemset(kpgtbl, 0, PGSIZE);
    800012c8:	6605                	lui	a2,0x1
    800012ca:	4581                	li	a1,0
    800012cc:	00000097          	auipc	ra,0x0
    800012d0:	b28080e7          	jalr	-1240(ra) # 80000df4 <kmemset>
  kvmmap(kpgtbl, UART0, UART0, PGSIZE, PTE_R | PTE_W);
    800012d4:	4719                	li	a4,6
    800012d6:	6685                	lui	a3,0x1
    800012d8:	10000637          	lui	a2,0x10000
    800012dc:	100005b7          	lui	a1,0x10000
    800012e0:	8526                	mv	a0,s1
    800012e2:	00000097          	auipc	ra,0x0
    800012e6:	fa0080e7          	jalr	-96(ra) # 80001282 <kvmmap>
  kvmmap(kpgtbl, VIRTIO0, VIRTIO0, PGSIZE, PTE_R | PTE_W);
    800012ea:	4719                	li	a4,6
    800012ec:	6685                	lui	a3,0x1
    800012ee:	10001637          	lui	a2,0x10001
    800012f2:	100015b7          	lui	a1,0x10001
    800012f6:	8526                	mv	a0,s1
    800012f8:	00000097          	auipc	ra,0x0
    800012fc:	f8a080e7          	jalr	-118(ra) # 80001282 <kvmmap>
  kvmmap(kpgtbl, PLIC, PLIC, 0x400000, PTE_R | PTE_W);
    80001300:	4719                	li	a4,6
    80001302:	004006b7          	lui	a3,0x400
    80001306:	0c000637          	lui	a2,0xc000
    8000130a:	0c0005b7          	lui	a1,0xc000
    8000130e:	8526                	mv	a0,s1
    80001310:	00000097          	auipc	ra,0x0
    80001314:	f72080e7          	jalr	-142(ra) # 80001282 <kvmmap>
  kvmmap(kpgtbl, KERNBASE, KERNBASE, (uint64)etext-KERNBASE, PTE_R | PTE_X);
    80001318:	00008917          	auipc	s2,0x8
    8000131c:	ce890913          	addi	s2,s2,-792 # 80009000 <etext>
    80001320:	4729                	li	a4,10
    80001322:	80008697          	auipc	a3,0x80008
    80001326:	cde68693          	addi	a3,a3,-802 # 9000 <_entry-0x7fff7000>
    8000132a:	4605                	li	a2,1
    8000132c:	067e                	slli	a2,a2,0x1f
    8000132e:	85b2                	mv	a1,a2
    80001330:	8526                	mv	a0,s1
    80001332:	00000097          	auipc	ra,0x0
    80001336:	f50080e7          	jalr	-176(ra) # 80001282 <kvmmap>
  kvmmap(kpgtbl, (uint64)etext, (uint64)etext, PHYSTOP-(uint64)etext, PTE_R | PTE_W);
    8000133a:	4719                	li	a4,6
    8000133c:	46c5                	li	a3,17
    8000133e:	06ee                	slli	a3,a3,0x1b
    80001340:	412686b3          	sub	a3,a3,s2
    80001344:	864a                	mv	a2,s2
    80001346:	85ca                	mv	a1,s2
    80001348:	8526                	mv	a0,s1
    8000134a:	00000097          	auipc	ra,0x0
    8000134e:	f38080e7          	jalr	-200(ra) # 80001282 <kvmmap>
  kvmmap(kpgtbl, TRAMPOLINE, (uint64)trampoline, PGSIZE, PTE_R | PTE_X);
    80001352:	4729                	li	a4,10
    80001354:	6685                	lui	a3,0x1
    80001356:	00007617          	auipc	a2,0x7
    8000135a:	caa60613          	addi	a2,a2,-854 # 80008000 <_trampoline>
    8000135e:	040005b7          	lui	a1,0x4000
    80001362:	15fd                	addi	a1,a1,-1
    80001364:	05b2                	slli	a1,a1,0xc
    80001366:	8526                	mv	a0,s1
    80001368:	00000097          	auipc	ra,0x0
    8000136c:	f1a080e7          	jalr	-230(ra) # 80001282 <kvmmap>
  proc_mapstacks(kpgtbl);
    80001370:	8526                	mv	a0,s1
    80001372:	00000097          	auipc	ra,0x0
    80001376:	600080e7          	jalr	1536(ra) # 80001972 <proc_mapstacks>
}
    8000137a:	8526                	mv	a0,s1
    8000137c:	60e2                	ld	ra,24(sp)
    8000137e:	6442                	ld	s0,16(sp)
    80001380:	64a2                	ld	s1,8(sp)
    80001382:	6902                	ld	s2,0(sp)
    80001384:	6105                	addi	sp,sp,32
    80001386:	8082                	ret

0000000080001388 <kvminit>:
{
    80001388:	1141                	addi	sp,sp,-16
    8000138a:	e406                	sd	ra,8(sp)
    8000138c:	e022                	sd	s0,0(sp)
    8000138e:	0800                	addi	s0,sp,16
  kernel_pagetable = kvmmake();
    80001390:	00000097          	auipc	ra,0x0
    80001394:	f22080e7          	jalr	-222(ra) # 800012b2 <kvmmake>
    80001398:	0000a797          	auipc	a5,0xa
    8000139c:	c8a7b423          	sd	a0,-888(a5) # 8000b020 <kernel_pagetable>
}
    800013a0:	60a2                	ld	ra,8(sp)
    800013a2:	6402                	ld	s0,0(sp)
    800013a4:	0141                	addi	sp,sp,16
    800013a6:	8082                	ret

00000000800013a8 <uvmunmap>:
// Remove npages of mappings starting from va. va must be
// page-aligned. The mappings must exist.
// Optionally free the physical memory.
void
uvmunmap(pagetable_t pagetable, uint64 va, uint64 npages, int do_free)
{
    800013a8:	715d                	addi	sp,sp,-80
    800013aa:	e486                	sd	ra,72(sp)
    800013ac:	e0a2                	sd	s0,64(sp)
    800013ae:	fc26                	sd	s1,56(sp)
    800013b0:	f84a                	sd	s2,48(sp)
    800013b2:	f44e                	sd	s3,40(sp)
    800013b4:	f052                	sd	s4,32(sp)
    800013b6:	ec56                	sd	s5,24(sp)
    800013b8:	e85a                	sd	s6,16(sp)
    800013ba:	e45e                	sd	s7,8(sp)
    800013bc:	0880                	addi	s0,sp,80
  uint64 a;
  pte_t *pte;

  if((va % PGSIZE) != 0)
    800013be:	03459793          	slli	a5,a1,0x34
    800013c2:	e795                	bnez	a5,800013ee <uvmunmap+0x46>
    800013c4:	8a2a                	mv	s4,a0
    800013c6:	892e                	mv	s2,a1
    800013c8:	8ab6                	mv	s5,a3
    panic("uvmunmap: not aligned");

  for(a = va; a < va + npages*PGSIZE; a += PGSIZE){
    800013ca:	0632                	slli	a2,a2,0xc
    800013cc:	00b609b3          	add	s3,a2,a1
    if((pte = walk(pagetable, a, 0)) == 0)
      panic("uvmunmap: walk");
    if((*pte & PTE_V) == 0)
      panic("uvmunmap: not mapped");
    if(PTE_FLAGS(*pte) == PTE_V)
    800013d0:	4b85                	li	s7,1
  for(a = va; a < va + npages*PGSIZE; a += PGSIZE){
    800013d2:	6b05                	lui	s6,0x1
    800013d4:	0735e263          	bltu	a1,s3,80001438 <uvmunmap+0x90>
      uint64 pa = PTE2PA(*pte);
      kfree((void*)pa);
    }
    *pte = 0;
  }
}
    800013d8:	60a6                	ld	ra,72(sp)
    800013da:	6406                	ld	s0,64(sp)
    800013dc:	74e2                	ld	s1,56(sp)
    800013de:	7942                	ld	s2,48(sp)
    800013e0:	79a2                	ld	s3,40(sp)
    800013e2:	7a02                	ld	s4,32(sp)
    800013e4:	6ae2                	ld	s5,24(sp)
    800013e6:	6b42                	ld	s6,16(sp)
    800013e8:	6ba2                	ld	s7,8(sp)
    800013ea:	6161                	addi	sp,sp,80
    800013ec:	8082                	ret
    panic("uvmunmap: not aligned");
    800013ee:	00008517          	auipc	a0,0x8
    800013f2:	d1250513          	addi	a0,a0,-750 # 80009100 <digits+0xc0>
    800013f6:	fffff097          	auipc	ra,0xfffff
    800013fa:	26c080e7          	jalr	620(ra) # 80000662 <panic>
      panic("uvmunmap: walk");
    800013fe:	00008517          	auipc	a0,0x8
    80001402:	d1a50513          	addi	a0,a0,-742 # 80009118 <digits+0xd8>
    80001406:	fffff097          	auipc	ra,0xfffff
    8000140a:	25c080e7          	jalr	604(ra) # 80000662 <panic>
      panic("uvmunmap: not mapped");
    8000140e:	00008517          	auipc	a0,0x8
    80001412:	d1a50513          	addi	a0,a0,-742 # 80009128 <digits+0xe8>
    80001416:	fffff097          	auipc	ra,0xfffff
    8000141a:	24c080e7          	jalr	588(ra) # 80000662 <panic>
      panic("uvmunmap: not a leaf");
    8000141e:	00008517          	auipc	a0,0x8
    80001422:	d2250513          	addi	a0,a0,-734 # 80009140 <digits+0x100>
    80001426:	fffff097          	auipc	ra,0xfffff
    8000142a:	23c080e7          	jalr	572(ra) # 80000662 <panic>
    *pte = 0;
    8000142e:	0004b023          	sd	zero,0(s1)
  for(a = va; a < va + npages*PGSIZE; a += PGSIZE){
    80001432:	995a                	add	s2,s2,s6
    80001434:	fb3972e3          	bgeu	s2,s3,800013d8 <uvmunmap+0x30>
    if((pte = walk(pagetable, a, 0)) == 0)
    80001438:	4601                	li	a2,0
    8000143a:	85ca                	mv	a1,s2
    8000143c:	8552                	mv	a0,s4
    8000143e:	00000097          	auipc	ra,0x0
    80001442:	cbc080e7          	jalr	-836(ra) # 800010fa <walk>
    80001446:	84aa                	mv	s1,a0
    80001448:	d95d                	beqz	a0,800013fe <uvmunmap+0x56>
    if((*pte & PTE_V) == 0)
    8000144a:	6108                	ld	a0,0(a0)
    8000144c:	00157793          	andi	a5,a0,1
    80001450:	dfdd                	beqz	a5,8000140e <uvmunmap+0x66>
    if(PTE_FLAGS(*pte) == PTE_V)
    80001452:	3ff57793          	andi	a5,a0,1023
    80001456:	fd7784e3          	beq	a5,s7,8000141e <uvmunmap+0x76>
    if(do_free){
    8000145a:	fc0a8ae3          	beqz	s5,8000142e <uvmunmap+0x86>
      uint64 pa = PTE2PA(*pte);
    8000145e:	8129                	srli	a0,a0,0xa
      kfree((void*)pa);
    80001460:	0532                	slli	a0,a0,0xc
    80001462:	fffff097          	auipc	ra,0xfffff
    80001466:	6a8080e7          	jalr	1704(ra) # 80000b0a <kfree>
    8000146a:	b7d1                	j	8000142e <uvmunmap+0x86>

000000008000146c <uvmcreate>:

// create an empty user page table.
// returns 0 if out of memory.
pagetable_t
uvmcreate()
{
    8000146c:	1101                	addi	sp,sp,-32
    8000146e:	ec06                	sd	ra,24(sp)
    80001470:	e822                	sd	s0,16(sp)
    80001472:	e426                	sd	s1,8(sp)
    80001474:	1000                	addi	s0,sp,32
  pagetable_t pagetable;
  pagetable = (pagetable_t) kalloc();
    80001476:	fffff097          	auipc	ra,0xfffff
    8000147a:	792080e7          	jalr	1938(ra) # 80000c08 <kalloc>
    8000147e:	84aa                	mv	s1,a0
  if(pagetable == 0)
    80001480:	c519                	beqz	a0,8000148e <uvmcreate+0x22>
    return 0;
  kmemset(pagetable, 0, PGSIZE);
    80001482:	6605                	lui	a2,0x1
    80001484:	4581                	li	a1,0
    80001486:	00000097          	auipc	ra,0x0
    8000148a:	96e080e7          	jalr	-1682(ra) # 80000df4 <kmemset>
  return pagetable;
}
    8000148e:	8526                	mv	a0,s1
    80001490:	60e2                	ld	ra,24(sp)
    80001492:	6442                	ld	s0,16(sp)
    80001494:	64a2                	ld	s1,8(sp)
    80001496:	6105                	addi	sp,sp,32
    80001498:	8082                	ret

000000008000149a <uvminit>:
// Load the user initcode into address 0 of pagetable,
// for the very first process.
// sz must be less than a page.
void
uvminit(pagetable_t pagetable, uchar *src, uint sz)
{
    8000149a:	7179                	addi	sp,sp,-48
    8000149c:	f406                	sd	ra,40(sp)
    8000149e:	f022                	sd	s0,32(sp)
    800014a0:	ec26                	sd	s1,24(sp)
    800014a2:	e84a                	sd	s2,16(sp)
    800014a4:	e44e                	sd	s3,8(sp)
    800014a6:	e052                	sd	s4,0(sp)
    800014a8:	1800                	addi	s0,sp,48
  char *mem;

  if(sz >= PGSIZE)
    800014aa:	6785                	lui	a5,0x1
    800014ac:	04f67863          	bgeu	a2,a5,800014fc <uvminit+0x62>
    800014b0:	8a2a                	mv	s4,a0
    800014b2:	89ae                	mv	s3,a1
    800014b4:	84b2                	mv	s1,a2
    panic("inituvm: more than a page");
  mem = kalloc();
    800014b6:	fffff097          	auipc	ra,0xfffff
    800014ba:	752080e7          	jalr	1874(ra) # 80000c08 <kalloc>
    800014be:	892a                	mv	s2,a0
  kmemset(mem, 0, PGSIZE);
    800014c0:	6605                	lui	a2,0x1
    800014c2:	4581                	li	a1,0
    800014c4:	00000097          	auipc	ra,0x0
    800014c8:	930080e7          	jalr	-1744(ra) # 80000df4 <kmemset>
  mappages(pagetable, 0, PGSIZE, (uint64)mem, PTE_W|PTE_R|PTE_X|PTE_U);
    800014cc:	4779                	li	a4,30
    800014ce:	86ca                	mv	a3,s2
    800014d0:	6605                	lui	a2,0x1
    800014d2:	4581                	li	a1,0
    800014d4:	8552                	mv	a0,s4
    800014d6:	00000097          	auipc	ra,0x0
    800014da:	d0c080e7          	jalr	-756(ra) # 800011e2 <mappages>
  kmemmove(mem, src, sz);
    800014de:	8626                	mv	a2,s1
    800014e0:	85ce                	mv	a1,s3
    800014e2:	854a                	mv	a0,s2
    800014e4:	00000097          	auipc	ra,0x0
    800014e8:	96c080e7          	jalr	-1684(ra) # 80000e50 <kmemmove>
}
    800014ec:	70a2                	ld	ra,40(sp)
    800014ee:	7402                	ld	s0,32(sp)
    800014f0:	64e2                	ld	s1,24(sp)
    800014f2:	6942                	ld	s2,16(sp)
    800014f4:	69a2                	ld	s3,8(sp)
    800014f6:	6a02                	ld	s4,0(sp)
    800014f8:	6145                	addi	sp,sp,48
    800014fa:	8082                	ret
    panic("inituvm: more than a page");
    800014fc:	00008517          	auipc	a0,0x8
    80001500:	c5c50513          	addi	a0,a0,-932 # 80009158 <digits+0x118>
    80001504:	fffff097          	auipc	ra,0xfffff
    80001508:	15e080e7          	jalr	350(ra) # 80000662 <panic>

000000008000150c <uvmdealloc>:
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
uint64
uvmdealloc(pagetable_t pagetable, uint64 oldsz, uint64 newsz)
{
    8000150c:	1101                	addi	sp,sp,-32
    8000150e:	ec06                	sd	ra,24(sp)
    80001510:	e822                	sd	s0,16(sp)
    80001512:	e426                	sd	s1,8(sp)
    80001514:	1000                	addi	s0,sp,32
  if(newsz >= oldsz)
    return oldsz;
    80001516:	84ae                	mv	s1,a1
  if(newsz >= oldsz)
    80001518:	00b67d63          	bgeu	a2,a1,80001532 <uvmdealloc+0x26>
    8000151c:	84b2                	mv	s1,a2

  if(PGROUNDUP(newsz) < PGROUNDUP(oldsz)){
    8000151e:	6785                	lui	a5,0x1
    80001520:	17fd                	addi	a5,a5,-1
    80001522:	00f60733          	add	a4,a2,a5
    80001526:	76fd                	lui	a3,0xfffff
    80001528:	8f75                	and	a4,a4,a3
    8000152a:	97ae                	add	a5,a5,a1
    8000152c:	8ff5                	and	a5,a5,a3
    8000152e:	00f76863          	bltu	a4,a5,8000153e <uvmdealloc+0x32>
    int npages = (PGROUNDUP(oldsz) - PGROUNDUP(newsz)) / PGSIZE;
    uvmunmap(pagetable, PGROUNDUP(newsz), npages, 1);
  }

  return newsz;
}
    80001532:	8526                	mv	a0,s1
    80001534:	60e2                	ld	ra,24(sp)
    80001536:	6442                	ld	s0,16(sp)
    80001538:	64a2                	ld	s1,8(sp)
    8000153a:	6105                	addi	sp,sp,32
    8000153c:	8082                	ret
    int npages = (PGROUNDUP(oldsz) - PGROUNDUP(newsz)) / PGSIZE;
    8000153e:	8f99                	sub	a5,a5,a4
    80001540:	83b1                	srli	a5,a5,0xc
    uvmunmap(pagetable, PGROUNDUP(newsz), npages, 1);
    80001542:	4685                	li	a3,1
    80001544:	0007861b          	sext.w	a2,a5
    80001548:	85ba                	mv	a1,a4
    8000154a:	00000097          	auipc	ra,0x0
    8000154e:	e5e080e7          	jalr	-418(ra) # 800013a8 <uvmunmap>
    80001552:	b7c5                	j	80001532 <uvmdealloc+0x26>

0000000080001554 <uvmalloc>:
  if(newsz < oldsz)
    80001554:	0ab66163          	bltu	a2,a1,800015f6 <uvmalloc+0xa2>
{
    80001558:	7139                	addi	sp,sp,-64
    8000155a:	fc06                	sd	ra,56(sp)
    8000155c:	f822                	sd	s0,48(sp)
    8000155e:	f426                	sd	s1,40(sp)
    80001560:	f04a                	sd	s2,32(sp)
    80001562:	ec4e                	sd	s3,24(sp)
    80001564:	e852                	sd	s4,16(sp)
    80001566:	e456                	sd	s5,8(sp)
    80001568:	0080                	addi	s0,sp,64
    8000156a:	8aaa                	mv	s5,a0
    8000156c:	8a32                	mv	s4,a2
  oldsz = PGROUNDUP(oldsz);
    8000156e:	6785                	lui	a5,0x1
    80001570:	17fd                	addi	a5,a5,-1
    80001572:	95be                	add	a1,a1,a5
    80001574:	77fd                	lui	a5,0xfffff
    80001576:	00f5f9b3          	and	s3,a1,a5
  for(a = oldsz; a < newsz; a += PGSIZE){
    8000157a:	08c9f063          	bgeu	s3,a2,800015fa <uvmalloc+0xa6>
    8000157e:	894e                	mv	s2,s3
    mem = kalloc();
    80001580:	fffff097          	auipc	ra,0xfffff
    80001584:	688080e7          	jalr	1672(ra) # 80000c08 <kalloc>
    80001588:	84aa                	mv	s1,a0
    if(mem == 0){
    8000158a:	c51d                	beqz	a0,800015b8 <uvmalloc+0x64>
    kmemset(mem, 0, PGSIZE);
    8000158c:	6605                	lui	a2,0x1
    8000158e:	4581                	li	a1,0
    80001590:	00000097          	auipc	ra,0x0
    80001594:	864080e7          	jalr	-1948(ra) # 80000df4 <kmemset>
    if(mappages(pagetable, a, PGSIZE, (uint64)mem, PTE_W|PTE_X|PTE_R|PTE_U) != 0){
    80001598:	4779                	li	a4,30
    8000159a:	86a6                	mv	a3,s1
    8000159c:	6605                	lui	a2,0x1
    8000159e:	85ca                	mv	a1,s2
    800015a0:	8556                	mv	a0,s5
    800015a2:	00000097          	auipc	ra,0x0
    800015a6:	c40080e7          	jalr	-960(ra) # 800011e2 <mappages>
    800015aa:	e905                	bnez	a0,800015da <uvmalloc+0x86>
  for(a = oldsz; a < newsz; a += PGSIZE){
    800015ac:	6785                	lui	a5,0x1
    800015ae:	993e                	add	s2,s2,a5
    800015b0:	fd4968e3          	bltu	s2,s4,80001580 <uvmalloc+0x2c>
  return newsz;
    800015b4:	8552                	mv	a0,s4
    800015b6:	a809                	j	800015c8 <uvmalloc+0x74>
      uvmdealloc(pagetable, a, oldsz);
    800015b8:	864e                	mv	a2,s3
    800015ba:	85ca                	mv	a1,s2
    800015bc:	8556                	mv	a0,s5
    800015be:	00000097          	auipc	ra,0x0
    800015c2:	f4e080e7          	jalr	-178(ra) # 8000150c <uvmdealloc>
      return 0;
    800015c6:	4501                	li	a0,0
}
    800015c8:	70e2                	ld	ra,56(sp)
    800015ca:	7442                	ld	s0,48(sp)
    800015cc:	74a2                	ld	s1,40(sp)
    800015ce:	7902                	ld	s2,32(sp)
    800015d0:	69e2                	ld	s3,24(sp)
    800015d2:	6a42                	ld	s4,16(sp)
    800015d4:	6aa2                	ld	s5,8(sp)
    800015d6:	6121                	addi	sp,sp,64
    800015d8:	8082                	ret
      kfree(mem);
    800015da:	8526                	mv	a0,s1
    800015dc:	fffff097          	auipc	ra,0xfffff
    800015e0:	52e080e7          	jalr	1326(ra) # 80000b0a <kfree>
      uvmdealloc(pagetable, a, oldsz);
    800015e4:	864e                	mv	a2,s3
    800015e6:	85ca                	mv	a1,s2
    800015e8:	8556                	mv	a0,s5
    800015ea:	00000097          	auipc	ra,0x0
    800015ee:	f22080e7          	jalr	-222(ra) # 8000150c <uvmdealloc>
      return 0;
    800015f2:	4501                	li	a0,0
    800015f4:	bfd1                	j	800015c8 <uvmalloc+0x74>
    return oldsz;
    800015f6:	852e                	mv	a0,a1
}
    800015f8:	8082                	ret
  return newsz;
    800015fa:	8532                	mv	a0,a2
    800015fc:	b7f1                	j	800015c8 <uvmalloc+0x74>

00000000800015fe <freewalk>:

// Recursively free page-table pages.
// All leaf mappings must already have been removed.
void
freewalk(pagetable_t pagetable)
{
    800015fe:	7179                	addi	sp,sp,-48
    80001600:	f406                	sd	ra,40(sp)
    80001602:	f022                	sd	s0,32(sp)
    80001604:	ec26                	sd	s1,24(sp)
    80001606:	e84a                	sd	s2,16(sp)
    80001608:	e44e                	sd	s3,8(sp)
    8000160a:	e052                	sd	s4,0(sp)
    8000160c:	1800                	addi	s0,sp,48
    8000160e:	8a2a                	mv	s4,a0
  // there are 2^9 = 512 PTEs in a page table.
  for(int i = 0; i < 512; i++){
    80001610:	84aa                	mv	s1,a0
    80001612:	6905                	lui	s2,0x1
    80001614:	992a                	add	s2,s2,a0
    pte_t pte = pagetable[i];
    if((pte & PTE_V) && (pte & (PTE_R|PTE_W|PTE_X)) == 0){
    80001616:	4985                	li	s3,1
    80001618:	a829                	j	80001632 <freewalk+0x34>
      // this PTE points to a lower-level page table.
      uint64 child = PTE2PA(pte);
    8000161a:	83a9                	srli	a5,a5,0xa
      freewalk((pagetable_t)child);
    8000161c:	00c79513          	slli	a0,a5,0xc
    80001620:	00000097          	auipc	ra,0x0
    80001624:	fde080e7          	jalr	-34(ra) # 800015fe <freewalk>
      pagetable[i] = 0;
    80001628:	0004b023          	sd	zero,0(s1)
  for(int i = 0; i < 512; i++){
    8000162c:	04a1                	addi	s1,s1,8
    8000162e:	03248163          	beq	s1,s2,80001650 <freewalk+0x52>
    pte_t pte = pagetable[i];
    80001632:	609c                	ld	a5,0(s1)
    if((pte & PTE_V) && (pte & (PTE_R|PTE_W|PTE_X)) == 0){
    80001634:	00f7f713          	andi	a4,a5,15
    80001638:	ff3701e3          	beq	a4,s3,8000161a <freewalk+0x1c>
    } else if(pte & PTE_V){
    8000163c:	8b85                	andi	a5,a5,1
    8000163e:	d7fd                	beqz	a5,8000162c <freewalk+0x2e>
      panic("freewalk: leaf");
    80001640:	00008517          	auipc	a0,0x8
    80001644:	b3850513          	addi	a0,a0,-1224 # 80009178 <digits+0x138>
    80001648:	fffff097          	auipc	ra,0xfffff
    8000164c:	01a080e7          	jalr	26(ra) # 80000662 <panic>
    }
  }
  kfree((void*)pagetable);
    80001650:	8552                	mv	a0,s4
    80001652:	fffff097          	auipc	ra,0xfffff
    80001656:	4b8080e7          	jalr	1208(ra) # 80000b0a <kfree>
}
    8000165a:	70a2                	ld	ra,40(sp)
    8000165c:	7402                	ld	s0,32(sp)
    8000165e:	64e2                	ld	s1,24(sp)
    80001660:	6942                	ld	s2,16(sp)
    80001662:	69a2                	ld	s3,8(sp)
    80001664:	6a02                	ld	s4,0(sp)
    80001666:	6145                	addi	sp,sp,48
    80001668:	8082                	ret

000000008000166a <uvmfree>:

// Free user memory pages,
// then free page-table pages.
void
uvmfree(pagetable_t pagetable, uint64 sz)
{
    8000166a:	1101                	addi	sp,sp,-32
    8000166c:	ec06                	sd	ra,24(sp)
    8000166e:	e822                	sd	s0,16(sp)
    80001670:	e426                	sd	s1,8(sp)
    80001672:	1000                	addi	s0,sp,32
    80001674:	84aa                	mv	s1,a0
  if(sz > 0)
    80001676:	e999                	bnez	a1,8000168c <uvmfree+0x22>
    uvmunmap(pagetable, 0, PGROUNDUP(sz)/PGSIZE, 1);
  freewalk(pagetable);
    80001678:	8526                	mv	a0,s1
    8000167a:	00000097          	auipc	ra,0x0
    8000167e:	f84080e7          	jalr	-124(ra) # 800015fe <freewalk>
}
    80001682:	60e2                	ld	ra,24(sp)
    80001684:	6442                	ld	s0,16(sp)
    80001686:	64a2                	ld	s1,8(sp)
    80001688:	6105                	addi	sp,sp,32
    8000168a:	8082                	ret
    uvmunmap(pagetable, 0, PGROUNDUP(sz)/PGSIZE, 1);
    8000168c:	6785                	lui	a5,0x1
    8000168e:	17fd                	addi	a5,a5,-1
    80001690:	95be                	add	a1,a1,a5
    80001692:	4685                	li	a3,1
    80001694:	00c5d613          	srli	a2,a1,0xc
    80001698:	4581                	li	a1,0
    8000169a:	00000097          	auipc	ra,0x0
    8000169e:	d0e080e7          	jalr	-754(ra) # 800013a8 <uvmunmap>
    800016a2:	bfd9                	j	80001678 <uvmfree+0xe>

00000000800016a4 <uvmcopy>:
  pte_t *pte;
  uint64 pa, i;
  uint flags;
  char *mem;

  for(i = 0; i < sz; i += PGSIZE){
    800016a4:	c679                	beqz	a2,80001772 <uvmcopy+0xce>
{
    800016a6:	715d                	addi	sp,sp,-80
    800016a8:	e486                	sd	ra,72(sp)
    800016aa:	e0a2                	sd	s0,64(sp)
    800016ac:	fc26                	sd	s1,56(sp)
    800016ae:	f84a                	sd	s2,48(sp)
    800016b0:	f44e                	sd	s3,40(sp)
    800016b2:	f052                	sd	s4,32(sp)
    800016b4:	ec56                	sd	s5,24(sp)
    800016b6:	e85a                	sd	s6,16(sp)
    800016b8:	e45e                	sd	s7,8(sp)
    800016ba:	0880                	addi	s0,sp,80
    800016bc:	8b2a                	mv	s6,a0
    800016be:	8aae                	mv	s5,a1
    800016c0:	8a32                	mv	s4,a2
  for(i = 0; i < sz; i += PGSIZE){
    800016c2:	4981                	li	s3,0
    if((pte = walk(old, i, 0)) == 0)
    800016c4:	4601                	li	a2,0
    800016c6:	85ce                	mv	a1,s3
    800016c8:	855a                	mv	a0,s6
    800016ca:	00000097          	auipc	ra,0x0
    800016ce:	a30080e7          	jalr	-1488(ra) # 800010fa <walk>
    800016d2:	c531                	beqz	a0,8000171e <uvmcopy+0x7a>
      panic("uvmcopy: pte should exist");
    if((*pte & PTE_V) == 0)
    800016d4:	6118                	ld	a4,0(a0)
    800016d6:	00177793          	andi	a5,a4,1
    800016da:	cbb1                	beqz	a5,8000172e <uvmcopy+0x8a>
      panic("uvmcopy: page not present");
    pa = PTE2PA(*pte);
    800016dc:	00a75593          	srli	a1,a4,0xa
    800016e0:	00c59b93          	slli	s7,a1,0xc
    flags = PTE_FLAGS(*pte);
    800016e4:	3ff77493          	andi	s1,a4,1023
    if((mem = kalloc()) == 0)
    800016e8:	fffff097          	auipc	ra,0xfffff
    800016ec:	520080e7          	jalr	1312(ra) # 80000c08 <kalloc>
    800016f0:	892a                	mv	s2,a0
    800016f2:	c939                	beqz	a0,80001748 <uvmcopy+0xa4>
      goto err;
    kmemmove(mem, (char*)pa, PGSIZE);
    800016f4:	6605                	lui	a2,0x1
    800016f6:	85de                	mv	a1,s7
    800016f8:	fffff097          	auipc	ra,0xfffff
    800016fc:	758080e7          	jalr	1880(ra) # 80000e50 <kmemmove>
    if(mappages(new, i, PGSIZE, (uint64)mem, flags) != 0){
    80001700:	8726                	mv	a4,s1
    80001702:	86ca                	mv	a3,s2
    80001704:	6605                	lui	a2,0x1
    80001706:	85ce                	mv	a1,s3
    80001708:	8556                	mv	a0,s5
    8000170a:	00000097          	auipc	ra,0x0
    8000170e:	ad8080e7          	jalr	-1320(ra) # 800011e2 <mappages>
    80001712:	e515                	bnez	a0,8000173e <uvmcopy+0x9a>
  for(i = 0; i < sz; i += PGSIZE){
    80001714:	6785                	lui	a5,0x1
    80001716:	99be                	add	s3,s3,a5
    80001718:	fb49e6e3          	bltu	s3,s4,800016c4 <uvmcopy+0x20>
    8000171c:	a081                	j	8000175c <uvmcopy+0xb8>
      panic("uvmcopy: pte should exist");
    8000171e:	00008517          	auipc	a0,0x8
    80001722:	a6a50513          	addi	a0,a0,-1430 # 80009188 <digits+0x148>
    80001726:	fffff097          	auipc	ra,0xfffff
    8000172a:	f3c080e7          	jalr	-196(ra) # 80000662 <panic>
      panic("uvmcopy: page not present");
    8000172e:	00008517          	auipc	a0,0x8
    80001732:	a7a50513          	addi	a0,a0,-1414 # 800091a8 <digits+0x168>
    80001736:	fffff097          	auipc	ra,0xfffff
    8000173a:	f2c080e7          	jalr	-212(ra) # 80000662 <panic>
      kfree(mem);
    8000173e:	854a                	mv	a0,s2
    80001740:	fffff097          	auipc	ra,0xfffff
    80001744:	3ca080e7          	jalr	970(ra) # 80000b0a <kfree>
    }
  }
  return 0;

 err:
  uvmunmap(new, 0, i / PGSIZE, 1);
    80001748:	4685                	li	a3,1
    8000174a:	00c9d613          	srli	a2,s3,0xc
    8000174e:	4581                	li	a1,0
    80001750:	8556                	mv	a0,s5
    80001752:	00000097          	auipc	ra,0x0
    80001756:	c56080e7          	jalr	-938(ra) # 800013a8 <uvmunmap>
  return -1;
    8000175a:	557d                	li	a0,-1
}
    8000175c:	60a6                	ld	ra,72(sp)
    8000175e:	6406                	ld	s0,64(sp)
    80001760:	74e2                	ld	s1,56(sp)
    80001762:	7942                	ld	s2,48(sp)
    80001764:	79a2                	ld	s3,40(sp)
    80001766:	7a02                	ld	s4,32(sp)
    80001768:	6ae2                	ld	s5,24(sp)
    8000176a:	6b42                	ld	s6,16(sp)
    8000176c:	6ba2                	ld	s7,8(sp)
    8000176e:	6161                	addi	sp,sp,80
    80001770:	8082                	ret
  return 0;
    80001772:	4501                	li	a0,0
}
    80001774:	8082                	ret

0000000080001776 <uvmclear>:

// mark a PTE invalid for user access.
// used by exec for the user stack guard page.
void
uvmclear(pagetable_t pagetable, uint64 va)
{
    80001776:	1141                	addi	sp,sp,-16
    80001778:	e406                	sd	ra,8(sp)
    8000177a:	e022                	sd	s0,0(sp)
    8000177c:	0800                	addi	s0,sp,16
  pte_t *pte;
  
  pte = walk(pagetable, va, 0);
    8000177e:	4601                	li	a2,0
    80001780:	00000097          	auipc	ra,0x0
    80001784:	97a080e7          	jalr	-1670(ra) # 800010fa <walk>
  if(pte == 0)
    80001788:	c901                	beqz	a0,80001798 <uvmclear+0x22>
    panic("uvmclear");
  *pte &= ~PTE_U;
    8000178a:	611c                	ld	a5,0(a0)
    8000178c:	9bbd                	andi	a5,a5,-17
    8000178e:	e11c                	sd	a5,0(a0)
}
    80001790:	60a2                	ld	ra,8(sp)
    80001792:	6402                	ld	s0,0(sp)
    80001794:	0141                	addi	sp,sp,16
    80001796:	8082                	ret
    panic("uvmclear");
    80001798:	00008517          	auipc	a0,0x8
    8000179c:	a3050513          	addi	a0,a0,-1488 # 800091c8 <digits+0x188>
    800017a0:	fffff097          	auipc	ra,0xfffff
    800017a4:	ec2080e7          	jalr	-318(ra) # 80000662 <panic>

00000000800017a8 <copyout>:
int
copyout(pagetable_t pagetable, uint64 dstva, char *src, uint64 len)
{
  uint64 n, va0, pa0;

  while(len > 0){
    800017a8:	c6bd                	beqz	a3,80001816 <copyout+0x6e>
{
    800017aa:	715d                	addi	sp,sp,-80
    800017ac:	e486                	sd	ra,72(sp)
    800017ae:	e0a2                	sd	s0,64(sp)
    800017b0:	fc26                	sd	s1,56(sp)
    800017b2:	f84a                	sd	s2,48(sp)
    800017b4:	f44e                	sd	s3,40(sp)
    800017b6:	f052                	sd	s4,32(sp)
    800017b8:	ec56                	sd	s5,24(sp)
    800017ba:	e85a                	sd	s6,16(sp)
    800017bc:	e45e                	sd	s7,8(sp)
    800017be:	e062                	sd	s8,0(sp)
    800017c0:	0880                	addi	s0,sp,80
    800017c2:	8b2a                	mv	s6,a0
    800017c4:	8c2e                	mv	s8,a1
    800017c6:	8a32                	mv	s4,a2
    800017c8:	89b6                	mv	s3,a3
    va0 = PGROUNDDOWN(dstva);
    800017ca:	7bfd                	lui	s7,0xfffff
    pa0 = walkaddr(pagetable, va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (dstva - va0);
    800017cc:	6a85                	lui	s5,0x1
    800017ce:	a015                	j	800017f2 <copyout+0x4a>
    if(n > len)
      n = len;
    kmemmove((void *)(pa0 + (dstva - va0)), src, n);
    800017d0:	9562                	add	a0,a0,s8
    800017d2:	0004861b          	sext.w	a2,s1
    800017d6:	85d2                	mv	a1,s4
    800017d8:	41250533          	sub	a0,a0,s2
    800017dc:	fffff097          	auipc	ra,0xfffff
    800017e0:	674080e7          	jalr	1652(ra) # 80000e50 <kmemmove>

    len -= n;
    800017e4:	409989b3          	sub	s3,s3,s1
    src += n;
    800017e8:	9a26                	add	s4,s4,s1
    dstva = va0 + PGSIZE;
    800017ea:	01590c33          	add	s8,s2,s5
  while(len > 0){
    800017ee:	02098263          	beqz	s3,80001812 <copyout+0x6a>
    va0 = PGROUNDDOWN(dstva);
    800017f2:	017c7933          	and	s2,s8,s7
    pa0 = walkaddr(pagetable, va0);
    800017f6:	85ca                	mv	a1,s2
    800017f8:	855a                	mv	a0,s6
    800017fa:	00000097          	auipc	ra,0x0
    800017fe:	9a6080e7          	jalr	-1626(ra) # 800011a0 <walkaddr>
    if(pa0 == 0)
    80001802:	cd01                	beqz	a0,8000181a <copyout+0x72>
    n = PGSIZE - (dstva - va0);
    80001804:	418904b3          	sub	s1,s2,s8
    80001808:	94d6                	add	s1,s1,s5
    8000180a:	fc99f3e3          	bgeu	s3,s1,800017d0 <copyout+0x28>
    8000180e:	84ce                	mv	s1,s3
    80001810:	b7c1                	j	800017d0 <copyout+0x28>
  }
  return 0;
    80001812:	4501                	li	a0,0
    80001814:	a021                	j	8000181c <copyout+0x74>
    80001816:	4501                	li	a0,0
}
    80001818:	8082                	ret
      return -1;
    8000181a:	557d                	li	a0,-1
}
    8000181c:	60a6                	ld	ra,72(sp)
    8000181e:	6406                	ld	s0,64(sp)
    80001820:	74e2                	ld	s1,56(sp)
    80001822:	7942                	ld	s2,48(sp)
    80001824:	79a2                	ld	s3,40(sp)
    80001826:	7a02                	ld	s4,32(sp)
    80001828:	6ae2                	ld	s5,24(sp)
    8000182a:	6b42                	ld	s6,16(sp)
    8000182c:	6ba2                	ld	s7,8(sp)
    8000182e:	6c02                	ld	s8,0(sp)
    80001830:	6161                	addi	sp,sp,80
    80001832:	8082                	ret

0000000080001834 <copyin>:
int
copyin(pagetable_t pagetable, char *dst, uint64 srcva, uint64 len)
{
  uint64 n, va0, pa0;

  while(len > 0){
    80001834:	caa5                	beqz	a3,800018a4 <copyin+0x70>
{
    80001836:	715d                	addi	sp,sp,-80
    80001838:	e486                	sd	ra,72(sp)
    8000183a:	e0a2                	sd	s0,64(sp)
    8000183c:	fc26                	sd	s1,56(sp)
    8000183e:	f84a                	sd	s2,48(sp)
    80001840:	f44e                	sd	s3,40(sp)
    80001842:	f052                	sd	s4,32(sp)
    80001844:	ec56                	sd	s5,24(sp)
    80001846:	e85a                	sd	s6,16(sp)
    80001848:	e45e                	sd	s7,8(sp)
    8000184a:	e062                	sd	s8,0(sp)
    8000184c:	0880                	addi	s0,sp,80
    8000184e:	8b2a                	mv	s6,a0
    80001850:	8a2e                	mv	s4,a1
    80001852:	8c32                	mv	s8,a2
    80001854:	89b6                	mv	s3,a3
    va0 = PGROUNDDOWN(srcva);
    80001856:	7bfd                	lui	s7,0xfffff
    pa0 = walkaddr(pagetable, va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (srcva - va0);
    80001858:	6a85                	lui	s5,0x1
    8000185a:	a01d                	j	80001880 <copyin+0x4c>
    if(n > len)
      n = len;
    kmemmove(dst, (void *)(pa0 + (srcva - va0)), n);
    8000185c:	018505b3          	add	a1,a0,s8
    80001860:	0004861b          	sext.w	a2,s1
    80001864:	412585b3          	sub	a1,a1,s2
    80001868:	8552                	mv	a0,s4
    8000186a:	fffff097          	auipc	ra,0xfffff
    8000186e:	5e6080e7          	jalr	1510(ra) # 80000e50 <kmemmove>

    len -= n;
    80001872:	409989b3          	sub	s3,s3,s1
    dst += n;
    80001876:	9a26                	add	s4,s4,s1
    srcva = va0 + PGSIZE;
    80001878:	01590c33          	add	s8,s2,s5
  while(len > 0){
    8000187c:	02098263          	beqz	s3,800018a0 <copyin+0x6c>
    va0 = PGROUNDDOWN(srcva);
    80001880:	017c7933          	and	s2,s8,s7
    pa0 = walkaddr(pagetable, va0);
    80001884:	85ca                	mv	a1,s2
    80001886:	855a                	mv	a0,s6
    80001888:	00000097          	auipc	ra,0x0
    8000188c:	918080e7          	jalr	-1768(ra) # 800011a0 <walkaddr>
    if(pa0 == 0)
    80001890:	cd01                	beqz	a0,800018a8 <copyin+0x74>
    n = PGSIZE - (srcva - va0);
    80001892:	418904b3          	sub	s1,s2,s8
    80001896:	94d6                	add	s1,s1,s5
    80001898:	fc99f2e3          	bgeu	s3,s1,8000185c <copyin+0x28>
    8000189c:	84ce                	mv	s1,s3
    8000189e:	bf7d                	j	8000185c <copyin+0x28>
  }
  return 0;
    800018a0:	4501                	li	a0,0
    800018a2:	a021                	j	800018aa <copyin+0x76>
    800018a4:	4501                	li	a0,0
}
    800018a6:	8082                	ret
      return -1;
    800018a8:	557d                	li	a0,-1
}
    800018aa:	60a6                	ld	ra,72(sp)
    800018ac:	6406                	ld	s0,64(sp)
    800018ae:	74e2                	ld	s1,56(sp)
    800018b0:	7942                	ld	s2,48(sp)
    800018b2:	79a2                	ld	s3,40(sp)
    800018b4:	7a02                	ld	s4,32(sp)
    800018b6:	6ae2                	ld	s5,24(sp)
    800018b8:	6b42                	ld	s6,16(sp)
    800018ba:	6ba2                	ld	s7,8(sp)
    800018bc:	6c02                	ld	s8,0(sp)
    800018be:	6161                	addi	sp,sp,80
    800018c0:	8082                	ret

00000000800018c2 <copyinstr>:
copyinstr(pagetable_t pagetable, char *dst, uint64 srcva, uint64 max)
{
  uint64 n, va0, pa0;
  int got_null = 0;

  while(got_null == 0 && max > 0){
    800018c2:	c2dd                	beqz	a3,80001968 <copyinstr+0xa6>
{
    800018c4:	715d                	addi	sp,sp,-80
    800018c6:	e486                	sd	ra,72(sp)
    800018c8:	e0a2                	sd	s0,64(sp)
    800018ca:	fc26                	sd	s1,56(sp)
    800018cc:	f84a                	sd	s2,48(sp)
    800018ce:	f44e                	sd	s3,40(sp)
    800018d0:	f052                	sd	s4,32(sp)
    800018d2:	ec56                	sd	s5,24(sp)
    800018d4:	e85a                	sd	s6,16(sp)
    800018d6:	e45e                	sd	s7,8(sp)
    800018d8:	0880                	addi	s0,sp,80
    800018da:	8a2a                	mv	s4,a0
    800018dc:	8b2e                	mv	s6,a1
    800018de:	8bb2                	mv	s7,a2
    800018e0:	84b6                	mv	s1,a3
    va0 = PGROUNDDOWN(srcva);
    800018e2:	7afd                	lui	s5,0xfffff
    pa0 = walkaddr(pagetable, va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (srcva - va0);
    800018e4:	6985                	lui	s3,0x1
    800018e6:	a02d                	j	80001910 <copyinstr+0x4e>
      n = max;

    char *p = (char *) (pa0 + (srcva - va0));
    while(n > 0){
      if(*p == '\0'){
        *dst = '\0';
    800018e8:	00078023          	sb	zero,0(a5) # 1000 <_entry-0x7ffff000>
    800018ec:	4785                	li	a5,1
      dst++;
    }

    srcva = va0 + PGSIZE;
  }
  if(got_null){
    800018ee:	37fd                	addiw	a5,a5,-1
    800018f0:	0007851b          	sext.w	a0,a5
    return 0;
  } else {
    return -1;
  }
}
    800018f4:	60a6                	ld	ra,72(sp)
    800018f6:	6406                	ld	s0,64(sp)
    800018f8:	74e2                	ld	s1,56(sp)
    800018fa:	7942                	ld	s2,48(sp)
    800018fc:	79a2                	ld	s3,40(sp)
    800018fe:	7a02                	ld	s4,32(sp)
    80001900:	6ae2                	ld	s5,24(sp)
    80001902:	6b42                	ld	s6,16(sp)
    80001904:	6ba2                	ld	s7,8(sp)
    80001906:	6161                	addi	sp,sp,80
    80001908:	8082                	ret
    srcva = va0 + PGSIZE;
    8000190a:	01390bb3          	add	s7,s2,s3
  while(got_null == 0 && max > 0){
    8000190e:	c8a9                	beqz	s1,80001960 <copyinstr+0x9e>
    va0 = PGROUNDDOWN(srcva);
    80001910:	015bf933          	and	s2,s7,s5
    pa0 = walkaddr(pagetable, va0);
    80001914:	85ca                	mv	a1,s2
    80001916:	8552                	mv	a0,s4
    80001918:	00000097          	auipc	ra,0x0
    8000191c:	888080e7          	jalr	-1912(ra) # 800011a0 <walkaddr>
    if(pa0 == 0)
    80001920:	c131                	beqz	a0,80001964 <copyinstr+0xa2>
    n = PGSIZE - (srcva - va0);
    80001922:	417906b3          	sub	a3,s2,s7
    80001926:	96ce                	add	a3,a3,s3
    80001928:	00d4f363          	bgeu	s1,a3,8000192e <copyinstr+0x6c>
    8000192c:	86a6                	mv	a3,s1
    char *p = (char *) (pa0 + (srcva - va0));
    8000192e:	955e                	add	a0,a0,s7
    80001930:	41250533          	sub	a0,a0,s2
    while(n > 0){
    80001934:	daf9                	beqz	a3,8000190a <copyinstr+0x48>
    80001936:	87da                	mv	a5,s6
      if(*p == '\0'){
    80001938:	41650633          	sub	a2,a0,s6
    8000193c:	fff48593          	addi	a1,s1,-1
    80001940:	95da                	add	a1,a1,s6
    while(n > 0){
    80001942:	96da                	add	a3,a3,s6
      if(*p == '\0'){
    80001944:	00f60733          	add	a4,a2,a5
    80001948:	00074703          	lbu	a4,0(a4) # fffffffffffff000 <end+0xffffffff7ffd4c40>
    8000194c:	df51                	beqz	a4,800018e8 <copyinstr+0x26>
        *dst = *p;
    8000194e:	00e78023          	sb	a4,0(a5)
      --max;
    80001952:	40f584b3          	sub	s1,a1,a5
      dst++;
    80001956:	0785                	addi	a5,a5,1
    while(n > 0){
    80001958:	fed796e3          	bne	a5,a3,80001944 <copyinstr+0x82>
      dst++;
    8000195c:	8b3e                	mv	s6,a5
    8000195e:	b775                	j	8000190a <copyinstr+0x48>
    80001960:	4781                	li	a5,0
    80001962:	b771                	j	800018ee <copyinstr+0x2c>
      return -1;
    80001964:	557d                	li	a0,-1
    80001966:	b779                	j	800018f4 <copyinstr+0x32>
  int got_null = 0;
    80001968:	4781                	li	a5,0
  if(got_null){
    8000196a:	37fd                	addiw	a5,a5,-1
    8000196c:	0007851b          	sext.w	a0,a5
}
    80001970:	8082                	ret

0000000080001972 <proc_mapstacks>:

// Allocate a page for each process's kernel stack.
// Map it high in memory, followed by an invalid
// guard page.
void proc_mapstacks(pagetable_t kpgtbl)
{
    80001972:	7139                	addi	sp,sp,-64
    80001974:	fc06                	sd	ra,56(sp)
    80001976:	f822                	sd	s0,48(sp)
    80001978:	f426                	sd	s1,40(sp)
    8000197a:	f04a                	sd	s2,32(sp)
    8000197c:	ec4e                	sd	s3,24(sp)
    8000197e:	e852                	sd	s4,16(sp)
    80001980:	e456                	sd	s5,8(sp)
    80001982:	e05a                	sd	s6,0(sp)
    80001984:	0080                	addi	s0,sp,64
    80001986:	89aa                	mv	s3,a0
	struct proc *p;
	
	for(p = proc; p < &proc[NPROC]; p++) {
    80001988:	00012497          	auipc	s1,0x12
    8000198c:	d4848493          	addi	s1,s1,-696 # 800136d0 <proc>

		if(pa == NULL) {
			panic("kalloc");
		}

		uint64 va = KSTACK((int) (p - proc));
    80001990:	8b26                	mv	s6,s1
    80001992:	00007a97          	auipc	s5,0x7
    80001996:	66ea8a93          	addi	s5,s5,1646 # 80009000 <etext>
    8000199a:	04000937          	lui	s2,0x4000
    8000199e:	197d                	addi	s2,s2,-1
    800019a0:	0932                	slli	s2,s2,0xc
	for(p = proc; p < &proc[NPROC]; p++) {
    800019a2:	00017a17          	auipc	s4,0x17
    800019a6:	72ea0a13          	addi	s4,s4,1838 # 800190d0 <tickslock>
		char *pa = kalloc();
    800019aa:	fffff097          	auipc	ra,0xfffff
    800019ae:	25e080e7          	jalr	606(ra) # 80000c08 <kalloc>
    800019b2:	862a                	mv	a2,a0
		if(pa == NULL) {
    800019b4:	c131                	beqz	a0,800019f8 <proc_mapstacks+0x86>
		uint64 va = KSTACK((int) (p - proc));
    800019b6:	416485b3          	sub	a1,s1,s6
    800019ba:	858d                	srai	a1,a1,0x3
    800019bc:	000ab783          	ld	a5,0(s5)
    800019c0:	02f585b3          	mul	a1,a1,a5
    800019c4:	2585                	addiw	a1,a1,1
    800019c6:	00d5959b          	slliw	a1,a1,0xd
		kvmmap(kpgtbl, va, (uint64)pa, PGSIZE, PTE_R | PTE_W);
    800019ca:	4719                	li	a4,6
    800019cc:	6685                	lui	a3,0x1
    800019ce:	40b905b3          	sub	a1,s2,a1
    800019d2:	854e                	mv	a0,s3
    800019d4:	00000097          	auipc	ra,0x0
    800019d8:	8ae080e7          	jalr	-1874(ra) # 80001282 <kvmmap>
	for(p = proc; p < &proc[NPROC]; p++) {
    800019dc:	16848493          	addi	s1,s1,360
    800019e0:	fd4495e3          	bne	s1,s4,800019aa <proc_mapstacks+0x38>
	}
}
    800019e4:	70e2                	ld	ra,56(sp)
    800019e6:	7442                	ld	s0,48(sp)
    800019e8:	74a2                	ld	s1,40(sp)
    800019ea:	7902                	ld	s2,32(sp)
    800019ec:	69e2                	ld	s3,24(sp)
    800019ee:	6a42                	ld	s4,16(sp)
    800019f0:	6aa2                	ld	s5,8(sp)
    800019f2:	6b02                	ld	s6,0(sp)
    800019f4:	6121                	addi	sp,sp,64
    800019f6:	8082                	ret
			panic("kalloc");
    800019f8:	00007517          	auipc	a0,0x7
    800019fc:	7e050513          	addi	a0,a0,2016 # 800091d8 <digits+0x198>
    80001a00:	fffff097          	auipc	ra,0xfffff
    80001a04:	c62080e7          	jalr	-926(ra) # 80000662 <panic>

0000000080001a08 <procinit>:

// initialize the proc table at boot time.
void procinit(void)
{
    80001a08:	7139                	addi	sp,sp,-64
    80001a0a:	fc06                	sd	ra,56(sp)
    80001a0c:	f822                	sd	s0,48(sp)
    80001a0e:	f426                	sd	s1,40(sp)
    80001a10:	f04a                	sd	s2,32(sp)
    80001a12:	ec4e                	sd	s3,24(sp)
    80001a14:	e852                	sd	s4,16(sp)
    80001a16:	e456                	sd	s5,8(sp)
    80001a18:	e05a                	sd	s6,0(sp)
    80001a1a:	0080                	addi	s0,sp,64
	struct proc * p;
	
	initlock(&pid_lock, "nextpid");
    80001a1c:	00007597          	auipc	a1,0x7
    80001a20:	7c458593          	addi	a1,a1,1988 # 800091e0 <digits+0x1a0>
    80001a24:	00012517          	auipc	a0,0x12
    80001a28:	87c50513          	addi	a0,a0,-1924 # 800132a0 <pid_lock>
    80001a2c:	fffff097          	auipc	ra,0xfffff
    80001a30:	23c080e7          	jalr	572(ra) # 80000c68 <initlock>
	initlock(&wait_lock, "wait_lock");
    80001a34:	00007597          	auipc	a1,0x7
    80001a38:	7b458593          	addi	a1,a1,1972 # 800091e8 <digits+0x1a8>
    80001a3c:	00012517          	auipc	a0,0x12
    80001a40:	87c50513          	addi	a0,a0,-1924 # 800132b8 <wait_lock>
    80001a44:	fffff097          	auipc	ra,0xfffff
    80001a48:	224080e7          	jalr	548(ra) # 80000c68 <initlock>

	for(p = proc; p < &proc[NPROC]; p++) {
    80001a4c:	00012497          	auipc	s1,0x12
    80001a50:	c8448493          	addi	s1,s1,-892 # 800136d0 <proc>
		initlock(&p->lock, "proc");
    80001a54:	00007b17          	auipc	s6,0x7
    80001a58:	7a4b0b13          	addi	s6,s6,1956 # 800091f8 <digits+0x1b8>
		p->kstack = KSTACK((int) (p - proc));
    80001a5c:	8aa6                	mv	s5,s1
    80001a5e:	00007a17          	auipc	s4,0x7
    80001a62:	5a2a0a13          	addi	s4,s4,1442 # 80009000 <etext>
    80001a66:	04000937          	lui	s2,0x4000
    80001a6a:	197d                	addi	s2,s2,-1
    80001a6c:	0932                	slli	s2,s2,0xc
	for(p = proc; p < &proc[NPROC]; p++) {
    80001a6e:	00017997          	auipc	s3,0x17
    80001a72:	66298993          	addi	s3,s3,1634 # 800190d0 <tickslock>
		initlock(&p->lock, "proc");
    80001a76:	85da                	mv	a1,s6
    80001a78:	8526                	mv	a0,s1
    80001a7a:	fffff097          	auipc	ra,0xfffff
    80001a7e:	1ee080e7          	jalr	494(ra) # 80000c68 <initlock>
		p->kstack = KSTACK((int) (p - proc));
    80001a82:	415487b3          	sub	a5,s1,s5
    80001a86:	878d                	srai	a5,a5,0x3
    80001a88:	000a3703          	ld	a4,0(s4)
    80001a8c:	02e787b3          	mul	a5,a5,a4
    80001a90:	2785                	addiw	a5,a5,1
    80001a92:	00d7979b          	slliw	a5,a5,0xd
    80001a96:	40f907b3          	sub	a5,s2,a5
    80001a9a:	e0bc                	sd	a5,64(s1)
	for(p = proc; p < &proc[NPROC]; p++) {
    80001a9c:	16848493          	addi	s1,s1,360
    80001aa0:	fd349be3          	bne	s1,s3,80001a76 <procinit+0x6e>
	}
}
    80001aa4:	70e2                	ld	ra,56(sp)
    80001aa6:	7442                	ld	s0,48(sp)
    80001aa8:	74a2                	ld	s1,40(sp)
    80001aaa:	7902                	ld	s2,32(sp)
    80001aac:	69e2                	ld	s3,24(sp)
    80001aae:	6a42                	ld	s4,16(sp)
    80001ab0:	6aa2                	ld	s5,8(sp)
    80001ab2:	6b02                	ld	s6,0(sp)
    80001ab4:	6121                	addi	sp,sp,64
    80001ab6:	8082                	ret

0000000080001ab8 <cpuid>:

// Must be called with interrupts disabled,
// to prevent race with process being moved
// to a different CPU.
int cpuid()
{
    80001ab8:	1141                	addi	sp,sp,-16
    80001aba:	e422                	sd	s0,8(sp)
    80001abc:	0800                	addi	s0,sp,16
  asm volatile("mv %0, tp" : "=r" (x) );
    80001abe:	8512                	mv	a0,tp
	int id = r_tp();
	return id;
}
    80001ac0:	2501                	sext.w	a0,a0
    80001ac2:	6422                	ld	s0,8(sp)
    80001ac4:	0141                	addi	sp,sp,16
    80001ac6:	8082                	ret

0000000080001ac8 <mycpu>:

// Return this CPU's cpu struct.
// Interrupts must be disabled.
struct cpu * mycpu(void)
{
    80001ac8:	1141                	addi	sp,sp,-16
    80001aca:	e422                	sd	s0,8(sp)
    80001acc:	0800                	addi	s0,sp,16
    80001ace:	8792                	mv	a5,tp
	int id = cpuid();
	struct cpu *c = &cpus[id];
    80001ad0:	2781                	sext.w	a5,a5
    80001ad2:	079e                	slli	a5,a5,0x7

	return c;
}
    80001ad4:	00011517          	auipc	a0,0x11
    80001ad8:	7fc50513          	addi	a0,a0,2044 # 800132d0 <cpus>
    80001adc:	953e                	add	a0,a0,a5
    80001ade:	6422                	ld	s0,8(sp)
    80001ae0:	0141                	addi	sp,sp,16
    80001ae2:	8082                	ret

0000000080001ae4 <myproc>:

// Return the current struct proc *, or zero if none.
struct proc * myproc(void)
{
    80001ae4:	1101                	addi	sp,sp,-32
    80001ae6:	ec06                	sd	ra,24(sp)
    80001ae8:	e822                	sd	s0,16(sp)
    80001aea:	e426                	sd	s1,8(sp)
    80001aec:	1000                	addi	s0,sp,32
	push_off();
    80001aee:	fffff097          	auipc	ra,0xfffff
    80001af2:	1be080e7          	jalr	446(ra) # 80000cac <push_off>
    80001af6:	8792                	mv	a5,tp

	struct cpu *c = mycpu();
	struct proc *p = c->proc;
    80001af8:	2781                	sext.w	a5,a5
    80001afa:	079e                	slli	a5,a5,0x7
    80001afc:	00011717          	auipc	a4,0x11
    80001b00:	7a470713          	addi	a4,a4,1956 # 800132a0 <pid_lock>
    80001b04:	97ba                	add	a5,a5,a4
    80001b06:	7b84                	ld	s1,48(a5)

	pop_off();
    80001b08:	fffff097          	auipc	ra,0xfffff
    80001b0c:	244080e7          	jalr	580(ra) # 80000d4c <pop_off>

	return p;
}
    80001b10:	8526                	mv	a0,s1
    80001b12:	60e2                	ld	ra,24(sp)
    80001b14:	6442                	ld	s0,16(sp)
    80001b16:	64a2                	ld	s1,8(sp)
    80001b18:	6105                	addi	sp,sp,32
    80001b1a:	8082                	ret

0000000080001b1c <forkret>:
}

// A fork child's very first scheduling by scheduler()
// will swtch to forkret.
void forkret(void)
{
    80001b1c:	1101                	addi	sp,sp,-32
    80001b1e:	ec06                	sd	ra,24(sp)
    80001b20:	e822                	sd	s0,16(sp)
    80001b22:	e426                	sd	s1,8(sp)
    80001b24:	1000                	addi	s0,sp,32
	// Still holding p->lock from scheduler.
	static int first = 1;

	release(&myproc()->lock);
    80001b26:	00000097          	auipc	ra,0x0
    80001b2a:	fbe080e7          	jalr	-66(ra) # 80001ae4 <myproc>
    80001b2e:	fffff097          	auipc	ra,0xfffff
    80001b32:	27e080e7          	jalr	638(ra) # 80000dac <release>
	
	if(first) {
    80001b36:	00008797          	auipc	a5,0x8
    80001b3a:	49a7a783          	lw	a5,1178(a5) # 80009fd0 <first.1>
    80001b3e:	eb91                	bnez	a5,80001b52 <forkret+0x36>
		first = 0;
		root_init(ROOTDEV);
		initproc->cwd = namei("/"); /* Finish setting up init here because root_init() has to be called before namei() will work, and root_init() needs the rest of the process in place to function */
	}

	usertrapret();
    80001b40:	00001097          	auipc	ra,0x1
    80001b44:	b14080e7          	jalr	-1260(ra) # 80002654 <usertrapret>
}
    80001b48:	60e2                	ld	ra,24(sp)
    80001b4a:	6442                	ld	s0,16(sp)
    80001b4c:	64a2                	ld	s1,8(sp)
    80001b4e:	6105                	addi	sp,sp,32
    80001b50:	8082                	ret
		first = 0;
    80001b52:	00008797          	auipc	a5,0x8
    80001b56:	4607af23          	sw	zero,1150(a5) # 80009fd0 <first.1>
		root_init(ROOTDEV);
    80001b5a:	4505                	li	a0,1
    80001b5c:	00001097          	auipc	ra,0x1
    80001b60:	6a2080e7          	jalr	1698(ra) # 800031fe <root_init>
		initproc->cwd = namei("/"); /* Finish setting up init here because root_init() has to be called before namei() will work, and root_init() needs the rest of the process in place to function */
    80001b64:	00009497          	auipc	s1,0x9
    80001b68:	4c44b483          	ld	s1,1220(s1) # 8000b028 <initproc>
    80001b6c:	00007517          	auipc	a0,0x7
    80001b70:	69450513          	addi	a0,a0,1684 # 80009200 <digits+0x1c0>
    80001b74:	00001097          	auipc	ra,0x1
    80001b78:	7d6080e7          	jalr	2006(ra) # 8000334a <namei>
    80001b7c:	14a4b823          	sd	a0,336(s1)
    80001b80:	b7c1                	j	80001b40 <forkret+0x24>

0000000080001b82 <allocpid>:
{
    80001b82:	1101                	addi	sp,sp,-32
    80001b84:	ec06                	sd	ra,24(sp)
    80001b86:	e822                	sd	s0,16(sp)
    80001b88:	e426                	sd	s1,8(sp)
    80001b8a:	e04a                	sd	s2,0(sp)
    80001b8c:	1000                	addi	s0,sp,32
	acquire(&pid_lock);
    80001b8e:	00011917          	auipc	s2,0x11
    80001b92:	71290913          	addi	s2,s2,1810 # 800132a0 <pid_lock>
    80001b96:	854a                	mv	a0,s2
    80001b98:	fffff097          	auipc	ra,0xfffff
    80001b9c:	160080e7          	jalr	352(ra) # 80000cf8 <acquire>
	pid = nextpid;
    80001ba0:	00008797          	auipc	a5,0x8
    80001ba4:	43478793          	addi	a5,a5,1076 # 80009fd4 <nextpid>
    80001ba8:	4384                	lw	s1,0(a5)
	nextpid = nextpid + 1;
    80001baa:	0014871b          	addiw	a4,s1,1
    80001bae:	c398                	sw	a4,0(a5)
	release(&pid_lock);
    80001bb0:	854a                	mv	a0,s2
    80001bb2:	fffff097          	auipc	ra,0xfffff
    80001bb6:	1fa080e7          	jalr	506(ra) # 80000dac <release>
}
    80001bba:	8526                	mv	a0,s1
    80001bbc:	60e2                	ld	ra,24(sp)
    80001bbe:	6442                	ld	s0,16(sp)
    80001bc0:	64a2                	ld	s1,8(sp)
    80001bc2:	6902                	ld	s2,0(sp)
    80001bc4:	6105                	addi	sp,sp,32
    80001bc6:	8082                	ret

0000000080001bc8 <proc_pagetable>:
{
    80001bc8:	1101                	addi	sp,sp,-32
    80001bca:	ec06                	sd	ra,24(sp)
    80001bcc:	e822                	sd	s0,16(sp)
    80001bce:	e426                	sd	s1,8(sp)
    80001bd0:	e04a                	sd	s2,0(sp)
    80001bd2:	1000                	addi	s0,sp,32
    80001bd4:	892a                	mv	s2,a0
	pagetable = uvmcreate();
    80001bd6:	00000097          	auipc	ra,0x0
    80001bda:	896080e7          	jalr	-1898(ra) # 8000146c <uvmcreate>
    80001bde:	84aa                	mv	s1,a0
	if(pagetable == 0)
    80001be0:	c121                	beqz	a0,80001c20 <proc_pagetable+0x58>
	if(mappages(pagetable, TRAMPOLINE, PGSIZE, (uint64) trampoline, PTE_R | PTE_X) < 0) {
    80001be2:	4729                	li	a4,10
    80001be4:	00006697          	auipc	a3,0x6
    80001be8:	41c68693          	addi	a3,a3,1052 # 80008000 <_trampoline>
    80001bec:	6605                	lui	a2,0x1
    80001bee:	040005b7          	lui	a1,0x4000
    80001bf2:	15fd                	addi	a1,a1,-1
    80001bf4:	05b2                	slli	a1,a1,0xc
    80001bf6:	fffff097          	auipc	ra,0xfffff
    80001bfa:	5ec080e7          	jalr	1516(ra) # 800011e2 <mappages>
    80001bfe:	02054863          	bltz	a0,80001c2e <proc_pagetable+0x66>
	if(mappages(pagetable, TRAPFRAME, PGSIZE, (uint64)(p->trapframe), PTE_R | PTE_W) < 0) {
    80001c02:	4719                	li	a4,6
    80001c04:	05893683          	ld	a3,88(s2)
    80001c08:	6605                	lui	a2,0x1
    80001c0a:	020005b7          	lui	a1,0x2000
    80001c0e:	15fd                	addi	a1,a1,-1
    80001c10:	05b6                	slli	a1,a1,0xd
    80001c12:	8526                	mv	a0,s1
    80001c14:	fffff097          	auipc	ra,0xfffff
    80001c18:	5ce080e7          	jalr	1486(ra) # 800011e2 <mappages>
    80001c1c:	02054163          	bltz	a0,80001c3e <proc_pagetable+0x76>
}
    80001c20:	8526                	mv	a0,s1
    80001c22:	60e2                	ld	ra,24(sp)
    80001c24:	6442                	ld	s0,16(sp)
    80001c26:	64a2                	ld	s1,8(sp)
    80001c28:	6902                	ld	s2,0(sp)
    80001c2a:	6105                	addi	sp,sp,32
    80001c2c:	8082                	ret
		uvmfree(pagetable, 0);
    80001c2e:	4581                	li	a1,0
    80001c30:	8526                	mv	a0,s1
    80001c32:	00000097          	auipc	ra,0x0
    80001c36:	a38080e7          	jalr	-1480(ra) # 8000166a <uvmfree>
		return NULL;
    80001c3a:	4481                	li	s1,0
    80001c3c:	b7d5                	j	80001c20 <proc_pagetable+0x58>
		uvmunmap(pagetable, TRAMPOLINE, 1, 0);
    80001c3e:	4681                	li	a3,0
    80001c40:	4605                	li	a2,1
    80001c42:	040005b7          	lui	a1,0x4000
    80001c46:	15fd                	addi	a1,a1,-1
    80001c48:	05b2                	slli	a1,a1,0xc
    80001c4a:	8526                	mv	a0,s1
    80001c4c:	fffff097          	auipc	ra,0xfffff
    80001c50:	75c080e7          	jalr	1884(ra) # 800013a8 <uvmunmap>
		uvmfree(pagetable, 0);
    80001c54:	4581                	li	a1,0
    80001c56:	8526                	mv	a0,s1
    80001c58:	00000097          	auipc	ra,0x0
    80001c5c:	a12080e7          	jalr	-1518(ra) # 8000166a <uvmfree>
		return NULL;
    80001c60:	4481                	li	s1,0
    80001c62:	bf7d                	j	80001c20 <proc_pagetable+0x58>

0000000080001c64 <proc_freepagetable>:
{
    80001c64:	1101                	addi	sp,sp,-32
    80001c66:	ec06                	sd	ra,24(sp)
    80001c68:	e822                	sd	s0,16(sp)
    80001c6a:	e426                	sd	s1,8(sp)
    80001c6c:	e04a                	sd	s2,0(sp)
    80001c6e:	1000                	addi	s0,sp,32
    80001c70:	84aa                	mv	s1,a0
    80001c72:	892e                	mv	s2,a1
	uvmunmap(pagetable, TRAMPOLINE, 1, 0);
    80001c74:	4681                	li	a3,0
    80001c76:	4605                	li	a2,1
    80001c78:	040005b7          	lui	a1,0x4000
    80001c7c:	15fd                	addi	a1,a1,-1
    80001c7e:	05b2                	slli	a1,a1,0xc
    80001c80:	fffff097          	auipc	ra,0xfffff
    80001c84:	728080e7          	jalr	1832(ra) # 800013a8 <uvmunmap>
	uvmunmap(pagetable, TRAPFRAME, 1, 0);
    80001c88:	4681                	li	a3,0
    80001c8a:	4605                	li	a2,1
    80001c8c:	020005b7          	lui	a1,0x2000
    80001c90:	15fd                	addi	a1,a1,-1
    80001c92:	05b6                	slli	a1,a1,0xd
    80001c94:	8526                	mv	a0,s1
    80001c96:	fffff097          	auipc	ra,0xfffff
    80001c9a:	712080e7          	jalr	1810(ra) # 800013a8 <uvmunmap>
	uvmfree(pagetable, sz);
    80001c9e:	85ca                	mv	a1,s2
    80001ca0:	8526                	mv	a0,s1
    80001ca2:	00000097          	auipc	ra,0x0
    80001ca6:	9c8080e7          	jalr	-1592(ra) # 8000166a <uvmfree>
}
    80001caa:	60e2                	ld	ra,24(sp)
    80001cac:	6442                	ld	s0,16(sp)
    80001cae:	64a2                	ld	s1,8(sp)
    80001cb0:	6902                	ld	s2,0(sp)
    80001cb2:	6105                	addi	sp,sp,32
    80001cb4:	8082                	ret

0000000080001cb6 <freeproc>:
{
    80001cb6:	1101                	addi	sp,sp,-32
    80001cb8:	ec06                	sd	ra,24(sp)
    80001cba:	e822                	sd	s0,16(sp)
    80001cbc:	e426                	sd	s1,8(sp)
    80001cbe:	1000                	addi	s0,sp,32
    80001cc0:	84aa                	mv	s1,a0
	if(p->trapframe) {
    80001cc2:	6d28                	ld	a0,88(a0)
    80001cc4:	c509                	beqz	a0,80001cce <freeproc+0x18>
		kfree((void *)p->trapframe);
    80001cc6:	fffff097          	auipc	ra,0xfffff
    80001cca:	e44080e7          	jalr	-444(ra) # 80000b0a <kfree>
	p->trapframe = 0;
    80001cce:	0404bc23          	sd	zero,88(s1)
	if(p->pagetable) {
    80001cd2:	68a8                	ld	a0,80(s1)
    80001cd4:	c511                	beqz	a0,80001ce0 <freeproc+0x2a>
		proc_freepagetable(p->pagetable, p->sz);
    80001cd6:	64ac                	ld	a1,72(s1)
    80001cd8:	00000097          	auipc	ra,0x0
    80001cdc:	f8c080e7          	jalr	-116(ra) # 80001c64 <proc_freepagetable>
	p->pagetable = 0;
    80001ce0:	0404b823          	sd	zero,80(s1)
	p->sz = 0;
    80001ce4:	0404b423          	sd	zero,72(s1)
	p->pid = 0;
    80001ce8:	0204a823          	sw	zero,48(s1)
	p->parent = 0;
    80001cec:	0204bc23          	sd	zero,56(s1)
	p->name[0] = 0;
    80001cf0:	14048c23          	sb	zero,344(s1)
	p->chan = 0;
    80001cf4:	0204b023          	sd	zero,32(s1)
	p->killed = 0;
    80001cf8:	0204a423          	sw	zero,40(s1)
	p->xstate = 0;
    80001cfc:	0204a623          	sw	zero,44(s1)
	p->state = UNUSED;
    80001d00:	0004ac23          	sw	zero,24(s1)
}
    80001d04:	60e2                	ld	ra,24(sp)
    80001d06:	6442                	ld	s0,16(sp)
    80001d08:	64a2                	ld	s1,8(sp)
    80001d0a:	6105                	addi	sp,sp,32
    80001d0c:	8082                	ret

0000000080001d0e <allocproc>:
{
    80001d0e:	1101                	addi	sp,sp,-32
    80001d10:	ec06                	sd	ra,24(sp)
    80001d12:	e822                	sd	s0,16(sp)
    80001d14:	e426                	sd	s1,8(sp)
    80001d16:	e04a                	sd	s2,0(sp)
    80001d18:	1000                	addi	s0,sp,32
	for(p = proc; p < &proc[NPROC]; p++) {
    80001d1a:	00012497          	auipc	s1,0x12
    80001d1e:	9b648493          	addi	s1,s1,-1610 # 800136d0 <proc>
    80001d22:	00017917          	auipc	s2,0x17
    80001d26:	3ae90913          	addi	s2,s2,942 # 800190d0 <tickslock>
		acquire(&p->lock);
    80001d2a:	8526                	mv	a0,s1
    80001d2c:	fffff097          	auipc	ra,0xfffff
    80001d30:	fcc080e7          	jalr	-52(ra) # 80000cf8 <acquire>
		if(p->state == UNUSED) {
    80001d34:	4c9c                	lw	a5,24(s1)
    80001d36:	cf81                	beqz	a5,80001d4e <allocproc+0x40>
			release(&p->lock);
    80001d38:	8526                	mv	a0,s1
    80001d3a:	fffff097          	auipc	ra,0xfffff
    80001d3e:	072080e7          	jalr	114(ra) # 80000dac <release>
	for(p = proc; p < &proc[NPROC]; p++) {
    80001d42:	16848493          	addi	s1,s1,360
    80001d46:	ff2492e3          	bne	s1,s2,80001d2a <allocproc+0x1c>
	return NULL;
    80001d4a:	4481                	li	s1,0
    80001d4c:	a889                	j	80001d9e <allocproc+0x90>
	p->pid = allocpid();
    80001d4e:	00000097          	auipc	ra,0x0
    80001d52:	e34080e7          	jalr	-460(ra) # 80001b82 <allocpid>
    80001d56:	d888                	sw	a0,48(s1)
	p->state = USED;
    80001d58:	4785                	li	a5,1
    80001d5a:	cc9c                	sw	a5,24(s1)
	if((p->trapframe = (struct trapframe *)kalloc()) == 0) {
    80001d5c:	fffff097          	auipc	ra,0xfffff
    80001d60:	eac080e7          	jalr	-340(ra) # 80000c08 <kalloc>
    80001d64:	892a                	mv	s2,a0
    80001d66:	eca8                	sd	a0,88(s1)
    80001d68:	c131                	beqz	a0,80001dac <allocproc+0x9e>
	p->pagetable = proc_pagetable(p);
    80001d6a:	8526                	mv	a0,s1
    80001d6c:	00000097          	auipc	ra,0x0
    80001d70:	e5c080e7          	jalr	-420(ra) # 80001bc8 <proc_pagetable>
    80001d74:	892a                	mv	s2,a0
    80001d76:	e8a8                	sd	a0,80(s1)
	if(p->pagetable == 0) {
    80001d78:	c531                	beqz	a0,80001dc4 <allocproc+0xb6>
	kmemset(&p->context, 0, sizeof(p->context));
    80001d7a:	07000613          	li	a2,112
    80001d7e:	4581                	li	a1,0
    80001d80:	06048513          	addi	a0,s1,96
    80001d84:	fffff097          	auipc	ra,0xfffff
    80001d88:	070080e7          	jalr	112(ra) # 80000df4 <kmemset>
	p->context.ra = (uint64)forkret;
    80001d8c:	00000797          	auipc	a5,0x0
    80001d90:	d9078793          	addi	a5,a5,-624 # 80001b1c <forkret>
    80001d94:	f0bc                	sd	a5,96(s1)
	p->context.sp = p->kstack + PGSIZE;
    80001d96:	60bc                	ld	a5,64(s1)
    80001d98:	6705                	lui	a4,0x1
    80001d9a:	97ba                	add	a5,a5,a4
    80001d9c:	f4bc                	sd	a5,104(s1)
}
    80001d9e:	8526                	mv	a0,s1
    80001da0:	60e2                	ld	ra,24(sp)
    80001da2:	6442                	ld	s0,16(sp)
    80001da4:	64a2                	ld	s1,8(sp)
    80001da6:	6902                	ld	s2,0(sp)
    80001da8:	6105                	addi	sp,sp,32
    80001daa:	8082                	ret
		freeproc(p);
    80001dac:	8526                	mv	a0,s1
    80001dae:	00000097          	auipc	ra,0x0
    80001db2:	f08080e7          	jalr	-248(ra) # 80001cb6 <freeproc>
		release(&p->lock);
    80001db6:	8526                	mv	a0,s1
    80001db8:	fffff097          	auipc	ra,0xfffff
    80001dbc:	ff4080e7          	jalr	-12(ra) # 80000dac <release>
		return NULL;
    80001dc0:	84ca                	mv	s1,s2
    80001dc2:	bff1                	j	80001d9e <allocproc+0x90>
		freeproc(p);
    80001dc4:	8526                	mv	a0,s1
    80001dc6:	00000097          	auipc	ra,0x0
    80001dca:	ef0080e7          	jalr	-272(ra) # 80001cb6 <freeproc>
		release(&p->lock);
    80001dce:	8526                	mv	a0,s1
    80001dd0:	fffff097          	auipc	ra,0xfffff
    80001dd4:	fdc080e7          	jalr	-36(ra) # 80000dac <release>
		return NULL;
    80001dd8:	84ca                	mv	s1,s2
    80001dda:	b7d1                	j	80001d9e <allocproc+0x90>

0000000080001ddc <userinit>:
{
    80001ddc:	1101                	addi	sp,sp,-32
    80001dde:	ec06                	sd	ra,24(sp)
    80001de0:	e822                	sd	s0,16(sp)
    80001de2:	e426                	sd	s1,8(sp)
    80001de4:	1000                	addi	s0,sp,32
	p = allocproc();
    80001de6:	00000097          	auipc	ra,0x0
    80001dea:	f28080e7          	jalr	-216(ra) # 80001d0e <allocproc>
    80001dee:	84aa                	mv	s1,a0
	initproc = p;
    80001df0:	00009797          	auipc	a5,0x9
    80001df4:	22a7bc23          	sd	a0,568(a5) # 8000b028 <initproc>
	uvminit(p->pagetable, initcode, sizeof(initcode));
    80001df8:	03400613          	li	a2,52
    80001dfc:	00008597          	auipc	a1,0x8
    80001e00:	1e458593          	addi	a1,a1,484 # 80009fe0 <initcode>
    80001e04:	6928                	ld	a0,80(a0)
    80001e06:	fffff097          	auipc	ra,0xfffff
    80001e0a:	694080e7          	jalr	1684(ra) # 8000149a <uvminit>
	p->sz = PGSIZE;
    80001e0e:	6785                	lui	a5,0x1
    80001e10:	e4bc                	sd	a5,72(s1)
	p->trapframe->epc = 0;			// user program counter
    80001e12:	6cb8                	ld	a4,88(s1)
    80001e14:	00073c23          	sd	zero,24(a4) # 1018 <_entry-0x7fffefe8>
	p->trapframe->sp = PGSIZE;	// user stack pointer
    80001e18:	6cb8                	ld	a4,88(s1)
    80001e1a:	fb1c                	sd	a5,48(a4)
	ksafestrcpy(p->name, "initcode", sizeof(p->name));
    80001e1c:	4641                	li	a2,16
    80001e1e:	00007597          	auipc	a1,0x7
    80001e22:	3ea58593          	addi	a1,a1,1002 # 80009208 <digits+0x1c8>
    80001e26:	15848513          	addi	a0,s1,344
    80001e2a:	fffff097          	auipc	ra,0xfffff
    80001e2e:	114080e7          	jalr	276(ra) # 80000f3e <ksafestrcpy>
	p->state = RUNNABLE;
    80001e32:	478d                	li	a5,3
    80001e34:	cc9c                	sw	a5,24(s1)
	release(&p->lock);
    80001e36:	8526                	mv	a0,s1
    80001e38:	fffff097          	auipc	ra,0xfffff
    80001e3c:	f74080e7          	jalr	-140(ra) # 80000dac <release>
}
    80001e40:	60e2                	ld	ra,24(sp)
    80001e42:	6442                	ld	s0,16(sp)
    80001e44:	64a2                	ld	s1,8(sp)
    80001e46:	6105                	addi	sp,sp,32
    80001e48:	8082                	ret

0000000080001e4a <growproc>:
{
    80001e4a:	1101                	addi	sp,sp,-32
    80001e4c:	ec06                	sd	ra,24(sp)
    80001e4e:	e822                	sd	s0,16(sp)
    80001e50:	e426                	sd	s1,8(sp)
    80001e52:	e04a                	sd	s2,0(sp)
    80001e54:	1000                	addi	s0,sp,32
    80001e56:	84aa                	mv	s1,a0
	struct proc * p = myproc();
    80001e58:	00000097          	auipc	ra,0x0
    80001e5c:	c8c080e7          	jalr	-884(ra) # 80001ae4 <myproc>
    80001e60:	892a                	mv	s2,a0
	sz = p->sz;
    80001e62:	652c                	ld	a1,72(a0)
    80001e64:	0005879b          	sext.w	a5,a1
	if(n > 0) {
    80001e68:	00904f63          	bgtz	s1,80001e86 <growproc+0x3c>
	} else if(n < 0) {
    80001e6c:	0204cd63          	bltz	s1,80001ea6 <growproc+0x5c>
	p->sz = sz;
    80001e70:	1782                	slli	a5,a5,0x20
    80001e72:	9381                	srli	a5,a5,0x20
    80001e74:	04f93423          	sd	a5,72(s2)
	return 0;
    80001e78:	4501                	li	a0,0
}
    80001e7a:	60e2                	ld	ra,24(sp)
    80001e7c:	6442                	ld	s0,16(sp)
    80001e7e:	64a2                	ld	s1,8(sp)
    80001e80:	6902                	ld	s2,0(sp)
    80001e82:	6105                	addi	sp,sp,32
    80001e84:	8082                	ret
		if((sz = uvmalloc(p->pagetable, sz, sz + n)) == 0) {
    80001e86:	00f4863b          	addw	a2,s1,a5
    80001e8a:	1602                	slli	a2,a2,0x20
    80001e8c:	9201                	srli	a2,a2,0x20
    80001e8e:	1582                	slli	a1,a1,0x20
    80001e90:	9181                	srli	a1,a1,0x20
    80001e92:	6928                	ld	a0,80(a0)
    80001e94:	fffff097          	auipc	ra,0xfffff
    80001e98:	6c0080e7          	jalr	1728(ra) # 80001554 <uvmalloc>
    80001e9c:	0005079b          	sext.w	a5,a0
    80001ea0:	fbe1                	bnez	a5,80001e70 <growproc+0x26>
			return -1;
    80001ea2:	557d                	li	a0,-1
    80001ea4:	bfd9                	j	80001e7a <growproc+0x30>
		sz = uvmdealloc(p->pagetable, sz, sz + n);
    80001ea6:	00f4863b          	addw	a2,s1,a5
    80001eaa:	1602                	slli	a2,a2,0x20
    80001eac:	9201                	srli	a2,a2,0x20
    80001eae:	1582                	slli	a1,a1,0x20
    80001eb0:	9181                	srli	a1,a1,0x20
    80001eb2:	6928                	ld	a0,80(a0)
    80001eb4:	fffff097          	auipc	ra,0xfffff
    80001eb8:	658080e7          	jalr	1624(ra) # 8000150c <uvmdealloc>
    80001ebc:	0005079b          	sext.w	a5,a0
    80001ec0:	bf45                	j	80001e70 <growproc+0x26>

0000000080001ec2 <fork>:
{
    80001ec2:	7139                	addi	sp,sp,-64
    80001ec4:	fc06                	sd	ra,56(sp)
    80001ec6:	f822                	sd	s0,48(sp)
    80001ec8:	f426                	sd	s1,40(sp)
    80001eca:	f04a                	sd	s2,32(sp)
    80001ecc:	ec4e                	sd	s3,24(sp)
    80001ece:	e852                	sd	s4,16(sp)
    80001ed0:	e456                	sd	s5,8(sp)
    80001ed2:	0080                	addi	s0,sp,64
	struct proc * p = myproc();
    80001ed4:	00000097          	auipc	ra,0x0
    80001ed8:	c10080e7          	jalr	-1008(ra) # 80001ae4 <myproc>
    80001edc:	8aaa                	mv	s5,a0
	if((np = allocproc()) == NULL)
    80001ede:	00000097          	auipc	ra,0x0
    80001ee2:	e30080e7          	jalr	-464(ra) # 80001d0e <allocproc>
    80001ee6:	10050b63          	beqz	a0,80001ffc <fork+0x13a>
    80001eea:	8a2a                	mv	s4,a0
	if(uvmcopy(p->pagetable, np->pagetable, p->sz) < 0) {
    80001eec:	048ab603          	ld	a2,72(s5)
    80001ef0:	692c                	ld	a1,80(a0)
    80001ef2:	050ab503          	ld	a0,80(s5)
    80001ef6:	fffff097          	auipc	ra,0xfffff
    80001efa:	7ae080e7          	jalr	1966(ra) # 800016a4 <uvmcopy>
    80001efe:	04054863          	bltz	a0,80001f4e <fork+0x8c>
	np->sz = p->sz;
    80001f02:	048ab783          	ld	a5,72(s5)
    80001f06:	04fa3423          	sd	a5,72(s4)
	*(np->trapframe) = *(p->trapframe);
    80001f0a:	058ab683          	ld	a3,88(s5)
    80001f0e:	87b6                	mv	a5,a3
    80001f10:	058a3703          	ld	a4,88(s4)
    80001f14:	12068693          	addi	a3,a3,288
    80001f18:	0007b803          	ld	a6,0(a5) # 1000 <_entry-0x7ffff000>
    80001f1c:	6788                	ld	a0,8(a5)
    80001f1e:	6b8c                	ld	a1,16(a5)
    80001f20:	6f90                	ld	a2,24(a5)
    80001f22:	01073023          	sd	a6,0(a4)
    80001f26:	e708                	sd	a0,8(a4)
    80001f28:	eb0c                	sd	a1,16(a4)
    80001f2a:	ef10                	sd	a2,24(a4)
    80001f2c:	02078793          	addi	a5,a5,32
    80001f30:	02070713          	addi	a4,a4,32
    80001f34:	fed792e3          	bne	a5,a3,80001f18 <fork+0x56>
	np->trapframe->a0 = 0;
    80001f38:	058a3783          	ld	a5,88(s4)
    80001f3c:	0607b823          	sd	zero,112(a5)
	for(i = 0; i < NOFILE; i++) {
    80001f40:	0d0a8493          	addi	s1,s5,208
    80001f44:	0d0a0913          	addi	s2,s4,208
    80001f48:	150a8993          	addi	s3,s5,336
    80001f4c:	a00d                	j	80001f6e <fork+0xac>
		freeproc(np);
    80001f4e:	8552                	mv	a0,s4
    80001f50:	00000097          	auipc	ra,0x0
    80001f54:	d66080e7          	jalr	-666(ra) # 80001cb6 <freeproc>
		release(&np->lock);
    80001f58:	8552                	mv	a0,s4
    80001f5a:	fffff097          	auipc	ra,0xfffff
    80001f5e:	e52080e7          	jalr	-430(ra) # 80000dac <release>
		return -1;
    80001f62:	597d                	li	s2,-1
    80001f64:	a051                	j	80001fe8 <fork+0x126>
	for(i = 0; i < NOFILE; i++) {
    80001f66:	04a1                	addi	s1,s1,8
    80001f68:	0921                	addi	s2,s2,8
    80001f6a:	01348b63          	beq	s1,s3,80001f80 <fork+0xbe>
		if(p->ofile[i]) {
    80001f6e:	6088                	ld	a0,0(s1)
    80001f70:	d97d                	beqz	a0,80001f66 <fork+0xa4>
			np->ofile[i] = filedup(p->ofile[i]);
    80001f72:	00002097          	auipc	ra,0x2
    80001f76:	a92080e7          	jalr	-1390(ra) # 80003a04 <filedup>
    80001f7a:	00a93023          	sd	a0,0(s2)
    80001f7e:	b7e5                	j	80001f66 <fork+0xa4>
	np->cwd = p->cwd->inode_ops->idup(p->cwd);
    80001f80:	150ab503          	ld	a0,336(s5)
    80001f84:	691c                	ld	a5,16(a0)
    80001f86:	63bc                	ld	a5,64(a5)
    80001f88:	9782                	jalr	a5
    80001f8a:	14aa3823          	sd	a0,336(s4)
	ksafestrcpy(np->name, p->name, sizeof(p->name));
    80001f8e:	4641                	li	a2,16
    80001f90:	158a8593          	addi	a1,s5,344
    80001f94:	158a0513          	addi	a0,s4,344
    80001f98:	fffff097          	auipc	ra,0xfffff
    80001f9c:	fa6080e7          	jalr	-90(ra) # 80000f3e <ksafestrcpy>
	pid = np->pid;
    80001fa0:	030a2903          	lw	s2,48(s4)
	release(&np->lock);
    80001fa4:	8552                	mv	a0,s4
    80001fa6:	fffff097          	auipc	ra,0xfffff
    80001faa:	e06080e7          	jalr	-506(ra) # 80000dac <release>
	acquire(&wait_lock);
    80001fae:	00011497          	auipc	s1,0x11
    80001fb2:	30a48493          	addi	s1,s1,778 # 800132b8 <wait_lock>
    80001fb6:	8526                	mv	a0,s1
    80001fb8:	fffff097          	auipc	ra,0xfffff
    80001fbc:	d40080e7          	jalr	-704(ra) # 80000cf8 <acquire>
	np->parent = p;
    80001fc0:	035a3c23          	sd	s5,56(s4)
	release(&wait_lock);
    80001fc4:	8526                	mv	a0,s1
    80001fc6:	fffff097          	auipc	ra,0xfffff
    80001fca:	de6080e7          	jalr	-538(ra) # 80000dac <release>
	acquire(&np->lock);
    80001fce:	8552                	mv	a0,s4
    80001fd0:	fffff097          	auipc	ra,0xfffff
    80001fd4:	d28080e7          	jalr	-728(ra) # 80000cf8 <acquire>
	np->state = RUNNABLE;
    80001fd8:	478d                	li	a5,3
    80001fda:	00fa2c23          	sw	a5,24(s4)
	release(&np->lock);
    80001fde:	8552                	mv	a0,s4
    80001fe0:	fffff097          	auipc	ra,0xfffff
    80001fe4:	dcc080e7          	jalr	-564(ra) # 80000dac <release>
}
    80001fe8:	854a                	mv	a0,s2
    80001fea:	70e2                	ld	ra,56(sp)
    80001fec:	7442                	ld	s0,48(sp)
    80001fee:	74a2                	ld	s1,40(sp)
    80001ff0:	7902                	ld	s2,32(sp)
    80001ff2:	69e2                	ld	s3,24(sp)
    80001ff4:	6a42                	ld	s4,16(sp)
    80001ff6:	6aa2                	ld	s5,8(sp)
    80001ff8:	6121                	addi	sp,sp,64
    80001ffa:	8082                	ret
		return -1;
    80001ffc:	597d                	li	s2,-1
    80001ffe:	b7ed                	j	80001fe8 <fork+0x126>

0000000080002000 <scheduler>:
{
    80002000:	7139                	addi	sp,sp,-64
    80002002:	fc06                	sd	ra,56(sp)
    80002004:	f822                	sd	s0,48(sp)
    80002006:	f426                	sd	s1,40(sp)
    80002008:	f04a                	sd	s2,32(sp)
    8000200a:	ec4e                	sd	s3,24(sp)
    8000200c:	e852                	sd	s4,16(sp)
    8000200e:	e456                	sd	s5,8(sp)
    80002010:	e05a                	sd	s6,0(sp)
    80002012:	0080                	addi	s0,sp,64
    80002014:	8792                	mv	a5,tp
	int id = r_tp();
    80002016:	2781                	sext.w	a5,a5
	c->proc = NULL;
    80002018:	00779a93          	slli	s5,a5,0x7
    8000201c:	00011717          	auipc	a4,0x11
    80002020:	28470713          	addi	a4,a4,644 # 800132a0 <pid_lock>
    80002024:	9756                	add	a4,a4,s5
    80002026:	02073823          	sd	zero,48(a4)
				swtch(&c->context, &p->context);
    8000202a:	00011717          	auipc	a4,0x11
    8000202e:	2ae70713          	addi	a4,a4,686 # 800132d8 <cpus+0x8>
    80002032:	9aba                	add	s5,s5,a4
			if(p->state == RUNNABLE) {
    80002034:	498d                	li	s3,3
				p->state = RUNNING;
    80002036:	4b11                	li	s6,4
				c->proc = p;
    80002038:	079e                	slli	a5,a5,0x7
    8000203a:	00011a17          	auipc	s4,0x11
    8000203e:	266a0a13          	addi	s4,s4,614 # 800132a0 <pid_lock>
    80002042:	9a3e                	add	s4,s4,a5
		for(p = proc; p < &proc[NPROC]; p++) {
    80002044:	00017917          	auipc	s2,0x17
    80002048:	08c90913          	addi	s2,s2,140 # 800190d0 <tickslock>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    8000204c:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    80002050:	0027e793          	ori	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80002054:	10079073          	csrw	sstatus,a5
    80002058:	00011497          	auipc	s1,0x11
    8000205c:	67848493          	addi	s1,s1,1656 # 800136d0 <proc>
    80002060:	a811                	j	80002074 <scheduler+0x74>
			release(&p->lock);
    80002062:	8526                	mv	a0,s1
    80002064:	fffff097          	auipc	ra,0xfffff
    80002068:	d48080e7          	jalr	-696(ra) # 80000dac <release>
		for(p = proc; p < &proc[NPROC]; p++) {
    8000206c:	16848493          	addi	s1,s1,360
    80002070:	fd248ee3          	beq	s1,s2,8000204c <scheduler+0x4c>
			acquire(&p->lock);
    80002074:	8526                	mv	a0,s1
    80002076:	fffff097          	auipc	ra,0xfffff
    8000207a:	c82080e7          	jalr	-894(ra) # 80000cf8 <acquire>
			if(p->state == RUNNABLE) {
    8000207e:	4c9c                	lw	a5,24(s1)
    80002080:	ff3791e3          	bne	a5,s3,80002062 <scheduler+0x62>
				p->state = RUNNING;
    80002084:	0164ac23          	sw	s6,24(s1)
				c->proc = p;
    80002088:	029a3823          	sd	s1,48(s4)
				swtch(&c->context, &p->context);
    8000208c:	06048593          	addi	a1,s1,96
    80002090:	8556                	mv	a0,s5
    80002092:	ffffe097          	auipc	ra,0xffffe
    80002096:	048080e7          	jalr	72(ra) # 800000da <swtch>
				c->proc = NULL;
    8000209a:	020a3823          	sd	zero,48(s4)
    8000209e:	b7d1                	j	80002062 <scheduler+0x62>

00000000800020a0 <sched>:
{
    800020a0:	7179                	addi	sp,sp,-48
    800020a2:	f406                	sd	ra,40(sp)
    800020a4:	f022                	sd	s0,32(sp)
    800020a6:	ec26                	sd	s1,24(sp)
    800020a8:	e84a                	sd	s2,16(sp)
    800020aa:	e44e                	sd	s3,8(sp)
    800020ac:	1800                	addi	s0,sp,48
	struct proc *p = myproc();
    800020ae:	00000097          	auipc	ra,0x0
    800020b2:	a36080e7          	jalr	-1482(ra) # 80001ae4 <myproc>
    800020b6:	84aa                	mv	s1,a0
	if(!holding(&p->lock))
    800020b8:	fffff097          	auipc	ra,0xfffff
    800020bc:	bc6080e7          	jalr	-1082(ra) # 80000c7e <holding>
    800020c0:	c93d                	beqz	a0,80002136 <sched+0x96>
  asm volatile("mv %0, tp" : "=r" (x) );
    800020c2:	8792                	mv	a5,tp
	if(mycpu()->noff != 1)
    800020c4:	2781                	sext.w	a5,a5
    800020c6:	079e                	slli	a5,a5,0x7
    800020c8:	00011717          	auipc	a4,0x11
    800020cc:	1d870713          	addi	a4,a4,472 # 800132a0 <pid_lock>
    800020d0:	97ba                	add	a5,a5,a4
    800020d2:	0a87a703          	lw	a4,168(a5)
    800020d6:	4785                	li	a5,1
    800020d8:	06f71763          	bne	a4,a5,80002146 <sched+0xa6>
	if(p->state == RUNNING)
    800020dc:	4c98                	lw	a4,24(s1)
    800020de:	4791                	li	a5,4
    800020e0:	06f70b63          	beq	a4,a5,80002156 <sched+0xb6>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    800020e4:	100027f3          	csrr	a5,sstatus
  return (x & SSTATUS_SIE) != 0;
    800020e8:	8b89                	andi	a5,a5,2
	if(intr_get())
    800020ea:	efb5                	bnez	a5,80002166 <sched+0xc6>
  asm volatile("mv %0, tp" : "=r" (x) );
    800020ec:	8792                	mv	a5,tp
	intena = mycpu()->intena;
    800020ee:	00011917          	auipc	s2,0x11
    800020f2:	1b290913          	addi	s2,s2,434 # 800132a0 <pid_lock>
    800020f6:	2781                	sext.w	a5,a5
    800020f8:	079e                	slli	a5,a5,0x7
    800020fa:	97ca                	add	a5,a5,s2
    800020fc:	0ac7a983          	lw	s3,172(a5)
    80002100:	8792                	mv	a5,tp
	swtch(&p->context, &mycpu()->context);
    80002102:	2781                	sext.w	a5,a5
    80002104:	079e                	slli	a5,a5,0x7
    80002106:	00011597          	auipc	a1,0x11
    8000210a:	1d258593          	addi	a1,a1,466 # 800132d8 <cpus+0x8>
    8000210e:	95be                	add	a1,a1,a5
    80002110:	06048513          	addi	a0,s1,96
    80002114:	ffffe097          	auipc	ra,0xffffe
    80002118:	fc6080e7          	jalr	-58(ra) # 800000da <swtch>
    8000211c:	8792                	mv	a5,tp
	mycpu()->intena = intena;
    8000211e:	2781                	sext.w	a5,a5
    80002120:	079e                	slli	a5,a5,0x7
    80002122:	993e                	add	s2,s2,a5
    80002124:	0b392623          	sw	s3,172(s2)
}
    80002128:	70a2                	ld	ra,40(sp)
    8000212a:	7402                	ld	s0,32(sp)
    8000212c:	64e2                	ld	s1,24(sp)
    8000212e:	6942                	ld	s2,16(sp)
    80002130:	69a2                	ld	s3,8(sp)
    80002132:	6145                	addi	sp,sp,48
    80002134:	8082                	ret
		panic("sched p->lock");
    80002136:	00007517          	auipc	a0,0x7
    8000213a:	0e250513          	addi	a0,a0,226 # 80009218 <digits+0x1d8>
    8000213e:	ffffe097          	auipc	ra,0xffffe
    80002142:	524080e7          	jalr	1316(ra) # 80000662 <panic>
		panic("sched locks");
    80002146:	00007517          	auipc	a0,0x7
    8000214a:	0e250513          	addi	a0,a0,226 # 80009228 <digits+0x1e8>
    8000214e:	ffffe097          	auipc	ra,0xffffe
    80002152:	514080e7          	jalr	1300(ra) # 80000662 <panic>
		panic("sched running");
    80002156:	00007517          	auipc	a0,0x7
    8000215a:	0e250513          	addi	a0,a0,226 # 80009238 <digits+0x1f8>
    8000215e:	ffffe097          	auipc	ra,0xffffe
    80002162:	504080e7          	jalr	1284(ra) # 80000662 <panic>
		panic("sched interruptible");
    80002166:	00007517          	auipc	a0,0x7
    8000216a:	0e250513          	addi	a0,a0,226 # 80009248 <digits+0x208>
    8000216e:	ffffe097          	auipc	ra,0xffffe
    80002172:	4f4080e7          	jalr	1268(ra) # 80000662 <panic>

0000000080002176 <yield>:
{
    80002176:	1101                	addi	sp,sp,-32
    80002178:	ec06                	sd	ra,24(sp)
    8000217a:	e822                	sd	s0,16(sp)
    8000217c:	e426                	sd	s1,8(sp)
    8000217e:	1000                	addi	s0,sp,32
	struct proc * p = myproc();
    80002180:	00000097          	auipc	ra,0x0
    80002184:	964080e7          	jalr	-1692(ra) # 80001ae4 <myproc>
    80002188:	84aa                	mv	s1,a0
	acquire(&p->lock);
    8000218a:	fffff097          	auipc	ra,0xfffff
    8000218e:	b6e080e7          	jalr	-1170(ra) # 80000cf8 <acquire>
	p->state = RUNNABLE;
    80002192:	478d                	li	a5,3
    80002194:	cc9c                	sw	a5,24(s1)
	sched();
    80002196:	00000097          	auipc	ra,0x0
    8000219a:	f0a080e7          	jalr	-246(ra) # 800020a0 <sched>
	release(&p->lock);
    8000219e:	8526                	mv	a0,s1
    800021a0:	fffff097          	auipc	ra,0xfffff
    800021a4:	c0c080e7          	jalr	-1012(ra) # 80000dac <release>
}
    800021a8:	60e2                	ld	ra,24(sp)
    800021aa:	6442                	ld	s0,16(sp)
    800021ac:	64a2                	ld	s1,8(sp)
    800021ae:	6105                	addi	sp,sp,32
    800021b0:	8082                	ret

00000000800021b2 <_sleep>:

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
_sleep(void * chan, struct spinlock *lk)
{
    800021b2:	7179                	addi	sp,sp,-48
    800021b4:	f406                	sd	ra,40(sp)
    800021b6:	f022                	sd	s0,32(sp)
    800021b8:	ec26                	sd	s1,24(sp)
    800021ba:	e84a                	sd	s2,16(sp)
    800021bc:	e44e                	sd	s3,8(sp)
    800021be:	1800                	addi	s0,sp,48
    800021c0:	89aa                	mv	s3,a0
    800021c2:	892e                	mv	s2,a1
	
	struct proc * p = myproc();
    800021c4:	00000097          	auipc	ra,0x0
    800021c8:	920080e7          	jalr	-1760(ra) # 80001ae4 <myproc>
    800021cc:	84aa                	mv	s1,a0
	// change p->state and then call sched.
	// Once we hold p->lock, we can be
	// guaranteed that we won't miss any wakeup
	// (wakeup locks p->lock),
	// so it's okay to release lk.
	acquire(&p->lock);	//DOC: sleeplock1
    800021ce:	fffff097          	auipc	ra,0xfffff
    800021d2:	b2a080e7          	jalr	-1238(ra) # 80000cf8 <acquire>

	release(lk);
    800021d6:	854a                	mv	a0,s2
    800021d8:	fffff097          	auipc	ra,0xfffff
    800021dc:	bd4080e7          	jalr	-1068(ra) # 80000dac <release>

	// Go to sleep.
	p->chan = chan;
    800021e0:	0334b023          	sd	s3,32(s1)
	p->state = SLEEPING;
    800021e4:	4789                	li	a5,2
    800021e6:	cc9c                	sw	a5,24(s1)

	sched();
    800021e8:	00000097          	auipc	ra,0x0
    800021ec:	eb8080e7          	jalr	-328(ra) # 800020a0 <sched>

	// Tidy up.
	p->chan = NULL;
    800021f0:	0204b023          	sd	zero,32(s1)

	// Reacquire original lock.
	release(&p->lock);
    800021f4:	8526                	mv	a0,s1
    800021f6:	fffff097          	auipc	ra,0xfffff
    800021fa:	bb6080e7          	jalr	-1098(ra) # 80000dac <release>
	acquire(lk);
    800021fe:	854a                	mv	a0,s2
    80002200:	fffff097          	auipc	ra,0xfffff
    80002204:	af8080e7          	jalr	-1288(ra) # 80000cf8 <acquire>
}
    80002208:	70a2                	ld	ra,40(sp)
    8000220a:	7402                	ld	s0,32(sp)
    8000220c:	64e2                	ld	s1,24(sp)
    8000220e:	6942                	ld	s2,16(sp)
    80002210:	69a2                	ld	s3,8(sp)
    80002212:	6145                	addi	sp,sp,48
    80002214:	8082                	ret

0000000080002216 <_wait>:
{
    80002216:	715d                	addi	sp,sp,-80
    80002218:	e486                	sd	ra,72(sp)
    8000221a:	e0a2                	sd	s0,64(sp)
    8000221c:	fc26                	sd	s1,56(sp)
    8000221e:	f84a                	sd	s2,48(sp)
    80002220:	f44e                	sd	s3,40(sp)
    80002222:	f052                	sd	s4,32(sp)
    80002224:	ec56                	sd	s5,24(sp)
    80002226:	e85a                	sd	s6,16(sp)
    80002228:	e45e                	sd	s7,8(sp)
    8000222a:	e062                	sd	s8,0(sp)
    8000222c:	0880                	addi	s0,sp,80
    8000222e:	8b2a                	mv	s6,a0
	struct proc *p = myproc();
    80002230:	00000097          	auipc	ra,0x0
    80002234:	8b4080e7          	jalr	-1868(ra) # 80001ae4 <myproc>
    80002238:	892a                	mv	s2,a0
	acquire(&wait_lock);
    8000223a:	00011517          	auipc	a0,0x11
    8000223e:	07e50513          	addi	a0,a0,126 # 800132b8 <wait_lock>
    80002242:	fffff097          	auipc	ra,0xfffff
    80002246:	ab6080e7          	jalr	-1354(ra) # 80000cf8 <acquire>
		havekids = 0;
    8000224a:	4b81                	li	s7,0
				if(np->state == ZOMBIE) {
    8000224c:	4a15                	li	s4,5
				havekids = 1;
    8000224e:	4a85                	li	s5,1
		for(np = proc; np < &proc[NPROC]; np++) {
    80002250:	00017997          	auipc	s3,0x17
    80002254:	e8098993          	addi	s3,s3,-384 # 800190d0 <tickslock>
		_sleep(p, &wait_lock);	//DOC: wait-sleep
    80002258:	00011c17          	auipc	s8,0x11
    8000225c:	060c0c13          	addi	s8,s8,96 # 800132b8 <wait_lock>
		havekids = 0;
    80002260:	875e                	mv	a4,s7
		for(np = proc; np < &proc[NPROC]; np++) {
    80002262:	00011497          	auipc	s1,0x11
    80002266:	46e48493          	addi	s1,s1,1134 # 800136d0 <proc>
    8000226a:	a0bd                	j	800022d8 <_wait+0xc2>
					pid = np->pid;
    8000226c:	0304a983          	lw	s3,48(s1)
					if(addr != 0 && copyout(p->pagetable, addr, (char *) &np->xstate, sizeof(np->xstate)) < 0) {
    80002270:	000b0e63          	beqz	s6,8000228c <_wait+0x76>
    80002274:	4691                	li	a3,4
    80002276:	02c48613          	addi	a2,s1,44
    8000227a:	85da                	mv	a1,s6
    8000227c:	05093503          	ld	a0,80(s2)
    80002280:	fffff097          	auipc	ra,0xfffff
    80002284:	528080e7          	jalr	1320(ra) # 800017a8 <copyout>
    80002288:	02054563          	bltz	a0,800022b2 <_wait+0x9c>
					freeproc(np);
    8000228c:	8526                	mv	a0,s1
    8000228e:	00000097          	auipc	ra,0x0
    80002292:	a28080e7          	jalr	-1496(ra) # 80001cb6 <freeproc>
					release(&np->lock);
    80002296:	8526                	mv	a0,s1
    80002298:	fffff097          	auipc	ra,0xfffff
    8000229c:	b14080e7          	jalr	-1260(ra) # 80000dac <release>
					release(&wait_lock);
    800022a0:	00011517          	auipc	a0,0x11
    800022a4:	01850513          	addi	a0,a0,24 # 800132b8 <wait_lock>
    800022a8:	fffff097          	auipc	ra,0xfffff
    800022ac:	b04080e7          	jalr	-1276(ra) # 80000dac <release>
					return pid;
    800022b0:	a09d                	j	80002316 <_wait+0x100>
						release(&np->lock);
    800022b2:	8526                	mv	a0,s1
    800022b4:	fffff097          	auipc	ra,0xfffff
    800022b8:	af8080e7          	jalr	-1288(ra) # 80000dac <release>
						release(&wait_lock);
    800022bc:	00011517          	auipc	a0,0x11
    800022c0:	ffc50513          	addi	a0,a0,-4 # 800132b8 <wait_lock>
    800022c4:	fffff097          	auipc	ra,0xfffff
    800022c8:	ae8080e7          	jalr	-1304(ra) # 80000dac <release>
						return -1;
    800022cc:	59fd                	li	s3,-1
    800022ce:	a0a1                	j	80002316 <_wait+0x100>
		for(np = proc; np < &proc[NPROC]; np++) {
    800022d0:	16848493          	addi	s1,s1,360
    800022d4:	03348463          	beq	s1,s3,800022fc <_wait+0xe6>
			if(np->parent == p) {
    800022d8:	7c9c                	ld	a5,56(s1)
    800022da:	ff279be3          	bne	a5,s2,800022d0 <_wait+0xba>
				acquire(&np->lock);
    800022de:	8526                	mv	a0,s1
    800022e0:	fffff097          	auipc	ra,0xfffff
    800022e4:	a18080e7          	jalr	-1512(ra) # 80000cf8 <acquire>
				if(np->state == ZOMBIE) {
    800022e8:	4c9c                	lw	a5,24(s1)
    800022ea:	f94781e3          	beq	a5,s4,8000226c <_wait+0x56>
				release(&np->lock);
    800022ee:	8526                	mv	a0,s1
    800022f0:	fffff097          	auipc	ra,0xfffff
    800022f4:	abc080e7          	jalr	-1348(ra) # 80000dac <release>
				havekids = 1;
    800022f8:	8756                	mv	a4,s5
    800022fa:	bfd9                	j	800022d0 <_wait+0xba>
		if(!havekids || p->killed) {
    800022fc:	c701                	beqz	a4,80002304 <_wait+0xee>
    800022fe:	02892783          	lw	a5,40(s2)
    80002302:	c79d                	beqz	a5,80002330 <_wait+0x11a>
			release(&wait_lock);
    80002304:	00011517          	auipc	a0,0x11
    80002308:	fb450513          	addi	a0,a0,-76 # 800132b8 <wait_lock>
    8000230c:	fffff097          	auipc	ra,0xfffff
    80002310:	aa0080e7          	jalr	-1376(ra) # 80000dac <release>
			return -1;
    80002314:	59fd                	li	s3,-1
}
    80002316:	854e                	mv	a0,s3
    80002318:	60a6                	ld	ra,72(sp)
    8000231a:	6406                	ld	s0,64(sp)
    8000231c:	74e2                	ld	s1,56(sp)
    8000231e:	7942                	ld	s2,48(sp)
    80002320:	79a2                	ld	s3,40(sp)
    80002322:	7a02                	ld	s4,32(sp)
    80002324:	6ae2                	ld	s5,24(sp)
    80002326:	6b42                	ld	s6,16(sp)
    80002328:	6ba2                	ld	s7,8(sp)
    8000232a:	6c02                	ld	s8,0(sp)
    8000232c:	6161                	addi	sp,sp,80
    8000232e:	8082                	ret
		_sleep(p, &wait_lock);	//DOC: wait-sleep
    80002330:	85e2                	mv	a1,s8
    80002332:	854a                	mv	a0,s2
    80002334:	00000097          	auipc	ra,0x0
    80002338:	e7e080e7          	jalr	-386(ra) # 800021b2 <_sleep>
		havekids = 0;
    8000233c:	b715                	j	80002260 <_wait+0x4a>

000000008000233e <wakeup>:

// Wake up all processes sleeping on chan.
// Must be called without any p->lock.
void wakeup(void * chan)
{
    8000233e:	7139                	addi	sp,sp,-64
    80002340:	fc06                	sd	ra,56(sp)
    80002342:	f822                	sd	s0,48(sp)
    80002344:	f426                	sd	s1,40(sp)
    80002346:	f04a                	sd	s2,32(sp)
    80002348:	ec4e                	sd	s3,24(sp)
    8000234a:	e852                	sd	s4,16(sp)
    8000234c:	e456                	sd	s5,8(sp)
    8000234e:	0080                	addi	s0,sp,64
    80002350:	8a2a                	mv	s4,a0
	
	struct proc * p;

	for(p = proc; p < &proc[NPROC]; p++) {
    80002352:	00011497          	auipc	s1,0x11
    80002356:	37e48493          	addi	s1,s1,894 # 800136d0 <proc>
		if(p != myproc()) {
			acquire(&p->lock);

			if(p->state == SLEEPING && p->chan == chan) {
    8000235a:	4989                	li	s3,2
				p->state = RUNNABLE;
    8000235c:	4a8d                	li	s5,3
	for(p = proc; p < &proc[NPROC]; p++) {
    8000235e:	00017917          	auipc	s2,0x17
    80002362:	d7290913          	addi	s2,s2,-654 # 800190d0 <tickslock>
    80002366:	a811                	j	8000237a <wakeup+0x3c>
			}

			release(&p->lock);
    80002368:	8526                	mv	a0,s1
    8000236a:	fffff097          	auipc	ra,0xfffff
    8000236e:	a42080e7          	jalr	-1470(ra) # 80000dac <release>
	for(p = proc; p < &proc[NPROC]; p++) {
    80002372:	16848493          	addi	s1,s1,360
    80002376:	03248663          	beq	s1,s2,800023a2 <wakeup+0x64>
		if(p != myproc()) {
    8000237a:	fffff097          	auipc	ra,0xfffff
    8000237e:	76a080e7          	jalr	1898(ra) # 80001ae4 <myproc>
    80002382:	fea488e3          	beq	s1,a0,80002372 <wakeup+0x34>
			acquire(&p->lock);
    80002386:	8526                	mv	a0,s1
    80002388:	fffff097          	auipc	ra,0xfffff
    8000238c:	970080e7          	jalr	-1680(ra) # 80000cf8 <acquire>
			if(p->state == SLEEPING && p->chan == chan) {
    80002390:	4c9c                	lw	a5,24(s1)
    80002392:	fd379be3          	bne	a5,s3,80002368 <wakeup+0x2a>
    80002396:	709c                	ld	a5,32(s1)
    80002398:	fd4798e3          	bne	a5,s4,80002368 <wakeup+0x2a>
				p->state = RUNNABLE;
    8000239c:	0154ac23          	sw	s5,24(s1)
    800023a0:	b7e1                	j	80002368 <wakeup+0x2a>
		}
	}
}
    800023a2:	70e2                	ld	ra,56(sp)
    800023a4:	7442                	ld	s0,48(sp)
    800023a6:	74a2                	ld	s1,40(sp)
    800023a8:	7902                	ld	s2,32(sp)
    800023aa:	69e2                	ld	s3,24(sp)
    800023ac:	6a42                	ld	s4,16(sp)
    800023ae:	6aa2                	ld	s5,8(sp)
    800023b0:	6121                	addi	sp,sp,64
    800023b2:	8082                	ret

00000000800023b4 <reparent>:
{
    800023b4:	7179                	addi	sp,sp,-48
    800023b6:	f406                	sd	ra,40(sp)
    800023b8:	f022                	sd	s0,32(sp)
    800023ba:	ec26                	sd	s1,24(sp)
    800023bc:	e84a                	sd	s2,16(sp)
    800023be:	e44e                	sd	s3,8(sp)
    800023c0:	e052                	sd	s4,0(sp)
    800023c2:	1800                	addi	s0,sp,48
    800023c4:	892a                	mv	s2,a0
	for(pp = proc; pp < &proc[NPROC]; pp++) {
    800023c6:	00011497          	auipc	s1,0x11
    800023ca:	30a48493          	addi	s1,s1,778 # 800136d0 <proc>
			pp->parent = initproc;
    800023ce:	00009a17          	auipc	s4,0x9
    800023d2:	c5aa0a13          	addi	s4,s4,-934 # 8000b028 <initproc>
	for(pp = proc; pp < &proc[NPROC]; pp++) {
    800023d6:	00017997          	auipc	s3,0x17
    800023da:	cfa98993          	addi	s3,s3,-774 # 800190d0 <tickslock>
    800023de:	a029                	j	800023e8 <reparent+0x34>
    800023e0:	16848493          	addi	s1,s1,360
    800023e4:	01348d63          	beq	s1,s3,800023fe <reparent+0x4a>
		if(pp->parent == p) {
    800023e8:	7c9c                	ld	a5,56(s1)
    800023ea:	ff279be3          	bne	a5,s2,800023e0 <reparent+0x2c>
			pp->parent = initproc;
    800023ee:	000a3503          	ld	a0,0(s4)
    800023f2:	fc88                	sd	a0,56(s1)
			wakeup(initproc);
    800023f4:	00000097          	auipc	ra,0x0
    800023f8:	f4a080e7          	jalr	-182(ra) # 8000233e <wakeup>
    800023fc:	b7d5                	j	800023e0 <reparent+0x2c>
}
    800023fe:	70a2                	ld	ra,40(sp)
    80002400:	7402                	ld	s0,32(sp)
    80002402:	64e2                	ld	s1,24(sp)
    80002404:	6942                	ld	s2,16(sp)
    80002406:	69a2                	ld	s3,8(sp)
    80002408:	6a02                	ld	s4,0(sp)
    8000240a:	6145                	addi	sp,sp,48
    8000240c:	8082                	ret

000000008000240e <_exit>:
{
    8000240e:	7179                	addi	sp,sp,-48
    80002410:	f406                	sd	ra,40(sp)
    80002412:	f022                	sd	s0,32(sp)
    80002414:	ec26                	sd	s1,24(sp)
    80002416:	e84a                	sd	s2,16(sp)
    80002418:	e44e                	sd	s3,8(sp)
    8000241a:	e052                	sd	s4,0(sp)
    8000241c:	1800                	addi	s0,sp,48
    8000241e:	8a2a                	mv	s4,a0
	struct proc * p = myproc();
    80002420:	fffff097          	auipc	ra,0xfffff
    80002424:	6c4080e7          	jalr	1732(ra) # 80001ae4 <myproc>
    80002428:	89aa                	mv	s3,a0
	if(p == initproc) {
    8000242a:	00009797          	auipc	a5,0x9
    8000242e:	bfe7b783          	ld	a5,-1026(a5) # 8000b028 <initproc>
    80002432:	0d050493          	addi	s1,a0,208
    80002436:	15050913          	addi	s2,a0,336
    8000243a:	02a79363          	bne	a5,a0,80002460 <_exit+0x52>
		panic("init exiting");
    8000243e:	00007517          	auipc	a0,0x7
    80002442:	e2250513          	addi	a0,a0,-478 # 80009260 <digits+0x220>
    80002446:	ffffe097          	auipc	ra,0xffffe
    8000244a:	21c080e7          	jalr	540(ra) # 80000662 <panic>
			fileclose(f);
    8000244e:	00001097          	auipc	ra,0x1
    80002452:	608080e7          	jalr	1544(ra) # 80003a56 <fileclose>
			p->ofile[fd] = 0;
    80002456:	0004b023          	sd	zero,0(s1)
	for(int fd = 0; fd < NOFILE; fd++) {
    8000245a:	04a1                	addi	s1,s1,8
    8000245c:	01248563          	beq	s1,s2,80002466 <_exit+0x58>
		if(p->ofile[fd]) {
    80002460:	6088                	ld	a0,0(s1)
    80002462:	f575                	bnez	a0,8000244e <_exit+0x40>
    80002464:	bfdd                	j	8000245a <_exit+0x4c>
	begin_op();
    80002466:	00001097          	auipc	ra,0x1
    8000246a:	11c080e7          	jalr	284(ra) # 80003582 <begin_op>
	p->cwd->inode_ops->iput(p->cwd);
    8000246e:	1509b503          	ld	a0,336(s3)
    80002472:	691c                	ld	a5,16(a0)
    80002474:	779c                	ld	a5,40(a5)
    80002476:	9782                	jalr	a5
	end_op();
    80002478:	00001097          	auipc	ra,0x1
    8000247c:	188080e7          	jalr	392(ra) # 80003600 <end_op>
	p->cwd = NULL;
    80002480:	1409b823          	sd	zero,336(s3)
	acquire(&wait_lock);
    80002484:	00011497          	auipc	s1,0x11
    80002488:	e3448493          	addi	s1,s1,-460 # 800132b8 <wait_lock>
    8000248c:	8526                	mv	a0,s1
    8000248e:	fffff097          	auipc	ra,0xfffff
    80002492:	86a080e7          	jalr	-1942(ra) # 80000cf8 <acquire>
	reparent(p);
    80002496:	854e                	mv	a0,s3
    80002498:	00000097          	auipc	ra,0x0
    8000249c:	f1c080e7          	jalr	-228(ra) # 800023b4 <reparent>
	wakeup(p->parent);
    800024a0:	0389b503          	ld	a0,56(s3)
    800024a4:	00000097          	auipc	ra,0x0
    800024a8:	e9a080e7          	jalr	-358(ra) # 8000233e <wakeup>
	acquire(&p->lock);
    800024ac:	854e                	mv	a0,s3
    800024ae:	fffff097          	auipc	ra,0xfffff
    800024b2:	84a080e7          	jalr	-1974(ra) # 80000cf8 <acquire>
	p->xstate = status;
    800024b6:	0349a623          	sw	s4,44(s3)
	p->state = ZOMBIE;
    800024ba:	4795                	li	a5,5
    800024bc:	00f9ac23          	sw	a5,24(s3)
	release(&wait_lock);
    800024c0:	8526                	mv	a0,s1
    800024c2:	fffff097          	auipc	ra,0xfffff
    800024c6:	8ea080e7          	jalr	-1814(ra) # 80000dac <release>
	sched();
    800024ca:	00000097          	auipc	ra,0x0
    800024ce:	bd6080e7          	jalr	-1066(ra) # 800020a0 <sched>
	panic("zombie exit");
    800024d2:	00007517          	auipc	a0,0x7
    800024d6:	d9e50513          	addi	a0,a0,-610 # 80009270 <digits+0x230>
    800024da:	ffffe097          	auipc	ra,0xffffe
    800024de:	188080e7          	jalr	392(ra) # 80000662 <panic>

00000000800024e2 <kill>:

// Kill the process with the given pid.
// The victim won't exit until it tries to return
// to user space (see usertrap() in trap.c).
int kill(int pid)
{
    800024e2:	7179                	addi	sp,sp,-48
    800024e4:	f406                	sd	ra,40(sp)
    800024e6:	f022                	sd	s0,32(sp)
    800024e8:	ec26                	sd	s1,24(sp)
    800024ea:	e84a                	sd	s2,16(sp)
    800024ec:	e44e                	sd	s3,8(sp)
    800024ee:	1800                	addi	s0,sp,48
    800024f0:	892a                	mv	s2,a0
	
	struct proc *p;

	for(p = proc; p < &proc[NPROC]; p++) {
    800024f2:	00011497          	auipc	s1,0x11
    800024f6:	1de48493          	addi	s1,s1,478 # 800136d0 <proc>
    800024fa:	00017997          	auipc	s3,0x17
    800024fe:	bd698993          	addi	s3,s3,-1066 # 800190d0 <tickslock>
		acquire(&p->lock);
    80002502:	8526                	mv	a0,s1
    80002504:	ffffe097          	auipc	ra,0xffffe
    80002508:	7f4080e7          	jalr	2036(ra) # 80000cf8 <acquire>

		if(p->pid == pid) {
    8000250c:	589c                	lw	a5,48(s1)
    8000250e:	01278d63          	beq	a5,s2,80002528 <kill+0x46>
			release(&p->lock);

			return 0;
		}

		release(&p->lock);
    80002512:	8526                	mv	a0,s1
    80002514:	fffff097          	auipc	ra,0xfffff
    80002518:	898080e7          	jalr	-1896(ra) # 80000dac <release>
	for(p = proc; p < &proc[NPROC]; p++) {
    8000251c:	16848493          	addi	s1,s1,360
    80002520:	ff3491e3          	bne	s1,s3,80002502 <kill+0x20>
	}

	return -1;
    80002524:	557d                	li	a0,-1
    80002526:	a829                	j	80002540 <kill+0x5e>
			p->killed = 1;
    80002528:	4785                	li	a5,1
    8000252a:	d49c                	sw	a5,40(s1)
			if(p->state == SLEEPING) {
    8000252c:	4c98                	lw	a4,24(s1)
    8000252e:	4789                	li	a5,2
    80002530:	00f70f63          	beq	a4,a5,8000254e <kill+0x6c>
			release(&p->lock);
    80002534:	8526                	mv	a0,s1
    80002536:	fffff097          	auipc	ra,0xfffff
    8000253a:	876080e7          	jalr	-1930(ra) # 80000dac <release>
			return 0;
    8000253e:	4501                	li	a0,0
}
    80002540:	70a2                	ld	ra,40(sp)
    80002542:	7402                	ld	s0,32(sp)
    80002544:	64e2                	ld	s1,24(sp)
    80002546:	6942                	ld	s2,16(sp)
    80002548:	69a2                	ld	s3,8(sp)
    8000254a:	6145                	addi	sp,sp,48
    8000254c:	8082                	ret
				p->state = RUNNABLE;
    8000254e:	478d                	li	a5,3
    80002550:	cc9c                	sw	a5,24(s1)
    80002552:	b7cd                	j	80002534 <kill+0x52>

0000000080002554 <either_copyout>:

// Copy to either a user address, or kernel address,
// depending on usr_dst.
// Returns 0 on success, -1 on error.
int either_copyout(int user_dst, uint64 dst, void * src, uint64 len)
{
    80002554:	7179                	addi	sp,sp,-48
    80002556:	f406                	sd	ra,40(sp)
    80002558:	f022                	sd	s0,32(sp)
    8000255a:	ec26                	sd	s1,24(sp)
    8000255c:	e84a                	sd	s2,16(sp)
    8000255e:	e44e                	sd	s3,8(sp)
    80002560:	e052                	sd	s4,0(sp)
    80002562:	1800                	addi	s0,sp,48
    80002564:	84aa                	mv	s1,a0
    80002566:	892e                	mv	s2,a1
    80002568:	89b2                	mv	s3,a2
    8000256a:	8a36                	mv	s4,a3
	struct proc * p = myproc();
    8000256c:	fffff097          	auipc	ra,0xfffff
    80002570:	578080e7          	jalr	1400(ra) # 80001ae4 <myproc>

	if(user_dst) {
    80002574:	c08d                	beqz	s1,80002596 <either_copyout+0x42>
		return copyout(p->pagetable, dst, src, len);
    80002576:	86d2                	mv	a3,s4
    80002578:	864e                	mv	a2,s3
    8000257a:	85ca                	mv	a1,s2
    8000257c:	6928                	ld	a0,80(a0)
    8000257e:	fffff097          	auipc	ra,0xfffff
    80002582:	22a080e7          	jalr	554(ra) # 800017a8 <copyout>
	} else {
		kmemmove((char *)dst, src, len);

		return 0;
	}
}
    80002586:	70a2                	ld	ra,40(sp)
    80002588:	7402                	ld	s0,32(sp)
    8000258a:	64e2                	ld	s1,24(sp)
    8000258c:	6942                	ld	s2,16(sp)
    8000258e:	69a2                	ld	s3,8(sp)
    80002590:	6a02                	ld	s4,0(sp)
    80002592:	6145                	addi	sp,sp,48
    80002594:	8082                	ret
		kmemmove((char *)dst, src, len);
    80002596:	000a061b          	sext.w	a2,s4
    8000259a:	85ce                	mv	a1,s3
    8000259c:	854a                	mv	a0,s2
    8000259e:	fffff097          	auipc	ra,0xfffff
    800025a2:	8b2080e7          	jalr	-1870(ra) # 80000e50 <kmemmove>
		return 0;
    800025a6:	8526                	mv	a0,s1
    800025a8:	bff9                	j	80002586 <either_copyout+0x32>

00000000800025aa <either_copyin>:

// Copy from either a user address, or kernel address,
// depending on usr_src.
// Returns 0 on success, -1 on error.
int either_copyin(void * dst, int user_src, uint64 src, uint64 len)
{
    800025aa:	7179                	addi	sp,sp,-48
    800025ac:	f406                	sd	ra,40(sp)
    800025ae:	f022                	sd	s0,32(sp)
    800025b0:	ec26                	sd	s1,24(sp)
    800025b2:	e84a                	sd	s2,16(sp)
    800025b4:	e44e                	sd	s3,8(sp)
    800025b6:	e052                	sd	s4,0(sp)
    800025b8:	1800                	addi	s0,sp,48
    800025ba:	892a                	mv	s2,a0
    800025bc:	84ae                	mv	s1,a1
    800025be:	89b2                	mv	s3,a2
    800025c0:	8a36                	mv	s4,a3
	struct proc * p = myproc();
    800025c2:	fffff097          	auipc	ra,0xfffff
    800025c6:	522080e7          	jalr	1314(ra) # 80001ae4 <myproc>

	if(user_src) {
    800025ca:	c08d                	beqz	s1,800025ec <either_copyin+0x42>
		return copyin(p->pagetable, dst, src, len);
    800025cc:	86d2                	mv	a3,s4
    800025ce:	864e                	mv	a2,s3
    800025d0:	85ca                	mv	a1,s2
    800025d2:	6928                	ld	a0,80(a0)
    800025d4:	fffff097          	auipc	ra,0xfffff
    800025d8:	260080e7          	jalr	608(ra) # 80001834 <copyin>
	} else {
		kmemmove(dst, (char*)src, len);

		return 0;
	}
}
    800025dc:	70a2                	ld	ra,40(sp)
    800025de:	7402                	ld	s0,32(sp)
    800025e0:	64e2                	ld	s1,24(sp)
    800025e2:	6942                	ld	s2,16(sp)
    800025e4:	69a2                	ld	s3,8(sp)
    800025e6:	6a02                	ld	s4,0(sp)
    800025e8:	6145                	addi	sp,sp,48
    800025ea:	8082                	ret
		kmemmove(dst, (char*)src, len);
    800025ec:	000a061b          	sext.w	a2,s4
    800025f0:	85ce                	mv	a1,s3
    800025f2:	854a                	mv	a0,s2
    800025f4:	fffff097          	auipc	ra,0xfffff
    800025f8:	85c080e7          	jalr	-1956(ra) # 80000e50 <kmemmove>
		return 0;
    800025fc:	8526                	mv	a0,s1
    800025fe:	bff9                	j	800025dc <either_copyin+0x32>

0000000080002600 <procdump>:

// Print a process listing to console.	For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void procdump(void)
{
    80002600:	1141                	addi	sp,sp,-16
    80002602:	e422                	sd	s0,8(sp)
    80002604:	0800                	addi	s0,sp,16
    80002606:	04000793          	li	a5,64
	struct proc * p;
	char * state;

	

	for(p = proc; p < &proc[NPROC]; p++) {
    8000260a:	17fd                	addi	a5,a5,-1
    8000260c:	fffd                	bnez	a5,8000260a <procdump+0xa>
		}

		
		
	}
}
    8000260e:	6422                	ld	s0,8(sp)
    80002610:	0141                	addi	sp,sp,16
    80002612:	8082                	ret

0000000080002614 <trapinit>:

extern int devintr();

void
trapinit(void)
{
    80002614:	1141                	addi	sp,sp,-16
    80002616:	e406                	sd	ra,8(sp)
    80002618:	e022                	sd	s0,0(sp)
    8000261a:	0800                	addi	s0,sp,16
  initlock(&tickslock, "time");
    8000261c:	00007597          	auipc	a1,0x7
    80002620:	c6458593          	addi	a1,a1,-924 # 80009280 <digits+0x240>
    80002624:	00017517          	auipc	a0,0x17
    80002628:	aac50513          	addi	a0,a0,-1364 # 800190d0 <tickslock>
    8000262c:	ffffe097          	auipc	ra,0xffffe
    80002630:	63c080e7          	jalr	1596(ra) # 80000c68 <initlock>
}
    80002634:	60a2                	ld	ra,8(sp)
    80002636:	6402                	ld	s0,0(sp)
    80002638:	0141                	addi	sp,sp,16
    8000263a:	8082                	ret

000000008000263c <trapinithart>:

// set up to take exceptions and traps while in the kernel.
void
trapinithart(void)
{
    8000263c:	1141                	addi	sp,sp,-16
    8000263e:	e422                	sd	s0,8(sp)
    80002640:	0800                	addi	s0,sp,16
  asm volatile("csrw stvec, %0" : : "r" (x));
    80002642:	ffffe797          	auipc	a5,0xffffe
    80002646:	9de78793          	addi	a5,a5,-1570 # 80000020 <kernelvec>
    8000264a:	10579073          	csrw	stvec,a5
  w_stvec((uint64)kernelvec);
}
    8000264e:	6422                	ld	s0,8(sp)
    80002650:	0141                	addi	sp,sp,16
    80002652:	8082                	ret

0000000080002654 <usertrapret>:
//
// return to user space
//
void
usertrapret(void)
{
    80002654:	1141                	addi	sp,sp,-16
    80002656:	e406                	sd	ra,8(sp)
    80002658:	e022                	sd	s0,0(sp)
    8000265a:	0800                	addi	s0,sp,16
  struct proc *p = myproc();
    8000265c:	fffff097          	auipc	ra,0xfffff
    80002660:	488080e7          	jalr	1160(ra) # 80001ae4 <myproc>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80002664:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() & ~SSTATUS_SIE);
    80002668:	9bf5                	andi	a5,a5,-3
  asm volatile("csrw sstatus, %0" : : "r" (x));
    8000266a:	10079073          	csrw	sstatus,a5
  // kerneltrap() to usertrap(), so turn off interrupts until
  // we're back in user space, where usertrap() is correct.
  intr_off();

  // send syscalls, interrupts, and exceptions to trampoline.S
  w_stvec(TRAMPOLINE + (uservec - trampoline));
    8000266e:	00006697          	auipc	a3,0x6
    80002672:	99268693          	addi	a3,a3,-1646 # 80008000 <_trampoline>
    80002676:	00006717          	auipc	a4,0x6
    8000267a:	98a70713          	addi	a4,a4,-1654 # 80008000 <_trampoline>
    8000267e:	8f15                	sub	a4,a4,a3
    80002680:	040007b7          	lui	a5,0x4000
    80002684:	17fd                	addi	a5,a5,-1
    80002686:	07b2                	slli	a5,a5,0xc
    80002688:	973e                	add	a4,a4,a5
  asm volatile("csrw stvec, %0" : : "r" (x));
    8000268a:	10571073          	csrw	stvec,a4

  // set up trapframe values that uservec will need when
  // the process next re-enters the kernel.
  p->trapframe->kernel_satp = r_satp();         // kernel page table
    8000268e:	6d38                	ld	a4,88(a0)
  asm volatile("csrr %0, satp" : "=r" (x) );
    80002690:	18002673          	csrr	a2,satp
    80002694:	e310                	sd	a2,0(a4)
  p->trapframe->kernel_sp = p->kstack + PGSIZE; // process's kernel stack
    80002696:	6d30                	ld	a2,88(a0)
    80002698:	6138                	ld	a4,64(a0)
    8000269a:	6585                	lui	a1,0x1
    8000269c:	972e                	add	a4,a4,a1
    8000269e:	e618                	sd	a4,8(a2)
  p->trapframe->kernel_trap = (uint64)usertrap;
    800026a0:	6d38                	ld	a4,88(a0)
    800026a2:	00000617          	auipc	a2,0x0
    800026a6:	13860613          	addi	a2,a2,312 # 800027da <usertrap>
    800026aa:	eb10                	sd	a2,16(a4)
  p->trapframe->kernel_hartid = r_tp();         // hartid for cpuid()
    800026ac:	6d38                	ld	a4,88(a0)
  asm volatile("mv %0, tp" : "=r" (x) );
    800026ae:	8612                	mv	a2,tp
    800026b0:	f310                	sd	a2,32(a4)
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    800026b2:	10002773          	csrr	a4,sstatus
  // set up the registers that trampoline.S's sret will use
  // to get to user space.
  
  // set S Previous Privilege mode to User.
  unsigned long x = r_sstatus();
  x &= ~SSTATUS_SPP; // clear SPP to 0 for user mode
    800026b6:	eff77713          	andi	a4,a4,-257
  x |= SSTATUS_SPIE; // enable interrupts in user mode
    800026ba:	02076713          	ori	a4,a4,32
  asm volatile("csrw sstatus, %0" : : "r" (x));
    800026be:	10071073          	csrw	sstatus,a4
  w_sstatus(x);

  // set S Exception Program Counter to the saved user pc.
  w_sepc(p->trapframe->epc);
    800026c2:	6d38                	ld	a4,88(a0)
  asm volatile("csrw sepc, %0" : : "r" (x));
    800026c4:	6f18                	ld	a4,24(a4)
    800026c6:	14171073          	csrw	sepc,a4

  // tell trampoline.S the user page table to switch to.
  uint64 satp = MAKE_SATP(p->pagetable);
    800026ca:	692c                	ld	a1,80(a0)
    800026cc:	81b1                	srli	a1,a1,0xc

  // jump to trampoline.S at the top of memory, which 
  // switches to the user page table, restores user registers,
  // and switches to user mode with sret.
  uint64 fn = TRAMPOLINE + (userret - trampoline);
    800026ce:	00006717          	auipc	a4,0x6
    800026d2:	9c270713          	addi	a4,a4,-1598 # 80008090 <userret>
    800026d6:	8f15                	sub	a4,a4,a3
    800026d8:	97ba                	add	a5,a5,a4
  ((void (*)(uint64,uint64))fn)(TRAPFRAME, satp);
    800026da:	577d                	li	a4,-1
    800026dc:	177e                	slli	a4,a4,0x3f
    800026de:	8dd9                	or	a1,a1,a4
    800026e0:	02000537          	lui	a0,0x2000
    800026e4:	157d                	addi	a0,a0,-1
    800026e6:	0536                	slli	a0,a0,0xd
    800026e8:	9782                	jalr	a5
}
    800026ea:	60a2                	ld	ra,8(sp)
    800026ec:	6402                	ld	s0,0(sp)
    800026ee:	0141                	addi	sp,sp,16
    800026f0:	8082                	ret

00000000800026f2 <clockintr>:
  w_sstatus(sstatus);
}

void
clockintr()
{
    800026f2:	1101                	addi	sp,sp,-32
    800026f4:	ec06                	sd	ra,24(sp)
    800026f6:	e822                	sd	s0,16(sp)
    800026f8:	e426                	sd	s1,8(sp)
    800026fa:	1000                	addi	s0,sp,32
  acquire(&tickslock);
    800026fc:	00017497          	auipc	s1,0x17
    80002700:	9d448493          	addi	s1,s1,-1580 # 800190d0 <tickslock>
    80002704:	8526                	mv	a0,s1
    80002706:	ffffe097          	auipc	ra,0xffffe
    8000270a:	5f2080e7          	jalr	1522(ra) # 80000cf8 <acquire>
  ticks++;
    8000270e:	00009517          	auipc	a0,0x9
    80002712:	92250513          	addi	a0,a0,-1758 # 8000b030 <ticks>
    80002716:	411c                	lw	a5,0(a0)
    80002718:	2785                	addiw	a5,a5,1
    8000271a:	c11c                	sw	a5,0(a0)
  wakeup(&ticks);
    8000271c:	00000097          	auipc	ra,0x0
    80002720:	c22080e7          	jalr	-990(ra) # 8000233e <wakeup>
  release(&tickslock);
    80002724:	8526                	mv	a0,s1
    80002726:	ffffe097          	auipc	ra,0xffffe
    8000272a:	686080e7          	jalr	1670(ra) # 80000dac <release>
}
    8000272e:	60e2                	ld	ra,24(sp)
    80002730:	6442                	ld	s0,16(sp)
    80002732:	64a2                	ld	s1,8(sp)
    80002734:	6105                	addi	sp,sp,32
    80002736:	8082                	ret

0000000080002738 <devintr>:
// returns 2 if timer interrupt,
// 1 if other device,
// 0 if not recognized.
int
devintr()
{
    80002738:	1101                	addi	sp,sp,-32
    8000273a:	ec06                	sd	ra,24(sp)
    8000273c:	e822                	sd	s0,16(sp)
    8000273e:	e426                	sd	s1,8(sp)
    80002740:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, scause" : "=r" (x) );
    80002742:	14202773          	csrr	a4,scause
  uint64 scause = r_scause();

  if((scause & 0x8000000000000000L) &&
    80002746:	00074d63          	bltz	a4,80002760 <devintr+0x28>
    // now allowed to interrupt again.
    if(irq)
      plic_complete(irq);

    return 1;
  } else if(scause == 0x8000000000000001L){
    8000274a:	57fd                	li	a5,-1
    8000274c:	17fe                	slli	a5,a5,0x3f
    8000274e:	0785                	addi	a5,a5,1
    // the SSIP bit in sip.
    w_sip(r_sip() & ~2);

    return 2;
  } else {
    return 0;
    80002750:	4501                	li	a0,0
  } else if(scause == 0x8000000000000001L){
    80002752:	06f70363          	beq	a4,a5,800027b8 <devintr+0x80>
  }
}
    80002756:	60e2                	ld	ra,24(sp)
    80002758:	6442                	ld	s0,16(sp)
    8000275a:	64a2                	ld	s1,8(sp)
    8000275c:	6105                	addi	sp,sp,32
    8000275e:	8082                	ret
     (scause & 0xff) == 9){
    80002760:	0ff77793          	zext.b	a5,a4
  if((scause & 0x8000000000000000L) &&
    80002764:	46a5                	li	a3,9
    80002766:	fed792e3          	bne	a5,a3,8000274a <devintr+0x12>
    int irq = plic_claim();
    8000276a:	00003097          	auipc	ra,0x3
    8000276e:	912080e7          	jalr	-1774(ra) # 8000507c <plic_claim>
    80002772:	84aa                	mv	s1,a0
    if(irq == UART0_IRQ){
    80002774:	47a9                	li	a5,10
    80002776:	02f50763          	beq	a0,a5,800027a4 <devintr+0x6c>
    } else if(irq == VIRTIO0_IRQ){
    8000277a:	4785                	li	a5,1
    8000277c:	02f50963          	beq	a0,a5,800027ae <devintr+0x76>
    return 1;
    80002780:	4505                	li	a0,1
    } else if(irq){
    80002782:	d8f1                	beqz	s1,80002756 <devintr+0x1e>
      kprintf("unexpected interrupt irq=%d\n", irq);
    80002784:	85a6                	mv	a1,s1
    80002786:	00007517          	auipc	a0,0x7
    8000278a:	b0250513          	addi	a0,a0,-1278 # 80009288 <digits+0x248>
    8000278e:	ffffe097          	auipc	ra,0xffffe
    80002792:	f1e080e7          	jalr	-226(ra) # 800006ac <kprintf>
      plic_complete(irq);
    80002796:	8526                	mv	a0,s1
    80002798:	00003097          	auipc	ra,0x3
    8000279c:	908080e7          	jalr	-1784(ra) # 800050a0 <plic_complete>
    return 1;
    800027a0:	4505                	li	a0,1
    800027a2:	bf55                	j	80002756 <devintr+0x1e>
      uartintr();
    800027a4:	ffffe097          	auipc	ra,0xffffe
    800027a8:	316080e7          	jalr	790(ra) # 80000aba <uartintr>
    800027ac:	b7ed                	j	80002796 <devintr+0x5e>
      virtio_disk_intr();
    800027ae:	00003097          	auipc	ra,0x3
    800027b2:	d7e080e7          	jalr	-642(ra) # 8000552c <virtio_disk_intr>
    800027b6:	b7c5                	j	80002796 <devintr+0x5e>
    if(cpuid() == 0){
    800027b8:	fffff097          	auipc	ra,0xfffff
    800027bc:	300080e7          	jalr	768(ra) # 80001ab8 <cpuid>
    800027c0:	c901                	beqz	a0,800027d0 <devintr+0x98>
  asm volatile("csrr %0, sip" : "=r" (x) );
    800027c2:	144027f3          	csrr	a5,sip
    w_sip(r_sip() & ~2);
    800027c6:	9bf5                	andi	a5,a5,-3
  asm volatile("csrw sip, %0" : : "r" (x));
    800027c8:	14479073          	csrw	sip,a5
    return 2;
    800027cc:	4509                	li	a0,2
    800027ce:	b761                	j	80002756 <devintr+0x1e>
      clockintr();
    800027d0:	00000097          	auipc	ra,0x0
    800027d4:	f22080e7          	jalr	-222(ra) # 800026f2 <clockintr>
    800027d8:	b7ed                	j	800027c2 <devintr+0x8a>

00000000800027da <usertrap>:
{
    800027da:	1101                	addi	sp,sp,-32
    800027dc:	ec06                	sd	ra,24(sp)
    800027de:	e822                	sd	s0,16(sp)
    800027e0:	e426                	sd	s1,8(sp)
    800027e2:	e04a                	sd	s2,0(sp)
    800027e4:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    800027e6:	100027f3          	csrr	a5,sstatus
  if((r_sstatus() & SSTATUS_SPP) != 0)
    800027ea:	1007f793          	andi	a5,a5,256
    800027ee:	e3ad                	bnez	a5,80002850 <usertrap+0x76>
  asm volatile("csrw stvec, %0" : : "r" (x));
    800027f0:	ffffe797          	auipc	a5,0xffffe
    800027f4:	83078793          	addi	a5,a5,-2000 # 80000020 <kernelvec>
    800027f8:	10579073          	csrw	stvec,a5
  struct proc *p = myproc();
    800027fc:	fffff097          	auipc	ra,0xfffff
    80002800:	2e8080e7          	jalr	744(ra) # 80001ae4 <myproc>
    80002804:	84aa                	mv	s1,a0
  p->trapframe->epc = r_sepc();
    80002806:	6d3c                	ld	a5,88(a0)
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80002808:	14102773          	csrr	a4,sepc
    8000280c:	ef98                	sd	a4,24(a5)
  asm volatile("csrr %0, scause" : "=r" (x) );
    8000280e:	14202773          	csrr	a4,scause
  if(r_scause() == 8){
    80002812:	47a1                	li	a5,8
    80002814:	04f71c63          	bne	a4,a5,8000286c <usertrap+0x92>
    if(p->killed)
    80002818:	551c                	lw	a5,40(a0)
    8000281a:	e3b9                	bnez	a5,80002860 <usertrap+0x86>
    p->trapframe->epc += 4;
    8000281c:	6cb8                	ld	a4,88(s1)
    8000281e:	6f1c                	ld	a5,24(a4)
    80002820:	0791                	addi	a5,a5,4
    80002822:	ef1c                	sd	a5,24(a4)
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80002824:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    80002828:	0027e793          	ori	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    8000282c:	10079073          	csrw	sstatus,a5
    syscall();
    80002830:	00000097          	auipc	ra,0x0
    80002834:	2e0080e7          	jalr	736(ra) # 80002b10 <syscall>
  if(p->killed)
    80002838:	549c                	lw	a5,40(s1)
    8000283a:	ebc1                	bnez	a5,800028ca <usertrap+0xf0>
  usertrapret();
    8000283c:	00000097          	auipc	ra,0x0
    80002840:	e18080e7          	jalr	-488(ra) # 80002654 <usertrapret>
}
    80002844:	60e2                	ld	ra,24(sp)
    80002846:	6442                	ld	s0,16(sp)
    80002848:	64a2                	ld	s1,8(sp)
    8000284a:	6902                	ld	s2,0(sp)
    8000284c:	6105                	addi	sp,sp,32
    8000284e:	8082                	ret
    panic("usertrap: not from user mode");
    80002850:	00007517          	auipc	a0,0x7
    80002854:	a5850513          	addi	a0,a0,-1448 # 800092a8 <digits+0x268>
    80002858:	ffffe097          	auipc	ra,0xffffe
    8000285c:	e0a080e7          	jalr	-502(ra) # 80000662 <panic>
      _exit(-1);
    80002860:	557d                	li	a0,-1
    80002862:	00000097          	auipc	ra,0x0
    80002866:	bac080e7          	jalr	-1108(ra) # 8000240e <_exit>
    8000286a:	bf4d                	j	8000281c <usertrap+0x42>
  } else if((which_dev = devintr()) != 0){
    8000286c:	00000097          	auipc	ra,0x0
    80002870:	ecc080e7          	jalr	-308(ra) # 80002738 <devintr>
    80002874:	892a                	mv	s2,a0
    80002876:	c501                	beqz	a0,8000287e <usertrap+0xa4>
  if(p->killed)
    80002878:	549c                	lw	a5,40(s1)
    8000287a:	c3a1                	beqz	a5,800028ba <usertrap+0xe0>
    8000287c:	a815                	j	800028b0 <usertrap+0xd6>
  asm volatile("csrr %0, scause" : "=r" (x) );
    8000287e:	142025f3          	csrr	a1,scause
    kprintf("usertrap(): unexpected scause %p pid=%d\n", r_scause(), p->pid);
    80002882:	5890                	lw	a2,48(s1)
    80002884:	00007517          	auipc	a0,0x7
    80002888:	a4450513          	addi	a0,a0,-1468 # 800092c8 <digits+0x288>
    8000288c:	ffffe097          	auipc	ra,0xffffe
    80002890:	e20080e7          	jalr	-480(ra) # 800006ac <kprintf>
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80002894:	141025f3          	csrr	a1,sepc
  asm volatile("csrr %0, stval" : "=r" (x) );
    80002898:	14302673          	csrr	a2,stval
    kprintf("            sepc=%p stval=%p\n", r_sepc(), r_stval());
    8000289c:	00007517          	auipc	a0,0x7
    800028a0:	a5c50513          	addi	a0,a0,-1444 # 800092f8 <digits+0x2b8>
    800028a4:	ffffe097          	auipc	ra,0xffffe
    800028a8:	e08080e7          	jalr	-504(ra) # 800006ac <kprintf>
    p->killed = 1;
    800028ac:	4785                	li	a5,1
    800028ae:	d49c                	sw	a5,40(s1)
    _exit(-1);
    800028b0:	557d                	li	a0,-1
    800028b2:	00000097          	auipc	ra,0x0
    800028b6:	b5c080e7          	jalr	-1188(ra) # 8000240e <_exit>
  if(which_dev == 2)
    800028ba:	4789                	li	a5,2
    800028bc:	f8f910e3          	bne	s2,a5,8000283c <usertrap+0x62>
    yield();
    800028c0:	00000097          	auipc	ra,0x0
    800028c4:	8b6080e7          	jalr	-1866(ra) # 80002176 <yield>
    800028c8:	bf95                	j	8000283c <usertrap+0x62>
  int which_dev = 0;
    800028ca:	4901                	li	s2,0
    800028cc:	b7d5                	j	800028b0 <usertrap+0xd6>

00000000800028ce <kerneltrap>:
{
    800028ce:	7179                	addi	sp,sp,-48
    800028d0:	f406                	sd	ra,40(sp)
    800028d2:	f022                	sd	s0,32(sp)
    800028d4:	ec26                	sd	s1,24(sp)
    800028d6:	e84a                	sd	s2,16(sp)
    800028d8:	e44e                	sd	s3,8(sp)
    800028da:	1800                	addi	s0,sp,48
  asm volatile("csrr %0, sepc" : "=r" (x) );
    800028dc:	14102973          	csrr	s2,sepc
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    800028e0:	100024f3          	csrr	s1,sstatus
  asm volatile("csrr %0, scause" : "=r" (x) );
    800028e4:	142029f3          	csrr	s3,scause
  if((sstatus & SSTATUS_SPP) == 0)
    800028e8:	1004f793          	andi	a5,s1,256
    800028ec:	cb85                	beqz	a5,8000291c <kerneltrap+0x4e>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    800028ee:	100027f3          	csrr	a5,sstatus
  return (x & SSTATUS_SIE) != 0;
    800028f2:	8b89                	andi	a5,a5,2
  if(intr_get() != 0)
    800028f4:	ef85                	bnez	a5,8000292c <kerneltrap+0x5e>
  if((which_dev = devintr()) == 0){
    800028f6:	00000097          	auipc	ra,0x0
    800028fa:	e42080e7          	jalr	-446(ra) # 80002738 <devintr>
    800028fe:	cd1d                	beqz	a0,8000293c <kerneltrap+0x6e>
  if(which_dev == 2 && myproc() != 0 && myproc()->state == RUNNING)
    80002900:	4789                	li	a5,2
    80002902:	06f50a63          	beq	a0,a5,80002976 <kerneltrap+0xa8>
  asm volatile("csrw sepc, %0" : : "r" (x));
    80002906:	14191073          	csrw	sepc,s2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    8000290a:	10049073          	csrw	sstatus,s1
}
    8000290e:	70a2                	ld	ra,40(sp)
    80002910:	7402                	ld	s0,32(sp)
    80002912:	64e2                	ld	s1,24(sp)
    80002914:	6942                	ld	s2,16(sp)
    80002916:	69a2                	ld	s3,8(sp)
    80002918:	6145                	addi	sp,sp,48
    8000291a:	8082                	ret
    panic("kerneltrap: not from supervisor mode");
    8000291c:	00007517          	auipc	a0,0x7
    80002920:	9fc50513          	addi	a0,a0,-1540 # 80009318 <digits+0x2d8>
    80002924:	ffffe097          	auipc	ra,0xffffe
    80002928:	d3e080e7          	jalr	-706(ra) # 80000662 <panic>
    panic("kerneltrap: interrupts enabled");
    8000292c:	00007517          	auipc	a0,0x7
    80002930:	a1450513          	addi	a0,a0,-1516 # 80009340 <digits+0x300>
    80002934:	ffffe097          	auipc	ra,0xffffe
    80002938:	d2e080e7          	jalr	-722(ra) # 80000662 <panic>
    kprintf("scause %p\n", scause);
    8000293c:	85ce                	mv	a1,s3
    8000293e:	00007517          	auipc	a0,0x7
    80002942:	a2250513          	addi	a0,a0,-1502 # 80009360 <digits+0x320>
    80002946:	ffffe097          	auipc	ra,0xffffe
    8000294a:	d66080e7          	jalr	-666(ra) # 800006ac <kprintf>
  asm volatile("csrr %0, sepc" : "=r" (x) );
    8000294e:	141025f3          	csrr	a1,sepc
  asm volatile("csrr %0, stval" : "=r" (x) );
    80002952:	14302673          	csrr	a2,stval
    kprintf("sepc=%p stval=%p\n", r_sepc(), r_stval());
    80002956:	00007517          	auipc	a0,0x7
    8000295a:	a1a50513          	addi	a0,a0,-1510 # 80009370 <digits+0x330>
    8000295e:	ffffe097          	auipc	ra,0xffffe
    80002962:	d4e080e7          	jalr	-690(ra) # 800006ac <kprintf>
    panic("kerneltrap");
    80002966:	00007517          	auipc	a0,0x7
    8000296a:	a2250513          	addi	a0,a0,-1502 # 80009388 <digits+0x348>
    8000296e:	ffffe097          	auipc	ra,0xffffe
    80002972:	cf4080e7          	jalr	-780(ra) # 80000662 <panic>
  if(which_dev == 2 && myproc() != 0 && myproc()->state == RUNNING)
    80002976:	fffff097          	auipc	ra,0xfffff
    8000297a:	16e080e7          	jalr	366(ra) # 80001ae4 <myproc>
    8000297e:	d541                	beqz	a0,80002906 <kerneltrap+0x38>
    80002980:	fffff097          	auipc	ra,0xfffff
    80002984:	164080e7          	jalr	356(ra) # 80001ae4 <myproc>
    80002988:	4d18                	lw	a4,24(a0)
    8000298a:	4791                	li	a5,4
    8000298c:	f6f71de3          	bne	a4,a5,80002906 <kerneltrap+0x38>
    yield();
    80002990:	fffff097          	auipc	ra,0xfffff
    80002994:	7e6080e7          	jalr	2022(ra) # 80002176 <yield>
    80002998:	b7bd                	j	80002906 <kerneltrap+0x38>

000000008000299a <argraw>:
  return kstrlen(buf);
}

static uint64
argraw(int n)
{
    8000299a:	1101                	addi	sp,sp,-32
    8000299c:	ec06                	sd	ra,24(sp)
    8000299e:	e822                	sd	s0,16(sp)
    800029a0:	e426                	sd	s1,8(sp)
    800029a2:	1000                	addi	s0,sp,32
    800029a4:	84aa                	mv	s1,a0
  struct proc *p = myproc();
    800029a6:	fffff097          	auipc	ra,0xfffff
    800029aa:	13e080e7          	jalr	318(ra) # 80001ae4 <myproc>
  switch (n) {
    800029ae:	4795                	li	a5,5
    800029b0:	0497e163          	bltu	a5,s1,800029f2 <argraw+0x58>
    800029b4:	048a                	slli	s1,s1,0x2
    800029b6:	00007717          	auipc	a4,0x7
    800029ba:	a0a70713          	addi	a4,a4,-1526 # 800093c0 <digits+0x380>
    800029be:	94ba                	add	s1,s1,a4
    800029c0:	409c                	lw	a5,0(s1)
    800029c2:	97ba                	add	a5,a5,a4
    800029c4:	8782                	jr	a5
  case 0:
    return p->trapframe->a0;
    800029c6:	6d3c                	ld	a5,88(a0)
    800029c8:	7ba8                	ld	a0,112(a5)
  case 5:
    return p->trapframe->a5;
  }
  panic("argraw");
  return -1;
}
    800029ca:	60e2                	ld	ra,24(sp)
    800029cc:	6442                	ld	s0,16(sp)
    800029ce:	64a2                	ld	s1,8(sp)
    800029d0:	6105                	addi	sp,sp,32
    800029d2:	8082                	ret
    return p->trapframe->a1;
    800029d4:	6d3c                	ld	a5,88(a0)
    800029d6:	7fa8                	ld	a0,120(a5)
    800029d8:	bfcd                	j	800029ca <argraw+0x30>
    return p->trapframe->a2;
    800029da:	6d3c                	ld	a5,88(a0)
    800029dc:	63c8                	ld	a0,128(a5)
    800029de:	b7f5                	j	800029ca <argraw+0x30>
    return p->trapframe->a3;
    800029e0:	6d3c                	ld	a5,88(a0)
    800029e2:	67c8                	ld	a0,136(a5)
    800029e4:	b7dd                	j	800029ca <argraw+0x30>
    return p->trapframe->a4;
    800029e6:	6d3c                	ld	a5,88(a0)
    800029e8:	6bc8                	ld	a0,144(a5)
    800029ea:	b7c5                	j	800029ca <argraw+0x30>
    return p->trapframe->a5;
    800029ec:	6d3c                	ld	a5,88(a0)
    800029ee:	6fc8                	ld	a0,152(a5)
    800029f0:	bfe9                	j	800029ca <argraw+0x30>
  panic("argraw");
    800029f2:	00007517          	auipc	a0,0x7
    800029f6:	9a650513          	addi	a0,a0,-1626 # 80009398 <digits+0x358>
    800029fa:	ffffe097          	auipc	ra,0xffffe
    800029fe:	c68080e7          	jalr	-920(ra) # 80000662 <panic>

0000000080002a02 <fetchaddr>:
{
    80002a02:	1101                	addi	sp,sp,-32
    80002a04:	ec06                	sd	ra,24(sp)
    80002a06:	e822                	sd	s0,16(sp)
    80002a08:	e426                	sd	s1,8(sp)
    80002a0a:	e04a                	sd	s2,0(sp)
    80002a0c:	1000                	addi	s0,sp,32
    80002a0e:	84aa                	mv	s1,a0
    80002a10:	892e                	mv	s2,a1
  struct proc *p = myproc();
    80002a12:	fffff097          	auipc	ra,0xfffff
    80002a16:	0d2080e7          	jalr	210(ra) # 80001ae4 <myproc>
  if(addr >= p->sz || addr+sizeof(uint64) > p->sz)
    80002a1a:	653c                	ld	a5,72(a0)
    80002a1c:	02f4f863          	bgeu	s1,a5,80002a4c <fetchaddr+0x4a>
    80002a20:	00848713          	addi	a4,s1,8
    80002a24:	02e7e663          	bltu	a5,a4,80002a50 <fetchaddr+0x4e>
  if(copyin(p->pagetable, (char *)ip, addr, sizeof(*ip)) != 0)
    80002a28:	46a1                	li	a3,8
    80002a2a:	8626                	mv	a2,s1
    80002a2c:	85ca                	mv	a1,s2
    80002a2e:	6928                	ld	a0,80(a0)
    80002a30:	fffff097          	auipc	ra,0xfffff
    80002a34:	e04080e7          	jalr	-508(ra) # 80001834 <copyin>
    80002a38:	00a03533          	snez	a0,a0
    80002a3c:	40a00533          	neg	a0,a0
}
    80002a40:	60e2                	ld	ra,24(sp)
    80002a42:	6442                	ld	s0,16(sp)
    80002a44:	64a2                	ld	s1,8(sp)
    80002a46:	6902                	ld	s2,0(sp)
    80002a48:	6105                	addi	sp,sp,32
    80002a4a:	8082                	ret
    return -1;
    80002a4c:	557d                	li	a0,-1
    80002a4e:	bfcd                	j	80002a40 <fetchaddr+0x3e>
    80002a50:	557d                	li	a0,-1
    80002a52:	b7fd                	j	80002a40 <fetchaddr+0x3e>

0000000080002a54 <fetchstr>:
{
    80002a54:	7179                	addi	sp,sp,-48
    80002a56:	f406                	sd	ra,40(sp)
    80002a58:	f022                	sd	s0,32(sp)
    80002a5a:	ec26                	sd	s1,24(sp)
    80002a5c:	e84a                	sd	s2,16(sp)
    80002a5e:	e44e                	sd	s3,8(sp)
    80002a60:	1800                	addi	s0,sp,48
    80002a62:	892a                	mv	s2,a0
    80002a64:	84ae                	mv	s1,a1
    80002a66:	89b2                	mv	s3,a2
  struct proc *p = myproc();
    80002a68:	fffff097          	auipc	ra,0xfffff
    80002a6c:	07c080e7          	jalr	124(ra) # 80001ae4 <myproc>
  int err = copyinstr(p->pagetable, buf, addr, max);
    80002a70:	86ce                	mv	a3,s3
    80002a72:	864a                	mv	a2,s2
    80002a74:	85a6                	mv	a1,s1
    80002a76:	6928                	ld	a0,80(a0)
    80002a78:	fffff097          	auipc	ra,0xfffff
    80002a7c:	e4a080e7          	jalr	-438(ra) # 800018c2 <copyinstr>
  if(err < 0)
    80002a80:	00054763          	bltz	a0,80002a8e <fetchstr+0x3a>
  return kstrlen(buf);
    80002a84:	8526                	mv	a0,s1
    80002a86:	ffffe097          	auipc	ra,0xffffe
    80002a8a:	4ea080e7          	jalr	1258(ra) # 80000f70 <kstrlen>
}
    80002a8e:	70a2                	ld	ra,40(sp)
    80002a90:	7402                	ld	s0,32(sp)
    80002a92:	64e2                	ld	s1,24(sp)
    80002a94:	6942                	ld	s2,16(sp)
    80002a96:	69a2                	ld	s3,8(sp)
    80002a98:	6145                	addi	sp,sp,48
    80002a9a:	8082                	ret

0000000080002a9c <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
    80002a9c:	1101                	addi	sp,sp,-32
    80002a9e:	ec06                	sd	ra,24(sp)
    80002aa0:	e822                	sd	s0,16(sp)
    80002aa2:	e426                	sd	s1,8(sp)
    80002aa4:	1000                	addi	s0,sp,32
    80002aa6:	84ae                	mv	s1,a1
  *ip = argraw(n);
    80002aa8:	00000097          	auipc	ra,0x0
    80002aac:	ef2080e7          	jalr	-270(ra) # 8000299a <argraw>
    80002ab0:	c088                	sw	a0,0(s1)
  return 0;
}
    80002ab2:	4501                	li	a0,0
    80002ab4:	60e2                	ld	ra,24(sp)
    80002ab6:	6442                	ld	s0,16(sp)
    80002ab8:	64a2                	ld	s1,8(sp)
    80002aba:	6105                	addi	sp,sp,32
    80002abc:	8082                	ret

0000000080002abe <argaddr>:
// Retrieve an argument as a pointer.
// Doesn't check for legality, since
// copyin/copyout will do that.
int
argaddr(int n, uint64 *ip)
{
    80002abe:	1101                	addi	sp,sp,-32
    80002ac0:	ec06                	sd	ra,24(sp)
    80002ac2:	e822                	sd	s0,16(sp)
    80002ac4:	e426                	sd	s1,8(sp)
    80002ac6:	1000                	addi	s0,sp,32
    80002ac8:	84ae                	mv	s1,a1
  *ip = argraw(n);
    80002aca:	00000097          	auipc	ra,0x0
    80002ace:	ed0080e7          	jalr	-304(ra) # 8000299a <argraw>
    80002ad2:	e088                	sd	a0,0(s1)
  return 0;
}
    80002ad4:	4501                	li	a0,0
    80002ad6:	60e2                	ld	ra,24(sp)
    80002ad8:	6442                	ld	s0,16(sp)
    80002ada:	64a2                	ld	s1,8(sp)
    80002adc:	6105                	addi	sp,sp,32
    80002ade:	8082                	ret

0000000080002ae0 <argstr>:
// Fetch the nth word-sized system call argument as a null-terminated string.
// Copies into buf, at most max.
// Returns string length if OK (including nul), -1 if error.
int
argstr(int n, char *buf, int max)
{
    80002ae0:	1101                	addi	sp,sp,-32
    80002ae2:	ec06                	sd	ra,24(sp)
    80002ae4:	e822                	sd	s0,16(sp)
    80002ae6:	e426                	sd	s1,8(sp)
    80002ae8:	e04a                	sd	s2,0(sp)
    80002aea:	1000                	addi	s0,sp,32
    80002aec:	84ae                	mv	s1,a1
    80002aee:	8932                	mv	s2,a2
  *ip = argraw(n);
    80002af0:	00000097          	auipc	ra,0x0
    80002af4:	eaa080e7          	jalr	-342(ra) # 8000299a <argraw>
  uint64 addr;
  if(argaddr(n, &addr) < 0)
    return -1;
  return fetchstr(addr, buf, max);
    80002af8:	864a                	mv	a2,s2
    80002afa:	85a6                	mv	a1,s1
    80002afc:	00000097          	auipc	ra,0x0
    80002b00:	f58080e7          	jalr	-168(ra) # 80002a54 <fetchstr>
}
    80002b04:	60e2                	ld	ra,24(sp)
    80002b06:	6442                	ld	s0,16(sp)
    80002b08:	64a2                	ld	s1,8(sp)
    80002b0a:	6902                	ld	s2,0(sp)
    80002b0c:	6105                	addi	sp,sp,32
    80002b0e:	8082                	ret

0000000080002b10 <syscall>:
[SYS_close]   sys_close,
};

void
syscall(void)
{
    80002b10:	1101                	addi	sp,sp,-32
    80002b12:	ec06                	sd	ra,24(sp)
    80002b14:	e822                	sd	s0,16(sp)
    80002b16:	e426                	sd	s1,8(sp)
    80002b18:	e04a                	sd	s2,0(sp)
    80002b1a:	1000                	addi	s0,sp,32
  int num;
  struct proc *p = myproc();
    80002b1c:	fffff097          	auipc	ra,0xfffff
    80002b20:	fc8080e7          	jalr	-56(ra) # 80001ae4 <myproc>
    80002b24:	84aa                	mv	s1,a0

  num = p->trapframe->a7;
    80002b26:	05853903          	ld	s2,88(a0)
    80002b2a:	0a893783          	ld	a5,168(s2)
    80002b2e:	0007869b          	sext.w	a3,a5
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
    80002b32:	37fd                	addiw	a5,a5,-1
    80002b34:	4751                	li	a4,20
    80002b36:	00f76f63          	bltu	a4,a5,80002b54 <syscall+0x44>
    80002b3a:	00369713          	slli	a4,a3,0x3
    80002b3e:	00007797          	auipc	a5,0x7
    80002b42:	89a78793          	addi	a5,a5,-1894 # 800093d8 <syscalls>
    80002b46:	97ba                	add	a5,a5,a4
    80002b48:	639c                	ld	a5,0(a5)
    80002b4a:	c789                	beqz	a5,80002b54 <syscall+0x44>
    p->trapframe->a0 = syscalls[num]();
    80002b4c:	9782                	jalr	a5
    80002b4e:	06a93823          	sd	a0,112(s2)
    80002b52:	a839                	j	80002b70 <syscall+0x60>
  } else {
    kprintf("%d %s: unknown sys call %d\n",
    80002b54:	15848613          	addi	a2,s1,344
    80002b58:	588c                	lw	a1,48(s1)
    80002b5a:	00007517          	auipc	a0,0x7
    80002b5e:	84650513          	addi	a0,a0,-1978 # 800093a0 <digits+0x360>
    80002b62:	ffffe097          	auipc	ra,0xffffe
    80002b66:	b4a080e7          	jalr	-1206(ra) # 800006ac <kprintf>
            p->pid, p->name, num);
    p->trapframe->a0 = -1;
    80002b6a:	6cbc                	ld	a5,88(s1)
    80002b6c:	577d                	li	a4,-1
    80002b6e:	fbb8                	sd	a4,112(a5)
  }
}
    80002b70:	60e2                	ld	ra,24(sp)
    80002b72:	6442                	ld	s0,16(sp)
    80002b74:	64a2                	ld	s1,8(sp)
    80002b76:	6902                	ld	s2,0(sp)
    80002b78:	6105                	addi	sp,sp,32
    80002b7a:	8082                	ret

0000000080002b7c <sys_exit>:
#include <kernel/spinlock.h>
#include <kernel/proc.h>

uint64
sys_exit(void)
{
    80002b7c:	1101                	addi	sp,sp,-32
    80002b7e:	ec06                	sd	ra,24(sp)
    80002b80:	e822                	sd	s0,16(sp)
    80002b82:	1000                	addi	s0,sp,32
  int n;
  if(argint(0, &n) < 0)
    80002b84:	fec40593          	addi	a1,s0,-20
    80002b88:	4501                	li	a0,0
    80002b8a:	00000097          	auipc	ra,0x0
    80002b8e:	f12080e7          	jalr	-238(ra) # 80002a9c <argint>
    return -1;
    80002b92:	57fd                	li	a5,-1
  if(argint(0, &n) < 0)
    80002b94:	00054963          	bltz	a0,80002ba6 <sys_exit+0x2a>
  _exit(n);
    80002b98:	fec42503          	lw	a0,-20(s0)
    80002b9c:	00000097          	auipc	ra,0x0
    80002ba0:	872080e7          	jalr	-1934(ra) # 8000240e <_exit>
  return 0;  // not reached
    80002ba4:	4781                	li	a5,0
}
    80002ba6:	853e                	mv	a0,a5
    80002ba8:	60e2                	ld	ra,24(sp)
    80002baa:	6442                	ld	s0,16(sp)
    80002bac:	6105                	addi	sp,sp,32
    80002bae:	8082                	ret

0000000080002bb0 <sys_getpid>:

uint64
sys_getpid(void)
{
    80002bb0:	1141                	addi	sp,sp,-16
    80002bb2:	e406                	sd	ra,8(sp)
    80002bb4:	e022                	sd	s0,0(sp)
    80002bb6:	0800                	addi	s0,sp,16
  return myproc()->pid;
    80002bb8:	fffff097          	auipc	ra,0xfffff
    80002bbc:	f2c080e7          	jalr	-212(ra) # 80001ae4 <myproc>
}
    80002bc0:	5908                	lw	a0,48(a0)
    80002bc2:	60a2                	ld	ra,8(sp)
    80002bc4:	6402                	ld	s0,0(sp)
    80002bc6:	0141                	addi	sp,sp,16
    80002bc8:	8082                	ret

0000000080002bca <sys_fork>:

uint64
sys_fork(void)
{
    80002bca:	1141                	addi	sp,sp,-16
    80002bcc:	e406                	sd	ra,8(sp)
    80002bce:	e022                	sd	s0,0(sp)
    80002bd0:	0800                	addi	s0,sp,16
  return fork();
    80002bd2:	fffff097          	auipc	ra,0xfffff
    80002bd6:	2f0080e7          	jalr	752(ra) # 80001ec2 <fork>
}
    80002bda:	60a2                	ld	ra,8(sp)
    80002bdc:	6402                	ld	s0,0(sp)
    80002bde:	0141                	addi	sp,sp,16
    80002be0:	8082                	ret

0000000080002be2 <sys_wait>:

uint64
sys_wait(void)
{
    80002be2:	1101                	addi	sp,sp,-32
    80002be4:	ec06                	sd	ra,24(sp)
    80002be6:	e822                	sd	s0,16(sp)
    80002be8:	1000                	addi	s0,sp,32
  uint64 p;
  if(argaddr(0, &p) < 0)
    80002bea:	fe840593          	addi	a1,s0,-24
    80002bee:	4501                	li	a0,0
    80002bf0:	00000097          	auipc	ra,0x0
    80002bf4:	ece080e7          	jalr	-306(ra) # 80002abe <argaddr>
    80002bf8:	87aa                	mv	a5,a0
    return -1;
    80002bfa:	557d                	li	a0,-1
  if(argaddr(0, &p) < 0)
    80002bfc:	0007c863          	bltz	a5,80002c0c <sys_wait+0x2a>
  return _wait(p);
    80002c00:	fe843503          	ld	a0,-24(s0)
    80002c04:	fffff097          	auipc	ra,0xfffff
    80002c08:	612080e7          	jalr	1554(ra) # 80002216 <_wait>
}
    80002c0c:	60e2                	ld	ra,24(sp)
    80002c0e:	6442                	ld	s0,16(sp)
    80002c10:	6105                	addi	sp,sp,32
    80002c12:	8082                	ret

0000000080002c14 <sys_sbrk>:

uint64
sys_sbrk(void)
{
    80002c14:	7179                	addi	sp,sp,-48
    80002c16:	f406                	sd	ra,40(sp)
    80002c18:	f022                	sd	s0,32(sp)
    80002c1a:	ec26                	sd	s1,24(sp)
    80002c1c:	1800                	addi	s0,sp,48
  int addr;
  int n;

  if(argint(0, &n) < 0)
    80002c1e:	fdc40593          	addi	a1,s0,-36
    80002c22:	4501                	li	a0,0
    80002c24:	00000097          	auipc	ra,0x0
    80002c28:	e78080e7          	jalr	-392(ra) # 80002a9c <argint>
    80002c2c:	87aa                	mv	a5,a0
    return -1;
    80002c2e:	557d                	li	a0,-1
  if(argint(0, &n) < 0)
    80002c30:	0207c063          	bltz	a5,80002c50 <sys_sbrk+0x3c>
  addr = myproc()->sz;
    80002c34:	fffff097          	auipc	ra,0xfffff
    80002c38:	eb0080e7          	jalr	-336(ra) # 80001ae4 <myproc>
    80002c3c:	4524                	lw	s1,72(a0)
  if(growproc(n) < 0)
    80002c3e:	fdc42503          	lw	a0,-36(s0)
    80002c42:	fffff097          	auipc	ra,0xfffff
    80002c46:	208080e7          	jalr	520(ra) # 80001e4a <growproc>
    80002c4a:	00054863          	bltz	a0,80002c5a <sys_sbrk+0x46>
    return -1;
  return addr;
    80002c4e:	8526                	mv	a0,s1
}
    80002c50:	70a2                	ld	ra,40(sp)
    80002c52:	7402                	ld	s0,32(sp)
    80002c54:	64e2                	ld	s1,24(sp)
    80002c56:	6145                	addi	sp,sp,48
    80002c58:	8082                	ret
    return -1;
    80002c5a:	557d                	li	a0,-1
    80002c5c:	bfd5                	j	80002c50 <sys_sbrk+0x3c>

0000000080002c5e <sys_sleep>:

uint64
sys_sleep(void)
{
    80002c5e:	7139                	addi	sp,sp,-64
    80002c60:	fc06                	sd	ra,56(sp)
    80002c62:	f822                	sd	s0,48(sp)
    80002c64:	f426                	sd	s1,40(sp)
    80002c66:	f04a                	sd	s2,32(sp)
    80002c68:	ec4e                	sd	s3,24(sp)
    80002c6a:	0080                	addi	s0,sp,64
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
    80002c6c:	fcc40593          	addi	a1,s0,-52
    80002c70:	4501                	li	a0,0
    80002c72:	00000097          	auipc	ra,0x0
    80002c76:	e2a080e7          	jalr	-470(ra) # 80002a9c <argint>
    return -1;
    80002c7a:	57fd                	li	a5,-1
  if(argint(0, &n) < 0)
    80002c7c:	06054563          	bltz	a0,80002ce6 <sys_sleep+0x88>
  acquire(&tickslock);
    80002c80:	00016517          	auipc	a0,0x16
    80002c84:	45050513          	addi	a0,a0,1104 # 800190d0 <tickslock>
    80002c88:	ffffe097          	auipc	ra,0xffffe
    80002c8c:	070080e7          	jalr	112(ra) # 80000cf8 <acquire>
  ticks0 = ticks;
    80002c90:	00008917          	auipc	s2,0x8
    80002c94:	3a092903          	lw	s2,928(s2) # 8000b030 <ticks>
  while(ticks - ticks0 < n){
    80002c98:	fcc42783          	lw	a5,-52(s0)
    80002c9c:	cf85                	beqz	a5,80002cd4 <sys_sleep+0x76>
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    _sleep(&ticks, &tickslock);
    80002c9e:	00016997          	auipc	s3,0x16
    80002ca2:	43298993          	addi	s3,s3,1074 # 800190d0 <tickslock>
    80002ca6:	00008497          	auipc	s1,0x8
    80002caa:	38a48493          	addi	s1,s1,906 # 8000b030 <ticks>
    if(myproc()->killed){
    80002cae:	fffff097          	auipc	ra,0xfffff
    80002cb2:	e36080e7          	jalr	-458(ra) # 80001ae4 <myproc>
    80002cb6:	551c                	lw	a5,40(a0)
    80002cb8:	ef9d                	bnez	a5,80002cf6 <sys_sleep+0x98>
    _sleep(&ticks, &tickslock);
    80002cba:	85ce                	mv	a1,s3
    80002cbc:	8526                	mv	a0,s1
    80002cbe:	fffff097          	auipc	ra,0xfffff
    80002cc2:	4f4080e7          	jalr	1268(ra) # 800021b2 <_sleep>
  while(ticks - ticks0 < n){
    80002cc6:	409c                	lw	a5,0(s1)
    80002cc8:	412787bb          	subw	a5,a5,s2
    80002ccc:	fcc42703          	lw	a4,-52(s0)
    80002cd0:	fce7efe3          	bltu	a5,a4,80002cae <sys_sleep+0x50>
  }
  release(&tickslock);
    80002cd4:	00016517          	auipc	a0,0x16
    80002cd8:	3fc50513          	addi	a0,a0,1020 # 800190d0 <tickslock>
    80002cdc:	ffffe097          	auipc	ra,0xffffe
    80002ce0:	0d0080e7          	jalr	208(ra) # 80000dac <release>
  return 0;
    80002ce4:	4781                	li	a5,0
}
    80002ce6:	853e                	mv	a0,a5
    80002ce8:	70e2                	ld	ra,56(sp)
    80002cea:	7442                	ld	s0,48(sp)
    80002cec:	74a2                	ld	s1,40(sp)
    80002cee:	7902                	ld	s2,32(sp)
    80002cf0:	69e2                	ld	s3,24(sp)
    80002cf2:	6121                	addi	sp,sp,64
    80002cf4:	8082                	ret
      release(&tickslock);
    80002cf6:	00016517          	auipc	a0,0x16
    80002cfa:	3da50513          	addi	a0,a0,986 # 800190d0 <tickslock>
    80002cfe:	ffffe097          	auipc	ra,0xffffe
    80002d02:	0ae080e7          	jalr	174(ra) # 80000dac <release>
      return -1;
    80002d06:	57fd                	li	a5,-1
    80002d08:	bff9                	j	80002ce6 <sys_sleep+0x88>

0000000080002d0a <sys_kill>:

uint64
sys_kill(void)
{
    80002d0a:	1101                	addi	sp,sp,-32
    80002d0c:	ec06                	sd	ra,24(sp)
    80002d0e:	e822                	sd	s0,16(sp)
    80002d10:	1000                	addi	s0,sp,32
  int pid;

  if(argint(0, &pid) < 0)
    80002d12:	fec40593          	addi	a1,s0,-20
    80002d16:	4501                	li	a0,0
    80002d18:	00000097          	auipc	ra,0x0
    80002d1c:	d84080e7          	jalr	-636(ra) # 80002a9c <argint>
    80002d20:	87aa                	mv	a5,a0
    return -1;
    80002d22:	557d                	li	a0,-1
  if(argint(0, &pid) < 0)
    80002d24:	0007c863          	bltz	a5,80002d34 <sys_kill+0x2a>
  return kill(pid);
    80002d28:	fec42503          	lw	a0,-20(s0)
    80002d2c:	fffff097          	auipc	ra,0xfffff
    80002d30:	7b6080e7          	jalr	1974(ra) # 800024e2 <kill>
}
    80002d34:	60e2                	ld	ra,24(sp)
    80002d36:	6442                	ld	s0,16(sp)
    80002d38:	6105                	addi	sp,sp,32
    80002d3a:	8082                	ret

0000000080002d3c <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
uint64
sys_uptime(void)
{
    80002d3c:	1101                	addi	sp,sp,-32
    80002d3e:	ec06                	sd	ra,24(sp)
    80002d40:	e822                	sd	s0,16(sp)
    80002d42:	e426                	sd	s1,8(sp)
    80002d44:	1000                	addi	s0,sp,32
  uint xticks;

  acquire(&tickslock);
    80002d46:	00016517          	auipc	a0,0x16
    80002d4a:	38a50513          	addi	a0,a0,906 # 800190d0 <tickslock>
    80002d4e:	ffffe097          	auipc	ra,0xffffe
    80002d52:	faa080e7          	jalr	-86(ra) # 80000cf8 <acquire>
  xticks = ticks;
    80002d56:	00008497          	auipc	s1,0x8
    80002d5a:	2da4a483          	lw	s1,730(s1) # 8000b030 <ticks>
  release(&tickslock);
    80002d5e:	00016517          	auipc	a0,0x16
    80002d62:	37250513          	addi	a0,a0,882 # 800190d0 <tickslock>
    80002d66:	ffffe097          	auipc	ra,0xffffe
    80002d6a:	046080e7          	jalr	70(ra) # 80000dac <release>
  return xticks;
}
    80002d6e:	02049513          	slli	a0,s1,0x20
    80002d72:	9101                	srli	a0,a0,0x20
    80002d74:	60e2                	ld	ra,24(sp)
    80002d76:	6442                	ld	s0,16(sp)
    80002d78:	64a2                	ld	s1,8(sp)
    80002d7a:	6105                	addi	sp,sp,32
    80002d7c:	8082                	ret

0000000080002d7e <binit>:
	// head.next is most recent, head.prev is least.
	struct buf head;
} bcache;

void binit(void)
{
    80002d7e:	7179                	addi	sp,sp,-48
    80002d80:	f406                	sd	ra,40(sp)
    80002d82:	f022                	sd	s0,32(sp)
    80002d84:	ec26                	sd	s1,24(sp)
    80002d86:	e84a                	sd	s2,16(sp)
    80002d88:	e44e                	sd	s3,8(sp)
    80002d8a:	e052                	sd	s4,0(sp)
    80002d8c:	1800                	addi	s0,sp,48
	struct buf *b;

	initlock(&bcache.lock, "bcache");
    80002d8e:	00006597          	auipc	a1,0x6
    80002d92:	6fa58593          	addi	a1,a1,1786 # 80009488 <syscalls+0xb0>
    80002d96:	00016517          	auipc	a0,0x16
    80002d9a:	35250513          	addi	a0,a0,850 # 800190e8 <bcache>
    80002d9e:	ffffe097          	auipc	ra,0xffffe
    80002da2:	eca080e7          	jalr	-310(ra) # 80000c68 <initlock>

	// Create linked list of buffers
	bcache.head.prev = &bcache.head;
    80002da6:	0001e797          	auipc	a5,0x1e
    80002daa:	34278793          	addi	a5,a5,834 # 800210e8 <bcache+0x8000>
    80002dae:	0001e717          	auipc	a4,0x1e
    80002db2:	5a270713          	addi	a4,a4,1442 # 80021350 <bcache+0x8268>
    80002db6:	2ae7b823          	sd	a4,688(a5)
	bcache.head.next = &bcache.head;
    80002dba:	2ae7bc23          	sd	a4,696(a5)
	for(b = bcache.buf; b < bcache.buf+NBUF; b++) {
    80002dbe:	00016497          	auipc	s1,0x16
    80002dc2:	34248493          	addi	s1,s1,834 # 80019100 <bcache+0x18>
		b->next = bcache.head.next;
    80002dc6:	893e                	mv	s2,a5
		b->prev = &bcache.head;
    80002dc8:	89ba                	mv	s3,a4
		initsleeplock(&b->lock, "buffer");
    80002dca:	00006a17          	auipc	s4,0x6
    80002dce:	6c6a0a13          	addi	s4,s4,1734 # 80009490 <syscalls+0xb8>
		b->next = bcache.head.next;
    80002dd2:	2b893783          	ld	a5,696(s2)
    80002dd6:	e8bc                	sd	a5,80(s1)
		b->prev = &bcache.head;
    80002dd8:	0534b423          	sd	s3,72(s1)
		initsleeplock(&b->lock, "buffer");
    80002ddc:	85d2                	mv	a1,s4
    80002dde:	01048513          	addi	a0,s1,16
    80002de2:	00001097          	auipc	ra,0x1
    80002de6:	a66080e7          	jalr	-1434(ra) # 80003848 <initsleeplock>
		bcache.head.next->prev = b;
    80002dea:	2b893783          	ld	a5,696(s2)
    80002dee:	e7a4                	sd	s1,72(a5)
		bcache.head.next = b;
    80002df0:	2a993c23          	sd	s1,696(s2)
	for(b = bcache.buf; b < bcache.buf+NBUF; b++) {
    80002df4:	45848493          	addi	s1,s1,1112
    80002df8:	fd349de3          	bne	s1,s3,80002dd2 <binit+0x54>
	}
}
    80002dfc:	70a2                	ld	ra,40(sp)
    80002dfe:	7402                	ld	s0,32(sp)
    80002e00:	64e2                	ld	s1,24(sp)
    80002e02:	6942                	ld	s2,16(sp)
    80002e04:	69a2                	ld	s3,8(sp)
    80002e06:	6a02                	ld	s4,0(sp)
    80002e08:	6145                	addi	sp,sp,48
    80002e0a:	8082                	ret

0000000080002e0c <bread>:
	panic("bget: no buffers");
}

// Return a locked buf with the contents of the indicated block.
struct buf * bread(uint dev, uint blockno)
{
    80002e0c:	7179                	addi	sp,sp,-48
    80002e0e:	f406                	sd	ra,40(sp)
    80002e10:	f022                	sd	s0,32(sp)
    80002e12:	ec26                	sd	s1,24(sp)
    80002e14:	e84a                	sd	s2,16(sp)
    80002e16:	e44e                	sd	s3,8(sp)
    80002e18:	1800                	addi	s0,sp,48
    80002e1a:	892a                	mv	s2,a0
    80002e1c:	89ae                	mv	s3,a1
	acquire(&bcache.lock);
    80002e1e:	00016517          	auipc	a0,0x16
    80002e22:	2ca50513          	addi	a0,a0,714 # 800190e8 <bcache>
    80002e26:	ffffe097          	auipc	ra,0xffffe
    80002e2a:	ed2080e7          	jalr	-302(ra) # 80000cf8 <acquire>
	for(b = bcache.head.next; b != &bcache.head; b = b->next) {
    80002e2e:	0001e497          	auipc	s1,0x1e
    80002e32:	5724b483          	ld	s1,1394(s1) # 800213a0 <bcache+0x82b8>
    80002e36:	0001e797          	auipc	a5,0x1e
    80002e3a:	51a78793          	addi	a5,a5,1306 # 80021350 <bcache+0x8268>
    80002e3e:	02f48f63          	beq	s1,a5,80002e7c <bread+0x70>
    80002e42:	873e                	mv	a4,a5
    80002e44:	a021                	j	80002e4c <bread+0x40>
    80002e46:	68a4                	ld	s1,80(s1)
    80002e48:	02e48a63          	beq	s1,a4,80002e7c <bread+0x70>
		if(b->dev == dev && b->blockno == blockno) {
    80002e4c:	449c                	lw	a5,8(s1)
    80002e4e:	ff279ce3          	bne	a5,s2,80002e46 <bread+0x3a>
    80002e52:	44dc                	lw	a5,12(s1)
    80002e54:	ff3799e3          	bne	a5,s3,80002e46 <bread+0x3a>
			b->refcnt++;
    80002e58:	40bc                	lw	a5,64(s1)
    80002e5a:	2785                	addiw	a5,a5,1
    80002e5c:	c0bc                	sw	a5,64(s1)
			release(&bcache.lock);
    80002e5e:	00016517          	auipc	a0,0x16
    80002e62:	28a50513          	addi	a0,a0,650 # 800190e8 <bcache>
    80002e66:	ffffe097          	auipc	ra,0xffffe
    80002e6a:	f46080e7          	jalr	-186(ra) # 80000dac <release>
			acquiresleep(&b->lock);
    80002e6e:	01048513          	addi	a0,s1,16
    80002e72:	00001097          	auipc	ra,0x1
    80002e76:	a10080e7          	jalr	-1520(ra) # 80003882 <acquiresleep>
			return b;
    80002e7a:	a8b9                	j	80002ed8 <bread+0xcc>
	for(b = bcache.head.prev; b != &bcache.head; b = b->prev) {
    80002e7c:	0001e497          	auipc	s1,0x1e
    80002e80:	51c4b483          	ld	s1,1308(s1) # 80021398 <bcache+0x82b0>
    80002e84:	0001e797          	auipc	a5,0x1e
    80002e88:	4cc78793          	addi	a5,a5,1228 # 80021350 <bcache+0x8268>
    80002e8c:	00f48863          	beq	s1,a5,80002e9c <bread+0x90>
    80002e90:	873e                	mv	a4,a5
		if(b->refcnt == 0) {
    80002e92:	40bc                	lw	a5,64(s1)
    80002e94:	cf81                	beqz	a5,80002eac <bread+0xa0>
	for(b = bcache.head.prev; b != &bcache.head; b = b->prev) {
    80002e96:	64a4                	ld	s1,72(s1)
    80002e98:	fee49de3          	bne	s1,a4,80002e92 <bread+0x86>
	panic("bget: no buffers");
    80002e9c:	00006517          	auipc	a0,0x6
    80002ea0:	5fc50513          	addi	a0,a0,1532 # 80009498 <syscalls+0xc0>
    80002ea4:	ffffd097          	auipc	ra,0xffffd
    80002ea8:	7be080e7          	jalr	1982(ra) # 80000662 <panic>
			b->dev = dev;
    80002eac:	0124a423          	sw	s2,8(s1)
			b->blockno = blockno;
    80002eb0:	0134a623          	sw	s3,12(s1)
			b->valid = 0;
    80002eb4:	0004a023          	sw	zero,0(s1)
			b->refcnt = 1;
    80002eb8:	4785                	li	a5,1
    80002eba:	c0bc                	sw	a5,64(s1)
			release(&bcache.lock);
    80002ebc:	00016517          	auipc	a0,0x16
    80002ec0:	22c50513          	addi	a0,a0,556 # 800190e8 <bcache>
    80002ec4:	ffffe097          	auipc	ra,0xffffe
    80002ec8:	ee8080e7          	jalr	-280(ra) # 80000dac <release>
			acquiresleep(&b->lock);
    80002ecc:	01048513          	addi	a0,s1,16
    80002ed0:	00001097          	auipc	ra,0x1
    80002ed4:	9b2080e7          	jalr	-1614(ra) # 80003882 <acquiresleep>
	struct buf *b;

	b = bget(dev, blockno);

	if(!b->valid) {
    80002ed8:	409c                	lw	a5,0(s1)
    80002eda:	cb89                	beqz	a5,80002eec <bread+0xe0>
		
		b->valid = 1;
	}

	return b;
}
    80002edc:	8526                	mv	a0,s1
    80002ede:	70a2                	ld	ra,40(sp)
    80002ee0:	7402                	ld	s0,32(sp)
    80002ee2:	64e2                	ld	s1,24(sp)
    80002ee4:	6942                	ld	s2,16(sp)
    80002ee6:	69a2                	ld	s3,8(sp)
    80002ee8:	6145                	addi	sp,sp,48
    80002eea:	8082                	ret
		virtio_disk_rw(b, 0);
    80002eec:	4581                	li	a1,0
    80002eee:	8526                	mv	a0,s1
    80002ef0:	00002097          	auipc	ra,0x2
    80002ef4:	3b6080e7          	jalr	950(ra) # 800052a6 <virtio_disk_rw>
		b->valid = 1;
    80002ef8:	4785                	li	a5,1
    80002efa:	c09c                	sw	a5,0(s1)
	return b;
    80002efc:	b7c5                	j	80002edc <bread+0xd0>

0000000080002efe <bwrite>:

// Write b's contents to disk.  Must be locked.
void bwrite(struct buf *b)
{
    80002efe:	1101                	addi	sp,sp,-32
    80002f00:	ec06                	sd	ra,24(sp)
    80002f02:	e822                	sd	s0,16(sp)
    80002f04:	e426                	sd	s1,8(sp)
    80002f06:	1000                	addi	s0,sp,32
    80002f08:	84aa                	mv	s1,a0
	if(!holdingsleep(&b->lock))
    80002f0a:	0541                	addi	a0,a0,16
    80002f0c:	00001097          	auipc	ra,0x1
    80002f10:	a10080e7          	jalr	-1520(ra) # 8000391c <holdingsleep>
    80002f14:	cd01                	beqz	a0,80002f2c <bwrite+0x2e>
		panic("bwrite");
	virtio_disk_rw(b, 1);
    80002f16:	4585                	li	a1,1
    80002f18:	8526                	mv	a0,s1
    80002f1a:	00002097          	auipc	ra,0x2
    80002f1e:	38c080e7          	jalr	908(ra) # 800052a6 <virtio_disk_rw>
}
    80002f22:	60e2                	ld	ra,24(sp)
    80002f24:	6442                	ld	s0,16(sp)
    80002f26:	64a2                	ld	s1,8(sp)
    80002f28:	6105                	addi	sp,sp,32
    80002f2a:	8082                	ret
		panic("bwrite");
    80002f2c:	00006517          	auipc	a0,0x6
    80002f30:	58450513          	addi	a0,a0,1412 # 800094b0 <syscalls+0xd8>
    80002f34:	ffffd097          	auipc	ra,0xffffd
    80002f38:	72e080e7          	jalr	1838(ra) # 80000662 <panic>

0000000080002f3c <brelease>:

// Release a locked buffer.
// Move to the head of the most-recently-used list.
void brelease(struct buf *b)
{
    80002f3c:	1101                	addi	sp,sp,-32
    80002f3e:	ec06                	sd	ra,24(sp)
    80002f40:	e822                	sd	s0,16(sp)
    80002f42:	e426                	sd	s1,8(sp)
    80002f44:	e04a                	sd	s2,0(sp)
    80002f46:	1000                	addi	s0,sp,32
    80002f48:	84aa                	mv	s1,a0
	if(!holdingsleep(&b->lock))
    80002f4a:	01050913          	addi	s2,a0,16
    80002f4e:	854a                	mv	a0,s2
    80002f50:	00001097          	auipc	ra,0x1
    80002f54:	9cc080e7          	jalr	-1588(ra) # 8000391c <holdingsleep>
    80002f58:	c92d                	beqz	a0,80002fca <brelease+0x8e>
		panic("brelease");

	releasesleep(&b->lock);
    80002f5a:	854a                	mv	a0,s2
    80002f5c:	00001097          	auipc	ra,0x1
    80002f60:	97c080e7          	jalr	-1668(ra) # 800038d8 <releasesleep>
	acquire(&bcache.lock);
    80002f64:	00016517          	auipc	a0,0x16
    80002f68:	18450513          	addi	a0,a0,388 # 800190e8 <bcache>
    80002f6c:	ffffe097          	auipc	ra,0xffffe
    80002f70:	d8c080e7          	jalr	-628(ra) # 80000cf8 <acquire>

	b->refcnt--;
    80002f74:	40bc                	lw	a5,64(s1)
    80002f76:	37fd                	addiw	a5,a5,-1
    80002f78:	0007871b          	sext.w	a4,a5
    80002f7c:	c0bc                	sw	a5,64(s1)
	
	if (b->refcnt == 0) {
    80002f7e:	eb05                	bnez	a4,80002fae <brelease+0x72>
		// no one is waiting for it.
		b->next->prev = b->prev;
    80002f80:	68bc                	ld	a5,80(s1)
    80002f82:	64b8                	ld	a4,72(s1)
    80002f84:	e7b8                	sd	a4,72(a5)
		b->prev->next = b->next;
    80002f86:	64bc                	ld	a5,72(s1)
    80002f88:	68b8                	ld	a4,80(s1)
    80002f8a:	ebb8                	sd	a4,80(a5)
		b->next = bcache.head.next;
    80002f8c:	0001e797          	auipc	a5,0x1e
    80002f90:	15c78793          	addi	a5,a5,348 # 800210e8 <bcache+0x8000>
    80002f94:	2b87b703          	ld	a4,696(a5)
    80002f98:	e8b8                	sd	a4,80(s1)
		b->prev = &bcache.head;
    80002f9a:	0001e717          	auipc	a4,0x1e
    80002f9e:	3b670713          	addi	a4,a4,950 # 80021350 <bcache+0x8268>
    80002fa2:	e4b8                	sd	a4,72(s1)
		bcache.head.next->prev = b;
    80002fa4:	2b87b703          	ld	a4,696(a5)
    80002fa8:	e724                	sd	s1,72(a4)
		bcache.head.next = b;
    80002faa:	2a97bc23          	sd	s1,696(a5)
	}
	
	release(&bcache.lock);
    80002fae:	00016517          	auipc	a0,0x16
    80002fb2:	13a50513          	addi	a0,a0,314 # 800190e8 <bcache>
    80002fb6:	ffffe097          	auipc	ra,0xffffe
    80002fba:	df6080e7          	jalr	-522(ra) # 80000dac <release>
}
    80002fbe:	60e2                	ld	ra,24(sp)
    80002fc0:	6442                	ld	s0,16(sp)
    80002fc2:	64a2                	ld	s1,8(sp)
    80002fc4:	6902                	ld	s2,0(sp)
    80002fc6:	6105                	addi	sp,sp,32
    80002fc8:	8082                	ret
		panic("brelease");
    80002fca:	00006517          	auipc	a0,0x6
    80002fce:	4ee50513          	addi	a0,a0,1262 # 800094b8 <syscalls+0xe0>
    80002fd2:	ffffd097          	auipc	ra,0xffffd
    80002fd6:	690080e7          	jalr	1680(ra) # 80000662 <panic>

0000000080002fda <bpin>:

void bpin(struct buf *b) {
    80002fda:	1101                	addi	sp,sp,-32
    80002fdc:	ec06                	sd	ra,24(sp)
    80002fde:	e822                	sd	s0,16(sp)
    80002fe0:	e426                	sd	s1,8(sp)
    80002fe2:	1000                	addi	s0,sp,32
    80002fe4:	84aa                	mv	s1,a0
	acquire(&bcache.lock);
    80002fe6:	00016517          	auipc	a0,0x16
    80002fea:	10250513          	addi	a0,a0,258 # 800190e8 <bcache>
    80002fee:	ffffe097          	auipc	ra,0xffffe
    80002ff2:	d0a080e7          	jalr	-758(ra) # 80000cf8 <acquire>
	b->refcnt++;
    80002ff6:	40bc                	lw	a5,64(s1)
    80002ff8:	2785                	addiw	a5,a5,1
    80002ffa:	c0bc                	sw	a5,64(s1)
	release(&bcache.lock);
    80002ffc:	00016517          	auipc	a0,0x16
    80003000:	0ec50513          	addi	a0,a0,236 # 800190e8 <bcache>
    80003004:	ffffe097          	auipc	ra,0xffffe
    80003008:	da8080e7          	jalr	-600(ra) # 80000dac <release>
}
    8000300c:	60e2                	ld	ra,24(sp)
    8000300e:	6442                	ld	s0,16(sp)
    80003010:	64a2                	ld	s1,8(sp)
    80003012:	6105                	addi	sp,sp,32
    80003014:	8082                	ret

0000000080003016 <bunpin>:

void bunpin(struct buf *b) {
    80003016:	1101                	addi	sp,sp,-32
    80003018:	ec06                	sd	ra,24(sp)
    8000301a:	e822                	sd	s0,16(sp)
    8000301c:	e426                	sd	s1,8(sp)
    8000301e:	1000                	addi	s0,sp,32
    80003020:	84aa                	mv	s1,a0
	acquire(&bcache.lock);
    80003022:	00016517          	auipc	a0,0x16
    80003026:	0c650513          	addi	a0,a0,198 # 800190e8 <bcache>
    8000302a:	ffffe097          	auipc	ra,0xffffe
    8000302e:	cce080e7          	jalr	-818(ra) # 80000cf8 <acquire>
	b->refcnt--;
    80003032:	40bc                	lw	a5,64(s1)
    80003034:	37fd                	addiw	a5,a5,-1
    80003036:	c0bc                	sw	a5,64(s1)
	release(&bcache.lock);
    80003038:	00016517          	auipc	a0,0x16
    8000303c:	0b050513          	addi	a0,a0,176 # 800190e8 <bcache>
    80003040:	ffffe097          	auipc	ra,0xffffe
    80003044:	d6c080e7          	jalr	-660(ra) # 80000dac <release>
}
    80003048:	60e2                	ld	ra,24(sp)
    8000304a:	6442                	ld	s0,16(sp)
    8000304c:	64a2                	ld	s1,8(sp)
    8000304e:	6105                	addi	sp,sp,32
    80003050:	8082                	ret

0000000080003052 <namex>:
// Look up and return the inode for a path name.
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode * namex(char * path, int nameiparent, char * name)
{
    80003052:	7159                	addi	sp,sp,-112
    80003054:	f486                	sd	ra,104(sp)
    80003056:	f0a2                	sd	s0,96(sp)
    80003058:	eca6                	sd	s1,88(sp)
    8000305a:	e8ca                	sd	s2,80(sp)
    8000305c:	e4ce                	sd	s3,72(sp)
    8000305e:	e0d2                	sd	s4,64(sp)
    80003060:	fc56                	sd	s5,56(sp)
    80003062:	f85a                	sd	s6,48(sp)
    80003064:	f45e                	sd	s7,40(sp)
    80003066:	f062                	sd	s8,32(sp)
    80003068:	ec66                	sd	s9,24(sp)
    8000306a:	e86a                	sd	s10,16(sp)
    8000306c:	e46e                	sd	s11,8(sp)
    8000306e:	1880                	addi	s0,sp,112
    80003070:	84aa                	mv	s1,a0
    80003072:	8bae                	mv	s7,a1
    80003074:	8b32                	mv	s6,a2
	struct inode * ip, * next;

	if(*path == '/') {
    80003076:	00054703          	lbu	a4,0(a0)
    8000307a:	02f00793          	li	a5,47
    8000307e:	02f71563          	bne	a4,a5,800030a8 <namex+0x56>
		ip = root_fs->vfs_ops->get_root(ROOTDEV);
    80003082:	00008797          	auipc	a5,0x8
    80003086:	fb67b783          	ld	a5,-74(a5) # 8000b038 <root_fs>
    8000308a:	679c                	ld	a5,8(a5)
    8000308c:	639c                	ld	a5,0(a5)
    8000308e:	4505                	li	a0,1
    80003090:	9782                	jalr	a5
    80003092:	8a2a                	mv	s4,a0
	while(*path == '/')
    80003094:	02f00913          	li	s2,47
	if(len >= DIRSIZ) {
    80003098:	4d35                	li	s10,13
	len = path - s;
    8000309a:	4c01                	li	s8,0
		ip = root_fs->inode_ops->idup(myproc()->cwd);
	}

	while((path = skipelem(path, name)) != 0) {
		if(!ip->inode_ops) {
			if(root_fs) {
    8000309c:	00008d97          	auipc	s11,0x8
    800030a0:	f9cd8d93          	addi	s11,s11,-100 # 8000b038 <root_fs>
			}
		}

		ip->inode_ops->ilock(ip);

		if(ip->type != T_DIR) {
    800030a4:	4c85                	li	s9,1
    800030a6:	a8fd                	j	800031a4 <namex+0x152>
		ip = root_fs->inode_ops->idup(myproc()->cwd);
    800030a8:	00008797          	auipc	a5,0x8
    800030ac:	f907b783          	ld	a5,-112(a5) # 8000b038 <root_fs>
    800030b0:	6b9c                	ld	a5,16(a5)
    800030b2:	0407b903          	ld	s2,64(a5)
    800030b6:	fffff097          	auipc	ra,0xfffff
    800030ba:	a2e080e7          	jalr	-1490(ra) # 80001ae4 <myproc>
    800030be:	15053503          	ld	a0,336(a0)
    800030c2:	9902                	jalr	s2
    800030c4:	8a2a                	mv	s4,a0
    800030c6:	b7f9                	j	80003094 <namex+0x42>
			if(root_fs) {
    800030c8:	000db783          	ld	a5,0(s11)
    800030cc:	cb81                	beqz	a5,800030dc <namex+0x8a>
				ip->inode_ops = root_fs->inode_ops;
    800030ce:	6b98                	ld	a4,16(a5)
    800030d0:	00ea3823          	sd	a4,16(s4)
				ip->vfs_ops = root_fs->vfs_ops;
    800030d4:	679c                	ld	a5,8(a5)
    800030d6:	00fa3c23          	sd	a5,24(s4)
    800030da:	a079                	j	80003168 <namex+0x116>
				kprintf("Possibly fatal: inode_ops needed but no root_fs available\n");
    800030dc:	00006517          	auipc	a0,0x6
    800030e0:	3ec50513          	addi	a0,a0,1004 # 800094c8 <syscalls+0xf0>
    800030e4:	ffffd097          	auipc	ra,0xffffd
    800030e8:	5c8080e7          	jalr	1480(ra) # 800006ac <kprintf>
    800030ec:	a8b5                	j	80003168 <namex+0x116>
			ip->inode_ops->iunlockput(ip);
    800030ee:	010a3783          	ld	a5,16(s4)
    800030f2:	7f9c                	ld	a5,56(a5)
    800030f4:	8552                	mv	a0,s4
    800030f6:	9782                	jalr	a5
			return 0;
    800030f8:	4a01                	li	s4,0
		ip->inode_ops->iput(ip);
		return 0;
	}

	return ip;
}
    800030fa:	8552                	mv	a0,s4
    800030fc:	70a6                	ld	ra,104(sp)
    800030fe:	7406                	ld	s0,96(sp)
    80003100:	64e6                	ld	s1,88(sp)
    80003102:	6946                	ld	s2,80(sp)
    80003104:	69a6                	ld	s3,72(sp)
    80003106:	6a06                	ld	s4,64(sp)
    80003108:	7ae2                	ld	s5,56(sp)
    8000310a:	7b42                	ld	s6,48(sp)
    8000310c:	7ba2                	ld	s7,40(sp)
    8000310e:	7c02                	ld	s8,32(sp)
    80003110:	6ce2                	ld	s9,24(sp)
    80003112:	6d42                	ld	s10,16(sp)
    80003114:	6da2                	ld	s11,8(sp)
    80003116:	6165                	addi	sp,sp,112
    80003118:	8082                	ret
			ip->inode_ops->iunlock(ip);
    8000311a:	010a3783          	ld	a5,16(s4)
    8000311e:	7b9c                	ld	a5,48(a5)
    80003120:	8552                	mv	a0,s4
    80003122:	9782                	jalr	a5
			return ip;
    80003124:	bfd9                	j	800030fa <namex+0xa8>
			ip->inode_ops->iunlockput(ip);
    80003126:	010a3783          	ld	a5,16(s4)
    8000312a:	7f9c                	ld	a5,56(a5)
    8000312c:	8552                	mv	a0,s4
    8000312e:	9782                	jalr	a5
			return 0;
    80003130:	8a4e                	mv	s4,s3
    80003132:	b7e1                	j	800030fa <namex+0xa8>
	len = path - s;
    80003134:	40998633          	sub	a2,s3,s1
    80003138:	00060a9b          	sext.w	s5,a2
	if(len >= DIRSIZ) {
    8000313c:	095d5c63          	bge	s10,s5,800031d4 <namex+0x182>
		kmemmove(name, s, DIRSIZ);
    80003140:	4639                	li	a2,14
    80003142:	85a6                	mv	a1,s1
    80003144:	855a                	mv	a0,s6
    80003146:	ffffe097          	auipc	ra,0xffffe
    8000314a:	d0a080e7          	jalr	-758(ra) # 80000e50 <kmemmove>
    8000314e:	84ce                	mv	s1,s3
	while(*path == '/')
    80003150:	0004c783          	lbu	a5,0(s1)
    80003154:	01279763          	bne	a5,s2,80003162 <namex+0x110>
		path++;
    80003158:	0485                	addi	s1,s1,1
	while(*path == '/')
    8000315a:	0004c783          	lbu	a5,0(s1)
    8000315e:	ff278de3          	beq	a5,s2,80003158 <namex+0x106>
		if(!ip->inode_ops) {
    80003162:	010a3783          	ld	a5,16(s4)
    80003166:	d3ad                	beqz	a5,800030c8 <namex+0x76>
		ip->inode_ops->ilock(ip);
    80003168:	010a3783          	ld	a5,16(s4)
    8000316c:	739c                	ld	a5,32(a5)
    8000316e:	8552                	mv	a0,s4
    80003170:	9782                	jalr	a5
		if(ip->type != T_DIR) {
    80003172:	028a1783          	lh	a5,40(s4)
    80003176:	f7979ce3          	bne	a5,s9,800030ee <namex+0x9c>
		if(nameiparent && *path == '\0') {
    8000317a:	000b8563          	beqz	s7,80003184 <namex+0x132>
    8000317e:	0004c783          	lbu	a5,0(s1)
    80003182:	dfc1                	beqz	a5,8000311a <namex+0xc8>
		if((next = ip->inode_ops->dir_lookup(ip, name, 0)) == 0) {
    80003184:	010a3783          	ld	a5,16(s4)
    80003188:	639c                	ld	a5,0(a5)
    8000318a:	8662                	mv	a2,s8
    8000318c:	85da                	mv	a1,s6
    8000318e:	8552                	mv	a0,s4
    80003190:	9782                	jalr	a5
    80003192:	89aa                	mv	s3,a0
    80003194:	d949                	beqz	a0,80003126 <namex+0xd4>
		next->inode_ops = ip->inode_ops;
    80003196:	010a3783          	ld	a5,16(s4)
    8000319a:	e91c                	sd	a5,16(a0)
		ip->inode_ops->iunlockput(ip);
    8000319c:	7f9c                	ld	a5,56(a5)
    8000319e:	8552                	mv	a0,s4
    800031a0:	9782                	jalr	a5
		ip = next;
    800031a2:	8a4e                	mv	s4,s3
	while(*path == '/')
    800031a4:	0004c783          	lbu	a5,0(s1)
    800031a8:	01279763          	bne	a5,s2,800031b6 <namex+0x164>
		path++;
    800031ac:	0485                	addi	s1,s1,1
	while(*path == '/')
    800031ae:	0004c783          	lbu	a5,0(s1)
    800031b2:	ff278de3          	beq	a5,s2,800031ac <namex+0x15a>
	if(*path == 0)
    800031b6:	cb9d                	beqz	a5,800031ec <namex+0x19a>
	while(*path != '/' && *path != 0)
    800031b8:	0004c783          	lbu	a5,0(s1)
    800031bc:	89a6                	mv	s3,s1
	len = path - s;
    800031be:	8ae2                	mv	s5,s8
    800031c0:	8662                	mv	a2,s8
	while(*path != '/' && *path != 0)
    800031c2:	01278963          	beq	a5,s2,800031d4 <namex+0x182>
    800031c6:	d7bd                	beqz	a5,80003134 <namex+0xe2>
		path++;
    800031c8:	0985                	addi	s3,s3,1
	while(*path != '/' && *path != 0)
    800031ca:	0009c783          	lbu	a5,0(s3)
    800031ce:	ff279ce3          	bne	a5,s2,800031c6 <namex+0x174>
    800031d2:	b78d                	j	80003134 <namex+0xe2>
		kmemmove(name, s, len);
    800031d4:	2601                	sext.w	a2,a2
    800031d6:	85a6                	mv	a1,s1
    800031d8:	855a                	mv	a0,s6
    800031da:	ffffe097          	auipc	ra,0xffffe
    800031de:	c76080e7          	jalr	-906(ra) # 80000e50 <kmemmove>
		name[len] = 0;
    800031e2:	9ada                	add	s5,s5,s6
    800031e4:	000a8023          	sb	zero,0(s5)
    800031e8:	84ce                	mv	s1,s3
    800031ea:	b79d                	j	80003150 <namex+0xfe>
	if(nameiparent) {
    800031ec:	f00b87e3          	beqz	s7,800030fa <namex+0xa8>
		ip->inode_ops->iput(ip);
    800031f0:	010a3783          	ld	a5,16(s4)
    800031f4:	779c                	ld	a5,40(a5)
    800031f6:	8552                	mv	a0,s4
    800031f8:	9782                	jalr	a5
		return 0;
    800031fa:	4a01                	li	s4,0
    800031fc:	bdfd                	j	800030fa <namex+0xa8>

00000000800031fe <root_init>:
{
    800031fe:	7101                	addi	sp,sp,-512
    80003200:	ff86                	sd	ra,504(sp)
    80003202:	fba2                	sd	s0,496(sp)
    80003204:	f7a6                	sd	s1,488(sp)
    80003206:	f3ca                	sd	s2,480(sp)
    80003208:	0400                	addi	s0,sp,512
    8000320a:	84aa                	mv	s1,a0
		if((fs_type = vfs_list[i].vfs_ops->read_super(dev, &superblock)) != -1) {
    8000320c:	00007797          	auipc	a5,0x7
    80003210:	e147b783          	ld	a5,-492(a5) # 8000a020 <vfs_list+0x8>
    80003214:	679c                	ld	a5,8(a5)
    80003216:	e0040593          	addi	a1,s0,-512
    8000321a:	9782                	jalr	a5
    8000321c:	57fd                	li	a5,-1
    8000321e:	02f51663          	bne	a0,a5,8000324a <root_init+0x4c>
    80003222:	00007797          	auipc	a5,0x7
    80003226:	ff67b783          	ld	a5,-10(a5) # 8000a218 <vfs_list+0x200>
    8000322a:	679c                	ld	a5,8(a5)
    8000322c:	e0040593          	addi	a1,s0,-512
    80003230:	8526                	mv	a0,s1
    80003232:	9782                	jalr	a5
    80003234:	57fd                	li	a5,-1
    80003236:	00f51a63          	bne	a0,a5,8000324a <root_init+0x4c>
	panic("Unknown file system type!");
    8000323a:	00006517          	auipc	a0,0x6
    8000323e:	36650513          	addi	a0,a0,870 # 800095a0 <syscalls+0x1c8>
    80003242:	ffffd097          	auipc	ra,0xffffd
    80003246:	420080e7          	jalr	1056(ra) # 80000662 <panic>
			switch(fs_type) {
    8000324a:	67bd                	lui	a5,0xf
    8000324c:	f5378793          	addi	a5,a5,-173 # ef53 <_entry-0x7fff10ad>
    80003250:	06f50b63          	beq	a0,a5,800032c6 <root_init+0xc8>
    80003254:	102037b7          	lui	a5,0x10203
    80003258:	04078793          	addi	a5,a5,64 # 10203040 <_entry-0x6fdfcfc0>
    8000325c:	0af51b63          	bne	a0,a5,80003312 <root_init+0x114>
					root_fs = kalloc(); /* Allocate a 4KB block for the root_fs */
    80003260:	ffffe097          	auipc	ra,0xffffe
    80003264:	9a8080e7          	jalr	-1624(ra) # 80000c08 <kalloc>
    80003268:	00008917          	auipc	s2,0x8
    8000326c:	dd090913          	addi	s2,s2,-560 # 8000b038 <root_fs>
    80003270:	00a93023          	sd	a0,0(s2)
					kmemmove(root_fs, &vfs_list[0], sizeof(struct vfs));
    80003274:	1f800613          	li	a2,504
    80003278:	00007597          	auipc	a1,0x7
    8000327c:	da058593          	addi	a1,a1,-608 # 8000a018 <vfs_list>
    80003280:	ffffe097          	auipc	ra,0xffffe
    80003284:	bd0080e7          	jalr	-1072(ra) # 80000e50 <kmemmove>
					kmemmove(&root_fs->superblock, &superblock, sizeof(struct superblock));
    80003288:	00093503          	ld	a0,0(s2)
    8000328c:	1e000613          	li	a2,480
    80003290:	e0040593          	addi	a1,s0,-512
    80003294:	0561                	addi	a0,a0,24
    80003296:	ffffe097          	auipc	ra,0xffffe
    8000329a:	bba080e7          	jalr	-1094(ra) # 80000e50 <kmemmove>
					initlog(dev);
    8000329e:	8526                	mv	a0,s1
    800032a0:	00000097          	auipc	ra,0x0
    800032a4:	23c080e7          	jalr	572(ra) # 800034dc <initlog>
					kprintf("Loaded valid xv6 file system as root device!\n");
    800032a8:	00006517          	auipc	a0,0x6
    800032ac:	26050513          	addi	a0,a0,608 # 80009508 <syscalls+0x130>
    800032b0:	ffffd097          	auipc	ra,0xffffd
    800032b4:	3fc080e7          	jalr	1020(ra) # 800006ac <kprintf>
}
    800032b8:	70fe                	ld	ra,504(sp)
    800032ba:	745e                	ld	s0,496(sp)
    800032bc:	74be                	ld	s1,488(sp)
    800032be:	791e                	ld	s2,480(sp)
    800032c0:	20010113          	addi	sp,sp,512
    800032c4:	8082                	ret
					root_fs = kalloc(); /* Allocate a 4KB block for the root_fs */
    800032c6:	ffffe097          	auipc	ra,0xffffe
    800032ca:	942080e7          	jalr	-1726(ra) # 80000c08 <kalloc>
    800032ce:	00008497          	auipc	s1,0x8
    800032d2:	d6a48493          	addi	s1,s1,-662 # 8000b038 <root_fs>
    800032d6:	e088                	sd	a0,0(s1)
					kmemmove(root_fs, &vfs_list[1], sizeof(struct vfs));
    800032d8:	1f800613          	li	a2,504
    800032dc:	00007597          	auipc	a1,0x7
    800032e0:	f3458593          	addi	a1,a1,-204 # 8000a210 <vfs_list+0x1f8>
    800032e4:	ffffe097          	auipc	ra,0xffffe
    800032e8:	b6c080e7          	jalr	-1172(ra) # 80000e50 <kmemmove>
					kmemmove(&root_fs->superblock, &superblock, sizeof(struct superblock));
    800032ec:	6088                	ld	a0,0(s1)
    800032ee:	1e000613          	li	a2,480
    800032f2:	e0040593          	addi	a1,s0,-512
    800032f6:	0561                	addi	a0,a0,24
    800032f8:	ffffe097          	auipc	ra,0xffffe
    800032fc:	b58080e7          	jalr	-1192(ra) # 80000e50 <kmemmove>
					kprintf("Loaded valid ext2 file system as root device!\n");
    80003300:	00006517          	auipc	a0,0x6
    80003304:	23850513          	addi	a0,a0,568 # 80009538 <syscalls+0x160>
    80003308:	ffffd097          	auipc	ra,0xffffd
    8000330c:	3a4080e7          	jalr	932(ra) # 800006ac <kprintf>
					return;
    80003310:	b765                	j	800032b8 <root_init+0xba>
					panic("No implementation available for initialising FS type!");
    80003312:	00006517          	auipc	a0,0x6
    80003316:	25650513          	addi	a0,a0,598 # 80009568 <syscalls+0x190>
    8000331a:	ffffd097          	auipc	ra,0xffffd
    8000331e:	348080e7          	jalr	840(ra) # 80000662 <panic>

0000000080003322 <iinit>:
{
    80003322:	1141                	addi	sp,sp,-16
    80003324:	e406                	sd	ra,8(sp)
    80003326:	e022                	sd	s0,0(sp)
    80003328:	0800                	addi	s0,sp,16
	initlock(&itable.lock, "itable");
    8000332a:	00006597          	auipc	a1,0x6
    8000332e:	29658593          	addi	a1,a1,662 # 800095c0 <syscalls+0x1e8>
    80003332:	0001e517          	auipc	a0,0x1e
    80003336:	65650513          	addi	a0,a0,1622 # 80021988 <itable>
    8000333a:	ffffe097          	auipc	ra,0xffffe
    8000333e:	92e080e7          	jalr	-1746(ra) # 80000c68 <initlock>
}
    80003342:	60a2                	ld	ra,8(sp)
    80003344:	6402                	ld	s0,0(sp)
    80003346:	0141                	addi	sp,sp,16
    80003348:	8082                	ret

000000008000334a <namei>:

struct inode * namei(char *path)
{
    8000334a:	1101                	addi	sp,sp,-32
    8000334c:	ec06                	sd	ra,24(sp)
    8000334e:	e822                	sd	s0,16(sp)
    80003350:	1000                	addi	s0,sp,32
	char name[DIRSIZ];
	return namex(path, 0, name);
    80003352:	fe040613          	addi	a2,s0,-32
    80003356:	4581                	li	a1,0
    80003358:	00000097          	auipc	ra,0x0
    8000335c:	cfa080e7          	jalr	-774(ra) # 80003052 <namex>
}
    80003360:	60e2                	ld	ra,24(sp)
    80003362:	6442                	ld	s0,16(sp)
    80003364:	6105                	addi	sp,sp,32
    80003366:	8082                	ret

0000000080003368 <nameiparent>:

struct inode * nameiparent(char *path, char *name)
{
    80003368:	1141                	addi	sp,sp,-16
    8000336a:	e406                	sd	ra,8(sp)
    8000336c:	e022                	sd	s0,0(sp)
    8000336e:	0800                	addi	s0,sp,16
    80003370:	862e                	mv	a2,a1
	return namex(path, 1, name);
    80003372:	4585                	li	a1,1
    80003374:	00000097          	auipc	ra,0x0
    80003378:	cde080e7          	jalr	-802(ra) # 80003052 <namex>
}
    8000337c:	60a2                	ld	ra,8(sp)
    8000337e:	6402                	ld	s0,0(sp)
    80003380:	0141                	addi	sp,sp,16
    80003382:	8082                	ret

0000000080003384 <write_head>:

// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void write_head(void)
{
    80003384:	1101                	addi	sp,sp,-32
    80003386:	ec06                	sd	ra,24(sp)
    80003388:	e822                	sd	s0,16(sp)
    8000338a:	e426                	sd	s1,8(sp)
    8000338c:	e04a                	sd	s2,0(sp)
    8000338e:	1000                	addi	s0,sp,32
	struct buf * buf = sb.vfs_ops->bread(log.dev, log.start);
    80003390:	0001f917          	auipc	s2,0x1f
    80003394:	10090913          	addi	s2,s2,256 # 80022490 <log>
    80003398:	0001e797          	auipc	a5,0x1e
    8000339c:	4187b783          	ld	a5,1048(a5) # 800217b0 <sb+0x8>
    800033a0:	63bc                	ld	a5,64(a5)
    800033a2:	01892583          	lw	a1,24(s2)
    800033a6:	02892503          	lw	a0,40(s2)
    800033aa:	9782                	jalr	a5
    800033ac:	84aa                	mv	s1,a0
	struct logheader * hb = (struct logheader *) (buf->data);
	int i;

	hb->n = log.lh.n;
    800033ae:	02c92683          	lw	a3,44(s2)
    800033b2:	cd34                	sw	a3,88(a0)

	for (i = 0; i < log.lh.n; i++) {
    800033b4:	02d05863          	blez	a3,800033e4 <write_head+0x60>
    800033b8:	0001f797          	auipc	a5,0x1f
    800033bc:	10878793          	addi	a5,a5,264 # 800224c0 <log+0x30>
    800033c0:	05c50713          	addi	a4,a0,92
    800033c4:	36fd                	addiw	a3,a3,-1
    800033c6:	02069613          	slli	a2,a3,0x20
    800033ca:	01e65693          	srli	a3,a2,0x1e
    800033ce:	0001f617          	auipc	a2,0x1f
    800033d2:	0f660613          	addi	a2,a2,246 # 800224c4 <log+0x34>
    800033d6:	96b2                	add	a3,a3,a2
		hb->block[i] = log.lh.block[i];
    800033d8:	4390                	lw	a2,0(a5)
    800033da:	c310                	sw	a2,0(a4)
	for (i = 0; i < log.lh.n; i++) {
    800033dc:	0791                	addi	a5,a5,4
    800033de:	0711                	addi	a4,a4,4
    800033e0:	fed79ce3          	bne	a5,a3,800033d8 <write_head+0x54>
	}

	sb.vfs_ops->bwrite(buf);
    800033e4:	0001e917          	auipc	s2,0x1e
    800033e8:	3c490913          	addi	s2,s2,964 # 800217a8 <sb>
    800033ec:	00893783          	ld	a5,8(s2)
    800033f0:	7f9c                	ld	a5,56(a5)
    800033f2:	8526                	mv	a0,s1
    800033f4:	9782                	jalr	a5
	sb.vfs_ops->brelease(buf);
    800033f6:	00893783          	ld	a5,8(s2)
    800033fa:	7b9c                	ld	a5,48(a5)
    800033fc:	8526                	mv	a0,s1
    800033fe:	9782                	jalr	a5
}
    80003400:	60e2                	ld	ra,24(sp)
    80003402:	6442                	ld	s0,16(sp)
    80003404:	64a2                	ld	s1,8(sp)
    80003406:	6902                	ld	s2,0(sp)
    80003408:	6105                	addi	sp,sp,32
    8000340a:	8082                	ret

000000008000340c <install_trans>:
	for (tail = 0; tail < log.lh.n; tail++) {
    8000340c:	0001f797          	auipc	a5,0x1f
    80003410:	0b07a783          	lw	a5,176(a5) # 800224bc <log+0x2c>
    80003414:	0cf05363          	blez	a5,800034da <install_trans+0xce>
{
    80003418:	715d                	addi	sp,sp,-80
    8000341a:	e486                	sd	ra,72(sp)
    8000341c:	e0a2                	sd	s0,64(sp)
    8000341e:	fc26                	sd	s1,56(sp)
    80003420:	f84a                	sd	s2,48(sp)
    80003422:	f44e                	sd	s3,40(sp)
    80003424:	f052                	sd	s4,32(sp)
    80003426:	ec56                	sd	s5,24(sp)
    80003428:	e85a                	sd	s6,16(sp)
    8000342a:	e45e                	sd	s7,8(sp)
    8000342c:	0880                	addi	s0,sp,80
    8000342e:	8baa                	mv	s7,a0
    80003430:	0001fb17          	auipc	s6,0x1f
    80003434:	090b0b13          	addi	s6,s6,144 # 800224c0 <log+0x30>
	for (tail = 0; tail < log.lh.n; tail++) {
    80003438:	4a81                	li	s5,0
		struct buf * lbuf = sb.vfs_ops->bread(log.dev, log.start + tail + 1); // read log block
    8000343a:	0001fa17          	auipc	s4,0x1f
    8000343e:	056a0a13          	addi	s4,s4,86 # 80022490 <log>
    80003442:	0001e917          	auipc	s2,0x1e
    80003446:	36690913          	addi	s2,s2,870 # 800217a8 <sb>
    8000344a:	a00d                	j	8000346c <install_trans+0x60>
		sb.vfs_ops->brelease(lbuf);
    8000344c:	00893783          	ld	a5,8(s2)
    80003450:	7b9c                	ld	a5,48(a5)
    80003452:	854e                	mv	a0,s3
    80003454:	9782                	jalr	a5
		sb.vfs_ops->brelease(dbuf);
    80003456:	00893783          	ld	a5,8(s2)
    8000345a:	7b9c                	ld	a5,48(a5)
    8000345c:	8526                	mv	a0,s1
    8000345e:	9782                	jalr	a5
	for (tail = 0; tail < log.lh.n; tail++) {
    80003460:	2a85                	addiw	s5,s5,1
    80003462:	0b11                	addi	s6,s6,4
    80003464:	02ca2783          	lw	a5,44(s4)
    80003468:	04fade63          	bge	s5,a5,800034c4 <install_trans+0xb8>
		struct buf * lbuf = sb.vfs_ops->bread(log.dev, log.start + tail + 1); // read log block
    8000346c:	018a2583          	lw	a1,24(s4)
    80003470:	015585bb          	addw	a1,a1,s5
    80003474:	00893783          	ld	a5,8(s2)
    80003478:	63bc                	ld	a5,64(a5)
    8000347a:	2585                	addiw	a1,a1,1
    8000347c:	028a2503          	lw	a0,40(s4)
    80003480:	9782                	jalr	a5
    80003482:	89aa                	mv	s3,a0
		struct buf * dbuf = sb.vfs_ops->bread(log.dev, log.lh.block[tail]); // read dst
    80003484:	00893783          	ld	a5,8(s2)
    80003488:	63bc                	ld	a5,64(a5)
    8000348a:	000b2583          	lw	a1,0(s6)
    8000348e:	028a2503          	lw	a0,40(s4)
    80003492:	9782                	jalr	a5
    80003494:	84aa                	mv	s1,a0
		kmemmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
    80003496:	40000613          	li	a2,1024
    8000349a:	05898593          	addi	a1,s3,88
    8000349e:	05850513          	addi	a0,a0,88
    800034a2:	ffffe097          	auipc	ra,0xffffe
    800034a6:	9ae080e7          	jalr	-1618(ra) # 80000e50 <kmemmove>
		sb.vfs_ops->bwrite(dbuf);  // write dst to disk
    800034aa:	00893783          	ld	a5,8(s2)
    800034ae:	7f9c                	ld	a5,56(a5)
    800034b0:	8526                	mv	a0,s1
    800034b2:	9782                	jalr	a5
		if(recovering == 0)
    800034b4:	f80b9ce3          	bnez	s7,8000344c <install_trans+0x40>
			bunpin(dbuf);
    800034b8:	8526                	mv	a0,s1
    800034ba:	00000097          	auipc	ra,0x0
    800034be:	b5c080e7          	jalr	-1188(ra) # 80003016 <bunpin>
    800034c2:	b769                	j	8000344c <install_trans+0x40>
}
    800034c4:	60a6                	ld	ra,72(sp)
    800034c6:	6406                	ld	s0,64(sp)
    800034c8:	74e2                	ld	s1,56(sp)
    800034ca:	7942                	ld	s2,48(sp)
    800034cc:	79a2                	ld	s3,40(sp)
    800034ce:	7a02                	ld	s4,32(sp)
    800034d0:	6ae2                	ld	s5,24(sp)
    800034d2:	6b42                	ld	s6,16(sp)
    800034d4:	6ba2                	ld	s7,8(sp)
    800034d6:	6161                	addi	sp,sp,80
    800034d8:	8082                	ret
    800034da:	8082                	ret

00000000800034dc <initlog>:
{
    800034dc:	1101                	addi	sp,sp,-32
    800034de:	ec06                	sd	ra,24(sp)
    800034e0:	e822                	sd	s0,16(sp)
    800034e2:	e426                	sd	s1,8(sp)
    800034e4:	e04a                	sd	s2,0(sp)
    800034e6:	1000                	addi	s0,sp,32
    800034e8:	892a                	mv	s2,a0
	initlock(&log.lock, "log");
    800034ea:	0001f497          	auipc	s1,0x1f
    800034ee:	fa648493          	addi	s1,s1,-90 # 80022490 <log>
    800034f2:	00006597          	auipc	a1,0x6
    800034f6:	0e658593          	addi	a1,a1,230 # 800095d8 <syscalls+0x200>
    800034fa:	8526                	mv	a0,s1
    800034fc:	ffffd097          	auipc	ra,0xffffd
    80003500:	76c080e7          	jalr	1900(ra) # 80000c68 <initlock>
	log.start = sb.xv6_superblock.logstart;
    80003504:	0001e797          	auipc	a5,0x1e
    80003508:	2a478793          	addi	a5,a5,676 # 800217a8 <sb>
    8000350c:	57cc                	lw	a1,44(a5)
    8000350e:	cc8c                	sw	a1,24(s1)
	log.size = sb.xv6_superblock.nlog;
    80003510:	5798                	lw	a4,40(a5)
    80003512:	ccd8                	sw	a4,28(s1)
	log.dev = dev;
    80003514:	0324a423          	sw	s2,40(s1)
	struct buf *buf = sb.vfs_ops->bread(log.dev, log.start);
    80003518:	679c                	ld	a5,8(a5)
    8000351a:	63bc                	ld	a5,64(a5)
    8000351c:	854a                	mv	a0,s2
    8000351e:	9782                	jalr	a5
	log.lh.n = lh->n;
    80003520:	4d34                	lw	a3,88(a0)
    80003522:	d4d4                	sw	a3,44(s1)
	for(i = 0; i < log.lh.n; i++) {
    80003524:	02d05663          	blez	a3,80003550 <initlog+0x74>
    80003528:	05c50793          	addi	a5,a0,92
    8000352c:	0001f717          	auipc	a4,0x1f
    80003530:	f9470713          	addi	a4,a4,-108 # 800224c0 <log+0x30>
    80003534:	36fd                	addiw	a3,a3,-1
    80003536:	02069613          	slli	a2,a3,0x20
    8000353a:	01e65693          	srli	a3,a2,0x1e
    8000353e:	06050613          	addi	a2,a0,96
    80003542:	96b2                	add	a3,a3,a2
		log.lh.block[i] = lh->block[i];
    80003544:	4390                	lw	a2,0(a5)
    80003546:	c310                	sw	a2,0(a4)
	for(i = 0; i < log.lh.n; i++) {
    80003548:	0791                	addi	a5,a5,4
    8000354a:	0711                	addi	a4,a4,4
    8000354c:	fed79ce3          	bne	a5,a3,80003544 <initlog+0x68>
	sb.vfs_ops->brelease(buf);
    80003550:	0001e797          	auipc	a5,0x1e
    80003554:	2607b783          	ld	a5,608(a5) # 800217b0 <sb+0x8>
    80003558:	7b9c                	ld	a5,48(a5)
    8000355a:	9782                	jalr	a5

static void recover_from_log(void)
{
	read_head();
	install_trans(1); // if committed, copy from log to disk
    8000355c:	4505                	li	a0,1
    8000355e:	00000097          	auipc	ra,0x0
    80003562:	eae080e7          	jalr	-338(ra) # 8000340c <install_trans>

	log.lh.n = 0;
    80003566:	0001f797          	auipc	a5,0x1f
    8000356a:	f407ab23          	sw	zero,-170(a5) # 800224bc <log+0x2c>

	write_head(); // clear the log
    8000356e:	00000097          	auipc	ra,0x0
    80003572:	e16080e7          	jalr	-490(ra) # 80003384 <write_head>
}
    80003576:	60e2                	ld	ra,24(sp)
    80003578:	6442                	ld	s0,16(sp)
    8000357a:	64a2                	ld	s1,8(sp)
    8000357c:	6902                	ld	s2,0(sp)
    8000357e:	6105                	addi	sp,sp,32
    80003580:	8082                	ret

0000000080003582 <begin_op>:
}

// called at the start of each FS system call.
void begin_op(void)
{
    80003582:	1101                	addi	sp,sp,-32
    80003584:	ec06                	sd	ra,24(sp)
    80003586:	e822                	sd	s0,16(sp)
    80003588:	e426                	sd	s1,8(sp)
    8000358a:	e04a                	sd	s2,0(sp)
    8000358c:	1000                	addi	s0,sp,32
	acquire(&log.lock);
    8000358e:	0001f517          	auipc	a0,0x1f
    80003592:	f0250513          	addi	a0,a0,-254 # 80022490 <log>
    80003596:	ffffd097          	auipc	ra,0xffffd
    8000359a:	762080e7          	jalr	1890(ra) # 80000cf8 <acquire>

	while(1) {
		if(log.committing) {
    8000359e:	0001f497          	auipc	s1,0x1f
    800035a2:	ef248493          	addi	s1,s1,-270 # 80022490 <log>
			_sleep(&log, &log.lock);
		} else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE) {
    800035a6:	4979                	li	s2,30
    800035a8:	a039                	j	800035b6 <begin_op+0x34>
			_sleep(&log, &log.lock);
    800035aa:	85a6                	mv	a1,s1
    800035ac:	8526                	mv	a0,s1
    800035ae:	fffff097          	auipc	ra,0xfffff
    800035b2:	c04080e7          	jalr	-1020(ra) # 800021b2 <_sleep>
		if(log.committing) {
    800035b6:	50dc                	lw	a5,36(s1)
    800035b8:	fbed                	bnez	a5,800035aa <begin_op+0x28>
		} else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE) {
    800035ba:	5098                	lw	a4,32(s1)
    800035bc:	2705                	addiw	a4,a4,1
    800035be:	0007069b          	sext.w	a3,a4
    800035c2:	0027179b          	slliw	a5,a4,0x2
    800035c6:	9fb9                	addw	a5,a5,a4
    800035c8:	0017979b          	slliw	a5,a5,0x1
    800035cc:	54d8                	lw	a4,44(s1)
    800035ce:	9fb9                	addw	a5,a5,a4
    800035d0:	00f95963          	bge	s2,a5,800035e2 <begin_op+0x60>
			// this op might exhaust log space; wait for commit.
			_sleep(&log, &log.lock);
    800035d4:	85a6                	mv	a1,s1
    800035d6:	8526                	mv	a0,s1
    800035d8:	fffff097          	auipc	ra,0xfffff
    800035dc:	bda080e7          	jalr	-1062(ra) # 800021b2 <_sleep>
    800035e0:	bfd9                	j	800035b6 <begin_op+0x34>
		} else {
			log.outstanding += 1;
    800035e2:	0001f517          	auipc	a0,0x1f
    800035e6:	eae50513          	addi	a0,a0,-338 # 80022490 <log>
    800035ea:	d114                	sw	a3,32(a0)
			release(&log.lock);
    800035ec:	ffffd097          	auipc	ra,0xffffd
    800035f0:	7c0080e7          	jalr	1984(ra) # 80000dac <release>
			break;
		}
	}
}
    800035f4:	60e2                	ld	ra,24(sp)
    800035f6:	6442                	ld	s0,16(sp)
    800035f8:	64a2                	ld	s1,8(sp)
    800035fa:	6902                	ld	s2,0(sp)
    800035fc:	6105                	addi	sp,sp,32
    800035fe:	8082                	ret

0000000080003600 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void end_op(void)
{
    80003600:	7139                	addi	sp,sp,-64
    80003602:	fc06                	sd	ra,56(sp)
    80003604:	f822                	sd	s0,48(sp)
    80003606:	f426                	sd	s1,40(sp)
    80003608:	f04a                	sd	s2,32(sp)
    8000360a:	ec4e                	sd	s3,24(sp)
    8000360c:	e852                	sd	s4,16(sp)
    8000360e:	e456                	sd	s5,8(sp)
    80003610:	e05a                	sd	s6,0(sp)
    80003612:	0080                	addi	s0,sp,64
	int do_commit = 0;

	acquire(&log.lock);
    80003614:	0001f497          	auipc	s1,0x1f
    80003618:	e7c48493          	addi	s1,s1,-388 # 80022490 <log>
    8000361c:	8526                	mv	a0,s1
    8000361e:	ffffd097          	auipc	ra,0xffffd
    80003622:	6da080e7          	jalr	1754(ra) # 80000cf8 <acquire>

	log.outstanding -= 1;
    80003626:	509c                	lw	a5,32(s1)
    80003628:	37fd                	addiw	a5,a5,-1
    8000362a:	0007891b          	sext.w	s2,a5
    8000362e:	d09c                	sw	a5,32(s1)

	if(log.committing) {
    80003630:	50dc                	lw	a5,36(s1)
    80003632:	e7b9                	bnez	a5,80003680 <end_op+0x80>
		panic("log.committing");
	}

	if(log.outstanding == 0) {
    80003634:	04091e63          	bnez	s2,80003690 <end_op+0x90>
		do_commit = 1;
		log.committing = 1;
    80003638:	0001f497          	auipc	s1,0x1f
    8000363c:	e5848493          	addi	s1,s1,-424 # 80022490 <log>
    80003640:	4785                	li	a5,1
    80003642:	d0dc                	sw	a5,36(s1)
		// and decrementing log.outstanding has decreased
		// the amount of reserved space.
		wakeup(&log);
	}

	release(&log.lock);
    80003644:	8526                	mv	a0,s1
    80003646:	ffffd097          	auipc	ra,0xffffd
    8000364a:	766080e7          	jalr	1894(ra) # 80000dac <release>
	}
}

static void commit()
{
	if(log.lh.n > 0) {
    8000364e:	54dc                	lw	a5,44(s1)
    80003650:	06f04863          	bgtz	a5,800036c0 <end_op+0xc0>
		acquire(&log.lock);
    80003654:	0001f497          	auipc	s1,0x1f
    80003658:	e3c48493          	addi	s1,s1,-452 # 80022490 <log>
    8000365c:	8526                	mv	a0,s1
    8000365e:	ffffd097          	auipc	ra,0xffffd
    80003662:	69a080e7          	jalr	1690(ra) # 80000cf8 <acquire>
		log.committing = 0;
    80003666:	0204a223          	sw	zero,36(s1)
		wakeup(&log);
    8000366a:	8526                	mv	a0,s1
    8000366c:	fffff097          	auipc	ra,0xfffff
    80003670:	cd2080e7          	jalr	-814(ra) # 8000233e <wakeup>
		release(&log.lock);
    80003674:	8526                	mv	a0,s1
    80003676:	ffffd097          	auipc	ra,0xffffd
    8000367a:	736080e7          	jalr	1846(ra) # 80000dac <release>
}
    8000367e:	a03d                	j	800036ac <end_op+0xac>
		panic("log.committing");
    80003680:	00006517          	auipc	a0,0x6
    80003684:	f6050513          	addi	a0,a0,-160 # 800095e0 <syscalls+0x208>
    80003688:	ffffd097          	auipc	ra,0xffffd
    8000368c:	fda080e7          	jalr	-38(ra) # 80000662 <panic>
		wakeup(&log);
    80003690:	0001f497          	auipc	s1,0x1f
    80003694:	e0048493          	addi	s1,s1,-512 # 80022490 <log>
    80003698:	8526                	mv	a0,s1
    8000369a:	fffff097          	auipc	ra,0xfffff
    8000369e:	ca4080e7          	jalr	-860(ra) # 8000233e <wakeup>
	release(&log.lock);
    800036a2:	8526                	mv	a0,s1
    800036a4:	ffffd097          	auipc	ra,0xffffd
    800036a8:	708080e7          	jalr	1800(ra) # 80000dac <release>
}
    800036ac:	70e2                	ld	ra,56(sp)
    800036ae:	7442                	ld	s0,48(sp)
    800036b0:	74a2                	ld	s1,40(sp)
    800036b2:	7902                	ld	s2,32(sp)
    800036b4:	69e2                	ld	s3,24(sp)
    800036b6:	6a42                	ld	s4,16(sp)
    800036b8:	6aa2                	ld	s5,8(sp)
    800036ba:	6b02                	ld	s6,0(sp)
    800036bc:	6121                	addi	sp,sp,64
    800036be:	8082                	ret
	for (tail = 0; tail < log.lh.n; tail++) {
    800036c0:	0001fb17          	auipc	s6,0x1f
    800036c4:	e00b0b13          	addi	s6,s6,-512 # 800224c0 <log+0x30>
		struct buf * to = sb.vfs_ops->bread(log.dev, log.start + tail + 1); // log block
    800036c8:	0001fa97          	auipc	s5,0x1f
    800036cc:	dc8a8a93          	addi	s5,s5,-568 # 80022490 <log>
    800036d0:	0001e997          	auipc	s3,0x1e
    800036d4:	0d898993          	addi	s3,s3,216 # 800217a8 <sb>
    800036d8:	018aa583          	lw	a1,24(s5)
    800036dc:	012585bb          	addw	a1,a1,s2
    800036e0:	0089b783          	ld	a5,8(s3)
    800036e4:	63bc                	ld	a5,64(a5)
    800036e6:	2585                	addiw	a1,a1,1
    800036e8:	028aa503          	lw	a0,40(s5)
    800036ec:	9782                	jalr	a5
    800036ee:	84aa                	mv	s1,a0
		struct buf * from = sb.vfs_ops->bread(log.dev, log.lh.block[tail]); // cache block
    800036f0:	0089b783          	ld	a5,8(s3)
    800036f4:	63bc                	ld	a5,64(a5)
    800036f6:	000b2583          	lw	a1,0(s6)
    800036fa:	028aa503          	lw	a0,40(s5)
    800036fe:	9782                	jalr	a5
    80003700:	8a2a                	mv	s4,a0
		kmemmove(to->data, from->data, BSIZE);
    80003702:	40000613          	li	a2,1024
    80003706:	05850593          	addi	a1,a0,88
    8000370a:	05848513          	addi	a0,s1,88
    8000370e:	ffffd097          	auipc	ra,0xffffd
    80003712:	742080e7          	jalr	1858(ra) # 80000e50 <kmemmove>
		sb.vfs_ops->bwrite(to);  // write the log
    80003716:	0089b783          	ld	a5,8(s3)
    8000371a:	7f9c                	ld	a5,56(a5)
    8000371c:	8526                	mv	a0,s1
    8000371e:	9782                	jalr	a5
		sb.vfs_ops->brelease(from);
    80003720:	0089b783          	ld	a5,8(s3)
    80003724:	7b9c                	ld	a5,48(a5)
    80003726:	8552                	mv	a0,s4
    80003728:	9782                	jalr	a5
		sb.vfs_ops->brelease(to);
    8000372a:	0089b783          	ld	a5,8(s3)
    8000372e:	7b9c                	ld	a5,48(a5)
    80003730:	8526                	mv	a0,s1
    80003732:	9782                	jalr	a5
	for (tail = 0; tail < log.lh.n; tail++) {
    80003734:	2905                	addiw	s2,s2,1
    80003736:	0b11                	addi	s6,s6,4
    80003738:	02caa783          	lw	a5,44(s5)
    8000373c:	f8f94ee3          	blt	s2,a5,800036d8 <end_op+0xd8>
		write_log();     // Write modified blocks from cache to log
		write_head();    // Write header to disk -- the real commit
    80003740:	00000097          	auipc	ra,0x0
    80003744:	c44080e7          	jalr	-956(ra) # 80003384 <write_head>
		install_trans(0); // Now install writes to home locations
    80003748:	4501                	li	a0,0
    8000374a:	00000097          	auipc	ra,0x0
    8000374e:	cc2080e7          	jalr	-830(ra) # 8000340c <install_trans>

		log.lh.n = 0;
    80003752:	0001f797          	auipc	a5,0x1f
    80003756:	d607a523          	sw	zero,-662(a5) # 800224bc <log+0x2c>

		write_head();    // Erase the transaction from the log
    8000375a:	00000097          	auipc	ra,0x0
    8000375e:	c2a080e7          	jalr	-982(ra) # 80003384 <write_head>
    80003762:	bdcd                	j	80003654 <end_op+0x54>

0000000080003764 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelease(bp)

void log_write(struct buf * b)
{
    80003764:	1101                	addi	sp,sp,-32
    80003766:	ec06                	sd	ra,24(sp)
    80003768:	e822                	sd	s0,16(sp)
    8000376a:	e426                	sd	s1,8(sp)
    8000376c:	e04a                	sd	s2,0(sp)
    8000376e:	1000                	addi	s0,sp,32
    80003770:	84aa                	mv	s1,a0
	int i;

	acquire(&log.lock);
    80003772:	0001f917          	auipc	s2,0x1f
    80003776:	d1e90913          	addi	s2,s2,-738 # 80022490 <log>
    8000377a:	854a                	mv	a0,s2
    8000377c:	ffffd097          	auipc	ra,0xffffd
    80003780:	57c080e7          	jalr	1404(ra) # 80000cf8 <acquire>

	if(log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1) {
    80003784:	02c92603          	lw	a2,44(s2)
    80003788:	47f5                	li	a5,29
    8000378a:	06c7c563          	blt	a5,a2,800037f4 <log_write+0x90>
    8000378e:	0001f797          	auipc	a5,0x1f
    80003792:	d1e7a783          	lw	a5,-738(a5) # 800224ac <log+0x1c>
    80003796:	37fd                	addiw	a5,a5,-1
    80003798:	04f65e63          	bge	a2,a5,800037f4 <log_write+0x90>
		panic("too big a transaction");
	}

	if(log.outstanding < 1) {
    8000379c:	0001f797          	auipc	a5,0x1f
    800037a0:	d147a783          	lw	a5,-748(a5) # 800224b0 <log+0x20>
    800037a4:	06f05063          	blez	a5,80003804 <log_write+0xa0>
		panic("log_write outside of trans");
	}

	for(i = 0; i < log.lh.n; i++) {
    800037a8:	4781                	li	a5,0
    800037aa:	06c05563          	blez	a2,80003814 <log_write+0xb0>
		if(log.lh.block[i] == b->blockno) {   // log absorption
    800037ae:	44cc                	lw	a1,12(s1)
    800037b0:	0001f717          	auipc	a4,0x1f
    800037b4:	d1070713          	addi	a4,a4,-752 # 800224c0 <log+0x30>
	for(i = 0; i < log.lh.n; i++) {
    800037b8:	4781                	li	a5,0
		if(log.lh.block[i] == b->blockno) {   // log absorption
    800037ba:	4314                	lw	a3,0(a4)
    800037bc:	04b68c63          	beq	a3,a1,80003814 <log_write+0xb0>
	for(i = 0; i < log.lh.n; i++) {
    800037c0:	2785                	addiw	a5,a5,1
    800037c2:	0711                	addi	a4,a4,4
    800037c4:	fef61be3          	bne	a2,a5,800037ba <log_write+0x56>
			break;
		}
	}

	log.lh.block[i] = b->blockno;
    800037c8:	0621                	addi	a2,a2,8
    800037ca:	060a                	slli	a2,a2,0x2
    800037cc:	0001f797          	auipc	a5,0x1f
    800037d0:	cc478793          	addi	a5,a5,-828 # 80022490 <log>
    800037d4:	97b2                	add	a5,a5,a2
    800037d6:	44d8                	lw	a4,12(s1)
    800037d8:	cb98                	sw	a4,16(a5)

	if(i == log.lh.n) {  // Add new block to log?
		bpin(b);
    800037da:	8526                	mv	a0,s1
    800037dc:	fffff097          	auipc	ra,0xfffff
    800037e0:	7fe080e7          	jalr	2046(ra) # 80002fda <bpin>
		log.lh.n++;
    800037e4:	0001f717          	auipc	a4,0x1f
    800037e8:	cac70713          	addi	a4,a4,-852 # 80022490 <log>
    800037ec:	575c                	lw	a5,44(a4)
    800037ee:	2785                	addiw	a5,a5,1
    800037f0:	d75c                	sw	a5,44(a4)
    800037f2:	a82d                	j	8000382c <log_write+0xc8>
		panic("too big a transaction");
    800037f4:	00006517          	auipc	a0,0x6
    800037f8:	dfc50513          	addi	a0,a0,-516 # 800095f0 <syscalls+0x218>
    800037fc:	ffffd097          	auipc	ra,0xffffd
    80003800:	e66080e7          	jalr	-410(ra) # 80000662 <panic>
		panic("log_write outside of trans");
    80003804:	00006517          	auipc	a0,0x6
    80003808:	e0450513          	addi	a0,a0,-508 # 80009608 <syscalls+0x230>
    8000380c:	ffffd097          	auipc	ra,0xffffd
    80003810:	e56080e7          	jalr	-426(ra) # 80000662 <panic>
	log.lh.block[i] = b->blockno;
    80003814:	00878693          	addi	a3,a5,8
    80003818:	068a                	slli	a3,a3,0x2
    8000381a:	0001f717          	auipc	a4,0x1f
    8000381e:	c7670713          	addi	a4,a4,-906 # 80022490 <log>
    80003822:	9736                	add	a4,a4,a3
    80003824:	44d4                	lw	a3,12(s1)
    80003826:	cb14                	sw	a3,16(a4)
	if(i == log.lh.n) {  // Add new block to log?
    80003828:	faf609e3          	beq	a2,a5,800037da <log_write+0x76>
	}

	release(&log.lock);
    8000382c:	0001f517          	auipc	a0,0x1f
    80003830:	c6450513          	addi	a0,a0,-924 # 80022490 <log>
    80003834:	ffffd097          	auipc	ra,0xffffd
    80003838:	578080e7          	jalr	1400(ra) # 80000dac <release>
}
    8000383c:	60e2                	ld	ra,24(sp)
    8000383e:	6442                	ld	s0,16(sp)
    80003840:	64a2                	ld	s1,8(sp)
    80003842:	6902                	ld	s2,0(sp)
    80003844:	6105                	addi	sp,sp,32
    80003846:	8082                	ret

0000000080003848 <initsleeplock>:
#include <kernel/spinlock.h>
#include <kernel/proc.h>
#include <kernel/sleeplock.h>

void initsleeplock(struct sleeplock * lk, char * name)
{
    80003848:	1101                	addi	sp,sp,-32
    8000384a:	ec06                	sd	ra,24(sp)
    8000384c:	e822                	sd	s0,16(sp)
    8000384e:	e426                	sd	s1,8(sp)
    80003850:	e04a                	sd	s2,0(sp)
    80003852:	1000                	addi	s0,sp,32
    80003854:	84aa                	mv	s1,a0
    80003856:	892e                	mv	s2,a1
	initlock(&lk->lk, "sleep lock");
    80003858:	00006597          	auipc	a1,0x6
    8000385c:	dd058593          	addi	a1,a1,-560 # 80009628 <syscalls+0x250>
    80003860:	0521                	addi	a0,a0,8
    80003862:	ffffd097          	auipc	ra,0xffffd
    80003866:	406080e7          	jalr	1030(ra) # 80000c68 <initlock>
	lk->name = name;
    8000386a:	0324b023          	sd	s2,32(s1)
	lk->locked = 0;
    8000386e:	0004a023          	sw	zero,0(s1)
	lk->pid = 0;
    80003872:	0204a423          	sw	zero,40(s1)
}
    80003876:	60e2                	ld	ra,24(sp)
    80003878:	6442                	ld	s0,16(sp)
    8000387a:	64a2                	ld	s1,8(sp)
    8000387c:	6902                	ld	s2,0(sp)
    8000387e:	6105                	addi	sp,sp,32
    80003880:	8082                	ret

0000000080003882 <acquiresleep>:

void acquiresleep(struct sleeplock * lk)
{
    80003882:	1101                	addi	sp,sp,-32
    80003884:	ec06                	sd	ra,24(sp)
    80003886:	e822                	sd	s0,16(sp)
    80003888:	e426                	sd	s1,8(sp)
    8000388a:	e04a                	sd	s2,0(sp)
    8000388c:	1000                	addi	s0,sp,32
    8000388e:	84aa                	mv	s1,a0
	acquire(&lk->lk);
    80003890:	00850913          	addi	s2,a0,8
    80003894:	854a                	mv	a0,s2
    80003896:	ffffd097          	auipc	ra,0xffffd
    8000389a:	462080e7          	jalr	1122(ra) # 80000cf8 <acquire>

	while (lk->locked) {
    8000389e:	409c                	lw	a5,0(s1)
    800038a0:	cb89                	beqz	a5,800038b2 <acquiresleep+0x30>
		_sleep(lk, &lk->lk);
    800038a2:	85ca                	mv	a1,s2
    800038a4:	8526                	mv	a0,s1
    800038a6:	fffff097          	auipc	ra,0xfffff
    800038aa:	90c080e7          	jalr	-1780(ra) # 800021b2 <_sleep>
	while (lk->locked) {
    800038ae:	409c                	lw	a5,0(s1)
    800038b0:	fbed                	bnez	a5,800038a2 <acquiresleep+0x20>
	}

	lk->locked = 1;
    800038b2:	4785                	li	a5,1
    800038b4:	c09c                	sw	a5,0(s1)

	lk->pid = myproc()->pid;
    800038b6:	ffffe097          	auipc	ra,0xffffe
    800038ba:	22e080e7          	jalr	558(ra) # 80001ae4 <myproc>
    800038be:	591c                	lw	a5,48(a0)
    800038c0:	d49c                	sw	a5,40(s1)
	
	release(&lk->lk);
    800038c2:	854a                	mv	a0,s2
    800038c4:	ffffd097          	auipc	ra,0xffffd
    800038c8:	4e8080e7          	jalr	1256(ra) # 80000dac <release>
}
    800038cc:	60e2                	ld	ra,24(sp)
    800038ce:	6442                	ld	s0,16(sp)
    800038d0:	64a2                	ld	s1,8(sp)
    800038d2:	6902                	ld	s2,0(sp)
    800038d4:	6105                	addi	sp,sp,32
    800038d6:	8082                	ret

00000000800038d8 <releasesleep>:

void releasesleep(struct sleeplock * lk)
{
    800038d8:	1101                	addi	sp,sp,-32
    800038da:	ec06                	sd	ra,24(sp)
    800038dc:	e822                	sd	s0,16(sp)
    800038de:	e426                	sd	s1,8(sp)
    800038e0:	e04a                	sd	s2,0(sp)
    800038e2:	1000                	addi	s0,sp,32
    800038e4:	84aa                	mv	s1,a0
	acquire(&lk->lk);
    800038e6:	00850913          	addi	s2,a0,8
    800038ea:	854a                	mv	a0,s2
    800038ec:	ffffd097          	auipc	ra,0xffffd
    800038f0:	40c080e7          	jalr	1036(ra) # 80000cf8 <acquire>
	lk->locked = 0;
    800038f4:	0004a023          	sw	zero,0(s1)
	lk->pid = 0;
    800038f8:	0204a423          	sw	zero,40(s1)
	wakeup(lk);
    800038fc:	8526                	mv	a0,s1
    800038fe:	fffff097          	auipc	ra,0xfffff
    80003902:	a40080e7          	jalr	-1472(ra) # 8000233e <wakeup>
	release(&lk->lk);
    80003906:	854a                	mv	a0,s2
    80003908:	ffffd097          	auipc	ra,0xffffd
    8000390c:	4a4080e7          	jalr	1188(ra) # 80000dac <release>
}
    80003910:	60e2                	ld	ra,24(sp)
    80003912:	6442                	ld	s0,16(sp)
    80003914:	64a2                	ld	s1,8(sp)
    80003916:	6902                	ld	s2,0(sp)
    80003918:	6105                	addi	sp,sp,32
    8000391a:	8082                	ret

000000008000391c <holdingsleep>:

int holdingsleep(struct sleeplock * lk)
{
    8000391c:	7179                	addi	sp,sp,-48
    8000391e:	f406                	sd	ra,40(sp)
    80003920:	f022                	sd	s0,32(sp)
    80003922:	ec26                	sd	s1,24(sp)
    80003924:	e84a                	sd	s2,16(sp)
    80003926:	e44e                	sd	s3,8(sp)
    80003928:	1800                	addi	s0,sp,48
    8000392a:	84aa                	mv	s1,a0
	int r;
	
	acquire(&lk->lk);
    8000392c:	00850913          	addi	s2,a0,8
    80003930:	854a                	mv	a0,s2
    80003932:	ffffd097          	auipc	ra,0xffffd
    80003936:	3c6080e7          	jalr	966(ra) # 80000cf8 <acquire>
	r = lk->locked && (lk->pid == myproc()->pid);
    8000393a:	409c                	lw	a5,0(s1)
    8000393c:	ef99                	bnez	a5,8000395a <holdingsleep+0x3e>
    8000393e:	4481                	li	s1,0
	release(&lk->lk);
    80003940:	854a                	mv	a0,s2
    80003942:	ffffd097          	auipc	ra,0xffffd
    80003946:	46a080e7          	jalr	1130(ra) # 80000dac <release>
	return r;
}
    8000394a:	8526                	mv	a0,s1
    8000394c:	70a2                	ld	ra,40(sp)
    8000394e:	7402                	ld	s0,32(sp)
    80003950:	64e2                	ld	s1,24(sp)
    80003952:	6942                	ld	s2,16(sp)
    80003954:	69a2                	ld	s3,8(sp)
    80003956:	6145                	addi	sp,sp,48
    80003958:	8082                	ret
	r = lk->locked && (lk->pid == myproc()->pid);
    8000395a:	0284a983          	lw	s3,40(s1)
    8000395e:	ffffe097          	auipc	ra,0xffffe
    80003962:	186080e7          	jalr	390(ra) # 80001ae4 <myproc>
    80003966:	5904                	lw	s1,48(a0)
    80003968:	413484b3          	sub	s1,s1,s3
    8000396c:	0014b493          	seqz	s1,s1
    80003970:	bfc1                	j	80003940 <holdingsleep+0x24>

0000000080003972 <fileinit>:
	struct spinlock lock;
	struct file file[NFILE];
} ftable;

void fileinit(void)
{
    80003972:	1141                	addi	sp,sp,-16
    80003974:	e406                	sd	ra,8(sp)
    80003976:	e022                	sd	s0,0(sp)
    80003978:	0800                	addi	s0,sp,16
	initlock(&ftable.lock, "ftable");
    8000397a:	00006597          	auipc	a1,0x6
    8000397e:	cbe58593          	addi	a1,a1,-834 # 80009638 <syscalls+0x260>
    80003982:	0001f517          	auipc	a0,0x1f
    80003986:	c5650513          	addi	a0,a0,-938 # 800225d8 <ftable>
    8000398a:	ffffd097          	auipc	ra,0xffffd
    8000398e:	2de080e7          	jalr	734(ra) # 80000c68 <initlock>
}
    80003992:	60a2                	ld	ra,8(sp)
    80003994:	6402                	ld	s0,0(sp)
    80003996:	0141                	addi	sp,sp,16
    80003998:	8082                	ret

000000008000399a <filealloc>:

// Allocate a file structure.
struct file* filealloc(void)
{
    8000399a:	1101                	addi	sp,sp,-32
    8000399c:	ec06                	sd	ra,24(sp)
    8000399e:	e822                	sd	s0,16(sp)
    800039a0:	e426                	sd	s1,8(sp)
    800039a2:	1000                	addi	s0,sp,32
	struct file *f;

	acquire(&ftable.lock);
    800039a4:	0001f517          	auipc	a0,0x1f
    800039a8:	c3450513          	addi	a0,a0,-972 # 800225d8 <ftable>
    800039ac:	ffffd097          	auipc	ra,0xffffd
    800039b0:	34c080e7          	jalr	844(ra) # 80000cf8 <acquire>

	for(f = ftable.file; f < ftable.file + NFILE; f++) {
    800039b4:	0001f497          	auipc	s1,0x1f
    800039b8:	c3c48493          	addi	s1,s1,-964 # 800225f0 <ftable+0x18>
    800039bc:	00020717          	auipc	a4,0x20
    800039c0:	bd470713          	addi	a4,a4,-1068 # 80023590 <ftable+0xfb8>
		if(f->ref == 0) {
    800039c4:	40dc                	lw	a5,4(s1)
    800039c6:	cf99                	beqz	a5,800039e4 <filealloc+0x4a>
	for(f = ftable.file; f < ftable.file + NFILE; f++) {
    800039c8:	02848493          	addi	s1,s1,40
    800039cc:	fee49ce3          	bne	s1,a4,800039c4 <filealloc+0x2a>
			release(&ftable.lock);
			return f;
		}
	}

	release(&ftable.lock);
    800039d0:	0001f517          	auipc	a0,0x1f
    800039d4:	c0850513          	addi	a0,a0,-1016 # 800225d8 <ftable>
    800039d8:	ffffd097          	auipc	ra,0xffffd
    800039dc:	3d4080e7          	jalr	980(ra) # 80000dac <release>

	return 0;
    800039e0:	4481                	li	s1,0
    800039e2:	a819                	j	800039f8 <filealloc+0x5e>
			f->ref = 1;
    800039e4:	4785                	li	a5,1
    800039e6:	c0dc                	sw	a5,4(s1)
			release(&ftable.lock);
    800039e8:	0001f517          	auipc	a0,0x1f
    800039ec:	bf050513          	addi	a0,a0,-1040 # 800225d8 <ftable>
    800039f0:	ffffd097          	auipc	ra,0xffffd
    800039f4:	3bc080e7          	jalr	956(ra) # 80000dac <release>
}
    800039f8:	8526                	mv	a0,s1
    800039fa:	60e2                	ld	ra,24(sp)
    800039fc:	6442                	ld	s0,16(sp)
    800039fe:	64a2                	ld	s1,8(sp)
    80003a00:	6105                	addi	sp,sp,32
    80003a02:	8082                	ret

0000000080003a04 <filedup>:

// Increment ref count for file f.
struct file* filedup(struct file *f)
{
    80003a04:	1101                	addi	sp,sp,-32
    80003a06:	ec06                	sd	ra,24(sp)
    80003a08:	e822                	sd	s0,16(sp)
    80003a0a:	e426                	sd	s1,8(sp)
    80003a0c:	1000                	addi	s0,sp,32
    80003a0e:	84aa                	mv	s1,a0
	acquire(&ftable.lock);
    80003a10:	0001f517          	auipc	a0,0x1f
    80003a14:	bc850513          	addi	a0,a0,-1080 # 800225d8 <ftable>
    80003a18:	ffffd097          	auipc	ra,0xffffd
    80003a1c:	2e0080e7          	jalr	736(ra) # 80000cf8 <acquire>

	if(f->ref < 1) {
    80003a20:	40dc                	lw	a5,4(s1)
    80003a22:	02f05263          	blez	a5,80003a46 <filedup+0x42>
		panic("filedup()");
	}

	f->ref++;
    80003a26:	2785                	addiw	a5,a5,1
    80003a28:	c0dc                	sw	a5,4(s1)
	
	release(&ftable.lock);
    80003a2a:	0001f517          	auipc	a0,0x1f
    80003a2e:	bae50513          	addi	a0,a0,-1106 # 800225d8 <ftable>
    80003a32:	ffffd097          	auipc	ra,0xffffd
    80003a36:	37a080e7          	jalr	890(ra) # 80000dac <release>

	return f;
}
    80003a3a:	8526                	mv	a0,s1
    80003a3c:	60e2                	ld	ra,24(sp)
    80003a3e:	6442                	ld	s0,16(sp)
    80003a40:	64a2                	ld	s1,8(sp)
    80003a42:	6105                	addi	sp,sp,32
    80003a44:	8082                	ret
		panic("filedup()");
    80003a46:	00006517          	auipc	a0,0x6
    80003a4a:	bfa50513          	addi	a0,a0,-1030 # 80009640 <syscalls+0x268>
    80003a4e:	ffffd097          	auipc	ra,0xffffd
    80003a52:	c14080e7          	jalr	-1004(ra) # 80000662 <panic>

0000000080003a56 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void fileclose(struct file* f)
{
    80003a56:	7139                	addi	sp,sp,-64
    80003a58:	fc06                	sd	ra,56(sp)
    80003a5a:	f822                	sd	s0,48(sp)
    80003a5c:	f426                	sd	s1,40(sp)
    80003a5e:	f04a                	sd	s2,32(sp)
    80003a60:	ec4e                	sd	s3,24(sp)
    80003a62:	e852                	sd	s4,16(sp)
    80003a64:	e456                	sd	s5,8(sp)
    80003a66:	0080                	addi	s0,sp,64
    80003a68:	84aa                	mv	s1,a0
	struct file ff;

	acquire(&ftable.lock);
    80003a6a:	0001f517          	auipc	a0,0x1f
    80003a6e:	b6e50513          	addi	a0,a0,-1170 # 800225d8 <ftable>
    80003a72:	ffffd097          	auipc	ra,0xffffd
    80003a76:	286080e7          	jalr	646(ra) # 80000cf8 <acquire>

	if(f->ref < 1) {
    80003a7a:	40dc                	lw	a5,4(s1)
    80003a7c:	06f05163          	blez	a5,80003ade <fileclose+0x88>
		panic("fileclose()");
	}

	if(--f->ref > 0) {
    80003a80:	37fd                	addiw	a5,a5,-1
    80003a82:	0007871b          	sext.w	a4,a5
    80003a86:	c0dc                	sw	a5,4(s1)
    80003a88:	06e04363          	bgtz	a4,80003aee <fileclose+0x98>
		release(&ftable.lock);
		return;
	}

	ff = *f;
    80003a8c:	0004a903          	lw	s2,0(s1)
    80003a90:	0094ca83          	lbu	s5,9(s1)
    80003a94:	0104ba03          	ld	s4,16(s1)
    80003a98:	0184b983          	ld	s3,24(s1)
	f->ref = 0;
    80003a9c:	0004a223          	sw	zero,4(s1)
	f->type = FD_NONE;
    80003aa0:	0004a023          	sw	zero,0(s1)
	release(&ftable.lock);
    80003aa4:	0001f517          	auipc	a0,0x1f
    80003aa8:	b3450513          	addi	a0,a0,-1228 # 800225d8 <ftable>
    80003aac:	ffffd097          	auipc	ra,0xffffd
    80003ab0:	300080e7          	jalr	768(ra) # 80000dac <release>

	if(ff.type == FD_PIPE) {
    80003ab4:	4785                	li	a5,1
    80003ab6:	04f90d63          	beq	s2,a5,80003b10 <fileclose+0xba>
		pipeclose(ff.pipe, ff.writable);
	} else if(ff.type == FD_INODE || ff.type == FD_DEVICE) {
    80003aba:	3979                	addiw	s2,s2,-2
    80003abc:	4785                	li	a5,1
    80003abe:	0527e063          	bltu	a5,s2,80003afe <fileclose+0xa8>
		begin_op();
    80003ac2:	00000097          	auipc	ra,0x0
    80003ac6:	ac0080e7          	jalr	-1344(ra) # 80003582 <begin_op>
		ff.ip->inode_ops->iput(ff.ip);
    80003aca:	0109b783          	ld	a5,16(s3)
    80003ace:	779c                	ld	a5,40(a5)
    80003ad0:	854e                	mv	a0,s3
    80003ad2:	9782                	jalr	a5
		end_op();
    80003ad4:	00000097          	auipc	ra,0x0
    80003ad8:	b2c080e7          	jalr	-1236(ra) # 80003600 <end_op>
    80003adc:	a00d                	j	80003afe <fileclose+0xa8>
		panic("fileclose()");
    80003ade:	00006517          	auipc	a0,0x6
    80003ae2:	b7250513          	addi	a0,a0,-1166 # 80009650 <syscalls+0x278>
    80003ae6:	ffffd097          	auipc	ra,0xffffd
    80003aea:	b7c080e7          	jalr	-1156(ra) # 80000662 <panic>
		release(&ftable.lock);
    80003aee:	0001f517          	auipc	a0,0x1f
    80003af2:	aea50513          	addi	a0,a0,-1302 # 800225d8 <ftable>
    80003af6:	ffffd097          	auipc	ra,0xffffd
    80003afa:	2b6080e7          	jalr	694(ra) # 80000dac <release>
	}
}
    80003afe:	70e2                	ld	ra,56(sp)
    80003b00:	7442                	ld	s0,48(sp)
    80003b02:	74a2                	ld	s1,40(sp)
    80003b04:	7902                	ld	s2,32(sp)
    80003b06:	69e2                	ld	s3,24(sp)
    80003b08:	6a42                	ld	s4,16(sp)
    80003b0a:	6aa2                	ld	s5,8(sp)
    80003b0c:	6121                	addi	sp,sp,64
    80003b0e:	8082                	ret
		pipeclose(ff.pipe, ff.writable);
    80003b10:	85d6                	mv	a1,s5
    80003b12:	8552                	mv	a0,s4
    80003b14:	00000097          	auipc	ra,0x0
    80003b18:	33a080e7          	jalr	826(ra) # 80003e4e <pipeclose>
    80003b1c:	b7cd                	j	80003afe <fileclose+0xa8>

0000000080003b1e <filestat>:

// Get metadata about file f.
// addr is a user virtual address, pointing to a struct stat.
int filestat(struct file *f, uint64 addr)
{
    80003b1e:	715d                	addi	sp,sp,-80
    80003b20:	e486                	sd	ra,72(sp)
    80003b22:	e0a2                	sd	s0,64(sp)
    80003b24:	fc26                	sd	s1,56(sp)
    80003b26:	f84a                	sd	s2,48(sp)
    80003b28:	f44e                	sd	s3,40(sp)
    80003b2a:	0880                	addi	s0,sp,80
    80003b2c:	84aa                	mv	s1,a0
    80003b2e:	89ae                	mv	s3,a1
	struct proc *p = myproc();
    80003b30:	ffffe097          	auipc	ra,0xffffe
    80003b34:	fb4080e7          	jalr	-76(ra) # 80001ae4 <myproc>
	struct stat st;
	
	if(f->type == FD_INODE || f->type == FD_DEVICE) {
    80003b38:	409c                	lw	a5,0(s1)
    80003b3a:	37f9                	addiw	a5,a5,-2
    80003b3c:	4705                	li	a4,1
    80003b3e:	04f76463          	bltu	a4,a5,80003b86 <filestat+0x68>
    80003b42:	892a                	mv	s2,a0
		f->ip->inode_ops->ilock(f->ip);
    80003b44:	6c88                	ld	a0,24(s1)
    80003b46:	691c                	ld	a5,16(a0)
    80003b48:	739c                	ld	a5,32(a5)
    80003b4a:	9782                	jalr	a5
		f->ip->inode_ops->stati(f->ip, &st);
    80003b4c:	6c88                	ld	a0,24(s1)
    80003b4e:	691c                	ld	a5,16(a0)
    80003b50:	67bc                	ld	a5,72(a5)
    80003b52:	fb840593          	addi	a1,s0,-72
    80003b56:	9782                	jalr	a5
		f->ip->inode_ops->iunlock(f->ip);
    80003b58:	6c88                	ld	a0,24(s1)
    80003b5a:	691c                	ld	a5,16(a0)
    80003b5c:	7b9c                	ld	a5,48(a5)
    80003b5e:	9782                	jalr	a5

		if(copyout(p->pagetable, addr, (char *)&st, sizeof(st)) < 0) {
    80003b60:	46e1                	li	a3,24
    80003b62:	fb840613          	addi	a2,s0,-72
    80003b66:	85ce                	mv	a1,s3
    80003b68:	05093503          	ld	a0,80(s2)
    80003b6c:	ffffe097          	auipc	ra,0xffffe
    80003b70:	c3c080e7          	jalr	-964(ra) # 800017a8 <copyout>
    80003b74:	41f5551b          	sraiw	a0,a0,0x1f

		return 0;
	}

	return -1;
}
    80003b78:	60a6                	ld	ra,72(sp)
    80003b7a:	6406                	ld	s0,64(sp)
    80003b7c:	74e2                	ld	s1,56(sp)
    80003b7e:	7942                	ld	s2,48(sp)
    80003b80:	79a2                	ld	s3,40(sp)
    80003b82:	6161                	addi	sp,sp,80
    80003b84:	8082                	ret
	return -1;
    80003b86:	557d                	li	a0,-1
    80003b88:	bfc5                	j	80003b78 <filestat+0x5a>

0000000080003b8a <fileread>:

// Read from file f.
// addr is a user virtual address.
int fileread(struct file *f, uint64 addr, int n)
{
    80003b8a:	7179                	addi	sp,sp,-48
    80003b8c:	f406                	sd	ra,40(sp)
    80003b8e:	f022                	sd	s0,32(sp)
    80003b90:	ec26                	sd	s1,24(sp)
    80003b92:	e84a                	sd	s2,16(sp)
    80003b94:	e44e                	sd	s3,8(sp)
    80003b96:	1800                	addi	s0,sp,48
	int r = 0;

	if(f->readable == 0) {
    80003b98:	00854783          	lbu	a5,8(a0)
    80003b9c:	cfd9                	beqz	a5,80003c3a <fileread+0xb0>
    80003b9e:	84aa                	mv	s1,a0
    80003ba0:	89ae                	mv	s3,a1
    80003ba2:	8932                	mv	s2,a2
		return -1;
	}

	if(f->type == FD_PIPE) {
    80003ba4:	411c                	lw	a5,0(a0)
    80003ba6:	4705                	li	a4,1
    80003ba8:	04e78663          	beq	a5,a4,80003bf4 <fileread+0x6a>
		r = piperead(f->pipe, addr, n);
	} else if(f->type == FD_DEVICE) {
    80003bac:	470d                	li	a4,3
    80003bae:	04e78a63          	beq	a5,a4,80003c02 <fileread+0x78>
		if(f->major < 0 || f->major >= NDEV || !devsw[f->major].read) {
			return -1;
		}

		r = devsw[f->major].read(1, addr, n);
	} else if(f->type == FD_INODE) {
    80003bb2:	4709                	li	a4,2
    80003bb4:	06e79b63          	bne	a5,a4,80003c2a <fileread+0xa0>
		f->ip->inode_ops->ilock(f->ip);
    80003bb8:	6d08                	ld	a0,24(a0)
    80003bba:	691c                	ld	a5,16(a0)
    80003bbc:	739c                	ld	a5,32(a5)
    80003bbe:	9782                	jalr	a5

		if((r = f->ip->inode_ops->readi(f->ip, 1, addr, f->off, n)) > 0) {
    80003bc0:	6c88                	ld	a0,24(s1)
    80003bc2:	691c                	ld	a5,16(a0)
    80003bc4:	6bbc                	ld	a5,80(a5)
    80003bc6:	874a                	mv	a4,s2
    80003bc8:	5094                	lw	a3,32(s1)
    80003bca:	864e                	mv	a2,s3
    80003bcc:	4585                	li	a1,1
    80003bce:	9782                	jalr	a5
    80003bd0:	892a                	mv	s2,a0
    80003bd2:	00a05563          	blez	a0,80003bdc <fileread+0x52>
			f->off += r;
    80003bd6:	509c                	lw	a5,32(s1)
    80003bd8:	9fa9                	addw	a5,a5,a0
    80003bda:	d09c                	sw	a5,32(s1)
		}

		f->ip->inode_ops->iunlock(f->ip);
    80003bdc:	6c88                	ld	a0,24(s1)
    80003bde:	691c                	ld	a5,16(a0)
    80003be0:	7b9c                	ld	a5,48(a5)
    80003be2:	9782                	jalr	a5
	} else {
		panic("fileread()");
	}

	return r;
}
    80003be4:	854a                	mv	a0,s2
    80003be6:	70a2                	ld	ra,40(sp)
    80003be8:	7402                	ld	s0,32(sp)
    80003bea:	64e2                	ld	s1,24(sp)
    80003bec:	6942                	ld	s2,16(sp)
    80003bee:	69a2                	ld	s3,8(sp)
    80003bf0:	6145                	addi	sp,sp,48
    80003bf2:	8082                	ret
		r = piperead(f->pipe, addr, n);
    80003bf4:	6908                	ld	a0,16(a0)
    80003bf6:	00000097          	auipc	ra,0x0
    80003bfa:	3ba080e7          	jalr	954(ra) # 80003fb0 <piperead>
    80003bfe:	892a                	mv	s2,a0
    80003c00:	b7d5                	j	80003be4 <fileread+0x5a>
		if(f->major < 0 || f->major >= NDEV || !devsw[f->major].read) {
    80003c02:	02451783          	lh	a5,36(a0)
    80003c06:	03079693          	slli	a3,a5,0x30
    80003c0a:	92c1                	srli	a3,a3,0x30
    80003c0c:	4725                	li	a4,9
    80003c0e:	02d76863          	bltu	a4,a3,80003c3e <fileread+0xb4>
    80003c12:	0792                	slli	a5,a5,0x4
    80003c14:	0001f717          	auipc	a4,0x1f
    80003c18:	92470713          	addi	a4,a4,-1756 # 80022538 <devsw>
    80003c1c:	97ba                	add	a5,a5,a4
    80003c1e:	639c                	ld	a5,0(a5)
    80003c20:	c38d                	beqz	a5,80003c42 <fileread+0xb8>
		r = devsw[f->major].read(1, addr, n);
    80003c22:	4505                	li	a0,1
    80003c24:	9782                	jalr	a5
    80003c26:	892a                	mv	s2,a0
    80003c28:	bf75                	j	80003be4 <fileread+0x5a>
		panic("fileread()");
    80003c2a:	00006517          	auipc	a0,0x6
    80003c2e:	a3650513          	addi	a0,a0,-1482 # 80009660 <syscalls+0x288>
    80003c32:	ffffd097          	auipc	ra,0xffffd
    80003c36:	a30080e7          	jalr	-1488(ra) # 80000662 <panic>
		return -1;
    80003c3a:	597d                	li	s2,-1
    80003c3c:	b765                	j	80003be4 <fileread+0x5a>
			return -1;
    80003c3e:	597d                	li	s2,-1
    80003c40:	b755                	j	80003be4 <fileread+0x5a>
    80003c42:	597d                	li	s2,-1
    80003c44:	b745                	j	80003be4 <fileread+0x5a>

0000000080003c46 <filewrite>:

// Write to file f.
// addr is a user virtual address.
int filewrite(struct file * f, uint64 addr, int n)
{
    80003c46:	715d                	addi	sp,sp,-80
    80003c48:	e486                	sd	ra,72(sp)
    80003c4a:	e0a2                	sd	s0,64(sp)
    80003c4c:	fc26                	sd	s1,56(sp)
    80003c4e:	f84a                	sd	s2,48(sp)
    80003c50:	f44e                	sd	s3,40(sp)
    80003c52:	f052                	sd	s4,32(sp)
    80003c54:	ec56                	sd	s5,24(sp)
    80003c56:	e85a                	sd	s6,16(sp)
    80003c58:	e45e                	sd	s7,8(sp)
    80003c5a:	e062                	sd	s8,0(sp)
    80003c5c:	0880                	addi	s0,sp,80
	int r, ret = 0;

	if(f->writable == 0)
    80003c5e:	00954783          	lbu	a5,9(a0)
    80003c62:	10078363          	beqz	a5,80003d68 <filewrite+0x122>
    80003c66:	892a                	mv	s2,a0
    80003c68:	8b2e                	mv	s6,a1
    80003c6a:	8a32                	mv	s4,a2
		return -1;

	if(f->type == FD_PIPE) {
    80003c6c:	411c                	lw	a5,0(a0)
    80003c6e:	4705                	li	a4,1
    80003c70:	02e78263          	beq	a5,a4,80003c94 <filewrite+0x4e>
		ret = pipewrite(f->pipe, addr, n);
	} else if(f->type == FD_DEVICE) {
    80003c74:	470d                	li	a4,3
    80003c76:	02e78663          	beq	a5,a4,80003ca2 <filewrite+0x5c>
		if(f->major < 0 || f->major >= NDEV || !devsw[f->major].write) {
			return -1;
		}

		ret = devsw[f->major].write(1, addr, n);
	} else if(f->type == FD_INODE) {
    80003c7a:	4709                	li	a4,2
    80003c7c:	0ce79e63          	bne	a5,a4,80003d58 <filewrite+0x112>
		// might be writing a device like the console.

		int max = ((MAXOPBLOCKS - 1 - 1 - 2) / 2) * BSIZE;
		int i = 0;

		while(i < n) {
    80003c80:	0ac05a63          	blez	a2,80003d34 <filewrite+0xee>
		int i = 0;
    80003c84:	4981                	li	s3,0
    80003c86:	6b85                	lui	s7,0x1
    80003c88:	c00b8b93          	addi	s7,s7,-1024 # c00 <_entry-0x7ffff400>
    80003c8c:	6c05                	lui	s8,0x1
    80003c8e:	c00c0c1b          	addiw	s8,s8,-1024
    80003c92:	a849                	j	80003d24 <filewrite+0xde>
		ret = pipewrite(f->pipe, addr, n);
    80003c94:	6908                	ld	a0,16(a0)
    80003c96:	00000097          	auipc	ra,0x0
    80003c9a:	228080e7          	jalr	552(ra) # 80003ebe <pipewrite>
    80003c9e:	8a2a                	mv	s4,a0
    80003ca0:	a869                	j	80003d3a <filewrite+0xf4>
		if(f->major < 0 || f->major >= NDEV || !devsw[f->major].write) {
    80003ca2:	02451783          	lh	a5,36(a0)
    80003ca6:	03079693          	slli	a3,a5,0x30
    80003caa:	92c1                	srli	a3,a3,0x30
    80003cac:	4725                	li	a4,9
    80003cae:	0ad76f63          	bltu	a4,a3,80003d6c <filewrite+0x126>
    80003cb2:	0792                	slli	a5,a5,0x4
    80003cb4:	0001f717          	auipc	a4,0x1f
    80003cb8:	88470713          	addi	a4,a4,-1916 # 80022538 <devsw>
    80003cbc:	97ba                	add	a5,a5,a4
    80003cbe:	679c                	ld	a5,8(a5)
    80003cc0:	cbc5                	beqz	a5,80003d70 <filewrite+0x12a>
		ret = devsw[f->major].write(1, addr, n);
    80003cc2:	4505                	li	a0,1
    80003cc4:	9782                	jalr	a5
    80003cc6:	8a2a                	mv	s4,a0
    80003cc8:	a88d                	j	80003d3a <filewrite+0xf4>
    80003cca:	00048a9b          	sext.w	s5,s1

			if(n1 > max) {
				n1 = max;
			}

			begin_op();
    80003cce:	00000097          	auipc	ra,0x0
    80003cd2:	8b4080e7          	jalr	-1868(ra) # 80003582 <begin_op>
			f->ip->inode_ops->ilock(f->ip);
    80003cd6:	01893503          	ld	a0,24(s2)
    80003cda:	691c                	ld	a5,16(a0)
    80003cdc:	739c                	ld	a5,32(a5)
    80003cde:	9782                	jalr	a5

			if((r = f->ip->inode_ops->writei(f->ip, 1, addr + i, f->off, n1)) > 0) {
    80003ce0:	01893503          	ld	a0,24(s2)
    80003ce4:	691c                	ld	a5,16(a0)
    80003ce6:	6fbc                	ld	a5,88(a5)
    80003ce8:	8756                	mv	a4,s5
    80003cea:	02092683          	lw	a3,32(s2)
    80003cee:	01698633          	add	a2,s3,s6
    80003cf2:	4585                	li	a1,1
    80003cf4:	9782                	jalr	a5
    80003cf6:	84aa                	mv	s1,a0
    80003cf8:	00a05763          	blez	a0,80003d06 <filewrite+0xc0>
				f->off += r;
    80003cfc:	02092783          	lw	a5,32(s2)
    80003d00:	9fa9                	addw	a5,a5,a0
    80003d02:	02f92023          	sw	a5,32(s2)
			}

			f->ip->inode_ops->iunlock(f->ip);
    80003d06:	01893503          	ld	a0,24(s2)
    80003d0a:	691c                	ld	a5,16(a0)
    80003d0c:	7b9c                	ld	a5,48(a5)
    80003d0e:	9782                	jalr	a5
			end_op();
    80003d10:	00000097          	auipc	ra,0x0
    80003d14:	8f0080e7          	jalr	-1808(ra) # 80003600 <end_op>

			if(r != n1) {
    80003d18:	009a9f63          	bne	s5,s1,80003d36 <filewrite+0xf0>
				// error from writei
				break;
			}

			i += r;
    80003d1c:	013489bb          	addw	s3,s1,s3
		while(i < n) {
    80003d20:	0149db63          	bge	s3,s4,80003d36 <filewrite+0xf0>
			int n1 = n - i;
    80003d24:	413a04bb          	subw	s1,s4,s3
    80003d28:	0004879b          	sext.w	a5,s1
    80003d2c:	f8fbdfe3          	bge	s7,a5,80003cca <filewrite+0x84>
    80003d30:	84e2                	mv	s1,s8
    80003d32:	bf61                	j	80003cca <filewrite+0x84>
		int i = 0;
    80003d34:	4981                	li	s3,0
		}

		ret = (i == n ? n : -1);
    80003d36:	013a1f63          	bne	s4,s3,80003d54 <filewrite+0x10e>
	} else {
		panic("filewrite()");
	}

	return ret;
}
    80003d3a:	8552                	mv	a0,s4
    80003d3c:	60a6                	ld	ra,72(sp)
    80003d3e:	6406                	ld	s0,64(sp)
    80003d40:	74e2                	ld	s1,56(sp)
    80003d42:	7942                	ld	s2,48(sp)
    80003d44:	79a2                	ld	s3,40(sp)
    80003d46:	7a02                	ld	s4,32(sp)
    80003d48:	6ae2                	ld	s5,24(sp)
    80003d4a:	6b42                	ld	s6,16(sp)
    80003d4c:	6ba2                	ld	s7,8(sp)
    80003d4e:	6c02                	ld	s8,0(sp)
    80003d50:	6161                	addi	sp,sp,80
    80003d52:	8082                	ret
		ret = (i == n ? n : -1);
    80003d54:	5a7d                	li	s4,-1
    80003d56:	b7d5                	j	80003d3a <filewrite+0xf4>
		panic("filewrite()");
    80003d58:	00006517          	auipc	a0,0x6
    80003d5c:	91850513          	addi	a0,a0,-1768 # 80009670 <syscalls+0x298>
    80003d60:	ffffd097          	auipc	ra,0xffffd
    80003d64:	902080e7          	jalr	-1790(ra) # 80000662 <panic>
		return -1;
    80003d68:	5a7d                	li	s4,-1
    80003d6a:	bfc1                	j	80003d3a <filewrite+0xf4>
			return -1;
    80003d6c:	5a7d                	li	s4,-1
    80003d6e:	b7f1                	j	80003d3a <filewrite+0xf4>
    80003d70:	5a7d                	li	s4,-1
    80003d72:	b7e1                	j	80003d3a <filewrite+0xf4>

0000000080003d74 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
    80003d74:	7179                	addi	sp,sp,-48
    80003d76:	f406                	sd	ra,40(sp)
    80003d78:	f022                	sd	s0,32(sp)
    80003d7a:	ec26                	sd	s1,24(sp)
    80003d7c:	e84a                	sd	s2,16(sp)
    80003d7e:	e44e                	sd	s3,8(sp)
    80003d80:	e052                	sd	s4,0(sp)
    80003d82:	1800                	addi	s0,sp,48
    80003d84:	84aa                	mv	s1,a0
    80003d86:	8a2e                	mv	s4,a1
  struct pipe *pi;

  pi = 0;
  *f0 = *f1 = 0;
    80003d88:	0005b023          	sd	zero,0(a1)
    80003d8c:	00053023          	sd	zero,0(a0)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
    80003d90:	00000097          	auipc	ra,0x0
    80003d94:	c0a080e7          	jalr	-1014(ra) # 8000399a <filealloc>
    80003d98:	e088                	sd	a0,0(s1)
    80003d9a:	c551                	beqz	a0,80003e26 <pipealloc+0xb2>
    80003d9c:	00000097          	auipc	ra,0x0
    80003da0:	bfe080e7          	jalr	-1026(ra) # 8000399a <filealloc>
    80003da4:	00aa3023          	sd	a0,0(s4)
    80003da8:	c92d                	beqz	a0,80003e1a <pipealloc+0xa6>
    goto bad;
  if((pi = (struct pipe*)kalloc()) == 0)
    80003daa:	ffffd097          	auipc	ra,0xffffd
    80003dae:	e5e080e7          	jalr	-418(ra) # 80000c08 <kalloc>
    80003db2:	892a                	mv	s2,a0
    80003db4:	c125                	beqz	a0,80003e14 <pipealloc+0xa0>
    goto bad;
  pi->readopen = 1;
    80003db6:	4985                	li	s3,1
    80003db8:	23352023          	sw	s3,544(a0)
  pi->writeopen = 1;
    80003dbc:	23352223          	sw	s3,548(a0)
  pi->nwrite = 0;
    80003dc0:	20052e23          	sw	zero,540(a0)
  pi->nread = 0;
    80003dc4:	20052c23          	sw	zero,536(a0)
  initlock(&pi->lock, "pipe");
    80003dc8:	00006597          	auipc	a1,0x6
    80003dcc:	8b858593          	addi	a1,a1,-1864 # 80009680 <syscalls+0x2a8>
    80003dd0:	ffffd097          	auipc	ra,0xffffd
    80003dd4:	e98080e7          	jalr	-360(ra) # 80000c68 <initlock>
  (*f0)->type = FD_PIPE;
    80003dd8:	609c                	ld	a5,0(s1)
    80003dda:	0137a023          	sw	s3,0(a5)
  (*f0)->readable = 1;
    80003dde:	609c                	ld	a5,0(s1)
    80003de0:	01378423          	sb	s3,8(a5)
  (*f0)->writable = 0;
    80003de4:	609c                	ld	a5,0(s1)
    80003de6:	000784a3          	sb	zero,9(a5)
  (*f0)->pipe = pi;
    80003dea:	609c                	ld	a5,0(s1)
    80003dec:	0127b823          	sd	s2,16(a5)
  (*f1)->type = FD_PIPE;
    80003df0:	000a3783          	ld	a5,0(s4)
    80003df4:	0137a023          	sw	s3,0(a5)
  (*f1)->readable = 0;
    80003df8:	000a3783          	ld	a5,0(s4)
    80003dfc:	00078423          	sb	zero,8(a5)
  (*f1)->writable = 1;
    80003e00:	000a3783          	ld	a5,0(s4)
    80003e04:	013784a3          	sb	s3,9(a5)
  (*f1)->pipe = pi;
    80003e08:	000a3783          	ld	a5,0(s4)
    80003e0c:	0127b823          	sd	s2,16(a5)
  return 0;
    80003e10:	4501                	li	a0,0
    80003e12:	a025                	j	80003e3a <pipealloc+0xc6>

 bad:
  if(pi)
    kfree((char*)pi);
  if(*f0)
    80003e14:	6088                	ld	a0,0(s1)
    80003e16:	e501                	bnez	a0,80003e1e <pipealloc+0xaa>
    80003e18:	a039                	j	80003e26 <pipealloc+0xb2>
    80003e1a:	6088                	ld	a0,0(s1)
    80003e1c:	c51d                	beqz	a0,80003e4a <pipealloc+0xd6>
    fileclose(*f0);
    80003e1e:	00000097          	auipc	ra,0x0
    80003e22:	c38080e7          	jalr	-968(ra) # 80003a56 <fileclose>
  if(*f1)
    80003e26:	000a3783          	ld	a5,0(s4)
    fileclose(*f1);
  return -1;
    80003e2a:	557d                	li	a0,-1
  if(*f1)
    80003e2c:	c799                	beqz	a5,80003e3a <pipealloc+0xc6>
    fileclose(*f1);
    80003e2e:	853e                	mv	a0,a5
    80003e30:	00000097          	auipc	ra,0x0
    80003e34:	c26080e7          	jalr	-986(ra) # 80003a56 <fileclose>
  return -1;
    80003e38:	557d                	li	a0,-1
}
    80003e3a:	70a2                	ld	ra,40(sp)
    80003e3c:	7402                	ld	s0,32(sp)
    80003e3e:	64e2                	ld	s1,24(sp)
    80003e40:	6942                	ld	s2,16(sp)
    80003e42:	69a2                	ld	s3,8(sp)
    80003e44:	6a02                	ld	s4,0(sp)
    80003e46:	6145                	addi	sp,sp,48
    80003e48:	8082                	ret
  return -1;
    80003e4a:	557d                	li	a0,-1
    80003e4c:	b7fd                	j	80003e3a <pipealloc+0xc6>

0000000080003e4e <pipeclose>:

void
pipeclose(struct pipe *pi, int writable)
{
    80003e4e:	1101                	addi	sp,sp,-32
    80003e50:	ec06                	sd	ra,24(sp)
    80003e52:	e822                	sd	s0,16(sp)
    80003e54:	e426                	sd	s1,8(sp)
    80003e56:	e04a                	sd	s2,0(sp)
    80003e58:	1000                	addi	s0,sp,32
    80003e5a:	84aa                	mv	s1,a0
    80003e5c:	892e                	mv	s2,a1
  acquire(&pi->lock);
    80003e5e:	ffffd097          	auipc	ra,0xffffd
    80003e62:	e9a080e7          	jalr	-358(ra) # 80000cf8 <acquire>
  if(writable){
    80003e66:	02090d63          	beqz	s2,80003ea0 <pipeclose+0x52>
    pi->writeopen = 0;
    80003e6a:	2204a223          	sw	zero,548(s1)
    wakeup(&pi->nread);
    80003e6e:	21848513          	addi	a0,s1,536
    80003e72:	ffffe097          	auipc	ra,0xffffe
    80003e76:	4cc080e7          	jalr	1228(ra) # 8000233e <wakeup>
  } else {
    pi->readopen = 0;
    wakeup(&pi->nwrite);
  }
  if(pi->readopen == 0 && pi->writeopen == 0){
    80003e7a:	2204b783          	ld	a5,544(s1)
    80003e7e:	eb95                	bnez	a5,80003eb2 <pipeclose+0x64>
    release(&pi->lock);
    80003e80:	8526                	mv	a0,s1
    80003e82:	ffffd097          	auipc	ra,0xffffd
    80003e86:	f2a080e7          	jalr	-214(ra) # 80000dac <release>
    kfree((char*)pi);
    80003e8a:	8526                	mv	a0,s1
    80003e8c:	ffffd097          	auipc	ra,0xffffd
    80003e90:	c7e080e7          	jalr	-898(ra) # 80000b0a <kfree>
  } else
    release(&pi->lock);
}
    80003e94:	60e2                	ld	ra,24(sp)
    80003e96:	6442                	ld	s0,16(sp)
    80003e98:	64a2                	ld	s1,8(sp)
    80003e9a:	6902                	ld	s2,0(sp)
    80003e9c:	6105                	addi	sp,sp,32
    80003e9e:	8082                	ret
    pi->readopen = 0;
    80003ea0:	2204a023          	sw	zero,544(s1)
    wakeup(&pi->nwrite);
    80003ea4:	21c48513          	addi	a0,s1,540
    80003ea8:	ffffe097          	auipc	ra,0xffffe
    80003eac:	496080e7          	jalr	1174(ra) # 8000233e <wakeup>
    80003eb0:	b7e9                	j	80003e7a <pipeclose+0x2c>
    release(&pi->lock);
    80003eb2:	8526                	mv	a0,s1
    80003eb4:	ffffd097          	auipc	ra,0xffffd
    80003eb8:	ef8080e7          	jalr	-264(ra) # 80000dac <release>
}
    80003ebc:	bfe1                	j	80003e94 <pipeclose+0x46>

0000000080003ebe <pipewrite>:

int
pipewrite(struct pipe *pi, uint64 addr, int n)
{
    80003ebe:	711d                	addi	sp,sp,-96
    80003ec0:	ec86                	sd	ra,88(sp)
    80003ec2:	e8a2                	sd	s0,80(sp)
    80003ec4:	e4a6                	sd	s1,72(sp)
    80003ec6:	e0ca                	sd	s2,64(sp)
    80003ec8:	fc4e                	sd	s3,56(sp)
    80003eca:	f852                	sd	s4,48(sp)
    80003ecc:	f456                	sd	s5,40(sp)
    80003ece:	f05a                	sd	s6,32(sp)
    80003ed0:	ec5e                	sd	s7,24(sp)
    80003ed2:	e862                	sd	s8,16(sp)
    80003ed4:	1080                	addi	s0,sp,96
    80003ed6:	84aa                	mv	s1,a0
    80003ed8:	8aae                	mv	s5,a1
    80003eda:	8a32                	mv	s4,a2
  int i = 0;
  struct proc *pr = myproc();
    80003edc:	ffffe097          	auipc	ra,0xffffe
    80003ee0:	c08080e7          	jalr	-1016(ra) # 80001ae4 <myproc>
    80003ee4:	89aa                	mv	s3,a0

  acquire(&pi->lock);
    80003ee6:	8526                	mv	a0,s1
    80003ee8:	ffffd097          	auipc	ra,0xffffd
    80003eec:	e10080e7          	jalr	-496(ra) # 80000cf8 <acquire>
  while(i < n){
    80003ef0:	0b405363          	blez	s4,80003f96 <pipewrite+0xd8>
  int i = 0;
    80003ef4:	4901                	li	s2,0
    if(pi->nwrite == pi->nread + PIPESIZE){ //DOC: pipewrite-full
      wakeup(&pi->nread);
      _sleep(&pi->nwrite, &pi->lock);
    } else {
      char ch;
      if(copyin(pr->pagetable, &ch, addr + i, 1) == -1)
    80003ef6:	5b7d                	li	s6,-1
      wakeup(&pi->nread);
    80003ef8:	21848c13          	addi	s8,s1,536
      _sleep(&pi->nwrite, &pi->lock);
    80003efc:	21c48b93          	addi	s7,s1,540
    80003f00:	a089                	j	80003f42 <pipewrite+0x84>
      release(&pi->lock);
    80003f02:	8526                	mv	a0,s1
    80003f04:	ffffd097          	auipc	ra,0xffffd
    80003f08:	ea8080e7          	jalr	-344(ra) # 80000dac <release>
      return -1;
    80003f0c:	597d                	li	s2,-1
  }
  wakeup(&pi->nread);
  release(&pi->lock);

  return i;
}
    80003f0e:	854a                	mv	a0,s2
    80003f10:	60e6                	ld	ra,88(sp)
    80003f12:	6446                	ld	s0,80(sp)
    80003f14:	64a6                	ld	s1,72(sp)
    80003f16:	6906                	ld	s2,64(sp)
    80003f18:	79e2                	ld	s3,56(sp)
    80003f1a:	7a42                	ld	s4,48(sp)
    80003f1c:	7aa2                	ld	s5,40(sp)
    80003f1e:	7b02                	ld	s6,32(sp)
    80003f20:	6be2                	ld	s7,24(sp)
    80003f22:	6c42                	ld	s8,16(sp)
    80003f24:	6125                	addi	sp,sp,96
    80003f26:	8082                	ret
      wakeup(&pi->nread);
    80003f28:	8562                	mv	a0,s8
    80003f2a:	ffffe097          	auipc	ra,0xffffe
    80003f2e:	414080e7          	jalr	1044(ra) # 8000233e <wakeup>
      _sleep(&pi->nwrite, &pi->lock);
    80003f32:	85a6                	mv	a1,s1
    80003f34:	855e                	mv	a0,s7
    80003f36:	ffffe097          	auipc	ra,0xffffe
    80003f3a:	27c080e7          	jalr	636(ra) # 800021b2 <_sleep>
  while(i < n){
    80003f3e:	05495d63          	bge	s2,s4,80003f98 <pipewrite+0xda>
    if(pi->readopen == 0 || pr->killed){
    80003f42:	2204a783          	lw	a5,544(s1)
    80003f46:	dfd5                	beqz	a5,80003f02 <pipewrite+0x44>
    80003f48:	0289a783          	lw	a5,40(s3)
    80003f4c:	fbdd                	bnez	a5,80003f02 <pipewrite+0x44>
    if(pi->nwrite == pi->nread + PIPESIZE){ //DOC: pipewrite-full
    80003f4e:	2184a783          	lw	a5,536(s1)
    80003f52:	21c4a703          	lw	a4,540(s1)
    80003f56:	2007879b          	addiw	a5,a5,512
    80003f5a:	fcf707e3          	beq	a4,a5,80003f28 <pipewrite+0x6a>
      if(copyin(pr->pagetable, &ch, addr + i, 1) == -1)
    80003f5e:	4685                	li	a3,1
    80003f60:	01590633          	add	a2,s2,s5
    80003f64:	faf40593          	addi	a1,s0,-81
    80003f68:	0509b503          	ld	a0,80(s3)
    80003f6c:	ffffe097          	auipc	ra,0xffffe
    80003f70:	8c8080e7          	jalr	-1848(ra) # 80001834 <copyin>
    80003f74:	03650263          	beq	a0,s6,80003f98 <pipewrite+0xda>
      pi->data[pi->nwrite++ % PIPESIZE] = ch;
    80003f78:	21c4a783          	lw	a5,540(s1)
    80003f7c:	0017871b          	addiw	a4,a5,1
    80003f80:	20e4ae23          	sw	a4,540(s1)
    80003f84:	1ff7f793          	andi	a5,a5,511
    80003f88:	97a6                	add	a5,a5,s1
    80003f8a:	faf44703          	lbu	a4,-81(s0)
    80003f8e:	00e78c23          	sb	a4,24(a5)
      i++;
    80003f92:	2905                	addiw	s2,s2,1
    80003f94:	b76d                	j	80003f3e <pipewrite+0x80>
  int i = 0;
    80003f96:	4901                	li	s2,0
  wakeup(&pi->nread);
    80003f98:	21848513          	addi	a0,s1,536
    80003f9c:	ffffe097          	auipc	ra,0xffffe
    80003fa0:	3a2080e7          	jalr	930(ra) # 8000233e <wakeup>
  release(&pi->lock);
    80003fa4:	8526                	mv	a0,s1
    80003fa6:	ffffd097          	auipc	ra,0xffffd
    80003faa:	e06080e7          	jalr	-506(ra) # 80000dac <release>
  return i;
    80003fae:	b785                	j	80003f0e <pipewrite+0x50>

0000000080003fb0 <piperead>:

int
piperead(struct pipe *pi, uint64 addr, int n)
{
    80003fb0:	715d                	addi	sp,sp,-80
    80003fb2:	e486                	sd	ra,72(sp)
    80003fb4:	e0a2                	sd	s0,64(sp)
    80003fb6:	fc26                	sd	s1,56(sp)
    80003fb8:	f84a                	sd	s2,48(sp)
    80003fba:	f44e                	sd	s3,40(sp)
    80003fbc:	f052                	sd	s4,32(sp)
    80003fbe:	ec56                	sd	s5,24(sp)
    80003fc0:	e85a                	sd	s6,16(sp)
    80003fc2:	0880                	addi	s0,sp,80
    80003fc4:	84aa                	mv	s1,a0
    80003fc6:	892e                	mv	s2,a1
    80003fc8:	8ab2                	mv	s5,a2
  int i;
  struct proc *pr = myproc();
    80003fca:	ffffe097          	auipc	ra,0xffffe
    80003fce:	b1a080e7          	jalr	-1254(ra) # 80001ae4 <myproc>
    80003fd2:	8a2a                	mv	s4,a0
  char ch;

  acquire(&pi->lock);
    80003fd4:	8526                	mv	a0,s1
    80003fd6:	ffffd097          	auipc	ra,0xffffd
    80003fda:	d22080e7          	jalr	-734(ra) # 80000cf8 <acquire>
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    80003fde:	2184a703          	lw	a4,536(s1)
    80003fe2:	21c4a783          	lw	a5,540(s1)
    if(pr->killed){
      release(&pi->lock);
      return -1;
    }
    _sleep(&pi->nread, &pi->lock); //DOC: piperead-sleep
    80003fe6:	21848993          	addi	s3,s1,536
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    80003fea:	02f71463          	bne	a4,a5,80004012 <piperead+0x62>
    80003fee:	2244a783          	lw	a5,548(s1)
    80003ff2:	c385                	beqz	a5,80004012 <piperead+0x62>
    if(pr->killed){
    80003ff4:	028a2783          	lw	a5,40(s4)
    80003ff8:	ebc9                	bnez	a5,8000408a <piperead+0xda>
    _sleep(&pi->nread, &pi->lock); //DOC: piperead-sleep
    80003ffa:	85a6                	mv	a1,s1
    80003ffc:	854e                	mv	a0,s3
    80003ffe:	ffffe097          	auipc	ra,0xffffe
    80004002:	1b4080e7          	jalr	436(ra) # 800021b2 <_sleep>
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    80004006:	2184a703          	lw	a4,536(s1)
    8000400a:	21c4a783          	lw	a5,540(s1)
    8000400e:	fef700e3          	beq	a4,a5,80003fee <piperead+0x3e>
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    80004012:	4981                	li	s3,0
    if(pi->nread == pi->nwrite)
      break;
    ch = pi->data[pi->nread++ % PIPESIZE];
    if(copyout(pr->pagetable, addr + i, &ch, 1) == -1)
    80004014:	5b7d                	li	s6,-1
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    80004016:	05505463          	blez	s5,8000405e <piperead+0xae>
    if(pi->nread == pi->nwrite)
    8000401a:	2184a783          	lw	a5,536(s1)
    8000401e:	21c4a703          	lw	a4,540(s1)
    80004022:	02f70e63          	beq	a4,a5,8000405e <piperead+0xae>
    ch = pi->data[pi->nread++ % PIPESIZE];
    80004026:	0017871b          	addiw	a4,a5,1
    8000402a:	20e4ac23          	sw	a4,536(s1)
    8000402e:	1ff7f793          	andi	a5,a5,511
    80004032:	97a6                	add	a5,a5,s1
    80004034:	0187c783          	lbu	a5,24(a5)
    80004038:	faf40fa3          	sb	a5,-65(s0)
    if(copyout(pr->pagetable, addr + i, &ch, 1) == -1)
    8000403c:	4685                	li	a3,1
    8000403e:	fbf40613          	addi	a2,s0,-65
    80004042:	85ca                	mv	a1,s2
    80004044:	050a3503          	ld	a0,80(s4)
    80004048:	ffffd097          	auipc	ra,0xffffd
    8000404c:	760080e7          	jalr	1888(ra) # 800017a8 <copyout>
    80004050:	01650763          	beq	a0,s6,8000405e <piperead+0xae>
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    80004054:	2985                	addiw	s3,s3,1
    80004056:	0905                	addi	s2,s2,1
    80004058:	fd3a91e3          	bne	s5,s3,8000401a <piperead+0x6a>
    8000405c:	89d6                	mv	s3,s5
      break;
  }
  wakeup(&pi->nwrite);  //DOC: piperead-wakeup
    8000405e:	21c48513          	addi	a0,s1,540
    80004062:	ffffe097          	auipc	ra,0xffffe
    80004066:	2dc080e7          	jalr	732(ra) # 8000233e <wakeup>
  release(&pi->lock);
    8000406a:	8526                	mv	a0,s1
    8000406c:	ffffd097          	auipc	ra,0xffffd
    80004070:	d40080e7          	jalr	-704(ra) # 80000dac <release>
  return i;
}
    80004074:	854e                	mv	a0,s3
    80004076:	60a6                	ld	ra,72(sp)
    80004078:	6406                	ld	s0,64(sp)
    8000407a:	74e2                	ld	s1,56(sp)
    8000407c:	7942                	ld	s2,48(sp)
    8000407e:	79a2                	ld	s3,40(sp)
    80004080:	7a02                	ld	s4,32(sp)
    80004082:	6ae2                	ld	s5,24(sp)
    80004084:	6b42                	ld	s6,16(sp)
    80004086:	6161                	addi	sp,sp,80
    80004088:	8082                	ret
      release(&pi->lock);
    8000408a:	8526                	mv	a0,s1
    8000408c:	ffffd097          	auipc	ra,0xffffd
    80004090:	d20080e7          	jalr	-736(ra) # 80000dac <release>
      return -1;
    80004094:	59fd                	li	s3,-1
    80004096:	bff9                	j	80004074 <piperead+0xc4>

0000000080004098 <exec>:
#include <kernel/vfs.h>

static int loadseg(pde_t * pgdir, uint64 addr, struct inode * ip, uint offset, uint sz);

int exec(char * path, char ** argv)
{
    80004098:	de010113          	addi	sp,sp,-544
    8000409c:	20113c23          	sd	ra,536(sp)
    800040a0:	20813823          	sd	s0,528(sp)
    800040a4:	20913423          	sd	s1,520(sp)
    800040a8:	21213023          	sd	s2,512(sp)
    800040ac:	ffce                	sd	s3,504(sp)
    800040ae:	fbd2                	sd	s4,496(sp)
    800040b0:	f7d6                	sd	s5,488(sp)
    800040b2:	f3da                	sd	s6,480(sp)
    800040b4:	efde                	sd	s7,472(sp)
    800040b6:	ebe2                	sd	s8,464(sp)
    800040b8:	e7e6                	sd	s9,456(sp)
    800040ba:	e3ea                	sd	s10,448(sp)
    800040bc:	ff6e                	sd	s11,440(sp)
    800040be:	1400                	addi	s0,sp,544
    800040c0:	892a                	mv	s2,a0
    800040c2:	dea43423          	sd	a0,-536(s0)
    800040c6:	deb43823          	sd	a1,-528(s0)
	struct elfhdr elf;
	struct inode * ip;
	struct proghdr ph;
	pagetable_t pagetable = 0, oldpagetable;

	struct proc * p = myproc();
    800040ca:	ffffe097          	auipc	ra,0xffffe
    800040ce:	a1a080e7          	jalr	-1510(ra) # 80001ae4 <myproc>
    800040d2:	84aa                	mv	s1,a0

	begin_op();
    800040d4:	fffff097          	auipc	ra,0xfffff
    800040d8:	4ae080e7          	jalr	1198(ra) # 80003582 <begin_op>

	if((ip = namei(path)) == 0) {
    800040dc:	854a                	mv	a0,s2
    800040de:	fffff097          	auipc	ra,0xfffff
    800040e2:	26c080e7          	jalr	620(ra) # 8000334a <namei>
    800040e6:	c935                	beqz	a0,8000415a <exec+0xc2>
    800040e8:	8a2a                	mv	s4,a0
		end_op();
		return -1;
	}
	
	ip->inode_ops->ilock(ip);
    800040ea:	691c                	ld	a5,16(a0)
    800040ec:	739c                	ld	a5,32(a5)
    800040ee:	9782                	jalr	a5

	// Check ELF header
	if(ip->inode_ops->readi(ip, 0, (uint64)&elf, 0, sizeof(elf)) != sizeof(elf)) {
    800040f0:	010a3783          	ld	a5,16(s4)
    800040f4:	6bbc                	ld	a5,80(a5)
    800040f6:	04000713          	li	a4,64
    800040fa:	4681                	li	a3,0
    800040fc:	e5040613          	addi	a2,s0,-432
    80004100:	4581                	li	a1,0
    80004102:	8552                	mv	a0,s4
    80004104:	9782                	jalr	a5
    80004106:	04000793          	li	a5,64
    8000410a:	00f51a63          	bne	a0,a5,8000411e <exec+0x86>
		goto bad;
	}

	if(elf.magic != ELF_MAGIC) {
    8000410e:	e5042703          	lw	a4,-432(s0)
    80004112:	464c47b7          	lui	a5,0x464c4
    80004116:	57f78793          	addi	a5,a5,1407 # 464c457f <_entry-0x39b3ba81>
    8000411a:	04f70663          	beq	a4,a5,80004166 <exec+0xce>
	if(pagetable) {
		proc_freepagetable(pagetable, sz);
	}

	if(ip) {
		ip->inode_ops->iunlockput(ip);
    8000411e:	010a3783          	ld	a5,16(s4)
    80004122:	7f9c                	ld	a5,56(a5)
    80004124:	8552                	mv	a0,s4
    80004126:	9782                	jalr	a5
		end_op();
    80004128:	fffff097          	auipc	ra,0xfffff
    8000412c:	4d8080e7          	jalr	1240(ra) # 80003600 <end_op>
	}

	return -1;
    80004130:	557d                	li	a0,-1
}
    80004132:	21813083          	ld	ra,536(sp)
    80004136:	21013403          	ld	s0,528(sp)
    8000413a:	20813483          	ld	s1,520(sp)
    8000413e:	20013903          	ld	s2,512(sp)
    80004142:	79fe                	ld	s3,504(sp)
    80004144:	7a5e                	ld	s4,496(sp)
    80004146:	7abe                	ld	s5,488(sp)
    80004148:	7b1e                	ld	s6,480(sp)
    8000414a:	6bfe                	ld	s7,472(sp)
    8000414c:	6c5e                	ld	s8,464(sp)
    8000414e:	6cbe                	ld	s9,456(sp)
    80004150:	6d1e                	ld	s10,448(sp)
    80004152:	7dfa                	ld	s11,440(sp)
    80004154:	22010113          	addi	sp,sp,544
    80004158:	8082                	ret
		end_op();
    8000415a:	fffff097          	auipc	ra,0xfffff
    8000415e:	4a6080e7          	jalr	1190(ra) # 80003600 <end_op>
		return -1;
    80004162:	557d                	li	a0,-1
    80004164:	b7f9                	j	80004132 <exec+0x9a>
	if((pagetable = proc_pagetable(p)) == 0) {
    80004166:	8526                	mv	a0,s1
    80004168:	ffffe097          	auipc	ra,0xffffe
    8000416c:	a60080e7          	jalr	-1440(ra) # 80001bc8 <proc_pagetable>
    80004170:	8b2a                	mv	s6,a0
    80004172:	d555                	beqz	a0,8000411e <exec+0x86>
	for(i = 0, off = elf.phoff; i < elf.phnum; i++, off += sizeof(ph)){
    80004174:	e7042783          	lw	a5,-400(s0)
    80004178:	e8845703          	lhu	a4,-376(s0)
    8000417c:	c735                	beqz	a4,800041e8 <exec+0x150>
	uint64 argc, sz = 0, sp, ustack[MAXARG], stackbase;
    8000417e:	4481                	li	s1,0
	for(i = 0, off = elf.phoff; i < elf.phnum; i++, off += sizeof(ph)){
    80004180:	e0043423          	sd	zero,-504(s0)
		if((ph.vaddr % PGSIZE) != 0)
    80004184:	6a85                	lui	s5,0x1
    80004186:	fffa8713          	addi	a4,s5,-1 # fff <_entry-0x7ffff001>
    8000418a:	dee43023          	sd	a4,-544(s0)
static int loadseg(pagetable_t pagetable, uint64 va, struct inode * ip, uint offset, uint sz)
{
	uint i, n;
	uint64 pa;

	for(i = 0; i < sz; i += PGSIZE){
    8000418e:	6d85                	lui	s11,0x1
    80004190:	7d7d                	lui	s10,0xfffff
    80004192:	ac1d                	j	800043c8 <exec+0x330>
		pa = walkaddr(pagetable, va + i);

		if(pa == 0) {
			panic("loadseg: address should exist");
    80004194:	00005517          	auipc	a0,0x5
    80004198:	4f450513          	addi	a0,a0,1268 # 80009688 <syscalls+0x2b0>
    8000419c:	ffffc097          	auipc	ra,0xffffc
    800041a0:	4c6080e7          	jalr	1222(ra) # 80000662 <panic>
			n = sz - i;
		} else {
			n = PGSIZE;
		}

		if(ip->inode_ops->readi(ip, 0, (uint64)pa, offset+i, n) != n) {
    800041a4:	010a3783          	ld	a5,16(s4)
    800041a8:	6bbc                	ld	a5,80(a5)
    800041aa:	874a                	mv	a4,s2
    800041ac:	009c86bb          	addw	a3,s9,s1
    800041b0:	4581                	li	a1,0
    800041b2:	8552                	mv	a0,s4
    800041b4:	9782                	jalr	a5
    800041b6:	2501                	sext.w	a0,a0
    800041b8:	1aa91863          	bne	s2,a0,80004368 <exec+0x2d0>
	for(i = 0; i < sz; i += PGSIZE){
    800041bc:	009d84bb          	addw	s1,s11,s1
    800041c0:	013d09bb          	addw	s3,s10,s3
    800041c4:	1f74f263          	bgeu	s1,s7,800043a8 <exec+0x310>
		pa = walkaddr(pagetable, va + i);
    800041c8:	02049593          	slli	a1,s1,0x20
    800041cc:	9181                	srli	a1,a1,0x20
    800041ce:	95e2                	add	a1,a1,s8
    800041d0:	855a                	mv	a0,s6
    800041d2:	ffffd097          	auipc	ra,0xffffd
    800041d6:	fce080e7          	jalr	-50(ra) # 800011a0 <walkaddr>
    800041da:	862a                	mv	a2,a0
		if(pa == 0) {
    800041dc:	dd45                	beqz	a0,80004194 <exec+0xfc>
			n = PGSIZE;
    800041de:	8956                	mv	s2,s5
		if(sz - i < PGSIZE) {
    800041e0:	fd59f2e3          	bgeu	s3,s5,800041a4 <exec+0x10c>
			n = sz - i;
    800041e4:	894e                	mv	s2,s3
    800041e6:	bf7d                	j	800041a4 <exec+0x10c>
	uint64 argc, sz = 0, sp, ustack[MAXARG], stackbase;
    800041e8:	4481                	li	s1,0
	ip->inode_ops->iunlockput(ip);
    800041ea:	010a3783          	ld	a5,16(s4)
    800041ee:	7f9c                	ld	a5,56(a5)
    800041f0:	8552                	mv	a0,s4
    800041f2:	9782                	jalr	a5
	end_op();
    800041f4:	fffff097          	auipc	ra,0xfffff
    800041f8:	40c080e7          	jalr	1036(ra) # 80003600 <end_op>
	p = myproc();
    800041fc:	ffffe097          	auipc	ra,0xffffe
    80004200:	8e8080e7          	jalr	-1816(ra) # 80001ae4 <myproc>
    80004204:	8aaa                	mv	s5,a0
	uint64 oldsz = p->sz;
    80004206:	04853d03          	ld	s10,72(a0)
	sz = PGROUNDUP(sz);
    8000420a:	6785                	lui	a5,0x1
    8000420c:	17fd                	addi	a5,a5,-1
    8000420e:	97a6                	add	a5,a5,s1
    80004210:	777d                	lui	a4,0xfffff
    80004212:	8ff9                	and	a5,a5,a4
    80004214:	def43c23          	sd	a5,-520(s0)
	if((sz1 = uvmalloc(pagetable, sz, sz + 2 * PGSIZE)) == 0)
    80004218:	6609                	lui	a2,0x2
    8000421a:	963e                	add	a2,a2,a5
    8000421c:	85be                	mv	a1,a5
    8000421e:	855a                	mv	a0,s6
    80004220:	ffffd097          	auipc	ra,0xffffd
    80004224:	334080e7          	jalr	820(ra) # 80001554 <uvmalloc>
    80004228:	8baa                	mv	s7,a0
	ip = 0;
    8000422a:	4a01                	li	s4,0
	if((sz1 = uvmalloc(pagetable, sz, sz + 2 * PGSIZE)) == 0)
    8000422c:	12050e63          	beqz	a0,80004368 <exec+0x2d0>
	uvmclear(pagetable, sz - 2 * PGSIZE);
    80004230:	75f9                	lui	a1,0xffffe
    80004232:	95aa                	add	a1,a1,a0
    80004234:	855a                	mv	a0,s6
    80004236:	ffffd097          	auipc	ra,0xffffd
    8000423a:	540080e7          	jalr	1344(ra) # 80001776 <uvmclear>
	stackbase = sp - PGSIZE;
    8000423e:	7c7d                	lui	s8,0xfffff
    80004240:	9c5e                	add	s8,s8,s7
	for(argc = 0; argv[argc]; argc++) {
    80004242:	df043783          	ld	a5,-528(s0)
    80004246:	6388                	ld	a0,0(a5)
    80004248:	c925                	beqz	a0,800042b8 <exec+0x220>
    8000424a:	e9040993          	addi	s3,s0,-368
    8000424e:	f9040c93          	addi	s9,s0,-112
	sp = sz;
    80004252:	895e                	mv	s2,s7
	for(argc = 0; argv[argc]; argc++) {
    80004254:	4481                	li	s1,0
		sp -= kstrlen(argv[argc]) + 1;
    80004256:	ffffd097          	auipc	ra,0xffffd
    8000425a:	d1a080e7          	jalr	-742(ra) # 80000f70 <kstrlen>
    8000425e:	0015079b          	addiw	a5,a0,1
    80004262:	40f907b3          	sub	a5,s2,a5
		sp -= sp % 16; // riscv sp must be 16-byte aligned
    80004266:	ff07f913          	andi	s2,a5,-16
		if(sp < stackbase) {
    8000426a:	13896363          	bltu	s2,s8,80004390 <exec+0x2f8>
		if(copyout(pagetable, sp, argv[argc], kstrlen(argv[argc]) + 1) < 0) {
    8000426e:	df043d83          	ld	s11,-528(s0)
    80004272:	000dba03          	ld	s4,0(s11) # 1000 <_entry-0x7ffff000>
    80004276:	8552                	mv	a0,s4
    80004278:	ffffd097          	auipc	ra,0xffffd
    8000427c:	cf8080e7          	jalr	-776(ra) # 80000f70 <kstrlen>
    80004280:	0015069b          	addiw	a3,a0,1
    80004284:	8652                	mv	a2,s4
    80004286:	85ca                	mv	a1,s2
    80004288:	855a                	mv	a0,s6
    8000428a:	ffffd097          	auipc	ra,0xffffd
    8000428e:	51e080e7          	jalr	1310(ra) # 800017a8 <copyout>
    80004292:	10054363          	bltz	a0,80004398 <exec+0x300>
		ustack[argc] = sp;
    80004296:	0129b023          	sd	s2,0(s3)
	for(argc = 0; argv[argc]; argc++) {
    8000429a:	0485                	addi	s1,s1,1
    8000429c:	008d8793          	addi	a5,s11,8
    800042a0:	def43823          	sd	a5,-528(s0)
    800042a4:	008db503          	ld	a0,8(s11)
    800042a8:	c911                	beqz	a0,800042bc <exec+0x224>
		if(argc >= MAXARG) {
    800042aa:	09a1                	addi	s3,s3,8
    800042ac:	fb3c95e3          	bne	s9,s3,80004256 <exec+0x1be>
	sz = sz1;
    800042b0:	df743c23          	sd	s7,-520(s0)
	ip = 0;
    800042b4:	4a01                	li	s4,0
    800042b6:	a84d                	j	80004368 <exec+0x2d0>
	sp = sz;
    800042b8:	895e                	mv	s2,s7
	for(argc = 0; argv[argc]; argc++) {
    800042ba:	4481                	li	s1,0
	ustack[argc] = 0;
    800042bc:	00349793          	slli	a5,s1,0x3
    800042c0:	f9078793          	addi	a5,a5,-112 # f90 <_entry-0x7ffff070>
    800042c4:	97a2                	add	a5,a5,s0
    800042c6:	f007b023          	sd	zero,-256(a5)
	sp -= (argc + 1) * sizeof(uint64);
    800042ca:	00148693          	addi	a3,s1,1
    800042ce:	068e                	slli	a3,a3,0x3
    800042d0:	40d90933          	sub	s2,s2,a3
	sp -= sp % 16;
    800042d4:	ff097913          	andi	s2,s2,-16
	if(sp < stackbase) {
    800042d8:	01897663          	bgeu	s2,s8,800042e4 <exec+0x24c>
	sz = sz1;
    800042dc:	df743c23          	sd	s7,-520(s0)
	ip = 0;
    800042e0:	4a01                	li	s4,0
    800042e2:	a059                	j	80004368 <exec+0x2d0>
	if(copyout(pagetable, sp, (char *) ustack, (argc + 1) * sizeof(uint64)) < 0) {
    800042e4:	e9040613          	addi	a2,s0,-368
    800042e8:	85ca                	mv	a1,s2
    800042ea:	855a                	mv	a0,s6
    800042ec:	ffffd097          	auipc	ra,0xffffd
    800042f0:	4bc080e7          	jalr	1212(ra) # 800017a8 <copyout>
    800042f4:	0a054663          	bltz	a0,800043a0 <exec+0x308>
	p->trapframe->a1 = sp;
    800042f8:	058ab783          	ld	a5,88(s5)
    800042fc:	0727bc23          	sd	s2,120(a5)
	for(last = s = path; *s; s++) {
    80004300:	de843783          	ld	a5,-536(s0)
    80004304:	0007c703          	lbu	a4,0(a5)
    80004308:	cf11                	beqz	a4,80004324 <exec+0x28c>
    8000430a:	0785                	addi	a5,a5,1
		if(*s == '/') {
    8000430c:	02f00693          	li	a3,47
    80004310:	a039                	j	8000431e <exec+0x286>
			last = s + 1;
    80004312:	def43423          	sd	a5,-536(s0)
	for(last = s = path; *s; s++) {
    80004316:	0785                	addi	a5,a5,1
    80004318:	fff7c703          	lbu	a4,-1(a5)
    8000431c:	c701                	beqz	a4,80004324 <exec+0x28c>
		if(*s == '/') {
    8000431e:	fed71ce3          	bne	a4,a3,80004316 <exec+0x27e>
    80004322:	bfc5                	j	80004312 <exec+0x27a>
	ksafestrcpy(p->name, last, sizeof(p->name));
    80004324:	4641                	li	a2,16
    80004326:	de843583          	ld	a1,-536(s0)
    8000432a:	158a8513          	addi	a0,s5,344
    8000432e:	ffffd097          	auipc	ra,0xffffd
    80004332:	c10080e7          	jalr	-1008(ra) # 80000f3e <ksafestrcpy>
	oldpagetable = p->pagetable;
    80004336:	050ab503          	ld	a0,80(s5)
	p->pagetable = pagetable;
    8000433a:	056ab823          	sd	s6,80(s5)
	p->sz = sz;
    8000433e:	057ab423          	sd	s7,72(s5)
	p->trapframe->epc = elf.entry;	// initial program counter = main
    80004342:	058ab783          	ld	a5,88(s5)
    80004346:	e6843703          	ld	a4,-408(s0)
    8000434a:	ef98                	sd	a4,24(a5)
	p->trapframe->sp = sp; // initial stack pointer
    8000434c:	058ab783          	ld	a5,88(s5)
    80004350:	0327b823          	sd	s2,48(a5)
	proc_freepagetable(oldpagetable, oldsz);
    80004354:	85ea                	mv	a1,s10
    80004356:	ffffe097          	auipc	ra,0xffffe
    8000435a:	90e080e7          	jalr	-1778(ra) # 80001c64 <proc_freepagetable>
	return argc; // this ends up in a0, the first argument to main(argc, argv)
    8000435e:	0004851b          	sext.w	a0,s1
    80004362:	bbc1                	j	80004132 <exec+0x9a>
    80004364:	de943c23          	sd	s1,-520(s0)
		proc_freepagetable(pagetable, sz);
    80004368:	df843583          	ld	a1,-520(s0)
    8000436c:	855a                	mv	a0,s6
    8000436e:	ffffe097          	auipc	ra,0xffffe
    80004372:	8f6080e7          	jalr	-1802(ra) # 80001c64 <proc_freepagetable>
	return -1;
    80004376:	557d                	li	a0,-1
	if(ip) {
    80004378:	da0a0de3          	beqz	s4,80004132 <exec+0x9a>
    8000437c:	b34d                	j	8000411e <exec+0x86>
    8000437e:	de943c23          	sd	s1,-520(s0)
    80004382:	b7dd                	j	80004368 <exec+0x2d0>
    80004384:	de943c23          	sd	s1,-520(s0)
    80004388:	b7c5                	j	80004368 <exec+0x2d0>
    8000438a:	de943c23          	sd	s1,-520(s0)
    8000438e:	bfe9                	j	80004368 <exec+0x2d0>
	sz = sz1;
    80004390:	df743c23          	sd	s7,-520(s0)
	ip = 0;
    80004394:	4a01                	li	s4,0
    80004396:	bfc9                	j	80004368 <exec+0x2d0>
	sz = sz1;
    80004398:	df743c23          	sd	s7,-520(s0)
	ip = 0;
    8000439c:	4a01                	li	s4,0
    8000439e:	b7e9                	j	80004368 <exec+0x2d0>
	sz = sz1;
    800043a0:	df743c23          	sd	s7,-520(s0)
	ip = 0;
    800043a4:	4a01                	li	s4,0
    800043a6:	b7c9                	j	80004368 <exec+0x2d0>
		if((sz1 = uvmalloc(pagetable, sz, ph.vaddr + ph.memsz)) == 0)
    800043a8:	df843483          	ld	s1,-520(s0)
	for(i = 0, off = elf.phoff; i < elf.phnum; i++, off += sizeof(ph)){
    800043ac:	e0843783          	ld	a5,-504(s0)
    800043b0:	0017869b          	addiw	a3,a5,1
    800043b4:	e0d43423          	sd	a3,-504(s0)
    800043b8:	e0043783          	ld	a5,-512(s0)
    800043bc:	0387879b          	addiw	a5,a5,56
    800043c0:	e8845703          	lhu	a4,-376(s0)
    800043c4:	e2e6d3e3          	bge	a3,a4,800041ea <exec+0x152>
		if(ip->inode_ops->readi(ip, 0, (uint64) &ph, off, sizeof(ph)) != sizeof(ph)) {
    800043c8:	0007869b          	sext.w	a3,a5
    800043cc:	e0d43023          	sd	a3,-512(s0)
    800043d0:	010a3783          	ld	a5,16(s4)
    800043d4:	6bbc                	ld	a5,80(a5)
    800043d6:	03800713          	li	a4,56
    800043da:	e1840613          	addi	a2,s0,-488
    800043de:	4581                	li	a1,0
    800043e0:	8552                	mv	a0,s4
    800043e2:	9782                	jalr	a5
    800043e4:	03800793          	li	a5,56
    800043e8:	f6f51ee3          	bne	a0,a5,80004364 <exec+0x2cc>
		if(ph.type != ELF_PROG_LOAD) {
    800043ec:	e1842783          	lw	a5,-488(s0)
    800043f0:	4705                	li	a4,1
    800043f2:	fae79de3          	bne	a5,a4,800043ac <exec+0x314>
		if(ph.memsz < ph.filesz) {
    800043f6:	e4043603          	ld	a2,-448(s0)
    800043fa:	e3843783          	ld	a5,-456(s0)
    800043fe:	f8f660e3          	bltu	a2,a5,8000437e <exec+0x2e6>
		if(ph.vaddr + ph.memsz < ph.vaddr) {
    80004402:	e2843783          	ld	a5,-472(s0)
    80004406:	963e                	add	a2,a2,a5
    80004408:	f6f66ee3          	bltu	a2,a5,80004384 <exec+0x2ec>
		if((sz1 = uvmalloc(pagetable, sz, ph.vaddr + ph.memsz)) == 0)
    8000440c:	85a6                	mv	a1,s1
    8000440e:	855a                	mv	a0,s6
    80004410:	ffffd097          	auipc	ra,0xffffd
    80004414:	144080e7          	jalr	324(ra) # 80001554 <uvmalloc>
    80004418:	dea43c23          	sd	a0,-520(s0)
    8000441c:	d53d                	beqz	a0,8000438a <exec+0x2f2>
		if((ph.vaddr % PGSIZE) != 0)
    8000441e:	e2843c03          	ld	s8,-472(s0)
    80004422:	de043783          	ld	a5,-544(s0)
    80004426:	00fc77b3          	and	a5,s8,a5
    8000442a:	ff9d                	bnez	a5,80004368 <exec+0x2d0>
		if(loadseg(pagetable, ph.vaddr, ip, ph.off, ph.filesz) < 0)
    8000442c:	e2042c83          	lw	s9,-480(s0)
    80004430:	e3842b83          	lw	s7,-456(s0)
	for(i = 0; i < sz; i += PGSIZE){
    80004434:	f60b8ae3          	beqz	s7,800043a8 <exec+0x310>
    80004438:	89de                	mv	s3,s7
    8000443a:	4481                	li	s1,0
    8000443c:	b371                	j	800041c8 <exec+0x130>

000000008000443e <argfd>:
extern struct vfs * root_fs;

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int argfd(int n, int * pfd, struct file ** pf)
{
    8000443e:	7179                	addi	sp,sp,-48
    80004440:	f406                	sd	ra,40(sp)
    80004442:	f022                	sd	s0,32(sp)
    80004444:	ec26                	sd	s1,24(sp)
    80004446:	e84a                	sd	s2,16(sp)
    80004448:	1800                	addi	s0,sp,48
    8000444a:	892e                	mv	s2,a1
    8000444c:	84b2                	mv	s1,a2
	int fd;
	struct file * f;

	if(argint(n, &fd) < 0)
    8000444e:	fdc40593          	addi	a1,s0,-36
    80004452:	ffffe097          	auipc	ra,0xffffe
    80004456:	64a080e7          	jalr	1610(ra) # 80002a9c <argint>
    8000445a:	04054063          	bltz	a0,8000449a <argfd+0x5c>
		return -1;

	if(fd < 0 || fd >= NOFILE || (f = myproc()->ofile[fd]) == NULL)
    8000445e:	fdc42703          	lw	a4,-36(s0)
    80004462:	47bd                	li	a5,15
    80004464:	02e7ed63          	bltu	a5,a4,8000449e <argfd+0x60>
    80004468:	ffffd097          	auipc	ra,0xffffd
    8000446c:	67c080e7          	jalr	1660(ra) # 80001ae4 <myproc>
    80004470:	fdc42703          	lw	a4,-36(s0)
    80004474:	01a70793          	addi	a5,a4,26 # fffffffffffff01a <end+0xffffffff7ffd4c5a>
    80004478:	078e                	slli	a5,a5,0x3
    8000447a:	953e                	add	a0,a0,a5
    8000447c:	611c                	ld	a5,0(a0)
    8000447e:	c395                	beqz	a5,800044a2 <argfd+0x64>
		return -1;

	if(pfd)
    80004480:	00090463          	beqz	s2,80004488 <argfd+0x4a>
		*pfd = fd;
    80004484:	00e92023          	sw	a4,0(s2)

	if(pf)
		*pf = f;

	return 0;
    80004488:	4501                	li	a0,0
	if(pf)
    8000448a:	c091                	beqz	s1,8000448e <argfd+0x50>
		*pf = f;
    8000448c:	e09c                	sd	a5,0(s1)
}
    8000448e:	70a2                	ld	ra,40(sp)
    80004490:	7402                	ld	s0,32(sp)
    80004492:	64e2                	ld	s1,24(sp)
    80004494:	6942                	ld	s2,16(sp)
    80004496:	6145                	addi	sp,sp,48
    80004498:	8082                	ret
		return -1;
    8000449a:	557d                	li	a0,-1
    8000449c:	bfcd                	j	8000448e <argfd+0x50>
		return -1;
    8000449e:	557d                	li	a0,-1
    800044a0:	b7fd                	j	8000448e <argfd+0x50>
    800044a2:	557d                	li	a0,-1
    800044a4:	b7ed                	j	8000448e <argfd+0x50>

00000000800044a6 <fdalloc>:

// Allocate a file descriptor for the given file.
// Takes over file reference from caller on success.
static int fdalloc(struct file *f)
{
    800044a6:	1101                	addi	sp,sp,-32
    800044a8:	ec06                	sd	ra,24(sp)
    800044aa:	e822                	sd	s0,16(sp)
    800044ac:	e426                	sd	s1,8(sp)
    800044ae:	1000                	addi	s0,sp,32
    800044b0:	84aa                	mv	s1,a0
	int fd;
	struct proc * p = myproc();
    800044b2:	ffffd097          	auipc	ra,0xffffd
    800044b6:	632080e7          	jalr	1586(ra) # 80001ae4 <myproc>
    800044ba:	862a                	mv	a2,a0

	for(fd = 0; fd < NOFILE; fd++) {
    800044bc:	0d050793          	addi	a5,a0,208
    800044c0:	4501                	li	a0,0
    800044c2:	46c1                	li	a3,16
		if(p->ofile[fd] == 0) {
    800044c4:	6398                	ld	a4,0(a5)
    800044c6:	cb19                	beqz	a4,800044dc <fdalloc+0x36>
	for(fd = 0; fd < NOFILE; fd++) {
    800044c8:	2505                	addiw	a0,a0,1
    800044ca:	07a1                	addi	a5,a5,8
    800044cc:	fed51ce3          	bne	a0,a3,800044c4 <fdalloc+0x1e>

			return fd;
		}
	}

	return -1;
    800044d0:	557d                	li	a0,-1
}
    800044d2:	60e2                	ld	ra,24(sp)
    800044d4:	6442                	ld	s0,16(sp)
    800044d6:	64a2                	ld	s1,8(sp)
    800044d8:	6105                	addi	sp,sp,32
    800044da:	8082                	ret
			p->ofile[fd] = f;
    800044dc:	01a50793          	addi	a5,a0,26
    800044e0:	078e                	slli	a5,a5,0x3
    800044e2:	963e                	add	a2,a2,a5
    800044e4:	e204                	sd	s1,0(a2)
			return fd;
    800044e6:	b7f5                	j	800044d2 <fdalloc+0x2c>

00000000800044e8 <create>:

	return -1;
}

static struct inode * create(char * path, short type, short major, short minor)
{
    800044e8:	715d                	addi	sp,sp,-80
    800044ea:	e486                	sd	ra,72(sp)
    800044ec:	e0a2                	sd	s0,64(sp)
    800044ee:	fc26                	sd	s1,56(sp)
    800044f0:	f84a                	sd	s2,48(sp)
    800044f2:	f44e                	sd	s3,40(sp)
    800044f4:	f052                	sd	s4,32(sp)
    800044f6:	ec56                	sd	s5,24(sp)
    800044f8:	0880                	addi	s0,sp,80
    800044fa:	8a2e                	mv	s4,a1
    800044fc:	8ab2                	mv	s5,a2
    800044fe:	89b6                	mv	s3,a3
	struct inode * ip, * dp;
	char name[DIRSIZ];

	if((dp = nameiparent(path, name)) == NULL)
    80004500:	fb040593          	addi	a1,s0,-80
    80004504:	fffff097          	auipc	ra,0xfffff
    80004508:	e64080e7          	jalr	-412(ra) # 80003368 <nameiparent>
    8000450c:	892a                	mv	s2,a0
    8000450e:	12050e63          	beqz	a0,8000464a <create+0x162>
		return NULL;

	dp->inode_ops->ilock(dp);
    80004512:	691c                	ld	a5,16(a0)
    80004514:	739c                	ld	a5,32(a5)
    80004516:	9782                	jalr	a5

	if((ip = dp->inode_ops->dir_lookup(dp, name, 0)) != NULL) {
    80004518:	01093783          	ld	a5,16(s2)
    8000451c:	639c                	ld	a5,0(a5)
    8000451e:	4601                	li	a2,0
    80004520:	fb040593          	addi	a1,s0,-80
    80004524:	854a                	mv	a0,s2
    80004526:	9782                	jalr	a5
    80004528:	84aa                	mv	s1,a0
    8000452a:	c531                	beqz	a0,80004576 <create+0x8e>
		dp->inode_ops->iunlockput(dp);
    8000452c:	01093783          	ld	a5,16(s2)
    80004530:	7f9c                	ld	a5,56(a5)
    80004532:	854a                	mv	a0,s2
    80004534:	9782                	jalr	a5
		ip->inode_ops->ilock(ip);
    80004536:	689c                	ld	a5,16(s1)
    80004538:	739c                	ld	a5,32(a5)
    8000453a:	8526                	mv	a0,s1
    8000453c:	9782                	jalr	a5

		if(type == T_FILE && (ip->type == T_FILE || ip->type == T_DEVICE))
    8000453e:	000a059b          	sext.w	a1,s4
    80004542:	4789                	li	a5,2
    80004544:	00f59a63          	bne	a1,a5,80004558 <create+0x70>
    80004548:	0284d783          	lhu	a5,40(s1)
    8000454c:	37f9                	addiw	a5,a5,-2
    8000454e:	17c2                	slli	a5,a5,0x30
    80004550:	93c1                	srli	a5,a5,0x30
    80004552:	4705                	li	a4,1
    80004554:	00f77763          	bgeu	a4,a5,80004562 <create+0x7a>
			return ip;

		ip->inode_ops->iunlockput(ip);
    80004558:	689c                	ld	a5,16(s1)
    8000455a:	7f9c                	ld	a5,56(a5)
    8000455c:	8526                	mv	a0,s1
    8000455e:	9782                	jalr	a5

		return NULL;
    80004560:	4481                	li	s1,0
		panic("create: dir_link()");

	dp->inode_ops->iunlockput(dp);

	return ip;
}
    80004562:	8526                	mv	a0,s1
    80004564:	60a6                	ld	ra,72(sp)
    80004566:	6406                	ld	s0,64(sp)
    80004568:	74e2                	ld	s1,56(sp)
    8000456a:	7942                	ld	s2,48(sp)
    8000456c:	79a2                	ld	s3,40(sp)
    8000456e:	7a02                	ld	s4,32(sp)
    80004570:	6ae2                	ld	s5,24(sp)
    80004572:	6161                	addi	sp,sp,80
    80004574:	8082                	ret
	if((ip = dp->vfs_ops->ialloc(dp->dev, type)) == NULL) // This should really use the major and minor numbers to reference a list of devices and find the corresponding superblock
    80004576:	01893783          	ld	a5,24(s2)
    8000457a:	6b9c                	ld	a5,16(a5)
    8000457c:	85d2                	mv	a1,s4
    8000457e:	00092503          	lw	a0,0(s2)
    80004582:	9782                	jalr	a5
    80004584:	84aa                	mv	s1,a0
    80004586:	c529                	beqz	a0,800045d0 <create+0xe8>
	ip->inode_ops->ilock(ip);
    80004588:	691c                	ld	a5,16(a0)
    8000458a:	739c                	ld	a5,32(a5)
    8000458c:	9782                	jalr	a5
	ip->major = major;
    8000458e:	03549523          	sh	s5,42(s1)
	ip->minor = minor;
    80004592:	03349623          	sh	s3,44(s1)
	ip->nlink = 1;
    80004596:	4985                	li	s3,1
    80004598:	03349723          	sh	s3,46(s1)
	ip->inode_ops->iupdate(ip);
    8000459c:	689c                	ld	a5,16(s1)
    8000459e:	679c                	ld	a5,8(a5)
    800045a0:	8526                	mv	a0,s1
    800045a2:	9782                	jalr	a5
	if(type == T_DIR) {  // Create . and .. entries.
    800045a4:	000a059b          	sext.w	a1,s4
    800045a8:	03358c63          	beq	a1,s3,800045e0 <create+0xf8>
	if(dp->inode_ops->dir_link(dp, name, ip->inum, ip->type) < 0)
    800045ac:	01093783          	ld	a5,16(s2)
    800045b0:	73bc                	ld	a5,96(a5)
    800045b2:	02849683          	lh	a3,40(s1)
    800045b6:	40d0                	lw	a2,4(s1)
    800045b8:	fb040593          	addi	a1,s0,-80
    800045bc:	854a                	mv	a0,s2
    800045be:	9782                	jalr	a5
    800045c0:	06054d63          	bltz	a0,8000463a <create+0x152>
	dp->inode_ops->iunlockput(dp);
    800045c4:	01093783          	ld	a5,16(s2)
    800045c8:	7f9c                	ld	a5,56(a5)
    800045ca:	854a                	mv	a0,s2
    800045cc:	9782                	jalr	a5
	return ip;
    800045ce:	bf51                	j	80004562 <create+0x7a>
		panic("create: ialloc");
    800045d0:	00005517          	auipc	a0,0x5
    800045d4:	0d850513          	addi	a0,a0,216 # 800096a8 <syscalls+0x2d0>
    800045d8:	ffffc097          	auipc	ra,0xffffc
    800045dc:	08a080e7          	jalr	138(ra) # 80000662 <panic>
		dp->nlink++;  // for ".."
    800045e0:	02e95783          	lhu	a5,46(s2)
    800045e4:	2785                	addiw	a5,a5,1
    800045e6:	02f91723          	sh	a5,46(s2)
		dp->inode_ops->iupdate(dp);
    800045ea:	01093783          	ld	a5,16(s2)
    800045ee:	679c                	ld	a5,8(a5)
    800045f0:	854a                	mv	a0,s2
    800045f2:	9782                	jalr	a5
		if(ip->inode_ops->dir_link(ip, ".", ip->inum, ip->type) < 0 || ip->inode_ops->dir_link(ip, "..", dp->inum, dp->type) < 0)
    800045f4:	689c                	ld	a5,16(s1)
    800045f6:	73bc                	ld	a5,96(a5)
    800045f8:	02849683          	lh	a3,40(s1)
    800045fc:	40d0                	lw	a2,4(s1)
    800045fe:	00005597          	auipc	a1,0x5
    80004602:	0ba58593          	addi	a1,a1,186 # 800096b8 <syscalls+0x2e0>
    80004606:	8526                	mv	a0,s1
    80004608:	9782                	jalr	a5
    8000460a:	02054063          	bltz	a0,8000462a <create+0x142>
    8000460e:	689c                	ld	a5,16(s1)
    80004610:	73bc                	ld	a5,96(a5)
    80004612:	02891683          	lh	a3,40(s2)
    80004616:	00492603          	lw	a2,4(s2)
    8000461a:	00005597          	auipc	a1,0x5
    8000461e:	0a658593          	addi	a1,a1,166 # 800096c0 <syscalls+0x2e8>
    80004622:	8526                	mv	a0,s1
    80004624:	9782                	jalr	a5
    80004626:	f80553e3          	bgez	a0,800045ac <create+0xc4>
			panic("create dots");
    8000462a:	00005517          	auipc	a0,0x5
    8000462e:	09e50513          	addi	a0,a0,158 # 800096c8 <syscalls+0x2f0>
    80004632:	ffffc097          	auipc	ra,0xffffc
    80004636:	030080e7          	jalr	48(ra) # 80000662 <panic>
		panic("create: dir_link()");
    8000463a:	00005517          	auipc	a0,0x5
    8000463e:	09e50513          	addi	a0,a0,158 # 800096d8 <syscalls+0x300>
    80004642:	ffffc097          	auipc	ra,0xffffc
    80004646:	020080e7          	jalr	32(ra) # 80000662 <panic>
		return NULL;
    8000464a:	84aa                	mv	s1,a0
    8000464c:	bf19                	j	80004562 <create+0x7a>

000000008000464e <sys_dup>:
{
    8000464e:	7179                	addi	sp,sp,-48
    80004650:	f406                	sd	ra,40(sp)
    80004652:	f022                	sd	s0,32(sp)
    80004654:	ec26                	sd	s1,24(sp)
    80004656:	e84a                	sd	s2,16(sp)
    80004658:	1800                	addi	s0,sp,48
	if(argfd(0, 0, &f) < 0)
    8000465a:	fd840613          	addi	a2,s0,-40
    8000465e:	4581                	li	a1,0
    80004660:	4501                	li	a0,0
    80004662:	00000097          	auipc	ra,0x0
    80004666:	ddc080e7          	jalr	-548(ra) # 8000443e <argfd>
		return -1;
    8000466a:	57fd                	li	a5,-1
	if(argfd(0, 0, &f) < 0)
    8000466c:	02054363          	bltz	a0,80004692 <sys_dup+0x44>
	if((fd = fdalloc(f)) < 0)
    80004670:	fd843903          	ld	s2,-40(s0)
    80004674:	854a                	mv	a0,s2
    80004676:	00000097          	auipc	ra,0x0
    8000467a:	e30080e7          	jalr	-464(ra) # 800044a6 <fdalloc>
    8000467e:	84aa                	mv	s1,a0
		return -1;
    80004680:	57fd                	li	a5,-1
	if((fd = fdalloc(f)) < 0)
    80004682:	00054863          	bltz	a0,80004692 <sys_dup+0x44>
	filedup(f);
    80004686:	854a                	mv	a0,s2
    80004688:	fffff097          	auipc	ra,0xfffff
    8000468c:	37c080e7          	jalr	892(ra) # 80003a04 <filedup>
	return fd;
    80004690:	87a6                	mv	a5,s1
}
    80004692:	853e                	mv	a0,a5
    80004694:	70a2                	ld	ra,40(sp)
    80004696:	7402                	ld	s0,32(sp)
    80004698:	64e2                	ld	s1,24(sp)
    8000469a:	6942                	ld	s2,16(sp)
    8000469c:	6145                	addi	sp,sp,48
    8000469e:	8082                	ret

00000000800046a0 <sys_read>:
{
    800046a0:	7179                	addi	sp,sp,-48
    800046a2:	f406                	sd	ra,40(sp)
    800046a4:	f022                	sd	s0,32(sp)
    800046a6:	1800                	addi	s0,sp,48
	if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    800046a8:	fe840613          	addi	a2,s0,-24
    800046ac:	4581                	li	a1,0
    800046ae:	4501                	li	a0,0
    800046b0:	00000097          	auipc	ra,0x0
    800046b4:	d8e080e7          	jalr	-626(ra) # 8000443e <argfd>
		return -1;
    800046b8:	57fd                	li	a5,-1
	if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    800046ba:	04054163          	bltz	a0,800046fc <sys_read+0x5c>
    800046be:	fe440593          	addi	a1,s0,-28
    800046c2:	4509                	li	a0,2
    800046c4:	ffffe097          	auipc	ra,0xffffe
    800046c8:	3d8080e7          	jalr	984(ra) # 80002a9c <argint>
		return -1;
    800046cc:	57fd                	li	a5,-1
	if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    800046ce:	02054763          	bltz	a0,800046fc <sys_read+0x5c>
    800046d2:	fd840593          	addi	a1,s0,-40
    800046d6:	4505                	li	a0,1
    800046d8:	ffffe097          	auipc	ra,0xffffe
    800046dc:	3e6080e7          	jalr	998(ra) # 80002abe <argaddr>
		return -1;
    800046e0:	57fd                	li	a5,-1
	if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    800046e2:	00054d63          	bltz	a0,800046fc <sys_read+0x5c>
	return fileread(f, p, n);
    800046e6:	fe442603          	lw	a2,-28(s0)
    800046ea:	fd843583          	ld	a1,-40(s0)
    800046ee:	fe843503          	ld	a0,-24(s0)
    800046f2:	fffff097          	auipc	ra,0xfffff
    800046f6:	498080e7          	jalr	1176(ra) # 80003b8a <fileread>
    800046fa:	87aa                	mv	a5,a0
}
    800046fc:	853e                	mv	a0,a5
    800046fe:	70a2                	ld	ra,40(sp)
    80004700:	7402                	ld	s0,32(sp)
    80004702:	6145                	addi	sp,sp,48
    80004704:	8082                	ret

0000000080004706 <sys_write>:
{
    80004706:	7179                	addi	sp,sp,-48
    80004708:	f406                	sd	ra,40(sp)
    8000470a:	f022                	sd	s0,32(sp)
    8000470c:	1800                	addi	s0,sp,48
	if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    8000470e:	fe840613          	addi	a2,s0,-24
    80004712:	4581                	li	a1,0
    80004714:	4501                	li	a0,0
    80004716:	00000097          	auipc	ra,0x0
    8000471a:	d28080e7          	jalr	-728(ra) # 8000443e <argfd>
		return -1;
    8000471e:	57fd                	li	a5,-1
	if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    80004720:	04054163          	bltz	a0,80004762 <sys_write+0x5c>
    80004724:	fe440593          	addi	a1,s0,-28
    80004728:	4509                	li	a0,2
    8000472a:	ffffe097          	auipc	ra,0xffffe
    8000472e:	372080e7          	jalr	882(ra) # 80002a9c <argint>
		return -1;
    80004732:	57fd                	li	a5,-1
	if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    80004734:	02054763          	bltz	a0,80004762 <sys_write+0x5c>
    80004738:	fd840593          	addi	a1,s0,-40
    8000473c:	4505                	li	a0,1
    8000473e:	ffffe097          	auipc	ra,0xffffe
    80004742:	380080e7          	jalr	896(ra) # 80002abe <argaddr>
		return -1;
    80004746:	57fd                	li	a5,-1
	if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    80004748:	00054d63          	bltz	a0,80004762 <sys_write+0x5c>
	return filewrite(f, p, n);
    8000474c:	fe442603          	lw	a2,-28(s0)
    80004750:	fd843583          	ld	a1,-40(s0)
    80004754:	fe843503          	ld	a0,-24(s0)
    80004758:	fffff097          	auipc	ra,0xfffff
    8000475c:	4ee080e7          	jalr	1262(ra) # 80003c46 <filewrite>
    80004760:	87aa                	mv	a5,a0
}
    80004762:	853e                	mv	a0,a5
    80004764:	70a2                	ld	ra,40(sp)
    80004766:	7402                	ld	s0,32(sp)
    80004768:	6145                	addi	sp,sp,48
    8000476a:	8082                	ret

000000008000476c <sys_close>:
{
    8000476c:	1101                	addi	sp,sp,-32
    8000476e:	ec06                	sd	ra,24(sp)
    80004770:	e822                	sd	s0,16(sp)
    80004772:	1000                	addi	s0,sp,32
	if(argfd(0, &fd, &f) < 0)
    80004774:	fe040613          	addi	a2,s0,-32
    80004778:	fec40593          	addi	a1,s0,-20
    8000477c:	4501                	li	a0,0
    8000477e:	00000097          	auipc	ra,0x0
    80004782:	cc0080e7          	jalr	-832(ra) # 8000443e <argfd>
		return -1;
    80004786:	57fd                	li	a5,-1
	if(argfd(0, &fd, &f) < 0)
    80004788:	02054463          	bltz	a0,800047b0 <sys_close+0x44>
	myproc()->ofile[fd] = 0;
    8000478c:	ffffd097          	auipc	ra,0xffffd
    80004790:	358080e7          	jalr	856(ra) # 80001ae4 <myproc>
    80004794:	fec42783          	lw	a5,-20(s0)
    80004798:	07e9                	addi	a5,a5,26
    8000479a:	078e                	slli	a5,a5,0x3
    8000479c:	953e                	add	a0,a0,a5
    8000479e:	00053023          	sd	zero,0(a0)
	fileclose(f);
    800047a2:	fe043503          	ld	a0,-32(s0)
    800047a6:	fffff097          	auipc	ra,0xfffff
    800047aa:	2b0080e7          	jalr	688(ra) # 80003a56 <fileclose>
	return 0;
    800047ae:	4781                	li	a5,0
}
    800047b0:	853e                	mv	a0,a5
    800047b2:	60e2                	ld	ra,24(sp)
    800047b4:	6442                	ld	s0,16(sp)
    800047b6:	6105                	addi	sp,sp,32
    800047b8:	8082                	ret

00000000800047ba <sys_fstat>:
{
    800047ba:	1101                	addi	sp,sp,-32
    800047bc:	ec06                	sd	ra,24(sp)
    800047be:	e822                	sd	s0,16(sp)
    800047c0:	1000                	addi	s0,sp,32
	if(argfd(0, 0, &f) < 0 || argaddr(1, &st) < 0)
    800047c2:	fe840613          	addi	a2,s0,-24
    800047c6:	4581                	li	a1,0
    800047c8:	4501                	li	a0,0
    800047ca:	00000097          	auipc	ra,0x0
    800047ce:	c74080e7          	jalr	-908(ra) # 8000443e <argfd>
		return -1;
    800047d2:	57fd                	li	a5,-1
	if(argfd(0, 0, &f) < 0 || argaddr(1, &st) < 0)
    800047d4:	02054563          	bltz	a0,800047fe <sys_fstat+0x44>
    800047d8:	fe040593          	addi	a1,s0,-32
    800047dc:	4505                	li	a0,1
    800047de:	ffffe097          	auipc	ra,0xffffe
    800047e2:	2e0080e7          	jalr	736(ra) # 80002abe <argaddr>
		return -1;
    800047e6:	57fd                	li	a5,-1
	if(argfd(0, 0, &f) < 0 || argaddr(1, &st) < 0)
    800047e8:	00054b63          	bltz	a0,800047fe <sys_fstat+0x44>
	return filestat(f, st);
    800047ec:	fe043583          	ld	a1,-32(s0)
    800047f0:	fe843503          	ld	a0,-24(s0)
    800047f4:	fffff097          	auipc	ra,0xfffff
    800047f8:	32a080e7          	jalr	810(ra) # 80003b1e <filestat>
    800047fc:	87aa                	mv	a5,a0
}
    800047fe:	853e                	mv	a0,a5
    80004800:	60e2                	ld	ra,24(sp)
    80004802:	6442                	ld	s0,16(sp)
    80004804:	6105                	addi	sp,sp,32
    80004806:	8082                	ret

0000000080004808 <sys_link>:
{
    80004808:	7169                	addi	sp,sp,-304
    8000480a:	f606                	sd	ra,296(sp)
    8000480c:	f222                	sd	s0,288(sp)
    8000480e:	ee26                	sd	s1,280(sp)
    80004810:	ea4a                	sd	s2,272(sp)
    80004812:	1a00                	addi	s0,sp,304
	if(argstr(0, old, MAXPATH) < 0 || argstr(1, new, MAXPATH) < 0)
    80004814:	08000613          	li	a2,128
    80004818:	ed040593          	addi	a1,s0,-304
    8000481c:	4501                	li	a0,0
    8000481e:	ffffe097          	auipc	ra,0xffffe
    80004822:	2c2080e7          	jalr	706(ra) # 80002ae0 <argstr>
		return -1;
    80004826:	57fd                	li	a5,-1
	if(argstr(0, old, MAXPATH) < 0 || argstr(1, new, MAXPATH) < 0)
    80004828:	10054463          	bltz	a0,80004930 <sys_link+0x128>
    8000482c:	08000613          	li	a2,128
    80004830:	f5040593          	addi	a1,s0,-176
    80004834:	4505                	li	a0,1
    80004836:	ffffe097          	auipc	ra,0xffffe
    8000483a:	2aa080e7          	jalr	682(ra) # 80002ae0 <argstr>
		return -1;
    8000483e:	57fd                	li	a5,-1
	if(argstr(0, old, MAXPATH) < 0 || argstr(1, new, MAXPATH) < 0)
    80004840:	0e054863          	bltz	a0,80004930 <sys_link+0x128>
	begin_op();
    80004844:	fffff097          	auipc	ra,0xfffff
    80004848:	d3e080e7          	jalr	-706(ra) # 80003582 <begin_op>
	if((ip = namei(old)) == NULL) {
    8000484c:	ed040513          	addi	a0,s0,-304
    80004850:	fffff097          	auipc	ra,0xfffff
    80004854:	afa080e7          	jalr	-1286(ra) # 8000334a <namei>
    80004858:	84aa                	mv	s1,a0
    8000485a:	c149                	beqz	a0,800048dc <sys_link+0xd4>
	ip->inode_ops->ilock(ip);
    8000485c:	691c                	ld	a5,16(a0)
    8000485e:	739c                	ld	a5,32(a5)
    80004860:	9782                	jalr	a5
	if(ip->type == T_DIR) {
    80004862:	02849703          	lh	a4,40(s1)
    80004866:	4785                	li	a5,1
    80004868:	08f70063          	beq	a4,a5,800048e8 <sys_link+0xe0>
	ip->nlink++;
    8000486c:	02e4d783          	lhu	a5,46(s1)
    80004870:	2785                	addiw	a5,a5,1
    80004872:	02f49723          	sh	a5,46(s1)
	ip->inode_ops->iupdate(ip);
    80004876:	689c                	ld	a5,16(s1)
    80004878:	679c                	ld	a5,8(a5)
    8000487a:	8526                	mv	a0,s1
    8000487c:	9782                	jalr	a5
	ip->inode_ops->iunlock(ip);
    8000487e:	689c                	ld	a5,16(s1)
    80004880:	7b9c                	ld	a5,48(a5)
    80004882:	8526                	mv	a0,s1
    80004884:	9782                	jalr	a5
	if((dp = nameiparent(new, name)) == NULL)
    80004886:	fd040593          	addi	a1,s0,-48
    8000488a:	f5040513          	addi	a0,s0,-176
    8000488e:	fffff097          	auipc	ra,0xfffff
    80004892:	ada080e7          	jalr	-1318(ra) # 80003368 <nameiparent>
    80004896:	892a                	mv	s2,a0
    80004898:	c535                	beqz	a0,80004904 <sys_link+0xfc>
	ip->inode_ops->ilock(dp);
    8000489a:	689c                	ld	a5,16(s1)
    8000489c:	739c                	ld	a5,32(a5)
    8000489e:	9782                	jalr	a5
	if(dp->dev != ip->dev || ip->inode_ops->dir_link(dp, name, ip->inum, ip->type) < 0) {
    800048a0:	00092703          	lw	a4,0(s2)
    800048a4:	409c                	lw	a5,0(s1)
    800048a6:	04f71b63          	bne	a4,a5,800048fc <sys_link+0xf4>
    800048aa:	689c                	ld	a5,16(s1)
    800048ac:	73bc                	ld	a5,96(a5)
    800048ae:	02849683          	lh	a3,40(s1)
    800048b2:	40d0                	lw	a2,4(s1)
    800048b4:	fd040593          	addi	a1,s0,-48
    800048b8:	854a                	mv	a0,s2
    800048ba:	9782                	jalr	a5
    800048bc:	04054063          	bltz	a0,800048fc <sys_link+0xf4>
	ip->inode_ops->iunlockput(dp);
    800048c0:	689c                	ld	a5,16(s1)
    800048c2:	7f9c                	ld	a5,56(a5)
    800048c4:	854a                	mv	a0,s2
    800048c6:	9782                	jalr	a5
	ip->inode_ops->iput(ip);
    800048c8:	689c                	ld	a5,16(s1)
    800048ca:	779c                	ld	a5,40(a5)
    800048cc:	8526                	mv	a0,s1
    800048ce:	9782                	jalr	a5
	end_op();
    800048d0:	fffff097          	auipc	ra,0xfffff
    800048d4:	d30080e7          	jalr	-720(ra) # 80003600 <end_op>
	return 0;
    800048d8:	4781                	li	a5,0
    800048da:	a899                	j	80004930 <sys_link+0x128>
		end_op();
    800048dc:	fffff097          	auipc	ra,0xfffff
    800048e0:	d24080e7          	jalr	-732(ra) # 80003600 <end_op>
		return -1;
    800048e4:	57fd                	li	a5,-1
    800048e6:	a0a9                	j	80004930 <sys_link+0x128>
		ip->inode_ops->iunlockput(ip);
    800048e8:	689c                	ld	a5,16(s1)
    800048ea:	7f9c                	ld	a5,56(a5)
    800048ec:	8526                	mv	a0,s1
    800048ee:	9782                	jalr	a5
		end_op();
    800048f0:	fffff097          	auipc	ra,0xfffff
    800048f4:	d10080e7          	jalr	-752(ra) # 80003600 <end_op>
		return -1;
    800048f8:	57fd                	li	a5,-1
    800048fa:	a81d                	j	80004930 <sys_link+0x128>
		ip->inode_ops->iunlockput(dp);
    800048fc:	689c                	ld	a5,16(s1)
    800048fe:	7f9c                	ld	a5,56(a5)
    80004900:	854a                	mv	a0,s2
    80004902:	9782                	jalr	a5
	ip->inode_ops->ilock(ip);
    80004904:	689c                	ld	a5,16(s1)
    80004906:	739c                	ld	a5,32(a5)
    80004908:	8526                	mv	a0,s1
    8000490a:	9782                	jalr	a5
	ip->nlink--;
    8000490c:	02e4d783          	lhu	a5,46(s1)
    80004910:	37fd                	addiw	a5,a5,-1
    80004912:	02f49723          	sh	a5,46(s1)
	ip->inode_ops->iupdate(ip);
    80004916:	689c                	ld	a5,16(s1)
    80004918:	679c                	ld	a5,8(a5)
    8000491a:	8526                	mv	a0,s1
    8000491c:	9782                	jalr	a5
	ip->inode_ops->iunlockput(ip);
    8000491e:	689c                	ld	a5,16(s1)
    80004920:	7f9c                	ld	a5,56(a5)
    80004922:	8526                	mv	a0,s1
    80004924:	9782                	jalr	a5
	end_op();
    80004926:	fffff097          	auipc	ra,0xfffff
    8000492a:	cda080e7          	jalr	-806(ra) # 80003600 <end_op>
	return -1;
    8000492e:	57fd                	li	a5,-1
}
    80004930:	853e                	mv	a0,a5
    80004932:	70b2                	ld	ra,296(sp)
    80004934:	7412                	ld	s0,288(sp)
    80004936:	64f2                	ld	s1,280(sp)
    80004938:	6952                	ld	s2,272(sp)
    8000493a:	6155                	addi	sp,sp,304
    8000493c:	8082                	ret

000000008000493e <sys_unlink>:
{
    8000493e:	7151                	addi	sp,sp,-240
    80004940:	f586                	sd	ra,232(sp)
    80004942:	f1a2                	sd	s0,224(sp)
    80004944:	eda6                	sd	s1,216(sp)
    80004946:	e9ca                	sd	s2,208(sp)
    80004948:	e5ce                	sd	s3,200(sp)
    8000494a:	1980                	addi	s0,sp,240
	if(argstr(0, path, MAXPATH) < 0)
    8000494c:	08000613          	li	a2,128
    80004950:	f3040593          	addi	a1,s0,-208
    80004954:	4501                	li	a0,0
    80004956:	ffffe097          	auipc	ra,0xffffe
    8000495a:	18a080e7          	jalr	394(ra) # 80002ae0 <argstr>
    8000495e:	18054063          	bltz	a0,80004ade <sys_unlink+0x1a0>
	begin_op();
    80004962:	fffff097          	auipc	ra,0xfffff
    80004966:	c20080e7          	jalr	-992(ra) # 80003582 <begin_op>
	if((dp = nameiparent(path, name)) == NULL) {
    8000496a:	fb040593          	addi	a1,s0,-80
    8000496e:	f3040513          	addi	a0,s0,-208
    80004972:	fffff097          	auipc	ra,0xfffff
    80004976:	9f6080e7          	jalr	-1546(ra) # 80003368 <nameiparent>
    8000497a:	892a                	mv	s2,a0
    8000497c:	cd69                	beqz	a0,80004a56 <sys_unlink+0x118>
	dp->inode_ops->ilock(dp);
    8000497e:	691c                	ld	a5,16(a0)
    80004980:	739c                	ld	a5,32(a5)
    80004982:	9782                	jalr	a5
	if(dp->vfs_ops->name_cmp(name, ".") == 0 || dp->vfs_ops->name_cmp(name, "..") == 0)
    80004984:	01893783          	ld	a5,24(s2)
    80004988:	67bc                	ld	a5,72(a5)
    8000498a:	00005597          	auipc	a1,0x5
    8000498e:	d2e58593          	addi	a1,a1,-722 # 800096b8 <syscalls+0x2e0>
    80004992:	fb040513          	addi	a0,s0,-80
    80004996:	9782                	jalr	a5
    80004998:	14050963          	beqz	a0,80004aea <sys_unlink+0x1ac>
    8000499c:	01893783          	ld	a5,24(s2)
    800049a0:	67bc                	ld	a5,72(a5)
    800049a2:	00005597          	auipc	a1,0x5
    800049a6:	d1e58593          	addi	a1,a1,-738 # 800096c0 <syscalls+0x2e8>
    800049aa:	fb040513          	addi	a0,s0,-80
    800049ae:	9782                	jalr	a5
    800049b0:	12050d63          	beqz	a0,80004aea <sys_unlink+0x1ac>
	if((ip = dp->inode_ops->dir_lookup(dp, name, &off)) == NULL)
    800049b4:	01093783          	ld	a5,16(s2)
    800049b8:	639c                	ld	a5,0(a5)
    800049ba:	f2c40613          	addi	a2,s0,-212
    800049be:	fb040593          	addi	a1,s0,-80
    800049c2:	854a                	mv	a0,s2
    800049c4:	9782                	jalr	a5
    800049c6:	84aa                	mv	s1,a0
    800049c8:	12050163          	beqz	a0,80004aea <sys_unlink+0x1ac>
	ip->inode_ops->ilock(ip);
    800049cc:	691c                	ld	a5,16(a0)
    800049ce:	739c                	ld	a5,32(a5)
    800049d0:	9782                	jalr	a5
	if(ip->nlink < 1)
    800049d2:	02e49783          	lh	a5,46(s1)
    800049d6:	08f05663          	blez	a5,80004a62 <sys_unlink+0x124>
	if(ip->type == T_DIR && !isdirempty(ip)) {
    800049da:	02849703          	lh	a4,40(s1)
    800049de:	4785                	li	a5,1
    800049e0:	08f70963          	beq	a4,a5,80004a72 <sys_unlink+0x134>
	kmemset(&de, 0, sizeof(de));
    800049e4:	4641                	li	a2,16
    800049e6:	4581                	li	a1,0
    800049e8:	fc040513          	addi	a0,s0,-64
    800049ec:	ffffc097          	auipc	ra,0xffffc
    800049f0:	408080e7          	jalr	1032(ra) # 80000df4 <kmemset>
	if(dp->inode_ops->writei(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    800049f4:	01093783          	ld	a5,16(s2)
    800049f8:	6fbc                	ld	a5,88(a5)
    800049fa:	4741                	li	a4,16
    800049fc:	f2c42683          	lw	a3,-212(s0)
    80004a00:	fc040613          	addi	a2,s0,-64
    80004a04:	4581                	li	a1,0
    80004a06:	854a                	mv	a0,s2
    80004a08:	9782                	jalr	a5
    80004a0a:	47c1                	li	a5,16
    80004a0c:	0af51663          	bne	a0,a5,80004ab8 <sys_unlink+0x17a>
	if(ip->type == T_DIR) {
    80004a10:	02849703          	lh	a4,40(s1)
    80004a14:	4785                	li	a5,1
    80004a16:	0af70963          	beq	a4,a5,80004ac8 <sys_unlink+0x18a>
	dp->inode_ops->iunlockput(dp);
    80004a1a:	01093783          	ld	a5,16(s2)
    80004a1e:	7f9c                	ld	a5,56(a5)
    80004a20:	854a                	mv	a0,s2
    80004a22:	9782                	jalr	a5
	ip->nlink--;
    80004a24:	02e4d783          	lhu	a5,46(s1)
    80004a28:	37fd                	addiw	a5,a5,-1
    80004a2a:	02f49723          	sh	a5,46(s1)
	ip->inode_ops->iupdate(ip);
    80004a2e:	689c                	ld	a5,16(s1)
    80004a30:	679c                	ld	a5,8(a5)
    80004a32:	8526                	mv	a0,s1
    80004a34:	9782                	jalr	a5
	ip->inode_ops->iunlockput(ip);
    80004a36:	689c                	ld	a5,16(s1)
    80004a38:	7f9c                	ld	a5,56(a5)
    80004a3a:	8526                	mv	a0,s1
    80004a3c:	9782                	jalr	a5
	end_op();
    80004a3e:	fffff097          	auipc	ra,0xfffff
    80004a42:	bc2080e7          	jalr	-1086(ra) # 80003600 <end_op>
	return 0;
    80004a46:	4501                	li	a0,0
}
    80004a48:	70ae                	ld	ra,232(sp)
    80004a4a:	740e                	ld	s0,224(sp)
    80004a4c:	64ee                	ld	s1,216(sp)
    80004a4e:	694e                	ld	s2,208(sp)
    80004a50:	69ae                	ld	s3,200(sp)
    80004a52:	616d                	addi	sp,sp,240
    80004a54:	8082                	ret
		end_op();
    80004a56:	fffff097          	auipc	ra,0xfffff
    80004a5a:	baa080e7          	jalr	-1110(ra) # 80003600 <end_op>
		return -1;
    80004a5e:	557d                	li	a0,-1
    80004a60:	b7e5                	j	80004a48 <sys_unlink+0x10a>
		panic("unlink: nlink < 1");
    80004a62:	00005517          	auipc	a0,0x5
    80004a66:	c8e50513          	addi	a0,a0,-882 # 800096f0 <syscalls+0x318>
    80004a6a:	ffffc097          	auipc	ra,0xffffc
    80004a6e:	bf8080e7          	jalr	-1032(ra) # 80000662 <panic>
	for(off = 2 * sizeof(de); off < dp->size; off += sizeof(de)) {
    80004a72:	5898                	lw	a4,48(s1)
    80004a74:	02000793          	li	a5,32
    80004a78:	f6e7f6e3          	bgeu	a5,a4,800049e4 <sys_unlink+0xa6>
    80004a7c:	02000993          	li	s3,32
		if(dp->inode_ops->readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de)) {
    80004a80:	689c                	ld	a5,16(s1)
    80004a82:	6bbc                	ld	a5,80(a5)
    80004a84:	4741                	li	a4,16
    80004a86:	86ce                	mv	a3,s3
    80004a88:	f1840613          	addi	a2,s0,-232
    80004a8c:	4581                	li	a1,0
    80004a8e:	8526                	mv	a0,s1
    80004a90:	9782                	jalr	a5
    80004a92:	47c1                	li	a5,16
    80004a94:	00f51a63          	bne	a0,a5,80004aa8 <sys_unlink+0x16a>
		if(de.inum != 0) {
    80004a98:	f1845783          	lhu	a5,-232(s0)
    80004a9c:	e3b9                	bnez	a5,80004ae2 <sys_unlink+0x1a4>
	for(off = 2 * sizeof(de); off < dp->size; off += sizeof(de)) {
    80004a9e:	29c1                	addiw	s3,s3,16
    80004aa0:	589c                	lw	a5,48(s1)
    80004aa2:	fcf9efe3          	bltu	s3,a5,80004a80 <sys_unlink+0x142>
    80004aa6:	bf3d                	j	800049e4 <sys_unlink+0xa6>
			panic("isdirempty: readi");
    80004aa8:	00005517          	auipc	a0,0x5
    80004aac:	c6050513          	addi	a0,a0,-928 # 80009708 <syscalls+0x330>
    80004ab0:	ffffc097          	auipc	ra,0xffffc
    80004ab4:	bb2080e7          	jalr	-1102(ra) # 80000662 <panic>
		panic("unlink: writei");
    80004ab8:	00005517          	auipc	a0,0x5
    80004abc:	c6850513          	addi	a0,a0,-920 # 80009720 <syscalls+0x348>
    80004ac0:	ffffc097          	auipc	ra,0xffffc
    80004ac4:	ba2080e7          	jalr	-1118(ra) # 80000662 <panic>
		dp->nlink--;
    80004ac8:	02e95783          	lhu	a5,46(s2)
    80004acc:	37fd                	addiw	a5,a5,-1
    80004ace:	02f91723          	sh	a5,46(s2)
		dp->inode_ops->iupdate(dp);
    80004ad2:	01093783          	ld	a5,16(s2)
    80004ad6:	679c                	ld	a5,8(a5)
    80004ad8:	854a                	mv	a0,s2
    80004ada:	9782                	jalr	a5
    80004adc:	bf3d                	j	80004a1a <sys_unlink+0xdc>
		return -1;
    80004ade:	557d                	li	a0,-1
    80004ae0:	b7a5                	j	80004a48 <sys_unlink+0x10a>
		ip->inode_ops->iunlockput(ip);
    80004ae2:	689c                	ld	a5,16(s1)
    80004ae4:	7f9c                	ld	a5,56(a5)
    80004ae6:	8526                	mv	a0,s1
    80004ae8:	9782                	jalr	a5
	dp->inode_ops->iunlockput(dp);
    80004aea:	01093783          	ld	a5,16(s2)
    80004aee:	7f9c                	ld	a5,56(a5)
    80004af0:	854a                	mv	a0,s2
    80004af2:	9782                	jalr	a5
	end_op();
    80004af4:	fffff097          	auipc	ra,0xfffff
    80004af8:	b0c080e7          	jalr	-1268(ra) # 80003600 <end_op>
	return -1;
    80004afc:	557d                	li	a0,-1
    80004afe:	b7a9                	j	80004a48 <sys_unlink+0x10a>

0000000080004b00 <sys_open>:

uint64 sys_open(void)
{
    80004b00:	7131                	addi	sp,sp,-192
    80004b02:	fd06                	sd	ra,184(sp)
    80004b04:	f922                	sd	s0,176(sp)
    80004b06:	f526                	sd	s1,168(sp)
    80004b08:	f14a                	sd	s2,160(sp)
    80004b0a:	ed4e                	sd	s3,152(sp)
    80004b0c:	0180                	addi	s0,sp,192
	int fd, omode;
	struct file * f;
	struct inode * ip;
	int n;

	if((n = argstr(0, path, MAXPATH)) < 0 || argint(1, &omode) < 0)
    80004b0e:	08000613          	li	a2,128
    80004b12:	f5040593          	addi	a1,s0,-176
    80004b16:	4501                	li	a0,0
    80004b18:	ffffe097          	auipc	ra,0xffffe
    80004b1c:	fc8080e7          	jalr	-56(ra) # 80002ae0 <argstr>
		return -1;
    80004b20:	597d                	li	s2,-1
	if((n = argstr(0, path, MAXPATH)) < 0 || argint(1, &omode) < 0)
    80004b22:	0a054f63          	bltz	a0,80004be0 <sys_open+0xe0>
    80004b26:	f4c40593          	addi	a1,s0,-180
    80004b2a:	4505                	li	a0,1
    80004b2c:	ffffe097          	auipc	ra,0xffffe
    80004b30:	f70080e7          	jalr	-144(ra) # 80002a9c <argint>
    80004b34:	0a054663          	bltz	a0,80004be0 <sys_open+0xe0>
	begin_op();
    80004b38:	fffff097          	auipc	ra,0xfffff
    80004b3c:	a4a080e7          	jalr	-1462(ra) # 80003582 <begin_op>

	if(omode & O_CREATE) {
    80004b40:	f4c42783          	lw	a5,-180(s0)
    80004b44:	2007f793          	andi	a5,a5,512
    80004b48:	cbcd                	beqz	a5,80004bfa <sys_open+0xfa>
		if((ip = create(path, T_FILE, 0, 0)) == NULL) {
    80004b4a:	4681                	li	a3,0
    80004b4c:	4601                	li	a2,0
    80004b4e:	4589                	li	a1,2
    80004b50:	f5040513          	addi	a0,s0,-176
    80004b54:	00000097          	auipc	ra,0x0
    80004b58:	994080e7          	jalr	-1644(ra) # 800044e8 <create>
    80004b5c:	84aa                	mv	s1,a0
    80004b5e:	c949                	beqz	a0,80004bf0 <sys_open+0xf0>

			return -1;
		}
	}

	if(ip->type == T_DEVICE && (ip->major < 0 || ip->major >= NDEV)) {
    80004b60:	02849703          	lh	a4,40(s1)
    80004b64:	478d                	li	a5,3
    80004b66:	00f71763          	bne	a4,a5,80004b74 <sys_open+0x74>
    80004b6a:	02a4d703          	lhu	a4,42(s1)
    80004b6e:	47a5                	li	a5,9
    80004b70:	0ce7e863          	bltu	a5,a4,80004c40 <sys_open+0x140>
		end_op();

		return -1;
	}

	if((f = filealloc()) == NULL || (fd = fdalloc(f)) < 0) {
    80004b74:	fffff097          	auipc	ra,0xfffff
    80004b78:	e26080e7          	jalr	-474(ra) # 8000399a <filealloc>
    80004b7c:	89aa                	mv	s3,a0
    80004b7e:	cd65                	beqz	a0,80004c76 <sys_open+0x176>
    80004b80:	00000097          	auipc	ra,0x0
    80004b84:	926080e7          	jalr	-1754(ra) # 800044a6 <fdalloc>
    80004b88:	892a                	mv	s2,a0
    80004b8a:	0e054163          	bltz	a0,80004c6c <sys_open+0x16c>
		end_op();

		return -1;
	}

	if(ip->type == T_DEVICE) {
    80004b8e:	02849703          	lh	a4,40(s1)
    80004b92:	478d                	li	a5,3
    80004b94:	0cf70063          	beq	a4,a5,80004c54 <sys_open+0x154>
		f->type = FD_DEVICE;
		f->major = ip->major;
	} else {
		f->type = FD_INODE;
    80004b98:	4789                	li	a5,2
    80004b9a:	00f9a023          	sw	a5,0(s3)
		f->off = 0;
    80004b9e:	0209a023          	sw	zero,32(s3)
	}

	f->ip = ip;
    80004ba2:	0099bc23          	sd	s1,24(s3)
	f->readable = !(omode & O_WRONLY);
    80004ba6:	f4c42783          	lw	a5,-180(s0)
    80004baa:	0017c713          	xori	a4,a5,1
    80004bae:	8b05                	andi	a4,a4,1
    80004bb0:	00e98423          	sb	a4,8(s3)
	f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
    80004bb4:	0037f713          	andi	a4,a5,3
    80004bb8:	00e03733          	snez	a4,a4
    80004bbc:	00e984a3          	sb	a4,9(s3)

	if((omode & O_TRUNC) && ip->type == T_FILE) {
    80004bc0:	4007f793          	andi	a5,a5,1024
    80004bc4:	c791                	beqz	a5,80004bd0 <sys_open+0xd0>
    80004bc6:	02849703          	lh	a4,40(s1)
    80004bca:	4789                	li	a5,2
    80004bcc:	08f70b63          	beq	a4,a5,80004c62 <sys_open+0x162>
		ip->inode_ops->itrunc(ip);
	}

	ip->inode_ops->iunlock(ip);
    80004bd0:	689c                	ld	a5,16(s1)
    80004bd2:	7b9c                	ld	a5,48(a5)
    80004bd4:	8526                	mv	a0,s1
    80004bd6:	9782                	jalr	a5
	end_op();
    80004bd8:	fffff097          	auipc	ra,0xfffff
    80004bdc:	a28080e7          	jalr	-1496(ra) # 80003600 <end_op>

	return fd;
}
    80004be0:	854a                	mv	a0,s2
    80004be2:	70ea                	ld	ra,184(sp)
    80004be4:	744a                	ld	s0,176(sp)
    80004be6:	74aa                	ld	s1,168(sp)
    80004be8:	790a                	ld	s2,160(sp)
    80004bea:	69ea                	ld	s3,152(sp)
    80004bec:	6129                	addi	sp,sp,192
    80004bee:	8082                	ret
			end_op();
    80004bf0:	fffff097          	auipc	ra,0xfffff
    80004bf4:	a10080e7          	jalr	-1520(ra) # 80003600 <end_op>
			return -1;
    80004bf8:	b7e5                	j	80004be0 <sys_open+0xe0>
		if((ip = namei(path)) == NULL) {
    80004bfa:	f5040513          	addi	a0,s0,-176
    80004bfe:	ffffe097          	auipc	ra,0xffffe
    80004c02:	74c080e7          	jalr	1868(ra) # 8000334a <namei>
    80004c06:	84aa                	mv	s1,a0
    80004c08:	c515                	beqz	a0,80004c34 <sys_open+0x134>
		ip->inode_ops->ilock(ip);
    80004c0a:	691c                	ld	a5,16(a0)
    80004c0c:	739c                	ld	a5,32(a5)
    80004c0e:	9782                	jalr	a5
		if(ip->type == T_DIR && omode != O_RDONLY) {
    80004c10:	02849703          	lh	a4,40(s1)
    80004c14:	4785                	li	a5,1
    80004c16:	f4f715e3          	bne	a4,a5,80004b60 <sys_open+0x60>
    80004c1a:	f4c42783          	lw	a5,-180(s0)
    80004c1e:	dbb9                	beqz	a5,80004b74 <sys_open+0x74>
			ip->inode_ops->iunlockput(ip);
    80004c20:	689c                	ld	a5,16(s1)
    80004c22:	7f9c                	ld	a5,56(a5)
    80004c24:	8526                	mv	a0,s1
    80004c26:	9782                	jalr	a5
			end_op();
    80004c28:	fffff097          	auipc	ra,0xfffff
    80004c2c:	9d8080e7          	jalr	-1576(ra) # 80003600 <end_op>
			return -1;
    80004c30:	597d                	li	s2,-1
    80004c32:	b77d                	j	80004be0 <sys_open+0xe0>
			end_op();
    80004c34:	fffff097          	auipc	ra,0xfffff
    80004c38:	9cc080e7          	jalr	-1588(ra) # 80003600 <end_op>
			return -1;
    80004c3c:	597d                	li	s2,-1
    80004c3e:	b74d                	j	80004be0 <sys_open+0xe0>
		ip->inode_ops->iunlockput(ip);
    80004c40:	689c                	ld	a5,16(s1)
    80004c42:	7f9c                	ld	a5,56(a5)
    80004c44:	8526                	mv	a0,s1
    80004c46:	9782                	jalr	a5
		end_op();
    80004c48:	fffff097          	auipc	ra,0xfffff
    80004c4c:	9b8080e7          	jalr	-1608(ra) # 80003600 <end_op>
		return -1;
    80004c50:	597d                	li	s2,-1
    80004c52:	b779                	j	80004be0 <sys_open+0xe0>
		f->type = FD_DEVICE;
    80004c54:	00f9a023          	sw	a5,0(s3)
		f->major = ip->major;
    80004c58:	02a49783          	lh	a5,42(s1)
    80004c5c:	02f99223          	sh	a5,36(s3)
    80004c60:	b789                	j	80004ba2 <sys_open+0xa2>
		ip->inode_ops->itrunc(ip);
    80004c62:	689c                	ld	a5,16(s1)
    80004c64:	6b9c                	ld	a5,16(a5)
    80004c66:	8526                	mv	a0,s1
    80004c68:	9782                	jalr	a5
    80004c6a:	b79d                	j	80004bd0 <sys_open+0xd0>
			fileclose(f);
    80004c6c:	854e                	mv	a0,s3
    80004c6e:	fffff097          	auipc	ra,0xfffff
    80004c72:	de8080e7          	jalr	-536(ra) # 80003a56 <fileclose>
		ip->inode_ops->iunlockput(ip);
    80004c76:	689c                	ld	a5,16(s1)
    80004c78:	7f9c                	ld	a5,56(a5)
    80004c7a:	8526                	mv	a0,s1
    80004c7c:	9782                	jalr	a5
		end_op();
    80004c7e:	fffff097          	auipc	ra,0xfffff
    80004c82:	982080e7          	jalr	-1662(ra) # 80003600 <end_op>
		return -1;
    80004c86:	597d                	li	s2,-1
    80004c88:	bfa1                	j	80004be0 <sys_open+0xe0>

0000000080004c8a <sys_mkdir>:

uint64 sys_mkdir(void)
{
    80004c8a:	7175                	addi	sp,sp,-144
    80004c8c:	e506                	sd	ra,136(sp)
    80004c8e:	e122                	sd	s0,128(sp)
    80004c90:	0900                	addi	s0,sp,144
	char path[MAXPATH];
	struct inode * ip;

	begin_op();
    80004c92:	fffff097          	auipc	ra,0xfffff
    80004c96:	8f0080e7          	jalr	-1808(ra) # 80003582 <begin_op>

	if(argstr(0, path, MAXPATH) < 0 || (ip = create(path, T_DIR, 0, 0)) == NULL) {
    80004c9a:	08000613          	li	a2,128
    80004c9e:	f7040593          	addi	a1,s0,-144
    80004ca2:	4501                	li	a0,0
    80004ca4:	ffffe097          	auipc	ra,0xffffe
    80004ca8:	e3c080e7          	jalr	-452(ra) # 80002ae0 <argstr>
    80004cac:	02054863          	bltz	a0,80004cdc <sys_mkdir+0x52>
    80004cb0:	4681                	li	a3,0
    80004cb2:	4601                	li	a2,0
    80004cb4:	4585                	li	a1,1
    80004cb6:	f7040513          	addi	a0,s0,-144
    80004cba:	00000097          	auipc	ra,0x0
    80004cbe:	82e080e7          	jalr	-2002(ra) # 800044e8 <create>
    80004cc2:	cd09                	beqz	a0,80004cdc <sys_mkdir+0x52>
		end_op();

		return -1;
	}

	ip->inode_ops->iunlockput(ip);
    80004cc4:	691c                	ld	a5,16(a0)
    80004cc6:	7f9c                	ld	a5,56(a5)
    80004cc8:	9782                	jalr	a5
	end_op();
    80004cca:	fffff097          	auipc	ra,0xfffff
    80004cce:	936080e7          	jalr	-1738(ra) # 80003600 <end_op>

	return 0;
    80004cd2:	4501                	li	a0,0
}
    80004cd4:	60aa                	ld	ra,136(sp)
    80004cd6:	640a                	ld	s0,128(sp)
    80004cd8:	6149                	addi	sp,sp,144
    80004cda:	8082                	ret
		end_op();
    80004cdc:	fffff097          	auipc	ra,0xfffff
    80004ce0:	924080e7          	jalr	-1756(ra) # 80003600 <end_op>
		return -1;
    80004ce4:	557d                	li	a0,-1
    80004ce6:	b7fd                	j	80004cd4 <sys_mkdir+0x4a>

0000000080004ce8 <sys_mknod>:

uint64 sys_mknod(void)
{
    80004ce8:	7135                	addi	sp,sp,-160
    80004cea:	ed06                	sd	ra,152(sp)
    80004cec:	e922                	sd	s0,144(sp)
    80004cee:	1100                	addi	s0,sp,160
	struct inode * ip;
	char path[MAXPATH];
	int major, minor;

	begin_op();
    80004cf0:	fffff097          	auipc	ra,0xfffff
    80004cf4:	892080e7          	jalr	-1902(ra) # 80003582 <begin_op>

	if((argstr(0, path, MAXPATH)) < 0 || argint(1, &major) < 0 || argint(2, &minor) < 0 || (ip = create(path, T_DEVICE, major, minor)) == NULL) {
    80004cf8:	08000613          	li	a2,128
    80004cfc:	f7040593          	addi	a1,s0,-144
    80004d00:	4501                	li	a0,0
    80004d02:	ffffe097          	auipc	ra,0xffffe
    80004d06:	dde080e7          	jalr	-546(ra) # 80002ae0 <argstr>
    80004d0a:	04054963          	bltz	a0,80004d5c <sys_mknod+0x74>
    80004d0e:	f6c40593          	addi	a1,s0,-148
    80004d12:	4505                	li	a0,1
    80004d14:	ffffe097          	auipc	ra,0xffffe
    80004d18:	d88080e7          	jalr	-632(ra) # 80002a9c <argint>
    80004d1c:	04054063          	bltz	a0,80004d5c <sys_mknod+0x74>
    80004d20:	f6840593          	addi	a1,s0,-152
    80004d24:	4509                	li	a0,2
    80004d26:	ffffe097          	auipc	ra,0xffffe
    80004d2a:	d76080e7          	jalr	-650(ra) # 80002a9c <argint>
    80004d2e:	02054763          	bltz	a0,80004d5c <sys_mknod+0x74>
    80004d32:	f6841683          	lh	a3,-152(s0)
    80004d36:	f6c41603          	lh	a2,-148(s0)
    80004d3a:	458d                	li	a1,3
    80004d3c:	f7040513          	addi	a0,s0,-144
    80004d40:	fffff097          	auipc	ra,0xfffff
    80004d44:	7a8080e7          	jalr	1960(ra) # 800044e8 <create>
    80004d48:	c911                	beqz	a0,80004d5c <sys_mknod+0x74>
		end_op();

		return -1;
	}

	ip->inode_ops->iunlockput(ip);
    80004d4a:	691c                	ld	a5,16(a0)
    80004d4c:	7f9c                	ld	a5,56(a5)
    80004d4e:	9782                	jalr	a5
	end_op();
    80004d50:	fffff097          	auipc	ra,0xfffff
    80004d54:	8b0080e7          	jalr	-1872(ra) # 80003600 <end_op>

	return 0;
    80004d58:	4501                	li	a0,0
    80004d5a:	a031                	j	80004d66 <sys_mknod+0x7e>
		end_op();
    80004d5c:	fffff097          	auipc	ra,0xfffff
    80004d60:	8a4080e7          	jalr	-1884(ra) # 80003600 <end_op>
		return -1;
    80004d64:	557d                	li	a0,-1
}
    80004d66:	60ea                	ld	ra,152(sp)
    80004d68:	644a                	ld	s0,144(sp)
    80004d6a:	610d                	addi	sp,sp,160
    80004d6c:	8082                	ret

0000000080004d6e <sys_chdir>:

uint64 sys_chdir(void)
{
    80004d6e:	7135                	addi	sp,sp,-160
    80004d70:	ed06                	sd	ra,152(sp)
    80004d72:	e922                	sd	s0,144(sp)
    80004d74:	e526                	sd	s1,136(sp)
    80004d76:	e14a                	sd	s2,128(sp)
    80004d78:	1100                	addi	s0,sp,160
	char path[MAXPATH];
	struct inode * ip;
	struct proc * p = myproc();
    80004d7a:	ffffd097          	auipc	ra,0xffffd
    80004d7e:	d6a080e7          	jalr	-662(ra) # 80001ae4 <myproc>
    80004d82:	892a                	mv	s2,a0
	
	begin_op();
    80004d84:	ffffe097          	auipc	ra,0xffffe
    80004d88:	7fe080e7          	jalr	2046(ra) # 80003582 <begin_op>

	if(argstr(0, path, MAXPATH) < 0 || (ip = namei(path)) == NULL) {
    80004d8c:	08000613          	li	a2,128
    80004d90:	f6040593          	addi	a1,s0,-160
    80004d94:	4501                	li	a0,0
    80004d96:	ffffe097          	auipc	ra,0xffffe
    80004d9a:	d4a080e7          	jalr	-694(ra) # 80002ae0 <argstr>
    80004d9e:	04054863          	bltz	a0,80004dee <sys_chdir+0x80>
    80004da2:	f6040513          	addi	a0,s0,-160
    80004da6:	ffffe097          	auipc	ra,0xffffe
    80004daa:	5a4080e7          	jalr	1444(ra) # 8000334a <namei>
    80004dae:	84aa                	mv	s1,a0
    80004db0:	cd1d                	beqz	a0,80004dee <sys_chdir+0x80>
		end_op();

		return -1;
	}

	ip->inode_ops->ilock(ip);
    80004db2:	691c                	ld	a5,16(a0)
    80004db4:	739c                	ld	a5,32(a5)
    80004db6:	9782                	jalr	a5

	if(ip->type != T_DIR) {
    80004db8:	02849703          	lh	a4,40(s1)
    80004dbc:	4785                	li	a5,1
    80004dbe:	02f71e63          	bne	a4,a5,80004dfa <sys_chdir+0x8c>
		end_op();

		return -1;
	}

	ip->inode_ops->iunlock(ip);
    80004dc2:	689c                	ld	a5,16(s1)
    80004dc4:	7b9c                	ld	a5,48(a5)
    80004dc6:	8526                	mv	a0,s1
    80004dc8:	9782                	jalr	a5
	ip->inode_ops->iput(p->cwd);
    80004dca:	689c                	ld	a5,16(s1)
    80004dcc:	779c                	ld	a5,40(a5)
    80004dce:	15093503          	ld	a0,336(s2)
    80004dd2:	9782                	jalr	a5
	end_op();
    80004dd4:	fffff097          	auipc	ra,0xfffff
    80004dd8:	82c080e7          	jalr	-2004(ra) # 80003600 <end_op>

	p->cwd = ip;
    80004ddc:	14993823          	sd	s1,336(s2)

	return 0;
    80004de0:	4501                	li	a0,0
}
    80004de2:	60ea                	ld	ra,152(sp)
    80004de4:	644a                	ld	s0,144(sp)
    80004de6:	64aa                	ld	s1,136(sp)
    80004de8:	690a                	ld	s2,128(sp)
    80004dea:	610d                	addi	sp,sp,160
    80004dec:	8082                	ret
		end_op();
    80004dee:	fffff097          	auipc	ra,0xfffff
    80004df2:	812080e7          	jalr	-2030(ra) # 80003600 <end_op>
		return -1;
    80004df6:	557d                	li	a0,-1
    80004df8:	b7ed                	j	80004de2 <sys_chdir+0x74>
		ip->inode_ops->iunlockput(ip);
    80004dfa:	689c                	ld	a5,16(s1)
    80004dfc:	7f9c                	ld	a5,56(a5)
    80004dfe:	8526                	mv	a0,s1
    80004e00:	9782                	jalr	a5
		end_op();
    80004e02:	ffffe097          	auipc	ra,0xffffe
    80004e06:	7fe080e7          	jalr	2046(ra) # 80003600 <end_op>
		return -1;
    80004e0a:	557d                	li	a0,-1
    80004e0c:	bfd9                	j	80004de2 <sys_chdir+0x74>

0000000080004e0e <sys_exec>:

uint64 sys_exec(void)
{
    80004e0e:	7145                	addi	sp,sp,-464
    80004e10:	e786                	sd	ra,456(sp)
    80004e12:	e3a2                	sd	s0,448(sp)
    80004e14:	ff26                	sd	s1,440(sp)
    80004e16:	fb4a                	sd	s2,432(sp)
    80004e18:	f74e                	sd	s3,424(sp)
    80004e1a:	f352                	sd	s4,416(sp)
    80004e1c:	ef56                	sd	s5,408(sp)
    80004e1e:	0b80                	addi	s0,sp,464
	char path[MAXPATH], * argv[MAXARG];
	int i;
	uint64 uargv, uarg;

	if(argstr(0, path, MAXPATH) < 0 || argaddr(1, &uargv) < 0) {
    80004e20:	08000613          	li	a2,128
    80004e24:	f4040593          	addi	a1,s0,-192
    80004e28:	4501                	li	a0,0
    80004e2a:	ffffe097          	auipc	ra,0xffffe
    80004e2e:	cb6080e7          	jalr	-842(ra) # 80002ae0 <argstr>
		return -1;
    80004e32:	597d                	li	s2,-1
	if(argstr(0, path, MAXPATH) < 0 || argaddr(1, &uargv) < 0) {
    80004e34:	0c054b63          	bltz	a0,80004f0a <sys_exec+0xfc>
    80004e38:	e3840593          	addi	a1,s0,-456
    80004e3c:	4505                	li	a0,1
    80004e3e:	ffffe097          	auipc	ra,0xffffe
    80004e42:	c80080e7          	jalr	-896(ra) # 80002abe <argaddr>
    80004e46:	0c054263          	bltz	a0,80004f0a <sys_exec+0xfc>
	}

	kmemset(argv, 0, sizeof(argv));
    80004e4a:	10000613          	li	a2,256
    80004e4e:	4581                	li	a1,0
    80004e50:	e4040513          	addi	a0,s0,-448
    80004e54:	ffffc097          	auipc	ra,0xffffc
    80004e58:	fa0080e7          	jalr	-96(ra) # 80000df4 <kmemset>

	for(i = 0;; i++) {
		if(i >= NELEM(argv)) {
    80004e5c:	e4040493          	addi	s1,s0,-448
	kmemset(argv, 0, sizeof(argv));
    80004e60:	89a6                	mv	s3,s1
    80004e62:	4901                	li	s2,0
		if(i >= NELEM(argv)) {
    80004e64:	02000a13          	li	s4,32
    80004e68:	00090a9b          	sext.w	s5,s2
			goto bad;
		}

		if(fetchaddr(uargv + sizeof(uint64) * i, (uint64 *) &uarg) < 0) {
    80004e6c:	00391513          	slli	a0,s2,0x3
    80004e70:	e3040593          	addi	a1,s0,-464
    80004e74:	e3843783          	ld	a5,-456(s0)
    80004e78:	953e                	add	a0,a0,a5
    80004e7a:	ffffe097          	auipc	ra,0xffffe
    80004e7e:	b88080e7          	jalr	-1144(ra) # 80002a02 <fetchaddr>
    80004e82:	02054a63          	bltz	a0,80004eb6 <sys_exec+0xa8>
			goto bad;
		}

		if(uarg == 0) {
    80004e86:	e3043783          	ld	a5,-464(s0)
    80004e8a:	c3b9                	beqz	a5,80004ed0 <sys_exec+0xc2>
			argv[i] = 0;
			break;
		}

		argv[i] = kalloc();
    80004e8c:	ffffc097          	auipc	ra,0xffffc
    80004e90:	d7c080e7          	jalr	-644(ra) # 80000c08 <kalloc>
    80004e94:	85aa                	mv	a1,a0
    80004e96:	00a9b023          	sd	a0,0(s3)

		if(argv[i] == NULL) {
    80004e9a:	cd11                	beqz	a0,80004eb6 <sys_exec+0xa8>
			goto bad;
		}

		if(fetchstr(uarg, argv[i], PGSIZE) < 0) {
    80004e9c:	6605                	lui	a2,0x1
    80004e9e:	e3043503          	ld	a0,-464(s0)
    80004ea2:	ffffe097          	auipc	ra,0xffffe
    80004ea6:	bb2080e7          	jalr	-1102(ra) # 80002a54 <fetchstr>
    80004eaa:	00054663          	bltz	a0,80004eb6 <sys_exec+0xa8>
		if(i >= NELEM(argv)) {
    80004eae:	0905                	addi	s2,s2,1
    80004eb0:	09a1                	addi	s3,s3,8
    80004eb2:	fb491be3          	bne	s2,s4,80004e68 <sys_exec+0x5a>
	}

	return ret;

 bad:
	for(i = 0; i < NELEM(argv) && argv[i] != NULL; i++) {
    80004eb6:	f4040913          	addi	s2,s0,-192
    80004eba:	6088                	ld	a0,0(s1)
    80004ebc:	c531                	beqz	a0,80004f08 <sys_exec+0xfa>
		kfree(argv[i]);
    80004ebe:	ffffc097          	auipc	ra,0xffffc
    80004ec2:	c4c080e7          	jalr	-948(ra) # 80000b0a <kfree>
	for(i = 0; i < NELEM(argv) && argv[i] != NULL; i++) {
    80004ec6:	04a1                	addi	s1,s1,8
    80004ec8:	ff2499e3          	bne	s1,s2,80004eba <sys_exec+0xac>
	}

	return -1;
    80004ecc:	597d                	li	s2,-1
    80004ece:	a835                	j	80004f0a <sys_exec+0xfc>
			argv[i] = 0;
    80004ed0:	0a8e                	slli	s5,s5,0x3
    80004ed2:	fc0a8793          	addi	a5,s5,-64
    80004ed6:	00878ab3          	add	s5,a5,s0
    80004eda:	e80ab023          	sd	zero,-384(s5)
	int ret = exec(path, argv);
    80004ede:	e4040593          	addi	a1,s0,-448
    80004ee2:	f4040513          	addi	a0,s0,-192
    80004ee6:	fffff097          	auipc	ra,0xfffff
    80004eea:	1b2080e7          	jalr	434(ra) # 80004098 <exec>
    80004eee:	892a                	mv	s2,a0
	for(i = 0; i < NELEM(argv) && argv[i] != NULL; i++) {
    80004ef0:	f4040993          	addi	s3,s0,-192
    80004ef4:	6088                	ld	a0,0(s1)
    80004ef6:	c911                	beqz	a0,80004f0a <sys_exec+0xfc>
		kfree(argv[i]);
    80004ef8:	ffffc097          	auipc	ra,0xffffc
    80004efc:	c12080e7          	jalr	-1006(ra) # 80000b0a <kfree>
	for(i = 0; i < NELEM(argv) && argv[i] != NULL; i++) {
    80004f00:	04a1                	addi	s1,s1,8
    80004f02:	ff3499e3          	bne	s1,s3,80004ef4 <sys_exec+0xe6>
    80004f06:	a011                	j	80004f0a <sys_exec+0xfc>
	return -1;
    80004f08:	597d                	li	s2,-1
}
    80004f0a:	854a                	mv	a0,s2
    80004f0c:	60be                	ld	ra,456(sp)
    80004f0e:	641e                	ld	s0,448(sp)
    80004f10:	74fa                	ld	s1,440(sp)
    80004f12:	795a                	ld	s2,432(sp)
    80004f14:	79ba                	ld	s3,424(sp)
    80004f16:	7a1a                	ld	s4,416(sp)
    80004f18:	6afa                	ld	s5,408(sp)
    80004f1a:	6179                	addi	sp,sp,464
    80004f1c:	8082                	ret

0000000080004f1e <sys_pipe>:

uint64 sys_pipe(void)
{
    80004f1e:	7139                	addi	sp,sp,-64
    80004f20:	fc06                	sd	ra,56(sp)
    80004f22:	f822                	sd	s0,48(sp)
    80004f24:	f426                	sd	s1,40(sp)
    80004f26:	0080                	addi	s0,sp,64
	uint64 fdarray; // user pointer to array of two integers
	struct file * rf, * wf;
	int fd0, fd1;
	struct proc * p = myproc();
    80004f28:	ffffd097          	auipc	ra,0xffffd
    80004f2c:	bbc080e7          	jalr	-1092(ra) # 80001ae4 <myproc>
    80004f30:	84aa                	mv	s1,a0

	if(argaddr(0, &fdarray) < 0)
    80004f32:	fd840593          	addi	a1,s0,-40
    80004f36:	4501                	li	a0,0
    80004f38:	ffffe097          	auipc	ra,0xffffe
    80004f3c:	b86080e7          	jalr	-1146(ra) # 80002abe <argaddr>
		return -1;
    80004f40:	57fd                	li	a5,-1
	if(argaddr(0, &fdarray) < 0)
    80004f42:	0e054063          	bltz	a0,80005022 <sys_pipe+0x104>

	if(pipealloc(&rf, &wf) < 0)
    80004f46:	fc840593          	addi	a1,s0,-56
    80004f4a:	fd040513          	addi	a0,s0,-48
    80004f4e:	fffff097          	auipc	ra,0xfffff
    80004f52:	e26080e7          	jalr	-474(ra) # 80003d74 <pipealloc>
		return -1;
    80004f56:	57fd                	li	a5,-1
	if(pipealloc(&rf, &wf) < 0)
    80004f58:	0c054563          	bltz	a0,80005022 <sys_pipe+0x104>

	fd0 = -1;
    80004f5c:	fcf42223          	sw	a5,-60(s0)

	if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0) {
    80004f60:	fd043503          	ld	a0,-48(s0)
    80004f64:	fffff097          	auipc	ra,0xfffff
    80004f68:	542080e7          	jalr	1346(ra) # 800044a6 <fdalloc>
    80004f6c:	fca42223          	sw	a0,-60(s0)
    80004f70:	08054c63          	bltz	a0,80005008 <sys_pipe+0xea>
    80004f74:	fc843503          	ld	a0,-56(s0)
    80004f78:	fffff097          	auipc	ra,0xfffff
    80004f7c:	52e080e7          	jalr	1326(ra) # 800044a6 <fdalloc>
    80004f80:	fca42023          	sw	a0,-64(s0)
    80004f84:	06054963          	bltz	a0,80004ff6 <sys_pipe+0xd8>
		fileclose(wf);
		
		return -1;
	}

	if(copyout(p->pagetable, fdarray, (char *) &fd0, sizeof(fd0)) < 0 || copyout(p->pagetable, fdarray + sizeof(fd0), (char *) &fd1, sizeof(fd1)) < 0) {
    80004f88:	4691                	li	a3,4
    80004f8a:	fc440613          	addi	a2,s0,-60
    80004f8e:	fd843583          	ld	a1,-40(s0)
    80004f92:	68a8                	ld	a0,80(s1)
    80004f94:	ffffd097          	auipc	ra,0xffffd
    80004f98:	814080e7          	jalr	-2028(ra) # 800017a8 <copyout>
    80004f9c:	02054063          	bltz	a0,80004fbc <sys_pipe+0x9e>
    80004fa0:	4691                	li	a3,4
    80004fa2:	fc040613          	addi	a2,s0,-64
    80004fa6:	fd843583          	ld	a1,-40(s0)
    80004faa:	0591                	addi	a1,a1,4
    80004fac:	68a8                	ld	a0,80(s1)
    80004fae:	ffffc097          	auipc	ra,0xffffc
    80004fb2:	7fa080e7          	jalr	2042(ra) # 800017a8 <copyout>
		fileclose(wf);

		return -1;
	}

	return 0;
    80004fb6:	4781                	li	a5,0
	if(copyout(p->pagetable, fdarray, (char *) &fd0, sizeof(fd0)) < 0 || copyout(p->pagetable, fdarray + sizeof(fd0), (char *) &fd1, sizeof(fd1)) < 0) {
    80004fb8:	06055563          	bgez	a0,80005022 <sys_pipe+0x104>
		p->ofile[fd0] = 0;
    80004fbc:	fc442783          	lw	a5,-60(s0)
    80004fc0:	07e9                	addi	a5,a5,26
    80004fc2:	078e                	slli	a5,a5,0x3
    80004fc4:	97a6                	add	a5,a5,s1
    80004fc6:	0007b023          	sd	zero,0(a5)
		p->ofile[fd1] = 0;
    80004fca:	fc042783          	lw	a5,-64(s0)
    80004fce:	07e9                	addi	a5,a5,26
    80004fd0:	078e                	slli	a5,a5,0x3
    80004fd2:	00f48533          	add	a0,s1,a5
    80004fd6:	00053023          	sd	zero,0(a0)
		fileclose(rf);
    80004fda:	fd043503          	ld	a0,-48(s0)
    80004fde:	fffff097          	auipc	ra,0xfffff
    80004fe2:	a78080e7          	jalr	-1416(ra) # 80003a56 <fileclose>
		fileclose(wf);
    80004fe6:	fc843503          	ld	a0,-56(s0)
    80004fea:	fffff097          	auipc	ra,0xfffff
    80004fee:	a6c080e7          	jalr	-1428(ra) # 80003a56 <fileclose>
		return -1;
    80004ff2:	57fd                	li	a5,-1
    80004ff4:	a03d                	j	80005022 <sys_pipe+0x104>
		if(fd0 >= 0) {
    80004ff6:	fc442783          	lw	a5,-60(s0)
    80004ffa:	0007c763          	bltz	a5,80005008 <sys_pipe+0xea>
			p->ofile[fd0] = 0;
    80004ffe:	07e9                	addi	a5,a5,26
    80005000:	078e                	slli	a5,a5,0x3
    80005002:	97a6                	add	a5,a5,s1
    80005004:	0007b023          	sd	zero,0(a5)
		fileclose(rf);
    80005008:	fd043503          	ld	a0,-48(s0)
    8000500c:	fffff097          	auipc	ra,0xfffff
    80005010:	a4a080e7          	jalr	-1462(ra) # 80003a56 <fileclose>
		fileclose(wf);
    80005014:	fc843503          	ld	a0,-56(s0)
    80005018:	fffff097          	auipc	ra,0xfffff
    8000501c:	a3e080e7          	jalr	-1474(ra) # 80003a56 <fileclose>
		return -1;
    80005020:	57fd                	li	a5,-1
}
    80005022:	853e                	mv	a0,a5
    80005024:	70e2                	ld	ra,56(sp)
    80005026:	7442                	ld	s0,48(sp)
    80005028:	74a2                	ld	s1,40(sp)
    8000502a:	6121                	addi	sp,sp,64
    8000502c:	8082                	ret

000000008000502e <plicinit>:
// the riscv Platform Level Interrupt Controller (PLIC).
//

void
plicinit(void)
{
    8000502e:	1141                	addi	sp,sp,-16
    80005030:	e422                	sd	s0,8(sp)
    80005032:	0800                	addi	s0,sp,16
  // set desired IRQ priorities non-zero (otherwise disabled).
  *(uint32*)(PLIC + UART0_IRQ*4) = 1;
    80005034:	0c0007b7          	lui	a5,0xc000
    80005038:	4705                	li	a4,1
    8000503a:	d798                	sw	a4,40(a5)
  *(uint32*)(PLIC + VIRTIO0_IRQ*4) = 1;
    8000503c:	c3d8                	sw	a4,4(a5)
}
    8000503e:	6422                	ld	s0,8(sp)
    80005040:	0141                	addi	sp,sp,16
    80005042:	8082                	ret

0000000080005044 <plicinithart>:

void
plicinithart(void)
{
    80005044:	1141                	addi	sp,sp,-16
    80005046:	e406                	sd	ra,8(sp)
    80005048:	e022                	sd	s0,0(sp)
    8000504a:	0800                	addi	s0,sp,16
  int hart = cpuid();
    8000504c:	ffffd097          	auipc	ra,0xffffd
    80005050:	a6c080e7          	jalr	-1428(ra) # 80001ab8 <cpuid>
  
  // set uart's enable bit for this hart's S-mode. 
  *(uint32*)PLIC_SENABLE(hart)= (1 << UART0_IRQ) | (1 << VIRTIO0_IRQ);
    80005054:	0085171b          	slliw	a4,a0,0x8
    80005058:	0c0027b7          	lui	a5,0xc002
    8000505c:	97ba                	add	a5,a5,a4
    8000505e:	40200713          	li	a4,1026
    80005062:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>

  // set this hart's S-mode priority threshold to 0.
  *(uint32*)PLIC_SPRIORITY(hart) = 0;
    80005066:	00d5151b          	slliw	a0,a0,0xd
    8000506a:	0c2017b7          	lui	a5,0xc201
    8000506e:	97aa                	add	a5,a5,a0
    80005070:	0007a023          	sw	zero,0(a5) # c201000 <_entry-0x73dff000>
}
    80005074:	60a2                	ld	ra,8(sp)
    80005076:	6402                	ld	s0,0(sp)
    80005078:	0141                	addi	sp,sp,16
    8000507a:	8082                	ret

000000008000507c <plic_claim>:

// ask the PLIC what interrupt we should serve.
int
plic_claim(void)
{
    8000507c:	1141                	addi	sp,sp,-16
    8000507e:	e406                	sd	ra,8(sp)
    80005080:	e022                	sd	s0,0(sp)
    80005082:	0800                	addi	s0,sp,16
  int hart = cpuid();
    80005084:	ffffd097          	auipc	ra,0xffffd
    80005088:	a34080e7          	jalr	-1484(ra) # 80001ab8 <cpuid>
  int irq = *(uint32*)PLIC_SCLAIM(hart);
    8000508c:	00d5151b          	slliw	a0,a0,0xd
    80005090:	0c2017b7          	lui	a5,0xc201
    80005094:	97aa                	add	a5,a5,a0
  return irq;
}
    80005096:	43c8                	lw	a0,4(a5)
    80005098:	60a2                	ld	ra,8(sp)
    8000509a:	6402                	ld	s0,0(sp)
    8000509c:	0141                	addi	sp,sp,16
    8000509e:	8082                	ret

00000000800050a0 <plic_complete>:

// tell the PLIC we've served this IRQ.
void
plic_complete(int irq)
{
    800050a0:	1101                	addi	sp,sp,-32
    800050a2:	ec06                	sd	ra,24(sp)
    800050a4:	e822                	sd	s0,16(sp)
    800050a6:	e426                	sd	s1,8(sp)
    800050a8:	1000                	addi	s0,sp,32
    800050aa:	84aa                	mv	s1,a0
  int hart = cpuid();
    800050ac:	ffffd097          	auipc	ra,0xffffd
    800050b0:	a0c080e7          	jalr	-1524(ra) # 80001ab8 <cpuid>
  *(uint32*)PLIC_SCLAIM(hart) = irq;
    800050b4:	00d5151b          	slliw	a0,a0,0xd
    800050b8:	0c2017b7          	lui	a5,0xc201
    800050bc:	97aa                	add	a5,a5,a0
    800050be:	c3c4                	sw	s1,4(a5)
}
    800050c0:	60e2                	ld	ra,24(sp)
    800050c2:	6442                	ld	s0,16(sp)
    800050c4:	64a2                	ld	s1,8(sp)
    800050c6:	6105                	addi	sp,sp,32
    800050c8:	8082                	ret

00000000800050ca <free_desc>:
}

// mark a descriptor as free.
static void
free_desc(int i)
{
    800050ca:	1141                	addi	sp,sp,-16
    800050cc:	e406                	sd	ra,8(sp)
    800050ce:	e022                	sd	s0,0(sp)
    800050d0:	0800                	addi	s0,sp,16
  if(i >= NUM)
    800050d2:	479d                	li	a5,7
    800050d4:	06a7c863          	blt	a5,a0,80005144 <free_desc+0x7a>
    panic("free_desc 1");
  if(disk.free[i])
    800050d8:	0001f717          	auipc	a4,0x1f
    800050dc:	f2870713          	addi	a4,a4,-216 # 80024000 <disk>
    800050e0:	972a                	add	a4,a4,a0
    800050e2:	6789                	lui	a5,0x2
    800050e4:	97ba                	add	a5,a5,a4
    800050e6:	0187c783          	lbu	a5,24(a5) # 2018 <_entry-0x7fffdfe8>
    800050ea:	e7ad                	bnez	a5,80005154 <free_desc+0x8a>
    panic("free_desc 2");
  disk.desc[i].addr = 0;
    800050ec:	00451793          	slli	a5,a0,0x4
    800050f0:	00021717          	auipc	a4,0x21
    800050f4:	f1070713          	addi	a4,a4,-240 # 80026000 <disk+0x2000>
    800050f8:	6314                	ld	a3,0(a4)
    800050fa:	96be                	add	a3,a3,a5
    800050fc:	0006b023          	sd	zero,0(a3)
  disk.desc[i].len = 0;
    80005100:	6314                	ld	a3,0(a4)
    80005102:	96be                	add	a3,a3,a5
    80005104:	0006a423          	sw	zero,8(a3)
  disk.desc[i].flags = 0;
    80005108:	6314                	ld	a3,0(a4)
    8000510a:	96be                	add	a3,a3,a5
    8000510c:	00069623          	sh	zero,12(a3)
  disk.desc[i].next = 0;
    80005110:	6318                	ld	a4,0(a4)
    80005112:	97ba                	add	a5,a5,a4
    80005114:	00079723          	sh	zero,14(a5)
  disk.free[i] = 1;
    80005118:	0001f717          	auipc	a4,0x1f
    8000511c:	ee870713          	addi	a4,a4,-280 # 80024000 <disk>
    80005120:	972a                	add	a4,a4,a0
    80005122:	6789                	lui	a5,0x2
    80005124:	97ba                	add	a5,a5,a4
    80005126:	4705                	li	a4,1
    80005128:	00e78c23          	sb	a4,24(a5) # 2018 <_entry-0x7fffdfe8>
  wakeup(&disk.free[0]);
    8000512c:	00021517          	auipc	a0,0x21
    80005130:	eec50513          	addi	a0,a0,-276 # 80026018 <disk+0x2018>
    80005134:	ffffd097          	auipc	ra,0xffffd
    80005138:	20a080e7          	jalr	522(ra) # 8000233e <wakeup>
}
    8000513c:	60a2                	ld	ra,8(sp)
    8000513e:	6402                	ld	s0,0(sp)
    80005140:	0141                	addi	sp,sp,16
    80005142:	8082                	ret
    panic("free_desc 1");
    80005144:	00004517          	auipc	a0,0x4
    80005148:	5ec50513          	addi	a0,a0,1516 # 80009730 <syscalls+0x358>
    8000514c:	ffffb097          	auipc	ra,0xffffb
    80005150:	516080e7          	jalr	1302(ra) # 80000662 <panic>
    panic("free_desc 2");
    80005154:	00004517          	auipc	a0,0x4
    80005158:	5ec50513          	addi	a0,a0,1516 # 80009740 <syscalls+0x368>
    8000515c:	ffffb097          	auipc	ra,0xffffb
    80005160:	506080e7          	jalr	1286(ra) # 80000662 <panic>

0000000080005164 <virtio_disk_init>:
{
    80005164:	1101                	addi	sp,sp,-32
    80005166:	ec06                	sd	ra,24(sp)
    80005168:	e822                	sd	s0,16(sp)
    8000516a:	e426                	sd	s1,8(sp)
    8000516c:	1000                	addi	s0,sp,32
  initlock(&disk.vdisk_lock, "virtio_disk");
    8000516e:	00004597          	auipc	a1,0x4
    80005172:	5e258593          	addi	a1,a1,1506 # 80009750 <syscalls+0x378>
    80005176:	00021517          	auipc	a0,0x21
    8000517a:	fb250513          	addi	a0,a0,-78 # 80026128 <disk+0x2128>
    8000517e:	ffffc097          	auipc	ra,0xffffc
    80005182:	aea080e7          	jalr	-1302(ra) # 80000c68 <initlock>
  if(*R(VIRTIO_MMIO_MAGIC_VALUE) != 0x74726976 ||
    80005186:	100017b7          	lui	a5,0x10001
    8000518a:	4398                	lw	a4,0(a5)
    8000518c:	2701                	sext.w	a4,a4
    8000518e:	747277b7          	lui	a5,0x74727
    80005192:	97678793          	addi	a5,a5,-1674 # 74726976 <_entry-0xb8d968a>
    80005196:	0ef71063          	bne	a4,a5,80005276 <virtio_disk_init+0x112>
     *R(VIRTIO_MMIO_VERSION) != 1 ||
    8000519a:	100017b7          	lui	a5,0x10001
    8000519e:	43dc                	lw	a5,4(a5)
    800051a0:	2781                	sext.w	a5,a5
  if(*R(VIRTIO_MMIO_MAGIC_VALUE) != 0x74726976 ||
    800051a2:	4705                	li	a4,1
    800051a4:	0ce79963          	bne	a5,a4,80005276 <virtio_disk_init+0x112>
     *R(VIRTIO_MMIO_DEVICE_ID) != 2 ||
    800051a8:	100017b7          	lui	a5,0x10001
    800051ac:	479c                	lw	a5,8(a5)
    800051ae:	2781                	sext.w	a5,a5
     *R(VIRTIO_MMIO_VERSION) != 1 ||
    800051b0:	4709                	li	a4,2
    800051b2:	0ce79263          	bne	a5,a4,80005276 <virtio_disk_init+0x112>
     *R(VIRTIO_MMIO_VENDOR_ID) != 0x554d4551){
    800051b6:	100017b7          	lui	a5,0x10001
    800051ba:	47d8                	lw	a4,12(a5)
    800051bc:	2701                	sext.w	a4,a4
     *R(VIRTIO_MMIO_DEVICE_ID) != 2 ||
    800051be:	554d47b7          	lui	a5,0x554d4
    800051c2:	55178793          	addi	a5,a5,1361 # 554d4551 <_entry-0x2ab2baaf>
    800051c6:	0af71863          	bne	a4,a5,80005276 <virtio_disk_init+0x112>
  *R(VIRTIO_MMIO_STATUS) = status;
    800051ca:	100017b7          	lui	a5,0x10001
    800051ce:	4705                	li	a4,1
    800051d0:	dbb8                	sw	a4,112(a5)
  *R(VIRTIO_MMIO_STATUS) = status;
    800051d2:	470d                	li	a4,3
    800051d4:	dbb8                	sw	a4,112(a5)
  uint64 features = *R(VIRTIO_MMIO_DEVICE_FEATURES);
    800051d6:	4b98                	lw	a4,16(a5)
  *R(VIRTIO_MMIO_DRIVER_FEATURES) = features;
    800051d8:	c7ffe6b7          	lui	a3,0xc7ffe
    800051dc:	75f68693          	addi	a3,a3,1887 # ffffffffc7ffe75f <end+0xffffffff47fd439f>
    800051e0:	8f75                	and	a4,a4,a3
    800051e2:	d398                	sw	a4,32(a5)
  *R(VIRTIO_MMIO_STATUS) = status;
    800051e4:	472d                	li	a4,11
    800051e6:	dbb8                	sw	a4,112(a5)
  *R(VIRTIO_MMIO_STATUS) = status;
    800051e8:	473d                	li	a4,15
    800051ea:	dbb8                	sw	a4,112(a5)
  *R(VIRTIO_MMIO_GUEST_PAGE_SIZE) = PGSIZE;
    800051ec:	6705                	lui	a4,0x1
    800051ee:	d798                	sw	a4,40(a5)
  *R(VIRTIO_MMIO_QUEUE_SEL) = 0;
    800051f0:	0207a823          	sw	zero,48(a5) # 10001030 <_entry-0x6fffefd0>
  uint32 max = *R(VIRTIO_MMIO_QUEUE_NUM_MAX);
    800051f4:	5bdc                	lw	a5,52(a5)
    800051f6:	2781                	sext.w	a5,a5
  if(max == 0)
    800051f8:	c7d9                	beqz	a5,80005286 <virtio_disk_init+0x122>
  if(max < NUM)
    800051fa:	471d                	li	a4,7
    800051fc:	08f77d63          	bgeu	a4,a5,80005296 <virtio_disk_init+0x132>
  *R(VIRTIO_MMIO_QUEUE_NUM) = NUM;
    80005200:	100014b7          	lui	s1,0x10001
    80005204:	47a1                	li	a5,8
    80005206:	dc9c                	sw	a5,56(s1)
  kmemset(disk.pages, 0, sizeof(disk.pages));
    80005208:	6609                	lui	a2,0x2
    8000520a:	4581                	li	a1,0
    8000520c:	0001f517          	auipc	a0,0x1f
    80005210:	df450513          	addi	a0,a0,-524 # 80024000 <disk>
    80005214:	ffffc097          	auipc	ra,0xffffc
    80005218:	be0080e7          	jalr	-1056(ra) # 80000df4 <kmemset>
  *R(VIRTIO_MMIO_QUEUE_PFN) = ((uint64)disk.pages) >> PGSHIFT;
    8000521c:	0001f717          	auipc	a4,0x1f
    80005220:	de470713          	addi	a4,a4,-540 # 80024000 <disk>
    80005224:	00c75793          	srli	a5,a4,0xc
    80005228:	2781                	sext.w	a5,a5
    8000522a:	c0bc                	sw	a5,64(s1)
  disk.desc = (struct virtq_desc *) disk.pages;
    8000522c:	00021797          	auipc	a5,0x21
    80005230:	dd478793          	addi	a5,a5,-556 # 80026000 <disk+0x2000>
    80005234:	e398                	sd	a4,0(a5)
  disk.avail = (struct virtq_avail *)(disk.pages + NUM*sizeof(struct virtq_desc));
    80005236:	0001f717          	auipc	a4,0x1f
    8000523a:	e4a70713          	addi	a4,a4,-438 # 80024080 <disk+0x80>
    8000523e:	e798                	sd	a4,8(a5)
  disk.used = (struct virtq_used *) (disk.pages + PGSIZE);
    80005240:	00020717          	auipc	a4,0x20
    80005244:	dc070713          	addi	a4,a4,-576 # 80025000 <disk+0x1000>
    80005248:	eb98                	sd	a4,16(a5)
    disk.free[i] = 1;
    8000524a:	4705                	li	a4,1
    8000524c:	00e78c23          	sb	a4,24(a5)
    80005250:	00e78ca3          	sb	a4,25(a5)
    80005254:	00e78d23          	sb	a4,26(a5)
    80005258:	00e78da3          	sb	a4,27(a5)
    8000525c:	00e78e23          	sb	a4,28(a5)
    80005260:	00e78ea3          	sb	a4,29(a5)
    80005264:	00e78f23          	sb	a4,30(a5)
    80005268:	00e78fa3          	sb	a4,31(a5)
}
    8000526c:	60e2                	ld	ra,24(sp)
    8000526e:	6442                	ld	s0,16(sp)
    80005270:	64a2                	ld	s1,8(sp)
    80005272:	6105                	addi	sp,sp,32
    80005274:	8082                	ret
    panic("could not find virtio disk");
    80005276:	00004517          	auipc	a0,0x4
    8000527a:	4ea50513          	addi	a0,a0,1258 # 80009760 <syscalls+0x388>
    8000527e:	ffffb097          	auipc	ra,0xffffb
    80005282:	3e4080e7          	jalr	996(ra) # 80000662 <panic>
    panic("virtio disk has no queue 0");
    80005286:	00004517          	auipc	a0,0x4
    8000528a:	4fa50513          	addi	a0,a0,1274 # 80009780 <syscalls+0x3a8>
    8000528e:	ffffb097          	auipc	ra,0xffffb
    80005292:	3d4080e7          	jalr	980(ra) # 80000662 <panic>
    panic("virtio disk max queue too short");
    80005296:	00004517          	auipc	a0,0x4
    8000529a:	50a50513          	addi	a0,a0,1290 # 800097a0 <syscalls+0x3c8>
    8000529e:	ffffb097          	auipc	ra,0xffffb
    800052a2:	3c4080e7          	jalr	964(ra) # 80000662 <panic>

00000000800052a6 <virtio_disk_rw>:
  return 0;
}

void
virtio_disk_rw(struct buf *b, int write)
{
    800052a6:	7119                	addi	sp,sp,-128
    800052a8:	fc86                	sd	ra,120(sp)
    800052aa:	f8a2                	sd	s0,112(sp)
    800052ac:	f4a6                	sd	s1,104(sp)
    800052ae:	f0ca                	sd	s2,96(sp)
    800052b0:	ecce                	sd	s3,88(sp)
    800052b2:	e8d2                	sd	s4,80(sp)
    800052b4:	e4d6                	sd	s5,72(sp)
    800052b6:	e0da                	sd	s6,64(sp)
    800052b8:	fc5e                	sd	s7,56(sp)
    800052ba:	f862                	sd	s8,48(sp)
    800052bc:	f466                	sd	s9,40(sp)
    800052be:	f06a                	sd	s10,32(sp)
    800052c0:	ec6e                	sd	s11,24(sp)
    800052c2:	0100                	addi	s0,sp,128
    800052c4:	8aaa                	mv	s5,a0
    800052c6:	8d2e                	mv	s10,a1
  uint64 sector = b->blockno * (BSIZE / 512);
    800052c8:	00c52c83          	lw	s9,12(a0)
    800052cc:	001c9c9b          	slliw	s9,s9,0x1
    800052d0:	1c82                	slli	s9,s9,0x20
    800052d2:	020cdc93          	srli	s9,s9,0x20

  acquire(&disk.vdisk_lock);
    800052d6:	00021517          	auipc	a0,0x21
    800052da:	e5250513          	addi	a0,a0,-430 # 80026128 <disk+0x2128>
    800052de:	ffffc097          	auipc	ra,0xffffc
    800052e2:	a1a080e7          	jalr	-1510(ra) # 80000cf8 <acquire>
  for(int i = 0; i < 3; i++){
    800052e6:	4981                	li	s3,0
  for(int i = 0; i < NUM; i++){
    800052e8:	44a1                	li	s1,8
      disk.free[i] = 0;
    800052ea:	0001fc17          	auipc	s8,0x1f
    800052ee:	d16c0c13          	addi	s8,s8,-746 # 80024000 <disk>
    800052f2:	6b89                	lui	s7,0x2
  for(int i = 0; i < 3; i++){
    800052f4:	4b0d                	li	s6,3
    800052f6:	a0ad                	j	80005360 <virtio_disk_rw+0xba>
      disk.free[i] = 0;
    800052f8:	00fc0733          	add	a4,s8,a5
    800052fc:	975e                	add	a4,a4,s7
    800052fe:	00070c23          	sb	zero,24(a4)
    idx[i] = alloc_desc();
    80005302:	c19c                	sw	a5,0(a1)
    if(idx[i] < 0){
    80005304:	0207c563          	bltz	a5,8000532e <virtio_disk_rw+0x88>
  for(int i = 0; i < 3; i++){
    80005308:	2905                	addiw	s2,s2,1
    8000530a:	0611                	addi	a2,a2,4
    8000530c:	19690c63          	beq	s2,s6,800054a4 <virtio_disk_rw+0x1fe>
    idx[i] = alloc_desc();
    80005310:	85b2                	mv	a1,a2
  for(int i = 0; i < NUM; i++){
    80005312:	00021717          	auipc	a4,0x21
    80005316:	d0670713          	addi	a4,a4,-762 # 80026018 <disk+0x2018>
    8000531a:	87ce                	mv	a5,s3
    if(disk.free[i]){
    8000531c:	00074683          	lbu	a3,0(a4)
    80005320:	fee1                	bnez	a3,800052f8 <virtio_disk_rw+0x52>
  for(int i = 0; i < NUM; i++){
    80005322:	2785                	addiw	a5,a5,1
    80005324:	0705                	addi	a4,a4,1
    80005326:	fe979be3          	bne	a5,s1,8000531c <virtio_disk_rw+0x76>
    idx[i] = alloc_desc();
    8000532a:	57fd                	li	a5,-1
    8000532c:	c19c                	sw	a5,0(a1)
      for(int j = 0; j < i; j++)
    8000532e:	01205d63          	blez	s2,80005348 <virtio_disk_rw+0xa2>
    80005332:	8dce                	mv	s11,s3
        free_desc(idx[j]);
    80005334:	000a2503          	lw	a0,0(s4)
    80005338:	00000097          	auipc	ra,0x0
    8000533c:	d92080e7          	jalr	-622(ra) # 800050ca <free_desc>
      for(int j = 0; j < i; j++)
    80005340:	2d85                	addiw	s11,s11,1
    80005342:	0a11                	addi	s4,s4,4
    80005344:	ff2d98e3          	bne	s11,s2,80005334 <virtio_disk_rw+0x8e>
  int idx[3];
  while(1){
    if(alloc3_desc(idx) == 0) {
      break;
    }
    _sleep(&disk.free[0], &disk.vdisk_lock);
    80005348:	00021597          	auipc	a1,0x21
    8000534c:	de058593          	addi	a1,a1,-544 # 80026128 <disk+0x2128>
    80005350:	00021517          	auipc	a0,0x21
    80005354:	cc850513          	addi	a0,a0,-824 # 80026018 <disk+0x2018>
    80005358:	ffffd097          	auipc	ra,0xffffd
    8000535c:	e5a080e7          	jalr	-422(ra) # 800021b2 <_sleep>
  for(int i = 0; i < 3; i++){
    80005360:	f8040a13          	addi	s4,s0,-128
{
    80005364:	8652                	mv	a2,s4
  for(int i = 0; i < 3; i++){
    80005366:	894e                	mv	s2,s3
    80005368:	b765                	j	80005310 <virtio_disk_rw+0x6a>
  disk.desc[idx[0]].next = idx[1];

  disk.desc[idx[1]].addr = (uint64) b->data;
  disk.desc[idx[1]].len = BSIZE;
  if(write)
    disk.desc[idx[1]].flags = 0; // device reads b->data
    8000536a:	00021697          	auipc	a3,0x21
    8000536e:	c966b683          	ld	a3,-874(a3) # 80026000 <disk+0x2000>
    80005372:	96ba                	add	a3,a3,a4
    80005374:	00069623          	sh	zero,12(a3)
  else
    disk.desc[idx[1]].flags = VRING_DESC_F_WRITE; // device writes b->data
  disk.desc[idx[1]].flags |= VRING_DESC_F_NEXT;
    80005378:	0001f817          	auipc	a6,0x1f
    8000537c:	c8880813          	addi	a6,a6,-888 # 80024000 <disk>
    80005380:	00021697          	auipc	a3,0x21
    80005384:	c8068693          	addi	a3,a3,-896 # 80026000 <disk+0x2000>
    80005388:	6290                	ld	a2,0(a3)
    8000538a:	963a                	add	a2,a2,a4
    8000538c:	00c65583          	lhu	a1,12(a2) # 200c <_entry-0x7fffdff4>
    80005390:	0015e593          	ori	a1,a1,1
    80005394:	00b61623          	sh	a1,12(a2)
  disk.desc[idx[1]].next = idx[2];
    80005398:	f8842603          	lw	a2,-120(s0)
    8000539c:	628c                	ld	a1,0(a3)
    8000539e:	972e                	add	a4,a4,a1
    800053a0:	00c71723          	sh	a2,14(a4)

  disk.info[idx[0]].status = 0xff; // device writes 0 on success
    800053a4:	20050593          	addi	a1,a0,512
    800053a8:	0592                	slli	a1,a1,0x4
    800053aa:	95c2                	add	a1,a1,a6
    800053ac:	577d                	li	a4,-1
    800053ae:	02e58823          	sb	a4,48(a1)
  disk.desc[idx[2]].addr = (uint64) &disk.info[idx[0]].status;
    800053b2:	00461713          	slli	a4,a2,0x4
    800053b6:	6290                	ld	a2,0(a3)
    800053b8:	963a                	add	a2,a2,a4
    800053ba:	03078793          	addi	a5,a5,48
    800053be:	97c2                	add	a5,a5,a6
    800053c0:	e21c                	sd	a5,0(a2)
  disk.desc[idx[2]].len = 1;
    800053c2:	629c                	ld	a5,0(a3)
    800053c4:	97ba                	add	a5,a5,a4
    800053c6:	4605                	li	a2,1
    800053c8:	c790                	sw	a2,8(a5)
  disk.desc[idx[2]].flags = VRING_DESC_F_WRITE; // device writes the status
    800053ca:	629c                	ld	a5,0(a3)
    800053cc:	97ba                	add	a5,a5,a4
    800053ce:	4809                	li	a6,2
    800053d0:	01079623          	sh	a6,12(a5)
  disk.desc[idx[2]].next = 0;
    800053d4:	629c                	ld	a5,0(a3)
    800053d6:	97ba                	add	a5,a5,a4
    800053d8:	00079723          	sh	zero,14(a5)

  // record struct buf for virtio_disk_intr().
  b->disk = 1;
    800053dc:	00caa223          	sw	a2,4(s5)
  disk.info[idx[0]].b = b;
    800053e0:	0355b423          	sd	s5,40(a1)

  // tell the device the first index in our chain of descriptors.
  disk.avail->ring[disk.avail->idx % NUM] = idx[0];
    800053e4:	6698                	ld	a4,8(a3)
    800053e6:	00275783          	lhu	a5,2(a4)
    800053ea:	8b9d                	andi	a5,a5,7
    800053ec:	0786                	slli	a5,a5,0x1
    800053ee:	973e                	add	a4,a4,a5
    800053f0:	00a71223          	sh	a0,4(a4)

  __sync_synchronize();
    800053f4:	0ff0000f          	fence

  // tell the device another avail ring entry is available.
  disk.avail->idx += 1; // not % NUM ...
    800053f8:	6698                	ld	a4,8(a3)
    800053fa:	00275783          	lhu	a5,2(a4)
    800053fe:	2785                	addiw	a5,a5,1
    80005400:	00f71123          	sh	a5,2(a4)

  __sync_synchronize();
    80005404:	0ff0000f          	fence

  *R(VIRTIO_MMIO_QUEUE_NOTIFY) = 0; // value is queue number
    80005408:	100017b7          	lui	a5,0x10001
    8000540c:	0407a823          	sw	zero,80(a5) # 10001050 <_entry-0x6fffefb0>

  // Wait for virtio_disk_intr() to say request has finished.
  while(b->disk == 1) {
    80005410:	004aa783          	lw	a5,4(s5)
    80005414:	02c79163          	bne	a5,a2,80005436 <virtio_disk_rw+0x190>
    _sleep(b, &disk.vdisk_lock);
    80005418:	00021917          	auipc	s2,0x21
    8000541c:	d1090913          	addi	s2,s2,-752 # 80026128 <disk+0x2128>
  while(b->disk == 1) {
    80005420:	4485                	li	s1,1
    _sleep(b, &disk.vdisk_lock);
    80005422:	85ca                	mv	a1,s2
    80005424:	8556                	mv	a0,s5
    80005426:	ffffd097          	auipc	ra,0xffffd
    8000542a:	d8c080e7          	jalr	-628(ra) # 800021b2 <_sleep>
  while(b->disk == 1) {
    8000542e:	004aa783          	lw	a5,4(s5)
    80005432:	fe9788e3          	beq	a5,s1,80005422 <virtio_disk_rw+0x17c>
  }

  disk.info[idx[0]].b = 0;
    80005436:	f8042903          	lw	s2,-128(s0)
    8000543a:	20090713          	addi	a4,s2,512
    8000543e:	0712                	slli	a4,a4,0x4
    80005440:	0001f797          	auipc	a5,0x1f
    80005444:	bc078793          	addi	a5,a5,-1088 # 80024000 <disk>
    80005448:	97ba                	add	a5,a5,a4
    8000544a:	0207b423          	sd	zero,40(a5)
    int flag = disk.desc[i].flags;
    8000544e:	00021997          	auipc	s3,0x21
    80005452:	bb298993          	addi	s3,s3,-1102 # 80026000 <disk+0x2000>
    80005456:	00491713          	slli	a4,s2,0x4
    8000545a:	0009b783          	ld	a5,0(s3)
    8000545e:	97ba                	add	a5,a5,a4
    80005460:	00c7d483          	lhu	s1,12(a5)
    int nxt = disk.desc[i].next;
    80005464:	854a                	mv	a0,s2
    80005466:	00e7d903          	lhu	s2,14(a5)
    free_desc(i);
    8000546a:	00000097          	auipc	ra,0x0
    8000546e:	c60080e7          	jalr	-928(ra) # 800050ca <free_desc>
    if(flag & VRING_DESC_F_NEXT)
    80005472:	8885                	andi	s1,s1,1
    80005474:	f0ed                	bnez	s1,80005456 <virtio_disk_rw+0x1b0>
  free_chain(idx[0]);

  release(&disk.vdisk_lock);
    80005476:	00021517          	auipc	a0,0x21
    8000547a:	cb250513          	addi	a0,a0,-846 # 80026128 <disk+0x2128>
    8000547e:	ffffc097          	auipc	ra,0xffffc
    80005482:	92e080e7          	jalr	-1746(ra) # 80000dac <release>
}
    80005486:	70e6                	ld	ra,120(sp)
    80005488:	7446                	ld	s0,112(sp)
    8000548a:	74a6                	ld	s1,104(sp)
    8000548c:	7906                	ld	s2,96(sp)
    8000548e:	69e6                	ld	s3,88(sp)
    80005490:	6a46                	ld	s4,80(sp)
    80005492:	6aa6                	ld	s5,72(sp)
    80005494:	6b06                	ld	s6,64(sp)
    80005496:	7be2                	ld	s7,56(sp)
    80005498:	7c42                	ld	s8,48(sp)
    8000549a:	7ca2                	ld	s9,40(sp)
    8000549c:	7d02                	ld	s10,32(sp)
    8000549e:	6de2                	ld	s11,24(sp)
    800054a0:	6109                	addi	sp,sp,128
    800054a2:	8082                	ret
  struct virtio_blk_req *buf0 = &disk.ops[idx[0]];
    800054a4:	f8042503          	lw	a0,-128(s0)
    800054a8:	20050793          	addi	a5,a0,512
    800054ac:	0792                	slli	a5,a5,0x4
  if(write)
    800054ae:	0001f817          	auipc	a6,0x1f
    800054b2:	b5280813          	addi	a6,a6,-1198 # 80024000 <disk>
    800054b6:	00f80733          	add	a4,a6,a5
    800054ba:	01a036b3          	snez	a3,s10
    800054be:	0ad72423          	sw	a3,168(a4)
  buf0->reserved = 0;
    800054c2:	0a072623          	sw	zero,172(a4)
  buf0->sector = sector;
    800054c6:	0b973823          	sd	s9,176(a4)
  disk.desc[idx[0]].addr = (uint64) buf0;
    800054ca:	7679                	lui	a2,0xffffe
    800054cc:	963e                	add	a2,a2,a5
    800054ce:	00021697          	auipc	a3,0x21
    800054d2:	b3268693          	addi	a3,a3,-1230 # 80026000 <disk+0x2000>
    800054d6:	6298                	ld	a4,0(a3)
    800054d8:	9732                	add	a4,a4,a2
  struct virtio_blk_req *buf0 = &disk.ops[idx[0]];
    800054da:	0a878593          	addi	a1,a5,168
    800054de:	95c2                	add	a1,a1,a6
  disk.desc[idx[0]].addr = (uint64) buf0;
    800054e0:	e30c                	sd	a1,0(a4)
  disk.desc[idx[0]].len = sizeof(struct virtio_blk_req);
    800054e2:	6298                	ld	a4,0(a3)
    800054e4:	9732                	add	a4,a4,a2
    800054e6:	45c1                	li	a1,16
    800054e8:	c70c                	sw	a1,8(a4)
  disk.desc[idx[0]].flags = VRING_DESC_F_NEXT;
    800054ea:	6298                	ld	a4,0(a3)
    800054ec:	9732                	add	a4,a4,a2
    800054ee:	4585                	li	a1,1
    800054f0:	00b71623          	sh	a1,12(a4)
  disk.desc[idx[0]].next = idx[1];
    800054f4:	f8442703          	lw	a4,-124(s0)
    800054f8:	628c                	ld	a1,0(a3)
    800054fa:	962e                	add	a2,a2,a1
    800054fc:	00e61723          	sh	a4,14(a2) # ffffffffffffe00e <end+0xffffffff7ffd3c4e>
  disk.desc[idx[1]].addr = (uint64) b->data;
    80005500:	0712                	slli	a4,a4,0x4
    80005502:	6290                	ld	a2,0(a3)
    80005504:	963a                	add	a2,a2,a4
    80005506:	058a8593          	addi	a1,s5,88
    8000550a:	e20c                	sd	a1,0(a2)
  disk.desc[idx[1]].len = BSIZE;
    8000550c:	6294                	ld	a3,0(a3)
    8000550e:	96ba                	add	a3,a3,a4
    80005510:	40000613          	li	a2,1024
    80005514:	c690                	sw	a2,8(a3)
  if(write)
    80005516:	e40d1ae3          	bnez	s10,8000536a <virtio_disk_rw+0xc4>
    disk.desc[idx[1]].flags = VRING_DESC_F_WRITE; // device writes b->data
    8000551a:	00021697          	auipc	a3,0x21
    8000551e:	ae66b683          	ld	a3,-1306(a3) # 80026000 <disk+0x2000>
    80005522:	96ba                	add	a3,a3,a4
    80005524:	4609                	li	a2,2
    80005526:	00c69623          	sh	a2,12(a3)
    8000552a:	b5b9                	j	80005378 <virtio_disk_rw+0xd2>

000000008000552c <virtio_disk_intr>:

void
virtio_disk_intr()
{
    8000552c:	1101                	addi	sp,sp,-32
    8000552e:	ec06                	sd	ra,24(sp)
    80005530:	e822                	sd	s0,16(sp)
    80005532:	e426                	sd	s1,8(sp)
    80005534:	e04a                	sd	s2,0(sp)
    80005536:	1000                	addi	s0,sp,32
  acquire(&disk.vdisk_lock);
    80005538:	00021517          	auipc	a0,0x21
    8000553c:	bf050513          	addi	a0,a0,-1040 # 80026128 <disk+0x2128>
    80005540:	ffffb097          	auipc	ra,0xffffb
    80005544:	7b8080e7          	jalr	1976(ra) # 80000cf8 <acquire>
  // we've seen this interrupt, which the following line does.
  // this may race with the device writing new entries to
  // the "used" ring, in which case we may process the new
  // completion entries in this interrupt, and have nothing to do
  // in the next interrupt, which is harmless.
  *R(VIRTIO_MMIO_INTERRUPT_ACK) = *R(VIRTIO_MMIO_INTERRUPT_STATUS) & 0x3;
    80005548:	10001737          	lui	a4,0x10001
    8000554c:	533c                	lw	a5,96(a4)
    8000554e:	8b8d                	andi	a5,a5,3
    80005550:	d37c                	sw	a5,100(a4)

  __sync_synchronize();
    80005552:	0ff0000f          	fence

  // the device increments disk.used->idx when it
  // adds an entry to the used ring.

  while(disk.used_idx != disk.used->idx){
    80005556:	00021797          	auipc	a5,0x21
    8000555a:	aaa78793          	addi	a5,a5,-1366 # 80026000 <disk+0x2000>
    8000555e:	6b94                	ld	a3,16(a5)
    80005560:	0207d703          	lhu	a4,32(a5)
    80005564:	0026d783          	lhu	a5,2(a3)
    80005568:	06f70163          	beq	a4,a5,800055ca <virtio_disk_intr+0x9e>
    __sync_synchronize();
    int id = disk.used->ring[disk.used_idx % NUM].id;
    8000556c:	0001f917          	auipc	s2,0x1f
    80005570:	a9490913          	addi	s2,s2,-1388 # 80024000 <disk>
    80005574:	00021497          	auipc	s1,0x21
    80005578:	a8c48493          	addi	s1,s1,-1396 # 80026000 <disk+0x2000>
    __sync_synchronize();
    8000557c:	0ff0000f          	fence
    int id = disk.used->ring[disk.used_idx % NUM].id;
    80005580:	6898                	ld	a4,16(s1)
    80005582:	0204d783          	lhu	a5,32(s1)
    80005586:	8b9d                	andi	a5,a5,7
    80005588:	078e                	slli	a5,a5,0x3
    8000558a:	97ba                	add	a5,a5,a4
    8000558c:	43dc                	lw	a5,4(a5)

    if(disk.info[id].status != 0)
    8000558e:	20078713          	addi	a4,a5,512
    80005592:	0712                	slli	a4,a4,0x4
    80005594:	974a                	add	a4,a4,s2
    80005596:	03074703          	lbu	a4,48(a4) # 10001030 <_entry-0x6fffefd0>
    8000559a:	e731                	bnez	a4,800055e6 <virtio_disk_intr+0xba>
      panic("virtio_disk_intr status");

    struct buf *b = disk.info[id].b;
    8000559c:	20078793          	addi	a5,a5,512
    800055a0:	0792                	slli	a5,a5,0x4
    800055a2:	97ca                	add	a5,a5,s2
    800055a4:	7788                	ld	a0,40(a5)
    b->disk = 0;   // disk is done with buf
    800055a6:	00052223          	sw	zero,4(a0)
    wakeup(b);
    800055aa:	ffffd097          	auipc	ra,0xffffd
    800055ae:	d94080e7          	jalr	-620(ra) # 8000233e <wakeup>

    disk.used_idx += 1;
    800055b2:	0204d783          	lhu	a5,32(s1)
    800055b6:	2785                	addiw	a5,a5,1
    800055b8:	17c2                	slli	a5,a5,0x30
    800055ba:	93c1                	srli	a5,a5,0x30
    800055bc:	02f49023          	sh	a5,32(s1)
  while(disk.used_idx != disk.used->idx){
    800055c0:	6898                	ld	a4,16(s1)
    800055c2:	00275703          	lhu	a4,2(a4)
    800055c6:	faf71be3          	bne	a4,a5,8000557c <virtio_disk_intr+0x50>
  }

  release(&disk.vdisk_lock);
    800055ca:	00021517          	auipc	a0,0x21
    800055ce:	b5e50513          	addi	a0,a0,-1186 # 80026128 <disk+0x2128>
    800055d2:	ffffb097          	auipc	ra,0xffffb
    800055d6:	7da080e7          	jalr	2010(ra) # 80000dac <release>
}
    800055da:	60e2                	ld	ra,24(sp)
    800055dc:	6442                	ld	s0,16(sp)
    800055de:	64a2                	ld	s1,8(sp)
    800055e0:	6902                	ld	s2,0(sp)
    800055e2:	6105                	addi	sp,sp,32
    800055e4:	8082                	ret
      panic("virtio_disk_intr status");
    800055e6:	00004517          	auipc	a0,0x4
    800055ea:	1da50513          	addi	a0,a0,474 # 800097c0 <syscalls+0x3e8>
    800055ee:	ffffb097          	auipc	ra,0xffffb
    800055f2:	074080e7          	jalr	116(ra) # 80000662 <panic>

00000000800055f6 <xv6_itrunc>:

// Truncate inode (discard contents).
// Caller must hold ip->lock.

void xv6_itrunc(struct inode * ip)
{
    800055f6:	7139                	addi	sp,sp,-64
    800055f8:	fc06                	sd	ra,56(sp)
    800055fa:	f822                	sd	s0,48(sp)
    800055fc:	f426                	sd	s1,40(sp)
    800055fe:	f04a                	sd	s2,32(sp)
    80005600:	ec4e                	sd	s3,24(sp)
    80005602:	e852                	sd	s4,16(sp)
    80005604:	e456                	sd	s5,8(sp)
    80005606:	0080                	addi	s0,sp,64
    80005608:	892a                	mv	s2,a0
	int i, j;
	struct buf *bp;
	uint *a;

	for(i = 0; i < NDIRECT; i++) {
    8000560a:	4481                	li	s1,0
		if(ip->xv6_inode->addrs[i]) {
			xv6_vfs_ops.bfree(ip->dev, ip->xv6_inode->addrs[i]);
    8000560c:	00005a17          	auipc	s4,0x5
    80005610:	dfca0a13          	addi	s4,s4,-516 # 8000a408 <xv6_vfs_ops>
	for(i = 0; i < NDIRECT; i++) {
    80005614:	49b1                	li	s3,12
    80005616:	a021                	j	8000561e <xv6_itrunc+0x28>
    80005618:	2485                	addiw	s1,s1,1
    8000561a:	03348863          	beq	s1,s3,8000564a <xv6_itrunc+0x54>
		if(ip->xv6_inode->addrs[i]) {
    8000561e:	02093783          	ld	a5,32(s2)
    80005622:	01048713          	addi	a4,s1,16
    80005626:	070a                	slli	a4,a4,0x2
    80005628:	97ba                	add	a5,a5,a4
    8000562a:	47cc                	lw	a1,12(a5)
    8000562c:	d5f5                	beqz	a1,80005618 <xv6_itrunc+0x22>
			xv6_vfs_ops.bfree(ip->dev, ip->xv6_inode->addrs[i]);
    8000562e:	028a3783          	ld	a5,40(s4)
    80005632:	00092503          	lw	a0,0(s2)
    80005636:	9782                	jalr	a5
			ip->xv6_inode->addrs[i] = 0;
    80005638:	02093783          	ld	a5,32(s2)
    8000563c:	01048713          	addi	a4,s1,16
    80005640:	070a                	slli	a4,a4,0x2
    80005642:	97ba                	add	a5,a5,a4
    80005644:	0007a623          	sw	zero,12(a5)
    80005648:	bfc1                	j	80005618 <xv6_itrunc+0x22>
		}
	}

	if(ip->xv6_inode->addrs[NDIRECT]) {
    8000564a:	02093783          	ld	a5,32(s2)
    8000564e:	5fec                	lw	a1,124(a5)
    80005650:	cdb9                	beqz	a1,800056ae <xv6_itrunc+0xb8>
		bp = xv6_vfs_ops.bread(ip->dev, ip->xv6_inode->addrs[NDIRECT]);
    80005652:	00092503          	lw	a0,0(s2)
    80005656:	00005797          	auipc	a5,0x5
    8000565a:	df27b783          	ld	a5,-526(a5) # 8000a448 <xv6_vfs_ops+0x40>
    8000565e:	9782                	jalr	a5
    80005660:	8aaa                	mv	s5,a0
		a = (uint*)bp->data;

		for(j = 0; j < NINDIRECT; j++) {
    80005662:	05850493          	addi	s1,a0,88
    80005666:	45850993          	addi	s3,a0,1112
			if(a[j])
				xv6_vfs_ops.bfree(ip->dev, a[j]);
    8000566a:	00005a17          	auipc	s4,0x5
    8000566e:	d9ea0a13          	addi	s4,s4,-610 # 8000a408 <xv6_vfs_ops>
    80005672:	a021                	j	8000567a <xv6_itrunc+0x84>
		for(j = 0; j < NINDIRECT; j++) {
    80005674:	0491                	addi	s1,s1,4
    80005676:	01348a63          	beq	s1,s3,8000568a <xv6_itrunc+0x94>
			if(a[j])
    8000567a:	408c                	lw	a1,0(s1)
    8000567c:	dde5                	beqz	a1,80005674 <xv6_itrunc+0x7e>
				xv6_vfs_ops.bfree(ip->dev, a[j]);
    8000567e:	028a3783          	ld	a5,40(s4)
    80005682:	00092503          	lw	a0,0(s2)
    80005686:	9782                	jalr	a5
    80005688:	b7f5                	j	80005674 <xv6_itrunc+0x7e>
		}

		xv6_vfs_ops.brelease(bp);
    8000568a:	00005497          	auipc	s1,0x5
    8000568e:	d7e48493          	addi	s1,s1,-642 # 8000a408 <xv6_vfs_ops>
    80005692:	789c                	ld	a5,48(s1)
    80005694:	8556                	mv	a0,s5
    80005696:	9782                	jalr	a5
		xv6_vfs_ops.bfree(ip->dev, ip->xv6_inode->addrs[NDIRECT]);
    80005698:	02093703          	ld	a4,32(s2)
    8000569c:	749c                	ld	a5,40(s1)
    8000569e:	5f6c                	lw	a1,124(a4)
    800056a0:	00092503          	lw	a0,0(s2)
    800056a4:	9782                	jalr	a5
		ip->xv6_inode->addrs[NDIRECT] = 0;
    800056a6:	02093783          	ld	a5,32(s2)
    800056aa:	0607ae23          	sw	zero,124(a5)
	}

	ip->size = 0;
    800056ae:	02092823          	sw	zero,48(s2)
	xv6_inode_ops.iupdate(ip);
    800056b2:	854a                	mv	a0,s2
    800056b4:	00005797          	auipc	a5,0x5
    800056b8:	dac7b783          	ld	a5,-596(a5) # 8000a460 <xv6_inode_ops+0x8>
    800056bc:	9782                	jalr	a5
}
    800056be:	70e2                	ld	ra,56(sp)
    800056c0:	7442                	ld	s0,48(sp)
    800056c2:	74a2                	ld	s1,40(sp)
    800056c4:	7902                	ld	s2,32(sp)
    800056c6:	69e2                	ld	s3,24(sp)
    800056c8:	6a42                	ld	s4,16(sp)
    800056ca:	6aa2                	ld	s5,8(sp)
    800056cc:	6121                	addi	sp,sp,64
    800056ce:	8082                	ret

00000000800056d0 <xv6_iunlockput>:
	releasesleep(&ip->xv6_inode->lock);
}


void xv6_iunlockput(struct inode * ip)
{
    800056d0:	1101                	addi	sp,sp,-32
    800056d2:	ec06                	sd	ra,24(sp)
    800056d4:	e822                	sd	s0,16(sp)
    800056d6:	e426                	sd	s1,8(sp)
    800056d8:	e04a                	sd	s2,0(sp)
    800056da:	1000                	addi	s0,sp,32
    800056dc:	84aa                	mv	s1,a0
	xv6_inode_ops.iunlock(ip);
    800056de:	00005917          	auipc	s2,0x5
    800056e2:	d2a90913          	addi	s2,s2,-726 # 8000a408 <xv6_vfs_ops>
    800056e6:	08093783          	ld	a5,128(s2)
    800056ea:	9782                	jalr	a5
	xv6_inode_ops.iput(ip);
    800056ec:	07893783          	ld	a5,120(s2)
    800056f0:	8526                	mv	a0,s1
    800056f2:	9782                	jalr	a5
}
    800056f4:	60e2                	ld	ra,24(sp)
    800056f6:	6442                	ld	s0,16(sp)
    800056f8:	64a2                	ld	s1,8(sp)
    800056fa:	6902                	ld	s2,0(sp)
    800056fc:	6105                	addi	sp,sp,32
    800056fe:	8082                	ret

0000000080005700 <xv6_stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.

void xv6_stati(struct inode * ip, struct stat * st)
{
    80005700:	1141                	addi	sp,sp,-16
    80005702:	e422                	sd	s0,8(sp)
    80005704:	0800                	addi	s0,sp,16
	st->dev = ip->dev;
    80005706:	411c                	lw	a5,0(a0)
    80005708:	c19c                	sw	a5,0(a1)
	st->ino = ip->inum;
    8000570a:	415c                	lw	a5,4(a0)
    8000570c:	c1dc                	sw	a5,4(a1)
	st->type = ip->type;
    8000570e:	02851783          	lh	a5,40(a0)
    80005712:	00f59423          	sh	a5,8(a1)
	st->nlink = ip->nlink;
    80005716:	02e51783          	lh	a5,46(a0)
    8000571a:	00f59523          	sh	a5,10(a1)
	st->size = ip->size;
    8000571e:	03056783          	lwu	a5,48(a0)
    80005722:	e99c                	sd	a5,16(a1)
}
    80005724:	6422                	ld	s0,8(sp)
    80005726:	0141                	addi	sp,sp,16
    80005728:	8082                	ret

000000008000572a <xv6_read_super>:
{
    8000572a:	7179                	addi	sp,sp,-48
    8000572c:	f406                	sd	ra,40(sp)
    8000572e:	f022                	sd	s0,32(sp)
    80005730:	ec26                	sd	s1,24(sp)
    80005732:	e84a                	sd	s2,16(sp)
    80005734:	e44e                	sd	s3,8(sp)
    80005736:	e052                	sd	s4,0(sp)
    80005738:	1800                	addi	s0,sp,48
    8000573a:	89aa                	mv	s3,a0
    8000573c:	84ae                	mv	s1,a1
	buffer = xv6_vfs_ops.bread(dev, 1);
    8000573e:	4585                	li	a1,1
    80005740:	00005797          	auipc	a5,0x5
    80005744:	d087b783          	ld	a5,-760(a5) # 8000a448 <xv6_vfs_ops+0x40>
    80005748:	9782                	jalr	a5
    8000574a:	892a                	mv	s2,a0
	if(((struct xv6_superblock *) buffer->data)->magic != XV6_MAGIC) {
    8000574c:	4d38                	lw	a4,88(a0)
    8000574e:	102037b7          	lui	a5,0x10203
    80005752:	04078793          	addi	a5,a5,64 # 10203040 <_entry-0x6fdfcfc0>
    80005756:	0cf71763          	bne	a4,a5,80005824 <xv6_read_super+0xfa>
	kmemmove(&superblock->xv6_superblock, buffer->data, sizeof(struct xv6_superblock));
    8000575a:	01848a13          	addi	s4,s1,24
    8000575e:	02000613          	li	a2,32
    80005762:	05850593          	addi	a1,a0,88
    80005766:	8552                	mv	a0,s4
    80005768:	ffffb097          	auipc	ra,0xffffb
    8000576c:	6e8080e7          	jalr	1768(ra) # 80000e50 <kmemmove>
	superblock->magic = XV6_MAGIC;
    80005770:	102037b7          	lui	a5,0x10203
    80005774:	04078793          	addi	a5,a5,64 # 10203040 <_entry-0x6fdfcfc0>
    80005778:	c89c                	sw	a5,16(s1)
	superblock->block_size = XV6_BLOCK_SIZE;
    8000577a:	40000793          	li	a5,1024
    8000577e:	c0dc                	sw	a5,4(s1)
	superblock->device = dev;
    80005780:	01349023          	sh	s3,0(s1)
	superblock->size = superblock->xv6_superblock.size;
    80005784:	4cdc                	lw	a5,28(s1)
    80005786:	c8dc                	sw	a5,20(s1)
	superblock->vfs_ops = &xv6_vfs_ops;
    80005788:	00005997          	auipc	s3,0x5
    8000578c:	c8098993          	addi	s3,s3,-896 # 8000a408 <xv6_vfs_ops>
    80005790:	0134b423          	sd	s3,8(s1)
	kmemmove(&sb, superblock, sizeof(struct superblock));
    80005794:	1e000613          	li	a2,480
    80005798:	85a6                	mv	a1,s1
    8000579a:	0001c517          	auipc	a0,0x1c
    8000579e:	00e50513          	addi	a0,a0,14 # 800217a8 <sb>
    800057a2:	ffffb097          	auipc	ra,0xffffb
    800057a6:	6ae080e7          	jalr	1710(ra) # 80000e50 <kmemmove>
	kmemmove(&sb.xv6_superblock, &superblock->xv6_superblock, sizeof(struct xv6_superblock));
    800057aa:	02000613          	li	a2,32
    800057ae:	85d2                	mv	a1,s4
    800057b0:	0001c517          	auipc	a0,0x1c
    800057b4:	01050513          	addi	a0,a0,16 # 800217c0 <sb+0x18>
    800057b8:	ffffb097          	auipc	ra,0xffffb
    800057bc:	698080e7          	jalr	1688(ra) # 80000e50 <kmemmove>
	xv6_vfs_ops.brelease(buffer);
    800057c0:	0309b783          	ld	a5,48(s3)
    800057c4:	854a                	mv	a0,s2
    800057c6:	9782                	jalr	a5
	initlock(&xv6_active_inodes.lock, "xv6_inode_pool");
    800057c8:	00004597          	auipc	a1,0x4
    800057cc:	01058593          	addi	a1,a1,16 # 800097d8 <syscalls+0x400>
    800057d0:	00022517          	auipc	a0,0x22
    800057d4:	83050513          	addi	a0,a0,-2000 # 80027000 <xv6_active_inodes>
    800057d8:	ffffb097          	auipc	ra,0xffffb
    800057dc:	490080e7          	jalr	1168(ra) # 80000c68 <initlock>
	for(uint i = 0; i < NINODE; i++) {
    800057e0:	00022497          	auipc	s1,0x22
    800057e4:	84848493          	addi	s1,s1,-1976 # 80027028 <xv6_active_inodes+0x28>
    800057e8:	00023997          	auipc	s3,0x23
    800057ec:	14098993          	addi	s3,s3,320 # 80028928 <xv6_active_inodes+0x1928>
		initsleeplock(&xv6_active_inodes.inodes[i].lock, "xv6_inodes");
    800057f0:	00004917          	auipc	s2,0x4
    800057f4:	ff890913          	addi	s2,s2,-8 # 800097e8 <syscalls+0x410>
    800057f8:	85ca                	mv	a1,s2
    800057fa:	8526                	mv	a0,s1
    800057fc:	ffffe097          	auipc	ra,0xffffe
    80005800:	04c080e7          	jalr	76(ra) # 80003848 <initsleeplock>
	for(uint i = 0; i < NINODE; i++) {
    80005804:	08048493          	addi	s1,s1,128
    80005808:	ff3498e3          	bne	s1,s3,800057f8 <xv6_read_super+0xce>
	return XV6_MAGIC;
    8000580c:	10203537          	lui	a0,0x10203
    80005810:	04050513          	addi	a0,a0,64 # 10203040 <_entry-0x6fdfcfc0>
}
    80005814:	70a2                	ld	ra,40(sp)
    80005816:	7402                	ld	s0,32(sp)
    80005818:	64e2                	ld	s1,24(sp)
    8000581a:	6942                	ld	s2,16(sp)
    8000581c:	69a2                	ld	s3,8(sp)
    8000581e:	6a02                	ld	s4,0(sp)
    80005820:	6145                	addi	sp,sp,48
    80005822:	8082                	ret
		xv6_vfs_ops.brelease(buffer);
    80005824:	00005797          	auipc	a5,0x5
    80005828:	c147b783          	ld	a5,-1004(a5) # 8000a438 <xv6_vfs_ops+0x30>
    8000582c:	9782                	jalr	a5
		return -1;
    8000582e:	557d                	li	a0,-1
    80005830:	b7d5                	j	80005814 <xv6_read_super+0xea>

0000000080005832 <xv6_idup>:
{
    80005832:	1101                	addi	sp,sp,-32
    80005834:	ec06                	sd	ra,24(sp)
    80005836:	e822                	sd	s0,16(sp)
    80005838:	e426                	sd	s1,8(sp)
    8000583a:	1000                	addi	s0,sp,32
    8000583c:	84aa                	mv	s1,a0
	acquire(&itable.lock);
    8000583e:	0001c517          	auipc	a0,0x1c
    80005842:	14a50513          	addi	a0,a0,330 # 80021988 <itable>
    80005846:	ffffb097          	auipc	ra,0xffffb
    8000584a:	4b2080e7          	jalr	1202(ra) # 80000cf8 <acquire>
	ip->ref++;
    8000584e:	449c                	lw	a5,8(s1)
    80005850:	2785                	addiw	a5,a5,1
    80005852:	c49c                	sw	a5,8(s1)
	release(&itable.lock);
    80005854:	0001c517          	auipc	a0,0x1c
    80005858:	13450513          	addi	a0,a0,308 # 80021988 <itable>
    8000585c:	ffffb097          	auipc	ra,0xffffb
    80005860:	550080e7          	jalr	1360(ra) # 80000dac <release>
}
    80005864:	8526                	mv	a0,s1
    80005866:	60e2                	ld	ra,24(sp)
    80005868:	6442                	ld	s0,16(sp)
    8000586a:	64a2                	ld	s1,8(sp)
    8000586c:	6105                	addi	sp,sp,32
    8000586e:	8082                	ret

0000000080005870 <xv6_balloc>:
{
    80005870:	711d                	addi	sp,sp,-96
    80005872:	ec86                	sd	ra,88(sp)
    80005874:	e8a2                	sd	s0,80(sp)
    80005876:	e4a6                	sd	s1,72(sp)
    80005878:	e0ca                	sd	s2,64(sp)
    8000587a:	fc4e                	sd	s3,56(sp)
    8000587c:	f852                	sd	s4,48(sp)
    8000587e:	f456                	sd	s5,40(sp)
    80005880:	f05a                	sd	s6,32(sp)
    80005882:	ec5e                	sd	s7,24(sp)
    80005884:	e862                	sd	s8,16(sp)
    80005886:	e466                	sd	s9,8(sp)
    80005888:	e06a                	sd	s10,0(sp)
    8000588a:	1080                	addi	s0,sp,96
	for(b = 0; b < sb.size; b += XV6_BPB) {
    8000588c:	0001c797          	auipc	a5,0x1c
    80005890:	f307a783          	lw	a5,-208(a5) # 800217bc <sb+0x14>
    80005894:	cbd1                	beqz	a5,80005928 <xv6_balloc+0xb8>
    80005896:	8baa                	mv	s7,a0
    80005898:	4a81                	li	s5,0
		bp = xv6_vfs_ops.bread(dev, XV6_BBLOCK(b, sb));
    8000589a:	0001cb17          	auipc	s6,0x1c
    8000589e:	f0eb0b13          	addi	s6,s6,-242 # 800217a8 <sb>
    800058a2:	00005c17          	auipc	s8,0x5
    800058a6:	b66c0c13          	addi	s8,s8,-1178 # 8000a408 <xv6_vfs_ops>
		for(bi = 0; bi < XV6_BPB && b + bi < sb.size; bi++) {
    800058aa:	4c81                	li	s9,0
			m = 1 << (bi % 8);
    800058ac:	4985                	li	s3,1
		for(bi = 0; bi < XV6_BPB && b + bi < sb.size; bi++) {
    800058ae:	6a09                	lui	s4,0x2
	for(b = 0; b < sb.size; b += XV6_BPB) {
    800058b0:	6d09                	lui	s10,0x2
    800058b2:	a829                	j	800058cc <xv6_balloc+0x5c>
		xv6_vfs_ops.brelease(bp);
    800058b4:	030c3783          	ld	a5,48(s8)
    800058b8:	854a                	mv	a0,s2
    800058ba:	9782                	jalr	a5
	for(b = 0; b < sb.size; b += XV6_BPB) {
    800058bc:	015d07bb          	addw	a5,s10,s5
    800058c0:	00078a9b          	sext.w	s5,a5
    800058c4:	014b2703          	lw	a4,20(s6)
    800058c8:	06eaf063          	bgeu	s5,a4,80005928 <xv6_balloc+0xb8>
		bp = xv6_vfs_ops.bread(dev, XV6_BBLOCK(b, sb));
    800058cc:	41fad79b          	sraiw	a5,s5,0x1f
    800058d0:	0137d79b          	srliw	a5,a5,0x13
    800058d4:	015787bb          	addw	a5,a5,s5
    800058d8:	40d7d79b          	sraiw	a5,a5,0xd
    800058dc:	034b2583          	lw	a1,52(s6)
    800058e0:	040c3703          	ld	a4,64(s8)
    800058e4:	9dbd                	addw	a1,a1,a5
    800058e6:	855e                	mv	a0,s7
    800058e8:	9702                	jalr	a4
    800058ea:	892a                	mv	s2,a0
		for(bi = 0; bi < XV6_BPB && b + bi < sb.size; bi++) {
    800058ec:	014b2503          	lw	a0,20(s6)
    800058f0:	000a849b          	sext.w	s1,s5
    800058f4:	8766                	mv	a4,s9
    800058f6:	faa4ffe3          	bgeu	s1,a0,800058b4 <xv6_balloc+0x44>
			m = 1 << (bi % 8);
    800058fa:	00777693          	andi	a3,a4,7
    800058fe:	00d996bb          	sllw	a3,s3,a3
			if((bp->data[bi / 8] & m) == 0) {	// Is block free?
    80005902:	41f7579b          	sraiw	a5,a4,0x1f
    80005906:	01d7d79b          	srliw	a5,a5,0x1d
    8000590a:	9fb9                	addw	a5,a5,a4
    8000590c:	4037d79b          	sraiw	a5,a5,0x3
    80005910:	00f90633          	add	a2,s2,a5
    80005914:	05864603          	lbu	a2,88(a2)
    80005918:	00c6f5b3          	and	a1,a3,a2
    8000591c:	cd91                	beqz	a1,80005938 <xv6_balloc+0xc8>
		for(bi = 0; bi < XV6_BPB && b + bi < sb.size; bi++) {
    8000591e:	2705                	addiw	a4,a4,1
    80005920:	2485                	addiw	s1,s1,1
    80005922:	fd471ae3          	bne	a4,s4,800058f6 <xv6_balloc+0x86>
    80005926:	b779                	j	800058b4 <xv6_balloc+0x44>
	panic("balloc: out of blocks");
    80005928:	00004517          	auipc	a0,0x4
    8000592c:	ed050513          	addi	a0,a0,-304 # 800097f8 <syscalls+0x420>
    80005930:	ffffb097          	auipc	ra,0xffffb
    80005934:	d32080e7          	jalr	-718(ra) # 80000662 <panic>
				bp->data[bi / 8] |= m;	// Mark block in use.
    80005938:	97ca                	add	a5,a5,s2
    8000593a:	8e55                	or	a2,a2,a3
    8000593c:	04c78c23          	sb	a2,88(a5)
				log_write(bp);
    80005940:	854a                	mv	a0,s2
    80005942:	ffffe097          	auipc	ra,0xffffe
    80005946:	e22080e7          	jalr	-478(ra) # 80003764 <log_write>
				xv6_vfs_ops.brelease(bp);
    8000594a:	00005997          	auipc	s3,0x5
    8000594e:	abe98993          	addi	s3,s3,-1346 # 8000a408 <xv6_vfs_ops>
    80005952:	0309b783          	ld	a5,48(s3)
    80005956:	854a                	mv	a0,s2
    80005958:	9782                	jalr	a5
				xv6_vfs_ops.bzero(dev, b + bi);
    8000595a:	0209b783          	ld	a5,32(s3)
    8000595e:	85a6                	mv	a1,s1
    80005960:	855e                	mv	a0,s7
    80005962:	9782                	jalr	a5
}
    80005964:	8526                	mv	a0,s1
    80005966:	60e6                	ld	ra,88(sp)
    80005968:	6446                	ld	s0,80(sp)
    8000596a:	64a6                	ld	s1,72(sp)
    8000596c:	6906                	ld	s2,64(sp)
    8000596e:	79e2                	ld	s3,56(sp)
    80005970:	7a42                	ld	s4,48(sp)
    80005972:	7aa2                	ld	s5,40(sp)
    80005974:	7b02                	ld	s6,32(sp)
    80005976:	6be2                	ld	s7,24(sp)
    80005978:	6c42                	ld	s8,16(sp)
    8000597a:	6ca2                	ld	s9,8(sp)
    8000597c:	6d02                	ld	s10,0(sp)
    8000597e:	6125                	addi	sp,sp,96
    80005980:	8082                	ret

0000000080005982 <xv6_bzero>:
{
    80005982:	1101                	addi	sp,sp,-32
    80005984:	ec06                	sd	ra,24(sp)
    80005986:	e822                	sd	s0,16(sp)
    80005988:	e426                	sd	s1,8(sp)
    8000598a:	e04a                	sd	s2,0(sp)
    8000598c:	1000                	addi	s0,sp,32
	bp = xv6_vfs_ops.bread(dev, block_num);
    8000598e:	00005917          	auipc	s2,0x5
    80005992:	a7a90913          	addi	s2,s2,-1414 # 8000a408 <xv6_vfs_ops>
    80005996:	04093783          	ld	a5,64(s2)
    8000599a:	9782                	jalr	a5
    8000599c:	84aa                	mv	s1,a0
	kmemset(bp->data, 0, XV6_BLOCK_SIZE);
    8000599e:	40000613          	li	a2,1024
    800059a2:	4581                	li	a1,0
    800059a4:	05850513          	addi	a0,a0,88
    800059a8:	ffffb097          	auipc	ra,0xffffb
    800059ac:	44c080e7          	jalr	1100(ra) # 80000df4 <kmemset>
	log_write(bp);
    800059b0:	8526                	mv	a0,s1
    800059b2:	ffffe097          	auipc	ra,0xffffe
    800059b6:	db2080e7          	jalr	-590(ra) # 80003764 <log_write>
	xv6_vfs_ops.brelease(bp);
    800059ba:	03093783          	ld	a5,48(s2)
    800059be:	8526                	mv	a0,s1
    800059c0:	9782                	jalr	a5
}
    800059c2:	60e2                	ld	ra,24(sp)
    800059c4:	6442                	ld	s0,16(sp)
    800059c6:	64a2                	ld	s1,8(sp)
    800059c8:	6902                	ld	s2,0(sp)
    800059ca:	6105                	addi	sp,sp,32
    800059cc:	8082                	ret

00000000800059ce <xv6_bfree>:
{
    800059ce:	1101                	addi	sp,sp,-32
    800059d0:	ec06                	sd	ra,24(sp)
    800059d2:	e822                	sd	s0,16(sp)
    800059d4:	e426                	sd	s1,8(sp)
    800059d6:	e04a                	sd	s2,0(sp)
    800059d8:	1000                	addi	s0,sp,32
    800059da:	84ae                	mv	s1,a1
	bp = xv6_vfs_ops.bread(dev, XV6_BBLOCK(block_num, sb));
    800059dc:	00d5d59b          	srliw	a1,a1,0xd
    800059e0:	0001c797          	auipc	a5,0x1c
    800059e4:	dfc7a783          	lw	a5,-516(a5) # 800217dc <sb+0x34>
    800059e8:	9dbd                	addw	a1,a1,a5
    800059ea:	00005797          	auipc	a5,0x5
    800059ee:	a5e7b783          	ld	a5,-1442(a5) # 8000a448 <xv6_vfs_ops+0x40>
    800059f2:	9782                	jalr	a5
	m = 1 << (bi % 8);
    800059f4:	0074f713          	andi	a4,s1,7
    800059f8:	4785                	li	a5,1
    800059fa:	00e797bb          	sllw	a5,a5,a4
	if((bp->data[bi / 8] & m) == 0) {
    800059fe:	14ce                	slli	s1,s1,0x33
    80005a00:	90d9                	srli	s1,s1,0x36
    80005a02:	00950733          	add	a4,a0,s1
    80005a06:	05874703          	lbu	a4,88(a4)
    80005a0a:	00e7f6b3          	and	a3,a5,a4
    80005a0e:	ca85                	beqz	a3,80005a3e <xv6_bfree+0x70>
    80005a10:	892a                	mv	s2,a0
	bp->data[bi / 8] &= ~m;
    80005a12:	94aa                	add	s1,s1,a0
    80005a14:	fff7c793          	not	a5,a5
    80005a18:	8f7d                	and	a4,a4,a5
    80005a1a:	04e48c23          	sb	a4,88(s1)
	log_write(bp);
    80005a1e:	ffffe097          	auipc	ra,0xffffe
    80005a22:	d46080e7          	jalr	-698(ra) # 80003764 <log_write>
	xv6_vfs_ops.brelease(bp);
    80005a26:	854a                	mv	a0,s2
    80005a28:	00005797          	auipc	a5,0x5
    80005a2c:	a107b783          	ld	a5,-1520(a5) # 8000a438 <xv6_vfs_ops+0x30>
    80005a30:	9782                	jalr	a5
}
    80005a32:	60e2                	ld	ra,24(sp)
    80005a34:	6442                	ld	s0,16(sp)
    80005a36:	64a2                	ld	s1,8(sp)
    80005a38:	6902                	ld	s2,0(sp)
    80005a3a:	6105                	addi	sp,sp,32
    80005a3c:	8082                	ret
		panic("freeing free block");
    80005a3e:	00004517          	auipc	a0,0x4
    80005a42:	dd250513          	addi	a0,a0,-558 # 80009810 <syscalls+0x438>
    80005a46:	ffffb097          	auipc	ra,0xffffb
    80005a4a:	c1c080e7          	jalr	-996(ra) # 80000662 <panic>

0000000080005a4e <xv6_iupdate>:
{
    80005a4e:	7179                	addi	sp,sp,-48
    80005a50:	f406                	sd	ra,40(sp)
    80005a52:	f022                	sd	s0,32(sp)
    80005a54:	ec26                	sd	s1,24(sp)
    80005a56:	e84a                	sd	s2,16(sp)
    80005a58:	e44e                	sd	s3,8(sp)
    80005a5a:	1800                	addi	s0,sp,48
    80005a5c:	84aa                	mv	s1,a0
	bp = xv6_vfs_ops.bread(ip->dev, XV6_IBLOCK(ip->inum, sb));
    80005a5e:	415c                	lw	a5,4(a0)
    80005a60:	0047d79b          	srliw	a5,a5,0x4
    80005a64:	0001c597          	auipc	a1,0x1c
    80005a68:	d745a583          	lw	a1,-652(a1) # 800217d8 <sb+0x30>
    80005a6c:	00005997          	auipc	s3,0x5
    80005a70:	99c98993          	addi	s3,s3,-1636 # 8000a408 <xv6_vfs_ops>
    80005a74:	0409b703          	ld	a4,64(s3)
    80005a78:	9dbd                	addw	a1,a1,a5
    80005a7a:	4108                	lw	a0,0(a0)
    80005a7c:	9702                	jalr	a4
    80005a7e:	892a                	mv	s2,a0
	dip = (struct xv6_dinode *)bp->data + ip->inum % XV6_IPB;
    80005a80:	05850793          	addi	a5,a0,88
    80005a84:	40d8                	lw	a4,4(s1)
    80005a86:	8b3d                	andi	a4,a4,15
    80005a88:	071a                	slli	a4,a4,0x6
    80005a8a:	97ba                	add	a5,a5,a4
	dip->type = ip->type;
    80005a8c:	02849703          	lh	a4,40(s1)
    80005a90:	00e79023          	sh	a4,0(a5)
	dip->major = ip->major;
    80005a94:	02a49703          	lh	a4,42(s1)
    80005a98:	00e79123          	sh	a4,2(a5)
	dip->minor = ip->minor;
    80005a9c:	02c49703          	lh	a4,44(s1)
    80005aa0:	00e79223          	sh	a4,4(a5)
	dip->nlink = ip->nlink;
    80005aa4:	02e49703          	lh	a4,46(s1)
    80005aa8:	00e79323          	sh	a4,6(a5)
	dip->size = ip->size;
    80005aac:	5898                	lw	a4,48(s1)
    80005aae:	c798                	sw	a4,8(a5)
	kmemmove(dip->addrs, ip->xv6_inode->addrs, sizeof(ip->xv6_inode->addrs));
    80005ab0:	708c                	ld	a1,32(s1)
    80005ab2:	03400613          	li	a2,52
    80005ab6:	04c58593          	addi	a1,a1,76
    80005aba:	00c78513          	addi	a0,a5,12
    80005abe:	ffffb097          	auipc	ra,0xffffb
    80005ac2:	392080e7          	jalr	914(ra) # 80000e50 <kmemmove>
	log_write(bp);
    80005ac6:	854a                	mv	a0,s2
    80005ac8:	ffffe097          	auipc	ra,0xffffe
    80005acc:	c9c080e7          	jalr	-868(ra) # 80003764 <log_write>
	xv6_vfs_ops.brelease(bp);
    80005ad0:	0309b783          	ld	a5,48(s3)
    80005ad4:	854a                	mv	a0,s2
    80005ad6:	9782                	jalr	a5
}
    80005ad8:	70a2                	ld	ra,40(sp)
    80005ada:	7402                	ld	s0,32(sp)
    80005adc:	64e2                	ld	s1,24(sp)
    80005ade:	6942                	ld	s2,16(sp)
    80005ae0:	69a2                	ld	s3,8(sp)
    80005ae2:	6145                	addi	sp,sp,48
    80005ae4:	8082                	ret

0000000080005ae6 <xv6_bmap>:
{
    80005ae6:	7179                	addi	sp,sp,-48
    80005ae8:	f406                	sd	ra,40(sp)
    80005aea:	f022                	sd	s0,32(sp)
    80005aec:	ec26                	sd	s1,24(sp)
    80005aee:	e84a                	sd	s2,16(sp)
    80005af0:	e44e                	sd	s3,8(sp)
    80005af2:	e052                	sd	s4,0(sp)
    80005af4:	1800                	addi	s0,sp,48
    80005af6:	8a2a                	mv	s4,a0
    80005af8:	84ae                	mv	s1,a1
	if(bn < NDIRECT) {
    80005afa:	47ad                	li	a5,11
    80005afc:	08b7fa63          	bgeu	a5,a1,80005b90 <xv6_bmap+0xaa>
	bn -= NDIRECT;
    80005b00:	ff45849b          	addiw	s1,a1,-12
    80005b04:	0004871b          	sext.w	a4,s1
	if(bn < NINDIRECT) {
    80005b08:	0ff00793          	li	a5,255
    80005b0c:	0ae7ee63          	bltu	a5,a4,80005bc8 <xv6_bmap+0xe2>
		if((addr = ip->xv6_inode->addrs[NDIRECT]) == 0) {
    80005b10:	711c                	ld	a5,32(a0)
    80005b12:	5fec                	lw	a1,124(a5)
    80005b14:	ed81                	bnez	a1,80005b2c <xv6_bmap+0x46>
			ip->xv6_inode->addrs[NDIRECT] = addr = xv6_vfs_ops.balloc(ip->dev);
    80005b16:	4108                	lw	a0,0(a0)
    80005b18:	00005797          	auipc	a5,0x5
    80005b1c:	9087b783          	ld	a5,-1784(a5) # 8000a420 <xv6_vfs_ops+0x18>
    80005b20:	9782                	jalr	a5
    80005b22:	0005059b          	sext.w	a1,a0
    80005b26:	020a3783          	ld	a5,32(s4) # 2020 <_entry-0x7fffdfe0>
    80005b2a:	dfec                	sw	a1,124(a5)
		bp = xv6_vfs_ops.bread(ip->dev, addr);
    80005b2c:	000a2503          	lw	a0,0(s4)
    80005b30:	00005797          	auipc	a5,0x5
    80005b34:	9187b783          	ld	a5,-1768(a5) # 8000a448 <xv6_vfs_ops+0x40>
    80005b38:	9782                	jalr	a5
    80005b3a:	89aa                	mv	s3,a0
		a = (uint *)bp->data;
    80005b3c:	05850793          	addi	a5,a0,88
		if((addr = a[bn]) == 0) {
    80005b40:	02049713          	slli	a4,s1,0x20
    80005b44:	01e75493          	srli	s1,a4,0x1e
    80005b48:	94be                	add	s1,s1,a5
    80005b4a:	0004a903          	lw	s2,0(s1)
    80005b4e:	02091263          	bnez	s2,80005b72 <xv6_bmap+0x8c>
			a[bn] = addr = xv6_vfs_ops.balloc(ip->dev);
    80005b52:	000a2503          	lw	a0,0(s4)
    80005b56:	00005797          	auipc	a5,0x5
    80005b5a:	8ca7b783          	ld	a5,-1846(a5) # 8000a420 <xv6_vfs_ops+0x18>
    80005b5e:	9782                	jalr	a5
    80005b60:	0005091b          	sext.w	s2,a0
    80005b64:	0124a023          	sw	s2,0(s1)
			log_write(bp);
    80005b68:	854e                	mv	a0,s3
    80005b6a:	ffffe097          	auipc	ra,0xffffe
    80005b6e:	bfa080e7          	jalr	-1030(ra) # 80003764 <log_write>
		xv6_vfs_ops.brelease(bp);
    80005b72:	854e                	mv	a0,s3
    80005b74:	00005797          	auipc	a5,0x5
    80005b78:	8c47b783          	ld	a5,-1852(a5) # 8000a438 <xv6_vfs_ops+0x30>
    80005b7c:	9782                	jalr	a5
}
    80005b7e:	854a                	mv	a0,s2
    80005b80:	70a2                	ld	ra,40(sp)
    80005b82:	7402                	ld	s0,32(sp)
    80005b84:	64e2                	ld	s1,24(sp)
    80005b86:	6942                	ld	s2,16(sp)
    80005b88:	69a2                	ld	s3,8(sp)
    80005b8a:	6a02                	ld	s4,0(sp)
    80005b8c:	6145                	addi	sp,sp,48
    80005b8e:	8082                	ret
		if((addr = ip->xv6_inode->addrs[bn]) == 0) {
    80005b90:	711c                	ld	a5,32(a0)
    80005b92:	02059693          	slli	a3,a1,0x20
    80005b96:	01e6d713          	srli	a4,a3,0x1e
    80005b9a:	97ba                	add	a5,a5,a4
    80005b9c:	04c7a903          	lw	s2,76(a5)
    80005ba0:	fc091fe3          	bnez	s2,80005b7e <xv6_bmap+0x98>
			ip->xv6_inode->addrs[bn] = addr = xv6_vfs_ops.balloc(ip->dev);
    80005ba4:	4108                	lw	a0,0(a0)
    80005ba6:	00005797          	auipc	a5,0x5
    80005baa:	87a7b783          	ld	a5,-1926(a5) # 8000a420 <xv6_vfs_ops+0x18>
    80005bae:	9782                	jalr	a5
    80005bb0:	0005091b          	sext.w	s2,a0
    80005bb4:	020a3783          	ld	a5,32(s4)
    80005bb8:	02049713          	slli	a4,s1,0x20
    80005bbc:	01e75493          	srli	s1,a4,0x1e
    80005bc0:	97a6                	add	a5,a5,s1
    80005bc2:	0527a623          	sw	s2,76(a5)
    80005bc6:	bf65                	j	80005b7e <xv6_bmap+0x98>
	panic("bmap: out of range");
    80005bc8:	00004517          	auipc	a0,0x4
    80005bcc:	c6050513          	addi	a0,a0,-928 # 80009828 <syscalls+0x450>
    80005bd0:	ffffb097          	auipc	ra,0xffffb
    80005bd4:	a92080e7          	jalr	-1390(ra) # 80000662 <panic>

0000000080005bd8 <xv6_name_cmp>:
{
    80005bd8:	1141                	addi	sp,sp,-16
    80005bda:	e406                	sd	ra,8(sp)
    80005bdc:	e022                	sd	s0,0(sp)
    80005bde:	0800                	addi	s0,sp,16
	return kstrncmp(source, dest, DIRSIZ);
    80005be0:	4639                	li	a2,14
    80005be2:	ffffb097          	auipc	ra,0xffffb
    80005be6:	2e2080e7          	jalr	738(ra) # 80000ec4 <kstrncmp>
}
    80005bea:	60a2                	ld	ra,8(sp)
    80005bec:	6402                	ld	s0,0(sp)
    80005bee:	0141                	addi	sp,sp,16
    80005bf0:	8082                	ret

0000000080005bf2 <xv6_ilock>:
{
    80005bf2:	7179                	addi	sp,sp,-48
    80005bf4:	f406                	sd	ra,40(sp)
    80005bf6:	f022                	sd	s0,32(sp)
    80005bf8:	ec26                	sd	s1,24(sp)
    80005bfa:	e84a                	sd	s2,16(sp)
    80005bfc:	e44e                	sd	s3,8(sp)
    80005bfe:	1800                	addi	s0,sp,48
	if(ip == 0 || ip->ref < 1) {
    80005c00:	c15d                	beqz	a0,80005ca6 <xv6_ilock+0xb4>
    80005c02:	84aa                	mv	s1,a0
    80005c04:	451c                	lw	a5,8(a0)
    80005c06:	0af05063          	blez	a5,80005ca6 <xv6_ilock+0xb4>
	acquiresleep(&ip->xv6_inode->lock);
    80005c0a:	7108                	ld	a0,32(a0)
    80005c0c:	0541                	addi	a0,a0,16
    80005c0e:	ffffe097          	auipc	ra,0xffffe
    80005c12:	c74080e7          	jalr	-908(ra) # 80003882 <acquiresleep>
	if(!(ip->flags & I_VALID)) {
    80005c16:	44dc                	lw	a5,12(s1)
    80005c18:	8b89                	andi	a5,a5,2
    80005c1a:	efbd                	bnez	a5,80005c98 <xv6_ilock+0xa6>
		bp = xv6_vfs_ops.bread(ip->dev, XV6_IBLOCK(ip->inum, sb));
    80005c1c:	40dc                	lw	a5,4(s1)
    80005c1e:	0047d79b          	srliw	a5,a5,0x4
    80005c22:	0001c597          	auipc	a1,0x1c
    80005c26:	bb65a583          	lw	a1,-1098(a1) # 800217d8 <sb+0x30>
    80005c2a:	00004997          	auipc	s3,0x4
    80005c2e:	7de98993          	addi	s3,s3,2014 # 8000a408 <xv6_vfs_ops>
    80005c32:	0409b703          	ld	a4,64(s3)
    80005c36:	9dbd                	addw	a1,a1,a5
    80005c38:	4088                	lw	a0,0(s1)
    80005c3a:	9702                	jalr	a4
    80005c3c:	892a                	mv	s2,a0
		dip = (struct xv6_dinode *) bp->data + ip->inum % XV6_IPB;
    80005c3e:	05850593          	addi	a1,a0,88
    80005c42:	40dc                	lw	a5,4(s1)
    80005c44:	8bbd                	andi	a5,a5,15
    80005c46:	079a                	slli	a5,a5,0x6
    80005c48:	95be                	add	a1,a1,a5
		ip->type = dip->type;
    80005c4a:	00059783          	lh	a5,0(a1)
    80005c4e:	02f49423          	sh	a5,40(s1)
		ip->major = dip->major;
    80005c52:	00259783          	lh	a5,2(a1)
    80005c56:	02f49523          	sh	a5,42(s1)
		ip->minor = dip->minor;
    80005c5a:	00459783          	lh	a5,4(a1)
    80005c5e:	02f49623          	sh	a5,44(s1)
		ip->nlink = dip->nlink;
    80005c62:	00659783          	lh	a5,6(a1)
    80005c66:	02f49723          	sh	a5,46(s1)
		ip->size = dip->size;
    80005c6a:	459c                	lw	a5,8(a1)
    80005c6c:	d89c                	sw	a5,48(s1)
		kmemmove(ip->xv6_inode->addrs, dip->addrs, sizeof(ip->xv6_inode->addrs));
    80005c6e:	7088                	ld	a0,32(s1)
    80005c70:	03400613          	li	a2,52
    80005c74:	05b1                	addi	a1,a1,12
    80005c76:	04c50513          	addi	a0,a0,76
    80005c7a:	ffffb097          	auipc	ra,0xffffb
    80005c7e:	1d6080e7          	jalr	470(ra) # 80000e50 <kmemmove>
		xv6_vfs_ops.brelease(bp);
    80005c82:	0309b783          	ld	a5,48(s3)
    80005c86:	854a                	mv	a0,s2
    80005c88:	9782                	jalr	a5
		ip->flags |= I_VALID;
    80005c8a:	44dc                	lw	a5,12(s1)
    80005c8c:	0027e793          	ori	a5,a5,2
    80005c90:	c4dc                	sw	a5,12(s1)
		if(ip->type == 0) {
    80005c92:	02849783          	lh	a5,40(s1)
    80005c96:	c385                	beqz	a5,80005cb6 <xv6_ilock+0xc4>
}
    80005c98:	70a2                	ld	ra,40(sp)
    80005c9a:	7402                	ld	s0,32(sp)
    80005c9c:	64e2                	ld	s1,24(sp)
    80005c9e:	6942                	ld	s2,16(sp)
    80005ca0:	69a2                	ld	s3,8(sp)
    80005ca2:	6145                	addi	sp,sp,48
    80005ca4:	8082                	ret
		panic("xv6_ilock()");
    80005ca6:	00004517          	auipc	a0,0x4
    80005caa:	b9a50513          	addi	a0,a0,-1126 # 80009840 <syscalls+0x468>
    80005cae:	ffffb097          	auipc	ra,0xffffb
    80005cb2:	9b4080e7          	jalr	-1612(ra) # 80000662 <panic>
			panic("xv6_ilock(): no type");
    80005cb6:	00004517          	auipc	a0,0x4
    80005cba:	b9a50513          	addi	a0,a0,-1126 # 80009850 <syscalls+0x478>
    80005cbe:	ffffb097          	auipc	ra,0xffffb
    80005cc2:	9a4080e7          	jalr	-1628(ra) # 80000662 <panic>

0000000080005cc6 <xv6_iput>:
{
    80005cc6:	1101                	addi	sp,sp,-32
    80005cc8:	ec06                	sd	ra,24(sp)
    80005cca:	e822                	sd	s0,16(sp)
    80005ccc:	e426                	sd	s1,8(sp)
    80005cce:	e04a                	sd	s2,0(sp)
    80005cd0:	1000                	addi	s0,sp,32
    80005cd2:	84aa                	mv	s1,a0
	acquire(&itable.lock);
    80005cd4:	0001c517          	auipc	a0,0x1c
    80005cd8:	cb450513          	addi	a0,a0,-844 # 80021988 <itable>
    80005cdc:	ffffb097          	auipc	ra,0xffffb
    80005ce0:	01c080e7          	jalr	28(ra) # 80000cf8 <acquire>
	if(ip->ref == 1 && (ip->flags & I_VALID) && ip->nlink == 0) {
    80005ce4:	6498                	ld	a4,8(s1)
    80005ce6:	478d                	li	a5,3
    80005ce8:	1782                	slli	a5,a5,0x20
    80005cea:	17fd                	addi	a5,a5,-1
    80005cec:	8f7d                	and	a4,a4,a5
    80005cee:	4785                	li	a5,1
    80005cf0:	1786                	slli	a5,a5,0x21
    80005cf2:	0785                	addi	a5,a5,1
    80005cf4:	02f70363          	beq	a4,a5,80005d1a <xv6_iput+0x54>
	ip->ref--;
    80005cf8:	449c                	lw	a5,8(s1)
    80005cfa:	37fd                	addiw	a5,a5,-1
    80005cfc:	c49c                	sw	a5,8(s1)
	release(&itable.lock);
    80005cfe:	0001c517          	auipc	a0,0x1c
    80005d02:	c8a50513          	addi	a0,a0,-886 # 80021988 <itable>
    80005d06:	ffffb097          	auipc	ra,0xffffb
    80005d0a:	0a6080e7          	jalr	166(ra) # 80000dac <release>
}
    80005d0e:	60e2                	ld	ra,24(sp)
    80005d10:	6442                	ld	s0,16(sp)
    80005d12:	64a2                	ld	s1,8(sp)
    80005d14:	6902                	ld	s2,0(sp)
    80005d16:	6105                	addi	sp,sp,32
    80005d18:	8082                	ret
	if(ip->ref == 1 && (ip->flags & I_VALID) && ip->nlink == 0) {
    80005d1a:	02e49783          	lh	a5,46(s1)
    80005d1e:	ffe9                	bnez	a5,80005cf8 <xv6_iput+0x32>
		acquiresleep(&ip->xv6_inode->lock);
    80005d20:	7088                	ld	a0,32(s1)
    80005d22:	0541                	addi	a0,a0,16
    80005d24:	ffffe097          	auipc	ra,0xffffe
    80005d28:	b5e080e7          	jalr	-1186(ra) # 80003882 <acquiresleep>
		release(&itable.lock);
    80005d2c:	0001c517          	auipc	a0,0x1c
    80005d30:	c5c50513          	addi	a0,a0,-932 # 80021988 <itable>
    80005d34:	ffffb097          	auipc	ra,0xffffb
    80005d38:	078080e7          	jalr	120(ra) # 80000dac <release>
		xv6_inode_ops.itrunc(ip);
    80005d3c:	00004917          	auipc	s2,0x4
    80005d40:	6cc90913          	addi	s2,s2,1740 # 8000a408 <xv6_vfs_ops>
    80005d44:	06093783          	ld	a5,96(s2)
    80005d48:	8526                	mv	a0,s1
    80005d4a:	9782                	jalr	a5
		ip->type = 0;
    80005d4c:	02049423          	sh	zero,40(s1)
		xv6_inode_ops.iupdate(ip);
    80005d50:	05893783          	ld	a5,88(s2)
    80005d54:	8526                	mv	a0,s1
    80005d56:	9782                	jalr	a5
		ip->flags = 0;
    80005d58:	0004a623          	sw	zero,12(s1)
			if(ip->xv6_inode == &xv6_active_inodes.inodes[i]) {
    80005d5c:	7094                	ld	a3,32(s1)
    80005d5e:	00021717          	auipc	a4,0x21
    80005d62:	2ba70713          	addi	a4,a4,698 # 80027018 <xv6_active_inodes+0x18>
		for(int i = 0; i < NINODE; i++) {
    80005d66:	4781                	li	a5,0
    80005d68:	03200613          	li	a2,50
			if(ip->xv6_inode == &xv6_active_inodes.inodes[i]) {
    80005d6c:	00e68863          	beq	a3,a4,80005d7c <xv6_iput+0xb6>
		for(int i = 0; i < NINODE; i++) {
    80005d70:	2785                	addiw	a5,a5,1
    80005d72:	08070713          	addi	a4,a4,128
    80005d76:	fec79be3          	bne	a5,a2,80005d6c <xv6_iput+0xa6>
    80005d7a:	a829                	j	80005d94 <xv6_iput+0xce>
				xv6_active_inodes.reserved[i] = INODE_FREE;
    80005d7c:	64478793          	addi	a5,a5,1604
    80005d80:	078a                	slli	a5,a5,0x2
    80005d82:	00021717          	auipc	a4,0x21
    80005d86:	27e70713          	addi	a4,a4,638 # 80027000 <xv6_active_inodes>
    80005d8a:	97ba                	add	a5,a5,a4
    80005d8c:	0007a423          	sw	zero,8(a5)
				ip->xv6_inode = NULL;
    80005d90:	0204b023          	sd	zero,32(s1)
		releasesleep(&ip->xv6_inode->lock);
    80005d94:	7088                	ld	a0,32(s1)
    80005d96:	0541                	addi	a0,a0,16
    80005d98:	ffffe097          	auipc	ra,0xffffe
    80005d9c:	b40080e7          	jalr	-1216(ra) # 800038d8 <releasesleep>
		acquire(&itable.lock);
    80005da0:	0001c517          	auipc	a0,0x1c
    80005da4:	be850513          	addi	a0,a0,-1048 # 80021988 <itable>
    80005da8:	ffffb097          	auipc	ra,0xffffb
    80005dac:	f50080e7          	jalr	-176(ra) # 80000cf8 <acquire>
    80005db0:	b7a1                	j	80005cf8 <xv6_iput+0x32>

0000000080005db2 <xv6_iunlock>:
{
    80005db2:	1101                	addi	sp,sp,-32
    80005db4:	ec06                	sd	ra,24(sp)
    80005db6:	e822                	sd	s0,16(sp)
    80005db8:	e426                	sd	s1,8(sp)
    80005dba:	1000                	addi	s0,sp,32
	if(ip == 0 || !holdingsleep(&ip->xv6_inode->lock) || ip->ref < 1)
    80005dbc:	c51d                	beqz	a0,80005dea <xv6_iunlock+0x38>
    80005dbe:	84aa                	mv	s1,a0
    80005dc0:	7108                	ld	a0,32(a0)
    80005dc2:	0541                	addi	a0,a0,16
    80005dc4:	ffffe097          	auipc	ra,0xffffe
    80005dc8:	b58080e7          	jalr	-1192(ra) # 8000391c <holdingsleep>
    80005dcc:	cd19                	beqz	a0,80005dea <xv6_iunlock+0x38>
    80005dce:	449c                	lw	a5,8(s1)
    80005dd0:	00f05d63          	blez	a5,80005dea <xv6_iunlock+0x38>
	releasesleep(&ip->xv6_inode->lock);
    80005dd4:	7088                	ld	a0,32(s1)
    80005dd6:	0541                	addi	a0,a0,16
    80005dd8:	ffffe097          	auipc	ra,0xffffe
    80005ddc:	b00080e7          	jalr	-1280(ra) # 800038d8 <releasesleep>
}
    80005de0:	60e2                	ld	ra,24(sp)
    80005de2:	6442                	ld	s0,16(sp)
    80005de4:	64a2                	ld	s1,8(sp)
    80005de6:	6105                	addi	sp,sp,32
    80005de8:	8082                	ret
		panic("xv6_iunlock()");
    80005dea:	00004517          	auipc	a0,0x4
    80005dee:	a7e50513          	addi	a0,a0,-1410 # 80009868 <syscalls+0x490>
    80005df2:	ffffb097          	auipc	ra,0xffffb
    80005df6:	870080e7          	jalr	-1936(ra) # 80000662 <panic>

0000000080005dfa <xv6_readi>:
// Caller must hold ip->lock.
// If user_dst==1, then dst is a user virtual address;
// otherwise, dst is a kernel address.

int xv6_readi(struct inode *ip, int user_dst, uint64 dst, uint off, uint n)
{
    80005dfa:	7119                	addi	sp,sp,-128
    80005dfc:	fc86                	sd	ra,120(sp)
    80005dfe:	f8a2                	sd	s0,112(sp)
    80005e00:	f4a6                	sd	s1,104(sp)
    80005e02:	f0ca                	sd	s2,96(sp)
    80005e04:	ecce                	sd	s3,88(sp)
    80005e06:	e8d2                	sd	s4,80(sp)
    80005e08:	e4d6                	sd	s5,72(sp)
    80005e0a:	e0da                	sd	s6,64(sp)
    80005e0c:	fc5e                	sd	s7,56(sp)
    80005e0e:	f862                	sd	s8,48(sp)
    80005e10:	f466                	sd	s9,40(sp)
    80005e12:	f06a                	sd	s10,32(sp)
    80005e14:	ec6e                	sd	s11,24(sp)
    80005e16:	0100                	addi	s0,sp,128
    80005e18:	f8b43423          	sd	a1,-120(s0)
	uint tot, m;
	struct buf *bp;

	if(off > ip->size || off + n < off) {
    80005e1c:	591c                	lw	a5,48(a0)
    80005e1e:	0cd7eb63          	bltu	a5,a3,80005ef4 <xv6_readi+0xfa>
    80005e22:	8caa                	mv	s9,a0
    80005e24:	8ab2                	mv	s5,a2
    80005e26:	8936                	mv	s2,a3
    80005e28:	8c3a                	mv	s8,a4
    80005e2a:	9f35                	addw	a4,a4,a3
    80005e2c:	0cd76663          	bltu	a4,a3,80005ef8 <xv6_readi+0xfe>
		return -1;
	}

	if(off + n > ip->size) {
    80005e30:	00e7f463          	bgeu	a5,a4,80005e38 <xv6_readi+0x3e>
		n = ip->size - off;
    80005e34:	40d78c3b          	subw	s8,a5,a3
	}

	for(tot=0; tot<n; tot+=m, off+=m, dst+=m) {
    80005e38:	0a0c0c63          	beqz	s8,80005ef0 <xv6_readi+0xf6>
    80005e3c:	4a01                	li	s4,0
		bp = xv6_vfs_ops.bread(ip->dev, xv6_inode_ops.bmap(ip, off / BSIZE));
    80005e3e:	00004b17          	auipc	s6,0x4
    80005e42:	5cab0b13          	addi	s6,s6,1482 # 8000a408 <xv6_vfs_ops>
		m = min(n - tot, BSIZE - off % BSIZE);
    80005e46:	40000d93          	li	s11,1024

		if(either_copyout(user_dst, dst, bp->data + (off % BSIZE), m) == -1) {
    80005e4a:	5d7d                	li	s10,-1
    80005e4c:	a82d                	j	80005e86 <xv6_readi+0x8c>
    80005e4e:	02099b93          	slli	s7,s3,0x20
    80005e52:	020bdb93          	srli	s7,s7,0x20
    80005e56:	05848613          	addi	a2,s1,88
    80005e5a:	86de                	mv	a3,s7
    80005e5c:	963a                	add	a2,a2,a4
    80005e5e:	85d6                	mv	a1,s5
    80005e60:	f8843503          	ld	a0,-120(s0)
    80005e64:	ffffc097          	auipc	ra,0xffffc
    80005e68:	6f0080e7          	jalr	1776(ra) # 80002554 <either_copyout>
    80005e6c:	05a50a63          	beq	a0,s10,80005ec0 <xv6_readi+0xc6>
			xv6_vfs_ops.brelease(bp);
			tot = -1;
			break;
    	}

		xv6_vfs_ops.brelease(bp);
    80005e70:	030b3783          	ld	a5,48(s6)
    80005e74:	8526                	mv	a0,s1
    80005e76:	9782                	jalr	a5
	for(tot=0; tot<n; tot+=m, off+=m, dst+=m) {
    80005e78:	01498a3b          	addw	s4,s3,s4
    80005e7c:	0129893b          	addw	s2,s3,s2
    80005e80:	9ade                	add	s5,s5,s7
    80005e82:	058a7663          	bgeu	s4,s8,80005ece <xv6_readi+0xd4>
		bp = xv6_vfs_ops.bread(ip->dev, xv6_inode_ops.bmap(ip, off / BSIZE));
    80005e86:	040b3483          	ld	s1,64(s6)
    80005e8a:	000ca983          	lw	s3,0(s9)
    80005e8e:	068b3783          	ld	a5,104(s6)
    80005e92:	00a9559b          	srliw	a1,s2,0xa
    80005e96:	8566                	mv	a0,s9
    80005e98:	9782                	jalr	a5
    80005e9a:	0005059b          	sext.w	a1,a0
    80005e9e:	854e                	mv	a0,s3
    80005ea0:	9482                	jalr	s1
    80005ea2:	84aa                	mv	s1,a0
		m = min(n - tot, BSIZE - off % BSIZE);
    80005ea4:	3ff97713          	andi	a4,s2,1023
    80005ea8:	40ed87bb          	subw	a5,s11,a4
    80005eac:	414c06bb          	subw	a3,s8,s4
    80005eb0:	89be                	mv	s3,a5
    80005eb2:	2781                	sext.w	a5,a5
    80005eb4:	0006861b          	sext.w	a2,a3
    80005eb8:	f8f67be3          	bgeu	a2,a5,80005e4e <xv6_readi+0x54>
    80005ebc:	89b6                	mv	s3,a3
    80005ebe:	bf41                	j	80005e4e <xv6_readi+0x54>
			xv6_vfs_ops.brelease(bp);
    80005ec0:	8526                	mv	a0,s1
    80005ec2:	00004797          	auipc	a5,0x4
    80005ec6:	5767b783          	ld	a5,1398(a5) # 8000a438 <xv6_vfs_ops+0x30>
    80005eca:	9782                	jalr	a5
			tot = -1;
    80005ecc:	5a7d                	li	s4,-1
	}

	return tot;
    80005ece:	000a051b          	sext.w	a0,s4
}
    80005ed2:	70e6                	ld	ra,120(sp)
    80005ed4:	7446                	ld	s0,112(sp)
    80005ed6:	74a6                	ld	s1,104(sp)
    80005ed8:	7906                	ld	s2,96(sp)
    80005eda:	69e6                	ld	s3,88(sp)
    80005edc:	6a46                	ld	s4,80(sp)
    80005ede:	6aa6                	ld	s5,72(sp)
    80005ee0:	6b06                	ld	s6,64(sp)
    80005ee2:	7be2                	ld	s7,56(sp)
    80005ee4:	7c42                	ld	s8,48(sp)
    80005ee6:	7ca2                	ld	s9,40(sp)
    80005ee8:	7d02                	ld	s10,32(sp)
    80005eea:	6de2                	ld	s11,24(sp)
    80005eec:	6109                	addi	sp,sp,128
    80005eee:	8082                	ret
	for(tot=0; tot<n; tot+=m, off+=m, dst+=m) {
    80005ef0:	8a62                	mv	s4,s8
    80005ef2:	bff1                	j	80005ece <xv6_readi+0xd4>
		return -1;
    80005ef4:	557d                	li	a0,-1
    80005ef6:	bff1                	j	80005ed2 <xv6_readi+0xd8>
    80005ef8:	557d                	li	a0,-1
    80005efa:	bfe1                	j	80005ed2 <xv6_readi+0xd8>

0000000080005efc <xv6_writei>:
// Returns the number of bytes successfully written.
// If the return value is less than the requested n,
// there was an error of some kind.

int xv6_writei(struct inode *ip, int user_src, uint64 src, uint off, uint n)
{
    80005efc:	7119                	addi	sp,sp,-128
    80005efe:	fc86                	sd	ra,120(sp)
    80005f00:	f8a2                	sd	s0,112(sp)
    80005f02:	f4a6                	sd	s1,104(sp)
    80005f04:	f0ca                	sd	s2,96(sp)
    80005f06:	ecce                	sd	s3,88(sp)
    80005f08:	e8d2                	sd	s4,80(sp)
    80005f0a:	e4d6                	sd	s5,72(sp)
    80005f0c:	e0da                	sd	s6,64(sp)
    80005f0e:	fc5e                	sd	s7,56(sp)
    80005f10:	f862                	sd	s8,48(sp)
    80005f12:	f466                	sd	s9,40(sp)
    80005f14:	f06a                	sd	s10,32(sp)
    80005f16:	ec6e                	sd	s11,24(sp)
    80005f18:	0100                	addi	s0,sp,128
    80005f1a:	f8b43423          	sd	a1,-120(s0)
	uint tot, m;
	struct buf *bp;

	if(off > ip->size || off + n < off) {
    80005f1e:	591c                	lw	a5,48(a0)
    80005f20:	0ed7ea63          	bltu	a5,a3,80006014 <xv6_writei+0x118>
    80005f24:	8caa                	mv	s9,a0
    80005f26:	8ab2                	mv	s5,a2
    80005f28:	8936                	mv	s2,a3
    80005f2a:	8c3a                	mv	s8,a4
    80005f2c:	00e687bb          	addw	a5,a3,a4
    80005f30:	0ed7e463          	bltu	a5,a3,80006018 <xv6_writei+0x11c>
		return -1;
	}

	if(off + n > MAXFILE * BSIZE) {
    80005f34:	00043737          	lui	a4,0x43
    80005f38:	0ef76263          	bltu	a4,a5,8000601c <xv6_writei+0x120>
		return -1;
	}

	for(tot = 0; tot < n; tot += m, off += m, src += m){
    80005f3c:	0a0c0b63          	beqz	s8,80005ff2 <xv6_writei+0xf6>
    80005f40:	4a01                	li	s4,0
		bp = xv6_vfs_ops.bread(ip->dev, xv6_inode_ops.bmap(ip, off / BSIZE));
    80005f42:	00004b17          	auipc	s6,0x4
    80005f46:	4c6b0b13          	addi	s6,s6,1222 # 8000a408 <xv6_vfs_ops>
		m = min(n - tot, BSIZE - off % BSIZE);
    80005f4a:	40000d93          	li	s11,1024
		if(either_copyin(bp->data + (off % BSIZE), user_src, src, m) == -1) {
    80005f4e:	5d7d                	li	s10,-1
    80005f50:	a091                	j	80005f94 <xv6_writei+0x98>
    80005f52:	02099b93          	slli	s7,s3,0x20
    80005f56:	020bdb93          	srli	s7,s7,0x20
    80005f5a:	05848513          	addi	a0,s1,88
    80005f5e:	86de                	mv	a3,s7
    80005f60:	8656                	mv	a2,s5
    80005f62:	f8843583          	ld	a1,-120(s0)
    80005f66:	953a                	add	a0,a0,a4
    80005f68:	ffffc097          	auipc	ra,0xffffc
    80005f6c:	642080e7          	jalr	1602(ra) # 800025aa <either_copyin>
    80005f70:	05a50f63          	beq	a0,s10,80005fce <xv6_writei+0xd2>
			xv6_vfs_ops.brelease(bp);
			break;
		}
		log_write(bp);
    80005f74:	8526                	mv	a0,s1
    80005f76:	ffffd097          	auipc	ra,0xffffd
    80005f7a:	7ee080e7          	jalr	2030(ra) # 80003764 <log_write>
		xv6_vfs_ops.brelease(bp);
    80005f7e:	030b3783          	ld	a5,48(s6)
    80005f82:	8526                	mv	a0,s1
    80005f84:	9782                	jalr	a5
	for(tot = 0; tot < n; tot += m, off += m, src += m){
    80005f86:	01498a3b          	addw	s4,s3,s4
    80005f8a:	0129893b          	addw	s2,s3,s2
    80005f8e:	9ade                	add	s5,s5,s7
    80005f90:	058a7563          	bgeu	s4,s8,80005fda <xv6_writei+0xde>
		bp = xv6_vfs_ops.bread(ip->dev, xv6_inode_ops.bmap(ip, off / BSIZE));
    80005f94:	040b3483          	ld	s1,64(s6)
    80005f98:	000ca983          	lw	s3,0(s9)
    80005f9c:	068b3783          	ld	a5,104(s6)
    80005fa0:	00a9559b          	srliw	a1,s2,0xa
    80005fa4:	8566                	mv	a0,s9
    80005fa6:	9782                	jalr	a5
    80005fa8:	0005059b          	sext.w	a1,a0
    80005fac:	854e                	mv	a0,s3
    80005fae:	9482                	jalr	s1
    80005fb0:	84aa                	mv	s1,a0
		m = min(n - tot, BSIZE - off % BSIZE);
    80005fb2:	3ff97713          	andi	a4,s2,1023
    80005fb6:	40ed87bb          	subw	a5,s11,a4
    80005fba:	414c06bb          	subw	a3,s8,s4
    80005fbe:	89be                	mv	s3,a5
    80005fc0:	2781                	sext.w	a5,a5
    80005fc2:	0006861b          	sext.w	a2,a3
    80005fc6:	f8f676e3          	bgeu	a2,a5,80005f52 <xv6_writei+0x56>
    80005fca:	89b6                	mv	s3,a3
    80005fcc:	b759                	j	80005f52 <xv6_writei+0x56>
			xv6_vfs_ops.brelease(bp);
    80005fce:	8526                	mv	a0,s1
    80005fd0:	00004797          	auipc	a5,0x4
    80005fd4:	4687b783          	ld	a5,1128(a5) # 8000a438 <xv6_vfs_ops+0x30>
    80005fd8:	9782                	jalr	a5
	}

	if(n > 0 && off > ip->size){
    80005fda:	030ca783          	lw	a5,48(s9)
    80005fde:	0127fa63          	bgeu	a5,s2,80005ff2 <xv6_writei+0xf6>
		ip->size = off;
    80005fe2:	032ca823          	sw	s2,48(s9)
		xv6_inode_ops.iupdate(ip);
    80005fe6:	8566                	mv	a0,s9
    80005fe8:	00004797          	auipc	a5,0x4
    80005fec:	4787b783          	ld	a5,1144(a5) # 8000a460 <xv6_inode_ops+0x8>
    80005ff0:	9782                	jalr	a5
	}

	return n;
    80005ff2:	000c051b          	sext.w	a0,s8
}
    80005ff6:	70e6                	ld	ra,120(sp)
    80005ff8:	7446                	ld	s0,112(sp)
    80005ffa:	74a6                	ld	s1,104(sp)
    80005ffc:	7906                	ld	s2,96(sp)
    80005ffe:	69e6                	ld	s3,88(sp)
    80006000:	6a46                	ld	s4,80(sp)
    80006002:	6aa6                	ld	s5,72(sp)
    80006004:	6b06                	ld	s6,64(sp)
    80006006:	7be2                	ld	s7,56(sp)
    80006008:	7c42                	ld	s8,48(sp)
    8000600a:	7ca2                	ld	s9,40(sp)
    8000600c:	7d02                	ld	s10,32(sp)
    8000600e:	6de2                	ld	s11,24(sp)
    80006010:	6109                	addi	sp,sp,128
    80006012:	8082                	ret
		return -1;
    80006014:	557d                	li	a0,-1
    80006016:	b7c5                	j	80005ff6 <xv6_writei+0xfa>
    80006018:	557d                	li	a0,-1
    8000601a:	bff1                	j	80005ff6 <xv6_writei+0xfa>
		return -1;
    8000601c:	557d                	li	a0,-1
    8000601e:	bfe1                	j	80005ff6 <xv6_writei+0xfa>

0000000080006020 <xv6_dir_link>:

// Write a new directory entry (name, inum) into the directory dp.

int xv6_dir_link(struct inode * dp, char * name, uint inum, uint type)
{
    80006020:	715d                	addi	sp,sp,-80
    80006022:	e486                	sd	ra,72(sp)
    80006024:	e0a2                	sd	s0,64(sp)
    80006026:	fc26                	sd	s1,56(sp)
    80006028:	f84a                	sd	s2,48(sp)
    8000602a:	f44e                	sd	s3,40(sp)
    8000602c:	f052                	sd	s4,32(sp)
    8000602e:	ec56                	sd	s5,24(sp)
    80006030:	0880                	addi	s0,sp,80
    80006032:	892a                	mv	s2,a0
    80006034:	8aae                	mv	s5,a1
    80006036:	8a32                	mv	s4,a2
	int off;
	struct dirent de;
	struct inode * ip;

	// Check that name is not present.
	if((ip = xv6_inode_ops.dir_lookup(dp, name, 0)) != 0) {
    80006038:	4601                	li	a2,0
    8000603a:	00004797          	auipc	a5,0x4
    8000603e:	41e7b783          	ld	a5,1054(a5) # 8000a458 <xv6_inode_ops>
    80006042:	9782                	jalr	a5
    80006044:	e141                	bnez	a0,800060c4 <xv6_dir_link+0xa4>
		xv6_inode_ops.iput(ip);
		return -1;
	}

	// Look for an empty dirent.
	for(off = 0; off < dp->size; off += sizeof(de)) {
    80006046:	03092483          	lw	s1,48(s2)
    8000604a:	c895                	beqz	s1,8000607e <xv6_dir_link+0x5e>
    8000604c:	4481                	li	s1,0
		if(xv6_inode_ops.readi(dp, 0,(uint64)&de, off, sizeof(de)) != sizeof(de)) {
    8000604e:	00004997          	auipc	s3,0x4
    80006052:	3ba98993          	addi	s3,s3,954 # 8000a408 <xv6_vfs_ops>
    80006056:	0a09b783          	ld	a5,160(s3)
    8000605a:	4741                	li	a4,16
    8000605c:	86a6                	mv	a3,s1
    8000605e:	fb040613          	addi	a2,s0,-80
    80006062:	4581                	li	a1,0
    80006064:	854a                	mv	a0,s2
    80006066:	9782                	jalr	a5
    80006068:	47c1                	li	a5,16
    8000606a:	06f51463          	bne	a0,a5,800060d2 <xv6_dir_link+0xb2>
			panic("xv6_dir_link() readi()");
		}

		if(de.inum == 0) {
    8000606e:	fb045783          	lhu	a5,-80(s0)
    80006072:	c791                	beqz	a5,8000607e <xv6_dir_link+0x5e>
	for(off = 0; off < dp->size; off += sizeof(de)) {
    80006074:	24c1                	addiw	s1,s1,16
    80006076:	03092783          	lw	a5,48(s2)
    8000607a:	fcf4eee3          	bltu	s1,a5,80006056 <xv6_dir_link+0x36>
			break;
		}
	}

	kstrncpy(de.name, name, DIRSIZ);
    8000607e:	4639                	li	a2,14
    80006080:	85d6                	mv	a1,s5
    80006082:	fb240513          	addi	a0,s0,-78
    80006086:	ffffb097          	auipc	ra,0xffffb
    8000608a:	e7a080e7          	jalr	-390(ra) # 80000f00 <kstrncpy>
	de.inum = inum;
    8000608e:	fb441823          	sh	s4,-80(s0)

	if(xv6_inode_ops.writei(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de)) {
    80006092:	4741                	li	a4,16
    80006094:	86a6                	mv	a3,s1
    80006096:	fb040613          	addi	a2,s0,-80
    8000609a:	4581                	li	a1,0
    8000609c:	854a                	mv	a0,s2
    8000609e:	00004797          	auipc	a5,0x4
    800060a2:	4127b783          	ld	a5,1042(a5) # 8000a4b0 <xv6_inode_ops+0x58>
    800060a6:	9782                	jalr	a5
    800060a8:	872a                	mv	a4,a0
    800060aa:	47c1                	li	a5,16
		panic("xv6_dir_link() writei()");
	}

	return 0;
    800060ac:	4501                	li	a0,0
	if(xv6_inode_ops.writei(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de)) {
    800060ae:	02f71a63          	bne	a4,a5,800060e2 <xv6_dir_link+0xc2>
}
    800060b2:	60a6                	ld	ra,72(sp)
    800060b4:	6406                	ld	s0,64(sp)
    800060b6:	74e2                	ld	s1,56(sp)
    800060b8:	7942                	ld	s2,48(sp)
    800060ba:	79a2                	ld	s3,40(sp)
    800060bc:	7a02                	ld	s4,32(sp)
    800060be:	6ae2                	ld	s5,24(sp)
    800060c0:	6161                	addi	sp,sp,80
    800060c2:	8082                	ret
		xv6_inode_ops.iput(ip);
    800060c4:	00004797          	auipc	a5,0x4
    800060c8:	3bc7b783          	ld	a5,956(a5) # 8000a480 <xv6_inode_ops+0x28>
    800060cc:	9782                	jalr	a5
		return -1;
    800060ce:	557d                	li	a0,-1
    800060d0:	b7cd                	j	800060b2 <xv6_dir_link+0x92>
			panic("xv6_dir_link() readi()");
    800060d2:	00003517          	auipc	a0,0x3
    800060d6:	7a650513          	addi	a0,a0,1958 # 80009878 <syscalls+0x4a0>
    800060da:	ffffa097          	auipc	ra,0xffffa
    800060de:	588080e7          	jalr	1416(ra) # 80000662 <panic>
		panic("xv6_dir_link() writei()");
    800060e2:	00003517          	auipc	a0,0x3
    800060e6:	7ae50513          	addi	a0,a0,1966 # 80009890 <syscalls+0x4b8>
    800060ea:	ffffa097          	auipc	ra,0xffffa
    800060ee:	578080e7          	jalr	1400(ra) # 80000662 <panic>

00000000800060f2 <xv6_iget>:
{
    800060f2:	7179                	addi	sp,sp,-48
    800060f4:	f406                	sd	ra,40(sp)
    800060f6:	f022                	sd	s0,32(sp)
    800060f8:	ec26                	sd	s1,24(sp)
    800060fa:	e84a                	sd	s2,16(sp)
    800060fc:	e44e                	sd	s3,8(sp)
    800060fe:	e052                	sd	s4,0(sp)
    80006100:	1800                	addi	s0,sp,48
    80006102:	89aa                	mv	s3,a0
    80006104:	8a2e                	mv	s4,a1
	acquire(&itable.lock);
    80006106:	0001c517          	auipc	a0,0x1c
    8000610a:	88250513          	addi	a0,a0,-1918 # 80021988 <itable>
    8000610e:	ffffb097          	auipc	ra,0xffffb
    80006112:	bea080e7          	jalr	-1046(ra) # 80000cf8 <acquire>
	empty = NULL;
    80006116:	4901                	li	s2,0
	for(ip = &itable.inode[0]; ip < &itable.inode[NINODE]; ip++) {
    80006118:	0001c497          	auipc	s1,0x1c
    8000611c:	88848493          	addi	s1,s1,-1912 # 800219a0 <itable+0x18>
    80006120:	0001c697          	auipc	a3,0x1c
    80006124:	37068693          	addi	a3,a3,880 # 80022490 <log>
    80006128:	a039                	j	80006136 <xv6_iget+0x44>
		if(empty == NULL && ip->ref == 0) {
    8000612a:	02090b63          	beqz	s2,80006160 <xv6_iget+0x6e>
	for(ip = &itable.inode[0]; ip < &itable.inode[NINODE]; ip++) {
    8000612e:	03848493          	addi	s1,s1,56
    80006132:	02d48a63          	beq	s1,a3,80006166 <xv6_iget+0x74>
		if(ip->ref > 0 && ip->dev == dev && ip->inum == inum) {
    80006136:	449c                	lw	a5,8(s1)
    80006138:	fef059e3          	blez	a5,8000612a <xv6_iget+0x38>
    8000613c:	4098                	lw	a4,0(s1)
    8000613e:	ff3716e3          	bne	a4,s3,8000612a <xv6_iget+0x38>
    80006142:	40d8                	lw	a4,4(s1)
    80006144:	ff4713e3          	bne	a4,s4,8000612a <xv6_iget+0x38>
			ip->ref++;
    80006148:	2785                	addiw	a5,a5,1
    8000614a:	c49c                	sw	a5,8(s1)
			release(&itable.lock);
    8000614c:	0001c517          	auipc	a0,0x1c
    80006150:	83c50513          	addi	a0,a0,-1988 # 80021988 <itable>
    80006154:	ffffb097          	auipc	ra,0xffffb
    80006158:	c58080e7          	jalr	-936(ra) # 80000dac <release>
			return ip;
    8000615c:	8926                	mv	s2,s1
    8000615e:	a85d                	j	80006214 <xv6_iget+0x122>
		if(empty == NULL && ip->ref == 0) {
    80006160:	f7f9                	bnez	a5,8000612e <xv6_iget+0x3c>
    80006162:	8926                	mv	s2,s1
    80006164:	b7e9                	j	8000612e <xv6_iget+0x3c>
	release(&itable.lock);
    80006166:	0001c517          	auipc	a0,0x1c
    8000616a:	82250513          	addi	a0,a0,-2014 # 80021988 <itable>
    8000616e:	ffffb097          	auipc	ra,0xffffb
    80006172:	c3e080e7          	jalr	-962(ra) # 80000dac <release>
	if(empty == NULL) {
    80006176:	04090b63          	beqz	s2,800061cc <xv6_iget+0xda>
	ip->dev = dev;
    8000617a:	01392023          	sw	s3,0(s2)
	ip->inum = inum;
    8000617e:	01492223          	sw	s4,4(s2)
	ip->ref = 1;
    80006182:	4785                	li	a5,1
    80006184:	00f92423          	sw	a5,8(s2)
	ip->inode_ops = &xv6_inode_ops;
    80006188:	00004797          	auipc	a5,0x4
    8000618c:	2d078793          	addi	a5,a5,720 # 8000a458 <xv6_inode_ops>
    80006190:	00f93823          	sd	a5,16(s2)
	ip->vfs_ops = &xv6_vfs_ops;
    80006194:	00004797          	auipc	a5,0x4
    80006198:	27478793          	addi	a5,a5,628 # 8000a408 <xv6_vfs_ops>
    8000619c:	00f93c23          	sd	a5,24(s2)
	acquire(&xv6_active_inodes.lock);
    800061a0:	00021517          	auipc	a0,0x21
    800061a4:	e6050513          	addi	a0,a0,-416 # 80027000 <xv6_active_inodes>
    800061a8:	ffffb097          	auipc	ra,0xffffb
    800061ac:	b50080e7          	jalr	-1200(ra) # 80000cf8 <acquire>
	for(int i = 0; i < NINODE; i++) {
    800061b0:	00022717          	auipc	a4,0x22
    800061b4:	76870713          	addi	a4,a4,1896 # 80028918 <xv6_active_inodes+0x1918>
    800061b8:	4781                	li	a5,0
    800061ba:	03200613          	li	a2,50
		if(xv6_active_inodes.reserved[i] == INODE_FREE) {
    800061be:	4314                	lw	a3,0(a4)
    800061c0:	ce91                	beqz	a3,800061dc <xv6_iget+0xea>
	for(int i = 0; i < NINODE; i++) {
    800061c2:	2785                	addiw	a5,a5,1
    800061c4:	0711                	addi	a4,a4,4
    800061c6:	fec79ce3          	bne	a5,a2,800061be <xv6_iget+0xcc>
    800061ca:	a805                	j	800061fa <xv6_iget+0x108>
		panic("xv6_iget(): no inodes");
    800061cc:	00003517          	auipc	a0,0x3
    800061d0:	6dc50513          	addi	a0,a0,1756 # 800098a8 <syscalls+0x4d0>
    800061d4:	ffffa097          	auipc	ra,0xffffa
    800061d8:	48e080e7          	jalr	1166(ra) # 80000662 <panic>
			xv6_active_inodes.reserved[i] |= INODE_RESERVED;
    800061dc:	00021697          	auipc	a3,0x21
    800061e0:	e2468693          	addi	a3,a3,-476 # 80027000 <xv6_active_inodes>
    800061e4:	64478713          	addi	a4,a5,1604
    800061e8:	070a                	slli	a4,a4,0x2
    800061ea:	9736                	add	a4,a4,a3
    800061ec:	4605                	li	a2,1
    800061ee:	c710                	sw	a2,8(a4)
			ip->xv6_inode = &xv6_active_inodes.inodes[i];
    800061f0:	079e                	slli	a5,a5,0x7
    800061f2:	07e1                	addi	a5,a5,24
    800061f4:	97b6                	add	a5,a5,a3
    800061f6:	02f93023          	sd	a5,32(s2)
	release(&xv6_active_inodes.lock);
    800061fa:	00021517          	auipc	a0,0x21
    800061fe:	e0650513          	addi	a0,a0,-506 # 80027000 <xv6_active_inodes>
    80006202:	ffffb097          	auipc	ra,0xffffb
    80006206:	baa080e7          	jalr	-1110(ra) # 80000dac <release>
	if(ip->xv6_inode == NULL) {
    8000620a:	02093783          	ld	a5,32(s2)
    8000620e:	cf81                	beqz	a5,80006226 <xv6_iget+0x134>
	ip->flags = 0;
    80006210:	00092623          	sw	zero,12(s2)
}
    80006214:	854a                	mv	a0,s2
    80006216:	70a2                	ld	ra,40(sp)
    80006218:	7402                	ld	s0,32(sp)
    8000621a:	64e2                	ld	s1,24(sp)
    8000621c:	6942                	ld	s2,16(sp)
    8000621e:	69a2                	ld	s3,8(sp)
    80006220:	6a02                	ld	s4,0(sp)
    80006222:	6145                	addi	sp,sp,48
    80006224:	8082                	ret
		panic("iget(): No inodes available!");
    80006226:	00003517          	auipc	a0,0x3
    8000622a:	69a50513          	addi	a0,a0,1690 # 800098c0 <syscalls+0x4e8>
    8000622e:	ffffa097          	auipc	ra,0xffffa
    80006232:	434080e7          	jalr	1076(ra) # 80000662 <panic>

0000000080006236 <xv6_get_root>:
{
    80006236:	1141                	addi	sp,sp,-16
    80006238:	e406                	sd	ra,8(sp)
    8000623a:	e022                	sd	s0,0(sp)
    8000623c:	0800                	addi	s0,sp,16
	return xv6_iget(dev, ROOTINO);
    8000623e:	4585                	li	a1,1
    80006240:	00000097          	auipc	ra,0x0
    80006244:	eb2080e7          	jalr	-334(ra) # 800060f2 <xv6_iget>
}
    80006248:	60a2                	ld	ra,8(sp)
    8000624a:	6402                	ld	s0,0(sp)
    8000624c:	0141                	addi	sp,sp,16
    8000624e:	8082                	ret

0000000080006250 <xv6_ialloc>:
{
    80006250:	715d                	addi	sp,sp,-80
    80006252:	e486                	sd	ra,72(sp)
    80006254:	e0a2                	sd	s0,64(sp)
    80006256:	fc26                	sd	s1,56(sp)
    80006258:	f84a                	sd	s2,48(sp)
    8000625a:	f44e                	sd	s3,40(sp)
    8000625c:	f052                	sd	s4,32(sp)
    8000625e:	ec56                	sd	s5,24(sp)
    80006260:	e85a                	sd	s6,16(sp)
    80006262:	e45e                	sd	s7,8(sp)
    80006264:	e062                	sd	s8,0(sp)
    80006266:	0880                	addi	s0,sp,80
	for(inum = 1; inum < sb.xv6_superblock.ninodes; inum++) {
    80006268:	0001b717          	auipc	a4,0x1b
    8000626c:	56472703          	lw	a4,1380(a4) # 800217cc <sb+0x24>
    80006270:	4785                	li	a5,1
    80006272:	04e7fc63          	bgeu	a5,a4,800062ca <xv6_ialloc+0x7a>
    80006276:	8b2a                	mv	s6,a0
    80006278:	8c2e                	mv	s8,a1
    8000627a:	4485                	li	s1,1
		bp = xv6_vfs_ops.bread(dev, XV6_IBLOCK(inum, sb));
    8000627c:	0001ba97          	auipc	s5,0x1b
    80006280:	52ca8a93          	addi	s5,s5,1324 # 800217a8 <sb>
    80006284:	00004a17          	auipc	s4,0x4
    80006288:	184a0a13          	addi	s4,s4,388 # 8000a408 <xv6_vfs_ops>
    8000628c:	00048b9b          	sext.w	s7,s1
    80006290:	0044d593          	srli	a1,s1,0x4
    80006294:	030aa703          	lw	a4,48(s5)
    80006298:	040a3783          	ld	a5,64(s4)
    8000629c:	9db9                	addw	a1,a1,a4
    8000629e:	855a                	mv	a0,s6
    800062a0:	9782                	jalr	a5
    800062a2:	892a                	mv	s2,a0
		dip = (struct xv6_dinode *)bp->data + inum % XV6_IPB;
    800062a4:	05850993          	addi	s3,a0,88
    800062a8:	00f4f793          	andi	a5,s1,15
    800062ac:	079a                	slli	a5,a5,0x6
    800062ae:	99be                	add	s3,s3,a5
		if(dip->type == 0) {
    800062b0:	00099783          	lh	a5,0(s3)
    800062b4:	c39d                	beqz	a5,800062da <xv6_ialloc+0x8a>
		xv6_vfs_ops.brelease(bp);
    800062b6:	030a3783          	ld	a5,48(s4)
    800062ba:	9782                	jalr	a5
	for(inum = 1; inum < sb.xv6_superblock.ninodes; inum++) {
    800062bc:	0485                	addi	s1,s1,1
    800062be:	024aa703          	lw	a4,36(s5)
    800062c2:	0004879b          	sext.w	a5,s1
    800062c6:	fce7e3e3          	bltu	a5,a4,8000628c <xv6_ialloc+0x3c>
	panic("ialloc: no inodes");
    800062ca:	00003517          	auipc	a0,0x3
    800062ce:	61650513          	addi	a0,a0,1558 # 800098e0 <syscalls+0x508>
    800062d2:	ffffa097          	auipc	ra,0xffffa
    800062d6:	390080e7          	jalr	912(ra) # 80000662 <panic>
			kmemset(dip, 0, sizeof(*dip));
    800062da:	04000613          	li	a2,64
    800062de:	4581                	li	a1,0
    800062e0:	854e                	mv	a0,s3
    800062e2:	ffffb097          	auipc	ra,0xffffb
    800062e6:	b12080e7          	jalr	-1262(ra) # 80000df4 <kmemset>
			dip->type = type;
    800062ea:	01899023          	sh	s8,0(s3)
			log_write(bp);
    800062ee:	854a                	mv	a0,s2
    800062f0:	ffffd097          	auipc	ra,0xffffd
    800062f4:	474080e7          	jalr	1140(ra) # 80003764 <log_write>
			xv6_vfs_ops.brelease(bp);
    800062f8:	854a                	mv	a0,s2
    800062fa:	00004797          	auipc	a5,0x4
    800062fe:	13e7b783          	ld	a5,318(a5) # 8000a438 <xv6_vfs_ops+0x30>
    80006302:	9782                	jalr	a5
			return xv6_iget(dev, inum);
    80006304:	85de                	mv	a1,s7
    80006306:	855a                	mv	a0,s6
    80006308:	00000097          	auipc	ra,0x0
    8000630c:	dea080e7          	jalr	-534(ra) # 800060f2 <xv6_iget>
}
    80006310:	60a6                	ld	ra,72(sp)
    80006312:	6406                	ld	s0,64(sp)
    80006314:	74e2                	ld	s1,56(sp)
    80006316:	7942                	ld	s2,48(sp)
    80006318:	79a2                	ld	s3,40(sp)
    8000631a:	7a02                	ld	s4,32(sp)
    8000631c:	6ae2                	ld	s5,24(sp)
    8000631e:	6b42                	ld	s6,16(sp)
    80006320:	6ba2                	ld	s7,8(sp)
    80006322:	6c02                	ld	s8,0(sp)
    80006324:	6161                	addi	sp,sp,80
    80006326:	8082                	ret

0000000080006328 <xv6_dir_lookup>:
{
    80006328:	715d                	addi	sp,sp,-80
    8000632a:	e486                	sd	ra,72(sp)
    8000632c:	e0a2                	sd	s0,64(sp)
    8000632e:	fc26                	sd	s1,56(sp)
    80006330:	f84a                	sd	s2,48(sp)
    80006332:	f44e                	sd	s3,40(sp)
    80006334:	f052                	sd	s4,32(sp)
    80006336:	ec56                	sd	s5,24(sp)
    80006338:	0880                	addi	s0,sp,80
	if(dp->type != T_DIR) {
    8000633a:	02851703          	lh	a4,40(a0)
    8000633e:	4785                	li	a5,1
    80006340:	00f71e63          	bne	a4,a5,8000635c <xv6_dir_lookup+0x34>
    80006344:	892a                	mv	s2,a0
    80006346:	8a2e                	mv	s4,a1
    80006348:	8ab2                	mv	s5,a2
	for(off = 0; off < dp->size; off += sizeof(de)) {
    8000634a:	591c                	lw	a5,48(a0)
    8000634c:	4481                	li	s1,0
		if(xv6_inode_ops.readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de)) {
    8000634e:	00004997          	auipc	s3,0x4
    80006352:	0ba98993          	addi	s3,s3,186 # 8000a408 <xv6_vfs_ops>
	return 0;
    80006356:	4501                	li	a0,0
	for(off = 0; off < dp->size; off += sizeof(de)) {
    80006358:	e79d                	bnez	a5,80006386 <xv6_dir_lookup+0x5e>
    8000635a:	a895                	j	800063ce <xv6_dir_lookup+0xa6>
		panic("xv6_dir_lookup not DIR");
    8000635c:	00003517          	auipc	a0,0x3
    80006360:	59c50513          	addi	a0,a0,1436 # 800098f8 <syscalls+0x520>
    80006364:	ffffa097          	auipc	ra,0xffffa
    80006368:	2fe080e7          	jalr	766(ra) # 80000662 <panic>
			panic("xv6_dir_lookup read");
    8000636c:	00003517          	auipc	a0,0x3
    80006370:	5a450513          	addi	a0,a0,1444 # 80009910 <syscalls+0x538>
    80006374:	ffffa097          	auipc	ra,0xffffa
    80006378:	2ee080e7          	jalr	750(ra) # 80000662 <panic>
	for(off = 0; off < dp->size; off += sizeof(de)) {
    8000637c:	24c1                	addiw	s1,s1,16
    8000637e:	03092783          	lw	a5,48(s2)
    80006382:	04f4f563          	bgeu	s1,a5,800063cc <xv6_dir_lookup+0xa4>
		if(xv6_inode_ops.readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de)) {
    80006386:	0a09b783          	ld	a5,160(s3)
    8000638a:	4741                	li	a4,16
    8000638c:	86a6                	mv	a3,s1
    8000638e:	fb040613          	addi	a2,s0,-80
    80006392:	4581                	li	a1,0
    80006394:	854a                	mv	a0,s2
    80006396:	9782                	jalr	a5
    80006398:	47c1                	li	a5,16
    8000639a:	fcf519e3          	bne	a0,a5,8000636c <xv6_dir_lookup+0x44>
		if(de.inum == 0) {
    8000639e:	fb045783          	lhu	a5,-80(s0)
    800063a2:	dfe9                	beqz	a5,8000637c <xv6_dir_lookup+0x54>
		if(xv6_vfs_ops.name_cmp(name, de.name) == 0) {
    800063a4:	0489b783          	ld	a5,72(s3)
    800063a8:	fb240593          	addi	a1,s0,-78
    800063ac:	8552                	mv	a0,s4
    800063ae:	9782                	jalr	a5
    800063b0:	f571                	bnez	a0,8000637c <xv6_dir_lookup+0x54>
			if(poff)
    800063b2:	000a8463          	beqz	s5,800063ba <xv6_dir_lookup+0x92>
				*poff = off;
    800063b6:	009aa023          	sw	s1,0(s5)
			return xv6_iget(dp->dev, inum);
    800063ba:	fb045583          	lhu	a1,-80(s0)
    800063be:	00092503          	lw	a0,0(s2)
    800063c2:	00000097          	auipc	ra,0x0
    800063c6:	d30080e7          	jalr	-720(ra) # 800060f2 <xv6_iget>
    800063ca:	a011                	j	800063ce <xv6_dir_lookup+0xa6>
	return 0;
    800063cc:	4501                	li	a0,0
}
    800063ce:	60a6                	ld	ra,72(sp)
    800063d0:	6406                	ld	s0,64(sp)
    800063d2:	74e2                	ld	s1,56(sp)
    800063d4:	7942                	ld	s2,48(sp)
    800063d6:	79a2                	ld	s3,40(sp)
    800063d8:	7a02                	ld	s4,32(sp)
    800063da:	6ae2                	ld	s5,24(sp)
    800063dc:	6161                	addi	sp,sp,80
    800063de:	8082                	ret

00000000800063e0 <xv6_ifree>:
{
    800063e0:	1141                	addi	sp,sp,-16
    800063e2:	e406                	sd	ra,8(sp)
    800063e4:	e022                	sd	s0,0(sp)
    800063e6:	0800                	addi	s0,sp,16
	panic("xv6_ifree() not implemented!");
    800063e8:	00003517          	auipc	a0,0x3
    800063ec:	54050513          	addi	a0,a0,1344 # 80009928 <syscalls+0x550>
    800063f0:	ffffa097          	auipc	ra,0xffffa
    800063f4:	272080e7          	jalr	626(ra) # 80000662 <panic>

00000000800063f8 <xv6_cleanup>:
{
    800063f8:	1141                	addi	sp,sp,-16
    800063fa:	e406                	sd	ra,8(sp)
    800063fc:	e022                	sd	s0,0(sp)
    800063fe:	0800                	addi	s0,sp,16
	panic("xv6_cleanup() not implemented!");
    80006400:	00003517          	auipc	a0,0x3
    80006404:	54850513          	addi	a0,a0,1352 # 80009948 <syscalls+0x570>
    80006408:	ffffa097          	auipc	ra,0xffffa
    8000640c:	25a080e7          	jalr	602(ra) # 80000662 <panic>

0000000080006410 <ext2_try_to_allocate>:

	return here;
}

static int ext2_try_to_allocate(int group, struct buf * bitmap_buffer, unsigned long goal_group, unsigned long *count)
{
    80006410:	1141                	addi	sp,sp,-16
    80006412:	e422                	sd	s0,8(sp)
    80006414:	0800                	addi	s0,sp,16
		start = goal_group;
	} else {
		start = 0;
	}

	end = root_fs->superblock.ext2_in_mem_super.blocks_per_block_group;
    80006416:	00005797          	auipc	a5,0x5
    8000641a:	c227b783          	ld	a5,-990(a5) # 8000b038 <root_fs>
    8000641e:	0387b883          	ld	a7,56(a5)
	return find_last_set_bit(n) - 1;
}

static inline int test_bit(long nr, volatile const unsigned long * addr)
{
	return (*addr & (1 << nr)) >> nr;
    80006422:	4805                	li	a6,1
    80006424:	6dbc                	ld	a5,88(a1)
    80006426:	00c8173b          	sllw	a4,a6,a2

static inline int test_and_set_bit(long nr, volatile unsigned long * addr)
{
	unsigned long ret = test_bit(nr, addr);

	*addr |= (1 << nr);
    8000642a:	6da8                	ld	a0,88(a1)
    8000642c:	8d59                	or	a0,a0,a4
    8000642e:	eda8                	sd	a0,88(a1)
	return (*addr & (1 << nr)) >> nr;
    80006430:	8ff9                	and	a5,a5,a4
    80006432:	00c7d7b3          	srl	a5,a5,a2
			;
	}

	start = goal_group;

	if(test_and_set_bit(goal_group, (unsigned long *)bitmap_buffer->data)) {
    80006436:	2781                	sext.w	a5,a5
    80006438:	c799                	beqz	a5,80006446 <ext2_try_to_allocate+0x36>
		start++;
    8000643a:	0605                	addi	a2,a2,1
		goal_group++;

		if(start >= end)
    8000643c:	ff1664e3          	bltu	a2,a7,80006424 <ext2_try_to_allocate+0x14>
    80006440:	4801                	li	a6,0

fail_access:

	*count = num;

	return -1;
    80006442:	557d                	li	a0,-1
    80006444:	a891                	j	80006498 <ext2_try_to_allocate+0x88>
	for(num++, goal_group++; num < *count && goal_group < end && !test_and_set_bit(goal_group, (unsigned long *) bitmap_buffer->data); num++, goal_group++)
    80006446:	0605                	addi	a2,a2,1
    80006448:	6298                	ld	a4,0(a3)
    8000644a:	4785                	li	a5,1
    8000644c:	04e7fb63          	bgeu	a5,a4,800064a2 <ext2_try_to_allocate+0x92>
    80006450:	05167b63          	bgeu	a2,a7,800064a6 <ext2_try_to_allocate+0x96>
    80006454:	6dbc                	ld	a5,88(a1)
    80006456:	4705                	li	a4,1
    80006458:	00c7173b          	sllw	a4,a4,a2
	*addr |= (1 << nr);
    8000645c:	6da8                	ld	a0,88(a1)
    8000645e:	8d59                	or	a0,a0,a4
    80006460:	eda8                	sd	a0,88(a1)
	return (*addr & (1 << nr)) >> nr;
    80006462:	8ff9                	and	a5,a5,a4
    80006464:	00c7d7b3          	srl	a5,a5,a2
    80006468:	2781                	sext.w	a5,a5
    8000646a:	e3a1                	bnez	a5,800064aa <ext2_try_to_allocate+0x9a>
    8000646c:	4805                	li	a6,1
    8000646e:	4305                	li	t1,1
    80006470:	0805                	addi	a6,a6,1
    80006472:	0605                	addi	a2,a2,1
    80006474:	629c                	ld	a5,0(a3)
    80006476:	00f87f63          	bgeu	a6,a5,80006494 <ext2_try_to_allocate+0x84>
    8000647a:	01167d63          	bgeu	a2,a7,80006494 <ext2_try_to_allocate+0x84>
    8000647e:	6dbc                	ld	a5,88(a1)
    80006480:	00c3173b          	sllw	a4,t1,a2
	*addr |= (1 << nr);
    80006484:	6da8                	ld	a0,88(a1)
    80006486:	8d59                	or	a0,a0,a4
    80006488:	eda8                	sd	a0,88(a1)
	return (*addr & (1 << nr)) >> nr;
    8000648a:	8ff9                	and	a5,a5,a4
    8000648c:	00c7d7b3          	srl	a5,a5,a2
    80006490:	2781                	sext.w	a5,a5
    80006492:	dff9                	beqz	a5,80006470 <ext2_try_to_allocate+0x60>
	return goal_group - num;
    80006494:	4106053b          	subw	a0,a2,a6
	*count = num;
    80006498:	0106b023          	sd	a6,0(a3)
}
    8000649c:	6422                	ld	s0,8(sp)
    8000649e:	0141                	addi	sp,sp,16
    800064a0:	8082                	ret
	for(num++, goal_group++; num < *count && goal_group < end && !test_and_set_bit(goal_group, (unsigned long *) bitmap_buffer->data); num++, goal_group++)
    800064a2:	4805                	li	a6,1
    800064a4:	bfc5                	j	80006494 <ext2_try_to_allocate+0x84>
    800064a6:	4805                	li	a6,1
    800064a8:	b7f5                	j	80006494 <ext2_try_to_allocate+0x84>
    800064aa:	4805                	li	a6,1
    800064ac:	b7e5                	j	80006494 <ext2_try_to_allocate+0x84>

00000000800064ae <ext2_stati>:

	release(&itable.lock);
}

void ext2_stati(struct inode * ip, struct stat * st)
{
    800064ae:	1141                	addi	sp,sp,-16
    800064b0:	e422                	sd	s0,8(sp)
    800064b2:	0800                	addi	s0,sp,16
	st->dev = ip->dev;
    800064b4:	411c                	lw	a5,0(a0)
    800064b6:	c19c                	sw	a5,0(a1)
	st->ino = ip->inum;
    800064b8:	415c                	lw	a5,4(a0)
    800064ba:	c1dc                	sw	a5,4(a1)
	st->type = ip->type;
    800064bc:	02851783          	lh	a5,40(a0)
    800064c0:	00f59423          	sh	a5,8(a1)
	st->nlink = ip->nlink;
    800064c4:	02e51783          	lh	a5,46(a0)
    800064c8:	00f59523          	sh	a5,10(a1)
	st->size = ip->size;
    800064cc:	03056783          	lwu	a5,48(a0)
    800064d0:	e99c                	sd	a5,16(a1)
}
    800064d2:	6422                	ld	s0,8(sp)
    800064d4:	0141                	addi	sp,sp,16
    800064d6:	8082                	ret

00000000800064d8 <ext2_iunlockput>:
	ip->ref--;
	release(&itable.lock);
}

void ext2_iunlockput(struct inode * ip)
{
    800064d8:	1101                	addi	sp,sp,-32
    800064da:	ec06                	sd	ra,24(sp)
    800064dc:	e822                	sd	s0,16(sp)
    800064de:	e426                	sd	s1,8(sp)
    800064e0:	e04a                	sd	s2,0(sp)
    800064e2:	1000                	addi	s0,sp,32
    800064e4:	84aa                	mv	s1,a0
	ext2_inode_ops.iunlock(ip);
    800064e6:	00004917          	auipc	s2,0x4
    800064ea:	fda90913          	addi	s2,s2,-38 # 8000a4c0 <ext2_inode_ops>
    800064ee:	03093783          	ld	a5,48(s2)
    800064f2:	9782                	jalr	a5
	ext2_inode_ops.iput(ip);
    800064f4:	02893783          	ld	a5,40(s2)
    800064f8:	8526                	mv	a0,s1
    800064fa:	9782                	jalr	a5
    800064fc:	60e2                	ld	ra,24(sp)
    800064fe:	6442                	ld	s0,16(sp)
    80006500:	64a2                	ld	s1,8(sp)
    80006502:	6902                	ld	s2,0(sp)
    80006504:	6105                	addi	sp,sp,32
    80006506:	8082                	ret

0000000080006508 <ext2_get_group_descriptor>:
{
    80006508:	1141                	addi	sp,sp,-16
    8000650a:	e406                	sd	ra,8(sp)
    8000650c:	e022                	sd	s0,0(sp)
    8000650e:	0800                	addi	s0,sp,16
	if(block_group >= root_fs->superblock.ext2_in_mem_super.group_count) {
    80006510:	02051693          	slli	a3,a0,0x20
    80006514:	9281                	srli	a3,a3,0x20
    80006516:	00005717          	auipc	a4,0x5
    8000651a:	b2273703          	ld	a4,-1246(a4) # 8000b038 <root_fs>
    8000651e:	733c                	ld	a5,96(a4)
    80006520:	02f6fa63          	bgeu	a3,a5,80006554 <ext2_get_group_descriptor+0x4c>
	offset = block_group & (root_fs->superblock.ext2_in_mem_super.group_descriptors_per_block - 1);
    80006524:	6f3c                	ld	a5,88(a4)
    80006526:	17fd                	addi	a5,a5,-1
    80006528:	8ff5                	and	a5,a5,a3
	group_descriptor = block_group >> root_fs->superblock.ext2_in_mem_super.descriptors_per_block_bits;
    8000652a:	1d072683          	lw	a3,464(a4)
    8000652e:	00d5553b          	srlw	a0,a0,a3
	if(!root_fs->superblock.ext2_in_mem_super.group_descriptors[group_descriptor]) {
    80006532:	02051693          	slli	a3,a0,0x20
    80006536:	01d6d513          	srli	a0,a3,0x1d
    8000653a:	972a                	add	a4,a4,a0
    8000653c:	6758                	ld	a4,136(a4)
    8000653e:	c31d                	beqz	a4,80006564 <ext2_get_group_descriptor+0x5c>
	descriptor = (struct ext2_group_descriptor *) root_fs->superblock.ext2_in_mem_super.group_descriptors[group_descriptor]->data;
    80006540:	05870513          	addi	a0,a4,88
	if(buffer) {
    80006544:	c191                	beqz	a1,80006548 <ext2_get_group_descriptor+0x40>
		*buffer = root_fs->superblock.ext2_in_mem_super.group_descriptors[group_descriptor];
    80006546:	e198                	sd	a4,0(a1)
	return descriptor + offset;
    80006548:	0796                	slli	a5,a5,0x5
}
    8000654a:	953e                	add	a0,a0,a5
    8000654c:	60a2                	ld	ra,8(sp)
    8000654e:	6402                	ld	s0,0(sp)
    80006550:	0141                	addi	sp,sp,16
    80006552:	8082                	ret
		panic("ext2_get_group_descriptor(): Block group too large");
    80006554:	00003517          	auipc	a0,0x3
    80006558:	41450513          	addi	a0,a0,1044 # 80009968 <syscalls+0x590>
    8000655c:	ffffa097          	auipc	ra,0xffffa
    80006560:	106080e7          	jalr	262(ra) # 80000662 <panic>
		panic("ext2_get_group_descriptor(): Group descriptor not loaded");
    80006564:	00003517          	auipc	a0,0x3
    80006568:	43c50513          	addi	a0,a0,1084 # 800099a0 <syscalls+0x5c8>
    8000656c:	ffffa097          	auipc	ra,0xffffa
    80006570:	0f6080e7          	jalr	246(ra) # 80000662 <panic>

0000000080006574 <read_block_bitmap>:
{
    80006574:	1141                	addi	sp,sp,-16
    80006576:	e406                	sd	ra,8(sp)
    80006578:	e022                	sd	s0,0(sp)
    8000657a:	0800                	addi	s0,sp,16
	descriptor = ext2_get_group_descriptor(block_group, 0);
    8000657c:	4581                	li	a1,0
    8000657e:	00000097          	auipc	ra,0x0
    80006582:	f8a080e7          	jalr	-118(ra) # 80006508 <ext2_get_group_descriptor>
	if(!descriptor)
    80006586:	cd09                	beqz	a0,800065a0 <read_block_bitmap+0x2c>
	buffer = ext2_vfs_ops.bread(root_fs->superblock.device, descriptor->block_bitmap);
    80006588:	410c                	lw	a1,0(a0)
    8000658a:	00005797          	auipc	a5,0x5
    8000658e:	aae7b783          	ld	a5,-1362(a5) # 8000b038 <root_fs>
    80006592:	01879503          	lh	a0,24(a5)
    80006596:	00004797          	auipc	a5,0x4
    8000659a:	fd27b783          	ld	a5,-46(a5) # 8000a568 <ext2_vfs_ops+0x40>
    8000659e:	9782                	jalr	a5
}
    800065a0:	60a2                	ld	ra,8(sp)
    800065a2:	6402                	ld	s0,0(sp)
    800065a4:	0141                	addi	sp,sp,16
    800065a6:	8082                	ret

00000000800065a8 <ext2_get_inode>:
{
    800065a8:	1101                	addi	sp,sp,-32
    800065aa:	ec06                	sd	ra,24(sp)
    800065ac:	e822                	sd	s0,16(sp)
    800065ae:	e426                	sd	s1,8(sp)
    800065b0:	e04a                	sd	s2,0(sp)
    800065b2:	1000                	addi	s0,sp,32
    800065b4:	84ae                	mv	s1,a1
	if((inode_num != EXT2_ROOT_INODE && inode_num < root_fs->superblock.ext2_in_mem_super.disk_super->first_inode) || inode_num > root_fs->superblock.ext2_in_mem_super.disk_super->inode_count) {
    800065b6:	4789                	li	a5,2
    800065b8:	00f50a63          	beq	a0,a5,800065cc <ext2_get_inode+0x24>
    800065bc:	00005797          	auipc	a5,0x5
    800065c0:	a7c7b783          	ld	a5,-1412(a5) # 8000b038 <root_fs>
    800065c4:	63dc                	ld	a5,128(a5)
    800065c6:	4bfc                	lw	a5,84(a5)
    800065c8:	06f56c63          	bltu	a0,a5,80006640 <ext2_get_inode+0x98>
    800065cc:	00005697          	auipc	a3,0x5
    800065d0:	a6c6b683          	ld	a3,-1428(a3) # 8000b038 <root_fs>
    800065d4:	62dc                	ld	a5,128(a3)
    800065d6:	439c                	lw	a5,0(a5)
    800065d8:	06a7e463          	bltu	a5,a0,80006640 <ext2_get_inode+0x98>
	block_group = (inode_num - 1) / root_fs->superblock.ext2_in_mem_super.inodes_per_block_group; /* Determine the block group the inode is in */
    800065dc:	357d                	addiw	a0,a0,-1
    800065de:	1502                	slli	a0,a0,0x20
    800065e0:	9101                	srli	a0,a0,0x20
    800065e2:	62b8                	ld	a4,64(a3)
    800065e4:	02e557b3          	divu	a5,a0,a4
	if(block_group > root_fs->superblock.ext2_in_mem_super.group_count) {
    800065e8:	72b0                	ld	a2,96(a3)
    800065ea:	06f66363          	bltu	a2,a5,80006650 <ext2_get_inode+0xa8>
	group_descriptor = block_group / root_fs->superblock.ext2_in_mem_super.group_descriptors_per_block; /* Determine group descriptor of the block group */
    800065ee:	6eb0                	ld	a2,88(a3)
	offset = ((inode_num - 1) % root_fs->superblock.ext2_in_mem_super.inodes_per_block_group) * EXT2_INODE_SIZE;
    800065f0:	02e57533          	remu	a0,a0,a4
    800065f4:	00851913          	slli	s2,a0,0x8
	group_descriptor = block_group / root_fs->superblock.ext2_in_mem_super.group_descriptors_per_block; /* Determine group descriptor of the block group */
    800065f8:	02c7d733          	divu	a4,a5,a2
	buffer_p = root_fs->superblock.ext2_in_mem_super.group_descriptors[group_descriptor]; /* Load the pointer to the buffer for the group descriptor into a variable */
    800065fc:	0739                	addi	a4,a4,14
    800065fe:	070e                	slli	a4,a4,0x3
    80006600:	9736                	add	a4,a4,a3
	descriptor_index = block_group % root_fs->superblock.ext2_in_mem_super.group_descriptors_per_block; /* Determine the index of the group descriptor inside the group descriptor offset */
    80006602:	02c7f7b3          	remu	a5,a5,a2
	block = group_descriptor_p[descriptor_index].inode_table + (offset >> 10);
    80006606:	6f18                	ld	a4,24(a4)
    80006608:	0796                	slli	a5,a5,0x5
    8000660a:	97ba                	add	a5,a5,a4
    8000660c:	0607e583          	lwu	a1,96(a5)
    80006610:	8109                	srli	a0,a0,0x2
	if(!(buffer_p = ext2_vfs_ops.bread(root_fs->superblock.device, block)))
    80006612:	9da9                	addw	a1,a1,a0
    80006614:	01869503          	lh	a0,24(a3)
    80006618:	00004797          	auipc	a5,0x4
    8000661c:	f507b783          	ld	a5,-176(a5) # 8000a568 <ext2_vfs_ops+0x40>
    80006620:	9782                	jalr	a5
    80006622:	872a                	mv	a4,a0
    80006624:	cd15                	beqz	a0,80006660 <ext2_get_inode+0xb8>
	raw_inode = ((struct ext2_inode *) (buffer_p->data + offset));
    80006626:	05850513          	addi	a0,a0,88
	offset &= (EXT2_BLOCK_SIZE - 1);
    8000662a:	3ff97913          	andi	s2,s2,1023
	raw_inode = ((struct ext2_inode *) (buffer_p->data + offset));
    8000662e:	954a                	add	a0,a0,s2
	if(buffer)
    80006630:	c091                	beqz	s1,80006634 <ext2_get_inode+0x8c>
		*buffer = buffer_p;
    80006632:	e098                	sd	a4,0(s1)
}
    80006634:	60e2                	ld	ra,24(sp)
    80006636:	6442                	ld	s0,16(sp)
    80006638:	64a2                	ld	s1,8(sp)
    8000663a:	6902                	ld	s2,0(sp)
    8000663c:	6105                	addi	sp,sp,32
    8000663e:	8082                	ret
		panic("ext2_get_inode(): Invalid inode number");
    80006640:	00003517          	auipc	a0,0x3
    80006644:	3a050513          	addi	a0,a0,928 # 800099e0 <syscalls+0x608>
    80006648:	ffffa097          	auipc	ra,0xffffa
    8000664c:	01a080e7          	jalr	26(ra) # 80000662 <panic>
		panic("ext2_get_inode(): Block group out of range");
    80006650:	00003517          	auipc	a0,0x3
    80006654:	3b850513          	addi	a0,a0,952 # 80009a08 <syscalls+0x630>
    80006658:	ffffa097          	auipc	ra,0xffffa
    8000665c:	00a080e7          	jalr	10(ra) # 80000662 <panic>
		panic("ext2_get_inode(): Could not read inode block");
    80006660:	00003517          	auipc	a0,0x3
    80006664:	3d850513          	addi	a0,a0,984 # 80009a38 <syscalls+0x660>
    80006668:	ffffa097          	auipc	ra,0xffffa
    8000666c:	ffa080e7          	jalr	-6(ra) # 80000662 <panic>

0000000080006670 <ext2_bfree>:
{
    80006670:	1141                	addi	sp,sp,-16
    80006672:	e406                	sd	ra,8(sp)
    80006674:	e022                	sd	s0,0(sp)
    80006676:	0800                	addi	s0,sp,16
	panic("ext2_bfree() not implemented!");
    80006678:	00003517          	auipc	a0,0x3
    8000667c:	3f050513          	addi	a0,a0,1008 # 80009a68 <syscalls+0x690>
    80006680:	ffffa097          	auipc	ra,0xffffa
    80006684:	fe2080e7          	jalr	-30(ra) # 80000662 <panic>

0000000080006688 <ext2_name_cmp>:
{
    80006688:	1141                	addi	sp,sp,-16
    8000668a:	e406                	sd	ra,8(sp)
    8000668c:	e022                	sd	s0,0(sp)
    8000668e:	0800                	addi	s0,sp,16
	panic("ext2_name_cmp() not implemented!");
    80006690:	00003517          	auipc	a0,0x3
    80006694:	3f850513          	addi	a0,a0,1016 # 80009a88 <syscalls+0x6b0>
    80006698:	ffffa097          	auipc	ra,0xffffa
    8000669c:	fca080e7          	jalr	-54(ra) # 80000662 <panic>

00000000800066a0 <ext2_itrunc>:
{
    800066a0:	1141                	addi	sp,sp,-16
    800066a2:	e406                	sd	ra,8(sp)
    800066a4:	e022                	sd	s0,0(sp)
    800066a6:	0800                	addi	s0,sp,16
	panic("itrunc() not implemented!");
    800066a8:	00003517          	auipc	a0,0x3
    800066ac:	40850513          	addi	a0,a0,1032 # 80009ab0 <syscalls+0x6d8>
    800066b0:	ffffa097          	auipc	ra,0xffffa
    800066b4:	fb2080e7          	jalr	-78(ra) # 80000662 <panic>

00000000800066b8 <ext2_read_super>:
{
    800066b8:	715d                	addi	sp,sp,-80
    800066ba:	e486                	sd	ra,72(sp)
    800066bc:	e0a2                	sd	s0,64(sp)
    800066be:	fc26                	sd	s1,56(sp)
    800066c0:	f84a                	sd	s2,48(sp)
    800066c2:	f44e                	sd	s3,40(sp)
    800066c4:	f052                	sd	s4,32(sp)
    800066c6:	ec56                	sd	s5,24(sp)
    800066c8:	e85a                	sd	s6,16(sp)
    800066ca:	e45e                	sd	s7,8(sp)
    800066cc:	0880                	addi	s0,sp,80
    800066ce:	8aaa                	mv	s5,a0
    800066d0:	89ae                	mv	s3,a1
	buffer = ext2_vfs_ops.bread(dev, EXT2_SUPERBLOCK_BLOCK);
    800066d2:	00050a1b          	sext.w	s4,a0
    800066d6:	4585                	li	a1,1
    800066d8:	8552                	mv	a0,s4
    800066da:	00004797          	auipc	a5,0x4
    800066de:	e8e7b783          	ld	a5,-370(a5) # 8000a568 <ext2_vfs_ops+0x40>
    800066e2:	9782                	jalr	a5
    800066e4:	892a                	mv	s2,a0
	if(((struct ext2_superblock *) buffer->data)->magic_number != EXT2_MAGIC) {
    800066e6:	09055703          	lhu	a4,144(a0)
    800066ea:	67bd                	lui	a5,0xf
    800066ec:	f5378793          	addi	a5,a5,-173 # ef53 <_entry-0x7fff10ad>
    800066f0:	14f71c63          	bne	a4,a5,80006848 <ext2_read_super+0x190>
	initlock(&ext2_active_inodes.lock, "ext2_inode_pool");
    800066f4:	00003597          	auipc	a1,0x3
    800066f8:	3dc58593          	addi	a1,a1,988 # 80009ad0 <syscalls+0x6f8>
    800066fc:	00022517          	auipc	a0,0x22
    80006700:	2e450513          	addi	a0,a0,740 # 800289e0 <ext2_active_inodes>
    80006704:	ffffa097          	auipc	ra,0xffffa
    80006708:	564080e7          	jalr	1380(ra) # 80000c68 <initlock>
	ext2_disk_super = kalloc();
    8000670c:	ffffa097          	auipc	ra,0xffffa
    80006710:	4fc080e7          	jalr	1276(ra) # 80000c08 <kalloc>
    80006714:	84aa                	mv	s1,a0
	kmemmove(ext2_disk_super, buffer->data, sizeof(struct ext2_superblock)); /* Read the disk super block into memory */
    80006716:	40000613          	li	a2,1024
    8000671a:	05890593          	addi	a1,s2,88
    8000671e:	ffffa097          	auipc	ra,0xffffa
    80006722:	732080e7          	jalr	1842(ra) # 80000e50 <kmemmove>
	ext2_vfs_ops.brelease(buffer);
    80006726:	854a                	mv	a0,s2
    80006728:	00004797          	auipc	a5,0x4
    8000672c:	e307b783          	ld	a5,-464(a5) # 8000a558 <ext2_vfs_ops+0x30>
    80006730:	9782                	jalr	a5
	super->magic = EXT2_MAGIC;
    80006732:	67bd                	lui	a5,0xf
    80006734:	f5378793          	addi	a5,a5,-173 # ef53 <_entry-0x7fff10ad>
    80006738:	00f9a823          	sw	a5,16(s3)
	super->block_size = EXT2_BLOCK_SIZE_SHIFT << ext2_disk_super->block_size;
    8000673c:	4c98                	lw	a4,24(s1)
    8000673e:	40000793          	li	a5,1024
    80006742:	00e797bb          	sllw	a5,a5,a4
    80006746:	0007871b          	sext.w	a4,a5
    8000674a:	00f9a223          	sw	a5,4(s3)
	super->device = dev;
    8000674e:	01599023          	sh	s5,0(s3)
	super->size = ext2_disk_super->block_count;
    80006752:	40dc                	lw	a5,4(s1)
    80006754:	00f9aa23          	sw	a5,20(s3)
	super->vfs_ops = &ext2_vfs_ops;
    80006758:	00004797          	auipc	a5,0x4
    8000675c:	dd078793          	addi	a5,a5,-560 # 8000a528 <ext2_vfs_ops>
    80006760:	00f9b423          	sd	a5,8(s3)
	if(super->block_size != EXT2_BLOCK_SIZE)
    80006764:	40000793          	li	a5,1024
    80006768:	0ef71763          	bne	a4,a5,80006856 <ext2_read_super+0x19e>
	super->ext2_in_mem_super.disk_super = ext2_disk_super;
    8000676c:	0699b423          	sd	s1,104(s3)
	super->ext2_in_mem_super.super_buffer = buffer;
    80006770:	0729b023          	sd	s2,96(s3)
	super->ext2_in_mem_super.inode_size = EXT2_INODE_SIZE;
    80006774:	10000793          	li	a5,256
    80006778:	1af9ae23          	sw	a5,444(s3)
	super->ext2_in_mem_super.first_inode = EXT2_FIRST_INODE;
    8000677c:	47ad                	li	a5,11
    8000677e:	1cf9a023          	sw	a5,448(s3)
	super->ext2_in_mem_super.blocks_per_block_group = super->ext2_in_mem_super.disk_super->blocks_per_block_group;
    80006782:	0204e683          	lwu	a3,32(s1)
    80006786:	02d9b023          	sd	a3,32(s3)
	super->ext2_in_mem_super.inodes_per_block_group = super->ext2_in_mem_super.disk_super->inodes_per_block_group;
    8000678a:	0284e783          	lwu	a5,40(s1)
    8000678e:	02f9b423          	sd	a5,40(s3)
	super->ext2_in_mem_super.inodes_per_block = super->block_size / super->ext2_in_mem_super.inode_size;
    80006792:	4791                	li	a5,4
    80006794:	00f9bc23          	sd	a5,24(s3)
	super->ext2_in_mem_super.inode_table_blocks_per_group = ext2_disk_super->inodes_per_block_group / super->ext2_in_mem_super.inodes_per_block;
    80006798:	0284e783          	lwu	a5,40(s1)
    8000679c:	8389                	srli	a5,a5,0x2
    8000679e:	02f9b823          	sd	a5,48(s3)
	super->ext2_in_mem_super.group_descriptors_per_block = super->block_size / sizeof(struct ext2_group_descriptor);
    800067a2:	02000793          	li	a5,32
    800067a6:	04f9b023          	sd	a5,64(s3)
	for(int bit = 31; bit > 0; bit--) {
    800067aa:	47f9                	li	a5,30
		if(x & (1 << bit)) {
    800067ac:	4721                	li	a4,8
	for(int bit = 31; bit > 0; bit--) {
    800067ae:	37fd                	addiw	a5,a5,-1
		if(x & (1 << bit)) {
    800067b0:	fee79fe3          	bne	a5,a4,800067ae <ext2_read_super+0xf6>
	super->ext2_in_mem_super.address_per_block_bits = ilog2(super->block_size / sizeof(unsigned int));
    800067b4:	47a1                	li	a5,8
    800067b6:	1af9aa23          	sw	a5,436(s3)
	for(int bit = 31; bit > 0; bit--) {
    800067ba:	47f9                	li	a5,30
		if(x & (1 << bit)) {
    800067bc:	4715                	li	a4,5
	for(int bit = 31; bit > 0; bit--) {
    800067be:	37fd                	addiw	a5,a5,-1
		if(x & (1 << bit)) {
    800067c0:	fee79fe3          	bne	a5,a4,800067be <ext2_read_super+0x106>
	super->ext2_in_mem_super.descriptors_per_block_bits = ilog2(super->ext2_in_mem_super.group_descriptors_per_block);
    800067c4:	4795                	li	a5,5
    800067c6:	1af9ac23          	sw	a5,440(s3)
	super->ext2_in_mem_super.block_size_bits = blocksize_bits(super->block_size);
    800067ca:	47a9                	li	a5,10
    800067cc:	1cf9ae23          	sw	a5,476(s3)
	if(super->ext2_in_mem_super.blocks_per_block_group > super->block_size * 8)
    800067d0:	6789                	lui	a5,0x2
    800067d2:	08d7ea63          	bltu	a5,a3,80006866 <ext2_read_super+0x1ae>
	super->ext2_in_mem_super.group_count = ((super->ext2_in_mem_super.disk_super->block_count - super->ext2_in_mem_super.disk_super->superblock_block - 1) / super->ext2_in_mem_super.blocks_per_block_group) + 1;
    800067d6:	40dc                	lw	a5,4(s1)
    800067d8:	37fd                	addiw	a5,a5,-1
    800067da:	48d8                	lw	a4,20(s1)
    800067dc:	9f99                	subw	a5,a5,a4
    800067de:	1782                	slli	a5,a5,0x20
    800067e0:	9381                	srli	a5,a5,0x20
    800067e2:	02d7d7b3          	divu	a5,a5,a3
    800067e6:	00178713          	addi	a4,a5,1 # 2001 <_entry-0x7fffdfff>
    800067ea:	04e9b423          	sd	a4,72(s3)
	group_descriptor_block_count = (super->ext2_in_mem_super.group_count + super->ext2_in_mem_super.group_descriptors_per_block - 1) / super->ext2_in_mem_super.group_descriptors_per_block;
    800067ee:	02078793          	addi	a5,a5,32
    800067f2:	0057db93          	srli	s7,a5,0x5
	if(group_descriptor_block_count > EXT2_MAX_BLOCK_GROUP_COUNT)
    800067f6:	51f00713          	li	a4,1311
    800067fa:	06f76e63          	bltu	a4,a5,80006876 <ext2_read_super+0x1be>
    800067fe:	07098913          	addi	s2,s3,112
    80006802:	002b8b13          	addi	s6,s7,2 # 2002 <_entry-0x7fffdffe>
    80006806:	4489                	li	s1,2
		super->ext2_in_mem_super.group_descriptors[i] = ext2_vfs_ops.bread(dev, i + 2);
    80006808:	00004a97          	auipc	s5,0x4
    8000680c:	cb8a8a93          	addi	s5,s5,-840 # 8000a4c0 <ext2_inode_ops>
    80006810:	0a8ab783          	ld	a5,168(s5)
    80006814:	85a6                	mv	a1,s1
    80006816:	8552                	mv	a0,s4
    80006818:	9782                	jalr	a5
    8000681a:	00a93023          	sd	a0,0(s2)
		if(!super->ext2_in_mem_super.group_descriptors[i])
    8000681e:	c525                	beqz	a0,80006886 <ext2_read_super+0x1ce>
	for(int i = 0; i < group_descriptor_block_count; i++) {
    80006820:	2485                	addiw	s1,s1,1
    80006822:	0921                	addi	s2,s2,8
    80006824:	ff6496e3          	bne	s1,s6,80006810 <ext2_read_super+0x158>
	super->ext2_in_mem_super.group_descriptor_count = group_descriptor_block_count;
    80006828:	0379bc23          	sd	s7,56(s3)
	return EXT2_MAGIC;
    8000682c:	653d                	lui	a0,0xf
    8000682e:	f5350513          	addi	a0,a0,-173 # ef53 <_entry-0x7fff10ad>
}
    80006832:	60a6                	ld	ra,72(sp)
    80006834:	6406                	ld	s0,64(sp)
    80006836:	74e2                	ld	s1,56(sp)
    80006838:	7942                	ld	s2,48(sp)
    8000683a:	79a2                	ld	s3,40(sp)
    8000683c:	7a02                	ld	s4,32(sp)
    8000683e:	6ae2                	ld	s5,24(sp)
    80006840:	6b42                	ld	s6,16(sp)
    80006842:	6ba2                	ld	s7,8(sp)
    80006844:	6161                	addi	sp,sp,80
    80006846:	8082                	ret
		ext2_vfs_ops.brelease(buffer);
    80006848:	00004797          	auipc	a5,0x4
    8000684c:	d107b783          	ld	a5,-752(a5) # 8000a558 <ext2_vfs_ops+0x30>
    80006850:	9782                	jalr	a5
		return -1;
    80006852:	557d                	li	a0,-1
    80006854:	bff9                	j	80006832 <ext2_read_super+0x17a>
		panic("ext2_read_super(): System only supports 1024 byte blocks for ext2!");
    80006856:	00003517          	auipc	a0,0x3
    8000685a:	28a50513          	addi	a0,a0,650 # 80009ae0 <syscalls+0x708>
    8000685e:	ffffa097          	auipc	ra,0xffffa
    80006862:	e04080e7          	jalr	-508(ra) # 80000662 <panic>
		panic("ext2_read_super(): Too many inodes per block!");
    80006866:	00003517          	auipc	a0,0x3
    8000686a:	2c250513          	addi	a0,a0,706 # 80009b28 <syscalls+0x750>
    8000686e:	ffffa097          	auipc	ra,0xffffa
    80006872:	df4080e7          	jalr	-524(ra) # 80000662 <panic>
		panic("ext2_read_super(): Not enough memory to for group_descriptor! Consider increasing the maximum group size");
    80006876:	00003517          	auipc	a0,0x3
    8000687a:	2e250513          	addi	a0,a0,738 # 80009b58 <syscalls+0x780>
    8000687e:	ffffa097          	auipc	ra,0xffffa
    80006882:	de4080e7          	jalr	-540(ra) # 80000662 <panic>
			panic("ext2_read_super(): Could not read ext2 group descriptor!");
    80006886:	00003517          	auipc	a0,0x3
    8000688a:	34250513          	addi	a0,a0,834 # 80009bc8 <syscalls+0x7f0>
    8000688e:	ffffa097          	auipc	ra,0xffffa
    80006892:	dd4080e7          	jalr	-556(ra) # 80000662 <panic>

0000000080006896 <ext2_iupdate>:
{
    80006896:	7179                	addi	sp,sp,-48
    80006898:	f406                	sd	ra,40(sp)
    8000689a:	f022                	sd	s0,32(sp)
    8000689c:	ec26                	sd	s1,24(sp)
    8000689e:	e84a                	sd	s2,16(sp)
    800068a0:	1800                	addi	s0,sp,48
    800068a2:	84aa                	mv	s1,a0
	raw_inode = ext2_get_inode(ip->inum, &buffer);
    800068a4:	fd840593          	addi	a1,s0,-40
    800068a8:	4148                	lw	a0,4(a0)
    800068aa:	00000097          	auipc	ra,0x0
    800068ae:	cfe080e7          	jalr	-770(ra) # 800065a8 <ext2_get_inode>
    800068b2:	892a                	mv	s2,a0
	raw_inode->mode = ip->ext2_inode->inode.mode;
    800068b4:	709c                	ld	a5,32(s1)
    800068b6:	0007d783          	lhu	a5,0(a5)
    800068ba:	00f51023          	sh	a5,0(a0)
	raw_inode->sector_count = ip->ext2_inode->inode.sector_count;
    800068be:	709c                	ld	a5,32(s1)
    800068c0:	4fdc                	lw	a5,28(a5)
    800068c2:	cd5c                	sw	a5,28(a0)
	raw_inode->hard_link_count = ip->ext2_inode->inode.hard_link_count;
    800068c4:	709c                	ld	a5,32(s1)
    800068c6:	01a7d783          	lhu	a5,26(a5)
    800068ca:	00f51d23          	sh	a5,26(a0)
	kmemmove(raw_inode->blocks, ip->ext2_inode->inode.blocks, sizeof(ip->ext2_inode->inode.blocks));
    800068ce:	708c                	ld	a1,32(s1)
    800068d0:	03c00613          	li	a2,60
    800068d4:	02858593          	addi	a1,a1,40
    800068d8:	02850513          	addi	a0,a0,40
    800068dc:	ffffa097          	auipc	ra,0xffffa
    800068e0:	574080e7          	jalr	1396(ra) # 80000e50 <kmemmove>
	raw_inode->size = ip->size;
    800068e4:	589c                	lw	a5,48(s1)
    800068e6:	00f92223          	sw	a5,4(s2)
	ext2_vfs_ops.bwrite(buffer);
    800068ea:	00004497          	auipc	s1,0x4
    800068ee:	bd648493          	addi	s1,s1,-1066 # 8000a4c0 <ext2_inode_ops>
    800068f2:	70dc                	ld	a5,160(s1)
    800068f4:	fd843503          	ld	a0,-40(s0)
    800068f8:	9782                	jalr	a5
	ext2_vfs_ops.brelease(buffer);
    800068fa:	6cdc                	ld	a5,152(s1)
    800068fc:	fd843503          	ld	a0,-40(s0)
    80006900:	9782                	jalr	a5
}
    80006902:	70a2                	ld	ra,40(sp)
    80006904:	7402                	ld	s0,32(sp)
    80006906:	64e2                	ld	s1,24(sp)
    80006908:	6942                	ld	s2,16(sp)
    8000690a:	6145                	addi	sp,sp,48
    8000690c:	8082                	ret

000000008000690e <ext2_writei>:
{
    8000690e:	711d                	addi	sp,sp,-96
    80006910:	ec86                	sd	ra,88(sp)
    80006912:	e8a2                	sd	s0,80(sp)
    80006914:	e4a6                	sd	s1,72(sp)
    80006916:	e0ca                	sd	s2,64(sp)
    80006918:	fc4e                	sd	s3,56(sp)
    8000691a:	f852                	sd	s4,48(sp)
    8000691c:	f456                	sd	s5,40(sp)
    8000691e:	f05a                	sd	s6,32(sp)
    80006920:	ec5e                	sd	s7,24(sp)
    80006922:	e862                	sd	s8,16(sp)
    80006924:	e466                	sd	s9,8(sp)
    80006926:	1080                	addi	s0,sp,96
    80006928:	8c2a                	mv	s8,a0
    8000692a:	8b32                	mv	s6,a2
    8000692c:	8bba                	mv	s7,a4
	if(ip->type == T_DEVICE) {
    8000692e:	02851703          	lh	a4,40(a0)
    80006932:	478d                	li	a5,3
    80006934:	02f70463          	beq	a4,a5,8000695c <ext2_writei+0x4e>
    80006938:	89b6                	mv	s3,a3
	if(off > ip->size || off + n < off)
    8000693a:	591c                	lw	a5,48(a0)
    8000693c:	0cd7e163          	bltu	a5,a3,800069fe <ext2_writei+0xf0>
    80006940:	017687bb          	addw	a5,a3,s7
    80006944:	0ad7ef63          	bltu	a5,a3,80006a02 <ext2_writei+0xf4>
	for(tot = 0; tot < n; tot += m, off += m, src += m) {
    80006948:	0c0b8b63          	beqz	s7,80006a1e <ext2_writei+0x110>
    8000694c:	4a81                	li	s5,0
		buffer_p = ext2_vfs_ops.bread(ip->dev, ext2_inode_ops.bmap(ip, off / EXT2_BLOCK_SIZE));
    8000694e:	00004a17          	auipc	s4,0x4
    80006952:	b72a0a13          	addi	s4,s4,-1166 # 8000a4c0 <ext2_inode_ops>
		m = min(n - tot, EXT2_BLOCK_SIZE - off % EXT2_BLOCK_SIZE);
    80006956:	40000c93          	li	s9,1024
    8000695a:	a08d                	j	800069bc <ext2_writei+0xae>
		if (ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
    8000695c:	02a51783          	lh	a5,42(a0)
    80006960:	03079693          	slli	a3,a5,0x30
    80006964:	92c1                	srli	a3,a3,0x30
    80006966:	4725                	li	a4,9
    80006968:	08d76763          	bltu	a4,a3,800069f6 <ext2_writei+0xe8>
    8000696c:	0792                	slli	a5,a5,0x4
    8000696e:	0001c717          	auipc	a4,0x1c
    80006972:	bca70713          	addi	a4,a4,-1078 # 80022538 <devsw>
    80006976:	97ba                	add	a5,a5,a4
    80006978:	679c                	ld	a5,8(a5)
    8000697a:	c3c1                	beqz	a5,800069fa <ext2_writei+0xec>
		return devsw[ip->major].write(1, src, n);
    8000697c:	865e                	mv	a2,s7
    8000697e:	85da                	mv	a1,s6
    80006980:	4505                	li	a0,1
    80006982:	9782                	jalr	a5
    80006984:	a879                	j	80006a22 <ext2_writei+0x114>
		kmemmove(buffer_p->data + off % EXT2_BLOCK_SIZE, src, m);
    80006986:	05890513          	addi	a0,s2,88
    8000698a:	0004861b          	sext.w	a2,s1
    8000698e:	85da                	mv	a1,s6
    80006990:	953a                	add	a0,a0,a4
    80006992:	ffffa097          	auipc	ra,0xffffa
    80006996:	4be080e7          	jalr	1214(ra) # 80000e50 <kmemmove>
		ext2_vfs_ops.bwrite(buffer_p);
    8000699a:	0a0a3783          	ld	a5,160(s4)
    8000699e:	854a                	mv	a0,s2
    800069a0:	9782                	jalr	a5
		ext2_vfs_ops.brelease(buffer_p);
    800069a2:	098a3783          	ld	a5,152(s4)
    800069a6:	854a                	mv	a0,s2
    800069a8:	9782                	jalr	a5
	for(tot = 0; tot < n; tot += m, off += m, src += m) {
    800069aa:	01548abb          	addw	s5,s1,s5
    800069ae:	013489bb          	addw	s3,s1,s3
    800069b2:	1482                	slli	s1,s1,0x20
    800069b4:	9081                	srli	s1,s1,0x20
    800069b6:	9b26                	add	s6,s6,s1
    800069b8:	057af763          	bgeu	s5,s7,80006a06 <ext2_writei+0xf8>
		buffer_p = ext2_vfs_ops.bread(ip->dev, ext2_inode_ops.bmap(ip, off / EXT2_BLOCK_SIZE));
    800069bc:	0a8a3483          	ld	s1,168(s4)
    800069c0:	000c2903          	lw	s2,0(s8)
    800069c4:	018a3783          	ld	a5,24(s4)
    800069c8:	00a9d59b          	srliw	a1,s3,0xa
    800069cc:	8562                	mv	a0,s8
    800069ce:	9782                	jalr	a5
    800069d0:	0005059b          	sext.w	a1,a0
    800069d4:	854a                	mv	a0,s2
    800069d6:	9482                	jalr	s1
    800069d8:	892a                	mv	s2,a0
		m = min(n - tot, EXT2_BLOCK_SIZE - off % EXT2_BLOCK_SIZE);
    800069da:	3ff9f713          	andi	a4,s3,1023
    800069de:	40ec87bb          	subw	a5,s9,a4
    800069e2:	415b86bb          	subw	a3,s7,s5
    800069e6:	84be                	mv	s1,a5
    800069e8:	2781                	sext.w	a5,a5
    800069ea:	0006861b          	sext.w	a2,a3
    800069ee:	f8f67ce3          	bgeu	a2,a5,80006986 <ext2_writei+0x78>
    800069f2:	84b6                	mv	s1,a3
    800069f4:	bf49                	j	80006986 <ext2_writei+0x78>
			return -1;
    800069f6:	557d                	li	a0,-1
    800069f8:	a02d                	j	80006a22 <ext2_writei+0x114>
    800069fa:	557d                	li	a0,-1
    800069fc:	a01d                	j	80006a22 <ext2_writei+0x114>
		return -1;
    800069fe:	557d                	li	a0,-1
    80006a00:	a00d                	j	80006a22 <ext2_writei+0x114>
    80006a02:	557d                	li	a0,-1
    80006a04:	a839                	j	80006a22 <ext2_writei+0x114>
	if(n > 0 && off > ip->size){
    80006a06:	030c2783          	lw	a5,48(s8)
    80006a0a:	0137fa63          	bgeu	a5,s3,80006a1e <ext2_writei+0x110>
		ip->size = off;
    80006a0e:	033c2823          	sw	s3,48(s8)
		ext2_inode_ops.iupdate(ip);
    80006a12:	8562                	mv	a0,s8
    80006a14:	00004797          	auipc	a5,0x4
    80006a18:	ab47b783          	ld	a5,-1356(a5) # 8000a4c8 <ext2_inode_ops+0x8>
    80006a1c:	9782                	jalr	a5
	return n;
    80006a1e:	000b851b          	sext.w	a0,s7
}
    80006a22:	60e6                	ld	ra,88(sp)
    80006a24:	6446                	ld	s0,80(sp)
    80006a26:	64a6                	ld	s1,72(sp)
    80006a28:	6906                	ld	s2,64(sp)
    80006a2a:	79e2                	ld	s3,56(sp)
    80006a2c:	7a42                	ld	s4,48(sp)
    80006a2e:	7aa2                	ld	s5,40(sp)
    80006a30:	7b02                	ld	s6,32(sp)
    80006a32:	6be2                	ld	s7,24(sp)
    80006a34:	6c42                	ld	s8,16(sp)
    80006a36:	6ca2                	ld	s9,8(sp)
    80006a38:	6125                	addi	sp,sp,96
    80006a3a:	8082                	ret

0000000080006a3c <ext2_iunlock>:
{
    80006a3c:	1101                	addi	sp,sp,-32
    80006a3e:	ec06                	sd	ra,24(sp)
    80006a40:	e822                	sd	s0,16(sp)
    80006a42:	e426                	sd	s1,8(sp)
    80006a44:	1000                	addi	s0,sp,32
	if(ip == 0 || !(ip->flags & I_BUSY) || ip->ref < 1)
    80006a46:	c121                	beqz	a0,80006a86 <ext2_iunlock+0x4a>
    80006a48:	84aa                	mv	s1,a0
    80006a4a:	455c                	lw	a5,12(a0)
    80006a4c:	8b85                	andi	a5,a5,1
    80006a4e:	cf85                	beqz	a5,80006a86 <ext2_iunlock+0x4a>
    80006a50:	451c                	lw	a5,8(a0)
    80006a52:	02f05a63          	blez	a5,80006a86 <ext2_iunlock+0x4a>
	acquire(&itable.lock);
    80006a56:	0001b517          	auipc	a0,0x1b
    80006a5a:	f3250513          	addi	a0,a0,-206 # 80021988 <itable>
    80006a5e:	ffffa097          	auipc	ra,0xffffa
    80006a62:	29a080e7          	jalr	666(ra) # 80000cf8 <acquire>
	ip->flags &= ~I_BUSY;
    80006a66:	44dc                	lw	a5,12(s1)
    80006a68:	9bf9                	andi	a5,a5,-2
    80006a6a:	c4dc                	sw	a5,12(s1)
	release(&itable.lock);
    80006a6c:	0001b517          	auipc	a0,0x1b
    80006a70:	f1c50513          	addi	a0,a0,-228 # 80021988 <itable>
    80006a74:	ffffa097          	auipc	ra,0xffffa
    80006a78:	338080e7          	jalr	824(ra) # 80000dac <release>
}
    80006a7c:	60e2                	ld	ra,24(sp)
    80006a7e:	6442                	ld	s0,16(sp)
    80006a80:	64a2                	ld	s1,8(sp)
    80006a82:	6105                	addi	sp,sp,32
    80006a84:	8082                	ret
		panic("ext2_iunlock(): Inode busy or invalid");
    80006a86:	00003517          	auipc	a0,0x3
    80006a8a:	18250513          	addi	a0,a0,386 # 80009c08 <syscalls+0x830>
    80006a8e:	ffffa097          	auipc	ra,0xffffa
    80006a92:	bd4080e7          	jalr	-1068(ra) # 80000662 <panic>

0000000080006a96 <ext2_idup>:
{
    80006a96:	1101                	addi	sp,sp,-32
    80006a98:	ec06                	sd	ra,24(sp)
    80006a9a:	e822                	sd	s0,16(sp)
    80006a9c:	e426                	sd	s1,8(sp)
    80006a9e:	1000                	addi	s0,sp,32
    80006aa0:	84aa                	mv	s1,a0
	acquire(&itable.lock);
    80006aa2:	0001b517          	auipc	a0,0x1b
    80006aa6:	ee650513          	addi	a0,a0,-282 # 80021988 <itable>
    80006aaa:	ffffa097          	auipc	ra,0xffffa
    80006aae:	24e080e7          	jalr	590(ra) # 80000cf8 <acquire>
	ip->ref++;
    80006ab2:	449c                	lw	a5,8(s1)
    80006ab4:	2785                	addiw	a5,a5,1
    80006ab6:	c49c                	sw	a5,8(s1)
	release(&itable.lock);
    80006ab8:	0001b517          	auipc	a0,0x1b
    80006abc:	ed050513          	addi	a0,a0,-304 # 80021988 <itable>
    80006ac0:	ffffa097          	auipc	ra,0xffffa
    80006ac4:	2ec080e7          	jalr	748(ra) # 80000dac <release>
}
    80006ac8:	8526                	mv	a0,s1
    80006aca:	60e2                	ld	ra,24(sp)
    80006acc:	6442                	ld	s0,16(sp)
    80006ace:	64a2                	ld	s1,8(sp)
    80006ad0:	6105                	addi	sp,sp,32
    80006ad2:	8082                	ret

0000000080006ad4 <ext2_iput>:
{
    80006ad4:	7179                	addi	sp,sp,-48
    80006ad6:	f406                	sd	ra,40(sp)
    80006ad8:	f022                	sd	s0,32(sp)
    80006ada:	ec26                	sd	s1,24(sp)
    80006adc:	e84a                	sd	s2,16(sp)
    80006ade:	e44e                	sd	s3,8(sp)
    80006ae0:	1800                	addi	s0,sp,48
    80006ae2:	892a                	mv	s2,a0
	acquire(&itable.lock);
    80006ae4:	0001b517          	auipc	a0,0x1b
    80006ae8:	ea450513          	addi	a0,a0,-348 # 80021988 <itable>
    80006aec:	ffffa097          	auipc	ra,0xffffa
    80006af0:	20c080e7          	jalr	524(ra) # 80000cf8 <acquire>
	if(ip->ref == 1 && (ip->flags & I_VALID) && ip->nlink == 0) {
    80006af4:	00893703          	ld	a4,8(s2)
    80006af8:	478d                	li	a5,3
    80006afa:	1782                	slli	a5,a5,0x20
    80006afc:	17fd                	addi	a5,a5,-1
    80006afe:	8f7d                	and	a4,a4,a5
    80006b00:	4785                	li	a5,1
    80006b02:	1786                	slli	a5,a5,0x21
    80006b04:	0785                	addi	a5,a5,1
    80006b06:	0af71263          	bne	a4,a5,80006baa <ext2_iput+0xd6>
    80006b0a:	02e91783          	lh	a5,46(s2)
    80006b0e:	efd1                	bnez	a5,80006baa <ext2_iput+0xd6>
		if(ip->flags & I_BUSY)
    80006b10:	00c92783          	lw	a5,12(s2)
    80006b14:	0017f493          	andi	s1,a5,1
    80006b18:	e8b9                	bnez	s1,80006b6e <ext2_iput+0x9a>
		ip->flags |= I_BUSY;
    80006b1a:	0017e793          	ori	a5,a5,1
    80006b1e:	00f92623          	sw	a5,12(s2)
		release(&itable.lock);
    80006b22:	0001b517          	auipc	a0,0x1b
    80006b26:	e6650513          	addi	a0,a0,-410 # 80021988 <itable>
    80006b2a:	ffffa097          	auipc	ra,0xffffa
    80006b2e:	282080e7          	jalr	642(ra) # 80000dac <release>
		ext2_inode_ops.itrunc(ip);
    80006b32:	00004997          	auipc	s3,0x4
    80006b36:	98e98993          	addi	s3,s3,-1650 # 8000a4c0 <ext2_inode_ops>
    80006b3a:	0109b783          	ld	a5,16(s3)
    80006b3e:	854a                	mv	a0,s2
    80006b40:	9782                	jalr	a5
		ip->type = 0;
    80006b42:	02091423          	sh	zero,40(s2)
		ext2_inode_ops.iupdate(ip);
    80006b46:	0089b783          	ld	a5,8(s3)
    80006b4a:	854a                	mv	a0,s2
    80006b4c:	9782                	jalr	a5
			if(ip->ext2_inode == &ext2_active_inodes.inodes[i]) {
    80006b4e:	02093703          	ld	a4,32(s2)
    80006b52:	00022797          	auipc	a5,0x22
    80006b56:	ea678793          	addi	a5,a5,-346 # 800289f8 <ext2_active_inodes+0x18>
		for(int i = 0; i < NINODE; i++) {
    80006b5a:	03200693          	li	a3,50
			if(ip->ext2_inode == &ext2_active_inodes.inodes[i]) {
    80006b5e:	02f70063          	beq	a4,a5,80006b7e <ext2_iput+0xaa>
		for(int i = 0; i < NINODE; i++) {
    80006b62:	2485                	addiw	s1,s1,1
    80006b64:	08078793          	addi	a5,a5,128
    80006b68:	fed49be3          	bne	s1,a3,80006b5e <ext2_iput+0x8a>
    80006b6c:	a02d                	j	80006b96 <ext2_iput+0xc2>
			panic("ext2_iput(): Inode busy");
    80006b6e:	00003517          	auipc	a0,0x3
    80006b72:	0c250513          	addi	a0,a0,194 # 80009c30 <syscalls+0x858>
    80006b76:	ffffa097          	auipc	ra,0xffffa
    80006b7a:	aec080e7          	jalr	-1300(ra) # 80000662 <panic>
				ext2_active_inodes.reserved[i] = INODE_FREE;
    80006b7e:	64448493          	addi	s1,s1,1604
    80006b82:	048a                	slli	s1,s1,0x2
    80006b84:	00022797          	auipc	a5,0x22
    80006b88:	e5c78793          	addi	a5,a5,-420 # 800289e0 <ext2_active_inodes>
    80006b8c:	97a6                	add	a5,a5,s1
    80006b8e:	0007a423          	sw	zero,8(a5)
				ip->ext2_inode = NULL;
    80006b92:	02093023          	sd	zero,32(s2)
		acquire(&itable.lock);
    80006b96:	0001b517          	auipc	a0,0x1b
    80006b9a:	df250513          	addi	a0,a0,-526 # 80021988 <itable>
    80006b9e:	ffffa097          	auipc	ra,0xffffa
    80006ba2:	15a080e7          	jalr	346(ra) # 80000cf8 <acquire>
		ip->flags = 0;
    80006ba6:	00092623          	sw	zero,12(s2)
	ip->ref--;
    80006baa:	00892783          	lw	a5,8(s2)
    80006bae:	37fd                	addiw	a5,a5,-1
    80006bb0:	00f92423          	sw	a5,8(s2)
	release(&itable.lock);
    80006bb4:	0001b517          	auipc	a0,0x1b
    80006bb8:	dd450513          	addi	a0,a0,-556 # 80021988 <itable>
    80006bbc:	ffffa097          	auipc	ra,0xffffa
    80006bc0:	1f0080e7          	jalr	496(ra) # 80000dac <release>
}
    80006bc4:	70a2                	ld	ra,40(sp)
    80006bc6:	7402                	ld	s0,32(sp)
    80006bc8:	64e2                	ld	s1,24(sp)
    80006bca:	6942                	ld	s2,16(sp)
    80006bcc:	69a2                	ld	s3,8(sp)
    80006bce:	6145                	addi	sp,sp,48
    80006bd0:	8082                	ret

0000000080006bd2 <ext2_ilock>:
{
    80006bd2:	7179                	addi	sp,sp,-48
    80006bd4:	f406                	sd	ra,40(sp)
    80006bd6:	f022                	sd	s0,32(sp)
    80006bd8:	ec26                	sd	s1,24(sp)
    80006bda:	e84a                	sd	s2,16(sp)
    80006bdc:	1800                	addi	s0,sp,48
	if(ip == NULL || ip->ref < 1) {
    80006bde:	c13d                	beqz	a0,80006c44 <ext2_ilock+0x72>
    80006be0:	84aa                	mv	s1,a0
    80006be2:	451c                	lw	a5,8(a0)
    80006be4:	06f05063          	blez	a5,80006c44 <ext2_ilock+0x72>
	acquire(&itable.lock);
    80006be8:	0001b517          	auipc	a0,0x1b
    80006bec:	da050513          	addi	a0,a0,-608 # 80021988 <itable>
    80006bf0:	ffffa097          	auipc	ra,0xffffa
    80006bf4:	108080e7          	jalr	264(ra) # 80000cf8 <acquire>
	while(ip->flags & I_BUSY)
    80006bf8:	44dc                	lw	a5,12(s1)
    80006bfa:	0017f713          	andi	a4,a5,1
    80006bfe:	cf19                	beqz	a4,80006c1c <ext2_ilock+0x4a>
		_sleep(ip, &itable.lock);
    80006c00:	0001b917          	auipc	s2,0x1b
    80006c04:	d8890913          	addi	s2,s2,-632 # 80021988 <itable>
    80006c08:	85ca                	mv	a1,s2
    80006c0a:	8526                	mv	a0,s1
    80006c0c:	ffffb097          	auipc	ra,0xffffb
    80006c10:	5a6080e7          	jalr	1446(ra) # 800021b2 <_sleep>
	while(ip->flags & I_BUSY)
    80006c14:	44dc                	lw	a5,12(s1)
    80006c16:	0017f713          	andi	a4,a5,1
    80006c1a:	f77d                	bnez	a4,80006c08 <ext2_ilock+0x36>
	ip->flags |= I_BUSY;
    80006c1c:	0017e793          	ori	a5,a5,1
    80006c20:	c4dc                	sw	a5,12(s1)
	release(&itable.lock);
    80006c22:	0001b517          	auipc	a0,0x1b
    80006c26:	d6650513          	addi	a0,a0,-666 # 80021988 <itable>
    80006c2a:	ffffa097          	auipc	ra,0xffffa
    80006c2e:	182080e7          	jalr	386(ra) # 80000dac <release>
	if(!(ip->flags & I_VALID)) {
    80006c32:	44dc                	lw	a5,12(s1)
    80006c34:	8b89                	andi	a5,a5,2
    80006c36:	cf99                	beqz	a5,80006c54 <ext2_ilock+0x82>
}
    80006c38:	70a2                	ld	ra,40(sp)
    80006c3a:	7402                	ld	s0,32(sp)
    80006c3c:	64e2                	ld	s1,24(sp)
    80006c3e:	6942                	ld	s2,16(sp)
    80006c40:	6145                	addi	sp,sp,48
    80006c42:	8082                	ret
		panic("ext2_ilock(): Bad inode");
    80006c44:	00003517          	auipc	a0,0x3
    80006c48:	00450513          	addi	a0,a0,4 # 80009c48 <syscalls+0x870>
    80006c4c:	ffffa097          	auipc	ra,0xffffa
    80006c50:	a16080e7          	jalr	-1514(ra) # 80000662 <panic>
		raw_inode = ext2_get_inode(ip->inum, &buffer_p);
    80006c54:	fd840593          	addi	a1,s0,-40
    80006c58:	40c8                	lw	a0,4(s1)
    80006c5a:	00000097          	auipc	ra,0x0
    80006c5e:	94e080e7          	jalr	-1714(ra) # 800065a8 <ext2_get_inode>
    80006c62:	85aa                	mv	a1,a0
		if(EXT2_IS_DIR(raw_inode->mode)) {
    80006c64:	00055703          	lhu	a4,0(a0)
    80006c68:	77fd                	lui	a5,0xfffff
    80006c6a:	00f776b3          	and	a3,a4,a5
    80006c6e:	6611                	lui	a2,0x4
    80006c70:	02c68363          	beq	a3,a2,80006c96 <ext2_ilock+0xc4>
		} else if(EXT2_IS_FILE(raw_inode->mode)) {
    80006c74:	2681                	sext.w	a3,a3
    80006c76:	67a1                	lui	a5,0x8
    80006c78:	06f68463          	beq	a3,a5,80006ce0 <ext2_ilock+0x10e>
		} else if(EXT2_IS_CHAR_DEV(raw_inode->mode) || EXT2_IS_BLOCK_DEV(raw_inode->mode)) {
    80006c7c:	77ed                	lui	a5,0xffffb
    80006c7e:	8f7d                	and	a4,a4,a5
    80006c80:	6789                	lui	a5,0x2
    80006c82:	06f70163          	beq	a4,a5,80006ce4 <ext2_ilock+0x112>
			panic("ext2_ilock(): Invalid file mode");
    80006c86:	00003517          	auipc	a0,0x3
    80006c8a:	fda50513          	addi	a0,a0,-38 # 80009c60 <syscalls+0x888>
    80006c8e:	ffffa097          	auipc	ra,0xffffa
    80006c92:	9d4080e7          	jalr	-1580(ra) # 80000662 <panic>
    80006c96:	4785                	li	a5,1
			ip->type = T_DIR;
    80006c98:	02f49423          	sh	a5,40(s1)
		ip->nlink = raw_inode->hard_link_count;
    80006c9c:	01a5d783          	lhu	a5,26(a1)
    80006ca0:	02f49723          	sh	a5,46(s1)
		ip->size = raw_inode->size;
    80006ca4:	41dc                	lw	a5,4(a1)
    80006ca6:	d89c                	sw	a5,48(s1)
		kmemmove(&ip->ext2_inode->inode, raw_inode, sizeof(raw_inode));
    80006ca8:	4621                	li	a2,8
    80006caa:	7088                	ld	a0,32(s1)
    80006cac:	ffffa097          	auipc	ra,0xffffa
    80006cb0:	1a4080e7          	jalr	420(ra) # 80000e50 <kmemmove>
		ext2_vfs_ops.brelease(buffer_p);
    80006cb4:	fd843503          	ld	a0,-40(s0)
    80006cb8:	00004797          	auipc	a5,0x4
    80006cbc:	8a07b783          	ld	a5,-1888(a5) # 8000a558 <ext2_vfs_ops+0x30>
    80006cc0:	9782                	jalr	a5
		ip->flags |= I_VALID;
    80006cc2:	44dc                	lw	a5,12(s1)
    80006cc4:	0027e793          	ori	a5,a5,2
    80006cc8:	c4dc                	sw	a5,12(s1)
		if(ip->type == 0) {
    80006cca:	02849783          	lh	a5,40(s1)
    80006cce:	f7ad                	bnez	a5,80006c38 <ext2_ilock+0x66>
			panic("ext2_ilock(): Invalid type");
    80006cd0:	00003517          	auipc	a0,0x3
    80006cd4:	fb050513          	addi	a0,a0,-80 # 80009c80 <syscalls+0x8a8>
    80006cd8:	ffffa097          	auipc	ra,0xffffa
    80006cdc:	98a080e7          	jalr	-1654(ra) # 80000662 <panic>
    80006ce0:	4789                	li	a5,2
    80006ce2:	bf5d                	j	80006c98 <ext2_ilock+0xc6>
    80006ce4:	478d                	li	a5,3
    80006ce6:	bf4d                	j	80006c98 <ext2_ilock+0xc6>

0000000080006ce8 <ext2_readi>:
{
    80006ce8:	7119                	addi	sp,sp,-128
    80006cea:	fc86                	sd	ra,120(sp)
    80006cec:	f8a2                	sd	s0,112(sp)
    80006cee:	f4a6                	sd	s1,104(sp)
    80006cf0:	f0ca                	sd	s2,96(sp)
    80006cf2:	ecce                	sd	s3,88(sp)
    80006cf4:	e8d2                	sd	s4,80(sp)
    80006cf6:	e4d6                	sd	s5,72(sp)
    80006cf8:	e0da                	sd	s6,64(sp)
    80006cfa:	fc5e                	sd	s7,56(sp)
    80006cfc:	f862                	sd	s8,48(sp)
    80006cfe:	f466                	sd	s9,40(sp)
    80006d00:	f06a                	sd	s10,32(sp)
    80006d02:	ec6e                	sd	s11,24(sp)
    80006d04:	0100                	addi	s0,sp,128
    80006d06:	f8b43423          	sd	a1,-120(s0)
	if(off > ip->size || off + n < off) {
    80006d0a:	591c                	lw	a5,48(a0)
    80006d0c:	0cd7eb63          	bltu	a5,a3,80006de2 <ext2_readi+0xfa>
    80006d10:	8caa                	mv	s9,a0
    80006d12:	8ab2                	mv	s5,a2
    80006d14:	8936                	mv	s2,a3
    80006d16:	8c3a                	mv	s8,a4
    80006d18:	9f35                	addw	a4,a4,a3
    80006d1a:	0cd76663          	bltu	a4,a3,80006de6 <ext2_readi+0xfe>
	if(off + n > ip->size) {
    80006d1e:	00e7f463          	bgeu	a5,a4,80006d26 <ext2_readi+0x3e>
		n = ip->size - off;
    80006d22:	40d78c3b          	subw	s8,a5,a3
	for(tot = 0; tot < n; tot += m, off += m, dst += m) {
    80006d26:	0a0c0c63          	beqz	s8,80006dde <ext2_readi+0xf6>
    80006d2a:	4a01                	li	s4,0
		buffer_p = ext2_vfs_ops.bread(ip->dev, ext2_inode_ops.bmap(ip, off / BSIZE));
    80006d2c:	00003b17          	auipc	s6,0x3
    80006d30:	794b0b13          	addi	s6,s6,1940 # 8000a4c0 <ext2_inode_ops>
		m = min(n - tot, BSIZE - off % BSIZE);
    80006d34:	40000d93          	li	s11,1024
		if(either_copyout(user_dst, dst, buffer_p->data + (off % BSIZE), m) == -1) {
    80006d38:	5d7d                	li	s10,-1
    80006d3a:	a82d                	j	80006d74 <ext2_readi+0x8c>
    80006d3c:	02099b93          	slli	s7,s3,0x20
    80006d40:	020bdb93          	srli	s7,s7,0x20
    80006d44:	05848613          	addi	a2,s1,88
    80006d48:	86de                	mv	a3,s7
    80006d4a:	963a                	add	a2,a2,a4
    80006d4c:	85d6                	mv	a1,s5
    80006d4e:	f8843503          	ld	a0,-120(s0)
    80006d52:	ffffc097          	auipc	ra,0xffffc
    80006d56:	802080e7          	jalr	-2046(ra) # 80002554 <either_copyout>
    80006d5a:	05a50a63          	beq	a0,s10,80006dae <ext2_readi+0xc6>
		ext2_vfs_ops.brelease(buffer_p);
    80006d5e:	098b3783          	ld	a5,152(s6)
    80006d62:	8526                	mv	a0,s1
    80006d64:	9782                	jalr	a5
	for(tot = 0; tot < n; tot += m, off += m, dst += m) {
    80006d66:	01498a3b          	addw	s4,s3,s4
    80006d6a:	0129893b          	addw	s2,s3,s2
    80006d6e:	9ade                	add	s5,s5,s7
    80006d70:	058a7663          	bgeu	s4,s8,80006dbc <ext2_readi+0xd4>
		buffer_p = ext2_vfs_ops.bread(ip->dev, ext2_inode_ops.bmap(ip, off / BSIZE));
    80006d74:	0a8b3483          	ld	s1,168(s6)
    80006d78:	000ca983          	lw	s3,0(s9)
    80006d7c:	018b3783          	ld	a5,24(s6)
    80006d80:	00a9559b          	srliw	a1,s2,0xa
    80006d84:	8566                	mv	a0,s9
    80006d86:	9782                	jalr	a5
    80006d88:	0005059b          	sext.w	a1,a0
    80006d8c:	854e                	mv	a0,s3
    80006d8e:	9482                	jalr	s1
    80006d90:	84aa                	mv	s1,a0
		m = min(n - tot, BSIZE - off % BSIZE);
    80006d92:	3ff97713          	andi	a4,s2,1023
    80006d96:	40ed87bb          	subw	a5,s11,a4
    80006d9a:	414c06bb          	subw	a3,s8,s4
    80006d9e:	89be                	mv	s3,a5
    80006da0:	2781                	sext.w	a5,a5
    80006da2:	0006861b          	sext.w	a2,a3
    80006da6:	f8f67be3          	bgeu	a2,a5,80006d3c <ext2_readi+0x54>
    80006daa:	89b6                	mv	s3,a3
    80006dac:	bf41                	j	80006d3c <ext2_readi+0x54>
			ext2_vfs_ops.brelease(buffer_p);
    80006dae:	8526                	mv	a0,s1
    80006db0:	00003797          	auipc	a5,0x3
    80006db4:	7a87b783          	ld	a5,1960(a5) # 8000a558 <ext2_vfs_ops+0x30>
    80006db8:	9782                	jalr	a5
			tot = -1;
    80006dba:	5a7d                	li	s4,-1
	return tot;
    80006dbc:	000a051b          	sext.w	a0,s4
}
    80006dc0:	70e6                	ld	ra,120(sp)
    80006dc2:	7446                	ld	s0,112(sp)
    80006dc4:	74a6                	ld	s1,104(sp)
    80006dc6:	7906                	ld	s2,96(sp)
    80006dc8:	69e6                	ld	s3,88(sp)
    80006dca:	6a46                	ld	s4,80(sp)
    80006dcc:	6aa6                	ld	s5,72(sp)
    80006dce:	6b06                	ld	s6,64(sp)
    80006dd0:	7be2                	ld	s7,56(sp)
    80006dd2:	7c42                	ld	s8,48(sp)
    80006dd4:	7ca2                	ld	s9,40(sp)
    80006dd6:	7d02                	ld	s10,32(sp)
    80006dd8:	6de2                	ld	s11,24(sp)
    80006dda:	6109                	addi	sp,sp,128
    80006ddc:	8082                	ret
	for(tot = 0; tot < n; tot += m, off += m, dst += m) {
    80006dde:	8a62                	mv	s4,s8
    80006de0:	bff1                	j	80006dbc <ext2_readi+0xd4>
		return -1;
    80006de2:	557d                	li	a0,-1
    80006de4:	bff1                	j	80006dc0 <ext2_readi+0xd8>
    80006de6:	557d                	li	a0,-1
    80006de8:	bfe1                	j	80006dc0 <ext2_readi+0xd8>

0000000080006dea <ext2_new_blocks>:
{
    80006dea:	7159                	addi	sp,sp,-112
    80006dec:	f486                	sd	ra,104(sp)
    80006dee:	f0a2                	sd	s0,96(sp)
    80006df0:	eca6                	sd	s1,88(sp)
    80006df2:	e8ca                	sd	s2,80(sp)
    80006df4:	e4ce                	sd	s3,72(sp)
    80006df6:	e0d2                	sd	s4,64(sp)
    80006df8:	fc56                	sd	s5,56(sp)
    80006dfa:	f85a                	sd	s6,48(sp)
    80006dfc:	f45e                	sd	s7,40(sp)
    80006dfe:	f062                	sd	s8,32(sp)
    80006e00:	ec66                	sd	s9,24(sp)
    80006e02:	e86a                	sd	s10,16(sp)
    80006e04:	1880                	addi	s0,sp,112
    80006e06:	8c36                	mv	s8,a3
	unsigned long num = *count;
    80006e08:	621c                	ld	a5,0(a2)
    80006e0a:	f8f43823          	sd	a5,-112(s0)
	*errp = -1;
    80006e0e:	57fd                	li	a5,-1
    80006e10:	c29c                	sw	a5,0(a3)
	if(goal < root_fs->superblock.ext2_in_mem_super.disk_super->superblock_block || goal >= root_fs->superblock.ext2_in_mem_super.disk_super->block_count) {
    80006e12:	00004797          	auipc	a5,0x4
    80006e16:	2267b783          	ld	a5,550(a5) # 8000b038 <root_fs>
    80006e1a:	63d8                	ld	a4,128(a5)
    80006e1c:	01476483          	lwu	s1,20(a4)
		goal = root_fs->superblock.ext2_in_mem_super.disk_super->superblock_block;
    80006e20:	8ba6                	mv	s7,s1
	if(goal < root_fs->superblock.ext2_in_mem_super.disk_super->superblock_block || goal >= root_fs->superblock.ext2_in_mem_super.disk_super->block_count) {
    80006e22:	0095e863          	bltu	a1,s1,80006e32 <ext2_new_blocks+0x48>
    80006e26:	8bae                	mv	s7,a1
    80006e28:	00476703          	lwu	a4,4(a4)
    80006e2c:	00e5e363          	bltu	a1,a4,80006e32 <ext2_new_blocks+0x48>
		goal = root_fs->superblock.ext2_in_mem_super.disk_super->superblock_block;
    80006e30:	8ba6                	mv	s7,s1
	group_num = (goal - root_fs->superblock.ext2_in_mem_super.disk_super->superblock_block) / root_fs->superblock.ext2_in_mem_super.blocks_per_block_group;
    80006e32:	409b84b3          	sub	s1,s7,s1
    80006e36:	7f9c                	ld	a5,56(a5)
    80006e38:	02f4d4b3          	divu	s1,s1,a5
    80006e3c:	2481                	sext.w	s1,s1
	struct buf * bitmap_buffer = 0;
    80006e3e:	4981                	li	s3,0
	ngroups = root_fs->superblock.ext2_in_mem_super.group_count;
    80006e40:	00004c97          	auipc	s9,0x4
    80006e44:	1f8c8c93          	addi	s9,s9,504 # 8000b038 <root_fs>
		ext2_vfs_ops.brelease(bitmap_buffer);
    80006e48:	00003b17          	auipc	s6,0x3
    80006e4c:	678b0b13          	addi	s6,s6,1656 # 8000a4c0 <ext2_inode_ops>
	descriptor = ext2_get_group_descriptor(group_num, &descriptor_buffer);
    80006e50:	00048a1b          	sext.w	s4,s1
    80006e54:	f9840593          	addi	a1,s0,-104
    80006e58:	8552                	mv	a0,s4
    80006e5a:	fffff097          	auipc	ra,0xfffff
    80006e5e:	6ae080e7          	jalr	1710(ra) # 80006508 <ext2_get_group_descriptor>
    80006e62:	892a                	mv	s2,a0
	if(!descriptor) {
    80006e64:	16050763          	beqz	a0,80006fd2 <ext2_new_blocks+0x1e8>
	if(free_blocks > 0) {
    80006e68:	00c55783          	lhu	a5,12(a0)
    80006e6c:	c7ed                	beqz	a5,80006f56 <ext2_new_blocks+0x16c>
		group_target_block = ((goal - root_fs->superblock.ext2_in_mem_super.disk_super->superblock_block) % root_fs->superblock.ext2_in_mem_super.blocks_per_block_group);
    80006e6e:	000cb783          	ld	a5,0(s9)
    80006e72:	63d8                	ld	a4,128(a5)
    80006e74:	01476603          	lwu	a2,20(a4)
    80006e78:	40cb8633          	sub	a2,s7,a2
    80006e7c:	7f9c                	ld	a5,56(a5)
    80006e7e:	02f67633          	remu	a2,a2,a5
    80006e82:	00060a9b          	sext.w	s5,a2
		bitmap_buffer = read_block_bitmap(group_num);
    80006e86:	8552                	mv	a0,s4
    80006e88:	fffff097          	auipc	ra,0xfffff
    80006e8c:	6ec080e7          	jalr	1772(ra) # 80006574 <read_block_bitmap>
    80006e90:	89aa                	mv	s3,a0
		if(!bitmap_buffer) {
    80006e92:	14050063          	beqz	a0,80006fd2 <ext2_new_blocks+0x1e8>
		group_allocated_block = ext2_try_to_allocate(group_num, bitmap_buffer, group_target_block, &num);
    80006e96:	f9040693          	addi	a3,s0,-112
    80006e9a:	8656                	mv	a2,s5
    80006e9c:	85aa                	mv	a1,a0
    80006e9e:	8526                	mv	a0,s1
    80006ea0:	fffff097          	auipc	ra,0xfffff
    80006ea4:	570080e7          	jalr	1392(ra) # 80006410 <ext2_try_to_allocate>
		if(group_allocated_block >= 0)
    80006ea8:	0a054763          	bltz	a0,80006f56 <ext2_new_blocks+0x16c>
	return group_num * root_fs->superblock.ext2_in_mem_super.blocks_per_block_group + root_fs->superblock.ext2_in_mem_super.disk_super->superblock_block;
    80006eac:	000cb703          	ld	a4,0(s9)
    80006eb0:	634c                	ld	a1,128(a4)
    80006eb2:	0145ea03          	lwu	s4,20(a1)
	return_block = group_allocated_block + ext2_group_first_block_num(group_num);
    80006eb6:	9a2a                	add	s4,s4,a0
	return group_num * root_fs->superblock.ext2_in_mem_super.blocks_per_block_group + root_fs->superblock.ext2_in_mem_super.disk_super->superblock_block;
    80006eb8:	7f1c                	ld	a5,56(a4)
    80006eba:	02f487b3          	mul	a5,s1,a5
	return_block = group_allocated_block + ext2_group_first_block_num(group_num);
    80006ebe:	9a3e                	add	s4,s4,a5
	if(in_range(descriptor->block_bitmap, return_block, num) || in_range(descriptor->inode_bitmap, return_block, num) || in_range(return_block, descriptor->inode_table, root_fs->superblock.ext2_in_mem_super.inode_table_blocks_per_group) || in_range(return_block + num - 1, descriptor->inode_table, root_fs->superblock.ext2_in_mem_super.inode_table_blocks_per_group)) {
    80006ec0:	00096683          	lwu	a3,0(s2)
    80006ec4:	0146e863          	bltu	a3,s4,80006ed4 <ext2_new_blocks+0xea>
    80006ec8:	f9043783          	ld	a5,-112(s0)
    80006ecc:	17fd                	addi	a5,a5,-1
    80006ece:	97d2                	add	a5,a5,s4
    80006ed0:	f8d7f0e3          	bgeu	a5,a3,80006e50 <ext2_new_blocks+0x66>
    80006ed4:	00496683          	lwu	a3,4(s2)
    80006ed8:	0146e863          	bltu	a3,s4,80006ee8 <ext2_new_blocks+0xfe>
    80006edc:	f9043783          	ld	a5,-112(s0)
    80006ee0:	17fd                	addi	a5,a5,-1
    80006ee2:	97d2                	add	a5,a5,s4
    80006ee4:	f6d7f6e3          	bgeu	a5,a3,80006e50 <ext2_new_blocks+0x66>
    80006ee8:	00896603          	lwu	a2,8(s2)
    80006eec:	00ca6763          	bltu	s4,a2,80006efa <ext2_new_blocks+0x110>
    80006ef0:	673c                	ld	a5,72(a4)
    80006ef2:	17fd                	addi	a5,a5,-1
    80006ef4:	97b2                	add	a5,a5,a2
    80006ef6:	f547fde3          	bgeu	a5,s4,80006e50 <ext2_new_blocks+0x66>
    80006efa:	f9043503          	ld	a0,-112(s0)
    80006efe:	fff50693          	addi	a3,a0,-1
    80006f02:	96d2                	add	a3,a3,s4
    80006f04:	00c6e763          	bltu	a3,a2,80006f12 <ext2_new_blocks+0x128>
    80006f08:	673c                	ld	a5,72(a4)
    80006f0a:	17fd                	addi	a5,a5,-1
    80006f0c:	97b2                	add	a5,a5,a2
    80006f0e:	f4d7f1e3          	bgeu	a5,a3,80006e50 <ext2_new_blocks+0x66>
	if(return_block + num - 1 >= root_fs->superblock.ext2_in_mem_super.disk_super->block_count) {
    80006f12:	0045e783          	lwu	a5,4(a1)
    80006f16:	0af6f663          	bgeu	a3,a5,80006fc2 <ext2_new_blocks+0x1d8>
	group_adjust_blocks(descriptor, descriptor_buffer, -num);
    80006f1a:	40a0053b          	negw	a0,a0
    80006f1e:	0005079b          	sext.w	a5,a0
	if(count) {
    80006f22:	cf89                	beqz	a5,80006f3c <ext2_new_blocks+0x152>
		descriptor->free_blocks_count = descriptor->free_blocks_count + count;
    80006f24:	00c95783          	lhu	a5,12(s2)
    80006f28:	9d3d                	addw	a0,a0,a5
    80006f2a:	00a91623          	sh	a0,12(s2)
		ext2_vfs_ops.bwrite(buffer);
    80006f2e:	f9843503          	ld	a0,-104(s0)
    80006f32:	00003797          	auipc	a5,0x3
    80006f36:	62e7b783          	ld	a5,1582(a5) # 8000a560 <ext2_vfs_ops+0x38>
    80006f3a:	9782                	jalr	a5
	ext2_vfs_ops.bwrite(bitmap_buffer);
    80006f3c:	00003497          	auipc	s1,0x3
    80006f40:	58448493          	addi	s1,s1,1412 # 8000a4c0 <ext2_inode_ops>
    80006f44:	70dc                	ld	a5,160(s1)
    80006f46:	854e                	mv	a0,s3
    80006f48:	9782                	jalr	a5
	*errp = 0;
    80006f4a:	000c2023          	sw	zero,0(s8)
	ext2_vfs_ops.brelease(bitmap_buffer);
    80006f4e:	6cdc                	ld	a5,152(s1)
    80006f50:	854e                	mv	a0,s3
    80006f52:	9782                	jalr	a5
	return return_block;
    80006f54:	a849                	j	80006fe6 <ext2_new_blocks+0x1fc>
	ngroups = root_fs->superblock.ext2_in_mem_super.group_count;
    80006f56:	000cb783          	ld	a5,0(s9)
    80006f5a:	0607ba83          	ld	s5,96(a5)
	for(int block_group_index = 0; block_group_index < ngroups; block_group_index++) {
    80006f5e:	060a8d63          	beqz	s5,80006fd8 <ext2_new_blocks+0x1ee>
    80006f62:	4a01                	li	s4,0
    80006f64:	a021                	j	80006f6c <ext2_new_blocks+0x182>
    80006f66:	0a05                	addi	s4,s4,1
    80006f68:	074a8863          	beq	s5,s4,80006fd8 <ext2_new_blocks+0x1ee>
		group_num++;
    80006f6c:	2485                	addiw	s1,s1,1
			group_num = 0;
    80006f6e:	0154b7b3          	sltu	a5,s1,s5
    80006f72:	40f007b3          	neg	a5,a5
    80006f76:	8cfd                	and	s1,s1,a5
		descriptor = ext2_get_group_descriptor(group_num, &descriptor_buffer);
    80006f78:	00048d1b          	sext.w	s10,s1
    80006f7c:	f9840593          	addi	a1,s0,-104
    80006f80:	856a                	mv	a0,s10
    80006f82:	fffff097          	auipc	ra,0xfffff
    80006f86:	586080e7          	jalr	1414(ra) # 80006508 <ext2_get_group_descriptor>
    80006f8a:	892a                	mv	s2,a0
		if(!descriptor) {
    80006f8c:	c139                	beqz	a0,80006fd2 <ext2_new_blocks+0x1e8>
		if(!free_blocks) {
    80006f8e:	00c55783          	lhu	a5,12(a0)
    80006f92:	dbf1                	beqz	a5,80006f66 <ext2_new_blocks+0x17c>
		ext2_vfs_ops.brelease(bitmap_buffer);
    80006f94:	098b3783          	ld	a5,152(s6)
    80006f98:	854e                	mv	a0,s3
    80006f9a:	9782                	jalr	a5
		bitmap_buffer = read_block_bitmap(group_num);
    80006f9c:	856a                	mv	a0,s10
    80006f9e:	fffff097          	auipc	ra,0xfffff
    80006fa2:	5d6080e7          	jalr	1494(ra) # 80006574 <read_block_bitmap>
    80006fa6:	89aa                	mv	s3,a0
		if(!bitmap_buffer) {
    80006fa8:	c50d                	beqz	a0,80006fd2 <ext2_new_blocks+0x1e8>
		group_allocated_block = ext2_try_to_allocate(group_num, bitmap_buffer, -1, &num);
    80006faa:	f9040693          	addi	a3,s0,-112
    80006fae:	567d                	li	a2,-1
    80006fb0:	85aa                	mv	a1,a0
    80006fb2:	8526                	mv	a0,s1
    80006fb4:	fffff097          	auipc	ra,0xfffff
    80006fb8:	45c080e7          	jalr	1116(ra) # 80006410 <ext2_try_to_allocate>
		if(group_allocated_block >= 0) {
    80006fbc:	fa0545e3          	bltz	a0,80006f66 <ext2_new_blocks+0x17c>
    80006fc0:	b5f5                	j	80006eac <ext2_new_blocks+0xc2>
		panic("ext2_new_blocks(): Invalid block number");
    80006fc2:	00003517          	auipc	a0,0x3
    80006fc6:	cde50513          	addi	a0,a0,-802 # 80009ca0 <syscalls+0x8c8>
    80006fca:	ffff9097          	auipc	ra,0xffff9
    80006fce:	698080e7          	jalr	1688(ra) # 80000662 <panic>
	*errp = -2;
    80006fd2:	57f9                	li	a5,-2
    80006fd4:	00fc2023          	sw	a5,0(s8)
	ext2_vfs_ops.brelease(bitmap_buffer);
    80006fd8:	854e                	mv	a0,s3
    80006fda:	00003797          	auipc	a5,0x3
    80006fde:	57e7b783          	ld	a5,1406(a5) # 8000a558 <ext2_vfs_ops+0x30>
    80006fe2:	9782                	jalr	a5
	return 0;
    80006fe4:	4a01                	li	s4,0
}
    80006fe6:	8552                	mv	a0,s4
    80006fe8:	70a6                	ld	ra,104(sp)
    80006fea:	7406                	ld	s0,96(sp)
    80006fec:	64e6                	ld	s1,88(sp)
    80006fee:	6946                	ld	s2,80(sp)
    80006ff0:	69a6                	ld	s3,72(sp)
    80006ff2:	6a06                	ld	s4,64(sp)
    80006ff4:	7ae2                	ld	s5,56(sp)
    80006ff6:	7b42                	ld	s6,48(sp)
    80006ff8:	7ba2                	ld	s7,40(sp)
    80006ffa:	7c02                	ld	s8,32(sp)
    80006ffc:	6ce2                	ld	s9,24(sp)
    80006ffe:	6d42                	ld	s10,16(sp)
    80007000:	6165                	addi	sp,sp,112
    80007002:	8082                	ret

0000000080007004 <ext2_bmap>:
{
    80007004:	7169                	addi	sp,sp,-304
    80007006:	f606                	sd	ra,296(sp)
    80007008:	f222                	sd	s0,288(sp)
    8000700a:	ee26                	sd	s1,280(sp)
    8000700c:	ea4a                	sd	s2,272(sp)
    8000700e:	e64e                	sd	s3,264(sp)
    80007010:	e252                	sd	s4,256(sp)
    80007012:	fdd6                	sd	s5,248(sp)
    80007014:	f9da                	sd	s6,240(sp)
    80007016:	f5de                	sd	s7,232(sp)
    80007018:	f1e2                	sd	s8,224(sp)
    8000701a:	ede6                	sd	s9,216(sp)
    8000701c:	e9ea                	sd	s10,208(sp)
    8000701e:	e5ee                	sd	s11,200(sp)
    80007020:	1a00                	addi	s0,sp,304
    80007022:	8aaa                	mv	s5,a0
    80007024:	eeb43423          	sd	a1,-280(s0)
	int offsets[4] = { 0 };
    80007028:	f8043023          	sd	zero,-128(s0)
    8000702c:	f8043423          	sd	zero,-120(s0)
	depth = ext2_block_to_path(ip, block_num, offsets, &blocks_to_boundary);
    80007030:	02059c93          	slli	s9,a1,0x20
    80007034:	020cdc93          	srli	s9,s9,0x20
	int pointers = root_fs->superblock.block_size / sizeof(unsigned int);
    80007038:	00004717          	auipc	a4,0x4
    8000703c:	00073703          	ld	a4,0(a4) # 8000b038 <root_fs>
    80007040:	4f5c                	lw	a5,28(a4)
    80007042:	0027da1b          	srliw	s4,a5,0x2
    80007046:	0027dc1b          	srliw	s8,a5,0x2
	int pointers_bits = root_fs->superblock.ext2_in_mem_super.address_per_block_bits;
    8000704a:	1cc72783          	lw	a5,460(a4)
	} else if(inode_block < direct_blocks) {
    8000704e:	472d                	li	a4,11
    80007050:	05974263          	blt	a4,s9,80007094 <ext2_bmap+0x90>
		offsets[n++] = inode_block;
    80007054:	f8b42023          	sw	a1,-128(s0)
		final = direct_blocks;
    80007058:	4c31                	li	s8,12
		offsets[n++] = inode_block;
    8000705a:	4d85                	li	s11,1
	add_chain(chain, 0, inode->ext2_inode->inode.blocks + *offsets);
    8000705c:	020ab783          	ld	a5,32(s5)
    80007060:	02878793          	addi	a5,a5,40
    80007064:	f8042703          	lw	a4,-128(s0)
    80007068:	070a                	slli	a4,a4,0x2
    8000706a:	97ba                	add	a5,a5,a4
	p->key = *(p->p = v);
    8000706c:	f2f43023          	sd	a5,-224(s0)
    80007070:	439c                	lw	a5,0(a5)
    80007072:	f2f42423          	sw	a5,-216(s0)
	p->buffer = buffer;
    80007076:	f2043823          	sd	zero,-208(s0)
	if(!p->key) {
    8000707a:	46078663          	beqz	a5,800074e6 <ext2_bmap+0x4e2>
    8000707e:	896e                	mv	s2,s11
	Indirect * p = chain;
    80007080:	f2040493          	addi	s1,s0,-224
    80007084:	f8040993          	addi	s3,s0,-128
		buffer = ext2_vfs_ops.bread(inode->dev, p->key);
    80007088:	00003b97          	auipc	s7,0x3
    8000708c:	438b8b93          	addi	s7,s7,1080 # 8000a4c0 <ext2_inode_ops>
	for(;from <= to && from->key == *from->p; from++)
    80007090:	8b26                	mv	s6,s1
    80007092:	a85d                	j	80007148 <ext2_bmap+0x144>
	} else if((inode_block -= direct_blocks) < indirect_blocks) {
    80007094:	1cd1                	addi	s9,s9,-12
    80007096:	058cc363          	blt	s9,s8,800070dc <ext2_bmap+0xd8>
	const long direct_blocks = EXT2_DIR_BLOCK_COUNT, indirect_blocks = pointers, double_blocks = (1 << (pointers_bits * 2));
    8000709a:	0017969b          	slliw	a3,a5,0x1
    8000709e:	4705                	li	a4,1
    800070a0:	00d7173b          	sllw	a4,a4,a3
	} else if((inode_block -= indirect_blocks) < double_blocks) {
    800070a4:	418c8cb3          	sub	s9,s9,s8
    800070a8:	04ecc163          	blt	s9,a4,800070ea <ext2_bmap+0xe6>
	} else if(((inode_block -= double_blocks) >> (pointers_bits * 2)) < pointers) {
    800070ac:	40ec8cb3          	sub	s9,s9,a4
    800070b0:	40dcd6b3          	sra	a3,s9,a3
    800070b4:	0586da63          	bge	a3,s8,80007108 <ext2_bmap+0x104>
		offsets[n++] = EXT2_TIND_BLOCK;
    800070b8:	4739                	li	a4,14
    800070ba:	f8e42023          	sw	a4,-128(s0)
		offsets[n++] = inode_block >> (pointers_bits * 2);
    800070be:	f8d42223          	sw	a3,-124(s0)
		offsets[n++] = (inode_block >> pointers_bits) & (pointers - 1);
    800070c2:	fffa071b          	addiw	a4,s4,-1
    800070c6:	40fcd7b3          	sra	a5,s9,a5
    800070ca:	8ff9                	and	a5,a5,a4
    800070cc:	f8f42423          	sw	a5,-120(s0)
		offsets[n++] = inode_block & (pointers - 1);
    800070d0:	01977733          	and	a4,a4,s9
    800070d4:	f8e42623          	sw	a4,-116(s0)
    800070d8:	4d91                	li	s11,4
    800070da:	b749                	j	8000705c <ext2_bmap+0x58>
		offsets[n++] = EXT2_IND_BLOCK;
    800070dc:	47b1                	li	a5,12
    800070de:	f8f42023          	sw	a5,-128(s0)
		offsets[n++] = inode_block;
    800070e2:	f9942223          	sw	s9,-124(s0)
    800070e6:	4d89                	li	s11,2
    800070e8:	bf95                	j	8000705c <ext2_bmap+0x58>
		offsets[n++] = EXT2_DIND_BLOCK;
    800070ea:	4735                	li	a4,13
    800070ec:	f8e42023          	sw	a4,-128(s0)
		offsets[n++] = inode_block >> pointers_bits;
    800070f0:	40fcd7b3          	sra	a5,s9,a5
    800070f4:	f8f42223          	sw	a5,-124(s0)
		offsets[n++] = inode_block & (pointers - 1);
    800070f8:	fffa079b          	addiw	a5,s4,-1
    800070fc:	00fcf7b3          	and	a5,s9,a5
    80007100:	f8f42423          	sw	a5,-120(s0)
    80007104:	4d8d                	li	s11,3
    80007106:	bf99                	j	8000705c <ext2_bmap+0x58>
		panic("ext2_block_to_path(): Block out of bounds");
    80007108:	00003517          	auipc	a0,0x3
    8000710c:	bc050513          	addi	a0,a0,-1088 # 80009cc8 <syscalls+0x8f0>
    80007110:	ffff9097          	auipc	ra,0xffff9
    80007114:	552080e7          	jalr	1362(ra) # 80000662 <panic>
			panic("ext2_get_branch(): Could not read buffer");
    80007118:	00003517          	auipc	a0,0x3
    8000711c:	be050513          	addi	a0,a0,-1056 # 80009cf8 <syscalls+0x920>
    80007120:	ffff9097          	auipc	ra,0xffff9
    80007124:	542080e7          	jalr	1346(ra) # 80000662 <panic>
		if(!verify_chain(chain, p)) {
    80007128:	04f4f763          	bgeu	s1,a5,80007176 <ext2_bmap+0x172>
		add_chain(++p, buffer, (unsigned int *)buffer->data + *++offsets);
    8000712c:	04e1                	addi	s1,s1,24
    8000712e:	0991                	addi	s3,s3,4
    80007130:	05850793          	addi	a5,a0,88
    80007134:	0009a703          	lw	a4,0(s3)
    80007138:	070a                	slli	a4,a4,0x2
    8000713a:	97ba                	add	a5,a5,a4
	p->key = *(p->p = v);
    8000713c:	e09c                	sd	a5,0(s1)
    8000713e:	439c                	lw	a5,0(a5)
    80007140:	c49c                	sw	a5,8(s1)
	p->buffer = buffer;
    80007142:	e888                	sd	a0,16(s1)
		if(!p->key) {
    80007144:	36078063          	beqz	a5,800074a4 <ext2_bmap+0x4a0>
	while(--depth) {
    80007148:	397d                	addiw	s2,s2,-1
    8000714a:	22090e63          	beqz	s2,80007386 <ext2_bmap+0x382>
		buffer = ext2_vfs_ops.bread(inode->dev, p->key);
    8000714e:	0a8bb783          	ld	a5,168(s7)
    80007152:	448c                	lw	a1,8(s1)
    80007154:	000aa503          	lw	a0,0(s5)
    80007158:	9782                	jalr	a5
		if(!buffer) {
    8000715a:	dd5d                	beqz	a0,80007118 <ext2_bmap+0x114>
	for(;from <= to && from->key == *from->p; from++)
    8000715c:	f2040793          	addi	a5,s0,-224
    80007160:	fd64e6e3          	bltu	s1,s6,8000712c <ext2_bmap+0x128>
    80007164:	6398                	ld	a4,0(a5)
    80007166:	4794                	lw	a3,8(a5)
    80007168:	4318                	lw	a4,0(a4)
    8000716a:	fae69fe3          	bne	a3,a4,80007128 <ext2_bmap+0x124>
    8000716e:	07e1                	addi	a5,a5,24
    80007170:	fef4fae3          	bgeu	s1,a5,80007164 <ext2_bmap+0x160>
    80007174:	bf65                	j	8000712c <ext2_bmap+0x128>
			panic("ext2_get_branch(): Invalid chain");
    80007176:	00003517          	auipc	a0,0x3
    8000717a:	bb250513          	addi	a0,a0,-1102 # 80009d28 <syscalls+0x950>
    8000717e:	ffff9097          	auipc	ra,0xffff9
    80007182:	4e4080e7          	jalr	1252(ra) # 80000662 <panic>
			return *p;
    80007186:	1702                	slli	a4,a4,0x20
    80007188:	9301                	srli	a4,a4,0x20
		*boundary = final - 1 - (inode_block & (pointers - 1));
    8000718a:	fffa079b          	addiw	a5,s4,-1
    8000718e:	00fcf7b3          	and	a5,s9,a5
    80007192:	40fc07bb          	subw	a5,s8,a5
	indirect_blocks = (chain + depth) - partial - 1;
    80007196:	001d9693          	slli	a3,s11,0x1
    8000719a:	96ee                	add	a3,a3,s11
    8000719c:	068e                	slli	a3,a3,0x3
    8000719e:	f2040613          	addi	a2,s0,-224
    800071a2:	00d60b33          	add	s6,a2,a3
    800071a6:	409b0b33          	sub	s6,s6,s1
    800071aa:	403b5b13          	srai	s6,s6,0x3
    800071ae:	00002697          	auipc	a3,0x2
    800071b2:	e5a6b683          	ld	a3,-422(a3) # 80009008 <etext+0x8>
    800071b6:	02db0b33          	mul	s6,s6,a3
    800071ba:	3b7d                	addiw	s6,s6,-1
    800071bc:	000b091b          	sext.w	s2,s6
	if(k > 0) {
    800071c0:	07204663          	bgtz	s2,8000722c <ext2_bmap+0x228>
	for(count++; count < blocks && count <= blocks_to_boundary && *(branch[0].p + count) == 0; count++)
    800071c4:	4685                	li	a3,1
    800071c6:	0736f963          	bgeu	a3,s3,80007238 <ext2_bmap+0x234>
    800071ca:	fff7861b          	addiw	a2,a5,-1
    800071ce:	c63d                	beqz	a2,8000723c <ext2_bmap+0x238>
    800071d0:	0d11                	addi	s10,s10,4
    800071d2:	4785                	li	a5,1
    800071d4:	000d2683          	lw	a3,0(s10) # 2000 <_entry-0x7fffe000>
    800071d8:	e699                	bnez	a3,800071e6 <ext2_bmap+0x1e2>
    800071da:	0785                	addi	a5,a5,1
    800071dc:	00f98563          	beq	s3,a5,800071e6 <ext2_bmap+0x1e2>
    800071e0:	0d11                	addi	s10,s10,4
    800071e2:	fef679e3          	bgeu	a2,a5,800071d4 <ext2_bmap+0x1d0>
	return count;
    800071e6:	2781                	sext.w	a5,a5
	if(ext2_allocate_branch(ip, indirect_blocks, &count, goal, offsets + (partial - chain), partial) < 0) {
    800071e8:	f2040993          	addi	s3,s0,-224
    800071ec:	413489b3          	sub	s3,s1,s3
    800071f0:	4039d993          	srai	s3,s3,0x3
    800071f4:	00002697          	auipc	a3,0x2
    800071f8:	e146b683          	ld	a3,-492(a3) # 80009008 <etext+0x8>
    800071fc:	02d989b3          	mul	s3,s3,a3
	int blocksize = root_fs->superblock.block_size;
    80007200:	00004697          	auipc	a3,0x4
    80007204:	e386b683          	ld	a3,-456(a3) # 8000b038 <root_fs>
    80007208:	01c6ad03          	lw	s10,28(a3)
	int err = 0;
    8000720c:	ee042a23          	sw	zero,-268(s0)
	unsigned long new_blocks[4] = { 0 };
    80007210:	f0043023          	sd	zero,-256(s0)
    80007214:	f0043423          	sd	zero,-248(s0)
    80007218:	f0043823          	sd	zero,-240(s0)
    8000721c:	f0043c23          	sd	zero,-232(s0)
	num = ext2_allocate_blocks(inode, goal, indirect_blocks, *blocks, new_blocks, &err);
    80007220:	00070b9b          	sext.w	s7,a4
	int target = blocks + indirect_blocks;
    80007224:	00fb0b3b          	addw	s6,s6,a5
	int index = 0;
    80007228:	4a01                	li	s4,0
    8000722a:	a805                	j	8000725a <ext2_bmap+0x256>
		if(blocks < blocks_to_boundary + 1) {
    8000722c:	2781                	sext.w	a5,a5
		return count;
    8000722e:	00f9f363          	bgeu	s3,a5,80007234 <ext2_bmap+0x230>
    80007232:	87ce                	mv	a5,s3
    80007234:	2781                	sext.w	a5,a5
    80007236:	bf4d                	j	800071e8 <ext2_bmap+0x1e4>
	for(count++; count < blocks && count <= blocks_to_boundary && *(branch[0].p + count) == 0; count++)
    80007238:	4785                	li	a5,1
    8000723a:	b775                	j	800071e6 <ext2_bmap+0x1e2>
    8000723c:	4785                	li	a5,1
    8000723e:	b765                	j	800071e6 <ext2_bmap+0x1e2>
	panic("ext2_allocate_blocks(): Failed to get new blocks");
    80007240:	00003517          	auipc	a0,0x3
    80007244:	b1050513          	addi	a0,a0,-1264 # 80009d50 <syscalls+0x978>
    80007248:	ffff9097          	auipc	ra,0xffff9
    8000724c:	41a080e7          	jalr	1050(ra) # 80000662 <panic>
    80007250:	eef43c23          	sd	a5,-264(s0)
		if(count > 0) {
    80007254:	ef843703          	ld	a4,-264(s0)
    80007258:	eb21                	bnez	a4,800072a8 <ext2_bmap+0x2a4>
		count = target;
    8000725a:	ef643c23          	sd	s6,-264(s0)
		current_block = ext2_new_blocks(inode, goal, &count, err);
    8000725e:	ef440693          	addi	a3,s0,-268
    80007262:	ef840613          	addi	a2,s0,-264
    80007266:	85de                	mv	a1,s7
    80007268:	8556                	mv	a0,s5
    8000726a:	00000097          	auipc	ra,0x0
    8000726e:	b80080e7          	jalr	-1152(ra) # 80006dea <ext2_new_blocks>
		if(*err) {
    80007272:	ef442783          	lw	a5,-268(s0)
    80007276:	f7e9                	bnez	a5,80007240 <ext2_bmap+0x23c>
		target -= count;
    80007278:	ef843783          	ld	a5,-264(s0)
    8000727c:	40fb0b3b          	subw	s6,s6,a5
		while(index < indirect_blocks && count) {
    80007280:	032a5263          	bge	s4,s2,800072a4 <ext2_bmap+0x2a0>
    80007284:	003a1713          	slli	a4,s4,0x3
    80007288:	f0040693          	addi	a3,s0,-256
    8000728c:	9736                	add	a4,a4,a3
    8000728e:	d7f1                	beqz	a5,8000725a <ext2_bmap+0x256>
			new_blocks[index++] = current_block++;
    80007290:	00150693          	addi	a3,a0,1
    80007294:	2a05                	addiw	s4,s4,1
    80007296:	e308                	sd	a0,0(a4)
			count--;
    80007298:	17fd                	addi	a5,a5,-1
		while(index < indirect_blocks && count) {
    8000729a:	0721                	addi	a4,a4,8
    8000729c:	fb490ae3          	beq	s2,s4,80007250 <ext2_bmap+0x24c>
			new_blocks[index++] = current_block++;
    800072a0:	8536                	mv	a0,a3
    800072a2:	b7f5                	j	8000728e <ext2_bmap+0x28a>
		current_block = ext2_new_blocks(inode, goal, &count, err);
    800072a4:	86aa                	mv	a3,a0
    800072a6:	b77d                	j	80007254 <ext2_bmap+0x250>
	new_blocks[index] = current_block;
    800072a8:	003a1793          	slli	a5,s4,0x3
    800072ac:	f9078793          	addi	a5,a5,-112
    800072b0:	97a2                	add	a5,a5,s0
    800072b2:	f6d7b823          	sd	a3,-144(a5)
	ret = count;
    800072b6:	0007079b          	sext.w	a5,a4
    800072ba:	eef43023          	sd	a5,-288(s0)
	*err = 0;
    800072be:	ee042a23          	sw	zero,-268(s0)
	branch[0].key = new_blocks[0];
    800072c2:	f0043783          	ld	a5,-256(s0)
    800072c6:	c49c                	sw	a5,8(s1)
	for(int n = 1; n <= indirect_blocks; n++) {
    800072c8:	0b205f63          	blez	s2,80007386 <ext2_bmap+0x382>
    800072cc:	f0040b93          	addi	s7,s0,-256
    800072d0:	04e1                	addi	s1,s1,24
    800072d2:	098a                	slli	s3,s3,0x2
    800072d4:	f8040793          	addi	a5,s0,-128
    800072d8:	01378c33          	add	s8,a5,s3
    800072dc:	4b05                	li	s6,1
		buffer = ext2_vfs_ops.bread(inode->dev, new_blocks[n - 1]);
    800072de:	00003c97          	auipc	s9,0x3
    800072e2:	1e2c8c93          	addi	s9,s9,482 # 8000a4c0 <ext2_inode_ops>
    800072e6:	ffe7079b          	addiw	a5,a4,-2
    800072ea:	1782                	slli	a5,a5,0x20
    800072ec:	9381                	srli	a5,a5,0x20
    800072ee:	0785                	addi	a5,a5,1
    800072f0:	ecf43c23          	sd	a5,-296(s0)
    800072f4:	a80d                	j	80007326 <ext2_bmap+0x322>
	panic("ext2_allocate_branch(): Failed to allocate block branch");
    800072f6:	00003517          	auipc	a0,0x3
    800072fa:	a9250513          	addi	a0,a0,-1390 # 80009d88 <syscalls+0x9b0>
    800072fe:	ffff9097          	auipc	ra,0xffff9
    80007302:	364080e7          	jalr	868(ra) # 80000662 <panic>
				*(branch[n].p + i) = ++current_block;
    80007306:	0785                	addi	a5,a5,1
    80007308:	00f9a023          	sw	a5,0(s3)
			for(int i = 1; i < num; i++) {
    8000730c:	0991                	addi	s3,s3,4
    8000730e:	fee79ce3          	bne	a5,a4,80007306 <ext2_bmap+0x302>
		ext2_vfs_ops.bwrite(buffer);
    80007312:	0a0cb783          	ld	a5,160(s9)
    80007316:	8552                	mv	a0,s4
    80007318:	9782                	jalr	a5
	for(int n = 1; n <= indirect_blocks; n++) {
    8000731a:	2b05                	addiw	s6,s6,1
    8000731c:	0ba1                	addi	s7,s7,8
    8000731e:	04e1                	addi	s1,s1,24
    80007320:	0c11                	addi	s8,s8,4
    80007322:	05694e63          	blt	s2,s6,8000737e <ext2_bmap+0x37a>
		buffer = ext2_vfs_ops.bread(inode->dev, new_blocks[n - 1]);
    80007326:	0a8cb783          	ld	a5,168(s9)
    8000732a:	000ba583          	lw	a1,0(s7)
    8000732e:	000aa503          	lw	a0,0(s5)
    80007332:	9782                	jalr	a5
    80007334:	8a2a                	mv	s4,a0
		if(!buffer)
    80007336:	d161                	beqz	a0,800072f6 <ext2_bmap+0x2f2>
		branch[n].buffer = buffer;
    80007338:	e888                	sd	a0,16(s1)
		kmemset(buffer->data, 0, blocksize);
    8000733a:	05850993          	addi	s3,a0,88
    8000733e:	866a                	mv	a2,s10
    80007340:	4581                	li	a1,0
    80007342:	854e                	mv	a0,s3
    80007344:	ffffa097          	auipc	ra,0xffffa
    80007348:	ab0080e7          	jalr	-1360(ra) # 80000df4 <kmemset>
		branch[n].p = (unsigned int *) buffer->data + offsets[n];
    8000734c:	004c2783          	lw	a5,4(s8)
    80007350:	078a                	slli	a5,a5,0x2
    80007352:	99be                	add	s3,s3,a5
    80007354:	0134b023          	sd	s3,0(s1)
		branch[n].key = new_blocks[n];
    80007358:	008bb783          	ld	a5,8(s7)
    8000735c:	0007871b          	sext.w	a4,a5
    80007360:	c498                	sw	a4,8(s1)
		*branch[n].p = branch[n].key;
    80007362:	00e9a023          	sw	a4,0(s3)
		if(n == indirect_blocks) {
    80007366:	fb6916e3          	bne	s2,s6,80007312 <ext2_bmap+0x30e>
			for(int i = 1; i < num; i++) {
    8000736a:	ee043703          	ld	a4,-288(s0)
    8000736e:	4685                	li	a3,1
    80007370:	fae6d1e3          	bge	a3,a4,80007312 <ext2_bmap+0x30e>
    80007374:	0991                	addi	s3,s3,4
    80007376:	ed843703          	ld	a4,-296(s0)
    8000737a:	973e                	add	a4,a4,a5
    8000737c:	b769                	j	80007306 <ext2_bmap+0x302>
	return err;
    8000737e:	ef442783          	lw	a5,-268(s0)
	if(ext2_allocate_branch(ip, indirect_blocks, &count, goal, offsets + (partial - chain), partial) < 0) {
    80007382:	0807cb63          	bltz	a5,80007418 <ext2_bmap+0x414>
	block_no = chain[depth - 1].key;
    80007386:	fffd871b          	addiw	a4,s11,-1
    8000738a:	00171793          	slli	a5,a4,0x1
    8000738e:	97ba                	add	a5,a5,a4
    80007390:	078e                	slli	a5,a5,0x3
    80007392:	f9078793          	addi	a5,a5,-112
    80007396:	97a2                	add	a5,a5,s0
    80007398:	f987aa03          	lw	s4,-104(a5)
	int pointers = root_fs->superblock.block_size / sizeof(unsigned int);
    8000739c:	00004717          	auipc	a4,0x4
    800073a0:	c9c73703          	ld	a4,-868(a4) # 8000b038 <root_fs>
    800073a4:	4f5c                	lw	a5,28(a4)
	int pointers_bits = root_fs->superblock.ext2_in_mem_super.address_per_block_bits;
    800073a6:	1cc72683          	lw	a3,460(a4)
	if(block_num < direct_blocks) {
    800073aa:	472d                	li	a4,11
    800073ac:	ee843603          	ld	a2,-280(s0)
    800073b0:	06c76c63          	bltu	a4,a2,80007428 <ext2_bmap+0x424>
		if(inode->ext2_inode->inode.blocks[block_num] == 0) {
    800073b4:	02061793          	slli	a5,a2,0x20
    800073b8:	01e7d713          	srli	a4,a5,0x1e
    800073bc:	020ab783          	ld	a5,32(s5)
    800073c0:	97ba                	add	a5,a5,a4
    800073c2:	5798                	lw	a4,40(a5)
    800073c4:	e701                	bnez	a4,800073cc <ext2_bmap+0x3c8>
			inode->ext2_inode->inode.blocks[block_num] = chain[0].key;
    800073c6:	f2842703          	lw	a4,-216(s0)
    800073ca:	d798                	sw	a4,40(a5)
	partial = chain + depth - 1;
    800073cc:	f2040793          	addi	a5,s0,-224
    800073d0:	001d9493          	slli	s1,s11,0x1
    800073d4:	94ee                	add	s1,s1,s11
    800073d6:	048e                	slli	s1,s1,0x3
    800073d8:	14a1                	addi	s1,s1,-24
    800073da:	94be                	add	s1,s1,a5
	while(partial > chain) {
    800073dc:	0097fe63          	bgeu	a5,s1,800073f8 <ext2_bmap+0x3f4>
		ext2_vfs_ops.brelease(partial->buffer);
    800073e0:	00003997          	auipc	s3,0x3
    800073e4:	0e098993          	addi	s3,s3,224 # 8000a4c0 <ext2_inode_ops>
	while(partial > chain) {
    800073e8:	893e                	mv	s2,a5
		ext2_vfs_ops.brelease(partial->buffer);
    800073ea:	0989b783          	ld	a5,152(s3)
    800073ee:	6888                	ld	a0,16(s1)
    800073f0:	9782                	jalr	a5
		partial--;
    800073f2:	14a1                	addi	s1,s1,-24
	while(partial > chain) {
    800073f4:	fe996be3          	bltu	s2,s1,800073ea <ext2_bmap+0x3e6>
}
    800073f8:	8552                	mv	a0,s4
    800073fa:	70b2                	ld	ra,296(sp)
    800073fc:	7412                	ld	s0,288(sp)
    800073fe:	64f2                	ld	s1,280(sp)
    80007400:	6952                	ld	s2,272(sp)
    80007402:	69b2                	ld	s3,264(sp)
    80007404:	6a12                	ld	s4,256(sp)
    80007406:	7aee                	ld	s5,248(sp)
    80007408:	7b4e                	ld	s6,240(sp)
    8000740a:	7bae                	ld	s7,232(sp)
    8000740c:	7c0e                	ld	s8,224(sp)
    8000740e:	6cee                	ld	s9,216(sp)
    80007410:	6d4e                	ld	s10,208(sp)
    80007412:	6dae                	ld	s11,200(sp)
    80007414:	6155                	addi	sp,sp,304
    80007416:	8082                	ret
		panic("ext2_bmap(): Failed to allocate branch");
    80007418:	00003517          	auipc	a0,0x3
    8000741c:	9a850513          	addi	a0,a0,-1624 # 80009dc0 <syscalls+0x9e8>
    80007420:	ffff9097          	auipc	ra,0xffff9
    80007424:	242080e7          	jalr	578(ra) # 80000662 <panic>
	int pointers = root_fs->superblock.block_size / sizeof(unsigned int);
    80007428:	0027d59b          	srliw	a1,a5,0x2
    8000742c:	0027d51b          	srliw	a0,a5,0x2
	} else if((block_num -= direct_blocks) < indirect_blocks) {
    80007430:	ee843703          	ld	a4,-280(s0)
    80007434:	3751                	addiw	a4,a4,-12
    80007436:	02071613          	slli	a2,a4,0x20
    8000743a:	9201                	srli	a2,a2,0x20
    8000743c:	00a65a63          	bge	a2,a0,80007450 <ext2_bmap+0x44c>
		if(inode->ext2_inode->inode.blocks[EXT2_IND_BLOCK] == 0) {
    80007440:	020ab783          	ld	a5,32(s5)
    80007444:	4fb8                	lw	a4,88(a5)
    80007446:	f359                	bnez	a4,800073cc <ext2_bmap+0x3c8>
			inode->ext2_inode->inode.blocks[EXT2_IND_BLOCK] = chain[0].key;
    80007448:	f2842703          	lw	a4,-216(s0)
    8000744c:	cfb8                	sw	a4,88(a5)
    8000744e:	bfbd                	j	800073cc <ext2_bmap+0x3c8>
	const long direct_blocks = EXT2_DIR_BLOCK_COUNT, indirect_blocks = pointers, double_blocks = (1 << (pointers_bits * 2));
    80007450:	0016969b          	slliw	a3,a3,0x1
    80007454:	4785                	li	a5,1
    80007456:	00d797bb          	sllw	a5,a5,a3
    8000745a:	0007881b          	sext.w	a6,a5
	} else if((block_num -= indirect_blocks) < double_blocks) {
    8000745e:	9f0d                	subw	a4,a4,a1
    80007460:	02071613          	slli	a2,a4,0x20
    80007464:	9201                	srli	a2,a2,0x20
    80007466:	01065a63          	bge	a2,a6,8000747a <ext2_bmap+0x476>
		if(inode->ext2_inode->inode.blocks[EXT2_DIND_BLOCK] == 0) {
    8000746a:	020ab783          	ld	a5,32(s5)
    8000746e:	4ff8                	lw	a4,92(a5)
    80007470:	ff31                	bnez	a4,800073cc <ext2_bmap+0x3c8>
			inode->ext2_inode->inode.blocks[EXT2_DIND_BLOCK] = chain[0].key;
    80007472:	f2842703          	lw	a4,-216(s0)
    80007476:	cff8                	sw	a4,92(a5)
    80007478:	bf91                	j	800073cc <ext2_bmap+0x3c8>
	} else if(((block_num -= double_blocks) >> (pointers_bits * 2)) < pointers) {
    8000747a:	9f1d                	subw	a4,a4,a5
    8000747c:	00d757bb          	srlw	a5,a4,a3
    80007480:	00a7fa63          	bgeu	a5,a0,80007494 <ext2_bmap+0x490>
		if(inode->ext2_inode->inode.blocks[EXT2_TIND_BLOCK] == 0) {
    80007484:	020ab783          	ld	a5,32(s5)
    80007488:	53b8                	lw	a4,96(a5)
    8000748a:	f329                	bnez	a4,800073cc <ext2_bmap+0x3c8>
			inode->ext2_inode->inode.blocks[EXT2_TIND_BLOCK] = chain[0].key;
    8000748c:	f2842703          	lw	a4,-216(s0)
    80007490:	d3b8                	sw	a4,96(a5)
    80007492:	bf2d                	j	800073cc <ext2_bmap+0x3c8>
		panic("ext2_update_branch(): Block out of bounds");
    80007494:	00003517          	auipc	a0,0x3
    80007498:	95450513          	addi	a0,a0,-1708 # 80009de8 <syscalls+0xa10>
    8000749c:	ffff9097          	auipc	ra,0xffff9
    800074a0:	1c6080e7          	jalr	454(ra) # 80000662 <panic>
	max_blocks = root_fs->superblock.block_size >> root_fs->superblock.ext2_in_mem_super.block_size_bits;
    800074a4:	00004617          	auipc	a2,0x4
    800074a8:	b9463603          	ld	a2,-1132(a2) # 8000b038 <root_fs>
    800074ac:	1f462783          	lw	a5,500(a2)
    800074b0:	01c62983          	lw	s3,28(a2)
    800074b4:	00f9d9bb          	srlw	s3,s3,a5
    800074b8:	1982                	slli	s3,s3,0x20
    800074ba:	0209d993          	srli	s3,s3,0x20
	unsigned int * start = ind->buffer ? (unsigned int *) ind->buffer->data : inode->ext2_inode->inode.blocks;
    800074be:	688c                	ld	a1,16(s1)
    800074c0:	c5a1                	beqz	a1,80007508 <ext2_bmap+0x504>
    800074c2:	05858693          	addi	a3,a1,88
	for(p = ind->p - 1; p >= start; p--) {
    800074c6:	0004bd03          	ld	s10,0(s1)
    800074ca:	ffcd0793          	addi	a5,s10,-4
    800074ce:	00d7e963          	bltu	a5,a3,800074e0 <ext2_bmap+0x4dc>
		if(*p) {
    800074d2:	4398                	lw	a4,0(a5)
    800074d4:	ca0719e3          	bnez	a4,80007186 <ext2_bmap+0x182>
	for(p = ind->p - 1; p >= start; p--) {
    800074d8:	17f1                	addi	a5,a5,-4
    800074da:	fed7fce3          	bgeu	a5,a3,800074d2 <ext2_bmap+0x4ce>
	if(ind->buffer) {
    800074de:	cd9d                	beqz	a1,8000751c <ext2_bmap+0x518>
		return ind->buffer->blockno;
    800074e0:	00c5e703          	lwu	a4,12(a1)
    800074e4:	b15d                	j	8000718a <ext2_bmap+0x186>
	max_blocks = root_fs->superblock.block_size >> root_fs->superblock.ext2_in_mem_super.block_size_bits;
    800074e6:	00004617          	auipc	a2,0x4
    800074ea:	b5263603          	ld	a2,-1198(a2) # 8000b038 <root_fs>
    800074ee:	1f462783          	lw	a5,500(a2)
    800074f2:	01c62983          	lw	s3,28(a2)
    800074f6:	00f9d9bb          	srlw	s3,s3,a5
    800074fa:	1982                	slli	s3,s3,0x20
    800074fc:	0209d993          	srli	s3,s3,0x20
	unsigned int * start = ind->buffer ? (unsigned int *) ind->buffer->data : inode->ext2_inode->inode.blocks;
    80007500:	f3043583          	ld	a1,-208(s0)
	Indirect * p = chain;
    80007504:	f2040493          	addi	s1,s0,-224
	unsigned int * start = ind->buffer ? (unsigned int *) ind->buffer->data : inode->ext2_inode->inode.blocks;
    80007508:	020ab683          	ld	a3,32(s5)
    8000750c:	02868693          	addi	a3,a3,40
	for(p = ind->p - 1; p >= start; p--) {
    80007510:	0004bd03          	ld	s10,0(s1)
    80007514:	ffcd0793          	addi	a5,s10,-4
    80007518:	fad7fde3          	bgeu	a5,a3,800074d2 <ext2_bmap+0x4ce>
	block_group = (inode->inum - 1) / root_fs->superblock.ext2_in_mem_super.inodes_per_block_group;
    8000751c:	004aa903          	lw	s2,4(s5)
    80007520:	397d                	addiw	s2,s2,-1
    80007522:	1902                	slli	s2,s2,0x20
    80007524:	02095913          	srli	s2,s2,0x20
    80007528:	623c                	ld	a5,64(a2)
    8000752a:	02f95933          	divu	s2,s2,a5
	block_group_start = block_group * root_fs->superblock.ext2_in_mem_super.blocks_per_block_group + root_fs->superblock.ext2_in_mem_super.disk_super->superblock_block;
    8000752e:	2901                	sext.w	s2,s2
    80007530:	7e1c                	ld	a5,56(a2)
    80007532:	02f90933          	mul	s2,s2,a5
    80007536:	625c                	ld	a5,128(a2)
    80007538:	0147e783          	lwu	a5,20(a5)
    8000753c:	993e                	add	s2,s2,a5
	colour = (myproc()->pid % 16) * (root_fs->superblock.ext2_in_mem_super.blocks_per_block_group / 16);
    8000753e:	ffffa097          	auipc	ra,0xffffa
    80007542:	5a6080e7          	jalr	1446(ra) # 80001ae4 <myproc>
    80007546:	00004797          	auipc	a5,0x4
    8000754a:	af27b783          	ld	a5,-1294(a5) # 8000b038 <root_fs>
    8000754e:	7f98                	ld	a4,56(a5)
    80007550:	8311                	srli	a4,a4,0x4
    80007552:	591c                	lw	a5,48(a0)
    80007554:	41f7d69b          	sraiw	a3,a5,0x1f
    80007558:	01c6d69b          	srliw	a3,a3,0x1c
    8000755c:	9fb5                	addw	a5,a5,a3
    8000755e:	8bbd                	andi	a5,a5,15
    80007560:	9f95                	subw	a5,a5,a3
    80007562:	02f70733          	mul	a4,a4,a5
	return block_group_start + colour;
    80007566:	974a                	add	a4,a4,s2
    80007568:	b10d                	j	8000718a <ext2_bmap+0x186>

000000008000756a <ext2_iget>:
{
    8000756a:	715d                	addi	sp,sp,-80
    8000756c:	e486                	sd	ra,72(sp)
    8000756e:	e0a2                	sd	s0,64(sp)
    80007570:	fc26                	sd	s1,56(sp)
    80007572:	f84a                	sd	s2,48(sp)
    80007574:	f44e                	sd	s3,40(sp)
    80007576:	f052                	sd	s4,32(sp)
    80007578:	ec56                	sd	s5,24(sp)
    8000757a:	0880                	addi	s0,sp,80
    8000757c:	89aa                	mv	s3,a0
    8000757e:	8aae                	mv	s5,a1
	acquire(&itable.lock);
    80007580:	0001a517          	auipc	a0,0x1a
    80007584:	40850513          	addi	a0,a0,1032 # 80021988 <itable>
    80007588:	ffff9097          	auipc	ra,0xffff9
    8000758c:	770080e7          	jalr	1904(ra) # 80000cf8 <acquire>
	empty = 0;
    80007590:	4901                	li	s2,0
	for(ip = &itable.inode[0]; ip < &itable.inode[NINODE]; ip++) {
    80007592:	0001a497          	auipc	s1,0x1a
    80007596:	40e48493          	addi	s1,s1,1038 # 800219a0 <itable+0x18>
    8000759a:	0001b697          	auipc	a3,0x1b
    8000759e:	ef668693          	addi	a3,a3,-266 # 80022490 <log>
    800075a2:	a039                	j	800075b0 <ext2_iget+0x46>
		if(empty == 0 && ip->ref == 0) {
    800075a4:	02090b63          	beqz	s2,800075da <ext2_iget+0x70>
	for(ip = &itable.inode[0]; ip < &itable.inode[NINODE]; ip++) {
    800075a8:	03848493          	addi	s1,s1,56
    800075ac:	02d48a63          	beq	s1,a3,800075e0 <ext2_iget+0x76>
		if(ip->ref > 0 && ip->dev == dev && ip->inum == inum) {
    800075b0:	449c                	lw	a5,8(s1)
    800075b2:	fef059e3          	blez	a5,800075a4 <ext2_iget+0x3a>
    800075b6:	4098                	lw	a4,0(s1)
    800075b8:	ff3716e3          	bne	a4,s3,800075a4 <ext2_iget+0x3a>
    800075bc:	40d8                	lw	a4,4(s1)
    800075be:	ff5713e3          	bne	a4,s5,800075a4 <ext2_iget+0x3a>
			ip->ref++;
    800075c2:	2785                	addiw	a5,a5,1
    800075c4:	c49c                	sw	a5,8(s1)
			release(&itable.lock);
    800075c6:	0001a517          	auipc	a0,0x1a
    800075ca:	3c250513          	addi	a0,a0,962 # 80021988 <itable>
    800075ce:	ffff9097          	auipc	ra,0xffff9
    800075d2:	7de080e7          	jalr	2014(ra) # 80000dac <release>
			return ip;
    800075d6:	8926                	mv	s2,s1
    800075d8:	a21d                	j	800076fe <ext2_iget+0x194>
		if(empty == 0 && ip->ref == 0) {
    800075da:	f7f9                	bnez	a5,800075a8 <ext2_iget+0x3e>
    800075dc:	8926                	mv	s2,s1
    800075de:	b7e9                	j	800075a8 <ext2_iget+0x3e>
	if(empty == 0) {
    800075e0:	06090563          	beqz	s2,8000764a <ext2_iget+0xe0>
	ip->dev = dev;
    800075e4:	01392023          	sw	s3,0(s2)
	ip->inum = inum;
    800075e8:	01592223          	sw	s5,4(s2)
	ip->ref = 1;
    800075ec:	4785                	li	a5,1
    800075ee:	00f92423          	sw	a5,8(s2)
	ip->flags = 0;
    800075f2:	00092623          	sw	zero,12(s2)
	ip->inode_ops = &ext2_inode_ops;
    800075f6:	00003797          	auipc	a5,0x3
    800075fa:	eca78793          	addi	a5,a5,-310 # 8000a4c0 <ext2_inode_ops>
    800075fe:	00f93823          	sd	a5,16(s2)
	ip->vfs_ops = &ext2_vfs_ops;
    80007602:	00003797          	auipc	a5,0x3
    80007606:	f2678793          	addi	a5,a5,-218 # 8000a528 <ext2_vfs_ops>
    8000760a:	00f93c23          	sd	a5,24(s2)
	release(&itable.lock);
    8000760e:	0001a517          	auipc	a0,0x1a
    80007612:	37a50513          	addi	a0,a0,890 # 80021988 <itable>
    80007616:	ffff9097          	auipc	ra,0xffff9
    8000761a:	796080e7          	jalr	1942(ra) # 80000dac <release>
	acquire(&ext2_active_inodes.lock);
    8000761e:	00021517          	auipc	a0,0x21
    80007622:	3c250513          	addi	a0,a0,962 # 800289e0 <ext2_active_inodes>
    80007626:	ffff9097          	auipc	ra,0xffff9
    8000762a:	6d2080e7          	jalr	1746(ra) # 80000cf8 <acquire>
	for(int i = 0; i < NINODE; i++) {
    8000762e:	00023717          	auipc	a4,0x23
    80007632:	cca70713          	addi	a4,a4,-822 # 8002a2f8 <ext2_active_inodes+0x1918>
    80007636:	4781                	li	a5,0
    80007638:	03200613          	li	a2,50
		if(ext2_active_inodes.reserved[i] == 0x0) {
    8000763c:	4314                	lw	a3,0(a4)
    8000763e:	ce91                	beqz	a3,8000765a <ext2_iget+0xf0>
	for(int i = 0; i < NINODE; i++) {
    80007640:	2785                	addiw	a5,a5,1
    80007642:	0711                	addi	a4,a4,4
    80007644:	fec79ce3          	bne	a5,a2,8000763c <ext2_iget+0xd2>
    80007648:	a035                	j	80007674 <ext2_iget+0x10a>
		panic("ext2_iget(): Inode table full!");
    8000764a:	00002517          	auipc	a0,0x2
    8000764e:	7ce50513          	addi	a0,a0,1998 # 80009e18 <syscalls+0xa40>
    80007652:	ffff9097          	auipc	ra,0xffff9
    80007656:	010080e7          	jalr	16(ra) # 80000662 <panic>
			ext2_active_inodes.reserved[i] |= 0x1;
    8000765a:	00021a17          	auipc	s4,0x21
    8000765e:	386a0a13          	addi	s4,s4,902 # 800289e0 <ext2_active_inodes>
    80007662:	64478713          	addi	a4,a5,1604
    80007666:	070a                	slli	a4,a4,0x2
    80007668:	9752                	add	a4,a4,s4
    8000766a:	4685                	li	a3,1
    8000766c:	c714                	sw	a3,8(a4)
			active_inode = &ext2_active_inodes.inodes[i];
    8000766e:	079e                	slli	a5,a5,0x7
    80007670:	07e1                	addi	a5,a5,24
    80007672:	9a3e                	add	s4,s4,a5
	release(&ext2_active_inodes.lock);
    80007674:	00021517          	auipc	a0,0x21
    80007678:	36c50513          	addi	a0,a0,876 # 800289e0 <ext2_active_inodes>
    8000767c:	ffff9097          	auipc	ra,0xffff9
    80007680:	730080e7          	jalr	1840(ra) # 80000dac <release>
	raw_inode = ext2_get_inode(ip->inum, &buffer);
    80007684:	fb840593          	addi	a1,s0,-72
    80007688:	00492503          	lw	a0,4(s2)
    8000768c:	fffff097          	auipc	ra,0xfffff
    80007690:	f1c080e7          	jalr	-228(ra) # 800065a8 <ext2_get_inode>
    80007694:	85aa                	mv	a1,a0
	kmemmove(&active_inode->inode, raw_inode, sizeof(*raw_inode));
    80007696:	08000613          	li	a2,128
    8000769a:	8552                	mv	a0,s4
    8000769c:	ffff9097          	auipc	ra,0xffff9
    800076a0:	7b4080e7          	jalr	1972(ra) # 80000e50 <kmemmove>
	ip->ext2_inode = active_inode;
    800076a4:	03493023          	sd	s4,32(s2)
	ext2_vfs_ops.brelease(buffer);
    800076a8:	fb843503          	ld	a0,-72(s0)
    800076ac:	00003797          	auipc	a5,0x3
    800076b0:	eac7b783          	ld	a5,-340(a5) # 8000a558 <ext2_vfs_ops+0x30>
    800076b4:	9782                	jalr	a5
	if(EXT2_IS_DIR(active_inode->inode.mode)) {
    800076b6:	000a5703          	lhu	a4,0(s4)
    800076ba:	77fd                	lui	a5,0xfffff
    800076bc:	00f776b3          	and	a3,a4,a5
    800076c0:	6611                	lui	a2,0x4
    800076c2:	02c68363          	beq	a3,a2,800076e8 <ext2_iget+0x17e>
	} else if(EXT2_IS_FILE(active_inode->inode.mode)) {
    800076c6:	2681                	sext.w	a3,a3
    800076c8:	67a1                	lui	a5,0x8
    800076ca:	04f68463          	beq	a3,a5,80007712 <ext2_iget+0x1a8>
	} else if(EXT2_IS_CHAR_DEV(active_inode->inode.mode) || EXT2_IS_BLOCK_DEV(active_inode->inode.mode)) {
    800076ce:	77ed                	lui	a5,0xffffb
    800076d0:	8f7d                	and	a4,a4,a5
    800076d2:	6789                	lui	a5,0x2
    800076d4:	04f70163          	beq	a4,a5,80007716 <ext2_iget+0x1ac>
		panic("ext2_iget(): Invalid file mode");
    800076d8:	00002517          	auipc	a0,0x2
    800076dc:	76050513          	addi	a0,a0,1888 # 80009e38 <syscalls+0xa60>
    800076e0:	ffff9097          	auipc	ra,0xffff9
    800076e4:	f82080e7          	jalr	-126(ra) # 80000662 <panic>
    800076e8:	4785                	li	a5,1
		ip->type = T_DIR;
    800076ea:	02f91423          	sh	a5,40(s2)
	ip->nlink = active_inode->inode.hard_link_count;
    800076ee:	01aa5783          	lhu	a5,26(s4)
    800076f2:	02f91723          	sh	a5,46(s2)
	ip->size = active_inode->inode.size;
    800076f6:	004a2783          	lw	a5,4(s4)
    800076fa:	02f92823          	sw	a5,48(s2)
}
    800076fe:	854a                	mv	a0,s2
    80007700:	60a6                	ld	ra,72(sp)
    80007702:	6406                	ld	s0,64(sp)
    80007704:	74e2                	ld	s1,56(sp)
    80007706:	7942                	ld	s2,48(sp)
    80007708:	79a2                	ld	s3,40(sp)
    8000770a:	7a02                	ld	s4,32(sp)
    8000770c:	6ae2                	ld	s5,24(sp)
    8000770e:	6161                	addi	sp,sp,80
    80007710:	8082                	ret
    80007712:	4789                	li	a5,2
    80007714:	bfd9                	j	800076ea <ext2_iget+0x180>
    80007716:	478d                	li	a5,3
    80007718:	bfc9                	j	800076ea <ext2_iget+0x180>

000000008000771a <ext2_get_root>:
{
    8000771a:	1141                	addi	sp,sp,-16
    8000771c:	e406                	sd	ra,8(sp)
    8000771e:	e022                	sd	s0,0(sp)
    80007720:	0800                	addi	s0,sp,16
	return ext2_iget(dev, EXT2_ROOT_INODE);
    80007722:	4589                	li	a1,2
    80007724:	00000097          	auipc	ra,0x0
    80007728:	e46080e7          	jalr	-442(ra) # 8000756a <ext2_iget>
}
    8000772c:	60a2                	ld	ra,8(sp)
    8000772e:	6402                	ld	s0,0(sp)
    80007730:	0141                	addi	sp,sp,16
    80007732:	8082                	ret

0000000080007734 <ext2_ialloc>:
{
    80007734:	7175                	addi	sp,sp,-144
    80007736:	e506                	sd	ra,136(sp)
    80007738:	e122                	sd	s0,128(sp)
    8000773a:	fca6                	sd	s1,120(sp)
    8000773c:	f8ca                	sd	s2,112(sp)
    8000773e:	f4ce                	sd	s3,104(sp)
    80007740:	f0d2                	sd	s4,96(sp)
    80007742:	ecd6                	sd	s5,88(sp)
    80007744:	e8da                	sd	s6,80(sp)
    80007746:	e4de                	sd	s7,72(sp)
    80007748:	e0e2                	sd	s8,64(sp)
    8000774a:	fc66                	sd	s9,56(sp)
    8000774c:	f86a                	sd	s10,48(sp)
    8000774e:	f46e                	sd	s11,40(sp)
    80007750:	0900                	addi	s0,sp,144
    80007752:	f6b43c23          	sd	a1,-136(s0)
	for(i = 0; i < root_fs->superblock.ext2_in_mem_super.group_count; i++) {
    80007756:	00004797          	auipc	a5,0x4
    8000775a:	8e27b783          	ld	a5,-1822(a5) # 8000b038 <root_fs>
    8000775e:	73bc                	ld	a5,96(a5)
    80007760:	1c078a63          	beqz	a5,80007934 <ext2_ialloc+0x200>
    80007764:	8daa                	mv	s11,a0
		group_descriptor_p = ext2_get_group_descriptor(group, &bh2);
    80007766:	f8840593          	addi	a1,s0,-120
    8000776a:	4501                	li	a0,0
    8000776c:	fffff097          	auipc	ra,0xfffff
    80007770:	d9c080e7          	jalr	-612(ra) # 80006508 <ext2_get_group_descriptor>
    80007774:	8aaa                	mv	s5,a0
    80007776:	4b05                	li	s6,1
	group = 0;
    80007778:	4981                	li	s3,0
		group_descriptor_p = ext2_get_group_descriptor(group, &bh2);
    8000777a:	4c81                	li	s9,0
	buffer = ext2_vfs_ops.bread(root_fs->superblock.device, descriptor->inode_bitmap);
    8000777c:	00004a17          	auipc	s4,0x4
    80007780:	8bca0a13          	addi	s4,s4,-1860 # 8000b038 <root_fs>
    80007784:	00003c17          	auipc	s8,0x3
    80007788:	d3cc0c13          	addi	s8,s8,-708 # 8000a4c0 <ext2_inode_ops>
	return (*addr & (1 << nr)) >> nr;
    8000778c:	4d05                	li	s10,1
    8000778e:	a0b9                	j	800077dc <ext2_ialloc+0xa8>
		panic("read_inode_bitmap(): Failed to get group descriptor");
    80007790:	00002517          	auipc	a0,0x2
    80007794:	6c850513          	addi	a0,a0,1736 # 80009e58 <syscalls+0xa80>
    80007798:	ffff9097          	auipc	ra,0xffff9
    8000779c:	eca080e7          	jalr	-310(ra) # 80000662 <panic>
		panic("read_inode_bitmap(): Failed to read inode bitmap");
    800077a0:	00002517          	auipc	a0,0x2
    800077a4:	6f050513          	addi	a0,a0,1776 # 80009e90 <syscalls+0xab8>
    800077a8:	ffff9097          	auipc	ra,0xffff9
    800077ac:	eba080e7          	jalr	-326(ra) # 80000662 <panic>
			if(++group == root_fs->superblock.ext2_in_mem_super.group_count) {
    800077b0:	2985                	addiw	s3,s3,1
    800077b2:	733c                	ld	a5,96(a4)
    800077b4:	0af98363          	beq	s3,a5,8000785a <ext2_ialloc+0x126>
	for(i = 0; i < root_fs->superblock.ext2_in_mem_super.group_count; i++) {
    800077b8:	733c                	ld	a5,96(a4)
    800077ba:	16fb7d63          	bgeu	s6,a5,80007934 <ext2_ialloc+0x200>
		group_descriptor_p = ext2_get_group_descriptor(group, &bh2);
    800077be:	00098c9b          	sext.w	s9,s3
    800077c2:	f8840593          	addi	a1,s0,-120
    800077c6:	8566                	mv	a0,s9
    800077c8:	fffff097          	auipc	ra,0xfffff
    800077cc:	d40080e7          	jalr	-704(ra) # 80006508 <ext2_get_group_descriptor>
    800077d0:	8aaa                	mv	s5,a0
			ext2_vfs_ops.brelease(bitmap_buffer);
    800077d2:	098c3783          	ld	a5,152(s8)
    800077d6:	854a                	mv	a0,s2
    800077d8:	9782                	jalr	a5
    800077da:	0b05                	addi	s6,s6,1
	descriptor = ext2_get_group_descriptor(block_group, 0); 
    800077dc:	4581                	li	a1,0
    800077de:	854e                	mv	a0,s3
    800077e0:	fffff097          	auipc	ra,0xfffff
    800077e4:	d28080e7          	jalr	-728(ra) # 80006508 <ext2_get_group_descriptor>
	if(!descriptor)
    800077e8:	d545                	beqz	a0,80007790 <ext2_ialloc+0x5c>
	buffer = ext2_vfs_ops.bread(root_fs->superblock.device, descriptor->inode_bitmap);
    800077ea:	000a3703          	ld	a4,0(s4)
    800077ee:	0a8c3783          	ld	a5,168(s8)
    800077f2:	414c                	lw	a1,4(a0)
    800077f4:	01871503          	lh	a0,24(a4)
    800077f8:	9782                	jalr	a5
    800077fa:	892a                	mv	s2,a0
	if(!buffer)
    800077fc:	d155                	beqz	a0,800077a0 <ext2_ialloc+0x6c>
		inode_num = 0;
    800077fe:	4601                	li	a2,0
		inode_num = find_next_zero_bit((unsigned int *)bitmap_buffer->data, root_fs->superblock.ext2_in_mem_super.disk_super->inodes_per_block_group, inode_num);
    80007800:	05850b93          	addi	s7,a0,88
    80007804:	000a3783          	ld	a5,0(s4)
    80007808:	63dc                	ld	a5,128(a5)
    8000780a:	578c                	lw	a1,40(a5)
    8000780c:	855e                	mv	a0,s7
    8000780e:	00000097          	auipc	ra,0x0
    80007812:	4b2080e7          	jalr	1202(ra) # 80007cc0 <find_next_zero_bit>
    80007816:	0005049b          	sext.w	s1,a0
		if(inode_num >= root_fs->superblock.ext2_in_mem_super.disk_super->inodes_per_block_group) {
    8000781a:	000a3703          	ld	a4,0(s4)
    8000781e:	635c                	ld	a5,128(a4)
    80007820:	579c                	lw	a5,40(a5)
    80007822:	f8f4f7e3          	bgeu	s1,a5,800077b0 <ext2_ialloc+0x7c>
    80007826:	05893783          	ld	a5,88(s2)
    8000782a:	009d16bb          	sllw	a3,s10,s1
	*addr |= (1 << nr);
    8000782e:	05893603          	ld	a2,88(s2)
    80007832:	8e55                	or	a2,a2,a3
    80007834:	04c93c23          	sd	a2,88(s2)
	return (*addr & (1 << nr)) >> nr;
    80007838:	8ff5                	and	a5,a5,a3
    8000783a:	0097d7b3          	srl	a5,a5,s1
		if(test_and_set_bit(inode_num, (unsigned long *)bitmap_buffer->data)) {
    8000783e:	2781                	sext.w	a5,a5
    80007840:	cf99                	beqz	a5,8000785e <ext2_ialloc+0x12a>
			if(++inode_num >= root_fs->superblock.ext2_in_mem_super.disk_super->inodes_per_block_group) {
    80007842:	0014861b          	addiw	a2,s1,1
    80007846:	635c                	ld	a5,128(a4)
    80007848:	579c                	lw	a5,40(a5)
    8000784a:	faf66de3          	bltu	a2,a5,80007804 <ext2_ialloc+0xd0>
				if(++group == root_fs->superblock.ext2_in_mem_super.group_count) {
    8000784e:	2985                	addiw	s3,s3,1
    80007850:	733c                	ld	a5,96(a4)
    80007852:	f6f993e3          	bne	s3,a5,800077b8 <ext2_ialloc+0x84>
					group = 0;
    80007856:	4981                	li	s3,0
    80007858:	b785                	j	800077b8 <ext2_ialloc+0x84>
				group = 0;
    8000785a:	4981                	li	s3,0
    8000785c:	bfb1                	j	800077b8 <ext2_ialloc+0x84>
	ext2_vfs_ops.bwrite(bitmap_buffer); /* Might be broken */
    8000785e:	00003997          	auipc	s3,0x3
    80007862:	c6298993          	addi	s3,s3,-926 # 8000a4c0 <ext2_inode_ops>
    80007866:	0a09b783          	ld	a5,160(s3)
    8000786a:	854a                	mv	a0,s2
    8000786c:	9782                	jalr	a5
	ext2_vfs_ops.brelease(bitmap_buffer);
    8000786e:	0989b783          	ld	a5,152(s3)
    80007872:	854a                	mv	a0,s2
    80007874:	9782                	jalr	a5
	inode_num += group * root_fs->superblock.ext2_in_mem_super.disk_super->inodes_per_block_group + 1;
    80007876:	00003797          	auipc	a5,0x3
    8000787a:	7c27b783          	ld	a5,1986(a5) # 8000b038 <root_fs>
    8000787e:	63d8                	ld	a4,128(a5)
    80007880:	571c                	lw	a5,40(a4)
    80007882:	039787bb          	mulw	a5,a5,s9
    80007886:	2785                	addiw	a5,a5,1
    80007888:	9cbd                	addw	s1,s1,a5
	if (inode_num < EXT2_FIRST_INODE || inode_num > root_fs->superblock.ext2_in_mem_super.disk_super->inode_count) {
    8000788a:	47a9                	li	a5,10
    8000788c:	0a97fc63          	bgeu	a5,s1,80007944 <ext2_ialloc+0x210>
    80007890:	431c                	lw	a5,0(a4)
    80007892:	0a97e963          	bltu	a5,s1,80007944 <ext2_ialloc+0x210>
	group_descriptor_p->free_inodes_count--;
    80007896:	00ead783          	lhu	a5,14(s5)
    8000789a:	37fd                	addiw	a5,a5,-1
    8000789c:	00fa9723          	sh	a5,14(s5)
	ext2_vfs_ops.bwrite(bh2);
    800078a0:	f8843503          	ld	a0,-120(s0)
    800078a4:	00003797          	auipc	a5,0x3
    800078a8:	cbc7b783          	ld	a5,-836(a5) # 8000a560 <ext2_vfs_ops+0x38>
    800078ac:	9782                	jalr	a5
	raw_inode = ext2_get_inode(inode_num, &ibh);
    800078ae:	f8040593          	addi	a1,s0,-128
    800078b2:	8526                	mv	a0,s1
    800078b4:	fffff097          	auipc	ra,0xfffff
    800078b8:	cf4080e7          	jalr	-780(ra) # 800065a8 <ext2_get_inode>
    800078bc:	892a                	mv	s2,a0
	kmemset(raw_inode, 0, EXT2_INODE_SIZE);
    800078be:	10000613          	li	a2,256
    800078c2:	4581                	li	a1,0
    800078c4:	ffff9097          	auipc	ra,0xffff9
    800078c8:	530080e7          	jalr	1328(ra) # 80000df4 <kmemset>
	if(type == T_DIR) {
    800078cc:	f7843683          	ld	a3,-136(s0)
    800078d0:	0006879b          	sext.w	a5,a3
    800078d4:	4705                	li	a4,1
    800078d6:	08e78763          	beq	a5,a4,80007964 <ext2_ialloc+0x230>
	} else if(type == T_FILE) {
    800078da:	4709                	li	a4,2
    800078dc:	08e78663          	beq	a5,a4,80007968 <ext2_ialloc+0x234>
	} else if(type == T_DEVICE) {
    800078e0:	86be                	mv	a3,a5
    800078e2:	470d                	li	a4,3
    800078e4:	6789                	lui	a5,0x2
    800078e6:	06e69763          	bne	a3,a4,80007954 <ext2_ialloc+0x220>
		raw_inode->mode = EXT2_DIR;
    800078ea:	00f91023          	sh	a5,0(s2)
	ext2_vfs_ops.bwrite(ibh);
    800078ee:	00003917          	auipc	s2,0x3
    800078f2:	bd290913          	addi	s2,s2,-1070 # 8000a4c0 <ext2_inode_ops>
    800078f6:	0a093783          	ld	a5,160(s2)
    800078fa:	f8043503          	ld	a0,-128(s0)
    800078fe:	9782                	jalr	a5
	ext2_vfs_ops.brelease(ibh);
    80007900:	09893783          	ld	a5,152(s2)
    80007904:	f8043503          	ld	a0,-128(s0)
    80007908:	9782                	jalr	a5
	return ext2_iget(dev, inode_num);
    8000790a:	85a6                	mv	a1,s1
    8000790c:	856e                	mv	a0,s11
    8000790e:	00000097          	auipc	ra,0x0
    80007912:	c5c080e7          	jalr	-932(ra) # 8000756a <ext2_iget>
}
    80007916:	60aa                	ld	ra,136(sp)
    80007918:	640a                	ld	s0,128(sp)
    8000791a:	74e6                	ld	s1,120(sp)
    8000791c:	7946                	ld	s2,112(sp)
    8000791e:	79a6                	ld	s3,104(sp)
    80007920:	7a06                	ld	s4,96(sp)
    80007922:	6ae6                	ld	s5,88(sp)
    80007924:	6b46                	ld	s6,80(sp)
    80007926:	6ba6                	ld	s7,72(sp)
    80007928:	6c06                	ld	s8,64(sp)
    8000792a:	7ce2                	ld	s9,56(sp)
    8000792c:	7d42                	ld	s10,48(sp)
    8000792e:	7da2                	ld	s11,40(sp)
    80007930:	6149                	addi	sp,sp,144
    80007932:	8082                	ret
	panic("ext2_ialloc(): No space for inode");
    80007934:	00002517          	auipc	a0,0x2
    80007938:	59450513          	addi	a0,a0,1428 # 80009ec8 <syscalls+0xaf0>
    8000793c:	ffff9097          	auipc	ra,0xffff9
    80007940:	d26080e7          	jalr	-730(ra) # 80000662 <panic>
		panic("ext2_ialloc(): Inode number out of range");
    80007944:	00002517          	auipc	a0,0x2
    80007948:	5ac50513          	addi	a0,a0,1452 # 80009ef0 <syscalls+0xb18>
    8000794c:	ffff9097          	auipc	ra,0xffff9
    80007950:	d16080e7          	jalr	-746(ra) # 80000662 <panic>
		panic("ext2_ialloc(): Invalid inode mode");
    80007954:	00002517          	auipc	a0,0x2
    80007958:	5cc50513          	addi	a0,a0,1484 # 80009f20 <syscalls+0xb48>
    8000795c:	ffff9097          	auipc	ra,0xffff9
    80007960:	d06080e7          	jalr	-762(ra) # 80000662 <panic>
    80007964:	6791                	lui	a5,0x4
    80007966:	b751                	j	800078ea <ext2_ialloc+0x1b6>
    80007968:	67a1                	lui	a5,0x8
    8000796a:	b741                	j	800078ea <ext2_ialloc+0x1b6>

000000008000796c <ext2_dir_lookup>:
{
    8000796c:	711d                	addi	sp,sp,-96
    8000796e:	ec86                	sd	ra,88(sp)
    80007970:	e8a2                	sd	s0,80(sp)
    80007972:	e4a6                	sd	s1,72(sp)
    80007974:	e0ca                	sd	s2,64(sp)
    80007976:	fc4e                	sd	s3,56(sp)
    80007978:	f852                	sd	s4,48(sp)
    8000797a:	f456                	sd	s5,40(sp)
    8000797c:	f05a                	sd	s6,32(sp)
    8000797e:	ec5e                	sd	s7,24(sp)
    80007980:	e862                	sd	s8,16(sp)
    80007982:	e466                	sd	s9,8(sp)
    80007984:	1080                	addi	s0,sp,96
    80007986:	89aa                	mv	s3,a0
    80007988:	8bae                	mv	s7,a1
    8000798a:	8c32                	mv	s8,a2
	int name_length = kstrlen(name);
    8000798c:	852e                	mv	a0,a1
    8000798e:	ffff9097          	auipc	ra,0xffff9
    80007992:	5e2080e7          	jalr	1506(ra) # 80000f70 <kstrlen>
	for(unsigned int offset = 0; offset < dp->size;) {
    80007996:	0309a783          	lw	a5,48(s3)
    8000799a:	cfe9                	beqz	a5,80007a74 <ext2_dir_lookup+0x108>
    8000799c:	8b2a                	mv	s6,a0
    8000799e:	4481                	li	s1,0
		cur_block = offset / root_fs->superblock.block_size;
    800079a0:	00003a97          	auipc	s5,0x3
    800079a4:	698a8a93          	addi	s5,s5,1688 # 8000b038 <root_fs>
		unsigned int bmap = ext2_inode_ops.bmap(dp, cur_block);
    800079a8:	00003a17          	auipc	s4,0x3
    800079ac:	b18a0a13          	addi	s4,s4,-1256 # 8000a4c0 <ext2_inode_ops>
    800079b0:	a821                	j	800079c8 <ext2_dir_lookup+0x5c>
			offset += directory_entry->record_length;
    800079b2:	004cd783          	lhu	a5,4(s9)
    800079b6:	9cbd                	addw	s1,s1,a5
			ext2_vfs_ops.brelease(buffer_p);
    800079b8:	098a3783          	ld	a5,152(s4)
    800079bc:	854a                	mv	a0,s2
    800079be:	9782                	jalr	a5
	for(unsigned int offset = 0; offset < dp->size;) {
    800079c0:	0309a783          	lw	a5,48(s3)
    800079c4:	08f4fa63          	bgeu	s1,a5,80007a58 <ext2_dir_lookup+0xec>
		cur_block = offset / root_fs->superblock.block_size;
    800079c8:	000ab783          	ld	a5,0(s5)
    800079cc:	4fcc                	lw	a1,28(a5)
		unsigned int bmap = ext2_inode_ops.bmap(dp, cur_block);
    800079ce:	018a3783          	ld	a5,24(s4)
    800079d2:	02b4d5bb          	divuw	a1,s1,a1
    800079d6:	854e                	mv	a0,s3
    800079d8:	9782                	jalr	a5
		buffer_p = ext2_vfs_ops.bread(dp->dev, bmap);
    800079da:	0a8a3783          	ld	a5,168(s4)
    800079de:	0005059b          	sext.w	a1,a0
    800079e2:	0009a503          	lw	a0,0(s3)
    800079e6:	9782                	jalr	a5
    800079e8:	892a                	mv	s2,a0
		directory_entry = (struct ext2_dir_entry *) (buffer_p->data + (offset % root_fs->superblock.block_size));
    800079ea:	05850c93          	addi	s9,a0,88
    800079ee:	000ab783          	ld	a5,0(s5)
    800079f2:	4fdc                	lw	a5,28(a5)
    800079f4:	02f4f7bb          	remuw	a5,s1,a5
    800079f8:	1782                	slli	a5,a5,0x20
    800079fa:	9381                	srli	a5,a5,0x20
    800079fc:	9cbe                	add	s9,s9,a5
		if(directory_entry->inode == 0 || directory_entry->name_length_short != name_length) {
    800079fe:	000ca783          	lw	a5,0(s9)
    80007a02:	dbc5                	beqz	a5,800079b2 <ext2_dir_lookup+0x46>
    80007a04:	006cc603          	lbu	a2,6(s9)
    80007a08:	0006079b          	sext.w	a5,a2
    80007a0c:	fb6793e3          	bne	a5,s6,800079b2 <ext2_dir_lookup+0x46>
		if(kstrncmp(name, directory_entry->name, directory_entry->name_length_short) == 0) {
    80007a10:	008c8593          	addi	a1,s9,8
    80007a14:	855e                	mv	a0,s7
    80007a16:	ffff9097          	auipc	ra,0xffff9
    80007a1a:	4ae080e7          	jalr	1198(ra) # 80000ec4 <kstrncmp>
    80007a1e:	c909                	beqz	a0,80007a30 <ext2_dir_lookup+0xc4>
		offset += directory_entry->record_length;
    80007a20:	004cd783          	lhu	a5,4(s9)
    80007a24:	9cbd                	addw	s1,s1,a5
		ext2_vfs_ops.brelease(buffer_p);
    80007a26:	098a3783          	ld	a5,152(s4)
    80007a2a:	854a                	mv	a0,s2
    80007a2c:	9782                	jalr	a5
    80007a2e:	bf49                	j	800079c0 <ext2_dir_lookup+0x54>
			if(poffset) {
    80007a30:	000c0463          	beqz	s8,80007a38 <ext2_dir_lookup+0xcc>
				*poffset = offset;
    80007a34:	009c2023          	sw	s1,0(s8)
			inum = directory_entry->inode;
    80007a38:	000ca483          	lw	s1,0(s9)
			ext2_vfs_ops.brelease(buffer_p);
    80007a3c:	854a                	mv	a0,s2
    80007a3e:	00003797          	auipc	a5,0x3
    80007a42:	b1a7b783          	ld	a5,-1254(a5) # 8000a558 <ext2_vfs_ops+0x30>
    80007a46:	9782                	jalr	a5
			return ext2_iget(dp->dev, inum);
    80007a48:	85a6                	mv	a1,s1
    80007a4a:	0009a503          	lw	a0,0(s3)
    80007a4e:	00000097          	auipc	ra,0x0
    80007a52:	b1c080e7          	jalr	-1252(ra) # 8000756a <ext2_iget>
    80007a56:	a011                	j	80007a5a <ext2_dir_lookup+0xee>
	return 0;
    80007a58:	4501                	li	a0,0
}
    80007a5a:	60e6                	ld	ra,88(sp)
    80007a5c:	6446                	ld	s0,80(sp)
    80007a5e:	64a6                	ld	s1,72(sp)
    80007a60:	6906                	ld	s2,64(sp)
    80007a62:	79e2                	ld	s3,56(sp)
    80007a64:	7a42                	ld	s4,48(sp)
    80007a66:	7aa2                	ld	s5,40(sp)
    80007a68:	7b02                	ld	s6,32(sp)
    80007a6a:	6be2                	ld	s7,24(sp)
    80007a6c:	6c42                	ld	s8,16(sp)
    80007a6e:	6ca2                	ld	s9,8(sp)
    80007a70:	6125                	addi	sp,sp,96
    80007a72:	8082                	ret
	return 0;
    80007a74:	4501                	li	a0,0
    80007a76:	b7d5                	j	80007a5a <ext2_dir_lookup+0xee>

0000000080007a78 <ext2_dir_link>:
{
    80007a78:	7175                	addi	sp,sp,-144
    80007a7a:	e506                	sd	ra,136(sp)
    80007a7c:	e122                	sd	s0,128(sp)
    80007a7e:	fca6                	sd	s1,120(sp)
    80007a80:	f8ca                	sd	s2,112(sp)
    80007a82:	f4ce                	sd	s3,104(sp)
    80007a84:	f0d2                	sd	s4,96(sp)
    80007a86:	ecd6                	sd	s5,88(sp)
    80007a88:	e8da                	sd	s6,80(sp)
    80007a8a:	e4de                	sd	s7,72(sp)
    80007a8c:	e0e2                	sd	s8,64(sp)
    80007a8e:	fc66                	sd	s9,56(sp)
    80007a90:	f86a                	sd	s10,48(sp)
    80007a92:	f46e                	sd	s11,40(sp)
    80007a94:	0900                	addi	s0,sp,144
    80007a96:	892a                	mv	s2,a0
    80007a98:	89ae                	mv	s3,a1
    80007a9a:	f8b43423          	sd	a1,-120(s0)
    80007a9e:	f8c43023          	sd	a2,-128(s0)
    80007aa2:	f6d43c23          	sd	a3,-136(s0)
	int prev_name_length = kstrlen(name);
    80007aa6:	852e                	mv	a0,a1
    80007aa8:	ffff9097          	auipc	ra,0xffff9
    80007aac:	4c8080e7          	jalr	1224(ra) # 80000f70 <kstrlen>
    80007ab0:	8b2a                	mv	s6,a0
	unsigned short prev_record_length = EXT2_DIR_REC_LEN(prev_name_length);
    80007ab2:	00b5049b          	addiw	s1,a0,11
	int num_blocks = (dp->size + EXT2_BLOCK_SIZE - 1) / EXT2_BLOCK_SIZE;
    80007ab6:	03092783          	lw	a5,48(s2)
    80007aba:	3ff7879b          	addiw	a5,a5,1023
    80007abe:	00a7d79b          	srliw	a5,a5,0xa
    80007ac2:	f6f43823          	sd	a5,-144(s0)
	if(ext2_dir_lookup(dp, name, 0) != 0) {
    80007ac6:	4601                	li	a2,0
    80007ac8:	85ce                	mv	a1,s3
    80007aca:	854a                	mv	a0,s2
    80007acc:	00000097          	auipc	ra,0x0
    80007ad0:	ea0080e7          	jalr	-352(ra) # 8000796c <ext2_dir_lookup>
    80007ad4:	18051e63          	bnez	a0,80007c70 <ext2_dir_link+0x1f8>
    80007ad8:	98f1                	andi	s1,s1,-4
    80007ada:	14c2                	slli	s1,s1,0x30
    80007adc:	90c1                	srli	s1,s1,0x30
	for(n = 0; n <= num_blocks; n++) {
    80007ade:	4a81                	li	s5,0
		buffer_p = ext2_vfs_ops.bread(dp->dev, ext2_inode_ops.bmap(dp, n));
    80007ae0:	00003c17          	auipc	s8,0x3
    80007ae4:	9e0c0c13          	addi	s8,s8,-1568 # 8000a4c0 <ext2_inode_ops>
	last_byte -= page_num * root_fs->superblock.block_size;
    80007ae8:	00003d97          	auipc	s11,0x3
    80007aec:	550d8d93          	addi	s11,s11,1360 # 8000b038 <root_fs>
		while((char *)directory_entry <= (char *) buffer_p->data + EXT2_BLOCK_SIZE - prev_record_length) {
    80007af0:	40000b93          	li	s7,1024
    80007af4:	409b8bb3          	sub	s7,s7,s1
			if(!directory_entry->inode && record_length >= prev_record_length) {
    80007af8:	00048a1b          	sext.w	s4,s1
		buffer_p = ext2_vfs_ops.bread(dp->dev, ext2_inode_ops.bmap(dp, n));
    80007afc:	0a8c3c83          	ld	s9,168(s8)
    80007b00:	00092d03          	lw	s10,0(s2)
    80007b04:	000a899b          	sext.w	s3,s5
    80007b08:	018c3783          	ld	a5,24(s8)
    80007b0c:	85ce                	mv	a1,s3
    80007b0e:	854a                	mv	a0,s2
    80007b10:	9782                	jalr	a5
    80007b12:	0005059b          	sext.w	a1,a0
    80007b16:	856a                	mv	a0,s10
    80007b18:	9c82                	jalr	s9
    80007b1a:	8caa                	mv	s9,a0
		directory_entry = (struct ext2_dir_entry *) buffer_p->data;
    80007b1c:	05850713          	addi	a4,a0,88
	unsigned int last_byte = inode->size;
    80007b20:	03092783          	lw	a5,48(s2)
	last_byte -= page_num * root_fs->superblock.block_size;
    80007b24:	000db683          	ld	a3,0(s11)
    80007b28:	4ed4                	lw	a3,28(a3)
    80007b2a:	02d989bb          	mulw	s3,s3,a3
    80007b2e:	413787bb          	subw	a5,a5,s3
		dir_end = (char *) buffer_p->data + ext2_last_byte(dp, n);
    80007b32:	85be                	mv	a1,a5
    80007b34:	2781                	sext.w	a5,a5
    80007b36:	00f6f363          	bgeu	a3,a5,80007b3c <ext2_dir_link+0xc4>
    80007b3a:	85b6                	mv	a1,a3
    80007b3c:	1582                	slli	a1,a1,0x20
    80007b3e:	9181                	srli	a1,a1,0x20
    80007b40:	95ba                	add	a1,a1,a4
		while((char *)directory_entry <= (char *) buffer_p->data + EXT2_BLOCK_SIZE - prev_record_length) {
    80007b42:	01770533          	add	a0,a4,s7
    80007b46:	04e56a63          	bltu	a0,a4,80007b9a <ext2_dir_link+0x122>
			if((char *)directory_entry == dir_end) {
    80007b4a:	02b71663          	bne	a4,a1,80007b76 <ext2_dir_link+0xfe>
		directory_entry = (struct ext2_dir_entry *) buffer_p->data;
    80007b4e:	872e                	mv	a4,a1
				directory_entry->record_length = EXT2_BLOCK_SIZE;
    80007b50:	40000793          	li	a5,1024
    80007b54:	00f71223          	sh	a5,4(a4)
				directory_entry->inode = 0;
    80007b58:	00072023          	sw	zero,0(a4)
				goto got_it;
    80007b5c:	84ba                	mv	s1,a4
				record_length = EXT2_BLOCK_SIZE;
    80007b5e:	40000993          	li	s3,1024
				goto got_it;
    80007b62:	a085                	j	80007bc2 <ext2_dir_link+0x14a>
			if(record_length >= name_length + prev_record_length) {
    80007b64:	00978633          	add	a2,a5,s1
    80007b68:	04c9d463          	bge	s3,a2,80007bb0 <ext2_dir_link+0x138>
			directory_entry = (struct ext2_dir_entry *) ((char *) directory_entry + record_length);
    80007b6c:	974e                	add	a4,a4,s3
		while((char *)directory_entry <= (char *) buffer_p->data + EXT2_BLOCK_SIZE - prev_record_length) {
    80007b6e:	02e56663          	bltu	a0,a4,80007b9a <ext2_dir_link+0x122>
			if((char *)directory_entry == dir_end) {
    80007b72:	fce58fe3          	beq	a1,a4,80007b50 <ext2_dir_link+0xd8>
			if(directory_entry->record_length == 0) {
    80007b76:	00475983          	lhu	s3,4(a4)
    80007b7a:	0e098d63          	beqz	s3,80007c74 <ext2_dir_link+0x1fc>
			name_length = EXT2_DIR_REC_LEN(directory_entry->name_length_short);
    80007b7e:	00674783          	lbu	a5,6(a4)
    80007b82:	27ad                	addiw	a5,a5,11
    80007b84:	9bf1                	andi	a5,a5,-4
    80007b86:	17c2                	slli	a5,a5,0x30
    80007b88:	93c1                	srli	a5,a5,0x30
			if(!directory_entry->inode && record_length >= prev_record_length) {
    80007b8a:	4314                	lw	a3,0(a4)
    80007b8c:	fee1                	bnez	a3,80007b64 <ext2_dir_link+0xec>
    80007b8e:	0009861b          	sext.w	a2,s3
    80007b92:	fd4669e3          	bltu	a2,s4,80007b64 <ext2_dir_link+0xec>
    80007b96:	84ba                	mv	s1,a4
	if(directory_entry->inode) {
    80007b98:	a02d                	j	80007bc2 <ext2_dir_link+0x14a>
		ext2_vfs_ops.brelease(buffer_p);
    80007b9a:	098c3783          	ld	a5,152(s8)
    80007b9e:	8566                	mv	a0,s9
    80007ba0:	9782                	jalr	a5
	for(n = 0; n <= num_blocks; n++) {
    80007ba2:	2a85                	addiw	s5,s5,1
    80007ba4:	f7043783          	ld	a5,-144(s0)
    80007ba8:	f557dae3          	bge	a5,s5,80007afc <ext2_dir_link+0x84>
	return -1;
    80007bac:	557d                	li	a0,-1
    80007bae:	a061                	j	80007c36 <ext2_dir_link+0x1be>
	if(directory_entry->inode) {
    80007bb0:	c2d5                	beqz	a3,80007c54 <ext2_dir_link+0x1dc>
		struct ext2_dir_entry * temp = (struct ext2_dir_entry *) ((char *) directory_entry + name_length);
    80007bb2:	00f704b3          	add	s1,a4,a5
		temp->record_length = record_length - name_length;
    80007bb6:	40f986bb          	subw	a3,s3,a5
    80007bba:	00d49223          	sh	a3,4(s1)
		directory_entry->record_length = name_length;
    80007bbe:	00f71223          	sh	a5,4(a4)
	directory_entry->name_length_short = prev_name_length;
    80007bc2:	01648323          	sb	s6,6(s1)
	kstrncpy(directory_entry->name, name, prev_name_length);
    80007bc6:	865a                	mv	a2,s6
    80007bc8:	f8843583          	ld	a1,-120(s0)
    80007bcc:	00848513          	addi	a0,s1,8
    80007bd0:	ffff9097          	auipc	ra,0xffff9
    80007bd4:	330080e7          	jalr	816(ra) # 80000f00 <kstrncpy>
	directory_entry->inode = inum;
    80007bd8:	f8043783          	ld	a5,-128(s0)
    80007bdc:	c09c                	sw	a5,0(s1)
	if(type == T_DIR) {
    80007bde:	4785                	li	a5,1
    80007be0:	f7843683          	ld	a3,-136(s0)
    80007be4:	08f68263          	beq	a3,a5,80007c68 <ext2_dir_link+0x1f0>
	} else if(type == T_FILE) {
    80007be8:	4789                	li	a5,2
    80007bea:	08f68163          	beq	a3,a5,80007c6c <ext2_dir_link+0x1f4>
	} else if(type == T_DEVICE) {
    80007bee:	470d                	li	a4,3
    80007bf0:	478d                	li	a5,3
    80007bf2:	06e69363          	bne	a3,a4,80007c58 <ext2_dir_link+0x1e0>
		directory_entry->file_type = EXT2_DIR_DIR;
    80007bf6:	00f483a3          	sb	a5,7(s1)
	ext2_vfs_ops.bwrite(buffer_p);
    80007bfa:	00003497          	auipc	s1,0x3
    80007bfe:	8c648493          	addi	s1,s1,-1850 # 8000a4c0 <ext2_inode_ops>
    80007c02:	70dc                	ld	a5,160(s1)
    80007c04:	8566                	mv	a0,s9
    80007c06:	9782                	jalr	a5
	ext2_vfs_ops.brelease(buffer_p);
    80007c08:	6cdc                	ld	a5,152(s1)
    80007c0a:	8566                	mv	a0,s9
    80007c0c:	9782                	jalr	a5
	if ((n + 1) * EXT2_BLOCK_SIZE > dp->size) {
    80007c0e:	03092703          	lw	a4,48(s2)
    80007c12:	001a879b          	addiw	a5,s5,1
    80007c16:	00a7979b          	slliw	a5,a5,0xa
	return 0;
    80007c1a:	4501                	li	a0,0
	if ((n + 1) * EXT2_BLOCK_SIZE > dp->size) {
    80007c1c:	00f77d63          	bgeu	a4,a5,80007c36 <ext2_dir_link+0x1be>
		dp->size += record_length;
    80007c20:	00e9873b          	addw	a4,s3,a4
    80007c24:	02e92823          	sw	a4,48(s2)
		ext2_inode_ops.iupdate(dp);
    80007c28:	854a                	mv	a0,s2
    80007c2a:	00003797          	auipc	a5,0x3
    80007c2e:	89e7b783          	ld	a5,-1890(a5) # 8000a4c8 <ext2_inode_ops+0x8>
    80007c32:	9782                	jalr	a5
	return 0;
    80007c34:	4501                	li	a0,0
}
    80007c36:	60aa                	ld	ra,136(sp)
    80007c38:	640a                	ld	s0,128(sp)
    80007c3a:	74e6                	ld	s1,120(sp)
    80007c3c:	7946                	ld	s2,112(sp)
    80007c3e:	79a6                	ld	s3,104(sp)
    80007c40:	7a06                	ld	s4,96(sp)
    80007c42:	6ae6                	ld	s5,88(sp)
    80007c44:	6b46                	ld	s6,80(sp)
    80007c46:	6ba6                	ld	s7,72(sp)
    80007c48:	6c06                	ld	s8,64(sp)
    80007c4a:	7ce2                	ld	s9,56(sp)
    80007c4c:	7d42                	ld	s10,48(sp)
    80007c4e:	7da2                	ld	s11,40(sp)
    80007c50:	6149                	addi	sp,sp,144
    80007c52:	8082                	ret
    80007c54:	84ba                	mv	s1,a4
    80007c56:	b7b5                	j	80007bc2 <ext2_dir_link+0x14a>
		panic("ext2_dir_link(): Invalid inode mode");
    80007c58:	00002517          	auipc	a0,0x2
    80007c5c:	2f050513          	addi	a0,a0,752 # 80009f48 <syscalls+0xb70>
    80007c60:	ffff9097          	auipc	ra,0xffff9
    80007c64:	a02080e7          	jalr	-1534(ra) # 80000662 <panic>
    80007c68:	4789                	li	a5,2
    80007c6a:	b771                	j	80007bf6 <ext2_dir_link+0x17e>
    80007c6c:	4785                	li	a5,1
    80007c6e:	b761                	j	80007bf6 <ext2_dir_link+0x17e>
		return -1;
    80007c70:	557d                	li	a0,-1
    80007c72:	b7d1                	j	80007c36 <ext2_dir_link+0x1be>
				return -1;
    80007c74:	557d                	li	a0,-1
    80007c76:	b7c1                	j	80007c36 <ext2_dir_link+0x1be>

0000000080007c78 <ext2_balloc>:
{
    80007c78:	1141                	addi	sp,sp,-16
    80007c7a:	e406                	sd	ra,8(sp)
    80007c7c:	e022                	sd	s0,0(sp)
    80007c7e:	0800                	addi	s0,sp,16
	panic("ext2_balloc() not implemented!");
    80007c80:	00002517          	auipc	a0,0x2
    80007c84:	2f050513          	addi	a0,a0,752 # 80009f70 <syscalls+0xb98>
    80007c88:	ffff9097          	auipc	ra,0xffff9
    80007c8c:	9da080e7          	jalr	-1574(ra) # 80000662 <panic>

0000000080007c90 <ext2_bzero>:
{
    80007c90:	1141                	addi	sp,sp,-16
    80007c92:	e406                	sd	ra,8(sp)
    80007c94:	e022                	sd	s0,0(sp)
    80007c96:	0800                	addi	s0,sp,16
	panic("ext2_bzero() not implemented!");
    80007c98:	00002517          	auipc	a0,0x2
    80007c9c:	2f850513          	addi	a0,a0,760 # 80009f90 <syscalls+0xbb8>
    80007ca0:	ffff9097          	auipc	ra,0xffff9
    80007ca4:	9c2080e7          	jalr	-1598(ra) # 80000662 <panic>

0000000080007ca8 <ext2_cleanup>:
{
    80007ca8:	1141                	addi	sp,sp,-16
    80007caa:	e406                	sd	ra,8(sp)
    80007cac:	e022                	sd	s0,0(sp)
    80007cae:	0800                	addi	s0,sp,16
	panic("ext2_cleanup() not implemented!");
    80007cb0:	00002517          	auipc	a0,0x2
    80007cb4:	30050513          	addi	a0,a0,768 # 80009fb0 <syscalls+0xbd8>
    80007cb8:	ffff9097          	auipc	ra,0xffff9
    80007cbc:	9aa080e7          	jalr	-1622(ra) # 80000662 <panic>

0000000080007cc0 <find_next_zero_bit>:
#include <kernel/find_bits.h>
#include <kernel/defs.h>

unsigned int find_next_zero_bit(const unsigned int *addr, unsigned int size, unsigned int offset)
{
    80007cc0:	1141                	addi	sp,sp,-16
    80007cc2:	e422                	sd	s0,8(sp)
    80007cc4:	0800                	addi	s0,sp,16
	const unsigned int *p = addr + BITOP_WORD(offset);
	unsigned int result = offset & ~(BITS_PER_INT-1);
	unsigned int tmp;

	if(offset >= size) {
    80007cc6:	08b67d63          	bgeu	a2,a1,80007d60 <find_next_zero_bit+0xa0>
	const unsigned int *p = addr + BITOP_WORD(offset);
    80007cca:	0056579b          	srliw	a5,a2,0x5
    80007cce:	078a                	slli	a5,a5,0x2
    80007cd0:	00f50733          	add	a4,a0,a5
	unsigned int result = offset & ~(BITS_PER_INT-1);
    80007cd4:	fe067693          	andi	a3,a2,-32
		return size;
	}

	size -= result;
    80007cd8:	40d5883b          	subw	a6,a1,a3
    80007cdc:	0008079b          	sext.w	a5,a6
	offset %= BITS_PER_INT;
    80007ce0:	8a7d                	andi	a2,a2,31
	
	if(offset) {
    80007ce2:	c615                	beqz	a2,80007d0e <find_next_zero_bit+0x4e>
		tmp = *(p++);
    80007ce4:	430c                	lw	a1,0(a4)
		tmp |= ~0U >> (BITS_PER_INT - offset);
    80007ce6:	02000513          	li	a0,32
    80007cea:	9d11                	subw	a0,a0,a2
    80007cec:	567d                	li	a2,-1
    80007cee:	00a6563b          	srlw	a2,a2,a0
    80007cf2:	8dd1                	or	a1,a1,a2
    80007cf4:	2581                	sext.w	a1,a1
		if(size < BITS_PER_INT) {
    80007cf6:	467d                	li	a2,31
    80007cf8:	06f67263          	bgeu	a2,a5,80007d5c <find_next_zero_bit+0x9c>
			goto found_first;
		}

		if(~tmp) {
    80007cfc:	57fd                	li	a5,-1
	unsigned int result = offset & ~(BITS_PER_INT-1);
    80007cfe:	8536                	mv	a0,a3
		if(~tmp) {
    80007d00:	06f59163          	bne	a1,a5,80007d62 <find_next_zero_bit+0xa2>
		tmp = *(p++);
    80007d04:	0711                	addi	a4,a4,4
			goto found_middle;
		}

		size -= BITS_PER_INT;
    80007d06:	fe08079b          	addiw	a5,a6,-32
		result += BITS_PER_INT;
    80007d0a:	0206869b          	addiw	a3,a3,32
	}
	
	while(size & ~(BITS_PER_INT-1)) {
    80007d0e:	fe07f613          	andi	a2,a5,-32
    80007d12:	2601                	sext.w	a2,a2
    80007d14:	c229                	beqz	a2,80007d56 <find_next_zero_bit+0x96>
    80007d16:	8536                	mv	a0,a3
		if(~(tmp = *(p++))) {
    80007d18:	55fd                	li	a1,-1
    80007d1a:	9ebd                	addw	a3,a3,a5
    80007d1c:	0711                	addi	a4,a4,4
    80007d1e:	ffc72783          	lw	a5,-4(a4)
    80007d22:	04b79063          	bne	a5,a1,80007d62 <find_next_zero_bit+0xa2>
			goto found_middle;
		}
		
		result += BITS_PER_INT;
    80007d26:	0205079b          	addiw	a5,a0,32
    80007d2a:	0007851b          	sext.w	a0,a5
		size -= BITS_PER_INT;
    80007d2e:	40f687bb          	subw	a5,a3,a5
    80007d32:	0007861b          	sext.w	a2,a5
	while(size & ~(BITS_PER_INT-1)) {
    80007d36:	9b81                	andi	a5,a5,-32
    80007d38:	2781                	sext.w	a5,a5
    80007d3a:	f3ed                	bnez	a5,80007d1c <find_next_zero_bit+0x5c>
	}
	
	if(!size) {
    80007d3c:	c21d                	beqz	a2,80007d62 <find_next_zero_bit+0xa2>
		return result;
	}

	tmp = *p;
    80007d3e:	430c                	lw	a1,0(a4)
    80007d40:	87b2                	mv	a5,a2

found_first:
	tmp |= ~0U << size;
    80007d42:	577d                	li	a4,-1
    80007d44:	00f7173b          	sllw	a4,a4,a5
    80007d48:	8dd9                	or	a1,a1,a4
	
	if (tmp == ~0U)/* Are any bits zero? */
    80007d4a:	2581                	sext.w	a1,a1
    80007d4c:	577d                	li	a4,-1
    80007d4e:	00e59a63          	bne	a1,a4,80007d62 <find_next_zero_bit+0xa2>
		return result + size;	 /* Nope. */
    80007d52:	9d3d                	addw	a0,a0,a5
    80007d54:	a039                	j	80007d62 <find_next_zero_bit+0xa2>
	while(size & ~(BITS_PER_INT-1)) {
    80007d56:	8536                	mv	a0,a3
    80007d58:	863e                	mv	a2,a5
    80007d5a:	b7cd                	j	80007d3c <find_next_zero_bit+0x7c>
	unsigned int result = offset & ~(BITS_PER_INT-1);
    80007d5c:	8536                	mv	a0,a3
    80007d5e:	b7d5                	j	80007d42 <find_next_zero_bit+0x82>
		return size;
    80007d60:	852e                	mv	a0,a1
found_middle:
	return result + find_first_zero_bit(tmp);
    80007d62:	6422                	ld	s0,8(sp)
    80007d64:	0141                	addi	sp,sp,16
    80007d66:	8082                	ret
	...

0000000080008000 <_trampoline>:
    80008000:	14051573          	csrrw	a0,sscratch,a0
    80008004:	02153423          	sd	ra,40(a0)
    80008008:	02253823          	sd	sp,48(a0)
    8000800c:	02353c23          	sd	gp,56(a0)
    80008010:	04453023          	sd	tp,64(a0)
    80008014:	04553423          	sd	t0,72(a0)
    80008018:	04653823          	sd	t1,80(a0)
    8000801c:	04753c23          	sd	t2,88(a0)
    80008020:	f120                	sd	s0,96(a0)
    80008022:	f524                	sd	s1,104(a0)
    80008024:	fd2c                	sd	a1,120(a0)
    80008026:	e150                	sd	a2,128(a0)
    80008028:	e554                	sd	a3,136(a0)
    8000802a:	e958                	sd	a4,144(a0)
    8000802c:	ed5c                	sd	a5,152(a0)
    8000802e:	0b053023          	sd	a6,160(a0)
    80008032:	0b153423          	sd	a7,168(a0)
    80008036:	0b253823          	sd	s2,176(a0)
    8000803a:	0b353c23          	sd	s3,184(a0)
    8000803e:	0d453023          	sd	s4,192(a0)
    80008042:	0d553423          	sd	s5,200(a0)
    80008046:	0d653823          	sd	s6,208(a0)
    8000804a:	0d753c23          	sd	s7,216(a0)
    8000804e:	0f853023          	sd	s8,224(a0)
    80008052:	0f953423          	sd	s9,232(a0)
    80008056:	0fa53823          	sd	s10,240(a0)
    8000805a:	0fb53c23          	sd	s11,248(a0)
    8000805e:	11c53023          	sd	t3,256(a0)
    80008062:	11d53423          	sd	t4,264(a0)
    80008066:	11e53823          	sd	t5,272(a0)
    8000806a:	11f53c23          	sd	t6,280(a0)
    8000806e:	140022f3          	csrr	t0,sscratch
    80008072:	06553823          	sd	t0,112(a0)
    80008076:	00853103          	ld	sp,8(a0)
    8000807a:	02053203          	ld	tp,32(a0)
    8000807e:	01053283          	ld	t0,16(a0)
    80008082:	00053303          	ld	t1,0(a0)
    80008086:	18031073          	csrw	satp,t1
    8000808a:	12000073          	sfence.vma
    8000808e:	8282                	jr	t0

0000000080008090 <userret>:
    80008090:	18059073          	csrw	satp,a1
    80008094:	12000073          	sfence.vma
    80008098:	07053283          	ld	t0,112(a0)
    8000809c:	14029073          	csrw	sscratch,t0
    800080a0:	02853083          	ld	ra,40(a0)
    800080a4:	03053103          	ld	sp,48(a0)
    800080a8:	03853183          	ld	gp,56(a0)
    800080ac:	04053203          	ld	tp,64(a0)
    800080b0:	04853283          	ld	t0,72(a0)
    800080b4:	05053303          	ld	t1,80(a0)
    800080b8:	05853383          	ld	t2,88(a0)
    800080bc:	7120                	ld	s0,96(a0)
    800080be:	7524                	ld	s1,104(a0)
    800080c0:	7d2c                	ld	a1,120(a0)
    800080c2:	6150                	ld	a2,128(a0)
    800080c4:	6554                	ld	a3,136(a0)
    800080c6:	6958                	ld	a4,144(a0)
    800080c8:	6d5c                	ld	a5,152(a0)
    800080ca:	0a053803          	ld	a6,160(a0)
    800080ce:	0a853883          	ld	a7,168(a0)
    800080d2:	0b053903          	ld	s2,176(a0)
    800080d6:	0b853983          	ld	s3,184(a0)
    800080da:	0c053a03          	ld	s4,192(a0)
    800080de:	0c853a83          	ld	s5,200(a0)
    800080e2:	0d053b03          	ld	s6,208(a0)
    800080e6:	0d853b83          	ld	s7,216(a0)
    800080ea:	0e053c03          	ld	s8,224(a0)
    800080ee:	0e853c83          	ld	s9,232(a0)
    800080f2:	0f053d03          	ld	s10,240(a0)
    800080f6:	0f853d83          	ld	s11,248(a0)
    800080fa:	10053e03          	ld	t3,256(a0)
    800080fe:	10853e83          	ld	t4,264(a0)
    80008102:	11053f03          	ld	t5,272(a0)
    80008106:	11853f83          	ld	t6,280(a0)
    8000810a:	14051573          	csrrw	a0,sscratch,a0
    8000810e:	10200073          	sret
	...
