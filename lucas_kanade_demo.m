sphere1 = imread("sphere1.ppm");
sphere2 = imread("sphere2.ppm");
lucas_kanade(sphere1, sphere2, 15);
%export_fig sphere_flow.png;

synth1 = imread("synth1.pgm");
synth2 = imread("synth2.pgm");
%lucas_kanade(synth1, synth2, 15);
%export_fig synth_flow.png;

% INSTRUCTIONS
% either one of the functions above should be always commented out to
% produce the right result