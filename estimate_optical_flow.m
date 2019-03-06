function [vec] = estimate_optical_flow(image1, image2)
% Estimates the optical flow between the two given image patches

% Calculate A and b
[width, height] = size(image1);
len = width*height;
[Ix, Iy] = gradient(image1);
It = image2 - image1;
A = [reshape(Ix, [len, 1]), reshape(Iy, [len, 1])];
b = -reshape(It, [len, 1]);

% Calculate optical flow


vec=lsqminnorm(A,b);

end