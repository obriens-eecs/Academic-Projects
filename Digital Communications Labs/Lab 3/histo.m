T = (1/1000);
Fs = 200000;
dt = 1/Fs;
t = 0:dt:T-dt;
x = 5*sawtooth(2*pi*1000*t);

% x1 = 8*sawtooth(2*pi*1000*t);
% y1 = round(x1);
% y1 = rescale(y1,-5,5);
% z1 = x - y1;
% histogram(z1,10);
% 
% x2 = 32*sawtooth(2*pi*1000*t);
% y2 = round(x2);
% y2 = rescale(y2,-5,5);
% z2 = x - y2;
% histogram(z2,10);
% 
% x3 = 128*sawtooth(2*pi*1000*t);
% y3 = round(x3);
% y3 = rescale(y3,-5,5);
% z3 = x - y3;
% histogram(z3,10);

x4 = 512*sawtooth(2*pi*1000*t);
y4 = round(x4);
y4 = rescale(y4,-5,5);
z4 = x - y4;
histogram(z4,10);

title('Frequency of Quantization Error (10bits)');
xlabel('Error Magnitude');
ylabel('Occurences');
grid on