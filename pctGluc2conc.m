function conc = pctGluc2conc(pct, varargin)
% pctCluc2conc: converts pct glucose (w/v h2o) to concentration (molar)

MW = 180.16; % glucose molar mass (g/mol)
conc = pct ./ 180.16 .* 1000;