% Transformata Fouriera
% clear;
% clc;
% 
% im = imread('opera.jpg');
% im = double (im) / 255;
% im = rgb2gray(im);
% imwrite(im, 'obraz_w_skali_szarosci.jpg');
% % figure;
% % imshow(im)
% 
% t = fft2 (im);
% 
% A = abs(t);
% phi = angle(t);
% 
% % figure;
% % imshow(phi, [-pi, pi]);
% % ifft2 - odwrotna transformata
% % 1i to jednostka urojona, przy samym i interpreter sie czepia
% 
% phi (1,1) = phi(1,1) + pi; % zrobila sie inwersja
% 
% % phi = fftshift(phi);
% % imshow(phi, [-pi, pi]);
% 
% % amplituda wpływa na jasności
% 
% % A(200,200) = 1e5;
% 
% % lA = log(A);
% 
% % maxA = log(max(A(:))); % maksymalna wartość  
% 
% %imshow(lA, [0, maxA]);
% % funkcja fftshift zamienia ćwiartki miejscami
% % pokazuje jak bardzo są podobne punkty znajdujące się w danej odległości
% % od innych --> im bliżej środka, tym bardziej punkty są do siebie podobne
% 
% % niskie częstotliwości są w środku, wysokie odwrotnie
% 
% 
% 
% % imshow(fftshift(lA), [0, maxA]);
% 
% Kt = A .* exp(1i * phi);
% 
% cim2 = ifft2(Kt);
% 
% im2 = abs(cim2);
% 
% % imshow(im2); 
% imwrite(im2, 'obraz_po_transformacie_odwrotnej.jpg');
% 
% 
% phi(1,1) = phi(1,1) + pi; 
% 
% Kt = A.*exp(1i * phi); 
% Cim2=ifft2(Kt); 
% im2=abs(Cim2);
% figure;
% imshow(im2);





% [h,w] = size(im);
% m = zeros(h,w);

% m(200:end-200, 300:end-300) = 1; 
% A = A .* fftshift(m); 

% imshow(fftshift(log(A)), [0, maxA]);

% SPRAWOZDANIE NA 19.11.2019 do 9:26 na mail fis.agh.edu.pl
% obrazki podpisywać, dla wykresów należy dodać legendę
% pisać podsumowanie obrazków, wykresów
% 1. ogólne przekształcenia- jasność, kontrast, gamma, wyrównanie
% histogramu, histogramy, histogram obrazu, wykresy przekształceń,
% maskowanie

% 2. filtrowanie- uśredniające- dolnoprzepustowy, górnoprzepustowy,
% medianowy, fspecial(), gauss, motionblur, prewitt, binaryzacja, próg-
% metoda Otsu, adaptive, operacje morfologiczne- erozja, dylatacja,
% otwarcie, zamknięcie, krawędzie, filtr medianowy na binarnym obrazie

% 3. Bez teoretycznego wstępu, fourier, widmo amplitudowe i fazowe, co się
% dzieje zmieniając te wartości, ifft2, filtrowanie, kompresja



clear; clc;

% im=rgb2gray(double(imread('zubr.jpg'))/255);
% % robimy maskę 
% bim = ~imbinarize(im);
% % mask = im.*bim; % wycinamy to co nas nie interetuje, to nasza maska
% % imshow(mask);
% % figure;
% % imshow(bim); % tu zubr powinien byc bialy
% % cokolwiek zrobimy to mozemy tego uzyc jako maski, zwykle to co jest
% % prymitywniejsze nazywamy maską ale to nawet moze byc inny obraz nic nie
% % stoi na przeszkodzie
% 
% % transformata fouriera lets go
% amplituda A e [0, +inf]
% faza phi e [0, 2pi], [-pi, pi] - zeby przedział był 2pi
% 

im=rgb2gray(double(imread('opera.jpg'))/255);
% figure;
% imshow(im);
imwrite(im, 'obraz_w_skali_szarosci.jpg');

% A sin(theta) + phi

%szybka transformata fouriera
t=fft2(im); % complex double
% chcemy pozac A, phi 
A= abs(t);
phi = angle(t); % ogarniamy to phi

