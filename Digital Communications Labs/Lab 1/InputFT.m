N = 200;
freq = 1e6;
T = 1/freq;
S = T;
t = 0:(1/N)*S:S;
%x = square(2*pi*freq*t,50);
x = randn(size(t));
nfft = 1024;
X = fft(x,nfft);
mx = abs(X);
f = (0:nfft-1)*N/nfft;
plot(f,mx);
title('FFT of Gaussian Noise');
xlabel('Frequency (Hz)');
ylabel('Power');
