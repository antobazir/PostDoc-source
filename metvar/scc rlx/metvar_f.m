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
%19/12 Pour résoudre le pr
%27/12 Pour résoudre le souci de la gestion des conso on va rattacher le timer au vecteur d'état
function [code_stopped] = metvar_f (kO_arg, kS_arg, behavior, filename)

code_stopped = 0;
%declaration des paramètres à partir de conf %%%%%%%%%%%%
j=0;
% paramètres généraux
sz = 50; % 100  conf(j+1); j++; %size of the square domain in which the simulation is ran
n_min = 500; %  15 conf(j+1);j++; % simulated time in minutes
dx = 60; % 20  conf(j+1);j++;
dt =   0.5*dx^2/(2*100000);%conf(j+1);j++;
cell_diam = 20;
Radius_agg=0;
reac_time = 60;

%paramètres diffusion
d0 = dx%conf(j+1);j++;
tau = d0^2/100000%j++; % characteristic diff time in minues
DS_med = 0.3%conf(j+1);j++;
%DP_med = 0.4%conf(j+1);j++;
%DK_med = 0.4%conf(j+1);j++;

%paramètres métaboliques %0.40 et 0.1 donne une abondance relative similaire dans l'agrégat
%consumption
kO_tissue = kO_arg%conf(j+1);j++; %maxi value of consumption term for oxygen
kO_maint = 0.3*kO_tissue%conf(j+1);j++; %maxi value of consumption term for oxygen
kS_tissue = kS_arg%conf(j+1);j++; %max value of consumption term for Substrate (consumed only)
kS_comp = 2*kS_tissue%conf(j+1);j++; %max value of consumption term for Substrate (consumed only)
kS_maint =0.3*kS_tissue%conf(j+1);j++; %max value of consumption term for Substrate (consumed only)
%kP_tissue =-1*kS_tissue%conf(j+1);j++; % max value of consumption term for Product (produced/consumed)
%kP_maint =-0.5*kS_maint%conf(j+1);j++; % max value of consumption term for Product (produced/consumed)
cO =  0.1%conf(j+1);j++; %Michaelis Menten constant for Oxygen hill function for cons.
cS = 0.2%conf(j+1);j++; %" constant for Substrate hill function for cons.
cP = 0.1%conf(j+1);j++; %" constant for Product hill function for /prod
DOx_tissue = 0.5%conf(j+1); j++;% oxygen diffusion constant in tissue
DS_tissue = 0.05%conf(j+1);j++; % Substrate diffusion constant in tissue
%DP_tissue = 0.1%conf(j+1);j++; % Product diffusion constant in tissue
%DK_tissue = 0.1%conf(j+1);j++; % Kine diffusion constant in tissue
S_prol = 0.6 % 40 % of ext value needed to proliferate.
S_maint = 0.2 % 40 % of ext value needed to proliferate.
O_norm = 0.4 % 40 % of ext value needed to proliferate.
##K_prom = 0.2 % 40 % of ext value needed to proliferate.
##K_death = 0.4 % 40 % of ext value needed to proliferate.
##P_prom = 0.2 % 40 % of ext value needed to proliferate.
##P_death = 0.4 % 40 % of ext value needed to proliferate.
##rel_K = 0.2 % 40 % of ext value needed to proliferate.


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
%P = zeros(sz,sz); % product matrix
O = ones(sz,sz); % oxygen matrix
%K = zeros(sz,sz); % kine matrix

%consumption
kS = zeros(sz,sz); % Substrate consumption matrix
kO = zeros(sz,sz); % oxygen consumption matrix
%kP = zeros(sz,sz); % Product consumption matrix
%kK = zeros(sz,sz); % Product consumption matrix

%matrice des delta et relaxation
%dkS = zeros(sz,sz); % Substrate consumption matrix
%dkO = zeros(sz,sz);
%Rt_S = zeros(sz,sz); %matrice de décompte du temps de relax
%Rt_O = zeros(sz,sz); %matrice de décompte du temps de relax


