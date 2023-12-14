%script for general analysis of first configs
clear all;
close all;

%takes all folders
[stat str] = system('ls --ignore=*.m');
str = strsplit(str,'\n');

config_name =  'simple';
study_name = 'first';


remov = []
for j=1:length(str)
	if(exist([char(str(j)) '/Id'])!=2)
		remov = [remov j]
	endif
endfor

str(remov) = []

%selected_str =[str(21) str(23) str(22) str(1:2)];
%selected_str =[str(12) str(14) str(13) str(1:2)];
selected_str =[str(11) str(13) str(12) str(1:2)];
%selected_str =[str(7:9) str(1:6)];

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
##
figure;hold on
plot(St_r(100,:))
plot(abs(diff(St_r(100,:)))./max(abs(diff(St_r(100,:)))))
plot(St_r(90,:))
plot(abs(diff(St_r(90,:)))./max(abs(diff(St_r(90,:)))))

A = diff(St_r(100,:));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Population dynamics
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
text(2,1.5e4,'$_{\textrm{savy}}$','color', c_p{3,1},'fontsize',8);
text(2,7.5e3,'$_{\textrm{comp}}$','color',c_p{4,1},'fontsize',8);
text(2,3.75e3,'$_{\textrm{comp prol}}$','color',c_p{5,1},'fontsize',8);
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
text(2,1.5e4,'$_{\textrm{savy}}$','color', c_p{3,1},'fontsize',8);
text(2,7.5e3,'$_{\textrm{comp}}$','color',c_p{4,1},'fontsize',8);
text(2,3.75e3,'$_{\textrm{comp prol}}$','color',c_p{5,1},'fontsize',8);
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
text(2,1.5e3,'$_{\textrm{savy}}$','color', c_p{3,1},'fontsize',8);
text(2,7.5e2,'$_{\textrm{comp}}$','color',c_p{4,1},'fontsize',8);
text(2,3.75e2,'$_{\textrm{comp prol}}$','color',c_p{5,1},'fontsize',8);
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
text(2,1.5e3,'$_{\textrm{savy}}$','color', c_p{3,1},'fontsize',8);
text(2,7.5e2,'$_{\textrm{comp}}$','color',c_p{4,1},'fontsize',8);
text(2,3.75e2,'$_{\textrm{comp prol}}$','color',c_p{5,1},'fontsize',8);
set(aF,'outerposition',[0 0.05 0.9 0.9])
%legend('ref','starv','savy','compens','comprol','location','northwest')
print(F,["/home/antonybazir/Documents/Post-doc/Redac/metvar/" config_name "_" study_name "_Dnum_Su.pdf"], "-dpdflatex","-S240,180","-FCalibri:24");

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

F = figure('visible','off');
aF = axes(F);
hold on;
box
plot(dx*(-round(sz/2)+1:round(sz/2))*1e-3,[S(round(sz/2),1:round(sz/2),size(S,3),2,:) fliplr(S(round(sz/2),1:round(sz/2),size(S,3),3,:))])
line([0 0],[0 1.2],'color','black')
ylim([0 1.2])
xlabel(aF,'position (mm)','fontsize',20)
ylabel(aF,'subs. concentration','fontsize',20)
text(round(sz/3).*dx*1e-3,0.5,'sb-rich','horizontalalignment','center')
text(-round(sz/3).*dx*1e-3,0.5,'ox-rich','horizontalalignment','center')
set(aF,'outerposition',[0 0.05 0.9 0.9])
print(F,["/home/antonybazir/Documents/Post-doc/Redac/metvar/" config_name "_" study_name "_S.pdf"], "-dpdflatex","-S240,180","-FCalibri:24");


F = figure('visible','off');
aF = axes(F);
hold on;
box
plot(dx*(-round(sz/2)+1:round(sz/2))*1e-3,[O(round(sz/2),1:round(sz/2),size(O,3),2,:) fliplr(O(round(sz/2),1:round(sz/2),size(O,3),3,:))])
line([0 0],[0 1.2],'color','black')
ylim([0 1.2])
xlabel(aF,'position (mm)','fontsize',20)
ylabel(aF,'subs. concentration','fontsize',20,'position',[0 100 0])
text(round(sz/3).*dx*1e-3,0.5,'sb-rich','horizontalalignment','center')
text(-round(sz/3).*dx*1e-3,0.5,'ox-rich','horizontalalignment','center')
set(aF,'outerposition',[0 0.05 0.9 0.9])
print(F,["/home/antonybazir/Documents/Post-doc/Redac/metvar/" config_name "_" study_name "_O.pdf"], "-dpdflatex","-S240,180","-FCalibri:24");

