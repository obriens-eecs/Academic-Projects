function noise = noiseAnalCrop(im,top,bottom,left,right)
%Analyze noise in RGB image
im = im2double(im);
figure;imagesc(im);axis image;axis off;
im=mean(im(top:bottom,left:right,:),3);
figure;imagesc(im);colormap gray;axis image;axis off;
figure;
h = histogram(im(:));
xlabel('Luminance');
ylabel('Frequency');
set(gca,'FontSize',24);
noise = std(im(:))/mean(im(:));

