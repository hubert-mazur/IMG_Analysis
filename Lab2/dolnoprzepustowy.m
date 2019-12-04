im = rgb2gray(double(imread('zubr.jpg'))/255);
f = ones(3);
fim = imfilter(im,f);

figure; % tworzy nowe okno
imshow(fim);
imwrite(fim, 'dolnoprzepustowy.jpg');
