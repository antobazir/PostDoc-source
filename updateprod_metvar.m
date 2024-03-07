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

function [M,kM,DMm] = updateprod_metvar(Grid,LD,M_s,M,kM,cM,DMm,d0,ntime,tau,dx,dt)
sz  = size(M,1);

%Mn = 0:0.01:1;
%V_norm = 1/max(Mn./(cM+ Mn));

%Mt = [];

ntime;

%delta = 1;
% calculate the diffusion and consumption of nutrients
for i=1:ntime
%i=0;
%abs(delta)<1e-6
%while(abs(delta)>1e-9)
spread = imfill(Grid!=0,'holes');
M(spread==0)=0;
M(M<0)=0;
%delta
%i++;
##    %explicit  scheme
##    %x-step
##    M(2:sz-1,:) =  M(2:sz-1,:) + dt*(DMm(3:sz,:)-DMm(1:sz-2,:))/(4*dx^2).*(M(3:sz,:)-M(1:sz-2,:)) + DMm(2:sz-1,:)*dt/(dx^2).*(M(3:sz,:) -2*(M(2:sz-1,:)) + M(1:sz-2,:)) -kM(2:sz-1,:).*dt.*M(2:sz-1,:).*GD(2:sz-1,:);
##  %y-step
##    M(:,2:sz-1) =  M(:,2:sz-1) + DMm(:,2:sz-1)*dt/dx^2.*(M(:,3:sz) -2*(M(:,2:sz-1)) + M(:,1:sz-2));

  %terme intermédiaire pour calculer delta et arrêter la boucle
  %prev_M = M;%

##  M(1,:) = M(2,:);
##  M(sz,:) = M(sz-1,:);
##  M(:,1) = M(:,2);
##  M(:,sz) = M(:,sz-1);

    %explicit  scheme non dimensionalised
    %x-step
    M(2:sz-1,:) =  M(2:sz-1,:) + d0^2*dt/tau*(DMm(3:sz,:)-DMm(1:sz-2,:))/(4*dx^2).*(M(3:sz,:)-M(1:sz-2,:)) + DMm(2:sz-1,:)*d0^2*dt/tau/dx^2.*(M(3:sz,:) -2*(M(2:sz-1,:)) + M(1:sz-2,:)) -kM(2:sz-1,:).*dt.*(M_s(2:sz-1,:)>0);%kM(2:sz-1,:).*dt.*M_s(2:sz-1,:)./(cM + M_s(2:sz-1,:));
  %y-step
    M(:,2:sz-1) =  M(:,2:sz-1) +  d0^2*dt/tau*(DMm(:,3:sz)-DMm(:,1:sz-2))/(4*dx^2).*(M(:,3:sz)-M(:,1:sz-2)) + DMm(:,2:sz-1)*d0^2*dt/tau/dx^2.*(M(:,3:sz) -2*(M(:,2:sz-1)) + M(:,1:sz-2));

  %delta = max(max(V_norm*kM(2:sz-1,:).*dt.*M_s(2:sz-1,:)./(cM + M_s(2:sz-1,:))));
	%Mt(i) = M(round(sz/2),round(sz/2));
	%Mt(:,i) = M(1:round(sz/2),round(sz/2));

%endwhile
  endfor
endfunction
