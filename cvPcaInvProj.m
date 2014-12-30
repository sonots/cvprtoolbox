function [X] = cvPcaInvProj(Y, e, m)
% cvPcaInvProj - Inverse PCA Projection
%
% Synopsis
%   [X] = cvPcaInvProj(Y, e, m)
%
% Description
%   Recover feature vectors in a procipal space into an original space.
%
% Inputs ([]s are optional)
%   (matrix) Y        M x N matrix representing the projected data
%   (matrix) e        D x M matrix representing the principal components
%                     (eigenvectors) where M is the number of components.
%   (vector) m        D x 1 vector representing the mean vector of X
%                     vectors.
%
% Outputs ([]s are optional)
%   (matrix) X        D x N matrix representing feature vectors by columns
%                     where D is the number of dimensions and N is the
%                     number of vectors.
%
% Examples
%   See demo/cvPcaDemo.m
%
% See also
%   cvPca, cvPcaProj

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
 [M, N] = size(Y);
 X = e * Y;
 X = X + repmat(m, 1, N);
end