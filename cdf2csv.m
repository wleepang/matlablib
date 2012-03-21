function cdf2csv(filename, varargin)

% read ADNI/netCDF files of MS data
cdf = mzcdfread(filename);
[pks t] = mzcdf2peaks(cdf);

% compile a table of time, mass, intensity
out = zeros(size(cell2mat(pks), 1), 3);
k = 1;
for i=1:numel(pks),
    m = size(pks{i}, 1);
    
    x = repmat(t(i)/60, m, 1);
    
    out(k:(k+m-1), :) = [x, pks{i}];
    
    k = k + m;
end;

% output csv file having the same name as the cdf, just different extension
[path fname ext] = fileparts(filename);

if nargin > 1,
    csvfile = varargin{1};
else
    if isempty(path)
        csvfile = [fname '.csv'];
    else
        csvfile = [path filesep fname '.csv'];
    end
    
end

% csvwrite(csvfile, out, 7, 0);

% output a header
fid = fopen(csvfile, 'r+');
fseek(fid, 0, 'bof');
fprintf(fid, 'Time,Mass,Abundance\r\n');
fclose(fid);

% output data
dlmwrite(csvfile, out, '-append');