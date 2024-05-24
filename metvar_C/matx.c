#include <stdio.h>
#include <errno.h>
#include <stdlib.h>
#include "structdef.h"

#include <unistd.h>        
#include <sys/stat.h>

extern Model Mod;

int find_int( int sz, int value, int Mat[sz][sz], int *row, int *col)
{
	/*printf("find_int\n");*/
	int i, j;
	for (i=0; i<sz; i++)
	{
		for (j=0; j<sz; j++)
		{

			if(Mat[i][j]==value)
			{
				*col = j;
				*row = i;
				return;
			} 
			
		}

	}
	*row = -1;
	*col = -1;
	/*printf("row : %d | col : %d \n",*row,*col);
	printf("\n");*/
	return 0;
	
}

int find_float(float value, float** Mat, int sz, int* row, int* col)
{
	int i, j;
	for (i=0; i<sz; i++)
	{
		for (j=0; j<sz; j++)
		{
			if(Mat[i][j]==value)
			{
				col = j;
				break;
			}
			row = i;
			break; 
		}

	}

}

int Grid_check()
{
	int k;
	
	int row, col;

	printf("*");
	for(k=0;k<Mod.M_Cell.N_Cell;k++)
	{
		find_int(Mod.M_Nutr.sz,k+1,Mod.M_Cell.Grid,&row,&col);
		if(((int)(Mod.M_Cell.state[k][7])!=row)||((int)(Mod.M_Cell.state[k][8])!=col))
		{

			printf("state[%d][7]: %2.1f | row : %d \t  state[%d][8]: %2.1f | col : %d \n\n",k,Mod.M_Cell.state[k][7],row,k,Mod.M_Cell.state[k][8],col);

			printf("Grid[%d][%d] = %d | Grid[%d][%d] = %d \n\n",(int)(Mod.M_Cell.state[k][7]),(int)(Mod.M_Cell.state[k][8]),
			Mod.M_Cell.Grid[(int)(Mod.M_Cell.state[k][7])][(int)(Mod.M_Cell.state[k][8])],row,col,Mod.M_Cell.Grid[row][col]);

			return 1;
		}
		return 0;
	}
}
