%% �w�i�ƃ^�[�Q�b�g�����킹�� ���ǑO��

clear all; close all;

%%%%%%%%%%% �摜�̓ǂݍ��� %%%%%%%%%%%
Target =imread('outputTarget/target_r_40.bmp');    % ���摜
Back = imread('img/back.bmp');

%%%%�O����org

% ++++++++++++�c���̃T�C�Y+++++++++++

[width,height,val] = size(Target);


for k=1:1:3
    for i=1:1:width
       % disp(i);
       for j=1:1:height
          if Target(i,j,k) >  0
            Target(i,j,k) = Back(i,j,k);
          end
        end
    end
end



%%%�@�r�b�g���ϊ�
OutputImage = uint8(Target);



%%% �ϊ��摜(Org)�\��
figure;  imagesc(OutputImage); axis image;
imwrite(OutputImage,'testSitumilus/test_r.bmp','bmp');
