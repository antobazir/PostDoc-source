function [Grid,kO,kG,DG,sycle] = divide2D_cc(Grid,pos,c_idx,sz,G,O,sycle,kO,kG,kO_tissue,kG_tissue,DG,DG_tissue)
%plr = randi(1:4);
%pos
%cas full occupé ou inoccupé 1a et b
if(Grid(pos(1)+1,pos(2))==0&&Grid(pos(1)-1,pos(2))==0&&Grid(pos(1),pos(2)+1)==0&&Grid(pos(1),pos(2)-1)==0)
	disp('1a');
	plr = randi(4);
endif
if(Grid(pos(1)+1,pos(2))!=0&&Grid(pos(1)-1,pos(2))!=0&&Grid(pos(1),pos(2)+1)!=0&&Grid(pos(1),pos(2)-1)!=0)
	disp('1b')
	plr = randi(4);
endif

%cas avec  3 voisins sur 4 2 a b c et d
if(Grid(pos(1)+1,pos(2))==0&&Grid(pos(1)-1,pos(2))!=0&&Grid(pos(1),pos(2)+1)!=0&&Grid(pos(1),pos(2)-1)!=0)
	disp('2a');
	plr = 1;
endif

if(Grid(pos(1)+1,pos(2))!=0&&Grid(pos(1)-1,pos(2))!=0&&Grid(pos(1),pos(2)+1)==0&&Grid(pos(1),pos(2)-1)!=0)
	disp('2b');
	plr = 2;
endif

if(Grid(pos(1)+1,pos(2))!=0&&Grid(pos(1)-1,pos(2))==0&&Grid(pos(1),pos(2)+1)!=0&&Grid(pos(1),pos(2)-1)!=0)
	disp('2c');
	plr = 3;
endif

if(Grid(pos(1)+1,pos(2))!=0&&Grid(pos(1)-1,pos(2))!=0&&Grid(pos(1),pos(2)+1)!=0&&Grid(pos(1),pos(2)-1)==0)
	disp('2d');
	plr = 4;
endif

%cas avec 2 voisins sur 4 3 a b c et  d
if(Grid(pos(1)+1,pos(2))==0&&Grid(pos(1)-1,pos(2))==0&&Grid(pos(1),pos(2)+1)!=0&&Grid(pos(1),pos(2)-1)!=0)
	%disp('3a');
	rd = rand();
	if(rd<0.5)
		plr = 1;
		disp('3a-1')
	else
		plr = 3;
		disp('3a-3')
	endif
endif

if(Grid(pos(1)+1,pos(2))!=0&&Grid(pos(1)-1,pos(2))!=0&&Grid(pos(1),pos(2)+1)==0&&Grid(pos(1),pos(2)-1)==0)
	%disp('3b')
	rd = rand();
	if(rd<0.5)
		plr = 2;
		disp('3b-2')
	else
		plr = 4;
		disp('3b-4')
	endif
endif

if(Grid(pos(1)+1,pos(2))!=0&&Grid(pos(1)-1,pos(2))==0&&Grid(pos(1),pos(2)+1)!=0&&Grid(pos(1),pos(2)-1)==0)
	%disp('3c')
	rd = rand()
	if(rd<0.5)
		plr = 3;
		disp('3c-3')
	else
		plr = 4;
		disp('3c-4')
	endif
endif

if(Grid(pos(1)+1,pos(2))==0&&Grid(pos(1)-1,pos(2))!=0&&Grid(pos(1),pos(2)+1)==0&&Grid(pos(1),pos(2)-1)!=0)
	%disp('3d')
	rd = rand();
	if(rd<0.5)
		plr = 1;
		disp('3d-1')
	else
		plr = 2;
		disp('3d-2')
	endif
endif

if(Grid(pos(1)+1,pos(2))!=0&&Grid(pos(1)-1,pos(2))==0&&Grid(pos(1),pos(2)+1)==0&&Grid(pos(1),pos(2)-1)!=0)
	%disp('3e')
	rd = rand();
	if(rd<0.5)
		plr = 3;
		disp('3e-3')
	else
		plr = 2;
		disp('3e-2')
	endif
endif

if(Grid(pos(1)+1,pos(2))==0&&Grid(pos(1)-1,pos(2))!=0&&Grid(pos(1),pos(2)+1)!=0&&Grid(pos(1),pos(2)-1)==0)
	%disp('3f')
	rd = rand();
	if(rd<0.5)
		plr = 1;
		disp('3f-1')
	else
		plr = 4;
		disp('3f-4')
	endif
endif



