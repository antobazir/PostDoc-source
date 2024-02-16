close all
clear all
data = csvread('ECG_Values.csv')
y_vals = interp1(data(:,1),data(:,2),linspace(0,data(632,1),86))
y_vals = -y_vals+110;
x_vals = linspace(0,data(632,1),86)

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

ecg_f1= ecg_f1/36;

%passe haut

%étape  1
for i = 1:length(y_vals)
  if (i<2)
  ecg_f2(i) = ecg_f1(i);
  endif

  if (i>=2&&i<37)
  ecg_f2(i) = ecg_f1(i) + ecg_f2(i-1);
endif


  if (i>=37)
  ecg_f2(i) =  ecg_f1(i) + ecg_f2(i-1) - ecg_f1(i-36);
  endif


endfor

for i = 1:length(y_vals)
  if (i<19)
  ecg_f3(i) = -1/36*ecg_f2(i);
  endif

  if (i>=19)
  ecg_f3(i) = ecg_f1(i-18) -1/36*ecg_f2(i);
endif



endfor

%ecg = y_vals;
for i = 1:length(y_vals)
  if (i<2)
  ecg_f4(i) = -1/32*ecg_f1(i);
  endif

  if (i>=2&&i<17)
  ecg_f4(i) = -1/32*ecg_f1(i) - 1/32*ecg_f4(i-1);
endif

  if (i>=17&&i<33)
    %i-16
  ecg_f4(i) = ecg_f1(i-16) - 1/32*ecg_f1(i) - 1/32*ecg_f4(i-1);
  endif

  if (i>=33)
  ecg_f4(i) = ecg_f1(i-16) - 1/32*ecg_f1(i) - 1/32*ecg_f4(i-1) +1/32*ecg_f1(i-32);
  endif


endfor
figure
hold on
plot(linspace(0,0.43,86),ecg)
plot(linspace(0,0.43,86),ecg_f1)
plot(linspace(0,0.43,86),ecg_f4)

figure
hold on
plot(linspace(0,0.43,86),ecg)
plot(linspace(0,0.43,86),ecg_f1)
plot(linspace(0,0.43,86),ecg_f3)

figure
hold on
plot(linspace(0,0.43,86),ecg_f4)
plot(linspace(0,0.43,86),ecg_f3)

A = [(2.*linspace(0,0.43,86)/0.43)' (ecg_f3/max(ecg_f3))'];
A;
save('-ascii','bp_sig_ECG.txt','A')

%integer version
yvi = int32(y_vals);
%plot(yvi);
iecg = yvi;
for i = 1:length(yvi)
  if (i<2)
  iecg_f1(i) = iecg(i);
  endif

  if (i>=2&&i<3)
  iecg_f1(i) = iecg(i) + 2*iecg_f1(i-1);
endif

  if (i>=3&&i<7)
  iecg_f1(i) = iecg(i) + 2*iecg_f1(i-1)- iecg_f1(i-2);
  endif

  if (i>=7&&i<13)
   iecg_f1(i) = iecg(i) + 2*iecg_f1(i-1)- iecg_f1(i-2) - 2*iecg(i-6);
  endif

    if (i>=13&&i<87)
    iecg_f1(i) = iecg(i) + 2*iecg_f1(i-1)- iecg_f1(i-2) - 2*iecg(i-6) + iecg(i-12);
  endif
endfor

for i = 1:length(yvi)
  if (i<2)
  iecg_f4(i) = -1/32*iecg_f1(i);
  endif

  if (i>=2&&i<17)
  iecg_f4(i) = -1/32*iecg_f1(i) - 1/32*iecg_f4(i-1);
endif

  if (i>=17&&i<33)
    %i-16
  iecg_f4(i) = iecg_f1(i-16) - 1/32*iecg_f1(i) - 1/32*iecg_f4(i-1);
  endif

  if (i>=33)
  iecg_f4(i) = iecg_f1(i-16) - 1/32*iecg_f1(i) - 1/32*iecg_f4(i-1) +1/32*iecg_f1(i-32);
  endif

endfor

figure
hold on
plot(linspace(0,0.43,86),ecg_f4)
plot(linspace(0,0.43,86),iecg_f4)


