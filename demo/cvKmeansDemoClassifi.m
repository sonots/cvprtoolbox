% cvKmeansDemoClassifi - Demo of using K-means for classification problem.
% Note that the nearest neighbor uses only codewords (or codebook or
% centroids) as prototypes for classification
function cvKmeansDemoClassifi
trainData = [
    0.6213    0.5226    0.9797    0.9568    0.8801    0.8757    0.1730    0.2714    0.2523
    0.7373    0.8939    0.6614    0.0118    0.1991    0.0648    0.2987    0.2844    0.4692
    ];
trainClass = [
    1     1     1     2     2     2     3     3     3
    ];
testData = [
    0.9883    0.5828    0.4235    0.5155    0.3340
    0.4329    0.2259    0.5798    0.7604    0.5298
    ];

classLabel = unique(trainClass);
nClass     = length(classLabel);
% main
nCluster = nClass;
[trainCluster, codebook] = cvKmeans(trainData, nCluster);
codebookClass = cvAutolabel(trainCluster, trainClass);
testClass = cvKnn(testData, codebook, codebookClass, 1);

% plot prototypes
plotLabel = {'r*', 'g*', 'b*'};
for i=1:nClass
    A = trainData(:, trainClass == classLabel(i));
    plot(A(1,:), A(2,:), plotLabel{i});
    hold on;
end

% plot classifiees
plotLabel = {'ro', 'go', 'bo'};
for i=1:nClass
    A = testData(:, testClass == classLabel(i));
    plot(A(1,:), A(2,:), plotLabel{i});
    hold on;
end

% plot codebook
plot(codebook(1,:), codebook(2,:), 'k+');

% voronoi diagram
voronoi(codebook(1,:), codebook(2,:), 'k-');

legend('1: train','2: train', '3: train', '1: test', '2: test', '3: test', 'codewords');
title('Classification using k-means');
