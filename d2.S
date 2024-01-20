
image:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_start>:
f14022f3          	csrr	t0,mhartid
02029263          	bnez	t0,80000028 <finish>
00083117          	auipc	sp,0x83
02810113          	add	sp,sp,40 # 80083030 <_heap_start>
00001197          	auipc	gp,0x1
1da18193          	add	gp,gp,474 # 800011ea <_global_pointer>
00001297          	auipc	t0,0x1
e9c28293          	add	t0,t0,-356 # 80000eb4 <trap>
30529073          	csrw	mtvec,t0
13a010ef          	jal	8000115e <kernel_main>

0000000080000028 <finish>:
000000ef          	jal	80000028 <finish>

000000008000002c <lputs>:
100002b7          	lui	t0,0x10000

0000000080000030 <it>:
00054303          	lbu	t1,0(a0)
00030863          	beqz	t1,80000044 <rt>
00628023          	sb	t1,0(t0) # 10000000 <_heap_size+0x83030>
00150513          	add	a0,a0,1
ff1ff06f          	j	80000030 <it>

0000000080000044 <rt>:
00008067          	ret

0000000080000048 <supervisor_asm_trap>:
fd810113          	add	sp,sp,-40
02113023          	sd	ra,32(sp)
00a13c23          	sd	a0,24(sp)
00513823          	sd	t0,16(sp)
00613423          	sd	t1,8(sp)
00713023          	sd	t2,0(sp)
12300513          	li	a0,291
00000073          	ecall
00000517          	auipc	a0,0x0
1d350513          	add	a0,a0,467 # 8000023b <stimera>
fbdff0ef          	jal	8000002c <lputs>
02013083          	ld	ra,32(sp)
01813503          	ld	a0,24(sp)
01013283          	ld	t0,16(sp)
00813303          	ld	t1,8(sp)
00013383          	ld	t2,0(sp)
02810113          	add	sp,sp,40
10200073          	sret

0000000080000090 <asm_machine_trap>:
fd810113          	add	sp,sp,-40
02113023          	sd	ra,32(sp)
00a13c23          	sd	a0,24(sp)
00513823          	sd	t0,16(sp)
00613423          	sd	t1,8(sp)
00713023          	sd	t2,0(sp)
342022f3          	csrr	t0,mcause
0ff2f293          	zext.b	t0,t0
00700393          	li	t2,7
04729c63          	bne	t0,t2,8000010c <not_timer>

00000000800000b8 <timer>:
00000517          	auipc	a0,0x0
17c50513          	add	a0,a0,380 # 80000234 <timera>
f6dff0ef          	jal	8000002c <lputs>
02000293          	li	t0,32
3042a073          	csrs	mie,t0
3442a073          	csrs	mip,t0
020042b7          	lui	t0,0x2004
02faf337          	lui	t1,0x2faf
0803031b          	addw	t1,t1,128 # 2faf080 <_heap_size-0xcfcdf50>
0200c3b7          	lui	t2,0x200c
ff83839b          	addw	t2,t2,-8 # 200bff8 <_heap_size-0xdf70fd8>
0003b383          	ld	t2,0(t2)
006383b3          	add	t2,t2,t1
0072b023          	sd	t2,0(t0) # 2004000 <_heap_size-0xdf78fd0>
02013083          	ld	ra,32(sp)
01813503          	ld	a0,24(sp)
01013283          	ld	t0,16(sp)
00813303          	ld	t1,8(sp)
00013383          	ld	t2,0(sp)
02810113          	add	sp,sp,40
30200073          	mret

000000008000010c <not_timer>:
00900293          	li	t0,9
34202373          	csrr	t1,mcause
02531a63          	bne	t1,t0,80000148 <not_sbi_call>
12300313          	li	t1,291
00650463          	beq	a0,t1,80000124 <sbi_clear_timer>
0280006f          	j	80000148 <not_sbi_call>

0000000080000124 <sbi_clear_timer>:
00000517          	auipc	a0,0x0
12f50513          	add	a0,a0,303 # 80000253 <clear_timer>
f01ff0ef          	jal	8000002c <lputs>
02000293          	li	t0,32
3442b073          	csrc	mip,t0
3042b073          	csrc	mie,t0
341022f3          	csrr	t0,mepc
00428293          	add	t0,t0,4
34129073          	csrw	mepc,t0

0000000080000148 <not_sbi_call>:
02013083          	ld	ra,32(sp)
01813503          	ld	a0,24(sp)
01013283          	ld	t0,16(sp)
00813303          	ld	t1,8(sp)
00013383          	ld	t2,0(sp)
02810113          	add	sp,sp,40
30200073          	mret

0000000080000164 <supervisor_mode>:
000012b7          	lui	t0,0x1
8022829b          	addw	t0,t0,-2046 # 802 <_heap_size-0xff7c7ce>
01f00313          	li	t1,31
3a031073          	csrw	pmpcfg0,t1
fff00313          	li	t1,-1
3b031073          	csrw	pmpaddr0,t1
30029073          	csrw	mstatus,t0
00001317          	auipc	t1,0x1
f0830313          	add	t1,t1,-248 # 80001088 <strap>
10531073          	csrw	stvec,t1
0a000313          	li	t1,160
30432073          	csrs	mie,t1
02000313          	li	t1,32
30332073          	csrs	mideleg,t1
020042b7          	lui	t0,0x2004
004c5337          	lui	t1,0x4c5
b403031b          	addw	t1,t1,-1216 # 4c4b40 <_heap_size-0xfab8490>
0062b023          	sd	t1,0(t0) # 2004000 <_heap_size-0xdf78fd0>
00000317          	auipc	t1,0x0
01030313          	add	t1,t1,16 # 800001bc <spv>
34131073          	csrw	mepc,t1
30200073          	mret

00000000800001bc <spv>:
00001317          	auipc	t1,0x1
ecc30313          	add	t1,t1,-308 # 80001088 <strap>
10531073          	csrw	stvec,t1
7bf0006f          	j	80001186 <supervisor_m>

00000000800001cc <HEAP_SIZE>:
0ff7cfd0          	.word	0x0ff7cfd0
00000000          	.word	0x00000000

00000000800001d4 <HEAP_START>:
80083030          	.word	0x80083030
00000000          	.word	0x00000000

00000000800001dc <BSS_START>:
80003010          	.word	0x80003010
00000000          	.word	0x00000000

00000000800001e4 <BSS_END>:
80003030          	.word	0x80003030
00000000          	.word	0x00000000

00000000800001ec <RODATA_START>:
80002000          	.word	0x80002000
00000000          	.word	0x00000000

00000000800001f4 <RODATA_END>:
8000214c          	.word	0x8000214c
00000000          	.word	0x00000000

00000000800001fc <DATA_START>:
80003000          	.word	0x80003000
00000000          	.word	0x00000000

0000000080000204 <DATA_END>:
80003010          	.word	0x80003010
00000000          	.word	0x00000000

000000008000020c <TEXT_START>:
80000000          	.word	0x80000000
00000000          	.word	0x00000000

0000000080000214 <TEXT_END>:
800011ea          	.word	0x800011ea
00000000          	.word	0x00000000

000000008000021c <STACK>:
80083030          	.word	0x80083030
00000000          	.word	0x00000000

0000000080000224 <MEMORY_END>:
90000000          	.word	0x90000000
00000000          	.word	0x00000000

000000008000022c <MEMORY_START>:
80000000          	.word	0x80000000
00000000          	.word	0x00000000

0000000080000234 <timera>:
656d6954          	.word	0x656d6954
           	Address 0x80000238 is out of bounds.


000000008000023b <stimera>:
65707553          	.word	0x65707553
73697672          	.word	0x73697672
7420726f          	.word	0x7420726f
72656d69          	.word	0x72656d69
           	Address 0x8000024b is out of bounds.


000000008000024d <fail>:
4c494146          	.word	0x4c494146
           	Address 0x80000251 is out of bounds.


0000000080000253 <clear_timer>:
61656c43          	.word	0x61656c43
69742072          	.word	0x69742072
0a72656d          	.word	0x0a72656d
	...

0000000080000260 <newline>:
000a                	.short	0x000a
	...

0000000080000264 <get_heap_size>:
1141                	add	sp,sp,-16
e422                	sd	s0,8(sp)
0800                	add	s0,sp,16
00000797          	auipc	a5,0x0
f6278793          	add	a5,a5,-158 # 800001cc <HEAP_SIZE>
639c                	ld	a5,0(a5)
17c2                	sll	a5,a5,0x30
93c1                	srl	a5,a5,0x30
853e                	mv	a0,a5
6422                	ld	s0,8(sp)
0141                	add	sp,sp,16
8082                	ret

