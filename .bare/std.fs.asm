global f_open
global f_close
global open
global close

%macro close 1
  mov  rax, %1
  call f_close
%endmacro

; (int fd) -> void
f_close:
  ; Input: rax - The File Descriptor
  ; Output: None
  push r8
  mov  r8, rax
  mov  rax, 3
  mov  rdi, r8
  syscall
  mov  rax, r8
  pop  r8
  ret

O_NOCTTY_C: equ 0q400
O_ACCMODE_C: equ 0q003
O_NDELAY_C: equ O_NONBLOCK_C
O_ASYNC_C: equ 0q20000
O_FSYNC_C: equ O_SYNC_C
O_NONBLOCK_C: equ 0q4000
O_APPEND_C: equ 0q2000
O_RSYNC_C: equ O_SYNC_C
O_EXCL_C: equ 0q200
O_RDWR_C: equ 0q2
FFSYNC_C: equ O_FSYNC_C
O_SYNC_C: equ 0q4010000
O_CREAT_C: equ 0q100
O_RDONLY_C: equ  0q0
O_TRUNC_C: equ 0q1000
O_WRONLY_C: equ 0q1

S_FLAG_C: equ 0644

%macro open 3
  mov  rax, %1
  mov  rbx, S_FLAG_C
  mov  rcx, %2
  call f_open
  mov  %3, rdi
%endmacro

; (char *filename, int flags, int mode) -> (int fd)
f_open:
    ; Save the original values of rax, and rbx in temporary registers on the stack
    push r8
    push r9
    push r10
    mov  r8,  rax
    mov  r9,  rbx
    mov  r10, rcx
    
    ; Set up the syscall number for open (rax = 2)
    mov rdi,  r8
    mov rdx,  r9
    mov rsi,  r10
    mov rax,  2

    ; Perform the syscall (rax will contain the file descriptor)
    syscall

    ; Move the file descriptor from rax to rdi
    ; mov [rsp], rax
    mov rdi, rax

    ; Restore the original values of rax, rbx, and rcx from the stack
    mov rax, r8
    mov rbx, r9
    mov rcx, r10
    pop r8
    pop r9
    pop r10
    ; Return with the file descriptor in rdi
    ret
