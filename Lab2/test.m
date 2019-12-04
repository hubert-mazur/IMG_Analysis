im = rgb2gray(double(imread('zubr.jpg'))/255);
k = 25;
f = -ones(3);
f(5) = 5; % prosty filtr do wykrywania krawędzi
f(1) = 0;
f(3) = 0;
f(7) = 0;
f(9) = 0;
% f = ones(k,1)/k; %motion blur

fim = imfilter(im,f); % infilter - funkcja filtrująca, w funkcji f suma wag jest równa 1

% jest to filtr dolnoprzepustowy 

% imshow(im);
figure; % tworzy nowe okno
imshow(fim);
imwrite(fim, 'HP1.jpg');
