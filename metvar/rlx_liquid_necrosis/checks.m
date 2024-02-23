clear all
close all

load('starv/Ox')
figure
imagesc(LD_r(:,:,size(LD_r,3)))
colorbar
figure
imagesc(S_r(:,:,size(S_r,3)))
colorbar
figure;
plot(linspace(0,n_pt,length(St_r(25,:))),St_r(25,:))
hold on
plot(linspace(0,n_pt,length(St_r(20,:))),St_r(20,:))



figure; imagesc(state_mat_full(:,:,size(state_mat_full,3))); colorbar

figure
for i=1:size(state_mat_r,3)
  i
  imagesc(state_mat_r(:,:,i))
  kbhit
endfor

figure 1
figure 2
for i=269:size(state_mat_r,3)
  i
  figure 1
  imagesc(state_mat_r(:,:,i))
  figure 2
  imagesc(kS_r(:,:,i))
  kbhit
endfor
%

figure
for i=1:size(Grid_r,3)
  i
  imagesc(Grid_r(:,:,i))
  kbhit
endfor

figure
for i=1:size(S_r,3)
  i
  imagesc(S_r(:,:,i));colorbar
  kbhit
endfor

%150-160 pour vérifier qu'on perd pas de cellules mortes
%269-270-271 pour comprendre pour quoi des cellules baissent à l'extérieur
figure
for i=1:size(kS_r,3)
  i
  imagesc(kS_r(:,:,i));colorbar
  kbhit
endfor

figure
plot(Grid_r(31,16,:))

j=1
for i=1:size(state_cell,2)
  if(j>size(state_cell{i},1))
     story = zeros(1,8);
  else
     story(i,:) = state_cell{i}(j,:);
  endif
endfor
figure
plot(story)

j=10;
clear r
clear c
for i=1:size(Grid_r,3)
  if(j>size(state_cell{i},1))
    r= 0; c=0;
  else
    if(isempty(find(Grid_r(:,:,i)==j)))
      r = 0 ; c = 0;
    else
      [r,c] = ind2sub([sz,sz],find(Grid_r(:,:,i)==j));
    endif
  endif

  if(isempty(find(Grid_r(:,:,i)==j)))
    Evol(i,:)=  zeros(1,7);
  else
    if(r!=0)
      Evol(i,:)= [r c state_mat_r(r,c,i) S_r(r,c,i) kS_r(r,c,i) O_r(r,c,i) kO_r(r,c,i)];
    else
      Evol(i,:)= [r c 0 0 0 0 0];
    endif
  endif
endfor

figure
plot(Evol(:,3))
hold on
plot(Evol(:,4))
plot(Evol(:,5))

for i =1:size(state_cell,2)
  lg(i) = size(state_cell{i},1);
endfor
figure
plot(lg)

j=478;
clear r
clear c
for i=1:size(Grid_r,3)
    [r,c] = ind2sub([sz,sz],find(Grid_r(:,:,i)==j))

    if(isempty(r))
      Evol(i,:)=  zeros(1,7);
    else
      Evol(i,:)= [r c state_mat_r(r,c,i) S_r(r,c,i) kS_r(r,c,i) O_r(r,c,i) kO_r(r,c,i)];
    endif
endfor

figure
plot(Evol(:,3),'x-')
hold on
plot(Evol(:,4))
plot(Evol(:,5),'v-')


j=486;
clear r
clear c
for i=1:size(Grid_full,3)
    [r,c] = ind2sub([sz,sz],find(Grid_full(:,:,i)==j))

    if(isempty(r))
      Evolf(i,:)=  zeros(1,5);
    else
      Evolf(i,:)= [r c state_mat_full(r,c,i) state_cell{i}(j,4) state_cell{i}(j,5)];
    endif
endfor

figure
plot(Evolf(:,3),'x-')
hold on
plot(Evolf(:,4))
%plot(Evolf(:,5))


figure
