mean = 0;
sigma = 2;
a = 0:0.01:8;

%% Plot |Z|
pdf1 = (a ./ sigma) .* exp( -a.^2 ./ (2 * sigma));
plot(a,pdf1);
title('PDF of |Z|');
xlabel('Envelope of Signal');
ylabel('f(a)');

%% Plot |Z|^2
% pdf2 = (1 / (2 * sigma)) * exp( -a ./ (2 * sigma));
% plot(a,pdf2);
% title('PDF of |Z|^2');
% xlabel('Envelope of Signal');
% ylabel('f(a)');