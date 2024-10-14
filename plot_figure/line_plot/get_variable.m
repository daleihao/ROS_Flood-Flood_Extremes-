function variables = get_variable(region_i, variable_name)

scale_factor = 3600 * 24;
switch region_i
    case 1
        region_name = 'PN';
    case 2
        region_name = 'MA';
    case 3
        region_name = 'CA';
    case 4
        region_name = 'CA';
end

switch region_i
    case 1
        filter_days = [5 9] + 31;
        % filter_days = [24 (12 + 31)]; %6-12
    case 2
        filter_days = [17 20];
    case 3
        filter_days = [7 12];
    case 4
        filter_days = [6 12] + 31; %6-12

end

if region_i == 3 || region_i == 4
    filename_str = ['../all_data_P/basin_average_ELM_ROS_2017_' region_name '_FLOOD_Optimal_future_'];
else
    filename_str = ['../all_data_P/basin_average_ELM_ROS_1996_' region_name '_FLOOD_Optimal_future_'];
end



%% plot
variables = nan(6,1);
for delta_T = 0:5

    filename_i =  [ filename_str num2str(delta_T) 'K_P_after_spinup_20240909.mat'];

    if ~exist(filename_i,'file')
        filename_i =  [ filename_str num2str(delta_T) 'K_P_after_spinup_20240909.mat'];
    end

    load(filename_i, [variable_name 's']);

    filename_i =  [ filename_str num2str(delta_T) 'K_P_after_spinup_20240909_water_budget.mat'];

    load(filename_i, [variable_name 's']);

    switch variable_name
        case 'RAIN'
            variable = RAINs * scale_factor;
        case 'SNOW'
            variable = SNOWs * scale_factor;
        case 'TBOT'
            variable = TBOTs;
        case 'H2OSNO'
            variable = H2OSNOs;
        case 'QRUNOFF'
            variable = QRUNOFFs * scale_factor;
        case 'QH2OSFC'
            variable = QH2OSFCs * scale_factor;
        case 'QSNOMELT'
            variable = QSNOMELTs * scale_factor;
        case 'QTOPSOIL'
            variable = QTOPSOILs * scale_factor;
        case 'QINFL'
            variable = QINFLs * scale_factor;
        case 'QSOIL'
            variable = QSOILs * scale_factor;
        case 'QVEGE'
            variable = QVEGEs * scale_factor;
        case 'QVEGT'
            variable = QVEGTs * scale_factor;
        case 'H2OSFC'
            variable = H2OSFCs;
        case 'SOILICE'
            variable = SOILICEs;
        case 'SOILLIQ'
            variable = SOILLIQs;
        case 'FSAT'
            variable = FSATs;
        case 'TSA'
            variable = TSAs;
        case 'WA'
            variable = WAs;
        case 'QDRIP'
            variable = QDRIPs * scale_factor;
        case 'QINTR'
            variable = QINTRs * scale_factor;
        case 'QDRAI'
            variable = QDRAIs * scale_factor;
        case 'H2OCAN'
            variable = H2OCANs;
    end

    variable = variable';
    variable = variable(:);
    start_day = (filter_days(1) -1) * 24 + 1 + 1;
    end_day = (filter_days(2) ) * 24 + 1;

    if variable_name == "H2OSNO" || variable_name == "H2OSFC" || variable_name == "SOILICE" || variable_name == "SOILLIQ" ...
            || variable_name == "WA" || variable_name == "TSA" || variable_name == "H2OCAN"
        variables(delta_T + 1) = variable(end_day) - variable(start_day);
    elseif variable_name == "FSAT" 
        variables(delta_T + 1) = mean(variable(start_day:end_day));
    else
        variables(delta_T + 1) = sum(variable(start_day:end_day))/24;
    end
end

end