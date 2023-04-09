%relaxatiion study in 2D
clear all;
close all;

%sz = conf(1); n_min = conf(2); kO_tissue = conf(3); kG_tissue = conf(4);
%kT_tissue = conf(5); cT =  conf(6); cD = conf(7); k3 =  conf(8)
conf(1,:) = [201 250 0.5 10 0.017 0.5/10 1/100, 0.1];%A
conf(2,:) = [201 250 0.5 10 0.1 0.5/10 1/100 1];%A bien une chute au centre mais accumulation de GD et T
conf(3,:) = [201 250 0.5 10 0.05 0.5/10 1/100 0.5];%A idem
conf(4,:) = [201 250 0.5 10 0.02 0.5/10 1/100 0.5];%A idem ça tombe bien à zéro mais les concentrations au bord ne sont pas stables...
conf(5,:) = [201 400 0.5 10 0.02 0.5/10 1/100 0.2];%A idem ça remonte après 260....
conf(6,:) = [201 400 0.5 10 0.05 0.5/10 1/100 0.5];%A idem
conf(7,:) = [201 400 0.5 10 0.02 0.5/10 1/100 10];%A idem stable a priori et zéro au centre mais on vérifie en doublant
conf(8,:) = [201 800 0.5 10 0.02 0.5/10 1/100 10];%A idem stable au centre mais pas au bord... grosse oscillations à partir de 580 mn...
conf(9,:) = [201 800 0.5 10 0.02 0.5/10 1/100 10];%A 8 sans back regulation
conf(10,:) = [201 400 0.5 10 0.02 0.5/10 1/100 10];%A 9 shows its unstable so smaller steps...still no bakcr
conf(11,:) = [201 400 0.5 10 0.02 0.5/10 1/100 10];%A 10 has a different instability...still no bakcr lets's  try even smaller steps (dt 1/2000)
conf(12,:) = [201 200 0.5 10 0.2 0.5/10 1/100 10];%A 11 is stable. however the system does not settle for ATP before 400 mn which is too slow kT is raised. (dt 1/4000)
conf(13,:) = [201 300 0.5 10 0.02 0.5/10 1/100 1];%A 12 is stable. T and GD do not settle either... so we lower kA and kT (dt 1/4000)
conf(14,:) = [201 300 0.05 1 0.02 0.5/10 1/100 1];%A on essaie  de stabiliser G et O
conf(15,:) = [201 300 0.05 0.1 0.02 0.5/10 1/100 1];%A on  essaye de stabiliser GD -> marche pas ..
conf(16,:) = [201 800 0.5 1 0.02 0.5/10 1/100 1];%A 2nd test longue durée pas faible EEET ça diverge.
conf(17,:) = [201 800 0.5 1 0.02 0.5/10 1/100 1];%A17 avec dt 1/4000
conf(18,:) = [201 800 0.5 1 1 0.5/10 1/100 10];%A config standard longue durée avec dt 1/4000


dx = 15;
dt = 1/4000;

p=0; %trace les courbes intermédiaires

