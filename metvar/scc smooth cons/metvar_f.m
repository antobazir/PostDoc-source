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
%29/11 afin d'évaluer l'importance du modèle de gestion du cycle  cellulaire on change le code de façon à répartir les divisions sur les 100 mn de divisions précédentes
%29/11 ça implique de repenser complètement le code...
%19/12 Pour résoudre le souci des oscillations on changee beaucoup la strcuture
%21/12 on a validé le mapping de la consommation par des fonctions continues et on fait de même pour le cycle cellulaire
%21/12 dans le dossier old est déposé la version ou le cycle cellulaire n'a pas encore été modifié.
function a = metvar_f (kO_arg, kS_arg, bhv, filename)

%declaration des paramètres à partir de conf %%%%%%%%%%%%
j=0;
% paramètres généraux
sz = 30; % 100  conf(j+1); j++; %size of the square domain in which the simulation is ran
n_min = 500; %  15 conf(j+1);j++; % simulated time in minutes
dx = 60; % 20  conf(j+1);j++;
dt =   0.5*dx^2/(2*100000);%conf(j+1);j++;
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
kO_tissue = kO_arg%conf(j+1);j++; %maxi value of consumption term for oxygen
kO_maint = 0.3*kO_tissue%conf(j+1);j++; %maxi value of consumption term for oxygen
kS_tissue = kS_arg%conf(j+1);j++; %max value of consumption term for Substrate (consumed only)
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
n_div = 14; %nombre max de div.
n_init = 4; %nombre de division pour initialiser le système
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
LD = zeros(sz,sz); % Grilles de gestions des cellules
state_mat = zeros(sz,sz); % Grilles d'état nutriments exogènes
prod_mat = zeros(sz,sz); % Grilles d'état produit
%initialisation
Grid(round(sz/2),round(sz/2))=1; %cellule unique au centre au départ
LD(round(sz/2),round(sz/2)) = 1;
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
%29/11
state = [0 1];
l=1;


%maps
kO_r = [];
kS_r = [];
S_r  = [];
O_r  = [];
P_r  = [];
K_r  = [];
Grid_r = [];
LD_r = [];
Ot_r = [];
St_r = [];
Pt_r = [];
Kt_r = [];
state_mat_r = [];
prod_mat_r = [];

n_cy =1;
n_pt=0;
n_gr = 1;

%on fait les 3 ou 4 divisions initiales
for i = 1:n_init
  %on divise les cellules
  for k = 1:size(state,1)
    [r,c] = ind2sub([sz,sz],find(Grid==k));
		pos(1) = r; pos(2) = c;
    [Grid,LD,kO,kS,kP,DSm,DOm,DPm,DKm,state] = divide2D_metvar(Grid,LD,pos,k,sz,S,P,O,K,state,kO,kS,kP,kO_tissue,kS_tissue,kP_tissue,DOm,DSm,DPm,DKm,DOx_tissue,DS_tissue,DP_tissue,DK_tissue);
  endfor

  grid_stable = 0;
  %On réassemble l'agrégat
  %MIGRATION ROUTINE%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %migration moves the cell to favor sphericity
  prev_Grid = Grid;
  if(grid_stable==0)
    [Grid,LD,kO,kS,kP,DSm,DOm,DPm,DKm,state] = migrate2D_sphere_metvar(Grid,LD,sz,S,P,O,K,state,kO,kS,kP,kO_tissue,kS_tissue,kP_tissue,DOm,DSm,DPm,DKm,DOx_tissue,DS_tissue,DP_tissue,DK_tissue);
    %isokay2  = find(((Grid!=0)==(D!=0))==0)
    if(Grid==prev_Grid)
      grid_stable=1;%skip migration
      disp('grid stable')
    endif
  endif
endfor

%Dans ce code l'unité temporelle est la minute et le cycle en comporte 100mn
%Donc on laisse passer une minute diffusion - on divise - on réarrange
n_days = n_div-n_init; %donne le nombre de jours

state(:,1)=  randi(n_min,size(state,1),1);

