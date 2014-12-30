function [X, Class] = cvLibsvmRead(filename)
% cvLibsvmRead - Read a LIBSVM format file and returns matlab matrix data
%
% Synopsis
%   [X, Class] = cvLibsvmRead(filename)
%
% Description
%   cvLibsvmRead reads a LIBSVM [1] data format file and returns
%   a matlab matrix data. 
%   The format of training and testing data file in LIBSVM is as:
%   <label> <index1>:<value1> <index2>:<value2> ...
%    ...
%    ...
%
% Inputs ([]s are optional)
%   (string) filename The filename to be read
%
% Outputs ([]s are optional)
%   (matrix) X        D x N matrix representing feature vectors by columns
%                     where D is the number of dimensions and N is the
%                     number of vectors.
%   (vector) Class    1 x N vector representing class labels
%
% See also
%   cvLibsvmWrite

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
fid = fopen(filename, 'r');
X = []; Class = [];
for n=1:Inf
    tline = fgetl(fid);
    if ~ischar(tline), break, end
    [class,remain]=strtok(tline,' ');
    Class(n) = str2num(class);
    while ~strcmp(remain,'')
        [d,remain]=strtok(remain,':');
        [num,remain]=strtok(remain(2:end),' ');
        X(str2num(d),n) = str2num(num);
    end
end
%      format = ['%g ', repmat('%g:%g ', 1, D)];
%      X = fscanf(fid, format, [2*D+1, Inf]);
%      Class = X(1,:);
%      X = X(3:2:end,:);
fclose(fid);
end