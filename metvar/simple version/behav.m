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

function [kS,kO,kP,state,state_mat] = behav(behavior,Grid,S,P,O,state,kO,kS,kP,kO_tissue,kS_tissue,kP_tissue,DOm,DSm,DPm,DOx_tissue,DS_tissue,DP_tissue,S_prol,S_maint,O_norm)

  well_fed = and(S>=S_prol,O>=O_norm,Grid!=0);
  hypox = and(S>=S_prol,O<O_norm,Grid!=0);
  hypos = and(S<S_prol,S>=S_maint,O>=O_norm,Grid!=0);
  hypox_hypos = and(S<S_prol,S>=S_maint,O<O_norm,Grid!=0);
  starv = and(S<S_maint,Grid!=0);

  switch(behavior)
      case 0
      disp('nada');
	  state_mat = Grid!=0;


      case 1
      %enough of both
      kS(find(well_fed))=kS_tissue;
      kO(find(well_fed))=kO_tissue;

      %starvation (onlly possible w/substrate)
      kS(find(starv))=0;
      kO(find(starv))=0;
      state(Grid(find(starv)),2)=-1;

      state_mat = 2.*well_fed+starv;
  endswitch
endfunction


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
##		kS(find(starv)=0;
##		kO(find(starv))=0;
##		state(Grid(find(starv)),2)=-1;
