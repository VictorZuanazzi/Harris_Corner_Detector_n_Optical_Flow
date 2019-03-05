function  [corners] = plot_corners(image, col, row, name, angle)

figure('visible','off'); 
imshow(image);
title('corners ' + name);
hold on

for i = 1:size(row, 2)
    plot(col(i) + 2,row(i) + 2, 'xy'); 
end
if nargin > 4
    camroll(angle)
end


filename = strrep(name,' ','_');
file_name = sprintf('results/%s.png', filename);
saveas(gcf,file_name);
corners = gcf;
hold off

end