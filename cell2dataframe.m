function [DF] = cell2dataframe(CellIn)
% Cell2DataFrame: produces a data.frame like object (like in R) from a cell array
% the cell array must be defined as follows:
%   first row is column names
%   rest of cell array is data, can be of mixed type
%   optional: second row is type descriptor
%       char
%       numeric
%       mixed (returns cell array)

csColNames = NameSafe(CellIn(1,:), 'camel');
if ~iscellstr(csColNames),
    error('First row of cell array must be a cell array of strings with column names');
    return
end

dfData = CellIn(2:end,:);

DF = cell2struct(dfData, csColNames, 2);