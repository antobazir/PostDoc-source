#plots from data from C code
clear all;
close all;

%Id
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
OSf_num = load('../plots/OS_fragile/Numbers/Id.dat')
hypos_tol_num = load('../plots/OS_hypos_tol/Numbers/Id.dat')
hypox_tol_num = load('../plots/OS_hypox_tol/Numbers/Id.dat')
hypox_boost_num = load('../plots/OS_hypox_boost/Numbers/Id.dat')
figure
hold on
plot(OSf_num(:,1)/60,OSf_num(:,3),'color','blue')
plot(hypos_tol_num(:,1)/60,hypos_tol_num(:,3),'color','red')
plot(hypox_tol_num(:,1)/60,hypox_tol_num(:,3),'color','green')
plot(hypox_boost_num(:,1)/60,hypox_boost_num(:,3),'color','magenta')
box
grid
xlabel("time (hrs)")
ylabel("Live cells")
set(gca,'outerposition',[0 0.05 0.9 1])
print(gcf,["/home/antonybazir/Documents/Post-doc/Présentation/Apr2024/OS_live_Id.pdf"], "-dpdflatex","-S180,100","-FCalibri:20");
close

figure
hold on
plot(OSf_num(:,1)/60,OSf_num(:,4),'color','blue')
plot(hypos_tol_num(:,1)/60,hypos_tol_num(:,4),'color','red')
plot(hypox_tol_num(:,1)/60,hypox_tol_num(:,4),'color','green')
plot(hypox_boost_num(:,1)/60,hypox_boost_num(:,4),'color','magenta')
box
grid
xlabel("time (hrs)")
ylabel("Dead cells")
set(gca,'outerposition',[0 0.05 0.9 1])
print(gcf,["/home/antonybazir/Documents/Post-doc/Présentation/Apr2024/OS_dead_Id.pdf"], "-dpdflatex","-S180,100","-FCalibri:20");
close


OSf_num = load('../plots/OS_fragile/S_center/Id.dat')
hypos_tol_num = load('../plots/OS_hypos_tol/S_center/Id.dat')
hypox_tol_num = load('../plots/OS_hypox_tol/S_center/Id.dat')
hypox_boost_num = load('../plots/OS_hypox_boost/S_center/Id.dat')
figure
hold on
plot(OSf_num(:,1)/60,OSf_num(:,2),'color','blue')
plot(hypos_tol_num(:,1)/60,hypos_tol_num(:,2),'color','red')
plot(hypox_tol_num(:,1)/60,hypox_tol_num(:,2),'color','green')
plot(hypox_boost_num(:,1)/60,hypox_boost_num(:,2),'color','magenta')
box
grid
xlabel("time (hrs)")
ylabel("Concentration")
set(gca,'outerposition',[0 0.05 0.9 1])
print(gcf,["/home/antonybazir/Documents/Post-doc/Présentation/Apr2024/OS_S_Id.pdf"], "-dpdflatex","-S180,100","-FCalibri:20");
close

OSf_num = load('../plots/OS_fragile/O_center/Id.dat')
hypos_tol_num = load('../plots/OS_hypos_tol/O_center/Id.dat')
hypox_tol_num = load('../plots/OS_hypox_tol/O_center/Id.dat')
hypox_boost_num = load('../plots/OS_hypox_boost/O_center/Id.dat')
figure
hold on
plot(OSf_num(:,1)/60,OSf_num(:,2),'color','blue')
plot(hypos_tol_num(:,1)/60,hypos_tol_num(:,2),'color','red')
plot(hypox_tol_num(:,1)/60,hypox_tol_num(:,2),'color','green')
plot(hypox_boost_num(:,1)/60,hypox_boost_num(:,2),'color','magenta')
box
grid
xlabel("time (hrs)")
ylabel("Concentration")
set(gca,'outerposition',[0 0.05 0.9 1])
print(gcf,["/home/antonybazir/Documents/Post-doc/Présentation/Apr2024/OS_O_Id.pdf"], "-dpdflatex","-S180,100","-FCalibri:20");
close

