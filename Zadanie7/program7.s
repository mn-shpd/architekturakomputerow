#Wyrazenia regularne, tutaj szuka [bt][^abc] + c
#x = "abc  b acabxx xyc pqr"
#wynik = "bxx xyc"

	.intel_syntax noprefix
	.text 
	.global main
	
main:
	mov eax, [esp+8]
	mov eax, [eax+4]	#Pobranie adresu pierwszego argumentu (lancucha x)
	mov bl, [eax]		#Zapisanie pierwszego znaku w rejestrze BL.
start:
	cmp bl, 0		
	je koniec2		
	cmp bl, 98 	#b?	
	je skok1		
	cmp bl, 116	#t?	
	je skok1		
	inc eax			
	mov  bl, [eax]		
	jmp start		

skok0:	
	cmp bl, 99	#c?	
	jne skocz		
	inc eax			
	mov byte ptr[eax], 0	
	jmp koniec		
skok1:
	mov ecx, eax		
	inc eax			
	mov bl, [eax]		
skocz:
	cmp bl, 0		
	je koniec2		
	cmp bl, 97	#!a	
	je skok2		
	cmp bl, 98	#!b
	je start
	cmp bl, 99	#!c	
	je skok2
	inc eax			
	mov bl, [eax]		
	jmp skok0		

skok2:
	inc eax			
	mov bl, [eax]		
	jmp start
	
koniec:
	push ecx
	mov eax, offset format
	push eax
	call printf
	add esp, 8
	ret
	
koniec2:
	mov eax, offset komunikat
	push eax
	call printf
	add esp, 4
	ret
	
	.data
format:	 .asciz "Wynik: %s\n"
komunikat:	.asciz "Nie znaleziono szukanego wyrazenia.\n"
