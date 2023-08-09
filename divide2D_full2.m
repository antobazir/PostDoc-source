function [Grid,kO,kG,DG,sycle] = divide2D_full2(Grid,pos,c_idx,sz,G,O,sycle,kO,kG,kO_tissue,kG_tissue,DG,DG_tissue)
 %on autorise la diffusion sur les 8 voisins et plus seulement sur 4
%plr = randi(1:4);
%pos

%grille de zéro et de 1
Grid_bool = Grid!=0;
shift_vec =[];

ngh_vec(1:3) = Grid_bool(pos(1)-1,pos(2)-1:pos(2)+1);
ngh_vec(6:8) = Grid_bool(pos(1)+1,pos(2)-1:pos(2)+1);
ngh_vec(4:5) = [Grid_bool(pos(1),pos(2)-1) Grid_bool(pos(1),pos(2)+1)];

c_idx
opn_ngh = find(ngh_vec==0)
if(isempty(opn_ngh)==0)
  plr = opn_ngh(randi(length(opn_ngh)));
else
  plr = randi(8);
endif


%division and switching !

plr
switch(plr)
	case 1
		if(Grid(pos(1)-1,pos(2)-1)!=0)
			int_pos = [pos(1)-1,pos(2)-1];
			while(Grid(int_pos(1),int_pos(2))!=0)
				%vecteur des positions parcourues dans la direction choisies
				shift_vec = [shift_vec; int_pos];
				int_pos = [int_pos(1)-1 int_pos(2)-1];
			endwhile

      %on retourne le vecteur
			shift_vec = flip(shift_vec,1);

			for i=1:size(shift_vec,1)
				Grid(shift_vec(i,1)-1,shift_vec(i,2)-1) = Grid(shift_vec(i,1),shift_vec(i,2));
				kO(shift_vec(i,1)-1,shift_vec(i,2)-1) = kO_tissue;
				kG(shift_vec(i,1)-1,shift_vec(i,2)-1) = kG_tissue;
				DG(shift_vec(i,1)-1,shift_vec(i,2)-1) = DG_tissue;
			endfor

			Grid(pos(1)-1,pos(2)-1) = size(sycle,1)+1;
			kO(pos(1)-1,pos(2)-1) = kO_tissue;
			kG(pos(1)-1,pos(2)-1) = kG_tissue;
			DG(pos(1)-1,pos(2)-1) = DG_tissue;
			cycle_duration = 4032; % round(interp1([0.150 0.0375 0.015],[2.8000-0.6 6.6000-0.6 400.0000-0.6]*24*60,O(find(Grid==c_idx)))+864);
			sycle(size(sycle,1)+1,:) = [0 cycle_duration];

		else

			Grid(pos(1)-1,pos(2)-1) = size(sycle,1)+1;
			kO(pos(1)-1,pos(2)-1) = kO_tissue;
			kG(pos(1)-1,pos(2)-1) = kG_tissue;
			DG(pos(1)-1,pos(2)-1) = DG_tissue;
			cycle_duration = 4032; % round(interp1([0.150 0.0375 0.015],[2.8000-0.6 6.6000-0.6 400.0000-0.6]*24*60,O(find(Grid==c_idx)))+864);
			sycle(size(sycle,1)+1,:) = [0 cycle_duration];

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
				kO(shift_vec(i,1)-1,shift_vec(i,2)) = kO_tissue;
				kG(shift_vec(i,1)-1,shift_vec(i,2)) = kG_tissue;
				DG(shift_vec(i,1)-1,shift_vec(i,2)) = DG_tissue;
			endfor

			Grid(pos(1)-1,pos(2)) = size(sycle,1)+1;
			kO(pos(1)-1,pos(2)) = kO_tissue;
			kG(pos(1)-1,pos(2)) = kG_tissue;
			DG(pos(1)-1,pos(2)) = DG_tissue;
			cycle_duration = 4032; % round(interp1([0.150 0.0375 0.015],[2.8000-0.6 6.6000-0.6 400.0000-0.6]*24*60,O(find(Grid==c_idx)))+864);
			sycle(size(sycle,1)+1,:) = [0 cycle_duration];

		else

			Grid(pos(1)-1,pos(2)) = size(sycle,1)+1;
			kO(pos(1)-1,pos(2)) = kO_tissue;
			kG(pos(1)-1,pos(2)) = kG_tissue;
			DG(pos(1)-1,pos(2)) = DG_tissue;
			cycle_duration = 4032; % round(interp1([0.150 0.0375 0.015],[2.8000-0.6 6.6000-0.6 400.0000-0.6]*24*60,O(find(Grid==c_idx)))+864);
			sycle(size(sycle,1)+1,:) = [0 cycle_duration];

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
				kO(shift_vec(i,1)-1,shift_vec(i,2)+1) = kO_tissue;
				kG(shift_vec(i,1)-1,shift_vec(i,2)+1) = kG_tissue;
				DG(shift_vec(i,1)-1,shift_vec(i,2)+1) = DG_tissue;
			endfor

			Grid(pos(1)-1,pos(2)+1) = size(sycle,1)+1;
			kO(pos(1)-1,pos(2)+1) = kO_tissue;
			kG(pos(1)-1,pos(2)+1) = kG_tissue;
			DG(pos(1)-1,pos(2)+1) = DG_tissue;
			cycle_duration = 4032; % round(interp1([0.150 0.0375 0.015],[2.8000-0.6 6.6000-0.6 400.0000-0.6]*24*60,O(find(Grid==c_idx)))+864);
			sycle(size(sycle,1)+1,:) = [0 cycle_duration];

		else

			Grid(pos(1)-1,pos(2)+1) = size(sycle,1)+1;
			kO(pos(1)-1,pos(2)+1) = kO_tissue;
			kG(pos(1)-1,pos(2)+1) = kG_tissue;
			DG(pos(1)-1,pos(2)+1) = DG_tissue;
			cycle_duration = 4032; % round(interp1([0.150 0.0375 0.015],[2.8000-0.6 6.6000-0.6 400.0000-0.6]*24*60,O(find(Grid==c_idx)))+864);
			sycle(size(sycle,1)+1,:) = [0 cycle_duration];


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
				kO(shift_vec(i,1),shift_vec(i,2)-1) = kO_tissue;
				kG(shift_vec(i,1),shift_vec(i,2)-1) = kG_tissue;
				DG(shift_vec(i,1),shift_vec(i,2)-1) = DG_tissue;
			endfor

			Grid(pos(1),pos(2)-1) = size(sycle,1)+1;
			kO(pos(1),pos(2)-1) = kO_tissue;
			kG(pos(1),pos(2)-1) = kG_tissue;
			DG(pos(1),pos(2)-1) = DG_tissue;
			cycle_duration = 4032; % round(interp1([0.150 0.0375 0.015],[2.8000-0.6 6.6000-0.6 400.0000-0.6]*24*60,O(find(Grid==c_idx)))+864);
			sycle(size(sycle,1)+1,:) = [0 cycle_duration];


		else

			Grid(pos(1),pos(2)-1) = size(sycle,1)+1;
			kO(pos(1),pos(2)-1) = kO_tissue;
			kG(pos(1),pos(2)-1) = kG_tissue;
			DG(pos(1),pos(2)-1) = DG_tissue;
			cycle_duration = 4032; % round(interp1([0.150 0.0375 0.015],[2.8000-0.6 6.6000-0.6 400.0000-0.6]*24*60,O(find(Grid==c_idx)))+864);
			sycle(size(sycle,1)+1,:) = [0 cycle_duration];


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
				kO(shift_vec(i,1),shift_vec(i,2)+1) = kO_tissue;
				kG(shift_vec(i,1),shift_vec(i,2)+1) = kG_tissue;
				DG(shift_vec(i,1),shift_vec(i,2)+1) = DG_tissue;
			endfor

			Grid(pos(1),pos(2)+1) = size(sycle,1)+1;
			kO(pos(1),pos(2)+1) = kO_tissue;
			kG(pos(1),pos(2)+1) = kG_tissue;
			DG(pos(1),pos(2)+1) = DG_tissue;
			cycle_duration = 4032; % round(interp1([0.150 0.0375 0.015],[2.8000-0.6 6.6000-0.6 400.0000-0.6]*24*60,O(find(Grid==c_idx)))+864);
			sycle(size(sycle,1)+1,:) = [0 cycle_duration];


		else

			Grid(pos(1),pos(2)+1) = size(sycle,1)+1;
			kO(pos(1),pos(2)+1) = kO_tissue;
			kG(pos(1),pos(2)+1) = kG_tissue;
			DG(pos(1),pos(2)+1) = DG_tissue;
			cycle_duration = 4032; % round(interp1([0.150 0.0375 0.015],[2.8000-0.6 6.6000-0.6 400.0000-0.6]*24*60,O(find(Grid==c_idx)))+864);
			sycle(size(sycle,1)+1,:) = [0 cycle_duration];


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
				kO(shift_vec(i,1)+1,shift_vec(i,2)-1) = kO_tissue;
				kG(shift_vec(i,1)+1,shift_vec(i,2)-1) = kG_tissue;
				DG(shift_vec(i,1)+1,shift_vec(i,2)-1) = DG_tissue;
			endfor

			Grid(pos(1)+1,pos(2)-1) = size(sycle,1)+1;
			kO(pos(1)+1,pos(2)-1) = kO_tissue;
			kG(pos(1)+1,pos(2)-1) = kG_tissue;
			DG(pos(1)+1,pos(2)-1) = DG_tissue;
			cycle_duration = 4032; % round(interp1([0.150 0.0375 0.015],[2.8000-0.6 6.6000-0.6 400.0000-0.6]*24*60,O(find(Grid==c_idx)))+864);
			sycle(size(sycle,1)+1,:) = [0 cycle_duration];


		else

			Grid(pos(1)+1,pos(2)-1) = size(sycle,1)+1;
			kO(pos(1)+1,pos(2)-1) = kO_tissue;
			kG(pos(1)+1,pos(2)-1) = kG_tissue;
			DG(pos(1)+1,pos(2)-1) = DG_tissue;
			cycle_duration = 4032; % round(interp1([0.150 0.0375 0.015],[2.8000-0.6 6.6000-0.6 400.0000-0.6]*24*60,O(find(Grid==c_idx)))+864);
			sycle(size(sycle,1)+1,:) = [0 cycle_duration];


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
				kO(shift_vec(i,1)+1,shift_vec(i,2)) = kO_tissue;
				kG(shift_vec(i,1)+1,shift_vec(i,2)) = kG_tissue;
				DG(shift_vec(i,1)+1,shift_vec(i,2)) = DG_tissue;
			endfor

			Grid(pos(1)+1,pos(2)) = size(sycle,1)+1;
			kO(pos(1)+1,pos(2)) = kO_tissue;
			kG(pos(1)+1,pos(2)) = kG_tissue;
			DG(pos(1)+1,pos(2)) = DG_tissue;
			cycle_duration = 4032; % round(interp1([0.150 0.0375 0.015],[2.8000-0.6 6.6000-0.6 400.0000-0.6]*24*60,O(find(Grid==c_idx)))+864);
			sycle(size(sycle,1)+1,:) = [0 cycle_duration];

		else

			Grid(pos(1)+1,pos(2)) = size(sycle,1)+1;
			kO(pos(1)+1,pos(2)) = kO_tissue;
			kG(pos(1)+1,pos(2)) = kG_tissue;
			DG(pos(1)+1,pos(2)) = DG_tissue;
			cycle_duration = 4032; % round(interp1([0.150 0.0375 0.015],[2.8000-0.6 6.6000-0.6 400.0000-0.6]*24*60,O(find(Grid==c_idx)))+864);
			sycle(size(sycle,1)+1,:) = [0 cycle_duration];

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
				kO(shift_vec(i,1)+1,shift_vec(i,2)+1) = kO_tissue;
				kG(shift_vec(i,1)+1,shift_vec(i,2)+1) = kG_tissue;
				DG(shift_vec(i,1)+1,shift_vec(i,2)+1) = DG_tissue;
			endfor

			Grid(pos(1)+1,pos(2)+1) = size(sycle,1)+1;
			kO(pos(1)+1,pos(2)+1) = kO_tissue;
			kG(pos(1)+1,pos(2)+1) = kG_tissue;
			DG(pos(1)+1,pos(2)+1) = DG_tissue;
			cycle_duration = 4032; % round(interp1([0.150 0.0375 0.015],[2.8000-0.6 6.6000-0.6 400.0000-0.6]*24*60,O(find(Grid==c_idx)))+864);
			sycle(size(sycle,1)+1,:) = [0 cycle_duration];

		else

			Grid(pos(1)+1,pos(2)+1) = size(sycle,1)+1;
			kO(pos(1)+1,pos(2)+1) = kO_tissue;
			kG(pos(1)+1,pos(2)+1) = kG_tissue;
			DG(pos(1)+1,pos(2)+1) = DG_tissue;
			cycle_duration = 4032; % round(interp1([0.150 0.0375 0.015],[2.8000-0.6 6.6000-0.6 400.0000-0.6]*24*60,O(find(Grid==c_idx)))+864);
			sycle(size(sycle,1)+1,:) = [0 cycle_duration];

		endif

endswitch
return;
'called'
endfunction
