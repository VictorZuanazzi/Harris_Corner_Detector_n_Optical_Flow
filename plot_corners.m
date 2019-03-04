function  [corners] = plot_corners(image, col, row, name)

fig = figure; 
imshow(image) 
hold on

for i = 1:size(row, 2)
    plot(col(i),row(i), 'oy'); 
end

file_name = sprintf('person_toy/%s.png', name)
saveas(gcf,file_name);
corners = gcf;
hold off

end