clear all
chip_size = 10000;
sz = round(chip_size/15);
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
cycle_duration_0 = 4032;
filename = '';



%initialisation des grilles
G = zeros(round(sz/2)+1,round(sz/2)+1);
O = zeros(round(sz/2)+1,round(sz/2)+1);
kO = zeros(round(sz/2)+1,round(sz/2)+1);
kG = zeros(round(sz/2)+1,round(sz/2)+1);
Grid = zeros(round(sz/2)+1,round(sz/2)+1);
%Cycle = (round(sz/2)+1,round(sz/2)+1);
sycle = [];


%diffusion being physical it is not part of the modifiable parameters
DOx = ones(round(sz/2)+1,round(sz/2)+1);
DOx = 120000*DOx;
DOx_tissue = 120000;
DG = ones(round(sz/2)+1,round(sz/2)+1);
DG = conf(12)*DG;
DG_tissue = conf(12);
%r = round(sz/2.2)-2; %radius of the tissue circle in units
rad = round(pellet_size/15/2);

%dx = 50;
cell_size = 15
%dt = 1/300;
ntime = n_min/dt;

%giving all indexes corresponding to a center circle
[i,j,v] = find(DG!=0);
dsy_s = j-round(sz/2);
dsx_s = i-round(sz/2);
sites = find((dsx_s.^2+dsy_s.^2)<rad^2);

[r c] = ind2sub([round(sz/2)+1,round(sz/2)+1],sites);

%sélection des colonnes et lignes pair uniquement
length(r)
length(c)
r = r(find(mod(r,2)==0));
c = c(find(mod(c,2)==0));
length(r)
length(c)
##length(r)
##length(c(1:length(r)))
##c = c(1:length(r))
open_sites = sub2ind([round(sz/2)+1,round(sz/2)+1],r,c);
open_sites = unique(open_sites);
%randi(length(open_sites))

% Dans les fait on a 4500 en diamètre et 15 en épaisseur -> 0.286 µL -> 2860 cellules initialement
%open_sites;
%for m=1:min(length(open_sites),round(n_cells0/4))
for m=1:round(n_cells0/4)

	%miste à jour des données de diffusion et de la liste
	slct_st = randi(length(open_sites));
	%Grid(open_sites(slct_st))=c_idx ;
	DOx(open_sites(slct_st))= DOx_tissue;
	%DG(open_sites(slct_st))= DG_tissue;
	kO(open_sites(slct_st))= kO_tissue;
	kG(open_sites(slct_st))= kG_tissue;

		% placement de la cellule dans la grille et dans le cycle
	Grid(open_sites(slct_st)) = m;
	%Cycle(open_sites(slct_st)) = randi(cycle_duration_0);
	sycle(m,1) =  randi(cycle_duration_0);

	open_sites =  [open_sites(1:slct_st-1); open_sites(slct_st+1:length(open_sites))];


endfor

sycle(:,2) = cycle_duration_0;
%sycle(1,1) = 100000;
%imagesc(DG)
%waitforbuttonpress

%assure que la cellule centrale soit pleine
DOx(round(sz/2),round(sz/2))= DOx_tissue;
%DG(round(sz/2),round(sz/2))= DG_tissue;
kO(round(sz/2),round(sz/2))= kO_tissue;
kG(round(sz/2),round(sz/2))= kG_tissue;


DOx(round(sz/2),round(sz/2)-rad+2)= DOx_tissue;
%DG(round(sz/2),round(sz/2)-rad+2)= DG_tissue;
kO(round(sz/2),round(sz/2)-rad+2)= kO_tissue;
kG(round(sz/2),round(sz/2)-rad+2)= kG_tissue;


%Initial concentration are also physically motivated so they won't be touched.
G(:,:) =20;
O(:,:) =0.15;

if(isfile(filename))

endif

tic()
for i=1:12
	[Grid,sz,G,O,sycle,kO,kG,kO_tissue,kG_tissue,DG] = update_model(Grid,sz,G,O,sycle,kO,kG,kO_tissue,kG_tissue,DG,DG_tissue,ntime,conf)
	save(['200723_' num2str(2*i) 'hr']);
endfor
toc()


%T/D monte fort parce que D chute.
% switch quand (0.017*Tt(:,1)-kGt(:,1)) = 0.017 confirmé.
% donc essayer de voir ce qui se passe si µ est trop haut pour être refranchi et ce que signifie physique le fait que ce seuil soit franchi.
% la prod de [D] suit EXACTEMENT µ[T] jusqu'au seuil.
