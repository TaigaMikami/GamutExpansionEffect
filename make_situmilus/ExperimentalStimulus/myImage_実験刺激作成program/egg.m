clear all; close all;

%%%%%%%%%%% 画像の読み込み %%%%%%%%%%%
Org = imread('img/flower_org.bmp');    % 原画像
Org = rgb2gray(Org)

%% 細胞の検出
[~, threshold] = edge(Org, 'sobel');
fudgeFactor = .5;
BWs = edge(Org,'sobel', threshold * fudgeFactor);
figure, imshow(BWs), title('binary gradient mask');

%% イメージの拡張
se90 = strel('line', 3, 90);
se0 = strel('line', 3, 0);

BWsdil = imdilate(BWs, [se90 se0]);
figure, imshow(BWsdil), title('dilated gradient mask');

%%　内部のギャップを塗りつぶす
BWdfill = imfill(BWsdil, 'holes');
figure, imshow(BWdfill);
title('binary image with filled holes');

%% 境界に接触するオブジェクトの削除
BWnobord = imclearborder(BWdfill, 4);
figure, imshow(BWnobord), title('cleared border image');

BWnobord = imclearborder(BWdfill, 8);
figure, imshow(BWnobord), title('cleared border image');