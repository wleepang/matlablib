function b = isnancell(c, varargin)
% isnancell - checks if contents in a cell are NaN
b = cellfun(@(e)(all(isnan(e))), c, varargin{:});