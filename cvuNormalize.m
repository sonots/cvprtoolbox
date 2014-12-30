function X = cvuNormalize(X, range)
% cvuNormalize - (CV Utility) Normalize Array in [low, high]
%
% Synopsis
%   X = cvuNormalize(X. [low high])
%
% Description
%   Normalize Array in [low high]. Would be useful to imshow or imwrite.
%   FYI: imshow(I, [low, high]) does not mean to normalize, but cut off.
%
% Inputs ([]s are optional)
%   (array)  X        Array
%   (vector) [low = 0, high = 1]
%                     Normalization range [low, high]
%
% Outputs ([]s are optional)
%   (array)  X        Normalized array

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
%   04/01/2005  First Edition
if ~exist('range', 'var') || isempty(range)
    range = [0, 1];
end
low = range(1); high = range(2);
nPixel = prod(size(X));
vecx = reshape(X, nPixel, []);
mini = min(vecx);
maxi = max(vecx);
X = X - mini; % min to zero
X = X ./ (maxi-mini); % [0, 1]
X = X .* (high-low); % [0, high-low]
X = X + low; % [low, high]
end