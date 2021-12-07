xm = sqrt(2)*10*sqrt(log(1000)) % used to determine what the sample size should be
x = [-38:38]; % sample size
%represent filter
h = normpdf(x,0,10); % mean 0, standard deviation 10
figure; plot(h);
h = exp(-x.^2 / (2*10^2));
figure; plot(h);
sum(h)
h = h/sum(h)
sum(h)
h2 = h' * h;
figure; imagesc(h2); axis image; colormap gray;
[X,Y] = meshgrid(x);
h2 = exp(-x.^2 + Y.^2) / (2*10^2);
figure; imagesc(h2); axis image; colormap gray;
h2 = exp(-(x.^2 / 5^2 + Y.^2 / 10^2) / 2);
figure; imagesc(h2); axis image; colormap gray;
