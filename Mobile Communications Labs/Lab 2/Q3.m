X = normrnd(0,1,1,1000);
Y = normrnd(0,1,1,1000);
Z = X + 1i*Y;
Zabs = abs(Z);
Zabs2 = Zabs.^2;

%% Plot of |Z|
histogram(Zabs, 'Normalization', 'probability');
title('Histogram (Distribution) of |Z|');
xlabel('Signal Value');
ylabel('Probability (%)');

%% Plot of |Z|^2
% histogram(Zabs2, 'Normalization', 'probability');
% title('Histogram (Distribution) of |Z|^2');
% xlabel('Signal Value');
% ylabel('Probability (%)');
