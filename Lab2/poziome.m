im = rgb2gray(double(imread('zubr.jpg'))/255);
f = zeros(3);
f(4) = -1;
f(5) = 1;
fim = imfilter(im,f);

figure; % tworzy nowe okno
imshow(fim);
imwrite(fim, 'poziome.jpg');