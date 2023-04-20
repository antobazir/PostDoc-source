A = zeros(5,5);
A(3,3) = 1;
An = A;
A2 = A;

for i = 2:4
	for j = 2:4
		An(i,j) = An(i,j) + (A(i-1,j) -2*A(i,j) + A(i+1,j))/4 + (A(i,j+1) -2*A(i,j) + A(i,j-1))/4
	endfor
endfor

