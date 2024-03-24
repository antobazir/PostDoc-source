#include <stdio.h>
#include <errno.h>
#include <stdlib.h>

#include <unistd.h>        
#include <sys/stat.h>

int find_int( unsigned int sz, unsigned int value, unsigned int Mat[sz][sz], int *row, int *col)
{

	int i, j;
	for (i=0; i<sz; i++)
	{
		for (j=0; j<sz; j++)
		{

			if(Mat[i][j]==value)
			{
				*col = j;
				break;
			} 
			
		}
		if(Mat[i][j]==value)
		{
			*row = i;
			break;
		}

	}
	return 0;
	
}

int find_float(float value, float** Mat, unsigned int sz, int* row, int* col)
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
