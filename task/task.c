#include <stdint.h>
#include <stddef.h>
#include "../include/serial.h"
#include "../mm/mm.h"
#include "task.h"

#define TASK_POOL_PAGES 4

struct registers registers;

static void *task_memory;
static uint64_t tasks_count;
static uint64_t tasks_allocated;

struct task *current;
static struct task_queue *current_queue;

static void init_task_queue_pool(void)
{
	task_memory = kzalloc(TASK_POOL_PAGES * PAGE_SIZE);
	tasks_count = TASK_POOL_PAGES * PAGE_SIZE / sizeof(struct task_queue);
	tasks_allocated = 0;
}

static struct task_queue *alloc_task_queue(void)
{
	struct task_queue *res = (struct task_queue *) (task_memory + tasks_allocated * sizeof(struct task_queue));
	tasks_allocated++;
	return res;
}

static void end_of_task(void)
{
	uint64_t num = (uint64_t) current->data;
	pr_n("Task ended: ", num);
	current->status = END;
	schedule();
}

static void example_task_function(void *data)
{
	uint64_t i;
	uint64_t num = (uint64_t) data;
	for (i = 0; i < 10; i++){
		pr_n("Task number: ", num);
	}
}

static struct task tasks[10];
static struct task_queue main_queue;

void init_task(struct task *task, void (*func)(void *), void *data)
{
	task->regs.pc = (uint64_t) func;
	task->regs.ra = (uint64_t) &end_of_task;
	task->data = data;
	task->status = WAIT;
	task->regs.sp = alloc_pages(1) + PAGE_SIZE;
	task->table = root;
}
static void init_queue(struct task_queue *q)
{
	q->next = NULL;
	q->prev = NULL;
	q->task = NULL;
}
void add_to_queue(struct task *task, struct task_queue *queue)
{
	struct task_queue *task_elem = alloc_task_queue();
	struct task_queue *head = queue->prev;

	init_queue(task_elem);

	task_elem->task = task;
	task_elem->next = NULL;

	if (head) {
		head->next = task_elem;
		task_elem->prev = head;
	} else {
		queue->next = task_elem;
		task_elem->prev = queue;
	}
	queue->prev = task_elem;
}



static void traverse_queue(struct task_queue *q)
{
	struct task_queue *cq = q->next;

	while (cq) {
		uint64_t data = (uint64_t)cq->task->data;
		pr_n("Data: ", data);
		pr_n("PC: ", cq->task->regs.pc);

		cq = cq->next;
	}
}

extern void load_and_exec(void);
void schedule(void)
{
	struct task_queue *last;
	uint64_t sepc;
	asm("csrw sstatus, %0"::"r"((1 << 8) | (3 << 13)));
	if (current && current->status != END) {
		asm("csrr %0, sepc" : "=r" (sepc));
		current->regs.pc = sepc;
		asm("li tp, 0");
		add_to_queue(current, &main_queue);
	}
	while(!main_queue.next);
	current_queue = main_queue.next;
	current = current_queue->task;
	current->status = WORK;
	asm("mv tp, %0"::"r"(current));
	main_queue.next = current_queue->next;
	if (main_queue.next)
		current_queue->next->prev = current_queue;
	current->regs.a0 = current->data;
	asm("csrw sstatus, %0"::"r"((1 << 8) | (1 << 5) | (3 << 13)));
	load_and_exec();
}

void test_tasks(void)
{
	uint64_t i;

	init_task_queue_pool();
	init_queue(&main_queue);

	for (i = 0; i < 10; i++) {
		init_task(&tasks[i], &example_task_function, (void *)i);
		add_to_queue(&tasks[i], &main_queue);
	}

	puts("Tasks initialized:\n");

	traverse_queue(&main_queue);
}
