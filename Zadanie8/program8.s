#Liczy sinus (liczby zmiennoprzecinkowe)

	.intel_syntax noprefix
	.text
	.global main

main:
	finit   #przygotowuje rejestr liczb zmiennoprzecinkowych
	mov eax, [esp+8]
	mov eax, [eax+4]
	push eax
	call atof
	add esp, 4
	
	fst qword ptr x  #Zapisuje w zmiennej x podany argument.
	fst qword ptr y  #Zapisuje w zmiennej y podany argument.
	fstp qword ptr a  #Sciaga ze stosu wartosc i zapisuje w zmiennej a.
	
petla:	fld qword ptr dwa #2 -> stos
	fld qword ptr n   #n -> stos
	faddp		  #Na stosie wynik dodawania

	fld1               #1 -> stos
	fld qword ptr n  #Wrzuca na stos wartosc n.
	faddp              
	                   #st1 = wynik pierwszego dodawania
	                   #st0 = wynik drugiego dodawania
	fmulp              #Mnozy (n+2)*(n+1), na stosie wynik
	fld qword ptr a    #a -> stos
	fld qword ptr x	   #x -> stos
	fld qword ptr x	   #x -> stos
	fmulp              #na stosie kolejno: (n+2)*(n+1), a, (x*x)
	fmulp		   #na stosie kolejno: (n+2)*(n+1), a*(x*x)
	fdivrp	           #Wykonuje dzielenie odwrotne tzn. st0/st1 = a*(x*x) / (n+2)*(n+1) i zdejmuje ze stosu st0.
			   #Na stosie zostaje wynik.
	fchs               #Dokonuje zmiany znaku st0.
	fst qword ptr a    #Zapisuje w zmiennej a wynik dzielenia o zmienionym znaku.
	fld qword ptr y    #Wrzuca na stos wartosc ze zmiennej y.
	faddp              #Dodaje do (-1)* a*(x*x)/(n+2)*(n+1) wartosc y i sciaga ze stosu wartosc y.
	fstp qword ptr y   #Zapisuje w zmiennej y wynik dodawania a+y i sciaga ten wynik ze stosu.
	fld qword ptr n    #Wrzuca na stos wartosc ze zmiennej n.
	fld qword ptr dwa #Wrzuca na stos liczbe 2.
	faddp               #Wykonuje dzialanie n+2
	fstp qword ptr n   #Sciaga ze stosu wynik dzialania i przypisuje do zmiennej n.
	fld qword ptr a    #Wrzuca na stos wartosc ze zmiennej a.
	fabs		  #Zastepuje st0 jego wartoscia bezwzgledna, czyli |a|.
	fld qword ptr eps #Wrzuca na stos wartosc ze zmiennej eps.
	fcompp           #Porownuje st0 z st1 i sciaga ze stosu obydwie wartosci
	fstsw ax         #Kopiuje rejestr flag z koprocesora do procesora
	sahf		 #sahf
	jb petla

koniec:	fld qword ptr y
	sub esp, 8 
	fstp qword ptr [esp]  
	mov eax, offset wynik
	push eax
	call printf
	add esp, 12
	ret
	
	.data
x:	.double 1.0
wynik:	.asciz "%f\n"
y:	.double 1.0
a:	.double 1.0
n:	.double 1.0
dwa:	.double 2.0
eps:	.double 0.00001
