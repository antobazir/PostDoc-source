% you need both the Grid and the old diffusion grid as you don't always start a 0

function [G,O,D,GD,T,Gt,Ot,Dt,GDt,Tt] = diffusion_abm(Grid,G,O,D,GD,T,conf)
%function Gt_r = fullsys2D(conf)
sz = conf(1);
n_min = conf(2);
kO_tissue = conf(3);
kG_tissue = conf(4);
kT_tissue = conf(5);
cT =  conf(6);
cD = conf(7);
kA_tissue = conf(8);
dx = conf(9);
dt = conf(10);

%consumption are zeros at every call because they are reupdated later
kO = zeros(sz,sz);
kG = zeros(sz,sz);
kT = zeros(sz,sz);
kA = zeros(sz,sz);

%diffusion being "physical" it is not part of the modifiable parameters
DOx = ones(sz,sz);
DOx = 100000*DOx;
DOx_tissue = 100000;
DG = ones(sz,sz);
DG = 40000*DG;
DG_tissue = 10000;

%dx = 50;
cell_size = 15;
%dt = 1/300;
ntime = n_min/dt;

%updating diffusion and consumption according to the Grid
DOx(find(Grid!=0)) = DOx_tissue;
DG(find(Grid!=0))= DG_tissue;
kO(find(Grid!=0))= kO_tissue;
kG(find(Grid!=0))= kG_tissue;
kT(find(Grid!=0))= kT_tissue;
kA(find(Grid!=0))= kA_tissue;


tic()
l =1;
for i=1:ntime
    %i
	%This is kept to ensure constant supply
	G(find(Grid==0))= 5;
	O(find(Grid==0))= 0.15;

    kG(find(Grid!=0)) = kG_tissue*exp(-cT*T(find(Grid!=0))./ D(find(Grid!=0)));
    kO(find(Grid!=0)) = kO_tissue- kO_tissue/10.*D(find(Grid!=0)) ;
	kA(find(Grid!=0)) = kA_tissue*exp(-cT*T(find(Grid!=0))./ D(find(Grid!=0)));

    %explicit  scheme
	%y-step
    O(:,2:sz-1) =  O(:,2:sz-1) + DOx(:,2:sz-1)*dt/(dx^2).*(O(:,3:sz) -2*(O(:,2:sz-1)) + O(:,1:sz-2)) -dx/cell_size*kO(:,2:sz-1).*dt.*O(:,2:sz-1).*GD(:,2:sz-1)/2;
    G(:,2:sz-1) =  G(:,2:sz-1) + dt*(DG(:,3:sz)-DG(:,1:sz-2))/(4*dx^2).*(G(:,3:sz)-G(:,1:sz-2)) + DG(:,2:sz-1)*dt/dx^2.*(G(:,3:sz) -2*(G(:,2:sz-1)) + G(:,1:sz-2)) -dx/cell_size*kG(:,2:sz-1).*dt.*G(:,2:sz-1).*D(:,2:sz-1)/2;

    %x-step
    O(2:sz-1,:) =  O(2:sz-1,:)  + DOx(2:sz-1,:)*dt/(dx^2).*(O(3:sz,:) -2*(O(2:sz-1,:)) + O(1:sz-2,:)) -dx/cell_size*kO(2:sz-1,:).*dt.*O(2:sz-1,:).*GD(2:sz-1,:)/2;
    G(2:sz-1,:) =  G(2:sz-1,:) + dt*(DG(3:sz,:)-DG(1:sz-2,:))/(4*dx^2).*(G(3:sz,:)-G(1:sz-2,:)) + DG(2:sz-1,:)*dt/dx^2.*(G(3:sz,:) -2*(G(2:sz-1,:)) + G(1:sz-2,:)) -dx/cell_size*kG(2:sz-1,:).*dt.*G(2:sz-1,:).*D(2:sz-1,:)/2;

    D(2:sz-1,2:sz-1) =  D(2:sz-1,2:sz-1) -dx/cell_size*kG(2:sz-1,2:sz-1).*dt.*D(2:sz-1,2:sz-1).*G(2:sz-1,2:sz-1) + dx/cell_size*kT(2:sz-1,2:sz-1).*dt.*T(2:sz-1,2:sz-1);
    GD(2:sz-1,2:sz-1) =  GD(2:sz-1,2:sz-1) +dx/cell_size*kG(2:sz-1,2:sz-1).*dt.*D(2:sz-1,2:sz-1).*G(2:sz-1,2:sz-1) - dx/cell_size*kO(2:sz-1,2:sz-1).*dt.*GD(2:sz-1,2:sz-1).*O(2:sz-1,2:sz-1) - dx/cell_size*kA(2:sz-1,2:sz-1).*GD(2:sz-1,2:sz-1)*dt;
    T(2:sz-1,2:sz-1) =  T(2:sz-1,2:sz-1) +dx/cell_size*kO(2:sz-1,2:sz-1).*dt.*O(2:sz-1,2:sz-1).*GD(2:sz-1,2:sz-1) - dx/cell_size*kT(2:sz-1,2:sz-1).*dt.*T(2:sz-1,2:sz-1)+ dx/cell_size*kA(2:sz-1,2:sz-1).*GD(2:sz-1,2:sz-1)*dt;

    if(mod(i,100)==0)
		Ot(l,1) =  O(round(sz/2),round(sz/2));
		%Ot(l,2) =  O(round(sz/2),round(sz/2-r+2));
		Gt(l,1) =  G(round(sz/2),round(sz/2));
		%Gt(l,2) =  G(round(sz/2),round(sz/2-r+2));
		Dt(l,1) =  D(round(sz/2),round(sz/2));
		%Dt(l,2) =  D(round(sz/2),round(sz/2-r+2));
		GDt(l,1) =  GD(round(sz/2),round(sz/2));
		%GDt(l,2) =  GD(round(sz/2),round(sz/2-r+2));
		Tt(l,1) =  T(round(sz/2),round(sz/2));
		%Tt(l,2) =  T(round(sz/2),round(sz/2-r+2));
##      kGt(l,1) =  kG(round(sz/2),round(sz/2)).*G(round(sz/2),round(sz/2)).*D(round(sz/2),round(sz/2));
##      kGt(l,2) =  kG(round(sz/2),round(sz/2-r+2)).*G(round(sz/2),round(sz/2-r+2)).*D(round(sz/2),round(sz/2-r+2));
##      kGet(l,1) =  kG_tissue*exp(-T(round(sz/2),round(sz/2))./D(round(sz/2),round(sz/2)));
##      kGet(l,2) =  kG_tissue*exp(-T(round(sz/2),round(sz/2)-r+2)./D(round(sz/2),round(sz/2))-r+2);
##      kOct(l,1) =  kO(round(sz/2),round(sz/2)).*O(round(sz/2),round(sz/2)).*GD(round(sz/2),round(sz/2));
##      kOct(l,2) =  kO(round(sz/2),round(sz/2-r+2)).*O(round(sz/2),round(sz/2-r+2)).*GD(round(sz/2),round(sz/2-r+2));
		l = l+1;
    endif
endfor
toc()

endfunction

%T/D monte fort parce que D chute.
% switch quand (0.017*Tt(:,1)-kGt(:,1)) = 0.017 confirmé.
% donc essayer de voir ce qui se passe si µ est trop haut pour être refranchi et ce que signifie physique le fait que ce seuil soit franchi.
% la prod de [D] suit EXACTEMENT µ[T] jusqu'au seuil.
