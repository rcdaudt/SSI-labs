function v = computeFeatureVector(A)
%
% Describe an image A using texture features.
%   A is the image
%   v is a 1xN vector, being N the number of features used to describe the
% image
%

if size(A,3) > 1,
	A = rgb2gray(A);
end


direc = [0 1;-1 1; -1 0; -1 -1;0 12;-12 12; -12 0; -12 -12;0 23;-23 23; -23 0; -23 -23];% 92.5 percent accuracy


v = zeros(1, size(direc,1)*4); % feature vectors
stats_v = zeros(1,4); % tmp statistics vector
for i = 1 : size(direc,1)
    glcm = graycomatrix(A, 'Offset',direc(i,:),'Symmetric',true);% Compute GLCM matrix of current pixel
    stats = graycoprops(glcm); % Compute properties 
    stats_v(1) = stats.Contrast;
    if isnan(stats.Correlation) == 1 % Change all the NaN values to 1
        stats_v(2) = 1;
    else
        stats_v(2) = stats.Correlation;
    end
    stats_v(3) = stats.Energy;
    stats_v(4) = stats.Homogeneity;
    v(4*(i-1) + 1: 4*(i-1) + 4) = stats_v;
end
