function X = cvHistnorm(X, range)
% cvHistnorm - Histogram Normalization or Streching
%
% Synopsis
%   X = cvHistnorm(X. [low high])
%
% Description
%   Histogram Normalization. Normalize histogram of an image to [low high]
%
% Inputs ([]s are optional)
%   (array)  X        Image
%   (vector) [low = 0, high = 255]
%                     Normalization range [low, high]
%
% Outputs ([]s are optional)
%   (array)  X        Normalized array
%
% Examples
%   I = imread('image/lena.png');
%   figure;imshow(I);
%   figure;imshow(uint8(cvHistnorm(I, [0, 255])));
%
% See also
%   cvHisteq
%
% Requirement
%   cvuNormalize.m (this is the same thing)

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
%   04/01/2005  First Edition
if ~exist('range', 'var') || isempty(range)
    range = [0, 255];
end
isint = isinteger(X);
if isint, X = double(X); end;
X = cvuNormalize(X, range);
if isint, X = uint8(X); end;
end