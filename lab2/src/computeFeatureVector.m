function v = computeFeatureVector(A)
%
% Describe an image A using texture features.
%   A is the image
%   v is a 1xN vector, being N the number of features used to describe the
% image
%

r = mean(mean(A(:,:,1)));
g = mean(mean(A(:,:,2)));
b = mean(mean(A(:,:,3)));

if size(A,3) > 1,
	A = rgb2gray(A);
end

n = [12 23 1];
for i = 1:length(n)
    offsets = [n(i) 0; 0 n(i);n(i) n(i);n(i) -n(i)];
end

v = zeros(1,4*size(offsets,1));

for i = 1:size(offsets,1)
    desc1 = graycoprops(graycomatrix(A,'Offset',offsets(i,:)));
    v((4*i-3):4*i) = [desc1.Contrast desc1.Correlation desc1.Energy desc1.Homogeneity];
end

% v = v/mean(mean(A));
v = [r g b v]/mean(mean(A));