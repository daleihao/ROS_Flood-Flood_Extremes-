clc;
clear all;
close all;

figure;
set(gcf,'unit','normalized','position',[0.1,0.05,0.6,0.4]);
set(gca, 'Position', [0 0 1 1]);

panelnumbers = {'a','b','c',...
    'd','e','f',...
    'g','h'};

tmp = 1;
ymaxs = [200 100 400 600; 70 105 105 140];
titles = {'1996PacN','1996MidA','2017CA-Jan','2017CA-Feb'};
for region_i = [1 2 3 4]

% subplot('position', [0.06 + (region_i-1)*0.23 0.81 0.2 0.17]);
% plot_subfigure(region_i,'RAIN', 'Rainfall','mm/day', ['(' panelnumbers{tmp} ')']);
% tmp = tmp + 1;
% 
% 
% subplot('position', [0.06 + (region_i-1)*0.23 0.62 0.2 0.17]);
% plot_subfigure(region_i,'SNOW','Snowfall', 'mm/day', ['(' panelnumbers{tmp} ')']);
% tmp = tmp + 1;
% 
% 
% subplot('position', [0.06 + (region_i-1)*0.23 0.43 0.2 0.17]);
% plot_subfigure(region_i,'TBOT', 'Air temperature','mm/day', ['(' panelnumbers{tmp} ')']);
% tmp = tmp + 1;


subplot('position', [0.06 + (region_i-1)*0.235 0.54 0.2 0.4]);
plot_subfigure(region_i,'H2OSNO', 'SWE', 'mm', [ panelnumbers{tmp} ],ymaxs(1, region_i));

title(titles{region_i})

subplot('position', [0.06 + (region_i-1)*0.235 0.12 0.2 0.4]);
plot_subfigure(region_i,'QRUNOFF','Runoff', 'mm/day', [ panelnumbers{tmp+4} ],ymaxs(2, region_i));
tmp = tmp + 1;

if region_i == 4
  ld = legend('Control','+1K','+2K','+3K','+4K','+5K');
  ld.NumColumns = 2;
end
end

exportgraphics(gcf,'../../figure_P/ROS_figure_future_time_series_r_P.pdf','Resolution',300);
close all