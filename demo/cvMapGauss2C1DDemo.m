% cvMapGauss2C1DDemo - Demo of cvMapGauss2C1D.m
function cvMapGauss2C1DDemo
xp = [-1 0 1 2 4 6];
cp = [1 1 1 2 2 2];
x  = -5:1:8;

label = unique(cp);
nClass = length(label);
[D, P] = size(xp);
for i=1:2
    xi = xp(cp == i);
    ni = length(xi);
    prior(i) = ni / P;
    [mu(i) sigma(i)] = cvMeanCov(xi);
end
[c x0] = cvMapGauss2C1D(x, mu, sigma, prior);

% plot prototype vectors
classLabel = unique(cp);
nClass     = length(classLabel);
plotLabel = {'r*', 'g*'};
figure;
for i=1:nClass
    a = xp(classLabel(i) == cp);
    plot(a, 1, plotLabel{i});
    hold on;
end
% plot classifiee vectors
plotLabel = {'ro', 'go'};
for i=1:nClass
    a = x(classLabel(i) == c);
    if isempty(a), continue; end;
    plot(a, 1, plotLabel{i});
    hold on;
end
% plot boundaries
plot([x0(1) x0(1)], [0 2], 'k-');
plot([x0(2) x0(2)], [0 2], 'k-');
end
