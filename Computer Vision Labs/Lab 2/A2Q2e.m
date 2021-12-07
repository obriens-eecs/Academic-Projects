function  A2Q2e(im,scale,sigmamin,sigmamax,nsigma)
%Filter im using Gaussian filter in the space domain,
%optimizing the bandwidth

im = double(imresize(rgb2gray(im),scale));
sd = std(im(:))
noisyim = im + normrnd(0,sd,size(im));

%Sample sigma logarithmically
dlogsigma = (log(sigmamax)-log(sigmamin))/(nsigma-1);
sigmas = exp(log(sigmamin):dlogsigma:log(sigmamax));

for i = 1:nsigma
    sigma = sigmas(i);
    rmax = ceil(sqrt(2*sigma^2*log(1000))); %truncate at 0.1%
    x = [-rmax:rmax];
    h = exp(-x.^2/(2*sigma^2));
    h = h/sum(h(:)); %normalize to unit volume
    imw = conv2(h,h,noisyim,'same');
    mse(i) = mean((imw(:)-im(:)).^2);
end

figure;
semilogx(sigmas,mse,'LineWidth',3);
xlabel('\sigma');
ylabel('Mean square error');
set(gca,'FontSize',18);

[m,idx] = min(mse);
sigmaopt = sigmas(idx)

rmax = ceil(log(1000)/sigmaopt); %truncate at 0.1%
x = [-rmax:rmax];
h = exp(-x.^2/(2*sigmaopt^2));
h = h/sum(h(:)); %normalize to unit volume
tic
imw = conv2(h,h,noisyim,'same');
toc
mse = mean((imw(:)-im(:)).^2);
sprintf('SNR = %0.1f',sd/sqrt(mse))

figure;
imagesc(imw);axis image;colormap gray;axis off;
title('Noisy image after Gaussian filtering with optimal \sigma');
set(gca,'FontSize',18);


