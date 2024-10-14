function plot_subfigure_elevation_gradient_variable(region_i, variableName,islegend,isylabel,xlabeltext,ylabeltext,indexlabel,ymin,ymax,xmin,xmax,event_name)

hold on
plot([0 0],[0, 3000],'k--','LineWidth',2)

if variableName == "fsnow"
[variable_elevs1, meanelevation] = get_elev_gradient_variable(region_i,'QTOPSOIL');
[variable_elevs2, meanelevation] = get_elev_gradient_variable(region_i,'RAIN');
variable_elevs = (variable_elevs1 - variable_elevs2)./variable_elevs1 * 100;
elseif variableName == "QSNOW"
[variable_elevs1, meanelevation] = get_elev_gradient_variable(region_i,'QTOPSOIL');
[variable_elevs2, meanelevation] = get_elev_gradient_variable(region_i,'RAIN');
variable_elevs = (variable_elevs1 - variable_elevs2);
else
[variable_elevs, meanelevation] = get_elev_gradient_variable(region_i,variableName);
end
elevations = [1:length(variable_elevs)]*25;

colors = brewermap(7,'OrRd');
colors = colors(2:end,:);



hold on
p1 = plot(variable_elevs(:,1),elevations,'Color',colors(1,:),'LineWidth',2);
p2 = plot(variable_elevs(:,2),elevations,'Color',colors(2,:),'LineWidth',2);
p3 = plot(variable_elevs(:,3),elevations,'Color',colors(3,:),'LineWidth',2);
p4 = plot(variable_elevs(:,4),elevations,'Color',colors(4,:),'LineWidth',2);
p5 = plot(variable_elevs(:,5),elevations,'Color',colors(5,:),'LineWidth',2);
p6 = plot(variable_elevs(:,6),elevations,'Color',colors(6,:),'LineWidth',2);

if islegend
ld = legend([p1 p2 p3 p4 p5 p6],{'Control', '+1K', '+2K', '+3K', '+4K', '+5K'},'location','east')
  ld.NumColumns = 2;
end
xlabel(xlabeltext);
if isylabel
ylabel(ylabeltext);
end

ylim([ymin ymax])
xlim([xmin xmax])

YL = get(gca, 'YLim');

text(xmax-(xmax-xmin)/14,YL(2) - (YL(2) - YL(1))*0.05, indexlabel,'fontsize',18,'FontWeight','bold');
if variableName == "TBOT"
title(event_name,'fontsize',16,'FontWeight','bold');
%else
%text(xmax-(xmax-xmin)/2.5,YL(1) + (YL(2) - YL(1))*0.05, event_name,'fontsize',16,'FontWeight','bold');
end
box on
set(gca,'linewidth',1.5,'fontsize', 16)

% axes('Position',[.65 .2 .2 .2])
% box on
% h = histogram(meanelevation,'Normalization','pdf')
% xlabel('Elevation (m)')
% ylabel('Probability density');
% h.FaceColor = 	"k";
% h.EdgeColor = 	"k";
% h.LineWidth = 1;
