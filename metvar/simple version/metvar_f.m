## Copyright (C) 2023 Antony
##
## This program is free software: you can redistribute it and/or modify
## it under the terms of the GNU General Public License as published by
## the Free Software Foundation, either version 3 of the License, or
## (at your option) any later version.
##
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
##
## You should have received a copy of the GNU General Public License
## along with this program.  If not, see <https://www.gnu.org/licenses/>.

## -*- texinfo -*-
## @deftypefn {} {@var{retval} =} metvar_f (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: Antony <antony@antony-Lenovo-Yoga-S730-13IWL>
## Created: 2023-11-08

%08/11 This script is now turned into a function since only two parameters change for
% for each study. This makes it possible to use a script to generate the data
%15/11 on décale le Kine en diffusion APRES application de la mort cellulaire... à noter que ça peut décaler d'un cran la réponse
%09/12 On remplace update metvar par update metvar master pour le glucose car ça permet d'avoir une vraie condition de stabilité
%10/12 on calcule n_min à chaque boucle
function a = metvar_f (kO_arg, kS_arg, behavior, filename)

%declaration des paramètres à partir de conf %%%%%%%%%%%%
j=0;
% paramètres généraux
sz = 50; % 100  conf(j+1); j++; %size of the square domain in which the simulation is ran
%n_min = 100; %  15 conf(j+1);j++; % simulated time in minutes
dx = 60; % 20  conf(j+1);j++;
dt =  0.5*dx^2/(2*100000);%conf(j+1);j++; dt = 1.666e-2 par critère CFL
cell_diam = 20;
Radius_agg=0;

%paramètres diffusion
d0 = dx%conf(j+1);j++;
tau = d0^2/100000%j++; % characteristic diff time in minues
DS_med = 0.3%conf(j+1);j++;
DP_med = 0.4%conf(j+1);j++;
DK_med = 0.4%conf(j+1);j++;

%paramètres métaboliques %0.40 et 0.1 donne une abondance relative similaire dans l'agrégat
%consumption
kO_tissue = kO_arg%*(cell_diam^2)/(dx^2)%conf(j+1);j++; %maxi value of consumption term for oxygen
kO_maint = 0.3*kO_tissue%conf(j+1);j++; %maxi value of consumption term for oxygen
kS_tissue = kS_arg%*(cell_diam^2)/(dx^2)%conf(j+1);j++; %max value of consumption term for Substrate (consumed only)
kS_comp = 2*kS_tissue%conf(j+1);j++; %max value of consumption term for Substrate (consumed only)
kS_maint =0.3*kS_tissue%conf(j+1);j++; %max value of consumption term for Substrate (consumed only)
kP_tissue =-1*kS_tissue%conf(j+1);j++; % max value of consumption term for Product (produced/consumed)
kP_maint =-0.5*kS_maint%conf(j+1);j++; % max value of consumption term for Product (produced/consumed)
cO =  0.1%conf(j+1);j++; %Michaelis Menten constant for Oxygen hill function for cons.
cS = 0.2%conf(j+1);j++; %" constant for Substrate hill function for cons.
cP = 0.1%conf(j+1);j++; %" constant for Product hill function for /prod
DOx_tissue = 0.5%conf(j+1); j++;% oxygen diffusion constant in tissue
DS_tissue = 0.05%conf(j+1);j++; % Substrate diffusion constant in tissue
DP_tissue = 0.1%conf(j+1);j++; % Product diffusion constant in tissue
DK_tissue = 0.1%conf(j+1);j++; % Kine diffusion constant in tissue
S_prol = 0.5 % 40 % of ext value needed to proliferate.
S_maint = 0.2 % 40 % of ext value needed to proliferate.
O_norm = 0.4 % 40 % of ext value needed to proliferate.
K_prom = 0.2 % 40 % of ext value needed to proliferate.
K_death = 0.4 % 40 % of ext value needed to proliferate.
P_prom = 0.2 % 40 % of ext value needed to proliferate.
P_death = 0.4 % 40 % of ext value needed to proliferate.
rel_K = 0.2 % 40 % of ext value needed to proliferate.


%Paramètres cellulaires
%n_cells0 = conf(j+1);
%pellet_size = conf(j+1);
%Diff_glu = conf(j+1);
n_div = 11; %nombre max de div.
n_init = 3; %nombre de division pour initialiser le système
shed_prob = 0.9; %proba limite pour le shedding
%behavior = 1; %encodes the different behavior

