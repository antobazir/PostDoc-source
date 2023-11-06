%This is the code/script that will serve as a basis for the metabolic variety family of model
%notes la nécrose commence entre 200 et 500 µm


%cleaning the workspace
clear all;
close all;
pkg load image%needed for the migration code


filename = 'ref_conf/metvar1';

%conf Vector contains the values main parameters of the simulation
%conf= [40 3000 200 4e-3 ... %param gén
% 200 4e-3 0.3 0.36 ... %lol
% 0 0 0.1 ... % consos
% 100 1 1 ... % michael menten constant of the hill function
% 0.9 0.03 0.04]; % diffusion in tissue all scaled w/ oxygen in water

%declaration des paramètres à partir de conf %%%%%%%%%%%%
j=0;
% paramètres généraux
sz = 400; % 100  conf(j+1); j++; %size of the square domain in which the simulation is ran
n_min = 20; %  15 conf(j+1);j++; % simulated time in minutes
dx = 20; % 20  conf(j+1);j++;
dt =  26e-4;%conf(j+1);j++;

%paramètres diffusion
d0 = 20;%conf(j+1);j++;
tau = 4e-3;%j++; % characteristic diff time in minues
DS_med = 0.3%conf(j+1);j++;
DP_med = 0.4%conf(j+1);j++;

%paramètres métaboliques %0.40 et 0.1 donne une abondance relative similaire dans l'agrégat
%consumption
kO_tissue = 1.4%conf(j+1);j++; %maxi value of consumption term for oxygen
kO_maint = 0.3*kO_tissue%conf(j+1);j++; %maxi value of consumption term for oxygen
kS_tissue = 0.2%conf(j+1);j++; %max value of consumption term for Substrate (consumed only)
kS_comp = 2*kS_tissue%conf(j+1);j++; %max value of consumption term for Substrate (consumed only)
kS_tissue_maint =0.3*kS_tissue%conf(j+1);j++; %max value of consumption term for Substrate (consumed only)
kP_tissue = -0.2 %conf(j+1);j++; % max value of consumption term for Product (produced/consumed)
cO =  0.1%conf(j+1);j++; %Michaelis Menten constant for Oxygen hill function for cons.
cS = 0.2%conf(j+1);j++; %" constant for Substrate hill function for cons.
cP = 0.1%conf(j+1);j++; %" constant for Product hill function for /prod
DOx_tissue = 0.6%conf(j+1); j++;% oxygen diffusion constant in tissue
DS_tissue = 0.06%conf(j+1);j++; % Substrate diffusion constant in tissue
DP_tissue = 0.1%conf(j+1);j++; % Product diffusion constant in tissue
S_prol = 0.6 % 40 % of ext value needed to proliferate.
S_maint = 0.2 % 40 % of ext value needed to proliferate.
O_norm = 0.4 % 40 % of ext value needed to proliferate.

%Paramètres cellulaires
%n_cells0 = conf(j+1);
%pellet_size = conf(j+1);
%Diff_glu = conf(j+1);
n_div = 16; %nombre max de div.
n_init = 7; %nombre de division pour initialiser le système
shed_prob = 0.9; %proba limite pour le shedding


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
kP(round(sz/2),round(sz/2)) = kP_tissue;
DSm(round(sz/2),round(sz/2))=DS_tissue;
DOm(round(sz/2),round(sz/2))=DOx_tissue;
DPm(round(sz/2),round(sz/2))=DP_tissue;

%cell state  1: cell time 2: cell cycle duration
state = [randi(1440) 1440];
l=1
##	F1 = figure;
##  aF1 = axes(F1);
##  set(F1,'visible','off')
##	F2 =figure;
##  aF2 = axes(F2);
##  set(F2,'visible','off')
##	F3 = figure;
##  aF3 = axes(F3);
##  set(F3,'visible','off')
##	F4 = figure;
##  set(F4,'visible','off')
##	F5 = figure;
##  set(F5,'visible','off')
##	F6 = figure;
##  set(F6, 'visible','off')
##	F7 = figure;
##  set(F7,'visible','off')
##	F8 = figure;
##  hold on;
##  set(F8,'visible','off')

	%maps
	kO_r = [];
	kS_r = [];
	S_r  = [];
	O_r  = [];
	Grid_r = [];
	Ot_r = [];
	St_r = [];

	n_cy =0;

