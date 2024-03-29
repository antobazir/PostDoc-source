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
function [LD,state,state_mat,err] = behav(behavior,Grid,LD,S,O,state,state_mat,kO,kS,kO_tissue,kO_maint,kS_tissue,kS_maint,DOm,DSm,DOx_tissue,DS_tissue,S_prol,S_maint,O_norm,reac_time)

  % on garde la carte d'état précédente.
  prev_state_mat  = state_mat;

  % On  calcule la nouvelle carte d'était
  well_fed = and(S>=S_prol,O>=O_norm,Grid!=0,LD==1);
  hypox = and(S>=S_prol,O<O_norm,Grid!=0,LD==1);
  hypos = and(S<S_prol,S>=S_maint,O>=O_norm,Grid!=0,LD==1);
  hypox_hypos = and(S<S_prol,S>=S_maint,O<O_norm,Grid!=0,LD==1);
  %starv = or(and(S<S_maint,Grid!=0),and(Grid!=0,LD==0));
  starv = or(and(S<S_maint,Grid!=0),and(LD==0,Grid!=0));
  LD(kS<=0) = 0;
  state_mat = 5.*well_fed+4.*hypox+3.*hypos+2.*hypox_hypos+starv;
  %kbhit

  %prod_mat
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
  perim = im2double(bwperim(Grid));
  %sheddable_ox = and(perim,hypox);
  %sheddable_prod = and(perim,or(Prod_rct,Prod_lth));

  %matrice indiquant les changements d'état

  state_change = state_mat - prev_state_mat;
  %kbhit

  switch(behavior)
      case 'ref'
      %disp('nada');
	  state_mat = Grid!=0;
	  %prod_mat = Grid!=0;

	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	%Surctrate response only
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
      case 'starv'
      %enough of both
      conso_state = [0 0;... %unoccupied
      0 0;... %starved
      kS_tissue kO_tissue;... % hypox hypos
      kS_tissue kO_tissue;... % hypos
      kS_tissue kO_tissue;... % hypox
      kS_tissue kO_tissue];   % well fed

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
        save('debug')
        return
      endif
      state(Grid(chg_sites),5) = (conso_state(state_mat(chg_sites),1)-state(Grid(chg_sites),4))/reac_time;
      state(Grid(chg_sites),7) = (conso_state(state_mat(chg_sites),2)-state(Grid(chg_sites),6))/reac_time;

      %mise à jour du vecteur d'état
	    %state(Grid(find(well_fed)),2)=1;
	    %state(Grid(find(hypox)),2)=1;
	    %state(Grid(find(hypos)),2)=1;
	    %state(Grid(find(hypox_hypos)),2)=1;
      %state(Grid(find(starv)),2)=-1;

      %Rt_S(state_change!=0)=reac_time;
      %Rt_O(state_change!=0)=reac_time;
##
##      disp('********state change check***********')
##      and(state_change!=0,prev_state_mat==0)
##      kbhit
##      state_mat(and(state_change!=0,prev_state_mat==0))
##      kbhit
##      conso_state(state_mat(and(state_change!=0,prev_state_mat==0)),1)
##      kbhit
##      conso_state(prev_state_mat(state_change!=0),1)
##      kbhit

      % state_mat et prev_stat mat vont me donner les codess conso de chaque case
##      dkS(and(state_change!=0,prev_state_mat!=0))
##      kbhit
##      (conso_state(state_mat(and(state_change!=0,prev_state_mat!=0)),1)-conso_state(prev_state_mat(and(state_change!=0,prev_state_mat!=0)),1))/reac_time ;
##      kbhit
##
##        state_mat(and(state_change!=0,prev_state_mat!=0))
##        kbhit
##        state_mat(and(state_change!=0,prev_state_mat!=0))!=0
##        kbhit

        %disp('******condition problem*******')
        %state_change
        %kbhit
##        prev_state_mat
##        kbhit
##        state_mat
##        kbhit
##        Grid
##        kbhit
##        S
##        kbhit
##        O
##        kbhit
##        LD
##        kbhit
%      endif
     %kS_future(find(well_fed))=kS_tissue;
      %kO_future(find(well_fed))=kO_tissue;
      %kP(find(well_fed))=kP_tissue;
      %dkS(state_change!=0) =  (conso_state(state_mat(state_change!=0),1))/reac_time ;
      %dkS
      %kbhit;
      %Rt_S
      %kbhit;


##      %starvation (onlly possible w/surctrate)
##      kS_future(find(starv))=0;
##      kO_future(find(starv))=0;
##      %kP(find(starv))=0;
##	  K(find(starv)) = K(find(starv)) + rel_K;




      %prod_mat = 9.*No_eff +8.*Prod_rct+7.*Kine_rct+6.*ProdKine_rct+5.*Prod_lth+4.*Kine_lth+3.*P_rct_K_lth+2.*P_lth_K_rct+1.*ProdKine_lth;

##	  case 'savy'

