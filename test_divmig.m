%Test divmig on a set random config
pkg load image
clear all
close all
sz = 10;
Grid = zeros(sz,sz);

lG = 5;
cG = 5;

Grid(3,5:6)=1;
Grid(4,5:6)=1;
Grid(5,3:7)=1;
Grid(6,3:6)=1;
Grid(7,4:5)=1;
Grid(8,5)=1;


ng(1,:) = [lG-1 cG-1];
ng(2,:) = [lG cG-1];
ng(3,:) = [lG+1 cG-1];
ng(4,:) = [lG-1 cG];
ng(5,:) = [lG+1 cG];
ng(6,:) = [lG-1 cG+1];
ng(7,:) = [lG cG+1];
ng(8,:) = [lG+1 cG+1];

imagesc(Grid!=0)
%figure
perim = im2double(bwperim(Grid!=0));
idx_p = find(perim!=0);
[r c] = ind2sub([sz, sz],idx_p);
pos_0 = [r c]

imagesc(Grid!=0);


##for h=1:2
##  h
  %waitforbuttonpress

  stable_bool=0;
  while(stable_bool==0)
    waitforbuttonpress
    perim = im2double(bwperim(Grid!=0));
    idx_p = find(perim!=0);
    [r c] = ind2sub([sz, sz],idx_p);
    pos = [r c]

    for i =1:length(idx_p)
    i
    d_n = 0;

    pos(i,:)
    %kbhit
    ng(1,:) = [pos(i,1)-1 pos(i,2)-1];
    ng(2,:) = [pos(i,1) pos(i,2)-1];
    ng(3,:) = [pos(i,1)+1 pos(i,2)-1];
    ng(4,:) = [pos(i,1)-1 pos(i,2)];
    ng(5,:) = [pos(i,1)+1 pos(i,2)];
    ng(6,:) = [pos(i,1)-1 pos(i,2)+1];
    ng(7,:) = [pos(i,1) pos(i,2)+1];
    ng(8,:) = [pos(i,1)+1 pos(i,2)+1];
    %Grid = migrate2D_sphere(Grid,pos(i,:),1,sz,lG,cG)

      d = sqrt((pos(i,1)-lG).^2+(pos(i,2)-cG).^2)
      ngh_vec = neighb(Grid,pos(i,:))
      [v,id_d] = find(ngh_vec==0)

        for j=1:length(id_d)
          d_n(j,2) = sqrt((ng(id_d(j),1)-lG).^2 + (ng(id_d(j),2)-cG).^2);
          d_n(j,1) = id_d(j);
        endfor
        d_n

        min_d = find(d_n(:,2)==min(d_n(:,2)));
        if(min(d_n(:,2))<d)
          nb_can = length(min_d);

          %En choisi un aléatoirement
          rk = abs((1:nb_can)/nb_can-rand());
          id = find(rk==min(rk));

          min_d(id);
          d_n(min_d(id),1);
          Grid(ng(d_n(min_d(id),1),1),ng(d_n(min_d(id),1),2))=1;
          Grid(pos(i,1),pos(i,2))=0;
          disp('switch')
          imagesc(Grid!=0);
          break;%sort de la boucle si on change la config
        endif
        if(i==length(idx_p))
            stable_bool=1
        endif
      %Grid
    %imagesc(Grid!=0);
    %hold on;
    endfor
  endwhile
%endfor

%En fait il faut recalculer le perimètre et repartir de 1 DES que ça bouge.
%Il me faut  2 booléen. le premier reste à  zéro tant que je n'ai pas fait tout le périmètre sans rien changer
% et dedans faut un fort sur le périmètre qui break si on change et recalcule tout.

