all: Image

LD := riscv64-unknown-elf-ld
CC := riscv64-unknown-elf-gcc
CFLAGS := rv64g
SRC := $(shell find . -name '*.c')
OBJS := $(SRC:c=o)
ARCH := rv64g

Image: boot.o $(OBJS)
	echo $(OBJS)
	$(CC) -T link.lds -march=$(ARCH) -mcmodel=medany -ffreestanding -nostdlib -o image boot/boot.o $(OBJS) -lgcc

%.o: %.c
	$(CC) -march=$(ARCH) -ffreestanding -nostdlib -mcmodel=medany -o $@ -c $< -Wall -Wextra

boot.o:
	make ARCH=$(ARCH) -C boot/


clean:
	rm -rf image
	rm -rf $(OBJS)
