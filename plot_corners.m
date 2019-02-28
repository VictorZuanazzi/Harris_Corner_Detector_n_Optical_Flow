function  [corners] = plot_corners(image, col, row, name)

fig = figure; 
imshow(image) 
hold on

for i = 1:size(row, 2)
    plot(col(i),row(i), 'o'); 
end

file_name = './person_toy/'+ name +'.png';
saveas(gcf,file_name);
corners = gcf;
hold off

end