%relaxatiion study in 2D
clear all;
close all;

%sz = conf(1); n_min = conf(2); kO_tissue = conf(3); kG_tissue = conf(4);
%kT_tissue = conf(5); cT =  conf(6); cD = conf(7);
conf(1,:) = [41 20 0.5 10 0.017 0.5/10 1/100];
conf(2,:) = [101 20 0.5 10 0.017 0.5/10 1/100];
conf(3,:) = [201 20 0.5 10 0.017 0.5/10 1/100];
conf(4,:) = [101 100 0.5 10 0.017 0.5/10 1/100];%
conf(5,:) = [101 150 0.5 10 0.017 0.5/10 1/100]; %
conf(6,:) = [101 200 0.5 10 0.017 0.5/10 1/100]; %
conf(7,:) = [201 200 0.5 10 0.017 0.5/10 1/100];%
conf(8,:) = [201 300 0.5 10 0.017 0.5/10 1/100];%
conf(9,:) = [201 400 0.5 10 0.017 0.5/10 1/100];% ça diverge à 180 parce que la production de [D] s'inverse brusquement. Elle monte au départ puis diminue graduellement parce que le glucose et l'oxygène se raréfie et l'ATP aussi
conf(10,:) = [201 250 5 10 0.017 1/100 5/10];%  on remet et cd et ct  à leur place...
conf(11,:) = [201 250 1 1 10 1/100 0.5/10];% toujours la chute de [D] à 180 mn....  k1 GD sembe exploser sans raison...
conf(12,:) = [201 250 1 1 10 1/100 0.5/10];% On change dt pour voir si ça change le comportement...(on passse à 1/2000) pas mieux
conf(13,:) = [201 240 1 1 100 1/100 1/10];% mu plus grand n'aide pas...
conf(14,:) = [201 240 0.01 1 1 1/100 1/10];% bloque toujours à 180
conf(15,:) = [151 250 1 1 0.017 1/100 0.5/10];% bloque bien plus tot mais le comportement reste le même...
conf(16,:) = [151 400 1 1 0.017 1/100 0.5/10];% stable ou oscillant ? a priori stable
conf(17,:) = [151 250 1 0.01 0.017 1/100 0.5/10];% plus lent et descend moins bas.
conf(18,:) = [201 250 0.5 10 10 1/100 0.5/10];% on  tente une grosse conso d'ATP ça décale au delà de 200
conf(19,:) = [201 400 0.5 10 50 1/100 0.5/10];% on  tente une plus grosse conso d'ATP ça décale pas plus.
conf(20,:) = [201 400 0.5 0.01 10 1/100 0.5/10];% on  tente une plus grosse conso d'ATP et moins de conso glucose -> nope
conf(21,:) = [201 400 0.05 0.01 10 1/100 0.5/10];% on  tente une plus grosse conso d'ATP et moins de conso glucose -> nope
conf(22,:) = [201 400 0.05 0.01 0.02 1/100 0.5/10];% on  tente une plus grosse conso d'ATP et moins de conso glucose -> nope
conf(23,:) = [331 240 0.5 10 0.017 0.5/10 1/100];

dx = 15;
dt = 1/1000;

p=0; %trace les courbes intermédiaires

