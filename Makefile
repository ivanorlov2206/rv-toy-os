all: Image

Image: kernel.o mm.o serial.o boot.o
	riscv64-unknown-elf-gcc -T link.lds -mcmodel=medany -ffreestanding -nostdlib -o image boot/boot.o mm/mm.o serial/serial.o kernel/kernel.o -lgcc

kernel.o:
	make -C kernel/
mm.o:
	make -C mm/
serial.o:
	make -C serial/
boot.o:
	make -C boot/


clean:
	make -C kernel/ clean
	make -C serial/ clean
	make -C boot/ clean
	make -C mm/ clean
	rm -rf *.o
	rm -rf image
