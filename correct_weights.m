function w = correct_weights(w,threshold)

% if w = inf, w_new = high value
% if w = nan, w_new = 0

if nargin < 2, threshold = 1.5; end

idx_inf  = isinf(w);
idx_nan  = isnan(w);
idx_good = ~idx_inf & ~idx_nan;

q1  = prctile(w(idx_good),25);
q3  = prctile(w(idx_good),75);
thr = q3 + threshold*(q3 - q1); 
sat = max(w(w < thr));
w(w > thr) = sat;
w(idx_nan) = 0;

