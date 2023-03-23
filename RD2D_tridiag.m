
%this script aims at testing reaction-diffusion in 2D for the first time with non homogeneous diffusion coefficient
clear all;
close all;

tic()
sz = 101;
G = zeros(sz,sz);
G2 = zeros(sz,sz);
GT = zeros(sz,sz);
Gi = zeros(sz,sz);
Gi2 = zeros(sz,sz);
GiT = zeros(sz,sz);
Gn = zeros(sz,sz);
Gn2 = zeros(sz,sz);
GnT = zeros(sz,sz);
NabD_x = zeros(sz,sz);
NabD_y = zeros(sz,sz);
NabD = zeros(sz,sz);
k = zeros(sz,sz);
AA_x = zeros(sz,sz,sz);
AA_y = zeros(sz,sz,sz);
gam =zeros(sz*sz,1);

G(round(sz/2),round(sz/2))=10;
G2(round(sz/2),round(sz/2))=10;
GT(round(sz/2),round(sz/2))=10;
%G(round(sz/2)-3:round(sz/2)+3,round(sz/2))=10;


D = ones(sz,sz);
D = 40000*D;
D_tissue = 10000;
r = sz/4-1; %radius of the tissue circle in units

dx = 15;
dt = 1;
%ntime = 6/dt;
ntime = 10;

%giving all indexes corresponding to a center circle
[i,j,v] = find(D!=0);
dsy = j-round(sz/2);
dsx = i-round(sz/2);
D(find((dsx.^2+dsy.^2)<r^2))= D_tissue;

##%square
##D(round(sz/2)-r:round(sz/2)+r,round(sz/2)-r:round(sz/2)+r)= D_tissue

%matrices necessary for the calculations
% AD the diffusion matrix
AD = D*dt/(dx^2);

%NabD the prediffusion term due to spatial variation of  D
NabD_x(2:sz-1,:) = dt*(D(3:sz,:)-D(1:sz-2,:))/(4*dx^2);
NabD_y(:,2:sz-1) = dt*(D(:,3:sz)-D(:,1:sz-2))/(4*dx^2);


##%MATRIX GENERATION (1st method)--------------------------------------------
##%due to the variation of D in space the matrix changes with L so it needs 3 axes
##for l=1:sz
##      up_dg = [0; AD(2:sz-1,l)+NabD(2:sz-1,l)];
##      lo_dg = [AD(2:sz-1,l)-NabD(2:sz-1,l); 0];
##      dg = [1; 2*AD(2:sz-1,l) + 1 + k(2:sz-1,l)*dt; 1];
##      AA_x(:,:,l)=diag(dg)+ diag(-up_dg,1)+ diag(-lo_dg,-1);% matrix for the first step of solving
##endfor
##  AA_xm2 = blkdiag(AA_x(:,:,1));
##for l=2:sz
##    AA_xm2 = blkdiag(AA_xm2,AA_x(:,:,l));
##endfor
##
##for l=1:sz
##      up_dg = [0 AD(l,2:sz-1)+NabD(l,2:sz-1)];
##      lo_dg = [AD(l,2:sz-1)-NabD(l,2:sz-1) 0];
##      dg = [1 2*AD(l,2:sz-1) + 1 + k(l,2:sz-1)*dt 1];
##      AA_y(:,:,l)=diag(dg)+ diag(-up_dg,1)+ diag(-lo_dg,-1);% matrix for the 2nd step of solving
##endfor
##%------------------------------------------------------------------------------

%MATRIX GENERATION (2nd  method)--------------------------------------------
%matrix generation for x in the block format
%idée créer les diagonale à partir des matrices en rajoutant des lignes/colonnes de zéros où il ya besoin.
    u_mx = AD-NabD_x ;u_mx(1,:) = 0; u_mx(sz,:) = 0;
    up_dg_m = vec(u_mx); up_dg_m = up_dg_m(1:length(up_dg_m)-1);
    l_mx = AD+NabD_x ;l_mx(1,:) = 0; l_mx(sz,:) = 0;
    lo_dg_m = vec(l_mx); lo_dg_m = lo_dg_m(2:length(lo_dg_m));
    dg_mx =  2*AD + 1 + k*dt; dg_mx(1,:)=1; dg_mx(sz,:)=1;
    dg_m = vec(dg_mx);
    up_dg_x = up_dg_m ; lo_dg_x = lo_dg_m ; dg_x = dg_m ;%for tridiag stuff
    AA_xm = diag(dg_m)+ diag(-up_dg_m,1)+ diag(-lo_dg_m,-1);
    SAA_xm = sparse(AA_xm);

