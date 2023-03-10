close all;
n_space = 330
n_time = 10000

%Concentraion fields
G = zeros(1,n_space);
Gn = zeros(1,n_space);
f = zeros(1,n_space);
f = exp(-((1:n_space)-round(n_space/2)).^2)
D= 10000
k = 6e-2
dx = 3 %in µm

%small code with a case that is analytically tractable
a = sqrt(6e-2/10000)
c2 = 0.6*(1 - exp(a*n_space*dx))/(exp(-a*n_space*dx) - exp(a*n_space*dx))
c1 = 0.6 -c2

G_a = c1*exp(a*(1:n_space)*dx) + c2*exp(-a*(1:n_space)*dx)
G(1) = 0.6;
G(n_space) = 0.6;
Gn(1) = 0.6;
Gn(n_space) = 0.6;

fG = figure;
aG = axes(fG);
hold(aG);
xlabel(aG,'position (µm)','fontsize',20)
ylabel(aG, 'concentration (mM)','fontsize',20)

%algo jacobi matriciel
tic();
for i =1:n_time
  G(2:n_space-1) =D/(2*D+k*dx^2)*(G(3:n_space)+G(1:n_space-2));
endfor
toc();

G(2:n_space-1) = 0;

%algo jacobi séquentiel
tic();
for i =1:n_time
  for j = 2:n_space-1
    Gn(j) =D/(2*D+k*dx^2)*(G(j+1)+G(j-1));
   endfor
   G = Gn;
endfor
toc();

%algo Gauss-Seidel séquentiel
tic();
for i =1:n_time
  for j = 2:n_space-1
    G(j) =D/(2*D+k*dx^2)*(G(j+1)+G(j-1));
   endfor
endfor
toc();


plot(aG,G)
