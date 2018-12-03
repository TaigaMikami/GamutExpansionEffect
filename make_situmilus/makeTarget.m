clear all; close all;

%% a,bを指定しそれをターゲットパッチの形にくり抜くプログラム

L = 50;
a = [40, -40, 0, 0];
b = [0, 0, 40, -40];

% a = [101.6, 42.1, -42.1, -101.6, -101.6, -42.1, 42.1, 101.6];
% b = [42.1, 101.6, 101.6, 42.1, -42.1, -101.6, -101.6, -42.1];


Org = imread('makeTarget/target.bmp');    % 原画像
width = 280;
height = 280;
variety = 3;

% filename = sprintf('outputTarget/target_b_40.bmp');
filename = sprintf('outputTarget/target_b_40.bmp');
r = 4;

for i=1:1:width
   for j=1:1:height
       for k=1:1:3
           if Org(i,j,k) < 100
            outRGB = calcLabToRGB(L, a(r), b(r));
            Org(i,j,k) = outRGB(k);
           else
            outRGB = calcLabToRGB(0, 0, 0);
            Org(i,j,k) = outRGB(k);
%             disp(outRGB)
           end
        end
    end
end

imshow(Org);
imwrite(Org,filename,'bmp')
