            global      _start

            section     .text

putch:
            ;pop         buffer
            mov         rax, 1          ; system call for write
            mov         rdi, 1          ; file handle 1 is stdout
            mov         rsi, buffer     ; address of string to output
            mov         rdx, 1          ; number of bytes
            syscall                     ; invoke operation
            ret

ln:
            ;pop         buffer
            mov         rax, 1          ; system call for write
            mov         rdi, 1          ; file handle 1 is stdout
            mov         rsi, newline    ; address of string to output
            mov         rdx, 1          ; number of bytes
            syscall                     ; invoke operation
            ret

getch:
            mov         rax, 0          ; system call for read
            mov         rdi, 0          ; file handle 0 is stdin
            mov         rsi, buffer     ; address of string to output
            mov         rdx, 1          ; number of bytes
            syscall                     ; invoke operation
            ret

exit:
            mov         rax, 60         ; system call for exit
            xor         rdi, rdi        ; exit code 0
            syscall

_start:
            mov         byte [buffer], "A"
            call        putch
            call        ln
            mov         byte [buffer], "B"
            call        putch
            call        ln
            mov         byte [buffer], "C"
            call        putch
            call        ln

            call        getch
            mov         al, [buffer]
            mov         [finish], al
            add         byte [finish], 3

again:      inc         byte [buffer]
            call        putch
            call        ln
            mov         al, [finish]
            cmp         [buffer], al
            jl          again

            call        exit


            section     .data
newline:    db          10

            section     .bss
buffer:     resb        1
finish      resb        1
