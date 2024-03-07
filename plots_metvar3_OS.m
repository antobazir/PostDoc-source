%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%OS conf population
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all
close all
LD_f = load('OS_fragile/Id','LD_r').LD_r;
LD_s = load('OS_hypos_tol/Id','LD_r').LD_r;
LD_o = load('OS_hypox_tol/Id','LD_r').LD_r;
LD_b = load('OS_hypox_boost/Id','LD_r').LD_r;
st_m_f = load('OS_fragile/Id','state_mat_r').state_mat_r;
st_m_s = load('OS_hypos_tol/Id','state_mat_r').state_mat_r;
st_m_o = load('OS_hypox_tol/Id','state_mat_r').state_mat_r;
st_m_b = load('OS_hypox_boost/Id','state_mat_r').state_mat_r;

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

for i=1:size(st_m_f,3)
  quiesc_f(i) = length(find(or(st_m_f(:,:,i)==3,st_m_f(:,:,i)==4)));
endfor
for i=1:size(st_m_s,3)
  quiesc_s(i) = length(find(or(st_m_o(:,:,i)==4,st_m_o(:,:,i)==2)));
endfor
for i=1:size(st_m_o,3)
  quiesc_o(i) = length(find(or(st_m_o(:,:,i)==3,st_m_o(:,:,i)==2)));
endfor
for i=1:size(st_m_b,3)
  quiesc_b(i) = length(find(st_m_b(:,:,i)==3));
endfor

figure;
hold on
plot((1:size(LD_f,3))*10,area_f);
plot((1:size(LD_s,3))*10,area_s);
plot((1:size(LD_o,3))*10,area_o);
plot((1:size(LD_b,3))*10,area_b);
ylabel('Cell number')
xlabel('Minutes')
set(gca,'outerposition',[0 0.05 0.9 0.9])
print(gcf,["/home/antonybazir/Documents/Post-doc/Redac/metvar/OS_area.pdf"], "-dpdflatex","-S240,180","-FCalibri:24");
close

figure;
hold on
plot((1:size(LD_f,3))*10,live_f);
plot((1:size(LD_s,3))*10,live_s);
plot((1:size(LD_o,3))*10,live_o);
plot((1:size(LD_b,3))*10,live_b);
ylabel('Cell number')
xlabel('Minutes')
set(gca,'outerposition',[0 0.05 0.9 0.9])
print(gcf,["/home/antonybazir/Documents/Post-doc/Redac/metvar/OS_live.pdf"], "-dpdflatex","-S240,180","-FCalibri:24");
close

figure;
hold on
plot((1:size(st_m_f,3))*10,quiesc_f);
plot((1:size(st_m_s,3))*10,quiesc_s);
plot((1:size(st_m_o,3))*10,quiesc_o);
plot((1:size(st_m_b,3))*10,quiesc_b);
ylabel('Cell number')
xlabel('Minutes')
set(gca,'outerposition',[0 0.05 0.9 0.9])
print(gcf,["/home/antonybazir/Documents/Post-doc/Redac/metvar/OS_quiesc.pdf"], "-dpdflatex","-S240,180","-FCalibri:24");
close

figure;
hold on
plot((1:size(LD_f,3))*10,dead_f);
plot((1:size(LD_s,3))*10,dead_s);
plot((1:size(LD_o,3))*10,dead_o);
plot((1:size(LD_b,3))*10,dead_b);
ylabel('Cell number')
xlabel('Minutes')
set(gca,'outerposition',[0 0.05 0.9 0.9])
print(gcf,["/home/antonybazir/Documents/Post-doc/Redac/metvar/OS_dead.pdf"], "-dpdflatex","-S240,180","-FCalibri:24");
close

%Gl%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all
close all
LD_f = load('OS_fragile/Gl','LD_r').LD_r;
LD_s = load('OS_hypos_tol/Gl','LD_r').LD_r;
LD_o = load('OS_hypox_tol/Gl','LD_r').LD_r;
LD_b = load('OS_hypox_boost/Gl','LD_r').LD_r;

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
plot((1:size(LD_o,3))*10,area_o);
plot((1:size(LD_b,3))*10,area_b);
ylabel('Cell number')
xlabel('Minutes')
set(gca,'outerposition',[0 0.05 0.9 0.9])
print(gcf,["/home/antonybazir/Documents/Post-doc/Redac/metvar/Su_OS_area.pdf"], "-dpdflatex","-S240,180","-FCalibri:24");
close

