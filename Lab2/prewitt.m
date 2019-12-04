im = rgb2gray(double(imread('zubr.jpg'))/255);

f= fspecial('prewitt'); % funkcja fspecial tworzy rózne filtry
fim = imfilter(im,f);
figure;
imshow(fim);
imwrite(fim, 'prewitt.jpg');