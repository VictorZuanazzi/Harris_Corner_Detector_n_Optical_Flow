function [Gx, Gy, im_magnitude,im_direction] = compute_gradient(image)
image = 'images/image2.jpg'
image=im2double(imread(image));

Sobel_x = [ 1, 0, -1 ; 2, 0, -2 ; 1, 0, -1 ];
Sobel_y = Sobel_x';

Gx=imfilter(image,Sobel_x);
Gy=imfilter(image,Sobel_y);

im_magnitude = sqrt((Gx.^2+Gy.^2));
im_magnitude = imbinarize(rescale(im_magnitude));

%im_direction = atan2(Gy,Gx); % equiv to atan(Gy./Gx) but accounts for division by 0
im_direction = atan2(Gy,Gx);

out_image = [Gx,Gy;im_magnitude,im_direction];

imwrite(out_image,'images/gradients.png');

end

