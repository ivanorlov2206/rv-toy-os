#!/bin/bash

qemu-system-riscv64 -machine virt -cpu rv64,c=on -nographic -kernel image -bios none -serial mon:stdio -smp 1
