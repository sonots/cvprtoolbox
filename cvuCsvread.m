function [M] = cvuCsvread(filename, delim)
% cvuCsvread - (CV Utility) Read csv file
%
% Synopsis
%   M = cvuCsvread(filename, [delim])
%
% Description
%   matlab built-in csvread.m supports only numeric valued csv files.
%   This function supports strings, too.
%
% Inputs ([]s are optional)
%   (string) filename The filename to be read
%   (string) [delim = ',']
%                     The delimiter. The default is ',' (csv). 
%                     'abc' handles delimeters 'a', 'b', and 'c'. 
%                     Read more strtok.m. 
%
% Outputs ([]s are optional)
%   (cell)   M        Two dimensional cell array. M{n} is for the line n.
%                     M{n}{m} is for the element m at the line n.
%
% Examples
%   file.csv
%   A,10,10.5,10e-5
%   B,10
%   >> M = cvuCsvread('file.csv', ',');
%   M{1}
%     'A' [10] [10.5] [10e-5]
%   M{2}
%     'B' [10]
%
% See also
%   csvread

% Future Work
%   support format such as "a,b",c,d
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
%   08/01/2008  First Edition
if ~exist('delim', 'var') || isempty(delim)
    delim = ',';
end
if ~exist(filename, 'file')
    error([filename, ' does not exist.']);
end
fid = fopen(filename, 'r');
M = {};
for n=1:Inf
    tline = fgetl(fid);
    if ~ischar(tline), break, end
    m = 1;
    while true
        [var, tline] = strtok(tline, delim);
        if strcmp(var,''), break; end
        [num, isnum] = str2num(var);
        if isnum, var = num;, end
        M{n}{m} = var;
        m = m + 1;
    end
end
fclose(fid);
end