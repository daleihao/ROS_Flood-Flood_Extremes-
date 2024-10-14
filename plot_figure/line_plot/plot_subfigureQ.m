function plot_subfigureQ(region_i, varibale_name, labelname, unitname)

colors = brewermap(7,'OrRd');
colors = colors(2:end,:);
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

if region_i == 1 || region_i == 4
    filename_str = ['all_data/basin_average_ELM_ROS_2017_' region_name '_FLOOD_Optimal_future_'];
else
    filename_str = ['all_data/basin_average_ELM_ROS_1996_' region_name '_FLOOD_Optimal_future_'];
end



%% plot
hold on
for delta_T = 0:5
    filename_i =  [ filename_str num2str(delta_T) 'K_20240112.mat'];

    load(filename_i, [varibale_name 's']);

    variable = eval([varibale_name 's']) * scale_factor;

    variable = variable';
    variable = variable(:);
    start_day = (filter_days(1)-1) * 24 + 1;
    end_day = (filter_days(2)) * 24 ;
    plot(variable(start_day:end_day),'linewidth',1,'Color',colors(delta_T+1,:));

end

box on
set(gca,'linewidth',1,'fontsize',12);

xlim([0,(end_day-start_day)])

if region_i == 1
    ylabel([ labelname '(' unitname ')'])
end

if varibale_name == "RAIN"
    title(region_name);
end

if varibale_name ~= "QRUNOFF"
    set(gca,'xticklabel',[])
else
    filter_hours = int32(((filter_days(1):filter_days(2)) - 1)*24)';
    set(gca, 'linewidth',1,'fontsize', 15,'xtick',filter_hours - 24*(filter_days(1)-1),'xticklabel',datestr(datetime(2017,1,1, filter_hours, 0, 0), 6));
end
end