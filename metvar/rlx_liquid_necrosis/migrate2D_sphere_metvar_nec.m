%function [Grid,G,O,D,GD,T] = migrate2D_sphere_ctr(Grid,lG,cG,G,O,D,GD,T)
%function [Grid,kO,kG,DG,sycle] = migrate2D_sphere_ctr2(Grid,sz,G,O,sycle,kO,kG,kO_tissue,kG_tissue,DG,DG_tissue)
function  [Grid,LD,kO,kS,DSm,DOm,state,state_mat,err] = migrate2D_sphere_metvar_nec(Grid,LD,sz,S,O,state,state_mat,kO,kS,kO_tissue,kS_tissue,DOm,DSm,DOx_tissue,DS_tissue)%encoding the migration of cells in a sphere in order to make the sphere round
% *Hypothesis: Cells are allowed to move a few steps every hour.
% They typically move in order to make the configuration more circular
% In that case it means they move towards the neighboring empty position where
% their distance to the center of the aggregate is minimal
% *The center of the aggregate can be fixed a the beginning or recalculated at each steps

  %Area_patch = length(find(Grid!=0))*(dx^2);
  %Radius_agg = max(state(:,8))*dx;
  %Radius_nec = min(state(:,8))*dx;
  disp('mig')

if(size(kS,1)!=sz)
    disp('wrong resizing begin mig')
    size(kS,1)
    save('debug')
    err =1;
    return
endif

if(isempty(find(state_mat(:,1)!=0))==0)
  disp('problem in the 1st column of state_mat/beginning of mig')
  save('debug_state_mat')
  err=1;
  return
endif

%disp('mig')
 % only the perimeter cells can be moved
perim = im2double(bwperim(Grid));
figure; pcolor(perim);
kbhit;
close
idx_p = find(perim!=0);
sz = size(Grid,1);

%defines indexes
[r c] = ind2sub([sz, sz],idx_p);
%pos_0 = [r c]

figure; pcolor(Grid);
kbhit;

