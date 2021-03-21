;******************************************************************************;
; Program name: "SumArray".  This program creates an array, then reads the
; values of the array through the standard innput device.  It then displays the
; entries of the array, and finally calculates the sum of the entries of said
; array.  The calculated sum is ouptut to the standard output device and then
; returned.
; Copyright (C) 2021 Sean Javiya.
;
; This file is part of the software ArraySum
; This program is free software: you can redistribute it and/or modify
; it under the terms of the GNU General Public License as published by
; the Free Software Foundation, either version 3 of the License, or
; (at your option) any later version.
;
; This program is distributed in the hope that it will be useful,
; but WITHOUT ANY WARRANTY; without even the implied warranty of
; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
; GNU General Public License for more details.
;
; You should have received a copy of the GNU General Public License
; along with this program.  If not, see <https://www.gnu.org/licenses/>.
; *****************************************************************************
;
;
;------------------------------------------------------------------------------;
;------------------------------------------------------------------------------;
;Author information
;  Author name: Sean Javiya
;  Author email: seanjaviya@csu.fullerton.edu
;Program information
;  Program name: ArraySum
;  Programming languages: One driver module in C, three modules in X86, one
;                         library module in C++, and one bash file
;  Date program began: 2021-Mar-16
;  Date of last update: 2021-Mar-21
;  Date of reorganization of comments: 2021-Mar-21
;  Files in this program: Display.cpp, Fill.asm, Main.c, Control.asm, Sum.asm
;                         run.sh
;  Status: Finished.
;  The program was tested extensively with no errors in (Tuffix) Ubuntu 20.04
;Purpose
;  This program takes an array and its length as the parameters.  This Program
;  will calculate and return the sum of the entries of said array.  This program
;  will also be submit (for credit) for an assignment conducted during my
;  graduate studies program.
;This file
;   File name: Sum.asm
;   Language: X86 with Intel syntax
;   Max page width: 132 columns  (this file was not optimized for printing)
;   Assemble:
;     nasm -f elf64 -l Sum.lis -o Sum.o Sum.asm
;   Link:
;     g++ -m64 -no-pie -o SumArray.out Main.o Sum.o Fill.o Display.o Control.o
;------------------------------------------------------------------------------;
;------------------------------------------------------------------------------;
global Sum
segment .data
segment .bss
segment .text
Sum:
;------------------------------------------------------------------------------;
;------------------------------------------------------------------------------;
;preserve the registers onto the stack
push rbp
mov  rbp,rsp
push rdi
push rsi
push rdx
push rcx
push r8
push r9
push r10
push r11
push r12
push r13
push r14
push r15
push rbx
pushf
;------------------------------------------------------------------------------;
;------------------------------------------------------------------------------;
;                                                                     BEGIN CODE
;------------------------------------------------------------------------------;
;------------------------------------------------------------------------------;
;parameters: an array of doubles and the length of said array (as a long)
                                                        ;preserve the parameters
mov r15, rdi                            ;r15 holds starting address of the array
mov r14, rsi                                 ;r14 holds the length of said array
mov r13, 0                                ;r13 is the counter index for the loop
mov rax, 0                                                  ;initialize sum to 0
cvtsi2sd xmm15, rax                               ;prepare xmm15 for holding sum
;------------------------------------------------------------------------------;
beginloop:
movsd xmm14, [r15 + 8*r13]
addsd xmm15, xmm14
;take the value located at (8 * counter index past the starting address of)
;our array and add it to our sum
inc r13                                             ;increment our counter index
cmp r13, r14                       ;compare counter index to length of the array
je endloop                  ;if we have summed the whole array, jump out of loop
jmp beginloop                                                     ;else continue
;------------------------------------------------------------------------------;
endloop:
movsd xmm0, xmm15                                  ;prepare for return statement
;return: the sum of all the elements in the given array
;------------------------------------------------------------------------------;
;------------------------------------------------------------------------------;
;                                                                       END CODE
;------------------------------------------------------------------------------;
;------------------------------------------------------------------------------;
restore_registers:
;restore the registers from the stack
popf
pop rbx
pop r15
pop r14
pop r13
pop r12
pop r11
pop r10
pop r9
pop r8
pop rcx
pop rdx
pop rsi
pop rdi
pop rbp
;------------------------------------------------------------------------------;
;return statement
ret
