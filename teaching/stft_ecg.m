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

b(:,1)= b(:,1)/100
b(:,2)= b(:,2)/20
save("ecg_1.txt","b")

clear fb

wlen =5;
for n =1:floor(size(b,1)/wlen)
  fb(:,n) = fft(b((1+(n-1)*wlen):((n)*wlen),2),100);
endfor
figure
plot(abs(fb(:,28)))
figure
imagesc(abs(fb))

clear fb
wlen =10;
for n =1:floor(size(b,1)/wlen)
  fb(:,n) = fft(b((1+(n-1)*wlen):((n)*wlen),2),100);
endfor
figure
plot(abs(fb(:,4)))
figure
imagesc(abs(fb))

figure
clear fb
wlen =15;
for n =1:floor(size(b,1)/wlen)
  fb(:,n) = fft(b((1+(n-1)*wlen):((n)*wlen),2),100);
endfor
figure
plot(abs(fb(:,3)))
figure
imagesc(abs(fb))

