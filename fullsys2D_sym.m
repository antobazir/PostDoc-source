## Copyright (C) 2023 Antony
##
## This program is free software: you can redistribute it and/or modify
## it under the terms of the GNU General Public License as published by
## the Free Software Foundation, either version 3 of the License, or
## (at your option) any later version.
##
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
##
## You should have received a copy of the GNU General Public License
## along with this program.  If not, see <https://www.gnu.org/licenses/>.

## -*- texinfo -*-
## @deftypefn {} {@var{retval} =} fullsys2D (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: Antony <antony@antony-Latitude-E7450>
## Created: 2023-03-29

function [G,O,D,GD,T,Gt,Ot,Dt,GDt,Tt,kOct,kGt] = fullsys2D_sym(conf)
%function Gt_r = fullsys2D(conf)
sz = conf(1);
n_min = conf(2);
kO_tissue = conf(3);
kG_tissue = conf(4);
kT_tissue = conf(5);
cT =  conf(6);
cD = conf(7);

G = zeros(round(sz/2)+1,round(sz/2)+1);
D = zeros(round(sz/2)+1,round(sz/2)+1);
GD = zeros(round(sz/2)+1,round(sz/2)+1);
T = zeros(round(sz/2)+1,round(sz/2)+1);
O = zeros(round(sz/2)+1,round(sz/2)+1);
kO = zeros(round(sz/2)+1,round(sz/2)+1);
kG = zeros(round(sz/2)+1,round(sz/2)+1);
kT = zeros(round(sz/2)+1,round(sz/2)+1);

%diffusion being physical it is not part of the modifiable parameters
DOx = ones(round(sz/2)+1,round(sz/2)+1);
DOx = 100000*DOx;
DOx_tissue = 100000;
DG = ones(round(sz/2)+1,round(sz/2)+1);
DG = 40000*DG;
DG_tissue = 10000;
r = round(sz/2.2)-2; %radius of the tissue circle in units

dx = 15;
dt = 1/1000;
ntime = n_min/dt;

%giving all indexes corresponding to a center circle
[i,j,v] = find(DG!=0);
dsy_s = j-round(sz/2);
dsx_s = i-round(sz/2);
DOx(find((dsx_s.^2+dsy_s.^2)<r^2))= DOx_tissue;
DG(find((dsx_s.^2+dsy_s.^2)<r^2))= DG_tissue;
kO(find((dsx_s.^2+dsy_s.^2)<r^2))= kO_tissue;
kG(find((dsx_s.^2+dsy_s.^2)<r^2))= kG_tissue;
kT(find((dsx_s.^2+dsy_s.^2)<r^2))= kT_tissue;

%Initial concentration are also physically motivated so they won't be touched.
G(:,:) =5;
O(:,:) =0.15;
D(find((dsx_s.^2+dsy_s.^2)<r^2))= 0.2;
T(find((dsx_s.^2+dsy_s.^2)<r^2))= 20;
GD(find((dsx_s.^2+dsy_s.^2)<r^2))= 0.1;


