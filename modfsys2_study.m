%relaxatiion study in 2D
clear all;
close all;

%sz = conf(1); n_min = conf(2); kO_tissue = conf(3); kG_tissue = conf(4);
%kT_tissue = conf(5); cT =  conf(6); cD = conf(7); k3 =  conf(8) dx =  conf(9) dt = conf(10)
conf(1,:) = [61 1400 0.5 10 0.017 0.5/10 1/100, 1 50 1/300];% pas kA
conf(2,:) = [61 1400 0.5 10 1 0.5/10 1/100, 1 50 1/300];% pas de KA T se stabilise fort bas
conf(3,:) = [61 1400 0.5 10 1 0.5/10 1/100, 1 50 1/300];% pas de KA T se stabilise fort bas back reg rajoutée. change rien
conf(4,:) = [61 1400 0.5 10 0.02 0.5/10 1/100, 0.08 50 1/300];%  ON rajoute kA -> GD est pas stable du coup
conf(5,:) = [61 1400 0.2 1 0.02 0.5/10 1/100, 0.08 50 1/300];% unstable rim oxygen and too much so k2 jacked up
conf(6,:) = [61 1400 10 1 0.02 0.5/10 1/100, 0.08 50 1/300];% doesn't work.

%other model
conf(7,:) = [61 1400 0.5 10 0.017 0.5/10 1/100, 1 50 1/300];% config standard -> marche pas mal mais un peu instable on passe le pas à 1/500
conf(8,:) = [61 1400 0.5 10 0.017 0.5/10 1/100, 1 50 1/500];% pas mal mais l'oxygène ne chute pas à 0
conf(9,:) = [61 1400 2 10 0.017 0.5/10 1/100, 1 50 1/500];% pas mal mais l'oxygène ne chute pas à 0
conf(10,:) = [61 1400 10 10 0.017 0.5/10 1/100, 1 50 1/500];% pas mal mais l'oxygène ne chute à 0 !
conf(11,:) = [201 200 10 10 0.017 0.5/10 1/100, 1 15 1/1000];% plus court et pas plus serré ! -> bien
conf(12,:) = [201 200 0.5 10 1 0.5/10 1/100, 10 15 1/1000];% des productions plus proches des consos mesurées. marche mais l'oxygène est torp haut
conf(13,:) = [201 200 1 10 1 0.5/10 1/100, 10 15 1/1000];%toujourscette oxygène trophaut !
conf(14,:) = [201 200 10 10 1 0.5/10 1/100, 10 15 1/1000]; %oxygène réduit mais pas assez on re réduit l'ATP
conf(15,:) = [201 200 10 10 0.1 0.5/10 1/100, 1 15 1/1000]; %presque mais du coup ouais
conf(16,:) = [201 200 1 10 0.01 0.5/10 1/100, 1 15 1/1000]; %presque mais du coup ouais différence marrante avec avant
conf(17,:) = [201 300 10 10 0.02 0.5/10 1/100, 0.1 15 1/1000]; %pNICE !
conf(18,:) = [61 1400 10 10 0.02 0.5/10 1/100, 0.1 50 1/500]; % WORKS !
conf(19,:) = [401 500 10 10 0.02 0.5/10 1/100, 0.1 15 1/1000]; %big one  !
conf(20,:) = [201 500 1 10 0.02 0.5/10 1/100, 0.1 15 1/1000]; %19 works too BUT I want an oxygen gradient over at least 500 µm
conf(21,:) = [201 500 0.1 10 0.02 0.5/10 1/100, 0.1 15 1/1000]; %goudebut gradient not large enough if that doesn't work try to increase glucose consumption-> works but we'll try to increase glucose consumption  weird... max ATP is at the core.
conf(22,:) = [201 500 0.1 30 0.02 0.5/10 1/100, 0.1 15 1/1000]; %try to obtain  mm length gradients for O and G both and THEN adjust for the rest. ATP increases TOWARDS the core in the previous so I try x_g over gluc_g to see if it reverses.
conf(23,:) = [201 500 1 0.1 0.02 0.5/10 1/100, 0.1 15 1/1000]; %better oxygen gradient BUT non zeor concentration at the end (1 µM)
conf(24,:) = [201 500 5 1 0.02 0.5/10 1/100, 0.1 15 1/1000]; % not bad (good ATP) but oxygen gradient less pronounced so not good so 25 will be with both glucose and oxygen lower than 24
conf(25,:) = [201 500 0.3 0.03 0.02 0.5/10 1/100, 0.1 15 1/1000]; % not bad but oxygen gradient less pronounced so not good-> gradient is lss steep but does not results in full depletion so I increase aerobic consumption
conf(26,:) = [201 500 0.3 0.03 0.1 0.5/10 1/100, 0.1 15 1/1000]; %worse for depletion so we DECREASE aerobic consumption
conf(27,:) = [201 500 0.3 0.03 0.005 0.5/10 1/100, 0.1 15 1/1000]; %Gradient of oxygen is not bad and it ends up acceptably low however too much glucose means ATP remains high even at the core.
conf(28,:) = [201 500 0.3 0.6 0.005 0.5/10 1/100, 0.1 15 1/1000]; %same as before
conf(29,:) = [201 500 0.3 5 0.005 0.5/10 1/100, 0.1 15 1/1000]; %NOPE
conf(30,:) = [201 300 10 10 0.02 0.5/10 1/100, 0.1 15 1/1000]; %NOPE
conf(31,:) = [201 300 10 10 0.2 0.5/10 1/100, 0.1 15 1/1000];% not better


dx = conf(31,9)
dt = conf(31,10);

p=0; %trace les courbes intermédiaires

for i =31:31%size(conf,1)
  close all;
    i
  %[G,O,D,GD,T,Gt,Ot,Dt,GDt,Tt,kOct,kGt] = modfsys2DC_sym(conf(i,:));
  [G,O,D,GD,T,Gt,Ot,Dt,GDt,Tt,kOct,kGt] = modfsys2DD_sym(conf(i,:));
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


