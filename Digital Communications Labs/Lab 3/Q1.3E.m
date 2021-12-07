T = (1/1000);
Fs = 200000;
dt = 1/Fs;
t = 0:dt:T-dt;

x = 8*sin(2*pi*1000*t);
y = round(x);
y = rescale(y,-5,5);
x = 5*sin(2*pi*1000*t);
z = x - y;
plot(t,z);
rms(z)

title('Quantization of 1 Period forSinewave');
xlabel('Time(s)');
ylabel('Magnitude');
grid on