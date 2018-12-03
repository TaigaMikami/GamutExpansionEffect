clear all; close all;

%%%%%%%%%%% 画像の読み込み %%%%%%%%%%%
Ori=imread('img/flower_org.bmp');    % 原画像
Mk = imread('img/flower_only.bmp');


% ++++++++++++縦横のサイズ+++++++++++
width = 280; height = 280;


%%% 画像表示
%%% info=imfinfo('fruits.bmp');
%figure;  imagesc(Q);  axis image;
%figure;  imagesc(P);  axis image;



% Xred=X(:,:,1); Xgreen=X(:,:,2); Xblue=X(:,:,3);
RGBdo=double(Ori);
RGB=RGBdo/255;    %原画像     

RGBm=double(Mk);
RGBm=RGBm/255;

%%%%%maskの準備
mask = zeros(height,width);

%%%mask(i,j)にはi,jのマスクの明るさが入っている．黒＝０，白＝１
    for i = 1:height     
        for j= 1:width  
            mask(i,j) = (RGBm(i,j,1)+RGBm(i,j,2)+RGBm(i,j,3))/3;
        end
    end


%%% RGB -> sRGBへの変換（標準規格）
%原画像
sRGB = zeros(height,width,3); 
for k = 1:3
    for i = 1:height     
        for j= 1:width  
            if RGB(i,j,k) <= 0.04045
                sRGB(i,j,k) = RGB(i,j,k)/12.92;
            else
                sRGB(i,j,k) = ((RGB(i,j,k)+0.055)/1.055)^2.4;
            end
        end
    end
end



%%% sRGB -> XYZ(1931)への変換
% Mxyz = [0.4124,0.3576,0.1805;0.2126,0.7152,0.0722;0.0193,0.1192,0.9505]
% inv(Mxyz) = [3.2406,-1.5372,-0.4986;-0.9689,1.8758,0.0415;0.0557,-0.2040,1.0570]

%　原画像
x = sRGB(:,:,1)*0.4124+sRGB(:,:,2)*0.3576+sRGB(:,:,3)*0.1805;
y = sRGB(:,:,1)*0.2126+sRGB(:,:,2)*0.7152+sRGB(:,:,3)*0.0722;
z = sRGB(:,:,1)*0.0193+sRGB(:,:,2)*0.1192+sRGB(:,:,3)*0.9505;

X = x*100;
Y = y*100;
Z = z*100;


%%% XYZ(1931) -> Labへの変換
Xn = 95.04;
Yn = 100.00;
Zn = 108.83;

fx = zeros(height,width);
fy = zeros(height,width);
fz = zeros(height,width);

for i = 1:height
    for j= 1:width 
        if X(i,j)/Xn < 0.008856
            fx(i,j) = (903.3*X(i,j)/Xn+16)/116;
        else
            fx(i,j) = (X(i,j)/Xn)^(1/3);
        end
    end
end

for i = 1:height
    for j= 1:width 
        if Y(i,j)/Yn < 0.008856
            fy(i,j) = (903.3*Y(i,j)/Yn+16)/116;
        else
            fy(i,j) = (Y(i,j)/Yn)^(1/3);
        end
    end
end

for i = 1:height
    for j= 1:width 
        if Z(i,j)/Zn < 0.008856
            fz(i,j) = (903.3*Z(i,j)/Zn+16)/116;
        else
            fz(i,j) = (Z(i,j)/Zn)^(1/3);
        end
    end
end

L = 116*fy-16;
a = 500*(fx-fy);
b = 200*(fy-fz);


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
                 box2L(m,n) = L(i,j);
                 box2a(m,n) = a(i,j);
                 box2b(m,n) = b(i,j);
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
                         box1L(m,n) = L(i,j);
                         box1a(m,n) = a(i,j);
                         box1b(m,n) = b(i,j);
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
                     L(i,j) = box2L(m,n);       
                     a(i,j) = box2a(m,n);       
                     b(i,j) = box2b(m,n);       
                 end
                 n = 0;      
             end
             m = 0;      
             n = 0;      
             for i = boxst2y:boxen2y     
                 m = m + 1;      
                 for j = boxst2x:boxen2x        
                     n = n + 1;         
                     L(i,j) = box1L(m,n);
                     a(i,j) = box1a(m,n);           
                     b(i,j) = box1b(m,n);                     
                 end
                 n = 0;
             end
         end
    end
end


        


    
   
%Labの変調

%L = L * 1.000;
%a = a * 1.000;
%b = b * 1.000;







%%% Lab->XYZ変換
for i = 1:height
    for j= 1:width
        if L(i,j) > 903.3*0.008856
            y(i,j) = ((L(i,j)+16)/116)^3;
        else
            y(i,j) = L(i,j)/903.3;
        end
    end
end

for i = 1:height
    for j= 1:width
        if y(i,j) > 0.008856
            fy(i,j) = (L(i,j)+16)/116;
        else
            fy(i,j) = (903.3*y(i,j)+16)/116;
        end
    end
end

for i = 1:height
    for j= 1:width
       fx(i,j) = a(i,j)/500+fy(i,j);
    end
end

for i = 1:height
    for j= 1:width
       fz(i,j) = fy(i,j)-b(i,j)/200;
    end
end

for i = 1:height
    for j= 1:width
        if fx(i,j)^3 > 0.008856
            x(i,j) = fx(i,j)^3;
        else x(i,j) = (116*fx(i,j)-16)/903.3;
        end
    end
end

for i = 1:height
    for j= 1:width
        if fz(i,j)^3 > 0.008856
            z(i,j) = fz(i,j)^3;
        else z(i,j) = (116*fz(i,j)-16)/903.3;
        end
    end
end


x = Xn * x / 100;
y = Yn * y / 100;
z = Zn * z / 100;

%%% xyz->sRGB変換
sR = 3.2406*x-1.5372*y-0.4986*z;
sG = -0.9689*x+1.8758*y+0.0415*z;
sB = 0.0557*x-0.2040*y+1.0570*z;



%%% sRGBの結合
sRGB2 = zeros(height,width,3);

for i = 1:height
    for j = 1:width
        sRGB2(i,j,1) = sR(i,j);
        sRGB2(i,j,2) = sG(i,j);
        sRGB2(i,j,3) = sB(i,j);
    end
end



%%% sRGB -> RGBへの変換（標準規格）
RGB2 = zeros(height,width,3);

for k = 1:3
    for i = 1:height     
        for j= 1:width  
            if sRGB2(i,j,k) <= 0.0031308
                RGB2(i,j,k) = sRGB2(i,j,k)*12.92;
            else
                RGB2(i,j,k) = 1.055*(sRGB2(i,j,k)^(1.0 /2.4))-0.055;
            end
        end
    end
end

RGB2 = round(RGB2 * 255);

for k=1:3
    for i = 1:height
        for j = 1:width
            if RGB2(i,j,k) <= 0
                RGB2(i,j,k) = 0;
            else if RGB2(i,j,k) >= 255
                    RGB2(i,j,k) = 255;
                end
            end
        end
    end
end



%%%　ビット数変換
RGB2 = uint8(RGB2);



%%% 変換画像(RGB)表示
figure;  imagesc(RGB2); axis image;
imwrite(RGB2,'img/flower_org_random.bmp','bmp');