%Ox
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
OSf_num = load('../plots/OS_fragile/Numbers/Ox.dat')
hypos_tol_num = load('../plots/OS_hypos_tol/Numbers/Ox.dat')
hypox_tol_num = load('../plots/OS_hypox_tol/Numbers/Ox.dat')
hypox_boost_num = load('../plots/OS_hypox_boost/Numbers/Ox.dat')
figure
hold on
plot(OSf_num(:,1)/60,OSf_num(:,3),'color','blue')
plot(hypos_tol_num(:,1)/60,hypos_tol_num(:,3),'color','red')
plot(hypox_tol_num(:,1)/60,hypox_tol_num(:,3),'color','green')
plot(hypox_boost_num(:,1)/60,hypox_boost_num(:,3),'color','magenta')
box
grid
xlabel("time (hrs)")
ylabel("Live cells")
set(gca,'outerposition',[0 0.05 0.9 1])
print(gcf,["/home/antonybazir/Documents/Post-doc/Présentation/Apr2024/OS_live_Ox.pdf"], "-dpdflatex","-S180,100","-FCalibri:20");
close

figure
hold on
plot(OSf_num(:,1)/60,OSf_num(:,4),'color','blue')
plot(hypos_tol_num(:,1)/60,hypos_tol_num(:,4),'color','red')
plot(hypox_tol_num(:,1)/60,hypox_tol_num(:,4),'color','green')
plot(hypox_boost_num(:,1)/60,hypox_boost_num(:,4),'color','magenta')
box
grid
xlabel("time (hrs)")
ylabel("Dead cells")
set(gca,'outerposition',[0 0.05 0.9 1])
print(gcf,["/home/antonybazir/Documents/Post-doc/Présentation/Apr2024/OS_dead_Ox.pdf"], "-dpdflatex","-S180,100","-FCalibri:20");
close


OSf_num = load('../plots/OS_fragile/S_center/Ox.dat')
hypos_tol_num = load('../plots/OS_hypos_tol/S_center/Ox.dat')
hypox_tol_num = load('../plots/OS_hypox_tol/S_center/Ox.dat')
hypox_boost_num = load('../plots/OS_hypox_boost/S_center/Ox.dat')
figure
hold on
plot(OSf_num(:,1)/60,OSf_num(:,2),'color','blue')
plot(hypos_tol_num(:,1)/60,hypos_tol_num(:,2),'color','red')
plot(hypox_tol_num(:,1)/60,hypox_tol_num(:,2),'color','green')
plot(hypox_boost_num(:,1)/60,hypox_boost_num(:,2),'color','magenta')
box
grid
xlabel("time (hrs)")
ylabel("Concentration")
set(gca,'outerposition',[0 0.05 0.9 1])
print(gcf,["/home/antonybazir/Documents/Post-doc/Présentation/Apr2024/OS_S_Ox.pdf"], "-dpdflatex","-S180,100","-FCalibri:20");
close

OSf_num = load('../plots/OS_fragile/O_center/Ox.dat')
hypos_tol_num = load('../plots/OS_hypos_tol/O_center/Ox.dat')
hypox_tol_num = load('../plots/OS_hypox_tol/O_center/Ox.dat')
hypox_boost_num = load('../plots/OS_hypox_boost/O_center/Ox.dat')
figure
hold on
plot(OSf_num(:,1)/60,OSf_num(:,2),'color','blue')
plot(hypos_tol_num(:,1)/60,hypos_tol_num(:,2),'color','red')
plot(hypox_tol_num(:,1)/60,hypox_tol_num(:,2),'color','green')
plot(hypox_boost_num(:,1)/60,hypox_boost_num(:,2),'color','magenta')
box
grid
xlabel("time (hrs)")
ylabel("Concentration")
set(gca,'outerposition',[0 0.05 0.9 1])
print(gcf,["/home/antonybazir/Documents/Post-doc/Présentation/Apr2024/OS_O_Ox.pdf"], "-dpdflatex","-S180,100","-FCalibri:20");
close