0000000080000280 <floor_page>:
1101                	add	sp,sp,-32
ec22                	sd	s0,24(sp)
1000                	add	s0,sp,32
fea43423          	sd	a0,-24(s0)
fe843703          	ld	a4,-24(s0)
77fd                	lui	a5,0xfffff
8ff9                	and	a5,a5,a4
853e                	mv	a0,a5
6462                	ld	s0,24(sp)
6105                	add	sp,sp,32
8082                	ret

000000008000029a <ceil_page>:
1101                	add	sp,sp,-32
ec22                	sd	s0,24(sp)
1000                	add	s0,sp,32
fea43423          	sd	a0,-24(s0)
fe843703          	ld	a4,-24(s0)
6785                	lui	a5,0x1
17fd                	add	a5,a5,-1 # fff <_heap_size-0xff7bfd1>
973e                	add	a4,a4,a5
77fd                	lui	a5,0xfffff
8ff9                	and	a5,a5,a4
853e                	mv	a0,a5
6462                	ld	s0,24(sp)
6105                	add	sp,sp,32
8082                	ret

00000000800002ba <init_pages>:
1101                	add	sp,sp,-32
ec06                	sd	ra,24(sp)
e822                	sd	s0,16(sp)
1000                	add	s0,sp,32
00000797          	auipc	a5,0x0
f0a78793          	add	a5,a5,-246 # 800001cc <HEAP_SIZE>
639c                	ld	a5,0(a5)
853e                	mv	a0,a5
fcdff0ef          	jal	8000029a <ceil_page>
87aa                	mv	a5,a0
00c7d713          	srl	a4,a5,0xc
00003797          	auipc	a5,0x3
d4078793          	add	a5,a5,-704 # 80003018 <pages_count>
e398                	sd	a4,0(a5)
00003797          	auipc	a5,0x3
d3678793          	add	a5,a5,-714 # 80003018 <pages_count>
6398                	ld	a4,0(a5)
6785                	lui	a5,0x1
17fd                	add	a5,a5,-1 # fff <_heap_size-0xff7bfd1>
97ba                	add	a5,a5,a4
00c7d713          	srl	a4,a5,0xc
00003797          	auipc	a5,0x3
d2a78793          	add	a5,a5,-726 # 80003020 <first_page>
e398                	sd	a4,0(a5)
00000797          	auipc	a5,0x0
ed478793          	add	a5,a5,-300 # 800001d4 <HEAP_START>
639c                	ld	a5,0(a5)
853e                	mv	a0,a5
f8fff0ef          	jal	8000029a <ceil_page>
872a                	mv	a4,a0
00003797          	auipc	a5,0x3
d1678793          	add	a5,a5,-746 # 80003028 <alloc_addr>
e398                	sd	a4,0(a5)
fe042623          	sw	zero,-20(s0)
a099                	j	80000366 <init_pages+0xac>
fec46703          	lwu	a4,-20(s0)
00000797          	auipc	a5,0x0
eae78793          	add	a5,a5,-338 # 800001d4 <HEAP_START>
639c                	ld	a5,0(a5)
97ba                	add	a5,a5,a4
fef43023          	sd	a5,-32(s0)
fec46703          	lwu	a4,-20(s0)
00003797          	auipc	a5,0x3
ce678793          	add	a5,a5,-794 # 80003020 <first_page>
639c                	ld	a5,0(a5)
00f77863          	bgeu	a4,a5,80000354 <init_pages+0x9a>
fe043783          	ld	a5,-32(s0)
577d                	li	a4,-1
00e78023          	sb	a4,0(a5)
a029                	j	8000035c <init_pages+0xa2>
fe043783          	ld	a5,-32(s0)
00078023          	sb	zero,0(a5)
fec42783          	lw	a5,-20(s0)
2785                	addw	a5,a5,1
fef42623          	sw	a5,-20(s0)
fec46703          	lwu	a4,-20(s0)
00003797          	auipc	a5,0x3
cae78793          	add	a5,a5,-850 # 80003018 <pages_count>
639c                	ld	a5,0(a5)
faf767e3          	bltu	a4,a5,80000322 <init_pages+0x68>
0001                	nop
0001                	nop
60e2                	ld	ra,24(sp)
6442                	ld	s0,16(sp)
6105                	add	sp,sp,32
8082                	ret

0000000080000384 <addr_by_num>:
1101                	add	sp,sp,-32
ec22                	sd	s0,24(sp)
1000                	add	s0,sp,32
fea43423          	sd	a0,-24(s0)
00003797          	auipc	a5,0x3
c9a78793          	add	a5,a5,-870 # 80003028 <alloc_addr>
639c                	ld	a5,0(a5)
00c7d713          	srl	a4,a5,0xc
fe843783          	ld	a5,-24(s0)
97ba                	add	a5,a5,a4
07b2                	sll	a5,a5,0xc
853e                	mv	a0,a5
6462                	ld	s0,24(sp)
6105                	add	sp,sp,32
8082                	ret

00000000800003ac <alloc_pages>:
7139                	add	sp,sp,-64
fc06                	sd	ra,56(sp)
f822                	sd	s0,48(sp)
0080                	add	s0,sp,64
87aa                	mv	a5,a0
fcf42623          	sw	a5,-52(s0)
57fd                	li	a5,-1
fef42423          	sw	a5,-24(s0)
fe042223          	sw	zero,-28(s0)
00003797          	auipc	a5,0x3
c5c78793          	add	a5,a5,-932 # 80003020 <first_page>
639c                	ld	a5,0(a5)
fef42623          	sw	a5,-20(s0)
a0a5                	j	8000043a <alloc_pages+0x8e>
fec42703          	lw	a4,-20(s0)
00000797          	auipc	a5,0x0
dfc78793          	add	a5,a5,-516 # 800001d4 <HEAP_START>
639c                	ld	a5,0(a5)
97ba                	add	a5,a5,a4
fcf43c23          	sd	a5,-40(s0)
fd843783          	ld	a5,-40(s0)
0007c783          	lbu	a5,0(a5)
c799                	beqz	a5,800003fe <alloc_pages+0x52>
fe042223          	sw	zero,-28(s0)
57fd                	li	a5,-1
fef42423          	sw	a5,-24(s0)
a815                	j	80000430 <alloc_pages+0x84>
fe842783          	lw	a5,-24(s0)
0007871b          	sext.w	a4,a5
57fd                	li	a5,-1
00f71663          	bne	a4,a5,80000414 <alloc_pages+0x68>
fec42783          	lw	a5,-20(s0)
fef42423          	sw	a5,-24(s0)
fe442783          	lw	a5,-28(s0)
2785                	addw	a5,a5,1
fef42223          	sw	a5,-28(s0)
fe442783          	lw	a5,-28(s0)
873e                	mv	a4,a5
fcc42783          	lw	a5,-52(s0)
2701                	sext.w	a4,a4
2781                	sext.w	a5,a5
02f75163          	bge	a4,a5,8000044e <alloc_pages+0xa2>
fec42783          	lw	a5,-20(s0)
2785                	addw	a5,a5,1
fef42623          	sw	a5,-20(s0)
fec42703          	lw	a4,-20(s0)
00003797          	auipc	a5,0x3
bda78793          	add	a5,a5,-1062 # 80003018 <pages_count>
639c                	ld	a5,0(a5)
f8f766e3          	bltu	a4,a5,800003d4 <alloc_pages+0x28>
a011                	j	80000450 <alloc_pages+0xa4>
0001                	nop
fe842783          	lw	a5,-24(s0)
0007871b          	sext.w	a4,a5
57fd                	li	a5,-1
00f71463          	bne	a4,a5,80000462 <alloc_pages+0xb6>
4785                	li	a5,1
a8a9                	j	800004ba <alloc_pages+0x10e>
fe842783          	lw	a5,-24(s0)
fef42623          	sw	a5,-20(s0)
a02d                	j	80000494 <alloc_pages+0xe8>
fec42703          	lw	a4,-20(s0)
00000797          	auipc	a5,0x0
d6478793          	add	a5,a5,-668 # 800001d4 <HEAP_START>
639c                	ld	a5,0(a5)
97ba                	add	a5,a5,a4
fcf43c23          	sd	a5,-40(s0)
fd843783          	ld	a5,-40(s0)
4705                	li	a4,1
00e78023          	sb	a4,0(a5)
fec42783          	lw	a5,-20(s0)
2785                	addw	a5,a5,1
fef42623          	sw	a5,-20(s0)
fe842783          	lw	a5,-24(s0)
873e                	mv	a4,a5
fcc42783          	lw	a5,-52(s0)
9fb9                	addw	a5,a5,a4
0007871b          	sext.w	a4,a5
fec42783          	lw	a5,-20(s0)
2781                	sext.w	a5,a5
fce7c1e3          	blt	a5,a4,8000046c <alloc_pages+0xc0>
fe842783          	lw	a5,-24(s0)
853e                	mv	a0,a5
ed1ff0ef          	jal	80000384 <addr_by_num>
87aa                	mv	a5,a0
853e                	mv	a0,a5
70e2                	ld	ra,56(sp)
7442                	ld	s0,48(sp)
6121                	add	sp,sp,64
8082                	ret

