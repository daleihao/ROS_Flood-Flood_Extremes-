clc;
clear all;
close all;

region_names = {'CA','PN','MA'};

months = [ones(1,31) 2*ones(1,28)];
days = [1:31 1:28];

for region_i = 1:3

    case_names = dir(['/compyfs/haod776/e3sm_scratch/ROS/ROS_simulations/ROS_*' region_names{region_i} '*_FLOOD_Optimal_future_*_after_spinup_*']);

    disp(length(case_names))

    load([region_names{region_i} '_area_mask.mat']);

    for i = 1:length(case_names)

        tic
        case_name = case_names(i).name;
        if(exist(['all_data/ELM_' case_name '.mat'],'file'))
            continue;
        end



        TBOTs = nan(59, 24);
        TSOI_10CMs = nan(59, 24);

        SNOWs = nan(59, 24);
        RAINs = nan(59, 24);

        QSNOMELTs = nan(59, 24);
        QOVERs = nan(59, 24);
        QSOILs = nan(59, 24);
        QSNWCPICEs = nan(59, 24);
        QDRAIs = nan(59, 24);
        QTOPSOILs = nan(59, 24);
        QH2OSFCs = nan(59, 24);
        QDRAI_PERCHs = nan(59, 24);
        QINFLs = nan(59, 24);

        H2OSNOs = nan(59, 24);
        QRUNOFFs = nan(59, 24);


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

            TBOTs(day_i,:) = get_basin_average([dirname filename], 'TBOT', masks);
            TSOI_10CMs(day_i,:) = get_basin_average([dirname filename], 'TSOI_10CM', masks);

            SNOWs(day_i,:) = get_basin_average([dirname filename], 'SNOW', masks);
            RAINs(day_i,:) = get_basin_average([dirname filename], 'RAIN', masks);

            QSNOMELTs(day_i,:) = get_basin_average([dirname filename], 'QSNOMELT', masks);
            QOVERs(day_i,:) = get_basin_average([dirname filename], 'QOVER', masks);
            QSOILs(day_i,:) = get_basin_average([dirname filename], 'QSOIL', masks);
            QSNWCPICEs(day_i,:) = get_basin_average([dirname filename], 'QSNWCPICE', masks);
            QDRAIs(day_i,:) = get_basin_average([dirname filename], 'QDRAI', masks);
            QTOPSOILs(day_i,:) = get_basin_average([dirname filename], 'QTOPSOIL', masks);
            QH2OSFCs(day_i,:) = get_basin_average([dirname filename], 'QH2OSFC', masks);


            QDRAI_PERCHs(day_i,:) = get_basin_average([dirname filename], 'QDRAI_PERCH', masks);
            QINFLs(day_i,:) = get_basin_average([dirname filename], 'QINFL', masks);


            H2OSNOs(day_i,:) = get_basin_average([dirname filename], 'H2OSNO', masks);
            QRUNOFFs(day_i,:) = get_basin_average([dirname filename], 'QRUNOFF', masks);


        end
        %% save
        save(['all_data/basin_average_ELM_' case_name '.mat'],...
            "TBOTs",...
            "TSOI_10CMs",...
            "SNOWs",...
            "RAINs",...
            "QSNOMELTs",...
            "QOVERs",...
            "QSOILs",...
            "QSNWCPICEs",...
            "QDRAIs",...
            "QTOPSOILs",...
            "QH2OSFCs",...
            "QDRAI_PERCHs",...
            "QINFLs",...
            "H2OSNOs",...
            "QRUNOFFs"...
            );
        toc;
    end
end