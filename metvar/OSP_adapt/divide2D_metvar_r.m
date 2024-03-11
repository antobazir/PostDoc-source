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

function    [Grid,LD,kO,kS,kP,DSm,DOm,DPm,state,state_mat,err] = divide2D_metvar_r(Grid,LD,pos_p,c_idx,sz,S,O,P,state,state_mat,kO,kS,kP,kO_tissue,kS_tissue,kP_tissue,DOm,DSm,DPm,DOx_tissue,DS_tissue,DP_tissue,reac_time);
%disp('divid*****************************')
%sort(Grid(find(Grid!=0)))
%kbhit;
##
%plr = randi(1:4);
disp('div')

       if(size(kS,1)!=sz)
          disp('wrong resizing before divide')
          save('debug')
          err =1;
          return
        endif


pos_p;
if(length(find(Grid!=0))==1)
[ctroid(1) ctroid(2) v] = find(Grid!=0);
else
[gx gy v] = find(Grid!=0);
ctroid = round(centroid(gx,gy));
endif


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
##size(kS)
##kbhit;

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
				kS(sv(plr,1),sv(plr,2)) = kS(shift_vec(i,1),shift_vec(i,2));
				kP(sv(plr,1),sv(plr,2)) = kP(shift_vec(i,1),shift_vec(i,2));
				DSm(sv(plr,1),sv(plr,2)) = DSm(shift_vec(i,1),shift_vec(i,2));
				DPm(sv(plr,1),sv(plr,2)) = DPm(shift_vec(i,1),shift_vec(i,2));
				DOm(sv(plr,1),sv(plr,2)) = DOm(shift_vec(i,1),shift_vec(i,2));
        state_mat(sv(plr,1),sv(plr,2)) = state_mat(shift_vec(i,1),shift_vec(i,2));
				%prod_mat(sv(plr,1),sv(plr,2)) = prod_mat(shift_vec(i,1),shift_vec(i,2));
				%DKm(sv(plr,1),sv(plr,2)) = DKm(shift_vec(i,1),shift_vec(i,2));
				%Rt_S(sv(plr,1),sv(plr,2)) = Rt_S(shift_vec(i,1),shift_vec(i,2));
				%Rt_O(sv(plr,1),sv(plr,2)) = Rt_O(shift_vec(i,1),shift_vec(i,2));


			endfor

        Grid(ng(plr,1),ng(plr,2)) = size(state,1)+1;
        LD(ng(plr,1),ng(plr,2)) = LD(pos_p(1),pos_p(2));
        kS(ng(plr,1),ng(plr,2)) = kS(pos_p(1),pos_p(2));
        kO(ng(plr,1),ng(plr,2)) = kO(pos_p(1),pos_p(2));
        kP(ng(plr,1),ng(plr,2)) = kP(pos_p(1),pos_p(2));
        DSm(ng(plr,1),ng(plr,2)) = DSm(pos_p(1),pos_p(2));
        DOm(ng(plr,1),ng(plr,2)) = DOm(pos_p(1),pos_p(2));
        state_mat(ng(plr,1),ng(plr,2)) = state_mat(pos_p(1),pos_p(2));
	%prod_mat(ng(plr,1),ng(plr,2)) = prod_mat(pos_p(1),pos_p(2));
        DPm(ng(plr,1),ng(plr,2)) = DPm(pos_p(1),pos_p(2));
        %DKm(ng(plr,1),ng(plr,2)) = DKm(pos_p(1),pos_p(2));
        %Rt_S(ng(plr,1),ng(plr,2)) = reac_time;
        %Rt_O(ng(plr,1),ng(plr,2)) = reac_time;
        d = sqrt((ng(plr,1)-ctroid(1)).^2+(ng(plr,2)-ctroid(2)).^2);
        cycle_duration = 1; % round(interp1([0.150 0.0375 0.015],[2.8000-0.6 6.6000-0.6 400.0000-0.6]*24*60,O(find(Grid==c_idx)))+864);
        state(size(state,1)+1,:) = [0 state(c_idx,2) state(c_idx,3) state(c_idx,4) state(c_idx,5) state(c_idx,6) state(c_idx,7) state(c_idx,8) state(c_idx,9) d c_idx ];        % A priori faudrait faire baisser et remonter le conso lors des divisions mais non.

##        size(kS)
##        kbhit;

##         if(max(max(Grid))!=length(find(Grid!=0)))
##          disp(['2-Problem_shift:' num2str(plr) '/' num2str(c_idx)])
##          Grid(17:32,17:32)
##          size(state,1)
##          kbhit;
##          %Grid_before_problem(17:32,17:32)
##          kbhit;
##          return
##        endif

   	else
##
##      if(max(max(Grid))!=length(find(Grid!=0)))
##          disp(['3-Problem_shift:' num2str(plr) '/' num2str(c_idx)])
##            Grid(17:32,17:32)
##           % kbhit;
##           % Grid_before_problem(17:32,17:32)
##            %kbhit;
##          return
##        endif


        Grid(ng(plr,1),ng(plr,2)) = size(state,1)+1;
        LD(ng(plr,1),ng(plr,2)) = LD(pos_p(1),pos_p(2));
        kS(ng(plr,1),ng(plr,2)) = kS(pos_p(1),pos_p(2));
        kO(ng(plr,1),ng(plr,2)) = kO(pos_p(1),pos_p(2));
        kP(ng(plr,1),ng(plr,2)) = kP(pos_p(1),pos_p(2));
        DSm(ng(plr,1),ng(plr,2)) = DSm(pos_p(1),pos_p(2));
        DOm(ng(plr,1),ng(plr,2)) = DOm(pos_p(1),pos_p(2));
	DPm(ng(plr,1),ng(plr,2)) = DPm(pos_p(1),pos_p(2));
        state_mat(ng(plr,1),ng(plr,2)) = state_mat(pos_p(1),pos_p(2));
	%prod_mat(ng(plr,1),ng(plr,2)) = prod_mat(pos_p(1),pos_p(2));
        %
        %DKm(ng(plr,1),ng(plr,2)) = DKm(pos_p(1),pos_p(2));
        %Rt_S(ng(plr,1),ng(plr,2)) = reac_time;
        %Rt_O(ng(plr,1),ng(plr,2)) = reac_time;
        cycle_duration = 1; % round(interp1([0.150 0.0375 0.015],[2.8000-0.6 6.6000-0.6 400.0000-0.6]*24*60,O(find(Grid==c_idx)))+864);
        d = sqrt((ng(plr,1)-ctroid(1)).^2+(ng(plr,2)-ctroid(2)).^2);
        state(size(state,1)+1,:) = [0 state(c_idx,2) state(c_idx,3) state(c_idx,4) state(c_idx,5) state(c_idx,6) state(c_idx,7) state(c_idx,8) state(c_idx,9) d c_idx];

##         if(max(max(Grid))!=length(find(Grid!=0)))
##            disp(['4 - Problem:' num2str(plr)])
##            Grid(17:32,17:32)
##            kbhit;
##            Grid_before_problem(17:32,17:32)
##            kbhit;
##            return
##        endif

##        size(kS)
##        kbhit;
    endif

        if(size(kS,1)!=sz)
          disp('wrong resizing after divide')
          save('debug')
          err =1;
          return
        endif
err = 0;

endfunction
