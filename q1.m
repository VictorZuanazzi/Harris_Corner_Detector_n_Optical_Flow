image = imread('./person_toy/00000001.jpg');

threshold = [0, 1];
t = 0;
w = 5;

[H, row, col] = harris_corner_detector(image, t, w);