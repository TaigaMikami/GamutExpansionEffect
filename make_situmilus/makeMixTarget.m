clear all; close all;

%% ミックスターゲットをターゲットパッチにくり抜くプログラム

Org = imread('makeTarget/target.bmp');    % 原画像
Mix = imread('mixTarget/mix_40_all_8.bmp');    % 原画像
width = 280;
height = 280;
variety = 3;

% filename = sprintf('outputTarget/target_b_40.bmp');
filename = sprintf('outputTarget/mix_40_all4_8.bmp');
r = 4;

for i=1:1:width
   for j=1:1:height
       for k=1:1:3
           if (Org(i,j,1) == 0) && (Org(i,j,2) == 0) && (Org(i,j,3) == 0)
                Org(i,j,1) = Mix(i,j,1);
                Org(i,j,2) = Mix(i,j,2);
                Org(i,j,3) = Mix(i,j,3);
           elseif (Org(i,j,1) ~= Mix(i,j,1)) || (Org(i,j,2) ~= Mix(i,j,2)) || (Org(i,j,3) ~= Mix(i,j,3))
                outRGB = calcLabToRGB(0, 0, 0);
                Org(i,j,k) = outRGB(k);
            %             disp(outRGB)
           end
       end
    end
end

imshow(Org);
imwrite(Org,filename,'bmp')
