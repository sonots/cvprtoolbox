% cvLogSum - Compute log(sum) of log values
%
% Synopsis
%   [logsum] = cvLogSum(A, dim)
%
% Description
%   Compute log(sum) of log values, e.g., 
%   get log(a + b + c) from log(a), log(b), log(c). 
%   Useful to take sum of probabilities from log probabilities. 
%   Useful to avoid loss of precision caused by taking exp. 
%
% Inputs ([]s are optional)
%   (matrix) A        matrix containing log values.
%   (scalar) [dim]    sums along the dimension dim.
%
% Outputs ([]s are optional)
%   (matrix) logsum   log(sum) value. 
%
% Examples
%   >> exp(cvLogSum([log(1) log(2) log(3)]))
%   6

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
%   01/01/2009  First Edition
function logsum = cvLogSum(A, dim)
if ~exist('dim', 'var') || isempty(dim), dim = []; end;
% trick to avoid loss of precision as much as possible
if isvector(A) || isempty(dim)
    maxval = max(A);
else
    maxval = max(A, [], dim); 
end
A = A - repmat(maxval, size(A,1)/size(maxval,1), size(A,2)/size(maxval,2));
logsum = log(sum(exp(A), dim)) + maxval;
end
