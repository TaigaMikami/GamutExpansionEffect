close all;
clear all;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%���j�^�[�̃K���}�␮%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%% �摜�̓ǂݍ��� %%%%%%%%%%%
% ImageName = 'bride';%N3_conversion 
% Imdata = imread(strcat(ImageName,'.bmp'));
filename = 'pump_t-rand5_b-face.bmp';
Org = imread(strcat('newExpImage/test/pump/',filename));
Output = strcat('sokedImage/test/pump/',filename);
% Org = imread(strcat('soku_test/',filename));
% Output = strcat('sokued_test/',filename);
%%--------�ǂݍ��ތ��摜�̑傫��--------%%
[width,height,val] = size(Org);

RGBdo = double(Org);
%%---�m�F�p---%%
Rtest = RGBdo(:,:,1);
Gtest = RGBdo(:,:,2);
Btest = RGBdo(:,:,3);
%%---�ǂݍ��񂾉摜�𐳋K��---%% 
RGB = RGBdo./255;

% syms t;

%% �@RGB(����`)����sRGB�ւ̕ϊ�

%%---RGB����sRGB�ւ̕ϊ�(�W���K�i)---%%
sRGB = zeros(height,width,3);
for k = 1:3                                            
    for i = 1:height                                    
        for j= 1:width                                      
            if RGB(i,j,k) <= 0.04045
                sRGB(i,j,k) = RGB(i,j,k)./12.92;
            else
                sRGB(i,j,k) = ((RGB(i,j,k)+0.055)./1.055).^2.4;
            end
        end
    end
end

%% �ARGB��XYZ�ւ̕ϊ�

%%---sRGB��XYZ(CIE1931)�\�F�n�ɕϊ�%%

imageXYZ = zeros(height,width,3);

imageXYZ(:,:,1) = sRGB(:,:,1).*0.4124+sRGB(:,:,2).*0.3576+sRGB(:,:,3).*0.1805;
imageXYZ(:,:,2) = sRGB(:,:,1).*0.2126+sRGB(:,:,2).*0.7152+sRGB(:,:,3).*0.0722;
imageXYZ(:,:,3) = sRGB(:,:,1).*0.0193+sRGB(:,:,2).*0.1192+sRGB(:,:,3).*0.9505;

%% �BXYZ����Lab�ւ̕ϊ�

%%---�W����D65---%%
Xn = 0.9504;
Yn = 1;
Zn = 1.0883;

%%---XYZ����Lab�ɕϊ�---%%

Lab = zeros(height,width,3);

for i = 1:height             
   for j= 1:width
       % L�����߂�
           Lab(i,j,1) = 116 .* functionLAB(imageXYZ(i,j,2)./Yn) - 16;
       % a�����߂�
           Lab(i,j,2) = 500 .* (functionLAB(imageXYZ(i,j,1)./Xn) - functionLAB(imageXYZ(i,j,2)./Yn));
       % b�����߂�
           Lab(i,j,3) = 200 .* (functionLAB(imageXYZ(i,j,2)./Yn) - functionLAB(imageXYZ(i,j,3)./Zn));
   end
end

%% �DLab����XYZ

%%---�t�ϊ�---%%
%%---Lab��XYZ�ɕϊ�---%%
fxyz = zeros(height,width,3);
reimageXYZ = zeros(height,width,3);
fxyz(:,:,2) = (Lab(:,:,1)+16)/116;
fxyz(:,:,1) = (Lab(:,:,1)+16)/116+Lab(:,:,2)./500;
fxyz(:,:,3) = (Lab(:,:,1)+16)/116-Lab(:,:,3)./200;

 for i = 1:height
    for j= 1:width

 % Y���t�ϊ��Ōv�Z
        if  fxyz(i,j,2) > 6/29
            reimageXYZ(i,j,2) = ((fxyz(i,j,2)).^3).*Yn;
        else
            reimageXYZ(i,j,2) = (((3/29)^3).*(116.*fxyz(i,j,2) - 16)).*Yn;
        end

        % X���t�ϊ��Ōv�Z
        if  fxyz(i,j,1) > 6/29
            reimageXYZ(i,j,1) = ((fxyz(i,j,1)).^3).*Xn;
        else
            reimageXYZ(i,j,1) = (((3/29)^3).*(116.*fxyz(i,j,1) - 16)).*Xn;
        end

        % Z���t�ϊ��Ōv�Z
        if  fxyz(i,j,3) > 6/29
            reimageXYZ(i,j,3) = ((fxyz(i,j,3)).^3).*Zn;
        else
            reimageXYZ(i,j,3) = (((3/29)^3).*(116.*fxyz(i,j,3) - 16)).*Zn;
        end

    end
 end

%%---��񂾒l�̕␳---%%
for i = 1:height
    for j= 1:width
       if reimageXYZ(i,j,1) < 0
            reimageXYZ(i,j,1) = 0;
       end

       if reimageXYZ(i,j,3) < 0
            reimageXYZ(i,j,3) = 0;
       end

       if reimageXYZ(i,j,2) < 0
            reimageXYZ(i,j,2) = 0;
       end       
    end
end

%% �EXYZ����RGB�ϊ�  

%%---XYZ�����j�^�����ɍ��킹��RGB�l�ɕϊ�����---%%
%%%%%%%%%% ���j�^�̓��� %%%%%%%%%%
% LCD(CG-247)���j�^

%%---�F�x---%%
xred = 0.6374;
yred = 0.3304;
xgreen = 0.2674;
ygreen = 0.5985;
xblue = 0.1529;
yblue = 0.0576;

%     %%---�P�x---%%
%     Yred = 18.1;
%     Ygreen = 58.4;
%     Yblue = 5.25;

%%---���j�^�̍ő唒�F�ɂ�����XYZ�O�h���l()---%%
Xwhite = 108.7853;
Ywhite = 114.64;
Zwhite = 127.1557;

%%---���j�^�̍ő唒�F�ɂ�����XYZ�O�h���l��Y=1�Ő��K��---%%
reXwhite = Xwhite/Ywhite;
reYwhite = Ywhite/Ywhite;
reZwhite = Zwhite/Ywhite;

% vect�͒萔(�g�p���郂�j�^�̕ϊ��s������߂�)
vect = [xred xgreen xblue;
        yred ygreen yblue;
        1-xred-yred 1-xgreen-ygreen 1-xblue-yblue];

% vect�̋t�s��
inv_vect = inv(vect);

Tr = inv_vect(1,1).*reXwhite+inv_vect(1,2).*reYwhite+inv_vect(1,3).*reZwhite;
Tg = inv_vect(2,1).*reXwhite+inv_vect(2,2).*reYwhite+inv_vect(2,3).*reZwhite;
Tb = inv_vect(3,1).*reXwhite+inv_vect(3,2).*reYwhite+inv_vect(3,3).*reZwhite;

reM = [(Tr*xred) (Tg*xgreen) (Tb*xblue);
        (Tr*yred) (Tg*ygreen) (Tb*yblue);
        (Tr*(1-xred-yred)) (Tg*(1-xgreen-ygreen)) (Tb*(1-xblue-yblue))];

inv_reM = inv(reM);

reimageSRGB = zeros(height,width,3);%sRGB�̒l(���`)

 %----�g�p���郂�j�^�̕ϊ��s���p����sRGB�ɒ���----%
