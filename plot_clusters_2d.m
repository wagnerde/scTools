function plot_clusters_2d(xy, clust_ids, clust_names)
% USAGE: plot_clusters_2d(xy, clust_ids, clust_names)
%
% Generates a simple 2d plot for visualizing cell clusters.
%
% INPUTS:
% xy            2d array of xy coordinates
% clust_ids     Numerical array of cluster assignments for each row in xy
% clust_names   String array of cluster names for each row in xy (optional)
%

%% CODE:

% add color brewer functions to path
addpath('scTools/cbrewer')

% if cluster names are not specified, just use numbers instead
if ~exist('clust_names', 'var')
    clust_names = cellstr(num2str(clust_ids));
end

% set colormap, unassigned cells set to black
cols = cbrewer('qual','Set3', max(clust_ids));
cols = [cols; [0 0 0]];
color_ids = clust_ids;
color_ids(color_ids == -1) = max(color_ids)+1;

% make scatter plot
scatter(xy(:,1), xy(:,2), 25, color_ids, 'fill','linewidth',0.0001,'MarkerFaceAlpha',0.3);

% adjust axis limits
gap = 0.1;
x_plot = xy(:,1); x_range = range(x_plot);
y_plot = xy(:,2); y_range = range(y_plot);
set(gca,'xlim', [min(x_plot)-gap*x_range, max(x_plot)+gap*x_range])
set(gca,'ylim', [min(y_plot)-gap*y_range, max(y_plot)+gap*y_range])    

% adjust plot appearance
axis square;
set(gca,'fontsize',12);
xlabel({'','tSNE dimension 1'});
ylabel({'tSNE dimension 2',''});
set(gca,'xticklabel',{''},'yticklabel',{''});
set(gcf,'color','w');
box on
colormap(cols)

% add cluster labels
for k = 1:max(clust_ids)
    text(mean(xy(clust_ids==k,1)), mean(xy(clust_ids==k,2)), clust_names(find(clust_ids==k,1)), 'fontweight', 'normal', 'fontsize', 12);
end


