function [Cluster Codebook] = cvKmeans(X, K, stopIter, distFunc, verbose)
% cvKmeans - K-means clustering
%
% Synopsis
%   [Cluster Codebook] = cvKmeans(X, K, [stopIter], [distFunc], [verbose])
%
% Description
%   K-means clustering
%
% Inputs ([]s are optional)
%   (matrix) X        D x N matrix representing feature vectors by columns
%                     where D is the number of dimensions and N is the
%                     number of vectors.
%   (scalar) K        The number of clusters.
%   (scalar) [stopIter = .05]
%                     A scalar between [0, 1]. Stop iterations if the
%                     improved rate is less than this threshold value.
%   (func)   [distFunc = @cvEucdist]
%                     A function handle for distance measure. The function
%                     must have two arguments for matrix X and Y. See
%                     cvEucdist.m (Euclidean distance) as a reference.
%   (bool)   [verbose = false]
%                     Show progress or not.
%
% Outputs ([]s are optional)
%   (vector) Cluster  1 x N vector cntaining intergers indicating the
%                     cluster indicies. Cluster(n) is the cluster id for
%                     X(:,n).
%   (matrix) Codebook D x K matrix representing cluster centroids (means)
%                     or VQ codewords (codebook)
%
% Examples
%   See also demo/cvKmeansDemo.m, cvKmeansDemoVQ.m, cvKmeansDemoClassifi.m
%
%   X = rand(2, 10); % 2-dimensional vectors
%   [Cluster, Mu] = cvKmeans(X, 2);
%   % Use kmeans.m in practice that equivalent codes are as
%   [Cluster, Mu] = kmeans(X.', 2);
%   Cluster = Cluster.'; Mu = Mu.';
%   XCluster(:,:,1) = X(:, Cluster == 1);
%
% See also
%   cvAutolabel, cvEucdist, kmeans (Statistics Toolbox)

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
if ~exist('stopIter', 'var') || isempty(stopIter)
    stopIter = .05;
end
if ~exist('distFunc', 'var') || isempty(distFunc)
    distFunc = @cvEucdist;
end
if ~exist('verbose', 'var') || isempty(verbose)
    verbose = false;
end
[D N] = size(X);
if K > N,
    error('K must be less than or equal to the number of vectors N');
end

% Initial centroids
Codebook = X(:, randsample(N, K));

improvedRatio = Inf;
distortion = Inf;
iter = 0;
while true
    % Calculate euclidean distances between each sample and each centroid
    d = distFunc(Codebook, X);
    % Assign each sample to the nearest codeword (centroid)
    [dataNearClusterDist, Cluster] = min(d, [], 1);
    % distortion. If centroids are unchanged, distortion is also unchanged.
    % smaller distortion is better
    old_distortion = distortion;
    distortion = mean(dataNearClusterDist);

    % If no more improved, break;
    improvedRatio = 1 - (distortion / old_distortion);
    if verbose
        fprintf('%d: improved ratio = %f\n', iter, improvedRatio);
    end
    iter = iter + 1;
    if improvedRatio <= stopIter, break, end;

    % Renew Codebook
    for i=1:K
        % Get the id of samples which were clusterd into cluster i.
        idx = find(Cluster == i);
        % Calculate centroid of each cluter, and replace Codebook
        Codebook(:, i) = mean(X(:, idx),2);
    end
end