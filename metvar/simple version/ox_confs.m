%script for general analysis of first configs
clear all;
close all;

%takes all folders
[stat str] = system('ls --ignore=*.m');
str = strsplit(str,'\n');

config_name =  'simple';
study_name = 'hypox';


remov = []
for j=1:length(str)
	if(exist([char(str(j)) '/Id'])!=2)
		remov = [remov j]
	endif
endfor

str(remov) = []

%selected_str =[str(21) str(23) str(22) str(1:2)];
%selected_str =[str(12) str(14) str(3:6)];
selected_str =[str(11) str(13) str(3:6)];

for j =1:length(selected_str)

	folder_name = char(selected_str(j))
	clear filename
	%initiation of the different cases
	filename(1,:) = [folder_name '/Id'];
	filename(2,:) = [folder_name '/Ox'];
	filename(3,:) = [folder_name '/Gl'];


	for i=1:3
		Grids(:,:,:,i,j) = load(filename(i,:),'Grid_r').Grid_r;
		S(:,:,:,i,j) = load(filename(i,:),'S_r').S_r;
		kS(:,:,:,i,j) = load(filename(i,:),'kS_r').kS_r;
		kO(:,:,:,i,j) = load(filename(i,:),'kO_r').kO_r;
		St(:,:,:,i,j) = load(filename(i,:),'St_r').St_r;
		Ot(:,:,:,i,j) = load(filename(i,:),'Ot_r').Ot_r;
		%Pt(:,:,:,i,j) = load(filename(i,:),'Pt_r').Pt_r;
		%Kt(:,:,:,i,j) = load(filename(i,:),'Kt_r').Kt_r;
		O(:,:,:,i,j) = load(filename(i,:),'O_r').O_r;
		%P(:,:,:,i,j) = load(filename(i,:),'P_r').P_r;
		%K(:,:,:,i,j) = load(filename(i,:),'K_r').K_r;
		state_mat(:,:,:,i,j) = load(filename(i,:),'state_mat_r').state_mat_r;
		state_story{i,j} = load(filename(i,:),'state_story').state_story;
		%state_mat(:,:,:,i,j) = load(filename(i,:),'prod_mat_r').prod_mat_r;
		sz(:,:,:,i,j) = load(filename(i,:),'sz').sz;
		dx(:,:,:,i,j) = load(filename(i,:),'dx').dx;
		dt(:,:,:,i,j) = load(filename(i,:),'dt').dt;
	endfor

	for i=1:size(Grids,3)
	  live(i,1,j) = length(find(and(Grids(:,:,i,2,j)!=0,kS(:,:,i,2,j)!=0)));
	  live(i,2,j) = length(find(and(Grids(:,:,i,3,j)!=0,kS(:,:,i,3,j)!=0)));
	  dead(i,1,j) = length(find(and(Grids(:,:,i,2,j)!=0,kS(:,:,i,2,j)==0)));
	  dead(i,2,j) = length(find(and(Grids(:,:,i,3,j)!=0,kS(:,:,i,3,j)==0)));
	endfor

endfor


sz = sz(:,:,:,size(sz,4),size(sz,5));
dt = dt(:,:,:,size(sz,4),size(sz,5));
dx = dx(:,:,:,size(sz,4),size(sz,5));
%Ot = reshape(Ot,[100 4000 8 3 5]);


##figure
##imagesc((1:200)*dx,(1:200)*dx,state_mat(:,:,7,3,4))
##xlim([5000 7000])
##ylim([5000 7000])
##figure
##pcolor((1:200)*dx,(1:200)*dx,kS(:,:,7,3,4))
##xlim([5000 7000])
##ylim([5000 7000])
##figure
##pcolor((1:200)*dx,(1:200)*dx,S(:,:,7,3,4))
##xlim([5000 7000])
##ylim([5000 7000])
##
##close all
##figure
##imagesc(state_mat(:,:,8,3,4))
##xlim([80 120])
##ylim([80 120])
##figure
##imagesc(state_mat(:,:,9,3,4))
##xlim([80 120])
##ylim([80 120])
##figure
##imagesc(S(:,:,8,3,4)<0.2)
##xlim([80 120])
##ylim([80 120])
##figure
##imagesc(S(:,:,9,3,4)<0.2)
##xlim([80 120])
##ylim([80 120])
##
## figure;
##for i=1:9
## imagesc(and(kS(:,:,i,3,4)==0,kS(:,:,i+1,3,4),Grids(:,:,i,3,4)!=0,Grids(:,:,i+1,3,4)!=0))
##  waitforbuttonpress
##endfor
%prouve qu'un site qui était à zéro peut passer à KS_tissue
%Mais c'est possible que le site ait été déplacé

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Boucle de vérif
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


