0000000080000eb4 <trap>:
    80000eb4:	710d                	add	sp,sp,-352
    80000eb6:	ee86                	sd	ra,344(sp)
    80000eb8:	ea96                	sd	t0,336(sp)
    80000eba:	e69a                	sd	t1,328(sp)
    80000ebc:	e29e                	sd	t2,320(sp)
    80000ebe:	fe22                	sd	s0,312(sp)
    80000ec0:	fa2a                	sd	a0,304(sp)
    80000ec2:	f62e                	sd	a1,296(sp)
    80000ec4:	f232                	sd	a2,288(sp)
    80000ec6:	ee36                	sd	a3,280(sp)
    80000ec8:	ea3a                	sd	a4,272(sp)
    80000eca:	e63e                	sd	a5,264(sp)
    80000ecc:	e242                	sd	a6,256(sp)
    80000ece:	fdc6                	sd	a7,248(sp)
    80000ed0:	f9f2                	sd	t3,240(sp)
    80000ed2:	f5f6                	sd	t4,232(sp)
    80000ed4:	f1fa                	sd	t5,224(sp)
    80000ed6:	edfe                	sd	t6,216(sp)
    80000ed8:	a582                	fsd	ft0,200(sp)
    80000eda:	a186                	fsd	ft1,192(sp)
    80000edc:	bd0a                	fsd	ft2,184(sp)
    80000ede:	b90e                	fsd	ft3,176(sp)
    80000ee0:	b512                	fsd	ft4,168(sp)
    80000ee2:	b116                	fsd	ft5,160(sp)
    80000ee4:	ad1a                	fsd	ft6,152(sp)
    80000ee6:	a91e                	fsd	ft7,144(sp)
    80000ee8:	a52a                	fsd	fa0,136(sp)
    80000eea:	a12e                	fsd	fa1,128(sp)
    80000eec:	bcb2                	fsd	fa2,120(sp)
    80000eee:	b8b6                	fsd	fa3,112(sp)
    80000ef0:	b4ba                	fsd	fa4,104(sp)
    80000ef2:	b0be                	fsd	fa5,96(sp)
    80000ef4:	acc2                	fsd	fa6,88(sp)
    80000ef6:	a8c6                	fsd	fa7,80(sp)
    80000ef8:	a4f2                	fsd	ft8,72(sp)
    80000efa:	a0f6                	fsd	ft9,64(sp)
    80000efc:	bc7a                	fsd	ft10,56(sp)
    80000efe:	b87e                	fsd	ft11,48(sp)
    80000f00:	1280                	add	s0,sp,352
    80000f02:	ec043423          	sd	zero,-312(s0)
    80000f06:	ec043023          	sd	zero,-320(s0)
    80000f0a:	ea043c23          	sd	zero,-328(s0)
    80000f0e:	ea043823          	sd	zero,-336(s0)
    80000f12:	ea043423          	sd	zero,-344(s0)
    80000f16:	342027f3          	csrr	a5,mcause
    80000f1a:	ecf43423          	sd	a5,-312(s0)
    80000f1e:	ec843783          	ld	a5,-312(s0)
    80000f22:	0407d663          	bgez	a5,80000f6e <trap+0xba>
    80000f26:	ec843783          	ld	a5,-312(s0)
    80000f2a:	0ff7f713          	zext.b	a4,a5
    80000f2e:	479d                	li	a5,7
    80000f30:	10f71063          	bne	a4,a5,80001030 <trap+0x17c>
    80000f34:	02000793          	li	a5,32
    80000f38:	3047a073          	csrs	mie,a5
    80000f3c:	02000793          	li	a5,32
    80000f40:	3447a073          	csrs	mip,a5
    80000f44:	0200c7b7          	lui	a5,0x200c
    80000f48:	17e1                	add	a5,a5,-8 # 200bff8 <_heap_size-0xdf70fd8>
    80000f4a:	639c                	ld	a5,0(a5)
    80000f4c:	eaf43423          	sd	a5,-344(s0)
    80000f50:	ea843703          	ld	a4,-344(s0)
    80000f54:	004c57b7          	lui	a5,0x4c5
    80000f58:	b4078793          	add	a5,a5,-1216 # 4c4b40 <_heap_size-0xfab8490>
    80000f5c:	97ba                	add	a5,a5,a4
    80000f5e:	eaf43423          	sd	a5,-344(s0)
    80000f62:	ea843783          	ld	a5,-344(s0)
    80000f66:	02004737          	lui	a4,0x2004
    80000f6a:	e31c                	sd	a5,0(a4)
    80000f6c:	a0d1                	j	80001030 <trap+0x17c>
    80000f6e:	ec843703          	ld	a4,-312(s0)
    80000f72:	47a5                	li	a5,9
    80000f74:	04f71563          	bne	a4,a5,80000fbe <trap+0x10a>
    80000f78:	87c6                	mv	a5,a7
    80000f7a:	ecf43023          	sd	a5,-320(s0)
    80000f7e:	00001517          	auipc	a0,0x1
    80000f82:	15250513          	add	a0,a0,338 # 800020d0 <_rodata_start+0xd0>
    80000f86:	e03ff0ef          	jal	80000d88 <puts>
    80000f8a:	ec043703          	ld	a4,-320(s0)
    80000f8e:	12300793          	li	a5,291
    80000f92:	00f71863          	bne	a4,a5,80000fa2 <trap+0xee>
    80000f96:	02000793          	li	a5,32
    80000f9a:	3047b073          	csrc	mie,a5
    80000f9e:	3447b073          	csrc	mip,a5
    80000fa2:	341027f3          	csrr	a5,mepc
    80000fa6:	eaf43823          	sd	a5,-336(s0)
    80000faa:	eb043783          	ld	a5,-336(s0)
    80000fae:	0791                	add	a5,a5,4
    80000fb0:	eaf43823          	sd	a5,-336(s0)
    80000fb4:	eb043783          	ld	a5,-336(s0)
    80000fb8:	34179073          	csrw	mepc,a5
    80000fbc:	a89d                	j	80001032 <trap+0x17e>
    80000fbe:	343027f3          	csrr	a5,mtval
    80000fc2:	eaf43c23          	sd	a5,-328(s0)
    80000fc6:	341027f3          	csrr	a5,mepc
    80000fca:	eaf43823          	sd	a5,-336(s0)
    80000fce:	00001517          	auipc	a0,0x1
    80000fd2:	10a50513          	add	a0,a0,266 # 800020d8 <_rodata_start+0xd8>
    80000fd6:	db3ff0ef          	jal	80000d88 <puts>
    80000fda:	eb043503          	ld	a0,-336(s0)
    80000fde:	e43ff0ef          	jal	80000e20 <print_num>
    80000fe2:	00001517          	auipc	a0,0x1
    80000fe6:	0fe50513          	add	a0,a0,254 # 800020e0 <_rodata_start+0xe0>
    80000fea:	d9fff0ef          	jal	80000d88 <puts>
    80000fee:	00001517          	auipc	a0,0x1
    80000ff2:	0fa50513          	add	a0,a0,250 # 800020e8 <_rodata_start+0xe8>
    80000ff6:	d93ff0ef          	jal	80000d88 <puts>
    80000ffa:	eb843503          	ld	a0,-328(s0)
    80000ffe:	e23ff0ef          	jal	80000e20 <print_num>
    80001002:	00001517          	auipc	a0,0x1
    80001006:	0de50513          	add	a0,a0,222 # 800020e0 <_rodata_start+0xe0>
    8000100a:	d7fff0ef          	jal	80000d88 <puts>
    8000100e:	00001517          	auipc	a0,0x1
    80001012:	0e250513          	add	a0,a0,226 # 800020f0 <_rodata_start+0xf0>
    80001016:	d73ff0ef          	jal	80000d88 <puts>
    8000101a:	ec843503          	ld	a0,-312(s0)
    8000101e:	e03ff0ef          	jal	80000e20 <print_num>
    80001022:	00001517          	auipc	a0,0x1
    80001026:	0be50513          	add	a0,a0,190 # 800020e0 <_rodata_start+0xe0>
    8000102a:	d5fff0ef          	jal	80000d88 <puts>
    8000102e:	a001                	j	8000102e <trap+0x17a>
    80001030:	0001                	nop
    80001032:	60f6                	ld	ra,344(sp)
    80001034:	62d6                	ld	t0,336(sp)
    80001036:	6336                	ld	t1,328(sp)
    80001038:	6396                	ld	t2,320(sp)
    8000103a:	7472                	ld	s0,312(sp)
    8000103c:	7552                	ld	a0,304(sp)
    8000103e:	75b2                	ld	a1,296(sp)
    80001040:	7612                	ld	a2,288(sp)
    80001042:	66f2                	ld	a3,280(sp)
    80001044:	6752                	ld	a4,272(sp)
    80001046:	67b2                	ld	a5,264(sp)
    80001048:	6812                	ld	a6,256(sp)
    8000104a:	78ee                	ld	a7,248(sp)
    8000104c:	7e4e                	ld	t3,240(sp)
    8000104e:	7eae                	ld	t4,232(sp)
    80001050:	7f0e                	ld	t5,224(sp)
    80001052:	6fee                	ld	t6,216(sp)
    80001054:	202e                	fld	ft0,200(sp)
    80001056:	208e                	fld	ft1,192(sp)
    80001058:	316a                	fld	ft2,184(sp)
    8000105a:	31ca                	fld	ft3,176(sp)
    8000105c:	322a                	fld	ft4,168(sp)
    8000105e:	328a                	fld	ft5,160(sp)
    80001060:	236a                	fld	ft6,152(sp)
    80001062:	23ca                	fld	ft7,144(sp)
    80001064:	252a                	fld	fa0,136(sp)
    80001066:	258a                	fld	fa1,128(sp)
    80001068:	3666                	fld	fa2,120(sp)
    8000106a:	36c6                	fld	fa3,112(sp)
    8000106c:	3726                	fld	fa4,104(sp)
    8000106e:	3786                	fld	fa5,96(sp)
    80001070:	2866                	fld	fa6,88(sp)
    80001072:	28c6                	fld	fa7,80(sp)
    80001074:	2e26                	fld	ft8,72(sp)
    80001076:	2e86                	fld	ft9,64(sp)
    80001078:	3f62                	fld	ft10,56(sp)
    8000107a:	3fc2                	fld	ft11,48(sp)
    8000107c:	6135                	add	sp,sp,352
    8000107e:	30200073          	mret
