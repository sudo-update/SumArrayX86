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
;  This program will create an array, and call Fill, Display, and Sum in order
;  to read the entries from the standard input device, reaffirm the array
;  through the standard output device, and finally calculate the sum of said
;  array.  The calculated sum will be output through the standard output device
;  and returned to the caller.  This program will also be submit (for credit)
;  for an assignment conducted during my graduate studies program.
;This file
;   File name: Control.asm
;   Language: X86 with Intel syntax
;   Max page width: 132 columns  (this file was not optimized for printing)
;   Assemble:
;     nasm -f elf64 -l Control.lis -o Control.o Control.asm
;   Link:
;     g++ -m64 -no-pie -o SumArray.out Main.o Sum.o Fill.o Display.o Control.o
;------------------------------------------------------------------------------;
;------------------------------------------------------------------------------;
extern printf
extern scanf
extern Fill
extern display_assembly_array
extern Sum
global Control
segment .data
welcome db "Welcome to SumArray.", 10, 0
confirm_before_display db "The numbers you entered are as follows:", 10, 0
goodbye db "The sum of these values is %6.8lf.", 10
        db "The control module will return the sum to the caller module.", 10, 0
string_format db "%s", 0
empty_array_error db "You have entered an empty array.", 10
                  db "The sum of an empty array is 0.00000000.", 10
                  db "The control module will return 0.0 to the caller module.", 10, 0
segment .bss
asssembly_array resq 100
segment .text
Control:
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
push qword 0
mov rdi, string_format                                                       ;%s
mov rsi, welcome                                           ;Welcome to SumArray.
call printf
pop rax
;------------------------------------------------------------------------------;
mov r13, 100                              ;r13 holds the max length of the array
mov rax, 0
mov rdi, asssembly_array   ;the first parameter is the starting address of array
mov rsi, r13                    ;second parameter is the max length of the array
call Fill
mov r15, rax                               ;r15 holds actual length of the array
;------------------------------------------------------------------------------;
mov r14, 0
cmp r15, r14                                        ;check if the array is empty
je empty_array                     ;if the array is empty, special case handling
;------------------------------------------------------------------------------;
push qword 0
push qword 0
mov rdi, string_format                                                       ;%s
mov rsi, confirm_before_display         ;The numbers you entered are as follows:
call printf
pop rax
pop rax
;------------------------------------------------------------------------------;
mov rax, 0
mov rdi, asssembly_array   ;the first parameter is the starting address of array
mov rsi, r15                 ;second parameter is the actual length of the array
call display_assembly_array
;------------------------------------------------------------------------------;
mov rax, 0
mov rdi, asssembly_array   ;the first parameter is the starting address of array
mov rsi, r15                 ;second parameter is the actual length of the array
call Sum
movsd xmm15, xmm0                                ;xmm15 holds the calculated sum
;------------------------------------------------------------------------------;
mov rax, 1
movsd xmm0, xmm15
mov rdi, goodbye                              ;The sum of these values is %6.8lf
                   ;The control module will return the sum to the caller module.
call printf
;------------------------------------------------------------------------------;
movsd xmm0, xmm15                                     ;pepare sum to be returned
jmp restore_registers
;------------------------------------------------------------------------------;
;                            Special Case Handling
;------------------------------------------------------------------------------;
empty_array:    ;The program will arrive here if the user entered an empty array
push qword 0
push qword 0
mov rdi, string_format                                                       ;%s
mov rsi, empty_array_error                     ;You have entered an empty array.
                                       ;The sum of an empty array is 0.00000000.
                       ;The control module will return 0.0 to the caller module.
call printf
pop rax
pop rax
mov r14, 0
cvtsi2sd xmm0, r14                                     ;prepare 0 to be returned
jmp restore_registers
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
