clear all;
close all;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% �摜�g���~���O�p�v���O����
%
%�@�摜�̑傫����280�~280�ɂ��낦��
%
%
%                    made by �O����
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%% �摜�̓ǂݍ��� %%%%%%%%%%%
Org=imread('img/plastic_object.jpg');    % ���摜
%Model=imread('img/flower_org.bmp');    % ���摜

%[width,height,val] = size(Model);

% �摜�̃g���~���O
Org2 = imcrop(Org,[20 0 379 380]);
% �摜�̃��T�C�Y
Org3 = imresize(Org2,[280 280]);


figure(1),
imshow(Org);

% figure(2),
% imshow(Model);

figure(3)
imshow(Org3);
title('Cropped Image');

imwrite(Org3,'img/platic-org.bmp','bmp');