#!/bin/bash

qemu-system-riscv64 -machine virt  -nographic -kernel image -bios none -serial mon:stdio -smp 1
