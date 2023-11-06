clear all;
close all;

Grids_Gl = load('hypoxia_A4B2/metvar1_Gl','Grid_r').Grid_r;
Grids_Ox = load('hypoxia_A4B2/metvar1_Ox','Grid_r').Grid_r;

S_Gl = load('hypoxia_A4B2/metvar1_Gl','S_r').S_r;
kS_Gl = load('hypoxia_A4B2/metvar1_Gl','kS_r').kS_r;
St_Gl = load('hypoxia_A4B2/metvar1_Gl','St_r').St_r;
O_Gl = load('hypoxia_A4B2/metvar1_Gl','O_r').O_r;
Ot = load('hypoxia_A4B2/metvar1_Gl','Ot_r').Ot_r;
kO_Gl = load('hypoxia_A4B2/metvar1_Gl','kO_r').kO_r;
S_Ox = load('hypoxia_A4B2/metvar1_Ox','S_r').S_r;
kS_Ox = load('hypoxia_A4B2/metvar1_Ox','kS_r').kS_r;
O_Ox = load('hypoxia_A4B2/metvar1_Ox','O_r').O_r;
kO_Ox = load('hypoxia_A4B2/metvar1_Ox','kO_r').kO_r;
dx = load('hypoxia_A4B2/metvar1_Gl','dx').dx;
sz = load('hypoxia_A4B2/metvar1_Gl','sz').sz;

for i=1:11
  live(i,1) = length(find(and(Grids_Gl(:,:,i)!=0,kS_Gl(:,:,i)!=0)));
  live(i,2) = length(find(and(Grids_Ox(:,:,i)!=0,kS_Ox(:,:,i)!=0)));
  dead(i,1) = length(find(and(Grids_Gl(:,:,i)!=0,kS_Gl(:,:,i)==0)));
  dead(i,2) = length(find(and(Grids_Ox(:,:,i)!=0,kS_Ox(:,:,i)==0)));
endfor


F = figure('visible','off');
aF = axes(F);
hold on;
semilogy(aF,live(:,1),'-o','color','r')
semilogy(aF,live(:,2),'-o','color','b')
semilogy(aF,dead(:,1),'-x','color','r')
semilogy(aF,dead(:,2),'-x','color','b')
xlabel(aF,'divisions','fontsize',20)
ylabel(aF,'cell number','fontsize',20)
legend('more subst','more oxy.','location','northwest')
set(aF,'outerposition',[0.05 0.05 0.9 0.95])
print (F,["/home/antony/Documents/Post-doc/test_fortran/metabolic variety/Simple version/plots/hypoxia_A4B2/C_hypoxia_A4B2.pdf"], "-dpdflatexstandalone","-S480,360","-FCalibri:22");



kSmap = [kS_Gl(:,1:round(sz/2),:) kS_Ox(:,round(sz/2)+1:sz,:)];
Smap = [S_Gl(:,1:round(sz/2),:) S_Ox(:,round(sz/2)+1:sz,:)];
Omap = [O_Gl(:,1:round(sz/2),:) O_Ox(:,round(sz/2)+1:sz,:)];

F = figure('visible','off');
aF = axes(F);
imagesc(aF,((1:sz)-sz/2)*dx,((1:sz)-sz/2)*dx,kSmap(:,:,5))
xlabel(aF,'position (µm)','fontsize',20)
ylabel(aF,'position (µm)','fontsize',20)
set(aF,'outerposition',[0.05 0.05 0.85 0.95])
text(-0.25*round(sz/2)*dx,-0.25*round(sz/2)*dx,'more subst.','color','white','horizontalalignment','center')
text(0.25*round(sz/2)*dx,-0.25*round(sz/2)*dx,'more oxy.','color','white','horizontalalignment','center')
line([0 0], [-round(sz/2)*dx round(sz/2)*dx],'color','white')
%colorbar(aF);
axis(aF,[-2000 2000 -2000 2000]);
print (F,["/home/antony/Documents/Post-doc/test_fortran/metabolic variety/Simple version/plots/hypoxia_A4B2/Cmap_hypoxia_A4B2_J5.pdf"], "-dpdflatexstandalone","-S480,360","-FCalibri:22");

