
%%%% Finesse
figure
hold on;
x=0:0.001:3*pi;
y = 0.1.*sin(x).^2./(1+0.1.*sin(x).^2);
plot(x,y)
y = 1.*sin(x).^2./(1+1.*sin(x).^2);
plot(x,y)
y = 1000.*sin(x).^2./(1+1000.*sin(x).^2);
plot(x,y)
box('on')
ylabel('$R_{FP}$')
xlabel('$4 \pi n l / \lambda $')
[hleg, hleg_obj, hplot, labels] = legend({"F=0.1","F=1","F=1000"})
set(hleg,'unmodified_axes_outerposition',[0 0 380 280])
set(hleg,'unmodified_axes_position',[90 50 250 210])
print (gcf, "/home/antony/Documents/PhD/manuscrit/RFP.pdf", "-dpdflatexstandalone","-S480,360","-FCalibri:11");
system("pdflatex /home/antony/Documents/PhD/manuscrit/RFP");


%%%% sensib
figure
hold on;
x=0:0.01:10;
y = 0.1.*abs(sin(10.*x./pi)./(x./pi))
semilogx(x,y)
##y = abs(sin(10.*x)./(5.*x))
##plot(x,y)
##y = abs(sin(0.2.*x)./(0.4.*x))
##plot(x,y)
box('on')
ylabel('$dI_0/dP_0 ,_{norm} (u.a)$')
xlabel('$f/fc$')
print (gcf, "/home/antony/Documents/PhD/manuscrit/sensib_ac.pdf", "-dpdflatexstandalone","-S480,360","-FCalibri:11");
system("pdflatex /home/antony/Documents/PhD/manuscrit/sensib_ac");

close all
figure
hold on
f = logspace(1,9,100);
M = 1 - 10000000./(1+j.*1e-3.*f).^0.77 + j*1e-3.*f;
loglog(f,f.*imag(M)); 
box('on')
loglog([2e3 2e3],[1e5 1e16],'--','color','black')
loglog([1e7 1e7],[1e5 1e16],'--','color','black')
set(gca,'ytick',[],'yticklabel',[])
set(gca,'xtick',[],'xticklabel',[])
ylabel('Attenuation')
xlabel('Fréquence')
text(1.5e1,1e12,'C-D') ;text(1.5e1,9e10,'Non-relaxé')
text(1e4,1e12,'C-D') ;text(1e4,9e10,'relaxé')
text(3e7,3e7,'Fluide')
print (gcf, "/home/antony/Documents/PhD/manuscrit2/att_plot.pdf", "-dpdflatexstandalone","-S480,360","-FCalibri:11");
system("pdflatex /home/antony/Documents/PhD/manuscrit2/att_plot");
