clc;
clear all;
close all;

figure;
set(gcf,'unit','normalized','position',[0.1,0.05,0.7,0.5]);
set(gca, 'Position', [0 0 1 1]);


subplot('position', [0.05 + (1-1)*0.24 0.55 0.2 0.41]);
plot_T_sen_subplot('QINTR','Rainfall','mm/day',0,'(a)',0,100,1);


subplot('position', [0.05 + (2-1)*0.24 0.55 0.2 0.41]);
plot_T_sen_subplot('QDRIP','Snowfall','mm/day',0,'(b)',0,100,1);

legend('CA-Feb','PN','MA','CA-Jan');
subplot('position', [0.05 + (3-1)*0.24 0.55 0.2 0.41]);
plot_T_sen_subplot('H2OCAN','Snowmelt','mm/day',0,'(c)',0,100,1);

subplot('position', [0.05 + (4-1)*0.24 0.55 0.2 0.41]);
plot_T_sen_subplot('TWI','TWI','mm/day',0,'(d)');

subplot('position', [0.05 + (1-1)*0.24 0.10 0.2 0.41]);
plot_T_sen_subplot('RSNOMELT','Snowmelt contribution','%',1,'(e)');

subplot('position', [0.05 + (2-1)*0.24 0.10 0.2 0.41]);
plot_T_sen_subplot('QRUNOFF','Runoff','mm/day',1,'(f)');
legend('CA-Feb','PN','MA','CA-Jan');

subplot('position', [0.05 + (3-1)*0.24 0.10 0.2 0.41]);
plot_T_sen_subplot('QINFL','Infiltration','mm/day',1,'(g)');

subplot('position', [0.05 + (4-1)*0.24 0.10 0.2 0.41]);
plot_T_sen_subplot('RRUNOFF','Runoff efficiency','%',1,'(h)');


deswexportgraphics(gcf,'../figure/ROS_temperature_sensitivity.tif','Resolution',300);
close all


