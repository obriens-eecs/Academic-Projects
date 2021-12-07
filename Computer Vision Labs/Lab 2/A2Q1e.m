function [tspace,tfreq] = A2Q1e(im,betamin,betamax,nbeta)
%Filter im and show results using Wiener filter for specified range of beta
%values

im = double(rgb2gray(im));

%Sample beta logarithmically
dlogbeta = (log(betamax)-log(betamin))/(nbeta-1);
betas = exp(log(betamin):dlogbeta:log(betamax));


ncol = ceil(sqrt(nbeta+1));
nrow = ceil((nbeta+1)/ncol);

figure;
subplot(nrow,ncol,1);
imagesc(im);axis image;colormap gray;axis off;
title('Original image');
set(gca,'FontSize',14);

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
    
    imw = conv2(im,h,'same');
    
    subplot(nrow,ncol,i+1);
    imagesc(imw);axis image;colormap gray;axis off;
    title(sprintf('\\beta = %0.1f',beta));
    set(gca,'FontSize',14);
end