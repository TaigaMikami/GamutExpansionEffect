function [L,a,b] = calcLab_array(x)

%% �摜��Lab���v�Z���Ă����֐�
%�߂�l�F�z��
    [width,height,val] = size(x);
    RGBdo=double(x);
    RGB=RGBdo/255;    %���摜 
    
%% RGB -> sRGB�ւ̕ϊ��i�W���K�i�j
    %���摜
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

    %% sRGB -> XYZ(1931)�ւ̕ϊ�
    %�@���摜
    x = sRGB(:,:,1)*0.4124+sRGB(:,:,2)*0.3576+sRGB(:,:,3)*0.1805;
    y = sRGB(:,:,1)*0.2126+sRGB(:,:,2)*0.7152+sRGB(:,:,3)*0.0722;
    z = sRGB(:,:,1)*0.0193+sRGB(:,:,2)*0.1192+sRGB(:,:,3)*0.9505;

    X = x*100;
    Y = y*100;
    Z = z*100;
    
    %% XYZ(1931) -> Lab�ւ̕ϊ�
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
end