tic
disp('******************')
while(Radius_agg<500&&n_pt/n_min<30) % loop to stop at a given size
  %disp('******************')
	n_pt++;
  n_tot(n_pt) = size(state,1);
  n_live(n_pt) = size(length(find(state!=1)),1);
  n_dead(n_pt) = size(length(find(state==-1)),1);
nt = round(1/dt);
div =0;
  %5 à 8 secondes
  %[S,kS,DSm,O,kO,DOm,St,Ot] = update_nutr(Grid,LD,S,kS,DSm,kS_tissue,O,kO,DOm,kO_tissue,bhv,d0,nt,tau,dx,dt);
  B = bhv*ones(sz,sz);
  [kS,kO] = arrayfun(@cons_map,S,O,B);
  %disp(['max kO:' num2str(max(max(kO)))])
  kS = kS.*LD;
  kO = kO.*LD;

  if(isempty(find(isna(O)))&&isempty(find(isna(S)))&&isempty(find(isna(kS)))&&isempty(find(isna(kO)))==0)
      disp('NA appeared')
      save([filename '_stop_log'],'-binary')
      return
  endif
##  figure
##  imagesc(O)
##  figure
##  imagesc(kO)
##  figure
##  imagesc(LD)
##  waitforbuttonpress
## close all

  %disp(['O center:' num2str(O(round(sz/2),round(sz/2)))] )
  [S,kS,DSm,St] = update_nutr2(Grid,LD,S,kS,DSm,kS_tissue,d0,nt,tau,dx,dt);
  [O,kO,DOm,Ot] = update_nutr2(Grid,LD,O,kO,DOm,kO_tissue,d0,nt,tau,dx,dt);

  %[O,kO,DOm,Ot] = update_metvar(Grid,LD,O,kO,cO,DOm,d0,nt,tau,dx,dt);
  if(unique(B)!=1)
    LD(and(kS==0,kO==0))=0;
    LD(or(S<=0,O<=0))=0;
  endif


  %disp('conso_done')
  %[P,kP,DPm,Pt,delta] = updateprod_metvar(Grid,S,P,kP,cP,DPm,d0,1/dt,tau,dx,dt);
  St_r  = [St_r St];
  Ot_r  = [Ot_r Ot];
  %Pt_r  = [Pt_r Pt];
  %Kt_r  = [Kt_r Kt];
  %[K,kK,DKm,Kt,delta] = updateprod_metvar(Grid,K,P,kK,cP,DKm,d0,ntime,tau,dx,dt);
  %delta



  %division loop
  %on met les états à jour
  %state(:,1) =  state(:,1)+1;

  for k = 1:size(state,1)
    [r,c] = ind2sub([sz,sz],find(Grid==k));
		pos(1) = r; pos(2) = c;
      state = compute_cc(k,Grid,state,S,O,n_min,unique(B));
      state(k,1) = state(k,1)+1;
      if(state(k,1)==n_min) %if it has reached division time
        [Grid,LD,kO,kS,kP,DSm,DOm,DPm,DKm,state] = divide2D_metvar(Grid,LD,pos,k,sz,S,P,O,K,state,kO,kS,kP,kO_tissue,kS_tissue,kP_tissue,DOm,DSm,DPm,DKm,DOx_tissue,DS_tissue,DP_tissue,DK_tissue);
        state(k,1)=0;%mother cell resets
      endif
  endfor
  di_v_time(n_pt) = div;

  %migration et comportement
  if(mod(n_pt,10)==0)%réarrangement de l'agrégat toutes les 10 mns
    disp('***')
    n_pt
    toc
    grid_stable = 0;
    prev_Grid = Grid;
    if(grid_stable==0)
      [Grid,LD,kO,kS,kP,DSm,DOm,DPm,DKm,state] = migrate2D_sphere_metvar(Grid,LD,sz,S,P,O,K,state,kO,kS,kP,kO_tissue,kS_tissue,kP_tissue,DOm,DSm,DPm,DKm,DOx_tissue,DS_tissue,DP_tissue,DK_tissue);
      %isokay2  = find(((Grid!=0)==(D!=0))==0)
      if(Grid==prev_Grid)
        grid_stable=1;%skip migration
        %disp('grid stable')
      endif
    endif
  % recalcul du comportement toutes les 10 mns
    %[kS,kO,kP,K,state,state_mat,prod_mat] = behav(behavior,Grid,S,P,O,K,state,kO,kS,kP,kO_tissue,kO_maint,kS_tissue,kS_maint,kP_tissue,kP_maint,DOm,DSm,DPm,DOx_tissue,DS_tissue,DP_tissue,DK_tissue,S_prol,S_maint,O_norm,P_prom,P_death,K_prom,K_death,rel_K,state_mat,prod_mat);
  endif

  Area_patch = length(find(Grid!=0))*(dx^2);
  Radius_agg = sqrt(Area_patch/pi);

  if(mod(n_pt,240)==0) %un readout toutes les  6h
    n_pt
    disp(['Radius_agg:' num2str(Radius_agg) 'µm'])
    disp([num2str(n_pt/n_min) 'cycles'])
    n_days = n_pt/n_min;
    %readouts
    kO_r = [kO_r kO];
    kS_r = [kS_r kS];
    LD_r = [LD_r LD];
    S_r  = [S_r S];
    O_r  = [O_r O];
    P_r  = [P_r P];
    K_r  = [K_r K];
    Grid_r = [Grid_r Grid];
    state_mat_r = [state_mat_r state_mat];
    prod_mat_r = [prod_mat_r prod_mat];
    state_story(n_cy) = state;
    n_cy++;
    n_gr++;
    toc
  endif

