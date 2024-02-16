pia = [0 0 1 1 1 1 1 0 0];
N = length(pia)
pif = 1/N*fft(pia,N);

%exp(-j*2*pi*2/9)
%exp(-j*2*pi*3/9)
%exp(-j*2*pi*4/9)
%exp(-j*2*pi*5/9)
%exp(-j*2*pi*6/9)

%exp(-j*2*pi*2/9)+exp(-j*2*pi*3/9)+exp(-j*2*pi*4/9)+exp(-j*2*pi*5/9)+exp(-j*2*pi*6/9)

figure
plot(abs(pif))

