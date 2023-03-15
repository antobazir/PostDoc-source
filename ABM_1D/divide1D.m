function Grid = divide1D(Grid,pos,c_idx,sz)



  plr = floor(2*rand())+1;
  plr
    switch(plr)
      case 1
        if(Grid(pos+1)!=0)
          rim = find(Grid(pos+2:sz)==0);
          rim = rim(1)
          for i= pos+2+rim:-1:pos+1
              Grid(i+1)=Grid(i);
          endfor
         Grid(pos+1) = c_idx;
       else
         Grid(pos+1) = c_idx;
        endif
      case 2
         if(Grid(pos-1)!=0)
         disp('occupied')
          rim = find(Grid(1:pos+1)!=0);
          rim = rim(1);
          for i= rim:pos-1
              Grid(i-1)=Grid(i);
          endfor
         Grid(pos-1) = c_idx;
       else
         Grid(pos-1) = c_idx;
        endif
    endswitch
    return;



 'called'
endfunction
