function [pics_L,pics_a,pics_b] = calcLab(x)
    
    %% 画像のLabを計算してくれる関数(ターゲット領域のみ)
    %戻り値：Labの平均
    
    
    [width,height,val] = size(x);
    RGBdo=double(x);
    RGB=RGBdo/255;    %原画像 

    pics_L = 0;
    pics_a = 0;
    pics_b = 0;
    picsf_L = zeros(280,280);
    picsf_a = zeros(280,280);
    picsf_b = zeros(280,280);
    sumf_L = 0;
    sumf_a = 0;
    sumf_b = 0;

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

%     %% XYZ(1931) -> Labへの変換
%     モニターの白色点
%     Xn = 108.7853;
%     Yn = 114.64;
%     Zn = 127.1557;
%pump
%     Xn = 54.87;
%     Yn = 57.79;
%     Zn = 76.08;
%wool
%     Xn = 41.48;
%     Yn = 39.07;
%     Zn = 47.02;
%flower
    Xn = 58.50;
    Yn = 63.33;
    Zn = 72.07;

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
    
    
    A = reshape(a,[1,78400]);
    B = reshape(b,[1,78400]);
    figure(),
    scatter(A, B, '.');
    

    %% Labの要素の計算
    for i = 1:height
        for j = 1:width
            if L(i,j) ~= 0
               pics_L = pics_L + double(L(i,j,1));
               picsf_L(i,j) = 1; %フラグ用
               sumf_L = sumf_L + 1; %黒以外のピクセル数の総和
            end
        end
    end
    pics_L = pics_L / sumf_L;

    for i = 1:height
        for j = 1:width
            if a(i,j) ~= 0
               pics_a = pics_a + double(a(i,j,1));
               picsf_a(i,j) = 1; %フラグ用
               sumf_a = sumf_a + 1; %黒以外のピクセル数の総和
            end
        end
    end
    pics_a = pics_a / sumf_a;

    for i = 1:height
        for j = 1:width
            if b(i,j) ~= 0
               pics_b = pics_b + double(b(i,j,1));
               picsf_b(i,j) = 1; %フラグ用
               sumf_b = sumf_b + 1; %黒以外のピクセル数の総和
            end
        end
    end
    pics_b = pics_b / sumf_b;

end
