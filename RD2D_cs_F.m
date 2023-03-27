
%this script aims at testinF reaction-diffusion in 2D for the first time with non homoFeneous diffusion coefficient
clear all;
close all;

tic()
sz = 41;
F = zeros(sz,sz);
F2 = zeros(sz,sz);
Fi = zeros(sz,sz);
Fi2 = zeros(sz,sz);
Fn = zeros(sz,sz);
Fn2 = zeros(sz,sz);
NabD_x = zeros(sz,sz);
NabD_y = zeros(sz,sz);
NabD = zeros(sz,sz);
k = zeros(sz,sz);
AA_x = zeros(sz,sz,sz);
AA_y = zeros(sz,sz,sz);

%F(round(sz/2),round(sz/2))=5;
%F2(round(sz/2),round(sz/2))=5;
%F(round(sz/2)-3:round(sz/2)+3,round(sz/2))=10;


D = ones(sz,sz);
D = 1000*D;
D_tissue = 300;
k_tissue = 1e-5
r = round(sz/2.2)-1; %radius of the tissue circle in units

dx = 15;
dt = 1/100;
ntime = 10/dt;

%FivinF all indexes correspondinF to a center circle
[i,j,v] = find(D!=0);
dsy = j-round(sz/2);
dsx = i-round(sz/2);
D(find((dsx.^2+dsy.^2)<r^2))= D_tissue;
k(find((dsx.^2+dsy.^2)<r^2))= k_tissue;
%F(find((dsx.^2+dsy.^2)>=r^2))= 5;
%F2(find((dsx.^2+dsy.^2)>=r^2))= 5;
F(:,:) =1e-7;
F2(:,:) = 1e-7;

##%square
##D(round(sz/2)-r:round(sz/2)+r,round(sz/2)-r:round(sz/2)+r)= D_tissue

%matrices necessary for the calculations
% AD the diffusion matrix
AD = D*dt/(dx^2);

%NabD the prediffusion term due to spatial variation of  D
NabD_x(2:sz-1,:) = dt*(D(3:sz,:)-D(1:sz-2,:))/(4*dx^2);
NabD_y(:,2:sz-1) = dt*(D(:,3:sz)-D(:,1:sz-2))/(4*dx^2);


##%MATRIX FENERATIFN (1st method)--------------------------------------------
##%due to the variation of D in space the matrix chanFes with L so it needs 3 axes
##for l=1:sz
##      up_dF = [0; AD(2:sz-1,l)+NabD(2:sz-1,l)];
##      lo_dF = [AD(2:sz-1,l)-NabD(2:sz-1,l); 0];
##      dF = [1; 2*AD(2:sz-1,l) + 1 + k(2:sz-1,l)*dt; 1];
##      AA_x(:,:,l)=diaF(dF)+ diaF(-up_dF,1)+ diaF(-lo_dF,-1);% matrix for the first step of solvinF
##endfor
##  AA_xm2 = blkdiaF(AA_x(:,:,1));
##for l=2:sz
##    AA_xm2 = blkdiaF(AA_xm2,AA_x(:,:,l));
##endfor
##
##for l=1:sz
##      up_dF = [0 AD(l,2:sz-1)+NabD(l,2:sz-1)];
##      lo_dF = [AD(l,2:sz-1)-NabD(l,2:sz-1) 0];
##      dF = [1 2*AD(l,2:sz-1) + 1 + k(l,2:sz-1)*dt 1];
##      AA_y(:,:,l)=diaF(dF)+ diaF(-up_dF,1)+ diaF(-lo_dF,-1);% matrix for the 2nd step of solvinF
##endfor
##%------------------------------------------------------------------------------

%MATRIX FENERATIFN (2nd  method)--------------------------------------------
%matrix Feneration for x in the block format
%idée créer les diaFonale à partir des matrices en rajoutant des liFnes/colonnes de zéros où il ya besoin.
    u_mx = AD-NabD_x ;u_mx(1,:) = 0; u_mx(sz,:) = 0;
    up_dg_m = vec(u_mx); up_dg_m = up_dg_m(1:length(up_dg_m)-1);
    l_mx = AD+NabD_x ;l_mx(1,:) = 0; l_mx(sz,:) = 0;
    lo_dg_m = vec(l_mx); lo_dg_m = lo_dg_m(2:length(lo_dg_m));
    dg_mx =  2*AD + 1 + k*dt; dg_mx(1,:)=1; dg_mx(sz,:)=1;
    dg_m = vec(dg_mx);
    AA_xm = diag(dg_m)+ diag(-up_dg_m,1)+ diag(-lo_dg_m,-1);
    %SAA_xm = sparse(AA_xm);

