function frames = mid2frames(midtimes)

frames = zeros(length(midtimes),2);

for i = 1 : length(midtimes)
    frames(i,2) = 2*midtimes(i) - frames(i,1);

    if i < length(midtimes)
        frames(i + 1,1) = frames(i,2);
    end
end

if any(diff(frames(:,1))<0) | any(diff(frames(:,2))<0)
    error('mid2frames failed, probably there are some missing data')
end
    