00000000800004c4 <free_pages>:
7179                	add	sp,sp,-48
f422                	sd	s0,40(sp)
1800                	add	s0,sp,48
fca43c23          	sd	a0,-40(s0)
87ae                	mv	a5,a1
fcf42a23          	sw	a5,-44(s0)
fd843783          	ld	a5,-40(s0)
83b1                	srl	a5,a5,0xc
0007871b          	sext.w	a4,a5
00000797          	auipc	a5,0x0
cf678793          	add	a5,a5,-778 # 800001d4 <HEAP_START>
6394                	ld	a3,0(a5)
6785                	lui	a5,0x1
17fd                	add	a5,a5,-1 # fff <_heap_size-0xff7bfd1>
97b6                	add	a5,a5,a3
83b1                	srl	a5,a5,0xc
2781                	sext.w	a5,a5
40f707bb          	subw	a5,a4,a5
fef42423          	sw	a5,-24(s0)
fe842783          	lw	a5,-24(s0)
fef42623          	sw	a5,-20(s0)
a025                	j	8000052a <free_pages+0x66>
fec46703          	lwu	a4,-20(s0)
00000797          	auipc	a5,0x0
ccc78793          	add	a5,a5,-820 # 800001d4 <HEAP_START>
639c                	ld	a5,0(a5)
97ba                	add	a5,a5,a4
fef43023          	sd	a5,-32(s0)
fe043783          	ld	a5,-32(s0)
00078023          	sb	zero,0(a5)
fec42783          	lw	a5,-20(s0)
2785                	addw	a5,a5,1
fef42623          	sw	a5,-20(s0)
fd442783          	lw	a5,-44(s0)
fe842703          	lw	a4,-24(s0)
9fb9                	addw	a5,a5,a4
0007871b          	sext.w	a4,a5
fec42783          	lw	a5,-20(s0)
2781                	sext.w	a5,a5
fce7e3e3          	bltu	a5,a4,80000504 <free_pages+0x40>
0001                	nop
0001                	nop
7422                	ld	s0,40(sp)
6145                	add	sp,sp,48
8082                	ret

000000008000054c <memset>:
7139                	add	sp,sp,-64
fc22                	sd	s0,56(sp)
0080                	add	s0,sp,64
fca43c23          	sd	a0,-40(s0)
87ae                	mv	a5,a1
fcc43423          	sd	a2,-56(s0)
fcf40ba3          	sb	a5,-41(s0)
fd843783          	ld	a5,-40(s0)
fef43423          	sd	a5,-24(s0)
fe042223          	sw	zero,-28(s0)
a00d                	j	8000058e <memset+0x42>
fe843783          	ld	a5,-24(s0)
fd744703          	lbu	a4,-41(s0)
00e78023          	sb	a4,0(a5)
fe843783          	ld	a5,-24(s0)
0785                	add	a5,a5,1
fef43423          	sd	a5,-24(s0)
fe442783          	lw	a5,-28(s0)
2785                	addw	a5,a5,1
fef42223          	sw	a5,-28(s0)
fe446783          	lwu	a5,-28(s0)
fc843703          	ld	a4,-56(s0)
fce7ece3          	bltu	a5,a4,8000056e <memset+0x22>
0001                	nop
0001                	nop
7462                	ld	s0,56(sp)
6121                	add	sp,sp,64
8082                	ret

00000000800005a4 <kmalloc>:
7179                	add	sp,sp,-48
f406                	sd	ra,40(sp)
f022                	sd	s0,32(sp)
1800                	add	s0,sp,48
fca43c23          	sd	a0,-40(s0)
fd843703          	ld	a4,-40(s0)
6785                	lui	a5,0x1
17fd                	add	a5,a5,-1 # fff <_heap_size-0xff7bfd1>
97ba                	add	a5,a5,a4
83b1                	srl	a5,a5,0xc
fef407a3          	sb	a5,-17(s0)
fef44783          	lbu	a5,-17(s0)
2781                	sext.w	a5,a5
853e                	mv	a0,a5
de5ff0ef          	jal	800003ac <alloc_pages>
87aa                	mv	a5,a0
853e                	mv	a0,a5
70a2                	ld	ra,40(sp)
7402                	ld	s0,32(sp)
6145                	add	sp,sp,48
8082                	ret

00000000800005d8 <kzalloc>:
7179                	add	sp,sp,-48
f406                	sd	ra,40(sp)
f022                	sd	s0,32(sp)
1800                	add	s0,sp,48
fca43c23          	sd	a0,-40(s0)
fd843703          	ld	a4,-40(s0)
6785                	lui	a5,0x1
17fd                	add	a5,a5,-1 # fff <_heap_size-0xff7bfd1>
97ba                	add	a5,a5,a4
83b1                	srl	a5,a5,0xc
fef407a3          	sb	a5,-17(s0)
fef44783          	lbu	a5,-17(s0)
2781                	sext.w	a5,a5
853e                	mv	a0,a5
db1ff0ef          	jal	800003ac <alloc_pages>
fea43023          	sd	a0,-32(s0)
fef44783          	lbu	a5,-17(s0)
2781                	sext.w	a5,a5
00c7979b          	sllw	a5,a5,0xc
2781                	sext.w	a5,a5
863e                	mv	a2,a5
4581                	li	a1,0
fe043503          	ld	a0,-32(s0)
f35ff0ef          	jal	8000054c <memset>
fe043783          	ld	a5,-32(s0)
853e                	mv	a0,a5
70a2                	ld	ra,40(sp)
7402                	ld	s0,32(sp)
6145                	add	sp,sp,48
8082                	ret

000000008000062a <kfree>:
7179                	add	sp,sp,-48
f406                	sd	ra,40(sp)
f022                	sd	s0,32(sp)
1800                	add	s0,sp,48
fca43c23          	sd	a0,-40(s0)
fcb43823          	sd	a1,-48(s0)
fd043703          	ld	a4,-48(s0)
6785                	lui	a5,0x1
17fd                	add	a5,a5,-1 # fff <_heap_size-0xff7bfd1>
97ba                	add	a5,a5,a4
83b1                	srl	a5,a5,0xc
fef407a3          	sb	a5,-17(s0)
fef44783          	lbu	a5,-17(s0)
2781                	sext.w	a5,a5
85be                	mv	a1,a5
fd843503          	ld	a0,-40(s0)
e6fff0ef          	jal	800004c4 <free_pages>
0001                	nop
70a2                	ld	ra,40(sp)
7402                	ld	s0,32(sp)
6145                	add	sp,sp,48
8082                	ret

0000000080000664 <entry_is_allocated>:
1101                	add	sp,sp,-32
ec22                	sd	s0,24(sp)
1000                	add	s0,sp,32
fea43423          	sd	a0,-24(s0)
fe843783          	ld	a5,-24(s0)
0007c703          	lbu	a4,0(a5)
0017c683          	lbu	a3,1(a5)
06a2                	sll	a3,a3,0x8
8f55                	or	a4,a4,a3
0027c683          	lbu	a3,2(a5)
06c2                	sll	a3,a3,0x10
8f55                	or	a4,a4,a3
0037c683          	lbu	a3,3(a5)
06e2                	sll	a3,a3,0x18
8f55                	or	a4,a4,a3
0047c683          	lbu	a3,4(a5)
1682                	sll	a3,a3,0x20
8f55                	or	a4,a4,a3
0057c683          	lbu	a3,5(a5)
16a2                	sll	a3,a3,0x28
8f55                	or	a4,a4,a3
0067c683          	lbu	a3,6(a5)
16c2                	sll	a3,a3,0x30
8f55                	or	a4,a4,a3
0077c783          	lbu	a5,7(a5)
17e2                	sll	a5,a5,0x38
8fd9                	or	a5,a5,a4
2781                	sext.w	a5,a5
8b85                	and	a5,a5,1
2781                	sext.w	a5,a5
853e                	mv	a0,a5
6462                	ld	s0,24(sp)
6105                	add	sp,sp,32
8082                	ret

