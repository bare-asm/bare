global f_exit
global exit

%macro exit 1
    mov     rax, %1
    call    f_exit
%endmacro

f_exit:
    ; Input: rax - Integer representing the Error Code (Exit Status)
    ; Output: None
    push    rax         ; Reserve RAX
    mov     rdi, rax
    pop     rax
    mov     rax, 60     ; InvokeCall(SYS_EXIT)
    syscall
    ret
