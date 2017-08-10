function[tp, fp, fn] = find_tp_fp_fn(mask, gt)

% Author: Simon Graham
% Tissue Image Analytics Lab
% Department of Computer Science, 
% University of Warwick, UK.
%-------------------------------------------------------------------
% Parameters 
patchW =  80; % Width of patch
patchH = 80; % Height of patch
threshold = 0.5; % 50% threshold

% Arguments
% mask: predicted binary image
% gt: ground truth binary image
%-------------------------------------------------------------------

% Regions for TP, FP, FN
tp_mask =  (mask & gt);
fn_mask =  (gt - mask);
fp_mask = (mask - gt);

tp = 0; fp = 0; fn = 0;
for i=0:floor(size(gt,1)/patchH)-1
    for j=0:floor(size(gt,2)/patchW)-1
        tp_patch =  tp_mask(i*patchH +1 :(i+1)*patchH, j*patchW+1:(j+1)*patchW );
        fp_patch = fp_mask(i*patchH + 1:(i+1)*patchH, j*patchW+1:(j+1)*patchW );
        fn_patch = fn_mask(i*patchH+1:(i+1)*patchH, j*patchW+1:(j+1)*patchW );
        if (mean(tp_patch(:)) >= threshold)
            tp =  tp + 1;
        end
        if (mean(fp_patch(:)) >= threshold)
            fp =  fp + 1;
        end
        if (mean(fn_patch(:)) >= threshold)
            fn =  fn + 1;
        end
      
    end
end
end