figure('visible','off');
hold on
box
grid
p = plot(linspace(1,size(St,3)*size(St,2)*dt,size(St,3)*size(St,2)),reshape(St(100,:,:,2,3),[1 size(St,3)*size(St,2)]),'color','blue')
text(900,0.95,'$_{\textrm{center}}$','color',get(p,'color'),'fontsize',8,'horizontalalignment','right')
p = plot(linspace(1,size(St,3)*size(St,2)*dt,size(St,3)*size(St,2)),reshape(St(95,:,:,2,3),[1 size(St,3)*size(St,2)]),'color','red')
text(900,0.85,'$_{\textrm{near center}}$','color',get(p,'color'),'fontsize',8,'horizontalalignment','right')
p = plot(linspace(1,size(St,3)*size(St,2)*dt,size(St,3)*size(St,2)),reshape(St(90,:,:,2,3),[1 size(St,3)*size(St,2)]),'color','green')
text(900,0.75,'$_{\textrm{near rim}}$','color',get(p,'color'),'fontsize',8,'horizontalalignment','right')
p = plot(linspace(1,size(St,3)*size(St,2)*dt,size(St,3)*size(St,2)),reshape(St(85,:,:,2,3),[1 size(St,3)*size(St,2) ]),'color','cyan')
text(900,0.65,'$_{\textrm{rim}}$','color',get(p,'color'),'fontsize',8,'horizontalalignment','right')
for i =1:size(St,3)
  line([(i-1)*size(St,2)*dt (i-1)*size(St,2)*dt],[0 1],'linestyle','--','color','black','linewidth',0.01)
endfor
%legend('center','near-center','near-rim','rim')
xlabel('time (mn)')
ylabel('Concentration')
xlim([1 size(St,3)*size(St,2)*dt])
set(gca,'outerposition',[0 0.05 0.9 0.9])
print(["/home/antonybazir/Documents/Post-doc/Redac/metvar/" config_name "_" study_name "_savy_St_Ox.pdf"], "-dpdflatex","-S240,180","-FCalibri:24");

figure('visible','off');
hold on
box
grid
plot(linspace(1,size(St,3)*size(St,2)*dt,size(St,3)*size(St,2)),reshape(St(100,:,:,3,3),[1 size(St,3)*size(St,2)]),'color','blue')
plot(linspace(1,size(St,3)*size(St,2)*dt,size(St,3)*size(St,2)),reshape(St(95,:,:,3,3),[1 size(St,3)*size(St,2)]),'color','red')
plot(linspace(1,size(St,3)*size(St,2)*dt,size(St,3)*size(St,2)),reshape(St(90,:,:,3,3),[1 size(St,3)*size(St,2)]),'color','green')
plot(linspace(1,size(St,3)*size(St,2)*dt,size(St,3)*size(St,2)),reshape(St(85,:,:,3,3),[1 size(St,3)*size(St,2)]),'color','cyan')
for i =1:size(St,3)
  line([(i-1)*size(St,2)*dt (i-1)*size(St,2)*dt],[0 1],'linestyle','--','color','black','linewidth',0.01)
endfor
xlim([1 size(St,3)*size(St,2)*dt])
%legend('center','near-center','near-rim','rim')
xlabel('time (mn)')
ylabel('Concentration')
set(gca,'outerposition',[0 0.05 0.9 0.9])
print(["/home/antonybazir/Documents/Post-doc/Redac/metvar/" config_name "_" study_name "_savy_St_Gl.pdf"], "-dpdflatex","-S240,180","-FCalibri:24");