%Gl
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
OSf_num = load('../plots/OS_fragile/Numbers/Gl.dat')
hypos_tol_num = load('../plots/OS_hypos_tol/Numbers/Gl.dat')
hypox_tol_num = load('../plots/OS_hypox_tol/Numbers/Gl.dat')
hypox_boost_num = load('../plots/OS_hypox_boost/Numbers/Gl.dat')
figure
hold on
plot(OSf_num(:,1)/60,OSf_num(:,3),'color','blue')
plot(hypos_tol_num(:,1)/60,hypos_tol_num(:,3),'color','red')
plot(hypox_tol_num(:,1)/60,hypox_tol_num(:,3),'color','green')
plot(hypox_boost_num(:,1)/60,hypox_boost_num(:,3),'color','magenta')
box
grid
xlabel("time (hrs)")
ylabel("Live cells")
set(gca,'outerposition',[0 0.05 0.9 1])
print(gcf,["/home/antonybazir/Documents/Post-doc/Présentation/Apr2024/OS_live_Gl.pdf"], "-dpdflatex","-S180,100","-FCalibri:20");
close

figure
hold on
plot(OSf_num(:,1)/60,OSf_num(:,4),'color','blue')
plot(hypos_tol_num(:,1)/60,hypos_tol_num(:,4),'color','red')
plot(hypox_tol_num(:,1)/60,hypox_tol_num(:,4),'color','green')
plot(hypox_boost_num(:,1)/60,hypox_boost_num(:,4),'color','magenta')
box
grid
xlabel("time (hrs)")
ylabel("Dead cells")
set(gca,'outerposition',[0 0.05 0.9 1])
print(gcf,["/home/antonybazir/Documents/Post-doc/Présentation/Apr2024/OS_dead_Gl.pdf"], "-dpdflatex","-S180,100","-FCalibri:20");
close

OSf_num = load('../plots/OS_fragile/S_center/Gl.dat')
hypos_tol_num = load('../plots/OS_hypos_tol/S_center/Gl.dat')
hypox_tol_num = load('../plots/OS_hypox_tol/S_center/Gl.dat')
hypox_boost_num = load('../plots/OS_hypox_boost/S_center/Gl.dat')
figure
hold on
plot(OSf_num(:,1)/60,OSf_num(:,2),'color','blue')
plot(hypos_tol_num(:,1)/60,hypos_tol_num(:,2),'color','red')
plot(hypox_tol_num(:,1)/60,hypox_tol_num(:,2),'color','green')
plot(hypox_boost_num(:,1)/60,hypox_boost_num(:,2),'color','magenta')
box
grid
xlabel("time (hrs)")
ylabel("Concentration")
set(gca,'outerposition',[0 0.05 0.9 1])
print(gcf,["/home/antonybazir/Documents/Post-doc/Présentation/Apr2024/OS_S_Gl.pdf"], "-dpdflatex","-S180,100","-FCalibri:20");
close

