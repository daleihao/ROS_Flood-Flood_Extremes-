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


        QTOPSOILs = nan(size_x,size_y,day_num*24);
        QRUNOFFs = nan(size_x,size_y,day_num*24);
        SNOWs = nan(size_x,size_y,day_num*24);
        RAINs = nan(size_x,size_y,day_num*24);
        H2OSNOs = nan(size_x,size_y,day_num*24);
        TBOTs = nan(size_x,size_y,day_num*24);


        dirname = ['/compyfs/haod776/e3sm_scratch/ROS/ROS_simulations/' case_name '/run/'];

        tmp = 1;
        for day_i = 1:length(days)

            time_str = [num2str(months(day_i), '%02d') '-' num2str(days(day_i), '%02d') ];
            if contains(case_name, "_1996_")
                filename = [case_name '.elm.h0.1996-' time_str '-00000.nc'];
            else
                filename = [case_name '.elm.h0.2017-' time_str '-00000.nc'];
            end

            QTOPSOIL = ncread([dirname filename], 'QTOPSOIL',[1 1 1], [Inf Inf 24]);
            QRUNOFF = ncread([dirname filename], 'QRUNOFF',[1 1 1], [Inf Inf 24]);
            SNOW = ncread([dirname filename], 'SNOW',[1 1 1], [Inf Inf 24]);
            RAIN = ncread([dirname filename], 'RAIN',[1 1 1], [Inf Inf 24]);
            H2OSNO = ncread([dirname filename], 'H2OSNO',[1 1 1], [Inf Inf 24]);
            TBOT = ncread([dirname filename], 'TBOT',[1 1 1], [Inf Inf 24]);

            QTOPSOILs(:,:,tmp:(tmp+23)) = QTOPSOIL;
            QRUNOFFs(:,:,tmp:(tmp+23)) = QRUNOFF;
            SNOWs(:,:,tmp:(tmp+23)) = SNOW;
            RAINs(:,:,tmp:(tmp+23)) = RAIN;
            H2OSNOs(:,:,tmp:(tmp+23)) = H2OSNO;
            TBOTs(:,:,tmp:(tmp+23)) = TBOT;

            tmp = tmp+24;
        end

        QTOPSOILs = squeeze(sum(QTOPSOILs,3));
        QRUNOFFs = squeeze(sum(QRUNOFFs,3));
        SNOWs = squeeze(sum(SNOWs,3));
        RAINs = squeeze(sum(RAINs,3));
        H2OSNOs = squeeze(H2OSNOs(:,:,1));
        TBOTs = squeeze(mean(TBOTs,3));

        QTOPSOILs = flipud(QTOPSOILs');
        QRUNOFFs = flipud(QRUNOFFs');
        SNOWs = flipud(SNOWs');
        RAINs = flipud(RAINs');
        H2OSNOs = flipud(H2OSNOs');
        TBOTs = flipud(TBOTs');

        %% save
        save(['all_data/Spatial_ELM_' case_name '_' num2str(region_i) '.mat'],'QTOPSOILs',...
            'QRUNOFFs','SNOWs','RAINs','H2OSNOs','TBOTs');
        toc;
    end
end