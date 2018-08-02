function [ClustID, Quality] = get_louvain_clusters(G, gamma)
% Usage: [ClustID, Quality] = get_louvain_clusters(G, gamma)
%
% Performs Louvain-based community detection using 'genlouvain'
%
% INPUTS:
% G         Graph object
% gamma     Resolution (default = 1). Values >1 gives more clusters.
%           Values <1 give fewer clusters.
% 
% OUTPUTS:
% clustID   Community/Cluster assignments for each cell
% Q         Quality score for the partition of the network
%
%% CODE:

% add function path
addpath('scTools/GenLouvain-master')

% compute jaccard weights for each edge
A = get_jaccard_edge_weights(G);

% compute the modularity/quality matrix B, perform community detection
k = full(sum(A));
twom = sum(k);
B = @(v) A(:,v) - gamma*k'*k(v)/twom;
[ClustID, Quality] = genlouvain(B);
Quality = Quality/twom;



