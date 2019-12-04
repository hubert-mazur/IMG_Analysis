clear;
clc;
% filtracja obrazu
% wspólny wierzchołek - sąsiędztwo Moore'a
% wspólna krawędź- sąsiedztwo von Neumann'a

im = rgb2gray(double(imread('zubr.jpg'))/255);
k = 25;
f = -ones(3); % obraz się wyostrzył, krawędzie uwydatniły ; jest to filtr górnoprzepustowy
f(5) = 8; % prosty filtr do wykrywania krawędzi
% f = ones(k,1)/k; %motion blur

fim = imfilter(im,f); % infilter - funkcja filtrująca, w funkcji f suma wag jest równa 1

% jest to filtr dolnoprzepustowy 

% imshow(im);
% figure; % tworzy nowe okno
% imshow(fim);
% imwrite(fim, 'mean_removal.jpg');
% w ten sposób, zamazując obraz, możemy pozbyć się szumu, potrzebne do
% dalszej obróbki

% fim = medfilt2(im, [3,3]); % mediana
% filtr prewitta wykrywa krawędzie
% f= fspecial('prewitt'); % funkcja fspecial tworzy rózne filtry
% fim = imfilter(im,f);
%imshow(im);
%figure;
%imshow(fim);

%imhist(im);
% T = .55;

b_im = im;
% b_im(b_im < T) = 0;
% b_im(b_im >= T) = 1;

% b_im = im > T - dostaniemy dokładnie to samo

% b_im = imbinarize(im, T); - binaryzuje obraz, gotowa funkcja, wynikiem jest
% macierz logiczna, parametru T nie trzeba podawać, do znalezienia wartosci
% wykorzystuje metode Otsu
% T = graythresh(im); - wyznaczy parametr T
b_im = imbinarize(im, 'adaptive'); %- wybiera próg w zależności od danego
% otoczenia

b_im = ~ b_im;
figure;
imshow(b_im);
% title('binarny');
imwrite(b_im, 'adaptive_binarny.jpg');
figure;
b_im = medfilt2(b_im);
imshow(b_im);
% title('binarny medianowy filtr');
imwrite(b_im, 'binarny_medianowy.jpg');

% funkcja min() obcina krawędź z obiektu
% funkcja max() poszerzy krawędź obiektu

% min to inaczej erozja
% max to inaczej dylatacja

% imerode(b_im, ones(3));
% imdilate(b_im, ones(3));



im_d = imdilate(b_im, ones(3));
im_er = imerode(b_im,ones(3));
figure;
imshow(im_er);
title('erozja');
imwrite(im_er,'erozja.jpg');
figure;
imshow(im_d);
title('dylatacja');
imwrite(im_d,'dylatacja.jpg');

% erozja usuwa białe kropki, dylatacja czarne

% aby zwiększyć efekt możemy zwiększyć zakres- np. ones(5) 
% najpeirw erozja, póżniej dylatacja - operacjaa otwarcia

% w matlab mamy imopen(b_im, ones(3));, imclose(b_im,ones(3));
%b_im = -b_im +imdilate(b_im, ones(3));

im_op = imopen(b_im, ones(3));
im_cl = imclose(b_im,ones(3));

imwrite(im_op, 'otwarcie.jpg');
imwrite(im_cl, 'zamkniecie.jpg');

figure;
imshow(im_op);
title('otwarcie');
% imshow(b_im);
% f = -ones(3); 
% f(5) = 8; 

% b_im = imfilter(b_im, f); % krawędzie
%imshow(b_im);
% figure;
% imshow(b_im .* im);
% title('iloczyn_krawedzie');
imwrite(b_im .* im,'nalozenie.jpg');
