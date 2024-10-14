clc;
clear all;
close all;


region_names = {'PacN','MidA','CA'};
indexlabels = {'a','b','c'};
maxelevations = [3000,1000,3000];
figure;
set(gcf,'unit','normalized','position',[0.1,0.05,0.7,0.3]);
set(gca, 'Position', [0 0 1 1]);

for region_i = 1:3
    indexlabel = indexlabels{region_i  };
    region_name = region_names{region_i};
    maxelevation = maxelevations(region_i);
  
subplot('position', [0.05 + (region_i-1)*0.32 0.2 0.27 0.7]);

[variable_elevs, meanelevation] = get_elev_gradient_variable(region_i,'QRUNOFF');
    elevations = [1:length(variable_elevs)]*25;


    box on
    h = histogram(meanelevation,'Normalization','pdf');
    xlabel('Elevation (m)')
    if(region_i == 1)
    ylabel('Probability density');
    end
    h.FaceColor = 	"k";
    h.EdgeColor = 	"k";
    h.LineWidth = 1;

    xlim([0 maxelevation]);
 YL = get(gca, 'YLim');

text(-(maxelevation)*0.16,YL(2)+(YL(2)-YL(1))*0.05, indexlabel,'fontsize',22,'FontWeight','bold');


    title(region_name);
    set(gca,'LineWidth',1.5,'fontsize',18);
  set(gca,'YLim',YL);
    
end

exportgraphics(gcf,'../../figure_P/Figure_S_elevation_gradient_r_P.pdf','Resolution',300);
close all


