%This is the script used for data generation.
% The goal is to make data generation more streamlined and tracable
% It calls the metvar function and generates datasets
% it also generates the necessary plots


clear all;
close all;
pkg load image%needed for the migration code

folder_name  = 'ref_conf';
behavior = 0; %means no behavior

%checks that the folder exists
if(exist(folder_name)==0)
	system(['mkdir ' folder_name]);
endif

%initiation of the different cases
kS_arg(1) =  7; kO_arg(1) = 49; filename(1,:) = [folder_name '/Id'];
kS_arg(2) =  7; kO_arg(2) = 4.9; filename(2,:) = [folder_name '/Ox'];
kS_arg(3) =  0.7; kO_arg(3) = 49; filename(3,:) = [folder_name '/Gl'];

for i=1:3
%if the file exists don't do the calculations
  if(exist(filename(i,:))==0)
    disp('calcul lancé')
    metvar_f(kO_arg(i),kS_arg(i),behavior,filename(i,:));
  endif
endfor

for i=1:3
  Grids(:,:,:,i) = load(filename(i,:),'Grid_r').Grid_r;
  S(:,:,:,i) = load(filename(i,:),'S_r').S_r;
  kS(:,:,:,i) = load(filename(i,:),'kS_r').kS_r;
  St(:,:,:,i) = load(filename(i,:),'St_r').St_r;
  O(:,:,:,i) = load(filename(i,:),'O_r').O_r;
  P(:,:,:,i) = load(filename(i,:),'P_r').P_r;
  state_mat(:,:,:,i) = load(filename(i,:),'state_mat_r').state_mat_r;
  sz(:,:,:,i) = load(filename(i,:),'sz').sz;
  dx(:,:,:,i) = load(filename(i,:),'dx').dx;
  dt(:,:,:,i) = load(filename(i,:),'dt').dt;
endfor

pos = (-round(sz(:,:,:,3)/2)+1:round(sz(:,:,:,3)/2))*dx(:,:,:,3)*1e-3;
Smap = [S(:,1:round(sz/2),:,2) S(:,round(sz/2)+1:sz,:,3)];
Omap = [O(:,1:round(sz/2),:,2) O(:,round(sz/2)+1:sz,:,3)];
state_map = [state_mat(:,1:round(sz/2),:,2) state_mat(:,round(sz/2)+1:sz,:,3)];

for i=1:5
  live(i,1) = length(find(and(Grids(:,:,i,2)!=0,kS(:,:,i,2)!=0)));
  live(i,2) = length(find(and(Grids(:,:,i,3)!=0,kS(:,:,i,3)!=0)));
endfor



%cell number
F = figure('visible','off');
aF = axes(F);
hold on;
semilogy(aF,live(:,1),'-o','color','r')
semilogy(aF,live(:,2),'-o','color','b')
xlabel(aF,'divisions','fontsize',20)
ylabel(aF,'cell number','fontsize',20,'position',[0 100 0])
%legend('normal cons.','high cons.','location','northwest')
set(aF,'outerposition',[0 0.05 0.9 0.95])
print(F,["/home/antony/Documents/Post-doc/Redac/metvar/" folder_name "_Cnum.pdf"], "-dpdflatex","-S240,180","-FCalibri:24");

F = figure('visible','off');
aF = axes(F);
imagesc(aF,pos,pos,state_map(:,:,size(state_map,3)))
xlabel(aF,'position (mm)','fontsize',20)
ylabel(aF,'position (mm)','fontsize',20)
set(aF,'outerposition',[0.05 0.05 0.95 0.95])
print(F,["/home/antony/Documents/Post-doc/Redac/metvar/" folder_name "_statemap.pdf"], "-dpdflatex","-S240,180","-FCalibri:24");


F = figure('visible','off');
aF = axes(F);
hold on;
plot(pos,Smap(round(sz(:,:,:,3)/2),:,2),'color','blue')
plot(pos,Smap(round(sz(:,:,:,3)/2),:,4),'color','red')
plot(pos,Smap(round(sz(:,:,:,3)/2),:,6),'color','green')
line([0 0],[0 1.2],'color','black')
xlabel(aF,'position (mm)','fontsize',20)
ylabel(aF,'Subs concentration','fontsize',20)
ylim([0 1.2])
legend(aF,'d2','d4','d6','location','northwest');
text(round(sz(:,:,:,3)/3).*dx(:,:,:,3)*1e-3,0.5,'high subs','horizontalalignment','center')
text(-round(sz(:,:,:,3)/3).*dx(:,:,:,3)*1e-3,0.5,'low subs','horizontalalignment','center')
set(aF,'outerposition',[0.05 0.05 0.95 0.95])
print(F,["/home/antony/Documents/Post-doc/Redac/metvar/" folder_name "_Sub.pdf"], "-dpdflatex","-S240,180","-FCalibri:24");

F = figure('visible','off');
aF = axes(F);
hold on;
plot(pos,Omap(round(sz(:,:,:,3)/2),:,2),'color','blue')
plot(pos,Omap(round(sz(:,:,:,3)/2),:,4),'color','red')
plot(pos,Omap(round(sz(:,:,:,3)/2),:,6),'color','green')
line([0 0],[0 1.2],'color','black')
xlabel(aF,'position (mm)','fontsize',20)
ylabel(aF,'Oxyg. concentration','fontsize',20)
ylim([0 1.2])
text(round(sz(:,:,:,3)/3).*dx(:,:,:,3)*1e-3,0.5,'low oxy','horizontalalignment','center')
text(-round(sz(:,:,:,3)/3).*dx(:,:,:,3)*1e-3,0.5,'high oxy','horizontalalignment','center')
set(aF,'outerposition',[0.05 0.05 0.95 0.95])
print(F,["/home/antony/Documents/Post-doc/Redac/metvar/" folder_name "_Oxy.pdf"], "-dpdflatex","-S240,180","-FCalibri:24");


