%plots for metvar 4

%%%%%%%%%
%Ref
%%%%%%%%%%%

Grid = load('../plots/ref/Grid/Id79.dat');
figure; hold on
imagesc((-34:35)*20e-3,(-34:35)*20e-3,Grid)
%line(gca,[0 0],[0 -0.5],'color','red');
set(gca,'outerposition',[0 0.05 0.9 1])
xlabel("position (mm)")
ylabel("position (mm)")
xlim([-0.6 0.6])
ylim([-0.6 0.6])
print(gcf,["/home/antonybazir/Documents/Post-doc/Redac/metvar/ref_Grid.pdf"], "-dpdflatex","-S180,150","-FCalibri:28");
close

ref_num = load('../plots/ref/Numbers/Id.dat');
figure
hold on
plot(ref_num(:,1)/60,ref_num(:,3),'color','blue')
box
grid
xlabel("time (hrs)")
ylabel("Live cells")
xlim([0 150])
set(gca,'outerposition',[0 0.05 0.9 1])
print(gcf,["/home/antonybazir/Documents/Post-doc/Redac/metvar/ref_numbers.pdf"], "-dpdflatex","-S240,133","-FCalibri:24");
close

ref_S = load('../plots/ref/S_center/Id.dat');
%ref_O = load('../plots/ref/O_center/Id.dat');
figure
hold on
plot(ref_S(:,1)/60,ref_S(:,2),'color','blue')
%plot(ref_O(:,1)/60,ref_O(:,2),'o-','color','red')
box
grid
xlim([0 150])
xlabel("time (hrs)")
ylabel("Concentration")
set(gca,'outerposition',[0 0.05 0.9 1])
print(gcf,["/home/antonybazir/Documents/Post-doc/Redac/metvar/ref_S_center.pdf"], "-dpdflatex","-S240,133","-FCalibri:24");
close

S_mid = load('../plots/ref/S_midline/Id79.dat');
%O_mid = load('../plots/ref/O_midline/Id75.dat');
figure; hold on;
box
grid
xlabel("position (mm)")
ylabel("Concentration")
xlim([-0.6 0.6])
plot(S_mid(:,1)*1e-3,S_mid(:,2),'color','blue','+-','linewidth',1,'markersize',2);
%plot(O_mid(:,1)*1e-3,O_mid(:,2),'color','red','o-','linewidth',1,'markersize',2);
set(gca,'outerposition',[0 0.05 0.9 1])
print(gcf,["/home/antonybazir/Documents/Post-doc/Redac/metvar/S_ref_midline.pdf"], "-dpdflatex","-S240,133","-FCalibri:24");
close

%%%%%%%%%
%Starv
%%%%%%%%%%%
Grid = load('../plots/starv/Grid/Id100.dat');
figure; hold on
imagesc((-34:35)*20e-3,(-34:35)*20e-3,Grid)
%line(gca,[0 0],[0 -0.5],'color','red');
set(gca,'outerposition',[0 0.05 0.9 1])
xlabel("position (mm)")
ylabel("position (mm)")
xlim([-0.6 0.6])
ylim([-0.6 0.6])
print(gcf,["/home/antonybazir/Documents/Post-doc/Redac/metvar/starv_Grid.pdf"], "-dpdflatex","-S180,150","-FCalibri:28");
close

ref_num = load('../plots/ref/Numbers/Id.dat');
starv_num = load('../plots/starv/Numbers/Id.dat');
figure
hold on
plot(ref_num(:,1)/60,ref_num(:,3),'--','color','blue')
plot(starv_num(:,1)/60,starv_num(:,3),'color','blue')
box
grid
xlabel("time (hrs)")
ylabel("Live cells")
%xlim([0 150])
set(gca,'outerposition',[0 0.05 0.9 1])
print(gcf,["/home/antonybazir/Documents/Post-doc/Redac/metvar/starv_numbers.pdf"], "-dpdflatex","-S240,133","-FCalibri:24");
close

