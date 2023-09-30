;;;; Bare v0.0.1-beta0 x86-64 [@@ Linux]
;;;; Compile with: nasm -f elf64 main.asm
;;;; Link with: ld main
;;;; Run with: ./main

%include "bare.asm"
 
SECTION .data
    msg       db "What's your name? ", 0
    welcome   db "Hello ", 0
    end       db "!", 10, 0
    file      db "std.io.asm", 0h
    err       db "Error", 0
    SIZE      equ  64 * 1024 * 1024 * 1024

SECTION .bss
    f:          resb SIZE

SECTION .text
global  _start

_start:
    mov       rax, file
    ;;;; mov       rbx, S_FLAGS
    mov       rbx, O_RDWR
    call      f_open
    ;;;; read      [f], SIZE, 0
    ;;;; mov       [rbx + rax], 0
    ;;;; mov       f, rax
    ;;;; cmp       rax, "a"
    ;;;; jne       _err
    ;;;; mov       rax, 1
    ;;;; mov       rdi, 1
    ;;;; mov       rsi, byte [f]
    ;;;; mov       rdx, 16
    ;;;; syscall
    ;;;; read      rsp, SIZE, rdi
    stdout    msg
    mov       rax, 0
    mov       rsi, $f
    mov       rdx, SIZE
    mov       rdi, 0
    syscall
    stdout    welcome
    stdout    f
    stdout    end
    exit      0