while(n_cy<n_div) % loop to stop at a given size
   disp('******************')
	n_cy++
	div =0;

	%SHEDDING ROUTINE
##	if(n_cy>n_init)
##		% a quick calculation show that the spheroids drops roughly its surface each day
##		[Grid,kO,kS,kP,DSm,DOm,DPm,state] = shedding_metvar(Grid,state,kO,kS,kP,DOm,DSm,DPm,DS_med,DP_med,shed_prob);
##		[Grid,kO,kS,kP,DSm,DOm,DPm,state] = shedding_metvar(Grid,state,kO,kS,kP,DOm,DSm,DPm,DS_med,DP_med,shed_prob);
##	endif
  check_div1 = length(find(kS==kS_tissue))
	for k = 1:size(state,1)%for each cell check if it should divide
		if(state(k,2)>0)
			%DIVISION ROUTINE%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
			[r,c] = ind2sub([sz,sz],find(Grid==k));
			pos(1) = r; pos(2) = c;

			if(kS(find(Grid==k))==kS_tissue||kS(find(Grid==k))==kS_comp)
				div++;
				%pos
				[Grid,kO,kS,kP,DSm,DOm,DPm,state] = divide2D_metvar(Grid,pos,k,sz,S,P,O,state,kO,kS,kP,kO_tissue,kS_tissue,kP_tissue,DOm,DSm,DPm,DOx_tissue,DS_tissue,DP_tissue);
			endif

			%former shedding implementation
	##		perim = im2double(bwperim(Grid));
	##		if(n_cy<=n_init)
	##			%disp('beginning')
	##			[Grid,kO,kS,kP,DSm,DOm,DPm,state] = divide2D_metvar(Grid,pos,k,sz,S,P,O,state,kO,kS,kP,kO_tissue,kS_tissue,kP_tissue,DOm,DSm,DPm,DOx_tissue,DS_tissue,DP_tissue);
	##		else
	##			if(kS(find(Grid==k))==kS_tissue||kS(find(Grid==k))==kS_comp)
	##				if(perim(find(Grid==k))==0)
	##					div++;
	##					%pos
	##					[Grid,kO,kS,kP,DSm,DOm,DPm,state] = divide2D_metvar(Grid,pos,k,sz,S,P,O,state,kO,kS,kP,kO_tissue,kS_tissue,kP_tissue,DOm,DSm,DPm,DOx_tissue,DS_tissue,DP_tissue);
	##				else
	##						%disp('border cell so no div');
	##				endif
	##			endif
	##		endif


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
		endif
	endfor
  %check_div = length(find(kS==kS_tissue))
	n_cell = size(state,1)
	n_spher = 4/(3*sqrt(pi))*n_cell^(3/2)
	%les sphéroïdes humain saturent normalement vers 20000 cellules en 20 jours

	%MIGRATION ROUTINE%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	%migration moves the cell to favor sphericity
	prev_Grid = Grid;
	if(grid_stable==0)
		[Grid,kO,kS,kP,DSm,DOm,DPm,state] = migrate2D_sphere_metvar(Grid,sz,S,P,O,state,kO,kS,kP,kO_tissue,kS_tissue,kP_tissue,DOm,DSm,DPm,DOx_tissue,DS_tissue,DP_tissue);
		%isokay2  = find(((Grid!=0)==(D!=0))==0)
		if(Grid==prev_Grid)
			grid_stable=1;%skip migration
			disp('grid stable')
		endif
	endif

	ntime = n_min/dt;
	%ntime = 10;
	%Slol(:,:,l)= S;l++

	if(n_cy>n_init)
		tic
		[S,kS,DSm,St] = update_metvar(Grid,S,kS,cS,DSm,d0,ntime,tau,dx,dt);
		[O,kO,DOm,Ot] = update_metvar(Grid,O,kO,cO,DOm,d0,ntime,tau,dx,dt);
		%[P,kP,DPm,Pt,delta] = updateprod_metvar(Grid,S,P,kP,cP,DPm,d0,ntime,tau,dx,dt);
		%delta
    toc


		%BEHAVIOR DETERMINATION%%%%%%%%