OSf_num = load('../plots/OS_fragile/O_center/Gl.dat')
hypos_tol_num = load('../plots/OS_hypos_tol/O_center/Gl.dat')
hypox_tol_num = load('../plots/OS_hypox_tol/O_center/Gl.dat')
hypox_boost_num = load('../plots/OS_hypox_boost/O_center/Gl.dat')
figure
hold on
plot(OSf_num(:,1)/60,OSf_num(:,2),'color','blue')
plot(hypos_tol_num(:,1)/60,hypos_tol_num(:,2),'color','red')
plot(hypox_tol_num(:,1)/60,hypox_tol_num(:,2),'color','green')
plot(hypox_boost_num(:,1)/60,hypox_boost_num(:,2),'color','magenta')
box
grid
xlabel("time (hrs)")
ylabel("Concentration")
set(gca,'outerposition',[0 0.05 0.9 1])
print(gcf,["/home/antonybazir/Documents/Post-doc/Présentation/Apr2024/OS_O_Gl.pdf"], "-dpdflatex","-S180,100","-FCalibri:20");
close

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%midline
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
S_mid = load('../plots/ref/S_midline/Id73.dat');
O_mid = load('../plots/ref/O_midline/Id73.dat');
figure; hold on;
box
grid
xlabel("position (mm)")
ylabel("Concentration")
plot(S_mid(:,1)*1e-3,S_mid(:,2),'color','blue','+-','linewidth',1,'markersize',2);
plot(O_mid(:,1)*1e-3,O_mid(:,2),'color','red','o-','linewidth',1,'markersize',2);
set(gca,'outerposition',[0 0.05 0.9 0.9])
print(gcf,["/home/antonybazir/Documents/Post-doc/Présentation/Apr2024/SO_ref_midline_Id.pdf"], "-dpdflatex","-S120,100","-FCalibri:20");
close

S_mid = load('../plots/ref/S_midline/Gl72.dat');
O_mid = load('../plots/ref/O_midline/Gl72.dat');
figure; hold on;
box
grid
xlabel("position (mm)")
ylabel("Concentration")
plot(S_mid(:,1)*1e-3,S_mid(:,2),'color','blue','+-','linewidth',1,'markersize',2);
plot(O_mid(:,1)*1e-3,O_mid(:,2),'color','red','o-','linewidth',1,'markersize',2);
set(gca,'outerposition',[0 0.05 0.9 0.9])
print(gcf,["/home/antonybazir/Documents/Post-doc/Présentation/Apr2024/SO_ref_midline_Gl.pdf"], "-dpdflatex","-S120,100","-FCalibri:20");
close

S_mid = load('../plots/ref/S_midline/Ox75.dat');
O_mid = load('../plots/ref/O_midline/Ox75.dat');
figure; hold on;
box
grid
xlabel("position (mm)")
ylabel("Concentration")
plot(S_mid(:,1)*1e-3,S_mid(:,2),'color','blue','+-','linewidth',1,'markersize',2);
plot(O_mid(:,1)*1e-3,O_mid(:,2),'color','red','o-','linewidth',1,'markersize',2);
set(gca,'outerposition',[0 0.05 0.9 0.9])
print(gcf,["/home/antonybazir/Documents/Post-doc/Présentation/Apr2024/SO_ref_midline_Ox.pdf"], "-dpdflatex","-S120,100","-FCalibri:20");
close

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Grid
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Grid = load('../plots/ref/Grid/Id76.dat');
figure; hold on
imagesc((-34:35)*20e-3,(-34:35)*20e-3,Grid)
%line(gca,[0 0],[0 -0.5],'color','red');
print(gcf,["/home/antonybazir/Documents/Post-doc/Redac/metvar/ref_Grid.pdf"], "-dpdflatex","-S120,100","-FCalibri:20");



figure
clear frames
for i=1:102
  i
  subplot(2,2,1)
  eval(['Grid = load("../plots/starv/Grid/Id' num2str(i) '.dat");'])
  imagesc((-34:35)*20e-3,(-34:35)*20e-3,Grid)
  xlabel("position (mm)")
  ylabel("position (mm)")


  subplot(2,2,2)
  eval(['S = load("../plots/starv/S/Id' num2str(i) '.dat");'])
  imagesc((-34:35)*20e-3,(-34:35)*20e-3,S)
  xlabel("position (mm)")
  ylabel("position (mm)")
  %caxis([0 1])


  subplot(2,2,3)
    eval(['state_mat = load("../plots/starv/state_mat/Id' num2str(i) '.dat");'])
  imagesc((-34:35)*20e-3,(-34:35)*20e-3,state_mat)
  xlabel("position (mm)")
  ylabel("position (mm)")


  subplot(2,2,4)
  eval(['O = load("../plots/starv/O/Id' num2str(i) '.dat");'])
  imagesc((-34:35)*20e-3,(-34:35)*20e-3,O)
  xlabel("position (mm)")
  ylabel("position (mm)")
  %caxis([0 1])
  frames(i)  = getframe(gcf);

   min(min(S))

