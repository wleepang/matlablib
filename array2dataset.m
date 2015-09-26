function D = array2dataset(A)
% converts a numeric array to a dataset array
% 
% the numeric array A cannot have more than 2 dimensions

if length(size(A)) > 2,
    error('Array input has more than 2 dimensions');
end

D = dataset();
for i = 1:size(A, 2),
    D = horzcat(D, dataset(A(:,i), 'VarNames', sprintf('Var%d', i)));
end
