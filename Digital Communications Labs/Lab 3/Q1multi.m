T = (1/1000);
Fs = 200000;
dt = 1/Fs;
t = 0:dt:T-dt;
x = 5*sawtooth(2*pi*1000*t);

x1 = 8*sawtooth(2*pi*1000*t);
y1 = round(x1);
y1 = rescale(y1,-5,5);
z1 = x - y1;
hold on
plot(t,z1,'b');
rms(z1)

x2 = 32*sawtooth(2*pi*1000*t);
y2 = round(x2);
y2 = rescale(y2,-5,5);
z2 = x - y2;
plot(t,z2,'g');
hold on
rms(z2)

x3 = 128*sawtooth(2*pi*1000*t);
y3 = round(x3);
y3 = rescale(y3,-5,5);
z3 = x - y3;
plot(t,z3,'y');
hold on
rms(z3)

x4 = 512*sawtooth(2*pi*1000*t);
y4 = round(x4);
y4 = rescale(y4,-5,5);
z4 = x - y4;
plot(t,z4,'r');
rms(z4)

title('Quantization Error for Different Resolutions');
legend('4bits','6bits','8bits','10bits');
xlabel('Time (s)');
ylabel('Difference between Unquantized and Quantized');
grid on
