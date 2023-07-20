## Copyright (C) 2023 antony
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
## @deftypefn {} {@var{retval} =} update (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: antony <antony.bazir@antony-Latitude-E7450>
## Created: 2023-07-20

function [Grid,sz,G,O,sycle,kO,kG,kO_tissue,kG_tissue,DG] = update_model(Grid,sz,G,O,sycle,kO,kG,kO_tissue,kG_tissue,DG,DG_tissue,ntime,conf)
n_min = conf(2);
kO_tissue = conf(3);
kG_tissue = conf(4);
cO =  conf(5);
cG = conf(6);
dx = conf(7);
dt = conf(8);
renew = conf(9);
n_cells0 = conf(10);
pellet_size = conf(11);
Diff_glu = conf(12);


%diffusion being physical it is not part of the modifiable parameters
DOx = ones(round(sz/2)+1,round(sz/2)+1);
DOx = 120000*DOx;
DOx_tissue = 120000;
DG = ones(round(sz/2)+1,round(sz/2)+1);
DG = conf(12)*DG;
DG_tissue = conf(12);
%r = round(sz/2.2)-2; %radius of the tissue circle in units
rad = round(pellet_size/15/2);


[i,j,v] = find(DG!=0);
dsy_s = j-round(sz/2);
dsx_s = i-round(sz/2);
sites = find((dsx_s.^2+dsy_s.^2)<rad^2);

l =1;
for i=1:ntime
    %G'(round(sz/2),round(sz/2-rad+2))
    if(mod(i,1000)==0)
		i
		sycle(find(sycle(:,1)!=-1),1)= sycle(find(sycle(:,1)!=-1),1)+1;
		for n=1:length(sycle)
			%n
			Ox_vals(n) = O(find(Grid==n));
			if(O(find(Grid==n))>0.015)
				sycle(n,2) = round(interp1([0.150 0.0375 0.015],[2.8000-0.6 6.6000-0.6 400.0000-0.6]*24*60,O(find(Grid==n)))+864);
			else
				sycle(n,2) = round(((400.0000-0.6)*24*60)+864);
			endif
			%sycle(n,1)==sycle(n,2)
			if(sycle(n,1)>=sycle(n,2))
				%n
			endif
		endfor

		for k=1:length(sycle)
			%k
			%sycle(k,1)
			%sycle(k,2)
			%sycle(k,1)>=sycle(k,2)
			if(sycle(k,1)>=sycle(k,2))
				k
				[r,c] = ind2sub([round(sz/2)+1,round(sz/2)+1],find(Grid==k))
				pos(1) = r; pos(2) = c;
				length(sycle)
				[Grid,kO,kG,DG,sycle] = divide2D_cc(Grid,pos,k,round(sz/2)+1,G,O,sycle,kO,kG,kO_tissue,kG_tissue,DG,DG_tissue);
				length(sycle)
			endif

			if(G(find(Grid==k))<10&&O(find(Grid==k))<0.015&&sycle(k,1)<(sycle(k,2)-480)&sycle(k,1)>(sycle(k,2)-864))
				kG(find(Grid==k)) = 0;
				kO(find(Grid==k)) = 0;
				sycle(k,1) = -1;
			endif
		endfor
	endif

    %G(find((dsx.^2+dsy.^2)>=r^2))= 0.5;
	%option 1 medium get renewed only outside
	%if(renew==1)
		G(find((dsx_s.^2+dsy_s.^2)>=rad^2))= 20;
		O(find((dsx_s.^2+dsy_s.^2)>=rad^2))= 0.15;
##		G(1,2:size(G,2)) = G(2,2:size(G,2));
##		G(2:size(G,1),1) = G(2:size(G,1),2);
##		G(1,1) =G(2,2);
##		O(1,2:size(O,2)) = O(2,2:size(O,2));
##		O(2:size(O,1),1) = O(2:size(O,1),2);
##		O(1,1) =O(2,2);
	%endif

	%otion 2 medium get renewed everywhere but in cells
	%if(renew==2)
	%	G(find(DG==DG_tissue))= 20;
	%	O(find(DG==DG_tissue))= 0.15;
	%endif

	%if(renew==3)
