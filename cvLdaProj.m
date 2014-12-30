function [Y Ratio] = cvLdaProj(X, W)
% cvLdaProj - Projects feature vectors into LDA space
%
% Synopsis
%   [Y, Ratio] = cvLdaProj(X, W)
%
% Description
%   Projection into LDA space (sometimes called Fisherface [2] although 
%   this method is not only available for Face recognition)
%
% Inputs ([]s are optional)
%   (matrix) X        D x N matrix representing feature vectors by columns
%                     where D is the number of dimensions and N is the
%                     number of vectors.
%   (matrix) W        D x M matrix representing the LDA components (vectors)
%                     where M is the number of components.
%
% Outputs ([]s are optional)
%   (matrix) Y        M x N matrix representing the projected data
%   (matrix) [Ratio]  M x N matrix representing the composition ratio against
%                     each principal component. Ratio(m,n) gives the ratio
%                     that the data n is composed by the component m. 
% Examples
%   See demo/cvLdaDemo.m
%
% See also
%   cvLda, cvLdaInvProj

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
 Y = W.'*X;
 if nargout >= 2
     [M, N] = size(Y);
     ap = abs(Y);
     Ratio = ap ./ repmat(sum(ap, 1), M, 1);
 end
end