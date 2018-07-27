function clustIDs = get_density_clusters(xy, manual)
% Usage: clustIDs = get_density_clusters(xy, manual)
%
%

percNeigh = 0.03; 
kernel = 'Gauss';
dist = squareform(pdist(xy));
[dc, rho] = paraSet(dist, percNeigh, kernel);
if ~exist('manual','var')
    manual=0;
end
[~, clustIDs, ~, ~] = densityClust(dist, 10, rho, 0, manual);



