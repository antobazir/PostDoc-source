sz = 10;
Grid = zeros(sz,sz);

Grid(4*sz+4)=2;
Grid(4*sz+5)=1;
Grid(4*sz+6)=1;
Grid(5*sz+6)=1;
Grid(3*sz+6)=1;


pos(1) = round(sz/2)-1;
pos(2) = round(sz/2);


ng(1,:) = [pos(1)-1 pos(2)-1];
ng(2,:) = [pos(1) pos(2)-1];
ng(3,:) = [pos(1)+1 pos(2)-1];
ng(4,:) = [pos(1)-1 pos(2)];
ng(5,:) = [pos(1)+1 pos(2)];
ng(6,:) = [pos(1)-1 pos(2)+1];
ng(7,:) = [pos(1) pos(2)+1];
ng(8,:) = [pos(1)+1 pos(2)+1];

for i=1:8
    Grid(ng(i,1),ng(i,2));
end

ngh_vec = neighb(Grid,pos)
[v_n, id_n] = find(ngh_vec==0)

for j =1:length(id_n)
    find(neighb(Grid,ng(j,:))!=0)
    %nb_ngh(j) = length(neighb(Grid,ng(j,:)))
endfor