figure;
hold on
plot((1:size(LD_f,3))*10,live_f);
plot((1:size(LD_s,3))*10,live_s);
plot((1:size(LD_o,3))*10,live_o);
plot((1:size(LD_b,3))*10,live_b);
ylabel('Cell number')
xlabel('Minutes')
set(gca,'outerposition',[0 0.05 0.9 0.9])
print(gcf,["/home/antonybazir/Documents/Post-doc/Redac/metvar/Su_OS_live.pdf"], "-dpdflatex","-S240,180","-FCalibri:24");
close

figure;
hold on
plot((1:size(LD_f,3))*10,dead_f);
plot((1:size(LD_s,3))*10,dead_s);
plot((1:size(LD_o,3))*10,dead_o);
plot((1:size(LD_b,3))*10,dead_b);
set(gca,'outerposition',[0 0.05 0.9 0.9])
print(gcf,["/home/antonybazir/Documents/Post-doc/Redac/metvar/Su_OS_dead.pdf"], "-dpdflatex","-S240,180","-FCalibri:24");
close

%Ox%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all
close all
LD_f = load('OS_fragile/Ox','LD_r').LD_r;
LD_s = load('OS_hypos_tol/Ox','LD_r').LD_r;
LD_o = load('OS_hypox_tol/Ox','LD_r').LD_r;
LD_b = load('OS_hypox_boost/Ox','LD_r').LD_r;

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
plot((1:size(LD_o,3))*10,area_o);
plot((1:size(LD_b,3))*10,area_b);
ylabel('Cell number')
xlabel('Minutes')
set(gca,'outerposition',[0 0.05 0.9 0.9])
print(gcf,["/home/antonybazir/Documents/Post-doc/Redac/metvar/Ox_OS_area.pdf"], "-dpdflatex","-S240,180","-FCalibri:24");
close

figure;
hold on
plot((1:size(LD_f,3))*10,live_f);
plot((1:size(LD_s,3))*10,live_s);
plot((1:size(LD_o,3))*10,live_o);
plot((1:size(LD_b,3))*10,live_b);
ylabel('Cell number')
xlabel('Minutes')
set(gca,'outerposition',[0 0.05 0.9 0.9])
print(gcf,["/home/antonybazir/Documents/Post-doc/Redac/metvar/Ox_OS_live.pdf"], "-dpdflatex","-S240,180","-FCalibri:24");
close

figure;
hold on
plot((1:size(LD_f,3))*10,dead_f);
plot((1:size(LD_s,3))*10,dead_s);
plot((1:size(LD_o,3))*10,dead_o);
plot((1:size(LD_b,3))*10,dead_b);
set(gca,'outerposition',[0 0.05 0.9 0.9])
print(gcf,["/home/antonybazir/Documents/Post-doc/Redac/metvar/Ox_OS_dead.pdf"], "-dpdflatex","-S240,180","-FCalibri:24");
close

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%OS conf pnutrients
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Id%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all
close all
load('OS_fragile/Id','sz','dx')
S_f = load('OS_fragile/Id','S_r').S_r;
S_s = load('OS_hypos_tol/Id','S_r').S_r;
S_o = load('OS_hypox_tol/Id','S_r').S_r;
S_b = load('OS_hypox_boost/Id','S_r').S_r;
O_f = load('OS_fragile/Id','O_r').O_r;
O_s = load('OS_hypos_tol/Id','O_r').O_r;
O_o = load('OS_hypox_tol/Id','O_r').O_r;
O_b = load('OS_hypox_boost/Id','O_r').O_r;

figure
hold on
for i=1:size(S_f,3)
  S_ctr_f(i) = S_f(round(sz/2),round(sz/2),i);
endfor

for i=1:size(S_s,3)
  S_ctr_s(i) = S_s(round(sz/2),round(sz/2),i);
endfor

for i=1:size(S_o,3)
  S_ctr_o(i) = S_o(round(sz/2),round(sz/2),i);
endfor

for i=1:size(S_b,3)
  S_ctr_b(i) = S_b(round(sz/2),round(sz/2),i);
