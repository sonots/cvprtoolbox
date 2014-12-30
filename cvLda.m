function [W] = cvLda(X, C, M)
% cvLda - Fisher's Linear Discriminant Analysis (FLDA or LDA)
%
% Synopsis
%   [W] = cvLda(X, C, [M])
%
% Description
%   Fisher's Linear Discriminant Analysis (FLDA or LDA)
%
% Inputs ([]s are optional)
%   (matrix) X        D x N matrix representing feature vectors by columns
%                     where D is the number of dimensions and N is the
%                     number of vectors.
%   (vector) C        1 x N vector containing class labels (1,2,...,c).
%   (scalar) [M]      Specify the deminsion of projected space. 
%                       max M = (if N-1 < D, N-1, else D)
%                     Or, you can reduce later as W = W(:,1:M);
%                     You may use M = 1 to construct a good linear 
%                     classifier function rather than dimensionality
%                     reduction purpose [1] (107).
%                     In case that you can assume p(X|Ci) are multivariate 
%                     Gaussian with equal covariance matrices, you can 
%                     obtain a good threshold value analytically. Refer [1]
%                     (62). Furthermore, in case that you can assume the
%                     projected data p(y|Ci) are distributed on 1D Gaussian, 
%                     cvBayesDecision1DGauss.m is available to find a good
%                     threhold value. 
%                     Otherwise, use any machine learning method which 
%                     gives the best threshold for your classification task. 
%
% Outputs ([]s are optional)
%   (matrix) W        D x M matrix representing the LDA components (vectors)
%                     where M is the number of components. [1] (118)
%
% Examples
%   See demo/cvLdaDemo.m
%
% See also
%   cvLdaProj, cvLdaInvProj, classify (statistics toolbox)

% References
%   [1] R. O. Duda, P. E. Hart, and D. G. Stork, "Chapter 3.8.2. Fisher's
%   Linear Discriminant Analysis," Pattern Classification,
%   John Wiley & Sons, 2nd ed., 2001.
%   [2] P. N. Belhumeur, J. P. Hespanha, and D. J. Kriegman, “Eigenfaces
%   vs. fisherfaces: recognition using class specific linear projection,”
%   IEEE Transactions on Pattern Analysis and Machine Intelligence, vol. 19,
%   no. 7, pp. 711-720, July 1997.
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
%   12/01/2007  First Edition
[D, N] = size(X);
if ~exist('M', 'var') || isempty(M)
    M = D;
end
if M > D, M = D;, end;
if N < M, M = N;, end; % N:end are certainly all zero.

ClassLabel = unique(C); % Find all class labels
c = length(ClassLabel); % c denotes number of classes

if D > N-c
    % When D > N-c, almost always Sw is singular
    % Project into (N-c) by (N-c) subspace using PCA
    % to assure Sw is nonsingular [2]
    [Wpca, me] = cvPca(X, N-c);
    XX = cvPcaProj(X, Wpca, me);
    [Wfld] = cvLda(XX, C, M); % call myself, now ordinary LDA
    W = Wpca * Wfld;
    %% Fisherface paper [2] looks like below, but it was slow
    % [Wpca] = cvPca(X, N-c);
    % Find scatter matrix Sb, Sw for original X
    % Sb = Wpca.'*Sb*Wpca;
    % Sw = Wpca.'*Sw*Wpca;
    % [Wfld, S] = eig(Sb,Sw);
    % [S,inx] = sort(diag(S),1,'descend');
    % M = min(M, length(inx));
    % Wfld = Wfld(:,inx(1:M));
    % W = Wpca * Wfld;
else
    %% Find class means and scatter matrix
    me = mean(X, 2);
    Sw = zeros(D,D);
    Sb = zeros(D,D);
    for i=1:c
        Xi = X(:, C == ClassLabel(i));
        ni = size(Xi, 2);
        mi = mean(Xi, 2);
        %% Find within-class scatter
        SXi = Xi - repmat(mi, 1, ni);
        Si{i} = SXi * SXi.'; %% [1] (110)
        Sw = Sw + Si{i}; %% [1] (109)
        %% Find between-class scatter
        SMi = mi - me;
        Sb = Sb + ni * SMi * SMi.'; %% [1] (114)
    end
    [W, S] = eig(Sb,Sw);
    [S,inx] = sort(diag(S),1,'descend');
    M = min(M, length(inx));
    W = W(:,inx(1:M));
end
end