00000000800006bc <get_next_entry>:
7179                	add	sp,sp,-48
f422                	sd	s0,40(sp)
1800                	add	s0,sp,48
fca43c23          	sd	a0,-40(s0)
fd843783          	ld	a5,-40(s0)
0007c703          	lbu	a4,0(a5)
0017c683          	lbu	a3,1(a5)
06a2                	sll	a3,a3,0x8
8f55                	or	a4,a4,a3
0027c683          	lbu	a3,2(a5)
06c2                	sll	a3,a3,0x10
8f55                	or	a4,a4,a3
0037c683          	lbu	a3,3(a5)
06e2                	sll	a3,a3,0x18
8f55                	or	a4,a4,a3
0047c683          	lbu	a3,4(a5)
1682                	sll	a3,a3,0x20
8f55                	or	a4,a4,a3
0057c683          	lbu	a3,5(a5)
16a2                	sll	a3,a3,0x28
8f55                	or	a4,a4,a3
0067c683          	lbu	a3,6(a5)
16c2                	sll	a3,a3,0x30
8f55                	or	a4,a4,a3
0077c783          	lbu	a5,7(a5)
17e2                	sll	a5,a5,0x38
8fd9                	or	a5,a5,a4
fef43423          	sd	a5,-24(s0)
fe843783          	ld	a5,-24(s0)
00a7d713          	srl	a4,a5,0xa
c00007b7          	lui	a5,0xc0000
83d1                	srl	a5,a5,0x14
8ff9                	and	a5,a5,a4
853e                	mv	a0,a5
7422                	ld	s0,40(sp)
6145                	add	sp,sp,48
8082                	ret

0000000080000722 <set_entry>:
715d                	add	sp,sp,-80
e4a2                	sd	s0,72(sp)
0880                	add	s0,sp,80
fca43423          	sd	a0,-56(s0)
fcb43023          	sd	a1,-64(s0)
87b2                	mv	a5,a2
faf40fa3          	sb	a5,-65(s0)
fc043783          	ld	a5,-64(s0)
83b1                	srl	a5,a5,0xc
1ff7f793          	and	a5,a5,511
fcf43c23          	sd	a5,-40(s0)
fc043783          	ld	a5,-64(s0)
83d5                	srl	a5,a5,0x15
1ff7f793          	and	a5,a5,511
fef43023          	sd	a5,-32(s0)
fc043783          	ld	a5,-64(s0)
01e7d713          	srl	a4,a5,0x1e
040007b7          	lui	a5,0x4000
17fd                	add	a5,a5,-1 # 3ffffff <_heap_size-0xbf7cfd1>
8ff9                	and	a5,a5,a4
fef43423          	sd	a5,-24(s0)
fe843783          	ld	a5,-24(s0)
01c79713          	sll	a4,a5,0x1c
fe043783          	ld	a5,-32(s0)
07ce                	sll	a5,a5,0x13
8f5d                	or	a4,a4,a5
fd843783          	ld	a5,-40(s0)
07aa                	sll	a5,a5,0xa
8f5d                	or	a4,a4,a5
fbf44783          	lbu	a5,-65(s0)
8fd9                	or	a5,a5,a4
0017e713          	or	a4,a5,1
fc843783          	ld	a5,-56(s0)
0ff77693          	zext.b	a3,a4
0007c603          	lbu	a2,0(a5)
8a01                	and	a2,a2,0
8ed1                	or	a3,a3,a2
00d78023          	sb	a3,0(a5)
00875693          	srl	a3,a4,0x8
0ff6f693          	zext.b	a3,a3
0017c603          	lbu	a2,1(a5)
8a01                	and	a2,a2,0
8ed1                	or	a3,a3,a2
00d780a3          	sb	a3,1(a5)
01075693          	srl	a3,a4,0x10
0ff6f693          	zext.b	a3,a3
0027c603          	lbu	a2,2(a5)
8a01                	and	a2,a2,0
8ed1                	or	a3,a3,a2
00d78123          	sb	a3,2(a5)
01875693          	srl	a3,a4,0x18
0ff6f693          	zext.b	a3,a3
0037c603          	lbu	a2,3(a5)
8a01                	and	a2,a2,0
8ed1                	or	a3,a3,a2
00d781a3          	sb	a3,3(a5)
02075693          	srl	a3,a4,0x20
0ff6f693          	zext.b	a3,a3
0047c603          	lbu	a2,4(a5)
8a01                	and	a2,a2,0
8ed1                	or	a3,a3,a2
00d78223          	sb	a3,4(a5)
02875693          	srl	a3,a4,0x28
0ff6f693          	zext.b	a3,a3
0057c603          	lbu	a2,5(a5)
8a01                	and	a2,a2,0
8ed1                	or	a3,a3,a2
00d782a3          	sb	a3,5(a5)
03075693          	srl	a3,a4,0x30
0ff6f693          	zext.b	a3,a3
0067c603          	lbu	a2,6(a5)
8a01                	and	a2,a2,0
8ed1                	or	a3,a3,a2
00d78323          	sb	a3,6(a5)
9361                	srl	a4,a4,0x38
0077c683          	lbu	a3,7(a5)
8a81                	and	a3,a3,0
8f55                	or	a4,a4,a3
00e783a3          	sb	a4,7(a5)
0001                	nop
6426                	ld	s0,72(sp)
6161                	add	sp,sp,80
8082                	ret

000000008000082a <map>:
711d                	add	sp,sp,-96
ec86                	sd	ra,88(sp)
e8a2                	sd	s0,80(sp)
1080                	add	s0,sp,96
faa43c23          	sd	a0,-72(s0)
fab43823          	sd	a1,-80(s0)
fac43423          	sd	a2,-88(s0)
87b6                	mv	a5,a3
faf403a3          	sb	a5,-89(s0)
87ba                	mv	a5,a4
faf40323          	sb	a5,-90(s0)
4789                	li	a5,2
fef403a3          	sb	a5,-25(s0)
fb043783          	ld	a5,-80(s0)
83b1                	srl	a5,a5,0xc
1ff7f793          	and	a5,a5,511
fcf43023          	sd	a5,-64(s0)
fb043783          	ld	a5,-80(s0)
83d5                	srl	a5,a5,0x15
1ff7f793          	and	a5,a5,511
fcf43423          	sd	a5,-56(s0)
fb043783          	ld	a5,-80(s0)
83f9                	srl	a5,a5,0x1e
1ff7f793          	and	a5,a5,511
fcf43823          	sd	a5,-48(s0)
fe744783          	lbu	a5,-25(s0)
2781                	sext.w	a5,a5
078e                	sll	a5,a5,0x3
17c1                	add	a5,a5,-16
97a2                	add	a5,a5,s0
fd07b783          	ld	a5,-48(a5)
078e                	sll	a5,a5,0x3
fb843703          	ld	a4,-72(s0)
97ba                	add	a5,a5,a4
fef43423          	sd	a5,-24(s0)
a8e1                	j	8000096e <map+0x144>
fe843503          	ld	a0,-24(s0)
dc9ff0ef          	jal	80000664 <entry_is_allocated>
87aa                	mv	a5,a0
ebb1                	bnez	a5,800008f6 <map+0xcc>
6505                	lui	a0,0x1
d33ff0ef          	jal	800005d8 <kzalloc>
fca43c23          	sd	a0,-40(s0)
00001517          	auipc	a0,0x1
75250513          	add	a0,a0,1874 # 80002000 <_rodata_start>
4d2000ef          	jal	80000d88 <puts>
fd843783          	ld	a5,-40(s0)
853e                	mv	a0,a5
560000ef          	jal	80000e20 <print_num>
00001517          	auipc	a0,0x1
74c50513          	add	a0,a0,1868 # 80002010 <_rodata_start+0x10>
4bc000ef          	jal	80000d88 <puts>
fa744783          	lbu	a5,-89(s0)
853e                	mv	a0,a5
54a000ef          	jal	80000e20 <print_num>
00001517          	auipc	a0,0x1
74650513          	add	a0,a0,1862 # 80002020 <_rodata_start+0x20>
4a6000ef          	jal	80000d88 <puts>
fd843783          	ld	a5,-40(s0)
4601                	li	a2,0
85be                	mv	a1,a5
fe843503          	ld	a0,-24(s0)
e31ff0ef          	jal	80000722 <set_entry>
fe843783          	ld	a5,-24(s0)
0007c703          	lbu	a4,0(a5)
0017c683          	lbu	a3,1(a5)
06a2                	sll	a3,a3,0x8
8f55                	or	a4,a4,a3
0027c683          	lbu	a3,2(a5)
06c2                	sll	a3,a3,0x10
8f55                	or	a4,a4,a3
0037c683          	lbu	a3,3(a5)
06e2                	sll	a3,a3,0x18
8f55                	or	a4,a4,a3
0047c683          	lbu	a3,4(a5)
1682                	sll	a3,a3,0x20
8f55                	or	a4,a4,a3
0057c683          	lbu	a3,5(a5)
16a2                	sll	a3,a3,0x28
8f55                	or	a4,a4,a3
0067c683          	lbu	a3,6(a5)
16c2                	sll	a3,a3,0x30
8f55                	or	a4,a4,a3
0077c783          	lbu	a5,7(a5)
17e2                	sll	a5,a5,0x38
8fd9                	or	a5,a5,a4
83a9                	srl	a5,a5,0xa
07b2                	sll	a5,a5,0xc
fef43423          	sd	a5,-24(s0)
fe744783          	lbu	a5,-25(s0)
37fd                	addw	a5,a5,-1
fef403a3          	sb	a5,-25(s0)
fe744783          	lbu	a5,-25(s0)
2781                	sext.w	a5,a5
078e                	sll	a5,a5,0x3
17c1                	add	a5,a5,-16
97a2                	add	a5,a5,s0
fd07b783          	ld	a5,-48(a5)
078e                	sll	a5,a5,0x3
fe843703          	ld	a4,-24(s0)
97ba                	add	a5,a5,a4
fef43423          	sd	a5,-24(s0)
fa744783          	lbu	a5,-89(s0)
2785                	addw	a5,a5,1
faf403a3          	sb	a5,-89(s0)
fa744783          	lbu	a5,-89(s0)
0ff7f713          	zext.b	a4,a5
4785                	li	a5,1
f2e7f0e3          	bgeu	a5,a4,80000898 <map+0x6e>
fa644783          	lbu	a5,-90(s0)
863e                	mv	a2,a5
fa843583          	ld	a1,-88(s0)
fe843503          	ld	a0,-24(s0)
d99ff0ef          	jal	80000722 <set_entry>
0001                	nop
60e6                	ld	ra,88(sp)
6446                	ld	s0,80(sp)
6125                	add	sp,sp,96
8082                	ret

