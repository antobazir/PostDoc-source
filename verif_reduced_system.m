close all;
n_space = 330
n_time = 1000000

%Concentraion fields
O= zeros(1,n_space);
G = zeros(1,n_space);
D = zeros(1,n_space);
GD = zeros(1,n_space);
T = zeros(1,n_space);

kO = zeros(1,n_space);
kG = zeros(1,n_space);
kD = zeros(1,n_space);
kGD = zeros(1,n_space);
kT= zeros(1,n_space);

dx = 3 %in µm
dt = 1/27000 %in min

sph_size = 300; %spheroid size in µm
lim_inf= floor(n_space/2)-floor(0.5*sph_size/dx);
lim_sup = floor(n_space/2)+floor(0.5*sph_size/dx);

DOx = 100000; %diffusion of oxygen
DG = 10000; %diffusion of glucose

kO(lim_inf:lim_sup) = 1;
kO = 2.5*kO;
kG(lim_inf:lim_sup) = 1;
kG = 10*kG;
kT(lim_inf:lim_sup) = 1;
kT = 5e-2*kf;

O(1:n_space) = 0.6; %concentration in mM
G(1:n_space) = 5; %concentration in mM
D(1:n_space) = 0.1; %concentration in mM
T(1:n_space) = 0.1; %concentration in mM
GD(1:n_space) = 0.1; %concentration in mM

%figure oxygène
fO = figure;
aO = axes(fO);
hold(aO);
xlabel(aO,'position (µm)')
ylabel(aO, 'concentration (mM)')

%figure glucose
fG = figure;
aG = axes(fG);
hold(aG);
xlabel(aG,'position (µm)')
ylabel(aG, 'concentration (mM)')

%figure ATP
fT = figure;
aT = axes(fT);
hold(aT);
xlabel(aT,'position (µm)')
ylabel(aT, 'concentration (mM)')

tic();
for j=2:n_time-1
    O(2:n_space-1) =  O(2:n_space-1) + DOx*dt/dx^2.*(O(3:n_space) -2*(O(2:n_space-1)) + O(1:n_space-2)) -kO(2:n_space-1).*dt.*O(2:n_space-1).*GD(2:n_space-1);
    G(2:n_space-1) =  G(2:n_space-1) + DG*dt/dx^2.*(G(3:n_space) -2*(G(2:n_space-1)) + G(1:n_space-2)) -kG(2:n_space-1).*dt.*G(2:n_space-1).*D(2:n_space-1);
    D(2:n_space-1) =  D(2:n_space-1) -kG(2:n_space-1).*dt.*D(2:n_space-1).*GD(2:n_space-1) + kT(2:n_space-1).*dt.*T(2:n_space-1);
    GD(2:n_space-1) =  GD(2:n_space-1) +kG(2:n_space-1).*dt.*D(2:n_space-1).*G(2:n_space-1) - kO(2:n_space-1).*dt.*GD(2:n_space-1).*O(2:n_space-1);
    T(2:n_space-1) =  T(2:n_space-1) +kO(2:n_space-1).*dt.*O(2:n_space-1).*GD(2:n_space-1) - kT(2:n_space-1).*dt.*T(2:n_space-1);
    if(j==1/(1000*dt)||j==1/(100*dt)||j==1/(10*dt)||j==1/dt||j==2/(dt)||j==10/(dt))%||j==5/(dt)||j==10/(dt))
      plot(aO,(1:n_space)*dx,O)
      plot(aG,(1:n_space)*dx,G)
      plot(aT,(1:n_space)*dx,T)
    endif

##    if(j==2/dt)
##      plot(aB,(1:n_space)*dx,Ox_m/max(Ox_m),'.','color','blue')
##      plot(aB,(1:n_space)*dx,Gl_m/max(Gl_m),'-','color','blue')
##      plot(aB,(1:n_space)*dx,F_m/max(F_m),'--','color','blue')
##    endif

endfor

toc();
