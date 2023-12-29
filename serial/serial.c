#include "../include/serial.h"

static unsigned char *UART = (unsigned char *)0x10000000;
static unsigned char *UART_READY = (unsigned char *)0x10000005;

void puts(char *s)
{
	while (*s)
		*UART = *s++;
}

void putc(char c)
{
	*UART = c;
}

char getc(void)
{
	while (!(*UART_READY & 1));
	return *UART;
}

void print_num(uint64_t num)
{
	char buf[50];
	buf[49] = 0;
	uint8_t len = 0;

	if (num == 0) {
		puts("0");
		return;
	}

	while (num > 0) {
		buf[48 - len] = (num % 10) + '0';
		num /= 10;
		len++;
	}
	puts(buf + 49 - len);
}