##		G(find(DG==DG_tissue))= 5;
##		O(find(DG==DG_tissue))= 0.15;
	%endif

	kG(find(and(kG>0,O<0.015))) = kG_tissue*2;
	kG(find(and(kG>0,O>=0.015))) = kG_tissue;

    %explicit  scheme--Gluc
    %symétrisation
    G(1:round(sz/2)+1,round(sz/2)+1) = G(1:round(sz/2)+1,round(sz/2)-1);
    G(round(sz/2)+1,1:round(sz/2)+1) = G(round(sz/2)-1,1:round(sz/2)+1);
    %x-step
    G(2:round(sz/2),1:round(sz/2)+1) =  G(2:round(sz/2),1:round(sz/2)+1) + dt*(DG(3:round(sz/2)+1,1:round(sz/2)+1)-DG(1:round(sz/2)-1,1:round(sz/2)+1))/(4*dx^2).*(G(3:round(sz/2)+1,1:round(sz/2)+1)-G(1:round(sz/2)-1,1:round(sz/2)+1)) + DG(2:round(sz/2),1:round(sz/2)+1)*dt/dx^2.*(G(3:round(sz/2)+1,1:round(sz/2)+1) -2*(G(2:round(sz/2),1:round(sz/2)+1)) + G(1:round(sz/2)-1,1:round(sz/2)+1)) -kG(2:round(sz/2),1:round(sz/2)+1).*(G(2:round(sz/2),1:round(sz/2)+1)./(G(2:round(sz/2),1:round(sz/2)+1)+cG))*dt ;
    %y-step
    G(1:round(sz/2)+1,2:round(sz/2)) =  G(1:round(sz/2)+1,2:round(sz/2)) + dt*(DG(1:round(sz/2)+1,3:round(sz/2)+1)-DG(1:round(sz/2)+1,1:round(sz/2)-1))/(4*dx^2).*(G(1:round(sz/2)+1,3:round(sz/2)+1)-G(1:round(sz/2)+1,1:round(sz/2)-1)) + DG(1:round(sz/2)+1,2:round(sz/2))*dt/dx^2.*(G(1:round(sz/2)+1,3:round(sz/2)+1) -2*(G(1:round(sz/2)+1,2:round(sz/2))) + G(1:round(sz/2)+1,1:round(sz/2)-1));

    %explicit  scheme--GOx
    %symétrisation
    O(1:round(sz/2)+1,round(sz/2)+1) = O(1:round(sz/2)+1,round(sz/2)-1);
    O(round(sz/2)+1,1:round(sz/2)+1) = O(round(sz/2)-1,1:round(sz/2)+1);
    %x-step
    O(2:round(sz/2),1:round(sz/2)+1) =  O(2:round(sz/2),1:round(sz/2)+1) + dt*(DOx(3:round(sz/2)+1,1:round(sz/2)+1)-DOx(1:round(sz/2)-1,1:round(sz/2)+1))/(4*dx^2).*(O(3:round(sz/2)+1,1:round(sz/2)+1)-O(1:round(sz/2)-1,1:round(sz/2)+1)) + DOx(2:round(sz/2),1:round(sz/2)+1)*dt/dx^2.*(O(3:round(sz/2)+1,1:round(sz/2)+1) -2*(O(2:round(sz/2),1:round(sz/2)+1)) + O(1:round(sz/2)-1,1:round(sz/2)+1)) -kO(2:round(sz/2),1:round(sz/2)+1).*(O(2:round(sz/2),1:round(sz/2)+1)./(O(2:round(sz/2),1:round(sz/2)+1)+cO))*dt ;
    %y-step
    O(1:round(sz/2)+1,2:round(sz/2)) =  O(1:round(sz/2)+1,2:round(sz/2)) + dt*(DOx(1:round(sz/2)+1,3:round(sz/2)+1)-DOx(1:round(sz/2)+1,1:round(sz/2)-1))/(4*dx^2).*(O(1:round(sz/2)+1,3:round(sz/2)+1)-O(1:round(sz/2)+1,1:round(sz/2)-1)) + DOx(1:round(sz/2)+1,2:round(sz/2))*dt/dx^2.*(O(1:round(sz/2)+1,3:round(sz/2)+1) -2*(O(1:round(sz/2)+1,2:round(sz/2))) + O(1:round(sz/2)+1,1:round(sz/2)-1));


    if(mod(i,1000)==0)
      Ot(l,1) =  O(round(sz/2),round(sz/2));
      Ot(l,2) =  O(round(sz/2),round(sz/2-rad+2));
      Gt(l,1) =  G(round(sz/2),round(sz/2));
      Gt(l,2) =  G(round(sz/2),round(sz/2-rad+2));
	  kOct(l,1) =  kO(round(sz/2),round(sz/2)).*(O(round(sz/2),round(sz/2))./(O(round(sz/2),round(sz/2))+cO));
      kOct(l,2) =  kO(round(sz/2),round(sz/2-rad+2)).*(O(round(sz/2),round(sz/2-rad+2))./(O(round(sz/2),round(sz/2-rad+2))+cO));
      kGt(l,1) =  (kG(round(sz/2),round(sz/2))).*(G(round(sz/2),round(sz/2))./(G(round(sz/2),round(sz/2))+cG));
      kGt(l,2) =  (kG(round(sz/2),round(sz/2-rad+2))).*(G(round(sz/2),round(sz/2-rad+2))./(G(round(sz/2),round(sz/2-rad+2))+cG));

      l = l+1;
    endif
endfor

endfunction
