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
    nom = double(0);
    den = double(0);
    for j=1:n 
        point = double(data(j,:));
        x = euclidean_dist(point,center);
        kernel_out = kernel_gauss(x,b);
        nom = nom + (kernel_out * point);
        den = den + kernel_out;
    end
    new_center = nom/den;
    shift_dist = euclidean_dist(new_center,center);
    if shift_dist >= t
        center = new_center;
    end
end
peak  = center;
end

