% script pour les courbes de la synthèse de filtres num recursif
a = 10 %-> 10 Hz
f = linspace(0,10,100)
H = 1./(j*2*pi*f+a); %fonction de trasnfert
plot(f,arg(H))
hold on




%filtre num - on explore les 3 régime pour a*Te
a = 10
f = linspace(0,1,50)
H = 1./(1- exp(-j*2*pi.*f)+a)
plot(f,arg(H))
hold on
##a = 1
##H2 = 1./(1- exp(-j*2*pi.*f)+a)
##plot(f,arg(H2))
a = 0.1
H3 = 1./(1- exp(-j*2*pi.*f)+a)
plot(f,arg(H3))
f2 = linspace(-1,1,50)
plot(f,-atan((-sin(2*pi.*f))./(1-cos(2*pi.*f)+a)))


% passe haut
f = linspace(0,10,100)
H = j*2*pi*f./(j*2*pi*f+0.1); %fonction de trasnfert
plot(f,abs(H))


f = linspace(0,1,50)
H = (1- exp(-j*2*pi.*f))./(1- exp(-j*2*pi.*f)+10)
plot(f,abs(H))
