clear all; close all;

L = 50;
a = [40, -40, 0, 0];
b = [0, 0, 40, -40];

% a = [101.6, 42.1, -42.1, -101.6, -101.6, -42.1, 42.1, 101.6];
% b = [42.1, 101.6, 101.6, 42.1, -42.1, -101.6, -101.6, -42.1];


Org = imread('makeTarget/target.bmp');    % Œ´‰æ‘œ
width = 280;
height = 280;
variety = 3;

% filename = sprintf('outputTarget/target_b_40.bmp');
r = 2;

for m=0:5:110
    for i=1:1:width
       for j=1:1:height
           for k=1:1:3
               if Org(i,j,k) > 255
                disp(m);
                outRGB = calcLabToRGB(L, 0, m*(-1));
                MK(i,j,k) = outRGB(k);
               else
                outRGB = calcLabToRGB(L, 0, 0);
                MK(i,j,k) = outRGB(k);
               end
            end
        end
    end

    %imshow(Org);
    filename = sprintf('matchSitumilus/c/target_b_%d.bmp', m);
    imwrite(MK,filename,'bmp')
end
