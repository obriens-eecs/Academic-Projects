PtGt = 1;
Gr = 1;
L = 2e-9;
ht = 500;
hr = 2;
d = 1:1:100000;
fc = 4.5e8;
c = 3e8;
lambda = c / fc;

d1 = (d.^2+(ht-hr).^2 ).^(1/2);
d2 = (d.^2+(ht+hr).^2 ).^(1/2);

PrF = (lambda ./ (4 * pi .* d1) ) .^2 * PtGt * Gr / L;
deltaPhiL = 2 * pi .* (d2-d1) ./ lambda;
Pr = PrF .* abs(1 - d1/d2 .* exp(-1i * deltaPhiL)).^2;
dBmF = 6 * log10(Pr*20);

l = log10(d);
plot(l,dBmF);

title("Recieved Power for 900MHz");
ylabel("Recieved Signal Power (dB)");
xlabel("Logarithmic Scale of Distance (log10(d))");
