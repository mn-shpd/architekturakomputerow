#Program, ktory odwraca stringa.
#Np. z Wojtek robi ketjoW i zapisuje w tej samej tablicy/wskazniku.

#include <stdio.h>

int main() //Jesli 64 bit konflikt, można zdowngradowac do 32bit z opcja gcc -m32
{
        char s[]="Abcd"; 
	int y;            
	asm volatile
	(	
	".intel_syntax noprefix;"
	"mov ebx, %1;" 
	"xor ecx, ecx;" 
	"petla:"
	"mov al, [ebx];" 
	"cmp al, 0;"  
	"je skok1;"   
	"inc ecx;"    
	"inc ebx;"   
	"jmp petla;" 
"skok1:"
	"mov %0, ecx;" 
	"sub ebx, ecx;"
	               
"skok2:"
	"cmp ecx, 1;"  
	"jng koniec;"  
	"dec ecx;"    
	"mov al, [ebx];"  
	"add ebx, ecx;"  
	"mov ah, [ebx];"	                
	"mov [ebx], al;"
	"sub ebx, ecx;" 
	"mov [ebx], ah;"
	"inc ebx;"      
	"dec ecx;"      
	"jmp skok2;"
"koniec:"
	".att_syntax prefix;"
	        :"=r"(y)
		:"r"(s)
		:"eax","ebx","ecx"
	);
	for (int i = 0; s[i]!='\0'; i++) {
	  printf("%c", s[i]);
	}
	printf("\ny=%d", y);
	printf("\n");
	return 0;
}
