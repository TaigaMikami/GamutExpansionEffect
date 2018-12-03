%% �w�i�̈�i�����j�ƃ^�[�Q�b�g�̈���|�����킹��

close all;
clear all;

% Target =imread('outputTarget/target_b_40.bmp');    % ���摜
select_color = 'y'; %�^�[�Q�b�g�̃J���[�J�e�S���I��

backFolder = ['outputBack' filesep]; % �摜��ۑ����Ă���t�H���_��
backFileList = dir([backFolder '*.bmp']); % �摜�̌`��
backNum = size(backFileList, 1); % �t�H���_���̉摜�̖���

for m = 1:1:backNum
    target_file = sprintf('outputTarget/target_%s_40.bmp', select_color);
    Target =imread(target_file);    % ���摜
    backFileName = char(backFileList(m).name); % �摜�̃t�@�C�����i�t�H���_���Ȃ��j
    backFileName2 = [backFolder backFileName]; % �摜�̃t�@�C�����i�t�H���_��񂠂�j
    back_read = imread(backFileName2, 'bmp'); % �����_���Ɍ��肳�ꂽ�ꖇ�̉摜 
    disp(backFileName2)
    [width,height,val] = size(Target);
    
    imshow(back_read);
    
    for i=1:1:width
       % disp(i);
       for j=1:1:height
           for k=1:1:3
              if (Target(i,j,1) == 0) && (Target(i,j,2) == 0) && (Target(i,j,3) == 0)
                    Target(i,j,1) = back_read(i,j,1);
                    Target(i,j,2) = back_read(i,j,2);
                    Target(i,j,3) = back_read(i,j,3);
              else
%                   disp(Target(i,j,k))
              end
           end
        end
    end
    back_name = strrep(backFileName, '.bmp', '');
    filename = sprintf('testSitumilus/%s/test_%s_%s.bmp',select_color, select_color, back_name);
    imwrite(Target,filename,'bmp');
end
