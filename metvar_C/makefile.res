analysis : analysis.o 
	gcc -o analysis  -g analysis.o

analysis.o : analysis.c
	gcc -o analysis.o -g -c analysis.c -W -Wall -ansi -pedantic
