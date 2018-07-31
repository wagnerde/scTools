function plot_knn_graph(G, XY)
% Usage: plot_knn_graph(G, XY)
%
% Plots a 2D layout of a knn graph.
% 
% INPUTS:
% G         A Matlab graph object  
% XY        Matrix of XY coordinates for each node in G 
%

%% CODE


figure
set(gca,'Position',[0.05 0.05 0.9 0.9])
p = plot(G, 'XData', XY(:,1),'YData', XY(:,2), 'NodeCData', grp2idx(G.Nodes.OriginalDataSet));
p.MarkerSize=1;
p.EdgeAlpha = 0.05;
p.EdgeColor = [0 0 0];
colormap(jet)
axis off


