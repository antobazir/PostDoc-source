%script freq_samp
close all
Hk = [1 1 1 0.5 0 0 0 0 0 0 0.5 1 1];
N = length(Hk)

hi = ifft(Hk)
figure; hold on
plot(hi)
%hi_prime = [hi(8:13) hi(1:7)]'
%plot(hi_prime)

figure; hold on;
plot(linspace(0,1,251),abs(fft(hi,251)));
hi_zp = [hi(1:round(N/2)) zeros(1,251-length(hi)) hi(round(N/2)+1:N)];
stem((0:(N-1))./N,Hk)
plot(linspace(0,1,251),abs(fft(hi_zp)),'x-')
plot(linspace(0,1,251),abs(interpft(Hk,251)),'+-')

%vérif interpolation
##figure; hold on;
##for k=1:N
##  Hf(k,:) = Hk(k)*sin(pi*N.*(f-(k-1)/N))./(N*sin(pi*(f-(k-1)/N)));
##endfor
##plot(linspace(0,1,251),abs(sum(Hf,1)))
##
##figure
##plot(linspace(0,1,251),arg(fft(hi_zp)),'x-')


x = linspace(-2,2,251)'
y = abs(fft(hi_zp,251))';
A = [x [y(126:251); y(1:125)]];
save('-ascii','module_freq_samp.txt','A')
y = arg(fft(hi_zp,251))';
A = [x [y(126:251); y(1:125)]./(pi)];
save('-ascii','arg_freq_samp.txt','A')



%close all
Hk = [1 1 1 0.1 0 0 0 0 0 0 0.1 1 1];
N = length(Hk)

hi = ifft(Hk)
figure; hold on
plot(hi)
%hi_prime = [hi(8:13) hi(1:7)]'
%plot(hi_prime)

figure; hold on;
plot(linspace(0,1,251),abs(fft(hi,251)));
hi_zp = [hi(1:round(N/2)) zeros(1,251-length(hi)) hi(round(N/2)+1:N)];
stem((0:(N-1))./N,Hk)
plot(linspace(0,1,251),abs(fft(hi_zp)),'x-')
plot(linspace(0,1,251),abs(interpft(Hk,251)),'+-')

x = linspace(-2,2,251)'
y = abs(fft(hi_zp,251))';
A = [x [y(126:251); y(1:125)]];
save('-ascii','module_freq_samp2.txt','A')
y = arg(fft(hi_zp,251))';
A = [x [y(126:251); y(1:125)]./(pi)];
save('-ascii','arg_freq_samp2.txt','A')



%close all
Hk = [1 1 1 1 0.7 0.5 0.1 0 0 0 0 0 0 0.1 0.5 0.7 1 1 1];
N = length(Hk)

hi = ifft(Hk)
figure; hold on
plot(hi)
%hi_prime = [hi(8:13) hi(1:7)]'
%plot(hi_prime)

figure; hold on;
plot(linspace(0,1,251),abs(fft(hi,251)));
hi_zp = [hi(1:round(N/2)) zeros(1,251-length(hi)) hi(round(N/2)+1:N)];
stem((0:(N-1))./N,Hk)
plot(linspace(0,1,251),abs(fft(hi_zp)),'x-')
plot(linspace(0,1,251),abs(interpft(Hk,251)),'+-')

x = linspace(-2,2,251)'
y = abs(fft(hi_zp,251))';
A = [x [y(126:251); y(1:125)]];
save('-ascii','module_freq_samp3.txt','A')
y = arg(fft(hi_zp,251))';
A = [x [y(126:251); y(1:125)]./(pi)];
save('-ascii','arg_freq_samp3.txt','A')

