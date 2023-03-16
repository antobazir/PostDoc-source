
function Grid = divide1D_2(Grid,pos,c_idx,sz)

%gestion des bords
if(pos==1)
   if(Grid(pos+1)!=0)
        if(isempty(find(Grid(pos+2:sz)==0))==0)
          rim = find(Grid(pos+2:sz)==0);rim = rim(1)
          for i= pos+2+rim:-1:pos+1
              Grid(i+1)=Grid(i);
          endfor
         Grid(pos+1) = c_idx;
         else
            disp('grid full')
            return
        endif
   else
         Grid(pos+1) = c_idx;
   endif
   return;
endif

if(pos==sz)
       if(Grid(pos-1)!=0)
          if(isempty(find(Grid(1:pos-1)==0))==0)
            rim = find(Grid(1:pos-1)!=0);rim = rim(1);
            for i= rim:pos-1
                Grid(i-1)=Grid(i);
            endfor
          Grid(pos-1) = c_idx;
          else
            disp('grid full')
            return
          endif
       else
         Grid(pos-1) = c_idx;
     endif
     return;
endif

%cas général
  plr = floor(2*rand())+1;
  plr;
    switch(plr)
      case 1
       if(Grid(pos+1)!=0)
        if(isempty(find(Grid(pos+2:sz)==0))==0)
          rim = find(Grid(pos+2:sz)==0);rim = rim(1)
          for i= pos+2+rim:-1:pos+1
              Grid(i+1)=Grid(i);
          endfor
         Grid(pos+1) = c_idx;
         else
            disp('grid full');
            return
        endif
       else
         Grid(pos+1) = c_idx;
      endif
      case 2
       if(Grid(pos-1)!=0)
          if(isempty(find(Grid(1:pos-1)==0))==0)
            rim = find(Grid(1:pos-1)!=0);rim = rim(1);
            for i= rim:pos-1
                Grid(i-1)=Grid(i);
            endfor
          Grid(pos-1) = c_idx;
          else
            disp('grid full')
            return
          endif
       else
         Grid(pos-1) = c_idx;
     endif
    endswitch



    return;
   'called'
endfunction
