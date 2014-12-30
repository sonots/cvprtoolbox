% cvLibsvmTrain - Train a SVM classifier using LIBSVM [1]
%
% Synopsis
%   cvLibsvmTrain(X, C, [svmtrain], [svmscale], [libsvmpath])
%
% Description
%   Train a 2-class SVM classifier. 
%   This is a matlab interface for LIBSVM [1]. 
%
% HOW TO INSTALL
%   libsvm-2.85 (BSD licence) for windows is ready for you in the
%   cvprtoolbox directory. 
%   >> run '<path to cvprtoolbox>/startup.m';
%
% Inputs ([]s are optional)
%   (matrix) X        D x P matrix representing column prototype vectors
%                     where D is the number of dimensions and P is the
%                     number of vectors.
%   (vector) C        1 x P vector containing class lables for prototype
%                     vectors.
%   (string) [svmtrain = '']
%                     Option for the LIBSVM svmtrain command.
%   (string) [svmscale = '']
%                     Option for the LIBSVM svmscale command.
%   (string) [libsvmpath = '']
%                     The path to the LIBSVM commands. 
%                     The path is searched in the matlab path as defualt. 
%
% Outputs ([]s are optional)
%
% See also
%   cvLibsvmPredict, cvBsvm*, cvLibmsvm*
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
function cvLibsvmTrain(X, C, svmtrain, svmscale, libsvmpath)
if ~exist('libsvmpath', 'var') || isempty(libsvmpath)
    libsvmpath = cvLibsvmLocate();
end
if ~exist('svmtrain', 'var') || isempty(svmtrain)
    svmtrain = '';
end
if ~exist('svmscale', 'var') || isempty(svmscale)
    svmscale = '';
end
svmtraincmd = sprintf('"%s" %s', [libsvmpath, filesep, 'svmtrain'], svmtrain);
svmscalecmd = sprintf('"%s" %s', [libsvmpath, filesep, 'svmscale'], svmscale);

%% Train
cvLibsvmWrite(X, C, 'cvLibsvmTrain.txt');
eval(sprintf('!%s cvLibsvmTrain.txt > cvLibsvmTrain.scl.txt', svmscalecmd));
eval(sprintf('!%s cvLibsvmTrain.scl.txt', svmtraincmd));
