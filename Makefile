all: Image

Image:	kernel serial boot
	riscv64-unknown-elf-gcc -T link.lds -mcmodel=medany -ffreestanding -nostdlib -o image boot/boot.o serial/serial.o kernel/kernel.o

kernel:
	make -C kernel/
serial:
	make -C serial/
boot:
	make -C boot/

all:
	make -C kernel/
	make -C serial/
	make -C boot/


clean:
	rm -rf *.o
