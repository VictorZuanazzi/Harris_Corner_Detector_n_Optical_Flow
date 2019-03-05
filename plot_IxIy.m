function  [] = plot_IxIy(Ix, Iy, name)

figure('visible','off');
imshow([Ix Iy], []);
title("Ix Iy " + name);
hold on

filename = strrep(name,' ','_');

path = "./results/harris_IxIy_" + filename + ".png";
saveas(gcf,path);