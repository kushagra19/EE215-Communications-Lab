clear all;
close all;
t1 = [0:0.01:10];                        %Sampling frequency = 100Hz

fc = input("Carrier Frequency:");
fm = input("Message Frequency:");
%Carrier Signal-
carr = cos(2*pi*fc*t1);
%Message Signal-
msg = cos(2*pi*fm*t1);           
msg_h = imag(hilbert(msg));             %Taking Hilbert transform  
%Modulated Signal-
SSB = msg .* cos(2 * pi * fc * t1) - msg_h .* sin(2 * pi * fc * t1);     

%Taking Fourier Transform of modulated signal-
n = length(SSB);
Y = fft(SSB);
Fam = fftshift(Y);
fshift = (-n/2:n/2-1)*(100/n);          % zero-centered frequency range
freq = abs(Fam);                                                   

%Demodulating Signal-
X = SSB .* cos(2*pi*fc*t1);
demod = lowpass(X,fc/3,100)             %Passing through a lowpass filter

%Taking Fourier Transform of Demodulated signal-
n = length(demod);
Z = fft(demod);
Fam1 = fftshift(Z);
fshift = (-n/2:n/2-1)*(100/n);          % zero-centered frequency range
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
plot(t1, SSB); 
title('SSB Signal'); 
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
