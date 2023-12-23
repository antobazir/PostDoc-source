##%script de test pour reformuler la fonction de conso
close all
x = linspace(0,1,100);

##% row = S, col = O
##figure
##hold on
##yO10 = interp2(linspace(0,1,5),linspace(0,1,5)',[0 0 0 0.5 0.5;0 0 0 0.5 0.5;0 0 0.5 1 1;0 0 0.5 1 1;0 0 0.5 1 1],x,x','cubic')
##mesh(x,x,yO10)
##
##figure
##mesh([0 0 0 0.5 0.5;0 0 0 0.5 0.5;0 0 0.5 1 1;0 0 0.5 1 1;0 0 0.5 1 1])
##%kO = interp2(linspace(0,1,5),linspace(0,1,5)',[0 0 0 0.5 0.5;0 0 0 0.5 0.5;0 0 0.5 1 1;0 0 0.5 1 1;0 0 0.5 1 1],0.5,0.2,'cubic')
##
##%Les lignes donnent les points en conc. de subs croissante pour une conc. d'oxy
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



TsT = rand(3,3)
ToT = rand(3,3)


    Bh = [0 0 0 0.5 0.5;...
0 0 0 0.5 0.5;...
0 0 0.5 1 1;...
0 0 0.5 1 1;...
0 0 0.5 1 1];


[kS_arr,kO_arr] = arrayfun(@cons_map,TsT,ToT);

figure; mesh(x,x',interp2(linspace(0,1,5),linspace(0,1,5)',Bh_S,x,x','cubic'))
hold on;
scatter3(TsT,ToT,kS_arr,'r')

figure; mesh(x,x',interp2(linspace(0,1,5),linspace(0,1,5)',Bh_O,x,x','cubic'))
hold on;
scatter3(TsT,ToT,kO_arr,'r')
