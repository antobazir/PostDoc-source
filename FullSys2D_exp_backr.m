clear all;
close all;

tic()
sz = 401;
G = zeros(sz,sz);
D = zeros(sz,sz);
GD = zeros(sz,sz);
T = zeros(sz,sz);
O = zeros(sz,sz);
kO = zeros(sz,sz);
kG = zeros(sz,sz);
kT = zeros(sz,sz);


DOx = ones(sz,sz);
DOx = 100000*DOx;
DOx_tissue = 100000;
kO_tissue = 0.5; %0.1 %1 yields too much of a gradient
DG = ones(sz,sz);
DG = 40000*D;
DG_tissue = 10000;
kG_tissue = 5;% does not do the big when I lower kG
kT_tissue = 0.017;
r = round(sz/2.2)-2; %radius of the tissue circle in units

dx = 15;
dt = 1/1000;
ntime = 30/dt;

%giving all indexes corresponding to a center circle
[i,j,v] = find(DOx!=0);
dsy = j-round(sz/2);
dsx = i-round(sz/2);
DOx(find((dsx.^2+dsy.^2)<r^2))= DOx_tissue;
DG(find((dsx.^2+dsy.^2)<r^2))= DG_tissue;
kO(find((dsx.^2+dsy.^2)<r^2))= kO_tissue;
kG(find((dsx.^2+dsy.^2)<r^2))= kG_tissue;
kT(find((dsx.^2+dsy.^2)<r^2))= kT_tissue;

G(:,:) =5;
O(:,:) =0.15;
D(find((dsx.^2+dsy.^2)<r^2))= 0.2; %normally 0.2
T(find((dsx.^2+dsy.^2)<r^2))= 20;
GD(find((dsx.^2+dsy.^2)<r^2))= 0.1;


tic()
for i=1:ntime
    i
    G(G<0) = 0;
    O(O<0) = 0;
    D(D<0) = 0;
    GD(GD<0) = 0;
    T(T<0) = 0;

    G(find((dsx.^2+dsy.^2)>=r^2))= 5;
    O(find((dsx.^2+dsy.^2)>=r^2))= 0.15;
    %D(find((dsx.^2+dsy.^2)>=r^2))= 0.2;
    %T(find((dsx.^2+dsy.^2)>=r^2))= 20;
    %GD(find((dsx.^2+dsy.^2)>=r^2))= 1;

     kG(find((dsx.^2+dsy.^2)<r^2)) = kG_tissue*exp(-1/100*T(find((dsx.^2+dsy.^2)<r^2))./ D(find((dsx.^2+dsy.^2)<r^2)));
     kO(find((dsx.^2+dsy.^2)<r^2)) = kO_tissue- kO_tissue/10.*D(find((dsx.^2+dsy.^2)<r^2)) ;

    %explicit  scheme
    %x-step
    O(2:sz-1,:) =  O(2:sz-1,:)  + DOx(2:sz-1,:)*dt/(dx^2).*(O(3:sz,:) -2*(O(2:sz-1,:)) + O(1:sz-2,:)) -kO(2:sz-1,:).*dt.*O(2:sz-1,:).*GD(2:sz-1,:);
    G(2:sz-1,:) =  G(2:sz-1,:) + dt*(DG(3:sz,:)-DG(1:sz-2,:))/(4*dx^2).*(G(3:sz,:)-G(1:sz-2,:)) + DG(2:sz-1,:)*dt/dx^2.*(G(3:sz,:) -2*(G(2:sz-1,:)) + G(1:sz-2,:)) -kG(2:sz-1,:).*dt.*G(2:sz-1,:).*D(2:sz-1,:);
    %y-step
    O(:,2:sz-1) =  O(:,2:sz-1) + DOx(:,2:sz-1)*dt/dx^2.*(O(:,3:sz) -2*(O(:,2:sz-1)) + O(:,1:sz-2));
    G(:,2:sz-1) =  G(:,2:sz-1) + dt*(DG(:,3:sz)-DG(:,1:sz-2))/(4*dx^2).*(G(:,3:sz)-G(:,1:sz-2))+ DG(:,2:sz-1)*dt/dx^2.*(G(:,3:sz) -2*(G(:,2:sz-1)) + G(:,1:sz-2));

    D(2:sz-1,2:sz-1) =  D(2:sz-1,2:sz-1) -kG(2:sz-1,2:sz-1).*dt.*D(2:sz-1,2:sz-1).*G(2:sz-1,2:sz-1) + kT(2:sz-1,2:sz-1).*dt.*T(2:sz-1,2:sz-1);
    GD(2:sz-1,2:sz-1) =  GD(2:sz-1,2:sz-1) +kG(2:sz-1,2:sz-1).*dt.*D(2:sz-1,2:sz-1).*G(2:sz-1,2:sz-1) - kO(2:sz-1,2:sz-1).*dt.*GD(2:sz-1,2:sz-1).*O(2:sz-1,2:sz-1);
    T(2:sz-1,2:sz-1) =  T(2:sz-1,2:sz-1) +kO(2:sz-1,2:sz-1).*dt.*O(2:sz-1,2:sz-1).*GD(2:sz-1,2:sz-1) - kT(2:sz-1,2:sz-1).*dt.*T(2:sz-1,2:sz-1);


    Ot(i,1) =  O(round(sz/2),round(sz/2));
    Ot(i,2) =  O(round(sz/2),round(sz/2-r+2));
    Gt(i,1) =  G(round(sz/2),round(sz/2));
    Gt(i,2) =  G(round(sz/2),round(sz/2-r+2));
    Dt(i,1) =  D(round(sz/2),round(sz/2));
    Dt(i,2) =  D(round(sz/2),round(sz/2-r+2));
    Tt(i,1) =  T(round(sz/2),round(sz/2));
    Tt(i,2) =  T(round(sz/2),round(sz/2-r+2));
    kGt(i,1) =  kG(round(sz/2),round(sz/2));
    kGt(i,2) =  kG(round(sz/2),round(sz/2-r+2));
    gk(i,1) = kG(round(sz/2),round(sz/2)).*dt.*G(round(sz/2),round(sz/2)).*D(round(sz/2),round(sz/2));
    gk(i,2) = kG(round(sz/2),round(sz/2-r+2)).*dt.*G(round(sz/2),round(sz/2-r+2)).*D(round(sz/2),round(sz/2-r+2));

