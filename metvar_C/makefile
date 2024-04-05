metvar: full_study.o main.o metvar_f.o matx.o divide.o perim_centroid.o migrate.o diff_metvar.o behav.o structdef.h
	gcc -O -o metvar -g full_study.o main.o metvar_f.o matx.o divide.o perim_centroid.o migrate.o diff_metvar.o behav.o

behav.o : behav.c
	gcc -O -o behav.o -g -c behav.c -W -Wall -ansi -pedantic 

diff_metvar.o : diff_metvar.c 
	gcc -O -o  diff_metvar.o -g -c diff_metvar.c -W -Wall -ansi -pedantic

migrate.o : migrate.c perim_centroid.h
	gcc -O -o  migrate.o -g -c migrate.c -W -Wall -ansi -pedantic

perim_centroid.o : perim_centroid.c
	gcc -O -o perim_centroid.o -g -c perim_centroid.c -W -Wall -ansi -pedantic

divide.o : divide.c 
	gcc -O -o divide.o -g -c divide.c -W -Wall -ansi -pedantic

matx.o : matx.c 
	gcc -O -o  matx.o -g -c matx.c -W -Wall -ansi -pedantic

metvar_f.o: metvar_f.c matx.h migrate.h perim_centroid.h diff_metvar.h behav.h
	gcc -O -o metvar_f.o -g -c metvar_f.c -W -Wall -ansi -pedantic

full_study.o: full_study.c metvar_f.h
	gcc -O -o  full_study.o -g -c full_study.c -W -Wall -ansi -pedantic

main.o: main.c full_study.h metvar_f.h matx.h divide.h perim_centroid.h migrate.h diff_metvar.h structdef.h
	gcc -O -o  main.o -g -c main.c -W -Wall -ansi -pedantic


