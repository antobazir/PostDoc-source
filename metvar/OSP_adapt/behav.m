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
## @deftypefn {} {@var{retval} =} behav (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: Antony <antony@antony-Lenovo-Yoga-S730-13IWL>
## Created: 2023-11-08

%14/11/2023 state keeps division score
%24/12 dans cette mouture la fonction de comportement ne fixe pas k. Elle fixe la valeur initiale dkX et Rt_X
%24/12 Il faut définir une structure qui contient la conso de chaque état
%25/12: 02:30 régler le souci des consos: Quand l'état est inoccupé c'est 0 et ce n'est pas indexable
function [LD,state,state_mat,err] = behav(behavior,Grid,LD,S,O,P,state,state_mat,kO,kS,kP,kO_tissue,kO_maint,kS_tissue,kS_maint,kP_tissue,kP_maint,DOm,DSm,DPm,DOx_tissue,DS_tissue,DP_tissue,S_prol,S_maint,O_norm,P_reac,P_lth,reac_time)

##    if(state_mat(25,25)==1)
##      disp('state_mat wrong')
##      state_mat(25,25)
##      err=1;
##      return
##    endif
  % on garde la carte d'état précédente.
  prev_state_mat  = state_mat;


  % On  calcule la nouvelle carte d'état
  well_fed = and(S>=S_prol,O>=O_norm,P<P_reac,Grid!=0,prev_state_mat!=1,LD==1);
  well_fed_react = and(S>=S_prol,O>=O_norm,P>=P_reac,P<P_lth,Grid!=0,prev_state_mat!=1,LD==1);
  well_fed_lth = and(S>=S_prol,O>=O_norm,P>=P_lth,Grid!=0,prev_state_mat!=1,LD==1);
  hypox = and(S>=S_prol,O<O_norm,Grid!=0,P<P_reac,prev_state_mat!=1,LD==1);
  hypox_react = and(S>=S_prol,O<O_norm,P>=P_reac,P<P_lth,Grid!=0,prev_state_mat!=1,LD==1);
  hypox_lth = and(S>=S_prol,O<O_norm,P>=P_lth,Grid!=0,prev_state_mat!=1,LD==1);
  hypos = and(S<S_prol,S>=S_maint,O>=O_norm,P<P_reac,Grid!=0,prev_state_mat!=1,LD==1);
  hypos_react = and(S<S_prol,S>=S_maint,O>=O_norm,P>=P_reac,P<P_lth,Grid!=0,prev_state_mat!=1,LD==1);
  hypos_lth = and(S<S_prol,S>=S_maint,O>=O_norm,P>=P_lth,Grid!=0,prev_state_mat!=1,LD==1);
  hypox_hypos = and(S<S_prol,S>=S_maint,O<O_norm,P<P_reac,Grid!=0,prev_state_mat!=1,LD==1);
  hypox_hypos_react = and(S<S_prol,S>=S_maint,O<O_norm,P>=P_reac,P<P_lth,Grid!=0,prev_state_mat!=1,LD==1);
  hypox_hypos_lth = and(S<S_prol,S>=S_maint,O<O_norm,P>=P_lth,Grid!=0,prev_state_mat!=1,LD==1);
  %starv = or(and(S<S_maint,Grid!=0),and(Grid!=0,LD==0));
  starv = or(and(S<S_maint,Grid!=0),and(LD==-1,Grid!=0),prev_state_mat==1);
  %LD(starv) = 0;

  state_mat = 13.*well_fed + 12.*well_fed_react + 11.*well_fed_lth...
  +10.*hypox + 9.*hypox_react + 8.*hypox_lth...
  +7.*hypos + 6.*hypos_react + 5.* hypos_lth...
  +4.*hypox_hypos + 3.*hypox_hypos_react + 2.*hypox_hypos_lth...
  +starv;
  state_mat(Grid==0)=0;
  %kbhit