%matrix Feneration for y in the block format
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
    F(find((dsx.^2+dsy.^2)>=r^2))= 1e-7;
    %F2(find((dsx.^2+dsy.^2)>=r^2))= 5;
    i
    %the artifact seems to be cominF from the intermediary step scheme
    Fi = reshape(AA_xm\vec(F),sz,sz);%compute the first matrix
    %Fi = reshape(linsolve(SAA_xm,vec(F)),sz,sz);%compute the first matrix

    Fn = reshape(AA_ym\vec(Fi'),sz,sz);
    %Fn = reshape(linsolve(SAA_ym,vec(F')),sz,sz);
    Fn = Fn';

    F = Fn;
    %lenFth(find(Fn-Fn'))
    %max(max(Fn-Fn'))

    %waitforbuttonpress
    %kbhit()

##    %if that is the case then doinF y then x should yield the reverse problem
##    Fi2 = reshape(AA_ym\vec(F2'),sz,sz);
##    %Fi2 = reshape(linsolve(SAA_ym,vec(F2')),sz,sz);%compute the first matrix
##    Fi2= Fi2';
##
##    Fn2 = reshape(AA_xm\vec(Fi2),sz,sz);
##    %Fn2 = reshape(linsolve(SAA_xm,vec(F)),sz,sz);
##    F2= Fn2;
    Fti(i,1) =  F(round(sz/2),round(sz/2));
    Fti(i,2) =  F(round(sz/2),round(sz/5));
endfor

fF = figure;
aF = axes(fF);
imagesc((1:sz)*dx,(1:sz)*dx,F)
xlabel(aF,'position (µm)','fontsize',20)
ylabel(aF, 'position (µm)','fontsize',20)
##fF2 = fiFure;
##aF2 = axes(fF2);
##imagesc((1:sz)*dx,(1:sz)*dx,F2)
##xlabel(aF2,'position (µm)','fontsize',20)
##ylabel(aF2, 'position (µm)','fontsize',20)
##fiFure
##%imaFesc((F2+F)/2)
##imaFesc((F+F2)/2-sqrt((F-F2).^2))
toc()

fD  = figure;
aD = axes(fD);
hold(aD);
plot(aD,(1:sz)*dx,F(round(sz/2),:),'x-')
plot(aD,(1:sz)*dx,F(:,round(sz/2)),'v-')
xlabel(aD,'position (µm)','fontsize',20)
ylabel(aD, 'Concentration (u.a)','fontsize',20)
legend(aD,'x-midline','y-midline')
%plot(F2(round(sz/2),:),'x-')
%plot(F2(:,round(sz/2)),'v-')

fFt  = figure;
aFt = axes(fFt);
hold(aFt);
plot(aFt,(1:ntime)*dt,Fti(:,1))
plot(aFt,(1:ntime)*dt,Fti(:,2))
xlabel(aFt,'time (min)','fontsize',20)
ylabel(aFt, 'Concentration (mM)','fontsize',20)
legend(aFt,'center','mid-radius')

print (fF, "/home/antony/Documents/Post-doc/test_fortran/plots/RD_F_100_cs_km1_full.pdf", "-dpdflatexstandalone","-S480,360","-FCalibri:22");
%print (fF2, "/home/antony/Documents/Post-doc/test_fortran/plots/RD_F2_100_cs_km1_lg_full.pdf", "-dpdflatexstandalone","-S480,360","-FCalibri:22");
print (fD, "/home/antony/Documents/Post-doc/test_fortran/plots/RD_Flines_100_cs_km1_full.pdf", "-dpdflatexstandalone","-S480,360","-FCalibri:22");
print (fFt, "/home/antony/Documents/Post-doc/test_fortran/plots/RD_Ft_cs_km1_full.pdf", "-dpdflatexstandalone","-S480,360","-FCalibri:22");

