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

selected_str =[str(10:12) str(1:6)];

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

figure;
semilogy(live(:,1,1:8),'-o')
legend

figure;
semilogy(live(:,2,1:8),'-x')
legend

%2, 4, 5&7, 9
figure;
d = 8
pcolor(state_mat(:,:,d,2,2));
xlim([80 120])
ylim([80 120])
colorbar

hf  = figure
for i = 1:8
	hx(i) =  subplot(1,8,i)
	imagesc(state_mat(:,:,i,2,2));
	xlim([80 120])
	ylim([80 120])
	set(hx(i),'yticklabel',[])
	set(hx(i),'xticklabel',[])
endfor
set(hf,'position',[300 300 1000 90])
##set(hx(1),'position',[0.05 0.05 0.1 0.9])
##set(hx(2),'position',[0.16 0.05   0.1   0.9])
##set(hx(3),'position',[0.27 0.05   0.1   0.9])
##set(hx(4),'position',[0.38 0.05   0.1   0.9])
##set(hx(5),'position',[0.49 0.05   0.1   0.9])
##set(hx(6),'position',[0.6 0.05   0.1   0.9])
##set(hx(7),'position',[0.71 0.05   0.1   0.9])
##set(hx(8),'position',[0.82 0.05 0.1 0.9])
set(hx(1),'position',[0.0 0.05 0.1 0.9])
set(hx(2),'position',[0.11 0.05   0.1   0.9])
set(hx(3),'position',[0.22 0.05   0.1   0.9])
set(hx(4),'position',[0.33 0.05   0.1   0.9])
set(hx(5),'position',[0.44 0.05   0.1   0.9])
set(hx(6),'position',[0.55 0.05   0.1   0.9])
set(hx(7),'position',[0.66 0.05   0.1   0.9])
set(hx(8),'position',[0.77 0.05 0.1 0.9])
print(hf,["/home/antony/Documents/Post-doc/Redac/metvar/" study_name "_state_Ox.pdf"], "-dpdflatex","-S480,70","-FCalibri:24");

%95,105

%hclr = colorbar;

hf  = figure
for i = 1:8
	hx(i) =  subplot(1,8,i)
	imagesc(S(:,:,i,2,2));
	xlim([80 120])
	ylim([80 120])
	set(hx(i),'yticklabel',[])
	set(hx(i),'xticklabel',[])
endfor
set(hf,'position',[300 300 1000 90])

