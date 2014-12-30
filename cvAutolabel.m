function ClusterClass = cvAutolabel(ProtoCluster, ProtoClass)
% cvAutolabel - Label classes for clusters
%
% Synopsis
%   [ClusterClass] = cvAutolabel(ProtoCluster, ProtoClass);
%
% Description
%   cvAutolabel labels classes for clusters using majority voting.
%   ClusterClass = argmax (# of classes) in the cluster.
%
% Inputs ([]s are optional)
%   (vector) ProtoCluster
%                     1 x N vector representing integer cluster labels of
%                     prototypes (samles). ProtoCluster(n) is the cluster
%                     label of nth sample. Let the number of clusters be K.
%   (vector) ProtoClass
%                     1 x N vector representing integer cluster labels of
%                     prototypes (samles). ProtoCluster(n) is the class
%                     label of nth sample. Let the number of classes be C.
%
% Outputs ([]s are optional)
%   (vector) ClusterClass
%                     1 x K vector representing integer class labels for
%                     clusters. ClusterClass(k) is the class label
%                     for the kth cluster.
%
% Examples
%   ProtoCluster = [1 1 1 2 2 2 3 3 3];
%   ProtoClass   = [1 1 1 1 2 2 2 2 2];
%   ClusterClass = cvAutolabel(ProtoCluster, ProtoClass)
%   % [1 2 2];
%
% See also
%   cvKmeans

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
%   04/01/2006  First Edition
if length(ProtoCluster) ~= length(ProtoClass)
    error('The # of samples for both ProtoCluster and ProtoClass was not met.');
end
ClusterLabel = unique(ProtoCluster);
K            = length(ClusterLabel);
ClassLabel   = unique(ProtoClass);
C            = length(ClassLabel);
% majority voting
ClusterClass = zeros(1, K);
for k = 1:K
    Idx = find(ProtoCluster == ClusterLabel(k));
    InterClass = ProtoClass(Idx);
    ClassCounter = zeros(1, C);
    for c = 1:C
        ClassCounter(c) = sum(InterClass == ClassLabel(c));
    end
    [maxi major] = max(ClassCounter);
    ClusterClass(k) = ClassLabel(major);
end
