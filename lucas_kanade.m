function [] = lucas_kanade(image1, image2)
% Uses the Lucas-Kanade algorithm to display the optical flow between the
% given images

% Copy input images
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

% Crop images to be a multiple of 15 in length and width
[height, width] = size(im1);
horizontal_cells = floor(width/15);
vertical_cells = floor(height/15);
im1 = imcrop(im1, [0, 0, horizontal_cells*15, vertical_cells*15]);
im2 = imcrop(im2, [0, 0, horizontal_cells*15, vertical_cells*15]);

% Split images into cells of size 15x15
image1_split = mat2cell(im1, repmat(15,1,horizontal_cells), repmat(15,1,vertical_cells));
image2_split = mat2cell(im2, repmat(15,1,horizontal_cells), repmat(15,1,vertical_cells));

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


function [vec] = estimate_optical_flow(image1, image2)
% Estimates the optical flow between the two given image patches

% Calculate A and b
[Ix, Iy] = gradient(image1);
It = image2 - image1;
A = [reshape(Ix, [225, 1]), reshape(Iy, [225, 1])];
b = -reshape(It, [225, 1]);

% Calculate optical flow
vec = pinv(A)*b;
