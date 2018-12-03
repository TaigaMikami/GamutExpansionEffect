close all;
clear all;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%メトリッククロマ変調により画像の彩度を変調させるプログラムのテスト%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%% 画像の読み込み %%%%%%%%%%%
% ImageName = 'bride';%N3_conversion 
% Imdata = imread(strcat(ImageName,'.bmp'));
filename = '252-152-3.bmp';
% Org = imread(strcat('img/workspace/',filename));
% Output = strcat('img/workspace/maked/',filename);
Org = imread(strcat('sokued_test/',filename));
%Output = strcat('sokued_test/',filename);
%%--------読み込む元画像の大きさ--------%%
[width,height,val] = size(Org);

RGBdo = double(Org);
%%---確認用---%%
Rtest = RGBdo(:,:,1);
Gtest = RGBdo(:,:,2);
Btest = RGBdo(:,:,3);
%%---読み込んだ画像を正規化---%% 
RGB = RGBdo./255;

% syms t;

%% ①RGB(非線形)からsRGBへの変換

%%---RGBからsRGBへの変換(標準規格)---%%
sRGB = zeros(height,width,3);
for k = 1:3                                            
    for i = 1:height                                    
        for j= 1:width                                      
            if RGB(i,j,k) <= 0.04045
                sRGB(i,j,k) = RGB(i,j,k)./12.92;
            else
                sRGB(i,j,k) = ((RGB(i,j,k)+0.055)./1.055).^2.4;
            end
        end
    end
end

%% ②RGBかXYZへの変換

%%---sRGBをXYZ(CIE1931)表色系に変換%%

imageXYZ = zeros(height,width,3);

imageXYZ(:,:,1) = sRGB(:,:,1).*0.4124+sRGB(:,:,2).*0.3576+sRGB(:,:,3).*0.1805;
imageXYZ(:,:,2) = sRGB(:,:,1).*0.2126+sRGB(:,:,2).*0.7152+sRGB(:,:,3).*0.0722;
imageXYZ(:,:,3) = sRGB(:,:,1).*0.0193+sRGB(:,:,2).*0.1192+sRGB(:,:,3).*0.9505;

%% ③XYZかYxyへの変換
L = imageXYZ(1,1,2);
x = imageXYZ(1,1,1)/(imageXYZ(1,1,1)+imageXYZ(1,1,2)+imageXYZ(1,1,3));
y = imageXYZ(1,1,2)/(imageXYZ(1,1,1)+imageXYZ(1,1,2)+imageXYZ(1,1,3));

disp(L);
disp(x);
disp(y);

