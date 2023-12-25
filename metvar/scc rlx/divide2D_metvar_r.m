## Copyright (C) 2023 antony.bazir
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
## @deftypefn {} {@var{retval} =} divide2D_metvar_r (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: antony.bazir <antonybazir@antonybazir-Latitude-E7450>
## Created: 2023-12-23

%On ne donne plus directement la valeur de k mais on fixe le dkS

function    [Grid,LD,kO,dkO,kS,dkS,kP,DSm,DOm,DPm,DKm,Rt_S,Rt_O,state] = divide2D_metvar_r(Grid,LD,pos_p,c_idx,sz,S,P,O,K,state,kO,dkO,kS,dkS,kP,kO_tissue,kS_tissue,kP_tissue,DOm,DSm,DPm,DKm,DOx_tissue,DS_tissue,DP_tissue,DK_tissue,Rt_S,Rt_O,reac_time);
%disp('divid*****************************')
%sort(Grid(find(Grid!=0)))
%kbhit;
##
%plr = randi(1:4);
pos_p;

%grille de zéro et de 1
Grid_bool = Grid!=0;
shift_vec =[];

%définit les points voisins
ngh_vec(1:3) = Grid_bool(pos_p(1)-1,pos_p(2)-1:pos_p(2)+1);
ngh_vec(6:8) = Grid_bool(pos_p(1)+1,pos_p(2)-1:pos_p(2)+1);
ngh_vec(4:5) = [Grid_bool(pos_p(1),pos_p(2)-1) Grid_bool(pos_p(1),pos_p(2)+1)];


%position possible pour les voisins
ng(1,:) = [pos_p(1)-1 pos_p(2)-1];
ng(2,:) = [pos_p(1)-1 pos_p(2)];
ng(3,:) = [pos_p(1)-1 pos_p(2)+1];
ng(4,:) = [pos_p(1) pos_p(2)-1];
ng(5,:) = [pos_p(1) pos_p(2)+1];
ng(6,:) = [pos_p(1)+1 pos_p(2)-1];
ng(7,:) = [pos_p(1)+1 pos_p(2)];
ng(8,:) = [pos_p(1)+1 pos_p(2)+1];



c_idx;
opn_ngh = find(ngh_vec==0);
if(isempty(opn_ngh)==0)
  plr = opn_ngh(randi(length(opn_ngh)));
else
  plr = randi(8);
endif

