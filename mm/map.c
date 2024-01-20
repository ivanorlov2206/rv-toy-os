#include <stdint.h>
#include "../include/serial.h"
#include "mm.h"



void memset(void *addr, uint8_t chr, uint64_t size)
{
	uint8_t *pos = (uint8_t *) addr;
	uint32_t i;

	for (i = 0; i < size; i++) {
		*pos = chr;
		pos++;
	}
}

void memcpy(uint8_t *dst, uint8_t *src, uint64_t size)
{
	uint64_t i;

	for (i = 0; i < size; i++) {
		*dst = *src;
		dst++;
		src++;
	}
}


static int entry_is_allocated(struct table_entry *entry)
{
	return entry->entry & 1;
}

static struct table_entry *get_next_entry(struct table_entry *entry) {
	uint64_t data = entry->entry;

	return (struct table_entry *)((data >> 10) & (((uint64_t)1 << 44) - 1) & ~0x3ff);
}

static void set_entry(struct table_entry *entry, uint64_t addr, uint8_t flags)
{
	uint64_t ppn[3] = { (addr >> 12) & 0x1FF, (addr >> 21) & 0x1FF, (addr >> 30) & 0x3ffffff };

	entry->entry = (ppn[2] << 28) | (ppn[1] << 19) | (ppn[0] << 10) | flags | 1;
}

void map(struct table *table, uint64_t vir, uint64_t phy, uint8_t level, uint8_t flags)
{
	struct table_entry *te;
	struct table *next_table;
	uint8_t pos = 2;
	uint64_t vir_s[3] = { (vir >> 12) & 0x1FF, (vir >> 21) & 0x1FF, (vir >> 30) & 0x1FF };

	te = &table->entries[vir_s[pos]];
	while (level < 2) {
		if (!entry_is_allocated(te)) {
			next_table = kzalloc(sizeof(*next_table));
			puts("Allocating ");
			print_num(next_table);
			puts(" for level ");
			print_num(level);
			puts("\n");
			set_entry(te, (uint64_t)next_table, 0);
		}
		te = (struct table_entry *)((te->entry >> 10) << 12);
		te += vir_s[--pos];
		level++;
	}
	set_entry(te, phy, flags);
}

void map_kernel_range(struct table *root, uint64_t vir, uint64_t vir_end, uint8_t flags)
{
	vir = floor_page(vir);
	vir_end = ceil_page(vir_end);

	while (vir < vir_end)
	{
		map(root, vir, vir, 0, flags);

		vir += PAGE_SIZE;
	}
}

struct table *root;

void print_table(struct table *table, uint8_t level)
{
	uint32_t i;

	puts("Table ");
	print_num((uint64_t)table);
	puts(" non-null entries:\n");

	for (i = 0; i < ENTRIES_PER_TABLE; i++) {
		if (table->entries[i].entry) {
			puts("Entry ");
			print_num(i);
			puts(" = ");
			print_num(table->entries[i].entry);
			pr_n(" with address = ", get_next_entry(&table->entries[i]));
			pr_n("and flags = ", table->entries[i].entry & 0xFF);
			if (level > 0) {
				puts("\n====\n");
				print_table((struct table *)get_next_entry(&table->entries[i]), level - 1);
				puts("====");
			}
			puts("\n");
		}
	}
}

extern uint64_t RODATA_START;
extern uint64_t RODATA_END;
extern uint64_t DATA_START;
extern uint64_t DATA_END;
extern uint64_t BSS_START;
extern uint64_t BSS_END;
extern uint64_t TEXT_START;
extern uint64_t TEXT_END;
extern uint64_t STACK;
extern uint64_t MEMORY_END;
extern uint64_t MEMORY_START;

extern void supervisor_mode(void);
void map_kernel(void)
{
	root = kzalloc(sizeof(*root));

	map_kernel_range(root, TEXT_START, TEXT_END, 0b1110);
	map_kernel_range(root, RODATA_START, RODATA_END, 0b0110);
	map_kernel_range(root, DATA_START, DATA_END, 0b0110);
	map_kernel_range(root, BSS_START, BSS_END, 0b0110);
	map_kernel_range(root, BSS_END, STACK, 0b0110);
	map_kernel_range(root, HEAP_START, HEAP_START + pages_count * PAGE_SIZE, 0b0110);

	//map_kernel_range(root, TEXT_START, MEMORY_END, 0b001110);
	map(root, 0x10000000, 0x10000000, 0, 0b0000110);
	//map(root, 0x2004000, 0x2004000, 0, 0b0000110);
	//map(root, 0x200BFF8, 0x200BFF8, 0, 0b0000110);

	uint64_t root_ppn = (uint64_t)root >> 12;
	uint64_t satp = (uint64_t)8 << 60 | root_ppn;

	asm("csrw satp, %0"
		:: "r" (satp));

	puts("Kernel mapped! Trying to enable supervisor mode...\n");
	supervisor_mode();
	//print_table(root, 2);
}
