for i=0:8
  eval(['Grid = load("../plots/starv/Grid/Id' num2str(i) '.dat");'])
  Grid_full(i+1,:) = Grid;
endfor
figure
imagesc(Grid_full)

for i=0:8
  eval(['S = load("../plots/starv/S/Id' num2str(i) '.dat");'])
  S_full(i+1,:) = S;
endfor
figure
imagesc(S_full)
figure
plot(S_full(8,:));

for i=0:8
  eval(['Grid = load("../plots/ref/Grid/Id' num2str(i) '.dat");'])
  Grid_full(i+1,:) = Grid;
endfor
figure
imagesc(Grid_full)

for i=0:8
  eval(['S = load("../plots/ref/S/Id' num2str(i) '.dat");'])
  S_full(i+1,:) = S;
endfor
figure
imagesc(S_full)
figure
plot(S_full(8,:));
