% cvGaussPdfDemo - Demo of cvGaussPdf.m
function cvGaussPdfDemo
normalize = 'normterm';
logprob = false;
% 1-D
Mu = [0];
Sigma = [1];
X = [-4:0.1:4];
Pdf = cvGaussPdf(X, Mu, Sigma, normalize, logprob);
figure; plot(X, Pdf);
title('1-D Guassian with \mu = 0, \sigma = 1.');

% 2-D
Mu = [0
      0];
Sigma = [1 0
         0 1];
x1 = -4:0.1:4;
x2 = -4:0.1:4;
[X1 X2] = meshgrid(x1, x2);
X = [reshape(X1, [], size(X1, 1) * size(X1, 2));
     reshape(X2, [], size(X2, 1) * size(X2, 2))];
Pdf= cvGaussPdf(X, Mu, Sigma, normalize, logprob);
Z = reshape(Pdf, size(X1, 1), size(X1, 2));
fig = figure; surf(X1, X2, Z);
title('2-D Guassian with \mu_x = \mu_y = 0, \sigma_x = \sigma_y = 1, \sigma_{xy} = 0.');
saveas(fig, 'BivariateGaussian.png');
end