0000000080000998 <map_kernel_range>:
7179                	add	sp,sp,-48
f406                	sd	ra,40(sp)
f022                	sd	s0,32(sp)
1800                	add	s0,sp,48
fea43423          	sd	a0,-24(s0)
feb43023          	sd	a1,-32(s0)
fcc43c23          	sd	a2,-40(s0)
87b6                	mv	a5,a3
fcf40ba3          	sb	a5,-41(s0)
fe043503          	ld	a0,-32(s0)
8cbff0ef          	jal	80000280 <floor_page>
fea43023          	sd	a0,-32(s0)
fd843503          	ld	a0,-40(s0)
8d9ff0ef          	jal	8000029a <ceil_page>
fca43c23          	sd	a0,-40(s0)
a01d                	j	800009f0 <map_kernel_range+0x58>
fd744783          	lbu	a5,-41(s0)
873e                	mv	a4,a5
4681                	li	a3,0
fe043603          	ld	a2,-32(s0)
fe043583          	ld	a1,-32(s0)
fe843503          	ld	a0,-24(s0)
e4bff0ef          	jal	8000082a <map>
fe043703          	ld	a4,-32(s0)
6785                	lui	a5,0x1
97ba                	add	a5,a5,a4
fef43023          	sd	a5,-32(s0)
fe043703          	ld	a4,-32(s0)
fd843783          	ld	a5,-40(s0)
fcf76ae3          	bltu	a4,a5,800009cc <map_kernel_range+0x34>
0001                	nop
0001                	nop
70a2                	ld	ra,40(sp)
7402                	ld	s0,32(sp)
6145                	add	sp,sp,48
8082                	ret

0000000080000a08 <print_table>:
7179                	add	sp,sp,-48
f406                	sd	ra,40(sp)
f022                	sd	s0,32(sp)
1800                	add	s0,sp,48
fca43c23          	sd	a0,-40(s0)
87ae                	mv	a5,a1
fcf40ba3          	sb	a5,-41(s0)
00001517          	auipc	a0,0x1
60e50513          	add	a0,a0,1550 # 80002028 <_rodata_start+0x28>
366000ef          	jal	80000d88 <puts>
fd843783          	ld	a5,-40(s0)
853e                	mv	a0,a5
3f4000ef          	jal	80000e20 <print_num>
00001517          	auipc	a0,0x1
60050513          	add	a0,a0,1536 # 80002030 <_rodata_start+0x30>
350000ef          	jal	80000d88 <puts>
fe042623          	sw	zero,-20(s0)
aa65                	j	80000bf8 <print_table+0x1f0>
fd843703          	ld	a4,-40(s0)
fec46783          	lwu	a5,-20(s0)
078e                	sll	a5,a5,0x3
97ba                	add	a5,a5,a4
0007c703          	lbu	a4,0(a5) # 1000 <_heap_size-0xff7bfd0>
0017c683          	lbu	a3,1(a5)
06a2                	sll	a3,a3,0x8
8f55                	or	a4,a4,a3
0027c683          	lbu	a3,2(a5)
06c2                	sll	a3,a3,0x10
8f55                	or	a4,a4,a3
0037c683          	lbu	a3,3(a5)
06e2                	sll	a3,a3,0x18
8f55                	or	a4,a4,a3
0047c683          	lbu	a3,4(a5)
1682                	sll	a3,a3,0x20
8f55                	or	a4,a4,a3
0057c683          	lbu	a3,5(a5)
16a2                	sll	a3,a3,0x28
8f55                	or	a4,a4,a3
0067c683          	lbu	a3,6(a5)
16c2                	sll	a3,a3,0x30
8f55                	or	a4,a4,a3
0077c783          	lbu	a5,7(a5)
17e2                	sll	a5,a5,0x38
8fd9                	or	a5,a5,a4
16078263          	beqz	a5,80000bee <print_table+0x1e6>
00001517          	auipc	a0,0x1
5ba50513          	add	a0,a0,1466 # 80002048 <_rodata_start+0x48>
2f2000ef          	jal	80000d88 <puts>
fec46783          	lwu	a5,-20(s0)
853e                	mv	a0,a5
380000ef          	jal	80000e20 <print_num>
00001517          	auipc	a0,0x1
5ac50513          	add	a0,a0,1452 # 80002050 <_rodata_start+0x50>
2dc000ef          	jal	80000d88 <puts>
fd843703          	ld	a4,-40(s0)
fec46783          	lwu	a5,-20(s0)
078e                	sll	a5,a5,0x3
97ba                	add	a5,a5,a4
0007c703          	lbu	a4,0(a5)
0017c683          	lbu	a3,1(a5)
06a2                	sll	a3,a3,0x8
8f55                	or	a4,a4,a3
0027c683          	lbu	a3,2(a5)
06c2                	sll	a3,a3,0x10
8f55                	or	a4,a4,a3
0037c683          	lbu	a3,3(a5)
06e2                	sll	a3,a3,0x18
8f55                	or	a4,a4,a3
0047c683          	lbu	a3,4(a5)
1682                	sll	a3,a3,0x20
8f55                	or	a4,a4,a3
0057c683          	lbu	a3,5(a5)
16a2                	sll	a3,a3,0x28
8f55                	or	a4,a4,a3
0067c683          	lbu	a3,6(a5)
16c2                	sll	a3,a3,0x30
8f55                	or	a4,a4,a3
0077c783          	lbu	a5,7(a5)
17e2                	sll	a5,a5,0x38
8fd9                	or	a5,a5,a4
853e                	mv	a0,a5
326000ef          	jal	80000e20 <print_num>
00001517          	auipc	a0,0x1
55a50513          	add	a0,a0,1370 # 80002058 <_rodata_start+0x58>
282000ef          	jal	80000d88 <puts>
fec46783          	lwu	a5,-20(s0)
078e                	sll	a5,a5,0x3
fd843703          	ld	a4,-40(s0)
97ba                	add	a5,a5,a4
853e                	mv	a0,a5
ba5ff0ef          	jal	800006bc <get_next_entry>
87aa                	mv	a5,a0
853e                	mv	a0,a5
300000ef          	jal	80000e20 <print_num>
00001517          	auipc	a0,0x1
4fc50513          	add	a0,a0,1276 # 80002020 <_rodata_start+0x20>
25c000ef          	jal	80000d88 <puts>
00001517          	auipc	a0,0x1
54050513          	add	a0,a0,1344 # 80002070 <_rodata_start+0x70>
250000ef          	jal	80000d88 <puts>
fd843703          	ld	a4,-40(s0)
fec46783          	lwu	a5,-20(s0)
078e                	sll	a5,a5,0x3
97ba                	add	a5,a5,a4
0007c703          	lbu	a4,0(a5)
0017c683          	lbu	a3,1(a5)
06a2                	sll	a3,a3,0x8
8f55                	or	a4,a4,a3
0027c683          	lbu	a3,2(a5)
06c2                	sll	a3,a3,0x10
8f55                	or	a4,a4,a3
0037c683          	lbu	a3,3(a5)
06e2                	sll	a3,a3,0x18
8f55                	or	a4,a4,a3
0047c683          	lbu	a3,4(a5)
1682                	sll	a3,a3,0x20
8f55                	or	a4,a4,a3
0057c683          	lbu	a3,5(a5)
16a2                	sll	a3,a3,0x28
8f55                	or	a4,a4,a3
0067c683          	lbu	a3,6(a5)
16c2                	sll	a3,a3,0x30
8f55                	or	a4,a4,a3
0077c783          	lbu	a5,7(a5)
17e2                	sll	a5,a5,0x38
8fd9                	or	a5,a5,a4
0ff7f793          	zext.b	a5,a5
853e                	mv	a0,a5
296000ef          	jal	80000e20 <print_num>
00001517          	auipc	a0,0x1
49250513          	add	a0,a0,1170 # 80002020 <_rodata_start+0x20>
1f2000ef          	jal	80000d88 <puts>
fd744783          	lbu	a5,-41(s0)
0ff7f793          	zext.b	a5,a5
c3a1                	beqz	a5,80000be2 <print_table+0x1da>
00001517          	auipc	a0,0x1
4dc50513          	add	a0,a0,1244 # 80002080 <_rodata_start+0x80>
1dc000ef          	jal	80000d88 <puts>
fec46783          	lwu	a5,-20(s0)
078e                	sll	a5,a5,0x3
fd843703          	ld	a4,-40(s0)
97ba                	add	a5,a5,a4
853e                	mv	a0,a5
affff0ef          	jal	800006bc <get_next_entry>
872a                	mv	a4,a0
fd744783          	lbu	a5,-41(s0)
37fd                	addw	a5,a5,-1
0ff7f793          	zext.b	a5,a5
85be                	mv	a1,a5
853a                	mv	a0,a4
e37ff0ef          	jal	80000a08 <print_table>
00001517          	auipc	a0,0x1
4b250513          	add	a0,a0,1202 # 80002088 <_rodata_start+0x88>
1aa000ef          	jal	80000d88 <puts>
00001517          	auipc	a0,0x1
43e50513          	add	a0,a0,1086 # 80002020 <_rodata_start+0x20>
19e000ef          	jal	80000d88 <puts>
fec42783          	lw	a5,-20(s0)
2785                	addw	a5,a5,1
fef42623          	sw	a5,-20(s0)
fec42783          	lw	a5,-20(s0)
0007871b          	sext.w	a4,a5
1ff00793          	li	a5,511
e2e7ffe3          	bgeu	a5,a4,80000a42 <print_table+0x3a>
0001                	nop
0001                	nop
70a2                	ld	ra,40(sp)
7402                	ld	s0,32(sp)
6145                	add	sp,sp,48
8082                	ret

