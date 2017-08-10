clc
clear 
close all

%-------------------------------------------------------------------
% Author: Simon Graham
% Tissue Image Analytics Lab
% Department of Computer Science, 
% University of Warwick, UK.
%------------------------------------------------------------------

file_ext = '.png';
groundtruth_files = dir(['/ground_truth_path/*',file_ext]);
groundtruth_path = '/ground_truth_path/';
prediction_path = '/prediction_path/';

% Note: Image names in prediction and ground truth file must be the same
% Change above paths accordingly and file 
% Images must be in binary format. If not use im2bw function 
%------------------------------------------------------------------

stats_measure = 'jaccard';

if strcmp(stats_measure,'jaccard') == 1
    jac = 0;
    stats = {jac};
elseif strcmp(stats_measure,'dice') == 1
    dice = 0;
    stats = {dice};
elseif strcmp(stats_measure,'accuracy') == 1
    acc = 0;
    stats = {acc};
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
    elseif strcmp(stats_measure,'accuracy') == 1
        acc_ = Accuracy(gt,prediction);
        stats{1} = acc_ + stats{1};
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

