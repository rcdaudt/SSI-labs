close all
clear
clc
%% Read all the images
dir = './P2_seg';
feli_dir = strcat(dir,'/feli.tif'); 
hand_dir = strcat(dir,'/hand2.tif'); 
pingpong_dir = strcat(dir,'/pingpong2.tif'); 
mosaic_dir = strcat(dir,'/mosaic8.tif'); 

feli_im = imread(feli_dir);
hand_im = imread(hand_dir);
mosaic_im = imread(mosaic_dir);
pingpong_im = imread(pingpong_dir);
%% Feli
im_ct = glcm_texture(feli_im);

feli_plot = seg(im_ct(:,:,1:6),[1 1],0.28);
figure;
imshow(feli_plot,[],'InitialMagnification','fit');
colormap jet;

%% Hand
im_ct = glcm_texture(hand_im);

hand_plot = seg(im_ct(:,:,1:6),[1 1],0.3);
figure;
imshow(hand_plot,[],'InitialMagnification','fit');
colormap jet;