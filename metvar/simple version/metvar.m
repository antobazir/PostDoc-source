%This is the code/script that will serve as a basis for the metabolic variety family of model

%cleaning the workspace
clear all;
close all;
pkg load image%needed for the migration code

%conf Vector contains the values main parameters of the simulation
%conf= [40 3000 200 4e-3 ... %param gén
% 200 4e-3 0.3 0.36 ... %lol
% 0 0 0.1 ... % consos
% 100 1 1 ... % michael menten constant of the hill function
% 0.9 0.03 0.04]; % diffusion in tissue all scaled w/ oxygen in water

%declaration des paramètres à partir de conf %%%%%%%%%%%%
j=0;
% paramètres généraux
sz = 200; %conf(j+1); j++; %size of the square domain in which the simulation is ran
n_min = 15; %conf(j+1);j++; % simulated time in minutes
dx = 20; %conf(j+1);j++;
dt =  4e-4;%conf(j+1);j++;

%paramètres diffusion
d0 = 20;%conf(j+1);j++;
tau = 4e-3;%j++; % characteristic diff time in minues
DS_med = 0.3%conf(j+1);j++;
DP_med = 0.4%conf(j+1);j++;

%paramètres métaboliques
%consumption
kO_tissue = 0.8%conf(j+1);j++; %maxi value of consumption term for oxygen
kS_tissue = 0.2%conf(j+1);j++; %max value of consumption term for Substrate (consumed only)
kS_tissue_maint = 0.05%conf(j+1);j++; %max value of consumption term for Substrate (consumed only)
kP_tissue = 0.1 %conf(j+1);j++; % max value of consumption term for Product (produced/consumed)
cO =  0.001%conf(j+1);j++; %Michaelis Menten constant for Oxygen hill function for cons.
cS = 0.01%conf(j+1);j++; %" constant for Substrate hill function for cons.
cP = 0.001%conf(j+1);j++; %" constant for Product hill function for /prod
DOx_tissue = 0.6%conf(j+1); j++;% oxygen diffusion constant in tissue
DS_tissue = 0.06%conf(j+1);j++; % Substrate diffusion constant in tissue
DP_tissue = 0.04%conf(j+1);j++; % Product diffusion constant in tissue
S_prol = 0.4 % 40 % of ext value needed to proliferate.
S_maint = 0.1 % 40 % of ext value needed to proliferate.

%Paramètres cellulaires
%n_cells0 = conf(j+1);
%pellet_size = conf(j+1);
%Diff_glu = conf(j+1);

%initialisation des matrices
%matrices de concentration
S = ones(sz,sz); %substrate matrix
P = zeros(sz,sz); % product matrix
O = ones(sz,sz); % oxygen matrix
kO = zeros(sz,sz); % oxygen consumption maatrix
kS = zeros(sz,sz); % Substrate consumption matrix
kP = zeros(sz,sz); % Product consumption matrix
Grid = zeros(sz,sz); % Grilles de gestions des cellules
%initialisation
Grid(round(sz/2),round(sz/2))=1; %cellule unique au centre au départ

%matrices de diffusion
DOm = ones(sz,sz); %oxygen diffusion in medium is the ref
DSm = DS_med*ones(sz,sz); %glucose diffusion in water
DPm = DP_med*ones(sz,sz); %product is supposed to be smaller chains so it's higher
%  33207661 : D = kB T / ( 6  pi  r eta_0) : both glucose and lactate calculated
% then lactate renormalised to be above glucose by 20% (ratio found with formula)

%initialisation64
kS(round(sz/2),round(sz/2)) = kS_tissue;
kO(round(sz/2),round(sz/2)) = kO_tissue;
DSm(round(sz/2),round(sz/2))=DS_tissue;
DOm(round(sz/2),round(sz/2))=DOx_tissue;
DPm(round(sz/2),round(sz/2))=DP_tissue;

%cell state  1: cell time 2: cell cycle duration
state = [randi(1440) 1440];
l=1
	figure;
	figure;
	figure;
	figure;
while(size(state,1)<2048) % loop to stop at a given size

	div =0
	for k = 1:size(state,1)%for each cell check if it should divide

