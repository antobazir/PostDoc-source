#include <stdio.h>
#include <errno.h>
#include <stdlib.h>

#include <unistd.h>        
#include <sys/stat.h>
#include <time.h>
#include "structdef.h"



int divide(Model *mod, int *row, int *col) 
{
	unsigned int ngh[3][3];
	unsigned int ngh_vec[8];
	int i,j;
	unsigned int n_free = 0;
	unsigned int k=0;
	unsigned int l=0;
	unsigned int n_row[8];
	unsigned int nf_row[8];
	unsigned int n_col[8];
	unsigned int nf_col[8];	 
	unsigned int idx_ngh[8]; 
	unsigned int chosen_site;
	int interm_row;
	int interm_col;
	int row_shift[8];
	int col_shift[8];

	row_shift[0] = -1; col_shift[0] = -1;
	row_shift[1] = -1; col_shift[1] = 0;
	row_shift[2] = -1; col_shift[2] = 1;
	row_shift[3] = 0; col_shift[3] = -1;
	row_shift[4] = 0; col_shift[4] = 1;
	row_shift[5] = 1; col_shift[5] = -1;
	row_shift[6] = 1; col_shift[6] = 0;
	row_shift[7] = 1; col_shift[7] = 1;

	
	/* initialise le générateur de nombres*/
	srand(time(0));

	/*test:  cas plusieurs voisins libres */ 
	/*(*mod).M_Cell.Grid[4][5]=2;
	(*mod).M_Cell.N_Cell=(*mod).M_Cell.N_Cell+1;*/

	/*test:  cas tous les voisins libres */ 


	/*test:  cas aucun voisin libre */ 
	/*(*mod).M_Cell.Grid[4][5]=2;
	(*mod).M_Cell.Grid[4][3]=3;
	(*mod).M_Cell.Grid[3][5]=4;
	(*mod).M_Cell.Grid[5][5]=9;
	(*mod).M_Cell.Grid[5][4]=8;
	(*mod).M_Cell.Grid[3][4]=7;
	(*mod).M_Cell.Grid[3][3]=6;
	(*mod).M_Cell.Grid[5][3]=5;
	(*mod).M_Cell.N_Cell=9;*/

	printf("*****************\n");
		
	for (i=0; i<SZ; i++)
	{
		for (j=0; j<SZ; j++)
		{
			printf("%d ",(*mod).M_Cell.Grid[i][j]);
		}
		printf("\n");
	}

	/* on compte les voisins vide et on identifie les voisins vides*/
	for(i=-1; i<2;i++)
	{
		for(j=-1; j<2;j++)
		{
			ngh[i+1][j+1] = (*mod).M_Cell.Grid[*row+i][*col+j];
			/*printf("current: %d \n",ngh[i+1][j+1]);*/
			n_row[l] = *row+i;
			n_col[l] = *col+j;	
			if(ngh[i+1][j+1]==0)
			{	
				if(i!=0||j!=0)
				{	
					nf_row[k] = *row+i;
					nf_col[k] = *col+j;
					idx_ngh[k] = l+1;			
					n_free = n_free+1;
					k = k+1;
				}
					
			}
			l=l+1; 
		}
	}

	for(k=0; k<8; k++)
	{	
		printf("row: %d | col: %d \n", nf_row[k],nf_col[k]);
		printf("idx_ngh: %d \n",idx_ngh[k]);
	}

	/*no free neighbor*/
	if(n_free==0)
	{
		/* no free site, selection in general list */
		chosen_site = (rand() % 
		(8-1 - 0 + 1)) + 0; 
		interm_row = *row ;  interm_col = *col;
		/*Si la case n'est pas vide on passe à côté*/
		while((*mod).M_Cell.Grid[interm_row+row_shift[chosen_site]][interm_col+col_shift[chosen_site]]!=0)
		{
			interm_row = interm_row+row_shift[chosen_site];
			interm_col = interm_col+col_shift[chosen_site];
				
		} 

		/* now interm_row/col is on the border */
		/* as long as the intermediate position is not back to before you switch and skip*/
		while(interm_row!=*row||interm_col!=*col) 
		{
			/*1.shift the grid*/
			(*mod).M_Cell.Grid[interm_row+row_shift[chosen_site]][interm_col+col_shift[chosen_site]] = (*mod).M_Cell.Grid[interm_row][interm_col];

			/*2. shift back*/			
			interm_row = interm_row-row_shift[chosen_site];
			interm_col = interm_col-col_shift[chosen_site];
		}

		/*shift is done new cell is placed*/
		(*mod).M_Cell.N_Cell = (*mod).M_Cell.N_Cell+1; 
		(*mod).M_Cell.Grid[interm_row+row_shift[chosen_site]][interm_col+col_shift[chosen_site]] = (*mod).M_Cell.N_Cell;
		(*mod).M_Cell.LD[interm_row+row_shift[chosen_site]][interm_col+col_shift[chosen_site]] = 1;
		(*mod).M_Nutr.DSm[interm_row+row_shift[chosen_site]][interm_col+col_shift[chosen_site]] = (*mod).M_Nutr.DSm[*row][*col];
		(*mod).M_Nutr.DOm[interm_row+row_shift[chosen_site]][interm_col+col_shift[chosen_site]] = (*mod).M_Nutr.DOm[*row][*col];		
		(*mod).M_Nutr.kS[interm_row+row_shift[chosen_site]][interm_col+col_shift[chosen_site]] = (*mod).M_Nutr.kS[*row][*col];
		(*mod).M_Nutr.kO[interm_row+row_shift[chosen_site]][interm_col+col_shift[chosen_site]] = (*mod).M_Nutr.kO[*row][*col];		

		printf("chosen site: %d \n",chosen_site);
		printf("row: %d | col: %d \n",n_row[chosen_site],n_col[chosen_site]);
	}

	/* one free neighbor*/
	if(n_free==1)
	{	
		/*if only one site, it is chosen */

		(*mod).M_Cell.N_Cell = (*mod).M_Cell.N_Cell+1; 
		(*mod).M_Cell.Grid[nf_row[0]][nf_col[0]] = (*mod).M_Cell.N_Cell;
		(*mod).M_Cell.LD[nf_row[0]][nf_col[0]] = 1;
		(*mod).M_Nutr.DSm[nf_row[0]][nf_col[0]] = (*mod).M_Nutr.DSm[*row][*col];
		(*mod).M_Nutr.DOm[nf_row[0]][nf_col[0]] = (*mod).M_Nutr.DOm[*row][*col];
		(*mod).M_Nutr.kS[nf_row[0]][nf_col[0]] = (*mod).M_Nutr.kS[*row][*col];
		(*mod).M_Nutr.kO[nf_row[0]][nf_col[0]] = (*mod).M_Nutr.kO[*row][*col];

		
		printf("chosen site:\n");
		printf("row: %d | col: %d \n",nf_row[0],nf_col[0]);
	}

	/*several free neighbors*/
	if(n_free>1)
	{
		/*if several free site, random selection in list */
		chosen_site = (rand() % 
		(n_free-1 - 0 + 1)) + 0; 
		(*mod).M_Cell.N_Cell = (*mod).M_Cell.N_Cell+1;
		(*mod).M_Cell.Grid[nf_row[chosen_site]][nf_col[chosen_site]] = (*mod).M_Cell.N_Cell ;
		(*mod).M_Cell.LD[nf_row[chosen_site]][nf_col[chosen_site]] = 1;
		(*mod).M_Nutr.DSm[nf_row[chosen_site]][nf_col[chosen_site]] = (*mod).M_Nutr.DSm[*row][*col];
		(*mod).M_Nutr.DOm[nf_row[chosen_site]][nf_col[chosen_site]] = (*mod).M_Nutr.DOm[*row][*col];
		(*mod).M_Nutr.kS[nf_row[chosen_site]][nf_col[chosen_site]] = (*mod).M_Nutr.kS[*row][*col];
		(*mod).M_Nutr.kO[nf_row[chosen_site]][nf_col[chosen_site]] = (*mod).M_Nutr.kO[*row][*col];

		printf("chosen site:\n");
		printf("row: %d | col: %d \n",nf_row[chosen_site],nf_col[chosen_site]);
	}





	/*printf("nfree: %d \n",n_free);
	printf("chosen_site: %d \n",chosen_site);*/


	/*(*mod).M_Cell.Grid[4][5]=2;
	(*mod).M_Cell.N_Cell=(*mod).M_Cell.N_Cell+1;*/
	return 0;
} 
