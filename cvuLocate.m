function [filepath, dir] = cvuLocate(filename)
% cvuLocate - (CV Utility) Search a file path in the matlab path
%
% Synopsis
%   [filepath, dir] = cvuLocate(filename)
%
% Description
%   cvuLocate finds the path of a filename in the matlab path
%   environments. This searches not only .m files, but also any files.
%   If not found, this returns []. 
%
% Inputs ([]s are optional)
%   (string) filename filename to be searched
%
% Outputs ([]s are optional)
%   (string) filepath the found path of the filename. If not found, []
%   (string) dir      the found directory name

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
remain = ['.;', path()];
while true
    [dir, remain] = strtok(remain, ';');
    if isempty(dir)
        filepath = [];
        dir      = [];
        break;
    end
    filepath = [dir, filesep, filename];
    if exist(filepath, 'file')
        break;
    end
end