% 07/11  analysis of the reference configuration script
clear all;
close all
%imagesc(aF,((1:sz)-sz/2)*dx,((1:sz)-sz/2)*dx,S_Gl(:,:,12))
filename = 'ref_conf/metvar_Gl'


Grids = load(filename,'Grid_r').Grid_r;
S = load(filename,'S_r').S_r;
St = load(filename,'St_r').St_r;
O = load(filename,'O_r').O_r;
P = load(filename,'P_r').P_r;
sz = load(filename,'sz').sz;
dx = load(filename,'dx').dx;
dt = load(filename,'dt').dt;


j=3
pos = dx*((1:round(sz))-round(sz/2));

figure;imagesc(pos,pos,Grids(:,:,j));

figure;
plot(pos,S(round(sz/2),:,j))
hold on;
plot(pos,O(round(sz/2),:,j))
plot(pos,P(round(sz/2),:,j))

figure
plot((1:size(St,2))*dt,St(round(sz/2),:,j))
