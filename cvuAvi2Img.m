function cvuAvi2Img(avifile, outfmt, verbose)
% cvuAvi2Img - (CV Utility) Extract image files from an Avi file
%
% Synopsis
%   cvuAvi2Img(avifile, outfmt)
%
% Inputs ([]s are optional)
%   (string) avifile Filename of a avi file
%   (string) outfmt  Filename format of output image files.
%                    Include one %d (%02d or %03d is allowed.) in the
%                    file name part (not directory name or file extension).
%                    See sprintf.
%                    The file extention is used as the file format.
%   (bool)   [verbose = false]
%                    Print out intemediate states.
%
% Requirements
%   aviread.m and appropriate codecs
%
% Examples
%   cvuAvi2Img('foobar.avi', 'foobar/%03d.jpg');

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
%   04/01/2006  First Edition
if ~exist('verbose', 'var') || isempty(verbose)
        verbose = false;
end;
info = aviinfo(avifile);
if verbose, info, end;
[pathstr, name, ext, versn] = fileparts(outfmt);
if ~exist(pathstr, 'dir'), mkdir(pathstr); end;
for i = 1:info.NumFrames
    % read one by one to save memory usage
    A = aviread(avifile, i);
    outfile = sprintf(outfmt, i);
    if verbose, disp(outfile); end
    imwrite(A.cdata, outfile, ext(2:end));
end