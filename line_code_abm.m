% little code to try reduce 3D to 1D
clear all;
close all


%diffusion initialisation
sz = 1000;
dx = 15;
dt = 1/900 %in min
Grid = zeros(1,sz);
Ox = zeros(1,sz);
Gl = zeros(1,sz);
F = zeros(1,sz);
kO = zeros(1,sz);
kG = zeros(1,sz);
kf = zeros(1,sz);
DOx = zeros(1,sz);
DG = zeros(1,sz);
Df = zeros(1,sz);

ext_cOx = 0.6;
ext_cGl = 5;
ext_cF = 2e-7;

%boundary conditions
Ox(1:sz) = ext_cOx; %concentration in mM
Gl(1:sz) = ext_cGl; %concentration in mM
%50 kDa = 8.3e-20 g -> 49800 g/mol -> 2e-13 mol/mL -> 2e-10 mol/L -> 2e-7 mM/L
F(1:sz) = ext_cF; %concentration in mM


DOx(1:sz) = 100000; %diffusion of oxygen
kO_tissue = 1e-4; %consumption rate in mM/min based on 5000 amol/min & cell volume of 2000 µm^3

DG(1:sz) = 40000; %diffusion of glucose medium
DG_tissue = 10000; %diffusion of glucose medium
kG_tissue = 1e-4; %consumption rate in mM/min based on 500 amol/min & cell volume of 2000 µm^3

Df(1:sz) = 1000; %diffusion of growth factor
Df_tissue = 300; %diffusion of growth factor
kf_tissue = 1e-5; %consumption rate in mM/min based on value given by Filion

Ncell = 1;
Ndead = 0;
Nth_G = 0.1;
n_time_diff = 1440*900*16+2000; %1440 min cell/cycle dt is 1/900 mn and 3 is the number of cycles

%state : 1 = proliferative
% 2 =  quiescent
% 3 = necrotic
%moore neighboorhood

%initialisation
%Grid(sz/2)=1;
%DG(sz/2) = DG_tissue;
%kG(sz/2) = kG_tissue;
%kO(sz/2) = kO_tissue;

%plot preparation-------------------------------------------------
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

%figure growth factor
fF = figure;
aF = axes(fF);
hold(aF);
xlabel(aF,'position (µm)','fontsize',20)
ylabel(aF, 'concentration (mM)','fontsize',20)

%figure glucose
fGt = figure;
aGt = axes(fGt);
hold(aGt);
xlabel(aGt,'time (hours)','fontsize',20)
ylabel(aGt, 'concentration (mM)','fontsize',20)

v_dead = [];

