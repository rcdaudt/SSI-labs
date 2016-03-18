function im_label = seg(im,p,delta)
    [height, width, z] = size(im);
    if p(1) < 1 || p(1) > height || p(2) < 1 || p(2) > width
        error('Sorry, the starting point is out of the range!');
%         exit(0);
    end
    im_label = zeros(height, width);
    nd = [-1 0; 0 1; 1 0; 0 -1]; % neighborhood diretions (In our case is 4 nieghbors)
    R_label = 1;
    delta = delta * z;
    Error = 0;

    % This loop checks if all regions has been segmented
    im_label(p(1),p(2)) = R_label;
    while 1 
        q = p; % The first element in the waiting queue
        R_mean = im(q(1,1),q(1,2),:);
        pn = 1; % Initialize the pixel number in the current region
        
        % This loop checks if the current region finishes growing alreay
        while size(q,1) ~= 0 
            p_cur = q(1,:);  % Always use the first element in the queue as the current point
            % Visit the neighborhoods of the current point
            for i = 1 : size(nd,1)
                p_neighbor = p_cur + nd(i,:);

                % Make sure the neighborhood is valid and not labeled
                if p_neighbor(1) >= 1 && p_neighbor(2) >=1 && p_neighbor(1) <= height && p_neighbor(2) <= width && im_label(p_neighbor(1),p_neighbor(2)) ==0
                    for j = 1 : z
                        Error = Error + abs(im(p_neighbor(1),p_neighbor(2), j) - R_mean(j)); % Absolute sum
%                          Error = Error + (im(p_neighbor(1), p_neighbor(2), j) - R_mean(j)).^2; 
                    end
%                     Error = sqrt(Error); % Euclidean distance
                    if Error <= delta
                        %give label
                        im_label(p_neighbor(1),p_neighbor(2)) = R_label; 
                        %update mean
                        for j = 1 : z
                            R_mean(j) = (R_mean(j) * pn + im(p_neighbor(1),p_neighbor(2),j))/(pn+1);
                        end
                        %update pixel number in the region
                        pn = pn + 1;
                        %insert into the waiting queue
                        q = [q; p_neighbor];
                    end
                    Error = 0;
                end
            end
            q = q(2:end,:);
        end
        R_label = R_label + 1; % Update label
        [h,w] = find(im_label == 0,1,'first');
        if size(h,1) ~= 0
            p(1) = h;% Decide the starting point for the next region
            p(2) = w;
            im_label(p(1),p(2)) = R_label;
        else
            break;
        end
    end

end