ref_S = load('../plots/starv/S_center/Id.dat');
%ref_O = load('../plots/ref/O_center/Id.dat');
figure
hold on
plot(ref_S(:,1)/60,ref_S(:,2),'color','blue','linewidth',1,'markersize',2)
%plot(ref_O(:,1)/60,ref_O(:,2),'o-','color','red')
box
grid
%xlim([0 150])
xlabel("time (hrs)")
ylabel("Concentration")
set(gca,'outerposition',[0 0.05 0.9 1])
print(gcf,["/home/antonybazir/Documents/Post-doc/Redac/metvar/starv_S_center.pdf"], "-dpdflatex","-S240,133","-FCalibri:24");
close

S_mid = load('../plots/starv/S_midline/Id100.dat');
%O_mid = load('../plots/ref/O_midline/Id75.dat');
figure; hold on;
box
grid
xlabel("position (mm)")
ylabel("Concentration")
xlim([-0.6 0.6])
plot(S_mid(:,1)*1e-3,S_mid(:,2),'color','blue','+-','linewidth',1,'markersize',2);
%plot(O_mid(:,1)*1e-3,O_mid(:,2),'color','red','o-','linewidth',1,'markersize',2);
set(gca,'outerposition',[0 0.05 0.9 1])
print(gcf,["/home/antonybazir/Documents/Post-doc/Redac/metvar/S_starv_midline.pdf"], "-dpdflatex","-S240,133","-FCalibri:24");
close

%%%%%%%%%
%Savy
%%%%%%%%%%%
Grid = load('../plots/savy/Grid/Id69.dat');
figure; hold on
imagesc((-34:35)*20e-3,(-34:35)*20e-3,Grid)
%line(gca,[0 0],[0 -0.5],'color','red');
set(gca,'outerposition',[0 0.05 0.9 1])
xlabel("position (mm)")
ylabel("position (mm)")
xlim([-0.6 0.6])
ylim([-0.6 0.6])
print(gcf,["/home/antonybazir/Documents/Post-doc/Redac/metvar/savy_Grid.pdf"], "-dpdflatex","-S180,150","-FCalibri:28");
close

ref_num = load('../plots/ref/Numbers/Id.dat');
savy_num = load('../plots/savy/Numbers/Id.dat');
figure
hold on
plot(ref_num(:,1)/60,ref_num(:,3),'--','color','blue')
plot(savy_num(:,1)/60,savy_num(:,3),'color','blue')
box
grid
xlabel("time (hrs)")
ylabel("Live cells")
%xlim([0 150])
set(gca,'outerposition',[0 0.05 0.9 1])
print(gcf,["/home/antonybazir/Documents/Post-doc/Redac/metvar/savy_numbers.pdf"], "-dpdflatex","-S240,133","-FCalibri:24");
close

figure
hold on
plot(ref_num(:,1)/60,sqrt(ref_num(:,5))*20,'--','color','blue')
plot(savy_num(:,1)/60,sqrt(savy_num(:,5))*20,'color','blue')
box
grid
xlabel("time (hrs)")
ylabel("Radius (µm)")
%xlim([0 150])
set(gca,'outerposition',[0 0.05 0.9 1])

ref_S = load('../plots/savy/S_center/Id.dat');
%ref_O = load('../plots/ref/O_center/Id.dat');
figure
hold on
plot(ref_S(:,1)/60,ref_S(:,2),'color','blue','linewidth',1,'markersize',2)
%plot(ref_O(:,1)/60,ref_O(:,2),'o-','color','red')
box
grid
%xlim([0 150])
xlabel("time (hrs)")
ylabel("Concentration")
set(gca,'outerposition',[0 0.05 0.9 1])
print(gcf,["/home/antonybazir/Documents/Post-doc/Redac/metvar/savy_S_center.pdf"], "-dpdflatex","-S240,133","-FCalibri:24");
close