%disp('first if');
plr;

    if(Grid(ng(plr,1),ng(plr,2))!=0)
      int_pos = [ng(plr,1) ng(plr,2)];
       % on parcours tous les points dans la direction
			while(Grid(int_pos(1),int_pos(2))!=0)
     % disp('while')
				%vecteur des positions parcourues dans la direction choisies
				shift_vec = [shift_vec; int_pos];

        ig(1,:) = [int_pos(1)-1 int_pos(2)-1];
        ig(2,:) = [int_pos(1)-1 int_pos(2)];
        ig(3,:) = [int_pos(1)-1 int_pos(2)+1];
        ig(4,:) = [int_pos(1) int_pos(2)-1];
        ig(5,:) = [int_pos(1) int_pos(2)+1];
        ig(6,:) = [int_pos(1)+1 int_pos(2)-1];
        ig(7,:) = [int_pos(1)+1 int_pos(2)];
        ig(8,:) = [int_pos(1)+1 int_pos(2)+1];

				int_pos = [ig(plr,1) ig(plr,2)];
			endwhile

      %on retourne le vecteur
			shift_vec = flip(shift_vec,1);

      Grid_before_problem = Grid;

      for i=1:size(shift_vec,1)
        %('loop1')
        %position pour le shift
        sv(1,:) = [shift_vec(i,1)-1 shift_vec(i,2)-1];
        sv(2,:) = [shift_vec(i,1)-1 shift_vec(i,2)];
        sv(3,:) = [shift_vec(i,1)-1 shift_vec(i,2)+1];
        sv(4,:) = [shift_vec(i,1) shift_vec(i,2)-1];
        sv(5,:) = [shift_vec(i,1) shift_vec(i,2)+1];
        sv(6,:) = [shift_vec(i,1)+1 shift_vec(i,2)-1];
        sv(7,:) = [shift_vec(i,1)+1 shift_vec(i,2)];
        sv(8,:) = [shift_vec(i,1)+1 shift_vec(i,2)+1];



				Grid(sv(plr,1),sv(plr,2)) = Grid(shift_vec(i,1),shift_vec(i,2));
				LD(sv(plr,1),sv(plr,2)) = LD(shift_vec(i,1),shift_vec(i,2));
				kO(sv(plr,1),sv(plr,2)) = kO(shift_vec(i,1),shift_vec(i,2));
				dkO(sv(plr,1),sv(plr,2)) = dkO(shift_vec(i,1),shift_vec(i,2));
				kS(sv(plr,1),sv(plr,2)) = kS(shift_vec(i,1),shift_vec(i,2));
				dkS(sv(plr,1),sv(plr,2)) = dkS(shift_vec(i,1),shift_vec(i,2));
				kP(sv(plr,1),sv(plr,2)) = kP(shift_vec(i,1),shift_vec(i,2));
				DSm(sv(plr,1),sv(plr,2)) = DSm(shift_vec(i,1),shift_vec(i,2));
				Dpm(sv(plr,1),sv(plr,2)) = DPm(shift_vec(i,1),shift_vec(i,2));
				DOm(sv(plr,1),sv(plr,2)) = DOm(shift_vec(i,1),shift_vec(i,2));
				DKm(sv(plr,1),sv(plr,2)) = DKm(shift_vec(i,1),shift_vec(i,2));
				Rt_S(sv(plr,1),sv(plr,2)) = Rt_S(shift_vec(i,1),shift_vec(i,2));
				Rt_O(sv(plr,1),sv(plr,2)) = Rt_O(shift_vec(i,1),shift_vec(i,2));


			endfor

        Grid(ng(plr,1),ng(plr,2)) = size(state,1)+1;
        LD(ng(plr,1),ng(plr,2)) = 1;
        dkO(ng(plr,1),ng(plr,2)) = kO_tissue - kO(ng(plr,1),ng(plr,2));
        dkS(ng(plr,1),ng(plr,2)) = kS_tissue - kS(ng(plr,1),ng(plr,2));
        kP(ng(plr,1),ng(plr,2)) = kP_tissue;
        DSm(ng(plr,1),ng(plr,2)) = DS_tissue;
        DPm(ng(plr,1),ng(plr,2)) = DP_tissue;
        DOm(ng(plr,1),ng(plr,2)) = DOx_tissue;
        DKm(ng(plr,1),ng(plr,2)) = DK_tissue;
        Rt_S(ng(plr,1),ng(plr,2)) = reac_time;
        Rt_O(ng(plr,1),ng(plr,2)) = reac_time;
        cycle_duration = 1; % round(interp1([0.150 0.0375 0.015],[2.8000-0.6 6.6000-0.6 400.0000-0.6]*24*60,O(find(Grid==c_idx)))+864);
        state(size(state,1)+1,:) = [0 cycle_duration];

         if(max(max(Grid))!=length(find(Grid!=0)))
          disp(['2-Problem_shift:' num2str(plr) '/' num2str(c_idx)])
          Grid(17:32,17:32)
          size(state,1)
          kbhit;
          Grid_before_problem(17:32,17:32)
          kbhit;
          return
        endif

		else

      if(max(max(Grid))!=length(find(Grid!=0)))
          disp(['3-Problem_shift:' num2str(plr) '/' num2str(c_idx)])
            Grid(17:32,17:32)
            kbhit;
            Grid_before_problem(17:32,17:32)
            kbhit;
          return
        endif

        Grid(ng(plr,1),ng(plr,2)) = size(state,1)+1;
        LD(ng(plr,1),ng(plr,2)) = 1;
        dkO(ng(plr,1),ng(plr,2)) = kO_tissue - kO(ng(plr,1),ng(plr,2));
        dkS(ng(plr,1),ng(plr,2)) = kS_tissue - kS(ng(plr,1),ng(plr,2));
        kP(ng(plr,1),ng(plr,2)) = kP_tissue;
        DSm(ng(plr,1),ng(plr,2)) = DS_tissue;
        DPm(ng(plr,1),ng(plr,2)) = DP_tissue;
        DOm(ng(plr,1),ng(plr,2)) = DOx_tissue;
        DKm(ng(plr,1),ng(plr,2)) = DK_tissue;
        Rt_S(ng(plr,1),ng(plr,2)) = reac_time;
        Rt_O(ng(plr,1),ng(plr,2)) = reac_time;
        cycle_duration = 1; % round(interp1([0.150 0.0375 0.015],[2.8000-0.6 6.6000-0.6 400.0000-0.6]*24*60,O(find(Grid==c_idx)))+864);
        state(size(state,1)+1,:) = [0 cycle_duration];

         if(max(max(Grid))!=length(find(Grid!=0)))
            disp(['4 - Problem:' num2str(plr)])
            Grid(17:32,17:32)
            kbhit;
            Grid_before_problem(17:32,17:32)
            kbhit;
            return
        endif
    endif

