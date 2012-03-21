function val = coerceIntoRange(val, rng)
switch isinrange(val, rng),
    case 0,
        % do nothing value in range
    case -1,
        % value too low
        val = min(rng);
    case 1,
        % value too high
        val = max(rng);
    otherwise,
        % do nothing, unknown condition
end