tic();
for t = 1:n_time_diff
  if(mod(t,1440*900)==0)
      %Ncell = 2*(Ncell-Ndead);
      Ncell = Ncell + Ncell - Ndead
  endif
  Ncell;
  %mise à jour de la ligne de tissu
  l_tiss = floor(2*(3/4/pi)^(1/3)*(Ncell).^(1/3)); % calcul la largeur de la ligne de tissu en fonction du temps écoulé
  DG(floor((sz-l_tiss)/2):floor((sz-l_tiss)/2)+l_tiss-1) = DG_tissue;
  Df(floor((sz-l_tiss)/2):floor((sz-l_tiss)/2)+l_tiss-1) = Df_tissue;
  kG(floor((sz-l_tiss)/2):floor((sz-l_tiss)/2)+l_tiss-1) = kG_tissue;
  kO(floor((sz-l_tiss)/2):floor((sz-l_tiss)/2)+l_tiss-1) = kO_tissue;
  kf(floor((sz-l_tiss)/2):floor((sz-l_tiss)/2)+l_tiss-1) = kf_tissue;

  v_dead = unique([v_dead find(Gl<Nth_G)]);

  %assure que malgré la reprise de diffusion, une cellule morte reste morte
  kG(v_dead) = 0;
  kO(v_dead) = 0;
  kf(v_dead) = 0;

  kG(find(Gl<Nth_G)) = 0;
  kO(find(Gl<Nth_G)) = 0;
  kf(find(Gl<Nth_G)) = 0;

  if(mod(t,2880*900)==0)
    Gl(and(kG==0,DG!=DG_tissue)) = ext_cGl;
    Ox(and(kG==0,DG!=DG_tissue)) = ext_cOx;
    F(and(kG==0,DG!=DG_tissue)) = ext_cF;
  endif

     %diffusion
    %Ox(2:sz-1) =  Ox(2:sz-1) + DOx(2:sz-1).*dt/dx^2.*(Ox(3:sz) -2*(Ox(2:sz-1)) + Ox(1:sz-2)) -4/(3*l_tiss)*pi*(l_tiss/2)^3.*kO(2:sz-1).*dt.*Ox(2:sz-1); %consumption term is rescaled to account for sphere around line
    %Gl(2:sz-1) =  Gl(2:sz-1) + ((DG(3:sz)-DG(1:sz-2))/(2*dx)).*((Gl(3:sz)-Gl(1:sz-2))/(2*dx))*dt + DG(2:sz-1).*dt/dx^2.*(Gl(3:sz) -2*(Gl(2:sz-1)) + Gl(1:sz-2)) -4/(3*l_tiss)*pi*(l_tiss/2)^3.*kG(2:sz-1).*dt.*Gl(2:sz-1); %consumption term is rescaled to account for sphere around line

    Ox(2:sz-1) =  Ox(2:sz-1) + DOx(2:sz-1).*dt/dx^2.*(Ox(3:sz) -2*(Ox(2:sz-1)) + Ox(1:sz-2)) -Ncell./l_tiss.*kO(2:sz-1).*dt.*Ox(2:sz-1); %consumption term is rescaled to account for sphere around line
    Gl(2:sz-1) =  Gl(2:sz-1) + ((DG(3:sz)-DG(1:sz-2))/(2*dx)).*((Gl(3:sz)-Gl(1:sz-2))/(2*dx))*dt + DG(2:sz-1).*dt/dx^2.*(Gl(3:sz) -2*(Gl(2:sz-1)) + Gl(1:sz-2)) -Ncell./l_tiss.*kG(2:sz-1).*dt.*Gl(2:sz-1); %consumption term is rescaled to account for sphere around line
    F(2:sz-1) =  F(2:sz-1) + ((Df(3:sz)-Df(1:sz-2))/(2*dx)).*((F(3:sz)-F(1:sz-2))/(2*dx))*dt + Df(2:sz-1).*dt/dx^2.*(F(3:sz) -2*(F(2:sz-1)) + F(1:sz-2)) -Ncell./l_tiss.*kf(2:sz-1).*dt.*F(2:sz-1); %consumption term is rescaled to account for sphere around line

    Ox(1) = Ox(2);
    Ox(sz) = Ox(sz-1);
    Gl(1) = Gl(2);
    Gl(sz) = Gl(sz-1);
    F(1) = F(2);
    F(sz) = F(sz-1);
    Ndead = floor(4/3*pi*(length(v_dead)/2)^3);

    if(mod(t,100000)==0)
        l_tiss%faire en sorte que si v_dead = l_tiss tissu mort.
        Ncell
        Ndead
        v_dead
        plot(aGt,t/900/60,Gl(sz/2-1),'x')
        plot(aGt,t/900/60,Gl(1),'+')
    endif

    if(mod(t,3000000)==0)
        plot(aG,(1:sz)*dx,Gl)
        plot(aO,(1:sz)*dx,Ox)
        plot(aF,(1:sz)*dx,F)
    endif
endfor
toc();

print (fO, "/home/antony/Documents/Post-doc/test_fortran/plots/Ox_line_1.pdf", "-dpdflatexstandalone","-S480,360","-FCalibri:22");
print (fG, "/home/antony/Documents/Post-doc/test_fortran/plots/Gl_line_1.pdf", "-dpdflatexstandalone","-S480,360","-FCalibri:22");
print (fF, "/home/antony/Documents/Post-doc/test_fortran/plots/Fc_line_1.pdf", "-dpdflatexstandalone","-S480,360","-FCalibri:22");
print (fGt, "/home/antony/Documents/Post-doc/test_fortran/plots/time_Gl_large_1.pdf", "-dpdflatexstandalone","-S480,360","-FCalibri:22");


