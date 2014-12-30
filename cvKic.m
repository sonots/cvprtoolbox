% cvKic - Information Criterion for Clustering
%
% Synopsis
%   kic = cvKic(k, D, d)
%
% Description
%   An Information Criterion for Clustering used like
%   Akaike Information Criterion
%        kic(k) = sum(d) + 2*D*k;
%   [2] A rule of thumb is
%    K* = sqrt(N/2) 
%   where N is the number of samples
%
% Inputs ([]s are optional)
%   (scalar) k        The number of parameters in the model
%   (scalar) D        The number of dimension of feature vectors
%   (vector) d        1 x N vector containing squared residual errors
%                     between the model and a feature vector whose 
%                     dimension number is D. 
%
% Outputs ([]s are optional)
%   (scalar) kic      The Information Criterion value
%
% See also
%   cvAic, cvBic
%
% References
%   [1] Christopher D. Manning, Prabhakar Raghavan and Hinrich Schütze,
%   Introduction to Information Retrieval, Cambridge University Press. 2008.
%   http://nlp.stanford.edu/IR-book/html/htmledition/cluster-cardinality-in-k-means-1.html
%   [2] http://en.wikipedia.org/wiki/Data_clustering

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
function kic = cvKic(k, D, d)
RSS = sum(d); % residual sum of square
kic = RSS + 2*D*k;
end