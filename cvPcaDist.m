% cvPcaDist - Distance between a point to a PCA space
%
% Synopsis
%   [d p] = cvPcaDist(X, e, m, param)
%
% Description
%   This computes a distance between an euclidean point to a PCA space 
%   denoted by dH(x, pca). Let pca* be a point on pca space which has
%   a minimal distance to x. The pca* can be obtained by projecting x 
%   onto the pca space. That is, dH(x, pca) is dH(x, pca*). 
%   Let x* be a reconstructed point of pca* in the euclidean space. 
%   The dH(x, pca*) is the euclidean distance between x and x*, that is,
%   the reconstruction error. 
%
% Inputs ([]s are optional)
%   (matrix) X        D x N matrix representing feature vectors by columns
%                     where D is the number of dimensions and N is the
%                     number of vectors.
%   (matrix) e        D x M matrix representing the principal components
%                     (eigenvectors) where M is the number of components.
%   (vector) m        D x 1 vector representing the mean vector of X
%                     vectors.
%   (mixed)  param
%   1. (empty) []     (default) Residual reconstruction error (or distance
%                     from the PCA subspace) is returned. 
%   2. (scalar) sqsigma 
%                     A scalar representing variances
%                     of distribution of reconstruction errors. 
%                     Model likelihood probability by univariate Gaussian
%                     distribution on reconstruction errors.
%                     sqsigma is sigma^2 variance of reconstruction
%                     error estimated in training data. 
%   3. (vector) Lambda  
%                     A vector representing the eigenvalues respective to 
%                     the principal components axis (or variances in the 
%                     principle axis). DIFFS [1] method is used. 
%
% Outputs ([]s are optional)
%   (vector) d        1 x N vector representing distance between X(:,n) vs
%                     the pca space, or reconstruction error.
%   (vector) [p]      1 x N vector representing likelihood probability
%                     with respect to d.
%
% See also
%   cvPca, cvPcaProj, cvPcaInvProj, cvPcaDiffs
%   subspace (Angle Distance between PCA subspace vs PCA subspace)
%
% Requriements
%   cvEucdist, cvPcaLambdaFit

% References
%   [2] @INPROCEEDINGS{Moghaddam95probabilisticvisual,
%     author = {Baback Moghaddam and Alex Pentl},
%     title = {Probabilistic visual learning for object detection},
%     booktitle = {},
%     year = {1995},
%     pages = {786--793}
% }
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
%   10/09/2008  Add Likelihood measurement
%   05/01/2006  First Edition
function [d p] = cvPcaDist(X, e, m, varargin)
[D, N] = size(X); d = []; p = [];
[D, M] = size(e);
[Y, mX] = cvPcaProj(X, e, m);
% Y  = cvPcaProj(X, e, m);
% Xr = cvPcaInvProj(Y, e, m);
% d = sum((X - Xr).^2, 1);
d = cvEucdist(mX) - cvEucdist(Y); % faster way by L2 norm

if nargout > 1 && length(varargin) >= 1 % likelihood measurement
    if isscalar(varargin{1}) % simple modeling with univariate Gaussian
        sqsigma = varargin{1};
        % Estimate sqsigma as below in training data
        % [V Me] = cvPca(Xtrain, M);
        % d = cvPcaDist(Xtrain, V, Me); N = size(d, 2);
        % sqsigma = sum(d) / N; % or (N-1) unbiased est
        p = exp(-d/(2*sqsigma))/sqrt(2*pi*sqsigma);
    elseif isvector(varargin{1}) % DFFS [2]
        % modeling with multivariate isotorpic Gaussian of the same variance
        Lambda = varargin{1};
        nEig = length(Lambda);
        if nEig < D %% Do this beforehand
            Lambda = cvPcaLambdaFit(Lambda, D);
        end
        rLambda = Lambda(M+1:end); % eigenvalues from M+1
        row = mean(rLambda);
        p = exp(-d/(2*row))/((2*pi*row)^(length(rLambda)-M)/2);
    end
end