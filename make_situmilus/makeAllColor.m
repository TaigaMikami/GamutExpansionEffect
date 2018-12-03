clear all; close all;

%% Lab色空間においてすべての色を出すプログラム

L = 50;
% Org = imread('flower.bmp');    % 原画像
width = 280;
height = 252;

r = 110;
kakudo = 0;

m = 14;

for i=1:m:height
   for j=1:m:width
       kakudo = kakudo + 1;
       x = r * cosd(kakudo);
       y = r * sind(kakudo);
       for k=1:1:3
          disp(r)
          outRGB = calcLabToRGB(L, x, y);
          Org(i:i+m-1,j:j+m-1,k) = outRGB(k);
        end
    end
end

imshow(Org);
imwrite(Org,'img/allColor.bmp','bmp');