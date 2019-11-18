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

b_morph = bwmorph (b_im, 'skel', inf);

b_branch =  bwmorph(b_morph, 'branchpoint'); 

b_shrink = bwmorph(b_im, 'shrink', inf);

b_thin = bwmorph(b_im, 'thin', inf);

b_thicken = bwmorph(b_im, 'thicken', inf);

b_remove = bwmorph(b_im, 'remove', inf);


%% bwlabel(b_im)- prosta segmentacja
b_segm = bwlabel(b_im);
%% imshow(b_segm == 2) - wyświetla tylko 2. kaczkę
%% imshow(im .* (b_segm ==2)) - wyświetlamy kolorową kaczkę

segm = bwmorph(b_im, 'thicken', inf);  %
l = bwlabel(segm);                     % otrzymamy kaczkę z otoczeniem


figure;
% imshow(im .* (l ==2));
imshow(im .* (l ==2) .* b_im); % dostajemy samą kaczkę
title('kolorowa kaczka');

%% imshow(label2rgb(l)) - przypisuje każdej etykiecie jakiś kolor, przydatne,
%  by zobaczyc jak wyszła segmentacja

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

l = watershed(d); % segmentacja wododziałowa
figure;
imshow(label2rgb(l));







