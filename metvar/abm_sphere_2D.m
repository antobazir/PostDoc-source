clear all;
close all;
pkg load image

%sz = round(10000/15);
sz = 20;
conf= [sz 120 4.5 4 0.03 1 15 1/1500 1 7540 8000 30000];
n_min = conf(2);
kO_tissue = conf(3);
kG_tissue = conf(4);
cO =  conf(5);
cG = conf(6);
dx = conf(7);
dt = conf(8);
renew = conf(9);
n_cells0 = conf(10);
pellet_size = conf(11);
Diff_glu = conf(12);

G = zeros(sz,sz);
O = zeros(sz,sz);
kO = zeros(sz,sz);
kG = zeros(sz,sz);
Grid = zeros(sz,sz);
sycle = [1 4032];

DOx = ones(sz,sz);
DOx = 120000*DOx;
DOx_tissue = 120000;
DG = ones(sz,sz);
DG = conf(12)*DG;
DG_tissue = conf(12);

Grid(round(sz/2),round(sz/2))=1;

while(size(sycle,1)<65)
	idx = find(Grid!=0);
	for k = 1:size(sycle,1)

		[r,c] = ind2sub([sz,sz],find(Grid==k))
		pos(1) = r; pos(2) = c;

		[Grid,kO,kG,DG,sycle] = divide2D_full2(Grid,pos,k,sz,G,O,sycle,kO,kG,kO_tissue,kG_tissue,DG,DG_tissue);
		Grid
		grid_stable = 0;
		prev_Grid =  Grid;
		for j = 1:24
			j

		%migration reshapes the agregate
			prev_Grid = Grid;
			if(grid_stable==0)
				[Grid,kO,kG,DG,sycle] = migrate2D_sphere_ctr2(Grid,sz,G,O,sycle,kO,kG,kO_tissue,kG_tissue,DG,DG_tissue);
				%isokay2  = find(((Grid!=0)==(D!=0))==0)
				if(Grid==prev_Grid)
					grid_stable=1;%skip migration
					disp('grid stable')
				endif
			endif
		endfor
	endfor

	imagesc(Grid!=0)
	waitforbuttonpress

endwhile