S_mid = load('../plots/savy/S_midline/Id69.dat');
%O_mid = load('../plots/ref/O_midline/Id75.dat');
figure; hold on;
box
grid
xlabel("position (mm)")
ylabel("Concentration")
xlim([-0.6 0.6])
plot(S_mid(:,1)*1e-3,S_mid(:,2),'color','blue','+-','linewidth',1,'markersize',2);
%plot(O_mid(:,1)*1e-3,O_mid(:,2),'color','red','o-','linewidth',1,'markersize',2);
set(gca,'outerposition',[0 0.05 0.9 1])
print(gcf,["/home/antonybazir/Documents/Post-doc/Redac/metvar/S_savy_midline.pdf"], "-dpdflatex","-S240,133","-FCalibri:24");
close


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%midline
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
S_mid = load('../plots/ref/S_midline/Id79.dat');
O_mid = load('../plots/ref/O_midline/Id79.dat');
figure; hold on;
box
grid
xlabel("position (mm)")
ylabel("Concentration")
plot(S_mid(:,1)*1e-3,S_mid(:,2),'color','blue','+-','linewidth',1,'markersize',2);
plot(O_mid(:,1)*1e-3,O_mid(:,2),'color','red','o-','linewidth',1,'markersize',2);
set(gca,'outerposition',[0 0.05 0.9 1])
print(gcf,["/home/antonybazir/Documents/Post-doc/Redac/metvar/SO_ref_midline_Id.pdf"], "-dpdflatex","-S180,110","-FCalibri:24");
close

S_mid = load('../plots/ref/S_midline/Gl76.dat');
O_mid = load('../plots/ref/O_midline/Gl76.dat');
figure; hold on;
box
grid
xlabel("position (mm)")
ylabel("Concentration")
plot(S_mid(:,1)*1e-3,S_mid(:,2),'color','blue','+-','linewidth',1,'markersize',2);
plot(O_mid(:,1)*1e-3,O_mid(:,2),'color','red','o-','linewidth',1,'markersize',2);
set(gca,'outerposition',[0 0.05 0.9 1])
print(gcf,["/home/antonybazir/Documents/Post-doc/Redac/metvar/SO_ref_midline_Gl.pdf"], "-dpdflatex","-S180,110","-FCalibri:24");
close

S_mid = load('../plots/ref/S_midline/Ox77.dat');
O_mid = load('../plots/ref/O_midline/Ox77.dat');
figure; hold on;
box
grid
xlabel("position (mm)")
ylabel("Concentration")
plot(S_mid(:,1)*1e-3,S_mid(:,2),'color','blue','+-','linewidth',1,'markersize',2);
plot(O_mid(:,1)*1e-3,O_mid(:,2),'color','red','o-','linewidth',1,'markersize',2);
ylim([0 1])
set(gca,'outerposition',[0 0.05 0.9 1])
print(gcf,["/home/antonybazir/Documents/Post-doc/Redac/metvar/SO_ref_midline_Ox.pdf"], "-dpdflatex","-S180,110","-FCalibri:24");
close

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Growth
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
OSf_num = load('../plots/OS_fragile/Numbers/Id.dat');
hypos_tol_num = load('../plots/OS_hypos_tol/Numbers/Id.dat');
hypox_tol_num = load('../plots/OS_hypox_tol/Numbers/Id.dat');
hypox_boost_num = load('../plots/OS_hypox_boost/Numbers/Id.dat');
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
print(gcf,["/home/antonybazir/Documents/Post-doc/Redac/metvar/OS_live_Id.pdf"], "-dpdflatex","-S180,110","-FCalibri:26");
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
print(gcf,["/home/antonybazir/Documents/Post-doc/Redac/metvar/OS_dead_Id.pdf"], "-dpdflatex","-S180,110","-FCalibri:26");
close

