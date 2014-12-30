function [I] = cvuImgread(filename)
% cvuImgread - (CV Utility) Read an image as a grayscale image
%
% Synopsis
%   [I] = cvuImgread(filename)
%
% Description
%   cvuImgread reads an image as a grayscale image. 
%   You can ignore the colortype of the image ('indexed' or 'truecolor')
%   using this function. 
%
% Inputs ([]s are optional)
%   (string) filename The image filename
%
% Outputs ([]s are optional)
%   (matrix) I        The grayscale image
%
% See also
%   imread, ind2gray, rgb2gray (Image Processing Toolbox)

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
info = imfinfo(filename);
[image,map] = imread(filename);
if(strcmp(info.ColorType,'indexed') == 1)
    I = ind2gray(image,map);
elseif(strcmp(info.ColorType,'truecolor') == 1)
    I = rgb2gray(image);
else
    I = image;
end
