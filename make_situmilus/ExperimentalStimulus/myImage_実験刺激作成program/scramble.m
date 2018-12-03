clear all; close all;

%%%%%%%%%%% ‰æ‘œ‚Ì“Ç‚İ‚İ %%%%%%%%%%%
Org = imread('img/flower_org.bmp');    % Œ´‰æ‘œ

[width,height,variety] = size(Org);
m = 14;
flag = 1;
number = 1;
x = 1;
y = 1;

pix_R = zeros(14,14,400);
pix_G = zeros(14,14,400);
pix_B = zeros(14,14,400);

for i=1:m:width
   for j=1:m:height
        pix_R(x,y,number) = Org(i,j,1);
        pix_G(x,y,number) = Org(i,j,2); 
        pix_B(x,y,number) = Org(i,j,3); 


        if flag == 13
            number = number + 1;
            flag = 0;
            x = 1;
            y = 1;
        end
        
        x = x+1;
        y = y+1;
        flag = flag + 1;

   end
end

imshow(Org);
