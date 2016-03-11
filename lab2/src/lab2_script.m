% SSI Lab 2
% Daudt
% 11/03/16

clear all
close all
clc

%% Load segmentation images

feli = im2double(imread('P2_seg/feli.tif'));
hand = im2double(imread('P2_seg/hand2.tif'));
mosaic = im2double(imread('P2_seg/mosaic8.tif'));
pingpong = im2double(imread('P2_seg/pingpong2.tif'));

%% Compute descriptors

feli_desc = compute_descriptors(feli,7);
display('feli_desc done');
hand_desc = compute_descriptors(hand,7);
display('hand_desc done');
mosaic_desc = compute_descriptors(mosaic,7);
display('mosaic_desc done');
pingpong_desc = compute_descriptors(pingpong,7);
display('pingpong_desc done');

%% Display results

figure;
for i = 1:3
    subplot(3,1,i);
    imshow(feli_desc(:,:,i));
end

figure;
for i = 1:3
    subplot(3,1,i);
    imshow(hand_desc(:,:,i));
end

figure;
for i = 1:3
    subplot(3,1,i);
    imshow(mosaic_desc(:,:,i));
end

figure;
for i = 1:3
    subplot(3,1,i);
    imshow(pingpong_desc(:,:,i));
end

%% Segmentation

feli_prep = feli(:,:,3);
feli_prep(:,:,2:3) = feli_desc(:,:,1:2);
feli_seg = rg(feli_prep,0.25);
figure;
imagesc(feli_seg);

hand_prep = hand(:,:,[1 3]); %%% Smoothing?
hand_prep(:,:,3:4) = hand_desc(:,:,1:2);
hand_seg = rg(hand_prep,0.15);
figure;
imagesc(hand_seg);

mosaic_prep = mosaic;
mosaic_prep(:,:,4:6) = mosaic_desc;
mosaic_seg = rg(mosaic_prep,0.3);
figure;
imagesc(mosaic_seg);
%%
pingpong_prep = pingpong(:,:,1:3);
pingpong_prep(:,:,4:6) = pingpong_desc(:,:,1:3);
pingpong_seg = rg(pingpong_prep,0.1);
figure;
imagesc(pingpong_seg);



































