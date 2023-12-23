## Copyright (C) 2023 antony.bazir
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
## @deftypefn {} {@var{retval} =} cons_map (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: antony.bazir <antonybazir@antonybazir-Latitude-E7450>
## Created: 2023-12-19

function [kS, kO] = cons_map (S, O, B)
  %disp('cons_map')
  [Bh_S, Bh_O] = behav_f (unique(B));
  kS = interp2 (linspace (-0.01, 1.01, 5), linspace (-0.01, 1.01, 5)', Bh_S, S, O, 'cubic');
  kO = interp2 (linspace (-0.01, 1.01, 5), linspace (-0.01, 1.01, 5)', Bh_O, S, O, 'cubic');
endfunction