for m=1:size(Grids,5)
  m;
  for l=1:3
    l;
    clear state_sty
    clear full_sty
    clear prblms
    state_sty = state_story{l,m};
    for i =size(state_sty,2):-1:4
      i;
      tmp = state_sty{1,i};
      full_sty(:,i) = postpad(tmp(:,2),size(state_sty{1,size(state_sty,2)},1));
    endfor
    full_sty = full_sty(:,4:size(state_sty,2));

    for i=1:9
      prblms(:,i) = and(full_sty(:,i)==-1,full_sty(:,i+1)!=-1);
    endfor
    verdict(l,m) = isempty(find(prblms));
  endfor
endfor
verdict

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Population dynamics
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
F = figure('visible','off');
aF = axes(F);
hold on;
box
grid
p = semilogy(aF,live(:,1,:),'-o')
c_p = get(p,'color');
xlabel(aF,'days');%,'fontsize',20)
%default pos y label :  [0.381 1000 -1]
ylabel(aF,'cell number');%,'fontsize',20)
xlim(aF,[1 10])
text(2,6e4,'$_{\textrm{ref}}$','color',c_p{1,1},'fontsize',8);
text(2,3e4,'$_{\textrm{starv}}$','color',c_p{2,1},'fontsize',8);
text(2,1.5e4,'$_{\textrm{SavyO}}$','color', c_p{3,1},'fontsize',8);
text(2,7.5e3,'$_{\textrm{comp}}$','color',c_p{4,1},'fontsize',8);
text(2,3.75e3,'$_{\textrm{comp arr}}$','color',c_p{5,1},'fontsize',8);
text(2,3.75e3/2,'$_{\textrm{comp prol}}$','color',c_p{6,1},'fontsize',8);
set(aF,'outerposition',[0 0.05 0.9 0.9])
print(F,["/home/antonybazir/Documents/Post-doc/Redac/metvar/" config_name "_" study_name "_Cnum_Ox.pdf"], "-dpdflatex","-S240,180","-FCalibri:24");


F = figure('visible','off');
aF = axes(F);
hold on;
box
grid
p = semilogy(aF,live(:,2,:),'-x');
c_p = get(p,'color');
xlabel(aF,'days','fontsize',20)
ylabel(aF,'cell number','fontsize',20)
xlim(aF,[1 10])
text(2,6e4,'$_{\textrm{ref}}$','color',c_p{1,1},'fontsize',8);
text(2,3e4,'$_{\textrm{starv}}$','color',c_p{2,1},'fontsize',8);
text(2,1.5e4,'$_{\textrm{SavyO}}$','color', c_p{3,1},'fontsize',8);
text(2,7.5e3,'$_{\textrm{comp}}$','color',c_p{4,1},'fontsize',8);
text(2,3.75e3,'$_{\textrm{comp arr}}$','color',c_p{5,1},'fontsize',8);
text(2,3.75e3/2,'$_{\textrm{comp prol}}$','color',c_p{6,1},'fontsize',8);
set(aF,'outerposition',[0 0.05 0.9 0.9])
%legend('ref','starv','savy','compens','comprol','location','northwest')
print(F,["/home/antonybazir/Documents/Post-doc/Redac/metvar/" config_name "_" study_name "_Cnum_Su.pdf"], "-dpdflatex","-S240,180","-FCalibri:24");

