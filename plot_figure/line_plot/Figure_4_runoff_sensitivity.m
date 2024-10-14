clc;
clear all;
close all;

figure;
set(gcf,'unit','normalized','position',[0.1,0.05,0.48,0.7]);
set(gca, 'Position', [0 0 1 1]);


% subplot('position', [0.05 + (1-1)*0.245 0.6 0.2 0.35]);
% plot_T_sen_subplot('QOVER','Rainfall','mm',1,'a',0,300,0);


% subplot('position', [0.05 + (2-1)*0.245 0.6 0.2 0.35]);
% plot_T_sen_subplot('QDRAI','TWI','mm',1,'b',0,50,0);


subplot('position', [0.09 + (1-1)*0.48 0.725 0.4 0.25]);
plot_T_sen_subplot_runoff('QRUNOFF','','Runoff (mm)',1,'a',0, 300,0);

subplot('position', [0.09 + (2-1)*0.48 0.725 0.4 0.25]);
plot_T_sen_subplot_runoff('RRUNOFF','','\it{E}_{runoff} (%)',1,'b',0,100,1);


%% elevation gradient
subplot('position', [0.09 + (1-1)*0.48 0.385 0.4 0.28]);
plot_subfigure_elevation_gradient_runoff(1, 'QRUNOFF',0,1,'Runoff (mm)','Elevation (m)','c',0,1950,0,500,'1996PacN');

set(gca,"XLabel",[])

subplot('position', [0.09 + (2-1)*0.48 0.385 0.4 0.28]);
plot_subfigure_elevation_gradient_runoff(2, 'QRUNOFF',1,0,'Runoff (mm)','Elevation (m)','d',0,900,0,200,'1996MidA');
set(gca,"XLabel",[])
subplot('position', [0.09 + (1-1)*0.48 0.065 0.4 0.28]);
plot_subfigure_elevation_gradient_runoff(3, 'QRUNOFF',0,1,'Runoff (mm)','Elevation (m)','e',0,2900,0,500,'2017CA-Jan');


subplot('position', [0.09 + (2-1)*0.48 0.065 0.4 0.28]);
plot_subfigure_elevation_gradient_runoff(4, 'QRUNOFF',0,0,"Runoff (mm)",'Elevation (m)','f',0,2900,0,500,'2017CA-Feb');


exportgraphics(gcf,'../../figure_P/Figure_5_runoff_temperature_sensitivity_r_P.pdf','Resolution',300);
close all


