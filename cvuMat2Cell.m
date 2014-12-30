% cvuMat2Cell - (CV Utility) Conversion of training data representation
%
% Synopsis
%   [X] = cvuMat2Cell(X, C)
%
% Description
%   Convert a matrix type training data representation into a cell type.
%   Cell type: X{i} is a feature matrix of class i, i = 1,...,c.
%   Mat  type: X is a feature matrix for all
%              C is a matrix of class lables with respect to X.
%
% Inputs ([]s are optional)
%   (matrix) X        D x N matrix where D is the number of dimensions and 
%                     N is the number of vectors. 
%   (matrix) C        1 x N matrix containing class labels with respect to
%                     X, i.e., C(i) is the class label for X(:,i).
%
% Outputs ([]s are optional)
%   (cell)   X        c cell matrix of D x Ni matrix
%                     where D is the number of dimensions and Ni is the
%                     number of vectors for each i class.
%                     N = \sum_{i=1}^c Ni.
%
% See also
%   cvuCell2Mat

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
function [Y] = cvuMat2Cell(X, C)
Labels = unique(C);
nClass = length(Labels);
Y = cell(1, nClass);
for c = 1:nClass
    Y{c} = X(:, Labels(c) == C);
end
end
