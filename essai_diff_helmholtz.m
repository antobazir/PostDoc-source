close all;
n_space = 330
n_time = 50000

%Concentraion fields
G = zeros(1,n_space);
O = zeros(1,n_space);
Gn = zeros(1,n_space);
D = zeros(1,n_space);
kG = zeros(1,n_space);
kO = zeros(1,n_space);
DOx= 120000;
D(1:n_space) = 40000;
D(floor(n_space/2)-70:floor(n_space/2)+70) = 10000;
kG(floor(n_space/2)-70:floor(n_space/2)+70) = 6e-2;
kO(floor(n_space/2)-70:floor(n_space/2)+70) = 60e-2;
dx = 3; %in µm

##G(1) = 0.6;
##G(n_space) = 0.6;
##Gn(1) = 0.6;
##Gn(n_space) = 0.6;
G(1:n_space) =5;
O(1:n_space) =0.6;

fG = figure;
aG = axes(fG);
hold(aG);
xlabel(aG,'position (µm)','fontsize',20)
ylabel(aG, 'concentration (mM)','fontsize',20)

fO = figure;
aO = axes(fO);
hold(aO);
xlabel(aO,'position (µm)','fontsize',20)
ylabel(aO, 'concentration (mM)','fontsize',20)

ft = figure;
at = axes(ft);
hold(at);
xlabel(at,'step','fontsize',20)
ylabel(at, 'concentration (mM)','fontsize',20)

%algo jacobi matriciel my version
tic();
%G(floor(n_space/2))
for i =1:n_time
  G(2:n_space-1) =(dx^2./(2*D(2:n_space-1)+kG(2:n_space-1).*0.2*dx^2)).*((D(3:n_space)-D(1:n_space-2))/(2*dx)).*((G(3:n_space)-G(1:n_space-2))/(2*dx)) + (D(2:n_space-1).*(G(3:n_space)+G(1:n_space-2))/(dx^2)).*(dx^2./(2*D(2:n_space-1)+kG(2:n_space-1).*0.2*dx^2));
  O(2:n_space-1) = (DOx*(O(3:n_space)+O(1:n_space-2))/(dx^2)).*(dx^2./(2*DOx+kO(2:n_space-1)*0.6*dx^2));
  %G(floor(n_space/2))
  if(i==n_time/1000||i==n_time/100||i==n_time/10||i==n_time)
  plot(aG,G)
  plot(aO,O)
endif
  if(mod(i,1000)==0)
   plot(at,i,G(floor(n_space/2)),'x');
   plot(at,i,O(floor(n_space/2)),'o');
  endif
endfor
toc();



##G(2:n_space-1) = 0;
##
##%algo jacobi séquentiel
##tic();
##for i =1:n_time
##  for j = 2:n_space-1
##    Gn(j) =D/(2*D+k*dx^2)*(G(j+1)+G(j-1));
##   endfor
##   G = Gn;
##endfor
##toc();
##
##%algo Gauss-Seidel séquentiel
##tic();
##for i =1:n_time
##  for j = 2:n_space-1
##    G(j) =D/(2*D+k*dx^2)*(G(j+1)+G(j-1));
##   endfor
##endfor
##toc();
##


