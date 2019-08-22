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

print_hex:
            call        putch

            mov         rax, 1          ; system call for write
            mov         rdi, 1          ; file handle 1 is stdout
            mov         rsi, spacing     ; address of string to output
            mov         rdx, 3          ; number of bytes
            syscall                     ; invoke operation

            mov         al, [buffer]
            mov         bl, 16
            div         bl

            mov         bl, [buffer]
            mov         [temp], bl
            ;mov         [private], al
            mov         [remainder], ah

            mov         ebx, table
            xlat
            mov         [buffer], al
            call        putch

            mov         al, [remainder]
            mov         ebx, table
            xlat
            mov         [buffer], al
            call        putch

            mov         byte [buffer], 'h'
            call        putch

            call        ln

            mov         bl, [temp]
            mov         [buffer], bl

            ret

_start:
            ;mov        ebx, table
            ;mov        al, 0
            ;xlat

            ;mov        byte [buffer], al
            ;call       putch
            ;call       ln
            mov         byte [buffer], 'A'
again:
            call        print_hex
            inc         byte [buffer]
            cmp         byte [buffer], 'Z'
            jle         again

            call exit

            section     .data
newline     db          10
spacing     db          ' - '
table       db          "0123456789ABCDEF"

            section     .bss
buffer      resb        1
remainder   resb        1
temp        resb        1
