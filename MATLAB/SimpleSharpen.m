%% Deblurring script:
close all;
clear all;
clc;

%% Read in Image
% http://www.photoweeklyonline.com/sharpening-photos-for-the-web/
% Download image here: http://www.photoweeklyonline.com/wp-content/uploads/2010/11/Sharpen_Original.jpg
inputImg = imread('bird.jpg');

img = rgb2gray(inputImg);
img = img(20:399,200:499);  
img = double(img);

figure;
subplot(1,4,1)
subimage(uint8(img))
title('Original Image');

%% Mirror boundaries to prevent artifacts
[a,b]=size(img);
tmp = zeros(3*a,3*b);

fud = flipud(img);
flr = fliplr(img);
fall = fliplr(fud);
tmp(1:a,b+1:2*b) = fud;
tmp(a+1:2*a,1:b) = flr;
tmp(a+1:2*a,2*b+1:3*b) = flr;
tmp(2*a+1:3*a,b+1:2*b) = fud;  
tmp(1:a,1:b) = fall;
tmp(2*a+1:3*a,1:b) = fall;
tmp(1:a,2*b+1:3*b) = fall;
tmp(2*a+1:3*a,2*b+1:3*b) = fall;  
tmp(a+1:2*a,b+1:2*b) = img;

%% Sharpen
% http://homepages.inf.ed.ac.uk/rbf/HIPR2/unsharp.htm

sharpFilt = [0,-1,0;-1,4,-1;0,-1,0];
sharperImg = conv2(tmp,sharpFilt);

sharpFilt2 = [-1,-1,-1;-1,8,-1;-1,-1,-1];
sharperImg2 = conv2(tmp,sharpFilt2,'valid');

sharpFilt3 = [1,-2,1;-2,4,-2;1,-2,1];
sharperImg3 = conv2(tmp,sharpFilt3,'valid');

%% Ditch boundaries
sharperImg = sharperImg(a+1:2*a,b+1:2*b);
sharperImg = sharperImg + double(img);
sharperImg2 = sharperImg2(a+1:2*a,b+1:2*b);
sharperImg2 = sharperImg2 + double(img);
sharperImg3 = sharperImg3(a+1:2*a,b+1:2*b);
sharperImg3 = sharperImg3 + double(img);

%% Display Results
subplot(1,4,2);
subimage(uint8(sharperImg));
title('Sharper Image 1');

subplot(1,4,3);
subimage(uint8(sharperImg2));
title('Sharper Image 2');

subplot(1,4,4);
subimage(uint8(sharperImg3));
title('Sharper Image 3');

%% Try with color

% Currently performing research on color spaces since it may require an RGB
% -> CEI*Lab transormation


% [labimg, class] = convertRGB2Lab(inputImg);
% returnImg = convertLab2RGB(inputImg,class);
% 
% rimg = inputImg(20:399,200:499,1);
% gimg = inputImg(20:399,200:499,2);
% bimg = inputImg(20:399,200:499,3);
% 
% 
% % Plot different color intensities
% figure;
% subimage(inputImg(:,:,1))
% figure;
% subimage(inputImg(:,:,2))
% figure;
% subimage(inputImg(:,:,3))




