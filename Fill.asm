;extern stuff coming in
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
;parameter: address of the array to Fill
mov r15, rdi                            ;r15 holds starting address of the array
sub rsp, 24
mov rdi, string_format
mov rsi, prompt_for_values
call printf
add rsp, 24
mov r14, 0                                ;r14 is the counter index for our loop
beginloop:
;sub rsp, 48
push qword 0
push qword 0

mov rax, 0
mov rdi, float_format
mov rsi, rsp
call scanf
cdqe
cmp rax, -1
je endloop
;pop rax
;cvtsi2sd xmm0, rax
movsd xmm0, [rsp]
movsd [r15 + 8*r14], xmm0
         ;insert xmm0 into 8*counterindex past the starting address of our array
inc r14

pop rax
pop rax
;add rsp, 48

jmp beginloop
endloop:
pop rax
pop rax
;add rsp, 48
mov rax, r14                                       ;prepare for return statement
;return: number of values Filled into the given array
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
