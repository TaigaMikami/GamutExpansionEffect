clear all; 
close all;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% �I���W�i���摜�쐬�v���O����
%
%�@�I���W�i���w�i�ƃ^�[�Q�b�g�̈�����̂�����
%
%
%                    made by �O����
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%% �摜�̓ǂݍ��� %%%%%%%%%%%
Org=imread('wool-target_ave_controll.bmp');    % ���摜
Mk = imread('sokedImage/match/wool/bulr/wool-target_bulr100.bmp');
Mk_ave = imread('wool-target_ave.bmp');

% ++++++++++++�c���̃T�C�Y+++++++++++
[width,height,val] = size(Org);
Mk_flag = zeros(width,height,val);

% for k=1:1:3
%     for i=1:1:width
%        % disp(i);
%        for j=1:1:height
%           if Mk(i,j,k) == 0
%             Mk_flag(i,j,k) = 1;
%             Mk(i,j,k) = Org(i,j,k);
%           end
%         end
%     end
% end

for k=1:1:3
    for i=1:1:width
       % disp(i);
       for j=1:1:height
          if Mk_ave(i,j,k) == 0
            %Org(i,j,k) = Mk(i,j,k);
            Mk(i,j,k) = Org(i,j,k);
          end
        end
    end
end



%%%�@�r�b�g���ϊ�
Mk = uint8(Mk);



%%% �ϊ��摜(Org)�\��
figure;  imagesc(Mk); axis image;
imwrite(Mk,'wool-target_bulr_controll.bmp','bmp');