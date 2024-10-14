clc;
clear all;
close all;

figure;
set(gcf,'unit','normalized','position',[0.1,0.05,0.5,0.5]);
set(gca, 'Position', [0 0 1 1]);


subplot('position', [0.08 0.55  0.4 0.4]);
plot_T_sen_subplot('RAIN','','Rainfall (mm)',0,'a',-50,450,0);
set(gca,'xlabel',[],'XTickLabel',[])

subplot('position', [0.08 + (2-1)*0.49 0.55 0.4 0.4]);
plot_T_sen_subplot('QSNOMELT','','\it{Q}_{snow} (mm)',0,'b',-50, 450,0);


subplot('position', [0.08 0.11   0.4 0.4]);
plot_T_sen_subplot('TWI','','TWI (mm)',1,'c',-50,450,0);
%set(gca,'xlabel',[],'XTickLabel',[])



subplot('position', [0.08+0.49 0.11  0.4 0.4]);
plot_T_sen_subplot('RSNOMELT','','\it{C}_{snow} (%)',1,'d',-20,110,1);



exportgraphics(gcf,'../../figure_P/Figure_3_TWI_temperature_sensitivity_r1_P.pdf','Resolution',300);
close all


