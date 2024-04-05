#include <stdio.h>
#include <string.h>
#include <math.h>
#include <time.h>
#include "full_study.h"

int main(int argc, char*argv[])
{
	char* ptr;
	char path_f[100] = "/home/antonybazir/Documents/Post-doc/metabolic_variety_c/results/";
	printf("main\n\n");
	ptr = strcat(path_f,"starv");
	full_study(path_f,"starv");
	
	ptr = strcpy(path_f,"/home/antonybazir/Documents/Post-doc/metabolic_variety_c/results/");
	ptr = strcat(path_f,"ref");
	full_study(path_f,"ref");
	

	return 0;
}