%cells states & index
Grid = zeros(sz,sz); % Grilles de gestions des cellules
state_mat = zeros(sz,sz); % Grilles d'état nutriments exogènes
%prod_mat = zeros(sz,sz); % Grilles d'état produit
LD = zeros(sz,sz); %matrix qui dit si la cellule est vivante ou morte

%initialisation
Grid(round(sz/2),round(sz/2))=1; %cellule unique au centre au départ
LD(round(sz/2),round(sz/2))=1; %cellule unique au centre au départ
state_story =  cell(1,1); %cell structure stroring the vector states

%matrices de diffusion
DOm = ones(sz,sz); %oxygen diffusion in medium is the ref
DSm = DS_med*ones(sz,sz); %glucose diffusion in water
%DPm = DP_med*ones(sz,sz); %product is supposed to be smaller chains so it's higher
%DKm = DK_med*ones(sz,sz); %product is supposed to be smaller chains so it's higher
%  33207661 : D = kB T / ( 6  pi  r eta_0) : both glucose and lactate calculated
% then lactate renormalised to be above glucose by 20% (ratio found with formula)

%initialisation64
kS(round(sz/2),round(sz/2)) = kS_tissue;
kO(round(sz/2),round(sz/2)) = kO_tissue;
%kP(round(sz/2),round(sz/2)) = kP_tissue;
DSm(round(sz/2),round(sz/2))=DS_tissue;
DOm(round(sz/2),round(sz/2))=DOx_tissue;
%DPm(round(sz/2),round(sz/2))=DP_tissue;
%DKm(round(sz/2),round(sz/2))=DK_tissue;


%cell state  1: cell time 2: indice de division 3: timer évolution conso 4: conso courante 5: dkS 6: conso courante 7 dkO
%29/11
% state a désormais 7 colonnes pour suivre toutes les variables associéses aux cellules
state = [0 1 0 kS_tissue 0 kO_tissue 0];
l=1;


%maps
kO_r = [];
%dkO_r = [];
kS_r = [];
%dkS_r = [];
kS_ctr_r = [];
LD_r = [];
S_r  = [];
O_r  = [];
%P_r  = [];
%K_r  = [];
Grid_r = [];
Ot_r = [];
St_r = [];
%Pt_r = [];
%Kt_r = [];
state_mat_r = [];
%prod_mat_r = [];

n_cy =1;
n_pt=0;
n_gr = 1;

%on fait les 3 ou 4 divisions initiales
for i = 1:n_init
  %on divise les cellules
  for k = 1:size(state,1)
    [r,c] = ind2sub([sz,sz],find(Grid==k));
		pos_p(1) = r; pos_p(2) = c;
    %k
    %Grid
    %waitforbuttonpress
    %size(kS)
    %;
    [Grid,LD,kO,kS,DSm,DOm,state,state_mat,err] = divide2D_metvar_r(Grid,LD,pos_p,k,sz,S,O,state,state_mat,kO,kS,kO_tissue,kS_tissue,DOm,DSm,DOx_tissue,DS_tissue,reac_time);
    %size(kS)
    %kbhit;

    if(err==1)
    code_stopped=1;
    return
    endif
    %Grid
    %waitforbuttonpress
  endfor

  grid_stable = 0;
  %On réassemble l'agrégat
  %MIGRATION ROUTINE%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %migration moves the cell to favor sphericity
  prev_Grid = Grid;
  if(grid_stable==0)
    if(size(kS,1)!=sz)
    disp('wrong resizing before mig')
    code_stopped=1;
    save('debug')
    return
  endif
    [Grid,LD,kO,kS,DSm,DOm,state,state_mat] = migrate2D_sphere_metvar(Grid,LD,sz,S,O,state,state_mat,kO,kS,kO_tissue,kS_tissue,DOm,DSm,DOx_tissue,DS_tissue);
    %isokay2  = find(((Grid!=0)==(D!=0))==0)
    if(Grid==prev_Grid)
      grid_stable=1;%skip migration
      disp('grid stable')
    endif
  endif
  if(size(kS,1)!=sz)
    disp('wrong resizing')
    code_stopped=1;
    save('debug')
    return
  endif