stable_bool=0;
n=0
while(stable_bool==0)
n++;
  % on définit une suite d'index correspond au périmètre et on en garde les positions
  perim = im2double(bwperim(Grid!=0));
  idx_p = find(perim!=0);
  [r c] = ind2sub([sz, sz],idx_p);
  pos_p = [r c];

  % pour chaque indice du périmètre
  for i =1:length(idx_p)
    i
    d_n = 0;

    pos_p(i,:);
    %kbhit
    %on définit  les positions possibles
    ng(1,:) = [pos_p(i,1)-1 pos_p(i,2)-1];
    ng(2,:) = [pos_p(i,1) pos_p(i,2)-1];
    ng(3,:) = [pos_p(i,1)+1 pos_p(i,2)-1];
    ng(4,:) = [pos_p(i,1)-1 pos_p(i,2)];
    ng(5,:) = [pos_p(i,1)+1 pos_p(i,2)];
    ng(6,:) = [pos_p(i,1)-1 pos_p(i,2)+1];
    ng(7,:) = [pos_p(i,1) pos_p(i,2)+1];
    ng(8,:) = [pos_p(i,1)+1 pos_p(i,2)+1];

    %on calcule la distance au centre  et on regarde quels voisins sont vides
    d = sqrt((pos_p(i,1)-round(sz/2)).^2+(pos_p(i,2)-round(sz/2)).^2);
    ngh_vec = neighb(Grid,pos_p(i,:)); %calcule les voisins
    [v,id_d] = find(ngh_vec==0); %prend les indices des voisins vides

    % on calcule le nouveau rayon pour chaque position
    for j=1:length(id_d)
    d_n(j,2) = sqrt((ng(id_d(j),1)-round(sz/2)).^2 + (ng(id_d(j),2)-round(sz/2)).^2);
    d_n(j,1) = id_d(j);
    endfor

    % distances à l'ext/int de l'agrégat
    d
    %disp('d_ext:')
    d_ext = abs(d-max(state(:,8)))
    %disp('d_int:')
    d_int = abs(d-min(state(:,8)))
    kbhit

    %('line 81 in mig')
    % si le rayon est plus proche de l'extérieur que de l'intérieur
    if(d_ext<d_int)
      disp('min in mig')
      % On prend le minimum des rayons possibles
      min_d = find(d_n(:,2)==min(d_n(:,2)));

      % si un pôint présente un rayon plus petit que d
      if(min(d_n(:,2))<d)

        % s'il y e a plus d'un
        nb_can = length(min_d);

        %En choisi un aléatoirement
        rk = abs((1:nb_can)/nb_can-rand());
        id = find(rk==min(rk));

        min_d(id);
        d_n(min_d(id),1);
        Grid(ng(d_n(min_d(id),1),1),ng(d_n(min_d(id),1),2))=Grid(idx_p(i));
        Grid(pos_p(i,1),pos_p(i,2))=0;
        LD(ng(d_n(min_d(id),1),1),ng(d_n(min_d(id),1),2))=LD(idx_p(i));
        LD(pos_p(i,1),pos_p(i,2))=0;
        kS(ng(d_n(min_d(id),1),1),ng(d_n(min_d(id),1),2))=kS(idx_p(i));
        kS(pos_p(i,1),pos_p(i,2))=0;
        %dkS(ng(d_n(min_d(id),1),1),ng(d_n(min_d(id),1),2))=dkS(idx_p(i));
        %dkS(pos_p(i,1),pos_p(i,2))=0;
        %kP(ng(d_n(min_d(id),1),1),ng(d_n(min_d(id),1),2))=kP(idx_p(i));
        %kP(pos_p(i,1),pos_p(i,2))=0;
        kO(ng(d_n(min_d(id),1),1),ng(d_n(min_d(id),1),2))=kO(idx_p(i));
        kO(pos_p(i,1),pos_p(i,2))=0;
        %dkO(ng(d_n(min_d(id),1),1),ng(d_n(min_d(id),1),2))=dkO(idx_p(i));
        %dkO(pos_p(i,1),pos_p(i,2))=0;
        DSm(ng(d_n(min_d(id),1),1),ng(d_n(min_d(id),1),2))=DSm(idx_p(i));
        DSm(pos_p(i,1),pos_p(i,2))=0;
        %DPm(ng(d_n(min_d(id),1),1),ng(d_n(min_d(id),1),2))=DPm(idx_p(i));
        %DPm(pos_p(i,1),pos_p(i,2))=0;
        DOm(ng(d_n(min_d(id),1),1),ng(d_n(min_d(id),1),2))=DOm(idx_p(i));
        DOm(pos_p(i,1),pos_p(i,2))=0;
        state_mat(ng(d_n(min_d(id),1),1),ng(d_n(min_d(id),1),2))  = state_mat(idx_p(i));
        state_mat(pos_p(i,1),pos_p(i,2))  = 0;
        state(Grid(ng(d_n(min_d(id),1),1),ng(d_n(min_d(id),1),2)),8) = sqrt((ng(d_n(min_d(id),1),1)-round(sz/2)).^2+(ng(d_n(min_d(id),1),2)-round(sz/2)).^2);
        %DKm(ng(d_n(min_d(id),1),1),ng(d_n(min_d(id),1),2))=DOm(idx_p(i));
        %DKm(pos_p(i,1),pos_p(i,2))=0;
        %Rt_S(ng(d_n(min_d(id),1),1),ng(d_n(min_d(id),1),2))=Rt_S(idx_p(i));
        %Rt_S(pos_p(i,1),pos_p(i,2))=0;
        %Rt_O(ng(d_n(min_d(id),1),1),ng(d_n(min_d(id),1),2))=Rt_O(idx_p(i));
        %Rt_O(pos_p(i,1),pos_p(i,2))=0;

        %mise à jour des cartes de diffusion intracellulaires

        %on ne remet pas  G et O à zéro car elles sont mis à jour à la prochaine étape de diffusion

        %mise à jour des cartes de diffusion intracellulaires

        %disp('switch')
        %imagesc(Grid!=0);
        break;%sort de la boucle si on change la config
      endif

    elseif(d_ext>d_int)
      disp('max in mig')
      % On prend le maximum des rayons possibles
      max_d = find(d_n(:,2)==max(d_n(:,2)));

      % si un pôint présente un rayon plus petit que d
      if(max(d_n(:,2))>d)

        % s'il y e a plus d'un
        nb_can = length(max_d);

        %En choisi un aléatoirement
        rk = abs((1:nb_can)/nb_can-rand());
        id = find(rk==min(rk));

        max_d(id);
        d_n(max_d(id),1);
        Grid(ng(d_n(max_d(id),1),1),ng(d_n(max_d(id),1),2))=Grid(idx_p(i));
        Grid(pos_p(i,1),pos_p(i,2))=0;
        LD(ng(d_n(max_d(id),1),1),ng(d_n(max_d(id),1),2))=LD(idx_p(i));
        LD(pos_p(i,1),pos_p(i,2))=0;
        kS(ng(d_n(max_d(id),1),1),ng(d_n(max_d(id),1),2))=kS(idx_p(i));
        kS(pos_p(i,1),pos_p(i,2))=0;
        %dkS(ng(d_n(max_d(id),1),1),ng(d_n(max_d(id),1),2))=dkS(idx_p(i));
        %dkS(pos_p(i,1),pos_p(i,2))=0;
        %kP(ng(d_n(max_d(id),1),1),ng(d_n(max_d(id),1),2))=kP(idx_p(i));
        %kP(pos_p(i,1),pos_p(i,2))=0;
        kO(ng(d_n(max_d(id),1),1),ng(d_n(max_d(id),1),2))=kO(idx_p(i));
        kO(pos_p(i,1),pos_p(i,2))=0;
        %dkO(ng(d_n(max_d(id),1),1),ng(d_n(max_d(id),1),2))=dkO(idx_p(i));
        %dkO(pos_p(i,1),pos_p(i,2))=0;
        DSm(ng(d_n(max_d(id),1),1),ng(d_n(max_d(id),1),2))=DSm(idx_p(i));
        DSm(pos_p(i,1),pos_p(i,2))=0;
        %DPm(ng(d_n(max_d(id),1),1),ng(d_n(max_d(id),1),2))=DPm(idx_p(i));
        %DPm(pos_p(i,1),pos_p(i,2))=0;
        DOm(ng(d_n(max_d(id),1),1),ng(d_n(max_d(id),1),2))=DOm(idx_p(i));
        DOm(pos_p(i,1),pos_p(i,2))=0;
        state_mat(ng(d_n(max_d(id),1),1),ng(d_n(max_d(id),1),2))  = state_mat(idx_p(i));
        state_mat(pos_p(i,1),pos_p(i,2))  = 0;
        state(Grid(ng(d_n(max_d(id),1),1),ng(d_n(max_d(id),1),2)),8) = sqrt((ng(d_n(max_d(id),1),1)-round(sz/2)).^2+(ng(d_n(max_d(id),1),2)-round(sz/2)).^2);
        %DKm(ng(d_n(max_d(id),1),1),ng(d_n(max_d(id),1),2))=DOm(idx_p(i));
        %DKm(pos_p(i,1),pos_p(i,2))=0;
        %Rt_S(ng(d_n(max_d(id),1),1),ng(d_n(max_d(id),1),2))=Rt_S(idx_p(i));
        %Rt_S(pos_p(i,1),pos_p(i,2))=0;
        %Rt_O(ng(d_n(max_d(id),1),1),ng(d_n(max_d(id),1),2))=Rt_O(idx_p(i));
        %Rt_O(pos_p(i,1),pos_p(i,2))=0;

        %mise à jour des cartes de diffusion intracellulaires

        %on ne remet pas  G et O à zéro car elles sont mis à jour à la prochaine étape de diffusion

        %mise à jour des cartes de diffusion intracellulaires

        %disp('switch')
        %imagesc(Grid!=0);
        break;%sort de la boucle si on change la config

      endif

    endif

    if(i==length(idx_p))
      stable_bool=1;
    endif

    figure; pcolor(Grid);
    kbhit;

  endfor



  if(size(kS,1)!=sz)
    disp('wrong resizing end mig')
    save('debug')
    err =1;
    return
  endif

  if(isempty(find(state_mat(:,1)!=0))==0)
    disp('problem in the 1st column of state_mat/end of mig')
    save('debug_state_mat')
    err=1;
    return
  endif

    if (n==3*size(state,1))
       stable_bool=1;
    endif
  err =0;
endwhile

