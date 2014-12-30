function cvLibsvmWrite(X, Class, filename)
% cvLibsvmWrite - Write matlab matrix data into a file with LIBSVM format.
%
% Synopsis
%   cvLibsvmWrite(X, Class, filename)
%
% Description
%   cvLibsvmWrite writes matlab matrix data into a file with
%   LIBSVM [1] data format.
%   The format of training and testing data file in LIBSVM is as:
%   <label> <index1>:<value1> <index2>:<value2> ...
%    ...
%    ...
%
% Inputs ([]s are optional)
%   (matrix) X        D x N matrix representing feature vectors by columns
%                     where D is the number of dimensions and N is the
%                     number of vectors.
%   (vector) Class    1 x N vector representing class labels
%   (string) filename The filename to be written
%
% Outputs ([]s are optional)
%
% See also
%   cvLibsvmRead

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
[D, N] = size(X);
fid = fopen(filename, 'w');
for i=1:N
    fprintf(fid, '%d ', Class(i));
    for j=1:D
        fprintf(fid, '%d:%s ', j, num2str(X(j,i)));
    end
    fprintf(fid, '\n');
end
fclose(fid);
end