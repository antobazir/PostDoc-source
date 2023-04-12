function Grid = migrate2D_sphere(Grid,pos,c_idx,sz)

        ng(1,:) = [pos(1)-1 pos(2)-1];
        ng(2,:) = [pos(1) pos(2)-1];
        ng(3,:) = [pos(1)+1 pos(2)-1];
        ng(4,:) = [pos(1)-1 pos(2)];
        ng(5,:) = [pos(1)+1 pos(2)];
        ng(6,:) = [pos(1)-1 pos(2)+1];
        ng(7,:) = [pos(1) pos(2)+1];
        ng(8,:) = [pos(1)+1 pos(2)+1];



        ngh_vec = neighb(Grid,pos)
        if(length(find(ngh_vec!=0))<4)%less than 4 neighbor means you're at a tip

        %Check the eight neighboring position to see if you can raise the number of neighbor
        if
        ngh2_vec(1) = length(find(neighb(Grid,[pos(1)-1 pos(2)-1])!=0))
        ngh2_vec(2) = length(find(neighb(Grid,[pos(1) pos(2)-1])!=0))
        ngh2_vec(3) = length(find(neighb(Grid,[pos(1)+1 pos(2)-1])!=0))
        ngh2_vec(4) = length(find(neighb(Grid,[pos(1)-1 pos(2)])!=0))
        ngh2_vec(5) = length(find(neighb(Grid,[pos(1)+1 pos(2)])!=0))
        ngh2_vec(6) = length(find(neighb(Grid,[pos(1)-1 pos(2)+1])!=0))
        ngh2_vec(7) = length(find(neighb(Grid,[pos(1) pos(2)+1])!=0))
        ngh2_vec(8) = length(find(neighb(Grid,[pos(1)+1 pos(2)+1])!=0))

        % cas où on prend un seul voisin (simple
        [v,i] = find(ngh2_vec==max(ngh2_vec))
        if(length(i)==1)
           switch(v)
            case 1
              Grid(pos(1)-1,pos(2)-1) = c_idx;
              Grid(pos(1),pos(2)) = 0;
            case 2
              Grid(pos(1),pos(2)-1) = c_idx;
              Grid(pos(1),pos(2)) = 0;
            case 3
              Grid(pos(1)+1,pos(2)-1) = c_idx;
              Grid(pos(1),pos(2)) = 0;
            case 4
              Grid(pos(1)-1,pos(2)) = c_idx;
              Grid(pos(1),pos(2)) = 0;
            case 5
              Grid(pos(1)+1,pos(2)) = c_idx;
              Grid(pos(1),pos(2)) = 0;
            case 6
              Grid(pos(1)-1,pos(2)+1) = c_idx;
              Grid(pos(1),pos(2)) = 0;
            case 7
              Grid(pos(1),pos(2)+1) = c_idx;
              Grid(pos(1),pos(2)) = 0;
            case 8
              Grid(pos(1)+1,pos(2)+1) = c_idx;
              Grid(pos(1),pos(2)) = 0;
           endswitch
           return;
        endif



endfunction
