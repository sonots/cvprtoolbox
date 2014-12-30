% cvPfa - Principal Feature Analysis (Feature Selection)
%
% Synopsis
%   [IDX, Me] = cvPfa(X, [p], [q])
%
% Description
%   Principal Feature Analysis (Feature Selection)
%
% Inputs ([]s are optional)
%   (matrix) X        D x N matrix representing feature vectors by columns
%                     where D is the number of dimensions and N is the
%                     number of vectors.
%   (scalar) [p = min(D,N-1)]
%                     Number of features to select. If D, nothing is done.
%   (scalar) [q = p-1]  
%                     Number of deimensions reduced in PCA step.
%                     Usually p > q. Typically p > q + 1..5 [1]
%
% Outputs ([]s are optional)
%   (vector) IDX      The D x 1 binary mask vector which p 1's represent 
%                     features to select. Hint: X(IDX,:)
%   (vector) [Me]     The output of PCA. Hint: Me(IDX)
%                     D x 1 vector representing the mean vector of X vectors.

% References
%   [1] @MISC{Cohen02featureselection,
%     author = {Ira Cohen and Qi Tian and Xiang Sean and Zhou Thomas and S. Huang},
%     title = {Feature selection using principal feature analysis},
%     year = {2002}
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
%   12/20/2008  First Edition
function [IDX, Me] = cvPfa(X, p, q)
[D, N] = size(X);
if ~exist('p', 'var') || isempty(p) || p == 0
    p = D;
end
p = min(p, min(D, N-1));
if ~exist('q', 'var') || isempty(q)
    q = p - 1;
end

%% PCA step
[U Me, Lambda] = cvPca(X, q);

%% cluter row vectors (q x D). not col
[Cl, Mu] = kmeans(U, p, 'emptyaction', 'singleton', 'distance', 'sqEuclidean');

%% find axis which are nearest to mean vector
IDX = logical(zeros(D,1));
for i = 1:p
    Cli = find(Cl == i);
    d = cvEucdist(Mu(i,:).', U(Cli,:).');
    [mini, argmin] = min(d);
    IDX(Cli(argmin)) = 1;
end
