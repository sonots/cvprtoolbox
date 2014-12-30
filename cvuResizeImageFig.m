function cvuResizeImageFig(fig, size, fraction)
% cvuResizeImageFig - (CV Utility) Resize image figure
%
% Synopsis
%   cvuResizeImageFig(fig, size, fraction)
%
% Description
%   Resize image figure so that surrounding spaces are removed.
%   This is useful when saving displayed image.
%
% Inputs ([]s are optional)
%   (figure) fig      figure handle object
%   (vector) size     original image size [x, y]
%   (scalar) [fraction = 1.0]
%                     fraction to the original displayed image size.
%
% Outputs ([]s are optional)
%
% Examples
%   fig = figure;
%   I = imread('filename');
%   [M, N] = size(I);
%   imshow(I);
%   cvuResizeImageFig(fig, [M, N], 1);

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
if ~exist('fraction', 'var') || isempty(fraction)
    fraction = 1;
end
pos = get(fig, 'Position');
set(fig, 'Units', 'pixels', 'Position', ...
    [pos(1), pos(2)+pos(4)-fraction*size(1), ...
    fraction*size(2), fraction*size(1)]);
set(gca,'Position', [0 0 1 1], 'Visible', 'off');
