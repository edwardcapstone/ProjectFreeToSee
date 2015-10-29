function outImage = myBilateralFilter(A,w,sigma_s,sigma_r)
%implement biliteral filter here
%% For debugging:
% img = imread('lena.png');
% input_img_gray = rgb2gray(img);
% figure,
% subplot(1,2,1), subimage(input_img_gray);
% title('original image (gray scale)')
% %noisy images
% s = 30; %standard deviation of artificial noise
% noisy_img = double(input_img_gray) + s*randn(size(input_img_gray));
% subplot(1,2,2), subimage(uint8(noisy_img));
% title('noisy image')
% 
% A = double(noisy_img);
% sigma_s = 10;
% sigma_r = 10;
% w = 20;


%% Algorithm

%maximum window size; you have to deal with boundary issues
[X,Y] = meshgrid(-w:w,-w:w);

[a,b] = size(A);
outImage = zeros(a,b);
gaus = exp(-(X.^2+Y.^2)/(2*sigma_s^2));
for i = 1:a
    for k = 1:b
        currentWindow = A(max(i-w,1):min(i+w,a),max(k-w,1):min(k+w,b));
        scaledWindow = (exp(-(currentWindow-A(i,k)).^2/(2*sigma_r^2))).*gaus((max(i-w,1):min(i+w,a))-i+w+1,(max(k-w,1):min(k+w,b))-k+w+1);      
        outImage(i,k) = sum(scaledWindow(:).*currentWindow(:))/sum(scaledWindow(:));
   end
end


%% For debugging
% figure;
% subplot(1,2,1)
% subimage(uint8(noisy_img));
% colormap('gray');
% subplot(1,2,2)
% subimage(uint8(outImage));
% colormap('gray');




