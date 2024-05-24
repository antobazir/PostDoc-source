#include <string.h>
#include <math.h>
#include "structdef.h"
#include <stdio.h>
#include <stdlib.h>
#include <sys/stat.h>

void analysis(char* folder)
{


	int i,j,l,k,m;
	char suffix[6]; 
	char f_cpy[20];
	char exp[4];
	char path_r[100] ;
	char path_f[100] = "../plots/";
	char path_cpy[100], pc2[100], pc3[100], pc4[100],pc5[100], pc6[100], pc7[100], pc8[100], pc9[100], pc10[100], pc11[100], pc12[100], pc13[100],pc14[100],pc15[100],pc16[100];
	
	FILE *f;
	FILE *f2, *f3, *f4, *f5, *f6, *f7, *f8, *f9, *f10, *f11, *f12, *f13, *f14, *f15, *f16;
	Model *Mod;
	
	

	for(m=1;m<=3;m++)
	{
		strcpy(path_r,"../results/");		
		strcat(path_r,folder);
		strcpy(path_cpy,path_r);
		


		switch(m)
		{
			case 1:	
				strcpy(exp,"/Id");
				break;	
	
			case 2:			
				strcpy(exp,"/Gl");
				break;

			case 3:			
				strcpy(exp,"/Ox");
				break;

		}
		strcat(path_cpy,exp);
		printf("%s \n",path_cpy);
		Mod = (Model*) malloc (sizeof (Model));

		if(fopen(path_cpy,"r+")!=0)
		{
			f = fopen(path_cpy,"r+");
			l=0;
			
			strcpy(path_cpy,path_f);
			strcat(path_cpy,folder);
			mkdir(path_cpy,0755);
			printf("%s \n",path_cpy);
			strcpy(pc4,path_cpy);
			strcat(pc4,"/S_center"); 
			mkdir(pc4, 0755 );
			strcat(pc4,exp);strcat(pc4,".dat");
			strcpy(pc5,path_cpy);
			strcat(pc5,"/Numbers"); 
			mkdir(pc5, 0755 );
			strcat(pc5,exp);strcat(pc5,".dat");
			strcpy(pc6,path_cpy);
			strcat(pc6,"/O_center"); 
			mkdir(pc6, 0755 );
			strcat(pc6,exp);strcat(pc6,".dat");
			f4 =fopen(pc4,"w");
			f5 =fopen(pc5,"w");
			f6 =fopen(pc6,"w");



			while(! feof( f ))
			{

				printf("%d \n",l);
				strcpy(pc2,path_cpy);/*Grid*/
				strcat(pc2,"/Grid"); 
				mkdir(pc2, 0755 );
				strcat(pc2,exp);
				strcpy(pc3,path_cpy);/*S*/
				strcat(pc3,"/S"); 
				mkdir(pc3, 0755 );
				strcat(pc3,exp);
				strcpy(pc10,path_cpy);/*O*/
				strcat(pc10,"/O"); 
				mkdir(pc10, 0755 );
				strcat(pc10,exp);
				strcpy(pc11,path_cpy);/*state*/
				strcat(pc11,"/state"); 
				mkdir(pc11, 0755 );
				strcat(pc11,exp);
				strcpy(pc12,path_cpy);/*state*/
				strcat(pc12,"/LD"); 
				mkdir(pc12, 0755 );
				strcat(pc12,exp);
				strcpy(pc13,path_cpy);/*state*/
				strcat(pc13,"/DSm"); 
				mkdir(pc13, 0755 );
				strcat(pc13,exp);
				strcpy(pc14,path_cpy);/*state*/
				strcat(pc14,"/DOm"); 
				mkdir(pc14, 0755 );
				strcat(pc14,exp);
				strcpy(pc15,path_cpy);/*state*/
				strcat(pc15,"/kS"); 
				mkdir(pc15, 0755 );
				strcat(pc15,exp);
				strcpy(pc16,path_cpy);/*state*/
				strcat(pc16,"/kO"); 
				mkdir(pc16, 0755 );
				strcat(pc16,exp);
				strcpy(pc9,path_cpy);/*S*/
				strcat(pc9,"/state_mat"); 
				mkdir(pc9, 0755 );
				strcat(pc9,exp);
				strcpy(pc7,path_cpy);/*S_midline*/
				strcat(pc7,"/S_midline"); 
				mkdir(pc7, 0755 );
				strcat(pc7,exp);
				strcpy(pc8,path_cpy);/*O_midline*/
				strcat(pc8,"/O_midline"); 
				mkdir(pc8, 0755 );
				strcat(pc8,exp);

				sprintf(suffix, "%d.dat", l);
				strcat(pc2,suffix);strcat(pc3,suffix);strcat(pc7,suffix);strcat(pc8,suffix);strcat(pc9,suffix);strcat(pc10,suffix);strcat(pc11,suffix);strcat(pc12,suffix);strcat(pc13,suffix);strcat(pc14,suffix);strcat(pc15,suffix);strcat(pc16,suffix);	
				fread(Mod,sizeof(Model),1,f);
				printf("n_pts :%d\n",(*Mod).M_Cell.n_pts);
				printf("%s \n",pc2);
				printf("%s \n",pc3);
				printf("%s \n",pc9);
				printf("%s \n",pc14);
				f2 = fopen(pc2,"w"); f3 = fopen(pc3,"w");f7 = fopen(pc7,"w"); f8 = fopen(pc8,"w");f9 = fopen(pc9,"w");f10 = fopen(pc10,"w");f11 = fopen(pc11,"w");f12 = fopen(pc12,"w");f13 = fopen(pc13,"w");f14 = fopen(pc14,"w");f15 = fopen(pc15,"w");f16 = fopen(pc16,"w");

				if(f2!=NULL&&f3!=NULL&&f4!=NULL&&f5!=NULL)
				{
					for(i=0;i<(*Mod).M_Nutr.sz;i++)
					{
						for(j=0;j<(*Mod).M_Nutr.sz;j++)
						{

							if(i==(*Mod).M_Nutr.sz/2-1)
							{
								fprintf(f7,"%2.1f \t %3.2f \n",(j-((*Mod).M_Nutr.sz/2-1))*(*Mod).M_Nutr.dx,(*Mod).M_Nutr.S[i][j]);							
								fprintf(f8,"%2.1f \t %3.2f \n",(j-((*Mod).M_Nutr.sz/2-1))*(*Mod).M_Nutr.dx,(*Mod).M_Nutr.O[i][j]);
							}
							fprintf(f2,"%d ",(*Mod).M_Cell.Grid[i][j]);				
							fprintf(f3,"%3.2f ",(*Mod).M_Nutr.S[i][j]);
							fprintf(f10,"%3.2f ",(*Mod).M_Nutr.O[i][j]);
							fprintf(f9,"%d ",(*Mod).M_Cell.state_mat[i][j]);
							fprintf(f12,"%d ",(*Mod).M_Cell.LD[i][j]);
							fprintf(f13,"%3.2f ",(*Mod).M_Nutr.DSm[i][j]);
							fprintf(f14,"%3.2f ",(*Mod).M_Nutr.DOm[i][j]);
							fprintf(f15,"%3.2f ",(*Mod).M_Nutr.kS[i][j]);
							fprintf(f16,"%3.2f ",(*Mod).M_Nutr.kO[i][j]);
						}

						fprintf(f2,"\n");
						fprintf(f3,"\n");
						fprintf(f9,"\n");
						fprintf(f10,"\n");
						fprintf(f12,"\n");
						fprintf(f13,"\n");
						fprintf(f14,"\n");
						fprintf(f15,"\n");
						fprintf(f16,"\n");
						
					}
					fprintf(f4,"%d \t %3.2f \n",l*120,(*Mod).M_Nutr.S[(*Mod).M_Nutr.sz/2-1][(*Mod).M_Nutr.sz/2-1]);
					fprintf(f6,"%d \t %3.2f \n",l*120,(*Mod).M_Nutr.O[(*Mod).M_Nutr.sz/2-1][(*Mod).M_Nutr.sz/2-1]);
					fprintf(f5,"%d \t %d \t %d \t %d \t %d \n",l*120,(*Mod).M_Cell.N_Cell,(*Mod).M_Cell.N_Live,(*Mod).M_Cell.N_Dead,(*Mod).M_Cell.max_rad_sq);
					fclose(f2);fclose(f3);fclose(f7);fclose(f8);fclose(f9);fclose(f10);fclose(f12);fclose(f13);fclose(f14);fclose(f15);fclose(f16);
					
					for(i=0;i<(*Mod).M_Cell.N_Cell;i++)
					{
											for(k=0;k<10;k++)
						{
							fprintf(f11,"%3.2f ",(*Mod).M_Cell.state[i][k]);
						}
						fprintf(f11,"\n");
					}
					fclose(f11);
				}
				else 
				{
					if(f2==NULL)
					{
						printf("probleme f2: %s \n",pc2);
					}

					if(f3==NULL)
					{
						printf("probleme f3: %s \n",pc3);
					}

					if(f4==NULL)
					{
						printf("probleme f4: %s \n",pc4);
					}

					if(f5==NULL)
					{
						printf("probleme f5: %s \n",pc5);
					}
				}
				
				l++;

			}
			fclose(f);
			fclose(f4);fclose(f5);fclose(f6);

		}
	}
	return;
	
	

}  