%matrix generation for y in the block format
    u_mx = AD-NabD_y ;u_mx(:,1) = 0; u_mx(:,sz) = 0;
    up_dg_m = vec(u_mx'); up_dg_m = up_dg_m(1:length(up_dg_m)-1);
    l_mx = AD+NabD_y ;l_mx(:,1) = 0; l_mx(:,sz) = 0;
    lo_dg_m = vec(l_mx'); lo_dg_m = lo_dg_m(2:length(lo_dg_m));
    dg_mx =  2*AD + 1 + k*dt; dg_mx(:,1)=1; dg_mx(:,sz)=1;
    dg_m = vec(dg_mx');
    up_dg_y = up_dg_m ; lo_dg_y = lo_dg_m ; dg_y = dg_m ;
    AA_ym = diag(dg_m)+ diag(-up_dg_m,1)+ diag(-lo_dg_m,-1);
    SAA_ym = sparse(AA_ym);
%-------------------------------------------------------------------------------------------

    SAA_xm = matrix_type(SAA_xm,"banded",1,1);
    SAA_ym = matrix_type(SAA_ym,"banded",1,1);

for i=1:ntime
    i
    %the artifact seems to be coming from the intermediary step scheme
    Gi = reshape(AA_xm\vec(G),sz,sz);%compute the first matrix
    %Gi = reshape(linsolve(SAA_xm,vec(G)),sz,sz);%compute the first matrix

    Gn = reshape(AA_ym\vec(Gi'),sz,sz);
   % Gn = reshape(linsolve(SAA_ym,vec(G')),sz,sz);
    Gn = Gn';

    G = Gn;
    length(find(Gn-Gn'))
    max(max(Gn-Gn'))

    %waitforbuttonpress
    %kbhit()

    %if that is the case then doing y then x should yield the reverse problem
    Gi2 = reshape(AA_ym\vec(G2'),sz,sz);
    %Gi2 = reshape(linsolve(SAA_ym,vec(G2')),sz,sz);%compute the first matrix
    Gi2= Gi2';

    Gn2 = reshape(AA_xm\vec(Gi2),sz,sz);
    %Gn2 = reshape(linsolve(SAA_xm,vec(G)),sz,sz);
    G2= Gn2;

##    %tridiag solver----------------------------------
##    bet = 1;
##    %forward substitution
##    lv = length(vec(GT'));
##    gam(2:lv) = up_dg_y/bet;
##    bet_v(2:lv) = dg_y(2:lv) - lo_dg_y.*gam(2:lv);
##    vGT= vec(GT');
##    vGiT= vec(GiT');
##    vGiT(2:lv) = (vGT(2:lv)-lo_dg_y.*vGiT(1:lv-1))./bet_v(2:lv)';
##    vGiT(1:lv-1) = vGiT(1:lv-1)-gam(2:lv).*vGiT(2:lv);
##    GiT = reshape(vGiT,sz,sz);
##    GiT =  GiT';
##
##    gam(2:lv) = up_dg_x/bet;
##    bet_v(2:lv) = dg_x(2:lv) - lo_dg_x.*gam(2:lv);
##    vGnT= vec(Gn);
##    vGnT(2:lv) = (vGiT(2:lv)-lo_dg_x.*vGnT(1:lv-1))./bet_v(2:lv)';
##    vGnT(1:lv-1) = vGnT(1:lv-1)-gam(2:lv).*vGnT(2:lv);
##    GnT = reshape(vGnT,sz,sz);
##    GT = GnT;


    %------------------------------------------------
endfor

figure
imagesc(G)
figure
imagesc(G2)
figure
imagesc((G2+G)/2)
figure
imagesc((G+G2)/2-sqrt((G-G2).^2))
figure
imagesc(GT)
toc()

figure;
hold on;
plot(G(round(sz/2),:),'x-')
plot(G(:,round(sz/2)),'v-')
plot(G2(round(sz/2),:),'x-')
plot(G2(:,round(sz/2)),'v-')
G_av = (G+G2)/2;
plot(G_av(:,round(sz/2)),'o-')
