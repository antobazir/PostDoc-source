clear all;
close all;

tic()
sz = 51;
G = zeros(sz,sz);
Gi = zeros(sz,sz);
Gn = zeros(sz,sz);
NabD_x = zeros(sz,sz);
NabD_y = zeros(sz,sz);
NabD = zeros(sz,sz);
kO = zeros(sz,sz);
kG = zeros(sz,sz);


DOx = ones(sz,sz);
DOx = 100000*D;
DOx_tissue = 100000;
kOx_tissue = 0.1
DG = ones(sz,sz);
DG = 40000*D;
DG_tissue = 10000;
kG_tissue = 0.1
r = round(sz/2.2)-2; %radius of the tissue circle in units

dx = 15;
dt = 1/100;
ntime = 10/dt;

%giving all indexes corresponding to a center circle
[i,j,v] = find(D!=0);
dsy = j-round(sz/2);
dsx = i-round(sz/2);
DOx(find((dsx.^2+dsy.^2)<r^2))= DOx_tissue;
DG(find((dsx.^2+dsy.^2)<r^2))= DG_tissue;
kO(find((dsx.^2+dsy.^2)<r^2))= kO_tissue;
kG(find((dsx.^2+dsy.^2)<r^2))= kG_tissue;

G(:,:) =5;
O(:,:) =0.5;

ADO = DOx*dt/(dx^2);
ADG = DG*dt/(dx^2);

%NabD the prediffusion term due to spatial variation of  D
NDO_x(2:sz-1,:) = dt*(DOx(3:sz,:)-DOx(1:sz-2,:))/(4*dx^2);
NDO_y(:,2:sz-1) = dt*(DOx(:,3:sz)-DOx(:,1:sz-2))/(4*dx^2);

NDG_x(2:sz-1,:) = dt*(DG(3:sz,:)-DG(1:sz-2,:))/(4*dx^2);
NDG_y(:,2:sz-1) = dt*(DG(:,3:sz)-DG(:,1:sz-2))/(4*dx^2);

%matrix for oxygen----------------------------------
%matrix generation for x in the block format
%idée créer les diagonale à partir des matrices en rajoutant des lignes/colonnes de zéros où il ya besoin.
    u_mx = ADO-NDO_x ;u_mx(1,:) = 0; u_mx(sz,:) = 0;
    up_dg_m = vec(u_mx); up_dg_m = up_dg_m(1:length(up_dg_m)-1);
    l_mx = ADO+NDO_x ;l_mx(1,:) = 0; l_mx(sz,:) = 0;
    lo_dg_m = vec(l_mx); lo_dg_m = lo_dg_m(2:length(lo_dg_m));
    dg_mx =  2*ADO + 1 + kO*dt; dg_mx(1,:)=1; dg_mx(sz,:)=1;
    dg_m = vec(dg_mx);
    AO_xm = diag(dg_m)+ diag(-up_dg_m,1)+ diag(-lo_dg_m,-1);

%matrix generation for y in the block format
    u_mx = ADO-NDO_y ;u_mx(:,1) = 0; u_mx(:,sz) = 0;
    up_dg_m = vec(u_mx'); up_dg_m = up_dg_m(1:length(up_dg_m)-1);
    l_mx = ADO+NDO_y ;l_mx(:,1) = 0; l_mx(:,sz) = 0;
    lo_dg_m = vec(l_mx'); lo_dg_m = lo_dg_m(2:length(lo_dg_m));
    dg_mx =  2*ADO + 1 + kO*dt; dg_mx(:,1)=1; dg_mx(:,sz)=1;
    dg_m = vec(dg_mx');
    AO_ym = diag(dg_m)+ diag(-up_dg_m,1)+ diag(-lo_dg_m,-1);
%--------------------------

%matrix for glucose----------------------------------
%matrix generation for x in the block format
%idée créer les diagonale à partir des matrices en rajoutant des lignes/colonnes de zéros où il ya besoin.
    u_mx = ADG-NDG_x ;u_mx(1,:) = 0; u_mx(sz,:) = 0;
    up_dg_m = vec(u_mx); up_dg_m = up_dg_m(1:length(up_dg_m)-1);
    l_mx = ADG+NDG_x ;l_mx(1,:) = 0; l_mx(sz,:) = 0;
    lo_dg_m = vec(l_mx); lo_dg_m = lo_dg_m(2:length(lo_dg_m));
    dg_mx =  2*ADG + 1 + kG*dt; dg_mx(1,:)=1; dg_mx(sz,:)=1;
    dg_m = vec(dg_mx);
    AG_xm = diag(dg_m)+ diag(-up_dg_m,1)+ diag(-lo_dg_m,-1);

%matrix generation for y in the block format
    u_mx = ADG-NDG_y ;u_mx(:,1) = 0; u_mx(:,sz) = 0;
    up_dg_m = vec(u_mx'); up_dg_m = up_dg_m(1:length(up_dg_m)-1);
    l_mx = ADG+NDG_y ;l_mx(:,1) = 0; l_mx(:,sz) = 0;
    lo_dg_m = vec(l_mx'); lo_dg_m = lo_dg_m(2:length(lo_dg_m));
    dg_mx =  2*ADG + 1 + kG*dt; dg_mx(:,1)=1; dg_mx(:,sz)=1;
    dg_m = vec(dg_mx');
    AG_ym = diag(dg_m)+ diag(-up_dg_m,1)+ diag(-lo_dg_m,-1);
%--------------------------

for i=1:ntime
    %explicit  scheme
    O(2:n_space-1) =  O(2:n_space-1) + DOx(2:_space-1)*dt/dx^2.*(O(3:n_space) -2*(O(2:n_space-1)) + O(1:n_space-2)) -kO(2:n_space-1).*dt.*O(2:n_space-1).*GD(2:n_space-1);
    G(2:n_space-1) =  G(2:n_space-1) + DG(2:_space-1)*dt/dx^2.*(G(3:n_space) -2*(G(2:n_space-1)) + G(1:n_space-2)) -kG(2:n_space-1).*dt.*G(2:n_space-1).*D(2:n_space-1);
    D(2:n_space-1) =  D(2:n_space-1) -kG(2:n_space-1).*dt.*D(2:n_space-1).*GD(2:n_space-1) + kT(2:n_space-1).*dt.*T(2:n_space-1);
    GD(2:n_space-1) =  GD(2:n_space-1) +kG(2:n_space-1).*dt.*D(2:n_space-1).*G(2:n_space-1) - kO(2:n_space-1).*dt.*GD(2:n_space-1).*O(2:n_space-1);
    T(2:n_space-1) =  T(2:n_space-1) +kO(2:n_space-1).*dt.*O(2:n_space-1).*GD(2:n_space-1) - kT(2:n_space-1).*dt.*T(2:n_space-1);



    G(find((dsx.^2+dsy.^2)>=r^2))= 5;
    O(find((dsx.^2+dsy.^2)>=r^2))= 0.5;

    i
    %the artifact seems to be coming from the intermediary step scheme
    Gi = reshape(AG_xm\vec(G),sz,sz);%compute the first matrix
    Oi = reshape(AO_xm\vec(O),sz,sz);%compute the first matrix


    On = reshape(AO_ym\vec(Oi'),sz,sz);
    Gn = reshape(AG_ym\vec(Gi'),sz,sz);

    Gn = Gn';
    On = On';

    G = Gn;
    O = On;

endfor
