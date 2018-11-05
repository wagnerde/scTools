function [table_CorrGenes, corr_gene_ind] = get_gene_neighbors(X, gene_names_all, gene_query, ndisp)
% Usage: [table_CorrGenes, corr_gene_ind] = get_gene_neighbors(X, gene_names_all, gene_query, ndisp)
%
% Given a single query gene, returns table of most highly correlated genes 
% based on Pearson distance, with associated P-values.
% 
% INPUTS:
% X        
%       Normalized matrix of single-cell expression counts (rows=genes, 
%       columns=cells).
%
% gene_names_all       
%       Names of all genes (cell array of strings), corresponding to 
%       rows of X.
%
% gene_query
%       User specified query gene (string).
% 
% ndisp
%       Number of nearest gene neighbors to return.       
% 
% OUPUTS:
% table_CorrGenes
%       Table of height ndisp, summarizing the results of the neighbor
%       search.  Neighbor genes are rows.  Columns are: RHO (correlation),
%       PVAL, and adjusted PVAL (Benjamini & Hochberg 1995, fdr_bh).
%
% corr_gene_ind
%       Row indices of correlated genes identified.  
%

%% CODE:

% add path for p-value adjustment function fdr_bh
addpath('scTools/fdr_bh')

% transpose of the original data such that rows=cells and columns=genes
Xtranspose = X';

% get index of input gene name in the original gene name list
query_gene_ind = strcmp(gene_names_all, gene_query);

% extract the counts values for this gene across all cells(row)
query_gene_vals = Xtranspose(:,query_gene_ind);

% compute the correlation between selected gene & all other genes
[RHO,PVAL] = corr(Xtranspose,query_gene_vals,'rows','complete');
[~,~,~,PVAL_adj] = fdr_bh(PVAL);

% check how many genes to display
if ~exist('ndisp', 'var')
    ndisp = length(RHO);
end

% sort genes by correlation
RHO(isnan(RHO)) = -Inf;
[RHO_sorted,corr_gene_ind] = sort(RHO,'descend');
RHO_sorted = RHO_sorted(1:ndisp);
corr_gene_ind = corr_gene_ind(1:ndisp);
gene_names_all = gene_names_all(corr_gene_ind);

% generate results table
table_CorrGenes = table(RHO_sorted, PVAL(corr_gene_ind), PVAL_adj(corr_gene_ind),'VariableNames',{'RHO' 'PVAL' 'AdjPVAL'},'RowNames',(gene_names_all));


