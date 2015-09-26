function ds = cell2dataset(X, varargin)
% CELL2DATASET converts a cell array into a dataset array
%   ds = cell2dataset(X)
%   ds = cell2dataset(X, 'VarNames', VN)
%   ds = cell2dataset(X, 'VarNames', VN, 'ObsNames', ON)
%
% Converts a MxN cell array X to a MxN dataset array with M observations
% and N variables.
%
% The cell array X must be arranged in columns of data of the same type.
% If no VarNames are provided it produces VarNames 'Var1', 'Var2', ...
% Otherwise if VarNames VN must be a cell array of strings.
%
% ObsNames may be provided as a cell array of strings ON
%
% See also DATASET, CELLSTR

args.VarNames = {};
args.ObsNames = {};

args = pvargs(args, varargin);

sz = size(X);

ObsNames = args.ObsNames;
VarNames = args.VarNames;
if isempty(VarNames),
    VarNames = arrayfun(@(x)(sprintf('Var%d', x)), 1:sz(2), 'unif', 0);
end

% there is (sortof) a direct way to do this with the constructor for a
% dataset array, but the method is a bit essoteric
varspec = {X, VarNames{:}};
if isempty(ObsNames),
    % no ObsNames
    ds = dataset(varspec);
else
    % ObsNames provided
    ds = dataset(varspec, 'ObsNames', ObsNames);
end
