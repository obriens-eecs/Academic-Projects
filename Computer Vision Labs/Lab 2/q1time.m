I = imread("lowlight.jpg");
J = rgb2gray(I);
imagesc(J);
colormap gray
samples = [0:0.1:5.0];
[X,Y] = meshgrid(samples);
H = 1 ./ (1 + 100 * X .^ 2 + 100 * Y .^ 2);
h = ifft2(H);
hw = fftshift(h);
a = abs(hw);
surf(X,Y,a);
plot(X,a);
tic
A = conv2(J,a,'same');
toc
imagesc(A);
