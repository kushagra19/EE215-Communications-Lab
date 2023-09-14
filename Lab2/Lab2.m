clear all;
close all;

fs = 1000;                                   %Sampling frequency = 100Hz
fc = 200;
kf = 1;

t1 = [0:1/fs:0.2];                          

msg = sin(2*pi*30*t1)+2*sin(2*pi*60*t1);                     %message

%Modulation using FM-
 int_msg = cumsum(msg)/fs;
 mod_fm = cos(2*pi*fc*t1 + 2*pi*kf*int_msg);

%Taking Fourier Transform of modulated signal-
n = length(mod_fm);
Y = fft(mod_fm);
Fam = fftshift(Y);
fshift = (-n/2:n/2-1)*(fs/n);              % zero-centered frequency range
freq = abs(Fam);      

dif_mod = diff(mod_fm)*fs;
env = envelope(dif_mod);
env1 = env - mean(env);
demod = env1;
t2 = [1/fs:1/fs:0.2];

%Plotting Original signal-
figure(2);

subplot(1,1,1) 
plot(t1, msg); 
title('Modulated Signal'); 
xlabel('Time'); 
ylabel('Amplitude'); 
grid on;


%Plotting modulated signal-
figure(3);

subplot(2,1,1) 
plot(t1, mod_fm); 
title('Modulated Signal'); 
xlabel('Time'); 
ylabel('Amplitude'); 
grid on;

subplot(2,1,2) 
plot(fshift, freq); 
title('Magnitude spectrum'); 
xlabel('frequency'); 
ylabel('Magnitude'); 
grid on;

%Plotting demodulated signal-
figure(4);

subplot(1,1,1) 
plot(t2, demod); 
title('Demodulated Signal'); 
xlabel('Time'); 
ylabel('Amplitude'); 
grid on;




