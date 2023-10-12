%This is the code/script that will serve as a basis for the metabolic variety family of model

%cleaning the workspace
clear all;
close all;
pkg load image%needed for the migration code

%conf Vector contains the values main parameters of the simulation
conf= [];

%declaration des paramètres à partir de conf %%%%%%%%%%%%
j=0;
% paramètres généraux
sz = conf(j+1) %size of the square domain in which the simulation is ran
n_min = conf(j+1); % simulated time in minutes
dx = conf(j+1);
dt = conf(j+1);

%paramètres métaboliques
kO_tissue = conf(j+1); %maxi value of consumption term for oxygen
kS_tissue = conf(j+1); %max value of consumption term for Substrate (consumed only)
kP_tissue = conf(j+1); % max value of consumption term for Product (produced/consumed)
cO =  conf(j+1); %Michaelis Menten constant for Oxygen hill function for cons.
cS = conf(j+1); %" constant for Substrate hill function for cons.
cP = conf(j+1); %" constant for Product hill function for /prod
DOx_tissue = conf(j+1); % oxygen diffusion constant in tissue
DS_tissue = conf(j+1); % Substrate diffusion constant in tissue
DP_tissue = conf(j+1); % Product diffusion constant in tissue

%Paramètres cellulaires
%n_cells0 = conf(j+1);
%pellet_size = conf(j+1);
%Diff_glu = conf(j+1);

%initialisation des matrices
%matrices de concentration
S = zeros(sz,sz); %substrate matrix
P = zeros(sz,sz); % product matrix
O = zeros(sz,sz); % oxygen matrix
kO = zeros(sz,sz); % oxygen consumption maatrix
kS = zeros(sz,sz); % Substrate consumption matrix
kP = zeros(sz,sz); % Product consumption matrix
Grid = zeros(sz,sz); % Grilles de gestions des cellules
%initialisation
Grid(round(sz/2),round(sz/2))=1; %cellule unique au centre au départ

%matrices de diffusion
DOm = ones(sz,sz);
DOm = 100000*DOm; %oxygen diffusion in water
DSm = ones(sz,sz);
DSm = 36000*DSm; %glucose diffusion in water
DPm = ones(sz,sz);
DPm = 45000*DPm; %lactate diffusion calculated with
%  33207661 : D = kB T / ( 6  pi  r eta_0) : both glucose and lactate calculated
% then lactate renormalised to be above glucose by 20% (ratio found with formula)

%initialisation
DSm(round(sz/2),round(sz/2))=DS_tissue;
DOm(round(sz/2),round(sz/2))=DOx_tissue;
DPm(round(sz/2),round(sz/2))=DP_tissue;

%cell state  1: cell time 2: cell cycle duration
state = [randi(1440) 1440]

while(size(sycle,1)<65) % loop to stop at a given size
	for k = 1:size(state,1)%for each cell check if it should divide

		%extracts cell position for the following function
		[r,c] = ind2sub([sz,sz],find(Grid==k))
		pos(1) = r; pos(2) = c;


		[Grid,kO,kS,kP,DSm,DOm,DPm,state] = divide2D_metvar(Grid,pos,k,sz,S,P,O,sycle,kO,kS,kP,kO_tissue,kS_tissue,kP_tissue,DOm,DSm,DPm);

		Grid
		grid_stable = 0;
		prev_Grid =  Grid;
		for j = 1:24
			j

		%migration reshapes the agregate
			prev_Grid = Grid;
			if(grid_stable==0)
				[Grid,kO,kG,DG,sycle] = migrate2D_sphere_ctr2(Grid,sz,G,O,sycle,kO,kG,kO_tissue,kG_tissue,DG,DG_tissue);
				%isokay2  = find(((Grid!=0)==(D!=0))==0)
				if(Grid==prev_Grid)
					grid_stable=1;%skip migration
					disp('grid stable')
				endif
			endif
		endfor
	endfor

	imagesc(Grid!=0)
	waitforbuttonpress

	endfor
endwhile

