function Gmm = cvGmm(P, Mu, Sigma)
% cvGmm - Construct a GMM structure
%
% Synopsis
%   [Gmm] = cvGmm(P, Mu, Sigma)
%
% Description
%   cvGmm is a helper function to construct GMM structure.
%   Because a structure forces you use pre-defined field names unlike
%   function's input arguments, you may have to construct the structure
%   using several code lines.
%   You can write it in one line using this function. See EXAMPLE.
%
% Inputs ([]s are optional)
%   (vector) P        K x 1 vector representing the prior probabilities of
%                     K mixtures (proportion of number of feature vectors
%                     associated with the mixture.)
%   (matrix) Mu       D x K array representing the mean vectors of
%                     K mixtures.
%   (matrix) Sigma    D x D x K array representing the covariance matricies
%                     of K mixtures.
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
%   Gmm.P     = c;
%   Gmm.Mu    = means;
%   Gmm.Sigma = cov;
%   % can be written as
%   Gmm = cvGmm(c, means, cov);

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
Gmm.P     = P;
Gmm.Mu    = Mu;
Gmm.Sigma = Sigma;