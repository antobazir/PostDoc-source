
load('bug_cons_map1')

close all
B;

figure
imagesc(S)
colorbar
figure
imagesc(O)
colorbar
figure
imagesc(kS)
colorbar
figure
imagesc(kO)
colorbar
figure
imagesc(Grid)
figure
imagesc(LD)

figure
imagesc(kS.*LD*0.1*dt)
colorbar
% 9e-3 au centre pour le terme de conso

[kS_2,kO_2] = arrayfun(@cons_map,S,O,B)
 [Bh_S, Bh_O] = behav_f (unique(B));
  %kS_a = interp2 (linspace (0, 1, 5), linspace (0, 1, 5)', Bh_S, S, O, 'cubic');
  kS_a = interp2 (linspace (0, 1, 5), linspace (0, 1, 5)', Bh_S, S(18,18), O(18,18), 'cubic')
  %kO_a = interp2 (linspace (0, 1, 5), linspace (0, 1, 5)', Bh_O, S, O, 'cubic');

load('bug_cons_map2')
figure
imagesc(kS)
colorbar
figure
imagesc(kO)


load('comp_cons_map1')
max(max(kS))


kS_a = interp2 (linspace (0, 1, 5), linspace (0, 1, 5)', Bh_S, S(22,19), O(22,19), 'cubic')
