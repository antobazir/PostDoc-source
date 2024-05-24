#include <stdio.h>
#include <errno.h>
#include <stdlib.h>
#include "metvar_f.h"
#include <math.h>

#include <unistd.h>        
#include <sys/stat.h>      

int full_study(char* folder, float kS, float kO, float behav_code)
{
	/*consumption values and vector*/
	/*float kS_ = 1.0;
	float kO_ = 15.0;*/
	/*float kS_ = 1.5;
	float kO_ = 12.0;*/

	printf("full_study\n\n");

	/*part that creates the folder*/
	if ( mkdir(folder, 0755 ) != 0 ) 
	{
		fprintf( stderr, "Impossible de créer le dossier \n" );
		switch( errno ) 
		{
	    		case EACCES:
			fprintf( stderr, "\tTu n'as pas les droits\n" );
			break;
	    		case EEXIST:
			fprintf( stderr, "\tLe dossier existe déjà.\n" );
			break;
	    		default:
			fprintf( stderr, "\tJe ne t'en dirais pas plus ;-)" );
		}
		/*exit( EXIT_FAILURE );*/
	}
    
	if ( chdir(folder) != 0 ) 
	{
		fprintf( stderr, "Impossible de se placer dans le dossier.\n");
		exit( EXIT_FAILURE );
	}
	/*printf("%s \n",file);*/

	if (fopen("Id","r+") == 0 )/*En gros si le fichier n'existe pas, metvar*/ 
	{
		metvar_f(kS,kO,"Id",behav_code);
	}

	if (fopen("Gl","r+") == 0 )/*En gros si le fichier n'existe pas, metvar*/ 
	{
		metvar_f(kS*sqrt(5.0),kO/sqrt(5.0),"Gl",behav_code);
	}

	if (fopen("Ox","r+") == 0 )/*En gros si le fichier n'existe pas, metvar*/ 
	{
		metvar_f(kS/sqrt(5.0),kO*sqrt(5.0),"Ox",behav_code);
	}

	return EXIT_SUCCESS;

	
}


int full_study_chip(char* folder, float kS, float kO, float behav_code)
{
	/*consumption values and vector*/
	/*float kS_ = 1.0;
	float kO_ = 15.0;*/
	/*float kS_ = 1.5;
	float kO_ = 12.0;*/

	printf("full_study_chip\n\n");

	/*part that creates the folder*/
	if ( mkdir(folder, 0755 ) != 0 ) 
	{
		fprintf( stderr, "Impossible de créer le dossier \n" );
		switch( errno ) 
		{
	    		case EACCES:
			fprintf( stderr, "\tTu n'as pas les droits\n" );
			break;
	    		case EEXIST:
			fprintf( stderr, "\tLe dossier existe déjà.\n" );
			break;
	    		default:
			fprintf( stderr, "\tJe ne t'en dirais pas plus ;-)" );
		}
		/*exit( EXIT_FAILURE );*/
	}
    
	if ( chdir(folder) != 0 ) 
	{
		fprintf( stderr, "Impossible de se placer dans le dossier.\n");
		exit( EXIT_FAILURE );
	}
	/*printf("%s \n",file);*/

	if (fopen("Id","r+") == 0 )/*En gros si le fichier n'existe pas, metvar*/ 
	{
		metvar_c(kS,kO,"Id",behav_code);
	}

	if (fopen("Gl","r+") == 0 )/*En gros si le fichier n'existe pas, metvar*/ 
	{
		metvar_c(kS*sqrt(5.0),kO/sqrt(5.0),"Gl",behav_code);
	}

	if (fopen("Ox","r+") == 0 )/*En gros si le fichier n'existe pas, metvar*/ 
	{
		metvar_c(kS/sqrt(5.0),kO*sqrt(5.0),"Ox",behav_code);
	}

	return EXIT_SUCCESS;

	
}
