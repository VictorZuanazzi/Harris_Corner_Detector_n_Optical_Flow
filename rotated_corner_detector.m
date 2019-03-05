function [] = rotated_corner_detector(image, angle, name, w, t)
% default parameters
if nargin < 3
    name = "";
end
if nargin < 4
    w = 6;
end
if nargin < 5
    t = 0.07;
end

rot_image = imrotate(image, angle);

% rotate before 
[H, row, col, Ix, Iy] = harris_corner_detector(rot_image, t, w, name);
param_name = name + " t=" + num2str(t) + " w=" + num2str(w);
plot_corners(rot_image, col,row, param_name);
plot_IxIy(Ix,Iy,name);

% rotate after
name = name + " rotate after";
[H, row, col, Ix, Iy] = harris_corner_detector(image, t, w, name);
param_name = name + " t=" + num2str(t) + " w=" + num2str(w);
plot_corners(image, col,row, param_name, angle);