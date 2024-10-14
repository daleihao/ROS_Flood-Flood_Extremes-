clc;
clear all;
close all;

variable_name = 'QRUNOFF';
colors = brewermap(3,'Set2');

figure;
set(gcf,'unit','normalized','position',[0.1,0.05,0.55,0.3]);
set(gca, 'Position', [0 0 1 1]);

panelnumbers = {'a','b','c',...
    'd'};

titles = {'1996PacN','1996MidA','2017CA-Jan','2017CA-Feb'};

for region_i = [1 2 3 4]

    switch region_i
        case 1
            filter_days = [4 10] + 31; %5-9
        case 2
            filter_days = [16 21]; %% 17-20
        case 3
            filter_days = [6 13]; %% 7 12
        case 4
            filter_days = [5 13] + 31; %6-12
    end

subplot('position', [0.08 + (region_i-1)*0.23 0.15 0.2 0.75]);

    hold on
    variables = get_hourly_variable(region_i,'RAIN');
    peak_times = nan(6,1);
    for deltaT = 0:5
        variable_i = squeeze(variables(deltaT+1,:));
        peak_times(deltaT+1) = find(variable_i == max(variable_i(:)),1);
    end

    pi =  plot(peak_times,[0:5],'o-','LineWidth',2,'MarkerFaceColor','w','MarkerEdgeColor',colors(1,:),'MarkerSize',10,'color',colors(1,:));

    variables = get_hourly_variable(region_i,'QTOPSOIL');
    peak_times = nan(6,1);
    for deltaT = 0:5
        variable_i = squeeze(variables(deltaT+1,:));
        peak_times(deltaT+1) = find(variable_i == max(variable_i(:)));
    end

    pi =  plot(peak_times,[0:5],'o-','LineWidth',2,'MarkerFaceColor','w','MarkerEdgeColor',colors(2,:),'MarkerSize',10,'color',colors(2,:));


    variables = get_hourly_variable(region_i,'QRUNOFF');
    peak_times = nan(6,1);
    for deltaT = 0:5
        variable_i = squeeze(variables(deltaT+1,:));
        peak_times(deltaT+1) = find(variable_i == max(variable_i(:)));
    end

    pi =  plot(peak_times,[0:5],'o-','LineWidth',2,'MarkerFaceColor','w','MarkerEdgeColor',colors(3,:),'MarkerSize',10,'color',colors(3,:));

    variables = get_hourly_variable(region_i,'QRUNOFF');

    if(region_i == 3)
        legend('Rainfall','TWI','Runoff');
    end

    title(titles{region_i})
    box on

    filter_hours = int32(((filter_days(1):filter_days(2)) - 1)*24)';
    
    xlim([1 length(variables)]);
     ylim([0 5])
   
    set(gca, 'linewidth',1,'fontsize', 16,'xtick',filter_hours - 24*(filter_days(1)-1),'xticklabel',datestr(datetime(2017,1,1, filter_hours, 0, 0), 6));
    if region_i == 1 
    set(gca, 'ytick',0:5,'yticklabel',{'Control','+1K','+2K','+3K','+4K','+5K'});
    else
    set(gca,'yticklabel',[]);
    end

     XL = get(gca, 'XLim');

    text(XL(1)-(XL(2)-XL(1))*0.1,5.4, panelnumbers{region_i},'fontsize',22,'FontWeight','bold');

end

exportgraphics(gcf,'../../figure_P/Figure_S_peaking_timing_r_P.pdf','Resolution',300);
close all
