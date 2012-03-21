function [molar]=pct2molar(pct, mw)
% [molar]=pct2molar(pct, mw)
%   converts concentrations expressed as percent (w/v and w/w) to mols/L = M

% pct is expressed as g/100mL solution
% g/100mL * 1000mL/L * mol/g = M

molar = pct / 100 * 1000 / mw;