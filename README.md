# Bare Project
## What is it?
**Bare** is a framework for `x86_64` Assembly, which tries to clear (or at least arrange) the roadblocks faced by new Assembly Developers (myself counted). It uses **NASM** micros and functions to make things simple. Currently, it supports 64-Bit (`x86_64`) Linux only. Support for more architectures (starting with 64-bit ARM) and platforms is on the roadmap.

Bare tries to support most (if not all) of the syscalls offered by the Linux kernel. It takes time.
For a comprehensive list of such, see [this](#syscalls).

## I don't understand it
Neither do I. That's why I needed to create a completely new (and probably useless) convention for it. It's described [here](#the-convention).

## The Convention
To make sure that I understand what is for what, I created a small convention for Bare. I named it...**Bare x86 Convention** (BxC, for short), because it only applies to `x86_64` architecture.

### Functions
In BxC, functions MUST be prefixed with `f_`. It prevents conflict between macros and functions.
All the functions are allowed to use `rax`, `rbx`, `rcx`, and `rdx` as input registers. However, all of them must retain their original state at the end of the function (except `rcx` and `rdx`, for certain functions like `f_read`, which needs memory location). They are allowed to use `rdi` and `rsi` as output registers\*. Every other general purpose register, such as `rbp`, `rsp`, `r8` to `r15` can be used as temporary registers.

> \* - In certain scenario, when you need more than 2 output registers, you can use `rbp` and `rsp`.

### Macros
In BxC, macros MUST be neither prefixed nor suffixed. They don't have any rule regarding input or output.

### Constants
In BxC, any constant, let that be defined with `equ`, `db`, or simply `%define`, MUST end with `_C` suffix. This is to identify constants and avoid using them as macros.

> Example: `O_RDWR_C` and `O_CREAT_C` are 2 constants in `std.fs`, which are used as mode for `f_open`. They are (respectively) for Read-Write and Create.

## Syscalls
|    #      |      Syscall        |    Equivalent Macro  | Equivalent Function | Signature   |
| :-------: | :-----------------: | :------------------: | :-----------------: | :---------:  |
|    0      |      `SYS_READ`     |      `read`          |       `f_read`      |  `(int fd, size_t max_bytes, char* contents) -> void` |
|    1      |      `SYS_WRITE`    |      `write`         |       `f_write`     |  `(int fd, size_t max_bytes, const char* contents) -> void` |
|    2      |      `SYS_OPEN`     |      `open`          |       `f_open`      |  `(char* filename, int flags, int mode) -> int fd` |
|    3      |      `SYS_CLOSe`    |      `close`         |       `f_close`     |  `(int fd) -> void` |
|    60     |      `SYS_EXIT`     |      `exit`          |       `f_exit`      |  `(int code) -> void` |

## How to use it?
To use it, simply download the tarball of it's source (or the latest stable release) and extract it anywhere you like. Then simply create a `_.asm` file with the following contents:
```asm
%include "/path/to/bare/.bare/feature.asm"

; such as
%include "/path/to/bare/.bare/std.io.asm"
```
And include that file wherever you want! You'll get Bare working.

## Requirements
You simply need:
- Basic Assembly knowledge (you need to be familiar with Linux 64-bit NASM Assembly)
- Netwide Assembler (NASM)
- Any Linker (such as `ld`)
- A `x86_64` PC