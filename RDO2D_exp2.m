clear all;
close all;

tic()
sz = 46;
O = zeros(sz,sz);
kO = zeros(sz,sz);

DOx = ones(sz,sz);
DOx = 100000*DOx;
DO_tissue = 100000;
kO_tissue = 50;
r = round(sz/2.2)-2; %radius of the tissue circle in units

dx = 15;
dt = 1/1000;
ntime = 30/dt;

%giving all indexes corresponding to a center circle
[i,j,v] = find(DOx!=0);
dsy = j-round(sz/2);
dsx = i-round(sz/2);
DOx(find((dsx.^2+dsy.^2)<r^2))= DO_tissue;
kO(find((dsx.^2+dsy.^2)<r^2))= kO_tissue;

O(:,:) =0.15;



tic()
for i=1:ntime
    i

    O(find((dsx.^2+dsy.^2)>=r^2))= 0.15;

    %explicit  scheme
    %x-step
    O(2:sz-1,:) =  O(2:sz-1,:) + dt*(DOx(3:sz,:)-DOx(1:sz-2,:))/(4*dx^2).*(O(3:sz,:)-O(1:sz-2,:)) + DOx(2:sz-1,:)*dt/dx^2.*(O(3:sz,:) -2*(O(2:sz-1,:)) + O(1:sz-2,:)) -kO(2:sz-1,:).*O(2:sz-1,:)*dt;
    %y-step
    O(:,2:sz-1) =  O(:,2:sz-1) + dt*(DOx(:,3:sz)-DOx(:,1:sz-2))/(4*dx^2).*(O(:,3:sz)-O(:,1:sz-2))+ DOx(:,2:sz-1)*dt/dx^2.*(O(:,3:sz) -2*(O(:,2:sz-1)) + O(:,1:sz-2));

    Ot(i,1) =  O(round(sz/2),round(sz/2));
    Ot(i,2) =  O(round(sz/2),round(sz/2-r+2));


endfor
toc()

fO = figure;
aO = axes(fO);
imagesc((1:sz)*dx,(1:sz)*dx,O)
colorbar
xlabel(aO,'position (µm)','fontsize',20)
ylabel(aO, 'position (µm)','fontsize',20)
%title(aO, ['d= ' num2str(r*2*dx) '$\mu$m, D=' num2str(DO_tissue) '$\mu$m$^2$/min, k=' num2str(kO_tissue) 'mM/min, dt =' num2str(dt) 'mn, dx =' num2str(dx) '$\mu$m'])

fOx = figure;
aOx = axes(fOx);
plot((1:sz)*dx,O(round(sz/2),:))
xlabel(aOx,'position (µm)','fontsize',20)
ylabel(aOx, 'Concentration (mM)','fontsize',20)
%title(aOx, ['d= ' num2str(r*2*dx) '$\mu$m, D=' num2str(DO_tissue) '$\mu$m$^2$/min, k=' num2str(kO_tissue) 'mM/min, dt =' num2str(dt) 'mn, dx =' num2str(dx) '$\mu$m'])

fOt  = figure;
aOt = axes(fOt);
hold(aOt);
plot(aOt,(1:ntime)*dt,Ot(:,1))
plot(aOt,(1:ntime)*dt,Ot(:,2))
xlabel(aOt,'time (min)','fontsize',20)
ylabel(aOt, 'Concentration (mM)','fontsize',20)
legend(aOt,'center','rim')
%title(aOt, ['d= ' num2str(r*2*dx) '$\mu$m, D=' num2str(DO_tissue) '$\mu$m$^2$/min, k=' num2str(kO_tissue) 'mM/min, dt =' num2str(dt) 'mn, dx =' num2str(dx) '$\mu$m'])


print (fO, "/home/antony/Documents/Post-doc/test_fortran/plots/RD_O_cons_sph.pdf", "-dpdflatexstandalone","-S480,360","-FCalibri:22");
print (fOx, "/home/antony/Documents/Post-doc/test_fortran/plots/RD_Ox_cons_sph.pdf", "-dpdflatexstandalone","-S480,360","-FCalibri:22");
print (fOt, "/home/antony/Documents/Post-doc/test_fortran/plots/RD_Ot_cons_sph.pdf", "-dpdflatexstandalone","-S480,360","-FCalibri:22");

%name configs and run them with different parameters
%cons1 Schaller cons / my parameters  small tissue D 6000 k 20 cell diam 2.5
%cons2 Schaller cons / my parameters large tissue D 6000 k 20 cell diam 2.5
%cons3 Schaller cons / Schaller parameters small tissue D 6000 k 10 cell diam 3
%cons4 Schaller/Mao cons / Mao parameters small tissue D 1200 k 3.5 cell diam 6.6
%cons5 unknown cons / my parameters small tissue D 10000 k 20 cell diam 7.5
%cons6 unknown cons / my parameters large tissue D 10000 k 10 cell diam 7.5
%model 2----------------------------------------------
%cons7 unknown cons / my parameters large tissue D 10000 kt 4 cell diam 7.5
%cons8 unknown cons / my parameters small tissue D 10000 kt 4 cell diam 7.5
