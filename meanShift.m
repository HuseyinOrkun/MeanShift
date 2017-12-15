function peak = meanShift(data,i,params)
% data is an nxd matrix with n being number of data points and d being the
% number of dimenisons. params 2x1 fist threshold and size of window
[n,d] = size(data);
t = params(1);
r = params(2);
b = r;                    % bandwidth?
center = double(data(i,:)); 
shift_dist = Inf;
while (shift_dist > t)
     diff_matrix =  double(sqrt(sum((data-center).^2,2)));
     kernel = @kernel_gauss;
     kernel_out_matrix(1,:) = bsxfun(kernel,diff_matrix,b); % Consider doing kernel here too
     nom = kernel_out_matrix * data;
     den = sum(kernel_out_matrix);   
%     for j=1:n  Above is vectorized of this gor loop
%         point = double(data(j,:));
%         x = euclidean_dist(point,center);
%         kernel_out = kernel_gauss(x,b);
%         nom = nom + (kernel_out * point);
%         den = den + kernel_out;
%     end
    new_center = nom/den;
    shift_dist = euclidean_dist(new_center,center);
    if shift_dist >= t
        center = new_center;
    end
end
peak  = center;
end