for i =18:18%size(conf,1)
  close all;
    i
  [G,O,D,GD,T,Gt,Ot,Dt,GDt,Tt,kOct,kGt] = modfsys2DA_sym(conf(i,:));
  %[G,O,D,GD,T,Gt,Ot,Dt,GDt,Tt,kOct,kGt] = modfsys2DB_sym(conf(i,:));
  fG = figure;
  aG = axes(fG);
  imagesc(aG,(1:round(conf(i,1)/2))*dx,(1:round(conf(i,1)/2))*dx,G(1:round(conf(i,1)/2),1:round(conf(i,1)/2)))
  colorbar
  set(aG,'outerposition',[0.05 0.05 0.8 0.95])
  xlabel(aG,'position (µm)','fontsize',20)
  ylabel(aG,'position (µm)','fontsize',20)
  print (fG,["/home/antony/Documents/Post-doc/test_fortran/plots/modfsys2DA_G_conf" num2str(i) ".pdf"], "-dpdflatexstandalone","-S480,360","-FCalibri:22");


  fO = figure;
  aO = axes(fO);
  imagesc(aO,(1:round(conf(i,1)/2))*dx,(1:round(conf(i,1)/2))*dx,O(1:round(conf(i,1)/2),1:round(conf(i,1)/2)))
  colorbar
  set(aO,'outerposition',[0.05 0.05 0.8 0.95])
  xlabel(aO,'position (µm)','fontsize',20)
  ylabel(aO,'position (µm)','fontsize',20)
  print (fO,["/home/antony/Documents/Post-doc/test_fortran/plots/modfsys2DA_O_conf" num2str(i) ".pdf"], "-dpdflatexstandalone","-S480,360","-FCalibri:22");


  figure;
  hold on;
  plot((1:length(Gt(:,1)))*dt*100,Gt(:,1))
  plot((1:length(Gt(:,2)))*dt*100,Gt(:,2))
  xlabel('time (min)','fontsize',20)
  ylabel('[G] Concentration (mM)','fontsize',20)
  legend('center','rim')
  print (["/home/antony/Documents/Post-doc/test_fortran/plots/modfsys2DA_Gt_conf" num2str(i) ".pdf"], "-dpdflatexstandalone","-S480,360","-FCalibri:22");

  figure;
  hold on;
  plot((1:length(Gt(:,1)))*dt*100,Ot(:,1))
  plot((1:length(Gt(:,2)))*dt*100,Ot(:,2))
  xlabel('time (min)','fontsize',20)
  ylabel('[O] Concentration (mM)','fontsize',20)
  legend('center','rim')
  print (["/home/antony/Documents/Post-doc/test_fortran/plots/modfsys2DA_Ot_conf" num2str(i) ".pdf"], "-dpdflatexstandalone","-S480,360","-FCalibri:22");


  fT = figure;
  aT = axes(fT);
  imagesc(aT,(1:round(conf(i,1)/2))*dx,(1:round(conf(i,1)/2))*dx,T(1:round(conf(i,1)/2),1:round(conf(i,1)/2)))
  colorbar
  set(aT,'outerposition',[0.05 0.05 0.8 0.95])
  xlabel(aT,'position (µm)','fontsize',20)
  ylabel(aT,'position (µm)','fontsize',20)
  print (fT,["/home/antony/Documents/Post-doc/test_fortran/plots/modfsys2DA_T_conf" num2str(i) ".pdf"], "-dpdflatexstandalone","-S480,360","-FCalibri:22");


  figure;
  hold on;
  plot((1:length(Gt(:,1)))*dt*100,Dt(:,1))
  plot((1:length(Gt(:,2)))*dt*100,Dt(:,2))
  xlabel('time (min)','fontsize',20)
  ylabel('[D] Concentration (mM)','fontsize',20)
  legend('center','rim')
  print (["/home/antony/Documents/Post-doc/test_fortran/plots/modfsys2DA_Dt_conf" num2str(i) ".pdf"], "-dpdflatexstandalone","-S480,360","-FCalibri:22");


  figure;
  hold on;
  plot((1:length(Gt(:,1)))*dt*100,GDt(:,1))
  plot((1:length(Gt(:,2)))*dt*100,GDt(:,2))
  xlabel('time (min)','fontsize',20)
  ylabel('[GD] Concentration (mM)','fontsize',20)
  legend('center','rim')
  print (["/home/antony/Documents/Post-doc/test_fortran/plots/modfsys2DA_GDt_conf" num2str(i) ".pdf"], "-dpdflatexstandalone","-S480,360","-FCalibri:22");


  figure;
  hold on;
  plot((1:length(Gt(:,1)))*dt*100,Tt(:,1))
  plot((1:length(Gt(:,2)))*dt*100,Tt(:,2))
  xlabel('time (min)','fontsize',20)
  ylabel('[T] Concentration (mM)','fontsize',20)
  legend('center','rim')
  print (["/home/antony/Documents/Post-doc/test_fortran/plots/modfsys2DA_Tt_conf" num2str(i) ".pdf"], "-dpdflatexstandalone","-S480,360","-FCalibri:22");

  figure;
  hold on;
  plot((1:length(Gt(:,1)))*dt*100,kOct(:,1))
  plot((1:length(Gt(:,2)))*dt*100,kOct(:,2))
  xlabel('time (min)','fontsize',20)
  ylabel('magnitude','fontsize',20)
  legend('center','rim')
  print (["/home/antony/Documents/Post-doc/test_fortran/plots/modfsys2DA_kOct_conf" num2str(i) ".pdf"], "-dpdflatexstandalone","-S480,360","-FCalibri:22");

  figure;
  hold on;
  plot((1:length(Gt(:,1)))*dt*100,kGt(:,1))
  plot((1:length(Gt(:,2)))*dt*100,kGt(:,2))
  xlabel('time (min)','fontsize',20)
  ylabel('magnitude','fontsize',20)
  legend('center','rim')
  print (["/home/antony/Documents/Post-doc/test_fortran/plots/modfsys2DA_kGt_conf" num2str(i) ".pdf"], "-dpdflatexstandalone","-S480,360","-FCalibri:22");

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


