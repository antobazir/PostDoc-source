%relaxatiion study in 2D
clear all;
close all;

%sz = conf(1); n_min = conf(2); kO_tissue = conf(3); kG_tissue = conf(4);
%kT_tissue = conf(5); cT =  conf(6); cD = conf(7);kA_tissue = conf(8);
%gamma = conf(9);dx = conf(10);dt = conf(11);

chip_size = 10000;
sz = round(chip_size/15);

%config avec la diffusion au bord bien codée
conf(1,:) = [sz 10 4.5 4 0.03 1 15 1/1500 1 7540 8000 30000];

##conf(1,:) = [sz 60 4.5 0.225 0.03 1 15 1/1500 1 7540 8000 30000];
##
##conf(2,:) = [sz 60 4.5 0.225 0.03 1 15 1/1500 1 7540 4500 30000];
##
##conf(3,:) = [sz 60 4.5 0.225 0.03 1 15 1/1500 1 7540 8000 120000];
##
##conf(4,:) = [sz 60 4.5 0.225 0.03 1 15 1/1500 1 7540 4500 120000];
##
##conf(5,:) = [sz 180 4.5 4 0.03 1 15 1/1500 1 7540 8000 30000];
##
##conf(6,:) = [sz 60 4.5 8 0.03 1 15 1/1500 1 7540 8000 30000];
##
##conf(7,:) = [sz 60 4.5 4 0.03 1 15 1/1500 1 7540 4500 30000];
##
##conf(8,:) = [sz 60 4.5 8 0.03 1 15 1/1500 1 7540 4500 30000];
##
##conf(9,:) = [sz 60 4.5 4 0.03 1 15 1/1500 1 7540 8000 120000];
##
##conf(10,:) = [sz 120 4.5 8 0.03 1 15 1/1500 1 7540 8000 120000];
##
##conf(11,:) = [sz 60 4.5 4 0.03 1 15 1/1500 1 7540 4500 120000];
##
##conf(12,:) = [sz 60 4.5 8 0.03 1 15 1/1500 1 7540 4500 120000];
##
##%config sans augmentation du glcuose au centre
##
##conf(13,:) = [sz 180 4.5 4 0.03 1 15 1/1500 1 7540 8000 30000];
##
##conf(14,:) = [sz 60 4.5 8 0.03 1 15 1/1500 1 7540 4500 120000];



