function [precision, recall] = evaluate_performance(gt,result_labels)
boundaries = edge(gt,'Canny');
se = strel('disk',3);
boundaries_dilated_gt = imdilate(boundaries,se);
boundaries_found = edge(result_labels,'Canny');

true_pos = double(sum(boundaries_dilated_gt(boundaries_found == 1)));
detected_boundary = double(sum(sum(boundaries_found))); 
true_boundary = double(sum(sum(boundaries)));

precision = true_pos / detected_boundary;
recall = true_pos / true_boundary;

end
