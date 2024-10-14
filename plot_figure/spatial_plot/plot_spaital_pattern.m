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

    figure;
    colormap jet
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
        
        QRUNOFF(~masks) = nan;
        if(delta_T == 0)
         tmp = QRUNOFF;
        end
        subplot(2,3,delta_T+1)
        imagesc((QRUNOFF-tmp)*3600*24, [-limits(region_i) limits(region_i)])
        
        
    end
end



%% plot SWE
limits = [200, 200, 200];
for region_i = 1:3
    region_name = region_names{region_i};
    year_i = years{region_i};


    figure;
    colormap jet
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

        subplot(2,3,delta_T+1)
        imagesc(H2OSNO, [0 limits(region_i)])
        
    end
end

%% plot difference

%% plot SWE
limits = [200, 200, 200];
for region_i = 1:3
    region_name = region_names{region_i};
    year_i = years{region_i};


    figure;
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

        subplot(2,3,delta_T+1)
         if delta_T == 0
             TBOT_0 = FLDS;
         end
        imagesc(FLDS - TBOT_0, [-20 20])
        
    end
end