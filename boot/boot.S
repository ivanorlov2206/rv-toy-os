.global _start
.global HEAP_SIZE
.global HEAP_START
.global RODATA_START
.global RODATA_END
.global DATA_START
.global DATA_END
.global TEXT_START
.global TEXT_END
.global STACK
.global MEMORY_END
.global BSS_START
.global BSS_END
.global MEMORY_START

_start:
	csrr t0, mhartid
	bnez t0, finish

	#csrw satp, zero
	la sp, _stack
	la gp, _global_pointer

	# map the kernel

	la t0, trap
	csrw mtvec, t0

	call kernel_main
finish:
	jal finish

lputs:
	li t0, 0x10000000
it:
	lbu t1, 0(a0)
	beqz t1, rt
	sb t1, 0(t0)
	addi a0, a0, 1
	j it
rt:
	ret

supervisor_asm_trap:
	beqz tp, ft
	
	sd sp, 0(tp)
	sd ra, 8(tp)
	sd a0, 16(tp)
	sd a1, 24(tp)
	sd a2, 32(tp)
	sd a3, 40(tp)
	sd a4, 48(tp)
	sd a5, 56(tp)
	sd a6, 64(tp)
	sd a7, 72(tp)
	sd t0, 80(tp)
	sd t1, 88(tp)
	sd t2, 96(tp)
	sd t3, 104(tp)
	sd t4, 112(tp)
	sd t5, 120(tp)
	sd t6, 128(tp)
	sd s0, 136(tp)
	sd s1, 144(tp)
	sd s2, 152(tp)
	sd s3, 160(tp)
	sd s4, 168(tp)
	sd s5, 176(tp)
	sd s6, 184(tp)
	sd s7, 192(tp)
	sd s8, 200(tp)
	sd s9, 208(tp)
	sd s10, 216(tp)
	sd s11, 224(tp)
ft:
	j strap

.global load_and_exec
load_and_exec:
	ld ra, 8(tp)
	ld a0, 16(tp)
	ld a1, 24(tp)
	ld a2, 32(tp)
	ld a3, 40(tp)
	ld a4, 48(tp)
	ld a5, 56(tp)
	ld a6, 64(tp)
	ld a7, 72(tp)

	ld t0, 232(tp)
	csrw sepc, t0

	ld t0, 80(tp)
	ld t1, 88(tp)
	ld t2, 96(tp)
	ld t3, 104(tp)
	ld t4, 112(tp)
	ld t5, 120(tp)
	ld t6, 128(tp)
	ld s0, 136(tp)
	ld s1, 144(tp)
	ld s2, 152(tp)
	ld s3, 160(tp)
	ld s4, 168(tp)
	ld s5, 176(tp)
	ld s6, 184(tp)
	ld s7, 192(tp)
	ld s8, 200(tp)
	ld s9, 208(tp)
	ld s10, 216(tp)
	ld s11, 224(tp)
	ld sp, 0(tp)
	sret



.global supervisor_mode
supervisor_mode:
	#j supervisor_m
	li t0, (1 << 11) | 0x2
	li t1, (3 << 3) | (1 << 2) | (1 << 1) | 1
	csrw pmpcfg0, t1
	li t1, -1
	csrw pmpaddr0, t1
	csrw mstatus, t0

	la t1, supervisor_asm_trap
	csrw stvec, t1

# enable timer interrupts
	li t1, (1 << 7) | (1 << 5)
	csrs mie, t1

	li t1, 0x20
	csrs mideleg, t1

	li t0, 0x2004000
	li t1, 5000000
	sd t1, 0(t0)

	la t1, spv
	csrw mepc, t1

	mret

spv:
	li tp, 0
	la t1, supervisor_asm_trap
	csrw stvec, t1
	j supervisor_m

HEAP_SIZE: .dword _heap_size
HEAP_START: .dword _heap_start
BSS_START: .dword _bss_start
BSS_END: .dword _bss_end
RODATA_START: .dword _rodata_start
RODATA_END: .dword _rodata_end
DATA_START: .dword _data_start
DATA_END: .dword _data_end
TEXT_START: .dword _text_start
TEXT_END: .dword _text_end
STACK: .dword _stack
MEMORY_END: .dword _memory_end
MEMORY_START: .dword _memory_start
timera: .ascii "Timer\n\0"
stimera: .ascii "Supervisor timer\n\0"
fail: .ascii "FAIL\n\0"
clear_timer: .ascii "Clear timer\n\0"
newline: .ascii "\n\0"
