% cvPca - Principal Component Analysis
%
% Synopsis
%   [e, m, lambda] = cvPca(X, [M])
%
% Description
%   Principal Component Analysis
%
% Inputs ([]s are optional)
%   (matrix) X        D x N matrix representing feature vectors by columns
%                     where D is the number of dimensions and N is the
%                     number of vectors.
%   (scalar) [M]      Specify if you want to reduce dimensions of projected
%                     vectors into M. max M = min(N-1, D)
%                     Or, you can reduce later as e = e(:,1:M);
%
% Outputs ([]s are optional)
%   (matrix) e        D x M matrix representing the principal component
%                     axis (eigenvectors) where M is the number of components.
%                     e(:,i) is denoted as e_i in [1] chap 3.8.1 (89)
%   (vector) m        D x 1 vector representing the mean vector of X vectors.
%   (vector) [lambda] min(N-1,D) x 1 vector representing the first min(N-1,D)
%                     eigenvalues (or variances in the principle axis). 
%                     Biased (1/N) estimator of variances (squared) respective
%                     to the eigenvector axis. 
%                     Tips: diag(lambda) gives a diagonal matrix form. 
%   (scalar) [sqsigma]
%                     Variances of distribution of reconstruction errors
%                     which would be used by cvPcaDist.m
%
% Examples
%   See demo/cvPcaDemo.m
%
% See also
%   cvPcaProj, cvPcaInvProj, princomp (statistics toolbox). 
%   >> [e, Y, lambda] = princomp(X.', 'econ'); Y = Y.';
%   princomp does not return m, and its lambda is unbiased estimator (1/(N-1))

% References
%   [1] R. O. Duda, P. E. Hart, and D. G. Stork, "Chapter 3.8.1. Principal
%   Component Analysis," Pattern Classification, John Wiley & Sons, 2nd ed.,
%   2001.
%   [2] Shakhnarovich, B. Moghaddam, Face Recognition in Subspaces, Handbook
%   of Face Recognition, Eds. Stan Z. Li and Anil K. Jain, Springer-Verlag,
%   December 2004, p142-144 (Available online)
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
%   05/01/2006  First Edition
function [e m lambda, sqsigma] = cvPca(X, M)
[D, N] = size(X);
if ~exist('M', 'var') || isempty(M) || M == 0
    M = D;
end
M = min(M,min(D,N-1));

%% mean subtraction
m = mean(X, 2);
X = X - repmat(m, 1, N);

%% singular value decomposition. X = U*S*V.' or X.' = V*S*U.'
[U S V] = svd(X,'econ');
e = U(:,1:M);
if nargout > 2
    s = diag(S);
    s = s(1:min(D,N-1));
    lambda = s.^2 / N; % biased (1/N) estimator of variances
end
% lambda(N) is always 0 because of mean subtraction and intuitively because
% only N-1 principal axis can be obtained from N samples
% %% Eigen value decomposition version
% [e, S] = eig(cov(X.')); % cov does unbiased estimator 1/(N-1)
% [s,inx] = sort(diag(S),1,'descend');
% e = e(:,inx(1:M));
% lambda = s(1:min(D,N-1)) .* ((N-1)/N);

% sqsigma. Used to model distribution of errors by univariate Gaussian
if nargout > 3
    d = cvPcaDist(X, e, m); % Use of validation set would be better
    N = size(d,2);
    sqsigma = sum(d) / N; % or (N-1) unbiased est
end
end
