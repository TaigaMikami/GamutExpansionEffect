function [RGB2] = calcLabToRGB(setL,seta,setb)

    %% Labの設定
    L = setL;
    a = seta;
    b = setb;

    %% モニター白色点
    Xn = 108.7853;
    Yn = 114.64;
    Zn = 127.1557;


    %% Lab → XYZ 変換

    if L > 903.3*0.008856
        y = ((L+16)/116)^3;
    else
        y = L/903.3;
    end

    if y > 0.008856
        fy = (L+16)/116;
    else
        fy = (903.3*y+16)/116;
    end

    fx = a/500+fy;

    fz = fy-b/200;

    if fx^3 > 0.008856
        x = fx^3;
    else x = (116*fx-16)/903.3;
    end

    if fz^3 > 0.008856
        z = fz^3;
    else z = (116*fz-16)/903.3;
    end

    x = Xn * x / 100;
    y = Yn * y / 100;
    z = Zn * z / 100;

    %% xyz->sRGB変換
    sR = 3.2406*x-1.5372*y-0.4986*z;
    sG = -0.9689*x+1.8758*y+0.0415*z;
    sB = 0.0557*x-0.2040*y+1.0570*z;

    %% sRGBの結合
    sRGB2 = zeros(1,3);

    sRGB2(1) = sR;
    sRGB2(2) = sG;
    sRGB2(3) = sB;



    %% sRGB -> RGBへの変換（標準規格）
    RGB2 = zeros(1,3);

    for k = 1:3
        if sRGB2(k) <= 0.0031308
            RGB2(k) = sRGB2(k)*12.92;
        else
            RGB2(k) = 1.055*(sRGB2(k)^(1.0 /2.4))-0.055;
        end
    end

    RGB2 = round(RGB2 * 255);

    for k=1:3
        if RGB2(k) <= 0
            RGB2(k) = 0;
        else if RGB2(k) >= 255
                RGB2(k) = 255;
            end
        end
    end

    %%%　ビット数変換
    RGB2 = uint8(RGB2);

end