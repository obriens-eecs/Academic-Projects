function [tspace,tfreq] = A2Q1(im,beta,show)
%Filter im using Wiener filter in both space and frequency domains,
%returning execution times

im = double(rgb2gray(im));
if show
    figure;
    imagesc(im);axis image;axis off;colormap gray;
end

%Frequency domain
[M,N] = size(im);
ky = ifftshift([0:M-1]-floor(M/2))/M;
kx = ifftshift([0:N-1]-floor(N/2))/N;
[kX,kY]=meshgrid(kx,ky);

omega = 2*pi*sqrt(kX.^2+kY.^2);
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

if show
    figure;imagesc(h);axis image;colormap gray;
    title(sprintf('Wiener filter, \\beta = %0.1f',beta));
    set(gca,'FontSize',18);
    
    figure;plot(h(round(size(h,1)/2),:),'LineWidth',3);axis tight;
    title(sprintf('Wiener filter, \\beta = %0.1f',beta));
    set(gca,'FontSize',18);
end

tic
imw = conv2(im,h,'same');
tspace = toc;

if show
    figure;
    imagesc(imw);axis image;axis off;colormap gray;
    title(sprintf('Image filtered in space domain with Wiener filter, \\beta = %0.1f',beta));
    set(gca,'FontSize',16);
end

tic
imW = real(ifft2(H.*fft2(im)));
tfreq = toc;

if show
    figure;
    imagesc(imW);axis image;axis off;colormap gray;
    title(sprintf('Image filtered in frequency domain with Wiener filter, \\beta = %0.1f',beta));
    set(gca,'FontSize',16);
end

if show
    figure;
    imagesc(imW-imw);axis image;axis off;colormap gray;
    title(sprintf('Difference between filtered images, \\beta = %0.1f',beta));
    set(gca,'FontSize',16);
end

