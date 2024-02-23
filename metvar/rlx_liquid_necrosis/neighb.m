function ngh_vec = neighb(Grid,pos)

       ngh_vec(1) = Grid(pos(1)-1,pos(2)-1);
       ngh_vec(2) = Grid(pos(1),pos(2)-1);
       ngh_vec(3) = Grid(pos(1)+1,pos(2)-1);
       ngh_vec(4) = Grid(pos(1)-1,pos(2));
       ngh_vec(5) = Grid(pos(1)+1,pos(2));
       ngh_vec(6) = Grid(pos(1)-1,pos(2)+1);
       ngh_vec(7) = Grid(pos(1),pos(2)+1);
       ngh_vec(8) = Grid(pos(1)+1,pos(2)+1);


endfunction
