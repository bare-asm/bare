; Bare v0.0.1-beta0 x86-64 [@@ Linux]
; Compile with: nasm -f elf64 main.asm
; Link with: ld main
; Run with: ./main

%include "bare.asm"
 
SECTION .data
    msg       db "What's your name? ", 0
    welcome   db "Hello!", 10, 0
    end       db "!", 10, 0
 
SECTION .text
global  _start

_start:
    exit      0
