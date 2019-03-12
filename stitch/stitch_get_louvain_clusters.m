function DataSet = stitch_get_louvain_clusters(DataSet, varargin)
% Usage: DataSet = stitch_get_louvain_clusters(DataSet, varargin)
%
% Identifies Louvain cell clusters for each timepoint entry of DataSet.  
% Returns cluster assignments as a column in the table: DataSet.celldata
%

%% PARAMETER SETTINGS
% Set defaults
def.k_use = 30;
def.distance_metric = 'correlation';

% Create parser object
parserObj = inputParser;
parserObj.FunctionName = 'stitch_get_Louvain_clusters';
parserObj.StructExpand = false; 
parserObj.addOptional('k_use',def.k_use);
parserObj.addOptional('distance_metric',def.distance_metric);

% Parse input options
parserObj.parse(varargin{:});
settings = parserObj.Results;

%% CODE:

base_counter = 0;
for j = 1:length(DataSet)
    tmp.tables = get_knn(full(DataSet(j).X_norm), DataSet(j).gene_ind, DataSet(j).nDim, 30, 'euclidean', []);
    tmp.tables.EdgeTable = filter_duplicate_edges(tmp.tables.EdgeTable);    
    tmp.G = graph(tmp.tables.EdgeTable, tmp.tables.NodeTable);
    DataSet(j).celldata = table(get_louvain_clusters(tmp.G, 0.2)+base_counter, 'VariableNames', {'Louvain_ID'});
    base_counter = max(DataSet(j).celldata.Louvain_ID);
end