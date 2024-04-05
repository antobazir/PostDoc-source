#include <string.h>
#include <math.h>
#include "structdef.h"
#include <stdio.h>

void main(int argc, char* argv[])
{

	/*int i;
	char buf[20];

	for (i = 0; i < 100; i++) 
	{
	sprintf(buf, "pre_%d_suff", i); /*puts string into buffer*/
	/*printf("%s\n", buf); /* outputs so you can see it*/
	/*}*/

	int i,j,l,k;
	char folder[40]; 
	char path_r[100] = "/home/antonybazir/Documents/Post-doc/metabolic_variety_c/results/starv/Id";
	char path_f[100] = "/home/antonybazir/Documents/Post-doc/metabolic_variety_c/plots/";
	char path_cpy[100];
	
	FILE *f;
	FILE *f2;
	Model Mod;
	
	f = fopen(path_r,"r+");
	

	for(l=0;l<100;l++)
	{
		strcpy(path_cpy,path_f);
		sprintf(folder, "starv/Grid/Id%d.dat", l);
		strcat(path_cpy,folder); 
		printf("%s \n",path_cpy);
		fread(&Mod,sizeof(Model),1,f);
		f2 = fopen(path_cpy,"w");
		for(i=0;i<Mod.M_Nutr.sz;i++)
		{
			for(j=0;j<Mod.M_Nutr.sz;j++)
			{
				fprintf(f2,"%d ",Mod.M_Cell.Grid[i][j]);
			}
			fprintf(f2,"\n");
		}
		printf("\n");
		
	}
	fclose(f);
	
	f = fopen(path_r,"r+");
	for(l=0;l<100;l++)
	{
		strcpy(path_cpy,path_f);
		sprintf(folder, "starv/LD/Id%d.dat", l);
		strcat(path_cpy,folder); 
		printf("%s \n",path_cpy);
		fread(&Mod,sizeof(Model),1,f);
		f2 = fopen(path_cpy,"w");
		for(i=0;i<Mod.M_Nutr.sz;i++)
		{
			for(j=0;j<Mod.M_Nutr.sz;j++)
			{
				fprintf(f2,"%d ",Mod.M_Cell.LD[i][j]);
			}
			fprintf(f2,"\n");
		}
		printf("\n");
		
	}
	fclose(f);
	
	f = fopen(path_r,"r+");
	for(l=0;l<100;l++)
	{
		strcpy(path_cpy,path_f);
		sprintf(folder, "starv/S/Id%d.dat", l);
		strcat(path_cpy,folder); 
		printf("%s \n",path_cpy);
		fread(&Mod,sizeof(Model),1,f);
		f2 = fopen(path_cpy,"w");
		for(i=0;i<Mod.M_Nutr.sz;i++)
		{
			for(j=0;j<Mod.M_Nutr.sz;j++)
			{
				fprintf(f2,"%3.2f ",Mod.M_Nutr.S[i][j]);
			}
			fprintf(f2,"\n");
		}
		printf("\n");
		
	}
	fclose(f);	
	
	f = fopen(path_r,"r+");
	for(l=0;l<100;l++)
	{
		strcpy(path_cpy,path_f);
		sprintf(folder, "starv/kS/Id%d.dat", l);
		strcat(path_cpy,folder); 
		printf("%s \n",path_cpy);
		fread(&Mod,sizeof(Model),1,f);
		f2 = fopen(path_cpy,"w");
		for(i=0;i<Mod.M_Nutr.sz;i++)
		{
			for(j=0;j<Mod.M_Nutr.sz;j++)
			{
				fprintf(f2,"%3.2f ",Mod.M_Nutr.kS[i][j]);
			}
			fprintf(f2,"\n");
		}
		printf("\n");
		
	}
	fclose(f);	
	

	f = fopen(path_r,"r+");
	for(l=0;l<100;l++)
	{
		strcpy(path_cpy,path_f);
		sprintf(folder, "starv/state/Id%d.dat", l);
		strcat(path_cpy,folder); 
		printf("%s \n",path_cpy);
		fread(&Mod,sizeof(Model),1,f);
		f2 = fopen(path_cpy,"w");
		for(i=0;i<Mod.M_Cell.N_Cell;i++)
		{
			fprintf(f2,"%d ",i+1);
			for(j=0;j<10;j++)
			{
				fprintf(f2,"%3.2f ",Mod.M_Cell.state[i][j]);
			}
			fprintf(f2,"\n");
		}
		printf("\n");
		
	}
	fclose(f);	

}  
