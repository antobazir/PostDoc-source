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

extern Model Mod;

int migrate_sphere()
{
	int i,j,sz,k,n,m,p;
	sz = Mod.M_Nutr.sz;
	int row_perim[400];  
	int col_perim[400];
	int row_shift[8];  
	int col_shift[8];
	int row_ctrd, row;
	int col_ctrd, col;
	int lgth_perim=0;
	int rad_sq[400];
	int rad_sq_n[8];
	int min_rad;
	int n_closer,n_closest;
	int closer[8],closest[8];
	int chosen_site;
	float D_buff;
	/*FILE *f;*/


	row_shift[0] = -1; col_shift[0] = -1;
	row_shift[1] = -1; col_shift[1] = 0;
	row_shift[2] = -1; col_shift[2] = 1;
	row_shift[3] = 0; col_shift[3] = -1;
	row_shift[4] = 0; col_shift[4] = 1;
	row_shift[5] = 1; col_shift[5] = -1;
	row_shift[6] = 1; col_shift[6] = 0;
	row_shift[7] = 1; col_shift[7] = 1;

	/*test*/
	/*Mod.M_Cell.Grid[4][5]=2;
	Mod.M_Cell.Grid[4][3]=3;
	Mod.M_Cell.Grid[3][5]=4;
	Mod.M_Cell.Grid[4][6]=9;
	Mod.M_Cell.Grid[5][4]=8;
	Mod.M_Cell.Grid[3][4]=7;
	Mod.M_Cell.Grid[3][3]=6;
	Mod.M_Cell.Grid[5][3]=5;
	Mod.M_Cell.Grid[4][7]=10;
	Mod.M_Cell.N_Cell=10;

	Mod.M_Cell.LD[4][5]=1;
	Mod.M_Cell.LD[4][3]=1;
	Mod.M_Cell.LD[3][5]=1;
	Mod.M_Cell.LD[5][5]=1;
	Mod.M_Cell.LD[5][4]=1;
	Mod.M_Cell.LD[3][4]=1;
	Mod.M_Cell.LD[3][3]=1;
	Mod.M_Cell.LD[5][3]=1;
	Mod.M_Cell.LD[5][2]=1;*/

	sz = Mod.M_Nutr.sz;
	min_rad = sz;

		/* initialise le générateur de nombres*/
	srand(time(0));


	row_ctrd = (sz/2) - 1;
	col_ctrd = (sz/2) - 1;



	/*lgth_perim =*/ 
	perim(sz,&lgth_perim,row_perim,col_perim);


	for(k=0;k<lgth_perim;k++)
	{

		/*for(i=0;i<sz;i++)
		{
			for(j=0;j<sz;j++)
			{
				printf("%d ",Mod.M_Cell.Grid[i][j]);
			}
			printf("\n");

		}*/
	
		rad_sq[k] = ((row_perim[k]-row_ctrd)*(row_perim[k]-row_ctrd))
			 + ((col_perim[k]-col_ctrd)*(col_perim[k]-col_ctrd));

		for(n=0;n<8;n++)
		{
				
			if(n==0)
			{			
				n_closer = 0;

			}	
			rad_sq_n[n] = ((row_perim[k]+row_shift[n]-row_ctrd)*(row_perim[k]+row_shift[n]-row_ctrd))
			 	+ ((col_perim[k]+col_shift[n]-col_ctrd)*(col_perim[k]+col_shift[n]-col_ctrd));

			/* if the neighbor is free save it*/

			/*keeping index of closer neighbors*/
			if((rad_sq_n[n]<rad_sq[k])&&(Mod.M_Cell.LD[row_perim[k]+row_shift[n]][col_perim[k]+col_shift[n]]==0))
			{	
				
				closer[n_closer] = n;
				n_closer = n_closer +1;
					
			} 
			

		}

		if(n_closer>0)
		{
			/* if exactly one neighbor is closer*/
			if(n_closer==1)
			{
				/*printf("l.163 \n");*/
				chosen_site = closer[n_closer-1];


				/*shifts w/ said neighbor*/
				Mod.M_Cell.Grid[row_perim[k]+row_shift[chosen_site]][col_perim[k]+col_shift[chosen_site]] = Mod.M_Cell.Grid[row_perim[k]][col_perim[k]];
				Mod.M_Cell.Grid[row_perim[k]][col_perim[k]] = 0;

				/*after displacement,update position in state_vector*/
				find_int(sz,Mod.M_Cell.Grid[row_perim[k]+row_shift[chosen_site]][col_perim[k]+col_shift[chosen_site]],Mod.M_Cell.Grid,&row,&col);
								
				Mod.M_Cell.state[Mod.M_Cell.Grid[row_perim[k]+row_shift[chosen_site]][col_perim[k]+col_shift[chosen_site]]-1][7] = (float)(row);
				Mod.M_Cell.state[Mod.M_Cell.Grid[row_perim[k]+row_shift[chosen_site]][col_perim[k]+col_shift[chosen_site]]-1][8] = (float)(col);
				

				Mod.M_Cell.LD[row_perim[k]+row_shift[chosen_site]][col_perim[k]+col_shift[chosen_site]] = 1;
				Mod.M_Cell.LD[row_perim[k]][col_perim[k]] = 0;
				Mod.M_Cell.state_mat[row_perim[k]+row_shift[chosen_site]][col_perim[k]+col_shift[chosen_site]] = Mod.M_Cell.Grid[row_perim[k]][col_perim[k]];
				Mod.M_Cell.state_mat[row_perim[k]][col_perim[k]] = 0;
				Mod.M_Nutr.kS[row_perim[k]+row_shift[chosen_site]][col_perim[k]+col_shift[chosen_site]] = Mod.M_Nutr.kS[row_perim[k]][col_perim[k]];
				Mod.M_Nutr.kS[row_perim[k]][col_perim[k]] = 0;
				Mod.M_Nutr.kO[row_perim[k]+row_shift[chosen_site]][col_perim[k]+col_shift[chosen_site]] = Mod.M_Nutr.kO[row_perim[k]][col_perim[k]];
				Mod.M_Nutr.kO[row_perim[k]][col_perim[k]] = 0;
				D_buff = Mod.M_Nutr.DSm[row_perim[k]+row_shift[chosen_site]][col_perim[k]+col_shift[chosen_site]];
				Mod.M_Nutr.DSm[row_perim[k]+row_shift[chosen_site]][col_perim[k]+col_shift[chosen_site]] = Mod.M_Nutr.DSm[row_perim[k]][col_perim[k]];
				Mod.M_Nutr.DSm[row_perim[k]][col_perim[k]] = D_buff;
				D_buff = Mod.M_Nutr.DOm[row_perim[k]+row_shift[chosen_site]][col_perim[k]+col_shift[chosen_site]];
				Mod.M_Nutr.DOm[row_perim[k]+row_shift[chosen_site]][col_perim[k]+col_shift[chosen_site]] = Mod.M_Nutr.DOm[row_perim[k]][col_perim[k]];
				Mod.M_Nutr.DOm[row_perim[k]][col_perim[k]] = D_buff;
				
				/*for(i=0;i<sz;i++)
				{
					for(j=0;j<sz;j++)
					{
						printf("%d ",Mod.M_Cell.Grid[i][j]);
					}
					printf("\n");

				}*/				
				

				/*if a shift occurs get back to the start w/ new perim and centroid*/				
				/*centroid(mod,&row_ctrd,&col_ctrd);*/	
				perim(sz,&lgth_perim,row_perim,col_perim);			
				k=-1;/*you shifted so you need to calculate again*/
				/*break;*/ 			
			}

			/*if more than one neighbor is closer*/
			if(n_closer>1)
			{
		
			
				/*the neighbors w/ min distance is found*/
				min_rad = rad_sq_n[closer[0]];
				n_closest=0;
				
				for(m=0;m<n_closer;m++)
				{
					if(rad_sq_n[closer[m]]<min_rad)
					{
					
						min_rad= rad_sq_n[closer[m]];
						closest[0] = closer[m];
						n_closest = 1;
					}

					if(rad_sq_n[closer[m]]==min_rad)
					{
						closest[n_closest] = closer[m];
						n_closest = n_closest+1;	
					}
				}
				

	
				/* if one neighbor closer*/
				if(n_closest==1)
				{
					chosen_site = closest[0];
				}

				if(n_closest>1)
				{
					chosen_site = closest[(rand() % 
					((n_closest-1) - 0 + 1)) + 0];
				}


				n_closest= 0;
				n_closer =0;

				/*printf("several neighbs; \t col_perim[%d]: %d  \t  chosen_site : %d  \t Grid : %d \n\n",k,col_perim[k],chosen_site,Mod.M_Cell.Grid[row_perim[k]][col_perim[k]]);*/

				Mod.M_Cell.Grid[row_perim[k]+row_shift[chosen_site]][col_perim[k]+col_shift[chosen_site]] = Mod.M_Cell.Grid[row_perim[k]][col_perim[k]];
				Mod.M_Cell.Grid[row_perim[k]][col_perim[k]] = 0;


				/*after displacement,update position in state_vector*/
				find_int(sz,Mod.M_Cell.Grid[row_perim[k]+row_shift[chosen_site]][col_perim[k]+col_shift[chosen_site]],Mod.M_Cell.Grid,&row,&col);
				
				Mod.M_Cell.state[Mod.M_Cell.Grid[row_perim[k]+row_shift[chosen_site]][col_perim[k]+col_shift[chosen_site]]-1][7] = (float)(row);
				Mod.M_Cell.state[Mod.M_Cell.Grid[row_perim[k]+row_shift[chosen_site]][col_perim[k]+col_shift[chosen_site]]-1][8] = (float)(col);


				Mod.M_Cell.LD[row_perim[k]+row_shift[chosen_site]][col_perim[k]+col_shift[chosen_site]] = 1;
				Mod.M_Cell.LD[row_perim[k]][col_perim[k]] = 0;
				Mod.M_Cell.state_mat[row_perim[k]+row_shift[chosen_site]][col_perim[k]+col_shift[chosen_site]] = Mod.M_Cell.Grid[row_perim[k]][col_perim[k]];
				Mod.M_Cell.state_mat[row_perim[k]][col_perim[k]] = 0;
				Mod.M_Nutr.kS[row_perim[k]+row_shift[chosen_site]][col_perim[k]+col_shift[chosen_site]] = Mod.M_Nutr.kS[row_perim[k]][col_perim[k]];
				Mod.M_Nutr.kS[row_perim[k]][col_perim[k]] = 0;
				Mod.M_Nutr.kO[row_perim[k]+row_shift[chosen_site]][col_perim[k]+col_shift[chosen_site]] = Mod.M_Nutr.kO[row_perim[k]][col_perim[k]];
				Mod.M_Nutr.kO[row_perim[k]][col_perim[k]] = 0;
				D_buff = Mod.M_Nutr.DSm[row_perim[k]+row_shift[chosen_site]][col_perim[k]+col_shift[chosen_site]];
				Mod.M_Nutr.DSm[row_perim[k]+row_shift[chosen_site]][col_perim[k]+col_shift[chosen_site]] = Mod.M_Nutr.DSm[row_perim[k]][col_perim[k]];
				Mod.M_Nutr.DSm[row_perim[k]][col_perim[k]] = D_buff;
				D_buff = Mod.M_Nutr.DOm[row_perim[k]+row_shift[chosen_site]][col_perim[k]+col_shift[chosen_site]];
				Mod.M_Nutr.DOm[row_perim[k]+row_shift[chosen_site]][col_perim[k]+col_shift[chosen_site]] = Mod.M_Nutr.DOm[row_perim[k]][col_perim[k]];
				Mod.M_Nutr.DOm[row_perim[k]][col_perim[k]] = D_buff;


				/*for(i=0;i<sz;i++)
				{
					for(j=0;j<sz;j++)
					{
						printf("%d ",Mod.M_Cell.Grid[i][j]);
					}
					printf("\n");

				}*/

				/*centroid(mod,&row_ctrd,&col_ctrd);*/
				perim(sz,&lgth_perim,row_perim,col_perim);			
				k=-1;/*you shifted so you need to calculate again*/
				/*break;*/
		
			}
		}				
		
	}


}


