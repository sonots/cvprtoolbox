% cvuLs - (CV Utility) List of Files under A Directory
%
% Synopsis
%   [FILES] = cvuLs(path, opt)
%
% Description
%   This function is a simple wrapper of dir() function. 
%   This function returns a cell array of filename strings unlike d = dir() 
%   which returns M-by-1 structures. 
%   This function can return path to filenames. 
%
% Inputs ([]s are optional)
%   (string) path     The path can be a directory or a filename, and can
%                     contain a wildcard expression.  
%   (struct) opt      Options. e.g., struct('type', 'file', 'dot', false)
%                     or a cell {'type', 'file', 'dot', false}.
%   - (enum)   [type = 'all']
%                     'dir' or 'file' or 'all'
%   - (bool)   [fullpath = false]
%                     Return (relative) path to filenames rather than 
%                     only filenames under a directory. 
%   - (bool)   [dot = false]
%                     Show only filenames starting with . 
%   - (string) [ignore = '']
%                     Do not list matching entries. Use regexp.
%
% Outputs ([]s are optional)
%   (cell)   FILES    A cell array of (directory) filename strings

% Uses
%   dir.m
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
%   11/01/2008  First Edition
function FILES = cvuLs(path, opt)
if ~exist('opt', 'var') || isempty(opt), opt = struct(); end;
if iscell(opt), opt = struct(opt{:}); end;
% function FILES = cvuLs(path, varargin)
% opt = struct(varargin{:});
if ~isfield(opt, 'type'),     opt.type = 'all'; end;
if ~isfield(opt, 'fullpath'), opt.fullpath = false; end;
if ~isfield(opt, 'dot'),      opt.dot = false; end;
if ~isfield(opt, 'ignore'),   opt.ignore = ''; end;
if ~exist('path', 'var') || isempty(path), path = '.'; end;

dirs = dir(path);
if strcmp(opt.type, 'dir')
    dirs = dirs(cell2mat({dirs(:).isdir}));
elseif strcmp(opt.type, 'file')
    dirs = dirs(cell2mat({dirs(:).isdir}) == 0);
end
FILES = {dirs(:).name};

TMP = {};
if opt.dot
    for i = 1:length(FILES)
        if regexp(FILES{i}, '^\.')
            TMP{end+1} = FILES{i};
        end
    end
else
    for i = 1:length(FILES)
        if regexp(FILES{i}, '^[^.]')
            TMP{end+1} = FILES{i};
        end
    end
end
FILES = TMP;

if ~isempty(opt.ignore)
    TMP = {};
    for i = 1:length(FILES)
        if isempty(regexp(FILES{i}, opt.ignore, 'once'))
            TMP{end+1} = FILES{i};
        end
    end
    FILES = TMP;
end

if opt.fullpath
    if isdir(path)
        dirname = path;
    else
        dirname = fileparts(path);
    end
    
    for i = 1:length(FILES)
        FILES{i} = fullfile(dirname, FILES{i});
    end
end
end