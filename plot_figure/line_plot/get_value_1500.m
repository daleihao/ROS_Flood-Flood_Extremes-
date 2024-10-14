region_i = 2;
variableName = 'QRUNOFF';
[variable_elevs, meanelevation] = get_elev_gradient_variable_1500(region_i,variableName);

variable_elevs

dif_variable = (variable_elevs - variable_elevs(:,1))./variable_elevs(:,1)

dif_variable(:,6)*100/5
