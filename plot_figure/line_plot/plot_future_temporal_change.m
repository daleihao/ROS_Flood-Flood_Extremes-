clc;
clear all;
close all;

figure;
set(gcf,'unit','normalized','position',[0.1,0.05,0.6,0.8]);
set(gca, 'Position', [0 0 1 1]);

panelnumbers = {'a','b','c';...
    'd','e','f';...
    'g','h','i';...
    'j','k','l';...
    'm','n','o'; ...
    'a','b','c';...
    'd','e','f';...
    'g','h','i';...
    'j','k','l';...
    'm','n','o'};

tmp = 1;
for region_i = [1 2 3 4]

subplot('position', [0.06 + (region_i-1)*0.23 0.81 0.2 0.17]);
plot_subfigure(region_i,'RAIN', 'Rainfall','mm/day', ['(' panelnumbers{tmp} ')']);
tmp = tmp + 1;


subplot('position', [0.06 + (region_i-1)*0.23 0.62 0.2 0.17]);
plot_subfigure(region_i,'SNOW','Snowfall', 'mm/day', ['(' panelnumbers{tmp} ')']);
tmp = tmp + 1;


subplot('position', [0.06 + (region_i-1)*0.23 0.43 0.2 0.17]);
plot_subfigure(region_i,'TBOT', 'Air temperature','mm/day', ['(' panelnumbers{tmp} ')']);
tmp = tmp + 1;


subplot('position', [0.06 + (region_i-1)*0.23 0.24 0.2 0.17]);
plot_subfigure(region_i,'H2OSNO', 'SWE', 'mm/day', ['(' panelnumbers{tmp} ')']);
tmp = tmp + 1;



subplot('position', [0.06 + (region_i-1)*0.23 0.05 0.2 0.17]);
plot_subfigure(region_i,'QRUNOFF','Runoff', 'mm/day', ['(' panelnumbers{tmp} ')']);
tmp = tmp + 1;

if region_i == 3
    legend('Control','+1K','+2K','+3K','+4K','+5K');
end
end

exportgraphics(gcf,'../figure/ROS_figure_future_time_series.tif','Resolution',300);
close all