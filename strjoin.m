function s = strjoin(cs, varargin)
% STRJOIN joins strings in a cellstring using a separator
%   s = strjoin(cs)
%   s = strjoin(cs, 'sep', ',')

sep = '';
if nargin > 1,
    sep = varargin{1};
end

s = strcat(cs(1:(end-1)), sep);
s = [s{:}, cs{end}];