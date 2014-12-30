% cvCspca - Class-Specific PCA Subspace Model
%
% Synopsis
%   [U Me Lambda [sqsigma]] = cvCspca(X, M)
%
% Description
%    Specific Class PCA Subspace Model. 
%
% Inputs ([]s are optional)
%   (cell)   X        c cell of D x Ni feature vectors where c is the
%                     number of classes and D is the number of dimensions
%                     and Ni, i = 1..c is the number of samples
%   (scalar) [M]      Specify if you want to reduce dimensions of projected
%                     vectors into M. max M = min(N-1, D)
%                     Or, you can reduce later as e = e(:,1:M);
%
% Outputs ([]s are optional)
%   (cell)   U         c cell array containing D x M principle component 
%                      axes for each class where M = min(M, min(D, Ni-1))
%   (cell)   Me        c cell array containing a D x 1 mean vector for 
%                      each class
%   (cell)   Lambda    c cell array containing eigenvalues
%   (cell)   [sqsigma] c cell array containing variances of distribution
%                      of reconstruction errors
%
% See also
%   cvCspcaClassifi
%
% Uses
%   cvPca, cvPcaDist

% References
%   [1] Shan, S.G.[Shi-Guang], Gao, W.[Wen], Zhao, D.B.[De-Bin],
%   Face recognition based on face-specific subspace,
%   IJIST(13), No. 1, 2003, pp. 23-32. 
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
%   10/09/2008  First Edition
function [U Me Lambda sqsigma] = cvCspca(X, M)
if ~exist('M', 'var'), M = []; end;
nClass = length(X);
U = cell(1,nClass); Me = cell(1,nClass); Lambda = cell(1,nClass);
for i = 1:nClass
    [U{i} Me{i} Lambda{i}] = cvPca(X{i}, M);
end
% sqsigma. Used to model distribution of errors by univariate Gaussian
if nargout > 3
    sqsigma = cell(1,nClass);
    for c = 1:nClass
        d = cvPcaDist(X{c}, U{c}, Me{c}); % Use of validation set would be better
        N = size(d,2);
        sqsigma{c} = sum(d) / N; % or (N-1) unbiased est
    end
end
end