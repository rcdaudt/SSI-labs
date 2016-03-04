clear;
clc;
close all;

im_coins_dir = 'coins.png';
im_syn_dir = 'color.tif';
im_gan_dir = 'gantrycrane.png';
im_woman_dir = 'woman.tif';
im_coins = double(imread(im_coins_dir));
im_syn = double(imread(im_syn_dir));
im_gan = double(imread(im_gan_dir));
im_woman = double(imread(im_woman_dir));

%% Segmention
disp('Start segmenting...');

% Use of function seg
% segmented_result = seg(im, [x,y], delta)
% im: input image
% [x y]: starting point
% delta: threshold for region growing

tic
im_coins_label = seg(im_coins,[1 1],50);
toc
figure;
imshow(im_coins_label,[]);
colormap 'jet';

tic
im_syn_label = seg(im_syn,[1,1],50);
toc
figure;
imshow(im_syn_label,[]);
colormap 'jet';

tic
im_gan_label = seg(im_gan,[1 1],50);
toc
figure;
imshow(im_gan_label,[]);
colormap 'jet';

tic
im_woman_label = seg(im_woman,[1 1],25);
toc
figure;
imshow(im_woman_label,[]);
colormap 'hsv';

disp('Segmentation finished! The result is shown here.');