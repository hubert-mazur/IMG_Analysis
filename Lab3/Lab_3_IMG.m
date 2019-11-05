% Transformata Fouriera
clear;
clc;

im = double (rgb2gray(imread('opera.jpg'))/255);

t = fft2 (im);

A = abs(t);
phi = angle(t);

%imshow(phi, [-pi, pi]);

%ifft2 - odwrotna transformata
% 1i to jednostka urojona, przy samym i interpreter sie czepia

%phi (1,1) = phi(1,1) + pi; % zrobila sie inwersja

phi = fftshift(phi);

% amplituda wpływa na jasności

A(200,200) = 1e5;

lA = log(A);

maxA = log(max(A(:))); % maksymalna wartość  

%imshow(lA, [0, maxA]);
% funkcja fftshift zamienia ćwiartki miejscami
% pokazuje jak bardzo są podobne punkty znajdujące się w danej odległości
% od innych --> im bliżej środka, tym bardziej punkty są do siebie podobne

% niskie częstotliwości są w środku, wysokie odwrotnie



imshow(fftshift(lA), [0, maxA]);

Kt = A .* exp(1i * phi);

cim2 = ifft2(Kt);

im2 = abs(cim2);

%imshow(im2); 

[h,w] = size(im);
m = zeros(h,w);

m(200:end-200, 300:end-300) = 1; 
A = A .* fftshift(m); 

imshow(fftshift(log(A)), [0, maxA]);

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







