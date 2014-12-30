function [Mu, Sigma] = cvMeanCov(X, bias)
% cvMeanCov - Compute mean and covariance (variance for 1-D)
%
% Synopsis
%   [Mu, Sigma] = cvMeanCov(X, [bias])
%
% Description
%   Compute mean and covariance (variance for 1-D)
%
% Inputs ([]s are optional)
%   (matrix) X        D x N matrix representing column training vectors
%                     where D is the number of dimensions and N is the
%                     number of vectors.
%   (string) [bias = 'unbiased']
%                     'biased' covariance (1/N) or 
%                     'unbiased' covariance (1/(N-1)).
%
% Outputs ([]s are optional)
%   (vector) Mu       D x 1 vector containing estimated means
%   (matrix) Sigma    D x D matrix containing covariance matrix
%                     Note that for D = 1 (univariate) also, variance
%                     is returned (not standard deviation which is the
%                     sqrt version of variance). 

% References
%   [1] R. O. Duda, P. E. Hart, and D. G. Stork, "Chapter 2. Bayes
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
if ~exist('bias', 'var') || isempty(bias)
    bias = 'unbiased';
end
[D, N] = size(X);
Mu = mean(X, 2);
Sigma = cov(X.'); % cov gives unbiased 1/(N-1)
if strcmp(bias, 'biased') && N > 1
    Sigma = Sigma .* ((N-1) / N);
end
end
