clear all;
close all;
t1 = [0:0.01:10];                          %Sampling frequency = 100Hz

%Taking input from user and initializing variables-
fc = input("Carrier Frequency:");
Ac = input("Carrier Amplitude:");
                               
carr = Ac*cos(2*pi*fc*t1);                  %carrier signal
amod = input("Modulation index:");
fm = input("Message Frequency:");
msg = cos(2*pi*fm*t1);                      %message

%Modulation using conventional AM-
AM = Ac*(1 + amod*msg).*carr;   

%Taking Fourier Transform of modulated signal-
n = length(AM);
Y = fft(AM);
Fam = fftshift(Y);
fshift = (-n/2:n/2-1)*(100/n);              % zero-centered frequency range
freq = abs(Fam);                    

%Demodulation of AM signal
demod = envelope(AM,1,'peak')-Ac;

%Taking Fourier Transform of Demodulated signal-
n1 = length(demod);
X = fft(demod);
Fam = fftshift(X);
fshift = (-n1/2:n1/2-1)*(100/n1);           % zero-centered frequency range
freq1 = abs(Fam); 

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
plot(t1, AM); 
title('AM Signal'); 
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
plot(t1, demod); 
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


