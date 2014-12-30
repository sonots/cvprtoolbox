function O = cvHighboostFilter2(I, msize, A, B)
% cvHighboostFilter2 - Highboost Filter
%
% Synopsis
%   O = cvHighboostFilter2(I, [msize], [A], [B])
%
% Description
%   High boost filter is composed by an all pass filter and a edge
%   detection filter (laplacian filter). 
%   Thus, it emphasizes edges and results in image sharpener.
%
% Inputs ([]s are optional)
%   (matrix) I        N x M x C matrix representing the input image
%   (vector) [msize = [3 3]]
%   (scalar)          A scalar or 1 x 2 vector representing the size of 
%                     mask window.
%   (scalar) [A = 1]  All pass factor weight >= 1
%   (scalar) [B = A]  Division factor. Default is A.
%
% Outputs ([]s are optional)
%    (matrix) O       N x M x C matrix representing the output.
%
% Examples
%   I = cvuImgread('image/lena.png');
%   I = cvAverageFilter2(I, [3, 3]);
%   figure; imshow(uint8(I));
%   O = cvHighboostFilter2(I, [3, 3], 1, 1);
%   figure; imshow(O);
%
% See also
%   edge (edge.m does thining lines too)
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
if ~exist('msize', 'var') || isempty(msize)
    msize = [3 3];
end
if isscalar(msize)
    msize = [msize msize];
end
if ~exist('A', 'var') || isempty(A)
    A = 1;
end
if ~exist('B', 'var') || isempty(B)
    B = A;
end
if ~isa(I, 'double')
    I = double(I);
end

mask = ones(msize(1), msize(2)) * -1;
w = A + (prod(msize) -1);
mask(round(msize(1)/2), round(msize(2)/2)) = w;
mask = mask ./ B;
O = cvConv2(I, mask, 'reflect');
O = uint8(O); % cutoff outsize [0, 255]
end