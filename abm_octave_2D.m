clear all;
close all;
pkg load image

sz = 200;
Grid = zeros(sz,sz);

cr = 7.5; % cell radius
ncy = 3;
c_idx = 1; %cell index
n_cell = 1;
%moore neighboorhood

row = ((1:sz).*ones(sz,1))';
col = (1:sz).*ones(sz,1);

%initialisation
Grid(sz/2,sz/2)=1;
lG = sz/2;
cG = sz/2;

%Il y a envrion 50 µL de volume et si on a 10 000 cellules par µL ça 500 000 cellules
% La puce peut normalement contenir environ 30 000 000 de cellues. Là on en met moins d'un million

%0.5*2*2*2*2

while(c_idx<10*sz)
   idx = find(Grid!=0);
   discrepancy=length(1:c_idx)-length(idx)
   goal  = 1:c_idx;
   truth = sort(Grid(idx))';
   imagesc(Grid!=0)
   waitforbuttonpress

##   %migration
##   for j=1:24
##     idx = find(Grid!=0);
##     j;
##     [r0 c0] = ind2sub([sz, sz],idx);
##     %lG = round((sum(r0))/length(r0))
##     %cG = round((sum(c0))/length(c0))
##
##     % on bouge que celle du bord
##     perim = im2double(bwperim(Grid));
##     idx_p = find(perim!=0);
##
##    for i = 1:length(idx_p)
##        %bwperim(Grid)
##        %waitforbuttonpress
##        perim = im2double(bwperim(Grid));
##        idx_p = find(perim!=0);
##
##        [r c] = ind2sub([sz, sz],idx_p(i));
##        pos = [r c]
##        %Grid = migrate2D_chip(Grid,pos,c_idx,sz);
##        %hold on;
##        if(length(idx_p(i))>1)
##          Grid = migrate2D_sphere(Grid,pos,c_idx,sz,100,100);
##        endif
##        %Grid
##        %hold off;
##        %imagesc(Grid!=0)
##        %waitforbuttonpress
##    endfor
##    %imagesc(Grid!=0)
##    %waitforbuttonpress
##   endfor

	for j = 1:24
		Grid = migrate2D_sphere_ctr(Grid,lG,cG)
	endfor

	imagesc(Grid!=0)
	waitforbuttonpress

   % division loop
	idx = find(Grid!=0);
	for i = 1:length(idx)
		idx(i);
		pos(2) = col(idx(i));
		pos(1) = row(idx(i));
		pos;
		Grid = divide2D(Grid,pos,c_idx+1,sz);
		Grid;
		c_idx = c_idx+1;
	endfor
  disp("end of loop")
  imagesc(Grid!=0)
  waitforbuttonpress

endwhile

