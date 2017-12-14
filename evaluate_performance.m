function [precision recall] = evaluate_performance(gt,result_labels)
boundaries = edge(gt,'Canny');
se = strel('disk',3);
boundaries_dilated_gt = imdilate(boundaries,se);
boundaries_found = edge(result_labels,'Canny');
boundaries_found(100:200,100:200) = 0;


figure; imshow(boundaries_dilated_gt);pause;
figure; imshow(boundaries_found);pause;
true_pos = double(numel(boundaries_dilated_gt(boundaries_found == 1))));
detected_boundary = double(numel(boundaries_found(boundaries_found == 1))); 
true_boundary = double(numel(boundaries(boundaries == 1)));

precision = true_pos / detected_boundary;
recall = true_pos / true_boundary;

clear all;
close all;
clc;
end
