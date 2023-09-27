; Bare v0.0.1-beta0 x86-64 [@@ Linux]
; Compile with: nasm -f elf64 main.asm
; Link with: ld main
; Run with: ./main

%include "func.asm"
 
SECTION .data
    msg       db "What's your name? ", 0
    welcome   db "Hello, "
    end       db "!", 10, 0
 
SECTION .text
global  _start

_start:
    stdout    msg
    ; stdin     rbx, rcx
    ; stdout    welcome
    call      f_stdin
    mov       byte [rdi + rsi], 10
    mov       byte [rdi + rsi], 10
    mov       byte [rdi + rsi], 0
    stdout    rdi
    ; stdout    end
    exit      0