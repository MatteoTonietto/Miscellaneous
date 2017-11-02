function data2D = conv4Dto2D(dynData,mask)

[nR,nC,nS,nT] = size(dynData); 

if nargin < 2    
    mask = ones(nR,nC,nS);
end

idx = find(mask);

data2D = zeros(nT,length(idx));

for i = 1 : nT
    tmp         = dynData(:,:,:,i);
    data2D(i,:) = tmp(idx);
end