% cvLibsvmPredict - A SVM classifier using LIBSVM [1]
%
% Synopsis
%   [C] = cvLibsvmPredict(X, [svmpredict], [svmscale], [libsvmpath])
%
% Description
%   A 2-class SVM classifier.  
%   This is a matlab interface for LIBSVM [1]. 
%
% HOW TO INSTALL
%   libsvm-2.85 (BSD licence) for windows is ready for you in the
%   cvprtoolbox directory.
%   >> run '<path to cvprtoolbox>/startup.m';
%
% Inputs ([]s are optional)
%   (matrix) X        D x N matrix representing column classifiee vectors
%                     where D is the number of dimensions and N is the
%                     number of vectors.
%   (string) [svmpredict = '']
%                     Option for the LIBSVM svmpredict commnad.
%   (string) [svmscale = '']
%                     Option for the LIBSVM svmscale command.
%   (string) [libsvmpath = '']
%                     The path to the LIBSVM commands. Default searches
%                     paths in the matlab path.  
%
% Outputs ([]s are optional)
%   (vector) C        1 x N vector cntaining intergers indicating the
%                     class labels for X. C(n) is the class id for 
%                     X(:,n). 
%
% See also
%   cvLibsvmTrain, cvBsvm*, cvLibmsvm*
%
% Uses
%   LIBSVM [1], cvLibsvmLocate, cvLibsvmWrite, cvLibsvmRead

% References
%   [1] Chih-Chung Chang and Chih-Jen Lin, LIBSVM: a library for support
%   vector machines, 2001, http://www.csie.ntu.edu.tw/~cjlin/libsvm
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
function [C] = cvLibsvmPredict(X, svmpredict, svmscale, libsvmpath)
if ~exist('libsvmpath', 'var') || isempty(libsvmpath)
    libsvmpath = cvLibsvmLocate();
end
if ~exist('svmscale', 'var') || isempty(svmscale)
    svmscale = '';
end
if ~exist('svmpredict', 'var') || isempty(svmpredict)
    svmpredict = '';
end
svmpredictcmd = sprintf('"%s" %s', [libsvmpath, filesep, 'svmpredict'], svmpredict);
svmscalecmd = sprintf('"%s" %s', [libsvmpath, filesep, 'svmscale'], svmscale);

%% Predict
[D, N] = size(X);
C = zeros(1,N);
cvLibsvmWrite(X, C, 'cvLibsvmPredict.txt');
eval(sprintf('!%s cvLibsvmPredict.txt > cvLibsvmPredict.scl.txt', svmscalecmd));
eval(sprintf('!%s cvLibsvmPredict.scl.txt cvLibsvmTrain.scl.txt.model cvLibsvm.rslt.txt', svmpredictcmd));
C = load(sprintf('cvLibsvm.rslt.txt'));
C = reshape(C, 1, []);
