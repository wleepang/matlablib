function status = xlsDeleteSheet(file, sheet)
% deletes a sheet from an existing microsoft excel workbook

status = false;

[pn, fn, fx] = fileparts(file);

if isempty(pn),
    % calls to the COM server need a fully qualified path
    % get the current directory.
    pn = pwd;
end

file = fullfile(pn, [fn fx]);

xla = actxserver('Excel.Application');
xlwb= xla.Workbooks.Open(file);

% xla.AlertBeforeOverwriting = false;
xla.DisplayAlerts = false;
% xla.Interactive = false;
% xla.ScreenUpdating = false;
xla.EnableSound = false;

sheets = xlwb.Sheets;
nSheets = xlwb.Sheets.Count;

SheetNames = cell(nSheets, 1);
for i=1:nSheets,
    SheetNames{i} = sheets.Item(i).Name;
end

if ischar(sheet) || iscellstr(sheet),
    % delete by name
    ixDelete = find(ismember(SheetNames, sheet));
elseif isnumeric(sheet)
    % delete by index
    ixDelete = sheet;
end

% do the delete operation by name since indices get reset when a delete
% operation happens.

if ~isempty(ixDelete),
    csDelete = SheetNames(ixDelete);
    if length(ixDelete) < nSheets,
        % workbook cannot have no sheets
        for i = 1:length(csDelete),
            sheets.Item(csDelete{i}).Delete;
        end
    end
else
    % no sheets found to delete
    warning('xlsDeleteSheet:NoSheetsToDelete', 'Sheets not found. Nothing to do.');
end

xlwb.Save;
xlwb.Close(false);

xla.DisplayAlerts = true;
xla.Interactive = true;
xla.EnableSound = true;

xla.Quit;

delete(xla);

status = true;
