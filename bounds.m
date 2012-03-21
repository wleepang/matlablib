function [minmax] = bounds(x, varargin)
% returns the lowest and highest values in x
% [minmax] = bounds(x)
% [minmax] = bounds(x, dim)
% if x is a matrix returns on a column basis unless dim is specified
% accounts for nan values

dim = 1;
if nargin > 1
    dim = varargin{1};
end

if length(size(x)) == 2 && any(size(x) == 1),
    % input is a vector, ignore dim argument
    minmax = [nanmin(x) nanmax(x)];
else
    % input is a matrix use dim argument
    minmax = cat(dim, nanmin(x, [], dim), nanmax(x, [], dim));
end