0000000080000c14 <map_kernel>:
1101                	add	sp,sp,-32
ec06                	sd	ra,24(sp)
e822                	sd	s0,16(sp)
1000                	add	s0,sp,32
6505                	lui	a0,0x1
9bbff0ef          	jal	800005d8 <kzalloc>
872a                	mv	a4,a0
00002797          	auipc	a5,0x2
3ec78793          	add	a5,a5,1004 # 80003010 <root>
e398                	sd	a4,0(a5)
00002797          	auipc	a5,0x2
3e278793          	add	a5,a5,994 # 80003010 <root>
6398                	ld	a4,0(a5)
fffff797          	auipc	a5,0xfffff
5d478793          	add	a5,a5,1492 # 8000020c <TEXT_START>
638c                	ld	a1,0(a5)
fffff797          	auipc	a5,0xfffff
5d278793          	add	a5,a5,1490 # 80000214 <TEXT_END>
639c                	ld	a5,0(a5)
46b9                	li	a3,14
863e                	mv	a2,a5
853a                	mv	a0,a4
d47ff0ef          	jal	80000998 <map_kernel_range>
00002797          	auipc	a5,0x2
3ba78793          	add	a5,a5,954 # 80003010 <root>
6398                	ld	a4,0(a5)
fffff797          	auipc	a5,0xfffff
58c78793          	add	a5,a5,1420 # 800001ec <RODATA_START>
638c                	ld	a1,0(a5)
fffff797          	auipc	a5,0xfffff
58a78793          	add	a5,a5,1418 # 800001f4 <RODATA_END>
639c                	ld	a5,0(a5)
4699                	li	a3,6
863e                	mv	a2,a5
853a                	mv	a0,a4
d1fff0ef          	jal	80000998 <map_kernel_range>
00002797          	auipc	a5,0x2
39278793          	add	a5,a5,914 # 80003010 <root>
6398                	ld	a4,0(a5)
fffff797          	auipc	a5,0xfffff
57478793          	add	a5,a5,1396 # 800001fc <DATA_START>
638c                	ld	a1,0(a5)
fffff797          	auipc	a5,0xfffff
57278793          	add	a5,a5,1394 # 80000204 <DATA_END>
639c                	ld	a5,0(a5)
4699                	li	a3,6
863e                	mv	a2,a5
853a                	mv	a0,a4
cf7ff0ef          	jal	80000998 <map_kernel_range>
00002797          	auipc	a5,0x2
36a78793          	add	a5,a5,874 # 80003010 <root>
6398                	ld	a4,0(a5)
fffff797          	auipc	a5,0xfffff
52c78793          	add	a5,a5,1324 # 800001dc <BSS_START>
638c                	ld	a1,0(a5)
fffff797          	auipc	a5,0xfffff
52a78793          	add	a5,a5,1322 # 800001e4 <BSS_END>
639c                	ld	a5,0(a5)
4699                	li	a3,6
863e                	mv	a2,a5
853a                	mv	a0,a4
ccfff0ef          	jal	80000998 <map_kernel_range>
00002797          	auipc	a5,0x2
34278793          	add	a5,a5,834 # 80003010 <root>
6398                	ld	a4,0(a5)
fffff797          	auipc	a5,0xfffff
50c78793          	add	a5,a5,1292 # 800001e4 <BSS_END>
638c                	ld	a1,0(a5)
fffff797          	auipc	a5,0xfffff
53a78793          	add	a5,a5,1338 # 8000021c <STACK>
639c                	ld	a5,0(a5)
4699                	li	a3,6
863e                	mv	a2,a5
853a                	mv	a0,a4
ca7ff0ef          	jal	80000998 <map_kernel_range>
00002797          	auipc	a5,0x2
31a78793          	add	a5,a5,794 # 80003010 <root>
6388                	ld	a0,0(a5)
fffff797          	auipc	a5,0xfffff
4d478793          	add	a5,a5,1236 # 800001d4 <HEAP_START>
638c                	ld	a1,0(a5)
00002797          	auipc	a5,0x2
30e78793          	add	a5,a5,782 # 80003018 <pages_count>
639c                	ld	a5,0(a5)
00c79713          	sll	a4,a5,0xc
fffff797          	auipc	a5,0xfffff
4bc78793          	add	a5,a5,1212 # 800001d4 <HEAP_START>
639c                	ld	a5,0(a5)
97ba                	add	a5,a5,a4
4699                	li	a3,6
863e                	mv	a2,a5
c71ff0ef          	jal	80000998 <map_kernel_range>
00002797          	auipc	a5,0x2
2e478793          	add	a5,a5,740 # 80003010 <root>
639c                	ld	a5,0(a5)
4719                	li	a4,6
4681                	li	a3,0
10000637          	lui	a2,0x10000
100005b7          	lui	a1,0x10000
853e                	mv	a0,a5
ae7ff0ef          	jal	8000082a <map>
00002797          	auipc	a5,0x2
2c878793          	add	a5,a5,712 # 80003010 <root>
639c                	ld	a5,0(a5)
83b1                	srl	a5,a5,0xc
fef43423          	sd	a5,-24(s0)
fe843703          	ld	a4,-24(s0)
57fd                	li	a5,-1
17fe                	sll	a5,a5,0x3f
8fd9                	or	a5,a5,a4
fef43023          	sd	a5,-32(s0)
fe043783          	ld	a5,-32(s0)
18079073          	csrw	satp,a5
00001517          	auipc	a0,0x1
32250513          	add	a0,a0,802 # 80002090 <_rodata_start+0x90>
012000ef          	jal	80000d88 <puts>
beaff0ef          	jal	80000164 <supervisor_mode>
0001                	nop
60e2                	ld	ra,24(sp)
6442                	ld	s0,16(sp)
6105                	add	sp,sp,32
8082                	ret

0000000080000d88 <puts>:
1101                	add	sp,sp,-32
ec22                	sd	s0,24(sp)
1000                	add	s0,sp,32
fea43423          	sd	a0,-24(s0)
a005                	j	80000db2 <puts+0x2a>
fe843783          	ld	a5,-24(s0)
00178713          	add	a4,a5,1
fee43423          	sd	a4,-24(s0)
00002717          	auipc	a4,0x2
26070713          	add	a4,a4,608 # 80003000 <UART>
6318                	ld	a4,0(a4)
0007c783          	lbu	a5,0(a5)
00f70023          	sb	a5,0(a4)
fe843783          	ld	a5,-24(s0)
0007c783          	lbu	a5,0(a5)
ffe9                	bnez	a5,80000d94 <puts+0xc>
0001                	nop
0001                	nop
6462                	ld	s0,24(sp)
6105                	add	sp,sp,32
8082                	ret

