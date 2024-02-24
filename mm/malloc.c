#include <stdint.h>
#include <stddef.h>
#include "mm.h"
#include "../include/serial.h"
#include "../include/errno.h"

#define BLOCK_SIZES_COUNT 7

static const uint32_t block_sizes[BLOCK_SIZES_COUNT] = { 32, 64, 128, 256, 512, 4096, 16384 };
static const uint32_t blocks_per_size[BLOCK_SIZES_COUNT] = { 512, 512, 512, 512, 256, 256, 128 };
static uint32_t available_blocks[BLOCK_SIZES_COUNT];
static uint64_t avail;
static uint64_t kmalloc_start, kmalloc_pages_count;

void kmalloc_init(void)
{
	uint64_t total_amount = 0;
	uint32_t i;

	puts("Malloc init\n");

	for (i = 0; i < BLOCK_SIZES_COUNT; i++) {
		total_amount += block_sizes[i] * blocks_per_size[i];
		available_blocks[i] = blocks_per_size[i];
	}


	avail = alloc_pages(1);
	memset(avail, 0, PAGE_SIZE);

	kmalloc_pages_count = (total_amount + PAGE_SIZE - 1) / PAGE_SIZE;
	kmalloc_start = alloc_pages(kmalloc_pages_count);
	puts("Init successful\n");
}

int32_t block_size(uint64_t size)
{
	int32_t i;

	for (i = 0; i < BLOCK_SIZES_COUNT; i++) {
		if (size <= block_sizes[i])
			return i;
	}
	return -1;
}

int8_t leftmost0(uint8_t num)
{
	int8_t i;

	for (i = 0; i < 8; i++) {
		if (!(num & (1 << (8 - i - 1))))
			return i;
	}
	return -1;
}

void *kmalloc(uint64_t size)
{
	int32_t bsize = block_size(size);
	uint64_t skip = 0, skip_blocks = 0, i;
	uint8_t *byte;
	int8_t bit_ind;

	pr_n("Allocation size:", size);

	if (bsize == -1)
		return NULL;

	if (available_blocks[bsize] == 0)
		return NULL;

	for (i = 0; i < bsize; i++) {
		skip += blocks_per_size[i] * block_sizes[i];
		skip_blocks += blocks_per_size[i];
	}

	skip_blocks >>= 3;

	for (i = 0; i < blocks_per_size[bsize] >> 3; i++) {
		byte = (uint8_t *) (avail + skip_blocks + i);
		bit_ind = leftmost0(*byte);
		if (bit_ind == -1)
			continue;
		*byte = *byte | (1 << (7 - bit_ind));
		available_blocks[bsize]--;
		return (void *) (kmalloc_start + skip + (i * 8 + bit_ind) * block_sizes[bsize]);
	}

	return NULL;
}

void *kzalloc(uint64_t size)
{
	void *res = kmalloc(size);
	if (res == NULL)
		return (void *) ENOMEM;
	memset(res, 0, block_sizes[block_size(size)]);
	return res;
}

void print_allocated(void)
{
	uint64_t i;

	pr_n("Alloc start:", kmalloc_start);
	for (i = 0; i < BLOCK_SIZES_COUNT; i++) {
		puts("Count of size ");
		print_num(block_sizes[i]);
		pr_n(" available:", available_blocks[i]);
	}
}

void kfree(void *addr)
{
	uint64_t rel_addr = (uint64_t)addr - kmalloc_start;
	uint8_t bsize;
	uint64_t skip = 0, skip_blocks = 0, block_num;
	
	for (bsize = 0; bsize < BLOCK_SIZES_COUNT; bsize++) {
		if (rel_addr < skip + blocks_per_size[bsize] * block_sizes[bsize])
			break;
		skip += blocks_per_size[bsize] * block_sizes[bsize];
		skip_blocks += blocks_per_size[bsize];
	}
	if (bsize == BLOCK_SIZES_COUNT) {
		puts("Fail to kfree block which wasn't allocated\n");
		pr_n("Address: ", addr);
		while(1);
	}
	available_blocks[bsize]++;
	rel_addr -= skip;
	block_num = rel_addr / block_sizes[bsize];
	pr_n("Block num:", block_num);
	uint8_t *av_b = (uint8_t *) (avail + ((skip_blocks + block_num) >> 3));
	*av_b ^= (1 << (7 - (block_num % 8)));
}
