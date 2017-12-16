close all; clear all; clc;
img_path = 'cs484_hw3_data\';
imagefiles = dir(strcat(img_path,'*.jpg'));
gtfiles = dir(strcat(img_path,'*.png'));
[r,c] = size(imagefiles);
for i = 7
     I = imread(strcat(img_path,imagefiles(i).name) );
     img = imresize(I, .5); % This might not work, as number of
     %labels differ.
    gt = imread(strcat(img_path,gtfiles(i).name));
    %[a,b] = evaluate_performance(gt,gt);
     c = makecform('xyz2uvl');
     uvl_img =  applycform(rgb2xyz(img),c);
     params = [0.005,0.1];
     %params = [0.01,0.1];
     SegmentImage(uvl_img,params);
end
% I = imread('test7.jpg');
% img = imresize(I, [200 NaN]);
% params = [1,15];
% SegmentImage(img,params);
close all; clear all; clc;