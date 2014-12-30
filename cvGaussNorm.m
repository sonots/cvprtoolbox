function [X, Mu, Sigma] = cvGaussNorm(X, diagonal)
% cvGaussNorm - Zero mean and unit covariance normalization
%
% Synopsis
%   X = cvGaussNorm(X, diag)
%
% Description
%   Zero mean and unit covariance normalization
%
% Inputs ([]s are optional)
%   (array)  X        D x N array where N is number of samples
%   (bool)   [diagonal = true]
%                     Use only diagonal components of Covariance
%                     matrix
%
% Outputs ([]s are optional)
%   (array)  X        Normalized array
%   (array)  [Mu]     D x 1 mean vector
%   (array)  [Sigma]  D x D covariance matrix
%
% Example
%  demo/cvGaussNormDemo.m

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
if ~exist('diagonal', 'var') || isempty(diagonal)
    diagonal = 1;
end
[D, N] = size(X);
[Mu, Sigma] = cvMeanCov(X, 'biased');
if diagonal
    Sigma = diag(diag(Sigma));
end
X = X - repmat(Mu, 1, N);
InvSigma = inv(Sigma);
if find(InvSigma == Inf)
    X = Inf * ones(D, N);
else
    X = sqrtm(inv(Sigma)) * X;
end
end
