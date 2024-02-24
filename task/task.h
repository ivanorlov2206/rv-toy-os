enum task_status {
	WAIT,
	WORK,
	END,
};

struct registers {
	uint64_t sp;
	uint64_t ra;
	uint64_t a0;
	uint64_t a1;
	uint64_t a2;
	uint64_t a3;
	uint64_t a4;
	uint64_t a5;
	uint64_t a6;
	uint64_t a7;
	uint64_t t0;
	uint64_t t1;
	uint64_t t2;
	uint64_t t3;
	uint64_t t4;
	uint64_t t5;
	uint64_t t6;
	uint64_t s0;
	uint64_t s1;
	uint64_t s2;
	uint64_t s3;
	uint64_t s4;
	uint64_t s5;
	uint64_t s6;
	uint64_t s7;
	uint64_t s8;
	uint64_t s9;
	uint64_t s10;
	uint64_t s11;
	uint64_t pc;
};

#define M_CALL(n) asm("li a7, " # n "\n\t ecall"::)

extern void load_and_exec(void);
struct task {
	struct registers regs;
	void *stack;
	void *heap;
	void *data;
	struct table *table;
	enum task_status status;
};

struct task_queue {
	struct task_queue *next;
	struct task_queue *prev;
	struct task *task;
};

void print_allocated(void);
void test_tasks(void);
void schedule(void);
extern struct task *current;
