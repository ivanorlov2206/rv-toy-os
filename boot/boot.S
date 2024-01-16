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
	addi sp, sp, -40
	sd ra, 32(sp)
	sd a0, 24(sp)
	sd t0, 16(sp)
	sd t1, 8(sp)
	sd t2, 0(sp)

		
	li a0, 0x123
	ecall
	
	la a0, stimera
	call lputs

	ld ra, 32(sp)
	ld a0, 24(sp)
	ld t0, 16(sp)
	ld t1, 8(sp)
	ld t2, 0(sp)
	addi sp, sp, 40
	sret

asm_machine_trap:
	# overwrites stack?
	addi sp, sp, -40
	sd ra, 32(sp)
	sd a0, 24(sp)
	sd t0, 16(sp)
	sd t1, 8(sp)
	sd t2, 0(sp)

	csrr t0, mcause
	andi t0, t0, 0xFF
	li t2, 0x07
	bne t0, t2, not_timer
#	la a0, timer
timer:
	la a0, timera
	call lputs

	li t0, 0x20
	csrs mie, t0
	csrs mip, t0

	li t0, 0x2004000
	li t1, 50000000
	li t2, 0x200BFF8
	ld t2, 0(t2)

	add t2, t2, t1	
	sd t2, 0(t0)


	ld ra, 32(sp)
	ld a0, 24(sp)
	ld t0, 16(sp)
	ld t1, 8(sp)
	ld t2, 0(sp)
	addi sp, sp, 40
	
	
	mret
not_timer:
	li t0, 9
	csrr t1, mcause
	bne t1, t0, not_sbi_call
	li t1, 0x123
	beq a0, t1, sbi_clear_timer
	j wrong_sbi_call

sbi_clear_timer:
	la a0, clear_timer
	call lputs

	li t0, 0x20
	csrc mip, t0
	csrc mie, t0

	csrr t0, mepc
	addi t0, t0, 4
	csrw mepc, t0
wrong_sbi_call:
not_sbi_call:
	ld ra, 32(sp)
	ld a0, 24(sp)
	ld t0, 16(sp)
	ld t1, 8(sp)
	ld t2, 0(sp)
	addi sp, sp, 40
	
	mret



.global supervisor_mode
supervisor_mode:
	#j supervisor_m
	li t0, (1 << 11) | 0x2
	li t1, (3 << 3) | (1 << 2) | (1 << 1) | 1
	csrw pmpcfg0, t1
	li t1, -1
	csrw pmpaddr0, t1
	csrw mstatus, t0

# enable timer interrupts
	li t1, (1 << 7) | (1 << 5)
	csrs mie, t1

	li t1, 1 << 5
	csrs mideleg, t1

	li t0, 0x2004000
	li t1, 5000000
	sd t1, 0(t0)

	la t1, spv
	csrw mepc, t1

	mret

spv:
	la t1, strap
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
