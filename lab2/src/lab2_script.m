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

%% Feli

% Compute descriptors
feli_desc = compute_descriptors(feli,7,[5 0]);
display('feli_desc done');

% Display descriptors
figure;
for i = 1:3
    subplot(3,1,i);
    imshow(feli_desc(:,:,i));
end

% Segment image
feli_seg = rg(min(feli_desc,1),0.3);
figure;
imagesc(feli_seg);
colormap(colorcube);
display('feli_seg done');


%% Hand

% Compute descriptors
hand_desc = compute_descriptors(hand,7,[1 0]);
display('hand_desc done');

% Display descriptors
figure;
for i = 1:3
    subplot(3,1,i);
    imshow(hand_desc(:,:,i));
end
%%
% Segment image
hand_prep = cat(3,hand,min(1.5*hand_desc,1));
for i = 1:size(hand_prep,3)
    hand_prep(:,:,i) = medfilt2(hand_prep(:,:,i),[3 3]);
end
hand_seg = rg(hand_prep,0.08);
figure;
imagesc(hand_seg);
colormap(colorcube);
display('hand_seg done');


%% Mosaic

% Compute descriptors
mosaic_desc_h = compute_descriptors(mosaic,15,[1 0]);
mosaic_desc_d = compute_descriptors(mosaic,15,[1 -1]);
display('mosaic_desc done');

% Display descriptors
figure;
for i = 1:3
    subplot(3,1,i);
    imshow(mosaic_desc_h(:,:,i),[]);
end

figure;
for i = 1:3
    subplot(3,1,i);
    imshow(mosaic_desc_d(:,:,i),[]);
end

% Segment image
mosaic_prep = min(cat(3,imgaussfilt(mosaic,10),mosaic_desc_h(:,:,[1 3]),mosaic_desc_d(:,:,1)),6);
for i = 1:size(mosaic_prep,3)
    ma = max(max(mosaic_prep(:,:,i)));
    mi = min(min(mosaic_prep(:,:,i)));
    mosaic_prep(:,:,i) = (mosaic_prep(:,:,i)-mi)/(ma-mi);
    mosaic_prep(:,:,i) = histeq(mosaic_prep(:,:,i));
    mosaic_prep(:,:,i) = medfilt2(mosaic_prep(:,:,i),[10 10]);
end
mosaic_seg = rg(mosaic_prep,0.1);
figure;
imagesc(mosaic_seg);
colormap(colorcube);
display('mosaic_seg done');


%% Pingpong

% Compute descriptors
pingpong_desc = compute_descriptors(pingpong,7,[1 0]);
display('pingpong_desc done');

% Display descriptors
figure;
for i = 1:3
    subplot(3,1,i);
    imshow(pingpong_desc(:,:,i),[]);
end

% Segment image
pingpong_prep = min(cat(3,imgaussfilt(pingpong,1),pingpong_desc(:,:,1:3)),2);
for i = 1:size(pingpong_prep,3)
    ma = max(max(pingpong_prep(:,:,i)));
    mi = min(min(pingpong_prep(:,:,i)));
    pingpong_prep(:,:,i) = (pingpong_prep(:,:,i)-mi)/(ma-mi);
    pingpong_prep(:,:,i) = histeq(pingpong_prep(:,:,i));
    pingpong_prep(:,:,i) = medfilt2(pingpong_prep(:,:,i),[7 7]);
end
pingpong_seg = rg(pingpong_prep,0.18);
figure;
imagesc(pingpong_seg);
colormap(colorcube);
display('pingpong_seg done');





