figure
hold on
plot(OSf_num(:,1)/60,sqrt(OSf_num(:,5))*20,'color','blue')
plot(hypos_tol_num(:,1)/60,sqrt(hypos_tol_num(:,5))*20,'color','red')
plot(hypox_tol_num(:,1)/60,sqrt(hypox_tol_num(:,5))*20,'color','green')
plot(hypox_boost_num(:,1)/60,sqrt(hypox_boost_num(:,5))*20,'color','magenta')
box
grid
xlabel("time (hrs)")
ylabel("Radius (µm)")
set(gca,'outerposition',[0 0.05 0.9 1])
print(gcf,["/home/antonybazir/Documents/Post-doc/Redac/metvar/OS_Rad_Id.pdf"], "-dpdflatex","-S180,110","-FCalibri:26");
close

Grid = load('../plots/OS_fragile/Grid/Id129.dat');
figure; hold on
imagesc((-34:35)*20e-3,(-34:35)*20e-3,Grid)

Grid = load('../plots/OS_hypos_tol/Grid/Id141.dat');
figure; hold on
imagesc((-34:35)*20e-3,(-34:35)*20e-3,Grid)

Grid = load('../plots/OS_hypox_boost/Grid/Id126.dat');
figure; hold on
imagesc((-34:35)*20e-3,(-34:35)*20e-3,Grid)


OSf_num = load('../plots/OS_fragile/S_center/Id.dat');
hypos_tol_num = load('../plots/OS_hypos_tol/S_center/Id.dat');
hypox_tol_num = load('../plots/OS_hypox_tol/S_center/Id.dat');
hypox_boost_num = load('../plots/OS_hypox_boost/S_center/Id.dat');
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
print(gcf,["/home/antonybazir/Documents/Post-doc/Redac/metvar/OS_S_Id.pdf"], "-dpdflatex","-S240,120","-FCalibri:24");
close

OSf_num = load('../plots/OS_fragile/O_center/Id.dat');
hypos_tol_num = load('../plots/OS_hypos_tol/O_center/Id.dat');
hypox_tol_num = load('../plots/OS_hypox_tol/O_center/Id.dat');
hypox_boost_num = load('../plots/OS_hypox_boost/O_center/Id.dat');
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
print(gcf,["/home/antonybazir/Documents/Post-doc/Redac/metvar/OS_O_Id.pdf"], "-dpdflatex","-S240,120","-FCalibri:24");
close

%Ox
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
OSf_num = load('../plots/OS_fragile/Numbers/Ox.dat');
hypos_tol_num = load('../plots/OS_hypos_tol/Numbers/Ox.dat');
hypox_tol_num = load('../plots/OS_hypox_tol/Numbers/Ox.dat');
hypox_boost_num = load('../plots/OS_hypox_boost/Numbers/Ox.dat');
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
print(gcf,["/home/antonybazir/Documents/Post-doc/Redac/metvar/OS_live_Ox.pdf"], "-dpdflatex","-S180,110","-FCalibri:24");
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
print(gcf,["/home/antonybazir/Documents/Post-doc/Redac/metvar/OS_dead_Ox.pdf"], "-dpdflatex","-S180,110","-FCalibri:24");
close

figure
hold on
plot(OSf_num(:,1)/60,sqrt(OSf_num(:,5))*20,'color','blue')
plot(hypos_tol_num(:,1)/60,sqrt(hypos_tol_num(:,5))*20,'color','red')
plot(hypox_tol_num(:,1)/60,sqrt(hypox_tol_num(:,5))*20,'color','green')
plot(hypox_boost_num(:,1)/60,sqrt(hypox_boost_num(:,5))*20,'color','magenta')
box
grid
xlabel("time (hrs)")
ylabel("Radius (µm)")
set(gca,'outerposition',[0 0.05 0.9 1])
print(gcf,["/home/antonybazir/Documents/Post-doc/Redac/metvar/OS_Rad_Ox.pdf"], "-dpdflatex","-S180,110","-FCalibri:24");
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
print(gcf,["/home/antonybazir/Documents/Post-doc/Redac/metvar/OS_S_Ox.pdf"], "-dpdflatex","-S240,120","-FCalibri:24");
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
print(gcf,["/home/antonybazir/Documents/Post-doc/Redac/metvar/OS_O_Ox.pdf"], "-dpdflatex","-S240,120","-FCalibri:24");
close


