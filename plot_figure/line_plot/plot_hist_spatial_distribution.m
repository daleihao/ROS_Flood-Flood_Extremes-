clc;
clear all;
close all;

figure;
set(gcf,'unit','normalized','position',[0.1,0.05,0.6,0.8]);
set(gca, 'Position', [0 0 1 1]);

panelnumbers = {'a','b','c';...
    'd','e','f';...
    'g','h','i';};

tmp = 1;
for region_i = 1:3

subplot('position', [0.06 + (region_i-1)*0.32 0.81 0.28 0.17]);
plot_spatial_hist_figure(region_i,'H2OSNO', 'SWE','mm', ['(' panelnumbers{tmp} ')']);
tmp = tmp + 1;

subplot('position', [0.06 + (region_i-1)*0.32 0.62 0.28 0.17]);
plot_spatial_hist_figure(region_i,'QRUNOFF','Runoff', 'mm/day', ['(' panelnumbers{tmp} ')']);
tmp = tmp + 1;


subplot('position', [0.06 + (region_i-1)*0.32 0.43 0.28 0.17]);
plot_spatial_hist_figure(region_i,'QRUNOFF', 'Snowmelt','mm/day', ['(' panelnumbers{tmp} ')']);
tmp = tmp + 1;

end

exportgraphics(gcf,'../figure/ROS_figure_hist_spatial_pattern.tif','Resolution',300);
close all