function cell2tsv(fh, cs)
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
            otherwise,
                error('Unsupported class ''%s'' element (%d,%d)', class(cs{i, j}), i, j);
        end;
        if j < size(cs, 2), fprintf(fh, '\t'); end;
    end;
    fprintf(fh, '\n');
end;