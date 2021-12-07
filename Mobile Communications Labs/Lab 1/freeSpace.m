function [] = freeSpace(fc,d)
PtGt = 1;
Gr = 1;
L = 1;
c = 3e8;
lambda = c / fc;
Pr = (lambda ./ (4 * pi * d) ).^2 * PtGt * Gr / L;  
PrL = log10(Pr);
l = log10(d);
plot(l,PrL);
title("Recieved Power vs Distance");
ylabel("Recieved Signal Power");
xlabel("Logarithmic Scale of Distance");


end

