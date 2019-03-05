find_params = false;

if find_params
    % try a set of values for window and threshold to determin best fit
    
    % person toy
    image = imread('./person_toy/00000001.jpg');
    name = 'person toy';

    for w = [6,8,10]
        for t = ([1e-3:1e-3:1e-2 1e-2:1e-2:1e-1 1e-1:1e-1:1e-0])
            [H, row, col, Ix, Iy] = harris_corner_detector(image, t, w, name);
            param_name = name + " t=" + num2str(t) + " w=" + num2str(w);
            plot_corners(image, col,row, param_name);
        end
    end
    plot_IxIy(Ix,Iy,name)

    % pingpong
    image = imread('./pingpong/0000.jpeg');
    name = 'pingpong';

    for w = [2,4,6,8,10]
        for t = ([1e-3:1e-3:1e-2 1e-2:1e-2:1e-1 1e-1:1e-1:1e-0])
            [H, row, col] = harris_corner_detector(image, t, w, name);
            param_name = name + " t=" + num2str(t) + " w=" + num2str(w);
            plot_corners(image, col,row, param_name);
        end
    end
    plot_IxIy(Ix,Iy,name)
else
    % hand picked best values for window size and threshold
    
    % person toy
    image = imread('./person_toy/00000001.jpg');
    name = "person toy";

    w = 6;
    t = 0.07;
    [H, row, col, Ix, Iy] = harris_corner_detector(image, t, w, name);
    param_name = name + " t=" + num2str(t) + " w=" + num2str(w);
    plot_corners(image, col,row, param_name);
    plot_IxIy(Ix,Iy,name);

    % ping pong
    image = imread('./pingpong/0000.jpeg');
    name = "pingpong";

    w = 2;
    t = 0.04;
    [H, row, col, Ix, Iy] = harris_corner_detector(image, t, w, name);
    param_name = name + " t=" + num2str(t) + " w=" + num2str(w);
    plot_corners(image, col,row, param_name);
    plot_IxIy(Ix,Iy,name);
end