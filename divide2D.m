
function Grid = divide2D(Grid,pos,c_idx,sz)
  plr = floor(4*rand())+1;
  plr;
    switch(plr)
      case 1
        if(Grid(pos(1)+1,pos(2))!=0)
          [pos(1)+1 pos(2)];
          %disp('occupied');
          rim = find(Grid(pos(1)+2:sz,pos(2))==0);
          rim = rim(1);
          rim;
          pos(1)+rim-1;
          pos(1)+1;
          plr;
          pos;
          rim;
          before_shift = Grid(:,pos(2))';
          %for i= pos(1)+2:-1:pos(1)+rim-1
          for i= pos(1)+rim:-1:pos(1)+1
              %disp('done');
              Grid(i+1,pos(2))=Grid(i,pos(2));
          endfor
          after_shift = Grid(:,pos(2))';
          Grid(pos(1)+1,pos(2)) = c_idx;
          after_div = Grid(:,pos(2))';
       else
         Grid(pos(1)+1,pos(2)) = c_idx;
         %'1'
        endif

      case 2
          if(Grid(pos(1),pos(2)+1)!=0)
            [pos(1) pos(2)+1];
            %disp('occupied');
            rim = find(Grid(pos(1),pos(2)+2:sz)==0);
            rim = rim(1);
             pos(2)+rim-1;
            pos(2)+1;
            plr;
            pos;
            rim;
            before_shift = Grid(pos(1),:);
            %for i= pos(2)+2:-1:pos(2)+rim-1
            for i= pos(2)+rim:-1:pos(2)+1
             % disp('done');
              Grid(pos(1),i+1)=Grid(pos(1),i);
            endfor
            after_shift = Grid(pos(1),:);
            Grid(pos(1),pos(2)+1) = c_idx;
            after_div = Grid(pos(1),:);
       else
         Grid(pos(1),pos(2)+1) = c_idx;
         %'2'
        endif
      case 3
         if(Grid(pos(1)-1,pos(2))!=0)
          [pos(1)-1 pos(2)];
          %disp('occupied');
          rim = find(Grid(1:pos(1)+1,pos(2))!=0);
          rim = rim(1);
          rim;
          plr;
          pos;
          rim;
          before_shift = Grid(:,pos(2))';
          for i= rim:pos(1)-1
              Grid(i-1,pos(2))=Grid(i,pos(2));
          endfor
          after_shift = Grid(:,pos(2))';
          Grid(pos(1)-1,pos(2)) = c_idx;
          after_div = Grid(:,pos(2))';
       else
         Grid(pos(1)-1,pos(2)) = c_idx;
         %'3'
        endif
      case 4
          if(Grid(pos(1),pos(2)-1)!=0)
           [pos(1) pos(2)-1];
          %disp('occupied');
          rim = find(Grid(pos(1),1:pos(2)-1)!=0);
          rim = rim(1);
          rim;
          plr;
          pos;
          rim;
          before_shift = Grid(pos(1),:);
          for i= rim:pos(2)-1
              Grid(pos(1),i-1)=Grid(pos(1),i);
          endfor
          after_shift = Grid(pos(1),:);
          Grid(pos(1),pos(2)-1) = c_idx;
          after_div = Grid(pos(1),:);
       else
        Grid(pos(1),pos(2)-1) = c_idx;
        %'4'
        endif
    endswitch
    return;
   'called'
endfunction
