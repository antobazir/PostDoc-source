size = 100; %size in cells
Grid = zeros(size,size,size);
cr = 5; % cell radius
ncy = 2;
c_idx = 1; %cell index
%moore neighboorhood

%initialisation
Grid(size/2,size/2,size/2)=1;
Grid(size/2+1,size/2,size/2)=2;
Grid(size/2+2,size/2,size/2)=3;
Grid(size/2+3,size/2,size/2)=4;
Grid(size/2+4,size/2,size/2)=5;
Grid(size/2+5,size/2,size/2)=6;
Grid(size/2+6,size/2,size/2)=7;

%grid position correspondance
%(100*100)*(z-1)+100*(y-1)+x

%cell cycle-division
for i=1:ncy
    %if division occurs cell index is raised and position is retrieved
    prt_idx = find(Grid==prt_idx)
    prt_pos(3) = floor(find(Grid==1)/(100*100))+1;
    prt_pos(2) = floor((find(Grid==1)-(prt_pos(3)-1)*100*100)/100)+1;
    prt_pos(1) = (find(Grid==1)-(prt_pos(3)-1)*100*100-(prt_pos(2)-1)*100);
    c_idx = c_idx+1;
    plr = round(6*rand()); %choose polarisation of dividinig cells
    switch(plr)
      case 1
        if()
        Grid(prt_pos(1)+1,prt_pos(2),prt_pos(3))=c_idx;
      case 2
        Grid(prt_pos(1),prt_pos(2)+1,prt_pos(3))=c_idx;
      case 3
        Grid(prt_pos(1),prt_pos(2),prt_pos(3)+1)=c_idx;
      case 4
        Grid(prt_pos(1)-1,prt_pos(2),prt_pos(3))=c_idx;
      case 5
        Grid(prt_pos(1),prt_pos(2)-1,prt_pos(3))=c_idx;
      case 6
        Grid(prt_pos(1),prt_pos(2),prt_pos(3)-1)=c_idx;
    endswitch
endfor

function ret = divide(Grid,pos,plr,c_idx)
    switch(plr)
      case 1
        if(Grid(pos(1)+1,pos(2),pos(3))!=0)
          rim = find(Grid(pos(1)+1:size,pos(2),pos(3))==0); rim = rim(1);
          for i= rim:-1:pos(1)+1
              Grid(i+1,pos(2),pos(3))=Grid(i,pos(2),pos(3));
          endfor
         Grid(pos(1)+1,pos(2),pos(3)) = c_idx;
        endif
      case 2
          if(Grid(pos(1),pos(2)+1,pos(3))!=0)
          rim = find(Grid(pos(1),pos(2)+1:size,pos(3))==0); rim = rim(1);
          for i= rim:-1:pos(2)+1
              Grid(pos(1),i+1,pos(3))=Grid(pos(1),i,pos(3));
          endfor
         Grid(pos(1),pos(2)+1,pos(3)) = c_idx;
        endif
      case 3
         if(Grid(pos(1),pos(2),pos(3)+1)!=0)
          rim = find(Grid(pos(1),pos(2),pos(3)+1:size)==0); rim = rim(1);
          for i= rim:-1:pos(3)+1
              Grid(pos(1),pos(2),i+1)=Grid(pos(1),pos(2),i);
          endfor
         Grid(pos(1),pos(2),pos(3)+1) = c_idx;
        endif
      case 4
         if(Grid(pos(1)-1,pos(2),pos(3))!=0)
          rim = find(Grid(1:pos(1)+1,pos(2),pos(3))!=0); rim = rim(1);
          for i= rim:pos(1)-1
              Grid(i-1,pos(2),pos(3))=Grid(i,pos(2),pos(3));
          endfor
         Grid(pos(1)-1,pos(2),pos(3)) = c_idx;
        endif
      case 5
          if(Grid(pos(1),pos(2)-1,pos(3))!=0)
          rim = find(Grid(pos(1),1:pos(2)-1,pos(3))!=0); rim = rim(1);
          for i= rim:pos(2)-1
              Grid(pos(1),i-1,pos(3))=Grid(pos(1),i,pos(3));
          endfor
         Grid(pos(1),pos(2)-1,pos(3)) = c_idx;
        endif
      case 6
        Grid(prt_pos(1),prt_pos(2),prt_pos(3)-1)=c_idx;
    endswitch
endfunction

