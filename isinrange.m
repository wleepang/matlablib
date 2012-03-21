function InRng = isinrange(val, rng)
% test if val is within range specified by rng
if val >= min(rng) && val <= max(rng),
    InRng = 0;
elseif val < min(rng)
    InRng = -1;
elseif val > max(rng)
    InRng = 1;
elseif isnan(val)
    InRng = -1;
end