clear all; close all;

%%%%%%%%%%% �摜�̓ǂݍ��� %%%%%%%%%%%
Org=imread('img/P3RGB_conversion.bmp');    % ���摜
Mk = imread('img/P3RGB_conversion-target.bmp');

%%%%�O����org

% ++++++++++++�c���̃T�C�Y+++++++++++
%width = 280; height = 280;

[width,height] = size(Org);
% Xred=X(:,:,1); Xgreen=X(:,:,2); Xblue=X(:,:,3);
% Org=double(Org);
% %Org=Orgdo/255;    %���摜     
% 
% Orgm=double(Mk);
% Orgm=Orgm/255;

m = 10;

%���U�C�N����
for i=1:m:width
   % disp(i);
   for j=1:m:height
      Org(i:i+m-1,j:j+m-1,1) = mean2(Org(i:i+m-1,j:j+m-1,1));
      Org(i:i+m-1,j:j+m-1,2) = mean2(Org(i:i+m-1,j:j+m-1,2));
      Org(i:i+m-1,j:j+m-1,3) = mean2(Org(i:i+m-1,j:j+m-1,3));
      imshow(Org);
    end
end


for k=1:1:3
    for i=1:1:width
       % disp(i);
       for j=1:1:height
          if Mk(i,j,k) >  0
            Org(i,j,k) = Mk(i,j,k);
          end
        end
    end
end



%%%�@�r�b�g���ϊ�
Org = uint8(Org);



%%% �ϊ��摜(Org)�\��
figure;  imagesc(Org); axis image;
imwrite(Org,'img/flower_org_moz.bmp','bmp');