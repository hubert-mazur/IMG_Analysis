clear;
clc;
% Morfologia- wpływanie na kształt
% skupiamy się, gdzie są obiekty na obrazie
% położenie, obiektów itp.

im = imread('duck.jpg');
im = double (im )/ 255;
im = rgb2gray(im);
% T = graythresh(im);
b_im = imbinarize(im, .6);
b_im = ~ b_im;

b_im = imclose(b_im, ones(15));

imwrite(b_im, 'l_4_obraz_binarny.jpg');
% figure;
% imshow(b_im);


%% funkcja służaca do morflogii --> bwmorph(b_im, 'operacja', ile razy)
% podstawowe opcje:
%% fill- wypełnia pojedyncze dziury w obiektach- pojedyncze piksele!
%  nie zachowuje liczby Eulere
%% clean- usuwa białe piksele
%% open- w domyśle jest segment 3x3
%% close
%% majority- nadaje piskelowi tą wartość, której wartości jest najwięcej w
% sąsiedztwie, w praktyce filtr medianowy, segment jest 3x3
%% skel- powstaje szkielet obrazu, czyli zbiór punktów, które znajdują się w
% tej samej odległości od krawędzi --> pozwala powiedzieć więcej o
% orientacji obiektu, np. ptak leci, macha skrzydłami itd. Na podstawie
% szkieletu  łatwo jest zbudować graf
% zachowuje liczbe Eulera
%% endpoint- pokazuje punkty końcowe
%% branchpoint- punkty, gdzie szkielet się rozchodzi
%% shrink- realizuje w przybliżeniu erozję, na samym końcu zostanie jeden punkt, 
%  liczba Eulera zostanie zachowana
%% topologiczna liczba Eulera to liczba obiektów - liczba dziur
%% thin- uproszczony szkielet, thin upewnia się, że jeżeli jest krawędż o grubości 1,
%  to nie zostanie usunięta
%% thicken- robi dylatację, zapewnia, że 2 obiekty nigdy się nie połączą
%% remove- usuwa wnętrze
%% segmentacja- oddzielenie obiektów od siebie

b_skel_1 = bwmorph (b_im, 'skel', 1);
b_skel_inf = bwmorph(b_im, 'skel', inf);

imwrite(b_skel_1, 'skel_1.jpg');
imwrite(b_skel_inf, 'skel_inf.jpg');


b_endpoint = bwmorph(b_skel_inf, 'endpoint');
imwrite(b_endpoint, 'endpoint.jpg');


b_branch =  bwmorph(b_skel_inf, 'branchpoint');
imwrite(b_branch, 'branchpoint.jpg');


b_shrink_1 = bwmorph(b_im, 'shrink', 1);
b_shrink_inf = bwmorph(b_im, 'shrink', inf);

imwrite(b_shrink_1, 'b_shrink_1.jpg');
imwrite(b_shrink_inf, 'b_shrink_inf.jpg');


b_thin_inf = bwmorph(b_im, 'thin', inf);
b_thin_1 = bwmorph(b_im, 'thin', 1);

imwrite(b_thin_inf, 'b_thin_inf.jpg');
imwrite(b_thin_1, 'b_thin_1.jpg');


b_thicken_inf = bwmorph(b_im, 'thicken', inf);
b_thicken_1 = bwmorph(b_im, 'thicken', 1);

imwrite(b_thicken_inf, 'b_thicken_inf.jpg');
imwrite(b_thicken_1, 'b_thicken_1.jpg');


b_remove_inf = bwmorph(b_im, 'remove', inf);
b_remove_1 = bwmorph(b_im, 'remove', 1);

imwrite(b_remove_inf, 'b_remove_inf.jpg');
imwrite(b_remove_1, 'b_remove_1.jpg');


%% bwlabel(b_im)- prosta segmentacja
b_segm = bwlabel(b_im);

imwrite(b_segm == 2, 'segmentacja.jpg');
%% imshow(b_segm == 2) - wyświetla tylko 2. kaczkę
%% imshow(im .* (b_segm ==2)) - wyświetlamy kolorową kaczkę

segm = bwmorph(b_im, 'thicken', inf);  %
l = bwlabel(segm);                     % otrzymamy kaczkę z otoczeniem
imwrite(l, 'thicken_segmentacja.jpg');

figure;
% imshow(im .* (l ==2));
imshow(im .* (l ==2) .* b_im); % dostajemy samą kaczkę
title('kolorowa kaczka');

imwrite(im .* (l ==2) .* b_im, 'kolorwa_kaczka_nr_2.jpg');

%% imshow(label2rgb(l)) - przypisuje każdej etykiecie jakiś kolor, przydatne,
%  by zobaczyc jak wyszła segmentacja

imwrite(label2rgb(l), 'kolorowa_Segmentacja.jpg');

%% transformata odległościowa, polega na tym,
%  że obiekty z założenia znajdują się w odległości 0 od samych siebie
%  tło ma wartość zależną od tego, jak daleko znajduje się od najbliższego
%  obiektu

b_im ([1,end], :) = 1; % dopisujemy ramkę do obrazu
b_im (:, [1,end]) = 1; %

% bwdist możey przyjąć drugi argument, metrykę- czyli jak liczymy odległość
% metryka L2 = sqrt(a^2 + b^2)
% metryka L1 = |a| + |b|
% norma Lp = (a^p + b^p) ^ (1/p) - metryka Manhattan
% norma nieskończoność (Chebysheeva) max(a,b)

d = bwdist(b_im);
% d = bwdist(~b_im) - symulujemy, że kaczki są tłem
imshow(d/max(d(:))); % im obszar jaśniejszy, tym dalej znajduje się od najbliższego obiektu

imwrite(d/max(d(:)), 'metryka.jpg');

l = watershed(d); % segmentacja wododziałowa
figure;
imshow(label2rgb(l));
imwrite(label2rgb(l), 'watershed.jpg');







