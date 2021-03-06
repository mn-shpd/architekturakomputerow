#fibonacci na rejestrach

.intel_syntax noprefix
	
	.global main
	.text

main:
	mov eax, [esp+8]
	mov eax, [eax+4]
	push eax
	call atoi
	add esp, 4

	push eax
	call fib
	add esp, 4
	
	push eax
	mov ebx, offset messg
	push ebx
	call printf
	add esp, 8
	
	xor eax, eax
	ret

fib:
	mov eax, [esp+4]
	cmp eax, 1
	jg skok
	ret
	
skok:
	dec eax    #(N-1).
	push eax   
	call fib   #fib(N-1).
	pop ebx    
	push eax   
	dec ebx    #(N-2).
	push ebx   #Wrzucenie argumentu na stos. 
	call fib   #fib(N-2)
	add esp,4  
	pop ebx    
	add eax,ebx  
	ret

	.data

messg: .asciz "Wynik=%i\n"
n: .int 10
