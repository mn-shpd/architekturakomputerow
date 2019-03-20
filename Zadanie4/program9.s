#Pobiera scanfem liczbe, mnozy przez 2 i wypisuje wynik.

	.intel_syntax noprefix
	.global main
	.text

main:	mov eax, offset x  
	push eax	  
	mov eax, offset format 
	push eax	 
	call scanf	
	add esp, 8	
	mov eax, [x]	
	add eax, eax	
	push eax	
	mov eax, offset result 
	push eax	
	call printf	
	add esp, 8	
	xor eax, eax	
	ret
	
	.data
x:	.int 0
format:	.asciz "%d"
result:	.asciz "Wynik = %d\n"

	# esp zawsze wskazuje na ostatni element na stosie
