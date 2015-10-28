clear all;
close all;

%load image
img = im2double(rgb2gray(imread('lena.png')));
[N, M] = size(img);

%display original image
figure(1);
subplot(1, 2, 1);
imshow(img);
title('Original Image');

%create filter and moise
h = fspecial('motion', 31, 30);

%filter image
i = convolve(img, h, 'repeating');
noise_var = 0.001;
n = imnoise(zeros(M, N), 'gaussian', 0, noise_var);
i = i + n;

%display blurry images
subplot(1, 2, 2);
imshow(i);
title('Blurred image');

signal_var = var(img(:))
x_matlab = deconvwnr(i, h, noise_var / signal_var);

%
%                   H*(k,l) Sn(k,l)
% G(k,l)  =  ------------------------------
%            |H(k,l)|^2 Sn(k,l) + Sf(k,l)
%

%get frequency domain functions
I = fftshift(fft2(i, M, N));
H = fftshift(fft2(h, M, N));
H_conj = conj(H);
Sf = power_spectral_density(img);
Sn = power_spectral_density(n);
H_squared = abs(H) .^ 2;

denom = H_squared .* Sn + Sf;
G = H_conj .* Sn;
G = G ./ denom;

X = G .* I;

x = real(ifft2(ifftshift(X)));

%display unblurred images
figure(2);
subplot(1, 2, 1);
imshow(mat2gray(x_matlab));
title('matlab unblurred image');

subplot(1, 2, 2);
imshow(mat2gray(x));
title('our unblurred Image');
