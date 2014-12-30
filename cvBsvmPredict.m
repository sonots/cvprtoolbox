% cvBsvmPredict - A SVM classifier using BSVM [1]
%
% Synopsis
%   [C] = cvBsvmPredict(X, [bsvmpredict], [svmscale], [bsvmpath])
%
% Description
%   A multi-class SVM classifier. 
%   This is a matlab interface for BSVM [1]. 
%
% HOW TO INSTALL
%   bsvm (BSD licence) for windows is ready for you in the
%   cvprtoolbox directory. 
%   >> run '<path to cvprtoolbox>/startup.m';
%
% Inputs ([]s are optional)
%   (matrix) X        D x N matrix representing column classifiee vectors
%                     where D is the number of dimensions and N is the
%                     number of vectors.
%   (string) [bsvmpredict = '']
%                     Option for the BSVM bsvmpredict command.
%   (string) [svmscale = '']
%                     Option for the BSVM svmscale command.
%   (string) [bsvmpath = '']
%                     The path to the BSVM commands. Default searches
%                     The path is searched in the matlab path as defualt. 
%
% Outputs ([]s are optional)
%   (vector) C        1 x N vector cntaining intergers indicating the
%                     class labels for X. C(n) is the class id for 
%                     X(:,n). 
%
% See also
%   cvBsvmTrain, cvLibsvm*, cvLibmsvm*
%
% Requirments
%   BSVM [1], cvBsvmLocate

% References
%   BSVM (download)
%    [1] Chih-Chung Chang and Chih-Jen Lin, BSVM: a library for multi-class
%    support vector machines, 2001, http://www.csie.ntu.edu.tw/~cjlin/bsvm
%   Weston (-s 1)g
%    [2] J. Weston and C. Watkins, Multi-Class Support Vector Machines, 
%    Technical report CSD-TR-98-04, Royal Holloway, 1998 
%   Crammer (-s 2)
%    [3] K. Crammer and Y. Singer, On the algorithmic implementation of 
%    multiclass kernel-based vector machines. Technical report, School of 
%    Computer Science and Engineering, Hebrew University, 2001
%   A comparison
%    [4] C. Hsu and C. Lin, A comparison of methods for multi-class support
%    vector machines, Technical report, Department of Computer Science and
%    Information Engineering, National Taiwan University (2001),
%    http://citeseer.ist.psu.edu/hsu01comparison.html.
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
function C = cvBsvmPredict(X, bsvmpredict, svmscale, bsvmpath)
if ~exist('bsvmpath', 'var') || isempty(bsvmpath)
    bsvmpath = cvBsvmLocate();
end
if ~exist('svmpredict', 'var') || isempty(svmpredict)
    bsvmpredict = '';
end
if ~exist('svmscale', 'var') || isempty(svmscale)
    svmscale = '';
end
bsvmpredictcmd = sprintf('"%s" %s', [bsvmpath, filesep, 'bsvmpredict'], bsvmpredict);
svmscalecmd = sprintf('"%s" %s', [bsvmpath, filesep, 'svmscale'], svmscale);

%% Predict
[D, N] = size(X);
C = zeros(1,N);
cvLibsvmWrite(X, C, 'cvBsvmPredict.txt');
eval(sprintf('!%s cvBsvmPredict.txt > cvBsvmPredict.scl.txt', svmscalecmd));
eval(sprintf('!%s cvBsvmPredict.scl.txt cvBsvmTrain.scl.txt.model cvBsvm.rslt.txt', bsvmpredictcmd));
C = load(sprintf('cvBsvm.rslt.txt'));
C = reshape(C, 1, []);
