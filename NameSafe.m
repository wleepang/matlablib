function ssafe = NameSafe(s,method)
invalidChars = ['.', ' ', '/', '+', ':'];

switch lower(method),
    case 'camel'
        rexPos = regexp(s, ['[' invalidChars ']']);
        
        % names that need refactoring
        ixBadNames = find(~cellfun(@isempty, rexPos));
        
        for i = 1:length(ixBadNames),
            curName = s{ixBadNames(i)};
            curRexPos = rexPos{ixBadNames(i)};
            
            % lower case the entire string
            curName = lower(curName);
            
            % delete the offending character
            curName(curRexPos) = [];
            
            % uppercase the position immediately following
            curName(curRexPos) = upper(curName(curRexPos));
            
            s{ixBadNames(i)} = curName;
        end
        ssafe = s;
    otherwise
        % default filesafing
        ssafe = FileSafe(s);
end

