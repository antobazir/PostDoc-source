%script for general analysis of first configs
clear all;
close all;

wrk_dir = "/home/antonybazir/Documents/Post-doc/Redac/metvar/"

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
suff = ['Id'; 'Ox'; 'Gl'];

for j =1:length(selected_str)

	folder_name = char(selected_str(j))
	clear filename
	%initiation of the different cases
	filename(1,:) = [folder_name '/' suff(1,:)];
	filename(2,:) = [folder_name '/' suff(2,:)];
	filename(3,:) = [folder_name '/' suff(3,:)];


	for i=1:3
    plt_name{i,j} = [folder_name '_' suff(i,:)];
		Grids{i,j} = load(filename(i,:),'Grid_r').Grid_r;
		S{i,j} = load(filename(i,:),'S_r').S_r;
		kS{i,j} = load(filename(i,:),'kS_r').kS_r;
		St{i,j} = load(filename(i,:),'St_r').St_r;
		Ot{i,j} = load(filename(i,:),'Ot_r').Ot_r;
		%Pt{i,j} = load(filename(i,:),'Pt_r').Pt_r;
		%Kt{i,j} = load(filename(i,:),'Kt_r').Kt_r;
		O{i,j} = load(filename(i,:),'O_r').O_r;
		%P{i,j} = load(filename(i,:),'P_r').P_r;
		%K{i,j} = load(filename(i,:),'K_r').K_r;
		state_mat{i,j} = load(filename(i,:),'state_mat_r').state_mat_r;
		state_story{i,j} = load(filename(i,:),'state_story').state_story;
		%state_mat{i,j} = load(filename(i,:),'prod_mat_r').prod_mat_r;
		sz{i,j} = load(filename(i,:),'sz').sz;
		dx{i,j} = load(filename(i,:),'dx').dx;
		dt{i,j} = load(filename(i,:),'dt').dt;
	endfor

endfor

%dx =60;

function [live,dead] = live_dead(Gr,kM)
  for i=1:size(Gr,3)
    live(i) = length(find(and(Gr(:,:,i)!=0,kM(:,:,i)!=0)));
    dead(i) = length(find(and(Gr(:,:,i)!=0,kM(:,:,i)==0)));
  endfor
endfunction


y_leg{1,1} = 8e2;
ro = 1.5
y_leg{1,2} = y_leg{1,1}/ro;
y_leg{1,3} = y_leg{1,2}/ro;
y_leg{1,4} = y_leg{1,3}/ro;
y_leg{1,5} = y_leg{1,4}/ro;

y_leg_d{1,1} = 8e2;
ro = 1.8
y_leg_d{1,2} = y_leg_d{1,1}/ro;
y_leg_d{1,3} = y_leg_d{1,2}/ro;
y_leg_d{1,4} = y_leg_d{1,3}/ro;
y_leg_d{1,5} = y_leg_d{1,4}/ro;

sel_str  = strrep(selected_str,'_','');

function [p] = plot_all_conds(popl,y_leg,selected_str)
  p = semilogy(popl,'-+')
  c_p = get(p,'color');
  xl = xlim(gca);
  text(1,y_leg,['$_{\textrm{' selected_str '}}$'],'color',c_p,'fontsize',8);
  %print([ "/home/antonybazir/Documents/Post-doc/Redac/metvar/" plt_nm "_" plt_var ".pdf"], "-dpdflatex","-S240,180","-FCalibri:24");

endfunction

[lives,deads] = cellfun(@live_dead,Grids,kS,"UniformOutput", false);
%cellstr(repmat('lives',size(deads,2),1))
for i=1:3
    figure('visible','off');
    hold on;
    box
    grid
    p_live = cellfun(@plot_all_conds,lives(i,:),y_leg,sel_str)
    xlabel('cycles')
    yl = ylabel('cell number','position',[-2.1 100 0])
    %ylim([1 1000])
    %get(yl,'position')
    %legend(selected_str)
    print([ "/home/antonybazir/Documents/Post-doc/Présentation/Dec2023/" suff(i,:) "_lives.pdf"], "-dpdflatex","-S160,135","-FCalibri:24");
    close

    figure('visible','off');
    hold on;
    box
    grid
    p_live = cellfun(@plot_all_conds,deads(i,:),y_leg_d,sel_str)
    xlabel('cycles')
    yl = ylabel('cell number','position',[-2.1 20 0])
    %ylim([1 1000])
    %get(yl,'position')
    %legend(selected_str)
    print([ "/home/antonybazir/Documents/Post-doc/Présentation/Dec2023/" suff(i,:) "_deads.pdf"], "-dpdflatex","-S160,135","-FCalibri:24");
    close
