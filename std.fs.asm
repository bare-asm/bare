global f_open
global f_close
global open
global close

O_RW    : equ 1101o
O_WRONLY: equ 0001o
O_CREAT : equ 0100o
O_TRUNC : equ 1000o

S_FLAGS:  equ 644o

; (char *filename, int flags, int mode) -> (int fd)
f_open:
  push r8 , rax
  push r9 , rbx
  push r10, rcx
  mov  rdi, r8
  mov  rsi, r9
  mov  rdx, r10
  mov  rax, 2
  syscall
  mov  rax, r8
  mov  rbx, r9
  mov  rcx, r10
  pop  r8
  pop  r9
  pop  r8
  ret
