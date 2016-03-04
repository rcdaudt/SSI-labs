function desc = compute_descriptors(image,n)
    % Compute texture descriptors for each pixel of image using
    % (2n+1)x(2n+1) windows
    
    % Get size
    s = size(image);
    s(3) = size(image,3);
    
    % Initialize descriptors variable
%     desc = zeros(s(1),s(2),4*s(3));
    desc = zeros(s(1),s(2),3*s(3));
    
    for layer = 1:s(3) % For each layer
        current_layer = image(:,:,layer); % Get layer
        
        for row = 1:s(1)
            for col = 1:s(2) % For each pixel
                
                % Find boundaries of the window
                row_from = max(1,row-n);
                row_to = min(s(1),row+n);
                col_from = max(1,col-n);
                col_to = min(s(2),col+n);

                % Get glcm and properties in window
                glcm = graycomatrix(current_layer(row_from:row_to,col_from:col_to));
                props = graycoprops(glcm);
                
%                 % Store calculated values
%                 desc(row,col,layer*4-3) = props.Contrast;
%                 desc(row,col,layer*4-2) = props.Correlation;
%                 desc(row,col,layer*4-1) = props.Energy;
%                 desc(row,col,layer*4) = props.Homogeneity;

                % Store calculated values
                desc(row,col,layer*3-2) = props.Contrast;
                desc(row,col,layer*3-1) = props.Energy;
                desc(row,col,layer*3) = props.Homogeneity;
            end
        end
    end
    
end