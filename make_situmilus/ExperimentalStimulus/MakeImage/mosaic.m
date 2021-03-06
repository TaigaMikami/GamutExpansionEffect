clear all; close all;

%%%%%%%%%%% 画像の読み込み %%%%%%%%%%%
Org = imread('OriginalImage/flower.bmp');    % 原画像

[width,height,variety] = size(Org);
m = 28;

for k=1:1:3
    for i=1:m:width
       for j=1:m:height
          Org(i:i+m-1,j:j+m-1,k) = mean2(Org(i:i+m-1,j:j+m-1,k));
          disp(mean2(Org(i:i+m-1,j:j+m-1,k)))
        end
    end
end
imshow(Org);

