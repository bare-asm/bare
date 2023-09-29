ENDL_C     db 10, 0
NULL_C     db 0

global f_strlen
global f_stdout
global print
global println
global stdout
global ENDL_C
global NULL_C
global stdin
global f_stdin

%macro write 2
    mov  rax, %1
    mov  rbx, %2
    call f_write
%endmacro

f_write:
  ; Input: rax - Integer Representing the File Descriptor
  ;        rbx - String to write
  ; Output: None
  
    push    rcx         ; Reserve RAX
    mov     rcx, rax
    call    f_strlen    ; Calculate String Length
    mov     rdx, rdi
    mov     rsi, rcx
    pop     rcx
    mov     rdi, rbx    ; FileDescriptor
    mov     rax, 1      ; InvokeCall(SYS_WRITE)
    syscall
    ret

%macro read 3
    mov  rdi, 256
    mov  rsi, 256
    mov  rax, %3
    call f_read
    mov  %1, rdi
    mov  %2, rsi
%endmacro

f_read:
    ; Input: rax - The File Descriptor
    ; Output: rdi - The Input String
    ;         rsi - The String Length
    mov  r9, rdi
    mov rdi, rax
    mov rax, 0
    syscall
    mov rdi, rsi
    mov rsi, rdx
    ret

%macro stdin 2
    mov  rdi, 256
    mov  rsi, 256
    call f_stdin
    mov  %1, rdi
    mov  %2, rsi
%endmacro

f_stdin:
    ; Input: None
    ; Output: rdi - The Input String
    ;         rsi - The String Length
    push r8
    push r9
    mov  r8, rax
    mov  r9, rdi
    mov rdi, 0
    mov rax, 0
    syscall
    mov rdi, rsi
    mov rsi, rdx
    mov rax, r8
    pop r8
    pop r9
    ret

%macro stdout 1
    mov     rax, %1
    call    f_stdout
%endmacro

f_strlen:
    ; Input: rax - Address of the null-terminated string
    ; Output: rdi - Length of the string (excluding the null terminator.
    push    r8
    mov     r8, rax
    
nextchar:
    cmp     byte [rax], 0
    jz      finished
    inc     rax
    jmp     nextchar

finished:
    sub     rax, r8
    pop     r8
    mov     rdi, rax
    ret

f_stdout:
    ; Input: rax - Address of the null-terminated String
    ; Output: None
    push    rcx         ; Reserve RAX
    mov     rcx, rax
    mov     rax, rcx
    call    f_strlen      ; Calculate String Length
    mov     rdx, rdi
    mov     rsi, rcx
    pop     rcx
    mov     rdi, 1      ; FileDescriptor(STDOUT)
    mov     rax, 1      ; InvokeCall(SYS_WRITE)
    syscall
    ret
