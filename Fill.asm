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
;  This program will take the starting address of an array as its first
;  parameter, the maximum size of said array as its second parameter, and then
;  will fill the array with values read from the standard input device.  It will
;  return the number of elements that were filled into the array.  This program
;  will also be submit (for credit) for an assignment conducted during my
;  graduate studies program.
;This file
;   File name: Fill.asm
;   Language: X86 with Intel syntax
;   Max page width: 132 columns  (this file was not optimized for printing)
;   Assemble:
;     nasm -f elf64 -l Fill.lis -o Fill.o Fill.asm
;   Link:
;     g++ -m64 -no-pie -o SumArray.out Main.o Sum.o Fill.o Display.o Control.o
;------------------------------------------------------------------------------;
;------------------------------------------------------------------------------;
extern scanf
extern printf

global Fill
segment .data
prompt_for_values db "Please enter the values of the array as floating point", 10
                  db "numbers seperated by whitespace.", 10
                  db "When finished, press <Enter> followed by <Ctrl-D>.", 10, 0
float_format db "%lf", 0
string_format db "%s", 0
segment .bss
segment .text
Fill:
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
;parameters: address of the array to Fill, maximum length of array to fill
mov r15, rdi                            ;r15 holds starting address of the array
mov r13, rsi                              ;r13 holds the max length of the array
sub rsp, 24
mov rdi, string_format                                                       ;%s
mov rsi, prompt_for_values;Please enter the values of the array as floating point
                                               ;numbers seperated by whitespace.
                             ;When finished, press <Enter> followed by <Ctrl-D>.
call printf
add rsp, 24
mov r14, 0                                ;r14 is the counter index for our loop
;------------------------------------------------------------------------------;
beginloop:
push qword 0
push qword 0          ;get on the boundary and make room for value to be scanned
mov rax, 0
mov rdi, float_format                                                       ;%lf
mov rsi, rsp
call scanf
cdqe
cmp rax, -1
je endloop                                ;if Ctrl-D was input, jump out of loop
movsd xmm0, [rsp]                    ;store (scanned) value from stack into xmm0
movsd [r15 + 8*r14], xmm0
         ;insert xmm0 into 8*counterindex past the starting address of our array
inc r14                                             ;increment our counter index
cmp r14, r13             ;compare our counter index to the max size of the array
je endloop          ;if we have filled every slot in the array, jump out of loop
pop rax
pop rax
jmp beginloop
;------------------------------------------------------------------------------;
endloop:
pop rax
pop rax
mov rax, r14                                       ;prepare for return statement
;return: number of values Filled into the given array (counter index)
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
