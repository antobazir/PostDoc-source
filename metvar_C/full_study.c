#include <stdio.h>
#include <errno.h>
#include <stdlib.h>
#include "metvar_f.h"

#include <unistd.h>        
#include <sys/stat.h>      

int full_study(char* folder, char* file)
{
	/*consumption values and vector*/
	float kS_ = 0.05;
	float kO_ = 0.4;
	char behavior[] = "ref";
	char fil[] = "Id";

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
		metvar_f(kS_,kO_,behavior,fil);
	}

	return EXIT_SUCCESS;

	
}
