.global _start

_start:
	csrr t0, mhartid
	bnez t0, finish

	csrw satp, zero
	la sp, _stack
	call kernel_main
finish:
	jal finish
