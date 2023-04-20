clear all;
close all;

tic()
sz = 61;
G = zeros(sz,sz);
kG = zeros(sz,sz);

DG = ones(sz,sz);
DG = 40000*DG;
DG_tissue = 10000;
kG_tissue = 10;
r = round(sz/2.2)-2; %radius of the tissue circle in units

dx = 15;
dt = 1/1000;
ntime = 20/dt;

%giving all indexes corresponding to a center circle
[i,j,v] = find(DG!=0);
dsy = j-round(sz/2);
dsx = i-round(sz/2);
DG(find((dsx.^2+dsy.^2)<r^2))= DG_tissue;
kG(find((dsx.^2+dsy.^2)<r^2))= kG_tissue;

G(:,:) =5;



tic()
for i=1:ntime
    i

    G(find((dsx.^2+dsy.^2)>=r^2))= 5;

    %explicit  scheme
    %x-step
    G(2:sz-1,:) =  G(2:sz-1,:) + dt*(DG(3:sz,:)-DG(1:sz-2,:))/(4*dx^2).*(G(3:sz,:)-G(1:sz-2,:)) + DG(2:sz-1,:)*dt/dx^2.*(G(3:sz,:) -2*(G(2:sz-1,:)) + G(1:sz-2,:)) -kG(2:sz-1,:).*(G(2:sz-1,:).^4)./(G(2:sz-1,:).^4+(0.1)^4)*dt;
    %y-step
    G(:,2:sz-1) =  G(:,2:sz-1) + dt*(DG(:,3:sz)-DG(:,1:sz-2))/(4*dx^2).*(G(:,3:sz)-G(:,1:sz-2))+ DG(:,2:sz-1)*dt/dx^2.*(G(:,3:sz) -2*(G(:,2:sz-1)) + G(:,1:sz-2));

    Gt(i,1) =  G(round(sz/2),round(sz/2));
    Gt(i,2) =  G(round(sz/2),round(sz/2-r+2));


endfor
toc()

fG = figure;
aG = axes(fG);
imagesc((1:sz)*dx,(1:sz)*dx,G)
colorbar
xlabel(aG,'position (µm)','fontsize',20)
ylabel(aG, 'position (µm)','fontsize',20)
title(aG, ['d= ' num2str(r*2*dx) '$\mu$m, D=' num2str(DG_tissue) '$\mu$m$^2$/min, k=' num2str(kG_tissue) 'mM/min, dt =' num2str(dt) 'mn, dx =' num2str(dx) '$\mu$m'])

fGx = figure;
aGx = axes(fGx);
plot((1:sz)*dx,G(round(sz/2),:))
xlabel(aGx,'position (µm)','fontsize',20)
ylabel(aGx, 'Concentration (mM)','fontsize',20)
title(aGx, ['d= ' num2str(r*2*dx) '$\mu$m, D=' num2str(DG_tissue) '$\mu$m$^2$/min, k=' num2str(kG_tissue) 'mM/min, dt =' num2str(dt) 'mn, dx =' num2str(dx) '$\mu$m'])

fGt  = figure;
aGt = axes(fGt);
hold(aGt);
plot(aGt,(1:ntime)*dt,Gt(:,1))
plot(aGt,(1:ntime)*dt,Gt(:,2))
xlabel(aGt,'time (min)','fontsize',20)
ylabel(aGt, 'Concentration (mM)','fontsize',20)
legend(aGt,'center','rim')
title(aGt, ['d= ' num2str(r*2*dx) '$\mu$m, D=' num2str(DG_tissue) '$\mu$m$^2$/min, k=' num2str(kG_tissue) 'mM/min, dt =' num2str(dt) 'mn, dx =' num2str(dx) '$\mu$m'])


print (fG, "/home/antony/Documents/Post-doc/test_fortran/plots/RD_G_cons13.pdf", "-dpdflatexstandalone","-S480,360","-FCalibri:22");
print (fGx, "/home/antony/Documents/Post-doc/test_fortran/plots/RD_Gx_cons13.pdf", "-dpdflatexstandalone","-S480,360","-FCalibri:22");
print (fGt, "/home/antony/Documents/Post-doc/test_fortran/plots/RD_Gt_cons13.pdf", "-dpdflatexstandalone","-S480,360","-FCalibri:22");

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
%model 3----------------------------------------------
%cons9 unknown cons / my parameters large tissue D 10000 km 10 cell diam 7.5 smoot
%cons10 unknown cons / my parameters small tissue D 10000 km 10 cell diam 7.5 smoot
%cons11 unknown cons / my parameters large tissue D 10000 km 10 cell diam 7.5 sharp
%cons12 unknown cons / my parameters small tissue D 10000 km 10 cell diam 7.5 sharp
