clear all;                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            clear all; 
close all;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%RGBを指定することによりモニタの信頼性を確かめるプログラム%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% 出力したい色のRGB値を求める

%RGBの値を入力
% rx = input('Rの値(0~255) ')/255;
% gx = input('Gの値(0~255) ')/255;
% bx = input('Bの値(0~255) ')/255;
rx = 12/255;
gx = 53/255;
bx = 243/255;


%RGBに変換行列を掛けてXYZに変換
X = rx*0.4124+gx*0.3576+bx*0.1805;
Y = rx*0.2126+gx*0.7152+bx*0.0722;
Z = rx*0.0193+gx*0.1192+bx*0.9505;

%XYZに測定したRGB色度座標の逆行列を掛けて輝度に変換

%モニタのRGB最大出力のときの色度座標
    xred = 0.6374;
    yred = 0.3304;
    xgreen = 0.2674;
    ygreen = 0.5985;
    xblue = 0.1529;
    yblue = 0.0576;
    
     %%---モニタの最大白色におけるXYZ三刺激値---%%
    Xwhite = 108.7853;
    Ywhite = 114.64;
    Zwhite = 127.1557;

    %%---標準光D65---%%
    Xn = 0.9504;
    Yn = 1;
    Zn = 1.0883;
    
    %%---XsYsZsを正規化---%%
   % Xs = (Xwhite/Xn)*Xs;
   % Ys = (Ywhite/Yn)*Ys;
   % Zs = (Zwhite/Zn)*Zs;

% vectは定数
    vect = [xred/yred xgreen/ygreen xblue/yblue;
            1 1 1;
            (1-xred-yred)/yred (1-xgreen-ygreen)/ygreen (1-xblue-yblue)/yblue];
        
% vectの逆行列をとる
    inv_vect = inv(vect);
        
% 輝度を求める    
Yr = inv_vect(1,1)*X + inv_vect(1,2)*Y + inv_vect(1,3)*Z;
Yg = inv_vect(2,1)*X + inv_vect(2,2)*Y + inv_vect(2,3)*Z;
Yb = inv_vect(3,1)*X + inv_vect(3,2)*Y + inv_vect(3,3)*Z;

% R = 
% G 
% B

YYYr = Yr * (1/((rx / 255)^(2.2)));
YYYg = Yg * (1/((gx / 255)^(2.2)));
YYYb = Yb * (1/((bx / 255)^(2.2)));

yr = 25.12;
yg = 0.35;
yb = 0.35;

XXX = vect(1,1)*yr + vect(1,2)*yg + vect(1,3)*yb;
YYY = vect(1,1)*yr + vect(1,2)*yg + vect(1,3)*yb;
ZZZ = vect(1,1)*yr + vect(1,2)*yg + vect(1,3)*yb;

%RGB
RR = 3.240970*XXX + (-1.537383)*YYY + (-0.498611)*ZZZ;
GG =(-0.969244)*XXX + 1.875968*YYY + 0.041555*ZZZ;
BB = 0.055630*XXX + (-0.203977)*YYY + 1.056972*ZZZ;

%輝度の出力

outputYr = sprintf('Rの輝度値: %f',Yr);
disp(outputYr);
disp(abs(YYYr);
disp(RR);
outputYg= sprintf('Gの輝度値: %f',Yg);
disp(outputYg);
disp(YYYg);
disp(GG);
outputYb = sprintf('Bの輝度値: %f',Yb);
disp(outputYb);
disp(YYYb);
disp(BB);
