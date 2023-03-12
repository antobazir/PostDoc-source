sz = 100; %size in cells
Grid = zeros(size,size,size);
cr = 5; % cell radius
ncy = 3;
c_idx = 1; %cell index
n_cell = 1;
%moore neighboorhood

%initialisation
Grid(size/2,size/2,size/2)=1;

%grid position correspondance
%(100*100)*(z-1)+100*(y-1)+x

%cell cycle-division

    %if division occurs cell index is raised and position is retrieved
for i=1:ncy
  for j=1:c_idx
      j
      prt_pos(3) = floor(find(Grid==j)/(100*100))+1;
      prt_pos(2) = floor((find(Grid==j)-(prt_pos(3)-1)*100*100)/100)+1;
      prt_pos(1) = (find(Grid==j)-(prt_pos(3)-1)*100*100-(prt_pos(2)-1)*100);
      prt_pos
      c_idx = c_idx+1
      plr = round(6*rand()); %choose polarisation of dividinig cells
      plr
      Grid = divide(Grid,prt_pos,plr,c_idx,sz);
      n_cell = n_cell+1;
  endfor
endfor