##	  %enough of both
##      kS(find(well_fed))=kS_tissue;
##      kO(find(well_fed))=kO_tissue;
##      kP(find(well_fed))=kP_tissue;
##
##	  %not enough surctrate
##	  kS(find(hypos))=kS_maint;
##      kO(find(hypos))=kO_maint;
##      kP(find(hypos))=kP_maint;
##
##
##      %starvation (onlly possible w/surctrate)
##      kS(find(starv))=0;
##      kO(find(starv))=0;
##      kP(find(starv))=0;
##	  K(find(starv)) = K(find(starv)) + rel_K;
##
##	  %mise à jour du vecteur d'état
##	  state(Grid(find(well_fed)),2)=1;
##	  state(Grid(find(hypox)),2)=1;
##	  state(Grid(find(hypos)),2)=0; %no proliferation when surctrate is missing
##	  state(Grid(find(hypox_hypos)),2)=0; %no proliferation when surctrate is missing
##      state(Grid(find(starv)),2)=-1;
##
##      state_mat = 5.*well_fed+4.*hypox+3.*hypos+2.*hypox_hypos+starv;
##	  prod_mat = 9.*No_eff +8.*Prod_rct+7.*Kine_rct+6.*ProdKine_rct+5.*Prod_lth+4.*Kine_lth+3.*P_rct_K_lth+2.*P_lth_K_rct+1.*ProdKine_lth;

	case 'compens'
	% oxygen can provide boost in energy if substrate is in lower amounts but does not maintain prolifs
	  %enough of both
      kS(find(well_fed))=kS_tissue;
      kO(find(well_fed))=kO_tissue;
      kP(find(well_fed))=kP_tissue;

	  %not enough surctrate
	  kS(find(hypos))=kS_maint;
      kO(find(hypos))=2*kO_tissue;
      kP(find(hypos))=kP_tissue;

	  %hypoxia
	  kS(find(hypox))=kS_tissue;
      kO(find(hypox))=kO_tissue;
      kP(find(hypox))=kP_tissue;

	  %hypoxia+hyposubia
	  kS(find(hypox_hypos))=kS_maint;
      kO(find(hypox_hypos))=2*kO_tissue;
      kP(find(hypox_hypos))=kP_maint;

	  %starvation
      kS(find(starv))=0;
      kO(find(starv))=0;
      kP(find(starv))=0;
	  K(find(starv)) = K(find(starv)) + rel_K;

	  %state vector update
	  state(Grid(find(well_fed)),2)=1;
	  state(Grid(find(hypox)),2)=1;
	  state(Grid(find(hypos)),2)=0; %no proliferation when surctrate is missing
	  state(Grid(find(hypox_hypos)),2)=0; %no proliferation when surctrate is missing
      state(Grid(find(starv)),2)=-1;

	  state_mat = 5.*well_fed+4.*hypox+3.*hypos+2.*hypox_hypos+starv;
	 prod_mat = 9.*No_eff +8.*Prod_rct+7.*Kine_rct+6.*ProdKine_rct+5.*Prod_lth+4.*Kine_lth+3.*P_rct_K_lth+2.*P_lth_K_rct+1.*ProdKine_lth;

	case 'compens_prol'

	  %enough of both
      kS(find(well_fed))=kS_tissue;
      kO(find(well_fed))=kO_tissue;
      kP(find(well_fed))=kP_tissue;

	  %not enough surctrate
	  kS(find(hypos))=kS_maint;
      kO(find(hypos))=2*kO_tissue;
      kP(find(hypos))=kP_tissue;

	  %hypoxia
	  kS(find(hypox))=kS_tissue;
      kO(find(hypox))=kO_tissue;
      kP(find(hypox))=kP_tissue;

	  %hypoxia+hyposubia
	  kS(find(hypox_hypos))=kS_maint;
      kO(find(hypox_hypos))=2*kO_tissue;
      kP(find(hypox_hypos))=kP_maint;

      %starvation (onlly possible w/surctrate)
      kS(find(starv))=0;
      kO(find(starv))=0;
      kP(find(starv))=0;
	  K(find(starv)) = K(find(starv)) + rel_K;

	  %state vector update
	  state(Grid(find(well_fed)),2)=1;
	  state(Grid(find(hypox)),2)=1;
	  state(Grid(find(hypos)),2)=1; %
	  state(Grid(find(hypox_hypos)),2)=0; %no proliferation when surctrate is missing
      state(Grid(find(starv)),2)=-1;

      state_mat = 5.*well_fed+4.*hypox+3.*hypos+2.*hypox_hypos+starv;
      prod_mat = 9.*No_eff +8.*Prod_rct+7.*Kine_rct+6.*ProdKine_rct+5.*Prod_lth+4.*Kine_lth+3.*P_rct_K_lth+2.*P_lth_K_rct+1.*ProdKine_lth;

	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	%Oxygen response only
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

	case 'loc_hypox_base'
	% we tested no reaction to oxygen w/ surctrate now the opposite
		  %enough of both
      kS(find(well_fed))=kS_tissue;
      kO(find(well_fed))=kO_tissue;
      kP(find(well_fed))=kP_tissue;

	  %not enough surctrate -> no change
	  kS(find(hypos))=kS_tissue;
      kO(find(hypos))=kO_tissue;
      kP(find(hypos))=kP_tissue;

	  %hypoxia -> just reduces consmption
	  kS(find(hypox))=kS_tissue;
      kO(find(hypox))=kO_maint;
      kP(find(hypox))=kP_tissue;

	  %hypoxia+hyposubia
	  kS(find(hypox_hypos))=kS_tissue;
      kO(find(hypox_hypos))=kO_maint;
      kP(find(hypox_hypos))=kP_tissue;


      %starvation (onlly possible w/surctrate)
      kS(find(starv))=0;
      kO(find(starv))=0;
      kP(find(starv))=0;
	  K(find(starv)) = K(find(starv)) + rel_K;


	  %state vector update
	  state(Grid(find(well_fed)),2)=1;
	  state(Grid(find(hypox)),2)=1;
	  state(Grid(find(hypos)),2)=1; %no proliferation when surctrate is missing
	  state(Grid(find(hypox_hypos)),2)=1; %no proliferation when surctrate is missing
      state(Grid(find(starv)),2)=-1;

      state_mat = 5.*well_fed+4.*hypox+3.*hypos+2.*hypox_hypos+starv;
      prod_mat = 9.*No_eff +8.*Prod_rct+7.*Kine_rct+6.*ProdKine_rct+5.*Prod_lth+4.*Kine_lth+3.*P_rct_K_lth+2.*P_lth_K_rct+1.*ProdKine_lth;

	case 'loc_hypox_comp'
	%hypoxia reduces consumption AND provokes compensation
	%enough of both
      kS(find(well_fed))=kS_tissue;
      kO(find(well_fed))=kO_tissue;
      kP(find(well_fed))=kP_tissue;

	  %not enough substrate -> no change
	  kS(find(hypos))=kS_tissue;
      kO(find(hypos))=kO_tissue;
      kP(find(hypos))=kP_tissue;

	  %hypoxia
	  kS(find(hypox))=2*kS_tissue;
      kO(find(hypox))=kO_maint;
      kP(find(hypox))=2*kP_tissue;

	  %hypoxia+hyposubia
	  kS(find(hypox_hypos))=2*kS_tissue;
      kO(find(hypox_hypos))=kO_maint;
      kP(find(hypox_hypos))=2*kP_tissue;


      %starvation (onlly possible w/surctrate)
      kS(find(starv))=0;
      kO(find(starv))=0;
      kP(find(starv))=0;
	  K(find(starv)) = K(find(starv)) + rel_K;


	  %state vector update
	  state(Grid(find(well_fed)),2)=1;
	  state(Grid(find(hypox)),2)=1;
	  state(Grid(find(hypos)),2)=1; %no proliferation when surctrate is missing
	  state(Grid(find(hypox_hypos)),2)=1; %no proliferation when surctrate is missing
      state(Grid(find(starv)),2)=-1;

      state_mat = 5.*well_fed+4.*hypox+3.*hypos+2.*hypox_hypos+starv;
      prod_mat = 9.*No_eff +8.*Prod_rct+7.*Kine_rct+6.*ProdKine_rct+5.*Prod_lth+4.*Kine_lth+3.*P_rct_K_lth+2.*P_lth_K_rct+1.*ProdKine_lth;

	case 'loc_hypox_comp_prol'
	%hypoxia reduces consumption AND provokes compensation AND boost prolif
	%enough of both
      kS(find(well_fed))=kS_tissue;
      kO(find(well_fed))=kO_tissue;
      kP(find(well_fed))=kP_tissue;

	  %not enough surctrate
	  kS(find(hypos))=kS_tissue;
      kO(find(hypos))=kO_tissue;
      kP(find(hypos))=kP_tissue;

	  %hypoxia
	  kS(find(hypox))=2*kS_tissue;
      kO(find(hypox))=kO_maint;
      kP(find(hypox))=2*kP_tissue;

	  %hypoxia+hyposubia
	  kS(find(hypox_hypos))=2*kS_tissue;
      kO(find(hypox_hypos))=kO_maint;
      kP(find(hypox_hypos))=2*kP_tissue;


      %starvation (onlly possible w/surctrate)
      kS(find(starv))=0;
      kO(find(starv))=0;
      kP(find(starv))=0;
	  K(find(starv)) = K(find(starv)) + rel_K;


	  %state vector update
	  state(Grid(find(well_fed)),2)=1;
	  state(Grid(find(hypox)),2)=2;
	  state(Grid(find(hypos)),2)=1; %no proliferation when substrate is missing
	  state(Grid(find(hypox_hypos)),2)=1; %no proliferation when surctrate is missing
      state(Grid(find(starv)),2)=-1;

      state_mat = 5.*well_fed+4.*hypox+3.*hypos+2.*hypox_hypos+starv;
      prod_mat = 9.*No_eff +8.*Prod_rct+7.*Kine_rct+6.*ProdKine_rct+5.*Prod_lth+4.*Kine_lth+3.*P_rct_K_lth+2.*P_lth_K_rct+1.*ProdKine_lth;

	case 'loc_hypox_comp_arr'
	%hypoxia reduces consumption AND provokes compensation AND stops prolif
	%enough of both
      kS(find(well_fed))=kS_tissue;
      kO(find(well_fed))=kO_tissue;
      kP(find(well_fed))=kP_tissue;

	  %not enough surctrate
	  kS(find(hypos))=kS_tissue;
      kO(find(hypos))=kO_tissue;
      kP(find(hypos))=kP_tissue;

	  %hypoxia
	  kS(find(hypox))=2*kS_tissue;
      kO(find(hypox))=kO_maint;
      kP(find(hypox))=2*kP_tissue;

	  %hypoxia+hyposubia
	  kS(find(hypox_hypos))=2*kS_tissue;
      kO(find(hypox_hypos))=kO_maint;
      kP(find(hypox_hypos))=2*kP_tissue;


      %starvation (onlly possible w/surctrate)
      kS(find(starv))=0;
      kO(find(starv))=0;
      kP(find(starv))=0;
	  K(find(starv)) = K(find(starv)) + rel_K;


	  %state vector update
	  state(Grid(find(well_fed)),2)=1;
	  state(Grid(find(hypox)),2)=0;
	  state(Grid(find(hypos)),2)=1; %no proliferation when surctrate is missing
	  state(Grid(find(hypox_hypos)),2)=0; %no proliferation when surctrate is missing
      state(Grid(find(starv)),2)=-1;

      state_mat = 5.*well_fed+4.*hypox+3.*hypos+2.*hypox_hypos+starv;
      prod_mat = 9.*No_eff +8.*Prod_rct+7.*Kine_rct+6.*ProdKine_rct+5.*Prod_lth+4.*Kine_lth+3.*P_rct_K_lth+2.*P_lth_K_rct+1.*ProdKine_lth;

	case 'loc_hypox_comp_prol_mig'
	%hypoxia reduces consumption AND provokes compensation AND boost prolif AND triggers shedding
	%enough of both
      kS(find(well_fed))=kS_tissue;
      kO(find(well_fed))=kO_tissue;
      kP(find(well_fed))=kP_tissue;

	  %not enough surctrate
	  kS(find(hypos))=kS_tissue;
      kO(find(hypos))=kO_tissue;
      kP(find(hypos))=kP_tissue;

	  %hypoxia
	  kS(find(hypox))=2*kS_tissue;
      kO(find(hypox))=kO_maint;
      kP(find(hypox))=2*kP_tissue;

	  %hypoxia+hyposubia
	  kS(find(hypox_hypos))=2*kS_tissue;
      kO(find(hypox_hypos))=kO_maint;
      kP(find(hypox_hypos))=2*kP_tissue;


      %starvation (onlly possible w/surctrate)
      kS(find(starv))=0;
      kO(find(starv))=0;
      kP(find(starv))=0;
	  K(find(starv)) = K(find(starv)) + rel_K;


	  %state vector update
	  state(Grid(find(well_fed)),2)=1;
	  state(Grid(find(hypox)),2)=2;
	  state(Grid(find(hypos)),2)=1; %no proliferation when substrate is missing
	  state(Grid(find(hypox_hypos)),2)=1; %no proliferation when surctrate is missing
      state(Grid(find(starv)),2)=-1;
	  state(Grid(find(sheddable_ox)),2)=0;

      state_mat = 5.*well_fed+4.*hypox+3.*hypos+2.*hypox_hypos+starv;
      prod_mat = 9.*No_eff +8.*Prod_rct+7.*Kine_rct+6.*ProdKine_rct+5.*Prod_lth+4.*Kine_lth+3.*P_rct_K_lth+2.*P_lth_K_rct+1.*ProdKine_lth;

	  case 'loc_hypox_comp_arr_mig'
	%hypoxia reduces consumption AND provokes compensation AND stops prolif
	%enough of both
      kS(find(well_fed))=kS_tissue;
      kO(find(well_fed))=kO_tissue;
      kP(find(well_fed))=kP_tissue;

	  %not enough surctrate
	  kS(find(hypos))=kS_tissue;
      kO(find(hypos))=kO_tissue;
      kP(find(hypos))=kP_tissue;

	  %hypoxia
	  kS(find(hypox))=2*kS_tissue;
      kO(find(hypox))=kO_maint;
      kP(find(hypox))=2*kP_tissue;

	  %hypoxia+hyposubia
	  kS(find(hypox_hypos))=2*kS_tissue;
      kO(find(hypox_hypos))=kO_maint;
      kP(find(hypox_hypos))=2*kP_tissue;


      %starvation (onlly possible w/surctrate)
      kS(find(starv))=0;
      kO(find(starv))=0;
      kP(find(starv))=0;
	  K(find(starv)) = K(find(starv)) + rel_K;


	  %state vector update
	  state(Grid(find(well_fed)),2)=1;
	  state(Grid(find(hypox)),2)=0;
	  state(Grid(find(hypos)),2)=1; %no proliferation when surctrate is missing
	  state(Grid(find(hypox_hypos)),2)=0; %no proliferation when surctrate is missing
      state(Grid(find(starv)),2)=-1;
      state(Grid(find(sheddable_ox)),2)=0;

      state_mat = 5.*well_fed+4.*hypox+3.*hypos+2.*hypox_hypos+starv;
      prod_mat = 9.*No_eff +8.*Prod_rct+7.*Kine_rct+6.*ProdKine_rct+5.*Prod_lth+4.*Kine_lth+3.*P_rct_K_lth+2.*P_lth_K_rct+1.*ProdKine_lth;


    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	%Oxygen & Substrate response
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

	case 'OS_fragile'
	%anything but  well fed stop proliferation & shortage of both kills

	%enough of both
      kS(find(well_fed))=kS_tissue;
      kO(find(well_fed))=kO_tissue;
      kP(find(well_fed))=kP_tissue;

	  %not enough surctrate -> stops proliferation
	  kS(find(hypos))=kS_maint;
      kO(find(hypos))=kO_maint;
      kP(find(hypos))=kP_maint;

	  %hypoxia -> compensates but does not compensate enough to proliferate
	  kS(find(hypox))=2*kS_tissue;
      kO(find(hypox))=kO_maint;
      kP(find(hypox))=2*kP_tissue;

	  %hypoxia+hyposubia  -> the conjunction of two energy reductions kills the cell
	  kS(find(hypox_hypos))=0;
      kO(find(hypox_hypos))=0;
      kP(find(hypox_hypos))=0;


      %starvation (onlly possible w/surctrate)
      kS(find(starv))=0;
      kO(find(starv))=0;
      kP(find(starv))=0;
	  K(find(starv)) = K(find(starv)) + rel_K;


	  %state vector update
	  state(Grid(find(well_fed)),2)=1;
	  state(Grid(find(hypox)),2)=0;
	  state(Grid(find(hypos)),2)=0; %no proliferation when surctrate is missing
	  state(Grid(find(hypox_hypos)),2)=-1; %no proliferation when surctrate is missing
      state(Grid(find(starv)),2)=-1;

      state_mat = 5.*well_fed+4.*hypox+3.*hypos+2.*hypox_hypos+starv;
      prod_mat = 9.*No_eff +8.*Prod_rct+7.*Kine_rct+6.*ProdKine_rct+5.*Prod_lth+4.*Kine_lth+3.*P_rct_K_lth+2.*P_lth_K_rct+1.*ProdKine_lth;

	  	case 'OS_fragile_mig'
	%anything but  well fed stop proliferation & shortage of both kills

	%enough of both
      kS(find(well_fed))=kS_tissue;
      kO(find(well_fed))=kO_tissue;
      kP(find(well_fed))=kP_tissue;

	  %not enough surctrate -> stops proliferation
	  kS(find(hypos))=kS_maint;
      kO(find(hypos))=kO_maint;
      kP(find(hypos))=kP_maint;

	  %hypoxia -> compensates but does not compensate enough to proliferate
	  kS(find(hypox))=2*kS_tissue;
      kO(find(hypox))=kO_maint;
      kP(find(hypox))=2*kP_tissue;

	  %hypoxia+hyposubia  -> the conjunction of two energy reductions kills the cell
	  kS(find(hypox_hypos))=0;
      kO(find(hypox_hypos))=0;
      kP(find(hypox_hypos))=0;


      %starvation (onlly possible w/surctrate)
      kS(find(starv))=0;
      kO(find(starv))=0;
      kP(find(starv))=0;
	  K(find(starv)) = K(find(starv)) + rel_K;


	  %state vector update
	  state(Grid(find(well_fed)),2)=1;
	  state(Grid(find(hypox)),2)=0;
	  state(Grid(find(hypos)),2)=0; %no proliferation when surctrate is missing
	  state(Grid(find(hypox_hypos)),2)=-1; %no proliferation when surctrate is missing
      state(Grid(find(starv)),2)=-1;
	  state(Grid(find(sheddable_ox)),2)=0;

      state_mat = 5.*well_fed+4.*hypox+3.*hypos+2.*hypox_hypos+starv;
      prod_mat = 9.*No_eff +8.*Prod_rct+7.*Kine_rct+6.*ProdKine_rct+5.*Prod_lth+4.*Kine_lth+3.*P_rct_K_lth+2.*P_lth_K_rct+1.*ProdKine_lth;


	case 'OS_hypos_tol'
	%the cell tolerates hyposubemia

	%enough of both
      kS(find(well_fed))=kS_tissue;
      kO(find(well_fed))=kO_tissue;
      kP(find(well_fed))=kP_tissue;

	  %not enough surctrate -> compensate with oxy and keeps proli
	  kS(find(hypos))=kS_maint;
      kO(find(hypos))=2*kO_tissue;
      kP(find(hypos))=kP_maint;

	  %hypoxia -> compensates but does not compensate enough to proliferate
	  kS(find(hypox))=2*kS_tissue;
      kO(find(hypox))=kO_maint;
      kP(find(hypox))=2*kP_tissue;

	  %hypoxia+hyposubia  -> the conjunction of two energy reductions kills the cell
	  kS(find(hypox_hypos))=0;
      kO(find(hypox_hypos))=0;
      kP(find(hypox_hypos))=0;


      %starvation (onlly possible w/surctrate)
      kS(find(starv))=0;
      kO(find(starv))=0;
      kP(find(starv))=0;
	  K(find(starv)) = K(find(starv)) + rel_K;


	  %state vector update
	  state(Grid(find(well_fed)),2)=1;
	  state(Grid(find(hypox)),2)=0;
	  state(Grid(find(hypos)),2)=1; %no proliferation when surctrate is missing
	  state(Grid(find(hypox_hypos)),2)=-1; %no proliferation when surctrate is missing
      state(Grid(find(starv)),2)=-1;

      state_mat = 5.*well_fed+4.*hypox+3.*hypos+2.*hypox_hypos+starv;
      prod_mat = 9.*No_eff +8.*Prod_rct+7.*Kine_rct+6.*ProdKine_rct+5.*Prod_lth+4.*Kine_lth+3.*P_rct_K_lth+2.*P_lth_K_rct+1.*ProdKine_lth;


	case 'OS_hypox_tol'
	%anything but  well fed stop proliferation & shortage of both kills

	%enough of both
      kS(find(well_fed))=kS_tissue;
      kO(find(well_fed))=kO_tissue;
      kP(find(well_fed))=kP_tissue;

	  %not enough surctrate -> stops proliferation
	  kS(find(hypos))=kS_maint;
      kO(find(hypos))=kO_maint;
      kP(find(hypos))=kP_maint;

	  %hypoxia -> compensates enough to proliferate
	  kS(find(hypox))=2*kS_tissue;
      kO(find(hypox))=kO_maint;
      kP(find(hypox))=2*kP_tissue;

	  %hypoxia+hyposubia  -> if enough energy to proliferate in hypoxia, logically enough to maintain here
	  kS(find(hypox_hypos))=2*kS_tissue;
      kO(find(hypox_hypos))=kO_maint;
      kP(find(hypox_hypos))=2*kP_tissue;


      %starvation (onlly possible w/surctrate)
      kS(find(starv))=0;
      kO(find(starv))=0;
      kP(find(starv))=0;
	  K(find(starv)) = K(find(starv)) + rel_K;


	  %state vector update
	  state(Grid(find(well_fed)),2)=1;
	  state(Grid(find(hypox)),2)=1;
	  state(Grid(find(hypos)),2)=0; %no proliferation when surctrate is missing
	  state(Grid(find(hypox_hypos)),2)=0; %no proliferation when surctrate is missing
      state(Grid(find(starv)),2)=-1;

      state_mat = 5.*well_fed+4.*hypox+3.*hypos+2.*hypox_hypos+starv;
      prod_mat = 9.*No_eff +8.*Prod_rct+7.*Kine_rct+6.*ProdKine_rct+5.*Prod_lth+4.*Kine_lth+3.*P_rct_K_lth+2.*P_lth_K_rct+1.*ProdKine_lth;

	case 'OS_hypox_boost'
	%hypoxia boost prolif

	%enough of both
      kS(find(well_fed))=kS_tissue;
      kO(find(well_fed))=kO_tissue;
      kP(find(well_fed))=kP_tissue;

	  %not enough surctrate -> stops proliferation
	  kS(find(hypos))=kS_maint;
      kO(find(hypos))=kO_maint;
      kP(find(hypos))=kP_maint;

	  %hypoxia -> compensates enough to proliferate AND proliferate faster
	  kS(find(hypox))=2*kS_tissue;
      kO(find(hypox))=kO_maint;
      kP(find(hypox))=2*kP_tissue;

	  %hypoxia+hyposubia  -> if enough energy to proliferate faster in hypoxia, logically enough to maintain prolif here
	  kS(find(hypox_hypos))=2*kS_tissue;
      kO(find(hypox_hypos))=kO_maint;
      kP(find(hypox_hypos))=2*kP_tissue;


      %starvation (onlly possible w/surctrate)
      kS(find(starv))=0;
      kO(find(starv))=0;
      kP(find(starv))=0;
	  K(find(starv)) = K(find(starv)) + rel_K;


	  %state vector update
	  state(Grid(find(well_fed)),2)=1;
	  state(Grid(find(hypox)),2)=2;
	  state(Grid(find(hypos)),2)=0; %no proliferation when surctrate is missing
	  state(Grid(find(hypox_hypos)),2)=1; %no proliferation when surctrate is missing
      state(Grid(find(starv)),2)=-1;

      state_mat = 5.*well_fed+4.*hypox+3.*hypos+2.*hypox_hypos+starv;
      prod_mat = 9.*No_eff +8.*Prod_rct+7.*Kine_rct+6.*ProdKine_rct+5.*Prod_lth+4.*Kine_lth+3.*P_rct_K_lth+2.*P_lth_K_rct+1.*ProdKine_lth;

	case 'OS_hypox_boost_mig'
	%anything but  well fed stop proliferation & shortage of both kills

	%enough of both
      kS(find(well_fed))=kS_tissue;
      kO(find(well_fed))=kO_tissue;
      kP(find(well_fed))=kP_tissue;

	  %not enough surctrate -> stops proliferation
	  kS(find(hypos))=kS_maint;
      kO(find(hypos))=kO_maint;
      kP(find(hypos))=kP_maint;

	  %hypoxia -> compensates enough to proliferate AND proliferate faster
	  kS(find(hypox))=2*kS_tissue;
      kO(find(hypox))=kO_maint;
      kP(find(hypox))=2*kP_tissue;

	  %hypoxia+hyposubia  -> if enough energy to proliferate faster in hypoxia, logically enough to maintain prolif here
	  kS(find(hypox_hypos))=2*kS_tissue;
      kO(find(hypox_hypos))=kO_maint;
      kP(find(hypox_hypos))=2*kP_tissue;


      %starvation (onlly possible w/surctrate)
      kS(find(starv))=0;
      kO(find(starv))=0;
      kP(find(starv))=0;
	  K(find(starv)) = K(find(starv)) + rel_K;


	  %state vector update
	  state(Grid(find(well_fed)),2)=1;
	  state(Grid(find(hypox)),2)=2;
	  state(Grid(find(hypos)),2)=0; %no proliferation when surctrate is missing
	  state(Grid(find(hypox_hypos)),2)=1; %no proliferation when surctrate is missing
      state(Grid(find(starv)),2)=-1;
      state(Grid(find(sheddable_ox)),2)=0;

      state_mat = 5.*well_fed+4.*hypox+3.*hypos+2.*hypox_hypos+starv;
	  prod_mat = 9.*No_eff +8.*Prod_rct+7.*Kine_rct+6.*ProdKine_rct+5.*Prod_lth+4.*Kine_lth+3.*P_rct_K_lth+2.*P_lth_K_rct+1.*ProdKine_lth;
	  length(find(sheddable_ox))

	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	%Oxygen, Substrate & Product response
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	case 'OS_fragile_P_detr'
	%Now reaction to P is added and is simply detrimental

	%enough of both
      kS(find(and(well_fed,No_eff)))=kS_tissue;
      kO(find(and(well_fed,No_eff)))=kO_tissue;
      kP(find(and(well_fed,No_eff)))=kP_tissue;

	  %product stops prolif
	  kS(find(and(well_fed,Prod_rct)))=kS_maint;
      kO(find(and(well_fed,Prod_rct)))=kO_maint;
      kP(find(and(well_fed,Prod_rct)))=kP_maint;

	  % too much product kills the cell
	  kS(find(and(well_fed,Prod_lth)))=0;
      kO(find(and(well_fed,Prod_lth)))=0;
      kP(find(and(well_fed,Prod_lth)))=0;

	  %not enough substrate -> stops proliferation
	  kS(find(and(hypos,No_eff)))=kS_maint;
      kO(find(and(hypos,No_eff)))=kO_maint;
      kP(find(and(hypos,No_eff)))=kP_maint;

	  % cell does not tolerate medium product amounts with low energy
	  kS(find(and(hypos,Prod_rct)))=0;
      kO(find(and(hypos,Prod_rct)))=0;
      kP(find(and(hypos,Prod_rct)))=0;

	 % cell does not tolerate high product amounts with low energy
	  kS(find(and(hypos,Prod_lth)))=0;
      kO(find(and(hypos,Prod_lth)))=0;
      kP(find(and(hypos,Prod_lth)))=0;

	  %hypoxia -> compensates but does not compensate enough to proliferate
	  kS(find(and(hypox,No_eff)))=2*kS_tissue;
      kO(find(and(hypox,No_eff)))=kO_maint;
      kP(find(and(hypox,No_eff)))=2*kP_tissue;

	  kS(find(and(hypox,Prod_rct)))=2*kS_tissue;
      kO(find(and(hypox,Prod_rct)))=kO_maint;
      kP(find(and(hypox,Prod_rct)))=2*kP_tissue;

	  kS(find(and(hypox,Prod_lth)))=0;
      kO(find(and(hypox,Prod_lth)))=0;
      kP(find(and(hypox,Prod_lth)))=0;


	  %hypoxia+hyposubia  -> the conjunction of two energy reductions kills the cell
	  kS(find(and(hypox_hypos,No_eff)))=0;
      kO(find(and(hypox_hypos,No_eff)))=0;
      kP(find(and(hypox_hypos,No_eff)))=0;

	  kS(find(and(hypox_hypos,Prod_rct)))=0;
      kO(find(and(hypox_hypos,Prod_rct)))=0;
      kP(find(and(hypox_hypos,Prod_rct)))=0;

	  kS(find(and(hypox_hypos,Prod_lth)))=0;
      kO(find(and(hypox_hypos,Prod_lth)))=0;
      kP(find(and(hypox_hypos,Prod_lth)))=0;

      %starvation (onlly possible w/surctrate)
      kS(find(starv))=0;
      kO(find(starv))=0;
      kP(find(starv))=0;
	  K(find(starv)) = K(find(starv)) + rel_K;


	  %state vector update
	  state(Grid(find(and(well_fed,No_eff))),2)=1;
	  state(Grid(find(and(well_fed,Prod_rct))),2)=0;
	  state(Grid(find(and(well_fed,Prod_lth))),2)=-1;
	  state(Grid(find(and(hypox,No_eff))),2)=0;
	  state(Grid(find(and(hypox,Prod_rct))),2)=0;
	  state(Grid(find(and(hypox,Prod_lth))),2)=-1;
	  state(Grid(find(and(hypos,No_eff))),2)=0; %no proliferation when surctrate is missing
	  state(Grid(find(and(hypos,Prod_rct))),2)=-1; %no proliferation when surctrate is missing
	  state(Grid(find(and(hypos,Prod_lth))),2)=-1; %no proliferation when surctrate is missing
	  state(Grid(find(and(hypox_hypos,No_eff))),2)=-1; %no proliferation when surctrate is missing
	  state(Grid(find(and(hypox_hypos,Prod_rct))),2)=-1; %no proliferation when surctrate is missing
	  state(Grid(find(and(hypox_hypos,Prod_lth))),2)=-1; %no proliferation when surctrate is missing
      state(Grid(find(starv)),2)=-1;

      state_mat = 5.*well_fed+4.*hypox+3.*hypos+2.*hypox_hypos+starv;
      prod_mat = 9.*No_eff +8.*Prod_rct+7.*Kine_rct+6.*ProdKine_rct+5.*Prod_lth+4.*Kine_lth+3.*P_rct_K_lth+2.*P_lth_K_rct+1.*ProdKine_lth;

		case 'OS_fragile_P_detr_mig'
	%Now reaction to P is added and is simply detrimental

	%enough of both
      kS(find(and(well_fed,No_eff)))=kS_tissue;
      kO(find(and(well_fed,No_eff)))=kO_tissue;
      kP(find(and(well_fed,No_eff)))=kP_tissue;

	  %product stops prolif
	  kS(find(and(well_fed,Prod_rct)))=kS_maint;
      kO(find(and(well_fed,Prod_rct)))=kO_maint;
      kP(find(and(well_fed,Prod_rct)))=kP_maint;

	  % too much product kills the cell
	  kS(find(and(well_fed,Prod_lth)))=0;
      kO(find(and(well_fed,Prod_lth)))=0;
      kP(find(and(well_fed,Prod_lth)))=0;

	  %not enough substrate -> stops proliferation
	  kS(find(and(hypos,No_eff)))=kS_maint;
      kO(find(and(hypos,No_eff)))=kO_maint;
      kP(find(and(hypos,No_eff)))=kP_maint;

	  % cell does not tolerate medium product amounts with low energy
	  kS(find(and(hypos,Prod_rct)))=0;
      kO(find(and(hypos,Prod_rct)))=0;
      kP(find(and(hypos,Prod_rct)))=0;

	 % cell does not tolerate high product amounts with low energy
	  kS(find(and(hypos,Prod_lth)))=0;
      kO(find(and(hypos,Prod_lth)))=0;
      kP(find(and(hypos,Prod_lth)))=0;

	  %hypoxia -> compensates but does not compensate enough to proliferate
	  kS(find(and(hypox,No_eff)))=2*kS_tissue;
      kO(find(and(hypox,No_eff)))=kO_maint;
      kP(find(and(hypox,No_eff)))=2*kP_tissue;

	  kS(find(and(hypox,Prod_rct)))=2*kS_tissue;
      kO(find(and(hypox,Prod_rct)))=kO_maint;
      kP(find(and(hypox,Prod_rct)))=2*kP_tissue;

	  kS(find(and(hypox,Prod_lth)))=0;
      kO(find(and(hypox,Prod_lth)))=0;
      kP(find(and(hypox,Prod_lth)))=0;


	  %hypoxia+hyposubia  -> the conjunction of two energy reductions kills the cell
	  kS(find(and(hypox_hypos,No_eff)))=0;
      kO(find(and(hypox_hypos,No_eff)))=0;
      kP(find(and(hypox_hypos,No_eff)))=0;

	  kS(find(and(hypox_hypos,Prod_rct)))=0;
      kO(find(and(hypox_hypos,Prod_rct)))=0;
      kP(find(and(hypox_hypos,Prod_rct)))=0;

	  kS(find(and(hypox_hypos,Prod_lth)))=0;
      kO(find(and(hypox_hypos,Prod_lth)))=0;
      kP(find(and(hypox_hypos,Prod_lth)))=0;

      %starvation (onlly possible w/surctrate)
      kS(find(starv))=0;
      kO(find(starv))=0;
      kP(find(starv))=0;
	  K(find(starv)) = K(find(starv)) + rel_K;


	  %state vector update
	  state(Grid(find(and(well_fed,No_eff))),2)=1;
	  state(Grid(find(and(well_fed,Prod_rct))),2)=0;
	  state(Grid(find(and(well_fed,Prod_lth))),2)=-1;
	  state(Grid(find(and(hypox,No_eff))),2)=0;
	  state(Grid(find(and(hypox,Prod_rct))),2)=0;
	  state(Grid(find(and(hypox,Prod_lth))),2)=-1;
	  state(Grid(find(and(hypos,No_eff))),2)=0; %no proliferation when surctrate is missing
	  state(Grid(find(and(hypos,Prod_rct))),2)=-1; %no proliferation when surctrate is missing
	  state(Grid(find(and(hypos,Prod_lth))),2)=-1; %no proliferation when surctrate is missing
	  state(Grid(find(and(hypox_hypos,No_eff))),2)=-1; %no proliferation when surctrate is missing
	  state(Grid(find(and(hypox_hypos,Prod_rct))),2)=-1; %no proliferation when surctrate is missing
	  state(Grid(find(and(hypox_hypos,Prod_lth))),2)=-1; %no proliferation when surctrate is missing
      state(Grid(find(starv)),2)=-1;
	  state(Grid(find(sheddable_prod)),2)=0; %product can trigger shedding

      state_mat = 5.*well_fed+4.*hypox+3.*hypos+2.*hypox_hypos+starv;
      prod_mat = 9.*No_eff +8.*Prod_rct+7.*Kine_rct+6.*ProdKine_rct+5.*Prod_lth+4.*Kine_lth+3.*P_rct_K_lth+2.*P_lth_K_rct+1.*ProdKine_lth;


	case 'OS_hypox_boost_P_detr'
	%Now reaction to P is added and is simply detrimental

	%enough of both
      kS(find(and(well_fed,No_eff)))=kS_tissue;
      kO(find(and(well_fed,No_eff)))=kO_tissue;
      kP(find(and(well_fed,No_eff)))=kP_tissue;

	  %product stops prolif
	  kS(find(and(well_fed,Prod_rct)))=kS_maint;
      kO(find(and(well_fed,Prod_rct)))=kO_maint;
      kP(find(and(well_fed,Prod_rct)))=kP_maint;

	  % too much product kills the cell
	  kS(find(and(well_fed,Prod_lth)))=0;
      kO(find(and(well_fed,Prod_lth)))=0;
      kP(find(and(well_fed,Prod_lth)))=0;

	  %not enough substrate -> stops proliferation
	  kS(find(and(hypos,No_eff)))=kS_maint;
      kO(find(and(hypos,No_eff)))=kO_maint;
      kP(find(and(hypos,No_eff)))=kP_maint;

	  % cell does not tolerate medium product amounts with low energy
	  kS(find(and(hypos,Prod_rct)))=0;
      kO(find(and(hypos,Prod_rct)))=0;
      kP(find(and(hypos,Prod_rct)))=0;

	 % cell does not tolerate high product amounts with low energy
	  kS(find(and(hypos,Prod_lth)))=0;
      kO(find(and(hypos,Prod_lth)))=0;
      kP(find(and(hypos,Prod_lth)))=0;

	  %hypoxia -> compensates but does not compensate enough to proliferate
	  kS(find(and(hypox,No_eff)))=2*kS_tissue;
      kO(find(and(hypox,No_eff)))=kO_maint;
      kP(find(and(hypox,No_eff)))=2*kP_tissue;

	  kS(find(and(hypox,Prod_rct)))=2*kS_tissue;
      kO(find(and(hypox,Prod_rct)))=kO_maint;
      kP(find(and(hypox,Prod_rct)))=2*kP_tissue;

	  kS(find(and(hypox,Prod_lth)))=0;
      kO(find(and(hypox,Prod_lth)))=0;
      kP(find(and(hypox,Prod_lth)))=0;


	  %hypoxia+hyposubia  -> the conjunction of two energy reductions kills the cell
	  kS(find(and(hypox_hypos,No_eff)))=kS_tissue;
      kO(find(and(hypox_hypos,No_eff)))=kO_maint;
      kP(find(and(hypox_hypos,No_eff)))=kP_tissue;

	  kS(find(and(hypox_hypos,Prod_rct)))=0;
      kO(find(and(hypox_hypos,Prod_rct)))=0;
      kP(find(and(hypox_hypos,Prod_rct)))=0;

	  kS(find(and(hypox_hypos,Prod_lth)))=0;
      kO(find(and(hypox_hypos,Prod_lth)))=0;
      kP(find(and(hypox_hypos,Prod_lth)))=0;

      %starvation (onlly possible w/surctrate)
      kS(find(starv))=0;
      kO(find(starv))=0;
      kP(find(starv))=0;
	  K(find(starv)) = K(find(starv)) + rel_K;


	  %state vector update
	  state(Grid(find(and(well_fed,No_eff))),2)=1;
	  state(Grid(find(and(well_fed,Prod_rct))),2)=0;
	  state(Grid(find(and(well_fed,Prod_lth))),2)=-1;
	  state(Grid(find(and(hypox,No_eff))),2)=2;
	  state(Grid(find(and(hypox,Prod_rct))),2)=1;
	  state(Grid(find(and(hypox,Prod_lth))),2)=-1;
	  state(Grid(find(and(hypos,No_eff))),2)=0; %no proliferation when surctrate is missing
	  state(Grid(find(and(hypos,Prod_rct))),2)=-1; %no proliferation when surctrate is missing
	  state(Grid(find(and(hypos,Prod_lth))),2)=-1; %no proliferation when surctrate is missing
	  state(Grid(find(and(hypox_hypos,No_eff))),2)=0; %no proliferation when surctrate is missing
	  state(Grid(find(and(hypox_hypos,Prod_rct))),2)=-1; %no proliferation when surctrate is missing
	  state(Grid(find(and(hypox_hypos,Prod_lth))),2)=-1; %no proliferation when surctrate is missing
      state(Grid(find(starv)),2)=-1;


      state_mat = 5.*well_fed+4.*hypox+3.*hypos+2.*hypox_hypos+starv;
      prod_mat = 9.*No_eff +8.*Prod_rct+7.*Kine_rct+6.*ProdKine_rct+5.*Prod_lth+4.*Kine_lth+3.*P_rct_K_lth+2.*P_lth_K_rct+1.*ProdKine_lth;

	case 'OS_fragile_P_boost'
	%Now reaction to P is added and is simply detrimental

	%enough of both
      kS(find(and(well_fed,No_eff)))=kS_tissue;
      kO(find(and(well_fed,No_eff)))=kO_tissue;
      kP(find(and(well_fed,No_eff)))=kP_tissue;

	  %product boosts prolif
	  kS(find(and(well_fed,Prod_rct)))=2*kS_tissue;
      kO(find(and(well_fed,Prod_rct)))=2*kO_tissue;
      kP(find(and(well_fed,Prod_rct)))=2*kP_tissue;

	  % too much product kills the cell
	  kS(find(and(well_fed,Prod_lth)))=0;
      kO(find(and(well_fed,Prod_lth)))=0;
      kP(find(and(well_fed,Prod_lth)))=0;

	  %not enough substrate -> stops proliferation
	  kS(find(and(hypos,No_eff)))=kS_maint;
      kO(find(and(hypos,No_eff)))=kO_maint;
      kP(find(and(hypos,No_eff)))=kP_maint;

	  % cell does not tolerate medium product amounts with low energy
	  kS(find(and(hypos,Prod_rct)))=kS_tissue;
      kO(find(and(hypos,Prod_rct)))=kO_tissue;
      kP(find(and(hypos,Prod_rct)))=kP_tissue;

	 % cell does not tolerate high product amounts with low energy
	  kS(find(and(hypos,Prod_lth)))=0;
      kO(find(and(hypos,Prod_lth)))=0;
      kP(find(and(hypos,Prod_lth)))=0;

	  %hypoxia -> compensates but does not compensate enough to proliferate
	  kS(find(and(hypox,No_eff)))=2*kS_tissue;
      kO(find(and(hypox,No_eff)))=kO_maint;
      kP(find(and(hypox,No_eff)))=2*kP_tissue;

	  kS(find(and(hypox,Prod_rct)))=2*kS_tissue;
      kO(find(and(hypox,Prod_rct)))=kO_maint;
      kP(find(and(hypox,Prod_rct)))=2*kP_tissue;

	  kS(find(and(hypox,Prod_lth)))=0;
      kO(find(and(hypox,Prod_lth)))=0;
      kP(find(and(hypox,Prod_lth)))=0;


	  %hypoxia+hyposubia  -> the conjunction of two energy reductions kills the cell
	  kS(find(and(hypox_hypos,No_eff)))=0;
      kO(find(and(hypox_hypos,No_eff)))=0;
      kP(find(and(hypox_hypos,No_eff)))=0;

	  kS(find(and(hypox_hypos,Prod_rct)))=kS_maint;
      kO(find(and(hypox_hypos,Prod_rct)))=kO_maint;
      kP(find(and(hypox_hypos,Prod_rct)))=kP_maint;

	  kS(find(and(hypox_hypos,Prod_lth)))=0;
      kO(find(and(hypox_hypos,Prod_lth)))=0;
      kP(find(and(hypox_hypos,Prod_lth)))=0;

      %starvation (onlly possible w/surctrate)
      kS(find(starv))=0;
      kO(find(starv))=0;
      kP(find(starv))=0;
	  K(find(starv)) = K(find(starv)) + rel_K;


	  %state vector update
	  state(Grid(find(and(well_fed,No_eff))),2)=1;
	  state(Grid(find(and(well_fed,Prod_rct))),2)=2;
	  state(Grid(find(and(well_fed,Prod_lth))),2)=-1;
	  state(Grid(find(and(hypox,No_eff))),2)=0;
	  state(Grid(find(and(hypox,Prod_rct))),2)=1;
	  state(Grid(find(and(hypox,Prod_lth))),2)=-1;
	  state(Grid(find(and(hypos,No_eff))),2)=0; %no proliferation when surctrate is missing
	  state(Grid(find(and(hypos,Prod_rct))),2)=1; %no proliferation when surctrate is missing
	  state(Grid(find(and(hypos,Prod_lth))),2)=-1; %no proliferation when surctrate is missing
	  state(Grid(find(and(hypox_hypos,No_eff))),2)=-1; %no proliferation when surctrate is missing
	  state(Grid(find(and(hypox_hypos,Prod_rct))),2)=-1; %no proliferation when surctrate is missing
	  state(Grid(find(and(hypox_hypos,Prod_lth))),2)=-1; %no proliferation when surctrate is missing
      state(Grid(find(starv)),2)=-1;

      state_mat = 5.*well_fed+4.*hypox+3.*hypos+2.*hypox_hypos+starv;
      prod_mat = 9.*No_eff +8.*Prod_rct+7.*Kine_rct+6.*ProdKine_rct+5.*Prod_lth+4.*Kine_lth+3.*P_rct_K_lth+2.*P_lth_K_rct+1.*ProdKine_lth;

	case 'OS_hypox_boost_P_boost'
	%Now reaction to P is added and is simply detrimental

	%enough of both
      kS(find(and(well_fed,No_eff)))=kS_tissue;
      kO(find(and(well_fed,No_eff)))=kO_tissue;
      kP(find(and(well_fed,No_eff)))=kP_tissue;

	  %product boosts prolif
	  kS(find(and(well_fed,Prod_rct)))=2*kS_tissue;
      kO(find(and(well_fed,Prod_rct)))=2*kO_tissue;
      kP(find(and(well_fed,Prod_rct)))=2*kP_tissue;

	  % too much product kills the cell
	  kS(find(and(well_fed,Prod_lth)))=0;
      kO(find(and(well_fed,Prod_lth)))=0;
      kP(find(and(well_fed,Prod_lth)))=0;

	  %not enough substrate -> stops proliferation
	  kS(find(and(hypos,No_eff)))=kS_maint;
      kO(find(and(hypos,No_eff)))=kO_maint;
      kP(find(and(hypos,No_eff)))=kP_maint;

	  % product restores prolif
	  kS(find(and(hypos,Prod_rct)))=kS_tissue;
      kO(find(and(hypos,Prod_rct)))=kO_tissue;
      kP(find(and(hypos,Prod_rct)))=kP_tissue;

	 % cell does not tolerate high product amounts with low energy
	  kS(find(and(hypos,Prod_lth)))=0;
      kO(find(and(hypos,Prod_lth)))=0;
      kP(find(and(hypos,Prod_lth)))=0;

	  %hypoxia -> compensates but does not compensate enough to proliferate
	  kS(find(and(hypox,No_eff)))=2*kS_tissue;
      kO(find(and(hypox,No_eff)))=kO_maint;
      kP(find(and(hypox,No_eff)))=2*kP_tissue;

	  kS(find(and(hypox,Prod_rct)))=3*kS_tissue;
      kO(find(and(hypox,Prod_rct)))=kO_tissue;
      kP(find(and(hypox,Prod_rct)))=3*kP_tissue;

	  kS(find(and(hypox,Prod_lth)))=0;
      kO(find(and(hypox,Prod_lth)))=0;
      kP(find(and(hypox,Prod_lth)))=0;


	  %hypoxia+hyposubia  -> the conjunction of two energy reductions kills the cell
	  kS(find(and(hypox_hypos,No_eff)))=kS_tissue;
      kO(find(and(hypox_hypos,No_eff)))=kO_maint;
      kP(find(and(hypox_hypos,No_eff)))=kP_tissue;

	  kS(find(and(hypox_hypos,Prod_rct)))=2*kS_tissue;
      kO(find(and(hypox_hypos,Prod_rct)))=kO_maint;
      kP(find(and(hypox_hypos,Prod_rct)))=2*kP_maint;

	  kS(find(and(hypox_hypos,Prod_lth)))=0;
      kO(find(and(hypox_hypos,Prod_lth)))=0;
      kP(find(and(hypox_hypos,Prod_lth)))=0;

      %starvation (onlly possible w/surctrate)
      kS(find(starv))=0;
      kO(find(starv))=0;
      kP(find(starv))=0;
	  K(find(starv)) = K(find(starv)) + rel_K;


	  %state vector update
	  state(Grid(find(and(well_fed,No_eff))),2)=1;
	  state(Grid(find(and(well_fed,Prod_rct))),2)=2;
	  state(Grid(find(and(well_fed,Prod_lth))),2)=-1;
	  state(Grid(find(and(hypox,No_eff))),2)=2;
	  state(Grid(find(and(hypox,Prod_rct))),2)=3;
	  state(Grid(find(and(hypox,Prod_lth))),2)=-1;
	  state(Grid(find(and(hypos,No_eff))),2)=0; %no proliferation when surctrate is missing
	  state(Grid(find(and(hypos,Prod_rct))),2)=1; %no proliferation when surctrate is missing
	  state(Grid(find(and(hypos,Prod_lth))),2)=-1; %no proliferation when surctrate is missing
	  state(Grid(find(and(hypox_hypos,No_eff))),2)=0; %no proliferation when surctrate is missing
	  state(Grid(find(and(hypox_hypos,Prod_rct))),2)=1; %no proliferation when surctrate is missing
	  state(Grid(find(and(hypox_hypos,Prod_lth))),2)=-1; %no proliferation when surctrate is missing
      state(Grid(find(starv)),2)=-1;

      state_mat = 5.*well_fed+4.*hypox+3.*hypos+2.*hypox_hypos+starv;
      prod_mat = 9.*No_eff +8.*Prod_rct+7.*Kine_rct+6.*ProdKine_rct+5.*Prod_lth+4.*Kine_lth+3.*P_rct_K_lth+2.*P_lth_K_rct+1.*ProdKine_lth;

	case 'Prod_mediated_hypox_resp'
	%Case where hypoxia is mediated entirely by the product

	%enough of both
      kS(find(and(well_fed,No_eff)))=kS_tissue;
      kO(find(and(well_fed,No_eff)))=kO_tissue;
      kP(find(and(well_fed,No_eff)))=kP_tissue;

	  %product boosts prolif and provokes glyco switch
	  kS(find(and(well_fed,Prod_rct)))=2*kS_tissue;
      kO(find(and(well_fed,Prod_rct)))=kO_maint;
      kP(find(and(well_fed,Prod_rct)))=2*kP_tissue;

	  % too much product kills the cell
	  kS(find(and(well_fed,Prod_lth)))=0;
      kO(find(and(well_fed,Prod_lth)))=0;
      kP(find(and(well_fed,Prod_lth)))=0;

	  %not enough substrate -> stops proliferation
	  kS(find(and(hypos,No_eff)))=kS_maint;
      kO(find(and(hypos,No_eff)))=kO_maint;
      kP(find(and(hypos,No_eff)))=kP_maint;

	  % product restores prolif
	  kS(find(and(hypos,Prod_rct)))=kS_tissue;
      kO(find(and(hypos,Prod_rct)))=kO_tissue;
      kP(find(and(hypos,Prod_rct)))=kP_tissue;

	 % cell does not tolerate high product amounts with low energy
	  kS(find(and(hypos,Prod_lth)))=0;
      kO(find(and(hypos,Prod_lth)))=0;
      kP(find(and(hypos,Prod_lth)))=0;

	  %hypoxia -> compensates but does not compensate enough to proliferate
	  kS(find(and(hypox,No_eff)))=kS_tissue;
      kO(find(and(hypox,No_eff)))=kO_maint;
      kP(find(and(hypox,No_eff)))=kP_tissue;

	  kS(find(and(hypox,Prod_rct)))=2*kS_tissue;
      kO(find(and(hypox,Prod_rct)))=kO_tissue;
      kP(find(and(hypox,Prod_rct)))=2*kP_tissue;

	  kS(find(and(hypox,Prod_lth)))=0;
      kO(find(and(hypox,Prod_lth)))=0;
      kP(find(and(hypox,Prod_lth)))=0;


	  %hypoxia+hyposubia  -> the conjunction of two energy reductions kills the cell
	  kS(find(and(hypox_hypos,No_eff)))=kS_maint;
      kO(find(and(hypox_hypos,No_eff)))=kO_maint;
      kP(find(and(hypox_hypos,No_eff)))=kP_maint;

	  kS(find(and(hypox_hypos,Prod_rct)))=2*kS_tissue;
      kO(find(and(hypox_hypos,Prod_rct)))=kO_maint;
      kP(find(and(hypox_hypos,Prod_rct)))=2*kP_maint;

	  kS(find(and(hypox_hypos,Prod_lth)))=0;
      kO(find(and(hypox_hypos,Prod_lth)))=0;
      kP(find(and(hypox_hypos,Prod_lth)))=0;

      %starvation (onlly possible w/surctrate)
      kS(find(starv))=0;
      kO(find(starv))=0;
      kP(find(starv))=0;
	  K(find(starv)) = K(find(starv)) + rel_K;


	  %state vector update
	  state(Grid(find(and(well_fed,No_eff))),2)=1;
	  state(Grid(find(and(well_fed,Prod_rct))),2)=2;
	  state(Grid(find(and(well_fed,Prod_lth))),2)=-1;
	  state(Grid(find(and(hypox,No_eff))),2)=1;
	  state(Grid(find(and(hypox,Prod_rct))),2)=2;
	  state(Grid(find(and(hypox,Prod_lth))),2)=-1;
	  state(Grid(find(and(hypos,No_eff))),2)=0; %no proliferation when surctrate is missing
	  state(Grid(find(and(hypos,Prod_rct))),2)=1; %no proliferation when surctrate is missing
	  state(Grid(find(and(hypos,Prod_lth))),2)=-1; %no proliferation when surctrate is missing
	  state(Grid(find(and(hypox_hypos,No_eff))),2)=0; %no proliferation when surctrate is missing
	  state(Grid(find(and(hypox_hypos,Prod_rct))),2)=1; %no proliferation when surctrate is missing
	  state(Grid(find(and(hypox_hypos,Prod_lth))),2)=-1; %no proliferation when surctrate is missing
      state(Grid(find(starv)),2)=-1;

      state_mat = 5.*well_fed+4.*hypox+3.*hypos+2.*hypox_hypos+starv;
      prod_mat = 9.*No_eff +8.*Prod_rct+7.*Kine_rct+6.*ProdKine_rct+5.*Prod_lth+4.*Kine_lth+3.*P_rct_K_lth+2.*P_lth_K_rct+1.*ProdKine_lth;


		case 'Prod_mediated_hypox_resp_mig'
	%same as before but with migration

	%enough of both
      kS(find(and(well_fed,No_eff)))=kS_tissue;
      kO(find(and(well_fed,No_eff)))=kO_tissue;
      kP(find(and(well_fed,No_eff)))=kP_tissue;

	  %product boosts prolif and provokes glyco switch
	  kS(find(and(well_fed,Prod_rct)))=2*kS_tissue;
      kO(find(and(well_fed,Prod_rct)))=kO_maint;
      kP(find(and(well_fed,Prod_rct)))=2*kP_tissue;

	  % too much product kills the cell
	  kS(find(and(well_fed,Prod_lth)))=0;
      kO(find(and(well_fed,Prod_lth)))=0;
      kP(find(and(well_fed,Prod_lth)))=0;

	  %not enough substrate -> stops proliferation
	  kS(find(and(hypos,No_eff)))=kS_maint;
      kO(find(and(hypos,No_eff)))=kO_maint;
      kP(find(and(hypos,No_eff)))=kP_maint;

	  % product restores prolif
	  kS(find(and(hypos,Prod_rct)))=kS_tissue;
      kO(find(and(hypos,Prod_rct)))=kO_tissue;
      kP(find(and(hypos,Prod_rct)))=kP_tissue;

	 % cell does not tolerate high product amounts with low energy
	  kS(find(and(hypos,Prod_lth)))=0;
      kO(find(and(hypos,Prod_lth)))=0;
      kP(find(and(hypos,Prod_lth)))=0;

	  %hypoxia -> compensates but does not compensate enough to proliferate
	  kS(find(and(hypox,No_eff)))=kS_tissue;
      kO(find(and(hypox,No_eff)))=kO_maint;
      kP(find(and(hypox,No_eff)))=kP_tissue;

	  kS(find(and(hypox,Prod_rct)))=2*kS_tissue;
      kO(find(and(hypox,Prod_rct)))=kO_tissue;
      kP(find(and(hypox,Prod_rct)))=2*kP_tissue;

	  kS(find(and(hypox,Prod_lth)))=0;
      kO(find(and(hypox,Prod_lth)))=0;
      kP(find(and(hypox,Prod_lth)))=0;


	  %hypoxia+hyposubia  -> the conjunction of two energy reductions kills the cell
	  kS(find(and(hypox_hypos,No_eff)))=kS_maint;
      kO(find(and(hypox_hypos,No_eff)))=kO_maint;
      kP(find(and(hypox_hypos,No_eff)))=kP_maint;

	  kS(find(and(hypox_hypos,Prod_rct)))=2*kS_tissue;
      kO(find(and(hypox_hypos,Prod_rct)))=kO_maint;
      kP(find(and(hypox_hypos,Prod_rct)))=2*kP_maint;

	  kS(find(and(hypox_hypos,Prod_lth)))=0;
      kO(find(and(hypox_hypos,Prod_lth)))=0;
      kP(find(and(hypox_hypos,Prod_lth)))=0;

      %starvation (onlly possible w/surctrate)
      kS(find(starv))=0;
      kO(find(starv))=0;
      kP(find(starv))=0;
	  K(find(starv)) = K(find(starv)) + rel_K;


	  %state vector update
	  state(Grid(find(and(well_fed,No_eff))),2)=1;
	  state(Grid(find(and(well_fed,Prod_rct))),2)=2;
	  state(Grid(find(and(well_fed,Prod_lth))),2)=-1;
	  state(Grid(find(and(hypox,No_eff))),2)=1;
	  state(Grid(find(and(hypox,Prod_rct))),2)=2;
	  state(Grid(find(and(hypox,Prod_lth))),2)=-1;
	  state(Grid(find(and(hypos,No_eff))),2)=0; %no proliferation when surctrate is missing
	  state(Grid(find(and(hypos,Prod_rct))),2)=1; %no proliferation when surctrate is missing
	  state(Grid(find(and(hypos,Prod_lth))),2)=-1; %no proliferation when surctrate is missing
	  state(Grid(find(and(hypox_hypos,No_eff))),2)=0; %no proliferation when surctrate is missing
	  state(Grid(find(and(hypox_hypos,Prod_rct))),2)=1; %no proliferation when surctrate is missing
	  state(Grid(find(and(hypox_hypos,Prod_lth))),2)=-1; %no proliferation when surctrate is missing
      state(Grid(find(starv)),2)=-1;
	  state(Grid(find(sheddable_prod)),2)=0;

      state_mat = 5.*well_fed+4.*hypox+3.*hypos+2.*hypox_hypos+starv;
      prod_mat = 9.*No_eff +8.*Prod_rct+7.*Kine_rct+6.*ProdKine_rct+5.*Prod_lth+4.*Kine_lth+3.*P_rct_K_lth+2.*P_lth_K_rct+1.*ProdKine_lth;



	case 'Prod_cons_in_hypos'
	%Now reaction to P is added and is simply detrimental

	%enough of both
      kS(find(and(well_fed,No_eff)))=kS_tissue;
      kO(find(and(well_fed,No_eff)))=kO_tissue;
      kP(find(and(well_fed,No_eff)))=kP_tissue;

	  %product does nothing
	  kS(find(and(well_fed,Prod_rct)))=kS_tissue;
      kO(find(and(well_fed,Prod_rct)))=kO_tissue;
      kP(find(and(well_fed,Prod_rct)))=kP_maint; %product is moderately consumed and gives a boost in prolif

	  % nada
	  kS(find(and(well_fed,Prod_lth)))=kS_tissue;
      kO(find(and(well_fed,Prod_lth)))=kO_tissue;
      kP(find(and(well_fed,Prod_lth)))=kP_maint;

	  %not enough substrate -> stops proliferation
	  kS(find(and(hypos,No_eff)))=kS_maint;
      kO(find(and(hypos,No_eff)))=kO_maint;
      kP(find(and(hypos,No_eff)))=kP_maint;

	  % product restores prolif  by consuming moderate amount of Prod
	  kS(find(and(hypos,Prod_rct)))=kS_maint;
      kO(find(and(hypos,Prod_rct)))=kO_tissue;
      kP(find(and(hypos,Prod_rct)))=-kP_maint;

	 % cell does not tolerate high product amounts with low energy
	  kS(find(and(hypos,Prod_lth)))=kS_maint;
      kO(find(and(hypos,Prod_lth)))=kO_tissue;
      kP(find(and(hypos,Prod_lth)))=-kP_maint;

	  %hypoxia -> compensates but does not compensate enough to proliferate
	  kS(find(and(hypox,No_eff)))=kS_tissue;
      kO(find(and(hypox,No_eff)))=kO_tissue;
      kP(find(and(hypox,No_eff)))=kP_tissue;

	  kS(find(and(hypox,Prod_rct)))=kS_tissue;
      kO(find(and(hypox,Prod_rct)))=kO_tissue;
      kP(find(and(hypox,Prod_rct)))=kP_maint; %product is moderately consumed and gives a boost in prolif

	  kS(find(and(hypox,Prod_lth)))=kS_tissue;
      kO(find(and(hypox,Prod_lth)))=kO_tissue;
      kP(find(and(hypox,Prod_lth)))=kP_maint;


	  %hypoxia+hyposubia  -> the conjunction of two energy reductions kills the cell
	  kS(find(and(hypox_hypos,No_eff)))=kS_maint;
      kO(find(and(hypox_hypos,No_eff)))=kO_maint;
      kP(find(and(hypox_hypos,No_eff)))=kP_maint;

	  kS(find(and(hypox_hypos,Prod_rct)))=kS_maint;
      kO(find(and(hypox_hypos,Prod_rct)))=kO_maint;
      kP(find(and(hypox_hypos,Prod_rct)))=-kP_tissue;

	  kS(find(and(hypox_hypos,Prod_lth)))=kS_maint;
      kO(find(and(hypox_hypos,Prod_lth)))=kO_maint;
      kP(find(and(hypox_hypos,Prod_lth)))=-kP_tissue;

      %starvation (onlly possible w/surctrate)
      kS(find(and(starv,No_eff)))=0;
      kO(find(and(starv,No_eff)))=0;
      kP(find(and(starv,No_eff)))=0;
	  K(find(and(starv,No_eff))) = K(find(and(starv,No_eff))) + rel_K;

	  %product can rescue from starvation
	  kS(find(and(starv,Prod_rct)))=0;
      kO(find(and(starv,Prod_rct)))=kO_tissue;
      kP(find(and(starv,Prod_rct)))=-2*kP_tissue;
	  K(find(and(starv,Prod_rct))) = K(find(and(starv,Prod_rct))) + rel_K;

	  %product can rescue from starvation
	  kS(find(and(starv,Prod_lth)))=0;
      kO(find(and(starv,Prod_lth)))=kO_tissue;
      kP(find(and(starv,Prod_lth)))=-2*kP_tissue;
	  K(find(and(starv,Prod_lth))) = K(find(and(starv,Prod_lth))) + rel_K;

	  %state vector update
	  state(Grid(find(and(well_fed,No_eff))),2)=1;
	  state(Grid(find(and(well_fed,Prod_rct))),2)=2;
	  state(Grid(find(and(well_fed,Prod_lth))),2)=2;
	  state(Grid(find(and(hypox,No_eff))),2)=1;
	  state(Grid(find(and(hypox,Prod_rct))),2)=2;
	  state(Grid(find(and(hypox,Prod_lth))),2)=2;
	  state(Grid(find(and(hypos,No_eff))),2)=0; %no proliferation when surctrate is missing
	  state(Grid(find(and(hypos,Prod_rct))),2)=1; %no proliferation when surctrate is missing
	  state(Grid(find(and(hypos,Prod_lth))),2)=1; %no proliferation when surctrate is missing
	  state(Grid(find(and(hypox_hypos,No_eff))),2)=0; %no proliferation when surctrate is missing
	  state(Grid(find(and(hypox_hypos,Prod_rct))),2)=1; %no proliferation when surctrate is missing
	  state(Grid(find(and(hypox_hypos,Prod_lth))),2)=1; %no proliferation when surctrate is missing
      state(Grid(find(and(starv,No_eff))),2)=-1;
      state(Grid(find(and(starv,Prod_rct))),2)=1;
      state(Grid(find(and(starv,Prod_lth))),2)=1;

      state_mat = 5.*well_fed+4.*hypox+3.*hypos+2.*hypox_hypos+starv;
      prod_mat = 9.*No_eff +8.*Prod_rct+7.*Kine_rct+6.*ProdKine_rct+5.*Prod_lth+4.*Kine_lth+3.*P_rct_K_lth+2.*P_lth_K_rct+1.*ProdKine_lth;




	case 'Prod_cons_in_hypos_hypox_resp'
	%Now reaction to P is added and is simply detrimental

	%enough of both
      kS(find(and(well_fed,No_eff)))=kS_tissue;
      kO(find(and(well_fed,No_eff)))=kO_tissue;
      kP(find(and(well_fed,No_eff)))=kP_tissue;

	  %product does nothing
	  kS(find(and(well_fed,Prod_rct)))=kS_tissue;
      kO(find(and(well_fed,Prod_rct)))=kO_tissue;
      kP(find(and(well_fed,Prod_rct)))=kP_maint; %product is moderately consumed and gives a boost in prolif

	  % too much product kills the cell
	  kS(find(and(well_fed,Prod_lth)))=kS_tissue;
      kO(find(and(well_fed,Prod_lth)))=kO_tissue;
      kP(find(and(well_fed,Prod_lth)))=kP_maint;

	  %not enough substrate -> stops proliferation
	  kS(find(and(hypos,No_eff)))=kS_maint;
      kO(find(and(hypos,No_eff)))=kO_maint;
      kP(find(and(hypos,No_eff)))=kP_maint;

	  % product restores prolif  by consuming moderate amount of Prod
	  kS(find(and(hypos,Prod_rct)))=kS_maint;
      kO(find(and(hypos,Prod_rct)))=kO_tissue;
      kP(find(and(hypos,Prod_rct)))=-kP_maint;

	 % cell does not tolerate high product amounts with low energy
	  kS(find(and(hypos,Prod_lth)))=kS_maint;
      kO(find(and(hypos,Prod_lth)))=kO_tissue;
      kP(find(and(hypos,Prod_lth)))=-kP_maint;

	  %hypoxia -> compensates but does not compensate enough to proliferate
	  kS(find(and(hypox,No_eff)))=kS_tissue;
      kO(find(and(hypox,No_eff)))=kO_maint;
      kP(find(and(hypox,No_eff)))=kP_tissue;

	  kS(find(and(hypox,Prod_rct)))=2*kS_tissue;
      kO(find(and(hypox,Prod_rct)))=kO_tissue;
      kP(find(and(hypox,Prod_rct)))=kP_tissue; %product is moderately consumed and gives a boost in prolif

	  kS(find(and(hypox,Prod_lth)))=2*kS_tissue;
      kO(find(and(hypox,Prod_lth)))=kO_tissue;
      kP(find(and(hypox,Prod_lth)))=kP_tissue;


	  %hypoxia+hyposubia  -> the conjunction of two energy reductions kills the cell
	  kS(find(and(hypox_hypos,No_eff)))=kS_maint;
      kO(find(and(hypox_hypos,No_eff)))=kO_maint;
      kP(find(and(hypox_hypos,No_eff)))=kP_maint;

	  kS(find(and(hypox_hypos,Prod_rct)))=2*kS_tissue;
      kO(find(and(hypox_hypos,Prod_rct)))=kO_maint;
      kP(find(and(hypox_hypos,Prod_rct)))=-kP_tissue;

	  kS(find(and(hypox_hypos,Prod_lth)))=2*kS_tissue;
      kO(find(and(hypox_hypos,Prod_lth)))=kO_maint;
      kP(find(and(hypox_hypos,Prod_lth)))=-kP_tissue;

      %starvation (onlly possible w/surctrate)
      kS(find(and(starv,No_eff)))=0;
      kO(find(and(starv,No_eff)))=0;
      kP(find(and(starv,No_eff)))=0;
	  K(find(and(starv,No_eff))) = K(find(and(starv,No_eff))) + rel_K;

	  %product can rescue from starvation
	  kS(find(and(starv,Prod_rct)))=0;
      kO(find(and(starv,Prod_rct)))=kO_tissue;
      kP(find(and(starv,Prod_rct)))=-2*kP_tissue;
	  K(find(and(starv,Prod_rct))) = K(find(and(starv,Prod_rct))) + rel_K;

	  %product can rescue from starvation
	  kS(find(and(starv,Prod_lth)))=0;
      kO(find(and(starv,Prod_lth)))=kO_tissue;
      kP(find(and(starv,Prod_lth)))=-2*kP_tissue;
	  K(find(and(starv,Prod_rct))) = K(find(and(starv,Prod_rct))) + rel_K;

	  %state vector update
	  state(Grid(find(and(well_fed,No_eff))),2)=1;
	  state(Grid(find(and(well_fed,Prod_rct))),2)=2;
	  state(Grid(find(and(well_fed,Prod_lth))),2)=2;
	  state(Grid(find(and(hypox,No_eff))),2)=2;
	  state(Grid(find(and(hypox,Prod_rct))),2)=3;
	  state(Grid(find(and(hypox,Prod_lth))),2)=3;
	  state(Grid(find(and(hypos,No_eff))),2)=0; %no proliferation when surctrate is missing
	  state(Grid(find(and(hypos,Prod_rct))),2)=1; %no proliferation when surctrate is missing
	  state(Grid(find(and(hypos,Prod_lth))),2)=1; %no proliferation when surctrate is missing
	  state(Grid(find(and(hypox_hypos,No_eff))),2)=0; %no proliferation when surctrate is missing
	  state(Grid(find(and(hypox_hypos,Prod_rct))),2)=1; %no proliferation when surctrate is missing
	  state(Grid(find(and(hypox_hypos,Prod_lth))),2)=1; %no proliferation when surctrate is missing
      state(Grid(find(and(starv,No_eff))),2)=-1;
      state(Grid(find(and(starv,Prod_rct))),2)=1;
      state(Grid(find(and(starv,Prod_lth))),2)=1;

      state_mat = 5.*well_fed+4.*hypox+3.*hypos+2.*hypox_hypos+starv;
      prod_mat = 9.*No_eff +8.*Prod_rct+7.*Kine_rct+6.*ProdKine_rct+5.*Prod_lth+4.*Kine_lth+3.*P_rct_K_lth+2.*P_lth_K_rct+1.*ProdKine_lth;

	case 'Prod_cons_in_hypos_hypox_resp_mig'
	%Now reaction to P is added and is simply detrimental

	%enough of both
      kS(find(and(well_fed,No_eff)))=kS_tissue;
      kO(find(and(well_fed,No_eff)))=kO_tissue;
      kP(find(and(well_fed,No_eff)))=kP_tissue;

	  %product does nothing
	  kS(find(and(well_fed,Prod_rct)))=kS_tissue;
      kO(find(and(well_fed,Prod_rct)))=kO_tissue;
      kP(find(and(well_fed,Prod_rct)))=kP_maint; %product is moderately consumed and gives a boost in prolif

	  % too much product kills the cell
	  kS(find(and(well_fed,Prod_lth)))=kS_tissue;
      kO(find(and(well_fed,Prod_lth)))=kO_tissue;
      kP(find(and(well_fed,Prod_lth)))=kP_maint;

	  %not enough substrate -> stops proliferation
	  kS(find(and(hypos,No_eff)))=kS_maint;
      kO(find(and(hypos,No_eff)))=kO_maint;
      kP(find(and(hypos,No_eff)))=kP_maint;

	  % product restores prolif  by consuming moderate amount of Prod
	  kS(find(and(hypos,Prod_rct)))=kS_maint;
      kO(find(and(hypos,Prod_rct)))=kO_tissue;
      kP(find(and(hypos,Prod_rct)))=-kP_maint;

	 % cell does not tolerate high product amounts with low energy
	  kS(find(and(hypos,Prod_lth)))=kS_maint;
      kO(find(and(hypos,Prod_lth)))=kO_tissue;
      kP(find(and(hypos,Prod_lth)))=-kP_maint;

	  %hypoxia -> compensates but does not compensate enough to proliferate
	  kS(find(and(hypox,No_eff)))=kS_tissue;
      kO(find(and(hypox,No_eff)))=kO_maint;
      kP(find(and(hypox,No_eff)))=kP_tissue;

	  kS(find(and(hypox,Prod_rct)))=2*kS_tissue;
      kO(find(and(hypox,Prod_rct)))=kO_tissue;
      kP(find(and(hypox,Prod_rct)))=kP_tissue; %product is moderately consumed and gives a boost in prolif

	  kS(find(and(hypox,Prod_lth)))=2*kS_tissue;
      kO(find(and(hypox,Prod_lth)))=kO_tissue;
      kP(find(and(hypox,Prod_lth)))=kP_tissue;


	  %hypoxia+hyposubia  -> the conjunction of two energy reductions kills the cell
	  kS(find(and(hypox_hypos,No_eff)))=kS_maint;
      kO(find(and(hypox_hypos,No_eff)))=kO_maint;
      kP(find(and(hypox_hypos,No_eff)))=kP_maint;

	  kS(find(and(hypox_hypos,Prod_rct)))=2*kS_tissue;
      kO(find(and(hypox_hypos,Prod_rct)))=kO_maint;
      kP(find(and(hypox_hypos,Prod_rct)))=-kP_tissue;

	  kS(find(and(hypox_hypos,Prod_lth)))=2*kS_tissue;
      kO(find(and(hypox_hypos,Prod_lth)))=kO_maint;
      kP(find(and(hypox_hypos,Prod_lth)))=-kP_tissue;

      %starvation (onlly possible w/surctrate)
      kS(find(and(starv,No_eff)))=0;
      kO(find(and(starv,No_eff)))=0;
      kP(find(and(starv,No_eff)))=0;
	  K(find(and(starv,No_eff))) = K(find(and(starv,No_eff))) + rel_K;

	  %product can rescue from starvation
	  kS(find(and(starv,Prod_rct)))=0;
      kO(find(and(starv,Prod_rct)))=kO_tissue;
      kP(find(and(starv,Prod_rct)))=-2*kP_tissue;
	  K(find(and(starv,Prod_rct))) = K(find(and(starv,Prod_rct))) + rel_K;

	  %product can rescue from starvation
	  kS(find(and(starv,Prod_lth)))=0;
      kO(find(and(starv,Prod_lth)))=kO_tissue;
      kP(find(and(starv,Prod_lth)))=-2*kP_tissue;
	  K(find(and(starv,Prod_rct))) = K(find(and(starv,Prod_rct))) + rel_K;

	  %state vector update
	  state(Grid(find(and(well_fed,No_eff))),2)=1;
	  state(Grid(find(and(well_fed,Prod_rct))),2)=2;
	  state(Grid(find(and(well_fed,Prod_lth))),2)=2;
	  state(Grid(find(and(hypox,No_eff))),2)=2;
	  state(Grid(find(and(hypox,Prod_rct))),2)=3;
	  state(Grid(find(and(hypox,Prod_lth))),2)=3;
	  state(Grid(find(and(hypos,No_eff))),2)=0; %no proliferation when surctrate is missing
	  state(Grid(find(and(hypos,Prod_rct))),2)=1; %no proliferation when surctrate is missing
	  state(Grid(find(and(hypos,Prod_lth))),2)=1; %no proliferation when surctrate is missing
	  state(Grid(find(and(hypox_hypos,No_eff))),2)=0; %no proliferation when surctrate is missing
	  state(Grid(find(and(hypox_hypos,Prod_rct))),2)=1; %no proliferation when surctrate is missing
	  state(Grid(find(and(hypox_hypos,Prod_lth))),2)=1; %no proliferation when surctrate is missing
      state(Grid(find(and(starv,No_eff))),2)=-1;
      state(Grid(find(and(starv,Prod_rct))),2)=1;
      state(Grid(find(and(starv,Prod_lth))),2)=1;
	  state(Grid(find(sheddable_prod)),2)=0;

      state_mat = 5.*well_fed+4.*hypox+3.*hypos+2.*hypox_hypos+starv;
      prod_mat = 9.*No_eff +8.*Prod_rct+7.*Kine_rct+6.*ProdKine_rct+5.*Prod_lth+4.*Kine_lth+3.*P_rct_K_lth+2.*P_lth_K_rct+1.*ProdKine_lth;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%OSK models%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
