function  [corners] = plot_corners(image, col, row, name)

fig = figure('visible','off'); 
imshow(image);
title('corners ' + name);
hold on

for i = 1:size(row, 2)
    plot(col(i),row(i), 'oy'); 
end

filename = strrep(name,' ','_');
file_name = sprintf('results/%s.png', filename);
saveas(gcf,file_name);
corners = gcf;
hold off

end