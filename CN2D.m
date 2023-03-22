clear all;
close all;
%small script to compare and test Crank-Nicholson
sz = 201;
G = zeros(sz,sz);
Gcn = zeros(sz,sz);
Gcn_i = zeros(sz,sz);
Gcn_i2 = zeros(sz,sz);
Gcn_n = zeros(sz,sz);
Gcn_n2 = zeros(sz,sz);
Gdi = zeros(sz,sz);
Gdi_i = zeros(sz,sz);
Gdi_n = zeros(sz,sz);
rhs1 = zeros(sz,sz);
rhs2 = zeros(sz,sz);


dx = 15;
D = 100000;
dt = 1/100;
ntime = 10;
A = D*dt/(dx^2);

G(round(sz/2),round(sz/2))=10;
Gcn(round(sz/2),round(sz/2))=10;
Gdi(round(sz/2),round(sz/2))=10;

##fC = figure;
##aC =  axes(fC);
##fD = figure;
##aD =  axes(fD);

F = figure;

for i=1:ntime
      %x-stencil
      G(2:sz-1,:) = G(2:sz-1,:) + D*dt/(dx^2).*(G(3:sz,:)-2*G(2:sz-1,:)+G(1:sz-2,:));
      %y-stencil
      G(:,2:sz-1) = G(:,2:sz-1) + D*dt/(dx^2).*(G(:,3:sz)-2*G(:,2:sz-1)+G(:,1:sz-2));

      %Crank Nicholson ADI scheme----------------SPURIONS OSCILLATIONS BELOW dt = 1/500
      %calculation of the AA (intermediate step matrix)
      up_dg = [0 A/2*ones(1,sz-2,1)];
      lo_dg = [A/2*ones(1,sz-2) 0];
      dg = [1 (A+1)*ones(1,sz-2) 1];
      AA=diag(dg)+ diag(-up_dg,1)+ diag(-lo_dg,-1);



      %calculation of rhs matrix % SPURIONS OSCILLATIONS BELOW dt = 1/500
      rhs1(:,1) = Gcn(:,1);rhs1(:,sz) = Gcn(:,sz);
      rhs1(:,2:sz-1) = A/2*(Gcn(:,3:sz)) - (A-1)*Gcn(:,2:sz-1) + A/2*(Gcn(:,1:sz-2));

      %inversion and generation of the intermediate matrix
      Gcn_i = AA\rhs1;

      %rhs2 dérivée suivant x
      rhs2(2:sz-1,:) = A/2*(Gcn_i(3:sz,:)) - (A-1)*Gcn_i(2:sz-1,:) + A/2*(Gcn_i(1:sz-2,:));
      Gcn_n = AA\rhs2';
      Gcn_n = Gcn_n';

      %update for next step
      Gcn =  Gcn_n;
      %-----------------------

##      %loop type calculation-------------------------
##        for k = 2:sz-1
##          Gcn_i2(:,k) = AA\(A/2*(Gcn(:,k+1)) - (A-1)*Gcn(:,k) + A/2*(Gcn(:,k-1)));
##        endfor
##        for k = 2:sz-1
##          Gcn_n2(:,k) = AA\(A/2*(Gcn_i2(:,k+1)) - (A-1)*Gcn_i2(:,k) + A/2*(Gcn_i2(:,k-1)));
##        endfor
        %-------------------------------------------------------

      %"simple" Implicit scheme-------------------------
       %calculation of the AA (intermediate step matrix)
        up_dg = [0 A*ones(1,sz-2,1)];
        lo_dg = [A*ones(1,sz-2) 0];
        dg = [1 (2*A+1)*ones(1,sz-2) 1];
        DI=diag(dg)+ diag(-up_dg,1)+ diag(-lo_dg,-1);

        Gdi_i = DI\Gdi;

        %Gdi_i needs to be transposed in order to yield the y-derivative and the solution shall then be transposed too
        Gdi_n = DI\Gdi_i';
        Gdi_n = Gdi_n';
        Gdi = Gdi_n;

##      %plotting separate windows
##      imagesc(aC,Gcn)
##      imagesc(aD,Gdi)
##      kbhit()

      %plotting in same window
      subplot(2,1,1)
      imagesc(Gcn)
      subplot(2,1,2)
      imagesc(Gdi)
      kbhit();
endfor

