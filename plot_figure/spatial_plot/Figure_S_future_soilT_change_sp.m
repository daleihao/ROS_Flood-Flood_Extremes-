clc;
clear all;
close all;


region_names = {'PN','MA','CA','CA'};
years = {1996, 1996, 2017, 2017};
limits = [280, 280, 280,280];
limit_changes = [5 5 5 5];
event_names = {'1996PacN','1996MidA','2017CA-Jan','2017CA-Feb'};
figure;
set(gcf,'unit','normalized','position',[0.1,0.1,0.75,1]);
set(gca, 'Position', [0 0 1 1])
top_line = 1-0.02;
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


    for delta_T = 0:5

        disp(['Region:' region_name ': delta-T:' num2str(delta_T)])
        tic


        case_name = ['soil_Spatial_ELM_ROS_' num2str(year_i) '_' region_name '_FLOOD_Optimal_future_' num2str(delta_T) 'K_P_after_spinup_20240909_' ...
            num2str(region_i)];

        load(['../all_data_P/' case_name '.mat']);

        TSOI_10CMs_avg(~masks) = nan;
        TSOI_10CMs_avg(TSOI_10CMs_avg == 0) = 0;


        if(delta_T ==0)
            if region_i == 2
                ax1 = subplot('Position',[0.055 top_line-0.19  0.13 0.16]);
                top_line = top_line -0.19;
            else
                ax1 = subplot('Position',[0.055 top_line-0.25  0.13 0.22]);
                top_line = top_line - 0.25;
            end
            plot_global_map(region_i, lats, lons, TSOI_10CMs_avg, 270, limits(region_i), 'Control', 1, 1,'');
            colormap(ax1, colors_abs);
            ylabel(event_names{region_i});
            TSOI_10CMs_avg_hist = TSOI_10CMs_avg;
            if region_i==1
                m_text(-125,46,'a','fontsize',18);
            elseif region_i ==2
                m_text(-80.8,43,'b','fontsize',18);
            elseif region_i ==3
                m_text(-122.5,40.6,'c','fontsize',18);
            else
                m_text(-122.5,40.6,'d','fontsize',18);
            end
 

        else
            if region_i == 2
                ax1 = subplot('Position',[0.055 + 0.05+ 0.14*delta_T top_line  0.13 0.16]);
            else
                ax1 = subplot('Position',[0.055 + 0.05+ 0.14*delta_T top_line  0.13 0.22]);
            end

            diff_tmp = (TSOI_10CMs_avg - TSOI_10CMs_avg_hist);

            diff_tmp(diff_tmp == 0) = 0.001;
            plot_global_map(region_i,lats, lons, diff_tmp, -limit_changes(region_i), limit_changes(region_i), ['+' num2str(delta_T) 'K'], 1, 0,'');
            colormap(ax1, colors_delta);

        end
        if(delta_T == 0)
            hcb = colorbar;
            hcb.Title.String = "K";

            x=get(hcb,'Position');
            x(1)=0.19;
            if region_i == 2
                x(4)=0.15;
                 x(2)=x(2)-0.03;
            else
                x(4)=0.20;
                 x(2)=x(2)-0.04;
            end
            set(hcb,'Position',x)

             hcb.Ticks = [270:2:280]; % Custom tick positions
            hcb.TickLabels = {'270', '272', '274', '276', '278','280'}; % Custom tick labels


        end
        if(delta_T == 5)
            hcb = colorbar;
            hcb.Title.String = "K";

            x=get(hcb,'Position');
            x(1)=0.94;
            if region_i == 2
                x(4)=0.15;
                 x(2)=x(2)-0.03;
            else
                x(4)=0.20;
                 x(2)=x(2)-0.04;
            end
            set(hcb,'Position',x)
        end

        set(gca,'fontsize',18)
    end

end

set(gcf, 'render', 'Painters');
set(gcf, 'Color', 'w');
exportgraphics(gcf,'../../figure_P/Figure_S_soilT_spatial_map_r.pdf','Resolution',300);
close all

close all;