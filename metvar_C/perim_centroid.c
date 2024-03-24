#include <stdio.h>
#include <errno.h>
#include <stdlib.h>
#include <math.h>

#include <unistd.h>        
#include <sys/stat.h>
#include <time.h>
#include "structdef.h"

void centroid(Model *mod, int *row_ctrd, int *col_ctrd)
{

	int N_pts = 0;
	int i,j,sz;	
	*row_ctrd = 0;
	*col_ctrd = 0;
	/*printf("here...1\n");
	/*printf("wtf: %d \n", (*mod).M_Nutr.sz);*/
	sz = (*mod).M_Nutr.sz;

	
	for (i=0; i<sz; i++)
	{
		for (j=0; j<sz; j++)
		{
			/*printf("here...2\n");*/
			/* if the spot is not empty*/
			if((*mod).M_Cell.Grid[i][j]!=0) 
			{
				*row_ctrd = *row_ctrd + i;
				*col_ctrd = *col_ctrd + j;
				N_pts = N_pts +1;
			}
		}
	}
	*row_ctrd = *row_ctrd/N_pts;
	*col_ctrd = *col_ctrd/N_pts;
	printf("row_ctr: %d | col_ctrd: %d \n",*row_ctrd,*col_ctrd);
	printf("****\n");
	

}

void perim(Model *mod,unsigned int sz,int *lgth_perim,int row_perim[sz], int col_perim[sz])
{

	/*caution: this alogrithm works for the LD grid
	/*option 2 : any point w zero neighbor is at the rim*/

	int i,j,k;
	int row_shift[sz];
	int col_shift[sz];
	/*int lgth_perim =0;*/
	
	row_shift[0] = -1; col_shift[0] = -1;
	row_shift[1] = -1; col_shift[1] = 0;
	row_shift[2] = -1; col_shift[2] = 1;
	row_shift[3] = 0; col_shift[3] = -1;
	row_shift[4] = 0; col_shift[4] = 1;
	row_shift[5] = 1; col_shift[5] = -1;
	row_shift[6] = 1; col_shift[6] = 0;
	row_shift[7] = 1; col_shift[7] = 1;
	


	for (i=0; i<sz; i++)
	{
		for (j=0; j<sz; j++)
		{
			for(k=0;k<8;k++)
			{
				/*Si un des voisins est vide, le point est sur le périmètre*/
				if(((*mod).M_Cell.Grid[i][j]!=0)&&((*mod).M_Cell.LD[i+row_shift[k]][j+col_shift[k]]==0))
				{
					row_perim[*lgth_perim] = i;
					col_perim[*lgth_perim] = j;
					/*printf("Grid[i][j]: %d \n",(*mod).M_Cell.Grid[i][j]);
					printf("row_perim: %d \n",row_perim[*lgth_perim]);*/
					*lgth_perim = *lgth_perim+1;
					break;
				}
			}
		}

	}
	printf("length_perim : %d \n",*lgth_perim);
	printf("****\n");
	/*return lgth_perim;*/
}
	
	/*option 1 : discarded*/
	/*four loops. You scan each line/column in both directions.
	any point followed only by zero in one of the scans is perim*/
	/*int i,j,j_interm,k;
	int sz;
	sz = (*mod).M_Nutr.sz;
	int row_perim[sz];
	int col_perim[sz];
	int lgth_perim =0;
	
	/*j+*/
	/*for (i=0; i<sz; i++)
	{
		for (j=0; j<sz; j++)
		{
			if((*mod).M_Cell.Grid[i][j]!=0&&(*mod).M_Cell.Grid[i][j+1]==0)
			{	
				for(j_interm=j+1;j_interm<sz;j_interm++)
				{
					/* if one non-zero point is found,keep going*/
					/*if((*mod).M_Cell.Grid[i][j_interm]!=0)
					{
						break;
					}
					
				}*/ 
				/*if you get to the end it is a perim point*/
				/*if(j_interm==sz-1)
				{
					for(k=0;k<lgth_perim;k++)
					{
						/*if the point is already in the list do not add it*/
						/*if((row_perim[k]==i)&&(col_perim[k]==j))
						{
							break;
						}
						
					}*/
					/*double break to change line if perim found*/
					/*if((row_perim[k]==i)&&(col_perim[k]==j))
					{
						break;
					}
								
				}
			}
		}
	}
			

}*/
