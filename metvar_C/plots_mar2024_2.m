%plots_mar2024-2
starv_num = load('../plots/starv/Numbers/Id.dat');
figure
hold on
plot(starv_num(:,1)/60,starv_num(:,3),'color','blue')
box
grid
xlabel("time (hrs)")
ylabel("Live cells")
%xlim([0 150])
set(gca,'outerposition',[0 0.05 0.9 1])
print(gcf,["/home/antonybazir/Documents/Post-doc/Présentation/Mar2024/starv_numbers.pdf"], "-dpdflatex","-S180,100","-FCalibri:20");
close

figure
hold on
plot(starv_num(:,1)/60,starv_num(:,4),'color','blue')
box
grid
xlabel("time (hrs)")
ylabel("Dead cells")

figure
hold on
plot(starv_num(:,1)/60,sqrt(starv_num(:,5))*20*2,'color','blue')
box
grid
xlabel("time (hrs)")
ylabel("diam")
%xlim([0 150])
set(gca,'outerposition',[0 0.05 0.9 1])

ref_S = load('../plots/starv/S_center/Id.dat');
figure
hold on
%plot(ref_S(:,1)/60,ref_S(:,2),'+-','color','blue','linewidth',1,'markersize',2)
plot(ref_S(:,1)/60,ref_S(:,2),'color','blue')
box
grid
%xlim([0 150])
xlabel("time (hrs)")
ylabel("Concentration")
set(gca,'outerposition',[0 0.05 0.9 1])
print(gcf,["/home/antonybazir/Documents/Post-doc/Présentation/Mar2024/starv_S_center.pdf"], "-dpdflatex","-S180,100","-FCalibri:20");
close

savy_num = load('../plots/savy/Numbers/Id.dat');
starv_num = load('../plots/starv/Numbers/Id.dat');
figure
hold on
plot(savy_num(:,1)/60,savy_num(:,3),'color','blue')
plot(starv_num(:,1)/60,starv_num(:,3),'--','color','cyan','linewidth',0.1)
box
grid
xlabel("time (hrs)")
ylabel("Live cells")
%xlim([0 150])
set(gca,'outerposition',[0 0.05 0.9 1])
print(gcf,["/home/antonybazir/Documents/Post-doc/Présentation/Mar2024/savy_numbers.pdf"], "-dpdflatex","-S180,100","-FCalibri:20");
close


savy_S = load('../plots/savy/S_center/Id.dat');
starv_S = load('../plots/starv/S_center/Id.dat');
figure
hold on
%plot(ref_S(:,1)/60,ref_S(:,2),'+-','color','blue','linewidth',1,'markersize',2)
plot(savy_S(:,1)/60,savy_S(:,2),'color','blue')
plot(starv_S(:,1)/60,starv_S(:,2),'--','color','cyan','linewidth',0.1)
box
grid
%xlim([0 150])
xlabel("time (hrs)")
ylabel("Concentration")
set(gca,'outerposition',[0 0.05 0.9 1])
print(gcf,["/home/antonybazir/Documents/Post-doc/Présentation/Mar2024/savy_S_center.pdf"], "-dpdflatex","-S180,100","-FCalibri:20");
close


figure
hold on
plot(savy_num(:,1)/60,savy_num(:,4),'color','blue')
box
grid
xlabel("time (hrs)")
ylabel("diam")
%xlim([0 150])

figure
hold on
plot(savy_num(:,1)/60,sqrt(savy_num(:,5))*20*2,'color','blue')
box
grid
xlabel("time (hrs)")
ylabel("diam")
%xlim([0 150])
set(gca,'outerposition',[0 0.05 0.9 1])

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%midline
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
S_mid = load('../plots/ref/S_midline/Id72.dat');
O_mid = load('../plots/ref/O_midline/Id72.dat');
figure; hold on;
box
grid
xlabel("position (mm)")
ylabel("Concentration")
plot(S_mid(:,1)*1e-3,S_mid(:,2),'color','blue','+-','linewidth',1,'markersize',2);
plot(O_mid(:,1)*1e-3,O_mid(:,2),'color','red','o-','linewidth',1,'markersize',2);
set(gca,'outerposition',[0 0.05 0.9 0.9])
print(gcf,["/home/antonybazir/Documents/Post-doc/Présentation/Mar2024/SO_ref_midline_Id.pdf"], "-dpdflatex","-S130,105","-FCalibri:24");
close

