function [Variable_elevs, meanelevation] = get_elev_gradient_variable(region_i, variable_name)

scale_factor = 3600;

max_elv = 0;
switch region_i
    case 1
        region_name = 'PN';
        max_elv = 2000;
    case 2
        region_name = 'MA';
        max_elv = 1000;
    case 3
        region_name = 'CA';
        max_elv = 3000;
    case 4
        region_name = 'CA';
        max_elv = 3000;
end



if region_i == 3 || region_i == 4
    filename_str = ['../all_data_P/Spatial_ELM_ROS_2017_' region_name '_FLOOD_Optimal_future_'];
    filename_str2 = ['../all_data_P/soil_Spatial_ELM_ROS_2017_' region_name '_FLOOD_Optimal_future_'];

else
    filename_str = ['../all_data_P/Spatial_ELM_ROS_1996_' region_name '_FLOOD_Optimal_future_'];
    filename_str2 = ['../all_data_P/soil_Spatial_ELM_ROS_1996_' region_name '_FLOOD_Optimal_future_'];

end

%% load elevation and masks
load([ region_name '_area_mask.mat']);

if region_i == 3 || region_i == 4
    load(['elevation/' region_name '_2017_TOP_1km.mat']);
else
    load(['elevation/' region_name '_1996_TOP_1km.mat']);

end
meanelevation(~masks) = nan;


elev_bands = max_elv/25;

Variable_elevs = nan(elev_bands,6);
for delta_T = 0:5

    filename_i =  [ filename_str num2str(delta_T) 'K_P_after_spinup_20240909_' num2str(region_i) '.mat'];

  
    load(filename_i, [variable_name 's']);

    filename_2 =  [ filename_str2 num2str(delta_T) 'K_P_after_spinup_20240909_' num2str(region_i) '.mat'];
    load(filename_2);

    variable_spatial = eval([variable_name 's']);


    for elevation_i = 0:25:max_elv

        filters = meanelevation>=(elevation_i) & ...
            meanelevation<(elevation_i+25);
        Variable_elevs(elevation_i/25+1,delta_T+1 ) = mean(variable_spatial(filters),'omitnan');

    end
end

if  variable_name == "QRUNOFF" || variable_name == "QTOPSOIL" || variable_name == "SNOW" || variable_name == "RAIN" || variable_name == "QINFL"
Variable_elevs = Variable_elevs * scale_factor;
end