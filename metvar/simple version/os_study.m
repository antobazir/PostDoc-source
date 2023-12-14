%script for general analysis of first configs
clear all;
close all;

%takes all folders
[stat str] = system('ls --ignore=*.m');
str = strsplit(str,'\n');

config_name =  'simple';
study_name = 'OS';


remov = []
for j=1:length(str)
	if(exist([char(str(j)) '/Id'])!=2)
		remov = [remov j]
	endif
endfor

str(remov) = []

%selected_str =[str(21) str(23) str(22) str(1:2)];
%selected_str =[str(12) str(14) str(7) str(8) str(11) str(9)];
selected_str =[str(11) str(13) str(7) str(8) str(11) str(9)];

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

%problem sur OS. Le nombre de cellule mortes ce qui n'est pas possible
##% le problème c'est que si je PERDS des cellules mortes c'est forcément qu'elle revive.
##state_sty = state_story{3,4};
##for i =13:-1:4
##  i
##  tmp = state_sty{1,i};
##  full_sty(:,i) = postpad(tmp(:,2),size(state_sty{1,11},1));
##endfor
##full_sty = full_sty(:,4:13);
##
##for i=1:9
##  prblms(:,i) = and(full_sty(:,i)==-1,full_sty(:,i+1)!=-1);
##endfor
##figure
##imagesc(prblms)
##find(prblms!=0)
##[r c] = ind2sub([544 9],find(prblms!=0))
##
##%typiquement on a identifié 6 comme une cellule à problème
##[r c z] = ind2sub([200 200 10],find(Grids(:,:,:,3,4)==6))
##S(find(Grids(:,:,:,3,4)==6))
##kS(find(Grids(:,:,:,3,4)==6))
##O(find(Grids(:,:,:,3,4)==6))
##kO(find(Grids(:,:,:,3,4)==6))
##
##k= 6
##[r c z] = ind2sub([200 200 10],find(Grids(:,:,:,3,4)==k))
##[full_sty(k,:)' S(find(Grids(:,:,:,3,4)==k)) kS(find(Grids(:,:,:,3,4)==k)) O(find(Grids(:,:,:,3,4)==k)) kO(find(Grids(:,:,:,3,4)==k)) r  c]
##
##k=3
##[r c z] = ind2sub([200 200 10],find(Grids(:,:,:,3,4)==k))
##a =[full_sty(k,:)' S(find(Grids(:,:,:,3,4)==k)) kS(find(Grids(:,:,:,3,4)==k)) O(find(Grids(:,:,:,3,4)==k)) kO(find(Grids(:,:,:,3,4)==k)) r  c]
##
##k=6
##[r c z] = ind2sub([200 200 10],find(Grids(:,:,:,3,4)==k))
##for i=1:length(z)
##  b(i,:) =  [full_sty(k,i)' S(r(i),c(i),z(i),3,4) kS(r(i),c(i),z(i),3,4) O(r(i),c(i),z(i),3,4) kO(r(i),c(i),z(i),3,4) r(i)  c(i) state_mat(r(i),c(i),z(i),3,4)];
##endfor
##b
##% La condition qui  est censé laisser à zéro n'a pas marché...
##%-1.0000     0.4176          0     0.0073          0   100.0000    97.0000
##%      0     0.4887          0     0.0144          0   100.0000    97.0000
##
##or(and(S(100,97,k,3,4)<0.2,Grids(100,97,k,3,4)!=0),and(Grids(100,97,k,3,4)!=0,kS(100,97,k,3,4)==0,kO(100,97,k,3,4)==0))
##%cette ligne donne 1
##k=7
##or(and(S(100,97,k,3,4)<0.2,Grids(100,97,k,3,4)!=0),and(Grids(100,97,k,3,4)!=0,kS(100,97,k,3,4)==0,kO(100,97,k,3,4)==0))
##%celle -là aussi
##k=6
##and(S(100,97,k,3,4)>=0.5,O(100,97,k,3,4)<0.4,Grids(100,97,k,3,4)!=0,kS(100,97,k,3,4)>0,kO(100,97,k,3,4)>0);
##%celle-là donne zéro comme prévu...
##
##figure
##c = or(and(S(:,:,6,3,4)<0.2,Grids(:,:,6,3,4)!=0),and(Grids(:,:,6,3,4)!=0,kS(:,:,6,3,4)==0,kO(:,:,6,3,4)==0));
##imagesc(a)
##%fonctionne comme prévu
##
##figure
##d = or(and(S(:,:,7,3,4)<0.2,Grids(:,:,7,3,4)!=0),and(Grids(:,:,7,3,4)!=0,kS(:,:,7,3,4)==0,kO(:,:,7,3,4)==0));
##imagesc(b)
##%fonctionne comme prévu
##
##%montre qu'il y a des points qui passent de starv à pas starv mais ça à la limité c'est possible avec les migrations
##imagesc(and(a==1,b==0))

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
text(2,1.5e4,'$_{\textrm{fragile}}$','color', c_p{3,1},'fontsize',8);
text(2,7.5e3,'$_{\textrm{hypos tol}}$','color',c_p{4,1},'fontsize',8);
text(2,3.75e3,'$_{\textrm{hypox tol}}$','color',c_p{5,1},'fontsize',8);
text(2,3.75e3/2,'$_{\textrm{hypox bst}}$','color',c_p{6,1},'fontsize',8);
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
text(2,1.5e4,'$_{\textrm{fragile}}$','color', c_p{3,1},'fontsize',8);
text(2,7.5e3,'$_{\textrm{hypos tol}}$','color',c_p{4,1},'fontsize',8);
text(2,3.75e3,'$_{\textrm{hypox tol}}$','color',c_p{5,1},'fontsize',8);
text(2,3.75e3/2,'$_{\textrm{hypox bst}}$','color',c_p{6,1},'fontsize',8);
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
text(2,1.5e3,'$_{\textrm{fragile}}$','color', c_p{3,1},'fontsize',8);
text(2,7.5e2,'$_{\textrm{hypos tol}}$','color',c_p{4,1},'fontsize',8);
text(2,3.75e2,'$_{\textrm{hypox tol}}$','color',c_p{5,1},'fontsize',8);
text(2,3.75e2/2,'$_{\textrm{hypox bst}}$','color',c_p{6,1},'fontsize',8);
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
text(2,1.5e3,'$_{\textrm{fragile}}$','color', c_p{3,1},'fontsize',8);
text(2,7.5e2,'$_{\textrm{hypos tol}}$','color',c_p{4,1},'fontsize',8);
text(2,3.75e2,'$_{\textrm{hypox tol}}$','color',c_p{5,1},'fontsize',8);
text(2,3.75e2/2,'$_{\textrm{hypox bst}}$','color',c_p{6,1},'fontsize',8);
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
text(900,0.75,'$_{\textrm{fragile}}$','color',get(p,'color'),'fontsize',8,'horizontalalignment','right')
p = plot(linspace(1,size(St,3)*size(St,2)*dt,size(St,3)*size(St,2)),reshape(St(100,:,:,2,4),[1 size(St,3)*size(St,2) ]))
text(900,0.65,'$_{\textrm{hypos tol}}$','color',get(p,'color'),'fontsize',8,'horizontalalignment','right')
p = plot(linspace(1,size(St,3)*size(St,2)*dt,size(St,3)*size(St,2)),reshape(St(100,:,:,2,5),[1 size(St,3)*size(St,2) ]))
text(900,0.55,'$_{\textrm{hypox tol}}$','color',get(p,'color'),'fontsize',8,'horizontalalignment','right')
p = plot(linspace(1,size(St,3)*size(St,2)*dt,size(St,3)*size(St,2)),reshape(St(100,:,:,2,6),[1 size(St,3)*size(St,2) ]))
text(900,0.45,'$_{\textrm{hypox bst}}$','color',get(p,'color'),'fontsize',8,'horizontalalignment','right')
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
text(900,0.75,'$_{\textrm{fragile}}$','color',get(p,'color'),'fontsize',8,'horizontalalignment','right')
p = plot(linspace(1,size(St,3)*size(St,2)*dt,size(St,3)*size(St,2)),reshape(St(100,:,:,3,4),[1 size(St,3)*size(St,2) ]))
text(900,0.65,'$_{\textrm{hypos tol}}$','color',get(p,'color'),'fontsize',8,'horizontalalignment','right')
p = plot(linspace(1,size(St,3)*size(St,2)*dt,size(St,3)*size(St,2)),reshape(St(100,:,:,3,5),[1 size(St,3)*size(St,2) ]))
text(900,0.55,'$_{\textrm{hypox tol}}$','color',get(p,'color'),'fontsize',8,'horizontalalignment','right')
p = plot(linspace(1,size(St,3)*size(St,2)*dt,size(St,3)*size(St,2)),reshape(St(100,:,:,3,6),[1 size(St,3)*size(St,2) ]))
text(900,0.45,'$_{\textrm{hypox bst}}$','color',get(p,'color'),'fontsize',8,'horizontalalignment','right')
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
text(900,0.75,'$_{\textrm{fragile}}$','color',get(p,'color'),'fontsize',8,'horizontalalignment','right')
p = plot(linspace(1,size(Ot,3)*size(Ot,2)*dt,size(Ot,3)*size(Ot,2)),reshape(Ot(100,:,:,2,4),[1 size(Ot,3)*size(Ot,2) ]))
text(900,0.65,'$_{\textrm{hypos tol}}$','color',get(p,'color'),'fontsize',8,'horizontalalignment','right')
p = plot(linspace(1,size(Ot,3)*size(Ot,2)*dt,size(Ot,3)*size(Ot,2)),reshape(Ot(100,:,:,2,5),[1 size(Ot,3)*size(Ot,2) ]))
text(900,0.55,'$_{\textrm{hypox tol}}$','color',get(p,'color'),'fontsize',8,'horizontalalignment','right')
p = plot(linspace(1,size(Ot,3)*size(Ot,2)*dt,size(Ot,3)*size(Ot,2)),reshape(Ot(100,:,:,2,6),[1 size(Ot,3)*size(Ot,2) ]))
text(900,0.45,'$_{\textrm{hypox bst}}$','color',get(p,'color'),'fontsize',8,'horizontalalignment','right')
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
text(900,0.75,'$_{\textrm{fragile}}$','color',get(p,'color'),'fontsize',8,'horizontalalignment','right')
p = plot(linspace(1,size(Ot,3)*size(Ot,2)*dt,size(Ot,3)*size(Ot,2)),reshape(Ot(100,:,:,3,4),[1 size(Ot,3)*size(Ot,2) ]))
text(900,0.65,'$_{\textrm{hypos tol}}$','color',get(p,'color'),'fontsize',8,'horizontalalignment','right')
p = plot(linspace(1,size(Ot,3)*size(Ot,2)*dt,size(Ot,3)*size(Ot,2)),reshape(Ot(100,:,:,3,5),[1 size(Ot,3)*size(Ot,2) ]))
text(900,0.55,'$_{\textrm{hypox tol}}$','color',get(p,'color'),'fontsize',8,'horizontalalignment','right')
p = plot(linspace(1,size(Ot,3)*size(Ot,2)*dt,size(Ot,3)*size(Ot,2)),reshape(Ot(100,:,:,3,6),[1 size(Ot,3)*size(Ot,2) ]))
text(900,0.45,'$_{\textrm{hypox bst}}$','color',get(p,'color'),'fontsize',8,'horizontalalignment','right')

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

