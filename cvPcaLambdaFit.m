% cvPcaLambdaFit - Pad trailing eigenvalues by power law curve fitting
%
% Synopsis
%   Lambda = cvPcaLambdaFit(Lambda, D)
%
% Description
%   Pad trailing eigenvalues by power law curve fitting
%
% Inputs ([]s are optional)
%   (vector) Lambda   N-1 x 1 vector representing the first N-1
%                     eigenvalues (or variances in the principle axis)
%                     where N is the number of training samples and 
%                     N-1 < D.
%   (scalar) D        The number of dimension of feature vectors. 
%
% Outputs ([]s are optional)
%   (vector) Lambda   D x 1 vector representing the D eigenvalues
%                     padded by power law curve fitting
%
% See also
%   cvPca, cvPcaDiffs

% References
%   [1] @ARTICLE{Moghaddam02principalmanifolds,
%     author = {Baback Moghaddam},
%     title = {Principal manifolds and probabilistic subspaces for visual recognition},
%     journal = {IEEE Transactions on Pattern Analysis and Machine Intelligence},
%     year = {2002},
%     volume = {24},
%     pages = {780--788}
% }
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
%   11/14/2008  First Edition
function Lambda = cvPcaLambdaFit(Lambda, D)
nEig = length(Lambda);
% found that using only latter half models trailing parts better
ydata = Lambda(ceil(nEig/2):end);
xdata = ceil(nEig/2):nEig;
p = cvuPowerlawFit(xdata, ydata);
Lambda(nEig+1:D) = p(1).*(nEig+1:D).^p(2);
end
