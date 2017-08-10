function [acc] =  Accuracy(ground_truth, prediction)

% Author: Simon Graham
% Tissue Image Analytics Lab
% Department of Computer Science, 
% University of Warwick, UK.
%-------------------------------------------------------------------
% Both prediction and ground_truth 
% should conatain 1-Channel 
% Hint: use im2bw(img) to convert image to single channel
%------------------------------------------------------------------

% Check if images contain single channel
if ~islogical(ground_truth)
    error('Image must be in logical format');
end
if ~islogical(prediction)
    error('Image must be in logical format');
end

 number_pixels = size(ground_truth,1) * size(ground_truth,2);
 
 true_positive = (prediction & ground_truth);
 true_negative = (~prediction & ~ground_truth);
 combined = (true_positive + true_negative);
 
 number_correct = sum(combined(:));
 acc = number_correct / number_pixels;
 
end