endfor

figure
movie(frames,1)
imwrite(frame2im(frames),'../plots/starv/Id.gif','DelayTime',0.3,'Compression','jpeg','Quality',75);


figure
clear frames
for i=1:105
  i
  subplot(2,2,1)
  eval(['Grid = load("../plots/OS_fragile/Grid/Id' num2str(i) '.dat");'])
  imagesc((-34:35)*20e-3,(-34:35)*20e-3,Grid)
  xlabel("position (mm)")
  ylabel("position (mm)")


  subplot(2,2,2)
  eval(['S = load("../plots/OS_fragile/S/Id' num2str(i) '.dat");'])
  imagesc((-34:35)*20e-3,(-34:35)*20e-3,S)
  xlabel("position (mm)")
  ylabel("position (mm)")
  caxis([0 1])


  subplot(2,2,3)
    eval(['state_mat = load("../plots/OS_fragile/state_mat/Id' num2str(i) '.dat");'])
  imagesc((-34:35)*20e-3,(-34:35)*20e-3,state_mat)
  xlabel("position (mm)")
  ylabel("position (mm)")


  subplot(2,2,4)
  eval(['O = load("../plots/OS_fragile/O/Id' num2str(i) '.dat");'])
  imagesc((-34:35)*20e-3,(-34:35)*20e-3,O)
  xlabel("position (mm)")
  ylabel("position (mm)")
  caxis([0 1])
  frames(i)  = getframe(gcf);

   min(min(S))

endfor

figure
movie(frames,1)
imwrite(frame2im(frames),'../plots/OS_fragile/Id.gif','DelayTime',0.3,'Compression','jpeg','Quality',75);


figure
clear frames
for i=1:200
  i
  subplot(2,2,1)
  eval(['Grid = load("../plots/OS_hypox_boost/Grid/Id' num2str(i) '.dat");'])
  imagesc((-34:35)*20e-3,(-34:35)*20e-3,Grid)
  xlabel("position (mm)")
  ylabel("position (mm)")


  subplot(2,2,2)
  eval(['S = load("../plots/OS_hypox_boost/S/Id' num2str(i) '.dat");'])
  imagesc((-34:35)*20e-3,(-34:35)*20e-3,S)
  xlabel("position (mm)")
  ylabel("position (mm)")
  caxis([0 1])


  subplot(2,2,3)
    eval(['state_mat = load("../plots/OS_hypox_boost/state_mat/Id' num2str(i) '.dat");'])
  imagesc((-34:35)*20e-3,(-34:35)*20e-3,state_mat)
  xlabel("position (mm)")
  ylabel("position (mm)")


  subplot(2,2,4)
  eval(['O = load("../plots/OS_hypox_boost/O/Id' num2str(i) '.dat");'])
  imagesc((-34:35)*20e-3,(-34:35)*20e-3,O)
  xlabel("position (mm)")
  ylabel("position (mm)")
  caxis([0 1])
  frames(i)  = getframe(gcf);


endfor

figure
movie(frames,1)
imwrite(frame2im(frames),'../plots/OS_hypox_boost/Id.gif','DelayTime',0.3,'Compression','jpeg','Quality',75);

