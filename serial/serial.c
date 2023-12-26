#include "../include/serial.h"

static char *UART = (char *) 0x10000000;

void puts(const char *s)
{
	while (*s) {
		*UART = *s;
		s++;
	}
}
