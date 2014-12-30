function [Pdf] = cvGmmPdf(X, Gmm)
% cvGmmPdf - Probability Density Function of Mixtures of Gaussian
%
% Synopsis
%   [Pdf] = cvGmmPdf(X, Gmm)
%
% Description
%   Get the Probability Densitity Function (PDF) of Mixtures of Gaussain
%   (weighted linear combination of Gaussian PDF). 
%
% Inputs ([]s are optional)
%   (matrix) X        D x N matrix representing feature vectors by columns
%                     where D is the number of dimensions and N is the
%                     number of vectors.
%   (struct) Gmm      The Gaussian Mixture Model (GMM)
%   - (vector) P      K x 1 vector representing the weights of K mixtures
%                     (prior probabilities or proportion of number of 
%                     feature vectors associated with the mixture.)
%   - (matrix) Mu     D x K array representing the mean vectors of
%                     K mixtures.
%   - (matrix) Sigma  D x D x K array representing the covariance matricies of
%                     K mixtures.
%
% Outputs ([]s are optional)
%   (vector) Pdf
%                     1 x N vector representing the likelihood probabilities.
%
% EXAMPLE
%   X = [-2 -1 1 2
%       -2 -1 1 2];
%   % number of mixtures is 2
%   Gmm.P = [1/3
%       2/3];
%   Gmm.Mu    = [-1.5 1.5
%       -1.5 1.5];
%   Gmm.Sigma = [];
%   Gmm.Sigma(:,:,1) = [1 0
%       0 1];
%   Gmm.Sigma(:,:,2) = [1 0
%       0 1];
%   [Pdf] = cvGmmPdf(X, Gmm)
%
% See also
%   cvGaussPdf, cvGmmEm

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
[D N] = size(X);
K = length(Gmm.P);

% [1] p173 (4.99), equivalently, p527 (10.140)
PdfMixture = zeros(K, N);
for k = 1:K
    PdfMixture(k,:) = cvGaussPdf(X, Gmm.Mu(:,k), Gmm.Sigma(:,:,k), 'normterm', false);
end
Pdf = sum(repmat(Gmm.P, 1, N) .* PdfMixture, 1);
end
