# RISC-V Toy Operating System

## Usage

### Compilation
To compile this toy os you would need a RISC-V [gcc cross compiler](https://github.com/riscv-collab/riscv-gnu-toolchain).
After obtaining it, run
```bash
make
```
### Running
The OS is supposed to be run in QEMU emulator. You can simply use `run.sh` script to start it:
```bash
./run.sh
```

## Feature list

- Simple round-robin scheduler
- Memory allocators: page allocator and cache allocator
- Driver for the serial tty
- Paging support
- Runs in the Supervisor (S) mode, kickstarts in Machine (M) mode

## TODO
- Refactor code everywhere (it was written at nights)
- Add more sofisticated scheduling strategy
- Improve the cache allocator: currently it can't allocate a few contineous blocks


