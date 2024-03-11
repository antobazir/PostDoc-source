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
%20/02 Le problème du timing a été résolu en attachant la conso aux cellules et non plus au site
%22/02 Pour représenter la nécrose liquide on retire les cellules morte mais l'algo De migration s'adapte mal
%22/02 On définit LD comme une matrice tenant compte des cellules vivantes et des zones nécrotiques
%22/02 La tactique pour la zone nécrotique marche. en revanche des bugs apparaissent aux indices élevés...
%22/02 Relancer le code en incluant la position complète ET la cellule parente dans le vecteur d'état.
%04/03 on a changé la gestion de géométrie
function [code_stopped] = metvar_f (kO_arg, kS_arg, behavior, filename)

code_stopped = 0;
%declaration des paramètres à partir de conf %%%%%%%%%%%%
j=0;
% paramètres généraux
sz = 30; % 100  conf(j+1); j++; %size of the square domain in which the simulation is ran
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
DP_med = 0.4%conf(j+1);j++;
%DK_med = 0.4%conf(j+1);j++;

%paramètres métaboliques %0.40 et 0.1 donne une abondance relative similaire dans l'agrégat
%consumption
kO_tissue = kO_arg%conf(j+1);j++; %maxi value of consumption term for oxygen
kO_maint = 0.3*kO_tissue%conf(j+1);j++; %maxi value of consumption term for oxygen
kS_tissue = kS_arg%conf(j+1);j++; %max value of consumption term for Substrate (consumed only)
kS_comp = 2*kS_tissue%conf(j+1);j++; %max value of consumption term for Substrate (consumed only)
kS_maint =0.3*kS_tissue%conf(j+1);j++; %max value of consumption term for Substrate (consumed only)
kP_tissue =-2*kS_tissue%conf(j+1);j++; % max value of consumption term for Product (produced/consumed)
kP_maint =-1*kS_maint%conf(j+1);j++; % max value of consumption term for Product (produced/consumed)
cO =  0.1%conf(j+1);j++; %Michaelis Menten constant for Oxygen hill function for cons.
cS = 0.2%conf(j+1);j++; %" constant for Substrate hill function for cons.
cP = 0.1%conf(j+1);j++; %" constant for Product hill function for /prod
DOx_tissue = 0.5%conf(j+1); j++;% oxygen diffusion constant in tissue
DS_tissue = 0.05%conf(j+1);j++; % Substrate diffusion constant in tissue
DP_tissue = 0.1%conf(j+1);j++; % Product diffusion constant in tissue
%DK_tissue = 0.1%conf(j+1);j++; % Kine diffusion constant in tissue
S_prol = 0.6 % 40 % of ext value needed to proliferate.
S_maint = 0.3 % 40 % of ext value needed to proliferate.
O_norm = 0.4 % 40 % of ext value needed to proliferate.
##K_prom = 0.2 % 40 % of ext value needed to proliferate.
##K_death = 0.4 % 40 % of ext value needed to proliferate.
P_reac = 0.4 % 40 % of ext value needed to proliferate.
P_lth = 0.8 % 40 % of ext value needed to proliferate.
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
S = ones(sz,sz,'single'); %substrate matrix
P = zeros(sz,sz,'single'); % product matrix
O = ones(sz,sz,'single'); % oxygen matrix
%K = zeros(sz,sz); % kine matrix

%consumption
kS = zeros(sz,sz,'single'); % Substrate consumption matrix
kO = zeros(sz,sz,'single'); % oxygen consumption matrix
kP = zeros(sz,sz,'single'); % Product consumption matrix
%kK = zeros(sz,sz); % Product consumption matrix


%cells states & index
Grid = uint16(zeros(sz,sz)); % Grilles de gestions des cellules
state_mat = uint16(zeros(sz,sz)); % Grilles d'état nutriments exogènes
%prod_mat = uint16(zeros(sz,sz)); % Grilles d'état produit
LD = int8(zeros(sz,sz)); %matrix qui dit si la cellule est vivante ou morte

