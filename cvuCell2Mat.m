% cvuCell2Mat - (CV Utility) Conversion of training data representation
%
% Synopsis
%   [X C] = cvuCell2Mat(X)
%
% Description
%   Convert a cell type training data representation into a matrix type.
%   Cell type: X{i} is a feature matrix of class i, i = 1,...,c.
%   Mat  type: X is a feature matrix for all
%              C is a matrix of class lables with respect to X.
%
% Inputs ([]s are optional)
%   (cell)   X        c cell matrix of D x Ni matrix
%                     where D is the number of dimensions and Ni is the
%                     number of vectors for each i class.
%
% Outputs ([]s are optional)
%   (matrix) X        D x N matrix where D is the number of dimensions and 
%                     N is the number of vectors, N = \sum_{i=1}^c Ni.
%   (matrix) C        1 x N matrix containing class labels with respect to
%                     X, i.e., C(i) is the class label for X(:,i).
%
% See also
%    cvuMat2Cell

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
%   01/28/2009  First Edition
function [X C] = cvuCell2Mat(X)
C = []; 
for c = 1:length(X)
    C = cat(2, C, ones(1, size(X{c},2))*c);
end
X = cell2mat(X);
end
