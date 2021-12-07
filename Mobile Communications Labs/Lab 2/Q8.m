a = 0:1:12;
X = normrnd(0,1,1,1000);
Y = normrnd(0,1,1,1000);
Z = X + 1i*Y;
Zabs = abs(Z);
% ZabsRice = Zabs + Zabs;
% ZabsRice = Zabs + Zabs * 10;
 ZabsRice = Zabs + Zabs * 20;
%% Plot of |Z|
histogram(ZabsRice, 'Normalization', 'probability');
title('Histogram of Rician Distribution of |Z| (K=20)');
xlabel('Signal Value');
ylabel('Probability (%)');
