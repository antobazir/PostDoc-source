clear all;
close all;

%takes all folders
[stat str] = system('ls --ignore=*.m');
str = strsplit(str,'\n');

remov = []
for j=1:length(str)
	if(exist([char(str(j)) '/Id'])!=2)
		remov = [remov j]
	endif
endfor

str(remov) = []

for j =1:length(str)

	folder_name = char(str(j))
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
	endfor

endfor

sz = sz(:,:,:,size(sz,4),size(sz,5));

figure
semilogy(live(:,1,:),'x-')

figure
semilogy(live(:,2,:),'o-')

##figure
##plot(S(1:round(sz/2),round(sz/2),size(S,3),2,:))
##figure
##plot(S(1:round(sz/2),round(sz/2),size(S,3),3,:))
##
##
##figure
##plot(O(1:round(sz/2),round(sz/2),size(S,3),2,:))
##figure
##plot(O(1:round(sz/2),round(sz/2),size(S,3),3,:))
##
##
##figure
##plot(P(1:round(sz/2),round(sz/2),size(P,3),2,:))
##figure
##plot(P(1:round(sz/2),round(sz/2),size(P,3),3,:))
##
##figure
##plot(K(1:round(sz/2),round(sz/2),size(K,3),2,:))
##figure
##plot(K(1:round(sz/2),round(sz/2),size(K,3),3,:))
##
##figure
##hold on
##plot(O(1:round(sz/2),round(sz/2),size(S,3),2,:))
##plot(state_mat(1:round(sz/2),round(sz/2),size(S,3),2,:)./max(state_mat(1:round(sz/2),round(sz/2),size(S,3),2,:)),'--')
##

figure
semilogy(live(:,1,15:19),'x-')



