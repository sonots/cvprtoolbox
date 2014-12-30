function [X, Y] = cvHarrisCorner(I, wsize, sigma, nCorner)
% cvHarrisCorner - Harris Corner Detector
%
% Synopsis
%   [X Y] = cvHarrisCorner(I, wsize, sigma)
%
% Inputs ([]s are optional)
%   (matrix) I        the grayscale image
%   (vector) [wsize = 5]
%   (scalar)          A scalar or 1 x 2 vector representing the size of 
%                     Gaussian window. The number should be odd.
%                     A scalar specifies square window size. 
%   (scalar) [sigma = 1.0]
%                     The standard deviation of the Gaussian filter
%   (scalar) [nCorner = 200]
%                     The number of good corners to keep. 
%                     Use Inf to keep all.
%
% Outputs ([]s are optional)
%   (vector) X        N x 1 vector containing x coordinates of the corners. 
%                     N is the number of detected corners (max is 200).
%   (vector) Y        N x 1 vector containing y coordinates of the corners.
%
% Requirements
%   fspecial.m (Image Processing toolbox) and conv2. 
%   See help fspecial for fspecial('gaussian', wsize, sigma)

% References
%   [1] "A combined corner and edge detector", C.G. Harris and 
%   M.J. Stephens Proc. Fourth Alvey Vision Conf., Manchester, pp 147-151, 1988.
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
%   05/01/2007  First Edition
if ~exist('wsize', 'var') || isempty(wsize)
    wsize = 5;
end
if isscalar(wsize)
    wxsize = floor(wsize/2); wysize = floor(wsize/2);
else
    wxsize = floor(wsize(1)/2); wysize = floor(wsize(2)/2);
end
if ~exist('sigma', 'var') || isempty(sigma)
    sigma = 1;
end
if ~exist('nCorner', 'var') || isempty(nCorner)
    nCorner = 200;
end
I = double(I);

% Sobel filter to compute horizontal and vertical gradients.
Sobel = [-1 0 1; -2 0 2; -1 0 1] / 3; % or fspecial('sobel')
Ix = conv2(I, Sobel, 'same');
Iy = conv2(I, Sobel.', 'same');

% compute squares and product
% C is [Ix2  Ixy;
%		Ixy  Iy2 ]
Ixy = Ix .* Iy;
Ix2 = Ix.^2;
Iy2 = Iy.^2;
Ixy2 = Ixy .^2;

% Gaussian filter for smoothing
Gaussian = fspecial('gaussian', wsize, sigma);
GIx2 = conv2(Ix2, Gaussian, 'same');
GIy2 = conv2(Iy2, Gaussian, 'same');
GIxy = conv2(Ixy, Gaussian, 'same');

% computer Cornerness with k = 0.04
Cornerness = (GIx2 .* GIy2 - GIxy.*GIxy) - 0.04 * ((GIx2 +GIy2).^2);

% ToDo: Handle pixels around border well.
% Eliminate pixels around the border, 
% since convolution does not produce valid values there
[H, W] = size(Cornerness);
borderx = max(20, ceil(wxsize / 2)); % def of border region
bordery = max(20, ceil(wysize / 2));
mini = min(min(Cornerness));
Cornerness(1:borderx,:) = mini;
Cornerness(H-borderx+1:H,:) = mini;
Cornerness(:,1:bordery) = mini;
Cornerness(:,W-bordery+1:W) = mini;

% find pixels whose Cornerness is bigger than all their neighbours
GoodCorner = imextendedmax(Cornerness, 0.2);
% find indices and Cornerness value for the maxima
GoodCornerIndex = find(GoodCorner);

% Keep best nCorner corners
if nCorner ~= Inf
    GoodCornerValue = Cornerness(GoodCornerIndex);
    [TopGoodCornerValue, TopGoodCornerIndex] = sort(GoodCornerValue, 'descend');
    nGoodCornerValue = min(length(GoodCornerValue), nCorner);
    GoodCornerIndex = GoodCornerIndex(TopGoodCornerIndex(1:nGoodCornerValue));
end

% convert indices to pixel coordinates
Y = rem(GoodCornerIndex, H);		% no zeros since we've excluded borders
X = ceil(GoodCornerIndex / H);