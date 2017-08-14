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
groundtruth_path = '/Users/simongraham/Desktop/test_ims/ground_truth/';
groundtruth_files = dir([groundtruth_path,'*',file_ext_gt]);
probmap_path = '/Users/simongraham/Desktop/test_ims/prob_map/';

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

x = linspace(0,1);
y = linspace(0,1);
[X,Y,T,AUC] = perfcurve(labels_vector,prob_vector,1);

figure
plot(X,Y,'r',x,y,'b--')
legend('ROC curve', 'y=x', 'FontSize',20)
title('ROC Curve Plot', 'FontSize',25)
xlabel('False Positive Rate', 'FontSize',20)
ylabel('True Positive Rate', 'FontSize',20)

AUC