endfor

%Dans ce code l'unité temporelle est la minute et le cycle en comporte 100mn
%Donc on laisse passer une minute diffusion - on divise - on réarrange
n_days = n_div-n_init; %donne le nombre de jours

state(:,1)=  randi(n_min,size(state,1),1);

%étape nécessaire pour éviter d'avoir un décompte immédiat.
%Rt_S(:,:) = 0;
%Rt_O(:,:) = 0;
%dkS et dkO sont les incréments de consommation
%dkS(:,:) = 0;
%dkO(:,:) = 0;

tic
%while(n_pt<601) % loop to stop at a given size here it is  1000 µm
while(Radius_agg<1000&&n_pt/n_min<30) % loop to stop at a given size here it is  1000 µm
  %disp('******************')
	n_pt++;
  n_tot(n_pt) = size(state,1);
  n_live(n_pt) = size(length(find(state!=1)),1);
  n_dead(n_pt) = size(length(find(state==-1)),1);
  nt = round(1/dt);
  div =0;

  %disp('while:')
  %Grid(find(Grid!=0))
  %kbhit;

  %kS(Rt_S>0) = kS(Rt_S>0) + dkS(Rt_S>0);

  %kS_full(:,:,n_pt) = kS;

  %kbhit
  %kO(Rt_O>0) = kO(Rt_O>0) + dkO(Rt_O>0);
  %Rt_S(Rt_S>0) = Rt_S(Rt_S>0)-1;
  %Rt_O(Rt_S>0) = Rt_O(Rt_S>0)-1;

  %Rt_S_full(:,:,n_pt)= Rt_S;
  state_mat_full(:,:,n_pt) = state_mat;
  Grid_full(:,:,n_pt) = Grid;
  state_cell(n_pt) = mat2cell(state,size(state,1),size(state,2));

  %ensemble de conditions "impossibles" qui arrêtent le code si elle se produisent
if(length(find(kS>kS_comp))!=0||length(find(S>1.1))!=0||length(find(kS<-0.05))!=0)

  disp(['problem conso:' num2str(n_pt)])

  if(length(find(kS>kS_comp))!=0)
    disp('kS too high')
  endif

   if(length(find(kS<-0.05))!=0)
    disp('kS too low')
  endif

   if(length(find(S>1.1))!=0)
    disp('S too high')
  endif

   if(length(find(S<-0.01))!=0)
    disp('S too high')
  endif

  save('debug_conso','-binary')
  code_stopped = 1;
  return
