%code essai méthode implicite et de Crank-Nicholson
%méthode implicite
sz = 100;
dx = 15;
dt = 1/900; %in min
n_time=1000;

D = 100000;

A = D*dt/(dx^2)
Gl = zeros(1,sz);
Gn = zeros(1,sz);
Gl_e = zeros(1,sz);
Gl_cn = zeros(1,sz);
Gl(1) = 5;
Gl(sz) = 0;
Gl_e(1) = 5;
Gl_e(sz) = 0;
Gn(1) = 5;
Gn(sz) = 0;
Gl_cn(1) = 5;
Gl_cn(sz) = 0;

%initialisation
d_cn(1) = Gl_cn(1);
d_cn(sz) = Gl_cn(sz);

for i=1:n_time
  i;
% "simple" implicit algorithm
%calcul de d
  d = Gl;

%calcul de la matrice A
  up_dg = [0; A*ones(sz-2,1)];
  lo_dg = [A*ones(sz-2,1); 0];
  dg = [1; (2*A+1)*ones(sz-2,1); 1];

   AA=diag(dg)+ diag(-up_dg,1)+ diag(-lo_dg,-1);

   Gn = AA\d';
   Gl = Gn';

% "simple" explicit
Gl_e(2:sz-1) =  Gl_e(2:sz-1) +  A*(Gl_e(3:sz) -2*(Gl_e(2:sz-1)) + Gl_e(1:sz-2));

% crank Nicholson algorithm
  up_dg_cn = [0; A/2*ones(sz-2,1)];
  lo_dg_cn = [A/2*ones(sz-2,1); 0];
  dg_cn = [1; (A+1)*ones(sz-2,1); 1];

   AA_cn=diag(dg_cn)+ diag(-up_dg_cn,1)+ diag(-lo_dg_cn,-1);

d_cn(2:sz-1) =  A/2*(Gl_cn(3:sz)) - (A-1)*Gl_cn(2:sz-1) + A/2*(Gl_cn(1:sz-2));

  Gn_cn = (AA_cn)\d_cn';
  Gl_cn = Gn_cn';


endfor

figure
plot(Gl)
hold on
plot(Gl_cn)
plot(Gl_e)
