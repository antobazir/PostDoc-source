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
## @deftypefn {} {@var{retval} =} behav_cc (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: antony.bazir <antonybazir@antonybazir-Latitude-E7450>
## Created: 2023-12-21

function state = compute_cc(k,Grid,state,S,O,n_min,beh_val)
    Bh_Cc =  behav_f(beh_val);
    norm_prolif = interp2 (linspace (-0.01, 1.01, 5), linspace (-0.01, 1.01, 5)', Bh_Cc, S(Grid==k), O(Grid==k), 'cubic');
    state(k,2)=n_min.*norm_prolif;
endfunction
