#include <stdio.h>
#include <math.h>
#include <time.h>

#include "structdef.h"




void diff_metvar(Model *mod)
{

	int i,j,sz,h,nt;
	sz = (*mod).M_Nutr.sz;
	/*printf("15 here : dt : %f \n",(*mod).M_Nutr.dt);*/
	nt = (int)(1.0/(*mod).M_Nutr.dt);
	/*printf("1/dt: %f \n",1.0/(*mod).M_Nutr.dt);
	printf("nt: %d \n",nt);*/

	for (h=0; h<nt; h++)
	{
		for (i=1; i<sz-1; i++)
		{
			for (j=1; j<sz-1; j++)
			{	
				if((*mod).M_Nutr.S[i][j]>0.0)
				{
					(*mod).M_Nutr.S[i][j] = (*mod).M_Nutr.S[i][j] + (*mod).M_Nutr.d0*(*mod).M_Nutr.d0*(*mod).M_Nutr.dt/(*mod).M_Nutr.tau/(*mod).M_Nutr.dx/(*mod).M_Nutr.dx*(
							  0.5*(*mod).M_Nutr.DSm[i][j]*(*mod).M_Nutr.DSm[i-1][j]/(((*mod).M_Nutr.DSm[i][j]+(*mod).M_Nutr.DSm[i-1][j]))*((*mod).M_Nutr.S[i-1][j] - (*mod).M_Nutr.S[i][j]) 
							+ 0.5*(*mod).M_Nutr.DSm[i][j]*(*mod).M_Nutr.DSm[i+1][j]/(((*mod).M_Nutr.DSm[i][j]+(*mod).M_Nutr.DSm[i+1][j]))*((*mod).M_Nutr.S[i+1][j] - (*mod).M_Nutr.S[i][j]) 
							+ 0.5*(*mod).M_Nutr.DSm[i][j]*(*mod).M_Nutr.DSm[i][j-1]/(((*mod).M_Nutr.DSm[i][j]+(*mod).M_Nutr.DSm[i][j-1]))*((*mod).M_Nutr.S[i][j-1] - (*mod).M_Nutr.S[i][j])	
							+ 0.5*(*mod).M_Nutr.DSm[i][j]*(*mod).M_Nutr.DSm[i][j+1]/(((*mod).M_Nutr.DSm[i][j]+(*mod).M_Nutr.DSm[i][j+1]))*((*mod).M_Nutr.S[i][j+1] - (*mod).M_Nutr.S[i][j])
							) -  (*mod).M_Nutr.dt*(*mod).M_Nutr.kS[i][j];
				}

				if((*mod).M_Nutr.S[i][j]<=0.0)
				{
					(*mod).M_Nutr.S[i][j] = (*mod).M_Nutr.S[i][j] + (*mod).M_Nutr.d0*(*mod).M_Nutr.d0*(*mod).M_Nutr.dt/(*mod).M_Nutr.tau/(*mod).M_Nutr.dx/(*mod).M_Nutr.dx*(
							  0.5*(*mod).M_Nutr.DSm[i][j]*(*mod).M_Nutr.DSm[i-1][j]/(((*mod).M_Nutr.DSm[i][j]+(*mod).M_Nutr.DSm[i-1][j]))*((*mod).M_Nutr.S[i-1][j] - (*mod).M_Nutr.S[i][j]) 
							+ 0.5*(*mod).M_Nutr.DSm[i][j]*(*mod).M_Nutr.DSm[i+1][j]/(((*mod).M_Nutr.DSm[i][j]+(*mod).M_Nutr.DSm[i+1][j]))*((*mod).M_Nutr.S[i+1][j] - (*mod).M_Nutr.S[i][j]) 
							+ 0.5*(*mod).M_Nutr.DSm[i][j]*(*mod).M_Nutr.DSm[i][j-1]/(((*mod).M_Nutr.DSm[i][j]+(*mod).M_Nutr.DSm[i][j-1]))*((*mod).M_Nutr.S[i][j-1] - (*mod).M_Nutr.S[i][j])	
							+ 0.5*(*mod).M_Nutr.DSm[i][j]*(*mod).M_Nutr.DSm[i][j+1]/(((*mod).M_Nutr.DSm[i][j]+(*mod).M_Nutr.DSm[i][j+1]))*((*mod).M_Nutr.S[i][j+1] - (*mod).M_Nutr.S[i][j])
							);
				}




				if((*mod).M_Nutr.O[i][j]>0.0)
				{
					(*mod).M_Nutr.O[i][j] = (*mod).M_Nutr.O[i][j] + (*mod).M_Nutr.d0*(*mod).M_Nutr.d0*(*mod).M_Nutr.dt/(*mod).M_Nutr.tau/(*mod).M_Nutr.dx/(*mod).M_Nutr.dx*(
							  0.5*(*mod).M_Nutr.DOm[i][j]*(*mod).M_Nutr.DOm[i-1][j]/(((*mod).M_Nutr.DOm[i][j]+(*mod).M_Nutr.DOm[i-1][j]))*((*mod).M_Nutr.O[i-1][j] - (*mod).M_Nutr.O[i][j]) 
							+ 0.5*(*mod).M_Nutr.DOm[i][j]*(*mod).M_Nutr.DOm[i+1][j]/(((*mod).M_Nutr.DOm[i][j]+(*mod).M_Nutr.DOm[i+1][j]))*((*mod).M_Nutr.O[i+1][j] - (*mod).M_Nutr.O[i][j]) 
							+ 0.5*(*mod).M_Nutr.DOm[i][j]*(*mod).M_Nutr.DOm[i][j-1]/(((*mod).M_Nutr.DOm[i][j]+(*mod).M_Nutr.DOm[i][j-1]))*((*mod).M_Nutr.O[i][j-1] - (*mod).M_Nutr.O[i][j])	
							+ 0.5*(*mod).M_Nutr.DOm[i][j]*(*mod).M_Nutr.DOm[i][j+1]/(((*mod).M_Nutr.DOm[i][j]+(*mod).M_Nutr.DOm[i][j+1]))*((*mod).M_Nutr.O[i][j+1] - (*mod).M_Nutr.O[i][j])
							) -  (*mod).M_Nutr.dt*(*mod).M_Nutr.kO[i][j];
				}

				if((*mod).M_Nutr.O[i][j]<=0.0)
				{
					(*mod).M_Nutr.O[i][j] = (*mod).M_Nutr.O[i][j] + (*mod).M_Nutr.d0*(*mod).M_Nutr.d0*(*mod).M_Nutr.dt/(*mod).M_Nutr.tau/(*mod).M_Nutr.dx/(*mod).M_Nutr.dx*(
							  0.5*(*mod).M_Nutr.DOm[i][j]*(*mod).M_Nutr.DOm[i-1][j]/(((*mod).M_Nutr.DOm[i][j]+(*mod).M_Nutr.DOm[i-1][j]))*((*mod).M_Nutr.O[i-1][j] - (*mod).M_Nutr.O[i][j]) 
							+ 0.5*(*mod).M_Nutr.DOm[i][j]*(*mod).M_Nutr.DOm[i+1][j]/(((*mod).M_Nutr.DOm[i][j]+(*mod).M_Nutr.DOm[i+1][j]))*((*mod).M_Nutr.O[i+1][j] - (*mod).M_Nutr.O[i][j]) 
							+ 0.5*(*mod).M_Nutr.DOm[i][j]*(*mod).M_Nutr.DOm[i][j-1]/(((*mod).M_Nutr.DOm[i][j]+(*mod).M_Nutr.DOm[i][j-1]))*((*mod).M_Nutr.O[i][j-1] - (*mod).M_Nutr.O[i][j])	
							+ 0.5*(*mod).M_Nutr.DOm[i][j]*(*mod).M_Nutr.DOm[i][j+1]/(((*mod).M_Nutr.DOm[i][j]+(*mod).M_Nutr.DOm[i][j+1]))*((*mod).M_Nutr.O[i][j+1] - (*mod).M_Nutr.O[i][j])
							);
				}

				if((*mod).M_Cell.LD[i][j]==0)
				{
					(*mod).M_Nutr.S[i][j] =1.0;
					(*mod).M_Nutr.O[i][j] =1.0;
				}
			}
		}
	}

	/*printf("done\n");*/
}
