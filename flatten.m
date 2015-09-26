function data = flatten(data)
% FLATTEN flattens elements of a nested cell array
%
% C1 = flatten({{1 {2 3}} {4 5} 6})
% C2 = flatten({{'a' {'b','c'}} {'d' 'e'} 'f'})
% 
% Outputs:
% C1 = 
%     [1]    [2]    [3]    [4]    [5]    [6]
% C2 = 
%     'a'    'b'    'c'    'd'    'e'    'f'
  try
      data = cellfun(@flatten,data,'un',0);
      if any(cellfun(@iscell,data))
          data = [data{:}];
      end
  catch
      % a non-cell node, so simply return node data as-is
  end