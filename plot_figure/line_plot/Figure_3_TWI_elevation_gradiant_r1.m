clc;
clear all;
close all;

figure;
set(gcf,'unit','normalized','position',[0.1,0.05,0.3,0.7]);
set(gca, 'Position', [0 0 1 1]);

%% elevation gradient
subplot('position', [0.13 0.08 + (4-1)*0.23 0.83 0.215]);
plot_subfigure_elevation_gradient(1, 'fsnow',1,1,'\it{C}_{snow} (%)','Elevation (m)','a',0,1950,-100,100,'1996PacN');
set(gca,'xlabel',[],'XTickLabel',[])


xlim([-100 100])

subplot('position', [0.13 0.08 + (3-1)*0.23 0.83 0.215]);
plot_subfigure_elevation_gradient(2, 'fsnow',0,1,'\it{C}_{snow} (%)','Elevation (m)','b',0,900,-100,100,'1996MidA');
set(gca,'xlabel',[],'XTickLabel',[])


xlim([-100 100])
subplot('position', [0.13 0.08 + (2-1)*0.23 0.83 0.215]);
plot_subfigure_elevation_gradient(3, 'fsnow',0,1,'\it{C}_{snow} (%)','Elevation (m)','c',0,2900,-100,100,'2017CA-Jan');
set(gca,'xlabel',[],'XTickLabel',[])
xlim([-100 100])

subplot('position', [0.13 0.08 + (1-1)*0.23 0.83 0.215]);
plot_subfigure_elevation_gradient(4, 'fsnow',0,1,"\it{C}_{snow} (%)",'Elevation (m)','d',0,2900,-100,100,'2017CA-Feb');

xlim([-100 100])

exportgraphics(gcf,'../figure/Figure_S_Csnow_elevation_gradiant_r.tif','Resolution',300);
close all