case 'OS_fragile_K_detr'
	%Now reaction to P is added and is simply detrimental

	%enough of both
      kS(find(and(well_fed,No_eff)))=kS_tissue;
      kO(find(and(well_fed,No_eff)))=kO_tissue;
      kP(find(and(well_fed,No_eff)))=kP_tissue;

	  %product stops prolif
	  kS(find(and(well_fed,Kine_rct)))=kS_maint;
      kO(find(and(well_fed,Kine_rct)))=kO_maint;
      kP(find(and(well_fed,Kine_rct)))=kP_maint;

	  % too much product kills the cell
	  kS(find(and(well_fed,Kine_lth)))=0;
      kO(find(and(well_fed,Kine_lth)))=0;
      kP(find(and(well_fed,Kine_lth)))=0;

	  %not enough substrate -> stops proliferation
	  kS(find(and(hypos,No_eff)))=kS_maint;
      kO(find(and(hypos,No_eff)))=kO_maint;
      kP(find(and(hypos,No_eff)))=kP_maint;

	  % cell does not tolerate medium product amounts with low energy
	  kS(find(and(hypos,Kine_rct)))=0;
      kO(find(and(hypos,Kine_rct)))=0;
      kP(find(and(hypos,Kine_rct)))=0;

	 % cell does not tolerate high product amounts with low energy
	  kS(find(and(hypos,Kine_lth)))=0;
      kO(find(and(hypos,Kine_lth)))=0;
      kP(find(and(hypos,Kine_lth)))=0;

	  %hypoxia -> compensates but does not compensate enough to proliferate
	  kS(find(and(hypox,No_eff)))=2*kS_tissue;
      kO(find(and(hypox,No_eff)))=kO_maint;
      kP(find(and(hypox,No_eff)))=2*kP_tissue;

	  kS(find(and(hypox,Kine_rct)))=2*kS_tissue;
      kO(find(and(hypox,Kine_rct)))=kO_maint;
      kP(find(and(hypox,Kine_rct)))=2*kP_tissue;

	  kS(find(and(hypox,Kine_lth)))=0;
      kO(find(and(hypox,Kine_lth)))=0;
      kP(find(and(hypox,Kine_lth)))=0;


	  %hypoxia+hyposubia  -> the conjunction of two energy reductions kills the cell
	  kS(find(and(hypox_hypos,No_eff)))=0;
      kO(find(and(hypox_hypos,No_eff)))=0;
      kP(find(and(hypox_hypos,No_eff)))=0;

	  kS(find(and(hypox_hypos,Kine_rct)))=0;
      kO(find(and(hypox_hypos,Kine_rct)))=0;
      kP(find(and(hypox_hypos,Kine_rct)))=0;

	  kS(find(and(hypox_hypos,Kine_lth)))=0;
      kO(find(and(hypox_hypos,Kine_lth)))=0;
      kP(find(and(hypox_hypos,Kine_lth)))=0;

      %starvation (onlly possible w/surctrate)
      kS(find(starv))=0;
      kO(find(starv))=0;
      kP(find(starv))=0;
	  K(find(starv)) = K(find(starv)) + rel_K;


	  %state vector update
	  state(Grid(find(and(well_fed,No_eff))),2)=1;
	  state(Grid(find(and(well_fed,Kine_rct))),2)=0;
	  state(Grid(find(and(well_fed,Kine_lth))),2)=-1;
	  state(Grid(find(and(hypox,No_eff))),2)=0;
	  state(Grid(find(and(hypox,Kine_rct))),2)=0;
	  state(Grid(find(and(hypox,Kine_lth))),2)=-1;
	  state(Grid(find(and(hypos,No_eff))),2)=0; %no proliferation when surctrate is missing
	  state(Grid(find(and(hypos,Kine_rct))),2)=-1; %no proliferation when surctrate is missing
	  state(Grid(find(and(hypos,Kine_lth))),2)=-1; %no proliferation when surctrate is missing
	  state(Grid(find(and(hypox_hypos,No_eff))),2)=-1; %no proliferation when surctrate is missing
	  state(Grid(find(and(hypox_hypos,Kine_rct))),2)=-1; %no proliferation when surctrate is missing
	  state(Grid(find(and(hypox_hypos,Kine_lth))),2)=-1; %no proliferation when surctrate is missing
      state(Grid(find(starv)),2)=-1;

      state_mat = 5.*well_fed+4.*hypox+3.*hypos+2.*hypox_hypos+starv;
      prod_mat = 9.*No_eff +8.*Kine_rct+7.*Kine_rct+6.*ProdKine_rct+5.*Kine_lth+4.*Kine_lth+3.*P_rct_K_lth+2.*P_lth_K_rct+1.*ProdKine_lth;



	case 'OS_hypox_boost_K_detr'
	%Now reaction to P is added and is simply detrimental

	%enough of both
      kS(find(and(well_fed,No_eff)))=kS_tissue;
      kO(find(and(well_fed,No_eff)))=kO_tissue;
      kP(find(and(well_fed,No_eff)))=kP_tissue;

	  %product stops prolif
	  kS(find(and(well_fed,Kine_rct)))=kS_maint;
      kO(find(and(well_fed,Kine_rct)))=kO_maint;
      kP(find(and(well_fed,Kine_rct)))=kP_maint;

	  % too much product kills the cell
	  kS(find(and(well_fed,Kine_lth)))=0;
      kO(find(and(well_fed,Kine_lth)))=0;
      kP(find(and(well_fed,Kine_lth)))=0;

	  %not enough substrate -> stops proliferation
	  kS(find(and(hypos,No_eff)))=kS_maint;
      kO(find(and(hypos,No_eff)))=kO_maint;
      kP(find(and(hypos,No_eff)))=kP_maint;

	  % cell does not tolerate medium product amounts with low energy
	  kS(find(and(hypos,Kine_rct)))=0;
      kO(find(and(hypos,Kine_rct)))=0;
      kP(find(and(hypos,Kine_rct)))=0;

	 % cell does not tolerate high product amounts with low energy
	  kS(find(and(hypos,Kine_lth)))=0;
      kO(find(and(hypos,Kine_lth)))=0;
      kP(find(and(hypos,Kine_lth)))=0;

	  %hypoxia -> compensates but does not compensate enough to proliferate
	  kS(find(and(hypox,No_eff)))=2*kS_tissue;
      kO(find(and(hypox,No_eff)))=kO_maint;
      kP(find(and(hypox,No_eff)))=2*kP_tissue;

	  kS(find(and(hypox,Kine_rct)))=2*kS_tissue;
      kO(find(and(hypox,Kine_rct)))=kO_maint;
      kP(find(and(hypox,Kine_rct)))=2*kP_tissue;

	  kS(find(and(hypox,Kine_lth)))=0;
      kO(find(and(hypox,Kine_lth)))=0;
      kP(find(and(hypox,Kine_lth)))=0;


	  %hypoxia+hyposubia  -> the conjunction of two energy reductions kills the cell
	  kS(find(and(hypox_hypos,No_eff)))=kS_tissue;
      kO(find(and(hypox_hypos,No_eff)))=kO_maint;
      kP(find(and(hypox_hypos,No_eff)))=kP_tissue;

	  kS(find(and(hypox_hypos,Kine_rct)))=0;
      kO(find(and(hypox_hypos,Kine_rct)))=0;
      kP(find(and(hypox_hypos,Kine_rct)))=0;

	  kS(find(and(hypox_hypos,Kine_lth)))=0;
      kO(find(and(hypox_hypos,Kine_lth)))=0;
      kP(find(and(hypox_hypos,Kine_lth)))=0;

      %starvation (onlly possible w/surctrate)
      kS(find(starv))=0;
      kO(find(starv))=0;
      kP(find(starv))=0;
	  K(find(starv)) = K(find(starv)) + rel_K;


	  %state vector update
	  state(Grid(find(and(well_fed,No_eff))),2)=1;
	  state(Grid(find(and(well_fed,Kine_rct))),2)=0;
	  state(Grid(find(and(well_fed,Kine_lth))),2)=-1;
	  state(Grid(find(and(hypox,No_eff))),2)=2;
	  state(Grid(find(and(hypox,Kine_rct))),2)=1;
	  state(Grid(find(and(hypox,Kine_lth))),2)=-1;
	  state(Grid(find(and(hypos,No_eff))),2)=0; %no proliferation when surctrate is missing
	  state(Grid(find(and(hypos,Kine_rct))),2)=-1; %no proliferation when surctrate is missing
	  state(Grid(find(and(hypos,Kine_lth))),2)=-1; %no proliferation when surctrate is missing
	  state(Grid(find(and(hypox_hypos,No_eff))),2)=0; %no proliferation when surctrate is missing
	  state(Grid(find(and(hypox_hypos,Kine_rct))),2)=-1; %no proliferation when surctrate is missing
	  state(Grid(find(and(hypox_hypos,Kine_lth))),2)=-1; %no proliferation when surctrate is missing
      state(Grid(find(starv)),2)=-1;

      state_mat = 5.*well_fed+4.*hypox+3.*hypos+2.*hypox_hypos+starv;
      prod_mat = 9.*No_eff +8.*Prod_rct+7.*Kine_rct+6.*ProdKine_rct+5.*Prod_lth+4.*Kine_lth+3.*P_rct_K_lth+2.*P_lth_K_rct+1.*ProdKine_lth;



