#include <stdint.h>
#include "../include/serial.h"
#include "../mm/mm.h"

void error_trap(void)
{
	uint64_t cause = 0;
	puts("Error! Fell into trap!\n");
	asm("csrr %0, mcause" : "=r" (cause):);
	pr_n("Cause: ", cause);
	while(1);
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
	puts("\nWe are in supervisor mode now\n");
}
