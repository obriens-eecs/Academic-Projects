X = normrnd(0,50,1,1000);
Y = normrnd(0,50,1,1000);
Z = X + 1i*Y;
Zabs = abs(Z);
Zabs2 = Zabs.^2;

%% Plot of |Z|^2
histogram(Zabs2, 'Normalization', 'probability');
title('PDF of |Z|^2');
xlabel('Recieved Power');
ylabel('Probability');
% Sum the total number of entries in |Z| less than cutoff 50
Cut = sum(Zabs < 50);
m = sum(Zabs)/1000;