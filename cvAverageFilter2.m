function O = cvAverageFilter2(I, wsize)
% cvAverageFilter2 - 2D Average filter
%
% Synopsis
%   [GO] = cvAverageFilter2(I, wsize)
%
% Description
%   2D Average filter. This filter reflectly pad outside boundaries
%   although conv2.m pads outside boundaries with 0. 
%   This function supports color image input. 
%
% Inputs ([]s are optional)
%   (matrix) I        N x M x C matrix representing the input image
%   (vector) [wsize = [3 3]]
%   (scalar)          A scalar or 1 x 2 vector representing the size of 
%                     filter window. The number should be odd.
%                     A scalar specifies square window size. 
%
% Outputs ([]s are optional)
%    (matrix) O       N x M x C matrix representing the averaged values.
%                     Do not forget uint8(O) to represent an image. 
%
% Examples
%   I = imread('image/lena.png');
%   O = cvAverageFilter2(I, [5 5]);
%   figure; imshow(I); 
%   figure; imshow(uint8(O));
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
%   10/01/2006  First Edition
if ~exist('wsize', 'var') || isempty(wsize)
    wsize = [3 3];
end
if isscalar(wsize)
    wsize = [wsize wsize];
end
if ~isa(I, 'double')
    I = double(I);
end

%% Own implementation version (like 'same', but no zero padding)
% wysize = floor(wsize(1)/2); wxsize = floor(wsize(2)/2);
% [nRow nCol C] = size(I);
% for x = 1:nCol
%      Wx = (x - wxsize) : (x + wxsize);
%      Wx = Wx(Wx >= 1 & Wx <= nCol);
%      for y = 1:nRow
%          Wy = (y - wysize) : (y + wysize);
%          Wy = Wy(Wy >= 1 & Wy <= nRow);
%          O(y, x, :) = mean(mean(I(Wy, Wx, :)));
%      end
% end

% mask = fspecial('average', wsize);
mask = ones(wsize(1), wsize(2)) ./ prod(wsize);
C = size(I, 3);
for c = 1:C
    O(:,:,c) = cvConv2(I(:,:,c), mask, 'reflect');
end
end