%initialisation des matrices
%matrices de concentration
S = ones(sz,sz); %substrate matrix
P = zeros(sz,sz); % product matrix
O = ones(sz,sz); % oxygen matrix
K = zeros(sz,sz); % kine matrix
kO = zeros(sz,sz); % oxygen consumption maatrix
kS = zeros(sz,sz); % Substrate consumption matrix
kP = zeros(sz,sz); % Product consumption matrix
kK = zeros(sz,sz); % Product consumption matrix
Grid = zeros(sz,sz); % Grilles de gestions des cellules
state_mat = zeros(sz,sz); % Grilles d'état nutriments exogènes
prod_mat = zeros(sz,sz); % Grilles d'état produit
%initialisation
Grid(round(sz/2),round(sz/2))=1; %cellule unique au centre au départ
state_story =  cell(1,1); %cell structure stroring the vector states

%matrices de diffusion
DOm = ones(sz,sz); %oxygen diffusion in medium is the ref
DSm = DS_med*ones(sz,sz); %glucose diffusion in water
DPm = DP_med*ones(sz,sz); %product is supposed to be smaller chains so it's higher
DKm = DK_med*ones(sz,sz); %product is supposed to be smaller chains so it's higher
%  33207661 : D = kB T / ( 6  pi  r eta_0) : both glucose and lactate calculated
% then lactate renormalised to be above glucose by 20% (ratio found with formula)

%initialisation64
kS(round(sz/2),round(sz/2)) = kS_tissue;
kO(round(sz/2),round(sz/2)) = kO_tissue;
kP(round(sz/2),round(sz/2)) = kP_tissue;
DSm(round(sz/2),round(sz/2))=DS_tissue;
DOm(round(sz/2),round(sz/2))=DOx_tissue;
DPm(round(sz/2),round(sz/2))=DP_tissue;
DKm(round(sz/2),round(sz/2))=DK_tissue;

%cell state  1: cell time 2: cell cycle duration
state = [0 1];
l=1


	%maps
	kO_r = [];
	kS_r = [];
	S_r  = [];
	O_r  = [];
	P_r  = [];
	K_r  = [];
	Grid_r = [];
	Ot_r = [];
	St_r = [];
	Pt_r = [];
	Kt_r = [];
	state_mat_r = [];
	prod_mat_r = [];

	n_cy =0;

while(Radius_agg<1000) % loop to stop at a given size
  disp('******************')
	n_cy++
	div =0;

  check_div1 = length(find(kS==kS_tissue))
	for k = 1:size(state,1)%for each cell check if it should divide
		if(state(k,2)>0)%ne divise que les cellules en prolifération
			%DIVISION ROUTINE%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
			[r,c] = ind2sub([sz,sz],find(Grid==k));
			pos(1) = r; pos(2) = c;
			%state(k,2)
			for j=1:state(k,2)% accounts for division score
				div++;
				[Grid,kO,kS,kP,DSm,DOm,DPm,DKm,state] = divide2D_metvar(Grid,pos,k,sz,S,P,O,K,state,kO,kS,kP,kO_tissue,kS_tissue,kP_tissue,DOm,DSm,DPm,DKm,DOx_tissue,DS_tissue,DP_tissue,DK_tissue);
				%[Grid,kO,kS,kP,DSm,DOm,DPm,state] = divide2D_metvar(Grid,pos,k,sz,S,P,O,state,kO,kS,kP,kO_tissue,kS_tissue,kP_tissue,DOm,DSm,DPm,DOx_tissue,DS_tissue,DP_tissue);
			endfor
		endif
	endfor



	Grid;
	grid_stable = 0;
	prev_Grid =  Grid;

	n_cell = size(state,1)
  %state
  %waitforbuttonpress
	n_spher = 4/(3*sqrt(pi))*n_cell^(3/2)
	%les sphéroïdes humain saturent normalement vers 20000 cellules en 20 jours

	%MIGRATION ROUTINE%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	%migration moves the cell to favor sphericity
	prev_Grid = Grid;
	if(grid_stable==0)
		[Grid,kO,kS,kP,DSm,DOm,DPm,DKm,state] = migrate2D_sphere_metvar(Grid,sz,S,P,O,K,state,kO,kS,kP,kO_tissue,kS_tissue,kP_tissue,DOm,DSm,DPm,DKm,DOx_tissue,DS_tissue,DP_tissue,DK_tissue);
		%isokay2  = find(((Grid!=0)==(D!=0))==0)
		if(Grid==prev_Grid)
			grid_stable=1;%skip migration
			disp('grid stable')
		endif
	endif

  Area_patch = length(find(Grid!=0))*(dx^2);
  Radius_agg = sqrt(Area_patch/pi);
  n_min = round(Area_patch/5000);
  disp(['diffusion time :' num2str(n_min) ' mn'])
	ntime = floor(n_min/dt)+1;

	if(n_cy>n_init)
    %cnt=0;
		tic
