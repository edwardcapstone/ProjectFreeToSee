I = imread('peppers.png');%read image
I = I(10+[1:256],222+[1:256],:);%region of the picture
figure(1);  imshow(I);%original picture
title('Original Image');
LEN = 31; THETA = 11;
PSF = fspecial('motion',LEN,THETA);%generate motion blur function
blurred = imfilter(I,PSF,'circular','conv');%generate motion blur image
figure(2); subplot(221), 
imshow(blurred);%plot blurred image
title('Blurred');
wnr1 = deconvwnr(blurred,PSF);%use Wiener filter
subplot(222); imshow(wnr1);%show the image after filtering
title('Restored, True PSF');
wnr2 = deconvwnr(blurred,...
   fspecial('motion',2*LEN,THETA));%double length
subplot(223); imshow(wnr2); 
title('Restored, "Long" PSF');
wnr3 = deconvwnr(blurred,...
   fspecial('motion',LEN,2*THETA));%double angle
subplot(224); imshow(wnr3); 
title('Restored, Steep');
noise = 0.1*randn(size(I));%add some random noise
blurredNoisy = imadd(blurred,im2uint8(noise));%add the noise to the blurred image
figure(3); subplot(221)
imshow(blurredNoisy);
title('Blurred & Noisy');
wnr4 = deconvwnr(blurredNoisy,PSF);%Wiener filter
subplot(222),
imshow(wnr4);
title('Inverse Filtering of Noisy Data');
NSR = sum(noise(:).^2)/sum(im2double(I(:)).^2);%noise to signal ratio
wnr5 = deconvwnr(blurredNoisy,PSF,NSR);%use Wiener filter after adding NSR
subplot(223); imshow(wnr5);
title('Restored with NSR');
wnr6 =deconvwnr(blurredNoisy,PSF,NSR/2);%NSR/2
subplot(224),
imshow(wnr6);
title('Restored with NSR/2');
NP = abs(fftn(noise)).^2;%calculate noise power spectrum
NPOW = sum(NP(:))/prod(size(noise)); % noise power
NCORR = fftshift(real(ifftn(NP))); % noise correlation function
IP = abs(fftn(im2double(I))).^2;%calculate image spectrum
IPOW = sum(IP(:))/prod(size(I)); % image power
ICORR = fftshift(real(ifftn(IP))); % image correlation function
wnr7 = deconvwnr(blurredNoisy,PSF,NCORR,ICORR);%use Wiener filter with more parameters
figure(4); subplot(121)
imshow(wnr7);
title('Restored with ACF');
ICORR1 = ICORR(:,ceil(size(I,1)/2));
wnr8 = deconvwnr(blurredNoisy,PSF,NPOW,...
        ICORR1);%use noise power and one dimensional image correlation function to proceed Wiener filter
subplot(122); imshow(wnr8);
title('Restored with NP & 1D-ACF');
PSF2 = fspecial('gaussian',11,5);%gaussian blur function
Blurred = imfilter(I,PSF2,'conv');
figure(5); subplot(121)
imshow(Blurred);%blurred image
title('Blurred');
V = .02;
BlurredNoisy2 = imnoise(Blurred,'gaussian',0,V);%add gaussian white noise
subplot(122); imshow(BlurredNoisy2);
title('Blurred & Noisy');
NP = V*prod(size(I)); % noise power
[reg1 LAGRA] = deconvreg(BlurredNoisy2,PSF,NP);%regular filtering
figure(6); subplot(221)
imshow(reg1),
title('Restored with NP');
reg2 = deconvreg(BlurredNoisy2,PSF,NP*1.3);%enhance the noise
subplot(222); imshow(reg2);
title('Restored with larger NP');
reg3 = deconvreg(BlurredNoisy2,PSF,NP/1.3);%abate the noise
subplot(223); imshow(reg3);
title('Restored with smaller NP');
Edged = edgetaper(BlurredNoisy2,PSF);%blur the edge of the image
reg4 = deconvreg(Edged,PSF,NP/1.3);%regular filtering
subplot(224); imshow(reg4);
title('Edgetaper effect');
reg5 = deconvreg(Edged,PSF,[],LAGRA);%add Lagrange Multiplier
figure(7); subplot(221)
imshow(reg5);
title('Restored with LAGRA');
reg6 = deconvreg(Edged,PSF,[],LAGRA*100);%use larger Lagrange Multiplier
subplot(222); imshow(reg6);
title('Restored with large LAGRA');
reg7 = deconvreg(Edged,PSF,[],LAGRA/100);%abate Lagrange Multiplier
subplot(223); imshow(reg7);
title('Restored with small LAGRA');
REGOP = [1 -2 1];%smooth constrained parameter
reg8 = deconvreg(BlurredNoisy2,PSF,[],LAGRA,...
            REGOP);%add smooth constrained parameter
