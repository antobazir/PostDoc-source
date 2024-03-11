
## Copyright (C) 2023 antonybazir
##
## This program is free software: you can redistribute it and/or modify
## it under the terms of the GNU General Public License as published by
## the Free Software Foundation, either version 3 of the License, or
## (at your option) any later version.
##
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
##
## You should have received a copy of the GNU General Public License
## along with this program.  If not, see <https://www.gnu.org/licenses/>.

## -*- texinfo -*-
## @deftypefn {} {@var{retval} =} full_study (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: antonybazir <antonybazir.bazir@antonybazir-Latitude-E7450>
## Created: 2023-11-10

function err = full_study (folder_name, behavior)

	%checks that the folder exists
if(exist(folder_name)==0)
	system(['mkdir ' folder_name]);
endif

kS_ = 0.1/2;
kO_ = 0.8/2;

%initiation of the different cases
kS_arg(1) =  kS_; kO_arg(1) = kO_; filename(1,:) = [folder_name '/Id'];
kS_arg(2) =  kS_; kO_arg(2) = kO_/5; filename(2,:) = [folder_name '/Ox'];
kS_arg(3) =  kS_/5; kO_arg(3) = kO_; filename(3,:) = [folder_name '/Gl'];

for i=1:3
%if the file exists don't do the calculations
  if(exist(filename(i,:))==0)
    disp('calcul lancé')
    c_s  = metvar_f(kO_arg(i),kS_arg(i),behavior,filename(i,:));
    if(c_s==1)
     disp('error in metvar_f')
     save('debug_all')
     err=1;
     return
    endif
  endif
endfor
err=0;
##
##for i=1:3
##  Grids(:,:,:,i) = load(filename(i,:),'Grid_r').Grid_r;
##  S(:,:,:,i) = load(filename(i,:),'S_r').S_r;
##  kS(:,:,:,i) = load(filename(i,:),'kS_r').kS_r;
##  St(:,:,:,i) = load(filename(i,:),'St_r').St_r;
##  Kt(:,:,:,i) = load(filename(i,:),'Kt_r').Kt_r;
##  O(:,:,:,i) = load(filename(i,:),'O_r').O_r;
##  %P(:,:,:,i) = load(filename(i,:),'P_r').P_r;
##  %K(:,:,:,i) = load(filename(i,:),'K_r').K_r;
##  state_mat(:,:,:,i) = load(filename(i,:),'state_mat_r').state_mat_r;
##  sz(:,:,:,i) = load(filename(i,:),'sz').sz;
##  dx(:,:,:,i) = load(filename(i,:),'dx').dx;
##  dt(:,:,:,i) = load(filename(i,:),'dt').dt;
##endfor
##
##pos = (-round(sz(:,:,:,3)/2)+1:round(sz(:,:,:,3)/2))*dx(:,:,:,3)*1e-3;
##Smap = [S(:,1:round(sz/2),:,2) S(:,round(sz/2)+1:sz,:,3)];
##Omap = [O(:,1:round(sz/2),:,2) O(:,round(sz/2)+1:sz,:,3)];
##%Pmap = [P(:,1:round(sz/2),:,2) P(:,round(sz/2)+1:sz,:,3)];
##%Kmap = [K(:,1:round(sz/2),:,2) K(:,round(sz/2)+1:sz,:,3)];
##state_map = [state_mat(:,1:round(sz/2),:,2) state_mat(:,round(sz/2)+1:sz,:,3)];
##
##for i=1:size(Grids,3)
##  live(i,1) = length(find(and(Grids(:,:,i,2)!=0,kS(:,:,i,2)!=0)));
##  live(i,2) = length(find(and(Grids(:,:,i,3)!=0,kS(:,:,i,3)!=0)));
##endfor
##
##
##
##%cell number
##F = figure('visible','off');
##aF = axes(F);
##hold on;
##semilogy(aF,live(:,1),'-o','color','r')
##semilogy(aF,live(:,2),'-o','color','b')
##xlabel(aF,'days','fontsize',20)
##ylabel(aF,'cell number','fontsize',20)
##legend('high oxy.','high subs.','location','northwest')
##set(aF,'outerposition',[0 0.05 0.9 0.9])
##print(F,["/home/antonybazir/Documents/Post-doc/Redac/metvar/" pic_fld "_" folder_name "_Cnum.pdf"], "-dpdflatex","-S240,180","-FCalibri:24");
##
##F = figure('visible','off');
##aF = axes(F);
##imagesc(aF,pos,pos,state_map(:,:,size(state_map,3)))
##xlabel(aF,'position (mm)','fontsize',20)
##ylabel(aF,'position (mm)','fontsize',20)
##set(aF,'outerposition',[0 0.05 0.9 0.9])
##print(F,["/home/antonybazir/Documents/Post-doc/Redac/metvar/" pic_fld "_" folder_name "_statemap.pdf"], "-dpdflatex","-S240,180","-FCalibri:24");
##
##
##F = figure('visible','off');
##aF = axes(F);
##hold on;
##plot(pos,Smap(round(sz(:,:,:,3)/2),:,size(Grids,3)-4),'color','blue')
##plot(pos,Smap(round(sz(:,:,:,3)/2),:,size(Grids,3)-2),'color','red')
##plot(pos,Smap(round(sz(:,:,:,3)/2),:,size(Grids,3)),'color','green')
##line([0 0],[0 1.2],'color','black')
##xlabel(aF,'position (mm)','fontsize',20)
##ylabel(aF,'Subs concentration','fontsize',20)
##ylim([0 1.2])
##legend(aF,['d' num2str(size(Grids,3)-4)],['d' num2str(size(Grids,3)-2)],['d' num2str(size(Grids,3))],'location','northwest');
##text(round(sz(:,:,:,3)/3).*dx(:,:,:,3)*1e-3,0.5,'high subs','horizontalalignment','center')
##text(-round(sz(:,:,:,3)/3).*dx(:,:,:,3)*1e-3,0.5,'low subs','horizontalalignment','center')
##set(aF,'outerposition',[0.05 0.05 0.9 0.9])
##print(F,["/home/antonybazir/Documents/Post-doc/Redac/metvar/" pic_fld "_" folder_name "_Sub.pdf"], "-dpdflatex","-S240,180","-FCalibri:24");
##
##F = figure('visible','off');
##aF = axes(F);
##hold on;
##plot(pos,Omap(round(sz(:,:,:,3)/2),:,size(Grids,3)-4),'color','blue')
##plot(pos,Omap(round(sz(:,:,:,3)/2),:,size(Grids,3)-2),'color','red')
##plot(pos,Omap(round(sz(:,:,:,3)/2),:,size(Grids,3)),'color','green')
##line([0 0],[0 1.2],'color','black')
##xlabel(aF,'position (mm)','fontsize',20)
##ylabel(aF,'Oxyg. concentration','fontsize',20)
##ylim([0 1.2])
##text(round(sz(:,:,:,3)/3).*dx(:,:,:,3)*1e-3,0.5,'low oxy','horizontalalignment','center')
##text(-round(sz(:,:,:,3)/3).*dx(:,:,:,3)*1e-3,0.5,'high oxy','horizontalalignment','center')
##set(aF,'outerposition',[0.05 0.05 0.9 0.9])
##print(F,["/home/antonybazir/Documents/Post-doc/Redac/metvar/" pic_fld "_" folder_name "_Oxy.pdf"], "-dpdflatex","-S240,180","-FCalibri:24");

