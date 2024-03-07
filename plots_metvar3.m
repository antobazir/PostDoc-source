%all the plots needed for metvar3

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%ref conf
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all
close all
load('ref_conf/Id','LD_r','S_r','O_r','Grid_r','sz','dx')

figure
hold on
for i=1:size(LD_r,3)
  area(i) = length(find(Grid_r(:,:,i)));
  rad(i) = max(state_story{i}(:,10));
endfor
plot((1:size(LD_r,3))*10,area)
plot((1:size(rad,2))*10,rad)
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
for i=1:size(S_r,2)
  S_ctr(i) = S_r{i}(25,25);
  DSm_ctr(i) = DSm_r{i}(25,25);
  kS_ctr(i) = kS_r{i}(25,25);
endfor
plot((1:size(S_r,2)),S_ctr,'x-')
plot((1:size(DSm_r,2)),DSm_ctr,'v-')
plot((1:size(kS_r,2)),kS_ctr,'+-')


figure
hold on
for i=1:size(DSm_r,2)
  DSm_ctr(i) = DSm_r{i}(25,25);
endfor
plot((1:size(DSm_r,2)),DSm_ctr)



figure
hold on
for i=1:size(kS_r,2)
  kS_ctr(i) = kS_r{i}(25,25);
endfor
plot((1:size(kS_r,2)),kS_ctr)


figure
hold on
for i=1:size(S_r,3)
  i
  S_ctr(i) = S_r(round(sz/2),round(sz/2),i);
  P_ctr(i) = P_r(round(sz/2),round(sz/2),i);
  O_ctr(i) = O_r(round(sz/2),round(sz/2),i);
endfor
plot((1:size(LD_r,3))*10,S_ctr)
plot((1:size(LD_r,3))*10,O_ctr)
plot((1:size(LD_r,3))*10,P_ctr)
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
%savy conf
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all
close all
load('savy/Id','LD_r','S_r','O_r','Grid_r','sz','dx')

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
print(gcf,["/home/antonybazir/Documents/Post-doc/Redac/metvar/savy_area.pdf"], "-dpdflatex","-S240,180","-FCalibri:24");
close

figure
imagesc(dx*(-round(sz/2)+1:round(sz/2))*1e-3,dx*(-round(sz/2)+1:round(sz/2))*1e-3,Grid_r(:,:,size(Grid_r,3)))
ylabel('position (mm)')
xlabel('position (mm)')
set(gca,'outerposition',[0 0.05 0.9 0.9])
print(gcf,["/home/antonybazir/Documents/Post-doc/Redac/metvar/savy_Grid.pdf"], "-dpdflatex","-S240,180","-FCalibri:24");
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
print(gcf,["/home/antonybazir/Documents/Post-doc/Redac/metvar/savy_SO_ctr.pdf"], "-dpdflatex","-S240,180","-FCalibri:24");
close

figure
hold on
plot(dx*(-round(sz/2)+1:round(sz/2))*1e-3,S_r(round(sz/2),:,size(S_r,3)))
plot(dx*(-round(sz/2)+1:round(sz/2))*1e-3,O_r(round(sz/2),:,size(O_r,3)))
ylabel('Concentration')
xlabel('position (mm)')
set(gca,'outerposition',[0 0.05 0.9 0.9])
print(gcf,["/home/antonybazir/Documents/Post-doc/Redac/metvar/savy_SO_ctrline.pdf"], "-dpdflatex","-S240,180","-FCalibri:24");
close