figure('visible','off');
hold on
box
grid
plot(linspace(1,size(Ot,3)*size(Ot,2)*dt,size(Ot,3)*size(Ot,2)),reshape(Ot(100,:,:,2,3),[1 size(Ot,3)*size(Ot,2)]),'color','blue')
plot(linspace(1,size(Ot,3)*size(Ot,2)*dt,size(Ot,3)*size(Ot,2)),reshape(Ot(95,:,:,2,3),[1 size(Ot,3)*size(Ot,2)]),'color','red')
plot(linspace(1,size(Ot,3)*size(Ot,2)*dt,size(Ot,3)*size(Ot,2)),reshape(Ot(90,:,:,2,3),[1 size(Ot,3)*size(Ot,2)]),'color','green')
plot(linspace(1,size(Ot,3)*size(Ot,2)*dt,size(Ot,3)*size(Ot,2)),reshape(Ot(85,:,:,2,3),[1 size(Ot,3)*size(Ot,2) ]),'color','cyan')
for i =1:size(Ot,3)
  line([(i-1)*size(Ot,2)*dt (i-1)*size(Ot,2)*dt],[0 1],'linestyle','--','color','black','linewidth',0.01)
endfor
%legend('center','near-center','near-rim','rim')
xlabel('time (mn)')
ylabel('Concentration')
xlim([1 size(Ot,3)*size(Ot,2)*dt])
set(gca,'outerposition',[0 0.05 0.9 0.9])
print(["/home/antonybazir/Documents/Post-doc/Redac/metvar/" config_name "_" study_name "_savy_Ot_Ox.pdf"], "-dpdflatex","-S240,180","-FCalibri:24");

figure('visible','off');
hold on
box
grid
p = plot(linspace(1,size(Ot,3)*size(Ot,2)*dt,size(Ot,3)*size(Ot,2)),reshape(Ot(100,:,:,3,3),[1 size(Ot,3)*size(Ot,2)]),'color','blue')
plot(linspace(1,size(Ot,3)*size(Ot,2)*dt,size(Ot,3)*size(Ot,2)),reshape(Ot(95,:,:,3,3),[1 size(Ot,3)*size(Ot,2)]),'color','red')
plot(linspace(1,size(Ot,3)*size(Ot,2)*dt,size(Ot,3)*size(Ot,2)),reshape(Ot(90,:,:,3,3),[1 size(Ot,3)*size(Ot,2)]),'color','green')
plot(linspace(1,size(Ot,3)*size(Ot,2)*dt,size(Ot,3)*size(Ot,2)),reshape(Ot(85,:,:,3,3),[1 size(Ot,3)*size(Ot,2)]),'color','cyan')
for i =1:size(Ot,3)
  line([(i-1)*size(Ot,2)*dt (i-1)*size(Ot,2)*dt],[0 1],'linestyle','--','color','black','linewidth',0.01)
endfor
xlim([1 size(Ot,3)*size(Ot,2)*dt])
%legend('center','near-center','near-rim','rim')
xlabel('time (mn)')
ylabel('Concentration')
set(gca,'outerposition',[0 0.05 0.9 0.9])
print(["/home/antonybazir/Documents/Post-doc/Redac/metvar/" config_name "_" study_name "_savy_Ot_Gl.pdf"], "-dpdflatex","-S240,180","-FCalibri:24");




