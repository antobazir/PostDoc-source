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

function [M1,kM1,DM1m,M1t] = update_nutr2(Grid,LD,M1,kM1,DM1m,k1_tss,d0,ntime,tau,dx,dt)
sz  = size(M1,1);
%disp('cons_started')

M1t = [];
M2t = [];

%delta = 1;


% calculate the diffusion and consumption of nutrients


for i=1:ntime
%i
%i=0;
%abs(delta)<1e-6
%while(abs(delta)>1e-9)
M1(find(Grid==0))=1;
M2(find(Grid==0))=1;


%delta
%i++;
##    %explicit  scheme
##    %x-step
##    M(2:sz-1,:) =  M(2:sz-1,:) + dt*(DMm(3:sz,:)-DMm(1:sz-2,:))/(4*dx^2).*(M(3:sz,:)-M(1:sz-2,:)) + DMm(2:sz-1,:)*dt/(dx^2).*(M(3:sz,:) -2*(M(2:sz-1,:)) + M(1:sz-2,:)) -kM(2:sz-1,:).*dt.*M(2:sz-1,:).*GD(2:sz-1,:);
##  %y-step
##    M(:,2:sz-1) =  M(:,2:sz-1) + DMm(:,2:sz-1)*dt/dx^2.*(M(:,3:sz) -2*(M(:,2:sz-1)) + M(:,1:sz-2));

  %terme intermédiaire pour calculer delta et arrêter la boucle
  %prev_M = M;%

##    M(1,:) = M(2,:);
##  M(sz,:) = M(sz-1,:);
##  M(:,1) = M(:,2);
##  M(:,sz) = M(:,sz-1);

    %explicit  scheme non dimensionalised
    %x-step
    M1(2:sz-1,:) =  M1(2:sz-1,:) + d0^2*dt/tau*(DM1m(3:sz,:)-DM1m(1:sz-2,:))/(4*dx^2).*(M1(3:sz,:)-M1(1:sz-2,:)) + DM1m(2:sz-1,:)*d0^2*dt/tau/dx^2.*(M1(3:sz,:) -2*(M1(2:sz-1,:)) + M1(1:sz-2,:)) -k1_tss.*kM1(2:sz-1,:).*dt;
  %y-step
    M1(:,2:sz-1) =  M1(:,2:sz-1) +  d0^2*dt/tau*(DM1m(:,3:sz)-DM1m(:,1:sz-2))/(4*dx^2).*(M1(:,3:sz)-M1(:,1:sz-2)) + DM1m(:,2:sz-1)*d0^2*dt/tau/dx^2.*(M1(:,3:sz) -2*(M1(:,2:sz-1)) + M1(:,1:sz-2));



 %delta = max(max(abs(M-prev_M)));
	%Mt(i) = M(round(sz/2),round(sz/2));
	M1t(:,i) = M1(1:round(sz/2),round(sz/2));


    if(mod(i,1000)==0)
    disp([num2str(i) '/' num2str(ntime)])
  endif

%endwhile
  endfor
endfunction
