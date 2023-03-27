
%this script aims at testing reaction-diffusion in 2D for the first time with non homogeneous diffusion coefficient
clear all;
close all;

tic()
sz = 81;
O = zeros(sz,sz);
O2 = zeros(sz,sz);
Oi = zeros(sz,sz);
Oi2 = zeros(sz,sz);
On = zeros(sz,sz);
On2 = zeros(sz,sz);
NabD_x = zeros(sz,sz);
NabD_y = zeros(sz,sz);
NabD = zeros(sz,sz);
k = zeros(sz,sz);
AA_x = zeros(sz,sz,sz);
AA_y = zeros(sz,sz,sz);

%O(round(sz/2),round(sz/2))=5;
%O2(round(sz/2),round(sz/2))=5;
%O(round(sz/2)-3:round(sz/2)+3,round(sz/2))=10;


D = ones(sz,sz);
D = 100000*D;
D_tissue = 100000;
k_tissue = 1
r = round(sz/2.2)-1; %radius of the tissue circle in units

dx = 15;
dt = 1/100;
ntime = 10/dt;

%giving all indexes corresponding to a center circle
[i,j,v] = find(D!=0);
dsy = j-round(sz/2);
dsx = i-round(sz/2);
D(find((dsx.^2+dsy.^2)<r^2))= D_tissue;
k(find((dsx.^2+dsy.^2)<r^2))= k_tissue;
%O(find((dsx.^2+dsy.^2)>=r^2))= 5;
%O2(find((dsx.^2+dsy.^2)>=r^2))= 5;
O(:,:) =0.5;
O2(:,:) = 0.5;

##%square
##D(round(sz/2)-r:round(sz/2)+r,round(sz/2)-r:round(sz/2)+r)= D_tissue

%matrices necessary for the calculations
% AD the diffusion matrix
AD = D*dt/(dx^2);

%NabD the prediffusion term due to spatial variation of  D
NabD_x(2:sz-1,:) = dt*(D(3:sz,:)-D(1:sz-2,:))/(4*dx^2);
NabD_y(:,2:sz-1) = dt*(D(:,3:sz)-D(:,1:sz-2))/(4*dx^2);


##%MATRIX OENERATION (1st method)--------------------------------------------
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

%MATRIX OENERATION (2nd  method)--------------------------------------------
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
    O(find((dsx.^2+dsy.^2)>=r^2))= 0.5;
    O2(find((dsx.^2+dsy.^2)>=r^2))= 0.5;
    i
    %the artifact seems to be coming from the intermediary step scheme
    Oi = reshape(AA_xm\vec(O),sz,sz);%compute the first matrix
    %Oi = reshape(linsolve(SAA_xm,vec(O)),sz,sz);%compute the first matrix

    On = reshape(AA_ym\vec(Oi'),sz,sz);
    %On = reshape(linsolve(SAA_ym,vec(O')),sz,sz);
    On = On';

    O = On;
    length(find(On-On'))
    max(max(On-On'))

    %waitforbuttonpress
    %kbhit()

##    %if that is the case then doing y then x should yield the reverse problem
##    Oi2 = reshape(AA_ym\vec(O2'),sz,sz);
##    %Oi2 = reshape(linsolve(SAA_ym,vec(O2')),sz,sz);%compute the first matrix
##    Oi2= Oi2';
##
##    On2 = reshape(AA_xm\vec(Oi2),sz,sz);
##    %On2 = reshape(linsolve(SAA_xm,vec(O)),sz,sz);
##    O2= On2;
    Oti(i,1) =  O(round(sz/2),round(sz/2));
    Oti(i,2) =  O(round(sz/2),round(sz/5));
endfor

fO = figure;
aO = axes(fO);
imagesc((1:sz)*dx,(1:sz)*dx,O)
xlabel(aO,'position (µm)','fontsize',20)
ylabel(aO, 'position (µm)','fontsize',20)
##fO2 = figure;
##aO2 = axes(fO2);
##imagesc((1:sz)*dx,(1:sz)*dx,O2)
##xlabel(aO2,'position (µm)','fontsize',20)
##ylabel(aO2, 'position (µm)','fontsize',20)
##figure
##%imagesc((O2+O)/2)
##imagesc((O+O2)/2-sqrt((O-O2).^2))
toc()

fD  = figure;
aD = axes(fD);
hold(aD);
plot(aD,(1:sz)*dx,O(round(sz/2),:),'x-')
plot(aD,(1:sz)*dx,O(:,round(sz/2)),'v-')
xlabel(aD,'position (µm)','fontsize',20)
ylabel(aD, 'Concentration (u.a)','fontsize',20)
legend(aD,'x-midline','y-midline')
%plot(O2(round(sz/2),:),'x-')
%plot(O2(:,round(sz/2)),'v-')

fOt  = figure;
aOt = axes(fOt);
hold(aOt);
plot(aOt,(1:ntime)*dt,Oti(:,1))
plot(aOt,(1:ntime)*dt,Oti(:,2))
xlabel(aOt,'time (min)','fontsize',20)
ylabel(aOt, 'Concentration (mM)','fontsize',20)
legend(aOt,'center','outside')

print (fO, "/home/antony/Documents/Post-doc/test_fortran/plots/RD_O1050_100_cs_k1.pdf", "-dpdflatexstandalone","-S480,360","-FCalibri:22");
%print (fO2, "/home/antony/Documents/Post-doc/test_fortran/plots/RD_O2_100_cs_km1_lg_full.pdf", "-dpdflatexstandalone","-S480,360","-FCalibri:22");
print (fD, "/home/antony/Documents/Post-doc/test_fortran/plots/RD_Olines1050_100_cs_k1.pdf", "-dpdflatexstandalone","-S480,360","-FCalibri:22");
print (fOt, "/home/antony/Documents/Post-doc/test_fortran/plots/RD_Ot1050_cs_k1.pdf", "-dpdflatexstandalone","-S480,360","-FCalibri:22");