##		[S,kS,DSm,St,cnt] = update_metvar_master(Grid,S,kS,cS,DSm,d0,250,tau,dx,dt);
##    cnt
    [S,kS,DSm,St] = update_metvar(Grid,S,kS,cS,DSm,d0,ntime,tau,dx,dt);
		[O,kO,DOm,Ot] = update_metvar(Grid,O,kO,cO,DOm,d0,ntime,tau,dx,dt);
		%[P,kP,DPm,Pt,delta] = updateprod_metvar(Grid,S,P,kP,cP,DPm,d0,ntime,tau,dx,dt);
		%[K,kK,DKm,Kt,delta] = updateprod_metvar(Grid,K,P,kK,cP,DKm,d0,ntime,tau,dx,dt);
		%delta
    toc


		%BEHAVIOR DETERMINATION%%%%%%%%
		[kS,kO,kP,K,state,state_mat,prod_mat] = behav(behavior,Grid,S,P,O,K,state,kO,kS,kP,kO_tissue,kO_maint,kS_tissue,kS_maint,kP_tissue,kP_maint,DOm,DSm,DPm,DOx_tissue,DS_tissue,DP_tissue,DK_tissue,S_prol,S_maint,O_norm,P_prom,P_death,K_prom,K_death,rel_K,state_mat,prod_mat);

		%[K,kK,DKm,Kt,delta] = updateprod_metvar(Grid,K,P,kK,cP,DKm,d0,ntime,tau,dx,dt);
		%delta

    check_div2 = length(find(kS==kS_tissue))


		%readouts
		kO_r = [kO_r kO];
		kS_r = [kS_r kS];
		S_r  = [S_r S];
		St_r  = [St_r St];
		O_r  = [O_r O];
		Ot_r  = [Ot_r Ot];
##		P_r  = [P_r P];
##		Pt_r  = [Pt_r Pt];
##		K_r  = [K_r K];
##		Kt_r  = [Kt_r Kt];
		Grid_r = [Grid_r Grid];
		state_mat_r = [state_mat_r state_mat];
		prod_mat_r = [prod_mat_r prod_mat];
		state_story(n_cy-1) = state;
	endif

endwhile

S_r = reshape(S_r, [sz sz n_cy-n_init]);
%St_r = reshape(St_r, [round(sz/2) round(ntime) n_cy-n_init]);
%Ot_r = reshape(Ot_r, [round(sz/2) round(ntime) n_cy-n_init]);
##Kt_r = reshape(Kt_r, [round(sz/2) round(ntime) n_cy-n_init]);
##Pt_r = reshape(Pt_r, [round(sz/2) round(ntime) n_cy-n_init]);
O_r = reshape(O_r, [sz sz n_cy-n_init]);
##P_r = reshape(P_r, [sz sz n_cy-n_init]);
##K_r = reshape(K_r, [sz sz n_cy-n_init]);
kS_r = reshape(kS_r, [sz sz n_cy-n_init]);
kO_r = reshape(kO_r, [sz sz n_cy-n_init]);
Grid_r = reshape(Grid_r, [sz sz n_cy-n_init]);
state_mat_r = reshape(state_mat_r, [sz sz n_cy-n_init]);
prod_mat_r = reshape(prod_mat_r, [sz sz n_cy-n_init]);

[li co pr] = ind2sub([sz sz n_cy-n_init],find(or(kS_r==kS_tissue,kS_r==kS_comp)));
all_prol = [li, co, pr];
[li co pr] = ind2sub([sz sz n_cy-n_init],find(and(kS_r==0,Grid_r!=0)));
all_necr = [li, co, pr];
[li co pr] = ind2sub([sz sz n_cy-n_init],find(kS_r==kS_maint));
all_quiesc = [li, co, pr];

for k = 1:n_cy-n_init
	prol(k) = length(find(all_prol(:,3)==k));
	necr(k) = length(find(all_necr(:,3)==k));
	quiesc(k) = length(find(all_quiesc(:,3)==k));
endfor
##
##figure; semilogy(prol)
##
##figure; plot(prol)
##hold on; plot(necr)
##plot(quiesc)

save(filename,'-binary')

a = 1
endfunction
