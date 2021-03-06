function peak = meanShift(data,i,params)
% data is an nxd matrix with n being number of data points and d being the
% number of dimenisons. params 2x1 fist threshold and size of window
[n,d] = size(data);
center = double(data(i,:)); 
shift_dist = Inf;
while (shift_dist > params(1))
    if params(4) == 1
        diff_matrix =  double(sqrt(sum((data-center).^2,2)));
        neighborhood = data(diff_matrix< params(2),:);
        kernel_out_matrix = ((1/( params(2)*sqrt(2*pi))) *exp(-0.5*((diff_matrix(diff_matrix<params(2)) ./ params(2))).^2)).';
        nom = kernel_out_matrix * neighborhood;
        den = sum(kernel_out_matrix);   
        new_center = nom/den;
        shift_dist = euclidean_dist(new_center,center);
        if shift_dist >= params(1)
            center = new_center;
        end
    else
        % For spectral+spatial
        diff_matrix_sp =  double(sqrt(sum((data(:,1:3)-center(1:3)).^2,2)));
        diff_matrix_xy =  double(sqrt(sum((data(:,4:5)-center(4:5)).^2,2)));
        nb = data(diff_matrix_sp < params(2)& diff_matrix_xy< params(3),:);
        new_center = mean(nb,1);
        shift_dist = euclidean_dist(new_center,center);
        if(shift_dist >= params(1))
            center = new_center;
        end
    end
end
peak  = center;
end

