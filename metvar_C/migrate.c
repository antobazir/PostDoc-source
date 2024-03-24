/* file containing the migration functions*/
#include <stdio.h>
#include <errno.h>
#include <stdlib.h>
#include <math.h>
#include <time.h>
#include "matx.h"
#include "divide.h"
#include "structdef.h"
#include "perim_centroid.h"

#include <unistd.h>        
#include <sys/stat.h>  

int migrate_sphere(Model *mod)
{
	int i,j,sz,k,n,m;
	sz = (*mod).M_Nutr.sz;
	int row_perim[sz];  
	int col_perim[sz];
	int row_shift[8];  
	int col_shift[8];
	int row_ctrd;
	int col_ctrd;
	int lgth_perim;
	int rad_sq[sz];
	int rad_sq_n[8];
	int min_rad;
	int n_closer;
	int closer[5];
	int chosen_site;


	row_shift[0] = -1; col_shift[0] = -1;
	row_shift[1] = -1; col_shift[1] = 0;
	row_shift[2] = -1; col_shift[2] = 1;
	row_shift[3] = 0; col_shift[3] = -1;
	row_shift[4] = 0; col_shift[4] = 1;
	row_shift[5] = 1; col_shift[5] = -1;
	row_shift[6] = 1; col_shift[6] = 0;
	row_shift[7] = 1; col_shift[7] = 1;

	(*mod).M_Cell.Grid[4][5]=2;
	(*mod).M_Cell.Grid[4][3]=3;
	(*mod).M_Cell.Grid[3][5]=4;
	(*mod).M_Cell.Grid[4][6]=9;
	(*mod).M_Cell.Grid[5][4]=8;
	(*mod).M_Cell.Grid[3][4]=7;
	(*mod).M_Cell.Grid[3][3]=6;
	(*mod).M_Cell.Grid[5][3]=5;
	(*mod).M_Cell.Grid[4][7]=10;
	(*mod).M_Cell.N_Cell=10;

	(*mod).M_Cell.LD[4][5]=1;
	(*mod).M_Cell.LD[4][3]=1;
	(*mod).M_Cell.LD[3][5]=1;
	(*mod).M_Cell.LD[5][5]=1;
	(*mod).M_Cell.LD[5][4]=1;
	(*mod).M_Cell.LD[3][4]=1;
	(*mod).M_Cell.LD[3][3]=1;
	(*mod).M_Cell.LD[5][3]=1;
	(*mod).M_Cell.LD[5][2]=1;

	sz = (*mod).M_Nutr.sz;
	min_rad = sz;

		/* initialise le générateur de nombres*/
	srand(time(0));

	printf("*************************\n");
	centroid(mod,&row_ctrd,&col_ctrd);
	/*printf("centroid: \n");
	printf("row : %d | col: %d \n",row_ctrd,col_ctrd);

	printf("before perim sz: %d \n",(*mod).M_Nutr.sz);*/


	/*lgth_perim =*/ 
	perim(mod,sz,&lgth_perim,row_perim,col_perim);

	for (i=0; i<sz; i++)
	{
		for (j=0; j<SZ; j++)
		{
			printf("%d ",(*mod).M_Cell.Grid[i][j]);
		}
		printf("\n");
	}

	for(k=0;k<lgth_perim;k++)
	{
		/*printf("k: %d | lgth_perim: %d \n",k,lgth_perim);*/
		/*printf("lgth_perim: %d \n",lgth_perim);
		printf("row : %d | col: %d \n",row_perim[k],col_perim[k]);*/
		/*printf("dx : %lf | dy : %lf \n",dx*dx,dy*dy);*/
		rad_sq[k] = ((row_perim[k]-row_ctrd)*(row_perim[k]-row_ctrd))
			 + ((col_perim[k]-col_ctrd)*(col_perim[k]-col_ctrd));
		printf("rad_sq[%d] : %d | Grid[%d][%d]: %d \n",k,rad_sq[k],row_perim[k],col_perim[k],(*mod).M_Cell.Grid[row_perim[k]][col_perim[k]]);
		/*printf("\n");*/
		
		for(n=0;n<8;n++)
		{
				
			if(n==0)
			{			
				n_closer = 0;

			}	
			rad_sq_n[n] = ((row_perim[k]+row_shift[n]-row_ctrd)*(row_perim[k]+row_shift[n]-row_ctrd))
			 	+ ((col_perim[k]+col_shift[n]-col_ctrd)*(col_perim[k]+col_shift[n]-col_ctrd));

			printf("\t rad_sq[%d]: %d | rad_sq_n[%d] : %d | Grid[%d][%d] : %d \n",k,rad_sq[k],n,rad_sq_n[n],row_perim[k]+row_shift[n],col_perim[k]+col_shift[n],(*mod).M_Cell.Grid[row_perim[k]+row_shift[n]][col_perim[k]+col_shift[n]]);

			/* if the neighbor is free save it*/

			/*keeping index of closer neighbors*/
			if((rad_sq_n[n]<rad_sq[k])&&((*mod).M_Cell.Grid[row_perim[k]+row_shift[n]][col_perim[k]+col_shift[n]]==0))
			{	
				
				closer[n_closer] = n;
				n_closer = n_closer +1;
					
			} 
			

		}
		/*if at least one neighbor in closer*/
		printf("\t\t n_closer: %d \n",n_closer);
		printf("\n");
		if(n_closer>0)
		{
			/* if exactly one neighbor is closer*/
			if(n_closer==1)
			{
				/*shifts w/ said neighbor*/
				(*mod).M_Cell.Grid[row_perim[k]+row_shift[closer[n_closer-1]]][col_perim[k]+col_shift[closer[n_closer-1]]] = (*mod).M_Cell.Grid[row_perim[k]][col_perim[k]];
				(*mod).M_Cell.Grid[row_perim[k]][col_perim[k]] = 0;
			}

			/*if more than one neighbor is closer*/
			if(n_closer>1)
			{
				/*chosing randomly one closer site*/
				chosen_site = (rand() % 
				(n_closer-1 - 0 + 1)) + 0;

				min_rad = rad_sq_n[closer[0]];
				for(m=1;m<n_closer;m++)
				{
					if(rad_sq_n[closer[m]]<min_rad)
					{
						min_rad= rad_sq_n[closer[m]];
						chosen_site = closer[m];
					}
				}

				(*mod).M_Cell.Grid[row_perim[k]+row_shift[chosen_site]][col_perim[k]+col_shift[chosen_site]] = (*mod).M_Cell.Grid[row_perim[k]][col_perim[k]];
				(*mod).M_Cell.Grid[row_perim[k]][col_perim[k]] = 0;
			}
		}				

	}
}
