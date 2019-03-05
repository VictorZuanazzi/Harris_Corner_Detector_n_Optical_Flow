function [H, row, col] = harris_corner_detector(Image, threshold, window_size, name)

if nargin < 4
    name = "";
end

% converts ints to doubles
Image = im2double(Image);

% save for plotting
ImageColor = Image;

% convert image to grayscale first
Image = rgb2gray(Image);

% image size
[h, w] = size(Image);

% gets gradient in both directions
% use gaussian to take the gradient
G = fspecial('gaussian');
[Gx, Gy] = gradient(G);
Ix = conv2(Image, Gx, 'same');
Iy = conv2(Image, Gy, 'same');

% compute 2nd order derivatives
Ix2 = conv2(Ix.^2, G, 'same');
Iy2 = conv2(Iy.^2, G, 'same');
Ixy = conv2(Ix.*Iy, G, 'same');

% empirical constant
k = 0.04;

% Harris' matrix


%half of window size
h_ws = floor(window_size/2);
H = zeros(h + window_size, w + window_size);

%change that for padding.
for y = h_ws  + 1: h - h_ws
    for x = h_ws + 1 : w - h_ws
        
        Ix2_matrix = Ix2(y-h_ws:y+h_ws,x-h_ws:x+h_ws);
        Ix2_sum = sum(Ix2_matrix, 'all');
        
        % Iy2 mean
        Iy2_matrix = Iy2(y-h_ws:y+h_ws,x-h_ws:x+h_ws);
        Iy2_sum = sum(Iy2_matrix, 'all');
        
        % Ixy mean
        Ixy_matrix = Ixy(y-h_ws:y+h_ws,x-h_ws:x+h_ws);
        Ixy_sum = sum(Ixy_matrix, 'all');
        
        % compute R, using te matrix we just created
        Matrix = [Ix2_sum, Ixy_sum; 
                  Ixy_sum, Iy2_sum];
              
        R1 = det(Matrix) - (k * trace(Matrix)^2);
        
        % store the R values in our Harris Matrix
        H(y,x) = R1;
       
    end
end

% set threshold of 'cornerness' to 5 times average R score
count = 1;
for y = h_ws + 1 : h - h_ws      
    for x = h_ws + 1 : w - h_ws 
        max_pixel = max(max(H(y-h_ws:y+h_ws,x-h_ws:x+h_ws)));
        if max_pixel >= threshold
            if max_pixel == H(y,x)
                %assigns the coordinates, corrected for padding
                row(count) = y - h_ws; 
                col(count) = x - h_ws; 
                count = count + 1;
            end
        end
    end
end

%undo padding
H = H(h_ws+1:end -h_ws, h_ws+1:end -h_ws);

param_name = name + " t=" + num2str(threshold) + " w=" + num2str(window_size);

corners = plot_corners(ImageColor, col,row, param_name);
figure('visible','off');
imshow([Ix Iy], []);
title("Ix Iy " + name);
hold on

filename = strrep(name,' ','_');

path = "./results/harris_IxIy_" + filename + ".png";
saveas(gcf,path);

%figure;
%imshow(corners);


end