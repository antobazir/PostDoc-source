clear all
%%% cell numbers
Grids = load('ref_conf/metvar','Grid_r').Grid_r;
Grids_Gl = load('ref_conf/metvar_Gl','Grid_r').Grid_r;
Grids_Ox = load('ref_conf/metvar_Ox','Grid_r').Grid_r;
Grids1 = load('ref_conf/metvar1','Grid_r').Grid_r;
Grids1_Gl = load('ref_conf/metvar1_Gl','Grid_r').Grid_r;
Grids1_Ox = load('ref_conf/metvar1_Ox','Grid_r').Grid_r;
Grids2 = load('ref_conf/metvar2','Grid_r').Grid_r;
Grids2_Gl = load('ref_conf/metvar2_Gl','Grid_r').Grid_r;
Grids2_Ox = load('ref_conf/metvar2_Ox','Grid_r').Grid_r;
Grids3 = load('ref_conf/metvar3','Grid_r').Grid_r;
Grids3_Gl = load('ref_conf/metvar3_Gl','Grid_r').Grid_r;
Grids3_Ox = load('ref_conf/metvar3_Ox','Grid_r').Grid_r;
Grids4 = load('ref_conf/metvar4','Grid_r').Grid_r;
Grids4_Gl = load('ref_conf/metvar4_Gl','Grid_r').Grid_r;
Grids4_Ox = load('ref_conf/metvar4_Ox','Grid_r').Grid_r;



for i=1:14
  growth(i,1) = length(find(Grids(:,:,i)!=0));
  growth(i,2) = length(find(Grids_Gl(:,:,i)!=0));
  growth(i,3) = length(find(Grids_Ox(:,:,i)!=0));
  growth(i,4) = length(find(Grids1(:,:,i)!=0));
  growth(i,5) = length(find(Grids1_Gl(:,:,i)!=0));
  growth(i,6) = length(find(Grids1_Ox(:,:,i)!=0));
  growth(i,7) = length(find(Grids2(:,:,i)!=0));
  growth(i,8) = length(find(Grids2_Gl(:,:,i)!=0));
  growth(i,9) = length(find(Grids2_Ox(:,:,i)!=0));
  growth(i,10) = length(find(Grids3(:,:,i)!=0));
  growth(i,11) = length(find(Grids3_Gl(:,:,i)!=0));
  growth(i,12) = length(find(Grids3_Ox(:,:,i)!=0));
  growth(i,13) = length(find(Grids4(:,:,i)!=0));
  growth(i,14) = length(find(Grids4_Gl(:,:,i)!=0));
  growth(i,15) = length(find(Grids4_Ox(:,:,i)!=0));
endfor

F = figure('visible','off');
aF = axes(F);
hold on;
plot(aF,growth(:,1),'-+')
plot(aF,growth(:,2),'-x')
plot(aF,growth(:,3),'-o')
plot(aF,growth(:,4),'-+')
plot(aF,growth(:,5),'-x')
plot(aF,growth(:,6),'-o')
plot(aF,growth(:,7),'-+')
plot(aF,growth(:,8),'-x')
plot(aF,growth(:,9),'-o')
plot(aF,growth(:,10),'-+')
plot(aF,growth(:,11),'-x')
plot(aF,growth(:,12),'-o')
plot(aF,growth(:,13),'-+')
plot(aF,growth(:,14),'-x')
plot(aF,growth(:,15),'-o')
xlabel(aF,'divisions','fontsize',20)
ylabel(aF,'cell number','fontsize',20)
set(aF,'outerposition',[0.05 0.05 0.8 0.95])
print (F,["/home/antony/Documents/Post-doc/test_fortran/metabolic variety/Simple version/plots/ref_conf/C_inact.pdf"], "-dpdflatexstandalone","-S480,360","-FCalibri:22");


%
S_Gl = load('ref_conf/metvar_Gl','S_r').S_r;
S_Ox = load('ref_conf/metvar_Ox','S_r').S_r;
O_Gl = load('ref_conf/metvar_Gl','O_r').O_r;
O_Ox = load('ref_conf/metvar_Ox','O_r').O_r;
Grids = load('ref_conf/metvar','Grid_r').Grid_r;
Grids_Gl = load('ref_conf/metvar_Gl','Grid_r').Grid_r;
Grids_Ox = load('ref_conf/metvar_Ox','Grid_r').Grid_r;
dx = load('ref_conf/metvar','dx').dx;
sz = load('ref_conf/metvar','sz').sz;


