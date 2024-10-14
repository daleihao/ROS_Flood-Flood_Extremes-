clc;
clear all;
close all;

region_names = {'PN','MA','CA','CA'};

for region_i = 1:4

    case_names = dir(['/compyfs/haod776/e3sm_scratch/ROS/ROS_simulations/ROS_*' region_names{region_i} '*_FLOOD_Optimal_future_*_after_spinup_*']);

    switch region_i
        case 1
            months = 2*ones(10,1);
            days = [5:9];
        case 2
            months = 1*ones(10,1);
            days = [17:20];
        case 3
            months = 1*ones(10,1);
            days = [7:12];
        case 4
            months = 2*ones(10,1);
            days = [6:12]; %6-12
    end

    if region_i == 2
        size_x = 500;
        size_y = 400;
    else

        size_x = 300;
        size_y = 300;
    end

    day_num = length(days);
    disp(length(case_names))


    for i = 1:length(case_names)

        tic
        case_name = case_names(i).name;
        if(exist(['all_data/ELM_' case_name '.mat'],'file'))
            continue;
        end


        SOILICEs = nan(size_x,size_y,day_num*24);
        SOILLIQs = nan(size_x,size_y,day_num*24);
        SOILWATER_10CMs = nan(size_x,size_y,day_num*24);
        TSOI_10CMs = nan(size_x,size_y,day_num*24);
        QINFLs = nan(size_x,size_y,day_num*24);

        dirname = ['/compyfs/haod776/e3sm_scratch/ROS/ROS_simulations/' case_name '/run/'];

        tmp = 1;
        for day_i = 1:length(days)

            time_str = [num2str(months(day_i), '%02d') '-' num2str(days(day_i), '%02d') ];
            if contains(case_name, "_1996_")
                filename = [case_name '.elm.h0.1996-' time_str '-00000.nc'];
            else
                filename = [case_name '.elm.h0.2017-' time_str '-00000.nc'];
            end

            SOILICE = ncread([dirname filename], 'SOILICE',[1 1 1 1], [Inf Inf Inf 24]);
            SOILLIQ = ncread([dirname filename], 'SOILLIQ',[1 1 1 1], [Inf Inf Inf 24]);
            SOILICE = squeeze(sum(SOILICE,3));
            SOILLIQ = squeeze(sum(SOILLIQ,3));

            SOILWATER_10CM = ncread([dirname filename], 'SOILWATER_10CM',[1 1 1], [Inf Inf 24]);
            TSOI_10CM = ncread([dirname filename], 'TSOI_10CM',[1 1 1], [Inf Inf 24]);

            QINFL = ncread([dirname filename], 'QINFL',[1 1 1], [Inf Inf 24]);

            SOILICEs(:,:,tmp:(tmp+23)) = SOILICE;
            SOILLIQs(:,:,tmp:(tmp+23)) = SOILLIQ;
            SOILWATER_10CMs(:,:,tmp:(tmp+23)) = SOILWATER_10CM;
            TSOI_10CMs(:,:,tmp:(tmp+23)) = TSOI_10CM;
            QINFLs(:,:,tmp:(tmp+23)) = QINFL;

            tmp = tmp+24;
        end

        SOILICEs_avg = squeeze(mean(SOILICEs,3));
        SOILLIQs_avg = squeeze(mean(SOILLIQs,3));
        SOILWATER_10CMs_avg = squeeze(mean(SOILWATER_10CMs,3));
        TSOI_10CMs_avg = squeeze(mean(TSOI_10CMs,3));
        QINFLs = squeeze(sum(QINFLs,3));
        
        SOILICEs_avg = flipud(SOILICEs_avg');
        SOILLIQs_avg = flipud(SOILLIQs_avg');
        SOILWATER_10CMs_avg = flipud(SOILWATER_10CMs_avg');
        TSOI_10CMs_avg = flipud(TSOI_10CMs_avg');
        QINFLs = flipud(QINFLs');

        SOILICEs_init = squeeze(SOILICEs(:,:,1));
        SOILLIQs_init = squeeze(SOILLIQs(:,:,1));
        SOILWATER_10CMs_init = squeeze(SOILWATER_10CMs(:,:,1));
      
        SOILICEs_init = flipud(SOILICEs_init');
        SOILLIQs_init = flipud(SOILLIQs_init');
        SOILWATER_10CMs_init = flipud(SOILWATER_10CMs_init');

        SOILICEs_after = squeeze(SOILICEs(:,:,end));
        SOILLIQs_after = squeeze(SOILLIQs(:,:,end));
        SOILWATER_10CMs_after = squeeze(SOILWATER_10CMs(:,:,end));
      
        SOILICEs_after = flipud(SOILICEs_after');
        SOILLIQs_after = flipud(SOILLIQs_after');
        SOILWATER_10CMs_after = flipud(SOILWATER_10CMs_after');

        %% save
        save(['all_data/soil_Spatial_ELM_' case_name '_' num2str(region_i) '.mat'],...
            'SOILICEs_avg','SOILLIQs_avg','SOILWATER_10CMs_avg','TSOI_10CMs_avg',...
            'SOILICEs_init','SOILLIQs_init','SOILWATER_10CMs_init',...
            'SOILICEs_after','SOILLIQs_after','SOILWATER_10CMs_after',...
            'QINFLs'...
            );
        toc;
    end
end