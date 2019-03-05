find_params = false;

if find_params
    % try a set of values for window and threshold to determin best fit
    
    % person toy
    image = imread('./person_toy/00000001.jpg');
    name = 'person toy';

    for w = 2:1:10
        for t = 10.^(-1:-1:-10)
            [H, row, col] = harris_corner_detector(image, t, w, name);
        end
    end

    % pingpong
    image = imread('./pingpong/0000.jpeg');
    name = 'pingpong';

    for w = 2:1:10
        for t = 10.^(-1:-1:-10)
            [H, row, col] = harris_corner_detector(image, t, w, name);
        end
    end
else
    % hand picked best values for window size and threshold
    
    % person toy
    image = imread('./person_toy/00000001.jpg');
    name = "person toy";

    w = 5;
    t = 1e-5;
    [H, row, col] = harris_corner_detector(image, t, w, name);

    % ping pong
    image = imread('./pingpong/0000.jpeg');
    name = "pingpong";

    w = 5;
    t = 1e-2;
    [H, row, col] = harris_corner_detector(image, t, w, name);
end