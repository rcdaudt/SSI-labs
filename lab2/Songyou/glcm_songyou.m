close all
clear
clc
%% Texture features extraction by GLCM
dir = './P2_seg';
feli_dir = strcat(dir,'/feli.tif'); 
hand_dir = strcat(dir,'/hand2.tif'); 
pingpong_dir = strcat(dir,'/pingpong2.tif'); 
mosaic_dir = strcat(dir,'/mosaic8.tif'); 

feli_im = imread(feli_dir);
hand_im = imread(hand_dir);
mosaic_im = imread(mosaic_dir);
pingpong_im = imread(pingpong_dir);

im_orig = feli_im;
im = rgb2gray(im_orig);


[height,width] = size(im);
stats_im = zeros(height,width,4);% Images for storing 4 different properties

mask_size = 11;
hm = floor(mask_size/2); % Half of mask size

for h = hm + 1 : height - hm
    for w = hm + 1 : width - hm
        mask_im = im(h-hm:h+hm,w-hm:w+hm);% Acquire 11*11 neighborhood
        glcm = graycomatrix(mask_im, 'Offset',[1 1],'Symmetric',true);% Compute GLCM matrix of current pixel
        stats = graycoprops(glcm); % Compute properties 
        stats_im(h,w,1) = stats.Contrast;
        stats_im(h,w,2) = stats.Correlation;
        stats_im(h,w,3) = stats.Energy;
        stats_im(h,w,4) = stats.Homogeneity;
    end
end

% change the NaN in correlation to 1;
A = stats_im(:,:,2);
A(isnan(A)) = 1 ;
stats_im(:,:,2) = A;

% plot the histogram of 4 properties
figure;
subplot(421);imshow(stats_im(:,:,1));title('Contrast');
subplot(423);imshow(stats_im(:,:,2));title('Correlation');
subplot(425);imshow(stats_im(:,:,3));title('Energy');
subplot(427);imshow(stats_im(:,:,4));title('Homogeneity');

subplot(422);histogram(stats_im(:,:,1));
subplot(424);histogram(stats_im(:,:,2));
subplot(426);histogram(stats_im(:,:,3));
subplot(428);histogram(stats_im(:,:,4));

%% segmentation

% Create an image containing color and texture features
im_ct = zeros(height,width,7);% Color and texure mixed images
im_ct(:,:,1:3) = im_orig;% color part
im_ct(:,:,4:7) = stats_im;% texture part
for i = 1 : 7
    maxval = max(max(im_ct(:,:,i)));
    minval = min(min(im_ct(:,:,i)));
    im_ct(:,:,i) = (im_ct(:,:,i) - minval)./maxval;
end
% Segment
im_plot = seg(im_ct(:,:,1:5),[1 1],0.25);

% Plot
figure;
imshow(im_plot,[]);
colormap colorcube;