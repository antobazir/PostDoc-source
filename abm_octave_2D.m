sz = 10;
Grid = zeros(sz,sz);

cr = 7.5; % cell radius
ncy = 3;
c_idx = 1; %cell index
n_cell = 1;
%moore neighboorhood

%initialisation
Grid(sz/2,sz/2)=1;

while(c_idx<6)
  idx = find(Grid!=0)
  for i = 1:length(idx)
   idx(i);
   pos(2) = floor(idx(i)/sz)+1;
   pos(1) = idx(i)-(pos(2)-1)*10;
   pos
    Grid = divide2D(Grid,pos,c_idx+1,sz);
    Grid
    c_idx = c_idx+1;
  endfor
  disp("end of loop")
endwhile