endfor

function p = plot_map(Mp,fname)
figure('visible','off');
hold on;
box
grid
x = -round(size(Mp,1)/2)+1:round(size(Mp,1)/2);
y = -round(size(Mp,2)/2)+1:round(size(Mp,2)/2);
imagesc(x*1e-3,y*1e-3,Mp)
xlabel('position (mm)');
ylabel('position (mm)');
print([ "/home/antonybazir/Documents/Post-doc/Présentation/Dec2023/" fname ".pdf"], "-dpdflatex","-S160,135","-FCalibri:24");
close
endfunction

function p = plot_midlines(Mp1,Mp2,fname,fg_size,ft_size)
dx =60
figure('visible','off');
hold on;
box
grid
x = -round(size(Mp1,1)/2)+1:round(size(Mp1,1)/2);
plot(x*dx*1e-3,Mp1(:,round(size(Mp1,1)/2)),'+-','markersize',3,'color','blue')
plot(x*dx*1e-3,Mp2(:,round(size(Mp2,1)/2)),'o-','markersize',3,'color','red')
xlabel('position (mm)');
ylabel('Concentration');
%legend
print([ "/home/antonybazir/Documents/Post-doc/Présentation/Dec2023/" fname ".pdf"], "-dpdflatex",fg_size,ft_size);
close
endfunction

function p = nutr_time(Nt,dt,fname,fg_size,ft_size)
if(size(Nt,1)==1)
Nt=Nt';
endif
figure('visible','off');
hold on;
box
grid
for i=1:length(Nt)
  size(Nt{i,1},2)
  plot((1:size(Nt{i,1},2))*dt,Nt{i,1}(size(Nt{i,1},1),:))
endfor
xlabel('time (mn)');
ylabel('Concentration');
%legend('Id','Ox','Gl')
%legend
print([ "/home/antonybazir/Documents/Post-doc/Présentation/Dec2023/" fname ".pdf"], "-dpdflatex",fg_size,ft_size);
close
endfunction


plot_map(kS{2,3}(:,:,size(kS{2,3},3)),'kS_savy_Ox_final');
plot_map(kS{2,5}(:,:,size(kS{2,5},3)),'kS_compens_Ox_final');

for i=1:3
  plot_midlines(S{i,1}(:,:,size(S{i,1},3)),O{i,1}(:,:,size(O{i,1},3)),['ref_' suff(i,:) '_midl'],"-S100,90","-FCalibri:35")
endfor

nutr_time(St(:,1),dt{1,1},'St_ctr_ref_conf',"-S160,135","-FCalibri:24");
nutr_time(Ot(:,1),dt{1,1},'Ot_ctr_ref_conf',"-S160,135","-FCalibri:24");

nutr_time(St(1,:),dt{1,1},'St_ctr_Id',"-S160,135","-FCalibri:24");
nutr_time(St(2,:),dt{1,1},'St_ctr_Ox',"-S160,135","-FCalibri:24");
nutr_time(St(3,:),dt{1,1},'St_ctr_Gl',"-S160,135","-FCalibri:24");
nutr_time(Ot(1,:),dt{1,1},'Ot_ctr_Id',"-S160,135","-FCalibri:24");
nutr_time(Ot(2,:),dt{1,1},'Ot_ctr_Ox',"-S160,135","-FCalibri:24");
nutr_time(Ot(3,:),dt{1,1},'Ot_ctr_Gl',"-S160,135","-FCalibri:24");


##figure('visible','off');
##hold on;
##box
##grid
##semilogy(lives{1,1},'-+')
##print([ "/home/antonybazir/Documents/Post-doc/Présentation/Dec2023/ref_conf_pop.pdf"], "-dpdflatex","-S160,135","-FCalibri:24");
##close



##figure
##imagesc(kS{2,5}(:,:,size(kS{2,5},3)))
##figure
##imagesc(S{2,5}(:,:,size(S{2,5},3)))
##figure
##hold on;




