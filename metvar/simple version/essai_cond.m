%voir si le calcul des conditions ne met pas dedans

a = [0 0 1;0 1 0; 1 0 0]
b = [0 0 0; 0 0 0; 1 0 0]

cond =  and(a,b)

b = [0 0 0; 0 0 0; 0 0 0]

cond
