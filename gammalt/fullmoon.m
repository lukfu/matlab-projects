clear; close all;

Itif = imread('fullmoon1712.jpg');
Igray = rgb2gray(Itif);
clear Itif;
Idob=im2double(Igray);
clear Igray;

%imshow(Idob);

[x1,y1,z1] = size(Idob);

my1=1190;
my2=2325;
mx1=945;
mx2=2067;

nx=mx2-mx1;
ny=my2-my1;

A=zeros(nx,ny);

for i=1:nx
    for j=1:ny
            A(i,j)=Idob(mx1+i,my1+j);
    end
end

PSF = fspecial('gaussian',5,5);
AA = deconvlucy(A, PSF, 5);
%AA=A;

B = imadjust(AA);
C = histeq(AA);
D = adapthisteq(AA);
K = medfilt2(D); % median filter the noisy image
F = deconvlucy(K, PSF, 10);

imshow([A,K,F])

imwrite(A,'moon1.tif')
imwrite(K,'moon2.tif')
imwrite(F,'moon3.tif')