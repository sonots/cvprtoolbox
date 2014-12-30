% cvLibsvmLocate - Find a path of LIBSVM [1]
%
% Synopsis
%   libsvmpath = cvLibsvmLocate();
%
% Description
%   Find a path of LIBSVM [1]
%
% Inputs ([]s are optional)
%
% Outputs ([]s are optional)
%   (string) libsvmpath
%                     The directory path that BSVM exists
%
% Requirments
%   LIBSVM [1], cvuLocate

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
function libsvmpath = cvLibsvmLocate()
persistent libsvmpath_;
if isempty(libsvmpath_)
    [filepath, libsvmpath_] = cvuLocate('svmtrain.exe');
    if isempty(libsvmpath_)
        [filepath, libsvmpath_] = cvuLocate('svmtrain');
    end
end
if isempty(libsvmpath_)
    error('LIBSVM is not found.');
end
libsvmpath = libsvmpath_;
