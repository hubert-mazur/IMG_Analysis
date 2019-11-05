clear; clc;
im = imread('cat.jpg'); % wczytanie obrazu
im = double (im)/255; % konwersja do double
im = rgb2gray(im); % konwersja do odcieni szarości
% imhist(im); - tworzy histogram obrazu
% w tym przypadku, histogram będzie reprezentował częstość wystąpienia
% jasności
%subplot(h,w,i); - dzieli okno na h wierszy, w kolumn, i- obszar
h = 8;
w = 2;
i = 1;


% cechy:
% jasność --> + b - przedział (-1,1)
% kontrast- różnica pomiędzy dwiema wartościami --> *c - przedział (0,+inf)
% gamma - .^g (potęgowanie) --> przedział (0, +inf)

%%% jasność
b = 0.4; % ustawiamy zwspółczynnik zmiany jasności
im_b = im + b;
im_b(im_b>1) = 1; % w przypadku wyjścia poza zakres
im_b(im_b<0) = 0; %
%%% / jasność

im_c = im * .5;

subplot(h,w,i);
imshow(im);
title("Obraz w skali szarości");
subplot(h,w,i+1);
imhist(im);
title("Histogram obrazu w skali szarości")
subplot(h,w,i+2);
imshow(im_b);
title("Obraz w skali szarości z większą jasnością, b=0.4");
subplot(h,w,i+3)
imhist(im_b);
title("Histogram obrazu w skali szarości z większą jasnością");
subplot(h,w,i+4);
imshow(im_c);
title("Obraz w skali szarości z większym kontrastem");
subplot(h,w,i+5);
imhist(im_c);
title("Histogram obrazu ze zmienionym kontrastem");

g = 2; % ustawiamy gamme
im_g = im .^g;

subplot(h,w,i+6);
imshow(im_g);
title("Obraz ze zmienioną gammą");
subplot(h,w,i+7);
imhist(im_g);
title("Histogram obrazu ze zmienioną gammą");


%plot(x,y) - rysuje wykres
xlim([0,1]); % zakres osi x
ylim([0,1]); % zakres osi y
axis equal; % sprawia, że jednostki na osiach są takie same

x = (0: 1/255 :1); % tworzymy wektor x, w przedziale [0-1] z krokiem 1/255
b_y = x+b; 
b_y(b_y>1) = 1; % normalizacja
b_y(b_y<0) = 0; %


subplot(h,w,i+8);
plot(x,b_y);

c = 5;
y_c = x * c;
y_c(y_c>1) = 1;
y_c(y_c<0) = 0;
subplot(h,w,i+9);
plot(x,y_c);

g = 0.4;

y_g = x .^g;

subplot(h,w,i+10);
plot(x,y_g);

% zazwyczaj jest: x ^ (1/g) - aby jasnosc rosła wraz ze wzrostem gammy
% kontrast i gamme przedstawia się czesto w skali logarytmicznej

g = 3;
c = 1.5;
y = c * x.^g + b; % skrócony zapis, jednoczesna korekta wszystkich parametrów obrazu 
subplot(h,w,i+12);
plot(x,y);

im_bcg = c * im.^g + b;

subplot(h,w,i+12);
imshow(im_bcg);
title("Obraz po korekcji: b=0.4; c = 1.5; g=3");
subplot(h,w,i+13);
imhist(im_bcg);
title("Histogram obrazu po korekcji");

% dla inwersji  --> b = 1, c = -1, g = 1

% im_eq = histeq(im) - wyrównanie histogramu
subplot(h,w,i+14);
eq_im = histeq(im);
imshow(eq_im);
title("Obraz po wyrównaniu histogramu");
subplot(h,w,i+15);
imhist(eq_im);
title("Wyrównany histogram obrazka");