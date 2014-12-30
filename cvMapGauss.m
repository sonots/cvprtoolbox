function [Class g] = cvMapGauss(X, Mu, Sigma, P)
% cvMapGauss - Bayesian Decision for multi-class Multivariate Gaussian case
%
% Synopsis
%   [Class, g] = cvMapGauss(X, Mu, Sigma, P)
%
% Description
%   Bayesian decision or MAP (Maximum a posteriori) decision
%   in the multivariate Gaussian case for multi-class classification
%   problem. 
%
% Inputs ([]s are optional)
%   (matrix) X        D x N matrix representing column classifiee vectors
%                     where D is the number of dimensions and N is the
%                     number of vectors.
%   (matrix) Mu       D x K array representing the mean vectors of
%                     K classes.
%   (matrix) Sigma    D x D x K array representing the covariance matricies
%                     of K classes.
%   (vector) [P = uniform]
%                     K x 1 vector representing the prior probabilities for
%                     K classes. 
%                     (proportion of number of feature vectors associated 
%                     with the class cluster.)
%                     The default assigns as uniformly distributed. 
%                     MAP works as Maximum Likelihood decision in the case.  
%
% Outputs ([]s are optional)
%   (vector) Class    1 x N vector containing intergers indicating the
%                     class labels for X. Class(n) is the class id for
%                     X(:,n).
%   (matrix) [g]      K x N matrix containing returned values by
%                     discriminant functions. 
%   (matrix) [W]      D x D x K array used for discriminant functions. 
%   (matrix) [w]      D x K array used for discriminant functions
%   (vector) [w0]     K x 1 vector used for discriminant functions
%
%                     Discriminant function is as
%                       argmax_i gi(x) = x'W(i)x + w(i)'x + w0(i)
%
% Example
%   demo/cvMapGaussDemo.m
%
% See also
%   cvMeanCov

% References
%   [1] R. O. Duda, P. E. Hart, and D. G. Stork, "Chapter 2.1. Bayes
%   Decision Theory," Pattern Classification, John Wiley & Sons, 2nd ed.,
%   2001.
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
%   11/01/2007  First Edition
[D, N] = size(X);
K = size(Mu, 2);
if ~exist('P', 'var') || isempty(P)
    P = ones(K,1) ./ K;
end
%ClassLabel = 1:length(P);

%% Log posterior probability without normalization term
for i = 1:K
    g(i,:) = cvGaussPdf(X, Mu(:,i), Sigma(:,:,i), 'nonorm', 'logp') + log(P(i));
end

%% Discriminant function is formed as 2nd order func for Gaussian case [1]
%% ToDo: Fix me! What's wrong?
% W = []; w = []; w0 = []; g = [];
% for i = 1:K
%     InvSigma = inv(Sigma(:,:,i));
%     W(:,:,i) = -0.5 * InvSigma; %% [1] (67)
%     w(:,i) = InvSigma * Mu(:,i); %% [1] (68)
%     w0(i) = -0.5 * Mu(:,i).' * InvSigma * Mu(:,i) ...
%         - 0.5 * log(det(Sigma(:,:,i))) + log(P(i)); %% [1] (69)
% end
% W = W * -0.5;
% for n = 1:N
%     for i = 1:K
%         g(i,n) = -0.5 * X(:,n).' * W(:,:,i) * X(:,n);...
%             + w(:,i).' * X(:,n) + w0(i); %% [1] (66)
%     end
% end

%% MAP
[maxi, Class] = max(g, [], 1);
%Class = ClassLabel(Class);