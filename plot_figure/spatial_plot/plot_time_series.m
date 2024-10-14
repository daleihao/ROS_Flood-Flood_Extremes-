clc;
clear all;
close all;

region_names = {'CA','MA','PN'};
years = {2017, 1996, 1996};
%limits = [50, 20, 80];
for region_i = 1:3
    region_name = region_names{region_i};
    year_i = years{region_i};


    figure;
    hold on
    for delta_T = 0:5

        disp(['Region:' region_name ': delta-T:' num2str(delta_T)])
        tic
        if delta_T == 0
            case_name = ['ROS_' num2str(year_i) '_' region_name '_FLOOD_spinup_20230814'];
        else
            case_name = ['ROS_' num2str(year_i) '_' region_name '_FLOOD_future_' num2str(delta_T) 'K_20230814'];
        end

        if ~exist(['time_series/ELM_' case_name '.mat'], 'file')
            continue;
        end

        load(['time_series/ELM_' case_name '.mat']);


        plot(QSNOMELT*3600*24)

    end
    legend('Control','+1k','+2k','+3k','+4k','+5k');
end



%% plot SWE
region_names = {'CA','MA','PN'};
years = {2017, 1996, 1996};
%limits = [50, 20, 80];
for region_i = 1:3
    region_name = region_names{region_i};
    year_i = years{region_i};


    figure;
    hold on
    for delta_T = 0:5

        disp(['Region:' region_name ': delta-T:' num2str(delta_T)])
        tic
        if delta_T == 0
            case_name = ['ROS_' num2str(year_i) '_' region_name '_FLOOD_spinup_20230814'];
        else
            case_name = ['ROS_' num2str(year_i) '_' region_name '_FLOOD_future_' num2str(delta_T) 'K_20230814'];
        end

        if ~exist(['time_series/ELM_' case_name '.mat'], 'file')
            continue;
        end

        load(['time_series/ELM_' case_name '.mat']);


        plot(H2OSNO)

    end
    legend('Control','+1k','+2k','+3k','+4k','+5k');
end


%% SNOW


region_names = {'CA','MA','PN'};
years = {2017, 1996, 1996};
%limits = [50, 20, 80];
for region_i = 1:3
    region_name = region_names{region_i};
    year_i = years{region_i};


    figure;
    hold on
    for delta_T = 0:5

        disp(['Region:' region_name ': delta-T:' num2str(delta_T)])
        tic
        if delta_T == 0
            case_name = ['ROS_' num2str(year_i) '_' region_name '_FLOOD_spinup_20230814'];
        else
            case_name = ['ROS_' num2str(year_i) '_' region_name '_FLOOD_future_' num2str(delta_T) 'K_20230814'];
        end

        if ~exist(['time_series/ELM_' case_name '.mat'], 'file')
            continue;
        end

        load(['time_series/ELM_' case_name '.mat']);


%         IF DELTA_T == 0
%             PLOT( - FLDS);
%             FLDS_0 = FSDS;
%         ELSE
%             PLOT(FLDS - FLDS_0);
%         END

    end
    legend('Control','+1k','+2k','+3k','+4k','+5k');
end
