function Grid = migrate2D_chip(Grid,pos,c_idx,sz)
  %plr = randi(1:4);
  %pos
  %cas full occupé ou inoccupé 1a et b
  if(Grid(pos(1)+1,pos(2))==0&&Grid(pos(1)-1,pos(2))==0&&Grid(pos(1),pos(2)+1)==0&&Grid(pos(1),pos(2)-1)==0)
      disp('1a');
      plr = randi(4);
      switch(plr)
        case 1
             Grid(pos(1)+1,pos(2)) = c_idx;
             Grid(pos(1),pos(2)) = 0;
              return;
        case 2
             Grid(pos(1),pos(2)+1) = c_idx;
             Grid(pos(1),pos(2)) = 0;
              return;
        case 3
             Grid(pos(1)-1,pos(2)) = c_idx;
             Grid(pos(1),pos(2)) = 0;
              return;
        case 4
             Grid(pos(1),pos(2)-1) = c_idx;
             Grid(pos(1),pos(2)) = 0;
               return;
      endswitch

  endif

   if(Grid(pos(1)+1,pos(2))!=0&&Grid(pos(1)-1,pos(2))!=0&&Grid(pos(1),pos(2)+1)!=0&&Grid(pos(1),pos(2)-1)!=0)
      disp('boxed in')
       return;
  endif

  %cas avec  3 voisins sur 4 2 a b c et d
     if(Grid(pos(1)+1,pos(2))==0&&Grid(pos(1)-1,pos(2))!=0&&Grid(pos(1),pos(2)+1)!=0&&Grid(pos(1),pos(2)-1)!=0)
     disp('2a');
         Grid(pos(1)+1,pos(2)) = c_idx;
         Grid(pos(1),pos(2)) = 0;
          return;
  endif

     if(Grid(pos(1)+1,pos(2))!=0&&Grid(pos(1)-1,pos(2))!=0&&Grid(pos(1),pos(2)+1)==0&&Grid(pos(1),pos(2)-1)!=0)
       disp('2b');
         Grid(pos(1),pos(2)+1) = c_idx;
         Grid(pos(1),pos(2)) = 0;
          return;
  endif

   if(Grid(pos(1)+1,pos(2))!=0&&Grid(pos(1)-1,pos(2))==0&&Grid(pos(1),pos(2)+1)!=0&&Grid(pos(1),pos(2)-1)!=0)
      disp('2c');
         Grid(pos(1)-1,pos(2)) = c_idx;
         Grid(pos(1),pos(2)) = 0;
          return;
  endif

     if(Grid(pos(1)+1,pos(2))!=0&&Grid(pos(1)-1,pos(2))!=0&&Grid(pos(1),pos(2)+1)!=0&&Grid(pos(1),pos(2)-1)==0)
     disp('2d');
         Grid(pos(1),pos(2)-1) = c_idx;
         Grid(pos(1),pos(2)) = 0;
          return;
  endif

  %cas avec 2 voisins sur 4 3 a b c et  d
   if(Grid(pos(1)+1,pos(2))==0&&Grid(pos(1)-1,pos(2))==0&&Grid(pos(1),pos(2)+1)!=0&&Grid(pos(1),pos(2)-1)!=0)
   %disp('3a');
   rd = rand()
      if(rd<0.5)
         Grid(pos(1)+1,pos(2)) = c_idx;
         Grid(pos(1),pos(2)) = 0;
        disp('3a-1')
        return;
      else
         Grid(pos(1)-1,pos(2)) = c_idx;
         Grid(pos(1),pos(2)) = 0;
        disp('3a-3')
        return;
      endif

  endif

    if(Grid(pos(1)+1,pos(2))!=0&&Grid(pos(1)-1,pos(2))!=0&&Grid(pos(1),pos(2)+1)==0&&Grid(pos(1),pos(2)-1)==0)
    %disp('3b')
    rd = rand()
      if(rd<0.5)
         Grid(pos(1),pos(2)+1) = c_idx;
         Grid(pos(1),pos(2)) = 0;
        disp('3b-2')
        return;
      else
         Grid(pos(1),pos(2)-1) = c_idx;
         Grid(pos(1),pos(2)) = 0;
        disp('3b-4')
        return;
      endif

  endif

    if(Grid(pos(1)+1,pos(2))!=0&&Grid(pos(1)-1,pos(2))==0&&Grid(pos(1),pos(2)+1)!=0&&Grid(pos(1),pos(2)-1)==0)
    %disp('3c')
      rd = rand()
      if(rd<0.5)
         Grid(pos(1)-1,pos(2)) = c_idx;
         Grid(pos(1),pos(2)) = 0;
        disp('3c-3')
        return;
      else
         Grid(pos(1),pos(2)-1) = c_idx;
         Grid(pos(1),pos(2)) = 0;
        disp('3c-4')
        return;
      endif
  endif

    if(Grid(pos(1)+1,pos(2))==0&&Grid(pos(1)-1,pos(2))!=0&&Grid(pos(1),pos(2)+1)==0&&Grid(pos(1),pos(2)-1)!=0)
    %disp('3d')
      rd = rand()
      if(rd<0.5)
         Grid(pos(1)+1,pos(2)) = c_idx;
         Grid(pos(1),pos(2)) = 0;
        disp('3d-1')
        return;
      else
         Grid(pos(1),pos(2)+1) = c_idx;
         Grid(pos(1),pos(2)) = 0;
        disp('3d-2')
        return;
      endif
  endif

      if(Grid(pos(1)+1,pos(2))!=0&&Grid(pos(1)-1,pos(2))==0&&Grid(pos(1),pos(2)+1)==0&&Grid(pos(1),pos(2)-1)!=0)
    %disp('3e')
      rd = rand()
      if(rd<0.5)
         Grid(pos(1)-1,pos(2)) = c_idx;
         Grid(pos(1),pos(2)) = 0;
        disp('3e-3')
        return;
      else
         Grid(pos(1),pos(2)+1) = c_idx;
         Grid(pos(1),pos(2)) = 0;
        disp('3e-2')
        return;
      endif

  endif

    if(Grid(pos(1)+1,pos(2))==0&&Grid(pos(1)-1,pos(2))!=0&&Grid(pos(1),pos(2)+1)!=0&&Grid(pos(1),pos(2)-1)==0)
    %disp('3f')
      rd = rand()
      if(rd<0.5)
         Grid(pos(1)+1,pos(2)) = c_idx;
         Grid(pos(1),pos(2)) = 0;
        disp('3f-1')
      else
         Grid(pos(1),pos(2)-1) = c_idx;
         Grid(pos(1),pos(2)) = 0;
        disp('3f-4')
      endif
       return;
  endif



  %cas avec un voisin sur 4 4 a b c d
   if(Grid(pos(1)+1,pos(2))!=0&&Grid(pos(1)-1,pos(2))==0&&Grid(pos(1),pos(2)+1)==0&&Grid(pos(1),pos(2)-1)==0)
     %disp('4a')
      rd= rand()
      if(rd<0.3)
         Grid(pos(1),pos(2)+1) = c_idx;
         Grid(pos(1),pos(2)) = 0;
        disp('4a-2')
        return;
      elseif(rd>=0.33&&rd<0.66)
         Grid(pos(1)-1,pos(2)) = c_idx;
         Grid(pos(1),pos(2)) = 0;
        disp('4a-3')
        return;
      else
         Grid(pos(1),pos(2)-1) = c_idx;
         Grid(pos(1),pos(2)) = 0;
        disp('4a-4')
        return;
      endif

  endif

   if(Grid(pos(1)+1,pos(2))==0&&Grid(pos(1)-1,pos(2))!=0&&Grid(pos(1),pos(2)+1)==0&&Grid(pos(1),pos(2)-1)==0)
   %disp('4b')
      rd= rand()
      if(rd<0.3)
         Grid(pos(1)+1,pos(2)) = c_idx;
         Grid(pos(1),pos(2)) = 0;
        disp('4b-1')
        return;
      elseif(rd>=0.33&&rd<0.66)
         Grid(pos(1),pos(2)+1) = c_idx;
         Grid(pos(1),pos(2)) = 0;
        disp('4b-2')
        return;
      else
         Grid(pos(1),pos(2)-1) = c_idx;
         Grid(pos(1),pos(2)) = 0;
        disp('4b-4')
        return;
      endif
  endif

    if(Grid(pos(1)+1,pos(2))==0&&Grid(pos(1)-1,pos(2))==0&&Grid(pos(1),pos(2)+1)!=0&&Grid(pos(1),pos(2)-1)==0)
    %disp('4c')
      rd = rand()
      if(rd<0.3)
         Grid(pos(1)+1,pos(2)) = c_idx;
         Grid(pos(1),pos(2)) = 0;
        disp('4c-1')
        return;
      elseif(rd>=0.33&&rd<0.66)
         Grid(pos(1)-1,pos(2)) = c_idx;
         Grid(pos(1),pos(2)) = 0;
        disp('4c-3')
        return;
      else
         Grid(pos(1),pos(2)-1) = c_idx;
         Grid(pos(1),pos(2)) = 0;
        disp('4c-4')
        return;
      endif
  endif

    if(Grid(pos(1)+1,pos(2))==0&&Grid(pos(1)-1,pos(2))==0&&Grid(pos(1),pos(2)+1)==0&&Grid(pos(1),pos(2)-1)!=0)
    %disp('4d')
      rd = rand()
      if(rd<0.3)
         Grid(pos(1)+1,pos(2)) = c_idx;
         Grid(pos(1),pos(2)) = 0;
        disp('4d-1')
        return;
      elseif(rd>=0.33&&rd<0.66)
         Grid(pos(1),pos(2)+1) = c_idx;
         Grid(pos(1),pos(2)) = 0;
        disp('4d-2')
        return;
      else
         Grid(pos(1)-1,pos(2)) = c_idx;
         Grid(pos(1),pos(2)) = 0;
        disp('4d-3')
        return;
      endif

  endif


endfunction
