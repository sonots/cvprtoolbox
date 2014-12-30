function [Class x0] = cvBayesDecision1DGauss(X, mu, sigma, prior)
% cvBayesDecision1DGauss - Bayesian Decision for 2-class 1D Gaussian case
%
% Synopsis
%   [Class, x0] = cvBayesDecision1DGauss(X, mu, sigma, prior)
%
% Description
%   This detects bayesian decision boundary (threshold) analytically
%   for 2-class classification problem under assumption that 
%   data in each class is distributed on 1D Gaussian. 
%
% Inputs ([]s are optional)
%   (matrix) X        D x N matrix representing column classifiee vectors
%                     where D is the number of dimensions and N is the
%                     number of vectors.
%   (vector) mu       2 x 1 vector representing mean values for
%                     class 1 and class 2 respectively. 
%   (vector) sigma    2 x 1 vector representing sigma vaules for
%                     class 1 and class 2 respectively. 
%   (vector) [prior = [.5 .5]']
%                     2 x 1 vector representing prior probabilities for
%                     class 1 and class 2 respectively. The default
%                     assumes uniformly distributed, thus MAP becomes
%                     Maximum Likelihood decision. 
%
% Outputs ([]s are optional)
%   (vector) Class    1 x N vector containing intergers indicating the
%                     class labels for X. Class(n) is the class id for
%                     X(:,n).
%   (vector) x0       1 x 3 vector containing decision boundary where
%                     x0(1) < x < x0(2) for class x0(3).
%
% Example
%   demo/cvBayesDecision1DGaussDemo
%
% See also
%   cvMeanCov         Use to get mu and sigma. 
%   cvMapGauss        This gives the same classification result, but this
%                     does not tell you boundary thresholds.

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
if ~exist('prior', 'var') || isempty(prior)
    prior = [.5 .5]';
end
ClassLabel = [1 2];
% Boundary equation for 2-Class 1D Gaussian Case (Obtained from Mathematica)
b = mu(1)*sigma(2)-mu(2)*sigma(1);
denom = sigma(1)-sigma(2);
d = sigma(1)*sigma(2)*((mu(1)-mu(2))^2+ 2*(sigma(2)-sigma(1))*...
    log( (prior(1)*sqrt(sigma(2)))/(prior(2)*sqrt(sigma(1)))));
x0(1) = (-b - sqrt(d)) / denom;
x0(2) = (-b + sqrt(d)) / denom;
x0 = sort(x0);
if sigma(2) < sigma(1)
    x0(3) = ClassLabel(2); % w2 if x0(1) < X < x0(2)
else
    x0(3) = ClassLabel(1); % w1 if x0(1) < X < x0(2)
end
% Classification
Class = (x0(1) < X) & (X < x0(2));
Class = uint8(Class);
if x0(3) == ClassLabel(2)
    Class = Class + 1; % 0 1 => 1 2
else
    Class(Class == 0) = 2; % 1 0 => 1 2
end
Class = ClassLabel(Class);
end
