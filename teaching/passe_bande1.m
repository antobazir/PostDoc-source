close all
clear all
f = linspace(0,250,101);
f = f(1:100);

H = (1-exp(-4*j*pi.*f/500))./(1- 1.875*exp(-2*j*pi.*f/500) +0.9219*exp(-4*j*pi.*f/500))
H2 = (1)./(1- 1.874*exp(-2*j*pi.*f/500) +0.9218*exp(-4*j*pi.*f/500))

plot(f,abs(H))
hold on
plot(f,abs(H2),'--')

figure
plot(f,angle(H))

A = [(f/250)' 1/25*abs(H)'];
save('-ascii','module_passebande1.txt','A')


A = [(f/250)' 1/3*angle(H)'];
save('-ascii','argument_passebande1.txt','A')

f = linspace(0,100,101);
f = f(1:100);

H = (1-exp(-12*j*pi.*f/200)).^2./(1- exp(-2*j*pi.*f/200)).^2;
figure
plot(f,abs(H))
figure
plot(f,angle(H))

A = [(f/100)' 1/36*abs(H)'];
A = A(2:100,:);
save('-ascii','module_passebas.txt','A')

A = [(f/100)' (angle(H)/pi/2)'];
A = A(2:100,:);
save('-ascii','argument_passebas.txt','A')

f = linspace(0,100,101);
f = f(1:100);

H =  exp(-36*j*pi.*f/200) - 1/32*(1-exp(-72*j*pi.*f/200)).^1./(1- exp(-2*j*pi.*f/200)).^1;
figure
plot(f,abs(H))
figure
plot(f,angle(H))

A = [(f/100)' abs(H)'];
A = A(2:100,:);
save('-ascii','module_passehaut.txt','A')

A = [(f/100)' (angle(H)/pi/2)'];
A = A(2:100,:);
save('-ascii','argument_passehaut.txt','A')



f = linspace(0,100,101);
f = f(1:100);

H = ((1-exp(-12*j*pi.*f/200)).^2./(1- exp(-2*j*pi.*f/200)).^2).*(exp(-36*j*pi.*f/200) - 1/36*(1-exp(-72*j*pi.*f/200)).^1./(1- exp(-2*j*pi.*f/200)).^1);
figure
plot(f,abs(H))
figure
plot(f,angle(H))

A = [(f/100)' 1/63*abs(H)'];
A = A(2:100,:);
save('-ascii','module_passebande.txt','A')

A = [(f/100)' (angle(H)/pi/2)'];
A = A(2:100,:);
save('-ascii','argument_passebande.txt','A')


data = csvread('ECG_Values.csv')
y_vals = interp1(data(:,1),data(:,2),linspace(0,data(632,1),87))
y_vals = -y_vals+110;
x_vals = linspace(0,data(632,1),87)
f = linspace(0,200,201);
f = f(1:200);

A = [(2*x_vals/max(x_vals))' (y_vals/max(y_vals))'];
A;
save('-ascii','signal_ECG.txt','A')

ECG = abs(fft(y_vals,100));
figure
plot(f(1:100),ECG(1:100)/max(ECG))
A = [(2*f(1:100)/max(f(1:100)))' (ECG(1:100)/max(ECG))'];
A;
save('-ascii','module_ECG.txt','A')


f = linspace(0,200,176);
f = f(1:175);
H = ((1-exp(-12*j*pi.*f/200)).^2./(1- exp(-2*j*pi.*f/200)).^2).*(exp(-32*j*pi.*f/200) - 1/32*(1-exp(-64*j*pi.*f/200)).^1./(1- exp(-2*j*pi.*f/200)).^1);
H(1) = 1-1/36
ECG = fft(y_vals,175);
%ECG_PB = H(2:87).*ECG(2:87);
ECG_PB = H.*ECG;
figure
%plot(f,abs(ECG_PB)/max(abs(ECG_PB)))
plot(abs(ECG_PB)/max(abs(ECG_PB)))

f = linspace(0,200,88);
f = f(1:87);
H = ((1-exp(-12*j*pi.*f/200)).^2./(1- exp(-2*j*pi.*f/200)).^2).*(exp(-32*j*pi.*f/200) - 1/32*(1-exp(-64*j*pi.*f/200)).^1./(1- exp(-2*j*pi.*f/200)).^1);
H(1) = 1-1/32
figure
ht = real(ifft(H))
hpb = conv(y_vals,fliplr(ht),"same")
plot(hpb)

figure
hold on
plot(real(ifft(ECG_PB)))
plot(hpb)
plot(imag(ifft(ECG_PB)))
A = [(2.*linspace(0,0.43,87)/0.43)' (real(ifft(ECG_PB(1:87)))/1505)'];
A;
%save('-ascii','bp_sig_ECG.txt','A')

