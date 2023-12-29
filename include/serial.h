#include <stdint.h>

#define pr_n(c, n) puts(c); print_num(n); puts("\n");

void puts(char *s);
char getc(void);
void putc(char c);

void print_num(uint64_t num);
