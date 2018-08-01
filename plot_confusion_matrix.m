function plot_confusion_matrix(ids1, ids2)
% Usage: plot_confusion_matrix(ids1, ids2)
%
% Compares two sets of classifications for a set of objects.  Returns a
% confusion matrix. 
% 
% INPUT:
% ids1/2    Two sets of classification indices for the same number of 
%           observations/rows.
% 

%% CODE: 

% specify 1st clustering: x-axis
c1_nClust = sum(unique(ids1)>0);
ids1(ids1==-1) = max(ids1)+1; % ignore any ids set to -1
classes1 = unique(ids1);

% specify 2nd clustering: y-axis
c2_nClust = sum(unique(ids2)>0);
ids2(ids2==-1) = max(ids2)+1; % ignore any ids set to -1
classes2 = unique(ids2);

% get confusion matrix
[C, ~] = confusionmat(ids1,ids2);
C = C(1:c1_nClust, 1:c2_nClust); 
C = C ./ sum(C,2);

% sort columns by max row values
[~,top_match]=max(C,[],2);
[~,match_order]=sort(top_match);

% plot figure
figure;
imagesc(C(match_order,:)')
colormap(othercolor('Blues9'))
set(gca, 'YTick', 1:length(classes2))
set(gca, 'XTick', 1:length(classes1), 'XTickLabels', match_order)
xtickangle(90)
axis square