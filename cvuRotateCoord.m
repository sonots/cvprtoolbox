% cvuRotateCoord - (CV Utility) 2-D Rotate Coordninates
%
% Synopsis
%  [Xr Yr] = cvuRotateCoord(X, Y, theta, cx, cy)
%
% Description
%   Rotate 2-D Coordinates
%
% Inputs ([]s are optional)
%   (vector) X        1 x N vector representing x coordinates
%   (vector) Y        1 x N vector representing respective y coord
%   (scalar) theta    rotation angle in radian
%   (scalar) [cx]     rotation center x
%   (scalar) [cy]     rotation center y
% Outputs ([]s are optional)
%   (vector) X        1 x N vector representing x coordinates
%   (vector) Y        1 x N vector representing respective y coord
%
% Examples
%   [a b] = cvuRotateCoord(10,20,pi/2,0,20)
% 6.1232e-016
% 30
%  
%   [X Y] = meshgrid(0:4, 0:4);
%   X = reshape(X, 1, []); Y = reshape(Y, 1, []);
%   [Xr Yr] = cvuRotateCoord(X, Y, pi/4);
%   Xr = round(Xr); Yr = round(Yr);

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
function [X Y] = cvuRotateCoord(X, Y, theta, cx, cy)
if ~exist('cx', 'var') || isempty(cx);
    cx = 0;
end
if ~exist('cy', 'var') || isempty(cy);
    cy = 0;
end
if size(X,1) > size(X,2)
    X = X.';
end
if size(Y,1) > size(Y,2)
    Y = Y.';
end
R = [cos(theta)  -sin(theta) ; sin(theta)  cos(theta)];
X = X - cx;
Y = Y - cy;
Z = R * [X; Y];
X = Z(1,:);
Y = Z(2,:);
X = X + cx;
Y = Y + cy;
end