%cas avec un voisin sur 4 4 a b c d
if(Grid(pos(1)+1,pos(2))!=0&&Grid(pos(1)-1,pos(2))==0&&Grid(pos(1),pos(2)+1)==0&&Grid(pos(1),pos(2)-1)==0)
	%disp('4a')
	rd= rand();
	if(rd<0.3)
		plr = 2;
		disp('4a-2')
	elseif(rd>=0.33&&rd<0.66)
		plr = 3;
		disp('4a-3')
	else
		plr = 4;
		disp('4a-4')
	endif
endif

if(Grid(pos(1)+1,pos(2))==0&&Grid(pos(1)-1,pos(2))!=0&&Grid(pos(1),pos(2)+1)==0&&Grid(pos(1),pos(2)-1)==0)
	%disp('4b')
	rd= rand();
	if(rd<0.3)
		plr = 1;
		disp('4b-1')
	elseif(rd>=0.33&&rd<0.66)
		plr = 2;
		disp('4b-2')
	else
		plr = 4;
		disp('4b-4')
	endif
endif

if(Grid(pos(1)+1,pos(2))==0&&Grid(pos(1)-1,pos(2))==0&&Grid(pos(1),pos(2)+1)!=0&&Grid(pos(1),pos(2)-1)==0)
	%disp('4c')
	rd = rand();
	if(rd<0.3)
		plr = 1;
		disp('4c-1')
	elseif(rd>=0.33&&rd<0.66)
		plr = 3;
		disp('4c-3')
	else
		plr = 4;
		disp('4c-4')
	endif
endif

if(Grid(pos(1)+1,pos(2))==0&&Grid(pos(1)-1,pos(2))==0&&Grid(pos(1),pos(2)+1)==0&&Grid(pos(1),pos(2)-1)!=0)
	%disp('4d')
	rd = rand();
	if(rd<0.3)
		plr = 1;
		disp('4d-1')
	elseif(rd>=0.33&&rd<0.66)
		plr = 2;
		disp('4d-2')
	else
		plr = 3;
		disp('4d-3')
	endif
endif

%division and switching !

plr;
switch(plr)
	case 1
		if(Grid(pos(1)+1,pos(2))!=0)
			[pos(1)+1 pos(2)];
			%disp('occupied');
			rim = find(Grid(pos(1)+2:sz,pos(2))==0);
			rim = rim(1);
			rim;
			pos(1)+rim-1;
			pos(1)+1;
			before_shift = Grid(:,pos(2))';
			%for i= pos(1)+2:-1:pos(1)+rim-1
			for i= pos(1)+rim:-1:pos(1)+1
				%disp('done');
				Grid(i+1,pos(2))=Grid(i,pos(2));

			endfor
			after_shift = Grid(:,pos(2))';
			Grid(pos(1)+1,pos(2)) = length(sycle)+1;
			kO(pos(1)+1,pos(2)) = kO_tissue;
			kG(pos(1)+1,pos(2)) = kG_tissue;
			DG(pos(1)+1,pos(2)) = DG_tissue;
			sycle(c_idx,1) = 0;
			cycle_duration =  round(interp1([0.150 0.0375 0.015],[2.8000-0.6 6.6000-0.6 400.0000-0.6]*24*60,O(find(Grid==c_idx)))+864);
			sycle(length(sycle)+1,:) = [0 cycle_duration];


		else
			Grid(pos(1)+1,pos(2)) = length(sycle)+1;
			kO(pos(1)+1,pos(2)) = kO_tissue;
			kG(pos(1)+1,pos(2)) = kG_tissue;
			DG(pos(1)+1,pos(2)) = DG_tissue;
			sycle(c_idx,1) = 0;
			cycle_duration =  round(interp1([0.150 0.0375 0.015],[2.8000-0.6 6.6000-0.6 400.0000-0.6]*24*60,O(find(Grid==c_idx)))+864);
			sycle(length(sycle)+1,:) = [0 cycle_duration];

		 %'1'
		endif

    case 2
        if(Grid(pos(1),pos(2)+1)!=0)
			[pos(1) pos(2)+1];
			%disp('occupied');
			rim = find(Grid(pos(1),pos(2)+2:sz)==0);
			rim = rim(1);
			pos(2)+rim-1;
			pos(2)+1;
			before_shift = Grid(pos(1),:);
			%for i= pos(2)+2:-1:pos(2)+rim-1
			for i= pos(2)+rim:-1:pos(2)+1
				% disp('done');
				Grid(pos(1),i+1)=Grid(pos(1),i);

		endfor
			after_shift = Grid(pos(1),:);
			Grid(pos(1),pos(2)+1) = length(sycle)+1;
			kO(pos(1),pos(2)+1) = kO_tissue;
			kG(pos(1),pos(2)+1) = kG_tissue;
			DG(pos(1),pos(2)+1) = DG_tissue;
			sycle(c_idx,1) = 0;
			cycle_duration =  round(interp1([0.150 0.0375 0.015],[2.8000-0.6 6.6000-0.6 400.0000-0.6]*24*60,O(find(Grid==c_idx)))+864);
			sycle(length(sycle)+1,:) = [0 cycle_duration];



		else
			Grid(pos(1),pos(2)+1) = length(sycle)+1;
			kO(pos(1),pos(2)+1) = kO_tissue;
			kG(pos(1),pos(2)+1) = kG_tissue;
			DG(pos(1),pos(2)+1) = DG_tissue;
			sycle(c_idx,1) = 0;
			cycle_duration =  round(interp1([0.150 0.0375 0.015],[2.8000-0.6 6.6000-0.6 400.0000-0.6]*24*60,O(find(Grid==c_idx)))+864);
			sycle(length(sycle)+1,:) = [0 cycle_duration];
