%define LF      0Ah
%define stdout      1
%define sys_exit    60
%define sys_write   1


global _start

section .data

usagemsg: db "test {string}",LF,0

testmsg: db "wooop",0

section .text

_start:

pop rcx     ;this is argc
cmp rcx, 2      ;one argument
jne usage
pop rcx
pop rsi               ; argument now in rcx
test    rsi,rsi
jz usage

;mov rcx, testmsg    ;<-----uncomment this to print ok!

call print
jmp exit


usage:
mov rcx, usagemsg
call print
jmp exit


calclen:

push rdi
mov rdi, rcx
push rcx
xor rcx,rcx
not rcx
xor al,al
cld
repne scasb
not rcx
lea rdx, [rcx-1]
pop rcx
pop rdi
ret

print:

push rax
push rbx
push rdx

call calclen

mov rax, sys_write
mov rdi, stdout
syscall
pop rdx
pop rbx
pop rax
ret

exit:
mov rax, sys_exit
mov rbx, 0
syscall
