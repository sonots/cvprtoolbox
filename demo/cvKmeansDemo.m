% cvKmeansDemo - Demo of cvKmeans.m
function cvKmeansDemo
X =[ 3     2     2     2     1    -3    -2    -2    -2    -1
    2     3     2     1     2    -2    -3    -2    -1    -2 ];
[C, mu] = cvKmeans(X, 2);
C
mu

% plot data
clusterLabel = unique(C);
nCluster     = length(clusterLabel);
plotLabel = {'r+', 'b+'};
for i=1:nCluster
    A = X(:, C == clusterLabel(i));
    plot(A(1, :), A(2, :), plotLabel{i});
    hold on;
end

% plot centroids
plotLabel = {'ro', 'bo'};
for i=1:nCluster
    plot(mu(1, i), mu(2, i), plotLabel{i});
    hold on;
end
legend('cluster 1: data','cluster 2: data', 'cluster 1: centroid', ...
    'cluster 2: centroid', 'Location', 'SouthEast');
title('K means clustering');