
close all
n_space = 330
n_time = 10000000
Ox_m = zeros(1,n_space);
Gl_m = zeros(1,n_space);
F_m = zeros(1,n_space);

dx = 3 %in µm
dt = 1/27000 %in min

DOx = 100000 %diffusion of oxygen
kO = 3 %consumption rate in mM/min based on 6000 amol/min & cell volume of 2000 µm^3
DG = 10000 %diffusion of glucose
kG = 10 %consumption rate in mM/min based on 30000 amol/min & cell volume of 2000 µm^3
Df = 1000 %diffusion of growth factor
kf = 5e-3 %consumption rate in mM/min based on value given by Filion


%boundary conditions
Ox_m(1) = 0.6; %concentration in mM
Ox_m(n_space) = Ox_m(1);

Gl_m(1) = 5; %concentration in mM
Gl_m(n_space) = Gl_m(1);

%50 kDa = 8.3e-20 g -> 49800 g/mol -> 2e-13 mol/mL -> 2e-10 mol/L -> 2e-7 mM/L
F_m(1) = 2e-7; %concentration in mM
F_m(n_space) = F_m(1);

%figure oxygène
fO = figure;
aO = axes(fO);
hold(aO);
xlabel(aO,'position (µm)''fontsize',25)
ylabel(aO, 'concentration (mM)''fontsize',25)

%figure glucose
fG = figure;
aG = axes(fG);
hold(aG);
xlabel(aG,'position (µm)''fontsize',25)
ylabel(aG, 'concentration (mM)''fontsize',25)


%figure facteur
fF = figure;
aF = axes(fF);
hold(aF);
xlabel(aF,'position (µm)''fontsize',25)
ylabel(aF, 'concentration (mM)''fontsize',25)



%figure bilan
fB = figure;
aB = axes(fB);
hold(aB);
xlabel(aB,'position (µm)''fontsize',25)
ylabel(aB, 'concentration (mM)''fontsize',25)



tic();
for j=2:n_time-1
    Ox_m(2:n_space-1) =  Ox_m(2:n_space-1) + DOx*dt/dx^2.*(Ox_m(3:n_space) -2*(Ox_m(2:n_space-1)) + Ox_m(1:n_space-2)) -kO*dt*Ox_m(2:n_space-1);
    Gl_m(2:n_space-1) =  Gl_m(2:n_space-1) + DG*dt/dx^2.*(Gl_m(3:n_space) -2*(Gl_m(2:n_space-1)) + Gl_m(1:n_space-2)) -kG*dt*Gl_m(2:n_space-1);
    F_m(2:n_space-1) =  F_m(2:n_space-1) + Df*dt/dx^2.*(F_m(3:n_space) -2*(F_m(2:n_space-1)) + F_m(1:n_space-2)) -kf*dt*F_m(2:n_space-1);
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
plot(aG,(1:n_space)*dx,Gl_m,'x')
plot(aF,(1:n_space)*dx,F_m,'x')

plot(aB,(1:n_space)*dx,Ox_m/max(Ox_m),'.','color','red')
plot(aB,(1:n_space)*dx,Gl_m/max(Gl_m),'-','color','red')
plot(aB,(1:n_space)*dx,F_m/max(F_m),'--','color','red')
legend(aB,'[O] 2mn','[G] 2mn','[F] 2 mn','[O] 6hr','[G] 6hr','[F] 6hr')
set(aB,'fontsize',15)
toc();