endfor
toc()

fG = figure;
aG = axes(fG);
imagesc((1:sz)*dx,(1:sz)*dx,G)
colorbar
xlabel(aG,'position (µm)','fontsize',20)
ylabel(aG, 'position (µm)','fontsize',20)

fO = figure;
aO = axes(fO);
imagesc((1:sz)*dx,(1:sz)*dx,O)
colorbar
xlabel(aO,'position (µm)','fontsize',20)
ylabel(aO, 'position (µm)','fontsize',20)

fT = figure;
aT = axes(fT);
imagesc((1:sz)*dx,(1:sz)*dx,T)
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

fDt  = figure;
aDt = axes(fDt);
hold(aDt);
plot(aDt,(1:ntime)*dt,Dt(:,1))
plot(aDt,(1:ntime)*dt,Dt(:,2))
xlabel(aDt,'time (min)','fontsize',20)
ylabel(aDt, 'Concentration (mM)','fontsize',20)
legend(aDt,'center','rim')

fTt  = figure;
aTt = axes(fTt);
hold(aTt);
plot(aTt,(1:ntime)*dt,Tt(:,1))
plot(aTt,(1:ntime)*dt,Tt(:,2))
xlabel(aTt,'time (min)','fontsize',20)
ylabel(aTt, 'Concentration (mM)','fontsize',20)
legend(aTt,'center','rim')

fTDt  = figure;
aTDt = axes(fTDt);
hold(aTDt);
plot(aTDt,(1:ntime)*dt,Tt(:,1)./Dt(:,1))
plot(aTDt,(1:ntime)*dt,Tt(:,2)./Dt(:,2))
xlabel(aTDt,'time (min)','fontsize',20)
ylabel(aTDt, '[T]/[D]','fontsize',20)
legend(aTDt,'center','rim')


fkGt  = figure;
akGt = axes(fkGt);
hold(akGt);
plot(akGt,(1:ntime)*dt,kGt(:,1))
plot(akGt,(1:ntime)*dt,kGt(:,2))
xlabel(akGt,'tkG','fontsize',20)
legend(akGt,'center','rim')

