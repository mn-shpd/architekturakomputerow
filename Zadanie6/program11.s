.intel_syntax noprefix
#Fibonacci na stosie
	
	.global main
	.text

main:
	mov eax, [esp+8]
	mov eax, [eax+4]
	push eax
	call atoi
	add esp, 4

	call fib
	
	push eax
	mov ebx, offset messg
	push ebx
	call printf
	add esp, 8
	
	xor eax, eax
	ret

fib:
	cmp eax, 1  	#Warunek sprawdzajacy czy w rejestrze jest wart. <= 1.
	jbe koniec  	
	dec eax		#(N-1)
	push eax	
	call fib	#fib(N-1)
	pop ebx	        
	push eax     
	mov eax, ebx   
	dec eax	  	#(N-2)
	call fib  	#fib(N-2)
	pop ecx
	add eax, ecx    #Fib(N-1) + Fib(N-2)
	
koniec:
	ret
	
	.data

messg: .asciz "Wynik=%i\n"
