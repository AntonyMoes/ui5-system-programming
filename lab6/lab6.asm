global  _start

section .text

putch:
            mov         rax, 1          ; system call for write
            mov         rdi, 1          ; file handle 1 is stdout
            mov         rsi, buffer     ; address of string to output
            mov         rdx, 1          ; number of bytes
            syscall                     ; invoke operation
            ret

ln:
            mov         rax, 1          ; system call for write
            mov         rdi, 1          ; file handle 1 is stdout
            mov         rsi, newline     ; address of string to output
            mov         rdx, 1          ; number of bytes
            syscall                     ; invoke operation
            ret


exit:
            mov         rax, 60         ; system call for exit
            xor         rdi, rdi        ; exit code 0
            syscall

printarg:
            ;mov         byte [counter], 0
            pop         qword [wrd]
            mov         byte [counter], 0

printarg_l: xor         rax, rax
            mov         rax, [wrd]
            xor         rbx, rbx
            mov         dl, [counter]
            mov         dl, [rax + rbx]
            mov         [buffer], dl
            call        putch


            cmp         byte [buffer], 0
            jne         printarg_l

            call        ln
            ret



_start:
            push        rbp
            mov         rbp, rsp

            mov         rax, qword [rbp + 8]    ;points to argc
            mov         rbx, qword [rbp + 12]   ;points to arg
            mov         rcx, 0

lop:        push        rbx
            push        rax
            push        rcx

            ;call printf
            push        qword [rbx]
            ;push        msg
            call        printarg
            add         rsp, 8


            pop         rcx
            pop         rax
            pop         rbx

            inc         rcx     ;inc counter
            add         rbx, 4  ;move to the next arg

            cmp         rcx, rax
            jne         lop

            mov         rsp, rbp
            pop         rbp
            ;ret

            call        exit

            section     .data
newline     db          10

            section     .bss
buffer      resb        1
wrd         resq        1
counter     resb        1
