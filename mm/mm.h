#define PAGE_SIZE 4096
#define ENTRIES_PER_TABLE 512

struct table_entry {
	uint64_t entry;
} __attribute((packed));

struct table {
	struct table_entry entries[ENTRIES_PER_TABLE];
} __attribute((packed));


extern uint64_t HEAP_SIZE;
extern uint64_t HEAP_START;
extern uint64_t pages_count;
extern struct table *root;

void init_pages(void);
void kmalloc_init(void);
void *alloc_pages(int page_count);
void map(struct table *table, uint64_t vir, uint64_t phy, uint8_t level, uint8_t flags);
void map_kernel(void);
void *kzalloc(uint64_t size);
void memcpy(uint8_t *dst, uint8_t *src, uint64_t size);
void memset(void *addr, uint8_t chr, uint64_t size);