S_mid = load('../plots/ref/S_midline/Gl75.dat');
O_mid = load('../plots/ref/O_midline/Gl75.dat');
figure; hold on;
box
grid
xlabel("position (mm)")
ylabel("Concentration")
plot(S_mid(:,1)*1e-3,S_mid(:,2),'color','blue','+-','linewidth',1,'markersize',2);
plot(O_mid(:,1)*1e-3,O_mid(:,2),'color','red','o-','linewidth',1,'markersize',2);
set(gca,'outerposition',[0 0.05 0.9 0.9])
print(gcf,["/home/antonybazir/Documents/Post-doc/Présentation/Mar2024/SO_ref_midline_Gl.pdf"], "-dpdflatex","-S130,105","-FCalibri:24");
close

S_mid = load('../plots/ref/S_midline/Ox75.dat');
O_mid = load('../plots/ref/O_midline/Ox75.dat');
figure; hold on;
box
grid
xlabel("position (mm)")
ylabel("Concentration")
ylim([0 1])
plot(S_mid(:,1)*1e-3,S_mid(:,2),'color','blue','+-','linewidth',1,'markersize',2);
plot(O_mid(:,1)*1e-3,O_mid(:,2),'color','red','o-','linewidth',1,'markersize',2);
set(gca,'outerposition',[0 0.05 0.9 0.9])
print(gcf,["/home/antonybazir/Documents/Post-doc/Présentation/Mar2024/SO_ref_midline_Ox.pdf"], "-dpdflatex","-S130,105","-FCalibri:24");
close


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Id
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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
print(gcf,["/home/antonybazir/Documents/Post-doc/Présentation/Mar2024/OS_live_Id.pdf"], "-dpdflatex","-S180,100","-FCalibri:20");
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
print(gcf,["/home/antonybazir/Documents/Post-doc/Présentation/Mar2024/OS_dead_Id.pdf"], "-dpdflatex","-S180,100","-FCalibri:20");
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
print(gcf,["/home/antonybazir/Documents/Post-doc/Présentation/Mar2024/OS_Rad_Id.pdf"], "-dpdflatex","-S180,100","-FCalibri:20");
close


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
print(gcf,["/home/antonybazir/Documents/Post-doc/Présentation/Mar2024/OS_S_Id.pdf"], "-dpdflatex","-S180,100","-FCalibri:20");
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
print(gcf,["/home/antonybazir/Documents/Post-doc/Présentation/Mar2024/OS_O_Id.pdf"], "-dpdflatex","-S180,100","-FCalibri:20");
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
print(gcf,["/home/antonybazir/Documents/Post-doc/Présentation/Mar2024/OS_live_Ox.pdf"], "-dpdflatex","-S180,100","-FCalibri:20");
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
print(gcf,["/home/antonybazir/Documents/Post-doc/Présentation/Mar2024/OS_dead_Ox.pdf"], "-dpdflatex","-S180,100","-FCalibri:20");
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
print(gcf,["/home/antonybazir/Documents/Post-doc/Présentation/Mar2024/OS_Rad_Ox.pdf"], "-dpdflatex","-S180,100","-FCalibri:20");
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
print(gcf,["/home/antonybazir/Documents/Post-doc/Présentation/Mar2024/OS_S_Ox.pdf"], "-dpdflatex","-S180,100","-FCalibri:20");
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
print(gcf,["/home/antonybazir/Documents/Post-doc/Présentation/Mar2024/OS_O_Ox.pdf"], "-dpdflatex","-S180,100","-FCalibri:20");
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
print(gcf,["/home/antonybazir/Documents/Post-doc/Présentation/Mar2024/OS_live_Gl.pdf"], "-dpdflatex","-S180,100","-FCalibri:20");
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
print(gcf,["/home/antonybazir/Documents/Post-doc/Présentation/Mar2024/OS_dead_Gl.pdf"], "-dpdflatex","-S180,100","-FCalibri:20");
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
print(gcf,["/home/antonybazir/Documents/Post-doc/Présentation/Mar2024/OS_Rad_Gl.pdf"], "-dpdflatex","-S180,100","-FCalibri:20");
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
print(gcf,["/home/antonybazir/Documents/Post-doc/Présentation/Mar2024/OS_S_Gl.pdf"], "-dpdflatex","-S180,100","-FCalibri:20");
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
print(gcf,["/home/antonybazir/Documents/Post-doc/Présentation/Mar2024/OS_O_Gl.pdf"], "-dpdflatex","-S180,100","-FCalibri:20");
close


