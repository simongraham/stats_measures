function [dice] =  DiceIndex(ground_truth, prediction)
% Both prediction and ground_truth 
% should conatain 1-Channel 
% Hint: use im2bw(img) to convert image to single channel

%------------------------------------------------------------------
% Author: Talha Qaiser
% Tissue Image Analytics Lab
% Department of Computer Science, 
% University of Warwick, UK.
% http://www2.warwick.ac.uk/fac/sci/dcs/people/research/talhaqaiser
%-------------------------------------------------------------------

% Check if images contain single channel
if ~islogical(ground_truth)
    error('Image must be in logical format');
end
if ~islogical(prediction)
    error('Image must be in logical format');
end

 common = (ground_truth & prediction);
 a = sum(common(:));
 b = sum(ground_truth (:));
 c = sum(prediction(:));
 dice = 2*a/(b+c);
 
end