for i =22:22%size(conf,1)
  close all;
    i
  [G,O,D,GD,T,Gt,Ot,Dt,GDt,Tt,kOct,kGt] = fullsys2D_sym(conf(i,:));
  fG = figure;
  aG = axes(fG);
  imagesc(aG,(1:round(conf(i,1)/2))*dx,(1:round(conf(i,1)/2))*dx,G(1:round(conf(i,1)/2),1:round(conf(i,1)/2)))
  colorbar
  set(aG,'outerposition',[0.05 0.05 0.8 0.95])
  xlabel(aG,'position (µm)','fontsize',20)
  ylabel(aG,'position (µm)','fontsize',20)
  print (fG,["/home/antony/Documents/Post-doc/test_fortran/plots/fullsys2D_G_conf" num2str(i) ".pdf"], "-dpdflatexstandalone","-S480,360","-FCalibri:22");


  fO = figure;
  aO = axes(fO);
  imagesc(aO,(1:round(conf(i,1)/2))*dx,(1:round(conf(i,1)/2))*dx,O(1:round(conf(i,1)/2),1:round(conf(i,1)/2)))
  colorbar
  set(aO,'outerposition',[0.05 0.05 0.8 0.95])
  xlabel(aO,'position (µm)','fontsize',20)
  ylabel(aO,'position (µm)','fontsize',20)
  print (fO,["/home/antony/Documents/Post-doc/test_fortran/plots/fullsys2D_O_conf" num2str(i) ".pdf"], "-dpdflatexstandalone","-S480,360","-FCalibri:22");


  figure;
  hold on;
  plot((1:length(Gt(:,1)))*dt*100,Gt(:,1))
  plot((1:length(Gt(:,2)))*dt*100,Gt(:,2))
  xlabel('time (min)','fontsize',20)
  ylabel('Concentration (mM)','fontsize',20)
  legend('center','rim')
  print (["/home/antony/Documents/Post-doc/test_fortran/plots/fullsys2D_Gt_conf" num2str(i) ".pdf"], "-dpdflatexstandalone","-S480,360","-FCalibri:22");

  figure;
  hold on;
  plot((1:length(Gt(:,1)))*dt*100,Ot(:,1))
  plot((1:length(Gt(:,2)))*dt*100,Ot(:,2))
  xlabel('time (min)','fontsize',20)
  ylabel('Concentration (mM)','fontsize',20)
  legend('center','rim')
  print (["/home/antony/Documents/Post-doc/test_fortran/plots/fullsys2D_Ot_conf" num2str(i) ".pdf"], "-dpdflatexstandalone","-S480,360","-FCalibri:22");


  fT = figure;
  aT = axes(fT);
  imagesc(aT,(1:round(conf(i,1)/2))*dx,(1:round(conf(i,1)/2))*dx,T(1:round(conf(i,1)/2),1:round(conf(i,1)/2)))
  colorbar
  set(aT,'outerposition',[0.05 0.05 0.8 0.95])
  xlabel(aT,'position (µm)','fontsize',20)
  ylabel(aT,'position (µm)','fontsize',20)
  print (fT,["/home/antony/Documents/Post-doc/test_fortran/plots/fullsys2D_T_conf" num2str(i) ".pdf"], "-dpdflatexstandalone","-S480,360","-FCalibri:22");


  figure;
  hold on;
  plot((1:length(Gt(:,1)))*dt*100,Dt(:,1))
  plot((1:length(Gt(:,2)))*dt*100,Dt(:,2))
  xlabel('time (min)','fontsize',20)
  ylabel('Concentration (mM)','fontsize',20)
  legend('center','rim')
  print (["/home/antony/Documents/Post-doc/test_fortran/plots/fullsys2D_Dt_conf" num2str(i) ".pdf"], "-dpdflatexstandalone","-S480,360","-FCalibri:22");


  figure;
  hold on;
  plot((1:length(Gt(:,1)))*dt*100,GDt(:,1))
  plot((1:length(Gt(:,2)))*dt*100,GDt(:,2))
  xlabel('time (min)','fontsize',20)
  ylabel('Concentration (mM)','fontsize',20)
  legend('center','rim')
  print (["/home/antony/Documents/Post-doc/test_fortran/plots/fullsys2D_GDt_conf" num2str(i) ".pdf"], "-dpdflatexstandalone","-S480,360","-FCalibri:22");


  figure;
  hold on;
  plot((1:length(Gt(:,1)))*dt*100,Tt(:,1))
  plot((1:length(Gt(:,2)))*dt*100,Tt(:,2))
  xlabel('time (min)','fontsize',20)
  ylabel('Concentration (mM)','fontsize',20)
  legend('center','rim')
  print (["/home/antony/Documents/Post-doc/test_fortran/plots/fullsys2D_Tt_conf" num2str(i) ".pdf"], "-dpdflatexstandalone","-S480,360","-FCalibri:22");

  figure;
  hold on;
  plot((1:length(Gt(:,1)))*dt*100,kOct(:,1))
  plot((1:length(Gt(:,2)))*dt*100,kOct(:,2))
  xlabel('time (min)','fontsize',20)
  ylabel('Concentration (mM)','fontsize',20)
  legend('center','rim')
  print (["/home/antony/Documents/Post-doc/test_fortran/plots/fullsys2D_kOct_conf" num2str(i) ".pdf"], "-dpdflatexstandalone","-S480,360","-FCalibri:22");

  figure;
  hold on;
  plot((1:length(Gt(:,1)))*dt*100,kGt(:,1))
  plot((1:length(Gt(:,2)))*dt*100,kGt(:,2))
  xlabel('time (min)','fontsize',20)
  ylabel('Concentration (mM)','fontsize',20)
  legend('center','rim')
  print (["/home/antony/Documents/Post-doc/test_fortran/plots/fullsys2D_kGt_conf" num2str(i) ".pdf"], "-dpdflatexstandalone","-S480,360","-FCalibri:22");

  if(p==1)
    figure
    plot((0.017*Tt(:,1) - kGt(:,1)))
    hold on
    plot(0.017*Tt(:,1))
    plot(Dt(:,1)/30)
    plot(kGt(:,1))
    plot(10*exp(-conf(i,6)*Tt(:,1)./Dt(:,1)))
    plot(kOct(:,1)*10)
    plot(conf(i,3) - conf(i,7)*Dt(:,1))
    legend('$\Delta [D]$','$\mu [T]$','$[D]$','$k_1 [G][D]$','$k_1$','$k_2 [GD][O]$','$k_2$')

    figure
    plot(kOct(:,1) - 0.017*Tt(:,1))
    hold on
    plot(GDt(:,1)/30)
    plot(kOct(:,1)*10)
    legend('$\Delta [T]$','$[GD]$','$k_2 [GD][O]$')
  endif
endfor


