function plot_global_map(region_i,lats, lons, sw_total, min_clr, max_clr, title_text, isxticklabel, isyticklabel,num_label)
axis equal

if region_i == 1
    m_proj('miller','lat',[43.2 46],'lon',[-124 -121.4]); % robinson Mollweide

elseif region_i == 2
    m_proj('miller','lat',[39.4  43],'lon',[-79 -74.5]); % robinson Mollweide

elseif region_i >= 3
    m_proj('miller','lat',[38.5 40.6],'lon',[-121.8 -119.8]); % robinson Mollweide
end
%m_coast('color','k','linewidth',1);
hold on


if isyticklabel && isxticklabel
    m_grid('tickdir','out','linestyle','none','backcolor',[.9 .99 1], ...
        'fontsize',10,'tickstyle','dd','xtick',4,'ytick',4);
elseif isyticklabel && ~isxticklabel
    m_grid('tickdir','out','linestyle','none','backcolor',[.9 .99 1], 'xticklabels',[], ...
        'fontsize',10,'tickstyle','dd','xtick',4,'ytick',4);
elseif ~isyticklabel && isxticklabel
    m_grid('tickdir','out','linestyle','none','backcolor',[.9 .99 1], 'yticklabels',[], ...
        'fontsize',10,'tickstyle','dd','xtick',4,'ytick',4);
else
    m_grid('tickdir','out','linestyle','none','backcolor',[.9 .99 1], 'xticklabels',[], 'yticklabels',[], ...
        'fontsize',10,'tickstyle','dd','xtick',4,'ytick',4);
end


%%
% load('elevations_TP.mat');
% sw_total(elevations<=1500 | isnan(elevations)) = nan;

m_pcolor(lons,lats,sw_total);

if region_i == 1


    filename = 'HUC06/HUC06';
    gages_bounary = m_shaperead(filename);

    tmp = gages_bounary.ncst;
    for k=149:149%:length(tmp)
        tmp_2 = tmp{k};
        basin_plot = m_line(tmp_2(:,1),tmp_2(:,2),'color','k','linewidth',1);
        %alpha(gage_plot, 0.5)
    end

elseif region_i == 2

    filename = 'HUC06/HUC06';
    gages_bounary = m_shaperead(filename);
    tmp = gages_bounary.ncst;
    for k=[326  ]%:length(tmp)
        tmp_2 = tmp{k};
        basin_plot = m_line(tmp_2(:,1),tmp_2(:,2),'color','k','linewidth',1);
        Willamettte_Basin1 = [ tmp_2];
    end

    for k=[ 340 ]%:length(tmp)
        tmp_2 = tmp{k};
        basin_plot = m_line(tmp_2(:,1),tmp_2(:,2),'color','k','linewidth',1);
        Willamettte_Basin2 = [ tmp_2];
    end

    for k=[  342]%:length(tmp)
        tmp_2 = tmp{k};
        basin_plot = m_line(tmp_2(:,1),tmp_2(:,2),'color','k','linewidth',1);
        Willamettte_Basin3 = [tmp_2];
    end

elseif region_i >= 3

    filename = 'Basin_border/sierra_hwbasins';
    basins =m_shaperead(filename);

    tmp = basins.ncst;
    for k=2:4
        tmp_2 = tmp{k};
        if k==2
            tmp_2 = tmp_2(1:13769,1:2);
        end
        basin_plot = m_line(tmp_2(:,1),tmp_2(:,2),'color','k','linewidth',1);
    end

end

shading flat;
caxis([min_clr-1e-5,max_clr+1e-5])
%colormap(m_colmap('jet','step',10));
m_text(66,24,num_label,'fontsize',12,'fontweight','bold');
%colorbar
%colormap(colors_single);

if region_i == 1 && title_text ~= ""
    t = title(title_text,'fontsize',12, 'fontweight', 'bold');
    set(t, 'horizontalAlignment', 'left');
    set(t, 'units', 'normalized');
    h1 = get(t, 'position');
    set(t, 'position', [0 h1(2) h1(3)]);
end

set(gca, 'FontName', 'Time New Roman');

view(0,90);
hold off