/* Implémentation 170324 test lecture/écriture et construction de structures*/
/*new implementation with only a column of cells*/
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

Model Mod;

/*normal function for homogeneous sphere calculation*/	
int metvar_f(float kS, float kO ,char* file, float behav_code)
{

	printf("metvar \n");
	float kO_tissue = kO;
	float kS_tissue = kS;
	int sz = SZ;
	int row, col;
	int n_pt =0;
	int N=24000;
	int rad_sq=0;
	float DS_t,DO_t;
	clock_t start, end;



	Model Mod_r;
	/*Model Mod_save[200];*/	
	
	int i=0,j=0,k=0,l=0,m=0,n=0,o=0;
	FILE *f;
	FILE *f2; 

	start = clock();

	Mod.M_Nutr.DS_med = 0.2;
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
	DS_t = 0.035;DO_t = 0.6;
	Mod.M_Nutr.dx = 20.0;
	Mod.M_Nutr.d0 = 20.0;
	Mod.M_Nutr.dt = (0.95*Mod.M_Nutr.dx*Mod.M_Nutr.dx)/(2.0*200000.0);
	Mod.M_Nutr.tau = Mod.M_Nutr.d0*Mod.M_Nutr.d0/200000.0;
	/*Mod.M_Nutr.cS = 0.02;
	Mod.M_Nutr.cO = 0.2;*/	
	Mod.M_Cell.S_prol = 0.5;
	Mod.M_Cell.S_maint = 0.1;
	Mod.M_Cell.O_norm = 0.2;
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
	Mod.M_Nutr.DSm[sz/2-1][sz/2-1] = DS_t;
	Mod.M_Nutr.DOm[sz/2-1][sz/2-1] = DO_t;
	Mod.M_Nutr.sz = sz;

	Mod.M_Cell.state[0][0] = 10.0; /*divison timer*/
	Mod.M_Cell.state[0][1] = 1500.0; /*proliferation index*/
	Mod.M_Cell.state[0][2] = 0.0; /*Timer for state change*/
	Mod.M_Cell.state[0][3] = kS; /*Substrate consumption*/
	Mod.M_Cell.state[0][4] = 0.0; /*Substrate consumption*/
	Mod.M_Cell.state[0][5] = kO; /*Oxygen consumption*/
	Mod.M_Cell.state[0][6] = 0.0; /*Oxygen cons evolution*/
	Mod.M_Cell.state[0][7] = (float)(sz/2-1); /*row*/
	Mod.M_Cell.state[0][8] = (float)(sz/2-1); /*column*/
	Mod.M_Cell.state[0][9] = 0.0; /*parent*/
	Mod.M_Cell.state[0][10] = behav_code; /*behav code*/


	printf("initial Grid: \n");

	f = fopen(file,"a+");

	


	for(k=1;k<16;k++)
	{

		/*divide at the site previously extracted*/
		divide(k);

		
		/*do a migration round*/
		migrate_sphere();
		


	}

	for(k=0;k<32;k++)
	{
		for(j=0;j<11;j++)
		{
			printf("%3.2f ",Mod.M_Cell.state[k][j]);
		}
		printf("\n");	
	}

	
	printf("init: done\n");
	
	behav(kS_tissue,kO_tissue);


	/*randomizing cell timers*/
	for(i=0;i<Mod.M_Cell.N_Cell;i++)
	{
		Mod.M_Cell.state[i][0] = (float)((rand() % 
		(Mod.M_Cell.n_min - 0 + 1)) + 0);

	}

	while(n_pt<N&&Mod.M_Cell.max_rad_sq<=25*25)
	{
	
		n_pt++;

		diff_metvar();
		

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
					Mod.M_Nutr.DSm[(int)(Mod.M_Cell.state[l][7])][(int)(Mod.M_Cell.state[l][8])] = Mod.M_Nutr.DSm[(int)(Mod.M_Cell.state[l][7])][(int)(Mod.M_Cell.state[l][8])]  + (Mod.M_Nutr.DS_med-0.035)/(Mod.M_Cell.reac_time/3.0);
					Mod.M_Nutr.DOm[(int)(Mod.M_Cell.state[l][7])][(int)(Mod.M_Cell.state[l][8])] = Mod.M_Nutr.DOm[(int)(Mod.M_Cell.state[l][7])][(int)(Mod.M_Cell.state[l][8])] + (1.0-0.6)/(Mod.M_Cell.reac_time/3.0);				
				}			

			}


			/*update nutrients map*/
			Mod.M_Nutr.kS[(int)(Mod.M_Cell.state[l][7])][(int)(Mod.M_Cell.state[l][8])]=Mod.M_Cell.state[l][3];
			Mod.M_Nutr.kO[(int)(Mod.M_Cell.state[l][7])][(int)(Mod.M_Cell.state[l][8])]=Mod.M_Cell.state[l][5];


			if(Mod.M_Cell.state[l][2]<0.1&&Mod.M_Cell.state[l][7]!=-1.0&&Mod.M_Cell.LD[(int)(Mod.M_Cell.state[l][7])][(int)(Mod.M_Cell.state[l][8])]==-1)
			{
				Mod.M_Cell.Grid[(int)(Mod.M_Cell.state[l][7])][(int)(Mod.M_Cell.state[l][8])] = 0;				
				Mod.M_Nutr.kS[(int)(Mod.M_Cell.state[l][7])][(int)(Mod.M_Cell.state[l][8])] = 0.0;				
				Mod.M_Nutr.kO[(int)(Mod.M_Cell.state[l][7])][(int)(Mod.M_Cell.state[l][8])]= 0.0;
				Mod.M_Nutr.DSm[(int)(Mod.M_Cell.state[l][7])][(int)(Mod.M_Cell.state[l][8])] = Mod.M_Nutr.DS_med;				
				Mod.M_Nutr.DOm[(int)(Mod.M_Cell.state[l][7])][(int)(Mod.M_Cell.state[l][8])] = 1.0;
				Mod.M_Cell.state_mat[(int)(Mod.M_Cell.state[l][7])][(int)(Mod.M_Cell.state[l][8])] = 0.0;
				Mod.M_Cell.state[l][1]=0.0;
				Mod.M_Cell.state[l][7] =-1.0; 
				Mod.M_Cell.state[l][8] =-1.0; 
				Mod.M_Cell.N_Dead = Mod.M_Cell.N_Dead+1;

	
			}


			if(Mod.M_Cell.state[l][1]>=1.0)
			{
				Mod.M_Cell.state[l][0] = Mod.M_Cell.state[l][0]+1;
			}

			/*if timer reaches the value then division*/
			if(Mod.M_Cell.state[l][0]>=Mod.M_Cell.state[l][1]&&Mod.M_Cell.state[l][1]>=1.0)
			{
					divide_s(l+1);
	
			}				
		}


		Mod.M_Cell.N_Live = Mod.M_Cell.N_Cell - Mod.M_Cell.N_Dead;

		if((n_pt%30)==0)
		{
				
			printf("%d/%d\n",n_pt,N);
			printf("N_Cell: %d \t N_live : %d \t N_dead : %d\t max_rad_sq : %d \t S_ctr: %3.2f  \n",Mod.M_Cell.N_Cell,Mod.M_Cell.N_Live,Mod.M_Cell.N_Dead,Mod.M_Cell.max_rad_sq,Mod.M_Nutr.S[sz/2-1][sz/2-1]);
			/*migrate_sphere();*/
			behav(kS_tissue,kO_tissue);
			

		}

		if((n_pt%120)==0)
		{
			Mod.M_Cell.n_pts++;
			fwrite(&Mod,sizeof(Model),1,f);
		}

		/*vérif décalage tableau/grille*/
		
		 
	}
	
	
	fclose(f);

	
}

