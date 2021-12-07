function  A2Q2(im,betamin,betamax,nbeta)
%Filter im using Wiener filter in both frequency and space domains,
%over the specified range of beta values

im = double(rgb2gray(im));

figure;
imagesc(im);axis image;colormap gray;axis off;
title('Original image');
set(gca,'FontSize',18);

sd = std(im(:))

noisyim = im + normrnd(0,sd,size(im));

figure;
imagesc(noisyim);axis image;colormap gray;axis off;
title('Noisy image, SNR = 1');
set(gca,'FontSize',18);

%Sample beta logarithmically
dlogbeta = (log(betamax)-log(betamin))/(nbeta-1);
betas = exp(log(betamin):dlogbeta:log(betamax));

%Frequency domain
[M,N] = size(im);
ky = ifftshift([0:M-1]-floor(M/2))/M;
kx = ifftshift([0:N-1]-floor(N/2))/N;
[kX,kY]=meshgrid(kx,ky);

omega = 2*pi*sqrt(kX.^2+kY.^2);

for i = 1:nbeta
    beta = betas(i);
    
    %Transfer function
    H = 1./(1+(omega/beta).^2);
    
    %Space domain
    h = real(fftshift(ifft2(H)));
    
    %Truncate at 0.1%
    thresh = max(h(:))/1000;
    [I,J]=ind2sub(size(h),find(abs(h)>thresh));
    top = min(I);
    bottom = max(I);
    left = min(J);
    right = max(J);
    h = h(top:bottom,left:right);
    
    h = h/sum(h(:)); %normalize to unit volume

    imw = conv2(noisyim,h,'same');
    mse(i) = mean((imw(:)-im(:)).^2);
end

figure;
semilogx(betas,mse,'LineWidth',3);
xlabel('\beta');
ylabel('Mean square error');
set(gca,'FontSize',18);

[m,idx] = min(mse);
betaopt = betas(idx)

%Transfer function
H = 1./(1+(omega/betaopt).^2);

%Space domain
h = real(fftshift(ifft2(H)));

%Truncate at 0.1%
thresh = max(h(:))/1000;
[I,J]=ind2sub(size(h),find(abs(h)>thresh));
top = min(I);
bottom = max(I);
left = min(J);
right = max(J);
h = h(top:bottom,left:right);

h = h/sum(h(:)); %normalize to unit volume

tic
imw = conv2(noisyim,h,'same');
toc
mse = mean((imw(:)-im(:)).^2);
sprintf('SNR = %0.1f',sd/sqrt(mse))

%Frequency domain
tic
imW = real(ifft2(H.*fft2(im)));
toc

figure;
imagesc(imw);axis image;colormap gray;axis off;
title('Noisy image after Wiener filtering with optimal \beta');
set(gca,'FontSize',18);


