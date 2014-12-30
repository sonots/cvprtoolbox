function [Class, rank] = cvrKnn(protofile, queryfile, K, distFunc)
% cvrKnn - Run Interface of cvKnn
%
% Synopsis
%   [Class] = cvrKnn(protofile, queryfile, [K], [distFunc])
%
% Description
%   Run Interface of cvKnn: K-Nearest Neighbor classification. 
%   The file format of description files are as:
%     <mat filename storing feature vectors> <class label int>
%     ....
%   such as
%     1/001.mat 1
%     1/002.mat 1
%     2/001.mat 2
%     2/002.mat 2
%   Run interface would be used as
%   $ matlab.exe -nosplash -nodesktop -r "cvKnnRun(protofile,queryfile)" >
%   result
%
% Inputs ([]s are optional)
%   (string) protofile
%                     A description file of prototypes. 
%   (string) queryfile
%                     A description file of queries. The class labels
%                     are not necessary. 
%   (scalar) [K = 1]  K-NN's K. Search K nearest neighbors.
%   (func)   [distFunc = @cvEucdist]
%                     A function handle for distance measure. The function
%                     must have two arguments for matrix X and Y. See
%                     cvEucdist.m (Euclidean distance) as a reference.
%
% Outputs ([]s are optional)
%   (vector) Class    1 x N vector containing intergers indicating the
%                     class labels for X. Class(n) is the class id for 
%                     X(:,n). 
%
% See also
%   cvEucdist, cvKnn
%   find, paste (UNIX commands)

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
%   04/01/2005  First Edition
if ~exist('K', 'var') || isempty(K)
    K = 1;
end
if ~exist('distFunc', 'var') || isempty(distFunc)
    distFunc = @cvEucdist;
end

%% Read protofile
proto = cvuCsvread(protofile, ' ');
Proto = []; ProtoClass = [];
for n = 1:length(proto)
    tmp = load(proto{n}{1});
    fields = fieldnames(tmp);
    Proto(:,end+1) = getfield(tmp, fields{1});
    ProtoClass(end+1) = proto{n}{2};
end

%% Read queryfile
query = cvuCsvread(queryfile, ' ');
X = [];
for n = 1:length(query)
    tmp = load(query{n}{1});
    fields = fieldnames(tmp);
    X(:,end+1) = getfield(tmp, fields{1});
end

[Class, rank] = cvKnn(X, Proto, ProtoClass, K, distFunc);