void migrate_chip()
{
	int i,j,k;
	int m=0,l=0; 
	int row_shift[8];  
	int col_shift[8];
	int n_row[8];
	int nf_row[8];
	int n_col[8];
	int nf_col[8];	 
	int idx_ngh[8];
	int ngh[3][3];
	int ngh_vec[8]; 
	int interm_row, row, row2;
	int interm_col, col;
	int chosen_site;
	int n_free = 0;


	row_shift[0] = -1; col_shift[0] = -1;
	row_shift[1] = -1; col_shift[1] = 0;
	row_shift[2] = -1; col_shift[2] = 1;
	row_shift[3] = 0; col_shift[3] = -1;
	row_shift[4] = 0; col_shift[4] = 1;
	row_shift[5] = 1; col_shift[5] = -1;
	row_shift[6] = 1; col_shift[6] = 0;
	row_shift[7] = 1; col_shift[7] = 1;

	srand(time(0));
	
	/*Grid_check();*/
	/*cycling on all cells*/
	for(k=0;k<Mod.M_Cell.N_Cell;k++)
	{
		printf("311 \n");
		row = (int)(Mod.M_Cell.state[k][7]);
		col = (int)(Mod.M_Cell.state[k][8]);
		n_free = 0;
		/*printf("row %d | state[%d][7]: %3.2f | cond %d \n",row,k,Mod.M_Cell.state[k][7],row!=(int)(Mod.M_Cell.state[k][7]));
		printf("316 \n");
		if(row!=row2)
		{
			printf("nope: k : %d | row : %d | row2: %d \n",k,row,row2);
			return;
		}
		printf("322 \n")*/;
		/*printf("%d : row %d|%3.2f | col  %d|%3.2f  \n",k+1,row,Mod.M_Cell.state[k][7],col,Mod.M_Cell.state[k][8]);
		/*cells needs to be not starving and proliferating*/
		/*printf("%d : state_mat: %d -> [%d][%d] \n",k,Mod.M_Cell.state_mat[(int)(Mod.M_Cell.state[k][7])][(int)(Mod.M_Cell.state[k][8])],(int)(Mod.M_Cell.state[k][7]),(int)(Mod.M_Cell.state[k][8]));
		printf("k: %d |first cond: %d\n",k,Mod.M_Cell.state_mat[(int)(Mod.M_Cell.state[k][7])][(int)(Mod.M_Cell.state[k][8])]>1);*/
		if(Mod.M_Cell.state_mat[(int)(Mod.M_Cell.state[k][7])][(int)(Mod.M_Cell.state[k][8])]>1&&Mod.M_Cell.state[k][1]>1.01)
		{
			for(i=-1; i<2;i++)
			{
				for(j=-1; j<2;j++)
				{
					ngh[i+1][j+1] = Mod.M_Cell.Grid[row+i][col+j];
					/*printf("current: %d \n",ngh[i+1][j+1]);*/
					n_row[l] = row+i;
					n_col[l] = col+j;	
					if(ngh[i+1][j+1]==0)
					{	
						if(i!=0||j!=0)
						{	
							nf_row[m] = row+i;
							nf_col[m] = col+j;
							idx_ngh[m] = l+1;			
							n_free = n_free+1;
							m = m+1;
						}
							
					}
					l=l+1; 
				}
			}
			printf("352 \n");
			/*printf("n_free: %d\n",n_free);*/
			/*no free neighbor*/
			if(n_free==0)
			{
				/*can't move if boxed*/
				return;
			}

			/* one free neighbor*/
			if(n_free==1)
			{
				/*movement =duplication + removal*/

				/*duplication*/
				printf("367 \n");
				Mod.M_Cell.Grid[nf_row[0]][nf_col[0]] = k+1;
				Mod.M_Cell.LD[nf_row[0]][nf_col[0]] = 1;
				Mod.M_Nutr.DSm[nf_row[0]][nf_col[0]] = Mod.M_Nutr.DSm[row][col];
				Mod.M_Nutr.DOm[nf_row[0]][nf_col[0]] = Mod.M_Nutr.DOm[row][col];
				Mod.M_Nutr.kS[nf_row[0]][nf_col[0]] = Mod.M_Nutr.kS[row][col];
				Mod.M_Nutr.kO[nf_row[0]][nf_col[0]] = Mod.M_Nutr.kO[row][col];
				Mod.M_Cell.state_mat[nf_row[0]][nf_col[0]] = Mod.M_Cell.state_mat[row][col];
				Mod.M_Cell.state[k][7] = (float)(nf_row[0]);
				Mod.M_Cell.state[k][8] = (float)(nf_col[0]);


				/*removal*/
				Mod.M_Cell.Grid[row][col] = 0;
				Mod.M_Cell.LD[row][col] = 0;
				Mod.M_Nutr.DSm[row][col] = Mod.M_Nutr.DS_mat;
				Mod.M_Nutr.DOm[row][col] = Mod.M_Nutr.DS_mat;
				Mod.M_Nutr.kS[row][col]  = 0.0;
				Mod.M_Nutr.kO[row][col] = 0.0;
				Mod.M_Cell.state_mat[row][col] = 0;

		
			}

			if(n_free>1)
			{
				chosen_site = (rand() % 
				((n_free-1) - 0 + 1)) + 0; 

				/*printf("chosen_site: %d\n",chosen_site);*/
							/*movement =duplication + removal*/

				printf("399 \n");
				/*duplication*/
				Mod.M_Cell.Grid[nf_row[chosen_site]][nf_col[chosen_site]] = k+1;
				Mod.M_Cell.LD[nf_row[chosen_site]][nf_col[chosen_site]] = 1;
				Mod.M_Nutr.DSm[nf_row[chosen_site]][nf_col[chosen_site]] = Mod.M_Nutr.DSm[row][col];
				Mod.M_Nutr.DOm[nf_row[chosen_site]][nf_col[chosen_site]] = Mod.M_Nutr.DOm[row][col];
				Mod.M_Nutr.kS[nf_row[chosen_site]][nf_col[chosen_site]] = Mod.M_Nutr.kS[row][col];
				Mod.M_Nutr.kO[nf_row[chosen_site]][nf_col[chosen_site]] = Mod.M_Nutr.kO[row][col];
				Mod.M_Cell.state_mat[nf_row[chosen_site]][nf_col[chosen_site]] = Mod.M_Cell.state_mat[row][col];
				Mod.M_Cell.state[k][7] = (float)(nf_row[chosen_site]);
				Mod.M_Cell.state[k][8] = (float)(nf_col[chosen_site]);

				printf("411 \n");
				/*removal*/
				Mod.M_Cell.Grid[row][col] = 0;
				Mod.M_Cell.LD[row][col] = 0;
				Mod.M_Nutr.DSm[row][col] = Mod.M_Nutr.DS_mat;
				Mod.M_Nutr.DOm[row][col] = Mod.M_Nutr.DO_mat;
				Mod.M_Nutr.kS[row][col]  = 0.0;
				Mod.M_Nutr.kO[row][col] = 0.0;
				Mod.M_Cell.state_mat[row][col] = 0;
			}
		}

	}
	printf("425 \n");
	return; 
	/*printf("done\n");*/
}

