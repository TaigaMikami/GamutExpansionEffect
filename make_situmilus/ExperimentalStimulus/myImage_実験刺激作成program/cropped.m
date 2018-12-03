clear all;
close all;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 画像トリミング用プログラム
%
%　画像の大きさを280×280にそろえる
%
%
%                    made by 三上大河
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%% 画像の読み込み %%%%%%%%%%%
Org=imread('img/plastic_object.jpg');    % 原画像
%Model=imread('img/flower_org.bmp');    % 原画像

%[width,height,val] = size(Model);

% 画像のトリミング
Org2 = imcrop(Org,[20 0 379 380]);
% 画像のリサイズ
Org3 = imresize(Org2,[280 280]);


figure(1),
imshow(Org);

% figure(2),
% imshow(Model);

figure(3)
imshow(Org3);
title('Cropped Image');

imwrite(Org3,'img/platic-org.bmp','bmp');