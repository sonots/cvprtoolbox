% cvBsvmLocate - Find a path of BSVM [1]
%
% Synopsis
%   bsvmpath = cvBsvmLocate();
%
% Description
%   Find a path of BSVM [1]
%
% Inputs ([]s are optional)
%
% Outputs ([]s are optional)
%   (string) bsvmpath The directory path that BSVM exists
%
% Requirments
%   BSVM [1], cvuLocate

% References
%    [1] Chih-Chung Chang and Chih-Jen Lin, BSVM: a library for multi-class
%    support vector machines, 2001, http://www.csie.ntu.edu.tw/~cjlin/bsvm
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
function bsvmpath = cvBsvmLocate()
persistent bsvmpath_;
if isempty(bsvmpath_)
    [filepath, bsvmpath_] = cvuLocate('bsvmtrain.exe');
    if isempty(bsvmpath_)
        [filepath, bsvmpath_] = cvuLocate('bsvmtrain');
    end
end
if isempty(bsvmpath_)
    error('BSVM is not found.');
end
bsvmpath = bsvmpath_;
