#include <stdint.h>
#include "../include/serial.h"
#include "../mm/mm.h"
#include "../task/task.h"

static const uint64_t TIMER = 0x200BFF8;
static const uint64_t TIMER_CMP = 0x2004000;

__attribute__((interrupt("machine")))
void trap()
{
	uint64_t cause = 0, sys_num = 0;
	uint64_t mtval = 0, mepc = 0;
	uint64_t current_time = 0;
	asm("csrr %0, mcause" : "=r" (cause):);
	if (cause & ((uint64_t)1 << 63)) {
		if ((cause & 0xFF) == 0x07) {
			// Reset the timer
			asm("csrs mie, %0" :: "r"(0x20):);
			asm("csrs mip, %0" :: "r"(0x20):);

			asm("ld %0, 0(%1)" : "=r"(current_time) : "r"(TIMER):);
			current_time += (uint64_t)2000;
			asm("sd %0, 0(%1)" : :"r"(current_time), "r"(TIMER_CMP):);
		}
		return;
	} else if (cause == 9) {
		asm("mv %0, a7" : "=r"(sys_num):);
		if(sys_num == 0x123) {
			asm("csrc mie, %0 \n\t"
			    "csrc mip, %0" :: "r"(0x20):);
		}
		asm("csrr %0, mepc" : "=r"(mepc):);
		mepc += 4;
		asm("csrw mepc, %0"::"r"(mepc):);
		return;
	}
	// Exception
	puts("\nException.\n");
	asm("csrr %0, mtval" : "=r" (mtval):);
	asm("csrr %0, mepc" : "=r" (mepc):);
	pr_n("mepc: ", mepc);
	pr_n("mtval: ", mtval);
	pr_n("mcause: ", cause);
	while (1);
}

__attribute__((interrupt("supervisor")))
void strap()
{
	uint64_t cause = 0;

	asm("csrr %0, scause" : "=r" (cause):);
	
	if (cause & ((uint64_t)1 << 63) && (cause & 0xFF) == 5) {
		asm("li a7, 0x123 \n\t"
		    "ecall");
		schedule();
	}
}

int kernel_main(void)
{
	init_pages();
	
	map_kernel();
	puts("\nThe kernel loaded\n");

	return 0;
}

void supervisor_m(void)
{
	test_tasks();
	puts("\nWe are in supervisor mode now\n");
}
