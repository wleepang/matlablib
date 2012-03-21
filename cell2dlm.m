function cell2dlm(fh, cs, varargin)
% cell2dlm Outputs a cell array to a delimited text file
%   cell2dlm(FILEHANDLE, CELLARRAY)
%   Writes to a text file specified by FILEHANDLE using '\t' as a delimiter
%
%   cell2dlm(FILEHANDLE, CELLARRAY, DELIMITER)
%   Writes a text file of CELLARRAY using DELIMITER

if nargin > 2,
    dlm = varargin{1};
else
    dlm = '\t';
end

if isempty(fh) || fh < 1, fh = 1; end;

for i = 1:size(cs, 1),
    for j = 1:size(cs, 2),
        switch(class(cs{i, j})),
            case 'char',
                fprintf(fh, '%s', cs{i,j});
            case {'int', 'single', 'double'},
                if numel(cs{i,j}) > 1,
                    fprintf(fh, '%f', cs{i,j}(1));
                    fprintf(fh, ',%f', cs{i,j}(2:end));
                else
                    fprintf(fh, '%f', cs{i,j});
                end
            case 'logical'
                if numel(cs{i,j}) > 1,
                    fprintf(fh, '%d', cs{i,j}(1));
                    fprintf(fh, ',%d', cs{i,j}(2:end));
                else
                    fprintf(fh, '%d', cs{i,j});
                end
            otherwise,
                error('Unsupported class ''%s'' element (%d,%d)', class(cs{i, j}), i, j);
        end;
        if j < size(cs, 2), fprintf(fh, dlm); end;
    end;
    fprintf(fh, '\n');
end;