%profil sur la ligne centrale
figure('visible','off');
hold on
box
p = plot(((size(S,1)/2-1):-1:0)*dx*1e-3,S(1:size(S,1)/2,size(S,1)/2,2,2,3))
text(0.8,0.95,'$_{\textrm{d2}}$','color',get(p,'color'),'fontsize',8)
text(0.8,0.91,['$_{\textrm{p: ' num2str(length(find(kS(:,:,2,2,3)==kS(100,100,1,2,3)))) '}}$'],'color',get(p,'color'),'fontsize',8)
text(0.8,0.87,['$_{\textrm{q: ' num2str(length(find(kS(:,:,2,2,3)==kS(100,100,2,2,3)))) '}}$'],'color',get(p,'color'),'fontsize',8)
%text(0.18,0.87,['$_{\textrm{n: ' num2str(length(find(kS(:,:,2,2,3)==0))) '}}$'],'color',get(p,'color'),'fontsize',8)
p = plot(((size(S,1)/2-1):-1:0)*dx*1e-3,S(1:size(S,1)/2,size(S,1)/2,4,2,3))
text(0.8,0.77,'$_{\textrm{d4}}$','color',get(p,'color'),'fontsize',8)
text(0.8,0.73,['$_{\textrm{p: ' num2str(length(find(kS(:,:,4,2,3)==kS(100,100,1,2,3)))) '}}$'],'color',get(p,'color'),'fontsize',8)
text(0.8,0.69,['$_{\textrm{q: ' num2str(length(find(kS(:,:,4,2,3)==kS(100,100,2,2,3)))) '}}$'],'color',get(p,'color'),'fontsize',8)
p = plot(((size(S,1)/2-1):-1:0)*dx*1e-3,S(1:size(S,1)/2,size(S,1)/2,5,2,3))
text(0.8,0.59,'$_{\textrm{d5}}$','color',get(p,'color'),'fontsize',8)
text(0.8,0.55,['$_{\textrm{p: ' num2str(length(find(kS(:,:,5,2,3)==kS(100,100,1,2,3)))) '}}$'],'color',get(p,'color'),'fontsize',8)
text(0.8,0.51,['$_{\textrm{q: ' num2str(length(find(kS(:,:,5,2,3)==kS(100,100,2,2,3)))) '}}$'],'color',get(p,'color'),'fontsize',8)
p = plot(((size(S,1)/2-1):-1:0)*dx*1e-3,S(1:size(S,1)/2,size(S,1)/2,7,2,3))
text(0.8,0.41,'$_{\textrm{d7}}$','color',get(p,'color'),'fontsize',8)
text(0.8,0.37,['$_{\textrm{p: ' num2str(length(find(kS(:,:,7,2,3)==kS(100,100,1,2,3)))) '}}$'],'color',get(p,'color'),'fontsize',8)
text(0.8,0.33,['$_{\textrm{q: ' num2str(length(find(kS(:,:,7,2,3)==kS(100,100,2,2,3)))) '}}$'],'color',get(p,'color'),'fontsize',8)
p = plot(((size(S,1)/2-1):-1:0)*dx*1e-3,S(1:size(S,1)/2,size(S,1)/2,8,2,3))
text(0.8,0.23,'$_{\textrm{d8}}$','color',get(p,'color'),'fontsize',8)
text(0.8,0.19,['$_{\textrm{p: ' num2str(length(find(kS(:,:,8,2,3)==kS(100,100,1,2,3)))) '}}$'],'color',get(p,'color'),'fontsize',8)
text(0.8,0.15,['$_{\textrm{q: ' num2str(length(find(kS(:,:,8,2,3)==kS(100,100,2,2,3)))) '}}$'],'color',get(p,'color'),'fontsize',8)
xlabel('position (mm)')
xlim([0 1])
ylabel('Concentration')
set(gca,'outerposition',[0 0.05 0.9 0.9])
print(["/home/antonybazir/Documents/Post-doc/Redac/metvar/" config_name "_" study_name "_S_savy_Center_Ox.pdf"], "-dpdflatex","-S240,180","-FCalibri:24");