endwhile

    %on réarrange la grille une dernière fois AVANT les derniers calculs pour éviter les bugs
    grid_stable = 0;
    prev_Grid = Grid;
    if(grid_stable==0)
      [Grid,LD,kO,kS,kP,DSm,DOm,DPm,DKm,state] = migrate2D_sphere_metvar(Grid,LD,sz,S,P,O,K,state,kO,kS,kP,kO_tissue,kS_tissue,kP_tissue,DOm,DSm,DPm,DKm,DOx_tissue,DS_tissue,DP_tissue,DK_tissue);
      %isokay2  = find(((Grid!=0)==(D!=0))==0)
      if(Grid==prev_Grid)
        grid_stable=1;%skip migration
        %disp('grid stable')
      endif
    endif


    [kS,kO] = arrayfun(@cons_map,S,O,B);
    LD(and(kS==0,kO==0))=0;
    LD(or(S<=0,O<=0))=0;

    kO_r = [kO_r kO];
    kS_r = [kS_r kS];
    S_r  = [S_r S];
    LD_r = [LD_r LD];
    O_r  = [O_r O];
    P_r  = [P_r P];
    K_r  = [K_r K];
    Grid_r = [Grid_r Grid];
    state_mat_r = [state_mat_r state_mat];
    prod_mat_r = [prod_mat_r prod_mat];
    state_story(n_cy) = state;
    n_cy++;
    n_gr++;
    toc

  toc
  n_gr = n_gr-1
ntime = n_min/dt;
S_r = reshape(S_r, [sz sz n_gr]);
%St_r = reshape(St_r, [round(sz/2) round(ntime) n_days]);
%Ot_r = reshape(Ot_r, [round(sz/2) round(ntime) n_days]);
%Kt_r = reshape(Kt_r, [round(sz/2) round(ntime) n_days]);
%Pt_r = reshape(Pt_r, [round(sz/2) round(ntime) n_days]);
O_r = reshape(O_r, [sz sz n_gr]);
P_r = reshape(P_r, [sz sz n_gr]);
K_r = reshape(K_r, [sz sz n_gr]);
kS_r = reshape(kS_r, [sz sz n_gr]);
kO_r = reshape(kO_r, [sz sz n_gr]);
LD_r = reshape(LD_r, [sz sz n_gr]);
Grid_r = reshape(Grid_r, [sz sz n_gr]);
state_mat_r = reshape(state_mat_r, [sz sz n_gr]);
prod_mat_r = reshape(prod_mat_r, [sz sz n_gr]);


save(filename,'-binary')

a = 1
endfunction
