function C = dlm2cell(file, dlm)
% dlm2cell: reads a delimited text file into a cell array
%   C = dlm2cell(file, dlm)

% pull in the entire file as a single string
% (note on large files, this memory intensive)
fs = fileread(file);

% split the string on newline characters
fl = split(fs, '[\r\n]{1,2}')';

% split each line use the dimensions of first line split to get the width
% of the output array
el = split(fl, dlm);
C = cell(length(fl), length(el{1}));
for i = 1:length(fl),
    C(i,:) = strtrim([el{i}]);
end;

function s = split(s, dlm)
try
    % depending on the version of Matlab, this may or may not work.  For
    % sure doesn't work in v7.0 (R14SP1).
    s = regexp(s, dlm, 'split');
catch
    % this appears to produce equivalent results as above.
    s = regexp(s, ['[^' dlm ']{1,}'], 'match');
end;