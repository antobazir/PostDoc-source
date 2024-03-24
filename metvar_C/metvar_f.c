/* Implémentation 170324 test lecture/écriture et construction de structures*/
#include <stdio.h>
#include <errno.h>
#include <stdlib.h>
#include <math.h>
#include "matx.h"
#include "divide.h"
#include "structdef.h"
#include "perim_centroid.h"
#include "migrate.h"

#include <unistd.h>        
#include <sys/stat.h>  


	
int metvar_f(float kS, float kO ,char* behavior ,char* file)
{
	float kO_tissue = kO;
	float kS_tissue = kS;
	int sz = SZ;
	int row, col;

	Model Mod;
	Model Mod_r;
		
	
	int i=0,j=0,k=0;
	FILE *f;
	FILE *f2; 

	/*Initialisation des matrices*/
	for (i=0; i<SZ; i++)
	{
		for (j=0; j<SZ; j++)
		{
			Mod.M_Nutr.S[i][j] = 1.0;
			Mod.M_Nutr.O[i][j] = 1.0;
			Mod.M_Nutr.kS[i][j] = 0.0;
			Mod.M_Nutr.kO[i][j] = 0.0;
			Mod.M_Nutr.DSm[i][j] = 1.0;
			Mod.M_Nutr.DOm[i][j] = 1.0;
			Mod.M_Cell.Grid[i][j] = 0;
			Mod.M_Cell.state_mat[i][j] = 0;
		}
	}

	/*first cell is placed on the grid*/
	Mod.M_Cell.S_prol = 0.6;
	Mod.M_Cell.S_maint = 0.3;
	Mod.M_Cell.O_norm = 0.4;
	Mod.M_Cell.Grid[SZ/2-1][SZ/2-1] = 1;
	Mod.M_Cell.N_Cell = 1;
	Mod.M_Nutr.kS[SZ/2-1][SZ/2-1] = kS_tissue;
	Mod.M_Nutr.kO[SZ/2-1][SZ/2-1] = kO_tissue;
	Mod.M_Nutr.sz = SZ;

	Mod.M_Cell.state[1][1] = 0;
	Mod.M_Cell.state[1][2] = 1;
	Mod.M_Cell.state[1][3] = 0;
	Mod.M_Cell.state[1][4] = kS;
	Mod.M_Cell.state[1][5] = 0;
	Mod.M_Cell.state[1][6] = kO;
	Mod.M_Cell.state[1][7] = 0;
	Mod.M_Cell.state[1][8] = SZ/2-1;
	Mod.M_Cell.state[1][9] = SZ/2-1;
	Mod.M_Cell.state[1][10] = 0;

	/* find cell number one*/	
	find_int(sz,1,Mod.M_Cell.Grid,&row,&col);


	/*divide(&Mod,&row,&col);*/
	migrate_sphere(&Mod);
	 

	f = fopen("Id","a+");
	fwrite(&Mod,sizeof(Model),1,f);
	fclose(f);

	f2 = fopen("Id","r");
	fread(&Mod_r,sizeof(Model),1,f);	

	
	/*printing the save variable*/
	/*for (i=0; i<SZ; i++)
	{
		for (j=0; j<SZ; j++)
		{
			printf("%d ",Mod_r.M_Cell.Grid[i][j]);
		}
		printf("\n");
	}*/

	printf("*****************\n");
		
	for (i=0; i<SZ; i++)
	{
		for (j=0; j<SZ; j++)
		{
			printf("%d ",Mod.M_Cell.Grid[i][j]);
		}
		printf("\n");
	}

	printf("*****************\n");
	printf("N_Cell :  %d \n",Mod.M_Cell.N_Cell);

	
}