%Gl
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
OSf_num = load('../plots/OS_fragile/Numbers/Gl.dat');
hypos_tol_num = load('../plots/OS_hypos_tol/Numbers/Gl.dat');
hypox_tol_num = load('../plots/OS_hypox_tol/Numbers/Gl.dat');
hypox_boost_num = load('../plots/OS_hypox_boost/Numbers/Gl.dat');
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
print(gcf,["/home/antonybazir/Documents/Post-doc/Redac/metvar/OS_live_Gl.pdf"], "-dpdflatex","-S180,110","-FCalibri:24");
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
print(gcf,["/home/antonybazir/Documents/Post-doc/Redac/metvar/OS_dead_Gl.pdf"], "-dpdflatex","-S180,110","-FCalibri:24");
close

figure
hold on
plot(OSf_num(:,1)/60,sqrt(OSf_num(:,5))*20,'color','blue')
plot(hypos_tol_num(:,1)/60,sqrt(hypos_tol_num(:,5))*20,'color','red')
plot(hypox_tol_num(:,1)/60,sqrt(hypox_tol_num(:,5))*20,'color','green')
plot(hypox_boost_num(:,1)/60,sqrt(hypox_boost_num(:,5))*20,'color','magenta')
box
grid
xlabel("time (hrs)")
ylabel("Radius (µm)")
set(gca,'outerposition',[0 0.05 0.9 1])
print(gcf,["/home/antonybazir/Documents/Post-doc/Redac/metvar/OS_Rad_Gl.pdf"], "-dpdflatex","-S180,110","-FCalibri:24");
close



%Gl
OSf_num = load('../plots/OS_fragile/S_center/Gl.dat');
hypos_tol_num = load('../plots/OS_hypos_tol/S_center/Gl.dat');
hypox_tol_num = load('../plots/OS_hypox_tol/S_center/Gl.dat');
hypox_boost_num = load('../plots/OS_hypox_boost/S_center/Gl.dat');
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
print(gcf,["/home/antonybazir/Documents/Post-doc/Redac/metvar/OS_S_Gl.pdf"], "-dpdflatex","-S240,120","-FCalibri:24");
close

OSf_num = load('../plots/OS_fragile/O_center/Gl.dat');
hypos_tol_num = load('../plots/OS_hypos_tol/O_center/Gl.dat');
hypox_tol_num = load('../plots/OS_hypox_tol/O_center/Gl.dat');
hypox_boost_num = load('../plots/OS_hypox_boost/O_center/Gl.dat');
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
print(gcf,["/home/antonybazir/Documents/Post-doc/Redac/metvar/OS_O_Gl.pdf"], "-dpdflatex","-S240,120","-FCalibri:24");
close


Grid = load('../plots/OS_fragile/Grid/Gl175.dat');
figure; hold on
imagesc((-34:35)*20e-3,(-34:35)*20e-3,Grid)
%line(gca,[0 0],[0 -0.5],'color','red');
set(gca,'outerposition',[0 0.05 0.9 1])
xlabel("position (mm)")
ylabel("position (mm)")
xlim([-0.6 0.6])
ylim([-0.6 0.6])

Grid = load('../plots/OS_fragile/Grid/Id126.dat');
figure; hold on
imagesc((-34:35)*20e-3,(-34:35)*20e-3,Grid)
%line(gca,[0 0],[0 -0.5],'color','red');
set(gca,'outerposition',[0 0.05 0.9 1])
xlabel("position (mm)")
ylabel("position (mm)")
xlim([-0.6 0.6])
ylim([-0.6 0.6])
