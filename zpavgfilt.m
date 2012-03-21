function tmp = zpavgfilt(win, tmp)
% hack of simple zero-pt avg filter to use in place of filtfilt
% tmp = zpavgfilt(win, tmp)
%
% created since the DSP toolbox at ISB only has 1 available license!
% assumes 2D data input

% pad the ends of the data with the last values to reduce filter end
% effects
tmp = [repmat(tmp(1, :), win, 1); tmp; repmat(tmp(end, :), win, 1)];

% faux zero-phase filter the data to smooth out noise:
% filter, flip, filter, flip ...
tmp = flipud(filter(ones(1, win)/win, 1, flipud(filter(ones(1, win)/win, 1, tmp))));

% tmp = cat(3, filter(ones(1, win)/win, 1, tmp), flipud(filter(ones(1, win)/win, 1, flipud(tmp))));
% tmp = mean(tmp, 3);

% return the data set to its initial size
tmp = tmp(win+1:end-win, :);