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

%boundary conditions
Ox(1:sz) = 0.6; %concentration in mM
Gl(1:sz) = 5; %concentration in mM
%50 kDa = 8.3e-20 g -> 49800 g/mol -> 2e-13 mol/mL -> 2e-10 mol/L -> 2e-7 mM/L
F(1:sz) = 2e-7; %concentration in mM


DOx(1:sz) = 100000; %diffusion of oxygen
kO_tissue = 1e-2 %consumption rate in mM/min based on 5000 amol/min & cell volume of 2000 µm^3

DG(1:sz) = 40000 %diffusion of glucose medium
DG_tissue = 10000 %diffusion of glucose medium
kG_tissue = 1e-2; %consumption rate in mM/min based on 500 amol/min & cell volume of 2000 µm^3

Df(1:sz) = 1000; %diffusion of growth factor
kf = 5e-3*kf; %consumption rate in mM/min based on value given by Filion


n_time_diff = 1440*900*6; %1440 min cell/cycle dt is 1/900 mn and 3 is the number of cycles

%cell initialisation
cr = 7.5; % cell radius
ncy = 3;
c_idx = 1; %cell index
n_cell = 1;
state_v(c_idx) = 1;

%state : 1 = proliferative
% 2 =  quiescent
% 3 = necrotic
%moore neighboorhood

%initialisation
Grid(sz/2)=1;
DG(sz/2) = 10000;
kG(sz/2) = 1;
kO(sz/2) = 1;

tic();
for t = 1:n_time_diff
     %diffusion
    Ox(2:sz-1) =  Ox(2:sz-1) + DOx(2:sz-1).*dt/dx^2.*(Ox(3:sz) -2*(Ox(2:sz-1)) + Ox(1:sz-2)) -kO(2:sz-1).*dt.*Ox(2:sz-1);
    Gl(2:sz-1) =  Gl(2:sz-1) + ((DG(3:sz)-DG(1:sz-2))/(2*dx)).*((Gl(3:sz)-Gl(1:sz-2))/(2*dx))*dt + DG(2:sz-1).*dt/dx^2.*(Gl(3:sz) -2*(Gl(2:sz-1)) + Gl(1:sz-2)) -kG(2:sz-1).*dt.*Gl(2:sz-1);

    if(mod(t,1440*900)==0)
      disp("division")
      idx = find(Grid!=0)
      for i = 1:length(idx)
        pos = idx(i);
        pos

        %proliferative cells divide
        t
        if(state_v(i)==1)
          Grid = divide1D_2(Grid,pos,c_idx+1,sz);
        endif
        %disp('updated Grid:')
        Grid
        c_idx = c_idx+1;
        DG(find(Grid==c_idx)) = DG_tissue;
        kG(find(Grid==c_idx)) = kG_tissue;
        kO(find(Grid==c_idx)) = kO_tissue;
        state_v(c_idx)=1;
        disp("end of loop")
      endfor
     endif
endfor
toc();

