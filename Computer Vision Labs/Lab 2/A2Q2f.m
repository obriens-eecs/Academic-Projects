function  A2Q2f(im,scale,sigmad,sigmarmin,sigmarmax,nsigmar)
%Filter noisy image using Gaussian bilateral filter,
%optimizing bandwidth of range kernel. \

im = double(imresize(rgb2gray(im),scale));
sd = std(im(:))
noisyim = im + normrnd(0,sd,size(im)); %SNR = 1

%Sample sigma_r logarithmically
dlogsigmar = (log(sigmarmax)-log(sigmarmin))/(nsigmar-1);
sigmars = exp(log(sigmarmin):dlogsigmar:log(sigmarmax));

for i = 1:nsigmar
    sigmar = sigmars(i);
    imw = imbilatfilt(noisyim,sigmar^2,sigmad);
    mse(i) = mean((imw(:)-im(:)).^2);
end

figure;
semilogx(sigmars,mse,'LineWidth',3);
xlabel('\sigma_r');
ylabel('Mean square error');
set(gca,'FontSize',18);

[m,idx] = min(mse);
sigmaropt = sigmars(idx)

tic
imw = imbilatfilt(noisyim,sigmaropt^2,sigmad);
toc
mse = mean((imw(:)-im(:)).^2)
sprintf('SNR = %0.1f',sd/sqrt(mse))

figure;
imagesc(imw);axis image;colormap gray;axis off;
title('Noisy image after Gaussian bilateral filtering with optimal \sigma_d and \sigma_r');
set(gca,'FontSize',14);


