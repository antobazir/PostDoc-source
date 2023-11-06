clear all
%%% cell numbers
Grids = load('ref_conf/metvar0','Grid_r').Grid_r;
Grids_Gl = load('ref_conf/metvar0_Gl','Grid_r').Grid_r;
Grids_Ox = load('ref_conf/metvar0_Ox','Grid_r').Grid_r;

for i=1:7
  growth(i,1) = length(find(Grids(:,:,i)!=0));
  growth(i,2) = length(find(Grids_Gl(:,:,i)!=0));
  growth(i,3) = length(find(Grids_Ox(:,:,i)!=0));
endfor

F = figure('visible','off');
aF = axes(F);
hold on;
plot(aF,growth(:,1),'-+')
plot(aF,growth(:,2),'-x')
plot(aF,growth(:,3),'-o')
xlabel(aF,'divisions','fontsize',20)
ylabel(aF,'cell number','fontsize',20)
set(aF,'outerposition',[0.05 0.05 0.8 0.95])
print (F,["/home/antony/Documents/Post-doc/test_fortran/metabolic variety/Simple version/plots/ref_conf/C_inact.pdf"], "-dpdflatexstandalone","-S480,360","-FCalibri:22");



S_Gl = load('ref_conf/metvar0_Gl','S_r').S_r;
S_Ox = load('ref_conf/metvar0_Ox','S_r').S_r;
O_Gl = load('ref_conf/metvar0_Gl','O_r').O_r;
O_Ox = load('ref_conf/metvar0_Ox','O_r').O_r;
dx = load('ref_conf/metvar0','dx').dx;
sz = load('ref_conf/metvar0','sz').sz;

F = figure('visible','off');
aF = axes(F);
contour(aF,((1:sz)-sz/2)*dx,((1:sz)-sz/2)*dx,S_Gl(:,:,4))
xlabel(aF,'position (µm)','fontsize',20)
ylabel(aF,'position (µm)','fontsize',20)
set(aF,'outerposition',[0.05 0.05 0.85 0.95])
colorbar(aF)
axis(aF,[-1000 1000 -1000 1000]);
print (F,["/home/antony/Documents/Post-doc/test_fortran/metabolic variety/Simple version/plots/ref_conf/S_inact_Gl.pdf"], "-dpdflatexstandalone","-S480,360","-FCalibri:22");

F = figure('visible','off');
aF = axes(F);
contour(aF,((1:sz)-sz/2)*dx,((1:sz)-sz/2)*dx,O_Gl(:,:,4))
xlabel(aF,'position (µm)','fontsize',20)
ylabel(aF,'position (µm)','fontsize',20)
set(aF,'outerposition',[0.05 0.05 0.85 0.95])
colorbar(aF);
axis(aF,[-1000 1000 -1000 1000]);
print (F,["/home/antony/Documents/Post-doc/test_fortran/metabolic variety/Simple version/plots/ref_conf/O_inact_Gl.pdf"], "-dpdflatexstandalone","-S480,360","-FCalibri:22");

F = figure('visible','off');
aF = axes(F)
contour(aF,((1:sz)-sz/2)*dx,((1:sz)-sz/2)*dx,S_Ox(:,:,4))
xlabel(aF,'position (µm)','fontsize',20)
ylabel(aF,'position (µm)','fontsize',20)
set(aF,'outerposition',[0.05 0.05 0.85 0.95])
colorbar(aF);
axis(aF,[-1000 1000 -1000 1000]);
print (F,["/home/antony/Documents/Post-doc/test_fortran/metabolic variety/Simple version/plots/ref_conf/S_inact_Ox.pdf"], "-dpdflatexstandalone","-S480,360","-FCalibri:22");

F = figure('visible','off');
aF = axes(F)
contour(aF,((1:sz)-sz/2)*dx,((1:sz)-sz/2)*dx,O_Ox(:,:,4))
xlabel(aF,'position (µm)','fontsize',20)
ylabel(aF,'position (µm)','fontsize',20)
set(aF,'outerposition',[0.05 0.05 0.85 0.95])
colorbar(aF);
axis(aF,[-1000 1000 -1000 1000]);
print (F,["/home/antony/Documents/Post-doc/test_fortran/metabolic variety/Simple version/plots/ref_conf/O_inact_Ox.pdf"], "-dpdflatexstandalone","-S480,360","-FCalibri:22");


