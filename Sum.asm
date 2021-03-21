;extern stuff coming in
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
mov rax, 0
cvtsi2sd xmm15, rax                               ;prepare xmm15 for holding sum
beginloop:
movsd xmm14, [r15 + 8*r13]
addsd xmm15, xmm14
;take the value located at (8 * counter index past the starting address of)
;our array and add it to our sum
cmp r13, r14
je endloop
inc r13
jmp beginloop
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
