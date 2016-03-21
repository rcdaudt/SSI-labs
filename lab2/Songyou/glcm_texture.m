function im_ct = glcm_texture(im_orig)
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
        stats_im(h,w,2) = stats.Homogeneity;
        stats_im(h,w,3) = stats.Energy;
        stats_im(h,w,4) = stats.Correlation;
    end
end

% change the NaN in correlation to 1;
A = stats_im(:,:,4);
A(isnan(A)) = 1 ;
stats_im(:,:,4) = A;

% Create an image containing color and texture features
im_ct = zeros(height,width,7);% Color and texure mixed images
im_ct(:,:,1:3) = im_orig;% color part
im_ct(:,:,4:7) = stats_im;% texture part

% Normalizations for RGB and texture images
for i = 1 : 7
    maxval = max(max(im_ct(:,:,i)));
    minval = min(min(im_ct(:,:,i)));
    im_ct(:,:,i) = (im_ct(:,:,i) - minval)./maxval;
end
end