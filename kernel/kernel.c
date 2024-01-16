#include <stdint.h>
#include "../include/serial.h"
#include "../mm/mm.h"

__attribute__((interrupt("machine")))
void trap()
{
	uint64_t cause = 0, sys_num = 0;
	uint64_t mtval = 0, mepc = 0;
	asm("csrr %0, mcause" : "=r" (cause):);
	asm("mv %0, a7" : "=r"(sys_num):);
	puts("M interrupt\n");
	if (cause & ((uint64_t)1 << 63)) {
		if ((cause & 0xFF) == 0x07) {
			puts("M timer\n");
			// Timer;
			asm("li t0, 0x2004000 \n\t"
			    "li t1, 0x200bff8 \n\t"
			    "ld t1, 0(t1) \n\t"
			    "li t2, 5000000 \n\t"
			    "add t1, t1, t2 \n\t"
			    "sd t1, 0(t0) \n\t");
			asm("li t0, 0x20 \n\t"
			    "csrs mie, t0 \n\t"
			    "csrs mip, t0");
			return;
		}	
	} else {
		if (cause == 9) {
			puts("Ecall\n");
			if(sys_num == 0x123) {
				asm("li t0, 0x20 \n\t"
				    "csrc mie, t0 \n\t"
				    "csrc mip, t0 \n\t");
			}

			asm("csrr t0, mepc \n\t"
			    "addi t0, t0, 4 \n\t"
			    "csrw mepc, t0");
			return;

		} else {
			// Exception
			asm("csrr %0, mtval" : "=r" (mtval):);
			asm("csrr %0, mepc" : "=r" (mepc):);
			pr_n("mepc: ", mepc);
			pr_n("mtval: ", mtval);
			pr_n("mcause: ", cause);
			while (1);
		}
	}
	
}

__attribute__((interrupt("supervisor")))
void strap()
{
	uint64_t cause = 0;

	asm("csrr %0, scause" : "=r" (cause):);

	if (cause & ((uint64_t)1 << 63) && (cause & 0xFF) == 5) {
		puts("C timer\n");
		asm("li a7, 0x123 \n\t"
		    "ecall");
	}
}

int kernel_main(void)
{
	char c;
	uint64_t pointer1, pointer2, pointer3;

	init_pages();
	
	map_kernel();
	puts("\nHello, RISC-V world!\n");

	return 0;
}

int supervisor_m(void)
{
	uint64_t i = 0;

	puts("\nWe are in supervisor mode now\n");

	for (i = 0; i < 1000000; i++) {
		pr_n("i: ", i);
	}
}
