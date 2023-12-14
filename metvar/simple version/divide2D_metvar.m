%07/12 on modifie le code pour que le shiftage e

function[Grid,kO,kS,kP,DSm,DOm,DPm,DKm,state] = divide2D_metvar(Grid,pos,c_idx,sz,S,P,O,K,state,kO,kS,kP,kO_tissue,kS_tissue,kP_tissue,DOm,DSm,DPm,DKm,DOx_tissue,DS_tissue,DP_tissue,DK_tissue)%on autorise la diffusion sur les 8 voisins et plus seulement sur 4
%plr = randi(1:4);
pos;

%grille de zéro et de 1
Grid_bool = Grid!=0;
shift_vec =[];

ngh_vec(1:3) = Grid_bool(pos(1)-1,pos(2)-1:pos(2)+1);
ngh_vec(6:8) = Grid_bool(pos(1)+1,pos(2)-1:pos(2)+1);
ngh_vec(4:5) = [Grid_bool(pos(1),pos(2)-1) Grid_bool(pos(1),pos(2)+1)];

c_idx;
opn_ngh = find(ngh_vec==0);
if(isempty(opn_ngh)==0)
  plr = opn_ngh(randi(length(opn_ngh)));
else
  plr = randi(8);
endif


%division and switching !

plr;
switch(plr)
	case 1
    % Si la case d'à côté est vide on définit une position intermédiaire
		if(Grid(pos(1)-1,pos(2)-1)!=0)
			int_pos = [pos(1)-1,pos(2)-1];
      % on parcours tous les points dans la direction
			while(Grid(int_pos(1),int_pos(2))!=0)
				%vecteur des positions parcourues dans la direction choisies
				shift_vec = [shift_vec; int_pos];
				int_pos = [int_pos(1)-1 int_pos(2)-1];
			endwhile

      %on retourne le vecteur
			shift_vec = flip(shift_vec,1);

			for i=1:size(shift_vec,1)
				Grid(shift_vec(i,1)-1,shift_vec(i,2)-1) = Grid(shift_vec(i,1),shift_vec(i,2));
				kO(shift_vec(i,1)-1,shift_vec(i,2)-1) = kO(shift_vec(i,1),shift_vec(i,2));
				kS(shift_vec(i,1)-1,shift_vec(i,2)-1) = kS(shift_vec(i,1),shift_vec(i,2));
				kP(shift_vec(i,1)-1,shift_vec(i,2)-1) = kP(shift_vec(i,1),shift_vec(i,2));
				DSm(shift_vec(i,1)-1,shift_vec(i,2)-1) = DSm(shift_vec(i,1),shift_vec(i,2));
				Dpm(shift_vec(i,1)-1,shift_vec(i,2)-1) = DPm(shift_vec(i,1),shift_vec(i,2));
				DOm(shift_vec(i,1)-1,shift_vec(i,2)-1) = DOm(shift_vec(i,1),shift_vec(i,2));
				DKm(shift_vec(i,1)-1,shift_vec(i,2)-1) = DKm(shift_vec(i,1),shift_vec(i,2));
			endfor

			Grid(pos(1)-1,pos(2)-1) = size(state,1)+1;
			kO(pos(1)-1,pos(2)-1) = kO_tissue;
			kS(pos(1)-1,pos(2)-1) = kS_tissue;
			kP(pos(1)-1,pos(2)-1) = kP_tissue;
			DSm(pos(1)-1,pos(2)-1) = DS_tissue;
			DPm(pos(1)-1,pos(2)-1) = DP_tissue;
			DOm(pos(1)-1,pos(2)-1) = DOx_tissue;
			DKm(pos(1)-1,pos(2)-1) = DK_tissue;
			cycle_duration = 1; % round(interp1([0.150 0.0375 0.015],[2.8000-0.6 6.6000-0.6 400.0000-0.6]*24*60,O(find(Grid==c_idx)))+864);
			state(size(state,1)+1,:) = [0 cycle_duration];

		else

			Grid(pos(1)-1,pos(2)-1) = size(state,1)+1;
			kO(pos(1)-1,pos(2)-1) = kO_tissue;
			kS(pos(1)-1,pos(2)-1) = kS_tissue;
			kP(pos(1)-1,pos(2)-1) = kP_tissue;
			DSm(pos(1)-1,pos(2)-1) = DS_tissue;
			DPm(pos(1)-1,pos(2)-1) = DP_tissue;
			DOm(pos(1)-1,pos(2)-1) = DOx_tissue;
			DKm(pos(1)-1,pos(2)-1) = DK_tissue;
			cycle_duration = 1; % round(interp1([0.150 0.0375 0.015],[2.8000-0.6 6.6000-0.6 400.0000-0.6]*24*60,O(find(Grid==c_idx)))+864);
			state(size(state,1)+1,:) = [0 cycle_duration];

		endif

    case 2
		if(Grid(pos(1)-1,pos(2))!=0)
			int_pos = [pos(1)-1,pos(2)];
			while(Grid(int_pos(1),int_pos(2))!=0)
				%vecteur des positions parcourues dans la direction choisies
				shift_vec = [shift_vec; int_pos];
				int_pos = [int_pos(1)-1 int_pos(2)];
			endwhile

			%on retourne le vecteur
			shift_vec = flip(shift_vec,1);

			for i=1:size(shift_vec,1)
				Grid(shift_vec(i,1)-1,shift_vec(i,2)) = Grid(shift_vec(i,1),shift_vec(i,2));
				kO(shift_vec(i,1)-1,shift_vec(i,2)) = kO(shift_vec(i,1),shift_vec(i,2));
				kS(shift_vec(i,1)-1,shift_vec(i,2)) = kS(shift_vec(i,1),shift_vec(i,2));
				kP(shift_vec(i,1)-1,shift_vec(i,2)) = kP(shift_vec(i,1),shift_vec(i,2));
				DOm(shift_vec(i,1)-1,shift_vec(i,2)) = DOm(shift_vec(i,1),shift_vec(i,2));
				DKm(shift_vec(i,1)-1,shift_vec(i,2)) = DKm(shift_vec(i,1),shift_vec(i,2));
				DPm(shift_vec(i,1)-1,shift_vec(i,2)) = DPm(shift_vec(i,1),shift_vec(i,2));
				DSm(shift_vec(i,1)-1,shift_vec(i,2)) = DSm(shift_vec(i,1),shift_vec(i,2));
			endfor

			Grid(pos(1)-1,pos(2)) = size(state,1)+1;
			kO(pos(1)-1,pos(2)) = kO_tissue;
			kS(pos(1)-1,pos(2)) = kS_tissue;
			kP(pos(1)-1,pos(2)) = kP_tissue;
			DOm(pos(1)-1,pos(2)) = DOx_tissue;
			DKm(pos(1)-1,pos(2)) = DK_tissue;
			DSm(pos(1)-1,pos(2)) = DS_tissue;
			DPm(pos(1)-1,pos(2)) = DP_tissue;
			cycle_duration = 1; % round(interp1([0.150 0.0375 0.015],[2.8000-0.6 6.6000-0.6 400.0000-0.6]*24*60,O(find(Grid==c_idx)))+864);
			state(size(state,1)+1,:) = [0 cycle_duration];

		else

			Grid(pos(1)-1,pos(2)) = size(state,1)+1;
			kO(pos(1)-1,pos(2)) = kO_tissue;
			kS(pos(1)-1,pos(2)) = kS_tissue;
			kP(pos(1)-1,pos(2)) = kP_tissue;
			DOm(pos(1)-1,pos(2)) = DOx_tissue;
			DKm(pos(1)-1,pos(2)) = DK_tissue;
			DSm(pos(1)-1,pos(2)) = DS_tissue;
			DPm(pos(1)-1,pos(2)) = DP_tissue;
			cycle_duration = 1; % round(interp1([0.150 0.0375 0.015],[2.8000-0.6 6.6000-0.6 400.0000-0.6]*24*60,O(find(Grid==c_idx)))+864);
			state(size(state,1)+1,:) = [0 cycle_duration];

		endif

	case 3

		if(Grid(pos(1)-1,pos(2)+1)!=0)
			int_pos = [pos(1)-1,pos(2)+1];
			while(Grid(int_pos(1),int_pos(2))!=0)
				%vecteur des positions parcourues dans la direction choisies
				shift_vec = [shift_vec; int_pos];
				int_pos = [int_pos(1)-1 int_pos(2)+1];
			endwhile

		%on retourne le vecteur
			shift_vec = flip(shift_vec,1);

			for i=1:size(shift_vec,1)
				Grid(shift_vec(i,1)-1,shift_vec(i,2)+1) = Grid(shift_vec(i,1),shift_vec(i,2));
				kO(shift_vec(i,1)-1,shift_vec(i,2)+1) = kO(shift_vec(i,1),shift_vec(i,2));
				kS(shift_vec(i,1)-1,shift_vec(i,2)+1) = kS(shift_vec(i,1),shift_vec(i,2));
				kP(shift_vec(i,1)-1,shift_vec(i,2)+1) = kP(shift_vec(i,1),shift_vec(i,2));
				DSm(shift_vec(i,1)-1,shift_vec(i,2)+1) = DSm(shift_vec(i,1),shift_vec(i,2));
				DPm(shift_vec(i,1)-1,shift_vec(i,2)+1) = DPm(shift_vec(i,1),shift_vec(i,2));
				DOm(shift_vec(i,1)-1,shift_vec(i,2)+1) = DOm(shift_vec(i,1),shift_vec(i,2));
				DKm(shift_vec(i,1)-1,shift_vec(i,2)+1) = DKm(shift_vec(i,1),shift_vec(i,2));
			endfor

			Grid(pos(1)-1,pos(2)+1) = size(state,1)+1;
			kO(pos(1)-1,pos(2)+1) = kO_tissue;
			kS(pos(1)-1,pos(2)+1) = kS_tissue;
			kP(pos(1)-1,pos(2)+1) = kP_tissue;
			DSm(pos(1)-1,pos(2)+1) = DS_tissue;
			DPm(pos(1)-1,pos(2)+1) = DP_tissue;
			DOm(pos(1)-1,pos(2)+1) = DOx_tissue;
			DKm(pos(1)-1,pos(2)+1) = DK_tissue;
			cycle_duration = 1; % round(interp1([0.150 0.0375 0.015],[2.8000-0.6 6.6000-0.6 400.0000-0.6]*24*60,O(find(Grid==c_idx)))+864);
			state(size(state,1)+1,:) = [0 cycle_duration];

		else

			Grid(pos(1)-1,pos(2)+1) = size(state,1)+1;
			kO(pos(1)-1,pos(2)+1) = kO_tissue;
			kS(pos(1)-1,pos(2)+1) = kS_tissue;
			kP(pos(1)-1,pos(2)+1) = kP_tissue;
			DSm(pos(1)-1,pos(2)+1) = DS_tissue;
			DPm(pos(1)-1,pos(2)+1) = DP_tissue;
			DOm(pos(1)-1,pos(2)+1) = DOx_tissue;
			DKm(pos(1)-1,pos(2)+1) = DK_tissue;
			cycle_duration = 1; % round(interp1([0.150 0.0375 0.015],[2.8000-0.6 6.6000-0.6 400.0000-0.6]*24*60,O(find(Grid==c_idx)))+864);
			state(size(state,1)+1,:) = [0 cycle_duration];


		endif


	case 4

		if(Grid(pos(1),pos(2)-1)!=0)
			int_pos = [pos(1),pos(2)-1];
			while(Grid(int_pos(1),int_pos(2))!=0)
				%vecteur des positions parcourues dans la direction choisies
				shift_vec = [shift_vec; int_pos];
				int_pos = [int_pos(1) int_pos(2)-1];
			endwhile

			%on retourne le vecteur
			shift_vec = flip(shift_vec,1);

			for i=1:size(shift_vec,1)
				Grid(shift_vec(i,1),shift_vec(i,2)-1) = Grid(shift_vec(i,1),shift_vec(i,2));
				kO(shift_vec(i,1),shift_vec(i,2)-1) = kO(shift_vec(i,1),shift_vec(i,2));
				kS(shift_vec(i,1),shift_vec(i,2)-1) = kS(shift_vec(i,1),shift_vec(i,2));
				kP(shift_vec(i,1),shift_vec(i,2)-1) = kP(shift_vec(i,1),shift_vec(i,2));
				DSm(shift_vec(i,1),shift_vec(i,2)-1) = DSm(shift_vec(i,1),shift_vec(i,2));
				DPm(shift_vec(i,1),shift_vec(i,2)-1) = DPm(shift_vec(i,1),shift_vec(i,2));
				DOm(shift_vec(i,1),shift_vec(i,2)-1) = DOm(shift_vec(i,1),shift_vec(i,2));
				DKm(shift_vec(i,1),shift_vec(i,2)-1) = DKm(shift_vec(i,1),shift_vec(i,2));
			endfor

			Grid(pos(1),pos(2)-1) = size(state,1)+1;
			kO(pos(1),pos(2)-1) = kO_tissue;
			kS(pos(1),pos(2)-1) = kS_tissue;
			kP(pos(1),pos(2)-1) = kP_tissue;
			DSm(pos(1),pos(2)-1) = DS_tissue;
			DPm(pos(1),pos(2)-1) = DP_tissue;
			DOm(pos(1),pos(2)-1) = DOx_tissue;
			DKm(pos(1),pos(2)-1) = DK_tissue;
			cycle_duration = 1; % round(interp1([0.150 0.0375 0.015],[2.8000-0.6 6.6000-0.6 400.0000-0.6]*24*60,O(find(Grid==c_idx)))+864);
			state(size(state,1)+1,:) = [0 cycle_duration];


		else

			Grid(pos(1),pos(2)-1) = size(state,1)+1;
			kO(pos(1),pos(2)-1) = kO_tissue;
			kS(pos(1),pos(2)-1) = kS_tissue;
			kP(pos(1),pos(2)-1) = kP_tissue;
			DSm(pos(1),pos(2)-1) = DS_tissue;
			DPm(pos(1),pos(2)-1) = DP_tissue;
			DOm(pos(1),pos(2)-1) = DOx_tissue;
			DKm(pos(1),pos(2)-1) = DK_tissue;
			cycle_duration = 1; % round(interp1([0.150 0.0375 0.015],[2.8000-0.6 6.6000-0.6 400.0000-0.6]*24*60,O(find(Grid==c_idx)))+864);
			state(size(state,1)+1,:) = [0 cycle_duration];


		endif

    case 5

		if(Grid(pos(1),pos(2)+1)!=0)
			int_pos = [pos(1),pos(2)+1];
			while(Grid(int_pos(1),int_pos(2))!=0)
				%vecteur des positions parcourues dans la direction choisies
				shift_vec = [shift_vec; int_pos];
				int_pos = [int_pos(1) int_pos(2)+1];
			endwhile

			%on retourne le vecteur
			shift_vec = flip(shift_vec,1);

			for i=1:size(shift_vec,1)
				Grid(shift_vec(i,1),shift_vec(i,2)+1) = Grid(shift_vec(i,1),shift_vec(i,2));
				kO(shift_vec(i,1),shift_vec(i,2)+1) = kO(shift_vec(i,1),shift_vec(i,2));
				kS(shift_vec(i,1),shift_vec(i,2)+1) = kS(shift_vec(i,1),shift_vec(i,2));
				kP(shift_vec(i,1),shift_vec(i,2)+1) = kP(shift_vec(i,1),shift_vec(i,2));
				DOm(shift_vec(i,1),shift_vec(i,2)+1) = DOm(shift_vec(i,1),shift_vec(i,2));
				DKm(shift_vec(i,1),shift_vec(i,2)+1) = DKm(shift_vec(i,1),shift_vec(i,2));
				DSm(shift_vec(i,1),shift_vec(i,2)+1) = DSm(shift_vec(i,1),shift_vec(i,2));
				DPm(shift_vec(i,1),shift_vec(i,2)+1) = DPm(shift_vec(i,1),shift_vec(i,2));
			endfor

			Grid(pos(1),pos(2)+1) = size(state,1)+1;
			kO(pos(1),pos(2)+1) = kO_tissue;
			kS(pos(1),pos(2)+1) = kS_tissue;
			kP(pos(1),pos(2)+1) = kP_tissue;
			DOm(pos(1),pos(2)+1) = DOx_tissue;
			DKm(pos(1),pos(2)+1) = DK_tissue;
			DSm(pos(1),pos(2)+1) = DS_tissue;
			DPm(pos(1),pos(2)+1) = DP_tissue;
			cycle_duration = 1; % round(interp1([0.150 0.0375 0.015],[2.8000-0.6 6.6000-0.6 400.0000-0.6]*24*60,O(find(Grid==c_idx)))+864);
			state(size(state,1)+1,:) = [0 cycle_duration];


		else

			Grid(pos(1),pos(2)+1) = size(state,1)+1;
			kO(pos(1),pos(2)+1) = kO_tissue;
			kS(pos(1),pos(2)+1) = kS_tissue;
			kP(pos(1),pos(2)+1) = kP_tissue;
			DOm(pos(1),pos(2)+1) = DOx_tissue;
			DKm(pos(1),pos(2)+1) = DK_tissue;
			DSm(pos(1),pos(2)+1) = DS_tissue;
			DPm(pos(1),pos(2)+1) = DP_tissue;
			cycle_duration = 1; % round(interp1([0.150 0.0375 0.015],[2.8000-0.6 6.6000-0.6 400.0000-0.6]*24*60,O(find(Grid==c_idx)))+864);
			state(size(state,1)+1,:) = [0 cycle_duration];


		endif

    case 6

		if(Grid(pos(1)+1,pos(2)-1)!=0)
			int_pos = [pos(1)+1,pos(2)-1];
			while(Grid(int_pos(1),int_pos(2))!=0)
				%vecteur des positions parcourues dans la direction choisies
				shift_vec = [shift_vec; int_pos];
				int_pos = [int_pos(1)+1 int_pos(2)-1];
			endwhile

			%on retourne le vecteur
			shift_vec = flip(shift_vec,1);

			for i=1:size(shift_vec,1)
				Grid(shift_vec(i,1)+1,shift_vec(i,2)-1) = Grid(shift_vec(i,1),shift_vec(i,2));
				kO(shift_vec(i,1)+1,shift_vec(i,2)-1) = kO(shift_vec(i,1),shift_vec(i,2));
				kS(shift_vec(i,1)+1,shift_vec(i,2)-1) = kS(shift_vec(i,1),shift_vec(i,2));
				kP(shift_vec(i,1)+1,shift_vec(i,2)-1) = kP(shift_vec(i,1),shift_vec(i,2));
				DOm(shift_vec(i,1)+1,shift_vec(i,2)-1) = DOm(shift_vec(i,1),shift_vec(i,2));
				DKm(shift_vec(i,1)+1,shift_vec(i,2)-1) = DKm(shift_vec(i,1),shift_vec(i,2));
				DSm(shift_vec(i,1)+1,shift_vec(i,2)-1) = DSm(shift_vec(i,1),shift_vec(i,2));
				DPm(shift_vec(i,1)+1,shift_vec(i,2)-1) = DPm(shift_vec(i,1),shift_vec(i,2));
			endfor

			Grid(pos(1)+1,pos(2)-1) = size(state,1)+1;
			kO(pos(1)+1,pos(2)-1) = kO_tissue;
			kS(pos(1)+1,pos(2)-1) = kS_tissue;
			kP(pos(1)+1,pos(2)-1) = kP_tissue;
			DOm(pos(1)+1,pos(2)-1) = DOx_tissue;
			DKm(pos(1)+1,pos(2)-1) = DK_tissue;
			DSm(pos(1)+1,pos(2)-1) = DS_tissue;
			DPm(pos(1)+1,pos(2)-1) = DP_tissue;
			cycle_duration = 1; % round(interp1([0.150 0.0375 0.015],[2.8000-0.6 6.6000-0.6 400.0000-0.6]*24*60,O(find(Grid==c_idx)))+864);
			state(size(state,1)+1,:) = [0 cycle_duration];


		else

			Grid(pos(1)+1,pos(2)-1) = size(state,1)+1;
			kO(pos(1)+1,pos(2)-1) = kO_tissue;
			kS(pos(1)+1,pos(2)-1) = kS_tissue;
			kP(pos(1)+1,pos(2)-1) = kP_tissue;
			DOm(pos(1)+1,pos(2)-1) = DOx_tissue;
			DKm(pos(1)+1,pos(2)-1) = DK_tissue;
			DSm(pos(1)+1,pos(2)-1) = DS_tissue;
			DPm(pos(1)+1,pos(2)-1) = DP_tissue;
			cycle_duration = 1; % round(interp1([0.150 0.0375 0.015],[2.8000-0.6 6.6000-0.6 400.0000-0.6]*24*60,O(find(Grid==c_idx)))+864);
			state(size(state,1)+1,:) = [0 cycle_duration];


		endif

    case 7

		if(Grid(pos(1)+1,pos(2))!=0)
			int_pos = [pos(1)+1,pos(2)];
			while(Grid(int_pos(1),int_pos(2))!=0)
				%vecteur des positions parcourues dans la direction choisies
				shift_vec = [shift_vec; int_pos];
				int_pos = [int_pos(1)+1 int_pos(2)];
			endwhile

			%on retourne le vecteur
			shift_vec = flip(shift_vec,1);

			for i=1:size(shift_vec,1)
				Grid(shift_vec(i,1)+1,shift_vec(i,2)) = Grid(shift_vec(i,1),shift_vec(i,2));
				kO(shift_vec(i,1)+1,shift_vec(i,2)) = kO(shift_vec(i,1),shift_vec(i,2));
				kS(shift_vec(i,1)+1,shift_vec(i,2)) = kS(shift_vec(i,1),shift_vec(i,2));
				kP(shift_vec(i,1)+1,shift_vec(i,2)) = kP(shift_vec(i,1),shift_vec(i,2));
				DOm(shift_vec(i,1)+1,shift_vec(i,2)) = DOm(shift_vec(i,1),shift_vec(i,2));
				DKm(shift_vec(i,1)+1,shift_vec(i,2)) = DKm(shift_vec(i,1),shift_vec(i,2));
				DSm(shift_vec(i,1)+1,shift_vec(i,2)) = DSm(shift_vec(i,1),shift_vec(i,2));
				DPm(shift_vec(i,1)+1,shift_vec(i,2)) = DPm(shift_vec(i,1),shift_vec(i,2));
			endfor

			Grid(pos(1)+1,pos(2)) = size(state,1)+1;
			kO(pos(1)+1,pos(2)) = kO_tissue;
			kS(pos(1)+1,pos(2)) = kS_tissue;
			kP(pos(1)+1,pos(2)) = kP_tissue;
			DOm(pos(1)+1,pos(2)) = DOx_tissue;
			DKm(pos(1)+1,pos(2)) = DK_tissue;
			DSm(pos(1)+1,pos(2)) = DS_tissue;
			DPm(pos(1)+1,pos(2)) = DP_tissue;
			cycle_duration = 1; % round(interp1([0.150 0.0375 0.015],[2.8000-0.6 6.6000-0.6 400.0000-0.6]*24*60,O(find(Grid==c_idx)))+864);
			state(size(state,1)+1,:) = [0 cycle_duration];

		else

			Grid(pos(1)+1,pos(2)) = size(state,1)+1;
			kO(pos(1)+1,pos(2)) = kO_tissue;
			kS(pos(1)+1,pos(2)) = kS_tissue;
			kP(pos(1)+1,pos(2)) = kP_tissue;
			DOm(pos(1)+1,pos(2)) = DOx_tissue;
			DKm(pos(1)+1,pos(2)) = DK_tissue;
			DSm(pos(1)+1,pos(2)) = DS_tissue;
			DPm(pos(1)+1,pos(2)) = DP_tissue;
			cycle_duration = 1; % round(interp1([0.150 0.0375 0.015],[2.8000-0.6 6.6000-0.6 400.0000-0.6]*24*60,O(find(Grid==c_idx)))+864);
			state(size(state,1)+1,:) = [0 cycle_duration];

		endif

    case 8

		if(Grid(pos(1)+1,pos(2)+1)!=0)
			int_pos = [pos(1)+1,pos(2)+1];
			while(Grid(int_pos(1),int_pos(2))!=0)
				%vecteur des positions parcourues dans la direction choisies
				shift_vec = [shift_vec; int_pos];
				int_pos = [int_pos(1)+1 int_pos(2)+1];
			endwhile

			%on retourne le vecteur
			shift_vec = flip(shift_vec,1);

			for i=1:size(shift_vec,1)
				Grid(shift_vec(i,1)+1,shift_vec(i,2)+1) = Grid(shift_vec(i,1),shift_vec(i,2));
				kO(shift_vec(i,1)+1,shift_vec(i,2)+1) = kO(shift_vec(i,1),shift_vec(i,2));
				kS(shift_vec(i,1)+1,shift_vec(i,2)+1) = kS(shift_vec(i,1),shift_vec(i,2));
				kP(shift_vec(i,1)+1,shift_vec(i,2)+1) = kP(shift_vec(i,1),shift_vec(i,2));
				DOm(shift_vec(i,1)+1,shift_vec(i,2)+1) = DOm(shift_vec(i,1),shift_vec(i,2));
				DKm(shift_vec(i,1)+1,shift_vec(i,2)+1) = DKm(shift_vec(i,1),shift_vec(i,2));
				DSm(shift_vec(i,1)+1,shift_vec(i,2)+1) = DSm(shift_vec(i,1),shift_vec(i,2));
				DPm(shift_vec(i,1)+1,shift_vec(i,2)+1) = DPm(shift_vec(i,1),shift_vec(i,2));
			endfor

			Grid(pos(1)+1,pos(2)+1) = size(state,1)+1;
			kO(pos(1)+1,pos(2)+1) = kO_tissue;
			kS(pos(1)+1,pos(2)+1) = kS_tissue;
			kP(pos(1)+1,pos(2)+1) = kP_tissue;
			DOm(pos(1)+1,pos(2)+1) = DOx_tissue;
			DKm(pos(1)+1,pos(2)+1) = DK_tissue;
			DSm(pos(1)+1,pos(2)+1) = DS_tissue;
			DPm(pos(1)+1,pos(2)+1) = DP_tissue;
			cycle_duration = 1; % round(interp1([0.150 0.0375 0.015],[2.8000-0.6 6.6000-0.6 400.0000-0.6]*24*60,O(find(Grid==c_idx)))+864);
			state(size(state,1)+1,:) = [0 cycle_duration];

		else

			Grid(pos(1)+1,pos(2)+1) = size(state,1)+1;
			kO(pos(1)+1,pos(2)+1) = kO_tissue;
			kS(pos(1)+1,pos(2)+1) = kS_tissue;
			kP(pos(1)+1,pos(2)+1) = kP_tissue;
			DOm(pos(1)+1,pos(2)+1) = DOx_tissue;
			DKm(pos(1)+1,pos(2)+1) = DK_tissue;
			DSm(pos(1)+1,pos(2)+1) = DS_tissue;
			DPm(pos(1)+1,pos(2)+1) = DP_tissue;
			cycle_duration = 1; % round(interp1([0.150 0.0375 0.015],[2.8000-0.6 6.6000-0.6 400.0000-0.6]*24*60,O(find(Grid==c_idx)))+864);
			state(size(state,1)+1,:) = [0 cycle_duration];

		endif

endswitch
return
'called'
endfunction
