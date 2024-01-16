#include <stdint.h>
#include "mm.h"
#include "../include/errno.h"

void *kmalloc(uint64_t size)
{
	uint8_t pages_count = (size + PAGE_SIZE - 1) / PAGE_SIZE;
	return alloc_pages(pages_count);
}

void *kzalloc(uint64_t size)
{
	uint8_t pcount = (size + PAGE_SIZE - 1) / PAGE_SIZE;
	void *res = alloc_pages(pcount);
	if (res == ENOMEM)
		return (void *) ENOMEM;
	memset(res, 0, pcount * PAGE_SIZE);
	return res;
}

void kfree(void *addr, uint64_t size)
{
	uint8_t pages_count = (size + PAGE_SIZE - 1) / PAGE_SIZE;

	free_pages(addr, pages_count);
}
