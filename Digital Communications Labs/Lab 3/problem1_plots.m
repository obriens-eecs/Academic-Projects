f = 1000;                       % 1-kHz frequency
T = 2*(1/1000);
Fs = 200000;
dt = 1/Fs;
t = 0:dt:T-dt;
input = 5*sawtooth(2*pi*f*t);
sig = round(8*sawtooth(2*pi*f*t));
sig = rescale(sig,-5,5);
plot(t,sig,'k','LineWidth',2);
grid;
set(gca,'Xscale','linear','FontSize',12,'MinorGridLineStyle','none');
xlabel('$time$ [s]','Interpreter','latex','FontSize',14,...
    'FontName','times','Units','Normalized','Position',[0.5,-0.07],...
    'FontName','times-roman');
ylabel('Amplitude','Interpreter','latex','FontSize',14,...
    'FontName','times','Units','Normalized','Position',[-0.08,0.5],...
    'FontName','times-roman');
title('output from the quantizer');

s = size(sig);
signal = zeros(1,s(2));
for i = 1:s(2)
    signal(i) = abs(input(i) - sig(i));
end

rms_signal = rms(signal)

