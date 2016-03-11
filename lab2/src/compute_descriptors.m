function desc = compute_descriptors(image,n)
    % Compute texture descriptors for each pixel of image using
    % (2n+1)x(2n+1) windows
    
    % Ensure image is in grayscale
    if size(image,3) > 1,
        image = rgb2gray(image);
    end
    
    % Get size
    s = size(image);
    
    % Initialize descriptors variable
    desc = zeros(s(1),s(2),3);
    

    for row = 1:s(1)
        for col = 1:s(2) % For each pixel

            % Find boundaries of the window
            row_from = max(1,row-n);
            row_to = min(s(1),row+n);
            col_from = max(1,col-n);
            col_to = min(s(2),col+n);

            % Get glcm and properties in window
            glcm = graycomatrix(image(row_from:row_to,col_from:col_to));
            props = graycoprops(glcm);

            % Store calculated values
            desc(row,col,1) = props.Contrast;
            desc(row,col,2) = props.Energy;
            desc(row,col,3) = props.Homogeneity;
        end
    end

    
end