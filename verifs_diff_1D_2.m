%this second code has two main difference
%it models a spheroids in the middle of medium with appropriate consumption
close all
n_space = 330
n_time = 10000000
Ox_m = zeros(1,n_space);
Gl_m = zeros(1,n_space);
F_m = zeros(1,n_space);
kO = zeros(1,n_space);
kG = zeros(1,n_space);
kf = zeros(1,n_space);

dx = 3 %in µm
dt = 1/27000 %in min

sph_size = 300; %spheroid size in µm
lim_inf= floor(n_space/2)-floor(0.5*sph_size/dx);
lim_sup = floor(n_space/2)+floor(0.5*sph_size/dx);

DOx = 100000; %diffusion of oxygen
kO(lim_inf:lim_sup) = 1;
kO = 3*kO; %consumption rate in mM/min based on 5000 amol/min & cell volume of 2000 µm^3

DG = 10000 %diffusion of glucose
kG(lim_inf:lim_sup) = 1;
kG = 15*kG; %consumption rate in mM/min based on 500 amol/min & cell volume of 2000 µm^3

Df = 1000 %diffusion of growth factor
kf(lim_inf:lim_sup) = 1;
kf = 5e-3*kf; %consumption rate in mM/min based on value given by Filion


%boundary conditions
Ox_m(1:n_space) = 0.6; %concentration in mM


Gl_m(1:n_space) = 5; %concentration in mM

%50 kDa = 8.3e-20 g -> 49800 g/mol -> 2e-13 mol/mL -> 2e-10 mol/L -> 2e-7 mM/L
F_m(1:n_space) = 2e-7; %concentration in mM


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


%figure facteur
fF = figure;
aF = axes(fF);
hold(aF);
xlabel(aF,'position (µm)')
ylabel(aF, 'concentration (mM)')



%figure bilan
fB = figure;
aB = axes(fB);
hold(aB);
xlabel(aB,'position (µm)')
ylabel(aB, 'normalised concentration')



tic();
for j=2:n_time-1
    Ox_m(2:n_space-1) =  Ox_m(2:n_space-1) + DOx*dt/dx^2.*(Ox_m(3:n_space) -2*(Ox_m(2:n_space-1)) + Ox_m(1:n_space-2)) -kO(2:n_space-1).*dt.*Ox_m(2:n_space-1);
    Gl_m(2:n_space-1) =  Gl_m(2:n_space-1) + DG*dt/dx^2.*(Gl_m(3:n_space) -2*(Gl_m(2:n_space-1)) + Gl_m(1:n_space-2)) -kG(2:n_space-1).*dt.*Gl_m(2:n_space-1);
    F_m(2:n_space-1) =  F_m(2:n_space-1) + Df*dt/dx^2.*(F_m(3:n_space) -2*(F_m(2:n_space-1)) + F_m(1:n_space-2)) -kf(2:n_space-1).*dt.*F_m(2:n_space-1);
    if(j==1/(1000*dt)||j==1/(100*dt)||j==1/(10*dt)||j==1/dt||j==2/(dt)||j==10/(dt))%||j==5/(dt)||j==10/(dt))
      plot(aO,(1:n_space)*dx,Ox_m)
      plot(aG,(1:n_space)*dx,Gl_m)
      plot(aF,(1:n_space)*dx,F_m)
    endif

    if(j==2/dt)
      plot(aB,(1:n_space)*dx,Ox_m/max(Ox_m),'.','color','blue')
      plot(aB,(1:n_space)*dx,Gl_m/max(Gl_m),'-','color','blue')
      plot(aB,(1:n_space)*dx,F_m/max(F_m),'--','color','blue')
    endif

endfor

plot(aO,(1:n_space)*dx,Ox_m,'x')
legend(aO,'0.001 mn','0.01 mn','0.1 mn','1 mn','2 mn','10 mn','6hr')
plot(aG,(1:n_space)*dx,Gl_m,'x')
legend(aG,'0.001 mn','0.01 mn','0.1 mn','1 mn','2 mn','10 mn','6hr')
plot(aF,(1:n_space)*dx,F_m,'x')
legend(aF,'0.001 mn','0.01 mn','0.1 mn','1 mn','2 mn','10 mn','6hr')

plot(aB,(1:n_space)*dx,Ox_m/max(Ox_m),'.','color','red')
plot(aB,(1:n_space)*dx,Gl_m/max(Gl_m),'-','color','red')
plot(aB,(1:n_space)*dx,F_m/max(F_m),'--','color','red')
legend(aB,'[O] 2mn','[G] 2mn','[F] 2 mn','[O] 6hr','[G] 6hr','[F] 6hr')
toc();