figure('visible','off');
hold on
box
p = plot(((size(S,1)/2-1):-1:0)*dx*1e-3,S(1:size(S,1)/2,size(S,1)/2,2,3,3))
text(1.6,0.95,'$_{\textrm{d2}}$','color',get(p,'color'),'fontsize',8)
text(1.6,0.90,['$_{\textrm{p: ' num2str(length(find(kS(:,:,2,3,3)==kS(100,100,1,3,3)))) '}}$'],'color',get(p,'color'),'fontsize',8)
text(1.6,0.85,['$_{\textrm{q: ' num2str(length(find(kS(:,:,2,3,3)==kS(100,100,5,3,3)))) '}}$'],'color',get(p,'color'),'fontsize',8)
%text(0.18,0.87,['$_{\textrm{n: ' num2str(length(find(kS(:,:,2,2,3)==0))) '}}$'],'color',get(p,'color'),'fontsize',8)
p = plot(((size(S,1)/2-1):-1:0)*dx*1e-3,S(1:size(S,1)/2,size(S,1)/2,4,3,3))
text(1.6,0.75,'$_{\textrm{d4}}$','color',get(p,'color'),'fontsize',8)
text(1.6,0.70,['$_{\textrm{p: ' num2str(length(find(kS(:,:,4,3,3)==kS(100,100,1,3,3)))) '}}$'],'color',get(p,'color'),'fontsize',8)
text(1.6,0.65,['$_{\textrm{q: ' num2str(length(find(kS(:,:,4,3,3)==kS(100,100,5,3,3)))) '}}$'],'color',get(p,'color'),'fontsize',8)
p = plot(((size(S,1)/2-1):-1:0)*dx*1e-3,S(1:size(S,1)/2,size(S,1)/2,5,3,3))
text(1.6,0.55,'$_{\textrm{d5}}$','color',get(p,'color'),'fontsize',8)
text(1.6,0.50,['$_{\textrm{p: ' num2str(length(find(kS(:,:,5,3,3)==kS(100,100,1,3,3)))) '}}$'],'color',get(p,'color'),'fontsize',8)
text(1.6,0.45,['$_{\textrm{q: ' num2str(length(find(kS(:,:,5,3,3)==kS(100,100,5,3,3)))) '}}$'],'color',get(p,'color'),'fontsize',8)
p = plot(((size(S,1)/2-1):-1:0)*dx*1e-3,S(1:size(S,1)/2,size(S,1)/2,7,3,3))
text(1.6,0.35,'$_{\textrm{d7}}$','color',get(p,'color'),'fontsize',8)
text(1.6,0.30,['$_{\textrm{p: ' num2str(length(find(kS(:,:,7,3,3)==kS(100,100,1,3,3)))) '}}$'],'color',get(p,'color'),'fontsize',8)
text(1.6,0.25,['$_{\textrm{q: ' num2str(length(find(kS(:,:,7,3,3)==kS(100,100,5,3,3)))) '}}$'],'color',get(p,'color'),'fontsize',8)
p = plot(((size(S,1)/2-1):-1:0)*dx*1e-3,S(1:size(S,1)/2,size(S,1)/2,8,3,3))
text(1.6,0.15,'$_{\textrm{d8}}$','color',get(p,'color'),'fontsize',8)
text(1.6,0.10,['$_{\textrm{p: ' num2str(length(find(kS(:,:,8,3,3)==kS(100,100,1,3,3)))) '}}$'],'color',get(p,'color'),'fontsize',8)
text(1.6,0.05,['$_{\textrm{q: ' num2str(length(find(kS(:,:,8,3,3)==kS(100,100,5,3,3)))) '}}$'],'color',get(p,'color'),'fontsize',8)
xlabel('position (mm)')
xlim([0 2])
ylabel('Concentration')
set(gca,'outerposition',[0 0.05 0.9 0.9])
print(["/home/antonybazir/Documents/Post-doc/Redac/metvar/" config_name "_" study_name "_S_savy_Center_Gl.pdf"], "-dpdflatex","-S240,180","-FCalibri:24");




%n_prol
length(find(kS(:,:,2,2,3)==kS(100,100,1,2,3)))
%n_quiesc
length(find(kS(:,:,2,2,3)==kS(100,100,2,2,3)))
figure
hold on
box
p = plot(((size(S,1)/2-1):-1:0)*dx*1e-3,kS(1:size(S,1)/2,size(S,1)/2,2,2,3),'x-')
text(0.18,0.95,'$_{\textrm{d2}}$','color',get(p,'color'),'fontsize',8)
p = plot(((size(S,1)/2-1):-1:0)*dx*1e-3,kS(1:size(S,1)/2,size(S,1)/2,4,2,3),'+-')
text(0.38,0.95,'$_{\textrm{d4}}$','color',get(p,'color'),'fontsize',8)
p = plot(((size(S,1)/2-1):-1:0)*dx*1e-3,kS(1:size(S,1)/2,size(S,1)/2,5,2,3),'^-')
text(0.49,0.95,'$_{\textrm{d5}}$','color',get(p,'color'),'fontsize',8)
p = plot(((size(S,1)/2-1):-1:0)*dx*1e-3,kS(1:size(S,1)/2,size(S,1)/2,7,2,3),'v-')
text(0.57,0.95,'$_{\textrm{d7}}$','color',get(p,'color'),'fontsize',8)
p = plot(((size(S,1)/2-1):-1:0)*dx*1e-3,kS(1:size(S,1)/2,size(S,1)/2,8,2,3),'o-')
text(0.78,0.95,'$_{\textrm{d8}}$','color',get(p,'color'),'fontsize',8)
xlabel('position (mm)')
xlim([0 1])
ylabel('Consumption rate')
set(gca,'outerposition',[0 0.05 0.9 0.9])
print(["/home/antonybazir/Documents/Post-doc/Redac/metvar/" config_name "_" study_name "_kS_savy_Center_Ox.pdf"], "-dpdflatex","-S240,180","-FCalibri:24");

