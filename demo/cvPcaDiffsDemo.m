N = 20000;
X = [randn(1,N)*sqrt(0.1); 
    randn(1,N)*sqrt(2);
    randn(1,N)*sqrt(0.5)];
[U, Me, Lambda] = cvPca(X);
U
Me
Lambda

% Y = [randn(1,3)*sqrt(0.1);
%     randn(1,3)*sqrt(2);
%     randn(1,3)*sqrt(0.5)];
Y = [   -0.8724   -0.1224   -0.0493
    2.4751    3.1378    1.2612
   -0.2662    0.1468   -0.0246];

Mu = zeros(3,1);
Sigma = diag([0.1, 2, 0.5]);
logp = cvGaussPdf(Y, Mu, Sigma, 'nonorm', 'logp');
fprintf('truth\n');
logp

[d, logp] = cvPcaDiffs(Y, U, Me, Lambda, 'nonorm', 'logp');
fprintf('DIFFS all\n');
logp

V = U(:,1:2);
[d, logp, DIFS, DFFS, logpDIFS, logpDFFS] = cvPcaDiffs(Y, V, Me, Lambda, 'nonorm', 'logp');
fprintf('DIFFS 2\n');
logp

V = U(:,1);
[d, logp, DIFS, DFFS, logpDIFS, logpDFFS] = cvPcaDiffs(Y, V, Me, Lambda, 'nonorm', 'logp');
fprintf('DIFFS 1\n');
logp

% logp =
% 
%    -5.4078   -2.5579   -0.4104
% 
% 
% logp =
% 
%    -5.3641   -2.5899   -0.4269
% 
% 
% logp =
% 
%    -5.3641   -2.5899   -0.4269
% 
% 
% logp =
% 
%    -2.9188   -2.5633   -0.4200

% 
% N = 20000;
% D = 20;
% Sigma = [20:-1:1]';
% X = randn(D,N) .* repmat(sqrt(Sigma), 1, N);
% [U, Me, Lambda] = cvPca(X);
% 
% Y = randn(D,8) .* repmat(sqrt(Sigma), 1, 8);
% 
% Mu = zeros(D,1);
% logp = cvGaussPdf(Y, Mu, diag(Sigma)) % truth
% 
% [d, logp] = cvPcaDiffs(Y, U, Me, Lambda);
% logp
% 
% V = U(:,1:floor(D/2));
% [d, logp, DIFS, DFFS, logpDIFS, logpDFFS] = cvPcaDiffs(Y, V, Me, Lambda);
% logp
% 
% V = U(:,1);
% [d, logp, DIFS, DFFS, logpDIFS, logpDFFS] = cvPcaDiffs(Y, V, Me, Lambda);
% logp
