num = 1000;
n = [1:num];
% N = 5;
% N = 10;
 N = 20;
f0 = 1000000;
ai = rand(1, N);
phasei =(2*pi).*rand( 1, N);
X = 0;
Y = 0;
for x = 1:N
    X = X + ai(x)*cos(phasei(x));
    Y = Y + ai(x)*sin(phasei(x));
end
ert = X*cos(2.*pi.*f0.*n) - Y.*sin(2.*pi.*f0.*n);
figure(1); plot(n, ert);
variance = var(abs(ert));
pow = sum(ert)/1000;
pdf0 = (1/(2.*variance))*exp(-((ert)/(2.*variance)));
ksdensity(pdf0);
title('N=5,10,20');
