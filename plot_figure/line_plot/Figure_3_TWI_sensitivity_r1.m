clc;
clear all;
close all;

figure;
set(gcf,'unit','normalized','position',[0.1,0.05,0.5,0.7]);
set(gca, 'Position', [0 0 1 1]);


subplot('position', [0.08 0.08 + (4-1)*0.23  0.4 0.22]);
plot_T_sen_subplot('RAIN','','Rainfall (mm)',1,'a',0,350,0);
set(gca,'xlabel',[],'XTickLabel',[])

subplot('position', [0.08 0.08 + (3-1)*0.23  0.4 0.22]);
plot_T_sen_subplot('TWI','','TWI (mm)',1,'b',0,350,0);
set(gca,'xlabel',[],'XTickLabel',[])


%subplot('position', [0.05 + (3-1)*0.245 0.6 0.2 0.35]);
%plot_T_sen_subplot('QSNOMELT','\it{I}_{snow}','mm',1,'c',-20, 100,0);

subplot('position', [0.08 0.08 + (2-1)*0.23  0.4 0.22]);
plot_T_sen_subplot('RSNOMELT','','\it{C}_{snow} (%)',1,'c',-20,110,1);

%% elevation gradient
subplot('position', [0.57 0.08 + (4-1)*0.23 0.4 0.215]);
plot_subfigure_elevation_gradient(1, 'fsnow',1,1,'\it{C}_{snow} (%)','Elevation (m)','d',0,1950,-100,100,'1996PN');
set(gca,'xlabel',[],'XTickLabel',[])


xlim([-100 100])

subplot('position', [0.57 0.08 + (3-1)*0.23 0.4 0.215]);
plot_subfigure_elevation_gradient(2, 'fsnow',1,1,'\it{C}_{snow} (%)','Elevation (m)','e',0,900,-100,100,'1996MA');
set(gca,'xlabel',[],'XTickLabel',[])


xlim([-100 100])
subplot('position', [0.57 0.08 + (2-1)*0.23 0.4 0.215]);
plot_subfigure_elevation_gradient(3, 'fsnow',1,1,'\it{C}_{snow} (%)','Elevation (m)','f',0,2900,-100,100,'2017CA-Jan');
set(gca,'xlabel',[],'XTickLabel',[])
xlim([-100 100])

subplot('position', [0.57 0.08 + (1-1)*0.23 0.4 0.215]);
plot_subfigure_elevation_gradient(4, 'fsnow',1,1,"\it{C}_{snow} (%)",'Elevation (m)','g',0,2900,-100,100,'2017CA-Feb');

xlim([-100 100])

exportgraphics(gcf,'../figure/Figure_3_TWI_temperature_sensitivity_r.tif','Resolution',300);
close all


