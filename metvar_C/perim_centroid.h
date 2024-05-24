#include <stdio.h>
#include <errno.h>
#include <stdlib.h>
#include <math.h>

#include <unistd.h>        
#include <sys/stat.h>
#include <time.h>


void centroid( int *row_ctrd, int *col_ctrd);

void perim(unsigned int sz,int *lgth_perim,int row_perim[sz], int col_perim[sz]);

