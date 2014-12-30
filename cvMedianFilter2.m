function O = cvMedianFilter2(I, wsize)
% cvMedianFilter2 - 2D Median filter
%
% Synopsis
%   [O] = cvMedianFilter2(I, wsize)
%
% Description
%   2D Median filter. This accepts color image input too.
%
% Inputs ([]s are optional)
%   (matrix) I        N x M x C matrix representing the input image
%   (vector) wsize    A scalar or 1 x 2 vector representing the size of 
%   (scalar)          filter window. The number should be odd.
%                     A scalar specifies square window size. 
%
% Outputs ([]s are optional)
%    (matrix) O      N x M x C matrix representing the output image
%
% See also
%   medfilt2, ordfilt2 (Image Processing Toolbox)
%
% Examples
%   I = imread('image/lena.png');
%   I = imnoise(I,'salt & pepper',0.02);
%   O = uint8(cvMedianFilter2(I, [3 3]));
%   figure; imshow(I); 
%   figure; imshow(O);
%   % Use medfilt2 in practice where almost equivalent codes are as
%   for c = 1:size(I, 3)
%      O(:,:,c) = medfilt2(I(:,:,c), [3 3], 'symmetric');
%   end
%   % Or ordfilte2
%   domain = ones(3, 3);
%   order = ceil(prod(wsize) / 2);
%   for c = 1:size(I, 3)
%      O(:,:,c) = ordfilt2(I(:,:,c), order, domain, 'symmetric');
%   end

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
if isscalar(wsize)
    wysize = floor(wsize/2); wxsize = floor(wsize/2);
else
    wysize = floor(wsize(1)/2); wxsize = floor(wsize(2)/2);
end
if ~isa(I, 'double')
    I = double(I);
end

%% Ignore outside boundary
[nRow, nCol, C] = size(I);
for x = 1:nCol
    Wx = (x - wxsize) : (x + wxsize);
    Wx = Wx(Wx >= 1 & Wx <= nCol);
    for y = 1:nRow
        Wy = (y - wysize) : (y + wysize);
        Wy = Wy(Wy >= 1 & Wy <= nRow);
        O(y, x, :) = median(reshape(I(Wy, Wx, :), length(Wx)*length(Wy), [], C));
    end
end