sz = 20;
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

while(c_idx<sz)
   idx = find(Grid!=0);
   discrepancy=length(1:c_idx)-length(idx)
   goal  = 1:c_idx
   truth = sort(Grid(idx))
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