F = figure('visible','off');
aF = axes(F);
hold on;
box
grid
p = semilogy(aF,dead(:,1,:),'-o');
c_p = get(p,'color');
xlabel(aF,'days','fontsize',20)
ylim([1e1 1e4])
ylabel(aF,'cell number','fontsize',20)
text(2,6e3,'$_{\textrm{ref}}$','color',c_p{1,1},'fontsize',8);
text(2,3e3,'$_{\textrm{starv}}$','color',c_p{2,1},'fontsize',8);
text(2,1.5e3,'$_{\textrm{SavyO}}$','color', c_p{3,1},'fontsize',8);
text(2,7.5e2,'$_{\textrm{comp}}$','color',c_p{4,1},'fontsize',8);
text(2,3.75e2,'$_{\textrm{comp arr}}$','color',c_p{5,1},'fontsize',8);
text(2,3.75e2/2,'$_{\textrm{comp prol}}$','color',c_p{6,1},'fontsize',8);
set(aF,'outerposition',[0 0.05 0.9 0.9])
%legend('ref','starv','savy','compens','comprol','location','northwest')
print(F,["/home/antonybazir/Documents/Post-doc/Redac/metvar/" config_name "_" study_name "_Dnum_Ox.pdf"], "-dpdflatex","-S240,180","-FCalibri:24");

F = figure('visible','off');
aF = axes(F);
hold on;
box
p = semilogy(aF,dead(:,2,:),'-x')
ylim([1e1 1e4])
xlabel(aF,'days','fontsize',20)
ylabel(aF,'cell number','fontsize',20)
text(2,6e3,'$_{\textrm{ref}}$','color',c_p{1,1},'fontsize',8);
text(2,3e3,'$_{\textrm{starv}}$','color',c_p{2,1},'fontsize',8);
text(2,1.5e3,'$_{\textrm{savyO}}$','color', c_p{3,1},'fontsize',8);
text(2,7.5e2,'$_{\textrm{comp}}$','color',c_p{4,1},'fontsize',8);
text(2,3.75e2,'$_{\textrm{comp arr}}$','color',c_p{5,1},'fontsize',8);
text(2,3.75e2/2,'$_{\textrm{comp prol}}$','color',c_p{6,1},'fontsize',8);
set(aF,'outerposition',[0 0.05 0.9 0.9])
%legend('ref','starv','savy','compens','comprol','location','northwest')
print(F,["/home/antonybazir/Documents/Post-doc/Redac/metvar/" config_name "_" study_name "_Dnum_Su.pdf"], "-dpdflatex","-S240,180","-FCalibri:24");

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Center nutrient dynamics
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure('visible','off');
hold on
box
grid
p = plot(linspace(1,size(St,3)*size(St,2)*dt,size(St,3)*size(St,2)),reshape(St(100,:,:,2,1),[1 size(St,3)*size(St,2)]))
text(900,0.95,'$_{\textrm{ref}}$','color',get(p,'color'),'fontsize',8,'horizontalalignment','right')
p = plot(linspace(1,size(St,3)*size(St,2)*dt,size(St,3)*size(St,2)),reshape(St(100,:,:,2,2),[1 size(St,3)*size(St,2)]))
text(900,0.85,'$_{\textrm{starv}}$','color',get(p,'color'),'fontsize',8,'horizontalalignment','right')
p = plot(linspace(1,size(St,3)*size(St,2)*dt,size(St,3)*size(St,2)),reshape(St(100,:,:,2,3),[1 size(St,3)*size(St,2)]))
text(900,0.75,'$_{\textrm{savyO}}$','color',get(p,'color'),'fontsize',8,'horizontalalignment','right')
p = plot(linspace(1,size(St,3)*size(St,2)*dt,size(St,3)*size(St,2)),reshape(St(100,:,:,2,4),[1 size(St,3)*size(St,2) ]))
text(900,0.65,'$_{\textrm{comp}}$','color',get(p,'color'),'fontsize',8,'horizontalalignment','right')
p = plot(linspace(1,size(St,3)*size(St,2)*dt,size(St,3)*size(St,2)),reshape(St(100,:,:,2,5),[1 size(St,3)*size(St,2) ]))
text(900,0.55,'$_{\textrm{comp arr}}$','color',get(p,'color'),'fontsize',8,'horizontalalignment','right')
p = plot(linspace(1,size(St,3)*size(St,2)*dt,size(St,3)*size(St,2)),reshape(St(100,:,:,2,6),[1 size(St,3)*size(St,2) ]))
text(900,0.45,'$_{\textrm{comp prol}}$','color',get(p,'color'),'fontsize',8,'horizontalalignment','right')
for i =1:size(St,3)
  line([(i-1)*size(St,2)*dt (i-1)*size(St,2)*dt],[0 1],'linestyle','--','color','black','linewidth',0.01)
