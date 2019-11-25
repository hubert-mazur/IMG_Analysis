clear;
clc;

%% Problemem przy binaryzacji jest gradient, kaczki niewiele różnią się od tła na obrazie w skali szarości
%% na zielonym kanale jest duży gradient
h = 5;
w = 2;
i = 1;

im = imread('ptaki.jpg');
im = double(im) / 255;
g_im = rgb2gray(im);


for i=1:3 
    subplot(3,2,2*i-1);
    imshow(im(:,:,i));
    subplot(3,2,2*i);
    imhist(im(:,:,i));
end;

b = im(:,:,3);
r = im(:,:,1);
b = ~ imbinarize(b, .6);
r(r<.15) = 1;
r = imbinarize(r,.3);

b_im = b | r;

b_im = imclose(b_im, ones(5));
b_im = imopen(b_im, ones(5));


% figure;
% imshow(b_im);

%  obraz zbinaryzowany został, patrząc na różne kanały- red i blue, nie za pomocą funkcji rgb2gray
%% <title> Współczynniki geometryczne: </title>
%% area- pole powierzchni
%% centroid- średnia wszystkich współrzędnych
%% BoundingBox- współrzędne granic- możemy zobaczyć, gdzie znajduje się
%  nasza kaczka
%% perimiter- obwód, 
%  kraw = bwmorph(props.Image, 'remove');
%  perim = sum(kraw(:)); - w ten sposób możemy policzyć obwód


l = bwlabel(b_im);
n = max(l(:)); % jest 8 dużych obiektów

% prop = regionprops(l==4, 'all');
% imshow(prop.Image); % obrazek jest przycięty do BoundingBox

%% Proste współczynniki geometryczne:
%% współczynnik kołowości (circularity)
%  znając pole figury S, chcemy znaleźć d- średnicę --> d = 2*sqrt(S/pi);
%  jakia byłaby średnica koła aby pole koła i kaczki były te same
%% średnica koła o tym samym obwodzie co obwód kaczki
% znając obwód liczymy średnicę o tym samym obwodzie d = L/pi
%% tworzymy współczynnik dl/ds - nie zależy od rozmiaru figury!
%  współczynnik będzie duży, gdy figura będzie mieć duży obwód, a małe pole
% aby współczynnik był jak najmniejszy, figura musi być jak najbardziej
% zbliżona do koła
% dla konwencji przyjmujemy: dl/ds - 1 - współczynnik kształtu
% Malinowskiej
% ds/dl - współczynnik kształtu

%% współczynnik Danielsona- średnia odległość wszystkich punktów od najbliższych krawędzi
%% odległość piskela od środka masy- współczynnik Blair'a - Blis'a
%% współczynnik Harlink'a - odległość piskela na konturze od środka masy
%% współczynnik Ferret'a- odwołuje się do promieni Ferret'a- F1/F2, gdzie F- rozpiętość x, y

fun = {@AO5RBlairBliss, @AO5RCircularityL, @AO5RCircularityS, @AO5RDanielsson, @AO5RFeret, @AO5RHaralick, @AO5RMalinowska, @AO5RShape};
Nfun = length(fun);
wsp = zeros(n, Nfun);

for i = 1:5 
    for j = 1:Nfun
        wsp(i,j) = fun{j}(l==i);
    end
end

m = mean(wsp);
s = std(wsp);

% chcemy sprawdzić o ile dana liczba różni się od wartości oczekiwanej

err = abs(wsp - m)./ s;
% pokazuje jak abrdzo dana liczba się wyróżnia
%  zakładamy, że wszystkie warotści podlegają rozkładowi normalnemu,
%  wykorzystujemy metodę 3 sigm
% możemy sami ustalić próg:
T = 2; % 2 odchylenia standardowe, patrzymy czy kaczka jest typowa --> mieści sie w zakresie

err = err < T;
% możemy ustalić, że co najmniej 2 współczyniki musza być nietypowe, żeby
% kaczka była nietypowa
% 

typ = sum(err, 2) > 3;

prop = regionprops(l==8, 'all');
imshow(prop.Image); 
% kawałek skrzydła sprawia, że kaczka jest nietypowa

