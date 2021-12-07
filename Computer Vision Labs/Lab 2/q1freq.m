I = imread("lowlight.jpg");
J = rgb2gray(I);
imagesc(J);
colormap gray
[x, y] = size(J);
H = zeros(x, y);
for i=1:x
    for j=1:y
        H(i,j) = 1 / (1 + (100 * (i*0.001) ^ 2) + (100 * (j*0.001) ^ 2));
    end
end
K = zeros(x, y);
tic
L = fft2(J);
for i=1:x
    for j=1:y
        K(i,j) = L(i,j) * H(i,j);
    end
end
I2 = ifft2(K);
toc
I3 = real(I2);
I4 = uint8(I3);
imshow(I4)
