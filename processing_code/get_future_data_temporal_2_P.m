clc;
clear all;
close all;

region_names = {'CA','PN','MA'};

months = [ones(1,31) 2*ones(1,28)];
days = [1:31 1:28];

for region_i = 1:3

    case_names = dir(['/compyfs/haod776/e3sm_scratch/ROS/ROS_simulations/ROS_*' region_names{region_i} '*_FLOOD_Optimal_future_*_P_after_spinup_*']);

    disp(length(case_names))

    load([region_names{region_i} '_area_mask.mat']);

    for i = 1:length(case_names)


        case_name = case_names(i).name;
        if(exist(['all_data_P/basin_average_ELM_' case_name '_water_budget.mat'],'file'))
            disp(['existed!' case_name]);
            continue;
        end
        tic

        FSATs = nan(59, 24);
        TSOIs = nan(59, 24);

        H2OSOIs = nan(59, 24);
        SOILWATER_10CMs = nan(59, 24);
        SOILLIQs = nan(59, 24);
        SOILICEs = nan(59, 24);

        H2OSFCs = nan(59, 24);

        QINTRs = nan(59, 24);
        TSAs = nan(59, 24);
        QVEGEs = nan(59, 24);
        QVEGTs = nan(59, 24);
        QSOILs = nan(59, 24);

        TWSs = nan(59, 24);
        WAs = nan(59, 24);

        H2OCANs = nan(59, 24);
        QDRIPs = nan(59, 24);
        QFLOODs = nan(59, 24);
        QIRRIG_REALs = nan(59, 24);
        QRGWLs = nan(59, 24);
        SNOWICEs = nan(59, 24);
        SNOWLIQs = nan(59, 24);


        dirname = ['/compyfs/haod776/e3sm_scratch/ROS/ROS_simulations/' case_name '/run/'];

        for day_i = 1:59

            disp(day_i)

            time_str = [num2str(months(day_i), '%02d') '-' num2str(days(day_i), '%02d') ];
            if contains(case_name, "_1996_")
                filename = [case_name '.elm.h0.1996-' time_str '-00000.nc'];
            else
                filename = [case_name '.elm.h0.2017-' time_str '-00000.nc'];
            end


            %%'FSDS','FLDS','FSA','FSR','FIRE','FSH','EFLX_LH_TOT','TSOI','TSOI_10CM','SOILWATER_10CM','H2OSOI','TV','TG','TSA','FPSN','FSM','TBOT','FSNO','SNOWDP','H2OSNO','SNORDSL','QSNOMELT','QRUNOFF','QOVER','QSOIL','QSNWCPICE','SNOW','RAIN','QDRAI','QTOPSOIL','QH2OSFC','QDRAI_PERCH','QINFL','H2OSFC','FH2OSFC', 'FH2OSFC_EFF','QVEGE','QVEGT','SOILLIQ','SOILICE'

            %% aggregate to basin-level

            FSATs(day_i,:) = get_basin_average([dirname filename], 'FSAT', masks);
            TSOIs(day_i,:) = get_basin_average([dirname filename], 'TSOI', masks);

            H2OSOIs(day_i,:) = get_basin_average([dirname filename], 'H2OSOI', masks);
            SOILWATER_10CMs(day_i,:) = get_basin_average([dirname filename], 'SOILWATER_10CM', masks);

            SOILLIQs(day_i,:) = get_basin_average([dirname filename], 'SOILLIQ', masks);
            SOILICEs(day_i,:) = get_basin_average([dirname filename], 'SOILICE', masks);
            H2OSFCs(day_i,:) = get_basin_average([dirname filename], 'H2OSFC', masks);

            QINTRs(day_i,:) = get_basin_average([dirname filename], 'QINTR', masks);
            TSAs(day_i,:) = get_basin_average([dirname filename], 'TSA', masks);
            QVEGEs(day_i,:) = get_basin_average([dirname filename], 'QVEGE', masks);
            QVEGTs(day_i,:) = get_basin_average([dirname filename], 'QVEGT', masks);
            QSOILs(day_i,:) = get_basin_average([dirname filename], 'QSOIL', masks);

            TWSs(day_i,:) = get_basin_average([dirname filename], 'TWS', masks);
            WAs(day_i,:) = get_basin_average([dirname filename], 'WA', masks);

            H2OCANs(day_i,:) = get_basin_average([dirname filename], 'H2OCAN', masks);
            QDRIPs(day_i,:) = get_basin_average([dirname filename], 'QDRIP', masks);
            QFLOODs(day_i,:) = get_basin_average([dirname filename], 'QFLOOD', masks);
            QIRRIG_REALs(day_i,:) = get_basin_average([dirname filename], 'QIRRIG_REAL', masks);
            QRGWLs(day_i,:) = get_basin_average([dirname filename], 'QRGWL', masks);
            SNOWICEs(day_i,:) = get_basin_average([dirname filename], 'SNOWICE', masks);
            SNOWLIQs(day_i,:) = get_basin_average([dirname filename], 'SNOWLIQ', masks);



        end
        %% save
        save(['all_data_P/basin_average_ELM_' case_name '_water_budget.mat'],...
            "FSATs",...
            "TSOIs",...
            "H2OSOIs",...
            "SOILWATER_10CMs",...
            "SOILLIQs",...
            "SOILICEs",...
            "H2OSFCs",...
            "QINTRs",...
            "TSAs",...
            "QVEGEs",...
            "QVEGTs",...
            "QSOILs",...
            "TWSs",...
            "WAs",...
            "H2OCANs",...
            "QDRIPs",...
            "QFLOODs",...
            "QIRRIG_REALs",...
            "QRGWLs",...
            "SNOWICEs",...
            "SNOWLIQs"...
            );
        toc;
    end
end
