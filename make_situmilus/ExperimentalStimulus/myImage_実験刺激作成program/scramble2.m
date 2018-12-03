clear all; close all;

%%%%%%%%%%% �摜�̓ǂݍ��� %%%%%%%%%%%
Org=imread('img/P3RGB_conversion.bmp');    % ���摜
Mk = imread('img/P3RGB_conversion-target.bmp');


% ++++++++++++�c���̃T�C�Y+++++++++++
%width = 280; height = 280;
[width,height] = size(Org);

R = Org(:,:,1);
G = Org(:,:,2);
B = Org(:,:,3);

RGBm=double(Mk);
RGBm=RGBm/255;

%%%%%mask�̏���
mask = zeros(width+1,height+1);

%%%mask(i,j)�ɂ�i,j�̃}�X�N�̖��邳�������Ă���D�����O�C�����P
    for i = 1:width     
        for j= 1:height  
            mask(i,j) = (RGBm(i,j,1)+RGBm(i,j,2)+RGBm(i,j,3))/3;
        end
    end

%%%%%�����_������%%%%%%%%%%
sep = 20;  %�����_���p�b�`�̕�����  ��f��������؂�鐔�ɂ��Ȃ��ƃG���[��f��
% str = 250;  %a* b* �̒��S����̋����@�O�`�Q�T�T

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


%%mask�����łȂ��ꍇ�͓���ւ����s��Ȃ�

for i1 = 0:sep-1
    for j1 = 0:sep-1
         %%%%box2�ɓ���ւ��N�_�̏���ۑ�����
         %%%%box2��mask�����łȂ��ꍇ�I�����Ď��̔���
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
            %�@�������[�v
            %�@�摜�����ߍ���ł���΍Ē��I
             while roop == 1
                 i2 = rand() * sep;
                 i2 = fix(i2);
                 j2 = rand() * sep;
                 j2 = fix(j2);          
                 %%%%box1�ɓ���ւ���̏���ۑ�����
                 %%%%box1��mask�����łȂ��ꍇ����ւ����j2i2���Ē��I
       
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
                 if mask_fe == 0 %�摜�����܂��Ă��邩�𔻒f
                     roop = 0;
                 end
             end

             %box�ɓ��ꂽ���𗠕Ԃ�
             r = rand() * 2; 
             r = fix(r); %�O���P�̃����_��
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

%%% sRGB�̌���
RGB = zeros(height,width,3);

for i = 1:height
    for j = 1:width
        RGB(i,j,1) = R(i,j);
        RGB(i,j,2) = G(i,j);
        RGB(i,j,3) = B(i,j);
    end
end

%%%�@�r�b�g���ϊ�
RGB = uint8(RGB);



%%% �ϊ��摜(RGB)�\��
figure;  imagesc(RGB); axis image;
imwrite(RGB,'img/flower_org_random.bmp','bmp');
