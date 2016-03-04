function final = rg(image, delta_in)
% Image segmentation by Region Growing
    
    % Image size
    s = size(image);
    s(3) = size(image,3); % Force a third dimensional measurement
    
    % Adjust delta for number of layers
    delta = delta_in*s(3);
    
    % Initialise matrix to store labels - Labels go from 1 to N, label 0
    % menas no label has been assigned yet
    final = zeros(s(1),s(2));
    
    % Label assigned to the region that is currently being grown (current
    % label)
    cl = 0;
    
    % Variable to store point coordinates to be processed on the next
    % generation
    ng = [];
    
    % Matrix of offsets for neighbours
    N = [-1 0;1 0;0 -1;0 1;1 1;1 -1;-1 1;-1 -1];
    
    
    % Main loop - Goes through all pixels to ensure all pixels have been
    % assigned a label
    for v = 1:s(1)
        for h = 1:s(2)
            % Check if a new region should be created
            if final(v,h)==0
                % Grow new region
                
                % Create new label for the new region
                cl = cl + 1;
                % Assign label to origin pixel
                final(v,h) = cl;
                % Put starting point in the list of points to be processed
                % (first generation)
                ng = [v h];
                
                % Grow region (by generations)
                repeat = true;
                while repeat
                    repeat = false;
                    cg = ng; % Current generation = next generation
                    ng = [];
                    
                    % Find mean in current region for each layer
                    indices = find(final==cl);
                    mu = zeros(s(3),1);
                    for layer = 1:s(3)
                        mu(layer) = mean(image(indices+(layer-1)*s(1)*s(2)));
                    end
                    
                    % Check neigbourhood for each pixel
                    for i = 1:size(cg,1)
                        % Get indices
                        row = cg(i,1);
                        col = cg(i,2);
                        
                        % Check all the neighbours
                        for neigh = 1:size(N,1)
                            vv = row + N(neigh,1);
                            hh = col + N(neigh,2);
                            if vv>=1 && vv<=s(1) && hh>=1 && hh<=s(2) % If coordinates are inside bounds
                                if final(vv,hh) == 0 % If pixel has no label

                                    diff = 0;
                                    for layer = 1:s(3) % Calculate Manhattan distance in RGB
                                        diff = diff + abs(image(vv,hh,layer)-mu(layer));
                                    end

                                    if diff <= delta
                                        repeat = true; % Mark loop to repeat for a new generation
                                        final(vv,hh) = cl; % Assign label to pixel
                                        ng = [ng;vv hh]; % Add pixel to processing queue
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end