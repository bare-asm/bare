;;;; Bare v0.0.1-beta0 x86-64 [@@ Linux]
;;;; Compile with: nasm -f elf64 main.asm
;;;; Link with: ld main
;;;; Run with: ./main

%include "bare.asm"
 
SECTION .data
    msg       db "What's your name? ", 0
    _         db "What's the file? ", 0
    welcome   db "Hello ", 0
    end       db "!", 10, 0
    ; file      db "std.io.asm", 0h 
    err       db "Error", 0
    SIZE      equ  64 * 1024 * 1024
    __        db "Contents: ", 10, 0

SECTION .bss
    file:       resb SIZE
    f:          resb SIZE

SECTION .text
global  _start

_start:
    stdout    _
    read      file, SIZE, 0
    mov       rax, file
    call      f_strlen
    mov       byte [file + rdi - 1], 0
    stdout    file
    open           file, O_RDWR_C, rdi
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
    ;    read      rsp, SIZE, rdi
    ; stdout    msg
    ; mov       rax, 0
    ; mov       rsi, f
    ; mov       rdx, SIZE
    ; mov       rdi, 0
    ; syscall
    ; stdout    welcome
    read      f, SIZE, rdi
    close     rdi
    mov       rax, f
    call      f_strlen
    mov       byte [f + rdi], 10
    stdout    f
    ; stdout    end
    exit      0