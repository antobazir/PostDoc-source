clear all;
close all;

%takes all folders
[stat str] = system('ls --ignore=*.m');
str = strsplit(str,'\n');

study_name = 'hypox'


remov = []
for j=1:length(str)
	if(exist([char(str(j)) '/Id'])!=2)
		remov = [remov j]
	endif
endfor

str(remov) = []

selected_str =[str(21:23) str(1:6)];

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
		Pt(:,:,:,i,j) = load(filename(i,:),'Pt_r').Pt_r;
		Kt(:,:,:,i,j) = load(filename(i,:),'Kt_r').Kt_r;
		O(:,:,:,i,j) = load(filename(i,:),'O_r').O_r;
		P(:,:,:,i,j) = load(filename(i,:),'P_r').P_r;
		K(:,:,:,i,j) = load(filename(i,:),'K_r').K_r;
		state_mat(:,:,:,i,j) = load(filename(i,:),'state_mat_r').state_mat_r;
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

F = figure('visible','off');
aF = axes(F);
hold on;
box
semilogy(aF,live(:,1,:),'-o')
xlabel(aF,'days','fontsize',20)
ylabel(aF,'cell number','fontsize',20,'position',[0 100 0])
set(aF,'outerposition',[0 0.05 0.9 0.95])
print(F,["/home/antony/Documents/Post-doc/Redac/metvar/" study_name "_Cnum_Ox.pdf"], "-dpdflatex","-S240,180","-FCalibri:24");

F = figure('visible','off');
aF = axes(F);
hold on;
box
semilogy(aF,live(:,2,:),'-x')
xlabel(aF,'days','fontsize',20)
ylabel(aF,'cell number','fontsize',20,'position',[0 100 0])
set(aF,'outerposition',[0 0.05 0.9 0.95])
print(F,["/home/antony/Documents/Post-doc/Redac/metvar/" study_name "_Cnum_Su.pdf"], "-dpdflatex","-S240,180","-FCalibri:24");

F = figure('visible','off');
aF = axes(F);
hold on;
box
semilogy(aF,dead(:,1,:),'-o')
xlabel(aF,'days','fontsize',20)
ylim([1e1 1e4])
ylabel(aF,'cell number','fontsize',20,'position',[0 100 0])
set(aF,'outerposition',[0 0.05 0.9 0.95])
print(F,["/home/antony/Documents/Post-doc/Redac/metvar/" study_name "_Dnum_Ox.pdf"], "-dpdflatex","-S240,180","-FCalibri:24");

F = figure('visible','off');
aF = axes(F);
hold on;
box
semilogy(aF,dead(:,2,:),'-x')
ylim([1e1 1e4])
xlabel(aF,'days','fontsize',20)
ylabel(aF,'cell number','fontsize',20,'position',[0 100 0])
set(aF,'outerposition',[0 0.05 0.9 0.95])
print(F,["/home/antony/Documents/Post-doc/Redac/metvar/" study_name "_Dnum_Su.pdf"], "-dpdflatex","-S240,180","-FCalibri:24");

F = figure('visible','off');
aF = axes(F);
hold on;
box
plot(dx(:,:,:,size(dx,4),size(dx,5))*(-round(sz/2)+1:round(sz/2))*1e-3,[S(round(sz/2),1:round(sz/2),size(S,3),2,:) fliplr(S(round(sz/2),1:round(sz/2),size(S,3),3,:))])
line([0 0],[0 1.2],'color','black')
ylim([0 1.2])
xlabel(aF,'position (mm)','fontsize',20)
ylabel(aF,'subs. concentration','fontsize',20,'position',[0 100 0])
text(round(sz/3).*dx(:,:,:,3)*1e-3,0.5,'sb-rich','horizontalalignment','center')
text(-round(sz/3).*dx(:,:,:,3)*1e-3,0.5,'ox-rich','horizontalalignment','center')
set(aF,'outerposition',[0 0.05 0.9 0.95])
print(F,["/home/antony/Documents/Post-doc/Redac/metvar/" study_name "_S.pdf"], "-dpdflatex","-S240,180","-FCalibri:24");


F = figure('visible','off');
aF = axes(F);
hold on;
box
plot(dx(:,:,:,size(dx,4),size(dx,5))*(-round(sz/2)+1:round(sz/2))*1e-3,[O(round(sz/2),1:round(sz/2),size(O,3),2,:) fliplr(O(round(sz/2),1:round(sz/2),size(O,3),3,:))])
line([0 0],[0 1.2],'color','black')
ylim([0 1.2])
xlabel(aF,'position (mm)','fontsize',20)
ylabel(aF,'subs. concentration','fontsize',20,'position',[0 100 0])
text(round(sz/3).*dx(:,:,:,3)*1e-3,0.5,'sb-rich','horizontalalignment','center')
text(-round(sz/3).*dx(:,:,:,3)*1e-3,0.5,'ox-rich','horizontalalignment','center')
set(aF,'outerposition',[0 0.05 0.9 0.95])
print(F,["/home/antony/Documents/Post-doc/Redac/metvar/" study_name "_O.pdf"], "-dpdflatex","-S240,180","-FCalibri:24");

F = figure('visible','off');
aF = axes(F);
hold on;
box
plot(dx(:,:,:,size(dx,4),size(dx,5))*(-round(sz/2)+1:round(sz/2))*1e-3,[P(round(sz/2),1:round(sz/2),size(P,3),2,:) fliplr(P(round(sz/2),1:round(sz/2),size(P,3),3,:))])
line([0 0],[0 1.2],'color','black')
ylim([0 1.2])
xlabel(aF,'position (mm)','fontsize',20)
ylabel(aF,'subs. concentration','fontsize',20,'position',[0 100 0])
text(round(sz/3).*dx(:,:,:,3)*1e-3,0.5,'sb-rich','horizontalalignment','center')
text(-round(sz/3).*dx(:,:,:,3)*1e-3,0.5,'ox-rich','horizontalalignment','center')
set(aF,'outerposition',[0 0.05 0.9 0.95])
print(F,["/home/antony/Documents/Post-doc/Redac/metvar/" study_name "_P.pdf"], "-dpdflatex","-S240,180","-FCalibri:24");

F = figure('visible','off');
aF = axes(F);
hold on;
box
plot(dx(:,:,:,size(dx,4),size(dx,5))*(-round(sz/2)+1:round(sz/2))*1e-3,[K(round(sz/2),1:round(sz/2),size(K,3),2,:) fliplr(K(round(sz/2),1:round(sz/2),size(K,3),3,:))])
line([0 0],[0 1.2],'color','black')
ylim([0 1.2])
xlabel(aF,'position (mm)','fontsize',20)
ylabel(aF,'subs. concentration','fontsize',20,'position',[0 100 0])
text(round(sz/3).*dx(:,:,:,3)*1e-3,0.5,'sb-rich','horizontalalignment','center')
text(-round(sz/3).*dx(:,:,:,3)*1e-3,0.5,'ox-rich','horizontalalignment','center')
set(aF,'outerposition',[0 0.05 0.9 0.95])
print(F,["/home/antony/Documents/Post-doc/Redac/metvar/" study_name "_K.pdf"], "-dpdflatex","-S240,180","-FCalibri:24");

