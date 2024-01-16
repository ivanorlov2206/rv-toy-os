#include <stdint.h>
#include "../include/serial.h"

struct task {
	void *stack;
	void *heap;
	struct table *table;
	uint64_t registers[64];
	uint64_t pointer;
};

struct task_queue_entry {
	struct task_queue_entry *next;
	struct task_queue_entry *prev;
	struct task task;
};


