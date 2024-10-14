clc;
clear all;
close all;

figure;
set(gcf,'unit','normalized','position',[0.1,0.05,0.7,0.55]);
set(gca, 'Position', [0 0 1 1]);


subplot('position', [0.05 + (1-1)*0.245 0.6 0.2 0.35]);
plot_T_sen_subplot('RAIN','Rainfall','mm',1,'a',0,350,0);


subplot('position', [0.05 + (2-1)*0.245 0.6 0.2 0.35]);
plot_T_sen_subplot('TWI','TWI','mm',1,'b',0,350,0);


%subplot('position', [0.05 + (3-1)*0.245 0.6 0.2 0.35]);
%plot_T_sen_subplot('QSNOMELT','\it{I}_{snow}','mm',1,'c',-20, 100,0);

subplot('position', [0.05 + (4-1)*0.245 0.6 0.2 0.35]);
plot_T_sen_subplot('RSNOMELT','\it{f}_{snow}','%',1,'d',-20,110,1);

%% elevation gradient
subplot('position', [0.05 + (1-1)*0.245 0.10 0.2 0.4]);
plot_subfigure_elevation_gradient(1, 'fsnow',0,1,'\it{C}_{snow} (%)','Elevation (m)','e',0,1950,-100,100,'1996PN');

xlim([-100 100])

subplot('position', [0.05 + (2-1)*0.245 0.10 0.2 0.4]);
plot_subfigure_elevation_gradient(2, 'fsnow',1,0,'\it{C}_{snow} (%)','Elevation (m)','f',0,900,-100,100,'1996MA');

xlim([-100 100])
subplot('position', [0.05 + (3-1)*0.245 0.10 0.2 0.4]);
plot_subfigure_elevation_gradient(3, 'fsnow',0,0,'\it{C}_{snow} (%)','Elevation (m)','g',0,2900,-100,100,'2017CA-Jan');

xlim([-100 100])

subplot('position', [0.05 + (4-1)*0.245 0.10 0.2 0.4]);
plot_subfigure_elevation_gradient(4, 'fsnow',0,0,"\it{C}_{snow} (%)",'Elevation (m)','h',0,2900,-100,100,'2017CA-Feb');

xlim([-100 100])

exportgraphics(gcf,'../figure/Figure_3_TWI_temperature_sensitivity.tif','Resolution',300);
close all


