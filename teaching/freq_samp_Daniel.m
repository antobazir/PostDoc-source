clear all
close all
Hk = [1 1 1 0 0 0 0 1 1];
%Hk = [1 1 1 0 0 0 0 0 0];
N=length(Hk);

hi = ifft(Hk)
figure; hold on
plot(real(hi),'x-')
%hi_prime = [hi(6:9) hi(1:5)]'
%plot(real(hi_prime))

figure; hold on;
plot(linspace(0,1,251),abs(fft(hi,251)))
stem((0:N-1).*1/N,Hk)
f = linspace(0,1,251);

%k = [0 0 1 1 1 1 1 0 0];
for k=1:N
  Hf(k,:) = Hk(k)*sin(pi*N.*(f-(k-1)/N))./(N*sin(pi*(f-(k-1)/N)));
endfor
%plot(linspace(0,1,251),abs(fft(hi_prime,251)),'b')

plot(linspace(0,1,251),abs(sum(Hf,1)))

(0:N-1).*1/N
