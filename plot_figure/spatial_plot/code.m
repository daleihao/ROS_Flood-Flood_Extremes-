%% process data
clc
clear all;
close all;

%opengl software
%% fiure
elevations = imread('ELM_mean_of_Elevation.tif');

res_v = 0.01;
res_h = 0.01;
lon = (-122+res_h/2):res_h: (-119-res_h/2);
lat = (41-res_v/2):-res_v: (38 + res_v/2);
[lons,lats]=meshgrid(lon,lat);


%% figue plot
figure;
set(gcf,'unit','normalized','position',[0.1,0.1,0.32,0.6]);
set(gca, 'Position', [0.02 0.05 0.9 0.9])
colors = (brewermap(20, 'YlGnBu'));
colormap(colors)
plot_global_map_elevation(lats, lons, elevations, 0, 3000, '', 1, 1,'')
hcb = colorbar;
hcb.Title.String = "m";

x=get(hcb,'Position');
x(1)=0.82;
% x(4)=0.6;
% x(2)=0.3;
set(hcb,'Position',x)

set(gca,'fontsize',12)

%% plot boundary
filename = 'ROS_shape/usgs_gagesii_daily_boundaries';
gages_bounary = m_shaperead(filename);

tmp = gages_bounary.ncst;
for k=1:length(tmp)
    tmp_2 = tmp{k};
gage_plot = m_patch(tmp_2(:,1),tmp_2(:,2),[0.8 0.8 0.8]);
    alpha(gage_plot, 0.5)
end

filename = 'Basin_border/sierra_hwbasins';
basins =m_shaperead(filename);

tmp = basins.ncst;
for k=2:4
    tmp_2 = tmp{k};
basin_plot = m_line(tmp_2(:,1),tmp_2(:,2),'color','k','linewidth',1);
end

filename = 'ROS_shape/gagesII_9322_sept30_2011';
gages = m_shaperead(filename);

tmp = gages.dbf;
tmp2 = gages.dbfdata;
class_p = tmp2(:,3);
class_p = convertCharsToStrings(class_p);

sites_gauge = [11427760	11439500	11444201	11427000	11400500	11402000	11417500	11418500	11413000];
site_p = str2num(char(tmp.STAID));

[C,filters,ib] = intersect(site_p,sites_gauge,'stable');
lon_p = cell2mat(tmp.LNG_GAGE);
lat_p = cell2mat(tmp.LAT_GAGE);

site_info = [site_p lon_p lat_p];
writematrix(site_info,'sites/sierra_nevada_daily_discharge_stations.txt');
hold on
s1_plot = m_plot(lon_p(filters),lat_p(filters),'^','MarkerEdgeColor','r','MarkerFaceColor','r');

% filename = 'ROS_shape/states';
% states_bo78undary = m_shaperead(filename);
% u
% tmp = states_boundary.ncst;
% for k=1:length(tmp)
%     tmp_2 = tmp{k};
%     m_line(tmp_2(:,1),tmp_2(:,2),'color','k','linewidth',1);
% end

%% plot site loc
%% snow
hold on

%% stream
sitedata = readmatrix('sites/sierra_nevada_discharge_stations.txt');
filters_in = isSiteinBasin(sitedata(:,6),sitedata(:,5));

%s1_plot = m_plot(sitedata(filters_in,6),sitedata(filters_in,5),'^','MarkerEdgeColor','r','MarkerFaceColor','r');

% sitedata = readmatrix('sites/sierra_nevada_precip_stations.txt');
% m_plot(sitedata(:,6),sitedata(:,5),'o','MarkerEdgeColor','k');

sitedata = readmatrix('sites/sierra_nevada_met_stations.txt');
filters_in = isSiteinBasin(sitedata(:,5),sitedata(:,4));
s2_plot = m_plot(sitedata(filters_in,5),sitedata(filters_in,4),'+','MarkerEdgeColor','k','MarkerFaceColor','k','linewidth',1);

sitedata = readmatrix('sites/sierra_nevada_swe_stations.csv');
filters_in = isSiteinBasin(sitedata(:,6),sitedata(:,7));
s3_plot = m_plot(sitedata(filters_in,6),sitedata(filters_in,7),'o','MarkerEdgeColor','k','MarkerFaceColor',[1 1 1 ]);

h = legend([s1_plot, s2_plot, s3_plot,gage_plot,basin_plot],{'Stream Gauge','Met. Station','Snow Pillow','Gauge Drainage Area','Basin Boundary'});
set(h, 'Position',[0.335 0.06 0.05 0.2],'fontsize',8, 'linewidth', 1);

% Surface Met.
% Precipitation
% Soil
% snow
% stream
%set(gcf, 'InvertHardCopy', 'off');
print(gcf, '-dtiff', '-r300', ['study_area.tif'])
print(gcf, '-dpng', '-r300', ['study_area.png'])

close all