
bottom_heights = nan(9, 6);
top_heights = nan(9, 6);

variables = {'H2osfcs','Others','H2ocans','H2osnos','Snows','Rains','ETs','H2osoils','WAs'};

%% first H2OSFC
bottom_heights(1,:) = zeros(6,1);
top_heights(1,:) = H2osfcs';

for variable_i = 2:9
    variable_name = variables{variable_i};
%% then H2OCAN
for delta_T = 1:6
    variable_value = eval(variable_name);
    if (variable_value(delta_T)>0)
        bottom_heights(variable_i,delta_T) = max([top_heights(1:(variable_i-1),delta_T); 0]);
    else
        bottom_heights(variable_i,delta_T) = min([top_heights(1:(variable_i-1),delta_T); 0]);
    end
end
 top_heights(variable_i,:) = bottom_heights(variable_i,:) + variable_value';
end

%% figure

colors = flipud(brewermap(9,'BrBG'));
colors(5,:) = [0.5 0.5 0.5];
%variables = {'H2osfcs','H2ocans','H2osnos','Snows','Rains','ETs','H2osoils'};

variables = {'H2osfcs','Others','H2ocans','H2osnos','Snows','Rains','ETs','H2osoils','WAs'};
%colors = flipud(brewermap(6,'Spectral'));
colors = colors([6 5 4 3 2 1 7 8 9], :);
% figure;
% hold on
% for delta_T = 1:5
%     for variable_i = 1:6
%
%         p = patch([delta_T:(delta_T+1) (delta_T+1):-1:delta_T],[bottom_heights(variable_i,delta_T:(delta_T+1)) fliplr(top_heights(variable_i,delta_T:(delta_T+1)))],colors(variable_i,:))
%         %p.FaceAlpha = delta_T *0.2;
%
%     end
% end

ps = cell(9,1);
hold on
for variable_i = 1:9
    ps{variable_i} = patch([0:5 5:-1:0],[bottom_heights(variable_i,:) fliplr(top_heights(variable_i,:))],colors(variable_i,:),'EdgeColor',colors(variable_i,:));
    %p.FaceAlpha = delta_T *0.2;
end

qr = plot([0:5],-Qrunoffs, 'Ko-','LineWidth',2,'Marker','square','MarkerSize',15,'MarkerEdgeColor','k','MarkerFaceColor','w');


YL = get(gca, 'YLim');

text(-0.6,YL(2)+(YL(2)-YL(1))*0.05, indexlabel,'fontsize',22,'FontWeight','bold');
 set(gca, 'YLim', YL);