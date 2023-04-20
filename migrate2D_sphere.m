function Grid = migrate2D_sphere(Grid,pos,c_idx,sz,lG,cG)
%option A: essayer de maximiser son nombre de voisin
##        ng(1,:) = [pos(1)-1 pos(2)-1];
##        ng(2,:) = [pos(1) pos(2)-1];
##        ng(3,:) = [pos(1)+1 pos(2)-1];
##        ng(4,:) = [pos(1)-1 pos(2)];
##        ng(5,:) = [pos(1)+1 pos(2)];
##        ng(6,:) = [pos(1)-1 pos(2)+1];
##        ng(7,:) = [pos(1) pos(2)+1];
##        ng(8,:) = [pos(1)+1 pos(2)+1];
##
##
##        ngh_vec = neighb(Grid,pos);
##        nb_ngh0 = length(find(ngh_vec!=0));
##        if(length(find(ngh_vec!=0))<4)%less than 4 neighbor means you're at a tip
##           [v_n, id_n] = find(ngh_vec==0);
##
##            for j =1:length(id_n)
##                nb_ngh(j) = length(find(neighb(Grid,ng(id_n(j),:))!=0))-1;
##                %nb_ngh(j) = length(neighb(Grid,ng(j,:)))
##            endfor
##
##            if(max(nb_ngh)>nb_ngh0)
##                can = id_n(find(nb_ngh==max(nb_ngh)));
##                nb_can = length(can);
##
##                %En choisi un aléatoirement
##                rk = abs((1:nb_can)/nb_can-rand());
##                id = find(rk==min(rk));
##
##                %effectue la migration
##                can(id);
##                Grid(ng(can(id),1),ng(can(id),2))=c_idx;
##                Grid(pos(1),pos(2))=0;
##            endif
##
##
##        endif

%option B : rapprocher les points du barycentre. ne marche pas bien
%ngh_vec = neighb(Grid,pos);
%nb_ngh0 = length(find(ngh_vec!=0))
%if(nb_ngh0<8)
  idx = find(Grid!=0);

  ng(1,:) = [pos(1)-1 pos(2)-1];
  ng(2,:) = [pos(1) pos(2)-1];
  ng(3,:) = [pos(1)+1 pos(2)-1];
  ng(4,:) = [pos(1)-1 pos(2)];
  ng(5,:) = [pos(1)+1 pos(2)];
  ng(6,:) = [pos(1)-1 pos(2)+1];
  ng(7,:) = [pos(1) pos(2)+1];
  ng(8,:) = [pos(1)+1 pos(2)+1];

  row = ((1:sz).*ones(sz,1))';
  col = (1:sz).*ones(sz,1);

  for i = 1:length(idx)
    ps(i,2) = col(idx(i));
    ps(i,1) = row(idx(i));
  endfor

  %ps
  %lG = round((sum(ps(:,1)))/length(ps(:,1)))
  %cG = round((sum(ps(:,2)))/length(ps(:,2)))
  %scatter(cG,lG,'x')


  if(pos(1)!=lG&&pos(2)!=cG)
      d_n = 0;
      d = sqrt((pos(1)-lG).^2+(pos(2)-cG).^2);
      ngh_vec = neighb(Grid,pos);
      [v,id_d] = find(ngh_vec==0);

      for i=1:length(id_d)
        d_n(i,2) = sqrt((ng(id_d(i),1)-lG).^2 + (ng(id_d(i),2)-cG).^2);
        d_n(i,1) = id_d(i);
      endfor
      %
      min_d = find(d_n(:,2)==min(d_n(:,2)));
      if(min(d_n(:,2))<d)
        nb_can = length(min_d);

        %En choisi un aléatoirement
        rk = abs((1:nb_can)/nb_can-rand());
        id = find(rk==min(rk));

        min_d(id);
        d_n(min_d(id),1);
        %min_d(d_n(min_d(id),2))
    ##
        Grid(ng(d_n(min_d(id),1),1),ng(d_n(min_d(id),1),2))=c_idx;
        Grid(pos(1),pos(2))=0;
        disp('switched')
        ng(d_n(min_d(id),1),1);
        ng(d_n(min_d(id),1),2);
      endif
    endif
%endif


##%option C
##
## ml = find(sum(Grid,2));
##lmax_0 = ml(length(ml))-ml(1)+1;
## mc = find(sum(Grid,1));
##cmax_0 = mc(length(mc))-mc(1)+1;
##lmax = 0;
##cmax = 0;
##
##        ng(1,:) = [pos(1)-1 pos(2)-1];
##        ng(2,:) = [pos(1) pos(2)-1];
##        ng(3,:) = [pos(1)+1 pos(2)-1];
##        ng(4,:) = [pos(1)-1 pos(2)];
##        ng(5,:) = [pos(1)+1 pos(2)];
##        ng(6,:) = [pos(1)-1 pos(2)+1];
##        ng(7,:) = [pos(1) pos(2)+1];
##        ng(8,:) = [pos(1)+1 pos(2)+1];
##
##
##         %if(length(idx)>1)
##         ngh_vec = neighb(Grid,pos);
##         [v_n, id_n] = find(ngh_vec==0);
##         if(isempty(id_n)==0)
##          for j=1:length(id_n)
##            j;
##            G2 =  Grid;
##            G2(pos(1),pos(2)) = 0;
##            G2(ng(id_n(j),1),ng(id_n(j),2)) = 1;
##            G2;
##            ml = find(sum(G2,2));
##            lmax(j) = ml(length(ml))-ml(1)+1;
##            mc = find(sum(G2,1));
##            cmax(j) = mc(length(mc))-mc(1)+1;
##            %Je ne peux pas en une seule permutation  faire baisser lmax et cmax
##
##
####            area = length(find(G2)!=0)
####            perimeter = length(find(im2double(bwperim(G2))))
####            Roundness(j) = perimeter.^2/(4*pi*area)
##          endfor
##          dlmax = lmax-lmax_0;
##          dcmax = cmax-cmax_0;
##          dmax = dlmax+dcmax;
##          find(dmax==min(dmax));
##
##          if(min(dmax)<0)
##            can = id_n(find(dmax==min(dmax)));
##            nb_can = length(can);
##
##            rk = abs((1:nb_can)/nb_can-rand());
##            id = find(rk==min(rk));
##
##            %effectue la migration
##            can(id);
##            Grid(ng(can(id),1),ng(can(id),2))=c_idx;
##            Grid(pos(1),pos(2))=0;
##            c_idx
##            disp([num2str(c_idx) ':shifted'])
##          endif
##          endif


endfunction

