function [labels peaks] = SegmentImage(img,params)
% use for test in small data subset 
data = test();
[n,d] = size(data);
%[x,y,d] = size(img);
%n = x*y; %points vs data
%data = zeros(n,d);
% for i = 1:x
%     for j = 1:y
%        data((i-1)*y+j,:) = img(i,j,:) ; % I shoud append i,j in here
%     end
% end
r = params(2);
peaks_temp = zeros([n,d]) - 1;
clusters = zeros([n,1]) - 1;
notUsedFlag = zeros([1,d]) - 1;
% Implement Neighborhood thingy
% Selim hoca baz?lar?n? atmay?p aras?na label bulunabilir demi?ti, nas?l?
for i= 1:n
        peak_found = false;
        if isequal(peaks_temp(i,:),notUsedFlag)
            new_peak = meanShift(data,i,params);
            peak_found = true;
        end
        if(peak_found && ~any(ismember(peaks_temp,new_peak,'rows')))
            peaks_temp(i,:) = new_peak; 
            for j = i:n
                if (isequal(peaks_temp(j,:),notUsedFlag)&&euclidean_dist(data(j,:),new_peak) <= r)
                peaks_temp(j,:) = new_peak; 
                end
            end
            % Compare all peaks and merge two peaks in one cluster if they are
            % closer than r/2 
            notFoundFlag = true;
            for j = 1:n 
                if ~isequal(peaks_temp(j,:),notUsedFlag)&&(euclidean_dist(peaks_temp(j,:),new_peak) <= r/2)
                    clusters(j) = i;
                    notFoundFlag = false;
                end
            end
            if notFoundFlag
                clusters(i) = i;
            end
       end
end
scatter(peaks_temp(clusters,1),peaks_temp(clusters,2),"Marker",'+',"MarkerFaceColor",[1,0,0]);pause;
