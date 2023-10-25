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
## @deftypefn {} {@var{retval} =} shedding_metvar (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: antony <antony.bazir@antony-Latitude-E7450>
## Created: 2023-10-22

function [Grid,kO,kS,kP,DSm,DOm,DPm,state] = shedding_metvar(Grid,state,kO,kS,kP,DOm,DSm,DPm,DS_med,DP_med,shed_prob)

	%On définit le périmètre.
	perim = im2double(bwperim(Grid));

	% On tire une variable aléatoire dans une distrib normal pour chaque cellule de la périph
	shed_real_perim = rand(size(Grid,1),size(Grid,2)).*perim;

	% trouver les cellules sous la limite
	shed_grid = and(shed_real_perim<shed_prob,shed_real_perim!=0);
	idx_real = find(shed_grid);

	removed = length(idx_real)

	% on met le vecteur d'état à jour
	state(Grid(idx_real),2)=-2;
	Grid(idx_real)= 0; %On retire les cellules concernées de la grille

	%setting consumption to zero
	kS(idx_real) =  0;
	kP(idx_real) =  0;
	kO(idx_real) =  0;

	%setting diffusion to medium value
	DOm(idx_real) = 1;
	DSm(idx_real) = DS_med;
	DPm(idx_real) = DP_med;
endfunction
