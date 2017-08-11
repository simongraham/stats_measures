clc 
clear
close all

% Author: Simon Graham
% Tissue Image Analytics Lab
% Department of Computer Science, 
% University of Warwick, UK.
%-------------------------------------------------------------------

file_ext_gt = '.png';
file_ext_prob = '.mat';
groundtruth_path = 'groundtruth_path/';
groundtruth_files = dir([groundtruth_path,'*',file_ext_gt]);
probmap_path = 'probmap_path/';

%-------------------------------------------------------------------

for i = 1:length(groundtruth_files)
    
    image_name = groundtruth_files(i).name;
    image_split = strsplit(image_name,'.');
    image_basename = image_split(1);
    disp( sprintf( 'Processing Image: %s', image_basename{1}));
    
    image_prob_path = [probmap_path,image_basename{1},file_ext_prob];
    load(image_prob_path);
    image_prob = result;
    image_gt_path = [groundtruth_path,image_basename{1},file_ext_gt];
    image_gt = imread(image_gt_path);
    image_prob = imresize(image_prob,[size(image_gt,1),size(image_gt,2)]);
    
    image_gt = image_gt(:);
    image_prob = image_prob(:);
    
    if  i > 1
        labels_vector = [labels_vector;image_gt];
        prob_vector = [prob_vector;image_prob];
    else
        labels_vector = image_gt;
        prob_vector = image_prob;
    end

end

[X,Y] = perfcurve(labels_vector,prob_vector,1);
plot(X,Y)
title 'ROC Curve';

