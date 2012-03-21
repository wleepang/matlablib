function props = GetRecursive(hObject)
% function to recursively get properties from a parent object down through
% its progeny

props = get(hObject);

% recurse into children
if isfield(props, 'Children'),
    if ~isempty(props.Children),
        % fprintf('%s: has %d children\n', props.Tag, length(props.Children))
        Children = cell(length(props.Children), 1);
        for i = 1:length(props.Children),
            % WARNING: RECURSION!!
            Children{i} = GetRecursive(props.Children(i));
        end
        props.Children = Children;
    end
end