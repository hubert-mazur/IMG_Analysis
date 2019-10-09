clear; clc;
% to jest komentarz
% szybkie komentowanie- ctrl + r, odkomentowanie ctrl + t
% komentarz blokowy- % {, %}
% łamanie linii- a = [1,2,3; ...
%4,5,6];
% rozwiżanie ukadu równań
% wyznacznik macierzy to det

% A = [1,2,3,4; 25,16,9,4; 2,3,5,7; 3,8,5,2];
% b = [1;2;3;4];
% 
% Ax1 = A;
% Ax2 = A;
% Ax3 = A;
% Ax4 = A;
% 
% 
%    Ax1 (:,1) = b;
%    Ax2 (:,2) = b;
%    Ax3 (:,3) = b;
%    Ax4 (:,4) = b;
% 
% 
% dA = det(A);
% 
% x1 = det(Ax1) / dA
% x2 = det(Ax2) / dA
% x3 = det(Ax3) / dA
% x4 = det(Ax4) / dA
% 
% X = A^-1 * b % szybkie rowziązanie

image = imread('cat.jpg');
image = double (image)/255;
% imshow(image) - pokazuje obrazek
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% imshow(image(:,:,1))
% imcp = image;
% imcp(:,:,[2,3]) = 0;
% imshow(imcp);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

grayimg = mean(image,3); % chcemy trzeci wymiar uśrednić
imshow(grayimg)

% standard YUV- [.299, .587, .114] - optymalne wagi dla RGB
% w = [.299,.587,.114];
% w = permute(w,[1,3,2]);
% grayimg = image.*w;
% grayimg = sum(grayimg,3);
% imshow(grayimg)

rgb2gray(image);
imshow(image)

