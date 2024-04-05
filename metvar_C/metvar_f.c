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
#include "diff_metvar.h"
#include "behav.h"

#include <unistd.h>        
#include <sys/stat.h>  


	
int metvar_f(float kS, float kO ,char* behavior ,char* file)
{

	printf("metvar \n");
	float kO_tissue = kO;
	float kS_tissue = kS;
	int sz = SZ;
	int row, col;
	int n_pt =0;
	int N=24000;
	int rad_sq=0;

	

	Model Mod;
	Model Mod_r;
	/*Model Mod_save[200];*/	
	
	int i=0,j=0,k=0,l=0,m=0;
	FILE *f;
	FILE *f2; 

	Mod.M_Nutr.DS_med = 0.3;
	/*Initialisation des matrices*/
	for (i=0; i<sz; i++)
	{
		for (j=0; j<sz; j++)
		{
			Mod.M_Nutr.S[i][j] = 1.0;
			Mod.M_Nutr.O[i][j] = 1.0;
			Mod.M_Nutr.kS[i][j] = 0.0;
			Mod.M_Nutr.kO[i][j] = 0.0;
			Mod.M_Nutr.DSm[i][j] = Mod.M_Nutr.DS_med;
			Mod.M_Nutr.DOm[i][j] = 1.0;
			Mod.M_Cell.Grid[i][j] = 0;
			Mod.M_Cell.LD[i][j] = 0;
			Mod.M_Cell.state_mat[i][j] = 0;
		}
	}
	
	for (i=0; i<sz; i++)
	{
		for (j=0; j<10; j++)
		{
			Mod.M_Cell.state[i][j] = 0.0;
		}
	}


	
	/*first cell is placed on the grid*/
	Mod.M_Nutr.dx = 20.0;
	Mod.M_Nutr.d0 = 20.0;
	Mod.M_Nutr.dt = (0.5*Mod.M_Nutr.dx*Mod.M_Nutr.dx)/200000.0;
	Mod.M_Nutr.tau = Mod.M_Nutr.d0*Mod.M_Nutr.d0/100000.0;
	Mod.M_Cell.S_prol = 0.6;
	Mod.M_Cell.S_maint = 0.3;
	Mod.M_Cell.O_norm = 0.4;
	Mod.M_Cell.Grid[sz/2-1][sz/2-1] = 1;
	Mod.M_Cell.LD[sz/2-1][sz/2-1] = 1;
	Mod.M_Cell.N_Cell = 1;
	Mod.M_Cell.N_Dead = 0;
	Mod.M_Cell.n_pts=0;
	Mod.M_Cell.max_rad_sq=0;
	Mod.M_Cell.reac_time = 60;
	Mod.M_Cell.n_min = 1500;
	Mod.M_Cell.state_mat[sz/2-1][sz/2-1] = 5;
	Mod.M_Nutr.kS[sz/2-1][sz/2-1] = kS_tissue;
	Mod.M_Nutr.kO[sz/2-1][sz/2-1] = kO_tissue;
	Mod.M_Nutr.DSm[sz/2-1][sz/2-1] = 0.05;
	Mod.M_Nutr.DOm[sz/2-1][sz/2-1] = 0.6;
	Mod.M_Nutr.sz = sz;

	Mod.M_Cell.state[0][0] = 10.0; /*divison timer*/
	Mod.M_Cell.state[0][1] = 1.0; /*proliferation index*/
	Mod.M_Cell.state[0][2] = 0.0; /*Timer for state change*/
	Mod.M_Cell.state[0][3] = kS; /*Substrate consumption*/
	Mod.M_Cell.state[0][4] = 0.0; /*Substrate consumption*/
	Mod.M_Cell.state[0][5] = kO; /*Oxygen consumption*/
	Mod.M_Cell.state[0][6] = 0.0; /*Oxygen cons evolution*/
	Mod.M_Cell.state[0][7] = (float)(sz/2-1); /*row*/
	Mod.M_Cell.state[0][8] = (float)(sz/2-1); /*column*/
	Mod.M_Cell.state[0][9] = 0.0; /*parent*/

	printf("initial Grid: \n");

	f = fopen(file,"a+");

	
	for(k=1;k<16;k++)
	{

		/*divide at the site previously extracted*/
		divide(&Mod,k);

		find_int(sz,k+1,Mod.M_Cell.Grid,&row,&col);
		if(((int)(Mod.M_Cell.state[k][7])!=row)||((int)(Mod.M_Cell.state[k][8])!=col))
		{
			printf("l.117 n_pt: %d \n\n",n_pt);

			printf("state[%d][7]: %2.1f | row : %d \t  state[%d][8]: %2.1f | col : %d \n\n",k,Mod.M_Cell.state[k][7],row,k,Mod.M_Cell.state[k][8],col);

			printf("Grid[%d][%d] = %d | Grid[%d][%d] = %d \n\n",(int)(Mod.M_Cell.state[k][7]),(int)(Mod.M_Cell.state[k][8]),
			Mod.M_Cell.Grid[(int)(Mod.M_Cell.state[k][7])][(int)(Mod.M_Cell.state[k][8])],row,col,Mod.M_Cell.Grid[row][col]);
			/*for(i=0;i<sz;i++)
			{
				for(j=0;j<sz;j++)
				{
					printf("%d ",Mod.M_Cell.Grid[i][j]);
				}
				printf("\n");

			}
			printf("\n");*/
			for(i=0;i<Mod.M_Cell.N_Cell;i++)
			{
				printf("%d ",i+1);
				for(j=0;j<10;j++)
				{
					printf("%2.1f  ",Mod.M_Cell.state[i][j]);
				}
				printf("\n");

			}
			printf("\n");

			for(i=35-10;i<35+10;i++)
			{
				for(j=35-10;j<35+10;j++)
				{
					printf("%d ",Mod.M_Cell.Grid[i][j]);
				}
				printf("\n");

			}
			printf("\n");
		
			fwrite(&Mod,sizeof(Model),1,f);
			return;
		}
		
		/*do a migration round*/
		migrate_sphere(&Mod);

		find_int(sz,k+1,Mod.M_Cell.Grid,&row,&col);
		if(((int)(Mod.M_Cell.state[k][7])!=row)||((int)(Mod.M_Cell.state[k][8])!=col))
		{
			printf("l.167 n_pt: %d \n\n",n_pt);

			printf("state[%d][7]: %2.1f | row : %d \t  state[%d][8]: %2.1f | col : %d \n\n",k,Mod.M_Cell.state[k][7],row,k,Mod.M_Cell.state[k][8],col);

			printf("Grid[%d][%d] = %d | Grid[%d][%d] = %d \n\n",(int)(Mod.M_Cell.state[k][7]),(int)(Mod.M_Cell.state[k][8]),
			Mod.M_Cell.Grid[(int)(Mod.M_Cell.state[k][7])][(int)(Mod.M_Cell.state[k][8])],row,col,Mod.M_Cell.Grid[row][col]);
			/*for(i=0;i<sz;i++)
			{
				for(j=0;j<sz;j++)
				{
					printf("%d ",Mod.M_Cell.Grid[i][j]);
				}
				printf("\n");

			}
			printf("\n");*/
			for(i=0;i<Mod.M_Cell.N_Cell;i++)
			{
				printf("%d ",i+1);
				for(j=0;j<10;j++)
				{
					printf("%2.1f  ",Mod.M_Cell.state[i][j]);
				}
				printf("\n");

			}
			printf("\n");

			for(i=35-10;i<35+10;i++)
			{
				for(j=35-10;j<35+10;j++)
				{
					printf("%d ",Mod.M_Cell.Grid[i][j]);
				}
				printf("\n");

			}
			printf("\n");
		
			fwrite(&Mod,sizeof(Model),1,f);
			return;
		}
		
		


	}
	printf("init: done\n");
	
	behav(&Mod,behavior,kS_tissue,kO_tissue);


	/*randomizing cell timers*/
	for(i=0;i<Mod.M_Cell.N_Cell;i++)
	{
		Mod.M_Cell.state[i][0] = (float)((rand() % 
		(1500 - 0 + 1)) + 0);

	}

	/*each point is a minute*/
	while(n_pt<N&&Mod.M_Cell.max_rad_sq<=25*25)
	{
	
		n_pt++;

		diff_metvar(&Mod);
		

		/*metvar for one minute */
		for(l=0;l<Mod.M_Cell.N_Cell;l++)
		{	
			if(Mod.M_Cell.state[l][7]!=-1.0&&Mod.M_Cell.state[l][8]!=-1.0)
			{
				rad_sq = 
					(((int)(Mod.M_Cell.state[l][7]) - sz/2)*((int)(Mod.M_Cell.state[l][7]) - sz/2))+ 
					  (((int)(Mod.M_Cell.state[l][8]) - sz/2)*((int)(Mod.M_Cell.state[l][8]) - sz/2)) 
					  ;
			}

		  
			if(rad_sq>Mod.M_Cell.max_rad_sq)
			{
				printf("%d : %3.1f %3.1f \n \n",l,Mod.M_Cell.state[l][7],Mod.M_Cell.state[l][8]);
				Mod.M_Cell.max_rad_sq=rad_sq;
			}
			
		
			/*decreasing timer*/
			if(Mod.M_Cell.state[l][2]>0)
			{
				Mod.M_Cell.state[l][3] = Mod.M_Cell.state[l][3] + Mod.M_Cell.state[l][4];
				Mod.M_Cell.state[l][5] = Mod.M_Cell.state[l][5] + Mod.M_Cell.state[l][6]; 
				Mod.M_Cell.state[l][2] = Mod.M_Cell.state[l][2]-1.0;				

				if((Mod.M_Cell.state[l][2]<=(Mod.M_Cell.reac_time/3.0))&&Mod.M_Cell.LD[(int)(Mod.M_Cell.state[l][7])][(int)(Mod.M_Cell.state[l][8])]==-1)
				{
					Mod.M_Nutr.DSm[(int)(Mod.M_Cell.state[l][7])][(int)(Mod.M_Cell.state[l][8])] = Mod.M_Nutr.DSm[(int)(Mod.M_Cell.state[l][7])][(int)(Mod.M_Cell.state[l][8])]  + (Mod.M_Nutr.DS_med-0.05)/(Mod.M_Cell.reac_time/3.0);
					Mod.M_Nutr.DOm[(int)(Mod.M_Cell.state[l][7])][(int)(Mod.M_Cell.state[l][8])] = Mod.M_Nutr.DOm[(int)(Mod.M_Cell.state[l][7])][(int)(Mod.M_Cell.state[l][8])]  + (1.0-0.6)/(Mod.M_Cell.reac_time/3.0);				
				}			

			}


			/*update nutrients map*/
			Mod.M_Nutr.kS[(int)(Mod.M_Cell.state[l][7])][(int)(Mod.M_Cell.state[l][8])]=Mod.M_Cell.state[l][3];
			Mod.M_Nutr.kO[(int)(Mod.M_Cell.state[l][7])][(int)(Mod.M_Cell.state[l][8])]=Mod.M_Cell.state[l][5];


			if(Mod.M_Cell.state[l][1]!=0&&Mod.M_Cell.state[l][2]==0&&Mod.M_Cell.LD[(int)(Mod.M_Cell.state[l][7])][(int)(Mod.M_Cell.state[l][8])]==-1)
			{
				Mod.M_Cell.Grid[(int)(Mod.M_Cell.state[l][7])][(int)(Mod.M_Cell.state[l][8])] = 0;				
				Mod.M_Nutr.kS[(int)(Mod.M_Cell.state[l][7])][(int)(Mod.M_Cell.state[l][8])] = 0.0;				
				Mod.M_Nutr.kO[(int)(Mod.M_Cell.state[l][7])][(int)(Mod.M_Cell.state[l][8])] = 0.0;
				Mod.M_Nutr.DSm[(int)(Mod.M_Cell.state[l][7])][(int)(Mod.M_Cell.state[l][8])] = Mod.M_Nutr.DS_med;				
				Mod.M_Nutr.DOm[(int)(Mod.M_Cell.state[l][7])][(int)(Mod.M_Cell.state[l][8])] = 1.0;
				Mod.M_Cell.state_mat[(int)(Mod.M_Cell.state[l][7])][(int)(Mod.M_Cell.state[l][8])] = 0.0;
				Mod.M_Cell.state[l][1]=0.0;
				Mod.M_Cell.state[l][7] =-1.0; 
				Mod.M_Cell.state[l][8] =-1.0; 
				Mod.M_Cell.N_Dead = Mod.M_Cell.N_Dead+1;

	
			}


			if(Mod.M_Cell.state[l][1]>=1)
			{
				Mod.M_Cell.state[l][0] = Mod.M_Cell.state[l][0]+1;
			}

			/*if timer reaches the value then division*/
			if(Mod.M_Cell.state[l][0]==(float)(Mod.M_Cell.n_min))
			{

				divide(&Mod,l+1);
	
			}				
		}


		for(l=0;l<Mod.M_Cell.N_Cell;l++)
		{
			find_int(sz,l+1,Mod.M_Cell.Grid,&row,&col);
			if(((int)(Mod.M_Cell.state[l][7])!=row)||((int)(Mod.M_Cell.state[l][8])!=col))
			{
				printf("l308 .cell idx: %d \n\n",l+1);

				printf("state[%d][7]: %2.1f | row : %d \t  state[%d][8]: %2.1f | col : %d \n\n",l,Mod.M_Cell.state[l][7],row,l,Mod.M_Cell.state[l][8],col);

				printf("Grid[%d][%d] = %d | Grid[%d][%d] = %d \n\n",(int)(Mod.M_Cell.state[l][7]),(int)(Mod.M_Cell.state[l][8]),
				Mod.M_Cell.Grid[(int)(Mod.M_Cell.state[l][7])][(int)(Mod.M_Cell.state[l][8])],row,col,Mod.M_Cell.Grid[row][col]);
				/*for(i=0;i<sz;i++)
				{
					for(j=0;j<sz;j++)
					{
						printf("%d ",Mod.M_Cell.Grid[i][j]);
					}
					printf("\n");

				}
				printf("\n");*/
				for(i=0;i<Mod.M_Cell.N_Cell;i++)
				{
					printf("%d ",i+1);
					for(j=0;j<10;j++)
					{
						printf("%2.1f  ",Mod.M_Cell.state[i][j]);
					}
					printf("\n");

				}
				printf("\n");

				for(i=35-10;i<35+10;i++)
				{
					for(j=35-10;j<35+10;j++)
					{
						printf("%d ",Mod.M_Cell.Grid[i][j]);
					}
					printf("\n");

				}
				printf("\n");
			
				fwrite(&Mod,sizeof(Model),1,f);
				return;
			}
		}

		Mod.M_Cell.N_Live = Mod.M_Cell.N_Cell - Mod.M_Cell.N_Dead;

		if((n_pt%30)==0)
		{
			Mod.M_Cell.n_pts++;	
			printf("%d/%d\n",n_pt,N);
			printf("N_Cell: %d \t N_live : %d \t N_dead : %d\t max_rad_sq : %d  \n",Mod.M_Cell.N_Cell,Mod.M_Cell.N_Live,Mod.M_Cell.N_Dead,Mod.M_Cell.max_rad_sq);
			migrate_sphere(&Mod);
			behav(&Mod,behavior,kS_tissue,kO_tissue);
			

		}

		if((n_pt%120)==0)
		{
			fwrite(&Mod,sizeof(Model),1,f);
		}

		/*vérif décalage tableau/grille*/
		for(l=0;l<Mod.M_Cell.N_Cell;l++)
		{
			find_int(sz,l+1,Mod.M_Cell.Grid,&row,&col);
			if(((int)(Mod.M_Cell.state[l][7])!=row)||((int)(Mod.M_Cell.state[l][8])!=col))
			{
				printf("l316 .cell idx: %d \n\n",l+1);

				printf("state[%d][7]: %2.1f | row : %d \t  state[%d][8]: %2.1f | col : %d \n\n",l,Mod.M_Cell.state[l][7],row,l,Mod.M_Cell.state[l][8],col);

				printf("Grid[%d][%d] = %d | Grid[%d][%d] = %d \n\n",(int)(Mod.M_Cell.state[l][7]),(int)(Mod.M_Cell.state[l][8]),
				Mod.M_Cell.Grid[(int)(Mod.M_Cell.state[l][7])][(int)(Mod.M_Cell.state[l][8])],row,col,Mod.M_Cell.Grid[row][col]);
				/*for(i=0;i<sz;i++)
				{
					for(j=0;j<sz;j++)
					{
						printf("%d ",Mod.M_Cell.Grid[i][j]);
					}
					printf("\n");

				}
				printf("\n");*/
				for(i=0;i<Mod.M_Cell.N_Cell;i++)
				{
					printf("%d ",i+1);
					for(j=0;j<10;j++)
					{
						printf("%2.1f  ",Mod.M_Cell.state[i][j]);
					}
					printf("\n");

				}
				printf("\n");

				for(i=35-10;i<35+10;i++)
				{
					for(j=35-10;j<35+10;j++)
					{
						printf("%d ",Mod.M_Cell.Grid[i][j]);
					}
					printf("\n");

				}
				printf("\n");
			
				fwrite(&Mod,sizeof(Model),1,f);
				return;
			}
		}
		 
	}
	
	
	fclose(f);

	
}
