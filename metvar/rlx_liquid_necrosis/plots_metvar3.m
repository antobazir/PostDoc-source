%all the plots needed for metvar3

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%ref conf
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all
close all
load('ref_conf/Id','LD_r','S_r','O_r','Grid_r','sz','dx')

figure
for i=1:size(LD_r,3)
  area(i) = length(find(Grid_r(:,:,i)));
endfor
plot((1:size(LD_r,3))*10,area)
ylabel('Cell number')
xlabel('Minutes')
set(gca,'outerposition',[0 0.05 0.9 0.9])
print(gcf,["/home/antonybazir/Documents/Post-doc/Redac/metvar/ref_conf_area.pdf"], "-dpdflatex","-S240,180","-FCalibri:24");
close

figure
imagesc(dx*(-round(sz/2)+1:round(sz/2))*1e-3,dx*(-round(sz/2)+1:round(sz/2))*1e-3,Grid_r(:,:,size(Grid_r,3)))
ylabel('position (mm)')
xlabel('position (mm)')
set(gca,'outerposition',[0 0.05 0.9 0.9])
print(gcf,["/home/antonybazir/Documents/Post-doc/Redac/metvar/ref_conf_Grid.pdf"], "-dpdflatex","-S240,180","-FCalibri:24");
close

figure
hold on
for i=1:size(S_r,3)
  i
  S_ctr(i) = S_r(round(sz/2),round(sz/2),i);
  O_ctr(i) = O_r(round(sz/2),round(sz/2),i);
endfor
plot((1:size(LD_r,3))*10,S_ctr)
plot((1:size(LD_r,3))*10,O_ctr)
ylabel('Concentration')
xlabel('Minutes')
set(gca,'outerposition',[0 0.05 0.9 0.9])
print(gcf,["/home/antonybazir/Documents/Post-doc/Redac/metvar/ref_SO_ctr.pdf"], "-dpdflatex","-S240,180","-FCalibri:24");
close

figure
hold on
plot(dx*(-round(sz/2)+1:round(sz/2))*1e-3,S_r(round(sz/2),:,size(S_r,3)))
plot(dx*(-round(sz/2)+1:round(sz/2))*1e-3,O_r(round(sz/2),:,size(O_r,3)))
ylabel('Concentration')
xlabel('position (mm)')
set(gca,'outerposition',[0 0.05 0.9 0.9])
print(gcf,["/home/antonybazir/Documents/Post-doc/Redac/metvar/ref_SO_ctrline.pdf"], "-dpdflatex","-S240,180","-FCalibri:24");
close

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%starv conf
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all
close all
load('starv/Id','LD_r','S_r','O_r','Grid_r','sz','dx')

figure
hold on
for i=1:size(LD_r,3)
  area(i) = length(find(LD_r(:,:,i)));
  live(i) = length(find(LD_r(:,:,i)==1));
  dead(i) = length(find(LD_r(:,:,i)==-1));
endfor
plot((1:size(LD_r,3))*10,area)
plot((1:size(LD_r,3))*10,live)
plot((1:size(LD_r,3))*10,dead)
ylabel('Cell number')
xlabel('Minutes')
set(gca,'outerposition',[0 0.05 0.9 0.9])
print(gcf,["/home/antonybazir/Documents/Post-doc/Redac/metvar/starv_area.pdf"], "-dpdflatex","-S240,180","-FCalibri:24");
close

figure
imagesc(dx*(-round(sz/2)+1:round(sz/2))*1e-3,dx*(-round(sz/2)+1:round(sz/2))*1e-3,Grid_r(:,:,size(Grid_r,3)))
ylabel('position (mm)')
xlabel('position (mm)')
set(gca,'outerposition',[0 0.05 0.9 0.9])
print(gcf,["/home/antonybazir/Documents/Post-doc/Redac/metvar/starv_Grid.pdf"], "-dpdflatex","-S240,180","-FCalibri:24");
close

figure
hold on
for i=1:size(S_r,3)
  i
  S_ctr(i) = S_r(round(sz/2),round(sz/2),i);
  O_ctr(i) = O_r(round(sz/2),round(sz/2),i);
endfor
plot((1:size(LD_r,3))*10,S_ctr)
plot((1:size(LD_r,3))*10,O_ctr)
ylabel('Concentration')
xlabel('Minutes')
set(gca,'outerposition',[0 0.05 0.9 0.9])
print(gcf,["/home/antonybazir/Documents/Post-doc/Redac/metvar/starv_SO_ctr.pdf"], "-dpdflatex","-S240,180","-FCalibri:24");
close

figure
hold on
plot(dx*(-round(sz/2)+1:round(sz/2))*1e-3,S_r(round(sz/2),:,size(S_r,3)))
plot(dx*(-round(sz/2)+1:round(sz/2))*1e-3,O_r(round(sz/2),:,size(O_r,3)))
ylabel('Concentration')
xlabel('position (mm)')
set(gca,'outerposition',[0 0.05 0.9 0.9])
print(gcf,["/home/antonybazir/Documents/Post-doc/Redac/metvar/starv_SO_ctrline.pdf"], "-dpdflatex","-S240,180","-FCalibri:24");
close

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%OS conf
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all
close all
LD_f = load('OS_fragile/Id','LD_r').LD_r;
LD_s = load('OS_hypos_tol/Id','LD_r').LD_r;
LD_o = load('OS_hypox_tol/Id','LD_r').LD_r;
LD_b = load('OS_hypox_boost/Id','LD_r').LD_r;

figure
hold on
for i=1:size(LD_f,3)
  area_f(i) = length(find(LD_f(:,:,i)));
  live_f(i) = length(find(LD_f(:,:,i)==1));
  dead_f(i) = length(find(LD_f(:,:,i)==-1));
endfor
for i=1:size(LD_s,3)
  area_s(i) = length(find(LD_s(:,:,i)));
  live_s(i) = length(find(LD_s(:,:,i)==1));
  dead_s(i) = length(find(LD_s(:,:,i)==-1));
endfor
for i=1:size(LD_o,3)
  area_o(i) = length(find(LD_o(:,:,i)));
  live_o(i) = length(find(LD_o(:,:,i)==1));
  dead_o(i) = length(find(LD_o(:,:,i)==-1));
endfor
for i=1:size(LD_b,3)
  area_b(i) = length(find(LD_b(:,:,i)));
  live_b(i) = length(find(LD_b(:,:,i)==1));
  dead_b(i) = length(find(LD_b(:,:,i)==-1));
endfor

figure;
hold on
plot((1:size(LD_f,3))*10,area_f);
plot((1:size(LD_s,3))*10,area_s);
plot((1:size(LD_b,3))*10,area_b);
plot((1:size(LD_o,3))*10,area_o);
ylabel('Cell number')
xlabel('Minutes')
set(gca,'outerposition',[0 0.05 0.9 0.9])
print(gcf,["/home/antonybazir/Documents/Post-doc/Redac/metvar/OS_area.pdf"], "-dpdflatex","-S240,180","-FCalibri:24");
close