F = figure('visible','off');
aF = axes(F);
imagesc(aF,((1:sz)-sz/2)*dx,((1:sz)-sz/2)*dx,kSmap(:,:,11))
xlabel(aF,'position (µm)','fontsize',20)
ylabel(aF,'position (µm)','fontsize',20)
set(aF,'outerposition',[0.05 0.05 0.85 0.95])
text(-0.25*round(sz/2)*dx,-0.25*round(sz/2)*dx,'more subst.','color','white','horizontalalignment','center')
text(0.25*round(sz/2)*dx,-0.25*round(sz/2)*dx,'more oxy.','color','white','horizontalalignment','center')
line([0 0], [-round(sz/2)*dx round(sz/2)*dx],'color','white')
%colorbar(aF);
axis(aF,[-2000 2000 -2000 2000]);
print (F,["/home/antony/Documents/Post-doc/test_fortran/metabolic variety/Simple version/plots/hypoxia_A4B2/Cmap_hypoxia_A4B2_J11.pdf"], "-dpdflatexstandalone","-S480,360","-FCalibri:22");


idx = 11

F = figure('visible','off');
aF = axes(F);
%aF2 = axes(F);
%aP1 = imagesc(aF1,((1:sz)-sz/2)*dx,((1:sz)-sz/2)*dx,kS(:,:,idx)./max(max(kS(:,:,idx))))
%hold on;
%aP2 = contour(aF2,((1:sz)-sz/2)*dx,((1:sz)-sz/2)*dx,S(:,:,idx),'linewidth',2)
contour(((1:sz)-sz/2)*dx,((1:sz)-sz/2)*dx,Smap(:,:,idx))
xlabel(aF,'position (µm)','fontsize',20)
ylabel(aF,'position (µm)','fontsize',20)
set(aF,'outerposition',[0.05 0.05 0.85 0.95])
text(-0.5*round(sz/2)*dx,-0.5*round(sz/2)*dx,'more subst.','horizontalalignment','center')
text(0.5*round(sz/2)*dx,-0.5*round(sz/2)*dx,'more oxy.','horizontalalignment','center')
text(-0.2*round(sz/2)*dx,0,num2str(min(min(S_Gl(:,:,idx)))),'horizontalalignment','center')
text(0.2*round(sz/2)*dx,0,num2str(min(min(S_Ox(:,:,idx)))),'horizontalalignment','center')
line([0 0], [-round(sz/2)*dx round(sz/2)*dx])
caxis([0 1])
%colorbar(aF1,'gray')
%axis(aF,[-2000 2000 -2000 2000]);
print (F,["/home/antony/Documents/Post-doc/test_fortran/metabolic variety/Simple version/plots/hypoxia_A4B2/S_hypoxia_A4B2.pdf"], "-dpdflatexstandalone","-S480,360","-FCalibri:22");


F = figure('visible','off');
aF = axes(F);
hold on;
%aF2 = axes(F);
%aP1 = imagesc(aF1,((1:sz)-sz/2)*dx,((1:sz)-sz/2)*dx,kS(:,:,idx)./max(max(kS(:,:,idx))))
%hold on;
%aP2 = contour(aF2,((1:sz)-sz/2)*dx,((1:sz)-sz/2)*dx,S(:,:,idx),'linewidth',2)
plot(((1:sz)-sz/2)*dx,Smap(round(sz/2),:,4))
plot(((1:sz)-sz/2)*dx,Smap(round(sz/2),:,7))
plot(((1:sz)-sz/2)*dx,Smap(round(sz/2),:,11))
%plot(((1:sz)-sz/2)*dx,Omap(round(sz/2),:,idx),'-o')
xlabel(aF,'position (µm)','fontsize',20)
ylabel(aF,'Subst. concentration','fontsize',20)
set(aF,'outerposition',[0.05 0.05 0.85 0.95])
text(-0.5*round(sz/2)*dx,0.8,'more subst.','horizontalalignment','center')
text(0.5*round(sz/2)*dx,0.8,'more oxy.','horizontalalignment','center')
%text(-0.2*round(sz/2)*dx,0,num2str(min(min(S(:,:,idx)))),'horizontalalignment','center')
%text(0.2*round(sz/2)*dx,0,num2str(min(min(S_Ox(:,:,idx)))),'horizontalalignment','center')
line([0 0], [-round(sz/2)*dx round(sz/2)*dx],'color','black')
ylim([0 1.2])
%colorbar(aF1,'gray')
%axis(aF,[-2000 2000 -2000 2000]);
print (F,["/home/antony/Documents/Post-doc/test_fortran/metabolic variety/Simple version/plots/hypoxia_A4B2/S_hypoxia_A4B2.pdf"], "-dpdflatexstandalone","-S480,360","-FCalibri:22");


