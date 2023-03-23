%script to test the tridiag routine from the book i 1D and compare it to other methods
%namely  normal inversion with linsolve
clear all;
close all;

tic()
sz = 21;

G = zeros(sz,1);
gam = zeros(sz,1);
GT = zeros(sz,1);
GTb = zeros(sz,1);
Gn = zeros(sz,1);
GnT = zeros(sz,1);
GnTb = zeros(sz,1);
k = zeros(sz,1);
AA = zeros(sz,sz);
NabD = zeros(sz,1);
bet_v = zeros(sz,1)
betb =0

dx = 15;
dt = 1/10;
%ntime = 6/dt;
ntime = 3;


D = ones(sz,1);
D = 40000*D;
D_tissue = 10000;
r = round(sz/4)-1;
D(round(sz/2)-r:round(sz/2)+r)=10000;

G(round(sz/2))=10;
GT(round(sz/2))=10;
GTb(round(sz/2))=10;

% AD the diffusion matrix
AD = D*dt/(dx^2);
NabD(2:sz-1) = dt*(D(3:sz)-D(1:sz-2))/(4*dx^2);

%diagonal and Matrix
up_dg = [0; AD(2:sz-1)-NabD(2:sz-1)];
lo_dg = [AD(2:sz-1)+NabD(2:sz-1); 0];
dg = [1; 2*AD(2:sz-1) + 1 + k(2:sz-1)*dt; 1];
AA = diag(dg)+ diag(-up_dg,1)+ diag(-lo_dg,-1);

figure
hold on;
for i=1:ntime

      %implicit method with mldivide/linsolve from Octave
      Gn = AA\G;
      G = Gn;

      %
      bet_v(1)=1;
      %gam(2:sz) =dg(2:sz) - lo_dg.*(up_dg(1:sz-1)./bet_v(1:sz-1))
      bet_v(1:sz-1);
      bet_v(2:sz) = dg(2:sz) - lo_dg.*(up_dg(1:sz-1)./bet_v(1:sz-1));
      GnT(2:sz) = (GT(2:sz)-lo_dg.*GnT(1:sz-1))./bet_v(2:sz);
      GnT(1:sz-1) = GnT(1:sz-1)-(up_dg(1:sz-1)./bet_v(1:sz-1)).*GnT(2:sz);
      GT = GnT;

      betb = 1;
      for j = 2:sz%marche pas probablement parce que C1 = upè_dg1= 0
          gam(j) = up_dg(j-1)/betb;
          betb = dg(j)-lo_dg(j-1)*gam(j)
          GnTb(j) = (GTb(j) - lo_dg(j-1)*GnTb(j-1))/betb
      endfor
      %plot(GnTb,'v')
      for j=sz-1:-1:1
         GnTb(j) =  GnTb(j) - gam(j+1)* GnTb(j+1);
      endfor
      GTb = GnTb;

waitforbuttonpress()
plot(G,'o')
%plot(GT,'x')
plot(GTb,'v')

endfor
