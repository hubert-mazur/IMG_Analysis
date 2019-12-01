clear;
clc;

im = imread('ptaki2.jpg');
im = double(im) / 255;
im = rgb2gray(im);
b_im = imbinarize(im, .5);
imclose(b_im, ones(9));
b_im = ~ b_im;

im_kaczki = imread('duck.jpg');
im_kaczki = double(im_kaczki) / 255;
im_kaczki = rgb2gray(im_kaczki);
im_kaczki_b = imbinarize(im_kaczki, .6);
im_kaczki_b = imclose(im_kaczki_b, ones(15));
im_kaczki_b = ~ im_kaczki_b;


im_ptaki = imread('ptaki.jpg');
im_ptaki = double(im_ptaki) / 255;
im_ptaki_b = rgb2gray(im_ptaki);
im_ptaki_b = imbinarize(im_ptaki_b, 0.5);
im_ptaki_b = ~ im_ptaki_b;

figure;
imshow(b_im);

l_ptaki2 = bwlabel(b_im);
l_kaczki = bwlabel(im_kaczki_b);
l_ptaki = bwlabel(im_ptaki_b);

for i = 1:max(l_ptaki2(:))
    if length(l_ptaki2(l_ptaki2 == i)) < 1000
        l_ptaki2(l_ptaki2==i) = 0;
    end
end



L_ptaki2 = bwlabel(l_ptaki2>0);
L_kaczki = bwlabel(l_kaczki>0);
L_ptaki = bwlabel(l_ptaki>0);

figure;
imshow(L_ptaki2);



n_ptaki2 = max(L_ptaki2(:));
n_ptaki = max(L_ptaki(:));
n_kaczki = max(L_kaczki(:));

fun = {@AO5RBlairBliss, @AO5RCircularityL, @AO5RCircularityS, @AO5RDanielsson, @AO5RFeret, @AO5RHaralick, @AO5RMalinowska, @AO5RShape};
Nfun = length(fun);
wsp_ptaki2 = zeros(n_ptaki2, Nfun);
wsp_kaczki = zeros(n_kaczki, Nfun);
wsp_ptaki = zeros(n_ptaki, Nfun);



for i = 1:n_ptaki2 
    for j = 1:Nfun
        wsp_ptaki2(i,j) = fun{j}(L_ptaki2==i);
    end
end

for i = 1:n_ptaki 
    for j = 1:Nfun
        wsp_ptaki(i,j) = fun{j}(L_ptaki==i);
    end
end

for i = 1:n_kaczki
    for j = 1:Nfun
        wsp_kaczki(i,j) = fun{j}(L_kaczki==i);
    end
end


% sieć neuronowa
ucz = [wsp_ptaki2; wsp_ptaki]';
uczout = [ones(1,size(wsp_ptaki2,1)), 2 * ones(1, size(wsp_ptaki,1))];

mn = feedforwardnet;
nn = train(mn, ucz, uczout);

out = mn(wsp_ptaki2(:,1)');

res = mn(ucz);

round(res) == uczout



%% Sprawozdanie:
% 1. Morfologia, segmentacja, 
% 2. Współczynniki geometryczne
% 3. Klasyfikacja

% Do 10.12.2019 do 9:05, napisać coś mądrego
%% Projekty:
% Tematy projektów są na stronie
% Samemu zaimplementować metody, np. segmentacja, binaryzacja itd.
%% W prjekcie powinna być: dokumentacja:
% co to jest i do czego ma służyć 
% jak to uruchomic
% Kto co robił
% co się nie udalo, co nie działa
% Na napisanie projektu jest około 2 miesiące
% Przykładowe dane, dane, z którymi działa projekt
% próbowac uruchomić z większym obrazkiem

