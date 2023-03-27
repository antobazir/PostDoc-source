clear all;
close all;

tic()
sz = 51;
G = zeros(sz,sz,sz);
D = zeros(sz,sz,sz);
GD = zeros(sz,sz,sz);
T = zeros(sz,sz,sz);
O = zeros(sz,sz,sz);
kO = zeros(sz,sz,sz);
kG = zeros(sz,sz,sz);
kT = zeros(sz,sz,sz);


DOx = ones(sz,sz,sz);
DOx = 100000*DOx;
DOx_tissue = 100000;
kO_tissue = 1;
DG = ones(sz,sz,sz);
DG = 40000*D;
DG_tissue = 10000;
kG_tissue = 5;
kT_tissue = 1;
r = round(sz/2.2)-2; %radius of the tissue circle in units

dx = 15;
dt = 1/1000;
ntime = 10/dt;

%giving all indexes corresponding to a center circle
[i] = find(DOx!=0);
dsz = vec((1:sz)'*ones(1,sz*sz));
B = reshape(dsz,sz*sz,sz);
dsy = vec(B');
dsx = vec(((1:sz)'*ones(1,sz*sz))');
dsx = dsx-round(sz/2);
dsy = dsy-round(sz/2);
dsz = dsz-round(sz/2);
DOx(find((dsx.^2+dsy.^2+dsz.^2)<r^2))= DOx_tissue;
DG(find((dsx.^2+dsy.^2+dsz.^2)<r^2))= DG_tissue;
kO(find((dsx.^2+dsy.^2+dsz.^2)<r^2))= kO_tissue;
kG(find((dsx.^2+dsy.^2+dsz.^2)<r^2))= kG_tissue;
kT(find((dsx.^2+dsy.^2+dsz.^2)<r^2))= kT_tissue;

figure;
imagesc(DOx(:,:,round(sz/4)))
figure;
imagesc(kO(:,:,round(sz/4)))
waitforbuttonpress

G(:,:) =5;
O(:,:) =0.5;
D(find((dsx.^2+dsy.^2+dsz.^2)<r^2))= 0.2;
T(find((dsx.^2+dsy.^2+dsz.^2)<r^2))= 20;
GD(find((dsx.^2+dsy.^2+dsz.^2)<r^2))= 1;


tic()
for i=1:ntime
    i

    G(find((dsx.^2+dsy.^2+dsz.^2)>=r^2))= 5;
    O(find((dsx.^2+dsy.^2+dsz.^2)>=r^2))= 0.5;
    %D(find((dsx.^2+dsy.^2)>=r^2))= 0.2;
    %T(find((dsx.^2+dsy.^2)>=r^2))= 20;
    %GD(find((dsx.^2+dsy.^2)>=r^2))= 1;

     kG(find((dsx.^2+dsy.^2+dsz.^2)<r^2)) = kG_tissue*exp(-1/10*T(find((dsx.^2+dsy.^2+dsz.^2)<r^2))./ D(find((dsx.^2+dsy.^2+dsz.^2)<r^2)));
     kO(find((dsx.^2+dsy.^2+dsz.^2)<r^2)) = kO_tissue- 0.1.*D(find((dsx.^2+dsy.^2+dsz.^2)<r^2)) ;

    %explicit  scheme
    %x-step
    O(2:sz-1,:,:) =  O(2:sz-1,:,:)  + DOx(2:sz-1,:,:)*dt/(dx^2).*(O(3:sz,:,:) -2*(O(2:sz-1,:,:)) + O(1:sz-2,:,:)) -kO(2:sz-1,:,:).*dt.*O(2:sz-1,:,:).*GD(2:sz-1,:,:);
    G(2:sz-1,:,:) =  G(2:sz-1,:,:) + dt*(DG(3:sz,:,:)-DG(1:sz-2,:,:))/(4*dx^2).*(G(3:sz,:,:)-G(1:sz-2,:,:)) + DG(2:sz-1,:,:)*dt/dx^2.*(G(3:sz,:,:) -2*(G(2:sz-1,:,:)) + G(1:sz-2,:,:)) -kG(2:sz-1,:,:).*dt.*G(2:sz-1,:,:).*D(2:sz-1,:,:);
    %y-step
    O(:,2:sz-1,:) =  O(:,2:sz-1,:) + DOx(:,2:sz-1,:)*dt/dx^2.*(O(:,3:sz,:) -2*(O(:,2:sz-1,:)) + O(:,1:sz-2,:));
    G(:,2:sz-1,:) =  G(:,2:sz-1,:) + dt*(DG(:,3:sz,:)-DG(:,1:sz-2,:))/(4*dx^2).*(G(:,3:sz,:)-G(:,1:sz-2,:))+ DG(:,2:sz-1,:)*dt/dx^2.*(G(:,3:sz,:) -2*(G(:,2:sz-1,:)) + G(:,1:sz-2,:));
    %z-step
    O(:,:,2:sz-1) =  O(:,:,2:sz-1) + DOx(:,:,2:sz-1)*dt/dx^2.*(O(:,:,3:sz) -2*(O(:,:,2:sz-1)) + O(:,:,1:sz-2));
    G(:,:,2:sz-1) =  G(:,:,2:sz-1) + dt*(DG(:,:,3:sz)-DG(:,:,1:sz-2))/(4*dx^2).*(G(:,:,3:sz)-G(:,:,1:sz-2))+ DG(:,:,2:sz-1)*dt/dx^2.*(G(:,:,3:sz) -2*(G(:,:,2:sz-1)) + G(:,:,1:sz-2));



    D(2:sz-1,2:sz-1,2:sz-1) =  D(2:sz-1,2:sz-1,2:sz-1) -kG(2:sz-1,2:sz-1,2:sz-1).*dt.*D(2:sz-1,2:sz-1,2:sz-1).*GD(2:sz-1,2:sz-1,2:sz-1) + kT(2:sz-1,2:sz-1,2:sz-1).*dt.*T(2:sz-1,2:sz-1,2:sz-1);
    GD(2:sz-1,2:sz-1,2:sz-1) =  GD(2:sz-1,2:sz-1,2:sz-1) +kG(2:sz-1,2:sz-1,2:sz-1).*dt.*D(2:sz-1,2:sz-1,2:sz-1).*G(2:sz-1,2:sz-1,2:sz-1) - kO(2:sz-1,2:sz-1,2:sz-1).*dt.*GD(2:sz-1,2:sz-1,2:sz-1).*O(2:sz-1,2:sz-1,2:sz-1);
    T(2:sz-1,2:sz-1,2:sz-1) =  T(2:sz-1,2:sz-1,2:sz-1) +kO(2:sz-1,2:sz-1,2:sz-1).*dt.*O(2:sz-1,2:sz-1,2:sz-1).*GD(2:sz-1,2:sz-1,2:sz-1) - kT(2:sz-1,2:sz-1,2:sz-1).*dt.*T(2:sz-1,2:sz-1,2:sz-1);


    Ot(i,1) =  O(round(sz/2),round(sz/2),round(sz/2));
    Ot(i,2) =  O(round(sz/2),round(sz/2-r+2),round(sz/2));
    Gt(i,1) =  G(round(sz/2),round(sz/2),round(sz/2));
    Gt(i,2) =  G(round(sz/2),round(sz/2-r+2),round(sz/2));
    Tt(i,1) =  T(round(sz/2),round(sz/2),round(sz/2));
    Tt(i,2) =  T(round(sz/2),round(sz/2-r+2),round(sz/2));

endfor
toc()

fG = figure;
aG = axes(fG);
imagesc((1:sz)*dx,(1:sz)*dx,G(:,:,round(sz/2)))
colorbar
xlabel(aG,'position (µm)','fontsize',20)
ylabel(aG, 'position (µm)','fontsize',20)

fO = figure;
aO = axes(fO);
imagesc((1:sz)*dx,(1:sz)*dx,O(:,:,round(sz/2)))
colorbar
xlabel(aO,'position (µm)','fontsize',20)
ylabel(aO, 'position (µm)','fontsize',20)

fT = figure;
aT = axes(fT);
imagesc((1:sz)*dx,(1:sz)*dx,T(:,:,round(sz/2)))
colorbar
xlabel(aO,'position (µm)','fontsize',20)
ylabel(aO, 'position (µm)','fontsize',20)

fGt  = figure;
aGt = axes(fGt);
hold(aGt);
plot(aGt,(1:ntime)*dt,Gt(:,1))
plot(aGt,(1:ntime)*dt,Gt(:,2))
xlabel(aGt,'time (min)','fontsize',20)
ylabel(aGt, 'Concentration (mM)','fontsize',20)
legend(aGt,'center','rim')

fOt  = figure;
aOt = axes(fOt);
hold(aOt);
plot(aOt,(1:ntime)*dt,Ot(:,1))
plot(aOt,(1:ntime)*dt,Ot(:,2))
xlabel(aOt,'time (min)','fontsize',20)
ylabel(aOt, 'Concentration (mM)','fontsize',20)
legend(aOt,'center','rim')

fTt  = figure;
aTt = axes(fTt);
hold(aTt);
plot(aTt,(1:ntime)*dt,Tt(:,1))
plot(aTt,(1:ntime)*dt,Tt(:,2))
xlabel(aTt,'time (min)','fontsize',20)
ylabel(aTt, 'Concentration (mM)','fontsize',20)
legend(aTt,'center','rim')

figure(fT)
caxis([min(Tt(:,1)) max(max(max(T)))])

##print (fG, "/home/antony/Documents/Post-doc/test_fortran/plots/RD_G630_exp_cs_km1.pdf", "-dpdflatexstandalone","-S480,360","-FCalibri:22");
##print (fO, "/home/antony/Documents/Post-doc/test_fortran/plots/RD_O630_exp_cs_km1.pdf", "-dpdflatexstandalone","-S480,360","-FCalibri:22");
##print (fT, "/home/antony/Documents/Post-doc/test_fortran/plots/RD_T630_exp_cs_km1.pdf", "-dpdflatexstandalone","-S480,360","-FCalibri:22");
##print (fGt, "/home/antony/Documents/Post-doc/test_fortran/plots/RD_t630_cs_km1_G.pdf", "-dpdflatexstandalone","-S480,360","-FCalibri:22");
##print (fOt, "/home/antony/Documents/Post-doc/test_fortran/plots/RD_t630_cs_km1_O.pdf", "-dpdflatexstandalone","-S480,360","-FCalibri:22");
##print (fTt, "/home/antony/Documents/Post-doc/test_fortran/plots/RD_t630_cs_km1_T.pdf", "-dpdflatexstandalone","-S480,360","-FCalibri:22");

%name configs and run them with different parameters
