% cvMapGaussDemo - Demo of cvBayseDecisionGauss.m
function cvMapGaussDemo
Xp(:,1:4) = 10 + 2 * randn(2,4);
Xp(:,5:8) = 20 + 4 * randn(2,4);
Cp = [1 1 1 1 2 2 2 2];

% Label = unique(Cp);
% nClass = length(Label);
% [D, P] = size(Xp);
% for i=1:nClass
%     Xi = Xp(:, Cp == i);
%     ni = length(Xi);
%     Prior(i) = ni / P;
%     [Mu(:,i) Sigma(:,:,i)] = cvMeanCov(Xi);
% end
Prior = [1/2 1/2];
Mu = [10 20
      10 20];
Sigma(:,:,1) = 4 * eye(2);
Sigma(:,:,2) = 16 * eye(2);

[Class g] = cvMapGauss(Xp, Mu, Sigma, Prior);
%[Class g W w w0] = cvMapGauss(Xp, Mu, Sigma, Prior);
% g
% W
% w
% w0
% Class
Class == Cp
%%%% hmmm, does not return 1 1 1 1 1 1 1 1 1 1 1 ....