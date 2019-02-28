function visualize_n_save(path, varargin)
% concatenates the images horizontally and saves them in the specified path

image = varargin{1};
for i = 2:length(varargin)
    image = [image, varargin{i}];
end

montage(image,'size',[1 NaN]);
imwrite(image, path)

end