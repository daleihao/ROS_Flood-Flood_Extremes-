clc;
clear all;
close all;


region_names = {'CA','MA','PN'};
years = {2017, 1996, 1996};
limits = [50, 10, 80];

for region_i = 1:3
    region_name = region_names{region_i};
    year_i = years{region_i};

    load([region_name '_area_mask.mat']);


    %% fiure
    res_v = 0.01;
    res_h = 0.01;
    lon = (-122+res_h/2):res_h: (-119-res_h/2);
    lat = (41-res_v/2):-res_v: (38 + res_v/2);
    [lons,lats]=meshgrid(lon,lat);

    %% figue plot
    colors_abs = (brewermap(21, 'YlOrRd'));
    colors_delta = flipud(brewermap(21, 'RdBu'));
    colors_delta(11,:) = [0.9 0.9 0.9];

    figure;
    set(gcf,'unit','normalized','position',[0.1,0.1,0.9,0.3]);
    set(gca, 'Position', [0 0 1 1])
   


    for delta_T = 0:5

        disp(['Region:' region_name ': delta-T:' num2str(delta_T)])
        tic
        if delta_T == 0
            case_name = ['ROS_' num2str(year_i) '_' region_name '_FLOOD_spinup_20230814'];
        else
            case_name = ['ROS_' num2str(year_i) '_' region_name '_FLOOD_future_' num2str(delta_T) 'K_20230814'];
        end

        if ~exist(['spatial_mean/ELM_' case_name '.mat'], 'file')
            continue;
        end

        load(['spatial_mean/ELM_' case_name '.mat']);

        H2OSNO(~masks) = nan;
        

        if(delta_T ==0)
            ax1 = subplot('Position',[0.02+ 0.15*delta_T 0.05  0.14 0.85]);
            plot_global_map(lats, lons, H2OSNO, 0, 500, 'Historical', 1, 1,'');
            colormap(ax1, colors_abs);
            H2OSNO_hist = H2OSNO;
        else
            ax1 = subplot('Position',[0.02 + 0.05+ 0.145*delta_T 0.05  0.14 0.85]);
            plot_global_map(lats, lons, (H2OSNO - H2OSNO_hist), -200, 200, ['+' num2str(delta_T) '°C'], 1, 0,'');
            colormap(ax1, colors_delta);
        end
        if(delta_T == 0)
            hcb = colorbar;
            hcb.Title.String = "mm/day";

            x=get(hcb,'Position');
            x(1)=0.175;
            x(2)=0.05;
            x(4)=0.85;
            set(hcb,'Position',x)

        end
        if(delta_T == 5)
            hcb = colorbar;
            hcb.Title.String = "mm/day";

            x=get(hcb,'Position');
            x(1)=0.95;
            x(2)=0.05;
            x(4)=0.85;
            set(hcb,'Position',x)

        end

        set(gca,'fontsize',18)
    end
    set(gcf, 'render', 'Painters');
    set(gcf, 'Color', 'w');
    export_fig('ROS_figure_future_swe_change_sp_r.pdf','-Painters', '-nocrop');

    close all;
end
