%% 背景とターゲットを合わせる 改良前版

clear all; close all;

%%%%%%%%%%% 画像の読み込み %%%%%%%%%%%
Target =imread('outputTarget/target_r_40.bmp');    % 原画像
Back = imread('img/back.bmp');

%%%%三上大河org

% ++++++++++++縦横のサイズ+++++++++++

[width,height,val] = size(Target);


for k=1:1:3
    for i=1:1:width
       % disp(i);
       for j=1:1:height
          if Target(i,j,k) >  0
            Target(i,j,k) = Back(i,j,k);
          end
        end
    end
end



%%%　ビット数変換
OutputImage = uint8(Target);



%%% 変換画像(Org)表示
figure;  imagesc(OutputImage); axis image;
imwrite(OutputImage,'testSitumilus/test_r.bmp','bmp');
