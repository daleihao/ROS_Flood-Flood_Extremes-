function plot_spatial_hist_figure(region_i, varibale_name, labelname, unitname, numbername)

scale_factor = 3600 * 24;
switch region_i
    case 1
        region_name = 'CA';
    case 2
        region_name = 'PN';
    case 3
        region_name = 'MA';
    case 4
        region_name = 'CA';
end

switch region_i
    case 1
        filter_days = [5 13] + 31; %6-12
    case 2
        filter_days = [4 10] + 31;
    case 3
        filter_days = [17 23];
    case 4
        filter_days = [6 13];
end

%filter_days = [1 58];

load([region_name '_area_mask.mat']);

if region_i == 1 || region_i == 4
    filename_str = ['all_data/Spatial_ELM_ROS_2017_' region_name '_FLOOD_Optimal_future_'];
else
    filename_str = ['all_data/Spatial_ELM_ROS_1996_' region_name '_FLOOD_Optimal_future_'];
end



%% plot
delta_T = 0;
filename_i =  [ filename_str num2str(delta_T) 'K_20240112_' num2str(region_i) '.mat'];

load(filename_i, [varibale_name 's']);

switch varibale_name
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
end

if varibale_name == "QRUNOFF"
 variable = mean(variable, 3);
end

if varibale_name == "H2OSNO"
 variable = squeeze(variable(:,:,1));
end

variable = flipud(variable');
variable(~masks) = nan;
colormap jet
imagesc(variable);


end