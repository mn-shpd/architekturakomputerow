#Program, ktory liczy ilosc wystapien ciagu 101 w zapisie binarnym liczby
#a) wariant bez nachodzenia na siebie ciagow 
#b) wariant z nachodzeniem 

#10101010101

#a) 3
#b) 5

#include <stdio.h>

int main() {
  int x;
  int y = 0;

  printf("Podaj liczbe x: ");
  scanf("%d", &x);
  
  asm volatile (
  ".intel_syntax noprefix;"
  "mov eax, %1;"  
  "xor ecx, ecx;" 
  "petla:"
  "and eax, eax;" 
  "jz koniec;"    
  "shl eax, 1;"   
  "jnc petla;"    
  "skok:"         
  "shl eax, 1;"   
  "jc skok;"      
  "shl eax, 1;"   
  "jnc petla;"  
  "inc ecx;"    
  "and eax, eax;" 
  "jnz skok;"     
  "koniec:"     
  "mov %0, ecx;" 
  ".att_syntax prefix;"
  :"=r"(y)    //nadajemy wartosc y   %0
  :"r"(x)  // pobieramy x z jakiegos rejestru pamieci  %1
  :"eax","ecx","ebx"
  );
  
  printf("y = %i\n", y);
  return 0;
}

//Zeby bylo bez nachodzenia wystarczy zmienic ostatni warunek skokowy na petla
