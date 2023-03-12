function Grid = divide(Grid,pos,plr,c_idx,sz)
    switch(plr)
      case 1
        if(Grid(pos(1)+1,pos(2),pos(3))!=0)
          rim = find(Grid(pos(1)+1:sz,pos(2),pos(3))==0); rim = rim(1);
          for i= rim:-1:pos(1)+1
              Grid(i+1,pos(2),pos(3))=Grid(i,pos(2),pos(3));
          endfor
         Grid(pos(1)+1,pos(2),pos(3)) = c_idx;
       else
         Grid(pos(1)+1,pos(2),pos(3)) = c_idx;
        endif
      case 2
          if(Grid(pos(1),pos(2)+1,pos(3))!=0)
          rim = find(Grid(pos(1),pos(2)+1:sz,pos(3))==0); rim = rim(1);
          for i= rim:-1:pos(2)+1
              Grid(pos(1),i+1,pos(3))=Grid(pos(1),i,pos(3));
          endfor
         Grid(pos(1),pos(2)+1,pos(3)) = c_idx;
       else
         Grid(pos(1),pos(2)+1,pos(3)) = c_idx;
        endif
      case 3
         if(Grid(pos(1),pos(2),pos(3)+1)!=0)
          rim = find(Grid(pos(1),pos(2),pos(3)+1:sz)==0); rim = rim(1);
          for i= rim:-1:pos(3)+1
              Grid(pos(1),pos(2),i+1)=Grid(pos(1),pos(2),i);
          endfor
         Grid(pos(1),pos(2),pos(3)+1) = c_idx;
       else
         Grid(pos(1),pos(2),pos(3)+1) = c_idx;
        endif
      case 4
         if(Grid(pos(1)-1,pos(2),pos(3))!=0)
          rim = find(Grid(1:pos(1)+1,pos(2),pos(3))!=0); rim = rim(1);
          for i= rim:pos(1)-1
              Grid(i-1,pos(2),pos(3))=Grid(i,pos(2),pos(3));
          endfor
         Grid(pos(1)-1,pos(2),pos(3)) = c_idx;
       else
         Grid(pos(1)-1,pos(2),pos(3)) = c_idx;
        endif
      case 5
          if(Grid(pos(1),pos(2)-1,pos(3))!=0)
          rim = find(Grid(pos(1),1:pos(2)-1,pos(3))!=0); rim = rim(1);
          for i= rim:pos(2)-1
              Grid(pos(1),i-1,pos(3))=Grid(pos(1),i,pos(3));
          endfor
         Grid(pos(1),pos(2)-1,pos(3)) = c_idx;
       else
        Grid(pos(1),pos(2)-1,pos(3)) = c_idx;
        endif
      case 6
         if(Grid(pos(1),pos(2),pos(3)-1)!=0)
          rim = find(Grid(pos(1),pos(2),1:pos(3)-1)!=0); rim = rim(1);
          for i= rim:pos(3)-1
              Grid(pos(1),pos(2),i-1)=Grid(pos(1),pos(2),i);
          endfor
         Grid(pos(1),pos(2),pos(3)-1) = c_idx;
        endif
    endswitch
   'called'
endfunction
