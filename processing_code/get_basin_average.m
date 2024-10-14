function variable_ave=get_basin_average(fileName, variableName, masks)

variable  = ncread(fileName, variableName);


%% average all the layers
if  ndims(variable) == 4
    if variableName == "SOILLIQ" || variableName == "SOILICE"
        variable = squeeze(sum(variable, 3));
    else
        variable = squeeze(mean(variable, 3));
    end
end

variable_ave = nan(24, 1);
for hour_i = 1:24

    variable_tmp = squeeze(variable(:,:,hour_i));

    variable_tmp = flipud(variable_tmp');
    variable_tmp(~masks) = nan;

    variable_ave(hour_i) = squeeze(mean(variable_tmp,[1 2],'omitnan'));
end