F = figure('visible','off');
aF = axes(F);
contour(aF,((1:sz)-sz/2)*dx,((1:sz)-sz/2)*dx,Omap(:,:,idx))
xlabel(aF,'position (µm)','fontsize',20)
ylabel(aF,'position (µm)','fontsize',20)
set(aF,'outerposition',[0.05 0.05 0.85 0.95])
text(-0.5*round(sz/2)*dx,-0.5*round(sz/2)*dx,'more subst.','horizontalalignment','center')
text(0.5*round(sz/2)*dx,-0.5*round(sz/2)*dx,'more oxy.','horizontalalignment','center')
text(-0.2*round(sz/2)*dx,0,num2str(min(min(O_Gl(:,:,idx)))),'horizontalalignment','center')
text(0.2*round(sz/2)*dx,0,num2str(min(min(O_Ox(:,:,idx)))),'horizontalalignment','center')
line([0 0], [-round(sz/2)*dx round(sz/2)*dx])
caxis([0 1])
colorbar(aF);
%axis(aF,[-2000 2000 -2000 2000]);
print (F,["/home/antony/Documents/Post-doc/test_fortran/metabolic variety/Simple version/plots/hypoxia_A4B2/O_hypoxia_A4B2.pdf"], "-dpdflatexstandalone","-S480,360","-FCalibri:22");


F = figure('visible','off');
aF = axes(F);
hold on;
%aF2 = axes(F);
%aP1 = imagesc(aF1,((1:sz)-sz/2)*dx,((1:sz)-sz/2)*dx,kS(:,:,idx)./max(max(kS(:,:,idx))))
%hold on;
%aP2 = contour(aF2,((1:sz)-sz/2)*dx,((1:sz)-sz/2)*dx,S(:,:,idx),'linewidth',2)
plot(((1:sz)-sz/2)*dx,Omap(round(sz/2),:,4))
plot(((1:sz)-sz/2)*dx,Omap(round(sz/2),:,7))
plot(((1:sz)-sz/2)*dx,Omap(round(sz/2),:,11))
%plot(((1:sz)-sz/2)*dx,Omap(round(sz/2),:,idx),'-o')
xlabel(aF,'position (µm)','fontsize',20)
ylabel(aF,'Oxy. concentration','fontsize',20)
set(aF,'outerposition',[0.05 0.05 0.85 0.95])
text(-0.5*round(sz/2)*dx,0.8,'more subst.','horizontalalignment','center')
text(0.5*round(sz/2)*dx,0.8,'more oxy.','horizontalalignment','center')
%text(-0.2*round(sz/2)*dx,0,num2str(min(min(S(:,:,idx)))),'horizontalalignment','center')
%text(0.2*round(sz/2)*dx,0,num2str(min(min(S_Ox(:,:,idx)))),'horizontalalignment','center')
line([0 0], [-round(sz/2)*dx round(sz/2)*dx],'color','black')
ylim([0 1.2])
%colorbar(aF1,'gray')
%axis(aF,[-2000 2000 -2000 2000]);
print (F,["/home/antony/Documents/Post-doc/test_fortran/metabolic variety/Simple version/plots/hypoxia_A4B2/O_hypoxia_A4B2.pdf"], "-dpdflatexstandalone","-S480,360","-FCalibri:22");

