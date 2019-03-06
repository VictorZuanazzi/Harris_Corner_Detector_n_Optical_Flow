type = "person_toy";

if type =="person_toy"
    path = "./person_toy/";
    file_ending ="*.jpg";
    gif_name = "person_toy_2.gif";
    window_size =  7;
elseif type =="pingpong"
    path = "./pingpong/";
    file_ending = "*.jpeg";
    gif_name = "pingpong_2.gif";
    window_size =  9;
end

%LOAD_SYN_IMAGES read from directory image_dir all files with extension png
%   image_dir: path to the image directory
%   nchannel: the image channel to be loaded, default = 1
%
%   image_stack: all images stacked along the 3rd channel
%   scriptV: light directions

files = dir(fullfile(path, file_ending));
nfiles = length(files);

% for edge detection
threshold = 0.03;

% for velocity vec
patch_size = 15 ; % window size for which the vel vector is calculated
shift_constant = 0.5; % additive constant such that the new edge moves min 1 pixel

% allow only odd sized patches
if mod(patch_size, 2) == 0
    error('patch_size must be odd to have the edge as center')
end

%load all images 
for k=1:nfiles
    image_{k} = imread(path+files(k).name );
end

% load first image
image1=im2double(image_{1});
[height,width,dim]=size(image1);

% % apply gaussian smoothing filter before starting
kernel_size = 3 ; 
sigma = 1.0; 
image1 = imfilter(image1, gauss2D(sigma, kernel_size), 'conv');

% determine edges 
[H, row, col] = harris_corner_detector(image1, threshold, window_size);