figure
clear frames
for i=1:124
  i
  subplot(2,2,1)
  eval(['Grid = load("../plots/OS_hypox_boost/Grid/Gl' num2str(i) '.dat");'])
  imagesc((-34:35)*20e-3,(-34:35)*20e-3,Grid)
  xlabel("position (mm)")
  ylabel("position (mm)")


  subplot(2,2,2)
  eval(['S = load("../plots/OS_hypox_boost/S/Gl' num2str(i) '.dat");'])
  imagesc((-34:35)*20e-3,(-34:35)*20e-3,S)
  xlabel("position (mm)")
  ylabel("position (mm)")
  caxis([0 1])


  subplot(2,2,3)
    eval(['state_mat = load("../plots/OS_hypox_boost/state_mat/Gl' num2str(i) '.dat");'])
  imagesc((-34:35)*20e-3,(-34:35)*20e-3,state_mat)
  xlabel("position (mm)")
  ylabel("position (mm)")


  subplot(2,2,4)
  eval(['O = load("../plots/OS_hypox_boost/O/Gl' num2str(i) '.dat");'])
  imagesc((-34:35)*20e-3,(-34:35)*20e-3,O)
  xlabel("position (mm)")
  ylabel("position (mm)")
  caxis([0 1])
  frames(i)  = getframe(gcf);


endfor

figure
movie(frames,1)
imwrite(frame2im(frames),'../plots/OS_hypox_boost/Gl.gif','DelayTime',0.3,'Compression','jpeg','Quality',75);


figure
clear frames
for i=1:114
  i
  subplot(2,2,1)
  eval(['Grid = load("../plots/OS_hypox_boost/Grid/Ox' num2str(i) '.dat");'])
  imagesc((-34:35)*20e-3,(-34:35)*20e-3,Grid)
  xlabel("position (mm)")
  ylabel("position (mm)")


  subplot(2,2,2)
  eval(['S = load("../plots/OS_hypox_boost/S/Ox' num2str(i) '.dat");'])
  imagesc((-34:35)*20e-3,(-34:35)*20e-3,S)
  xlabel("position (mm)")
  ylabel("position (mm)")
  caxis([0 1])


  subplot(2,2,3)
    eval(['state_mat = load("../plots/OS_hypox_boost/state_mat/Ox' num2str(i) '.dat");'])
  imagesc((-34:35)*20e-3,(-34:35)*20e-3,state_mat)
  xlabel("position (mm)")
  ylabel("position (mm)")


  subplot(2,2,4)
  eval(['O = load("../plots/OS_hypox_boost/O/Ox' num2str(i) '.dat");'])
  imagesc((-34:35)*20e-3,(-34:35)*20e-3,O)
  xlabel("position (mm)")
  ylabel("position (mm)")
  caxis([0 1])
  frames(i)  = getframe(gcf);


endfor

figure
movie(frames,1)
imwrite(frame2im(frames),'../plots/OS_hypox_boost/Ox.gif','DelayTime',0.3,'Compression','jpeg','Quality',75);


figure
clear frames
for i=1:187
  i
  subplot(2,2,1)
  eval(['Grid = load("../plots/OS_hypox_tol/Grid/Gl' num2str(i) '.dat");'])
  imagesc((-34:35)*20e-3,(-34:35)*20e-3,Grid)
  xlabel("position (mm)")
  ylabel("position (mm)")


  subplot(2,2,2)
  eval(['S = load("../plots/OS_hypox_tol/S/Gl' num2str(i) '.dat");'])
  imagesc((-34:35)*20e-3,(-34:35)*20e-3,S)
  xlabel("position (mm)")
  ylabel("position (mm)")
  caxis([0 1])


  subplot(2,2,3)
    eval(['state_mat = load("../plots/OS_hypox_tol/state_mat/Gl' num2str(i) '.dat");'])
  imagesc((-34:35)*20e-3,(-34:35)*20e-3,state_mat)
  xlabel("position (mm)")
  ylabel("position (mm)")


  subplot(2,2,4)
  eval(['O = load("../plots/OS_hypox_tol/O/Gl' num2str(i) '.dat");'])
  imagesc((-34:35)*20e-3,(-34:35)*20e-3,O)
  xlabel("position (mm)")
  ylabel("position (mm)")
  caxis([0 1])
  frames(i)  = getframe(gcf);


endfor

figure
movie(frames,1)
imwrite(frame2im(frames),'../plots/OS_hypox_tol/Gl.gif','DelayTime',0.3,'Compression','jpeg','Quality',75);

