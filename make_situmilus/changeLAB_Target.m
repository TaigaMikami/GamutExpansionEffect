clear all; close all;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 彩度変調プログラム
%
% %　ターゲット領域の彩度変調する
%
%
%                    made by 三上大河
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Org = imread('outputTarget/mix_40_all4_8.bmp');    % ミックスターゲット
select_color = 'all4_8';

% org_img = sprintf('outputTarget/target_%s_40.bmp', select_color);
% Org = imread(org_img);    % 背景黒画像
Back = imread('match_haikei.bmp'); %背景平均画像


figure(1),
imshow(Org);

 % ++++++++++++縦横のサイズ+++++++++++
    [width,height,val] = size(Org);
 %% 背景の設定
 
 
picsR = 0;
picsG = 0;
picsB = 0;
picsfR = zeros(280,280);
picsfG = zeros(280,280);
picsfB = zeros(280,280);
sumfR = 0;
sumfG = 0;
sumfB = 0;

%前
%if Org(i,j,1) == 0 <-　1個のみ
for i = 1:height
    for j = 1:width
        if Org(i,j,1) == 0 && Org(i,j,2) == 0 && Org(i,j,3) == 0
           %picsR = picsR + double(Back(i,j,1));
           picsR = double(Back(1,1,1));
           picsfR(i,j) = 1;
           sumfR = sumfR + 1;
        end
    end
end
%picsR = picsR / sumfR;


for i = 1:height
    for j = 1:width
        if Org(i,j,1) == 0 && Org(i,j,2) == 0 && Org(i,j,3) == 0
           %picsG = picsG + double(Back(i,j,2));
           picsG = double(Back(1,1,2));
           picsfG(i,j) = 1;
           sumfG = sumfG + 1;
        end
    end
end
%picsG = picsG / sumfG;


for i = 1:height
    for j = 1:width
        if Org(i,j,1) == 0 && Org(i,j,2) == 0 && Org(i,j,3) == 0
           %picsB = picsB + double(Back(i,j,3));
           picsB = double(Back(1,1,3));
           picsfB(i,j) = 1;
           sumfB = sumfB + 1;
        end
    end
end
%picsB = picsB / sumfB;

     
     
for m = 0:1:30

    % Xred=X(:,:,1); Xgreen=X(:,:,2); Xblue=X(:,:,3);
    RGBdo=double(Org);
    RGB=RGBdo/255;    %原画像 

    %% RGB -> sRGBへの変換（標準規格）
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

    %% sRGB -> XYZ(1931)への変換
    %　原画像
    x = sRGB(:,:,1)*0.4124+sRGB(:,:,2)*0.3576+sRGB(:,:,3)*0.1805;
    y = sRGB(:,:,1)*0.2126+sRGB(:,:,2)*0.7152+sRGB(:,:,3)*0.0722;
    z = sRGB(:,:,1)*0.0193+sRGB(:,:,2)*0.1192+sRGB(:,:,3)*0.9505;

    X = x*100;
    Y = y*100;
    Z = z*100;
    
    %% XYZ(1931) -> Labへの変換
    Xn = 108.7853;
    Yn = 114.64;
    Zn = 127.1557;

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



    %% Labの変調

    L = L * 1.000;
    a = a * m * 0.05;
    b = b * m * 0.05;

    L2 = zeros(i,j);
    a2 = zeros(i,j);
    b2 = zeros(i,j);






    %% Lab->XYZ変換
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


    %% xyz->sRGB変換
    sR = 3.2406*x-1.5372*y-0.4986*z;
    sG = -0.9689*x+1.8758*y+0.0415*z;
    sB = 0.0557*x-0.2040*y+1.0570*z;



    %% sRGBの結合
    sRGB2 = zeros(height,width,3);

    for i = 1:height
        for j = 1:width
            sRGB2(i,j,1) = sR(i,j);
            sRGB2(i,j,2) = sG(i,j);
            sRGB2(i,j,3) = sB(i,j);
        end
    end



    %% sRGB -> RGBへの変換（標準規格）
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
    
    %% 背景の設定
    
    

    %%%　ビット数変換
    RGB2 = uint8(RGB2);

    for i = 1:height
        for j = 1:width
            if picsfR(i,j) == 1
               RGB2(i,j,1) = picsR;%移す
            end
        end
    end
    
    for i = 1:height
        for j = 1:width
            if picsfG(i,j) == 1
               RGB2(i,j,2) = picsG;
            end
        end
    end

     for i = 1:height
        for j = 1:width
            if picsfB(i,j) == 1
                RGB2(i,j,3) = picsB;
            end
        end
     end
    
     for k=1:1:3
        for i=1:1:width
           % disp(i);
           for j=1:1:height
              if (Org(i,j,1) == 0) && (Org(i,j,2) == 0) && (Org(i,j,3) == 0)
                %Org(i,j,k) = Mk(i,j,k);
                RGB2(i,j,k) = Back(i,j,k);
              end
            end
        end
    end

    %% 変換画像(RGB)表示


    str = sprintf('matchSitumilus/%s/%d.bmp' ,select_color, 40*m*0.05);%*0.05

    imwrite(RGB2,str,'bmp');
end
