#!/bin/bash
cd $1
nasm -f elf "$1.asm" -o "$1.o"
ld -m elf_i386 "$1.o" -o "$1.tmp"
rm "$1.o"
./"$1.tmp"
rm "$1.tmp"
