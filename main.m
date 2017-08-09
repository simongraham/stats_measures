clc
clear 
close all
% 
se = strel('disk',10);
se2 = strel('disk',10);

ground_truth_files = dir('/Users/simongraham/Desktop/Summer_Project/binary_maps/ground_truth1/*.png');
tissue_path = '/Users/simongraham/Desktop/wsi_ims/non_tumour_gt/';
root = '/Users/simongraham/Desktop/wsi_ims/k_means/';
% jac = 0;
tp1 = 0;
fp1 = 0;
fn1 = 0;
tp2 = 0;
fp2 = 0;
fn2 = 0;
for i = 1:12
    i
    gt1 = '/Users/simongraham/Desktop/Summer_Project/binary_maps/ground_truth1/';
    gt2 = ground_truth_files(i).name;
    basename = gt2(7:9);
    tumour = [root,basename,'/tumour/process.png'];
    tumour = imread(tumour);
    fat = [root,basename,'/fat/process.png'];
    fat = imread(fat);
    non_tumour = [root,basename,'/non_tumour/process.png'];
    non_tumour = imread(non_tumour);
    
    tumour = imerode(tumour,se2);
    non_tumour = imerode(non_tumour,se2);
    fat = imerode(fat,se2);
    %imshow(non_tumour);
    
    ground_truth = [gt1,gt2];
    ground_truth = imread(ground_truth);
    ground_truth2 = ~ground_truth;
    
    tumour = imresize(tumour, [size(ground_truth,1) size(ground_truth,2)]);
    non_tumour = imresize(non_tumour, [size(ground_truth,1) size(ground_truth,2)]);
    fat = imresize(fat, [size(ground_truth,1) size(ground_truth,2)]);
    non_tumour = non_tumour | fat;
    %imshow(non_tumour);
    
    [tp_1,fp_1,fn_1] = find_tp_fp_fn(tumour,ground_truth);
    tp1 = tp1 + tp_1;
    fp1 = fp1 + fp_1;
    fn1 = fn1 + fn_1;
    
        
    [tp_2,fp_2,fn_2] = find_tp_fp_fn(non_tumour,ground_truth2);
    tp2 = tp2 + tp_2;
    fp2 = fp2 + fp_2;
    fn2 = fn2 + fn_2;
%     imshow(image);
%     ground_truth = [tissue_path,'image-',basename,'.png'];
%     ground_truth = imread(ground_truth);
%     fat_file = [root,basename,'/fat/process.png'];
%     fat = imread(fat_file);
%     non_tumour_file = [root,basename,'/non_tumour/process.png'];
%     non_tumour = imread(non_tumour_file);
%     combined = non_tumour | fat;
%     combined = imclose(combined,se);
%     combined = imerode(combined,se2);
%     %imshow(combined);
%     non_tumour = imresize(fat, [size(ground_truth,1) size(ground_truth,2)]);
%     combined  = imresize(combined, [size(ground_truth,1) size(ground_truth,2)]);
%     ground_truth = im2bw(ground_truth,0.1);
%     combined = im2bw(combined,0.1);
%     non_tumour = im2bw(non_tumour,0.1);
 
end
tp1;
fp1;
fn1;
tp2;
fp2;
fn2;

[f1_1,pr_1,re_1] = Calculate_F1Score(tp1,fp1,fn1);
f1_1
pr_1
re_1

[f1_2,pr_2,re_2] = Calculate_F1Score(tp2,fp2,fn2);
f1_2
pr_2
re_2

%     i
%     gt1 = '/Users/simongraham/Desktop/Summer_Project/binary_maps/ground_truth1/';
%     gt2 = ground_truth_files(i).name;
%     gt_ = strcat(gt1,gt2);
%     gt = imread(gt_);
%     basename = gt2(7:9);
%     pred_file = [pred_path,'TUPAC-TR-',basename,'.png'];
%     pred = imread(pred_file);
%     pred  = imresize(pred, [size(gt,1) size(gt,2)]);
%     [tp_,fp_,fn_] = find_tp_fp_fn(pred,gt);
%     tp = tp + tp_;
%     fp = fp + fp_;
%     fn = fn + fn_;
%     %jac = jac + JaccardCoefficient(gt,pred);
% end
% 
% tp
% fp
% fn