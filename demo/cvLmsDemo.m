% cvLmsDemo - Demo of cvLms.m
function cvLmsDemo
trainData = [
    0.6213    0.5226    0.9797    0.9568    0.8801    0.8757
    0.7373    0.8939    0.6614    0.0118    0.1991    0.0648
    ];
trainClass = [
    1     1     1     2     2     2
    ];
testData = [
    0.9883    0.5828    0.4235    0.5155    0.3340
    0.4329    0.2259    0.5798    0.7604    0.5298
    ];
b = ones(1, size(trainData, 2));
% main
[testClass, a] = cvLms(testData, trainData, trainClass, b);
testClass
a

% plot prototype vectors
classLabel = unique(trainClass);
nClass     = length(classLabel);
plotLabel = {'r*', 'g*'};
figure;
for i=1:nClass
    A = trainData(:, trainClass == classLabel(i));
    plot(A(1,:), A(2,:), plotLabel{i});
    hold on;
end

% plot classifiee vectors
plotLabel = {'ro', 'go'};
for i=1:nClass
    A = testData(:, testClass == classLabel(i));
    plot(A(1,:), A(2,:), plotLabel{i});
    hold on;
end

% plot decision boundary
w0 = a(1);
w  = a(2:end);
dist = -w0 / norm(w);
w = w ./ norm(w);
plot(w(1)*dist+[0 w(1)],w(2)*dist+[0 w(2)],'r-'); % weight vector
bound(1) = w(2); bound(2) = -w(1); % boundary is perpendicular to w
plot(w(1)*dist+[0 bound(1)],w(2)*dist+[0 bound(2)],'k-');
axis([0 1 0 1]);
hold off;

legend('1: prototype','2: prototype','1: classifiee', '2: classifiee', 'weight vector a', 'boundary', 'Location', 'NorthEast');
title('LMS');