reimageSRGB(:,:,1) = reimageXYZ(:,:,1).*inv_reM(1,1)+reimageXYZ(:,:,2).*inv_reM(1,2)+reimageXYZ(:,:,3).*inv_reM(1,3);
reimageSRGB(:,:,2) = reimageXYZ(:,:,1).*inv_reM(2,1)+reimageXYZ(:,:,2).*inv_reM(2,2)+reimageXYZ(:,:,3).*inv_reM(2,3);
reimageSRGB(:,:,3) = reimageXYZ(:,:,1).*inv_reM(3,1)+reimageXYZ(:,:,2).*inv_reM(3,2)+reimageXYZ(:,:,3).*inv_reM(3,3);

  %------------(RGB(����`)�֒���)-------------%
%      reimageRGB = uint8(round(abs((reimageSRGB.^(1/2.2)).*255)));

%      reimageRGB(:,:,1) = uint8(round(abs((reimageSRGB(:,:,1).^(1/2.2)).*255)));
%      reimageRGB(:,:,2) = uint8(round(abs((reimageSRGB(:,:,2).^(1/2.2)).*255)));
%      reimageRGB(:,:,3) = uint8(round(abs((reimageSRGB(:,:,3).^(1/2.2)).*255)));
%     
%      reimageRGB = zeros(height,width,3);%sRGB�̒l(���`)
% 
%reimageRGB(:,:,1) = uint8(round(abs((1.9815152995383.*(10.^(-19)).*(2.0375742566707.*(10^20).*sqrt(1.00626742503621.*(10.^71).*reimageSRGB(:,:,1).^2-1.4184834436165.*(10.^69).*reimageSRGB(:,:,1)+2.2447160845016.*(10.^68))+6.4635357007182.*(10.^55).*reimageSRGB(:,:,1)-4.5556569509160.*(10.^53)).^(1/3)-(4.138724923867.*(10.^17))./(2.0375742566707.*(10.^20).*sqrt(1.00626742503621.*(10.^71).*reimageSRGB(:,:,1).^2-1.4184834436165.*(10.^69).*reimageSRGB(:,:,1)+2.2447160845016.*(10.^68))+6.4635357007182.*(10.^55).*reimageSRGB(:,:,1)-4.5556569509160.*(10.^53)).^(1/3)+0.091895918262562).*255)));
%reimageRGB(:,:,2) = uint8(round(abs((3.813198629995*(10^(-26))*(2.5676048344383*(10^36)*sqrt(1.3902274532196*(10^79).*reimageSRGB(:,:,2).^2+1.6201916996281*(10^76).*reimageSRGB(:,:,2)+2.8373995482924*(10^76))+9.5735082290501*(10^75).*reimageSRGB(:,:,2)+5.5785542621487*(10^72)).^(1/3)-(2.1806750960569*(10^24))./(2.5676048344383*(10^36)*sqrt(1.3902274532196*(10^79).*reimageSRGB(:,:,2).^2+1.6201916996281*(10^76).*reimageSRGB(:,:,2)+2.8373995482924*(10^76))+9.5735082290501*(10^75).*reimageSRGB(:,:,2)+5.5785542621487*(10^72)).^(1/3)+0.068907077580750).*255)));
%reimageRGB(:,:,3) = uint8(round(abs((2.615530492303*(10^(-30))*(1.529288356328*(10^48)*sqrt(7.476296619234*(10^80).*reimageSRGB(:,:,3).^2+2.044128913387*(10^79).*reimageSRGB(:,:,3)+4.178652922057*(10^77))+4.181505223859*(10^88).*reimageSRGB(:,:,3)+5.716423628497*(10^86)).^(1/3)-(2.266251089668*(10^28))./(1.529288356328*(10^48)*sqrt(7.476296619234*(10^80).*reimageSRGB(:,:,3).^2+2.044128913387*(10^79).*reimageSRGB(:,:,3)+4.178652922057*(10^77))+4.181505223859*(10^88).*reimageSRGB(:,:,3)+5.716423628497*(10^86)).^(1/3)-0.09585269255912).*255)));

% f1(t) = 2*(10^(-8))*t^3 + 1*(10^(-5))*t^2 + 5*(10^(-5))*t + 0.0067;
% f2(t) = 2*(10^(-8))*t^3 + 1*(10^(-5))*t^2 + 5*(10^(-5))*t + 0.0026;
% f3(t) = 2*(10^(-8))*t^3 + 1*(10^(-5))*t^2 + 4*(10^(-5))*t + 0.0186;
% g1(t) = finverse(f1);
% g2(t) = finverse(f2);
% g3(t) = finverse(f3);
% reimageRGB(:,:,1) = uint8(round(g1(reimageSRGB(:,:,1))));
% reimageRGB(:,:,2) = uint8(round(g2(reimageSRGB(:,:,2))));
% reimageRGB(:,:,3) = uint8(round(g3(reimageSRGB(:,:,3))));
reimageRGB(:,:,1) = uint8(round(abs(-0.662109+0.000241173*(1097*sqrt(9.74761*(10^15).*reimageSRGB(:,:,1).^2-3.70286*(10^15).*reimageSRGB(:,:,1)+2.41804*(10^13))+1.08307*(10^11).*reimageSRGB(:,:,1)-2.05714*(10^10)).^(1/3)+1768.18./((1097*sqrt(9.74761*(10^15).*reimageSRGB(:,:,1).^2-3.70286*(10^15).*reimageSRGB(:,:,1)+2.41804*(10^13))+1.08307*(10^11).*reimageSRGB(:,:,1)-2.05714*(10^10)).^(1/3))).*255));
reimageRGB(:,:,2) = uint8(round(abs(-0.625109+0.000140365*(5932.27*sqrt(7.91817*(10^15).*reimageSRGB(:,:,2).^2-2.55635*(10^15).*reimageSRGB(:,:,2)+6.41083*(10^12))+5.27878*(10^11).*reimageSRGB(:,:,2)-8.52115*(10^10)).^(1/3)+2689.6./((5932.27*sqrt(7.91817*(10^15).*reimageSRGB(:,:,2).^2-2.55635*(10^15).*reimageSRGB(:,:,2)+6.41083*(10^12))+5.27878*(10^11).*reimageSRGB(:,:,2)-8.52115*(10^10)).^(1/3))).*255));
reimageRGB(:,:,3) = uint8(round(abs(-0.87766+0.00012161*(20142.2*sqrt(2.53566*(10^15).*reimageSRGB(:,:,3).^2-2.02456*(10^15).*reimageSRGB(:,:,3)+3.66929*(10^13))+1.01427*(10^12).*reimageSRGB(:,:,3)-4.04911*(10^11)).^(1/3)+6448.07./((20142.2*sqrt(2.53566*(10^15).*reimageSRGB(:,:,3).^2-2.02456*(10^15).*reimageSRGB(:,:,3)+3.66929*(10^13))+1.01427*(10^12).*reimageSRGB(:,:,3)-4.04911*(10^11)).^(1/3))).*255));

%     
%%---��񂾒l��␳---%%
for k=1:3
    for i = 1:height
        for j = 1:width            
            if reimageRGB(i,j,k) == 0;
            elseif reimageRGB(i,j,k) > 255
                reimageRGB(i,j,k) = 255;
            end
        end
    end
end

%% �摜�o��
    
imwrite(reimageRGB,Output,'bmp');