%sort(Grid(find(Grid!=0)))
%kbhit;
##
##
##%division and switching !
##
##plr;
##switch(plr)
##	case 1
##    % Si la case d'à côté est vide on définit une position intermédiaire
##		if(Grid(pos(1)-1,pos(2)-1)!=0)
##			int_pos = [pos(1)-1,pos(2)-1];
##      % on parcours tous les points dans la direction
##			while(Grid(int_pos(1),int_pos(2))!=0)
##				%vecteur des positions parcourues dans la direction choisies
##				shift_vec = [shift_vec; int_pos];
##				int_pos = [int_pos(1)-1 int_pos(2)-1];
##			endwhile
##
##      %on retourne le vecteur
##			shift_vec = flip(shift_vec,1);
##
##			for i=1:size(shift_vec,1)
##				Grid(shift_vec(i,1)-1,shift_vec(i,2)-1) = Grid(shift_vec(i,1),shift_vec(i,2));
##				kO(shift_vec(i,1)-1,shift_vec(i,2)-1) = kO(shift_vec(i,1),shift_vec(i,2));
##				dkO(shift_vec(i,1)-1,shift_vec(i,2)-1) = dkO(shift_vec(i,1),shift_vec(i,2));
##				kS(shift_vec(i,1)-1,shift_vec(i,2)-1) = kS(shift_vec(i,1),shift_vec(i,2));
##				dkS(shift_vec(i,1)-1,shift_vec(i,2)-1) = dkS(shift_vec(i,1),shift_vec(i,2));
##				kP(shift_vec(i,1)-1,shift_vec(i,2)-1) = kP(shift_vec(i,1),shift_vec(i,2));
##				DSm(shift_vec(i,1)-1,shift_vec(i,2)-1) = DSm(shift_vec(i,1),shift_vec(i,2));
##				Dpm(shift_vec(i,1)-1,shift_vec(i,2)-1) = DPm(shift_vec(i,1),shift_vec(i,2));
##				DOm(shift_vec(i,1)-1,shift_vec(i,2)-1) = DOm(shift_vec(i,1),shift_vec(i,2));
##				DKm(shift_vec(i,1)-1,shift_vec(i,2)-1) = DKm(shift_vec(i,1),shift_vec(i,2));
##        Rt_S(shift_vec(i,1)-1,shift_vec(i,2)-1) = Rt_S(shift_vec(i,1),shift_vec(i,2));
##        Rt_O(shift_vec(i,1)-1,shift_vec(i,2)-1) = Rt_O(shift_vec(i,1),shift_vec(i,2));
##			endfor
##
##			Grid(pos(1)-1,pos(2)-1) = size(state,1)+1;
##			%kO(pos(1)-1,pos(2)-1) = kO_tissue;
##      %kS(pos(1)-1,pos(2)-1) = kS_tissue;
##			dkO(pos(1)-1,pos(2)-1) = kO_tissue  - kO(pos(1)-1,pos(2)-1);
##			dkS(pos(1)-1,pos(2)-1) = kS_tissue - kS(pos(1)-1,pos(2)-1);
##      Rt_S(pos(1)-1,pos(2)-1) = 120;
##      Rt_O(pos(1)-1,pos(2)-1) = 120;
##			kP(pos(1)-1,pos(2)-1) = kP_tissue;
##			DSm(pos(1)-1,pos(2)-1) = DS_tissue;
##			DPm(pos(1)-1,pos(2)-1) = DP_tissue;
##			DOm(pos(1)-1,pos(2)-1) = DOx_tissue;
##			DKm(pos(1)-1,pos(2)-1) = DK_tissue;
##			cycle_duration = 1; % round(interp1([0.150 0.0375 0.015],[2.8000-0.6 6.6000-0.6 400.0000-0.6]*24*60,O(find(Grid==c_idx)))+864);
##			state(size(state,1)+1,:) = [0 cycle_duration];
##
##		else
##
##			Grid(pos(1)-1,pos(2)-1) = size(state,1)+1;
##      dkO(pos(1)-1,pos(2)-1) = kO_tissue  - kO(pos(1)-1,pos(2)-1);
##			dkS(pos(1)-1,pos(2)-1) = kS_tissue - kS(pos(1)-1,pos(2)-1);
##      Rt_S(pos(1)-1,pos(2)-1) = 120;
##      Rt_O(pos(1)-1,pos(2)-1) = 120;
##			kP(pos(1)-1,pos(2)-1) = kP_tissue;
##			DSm(pos(1)-1,pos(2)-1) = DS_tissue;
##			DPm(pos(1)-1,pos(2)-1) = DP_tissue;
##			DOm(pos(1)-1,pos(2)-1) = DOx_tissue;
##			DKm(pos(1)-1,pos(2)-1) = DK_tissue;
##			cycle_duration = 1; % round(interp1([0.150 0.0375 0.015],[2.8000-0.6 6.6000-0.6 400.0000-0.6]*24*60,O(find(Grid==c_idx)))+864);
##			state(size(state,1)+1,:) = [0 cycle_duration];
##
##		endif
##
##    case 2
##		if(Grid(pos(1)-1,pos(2))!=0)
##			int_pos = [pos(1)-1,pos(2)];
##			while(Grid(int_pos(1),int_pos(2))!=0)
##				%vecteur des positions parcourues dans la direction choisies
##				shift_vec = [shift_vec; int_pos];
##				int_pos = [int_pos(1)-1 int_pos(2)];
##			endwhile
##
##			%on retourne le vecteur
##			shift_vec = flip(shift_vec,1);
##
##			for i=1:size(shift_vec,1)
##				Grid(shift_vec(i,1)-1,shift_vec(i,2)) = Grid(shift_vec(i,1),shift_vec(i,2));
##				kO(shift_vec(i,1)-1,shift_vec(i,2)) = kO(shift_vec(i,1),shift_vec(i,2));
##				dkO(shift_vec(i,1)-1,shift_vec(i,2)) = dkO(shift_vec(i,1),shift_vec(i,2));
##				kS(shift_vec(i,1)-1,shift_vec(i,2)) = kS(shift_vec(i,1),shift_vec(i,2));
##				dkS(shift_vec(i,1)-1,shift_vec(i,2)) = dkS(shift_vec(i,1),shift_vec(i,2));
##				kP(shift_vec(i,1)-1,shift_vec(i,2)) = kP(shift_vec(i,1),shift_vec(i,2));
##				DOm(shift_vec(i,1)-1,shift_vec(i,2)) = DOm(shift_vec(i,1),shift_vec(i,2));
##				DKm(shift_vec(i,1)-1,shift_vec(i,2)) = DKm(shift_vec(i,1),shift_vec(i,2));
##				DPm(shift_vec(i,1)-1,shift_vec(i,2)) = DPm(shift_vec(i,1),shift_vec(i,2));
##				DSm(shift_vec(i,1)-1,shift_vec(i,2)) = DSm(shift_vec(i,1),shift_vec(i,2));
##				Rt_S(shift_vec(i,1)-1,shift_vec(i,2)) = Rt_S(shift_vec(i,1),shift_vec(i,2));
##				Rt_O(shift_vec(i,1)-1,shift_vec(i,2)) = Rt_O(shift_vec(i,1),shift_vec(i,2));
##			endfor
##
##			Grid(pos(1)-1,pos(2)) = size(state,1)+1;
##			dkO(pos(1)-1,pos(2)) = kO_tissue - kO(pos(1)-1,pos(2));
##			dkS(pos(1)-1,pos(2)) = kS_tissue - kS(pos(1)-1,pos(2));
##			kP(pos(1)-1,pos(2)) = kP_tissue;
##			DOm(pos(1)-1,pos(2)) = DOx_tissue;
##			DKm(pos(1)-1,pos(2)) = DK_tissue;
##			DSm(pos(1)-1,pos(2)) = DS_tissue;
##			DPm(pos(1)-1,pos(2)) = DP_tissue;
##			cycle_duration = 1; % round(interp1([0.150 0.0375 0.015],[2.8000-0.6 6.6000-0.6 400.0000-0.6]*24*60,O(find(Grid==c_idx)))+864);
##			state(size(state,1)+1,:) = [0 cycle_duration];
##
##		else
##
##			Grid(pos(1)-1,pos(2)) = size(state,1)+1;
##			dkO(pos(1)-1,pos(2)) = kO_tissue - kO(pos(1)-1,pos(2));
##			dkS(pos(1)-1,pos(2)) = kS_tissue - kS(pos(1)-1,pos(2));
##			kP(pos(1)-1,pos(2)) = kP_tissue;
##			Rt_S(pos(1)-1,pos(2)) = 120;
##			Rt_O(pos(1)-1,pos(2)) = 120;
##			DOm(pos(1)-1,pos(2)) = DOx_tissue;
##			DKm(pos(1)-1,pos(2)) = DK_tissue;
##			DSm(pos(1)-1,pos(2)) = DS_tissue;
##			DPm(pos(1)-1,pos(2)) = DP_tissue;
##			cycle_duration = 1; % round(interp1([0.150 0.0375 0.015],[2.8000-0.6 6.6000-0.6 400.0000-0.6]*24*60,O(find(Grid==c_idx)))+864);
##			state(size(state,1)+1,:) = [0 cycle_duration];
##
##		endif
##
##	case 3
##
##		if(Grid(pos(1)-1,pos(2)+1)!=0)
##			int_pos = [pos(1)-1,pos(2)+1];
##			while(Grid(int_pos(1),int_pos(2))!=0)
##				%vecteur des positions parcourues dans la direction choisies
##				shift_vec = [shift_vec; int_pos];
##				int_pos = [int_pos(1)-1 int_pos(2)+1];
##			endwhile
##
##		%on retourne le vecteur
##			shift_vec = flip(shift_vec,1);
##
##			for i=1:size(shift_vec,1)
##				Grid(shift_vec(i,1)-1,shift_vec(i,2)+1) = Grid(shift_vec(i,1),shift_vec(i,2));
##				kO(shift_vec(i,1)-1,shift_vec(i,2)+1) = kO(shift_vec(i,1),shift_vec(i,2));
##				dkO(shift_vec(i,1)-1,shift_vec(i,2)+1) = dkO(shift_vec(i,1),shift_vec(i,2));
##				kS(shift_vec(i,1)-1,shift_vec(i,2)+1) = kS(shift_vec(i,1),shift_vec(i,2));
##				dkS(shift_vec(i,1)-1,shift_vec(i,2)+1) = dkS(shift_vec(i,1),shift_vec(i,2));
##				kP(shift_vec(i,1)-1,shift_vec(i,2)+1) = kP(shift_vec(i,1),shift_vec(i,2));
##				DSm(shift_vec(i,1)-1,shift_vec(i,2)+1) = DSm(shift_vec(i,1),shift_vec(i,2));
##				DPm(shift_vec(i,1)-1,shift_vec(i,2)+1) = DPm(shift_vec(i,1),shift_vec(i,2));
##				DOm(shift_vec(i,1)-1,shift_vec(i,2)+1) = DOm(shift_vec(i,1),shift_vec(i,2));
##				DKm(shift_vec(i,1)-1,shift_vec(i,2)+1) = DKm(shift_vec(i,1),shift_vec(i,2));
##				Rt_S(shift_vec(i,1)-1,shift_vec(i,2)+1) = Rt_S(shift_vec(i,1),shift_vec(i,2));
##				Rt_O(shift_vec(i,1)-1,shift_vec(i,2)+1) = Rt_O(shift_vec(i,1),shift_vec(i,2));
##			endfor
##
##			Grid(pos(1)-1,pos(2)+1) = size(state,1)+1;
##			dkO(pos(1)-1,pos(2)+1) = kO_tissue - kO(pos(1)-1,pos(2)+1);
##			dkS(pos(1)-1,pos(2)+1) = kS_tissue - kS(pos(1)-1,pos(2)+1);
##      Rt_S(pos(1)-1,pos(2)+1) =  120;
##      Rt_O(pos(1)-1,pos(2)+1) =  120;
##			kP(pos(1)-1,pos(2)+1) = kP_tissue;
##			DSm(pos(1)-1,pos(2)+1) = DS_tissue;
##			DPm(pos(1)-1,pos(2)+1) = DP_tissue;
##			DOm(pos(1)-1,pos(2)+1) = DOx_tissue;
##			DKm(pos(1)-1,pos(2)+1) = DK_tissue;
##			cycle_duration = 1; % round(interp1([0.150 0.0375 0.015],[2.8000-0.6 6.6000-0.6 400.0000-0.6]*24*60,O(find(Grid==c_idx)))+864);
##			state(size(state,1)+1,:) = [0 cycle_duration];
##
##		else
##
##			Grid(pos(1)-1,pos(2)+1) = size(state,1)+1;
##			dkO(pos(1)-1,pos(2)+1) = kO_tissue - kO(pos(1)-1,pos(2)+1);
##			dkS(pos(1)-1,pos(2)+1) = kS_tissue - kS(pos(1)-1,pos(2)+1);
##      Rt_S(pos(1)-1,pos(2)+1) =  120;
##      Rt_O(pos(1)-1,pos(2)+1) =  120;
##			kP(pos(1)-1,pos(2)+1) = kP_tissue;
##			DSm(pos(1)-1,pos(2)+1) = DS_tissue;
##			DPm(pos(1)-1,pos(2)+1) = DP_tissue;
##			DOm(pos(1)-1,pos(2)+1) = DOx_tissue;
##			DKm(pos(1)-1,pos(2)+1) = DK_tissue;
##			cycle_duration = 1; % round(interp1([0.150 0.0375 0.015],[2.8000-0.6 6.6000-0.6 400.0000-0.6]*24*60,O(find(Grid==c_idx)))+864);
##			state(size(state,1)+1,:) = [0 cycle_duration];
##
##
##
##		endif
##
##
##	case 4
##
##		if(Grid(pos(1),pos(2)-1)!=0)
##			int_pos = [pos(1),pos(2)-1];
##			while(Grid(int_pos(1),int_pos(2))!=0)
##				%vecteur des positions parcourues dans la direction choisies
##				shift_vec = [shift_vec; int_pos];
##				int_pos = [int_pos(1) int_pos(2)-1];
##			endwhile
##
##			%on retourne le vecteur
##			shift_vec = flip(shift_vec,1);
##
##			for i=1:size(shift_vec,1)
##				Grid(shift_vec(i,1),shift_vec(i,2)-1) = Grid(shift_vec(i,1),shift_vec(i,2));
##				kO(shift_vec(i,1),shift_vec(i,2)-1) = kO(shift_vec(i,1),shift_vec(i,2));
##				kS(shift_vec(i,1),shift_vec(i,2)-1) = kS(shift_vec(i,1),shift_vec(i,2));
##				kP(shift_vec(i,1),shift_vec(i,2)-1) = kP(shift_vec(i,1),shift_vec(i,2));
##				DSm(shift_vec(i,1),shift_vec(i,2)-1) = DSm(shift_vec(i,1),shift_vec(i,2));
##				DPm(shift_vec(i,1),shift_vec(i,2)-1) = DPm(shift_vec(i,1),shift_vec(i,2));
##				DOm(shift_vec(i,1),shift_vec(i,2)-1) = DOm(shift_vec(i,1),shift_vec(i,2));
##				DKm(shift_vec(i,1),shift_vec(i,2)-1) = DKm(shift_vec(i,1),shift_vec(i,2));
##			endfor
##
##			Grid(pos(1),pos(2)-1) = size(state,1)+1;
##			kO(pos(1),pos(2)-1) = kO_tissue;
##			kS(pos(1),pos(2)-1) = kS_tissue;
##			kP(pos(1),pos(2)-1) = kP_tissue;
##			DSm(pos(1),pos(2)-1) = DS_tissue;
##			DPm(pos(1),pos(2)-1) = DP_tissue;
##			DOm(pos(1),pos(2)-1) = DOx_tissue;
##			DKm(pos(1),pos(2)-1) = DK_tissue;
##			cycle_duration = 1; % round(interp1([0.150 0.0375 0.015],[2.8000-0.6 6.6000-0.6 400.0000-0.6]*24*60,O(find(Grid==c_idx)))+864);
##			state(size(state,1)+1,:) = [0 cycle_duration];
##
##
##		else
##
##			Grid(pos(1),pos(2)-1) = size(state,1)+1;
##			kO(pos(1),pos(2)-1) = kO_tissue;
##			kS(pos(1),pos(2)-1) = kS_tissue;
##			kP(pos(1),pos(2)-1) = kP_tissue;
##			DSm(pos(1),pos(2)-1) = DS_tissue;
##			DPm(pos(1),pos(2)-1) = DP_tissue;
##			DOm(pos(1),pos(2)-1) = DOx_tissue;
##			DKm(pos(1),pos(2)-1) = DK_tissue;
##			cycle_duration = 1; % round(interp1([0.150 0.0375 0.015],[2.8000-0.6 6.6000-0.6 400.0000-0.6]*24*60,O(find(Grid==c_idx)))+864);
##			state(size(state,1)+1,:) = [0 cycle_duration];
##
##
##		endif
##
##    case 5
##
##		if(Grid(pos(1),pos(2)+1)!=0)
##			int_pos = [pos(1),pos(2)+1];
##			while(Grid(int_pos(1),int_pos(2))!=0)
##				%vecteur des positions parcourues dans la direction choisies
##				shift_vec = [shift_vec; int_pos];
##				int_pos = [int_pos(1) int_pos(2)+1];
##			endwhile
##
##			%on retourne le vecteur
##			shift_vec = flip(shift_vec,1);
##
##			for i=1:size(shift_vec,1)
##				Grid(shift_vec(i,1),shift_vec(i,2)+1) = Grid(shift_vec(i,1),shift_vec(i,2));
##				kO(shift_vec(i,1),shift_vec(i,2)+1) = kO(shift_vec(i,1),shift_vec(i,2));
##				kS(shift_vec(i,1),shift_vec(i,2)+1) = kS(shift_vec(i,1),shift_vec(i,2));
##				kP(shift_vec(i,1),shift_vec(i,2)+1) = kP(shift_vec(i,1),shift_vec(i,2));
##				DOm(shift_vec(i,1),shift_vec(i,2)+1) = DOm(shift_vec(i,1),shift_vec(i,2));
##				DKm(shift_vec(i,1),shift_vec(i,2)+1) = DKm(shift_vec(i,1),shift_vec(i,2));
##				DSm(shift_vec(i,1),shift_vec(i,2)+1) = DSm(shift_vec(i,1),shift_vec(i,2));
##				DPm(shift_vec(i,1),shift_vec(i,2)+1) = DPm(shift_vec(i,1),shift_vec(i,2));
##			endfor
##
##			Grid(pos(1),pos(2)+1) = size(state,1)+1;
##			kO(pos(1),pos(2)+1) = kO_tissue;
##			kS(pos(1),pos(2)+1) = kS_tissue;
##			kP(pos(1),pos(2)+1) = kP_tissue;
##			DOm(pos(1),pos(2)+1) = DOx_tissue;
##			DKm(pos(1),pos(2)+1) = DK_tissue;
##			DSm(pos(1),pos(2)+1) = DS_tissue;
##			DPm(pos(1),pos(2)+1) = DP_tissue;
##			cycle_duration = 1; % round(interp1([0.150 0.0375 0.015],[2.8000-0.6 6.6000-0.6 400.0000-0.6]*24*60,O(find(Grid==c_idx)))+864);
##			state(size(state,1)+1,:) = [0 cycle_duration];
##
##
##		else
##
##			Grid(pos(1),pos(2)+1) = size(state,1)+1;
##			kO(pos(1),pos(2)+1) = kO_tissue;
##			kS(pos(1),pos(2)+1) = kS_tissue;
##			kP(pos(1),pos(2)+1) = kP_tissue;
##			DOm(pos(1),pos(2)+1) = DOx_tissue;
##			DKm(pos(1),pos(2)+1) = DK_tissue;
##			DSm(pos(1),pos(2)+1) = DS_tissue;
##			DPm(pos(1),pos(2)+1) = DP_tissue;
##			cycle_duration = 1; % round(interp1([0.150 0.0375 0.015],[2.8000-0.6 6.6000-0.6 400.0000-0.6]*24*60,O(find(Grid==c_idx)))+864);
##			state(size(state,1)+1,:) = [0 cycle_duration];
##
##
##		endif
##
##    case 6
##
##		if(Grid(pos(1)+1,pos(2)-1)!=0)
##			int_pos = [pos(1)+1,pos(2)-1];
##			while(Grid(int_pos(1),int_pos(2))!=0)
##				%vecteur des positions parcourues dans la direction choisies
##				shift_vec = [shift_vec; int_pos];
##				int_pos = [int_pos(1)+1 int_pos(2)-1];
##			endwhile
##
##			%on retourne le vecteur
##			shift_vec = flip(shift_vec,1);
##
##			for i=1:size(shift_vec,1)
##				Grid(shift_vec(i,1)+1,shift_vec(i,2)-1) = Grid(shift_vec(i,1),shift_vec(i,2));
##				kO(shift_vec(i,1)+1,shift_vec(i,2)-1) = kO(shift_vec(i,1),shift_vec(i,2));
##				kS(shift_vec(i,1)+1,shift_vec(i,2)-1) = kS(shift_vec(i,1),shift_vec(i,2));
##				kP(shift_vec(i,1)+1,shift_vec(i,2)-1) = kP(shift_vec(i,1),shift_vec(i,2));
##				DOm(shift_vec(i,1)+1,shift_vec(i,2)-1) = DOm(shift_vec(i,1),shift_vec(i,2));
##				DKm(shift_vec(i,1)+1,shift_vec(i,2)-1) = DKm(shift_vec(i,1),shift_vec(i,2));
##				DSm(shift_vec(i,1)+1,shift_vec(i,2)-1) = DSm(shift_vec(i,1),shift_vec(i,2));
##				DPm(shift_vec(i,1)+1,shift_vec(i,2)-1) = DPm(shift_vec(i,1),shift_vec(i,2));
##			endfor
##
##			Grid(pos(1)+1,pos(2)-1) = size(state,1)+1;
##			kO(pos(1)+1,pos(2)-1) = kO_tissue;
##			kS(pos(1)+1,pos(2)-1) = kS_tissue;
##			kP(pos(1)+1,pos(2)-1) = kP_tissue;
##			DOm(pos(1)+1,pos(2)-1) = DOx_tissue;
##			DKm(pos(1)+1,pos(2)-1) = DK_tissue;
##			DSm(pos(1)+1,pos(2)-1) = DS_tissue;
##			DPm(pos(1)+1,pos(2)-1) = DP_tissue;
##			cycle_duration = 1; % round(interp1([0.150 0.0375 0.015],[2.8000-0.6 6.6000-0.6 400.0000-0.6]*24*60,O(find(Grid==c_idx)))+864);
##			state(size(state,1)+1,:) = [0 cycle_duration];
##
##
##		else
##
##			Grid(pos(1)+1,pos(2)-1) = size(state,1)+1;
##			kO(pos(1)+1,pos(2)-1) = kO_tissue;
##			kS(pos(1)+1,pos(2)-1) = kS_tissue;
##			kP(pos(1)+1,pos(2)-1) = kP_tissue;
##			DOm(pos(1)+1,pos(2)-1) = DOx_tissue;
##			DKm(pos(1)+1,pos(2)-1) = DK_tissue;
##			DSm(pos(1)+1,pos(2)-1) = DS_tissue;
##			DPm(pos(1)+1,pos(2)-1) = DP_tissue;
##			cycle_duration = 1; % round(interp1([0.150 0.0375 0.015],[2.8000-0.6 6.6000-0.6 400.0000-0.6]*24*60,O(find(Grid==c_idx)))+864);
##			state(size(state,1)+1,:) = [0 cycle_duration];
##
##
##		endif
##
##    case 7
##
##		if(Grid(pos(1)+1,pos(2))!=0)
##			int_pos = [pos(1)+1,pos(2)];
##			while(Grid(int_pos(1),int_pos(2))!=0)
##				%vecteur des positions parcourues dans la direction choisies
##				shift_vec = [shift_vec; int_pos];
##				int_pos = [int_pos(1)+1 int_pos(2)];
##			endwhile
##
##			%on retourne le vecteur
##			shift_vec = flip(shift_vec,1);
##
##			for i=1:size(shift_vec,1)
##				Grid(shift_vec(i,1)+1,shift_vec(i,2)) = Grid(shift_vec(i,1),shift_vec(i,2));
##				kO(shift_vec(i,1)+1,shift_vec(i,2)) = kO(shift_vec(i,1),shift_vec(i,2));
##				kS(shift_vec(i,1)+1,shift_vec(i,2)) = kS(shift_vec(i,1),shift_vec(i,2));
##				kP(shift_vec(i,1)+1,shift_vec(i,2)) = kP(shift_vec(i,1),shift_vec(i,2));
##				DOm(shift_vec(i,1)+1,shift_vec(i,2)) = DOm(shift_vec(i,1),shift_vec(i,2));
##				DKm(shift_vec(i,1)+1,shift_vec(i,2)) = DKm(shift_vec(i,1),shift_vec(i,2));
##				DSm(shift_vec(i,1)+1,shift_vec(i,2)) = DSm(shift_vec(i,1),shift_vec(i,2));
##				DPm(shift_vec(i,1)+1,shift_vec(i,2)) = DPm(shift_vec(i,1),shift_vec(i,2));
##			endfor
##
##			Grid(pos(1)+1,pos(2)) = size(state,1)+1;
##			kO(pos(1)+1,pos(2)) = kO_tissue;
##			kS(pos(1)+1,pos(2)) = kS_tissue;
##			kP(pos(1)+1,pos(2)) = kP_tissue;
##			DOm(pos(1)+1,pos(2)) = DOx_tissue;
##			DKm(pos(1)+1,pos(2)) = DK_tissue;
##			DSm(pos(1)+1,pos(2)) = DS_tissue;
##			DPm(pos(1)+1,pos(2)) = DP_tissue;
##			cycle_duration = 1; % round(interp1([0.150 0.0375 0.015],[2.8000-0.6 6.6000-0.6 400.0000-0.6]*24*60,O(find(Grid==c_idx)))+864);
##			state(size(state,1)+1,:) = [0 cycle_duration];
##
##		else
##
##			Grid(pos(1)+1,pos(2)) = size(state,1)+1;
##			kO(pos(1)+1,pos(2)) = kO_tissue;
##			kS(pos(1)+1,pos(2)) = kS_tissue;
##			kP(pos(1)+1,pos(2)) = kP_tissue;
##			DOm(pos(1)+1,pos(2)) = DOx_tissue;
##			DKm(pos(1)+1,pos(2)) = DK_tissue;
##			DSm(pos(1)+1,pos(2)) = DS_tissue;
##			DPm(pos(1)+1,pos(2)) = DP_tissue;
##			cycle_duration = 1; % round(interp1([0.150 0.0375 0.015],[2.8000-0.6 6.6000-0.6 400.0000-0.6]*24*60,O(find(Grid==c_idx)))+864);
##			state(size(state,1)+1,:) = [0 cycle_duration];
##
##		endif
##
##    case 8
##
##		if(Grid(pos(1)+1,pos(2)+1)!=0)
##			int_pos = [pos(1)+1,pos(2)+1];
##			while(Grid(int_pos(1),int_pos(2))!=0)
##				%vecteur des positions parcourues dans la direction choisies
##				shift_vec = [shift_vec; int_pos];
##				int_pos = [int_pos(1)+1 int_pos(2)+1];
##			endwhile
##
##			%on retourne le vecteur
##			shift_vec = flip(shift_vec,1);
##
##			for i=1:size(shift_vec,1)
##				Grid(shift_vec(i,1)+1,shift_vec(i,2)+1) = Grid(shift_vec(i,1),shift_vec(i,2));
##				kO(shift_vec(i,1)+1,shift_vec(i,2)+1) = kO(shift_vec(i,1),shift_vec(i,2));
##				kS(shift_vec(i,1)+1,shift_vec(i,2)+1) = kS(shift_vec(i,1),shift_vec(i,2));
##				kP(shift_vec(i,1)+1,shift_vec(i,2)+1) = kP(shift_vec(i,1),shift_vec(i,2));
##				DOm(shift_vec(i,1)+1,shift_vec(i,2)+1) = DOm(shift_vec(i,1),shift_vec(i,2));
##				DKm(shift_vec(i,1)+1,shift_vec(i,2)+1) = DKm(shift_vec(i,1),shift_vec(i,2));
##				DSm(shift_vec(i,1)+1,shift_vec(i,2)+1) = DSm(shift_vec(i,1),shift_vec(i,2));
##				DPm(shift_vec(i,1)+1,shift_vec(i,2)+1) = DPm(shift_vec(i,1),shift_vec(i,2));
##			endfor
##
##			Grid(pos(1)+1,pos(2)+1) = size(state,1)+1;
##			kO(pos(1)+1,pos(2)+1) = kO_tissue;
##			kS(pos(1)+1,pos(2)+1) = kS_tissue;
##			kP(pos(1)+1,pos(2)+1) = kP_tissue;
##			DOm(pos(1)+1,pos(2)+1) = DOx_tissue;
##			DKm(pos(1)+1,pos(2)+1) = DK_tissue;
##			DSm(pos(1)+1,pos(2)+1) = DS_tissue;
##			DPm(pos(1)+1,pos(2)+1) = DP_tissue;
##			cycle_duration = 1; % round(interp1([0.150 0.0375 0.015],[2.8000-0.6 6.6000-0.6 400.0000-0.6]*24*60,O(find(Grid==c_idx)))+864);
##			state(size(state,1)+1,:) = [0 cycle_duration];
##
##		else
##
##			Grid(pos(1)+1,pos(2)+1) = size(state,1)+1;
##			kO(pos(1)+1,pos(2)+1) = kO_tissue;
##			kS(pos(1)+1,pos(2)+1) = kS_tissue;
##			kP(pos(1)+1,pos(2)+1) = kP_tissue;
##			DOm(pos(1)+1,pos(2)+1) = DOx_tissue;
##			DKm(pos(1)+1,pos(2)+1) = DK_tissue;
##			DSm(pos(1)+1,pos(2)+1) = DS_tissue;
##			DPm(pos(1)+1,pos(2)+1) = DP_tissue;
##			cycle_duration = 1; % round(interp1([0.150 0.0375 0.015],[2.8000-0.6 6.6000-0.6 400.0000-0.6]*24*60,O(find(Grid==c_idx)))+864);
##			state(size(state,1)+1,:) = [0 cycle_duration];
##
##		endif
##
##endswitch
##return
##'called'
##

endfunction
