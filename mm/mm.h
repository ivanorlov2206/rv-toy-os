#define ENTRIES_PER_TABLE 512

struct table_entry {
	uint64_t entry;
} __attribute((packed));

struct table {
	struct table_entry entries[ENTRIES_PER_TABLE];
} __attribute((packed));

void init_pages(void);
void *alloc_pages(int page_count);
void map(struct table *table, uint64_t vir, uint64_t phy, uint8_t level, uint8_t flags);
void map_kernel(void);
