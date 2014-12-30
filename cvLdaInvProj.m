function [X] = cvLdaInvProj(Y, W)
% cvLdaInvProj - Inverse LDA Projection
%
% Synopsis
%   [X] = cvLdaInvProj(Y, W)
%
% Description
%   Fisher's Linear Discriminant Analysis (FLDA or LDA) [1] (118)
%
% Inputs ([]s are optional)
%   (matrix) Y        M x N matrix representing the projected data
%   (matrix) W        D x M matrix representing the LDA components (vectors)
%                     where M is the number of components.
%
% Outputs ([]s are optional)
%   (matrix) X        D x N matrix representing feature vectors by columns
%                     where D is the number of dimensions and N is the
%                     number of vectors.
%
% Examples
%   See demo/cvLdaDemo.m
%
% See also
%   cvLda, cvLdaProj

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
X = W * Y;
end