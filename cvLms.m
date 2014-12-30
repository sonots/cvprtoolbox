function [Class, a] = cvLms(X, Proto, ProtoClass, b)
% cvLms - 2-Class Linear Classifier by LMS method
%
% Synopsis
%   [Class, a] = cvLms(X, Proto, ProtoClass, [b])
%
% Description
%   2-Class Linear Classifier by Least Mean Squared-Error Procedures (LMS)
%
% Inputs ([]s are optional)
%   (matrix) X        D x N matrix representing column classifiee vectors
%                     where D is the number of dimensions and N is the
%                     number of vectors.
%   (matrix) Proto    D x P matrix representing column prototype vectors
%                     where D is the number of dimensions and P is the
%                     number of vectors.
%   (vector) ProtoClass
%                     1 x P vector containing class lables for prototype
%                     vectors.
%   (vector) [b = [n/n1 n/n1 .... n/n2 n/n2 ...]]
%                     1 x P vector containing margin vectors.
%                     The default is [n/n1 n/n1 .... n/n2 n/n2 ...] which
%                     gives solution like Fisher's linear discriminant.
%                     Solution totally depends on choice of b. [1]
%
% Outputs ([]s are optional)
%   (vector) Class    1 x N vector containing intergers indicating the
%                     class labels for X. Class(n) is the class id for
%                     X(:,n).
%   (vector) [a]      (D+1) x 1 vector which is the linear discriminant
%                     weight vector where a = [w0; w] (w is D x 1).
%                     a.'*[1; x] > 0 for class 1 and < 0 for class 2.

% References
%   [1] R. O. Duda, P. E. Hart, and D. G. Stork, "Chapter 5.8.1. Minimum
%   Squared-Error and the Pseudoinverse and Chapter 5.8.4 Widrow-Hoff or
%   LMS Procedure," Pattern Classification, John Wiley & Sons, 2nd ed.,
%   2001.
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
%% Initialization
classLabel = unique(ProtoClass);
nClass = length(classLabel);
if nClass > 2
    error('Must be a 2-class problem.');
end
% Convert into textbook form
[D, P] = size(Proto);
X1 = Proto(:, ProtoClass == classLabel(1));
X2 = Proto(:, ProtoClass == classLabel(2));
n1 = size(X1, 2);
n2 = size(X2, 2);
if ~exist('b', 'var') || isempty(b)
    b  = [ones(1, n1)*P/n1 ones(1, n2)*P/n2];
end
b = b';
Y = [ones(n1,1) X1'; -ones(n2,1) -X2'];
%% Pseudo-Inverse Procedure (expensive)
a = pinv(Y)*b;
%% Solve LMS by Gradient Descent
% a = rand(D+1, 1);
% eta(k), stopIter <- need them
% eta(k) = eta(1)/k

%% Classification
[D, N] = size(X);
Class = a'*[ones(1,N); X];
Class = classLabel((Class < 0) + 1);
end
