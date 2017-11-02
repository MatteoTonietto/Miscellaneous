function [TACs,TACs_std,TACs_N] = extract_TACs(dynData,mask,weights)

[nR,nC,nS,nT] = size(dynData); 

if nargin < 3    
    weights = ones(nR,nC,nS);
end

if nargin < 2    
    mask = ones(nR,nC,nS);
end

nlabel = double(max(mask(:)));

TACs      = zeros(nT,nlabel);
TACs_std  = zeros(nT,nlabel);
TACs_N    = zeros(1,nlabel);
for j = 1 : nlabel
    idx       = mask==j;
    TACs_N(j) = sum(idx(:));
    for k = 1 : nT
        tmp = dynData(:,:,:,k);
        TACs(k,j)     = sum((tmp(idx).*weights(idx)))/sum(weights(idx));
        TACs_std(k,j) = sqrt(var(tmp(idx),weights(idx)));
    end
end