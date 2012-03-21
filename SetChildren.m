function SetChildren(hObject, propName, propVal)
% function to recursively set properties from a parent object down

props = get(hObject);

% first set the parent
if any(strcmpi(propName, fieldnames(props))),
    % fprintf('%s: property ''%s'' found\n', props.Tag, propName)
    set(hObject, propName, propVal);
end

% second recurse into the children
if isfield(props, 'Children'),
    if ~isempty(props.Children),
        % fprintf('%s: has %d children\n', props.Tag, length(props.Children))
        for i = 1:length(props.Children),
            % WARNING: RECURSION!!
            SetChildren(props.Children(i), propName, propVal);
        end
    end
end