case 'OS_fragile_K_boost'
	%Now reaction to P is added and is simply detrimental

	%enough of both
      kS(find(and(well_fed,No_eff)))=kS_tissue;
      kO(find(and(well_fed,No_eff)))=kO_tissue;
      kP(find(and(well_fed,No_eff)))=kP_tissue;

	  %product boosts prolif
	  kS(find(and(well_fed,Kine_rct)))=2*kS_tissue;
      kO(find(and(well_fed,Kine_rct)))=2*kO_tissue;
      kP(find(and(well_fed,Kine_rct)))=2*kP_tissue;

	  % too much product kills the cell
	  kS(find(and(well_fed,Kine_lth)))=0;
      kO(find(and(well_fed,Kine_lth)))=0;
      kP(find(and(well_fed,Kine_lth)))=0;

	  %not enough substrate -> stops proliferation
	  kS(find(and(hypos,No_eff)))=kS_maint;
      kO(find(and(hypos,No_eff)))=kO_maint;
      kP(find(and(hypos,No_eff)))=kP_maint;

	  % cell does not tolerate medium product amounts with low energy
	  kS(find(and(hypos,Kine_rct)))=kS_tissue;
      kO(find(and(hypos,Kine_rct)))=kO_tissue;
      kP(find(and(hypos,Kine_rct)))=kP_tissue;

	 % cell does not tolerate high product amounts with low energy
	  kS(find(and(hypos,Kine_lth)))=0;
      kO(find(and(hypos,Kine_lth)))=0;
      kP(find(and(hypos,Kine_lth)))=0;

	  %hypoxia -> compensates but does not compensate enough to proliferate
	  kS(find(and(hypox,No_eff)))=2*kS_tissue;
      kO(find(and(hypox,No_eff)))=kO_maint;
      kP(find(and(hypox,No_eff)))=2*kP_tissue;

	  kS(find(and(hypox,Kine_rct)))=2*kS_tissue;
      kO(find(and(hypox,Kine_rct)))=kO_maint;
      kP(find(and(hypox,Kine_rct)))=2*kP_tissue;

	  kS(find(and(hypox,Kine_lth)))=0;
      kO(find(and(hypox,Kine_lth)))=0;
      kP(find(and(hypox,Kine_lth)))=0;


	  %hypoxia+hyposubia  -> the conjunction of two energy reductions kills the cell
	  kS(find(and(hypox_hypos,No_eff)))=0;
      kO(find(and(hypox_hypos,No_eff)))=0;
      kP(find(and(hypox_hypos,No_eff)))=0;

	  kS(find(and(hypox_hypos,Kine_rct)))=kS_maint;
      kO(find(and(hypox_hypos,Kine_rct)))=kO_maint;
      kP(find(and(hypox_hypos,Kine_rct)))=kP_maint;

	  kS(find(and(hypox_hypos,Kine_lth)))=0;
      kO(find(and(hypox_hypos,Kine_lth)))=0;
      kP(find(and(hypox_hypos,Kine_lth)))=0;

      %starvation (onlly possible w/surctrate)
      kS(find(starv))=0;
      kO(find(starv))=0;
      kP(find(starv))=0;
	  K(find(starv)) = K(find(starv)) + rel_K;


	  %state vector update
	  state(Grid(find(and(well_fed,No_eff))),2)=1;
	  state(Grid(find(and(well_fed,Kine_rct))),2)=2;
	  state(Grid(find(and(well_fed,Kine_lth))),2)=-1;
	  state(Grid(find(and(hypox,No_eff))),2)=0;
	  state(Grid(find(and(hypox,Kine_rct))),2)=1;
	  state(Grid(find(and(hypox,Kine_lth))),2)=-1;
	  state(Grid(find(and(hypos,No_eff))),2)=0; %no proliferation when surctrate is missing
	  state(Grid(find(and(hypos,Kine_rct))),2)=1; %no proliferation when surctrate is missing
	  state(Grid(find(and(hypos,Kine_lth))),2)=-1; %no proliferation when surctrate is missing
	  state(Grid(find(and(hypox_hypos,No_eff))),2)=-1; %no proliferation when surctrate is missing
	  state(Grid(find(and(hypox_hypos,Kine_rct))),2)=-1; %no proliferation when surctrate is missing
	  state(Grid(find(and(hypox_hypos,Kine_lth))),2)=-1; %no proliferation when surctrate is missing
      state(Grid(find(starv)),2)=-1;

      state_mat = 5.*well_fed+4.*hypox+3.*hypos+2.*hypox_hypos+starv;
      prod_mat = 9.*No_eff +8.*Prod_rct+7.*Kine_rct+6.*ProdKine_rct+5.*Prod_lth+4.*Kine_lth+3.*P_rct_K_lth+2.*P_lth_K_rct+1.*ProdKine_lth;

	case 'OS_hypox_boost_K_boost'
	%Now reaction to P is added and is simply detrimental

	%enough of both
      kS(find(and(well_fed,No_eff)))=kS_tissue;
      kO(find(and(well_fed,No_eff)))=kO_tissue;
      kP(find(and(well_fed,No_eff)))=kP_tissue;

	  %product boosts prolif
	  kS(find(and(well_fed,Kine_rct)))=2*kS_tissue;
      kO(find(and(well_fed,Kine_rct)))=2*kO_tissue;
      kP(find(and(well_fed,Kine_rct)))=2*kP_tissue;

	  % too much product kills the cell
	  kS(find(and(well_fed,Kine_lth)))=0;
      kO(find(and(well_fed,Kine_lth)))=0;
      kP(find(and(well_fed,Kine_lth)))=0;

	  %not enough substrate -> stops proliferation
	  kS(find(and(hypos,No_eff)))=kS_maint;
      kO(find(and(hypos,No_eff)))=kO_maint;
      kP(find(and(hypos,No_eff)))=kP_maint;

	  % product restores prolif
	  kS(find(and(hypos,Kine_rct)))=kS_tissue;
      kO(find(and(hypos,Kine_rct)))=kO_tissue;
      kP(find(and(hypos,Kine_rct)))=kP_tissue;

	 % cell does not tolerate high product amounts with low energy
	  kS(find(and(hypos,Kine_lth)))=0;
      kO(find(and(hypos,Kine_lth)))=0;
      kP(find(and(hypos,Kine_lth)))=0;

	  %hypoxia -> compensates but does not compensate enough to proliferate
	  kS(find(and(hypox,No_eff)))=2*kS_tissue;
      kO(find(and(hypox,No_eff)))=kO_maint;
      kP(find(and(hypox,No_eff)))=2*kP_tissue;

	  kS(find(and(hypox,Kine_rct)))=3*kS_tissue;
      kO(find(and(hypox,Kine_rct)))=kO_tissue;
      kP(find(and(hypox,Kine_rct)))=3*kP_tissue;

	  kS(find(and(hypox,Kine_lth)))=0;
      kO(find(and(hypox,Kine_lth)))=0;
      kP(find(and(hypox,Kine_lth)))=0;


	  %hypoxia+hyposubia  -> the conjunction of two energy reductions kills the cell
	  kS(find(and(hypox_hypos,No_eff)))=kS_tissue;
      kO(find(and(hypox_hypos,No_eff)))=kO_maint;
      kP(find(and(hypox_hypos,No_eff)))=kP_tissue;

	  kS(find(and(hypox_hypos,Kine_rct)))=2*kS_tissue;
      kO(find(and(hypox_hypos,Kine_rct)))=kO_maint;
      kP(find(and(hypox_hypos,Kine_rct)))=2*kP_maint;

	  kS(find(and(hypox_hypos,Kine_lth)))=0;
      kO(find(and(hypox_hypos,Kine_lth)))=0;
      kP(find(and(hypox_hypos,Kine_lth)))=0;

      %starvation (onlly possible w/surctrate)
      kS(find(starv))=0;
      kO(find(starv))=0;
      kP(find(starv))=0;
	  K(find(starv)) = K(find(starv)) + rel_K;


	  %state vector update
	  state(Grid(find(and(well_fed,No_eff))),2)=1;
	  state(Grid(find(and(well_fed,Kine_rct))),2)=2;
	  state(Grid(find(and(well_fed,Kine_lth))),2)=-1;
	  state(Grid(find(and(hypox,No_eff))),2)=2;
	  state(Grid(find(and(hypox,Kine_rct))),2)=3;
	  state(Grid(find(and(hypox,Kine_lth))),2)=-1;
	  state(Grid(find(and(hypos,No_eff))),2)=0; %no proliferation when surctrate is missing
	  state(Grid(find(and(hypos,Kine_rct))),2)=1; %no proliferation when surctrate is missing
	  state(Grid(find(and(hypos,Kine_lth))),2)=-1; %no proliferation when surctrate is missing
	  state(Grid(find(and(hypox_hypos,No_eff))),2)=0; %no proliferation when surctrate is missing
	  state(Grid(find(and(hypox_hypos,Kine_rct))),2)=1; %no proliferation when surctrate is missing
	  state(Grid(find(and(hypox_hypos,Kine_lth))),2)=-1; %no proliferation when surctrate is missing
      state(Grid(find(starv)),2)=-1;

      state_mat = 5.*well_fed+4.*hypox+3.*hypos+2.*hypox_hypos+starv;
      prod_mat = 9.*No_eff +8.*Prod_rct+7.*Kine_rct+6.*ProdKine_rct+5.*Prod_lth+4.*Kine_lth+3.*P_rct_K_lth+2.*P_lth_K_rct+1.*ProdKine_lth;

	case 'Kine_mediated_hypox_resp'
	%Now reaction to P is added and is simply detrimental

	%enough of both
      kS(find(and(well_fed,No_eff)))=kS_tissue;
      kO(find(and(well_fed,No_eff)))=kO_tissue;
      kP(find(and(well_fed,No_eff)))=kP_tissue;

	  %product boosts prolif and provokes glyco switch
	  kS(find(and(well_fed,Kine_rct)))=2*kS_tissue;
      kO(find(and(well_fed,Kine_rct)))=kO_maint;
      kP(find(and(well_fed,Kine_rct)))=2*kP_tissue;

	  % too much product kills the cell
	  kS(find(and(well_fed,Kine_lth)))=0;
      kO(find(and(well_fed,Kine_lth)))=0;
      kP(find(and(well_fed,Kine_lth)))=0;

	  %not enough substrate -> stops proliferation
	  kS(find(and(hypos,No_eff)))=kS_maint;
      kO(find(and(hypos,No_eff)))=kO_maint;
      kP(find(and(hypos,No_eff)))=kP_maint;

	  % product restores prolif
	  kS(find(and(hypos,Kine_rct)))=kS_tissue;
      kO(find(and(hypos,Kine_rct)))=kO_tissue;
      kP(find(and(hypos,Kine_rct)))=kP_tissue;

	 % cell does not tolerate high product amounts with low energy
	  kS(find(and(hypos,Kine_lth)))=0;
      kO(find(and(hypos,Kine_lth)))=0;
      kP(find(and(hypos,Kine_lth)))=0;

	  %hypoxia -> compensates but does not compensate enough to proliferate
	  kS(find(and(hypox,No_eff)))=kS_tissue;
      kO(find(and(hypox,No_eff)))=kO_maint;
      kP(find(and(hypox,No_eff)))=kP_tissue;

	  kS(find(and(hypox,Kine_rct)))=2*kS_tissue;
      kO(find(and(hypox,Kine_rct)))=kO_tissue;
      kP(find(and(hypox,Kine_rct)))=2*kP_tissue;

	  kS(find(and(hypox,Kine_lth)))=0;
      kO(find(and(hypox,Kine_lth)))=0;
      kP(find(and(hypox,Kine_lth)))=0;


	  %hypoxia+hyposubia  -> the conjunction of two energy reductions kills the cell
	  kS(find(and(hypox_hypos,No_eff)))=kS_maint;
      kO(find(and(hypox_hypos,No_eff)))=kO_maint;
      kP(find(and(hypox_hypos,No_eff)))=kP_maint;

	  kS(find(and(hypox_hypos,Kine_rct)))=2*kS_tissue;
      kO(find(and(hypox_hypos,Kine_rct)))=kO_maint;
      kP(find(and(hypox_hypos,Kine_rct)))=2*kP_maint;

	  kS(find(and(hypox_hypos,Kine_lth)))=0;
      kO(find(and(hypox_hypos,Kine_lth)))=0;
      kP(find(and(hypox_hypos,Kine_lth)))=0;

      %starvation (onlly possible w/surctrate)
      kS(find(starv))=0;
      kO(find(starv))=0;
      kP(find(starv))=0;
	  K(find(starv)) = K(find(starv)) + rel_K;


	  %state vector update
	  state(Grid(find(and(well_fed,No_eff))),2)=1;
	  state(Grid(find(and(well_fed,Kine_rct))),2)=2;
	  state(Grid(find(and(well_fed,Kine_lth))),2)=-1;
	  state(Grid(find(and(hypox,No_eff))),2)=1;
	  state(Grid(find(and(hypox,Kine_rct))),2)=2;
	  state(Grid(find(and(hypox,Kine_lth))),2)=-1;
	  state(Grid(find(and(hypos,No_eff))),2)=0; %no proliferation when surctrate is missing
	  state(Grid(find(and(hypos,Kine_rct))),2)=1; %no proliferation when surctrate is missing
	  state(Grid(find(and(hypos,Kine_lth))),2)=-1; %no proliferation when surctrate is missing
	  state(Grid(find(and(hypox_hypos,No_eff))),2)=0; %no proliferation when surctrate is missing
	  state(Grid(find(and(hypox_hypos,Kine_rct))),2)=1; %no proliferation when surctrate is missing
	  state(Grid(find(and(hypox_hypos,Kine_lth))),2)=-1; %no proliferation when surctrate is missing
      state(Grid(find(starv)),2)=-1;

      state_mat = 5.*well_fed+4.*hypox+3.*hypos+2.*hypox_hypos+starv;
      prod_mat = 9.*No_eff +8.*Prod_rct+7.*Kine_rct+6.*ProdKine_rct+5.*Prod_lth+4.*Kine_lth+3.*P_rct_K_lth+2.*P_lth_K_rct+1.*ProdKine_lth;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


endswitch
err =0;
endfunction


