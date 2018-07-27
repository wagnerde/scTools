clear all; close all; clc;

%% Load Data Set
% NOTE that the usage of some *very useful* functions: e.g., squareform, pdist2 ...
fileName = 'demoData.mat';
load(fileName); % NOTE that the 'demoData.mat' file includes a matrix <X> with *NE* elements and *2* dim,
                        % NE is the number of elements of a data set
figure(1);
plot(X(:, 1), X(:, 2), 'b.');
xlabel('Dim 1');
ylabel('Dim 2');
title('Original Data Set');

%% Settings of System Parameters for DensityClust
dist = pdist2(X, X); % [NE, NE] matrix (this case may be not suitable for large-scale data sets)
% average percentage of neighbours, ranging from [0, 1]
% as a rule of thumb, set to around 1%-2% of NE (see the corresponding *Science* paper for more details)
percNeigh = 0.02;
% 'Gauss' denotes the use of Gauss Kernel to compute rho, and
% 'Cut-off' denotes the use of Cut-off Kernel.
% For large-scale data sets, 'Cut-off' is preferable owing to computational efficiency,
% otherwise, 'Gauss' is preferable in the case of small samples (especially with noises).
kernel = 'Gauss';
% set critical system parameters for DensityClust
[dc, rho] = paraSet(dist, percNeigh, kernel); 
figure(2);
plot(rho, 'b*');
xlabel('ALL Data Points');
ylabel('\rho');
title('Distribution Plot of \rho');

%% Density Clustering
isHalo = 1; 
[numClust, clustInd, centInd, haloInd] = densityClust(dist, dc, rho, isHalo);
save('densityClust.mat', 'numClust', 'clustInd', 'centInd', 'haloInd');
figure(3);
plot(X(clustInd == 1, 1), X(clustInd == 1, 2), 'r.');
hold on;
plot(X(clustInd == 2, 1), X(clustInd == 2, 2), 'k.');
plot(X(centInd == 1, 1), X(centInd == 1, 2), 'bd', 'MarkerSize', 10, 'MarkerFaceColor', 'b');
plot(X(centInd == 2, 1), X(centInd == 2, 2), 'bd', 'MarkerSize', 10, 'MarkerFaceColor', 'b');
plot(X(haloInd == 0, 1), X(haloInd == 0, 2), 'g.');
xlabel('Dim 1');
ylabel('Dim 2');
title('DensityClust for 2-D Artifical Data Set');
hold off;