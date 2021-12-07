
N = 200;
freq = 1e6;
T = 1/freq;
S = 5*T;
t = 0:(1/N)*S:S;
y = square(2*pi*freq*t,50);

fs = 0.2e9;
N = 1; 
cutoff_Hz = 10000000;  
[b,a]=butter(N,cutoff_Hz/(fs/2),'low'); 
y_filt = filter(b,a,y);
G = tf(b,a);
bode(G)

figure;
plot(t,y,t,y_filt);
xlabel('Time (sec)');
ylabel('Amplitude');
ylim([-1 1]);
legend('Raw','Filtered');
title(['1st-Order Filter with Cutoff at 10MHz']);