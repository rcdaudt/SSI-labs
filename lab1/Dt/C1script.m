% SSI - Coursework 1

clear all
close all
clc

%% Load Images

coins = imread('coins.png');
color = imread('color.tif');
gc = imread('gantrycrane.png');
woman = imread('woman.tif');

% figure;
% imshow(coins);
% figure;
% imshow(color);
% figure;
% imshow(gc);
% figure;
% imshow(woman);

%% Apply Region Growing

display('Segmenting coins.png...');
tic
coins_rg = rg(coins,65);
toc
coins_rg_plot = coins_rg/max(max(coins_rg));
figure;
imshow(coins_rg_plot);
title('coins.png');
colormap 'colorcube';
pause(0.2)
display('Done!');


display('Segmenting colors.tif...');
tic
color_rg = rg(color,10);
toc
color_rg_plot = color_rg/max(max(color_rg));
figure;
imshow(color_rg_plot);
title('color.tif');
colormap 'colorcube';
pause(0.2)
display('Done!');


display('Segmenting gantrycrane.png...');
tic
gc_rg = rg(gc,50);
toc
gc_rg_plot = gc_rg/max(max(gc_rg));
figure;
imshow(gc_rg_plot);
title('gantrycrane.png');
colormap 'colorcube';
pause(0.2)
display('Done!');


display('Segmenting gantrycrane.png...');
% Apply gaussian blur before segmentation to avoid problems with textures
k = fspecial('gaussian',[5 5],1);
for i = 1:3
    gc2(:,:,i) = conv2(double(gc(:,:,i)),k,'valid');
end
tic
gc_rg = rg(gc2,50);
toc
gc_rg_plot = gc_rg/max(max(gc_rg));
figure;
imshow(gc_rg_plot);
title('gantrycrane.png');
colormap 'colorcube';
pause(0.2)
display('Done!');


display('Segmenting woman.tif...');
tic
woman_rg = rg(woman,50);
toc
woman_rg_plot = woman_rg/max(max(woman_rg));
figure;
imshow(woman_rg_plot);
title('woman.tif');
colormap 'colorcube';
pause(0.2)
display('Done!');


display('Segmenting woman.tif...');
% Apply gaussian blur before segmentation to avoid problems with textures
k = fspecial('gaussian',[5 5],1);
for i = 1:3
    woman2(:,:,i) = conv2(double(woman(:,:,i)),k,'valid');
end
tic
woman_rg = rg(woman2,50);
toc
woman_rg_plot = woman_rg/max(max(woman_rg));
figure;
imshow(woman_rg_plot);
title('woman.tif');
colormap 'colorcube';
pause(0.2)
display('Done!');

%% FCM

s = size(coins);
N = 2;
coins_v = reshape(coins,[s(1)*s(2) 1]);
[centers,U] = fcm(double(coins_v),N);
maxU = max(U);
for i = 1:N
    U(i,:) = U(i,:) == maxU;
end
regions = (1:N)*U;
figure;
I = reshape(regions,[s(1) s(2)]);
I = 255*(I - min(min(I)))/(max(max(I))-min(min(I)));
imagesc(I);
imwrite(I,parula(256),'coins_fcm.png');
% axis('equal');
title('FCM - coins');
pause(0.2)



s = size(color);
N = 4;
color_v = reshape(color,[s(1)*s(2) 3]);
[centers,U] = fcm(double(color_v),N);
maxU = max(U);
for i = 1:N
    U(i,:) = U(i,:) == maxU;
end
regions = (1:N)*U;
figure;
I = reshape(regions,[s(1) s(2)]);
I = 255*(I - min(min(I)))/(max(max(I))-min(min(I)));
imagesc(I);
imwrite(I,parula(256),'colors_fcm.png');
% axis('equal');
title('FCM - color');
pause(0.2)



s = size(gc);
N = 3;
gc_v = reshape(gc,[s(1)*s(2) 3]);
[centers,U] = fcm(double(gc_v),N);
maxU = max(U);
for i = 1:N
    U(i,:) = U(i,:) == maxU;
end
regions = (1:N)*U;
figure;
I = reshape(regions,[s(1) s(2)]);
I = 255*(I - min(min(I)))/(max(max(I))-min(min(I)));
imagesc(I);
imwrite(I,parula(256),'gc_fcm.png');
% axis('equal');
title('FCM - gantrycrane');
pause(0.2)




s = size(woman);
N = 3;
woman_v = reshape(woman,[s(1)*s(2) 3]);
[centers,U] = fcm(double(woman_v),N);
maxU = max(U);
for i = 1:N
    U(i,:) = U(i,:) == maxU;
end
regions = (1:N)*U;
figure;
I = reshape(regions,[s(1) s(2)]);
I = 255*(I - min(min(I)))/(max(max(I))-min(min(I)));
imagesc(I);
imwrite(I,parula(256),'woman_fcm.png');
% axis('equal');
title('FCM - woman');
pause(0.2)