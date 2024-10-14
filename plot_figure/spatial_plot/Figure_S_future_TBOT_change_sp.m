clc;
clear all;
close all;


region_names = {'PN','MA','CA','CA'};
years = {1996, 1996, 2017, 2017};
limits = [280, 280, 280,280];
limit_changes = [6,6,6,6];
event_names = {'1996PacN','1996MidA','2017CA-Jan','2017CA-Feb'};
figure;
set(gcf,'unit','normalized','position',[0.1,0.1,0.75,0.3]);
set(gca, 'Position', [0 0 1 1])
left_line = 0.05;
for region_i = 1:4
    region_name = region_names{region_i};
    year_i = years{region_i};

    load([region_name '_area_mask.mat']);


    %% fiure
    res_v = 0.01;
    res_h = 0.01;
    if region_i == 1
        lon = (-124+res_h/2):res_h: (-121-res_h/2);
        lat = (46-res_v/2):-res_v: (43 + res_v/2);
    elseif region_i == 2
        lon = (-79+res_h/2):res_h: (-74-res_h/2);
        lat = (43-res_v/2):-res_v: (39 + res_v/2);
    else
        lon = (-122+res_h/2):res_h: (-119-res_h/2);
        lat = (41-res_v/2):-res_v: (38 + res_v/2);
    end

    [lons,lats]=meshgrid(lon,lat);

    %% figue plot
    colors_abs = (brewermap(10, 'YlOrRd'));

    load('cmap.mat');
    colors_delta = cmap;
    % colors_delta(11,:) = [0.95 0.95 0.95];


    delta_T = 0;

    disp(['Region:' region_name ': delta-T:' num2str(delta_T)])
    tic


    case_name = ['Spatial_ELM_ROS_' num2str(year_i) '_' region_name '_FLOOD_Optimal_future_' num2str(delta_T) 'K_after_spinup_20240118_' ...
        num2str(region_i)];

    load(['../all_data/' case_name '.mat']);

    TBOTs(~masks) = nan;


    if region_i == 2
        ax1 = subplot('Position',[left_line 0.1  0.23 0.8]);
        left_line = left_line+0.25;
    else
        ax1 = subplot('Position',[left_line 0.1  0.2 0.8]);
        left_line = left_line+0.22;

    end
    plot_global_map_T(region_i, lats, lons, TBOTs, 270, limits(region_i), event_names{region_i}, 1, 1,'');
    colormap(ax1, colors_abs);
   % ylabel(event_names{region_i});

    if region_i==1
        m_text(-124.6,46,'a','fontsize',18);
    elseif region_i ==2
        m_text(-79.8,43,'b','fontsize',18);
    elseif region_i ==3
        m_text(-122.1,40.6,'c','fontsize',18);
    else
        m_text(-122.1,40.6,'d','fontsize',18);
    end

    if(region_i == 4)
        hcb = colorbar;
        hcb.Title.String = "K";

        x=get(hcb,'Position');
        x(1)=0.94;
        x(2)=x(2)-0.02;
        set(hcb,'Position',x)
    end
        set(gca,'fontsize',18)

end

set(gcf, 'render', 'Painters');
set(gcf, 'Color', 'w');
exportgraphics(gcf,'../../figure/Figure_S_TBOT_spatial_map_r.tif','Resolution',300);
close all

close all;