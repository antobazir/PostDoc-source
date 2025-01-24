clear all
a = load('ecg_cords.txt');

sortrows(a,1)
[y,i] = unique(a(:,1));
figure
scatter(a(:,1),a(:,2))
j=1;
for i=min(a(:,1)):max(a(:,1))
    b(j,1)=i;
    b(j,2) = mean(a(find(a(:,1)==i),2));
    j++;
endfor

figure
plot(b(:,1),b(:,2))

close all
figure
plot(movmean(b(:,2),112))

figure
plot(b(:,1),b(:,2)-movmean(b(:,2),112))

c = b(:,2)-movmean(b(:,2),112);%corrected signal

b1*y-1 - b2*y-2 + x - x-2
%Entree
d(1) = c(1);
d(2) = 1.875*d(1) + c(2);
d(3) = 1.875*d(2) - 0.9219*d(1) + c(3) -c(1);

for n=3:length(c)
  d(n) = 1.875*d(n-1) - 0.9219*d(n-2) + c(n) -c(n-2);
endfor

figure
hold on
plot(c)
plot(d)

e(:,1)= 2*b(:,1)/max(b(:,1));
e(:,2)= d/max(d);
save("ecg_tompkins.txt","e")


f(:,1)= 2*b(:,1)/max(b(:,1));
f(:,2)= c/max(c)+0.2;
save("x_ecg_tompkins.txt","f")
