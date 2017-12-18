function [labels, peaks] = SegmentImage(img,params)
% use for test in small data subset 
%data = test();
%[n,d] = size(data);
[x,y,d] = size(img);
n = x*y; %points vs data
data = reshape(img,[n,d]);
peaks_temp = zeros([n,d]);
peaks = zeros([1,d]);
clusters = zeros([n,1]);
notUsedFlag = zeros([1,d]);
cluster_no = 1;
for i = 1:n
        peak_found = false;
        if isequal(peaks_temp(i,:),notUsedFlag)
            new_peak = meanShift(data,i,params);
            peaks_temp(i,:) = new_peak;
            peak_found = true;
        end
        if(peak_found)  
            dist_matrix2 = sqrt(sum((data-new_peak).^2,2));
            for j = 1:n
                if (isequal(peaks_temp(j,:),notUsedFlag)&& dist_matrix2(j) <=  params(2))
                    peaks_temp(j,:) = new_peak; 
                end
            end
            
            non_empty = any(peaks_temp,2);
            dist_matrix = sqrt(sum((peaks_temp-new_peak).^2,2));
            dist_index = (dist_matrix <=  params(2)/2);
            indices = non_empty & dist_index;
            clusters(indices) =i;     
            if any(indices)
                clusters(i) = i;
            end
        end
end
unique_clusters =unique(clusters);
for i = 1:size(unique_clusters,1)
    peaks(i,:) =  mean(peaks_temp(clusters == unique_clusters(i),:),1);
end
%scatter(peaks(:,1),peaks(:,2),"Marker",'+',"MarkerFaceColor",[0,1,1]);pause;
labels = reshape(clusters,[x,y]);