for i=1:14
  idxs = find(Grids(:,:,i)!=0);
  [rows cols] = ind2sub([size(Grids,1),size(Grids,2)],idxs);
  rows = rows - round(size(Grids,1)/2); cols = cols - round(size(Grids,2)/2);
  diam(i) = max([max(rows) max(cols)])*dx;

   idxs = find(Grids_Gl(:,:,i)!=0);
  [rows cols] = ind2sub([size(Grids,1),size(Grids,2)],idxs);
  rows = rows - round(size(Grids,1)/2); cols = cols - round(size(Grids,2)/2);
  diam_Gl(i) = max([max(rows) max(cols)])*dx;

     idxs = find(Grids_Ox(:,:,i)!=0);
  [rows cols] = ind2sub([size(Grids,1),size(Grids,2)],idxs);
  rows = rows - round(size(Grids,1)/2); cols = cols - round(size(Grids,2)/2);
  diam_Ox(i) = max([max(rows) max(cols)])*dx;
endfor

%10 Gl 12 OX is the best diameter to compare.

F = figure('visible','off');
aF = axes(F);
contour(aF,((1:sz)-sz/2)*dx,((1:sz)-sz/2)*dx,S_Gl(:,:,10))
xlabel(aF,'position (µm)','fontsize',20)
ylabel(aF,'position (µm)','fontsize',20)
set(aF,'outerposition',[0.05 0.05 0.85 0.95])
colorbar(aF)
axis(aF,[-1000 1000 -1000 1000]);
print (F,["/home/antony/Documents/Post-doc/test_fortran/metabolic variety/Simple version/plots/ref_conf/S_inact_Gl.pdf"], "-dpdflatexstandalone","-S480,360","-FCalibri:22");

F = figure('visible','off');
aF = axes(F);
contour(aF,((1:sz)-sz/2)*dx,((1:sz)-sz/2)*dx,O_Gl(:,:,10))
xlabel(aF,'position (µm)','fontsize',20)
ylabel(aF,'position (µm)','fontsize',20)
set(aF,'outerposition',[0.05 0.05 0.85 0.95])
colorbar(aF);
axis(aF,[-1000 1000 -1000 1000]);
print (F,["/home/antony/Documents/Post-doc/test_fortran/metabolic variety/Simple version/plots/ref_conf/O_inact_Gl.pdf"], "-dpdflatexstandalone","-S480,360","-FCalibri:22");

F = figure('visible','off');
aF = axes(F)
contour(aF,((1:sz)-sz/2)*dx,((1:sz)-sz/2)*dx,S_Ox(:,:,12))
xlabel(aF,'position (µm)','fontsize',20)
ylabel(aF,'position (µm)','fontsize',20)
set(aF,'outerposition',[0.05 0.05 0.85 0.95])
colorbar(aF);
axis(aF,[-1000 1000 -1000 1000]);
print (F,["/home/antony/Documents/Post-doc/test_fortran/metabolic variety/Simple version/plots/ref_conf/S_inact_Ox.pdf"], "-dpdflatexstandalone","-S480,360","-FCalibri:22");

F = figure('visible','off');
aF = axes(F)
contour(aF,((1:sz)-sz/2)*dx,((1:sz)-sz/2)*dx,O_Ox(:,:,12))
xlabel(aF,'position (µm)','fontsize',20)
ylabel(aF,'position (µm)','fontsize',20)
set(aF,'outerposition',[0.05 0.05 0.85 0.95])
colorbar(aF);
axis(aF,[-1000 1000 -1000 1000]);
print (F,["/home/antony/Documents/Post-doc/test_fortran/metabolic variety/Simple version/plots/ref_conf/O_inact_Ox.pdf"], "-dpdflatexstandalone","-S480,360","-FCalibri:22");



%imagesc(aF,((1:sz)-sz/2)*dx,((1:sz)-sz/2)*dx,S_Gl(:,:,12))
