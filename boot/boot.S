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

	la t0, error_trap
	csrw mtvec, t0

	call kernel_main
finish:
	jal finish

.global supervisor_mode
supervisor_mode:
	#j supervisor_m
	li t0, 1 << 11
	li t1, (3 << 3) | (1 << 2) | (1 << 1) | 1
	csrw pmpcfg0, t1
	li t1, -1
	csrw pmpaddr0, t1
	csrw mstatus, t0
	la t1, supervisor_m
	csrw mepc, t1

	mret

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
