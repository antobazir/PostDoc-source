%script complet avec la migration, la division et la diffusion
clear all;
close all;
pkg load image

sz = 100;
cell_size = 15;
dx = 15;
dt = 1/1000;
Grid = zeros(sz,sz);

cr = 7.5; % cell radius
ncy = 3;
c_idx = 1; %cell index
n_cell = 1;
%moore neighboorhood

row = ((1:sz).*ones(sz,1))';
col = (1:sz).*ones(sz,1);

%initialisation de la partie cellulaire.
Grid(round(sz/2),round(sz/2))=1;
lG = round(sz/2);
cG = round(sz/2);
parent(1) = 1; %la première cellul n'a pas de parent

G = zeros(sz,sz);
D = zeros(sz,sz);
GD = zeros(sz,sz);
T = zeros(sz,sz);
O = zeros(sz,sz);

%initialisation de la diffusion
G(:,:) =5;
O(:,:) =0.15;
D(find(Grid!=0))= 0.2;
T(find(Grid!=0))= 20;
GD(find(Grid!=0))= 0.1;
Gt_tot = [];
Ot_tot = [];


conf = [sz 60 10 10 0.02 0.5/10 1/100 0.1 15 1/1000];

%initialisation des figures
fC = figure;
aC = axes(fC);
fG = figure;
aG = axes(fG);
fO = figure;
aO = axes(fO);

%Il y a envrion 50 µL de volume et si on a 10 000 cellules par µL ça 500 000 cellules
% La puce peut normalement contenir environ 30 000 000 de cellues. Là on en met moins d'un million


while(c_idx<2048)
   idx = find(Grid!=0);
   discrepancy=length(1:c_idx)-length(idx)
   goal  = 1:c_idx;
   truth = sort(Grid(idx))';
   %imagesc(Grid!=0)
   %waitforbuttonpress

    % division loop
	idx = find(Grid!=0);
	for i = 1:length(idx)
		idx(i)
		pos(2) = col(idx(i));
		pos(1) = row(idx(i));
		pos;
		[Grid,G,O,D,GD,T] = divide2D_full(Grid,pos,c_idx+1,sz,G,O,D,GD,T);%finir modif
		Grid;
		parent(c_idx+1) = Grid(idx(i)); %nécessaire pour mettre à jour les concentrations...
##		D(find(Grid==c_idx+1))= D(find(Grid==parent(c_idx+1)));
##		T(find(Grid==c_idx+1))= T(find(Grid==parent(c_idx+1)));
##		GD(find(Grid==c_idx+1))= GD(find(Grid==parent(c_idx+1)));
		c_idx = c_idx+1;
		isokay1  = find(((Grid!=0)==(D!=0))==0)
	endfor
	disp("end of loop")
	%imagesc(Grid!=0)
	%waitforbuttonpress

	%migration and diffusion loop
	diff_stable=0;
	grid_stable = 0;
	prev_Grid =  Grid;
	for j = 1:24
		j

		%migration reshapes the agregate
		prev_Grid = Grid;
		if(grid_stable==0)
			[Grid, G,O,D,GD,T] = migrate2D_sphere_ctr(Grid,lG,cG,G,O,D,GD,T);
			%[Grid, G,O,D,GD,T] = migrate2D_chip_full(Grid,lG,cG,G,O,D,GD,T);
			isokay2  = find(((Grid!=0)==(D!=0))==0)
			if(Grid==prev_Grid)
				grid_stable=1;%skip migration
				disp('grid stable')
			endif
		endif

		%diffusion calculation will be ran every hour
		if(diff_stable==0)
			[G,O,D,GD,T,Gt,Ot,Dt,GDt,Tt] = diffusion_abm(Grid,G,O,D,GD,T,conf);
			disp("diffusion ran")
			Gt_tot = [Gt_tot; Gt];
			Ot_tot = [Ot_tot; Ot];
			if(isempty(find(Gt!=Gt(1)))&&isempty(find(Ot!=Ot(1))))
				diff_stable =1; %skip diffusion
				disp('diff stable')
			endif
		endif


	endfor

	imagesc(aC,Grid!=0)
	imagesc(aG,G)
	imagesc(aO,O)
	colorbar(aG)
	colorbar(aO)

	waitforbuttonpress



endwhile
imagesc(aC,Grid!=0)
imagesc(aG,G)
colorbar(aG)

