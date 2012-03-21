function exportfig(hfig, varargin)
% SYNTAX
%   exportfig(hfig)
%   exportfig(hfig, Parameter, Value, ...)
%
% DESCRIPTION
%   Exports figure displays to various file formats
%
% OPTIONS
%   'name'          <string>        [current figure name]
%       name of file (sans extension)
%   'resolution'    <int>           [150]
%       dpi of output (only applicable for image formats)
%   'formats'       <cell>          {'png'}
%       output formats.  valid options are those supported by matlab - e.g.
%       a typical parameter value would be:
%           {'fig', 'pdf', 'png'}
%   'renderer'      <string>        ['painters']
%       default renderer for export engine.
%

% opts = getopts(varargin);
% 
% sName = parseopts('name', opts, get(hfig, 'name'));
% iRes = parseopts('resolution', opts, 150);
% cFormats = parseopts('formats', opts, {'png'});
% sRenderer = parseopts('renderer', opts, 'painters');

opts.name       = get(hfig, 'name');
opts.res        = 150;
opts.formats    = {'png'};
opts.renderer   = 'painters';

opts = pvargs(opts, varargin);

sName           = opts.name;
iRes            = opts.res;
cFormats        = opts.formats;
sRenderer       = opts.renderer;


if min(size(hfig)) == 1 && length(size(hfig)) == 2,
    if iscell(cFormats) && ~isempty(cFormats),
        for i = 1:length(hfig),
            if iscell(sName),
                sCurrName = sName{i};
            else
                sCurrName = sName;
            end;
            for j = 1:length(cFormats),
                if strcmpi(cFormats{j}, 'fig'),
                    saveas(hfig(i), sCurrName, 'fig');
                else
                    print(  ['-f' num2str(hfig(i))], ...
                            ['-' sRenderer], ...
                            ['-r' num2str(iRes)], ...
                            ['-d' cFormats{j}], ...
                            sCurrName ...
                        )
                end
            end
        end
    else
        error('output formats incorrectly specified');
    end
else
    error('figure handle must be a scalar or 1D vector');
end