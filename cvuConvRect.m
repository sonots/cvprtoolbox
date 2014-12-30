% cvuConvRect - (CV Utility) Convert a region of interest (Rect) format
%
% Synopsis
%   [rect, rotate] = cvuConvRect(rect, rotate, from, to);
%
% Inputs ([]s are optional)
%   (vector) rect     [x; y; width; height]
%   (scalar) angle    rotation angle in degree. 
%                     Positive values mean couter-clockwise rotation
%   (string) from     'normal' or 'center'
%   (scalar) to       'normal' or 'center'
%                     'normal' - [x; y; width; height; xy_rotate]
%                     where x, y are upper-left corner coordinates
%                     and xy_rotate is rotation as (x,y) is center
%                     'center' - [cx; cy; width; height; cxy_rotate]
%                     where cx, cy are center coordinates
%                     and cxy_rotate is rotation as (cx,cy) is center
%
% Outputs ([]s are optional)
%   (vector) rect    Converted representation
%   (scalar) angle  
%
% Examples
%   rect = cvuConvRect([10, 10, 5, 5], 45, 'normal', 'center')
%   rect = cvuConvRect(rect, 45, 'center', 'normal')
% rect =
%    12.8284
%    10.0000
%     5.0000
%     5.0000
% rect =
%     10
%     10
%      5
%      5
     
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
function [rect, angle] = cvuConvRect(rect, angle, from, to)
if strcmp(from, 'normal')
    rect = icvCorner2Center(rect, angle);
elseif strcmp(from, 'center')
    rect = icvCenter2Corner(rect, angle);
end
end

function [rect]= icvCorner2Center(rect, angle)
%% [x y width height xy_rotate] where x, y is upper-left corner
tmp = num2cell(rect);
[x y width height] = tmp{:};
theta = -pi/180*angle; % image coord is inverse y direction
%% Convert into [cx cy width height cxy_rotate]
cx = (2*x + width - 1)/2;
cy = (2*y + height - 1)/2;
[cx cy] = cvuRotateCoord(cx, cy, theta, x, y);
rect = [cx; cy; width; height];
end

function [rect] = icvCenter2Corner(rect, angle)
%% [cx; cy; width; height; cxy_rotate]
tmp = num2cell(rect);
[cx cy width height] = tmp{:};
theta = -pi/180*angle; % image coord is inverse y direction
%% Convert into [x y width height cxy_rotate]
x = (2*cx + 1 - width)/2;
y = (2*cy + 1 - height)/2;
[x y] = cvuRotateCoord(x, y, theta, cx, cy);
rect = [x; y; width; height];
end