fgkt  = figure;
agkt = axes(fgkt);
hold(agkt);
plot(agkt,(1:ntime)*dt,gk(:,1))
plot(agkt,(1:ntime)*dt,gk(:,2))
xlabel(agkt,'time','fontsize',20)
ylabel(agkt,'gluc cons','fontsize',20)
legend(agkt,'center','rim')

figure(fT)
caxis([min(Tt(:,1)) max(max(T))])

print (fG, "/home/antony/Documents/Post-doc/test_fortran/plots/fullsys2D_G_conf3.pdf", "-dpdflatexstandalone","-S480,360","-FCalibri:22");
print (fO, "/home/antony/Documents/Post-doc/test_fortran/plots/fullsys2D_O_conf3.pdf", "-dpdflatexstandalone","-S480,360","-FCalibri:22");
print (fT, "/home/antony/Documents/Post-doc/test_fortran/plots/fullsys2D_T_conf3.pdf", "-dpdflatexstandalone","-S480,360","-FCalibri:22");
print (fGt, "/home/antony/Documents/Post-doc/test_fortran/plots/fullsys2D_Gt_conf3.pdf", "-dpdflatexstandalone","-S480,360","-FCalibri:22");
print (fOt, "/home/antony/Documents/Post-doc/test_fortran/plots/fullsys2D_Ot_conf3.pdf", "-dpdflatexstandalone","-S480,360","-FCalibri:22");
print (fTt, "/home/antony/Documents/Post-doc/test_fortran/plots/fullsys2D_Tt_conf3.pdf", "-dpdflatexstandalone","-S480,360","-FCalibri:22");

%name configs and run them with different parameters
%conf 1 : kO 0.5 | kG 10 | kT 0.017 | d 500 | G0 5 | O0 0.15 | D0 0.2 | T0 20 | GD0 0.1 | dx 15 | dt 1/1000 |DfOx 100000 |DfGl 10000&40000 | cD 1/10| cT 1/100
%conf 2 : kO 0.5 | kG 10 | kT 0.017 | d 1500 | G0 5 | O0 0.15 | D0 0.2 | T0 20 | GD0 0.1 | dx 15 | dt 1/1000 |DfOx 100000 |DfGl 10000&40000  | cD 1/10| cT 1/100
%conf 3 : kO 0.5 | kG 10 | kT 0.017 | d 5000 | G0 5 | O0 0.15 | D0 0.2 | T0 20 | GD0 0.1 | dx 15 | dt 1/1000 |DfOx 100000 |DfGl 10000&40000  | cD 1/10| cT 1/100
%conf 4 : kO 0.5 | kG 10 | kT 0.017 | d 500 | G0 5 | O0 0.15 | D0 0.2 | T0 20 | GD0 0.1 | dx 15 | dt 1/1000 |DfOx 100000 |DfGl 10000&40000  | cD 1/10| cT 1/100
%conf X : kO 0.5 | kG 10 | kT 0.02 | d 1800 | G0 5 | O0 0.15 | D0 0.2 | T0 20 | GD0 0.1 | dx 15 | dt 1/1000 |DfOx 100000 |DfGl 10000&40000  | cD kO/10| cT 1/100 gets to zero but stabilises above zero
%conf X2 : kO 0.5 | kG 0.1 | kT 0.02 | d 1800 | G0 5 | O0 0.15 | D0 0.2 | T0 20 | GD0 0.1 | dx 15 | dt 1/1000 |DfOx 100000 |DfGl 10000&40000  | cD kO/10| cT 1/100 gets to zero but stabilises above zero
%conf X3 : kO 5 | kG 0.1 | kT 0.03 | d 1800 | G0 5 | O0 0.15 | D0 0.2 | T0 20 | GD0 0.1 | dx 15 | dt 1/1000 |DfOx 100000 |DfGl 10000&40000  | cD kO/10| cT 1/100 gets to zero but stabilises above zero
%conf X4 : kO 0.1 | kG 10 | kT 0.02| d 1800 | G0 5 | O0 0.15 | D0 2 | T0 20 | GD0 0.1 | dx 15 | dt 1/1000 |DfOx 100000 |DfGl 10000&40000  | cD kO/10| cT 1/100 gets to zero but stabilises above zero
%run X4
