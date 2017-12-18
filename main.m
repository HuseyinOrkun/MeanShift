close all; clear all; clc;
img_path = 'cs484_hw3_data\';
mkdir('cs484_hw3_results');
out_path = 'cs484_hw3_results\';
imagefiles = dir(strcat(img_path,'*.jpg'));
gtfiles = dir(strcat(img_path,'*.png'));
[r,c] = size(imagefiles);

for i = 11:r
     img = imread(strcat(img_path,imagefiles(i).name) );
     img = imresize(img,0.7); % This might not work, as number of

     gt = imread(strcat(img_path,gtfiles(i).name));
     gt = imresize(gt,0.7);
     lab = rgb2lab(img);
     params_matrix = [2, 20, 0, 1]; 
     for k = 1:1
         r = params_matrix(k,2);
         t = params_matrix(k,1);
         [labels, peaks] = SegmentImage(lab,params_matrix(k,:));
         rgb_labels = label2rgb(labels);
         %figure;imshow(rgb_labels);
         imwrite(rgb_labels,strcat(out_path,num2str(i),'-label-1-t-',num2str(t), '-r-', num2str(r),'.jpg'));
         boundaries = edge(labels,'Canny');
         boundary_img = img;   
         for l =1:size(img,1)
            for j = 1 :size(img,2)
                if boundaries(l,j) == 1
                    boundary_img(l,j,:) = [255,0,0];
                end
            end
         end
         [recall, presicion] = evaluate_performance(gt,labels);
         results(i,k,:) = [recall presicion];
         imwrite(boundary_img,strcat(out_path,num2str(i),'-boundaries-1-t-',num2str(t), '-r-', num2str(r),'.jpg'));
         disp(strcat('image',num2str(i),'p:',num2str(presicion),'r: ',num2str(recall)));
     end
end 
save('results',results);
close all; clear all; clc;