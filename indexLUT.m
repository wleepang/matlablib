function value = indexLUT(lut, key)
% simple hash tabling

ix = strncmp(key, lut(:,1), length(key));
value = lut{ix, 2};