##  No_eff = and(P<P_prom,K<K_prom,Grid!=0,kS>0,kO>0);
##  Prod_rct = and(P>=P_prom,P<P_death,K<K_prom,Grid!=0,kS>0,kO>0);
##  Prod_lth = and(P>=P_death,K<K_prom,Grid!=0,kS>0,kO>0);
##  Kine_rct = and(P<P_prom,K>=K_prom,K<K_death,Grid!=0,kS>0,kO>0);
##  Kine_lth = and(P<P_prom,K>=K_death,Grid!=0,kS>0,kO>0);
##  ProdKine_rct = and(P>=P_prom,P<P_death,K>=K_prom,K<K_death,Grid!=0,kS>0,kO>0);
##  ProdKine_lth = and(P>=P_death,K>=K_death,Grid!=0,kS>0,kO>0);
##  P_rct_K_lth = and(P>=P_prom,P<P_death,K>=K_death,Grid!=0,kS>0,kO>0);
##  P_lth_K_rct = and(P>=P_death,K>=K_prom,K<K_death,Grid!=0,kS>0,kO>0);

  %shedding
  %perim = im2double(bwperim(Grid));
  %sheddable_ox = and(perim,hypox);
  %sheddable_prod = and(perim,or(Prod_rct,Prod_lth));

  %matrice indiquant les changements d'état

  state_change = state_mat - prev_state_mat;
  %prod_change = prod_mat - prev_prod_mat;
  %kbhit

  switch(behavior)
      case 'ref'
      %disp('nada');
	  state_mat = 13.*(Grid!=0);


	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	%Surctrate response only
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
      case 'starv'
      %enough of both
      conso_state = [0 0 0;... %starved
      kS_tissue kO_tissue kP_tissue;... % hypox hypos_lth
      kS_tissue kO_tissue kP_tissue;... % hypox hypos_react
      kS_tissue kO_tissue kP_tissue;... % hypox hypos
      kS_tissue kO_tissue kP_tissue;... % hypos_lth
      kS_tissue kO_tissue kP_tissue;... % hypos_react
      kS_tissue kO_tissue kP_tissue;... % hypos
      kS_tissue kO_tissue kP_tissue;... % hypox_lth
      kS_tissue kO_tissue kP_tissue;... % hypox_react
      kS_tissue kO_tissue kP_tissue;... % hypox
      kS_tissue kO_tissue kP_tissue;...   % well fed_lth
      kS_tissue kO_tissue kP_tissue;...   % well fed_react
      kS_tissue kO_tissue kP_tissue];   % well fed

      %les indices des cellules correponsdant à un état ?
      Grid(find(well_fed));

      %les indices des cellules correponsdant à un changement état ?
      Grid(find(state_change!=0));

      % Toutes les cellules dont l'état change ont un timer mis à 120
      %étapes pour enlever les cases vidées car elles passent à zéro mais on ne veut pas changer l'état de ces cases...s
      chg_sites = find(state_change!=0);
      chg_sites = chg_sites(find(state_mat(chg_sites)))
      %chg_sites = chg_sites(find(Grid(chg_sites)))
      Grid(chg_sites)
      if(isempty(find(Grid(chg_sites)==0))==0)
        Grid(find(state_change!=0))
        disp('problem with Grid-zero in Grid')
        save('debug_behav')
        err=1;
        return
      endif
      state(Grid(chg_sites),3) = reac_time;

      %Pour chaque cellule dont l'état change on calcule le dkS et le dkO
      %ce qui veut dire qu'on  fait état suivant moins état précédent divisé par le temps de réaction


      %disp("state_mat:")
      %state_mat(chg_sites)
      if(isempty(find(state_mat(chg_sites)==0))==0)
        disp('chg_sites flagged a zero')
        err=1;
        save('debug')
        return
      endif
      state(Grid(chg_sites),5) = (conso_state(state_mat(chg_sites),1)-state(Grid(chg_sites),4))/reac_time;
      state(Grid(chg_sites),7) = (conso_state(state_mat(chg_sites),2)-state(Grid(chg_sites),6))/reac_time;
      state(Grid(chg_sites),9) = (conso_state(state_mat(chg_sites),3)-state(Grid(chg_sites),8))/reac_time;

      %mise à jour du vecteur d'état
	    %state(Grid(find(well_fed)),2)=1;
	    %state(Grid(find(hypox)),2)=1;
	    %state(Grid(find(hypos)),2)=1;
	    %state(Grid(find(hypox_hypos)),2)=1;
      %state(Grid(find(starv)),2)=-1;
      LD(starv) = -1;


      %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	%Substrate response only
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
      case 'savy'
      %enough of both
       conso_state = [0 0 0;... %starved
      kS_maint kO_tissue kP_maint;... % hypox hypos_lth
      kS_maint kO_tissue kP_maint;... % hypox hypos_react
      kS_maint kO_tissue kP_maint;... % hypox hypos
      kS_tissue kO_tissue kP_tissue;... % hypos_lth
      kS_tissue kO_tissue kP_tissue;... % hypos_react
      kS_tissue kO_tissue kP_tissue;... % hypos
      kS_tissue kO_tissue kP_tissue;... % hypox_lth
      kS_tissue kO_tissue kP_tissue;... % hypox_react
      kS_tissue kO_tissue kP_tissue;... % hypox
      kS_tissue kO_tissue kP_tissue;...   % well fed_lth
      kS_tissue kO_tissue kP_tissue;...   % well fed_react
      kS_tissue kO_tissue kP_tissue];   % well fed

      %les indices des cellules correponsdant à un état ?
      Grid(find(well_fed));

      %les indices des cellules correponsdant à un changement état ?
      Grid(find(state_change!=0));

      % Toutes les cellules dont l'état change ont un timer mis à 120
      Grid(find(state_change!=0))
      if(isempty(find(Grid(find(state_change!=0))==0))==0)
        Grid(find(state_change!=0))
        disp('problem with Grid-zero in Grid')
        save('debug_behav')
        err=1;
        return
      endif
      state(Grid(find(state_change!=0)),3) = reac_time;

      %Pour chaque cellule dont l'état change on calcule le dkS et le dkO
      %ce qui veut dire qu'on  fait état suivant moins état précédent divisé par le temps de réaction
      chg_sites = find(state_change!=0);
      %disp("state_mat:")
      %state_mat(chg_sites)
      if(isempty(find(state_mat(chg_sites)==0))==0)
        disp('chg_sites flagged a zero')
        err=1;
        save('debug')
        return
      endif
      state(Grid(chg_sites),5) = (conso_state(state_mat(chg_sites),1)-state(Grid(chg_sites),4))/reac_time;
      state(Grid(chg_sites),7) = (conso_state(state_mat(chg_sites),2)-state(Grid(chg_sites),6))/reac_time;
      state(Grid(chg_sites),9) = (conso_state(state_mat(chg_sites),3)-state(Grid(chg_sites),8))/reac_time;

      %mise à jour du vecteur d'état
	    state(Grid(find(well_fed)),2)=1;
	    state(Grid(find(well_fed_react)),2)=1;
	    state(Grid(find(well_fed_lth)),2)=1;
	    state(Grid(find(hypox)),2)=1;
	    state(Grid(find(hypox_react)),2)=1;
	    state(Grid(find(hypox_lth)),2)=1;
	    state(Grid(find(hypos)),2)=0;
	    state(Grid(find(hypos_react)),2)=0;
	    state(Grid(find(hypos_lth)),2)=0;
	    state(Grid(find(hypox_hypos)),2)=0;
	    state(Grid(find(hypox_hypos_react)),2)=0;
	    state(Grid(find(hypox_hypos_lth)),2)=0;
      state(Grid(find(and(starv,Grid!=0))),2)=0;

      %marqueur vie/mort
      LD(starv) = -1;

  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	%Substrate & Oxygen response
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    case 'OS_fragile'
    %anything but  well fed stop proliferation & shortage of both kills
      %enough of both
             conso_state = [0 0 0;... %starved
      0 0 0;... % hypox hypos_lth
      0 0 0;... % hypox hypos_react
      0 0 0;... % hypox hypos
      kS_maint kO_maint kP_maint;... % hypos_lth
      kS_maint kO_maint kP_maint;... % hypos_react
      kS_maint kO_maint kP_maint;... % hypos
      kS_maint kO_maint kP_maint;... % hypox_lth
      kS_maint kO_maint kP_maint;... % hypox_react
      kS_maint kO_maint kP_maint;... % hypox
      kS_tissue kO_tissue kP_tissue;...   % well fed_lth
      kS_tissue kO_tissue kP_tissue;...   % well fed_react
      kS_tissue kO_tissue kP_tissue];   % well fed

      %les indices des cellules correponsdant à un état ?
      Grid(find(well_fed));

      %les indices des cellules correponsdant à un changement état ?
      Grid(find(state_change!=0));

      % Toutes les cellules dont l'état change ont un timer mis à 120
      Grid(find(state_change!=0))
      if(isempty(find(Grid(find(state_change!=0))==0))==0)
        Grid(find(state_change!=0))
        disp('problem with Grid-zero in Grid')
        save('debug_behav')
        err=1;
        return
      endif
      state(Grid(find(state_change!=0)),3) = reac_time;

      %Pour chaque cellule dont l'état change on calcule le dkS et le dkO
      %ce qui veut dire qu'on  fait état suivant moins état précédent divisé par le temps de réaction
      chg_sites = find(state_change!=0);
      %disp("state_mat:")
      %state_mat(chg_sites)
      if(isempty(find(state_mat(chg_sites)==0))==0)
        disp('chg_sites flagged a zero')
        err=1;
        save('debug')
        return
      endif
      state(Grid(chg_sites),5) = (conso_state(state_mat(chg_sites),1)-state(Grid(chg_sites),4))/reac_time;
      state(Grid(chg_sites),7) = (conso_state(state_mat(chg_sites),2)-state(Grid(chg_sites),6))/reac_time;
      state(Grid(chg_sites),9) = (conso_state(state_mat(chg_sites),3)-state(Grid(chg_sites),8))/reac_time;


      %mise à jour du vecteur d'état
      state(Grid(find(well_fed)),2)=1;
	    state(Grid(find(well_fed_react)),2)=1;
	    state(Grid(find(well_fed_lth)),2)=1;
	    state(Grid(find(hypox)),2)=0;
	    state(Grid(find(hypox_react)),2)=0;
	    state(Grid(find(hypox_lth)),2)=0;
	    state(Grid(find(hypos)),2)=0;
	    state(Grid(find(hypos_react)),2)=0;
	    state(Grid(find(hypos_lth)),2)=0;
	    state(Grid(find(hypox_hypos)),2)=0;
	    state(Grid(find(hypox_hypos_react)),2)=0;
	    state(Grid(find(hypox_hypos_lth)),2)=0;
      state(Grid(find(and(starv,Grid!=0))),2)=0;

      %marqueur vie/mort
      LD(starv) = -1;
      LD(hypox_hypos) = -1;
      LD(hypox_hypos_react) = -1;
      LD(hypox_hypos_lth) = -1;


   case 'OS_hypos_tol'
	%the cell tolerates hyposubemia (tolerates means prolif can be kept but at w/ compensation)

   %enough of both
                   conso_state = [0 0 0;... %starved
      kS_maint kO_maint kP_maint;... % hypox hypos_lth
      kS_maint kO_maint kP_maint;... % hypox hypos_react
      kS_maint kO_maint kP_maint;... % hypox hypos
      kS_maint 2*kO_tissue kP_maint;... % hypos_lth
      kS_maint 2*kO_tissue kP_maint;... % hypos_react
      kS_maint 2*kO_tissue kP_maint;... % hypos
      2*kS_tissue kO_maint 2*kP_tissue;... % hypox_lth
      2*kS_tissue kO_maint 2*kP_tissue;... % hypox_react
      2*kS_tissue kO_maint 2*kP_tissue;... % hypox
      kS_tissue kO_tissue kP_tissue;...   % well fed_lth
      kS_tissue kO_tissue kP_tissue;...   % well fed_react
      kS_tissue kO_tissue kP_tissue];   % well fed


      %les indices des cellules correponsdant à un état ?
      Grid(find(well_fed));

      %les indices des cellules correponsdant à un changement état ?
      Grid(find(state_change!=0));

      % Toutes les cellules dont l'état change ont un timer mis à 120
      Grid(find(state_change!=0))
      if(isempty(find(Grid(find(state_change!=0))==0))==0)
        Grid(find(state_change!=0))
        disp('problem with Grid-zero in Grid')
        save('debug_behav')
        err=1;
        return
      endif
      state(Grid(find(state_change!=0)),3) = reac_time;

      %Pour chaque cellule dont l'état change on calcule le dkS et le dkO
      %ce qui veut dire qu'on  fait état suivant moins état précédent divisé par le temps de réaction
      chg_sites = find(state_change!=0);
      %disp("state_mat:")
      %state_mat(chg_sites)
      if(isempty(find(state_mat(chg_sites)==0))==0)
        disp('chg_sites flagged a zero')
        err=1;
        save('debug')
        return
      endif
      state(Grid(chg_sites),5) = (conso_state(state_mat(chg_sites),1)-state(Grid(chg_sites),4))/reac_time;
      state(Grid(chg_sites),7) = (conso_state(state_mat(chg_sites),2)-state(Grid(chg_sites),6))/reac_time;
      state(Grid(chg_sites),9) = (conso_state(state_mat(chg_sites),3)-state(Grid(chg_sites),8))/reac_time;

      %mise à jour du vecteur d'état
      state(Grid(find(well_fed)),2)=1;
	    state(Grid(find(well_fed_react)),2)=1;
	    state(Grid(find(well_fed_lth)),2)=1;
	    state(Grid(find(hypox)),2)=0;
	    state(Grid(find(hypox_react)),2)=0;
	    state(Grid(find(hypox_lth)),2)=0;
	    state(Grid(find(hypos)),2)=1;
	    state(Grid(find(hypos_react)),2)=1;
	    state(Grid(find(hypos_lth)),2)=1;
	    state(Grid(find(hypox_hypos)),2)=0;
	    state(Grid(find(hypox_hypos_react)),2)=0;
	    state(Grid(find(hypox_hypos_lth)),2)=0;
      state(Grid(find(and(starv,Grid!=0))),2)=0;

      %marqueur vie/mort
      LD(starv) = -1;
      %LD(hypox_hypos) = -1;

         case 'OS_hypox_tol'
	%the cell tolerates hypoxia (tolerates means prolif can be kept but at w/ compensation)

   %enough of both
                   conso_state = [0 0 0;... %starved
      kS_maint kO_maint kP_maint;... % hypox hypos_lth
      kS_maint kO_maint kP_maint;... % hypox hypos_react
      kS_maint kO_maint kP_maint;... % hypox hypos
      kS_maint 2*kO_tissue kP_maint;... % hypos_lth
      kS_maint 2*kO_tissue kP_maint;... % hypos_react
      kS_maint 2*kO_tissue kP_maint;... % hypos
      2*kS_tissue kO_maint 2*kP_tissue;... % hypox_lth
      2*kS_tissue kO_maint 2*kP_tissue;... % hypox_react
      2*kS_tissue kO_maint 2*kP_tissue;... % hypox
      kS_tissue kO_tissue kP_tissue;...   % well fed_lth
      kS_tissue kO_tissue kP_tissue;...   % well fed_react
      kS_tissue kO_tissue kP_tissue];   % well fed

      %les indices des cellules correponsdant à un état ?
      Grid(find(well_fed));

      %les indices des cellules correponsdant à un changement état ?
      Grid(find(state_change!=0));

      % Toutes les cellules dont l'état change ont un timer mis à 120
      Grid(find(state_change!=0))
      if(isempty(find(Grid(find(state_change!=0))==0))==0)
        Grid(find(state_change!=0))
        disp('problem with Grid-zero in Grid')
        save('debug_behav')
        err=1;
        return
      endif
      state(Grid(find(state_change!=0)),3) = reac_time;

      %Pour chaque cellule dont l'état change on calcule le dkS et le dkO
      %ce qui veut dire qu'on  fait état suivant moins état précédent divisé par le temps de réaction
      chg_sites = find(state_change!=0);
      %disp("state_mat:")
      %state_mat(chg_sites)
      if(isempty(find(state_mat(chg_sites)==0))==0)
        disp('chg_sites flagged a zero')
        err=1;
        save('debug')
        return
      endif
      state(Grid(chg_sites),5) = (conso_state(state_mat(chg_sites),1)-state(Grid(chg_sites),4))/reac_time;
      state(Grid(chg_sites),7) = (conso_state(state_mat(chg_sites),2)-state(Grid(chg_sites),6))/reac_time;
      state(Grid(chg_sites),9) = (conso_state(state_mat(chg_sites),3)-state(Grid(chg_sites),8))/reac_time;

      %mise à jour du vecteur d'état
      state(Grid(find(well_fed)),2)=1;
	    state(Grid(find(well_fed_react)),2)=1;
	    state(Grid(find(well_fed_lth)),2)=1;
	    state(Grid(find(hypox)),2)=1;
	    state(Grid(find(hypox_react)),2)=1;
	    state(Grid(find(hypox_lth)),2)=1;
	    state(Grid(find(hypos)),2)=0;
	    state(Grid(find(hypos_react)),2)=0;
	    state(Grid(find(hypos_lth)),2)=0;
	    state(Grid(find(hypox_hypos)),2)=0;
	    state(Grid(find(hypox_hypos_react)),2)=0;
	    state(Grid(find(hypox_hypos_lth)),2)=0;
      state(Grid(find(and(starv,Grid!=0))),2)=0;
      %marqueur vie/mort
      LD(starv) = -1;
      %LD(hypox_hypos) = -1;

      	case 'OS_hypox_boost'
	%hypoxia boost prolif

   %enough of both
                         conso_state = [0 0 0;... %starved
      kS_tissue kO_maint kP_tissue;... % hypox hypos_lth
      kS_tissue kO_maint kP_tissue;... % hypox hypos_react
      kS_tissue kO_maint kP_tissue;... % hypox hypos
      kS_maint 2*kO_tissue kP_maint;... % hypos_lth
      kS_maint 2*kO_tissue kP_maint;... % hypos_react
      kS_maint 2*kO_tissue kP_maint;... % hypos
      2*kS_tissue kO_maint 2*kP_tissue;... % hypox_lth
      2*kS_tissue kO_maint 2*kP_tissue;... % hypox_react
      2*kS_tissue kO_maint 2*kP_tissue;... % hypox
      kS_tissue kO_tissue kP_tissue;...   % well fed_lth
      kS_tissue kO_tissue kP_tissue;...   % well fed_react
      kS_tissue kO_tissue kP_tissue];   % well fed

      %les indices des cellules correponsdant à un état ?
      Grid(find(well_fed));

      %les indices des cellules correponsdant à un changement état ?
      Grid(find(state_change!=0));

      % Toutes les cellules dont l'état change ont un timer mis à 120
      Grid(find(state_change!=0))
      if(isempty(find(Grid(find(state_change!=0))==0))==0)
        Grid(find(state_change!=0))
        disp('problem with Grid-zero in Grid')
        save('debug_behav')
        err=1;
        return
      endif
      state(Grid(find(state_change!=0)),3) = reac_time;

      %Pour chaque cellule dont l'état change on calcule le dkS et le dkO
      %ce qui veut dire qu'on  fait état suivant moins état précédent divisé par le temps de réaction
      chg_sites = find(state_change!=0);
      %disp("state_mat:")
      %state_mat(chg_sites)
      if(isempty(find(state_mat(chg_sites)==0))==0)
        disp('chg_sites flagged a zero')
        err=1;
        save('debug')
        return
      endif
      state(Grid(chg_sites),5) = (conso_state(state_mat(chg_sites),1)-state(Grid(chg_sites),4))/reac_time;
      state(Grid(chg_sites),7) = (conso_state(state_mat(chg_sites),2)-state(Grid(chg_sites),6))/reac_time;
      state(Grid(chg_sites),9) = (conso_state(state_mat(chg_sites),3)-state(Grid(chg_sites),8))/reac_time;

      %mise à jour du vecteur d'état
            state(Grid(find(well_fed)),2)=1;
	    state(Grid(find(well_fed_react)),2)=1;
	    state(Grid(find(well_fed_lth)),2)=1;
	    state(Grid(find(hypox)),2)=2;
	    state(Grid(find(hypox_react)),2)=2;
	    state(Grid(find(hypox_lth)),2)=2;
	    state(Grid(find(hypos)),2)=0;
	    state(Grid(find(hypos_react)),2)=0;
	    state(Grid(find(hypos_lth)),2)=0;
	    state(Grid(find(hypox_hypos)),2)=1;
	    state(Grid(find(hypox_hypos_react)),2)=1;
	    state(Grid(find(hypox_hypos_lth)),2)=1;
      state(Grid(find(and(starv,Grid!=0))),2)=0;

      %marqueur vie/mort
      LD(starv) = -1;
      %LD(hypox_hypos) = -1;

  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	%Substrate, Oxygen & Product fragile response
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  case 'OS_fragile_P_lth'
    %anything but  well fed stop proliferation & shortage of both kills
    % product in high amounts kills
      %enough of both
             conso_state = [0 0 0;... %starved
      0 0 0;... % hypox hypos_lth
      0 0 0;... % hypox hypos_react
      0 0 0;... % hypox hypos
      0 0 0;... % hypos_lth
      kS_maint kO_maint kP_maint;... % hypos_react
      kS_maint kO_maint kP_maint;... % hypos
      0 0 0;... % hypox_lth
      kS_maint kO_maint kP_maint;... % hypox_react
      kS_maint kO_maint kP_maint;... % hypox
      0 0 0;...   % well fed_lth
      kS_tissue kO_tissue kP_tissue;...   % well fed_react
      kS_tissue kO_tissue kP_tissue];   % well fed

      %les indices des cellules correponsdant à un état ?
      Grid(find(well_fed));

      %les indices des cellules correponsdant à un changement état ?
      Grid(find(state_change!=0));

      % Toutes les cellules dont l'état change ont un timer mis à 120
      Grid(find(state_change!=0))
      if(isempty(find(Grid(find(state_change!=0))==0))==0)
        Grid(find(state_change!=0))
        disp('problem with Grid-zero in Grid')
        save('debug_behav')
        err=1;
        return
      endif
      state(Grid(find(state_change!=0)),3) = reac_time;

      %Pour chaque cellule dont l'état change on calcule le dkS et le dkO
      %ce qui veut dire qu'on  fait état suivant moins état précédent divisé par le temps de réaction
      chg_sites = find(state_change!=0);
      %disp("state_mat:")
      %state_mat(chg_sites)
      if(isempty(find(state_mat(chg_sites)==0))==0)
        disp('chg_sites flagged a zero')
        err=1;
        save('debug')
        return
      endif
      state(Grid(chg_sites),5) = (conso_state(state_mat(chg_sites),1)-state(Grid(chg_sites),4))/reac_time;
      state(Grid(chg_sites),7) = (conso_state(state_mat(chg_sites),2)-state(Grid(chg_sites),6))/reac_time;
      state(Grid(chg_sites),9) = (conso_state(state_mat(chg_sites),3)-state(Grid(chg_sites),8))/reac_time;


      %mise à jour du vecteur d'état
      state(Grid(find(well_fed)),2)=1;
	    state(Grid(find(well_fed_react)),2)=1;
	    state(Grid(find(well_fed_lth)),2)=0;
	    state(Grid(find(hypox)),2)=0;
	    state(Grid(find(hypox_react)),2)=0;
	    state(Grid(find(hypox_lth)),2)=0;
	    state(Grid(find(hypos)),2)=0;
	    state(Grid(find(hypos_react)),2)=0;
	    state(Grid(find(hypos_lth)),2)=0;
	    state(Grid(find(hypox_hypos)),2)=0;
	    state(Grid(find(hypox_hypos_react)),2)=0;
	    state(Grid(find(hypox_hypos_lth)),2)=0;
      state(Grid(find(and(starv,Grid!=0))),2)=0;

      %marqueur vie/mort
      LD(starv) = -1;
      LD(hypox_hypos) = -1;
      LD(hypox_hypos_react) = -1;
      LD(hypox_hypos_lth) = -1;
      LD(hypox_lth) = -1;
      LD(hypos_lth) = -1;
      LD(well_fed_lth) = -1;


            case 'OS_fragile_P_doom_lth'
    %anything but  well fed stop proliferation & shortage of both kills
    % product in moderate amount degrades
    % product in high amounts kills too
      %enough of both
             conso_state = [0 0 0;... %starved
      0 0 0;... % hypox hypos_lth
      0 0 0;... % hypox hypos_react
      0 0 0;... % hypox hypos
      0 0 0;... % hypos_lth
      0 0 0;... % hypos_react
      kS_maint kO_maint kP_maint;... % hypos
      0 0 0;... % hypox_lth
      0 0 0;... % hypox_react
      kS_maint kO_maint kP_maint;... % hypox
      0 0 0;...   % well fed_lth
      kS_maint kO_maint kP_maint;...  % well fed_react
      kS_tissue kO_tissue kP_tissue];   % well fed

      %les indices des cellules correponsdant à un état ?
      Grid(find(well_fed));

      %les indices des cellules correponsdant à un changement état ?
      Grid(find(state_change!=0));

      % Toutes les cellules dont l'état change ont un timer mis à 120
      Grid(find(state_change!=0))
      if(isempty(find(Grid(find(state_change!=0))==0))==0)
        Grid(find(state_change!=0))
        disp('problem with Grid-zero in Grid')
        save('debug_behav')
        err=1;
        return
      endif
      state(Grid(find(state_change!=0)),3) = reac_time;

      %Pour chaque cellule dont l'état change on calcule le dkS et le dkO
      %ce qui veut dire qu'on  fait état suivant moins état précédent divisé par le temps de réaction
      chg_sites = find(state_change!=0);
      %disp("state_mat:")
      %state_mat(chg_sites)
      if(isempty(find(state_mat(chg_sites)==0))==0)
        disp('chg_sites flagged a zero')
        err=1;
        save('debug')
        return
      endif
      state(Grid(chg_sites),5) = (conso_state(state_mat(chg_sites),1)-state(Grid(chg_sites),4))/reac_time;
      state(Grid(chg_sites),7) = (conso_state(state_mat(chg_sites),2)-state(Grid(chg_sites),6))/reac_time;
      state(Grid(chg_sites),9) = (conso_state(state_mat(chg_sites),3)-state(Grid(chg_sites),8))/reac_time;


      %mise à jour du vecteur d'état
      state(Grid(find(well_fed)),2)=1;
	    state(Grid(find(well_fed_react)),2)=0;
	    state(Grid(find(well_fed_lth)),2)=0;
	    state(Grid(find(hypox)),2)=0;
	    state(Grid(find(hypox_react)),2)=0;
	    state(Grid(find(hypox_lth)),2)=0;
	    state(Grid(find(hypos)),2)=0;
	    state(Grid(find(hypos_react)),2)=0;
	    state(Grid(find(hypos_lth)),2)=0;
	    state(Grid(find(hypox_hypos)),2)=0;
	    state(Grid(find(hypox_hypos_react)),2)=0;
	    state(Grid(find(hypox_hypos_lth)),2)=0;
      state(Grid(find(and(starv,Grid!=0))),2)=0;

      %marqueur vie/mort
      LD(starv) = -1;
      LD(hypox_hypos) = -1;
      LD(hypox_hypos_react) = -1;
      LD(hypox_react) = -1;
      LD(hypos_react) = -1;
      LD(hypox_hypos_lth) = -1;
      LD(hypox_lth) = -1;
      LD(hypos_lth) = -1;
      LD(well_fed_lth) = -1;


      case 'OS_fragile_P_resc_lth'
    %anything but  well fed stop proliferation & shortage of both kills
    % product in moderate amount can be used to maintain prolif and save from the mild scarcity death
    % product in high amounts kills
      %enough of both
             conso_state = [0 0 0;... %starved
      0 0 0;... % hypox hypos_lth
      kS_maint kO_maint -kP_maint;... % hypox hypos_react
      0 0 0;... % hypox hypos
      0 0 0;... % hypos_lth
      kS_maint kO_maint -kP_maint;... % hypos_react
      kS_maint kO_maint kP_maint;... % hypos
      0 0 0;... % hypox_lth
      kS_maint kO_maint -kP_maint;... % hypox_react
      kS_maint kO_maint kP_maint;... % hypox
      0 0 0;...   % well fed_lth
      kS_tissue kO_tissue kP_tissue;...   % well fed_react
      kS_tissue kO_tissue kP_tissue];   % well fed

      %les indices des cellules correponsdant à un état ?
      Grid(find(well_fed));

      %les indices des cellules correponsdant à un changement état ?
      Grid(find(state_change!=0));

      % Toutes les cellules dont l'état change ont un timer mis à 120
      Grid(find(state_change!=0))
      if(isempty(find(Grid(find(state_change!=0))==0))==0)
        Grid(find(state_change!=0))
        disp('problem with Grid-zero in Grid')
        save('debug_behav')
        err=1;
        return
      endif
      state(Grid(find(state_change!=0)),3) = reac_time;

      %Pour chaque cellule dont l'état change on calcule le dkS et le dkO
      %ce qui veut dire qu'on  fait état suivant moins état précédent divisé par le temps de réaction
      chg_sites = find(state_change!=0);
      %disp("state_mat:")
      %state_mat(chg_sites)
      if(isempty(find(state_mat(chg_sites)==0))==0)
        disp('chg_sites flagged a zero')
        err=1;
        save('debug')
        return
      endif
      state(Grid(chg_sites),5) = (conso_state(state_mat(chg_sites),1)-state(Grid(chg_sites),4))/reac_time;
      state(Grid(chg_sites),7) = (conso_state(state_mat(chg_sites),2)-state(Grid(chg_sites),6))/reac_time;
      state(Grid(chg_sites),9) = (conso_state(state_mat(chg_sites),3)-state(Grid(chg_sites),8))/reac_time;


      %mise à jour du vecteur d'état
      state(Grid(find(well_fed)),2)=1;
	    state(Grid(find(well_fed_react)),2)=1;
	    state(Grid(find(well_fed_lth)),2)=0;
	    state(Grid(find(hypox)),2)=0;
	    state(Grid(find(hypox_react)),2)=1;
	    state(Grid(find(hypox_lth)),2)=0;
	    state(Grid(find(hypos)),2)=0;
	    state(Grid(find(hypos_react)),2)=1;
	    state(Grid(find(hypos_lth)),2)=0;
	    state(Grid(find(hypox_hypos)),2)=0;
	    state(Grid(find(hypox_hypos_react)),2)=0;
	    state(Grid(find(hypox_hypos_lth)),2)=0;
      state(Grid(find(and(starv,Grid!=0))),2)=0;

      %marqueur vie/mort
      LD(starv) = -1;
      LD(hypox_hypos) = -1;
      %LD(hypox_hypos_react) = -1;
      LD(hypox_hypos_lth) = -1;
      LD(hypox_lth) = -1;
      LD(hypos_lth) = -1;
      LD(well_fed_lth) = -1;

  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	%Substrate, Oxygen & Product hypos tol response
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   case 'OS_hypos_tol_P_lth'
	%the cell tolerates hyposubemia (tolerates means prolif can be kept but at w/ compensation)
  %the cell dies if too much product
   %enough of both
                   conso_state = [0 0 0;... %starved
      0 0 0;... % hypox hypos_lth
      kS_maint kO_maint kP_maint;... % hypox hypos_react
      kS_maint kO_maint kP_maint;... % hypox hypos
      0 0 0;... % hypos_lth
      kS_maint 2*kO_tissue kP_maint;... % hypos_react
      kS_maint 2*kO_tissue kP_maint;... % hypos
      0 0 0;... % hypox_lth
      2*kS_tissue kO_maint 2*kP_tissue;... % hypox_react
      2*kS_tissue kO_maint 2*kP_tissue;... % hypox
      0 0 0;...   % well fed_lth
      kS_tissue kO_tissue kP_tissue;...   % well fed_react
      kS_tissue kO_tissue kP_tissue];   % well fed


      %les indices des cellules correponsdant à un état ?
      Grid(find(well_fed));

      %les indices des cellules correponsdant à un changement état ?
      Grid(find(state_change!=0));

      % Toutes les cellules dont l'état change ont un timer mis à 120
      Grid(find(state_change!=0))
      if(isempty(find(Grid(find(state_change!=0))==0))==0)
        Grid(find(state_change!=0))
        disp('problem with Grid-zero in Grid')
        save('debug_behav')
        err=1;
        return
      endif
      state(Grid(find(state_change!=0)),3) = reac_time;

      %Pour chaque cellule dont l'état change on calcule le dkS et le dkO
      %ce qui veut dire qu'on  fait état suivant moins état précédent divisé par le temps de réaction
      chg_sites = find(state_change!=0);
      %disp("state_mat:")
      %state_mat(chg_sites)
      if(isempty(find(state_mat(chg_sites)==0))==0)
        disp('chg_sites flagged a zero')
        err=1;
        save('debug')
        return
      endif
      state(Grid(chg_sites),5) = (conso_state(state_mat(chg_sites),1)-state(Grid(chg_sites),4))/reac_time;
      state(Grid(chg_sites),7) = (conso_state(state_mat(chg_sites),2)-state(Grid(chg_sites),6))/reac_time;
      state(Grid(chg_sites),9) = (conso_state(state_mat(chg_sites),3)-state(Grid(chg_sites),8))/reac_time;

      %mise à jour du vecteur d'état
      state(Grid(find(well_fed)),2)=1;
	    state(Grid(find(well_fed_react)),2)=1;
	    state(Grid(find(well_fed_lth)),2)=0;
	    state(Grid(find(hypox)),2)=0;
	    state(Grid(find(hypox_react)),2)=0;
	    state(Grid(find(hypox_lth)),2)=0;
	    state(Grid(find(hypos)),2)=1;
	    state(Grid(find(hypos_react)),2)=1;
	    state(Grid(find(hypos_lth)),2)=0;
	    state(Grid(find(hypox_hypos)),2)=0;
	    state(Grid(find(hypox_hypos_react)),2)=0;
	    state(Grid(find(hypox_hypos_lth)),2)=0;
      state(Grid(find(and(starv,Grid!=0))),2)=0;

      %marqueur vie/mort
      LD(starv) = -1;
      LD(well_fed_lth) = -1;
      LD(hypox_lth) = -1;
      LD(hypos_lth) = -1;
      LD(hypox_hypos_lth) = -1;
      %LD(hypox_hypos) = -1;

         case 'OS_hypos_tol_P_doom_lth'
	%the cell tolerates hyposubemia (tolerates means prolif can be kept but at w/ compensation)
  %the cell degrades if moderate product
   %enough of both
                   conso_state = [0 0 0;... %starved
      0 0 0;... % hypox hypos_lth
      0 0 0;... % hypox hypos_react
      kS_maint kO_maint kP_maint;... % hypox hypos
      0 0 0;... % hypos_lth
      kS_maint 2*kO_tissue kP_maint;... % hypos_react
      kS_maint 2*kO_tissue kP_maint;... % hypos
      0 0 0;... % hypox_lth
      0 0 0;... % hypox_react
      2*kS_tissue kO_maint 2*kP_tissue;... % hypox
      0 0 0;...   % well fed_lth
      kS_maint kO_maint kP_maint;...   % well fed_react
      kS_tissue kO_tissue kP_tissue];   % well fed


      %les indices des cellules correponsdant à un état ?
      Grid(find(well_fed));

      %les indices des cellules correponsdant à un changement état ?
      Grid(find(state_change!=0));

      % Toutes les cellules dont l'état change ont un timer mis à 120
      Grid(find(state_change!=0))
      if(isempty(find(Grid(find(state_change!=0))==0))==0)
        Grid(find(state_change!=0))
        disp('problem with Grid-zero in Grid')
        save('debug_behav')
        err=1;
        return
      endif
      state(Grid(find(state_change!=0)),3) = reac_time;

      %Pour chaque cellule dont l'état change on calcule le dkS et le dkO
      %ce qui veut dire qu'on  fait état suivant moins état précédent divisé par le temps de réaction
      chg_sites = find(state_change!=0);
      %disp("state_mat:")
      %state_mat(chg_sites)
      if(isempty(find(state_mat(chg_sites)==0))==0)
        disp('chg_sites flagged a zero')
        err=1;
        save('debug')
        return
      endif
      state(Grid(chg_sites),5) = (conso_state(state_mat(chg_sites),1)-state(Grid(chg_sites),4))/reac_time;
      state(Grid(chg_sites),7) = (conso_state(state_mat(chg_sites),2)-state(Grid(chg_sites),6))/reac_time;
      state(Grid(chg_sites),9) = (conso_state(state_mat(chg_sites),3)-state(Grid(chg_sites),8))/reac_time;

      %mise à jour du vecteur d'état
      state(Grid(find(well_fed)),2)=1;
	    state(Grid(find(well_fed_react)),2)=0;
	    state(Grid(find(well_fed_lth)),2)=0;
	    state(Grid(find(hypox)),2)=0;
	    state(Grid(find(hypox_react)),2)=0;
	    state(Grid(find(hypox_lth)),2)=0;
	    state(Grid(find(hypos)),2)=1;
	    state(Grid(find(hypos_react)),2)=0;
	    state(Grid(find(hypos_lth)),2)=0;
	    state(Grid(find(hypox_hypos)),2)=0;
	    state(Grid(find(hypox_hypos_react)),2)=0;
	    state(Grid(find(hypox_hypos_lth)),2)=0;
      state(Grid(find(and(starv,Grid!=0))),2)=0;

      %marqueur vie/mort
      LD(starv) = -1;
      LD(well_fed_lth) = -1;
      LD(hypox_lth) = -1;
      LD(hypox_react) = -1;
      LD(hypos_lth) = -1;
      LD(hypox_hypos_lth) = -1;
      LD(hypox_hypos_react) = -1;
      %LD(hypox_hypos) = -1;


        case 'OS_hypos_tol_P_resc_lth'
	%the cell tolerates hyposubemia (tolerates means prolif can be kept but at w/ compensation)
  %the cell restores prolif if moderate product
   %enough of both
                   conso_state = [0 0 0;... %starved
      0 0 0;... % hypox hypos_lth
      kS_maint kO_maint -kP_maint;... % hypox hypos_react
      kS_maint kO_maint kP_maint;... % hypox hypos
      0 0 0;... % hypos_lth
      kS_maint 2*kO_tissue kP_maint;... % hypos_react
      kS_maint 2*kO_tissue kP_maint;... % hypos
      0 0 0;... % hypox_lth
      2*kS_tissue kO_maint -2*kP_tissue;... % hypox_react
      2*kS_tissue kO_maint 2*kP_tissue;... % hypox
      0 0 0;...   % well fed_lth
      kS_tissue kO_tissue kP_tissue;...   % well fed_react
      kS_tissue kO_tissue kP_tissue];   % well fed


      %les indices des cellules correponsdant à un état ?
      Grid(find(well_fed));

      %les indices des cellules correponsdant à un changement état ?
      Grid(find(state_change!=0));

      % Toutes les cellules dont l'état change ont un timer mis à 120
      Grid(find(state_change!=0))
      if(isempty(find(Grid(find(state_change!=0))==0))==0)
        Grid(find(state_change!=0))
        disp('problem with Grid-zero in Grid')
        save('debug_behav')
        err=1;
        return
      endif
      state(Grid(find(state_change!=0)),3) = reac_time;

      %Pour chaque cellule dont l'état change on calcule le dkS et le dkO
      %ce qui veut dire qu'on  fait état suivant moins état précédent divisé par le temps de réaction
      chg_sites = find(state_change!=0);
      %disp("state_mat:")
      %state_mat(chg_sites)
      if(isempty(find(state_mat(chg_sites)==0))==0)
        disp('chg_sites flagged a zero')
        err=1;
        save('debug')
        return
      endif
      state(Grid(chg_sites),5) = (conso_state(state_mat(chg_sites),1)-state(Grid(chg_sites),4))/reac_time;
      state(Grid(chg_sites),7) = (conso_state(state_mat(chg_sites),2)-state(Grid(chg_sites),6))/reac_time;
      state(Grid(chg_sites),9) = (conso_state(state_mat(chg_sites),3)-state(Grid(chg_sites),8))/reac_time;

      %mise à jour du vecteur d'état
      state(Grid(find(well_fed)),2)=1;
	    state(Grid(find(well_fed_react)),2)=1;
	    state(Grid(find(well_fed_lth)),2)=0;
	    state(Grid(find(hypox)),2)=0;
	    state(Grid(find(hypox_react)),2)=1;
	    state(Grid(find(hypox_lth)),2)=0;
	    state(Grid(find(hypos)),2)=1;
	    state(Grid(find(hypos_react)),2)=1;
	    state(Grid(find(hypos_lth)),2)=0;
	    state(Grid(find(hypox_hypos)),2)=0;
	    state(Grid(find(hypox_hypos_react)),2)=1;
	    state(Grid(find(hypox_hypos_lth)),2)=0;
      state(Grid(find(and(starv,Grid!=0))),2)=0;

      %marqueur vie/mort
      LD(starv) = -1;
      LD(well_fed_lth) = -1;
      LD(hypox_lth) = -1;
      %LD(hypox_react) = -1;
      LD(hypos_lth) = -1;
      LD(hypox_hypos_lth) = -1;
      %LD(hypox_hypos_react) = -1;
      %LD(hypox_hypos) = -1;

      case 'OS_hypos_tol_P_boost_lth'
	%the cell tolerates hyposubemia (tolerates means prolif can be kept but at w/ compensation)
  %the cell prolif is boosted if moderate product
   %enough of both
                   conso_state = [0 0 0;... %starved
      0 0 0;... % hypox hypos_lth
      kS_maint kO_maint -kP_maint;... % hypox hypos_react
      kS_maint kO_maint kP_maint;... % hypox hypos
      0 0 0;... % hypos_lth
      kS_maint 2*kO_tissue -kP_maint;... % hypos_react
      kS_maint 2*kO_tissue kP_maint;... % hypos
      0 0 0;... % hypox_lth
      2*kS_tissue kO_maint -2*kP_tissue;... % hypox_react
      2*kS_tissue kO_maint 2*kP_tissue;... % hypox
      0 0 0;...   % well fed_lth
      kS_tissue kO_tissue -kP_tissue;...   % well fed_react
      kS_tissue kO_tissue kP_tissue];   % well fed


      %les indices des cellules correponsdant à un état ?
      Grid(find(well_fed));

      %les indices des cellules correponsdant à un changement état ?
      Grid(find(state_change!=0));

      % Toutes les cellules dont l'état change ont un timer mis à 120
      Grid(find(state_change!=0))
      if(isempty(find(Grid(find(state_change!=0))==0))==0)
        Grid(find(state_change!=0))
        disp('problem with Grid-zero in Grid')
        save('debug_behav')
        err=1;
        return
      endif
      state(Grid(find(state_change!=0)),3) = reac_time;

      %Pour chaque cellule dont l'état change on calcule le dkS et le dkO
      %ce qui veut dire qu'on  fait état suivant moins état précédent divisé par le temps de réaction
      chg_sites = find(state_change!=0);
      %disp("state_mat:")
      %state_mat(chg_sites)
      if(isempty(find(state_mat(chg_sites)==0))==0)
        disp('chg_sites flagged a zero')
        err=1;
        save('debug')
        return
      endif
      state(Grid(chg_sites),5) = (conso_state(state_mat(chg_sites),1)-state(Grid(chg_sites),4))/reac_time;
      state(Grid(chg_sites),7) = (conso_state(state_mat(chg_sites),2)-state(Grid(chg_sites),6))/reac_time;
      state(Grid(chg_sites),9) = (conso_state(state_mat(chg_sites),3)-state(Grid(chg_sites),8))/reac_time;

      %mise à jour du vecteur d'état
      state(Grid(find(well_fed)),2)=1;
	    state(Grid(find(well_fed_react)),2)=2;
	    state(Grid(find(well_fed_lth)),2)=0;
	    state(Grid(find(hypox)),2)=0;
	    state(Grid(find(hypox_react)),2)=1;
	    state(Grid(find(hypox_lth)),2)=0;
	    state(Grid(find(hypos)),2)=1;
	    state(Grid(find(hypos_react)),2)=2;
	    state(Grid(find(hypos_lth)),2)=0;
	    state(Grid(find(hypox_hypos)),2)=0;
	    state(Grid(find(hypox_hypos_react)),2)=1;
	    state(Grid(find(hypox_hypos_lth)),2)=0;
      state(Grid(find(and(starv,Grid!=0))),2)=0;

      %marqueur vie/mort
      LD(starv) = -1;
      LD(well_fed_lth) = -1;
      LD(hypox_lth) = -1;
      %LD(hypox_react) = -1;
      LD(hypos_lth) = -1;
      LD(hypox_hypos_lth) = -1;
      %LD(hypox_hypos_react) = -1;
      %LD(hypox_hypos) = -1;


  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %Substrate, Oxygen & Product hypox tol response
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

      case 'OS_hypox_tol_P_lth'
	%the cell tolerates hypoxia (tolerates means prolif can be kept but at w/ compensation)

   %enough of both
                   conso_state = [0 0 0;... %starved
      0 0 0;... % hypox hypos_lth
      kS_maint kO_maint kP_maint;... % hypox hypos_react
      kS_maint kO_maint kP_maint;... % hypox hypos
      0 0 0;... % hypos_lth
      kS_maint 2*kO_tissue kP_maint;... % hypos_react
      kS_maint 2*kO_tissue kP_maint;... % hypos
      0 0 0;... % hypox_lth
      2*kS_tissue kO_maint 2*kP_tissue;... % hypox_react
      2*kS_tissue kO_maint 2*kP_tissue;... % hypox
      0 0 0;...   % well fed_lth
      kS_tissue kO_tissue kP_tissue;...   % well fed_react
      kS_tissue kO_tissue kP_tissue];   % well fed

      %les indices des cellules correponsdant à un état ?
      Grid(find(well_fed));

      %les indices des cellules correponsdant à un changement état ?
      Grid(find(state_change!=0));

      % Toutes les cellules dont l'état change ont un timer mis à 120
      Grid(find(state_change!=0))
      if(isempty(find(Grid(find(state_change!=0))==0))==0)
        Grid(find(state_change!=0))
        disp('problem with Grid-zero in Grid')
        save('debug_behav')
        err=1;
        return
      endif
      state(Grid(find(state_change!=0)),3) = reac_time;

      %Pour chaque cellule dont l'état change on calcule le dkS et le dkO
      %ce qui veut dire qu'on  fait état suivant moins état précédent divisé par le temps de réaction
      chg_sites = find(state_change!=0);
      %disp("state_mat:")
      %state_mat(chg_sites)
      if(isempty(find(state_mat(chg_sites)==0))==0)
        disp('chg_sites flagged a zero')
        err=1;
        save('debug')
        return
      endif
      state(Grid(chg_sites),5) = (conso_state(state_mat(chg_sites),1)-state(Grid(chg_sites),4))/reac_time;
      state(Grid(chg_sites),7) = (conso_state(state_mat(chg_sites),2)-state(Grid(chg_sites),6))/reac_time;
      state(Grid(chg_sites),9) = (conso_state(state_mat(chg_sites),3)-state(Grid(chg_sites),8))/reac_time;

      %mise à jour du vecteur d'état
      state(Grid(find(well_fed)),2)=1;
	    state(Grid(find(well_fed_react)),2)=1;
	    state(Grid(find(well_fed_lth)),2)=0;
	    state(Grid(find(hypox)),2)=1;
	    state(Grid(find(hypox_react)),2)=1;
	    state(Grid(find(hypox_lth)),2)=0;
	    state(Grid(find(hypos)),2)=0;
	    state(Grid(find(hypos_react)),2)=0;
	    state(Grid(find(hypos_lth)),2)=0;
	    state(Grid(find(hypox_hypos)),2)=0;
	    state(Grid(find(hypox_hypos_react)),2)=0;
	    state(Grid(find(hypox_hypos_lth)),2)=0;
      state(Grid(find(and(starv,Grid!=0))),2)=0;

      %marqueur vie/mort
      LD(starv) = -1;
      LD(well_fed_lth) = -1;
      LD(hypox_lth) = -1;
      LD(hypos_lth) = -1;
      LD(hypox_hypos_lth) = -1;
      %LD(hypox_hypos) = -1;

 case 'OS_hypox_tol_P_doom_lth'
	%the cell tolerates hypoxia (tolerates means prolif can be kept but at w/ compensation)
  %the cell degrades if moderate product
   %enough of both
                   conso_state = [0 0 0;... %starved
      0 0 0;... % hypox hypos_lth
      0 0 0;... % hypox hypos_react
      kS_maint kO_maint kP_maint;... % hypox hypos
      0 0 0;... % hypos_lth
      0 0 0;... % hypos_react
      kS_maint 2*kO_tissue kP_maint;... % hypos
      0 0 0;... % hypox_lth
      kS_tissue kO_maint kP_tissue;... % hypox_react
      2*kS_tissue kO_maint 2*kP_tissue;... % hypox
      0 0 0;...   % well fed_lth
      kS_maint kO_maint kP_maint;...   % well fed_react
      kS_tissue kO_tissue kP_tissue];   % well fed

      %les indices des cellules correponsdant à un état ?
      Grid(find(well_fed));

      %les indices des cellules correponsdant à un changement état ?
      Grid(find(state_change!=0));

      % Toutes les cellules dont l'état change ont un timer mis à 120
      Grid(find(state_change!=0))
      if(isempty(find(Grid(find(state_change!=0))==0))==0)
        Grid(find(state_change!=0))
        disp('problem with Grid-zero in Grid')
        save('debug_behav')
        err=1;
        return
      endif
      state(Grid(find(state_change!=0)),3) = reac_time;

      %Pour chaque cellule dont l'état change on calcule le dkS et le dkO
      %ce qui veut dire qu'on  fait état suivant moins état précédent divisé par le temps de réaction
      chg_sites = find(state_change!=0);
      %disp("state_mat:")
      %state_mat(chg_sites)
      if(isempty(find(state_mat(chg_sites)==0))==0)
        disp('chg_sites flagged a zero')
        err=1;
        save('debug')
        return
      endif
      state(Grid(chg_sites),5) = (conso_state(state_mat(chg_sites),1)-state(Grid(chg_sites),4))/reac_time;
      state(Grid(chg_sites),7) = (conso_state(state_mat(chg_sites),2)-state(Grid(chg_sites),6))/reac_time;
      state(Grid(chg_sites),9) = (conso_state(state_mat(chg_sites),3)-state(Grid(chg_sites),8))/reac_time;

      %mise à jour du vecteur d'état
      state(Grid(find(well_fed)),2)=1;
	    state(Grid(find(well_fed_react)),2)=0;
	    state(Grid(find(well_fed_lth)),2)=0;
	    state(Grid(find(hypox)),2)=1;
	    state(Grid(find(hypox_react)),2)=0;
	    state(Grid(find(hypox_lth)),2)=0;
	    state(Grid(find(hypos)),2)=0;
	    state(Grid(find(hypos_react)),2)=0;
	    state(Grid(find(hypos_lth)),2)=0;
	    state(Grid(find(hypox_hypos)),2)=0;
	    state(Grid(find(hypox_hypos_react)),2)=0;
	    state(Grid(find(hypox_hypos_lth)),2)=0;
      state(Grid(find(and(starv,Grid!=0))),2)=0;

      %marqueur vie/mort
      LD(starv) = -1;
      LD(well_fed_lth) = -1;
      LD(hypox_lth) = -1;
      LD(hypos_lth) = -1;
      LD(hypos_react) = -1;
      LD(hypox_hypos_lth) = -1;
      LD(hypox_hypos_react) = -1;
      %LD(hypox_hypos) = -1;

      case 'OS_hypox_tol_P_resc_lth'
	%the cell tolerates hypoxia (tolerates means prolif can be kept but at w/ compensation)
  %product restores prolif in moderate amount (if it has stopped)
   %enough of both
                   conso_state = [0 0 0;... %starved
      0 0 0;... % hypox hypos_lth
      kS_maint kO_maint -kP_maint;... % hypox hypos_react
      kS_maint kO_maint kP_maint;... % hypox hypos
      0 0 0;... % hypos_lth
      kS_maint 2*kO_tissue -kP_maint;... % hypos_react
      kS_maint 2*kO_tissue kP_maint;... % hypos
      0 0 0;... % hypox_lth
      2*kS_tissue kO_maint 2*kP_tissue;... % hypox_react
      2*kS_tissue kO_maint 2*kP_tissue;... % hypox
      0 0 0;...   % well fed_lth
      kS_tissue kO_tissue kP_tissue;...   % well fed_react
      kS_tissue kO_tissue kP_tissue];   % well fed

      %les indices des cellules correponsdant à un état ?
      Grid(find(well_fed));

      %les indices des cellules correponsdant à un changement état ?
      Grid(find(state_change!=0));

      % Toutes les cellules dont l'état change ont un timer mis à 120
      Grid(find(state_change!=0))
      if(isempty(find(Grid(find(state_change!=0))==0))==0)
        Grid(find(state_change!=0))
        disp('problem with Grid-zero in Grid')
        save('debug_behav')
        err=1;
        return
      endif
      state(Grid(find(state_change!=0)),3) = reac_time;

      %Pour chaque cellule dont l'état change on calcule le dkS et le dkO
      %ce qui veut dire qu'on  fait état suivant moins état précédent divisé par le temps de réaction
      chg_sites = find(state_change!=0);
      %disp("state_mat:")
      %state_mat(chg_sites)
      if(isempty(find(state_mat(chg_sites)==0))==0)
        disp('chg_sites flagged a zero')
        err=1;
        save('debug')
        return
      endif
      state(Grid(chg_sites),5) = (conso_state(state_mat(chg_sites),1)-state(Grid(chg_sites),4))/reac_time;
      state(Grid(chg_sites),7) = (conso_state(state_mat(chg_sites),2)-state(Grid(chg_sites),6))/reac_time;
      state(Grid(chg_sites),9) = (conso_state(state_mat(chg_sites),3)-state(Grid(chg_sites),8))/reac_time;

      %mise à jour du vecteur d'état
      state(Grid(find(well_fed)),2)=1;
	    state(Grid(find(well_fed_react)),2)=1;
	    state(Grid(find(well_fed_lth)),2)=0;
	    state(Grid(find(hypox)),2)=1;
	    state(Grid(find(hypox_react)),2)=1;
	    state(Grid(find(hypox_lth)),2)=0;
	    state(Grid(find(hypos)),2)=0;
	    state(Grid(find(hypos_react)),2)=1;
	    state(Grid(find(hypos_lth)),2)=0;
	    state(Grid(find(hypox_hypos)),2)=0;
	    state(Grid(find(hypox_hypos_react)),2)=1;
	    state(Grid(find(hypox_hypos_lth)),2)=0;
      state(Grid(find(and(starv,Grid!=0))),2)=0;

      %marqueur vie/mort
      LD(starv) = -1;
      LD(well_fed_lth) = -1;
      LD(hypox_lth) = -1;
      LD(hypos_lth) = -1;
      LD(hypox_hypos_lth) = -1;
      %LD(hypox_hypos) = -1;

      case 'OS_hypox_tol_P_boost_lth'
	%the cell tolerates hypoxia (tolerates means prolif can be kept but at w/ compensation)
  %the cell prolif is boosted if moderate product
   %enough of both
                   conso_state = [0 0 0;... %starved
      0 0 0;... % hypox hypos_lth
      kS_maint kO_maint -kP_maint;... % hypox hypos_react
      kS_maint kO_maint kP_maint;... % hypox hypos
      0 0 0;... % hypos_lth
      kS_maint 2*kO_tissue -kP_maint;... % hypos_react
      kS_maint 2*kO_tissue kP_maint;... % hypos
      0 0 0;... % hypox_lth
      2*kS_tissue kO_maint -2*kP_tissue;... % hypox_react
      2*kS_tissue kO_maint 2*kP_tissue;... % hypox
      0 0 0;...   % well fed_lth
      kS_tissue kO_tissue -kP_tissue;...   % well fed_react
      kS_tissue kO_tissue kP_tissue];   % well fed

      %les indices des cellules correponsdant à un état ?
      Grid(find(well_fed));

      %les indices des cellules correponsdant à un changement état ?
      Grid(find(state_change!=0));

      % Toutes les cellules dont l'état change ont un timer mis à 120
      Grid(find(state_change!=0))
      if(isempty(find(Grid(find(state_change!=0))==0))==0)
        Grid(find(state_change!=0))
        disp('problem with Grid-zero in Grid')
        save('debug_behav')
        err=1;
        return
      endif
      state(Grid(find(state_change!=0)),3) = reac_time;

      %Pour chaque cellule dont l'état change on calcule le dkS et le dkO
      %ce qui veut dire qu'on  fait état suivant moins état précédent divisé par le temps de réaction
      chg_sites = find(state_change!=0);
      %disp("state_mat:")
      %state_mat(chg_sites)
      if(isempty(find(state_mat(chg_sites)==0))==0)
        disp('chg_sites flagged a zero')
        err=1;
        save('debug')
        return
      endif
      state(Grid(chg_sites),5) = (conso_state(state_mat(chg_sites),1)-state(Grid(chg_sites),4))/reac_time;
      state(Grid(chg_sites),7) = (conso_state(state_mat(chg_sites),2)-state(Grid(chg_sites),6))/reac_time;
      state(Grid(chg_sites),9) = (conso_state(state_mat(chg_sites),3)-state(Grid(chg_sites),8))/reac_time;

      %mise à jour du vecteur d'état
      state(Grid(find(well_fed)),2)=1;
	    state(Grid(find(well_fed_react)),2)=2;
	    state(Grid(find(well_fed_lth)),2)=0;
	    state(Grid(find(hypox)),2)=1;
	    state(Grid(find(hypox_react)),2)=2;
	    state(Grid(find(hypox_lth)),2)=0;
	    state(Grid(find(hypos)),2)=0;
	    state(Grid(find(hypos_react)),2)=1;
	    state(Grid(find(hypos_lth)),2)=0;
	    state(Grid(find(hypox_hypos)),2)=0;
	    state(Grid(find(hypox_hypos_react)),2)=1;
	    state(Grid(find(hypox_hypos_lth)),2)=0;
      state(Grid(find(and(starv,Grid!=0))),2)=0;

      %marqueur vie/mort
      LD(starv) = -1;
      LD(well_fed_lth) = -1;
      LD(hypox_lth) = -1;
      LD(hypos_lth) = -1;
      LD(hypox_hypos_lth) = -1;
      %LD(hypox_hypos) = -1;



  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %Substrate, Oxygen & Product hypox tol response
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    case 'OS_hypox_boost_P_lth'
	    %hypoxia boost prolif

   %enough of both
                         conso_state = [0 0 0;... %starved
      0 0 0;... % hypox hypos_lth
      kS_tissue kO_maint kP_tissue;... % hypox hypos_react
      kS_tissue kO_maint kP_tissue;... % hypox hypos
      0 0 0;... % hypos_lth
      kS_maint 2*kO_tissue kP_maint;... % hypos_react
      kS_maint 2*kO_tissue kP_maint;... % hypos
      0 0 0;... % hypox_lth
      2*kS_tissue kO_maint 2*kP_tissue;... % hypox_react
      2*kS_tissue kO_maint 2*kP_tissue;... % hypox
      0 0 0;...   % well fed_lth
      kS_tissue kO_tissue kP_tissue;...   % well fed_react
      kS_tissue kO_tissue kP_tissue];   % well fed

      %les indices des cellules correponsdant à un état ?
      Grid(find(well_fed));

      %les indices des cellules correponsdant à un changement état ?
      Grid(find(state_change!=0));

      % Toutes les cellules dont l'état change ont un timer mis à 120
      Grid(find(state_change!=0))
      if(isempty(find(Grid(find(state_change!=0))==0))==0)
        Grid(find(state_change!=0))
        disp('problem with Grid-zero in Grid')
        save('debug_behav')
        err=1;
        return
      endif
      state(Grid(find(state_change!=0)),3) = reac_time;

      %Pour chaque cellule dont l'état change on calcule le dkS et le dkO
      %ce qui veut dire qu'on  fait état suivant moins état précédent divisé par le temps de réaction
      chg_sites = find(state_change!=0);
      %disp("state_mat:")
      %state_mat(chg_sites)
      if(isempty(find(state_mat(chg_sites)==0))==0)
        disp('chg_sites flagged a zero')
        err=1;
        save('debug')
        return
      endif
      state(Grid(chg_sites),5) = (conso_state(state_mat(chg_sites),1)-state(Grid(chg_sites),4))/reac_time;
      state(Grid(chg_sites),7) = (conso_state(state_mat(chg_sites),2)-state(Grid(chg_sites),6))/reac_time;
      state(Grid(chg_sites),9) = (conso_state(state_mat(chg_sites),3)-state(Grid(chg_sites),8))/reac_time;

      %mise à jour du vecteur d'état
            state(Grid(find(well_fed)),2)=1;
	    state(Grid(find(well_fed_react)),2)=1;
	    state(Grid(find(well_fed_lth)),2)=0;
	    state(Grid(find(hypox)),2)=2;
	    state(Grid(find(hypox_react)),2)=2;
	    state(Grid(find(hypox_lth)),2)=0;
	    state(Grid(find(hypos)),2)=0;
	    state(Grid(find(hypos_react)),2)=0;
	    state(Grid(find(hypos_lth)),2)=0;
	    state(Grid(find(hypox_hypos)),2)=1;
	    state(Grid(find(hypox_hypos_react)),2)=1;
	    state(Grid(find(hypox_hypos_lth)),2)=0;
      state(Grid(find(and(starv,Grid!=0))),2)=0;

      %marqueur vie/mort
      LD(starv) = -1;
      LD(well_fed_lth) = -1;
      LD(hypox_lth) = -1;
      LD(hypos_lth) = -1;
      LD(hypox_hypos_lth) = -1;

    case 'OS_hypox_boost_P_doom_lth'
	    %hypoxia boost prolif
      %the cell degrades if moderate product
   %enough of both
                         conso_state = [0 0 0;... %starved
      0 0 0;... % hypox hypos_lth
      kS_maint kO_maint kP_maint;... % hypox hypos_react
      kS_tissue kO_maint kP_tissue;... % hypox hypos
      0 0 0;... % hypos_lth
      0 0 0;... % hypos_react
      kS_maint 2*kO_tissue kP_maint;... % hypos
      0 0 0;... % hypox_lth
      kS_tissue kO_maint kP_tissue;... % hypox_react
      2*kS_tissue kO_maint 2*kP_tissue;... % hypox
      0 0 0;...   % well fed_lth
      kS_maint kO_maint kP_maint;...   % well fed_react
      kS_tissue kO_tissue kP_tissue];   % well fed

      %les indices des cellules correponsdant à un état ?
      Grid(find(well_fed));

      %les indices des cellules correponsdant à un changement état ?
      Grid(find(state_change!=0));

      % Toutes les cellules dont l'état change ont un timer mis à 120
      Grid(find(state_change!=0))
      if(isempty(find(Grid(find(state_change!=0))==0))==0)
        Grid(find(state_change!=0))
        disp('problem with Grid-zero in Grid')
        save('debug_behav')
        err=1;
        return
      endif
      state(Grid(find(state_change!=0)),3) = reac_time;

      %Pour chaque cellule dont l'état change on calcule le dkS et le dkO
      %ce qui veut dire qu'on  fait état suivant moins état précédent divisé par le temps de réaction
      chg_sites = find(state_change!=0);
      %disp("state_mat:")
      %state_mat(chg_sites)
      if(isempty(find(state_mat(chg_sites)==0))==0)
        disp('chg_sites flagged a zero')
        err=1;
        save('debug')
        return
      endif
      state(Grid(chg_sites),5) = (conso_state(state_mat(chg_sites),1)-state(Grid(chg_sites),4))/reac_time;
      state(Grid(chg_sites),7) = (conso_state(state_mat(chg_sites),2)-state(Grid(chg_sites),6))/reac_time;
      state(Grid(chg_sites),9) = (conso_state(state_mat(chg_sites),3)-state(Grid(chg_sites),8))/reac_time;

      %mise à jour du vecteur d'état
            state(Grid(find(well_fed)),2)=1;
	    state(Grid(find(well_fed_react)),2)=0;
	    state(Grid(find(well_fed_lth)),2)=0;
	    state(Grid(find(hypox)),2)=2;
	    state(Grid(find(hypox_react)),2)=1;
	    state(Grid(find(hypox_lth)),2)=0;
	    state(Grid(find(hypos)),2)=0;
	    state(Grid(find(hypos_react)),2)=0;
	    state(Grid(find(hypos_lth)),2)=0;
	    state(Grid(find(hypox_hypos)),2)=1;
	    state(Grid(find(hypox_hypos_react)),2)=0;
	    state(Grid(find(hypox_hypos_lth)),2)=0;
      state(Grid(find(and(starv,Grid!=0))),2)=0;

      %marqueur vie/mort
      LD(starv) = -1;
      LD(well_fed_lth) = -1;
      LD(hypox_lth) = -1;
      LD(hypos_lth) = -1;
      LD(hypos_react) = -1;
      LD(hypox_hypos_lth) = -1;
      %LD(hypox_hypos_react) = -1;

      case 'OS_hypox_boost_P_resc_lth'
	    %hypoxia boost prolif
      %moderate product restores prolif if lost
   %enough of both
                         conso_state = [0 0 0;... %starved
      0 0 0;... % hypox hypos_lth
      kS_tissue kO_maint kP_tissue;... % hypox hypos_react
      kS_tissue kO_maint kP_tissue;... % hypox hypos
      0 0 0;... % hypos_lth
      kS_maint 2*kO_tissue -kP_maint;... % hypos_react
      kS_maint 2*kO_tissue kP_maint;... % hypos
      0 0 0;... % hypox_lth
      2*kS_tissue kO_maint 2*kP_tissue;... % hypox_react
      2*kS_tissue kO_maint 2*kP_tissue;... % hypox
      0 0 0;...   % well fed_lth
      kS_tissue kO_tissue kP_tissue;...   % well fed_react
      kS_tissue kO_tissue kP_tissue];   % well fed

      %les indices des cellules correponsdant à un état ?
      Grid(find(well_fed));

      %les indices des cellules correponsdant à un changement état ?
      Grid(find(state_change!=0));

      % Toutes les cellules dont l'état change ont un timer mis à 120
      Grid(find(state_change!=0))
      if(isempty(find(Grid(find(state_change!=0))==0))==0)
        Grid(find(state_change!=0))
        disp('problem with Grid-zero in Grid')
        save('debug_behav')
        err=1;
        return
      endif
      state(Grid(find(state_change!=0)),3) = reac_time;

      %Pour chaque cellule dont l'état change on calcule le dkS et le dkO
      %ce qui veut dire qu'on  fait état suivant moins état précédent divisé par le temps de réaction
      chg_sites = find(state_change!=0);
      %disp("state_mat:")
      %state_mat(chg_sites)
      if(isempty(find(state_mat(chg_sites)==0))==0)
        disp('chg_sites flagged a zero')
        err=1;
        save('debug')
        return
      endif
      state(Grid(chg_sites),5) = (conso_state(state_mat(chg_sites),1)-state(Grid(chg_sites),4))/reac_time;
      state(Grid(chg_sites),7) = (conso_state(state_mat(chg_sites),2)-state(Grid(chg_sites),6))/reac_time;
      state(Grid(chg_sites),9) = (conso_state(state_mat(chg_sites),3)-state(Grid(chg_sites),8))/reac_time;

      %mise à jour du vecteur d'état
            state(Grid(find(well_fed)),2)=1;
	    state(Grid(find(well_fed_react)),2)=1;
	    state(Grid(find(well_fed_lth)),2)=0;
	    state(Grid(find(hypox)),2)=2;
	    state(Grid(find(hypox_react)),2)=2;
	    state(Grid(find(hypox_lth)),2)=0;
	    state(Grid(find(hypos)),2)=0;
	    state(Grid(find(hypos_react)),2)=1;
	    state(Grid(find(hypos_lth)),2)=0;
	    state(Grid(find(hypox_hypos)),2)=1;
	    state(Grid(find(hypox_hypos_react)),2)=1;
	    state(Grid(find(hypox_hypos_lth)),2)=0;
      state(Grid(find(and(starv,Grid!=0))),2)=0;

      %marqueur vie/mort
      LD(starv) = -1;
      LD(well_fed_lth) = -1;
      LD(hypox_lth) = -1;
      LD(hypos_lth) = -1;
      LD(hypox_hypos_lth) = -1;

      case 'OS_hypox_boost_P_boost_lth'
	    %hypoxia boost prolif
      %moderate product boost prolif
   %enough of both
                         conso_state = [0 0 0;... %starved
      0 0 0;... % hypox hypos_lth
      kS_tissue kO_maint -kP_tissue;... % hypox hypos_react
      kS_tissue kO_maint kP_tissue;... % hypox hypos
      0 0 0;... % hypos_lth
      kS_maint 2*kO_tissue -kP_maint;... % hypos_react
      kS_maint 2*kO_tissue kP_maint;... % hypos
      0 0 0;... % hypox_lth
      2*kS_tissue kO_maint -2*kP_tissue;... % hypox_react
      2*kS_tissue kO_maint 2*kP_tissue;... % hypox
      0 0 0;...   % well fed_lth
      kS_tissue kO_tissue -kP_tissue;...   % well fed_react
      kS_tissue kO_tissue kP_tissue];   % well fed

      %les indices des cellules correponsdant à un état ?
      Grid(find(well_fed));

      %les indices des cellules correponsdant à un changement état ?
      Grid(find(state_change!=0));

      % Toutes les cellules dont l'état change ont un timer mis à 120
      Grid(find(state_change!=0))
      if(isempty(find(Grid(find(state_change!=0))==0))==0)
        Grid(find(state_change!=0))
        disp('problem with Grid-zero in Grid')
        save('debug_behav')
        err=1;
        return
      endif
      state(Grid(find(state_change!=0)),3) = reac_time;

      %Pour chaque cellule dont l'état change on calcule le dkS et le dkO
      %ce qui veut dire qu'on  fait état suivant moins état précédent divisé par le temps de réaction
      chg_sites = find(state_change!=0);
      %disp("state_mat:")
      %state_mat(chg_sites)
      if(isempty(find(state_mat(chg_sites)==0))==0)
        disp('chg_sites flagged a zero')
        err=1;
        save('debug')
        return
      endif
      state(Grid(chg_sites),5) = (conso_state(state_mat(chg_sites),1)-state(Grid(chg_sites),4))/reac_time;
      state(Grid(chg_sites),7) = (conso_state(state_mat(chg_sites),2)-state(Grid(chg_sites),6))/reac_time;
      state(Grid(chg_sites),9) = (conso_state(state_mat(chg_sites),3)-state(Grid(chg_sites),8))/reac_time;

      %mise à jour du vecteur d'état
            state(Grid(find(well_fed)),2)=1;
	    state(Grid(find(well_fed_react)),2)=2;
	    state(Grid(find(well_fed_lth)),2)=0;
	    state(Grid(find(hypox)),2)=2;
	    state(Grid(find(hypox_react)),2)=3;
	    state(Grid(find(hypox_lth)),2)=0;
	    state(Grid(find(hypos)),2)=0;
	    state(Grid(find(hypos_react)),2)=1;
	    state(Grid(find(hypos_lth)),2)=0;
	    state(Grid(find(hypox_hypos)),2)=1;
	    state(Grid(find(hypox_hypos_react)),2)=2;
	    state(Grid(find(hypox_hypos_lth)),2)=0;
      state(Grid(find(and(starv,Grid!=0))),2)=0;

      %marqueur vie/mort
      LD(starv) = -1;
      LD(well_fed_lth) = -1;
      LD(hypox_lth) = -1;
      LD(hypos_lth) = -1;
      LD(hypox_hypos_lth) = -1;



endswitch
err =0;
endfunction


