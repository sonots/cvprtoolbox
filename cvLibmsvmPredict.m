function [C] = cvLibmsvmPredict(X, msvm, svmpredict, svmscale, libsvmpath)
% cvLibmsvmPredict - Multi-class extension of LIBSVM [1]
%
% Synopsis
%   [C] = cvLibmsvmPredict(X, msvm, svmpredict, svmscale, libsvmpath)
%
% Description
%   Multi-class extension of LIBSVM [1]
%
% Inputs ([]s are optional)
%   (matrix) X        D x N matrix representing column classifiee vectors
%                     where D is the number of dimensions and N is the
%                     number of vectors.
%   (string) [msvm = '1v1']
%                     Algorithm for Multi-class extension.
%            '1v1'    One-against-one [3]
%            '1vr'    One-against-all [5]
%            'dag'    [4]
%                     Now, only 1v1 is supported. 
%                     1v1 achieves the highest performance [1].
%   (string) [svmpredict = '']
%                     Option for the LIBSVM svmpredict commnad.
%   (string) [svmscale = '']
%                     Option for the LIBSVM svmscale command.
%   (string) [libsvmpath = '']
%                     The path to the LIBSVM commands. Default searches
%                     paths in the matlab path.
%
% Outputs ([]s are optional)
%   (vector) C        1 x N vector containing intergers indicating the
%                     class labels for X. Class(n) is the class id for
%                     X(:,n).

% Requirements
%   LIBSVM[1], cvLibsvmPredict
%
% References
%   LIBSVM (download)
%    [1] Chih-Chung Chang and Chih-Jen Lin, LIBSVM: a library for support
%    vector machines, 2001, http://www.csie.ntu.edu.tw/~cjlin/libsvm
%   A comparison
%    [2] C. Hsu and C. Lin, A comparison of methods for multi-class support
%    vector machines, Technical report, Department of Computer Science and
%    Information Engineering, National Taiwan University (2001),
%    http://citeseer.ist.psu.edu/hsu01comparison.html.
%   One-against-one (1v1) M-SVM
%    [3] U. Kressel, Pairwise classification and support vector machines,
%    in Advances in Kernel Methods - Support Vector Learning (1999).
%   DAGSVM (dag)
%    [4] J. Shawe-Taylor J. Platt, N. Cristianini, Large margin dags for
%    multiclass classi¯cation, in Advances in Neural Information Processing
%    Systems 12 (2000), 547-553.
%   One-against-all or one-versus-rest (1vr) M-SVM
%    [5] V. Vapnik, Statistical learning theory, Wiley, New York, 1998.
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
if ~exist('msvm', 'var') || isempty(msvm)
    msvm = '1v1'; % '1vr', 'dag'
end
if ~exist('libsvmpath', 'var') || isempty(libsvmpath)
    libsvmpath = cvLibsvmLocate();
end
if ~exist('svmpredict', 'var') || isempty(svmpredict)
    svmpredict = '';
end
if ~exist('svmscale', 'var') || isempty(svmscale)
    svmscale = '';
end

if strcmp(msvm, '1v1')
    C = icvLibmsvm1v1Predict(X, svmpredict, svmscale, libsvmpath);
elseif strcmp(msvm, '1vr')
    %C = icvLibmsvm1vrPredict(X, svmpredict, svmscale, libsvmpath);    
elseif strcmp(msvm, 'dag')
    %C = icvLibmsvmDagPredict(X, svmpredict, svmscale, libsvmpath);    
end

end
function C = icvLibmsvm1v1Predict(X, svmpredict, svmscale,libsvmpath)
ClassLabel = load('cvLibmsvm1v1Train.txt');
nClass = length(ClassLabel);

[D, N] = size(X);
classified = zeros(nClass,N);
for k = 1:nClass
    for m = k+1:nClass
        copyfile(sprintf('cvLibmsvm1v1Train%03d%03d.txt', k, m), 'cvLibsvmTrain.txt');
        copyfile(sprintf('cvLibmsvm1v1Train%03d%03d.scl.txt', k, m), 'cvLibsvmTrain.scl.txt');
        copyfile(sprintf('cvLibmsvm1v1Train%03d%03d.scl.txt.model', k, m), 'cvLibsvmTrain.scl.txt.model');
        km_classified = cvLibsvmPredict(X, svmpredict, svmscale, libsvmpath);
        kwins = (km_classified > 0);
        mwins = (kwins == 0);
        classified(k,:) = classified(k,:) + kwins(:)';
        classified(m,:) = classified(m,:) + mwins(:)';
    end
end
[maxi, idx] = max(classified, [], 1);
C = ClassLabel(idx);
end
