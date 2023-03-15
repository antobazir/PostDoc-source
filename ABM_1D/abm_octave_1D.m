clear all;
close all

%diffusion initialisation
sz = 100;
Grid = zeros(1,sz);
Ox_m = zeros(1,sz);
Gl_m = zeros(1,sz);
F_m = zeros(1,sz);
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
kO = 3*kO; %consumption rate in mM/min based on 5000 amol/min & cell volume of 2000 µm^3

DG(1:sz) = 40000 %diffusion of glucose
kG = 15*kG; %consumption rate in mM/min based on 500 amol/min & cell volume of 2000 µm^3

Df(1:sz) = 1000; %diffusion of growth factor
kf = 5e-3*kf; %consumption rate in mM/min based on value given by Filion



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



for cy = 1:ncy
  idx = find(Grid!=0)
  for i = 1:length(idx)
   pos = idx(i);
   pos


    %proliferative cells divide
    if(state_v(i)==1)
      Grid = divide1D_2(Grid,pos,c_idx+1,sz);
    endif
    %disp('updated Grid:')
    %Grid
    c_idx = c_idx+1;
    state_v(c_idx)=1
    disp("end of loop")
  endfor
endfor

