global f_strlen
global f_stdout
global stdout
global read
global write
global f_read
global f_write

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
    mov  rax, %3
    mov  rbx, %2
    mov  rcx, %1
    call f_read
%endmacro

; (int fd, size_t count, char* mem) -> void
f_read:
    ; Input: rax - The File Descriptor
    ;        rbx - Number of bytes to read
    ;        rcx - The Memory to Store the contents
    push r8
    push r9
    mov  r8,  rax
    mov  r9,  rbx
    mov  rsi, rcx
    mov  rdx, r9
    mov  rdi, r8
    mov  rax, 0
    syscall
    mov  rax, r8
    mov  rbx, r9
    pop  r8
    pop  r9
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
    