void migrate_chip2(int cell_idx)
{
	int i,j;
	int m=0,l=0; 
	int row_shift[8];  
	int col_shift[8];
	int n_row[8];
	int nf_row[8];
	int n_col[8];
	int nf_col[8];	 
	int idx_ngh[8];
	int ngh[3][3];
	int ngh_vec[8]; 
	int interm_row, row, row2;
	int interm_col, col;
	int chosen_site;
	int n_free = 0;


	row_shift[0] = -1; col_shift[0] = -1;
	row_shift[1] = -1; col_shift[1] = 0;
	row_shift[2] = -1; col_shift[2] = 1;
	row_shift[3] = 0; col_shift[3] = -1;
	row_shift[4] = 0; col_shift[4] = 1;
	row_shift[5] = 1; col_shift[5] = -1;
	row_shift[6] = 1; col_shift[6] = 0;
	row_shift[7] = 1; col_shift[7] = 1;

	srand(time(0));
	
	/*Grid_check();*/
	/*cycling on all cells*/

	/*find_int(Mod.M_Nutr.sz,cell_idx+1,Mod.M_Cell.Grid,&row2,&col);*/
	row = (int)(Mod.M_Cell.state[cell_idx][7]);
	col = (int)(Mod.M_Cell.state[cell_idx][8]);
	/*n_free = 0;
	if(row!=row2)
	{
		printf("nope: cell_idx : %d | row : %d | row2: %d \n",cell_idx,row,row2);
		return;
	}
	printf("322 \n");*/
	/*printf("%d : row %d|%3.2f | col  %d|%3.2f  \n",cell_idx+1,row,Mod.M_Cell.state[cell_idx][7],col,Mod.M_Cell.state[cell_idx][8]);
	/*cells needs to be not starving and proliferating*/
	/*printf("%d : state_mat: %d -> [%d][%d] \n",cell_idxMod.M_Cell.state_mat[(int)(Mod.M_Cell.state[cell_idx][7])][(int)(Mod.M_Cell.state[cell_idx][8])],(int)(Mod.M_Cell.state[cell_idx][7]),(int)(Mod.M_Cell.state[cell_idx][8]));
	printf("k: %d |first cond: %d\n",cell_idxMod.M_Cell.state_mat[(int)(Mod.M_Cell.state[cell_idx][7])][(int)(Mod.M_Cell.state[cell_idx][8])]>1);*/
	if(Mod.M_Cell.state_mat[(int)(Mod.M_Cell.state[cell_idx][7])][(int)(Mod.M_Cell.state[cell_idx][8])]>1&&Mod.M_Cell.state[cell_idx][1]>1.01)
	{
		for(i=-1; i<2;i++)
		{
			for(j=-1; j<2;j++)
			{
				ngh[i+1][j+1] = Mod.M_Cell.Grid[row+i][col+j];
				/*printf("current: %d \n",ngh[i+1][j+1]);*/
				n_row[l] = row+i;
				n_col[l] = col+j;	
				if(ngh[i+1][j+1]==0)
				{	
					if(i!=0||j!=0)
					{	
						nf_row[m] = row+i;
						nf_col[m] = col+j;
						idx_ngh[m] = l+1;			
						n_free = n_free+1;
						m = m+1;
					}
						
				}
				l=l+1; 
			}
		}
		
		/*printf("n_free: %d\n",n_free);*/
		/*no free neighbor*/
		if(n_free==0)
		{
			/*can't move if boxed*/
			return;
		}

		/* one free neighbor*/
		if(n_free==1)
		{
			/*movement =duplication + removal*/

			/*duplication*/
			Mod.M_Cell.Grid[nf_row[0]][nf_col[0]] = cell_idx+1;
			Mod.M_Cell.LD[nf_row[0]][nf_col[0]] = 1;
			Mod.M_Nutr.DSm[nf_row[0]][nf_col[0]] = Mod.M_Nutr.DSm[row][col];
			Mod.M_Nutr.DOm[nf_row[0]][nf_col[0]] = Mod.M_Nutr.DOm[row][col];
			Mod.M_Nutr.kS[nf_row[0]][nf_col[0]] = Mod.M_Nutr.kS[row][col];
			Mod.M_Nutr.kO[nf_row[0]][nf_col[0]] = Mod.M_Nutr.kO[row][col];
			Mod.M_Cell.state_mat[nf_row[0]][nf_col[0]] = Mod.M_Cell.state_mat[row][col];
			Mod.M_Cell.state[cell_idx][7] = (float)(nf_row[0]);
			Mod.M_Cell.state[cell_idx][8] = (float)(nf_col[0]);


			/*removal*/
			Mod.M_Cell.Grid[row][col] = 0;
			Mod.M_Cell.LD[row][col] = 0;
			Mod.M_Nutr.DSm[row][col] = Mod.M_Nutr.DS_mat;
			Mod.M_Nutr.DOm[row][col] = Mod.M_Nutr.DS_mat;
			Mod.M_Nutr.kS[row][col]  = 0.0;
			Mod.M_Nutr.kO[row][col] = 0.0;
			Mod.M_Cell.state_mat[row][col] = 0;

	
		}

		if(n_free>1)
		{
			chosen_site = (rand() % 
			((n_free-1) - 0 + 1)) + 0; 

			/*printf("chosen_site: %d\n",chosen_site);*/
						/*movement =duplication + removal*/

			/*duplication*/
			Mod.M_Cell.Grid[nf_row[chosen_site]][nf_col[chosen_site]] = cell_idx+1;
			Mod.M_Cell.LD[nf_row[chosen_site]][nf_col[chosen_site]] = 1;
			Mod.M_Nutr.DSm[nf_row[chosen_site]][nf_col[chosen_site]] = Mod.M_Nutr.DSm[row][col];
			Mod.M_Nutr.DOm[nf_row[chosen_site]][nf_col[chosen_site]] = Mod.M_Nutr.DOm[row][col];
			Mod.M_Nutr.kS[nf_row[chosen_site]][nf_col[chosen_site]] = Mod.M_Nutr.kS[row][col];
			Mod.M_Nutr.kO[nf_row[chosen_site]][nf_col[chosen_site]] = Mod.M_Nutr.kO[row][col];
			Mod.M_Cell.state_mat[nf_row[chosen_site]][nf_col[chosen_site]] = Mod.M_Cell.state_mat[row][col];
			Mod.M_Cell.state[cell_idx][7] = (float)(nf_row[chosen_site]);
			Mod.M_Cell.state[cell_idx][8] = (float)(nf_col[chosen_site]);


			/*removal*/
			Mod.M_Cell.Grid[row][col] = 0;
			Mod.M_Cell.LD[row][col] = 0;
			Mod.M_Nutr.DSm[row][col] = Mod.M_Nutr.DS_mat;
			Mod.M_Nutr.DOm[row][col] = Mod.M_Nutr.DO_mat;
			Mod.M_Nutr.kS[row][col]  = 0.0;
			Mod.M_Nutr.kO[row][col] = 0.0;
			Mod.M_Cell.state_mat[row][col] = 0;
		}
	}

	
	return; 
	/*printf("done\n");*/
}
