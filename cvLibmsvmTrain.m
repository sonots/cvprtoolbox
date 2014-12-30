function cvLibmsvmTrain(X, C, msvm, svmtrain, svmscale, libsvmpath)
% cvLibmsvmTrain - Multi-class extension of LIBSVM [1]
%
% Synopsis
%   cvLibmsvmTrain(X, C, msvm, svmtrain, svmscale, libsvmpath)
%
% Description
%   Multi-class extension of LIBSVM [1]
%
% Inputs ([]s are optional)
%   (matrix) X        D x P matrix representing column prototype vectors
%                     where D is the number of dimensions and P is the
%                     number of vectors.
%   (vector) C        1 x P vector containing class lables for prototype
%                     vectors.
%   (string) [msvm = '1v1']
%                     Algorithm for Multi-class extension.
%            '1v1'    One-against-one [3]
%            '1vr'    One-against-all [5]
%            'dag'    [4]
%                     Now, only 1v1 is supported. 
%                     1v1 achieves the highest performance [1].
%   (string) [svmtrain = '']
%                     Option for the LIBSVM svmtrain command.
%   (string) [svmscale = '']
%                     Option for the LIBSVM svmscale command.
%   (string) [libsvmpath = '']
%                     The path to the LIBSVM commands. Default searches
%                     paths in the matlab path.
%
% Outputs ([]s are optional)

% Requirements
%   LIBSVM[1], cvLibsvmTrain
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
if ~exist('svmtrain', 'var') || isempty(svmtrain)
    svmtrain = '';
end
if ~exist('svmscale', 'var') || isempty(svmscale)
    svmscale = '';
end

if strcmp(msvm, '1v1')
    icvLibmsvm1v1Train(X, C, svmtrain, svmscale, libsvmpath);
elseif strcmp(msvm, '1vr')
    %icvLibmsvm1vrTrain(X, C, svmtrain, svmscale, libsvmpath);    
elseif strcmp(msvm, 'dag')
    %icvLibmsvmDagTrain(X, C, svmtrain, svmscale, libsvmpath);    
end

end
function icvLibmsvm1v1Train(X, C, svmtrain, svmscale, libsvmpath)
ClassLabel = unique(C);
nClass = length(ClassLabel);

save cvLibmsvm1v1Train.txt ClassLabel -ascii;
for k = 1:nClass
    for m = k+1:nClass
        Zk = X(:,C == ClassLabel(k));
        Zm = X(:,C == ClassLabel(m));
        Z = [Zk Zm];
        Zc = [ones(1,size(Zk,2)) ones(1,size(Zm,2))*-1];
        cvLibsvmTrain(Z, Zc, svmtrain, svmscale, libsvmpath);
        movefile('cvLibsvmTrain.txt', sprintf('cvLibmsvm1v1Train%03d%03d.txt', k, m));
        movefile('cvLibsvmTrain.scl.txt', sprintf('cvLibmsvm1v1Train%03d%03d.scl.txt', k, m));
        movefile('cvLibsvmTrain.scl.txt.model', sprintf('cvLibmsvm1v1Train%03d%03d.scl.txt.model', k, m));
    end
end
end