endif
##  Rt_S
##  kbhit
##  dkS
##  kbhit


  % étape de calcul diffusion consommation
  [S,kS,DSm,St] = update_metvar(Grid,LD,S,kS,cS,DSm,d0,nt,tau,dx,dt);
  [O,kO,DOm,Ot] = update_metvar(Grid,LD,O,kO,cO,DOm,d0,nt,tau,dx,dt);
  %[P,kP,DPm,Pt,delta] = updateprod_metvar(Grid,S,P,kP,cP,DPm,d0,1/dt,tau,dx,dt);

  %On sauve les concentration  et la conso au centre à cette étape
  St_r  = [St_r St];
  kS_ctr_r  = [kS_ctr_r kS(round(sz/2),round(sz/2))];
  Ot_r  = [Ot_r Ot];
  %Pt_r  = [Pt_r Pt];
  %Kt_r  = [Kt_r Kt];
  %[K,kK,DKm,Kt,delta] = updateprod_metvar(Grid,K,P,kK,cP,DKm,d0,ntime,tau,dx,dt);
  %delta
  if(size(kS,1)!=sz)
    disp('wrong resizing')
    code_stopped=1;
    save('debug')
    return
  endif





  %division loop
  %on met les états à jour
  %state(:,1) =  state(:,1)+1;

  % On prend chaque cellule dans le système
  for k = 1:size(state,1)
    %disp('main div loop:')
    %Grid(find(Grid!=0))
    %kbhit;

    % on extrait la position dans la grille de la cellule k
    [r,c] = ind2sub([sz,sz],find(Grid==k));
    pos(1) = r; pos(2) = c;

    %S'il ne trouve pas l'indice correspondant il s'arrête (on mettra une condition supplémentaire si la cellule est morte)
    if(isempty(find(Grid==k)))
       %k
       disp('no Grid == k')
       %Grid(find(Grid!=0))
        kbhit;
       save('debug_1')
       return
    endif



    %division scan
    if(LD(find(Grid==k))!=0)% if the cell is marked as dividing

      %On incrémente le timer
      state(k,1) = state(k,1)+1;

       % le kS et le kO sont mis à jour ici
      state(state(:,3)>0,3) = state(state(:,3)>0,3) ;%décrémente de 1 tous les timers non nuls
      if(state(k,3)>0)
        state(k,4) = state(k,4) + state(k,5); %décrémente le kS des cellules dont le timer est en cours
        state(k,6) = state(k,6) + state(k,7); %décrémente le kO des cellules dont le timer est en cours
        state(k,3) = state(k,3)-1; % décrémente le timer
        kS(Grid==k) = state(k,4);
        kO(Grid==k) = state(k,6);
      endif


      if(state(k,1)==n_min) %if it has reached division time pour l'instant le temps de division est constant pour toutes les cellules
        for m=1:state(k,2) %on divise une fois par index de division
         div++;

         [Grid,LD,kO,kS,DSm,DOm,state,state_mat,err] = divide2D_metvar_r(Grid,LD,pos,k,sz,S,O,state,state_mat,kO,kS,kO_tissue,kS_tissue,DOm,DSm,DOx_tissue,DS_tissue,reac_time);
         if(err==1)
            code_stopped=1;
            return
         endif

         if(max(max(Grid))!=length(find(Grid!=0)))
            disp(['Grid Problem:' num2str(k) '/' num2str(n_pt)])
            kbhit;
            return
        endif
        endfor
        state(k,1)=0;%mother cell resets
      endif
    endif

  endfor
  di_v_time(n_pt) = div;

    %on initialise la matrice pour la routine d'états
    if(n_pt==1)
     disp('init state')
      well_fed = and(S>=S_prol,O>=O_norm,Grid!=0,LD==1);
      hypox = and(S>=S_prol,O<O_norm,Grid!=0,LD==1);
      hypos = and(S<S_prol,S>=S_maint,O>=O_norm,Grid!=0,LD==1);
      hypox_hypos = and(S<S_prol,S>=S_maint,O<O_norm,Grid!=0,LD==1);
      %starv = or(and(S<S_maint,Grid!=0),and(Grid!=0,LD==0));
      starv = and(S<S_maint,Grid!=0);
      LD(starv) = 0;
      state_mat = 5.*well_fed+4.*hypox+3.*hypos+2.*hypox_hypos+starv;
   endif

  %migration et comportement
  if(mod(n_pt,10)==0)%réarrangement de l'agrégat toutes les 10 mns
    grid_stable = 0;
    prev_Grid = Grid;
    if(grid_stable==0)
      [Grid,LD,kO,kS,DSm,DOm,state,state_mat,err] = migrate2D_sphere_metvar(Grid,LD,sz,S,O,state,state_mat,kO,kS,kO_tissue,kS_tissue,DOm,DSm,DOx_tissue,DS_tissue);
      %[Grid,LD,kO,kS,DSm,DOm,state,state_mat,err] = migrate2D_sphere_metvar(Grid,LD,sz,S,O,state,state_mat,kO,kS,kO_tissue,kS_tissue,DOm,DSm,DOx_tissue,DS_tissue);
      %isokay2  = find(((Grid!=0)==(D!=0))==0)
      if(Grid==prev_Grid)
        grid_stable=1;%skip migration
        %disp('grid stable')
      endif
    endif
  % recalcul du comportement toutes les 10 mns
    %[kS,dkS,kO,dkO,kP,K,Rt_S,Rt_O,state,state_mat,prod_mat] = behav(behavior,Grid,S,P,O,K,state,kO,dkO,kS,dkS,kP,Rt_S,Rt_O,kO_tissue,kO_maint,kS_tissue,kS_maint,kP_tissue,kP_maint,DOm,DSm,DPm,DOx_tissue,DS_tissue,DP_tissue,DK_tissue,S_prol,S_maint,O_norm,P_prom,P_death,K_prom,K_death,rel_K,state_mat,prod_mat);

   [LD,state,state_mat,err] = behav(behavior,Grid,LD,S,O,state,state_mat,kO,kS,kO_tissue,kO_maint,kS_tissue,kS_maint,DOm,DSm,DOx_tissue,DS_tissue,S_prol,S_maint,O_norm,reac_time);
   %[LD,state,state_mat,err] = behav(behavior,Grid,LD,S,O,state,state_mat,kO,kS,kO_tissue,kO_maint,kS_tissue,kS_maint,DOm,DSm,DOx_tissue,DS_tissue,S_prol,S_maint,O_norm,reac_time);
    if(err==1)
      disp('error in behav')
      code_stopped =1;
      return
    endif
 endif

  Area_patch = length(find(Grid!=0))*(dx^2);
  Radius_agg = sqrt(Area_patch/pi);

  if(mod(n_pt,10)==0) %un readout toutes les  6h
    n_pt
    disp(['Radius_agg:' num2str(Radius_agg) 'µm'])
    disp([num2str(n_pt/n_min) 'cycles'])
    n_days = n_pt/n_min;
    %readouts
    kO_r = [kO_r kO];
    %dkO_r = [dkO_r dkO];
   % RtO_r = [RtO_r Rt_O];
    kS_r = [kS_r kS];
    %dkS_r = [dkS_r dkS];
    %RtS_r = [RtS_r Rt_S];
    LD_r = [LD_r LD];
    S_r  = [S_r S];
    O_r  = [O_r O];
    %P_r  = [P_r P];
    %K_r  = [K_r K];
    Grid_r = [Grid_r Grid];
    state_mat_r = [state_mat_r state_mat];
    %prod_mat_r = [prod_mat_r prod_mat];
    state_story(n_cy) = state;
    n_cy++;
    n_gr++;
  endif

