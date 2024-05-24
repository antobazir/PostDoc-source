#include <stdio.h>
#include <string.h>
#include <math.h>
#include <time.h>
#include "full_study.h"

int main(int argc, char*argv[])
{
	if(GEOM==0)
	{
		float kS,kO;
		char suffix[20];
		int i;	
		char* ptr;
		char path_f[100] = "/home/antonybazir/Documents/Post-doc/metvar_c/results/";
		printf("main\n\n");
		kS = 1.0; kO = 15.0;

		ptr = strcat(path_f,"starv");
		full_study(path_f, kS, kO,2.0);
		
		ptr = strcpy(path_f,"/home/antonybazir/Documents/Post-doc/metvar_c/results/");
		ptr = strcat(path_f,"ref");
		full_study(path_f, kS, kO,1.0);

		ptr = strcpy(path_f,"/home/antonybazir/Documents/Post-doc/metvar_c/results/");
		ptr = strcat(path_f,"savy");
		full_study(path_f, kS, kO,3.0);

		/*ptr = strcpy(path_f,"/home/antonybazir/Documents/Post-doc/metvar_c/results/");
		ptr = strcat(path_f,"compens_prol");
		full_study(path_f);*/

		ptr = strcpy(path_f,"/home/antonybazir/Documents/Post-doc/metvar_c/results/");
		ptr = strcat(path_f,"OS_fragile");
		full_study(path_f, kS, kO,4.0);

		ptr = strcpy(path_f,"/home/antonybazir/Documents/Post-doc/metvar_c/results/");
		ptr = strcat(path_f,"OS_hypos_tol");
		full_study(path_f, kS, kO,5.0);

		ptr = strcpy(path_f,"/home/antonybazir/Documents/Post-doc/metvar_c/results/");
		ptr = strcat(path_f,"OS_hypox_tol");
		full_study(path_f, kS, kO,6.0);

		ptr = strcpy(path_f,"/home/antonybazir/Documents/Post-doc/metvar_c/results/");
		ptr = strcat(path_f,"OS_hypox_boost");
		full_study(path_f, kS, kO,7.0);

		for(i=1;10;i++)
		{

			ptr = strcpy(path_f,"/home/antonybazir/Documents/Post-doc/metvar_c/results/");
			sprintf(suffix, "starv%d", i);			
			ptr = strcat(path_f,suffix);
			full_study(path_f, kS, kO,2.0);
			
			ptr = strcpy(path_f,"/home/antonybazir/Documents/Post-doc/metvar_c/results/");
			sprintf(suffix, "ref%d", i);			
			ptr = strcat(path_f,suffix);
			full_study(path_f, kS, kO,1.0);

			ptr = strcpy(path_f,"/home/antonybazir/Documents/Post-doc/metvar_c/results/");
			sprintf(suffix, "savy%d", i);			
			ptr = strcat(path_f,suffix);
			full_study(path_f, kS, kO,3.0);

			/*ptr = strcpy(path_f,"/home/antonybazir/Documents/Post-doc/metvar_c/results/");
			ptr = strcat(path_f,"compens_prol");
			full_study(path_f);*/

			ptr = strcpy(path_f,"/home/antonybazir/Documents/Post-doc/metvar_c/results/");
			sprintf(suffix, "OS_fragile%d", i);			
			ptr = strcat(path_f,suffix);
			full_study(path_f, kS, kO,4.0);

			ptr = strcpy(path_f,"/home/antonybazir/Documents/Post-doc/metvar_c/results/");
			sprintf(suffix, "OS_hypos_tol%d", i);			
			ptr = strcat(path_f,suffix);
			full_study(path_f, kS, kO,5.0);

			ptr = strcpy(path_f,"/home/antonybazir/Documents/Post-doc/metvar_c/results/");
			sprintf(suffix, "OS_hypox_tol%d", i);			
			ptr = strcat(path_f,suffix);
			full_study(path_f, kS, kO,6.0);

			ptr = strcpy(path_f,"/home/antonybazir/Documents/Post-doc/metvar_c/results/");
			sprintf(suffix, "OS_hypox_boost%d", i);			
			ptr = strcat(path_f,suffix);
			full_study(path_f, kS, kO,7.0);


		}

		return 0;
	}


	if(GEOM==1)
	{
		float kS,kO;	
		char* ptr;
		char path_f[100] = "/home/antonybazir/Documents/Post-doc/metvar_c/results/";
		printf("main\n\n");
		kS = 1.0; kO = 15.0;

		ptr = strcat(path_f,"c_starv");
		full_study_chip(path_f, kS, kO,2.0);
		
		ptr = strcpy(path_f,"/home/antonybazir/Documents/Post-doc/metvar_c/results/");
		ptr = strcat(path_f,"c_ref");
		full_study_chip(path_f, kS, kO,1.0);

		ptr = strcpy(path_f,"/home/antonybazir/Documents/Post-doc/metvar_c/results/");
		ptr = strcat(path_f,"c_savy");
		full_study_chip(path_f, kS, kO,3.0);


		ptr = strcpy(path_f,"/home/antonybazir/Documents/Post-doc/metvar_c/results/");
		ptr = strcat(path_f,"c_OS_fragile");
		full_study_chip(path_f, kS, kO,4.0);

		ptr = strcpy(path_f,"/home/antonybazir/Documents/Post-doc/metvar_c/results/");
		ptr = strcat(path_f,"c_OS_hypos_tol");
		full_study_chip(path_f, kS, kO,5.0);

		ptr = strcpy(path_f,"/home/antonybazir/Documents/Post-doc/metvar_c/results/");
		ptr = strcat(path_f,"c_OS_hypox_tol");
		full_study_chip(path_f, kS, kO,6.0);

		ptr = strcpy(path_f,"/home/antonybazir/Documents/Post-doc/metvar_c/results/");
		ptr = strcat(path_f,"c_OS_hypox_boost");
		full_study_chip(path_f, kS, kO,7.0);		

	return 0;
	}
}
