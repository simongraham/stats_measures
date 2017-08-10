clc
clear 
close all

%-------------------------------------------------------------------
% Author: Simon Graham
% Tissue Image Analytics Lab
% Department of Computer Science, 
% University of Warwick, UK.
%------------------------------------------------------------------

groundtruth_files = dir('/Users/simongraham/Desktop/Summer_Project/binary_maps/ground_truth1/*.png');
groundtruth_path = '/Users/simongraham/Desktop/Summer_Project/binary_maps/ground_truth1/';
prediction_path = '/Users/simongraham/Desktop/Summer_Project/binary_maps/unet/';
file_ext = '.png';
%------------------------------------------------------------------

stats_measure = 'tp_fp_fn';

if strcmp(stats_measure,'jaccard') == 1
    jac = 0;
    stats = {jac};
elseif strcmp(stats_measure,'dice') == 1
    dice = 0;
    stats = {dice};
elseif strcmp(stats_measure,'tp_fp_fn') == 1
    tp = 0;
    fp = 0;
    fn = 0;
    stats = {tp,fp,fn};
end
%----------------------------------------------------------------
    
for i = 1:length(groundtruth_files)
    image_name = groundtruth_files(i).name;
    disp( sprintf( 'Processing Image: %s', image_name ));
    pred_path = [prediction_path,image_name];
    prediction = imread(pred_path);
    gt_path = [groundtruth_path,image_name];
    gt = imread(gt_path);
    prediction = imresize(prediction, [size(gt,1) size(gt,2)]);
    
    if strcmp(stats_measure,'jaccard') == 1
        jac_ = JaccardCoefficient(gt,prediction);
        stats{1} = jac_ + stats{1};
    elseif strcmp(stats_measure,'dice') == 1
        dice_ = DiceIndex(gt,prediction);
        stats{1} = dice_ + stats{1};
    elseif strcmp(stats_measure,'tp_fp_fn') == 1
        [tp_,fp_,fn_] = find_tp_fp_fn(prediction,gt);
        stats{1} = tp_ + stats{1};
        stats{2} = fp_ + stats{2};
        stats{3} = fn_ + stats{3};
    end
end

stats

if strcmp(stats_measure,'tp_fp_fn') == 1
    [f1,pr,re] = Calculate_F1Score(stats{1},stats{2},stats{3});
    disp( sprintf( 'F1: %d, Precision: %d, Recall: %d', f1,pr,re ));
end