tic()
l =1;
for i=1:ntime
    %i

    %G(find((dsx.^2+dsy.^2)>=r^2))= 0.5;
    G(find((dsx_s.^2+dsy_s.^2)>=r^2))= 5;
    O(find((dsx_s.^2+dsy_s.^2)>=r^2))= 0.15;
    %D(find((dsx.^2+dsy.^2)>=r^2))= 0.2;
    %T(find((dsx.^2+dsy.^2)>=r^2))= 20;
    %GD(find((dsx.^2+dsy.^2)>=r^2))= 1;

     kG(find((dsx_s.^2+dsy_s.^2)<r^2)) = kG_tissue*exp(-cT*T(find((dsx_s.^2+dsy_s.^2)<r^2))./ D(find((dsx_s.^2+dsy_s.^2)<r^2)));
     kO(find((dsx_s.^2+dsy_s.^2)<r^2)) = max(0,kO_tissue- cD.*D(find((dsx_s.^2+dsy_s.^2)<r^2))) ;

    %explicit  scheme--Gluc
    G(2:round(sz/2),round(sz/2)+1) = G(2:round(sz/2),round(sz/2)-1);
    G(round(sz/2)+1,2:round(sz/2)) = G(round(sz/2)-1,2:round(sz/2));
    %x-step
    G(2:round(sz/2),2:round(sz/2)) =  G(2:round(sz/2),2:round(sz/2)) + dt*(DG(3:round(sz/2)+1,2:round(sz/2))-DG(1:round(sz/2)-1,2:round(sz/2)))/(4*dx^2).*(G(3:round(sz/2)+1,2:round(sz/2))-G(1:round(sz/2)-1,2:round(sz/2))) + DG(2:round(sz/2),2:round(sz/2))*dt/dx^2.*(G(3:round(sz/2)+1,2:round(sz/2)) -2*(G(2:round(sz/2),2:round(sz/2))) + G(1:round(sz/2)-1,2:round(sz/2))) -kG(2:round(sz/2),2:round(sz/2)).*G(2:round(sz/2),2:round(sz/2)).*D(2:round(sz/2),2:round(sz/2))*dt;
    %y-step
    G(2:round(sz/2),2:round(sz/2)) =  G(2:round(sz/2),2:round(sz/2)) + dt*(DG(2:round(sz/2),3:round(sz/2)+1)-DG(2:round(sz/2),1:round(sz/2)-1))/(4*dx^2).*(G(2:round(sz/2),3:round(sz/2)+1)-G(2:round(sz/2),1:round(sz/2)-1)) + DG(2:round(sz/2),2:round(sz/2))*dt/dx^2.*(G(2:round(sz/2),3:round(sz/2)+1) -2*(G(2:round(sz/2),2:round(sz/2))) + G(2:round(sz/2),1:round(sz/2)-1));


    %explicit  scheme--Ox
    O(2:round(sz/2),round(sz/2)+1) = O(2:round(sz/2),round(sz/2)-1);
    O(round(sz/2)+1,2:round(sz/2)) = O(round(sz/2)-1,2:round(sz/2));
    %x-step
    O(2:round(sz/2),2:round(sz/2)) =  O(2:round(sz/2),2:round(sz/2)) + dt*(DOx(3:round(sz/2)+1,2:round(sz/2))-DOx(1:round(sz/2)-1,2:round(sz/2)))/(4*dx^2).*(O(3:round(sz/2)+1,2:round(sz/2))-O(1:round(sz/2)-1,2:round(sz/2))) + DOx(2:round(sz/2),2:round(sz/2))*dt/dx^2.*(O(3:round(sz/2)+1,2:round(sz/2)) -2*(O(2:round(sz/2),2:round(sz/2))) + O(1:round(sz/2)-1,2:round(sz/2))) -kO(2:round(sz/2),2:round(sz/2)).*O(2:round(sz/2),2:round(sz/2)).*GD(2:round(sz/2),2:round(sz/2))*dt;
    %y-step
    O(2:round(sz/2),2:round(sz/2)) =  O(2:round(sz/2),2:round(sz/2)) + dt*(DOx(2:round(sz/2),3:round(sz/2)+1)-DOx(2:round(sz/2),1:round(sz/2)-1))/(4*dx^2).*(O(2:round(sz/2),3:round(sz/2)+1)-O(2:round(sz/2),1:round(sz/2)-1)) + DOx(2:round(sz/2),2:round(sz/2))*dt/dx^2.*(O(2:round(sz/2),3:round(sz/2)+1) -2*(O(2:round(sz/2),2:round(sz/2))) + O(2:round(sz/2),1:round(sz/2)-1));


    D(2:round(sz/2),2:round(sz/2)) =  D(2:round(sz/2),2:round(sz/2)) -kG(2:round(sz/2),2:round(sz/2)).*dt.*D(2:round(sz/2),2:round(sz/2)).*G(2:round(sz/2),2:round(sz/2)) + kT(2:round(sz/2),2:round(sz/2)).*dt.*T(2:round(sz/2),2:round(sz/2));
    GD(2:round(sz/2),2:round(sz/2)) =  GD(2:round(sz/2),2:round(sz/2)) +kG(2:round(sz/2),2:round(sz/2)).*dt.*D(2:round(sz/2),2:round(sz/2)).*G(2:round(sz/2),2:round(sz/2)) - kO(2:round(sz/2),2:round(sz/2)).*dt.*GD(2:round(sz/2),2:round(sz/2)).*O(2:round(sz/2),2:round(sz/2));
    T(2:round(sz/2),2:round(sz/2)) =  T(2:round(sz/2),2:round(sz/2)) +kO(2:round(sz/2),2:round(sz/2)).*dt.*O(2:round(sz/2),2:round(sz/2)).*GD(2:round(sz/2),2:round(sz/2)) - kT(2:round(sz/2),2:round(sz/2)).*dt.*T(2:round(sz/2),2:round(sz/2));

    if(mod(i,100)==0)
      Ot(l,1) =  O(round(sz/2),round(sz/2));
      Ot(l,2) =  O(round(sz/2),round(sz/2-r+2));
      Gt(l,1) =  G(round(sz/2),round(sz/2));
      Gt(l,2) =  G(round(sz/2),round(sz/2-r+2));
      Dt(l,1) =  D(round(sz/2),round(sz/2));
      Dt(l,2) =  D(round(sz/2),round(sz/2-r+2));
      GDt(l,1) =  GD(round(sz/2),round(sz/2));
      GDt(l,2) =  GD(round(sz/2),round(sz/2-r+2));
      Tt(l,1) =  T(round(sz/2),round(sz/2));
      Tt(l,2) =  T(round(sz/2),round(sz/2-r+2));
      kGt(l,1) =  kG(round(sz/2),round(sz/2)).*G(round(sz/2),round(sz/2)).*D(round(sz/2),round(sz/2));
      kGt(l,2) =  kG(round(sz/2),round(sz/2-r+2)).*G(round(sz/2),round(sz/2-r+2)).*D(round(sz/2),round(sz/2-r+2));
      kGet(l,1) =  kG_tissue*exp(-T(round(sz/2),round(sz/2))./D(round(sz/2),round(sz/2)));
      kGet(l,2) =  kG_tissue*exp(-T(round(sz/2),round(sz/2)-r+2)./D(round(sz/2),round(sz/2))-r+2);
      kOct(l,1) =  kO(round(sz/2),round(sz/2)).*O(round(sz/2),round(sz/2)).*GD(round(sz/2),round(sz/2));
      kOct(l,2) =  kO(round(sz/2),round(sz/2-r+2)).*O(round(sz/2),round(sz/2-r+2)).*GD(round(sz/2),round(sz/2-r+2));
      l = l+1;
    endif
endfor
toc()

endfunction

%T/D monte fort parce que D chute.
% switch quand (0.017*Tt(:,1)-kGt(:,1)) = 0.017 confirmé.
% donc essayer de voir ce qui se passe si µ est trop haut pour être refranchi et ce que signifie physique le fait que ce seuil soit franchi.
% la prod de [D] suit EXACTEMENT µ[T] jusqu'au seuil.
