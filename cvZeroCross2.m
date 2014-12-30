% cvZeroCross2 - 2D Zero Crossing
%
% Synopsis
%   idx = cvZeroCross2(I, thresh, direction)
%
% Description
%   Find zero crossing indices in 2D matrix
%
% Inputs ([]s are optional)
%   (matrix) I        N x M matrix
%   (scalar) [thresh = 0]
%                     The sensitivity threshold of zero-crossing. 
%                     Ignore all edges that are not stronger than thresh. 
%                     The default 0 is the same with considering
%                     all zero-crossings (all changes in sign). 
%   (string) [direction = []]
%                     'horizontal' or 'vertical' or '45' or '135'.
%                     The default detects zero-crossing in all directions 
%                     and merges the result. 
%
% Outputs ([]s are optional)
%   (matrix) idx      N x M matrix where 1 indicates zero crossing points.
%
% Requirements
%   cvConv2 (requires conv2)

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
%   02/01/2007  First Edition
function idx = cvZeroCross2(I, thresh, direction)
if ndims(I) >= 3
    error('The input must be a two dimensional array.');
end
if ~exist('thresh', 'var') || isempty(thresh)
    thresh = 0;
end
if ~exist('direction', 'var') || isempty(direction)
    % all directions
    idx = cvZeroCross2(I, thresh, 'horizontal');
    idx = idx | cvZeroCross2(I, thresh, 'vertical');
    idx = idx | cvZeroCross2(I, thresh, '45');
    idx = idx | cvZeroCross2(I, thresh, '135');
    return;
end

% HOW TO FIND ZERO-CROSSING
% 
% See if there is a change in sign between the two opposite pixels on either
% side of the middle pixel. See in each of four directions. 
% If there is a change the point is set to 1. 
% If when neighbouring points are multiplied and its result is negative,
% then there must be a change in sign between these two points.
% If the change is also above the thereshold then set it as a zero crossing.
% 
% Let x,y be the coordinate in interest. 
% if (I(x-1,y) * I(x+1,y) < 0) { // if sign is different
%     if(abs(I(x-1,y)) + abs(I(x+1,y)) > thresh) {
%         zero crossing in horizontal direction
%     }
% } else if // vertical direction, and so on..
%
% Reference: http://homepages.inf.ed.ac.uk/rbf/HIPR2/zerocdemo.htm
% The above operations can be done smartly using 2D convolution. See codes. 

if strcmp(direction, 'horizontal')
    mask = [0  0  0;
            -1  0  1;
            0  0  0];
elseif strcmp(direction, 'vertical')
    mask = [0  -1  0;
            0  0  0 ;
            0  1  0];
elseif strcmp(direction, '135')
    mask = [-1  0 0;
            0  0 0;
            0  0 1];
elseif strcmp(direction, '45')
    mask = [0  0  1;
            0  0  0;
           -1  0  0];
end

% % next pixel version
% if strcmp(direction, 'horizontal')
%     mask = [0  0  0;
%             0  -1  1;
%             0  0  0];
% elseif strcmp(direction, 'vertical')
%     mask = [0  0  0;
%             0  -1  0 ;
%             0  1  0];
% elseif strcmp(direction, '135')
%     mask = [0  0  0;
%             0  -1 0;
%             0  0  1];
% elseif strcmp(direction, '45')
%     mask = [0  0  1;
%             0  -1  0;
%             0  0  0];
% end

%% check if there is a change in sign
s = sign(I);
t = cvConv2(s, mask, 'reflect');
idx = (abs(t) == 2);
% To consider 0 for changes in sign, use (abs(t) > 0)

%% thresholding
if thresh > 0
    a = cvConv2(I, mask, 'reflect');
    idx = idx & (abs(a) > thresh);
end