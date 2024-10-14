
clc;
clear all;
close all;

figure;
set(gcf,'unit','normalized','position',[0.1,0.05,0.8,0.6]);
set(gca, 'Position', [0 0 1 1]);

y_u = [400 105 500 400];
y_d = [-200 -100 -250 -200];
titles = {'1996PacN','1996MidA','2017CA-Jan','2017CA-Feb'};
indexlabels = {'a','b','c','d'};
for region_i =1:4

    indexlabel = indexlabels{region_i};

    Rains = get_variable(region_i,'RAIN');
    Snows = get_variable(region_i,'SNOW');
    Qsoils = get_variable(region_i,'QSOIL');

    Qveges = get_variable(region_i,'QVEGE');
    Qvegts = get_variable(region_i,'QVEGT');

    ETs = -(Qsoils + Qveges + Qvegts);
    Qrunoffs = -get_variable(region_i,'QRUNOFF');
    Qsnomelts = get_variable(region_i,'QSNOMELT');
    H2osfcs = -get_variable(region_i,'H2OSFC');
    H2osnos = -get_variable(region_i,'H2OSNO');
    H2ocans = -get_variable(region_i,'H2OCAN');

    Qtopsoils = get_variable(region_i,'QTOPSOIL');

    Soilices = -get_variable(region_i,'SOILICE');
    Soilliqs = -get_variable(region_i,'SOILLIQ'); 
    WAs = -get_variable(region_i,'WA'); 

    H2osoils = Soilices+Soilliqs;
 %   TSAs = get_variable(region_i,'TSA'); 
    %Qh2osfcs = get_variable(region_i,'QH2OSFC');

    FSATs = get_variable(region_i,'FSAT');

    Others = Rains + Snows + ETs  + Qrunoffs + H2osfcs + H2osnos + H2ocans + H2osoils + WAs;
    Others = -Others;
    %colors = colors([4 3 2 1 5 6], :);

    row_i = ceil(region_i/2);
    col_i = region_i - (row_i-1)*2;

    subplot('position', [0.05 + (col_i-1)*0.43 0.53-(row_i-1)*0.44 0.38 0.38]);
    get_patch_data;
    title(titles{region_i})

    box on
    set(gca,'LineWidth',1.5,'fontsize',18,'XTick',[0:5],'XTickLabel',{'Control', '+1K', '+2K', '+3K', '+4K', '+5K'})
    xlim([0 5])
    if region_i == 4
       % variables = {'H2osfcs','H2ocans','H2osnos','Snows','Rains','ETs','H2osoils'};
%variables = {'H2osfcs','Others','H2ocans','H2osnos','Snows','Rains','ETs','H2osoils','WAs'};
%colors = flipud(brewermap(6,'Spectral'));
        ld = legend([ps{6} ps{5} ps{4} ps{3}  ps{1} ps{7} ps{8} ps{9} ps{2} qr],{'Rainfall','Snowfall','\DeltaSnow','\DeltaCanopy','\DeltaSurface',...
            'ET','\DeltaSoil','\DeltaAquifer','Others','Runoff'});
        ld.Position = [0.88 0.1 0.1 0.8];
    end
    
 if region_i <3
    set(gca, 'xticklabel',[])
 end

 if col_i == 1
    ylabel('mm')
 end
 ylim([y_d(region_i) y_u(region_i)])
end

exportgraphics(gcf,'../../figure_P/Figure_6_water_budget_P_r1.pdf','Resolution',300);
close all