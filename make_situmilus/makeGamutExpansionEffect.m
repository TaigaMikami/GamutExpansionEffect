clear all; close all;

%% 背景画像のテクスチャづくりのプログラム

L = 50;
a = [110, -110, 0, 0, 77.8, -77.8, 77.8, -77.8];
b = [0, 0, 110, -110, 77.8, 77.8, -77.8, -77.8];

% a = [101.6, 42.1, -42.1, -101.6, -101.6, -42.1, 42.1, 101.6];
% b = [42.1, 101.6, 101.6, 42.1, -42.1, -101.6, -101.6, -42.1];


Org = imread('flower.bmp');    % 原画像
width = 280;
height = 280;
variety = 3;

m = 35;
filename = sprintf('outputBack/back%d.bmp',m);
count_arr = zeros(1,8);

for i=1:m:width
   for j=1:m:height
       r = randi([1 8],1);
       while count_arr(r) >= (280/m)*(280/m)/8
         r = randi([1 8],1);
       end
       count_arr(r) = count_arr(r) + 1;
       for k=1:1:3
          disp(r)   
          outRGB = calcLabToRGB(L, a(r), b(r));
          Org(i:i+m-1,j:j+m-1,k) = outRGB(k);
        end
    end
end

imshow(Org);
imwrite(Org,filename,'bmp')