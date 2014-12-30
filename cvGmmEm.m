function Gmm = cvGmmEm(X, K, independent, maxIteration, verbose)
% cvGmmEm - Train Gaussian Mixture Models (GMM) using EM algorithm.
%
% Synopsis
%   [Gmm] = cvGmmEm(X, K, [maxIteration], [verbose])
%
% Description
%   cvGmmEm trains Gaussian Mixture Models (GMM) using the Expectation
%   Maximization (EM) algorithm.
%
% Inputs ([]s are optional)
%   (matrix) X        D x N matrix representing feature vectors by columns
%                     where D is the number of dimensions and N is the
%                     number of vectors.
%   (scalar) K        The number of mixtures (clusters).
%   (bool)   [independent = 0]
%                     Set 1 when want to assume components are wise
%                     independent. 
%   (scalar) [maxIteration = 10]
%                     The maximum number of iterations of EM algorithm.
%   (bool)   [verbose = false]
%                     Show progress or not.
%
% Outputs ([]s are optional)
%   (struct) Gmm      The Gaussian Mixture Model (GMM)
%   - (vector) P      K x 1 vector representing the prior probabilities of
%                     K mixtures (proportion of number of feature vectors
%                     associated with the mixture.)
%   - (matrix) Mu     D x K array representing the mean vectors of
%                     K mixtures.
%   - (matrix) Sigma  D x D x K array representing the covariance matricies 
%                     of K mixtures.
%
% Examples
%   X = [1 0 -1
%        1 0 -1];
%   Gmm = cvGmmEm(X, 3);
%
% See also
%   cvGaussPdf, cvGmmPdf
%
% Requirements
%   kmeans.m (Statistics toolbox) or replace it with cvKmeans.m.
%   Note) cvKmeans(X, K) is kmeans(X.', K).

% References
%   [1] Xuedong Huang, et al. "Spoken Language Processing, "
%   Prentice Hall PTR, p170-175 and p525-527, 2001.
%
% Authors
%   Naotoshi Seo <sonots(at)sonots.com>
%
% License
%   The program is free to use for non-commercial academic purposes,
%   but for course works, you must understand what is going inside to use.
%   The program can be used, modified, or re-distributed for any purposes
%   if you or one of your group understand codes (the one must come to
%   court if court cases occur.) Please contact the authors if you are
%   interested in using the program without meeting the above conditions.
%
% Changes
%   04/01/2006  First Edition
if ~exist('independent', 'var') || isempty(independent)
    independent = 0;
end
if ~exist('maxIteration', 'var') || isempty(maxIteration)
    maxIteration = 10;
end
if ~exist('verbose', 'var') || isempty(verbose)
    verbose = false;
end

Gmm = cvGmmInit_(X, K, independent);
[D, N] = size(X);

%% EM algorithm
iteration = 1;
logSumLikelihood = sum(log(cvGmmPdf(X, Gmm)));
if verbose
    fprintf('Iteration 00: ');
    fprintf('log sum likelihood = %f\n', logSumLikelihood);
end
while 1
    %%% Expectation ---------------
    % Posterior denoted as gamma_k^i [1] p174 (4.103), 
    % equivalently, denoted as p(k|Xn) [1] p527 (10.140). 
    Posterior = zeros(K, N); 
    for k = 1:K
        Posterior(k,:) = Gmm.P(k) * cvGaussPdf(X, Gmm.Mu(:,k), Gmm.Sigma(:,:,k), 'normterm', false);
    end
    Posterior = Posterior ./ repmat(sum(Posterior), K, 1); % normalization
    % sum respect to N, denoted as gamma_k [1] p174 (4.104)
    gamma = sum(Posterior, 2); 

    %%% Maximization ---------------
    Gmm.P = gamma ./ N; % [1] p174 (4.106)
    for k = 1:K
        %% Update means [1] p175 (4.107)
        Gmm.Mu(:,k) = sum(repmat(Posterior(k,:), D, 1) .* X, 2) / gamma(k);
        
        %% Update covariance matrix [1] p175 (4.108)
        mat = zeros(D, D);
        for n = 1:N
            diff = X(:,n) - Gmm.Mu(:,k);
            mat = mat + (Posterior(k,n) * (diff * diff.'));
        end
        Gmm.Sigma(:,:,k) = mat / gamma(k);
        if independent
            Gmm.Sigma(:,:,k) = diag(diag(Gmm.Sigma(:,:,k)));
        end
    end

    %%% Stop criterion -----------
    oldLogSumLikelihood = logSumLikelihood;
    logSumLikelihood = sum(log(cvGmmPdf(X, Gmm)));
    if verbose
        fprintf('Iteration %02d: ', iteration);
        fprintf('log sum likelihood = %f (%g improved from previous iteration) \n',...
            logSumLikelihood, logSumLikelihood - oldLogSumLikelihood);
    end
    iteration = iteration + 1;
    if logSumLikelihood <= oldLogSumLikelihood || iteration > maxIteration
        break;
    end
end
end

function Gmm = cvGmmInit_(X, K, independent)
% cvGmmInit_ - Initialize GMMs by kmeans algorithm.
%
% Synopsis
%   [Pr] = cvGmmInit_(X, K)
%
% Description
%   This initializes GMMs by kmeans algorithm
%
% Inputs ([]s are optional)
%   (matrix) X        D x N matrix representing feature vectors by columns
%                     where D is the number of dimensions and N is the
%                     number of vectors.
%   (scalar) K        The number of mixtures (clusters).
%   (bool)   [independent = 0]
%                     Set 1 when want to assume components are wise
%                     independent. 
%
% Outputs ([]s are optional)
%   (struct) Gmm      The Gaussian Mixture Model (GMM)
%   - (vector) P      K x 1 vector representing the prior probabilities of
%                     K mixtures (proportion of number of feature vectors
%                     associated with the mixture.)
%   - (matrix) Mu     D x K array representing the mean vectors of
%                     K mixtures.
%   - (matrix) Sigma  D x D x K array representing the covariance matricies 
%                     of K mixtures.
%
% References
%   [1] Xuedong Huang, et al. "Spoken Language Processing, "
%   Prentice Hall PTR, p170-175 and p525-527, 2001.
%
% Authors
%   Naotoshi Seo <sonots(at)sonots.com>
%
% License
%   The program is free for non-commercial academic use. Please contact
%   the authors if you are interested in using the software for commercial
%   purposes. The software must not modified or re-distributed without
%   prior permission of the authors.

% Changes
%   04/01/2006  First Edition
if ~exist('independent', 'var') || isempty(independent)
    independent = 0;
end
[D, N] = size(X);
[ClusterId] = kmeans(X.', K);

Gmm.P = zeros(K, 1);
Gmm.Mu = zeros(D, K);
Gmm.Sigma = zeros(D, D, K);
for k = 1:K
    Cluster = find(ClusterId == k);
    Gmm.P(k) = length(Cluster) / N;
    Gmm.Mu(:,k) = mean(X(:,Cluster), 2);
    Gmm.Sigma(:,:,k) = cov(X(:,Cluster).');
    if independent
        Gmm.Sigma(:,:,k) = diag(diag(Gmm.Sigma(:,:,k)));
    end
end
end