% figure;
% imshow(phi, [-pi, pi]); % szum, zaden z punktow w phi nie koresponduje z obrazem opery
% kazdy z punktow reprezentuje jedna z funkcji o roznych czestosciach
% tym mozna wykrywac czy obraz byl edytowany i nienaturalny

% chcemy zobaczyc na tym widmie ^ czy cos zmienilismy
% ale najpierw zrobmy odwrotna transformate fouriera
Kt = A.*exp(1i * phi); % postac kanoniczna
Cim2=ifft2(Kt); % transformata odwrotna
im2=abs(Cim2);
imshow(im2);
% figure;
% imwrite(im2, 'obraz_po_transformacie_odwrotnej.jpg');
% 
% % dobra patrzymy co sie stanie jak zmienimy faze na przeciwną
phi(1)=phi(1)+pi; % faza na przeciwną - negatyw 
Kt = A.*exp(1i * phi); % postac kanoniczna
Cim2=ifft2(Kt); % transformata odwrotna
im2=abs(Cim2);
% imshow(im2);
% figure;
% imwrite(im2, 'negatyw.jpg');

% % to co wchodzilo z najwieksza wartoscia zmienilismy na negatyw
% 
phi(1,1) = phi(1,1) + pi; % jak zmieniamy faze to obraz sie zmienia
% % faza duzo mowi nam o ksztaltach, jakbysmy zmienili bardzo faze to
% % nie poznalibysmy opery
% 
Kt = A.*exp(1i * phi); 
Cim2=ifft2(Kt); 
im2=abs(Cim2);
% figure;
% imshow(im2);
imwrite(im2, 'obraz_po_zmianie_fazy.jpg');


maxA = max(A(:));
lA = log(A); % logarytm z tej amplitudy bo wygodniej
% wyswietlamy widmo amplitudowe
% figure;
% imshow(lA, [0, log(maxA)]); % takie rozblyski z rogów


% najwazniejsze funkcje w tym obrazie znajduja sie w rogach
% punkty obok siebie maja podobne wartosci
% funkcje o najwiekszych czestotliwosciach 

% zamieniamy 4 cwiartki miejscami aby te najwazniejsze wartosci znajdowaly
% sie w srodku a nie w rogach
% robi sie to funkcją fftshift - ona nic nie przelicza tylko zmienia
% cwiartki
% imshow(fftshift(lA), [0, log(maxA)]); % robi sie gwiazdka - w srodku ekstremalnie duze czestotliwosci

%zeby cos ciekawego zobaczyc zmienmy amplitude
A(200, 200)= 1e5;
maxA = max(A(:));
lA = log(A);
% figure;
% imshow(fftshift(lA), [0, log(maxA)]); % bialy piksel

% pionowa linia po srodku wchodzi z najwieksza wagą - tak samo pozioma na
% środku
% w pionie mają rozne bardzo duze a w poziome taką samą małą czestotliowsc

% robimy maskę - bialy prostokąt na srodku z czarnym tlem

[h, w] = size(im);
m=zeros(h,w);
% m(200:end - 200,300:end - 300) = 1;  % bardzo nie widac roznicy - kompresja !
m(400:end - 400, 600:end - 600) = 1; % zostawiajac minimalny kawaleczek widma pozostaje nam IDEA obrazka, na malej ikonce nie zobaczylibysmy roznicy
A = A.* fftshift(m); % zaaplikowanie prostokąta jako maski
maxA = max(A(:));
lA = log(A);
imshow(fftshift(lA), [0, log(maxA)]); %równo wycięte widmo amplitudowe w prostokącie
% Kt = A.*exp(1i * phi);
% Cim2=ifft2(Kt); % transformata odwrotna
% im2=abs(Cim2);
% imshow(im2);

% na transformacie fouriera filtorwanie ma mniejsza zlozonosc obliczeniową

% sprawkoo
% 3 ostatnie labki
% za 2 tyg, 18 listopada do 12:44 .pdf, mail fis.agh.edu.pl
% 
