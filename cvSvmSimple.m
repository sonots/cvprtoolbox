function [w, b, a] = cvSvmSimple(Y, c)
% cvSvmSimple - SVM Classifier for linearly separable data
%
% Synopsis
%   [w, b, a] = cvSvmSimple(Y, c)
%
% Description
%   Support Vector Machine classifier for linearly separable data.
%   Just read as a reference together with book [1]
%
% Inputs ([]s are optional)
%   (matrix) Y        D x N matrix containing column training vectors where
%                     D is the number of dimensions and N is the number of
%                     vectors.
%   (vector) c        1 x N vector contains class labels (1 or -1)
%
% Outputs ([]s are optional)
%   (vector) w        D x 1 vector representing the weight vector
%   (scalar) b        The bias. w'*x + b > 0 for class 1, < 0 for class -1
%   (vector) [a]      1 x N vector containing the support vector
%                     coefficients. a(n) ~= 0 implies support vectors.
%
% Examples
%
% See also
%   cvLibsvm*, cvLibmsvm*, cvBsvm*

% References
%   [1] Christopher M. Bishop, "Pattern Recognition and Machine Learning,"
%   Springer, ch 7, 2006
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
%   11/01/2007  First Edition
[D, N] = size(Y);
% Kernel matrix
for i=1:N
    for j=1:N
        K(i,j) = Y(:,i)'*Y(:,j);
    end
end

%%% Solve Maximization
%% Construct matrix and vectors for quadprog function
f = ones(N, 1);
for i=1:N
    for j=1:N
        H(i,j) = c(i)*c(j)*K(i,j);
    end
end
Aeq = c;
beq = 0;
lb = 0;
%% Maximize f'*a - (1/2) a'*H*a
%% => Minimize (1/2) a'*H*a - f'*a
a = quadprog(H,-f,[],[],Aeq,beq,lb);
a = a'; % 1xN
%fprintf('%f ==? %f\n', sum(a), a'*H*a);

%%% Find discriminant function
%% Find w
% w = zeros(D,1);
% for i=1:N
%      w = w + a(i) * c(i) * Y(:,i);
% end
w = sum(repmat(a, D, 1) .* repmat(c, D, 1) .* Y, 2);
margin = 1 / norm(w);

%% Find b
S = find(a ~= 0); % indices for support vectors
% for n=1:S
%      b(n) = c(n) - sum(a(S).*c(S).*K(n,S));
% end
% b = mean(b);
Ns = length(S);
b = mean(c(S)' - sum(repmat(a(S),Ns,1) .* repmat(c(S),Ns,1) .* K(S,S), 2));

end