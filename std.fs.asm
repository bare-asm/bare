global f_open
global f_close
global open
global close

O_RDWR:   equ 2
O_WRONLY: equ 1
O_RDONLY: equ 0

; (char *filename, int mode) -> (int fd)
f_open:
    ; Save the original values of rax, and rbx in temporary registers on the stack
    push r8
    push r9
    mov  r8, rax
    mov  r9, rbx
    
    ; Set up the syscall number for open (rax = 2)
    mov rdi, r8
    mov rdx, r9
    mov rax, 2

    ; Perform the syscall (rax will contain the file descriptor)
    syscall

    ; Move the file descriptor from rax to rdi
    ; mov [rsp], rax
    mov rdi, rax

    ; Restore the original values of rax, rbx, and rcx from the stack
    pop r8
    pop r9
    ; Return with the file descriptor in rdi
    ret