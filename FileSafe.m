function s = FileSafe(s)
s = strrep(s, '.', 'p');
s = strrep(s, ' ', '_');
s = strrep(s, '/', '-');
s = strrep(s, '+', '_plus_');
s = strrep(s, ':', '-');