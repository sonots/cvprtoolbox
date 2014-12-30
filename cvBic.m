% cvBic - Bayesian Information Criterion
%
% Synopsis
%   bic = cvBic(k, d)
%
% Description
%   Get Bayesian Information Criterion under assumption that
%   residual error is normally distributed.
%   argmin_k bic(k) tells the most efficient k. 
%       bic(k) = N * log(sum(d)/N) + k * log(N);
%
% Inputs ([]s are optional)
%   (scalar) k        The number of parameters in the model
%   (vector) d        1 x N vector containing squared residual errors
%
% Outputs ([]s are optional)
%   (scalar) aic      The Akaike Information Criterion value
%
% See also
%   cvAic, cvKic

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
%   10/05/2008  First Edition
function bic = cvBic(k, d)
N = length(d);
RSS = sum(d); % residual sum of square
bic = N * log(RSS/N) + k * log(N);
%bic = N * log(RSS/N) + k * 2 * sqrt(N);
% log(N) can be anything. Let denote phi(N)
% if lim phi(N)/N = 0 and lim phi(N) = Inf
end
