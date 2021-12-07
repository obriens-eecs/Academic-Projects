
N = 200;
freq = 1e6;
T = 1/freq;
S = 5*T;
t = 0:(1/N)*S:S;
y = square(2*pi*freq*t,50);

fs = 2e8;
N = 1; 
cutoff_Hz = 1000000;  
[b,a]=butter(N,cutoff_Hz/(fs/2),'low'); 
y_filt = filter(b,a,y);

S = stepinfo(y_filt, 'RisingTimeLimits', [0.3 0.7]);

nfft = 1024;
X = fft(y_filt,nfft);
X = X(1:nfft/2);
mx = abs(X);
f = (0:nfft/2-1)*N/nfft;
plot(f,mx);
title('FFT of Signal Filtered with 1MHz Cutoff');
xlabel('Frequency (Hz)');
ylabel('Power');

