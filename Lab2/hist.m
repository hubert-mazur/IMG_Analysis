im = rgb2gray(double(imread('zubr.jpg'))/255);

imhist(im);
saveas(gcf, 'histogram.jpg');