%in this script we try to adress the reduced system by solving the 1st two equations
% in stationary regime
close all;
n_space = 330;
n_time = 200;

%Concentraion fields
O = zeros(1,n_space);
G = zeros(1,n_space);
D = zeros(1,n_space);
GD = zeros(1,n_space);
T = zeros(1,n_space);
DOx = zeros(1,n_space);
DG = zeros(1,n_space);
i_stat = 50000;

kO = zeros(1,n_space);
kG = zeros(1,n_space);
kD = zeros(1,n_space);
kGD = zeros(1,n_space);
kT= zeros(1,n_space);

dx = 3; %in µm
dt = 5; %in min lrelaxation time for the glucose equation


sph_size = 200; %spheroid size in µm
lim_inf= floor(n_space/2)-floor(0.5*sph_size/dx);
lim_sup = floor(n_space/2)+floor(0.5*sph_size/dx);


DOx = 120000; %diffusion of oxygen (ne dépend pas de l'espace car la membrane est perméable
DG(1:n_space) = 40000; %diffusion of glucose

kO(lim_inf:lim_sup) = 1;
kO = 0.5*kO;
kG(lim_inf:lim_sup) = 1;
kG = 5e-2*kG;
kT(lim_inf:lim_sup) = 1;
kT = 0.03e-2*kT;
DG(lim_inf:lim_sup) = 10000;

O(1:n_space) = 0.6; %concentration in mM
G(1:n_space) = 5; %concentration in mM
D(1:n_space) = 0.2; %concentration in mM
T(1:n_space) = 20; %concentration in mM
GD(1:n_space) = 0.6; %concentration in mM

%figure oxygène
fO = figure;
aO = axes(fO);
hold(aO);
xlabel(aO,'position (µm)','fontsize',20)
ylabel(aO, 'concentration (mM)','fontsize',20)

%figure glucose
fG = figure;
aG = axes(fG);
hold(aG);
xlabel(aG,'position (µm)','fontsize',20)
ylabel(aG, 'concentration (mM)','fontsize',20)

%figure ATP
fT = figure;
aT = axes(fT);
hold(aT);
xlabel(aT,'position (µm)','fontsize',20)
ylabel(aT, 'concentration (mM)','fontsize',20)

%figure ATP/ADP
fTD = figure;
aTD = axes(fTD);
hold(aTD);
xlabel(aTD,'position (µm)','fontsize',20)
ylabel(aTD, 'ratio T/D','fontsize',20)

%figure kO
fkO = figure;
akO = axes(fkO);
hold(akO);
xlabel(akO,'position (µm)','fontsize',20)
ylabel(akO, 'kO','fontsize',20)

%figure kG
fkG = figure;
akG = axes(fkG);
hold(akG);
xlabel(akG,'position (µm)','fontsize',20)
ylabel(akG, 'kG','fontsize',20)

%figure G(t)
fGt = figure;
aGt = axes(fGt);
hold(aGt);
xlabel(aGt,'temps(step)','fontsize',20)
ylabel(aGt, 'variation (mM)','fontsize',20)


tic();
for j=2:n_time-1
  %diffusion de l'oxygène et du glucose
  for i=1:i_stat
    G(2:n_space-1) =(dx^2./(2*DG(2:n_space-1)+kG(2:n_space-1).*D(2:n_space-1)*dx^2)).*((DG(3:n_space)-DG(1:n_space-2))/(2*dx)).*((G(3:n_space)-G(1:n_space-2))/(2*dx)) + (DG(2:n_space-1).*(G(3:n_space)+G(1:n_space-2))/(dx^2)).*(dx^2./(2*DG(2:n_space-1)+kG(2:n_space-1).*D(2:n_space-1)*dx^2));
    O(2:n_space-1) = (DOx*(O(3:n_space)+O(1:n_space-2))/(dx^2)).*(dx^2./(2*DOx+kO(2:n_space-1).*GD(2:n_space-1)*dx^2));
  endfor
  %plot(aO,O)
  %plot(aG,G)
  kG(lim_inf:lim_sup) = 5e-2.*exp(-1/100*T(lim_inf:lim_sup)./ D(lim_inf:lim_sup));
  kO(lim_inf:lim_sup) = 0.5- 0.25*D(lim_inf:lim_sup) ;
  j
  %avec la back régulation ça va pas du tout...
  %in its original form the behavior is illogical with constants but even with a changed sign there is a problem G and O reincrease at longer times
    D(2:n_space-1) =  D(2:n_space-1) -kG(2:n_space-1).*dt.*D(2:n_space-1).*GD(2:n_space-1) + kT(2:n_space-1).*dt.*T(2:n_space-1);
    GD(2:n_space-1) =  GD(2:n_space-1) +kG(2:n_space-1).*dt.*D(2:n_space-1).*G(2:n_space-1) - kO(2:n_space-1).*dt.*GD(2:n_space-1).*O(2:n_space-1);
    %T(2:n_space-1) =  T(2:n_space-1) -kO(2:n_space-1).*dt.*O(2:n_space-1).*GD(2:n_space-1) - kT(2:n_space-1).*dt.*T(2:n_space-1);
    % peut être changer un 2e signe dans le  ssytème
    T(2:n_space-1) =  T(2:n_space-1) +kO(2:n_space-1).*dt.*O(2:n_space-1).*GD(2:n_space-1) - kT(2:n_space-1).*dt.*T(2:n_space-1);
    if(mod(j,10)==0)
      plot(aGt,j,G(n_space/2),'x')
      G(n_space/2)

      plot(akO,(1:n_space)*dx,kO)
      plot(akG,(1:n_space)*dx,kG)
      plot(aO,(1:n_space)*dx,O)
      plot(aG,(1:n_space)*dx,G)
      plot(aT,(1:n_space)*dx,T)
      plot(aTD,(1:n_space)*dx,T./D)

    endif


endfor
toc();

      plot(aO,(1:n_space)*dx,O,'x-')
      plot(aG,(1:n_space)*dx,G,'x-')
      plot(aT,(1:n_space)*dx,T,'x-')
      plot(aTD,(1:n_space)*dx,T./D,'x-')

set(aO,'fontsize',15)
set(aG,'fontsize',15)
set(aT,'fontsize',15)
set(aTD,'fontsize',15)