0000000080000dc6 <putc>:
1101                	add	sp,sp,-32
ec22                	sd	s0,24(sp)
1000                	add	s0,sp,32
87aa                	mv	a5,a0
fef407a3          	sb	a5,-17(s0)
00002797          	auipc	a5,0x2
22e78793          	add	a5,a5,558 # 80003000 <UART>
639c                	ld	a5,0(a5)
fef44703          	lbu	a4,-17(s0)
00e78023          	sb	a4,0(a5)
0001                	nop
6462                	ld	s0,24(sp)
6105                	add	sp,sp,32
8082                	ret

0000000080000dec <getc>:
1141                	add	sp,sp,-16
e422                	sd	s0,8(sp)
0800                	add	s0,sp,16
0001                	nop
00002797          	auipc	a5,0x2
21478793          	add	a5,a5,532 # 80003008 <UART_READY>
639c                	ld	a5,0(a5)
0007c783          	lbu	a5,0(a5)
2781                	sext.w	a5,a5
8b85                	and	a5,a5,1
2781                	sext.w	a5,a5
d7f5                	beqz	a5,80000df4 <getc+0x8>
00002797          	auipc	a5,0x2
1f678793          	add	a5,a5,502 # 80003000 <UART>
639c                	ld	a5,0(a5)
0007c783          	lbu	a5,0(a5)
853e                	mv	a0,a5
6422                	ld	s0,8(sp)
0141                	add	sp,sp,16
8082                	ret

0000000080000e20 <print_num>:
711d                	add	sp,sp,-96
ec86                	sd	ra,88(sp)
e8a2                	sd	s0,80(sp)
1080                	add	s0,sp,96
faa43423          	sd	a0,-88(s0)
fe0404a3          	sb	zero,-23(s0)
fe0407a3          	sb	zero,-17(s0)
fa843783          	ld	a5,-88(s0)
ebb9                	bnez	a5,80000e8e <print_num+0x6e>
00001517          	auipc	a0,0x1
28e50513          	add	a0,a0,654 # 800020c8 <_rodata_start+0xc8>
f47ff0ef          	jal	80000d88 <puts>
a09d                	j	80000eac <print_num+0x8c>
fa843703          	ld	a4,-88(s0)
47a9                	li	a5,10
02f777b3          	remu	a5,a4,a5
0ff7f713          	zext.b	a4,a5
fef44783          	lbu	a5,-17(s0)
2781                	sext.w	a5,a5
03000693          	li	a3,48
40f687bb          	subw	a5,a3,a5
2781                	sext.w	a5,a5
0307071b          	addw	a4,a4,48
0ff77713          	zext.b	a4,a4
17c1                	add	a5,a5,-16
97a2                	add	a5,a5,s0
fce78423          	sb	a4,-56(a5)
fa843703          	ld	a4,-88(s0)
47a9                	li	a5,10
02f757b3          	divu	a5,a4,a5
faf43423          	sd	a5,-88(s0)
fef44783          	lbu	a5,-17(s0)
2785                	addw	a5,a5,1
fef407a3          	sb	a5,-17(s0)
fa843783          	ld	a5,-88(s0)
fbdd                	bnez	a5,80000e48 <print_num+0x28>
fef44783          	lbu	a5,-17(s0)
03100713          	li	a4,49
40f707b3          	sub	a5,a4,a5
fb840713          	add	a4,s0,-72
97ba                	add	a5,a5,a4
853e                	mv	a0,a5
ee1ff0ef          	jal	80000d88 <puts>
60e6                	ld	ra,88(sp)
6446                	ld	s0,80(sp)
6125                	add	sp,sp,96
8082                	ret

0000000080000eb4 <trap>:
710d                	add	sp,sp,-352
ee86                	sd	ra,344(sp)
ea96                	sd	t0,336(sp)
e69a                	sd	t1,328(sp)
e29e                	sd	t2,320(sp)
fe22                	sd	s0,312(sp)
fa2a                	sd	a0,304(sp)
f62e                	sd	a1,296(sp)
f232                	sd	a2,288(sp)
ee36                	sd	a3,280(sp)
ea3a                	sd	a4,272(sp)
e63e                	sd	a5,264(sp)
e242                	sd	a6,256(sp)
fdc6                	sd	a7,248(sp)
f9f2                	sd	t3,240(sp)
f5f6                	sd	t4,232(sp)
f1fa                	sd	t5,224(sp)
edfe                	sd	t6,216(sp)
a582                	fsd	ft0,200(sp)
a186                	fsd	ft1,192(sp)
bd0a                	fsd	ft2,184(sp)
b90e                	fsd	ft3,176(sp)
b512                	fsd	ft4,168(sp)
b116                	fsd	ft5,160(sp)
ad1a                	fsd	ft6,152(sp)
a91e                	fsd	ft7,144(sp)
a52a                	fsd	fa0,136(sp)
a12e                	fsd	fa1,128(sp)
bcb2                	fsd	fa2,120(sp)
b8b6                	fsd	fa3,112(sp)
b4ba                	fsd	fa4,104(sp)
b0be                	fsd	fa5,96(sp)
acc2                	fsd	fa6,88(sp)
a8c6                	fsd	fa7,80(sp)
a4f2                	fsd	ft8,72(sp)
a0f6                	fsd	ft9,64(sp)
bc7a                	fsd	ft10,56(sp)
b87e                	fsd	ft11,48(sp)
1280                	add	s0,sp,352
ec043423          	sd	zero,-312(s0)
ec043023          	sd	zero,-320(s0)
ea043c23          	sd	zero,-328(s0)
ea043823          	sd	zero,-336(s0)
ea043423          	sd	zero,-344(s0)
342027f3          	csrr	a5,mcause
ecf43423          	sd	a5,-312(s0)
ec843783          	ld	a5,-312(s0)
0407d963          	bgez	a5,80000f74 <trap+0xc0>
ec843783          	ld	a5,-312(s0)
0ff7f713          	zext.b	a4,a5
479d                	li	a5,7
10f71363          	bne	a4,a5,80001036 <trap+0x182>
02000793          	li	a5,32
3047a073          	csrs	mie,a5
02000793          	li	a5,32
3447a073          	csrs	mip,a5
0200c7b7          	lui	a5,0x200c
17e1                	add	a5,a5,-8 # 200bff8 <_heap_size-0xdf70fd8>
639c                	ld	a5,0(a5)
eaf43423          	sd	a5,-344(s0)
ea843703          	ld	a4,-344(s0)
004c57b7          	lui	a5,0x4c5
b4078793          	add	a5,a5,-1216 # 4c4b40 <_heap_size-0xfab8490>
97ba                	add	a5,a5,a4
eaf43423          	sd	a5,-344(s0)
ea843783          	ld	a5,-344(s0)
02004737          	lui	a4,0x2004
e31c                	sd	a5,0(a4)
87a2                	mv	a5,s0
eaf43423          	sd	a5,-344(s0)
a0d1                	j	80001036 <trap+0x182>
ec843703          	ld	a4,-312(s0)
47a5                	li	a5,9
04f71563          	bne	a4,a5,80000fc4 <trap+0x110>
87c6                	mv	a5,a7
ecf43023          	sd	a5,-320(s0)
00001517          	auipc	a0,0x1
14c50513          	add	a0,a0,332 # 800020d0 <_rodata_start+0xd0>
dfdff0ef          	jal	80000d88 <puts>
ec043703          	ld	a4,-320(s0)
12300793          	li	a5,291
00f71863          	bne	a4,a5,80000fa8 <trap+0xf4>
02000793          	li	a5,32
3047b073          	csrc	mie,a5
3447b073          	csrc	mip,a5
341027f3          	csrr	a5,mepc
eaf43823          	sd	a5,-336(s0)
eb043783          	ld	a5,-336(s0)
0791                	add	a5,a5,4
eaf43823          	sd	a5,-336(s0)
eb043783          	ld	a5,-336(s0)
34179073          	csrw	mepc,a5
a89d                	j	80001038 <trap+0x184>
343027f3          	csrr	a5,mtval
eaf43c23          	sd	a5,-328(s0)
341027f3          	csrr	a5,mepc
eaf43823          	sd	a5,-336(s0)
00001517          	auipc	a0,0x1
10450513          	add	a0,a0,260 # 800020d8 <_rodata_start+0xd8>
dadff0ef          	jal	80000d88 <puts>
eb043503          	ld	a0,-336(s0)
e3dff0ef          	jal	80000e20 <print_num>
00001517          	auipc	a0,0x1
0f850513          	add	a0,a0,248 # 800020e0 <_rodata_start+0xe0>
d99ff0ef          	jal	80000d88 <puts>
00001517          	auipc	a0,0x1
0f450513          	add	a0,a0,244 # 800020e8 <_rodata_start+0xe8>
d8dff0ef          	jal	80000d88 <puts>
eb843503          	ld	a0,-328(s0)
e1dff0ef          	jal	80000e20 <print_num>
00001517          	auipc	a0,0x1
0d850513          	add	a0,a0,216 # 800020e0 <_rodata_start+0xe0>
d79ff0ef          	jal	80000d88 <puts>
00001517          	auipc	a0,0x1
0dc50513          	add	a0,a0,220 # 800020f0 <_rodata_start+0xf0>
d6dff0ef          	jal	80000d88 <puts>
ec843503          	ld	a0,-312(s0)
dfdff0ef          	jal	80000e20 <print_num>
00001517          	auipc	a0,0x1
0b850513          	add	a0,a0,184 # 800020e0 <_rodata_start+0xe0>
d59ff0ef          	jal	80000d88 <puts>
a001                	j	80001034 <trap+0x180>
0001                	nop
60f6                	ld	ra,344(sp)
62d6                	ld	t0,336(sp)
6336                	ld	t1,328(sp)
6396                	ld	t2,320(sp)
7472                	ld	s0,312(sp)
7552                	ld	a0,304(sp)
75b2                	ld	a1,296(sp)
7612                	ld	a2,288(sp)
66f2                	ld	a3,280(sp)
6752                	ld	a4,272(sp)
67b2                	ld	a5,264(sp)
6812                	ld	a6,256(sp)
78ee                	ld	a7,248(sp)
7e4e                	ld	t3,240(sp)
7eae                	ld	t4,232(sp)
7f0e                	ld	t5,224(sp)
6fee                	ld	t6,216(sp)
202e                	fld	ft0,200(sp)
208e                	fld	ft1,192(sp)
316a                	fld	ft2,184(sp)
31ca                	fld	ft3,176(sp)
322a                	fld	ft4,168(sp)
328a                	fld	ft5,160(sp)
236a                	fld	ft6,152(sp)
23ca                	fld	ft7,144(sp)
252a                	fld	fa0,136(sp)
258a                	fld	fa1,128(sp)
3666                	fld	fa2,120(sp)
36c6                	fld	fa3,112(sp)
3726                	fld	fa4,104(sp)
3786                	fld	fa5,96(sp)
2866                	fld	fa6,88(sp)
28c6                	fld	fa7,80(sp)
2e26                	fld	ft8,72(sp)
2e86                	fld	ft9,64(sp)
3f62                	fld	ft10,56(sp)
3fc2                	fld	ft11,48(sp)
6135                	add	sp,sp,352
30200073          	mret

