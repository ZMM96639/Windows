clear all;clc;
img = imread('1 (1).BMP');
figure;
imshow(img);  
h=imrect;
pos = getPosition(h); %������������������ͻ᷵�������λ�úʹ�С
col=round(pos(1)) : round(pos(1)+pos(3));  %����pos�������±�
row=round(pos(2)) : round(pos(2) + pos(4));   %����pos�������±�
img(row,col,:) = 255;
imshow(img); 