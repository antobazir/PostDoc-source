clear all;
close all;

tic()
sz = 41;
G = zeros(sz,sz,sz);
kG = zeros(sz,sz,sz);

DG = ones(sz,sz,sz);
DG = 40000*DG;
DG_tissue = 10000;
kG_tissue = 10;
r = round(sz/2.2)-2; %radius of the tissue circle in units

dx = 15;
dt = 1/1000;
ntime = 20/dt;

%giving all indexes corresponding to a center circle
dsz = vec((1:sz)'*ones(1,sz*sz));
B = reshape(dsz,sz*sz,sz);
dsy = vec(B');
dsx = vec(((1:sz)'*ones(1,sz*sz))');
dsx = dsx-round(sz/2);
dsy = dsy-round(sz/2);
dsz = dsz-round(sz/2);
DG(find((dsx.^2+dsy.^2+dsz.^2)<r^2))= DG_tissue;
kG(find((dsx.^2+dsy.^2+dsz.^2)<r^2))= kG_tissue;

G(:,:) =5;

tic()
for i=1:ntime
    i

    G(find((dsx.^2+dsy.^2+dsz.^2)>=r^2))= 5;

    %explicit  scheme
    %x-step
    G(2:sz-1,:,:) =  G(2:sz-1,:,:) + dt*(DG(3:sz,:)-DG(1:sz-2,:,:))/(4*dx^2).*(G(3:sz,:,:)-G(1:sz-2,:,:)) + DG(2:sz-1,:,:)*dt/dx^2.*(G(3:sz,:) -2*(G(2:sz-1,:,:)) + G(1:sz-2,:)) -kG(2:sz-1,:,:).*(G(2:sz-1,:,:).^4)./(G(2:sz-1,:,:).^4+(0.1)^4)*dt;
    %y-step
    G(:,2:sz-1,:) =  G(:,2:sz-1,:) + dt*(DG(:,3:sz,:)-DG(:,1:sz-2,:))/(4*dx^2).*(G(:,3:sz,:)-G(:,1:sz-2,:))+ DG(:,2:sz-1,:)*dt/dx^2.*(G(:,3:sz,:) -2*(G(:,2:sz-1,:)) + G(:,1:sz-2,:));
    %z-step
    G(:,:,2:sz-1) =  G(:,:,2:sz-1) + dt*(DG(:,:,3:sz)-DG(:,:,1:sz-2))/(4*dx^2).*(G(:,:,3:sz)-G(:,:,1:sz-2))+ DG(:,:,2:sz-1)*dt/dx^2.*(G(:,:,3:sz) -2*(G(:,:,2:sz-1)) + G(:,:,1:sz-2));


    Gt(i,1) =  G(round(sz/2),round(sz/2),round(sz/2));
    Gt(i,2) =  G(round(sz/2),round(sz/2),round(sz/2-r+2));


endfor
toc()

fG = figure;
aG = axes(fG);
imagesc((1:sz)*dx,(1:sz)*dx,G(:,:,round(sz/2))
colorbar
xlabel(aG,'position (µm)','fontsize',20)
ylabel(aG, 'position (µm)','fontsize',20)
title(aG, ['d= ' num2str(r*2*dx) '$\mu$m, D=' num2str(DG_tissue) '$\mu$m$^2$/min, k=' num2str(kG_tissue) 'mM/min, dt =' num2str(dt) 'mn, dx =' num2str(dx) '$\mu$m'])

fGx = figure;
aGx = axes(fGx);
plot((1:sz)*dx,G(round(sz/2),:,round(sz/2)))
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


print (fG, "/home/antony/Documents/Post-doc/test_fortran/plots/RD3D_G_cons1.pdf", "-dpdflatexstandalone","-S480,360","-FCalibri:22");
print (fGx, "/home/antony/Documents/Post-doc/test_fortran/plots/RD3D_Gx_cons1.pdf", "-dpdflatexstandalone","-S480,360","-FCalibri:22");
print (fGt, "/home/antony/Documents/Post-doc/test_fortran/plots/RD3D_Gt_cons1.pdf", "-dpdflatexstandalone","-S480,360","-FCalibri:22");

%name configs and run them with different parameters
%cons1 unknown cons / my parameters large tissue D 10000 km 10 cell diam 7.5 sharp
%cons2 unknown cons / my parameters small tissue D 10000 km 10 cell diam 7.5 sharp
