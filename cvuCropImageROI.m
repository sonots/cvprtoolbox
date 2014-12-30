% cvuCropImageROI - (CV Utility) Crop rectangle region of interest of image
%
% Synopsis
%   ROI = cvuCropImageROI(I, rect, rotate)
%
% Description
%   Crop rectangle region of interest of image
%
% Inputs ([]s are optional)
%   (matrix) I        nRow x nCol x c matrix representing an image
%   (vector) rect     [x; y; width; height] where
%                     (x,y) are upper-left coord of rectangle
%   (scalar) rotate   rotation angle in degree
%                     rotation center is (x,y)
%                     Positive values mean couter-clockwise rotation
%
% Outputs ([]s are optional)
%   (matrix) ROI      width x height cropped image patch
%                     [] is returned if rectangle region specifies
%                     outside image
%
% Examples
%   ROI = cvuCropImageROI(I, 10, 5, 20, 30, 45)
%
% See also
%   cvuConvROI (format 1)
%
% Requirements
%   cvuRotateCoord

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
%   11/20/2008  First Edition
function ROI = cvuCropImageROI(I, rect, rotate)
[nRow, nCol,c] = size(I);
x = rect(1); y = rect(2);
width = rect(3); height = rect(4);
if ~exist('rotate', 'var') || rotate == 0
    ROI = I(y:y+height-1, x:x+width-1,:);
    return;
end
%cx = round(x+(width-1)/2);
%cy = round(y+(height-1)/2);
[X Y] = meshgrid(x:x+width-1, y:y+height-1);
X = reshape(X, 1, []); Y = reshape(Y, 1, []);
rotate = -pi/180*rotate; % image coord is inverse y direction
[Xr Yr] = cvuRotateCoord(X, Y, rotate, x, y);
Xr = round(Xr); Yr = round(Yr);
if sum(Xr < 1) + sum(Xr > nCol) > 0
    ROI = [];
    return;
end
if sum(Yr < 1) + sum(Yr > nRow) > 0
    ROI = [];
    return;
end
X = X - x + 1; Y = Y - y + 1;
ROI = zeros(height,width,c);
for i = 1:length(X)
    ROI(Y(i),X(i),:) = I(Yr(i),Xr(i),:);
end
end