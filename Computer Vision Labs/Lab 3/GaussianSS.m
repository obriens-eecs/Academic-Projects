function [GPyr] = GaussianSS(im, s1, ns, noctaves)
% im = imread('mondrian.jpg'); im = rgb2gray(im); im = im2double(im);

k = 2^(1/ns);
Gpyr = cell(1, noctaves);
[M,N] = size(im);

for octave = 1:noctaves
    scale = s1*2^(octave - 1);
    rc = [];
    %s = 0.5^octave;
    %im = imresize(im,[ceil(M*s) ceil(N*s)]);
    %[M,N] = size(im);
    
    for band = 1:(ns+3)
        
       sigma = scale*k^(band - 1); 
       ky = [0:M-1] - floor(M/2);
       kx = [0:N-1] - floor(N/2);
       [X,Y]=meshgrid(kx,ky);

       %Gaussian Kernel
       G = (1/(2*pi*sigma*sigma))*exp((-X.^2 - Y.^2)/(2*sigma*sigma));

       %Truncate at 1%
       thresh = max(G(:))/100;
       [I,J]=ind2sub(size(G),find(abs(G)>thresh));
       top = min(I);
       bottom = max(I);
       left = min(J);
       right = max(J);
       G = G(top:bottom,left:right);

       %Blurred Image
       L = conv2(im,G,'valid');

       %Pad with NaNs
       [LX LY] = size(L);
       dX = M - LX;
%        dX = round(dX);
       dY = N - LY;
%        dY = round(dY);
       xpad = ceil(dX/2);
       ypad = ceil(dY/2);
       dif = [xpad ypad];
       P = padarray(L, dif, NaN, 'both');
       if (band >= 3 && octave == 3)
           P = P(1:118,1:117);
       end
       %store image in 3d image array
       rc = cat(3, rc, P);
     
    end

    %store image array in cell
    GPyr{octave} = rc;
    im = GPyr{1}(1:M,1:N,(ns+1));
%     for i = 1:2:size(im,1)
%         for j = 1:2:size(im,2)
%             newIm() = im(i,j);
%         end
%     end
    im = imresize(im, 0.5);
    [M,N] = size(im);
    
end

end
