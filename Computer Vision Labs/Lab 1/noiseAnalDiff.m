function [noise,imdiff] = noiseAnalDiff(im1,im2)
%Analyze noise by differencing two images

im1 = im2double(im1);
im2 = im2double(im2);
figure;imagesc(im1);axis image;
imdiff=mean(im1-im2,3);
noise = std(imdiff(:))/mean(im1(:));

figure;imagesc(imdiff);colormap gray;axis image;axis off;
figure;
h = histogram(imdiff(:));
xlabel('Luminance difference');
ylabel('Frequency');
set(gca,'FontSize',24);