endfor
xlabel('time (min)')
ylabel('Concentration')
set(gca,'outerposition',[0 0.05 0.9 0.9])
print(["/home/antonybazir/Documents/Post-doc/Redac/metvar/" config_name "_" study_name "_St_Ox_Center.pdf"], "-dpdflatex","-S240,180","-FCalibri:24");

figure('visible','off');
hold on
box
grid
p = plot(linspace(1,size(St,3)*size(St,2)*dt,size(St,3)*size(St,2)),reshape(St(100,:,:,3,1),[1 size(St,3)*size(St,2)]))
text(900,0.95,'$_{\textrm{ref}}$','color',get(p,'color'),'fontsize',8,'horizontalalignment','right')
p = plot(linspace(1,size(St,3)*size(St,2)*dt,size(St,3)*size(St,2)),reshape(St(100,:,:,3,2),[1 size(St,3)*size(St,2)]))
text(900,0.85,'$_{\textrm{starv}}$','color',get(p,'color'),'fontsize',8,'horizontalalignment','right')
p = plot(linspace(1,size(St,3)*size(St,2)*dt,size(St,3)*size(St,2)),reshape(St(100,:,:,3,3),[1 size(St,3)*size(St,2)]))
text(900,0.75,'$_{\textrm{savyO}}$','color',get(p,'color'),'fontsize',8,'horizontalalignment','right')
p = plot(linspace(1,size(St,3)*size(St,2)*dt,size(St,3)*size(St,2)),reshape(St(100,:,:,3,4),[1 size(St,3)*size(St,2) ]))
text(900,0.65,'$_{\textrm{compens}}$','color',get(p,'color'),'fontsize',8,'horizontalalignment','right')
p = plot(linspace(1,size(St,3)*size(St,2)*dt,size(St,3)*size(St,2)),reshape(St(100,:,:,3,5),[1 size(St,3)*size(St,2) ]))
text(900,0.55,'$_{\textrm{compens arr}}$','color',get(p,'color'),'fontsize',8,'horizontalalignment','right')
p = plot(linspace(1,size(St,3)*size(St,2)*dt,size(St,3)*size(St,2)),reshape(St(100,:,:,3,6),[1 size(St,3)*size(St,2) ]))
text(900,0.45,'$_{\textrm{compens prol}}$','color',get(p,'color'),'fontsize',8,'horizontalalignment','right')
for i =1:size(St,3)
  line([(i-1)*size(St,2)*dt (i-1)*size(St,2)*dt],[0 1],'linestyle','--','color','black','linewidth',0.01)
endfor
xlabel('time (min)')
ylabel('Concentration')
set(gca,'outerposition',[0 0.05 0.9 0.9])
print(["/home/antonybazir/Documents/Post-doc/Redac/metvar/" config_name "_" study_name "_St_Gl_Center.pdf"], "-dpdflatex","-S240,180","-FCalibri:24");

figure('visible','off');
hold on
box
grid
p = plot(linspace(1,size(Ot,3)*size(Ot,2)*dt,size(Ot,3)*size(Ot,2)),reshape(Ot(100,:,:,2,1),[1 size(Ot,3)*size(Ot,2)]))
text(900,0.95,'$_{\textrm{ref}}$','color',get(p,'color'),'fontsize',8,'horizontalalignment','right')
p = plot(linspace(1,size(Ot,3)*size(Ot,2)*dt,size(Ot,3)*size(Ot,2)),reshape(Ot(100,:,:,2,2),[1 size(Ot,3)*size(Ot,2)]))
text(900,0.85,'$_{\textrm{starv}}$','color',get(p,'color'),'fontsize',8,'horizontalalignment','right')
p = plot(linspace(1,size(Ot,3)*size(Ot,2)*dt,size(Ot,3)*size(Ot,2)),reshape(Ot(100,:,:,2,3),[1 size(Ot,3)*size(Ot,2)]))
text(900,0.75,'$_{\textrm{savyO}}$','color',get(p,'color'),'fontsize',8,'horizontalalignment','right')
p = plot(linspace(1,size(Ot,3)*size(Ot,2)*dt,size(Ot,3)*size(Ot,2)),reshape(Ot(100,:,:,2,4),[1 size(Ot,3)*size(Ot,2) ]))
text(900,0.65,'$_{\textrm{compens}}$','color',get(p,'color'),'fontsize',8,'horizontalalignment','right')
p = plot(linspace(1,size(Ot,3)*size(Ot,2)*dt,size(Ot,3)*size(Ot,2)),reshape(Ot(100,:,:,2,5),[1 size(Ot,3)*size(Ot,2) ]))
text(900,0.55,'$_{\textrm{compens arr}}$','color',get(p,'color'),'fontsize',8,'horizontalalignment','right')
p = plot(linspace(1,size(Ot,3)*size(Ot,2)*dt,size(Ot,3)*size(Ot,2)),reshape(Ot(100,:,:,2,6),[1 size(Ot,3)*size(Ot,2) ]))
text(900,0.45,'$_{\textrm{compens prol}}$','color',get(p,'color'),'fontsize',8,'horizontalalignment','right')
for i =1:size(Ot,3)
  line([(i-1)*size(Ot,2)*dt (i-1)*size(Ot,2)*dt],[0 1],'linestyle','--','color','black','linewidth',0.01)