0000000080001088 <strap>:
7129                	add	sp,sp,-320
fe06                	sd	ra,312(sp)
fa16                	sd	t0,304(sp)
f61a                	sd	t1,296(sp)
f21e                	sd	t2,288(sp)
ee22                	sd	s0,280(sp)
ea2a                	sd	a0,272(sp)
e62e                	sd	a1,264(sp)
e232                	sd	a2,256(sp)
fdb6                	sd	a3,248(sp)
f9ba                	sd	a4,240(sp)
f5be                	sd	a5,232(sp)
f1c2                	sd	a6,224(sp)
edc6                	sd	a7,216(sp)
e9f2                	sd	t3,208(sp)
e5f6                	sd	t4,200(sp)
e1fa                	sd	t5,192(sp)
fd7e                	sd	t6,184(sp)
b502                	fsd	ft0,168(sp)
b106                	fsd	ft1,160(sp)
ad0a                	fsd	ft2,152(sp)
a90e                	fsd	ft3,144(sp)
a512                	fsd	ft4,136(sp)
a116                	fsd	ft5,128(sp)
bc9a                	fsd	ft6,120(sp)
b89e                	fsd	ft7,112(sp)
b4aa                	fsd	fa0,104(sp)
b0ae                	fsd	fa1,96(sp)
acb2                	fsd	fa2,88(sp)
a8b6                	fsd	fa3,80(sp)
a4ba                	fsd	fa4,72(sp)
a0be                	fsd	fa5,64(sp)
bc42                	fsd	fa6,56(sp)
b846                	fsd	fa7,48(sp)
b472                	fsd	ft8,40(sp)
b076                	fsd	ft9,32(sp)
ac7a                	fsd	ft10,24(sp)
a87e                	fsd	ft11,16(sp)
0280                	add	s0,sp,320
ec043423          	sd	zero,-312(s0)
142027f3          	csrr	a5,scause
ecf43423          	sd	a5,-312(s0)
ec843783          	ld	a5,-312(s0)
0207d363          	bgez	a5,8000110c <strap+0x84>
ec843783          	ld	a5,-312(s0)
0ff7f713          	zext.b	a4,a5
4795                	li	a5,5
00f71c63          	bne	a4,a5,8000110c <strap+0x84>
00001517          	auipc	a0,0x1
00850513          	add	a0,a0,8 # 80002100 <_rodata_start+0x100>
c89ff0ef          	jal	80000d88 <puts>
12300893          	li	a7,291
00000073          	ecall
0001                	nop
70f2                	ld	ra,312(sp)
72d2                	ld	t0,304(sp)
7332                	ld	t1,296(sp)
7392                	ld	t2,288(sp)
6472                	ld	s0,280(sp)
6552                	ld	a0,272(sp)
65b2                	ld	a1,264(sp)
6612                	ld	a2,256(sp)
76ee                	ld	a3,248(sp)
774e                	ld	a4,240(sp)
77ae                	ld	a5,232(sp)
780e                	ld	a6,224(sp)
68ee                	ld	a7,216(sp)
6e4e                	ld	t3,208(sp)
6eae                	ld	t4,200(sp)
6f0e                	ld	t5,192(sp)
7fea                	ld	t6,184(sp)
302a                	fld	ft0,168(sp)
308a                	fld	ft1,160(sp)
216a                	fld	ft2,152(sp)
21ca                	fld	ft3,144(sp)
222a                	fld	ft4,136(sp)
228a                	fld	ft5,128(sp)
3366                	fld	ft6,120(sp)
33c6                	fld	ft7,112(sp)
3526                	fld	fa0,104(sp)
3586                	fld	fa1,96(sp)
2666                	fld	fa2,88(sp)
26c6                	fld	fa3,80(sp)
2726                	fld	fa4,72(sp)
2786                	fld	fa5,64(sp)
3862                	fld	fa6,56(sp)
38c2                	fld	fa7,48(sp)
3e22                	fld	ft8,40(sp)
3e82                	fld	ft9,32(sp)
2f62                	fld	ft10,24(sp)
2fc2                	fld	ft11,16(sp)
6131                	add	sp,sp,320
10200073          	sret

000000008000115e <kernel_main>:
1141                	add	sp,sp,-16
e406                	sd	ra,8(sp)
e022                	sd	s0,0(sp)
0800                	add	s0,sp,16
954ff0ef          	jal	800002ba <init_pages>
aabff0ef          	jal	80000c14 <map_kernel>
00001517          	auipc	a0,0x1
fa250513          	add	a0,a0,-94 # 80002110 <_rodata_start+0x110>
c13ff0ef          	jal	80000d88 <puts>
4781                	li	a5,0
853e                	mv	a0,a5
60a2                	ld	ra,8(sp)
6402                	ld	s0,0(sp)
0141                	add	sp,sp,16
8082                	ret

0000000080001186 <supervisor_m>:
1101                	add	sp,sp,-32
ec06                	sd	ra,24(sp)
e822                	sd	s0,16(sp)
1000                	add	s0,sp,32
fe043423          	sd	zero,-24(s0)
00001517          	auipc	a0,0x1
f9650513          	add	a0,a0,-106 # 80002128 <_rodata_start+0x128>
befff0ef          	jal	80000d88 <puts>
fe043423          	sd	zero,-24(s0)
a035                	j	800011ce <supervisor_m+0x48>
00001517          	auipc	a0,0x1
fa450513          	add	a0,a0,-92 # 80002148 <_rodata_start+0x148>
bddff0ef          	jal	80000d88 <puts>
fe843503          	ld	a0,-24(s0)
c6dff0ef          	jal	80000e20 <print_num>
00001517          	auipc	a0,0x1
f2850513          	add	a0,a0,-216 # 800020e0 <_rodata_start+0xe0>
bc9ff0ef          	jal	80000d88 <puts>
fe843783          	ld	a5,-24(s0)
0785                	add	a5,a5,1
fef43423          	sd	a5,-24(s0)
fe843703          	ld	a4,-24(s0)
000f47b7          	lui	a5,0xf4
23f78793          	add	a5,a5,575 # f423f <_heap_size-0xfe88d91>
fce7f5e3          	bgeu	a5,a4,800011a4 <supervisor_m+0x1e>
0001                	nop
853e                	mv	a0,a5
60e2                	ld	ra,24(sp)
6442                	ld	s0,16(sp)
6105                	add	sp,sp,32
8082                	ret
