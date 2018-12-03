clear all; close all;

%%%%%%%%%%% 画像の読み込み %%%%%%%%%%%
Org=imread('img/P3RGB_conversion.bmp');    % 原画像
Mk = imread('img/P3RGB_conversion-target.bmp');


% ++++++++++++縦横のサイズ+++++++++++
%width = 280; height = 280;
[width,height] = size(Org);

R = Org(:,:,1);
G = Org(:,:,2);
B = Org(:,:,3);

RGBm=double(Mk);
RGBm=RGBm/255;

%%%%%maskの準備
mask = zeros(width+1,height+1);

%%%mask(i,j)にはi,jのマスクの明るさが入っている．黒＝０，白＝１
    for i = 1:width     
        for j= 1:height  
            mask(i,j) = (RGBm(i,j,1)+RGBm(i,j,2)+RGBm(i,j,3))/3;
        end
    end

%%%%%ランダム処理%%%%%%%%%%
sep = 20;  %ランダムパッチの分割数  画素数を割り切れる数にしないとエラーを吐く
% str = 250;  %a* b* の中心からの距離　０～２５５

deg = zeros(sep);
cells = zeros(sep);

box1L = zeros(height/sep,width/sep);
box2L = zeros(height/sep,width/sep);
box1a = zeros(height/sep,width/sep);
box2a = zeros(height/sep,width/sep);
box1b = zeros(height/sep,width/sep);
box2b = zeros(height/sep,width/sep);
mask_b = zeros(height/sep,width/sep);

flag_b = zeros(sep,sep);


%%maskが黒でない場合は入れ替えを行わない

for i1 = 0:sep-1
    for j1 = 0:sep-1
         %%%%box2に入れ替え起点の情報を保存する
         %%%%box2のmaskが黒でない場合終了して次の箱に
         boxst2x = i1 * (width/sep) + 1;
         boxst2y = j1 * (height/sep) + 1;
         boxen2x = (i1 + 1) * (width/sep); 
         boxen2y = (j1 + 1) * (height/sep); 
         m = 0;
         n = 0;
         for i = boxst2y:boxen2y
             m = m + 1;
             for j = boxst2x:boxen2x
                 n = n + 1;
                 box2L(m,n) = R(i,j);
                 box2a(m,n) = G(i,j);
                 box2b(m,n) = B(i,j);
                 mask_b(m,n) = mask(i,j);
             end
             n = 0;
         end
         mask_fs = 0;
         for i = 1:height/sep
             for j = 1:width/sep
                 mask_fs = mask_b(i,j) + mask_fs;
             end
         end
          mask_fs = mask_fs / ((width/sep) * (height/sep));
         
         if mask_fs == 0
             
             roop = 1;
            %　無限ループ
            %　画像が埋め込んであれば再抽選
             while roop == 1
                 i2 = rand() * sep;
                 i2 = fix(i2);
                 j2 = rand() * sep;
                 j2 = fix(j2);          
                 %%%%box1に入れ替え先の情報を保存する
                 %%%%box1のmaskが黒でない場合入れ替え先のj2i2を再抽選
       
                 boxst1x = i2 * (width/sep) + 1;
                 boxst1y = j2 * (height/sep) + 1;
                 boxen1x = (i2 + 1) * (width/sep);
                 boxen1y = (j2 + 1) * (height/sep);
                 
                 mask_fe = 0;
                 m = 0;
                 n = 0;            
                 for i = boxst1y:boxen1y
                     m = m + 1;
                     for j = boxst1x:boxen1x
                         n = n + 1;
                         box1L(m,n) = R(i,j);
                         box1a(m,n) = G(i,j);
                         box1b(m,n) = B(i,j);
                         mask_b(m,n) = mask(i,j);
                     end
                     n = 0;
                 end
                 for i = 1:width/sep
                     for j = 1:height/sep
                         mask_fe = mask_b(i,j) + mask_fe;
                     end
                 end
                 mask_fe = mask_fe / ((width/sep) * (height/sep));
                 if mask_fe == 0 %画像が埋まっているかを判断
                     roop = 0;
                 end
             end

             %boxに入れた物を裏返す
             r = rand() * 2; 
             r = fix(r); %０か１のランダム
             if r == 0               
                 box2L = box2L';         
                 box2a = box2a';         
                 box2b = box2b';               
             end
             m = 0; 
             n = 0; 
             for i = boxst1y:boxen1y 
                 m = m + 1;  
                 for j = boxst1x:boxen1x    
                     n = n + 1;      
                     R(i,j) = box2L(m,n);       
                     G(i,j) = box2a(m,n);       
                     B(i,j) = box2b(m,n);       
                 end
                 n = 0;      
             end
             m = 0;      
             n = 0;      
             for i = boxst2y:boxen2y     
                 m = m + 1;      
                 for j = boxst2x:boxen2x        
                     n = n + 1;         
                     R(i,j) = box1L(m,n);
                     G(i,j) = box1a(m,n);           
                     B(i,j) = box1b(m,n);                     
                 end
                 n = 0;
             end
         end
    end
end

%%% sRGBの結合
RGB = zeros(height,width,3);

for i = 1:height
    for j = 1:width
        RGB(i,j,1) = R(i,j);
        RGB(i,j,2) = G(i,j);
        RGB(i,j,3) = B(i,j);
    end
end

%%%　ビット数変換
RGB = uint8(RGB);



%%% 変換画像(RGB)表示
figure;  imagesc(RGB); axis image;
imwrite(RGB,'img/flower_org_random.bmp','bmp');
