clear all; close all;

L = 50;
a = [110, -110, 0, 0, 77.8, -77.8, 77.8, -77.8];
b = [0, 0, 110, -110, 77.8, 77.8, -77.8, -77.8];

% a = [101.6, 42.1, -42.1, -101.6, -101.6, -42.1, 42.1, 101.6];
% b = [42.1, 101.6, 101.6, 42.1, -42.1, -101.6, -101.6, -42.1];


Org = imread('flower.bmp');    % Œ´‰æ‘œ
width = 280;
height = 280;
variety = 3;

for r=1:1:8
    filename = sprintf('orgColor/org%d.bmp',r);

    for i=1:1:width
       for j=1:1:height
           for k=1:1:3
            outRGB = calcLabToRGB(L, a(r), b(r));
            Org(i,j,k) = outRGB(k);
           end
        end
    end


imshow(Org);
imwrite(Org,filename,'bmp')
end