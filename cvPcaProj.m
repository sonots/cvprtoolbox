function [Y TX Ratio] = cvPcaProj(X, e, m)
% cvPcaProj - Projects feature vectors into given principal space
%
% Synopsis
%   [Y, TX, Ratio] = cvPcaProj(X, e, m)
%
% Description
%   Projects feature vectors into given principal space.
%
% Inputs ([]s are optional)
%   (matrix) X        D x N matrix representing feature vectors by columns
%                     where D is the number of dimensions and N is the
%                     number of vectors.
%   (matrix) e        D x M matrix representing the principal components
%                     (eigenvectors) where M is the number of components.
%   (vector) m        D x 1 vector representing the mean vector of X
%                     vectors.
%
% Outputs ([]s are optional)
%   (matrix) Y        M x N matrix representing the projected data
%   (matrix) [TX]     D x N matrix representing the mean subtracted X
%   (matrix) [Ratio]  M x N matrix representing the composition ratio against
%                     each principal component. Ratio(m,n) gives the ratio
%                     that the data n is composed by principal component m.
%
% Examples
%   See demo/cvPcaDemo.m
%
% See also
%   cvPca, cvPcaInvProj

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
% REFERENCES
%   [1] R. O. Duda, P. E. Hart, and D. G. Stork, "Chapter 3.8.1. Principal
%   Component Analysis," Pattern Classification, John Wiley & Sons, 2nd ed.,
%   2001.
%   [2] Shakhnarovich, B. Moghaddam, Face Recognition in Subspaces, Handbook
%   of Face Recognition, Eds. Stan Z. Li and Anil K. Jain, Springer-Verlag,
%   December 2004, p142-144 (Available online)
%
% Changes
%   05/01/2006  First Edition
[D, N] = size(X);
TX = X - repmat(m, 1, N);
Y = e.' * TX;
if nargout >= 2
    [M, N] = size(Y);
    ap = abs(Y);
    Ratio = ap ./ repmat(sum(ap, 1), M, 1);
end
end