%initialisation
Grid(round(sz/2),round(sz/2))=1; %cellule unique au centre au départ
LD(round(sz/2),round(sz/2))=1; %cellule unique au centre au départ
state_story =  cell(1,1); %cell structure storing the vector states
S_r = cell(1,1);
DSm_r = cell(1,1);
O_r = cell(1,1);
P_r = cell(1,1);
kS_r = cell(1,1);
kO_r = cell(1,1);
kP_r = cell(1,1);
state_mat_r = cell(1,1);
Grid_r = cell(1,1);
LD_r = cell(1,1);

%matrices de diffusion
DOm = ones(sz,sz,'single'); %oxygen diffusion in medium is the ref
DSm = DS_med*ones(sz,sz,'single'); %glucose diffusion in water
DPm = DP_med*ones(sz,sz,'single'); %product is supposed to be smaller chains so it's higher
%DKm = DK_med*ones(sz,sz); %product is supposed to be smaller chains so it's higher
%  33207661 : D = kB T / ( 6  pi  r eta_0) : both glucose and lactate calculated
% then lactate renormalised to be above glucose by 20% (ratio found with formula)

%initialisation64
kS(round(sz/2),round(sz/2)) = kS_tissue;
kO(round(sz/2),round(sz/2)) = kO_tissue;
kP(round(sz/2),round(sz/2)) = kP_tissue;
DSm(round(sz/2),round(sz/2))=DS_tissue;
DOm(round(sz/2),round(sz/2))=DOx_tissue;
DPm(round(sz/2),round(sz/2))=DP_tissue;
%DKm(round(sz/2),round(sz/2))=DK_tissue;


%cell state  1: cell time 2: indice de division 3: timer évolution conso 4: conso courante 5: dkS 6: conso courante 7 dkO
%29/11
% state a désormais 9 colonnes pour suivre toutes les variables associéses aux cellules
state = [0 1 0 kS_tissue 0 kO_tissue 0 kP_tissue 0 0 0];
l=1;

n_cy =1;
n_pt=0;
n_gr = 1;

%on fait les 3 ou 4 divisions initiales
for i = 1:n_init

  for k = 1:size(state,1)
    [r(k),c(k)] = ind2sub([sz,sz],find(Grid==k));
    pos_p(1) = r(k); pos_p(2) = c(k);

    [Grid,LD,kO,kS,kP,DSm,DOm,DPm,state,state_mat,err] = divide2D_metvar_r(Grid,LD,pos_p,k,sz,S,O,P,state,state_mat,kO,kS,kP,kO_tissue,kS_tissue,kP_tissue,DOm,DSm,DPm,DOx_tissue,DS_tissue,DP_tissue,reac_time);

    if(err==1)
      code_stopped=1;
      return
    endif
  endfor

  %disp('after_div')
  %Grid(20:30,20:30)
  %kbhit;

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
    [Grid,LD,kO,kS,kP,DSm,DOm,DPm,state,state_mat,err] = migrate2D_sphere_metvar(Grid,LD,sz,S,O,P,state,state_mat,kO,kS,kP,kO_tissue,kS_tissue,kP_tissue,DOm,DSm,DPm,DOx_tissue,DS_tissue,DP_tissue,DS_med,DP_med);

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

%n_pt
disp(['Radius_agg:' num2str(Radius_agg) 'µm'])
disp([num2str(n_pt/n_min) 'cycles'])

