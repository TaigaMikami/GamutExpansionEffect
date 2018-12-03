clear all; close all;

%%%%%%%%%%% �摜�̓ǂݍ��� %%%%%%%%%%%
Org = imread('img/flower_org.bmp');    % ���摜
Org = rgb2gray(Org)

%% �זE�̌��o
[~, threshold] = edge(Org, 'sobel');
fudgeFactor = .5;
BWs = edge(Org,'sobel', threshold * fudgeFactor);
figure, imshow(BWs), title('binary gradient mask');

%% �C���[�W�̊g��
se90 = strel('line', 3, 90);
se0 = strel('line', 3, 0);

BWsdil = imdilate(BWs, [se90 se0]);
figure, imshow(BWsdil), title('dilated gradient mask');

%%�@�����̃M���b�v��h��Ԃ�
BWdfill = imfill(BWsdil, 'holes');
figure, imshow(BWdfill);
title('binary image with filled holes');

%% ���E�ɐڐG����I�u�W�F�N�g�̍폜
BWnobord = imclearborder(BWdfill, 4);
figure, imshow(BWnobord), title('cleared border image');

BWnobord = imclearborder(BWdfill, 8);
figure, imshow(BWnobord), title('cleared border image');