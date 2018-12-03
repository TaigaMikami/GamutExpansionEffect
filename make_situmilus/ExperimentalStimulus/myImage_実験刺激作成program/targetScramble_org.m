clear all; close all;

%%%%%%%%%%% 画像の読み込み %%%%%%%%%%%
Org=imread('img/flower/flower-target.bmp');    % 原画像
Mk = imread('img/flower/flower_ave.bmp');


% ++++++++++++縦横のサイズ+++++++++++
%width = 280; height = 280;
[width,height,val] = size(Org);

RGB = Org;
box2 = zeros(width,height,val);
R = Org(:,:,1);
G = Org(:,:,2);
B = Org(:,:,3);
R2 = Org(:,:,1);
G2 = Org(:,:,2);
B2 = Org(:,:,3);

count = 0;
patch_num = 0;
flag = 0;

sep = 20;  %ランダムパッチの分割数  画素数を割り切れる数にしないとエラーを吐く

box1R = zeros(height/sep,width/sep);
box2R = zeros(height/sep,width/sep);
box1G = zeros(height/sep,width/sep);
box2G = zeros(height/sep,width/sep);
box1B = zeros(height/sep,width/sep);
box2B = zeros(height/sep,width/sep);


for i1 = 0:sep-1
    for j1 = 0:sep-1
        boxst_x = i1 * (width/sep) + 1;
        boxst_y = j1 * (height/sep) + 1;
        boxen_x = (i1 + 1) * (width/sep); 
        boxen_y = (j1 + 1) * (height/sep); 

        for i = boxst_y:boxen_y
             for j = boxst_x:boxen_x
                 if (R(i,j) ~= 0) && (G(i,j) ~= 0) && (B(i,j) ~= 0)
                     flag = 1; %R:0 G:0 B:0があればフラグを立てる
                     count = count + 1; %黒のピクセルをカウント
                     count2 = count2 + 1;
                 end
             end
        end
        if (flag == 1) && count >= 132
            patch_num = patch_num + 1;
            for i = boxst_y:boxen_y
                 for j = boxst_x:boxen_x
    %                     box2R(m,n) = R(i,j);
    %                     box2G(m,n) = G(i,j);
    %                     box2B(m,n) = B(i,j);
                        R(i,j) = 255;
                        G(i,j) = 255;
                        B(i,j) = 255;
                 end
            end
        end
     
        count = 0;
        flag = 0;

    end
end

% %% 確認
% for i = 1:height
%     for j = 1:width
%         RGB(i,j,1) = R(i,j);
%         RGB(i,j,2) = G(i,j);
%         RGB(i,j,3) = B(i,j);
%     end
% end
% 
% figure(1),
% imshow(RGB);

for i1 = 0:sep-1
    for j1 = 0:sep-1
        boxst_x = i1 * (width/sep) + 1;
        boxst_y = j1 * (height/sep) + 1;
        boxen_x = (i1 + 1) * (width/sep); 
        boxen_y = (j1 + 1) * (height/sep); 
        
        m = 0;
        n = 0; 
        if (R(boxst_y,boxst_x) == 255) && (G(boxst_y,boxst_x) == 255) && (B(boxst_y,boxst_x) == 255)
            for i = boxst_y:boxen_y
                m = m + 1;
                 for j = boxst_x:boxen_x
                     n = n + 1;
                     box2R(m,n) = R2(i,j);
                     box2G(m,n) = G2(i,j);
                     box2B(m,n) = B2(i,j);
                 end
            end
        end
         roop = 1;
         %　無限ループ
         %　画像が埋め込んであれば再抽選
         while roop == 1
            i2 = rand() * sep;
            i2 = fix(i2);
            j2 = rand() * sep;
            j2 = fix(j2);          
           
            boxst1x = i2 * (width/sep) + 1;
            boxst1y = j2 * (height/sep) + 1;
            boxen1x = (i2 + 1) * (width/sep);
            boxen1y = (j2 + 1) * (height/sep);
         
            if (R(boxst1x,boxst1y) == 255) && (G(boxst1x,boxst1y) == 255) && (B(boxst1x,boxst1y) == 255)
                m = 0;
                n = 0;
                roop = 0;
                for i = boxst1y:boxen1y
                    m = m + 1;
                    for j = boxst1x:boxen1x
                        n = n + 1;
                            R(i,j) = box2R(m,n);
                            G(i,j) = box2G(m,n);
                            B(i,j) = box2B(m,n);
                                
                    end
                    n = 0;
                end
            end
        end
    end
end

%% 確認
for i = 1:height
    for j = 1:width
        RGB(i,j,1) = R(i,j);
        RGB(i,j,2) = G(i,j);
        RGB(i,j,3) = B(i,j);
    end
end


%%　画像表示
figure(1),
imshow(RGB);

figure(2),
imshow(Org);

