function [] = lucas_kanade(image1, image2, patch_size)
% Uses the Lucas-Kanade algorithm to display the optical flow between the
% given images

% Rename input images
im1 = image1;
im2 = image2;

% Convert images to grayscale if necessary
if (size(im1,3) == 3) 
  im1=rgb2gray(im1); 
  im2=rgb2gray(im2);
 end

% Convert input images to double
im1 = im2double(im1);
im2 = im2double(im2);

% Crop images to be a multiple of patch_size in length and width
[height, width] = size(im1);
horizontal_cells = floor(width/patch_size);
vertical_cells = floor(height/patch_size);
im1 = imcrop(im1, [0, 0, horizontal_cells*patch_size, vertical_cells*patch_size]);
im2 = imcrop(im2, [0, 0, horizontal_cells*patch_size, vertical_cells*patch_size]);

% Split images into cells of size patch_sizexpatch_size
image1_split = mat2cell(im1, repmat(patch_size,1,horizontal_cells), repmat(patch_size,1,vertical_cells));
image2_split = mat2cell(im2, repmat(patch_size,1,horizontal_cells), repmat(patch_size,1,vertical_cells));

% Create x/y grid
x = linspace(8,horizontal_cells*15 - 7,horizontal_cells);
y = linspace(8,vertical_cells*15 - 7, vertical_cells);
[x,y] = meshgrid(x,y);

% Calculate corresponding optical flow vectors
u = zeros(horizontal_cells, vertical_cells);
v = zeros(horizontal_cells, vertical_cells);
for i=1:horizontal_cells
    for j=1:vertical_cells
        vec = estimate_optical_flow(image1_split{i,j}, image2_split{i,j});
        u(i, j) = vec(1);
        v(i, j) = vec(2);
    end
end

% Show optical flow figure
figure();
imshow(image1);
hold on;
q = quiver(x,y, u, v);
q.Color = 'red';

end

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
vec = pinv(A)*b;

end
