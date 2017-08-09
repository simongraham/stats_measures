function[tp, fp, fn] = find_tp_fp_fn(mask, gt)
% parameters 
patchW =  80;
patchH = 80;
thres = 0.5; % means 50%

% Regions for TP, FP, FN
tp_mask =  im2bw((mask & gt));
fn_mask =  im2bw(gt - mask);
fp_mask = im2bw(mask - gt);

tp = 0; fp = 0; fn = 0;
for i=0:floor(size(gt,1)/patchH)-1
    for j=0:floor(size(gt,2)/patchW)-1
        tp_patch =  tp_mask(i*patchH +1 :(i+1)*patchH, j*patchW+1:(j+1)*patchW );
        fp_patch = fp_mask(i*patchH + 1:(i+1)*patchH, j*patchW+1:(j+1)*patchW );
        fn_patch = fn_mask(i*patchH+1:(i+1)*patchH, j*patchW+1:(j+1)*patchW );
        if (mean(tp_patch(:)) >= 0.5)
            tp =  tp + 1;
        end
        if (mean(fp_patch(:)) >= 0.5)
            fp =  fp + 1;
        end
        if (mean(fn_patch(:)) >= 0.5)
            fn =  fn + 1;
        end
      
    end
end
end