figure%('visible','off');
hold on
box
p = plot(((size(S,1)/2-1):-1:0)*dx*1e-3,kS(1:size(S,1)/2,size(S,1)/2,2,2,3).*(S(1:size(S,1)/2,size(S,1)/2,2,2,3)./(0.2+S(1:size(S,1)/2,size(S,1)/2,2,2,3)))*(1+0.2),'x-')
text(0.18,0.33,'$_{\textrm{d2}}$','color',get(p,'color'),'fontsize',8)
p = plot(((size(S,1)/2-1):-1:0)*dx*1e-3,kS(1:size(S,1)/2,size(S,1)/2,4,2,3).*(S(1:size(S,1)/2,size(S,1)/2,4,2,3)./(0.2+S(1:size(S,1)/2,size(S,1)/2,4,2,3)))*(1+0.2),'+-')
text(0.38,0.33,'$_{\textrm{d4}}$','color',get(p,'color'),'fontsize',8)
p = plot(((size(S,1)/2-1):-1:0)*dx*1e-3,kS(1:size(S,1)/2,size(S,1)/2,5,2,3).*(S(1:size(S,1)/2,size(S,1)/2,5,2,3)./(0.2+S(1:size(S,1)/2,size(S,1)/2,5,2,3)))*(1+0.2),'^-')
text(0.49,0.33,'$_{\textrm{d5}}$','color',get(p,'color'),'fontsize',8)
p = plot(((size(S,1)/2-1):-1:0)*dx*1e-3,kS(1:size(S,1)/2,size(S,1)/2,7,2,3).*(S(1:size(S,1)/2,size(S,1)/2,7,2,3)./(0.2+S(1:size(S,1)/2,size(S,1)/2,7,2,3)))*(1+0.2),'v-')
text(0.57,0.33,'$_{\textrm{d7}}$','color',get(p,'color'),'fontsize',8)
p = plot(((size(S,1)/2-1):-1:0)*dx*1e-3,kS(1:size(S,1)/2,size(S,1)/2,8,2,3).*(S(1:size(S,1)/2,size(S,1)/2,8,2,3)./(0.2+S(1:size(S,1)/2,size(S,1)/2,8,2,3)))*(1+0.2),'o-')
text(0.78,0.33,'$_{\textrm{d8}}$','color',get(p,'color'),'fontsize',8)
xlabel('position (mm)')
xlim([0 1])
ylabel('Consumption rate')
set(gca,'outerposition',[0 0.05 0.9 0.9])
print(["/home/antonybazir/Documents/Post-doc/Redac/metvar/" config_name "_" study_name "_cons_savy_Center_Ox.pdf"], "-dpdflatex","-S240,180","-FCalibri:24");