##		%BEHAVIOR DETERMINATION%%%%%%%%
##		%substrate
##		if(S(find(Grid==k))>=S_prol)
##			kS(find(Grid==k))=kS_tissue;
##		elseif(S(find(Grid==k))<S_prol&&S(find(Grid==k))>=S_maint)
##			kS(find(Grid==k))=kS_tissue_maint;
##		else
##			kS(find(Grid==k))=0;
##		endif


		%DIVISION ROUTINE%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
		[r,c] = ind2sub([sz,sz],find(Grid==k));
		pos(1) = r; pos(2) = c;

		if(kS(find(Grid==k))==kS_tissue)
			div++;
			%pos
			[Grid,kO,kS,kP,DSm,DOm,DPm,state] = divide2D_metvar(Grid,pos,k,sz,S,P,O,state,kO,kS,kP,kO_tissue,kS_tissue,kP_tissue,DOm,DSm,DPm,DOx_tissue,DS_tissue,DP_tissue);
		endif



##		% if the cell has reached division time then divide
##		if(state(k,1)>=state(k,2))
##			%extracts cell position for the following function
##			[r,c] = ind2sub([sz,sz],find(Grid==k))
##			pos(1) = r; pos(2) = c;
##
##			%division function
##			[Grid,kO,kS,kP,DSm,DOm,DPm,state] = divide2D_metvar(Grid,pos,k,sz,S,P,O,state,kO,kS,kP,kO_tissue,kS_tissue,kP_tissue,DOm,DSm,DPm,DOx_tissue,DS_tissue,DP_tissue);
##		endif


		Grid;
		grid_stable = 0;
		prev_Grid =  Grid;

##		%MIGRATION ROUTINE%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
##		%migration moves the cell to favor sphericity
##		prev_Grid = Grid;
##		if(grid_stable==0)
##			[Grid,kO,kS,kP,DSm,DOm,DPm,state] = migrate2D_sphere_metvar(Grid,pos,k,sz,S,P,O,state,kO,kS,kP,kO_tissue,kS_tissue,kP_tissue,DOm,DSm,DPm,DOx_tissue,DS_tissue,DP_tissue);
##			%isokay2  = find(((Grid!=0)==(D!=0))==0)
##			if(Grid==prev_Grid)
##				grid_stable=1;%skip migration
##				disp('grid stable')
##			endif
##		endif


	endfor
	div
	%MIGRATION ROUTINE%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	%migration moves the cell to favor sphericity
	prev_Grid = Grid;
	if(grid_stable==0)
		[Grid,kO,kS,kP,DSm,DOm,DPm,state] = migrate2D_sphere_metvar(Grid,pos,k,sz,S,P,O,state,kO,kS,kP,kO_tissue,kS_tissue,kP_tissue,DOm,DSm,DPm,DOx_tissue,DS_tissue,DP_tissue);
		%isokay2  = find(((Grid!=0)==(D!=0))==0)
		if(Grid==prev_Grid)
			grid_stable=1;%skip migration
			disp('grid stable')
		endif
	endif

	ntime = n_min/dt;
	%ntime = 10;
	%Slol(:,:,l)= S;l++
	[S,kS,DSm,St] = update_metvar(S,kS,cS,DSm,d0,tau,ntime,dx,dt);
##	[P,kP,DPm] = update_metvar(P,kP,DPm,ntime,dx,dt)
	[O,kO,DOm,Ot] = update_metvar(O,kO,cO,DOm,d0,tau,ntime,dx,dt);

		%BEHAVIOR DETERMINATION%%%%%%%%
	kS(find(and(S>=S_prol,Grid!=0)))=kS_tissue;
	kS(find(and(S<S_prol,S>=S_maint,Grid!=0)))=kS_tissue_maint;
	kS(find(and(S<S_maint,Grid!=0)))=0;

	%imagesc(Grid!=0)

	figure 1
	imagesc(S)
	caxis([0 1])
	colorbar
	figure 2
	imagesc(O)
	caxis([0 1])
	colorbar
	figure 3
	imagesc(Grid!=0)
	figure 4
	imagesc(kS)
	%waitforbuttonpress


endwhile



