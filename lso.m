clear all
fvdp = @(y,t) [y(2); (1 - y(1)^2) * y(2) - y(1)];
t = linspace (0, 20, 100);
y = lsode (fvdp, [2; 0], t);