/*the chip function for homogeneous model*/
int metvar_c(float kS, float kO ,char* file, float behav_code)
{

	printf("metvar \n");
	float kO_tissue = kO;
	float kS_tissue = kS;
	int sz = SZ;
	int row, col;
	int n_pt =0;
	int N=6000;
	int rad_sq=0;
	int rad_pellet=150;
	int row_free[22500];
	int col_free[22500];
	int N_free = 0;
	int N_cell_init = 2860;
	int site;
	clock_t start, end;

	
	srand(time(0));

	/*Model Mod_save[200];*/	
	
	int i=0,j=0,k=0,l=0,m=0,n=0;
	FILE *f;
	FILE *f2; 
	
	start = clock();

	Mod.M_Nutr.DS_med = 0.3;
	Mod.M_Nutr.DS_mat = 0.25;
	Mod.M_Nutr.DO_mat = 0.9;
	/*Initialisation des matrices*/
	for(k=0;k<22500;k++)
	{
		row_free[k];
		col_free[k];
	}	

	for (i=0; i<sz; i++)
	{
		for (j=0; j<sz; j++)
		{
			rad_sq = (i-(sz/2-1))*(i-(sz/2-1))+(j-(sz/2-1))*(j-(sz/2-1));
			Mod.M_Nutr.S[i][j] = 1.0;
			Mod.M_Nutr.O[i][j] = 1.0;
			Mod.M_Nutr.kS[i][j] = 0.0;
			Mod.M_Nutr.kO[i][j] = 0.0;
			Mod.M_Nutr.DSm[i][j] = Mod.M_Nutr.DS_med;
			Mod.M_Nutr.DOm[i][j] = 1.0;
			Mod.M_Cell.Grid[i][j] = -1;/*sites outside the pellets are negative*/
			if(rad_sq<=rad_pellet*rad_pellet)
			{
				Mod.M_Nutr.DSm[i][j] = Mod.M_Nutr.DS_mat;
				Mod.M_Nutr.DOm[i][j] = Mod.M_Nutr.DO_mat;
				Mod.M_Cell.Grid[i][j] = 0;
				
			}
			Mod.M_Cell.LD[i][j] = 0;
			Mod.M_Cell.state_mat[i][j] = 0;
		}
	}
	

	
	for (i=0; i<(sz*sz); i++)
	{
		for (j=0; j<11; j++)
		{
			Mod.M_Cell.state[i][j] = 0.0;
		}
	}


	
	/*first cell is placed on the grid*/
	Mod.M_Nutr.DS_tiss = 0.035;
	Mod.M_Nutr.DO_tiss = 0.6;

	Mod.M_Nutr.dx = 20.0;
	Mod.M_Nutr.d0 = 20.0;
	Mod.M_Nutr.dt = (0.95*Mod.M_Nutr.dx*Mod.M_Nutr.dx)/(400000.0);
	Mod.M_Nutr.tau = Mod.M_Nutr.d0*Mod.M_Nutr.d0/(200000.0);
	Mod.M_Cell.S_prol = 0.5;
	Mod.M_Cell.S_maint = 0.1;
	Mod.M_Cell.O_norm = 0.2;
	Mod.M_Cell.N_Dead = 0;
	Mod.M_Cell.n_pts=0;
	Mod.M_Cell.max_rad_sq=0;
	Mod.M_Cell.reac_time = 60;
	Mod.M_Cell.n_min = 1500;
	Mod.M_Cell.N_Cell = 0;


	printf("initial Grid: \n");

	
	

	/*open sites storage*/
	for(i=sz/2-rad_pellet;i<(sz/2)+rad_pellet;i=i+2)
	{
		for(j=(sz/2)-rad_pellet;j<(sz/2)+rad_pellet;j=j+2)
		{
			/*radius calculation*/
			rad_sq = (i-(sz/2-1))*(i-(sz/2-1))+(j-(sz/2-1))*(j-(sz/2-1));
			
			if(rad_sq<=rad_pellet*rad_pellet)
			{
				row_free[N_free]=  i;
				col_free[N_free]=  j;
				N_free++;
			}
		}
	
	}
	
	
	/*random cell placement*/
	for(n=0;n<N_cell_init;n++)
	{
		
		/*choose a site*/
		site = (rand() % ((N_free-1) - 0 + 1)) + 0;
		
		printf("n: %d \t site: %d \n",n,site);
		
		if(Mod.M_Cell.Grid[row_free[site]][col_free[site]]!=0)
		{
			n=n-1;
		}
		
		if(Mod.M_Cell.Grid[row_free[site]][col_free[site]]==0)
		{
			Mod.M_Cell.Grid[row_free[site]][col_free[site]] = n+1;
			Mod.M_Cell.LD[row_free[site]][col_free[site]] = 1;
			Mod.M_Nutr.kS[row_free[site]][col_free[site]] = kS;
			Mod.M_Nutr.kO[row_free[site]][col_free[site]] = kO;
			Mod.M_Nutr.DSm[row_free[site]][col_free[site]] = Mod.M_Nutr.DS_tiss;
			Mod.M_Nutr.DOm[row_free[site]][col_free[site]] = Mod.M_Nutr.DO_tiss;
			Mod.M_Cell.state_mat[row_free[site]][col_free[site]] = 5;
			Mod.M_Cell.state[n][0] = 10.0; /*divison timer*/
			Mod.M_Cell.state[n][1] = 1500.0; /*proliferation index*/
			Mod.M_Cell.state[n][2] = 0.0; /*Timer for state change*/
			Mod.M_Cell.state[n][3] = kS; /*Substrate consumption*/
			Mod.M_Cell.state[n][4] = 0.0; /*Substrate consumption*/
			Mod.M_Cell.state[n][5] = kO; /*Oxygen consumption*/
			Mod.M_Cell.state[n][6] = 0.0; /*Oxygen cons evolution*/
			Mod.M_Cell.state[n][7] = (float)(row_free[site]); /*row*/
			Mod.M_Cell.state[n][8] = (float)(col_free[site]); /*column*/
			Mod.M_Cell.state[n][9] = 0.0; /*parent*/
			Mod.M_Cell.state[n][10] = behav_code; /*parent*/
			Mod.M_Cell.N_Cell++; 
		}
		


	}
	
	/*Grid_check();*/

	
	
	printf("init: done\n");
	
	behav(kS_tissue,kO_tissue);

	f = fopen(file,"a+");
	fwrite(&Mod,sizeof(Model),1,f);
	/*randomizing cell timers*/
	for(i=0;i<Mod.M_Cell.N_Cell;i++)
	{
		Mod.M_Cell.state[i][0] = (float)((rand() % 
		(Mod.M_Cell.n_min - 0 + 1)) + 0);

	}

	/*each point is a minute*/
	while(n_pt<N)/*&&Mod.M_Cell.max_rad_sq<=25*25)*/
	{
		
		n_pt++;

		diff_chip(rad_pellet);
		

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

				if(Mod.M_Cell.LD[(int)(Mod.M_Cell.state[l][7])][(int)(Mod.M_Cell.state[l][8])]==-1)
				{
					Mod.M_Nutr.DSm[(int)(Mod.M_Cell.state[l][7])][(int)(Mod.M_Cell.state[l][8])] = Mod.M_Nutr.DSm[(int)(Mod.M_Cell.state[l][7])][(int)(Mod.M_Cell.state[l][8])]  + (Mod.M_Nutr.DS_med-Mod.M_Nutr.DS_tiss)/(4.0*Mod.M_Cell.reac_time);
					Mod.M_Nutr.DOm[(int)(Mod.M_Cell.state[l][7])][(int)(Mod.M_Cell.state[l][8])] = Mod.M_Nutr.DOm[(int)(Mod.M_Cell.state[l][7])][(int)(Mod.M_Cell.state[l][8])]  + (1.0-Mod.M_Nutr.DO_tiss)/(4.0*Mod.M_Cell.reac_time);				
				}			

			}


			/*update nutrients map*/
			Mod.M_Nutr.kS[(int)(Mod.M_Cell.state[l][7])][(int)(Mod.M_Cell.state[l][8])]=Mod.M_Cell.state[l][3];
			Mod.M_Nutr.kO[(int)(Mod.M_Cell.state[l][7])][(int)(Mod.M_Cell.state[l][8])]=Mod.M_Cell.state[l][5];

			/*cell death*/
			if(Mod.M_Cell.state[l][2]<0.1&&Mod.M_Cell.state[l][7]!=-1.0&&Mod.M_Cell.LD[(int)(Mod.M_Cell.state[l][7])][(int)(Mod.M_Cell.state[l][8])]==-1)
			{
				Mod.M_Cell.Grid[(int)(Mod.M_Cell.state[l][7])][(int)(Mod.M_Cell.state[l][8])] = 0;				
				Mod.M_Nutr.kS[(int)(Mod.M_Cell.state[l][7])][(int)(Mod.M_Cell.state[l][8])] = 0.000;				
				Mod.M_Nutr.kO[(int)(Mod.M_Cell.state[l][7])][(int)(Mod.M_Cell.state[l][8])] = 0.000;
				Mod.M_Nutr.DSm[(int)(Mod.M_Cell.state[l][7])][(int)(Mod.M_Cell.state[l][8])] = 0.5*Mod.M_Nutr.DS_med;				
				Mod.M_Nutr.DOm[(int)(Mod.M_Cell.state[l][7])][(int)(Mod.M_Cell.state[l][8])] = 1.0;
				Mod.M_Cell.state_mat[(int)(Mod.M_Cell.state[l][7])][(int)(Mod.M_Cell.state[l][8])] = 0;
				Mod.M_Cell.state[l][1]=0.0;
				Mod.M_Cell.state[l][7] =-1.0; 
				Mod.M_Cell.state[l][8] =-1.0; 
				Mod.M_Cell.N_Dead = Mod.M_Cell.N_Dead+1;
	
				/*if(Grid_check()==1)
				{
					printf("254\n");
					return -1;
				}*/	

	
			}


			if(Mod.M_Cell.state[l][1]>=1.0)
			{
				Mod.M_Cell.state[l][0] = Mod.M_Cell.state[l][0]+1;
			}

			/*if timer reaches the value then division*/
			if((Mod.M_Cell.state[l][0]>=Mod.M_Cell.state[l][1])&&Mod.M_Cell.state[l][1]>=1.0)
			{
	
					divide_s(l+1);
					/*if(Grid_check()==1)
					{
						printf("274\n");
						return -1;
					}*/
	
			}
			
			if((n_pt%30)==0&&Mod.M_Cell.state[l][1]>=1.0)
			{
				migrate_chip2(l);
			}				
		}



		Mod.M_Cell.N_Live = Mod.M_Cell.N_Cell - Mod.M_Cell.N_Dead;

		if((n_pt%30)==0)
		{
			Mod.M_Cell.n_pts++;	
			printf("%d/%d\n",n_pt,N);
			printf("N_Cell: %d \t N_live : %d \t N_dead : %d\t max_rad_sq : %d \t S_ctr: %3.2f  \n",Mod.M_Cell.N_Cell,Mod.M_Cell.N_Live,Mod.M_Cell.N_Dead,Mod.M_Cell.max_rad_sq,Mod.M_Nutr.S[sz/2-1][sz/2-1]);
			end = clock();
			double time_taken = (double)(end - start) / (double)(CLOCKS_PER_SEC);
	    		printf("Time taken is : %3.2lf sec \n",time_taken); 
			/*migrate_chip();*/
			behav(kS_tissue,kO_tissue);
			/*if(Grid_check()==1)
			{
				printf("297\n");
				return -1;
			}*/
			

		}

		if((n_pt%120)==0)
		{
			fwrite(&Mod,sizeof(Model),1,f);
		}

		
		 
	}
	
	
	fclose(f);

	
}
