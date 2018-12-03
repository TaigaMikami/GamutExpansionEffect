clear all; 
close all;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% オリジナル画像作成プログラム
%
%　オリジナル背景とターゲット領域を合体させる
%
%
%                    made by 三上大河
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%% 画像の読み込み %%%%%%%%%%%
Org=imread('wool-target_ave_controll.bmp');    % 原画像
Mk = imread('sokedImage/match/wool/bulr/wool-target_bulr100.bmp');
Mk_ave = imread('wool-target_ave.bmp');

% ++++++++++++縦横のサイズ+++++++++++
[width,height,val] = size(Org);
Mk_flag = zeros(width,height,val);

% for k=1:1:3
%     for i=1:1:width
%        % disp(i);
%        for j=1:1:height
%           if Mk(i,j,k) == 0
%             Mk_flag(i,j,k) = 1;
%             Mk(i,j,k) = Org(i,j,k);
%           end
%         end
%     end
% end

for k=1:1:3
    for i=1:1:width
       % disp(i);
       for j=1:1:height
          if Mk_ave(i,j,k) == 0
            %Org(i,j,k) = Mk(i,j,k);
            Mk(i,j,k) = Org(i,j,k);
          end
        end
    end
end



%%%　ビット数変換
Mk = uint8(Mk);



%%% 変換画像(Org)表示
figure;  imagesc(Mk); axis image;
imwrite(Mk,'wool-target_bulr_controll.bmp','bmp');