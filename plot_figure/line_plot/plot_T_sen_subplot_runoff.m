function plot_T_sen_subplot_runoff(variable_name, titlename, unitname,isxtick, labelname,ymin,ymax,islegend)

colors = brewermap(4,'Set2');
hold on
plot([0 7],[0 0],'k--','linewidth',1.5)

ps = [];
for region_i = [1 2 3 4]
    hold on

    if variable_name == "TWI"
        Qtopsoils = get_variable(region_i,'QTOPSOIL');
        variable = Qtopsoils;
    elseif variable_name == "RRUNOFF"
        Qtopsoils = get_variable(region_i,'QTOPSOIL');
        Qrunoffs = get_variable(region_i,'QRUNOFF');
        variable = Qrunoffs./Qtopsoils * 100;
    elseif variable_name == "QSNOMELT"
        Qtopsoils = get_variable(region_i,'QTOPSOIL');
        Rains = get_variable(region_i,'RAIN');
        variable = Qtopsoils - Rains;
  
    elseif variable_name == "RSNOMELT"
        Rains = get_variable(region_i,'RAIN');
        Qtopsoils = get_variable(region_i,'QTOPSOIL');
        variable = (Qtopsoils - Rains) ./ Qtopsoils * 100;
    elseif variable_name == "QDRAI"
        QDRAIs = get_variable(region_i,'QDRAI');
        variable = QDRAIs;
        elseif variable_name == "QOVER"
        Qrunoffs = get_variable(region_i,'QRUNOFF');
        QDRAIs = get_variable(region_i,'QDRAI');
        variable = Qrunoffs - QDRAIs;
    else 
        variable = get_variable(region_i,variable_name);

%         deltaSWE = get_variable(region_i,'H2OSNO');
%         
%         variable = deltaSWE ./ (deltaSWE + Rains/24) * 100;
%         variable = deltaSWE ./ (Rains/24) * 100;
    end
  pi =  plot(variable,'o-','LineWidth',2,'MarkerFaceColor','w','MarkerEdgeColor',colors(region_i,:),'MarkerSize',10,'color',colors(region_i,:));
ps = [ps pi];
end
box on
xlim([0.5 6.5])
ylim([ymin ymax])
title(titlename)
ylabel(unitname)

if islegend
    legend(ps,{'1996PacN','1996MidA','2017CA-Jan','2017CA-Feb'},'location','southwest');
end
YL = get(gca, 'YLim');

text(0.6,YL(2) - (YL(2) - YL(1))*0.05, labelname,'fontsize',18,'FontWeight','bold');
set(gca, 'fontsize', 16, ...
    'LineWidth', 1, 'xtick', [1:6],'XTickLabel', {'Control', '+1K', '+2K', '+3K', '+4K', '+5K'});

if ~isxtick
  set(gca, 'xticklabel',[])
end