endfor

plot((1:size(S_f,3))*10,S_ctr_f);
plot((1:size(S_s,3))*10,S_ctr_s);
plot((1:size(S_o,3))*10,S_ctr_o);
plot((1:size(S_b,3))*10,S_ctr_b);
ylabel('Concentration')
xlabel('Minutes')
set(gca,'outerposition',[0 0.05 0.9 0.9])
print(gcf,["/home/antonybazir/Documents/Post-doc/Redac/metvar/OS_S_ctr.pdf"], "-dpdflatex","-S240,180","-FCalibri:24");
close

figure
hold on
for i=1:size(O_f,3)
  O_ctr_f(i) = O_f(round(sz/2),round(sz/2),i);
endfor

for i=1:size(O_s,3)
  O_ctr_s(i) = O_s(round(sz/2),round(sz/2),i);
endfor

for i=1:size(O_o,3)
  O_ctr_o(i) = O_o(round(sz/2),round(sz/2),i);
endfor

for i=1:size(O_b,3)
  O_ctr_b(i) = O_b(round(sz/2),round(sz/2),i);
endfor

plot((1:size(O_f,3))*10,O_ctr_f);
plot((1:size(O_s,3))*10,O_ctr_s);
plot((1:size(O_o,3))*10,O_ctr_o);
plot((1:size(O_b,3))*10,O_ctr_b);
ylabel('Concentration')
xlabel('Minutes')
set(gca,'outerposition',[0 0.05 0.9 0.9])
print(gcf,["/home/antonybazir/Documents/Post-doc/Redac/metvar/OS_O_ctr.pdf"], "-dpdflatex","-S240,180","-FCalibri:24");
close

figure
hold on
plot(dx*(-round(sz/2)+1:round(sz/2))*1e-3,S_f(round(sz/2),:,size(S_f,3)))
plot(dx*(-round(sz/2)+1:round(sz/2))*1e-3,S_s(round(sz/2),:,size(S_s,3)))
plot(dx*(-round(sz/2)+1:round(sz/2))*1e-3,S_o(round(sz/2),:,size(S_o,3)))
plot(dx*(-round(sz/2)+1:round(sz/2))*1e-3,S_b(round(sz/2),:,size(S_b,3)))
ylabel('Concentration')
xlabel('position (mm)')
set(gca,'outerposition',[0 0.05 0.9 0.9])
print(gcf,["/home/antonybazir/Documents/Post-doc/Redac/metvar/OS_S_ctrline.pdf"], "-dpdflatex","-S240,180","-FCalibri:24");
close


figure
hold on
plot(dx*(-round(sz/2)+1:round(sz/2))*1e-3,O_f(round(sz/2),:,size(O_f,3)))
plot(dx*(-round(sz/2)+1:round(sz/2))*1e-3,O_s(round(sz/2),:,size(O_s,3)))
plot(dx*(-round(sz/2)+1:round(sz/2))*1e-3,O_o(round(sz/2),:,size(O_o,3)))
plot(dx*(-round(sz/2)+1:round(sz/2))*1e-3,O_b(round(sz/2),:,size(O_b,3)))
ylabel('Concentration')
xlabel('position (mm)')
set(gca,'outerposition',[0 0.05 0.9 0.9])
print(gcf,["/home/antonybazir/Documents/Post-doc/Redac/metvar/OS_O_ctrline.pdf"], "-dpdflatex","-S240,180","-FCalibri:24");
close

%Su%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all
close all
load('OS_fragile/Gl','sz','dx')
S_f = load('OS_fragile/Gl','S_r').S_r;
S_s = load('OS_hypos_tol/Gl','S_r').S_r;
S_o = load('OS_hypox_tol/Gl','S_r').S_r;
S_b = load('OS_hypox_boost/Gl','S_r').S_r;
O_f = load('OS_fragile/Gl','O_r').O_r;
O_s = load('OS_hypos_tol/Gl','O_r').O_r;
O_o = load('OS_hypox_tol/Gl','O_r').O_r;
O_b = load('OS_hypox_boost/Gl','O_r').O_r;

figure
hold on
for i=1:size(S_f,3)
  S_ctr_f(i) = S_f(round(sz/2),round(sz/2),i);
