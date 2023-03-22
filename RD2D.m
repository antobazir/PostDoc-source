%this script aims at testing reaction-diffusion in 2D for the first time with non homogeneous diffusion coefficient
clear all;

sz = 21;
G = zeros(sz,sz);
Gi = zeros(sz,sz);
Gn = zeros(sz,sz);
NabD = zeros(sz,sz);
k = zeros(sz,sz);
AA_x = zeros(sz,sz,sz);
AA_y = zeros(sz,sz,sz);

G(round(sz/2),round(sz/2))=10;

D = ones(sz,sz);
D = 40000*D;
D_tissue = 10000;
r = sz/4-1; %radius of the tissue circle in units

dx = 15;
dt = 1/100;
ntime = 1;

%giving all indexes corresponding to a center circle
[i,j,v] = find(D!=0);
dsy = j-round(sz/2);
dsx = i-round(sz/2);
D(find((dsx.^2+dsy.^2)<r^2))= D_tissue;

%matrices necessary for the calculations
% AD the diffusion matrix
AD = D*dt/(dx^2);

%NabD the prediffusion term due to spatial variation of  D
NabD(2:sz-1,:) = (D(3:sz,:)-D(1:sz-2,:))/(2*dx);
NabD(:,2:sz-1) = NabD(:,2:sz-1) + (D(:,3:sz)-D(:,1:sz-2))/(2*dx);

%due to the variation of D in space the matrix changes with L so it needs 3 axes
for l=1:sz
      up_dg = [0; AD(2:sz-1,l)+NabD(2:sz-1,l)];
      lo_dg = [AD(2:sz-1,l)-NabD(2:sz-1,l); 0];
      dg = [1; 2*AD(2:sz-1,l) + 1 + k(2:sz-1,l)*dt; 1];
      AA_x(:,:,l)=diag(dg)+ diag(-up_dg,1)+ diag(-lo_dg,-1);% matrix for the first step of solving
endfor

%vector generation can be optimized but not matrix as diag is coded for NxN matrices.
##      up_dg2 = [zeros(1,length(1:sz));  AD(2:sz-1,:)+NabD(2:sz-1,:)];
##      lo_dg2 = [AD(2:sz-1,:)-NabD(2:sz-1,:); zeros(1,length(1:sz))];
##      dg2 = [ones(1,length(1:sz)); 2*AD(2:sz-1,:) + 1 + k(2:sz-1,:)*dt; ones(1,length(1:sz))];


for l=1:sz
      up_dg = [0 AD(l,2:sz-1)+NabD(l,2:sz-1)];
      lo_dg = [AD(l,2:sz-1)-NabD(l,2:sz-1) 0];
      dg = [1 2*AD(l,2:sz-1) + 1 + k(l,2:sz-1)*dt 1];
      AA_y(:,:,l)=diag(dg)+ diag(-up_dg,1)+ diag(-lo_dg,-1);% matrix for the 2nd step of solving
endfor

%idée créer les diagonale à partir des matrices en rajoutant des lignes/colonnes de zéros où il ya besoin.

for i=1:ntime

endfor
