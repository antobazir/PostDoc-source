close all
clear all
data = csvread('ECG_Values.csv')
y_vals = interp1(data(:,1),data(:,2),linspace(0,data(632,1),86))
y_vals = -y_vals+110;
x_vals = linspace(0,data(632,1),86)

f = linspace(0,200,176);
f = f(1:175);
H = ((1-exp(-12*j*pi.*f/200)).^2./(1- exp(-2*j*pi.*f/200)).^2).*(exp(-32*j*pi.*f/200) - 1/32*(1-exp(-64*j*pi.*f/200)).^1./(1- exp(-2*j*pi.*f/200)).^1);
H(1) = 1-1/32
ECG = fft(y_vals,175);
%ECG_PB = H(2:87).*ECG(2:87);
ECG_PB = H.*ECG;
%figure
%plot(f,abs(ECG_PB)/max(abs(ECG_PB)))
%plot(abs(ECG_PB)/max(abs(ECG_PB)))

f = linspace(0,200,87);
f = f(1:86);
H = ((1-exp(-12*j*pi.*f/200)).^2./(1- exp(-2*j*pi.*f/200)).^2).*(exp(-32*j*pi.*f/200) - 1/32*(1-exp(-64*j*pi.*f/200)).^1./(1- exp(-2*j*pi.*f/200)).^1);
H(1) = 1-1/32
%figure
ht = real(ifft(H))
hpb = conv(y_vals(1:86),fliplr(ht),"same")
%plot(hpb)

%eq° diff
%passe bas
ecg = y_vals;
for i = 1:length(y_vals)
  if (i<2)
  ecg_f1(i) = ecg(i);
  endif

  if (i>=2&&i<3)
  ecg_f1(i) = ecg(i) + 2*ecg_f1(i-1);
endif

  if (i>=3&&i<7)
  ecg_f1(i) = ecg(i) + 2*ecg_f1(i-1)- ecg_f1(i-2);
  endif

  if (i>=7&&i<13)
    ecg_f1(i) = ecg(i) + 2*ecg_f1(i-1)- ecg_f1(i-2) - 2*ecg(i-6);
  endif

    if (i>=13&&i<87)
    ecg_f1(i) = ecg(i) + 2*ecg_f1(i-1)- ecg_f1(i-2) - 2*ecg(i-6) + ecg(i-12);
  endif


endfor

%passe haut

%ecg = y_vals;
for i = 1:length(y_vals)
  if (i<2)
  ecg_f2(i) = -1/32*ecg_f1(i);
  endif

  if (i>=2&&i<17)
  ecg_f2(i) = -1/32*ecg_f1(i) - 1/32*ecg_f2(i-1);
endif

  if (i>=17&&i<33)
    i-16
  ecg_f2(i) = ecg_f1(i-16) - 1/32*ecg_f1(i) - 1/32*ecg_f2(i-1);
  endif

  if (i>=33)
  ecg_f2(i) = ecg_f1(i-16) - 1/32*ecg_f1(i) - 1/32*ecg_f2(i-1) +1/32*ecg_f1(i-32);
  endif


endfor
figure
hold on
plot(linspace(0,0.43,86),ecg)
plot(linspace(0,0.43,86),ecg_f1)
plot(linspace(0,0.43,86),ecg_f2)

%signaux temporels
figure
hold on
plot(real(ifft(ECG_PB)))
plot(hpb)
%plot(imag(ifft(ECG_PB)))
plot(ecg_f2)
A = [(2.*linspace(0,0.43,86)/0.43)' (real(ifft(ECG_PB(1:86)))/1505)'];
A;
save('-ascii','bp_sig_ECG.txt','A')

##
####%spectre
##figure
##hold on
####
####f2 = linspace(0,200,501);
####f2 = f2(1:500);
####
####H2 = ((1-exp(-12*j*pi.*f2/200)).^2./(1- exp(-2*j*pi.*f2/200)).^2).*(exp(-32*j*pi.*f2/200) - 1/32*(1-exp(-64*j*pi.*f2/200)).^1./(1- exp(-2*j*pi.*f2/200)).^1);
####H2(1) = 1-1/32
##
##%plot(abs(H2.*fft(ecg,500))/max(abs(fft(H2.*fft(ecg,500)))))
##%plot(abs(H2.*fft(ecg,500))/20000)
##plot(abs(fft(ecg_f2,500))/max(abs(fft(ecg_f2))))
##plot(abs(fft(hpb,500))/max(abs(fft(hpb))))
