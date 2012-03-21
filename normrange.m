function x = normrange(x, varargin)
% normalize values of x to a range of data
%
% X = normrange(X)
% X = normrange(X, RNG)
%   normalizes the vector X over its range of data or the range specified
%   in RNG as [min max].  Values that are NaN are ignored.

% to be implemented
% X = normrange(X, [], DIM)
%   normalize the matrix X over its data range along the dimension dim
%
% X = normrange(X, RNG, DIM)
%   normalize the matrix X over the range RNG along the dimension DIM

rng = [];
if nargin > 1
    rng = varargin{1};
end

dim = 1;
if nargin > 2
    dim = varargin{2};
end

if length(size(x)) == 2 && any(size(x) == 1),
    % input is a vector, ignore dim argument
    if isempty(rng),
        xmin = nanmin(x);
        xrng = range(x);
    else
        xmin = min(rng);
        xrng = range(rng);
    end
else
%     % input is a matrix, use dim argument
%     if isempty(rng),
%         xmin = nanmin(x, [], dim);
%         xrng = range(x, dim);
%     end
% this scenario needs more thought
end

x = (x - xmin) ./ xrng;