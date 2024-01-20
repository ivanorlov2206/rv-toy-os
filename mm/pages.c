#include <stdint.h>
#include "../include/errno.h"
#include "mm.h"


uint64_t floor_page(uint64_t x)
{
	return x / PAGE_SIZE * PAGE_SIZE;
}

uint64_t ceil_page(uint64_t x)
{
	return (x + PAGE_SIZE - 1) / PAGE_SIZE * PAGE_SIZE;
}

struct page {
	uint8_t status;
};

static struct page *pages;
uint64_t pages_count;
static uint64_t first_page;
static uint64_t alloc_addr;

uint16_t get_heap_size(void)
{
	return HEAP_SIZE;
}

static void *addr_by_num(uint64_t page_num)
{
	return (void *)((alloc_addr / PAGE_SIZE + page_num) * PAGE_SIZE);
}

void init_pages(void)
{
	uint32_t i;
	struct page *page;

	pages_count = ceil_page(HEAP_SIZE) / PAGE_SIZE;

	first_page = (pages_count + PAGE_SIZE - 1) / PAGE_SIZE;
	alloc_addr = ceil_page(HEAP_START);
	pages = (uint8_t *) HEAP_START;

	for (i = 0; i < pages_count; i++) {
		page = &pages[i];
		page->status = i < first_page ? 0xFF : 0;
	}
}

static void *addr_by_page_num(uint64_t page_num)
{
	return (void *)(alloc_addr + page_num * PAGE_SIZE);
}

static void page_num_by_addr(uint64_t addr)
{

}

void *alloc_pages(int page_count) {
	struct page *page;
	int32_t i, start = -1, count_free = 0;

	for (i = first_page; i < pages_count; i++) {
		page = &pages[i];
		if (page->status) {
			count_free = 0;
			start = -1;
			continue;
		}
		if (start == -1)
			start = i;
		count_free++;
		if (count_free >= page_count)
			break;
	}
	if (start == -1)
		return (void *)ENOMEM;
	for (i = start; i < start + page_count; i++) {
		page = &pages[i];
		page->status = 1;
	}
	return addr_by_page_num(start);
}

void free_pages(void *addr, int page_count)
{
	uint32_t page_num = ((uint64_t)addr / PAGE_SIZE - (HEAP_START + PAGE_SIZE - 1) / PAGE_SIZE);
	struct page *page;
	uint32_t i;

	for (i = page_num; i < page_num + page_count; i++) {
		page = &pages[i];
		page->status = 0;
	}
}
