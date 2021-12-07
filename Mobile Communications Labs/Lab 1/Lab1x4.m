d = 1:1:100000;

l = log10(d);
dBmF = 1 ./ d.^4;
dBmF = log10(dBmF);

plot(l,dBmF);
title("x vs 1/x^4");
ylabel("1/x^4");
xlabel("x");