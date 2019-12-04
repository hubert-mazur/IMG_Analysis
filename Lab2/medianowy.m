im = rgb2gray(double(imread('zubr.jpg'))/255);
fim = medfilt2(im, [3,3]); % mediana
figure;
imshow(fim);
imwrite(fim, 'medianowy.jpg');