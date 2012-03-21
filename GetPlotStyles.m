function cStyles = GetPlotStyles(varargin)
args.order = {'lines','marks','colors'};
args.marks = {'o','s','d','^','v','>','<','p','h','.','*','+','x'};
args.lines = {'-','--',':','-.'};
args.colors= {'k', 'b','g','r','m','c','y'};

args = pvargs(args, varargin);

PermOrder = args.order;
PermOrder = lower(PermOrder);
PermOrder = [PermOrder{1}(1), ',', PermOrder{2}(1), ',', PermOrder{3}(1)];

% Possible Combinations
% mlc (default)
% lmc
% lcm
% mcl
% cml
% clm

m = args.marks;
l = args.lines;
c = args.colors;

cStyles = cell(numel(m)*numel(l)*numel(c), 4);
p = eval(['{' PermOrder '}']);

n = 1;
for i = 1:length(p{1}),
    for j = 1:length(p{2}),
        for k = 1:length(p{3}),
            cStyles{n, 1} = sprintf('%s%s%s', p{1}{i}, p{2}{j}, p{3}{k});
            cStyles(n, 2:end) = {p{1}{i}, p{2}{j}, p{3}{k}};
            n = n + 1;
        end;
    end;
end;