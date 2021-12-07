function imout = whiteBalance(imin,top,bottom,left,right)
%Corrects white balance based upon indicated crop

imin = im2double(imin);
[h,w,d] = size(imin);
mRGB = mean(reshape(imin,[],3));
mRGBcrop = mean(reshape(imin(top:bottom,left:right,:),[],3));
gain = mean(mRGB)/mean(mRGB./mRGBcrop);
imout = gain*imin./repmat(reshape(mRGBcrop,1,1,[]),h,w,1);


mean(imin(:))
mean(imout(:))
%imout = cast(imout,class(imin));

%For display purposes, scale both images equally so max overall is 1
m = max([imin(:);imout(:)]); 
figure;
subplot(1,2,1);
imagesc(imin/m);axis image;axis off;
title('Original','FontSize',18);
subplot(1,2,2);
imagesc(imout/m);axis image;axis off;
title('White Balanced','FontSize',18);
