close all;
clear;
clc;

%msg signal
num = 20000;
const = exp(1i*2*pi.*[0,1]/2);
msg = randi([0,1],num,1);

%BPSK modulation
BPSK = (msg==0)*(-1)+(msg==1)*(1);

ebnodb = -10:10;
number_snrs = length(ebnodb);
perr_est = zeros(number_snrs,1);

for n=1:number_snrs
    sigma = sqrt(1/(2*(10^(ebnodb(n)/10))));
    w = sigma*randn(num,1)+1i*sigma*randn(num,1);  %Random 2D gaussian noise generation
    r = BPSK+w;           %Received signal
    decisions=zeros(num,1);
    for k=1:num 
        distances = abs(r(k)-const);
        [min_dist,decisions(k)] = min(distances); 
        demod=(decisions==1)*(1);
    end

errors = (demod ~= msg);
perr_est(n) = sum(errors)/num;
end


semilogy(ebnodb,perr_est); % plotting error from simulation
hold on;
%COMPARE WITH THEORETICAL VALUES USING EQUATION BASED ON Q-Func
snro = 10.^(ebnodb/10); % raw SNR values
perr_th = qfunc(sqrt(2*snro)); % theoretical error
semilogy(ebnodb,perr_th,':r'); % plotting theoretical error
xlabel('Eb/N0 (dB)');
ylabel('Symbol error probability');
legend('Simulation','Theoritical Value','Location','NorthEast');
hold off;