for i =1:1%size(conf,1)

  dx = conf(i,7)
  dt = conf(i,8);

  close all;
    i
  %[G,O,D,GD,T,Gt,Ot,Dt,GDt,Tt,kOct,kGt] = modcfsys2DC_sym(conf(i,:));
  [G,O,Gt,Ot, kGt, kOct, kG, kO, Grid, sycle] = cfsys2DGOr_cc_sym(conf(i,:));

  save("-mat",["/home/antony/Documents/Post-doc/test_fortran/workspaces/GOr_cc/cfsys2DGOrcc_conf" num2str(i) ".mat"]);



  fG = figure;
  aG = axes(fG);
  hold on;
  imagesc(aG,(1:round(conf(i,1)/2))*dx,(1:round(conf(i,1)/2))*dx,G(1:round(conf(i,1)/2),1:round(conf(i,1)/2)))
  colorbar
  set(aG,'outerposition',[0.05 0.05 0.8 0.95])
  xlabel(aG,'position (µm)','fontsize',20)
  ylabel(aG,'position (µm)','fontsize',20)
  theta = pi/2:0.01:pi;
  y = chip_size/2 - round(conf(i,11)/2)*sin(theta);
  x = chip_size/2 + round(conf(i,11)/2)*cos(theta);
  plot(aG,x,y,'r')
  print (fG,["/home/antony/Documents/Post-doc/test_fortran/plots/GOr_cc/cfsys2DGOrcc_G_conf" num2str(i) ".pdf"], "-dpdflatexstandalone","-S480,360","-FCalibri:22");

  fGc = figure;
  aGc = axes(fGc);
  hold on;
  contour(aGc,(1:round(conf(i,1)/2))*dx,(1:round(conf(i,1)/2))*dx,G(1:round(conf(i,1)/2),1:round(conf(i,1)/2)),50)
  colorbar
  grid
  set(aGc,'outerposition',[0.05 0.05 0.8 0.95])
  xlabel(aGc,'position (µm)','fontsize',20)
  ylabel(aGc,'position (µm)','fontsize',20)
  y = sz- round(conf(i,11)/2)*sin(theta);
  x = sz + round(conf(i,11)/2)*cos(theta);
  theta = pi/2:0.01:pi;
  plot(aGc,x,y,'r')
  print (fGc,["/home/antony/Documents/Post-doc/test_fortran/plots/GOr_cc/cfsys2DGOrcc_G_ctr_conf" num2str(i) ".pdf"], "-dpdflatexstandalone","-S480,360","-FCalibri:22");

  figure;
  hold on;
  plot((1:round(conf(i,1)/2))*dx,G(1:round(conf(i,1)/2),round(conf(i,1)/2)))
  grid
  xlabel('position (µm)','fontsize',20)
  ylabel('[G] Concentration (mM)','fontsize',20)
  print (["/home/antony/Documents/Post-doc/test_fortran/plots/GOr_cc/cfsys2DGOrcc_Gline_conf" num2str(i) ".pdf"], "-dpdflatexstandalone","-S480,360","-FCalibri:22");


  fO = figure;
  aO = axes(fO);
  hold on;
  imagesc(aO,(1:round(conf(i,1)/2))*dx,(1:round(conf(i,1)/2))*dx,O(1:round(conf(i,1)/2),1:round(conf(i,1)/2)))
  colorbar
  set(aO,'outerposition',[0.05 0.05 0.8 0.95])
  xlabel(aO,'position (µm)','fontsize',20)
  ylabel(aO,'position (µm)','fontsize',20)
  y = chip_size/2 - round(conf(i,11)/2)*sin(theta);
  x = chip_size/2 + round(conf(i,11)/2)*cos(theta);
  theta = pi/2:0.01:pi;
  plot(aO,x,y,'r')
  print (fO,["/home/antony/Documents/Post-doc/test_fortran/plots/GOr_cc/cfsys2DGOrcc_O_conf" num2str(i) ".pdf"], "-dpdflatexstandalone","-S480,360","-FCalibri:22");

  fOc = figure;
  aOc = axes(fOc);
  hold on;
  contour(aOc,(1:round(conf(i,1)/2))*dx,(1:round(conf(i,1)/2))*dx,O(1:round(conf(i,1)/2),1:round(conf(i,1)/2)),50)
  colorbar
  caxis([0 0.015])
  grid
  set(aOc,'outerposition',[0.05 0.05 0.8 0.95])
  xlabel(aOc,'position (µm)','fontsize',20)
  ylabel(aOc,'position (µm)','fontsize',20)
  y = sz- round(conf(i,11)/2)*sin(theta);
  x = sz + round(conf(i,11)/2)*cos(theta);
  theta = pi/2:0.01:pi;
  plot(aOc,x,y,'r')
  print (fOc,["/home/antony/Documents/Post-doc/test_fortran/plots/GOr_cc/cfsys2DGOrcc_O_ctr_conf" num2str(i) ".pdf"], "-dpdflatexstandalone","-S480,360","-FCalibri:22");


  figure;
  hold on;
  plot((1:round(conf(i,1)/2))*dx,O(1:round(conf(i,1)/2),round(conf(i,1)/2)))
  grid
  xlabel('position (µm)','fontsize',20)
  ylabel('[O] Concentration (mM)','fontsize',20)
  print (["/home/antony/Documents/Post-doc/test_fortran/plots/GOr_cc/cfsys2DGOrcc_Oline_conf" num2str(i) ".pdf"], "-dpdflatexstandalone","-S480,360","-FCalibri:22");


  figure;
  hold on;
  plot((1:length(Gt(:,1)))*dt*100,Gt(:,1))
  plot((1:length(Gt(:,2)))*dt*100,Gt(:,2))
  grid
  xlabel('time (min)','fontsize',20)
  ylabel('[G] Concentration (mM)','fontsize',20)
  legend('center','rim')
  print (["/home/antony/Documents/Post-doc/test_fortran/plots/GOr_cc/cfsys2DGOrcc_Gt_conf" num2str(i) ".pdf"], "-dpdflatexstandalone","-S480,360","-FCalibri:22");

  figure;
  hold on;
  plot((1:length(Gt(:,1)))*dt*100,Ot(:,1))
  plot((1:length(Gt(:,2)))*dt*100,Ot(:,2))
  grid
  xlabel('time (min)','fontsize',20)
  ylabel('[O] Concentration (mM)','fontsize',20)
  legend('center','rim')
  print (["/home/antony/Documents/Post-doc/test_fortran/plots/GOr_cc/cfsys2DGOrcc_Ot_conf" num2str(i) ".pdf"], "-dpdflatexstandalone","-S480,360","-FCalibri:22");

  figure;
  hold on;
  plot((1:length(Gt(:,1)))*dt*100,kGt(:,1))
  plot((1:length(Gt(:,2)))*dt*100,kGt(:,2))
  grid
  xlabel('time (min)','fontsize',20)
  ylabel('G$_{cons}$ magnitude (mM/min)','fontsize',20)
  legend('center','rim')
  print (["/home/antony/Documents/Post-doc/test_fortran/plots/GOr_cc/cfsys2DGOrcc_kGt_conf" num2str(i) ".pdf"], "-dpdflatexstandalone","-S480,360","-FCalibri:22");

  figure;
  hold on;
  plot((1:length(Gt(:,1)))*dt*100,kOct(:,1))
  plot((1:length(Gt(:,2)))*dt*100,kOct(:,2))
  xlabel('time (min)','fontsize',20)
  ylabel('O$_{cons}$ magnitude (mM/min)','fontsize',20)
  legend('center','rim')
  print (["/home/antony/Documents/Post-doc/test_fortran/plots/GOr_cc/cfsys2DGOrcc_kOct_conf" num2str(i) ".pdf"], "-dpdflatexstandalone","-S480,360","-FCalibri:22");

  figure;
  hold on;
  ax = plotyy((1:round(conf(i,1)/2))*dx,G(1:round(conf(i,1)/2),round(conf(i,1)/2))./max(max(G)),(1:round(conf(i,1)/2))*dx,O(1:round(conf(i,1)/2),round(conf(i,1)/2))/max(max(O)));
  a = G(1:round(conf(i,1)/2),round(conf(i,1)/2))./max(max(G))-0.5;
  gl_z = find(abs(a)==min(abs(a)))*dx;
  line([gl_z gl_z],[0 1],'color','blue','linestyle','--');
  a = O(1:round(conf(i,1)/2),round(conf(i,1)/2))./max(max(O))-0.1;
  ox_z = find(abs(a)==min(abs(a)))*dx;
  line([ox_z ox_z],[0 1],'color','red','linestyle','--');
  grid
  xlabel('position (µm)','fontsize',20)
  ylabel(ax(1),'normalised [G]','fontsize',20)
  ylabel(ax(2),'normalised [O]','fontsize',20)
  print (["/home/antony/Documents/Post-doc/test_fortran/plots/GOr_cc/cfsys2DGOrcc_GO_conf" num2str(i) ".pdf"], "-dpdflatexstandalone","-S480,360","-FCalibri:22");

 endfor

