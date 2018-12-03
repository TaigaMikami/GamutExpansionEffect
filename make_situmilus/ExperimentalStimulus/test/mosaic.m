clear all; close all; % Magical words

%%%%%%%%%%% Loading Image %%%%%%%%%%%
Org = imread('img/flower_org.bmp');    % Original image

[width,height,variety] = size(Org); % loading width height RGB
m = 14; % procesed pixcel size

%%%%%%%%%%% Image Processing %%%%%%%%%%%
for k=1:1:3 
    for i=1:m:width
       for j=1:m:height
          % Average processing for specified pixels
          Org(i:i+m-1,j:j+m-1,k) = mean2(Org(i:i+m-1,j:j+m-1,k));
        end
    end
end

% Image show
imshow(Org);