endfor
xlabel('time (min)')
ylabel('Concentration')
set(gca,'outerposition',[0 0.05 0.9 0.9])
print(["/home/antonybazir/Documents/Post-doc/Redac/metvar/" config_name "_" study_name "_Ot_Ox_Center.pdf"], "-dpdflatex","-S240,180","-FCalibri:24");

figure('visible','off');
hold on
box
grid
p = plot(linspace(1,size(Ot,3)*size(Ot,2)*dt,size(Ot,3)*size(Ot,2)),reshape(Ot(100,:,:,3,1),[1 size(Ot,3)*size(Ot,2)]))
text(900,0.95,'$_{\textrm{ref}}$','color',get(p,'color'),'fontsize',8,'horizontalalignment','right')
p = plot(linspace(1,size(Ot,3)*size(Ot,2)*dt,size(Ot,3)*size(Ot,2)),reshape(Ot(100,:,:,3,2),[1 size(Ot,3)*size(Ot,2)]))
text(900,0.85,'$_{\textrm{starv}}$','color',get(p,'color'),'fontsize',8,'horizontalalignment','right')
p = plot(linspace(1,size(Ot,3)*size(Ot,2)*dt,size(Ot,3)*size(Ot,2)),reshape(Ot(100,:,:,3,3),[1 size(Ot,3)*size(Ot,2)]))
text(900,0.75,'$_{\textrm{savyO}}$','color',get(p,'color'),'fontsize',8,'horizontalalignment','right')
p = plot(linspace(1,size(Ot,3)*size(Ot,2)*dt,size(Ot,3)*size(Ot,2)),reshape(Ot(100,:,:,3,4),[1 size(Ot,3)*size(Ot,2) ]))
text(900,0.65,'$_{\textrm{compens}}$','color',get(p,'color'),'fontsize',8,'horizontalalignment','right')
p = plot(linspace(1,size(Ot,3)*size(Ot,2)*dt,size(Ot,3)*size(Ot,2)),reshape(Ot(100,:,:,3,5),[1 size(Ot,3)*size(Ot,2) ]))
text(900,0.55,'$_{\textrm{compens arr}}$','color',get(p,'color'),'fontsize',8,'horizontalalignment','right')
p = plot(linspace(1,size(Ot,3)*size(Ot,2)*dt,size(Ot,3)*size(Ot,2)),reshape(Ot(100,:,:,3,6),[1 size(Ot,3)*size(Ot,2) ]))
text(900,0.45,'$_{\textrm{compens prol}}$','color',get(p,'color'),'fontsize',8,'horizontalalignment','right')

for i =1:size(Ot,3)
  line([(i-1)*size(Ot,2)*dt (i-1)*size(Ot,2)*dt],[0 1],'linestyle','--','color','black','linewidth',0.01)
endfor
xlabel('time (min)')
ylabel('Concentration')
set(gca,'outerposition',[0 0.05 0.9 0.9])
print(["/home/antonybazir/Documents/Post-doc/Redac/metvar/" config_name "_" study_name "_Ot_Gl_Center.pdf"], "-dpdflatex","-S240,180","-FCalibri:24");



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
close all