figure('visible','off');
hold on
box
grid
p = plot(linspace(1,size(St,3)*size(St,2)*dt,size(Ot,3)*size(St,2)),reshape(St(100,:,:,2,1),[1 size(St,3)*size(St,2)]))
text(900,0.95,'$_{\textrm{ref}}$','color',get(p,'color'),'fontsize',8,'horizontalalignment','right')
p = plot(linspace(1,size(St,3)*size(St,2)*dt,size(Ot,3)*size(St,2)),reshape(St(100,:,:,2,2),[1 size(St,3)*size(St,2)]))
text(900,0.85,'$_{\textrm{starv}}$','color',get(p,'color'),'fontsize',8,'horizontalalignment','right')
p = plot(linspace(1,size(St,3)*size(St,2)*dt,size(Ot,3)*size(St,2)),reshape(St(100,:,:,2,3),[1 size(St,3)*size(St,2)]))
text(900,0.75,'$_{\textrm{savy}}$','color',get(p,'color'),'fontsize',8,'horizontalalignment','right')
p = plot(linspace(1,size(St,3)*size(St,2)*dt,size(Ot,3)*size(St,2)),reshape(St(100,:,:,2,4),[1 size(St,3)*size(St,2) ]))
text(900,0.65,'$_{\textrm{compens}}$','color',get(p,'color'),'fontsize',8,'horizontalalignment','right')
p = plot(linspace(1,size(St,3)*size(St,2)*dt,size(Ot,3)*size(St,2)),reshape(St(100,:,:,2,5),[1 size(St,3)*size(St,2) ]))
text(900,0.55,'$_{\textrm{compens prol}}$','color',get(p,'color'),'fontsize',8,'horizontalalignment','right')
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
p = plot(linspace(1,size(St,3)*size(St,2)*dt,size(Ot,3)*size(St,2)),reshape(St(100,:,:,3,1),[1 size(St,3)*size(St,2)]))
text(900,0.95,'$_{\textrm{ref}}$','color',get(p,'color'),'fontsize',8,'horizontalalignment','right')
p = plot(linspace(1,size(St,3)*size(St,2)*dt,size(Ot,3)*size(St,2)),reshape(St(100,:,:,3,2),[1 size(St,3)*size(St,2)]))
text(900,0.85,'$_{\textrm{starv}}$','color',get(p,'color'),'fontsize',8,'horizontalalignment','right')
p = plot(linspace(1,size(St,3)*size(St,2)*dt,size(Ot,3)*size(St,2)),reshape(St(100,:,:,3,3),[1 size(St,3)*size(St,2)]))
text(900,0.75,'$_{\textrm{savy}}$','color',get(p,'color'),'fontsize',8,'horizontalalignment','right')
p = plot(linspace(1,size(St,3)*size(St,2)*dt,size(Ot,3)*size(St,2)),reshape(St(100,:,:,3,4),[1 size(St,3)*size(St,2) ]))
text(900,0.65,'$_{\textrm{compens}}$','color',get(p,'color'),'fontsize',8,'horizontalalignment','right')
p = plot(linspace(1,size(St,3)*size(St,2)*dt,size(Ot,3)*size(St,2)),reshape(St(100,:,:,3,5),[1 size(St,3)*size(St,2) ]))
text(900,0.55,'$_{\textrm{compens prol}}$','color',get(p,'color'),'fontsize',8,'horizontalalignment','right')
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
plot(linspace(1,size(Ot,3),size(Ot,3)*size(Ot,2)),reshape(Ot(100,:,:,2,3),[1 size(Ot,3)*size(Ot,2)]))
plot(linspace(1,size(Ot,3),size(Ot,3)*size(Ot,2)),reshape(Ot(95,:,:,2,3),[1 size(Ot,3)*size(Ot,2)]))
plot(linspace(1,size(Ot,3),size(Ot,3)*size(Ot,2)),reshape(Ot(90,:,:,2,3),[1 size(Ot,3)*size(Ot,2)]))
plot(linspace(1,size(Ot,3),size(Ot,3)*size(Ot,2)),reshape(Ot(85,:,:,2,3),[1 size(Ot,3)*size(Ot,2) ]))
legend('center','near-center','near-rim','rim')
xlabel('time (days)')
ylabel('Concentration')
set(gca,'outerposition',[0 0.05 0.9 0.9])
print(["/home/antonybazir/Documents/Post-doc/Redac/metvar/" config_name "_" study_name "_Ot_Ox.pdf"], "-dpdflatex","-S240,180","-FCalibri:24");

figure('visible','off');
hold on
box
plot(linspace(1,size(Ot,3),size(Ot,3)*size(Ot,2)),reshape(Ot(100,:,:,3,3),[1 size(Ot,3)*size(Ot,2)]))
plot(linspace(1,size(Ot,3),size(Ot,3)*size(Ot,2)),reshape(Ot(95,:,:,3,3),[1 size(Ot,3)*size(Ot,2)]))
plot(linspace(1,size(Ot,3),size(Ot,3)*size(Ot,2)),reshape(Ot(90,:,:,3,3),[1 size(Ot,3)*size(Ot,2)]))
plot(linspace(1,size(Ot,3),size(Ot,3)*size(Ot,2)),reshape(Ot(85,:,:,3,3),[1 size(Ot,3)*size(Ot,2)]))
legend('center','near-center','near-rim','rim')
xlabel('time (days)')
ylabel('Concentration')
set(gca,'outerposition',[0 0.05 0.9 0.9])
print(["/home/antonybazir/Documents/Post-doc/Redac/metvar/" config_name "_" study_name "_Ot_Gl.pdf"], "-dpdflatex","-S240,180","-FCalibri:24");

