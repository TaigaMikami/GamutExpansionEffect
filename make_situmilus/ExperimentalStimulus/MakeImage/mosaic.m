clear all; close all;

%%%%%%%%%%% ‰æ‘œ‚Ì“Ç‚İ‚İ %%%%%%%%%%%
Org = imread('OriginalImage/flower.bmp');    % Œ´‰æ‘œ

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

