function  [Grid,G,O,D,GD,T] = divide2D_full(Grid,pos,c_idx,sz,G,O,D,GD,T)
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
				G(i+1,pos(2)) = G(i,pos(2));
				O(i+1,pos(2)) = O(i,pos(2));
				GD(i+1,pos(2)) = GD(i,pos(2));
				D(i+1,pos(2)) = D(i,pos(2));
				T(i+1,pos(2)) = T(i,pos(2));
			endfor
			after_shift = Grid(:,pos(2))';
			Grid(pos(1)+1,pos(2)) = c_idx;
			G(pos(1)+1,pos(2)) = G(pos(1),pos(2));
			O(pos(1)+1,pos(2)) = O(pos(1),pos(2));
			GD(pos(1)+1,pos(2)) = GD(pos(1),pos(2));
			D(pos(1)+1,pos(2)) = D(pos(1),pos(2));
			T(pos(1)+1,pos(2)) = T(pos(1),pos(2));
		else
			Grid(pos(1)+1,pos(2)) = c_idx;
			G(pos(1)+1,pos(2)) = G(pos(1),pos(2));
			O(pos(1)+1,pos(2)) = O(pos(1),pos(2));
			GD(pos(1)+1,pos(2)) = GD(pos(1),pos(2));
			D(pos(1)+1,pos(2)) = D(pos(1),pos(2));
			T(pos(1)+1,pos(2)) = T(pos(1),pos(2));
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
				G(pos(1),i+1)=G(pos(1),i);
				O(pos(1),i+1)=O(pos(1),i);
				GD(pos(1),i+1)=GD(pos(1),i);
				D(pos(1),i+1)=D(pos(1),i);
				T(pos(1),i+1)=T(pos(1),i);
		endfor
			after_shift = Grid(pos(1),:);
			Grid(pos(1),pos(2)+1) = c_idx;
			G(pos(1),pos(2)+1) = G(pos(1),pos(2));
			O(pos(1),pos(2)+1) = O(pos(1),pos(2));
			GD(pos(1),pos(2)+1) = GD(pos(1),pos(2));
			D(pos(1),pos(2)+1) = D(pos(1),pos(2));
			T(pos(1),pos(2)+1) = T(pos(1),pos(2));
		else
			Grid(pos(1),pos(2)+1) = c_idx;
			G(pos(1),pos(2)+1) = G(pos(1),pos(2));
			O(pos(1),pos(2)+1) = O(pos(1),pos(2));
			GD(pos(1),pos(2)+1) = GD(pos(1),pos(2));
			D(pos(1),pos(2)+1) = D(pos(1),pos(2));
			T(pos(1),pos(2)+1) = T(pos(1),pos(2));
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
			  G(i-1,pos(2))=G(i,pos(2));
			  O(i-1,pos(2))=O(i,pos(2));
			  GD(i-1,pos(2))=GD(i,pos(2));
			  D(i-1,pos(2))=D(i,pos(2));
			  T(i-1,pos(2))=T(i,pos(2));
			endfor
			after_shift = Grid(:,pos(2))';
			Grid(pos(1)-1,pos(2)) = c_idx;
			G(pos(1)-1,pos(2)) = G(pos(1),pos(2));
			O(pos(1)-1,pos(2)) = O(pos(1),pos(2));
			GD(pos(1)-1,pos(2)) = GD(pos(1),pos(2));
			D(pos(1)-1,pos(2)) = D(pos(1),pos(2));
			T(pos(1)-1,pos(2)) = T(pos(1),pos(2));
		else
			Grid(pos(1)-1,pos(2)) = c_idx;
			G(pos(1)-1,pos(2)) = G(pos(1),pos(2));
			O(pos(1)-1,pos(2)) = O(pos(1),pos(2));
			GD(pos(1)-1,pos(2)) = GD(pos(1),pos(2));
			D(pos(1)-1,pos(2)) = D(pos(1),pos(2));
			T(pos(1)-1,pos(2)) = T(pos(1),pos(2));
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
				G(pos(1),i-1)=G(pos(1),i);
				O(pos(1),i-1)=O(pos(1),i);
				GD(pos(1),i-1)=GD(pos(1),i);
				D(pos(1),i-1)=D(pos(1),i);
				T(pos(1),i-1)=T(pos(1),i);
			endfor
				after_shift = Grid(pos(1),:);
				Grid(pos(1),pos(2)-1) = c_idx;
				G(pos(1),pos(2)-1) = G(pos(1),pos(2));
				O(pos(1),pos(2)-1) = O(pos(1),pos(2));
				GD(pos(1),pos(2)-1) = GD(pos(1),pos(2));
				D(pos(1),pos(2)-1) = D(pos(1),pos(2));
				T(pos(1),pos(2)-1) = T(pos(1),pos(2));
			else
				Grid(pos(1),pos(2)-1) = c_idx;
				G(pos(1),pos(2)-1) = G(pos(1),pos(2));
				O(pos(1),pos(2)-1) = O(pos(1),pos(2));
				GD(pos(1),pos(2)-1) = GD(pos(1),pos(2));
				D(pos(1),pos(2)-1) = D(pos(1),pos(2));
				T(pos(1),pos(2)-1) = T(pos(1),pos(2));
				%'4'
			endif
endswitch
return;
'called'
endfunction
