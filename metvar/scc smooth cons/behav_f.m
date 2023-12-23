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
## @deftypefn {} {@var{retval} =} behav_f (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: antony.bazir <antonybazir@antonybazir-Latitude-E7450>
## Created: 2023-12-19
%19/12 this function handles the selection of behavior maps
function [Bh_S,Bh_O] = behav_f (beh_mat)
  switch(beh_mat)
    case 0 %test
      % S = 0 | S = 0.25 | S = 0.5 | S = 0.75 | S = 1
      Bh_S = [0 0 0 0.5 0.5;...  %O = 0
      0 0 0 0.5 0.5;...          %O = 0.25
      0 0 0.5 1 1;...            %O = 0.5
      0 0 0.5 1 1;...            %O = 0.75
      0 0 0.5 1 1];              %O = 1

      % S = 0 | S = 0.25 | S = 0.5 | S = 0.75 | S = 1
      Bh_O = [0 0 0 0.3 0.3;...  %O = 0
      0 0 0 0.3 0.3;...          %O = 0.25
      0 0 0.3 1 1;...            %O = 0.5
      0 0 0.3 1 1;...            %O = 0.75
      0 0 0.3 1 1];              %O = 1

            % S = 0 | S = 0.25 | S = 0.5 | S = 0.75 | S = 1
      Bh_Cc = [1 1 1 1 1;...  %O = 0
      1 1 1 1 1;...          %O = 0.25
      1 1 1 1 1;...            %O = 0.5
      1 1 1 1 1;...            %O = 0.75
      1 1 1 1 1];              %O = 1

      case 1 %ref
      % S = 0 | S = 0.25 | S = 0.5 | S = 0.75 | S = 1
      Bh_S = [0 1 1 1 1;...  %O = 0
      0 1 1 1 1;...          %O = 0.25
      0 1 1 1 1;...            %O = 0.5
      0 1 1 1 1;...            %O = 0.75
      0 1 1 1 1];              %O = 1

      % S = 0 | S = 0.25 | S = 0.5 | S = 0.75 | S = 1
      Bh_O = [0 1 1 1 1;...  %O = 0
      0 1 1 1 1;...          %O = 0.25
      0 1 1 1 1;...            %O = 0.5
      0 1 1 1 1;...            %O = 0.75
      0 1 1 1 1];              %O = 1

                  % S = 0 | S = 0.25 | S = 0.5 | S = 0.75 | S = 1
      Bh_Cc = [1 1 1 1 1;...  %O = 0
      1 1 1 1 1;...          %O = 0.25
      1 1 1 1 1;...            %O = 0.5
      1 1 1 1 1;...            %O = 0.75
      1 1 1 1 1];              %O = 1

      case 2 %starv
            % S = 0 | S = 0.25 | S = 0.5 | S = 0.75 | S = 1
      Bh_S = [0 0 1 1 1;...  %O = 0
      0 0 1 1 1;...          %O = 0.25
      0 0 1 1 1;...            %O = 0.5
      0 0 1 1 1;...            %O = 0.75
      0 0 1 1 1];              %O = 1

      % S = 0 | S = 0.25 | S = 0.5 | S = 0.75 | S = 1
      Bh_O = [0 0 1 1 1;...  %O = 0
      0 0 1 1 1;...          %O = 0.25
      0 0 1 1 1;...            %O = 0.5
      0 0 1 1 1;...            %O = 0.75
      0 0 1 1 1];              %O = 1

      %le cycle cellulaire rallonge VITE si on les nutriments sont trop bas
      % S = 0 | S = 0.25 | S = 0.5 | S = 0.75 | S = 1
      Bh_Cc = [100 1 1 1 1;...  %O = 0
      100 1 1 1 1;...          %O = 0.25
      100 1 1 1 1;...            %O = 0.5
      100 1 1 1 1;...            %O = 0.75
      100 1 1 1 1];              %O = 1

      case 3 %savy
            % S = 0 | S = 0.25 | S = 0.5 | S = 0.75 | S = 1
      Bh_S = [0 0 0.3 1 1;...  %O = 0
      0 0 0.3 1 1;...          %O = 0.25
      0 0 0.3 1 1;...            %O = 0.5
      0 0 0.3 1 1;...            %O = 0.75
      0 0 0.3 1 1];              %O = 1

      % S = 0 | S = 0.25 | S = 0.5 | S = 0.75 | S = 1
      Bh_O = [0 0 0.3 1 1;...  %O = 0
      0 0 0.3 1 1;...          %O = 0.25
      0 0 0.3 1 1;...            %O = 0.5
      0 0 0.3 1 1;...            %O = 0.75
      0 0 0.3 1 1];              %O = 1

       %le cycle cellulaire rallonge VITE si on les nutriments sont trop bas
      % S = 0 | S = 0.25 | S = 0.5 | S = 0.75 | S = 1
      Bh_Cc = [100 100 10 1 1;...  %O = 0
      100 100 10 1 1;...          %O = 0.25
      100 100 10 1 1;...            %O = 0.5
      100 100 10 1 1;...            %O = 0.75
      100 100 10 1 1];              %O = 1

      case 4 %comprol
      % S = 0 | S = 0.25 | S = 0.5 | S = 0.75 | S = 1
      Bh_S = [0 0 0.3 1 1;...  %O = 0
      0 0 0.3 1 1;...          %O = 0.25
      0 0 0.3 1 1;...            %O = 0.5
      0 0 0.3 1 1;...            %O = 0.75
      0 0 0.3 1 1];              %O = 1

      % S = 0 | S = 0.25 | S = 0.5 | S = 0.75 | S = 1
      Bh_O = [0 0 0.3 1 1;...  %O = 0
      0 0 0.3 1 1;...          %O = 0.25
      0 0 2 1 1;...            %O = 0.5
      0 0 2 1 1;...            %O = 0.75
      0 0 2 1 1];              %O = 1

       %le cycle cellulaire rallonge VITE si on les nutriments sont trop bas
      % S = 0 | S = 0.25 | S = 0.5 | S = 0.75 | S = 1
      Bh_Cc = [100 100 10 1 1;...  %O = 0
      100 100 10 1 1;...          %O = 0.25
      100 100 1 1 1;...            %O = 0.5
      100 100 1 1 1;...            %O = 0.75
      100 100 1 1 1];              %O = 1


  endswitch

endfunction
