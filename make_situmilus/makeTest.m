%% 背景領域（複数）とターゲット領域を掛け合わせる

close all;
clear all;

% Target =imread('outputTarget/target_b_40.bmp');    % 原画像
select_color = 'y'; %ターゲットのカラーカテゴリ選択

backFolder = ['outputBack' filesep]; % 画像を保存しているフォルダ名
backFileList = dir([backFolder '*.bmp']); % 画像の形式
backNum = size(backFileList, 1); % フォルダ内の画像の枚数

for m = 1:1:backNum
    target_file = sprintf('outputTarget/target_%s_40.bmp', select_color);
    Target =imread(target_file);    % 原画像
    backFileName = char(backFileList(m).name); % 画像のファイル名（フォルダ情報なし）
    backFileName2 = [backFolder backFileName]; % 画像のファイル名（フォルダ情報あり）
    back_read = imread(backFileName2, 'bmp'); % ランダムに決定された一枚の画像 
    disp(backFileName2)
    [width,height,val] = size(Target);
    
    imshow(back_read);
    
    for i=1:1:width
       % disp(i);
       for j=1:1:height
           for k=1:1:3
              if (Target(i,j,1) == 0) && (Target(i,j,2) == 0) && (Target(i,j,3) == 0)
                    Target(i,j,1) = back_read(i,j,1);
                    Target(i,j,2) = back_read(i,j,2);
                    Target(i,j,3) = back_read(i,j,3);
              else
%                   disp(Target(i,j,k))
              end
           end
        end
    end
    back_name = strrep(backFileName, '.bmp', '');
    filename = sprintf('testSitumilus/%s/test_%s_%s.bmp',select_color, select_color, back_name);
    imwrite(Target,filename,'bmp');
end