figure('visible','off');
hold on
box
plot(linspace(1,size(Ot,3),size(Ot,3)*size(Ot,2)),reshape(Ot(100,:,:,2,1),[1 size(Ot,3)*size(Ot,2)]))
plot(linspace(1,size(Ot,3),size(Ot,3)*size(Ot,2)),reshape(Ot(100,:,:,2,2),[1 size(Ot,3)*size(Ot,2)]))
plot(linspace(1,size(Ot,3),size(Ot,3)*size(Ot,2)),reshape(Ot(100,:,:,2,3),[1 size(Ot,3)*size(Ot,2)]))
plot(linspace(1,size(Ot,3),size(Ot,3)*size(Ot,2)),reshape(Ot(100,:,:,2,4),[1 size(Ot,3)*size(Ot,2) ]))
plot(linspace(1,size(Ot,3),size(Ot,3)*size(Ot,2)),reshape(Ot(100,:,:,2,5),[1 size(Ot,3)*size(Ot,2) ]))
xlabel('time (days)')
ylabel('Concentration')
set(gca,'outerposition',[0 0.05 0.9 0.9])
print(["/home/antonybazir/Documents/Post-doc/Redac/metvar/" config_name "_" study_name "_Ot_Ox_Center.pdf"], "-dpdflatex","-S240,180","-FCalibri:24");

figure('visible','off');
hold on
box
plot(linspace(1,size(Ot,3),size(Ot,3)*size(Ot,2)),reshape(Ot(100,:,:,3,1),[1 size(Ot,3)*size(Ot,2)]))
plot(linspace(1,size(Ot,3),size(Ot,3)*size(Ot,2)),reshape(Ot(100,:,:,3,2),[1 size(Ot,3)*size(Ot,2)]))
plot(linspace(1,size(Ot,3),size(Ot,3)*size(Ot,2)),reshape(Ot(100,:,:,3,3),[1 size(Ot,3)*size(Ot,2)]))
plot(linspace(1,size(Ot,3),size(Ot,3)*size(Ot,2)),reshape(Ot(100,:,:,3,4),[1 size(Ot,3)*size(Ot,2) ]))
plot(linspace(1,size(Ot,3),size(Ot,3)*size(Ot,2)),reshape(Ot(100,:,:,3,5),[1 size(Ot,3)*size(Ot,2) ]))
xlabel('time (days)')
ylabel('Concentration')
set(gca,'outerposition',[0 0.05 0.9 0.9])
print(["/home/antonybazir/Documents/Post-doc/Redac/metvar/" config_name "_" study_name "_Ot_Gl_Center.pdf"], "-dpdflatex","-S240,180","-FCalibri:24");




%2, 4, 5&7, 9
##figure;
##d = 8
##pcolor(state_mat(:,:,d,2,2));
##xlim([80 120])
##ylim([80 120])
##colorbar

##hf  = figure
##for i = 1:8
##	hx(i) =  subplot(1,8,i)
##	imagesc(state_mat(:,:,i,2,2));
##	xlim([80 120])
##	ylim([80 120])
##	set(hx(i),'yticklabel',[])
##	set(hx(i),'xticklabel',[])
##endfor
##set(hf,'position',[300 300 1000 90])
####set(hx(1),'position',[0.05 0.05 0.1 0.9])
####set(hx(2),'position',[0.16 0.05   0.1   0.9])
####set(hx(3),'position',[0.27 0.05   0.1   0.9])
####set(hx(4),'position',[0.38 0.05   0.1   0.9])
####set(hx(5),'position',[0.49 0.05   0.1   0.9])
####set(hx(6),'position',[0.6 0.05   0.1   0.9])
####set(hx(7),'position',[0.71 0.05   0.1   0.9])
####set(hx(8),'position',[0.82 0.05 0.1 0.9])
##height = 0.8, width = 0.1;
##set(hx(1),'position',[0.0 0.05    width   height])
##set(hx(2),'position',[0.11 0.05   width   height])
##set(hx(3),'position',[0.22 0.05   width   height])
##set(hx(4),'position',[0.33 0.05   width   height])
##set(hx(5),'position',[0.44 0.05   width   height])
##set(hx(6),'position',[0.55 0.05   width   height])
##set(hx(7),'position',[0.66 0.05   width   height])
##set(hx(8),'position',[0.77 0.05   width   height])
##print(hf,["/home/antonybazirbazir/Documents/Post-doc/Redac/metvar/" study_name "_state_Ox.pdf"], "-dpdflatex","-S480,70","-FCalibri:24");

close all;

##figure
##mesh(1:200,1:200,S(:,:,6,2,3))
##
##figure
##msh_data = reshape(St(:,:,:,2,3),[100 32000]);
## mesh(85:5:100,round(linspace(1,32000,200)),msh_data(85:5:100,round(linspace(1,32000,200)))','meshstyle','column')
##
##figure
##pcolor(S(:,:,6,2,3))
