close all
f = linspace(0,250,101);
f = f(1:100);

H = (1-exp(-4*j*pi.*f/500))./(1- 1.875*exp(-2*j*pi.*f/500) +0.9219*exp(-4*j*pi.*f/500))
H2 = (1)./(1- 1.874*exp(-2*j*pi.*f/500) +0.9218*exp(-4*j*pi.*f/500))

plot(f,abs(H))
hold on
plot(f,abs(H2),'--')

A = [(f/250)' 1/25*abs(H)'];
save('-ascii','module_passebande1.txt','A')
