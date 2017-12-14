function distance = euclidean_dist(v,u)
% Assuming v and u are vectors of equal sizes
distance = double(sqrt(sum((v-u).^2)));
end