##
##
##Grids_in = load('ref_conf/metvar1','Grid_r').Grid_r
##S_in = load('ref_conf/metvar1','S_r').S_r;
##kS_in = load('ref_conf/metvar1','kS_r').kS_r;
##St_in = load('ref_conf/metvar1','St_r').St_r;
##O_in = load('ref_conf/metvar1','O_r').O_r;
##Ot_in = load('ref_conf/metvar1','Ot_r').Ot_r;
##kO_in = load('ref_conf/metvar1','kO_r').kO_r;
##
##
##for i=1:7
##  live_in(i,1) = length(find(and(Grids(:,:,i)!=0,kS(:,:,i)!=0)));
##  live_in(i,2) = length(find(and(Grids_in(:,:,i)!=0,kS_in(:,:,i)!=0)));
##  dead_in(i,1) = length(find(and(Grids(:,:,i)!=0,kS(:,:,i)==0)));
##  dead_in(i,2) = length(find(and(Grids_in(:,:,i)!=0,kS_in(:,:,i)==0)));
##endfor
##
##
##F = figure('visible','off');
##aF = axes(F);
##hold on;
##semilogy(aF,live_in(:,1),'-o','color','r')
##semilogy(aF,live_in(:,2),'-o','color','b')
##semilogy(aF,dead_in(:,1),'-x','color','r')
##semilogy(aF,dead_in(:,2),'-x','color','b')
##xlabel(aF,'divisions','fontsize',20)
##ylabel(aF,'cell number','fontsize',20)
##legend('normal cons.','high cons.','location','northwest')
##set(aF,'outerposition',[0.05 0.05 0.9 0.95])
##print (F,["/home/antony/Documents/Post-doc/test_fortran/metabolic variety/Simple version/plots/hypoxia_A4B2/C_hypoxia_A4B2_in.pdf"], "-dpdflatexstandalone","-S480,360","-FCalibri:22");
##
##kSmap = [kS(:,1:round(sz/2),:) kS_in(:,round(sz/2)+1:sz,:)];
##Smap = [S(:,1:round(sz/2),:) S_in(:,round(sz/2)+1:sz,:)];
##Omap = [O(:,1:round(sz/2),:) O_in(:,round(sz/2)+1:sz,:)];
##
##
##F = figure('visible','off');
##aF = axes(F);
##imagesc(aF,((1:sz)-sz/2)*dx,((1:sz)-sz/2)*dx,kSmap(:,:,4))
##xlabel(aF,'position (µm)','fontsize',20)
##ylabel(aF,'position (µm)','fontsize',20)
##set(aF,'outerposition',[0.05 0.05 0.85 0.95])
##text(-0.5*round(sz/2)*dx,-0.5*round(sz/2)*dx,'hypoxia_A4B2.','color','white','horizontalalignment','center')
##text(0.5*round(sz/2)*dx,-0.5*round(sz/2)*dx,'passive','color','white','horizontalalignment','center')
##line([0 0], [-round(sz/2)*dx round(sz/2)*dx],'color','white')
##%colorbar(aF);
##%axis(aF,[-1000 1000 -1000 1000]);
##print (F,["/home/antony/Documents/Post-doc/test_fortran/metabolic variety/Simple version/plots/hypoxia_A4B2/Cmap_hypoxia_A4B2_in_J4.pdf"], "-dpdflatexstandalone","-S480,360","-FCalibri:22");
##
##F = figure('visible','off');
##aF = axes(F);
##imagesc(aF,((1:sz)-sz/2)*dx,((1:sz)-sz/2)*dx,kSmap(:,:,9))
##xlabel(aF,'position (µm)','fontsize',20)
##ylabel(aF,'position (µm)','fontsize',20)
##set(aF,'outerposition',[0.05 0.05 0.85 0.95])
##text(-0.5*round(sz/2)*dx,-0.5*round(sz/2)*dx,'hypoxia_A4B2.','color','white','horizontalalignment','center')
##text(0.5*round(sz/2)*dx,-0.5*round(sz/2)*dx,'passive','color','white','horizontalalignment','center')
##line([0 0], [-round(sz/2)*dx round(sz/2)*dx],'color','white')
##%colorbar(aF);
##%axis(aF,[-1000 1000 -1000 1000]);
##print (F,["/home/antony/Documents/Post-doc/test_fortran/metabolic variety/Simple version/plots/hypoxia_A4B2/Cmap_hypoxia_A4B2_in_J9.pdf"], "-dpdflatexstandalone","-S480,360","-FCalibri:22");
##
##
##F = figure('visible','off');
##aF = axes(F);
##hold on;
##%aF2 = axes(F);
##%aP1 = imagesc(aF1,((1:sz)-sz/2)*dx,((1:sz)-sz/2)*dx,kS(:,:,idx)./max(max(kS(:,:,idx))))
##%hold on;
##%aP2 = contour(aF2,((1:sz)-sz/2)*dx,((1:sz)-sz/2)*dx,S(:,:,idx),'linewidth',2)
##plot(((1:sz)-sz/2)*dx,Smap(round(sz/2),:,4))
##plot(((1:sz)-sz/2)*dx,Smap(round(sz/2),:,6))
##plot(((1:sz)-sz/2)*dx,Smap(round(sz/2),:,9))
##%plot(((1:sz)-sz/2)*dx,Omap(round(sz/2),:,idx),'-o')
##xlabel(aF,'position (µm)','fontsize',20)
##ylabel(aF,'concentration','fontsize',20)
##set(aF,'outerposition',[0.05 0.05 0.85 0.95])
##text(-0.5*round(sz/2)*dx,0.8,'hypoxia_A4B2.','horizontalalignment','center')
##text(0.5*round(sz/2)*dx,0.8,'passive','horizontalalignment','center')
##%text(-0.2*round(sz/2)*dx,0,num2str(min(min(S(:,:,idx)))),'horizontalalignment','center')
##%text(0.2*round(sz/2)*dx,0,num2str(min(min(S_Ox(:,:,idx)))),'horizontalalignment','center')
##line([0 0], [-round(sz/2)*dx round(sz/2)*dx],'color','black')
##ylim([0 1.2])
##%colorbar(aF1,'gray')
##%axis(aF,[-2000 2000 -2000 2000]);
##print (F,["/home/antony/Documents/Post-doc/test_fortran/metabolic variety/Simple version/plots/hypoxia_A4B2/S_hypoxia_A4B2_in.pdf"], "-dpdflatexstandalone","-S480,360","-FCalibri:22");
##
##F = figure('visible','off');
##aF = axes(F);
##hold on;
##%aF2 = axes(F);
##%aP1 = imagesc(aF1,((1:sz)-sz/2)*dx,((1:sz)-sz/2)*dx,kS(:,:,idx)./max(max(kS(:,:,idx))))
##%hold on;
##%aP2 = contour(aF2,((1:sz)-sz/2)*dx,((1:sz)-sz/2)*dx,S(:,:,idx),'linewidth',2)
##plot(((1:sz)-sz/2)*dx,Omap(round(sz/2),:,4))
##plot(((1:sz)-sz/2)*dx,Omap(round(sz/2),:,6))
##plot(((1:sz)-sz/2)*dx,Omap(round(sz/2),:,9))
##%plot(((1:sz)-sz/2)*dx,Omap(round(sz/2),:,idx),'-o')
##xlabel(aF,'position (µm)','fontsize',20)
##ylabel(aF,'concentration','fontsize',20)
##set(aF,'outerposition',[0.05 0.05 0.85 0.95])
##text(-0.5*round(sz/2)*dx,0.8,'hypoxia_A4B2.','horizontalalignment','center')
##text(0.5*round(sz/2)*dx,0.8,'passive','horizontalalignment','center')
##%text(-0.2*round(sz/2)*dx,0,num2str(min(min(S(:,:,idx)))),'horizontalalignment','center')
##%text(0.2*round(sz/2)*dx,0,num2str(min(min(S_Ox(:,:,idx)))),'horizontalalignment','center')
##line([0 0], [-round(sz/2)*dx round(sz/2)*dx],'color','black')
##ylim([0 1.2])
##%colorbar(aF1,'gray')
##%axis(aF,[-2000 2000 -2000 2000]);
##print (F,["/home/antony/Documents/Post-doc/test_fortran/metabolic variety/Simple version/plots/hypoxia_A4B2/O_hypoxia_A4B2_in.pdf"], "-dpdflatexstandalone","-S480,360","-FCalibri:22");


