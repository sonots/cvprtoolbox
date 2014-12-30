function image = cvuAppendImage(image1, image2)
% cvuAppendImage - (CV Utility) Append two images side-by-side.
%
% Synopsis
%   [image] = cvuAppendImage(image1, image2)
%
% Description
%   Append two images side-by-side.
%
% Inputs ([]s are optional)
%   (matrix) image1   image 1
%   (matrix) image2   image 2
%
% Outputs ([]s are optional)
%   (matrix) image    the generated image

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
% Fill zero to the image with the fewer rows
%    to make it the same height as the other image.
rows1 = size(image1,1);
rows2 = size(image2,1);
if (rows1 < rows2)
    image1(rows2,1) = 0;
else
    image2(rows1,1) = 0;
end
% Now append both images side-by-side.
image = [image1 image2];
