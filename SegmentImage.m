function [labels peaks] = SegmentImage(img,params)
% use for test in small data subset 
%data = test();
%[n,d] = size(data);
[x,y,d] = size(img);
n = x*y; %points vs data
data = zeros(n,d);
for i = 1:x
    for j = 1:y
       data((i-1)*y+j,:) = img(i,j,:) ; % I shoud append i,j in here
    end
end
r = params(2);
peaks_temp = zeros([n,d]);
clusters = zeros([n,1]);
notUsedFlag = zeros([1,d]);
% Implement Neighborhood thingy
% Selim hoca baz?lar?n? atmay?p aras?na label bulunabilir demi?ti, nas?l?
for i= 1:n
        peak_found = false;
        if isequal(peaks_temp(i,:),notUsedFlag)
            new_peak = meanShift(data,i,params);
            peak_found = true;
        end
        if(peak_found)
            for j = i:n
                if (isequal(peaks_temp(j,:),notUsedFlag)&&(euclidean_dist(data(j,:),new_peak) <= r))
                peaks_temp(j,:) = new_peak; 
                end
            end
            % Compare all peaks and merge two peaks in one cluster if they are
            % closer than r/2 
            
%             dist_matrix =  sqrt(sum((double(peaks_temp)-double(new_peak)).^2,2));
%             dist_matrix = dist_matrix(~all(peaks_temp==0,2));
%             clusters(dist_matrix <= r/2) = i;
%             if  isempty( clusters(dist_matrix<= r/2))
%                 clusters(i) = i;
%             end
            notFoundFlag = true;
            for j = 1:n 
                if ~isequal(peaks_temp(j,:),notUsedFlag)&&((euclidean_dist(peaks_temp(j,:),new_peak)) <= r/2)
                    clusters(j) = i;
                    notFoundFlag = false;
                end
            end
            if notFoundFlag
                clusters(i) = i;
            end
        end
end
unique_clusters =unique(clusters);
for i = 1:size(unique_clusters,1)
    peaks(i,:) =  mean(peaks_temp(clusters == unique_clusters(i),:));
end
%scatter(peaks(:,1),peaks(:,2),"Marker",'+',"MarkerFaceColor",[0,1,1]);pause;
label = 1;
labels = zeros(x,y);
prev_cluster = 0;
for i = 1:x
    for j = 1:y
       if prev_cluster == clusters((i-1)*y+j)
            labels(i,j) = clusters((i-1)*y+j); % I shoud append i,j in here
       else 
           label = label + 1;
           labels(i,j) = clusters((i-1)*y+j);
       end
    previous_cluster = clusters((i-1)*y+j);   
    end
end
figure;imshow(label2rgb(labels));pause;
figure;imshow(img);pause;