endwhile
  toc
  n_gr = n_gr-1
ntime = n_min/dt;
S_r = reshape(S_r, [sz sz n_gr]);
%St_r = reshape(St_r, [round(sz/2) round(ntime) n_days]);
%Ot_r = reshape(Ot_r, [round(sz/2) round(ntime) n_days]);
%Kt_r = reshape(Kt_r, [round(sz/2) round(ntime) n_days]);
%Pt_r = reshape(Pt_r, [round(sz/2) round(ntime) n_days]);
O_r = reshape(O_r, [sz sz n_gr]);
%P_r = reshape(P_r, [sz sz n_gr]);
%K_r = reshape(K_r, [sz sz n_gr]);
kS_r = reshape(kS_r, [sz sz n_gr]);
kS_ctr_r  = [kS_ctr_r kS(round(sz/2),round(sz/2))];
kO_r = reshape(kO_r, [sz sz n_gr]);
%dkO_r = reshape(dkO_r, [sz sz n_gr]);
LD_r = reshape(LD_r, [sz sz n_gr]);
Grid_r = reshape(Grid_r, [sz sz n_gr]);
state_mat_r = reshape(state_mat_r, [sz sz n_gr]);
%prod_mat_r = reshape(prod_mat_r, [sz sz n_gr]);


save(filename,'-binary')

a = 1
endfunction