tic
%while(n_pt<201) % loop to stop at a given size here it is  1000 µm
while(Radius_agg<600&&n_pt/n_min<8) % loop to stop at a given size here it is  1000 µm
  %disp('******************')
	n_pt++;
  nt = round(1/dt);
  div =0;

  %ensemble de conditions "impossibles" qui arrêtent le code si elle se produisent
  if(length(find(kS>kS_comp+0.01))!=0||length(find(S<-0.5))!=0||length(find(kS<-0.05))!=0)
  %if(length(find(kS>kS_comp+0.01))!=0||length(find(S>1.1))!=0||length(find(kS<-0.05))!=0)

    disp(['problem conso:' num2str(n_pt)])

    if(length(find(kS>kS_comp))!=0)
      disp('kS too high')
    endif

     if(length(find(kS<-0.05))!=0)
      disp('kS too low')
    endif

    % if(length(find(S>1.1))!=0)
     % disp('S too high')
    %endif

     if(length(find(S<-0.01))!=0)
      disp('S too low')
    endif

    save('debug_conso_2','-binary')
    code_stopped = 1;
    return
  endif


  % étape de calcul diffusion consommation
  %tic
  [S,kS,DSm] = update_metvar(Grid,LD,S,kS,cS,DSm,d0,nt,tau,dx,dt);
  [O,kO,DOm] = update_metvar(Grid,LD,O,kO,cO,DOm,d0,nt,tau,dx,dt);
  [P,kP,DPm] = updateprod_metvar(Grid,LD,S,P,kP,cP,DPm,d0,nt,tau,dx,dt);
  %toc

  if(size(kS,1)!=sz)
    disp('wrong resizing')
    code_stopped=1;
    save('debug')
    return
  endif


  % On prend chaque cellule dans le système