##		%enough of both
##		kS(find(and(S>=S_prol,O>=O_norm,Grid!=0)))=kS_tissue;
##		kO(find(and(S>=S_prol,O>=O_norm,Grid!=0)))=kO_tissue;
##
##		%hypoxia
##		kS(find(and(S>=S_prol,O<O_norm,Grid!=0)))=kS_comp;
##		kO(find(and(S>=S_prol,O<O_norm,Grid!=0)))=kO_maint;
##
##		%hypoxia + lack of sub
##		kS(find(and(S<S_prol,S>=S_maint,O<O_norm,Grid!=0)))=0;
##		kO(find(and(S<S_prol,S>=S_maint,O<O_norm,Grid!=0)))=0;
##
##		%normoxia + lack of sub
##		kS(find(and(S<S_prol,S>=S_maint,O>=O_norm,Grid!=0)))=kS_tissue_maint;
##		kO(find(and(S<S_prol,S>=S_maint,O>=O_norm,Grid!=0)))=kO_maint;
##
##		%starvation (onlly possible w/substrate)
##		kS(find(and(S<S_maint,Grid!=0)))=0;
##		kO(find(and(S<S_maint,Grid!=0)))=0;
##		state(Grid(find(and(S<S_maint,Grid!=0))),2)=-1;
    check_div2 = length(find(kS==kS_tissue))


		%readouts
		kO_r = [kO_r kO];
		kS_r = [kS_r kS];
		S_r  = [S_r S];
		St_r  = [St_r St];
		O_r  = [O_r O];
		Ot_r  = [Ot_r Ot];
		Grid_r = [Grid_r Grid];


	%imagesc(Grid!=0)

##		%figure 1
##		contour(aF1,((1:sz)-sz/2)*dx,((1:sz)-sz/2)*dx,S)
##		caxis(aF1,[0 1])
##		colorbar(aF1)
##		%figure 2
##		contour(aF2,((1:sz)-sz/2)*dx,((1:sz)-sz/2)*dx,O)
##		caxis(aF2,[0 1])
##		colorbar(aF2)
##    %figure 3
##		contour(aF3,((1:sz)-sz/2)*dx,((1:sz)-sz/2)*dx,P)
##		caxis(aF3,[0 1])
##		colorbar(aF3)
##		%figure 4
##		imagesc(aF4,((1:sz)-sz/2)*dx,((1:sz)-sz/2)*dx,Grid!=0)
##		%figure 5
##		imagesc(aF5,((1:sz)-sz/2)*dx,((1:sz)-sz/2)*dx,kS)
##	  colorbar(aF5)
##	  caxis(aF5,[0 kS_comp])
##		%figure 6
##		imagesc(aF6,((1:sz)-sz/2)*dx,((1:sz)-sz/2)*dx,kO)
##	  colorbar(aF6)
##	  caxis(aF6,[0 kO_tissue])
##    %figure 7
##		imagesc(aF7,((1:sz)-sz/2)*dx,((1:sz)-sz/2)*dx,abs(kP))
##	  colorbar(aF7)
##	  caxis(aF7,[0 abs(kP_tissue)])
##		figure 8;
##		plot(aF8,S(:,round(sz/2)),'-x')
##		plot(aF8,O(:,round(sz/2)),'-o')
		%waitforbuttonpress
	endif

endwhile

S_r = reshape(S_r, [sz sz n_cy-n_init]);
St_r = reshape(St_r, [round(sz/2) round(ntime) n_cy-n_init]);
O_r = reshape(O_r, [sz sz n_cy-n_init]);
kS_r = reshape(kS_r, [sz sz n_cy-n_init]);
kO_r = reshape(kO_r, [sz sz n_cy-n_init]);
Grid_r = reshape(Grid_r, [sz sz n_cy-n_init]);

[li co pr] = ind2sub([sz sz n_cy-n_init],find(or(kS_r==kS_tissue,kS_r==kS_comp)));
all_prol = [li, co, pr];
[li co pr] = ind2sub([sz sz n_cy-n_init],find(and(kS_r==0,Grid_r!=0)));
all_necr = [li, co, pr];
[li co pr] = ind2sub([sz sz n_cy-n_init],find(kS_r==kS_tissue_maint));
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
