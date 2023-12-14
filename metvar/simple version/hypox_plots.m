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
		Pt(:,:,:,i,j) = load(filename(i,:),'Pt_r').Pt_r;
		Kt(:,:,:,i,j) = load(filename(i,:),'Kt_r').Kt_r;
		O(:,:,:,i,j) = load(filename(i,:),'O_r').O_r;
		P(:,:,:,i,j) = load(filename(i,:),'P_r').P_r;
		K(:,:,:,i,j) = load(filename(i,:),'K_r').K_r;
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
height = 0.8, width = 0.1;
set(hx(1),'position',[0.0 0.05    width   height])
set(hx(2),'position',[0.11 0.05   width   height])
set(hx(3),'position',[0.22 0.05   width   height])
set(hx(4),'position',[0.33 0.05   width   height])
set(hx(5),'position',[0.44 0.05   width   height])
set(hx(6),'position',[0.55 0.05   width   height])
set(hx(7),'position',[0.66 0.05   width   height])
set(hx(8),'position',[0.77 0.05   width   height])
print(hf,["/home/antonybazir/Documents/Post-doc/Redac/metvar/" study_name "_state_Ox.pdf"], "-dpdflatex","-S480,70","-FCalibri:24");

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

figure; plot(linspace(0,7,32000),reshape(St(100,:,:,2,2),[1 32000]),'b')
hold on; plot(0:7,kS(100,100,:,2,2),'b')

plot(linspace(0,7,32000),reshape(St(97,:,:,2,2),[1 32000]),'r')
plot(0:7,kS(100,97,:,2,2),'r')

plot(linspace(0,7,32000),reshape(St(93,:,:,2,2),[1 32000]),'g')
plot((0:7).*1,kS(100,93,:,2,2),'g')

plot(linspace(0,7,32000),reshape(St(90,:,:,2,2),[1 32000]),'cyan')
plot((0:7).*1,kS(100,90,:,2,2),'cyan')
legend('center','near-center','near-rim','rim')
xlabel('eff. days')
ylabel('concentration/consumption')


figure
hold on;
for j=1:8
	prolif(j) = length(find(kS(:,:,j,2,2)==max(max(kS(:,:,j,2,2)))));
	quiesc(j) = length(find(kS(:,:,j,2,2)==0.3*max(max(kS(:,:,j,2,2)))));
endfor
semilogy(prolif,'b')
semilogy(quiesc,'r')

%for a given data set gets the full story
i=2;j=2;
clear full_story; clear diff_story; clear probs;
story_cell = state_story{i,j};
for k=11:-1:4
  vec_story = cell2mat(story_cell(k));
  if(k==11)
    %calculates the max size
    full_size = size(vec_story,1);
  endif
  full_story(k,:) = postpad(vec_story(:,2),full_size);
endfor
diff_story = diff(full_story,1,1);
length(find(max(full_story)==0))
% c'est bon aucune cellule ne repasse de -1 à plus que -1
for k=4:10
  probs(k,:) = and(full_story(k,:)==-1,full_story(k+1,:)>-1);
endfor

%on vérifie qu'on tombe juste entre 6 et 7 ou ça passe de 192 à 193 cellules vivantes
vec_story7 = cell2mat(story_cell(10));
vec_story7 = vec_story7(:,2);
vec_story6 = cell2mat(story_cell(9));
vec_story6 = vec_story6(:,2);
size(vec_story7,1) %tenir compte des 3 vecteurs vides au début
size(vec_story6,1)
disp('day 6:')
length(find(vec_story6==1))
length(find(vec_story6==0))
disp('day 7:')
length(find(vec_story7==1))
length(find(vec_story7==0))