endfor

for i=1:size(S_s,3)
  S_ctr_s(i) = S_s(round(sz/2),round(sz/2),i);
endfor

for i=1:size(S_o,3)
  S_ctr_o(i) = S_o(round(sz/2),round(sz/2),i);
endfor

for i=1:size(S_b,3)
  S_ctr_b(i) = S_b(round(sz/2),round(sz/2),i);
endfor

plot((1:size(S_f,3))*10,S_ctr_f);
plot((1:size(S_s,3))*10,S_ctr_s);
plot((1:size(S_o,3))*10,S_ctr_o);
plot((1:size(S_b,3))*10,S_ctr_b);
ylabel('Concentration')
xlabel('Minutes')
set(gca,'outerposition',[0 0.05 0.9 0.9])
print(gcf,["/home/antonybazir/Documents/Post-doc/Redac/metvar/Su_OS_S_ctr.pdf"], "-dpdflatex","-S240,180","-FCalibri:24");
close

figure
hold on
for i=1:size(O_f,3)
  O_ctr_f(i) = O_f(round(sz/2),round(sz/2),i);
endfor

for i=1:size(O_s,3)
  O_ctr_s(i) = O_s(round(sz/2),round(sz/2),i);
endfor

for i=1:size(O_o,3)
  O_ctr_o(i) = O_o(round(sz/2),round(sz/2),i);
endfor

for i=1:size(O_b,3)
  O_ctr_b(i) = O_b(round(sz/2),round(sz/2),i);
endfor

plot((1:size(O_f,3))*10,O_ctr_f);
plot((1:size(O_s,3))*10,O_ctr_s);
plot((1:size(O_o,3))*10,O_ctr_o);
plot((1:size(O_b,3))*10,O_ctr_b);
ylabel('Concentration')
xlabel('Minutes')
set(gca,'outerposition',[0 0.05 0.9 0.9])
print(gcf,["/home/antonybazir/Documents/Post-doc/Redac/metvar/Su_OS_O_ctr.pdf"], "-dpdflatex","-S240,180","-FCalibri:24");
close

figure
hold on
plot(dx*(-round(sz/2)+1:round(sz/2))*1e-3,S_f(round(sz/2),:,size(S_f,3)))
plot(dx*(-round(sz/2)+1:round(sz/2))*1e-3,S_s(round(sz/2),:,size(S_s,3)))
plot(dx*(-round(sz/2)+1:round(sz/2))*1e-3,S_o(round(sz/2),:,size(S_o,3)))
plot(dx*(-round(sz/2)+1:round(sz/2))*1e-3,S_b(round(sz/2),:,size(S_b,3)))
ylabel('Concentration')
xlabel('position (mm)')
set(gca,'outerposition',[0 0.05 0.9 0.9])
print(gcf,["/home/antonybazir/Documents/Post-doc/Redac/metvar/Su_OS_S_ctrline.pdf"], "-dpdflatex","-S240,180","-FCalibri:24");
close


figure
hold on
plot(dx*(-round(sz/2)+1:round(sz/2))*1e-3,O_f(round(sz/2),:,size(O_f,3)))
plot(dx*(-round(sz/2)+1:round(sz/2))*1e-3,O_s(round(sz/2),:,size(O_s,3)))
plot(dx*(-round(sz/2)+1:round(sz/2))*1e-3,O_o(round(sz/2),:,size(O_o,3)))
plot(dx*(-round(sz/2)+1:round(sz/2))*1e-3,O_b(round(sz/2),:,size(O_b,3)))
ylabel('Concentration')
xlabel('position (mm)')
set(gca,'outerposition',[0 0.05 0.9 0.9])
print(gcf,["/home/antonybazir/Documents/Post-doc/Redac/metvar/Su_OS_O_ctrline.pdf"], "-dpdflatex","-S240,180","-FCalibri:24");
close

%Ox%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all
close all
load('OS_fragile/Ox','sz','dx')
S_f = load('OS_fragile/Ox','S_r').S_r;
S_s = load('OS_hypos_tol/Ox','S_r').S_r;
S_o = load('OS_hypox_tol/Ox','S_r').S_r;
S_b = load('OS_hypox_boost/Ox','S_r').S_r;
O_f = load('OS_fragile/Ox','O_r').O_r;
O_s = load('OS_hypos_tol/Ox','O_r').O_r;
O_o = load('OS_hypox_tol/Ox','O_r').O_r;
O_b = load('OS_hypox_boost/Ox','O_r').O_r;