%'2'
		endif

	case 3
		if(Grid(pos(1)-1,pos(2))!=0)
			[pos(1)-1 pos(2)];
			%disp('occupied');
			rim = find(Grid(1:pos(1)+1,pos(2))!=0);
			rim = rim(1);
			rim;
			before_shift = Grid(:,pos(2))';
			for i= rim:pos(1)-1
			  Grid(i-1,pos(2))=Grid(i,pos(2));
			endfor
			after_shift = Grid(:,pos(2))';
			Grid(pos(1)-1,pos(2)) = length(sycle)+1;
			kG(pos(1)-1,pos(2)) = kG_tissue;
			DG(pos(1)-1,pos(2)) = DG_tissue;
			kO(pos(1)-1,pos(2)) = kO_tissue;
			sycle(c_idx,1) = 0;
			cycle_duration =  round(interp1([0.150 0.0375 0.015],[2.8000-0.6 6.6000-0.6 400.0000-0.6]*24*60,O(find(Grid==c_idx)))+864);
			sycle(length(sycle)+1,:) = [0 cycle_duration];



		else
			Grid(pos(1)-1,pos(2)) = length(sycle)+1;
			kG(pos(1)-1,pos(2)) = kG_tissue;
			DG(pos(1)-1,pos(2)) = DG_tissue;
			kO(pos(1)-1,pos(2)) = kO_tissue;
			sycle(c_idx,1) = 0;
			cycle_duration =  round(interp1([0.150 0.0375 0.015],[2.8000-0.6 6.6000-0.6 400.0000-0.6]*24*60,O(find(Grid==c_idx)))+864);
			sycle(length(sycle)+1,:) = [0 cycle_duration];

			%'3'
		endif

	case 4
		if(Grid(pos(1),pos(2)-1)!=0)
			[pos(1) pos(2)-1];
			%disp('occupied');
			rim = find(Grid(pos(1),1:pos(2)-1)!=0);
			rim = rim(1);
			rim;
			before_shift = Grid(pos(1),:);
			for i= rim:pos(2)-1
				Grid(pos(1),i-1)=Grid(pos(1),i);
			endfor
				after_shift = Grid(pos(1),:);
				Grid(pos(1),pos(2)-1) = length(sycle)+1;
				kG(pos(1),pos(2)-1) = kG_tissue;
				DG(pos(1),pos(2)-1) = DG_tissue;
				kO(pos(1),pos(2)-1) = kO_tissue;
				sycle(c_idx,1) = 0;
				cycle_duration =  round(interp1([0.150 0.0375 0.015],[2.8000-0.6 6.6000-0.6 400.0000-0.6]*24*60,O(find(Grid==c_idx)))+864);
				sycle(length(sycle)+1,:) = [0 cycle_duration];

			else
				Grid(pos(1),pos(2)-1) = length(sycle)+1;
				kG(pos(1),pos(2)-1) = kG_tissue;
				DG(pos(1),pos(2)-1) = DG_tissue;
				kO(pos(1),pos(2)-1) = kO_tissue;
				sycle(c_idx,1) = 0;
				cycle_duration =  round(interp1([0.150 0.0375 0.015],[2.8000-0.6 6.6000-0.6 400.0000-0.6]*24*60,O(find(Grid==c_idx)))+864);
				sycle(length(sycle)+1,:) = [0 cycle_duration];

			endif
endswitch
return;
'called'
endfunction
