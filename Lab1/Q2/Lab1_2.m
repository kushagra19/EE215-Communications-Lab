clear all;
close all;
t1 = [0:0.01:10];                   %Sampling frequency = 100Hz

fc = input("Carrier Frequency:");
Ac = input("Carrier Amplitude:");
% Carrier Signal
carr = Ac*cos(2*pi*fc*t1);          
fm = input("Message Frequency:");
%Message Signal
msg = cos(2*pi*fm*t1);
% DSB-SC is Modulated signal
DSB_SC = msg.*carr;                 

%Taking Fourier Transform of modulated signal-
n = length(DSB_SC);
Y = fft(DSB_SC);
Fam = fftshift(Y);
fshift = (-n/2:n/2-1)*(100/n);      % zero-centered frequency range
freq = abs(Fam);

%Demodulating Signal
X = DSB_SC .* cos(2*pi*fc*t1);
demod = lowpass(X,fc/3,100)         %Passing through a lowpass filter

%Taking Fourier Transform of Demodulated signal-
n = length(demod);
Z = fft(demod);
Fam1 = fftshift(Z);
fshift = (-n/2:n/2-1)*(100/n);      % zero-centered frequency range
freq1 = abs(Fam1);

%Plotting initial signals-
figure(1);
subplot(2,1,1) 
plot(t1, msg); 
title('Original Signal'); 
xlabel('Time'); 
ylabel('Amplitude'); 
grid on;
subplot(2,1,2) 
plot(t1, carr); 
title('Carrier Signal'); 
xlabel('Time'); 
ylabel('Amplitude'); 
grid on;

%Plotting Modulated signal-
figure(2);
subplot(2,1,1) 
plot(t1, DSB_SC); 
title('DSB-SC signal'); 
xlabel('Time'); 
ylabel('Amplitude'); 
grid on;
subplot(2,1,2) 
plot(fshift, freq); 
title('Magnitude spectrum'); 
xlabel('frequency'); 
ylabel('Magnitude'); 
grid on;

%Plotting Demodulated signal-
figure(3);
subplot(2,1,1) 
plot(t1, msg); 
title('Demodulated Signal'); 
xlabel('Time'); 
ylabel('Amplitude'); 
grid on;
subplot(2,1,2) 
plot(fshift, freq1); 
title('Magnitude spectrum'); 
xlabel('frequency'); 
ylabel('Magnitude'); 
grid on;