subplot(224); imshow(reg8);
title('Constrained by 1D Laplacian');
PSF3 = fspecial('gaussian',5,5);%Gaussian function
Blurred = imfilter(I,PSF3,'symmetric','conv');%blurred image
figure(8); subplot(121)
imshow(Blurred);
title('Blurred');
V = .002;
BlurredNoisy3 = imnoise(Blurred,'gaussian',0,V);%add Gaussian white noise
subplot(122); imshow(BlurredNoisy3);%blurred image after adding the noise
title('Blurred & Noisy');
luc1 = deconvlucy(BlurredNoisy3,PSF,5);%use lucy-richardson to filter
figure(9); subplot(131)
imshow(luc1);
title('Restored Image, NUMIT = 5');
luc1_cell = deconvlucy({BlurredNoisy3},PSF,5);%use deconvlucy
luc2_cell = deconvlucy(luc1_cell,PSF);%continue to use deconvlucy
luc2 = im2uint8(luc2_cell{2});%convert the image type
subplot(132); imshow(luc2);
title('Restored Image, NUMIT = 15');
DAMPAR = im2uint8(3*sqrt(V));%noise parameter
luc3 = deconvlucy(BlurredNoisy3,PSF,15,DAMPAR);%amplify the noise
subplot(133); imshow(luc3);
title('Restored Image with Damping, NUMIT = 15');
I = rgb2gray(I);%convert to gray image
PSF = fspecial('gaussian',7,10);%Gaussian blur function
Blurred4 = imfilter(I,PSF,'symmetric','conv');%generate blurred image
figure(11); subplot(221)
imshow(Blurred4);
title('Blurred Image');
UNDERPSF = ones(size(PSF)-4);%undersized PSF
[J1 P1] = deconvblind(Blurred4,UNDERPSF);%build deconvolution
subplot(222); imshow(J1);
title('Deblurring with Undersized PSF');
OVERPSF = padarray(UNDERPSF,[4 4],'replicate','both');%oversized PSF
[J2 P2] = deconvblind(Blurred4,OVERPSF);%build deconvolution
subplot(223); imshow(J2);
title('Deblurring with Oversized PSF');
INITPSF = padarray(UNDERPSF,[2 2],'replicate','both');%initial PSF
[J3 P3] = deconvblind(Blurred4,INITPSF);%build deconvolution
subplot(224); imshow(J3);
title('Deblurring with INITPSF');
figure(12); subplot(221);
imshow(PSF,[],'InitialMagnification','fit');%true PSF
title('True PSF'); subplot(222);
imshow(P1,[],'InitialMagnification','fit');%reconstructed undersized PSF 
title('Reconstructed Undersized PSF');
subplot(223);
imshow(P2,[],'InitialMagnification','fit');%reconstructed oversized PSF 
title('Reconstructed Oversized PSF');
subplot(224);
imshow(P3,[],'InitialMagnification','fit');%reconstructed true PSF
title('Reconstructed true PSF');