figure
hold on
for i=1:size(S_f,3)
  S_ctr_f(i) = S_f(round(sz/2),round(sz/2),i);
endfor

for i=1:size(S_s,3)
  S_ctr_s(i) = S_s(round(sz/2),round(sz/2),i);
endfor

for i=1:size(S_o,3)
  S_ctr_o(i) = S_o(round(sz/2),round(sz/2),i);
endfor

for i=1:size(S_b,3)
  S_ctr_b(i) = S_b(round(sz/2),round(sz/2),i);
endfor

plot((1:size(S_f,3))*10,S_ctr_f);
plot((1:size(S_s,3))*10,S_ctr_s);
plot((1:size(S_o,3))*10,S_ctr_o);
plot((1:size(S_b,3))*10,S_ctr_b);
ylabel('Concentration')
xlabel('Minutes')
set(gca,'outerposition',[0 0.05 0.9 0.9])
print(gcf,["/home/antonybazir/Documents/Post-doc/Redac/metvar/Ox_OS_S_ctr.pdf"], "-dpdflatex","-S240,180","-FCalibri:24");
close

figure
hold on
for i=1:size(O_f,3)
  O_ctr_f(i) = O_f(round(sz/2),round(sz/2),i);
endfor

for i=1:size(O_s,3)
  O_ctr_s(i) = O_s(round(sz/2),round(sz/2),i);
endfor

for i=1:size(O_o,3)
  O_ctr_o(i) = O_o(round(sz/2),round(sz/2),i);
endfor

for i=1:size(O_b,3)
  O_ctr_b(i) = O_b(round(sz/2),round(sz/2),i);
endfor

plot((1:size(O_f,3))*10,O_ctr_f);
plot((1:size(O_s,3))*10,O_ctr_s);
plot((1:size(O_o,3))*10,O_ctr_o);
plot((1:size(O_b,3))*10,O_ctr_b);
ylabel('Concentration')
xlabel('Minutes')
set(gca,'outerposition',[0 0.05 0.9 0.9])
print(gcf,["/home/antonybazir/Documents/Post-doc/Redac/metvar/Ox_OS_O_ctr.pdf"], "-dpdflatex","-S240,180","-FCalibri:24");
close

figure
hold on
plot(dx*(-round(sz/2)+1:round(sz/2))*1e-3,S_f(round(sz/2),:,size(S_f,3)))
plot(dx*(-round(sz/2)+1:round(sz/2))*1e-3,S_s(round(sz/2),:,size(S_s,3)))
plot(dx*(-round(sz/2)+1:round(sz/2))*1e-3,S_o(round(sz/2),:,size(S_o,3)))
plot(dx*(-round(sz/2)+1:round(sz/2))*1e-3,S_b(round(sz/2),:,size(S_b,3)))
ylabel('Concentration')
xlabel('position (mm)')
set(gca,'outerposition',[0 0.05 0.9 0.9])
print(gcf,["/home/antonybazir/Documents/Post-doc/Redac/metvar/Ox_OS_S_ctrline.pdf"], "-dpdflatex","-S240,180","-FCalibri:24");
close


figure
hold on
plot(dx*(-round(sz/2)+1:round(sz/2))*1e-3,O_f(round(sz/2),:,size(O_f,3)))
plot(dx*(-round(sz/2)+1:round(sz/2))*1e-3,O_s(round(sz/2),:,size(O_s,3)))
plot(dx*(-round(sz/2)+1:round(sz/2))*1e-3,O_o(round(sz/2),:,size(O_o,3)))
plot(dx*(-round(sz/2)+1:round(sz/2))*1e-3,O_b(round(sz/2),:,size(O_b,3)))
ylabel('Concentration')
xlabel('position (mm)')
set(gca,'outerposition',[0 0.05 0.9 0.9])
print(gcf,["/home/antonybazir/Documents/Post-doc/Redac/metvar/Ox_OS_O_ctrline.pdf"], "-dpdflatex","-S240,180","-FCalibri:24");
close
