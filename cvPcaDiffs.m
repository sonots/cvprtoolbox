% cvPcaDiffs - Distance "in" and "from" feature space [1]
%
% Synopsis
%   [d, p] = cvPcaDiffs(X, U, Me, Lambda, normalize, logprob, lambdapad)
%
% Description
%   This computes a distance between a point to a PCA subspace as sum of
%   distance-from-feature space (DFFS) and distance-in-feature-space
%   (DIFS). The DFFS is essentially a reconstruction error and the
%   DIFS measures (mahalanobis) distance between projected point and 
%   origin of PCA subpsace. DFFS and DIFS can be used to measure 
%   approximated likelihood Gaussian density distribution. 
%   See [1] for more details. 
%
% Inputs ([]s are optional)
%   (matrix) X        D x N matrix representing feature vectors by columns
%                     where D is the number of dimensions and N is the
%                     number of vectors.
%   (matrix) U        D x M matrix representing the principal components
%                     (eigenvectors) where M is the number of components.
%   (vector) Me       D x 1 vector representing the mean vector of X
%                     vectors.
%   (vector) Lambda   min(NT-1,D) x 1 vector representing the eigenvalues
%                     respective to the principal components axis
%                     (or variances in the principle axis) where NT is the
%                     number of training samples. 
%   (enum)   [normalize = 'normterm']
%                     0 or 'nonorm' 
%                       - Do not apply the normalization term
%                     1 or 'normterm'
%                       - Apply the normalization term
%                         (/ ((2*pi)^(D/2) * sqrt|Sigma|) )
%                     2 or 'normsum'
%                       - Normalize so that prob sum bocomes 1
%   (enum)   [logprob = 0]
%                     0 - Return probabilities
%                     1 or 'logp' - Return log probabilities
%   (enum)   [lambdapad = 0]
%                     0 - Do nothing
%                     1 - Zero padding when NT-1 < D so that Lambda to be D x 1
%                     2 - Lambda is padded by power law curve fitting when
%                         to be D x 1 when NT-1 < D. 
%                     This padding should be done beforehand once when you
%                     repeatedly use. Use cvPcaLambdaFit.m. Refer [2]
%
% Outputs ([]s are optional)
%   (vector) d        1 x N vector representing distance between X(:,n) vs
%                     the pca space.
%   (vector) p        1 x N vector representing estimated likelihood 
%                     Gaussian density p(x|PCA). The Gaussian is a 
%                     continuous densitiy function so it may have a value 
%                     more than 1.0. Do normalization later. 
%
% See also
%   cvPca, cvPcaProj, cvPcaInvProj, cvPcaDist, cvPcaLambdaFit

% References
%   [1] @INPROCEEDINGS{Moghaddam95probabilisticvisual,
%     author = {Baback Moghaddam and Alex Pentl},
%     title = {Probabilistic visual learning for object detection},
%     booktitle = {},
%     year = {1995},
%     pages = {786--793}
%   }
%   [2] @ARTICLE{Moghaddam02principalmanifolds,
%     author = {Baback Moghaddam},
%     title = {Principal manifolds and probabilistic subspaces for visual recognition},
%     journal = {IEEE Transactions on Pattern Analysis and Machine Intelligence},
%     year = {2002},
%     volume = {24},
%     pages = {780--788}
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
%   10/05/2008  First Edition
function [d, p, DIFS, DFFS, pDIFS, pDFFS, rho, nEig, Lambda] = cvPcaDiffs(X, U, Me, Lambda, normalize, logprob, lambdapad)
if ~exist('normalize', 'var') || isempty(normalize)
    normalize = 'normterm';
end
if ~exist('logprob', 'var') || isempty(logprob)
    logprob = false;
end
if ~exist('lambdapad', 'var') || isempty(lambdapad)
    lambdapad = 0;
end;
[D, N] = size(X);
[D, M] = size(U);
[Y X_t] = cvPcaProj(X, U, Me); % X_t: mean subtracted X

nEig = length(Lambda);
if lambdapad == 0
    % no padding
elseif lambdapad == 1 && nEig < D
    Lambda(end+1:D) = 0;
elseif lambdapad == 2 && nEig < D
    Lambda = cvPcaLambdaFit(Lambda, D);
end

%% distance in feature space
if M > 0
    pLambda = Lambda(1:M);
    sqrt_pLambda = sqrt(pLambda);
    DIFS = cvEucdist(Y ./ repmat(sqrt_pLambda(:), 1, size(Y,2))); % [1] (7) left 
    pDIFS = -DIFS/2;
    if strcmp(normalize, 'normterm') | normalize == 1
        normterm = log(2*pi)*(M/2) + sum(log(sqrt_pLambda));
        pDIFS = pDIFS - normterm; % [1] (8) left
    end
else
    DIFS = zeros(1,N);
    pDIFS = zeros(1,N);
end

%% distance from feature space
if nEig > M
    rLambda = Lambda(M+1:end);
    DFFS = cvEucdist(X_t) - cvEucdist(Y); % reconstruction error [1] (2)
    rho = mean(rLambda); % [1] (11)
    DFFS = DFFS ./ rho; % [1] (7) right term
    pDFFS = -DFFS/2;
    if strcmp(normalize, 'normterm') | normalize == 1
        normterm = log(2*pi*rho) * (length(rLambda)/2);
        pDFFS = pDFFS - normterm; % [1] (8) right
    end
else
    DFFS = zeros(1,N);
    pDFFS = zeros(1,N);
end

%% total distance
d = DIFS + DFFS; % [1] (7)
p = pDIFS + pDFFS; % [1] (8) log
if strcmp(normalize, 'normsum') | normalize == 2
    p = p - max(p); % pre-normalization to avoid probs being all zero
    % by taking exp because of precision limit (necessary especially in C)
    p = p - log(sum(exp(p)));
end

if ~logprob, p = exp(p); end;
if ~logprob & nargout > 4
    pDIFS = exp(pDIFS);
    pDFFS = exp(pDFFS);
end;