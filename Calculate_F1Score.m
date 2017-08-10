function [F1_score,Pr,Re] =  Calculate_F1Score(tp, fp, fn)

%-------------------------------------------------------------------
% Author: Simon Graham
% Tissue Image Analytics Lab
% Department of Computer Science, 
% University of Warwick, UK.
%------------------------------------------------------------------
% Variables:
% tp = number of true positives
% fp = number of false positives
% fn = number of false negatives
%------------------------------------------------------------------
% tp, fp, fn should be integer values
% they should contain the number of patches 
%------------------------------------------------------------------

Pr = tp / (tp + fp);
Re = tp / (tp + fn);
F1_score =  2*((Pr*Re)/(Pr+Re));
end
