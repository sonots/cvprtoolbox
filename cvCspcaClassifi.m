% cvCspcaClassifi - Classificaion using Class-Specific PCA subspace
%
% Synopsis
%   [C, Rank, p] = cvCspcaClassifi(X, U, Me, param)
%
% Description
%    Classificaion using Class-Specific PCA subspace
%
% Inputs ([]s are optional)
%   (matrix) X        D x N feature vectors where D is the number of 
%                     dimensions and N is the number of samples
%   (cell)   U        c cell array containing D x Mi principle component
%                     axes for each class where Mi = min(D, M, Ni)
%   (cell)   Me       c cell array containing a D x 1 mean vector for
%                     each class
%   (mixed)  param
%   1. (empty) []     residual reconstruction error (or distance
%                     from the PCA subspace) is used to measure
%                     disimilarity. Output p returns values of
%                     reconstruction errors * -1. 
%   2. (cell) sqsigma c cell array of scalars representing variances
%                     of distribution of reconstruction errors. 
%                     Model likelihood probability by univariate Gaussian
%                     distribution on reconstruction errors.
%                     sqsigma is sigma^2 variance of reconstruction
%                     error estimated in training data. 
%   3. (cell) Lambda  c cell array of vectors representing 
%                     the eigenvalues respective to the principal
%                     components axis (or variances in the principle axis).
%                     DIFFS [1] method is used. 
%
% Outputs ([]s are optional)
%   (vector) C        1 x N vector representing classification result
%   (matrix) Rank     c x N matrix representing classification ranking
%                     Rank(1,:) is the top one, Rank(2,:) is the 2nd.
%   (matrix) p        c x N matrix representing likelihood measures
%
% See also
%   cvCspca
%
% Uses
%   cvPcaDist, cvPcaDiffs

% References
%   [1] @INPROCEEDINGS{Moghaddam95probabilisticvisual,
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
%   10/09/2008  First Edition
function [C, Rank, p] = cvCspcaClassifi(X, U, Me, param)
nClass = length(U);
[D, N] = size(X);
d = zeros(nClass,N); p = zeros(nClass,N);
for c = 1:nClass
    if ~exist('param', 'var') % reconstruction error
        d(c,:) = cvPcaDist(X, U{c}, Me{c});
        p(c,:) = - d(c,:); % just to change min -> max
    elseif isscalar(param{1}) % probabilistic reconstruction error
        [d(c,:) p(c,:)] = cvPcaDist(X, U{c}, Me{c}, param{c});
    elseif isvector(param{1}) % DIFFS
        [d(c,:) p(c,:)] = cvPcaDiffs(X, U{c}, Me{c}, param{c}, 'nonorm', 'logp');
    end
end
[maxp, C] = max(p, [], 1);
if nargout >= 2
    [sortedp, Rank] = sort(p, 1, 'descend');
end
end