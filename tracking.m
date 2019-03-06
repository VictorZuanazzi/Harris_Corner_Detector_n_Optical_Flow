function    tracking(type)
    % choose params depending on type 
    if type =="person_toy"
        path = "./person_toy/";
        file_ending ="*.jpg";
        gif_name = "person_toy.gif";
        window_size =  7;
    elseif type =="pingpong"
        path = "./pingpong/";
        file_ending = "*.jpeg";
        gif_name = "pingpong.gif";
        window_size =  9;
    end
   
    %LOAD IMAGES
    files = dir(fullfile(path, file_ending));
    nfiles = length(files);

    % for edge detection
    threshold = 0.03;

    % for velocity vec
    patch_size = 15 ; % window size for which the vel vector is calculated
    shift_constant = 1; % additive constant such that the new edge moves min 1 pixel after rounding to nearest int

    % allow only odd sized patches
    if mod(patch_size, 2) == 0
        error('patch_size must be odd to have the edge as center')
    end

    %load all images 
    for k=1:nfiles
        image_{k} = imread(path+files(k).name );
    end

    % load first image
    image1=im2double(image_{1});
    [height,width,dim]=size(image1);

    % % apply gaussian smoothing filter before starting
    kernel_size = 3 ; 
    sigma = 1.0; 
    image1 = imfilter(image1, gauss2D(sigma, kernel_size), 'conv');

    % determine edges 
    [H, row, col] = harris_corner_detector(image1, threshold, window_size);

    current_edge_y = row ;
    current_edge_x = col ;

    number_of_edges = length(row);

    for n=1:(nfiles-1)

        image1=im2double(image_{n});
        image2=im2double(image_{n+1});

            % determine windows for optical flow 
            for i=1:number_of_edges
                
                % determine box for which velo vector is calculated
                window_x = [current_edge_x(i)-floor(patch_size/2):current_edge_x(i)+floor(patch_size/2)];
                window_y = [current_edge_y(i)-floor(patch_size/2):current_edge_y(i)+floor(patch_size/2)];

                % cut window if it would lead outside of the image
                window_x=window_x(window_x>0);
                window_y=window_y(window_y>0);

                window_x=window_x(window_x<width+1);
                window_y=window_y(window_y<height+1);

                % get sub images for the velo vector
                sub_image1 = image1(window_y,window_x);
                sub_image2 = image2(window_y,window_x);

                vel_vec = estimate_optical_flow(sub_image1, sub_image2);

                vel_vec_x(i) = vel_vec(1); 
                vel_vec_y(i) = vel_vec(2); 

            end          

        % plot image with flow vectors
        h=figure(1);
        imshow(image1);
        hold on;
        
        %add current edges to image
        plot(current_edge_x(:),current_edge_y(:), ['.','r'], 'MarkerSize',10); 
        
        %add flow vector
        q = quiver(current_edge_x,current_edge_y, vel_vec_x, vel_vec_y);
        q.Color = 'yellow';

        % write files with velocity vectors and edges to folder
        full_path = sprintf(path+'/Movie/%s.jpg' , num2str(n));
        saveas(gcf,full_path);
        
        % construct here a gif
        frame = getframe(h);
        im = frame2im(frame);
        [imind,cm] = rgb2ind(im,256);
        if n == 1 
          imwrite(imind,cm,gif_name,'gif', 'Loopcount',inf,'DelayTime',0.1); 
        else 
          imwrite(imind,cm,gif_name,'gif','WriteMode','append','DelayTime',0.1); 
        end 


        % set the new edges
        current_edge_x = round(current_edge_x + vel_vec_x +sign(vel_vec_x)*shift_constant,0) ; 
        current_edge_y = round(current_edge_y + vel_vec_y +sign(vel_vec_y)*shift_constant,0) ;

        % if due to the shift an edge drops out of the image we clip it 
        current_edge_x(current_edge_x<1)=1;
        current_edge_y(current_edge_y<1)=1;

        current_edge_x(current_edge_x>width)=width;
        current_edge_y(current_edge_y>height)=height;

    end
    close all % closes all figures
end










