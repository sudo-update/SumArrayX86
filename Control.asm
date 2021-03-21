;extern stuff coming in
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
mov rdi, string_format
mov rsi, welcome
call printf
pop rax

mov rax, 0
mov rdi, asssembly_array
call Fill
mov r15, rax                                      ;r15 holds length of the array

push qword 0
push qword 0
mov rdi, string_format
mov rsi, confirm_before_display
call printf
pop rax
pop rax
;should special case for no elements here
mov rax, 0
mov rdi, asssembly_array
mov rsi, r15
call display_assembly_array
;works until here
mov rax, 0
mov rdi, asssembly_array
mov rsi, r15
call Sum
movsd xmm15, xmm0


mov rax, 1
movsd xmm0, xmm15
mov rdi, goodbye
call printf

movsd xmm0, xmm15
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
