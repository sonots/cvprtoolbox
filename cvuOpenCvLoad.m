% cvuOpenCvLoad - (CV Utility) Load data in OpenCV CvFileStorage XML format
%
% Synopsis
%   var = cvuOpenCvLoad(filename, varname)
%
% Description
%
% Inputs ([]s are optional)
%   (string) filename The xml filename to be loaded
%   (string) [varname = []]
%                     The variable name. If not given, the first variable
%                     in the storage is loaded. 
%
% Outputs ([]s are optional)
%   (matrix) var      read matrix variable
%
% See also
%   cvuOpenCvSave, OprnCV's cvLoad

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
%   12/01/2008  First Edition
function var = cvuOpenCvLoad(filename, varname)
[dirname, basename, ext] = fileparts(filename);
if ~strcmp(ext, '.xml')
    error('Currently only xml is supported.');
end
%xml_io_tools
doc = xml_read(filename);
if ~exist('varname', 'var') || isempty(varname)
    names = fieldnames(doc);
    varname = names{1};
end
rows = eval(sprintf('doc.%s.rows', varname));
cols = eval(sprintf('doc.%s.cols', varname));
data = eval(sprintf('str2num(doc.%s.data)', varname));
var = reshape(data, cols, rows).';
end
