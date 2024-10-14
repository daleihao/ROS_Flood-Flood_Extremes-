clc;
clear all;
close all;

figure;
set(gcf,'unit','normalized','position',[0.1,0.05,0.7,0.9]);
set(gca, 'Position', [0 0 1 1]);

%% TBOT
ybottom = 0.83;
variableName = 'TBOT';
variableLabel = 'Air temperature (K)';
subplot('position', [0.055 + (1-1)*0.243 ybottom 0.2 0.13]);
plot_subfigure_elevation_gradient_variable(1, variableName,0,1,variableLabel,'Elevation (m)','a',0,1950,270,290,'1996PN');
hold on
plot([273.15 273.15], [0 3000],'--k','LineWidth',1.5)

subplot('position', [0.055 + (2-1)*0.24  ybottom 0.2 0.13]);
plot_subfigure_elevation_gradient_variable(2, variableName,0,0,variableLabel,'Elevation (m)','b',0,900,270,290,'1996MA');
hold on
plot([273.15 273.15], [0 3000],'--k','LineWidth',1.5)

subplot('position', [0.055 + (3-1)*0.24  ybottom 0.2 0.13]);
plot_subfigure_elevation_gradient_variable(3, variableName,0,0,variableLabel,'Elevation (m)','c',0,2900,270,290,'2017CA-Jan');

hold on
plot([273.15 273.15], [0 3000],'--k','LineWidth',1.5)

subplot('position', [0.055 + (4-1)*0.24  ybottom 0.2 0.13]);
plot_subfigure_elevation_gradient_variable(4, variableName,0,0,variableLabel,'Elevation (m)','d',0,2900,270,290,'2017CA-Feb');
hold on
plot([273.15 273.15], [0 3000],'--k','LineWidth',1.5)
%% TBOT
ybottom = 0.635;
variableName = 'H2OSNO';
variableLabel = 'Initial SWE (mm)';

subplot('position', [0.055 + (1-1)*0.24  ybottom 0.2 0.13]);
plot_subfigure_elevation_gradient_variable(1, variableName,0,1,variableLabel,'Elevation (m)','e',0,1950,0,1000,'1996PN');

subplot('position', [0.055 + (2-1)*0.24  ybottom 0.2 0.13]);
plot_subfigure_elevation_gradient_variable(2, variableName,0,0,variableLabel,'Elevation (m)','f',0,900,0,200,'1996MA');

subplot('position', [0.055 + (3-1)*0.24  ybottom 0.2 0.13]);
plot_subfigure_elevation_gradient_variable(3, variableName,0,0,variableLabel,'Elevation (m)','g',0,2900,0,1000,'2017CA-Jan');


subplot('position', [0.055 + (4-1)*0.24  ybottom 0.2 0.13]);
plot_subfigure_elevation_gradient_variable(4, variableName,0,0,variableLabel,'Elevation (m)','h',0,2900,0,2000,'2017CA-Feb');


%% TBOT
ybottom = 0.44;
variableName = 'RAIN';
variableLabel = 'Rainfall (mm)';

subplot('position', [0.055 + (1-1)*0.24  ybottom 0.2 0.13]);
plot_subfigure_elevation_gradient_variable(1, variableName,0,1,variableLabel,'Elevation (m)','i',0,1950,0,600,'1996PN');

subplot('position', [0.055 + (2-1)*0.24  ybottom 0.2 0.13]);
plot_subfigure_elevation_gradient_variable(2, variableName,0,0,variableLabel,'Elevation (m)','j',0,900,0,400,'1996MA');

subplot('position', [0.055 + (3-1)*0.24  ybottom 0.2 0.13]);
plot_subfigure_elevation_gradient_variable(3, variableName,0,0,variableLabel,'Elevation (m)','k',0,2900,0,600,'2017CA-Jan');


subplot('position', [0.055 + (4-1)*0.24  ybottom 0.2 0.13]);
plot_subfigure_elevation_gradient_variable(4, variableName,0,0,variableLabel,'Elevation (m)','l',0,2900,0,600,'2017CA-Feb');

%% elevation gradient
ybottom = 0.245;
variableName = 'SNOW';
variableLabel = 'Snowfall (mm)';

subplot('position', [0.055 + (1-1)*0.24  ybottom 0.2 0.13]);
plot_subfigure_elevation_gradient_variable(1, variableName,0,1,variableLabel,'Elevation (m)','m',0,1950,0,600,'1996PN');

subplot('position', [0.055 + (2-1)*0.24  ybottom 0.2 0.13]);
plot_subfigure_elevation_gradient_variable(2, variableName,0,0,variableLabel,'Elevation (m)','n',0,900,0,400,'1996MA');

subplot('position', [0.055 + (3-1)*0.24  ybottom 0.2 0.13]);
plot_subfigure_elevation_gradient_variable(3, variableName,0,0,variableLabel,'Elevation (m)','o',0,2900,0,600,'2017CA-Jan');


subplot('position', [0.055 + (4-1)*0.24  ybottom 0.2 0.13]);
plot_subfigure_elevation_gradient_variable(4, variableName,0,0,variableLabel,'Elevation (m)','p',0,2900,0,600,'2017CA-Feb');


%% elevation gradient
ybottom = 0.05;
variableName = 'QTOPSOIL';
variableLabel = 'TWI (mm)';

subplot('position', [0.055 + (1-1)*0.24 ybottom 0.2 0.13]);
plot_subfigure_elevation_gradient_variable(1, variableName,0,1,variableLabel,'Elevation (m)','q',0,1950,0,600,'1996PN');

subplot('position', [0.055 + (2-1)*0.24 ybottom 0.2 0.13]);
plot_subfigure_elevation_gradient_variable(2, variableName,0,0,variableLabel,'Elevation (m)','r',0,900,0,400,'1996MA');

subplot('position', [0.055 + (3-1)*0.24 ybottom 0.2 0.13]);
plot_subfigure_elevation_gradient_variable(3, variableName,0,0,variableLabel,'Elevation (m)','s',0,2900,0,600,'2017CA-Jan');


subplot('position', [0.055 + (4-1)*0.24 ybottom 0.2 0.13]);
plot_subfigure_elevation_gradient_variable(4, variableName,0,0,variableLabel,'Elevation (m)','t',0,2900,0,600,'2017CA-Feb');


exportgraphics(gcf,'../figure/Figure_S_variables_elevation_gradient.pdf','Resolution',300);
close all


