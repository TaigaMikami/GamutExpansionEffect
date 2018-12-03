clear all; close all;

L = 50;

%% ミックスターゲットのテクスチャ作成プログラム

%% C* = 110
% r
% a = [110, 101.6, 101.6]; 
% b = [0, 42.1, -42.1];

% g
% a = [-110, -101.6, -101.6]; 
% b = [0, 42.1, -42.1];

% y
% a = [0, 42.1, -42.1];
% b = [110, 101.6, 101.6]; 

% b
% a = [0, 42.1, -42.1];
% b = [-110, -101.6, -101.6];

%% C* = 40
% r 
% a = [40, 37.0, 37.0]; 
% b = [0, 15.3, -15.3];

% g
% a = [-40, -37.0, -37.0]; 
% b = [0, 15.3, -15.3];

% y
% a = [0, 15.3, -15.3];
% b = [40, 37.0, 37.0]; 

% b
% a = [0, 15.3, -15.3];
% b = [-40, -37.0, -37.0]; 

% a = [101.6, 42.1, -42.1, -101.6, -101.6, -42.1, 42.1, 101.6];
% b = [42.1, 101.6, 101.6, 42.1, -42.1, -101.6, -101.6, -42.1];

%% 4方向
a = [40, -40, 0, 0];
b = [0, 0, 40, -40];
ab_size = size(a);

Org = imread('flower.bmp');    % 原画像
width = 280;
height = 280;
variety = 3;

m = 8;
filename = sprintf('mixTarget/mix_40_all_%d.bmp',m);
count_arr = zeros(1,ab_size(2));

for i=1:m:width
   for j=1:m:height
       r = randi([1 ab_size(2)],1);
       while count_arr(r) >= (280/m)*(280/m)/ab_size(2);
         r = randi([1 ab_size(2)],1);
       end
       count_arr(r) = count_arr(r) + 1;
       for k=1:1:3
          outRGB = calcLabToRGB(L, a(r), b(r));
          Org(i:i+m-1,j:j+m-1,k) = outRGB(k);
        end
    end
end

imshow(Org);
imwrite(Org,filename,'bmp')