%size(state,1)
  for k = 1:size(state,1)
    if(not(isempty(find(Grid==k))))

      % on extrait la position dans la grille de la cellule k
      [r(k),c(k)] = ind2sub([sz,sz],find(Grid==k));
      pos(1) = r(k); pos(2) = c(k);

      [gx gy v] = find(Grid!=0);
      ctroid = round(centroid(gx,gy));
      if(length(ctroid)==1)
        save('debug_ctroid_2')
        code_stopped=1;
        return
      endif
      state(k,10) = sqrt((pos(1)-ctroid(1)).^2 + (pos(2)-ctroid(2)).^2);


      % on traite l'évolution de tous les timers non-nuls
      if(state(k,3)>0)
        state(k,4) = state(k,4) + state(k,5); %décrémente le kS des cellules dont le timer est en cours
        state(k,6) = state(k,6) + state(k,7); %décrémente le kO des cellules dont le timer est en cours
        state(k,8) = state(k,8) + state(k,9); %décrémente le kO des cellules dont le timer est en cours
        state(k,3) = state(k,3)-1; % décrémente le timer

        % décrémente la valeur de diffusion graduellement à mesure que la cellule perd son intégrité membranaire
        if(state(k,3)<=(reac_time/3)&&LD(find(Grid==k))==-1)
            DSm(Grid==k) = DSm(Grid==k) + (DS_med-DS_tissue)/(reac_time/3);
            DOm(Grid==k) = DOm(Grid==k) + (1-DOx_tissue)/(reac_time/3);
            DPm(Grid==k) = DPm(Grid==k) + (DP_med - DP_tissue)/(reac_time/3);
        endif

      endif
    endif

    kS(Grid==k) = state(k,4);
    kO(Grid==k) = state(k,6);
    kP(Grid==k) = state(k,8);

    if(state(k,3)==0&&LD(find(Grid==k))==-1)
      %disp('removal')

      kS(find(Grid==k)) = 0;
      kO(find(Grid==k)) = 0;
      kP(find(Grid==k)) = 0;
      %DSm(find(Grid==k)) = DS_med;
      %DPm(find(Grid==k)) = DP_med;
      %DOm(find(Grid==k)) = 1;
      state_mat(find(Grid==k)) = 0;
      prod_mat(find(Grid==k)) = 0;
      state(k,2) = 0;
      state(k,10) = 0;
      Grid(find(Grid==k)) = 0;
    endif

    %division scan
    if(LD(find(Grid==k))==1)% if the cell is marked as dividing

      %On incrémente le timer des cellules marqués comme non arrêtées
      if(state(k,2)>0)
        state(k,1) = state(k,1)+1;
      endif

       % le kS et le kO sont mis à jour ici



      if(state(k,1)==n_min) %if it has reached division time pour l'instant le temps de division est constant pour toutes les cellules
        for m=1:state(k,2) %on divise une fois par index de division
          div++;

          [Grid,LD,kO,kS,kP,DSm,DOm,DPm,state,state_mat,err] = divide2D_metvar_r(Grid,LD,pos,k,sz,S,O,P,state,state_mat,kO,kS,kP,kO_tissue,kS_tissue,kP_tissue,DOm,DSm,DPm,DOx_tissue,DS_tissue,DP_tissue,reac_time);
          if(err==1)
            code_stopped=1;
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
    % On  calcule la nouvelle carte d'état
    well_fed = and(S>=S_prol,O>=O_norm,P<P_reac,Grid!=0,LD==1);
    well_fed_react = and(S>=S_prol,O>=O_norm,P>=P_reac,P<P_lth,Grid!=0,LD==1);
    well_fed_lth = and(S>=S_prol,O>=O_norm,P>=P_lth,Grid!=0,LD==1);
    hypox = and(S>=S_prol,O<O_norm,Grid!=0,P<P_reac,LD==1);
    hypox_react = and(S>=S_prol,O<O_norm,P>=P_reac,P<P_lth,Grid!=0,LD==1);
    hypox_lth = and(S>=S_prol,O<O_norm,P>=P_lth,Grid!=0,LD==1);
    hypos = and(S<S_prol,S>=S_maint,O>=O_norm,P<P_reac,Grid!=0,LD==1);
    hypos_react = and(S<S_prol,S>=S_maint,O>=O_norm,P>=P_reac,P<P_lth,Grid!=0,LD==1);
    hypos_lth = and(S<S_prol,S>=S_maint,O>=O_norm,P>=P_lth,Grid!=0,LD==1);
    hypox_hypos = and(S<S_prol,S>=S_maint,O<O_norm,P<P_reac,Grid!=0,LD==1);
    hypox_hypos_react = and(S<S_prol,S>=S_maint,O<O_norm,P>=P_reac,P<P_lth,Grid!=0,LD==1);
    hypox_hypos_lth = and(S<S_prol,S>=S_maint,O<O_norm,P>=P_lth,Grid!=0,LD==1);
    %starv = or(and(S<S_maint,Grid!=0),and(Grid!=0,LD==0));
    starv = or(and(S<S_maint,Grid!=0),and(LD==-1,Grid!=0));
    %LD(starv) = 0;

    state_mat = 13.*well_fed + 12.*well_fed_react + 11.*well_fed_lth...
    +10.*hypox + 9.*hypox_react + 8.*hypox_lth...
    +7.*hypos + 6.*hypos_react + 5.* hypos_lth...
    +4.*hypox_hypos + 3.*hypox_hypos_react + 2.*hypox_hypos_lth...
    +starv;
    state_mat(Grid==0)=0;
  endif

  %migration et comportement
  if(mod(n_pt,10)==0)%réarrangement de l'agrégat toutes les 10 mns


    grid_stable = 0;
    prev_Grid = Grid;
    if(grid_stable==0)
      [Grid,LD,kO,kS,kP,DSm,DOm,DPm,state,state_mat,err] = migrate2D_sphere_metvar(Grid,LD,sz,S,O,P,state,state_mat,kO,kS,kP,kO_tissue,kS_tissue,kP_tissue,DOm,DSm,DPm,DOx_tissue,DS_tissue,DP_tissue,DS_med,DP_med);
      %[Grid,LD,kO,kS,DSm,DOm,state,state_mat,err] = migrate2D_sphere_metvar(Grid,LD,sz,S,O,state,state_mat,kO,kS,kO_tissue,kS_tissue,DOm,DSm,DOx_tissue,DS_tissue);
      %isokay2  = find(((Grid!=0)==(D!=0))==0)
      if(Grid==prev_Grid)
        grid_stable=1;%skip migration
        %disp('grid stable')
      endif
    endif

   state_mat(find(Grid==0)) = 0;
   [LD,state,state_mat,err] = behav(behavior,Grid,LD,S,O,P,state,state_mat,kO,kS,kP,kO_tissue,kO_maint,kS_tissue,kS_maint,kP_tissue,kP_maint,DOm,DSm,DPm,DOx_tissue,DS_tissue,DP_tissue,S_prol,S_maint,O_norm,P_reac,P_lth,reac_time);

    if(err==1)
      disp('error in behav')
      code_stopped =1;
      save('post_behav')
      return
    endif
 endif

  Radius_agg = max(state(:,10))*dx;

  if(mod(n_pt,20)==0) %un readout toutes les  6h
    disp('***************')
    n_pt
    disp(['Radius_agg:' num2str(Radius_agg) 'µm'])
    disp([num2str(n_pt/n_min) 'cycles'])
    n_days = n_pt/n_min;
    disp(['max S:' num2str(max(max(S)))])
    disp(['min S:' num2str(min(min(S)))])
    disp(['max O:' num2str(max(max(O)))])
    disp(['min O:' num2str(min(min(O)))])
    disp(['max P:' num2str(max(max(P)))])
    disp(['min P:' num2str(min(min(P)))])
    %readouts

    S_r(n_cy) = S;
    O_r(n_cy) = O;
    P_r(n_cy) = P;
    kS_r(n_cy) = kS;
    kO_r(n_cy) = kO;
    kP_r(n_cy) = kP;
    DSm_r(n_cy) = DSm;
    Grid_r(n_cy) =  Grid;
    LD_r(n_cy) = LD;
    state_story(n_cy) = state;
    n_cy++;
    n_gr++;

    %checks if close to too big and enlarges everything if needed.
    if(min(r)<5||max(r)>sz-5||min(c)<5||max(c)>sz-5)
      sz
      min(r)
      max(r)
      min(c)
      max(c)

        %cell
        Grid  = fliplr(flipud(resize(fliplr(flipud(resize(Grid,sz+5,sz+5))),sz+10,sz+10)));
        LD  = fliplr(flipud(resize(fliplr(flipud(resize(LD,sz+5,sz+5))),sz+10,sz+10)));
        state_mat  = fliplr(flipud(resize(fliplr(flipud(resize(state_mat,sz+5,sz+5))),sz+10,sz+10)));

        %nutrients
        S  = fliplr(flipud(resize(fliplr(flipud(resize(S,sz+5,sz+5))),sz+10,sz+10)));
        O  = fliplr(flipud(resize(fliplr(flipud(resize(O,sz+5,sz+5))),sz+10,sz+10)));
        P  = fliplr(flipud(resize(fliplr(flipud(resize(P,sz+5,sz+5))),sz+10,sz+10)));
        spread = imfill(Grid!=0,'holes');
        S(spread==0)=1;
        O(spread==0)=1;


        %consumption
        kS  = fliplr(flipud(resize(fliplr(flipud(resize(kS,sz+5,sz+5))),sz+10,sz+10)));
        kO  = fliplr(flipud(resize(fliplr(flipud(resize(kO,sz+5,sz+5))),sz+10,sz+10)));
        kP  = fliplr(flipud(resize(fliplr(flipud(resize(kP,sz+5,sz+5))),sz+10,sz+10)));


        %diffusion
        DSm  = fliplr(flipud(resize(fliplr(flipud(resize(DSm,sz+5,sz+5))),sz+10,sz+10)));
        DOm  = fliplr(flipud(resize(fliplr(flipud(resize(DOm,sz+5,sz+5))),sz+10,sz+10)));
        DPm  = fliplr(flipud(resize(fliplr(flipud(resize(DPm,sz+5,sz+5))),sz+10,sz+10)));
        DSm(spread==0)=DS_med;
        DPm(spread==0)=DP_med;
        DOm(spread==0)=1;

        sz = sz + 10;
    endif
  endif

  if(mod(n_pt,1000)==0)
    save(filename,'-binary')
  endif

endwhile
  toc

save(filename,'-binary')

a = 1
endfunction
