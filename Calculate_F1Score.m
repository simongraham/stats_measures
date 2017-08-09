function [F1_score,Pr,Re] =  Calculate_F1Score(tp, fp, fn)
% tp, fp, fn should be integer values
% they should contain the number of patches 

%------------------------------------------------------------------
% Author: Talha Qaiser
% Tissue Image Analytics Lab
% Department of Computer Science, 
% University of Warwick, UK.
% http://www2.warwick.ac.uk/fac/sci/dcs/people/research/talhaqaiser
%-------------------------------------------------------------------

Pr = tp / (tp + fp);
Re = tp / (tp + fn);
F1_score =  2*((Pr*Re)/(Pr+Re));
end
