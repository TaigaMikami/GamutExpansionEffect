clear all; close all;

%%%%%%%%%%% �摜�̓ǂݍ��� %%%%%%%%%%%
Org = imread('img/flower_org.bmp');    % ���摜

[width,height,variety] = size(Org);
m = 14;

for k=1:1:3
    for i=1:m:width
        %disp(i);
       for j=1:m:height
          Org(i:i+m-1,j:j+m-1,k) = mean2(Org(i:i+m-1,j:j+m-1,k));
        end
    end
end
imshow(Org);

