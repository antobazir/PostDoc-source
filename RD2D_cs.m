
%this script aims at testing reaction-diffusion in 2D for the first time with non homogeneous diffusion coefficient
clear all;
close all;

tic()
sz = 51;
G = zeros(sz,sz);
G2 = zeros(sz,sz);
Gi = zeros(sz,sz);
Gi2 = zeros(sz,sz);
Gn = zeros(sz,sz);
Gn2 = zeros(sz,sz);
NabD_x = zeros(sz,sz);
NabD_y = zeros(sz,sz);
NabD = zeros(sz,sz);
k = zeros(sz,sz);
AA_x = zeros(sz,sz,sz);
AA_y = zeros(sz,sz,sz);

%G(round(sz/2),round(sz/2))=5;
%G2(round(sz/2),round(sz/2))=5;
%G(round(sz/2)-3:round(sz/2)+3,round(sz/2))=10;


D = ones(sz,sz);
D = 40000*D;
D_tissue = 10000;
k_tissue = 0.1
r = round(sz/2.2)-1; %radius of the tissue circle in units

dx = 15;
dt = 1/100;
ntime = 20/dt;

%giving all indexes corresponding to a center circle
[i,j,v] = find(D!=0);
dsy = j-round(sz/2);
dsx = i-round(sz/2);
D(find((dsx.^2+dsy.^2)<r^2))= D_tissue;
k(find((dsx.^2+dsy.^2)<r^2))= k_tissue;
%G(find((dsx.^2+dsy.^2)>=r^2))= 5;
%G2(find((dsx.^2+dsy.^2)>=r^2))= 5;
G(:,:) =5;
%G2(:,:) = 5;

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
    AA_xm = diag(dg_m)+ diag(-up_dg_m,1)+ diag(-lo_dg_m,-1);
    %SAA_xm = sparse(AA_xm);

%matrix generation for y in the block format
    u_mx = AD-NabD_y ;u_mx(:,1) = 0; u_mx(:,sz) = 0;
    up_dg_m = vec(u_mx'); up_dg_m = up_dg_m(1:length(up_dg_m)-1);
    l_mx = AD+NabD_y ;l_mx(:,1) = 0; l_mx(:,sz) = 0;
    lo_dg_m = vec(l_mx'); lo_dg_m = lo_dg_m(2:length(lo_dg_m));
    dg_mx =  2*AD + 1 + k*dt; dg_mx(:,1)=1; dg_mx(:,sz)=1;
    dg_m = vec(dg_mx');
    AA_ym = diag(dg_m)+ diag(-up_dg_m,1)+ diag(-lo_dg_m,-1);
    %SAA_ym = sparse(AA_ym);
%-------------------------------------------------------------------------------------------
##  useless
##    SAA_xm = matrix_type(SAA_xm,"banded",1,1)
##    SAA_ym = matrix_type(SAA_ym,"banded",1,1)

for i=1:ntime
    G(find((dsx.^2+dsy.^2)>=r^2))= 5;
    %G2(find((dsx.^2+dsy.^2)>=r^2))= 5;
    i
    %the artifact seems to be coming from the intermediary step scheme
    Gi = reshape(AA_xm\vec(G),sz,sz);%compute the first matrix
    %Gi = reshape(linsolve(SAA_xm,vec(G)),sz,sz);%compute the first matrix

    Gn = reshape(AA_ym\vec(Gi'),sz,sz);
    %Gn = reshape(linsolve(SAA_ym,vec(G')),sz,sz);
    Gn = Gn';

    G = Gn;
    length(find(Gn-Gn'))
    max(max(Gn-Gn'))

    %waitforbuttonpress
    %kbhit()

##    %if that is the case then doing y then x should yield the reverse problem
##    Gi2 = reshape(AA_ym\vec(G2'),sz,sz);
##    %Gi2 = reshape(linsolve(SAA_ym,vec(G2')),sz,sz);%compute the first matrix
##    Gi2= Gi2';
##
##    Gn2 = reshape(AA_xm\vec(Gi2),sz,sz);
##    %Gn2 = reshape(linsolve(SAA_xm,vec(G)),sz,sz);
##    G2= Gn2;
    Gti(i,1) =  G(round(sz/2),round(sz/2));
    Gti(i,2) =  G(round(sz/2),round(sz/5));
endfor

fG = figure;
aG = axes(fG);
imagesc((1:sz)*dx,(1:sz)*dx,G)
xlabel(aG,'position (µm)','fontsize',20)
ylabel(aG, 'position (µm)','fontsize',20)
##fG2 = figure;
##aG2 = axes(fG2);
##imagesc((1:sz)*dx,(1:sz)*dx,G2)
##xlabel(aG2,'position (µm)','fontsize',20)
##ylabel(aG2, 'position (µm)','fontsize',20)
##figure
##%imagesc((G2+G)/2)
##imagesc((G+G2)/2-sqrt((G-G2).^2))
toc()

fD  = figure;
aD = axes(fD);
hold(aD);
plot(aD,(1:sz)*dx,G(round(sz/2),:),'x-')
plot(aD,(1:sz)*dx,G(:,round(sz/2)),'v-')
xlabel(aD,'position (µm)','fontsize',20)
ylabel(aD, 'Concentration (u.a)','fontsize',20)
legend(aD,'x-midline','y-midline')
%plot(G2(round(sz/2),:),'x-')
%plot(G2(:,round(sz/2)),'v-')

fGt  = figure;
aGt = axes(fGt);
hold(aGt);
plot(aGt,(1:ntime)*dt,Gti(:,1))
plot(aGt,(1:ntime)*dt,Gti(:,2))
xlabel(aGt,'time (min)','fontsize',20)
ylabel(aGt, 'Concentration (mM)','fontsize',20)
legend(aGt,'center','mid-radius')

print (fG, "/home/antony/Documents/Post-doc/test_fortran/plots/RD_G630_100_cs_km1_lg_full.pdf", "-dpdflatexstandalone","-S480,360","-FCalibri:22");
%print (fG2, "/home/antony/Documents/Post-doc/test_fortran/plots/RD_G2_100_cs_km1_lg_full.pdf", "-dpdflatexstandalone","-S480,360","-FCalibri:22");
print (fD, "/home/antony/Documents/Post-doc/test_fortran/plots/RD_lines630_100_cs_km1_lg_full.pdf", "-dpdflatexstandalone","-S480,360","-FCalibri:22");
print (fGt, "/home/antony/Documents/Post-doc/test_fortran/plots/RD_t630_cs_km1_lg_full.pdf", "-dpdflatexstandalone","-S480,360","-FCalibri:22");

