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
0407d663          	bgez	a5,80000f6e <trap+0xba>
ec843783          	ld	a5,-312(s0)
0ff7f713          	zext.b	a4,a5
479d                	li	a5,7
10f71063          	bne	a4,a5,80001030 <trap+0x17c>
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
a0d1                	j	80001030 <trap+0x17c>
ec843703          	ld	a4,-312(s0)
47a5                	li	a5,9
04f71563          	bne	a4,a5,80000fbe <trap+0x10a>
87c6                	mv	a5,a7
ecf43023          	sd	a5,-320(s0)
00001517          	auipc	a0,0x1
15250513          	add	a0,a0,338 # 800020d0 <_rodata_start+0xd0>
e03ff0ef          	jal	80000d88 <puts>
ec043703          	ld	a4,-320(s0)
12300793          	li	a5,291
00f71863          	bne	a4,a5,80000fa2 <trap+0xee>
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
a89d                	j	80001032 <trap+0x17e>
343027f3          	csrr	a5,mtval
eaf43c23          	sd	a5,-328(s0)
341027f3          	csrr	a5,mepc
eaf43823          	sd	a5,-336(s0)
00001517          	auipc	a0,0x1
10a50513          	add	a0,a0,266 # 800020d8 <_rodata_start+0xd8>
db3ff0ef          	jal	80000d88 <puts>
eb043503          	ld	a0,-336(s0)
e43ff0ef          	jal	80000e20 <print_num>
00001517          	auipc	a0,0x1
0fe50513          	add	a0,a0,254 # 800020e0 <_rodata_start+0xe0>
d9fff0ef          	jal	80000d88 <puts>
00001517          	auipc	a0,0x1
0fa50513          	add	a0,a0,250 # 800020e8 <_rodata_start+0xe8>
d93ff0ef          	jal	80000d88 <puts>
eb843503          	ld	a0,-328(s0)
e23ff0ef          	jal	80000e20 <print_num>
00001517          	auipc	a0,0x1
0de50513          	add	a0,a0,222 # 800020e0 <_rodata_start+0xe0>
d7fff0ef          	jal	80000d88 <puts>
00001517          	auipc	a0,0x1
0e250513          	add	a0,a0,226 # 800020f0 <_rodata_start+0xf0>
d73ff0ef          	jal	80000d88 <puts>
ec843503          	ld	a0,-312(s0)
e03ff0ef          	jal	80000e20 <print_num>
00001517          	auipc	a0,0x1
0be50513          	add	a0,a0,190 # 800020e0 <_rodata_start+0xe0>
d5fff0ef          	jal	80000d88 <puts>
a001                	j	8000102e <trap+0x17a>
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
