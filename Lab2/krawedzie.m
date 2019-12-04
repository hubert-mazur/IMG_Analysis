im = rgb2gray(double(imread('zubr.jpg'))/255);

f = -ones(3); 
f(5) = 8; 

b_im = imfilter(b_im, f); % krawędzie

imwrite(b_im, 'krawedzie.jpg');
